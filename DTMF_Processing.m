function output = Assignment2_DTMF(datafile, sampling_rate)
    %datafile = 'DTMF1.mat';
    %sampling_rate = 16000;

    %Sample period is the time period in seconds considered per pass
    sample_period = 0.12;

    data = importdata(datafile);
    data_column = 1;

    data_size = size(data, 1);
    points_per_sample = sampling_rate * sample_period;

    dtmf_frequencies = [697, 770, 852, 941, 1209, 1336, 1477];
    index_value_map = containers.Map([15, 16, 17, 25, 26, 27, 35, 36, 37, 45, 46, 47], {'1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '0', '#'});

    position = 1;
    number_array = 0;
    peak_number = 0;

    while position < data_size
        %disp(strcat(num2str(position / data_size * 100), '% Complete ...'));
        data_sample_size = points_per_sample;
        if data_size < position + points_per_sample
            data_sample_size = data_size - position;
        end

        normalised_dtmf_frequencies = round(dtmf_frequencies * (points_per_sample / sampling_rate));

        sample_data = data(position:(position + data_sample_size), data_column);
        fft_data = abs(P1_MyFT(sample_data, normalised_dtmf_frequencies));

        number_signature = 0;
        for i = 1:size(dtmf_frequencies, 2)
            if fft_data(normalised_dtmf_frequencies(i)) > 1.65
                number_signature = number_signature * 10 + i;
            end
        end

        if number_signature ~= 0
            number_array(peak_number + 1, end + 1) = number_signature;
        else
            if  number_array(peak_number + 1, end) ~= 0
                peak_number = peak_number + 1;
                number_array(peak_number + 1, 1) = 0;
            end
        end

        position = position + points_per_sample + 1;
    end

    array_mask = and(number_array < 99, number_array > 12);

    number_list = [];
    for i = 1:peak_number
        number_row = number_array(i, 1:end) .* array_mask(i, 1:end);
        number_row(number_row == 0) = [];
        number_list(end + 1) = mode(number_row);
    end

    output = {};
    for i = 1:size(number_list, 2)
        output{end + 1} = index_value_map(number_list(i));
    end

return
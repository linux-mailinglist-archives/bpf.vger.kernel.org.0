Return-Path: <bpf+bounces-40099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D605D97C8DA
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 14:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972252826D1
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAF19DF5F;
	Thu, 19 Sep 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXqjEirr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71819D8A6
	for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747399; cv=none; b=WY/ksKLtVcZ7f2j8c2D04BFchkgq3XAww6DbFwnhNMIQxsaM1bZdl/pOkSl8Jo1YIFfH7KKvwSt7AclFzaoR3b4RoPm0q5atFbCPckqQSu1sLJ8It9C7VkE0yLlV4j/LNGC5VAncDD6qUnROGSe7A4VsT7TsMuvSg2ciLC2Iko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747399; c=relaxed/simple;
	bh=eIx//wuCrZyfUNUPN7Cm1wImck7MiMB15Gs6y1slPOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVc83x5gecqAXtgj8z64xGCg4iMk0WDcMX51GFEk+9LfetF5TNJTxzDNUiPnY+y9P7/Zg1wD1kVtttSWySntqiRqbP6Ibo2VKRVvXWU6DfIO0kEgYwNi5qczFoCsO8Sdca5QX3EWNa0CGCFj9rPB/z6W/7142jzfCPWXfoubAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXqjEirr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa086b077so101442166b.0
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726747395; x=1727352195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cSQdYcDzYdL3jVmSs0YxJDpDpehUGcCD3O0jRMn0TAI=;
        b=mXqjEirrajN97lmlxuC/24Nynnl8uNqUfzE6N1NPN2i2SGs40Mz+EC23amLPqQtGv2
         f+EX5G9ODnNYS4ULmpWTvbPNWDIMlTPfQeCkNFb1/V4dx9Q3a71mXY7EKl3V4sP+GVis
         qwU4rSfRq4dyN7KvT1Hep7a5bjLa50NkyVej0fD/Y3p4CexFCD2cP9s7f4nne0sxd1s+
         pJy1tPv8SuIdOE1wKb4cJmiSuffKlm3JIf2x7XMvoQNjwYM1b2Gl97XjipAT4iq4IBgG
         82moNwm/nB4++u+/T/Gp5XeTIo1WTE4x6usOvsEgk4THpkMa1iyKZNegrYlwFRtDoDxt
         oRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726747395; x=1727352195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSQdYcDzYdL3jVmSs0YxJDpDpehUGcCD3O0jRMn0TAI=;
        b=Gb1yJoWqB4VnXn+CiqsDt4A4GfpJEB6KI9yaoZMKa3qp9mQdQw3y1FkN98At0JnKZI
         lFublj/65rgJjxA9s9yuZnvYKrWrjLqg4efgNBogGol/jhHoFoh/Ja3q3cH9MSTeuNqg
         gy1oysJvimjhMk9IaJV54fUOt+0lrDMZM2MHJECFgkaQnB/9A8arvZDHUmxeVQwhe1n0
         X9+By89Zw/JjmqrOTEBEAaq6VQ3vIdgwsI05HWgu5BFl/hTlnjAA5Qn5X6PqUQAh1Wxd
         UW2ltsCwtu24yBtWeTB2ej9KzqUHQczs32iDY5pOvGK81cs1R2aKrn+/mv9oZQxbNh4e
         kjKw==
X-Forwarded-Encrypted: i=1; AJvYcCUbjHfYE7SOuw+IaCjDiNddDMldrsVKtMM8hN8slXgesqqj9PCvV23ioY1TVvLCRKhxlG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMXOBJXrWBeds0rviyp6SNomZjPQEhzqMk2hQVrb9xK9vm4ATB
	VwojP2DK+s1odAGD0gSbvZgZozR9BpivHQ7Dgnt/D6lKUgDDUEbu
X-Google-Smtp-Source: AGHT+IGpEjVZmRJAv6o2ijwbhyE10oTupIcUYEiv+f4jFeJltjTgJElf191E8HTj5UdzwQig8GP5CA==
X-Received: by 2002:a17:907:3d8d:b0:a7a:af5d:f312 with SMTP id a640c23a62f3a-a9029615820mr2864307766b.46.1726747395067;
        Thu, 19 Sep 2024 05:03:15 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:3:6315:9fa9:de57:9990? ([2620:10d:c092:500::6:f897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f42f1sm709538266b.57.2024.09.19.05.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 05:03:14 -0700 (PDT)
Message-ID: <26fd04ad-364e-40b7-a8de-a3d4ef170a61@gmail.com>
Date: Thu, 19 Sep 2024 13:03:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: emit top frequent code lines
 in veristat
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20240918203925.150231-1-mykyta.yatsenko5@gmail.com>
 <733608c444d491bd3d94d974441c856f7ba64fb1.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <733608c444d491bd3d94d974441c856f7ba64fb1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 03:15, Eduard Zingerman wrote:
> On Wed, 2024-09-18 at 21:39 +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Production BPF programs are increasing in number of instructions and states
>> to the point, where optimising verification process for them is necessary
>> to avoid running into instruction limit. Authors of those BPF programs
>> need to analyze verifier output, for example, collecting the most
>> frequent source code lines to understand which part of the program has
>> the biggest verification cost.
>>
>> This patch introduces `--top-src-lines` flag in veristat.
>> `--top-src-lines=N` makes veristat output N the most popular sorce code
>> lines, parsed from verification log.
>>
>> An example:
>> ```
>> $ sudo ./veristat --log-size=1000000000 --top-src-lines=4  pyperf600.bpf.o
>> Processing 'pyperf600.bpf.o'...
>> Top source lines (on_event):
>>   4697: (pyperf.h:0)	
>>   2334: (pyperf.h:326)	event->stack[i] = *symbol_id;
>>   2334: (pyperf.h:118)	pidData->offsets.String_data);
>>   1176: (pyperf.h:92)	bpf_probe_read_user(&frame->f_back,
>> ...
>> ```
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> I think this is a cool feature!
> It's a bit of a shame that we don't collect information like this in
> the verifier itself, where it would be simpler to do (e.g. associate a
> counter with each instruction, or with each jump target).
Thanks for looking at this patch.
> [...]
>
>> +static int print_top_src_lines(char * const buf, size_t buf_sz, const char *prog_name)
>> +{
>> +	int lines_cap = 1;
>> +	int lines_size = 0;
>> +	char **lines;
>> +	char *line = NULL;
>> +	char *state;
>> +	struct line_cnt *freq = NULL;
>> +	struct line_cnt *cur;
>> +	int unique_lines;
>> +	int err;
> Note:
>    when compiling with clang 20.0.0git the following warning is reported:
>
> veristat.c:957:14: error: variable 'err' is used uninitialized whenever 'for' loop exits because its condition is false [-Werror,-Wsometimes-uninitialized]
>    957 |         for (i = 0; i < min(unique_lines, env.top_src_lines); ++i) {
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> veristat.c:972:9: note: uninitialized use occurs here
>    972 |         return err;
>        |
>    ...
> veristat.c:903:9: note: initialize the variable 'err' to silence this warning
>    903 |         int err;
>        |                ^
>        |                 = 0
yes, I've got a mail from CI regarding this, going to fix in the next 
version.
> Also, a nitpick: declarations should be sorted in a "reverse Christmas
> tree" order (at-least that's what Andrii enforces :).
>
>> +	int i;
>> +
>> +	lines = calloc(lines_cap, sizeof(char *));
> Nitpick: here and in a few places below use sizeof(*<array>), e.g.:
>           calloc(lines_cap, sizeof(*lines))
>
>> +	if (!lines)
>> +		return -ENOMEM;
>> +
>> +	while ((line = strtok_r(line ? NULL : buf, "\n", &state))) {
>> +		if (strncmp(line, "; ", 2))
>> +			continue;
>> +		line += 2;
>> +
>> +		if (lines_size == lines_cap) {
>> +			char **tmp;
>> +
>> +			lines_cap *= 2;
>> +			tmp = realloc(lines, lines_cap * sizeof(char *));
>> +			if (!tmp) {
>> +				err = -ENOMEM;
>> +				goto cleanup;
>> +			}
>> +			lines = tmp;
>> +		}
>> +		lines[lines_size] = line;
>> +		lines_size++;
>> +	}
>> +
>> +	if (!lines_size)
>> +		goto cleanup;
>> +
>> +	qsort(lines, lines_size, sizeof(char *), str_cmp);
>> +
>> +	freq = calloc(lines_size, sizeof(struct line_cnt));
>> +	if (!freq) {
>> +		err = -ENOMEM;
>> +		goto cleanup;
>> +	}
>> +
>> +	cur = freq;
>> +	cur->line = lines[0];
>> +	cur->cnt = 1;
>> +	for (i = 1; i < lines_size; ++i) {
>> +		if (strcmp(lines[i], cur->line)) {
>> +			cur++;
>> +			cur->line = lines[i];
>> +			cur->cnt = 0;
>> +		}
>> +		cur->cnt++;
>> +	}
>> +	unique_lines = cur - freq + 1;
>> +
>> +	qsort(freq, unique_lines, sizeof(struct line_cnt), line_cnt_cmp);
>> +
>> +	printf("Top source lines (%s):\n", prog_name);
>> +	for (i = 0; i < min(unique_lines, env.top_src_lines); ++i) {
>> +		char *src_code;
>> +		char *src_line;
>> +
>> +		src_code = strtok_r(freq[i].line, "@", &state);
> Does verifier guarantee presence of '@' for each source comment line?
It does not, if there is no @ character in the source line, I just print 
a full source line.
`if (src_line)` should check for that.

>> +		src_line = strtok_r(NULL, "\0", &state);
>> +		if (src_line)
> The '.line' string is null-terminated, can 'src_line' ever be NULL?
>
>> +			printf("%5d: (%s)\t%s\n", freq[i].cnt, src_line + 1, src_code);
>> +		else
>> +			printf("%5d: %s\n", freq[i].cnt, src_code);
>> +	}
>> +
>> +cleanup:
>> +	free(freq);
>> +	free(lines);
>> +	return err;
>> +}
>> +
> [...]
>
>



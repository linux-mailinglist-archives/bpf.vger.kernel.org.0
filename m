Return-Path: <bpf+bounces-42679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963329A9150
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E63FAB22AB5
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C901FDFB8;
	Mon, 21 Oct 2024 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLTXrNpm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D751FDF85
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542870; cv=none; b=rR5LGcru87vdBe/ylgWDHG4YtrmwApyTHpiVvSylWXIVpwrBpipb1gJmIogq2EBapEthDGzothmCtg+WoU23behD8EFc/i0cEoJL75Atf2sO995zBLxRNccDMpmPv7kYbwW2yee/cdIBtnS3/dyQ/392arCMZlPITX+hlvTj7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542870; c=relaxed/simple;
	bh=OtqLIM4aegKGbE5zl7Et4u5eP4EQx6qs0A2eQsr2yNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIGFHn+k7KD2MSPFjyzb3nNcRkOPPmtBG1+QjR2BntNNOFDktIR2LqNVusmO4tpfad0JBCxvqx3bpYRASnKEM0LvWxHl0O07BHl3kvYqzdee8fRni7lY9PqxD1QdlosMQc170FufnecqZBNYLIM3AxefXITFPlA67bZNjmHfOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLTXrNpm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so68937771fa.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729542867; x=1730147667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5FvU+nHejVv77RMSgWwqIwpCO/Bu/j3tNQF+nECe4N0=;
        b=hLTXrNpms3IWUIe7EGxt7jNOVIfw2gq8XAHfcZ4S7UzUvZlAVvwMiJnjc2p6qsUpNL
         xwcjbKXtNuJQI/2mthBMP50rfZQcgdRU2O80KLWalBFEW8vwmX2DsGE7rzALhArGY0fV
         HYXQwvapIofFvlngto4BEJ6LWJqoT8ru73Yh4r//8gKwliy38wIvZZcUb4338mQWA5II
         AV2uv29E7eYT6ftXhvw6Di5un0oH7Hh9dagR1FVbZx889eumnA29bfHGNYFLH22A+wqn
         rzzDmif2MW8EpzpHpitKjlH+aR72fcCiyqaTN0W+UYIWGiuprAi/Kzsfk/do9xaJCm4N
         sedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729542867; x=1730147667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FvU+nHejVv77RMSgWwqIwpCO/Bu/j3tNQF+nECe4N0=;
        b=kKHbaHgocbM4k5j9ako9Tel06eBBLV33g3ttY4aNc3g/+6PIZLrgXahHTi3Ahx9yCU
         thcb3+QwXPAwdqPBJdmGcty4xtZNkO7Zmf1qJElYD1PWvopXU8RFK37q0BKnmfOnGc74
         sGUqU2qpinZfzq1aBvdRNEaNAt8hdxQfzrFrydj1GBpbf+Rrq+AlaNlGJXdRVlGIUVWo
         AN6b6BwTsGskPL5U5e9auUSNYlkX1xrNd97BjAywO/E/OBQruxqdjtlWBGeeWUNpppuP
         7Xl2NoPSdX38YP+wkmB33Ib0TCwt4FyWesIOQ0MQpH47QEFzdBEdXg/vz2E5XHkBKoCX
         0HTg==
X-Gm-Message-State: AOJu0YxdILmA9IxLCB1jR57t+DM8xOGjvWy248VrzXEoH/NNWmTA9cLY
	P5z8mqC5sGl23KemEtJ75wjMBthrRoESaFXKVCLVUyKD+gfzssD/
X-Google-Smtp-Source: AGHT+IHRJtMJh0rSWNeU1W56jeXcrLTc08MOSvFTh2DwvZ+Fk0ZzO8/emHIZDF7YcZGbiMhY+byEcw==
X-Received: by 2002:a05:651c:502:b0:2fb:8c9a:fe3f with SMTP id 38308e7fff4ca-2fb8c9b23bemr63771001fa.22.1729542866135;
        Mon, 21 Oct 2024 13:34:26 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a302:ae00:2a0:8923:a788:9a73? ([2a02:8109:a302:ae00:2a0:8923:a788:9a73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9155c380sm251091666b.99.2024.10.21.13.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:34:25 -0700 (PDT)
Message-ID: <04056da1-a477-4dce-8466-04eef9428384@gmail.com>
Date: Mon, 21 Oct 2024 21:34:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: increase verifier log limit in
 veristat
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20241021141616.95160-1-mykyta.yatsenko5@gmail.com>
 <ZxaE_C_Im9-I8OSa@krava>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <ZxaE_C_Im9-I8OSa@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2024 17:44, Jiri Olsa wrote:
> On Mon, Oct 21, 2024 at 03:16:16PM +0100, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> The current default buffer size of 16MB allocated by veristat is no
>> longer sufficient to hold the verifier logs of some production BPF
>> programs. To address this issue, we need to increase the verifier log
>> limit.
>> Commit 7a9f5c65abcc ("bpf: increase verifier log limit") has already
>> increased the supported buffer size by the kernel, but veristat users
>> need to explicitly pass a log size argument to use the bigger log.
>>
>> This patch adds a function to detect the maximum verifier log size
>> supported by the kernel and uses that by default in veristat.
>> This ensures that veristat can handle larger verifier logs without
>> requiring users to manually specify the log size.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/testing/selftests/bpf/veristat.c | 40 +++++++++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
>> index c8efd44590d9..1d0708839f4b 100644
>> --- a/tools/testing/selftests/bpf/veristat.c
>> +++ b/tools/testing/selftests/bpf/veristat.c
>> @@ -16,10 +16,12 @@
>>   #include <sys/stat.h>
>>   #include <bpf/libbpf.h>
>>   #include <bpf/btf.h>
>> +#include <bpf/bpf.h>
>>   #include <libelf.h>
>>   #include <gelf.h>
>>   #include <float.h>
>>   #include <math.h>
>> +#include <linux/filter.h>
>>   
>>   #ifndef ARRAY_SIZE
>>   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>> @@ -1109,6 +1111,42 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
>>   	return;
>>   }
>>   
>> +static int max_verifier_log_size(void)
>> +{
>> +	const int big_log_size = UINT_MAX >> 2;
>> +	const int small_log_size = UINT_MAX >> 8;
>> +	struct bpf_insn insns[] = {
>> +		BPF_MOV64_IMM(BPF_REG_0, 0),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	int ret, insn_cnt = ARRAY_SIZE(insns);
>> +	char *log_buf;
>> +	static int log_size;
>> +
>> +	if (log_size != 0)
>> +		return log_size;
>> +
>> +	log_size = small_log_size;
>> +	log_buf = malloc(big_log_size);
> IIUC this would try to use 1GB by default? seems to agresive.. could we perhaps
> do that gradually and double the size on each failed load attempt?
>
> jirka
Yes, this allocates 1GB by default, I expect this is not a big of a 
problem if verifier
does not touch all that memory.
I tried doing gradual allocation initially, but that requires more 
significant rework
of the code.
Thanks for looking into this patch!
>
>> +
>> +	if (!log_buf)
>> +		return log_size;
>> +
>> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
>> +		    .log_buf = log_buf,
>> +		    .log_size = big_log_size,
>> +		    .log_level = 2
>> +	);
>> +	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
>> +	free(log_buf);
>> +
>> +	if (ret > 0) {
>> +		log_size = big_log_size;
>> +		close(ret);
>> +	}
>> +	return log_size;
>> +}
>> +
>>   static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
>>   {
>>   	const char *base_filename = basename(strdupa(filename));
>> @@ -1132,7 +1170,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>>   	memset(stats, 0, sizeof(*stats));
>>   
>>   	if (env.verbose || env.top_src_lines > 0) {
>> -		buf_sz = env.log_size ? env.log_size : 16 * 1024 * 1024;
>> +		buf_sz = env.log_size ? env.log_size : max_verifier_log_size();
>>   		buf = malloc(buf_sz);
>>   		if (!buf)
>>   			return -ENOMEM;
>> -- 
>> 2.47.0
>>
>>



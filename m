Return-Path: <bpf+bounces-49807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D382FA1C3DB
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 15:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850DC1888213
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3879B35974;
	Sat, 25 Jan 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVcamvr8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539028E37;
	Sat, 25 Jan 2025 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737816903; cv=none; b=ZW85RZb1k6vIqmO/ckJdDyBQBrWrvZ7zotv/HBOai4U17h5VTwrJqNQPMfaaHFuGnkOJRDwbzetCyEZ3b4uv/V4XPR34dtJbF0TtjDSqgSCpsCyr9YJEVReweaosvqOPTpYYMSKj3YHTMDkm5TsGchWRn0bN9Ga4UD/ea262YxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737816903; c=relaxed/simple;
	bh=KPtMJdD1a2W/aSOQStDb+rBv4BhAZIkWh5x6n5p0KgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqxL79ujRahj1g3ligNA921jto84oqUYf8gOalqMXr3fZaXKehgSvU65I3YQSdPuwsQVmIDYy9EWtI7fZjOiPPmIORuaszHrkOh+bEgB/eM0ynHyqygMH2Vw9k4UaE7ZO1lGfDJs0cbODihFpfpeZIBKxodVz+B/FdUiRjxtjmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVcamvr8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so4185324a91.3;
        Sat, 25 Jan 2025 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737816901; x=1738421701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoosp+Yz0y0vvt+DPNKaBS3j2VXPcPHcSQMWdxvkOhE=;
        b=iVcamvr8O/qSpIMIefKH7VUTyCfRixKVBvpdE24j6WqFGDxqy627C4+x8kMQQMfQYb
         Dszu22lxEGzWEMyVPDlsnQaV9etLjhf7QrAGfGTWzaJW+64ErFt/5TwP01KleU81TJbM
         6XEkDeWz7m11mPr11MrwmcGtXSY0JLffcBWpNHBrPmZyLovvNnJroJBLnqRTYH1Hi5qC
         rYo7dV599w5HG0y3t7w6Nbj/o1tYrmBO8CZqXpfcIRNg3QgRwqhXBFMDRB+ZQtW89MER
         GbE/m+eVWlOnvHMu/+x7QitFmetl44xDwBeEpi1t0TLpyCWn7fiai9voAZYhTSvx1cYz
         UN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737816901; x=1738421701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uoosp+Yz0y0vvt+DPNKaBS3j2VXPcPHcSQMWdxvkOhE=;
        b=RnN1neDqXp1pk29lKdA4tvZLYq8ttBQE7odNpEeToLhT9xWS4nFd0Hf/LOgImw62eP
         ii9jZMxAh6OayMjw6CZjUn3V1XyfpuDDz6SVjh0dn1IfduqOHkWY1PpqqHNDlkEr01q2
         RX+EkyTnPMmC6ml+RL0XjcY5U7JARKw/EVk4kcrqnUS/ppbOYT1kUXiZTa91Up7nTwXO
         JoomgyNAio3wufqO8GRtQUPXcBYLt1ap/05A3nOeelHXMZpGqkHqhonvF2jfHVWBZhk9
         /SiB27pZbFHiX5uLmZAqBHFylWJ5pIV4xSIOHq0O+lmFhV/CyAcGLZ1ExFhCJFwYlJaf
         HqBA==
X-Forwarded-Encrypted: i=1; AJvYcCXID0ccm/fB+ygPcWfPQSsnqYJVqH++HiSxjS8NWlmgSrShyxl/LfIbD9OfJGyIAKu8mlM=@vger.kernel.org, AJvYcCXYeyeDkZw7gnBsxpdkl6s9eBFV1/66CuT4DvOUv+MLghg1RERVqAuZ4tnK1V4SqtM6EMVuyAVp3XVJUU9s@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHfuIySxtLNFzgczqM/uBSS10nfQv/KTctl4l9aMN166ywt2/
	f3nVdoPx/nmCeGi499ypOxWSNPIWIqzQDsKs9byoIIaeP0Rruvin
X-Gm-Gg: ASbGncv0X4ujo/mRpRXRyQVfg20E7o8dUpIlS64PuR25WeXuk2FtmW7WEtuKoOYA0ay
	0DJFfdpHh9LIOnj5RvtksUGvyE4yMYIG/761iAZKMp+6FTOcXGH+5qLf/LFWcN9qMP/puDt32j7
	o+a9Qe2ZIK4KvLWBMdKkhyFGHaVN5bYICePTk2B545YSQkei7fH/p2ySqrhUshKGn1geAmyYr1m
	ukI5YDh3MtOLjF9kj/9ABQAxkEDLkSCsiaAzCT7JToZwuXIRbhwAZL7HY8+nM7TW7fCxFlOsLQi
	uw==
X-Google-Smtp-Source: AGHT+IGAldQ/TgZPPsEy7K2gmO1YS2pbiW7rdAlgUnjxUTdsCjUiZR7DXOO6csI49aD44HeAwooUyg==
X-Received: by 2002:a17:90b:1f88:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-2f782d5d838mr48732313a91.30.1737816901290;
        Sat, 25 Jan 2025 06:55:01 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa56147sm3712201a91.15.2025.01.25.06.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 06:55:00 -0800 (PST)
Message-ID: <50f55e32-06b9-4ec6-8771-14459d0a4cda@gmail.com>
Date: Sat, 25 Jan 2025 22:54:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: Add libbpf_probe_bpf_kfunc API
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250124144411.13468-1-chen.dylane@gmail.com>
 <20250124144411.13468-3-chen.dylane@gmail.com> <Z5O_YCV6Lnqymy-V@krava>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <Z5O_YCV6Lnqymy-V@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/25 00:27, Jiri Olsa 写道:
> On Fri, Jan 24, 2025 at 10:44:10PM +0800, Tao Chen wrote:
>> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
>> used to test the availability of the different eBPF kfuncs on the
>> current system.
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.h        | 17 ++++++++++++++++-
>>   tools/lib/bpf/libbpf.map      |  1 +
>>   tools/lib/bpf/libbpf_probes.c | 30 ++++++++++++++++++++++++++++++
>>   3 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 3020ee45303a..035829e22099 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1680,7 +1680,22 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
>>    */
>>   LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>>   				       enum bpf_func_id helper_id, const void *opts);
>> -
>> +/**
>> + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
>> + * use of a given BPF kfunc from specified BPF program type.
>> + * @param prog_type BPF program type used to check the support of BPF kfunc
>> + * @param kfunc_id The btf ID of BPF kfunc to check support for
>> + * @param btf_fd The module BTF FD, 0 for vmlinux
>> + * @param opts reserved for future extensibility, should be NULL
>> + * @return 1, if given combination of program type and kfunc is supported; 0,
>> + * if the combination is not supported; negative error code if feature
>> + * detection for provided input arguments failed or can't be performed
>> + *
>> + * Make sure the process has required set of CAP_* permissions (or runs as
>> + * root) when performing feature checking.
>> + */
>> +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
>> +				      int kfunc_id, __s16 btf_fd, const void *opts);
>>   /**
>>    * @brief **libbpf_num_possible_cpus()** is a helper function to get the
>>    * number of possible CPUs that the host kernel supports and expects.
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index a8b2936a1646..e93fae101efd 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
>>   		bpf_linker__add_buf;
>>   		bpf_linker__add_fd;
>>   		bpf_linker__new_fd;
>> +		libbpf_probe_bpf_kfunc;
>>   } LIBBPF_1.5.0;
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index b73345977b4e..cd7d16c1cc49 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -446,6 +446,36 @@ static int probe_func_comm(enum bpf_prog_type prog_type, struct bpf_insn insn,
>>   	return 0;
>>   }
>>   
>> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
>> +			   __s16 btf_fd, const void *opts)
>> +{
>> +	struct bpf_insn insn;
>> +	int err;
>> +	char buf[4096];
>> +
>> +	if (opts)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	insn.code = BPF_JMP | BPF_CALL;
>> +	insn.src_reg = BPF_PSEUDO_KFUNC_CALL;
>> +	insn.imm = kfunc_id;
>> +	insn.off = btf_fd;
> 
> nit, you could use
> 
>          struct bpf_insn insns[] = {
>          	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, off, imm),
>                  BPF_EXIT_INSN(),
>          };
> 
> jirka
> 

Yeah, it looks more concise, i will send it in v4. Thanks.

>> +
>> +	err = probe_func_comm(prog_type, insn, buf, sizeof(buf));
>> +	if (err)
>> +		return err;
>> +
>> +	/* If BPF verifier recognizes BPF kfunc but it's not supported for
>> +	 * given BPF program type, it will emit "calling kernel function
>> +	 * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
>> +	 * it will emit "kernel btf_id 4294967295 is not a function".
>> +	 */
>> +	if (err == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function")))
>> +		return 0;
>> +
>> +	return 1; /* assume supported */
>> +}
>> +
>>   int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>>   			    const void *opts)
>>   {
>> -- 
>> 2.43.0
>>


-- 
Best Regards
Dylane Chen


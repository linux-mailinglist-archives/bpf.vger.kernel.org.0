Return-Path: <bpf+bounces-50882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA3A2DB69
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 07:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A8B1887EE1
	for <lists+bpf@lfdr.de>; Sun,  9 Feb 2025 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB213B2A4;
	Sun,  9 Feb 2025 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8ODhktu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF414C9F;
	Sun,  9 Feb 2025 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739084224; cv=none; b=lGeS25Zk4y2h+BqeF5TEIH6zWR0JsnPe14Y8ITVOJIYeqWsc0qZhuNsRkSFGzFoZjT1/njO0Va5uDOUBI3iv8VCjfx87m0HvNTvPXbUwe2yABFvKGJAD2FIZrYIeFffP/fcHSy/o6tRKEZdOLwF1brpd4tjG1e+SVJiNf7Wqb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739084224; c=relaxed/simple;
	bh=6anvUkPCt9HB8KIVY17EvBLeWZESbfJt/eW2fImR5hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVW/D7369OpBRc/yJlGY5nzaDiz1679Rm/ghO66fgk/LmSW/Oh1/WgXPquQ+E4KEIRcYhb9VvZdjvvHGvUTSQfVVgjy0Kf5/qSibrYon8aPAPwbFR3AbIcIFuoobG+E4UydTlNyXpbZYgJ5ALKbrzQ/uzyURMAQEjLe492OoUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8ODhktu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9f5caa37cso6082198a91.0;
        Sat, 08 Feb 2025 22:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739084222; x=1739689022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaEFyV6jsKy6DHNIAt1vfm05AFFfBayBvXZDZquYLJU=;
        b=e8ODhktunLXXnjB65Li6HCF86TiXm0Jqg3r+Udy28p/GPZujoSvn2j4gpm3ovy3CiW
         yi0JvFw8pA937aKfJJXPJXygAl1I8amOROgUjD9qVc5VznK48d0F7NuVR4sK9ipIPydv
         UeEcaCEqY0ULDobINiUpSkk1BE4ep43aL7U6KsI9MRwAV6kLpZsCDcE0sk5T8QZJ2yhX
         OLjE0/f4cX0j0Z2ZAp+VnNaULGQfs9xhdCZdD90a8wfj3D1yy7HU3VeVUqpb1DKqZzIM
         KHLjkVY1ZRCwWpAHM0HUrGRGoQNxXB0A6uxLJgVkHuWDBnwNAjABYkq89R4MDc/ZT57q
         pu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739084222; x=1739689022;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RaEFyV6jsKy6DHNIAt1vfm05AFFfBayBvXZDZquYLJU=;
        b=at58UBTYe6jYKNm2HnMuhAUlKrTomzZkmw6AlGsFdFzzmI41CKfevKJI45ToTq+Ixt
         BM5LhS7+j8XHfEWn6KI2e57yNltmouZC+L+2Etm9jboHBPhGRhqUUCxh6KbQJI3Qy7GZ
         NjqpeU15F7Oc88mN/pTwkhzGgJtj/5+Y9c0XNVnxdFjAG2v7pin1zrBWiublsQShlz7O
         1eO4Zvxzb5H9kNTV/BFuB93XxcsFctHFvxmoerKrR5kVhyy4BPPQxzhxLlI1k+HnQD8V
         hbSUV/Iw6sRdPAOMxUhToCbhaLtYNM9TzWMv+8yH/PxpPraNlwIcbPVQJbatPLQN5402
         4VWg==
X-Forwarded-Encrypted: i=1; AJvYcCXrYLPyeFqUhL7PsmdKVWNk8yx8njxisBsfe4Mkd5tcntUhYLmVkdHKHIeN+tNiQ48HYm0WONt5+ywmNws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyic0XhOB9PQMdkWXyUwJ2tvEWKrqb+L623kyrUfjFc7H5ZKQBK
	D+xU7+jNj2FIdAy0E1J4Lo06QxDv59FitWbzAgNiyQaV5L0LhvCl
X-Gm-Gg: ASbGncscMQ5kLrZlOrqzHMwx3o6infGYrcxk6WIvX1sgN6IwmAy2NjZvMH90A2J2Lfk
	TeSVOM966RINHYLKybktbGT1dom3E7C0IMBJgBMrpD3THmfeQOl8IS6m7hdZQ8WKyAvn3tYkGiF
	6c8Avr2dYkW0tDfyEF6kXUYqBlnGIebp0RlbccI05dqh/u3YryM1U0k3ZdlwVGokB1kHFX7sCi6
	sBUQURLCq+W4EaJwjD9sqoSHglTFufoXtaR2T+WPYSkBFOxOXCMGXLAh49BNredUjt4P7le9Had
	Rv6LdYdUP4Kv
X-Google-Smtp-Source: AGHT+IEMUq4+ARTOuwu9CwO9JHr7t1SXU81aoeasd0P7K8XV60JUUzxr4T/Haxy8f3zvmtLeJ0I7kw==
X-Received: by 2002:a05:6a00:22cd:b0:725:41c4:dbc7 with SMTP id d2e1a72fcca58-7305e3e0aefmr14175560b3a.4.1739084222215;
        Sat, 08 Feb 2025 22:57:02 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16841sm5497230b3a.146.2025.02.08.22.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 22:57:01 -0800 (PST)
Message-ID: <f410202f-803c-45b1-b573-a8e6453cd0dc@gmail.com>
Date: Sun, 9 Feb 2025 14:56:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, haoluo@google.com,
 jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206051557.27913-1-chen.dylane@gmail.com>
 <20250206051557.27913-4-chen.dylane@gmail.com>
 <7d667c037e7396fb88cf243162c5aa8a537858bb.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <7d667c037e7396fb88cf243162c5aa8a537858bb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/8 06:35, Eduard Zingerman 写道:
> On Thu, 2025-02-06 at 13:15 +0800, Tao Chen wrote:
> 
> [...]
> 
>>   LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>>   				       enum bpf_func_id helper_id, const void *opts);
>> -
>> +/**
>> + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
>> + * use of a given BPF kfunc from specified BPF program type.
>> + * @param prog_type BPF program type used to check the support of BPF kfunc
>> + * @param kfunc_id The btf ID of BPF kfunc to check support for
>> + * @param btf_fd The module BTF FD, if kfunc is defined in kernel module,
>> + * btf_fd is used to point to module's BTF, 0 means kfunc defined in vmlinux.
> 
> Regarding '0' as special value:
> in general FD is considered invalid only if it's negative, 0 is a valid FD.
> Andrii, I remember there was a lengthy discussion about FD==0 and BPF,
> but I don't remember the conclusion.
> 

Hi Eduard,
As you said, so what about "-1 means kfunc defined in vmlinux", -1 just 
used to distinguish whether it is vmlinux，then processing in 
libbpf_probe_bpf_kfunc like:

offset = 0;
// vmlinux btf offset default is 0
insn.off = offset;
if (btf_fd >= 0) {
	offset = 1;
	insn.off = offset;
	fd_array[offset] = btf_fd;
}
What do you think?

>> + * @param opts reserved for future extensibility, should be NULL
>> + * @return 1, if given combination of program type and kfunc is supported; 0,
>> + * if the combination is not supported; negative error code if feature
>> + * detection for provided input arguments failed or can't be performed
>> + *
>> + * Make sure the process has required set of CAP_* permissions (or runs as
>> + * root) when performing feature checking.
>> + */
>> +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
>> +				      int kfunc_id, int btf_fd, const void *opts);
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
> 
> This is now in conflict with bpf-next.
> 
>>   } LIBBPF_1.5.0;
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index e142130cb83c..c7f2b2dfbcf1 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -433,6 +433,61 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
>>   	return true;
>>   }
>>   
>> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, int btf_fd,
>> +			   const void *opts)
>> +{
>> +	struct bpf_insn insns[] = {
>> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, btf_fd, kfunc_id),
>> +		BPF_EXIT_INSN(),
>> +	};
>> +	const size_t insn_cnt = ARRAY_SIZE(insns);
>> +	char buf[4096];
>> +	int *fd_array = NULL;
>> +	size_t fd_array_cnt = 0, fd_array_cap = fd_array_cnt;
>> +	int ret;
>> +
>> +	if (opts)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	if (!can_probe_prog_type(prog_type))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (btf_fd) {
>> +		ret = libbpf_ensure_mem((void **)&fd_array, &fd_array_cap,
>> +					sizeof(int), fd_array_cnt + btf_fd);
> 
> Please take a look at the tools/testing/selftests/bpf/prog_tests/fd_array.c,
> e.g. test case check_fd_array_cnt__fd_array_ok(). The offset field of the
> call instruction does not have to be an fd (as it only has 16 bits),
> instead it's an offset inside the fd_array.
> Here it would be sufficient to allocate a small array on stack.
> 
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* In kernel, obtain the btf fd by means of the offset of
>> +		 * the fd_array, and the offset is the btf fd.
>> +		 */
>> +		fd_array[btf_fd] = btf_fd;
>> +	}
> 
> [...]
> 


-- 
Best Regards
Dylane Chen


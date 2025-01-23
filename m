Return-Path: <bpf+bounces-49561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E237CA19D15
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 04:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0AA188AB75
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6135965;
	Thu, 23 Jan 2025 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1GYuycO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4902576;
	Thu, 23 Jan 2025 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737601573; cv=none; b=T7F0+35QX99NlXYyloL5kG+V6LoUEIgl8e8IzYaObcjzmZtA8YQ9fEBuyUbHFpiJ0+Nf4r2xpIKCzT4ICqUXL+5iYGBRfO4jLaCm6VDET263mpdpCMOymDwwgCsoT3MaGMgTEyELNjDA/yBb/46Q92jCx5i+MxIgUA4HT5zRMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737601573; c=relaxed/simple;
	bh=Y0VCaYrqShSwV4YZtAxBiPndKRyxT2JjQBQGnY3SVoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQUsiktDQ8aoE95gwcZIWMB+8xvIXq0cYRXlmNlNKjfouw9mFzIWpAFKb+1/9XzzE6CapW36hXj2Ge4QgDCt2WHVFil+6Pm2CZ8xmGn6/mak4hIPa0hfaJpi2u+QZjU16bg2Urcb9NFLM5NMDB5rBEHPwm4vGA/y3eZGliSm7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1GYuycO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21649a7bcdcso6434775ad.1;
        Wed, 22 Jan 2025 19:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737601570; x=1738206370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgo4k3Tfi4WinZQ1yafC5rn4PBmrw9L0uX3X0rA/eRQ=;
        b=K1GYuycOiaalSQN8GBVId+TnvIdMcM+r2rFutmrq/oyPvbWuvFSFMTR1Up4nIhLt4z
         qcK7Wt/AZyAhpe0J88O5LDaLI2cYGbTH0x0Bjg0fMgarYDW+3euXLdNnAiVW5BSjQflO
         dkchHrSe++o+e4bOXZ0W8uWw41M3VoOIVcCtpsy66xXZEBZmHkiV1zJOikj6BcG8mhAG
         FkN2gFDj7v72Reo7nvkJe+/G3LxFfdSjtFm9nBMXT5IgjVFneMTc0gsKI2++3WiIJw/e
         hk3yrWDRbiuRNZoO3PnTZ/hBk2q7bLPvCXkJEeErRzKLUxmI6mRuhAKQMXbdjHjZAabo
         BJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737601570; x=1738206370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bgo4k3Tfi4WinZQ1yafC5rn4PBmrw9L0uX3X0rA/eRQ=;
        b=OiD1n5IP1iGjY6n0h464DwuN/yNxGHiBvqBS3Yx2FtrjP8w4a0dcGk21kH+gTj3H/S
         BSJwLknfLMC920sC91RgKmhP+vzJwbKEvoSdSp5aXlQnQ3Vq0k+yr5q/3lwLMeyB76JU
         wCV9P9tbID/hQi8ocPzWA8zkQAWydLzLjrm8hh9+wN8fl9YKOuIAs1zoctAj4iRZCb9i
         bXqyX/f8AiGqKUBtBpGvGo24FmziPURTDL95Jpsig+ccPsQMwmU/03PNZ60anZVbjkEL
         4QrSRs/+xW4Dm43JUg41xr3N55pNgkr+VXNTsrgtQKzfKBXiJ/sXk4LmYzlaaoW9loBv
         p1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCKDipp664AlKofq2Ga2mknZ/6gdSzhSruRmY3mL+EqN7M6pnudPWUjsN4wUSndiVvLWI=@vger.kernel.org, AJvYcCXDyvFbE/Tm1DTAkSgctmKuND9jhm5OU1t+RxGlLEN9cd3/I7fwtNWG83zDKK/A3Fwnc6869PL+1qalKNst@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQkjD/exn6GxhSya033m6N4cBZ4O6VYFZxmwZD/A8QrDHlqpx
	lzkAAP+EbjR10hRS5yEPdCnnxzmQQ106osPl5X/sNY6Bb1wge4z3
X-Gm-Gg: ASbGnct2zJbRwSLh63eXa1ohUlAna5SWscCzYiVpQDKO+S1uSRMkpCneJIyI4z17BKx
	qisYGStZOxbVo95CzLvIR9te7uJcs8gDZ2uxbhcGOFnyD4pz7UEaAq7lkTd7f+SRchnhpndr2V9
	f3pacn3OLwlLepsP8XlzaHAibeWuSt1zSVJAOGQb1YWzwFeUV4Xey3ivjnTV7BIYkJl+RBv1QDk
	uzFxEBStIdNWGQF/vM1Hbg3nZjTAgdy5DZzIzt1qDrHAEIUxH3pkRLsrF+ykafXgu+LTyHtjwRD
	Ug==
X-Google-Smtp-Source: AGHT+IGXaMfEOgLMpEg9sLuCz6EU+5j1py/UM1aTVZrVXRLMTu1gPOq4oeRQbUg93Avj0YA6FZbNKg==
X-Received: by 2002:a05:6a00:17a3:b0:725:90f9:daf9 with SMTP id d2e1a72fcca58-72dafa7c0c9mr31288427b3a.15.1737601569528;
        Wed, 22 Jan 2025 19:06:09 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba44453sm11740993b3a.127.2025.01.22.19.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 19:06:08 -0800 (PST)
Message-ID: <09bd9f31-a096-4640-9f3e-c6232cf4b07d@gmail.com>
Date: Thu, 23 Jan 2025 11:06:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add libbpf_probe_bpf_kfunc API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250122171359.232791-1-chen.dylane@gmail.com>
 <20250122171359.232791-2-chen.dylane@gmail.com>
 <CAEf4BzZM9YCzbs1-nv6nDk=-V8EO08N76wTC5aawCyHRd9Ptqg@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzZM9YCzbs1-nv6nDk=-V8EO08N76wTC5aawCyHRd9Ptqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/1/23 06:22, Andrii Nakryiko 写道:
> On Wed, Jan 22, 2025 at 9:14 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
>> used to test the availability of the different eBPF kfuncs on the
>> current system.
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.h        | 16 +++++++++++++++-
>>   tools/lib/bpf/libbpf.map      |  1 +
>>   tools/lib/bpf/libbpf_probes.c | 36 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 3020ee45303a..3b6d33578a16 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1680,7 +1680,21 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
>>    */
>>   LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>>                                         enum bpf_func_id helper_id, const void *opts);
>> -
>> +/**
>> + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
>> + * use of a given BPF kfunc from specified BPF program type.
>> + * @param prog_type BPF program type used to check the support of BPF kfunc
>> + * @param kfunc_id The btf ID of BPF kfunc to check support for
>> + * @param opts reserved for future extensibility, should be NULL
>> + * @return 1, if given combination of program type and kfunc is supported; 0,
>> + * if the combination is not supported; negative error code if feature
>> + * detection for provided input arguments failed or can't be performed
>> + *
>> + * Make sure the process has required set of CAP_* permissions (or runs as
>> + * root) when performing feature checking.
>> + */
>> +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
>> +                                     int kfunc_id, const void *opts);
>>   /**
>>    * @brief **libbpf_num_possible_cpus()** is a helper function to get the
>>    * number of possible CPUs that the host kernel supports and expects.
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index a8b2936a1646..e93fae101efd 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -436,4 +436,5 @@ LIBBPF_1.6.0 {
>>                  bpf_linker__add_buf;
>>                  bpf_linker__add_fd;
>>                  bpf_linker__new_fd;
>> +               libbpf_probe_bpf_kfunc;
>>   } LIBBPF_1.5.0;
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index 9dfbe7750f56..bc1cf2afbe87 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -413,6 +413,42 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
>>          return libbpf_err(ret);
>>   }
>>
>> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id,
>> +                          const void *opts)
>> +{
>> +       struct bpf_insn insns[] = {
>> +               BPF_EXIT_INSN(),
>> +               BPF_EXIT_INSN(),
>> +       };
>> +       const size_t insn_cnt = ARRAY_SIZE(insns);
>> +       int err;
>> +       char buf[4096];
>> +
>> +       if (opts)
>> +               return libbpf_err(-EINVAL);
> 
> note how libbpf_probe_bpf_helper() rejects some program types because
> they can't be really loaded. Let's keep it consistent?
> 

Hi andrii, thank you for your guidance, i will add it later.

> pw-bot: cr
> 
>> +
>> +       insns[0].code = BPF_JMP | BPF_CALL;
>> +       insns[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
>> +       insns[0].imm = kfunc_id;
>> +
>> +       /* Now only support kfunc from vmlinux */
>> +       insns[0].off = 0;
> 
> why not support modules from the very beginning?
> 

So can we add a new parameter named like "off"? If it's a module, pass 
the BTF offset to insns[0].off. If it's vmlinux, pass 0.

>> +
>> +       buf[0] = '\0';
>> +       err = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
>> +       if (err < 0)
>> +               return libbpf_err(err);
>> +
>> +       /* If BPF verifier recognizes BPF kfunc but it's not supported for
>> +        * given BPF program type, it will emit "calling kernel function
>> +        * bpf_cpumask_create is not allowed"
>> +        */
>> +       if (err == 0 && strstr(buf, "not allowed"))
> 
> Looking at kernel code, if kfunc ID is not recognized, it seems like
> the verifier won't print anything, is that right? If that's the case,
> then this API will behave differently from libbpf_probe_bpf_helper(),
> which isn't great.
> 

You mean kfunc id is invalid? i try set kfunc id with -1
ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, -1, NULL);
And the verifier will print like:
"kernel btf_id 4294967295 is not a function"

So "not a function" may also be checked, i will add it in v2.

>> +               return 0;
>> +
>> +       return 1; /* assume supported */
>> +}
>> +
>>   int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
>>                              const void *opts)
>>   {
>> --
>> 2.43.0
>>


-- 
Best Regards
Dylane Chen


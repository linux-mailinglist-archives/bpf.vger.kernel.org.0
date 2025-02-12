Return-Path: <bpf+bounces-51202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08668A31C19
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 03:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A054C3A3070
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 02:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280141D517E;
	Wed, 12 Feb 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaraoAbc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD191CAA80;
	Wed, 12 Feb 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327611; cv=none; b=nSLtOea4pSKjvn9E4KkTIXo8655lH1rgwZwM2//ONug/Tk4cw8bVSB71qepoKUDohpnbftI+ItgsOmXfjLoV3YFAsJdQlHpnABMzlEDEnwhKFGcc4BJse+lRs6RyHtXc8yG/hHdD8hC+GAkVPoeqDNOMHTrjkmTd4DK6arC5K9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327611; c=relaxed/simple;
	bh=tcsUskMHWgTqCEzfD0gU9Chx3jKVAuklR1T9ZCi/pTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1M6lXt2FYDJzbpZDLry8enjPdVf9SXfJle7/OUTJs8wRbG2GLF1HeMDjffGUbzSlPff50jAMjtpyQ8eZFVq4glhy4Mb4IngizDktHqPwP9dKEX2vjLSmVnub6b6T5JAWV7VKHPRclX4UigLlrihALPmMSAPriCKBO+2v47HtBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaraoAbc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa8ada664fso3900146a91.3;
        Tue, 11 Feb 2025 18:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739327609; x=1739932409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYfpbaipit2gqqj73MEWZMfRTkNP0NMXgOayu9izEn0=;
        b=JaraoAbcwBgRMlRrC/bN3H+tsZACJg0mnxzSOemfzRu1ZhKypL8ViVNKsnz2X+4R15
         PHC1ghZ7FvbAG8eSc16Tw2wvHtDUfGhbDAvpWsIv/Pp2GkcB7wXZVOhExFA9G3a4H9nH
         vV4EcID1PnBEtYm++g1RDvho9bkJ8CGR86jPpX6QaYeYQ45nTqBn+aVcpwaeh4M2Tv0M
         I/xU/sSDXgIftt9Eaa35WNoEn4UDbEIRty56ZCk0GswgWF1ZKwPEIK226fM9ypXBhfpW
         ixJb1KYHXPseOuq1pnU9GBc24BMBCgTbNj4tfMDiUyyvswFtKO0lX+HfdtEe8VZXYRwP
         09XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739327609; x=1739932409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tYfpbaipit2gqqj73MEWZMfRTkNP0NMXgOayu9izEn0=;
        b=GpovxOdA/SGunu8vUrEIyHVni4GtrLH7i2IpWL2d7z5MdHCrVQRXg0ZSEeM0ZgUsbB
         zevW1fA3LD0vDsPCviXxzLNYQ/qpPUl+/7AaiqXFvtBpIB0tiC/QS6/w1psCmSsjiZZ/
         /pmYjKHnooCKk2JXVwn8MYk1fyiR/gRLHz0PaUZoM+36czRlkyYPx5cYU8HFtmEOxoNx
         BfEicKY2ZGUEQVoIu9AjmywNhpX4Edx8DahJWrTmi2qvV4jpnAav9n4THZO6LmEE1wlu
         s+ExXafX2uVSBvpdQAC3q6pD9PudOpeB1fholp1LCW/gOkloDccuwRxzliJVLE0WhnS2
         Xm4g==
X-Forwarded-Encrypted: i=1; AJvYcCUEejyG6Avx06zcfa9008Iezh9KoH6hYT/8VjH25iz5zTtqP3XjgliCtSKGbK93IdVdHjg=@vger.kernel.org, AJvYcCXF8vbTWTZpBDHG5MEwpZTHJ+loYirJzSMmcGHTcr+ZPYr8UCC1U3cTIT7+diOhM9FfV5Rg229aEcN2Jx2S@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Nwihapxcs0W+AClkMPII6UHE9uF/Uuq9AeXzfRIFoHeO2B/C
	GV0FmFNb22/iJ44U38I+CE2oXxukg6lbajQHUBI1udfabmrjHdVk
X-Gm-Gg: ASbGncsiqC1EgK9CUQ2I2WL+MFO8YzOHu9q9pBXb5Vt6gxm9NE8MXr6kzQjDCtFZfwE
	AzLnANsuLTcTvSEL4r3KnIgfWZzBrZ2tZEKfAGNjfDuAjswA/LM+FCqc69TS9Y+zQWY3zMInWFQ
	KUvZCxFFWfWPubBn+kfF+Bp22mpyVCx/Vburh4/SbQCqeIWSZRDHYghaxjbcIO36DnoaZ6nrNvp
	dXYQ2LRLh06gpJcyUkULncd7CM0BKg8sOFI5oD/rLGxvUY9hBflroNldEpYCMGzY5fLb/uItPSG
	8sNXeLCO9xNMFeI3HaQROo1JhzPweCcZ9Wo=
X-Google-Smtp-Source: AGHT+IFd/aeGO5thJHO0V7ZxYP66w+lE55lq8GrOFOMkeRBDnJSSbupVyZq2JFqOU5Zomh7KSGgihQ==
X-Received: by 2002:a05:6a00:398b:b0:730:979d:e80e with SMTP id d2e1a72fcca58-7322c383f8dmr1581897b3a.7.1739327609165;
        Tue, 11 Feb 2025 18:33:29 -0800 (PST)
Received: from [172.23.160.189] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af64adbsm10220598a12.48.2025.02.11.18.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 18:33:28 -0800 (PST)
Message-ID: <49282239-350a-4a76-9243-501373009bec@gmail.com>
Date: Wed, 12 Feb 2025 10:33:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 3/4] libbpf: Add libbpf_probe_bpf_kfunc API
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Chen <dylane.chen@didiglobal.com>
References: <20250211111859.6029-1-chen.dylane@gmail.com>
 <20250211111859.6029-4-chen.dylane@gmail.com>
 <CAEf4BzbQv4D65kuYRr+i8aqGqUY+YT7oKGJNNBxSUUBsj+Zhrw@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzbQv4D65kuYRr+i8aqGqUY+YT7oKGJNNBxSUUBsj+Zhrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/12 06:24, Andrii Nakryiko 写道:
> On Tue, Feb 11, 2025 at 3:19 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
>> used to test the availability of the different eBPF kfuncs on the
>> current system.
>>
>> Cc: Tao Chen <dylane.chen@didiglobal.com>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.h        | 19 +++++++++++++-
>>   tools/lib/bpf/libbpf.map      |  1 +
>>   tools/lib/bpf/libbpf_probes.c | 48 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 3020ee45303a..e796e38cf255 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1680,7 +1680,24 @@ LIBBPF_API int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void
>>    */
>>   LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
>>                                         enum bpf_func_id helper_id, const void *opts);
>> -
>> +/**
>> + * @brief **libbpf_probe_bpf_kfunc()** detects if host kernel supports the
>> + * use of a given BPF kfunc from specified BPF program type.
>> + * @param prog_type BPF program type used to check the support of BPF kfunc
>> + * @param kfunc_id The btf ID of BPF kfunc to check support for
>> + * @param btf_fd The module BTF FD, if kfunc is defined in kernel module,
>> + * btf_fd is used to point to module's BTF, which is >= 0, and -1 means kfunc
>> + * defined in vmlinux.
>> + * @param opts reserved for future extensibility, should be NULL
>> + * @return 1, if given combination of program type and kfunc is supported; 0,
>> + * if the combination is not supported; negative error code if feature
>> + * detection for provided input arguments failed or can't be performed
>> + *
>> + * Make sure the process has required set of CAP_* permissions (or runs as
>> + * root) when performing feature checking.
>> + */
>> +LIBBPF_API int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type,
>> +                                     int kfunc_id, int btf_fd, const void *opts);
>>   /**
>>    * @brief **libbpf_num_possible_cpus()** is a helper function to get the
>>    * number of possible CPUs that the host kernel supports and expects.
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index b5a838de6f47..3bbfe13aeb6a 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -438,4 +438,5 @@ LIBBPF_1.6.0 {
>>                  bpf_linker__new_fd;
>>                  btf__add_decl_attr;
>>                  btf__add_type_attr;
>> +               libbpf_probe_bpf_kfunc;
>>   } LIBBPF_1.5.0;
>> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
>> index 8ed92ea922b3..ab5591c385de 100644
>> --- a/tools/lib/bpf/libbpf_probes.c
>> +++ b/tools/lib/bpf/libbpf_probes.c
>> @@ -431,6 +431,54 @@ static bool can_probe_prog_type(enum bpf_prog_type prog_type)
>>          return true;
>>   }
>>
>> +int libbpf_probe_bpf_kfunc(enum bpf_prog_type prog_type, int kfunc_id, int btf_fd,
>> +                          const void *opts)
>> +{
>> +       struct bpf_insn insns[] = {
>> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 1, kfunc_id),
>> +               BPF_EXIT_INSN(),
>> +       };
>> +       const size_t insn_cnt = ARRAY_SIZE(insns);
>> +       char buf[4096];
>> +       int fd_array[2] = {-1};
>> +       int ret;
>> +
>> +       if (opts)
>> +               return libbpf_err(-EINVAL);
>> +
>> +       if (!can_probe_prog_type(prog_type))
>> +               return -EOPNOTSUPP;
> 
> libbpf_err() here
> 
> pw-bot: cr
> 

Ack.

>> +
>> +       if (btf_fd >= 0) {
>> +               fd_array[1] = btf_fd;
>> +       } else if (btf_fd == -1) {
> 
> let's not hard-code the equality, use < 0 (though I'd follow
> verifier's offset == 0 convention for vmlinux BTF here as well to stay
> conceptually consistent)
> 

Ack.

>> +               /* insn.off = 0, means vmlinux btf */
>> +               insns[0].off = 0;
>> +       } else {
>> +               return libbpf_err(-EINVAL);
>> +       }
>> +
>> +       buf[0] = '\0';
>> +       ret = probe_prog_load(prog_type, insns, insn_cnt, btf_fd >= 0 ? fd_array : NULL,
>> +                             buf, sizeof(buf));
>> +       if (ret < 0)
>> +               return libbpf_err(ret);
>> +
>> +       /* If BPF verifier recognizes BPF kfunc but it's not supported for
>> +        * given BPF program type, it will emit "calling kernel function
>> +        * bpf_cpumask_create is not allowed", if the kfunc id is invalid,
> 
> bpf_cpumask_create -> <name> to keep comments generic?
> 
>> +        * it will emit "kernel btf_id 4294967295 is not a function". If btf fd
> 
> same as above, use <id> placeholder instead of specific number?
> 
> and keep BTF (all caps) use consistent, please

Ack.

> 
>> +        * invalid in module btf, it will emit "invalid module BTF fd specified" or
> 
> ditto, btf -> BTF
> 
>> +        * "negative offset disallowed for kernel module function call"
>> +        */
>> +       if (ret == 0 && (strstr(buf, "not allowed") || strstr(buf, "not a function") ||
>> +                       (strstr(buf, "invalid module BTF fd")) ||
>> +                       (strstr(buf, "negative offset disallowed"))))
> 
> stylistically, given amount of checks, I'd probably go with the
> following structure

Ack. will change it.

> 
> if (ret > 0)
>      return 1;
> 
> if (strstr(buf, "not allowed") ||
>      strstr(buf, "not a function") ||
> ...)
>      return 0;
> 
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


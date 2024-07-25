Return-Path: <bpf+bounces-35614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1793BD29
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456841C2120E
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21F216F85A;
	Thu, 25 Jul 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob9uz7yW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1251CA8A;
	Thu, 25 Jul 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892788; cv=none; b=kJAzRvqmh3tH+bpPvCcZipQDgF+f7NAKO07w3T4hJMxLcKiBEU2LW7GIGj6BmSBUrnw1Ol/Q1ZV++BdchcerFWT8wWGjlWojAQrr1mR0uxZN9QpVRZajBN+57GXn3wrj+wBz9/sOOfTPiMs1nDZUsrRDLDA+FdRbf+6JRAZ0VmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892788; c=relaxed/simple;
	bh=1Uu3PFv1QpxKgLIrIatLBFT+cuwGiIzI7I99zxPykxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUyjYyJYdoh6+cQaZwHBnPO0BZ92AsD/fYPsg/kwyCeZZ17S6nSQ3zynxsPXvdOQXyMcnZCM6lGpRy39PpQr8osok/SHY4DYsYLdeCXlGUy8w5ijmk/o/vBc4HZ+QUOzKIHlj5b4t5FFK1zbZ7GkYJ7UBSeqONFXhlvRso+GpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob9uz7yW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-75a6c290528so441740a12.1;
        Thu, 25 Jul 2024 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721892786; x=1722497586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fujmfYGZfxzHATTeCS+Xi8LmDsRahgwdJ9BzE08rqlk=;
        b=Ob9uz7yWJDVBk317A2bplNie8P7YIKVMGcAAbluWdHPn2zQ7Xi8gDRsTc8MAQlcjvF
         wjq+tGzWNLasovIobBx2DPiFHJFC3zDX4k/oXi/50ktq30gEBRS9YvOT0vqEMP1ZRxkV
         OD6her5zjh8twcourJkbv83jyXGc09pyiPnkgGajG63QdZSzzXLdka6TRpejsU9I+JaJ
         s1ut/PQmLKp7k4ROHmK2hQ5llg2lBnKPCDrqTYbjFnv3njRBnJ37GXWPQm64gjPCyNsC
         7MsbPo1rk5BGg1xTpKuRm4DRLaAvCJyaUk0sZD1q4c/0FDNd0pg7kI9nbJRESID81dgZ
         7AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892786; x=1722497586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fujmfYGZfxzHATTeCS+Xi8LmDsRahgwdJ9BzE08rqlk=;
        b=a6ocfPUUJWCN9ej85Q7kyNc1+SFSKr5242nB6fjgEWfwnEtgUXx/ensFFiMtSjnYvF
         wrd1yeg9n3C/9DJKkBWPv775JZzQzBvLN7UdiXV4cwhAEzcfZLtvThhzqGzBfuxonCLn
         NasmgBSK+oo0DXDK9WF/gIi+ppMH/Qx/IOYwaLY2hfvVQu5THKHHIENoCVKeQ5gMq7Lm
         f2pQAc96WVA8ZQPT+HTyyLNB48alZGSFyGwlBBZyHEzenXgIYGj7HTfK1pUpjEGI+bfi
         2FPOB4UWL53o7XgvcWL9PwHMCGgyjiS/6Ws/+6PDf7+ViH46Q5XWQTyDj1jYC8Eug7Tw
         gAHg==
X-Forwarded-Encrypted: i=1; AJvYcCUau6dgRgcIxGa11nsbCKUCuzJ9ya21P7PMR8K/Yc6Vy47wq+k2rSXNnFLmcCVY+3itRkKUAiPtrXkrNyvulnpo+u04Fykdw6yaTdMZ
X-Gm-Message-State: AOJu0YyA7z8gp4UtQRDnERmyGB5tCOPXEvQ/wVpPvVv8fo3nik5i3UTE
	JXeNzkhrdJBis2EQt0YVp8P5HqZAJOkHkWTDd6cdQkdDM2IQ6p8T
X-Google-Smtp-Source: AGHT+IFAj47ef+ieqUUK1jiYLdSD76dtZSffSvQHpUdQX6caFxgyeV0cBnkz5m52yOBXCJD9psIANA==
X-Received: by 2002:a05:6a20:6d2a:b0:1c0:f3cb:522c with SMTP id adf61e73a8af0-1c47b47aa1cmr857499637.47.1721892785842;
        Thu, 25 Jul 2024 00:33:05 -0700 (PDT)
Received: from [10.22.68.119] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ffd12dsm7427215ad.308.2024.07.25.00.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 00:33:05 -0700 (PDT)
Message-ID: <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com>
Date: Thu, 25 Jul 2024 15:32:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725051511.57112-1-me@manjusaka.me>
 <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com>
 <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25/7/24 14:09, Yonghong Song wrote:
> 
> On 7/24/24 11:05 PM, Leon Hwang wrote:
>>
>> On 25/7/24 13:54, Yonghong Song wrote:
>>> On 7/24/24 10:15 PM, Zheao Li wrote:
>>>> This is a v2 patch, previous Link:
>>>> https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.me/T/#u
>>>>
>>>> Compare with v1:
>>>>
>>>> 1. Format the code style and signed-off field
>>>> 2. Use a shorter name bpf_check_attach_target_with_klog instead of
>>>> original name bpf_check_attach_target_with_kernel_log
>>>>
>>>> When attaching a freplace hook, failures can occur,
>>>> but currently, no output is provided to help developers diagnose the
>>>> root cause.
>>>>
>>>> This commit adds a new method, bpf_check_attach_target_with_klog,
>>>> which outputs the verifier log to the kernel.
>>>> Developers can then use dmesg to obtain more detailed information
>>>> about the failure.
>>>>
>>>> For an example of eBPF code,
>>>> Link:
>>>> https://github.com/Asphaltt/learn-by-example/blob/main/ebpf/freplace/main.go
>>>>
>>>> Co-developed-by: Leon Hwang <hffilwlqm@gmail.com>
>>>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>>>> Signed-off-by: Zheao Li <me@manjusaka.me>
>>>> ---
>>>>    include/linux/bpf_verifier.h |  5 +++++
>>>>    kernel/bpf/syscall.c         |  5 +++--
>>>>    kernel/bpf/trampoline.c      |  6 +++---
>>>>    kernel/bpf/verifier.c        | 19 +++++++++++++++++++
>>>>    4 files changed, 30 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/linux/bpf_verifier.h
>>>> b/include/linux/bpf_verifier.h
>>>> index 5cea15c81b8a..8eddba62c194 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -848,6 +848,11 @@ static inline void bpf_trampoline_unpack_key(u64
>>>> key, u32 *obj_id, u32 *btf_id)
>>>>            *btf_id = key & 0x7FFFFFFF;
>>>>    }
>>>>    +int bpf_check_attach_target_with_klog(const struct bpf_prog *prog,
>>>> +                        const struct bpf_prog *tgt_prog,
>>>> +                        u32 btf_id,
>>>> +                        struct bpf_attach_target_info *tgt_info);
>>> format issue in the above. Same code alignment is needed for arguments
>>> in different lines.
>>>
>>>> +
>>>>    int bpf_check_attach_target(struct bpf_verifier_log *log,
>>>>                    const struct bpf_prog *prog,
>>>>                    const struct bpf_prog *tgt_prog,
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index 869265852d51..bf826fcc8cf4 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -3464,8 +3464,9 @@ static int bpf_tracing_prog_attach(struct
>>>> bpf_prog *prog,
>>>>             */
>>>>            struct bpf_attach_target_info tgt_info = {};
>>>>    -        err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
>>>> -                          &tgt_info);
>>>> +        err = bpf_check_attach_target_with_klog(prog, NULL,
>>>> +                                  prog->aux->attach_btf_id,
>>>> +                                  &tgt_info);
>>> code alignment issue here as well.
>>> Also, the argument should be 'prog, tgt_prog, btf_id, &tgt_info', right?
>>>
>>>>            if (err)
>>>>                goto out_unlock;
>>>>    diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>>>> index f8302a5ca400..8862adaa7302 100644
>>>> --- a/kernel/bpf/trampoline.c
>>>> +++ b/kernel/bpf/trampoline.c
>>>> @@ -699,9 +699,9 @@ int bpf_trampoline_link_cgroup_shim(struct
>>>> bpf_prog *prog,
>>>>        u64 key;
>>>>        int err;
>>>>    -    err = bpf_check_attach_target(NULL, prog, NULL,
>>>> -                      prog->aux->attach_btf_id,
>>>> -                      &tgt_info);
>>>> +    err = bpf_check_attach_target_with_klog(prog, NULL,
>>>> +                              prog->aux->attach_btf_id,
>>>> +                              &tgt_info);
>>> code alignment issue here
>>>
>>>>        if (err)
>>>>            return err;
>>>>    diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 1f5302fb0957..4873b72f5a9a 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -21643,6 +21643,25 @@ static int
>>>> check_non_sleepable_error_inject(u32 btf_id)
>>>>        return btf_id_set_contains(&btf_non_sleepable_error_inject,
>>>> btf_id);
>>>>    }
>>>>    +int bpf_check_attach_target_with_klog(const struct bpf_prog *prog,
>>>> +                        const struct bpf_prog *tgt_prog,
>>>> +                        u32 btf_id,
>>>> +                        struct bpf_attach_target_info *tgt_info);
>>> code alignment issue here.
>>>
>>>> +{
>>>> +    struct bpf_verifier_log *log;
>>>> +    int err;
>>>> +
>>>> +    log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
>>> __GFP_NOWARN is unnecessary here.
>>>
>>>> +    if (!log) {
>>>> +        err = -ENOMEM;
>>>> +        return err;
>>>> +    }
>>>> +    log->level = BPF_LOG_KERNEL;
>>>> +    err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
>>>> tgt_info);
>>>> +    kfree(log);
>>>> +    return err;
>>>> +}
>>>> +
>>>>    int bpf_check_attach_target(struct bpf_verifier_log *log,
>>>>                    const struct bpf_prog *prog,
>>>>                    const struct bpf_prog *tgt_prog,
>>> More importantly, Andrii has implemented retsnoop, which intends to
>>> locate
>>> precise location in the kernel where err happens. The link is
>>>    https://github.com/anakryiko/retsnoop
>>>
>>> Maybe you want to take a look and see whether it can resolve your issue.
>>> We should really avoid putting more stuff in dmesg whenever possible.
>>>
>> retsnoop is really cool.
>>
>> However, when something wrong in bpf_check_attach_target(), retsnoop
>> only gets its return value -EINVAL, without any bpf_log() in it. It's
>> hard to figure out the reason why bpf_check_attach_target() returns
>> -EINVAL.
> 
> It should have line number like below in
> https://github.com/anakryiko/retsnoop
> 
> |$ sudo ./retsnoop -e '*sys_bpf' -a ':kernel/bpf/*.c' Receiving data...
> 20:19:36.372607 -> 20:19:36.372682 TID/PID 8346/8346 (simfail/simfail):
> entry_SYSCALL_64_after_hwframe+0x63 (arch/x86/entry/entry_64.S:120:0)
> do_syscall_64+0x35 (arch/x86/entry/common.c:80:7) . do_syscall_x64
> (arch/x86/entry/common.c:50:12) 73us [-ENOMEM] __x64_sys_bpf+0x1a
> (kernel/bpf/syscall.c:5067:1) 70us [-ENOMEM] __sys_bpf+0x38b
> (kernel/bpf/syscall.c:4947:9) . map_create (kernel/bpf/syscall.c:1106:8)
> . find_and_alloc_map (kernel/bpf/syscall.c:132:5) ! 50us [-ENOMEM]
> array_map_alloc !* 2us [NULL] bpf_map_alloc_percpu Could you double
> check? It does need corresponding kernel source though. |
> 

I have a try on an Ubuntu 24.04 VM, whose kernel is 6.8.0-39-generic.

$ sudo retsnoop -e '*sys_bpf' -a ':kernel/bpf/*.c' -T
Receiving data...
07:18:38.643643 -> 07:18:38.643728 TID/PID 6042/6039 (freplace/freplace):

FUNCTION CALL TRACE                                   RESULT
   DURATION
---------------------------------------------------
--------------------  --------
→ __x64_sys_bpf

    → __sys_bpf

        ↔ bpf_check_uarg_tail_zero                    [0]
    2.376us
        → link_create

            ↔ __bpf_prog_get
[0xffffb55f40db3000]   2.796us
            ↔ bpf_prog_attach_check_attach_type       [0]
    2.260us
            → bpf_tracing_prog_attach

                ↔ __bpf_prog_get
[0xffffb55f40d71000]   9.455us
                → bpf_check_attach_target

                    → btf_check_type_match

                        → btf_check_func_type_match

                            ↔ bpf_log                 [void]
    2.578us
                        ← btf_check_func_type_match   [-EINVAL]
    7.659us
                    ← btf_check_type_match            [-EINVAL]
   15.950us
                ← bpf_check_attach_target             [-EINVAL]
   22.397us
                ↔ __bpf_prog_put                      [void]
    2.323us
            ← bpf_tracing_prog_attach                 [-EINVAL]
   45.509us
            ↔ __bpf_prog_put                          [void]
    2.182us
        ← link_create                                 [-EINVAL]
   66.445us
    ← __sys_bpf                                       [-EINVAL]
   77.347us
← __x64_sys_bpf                                       [-EINVAL]
   81.979us

                    entry_SYSCALL_64_after_hwframe+0x78
(arch/x86/entry/entry_64.S:130:0)
                    do_syscall_64+0x7f
(arch/x86/entry/common.c:83:7)
                    . do_syscall_x64
(arch/x86/entry/common.c:52:12)
                    x64_sys_call+0x1936
(arch/x86/entry/syscall_64.c:33:1)
    81us [-EINVAL]  __x64_sys_bpf+0x1a
(kernel/bpf/syscall.c:5588:1)
    77us [-EINVAL]  __sys_bpf+0x4ae
(kernel/bpf/syscall.c:5556:9)
!   66us [-EINVAL]  link_create

!*  45us [-EINVAL]  bpf_tracing_prog_attach

!*  22us [-EINVAL]  bpf_check_attach_target

!*  15us [-EINVAL]  btf_check_type_match

!*   7us [-EINVAL]  btf_check_func_type_match

P.S. Check
https://gist.github.com/Asphaltt/883fd7362968f7747e820d63a9519971 to
have a better view of this output.

When attach freplace prog to a static-noline subprog, there is a
bpf_log() in btf_check_func_type_match(). However, I don't know what
bpf_log() logs.

With this patch, we are able to figure out what bpf_log() logs.
Therefore, we are able to figure out the reason why it fails to attach
freplace prog.

Thanks,
Leon


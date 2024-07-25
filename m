Return-Path: <bpf+bounces-35612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8F93BC8D
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 08:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090BA283F10
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74E016C690;
	Thu, 25 Jul 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjusaka.me header.i=@manjusaka.me header.b="YtRqW7Dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tdKPdzzd"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7429CA;
	Thu, 25 Jul 2024 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721889181; cv=none; b=AhPaM0I9mPsb/rP/KQ0fU3DtJWRHtoKWZbf9KEe75pslDpH/pW/nsdXmVul3HQ6maKTdxe+A4aGwBa3p10MNePf+YyeQs0F0U1JpijVeqYv+2m7Yi59PWj+C8Z5fZGggWeCc8jQXgWyCt9CdhoOTKSJGZ2eI/VAGWJd1Zi8T/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721889181; c=relaxed/simple;
	bh=N90K1B6FlTii8rTZtlUgFF3m4WH9emVGKNhH5YJ3XFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPyJN9SwDNyyO31dyiD2iFxSm3zTWe+BPrYmiYq+pr0Qa+hP0O5kV1788/5Zx6mca92rEGrJuhLRBWGV1jiswahzXqdGIoVShCJ+yew4WoiVogTDRUTV/hnwtnAJJZ8qXV8cqRAE1E8eUf33a9zoR0c4BQu/SInspIeV7YMgjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manjusaka.me; spf=pass smtp.mailfrom=manjusaka.me; dkim=pass (2048-bit key) header.d=manjusaka.me header.i=@manjusaka.me header.b=YtRqW7Dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tdKPdzzd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manjusaka.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjusaka.me
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B51E0114024C;
	Thu, 25 Jul 2024 02:32:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Jul 2024 02:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721889177;
	 x=1721975577; bh=hPx6P8+FlGlyh1aphGa5lEwiz4N11bPL+o6dt6Ky+HI=; b=
	YtRqW7DqTN1XRTr8GvV/AnliTjhKdIlyCrS7k46f1W51HZ3MKIgmAvly7RWnjAj0
	DTLZ9tc0RyMXWcAUiMeA1KuQqcpPdXJ7JkMF8H+cKKCODB2A0z9NzJGcMtNCiGgr
	TE2FCU/cfXqfDjR7TWw/Gad+Xy5cA0Ja6d9bJLj4sva/NpwLgsBvunNZRtV0OUqo
	pVkGMDiVxyVyPpnIrAB+kSgsC5gCBKQ2nTS7orGi1X3BloOHB9UAJDyue8yNV371
	bTmyqRh6rspOu8svytMmKJK++3GSrZyBtCI1IjWIgpZoy03Vxih+eYhtAq4VWDdj
	nhFW1XOhtTm3bWias5q+cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721889177; x=
	1721975577; bh=hPx6P8+FlGlyh1aphGa5lEwiz4N11bPL+o6dt6Ky+HI=; b=t
	dKPdzzdtE6qDYK24lWSZzyg6iLhJfig1MxqhK3et5VUJ3Z6JiI/H8G73SjUOtr1o
	MAQS6at041U27V6DpAHXfa3taVqoXPBVIFMvHaetiqJijVsLfpSF3L5KXuS6OrRR
	8EIT2rDoeJ1Kr2dvBdjzLFNp5X9XUxlKzf+BLd8wk+ipOHKeduwpGZdmzBqY8tOb
	mMjiXGY6jg1IOBcB21UFo6nsrMv+B/IiYWmygMFepBQp2bUOeigECIbbGJ/LIyxV
	1lzwk93rKZreV8nUnPVzAM+Ze42ezFNkgccAdT+6eL/BTn18KUr369yLu170pWOv
	8zipB3AmSjHfJuJFQDjYw==
X-ME-Sender: <xms:mfGhZhwi9mLGMRCm3GIm3Mh4ndiCDrbVx2fzsHZ4Eb5M_iEiaRNoBA>
    <xme:mfGhZhTKN0c7GUa_-8znfxvmBWZ9-GKSa57HJupOajvGUZ00qgpryKcSGFnLVq0Br
    tqf_TNZ5V17_GnaXLo>
X-ME-Received: <xmr:mfGhZrVaHwza3TAmxxq8rngRxbWlK6a527D0Lm-dITGedub4jbhVPCpBY6XzvombXzzXwczw87UBq4-9jBK2BELT9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedvgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghn
    jhhushgrkhgruceomhgvsehmrghnjhhushgrkhgrrdhmvgeqnecuggftrfgrthhtvghrnh
    epheefgfehhfeiteejjeduhffgfffhtdejuefhfefggfdvteegheffhfeufedugfeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehmrghnjhhushgr
    khgrrdhmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:mfGhZjiply6DCtUDkAYDQ-HJZdjhriPcWaqxyhGEknfYQHP2DNUhOA>
    <xmx:mfGhZjAhf-SqtvUGKm3TQPwcjOPZsnAVsG3MmaXQJn653JhPlIX0fA>
    <xmx:mfGhZsLdGDu4wtoVxSE1PB-vgCr4LXSC53JZnjCona9c89IVa03LAw>
    <xmx:mfGhZiBJSJ4p_wkQm-mMZnlfMAzKrnkgzK6hXpTzoCVHQTHo54wpHw>
    <xmx:mfGhZlTndkDW6u11ObIJcM8c2vAZa6TqbJtDGlXgwY_s_Nm9SkcfMuvm>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 02:32:45 -0400 (EDT)
Message-ID: <43e95369-3a4f-428b-b0e0-329880173167@manjusaka.me>
Date: Thu, 25 Jul 2024 14:32:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
To: Yonghong Song <yonghong.song@linux.dev>, Leon Hwang
 <hffilwlqm@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
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
Content-Language: en-US
From: Manjusaka <me@manjusaka.me>
In-Reply-To: <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/7/25 14:09, Yonghong Song wrote:
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
>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
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
>>> More importantly, Andrii has implemented retsnoop, which intends to locate
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
>> hard to figure out the reason why bpf_check_attach_target() returns -EINVAL.
> 
> It should have line number like below in https://github.com/anakryiko/retsnoop
> 
> |$ sudo ./retsnoop -e '*sys_bpf' -a ':kernel/bpf/*.c' Receiving data... 20:19:36.372607 -> 20:19:36.372682 TID/PID 8346/8346 (simfail/simfail): entry_SYSCALL_64_after_hwframe+0x63 (arch/x86/entry/entry_64.S:120:0) do_syscall_64+0x35 (arch/x86/entry/common.c:80:7) . do_syscall_x64 (arch/x86/entry/common.c:50:12) 73us [-ENOMEM] __x64_sys_bpf+0x1a (kernel/bpf/syscall.c:5067:1) 70us [-ENOMEM] __sys_bpf+0x38b (kernel/bpf/syscall.c:4947:9) . map_create (kernel/bpf/syscall.c:1106:8) . find_and_alloc_map (kernel/bpf/syscall.c:132:5) ! 50us [-ENOMEM] array_map_alloc !* 2us [NULL] bpf_map_alloc_percpu Could you double check? It does need corresponding kernel source though. |
> 
>>
>> How about adding a tracepoint in bpf_check_attach_target_with_klog()?
>> It's to avoid putting stuff in dmesg.
>>
>> Thanks,
>> Leon
>>
>>


Thanks for the review and reply. I will update the patch later when we reach the same point

Actually, for personally, I think it would be better to get the error message from dmesg. 

I can get enough information without installing extra dependency

Thanks

Zheao Li/Nadeshiko Manju


Return-Path: <bpf+bounces-73509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA413C3322F
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5F31889A9C
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF39B2D0617;
	Tue,  4 Nov 2025 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbbWPiI2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B4F9EC
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294432; cv=none; b=qNMFOxyO8hKTHnv0QNPkLf5sX0oQRHhZ/MmwBOAjYyOBLeaXU4UJhaS+ZVE/i/fwgxQepnORNxaJbGSfbY0a1+dqJgITeWk6GuS7EbR2SZMeN/mbjU1mo+ThYTWQ0fBISy6LDyoQA5cqoyrxX5dc6JQFjGHgTtx8gRZOeYTA+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294432; c=relaxed/simple;
	bh=B++7vGcqHCF4XZY+EolP1vnvyz2rxPS6p+ZzhyTFg3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3LDuB09ZppXPqgK0sX9+76jnAJAW+9SlvT0HVIGKTJr7L6VkOXegioxFV71qsQhm9OMGqp0xhSVKtwvNnRCcRPFLmrvdW2X2b7BgN7ii4ayoRRLDARvC+G3gZ4NSp7UCCPMur95hEyT1lRqvKU1PwAhjPZL2/gL7CsmdP0BSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbbWPiI2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4710665e7deso28503955e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762294429; x=1762899229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjaedYUtiX3T6EwCUHC4jpDyL++U5dTaeX5A5bbL4f0=;
        b=hbbWPiI2jum2+nn54GSZ/iPOD2TNjHZ1VcbgSKIkJpeuwoofK2l+jIdgNtuDgGIemW
         zhgFJVtin17eWdrU8vezw43l6TXumUHdjUXycfg1t508ZOaXynSpw6TdhJpq4F63RJ81
         NJDgFK4mrr5GJ4m9FC8e0BrRDQhWuX85QJji9Dvv9ScYEVbvNw+zWwXBEopxvwU5Hvc0
         q9t1lQnVf+ydYwHE7uqnltnqT3EMM6TmoDoc5hgglEbEaTVpijEjXzwI67+Iu64QWf5w
         4Mv88AL1W2K+Mo5rPfERVZk5LA1XMx3+GyTp5ja/oiJI5FNOCX6esagiv8DyAIiIwpKV
         yqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762294429; x=1762899229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjaedYUtiX3T6EwCUHC4jpDyL++U5dTaeX5A5bbL4f0=;
        b=IlnCibKlhRDekM39zSfPXac4XcVVNgUZeoyNVzsTG5RlChhO/wAGNwbAQjc/Ww5hxN
         kWMltvlrZiiMl37hyDtT2zC8EnO07d1OuOVIf8gaWQR1yMC+vt0lhoqM/p4SZz6LKpeD
         ky2uTKSxLi1Lef2w2+VsykINUddglQK2/480MyLgm45rQlRuAtDsYf0F8TwK81vL3faq
         VHfcCTiLHC0fdLAVfYBGG6gEAsnP7VU2zQh9CGqKh1pUgzRL0nFYqtD5fFkZkY+qbf05
         PRCjt8LodI1AgXajll5P0ymXXownDCk6lQr6MqRAOSmqpFCJ1Yb87DdAYP2iQZmLIcAN
         Bj2A==
X-Gm-Message-State: AOJu0Yz4364VY5L7Jmp6S0jAjI0Eg3g5QM8dUDLudH783RHnkP1veDjz
	wvi32i4VdMWWXbrJ3+Bi21W0Jk2SvO6pwMGav3uC5ZNzrvIDDBgB7XQe
X-Gm-Gg: ASbGncvMG5XNt1X7zkKK/7QOQrbnssCCsu9Zdwxfva/6dZL7wpWzWG1mEOy5tdH2Vwd
	qLXjgAVO4L8Bj2PZnElirld8/W+XpNIKe31jSogHiSmuQrbRciKgf2ZqpHto6wu9YuIFdUCxLid
	yEPloRf8XtVNO331HRqoPRR/z6YiYJ1pjkqflSlwXQ+VrCLvgtjZdWRX+IGWReLhnHFr2QWlu5V
	788vx3JLYl1wyK6Ttp16QGhZFCYfpmgixueix3lRfGcwbEx/sxrEDF5Yp1e9bnnOu3vbbVLuOVK
	dQ4Hq9LSSmNwJ4ChfuBMsZwtcCuQ7Fq0igBVNC2V8TwrBv8UaxkgcfG0x8OwCF/X1gnYEBr3xNQ
	VtBGixUfENRvvZ+PxAFcbwcNE634ghLCjjSVpxzGm7dgWXiOHl2Wo9LMJar5GqjxMnE7Si3U14g
	3cghCf6hrSX7zsixiBZCmsbMmbX4QvWPLMitEpYuL3dkKNVHoXU4lPSMcaqyQSCfPV
X-Google-Smtp-Source: AGHT+IHb96HuGmf7CqpawQhzQJGiMb8gxR/O6NSiUSRFLHD1dn3GiC2ab12OJVoDbX+4dI61Y5MPVA==
X-Received: by 2002:a05:600c:8b6f:b0:471:3b5:aeac with SMTP id 5b1f17b1804b1-4775cdca35dmr9715435e9.15.1762294428984;
        Tue, 04 Nov 2025 14:13:48 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdca7cbsm11881295e9.5.2025.11.04.14.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 14:13:48 -0800 (PST)
Message-ID: <ee9adebb-55bd-4636-b895-856e7e55c740@gmail.com>
Date: Tue, 4 Nov 2025 22:13:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 0/2] bpf: add _impl suffix for kfuncs with implicit
 args
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20251104-implv2-v2-0-6dbc35f39f28@meta.com>
 <529b54a3-c534-4760-9bec-ed1214e82819@linux.dev>
 <CAEf4Bza3xzxucYS_1U=hoHs=ihJGvpSk4h1M1k-cnb4eyDQwtg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bza3xzxucYS_1U=hoHs=ihJGvpSk4h1M1k-cnb4eyDQwtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/4/25 19:29, Andrii Nakryiko wrote:
> On Tue, Nov 4, 2025 at 9:23 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> On 11/4/25 7:29 AM, Mykyta Yatsenko wrote:
>>> We’re introducing support for implicit kfunc arguments and need to
>>> rename new kfuncs to comply with the naming convention.
>>> This new feature, will for each kfunc of the form:
>>>
>>> `bpf_foo_impl(args..., aux__prog)`
>>>
>>> generate a public BTF type:
>>>
>>> `bpf_foo(args...)`
>>>
>>> and the verifier will resolve calls to bpf_foo() to bpf_foo_impl(),
>>> supplying a valid struct bpf_prog_aux via aux__prog.
>> Hi Mykyta, thank you for submitting this.
>>
>> The explanation in this cover is inaccurate. There were a few
>> discussions, and the "implicit" feature is in active development, so
>> it is confusing... Let me try to elaborate.
>>
>> Currently if a kfunc needs access to struct bpf_prog_aux data, it must
>> have an explicit void *aux__prog argument in its declaration. Then on
>> BPF side the users must pass a dummy value (conventionally NULL).
>>
>> In the v6.18-rc4 these 4 functions are using aux__prog argument:
>>    * bpf_wq_set_callback_impl (note existing _impl suffix)
>>    * bpf_task_work_schedule_signal
>>    * bpf_task_work_schedule_resume
>>    * bpf_stream_vprintk
>>
>> The goal of the KF_IMPLICIT_ARGS feature is to hide this argument from
>> BPF programs, as it is supplied by the verifier.
>>
>> With it, the kfuncs still require an explicit argument in the
>> kernel declaration, for example:
>>
>>      __bpf_kfunc int bpf_foo(int arg, struct bpf_prog_aux *aux__implicit);
>>
>> In order to hide it from the BPF users, the following functions will
>> be produced in BTF from the above declaration:
>>
>>      /* no aux arg for BPF interface kfunc */
>>      __bpf_kfunc int bpf_foo(int arg);
>>
>>      /* no kfunc decl_tag for _impl function */
>>      int bpf_foo_impl(int arg, struct bpf_prog_aux *aux__implicit);
>>
>> Now the problem with existing aux__prog users that you're renaming in
>> this patchset is that because they don't have an _impl suffix, their
>> prototype will change, breaking binary compatibility with existing BPF
>> programs. If we simply mark them as KF_IMPLICIT_ARGS, then they lose
>> an argument in BTF, for example:
>>
>>      bpf_task_work_schedule_signal(task, tw, map__map, callback, aux__prog);
>>
>> becomes
>>
>>      bpf_task_work_schedule_signal(task, tw, map__map, callback);
>>
>> However, if we rename it to "bpf_task_work_schedule_signal_impl", then
>> after KF_IMPLICIT_ARGS feature is implemented, we can *add a new
>> kfunc* "bpf_task_work_schedule_signal" with an implicit arg.
>>
>> This way we can avoid breaking BPF progs calling this kfunc, although
>> renaming is still a disruption of course.
>>
>> See links to previous discussions:
>> * https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
>> * https://lore.kernel.org/bpf/20250924211716.1287715-1-ihor.solodrai@linux.dev/
>> * https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/
>>
>>> Three kfuncs added in 6.18 don’t follow this *_impl convention and
>>> therefore won’t participate in the new mechanism:
>>>   * bpf_task_work_schedule_resume()
>>>   * bpf_task_work_schedule_signal()
>>>   * bpf_stream_vprintk()
>>>
>>> Rename them to align with the implicit-arg flow:
>>> bpf_task_work_schedule_resume() -> bpf_task_work_schedule_resume_impl()
>>> bpf_task_work_schedule_signal() -> bpf_task_work_schedule_signal_impl()
>>> bpf_stream_vprintk() -> bpf_stream_vprintk_impl()
>>>
>>> The implicit-arg mechanism is not in tree yet, so callers must switch to
>>> the *_impl names for now. Once the new mechanism lands, the plain
>>> names (without _impl) will be reintroduced as BTF-visible entry points
>>> and will resolve to the _impl versions automatically.
>>>
> TBH, it looks like both Mykyta's and Ihor's descriptions are a little
> bit too detailed and are more concerned with details of the upcoming
> feature.
>
> What's important with these fixes is that we are fixing deviation from
> the previously established "_impl" suffix naming convention for these
> kfuncs that accept verifier-provided bpf_prog_aux arguments. Following
> uniform convention will allow for transparent backwards compatibility
> with the upcoming KF_IMPLICIT_ARGS feature, so this patch set aims to
> fix current deviation from the convention so as to eliminate
> unnecessary backwards incompatibility breakage in the future.
>
> WDYT?
Thanks, this message makes more sense, let me update commit descriptions 
and send v3.
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>> Changes in v1:
>>> - Split commit into 2
>>> - Rebase on the correct branch
>>> - Link to v1: https://lore.kernel.org/all/20251103232319.122965-1-mykyta.yatsenko5@gmail.com/
>>>
>>> ---
>>> Mykyta Yatsenko (2):
>>>        bpf:add _impl suffix for bpf_task_work_schedule* kfuncs
>>>        bpf:add _impl suffix for bpf_stream_vprintk() kfunc
>>>
>>>   kernel/bpf/helpers.c                               | 26 +++++++++++---------
>>>   kernel/bpf/stream.c                                |  3 ++-
>>>   kernel/bpf/verifier.c                              | 12 +++++-----
>>>   tools/bpf/bpftool/Documentation/bpftool-prog.rst   |  2 +-
>>>   tools/lib/bpf/bpf_helpers.h                        | 28 +++++++++++-----------
>>>   tools/testing/selftests/bpf/progs/stream_fail.c    |  6 ++---
>>>   tools/testing/selftests/bpf/progs/task_work.c      |  6 ++---
>>>   tools/testing/selftests/bpf/progs/task_work_fail.c |  8 +++----
>>>   .../testing/selftests/bpf/progs/task_work_stress.c |  4 ++--
>>>   9 files changed, 50 insertions(+), 45 deletions(-)
>>> ---
>>> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
>>> change-id: 20251104-implv2-d6c4be255026
>>>
>>> Best regards,



Return-Path: <bpf+bounces-71199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F5BE8F49
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B7B188646E
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA402F691C;
	Fri, 17 Oct 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmjW0NZR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506352F6903
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708314; cv=none; b=dAbsKTUF/yLQDsI3GhCWWAJSyppYGuCojHDQN4DUx+Av5dnKNTHspsiz7kRF7I+mUZbgRhtDTm8rScIScNEO/4H1bCeIW8gmmufZszr0moI/GdHRDAOPS6CvvwgdxgA6x49YCCaZFeASARDvTYe9gfaN1/Yug2bSwndlkqsVLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708314; c=relaxed/simple;
	bh=dKPFiyMwAS9jEqgHOTB4iDR0Lzw+4RPsGSNxWJ16oIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqfnx/yNi91Rghh30Oq28aU0q7tqYLVPuqseev3HXc1T5pHJBVpsFp+hyb5MEyDw+ESlXJnE6PKQaS8UCUmN6lTmRDqGZ51xilYDKghgJ3RLo7ySV72yD31W2R7ujMFiaMX+cMpwylmJUgEOmKNaNoAQCdJshH5nOxEJ40HkCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmjW0NZR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4712c6d9495so488475e9.2
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760708310; x=1761313110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTyHPqrMSqkhDgyEg9AcUe8GhX8MKoPde3eBRCRx+r4=;
        b=KmjW0NZRgMXv+FGp5y8V+dtWEnVllOi0uIBbQO9E4Y0xSMBwFNryzLe4vXN0GFHNHD
         1UQl90TtxiqatbY9JOqkqh15vWJ6T5vvBQRnmBwK/CvKog9sE+lRsIKFEDjL/1+FKDpr
         Aysf5ENG23uGS3eYs2fKK1YeCrAcrIVSchgZX9FzaVpaDeVjjWBbVwKPqWKrfoKEme4S
         a9G0UVHdEsbi1fGTORX+YfcfcjRUlkY35KkOlYNm+B2cIM2OrXw5lU8nZJQFWWgIlmnu
         Kn4WHP1THnjkGUt2ghq0PyeBTnULdSc7CUwHLnHJMhsywAfydFfKoMI2vSZsSp86NSse
         UUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760708310; x=1761313110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTyHPqrMSqkhDgyEg9AcUe8GhX8MKoPde3eBRCRx+r4=;
        b=Nov0IWqmATUYDovT1vagU2S/ZBUYf0XCxP5r/tSuECx40886a9qCR1mySEhS1yxOq4
         Z+lmpE6lY3Z0tAWGR76eGDr1st1A2s59X9iVK3BBZd4Ct2yH4HpSR5PoZFQIZzJY9YCR
         0VFS90AezRaaJ+xg7bu1XxpcVIEHQs+dZLZ79ZQaeegChQNZXIDXlDjE8iyw9SWdnQDs
         uS3Y09B4g9mW+Phpj61A3wJpCEQH0BslbcZjwQPaF5VFcS6uJek/R+hf2hDfMBiVzVlO
         xf6JZ69fiM6amTL7xAykULBLSRT1nwL+IwLmuuxnuwWtRHCyEF9kQDSdtvEgDCqNPkH6
         M09Q==
X-Gm-Message-State: AOJu0YzzvJD39rpCcOI20kk6gd9kZI8s5I0PeMZ0ODpv3fDk7eMqxVW1
	U4RuFElA3tYxI9dLIpOTYKBK4uzUnHL+mnk6Gi9stae7KKDwd8JoXgtJ
X-Gm-Gg: ASbGncsv7XejOQzcvi84Ml+QR1mi0XUwDwkEfdpnQxEnLfD4fWjk5yzwUQ4U2StusY4
	bgaus/bf4r+bpkKsfEorBjuwkZ5+gTQhEyTxgK9H/UwQv85asV9u0gWdzhwD70ulxl6pHWPwj/U
	1mg+TeZsuYDUq4wFeaOAEFl/zox26yMmPY5P93uz3tG9j44ReBepzQhRrk5qsEjxbYPh8IMbMNU
	Ts6D8MbRfNYeyZQ3nV6zBLMZ3W29tc91L+mgvRzEI/4WC2V4CungxiAF21j96LAfukhdJ//VJsu
	xd+Bq4LgKhUlJZqdFHOXu9Eu6jTKPhVfrB7W4sKxyL1zjHY/kvWzAeSXiwqCVHhtmQwvb4yqPCv
	EIFw6v2WBW4z+29k7KY3qH+0obK033WJ/LGlAkNW+hT1991DwFLTbmSEQTafEp92SQy90tqVF7o
	3llAPmA/Mf64T0yGSn5laiK1jasvNitkp+k+g=
X-Google-Smtp-Source: AGHT+IFJBsJ33ohZZkDoOU2spBJMGY1ajUuCEJD2scqsYCBPE/YG1LE8pvwGARyFSQG0lBkp0qsobQ==
X-Received: by 2002:a05:600c:19d4:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-47117903e2amr26654725e9.26.1760708310342;
        Fri, 17 Oct 2025 06:38:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0c3:1130::114d? ([2620:10d:c092:400::5:a7e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710cd833ebsm47290305e9.3.2025.10.17.06.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 06:38:29 -0700 (PDT)
Message-ID: <df068351-62a9-4bf6-938d-076a3d2443fa@gmail.com>
Date: Fri, 17 Oct 2025 14:38:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/11] selftests/bpf: add file dynptr tests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
 <20251015161155.120148-12-mykyta.yatsenko5@gmail.com>
 <188b00961e374aeec9b1aac53cb25416e502ef67.camel@gmail.com>
 <CAEf4BzYoA_T2zM7+ED88PMe2VNpybrduFObUB83QegGewB2O5A@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYoA_T2zM7+ED88PMe2VNpybrduFObUB83QegGewB2O5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 21:29, Andrii Nakryiko wrote:
> On Wed, Oct 15, 2025 at 2:57 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>> On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> Introducing selftests for validating file-backed dynptr works as
>>> expected.
>>>   * validate implementation supports dynptr slice and read operations
>>>   * validate destructors should be paired with initializers
>>>   * validate sleepable progs can page in.
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>> I get the following error report when running this test on top of [1].
>>
>> [1] 48a97ffc6c82 ("bpf: Consistently use bpf_rcu_lock_held() everywhere")
>>
>> ---
>>
>> [   11.790725] ============================================
>> [   11.790999] WARNING: possible recursive locking detected
>> [   11.791195] 6.17.0-gbfd75250bee0 #1 Tainted: G           OE
>> [   11.791418] --------------------------------------------
>> [   11.791446] test_progs/153 is trying to acquire lock:
>> [   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault (mm/memory.c:7081 (discriminator 4))
>> [   11.791446]
>> [   11.791446] but task is already holding lock:
>> [   11.791446] ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bpf_find_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_lock.h:41 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bpf/task_iter.c:751)
>> [   11.791446]
>> [   11.791446] other info that might help us debug this:
>> [   11.791446]  Possible unsafe locking scenario:
>> [   11.791446]
>> [   11.791446]        CPU0
>> [   11.791446]        ----
>> [   11.791446]   lock(&mm->mmap_lock);
>> [   11.791446]   lock(&mm->mmap_lock);
>> [   11.791446]
>> [   11.791446]  *** DEADLOCK ***
>> [   11.791446]
>> [   11.791446]  May be due to missing lock nesting notation
>> [   11.791446]
>> [   11.791446] 2 locks held by test_progs/153:
>> [   11.791446]  #0: ffffffff85a73be0 (rcu_read_lock_trace){....}-{0:0}, at: bpf_task_work_callback (./include/linux/rcupdate.h:331 (discriminator 1) ./include/linux/rcupdate_trace.h:58 (discriminator 1) ./include/linux/rcupdate_trace.h:102 (discriminator 1) kernel/bpf/helpers.c:4101 (discriminator 1))
>> [   11.791446]  #1: ff110001066916d0 (&mm->mmap_lock){++++}-{4:4}, at: bpf_find_vma (./arch/x86/include/asm/jump_label.h:36 ./include/linux/mmap_lock.h:41 ./include/linux/mmap_lock.h:388 kernel/bpf/task_iter.c:772 kernel/bpf/task_iter.c:751)
>> [   11.791446]
>> [   11.791446] stack backtrace:
>> [   11.791446] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>> [   11.791446] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-4.el9 04/01/2014
>> [   11.791446] Call Trace:
>> [   11.791446]  <TASK>
>> [   11.791446]  dump_stack_lvl (lib/dump_stack.c:122)
>> [   11.791446]  print_deadlock_bug.cold (kernel/locking/lockdep.c:3044)
>> [   11.791446]  __lock_acquire (kernel/locking/lockdep.c:3897 kernel/locking/lockdep.c:5237)
>> [   11.791446]  ? __pfx___up_read (kernel/locking/rwsem.c:1350)
>> [   11.791446]  lock_acquire (kernel/locking/lockdep.c:470 kernel/locking/lockdep.c:5870 kernel/locking/lockdep.c:5825)
>> [   11.791446]  ? __might_fault (mm/memory.c:7081 (discriminator 4))
>> [   11.791446]  ? __pfx___might_resched (kernel/sched/core.c:8880)
>> [   11.791446]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
>> [   11.791446]  __might_fault (mm/memory.c:7081 (discriminator 7))
> cc'ing some mm folks for help
>
> Is it a lockdep implementation detail that __might_fault is taking
> mmap_lock, or __might_fault is asserting that when fault is allowed,
> something (presumably kernel's page fault handler) might take
> mmap_lock? It's not clear to me.
>
> bpf_find_vma() clearly is holding mmap_lock, so if that's unsafe, we'd
> have to make sure that bpf_find_vma() cannot be called in a sleepable
> BPF program.
>
Do we want to have a finer granularity, for example just disallow
calls to copy_from_user type of functions in the bpf_find_vma callback?


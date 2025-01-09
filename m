Return-Path: <bpf+bounces-48320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F66A069F0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 01:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873693A6BAE
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 00:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC8D4C7D;
	Thu,  9 Jan 2025 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuYyqtU2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93C136E
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736382745; cv=none; b=DB3hbwpWfa2Igr3nlgJJM17Dia+67s2MW0oVILI2N9U4ZZyuhWi6vgmkbvOT0dRBNTm9n37M/Aj6wiReFVVTE+tgPvgO2xIAK6RM13NYFAPwFpVrIbQUurvheQibJRkvB25PfiG4xx4//qHYBeYSooYfD2kGMLivCuJxEJCNSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736382745; c=relaxed/simple;
	bh=RFQ4vJ5wfqbkAxU54BPhxmvC2qh8R4iMy3CuAj81vs0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R0m+1wMLLNZkk3kyGPUL2zTfE58CdWskk4zsQGfQpNdaa7DCK/vQA2FBTHZgaOnMeZ597EN01AR59dYQP0puK91Dy735SZoGfHCvsIrN7BVlGUyovjzr7KmWRPiSbVPLdi90dkotnPKVuEk2w5X+7QUD7/homCT3FiWiCo3f2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuYyqtU2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736382742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi155RjRwWDbZncgotm4uVCJKy7anDdIO+LXK2laYh8=;
	b=EuYyqtU2A8Tadfof12A6X6n+cG5SX4tVFJtvVzvmm6lu+/ipyCUiguzL1a1jaGmkWl1/sq
	d3DFK5cHf8XQVkTswB3kTliDwcpeAfW7q8NK5lY3AJuhWZaFs/zY/bfjOjFWxRgZWj9ALg
	62ZrWVfboQvvaT5iuYSPVVTC7x9IM3w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-VL9hqmPEPOC-pEaUAutBHA-1; Wed, 08 Jan 2025 19:32:21 -0500
X-MC-Unique: VL9hqmPEPOC-pEaUAutBHA-1
X-Mimecast-MFC-AGG-ID: VL9hqmPEPOC-pEaUAutBHA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d88833dffcso7049146d6.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 16:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736382741; x=1736987541;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi155RjRwWDbZncgotm4uVCJKy7anDdIO+LXK2laYh8=;
        b=p1j2dbt0JvBCsg/1EdJ8H5AS3zRKTNgc8x6SzbQJ1K2cgO9n3gFAta1Rf1HKtrB4jE
         tVmKPDXlUDWpclSBNt03CYwhLJT5n5Hj1MR5EMRCU+RSWcMCBtQ9ABhsLI6xwdZ9Z5eZ
         AgLnsKWfuQ2CplXmVsyXQSBGalk2mq57zYGGFSx99CubTCJIoDgfyPTOQSn10MOpBw9P
         EwWGEWjK4unPUB/JenYc2cHLDLokPb6evazY5gmwgacuA87i1jTxQNUgNM2xXJBqL4hY
         Lpnnw7b/yUHoMM0dh5jfKUyGhmetvL1n+LAxrerkKhivWBZZmOVmjlnap7RkLFBLLZos
         5kBA==
X-Gm-Message-State: AOJu0YyP+UCL9dlyVb5PcZkl/PC7FmubpKbXPSXLr+r+fAlr10rghvzd
	dx8HI9I5X7NeJCjEm762jJv+DU3bziP/iFs8Ayxl5Smoqy9g2WXbUNZQ/YgdH47SPNmH3uIWpKD
	tG/mDz+bZGIlZdDrqw70zQnTRmbds6lVL0Yevsf8v+4CfuGV0nw==
X-Gm-Gg: ASbGncvxoM9BkHhuv2a5Q66EeB9DW14KFmKHiD/+b56lHSjt8r//Ae97OrDaAdJxhP8
	neORY4S7GfHmr4jGOXM58zWc6uLAycDMxJDu4s/V1663O4Xv19L8IAT9TahNb6lVNARvSRcisQX
	Td4sv2Em+P10j45hQmi/qP+fwfyFcjCj/a0XLnwWrbROPPkQFmr1tFILWZ5HGQdvfHu8BU9bo65
	7MX8XDvdd3lnPjKZfsG838eO/5Wg9fSd1ifsaGc1ukCg8zcY7UUpl77+duIO4z4MtpFoGHbtGnM
	Y8MKwZ0eIJaxAVcPL0NKjpnt
X-Received: by 2002:a05:6214:f6b:b0:6d8:7ed4:336a with SMTP id 6a1803df08f44-6df9b2ad580mr84588786d6.31.1736382741107;
        Wed, 08 Jan 2025 16:32:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPwft1Eab4oS+/iu4S08mvjqhhG3H/y6zmpQNobpiKQz9qdiBXvBStJYpGbxzYSmz9Mijr7A==
X-Received: by 2002:a05:6214:f6b:b0:6d8:7ed4:336a with SMTP id 6a1803df08f44-6df9b2ad580mr84588196d6.31.1736382740468;
        Wed, 08 Jan 2025 16:32:20 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd182082f0sm195331996d6.129.2025.01.08.16.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 16:32:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1b1b68c3-4ee0-46de-b571-3ca366f6670b@redhat.com>
Date: Wed, 8 Jan 2025 19:32:17 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 11/22] rqspinlock: Add deadlock detection and
 recovery
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Waiman Long <llong@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
 Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
 Dohyun Kim <dohyunkim@google.com>, kernel-team@meta.com
References: <20250107140004.2732830-1-memxor@gmail.com>
 <20250107140004.2732830-12-memxor@gmail.com>
 <2402fa3e-bd43-47a5-ab8c-bd05877831ff@redhat.com>
 <CAP01T77FDwOs8wP2UvUNHC=oRE-ivUA5Ay04o0rnSc-M1NLmHA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP01T77FDwOs8wP2UvUNHC=oRE-ivUA5Ay04o0rnSc-M1NLmHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/25 3:19 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, 8 Jan 2025 at 21:36, Waiman Long <llong@redhat.com> wrote:
>>
>> On 1/7/25 8:59 AM, Kumar Kartikeya Dwivedi wrote:
>>> While the timeout logic provides guarantees for the waiter's forward
>>> progress, the time until a stalling waiter unblocks can still be long.
>>> The default timeout of 1/2 sec can be excessively long for some use
>>> cases.  Additionally, custom timeouts may exacerbate recovery time.
>>>
>>> Introduce logic to detect common cases of deadlocks and perform quicker
>>> recovery. This is done by dividing the time from entry into the locking
>>> slow path until the timeout into intervals of 1 ms. Then, after each
>>> interval elapses, deadlock detection is performed, while also polling
>>> the lock word to ensure we can quickly break out of the detection logic
>>> and proceed with lock acquisition.
>>>
>>> A 'held_locks' table is maintained per-CPU where the entry at the bottom
>>> denotes a lock being waited for or already taken. Entries coming before
>>> it denote locks that are already held. The current CPU's table can thus
>>> be looked at to detect AA deadlocks. The tables from other CPUs can be
>>> looked at to discover ABBA situations. Finally, when a matching entry
>>> for the lock being taken on the current CPU is found on some other CPU,
>>> a deadlock situation is detected. This function can take a long time,
>>> therefore the lock word is constantly polled in each loop iteration to
>>> ensure we can preempt detection and proceed with lock acquisition, using
>>> the is_lock_released check.
>>>
>>> We set 'spin' member of rqspinlock_timeout struct to 0 to trigger
>>> deadlock checks immediately to perform faster recovery.
>>>
>>> Note: Extending lock word size by 4 bytes to record owner CPU can allow
>>> faster detection for ABBA. It is typically the owner which participates
>>> in a ABBA situation. However, to keep compatibility with existing lock
>>> words in the kernel (struct qspinlock), and given deadlocks are a rare
>>> event triggered by bugs, we choose to favor compatibility over faster
>>> detection.
>>>
>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> ---
>>>    include/asm-generic/rqspinlock.h |  56 +++++++++-
>>>    kernel/locking/rqspinlock.c      | 178 ++++++++++++++++++++++++++++---
>>>    2 files changed, 220 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
>>> index 5c996a82e75f..c7e33ccc57a6 100644
>>> --- a/include/asm-generic/rqspinlock.h
>>> +++ b/include/asm-generic/rqspinlock.h
>>> @@ -11,14 +11,68 @@
>>>
>>>    #include <linux/types.h>
>>>    #include <vdso/time64.h>
>>> +#include <linux/percpu.h>
>>>
>>>    struct qspinlock;
>>>
>>> +extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
>>> +
>>>    /*
>>>     * Default timeout for waiting loops is 0.5 seconds
>>>     */
>>>    #define RES_DEF_TIMEOUT (NSEC_PER_SEC / 2)
>>>
>>> -extern int resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val, u64 timeout);
>>> +#define RES_NR_HELD 32
>>> +
>>> +struct rqspinlock_held {
>>> +     int cnt;
>>> +     void *locks[RES_NR_HELD];
>>> +};
>>> +
>>> +DECLARE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
>>> +
>>> +static __always_inline void grab_held_lock_entry(void *lock)
>>> +{
>>> +     int cnt = this_cpu_inc_return(rqspinlock_held_locks.cnt);
>>> +
>>> +     if (unlikely(cnt > RES_NR_HELD)) {
>>> +             /* Still keep the inc so we decrement later. */
>>> +             return;
>>> +     }
>>> +
>>> +     /*
>>> +      * Implied compiler barrier in per-CPU operations; otherwise we can have
>>> +      * the compiler reorder inc with write to table, allowing interrupts to
>>> +      * overwrite and erase our write to the table (as on interrupt exit it
>>> +      * will be reset to NULL).
>>> +      */
>>> +     this_cpu_write(rqspinlock_held_locks.locks[cnt - 1], lock);
>>> +}
>>> +
>>> +/*
>>> + * It is possible to run into misdetection scenarios of AA deadlocks on the same
>>> + * CPU, and missed ABBA deadlocks on remote CPUs when this function pops entries
>>> + * out of order (due to lock A, lock B, unlock A, unlock B) pattern. The correct
>>> + * logic to preserve right entries in the table would be to walk the array of
>>> + * held locks and swap and clear out-of-order entries, but that's too
>>> + * complicated and we don't have a compelling use case for out of order unlocking.
>> Maybe we can pass in the lock and print a warning if out-of-order unlock
>> is being done.
> I think alternatively, I will constrain the verifier in v2 to require
> lock release to be in-order, which would obviate the need to warn at
> runtime and reject programs potentially doing out-of-order unlocks.
> This doesn't cover in-kernel users though, but we're not doing
> out-of-order unlocks with this lock there, and it would be yet another
> branch in the unlock function with little benefit.

That will work too.

Cheers,
Longman



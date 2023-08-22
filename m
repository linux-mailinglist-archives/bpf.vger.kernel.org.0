Return-Path: <bpf+bounces-8295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5FB784AE0
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEBF1C20B1F
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FE320192;
	Tue, 22 Aug 2023 19:53:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4F20180
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 19:53:47 +0000 (UTC)
Received: from out-48.mta1.migadu.com (out-48.mta1.migadu.com [IPv6:2001:41d0:203:375::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3062093
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:53:45 -0700 (PDT)
Message-ID: <d90cb7f7-3ce7-cec5-7850-c886ae04b791@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692734023; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F8ufDbPxF+w2Ti4jHhHkQNw3BlXUv8qT40TI9vzmTdg=;
	b=rWHKYo1fsEy4YNNgyG1yLqhS2GPu7/bOm8htzkiU3bVDq/hvzuS5Db2u1cv0Mbd5RYv/VH
	xdbmmcq2pZ1IslO0j1Fjzjo2HL2H7+hm9GTRyYfb04LQltfXA+hkFBxsw233gs0etrjry8
	TNrnPzEwLQori85z10MFRtLafB/463c=
Date: Tue, 22 Aug 2023 12:53:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 6/7] bpf: Allow bpf_spin_{lock,unlock} in
 sleepable progs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-7-davemarchevsky@fb.com>
 <3a24babf-c4e0-11a2-e4a7-3d14b8858d88@linux.dev>
 <20230822194642.rt4plvim7m77tlkh@MacBook-Pro-8.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230822194642.rt4plvim7m77tlkh@MacBook-Pro-8.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/22/23 12:46 PM, Alexei Starovoitov wrote:
> On Mon, Aug 21, 2023 at 07:53:22PM -0700, Yonghong Song wrote:
>>
>>
>> On 8/21/23 12:33 PM, Dave Marchevsky wrote:
>>> Commit 9e7a4d9831e8 ("bpf: Allow LSM programs to use bpf spin locks")
>>> disabled bpf_spin_lock usage in sleepable progs, stating:
>>>
>>>    Sleepable LSM programs can be preempted which means that allowng spin
>>>    locks will need more work (disabling preemption and the verifier
>>>    ensuring that no sleepable helpers are called when a spin lock is
>>>    held).
>>>
>>> This patch disables preemption before grabbing bpf_spin_lock. The second
>>> requirement above "no sleepable helpers are called when a spin lock is
>>> held" is implicitly enforced by current verifier logic due to helper
>>> calls in spin_lock CS being disabled except for a few exceptions, none
>>> of which sleep.
>>>
>>> Due to above preemption changes, bpf_spin_lock CS can also be considered
>>> a RCU CS, so verifier's in_rcu_cs check is modified to account for this.
>>>
>>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>>> ---
>>>    kernel/bpf/helpers.c  | 2 ++
>>>    kernel/bpf/verifier.c | 9 +++------
>>>    2 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 945a85e25ac5..8bd3812fb8df 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -286,6 +286,7 @@ static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
>>>    	compiletime_assert(u.val == 0, "__ARCH_SPIN_LOCK_UNLOCKED not 0");
>>>    	BUILD_BUG_ON(sizeof(*l) != sizeof(__u32));
>>>    	BUILD_BUG_ON(sizeof(*lock) != sizeof(__u32));
>>> +	preempt_disable();
>>>    	arch_spin_lock(l);
>>>    }
>>> @@ -294,6 +295,7 @@ static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
>>>    	arch_spinlock_t *l = (void *)lock;
>>>    	arch_spin_unlock(l);
>>> +	preempt_enable();
>>>    }
>>
>> preempt_disable()/preempt_enable() is not needed. Is it possible we can
> 
> preempt_disable is needed in all cases. This mistake slipped in when
> we converted preempt disabled bpf progs into migrate disabled.
> For example, see how raw_spin_lock is doing it.

Okay, a slipped bug. That explains the difference between our 
bpf_spin_lock and raw_spin_lock. The change then makes sense.


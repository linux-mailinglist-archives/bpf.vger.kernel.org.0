Return-Path: <bpf+bounces-49184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F68A14F5D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6887A1F41
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 12:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DA1FF1D5;
	Fri, 17 Jan 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P97diof0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9FC1FF1C3
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117670; cv=none; b=Qhfd7reuHihDKbJyt6VVWUCGS+4O23VtNoWKPcNrsvXaTunxGlw0SyBUX8nDr0KF05trjmGi9KPBOCVyhbpN8XE5S+IEWMeNgkBB2xX2/4rAfJx7v4Zv86f6C2VVXXqS4M/QBBMFpByj4ee1SGF+sTAHYb3k5AvQ5l6gkBS35Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117670; c=relaxed/simple;
	bh=sX+AmtHK7AHSamgxSllFzOkJyamWGm1tKmXsG3ykALo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=leBsUJFAjG+UuUtG+pCVeqol+M7r3MUXFwp2GdbWuYvUEcLyE5D9Cg98zG8CbWrzsJr+cVnhnaZM8rHsfbr7Ou/l0h+wRMXhVBkk01a8B9ET48uCeVtvoRgFocQ8mwVBQfKMTCzTEB12rcRpQyRa0EOOVRhsthcn1AeIkBlGIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P97diof0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C815EC4CEDD;
	Fri, 17 Jan 2025 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737117670;
	bh=sX+AmtHK7AHSamgxSllFzOkJyamWGm1tKmXsG3ykALo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P97diof0kcA34hUJ70MCD8AgB44UzjN419uiWVKqybkIWg2mWqiW1LUxgwYKOiYqr
	 rrDrhLLtd7CkrlBIaSMG011DSnjbVOJYLMW9cbjbeicDHS5vnNNPWGC/cbnx6GXibL
	 JiYN3yJVXVIgYUgTU9lMK7ByNeZRgXtG18/gTqR5KAoLh68UqrApivUtQm7vSty97E
	 +Jt2YW8Zg7lktKKgNqKezrncsje4GRUGKdXvRrGI1K9v1bLD9KL1TbwwvKEGNPQHe1
	 40sFjQE/d98DopIT2lDB7gIx8Ax/Hh2rkx2kBlHvss/TAORRFmqGuV5ecU38POWTxa
	 h+DRPxsFK6Q0A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0096F17E7864; Fri, 17 Jan 2025 13:40:56 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, houtao1@huawei.com, xukuohai@huawei.com
Subject: Re: [PATCH bpf-next v3 4/5] bpf: Cancel the running bpf_timer
 through kworker for PREEMPT_RT
In-Reply-To: <20250117101816.2101857-5-houtao@huaweicloud.com>
References: <20250117101816.2101857-1-houtao@huaweicloud.com>
 <20250117101816.2101857-5-houtao@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:40:56 +0100
Message-ID: <87ldv9obon.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> From: Hou Tao <houtao1@huawei.com>
>
> During the update procedure, when overwrite element in a pre-allocated
> htab, the freeing of old_element is protected by the bucket lock. The
> reason why the bucket lock is necessary is that the old_element has
> already been stashed in htab->extra_elems after alloc_htab_elem()
> returns. If freeing the old_element after the bucket lock is unlocked,
> the stashed element may be reused by concurrent update procedure and the
> freeing of old_element will run concurrently with the reuse of the
> old_element. However, the invocation of check_and_free_fields() may
> acquire a spin-lock which violates the lockdep rule because its caller
> has already held a raw-spin-lock (bucket lock). The following warning
> will be reported when such race happens:
>
>   BUG: scheduling while atomic: test_progs/676/0x00000003
>   3 locks held by test_progs/676:
>   #0: ffffffff864b0240 (rcu_read_lock_trace){....}-{0:0}, at: bpf_prog_te=
st_run_syscall+0x2c0/0x830
>   #1: ffff88810e961188 (&htab->lockdep_key){....}-{2:2}, at: htab_map_upd=
ate_elem+0x306/0x1500
>   #2: ffff8881f4eac1b8 (&base->softirq_expiry_lock){....}-{2:2}, at: hrti=
mer_cancel_wait_running+0xe9/0x1b0
>   Modules linked in: bpf_testmod(O)
>   Preemption disabled at:
>   [<ffffffff817837a3>] htab_map_update_elem+0x293/0x1500
>   CPU: 0 UID: 0 PID: 676 Comm: test_progs Tainted: G ... 6.12.0+ #11
>   Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)...
>   Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x70
>   dump_stack+0x10/0x20
>   __schedule_bug+0x120/0x170
>   __schedule+0x300c/0x4800
>   schedule_rtlock+0x37/0x60
>   rtlock_slowlock_locked+0x6d9/0x54c0
>   rt_spin_lock+0x168/0x230
>   hrtimer_cancel_wait_running+0xe9/0x1b0
>   hrtimer_cancel+0x24/0x30
>   bpf_timer_delete_work+0x1d/0x40
>   bpf_timer_cancel_and_free+0x5e/0x80
>   bpf_obj_free_fields+0x262/0x4a0
>   check_and_free_fields+0x1d0/0x280
>   htab_map_update_elem+0x7fc/0x1500
>   bpf_prog_9f90bc20768e0cb9_overwrite_cb+0x3f/0x43
>   bpf_prog_ea601c4649694dbd_overwrite_timer+0x5d/0x7e
>   bpf_prog_test_run_syscall+0x322/0x830
>   __sys_bpf+0x135d/0x3ca0
>   __x64_sys_bpf+0x75/0xb0
>   x64_sys_call+0x1b5/0xa10
>   do_syscall_64+0x3b/0xc0
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>   ...
>   </TASK>
>
> It seems feasible to break the reuse and refill of per-cpu extra_elems
> into two independent parts: reuse the per-cpu extra_elems with bucket
> lock being held and refill the old_element as per-cpu extra_elems after
> the bucket lock is unlocked. However, it will make the concurrent
> overwrite procedures on the same CPU return unexpected -E2BIG error when
> the map is full.
>
> Therefore, the patch fixes the lock problem by breaking the cancelling
> of bpf_timer into two steps for PREEMPT_RT:
> 1) use hrtimer_try_to_cancel() and check its return value
> 2) if the timer is running, use hrtimer_cancel() through a kworker to
>    cancel it again
> Considering that the current implementation of hrtimer_cancel() will try
> to acquire a being held softirq_expiry_lock when the current timer is
> running, these steps above are reasonable. However, it also has
> downside. When the timer is running, the cancelling of the timer is
> delayed when releasing the last map uref. The delay is also fixable
> (e.g., break the cancelling of bpf timer into two parts: one part in
> locked scope, another one in unlocked scope), it can be revised later if
> necessary.
>
> It is a bit hard to decide the right fix tag. One reason is that the
> problem depends on PREEMPT_RT which is enabled in v6.12. Considering the
> softirq_expiry_lock lock exists since v5.4 and bpf_timer is introduced
> in v5.15, the bpf_timer commit is used in the fixes tag and an extra
> depends-on tag is added to state the dependency on PREEMPT_RT.
>
> Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
> Depends-on: v6.12+ with PREEMPT_RT enabled
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Closes: https://lore.kernel.org/bpf/20241106084527.4gPrMnHt@linutronix.de
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>


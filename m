Return-Path: <bpf+bounces-75757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A62C93590
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 02:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0AD134AE38
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38619539F;
	Sat, 29 Nov 2025 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBGMJis1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30788405F7
	for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764378766; cv=none; b=uqij2HMOxdu+leSbjvZYd3oGYM9MBoEqGeP7i+qTUM9w/slPcs7wYTyqHFiKUDw85OiLUvAfNIyaGpU5oX0Av6iMfQT0FFvPcRQEHv/DP7mZECANKCCG5hAmuSZCVbQ6sYyrtIZvuX8VwktoYhbNqaxnLNe4FoLRsebL7N/oC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764378766; c=relaxed/simple;
	bh=f5Ma7dLdojUznEg+VKIb662LGV7KW3gXJOLwaiVzGRY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kZmEQJfP0Up9/XFLN4uY3nLWsWywW2wxmTQICyPWOvQb+I1M7tJmjOOY0rslbbwI70xsq8U1jYtYsxYx/cJ/USZ7f0uh1c0pUGo1hER/vETFOQgIQFaKk4Qk9lBFhXqS3HJy7FxfHJsmUqrhdQp1QcCEWQns9AVTwd4knFbKNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBGMJis1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B3EC4CEF1;
	Sat, 29 Nov 2025 01:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764378765;
	bh=f5Ma7dLdojUznEg+VKIb662LGV7KW3gXJOLwaiVzGRY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=QBGMJis1uhMo44H4TwTjlezx6t6434KpbjHhNj+yHMVkI+eMl77NSchhidaRKgrE9
	 feRICXiVtCGGFUTgHSZQhPozPkMANnTCvHXNyWRNylgP4ndXjptwenCVHvU7azgM4O
	 QRf+Twpse0AJHaHMMvsQgR/oTg8RPFCi1BsaSCpOSayqJOET3+Cxfv6enq5nkWBM2n
	 gy8tjl9WnxTV9cSxzmgVteqzG3mEy/9MUiTi0Ma/wjo0mfDhlmTNGkrkYQLzHpgROS
	 AW6OI2V1NMhn9cCi8YQLgqO1z+8abgaZjFViObdCxAC/SSi7XdzSq7voguN16nXzJo
	 EXjS+rag+L9hg==
Content-Type: multipart/mixed; boundary="===============5632702494138061367=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6e191f28a7218efa8244704143b7ead2825210e3df003c7f025e0a5e94d82f8f@mail.kernel.org>
In-Reply-To: <20251128232802.1031906-4-memxor@gmail.com>
References: <20251128232802.1031906-4-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] rqspinlock: Use trylock fallback when per-CPU rqnode is busy
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ritesh@superluminal.eu,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,jelle@superluminal.eu,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 29 Nov 2025 01:12:45 +0000 (UTC)

--===============5632702494138061367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index d160123e2..e602cbbbd 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c
> @@ -440,10 +440,25 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
>  queue:
>  	lockevent_inc(lock_slowpath);
>  	/* Deadlock detection entry already held after failing fast path. */
>  	node = this_cpu_ptr(&rqnodes[0].mcs);
>  	idx = node->count++;

Can an NMI interrupt between the load and store operations of this
non-atomic increment? If so, both the interrupted context and the NMI
could read count=0, increment it, and both end up with idx=0.

Looking at the structure definition in include/asm-generic/mcs_spinlock.h,
the count field is a plain int, not atomic_t. The sequence for count++
typically compiles to separate load/add/store instructions.

If an NMI fires after the load but before the store completes:

  Process context: loads count=0
  << NMI interrupts >>
  NMI context: loads count=0, stores count=1, gets idx=0
  NMI: Checks (in_nmi() && 0 > 0) = false, proceeds to queue path
  NMI: Uses rqnodes[0]
  << Process resumes >>
  Process: stores count=1, gets idx=0
  Process: Also uses rqnodes[0]

Both contexts would then call grab_mcs_node(node, 0) and corrupt the
same queue node's locked and next fields.

The old code had this race too, but it was harmless because in_nmi()
was always true, forcing the fallback path. Now that NMIs with idx=0
can enter the normal queue path, does this race become exploitable?

>  	tail = encode_tail(smp_processor_id(), idx);
>
>  	trace_contention_begin(lock, LCB_F_SPIN);
>
>  	/*
>  	 * 4 nodes are allocated based on the assumption that there will
>  	 * not be nested NMIs taking spinlocks. That may not be true in
>  	 * some architectures even though the chance of needing more than
>  	 * 4 nodes will still be extremely unlikely. When that happens,
>  	 * we fall back to spinning on the lock directly without using
>  	 * any MCS node. This is not the most elegant solution, but is
>  	 * simple enough.
>  	 */
> -	if (unlikely(idx >= _Q_MAX_NODES || in_nmi())) {
> +	if (unlikely(idx >= _Q_MAX_NODES || (in_nmi() && idx > 0))) {
>  		lockevent_inc(lock_no_node);
>  		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19775799393

--===============5632702494138061367==--


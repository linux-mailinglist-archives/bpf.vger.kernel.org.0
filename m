Return-Path: <bpf+bounces-64117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914CAB0E655
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0785A1C87F1A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6052877E3;
	Tue, 22 Jul 2025 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6mRlixQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD38284B5D;
	Tue, 22 Jul 2025 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222677; cv=none; b=ewZDZllDMMzW6JhiQUie52qRr/HOKJX5LQtt6S/vUOejR1j7QAelqMFZwg77LXtqK1T/4X1ZCr7TkYeVS9zeE0psB40xnryjWhQGQUy7Nca/zQZvtmg30J0XxlJc4DIttap+4PJCXcl1FqMaOifFoUYeLdgjYpT/cLokhtr4dRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222677; c=relaxed/simple;
	bh=zemiTL/QDNWqSJxFQuFc22tZnd8puCgIlJWLNjceOvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrTDUR7RafcyBLlNLpVHd745hb+E2Od7mxTQNj9oaS+TWwmX6IRnq0ER1b7yRfwE9gXQZ99Z1i8WU/Jbgljs1SM8BTxre3jqKIxG8P5NvWQQJk/ua31T8w6OswZCGR10t18Nh+XQl6h1aWgrpWXqIldOZ9p0aEj4ITfV3AYPGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6mRlixQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E58CC4CEEB;
	Tue, 22 Jul 2025 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753222676;
	bh=zemiTL/QDNWqSJxFQuFc22tZnd8puCgIlJWLNjceOvQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C6mRlixQsArvQp5SFM7L9c6Ps8ntfC3C09109/p7fsMBzK4YSEyelxcSb+Dm+mUwB
	 C1G7JtMFWJUB6f8h4nHauMkWB8WT5rPbeQrN4tq6/BHNKowSBsoWNBpXxXCT+BmnY0
	 jqc76JoB/GiagC4yyHzin3sYuW6miQo0mQoNykZ+xSG8d89mroa+D2Zdx81VTGCCQO
	 5YvaLDYE5cK7fUl0cpMarEMrL/8y87vg0o5geQ/8k+ydtV1Mswc7SoGtGL+Oz/xw6M
	 s0yiI9EgyfXW1lRWNMiIOg/PSdBvrJYPTJQCSB8tUKrqMcIs/CajDBrSj3lYiJL1cy
	 3LEEPW7dNxr2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59409CE0CF0; Tue, 22 Jul 2025 15:17:56 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:17:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 6/4] srcu: Document srcu_flip() memory-barrier D relation
 to SRCU-fast
Message-ID: <9d53dfbd-3b6a-4110-a65e-dadb8fc5066b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>

The smp_mb() memory barrier at the end of srcu_flip() has a comment,
but that comment does not make it clear that this memory barrier is an
optimization, as opposed to being needed for correctness.  This commit
therefore adds this information and points out that it is omitted
for SRCU-fast, where a much heavier weight synchronize_srcu() would
be required.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c5e8ebc493d5e..1ff94b76d91f1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1168,6 +1168,16 @@ static void srcu_flip(struct srcu_struct *ssp)
 	 * counter update.  Note that both this memory barrier and the
 	 * one in srcu_readers_active_idx_check() provide the guarantee
 	 * for __srcu_read_lock().
+	 *
+	 * Note that this is a performance optimization, in which we spend
+	 * an otherwise unnecessary smp_mb() in order to reduce the number
+	 * of full per-CPU-variable scans in srcu_readers_lock_idx() and
+	 * srcu_readers_unlock_idx().  But this performance optimization
+	 * is not so optimal for SRCU-fast, where we would be spending
+	 * not smp_mb(), but rather synchronize_rcu().  At the same time,
+	 * the overhead of the smp_mb() is in the noise, so there is no
+	 * point in omitting it in the SRCU-fast case.  So the same code
+	 * is executed either way.
 	 */
 	smp_mb(); /* D */  /* Pairs with C. */
 }


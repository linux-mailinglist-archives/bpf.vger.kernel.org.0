Return-Path: <bpf+bounces-68771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0AAB8412C
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 12:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC637BEEC3
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1F72F5A3C;
	Thu, 18 Sep 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3u2Gg5t"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF46299A81;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191208; cv=none; b=mhqx0Wo92vqp28MMVeqwFmX9Ksk+b36oSLfu5VzseFIXQqNPxJE3fGsL1CoTNpu/0GVBPQcnnVVDj6vNAZqAciTG9WTivhyR3ST261Dwju0DLbnbJAqMEeM0ci+MS06OLWXXt0F8a8yz6I1iF4neWuJHKcdj+vXhAkGuoQjJPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191208; c=relaxed/simple;
	bh=bUr/c79awvu8OWGK8+lJnU//Ku79FE8Xqz9RETWtyqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzWs6STjft1s9W837mlvxbxTd+bqEeh6CuIiFS/pnH7qR6aqZkPIZyG9ddhGAB7b+XjGgTlfZd6/wys94utGYFmCAcpb5hi567XxwGWeUnR1+c6Tm5SG+Gup2KU+qnFj+f4VUH4meAGmOSC7MtSl3IG9sRkUbtp+TqT7FWZbiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3u2Gg5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA0AC4CEFE;
	Thu, 18 Sep 2025 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191207;
	bh=bUr/c79awvu8OWGK8+lJnU//Ku79FE8Xqz9RETWtyqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3u2Gg5thkUtaN/NWfHNKAS3ogUHOVnaqYP5Dvo0z71KexcdHXAUFxOWauAF0z4V6
	 cRdy/Y1sDwcGugIX3dO6q1thgjiQSQDV3HZ5J8gIM2IZ+TMqrW7z/FJkR2wr8o0XfO
	 3+ko/bI6kwWiP+ggqp5UCJc4HD3yo+PdfZtb+Jw+Gw/MQ4yQJXXr6fXt9HxDMu3Hy/
	 0Dc1d4gbvfQi4yCpUXo8PUb7cexVHOaA2nzvkO+AR1agmlSXs5ZIFFrtx+Q85CIrUy
	 jwvEg6x3gpfqc5glLN/1JwtAHt5hHpAgvGmsfOceK6pTND+Np4vAG7F1hT+78GZdEI
	 BLByvkTUTZzhw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EED18CE10B6; Thu, 18 Sep 2025 03:26:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 5/6] srcu: Document srcu_flip() memory-barrier D relation to SRCU-fast
Date: Thu, 18 Sep 2025 03:26:45 -0700
Message-Id: <20250918102646.2592821-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
References: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/srcutree.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c5e8ebc493d5ee..1ff94b76d91f15 100644
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
-- 
2.40.1



Return-Path: <bpf+bounces-64859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC061B17A6D
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 02:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5955A3415
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C3727462;
	Fri,  1 Aug 2025 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9Wd0Zh/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741F6ADD;
	Fri,  1 Aug 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007159; cv=none; b=NzCofY3OrkOyLXEcGyuuP2SYSiIx3vVsHD3cuduNTDC6t+OuqXxXL57zxHfv+/in7aSFTKsnMFsnvlTimvnSi1zMGaJhjFPSt2bR2MfBp25Qg/BIe/HI/0i9yj2rlAE2AWurU3TwcP1QuNPFBhz9DgPrMlErUqx1cgKvyyHnFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007159; c=relaxed/simple;
	bh=4SSkEhAPaR3rmWNDWHon6TEQT0/S26eD/pqJzTj6tKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DfvVc7eN+7SXZ353r88Z6wWXqLbYkQVQVPDUBm43cDf3Uganfm2q/RxEM6uzZ64TwP8YIQsfFqPL5N+YA6S+/n/Lmb7S7tI/H0b6eBlvfC8kL3HzF6m1CL4+F43lLmAJY6BFrjicZP2gyr7Xb0diUrJm0zMlPI/+QIysnaYcmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9Wd0Zh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE668C4CEFE;
	Fri,  1 Aug 2025 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754007158;
	bh=4SSkEhAPaR3rmWNDWHon6TEQT0/S26eD/pqJzTj6tKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9Wd0Zh/rpN0NXSOrDFbcJP1LqG4u1wvT0C8i/3/aBTS/rbNeAqHGgg/sxljtT9Tu
	 DBJwMT+gPkLvpH92r6mG4+J4+qjen6EXc1ogDh5II93D5NP/73YamwbeWAS9QjUGle
	 tHQYz1hdx89vSrVZCNAe85Fwl2iWh9PiHXiSyarpTStqXZpZsHHYDJToR4BDDLpTfA
	 u5J1oeJ1gKHvHm3eAZyrt+B4XMJW4C1KX20LyQDz0thhHuN06Wj82con/U4IB1O9EN
	 ArDHcQKjA/+lqTGrHVmXaHmUggw3WL2+onv2h8eYINXwySlu4iO8qzj3ekru1gES3/
	 ntcTCI7FyBIfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 34851CE0E88; Thu, 31 Jul 2025 17:12:38 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v5 6/6] srcu: Document srcu_flip() memory-barrier D relation to SRCU-fast
Date: Thu, 31 Jul 2025 17:12:36 -0700
Message-Id: <20250801001236.4091760-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c8842c55-faf8-4cde-89bf-da77d91eadcb@paulmck-laptop>
References: <c8842c55-faf8-4cde-89bf-da77d91eadcb@paulmck-laptop>
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
-- 
2.40.1



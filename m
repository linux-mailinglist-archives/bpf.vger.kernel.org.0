Return-Path: <bpf+bounces-65803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5AEB28909
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 02:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66453AE07F
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 00:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B52343AA4;
	Sat, 16 Aug 2025 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXLAdGS1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119C2AE7F;
	Sat, 16 Aug 2025 00:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302762; cv=none; b=FmC3Sx2VRD9SMS/mc/9rHQ12jydmsDNzY7oDnqhlHYjX9xDRRICaDVJQ3e3FCTcDsDIKLaUs4GOmT5yk6bNVAvY04vHB54Wx+/ndpOZm9jwQfhheo2RdhXQFMaoJIcc485+NdWwDcxK+B57z7lJ4AaMthwdtzCvfFO1KLi7t04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302762; c=relaxed/simple;
	bh=bUr/c79awvu8OWGK8+lJnU//Ku79FE8Xqz9RETWtyqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhn8U5BrFtCqC/IDJ9amJGtzPlPx6yQyv8k3+Ja7pggNa/o7ABc8U+oBrPVgXEcz7wLvxMCIrB8X0iH4JdIIQF6L9fu/dNftPe2Ena34AnO51zDw4RvaUvndx/jIb8qsXE64HsXC4+Bip4gPCiI0xHLyJN6U3wxl5uXXJmObnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXLAdGS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18012C4CEF4;
	Sat, 16 Aug 2025 00:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302762;
	bh=bUr/c79awvu8OWGK8+lJnU//Ku79FE8Xqz9RETWtyqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXLAdGS1dy2hxu45WdWoBAx+PzL/7iHNKWZd7EHjDUSbd9p4sU1ixyFCS1tEuoY9P
	 F/bQyO5wpjnkt6HDQT3kzdhkBm/z0kr9jlV03Hz8LYUefSwmfR2wiKBvy5FvUnARB4
	 fHz+pYb7Ri9Mx4ZULWA0HUxb6nEeawgjCc2WOzI5BAhd8jMtQ4beO5lJbyKkbEFb8d
	 Fh6jyDXTJBiqn4O+CCy7V7YEQrd5ORxkQ9MTkj5gCQBiLBPbCusmfXQbDcAG1B65U8
	 yBIxOZbeYXv/R0Q4qW+pD13/m6wyS5LrGjZ+YR2DO3HAk9MKyRjAY7fkWfwz8MNcz6
	 tBgacMYFCjCLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90731CE0EA9; Fri, 15 Aug 2025 17:06:00 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v6 6/6] srcu: Document srcu_flip() memory-barrier D relation to SRCU-fast
Date: Fri, 15 Aug 2025 17:05:59 -0700
Message-Id: <20250816000559.2622626-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
References: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
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



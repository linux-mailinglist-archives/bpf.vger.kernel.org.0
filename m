Return-Path: <bpf+bounces-73310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47304C2A497
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E87F94EE5C0
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544A02BE7C2;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO3Rd+XP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808B2BD5B2;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=THaW9Krcg5kSFK67x1vHDgOb/EcSLfbw2mt3Y9rQDb5M4Hzj8eOl3xmmAYI4WqSpy4KJm5UWBGYPwyJqM7jeoQrr0qM26wXUS4/597uzQo7Gwmu7CinQDy5wjjAqnzdlF072nd2JxJmVK6q4M6HKa5IgpYfFrEUPq/qUtJLHHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=vGDS0HEqwbT4kBxbF1tBRuTN6wYIuGTYd7f7W76C1sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHVITDvpnxaZvBlEb4ixeAtkkMGuDzg7alPkv89JWGPQCj8B2h7R5MDerv8+0bjWXBP9lbTY+DbgJz2r7u5pFESPaa0hxukDAZrSDynIBdtca5x2YbtMlMC5LDUS8CXbLCpy16OfgjTqgch/Z5JGZHRPKhWybgHo1x5lQtX4NB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO3Rd+XP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E868C4CEE7;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=vGDS0HEqwbT4kBxbF1tBRuTN6wYIuGTYd7f7W76C1sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eO3Rd+XPezEyvxr+qbHZKbOAIg5Kzf8NdGCDBH30nN4R5BycegLj3wTGEA/VyB/lt
	 AmHYIKFMd76iK8F3U0RXTb9TJmZ0IZoG6AG18ogvGBn6DHB7qhzcc90gYSmq9OARuw
	 l93R9qmR8P58shUHOgZ9JAd9PTklPbiT/inZ8NSpWnqvmpCHjbsNYqQtGgcNfV02+6
	 MVT7akj+Du6OUnVXB0nVZJVrizdd9G/437+Gj3YxJm4nTJT7X2HRUagMXARD8SU0uG
	 slRO0n7Cswp7GuLtes81jL/F9HTnXP0KktDiVkhJe/WXFWkxMmqpNergrKygQd3jFe
	 MWsHBx7e4p2+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 99F12CE1605; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 13/19] srcu: Add SRCU_READ_FLAVOR_FAST_UPDOWN CPP macro
Date: Sun,  2 Nov 2025 13:44:30 -0800
Message-Id: <20251102214436.3905633-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the SRCU_READ_FLAVOR_FAST_UPDOWN=0x8 macro
and adjusts rcutorture to make use of it.  In this commit, both
SRCU_READ_FLAVOR_FAST=0x4 and the new SRCU_READ_FLAVOR_FAST_UPDOWN
test SRCU-fast.  When the SRCU-fast-updown is added, the new
SRCU_READ_FLAVOR_FAST_UPDOWN macro will test it when passed to the
rcutorture.reader_flavor module parameter.

The old SRCU_READ_FLAVOR_FAST macro's value changed from 0x8 to 0x4.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h    | 16 +++++++++-------
 kernel/rcu/rcutorture.c | 24 ++++++++++++++++++------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 41e27c1d917d..1dd6812aabe7 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -56,13 +56,15 @@ int init_srcu_struct_fast(struct srcu_struct *ssp);
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /* Values for SRCU Tree srcu_data ->srcu_reader_flavor, but also used by rcutorture. */
-#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
-#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
-//				0x4		// SRCU-lite is no longer with us.
-#define SRCU_READ_FLAVOR_FAST	0x8		// srcu_read_lock_fast().
-#define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
-				SRCU_READ_FLAVOR_FAST) // All of the above.
-#define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_FAST
+#define SRCU_READ_FLAVOR_NORMAL		0x1		// srcu_read_lock().
+#define SRCU_READ_FLAVOR_NMI		0x2		// srcu_read_lock_nmisafe().
+//					0x4		// SRCU-lite is no longer with us.
+#define SRCU_READ_FLAVOR_FAST		0x4		// srcu_read_lock_fast().
+#define SRCU_READ_FLAVOR_FAST_UPDOWN	0x8		// srcu_read_lock_fast().
+#define SRCU_READ_FLAVOR_ALL		(SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
+					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN)
+						// All of the above.
+#define SRCU_READ_FLAVOR_SLOWGP		(SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN)
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e30311551a62..587b28258b6e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -702,6 +702,8 @@ static void srcu_torture_init(void)
 	rcu_sync_torture_init();
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		srcu_ctlp = &srcu_ctlf;
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
+		srcu_ctlp = &srcu_ctlf;
 }
 
 static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
@@ -728,6 +730,12 @@ static int srcu_torture_read_lock(void)
 		ret += idx << 1;
 	}
 	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 2;
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
 		scp = srcu_read_lock_fast(srcu_ctlp);
 		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
 		WARN_ON_ONCE(idx & ~0x1);
@@ -758,8 +766,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
 		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 2));
 	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL))
@@ -793,7 +803,7 @@ static int srcu_torture_down_read(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		return idx;
 	}
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
 		scp = srcu_down_read_fast(srcu_ctlp);
 		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
 		WARN_ON_ONCE(idx & ~0x1);
@@ -806,7 +816,7 @@ static int srcu_torture_down_read(void)
 static void srcu_torture_up_read(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
 		srcu_up_read_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
 	else if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) ||
 		 !(reader_flavor & SRCU_READ_FLAVOR_ALL))
@@ -901,14 +911,16 @@ static struct rcu_torture_ops srcu_ops = {
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
 	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
-				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
 	.name		= "srcu"
 };
 
 static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
+		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
+	else if (reader_flavor & SRCU_READ_FLAVOR_FAST)
 		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
 	else
 		WARN_ON(init_srcu_struct(&srcu_ctld));
@@ -953,7 +965,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
 	.debug_objects	= 1,
 	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
-				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST,
+				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
 	.name		= "srcud"
 };
 
-- 
2.40.1



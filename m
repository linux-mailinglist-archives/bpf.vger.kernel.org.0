Return-Path: <bpf+bounces-54971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20561A76812
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3A53AC706
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F973214A7A;
	Mon, 31 Mar 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkQRLIC4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF2214228;
	Mon, 31 Mar 2025 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431652; cv=none; b=Uhif5WYCJ9RYmoda+Ddvz3UFRAtiZJxnhF/l1clI5JYSmEuxeyKk2hXwMySNpdcQggGATdxtiyEvAR6vY0Wc2eL2teBD4BSBanweKooFm7/LCjbQShF5tCO04EzNUcYGzMhwsEOcDpHL+m6Y6CEadE7JvoI90DYUr5yk4rQo7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431652; c=relaxed/simple;
	bh=6jrWfKkieuu/8D+kTWmVGcAum/HJ0dEaNmeuUwbEYPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XYzLbV8A3phOgMWf1I1woe0f6ume/FaGJc9dwWa4b+biOj1sLurWml/VDrZxKO5eZYkgvLK/uyRpJW28hKXK99tVRpVI6hHP7/oz0y+Dj+P97Y2y3MdtAY6OITEI0ce3AhgwBw7AK1K+zDhQ2hx/y1OQapVBRrfDG+M9srIpaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkQRLIC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78325C4CEE3;
	Mon, 31 Mar 2025 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431652;
	bh=6jrWfKkieuu/8D+kTWmVGcAum/HJ0dEaNmeuUwbEYPU=;
	h=From:To:Cc:Subject:Date:From;
	b=jkQRLIC4+dn8Hfh8zf/gPHOJZzqOOFEBBdsWGZPiC2XmX0zj+H4qvPl5oPfOBW4gI
	 AhJwJYrEG2f++IvA4Y3WUqpH+g2PjkVDbHtpyPdjYslJ5ui/0P0dBXw0sfZuZHhqGM
	 SaSI9+9c5PiGq3BlPosOEVuygeHgPqVUkc9sYNRM4pQsxi6upxnxSblSG+uEYpF6tq
	 dkxVHU2s5tjsuyPrSi8OILIavDjT8U+iHsv4ldE05/I68mQT/J0O1H4BwKJ3bKI+t2
	 qjLbkot8WMZv1yGjOT2Eit8Ll+Zcea3oiLzKYUvoBr3+Lly1umj8AoiAJxBgm80/IJ
	 5FqSe2E33A0vA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 01/18] srcu: Force synchronization for srcu_get_delay()
Date: Mon, 31 Mar 2025 10:33:51 -0400
Message-Id: <20250331143409.1682789-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit d31e31365b5b6c0cdfc74d71be87234ced564395 ]

Currently, srcu_get_delay() can be called concurrently, for example,
by a CPU that is the first to request a new grace period and the CPU
processing the current grace period.  Although concurrent access is
harmless, it unnecessarily expands the state space.  Additionally,
all calls to srcu_get_delay() are from slow paths.

This commit therefore protects all calls to srcu_get_delay() with
ssp->srcu_sup->lock, which is already held on the invocation from the
srcu_funnel_gp_start() function.  While in the area, this commit also
adds a lockdep_assert_held() to srcu_get_delay() itself.

Reported-by: syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/srcutree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b83c74c4dcc0d..2d8f3329023c5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -647,6 +647,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long jbase = SRCU_INTERVAL;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
+	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	if (srcu_gp_is_expedited(ssp))
 		jbase = 0;
 	if (rcu_seq_state(READ_ONCE(sup->srcu_gp_seq))) {
@@ -674,9 +675,13 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	int cpu;
+	unsigned long delay;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
-	if (WARN_ON(!srcu_get_delay(ssp)))
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
+	delay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
+	if (WARN_ON(!delay))
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
@@ -1102,7 +1107,9 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
 	unsigned long curdelay;
 
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = !srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	for (;;) {
 		if (srcu_readers_active_idx_check(ssp, idx))
@@ -1849,7 +1856,9 @@ static void process_srcu(struct work_struct *work)
 	ssp = sup->srcu_ssp;
 
 	srcu_advance_state(ssp);
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	if (curdelay) {
 		WRITE_ONCE(sup->reschedule_count, 0);
 	} else {
-- 
2.39.5



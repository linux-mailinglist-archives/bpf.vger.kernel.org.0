Return-Path: <bpf+bounces-50144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E5A23453
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752DD3A574D
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD441F1934;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvS08X5H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7C1F12F3;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=uV7DvPSKXNecp0frE3D6VoKNA6Xmkc7xwjDGaHfkSgsWSMJXpgM6PZr0vpQIP3IyRlCEI88rBERFuagxlELbNokjAdcPJ6Fhch13lke50GB/DdqgwtXIqcuFnCSprlSBfuf5PoX6sZqmqN72Il/QpiDzbng3NJ7D+C3Y3M6Tf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=uAtuJ3av9Lq9AWrZeg4NpZzJnVi7xarg+44tE0OeOrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORKHtVfolmMMRowaDq3AfUitqvef01dBWhfMe2Db0cmdhvsmLzia6uX2Xhq8t8+YCO9uCPqo5TjSZAv2im+LA4gVnU6NsOzf5YTMY1DkbPFjLKQxeBHdbLdiQonRoC5e4vSa/RhSi41vXb4FW24ef2GiN7JA2Q33B2e7Jj81Nfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvS08X5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8773DC4CEF1;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=uAtuJ3av9Lq9AWrZeg4NpZzJnVi7xarg+44tE0OeOrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvS08X5Hzo5mRUtjSb9QsiUBRDmnZjzj0eJhBk2/0SNfEkt0EjAhzkzOH2cDkdVjo
	 zpg4abim2/gmQElanKBBBpe8NQ1lnxFOBf+Sm22WIEgp1sZP4OJo3l4WcjT7nqyXG8
	 aaDW7NrvxZSqC0z/wisGBAvu7JnY8Uln3zuIcyqBUEBy53X76tmFfU8r4Z1plmUJq+
	 dbgR/EynpHawu70dYIOWoAInDrLvZ5b4fi6+8LirBKlw2B0EkKYEA8Mg5/MBXucA0a
	 aoMSBQ+Rwmy1BfjnHQQ+JkFv1vi1/IFva+v8KLWwlVGc7lFfgx3vcmZ4btJE3o3821
	 xWdhfmJwml2yA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3F56CE37E2; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	syzbot+16a19b06125a2963eaee@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu v2] 07/20] srcu: Force synchronization for srcu_get_delay()
Date: Thu, 30 Jan 2025 11:03:04 -0800
Message-Id: <20250130190317.1652481-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/srcutree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index dfc98e69acca..46e4cdaa1786 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -648,6 +648,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long jbase = SRCU_INTERVAL;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
+	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	if (srcu_gp_is_expedited(ssp))
 		jbase = 0;
 	if (rcu_seq_state(READ_ONCE(sup->srcu_gp_seq))) {
@@ -675,9 +676,13 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
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
@@ -1101,7 +1106,9 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 {
 	unsigned long curdelay;
 
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = !srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	for (;;) {
 		if (srcu_readers_active_idx_check(ssp, idx))
@@ -1854,7 +1861,9 @@ static void process_srcu(struct work_struct *work)
 	ssp = sup->srcu_ssp;
 
 	srcu_advance_state(ssp);
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	curdelay = srcu_get_delay(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	if (curdelay) {
 		WRITE_ONCE(sup->reschedule_count, 0);
 	} else {
-- 
2.40.1



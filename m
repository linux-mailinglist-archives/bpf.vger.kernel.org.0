Return-Path: <bpf+bounces-38787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035DC96A478
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AC6287E25
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3018E741;
	Tue,  3 Sep 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8zphJJv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928418890E;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381200; cv=none; b=q2W27isSk2GfFySWGBSkf9UTML4YHITsLR/h+dMNNi0Nx9GXs7fOhXMJfRe/gycwsqO9l2iYxYMMM67B/CaRJ3HFLNXLTEkb+UQLw9c7nVsrfwRGMCAaU68xb7PMuX72jNReSP3k2OKqRao9u13hvMohYrowrL1ZMWQ0o6aJdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381200; c=relaxed/simple;
	bh=ZFWe75bF/mt2/XCIqlIxdCrVyBzyZMpmZq/qpGsMmvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHjA0jgKyd9NHsJKAmki31ynon2k3x3q+Y9N4zA3nU/jaHpRCFRcCMsDM3qINXb/FyHsGMPFRJssCIlJHZKeeO1UhxAFtkaF4pcsSCZftEyMh6ABHcMmgj98DCT3ASH1mf/oiEWhgL/sNx/LwesTDR2isQcW/1OVNIqgEuSuKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8zphJJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BF7C4CEC6;
	Tue,  3 Sep 2024 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725381199;
	bh=ZFWe75bF/mt2/XCIqlIxdCrVyBzyZMpmZq/qpGsMmvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8zphJJv0LvUrSfZgeJ+SWMLpRvj7b7jhUmrRjVZXAYvBCwRa/weypy4lJ1P7BMZV
	 rALCLTjRvb8gnKBGaikzDoGEo6GtCwUIgNRsHazG/8kXmAR2b1ehEPWXcP7OIkWSPt
	 ++OmGsq9Uk75J7PJHoSf3ZUOVCjHwA382tNSyIKU2qhYPhq1+oy5HFMiDSm4nKqkXy
	 dbFvC+qpfLKkGUuIWx/Wfxg91UaitH8GAaOMY6GjtIJYHeySsBdUv4B9iFh/YPXC+U
	 SEG7qGRzZeRr+cb3JJyCzvwZOWE0YQBQv7JY1u1o+EUwPDwUzgEchMs9qVtMYij5cF
	 NAg2tl7uAutvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3D227CE1EDE; Tue,  3 Sep 2024 09:33:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/11] srcu: Introduce srcu_gp_is_expedited() helper function
Date: Tue,  3 Sep 2024 09:33:09 -0700
Message-Id: <20240903163318.480678-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
References: <26cddadd-a79b-47b1-923e-9684cd8a7ef4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though the open-coded expressions usually fit on one line, this
commit replaces them with a call to a new srcu_gp_is_expedited()
helper function in order to improve readability.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/srcutree.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2fe0abade9c06..5b1a315f77bc6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -418,6 +418,16 @@ static void check_init_srcu_struct(struct srcu_struct *ssp)
 	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
+/*
+ * Is the current or any upcoming grace period to be expedited?
+ */
+static bool srcu_gp_is_expedited(struct srcu_struct *ssp)
+{
+	struct srcu_usage *sup = ssp->srcu_sup;
+
+	return ULONG_CMP_LT(READ_ONCE(sup->srcu_gp_seq), READ_ONCE(sup->srcu_gp_seq_needed_exp));
+}
+
 /*
  * Returns approximate total of the readers' ->srcu_lock_count[] values
  * for the rank of per-CPU counters specified by idx.
@@ -622,7 +632,7 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long jbase = SRCU_INTERVAL;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
-	if (ULONG_CMP_LT(READ_ONCE(sup->srcu_gp_seq), READ_ONCE(sup->srcu_gp_seq_needed_exp)))
+	if (srcu_gp_is_expedited(ssp))
 		jbase = 0;
 	if (rcu_seq_state(READ_ONCE(sup->srcu_gp_seq))) {
 		j = jiffies - 1;
@@ -867,7 +877,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	spin_lock_irq_rcu_node(sup);
 	idx = rcu_seq_state(sup->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
-	if (ULONG_CMP_LT(READ_ONCE(sup->srcu_gp_seq), READ_ONCE(sup->srcu_gp_seq_needed_exp)))
+	if (srcu_gp_is_expedited(ssp))
 		cbdelay = 0;
 
 	WRITE_ONCE(sup->srcu_last_gp_end, ktime_get_mono_fast_ns());
-- 
2.40.1



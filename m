Return-Path: <bpf+bounces-42070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418199F263
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1761F21F5B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677A1F9EB7;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbaBVhq6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B71EBA09;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=sLbNrm4h/ICLlpbJukR0QAQlUAaX64A0lK8UJNhlOoGXh4wLab+BU8tJKofgcCnN+A4Co+twzr4O80gd4SypqlX/sJhaM5M5rLOmLf1YdgNf7/RtGDx2Bl3FjPPdLFwcm/vHONMBIMAriHzp5+UIjz/eJLrj9y3wxqgJv+7Pm70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=wmL8nD35K+D183HPbTxmWpox+7fCqVw7eRDQh/aakYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbf6kNgtrWxEvUBA5LIcnz3N3C205x2LK4NKLIPHH9cMwEfMj72sJh2hxu4q878sM+lxztZmvjIVndzdqBPJUdnRN7uRfqJKy0aMESAJY2Mzj9+uFCYCvlVSuf41xTGof3bKf7kumrF9jUU2yBst6e+UYoQi2HtzHhpxzN9Sruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbaBVhq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170CFC4CECF;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=wmL8nD35K+D183HPbTxmWpox+7fCqVw7eRDQh/aakYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbaBVhq6aLfC7VY51sLTggV8RlajgDfmAPWDy+4TnP/4MjDAqGv71VgfzruJoHkQq
	 zyTw0yiWXvxGgMDAcAAxXsvxb3WOZm8Kw46nXEWWPiTYbqIUOMB3nmyl4NFWUIlD5w
	 w38FOrsyEmju+lfK0LZyksc0YEmm9aYn+1dVTyJqxJqZOYCAR+Zaj1IHG9P5+v0v2v
	 ZHmmCUFpmOq3bm39Jbv6542bzOB6s2tCHBDy2lviwGrX9Xq44c9VOC6HIhskVtXpKi
	 HaMG3MfaTVU2BUhHMNc+HtlKjdIDDequkBQAM0vUxmKJiNSfSLzxR31m0zz1fUajNF
	 KsNFHVLKnfV2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B63C8CE098E; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 02/15] srcu: Introduce srcu_gp_is_expedited() helper function
Date: Tue, 15 Oct 2024 09:10:59 -0700
Message-Id: <20241015161112.442758-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
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
index 9ff4ded609ba5..e29c6cbffbcb0 100644
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



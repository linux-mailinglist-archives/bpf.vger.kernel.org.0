Return-Path: <bpf+bounces-41465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A35799741B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8581F21932
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F81E22F9;
	Wed,  9 Oct 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtHyMAzi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A71E1A17;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497241; cv=none; b=d8H4oSnFFHWUp+4XXFaKjth7RPAjndCBq0Rfe/T5pzwU7lt4eccPnaBtJKVWt8hch/KJd/XB8tguEgqdpYMYSfYvTWB4rmnmK56rkIls/ffY1xA9BcnWADIvouw9wJwIG56W0tEHBTy4rrv555rEf7n4vDmn4SkmT5su5UeBSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497241; c=relaxed/simple;
	bh=wmL8nD35K+D183HPbTxmWpox+7fCqVw7eRDQh/aakYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkmrwZVzXMHBOW5J/bYW6BFjFa5t4GlNV2pSHAxKB70Hyrq7VWhphW2HZH1Ud+fXYIrbfIV/NFv3Bq5Kt0s3QjgGwBK6TWZ6CxQF2MGPMVJIh69VK2fR0eWgLJot84P+BrXoZIbFZ9ULO7z3bPIyZBCAktxkVKWNKddZCyo5WFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtHyMAzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0ADC4CECC;
	Wed,  9 Oct 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497241;
	bh=wmL8nD35K+D183HPbTxmWpox+7fCqVw7eRDQh/aakYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtHyMAzi5pzVy2FO6NdbHf1NjpkLld39dm+aDhUmCMhDih/CCOF+vcj1qNUlAzVo3
	 xzXk7hkxptMPUO5Vc4t5wsewui8Asg2VYaVHbgjmTGIFo21rY9g0Ne9o94tm3N/Vme
	 LNlMYqjC57KmIhE93FHAFTiEXXrkHZofwQg8WwL9JRw4yuOv64sdlRXgt+eHE5ZMQM
	 flCE8cJE3SG0LKmBI5MR0zMDMchsgvPqltBhy7Ist8vZqvPHA0pwHEraTjLbzWc+y2
	 Vhk0GMe4zwynZfTAO85mD9DulKtNzWXiA3Rt19UDSR/INKkd8fZLYPtvr/MS5eXhAW
	 9WvJ/OS5cqAwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12413CE0B68; Wed,  9 Oct 2024 11:07:21 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 02/12] srcu: Introduce srcu_gp_is_expedited() helper function
Date: Wed,  9 Oct 2024 11:07:09 -0700
Message-Id: <20241009180719.778285-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
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



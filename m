Return-Path: <bpf+bounces-69425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6252AB963D5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A1D3BF03E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1767329F12;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ4jcmzv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6D328997;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637316; cv=none; b=aJK+FEH3W7s5/EJRZ7l4n+tgSKdE5uG4MpHiSy2cdZgXdI/rNNspxiMB7Wz+DTCJQS3Kr79aD02CR3/MHnQs2AyTTTwivgn6UhmOhmJhGzuY5wyhCslpz5L3HCh5UAO/7IIrKfsnE1jSb0zjOgs4PNN9NQYshe13udXgtXKagPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637316; c=relaxed/simple;
	bh=vhENAcGeT3O7mnVVnjo6mRyfATWkOODJWG3NzL/dFHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jJrfoE4/AnJ90JyjAHgpGo4LylV9URCZ8d7mYTACq6iQXVRAPEoBEiJ4xexlQ1R/n0VuVkmidamyKqxu1gebX6fSw1RLIllk809f55fFag3fG14Q7Iog0vwwe7U7EUOgtfKpurCtEgBAiMArM1ZsfrtFMyhQ8zUTm1TvOCyVcvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ4jcmzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC26C2BCB1;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637316;
	bh=vhENAcGeT3O7mnVVnjo6mRyfATWkOODJWG3NzL/dFHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZ4jcmzvu5yPLh3dT7MSC3uGwk/CYGXuTJQfC2gJ6RgKoSUYZTDPYMvzwgvAMotSu
	 kvtFmDOyUr+ktFKfRDn8v4xuabNCvyGzshX3SnNDz2a/TK/R7SzKaNeoXK7+5dETKp
	 3Z3jTUVW8e/QWvdV3DRz//yCmavtBj/xFk1EdPfJ3GBfs545H4o889SSO+bpjSOUfY
	 ysSy1e74b0+0opa43vAvxuXquMo+cUL5cforS6IpZfXDp6dKjViGAIUgBoaFALeaKb
	 wj+ACOeiuTEVP3mVN4dkLNg1aOQt7lLorqflLFoT+I6BeY9FL2sMcJDUlrPfxTKTIo
	 bIu26RmNhQKCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C68A3CE12A5; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 07/34] rcu: Remove ->trc_reader_special from task_struct
Date: Tue, 23 Sep 2025 07:20:09 -0700
Message-Id: <20250923142036.112290-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that RCU Tasks Trace has been re-implemented in terms of SRCU-fast,
and no-longer-needed quiescent-state functions have been removed, the
->trc_reader_special task_struct field is only initialized, and never
actually used.  This commit therefore removes it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/sched.h | 1 -
 init/init_task.c      | 1 -
 kernel/fork.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e62c99e44a5502..577fafd22a0e6f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -940,7 +940,6 @@ struct task_struct {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	int				trc_reader_nesting;
 	struct srcu_ctr __percpu	*trc_reader_scp;
-	union rcu_special		trc_reader_special;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 	struct sched_info		sched_info;
diff --git a/init/init_task.c b/init/init_task.c
index 91c37f66ec8e9a..0c075f3cc8fc5a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -165,7 +165,6 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
-	.trc_reader_special.s = 0,
 #endif
 #ifdef CONFIG_CPUSETS
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
diff --git a/kernel/fork.c b/kernel/fork.c
index 12388e895d2955..5686d50b62cfaf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1780,7 +1780,6 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
-	p->trc_reader_special.s = 0;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-- 
2.40.1



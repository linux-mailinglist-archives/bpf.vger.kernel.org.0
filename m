Return-Path: <bpf+bounces-70100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EFBB0D31
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241F87B234A
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52E30648F;
	Wed,  1 Oct 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR2M9STP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95716304BB2;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330120; cv=none; b=jpQnfe0z/O7pKuRzLT8vuNbltewzv1x4KrHPVAJ3afj7nenCegMxmGyKcNeW8RCJOoKXWyegzFjev0xVHElXt1xvWzVxASD66e9Dt8YhFB/vMnz/kHPedcmixoKbI+KC6ulYeiuG0k15hyl9U1ypccCPeghnTcbaZM2c6fUKuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330120; c=relaxed/simple;
	bh=M6lQK/a51z9FSyLcsJB4DdYne3vYn3DuAPGWx5z897o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XC2dBok36tLUZwYpOfzP85IBUBjo+XGxUVKA+Hz2Ts4WLUTo+7nc5J9Bu4DgEF8IWxrFRJJJyzy8yrnAXAD589VDm1yh1ot0vYMf+cDCOguOjM/M4aPXVLKSPlTTCOD/JYCZuF9A7pOoF2wRwtJJew4d6ULVx3vjIUjHKwh3MI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR2M9STP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E0BC19423;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330120;
	bh=M6lQK/a51z9FSyLcsJB4DdYne3vYn3DuAPGWx5z897o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pR2M9STPcyv9NFEEZTT+27ROyeObWB77NHAWfHQ6us7no1FuLckHXZdb4ZAIj1BpO
	 iv2/1/dtWhZRs2NK9J7FC/FHVzyJ051TC8fJBs9+WmXXkThuoQkpxWCX/K3JoPxfSW
	 dWzSc207aRBqeTfYTqs8s6b87OtGAlcPz8RcfhfbTqztUl15/pb+H0oemKzKLPdZ9g
	 NAXYNfXfydCLBco3wkjroY0MfZk79fdOqYi0dV2EV/grxZFZyZp9rQ7rbP1ZSSd8rw
	 YCKqW6druRuOaJRTV5mMQAYcMegU0BGzZ0+oAAzZZqo/A+PenER5Sqll3n+FwEfWw9
	 vgQc55qIB3CiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 87EF6CE14BF; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 15/21] rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
Date: Wed,  1 Oct 2025 07:48:26 -0700
Message-Id: <20251001144832.631770-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates the initialization for the "srcu" and "srcud" torture
types to use DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast(),
respectively, when reader_flavor is equal to SRCU_READ_FLAVOR_FAST.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2e3806b996a80a..e859a1ca7dc841 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -692,10 +692,18 @@ static struct rcu_torture_ops rcu_busted_ops = {
  */
 
 DEFINE_STATIC_SRCU(srcu_ctl);
+DEFINE_STATIC_SRCU_FAST(srcu_ctlf);
 static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
 static struct rcu_torture_ops srcud_ops;
 
+static void srcu_torture_init(void)
+{
+	rcu_sync_torture_init();
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		srcu_ctlp = &srcu_ctlf;
+}
+
 static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
 {
 	srcutorture_get_gp_data(srcu_ctlp, flags, gp_seq);
@@ -865,7 +873,7 @@ static void srcu_torture_expedite_current(void)
 
 static struct rcu_torture_ops srcu_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= rcu_sync_torture_init,
+	.init		= srcu_torture_init,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
 	.readunlock	= srcu_torture_read_unlock,
@@ -897,10 +905,13 @@ static struct rcu_torture_ops srcu_ops = {
 	.name		= "srcu"
 };
 
-static void srcu_torture_init(void)
+static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
-	WARN_ON(init_srcu_struct(&srcu_ctld));
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
+	else
+		WARN_ON(init_srcu_struct(&srcu_ctld));
 	srcu_ctlp = &srcu_ctld;
 }
 
@@ -913,7 +924,7 @@ static void srcu_torture_cleanup(void)
 /* As above, but dynamically allocated. */
 static struct rcu_torture_ops srcud_ops = {
 	.ttype		= SRCU_FLAVOR,
-	.init		= srcu_torture_init,
+	.init		= srcud_torture_init,
 	.cleanup	= srcu_torture_cleanup,
 	.readlock	= srcu_torture_read_lock,
 	.read_delay	= srcu_read_delay,
-- 
2.40.1



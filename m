Return-Path: <bpf+bounces-73721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A68C37BDA
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBCF18948AF
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC929A300;
	Wed,  5 Nov 2025 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3RF5cLi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2C34AAEF;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=PKrsktQbnrbQh4PboS/YexacQCxKD7f+KpiX+ASsQLIYJDmAbRaiF1FeAjLvF9eEyah+YPeCpkBpOKcLpr0x5py7rCiYw4d846rwuE5WI/lU3g34VGY01u1bBMp8Rm11XM++iCiNlUjuxRL7Qnn4B3z1FhBd93azQ6ABtFC0GFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=0XIP1WBNxnsSzGwsfasxIItOHexh0+D3s4eF/W8IWy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/usEIsugx/ZbTJ1uODaiBBz7oXR9aadU862lyPz+k8YU6zLNXzxuOud0oBQV6+xSNjKRKxOqx18ZuPcS9HFZWVjJL85kWA+7K4WBU9GwcvArNuLL73jE0y6Wj6zy5KMqKlIHZlnzxcfynjFnyJ0PRsDuXXctTxCemwYnv9aweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3RF5cLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A583C4AF09;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374740;
	bh=0XIP1WBNxnsSzGwsfasxIItOHexh0+D3s4eF/W8IWy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3RF5cLiNom7AgfajrPIU5BflJ0Zp11zbIbQ//L/TVIiBqI4DpidS1LZauPkjWjpa
	 mQHaht3IEV/N6AidOafD3Bu96+qmfwTmaJK88s5Iht/o+KoUZs0kXU8wNw02tdNM27
	 eckR1/hscyYBB+8ubFvbTRq9ACNOKT+xRKQqtg+WBFnSby2QQ56N9RwCnqLkG4HTpc
	 PLFrRzYxK9GZzeVH6JFUmU6QmsBq0WKDwmRdOebfyYzr4Ez/azdRdA6PSg+L1QDY9L
	 Zsz5Rs7RaK21W5MoyAZ0MSe4pmXXjurHcSERpE5BjO1Bo5JLm+Eaz+5xN+QgOXsZtB
	 IsaT3UH2c/xLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 93EFECE0F4C; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH v2 06/16] rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
Date: Wed,  5 Nov 2025 12:32:06 -0800
Message-Id: <20251105203216.2701005-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
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
index ea8077c08fac..8022d32be351 100644
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



Return-Path: <bpf+bounces-69412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B78B9637E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C6B4A576A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E094F2E336F;
	Tue, 23 Sep 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0ANnOgz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9417266B56;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637302; cv=none; b=CYKfGaCuVTcoYsK7ZzK5QFL+UJEk0M8VvZRGT+78sD68qlv4R1Xf2Pi5zmaKKiqFw7zdOZ3VQjwsw+sGA4vjQivkXy4Vo96gq5XA8d8IQJepXcQG/lI6EHGR3ea+c0baXPtLOq4n2FJ3ynMbVf5YH4a5WtCR/h1Aw5w6e5/Lk78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637302; c=relaxed/simple;
	bh=M6lQK/a51z9FSyLcsJB4DdYne3vYn3DuAPGWx5z897o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLQBVnZ35QgA5G/iDidtX0//q2UkJj2HTgT7wjosHjHzUsagMh38TxrbwpdQFtHf9aw04LtMX0dBZNkiMterO3WOMncQF2g3hjEzi6LBm8lMCIcx9zXlc+Kg6oaO4US4u82fFX1dvNwM9LPtkmiKFNTX/38msV613j6MSJeb2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0ANnOgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08EDC16AAE;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=M6lQK/a51z9FSyLcsJB4DdYne3vYn3DuAPGWx5z897o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0ANnOgzC+ASozW2HZ75QzJ1W5a4HSPXIKWUZjUpnaOdlCuk9bJ5g+J2autwFuIsA
	 Lk5l4kLzfaFObvlQffxspHyFT8OSZTsdk71pQQ0Kh/f6q5DB6JC0a0F+SPXWMoIPFv
	 qDilZ26eN5uljN+xOeTh8Fqbo7FEaDiLLFVG3GfCaN2zv7y3jHYTB9JjTeYwbvTrPR
	 V7jKus+x/COwFC2jldC0ttsDgtNEpRJ0KQwTGb1gPSdpZADYfYX9UbbN25urxAuCl1
	 sSCk51Kec9EYFhg7d7kAKAbtIrGx6jjnA/xpg/DvUQzMJvBQwK1w8sLIWV1bDFO1bc
	 cLokgYfQa1FUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12166CE17C2; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 30/34] rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
Date: Tue, 23 Sep 2025 07:20:32 -0700
Message-Id: <20250923142036.112290-30-paulmck@kernel.org>
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



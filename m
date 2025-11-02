Return-Path: <bpf+bounces-73284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C2DC2977E
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C283AF585
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562025A65B;
	Sun,  2 Nov 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wod+oXgk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA76256C88;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119879; cv=none; b=qxi8gYwdVF5Olw+TN3yLP87AXGX500iARmegHlFgeXUMu8vmVWxTYSUYp60tA1cgdwGzIycGv7HKPbQBmlTj+RQh09DGJOIICBO+7eJMwmTlkt5oMfkmWdig/Rke+jT/guNI5McdFDubuaGcCdxQ8QFxURgOa5CvZfV/hE1zEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119879; c=relaxed/simple;
	bh=Cu8i0gH4rjThNUjBWI39PqXKh0kLjosZp3RPH4rFPo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+zKkB5xtJxZylpZitU394cVXhudAmHV+/wHNn4lFIhOTgZQTtQC8wwbDU3LPP5GNLSMnKXHmdJnAHj0x2Xoa0+5ctMp/ufB4YwMhUYrwmWiDBhX7L/oRS7GSPcMORcW9vSXUpPSg5CxiiL7/t4fit8VGm7cQpDbRklGQtYdgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wod+oXgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8B8C116C6;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119879;
	bh=Cu8i0gH4rjThNUjBWI39PqXKh0kLjosZp3RPH4rFPo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wod+oXgk0zjxiOSXGCu3xJx6QIIT9WScaDOq1gpQDsVgWE7G0WhyBx9gP/FYUHXgN
	 hInxHTm+FfXs5UuLdtMBRqV5VjC2FMb0BnKqbeNvRzYjH8RzAkdhiURvdDD5O+PX4l
	 tPitJiuuI7LJeKmds0C2bux9TP849xCmWp0p46AYVom3r2L6BuaGKx2VrSWCaHPOYa
	 4+2IUIZPgi112nOyqTpqrA1n/fWZV44Y9PzI+T/hPRSVONQ7PlbC76u9OT3M7/Uowd
	 eE6Ig5CRrP5Wz8U9uJ51vBuYCOqIrDdW9OHezQuYxiyJrLaw97Hwayk0Vw5ceMWxfQ
	 eySEbKhACEy/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 87105CE1104; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 06/19] rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()
Date: Sun,  2 Nov 2025 13:44:23 -0800
Message-Id: <20251102214436.3905633-6-paulmck@kernel.org>
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
index aa1f8240a276..e30311551a62 100644
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



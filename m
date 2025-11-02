Return-Path: <bpf+bounces-73276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E637EC2975D
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 22:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 653CA4E8581
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D42D248F4D;
	Sun,  2 Nov 2025 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqT2BBNn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A1225A34;
	Sun,  2 Nov 2025 21:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119878; cv=none; b=shkL1Tq/OCLgFTqfqjmPGN26v7fgDiPePAWE0gAbHDIQAmkXgO5uFMhrgYRJRK9tZj80xZb8gOwUi1cntfEHvDL3CCNqXHtFtPF2r0S4I9AfV/cvdXkMB1VnaUAdeMem2jw7gsQedzOdWtaSaL/Vay14ogUsWg0Jx2kqkgFmyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119878; c=relaxed/simple;
	bh=hiuAkXJp5N4WN5xE4QgqmeyHlsM9HdyJ3JawANTRqe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RJkQwHXuM+wbTWgXeeZ/B9lJLbqiFsUlxp/DTJ2kA/iZGwm4yXP2JNX2I2FR+xyyzASB3UQMmP8PhVhTV1X9KsCoSrnNX8BECw7AGUnUSWDdQJ0vnk9bq6Jd5kVcvqZy2RFLT0qepxeFiakvCy12P5h1hh57/9L+L3GNBhiW0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqT2BBNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09921C116D0;
	Sun,  2 Nov 2025 21:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119878;
	bh=hiuAkXJp5N4WN5xE4QgqmeyHlsM9HdyJ3JawANTRqe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqT2BBNnZtQaTEXe1+q17zK9ihLD/gCJayiiANA5mS06b+dP/ameTRlDG/OJFBqZS
	 rG4huuSiqvu5BF2GpaKYTghJ3uFJFAGbS7z2yQMsRUUm74bMG64czrt9KwAGebq/jm
	 6kttfwvp0m6OjEyTWtV3zixS5ZMxlCS5vDQ8JlE+vqxA907o4HTmn2Qtsx454gT9rW
	 Vp71oRKXHzUeEqKI3sXbAZv/ELfRr9f+gsvA03B2cj4SdUGD1KS8QT4VJBhKpcRCOq
	 +J24BFQO5abwIsIKNnYR0Br5ZaCI5Q6flc5nNaaciafZ20tSR8FULDl0IztNP72hBG
	 h0+GX21ORfP9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7EA35CE0F8F; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
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
Subject: [PATCH 03/19] rcutorture: Test srcu_expedite_current()
Date: Sun,  2 Nov 2025 13:44:20 -0800
Message-Id: <20251102214436.3905633-3-paulmck@kernel.org>
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

This commit adds a ->exp_current member to the rcu_torture_ops structure
to test the srcu_expedite_current() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/rcutorture.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 72619e5e8549..aa1f8240a276 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -389,6 +389,7 @@ struct rcu_torture_ops {
 	void (*deferred_free)(struct rcu_torture *p);
 	void (*sync)(void);
 	void (*exp_sync)(void);
+	void (*exp_current)(void);
 	unsigned long (*get_gp_state_exp)(void);
 	unsigned long (*start_gp_poll_exp)(void);
 	void (*start_gp_poll_exp_full)(struct rcu_gp_oldstate *rgosp);
@@ -857,6 +858,11 @@ static void srcu_torture_synchronize_expedited(void)
 	synchronize_srcu_expedited(srcu_ctlp);
 }
 
+static void srcu_torture_expedite_current(void)
+{
+	srcu_expedite_current(srcu_ctlp);
+}
+
 static struct rcu_torture_ops srcu_ops = {
 	.ttype		= SRCU_FLAVOR,
 	.init		= rcu_sync_torture_init,
@@ -871,6 +877,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
+	.exp_current	= srcu_torture_expedite_current,
 	.same_gp_state	= same_state_synchronize_srcu,
 	.get_comp_state = get_completed_synchronize_srcu,
 	.get_gp_state	= srcu_torture_get_gp_state,
@@ -919,6 +926,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
+	.exp_current	= srcu_torture_expedite_current,
 	.same_gp_state	= same_state_synchronize_srcu,
 	.get_comp_state = get_completed_synchronize_srcu,
 	.get_gp_state	= srcu_torture_get_gp_state,
@@ -1700,6 +1708,8 @@ rcu_torture_writer(void *arg)
 					ulo[i] = cur_ops->get_comp_state();
 				gp_snap = cur_ops->start_gp_poll();
 				rcu_torture_writer_state = RTWS_POLL_WAIT;
+				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
+					cur_ops->exp_current();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
 					gp_snap1 = cur_ops->get_gp_state();
 					for (i = 0; i < ulo_size; i++)
@@ -1720,6 +1730,8 @@ rcu_torture_writer(void *arg)
 					cur_ops->get_comp_state_full(&rgo[i]);
 				cur_ops->start_gp_poll_full(&gp_snap_full);
 				rcu_torture_writer_state = RTWS_POLL_WAIT_FULL;
+				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
+					cur_ops->exp_current();
 				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
 					cur_ops->get_gp_state_full(&gp_snap1_full);
 					for (i = 0; i < rgo_size; i++)
-- 
2.40.1



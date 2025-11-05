Return-Path: <bpf+bounces-73718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B58C37C07
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2AD3A9948
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFD34CFC6;
	Wed,  5 Nov 2025 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqZW3TYI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6B934A76E;
	Wed,  5 Nov 2025 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374740; cv=none; b=GrWwxS6+gg8uKEs6uhbsAZznEN+FLp0Huqv42VR0PcCByRhyqhX6qyiFtUC8TjrCgmCn1ZSjcANzmIdVW2kIGCsUrNA8aybl0MWNsBPOcOKZmbao1cLvzyNB05Ba6pnKYlpRcajV1VMsXUdfcZrnMEOAFj+kY0+RmRPV3fyeL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374740; c=relaxed/simple;
	bh=w01VFRMtubctWz2T4Nx3dEUt4UuqBNsYAd2a1T0fPq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cj5d2I+jko+iTVWi4dy2I9vXRAy5fibR9P1bQrT/65rzxJCr/Z6lnrW9as4Pud8AIaGeY3n5SCrWecqoLzBNwZT3TzjIgjIr7Z9ljPcnwDDfxStEaEwL8/k8CUkk2GdRpXW0RLryGXQjNoHPfyoDtYr+tri6lHgysGt1ymWX7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqZW3TYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70307C116D0;
	Wed,  5 Nov 2025 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374739;
	bh=w01VFRMtubctWz2T4Nx3dEUt4UuqBNsYAd2a1T0fPq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqZW3TYIk8mUbww2X56rdRiYQ1kQmld9u1n6GbTpTg6SYFV34Wd2W5yPxzvyVZxzV
	 tMfGdrOOvPSBgdqOpL5Jh4U0dRuOSMnOVV++80+mLxvhtqTjIDg5R39GcNLDi9G6x4
	 tU8Tj0JAf0HTrbnwdJm6+egaa2GOdbByhh0GudUB34l1JcqH6CEcAKiBFev1Xi33p6
	 Ze/LQqdtS5TV68EINoj92NayL9VyT++OvLb0QTcVkPKPgqggqqiwi3xuzU35fbYyhc
	 DycbK0ufC5na2iAcjOe7mEEH07v7fWcBDjstD51YK6I9oIOnjWaFgKKyl6w4Fn2evj
	 2/PhVn5BqG6eA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C405CE0CA7; Wed,  5 Nov 2025 12:32:18 -0800 (PST)
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
Subject: [PATCH v2 03/16] rcutorture: Test srcu_expedite_current()
Date: Wed,  5 Nov 2025 12:32:03 -0800
Message-Id: <20251105203216.2701005-3-paulmck@kernel.org>
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
index 318bea62ed3e..ea8077c08fac 100644
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



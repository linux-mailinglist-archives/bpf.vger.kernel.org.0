Return-Path: <bpf+bounces-70093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09ECBB0D02
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D6017113A
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB42304975;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r76KOMt3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573D303A20;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330119; cv=none; b=P4DNL9TfJJeBXZ25N7nv6nWDMpgf/BCmaVoYgwdrAC9HtVB01QegqY6xn71AwibXAao7GPslYMbxHrt/f/YPxTlZQJA+WPM46QAJ8LK23c3xRlzExIeJlM1muaHledyekp8uQaeds6sxt3wVMtUi9Js92exZz/TNYgWDwkgoga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330119; c=relaxed/simple;
	bh=H2Rpde2Lnzmi1rrKiEk9cEd+o18Lx4S73RaemLuL/J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzUXnmYtoVH0AmIl/2Yuk9ZEOZTc4H/GjrfGtWyHcy6ecL24bXRqqhaTtSQhIp4hROrX2DhT14wvZMpI4x8sdqfKMrOJPruqL7/jEANa6CsnFjspPWMdvPA+e8oAnPWh2EJey8gVBbaiB60rYzDHDb134rxTMHjY0DAbrCEW+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r76KOMt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53212C4CEFC;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330119;
	bh=H2Rpde2Lnzmi1rrKiEk9cEd+o18Lx4S73RaemLuL/J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r76KOMt33iJbGQvvJTCb2tOk0tL1Zg7UZS6SE6LrL8QWR1m5koA5xspEnh9nc5Zj/
	 h4RmJ7pIhFP/VP9nbsk2MrzRyyHIv50HhLUYFmwdpZs+G9kaWKSMvZDaSMhZmy7ghz
	 O17qTPZKhprfs/Kr20/n0lBDksxg2RDEQaLhhiI3ahcx8c1rb6KAZOgw3hyGGsWPmg
	 r/myOGTYt02w8oimpWnsEnNZ2nFDJX9kAvFvIEnp2cjO1HUDtLHatOn8uapDYzBJIn
	 nk7I98MWEnGWiq/vurOXIBuDl/KvXJWAwU3PlTVt5Z+TOakTrExR45I9fZWoAnXxGt
	 RfnaNmlZm/HXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 72A28CE11BD; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
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
Subject: [PATCH v2 07/21] rcutorture: Test srcu_expedite_current()
Date: Wed,  1 Oct 2025 07:48:18 -0700
Message-Id: <20251001144832.631770-7-paulmck@kernel.org>
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
index 485fa822b6a753..64803d09fc733a 100644
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
@@ -1698,6 +1706,8 @@ rcu_torture_writer(void *arg)
 					ulo[i] = cur_ops->get_comp_state();
 				gp_snap = cur_ops->start_gp_poll();
 				rcu_torture_writer_state = RTWS_POLL_WAIT;
+				if (cur_ops->exp_current && !torture_random(&rand) % 0xff)
+					cur_ops->exp_current();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
 					gp_snap1 = cur_ops->get_gp_state();
 					for (i = 0; i < ulo_size; i++)
@@ -1718,6 +1728,8 @@ rcu_torture_writer(void *arg)
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



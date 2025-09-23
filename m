Return-Path: <bpf+bounces-69409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CAFB96399
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B742A5945
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6053127F011;
	Tue, 23 Sep 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZNk3e/Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7225A322;
	Tue, 23 Sep 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637302; cv=none; b=koxUWOh0Fe4zFTbHyme44WDg2DVLxwVV+g1P61ZoA88y99e0SRjYpSkYzRIeLh0L8bATXbOFkLbfGooUWX0dYo7pEyIB15JDAJS8CcHfI/sehfaou2n0bH5BsKekK1aHbR5NKfZn//Sf5npwlV3QV9joHQx/4PktVcou2NcCq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637302; c=relaxed/simple;
	bh=H2Rpde2Lnzmi1rrKiEk9cEd+o18Lx4S73RaemLuL/J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huttp4icZAQHfrnumOMQHdYRZgpOhhYQTWthnjKB0ryuG3doAlpOj7gCc+zBRDDNZXwZKB/3y9nwa9knr0iYtTVhpqMQQed2FnT/nyIlmtmBcZ1scQ1hEkJpv/oRgzJI6vHfiTAeafvZzM871PnpdRLD85ehIZucZAWh5MrOc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZNk3e/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD378C116C6;
	Tue, 23 Sep 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637302;
	bh=H2Rpde2Lnzmi1rrKiEk9cEd+o18Lx4S73RaemLuL/J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZNk3e/YqvMbTZTSLqyol9n8i8uj4qcUOyZq6crGHGyjTnhSeORX279zXHZUxwx2d
	 VytjYuVy0eVDp4acvPYq6HYIGkPoyBsMiOJAflZ93fsaMb+WgSppR9yr6aKHuCt4IV
	 2SydQI98sh6uP4Y2zSJAekqCLLwjWPF+a6aCBee7YbUFtsgzbQC8Efpn2D106j+vv3
	 WC34d12o7agsARRC23Gxm7RpJJWBT538LlyWMSpNUYDrr7kZ+GvuJVQndI7/Azvt+8
	 k77SWufuZ9tKOrHro8uvj6WEa/XD/jueiKVaGiNtmEZ/FasjzYaP+zamjTtWFjLYTP
	 pt8xBHD3sHEuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01FB3CE168B; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
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
Subject: [PATCH 24/34] rcutorture: Test srcu_expedite_current()
Date: Tue, 23 Sep 2025 07:20:26 -0700
Message-Id: <20250923142036.112290-24-paulmck@kernel.org>
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



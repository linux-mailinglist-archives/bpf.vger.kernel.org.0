Return-Path: <bpf+bounces-73305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962AC2A476
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247813B313C
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44C29CB4D;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta9J2KOm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342D299949;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154352; cv=none; b=uyHCHzx9qTmJ+9ghmV+8JTqTxGzNC963G+3++zU0eURZWYHejTXOvL0ztvpHzgU5m4KEZ9dp6EQB6iwG5MNSJe2Y19gJPUsjv5y6tRGwYEA+2lpvwMF3igUIsSeE+J5/o5/6w6tY3Avz/6uMHlRD0gxWhPEammP6rRnt7HhitTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154352; c=relaxed/simple;
	bh=hiuAkXJp5N4WN5xE4QgqmeyHlsM9HdyJ3JawANTRqe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=swQ2PUQZgrddiMHAea5NmXSjdliUEqpmz9CoEBNSrh8qUX8GHOBP+zQLnnsOwSIQ2h8tl6cDXm/MPEFGCZFXR01wdj3JUmGQt7QcGZ1QIS6XZYeAAvn2rXFwpWgKlSbOOokCMxzre8VS1azURwXQ3zx5w1A0LSyee2YjLlmVfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta9J2KOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319ADC4CEE7;
	Mon,  3 Nov 2025 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154352;
	bh=hiuAkXJp5N4WN5xE4QgqmeyHlsM9HdyJ3JawANTRqe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ta9J2KOmcP0dE8kT6rHXaiZCUxjI6HCmKxmOxs+Uctq/FxFOVwOfwmT+6Fd6e38YW
	 cu0gtLntNkias2xFuULOCA7SrMeL6iQF9QYOfKRG92HVtc6mLB8Uy7I70BjLAgRr74
	 PyCcZrFbeWppvzWAYIdEq2oOiVhxaJZNd55oLNpnqT8bOET7tGN0AXm0xSP3jYxLnP
	 p5W3Lbp7ahOLme6SWFJnwIYXf6LMVKLIJSIhV8C9s/BshBMfLUZ+xGDYczABZAEWsl
	 zFf9Lt+BglAZNMhLXFHLtwgyMdElbG6vyGmLB8SeO285mPXBWGAmJG/khBLYo2NBZr
	 MGtqO2KBhW78A==
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



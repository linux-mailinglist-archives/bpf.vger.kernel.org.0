Return-Path: <bpf+bounces-69421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376FB96405
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCA1189205D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F032896C;
	Tue, 23 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra0kNFvw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF57327A28;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637315; cv=none; b=mkj8ds2pNHmRG1sEBtUxWvJkzy+EpD6lwJ1VxtJiO2IrMC5FkOvNyHFZurqN6Mb4Ei2+sCiIzxBmUVj/wGJJ9LADjpoebzaaMcN0ClQFOY1NkZ6qxzF2uGlMpQFL592mqS/G7zmVzG4hxPJ08cj0l9XVB0MuXKn8r78Z3bzVTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637315; c=relaxed/simple;
	bh=NiuHAgAJpC2TRweVL4XTZuEsRPP/Cvyb13DBOTQHKg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UqgRiVf2CPw8S8ujgXKqvNBuEGgZR7/1imXdiDi5IeAp/S1BdPh5vGz0sRh/39aw4OSmAZTZNuVxlpIf9YupiNH598PlrNSP3Oynh7JlCJQFmIZfhBkvTHWRECPqRw9lsqB4GUJ66TR8zeEp1nQ+nHcBAO21KC1w4D67DleGsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra0kNFvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9B0C116C6;
	Tue, 23 Sep 2025 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637314;
	bh=NiuHAgAJpC2TRweVL4XTZuEsRPP/Cvyb13DBOTQHKg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ra0kNFvw9LCjAKbmIOhztBvXixxP6dWztSS9jYD3y72qb9CiNmGz1U5bB/DWZcJAS
	 kQTSsSWkUSqgRGrnUPc323f94AuU4F/hBQwd/Cc0QXgE+56xvNxXIfUCHqUNqKertl
	 5GRBm/f18z0cJwH+flPGrtO6WS7sG8Pgl84IS+RAOAlTtPTmXvBPtACGq5APvrTAck
	 r5pFGq77/gW0Q4vo6L0tzT+US/sZqkCwIhNEhzxt5ksOddCzKufs5V4lFE0RtVYu3v
	 ekJR19lyktl+qU78SY63MwbiiH87VrWucn+I/DthLSHnOBeCpvYYsyYQBFCL1XwYjB
	 OZDO0hnMUE3Gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04BE4CE168F; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
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
Subject: [PATCH 25/34] srcu: Create an rcu_tasks_trace_expedite_current() function
Date: Tue, 23 Sep 2025 07:20:27 -0700
Message-Id: <20250923142036.112290-25-paulmck@kernel.org>
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

This commit creates an rcu_tasks_trace_expedite_current() function
that expedites the current (and possibly the next) RCU Tasks Trace
grace period.

If the current RCU Tasks Trace grace period is already waiting, that wait
will complete before the expediting takes effect.  If there is no RCU
Tasks Trace  grace period in flight, this function might well create one.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate_trace.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 7f7977fb56aca5..70231f95cd5e71 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -176,6 +176,20 @@ static inline void rcu_barrier_tasks_trace(void)
 	srcu_barrier(&rcu_tasks_trace_srcu_struct);
 }
 
+/**
+ * rcu_tasks_trace_expedite_current - Expedite the current Tasks Trace RCU grace period
+ *
+ * Cause the current Tasks Trace RCU grace period to become expedited.
+ * The grace period following the current one might also be expedited.
+ * If there is no current grace period, one might be created.  If the
+ * current grace period is currently sleeping, that sleep will complete
+ * before expediting will take effect.
+ */
+static inline void rcu_tasks_trace_expedite_current(void)
+{
+	srcu_expedite_current(&rcu_tasks_trace_srcu_struct);
+}
+
 // Placeholders to enable stepwise transition.
 void __init rcu_tasks_trace_suppress_unused(void);
 
-- 
2.40.1



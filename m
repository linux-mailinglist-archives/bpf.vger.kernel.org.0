Return-Path: <bpf+bounces-73309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA849C2A48B
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2B0C4EE0E7
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284E2BE644;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIr60mz6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE5A2BCF41;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=tAwYnIRv9ova56bkuoMT32btlvoNhALZex/lCcbTSKB1LQdrjmU9u//QD/GRX7WGOtLbSXVa7Uk83W/QHGNtvfubDQv1mwEDDfbGYrHpoLoVCSvFslqibpHhw9Mssq4vHtW+oVZlOL4hvgcac1G8/9gSVzSSuOwj3JRwMqd62Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=X/UrXsAEcy/6Jq6orEZM/DCRoejr5WUe52D6c7d8s1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Auh6qXguk9/WXz5Vi3EHyRXB+jK8hGYm+9yNRrYMX/4U50MYFH0pmEzIvaw7NGSL0a7RPzjGx54cft2V9KN39VowCZ/bdcAj7WJ1DUH99F8z8F4qu9ReIjO54kHGq6CYNfpweKLDgfAc4OCWbHH3B/QsaDloUFlMgHB83oXJ0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIr60mz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33114C4CEFD;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=X/UrXsAEcy/6Jq6orEZM/DCRoejr5WUe52D6c7d8s1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIr60mz6bAhZFdm2yABqAOUPAildyG6g+uY9gJEZ9XLnVWaTK8c9U9sd7n0kC/AjD
	 jjpaMK/JO3YNWYS+b6W9rDPJTTy7fKr/Wi/ytfUzLi7sX2K8yivdIwzc91WPgWyeeU
	 /2QYcW272I/f1ldHnTHnlTG3cruMhyORVTOfYcQZdy8niOwQ0mqYnTkyMlGFQCYhFA
	 p5p/b6hbvSQvaEBC56sW9aibHUpJ+1kf4YyGUrHAlJNbZW8nWdKO8l3Kozui1JYJk+
	 D9f/8CseVE3frboiXYLJ2uaVxVo2x694wmb1170EKF1ciHoY0yovVW/+EO3J1Mn8W8
	 yjLOotddGp1Aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C89D3CE19F9; Sun,  2 Nov 2025 15:07:01 -0800 (PST)
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
Subject: [PATCH 8/9] srcu: Create an rcu_tasks_trace_expedite_current() function
Date: Sun,  2 Nov 2025 15:06:58 -0800
Message-Id: <20251102230659.3906740-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
References: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
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
index f47ba9c07460..cee89e51e45c 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -184,6 +184,20 @@ static inline void rcu_barrier_tasks_trace(void)
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



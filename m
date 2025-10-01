Return-Path: <bpf+bounces-70101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D2BB0D0D
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D496F16A54F
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9520305E3F;
	Wed,  1 Oct 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csTgdgUS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE5303C8E;
	Wed,  1 Oct 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330120; cv=none; b=QEV3Ds1Skz2Z5qkme603le74Vngfyo8S+kcYpCqWLxPxYNNesVfJOdK8TV37p4qyuIH4Yo6Xz0cR7zSj9Nr5oRtpvnq8DFsEPnEvM/NKspv5LngmCdu9xXJ+h3lrFTSgKKS2uetP1vo1jJbFBrTpISZyq0AoCvnnQaJKUNqEFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330120; c=relaxed/simple;
	bh=tAtrCD0Q6r51wlJ/YZUSgYxDBqaTmpmjPK/LBZzejX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KV9topWwSRww8CBGkgoGc63KMF4hWuBjgS2WcfrMcL2WPFJMFxldctzaVt1j74zsonaRzVyDOPEqUU9Zi1GeqgUeSPjk/f3+3JHyc4qvV6HVfT/XTgSY9xvvl7xJrEC4sFQQLx0V7j4npISMZMEhmLf2dz16+L4fWFmj12xkS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csTgdgUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94989C4CEFB;
	Wed,  1 Oct 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759330119;
	bh=tAtrCD0Q6r51wlJ/YZUSgYxDBqaTmpmjPK/LBZzejX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=csTgdgUSMTy232HN+CTaEbv4J1Xi+gxUOITEFgFKGEAXeTFWSYXivUcBiiaMWKNO6
	 L/DrANeKLzG55seYzDAUNBzMgZCBMdSdSKaeAloQhD7gZLdRJEiLz7UXBYEoQsQV6O
	 JVVv38BECH+91AugcmcSGEEP+zJ18mnG4mm0IU9pzVtO5r8a1uC6VAjhOlKstZg4kp
	 DCP5cpX5qHOu/G5MeHxZSi72/o6oFozHlGcV7jy5psjJDQFPpSEf1SQo2PodWH7TOz
	 PY2gZxfu0WgF1ZLAzkLWwUgs2I4xZTJyWK2GUY8vORtMj8h0T6NiYht569BeQVDh/H
	 5QdA796+ihPGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7FDBECE1427; Wed,  1 Oct 2025 07:48:34 -0700 (PDT)
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
Subject: [PATCH v2 12/21] srcu: Create an rcu_tasks_trace_expedite_current() function
Date: Wed,  1 Oct 2025 07:48:23 -0700
Message-Id: <20251001144832.631770-12-paulmck@kernel.org>
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
index f47ba9c074601c..cee89e51e45cbb 100644
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



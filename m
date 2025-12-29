Return-Path: <bpf+bounces-77481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA6CE8018
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 20:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0849730019D4
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7959D2BDC0C;
	Mon, 29 Dec 2025 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKdSoCCc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D6274671;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035467; cv=none; b=sf1uCP3G5QtAc3M5th/BLP+rlcbjJbfN2B2c3GAahZ6sTafn+7TyDHZEx6mJtfTu6yMS3iaVvGf5YFg/CNKDH/A6WhOOEPM6qNRe0KWm9N/doTp+u14y3dbAhj//ASJTmdg/kXILl1GYURBdiqnRYCLCYYAg6vdrVTY4/sB5YbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035467; c=relaxed/simple;
	bh=cPP2uxUbUwhnZIVIHEGQUBtpGHQ7pekEysBIW2q62FU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UnCIAbt8GIb1X+Ipo4ZjceV2+P2PMifdN0jmoIRixO/c4TrUkFJG0vrTE/0agxuxoHNQiYrX8euUqaxlikqa0dDtjF26MDqG3Hk+KsxDwPps1FvCctf9O+F6shRMn/b+3hvriAD5mTSbbLB9Z3bZ3bVeuVFiqtA0JgwMIcFyUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKdSoCCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39187C2BCB6;
	Mon, 29 Dec 2025 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035467;
	bh=cPP2uxUbUwhnZIVIHEGQUBtpGHQ7pekEysBIW2q62FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKdSoCCcJcjXZntNLz69qz37Ix9/0AH64kd0KU1xOw7Tkiz4tB/c3qnX9Phn38aQK
	 d4PqagTAzkhGdiSnOlTdp4/8DqxapZBqXb0tFBBnsvHxg2RC1c5xc/6PSXpovlu8LJ
	 7SiWuPvULjo4X9PK9Q75MD3lMY3cIynD5gC+SgRHG6Fs5/SaX+GjDSCJnwqQ5Xf9XZ
	 e/f1H2eEhpRZATufiUbOkRAXMQG96/cXQoCPysxf6OZbM+ZR8iMl6BaamUtjE2P+PY
	 QXJn1vDkmChMZLcU7w1i3v6his49CdGu6o//MwU8e5luiENCXkRgcOsU5PcsIjppMU
	 zfJzTfhQ/RQpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C3DCCE1148; Mon, 29 Dec 2025 11:11:06 -0800 (PST)
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
Subject: [PATCH v4 8/9] srcu: Create an rcu_tasks_trace_expedite_current() function
Date: Mon, 29 Dec 2025 11:11:03 -0800
Message-Id: <20251229191104.693447-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
References: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
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
index f47ba9c074601..cee89e51e45cb 100644
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



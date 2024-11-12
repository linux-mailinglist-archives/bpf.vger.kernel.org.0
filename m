Return-Path: <bpf+bounces-44640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19D9C5C0B
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F0B833B9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F4E202651;
	Tue, 12 Nov 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXoJnIX9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDB1FC7FF;
	Tue, 12 Nov 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423180; cv=none; b=iDsXcaNgYEGY7qwCyZLB7dPTPapjsc8kvX4dv4A3zh3oe79USoIACwXyv5kKlXg1Dyfak9oV9Kyc3oAhMMF7YHkrY66C08Xtnq8URaC4pPbXkYJ5CnA27ghCrpGxqeV7HqwKwGBrmihU/EJdfwuu6/Ou+GjXARvLqc28FEqsvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423180; c=relaxed/simple;
	bh=89PLNAGurys0mJBxDA/ZpZpRTaoDP8T4R09w6xw7TlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUELgmAT3zjCHc9M568NuinEdiESeyqX83ceOo84vHrwfO35XlaphvHbBhfOrj+lL0CmMKj3mkz9YSdEbRC3ewCMx+QyZ+N8s7W8rwDWwr5Y+6ZjE7CvhwNBKxiQd+V80Ho6PwJdSl7iseECAGrFvk0l5vGns4tc8YF8rlz2oUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXoJnIX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36055C4CED8;
	Tue, 12 Nov 2024 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423179;
	bh=89PLNAGurys0mJBxDA/ZpZpRTaoDP8T4R09w6xw7TlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXoJnIX9pE8GJIgPVMl6V0UxchgE3PpNmtPgDuER5xM7+oAv98KyfhztiNFbZvv3I
	 Gv0irBUQjJBkLD4m7c/aTcktoCrfPCtma5YaS6M9/8jEVVaRmGA03wbFM5L8p+kxCy
	 MU6yC1wN3RSeXo7B9TEfOySx1wsZ3wSRgBQVCGTYdgC+jfYgszTra20vOzefUoFiZ1
	 HSyvwVjm2nfHA6sQsF/9SfYYR2/8QIzn6VVBWVOYfhOXMfEPsYLMspw4nnPkHRpBRO
	 afw7nCn2A6tIfzPqNzwqFmZ/wjhDS9BibAJxmTLZK5fYaIqr90NCZqDPMgugY9KUtz
	 fJ8B3OOOOX2lA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 13/16] rcutorture: Add srcu_read_lock_lite() support to rcutorture.reader_flavor
Date: Tue, 12 Nov 2024 15:51:56 +0100
Message-ID: <20241112145159.23032-14-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112145159.23032-1-frederic@kernel.org>
References: <20241112145159.23032-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit causes bit 0x4 of rcutorture.reader_flavor to select the new
srcu_read_lock_lite() and srcu_read_unlock_lite() functions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 kernel/rcu/rcutorture.c                         | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 52922727006f..203ec51e41d4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5431,8 +5431,8 @@
 			If there is more than one bit set, the readers
 			are entered from low-order bit up, and are
 			exited in the opposite order.  For SRCU, the
-			0x1 bit is normal readers and the 0x2 bit is
-			for NMI-safe readers.
+			0x1 bit is normal readers, 0x2 NMI-safe readers,
+			and 0x4 light-weight readers.
 
 	rcutorture.shuffle_interval= [KNL]
 			Set task-shuffle interval (s).  Shuffling tasks
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 405decec3367..a313cdcb0960 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -658,6 +658,11 @@ static int srcu_torture_read_lock(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 1;
 	}
+	if (reader_flavor & 0x4) {
+		idx = srcu_read_lock_lite(srcu_ctlp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 2;
+	}
 	return ret;
 }
 
@@ -683,6 +688,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & 0x4)
+		srcu_read_unlock_lite(srcu_ctlp, (idx & 0x4) >> 2);
 	if (reader_flavor & 0x2)
 		srcu_read_unlock_nmisafe(srcu_ctlp, (idx & 0x2) >> 1);
 	if ((reader_flavor & 0x1) || !(reader_flavor & 0x7))
-- 
2.46.0



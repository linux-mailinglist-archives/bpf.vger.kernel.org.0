Return-Path: <bpf+bounces-42071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DABE99F265
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7EC1C211CF
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74B1F9EBE;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3+axXn8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86F1F6669;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=DCSW7UKaSmSFBCVj2ctOGoXewqQEuqHbahwkzXaDDLqhOvUa1nOOptSUBBjMW1xdaWKuKNavERIRN+PSLwkee1hG7prrU0qyau72AUgl8tYhrhR0ome5Mr8l3UNIRMu8mYIhovK44W23K6xRm4RKdxMd8vi9No6xc9g1SUYBakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=Z/WQbE3a+ONF2RNiITyp4EEPiF50o0VFDZsBDE5/WuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cGuYcTlCwx8ngaoUKoPb8KoIyUqNODq3BBzW8fqozuwt0BxhJJBbrcz7IO4ZmN/GsxMpB+lFvMDBiR1MORr/R/Ec5d6np4F4XYeVo4We7G7QVpHRkaGfUSGHwDmB5h+M6t7u2Qp7J0eeceZfgWSjixCav7DjvjL9TOXW5p0h1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3+axXn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3380EC4CED3;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=Z/WQbE3a+ONF2RNiITyp4EEPiF50o0VFDZsBDE5/WuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3+axXn8xZbsDAU/0tCSbP0XWS+pig7dbTb/J7BJ5mBb5X4TnbB/qCAgEj+tFQWUC
	 G0cjmvub+tfkwxceKo7nrBT/AAAnqOy20DFGAithOjS7h292xNJUyp20croHhzOmWn
	 xaIL2BmFwfw27HPXvQ/SEjq47VjzRpd1mdenl9UZ/QMlHRidh/XsoViVwyKnb/I2we
	 JPRiAT2Muu2Mcz/+QdwsgZ7+mMpArMVSD089PDbXLOfyydpQ8EzaAC5ME7J6CeYcqK
	 fakIQ9cJI4I4tRFusceq3yeBbcpalD+NJF3jX16yZNSxXwJ4aEFSLTBR0R+UekJW8K
	 hCPY85EHn4Upw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BEA68CE0FAB; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu 05/15] srcu: Standardize srcu_data pointers to "sdp" and similar
Date: Tue, 15 Oct 2024 09:11:02 -0700
Message-Id: <20241015161112.442758-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit changes a few "cpuc" variables to "sdp" to align with usage
elsewhere.

[ paulmck: Apply Neeraj Upadhyay feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 kernel/rcu/srcutree.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index abe55777c4335..1e6abdf22c881 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -438,9 +438,9 @@ static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_lock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
 	}
 	return sum;
 }
@@ -456,11 +456,11 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_unlock_count[idx]);
+		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
 		if (IS_ENABLED(CONFIG_PROVE_RCU))
-			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
+			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
 		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
@@ -564,12 +564,12 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
 	unsigned long sum = 0;
 
 	for_each_possible_cpu(cpu) {
-		struct srcu_data *cpuc = per_cpu_ptr(ssp->sda, cpu);
+		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		sum += atomic_long_read(&cpuc->srcu_lock_count[0]);
-		sum += atomic_long_read(&cpuc->srcu_lock_count[1]);
-		sum -= atomic_long_read(&cpuc->srcu_unlock_count[0]);
-		sum -= atomic_long_read(&cpuc->srcu_unlock_count[1]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[0]);
+		sum += atomic_long_read(&sdp->srcu_lock_count[1]);
+		sum -= atomic_long_read(&sdp->srcu_unlock_count[0]);
+		sum -= atomic_long_read(&sdp->srcu_unlock_count[1]);
 	}
 	return sum;
 }
-- 
2.40.1



Return-Path: <bpf+bounces-69995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFACBAAFC4
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 04:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E19189A374
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04121ABAA;
	Tue, 30 Sep 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK3TA40B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E261FCCF8
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199064; cv=none; b=P211gDnwM9u0Jow52eB01gzh2BYzjCFDp293l90dyakFOAjo9rGvwludh2JKw2U3Gd+uVuo6U8Dp7JsPcTb6UU17CoVNu0IjtKERHP8jxRHEyAK/WEXnLTAbJLsH92gfnvFE5yDvBEbRvRRQDVZx1q4tf9NZbIcxGcIsO1xnBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199064; c=relaxed/simple;
	bh=RIksBLbV/NDNdHIPG7pRJpeOwdzY6lHsOG43qj5mi3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duqFj5VYAWFnUgU8IhQ4IwXGnj53qxsUOadEKs8KNrovAIppiSxg0dFayE+JXXq+zNi0q0au5K4+Sr6rA5XSjfJYH+4Uv+MVI1HmkJCQLSuS5ssFYlQ6WmoX0I62I8sGsNPHhSU8r08mlJmgETCWAkrFmaisy51F74q/87CrJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK3TA40B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698e4795ebso56407085ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759199061; x=1759803861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xA5fivf8dJ1hjHLD2sDhk5L09zUdQNO3KR6rV8Hi0U=;
        b=bK3TA40B+C8qt0ZJubCHo5x8+B4K4ibfhsCnSgVQveTn+mxYWHR4y2Jy18kiN0+L13
         6jHu6qYXfpE+oz43SXDEy+giSEhopzCPor7IQv6TXznz/TQ0cvMqXrVPJuSjnHaaaRdU
         oSKseUwDv+dQ/VlM/YomqK3TGWJwa1ChZo5FPcMOW3oXgam742RMyxDllwsl1/Qs+kCW
         Z0UMSzh8sy85zX6LOmrN8k0kI0PcSu4/nrbO/5bywfrWHN/Wa6ppFNU1gKsyPdun9d9O
         xigUSt5Xlsuuj7+LmbCwWq3ysUdxTv88PbABcSezhTFKYnyLJpe/ip87rseNeda4+d43
         p0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199061; x=1759803861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xA5fivf8dJ1hjHLD2sDhk5L09zUdQNO3KR6rV8Hi0U=;
        b=Cz8n6CnjBcuutNjz25oKEoPZVoTuT+y+IXDelz/h0M1T7lRDqpTy2pbKRu4Ragmix3
         pLCb9wKmYIPGfedFRr8IdaWIg5SQ17ea9JiWFrX1iKYmNSEdcyGQgS0KLKX2JpmGiY/j
         UnhCwdW8cl/+SHx8JNvvrdpoMonZmqA5bEf6vFwGM+/kWLMEv2DRJzwHBCR5g6mB3Nck
         4CEM2s0shGb1bUpw6qLIWFKEmxMPh1NRCxtg3GrXmMlCGwUf9YL0AoDWE3oseuRp4pvn
         9VhclskPC2eg923vV1qo+5z7Y880NNSVvreoiin/xYz1C37eER6NqQh9Ivf6BUAUkoDJ
         qURw==
X-Gm-Message-State: AOJu0YxNj5qccWpuuCQ6faloKx4KHncc1iovI6Zd/QADIW8lMlQ0u/yX
	M5UmbxTOrvdDkeclWdwXjesGpZxDKDhB9oJFDJt33Uom+5R1SmnQwtQ1b7t6Pw==
X-Gm-Gg: ASbGncuD0pi4w4XV5Aq1ZeHiIz9RzSYaFL8F0KY4+i378BW1KuDgSkwnTlvM9X8fu7U
	/NMlFn9hS7IO+CcTBt4QrMCXBj81MjXoNqD0eE8Fam9/E/TSC73sa2plNCWbLn0xj4+JSL91UGi
	odbbKWMUZqJKV68u0BVpvJCPY+5duIOqNbRG42cuDPuo9k14xfi8DsGqDzpn7bmfH2zawddgvLs
	ByJEHNs9tsKRGp/mimdZ82QALql3jFxBgKQE5KPwooHioTrCoN2UBUcFKjyrI/c6fHLVwIr4KfT
	K4rCVtibNOGwP1/vN1v2DUvzgqiqsWUK6cxiPo4uupRcZg7TnE95/SQZ2uUuyMS3a4ek2ueejZh
	m1wZkt22SKPalEnFW/PJWniveddBOxmtYCkE7niAOO7sXzBHBVHquDBamypYRbE1EGEfGi3NAcC
	N+J06rm7EhDbyRCxzUWTeW5DnQFIIxd0Q=
X-Google-Smtp-Source: AGHT+IGN19FiQJbxyBeWRBskqizC3mECfG8M4u81kulPg86rE/h7D0aMmKrNrHyP+EagMO5XF02E8g==
X-Received: by 2002:a17:902:d60f:b0:267:cdc8:b30b with SMTP id d9443c01a7336-27ed4a873c8mr181525855ad.53.1759199061393;
        Mon, 29 Sep 2025 19:24:21 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be14760sm18541289a91.13.2025.09.29.19.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:24:21 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	rjsu26@gmail.com,
	miloc@vt.edu,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [RFC bpf-next] bpf: Add deadlock check at the entry of slowpath for quick exit
Date: Tue, 30 Sep 2025 02:23:54 +0000
Message-ID: <20250930022354.16248-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single deadlock check at the start of slowpath function
enables quick deadlock detection. This additional check don't
create any overhead because same check happens in both pending
and queuing cases during contention. Also cleaned up the unused
function args in check_deadlock* functions.

I've checked the resilient spinlocks cover letter for benchmarks
to run but I couldn't figure out the link to run those benchmarks.
Can you point me to those benchmarks so that I can run that with
this change?

Fixes: a8fcf2a ("locking: Copy out qspinlock.c to kernel/bpf/rqspinlock.c")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 kernel/bpf/rqspinlock.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index a00561b1d3e5..6ec4e97a73a2 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -89,15 +89,14 @@ struct rqspinlock_timeout {
 DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
 EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
 
-static bool is_lock_released(rqspinlock_t *lock, u32 mask, struct rqspinlock_timeout *ts)
+static bool is_lock_released(rqspinlock_t *lock, u32 mask)
 {
 	if (!(atomic_read_acquire(&lock->val) & (mask)))
 		return true;
 	return false;
 }
 
-static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
-				      struct rqspinlock_timeout *ts)
+static noinline int check_deadlock_AA(rqspinlock_t *lock)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
 	int cnt = min(RES_NR_HELD, rqh->cnt);
@@ -118,8 +117,7 @@ static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
  * more locks, which reduce to ABBA). This is not exhaustive, and we rely on
  * timeouts as the final line of defense.
  */
-static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
-					struct rqspinlock_timeout *ts)
+static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
 	int rqh_cnt = min(RES_NR_HELD, rqh->cnt);
@@ -142,7 +140,7 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
 		 * Let's ensure to break out of this loop if the lock is available for
 		 * us to potentially acquire.
 		 */
-		if (is_lock_released(lock, mask, ts))
+		if (is_lock_released(lock, mask))
 			return 0;
 
 		/*
@@ -198,15 +196,14 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
 	return 0;
 }
 
-static noinline int check_deadlock(rqspinlock_t *lock, u32 mask,
-				   struct rqspinlock_timeout *ts)
+static noinline int check_deadlock(rqspinlock_t *lock, u32 mask)
 {
 	int ret;
 
-	ret = check_deadlock_AA(lock, mask, ts);
+	ret = check_deadlock_AA(lock);
 	if (ret)
 		return ret;
-	ret = check_deadlock_ABBA(lock, mask, ts);
+	ret = check_deadlock_ABBA(lock, mask);
 	if (ret)
 		return ret;
 
@@ -234,7 +231,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
 		ts->cur = time;
-		return check_deadlock(lock, mask, ts);
+		return check_deadlock(lock, mask);
 	}
 
 	return 0;
@@ -350,7 +347,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	struct mcs_spinlock *prev, *next, *node;
 	struct rqspinlock_timeout ts;
 	int idx, ret = 0;
-	u32 old, tail;
+	u32 old, tail, mask = _Q_LOCKED_MASK;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -359,6 +356,21 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 
 	RES_INIT_TIMEOUT(ts);
 
+	/*
+	 * Grab an entry in the held locks array, to enable deadlock detection
+	 */
+	grab_held_lock_entry(lock);
+
+	if (val & _Q_PENDING_VAL)
+		mask = _Q_LOCKED_PENDING_MASK;
+
+	/*
+	 * Do a deadlock check on the entry of the slowpath
+	 */
+	ret = check_deadlock(lock, mask);
+	if (ret)
+		goto err_release_entry;
+
 	/*
 	 * Wait for in-progress pending->locked hand-overs with a bounded
 	 * number of spins so that we guarantee forward progress.
@@ -400,11 +412,6 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		goto queue;
 	}
 
-	/*
-	 * Grab an entry in the held locks array, to enable deadlock detection.
-	 */
-	grab_held_lock_entry(lock);
-
 	/*
 	 * We're pending, wait for the owner to go away.
 	 *
@@ -451,10 +458,6 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 queue:
 	lockevent_inc(lock_slowpath);
-	/*
-	 * Grab deadlock detection entry for the queue path.
-	 */
-	grab_held_lock_entry(lock);
 
 	node = this_cpu_ptr(&rqnodes[0].mcs);
 	idx = node->count++;
-- 
2.43.0



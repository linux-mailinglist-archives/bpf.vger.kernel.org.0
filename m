Return-Path: <bpf+bounces-54124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9898DA6338F
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806891892C57
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50518DB15;
	Sun, 16 Mar 2025 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw5yRFKh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAEE188734;
	Sun, 16 Mar 2025 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097958; cv=none; b=h4VMht2pProLtiD60TkM9RDkXO9EvDFQkMYPqp2PQUr6YY0sgaG0prDXsflarJumWbWQ5VKQi+XaCgxZZo/1kfdVDS6xGVGAg6vJ/0BPyfsMwmJxvia5Zbq5yiNuwP1aIbk3zzQWaTdcxe1NsR01QQhUT4Yzo8e3qwr6bn1s83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097958; c=relaxed/simple;
	bh=akh5yhXfrEG7tkbyObFzFj7wBccI2uw5HAmi9Ua2XD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTazneyGhAhRlDZVE4Tg5nz8SQ4j9CZSxRyCUu64Vl+2p3oaRgvjjJD1jj7Jx1p8QhHdBMQhQNo6vxwCV/rtaypqnIauUi7rZFn0n4UDdRJHHIjMV6m8l06JyNWpgEs3qpkQWFjFQ9DeS1fBvkge+5oKBREKsJ2sNJvbQooyojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw5yRFKh; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4394a823036so9985645e9.0;
        Sat, 15 Mar 2025 21:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097955; x=1742702755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZSlxIaXESbScuJYNNT7oHLcn/yU5dVEPTh1HXSGjKY=;
        b=Vw5yRFKhKi4Ns1GT3sI1uUIX9p+aMtEXIASkFHlkb7anms20qR+cbk+jtldG7Y8laY
         PwG1rbiatiS7sK0TBsArqGX3YQ95Apu1E9gs+axOF6HantmWcFCkJi5Hx5yNpdDzf/Uu
         rO56+EtnnDwl6ObUbCrvE+2mGRsfKAJpY+iCC7S5uRpYMCvCIIe6qyCIf0Ambnjd44b6
         PLcnaV9cPYh5PbJCPp/21KLvApI4mfQ8d83AmU5zTVnlYQpGJe38qIuJ7U/wejDnVl9G
         maiVSCg8ODZZiNC+PwmM/w46bZmemZ8S9/7+fdNBiRyCFJTPeH9uKTw6VzZX+VwcFUrO
         MgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097955; x=1742702755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZSlxIaXESbScuJYNNT7oHLcn/yU5dVEPTh1HXSGjKY=;
        b=W520b0hZV0gWTUihV+7+ZJ1dJotUWg9KfuAil/9eEBuyllJIdHHveF/vjM6NsRk0hM
         KgrvMj1q96tdWVGLp9sOaA3nBcGp5HVfYdj1eg1MHstUrZIQ86T18vnpAsBbBZlZQF/D
         ghff3Nil2+4i9T1KxYtXeaQO4a/91A7Bqzl6OwbrVdhxBULcdnMxG3O3t/osi4yE3ZQH
         RN77W6gbviCcHmSUsnN1Pfx8tLAAAX3e2CmSIqJTgx8ACTLlZPXj8MM9yC+hD0CLFeQZ
         F5OIDI8uZoWYkwSKCZtGaty6+I712xkadHS0HgvGeA0HEw713rjQCVDD/Hg/wSV4WIXN
         ZE7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUjkGyxJ+8Skz1I411YPKazmh76L69em83h2gBbKoApinQe6sRBXXDPMBWEY/I7pcyNLpwV0rkb0YNuAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfpd8dNZGYPkLv8wwjW5x1Gq5VJPmRKZgI6G5eH831Z5h25vwG
	Kp6y9SnIbtC89CEjPaH4+c7R4e3MDOuWsBCdZS44u29XdhimHsX8nl3F2ZiPrtk=
X-Gm-Gg: ASbGncs0VpVWnO7w3bzxWuB/AOdGY+fTTtTx4pJMOy37TV/47XejkjiK3nPET+zTWDC
	H2UPN7NCMh+8bdeVps4Pm0OsVx4NmoTya9UmhFI6NhvSO88Vr6oPqvGfrg8WCF2g7ANPjr8d/es
	Sg8MnP7hn/QALBoxa+7ZNU/Zs+RA9Zl/KnG8li+btdrfiUYOEPBhIMC4hM4NPoLA8VTZCd0Rq6+
	OYxwWFTM7klCQmVRdn1oV4tDLdwCU2zSZ28cmkp7CyXwBq+Ecu91bWqhqGTqe/4hn8jDOFWRD1F
	vXCVt354Ns8Ha7IZJ8LbbTb/nraJhYHEESo=
X-Google-Smtp-Source: AGHT+IGXqKHvuoBJmJkfw5Qx4e5pyHmiy2Na/MLB4Z1m2JlcO42ipiA1BkRJPFk9pYLAuBnL9gK5Ng==
X-Received: by 2002:a5d:588b:0:b0:391:1213:9475 with SMTP id ffacd0b85a97d-3971d8021e7mr8853463f8f.24.1742097954718;
        Sat, 15 Mar 2025 21:05:54 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a5esm10682902f8f.27.2025.03.15.21.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 09/25] rqspinlock: Protect pending bit owners from stalls
Date: Sat, 15 Mar 2025 21:05:25 -0700
Message-ID: <20250316040541.108729-10-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5013; h=from:subject; bh=akh5yhXfrEG7tkbyObFzFj7wBccI2uw5HAmi9Ua2XD8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3c4jSnmA5ONpoVoAIOIOlsxwJqGlCaF71ZqrDS 9f300ICJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3AAKCRBM4MiGSL8Ryj+AD/ 9QOKlJQsL0hfRsxlnp+LcUhoinUUhuf5PSUgCRTOdkG5asYnxKe4RE+k6QEZqq50n7HbKHjFsdfrSv 5px/fRWV280XEsplziWpBm3nu9/uGIn06D/6DArjzNdiOULmNoKhIVTCdpvva8L3HI7GSTxZani9n6 MMd1j6C8TM9+oKJsg31rq03joUCbrTzttht7zSk0WcHYwGmbbQNFYepfby2aIG6QR4whRiRfFigmjD 1nOdu68WNCp+zFeB5UwD1SKNXHXAiI47mTVfHATyZW2gO+qoVjxj0jcjEQISr2U7ilsZqhtUV4qu79 0rmI1TdWYDffcf35yEPkekzca8OUaen5puFYbpAn2C5IQghtsvhiDeLpI+qrW+Dh9VrVLfJeZb4PA/ CmKe2nkK73+vP66V/atyI3Nop6a65yKO4dVVKbSm3r6dXZdycqN3CO6uWPWXasVJOnEwagR0GKKcHV 5lNkIep13oO1YQkgmpMqkC4RCf6IhbIwCFAm6j9Mt+0TJyAB8WHcAIwetF6IDcyMBK5R+DiMlKafao b9h8GkivtSiN4L7TcMtqek4PinmZ+hoaj24dkKmwfoF1g7gqEI1D1SHHR9nGA/BtBKsGojUhnVbY1O sUkCihUbg8MADno6l9S45vaZux7YwSBu0+kqCFmosGJEUxcqTgLWNTqfWjaA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The pending bit is used to avoid queueing in case the lock is
uncontended, and has demonstrated benefits for the 2 contender scenario,
esp. on x86. In case the pending bit is acquired and we wait for the
locked bit to disappear, we may get stuck due to the lock owner not
making progress. Hence, this waiting loop must be protected with a
timeout check.

To perform a graceful recovery once we decide to abort our lock
acquisition attempt in this case, we must unset the pending bit since we
own it. All waiters undoing their changes and exiting gracefully allows
the lock word to be restored to the unlocked state once all participants
(owner, waiters) have been recovered, and the lock remains usable.
Hence, set the pending bit back to zero before returning to the caller.

Introduce a lockevent (rqspinlock_lock_timeout) to capture timeout
event statistics.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h  |  2 +-
 kernel/bpf/rqspinlock.c           | 32 ++++++++++++++++++++++++++-----
 kernel/locking/lock_events_list.h |  5 +++++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 5dd4dd8aee69..9bd11cb7acd6 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -15,7 +15,7 @@
 struct qspinlock;
 typedef struct qspinlock rqspinlock_t;
 
-extern void resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
+extern int resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
 
 /*
  * Default timeout for waiting loops is 0.25 seconds
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index d429b923b58f..262294cfd36f 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -138,6 +138,10 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
  * @lock: Pointer to queued spinlock structure
  * @val: Current value of the queued spinlock 32-bit word
  *
+ * Return:
+ * * 0		- Lock was acquired successfully.
+ * * -ETIMEDOUT - Lock acquisition failed because of timeout.
+ *
  * (queue tail, pending bit, lock value)
  *
  *              fast     :    slow                                  :    unlock
@@ -154,12 +158,12 @@ static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
+int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	struct rqspinlock_timeout ts;
+	int idx, ret = 0;
 	u32 old, tail;
-	int idx;
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
 
@@ -217,8 +221,25 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * clear_pending_set_locked() implementations imply full
 	 * barriers.
 	 */
-	if (val & _Q_LOCKED_MASK)
-		smp_cond_load_acquire(&lock->locked, !VAL);
+	if (val & _Q_LOCKED_MASK) {
+		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret));
+	}
+
+	if (ret) {
+		/*
+		 * We waited for the locked bit to go back to 0, as the pending
+		 * waiter, but timed out. We need to clear the pending bit since
+		 * we own it. Once a stuck owner has been recovered, the lock
+		 * must be restored to a valid state, hence removing the pending
+		 * bit is necessary.
+		 *
+		 * *,1,* -> *,0,*
+		 */
+		clear_pending(lock);
+		lockevent_inc(rqspinlock_lock_timeout);
+		return ret;
+	}
 
 	/*
 	 * take ownership and clear the pending bit.
@@ -227,7 +248,7 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	clear_pending_set_locked(lock);
 	lockevent_inc(lock_pending);
-	return;
+	return 0;
 
 	/*
 	 * End of pending bit optimistic spinning and beginning of MCS
@@ -378,5 +399,6 @@ void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * release the node
 	 */
 	__this_cpu_dec(rqnodes[0].mcs.count);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(resilient_queued_spin_lock_slowpath);
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 97fb6f3f840a..c5286249994d 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -49,6 +49,11 @@ LOCK_EVENT(lock_use_node4)	/* # of locking ops that use 4th percpu node */
 LOCK_EVENT(lock_no_node)	/* # of locking ops w/o using percpu node    */
 #endif /* CONFIG_QUEUED_SPINLOCKS */
 
+/*
+ * Locking events for Resilient Queued Spin Lock
+ */
+LOCK_EVENT(rqspinlock_lock_timeout)	/* # of locking ops that timeout	*/
+
 /*
  * Locking events for rwsem
  */
-- 
2.47.1



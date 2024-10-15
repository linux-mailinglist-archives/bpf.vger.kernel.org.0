Return-Path: <bpf+bounces-42073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE499F26B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 18:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9521C21043
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761F1FAEF5;
	Tue, 15 Oct 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5vjrp7n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4851F76C6;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008674; cv=none; b=IvY6f3NWJuatMD0OLLlB3B7JDeRmzaRFG04/dixJwXnqIllSRqmCm91TkitwM/WfkOlq4nPlveQF/vCBJ4z811uH5/WGHNUygyRaGdkK+5BQy6yiUmV9Q4WFq/dWOqkjdCziWrw4nlpk65jaC933F82Rz5gy9DZrOWCyejJqO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008674; c=relaxed/simple;
	bh=26EP0pZI8PBKRVZdpQWBFbg5cAeS6s6sKXo9twbwLTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWAi1l/uIHmPnZQkNGmzDLbKPtjFUwaBe5YEgSxg01uUb3Cuz2Bmks3OjI1uaGTt0YXwueDKhMuH9IFC8Ye9pBuv+gW8/YqgPmgJdB4YjHcCBUD89W/nStaf++p4DRbpcMEuua61gJq1qppxnWlqrALZmziOXqEi0FU6cmAofhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5vjrp7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C059C4CEDE;
	Tue, 15 Oct 2024 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729008674;
	bh=26EP0pZI8PBKRVZdpQWBFbg5cAeS6s6sKXo9twbwLTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5vjrp7na9XP5kDbyfjxoYa+3p6xYTWVq8N/+8pbCSRuxmqqXKwMs3QvBxHBTA57u
	 ulJB1TLF1HcRI6s209q4yxaUryB9m5yB8D6f+4SyEtAWM0jUGXt9yV3UVRHBM6IwtW
	 L9yJo4/0+E2DvJ9ViRIZIm+fuDVJcivQo8z1Ge2r4P8iHy+7IqvId+CBpfnqQLBsmA
	 biLKkGevQd6tUCX2g2wb46QUr9/Zdc4IFS4h1K/0kUPdswky5QpWIbg5yD//rHAL4C
	 t+OqSRsHxPhVxFA9juT8uZCy3fArP9N71JM9vY5BAyGk61lyi1bdUAjv9wTAkSFtAd
	 /EE0HzewLCNEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C4179CE1189; Tue, 15 Oct 2024 09:11:13 -0700 (PDT)
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
Subject: [PATCH rcu 07/15] srcu: Create CPP macros for normal and NMI-safe SRCU readers
Date: Tue, 15 Oct 2024 09:11:04 -0700
Message-Id: <20241015161112.442758-7-paulmck@kernel.org>
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

This commit creates SRCU_READ_FLAVOR_NORMAL and SRCU_READ_FLAVOR_NMI
C-preprocessor macros for srcu_read_lock() and srcu_read_lock_nmisafe(),
respectively.  These replace the old true/false values that were
previously passed to srcu_check_read_flavor().  In addition, the
srcu_check_read_flavor() function itself requires a bit of rework to
handle bitmasks instead of true/false values.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h     | 20 ++++++++------------
 include/linux/srcutree.h |  4 ++++
 kernel/rcu/srcutree.c    | 21 +++++++++++----------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 46fd06b212baa..84daaa33ea0ab 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -176,10 +176,6 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
-#define SRCU_NMI_UNKNOWN	0x0
-#define SRCU_NMI_UNSAFE		0x1
-#define SRCU_NMI_SAFE		0x2
-
 #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
 void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 #else
@@ -247,7 +243,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	retval = __srcu_read_lock(ssp);
 	srcu_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -268,7 +264,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, true);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
 	retval = __srcu_read_lock_nmisafe(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
@@ -280,7 +276,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	retval = __srcu_read_lock(ssp);
 	return retval;
 }
@@ -309,7 +305,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
 {
 	WARN_ON_ONCE(in_nmi());
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	return __srcu_read_lock(ssp);
 }
 
@@ -324,7 +320,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	srcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock(ssp, idx);
 }
@@ -340,7 +336,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
-	srcu_check_read_flavor(ssp, true);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
 	rcu_lock_release(&ssp->dep_map);
 	__srcu_read_unlock_nmisafe(ssp, idx);
 }
@@ -349,7 +345,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 static inline notrace void
 srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
 {
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	__srcu_read_unlock(ssp, idx);
 }
 
@@ -366,7 +362,7 @@ static inline void srcu_up_read(struct srcu_struct *ssp, int idx)
 {
 	WARN_ON_ONCE(idx & ~0x1);
 	WARN_ON_ONCE(in_nmi());
-	srcu_check_read_flavor(ssp, false);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
 	__srcu_read_unlock(ssp, idx);
 }
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ab7d8d215b84b..79ad809c7f035 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -43,6 +43,10 @@ struct srcu_data {
 	struct srcu_struct *ssp;
 };
 
+/* Values for ->srcu_reader_flavor. */
+#define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
+#define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
+
 /*
  * Node in SRCU combining tree, similar in function to rcu_data.
  */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1e6abdf22c881..4c51be484b48a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -463,7 +463,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
 			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
 	}
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
-		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
+		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
 	return sum;
 }
 
@@ -703,20 +703,21 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
  */
 void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 {
-	int reader_flavor_mask = 1 << read_flavor;
-	int old_reader_flavor_mask;
+	int old_read_flavor;
 	struct srcu_data *sdp;
 
-	/* NMI-unsafe use in NMI is a bad sign */
-	WARN_ON_ONCE(!read_flavor && in_nmi());
+	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
+	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
+	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
+
 	sdp = raw_cpu_ptr(ssp->sda);
-	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
-	if (!old_reader_flavor_mask) {
-		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);
-		if (!old_reader_flavor_mask)
+	old_read_flavor = READ_ONCE(sdp->srcu_reader_flavor);
+	if (!old_read_flavor) {
+		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
+		if (!old_read_flavor)
 			return;
 	}
-	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
+	WARN_ONCE(old_read_flavor != read_flavor, "CPU %d old state %d new state %d\n", sdp->cpu, old_read_flavor, read_flavor);
 }
 EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
 #endif /* CONFIG_PROVE_RCU */
-- 
2.40.1



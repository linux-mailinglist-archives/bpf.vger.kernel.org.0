Return-Path: <bpf+bounces-49104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63EEA1430C
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9CF3A8E3B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6716F24385A;
	Thu, 16 Jan 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srWjbDzC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D92419F1;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=g5P0WW1Tnts/1wo5OCPf4oSTaeTPqXnY5GObInaxgJ4tcn7U/HRxLS2WB6xVMxdZeV7jTVZtpDbwuKJky4LwG36UeaKypZXn89KCDrXJHAlfhSxukr9DAMgedSB+BfOVnfk6nCWBXkRhlb93DpK/NxQsikX/hU3eDI5BK8xIY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=yk/MWVXZdRjDc32PMvtz8WEH6sSkKtNJuArIejcJ3Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LX6BGnoIZ1li68DaLlGfB/qPahQvTJuWKHkqFzbxJaM4FeKFx6igJMKXV+vAT9Mts3kFfYwgnFL3OzzUmw0b5i6pZJZ9QJTLCgcsjP+9lc2QwpttsAOPUBnDF8UJLtv6L5B65Ou+yffLyEQ/CAIaqe1O8u5flMPFjRKgvmiiJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srWjbDzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B81AC4CEF3;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=yk/MWVXZdRjDc32PMvtz8WEH6sSkKtNJuArIejcJ3Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srWjbDzCvpWnbEx1ahC8nFKLDT2YcSbIr0n4uQEG5HuNlMPTCL0f4DhGlbHG7hdzX
	 6UXtgAnYybPuDJi1oJt/xkqkRxRufEdZck0x2O0F8SKwb0179HmvgqAMlsK5vnLAY3
	 SS4SOMOODlKaRj/dDweeucnIST9xsx/FM6XzrKctvBy/Lc/SmJDWMXjUrwRC8pz3AY
	 iKxtY7lVXWJG/ED8sz6wn9p3Tt3FbwFGhiOUDHQYVnCB+OJ3WXIbXZv0Ci1fWJzy0n
	 OO4IBzU7cP1Sn3nUDA0RlUrOb+Gr5bpH+yMvrpUcjDxxISOLppvfJkQFOPV/vjQQ1v
	 Iu/F8cYnWrtkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 93EC4CE37D4; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
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
Subject: [PATCH rcu 08/17] srcu: Rename srcu_check_read_flavor_lite() to srcu_check_read_flavor_force()
Date: Thu, 16 Jan 2025 12:21:03 -0800
Message-Id: <20250116202112.3783327-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit renames the srcu_check_read_flavor_lite() function to
srcu_check_read_flavor_force() and adds a read_flavor argument in order to
support an srcu_read_lock_fast() variant that is to avoid array indexing
in both the lock and unlock primitives.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     |  2 +-
 include/linux/srcutiny.h |  2 +-
 include/linux/srcutree.h | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index f6f779b9d9ff2..ca00b9af7c237 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -279,7 +279,7 @@ static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
-	srcu_check_read_flavor_lite(ssp);
+	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_LITE);
 	retval = __srcu_read_lock_lite(ssp);
 	rcu_try_lock_acquire(&ssp->dep_map);
 	return retval;
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 31b59b4be2a74..6b1a7276aa4c9 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -82,7 +82,7 @@ static inline void srcu_barrier(struct srcu_struct *ssp)
 }
 
 #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
-#define srcu_check_read_flavor_lite(ssp) do { } while (0)
+#define srcu_check_read_flavor_force(ssp, read_flavor) do { } while (0)
 
 /* Defined here to avoid size increase for non-torture kernels. */
 static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 6b7eba59f3849..e29cc57eac81d 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -251,16 +251,18 @@ static inline void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx)
 
 void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
 
-// Record _lite() usage even for CONFIG_PROVE_RCU=n kernels.
-static inline void srcu_check_read_flavor_lite(struct srcu_struct *ssp)
+// Record reader usage even for CONFIG_PROVE_RCU=n kernels.  This is
+// needed only for flavors that require grace-period smp_mb() calls to be
+// promoted to synchronize_rcu().
+static inline void srcu_check_read_flavor_force(struct srcu_struct *ssp, int read_flavor)
 {
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
 
-	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE))
+	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & read_flavor))
 		return;
 
 	// Note that the cmpxchg() in __srcu_check_read_flavor() is fully ordered.
-	__srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
+	__srcu_check_read_flavor(ssp, read_flavor);
 }
 
 // Record non-_lite() usage only for CONFIG_PROVE_RCU=y kernels.
-- 
2.40.1



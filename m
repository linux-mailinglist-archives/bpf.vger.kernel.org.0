Return-Path: <bpf+bounces-49107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C00A1430E
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 21:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6953A1007
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E765243879;
	Thu, 16 Jan 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDLOf/rC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087B241A03;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058875; cv=none; b=ppNl5cJfiukTPoPbevSmMpKnUkNTaadZPKK9w5lzSYAuBYLedjl+1kbujgeJ6AjSGsGRQLQAXagvI7z0gLlt5GVkXbYcIR+sNimIPML24yF8QQASQDJ/m9f5uUCuOnCqKMiOovs7hEX5UL9vGGM5dh2rWYiDeMCKeRGZ39JrPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058875; c=relaxed/simple;
	bh=/Xhoj1WJzPcxvG0UU8IeYEawtU/PRon6+wnm3gf46G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWnbRqGSpn0D02P5EcYgffuh8vh9Bi8U1l8LBSlVX1Z1iR/1UfViExXMX8F2MPRfoseTMtnKg7KJ8sGouYkOdXjZutxdUqzb12uTJeVg18CpsoBEWMzSxGc7QBqQc+tahvhpAOI3Vc19z1gpeZpw6V+7YhLlFlCMZotyp24A37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDLOf/rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540A2C4CEE5;
	Thu, 16 Jan 2025 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058875;
	bh=/Xhoj1WJzPcxvG0UU8IeYEawtU/PRon6+wnm3gf46G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDLOf/rCYlfXUz6FMqGiB6jX5wg4YE7Zj9F03ZjSMrGsGwAwGbY4VFUNO93R58SLe
	 ZQxOVb64FMQiFZHKU9+z2YXhdmgrvY/1/j7eBXTaqTkZzVUIoyOteSCSEOC1eg8c/t
	 L1OLYbpBoy5WeB4zUKnVeyysR/d3YGp2YHMxir6m+au2wa3wl/VioD+Q22jI3hq2Kn
	 fn7tOUeLWmhtxhQ3I2UFt1ewc/ycIkA+LZDjuGYXtroOdOw4QsLtFcmaV7VyiVpLfv
	 W84oyKffe0Uzi4UpCp3pWuzghg1Q4TwzfUrPLs7hfyIbS/eBeuOjBa6liTNR6f6XIH
	 fGmpi3kwNsZeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98972CE37D7; Thu, 16 Jan 2025 12:21:14 -0800 (PST)
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
Subject: [PATCH rcu 10/17] srcu: Pull pointer-to-integer conversion into __srcu_ptr_to_ctr()
Date: Thu, 16 Jan 2025 12:21:05 -0800
Message-Id: <20250116202112.3783327-10-paulmck@kernel.org>
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

This commit abstracts the srcu_read_lock*() pointer-to-integer conversion
into a new __srcu_ptr_to_ctr().  This will be used in rcutorture for
testing an srcu_read_lock_fast() that returns a pointer rather than
an integer.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutree.h | 9 ++++++++-
 kernel/rcu/srcutree.c    | 4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index e29cc57eac81d..f41bb3a55a048 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -211,6 +211,13 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
+// Converts a per-CPU pointer to an ->srcu_ctrs[] array element to that
+// element's index.
+static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct srcu_ctr __percpu *scpp)
+{
+	return scpp - &ssp->sda->srcu_ctrs[0];
+}
+
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.  Returns an index that must be passed to the matching
@@ -228,7 +235,7 @@ static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
 	this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	barrier(); /* Avoid leaking the critical section. */
-	return scp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scp);
 }
 
 /*
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 973e49d04f4f1..4643a8ed7e326 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -753,7 +753,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 
 	this_cpu_inc(scp->srcu_locks.counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
-	return scp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scp);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
@@ -783,7 +783,7 @@ int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 
 	atomic_long_inc(&scp->srcu_locks);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
-	return scpp - &ssp->sda->srcu_ctrs[0];
+	return __srcu_ptr_to_ctr(ssp, scpp);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
 
-- 
2.40.1



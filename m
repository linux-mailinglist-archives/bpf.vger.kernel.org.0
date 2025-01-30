Return-Path: <bpf+bounces-50147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E58A9A2345A
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383E5166945
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC11F238E;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXnh/gjA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512B1F12FA;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=TRJZJSfaLQUYHq1GIC+Y/+/4rshP3nIHnqXTwix5i39PmiiZ/Sb6LRpg31eX/smNPEIsGKCNk3zP8vttNdLPvPP2m8SkoDmZygXn0NUZ1yMX36kVlkzsxFIjqNRqpniQx8LsGyUXPTUnYqBLMEIddFgX9yz+Tm+K3EZfiXANn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=AUBJFe6+y8Mp6SRcOcGWq4myj9KqTZ3gburkald3ZNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrMuXySk/770628jfi5/2G8AHv4FzqJB2LCaSZDMRpLCpmjzz9xv0lxZCzitJJbsrqoiGWQmft3GwFnPkUW62jDcT//BMc3KVoT17/YEOkP29nTWQk9OvHeTdlaG2RWJfsKlllM69kD7eQ1M9PREMiSxuHDEBsWsf4ws3JoD2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXnh/gjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87802C4CEF2;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=AUBJFe6+y8Mp6SRcOcGWq4myj9KqTZ3gburkald3ZNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXnh/gjAUAVEd02LWnnApK0LKQwx9m+vxg9KQdZcRXEu4SEMZ4VCcti1jY2IyHjLZ
	 66LRqnzYQkcUc0J0avzZpr/ci4qaqlwbOG8pl8IxX7whQc89uc+cPbSmiXF+li3q1t
	 0QpivYoML/sLc7TZfvVHVh3e0nzQqFQvAGOSr4iiogX7XRAr2EqjIly4NMvdYESq4l
	 uBPTDFJrSiafBqYDcJZ8ZGDjWNesz7WM59nELg3tS94Jpjq1jHmp/+CGX1nuT39J0P
	 6vEpskfVbTwEYqN5YPNR5a2IQAootH7XU7fOVdCOae4+fmgHtJGW8rE/T+nWMexPzc
	 Un9Ll7erFvJhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6BEDCE37E6; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 08/20] srcu: Rename srcu_check_read_flavor_lite() to srcu_check_read_flavor_force()
Date: Thu, 30 Jan 2025 11:03:05 -0800
Message-Id: <20250130190317.1652481-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
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
index f6f779b9d9ff..ca00b9af7c23 100644
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
index 31b59b4be2a7..6b1a7276aa4c 100644
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
index 6b7eba59f384..e29cc57eac81 100644
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



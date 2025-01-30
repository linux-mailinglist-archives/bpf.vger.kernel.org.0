Return-Path: <bpf+bounces-50155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B07FA2345F
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B31166B4B
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3B91F2C4F;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqRWktmD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988001F190E;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=FOfm6nsEcMOK6mJZ2cltZn+HF8pVb5aDsYept4i+SeWHpig9g+yeEQfmM9gwnWzbEwvAv/J7AnAo43ZZwk1qiSpyv3uFFW2CzZDxNllyinrWyDlev1SMUW0mYtmv5ug3373S0SOhwk6WWJh2QZNCOAHBQx2TJH4q38tOyePd3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=9y2DzeCgvyMVVNxPX0RVQZZ22Kzqmwq2K+TRXJQVSOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SiZo2apy6p/7+6jzoo+0o+XXF9YHZhnJMVuaW/ctPGCmri1rpMYCIuWQwsTqabcn/yh+uczN87JAIenPZUZW+BKnhAb2j5GzLUuvYm6aQ1G9hwDgaCIjnlXm5VTWNSGONZalePe8BWD0CqgtJzIgXRbpd2JvAvWZOK3FYbTN+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqRWktmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1006C4CEE7;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263800;
	bh=9y2DzeCgvyMVVNxPX0RVQZZ22Kzqmwq2K+TRXJQVSOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqRWktmD34aYw8VgnC8lk+5SrM6a0gf+ibzG/raLratfYA2p2BOWwOiZRvmi5C5KH
	 D0iN5bp4HRXa946NgB1BsyP1WVfkHl8sYqL4fELp2m6zacNqvfD7JHKJHKnqYzDcVK
	 vn28dp5KcwYIgGtWpxsl47bmcanHNviz/8dXm8k8/39Hnwg4lkolyYcX33XT0VxGtt
	 rjWxQkVhfyPFsbGgEMF+r8GO559DsDi0xpNOIPoaOYCWmBDOZBAPEfT+g3bUXcv9d4
	 3NR/h6ocy9O5IR5/O+grCedkOEAzH2WXRuSnfPPsQnvFGR9NBok64RbjX+9lgcLA6i
	 IfVAmBI694oHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12516CE3991; Thu, 30 Jan 2025 11:03:19 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	bpf@vger.kernel.org
Subject: [PATCH rcu v2] 19/20] srcu: Add srcu_down_read_fast() and srcu_up_read_fast()
Date: Thu, 30 Jan 2025 11:03:16 -0800
Message-Id: <20250130190317.1652481-19-paulmck@kernel.org>
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

A pair of matching srcu_read_lock_fast() and srcu_read_unlock_fast()
invocations must take place within the same context, for example, within
the same task.  Otherwise, lockdep complains, as is the right thing to
do for most use cases.

However, there are use cases involving tracing (for example, uretprobes)
in which an SRCU reader needs to begin in one task and end in a
timer handler, which might interrupt some other task.  This commit
therefore supplies the semaphore-like srcu_down_read_fast() and
srcu_up_read_fast() functions, which act like srcu_read_lock_fast() and
srcu_read_unlock_fast(), but permitting srcu_up_read_fast() to be invoked
in a different context than was the matching srcu_down_read_fast().

Neither srcu_down_read_fast() nor srcu_up_read_fast() may be invoked
from an NMI handler.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 317eab82a5f0..900b0d5c05f5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -281,6 +281,24 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *
 	return retval;
 }
 
+/**
+ * srcu_down_read_fast - register a new reader for an SRCU-protected structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter a semaphore-like SRCU read-side critical section, but for
+ * a light-weight smp_mb()-free reader.  See srcu_read_lock_fast() and
+ * srcu_down_read() for more information.
+ *
+ * The same srcu_struct may be used concurrently by srcu_down_read_fast()
+ * and srcu_read_lock_fast().
+ */
+static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires(ssp)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+	srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
+	return __srcu_read_lock_fast(ssp);
+}
+
 /**
  * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -400,6 +418,22 @@ static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ct
 	__srcu_read_unlock_fast(ssp, scp);
 }
 
+/**
+ * srcu_up_read_fast - unregister a old reader from an SRCU-protected structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @scp: return value from corresponding srcu_read_lock_fast().
+ *
+ * Exit an SRCU read-side critical section, but not necessarily from
+ * the same context as the maching srcu_down_read_fast().
+ */
+static inline void srcu_up_read_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
+	__releases(ssp)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
+	__srcu_read_unlock_fast(ssp, scp);
+}
+
 /**
  * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
-- 
2.40.1



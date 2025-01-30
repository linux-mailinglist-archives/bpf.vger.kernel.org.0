Return-Path: <bpf+bounces-50150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C24DA2345B
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFFA3A610E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117331F2396;
	Thu, 30 Jan 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNUQ0k0a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAF1F150F;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=Ccz8Rivs3dW5aj6HpxIjvxnHdUvEraUFMxPWu4u8bP0WeBVwRbXUPTHs31Sp1FYtDHFx20k1SBPy/Fttucgp/C1CRxRimzJeHW/802N7KNL9ri+HTiQncAJpUJSKPFjNu8cm3gZnZArTWZPkLJC44uAwo+t3q5h0cH4eGWoqK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=9ylMe2EoR3K55pq1MMAtt4TlBFgPxi0PeDYU9p9rAaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHrkfkSNy+33Kd7Kic4JQcTXW4JqLGycWe9rJ+Sqd1WEdE8kSGsavuqfeY9nuU6FYTjNKlMakP6Qlh+1yC47zqEcgEpXZlfGz7LuLx9LUVkALfdhFXpgtxj3CulrkJ4TcrNBjA3G/pCd9jlLflHb3YVIX6RRpyC6C/8Er2Fp/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNUQ0k0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFF0C4CEE4;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=9ylMe2EoR3K55pq1MMAtt4TlBFgPxi0PeDYU9p9rAaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNUQ0k0aNjY98yiPL2AIzZV3lYsYhvwZgX4Fp4FiTA3Wh93FaghAakR0Xer5Dvf9g
	 885T9UYCWM3RpopGmPJ5pOk+WxOk/h8ca2yaeIj1VpE0wmwo+n6mBx2imm24+UePOM
	 zePqn6lUEFyi5Tqd9h80IStFHqyspnyvOAiRSqEEYUHJaDRGMOIJF3feOzaY7Geh5b
	 RY5CnOIzus2wAIqMmmyP7t55eletOI+XbRhlh5t2MeO+GNMG6/SLrBWST48KACuU0j
	 1NM2vmRAaYvg/I3qPBsHpQU+OctuZxosQwhUhz7fFCNU/9L6n9ZwLN2ps1+rD8+LKY
	 zt4F50muSUjfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F25ADCE37FA; Thu, 30 Jan 2025 11:03:18 -0800 (PST)
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
Subject: [PATCH rcu v2] 12/20] srcu: Move SRCU Tree/Tiny definitions from srcu.h
Date: Thu, 30 Jan 2025 11:03:09 -0800
Message-Id: <20250130190317.1652481-12-paulmck@kernel.org>
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

There are a couple of definitions under "#ifdef CONFIG_TINY_SRCU"
in include/linux/srcu.h.  There is no point in them being there,
so this commit moves them to include/linux/srcutiny.h and
include/linux/srcutree.c, thus eliminating that #ifdef.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 10 +---------
 include/linux/srcutiny.h |  3 +++
 include/linux/srcutree.h |  1 +
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 505f5bdce444..2bd0e24e9b55 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -52,6 +52,7 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_SLOWGP	SRCU_READ_FLAVOR_LITE
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
+void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
@@ -64,15 +65,6 @@ int init_srcu_struct(struct srcu_struct *ssp);
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 		void (*func)(struct rcu_head *head));
 void cleanup_srcu_struct(struct srcu_struct *ssp);
-int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
-#ifdef CONFIG_TINY_SRCU
-#define __srcu_read_lock_lite __srcu_read_lock
-#define __srcu_read_unlock_lite __srcu_read_unlock
-#else // #ifdef CONFIG_TINY_SRCU
-int __srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock_lite(struct srcu_struct *ssp, int idx) __releases(ssp);
-#endif // #else // #ifdef CONFIG_TINY_SRCU
 void synchronize_srcu(struct srcu_struct *ssp);
 
 #define SRCU_GET_STATE_COMPLETED 0x1
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 6b1a7276aa4c..07a0c4489ea2 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -71,6 +71,9 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 	return idx;
 }
 
+#define __srcu_read_lock_lite __srcu_read_lock
+#define __srcu_read_unlock_lite __srcu_read_unlock
+
 static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 {
 	synchronize_srcu(ssp);
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 55fa400624bb..ef3065c0cadc 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -207,6 +207,7 @@ struct srcu_struct {
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
 
+int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
-- 
2.40.1



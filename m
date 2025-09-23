Return-Path: <bpf+bounces-69402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBC1B9635D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F819C485F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8124A063;
	Tue, 23 Sep 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXVcsyO0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485222C187;
	Tue, 23 Sep 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637296; cv=none; b=WtI62079Sn0jz/55q/6FmC5Tsrg8NnijTarOD3ekRgWpPUk7hpaEqEiFhDuU8lw+uSGXGGplvy7EsHXG4aO70Or1teJXzEZ2rB7o/xgHYXNdHLb9IIGKEF58mdQK4GXP+q1kRAdjzjKNV7PQ4gB9Dj/gWGdm+f6r3vkxUF0oss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637296; c=relaxed/simple;
	bh=4c507eqy0EGwafCH6pxIpf/X1KtAub6CGBV9RmYtNM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+tBG6m3uSj67Sf+lX0SwcB2KKXKxVfhcvTujKjNOlyUpK4EskE12hL2pJulhRoWnBhCeoDb1fnZgSy4eQBkwk/DYzedT+2Yd4KzXvnfynkI9CDD/Mb3vHzX24iKiK+FNPSbnxg7DHZ+ViCTUfDackk5SQtmBlBuxnCCykJTR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXVcsyO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8D5C4CEF5;
	Tue, 23 Sep 2025 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637295;
	bh=4c507eqy0EGwafCH6pxIpf/X1KtAub6CGBV9RmYtNM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXVcsyO0I+bJsahDDW5Mxc+Xl69wA3fjUGhiSQoEI/cPVHJ0W3WB3r8FegxcwE1Jp
	 BygEFEtZZ0IecTwd2MDGPAuItQ4h9b5HN/zxw2JRU/wzeaqTeSId5Dz69hwZCj3U1K
	 sWFEjbETExrm/55EsP3BuRsfgpGyE4umrlf4WvgeAan7xIwpMEa1Qdx+p38BEGmJA0
	 AnT4bzq3YP6dK/DurTGso0sn9ah67mqD/G/Fd2DYFRn0q/rKkp5aT60XHyEDR0yF7s
	 bDNsaqfzj84SrFRk23fpZ7vNgY4sgQFynMp5AEbeMCjHwmqVDAORNz0UHsxms/5jmr
	 huZQ0KyOXYAIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0CE8ECE1763; Tue, 23 Sep 2025 07:20:38 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 28/34] srcu: Make SRCU-fast available to heap srcu_struct structures
Date: Tue, 23 Sep 2025 07:20:30 -0700
Message-Id: <20250923142036.112290-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit defines a new init_srcu_struct_fast() function that marks
the specified srcu_struct structure for use by srcu_read_lock_fast()
and friends.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcu.h     | 16 ++++++++++++++--
 include/linux/srcutiny.h |  4 ++++
 kernel/rcu/srcutree.c    | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index ada65b58bc4c5f..26de47820c58cd 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -25,8 +25,10 @@ struct srcu_struct;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
-		       struct lock_class_key *key);
+int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
+#ifndef CONFIG_TINY_SRCU
+int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
+#endif // #ifndef CONFIG_TINY_SRCU
 
 #define init_srcu_struct(ssp) \
 ({ \
@@ -35,10 +37,20 @@ int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
 	__init_srcu_struct((ssp), #ssp, &__srcu_key); \
 })
 
+#define init_srcu_struct_fast(ssp) \
+({ \
+	static struct lock_class_key __srcu_key; \
+	\
+	__init_srcu_struct_fast((ssp), #ssp, &__srcu_key); \
+})
+
 #define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name },
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 int init_srcu_struct(struct srcu_struct *ssp);
+#ifndef CONFIG_TINY_SRCU
+int init_srcu_struct_fast(struct srcu_struct *ssp);
+#endif // #ifndef CONFIG_TINY_SRCU
 
 #define __SRCU_DEP_MAP_INIT(srcu_name)
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index b5f62259d56fb1..92e6ab53398fc0 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -54,6 +54,10 @@ void srcu_drive_gp(struct work_struct *wp);
 // Dummy structure for srcu_notifier_head.
 struct srcu_usage { };
 #define __SRCU_USAGE_INIT(name) { }
+#define __init_srcu_struct_fast __init_srcu_struct
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#define init_srcu_struct_fast init_srcu_struct
+#endif // #ifndef CONFIG_DEBUG_LOCK_ALLOC
 
 void synchronize_srcu(struct srcu_struct *ssp);
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c8b39d4dd3162..177f9ec1f926e1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -286,16 +286,29 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
-int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
-		       struct lock_class_key *key)
+static int
+__init_srcu_struct_common(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
 {
 	/* Don't re-initialize a lock while it is held. */
 	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
 	lockdep_init_map(&ssp->dep_map, name, key, 0);
 	return init_srcu_struct_fields(ssp, false);
 }
+
+int __init_srcu_struct(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
+{
+	ssp->srcu_reader_flavor = 0;
+	return __init_srcu_struct_common(ssp, name, key);
+}
 EXPORT_SYMBOL_GPL(__init_srcu_struct);
 
+int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
+{
+	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
+	return __init_srcu_struct_common(ssp, name, key);
+}
+EXPORT_SYMBOL_GPL(__init_srcu_struct_fast);
+
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
@@ -308,10 +321,26 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct);
  */
 int init_srcu_struct(struct srcu_struct *ssp)
 {
+	ssp->srcu_reader_flavor = 0;
 	return init_srcu_struct_fields(ssp, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct);
 
+/**
+ * init_srcu_struct_fast - initialize a fast-reader sleep-RCU structure
+ * @ssp: structure to initialize.
+ *
+ * Must invoke this on a given srcu_struct before passing that srcu_struct
+ * to any other function.  Each srcu_struct represents a separate domain
+ * of SRCU protection.
+ */
+int init_srcu_struct_fast(struct srcu_struct *ssp)
+{
+	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_FAST;
+	return init_srcu_struct_fields(ssp, false);
+}
+EXPORT_SYMBOL_GPL(init_srcu_struct_fast);
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /*
-- 
2.40.1



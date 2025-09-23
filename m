Return-Path: <bpf+bounces-69401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC1B9635A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B68619C46E5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22A246BC6;
	Tue, 23 Sep 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmSJei00"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9B22DFA4;
	Tue, 23 Sep 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637296; cv=none; b=skpTZbqZLUIUosztpggXtByvG4WDnjVEUyvRNnRfp53kp6Tzlhq538uUIDzOl1UROTb5HFo3CMdEuCFmdHhBioYm7LWhWtoKGdejvac6m9hHWPCJ9KSq702gb9bLZWzRCb2rmrkyNLUlrqx1lFLHT5dJ2SZVLMnYnC1zE6IKyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637296; c=relaxed/simple;
	bh=qnaBMWA94ufanssrOAqRkiBTs8H62VLm1Z5ULAg5fZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RO1pf4xdgenkjpSqiWyfv2uNztmBIjN/uERwwDJEkRuL3UjRCHpsZkYkd3sfTEFbCH8WsL27ly+3mUo2525i6LD/NunJGJIxng/WGVSBq8+aiw981hZYN/YwAlaWvWgbF3WlQnE6IGXav4/d8pQjW9bEsItuhNaC0EOchsYgpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmSJei00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD978C113D0;
	Tue, 23 Sep 2025 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637295;
	bh=qnaBMWA94ufanssrOAqRkiBTs8H62VLm1Z5ULAg5fZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmSJei00IJME6ljBHGfRq6vFRO1zny7h5HcG9np//bWh5BsdA0YjbsvAIeab/hDb7
	 ywF7Q8uD63Idrf3xx+GQnJo27ng1MxN0jQk52GWlOBa8wIvEyJ0pnvHshIvYkM2DeT
	 97zwSrCgE8aKM4zNHOF5/dW+2v6Qs4yXye7lX8rkzVNkgTQ7myA2SwgEJ9fKQqllF0
	 oS4mW1D/g05OWWBax9Uf/CzPiyMJMvjqjCNjEBQcbmARsynA6vMJ+tp0M+lqDbdtZ5
	 uZ+eTts8OkH74l4R0FUcbTYy2X19MbwszvsLKoTEe1WyZqy70JNE5Fzh//6pHw+tOR
	 f5t3B/QJEhRSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E2384CE14F7; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 17/34] srcu: Create a DEFINE_SRCU_FAST()
Date: Tue, 23 Sep 2025 07:20:19 -0700
Message-Id: <20250923142036.112290-17-paulmck@kernel.org>
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

This commit creates a DEFINE_SRCU_FAST() that is similar to DEFINE_SRCU(),
but which creates an srcu_struct that is usable only by readers initiated
by srcu_read_lock_fast() and friends.  Note that DEFINE_SRCU_FAST() is
usable only by built-in code, not from loadable modules.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: <bpf@vger.kernel.org>
---
 include/linux/srcutiny.h |  1 +
 include/linux/srcutree.h | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 51ce25f07930ee..00e5f05288d5e7 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -45,6 +45,7 @@ void srcu_drive_gp(struct work_struct *wp);
  */
 #define DEFINE_SRCU(name) \
 	struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
+#define DEFINE_SRCU_FAST(name) DEFINE_SRCU(name)
 #define DEFINE_STATIC_SRCU(name) \
 	static struct srcu_struct name = __SRCU_STRUCT_INIT(name, name, name)
 
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 42098e0fa0b7dd..1adc58d2ab6425 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -189,23 +189,33 @@ struct srcu_struct {
  *	init_srcu_struct(&my_srcu);
  *
  * See include/linux/percpu-defs.h for the rules on per-CPU variables.
+ *
+ * DEFINE_SRCU_FAST() creates an srcu_struct and associated structures
+ * whose readers must be of the SRCU-fast variety.  DEFINE_SRCU_FAST()
+ * cannot be used within modules due to there being no place to
+ * put the desired ->srcu_reader_flavor value.  If in-module use of
+ * DEFINE_SRCU_FAST() becomes necessary, the srcu_struct structure will
+ * need to grow in order to store this value.
  */
 #ifdef MODULE
-# define __DEFINE_SRCU(name, is_static)								\
+# define __DEFINE_SRCU(name, fast, is_static)							\
 	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
 	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage);	\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
 		__section("___srcu_struct_ptrs") = &name
 #else
-# define __DEFINE_SRCU(name, is_static)								\
-	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
+# define __DEFINE_SRCU(name, fast, is_static)							\
+	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data) = {				\
+		.srcu_reader_flavor = fast,							\
+	};											\
 	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
 	is_static struct srcu_struct name =							\
 		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
+#define DEFINE_SRCU_FAST(name)		__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, /* not static */)
 #endif
-#define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
-#define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
+#define DEFINE_SRCU(name)		__DEFINE_SRCU(name, 0, /* not static */)
+#define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, 0, static)
 
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
-- 
2.40.1



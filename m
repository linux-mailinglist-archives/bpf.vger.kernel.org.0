Return-Path: <bpf+bounces-38280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64B962A70
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AB51F21A44
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45C1A38D3;
	Wed, 28 Aug 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aai2f22Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DB19DF40;
	Wed, 28 Aug 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855873; cv=none; b=JvRGILxeP71dpp4u/Du2FDnXFHhiGAiQ1zyG4Gq9x9naYZmRd2aknXUIkVj2qd06eA76aYT54lX8+5KZ1qvfDsDFUVtLWWKGw4RY6uEfk04jIvDk+tqEYoyg90KXh24Nl3clzjQjxA4Xu/czXMBCzCLjLS5FZSFXmzws5PjZNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855873; c=relaxed/simple;
	bh=NRyKNKZZiGraXr3p/9LHNitmJMIinFDy+D9RphehFS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6ShudBrTD7OduT7iibUHIwPmRZVDnKjty/smdAzIWynXzamNAClQ3JdtQoE67Ksjx9RA+P9SKp72IdBX4XGbHu1TaFJyvSbl9lBL31wdgEplrELmhnADupYH57Ju+2ClZavEW6uBcM/TDWDi8aV6yi5i7NFhCL5SroKIf/gmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aai2f22Z; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724855870;
	bh=NRyKNKZZiGraXr3p/9LHNitmJMIinFDy+D9RphehFS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aai2f22Z3HJy1m532YmTh8hMge+vAn4NCPNWUnzUzQrQcoO/i6ikgg9tWnvD9E2hr
	 jlCmXXcaZkfpLKoqAbK2/L9FjF07I7TR4RdQ2p2AfjPQRaZqH5U9Qa5ndgRsYbjakd
	 P5B6/i9NAi+U2xkRLkML6e/LkN593HDaZ8j7DTot8RcGXXKxsPb3BdFI8k2ynX65e1
	 GiDYLvipoz5nWqzB7Nm/PBg48ARy2Ocg9l3/EwQZs1ps+B///4Sut4zJVitnfSJgB2
	 YOLegBbyl1VGEtuw2Lt03017TEYhg/cGmq3E1rMiImmdLSznH0CRqsHHYnFBgge4qS
	 +aP4hErnIF/WQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wv6T96GJvz1JN4;
	Wed, 28 Aug 2024 10:37:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-trace-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
Date: Wed, 28 Aug 2024 10:37:19 -0400
Message-Id: <20240828143719.828968-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To cover scenarios where the scope of the guard differs from the scope
of its activation, introduce DEFINE_INACTIVE_GUARD() and activate_guard().

Here is an example use for a conditionally activated guard variable:

void func(bool a)
{
	DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);

	[...]
	if (a) {
		might_sleep();
		activate_guard(preempt_notrace, myguard)();
	}
	[ protected code ]
}

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Sean Christopherson <seanjc@google.com>
---
 include/linux/cleanup.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 1247e67a6161..5f031cce97ca 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -149,12 +149,20 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *      similar to scoped_guard(), except it does fail when the lock
  *      acquire fails.
  *
+ * DEFINE_INACTIVE_GUARD(name, var):
+ *      define an inactive guard variable in a given scope, initialized to NULL.
+ *
+ * activate_guard(name, var)(args...):
+ *      activate a guard variable with its constructor, if it is not already
+ *      activated.
  */
 
 #define DECLARE_GUARD(_name, _type, _lock, _unlock) \
 	DECLARE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return *_T; }
+	{ return *_T; } \
+	static inline class_##_name##_t class_##_name##_null(void) \
+	{ return NULL; }
 
 #define DECLARE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
@@ -178,6 +186,14 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 		if (!__guard_ptr(_name)(&scope)) _fail; \
 		else
 
+#define DEFINE_INACTIVE_GUARD(_name, _var) \
+	class_##_name##_t _var __cleanup(class_##_name##_destructor) = \
+		class_##_name##_null()
+
+#define activate_guard(_name, _var) \
+	if (!class_##_name##_lock_ptr(&(_var))) \
+		_var = class_##_name##_constructor
+
 /*
  * Additional helper macros for generating lock guards with types, either for
  * locks that don't have a native type (eg. RCU, preempt) or those that need a
@@ -212,6 +228,11 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
 {									\
 	return _T->lock;						\
+}									\
+static inline class_##_name##_t class_##_name##_null(void)		\
+{									\
+	class_##_name##_t _t = { .lock = NULL };			\
+	return _t;							\
 }
 
 
-- 
2.39.2



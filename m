Return-Path: <bpf+bounces-33261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46C191AB16
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 17:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61181C22A0E
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114DF1990DD;
	Thu, 27 Jun 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="STDpCMPO"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86B198A27;
	Thu, 27 Jun 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501792; cv=none; b=Asmx2k9co1UcjjU7rDf21zBOMeUudLtcfQXdJwA4nhM27owU4teqAVPqHd5TLHUfLQhwGO9HbBE2RFQLE67vTXkHu2CFLDT5JTTzoJyg9b9DxR/KGYDstETfKyjtvAd/0d/c1iU3XO6wj2mhoTfgCdSiz2qnPeMU1taz2OtxFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501792; c=relaxed/simple;
	bh=Bk7Pg/cXxlmIlMDgHhqaAOlMz4ok67A5N9s2gbvA46o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JKjwipMvWmlo+KJMlVy5U8tCLRrDnZtKOX1OQzsGLWVGdYscorPXWW60Y3vW/0YRYhrfcoqZiBuAJC01ACum6Oxb+8KHuw3d/QlVdxnaPXNcNabK2LhHWTL7Wbc6Ylr3yeCOcTiBSVWO6NTJD5004T2e5T3x+H2avh216T7I8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=STDpCMPO; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719501789;
	bh=Bk7Pg/cXxlmIlMDgHhqaAOlMz4ok67A5N9s2gbvA46o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STDpCMPOR4U7JqsieE4ox/8TlDbifFKCHUg1acj3wXqFZSsy6pVk5x/mYuM7CSjJQ
	 3k7Z5Zpef/F0IzjLB8FxNi+MUWQMKdDQXVRHxTEo5aweo6yhFoavdT/A3mnETL4au2
	 Jcme9VCL+Amzab/pXr8hoJzrjjUyXk31KIa0ug/swMjZxO/lY5WjkkmlnMFuFMn6jB
	 Wiw7sEQrtjtbdofF9hHsYTbEEI24Y/+XTfbhvKCRNt00EZnkaReN67V58HmmvJB4c/
	 O9lfozqpYFYj2UCnJwOVR89mlUGX7GtyUjmOAt5SpTUH+bJZ3D+tfQVS4EqEKvQVBw
	 K4nbKYiTMngFA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W92Q50Cjsz17tq;
	Thu, 27 Jun 2024 11:23:09 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v5 3/8] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
Date: Thu, 27 Jun 2024 11:23:35 -0400
Message-Id: <20240627152340.82413-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
References: <20240627152340.82413-1-mathieu.desnoyers@efficios.com>
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
index 04f03ad5f25d..d6a3d8099d77 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -146,12 +146,20 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
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
@@ -175,6 +183,14 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
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
@@ -209,6 +225,11 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
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



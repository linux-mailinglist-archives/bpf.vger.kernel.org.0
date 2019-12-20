Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF74127FB7
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTPmI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:42:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfLTPmI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so9846616wrt.6
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 07:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SY0ttQjEzQPvjvG8/HqwJhfFR6ICOMlRVz/9vg/M7EA=;
        b=UWPjWjNkk3ZwL4zfuKwzD7wzxugsutarPfj0LeFqtbIXiZgJJOW1P3MOcYslXxorPk
         nAQY96DB9dWRcMoEyI6QZWz4Cz+kt2H22MewO8uKIJqlKeA0e6oSySc3nTN3PgHriCS9
         cKqgMmJVlPMkgu8RfEumk+6mn2FmDiWKzUbq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SY0ttQjEzQPvjvG8/HqwJhfFR6ICOMlRVz/9vg/M7EA=;
        b=kRZcJveRDgpTFm4ui6Tx+J97LE/XhPiymCI9p0L+aEs5cGgYYGY7u5UG/8Ql5ll4kW
         gZ6Un1frQLv1czbQxIFXlH0fyy/ILkraqX0J0Fx1e42d7iTAhH9lc2284YjKRTWzf+Ve
         /oakIl0dwEMXw9I1oH32lql1c9F1saAy1x5CGfhVh5nFEL5DyipcOLp5kgoNDKoMvwF0
         zdJGaIuZeRkOVOKNf4jAjNDdo0oLJUB0M0p0N+zDDEILm0DjyHvNvOtEcJTu+jzXgDG9
         t1F5oVHNbScLeb+KrCB6QL/i1kOk3ah7zvhmqYi9GHGw/fG85m7Z1WxOuLXDl0/Z4ms5
         PemQ==
X-Gm-Message-State: APjAAAWriZvIqDbHyiEe/GULlLBPM1SjG+j7+8qbFENgEAryfRXtAQuO
        6BbrlmdTqZjDBWBwWK9Gctw7gg==
X-Google-Smtp-Source: APXvYqxXhdI++uWPW1rc4/x3ev8WEpbY3c9lyzxIBUVouN9hKWxxY/RHbhhyvPJNvVFpgXkGqOONXw==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr16600716wrv.148.1576856524700;
        Fri, 20 Dec 2019 07:42:04 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v1 01/13] bpf: Refactor BPF_EVENT context macros to its own header.
Date:   Fri, 20 Dec 2019 16:41:56 +0100
Message-Id: <20191220154208.15895-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

These macros are useful for other program types than tracing.
i.e. KRSI (an upccoming BPF based LSM) which does not use
BPF_PROG_TYPE_TRACE but uses verifiable BTF accesses similar
to raw tracepoints.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_event.h | 78 +++++++++++++++++++++++++++++++++++++++
 include/trace/bpf_probe.h | 30 +--------------
 kernel/trace/bpf_trace.c  | 24 +-----------
 3 files changed, 81 insertions(+), 51 deletions(-)
 create mode 100644 include/linux/bpf_event.h

diff --git a/include/linux/bpf_event.h b/include/linux/bpf_event.h
new file mode 100644
index 000000000000..353eb1f5a3d0
--- /dev/null
+++ b/include/linux/bpf_event.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+
+/*
+ * Copyright (c) 2018 Facebook
+ * Copyright 2019 Google LLC.
+ */
+
+#ifndef _LINUX_BPF_EVENT_H
+#define _LINUX_BPF_EVENT_H
+
+#ifdef CONFIG_BPF_EVENTS
+
+/* cast any integer, pointer, or small struct to u64 */
+#define UINTTYPE(size) \
+	__typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
+		   __builtin_choose_expr(size == 2, (u16)2, \
+		   __builtin_choose_expr(size == 4, (u32)3, \
+		   __builtin_choose_expr(size == 8, (u64)4, \
+					 (void)5)))))
+#define __CAST_TO_U64(x) ({ \
+	typeof(x) __src = (x); \
+	UINTTYPE(sizeof(x)) __dst; \
+	memcpy(&__dst, &__src, sizeof(__dst)); \
+	(u64)__dst; })
+
+#define __CAST0(...) 0
+#define __CAST1(a, ...) __CAST_TO_U64(a)
+#define __CAST2(a, ...) __CAST_TO_U64(a), __CAST1(__VA_ARGS__)
+#define __CAST3(a, ...) __CAST_TO_U64(a), __CAST2(__VA_ARGS__)
+#define __CAST4(a, ...) __CAST_TO_U64(a), __CAST3(__VA_ARGS__)
+#define __CAST5(a, ...) __CAST_TO_U64(a), __CAST4(__VA_ARGS__)
+#define __CAST6(a, ...) __CAST_TO_U64(a), __CAST5(__VA_ARGS__)
+#define __CAST7(a, ...) __CAST_TO_U64(a), __CAST6(__VA_ARGS__)
+#define __CAST8(a, ...) __CAST_TO_U64(a), __CAST7(__VA_ARGS__)
+#define __CAST9(a, ...) __CAST_TO_U64(a), __CAST8(__VA_ARGS__)
+#define __CAST10(a ,...) __CAST_TO_U64(a), __CAST9(__VA_ARGS__)
+#define __CAST11(a, ...) __CAST_TO_U64(a), __CAST10(__VA_ARGS__)
+#define __CAST12(a, ...) __CAST_TO_U64(a), __CAST11(__VA_ARGS__)
+/* tracepoints with more than 12 arguments will hit build error */
+#define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
+
+#define UINTTYPE(size) \
+	__typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
+		   __builtin_choose_expr(size == 2, (u16)2, \
+		   __builtin_choose_expr(size == 4, (u32)3, \
+		   __builtin_choose_expr(size == 8, (u64)4, \
+					 (void)5)))))
+
+#define UNPACK(...)			__VA_ARGS__
+#define REPEAT_1(FN, DL, X, ...)	FN(X)
+#define REPEAT_2(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_1(FN, DL, __VA_ARGS__)
+#define REPEAT_3(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_2(FN, DL, __VA_ARGS__)
+#define REPEAT_4(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_3(FN, DL, __VA_ARGS__)
+#define REPEAT_5(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_4(FN, DL, __VA_ARGS__)
+#define REPEAT_6(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_5(FN, DL, __VA_ARGS__)
+#define REPEAT_7(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_6(FN, DL, __VA_ARGS__)
+#define REPEAT_8(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_7(FN, DL, __VA_ARGS__)
+#define REPEAT_9(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_8(FN, DL, __VA_ARGS__)
+#define REPEAT_10(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_9(FN, DL, __VA_ARGS__)
+#define REPEAT_11(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_10(FN, DL, __VA_ARGS__)
+#define REPEAT_12(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_11(FN, DL, __VA_ARGS__)
+#define REPEAT(X, FN, DL, ...)		REPEAT_##X(FN, DL, __VA_ARGS__)
+
+#define SARG(X)		u64 arg##X
+#ifdef COPY
+#undef COPY
+#endif
+
+#define COPY(X)		args[X] = arg##X
+#define __DL_COM	(,)
+#define __DL_SEM	(;)
+
+#define __SEQ_0_11	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
+
+#endif
+#endif /* _LINUX_BPF_EVENT_H */
+
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index b04c29270973..5165dbc66098 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/bpf_event.h>
+
 #undef TRACE_SYSTEM_VAR
 
 #ifdef CONFIG_BPF_EVENTS
@@ -27,34 +29,6 @@
 #undef __perf_task
 #define __perf_task(t)	(t)
 
-/* cast any integer, pointer, or small struct to u64 */
-#define UINTTYPE(size) \
-	__typeof__(__builtin_choose_expr(size == 1,  (u8)1, \
-		   __builtin_choose_expr(size == 2, (u16)2, \
-		   __builtin_choose_expr(size == 4, (u32)3, \
-		   __builtin_choose_expr(size == 8, (u64)4, \
-					 (void)5)))))
-#define __CAST_TO_U64(x) ({ \
-	typeof(x) __src = (x); \
-	UINTTYPE(sizeof(x)) __dst; \
-	memcpy(&__dst, &__src, sizeof(__dst)); \
-	(u64)__dst; })
-
-#define __CAST1(a,...) __CAST_TO_U64(a)
-#define __CAST2(a,...) __CAST_TO_U64(a), __CAST1(__VA_ARGS__)
-#define __CAST3(a,...) __CAST_TO_U64(a), __CAST2(__VA_ARGS__)
-#define __CAST4(a,...) __CAST_TO_U64(a), __CAST3(__VA_ARGS__)
-#define __CAST5(a,...) __CAST_TO_U64(a), __CAST4(__VA_ARGS__)
-#define __CAST6(a,...) __CAST_TO_U64(a), __CAST5(__VA_ARGS__)
-#define __CAST7(a,...) __CAST_TO_U64(a), __CAST6(__VA_ARGS__)
-#define __CAST8(a,...) __CAST_TO_U64(a), __CAST7(__VA_ARGS__)
-#define __CAST9(a,...) __CAST_TO_U64(a), __CAST8(__VA_ARGS__)
-#define __CAST10(a,...) __CAST_TO_U64(a), __CAST9(__VA_ARGS__)
-#define __CAST11(a,...) __CAST_TO_U64(a), __CAST10(__VA_ARGS__)
-#define __CAST12(a,...) __CAST_TO_U64(a), __CAST11(__VA_ARGS__)
-/* tracepoints with more than 12 arguments will hit build error */
-#define CAST_TO_U64(...) CONCATENATE(__CAST, COUNT_ARGS(__VA_ARGS__))(__VA_ARGS__)
-
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 static notrace void							\
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ffc91d4935ac..3fb02fe799ab 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/bpf.h>
 #include <linux/bpf_perf_event.h>
+#include <linux/bpf_event.h>
 #include <linux/filter.h>
 #include <linux/uaccess.h>
 #include <linux/ctype.h>
@@ -1461,29 +1462,6 @@ void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 	rcu_read_unlock();
 }
 
-#define UNPACK(...)			__VA_ARGS__
-#define REPEAT_1(FN, DL, X, ...)	FN(X)
-#define REPEAT_2(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_1(FN, DL, __VA_ARGS__)
-#define REPEAT_3(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_2(FN, DL, __VA_ARGS__)
-#define REPEAT_4(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_3(FN, DL, __VA_ARGS__)
-#define REPEAT_5(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_4(FN, DL, __VA_ARGS__)
-#define REPEAT_6(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_5(FN, DL, __VA_ARGS__)
-#define REPEAT_7(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_6(FN, DL, __VA_ARGS__)
-#define REPEAT_8(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_7(FN, DL, __VA_ARGS__)
-#define REPEAT_9(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_8(FN, DL, __VA_ARGS__)
-#define REPEAT_10(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_9(FN, DL, __VA_ARGS__)
-#define REPEAT_11(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_10(FN, DL, __VA_ARGS__)
-#define REPEAT_12(FN, DL, X, ...)	FN(X) UNPACK DL REPEAT_11(FN, DL, __VA_ARGS__)
-#define REPEAT(X, FN, DL, ...)		REPEAT_##X(FN, DL, __VA_ARGS__)
-
-#define SARG(X)		u64 arg##X
-#define COPY(X)		args[X] = arg##X
-
-#define __DL_COM	(,)
-#define __DL_SEM	(;)
-
-#define __SEQ_0_11	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
-
 #define BPF_TRACE_DEFN_x(x)						\
 	void bpf_trace_run##x(struct bpf_prog *prog,			\
 			      REPEAT(x, SARG, __DL_COM, __SEQ_0_11))	\
-- 
2.20.1


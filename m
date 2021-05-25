Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8011839001E
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 13:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhEYLjl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhEYLjj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 07:39:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A48C061756
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 04:38:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3411415wmk.1
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 04:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfLdEwoGk/7GhieusdaU5QkoyU+VzaNb+POLqJ3PMqI=;
        b=Cc2sGFxMY14Y9TfPcAgGHXH3B6XtSyIpV3KnxF6zW+m9nAe92SziUsci+zWYivK9Sk
         pFGfKsJxf9kTRpCawoV9nj33wWP+vYRoLjh/SUeFSfxh8BjkBVkSFe+eZ/54bZoe8h0u
         YPlPB2P7mtUVqnJxAjSc7bc+Pygoc6eGa3J1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfLdEwoGk/7GhieusdaU5QkoyU+VzaNb+POLqJ3PMqI=;
        b=U9gGOumCSUiofnVjkG3JEi9Jw6pbIhYx0Tub7EYACkfFxKKYPhiJiUDcsHKmi1tWpE
         1fWiy3HTpccUxYEo0lgxHe5D1ai/daf82w4q/pTvlaKdaISKx2ZQoYc07NfABMiF9yyH
         mklKbHZJp56O0BvStdmwnD9/K71p1k7rSN0lxD8u7x+FprrtLKCUMlHI9euGgcnEMQjV
         51N4b8fcKqsupwHcAdY461yuUWG1gPswDzutc/DA8pebpJLGJpcQo2TX1MvHQ/mKUcqD
         nM358T2u0vA6m63pUyxOQXTvVndIF8v+cajIzjcPrt2DA3VUJtkzOaEX5qO+JSOtjGqE
         diTA==
X-Gm-Message-State: AOAM530sejo7S6C3VS0eH6k67nYpHAmWC22mGyjUMOAvl5Uof7OCP1On
        xsV6P9riGLx8ASFgG3YeeCeNTUZIOOinBw==
X-Google-Smtp-Source: ABdhPJwze/6RSxPbjW8nXRoD/D73fm0ymPPUd3tx7B7QTd2doFk20LMDk6DP5KY1BexZ/Z0fJzkG9A==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr23630323wml.78.1621942687322;
        Tue, 25 May 2021 04:38:07 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:2c9a:c46e:e3f8:1d1d])
        by smtp.gmail.com with ESMTPSA id i11sm16030509wrq.26.2021.05.25.04.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 04:38:06 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
Date:   Tue, 25 May 2021 13:37:32 +0200
Message-Id: <20210525113732.2648158-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These macros are convenient wrappers around the bpf_seq_printf and
bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
targets low level tracing primitives. bpf_helpers.h is a better fit.

The __bpf_narg and __bpf_apply are needed in both files and provided
twice.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/bpf/preload/iterators/iterators.bpf.c  |  1 -
 tools/lib/bpf/bpf_helpers.h                   | 58 +++++++++++++++++++
 tools/lib/bpf/bpf_tracing.h                   | 52 -----------------
 .../bpf/progs/bpf_iter_bpf_hash_map.c         |  1 -
 .../selftests/bpf/progs/bpf_iter_bpf_map.c    |  1 -
 .../selftests/bpf/progs/bpf_iter_ipv6_route.c |  1 -
 .../selftests/bpf/progs/bpf_iter_netlink.c    |  1 -
 .../selftests/bpf/progs/bpf_iter_task.c       |  1 -
 .../selftests/bpf/progs/bpf_iter_task_btf.c   |  1 -
 .../selftests/bpf/progs/bpf_iter_task_file.c  |  1 -
 .../selftests/bpf/progs/bpf_iter_task_stack.c |  1 -
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |  1 -
 .../selftests/bpf/progs/bpf_iter_tcp4.c       |  1 -
 .../selftests/bpf/progs/bpf_iter_tcp6.c       |  1 -
 .../selftests/bpf/progs/bpf_iter_udp4.c       |  1 -
 .../selftests/bpf/progs/bpf_iter_udp6.c       |  1 -
 .../selftests/bpf/progs/test_snprintf.c       |  1 -
 17 files changed, 58 insertions(+), 67 deletions(-)

diff --git a/kernel/bpf/preload/iterators/iterators.bpf.c b/kernel/bpf/preload/iterators/iterators.bpf.c
index 52aa7b38e8b8..03af863314ea 100644
--- a/kernel/bpf/preload/iterators/iterators.bpf.c
+++ b/kernel/bpf/preload/iterators/iterators.bpf.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Facebook */
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
 #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 9720dc0b4605..eade4f335ad1 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -158,4 +158,62 @@ enum libbpf_tristate {
 #define __kconfig __attribute__((section(".kconfig")))
 #define __ksym __attribute__((section(".ksyms")))
 
+#define ___bpf_concat(a, b) a ## b
+#define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
+#define ___bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, N, ...) N
+#define ___bpf_narg(...) \
+	___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+
+#define ___bpf_fill0(arr, p, x) do {} while (0)
+#define ___bpf_fill1(arr, p, x) arr[p] = x
+#define ___bpf_fill2(arr, p, x, args...) arr[p] = x; ___bpf_fill1(arr, p + 1, args)
+#define ___bpf_fill3(arr, p, x, args...) arr[p] = x; ___bpf_fill2(arr, p + 1, args)
+#define ___bpf_fill4(arr, p, x, args...) arr[p] = x; ___bpf_fill3(arr, p + 1, args)
+#define ___bpf_fill5(arr, p, x, args...) arr[p] = x; ___bpf_fill4(arr, p + 1, args)
+#define ___bpf_fill6(arr, p, x, args...) arr[p] = x; ___bpf_fill5(arr, p + 1, args)
+#define ___bpf_fill7(arr, p, x, args...) arr[p] = x; ___bpf_fill6(arr, p + 1, args)
+#define ___bpf_fill8(arr, p, x, args...) arr[p] = x; ___bpf_fill7(arr, p + 1, args)
+#define ___bpf_fill9(arr, p, x, args...) arr[p] = x; ___bpf_fill8(arr, p + 1, args)
+#define ___bpf_fill10(arr, p, x, args...) arr[p] = x; ___bpf_fill9(arr, p + 1, args)
+#define ___bpf_fill11(arr, p, x, args...) arr[p] = x; ___bpf_fill10(arr, p + 1, args)
+#define ___bpf_fill12(arr, p, x, args...) arr[p] = x; ___bpf_fill11(arr, p + 1, args)
+#define ___bpf_fill(arr, args...) \
+	___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
+
+/*
+ * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
+ * in a structure.
+ */
+#define BPF_SEQ_PRINTF(seq, fmt, args...)			\
+({								\
+	static const char ___fmt[] = fmt;			\
+	unsigned long long ___param[___bpf_narg(args)];		\
+								\
+	_Pragma("GCC diagnostic push")				\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
+	___bpf_fill(___param, args);				\
+	_Pragma("GCC diagnostic pop")				\
+								\
+	bpf_seq_printf(seq, ___fmt, sizeof(___fmt),		\
+		       ___param, sizeof(___param));		\
+})
+
+/*
+ * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
+ * an array of u64.
+ */
+#define BPF_SNPRINTF(out, out_size, fmt, args...)		\
+({								\
+	static const char ___fmt[] = fmt;			\
+	unsigned long long ___param[___bpf_narg(args)];		\
+								\
+	_Pragma("GCC diagnostic push")				\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
+	___bpf_fill(___param, args);				\
+	_Pragma("GCC diagnostic pop")				\
+								\
+	bpf_snprintf(out, out_size, ___fmt,			\
+		     ___param, sizeof(___param));		\
+})
+
 #endif
diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 8c954ebc0c7c..2189f6bf6d2d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -413,56 +413,4 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
-#define ___bpf_fill0(arr, p, x) do {} while (0)
-#define ___bpf_fill1(arr, p, x) arr[p] = x
-#define ___bpf_fill2(arr, p, x, args...) arr[p] = x; ___bpf_fill1(arr, p + 1, args)
-#define ___bpf_fill3(arr, p, x, args...) arr[p] = x; ___bpf_fill2(arr, p + 1, args)
-#define ___bpf_fill4(arr, p, x, args...) arr[p] = x; ___bpf_fill3(arr, p + 1, args)
-#define ___bpf_fill5(arr, p, x, args...) arr[p] = x; ___bpf_fill4(arr, p + 1, args)
-#define ___bpf_fill6(arr, p, x, args...) arr[p] = x; ___bpf_fill5(arr, p + 1, args)
-#define ___bpf_fill7(arr, p, x, args...) arr[p] = x; ___bpf_fill6(arr, p + 1, args)
-#define ___bpf_fill8(arr, p, x, args...) arr[p] = x; ___bpf_fill7(arr, p + 1, args)
-#define ___bpf_fill9(arr, p, x, args...) arr[p] = x; ___bpf_fill8(arr, p + 1, args)
-#define ___bpf_fill10(arr, p, x, args...) arr[p] = x; ___bpf_fill9(arr, p + 1, args)
-#define ___bpf_fill11(arr, p, x, args...) arr[p] = x; ___bpf_fill10(arr, p + 1, args)
-#define ___bpf_fill12(arr, p, x, args...) arr[p] = x; ___bpf_fill11(arr, p + 1, args)
-#define ___bpf_fill(arr, args...) \
-	___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
-
-/*
- * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
- * in a structure.
- */
-#define BPF_SEQ_PRINTF(seq, fmt, args...)			\
-({								\
-	static const char ___fmt[] = fmt;			\
-	unsigned long long ___param[___bpf_narg(args)];		\
-								\
-	_Pragma("GCC diagnostic push")				\
-	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
-	___bpf_fill(___param, args);				\
-	_Pragma("GCC diagnostic pop")				\
-								\
-	bpf_seq_printf(seq, ___fmt, sizeof(___fmt),		\
-		       ___param, sizeof(___param));		\
-})
-
-/*
- * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
- * an array of u64.
- */
-#define BPF_SNPRINTF(out, out_size, fmt, args...)		\
-({								\
-	static const char ___fmt[] = fmt;			\
-	unsigned long long ___param[___bpf_narg(args)];		\
-								\
-	_Pragma("GCC diagnostic push")				\
-	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
-	___bpf_fill(___param, args);				\
-	_Pragma("GCC diagnostic pop")				\
-								\
-	bpf_snprintf(out, out_size, ___fmt,			\
-		     ___param, sizeof(___param));		\
-})
-
 #endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
index 6dfce3fd68bc..0aa3cd34cbe3 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Facebook */
 #include "bpf_iter.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
index b83b5d2e17dc..6c39e86b666f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_map.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Facebook */
 #include "bpf_iter.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c b/tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c
index d58d9f1642b5..784a610ce039 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_ipv6_route.c
@@ -3,7 +3,6 @@
 #include "bpf_iter.h"
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
index 95989f4c99b5..a28e51e2dcee 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
@@ -3,7 +3,6 @@
 #include "bpf_iter.h"
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
index b7f32c160f4e..c86b93f33b32 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Facebook */
 #include "bpf_iter.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c
index a1ddc36f13ec..bca8b889cb10 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_btf.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020, Oracle and/or its affiliates. */
 #include "bpf_iter.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
 #include <errno.h>
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
index b2f7c7c5f952..6e7b400888fe 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Facebook */
 #include "bpf_iter.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
index 43c36f5f7649..f2b8167b72a8 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Facebook */
 #include "bpf_iter.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
index 11d1aa37cf11..4ea6a37d1345 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2020 Facebook */
 #include "bpf_iter.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index 54380c5e1069..2e4775c35414 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -3,7 +3,6 @@
 #include "bpf_iter.h"
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include <bpf/bpf_endian.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index b4fbddfa4e10..943f7bba180e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -3,7 +3,6 @@
 #include "bpf_iter.h"
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include <bpf/bpf_endian.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
index f258583afbbd..cf0c485b1ed7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
@@ -3,7 +3,6 @@
 #include "bpf_iter.h"
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include <bpf/bpf_endian.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
index 65f93bb03f0f..5031e21c433f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
@@ -3,7 +3,6 @@
 #include "bpf_iter.h"
 #include "bpf_tracing_net.h"
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include <bpf/bpf_endian.h>
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_snprintf.c b/tools/testing/selftests/bpf/progs/test_snprintf.c
index e35129bea0a0..e2ad26150f9b 100644
--- a/tools/testing/selftests/bpf/progs/test_snprintf.c
+++ b/tools/testing/selftests/bpf/progs/test_snprintf.c
@@ -3,7 +3,6 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 
 __u32 pid = 0;
 
-- 
2.31.1.818.g46aad6cb9e-goog


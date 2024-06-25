Return-Path: <bpf+bounces-33012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87567915E21
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 07:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7FFB2118B
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 05:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CECB145A0A;
	Tue, 25 Jun 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WscYiCEy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358F1459F9
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719293268; cv=none; b=To/XC/8XlfAexi0iFfTdeimCr0vKBRFD7Olw1trh2RykLFLHsS8GGJ1nXCKzjv+4tqG08w9wO4ZoLO7LPh6CKfIO5ImmBP7Aa91whc6812VNdB6F+YPt4ULMyuAWIDlGDWHxLm9Hi7KtiojigQQn0gnTXdTISjksqjiqOp0or8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719293268; c=relaxed/simple;
	bh=5EJh8etRIQNnAAIADoqfuA1TBLItK4lUldVuGM+WzUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGc83ayKYvIutSbD0OE3KGwV9lGPmYpeRT6v3+SFs6pIb1R0phpEcbs22Psw2MWQnnxSLMtMY7yguttoWuO8cFlXgLhjwGzcOO/C0itEP9eB30MzJw1t99RYA2uiIbfub+7BpMq2Kst5Ro1k+pFdOUmKepbUF+Yj3H4fVFvWEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WscYiCEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381AEC32782;
	Tue, 25 Jun 2024 05:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719293267;
	bh=5EJh8etRIQNnAAIADoqfuA1TBLItK4lUldVuGM+WzUw=;
	h=From:To:Cc:Subject:Date:From;
	b=WscYiCEyNyekbMx53kRs8kxbTY9Etehe2YjjJ349aI4sVgDOcgNMvCzio2BtxrTkn
	 sZ+qvtP9/8yG4R0A5vCU0E9eUl3HL7g6wlL3HFg2vJ4IUkK82XrQtnfBVPUn0UcN5x
	 X1gF1FuPMNsB0h6AA8bk7JOj7uNLhqyQbKO0jCXRWpSe6h+PxFULyhFaFWzO1vvc+3
	 DJoCyo4m7BEcirZsSnWLX9t1ZO15KEVHyuzwH2fj7MzomG+Uib9agI6Ag6cAH1/oCK
	 CEWIUMYylaykx0Jp19UYbzt1T3dCemttAgjt+c0uILuUdlZv0RoqrgBpbPLo0ZJdBA
	 H9FVM0menchqQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
Date: Tue, 25 Jun 2024 07:27:41 +0200
Message-ID: <20240625052741.3640731-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARRAY_SIZE is used on multiple places, move its definition in
bpf_misc.h header.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h                 | 2 ++
 tools/testing/selftests/bpf/progs/iters.c                    | 2 --
 tools/testing/selftests/bpf/progs/kprobe_multi_session.c     | 3 +--
 tools/testing/selftests/bpf/progs/linked_list.c              | 5 +----
 tools/testing/selftests/bpf/progs/netif_receive_skb.c        | 5 +----
 tools/testing/selftests/bpf/progs/profiler.inc.h             | 5 +----
 tools/testing/selftests/bpf/progs/setget_sockopt.c           | 5 +----
 tools/testing/selftests/bpf/progs/test_bpf_ma.c              | 4 ----
 tools/testing/selftests/bpf/progs/test_sysctl_loop1.c        | 5 +----
 tools/testing/selftests/bpf/progs/test_sysctl_loop2.c        | 5 +----
 tools/testing/selftests/bpf/progs/test_sysctl_prog.c         | 5 +----
 .../testing/selftests/bpf/progs/test_tcp_custom_syncookie.c  | 1 +
 .../testing/selftests/bpf/progs/test_tcp_custom_syncookie.h  | 2 --
 .../testing/selftests/bpf/progs/verifier_subprog_precision.c | 2 --
 14 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c0280bd2f340..ac6ab1b977a1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -140,4 +140,6 @@
 /* make it look to compiler like value is read and written */
 #define __sink(expr) asm volatile("" : "+g"(expr))
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index fe65e0952a1e..16bdc3e25591 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -7,8 +7,6 @@
 #include "bpf_misc.h"
 #include "bpf_compiler.h"
 
-#define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
-
 static volatile int zero = 0;
 
 int my_pid;
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
index bbba9eb46551..bd8b7fb7061e 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_session.c
@@ -4,8 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
 #include "bpf_kfuncs.h"
-
-#define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index f69bf3e30321..421f40835acd 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -4,10 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_experimental.h"
-
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (int)(sizeof(x) / sizeof((x)[0]))
-#endif
+#include "bpf_misc.h"
 
 #include "linked_list.h"
 
diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
index c0062645fc68..9e067dcbf607 100644
--- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
+++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
 
 #include <errno.h>
 
@@ -23,10 +24,6 @@ bool skip = false;
 #define BADPTR			0
 #endif
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
-#endif
-
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(max_entries, 1);
diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 6957d9f2805e..8bd1ebd7d6af 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -9,6 +9,7 @@
 #include "err.h"
 #include "bpf_experimental.h"
 #include "bpf_compiler.h"
+#include "bpf_misc.h"
 
 #ifndef NULL
 #define NULL 0
@@ -133,10 +134,6 @@ struct {
 	__uint(max_entries, 16);
 } disallowed_exec_inodes SEC(".maps");
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(arr) (int)(sizeof(arr) / sizeof(arr[0]))
-#endif
-
 static INLINE bool IS_ERR(const void* ptr)
 {
 	return IS_ERR_VALUE((unsigned long)ptr);
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 7a438600ae98..60518aed1ffc 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -6,10 +6,7 @@
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
+#include "bpf_misc.h"
 
 extern unsigned long CONFIG_HZ __kconfig;
 
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
index 3494ca30fa7f..4a4e0b8d9b72 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
@@ -7,10 +7,6 @@
 #include "bpf_experimental.h"
 #include "bpf_misc.h"
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 struct generic_map_value {
 	void *data;
 };
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
index 7f74077d6622..548660e299a5 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
@@ -10,10 +10,7 @@
 #include <bpf/bpf_helpers.h>
 
 #include "bpf_compiler.h"
-
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
+#include "bpf_misc.h"
 
 /* tcp_mem sysctl has only 3 ints, but this test is doing TCP_MEM_LOOPS */
 #define TCP_MEM_LOOPS 28  /* because 30 doesn't fit into 512 bytes of stack */
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
index 68a75436e8af..81249d119a8b 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
@@ -10,10 +10,7 @@
 #include <bpf/bpf_helpers.h>
 
 #include "bpf_compiler.h"
-
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
+#include "bpf_misc.h"
 
 /* tcp_mem sysctl has only 3 ints, but this test is doing TCP_MEM_LOOPS */
 #define TCP_MEM_LOOPS 20  /* because 30 doesn't fit into 512 bytes of stack */
diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
index efc3c61f7852..bbdd08764789 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
@@ -10,6 +10,7 @@
 #include <bpf/bpf_helpers.h>
 
 #include "bpf_compiler.h"
+#include "bpf_misc.h"
 
 /* Max supported length of a string with unsigned long in base 10 (pow2 - 1). */
 #define MAX_ULONG_STR_LEN 0xF
@@ -17,10 +18,6 @@
 /* Max supported length of sysctl value string (pow2). */
 #define MAX_VALUE_STR_LEN 0x40
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-#endif
-
 const char tcp_mem_name[] = "net/ipv4/tcp_mem";
 static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
index c8e4553648bf..44ee0d037f95 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
@@ -9,6 +9,7 @@
 #include "bpf_kfuncs.h"
 #include "test_siphash.h"
 #include "test_tcp_custom_syncookie.h"
+#include "bpf_misc.h"
 
 #define MAX_PACKET_OFF 0xffff
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
index 29a6a53cf229..f8b1b7e68d2e 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
+++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
@@ -7,8 +7,6 @@
 #define __packed __attribute__((__packed__))
 #define __force
 
-#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
-
 #define swap(a, b)				\
 	do {					\
 		typeof(a) __tmp = (a);		\
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 4a58e0398e72..6a6fad625f7e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -8,8 +8,6 @@
 #include "bpf_misc.h"
 #include <../../../tools/include/linux/filter.h>
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
-
 int vals[] SEC(".data.vals") = {1, 2, 3, 4};
 
 __naked __noinline __used
-- 
2.45.2



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F3679C0A
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 15:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjAXOgr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 09:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjAXOgq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 09:36:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916F768D
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 06:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45254B811C2
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 14:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2798BC433EF;
        Tue, 24 Jan 2023 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674571002;
        bh=/qS2rz1X8/tcWdTusiWUx4wW8Vb+Nqk5Kr2EmEuqibc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgl/isBppMgHYBXvjW5zIPCkYqQvgVrUkHLdF1u587I0Tmiibhm3S85HRIkrMit6v
         TtDPlJNnBTxWXuoDJkj+7ZT5rY+Sra9lkPVY2m1PvPZ03NsPJ2X1DFBxHECpsYNbRp
         bImdxrKGiFmY6Fui7hy7XAdbK/M6w2lJ+K+5PuPmRC7N8kIC5eymeU6WoXAbh2Nr6d
         amNdlxsreH32V1Lp7hpmekDHN+g/PLuqGVu9CTfZHvMmP6aOmEY/cJgVxzF2G/eqs1
         iWwPp9+KAaSu+/V/sMqDCs17pPKx2al2cZWMB+WJ6wIfpYgb5FKR46kMpC1TdlNtNK
         UjfYJfn0Ruobg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 1/5] selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
Date:   Tue, 24 Jan 2023 15:36:22 +0100
Message-Id: <20230124143626.250719-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124143626.250719-1-jolsa@kernel.org>
References: <20230124143626.250719-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move all kfunc exports into separate header file and include it
in tests that need it.

We will move all test kfuncs into bpf_testmod in following change,
so it's convenient to have declarations in single place.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 89 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/cb_refs.c   |  1 +
 .../selftests/bpf/progs/jit_probe_mem.c       |  3 +-
 .../bpf/progs/kfunc_call_destructive.c        |  3 +-
 .../selftests/bpf/progs/kfunc_call_fail.c     |  9 +-
 .../selftests/bpf/progs/kfunc_call_race.c     |  3 +-
 .../selftests/bpf/progs/kfunc_call_test.c     | 15 +---
 .../bpf/progs/kfunc_call_test_subprog.c       | 17 +++-
 tools/testing/selftests/bpf/progs/map_kptr.c  |  1 +
 .../selftests/bpf/progs/map_kptr_fail.c       |  1 +
 10 files changed, 111 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
new file mode 100644
index 000000000000..41d4f8543a25
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BPF_TESTMOD_KFUNC_H
+#define _BPF_TESTMOD_KFUNC_H
+
+#ifndef __ksym
+#define __ksym __attribute__((section(".ksyms")))
+#endif
+
+struct prog_test_pass1 {
+	int x0;
+	struct {
+		int x1;
+		struct {
+			int x2;
+			struct {
+				int x3;
+			};
+		};
+	};
+};
+
+struct prog_test_pass2 {
+	int len;
+	short arr1[4];
+	struct {
+		char arr2[4];
+		unsigned long arr3[8];
+	} x;
+};
+
+struct prog_test_fail1 {
+	void *p;
+	int x;
+};
+
+struct prog_test_fail2 {
+	int x8;
+	struct prog_test_pass1 x;
+};
+
+struct prog_test_fail3 {
+	int len;
+	char arr1[2];
+	char arr2[];
+};
+
+struct prog_test_member1 {
+	int a;
+};
+
+struct prog_test_member {
+	struct prog_test_member1 m;
+	int c;
+};
+
+struct prog_test_ref_kfunc {
+	int a;
+	int b;
+	struct prog_test_member memb;
+	struct prog_test_ref_kfunc *next;
+	refcount_t cnt;
+};
+
+extern struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
+extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
+
+extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
+extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
+
+extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
+
+extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
+				__u32 c, __u64 d) __ksym;
+extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
+extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
+
+extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
+extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
+extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
+extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
+
+extern void bpf_kfunc_call_test_destructive(void) __ksym;
+
+#endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
index 7653df1bc787..b905833dc9d3 100644
--- a/tools/testing/selftests/bpf/progs/cb_refs.c
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -2,6 +2,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_testmod/bpf_testmod_kfunc.h"
 
 struct map_value {
 	struct prog_test_ref_kfunc __kptr_ref *ptr;
diff --git a/tools/testing/selftests/bpf/progs/jit_probe_mem.c b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
index 2d2e61470794..6bfcd652d701 100644
--- a/tools/testing/selftests/bpf/progs/jit_probe_mem.c
+++ b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
@@ -3,12 +3,11 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_testmod/bpf_testmod_kfunc.h"
 
 static struct prog_test_ref_kfunc __kptr_ref *v;
 long total_sum = -1;
 
-extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 
 SEC("tc")
 int test_jit_probe_mem(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c b/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
index 767472bc5a97..6a9b13a79ae8 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-
-extern void bpf_kfunc_call_test_destructive(void) __ksym;
+#include "bpf_testmod/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_destructive_test(void)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index b98313d391c6..e857d1c4cf5b 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
@@ -2,14 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-
-extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
-extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
-extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
-extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
-extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
+#include "bpf_testmod/bpf_testmod_kfunc.h"
 
 struct syscall_test_args {
 	__u8 data[16];
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_race.c b/tools/testing/selftests/bpf/progs/kfunc_call_race.c
index 4e8fed75a4e0..a9558e434611 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_race.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_race.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-
-extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
+#include "bpf_testmod/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_call_fail(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index f636e50be259..0beb96cf96f8 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -2,20 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-
-extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
-extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
-				  __u32 c, __u64 d) __ksym;
-
-extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
-extern void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
-extern void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
-extern void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
-extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
-extern void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
-extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
-extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+#include "bpf_testmod/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_call_test2(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
index c1fdecabeabf..f74c78bb5efd 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
@@ -4,10 +4,21 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_tcp_helpers.h"
 
+/*
+ * We can't include vmlinux.h, because it conflicts with bpf_tcp_helpers.h,
+ * but we need refcount_t typedef for bpf_testmod_kfunc.h.
+ * Adding it directly.
+ */
+typedef struct {
+	int counter;
+} atomic_t;
+typedef struct refcount_struct {
+	atomic_t refs;
+} refcount_t;
+
+#include "bpf_testmod/bpf_testmod_kfunc.h"
+
 extern const int bpf_prog_active __ksym;
-extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
-				  __u32 c, __u64 d) __ksym;
-extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 int active_res = -1;
 int sk_state_res = -1;
 
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index eb8217803493..753305c22c2f 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -2,6 +2,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_testmod/bpf_testmod_kfunc.h"
 
 struct map_value {
 	struct prog_test_ref_kfunc __kptr *unref_ptr;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index 760e41e1a632..3b5076d951df 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
+#include "bpf_testmod/bpf_testmod_kfunc.h"
 
 struct map_value {
 	char buf[8];
-- 
2.39.1


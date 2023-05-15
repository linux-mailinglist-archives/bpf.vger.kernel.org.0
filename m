Return-Path: <bpf+bounces-523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C0702E6C
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7E3281319
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2AC8FA;
	Mon, 15 May 2023 13:38:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9EC8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3B2C433D2;
	Mon, 15 May 2023 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157902;
	bh=3GgYhPdwI7A6BCWbtw6Icn57pta5u6llrmnzcguiKQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReHhnNTQOeA+IweN1oljITz69fpii/vQ/FABETP4pmrvkJXLyDWv8WM8b7ErrzrmJ
	 AbOuaHSZMeiNdRfQ72gScMMF4wVmfGdstbyxi9hH6HvMhPIPWVTsW2FA9jya4586dr
	 ic56tBXGoNil0njVZ8zh1JjXl1Vw1OhAmzklNTxOV9SSYv8dzLACP3bhD+9Ljt7wED
	 sX7OCwdoaCrgRHd3re7CAgquXHicFlSw0FGOja8c1QOlyCKI793+IIuFcOXVslg00A
	 TIBzd5N3wkM/XNxWhEZz7jNolLaX8nkAEkkriaOpZwG4tQMQy4kvXajsWfWpqZwG5r
	 ZPXJRHFmB5iUg==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 02/10] selftests/bpf: Move kfunc exports to bpf_testmod/bpf_testmod_kfunc.h
Date: Mon, 15 May 2023 15:37:48 +0200
Message-Id: <20230515133756.1658301-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
References: <20230515133756.1658301-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move all kfunc exports into separate bpf_testmod_kfunc.h header file
and include it in tests that need it.

We will move all test kfuncs into bpf_testmod in following change,
so it's convenient to have declarations in single place.

The bpf_testmod_kfunc.h is included by both bpf_testmod and bpf
programs that use test kfuncs.

As suggested by David, the bpf_testmod_kfunc.h includes vmlinux.h
and bpf/bpf_helpers.h for bpf programs build, so the declarations
have proper __ksym attribute and we can resolve all the structs.

Note in kfunc_call_test_subprog.c we can no longer use the sk_state
define from bpf_tcp_helpers.h (because it clashed with vmlinux.h)
and we need to address __sk_common.skc_state field directly.

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       | 40 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/cb_refs.c   |  4 +-
 .../selftests/bpf/progs/jit_probe_mem.c       |  4 +-
 .../bpf/progs/kfunc_call_destructive.c        |  3 +-
 .../selftests/bpf/progs/kfunc_call_fail.c     |  9 +----
 .../selftests/bpf/progs/kfunc_call_race.c     |  3 +-
 .../selftests/bpf/progs/kfunc_call_test.c     | 17 +-------
 .../bpf/progs/kfunc_call_test_subprog.c       |  9 +----
 .../selftests/bpf/progs/local_kptr_stash.c    |  5 +--
 tools/testing/selftests/bpf/progs/map_kptr.c  |  5 +--
 .../selftests/bpf/progs/map_kptr_fail.c       |  4 +-
 11 files changed, 52 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
new file mode 100644
index 000000000000..f0755135061d
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _BPF_TESTMOD_KFUNC_H
+#define _BPF_TESTMOD_KFUNC_H
+
+#ifndef __KERNEL__
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#else
+#define __ksym
+#endif
+
+extern struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr) __ksym;
+extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
+void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
+
+extern void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+extern int *bpf_kfunc_call_test_get_rdwr_mem(struct prog_test_ref_kfunc *p, const int rdwr_buf_size) __ksym;
+extern int *bpf_kfunc_call_test_get_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+extern int *bpf_kfunc_call_test_acq_rdonly_mem(struct prog_test_ref_kfunc *p, const int rdonly_buf_size) __ksym;
+extern void bpf_kfunc_call_int_mem_release(int *p) __ksym;
+extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
+
+extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
+
+extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
+				__u32 c, __u64 d) __ksym;
+extern int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
+extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
+extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
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
index 50f95ec61165..76d661b20e87 100644
--- a/tools/testing/selftests/bpf/progs/cb_refs.c
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -2,6 +2,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 struct map_value {
 	struct prog_test_ref_kfunc __kptr *ptr;
@@ -14,9 +15,6 @@ struct {
 	__uint(max_entries, 16);
 } array_map SEC(".maps");
 
-extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
-
 static __noinline int cb1(void *map, void *key, void *value, void *ctx)
 {
 	void *p = *(void **)ctx;
diff --git a/tools/testing/selftests/bpf/progs/jit_probe_mem.c b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
index 13f00ca2ed0a..f9789e668297 100644
--- a/tools/testing/selftests/bpf/progs/jit_probe_mem.c
+++ b/tools/testing/selftests/bpf/progs/jit_probe_mem.c
@@ -3,13 +3,11 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 static struct prog_test_ref_kfunc __kptr *v;
 long total_sum = -1;
 
-extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
-
 SEC("tc")
 int test_jit_probe_mem(struct __sk_buff *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c b/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
index 767472bc5a97..7632d9ecb253 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_destructive.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-
-extern void bpf_kfunc_call_test_destructive(void) __ksym;
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_destructive_test(void)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index b98313d391c6..4b0b7b79cdfb 100644
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
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 struct syscall_test_args {
 	__u8 data[16];
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_race.c b/tools/testing/selftests/bpf/progs/kfunc_call_race.c
index 4e8fed75a4e0..d532af07decf 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_race.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_race.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-
-extern void bpf_testmod_test_mod_kfunc(int i) __ksym;
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_call_fail(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 7daa8f5720b9..cf68d1e48a0f 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -2,22 +2,7 @@
 /* Copyright (c) 2021 Facebook */
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
-
-extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
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
-extern u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 SEC("tc")
 int kfunc_call_test4(struct __sk_buff *skb)
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
index c1fdecabeabf..2380c75e74ce 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test_subprog.c
@@ -1,13 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 extern const int bpf_prog_active __ksym;
-extern __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
-				  __u32 c, __u64 d) __ksym;
-extern struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 int active_res = -1;
 int sk_state_res = -1;
 
@@ -28,7 +23,7 @@ int __noinline f1(struct __sk_buff *skb)
 	if (active)
 		active_res = *active;
 
-	sk_state_res = bpf_kfunc_call_test3((struct sock *)sk)->sk_state;
+	sk_state_res = bpf_kfunc_call_test3((struct sock *)sk)->__sk_common.skc_state;
 
 	return (__u32)bpf_kfunc_call_test1((struct sock *)sk, 1, 2, 3, 4);
 }
diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index 0ef286da092b..06838083079c 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -5,7 +5,8 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
-#include "bpf_experimental.h"
+#include "../bpf_experimental.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 struct node_data {
 	long key;
@@ -32,8 +33,6 @@ struct map_value {
  */
 struct node_data *just_here_because_btf_bug;
 
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
-
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
 	__type(key, int);
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index d7150041e5d1..da30f0d59364 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -2,6 +2,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 struct map_value {
 	struct prog_test_ref_kfunc __kptr_untrusted *unref_ptr;
@@ -114,10 +115,6 @@ DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_map, hash_of_hash_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_malloc_map, hash_of_hash_malloc_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, lru_hash_map, hash_of_lru_hash_maps);
 
-extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
-void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
-
 #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
 
 static void test_kptr_unref(struct map_value *v)
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index da8c724f839b..450bb373b179 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
 
 struct map_value {
 	char buf[8];
@@ -19,9 +20,6 @@ struct array_map {
 	__uint(max_entries, 1);
 } array_map SEC(".maps");
 
-extern struct prog_test_ref_kfunc *bpf_kfunc_call_test_acquire(unsigned long *sp) __ksym;
-extern void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
-
 SEC("?tc")
 __failure __msg("kptr access size must be BPF_DW")
 int size_not_bpf_dw(struct __sk_buff *ctx)
-- 
2.40.1



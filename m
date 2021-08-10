Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002973E82EB
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 20:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhHJSWm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbhHJSWg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 14:22:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B2CC0817CC
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 11:06:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p71-20020a25424a0000b029056092741626so21642971yba.19
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6WnPzluv1zSHK7f5mcMZrKm+IWLtHDL7ra8NXePPBdA=;
        b=o+ztxxfjR11xTKNi/icw21q6p5qhS/UVudcRgfuAQ8Ub3PosKGwugnqfbMFQ9wUVoK
         IkTFVFWngBgPV0QIcG2wpt1GxTQgMZsA/yTEH6HzkPHHcoen3NetF7sGOo1A7+z6aVn4
         yN6kZPZz71lAzTSRWRwYQXsnTycXwk59Xwo2fep6p7t+lylNqVRFimtx0llwqI9iA+Ez
         6kVFBvm7yacW7RTX7BL0TIDsoWvFtI8n/XR/2jwixJl2jHdzuJmL9RUPA+up3St+cOKQ
         2ekXsJaYbem3dmjfzCGtb36LDFKUP+Y5okQmjwmzb+0WJBdL482WVXX/GGgUeVskpGEP
         KGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6WnPzluv1zSHK7f5mcMZrKm+IWLtHDL7ra8NXePPBdA=;
        b=WFHCGZQM93coG8ejqmOjTzavnVdgD9/G7uNi50WH8WM/1dsELhc4FfQVYEK84knGQP
         DMLgzHUx5HTvlUE1WzkMXUs9eXzzcNXktzJTxKO+FBpVuIGRRen617GzU2+vUeYQS9JW
         WzDevulXJJod6mkK741RkqWcJjHqTgpmb6ubE2BdgHAVSleUo31k6rx+V1K+xPgbUET4
         ISGlHROD8lLErly3mFVBBueqOyYzppfd/ZikhzNbxGAcQ0A1ub+fIe6jb8k4oHCT0L81
         /pgb48WRewvQAx8QRLs1DzabU7ujn+kaLSvh6cGvzkN9FOf377ngpyx3Dej00aZRGscM
         V8mg==
X-Gm-Message-State: AOAM533k7+Y/ZY/91meNXnMzimpFhs97558XIeR3IzwYRwJT9sW1iVpO
        8Ds172AH6i8VTYD9zkRUyRqtzeBkMBQ=
X-Google-Smtp-Source: ABdhPJzYGvCk29ZJEZwFImUUSMGVm/0/sshHWDHhiPIjlsSuEuRyT55Fs0V4+jKLmmOc6m79gDWx5CjOqgw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bb43:3980:e4ee:1b54])
 (user=haoluo job=sendgmr) by 2002:a25:d1c2:: with SMTP id i185mr40881010ybg.466.1628618771645;
 Tue, 10 Aug 2021 11:06:11 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:06:08 -0700
Message-Id: <20210810180608.1858888-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH bpf-next v2] libbpf: support weak typed ksyms.
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently weak typeless ksyms have default value zero, when they don't
exist in the kernel. However, weak typed ksyms are rejected by libbpf
if they can not be resolved. This means that if a bpf object contains
the declaration of a nonexistent weak typed ksym, it will be rejected
even if there is no program that references the symbol.

Nonexistent weak typed ksyms can also default to zero just like
typeless ones. This allows programs that access weak typed ksyms to be
accepted by verifier, if the accesses are guarded. For example,

extern const int bpf_link_fops3 __ksym __weak;

/* then in BPF program */

if (&bpf_link_fops3) {
   /* use bpf_link_fops3 */
}

If actual use of nonexistent typed ksym is not guarded properly,
verifier would see that register is not PTR_TO_BTF_ID and wouldn't
allow to use it for direct memory reads or passing it to BPF helpers.

Signed-off-by: Hao Luo <haoluo@google.com>
---
Changes since v1:
 - Weak typed symbols default to zero, as suggested by Andrii.
 - Use ASSERT_XXX() for tets.

 tools/lib/bpf/libbpf.c                        | 17 ++++--
 .../selftests/bpf/prog_tests/ksyms_btf.c      | 25 ++++++++
 .../selftests/bpf/progs/test_ksyms_weak.c     | 57 +++++++++++++++++++
 3 files changed, 94 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_weak.c

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb106e8c42cb..e7547a2967cf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5277,11 +5277,11 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 				}
 				insn[1].imm = ext->kcfg.data_off;
 			} else /* EXT_KSYM */ {
-				if (ext->ksym.type_id) { /* typed ksyms */
+				if (ext->ksym.type_id && ext->is_set) { /* typed ksyms */
 					insn[0].src_reg = BPF_PSEUDO_BTF_ID;
 					insn[0].imm = ext->ksym.kernel_btf_id;
 					insn[1].imm = ext->ksym.kernel_btf_obj_fd;
-				} else { /* typeless ksyms */
+				} else { /* typeless ksyms or unresolved typed ksyms */
 					insn[0].imm = (__u32)ext->ksym.addr;
 					insn[1].imm = ext->ksym.addr >> 32;
 				}
@@ -6584,7 +6584,7 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
 }
 
 static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
-			    __u16 kind, struct btf **res_btf,
+			    __u16 kind, bool is_weak, struct btf **res_btf,
 			    int *res_btf_fd)
 {
 	int i, id, btf_fd, err;
@@ -6608,6 +6608,9 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
 				break;
 		}
 	}
+	if (is_weak && id == -ENOENT)
+		return 0;
+
 	if (id <= 0) {
 		pr_warn("extern (%s ksym) '%s': failed to find BTF ID in kernel BTF(s).\n",
 			__btf_kind_str(kind), ksym_name);
@@ -6627,11 +6630,15 @@ static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
 	const char *targ_var_name;
 	int id, btf_fd = 0, err;
 	struct btf *btf = NULL;
+	bool is_weak = ext->is_weak;
 
-	id = find_ksym_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &btf_fd);
+	id = find_ksym_btf_id(obj, ext->name, BTF_KIND_VAR, is_weak, &btf, &btf_fd);
 	if (id < 0)
 		return id;
 
+	if (is_weak && id == 0)
+		return 0;
+
 	/* find local type_id */
 	local_type_id = ext->ksym.type_id;
 
@@ -6676,7 +6683,7 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 
 	local_func_proto_id = ext->ksym.type_id;
 
-	kfunc_id = find_ksym_btf_id(obj, ext->name, BTF_KIND_FUNC,
+	kfunc_id = find_ksym_btf_id(obj, ext->name, BTF_KIND_FUNC, false,
 				    &kern_btf, &kern_btf_fd);
 	if (kfunc_id < 0) {
 		pr_warn("extern (func ksym) '%s': not found in kernel BTF\n",
diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
index 67bebd324147..6bd60902f200 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
@@ -6,6 +6,7 @@
 #include <bpf/btf.h>
 #include "test_ksyms_btf.skel.h"
 #include "test_ksyms_btf_null_check.skel.h"
+#include "test_ksyms_weak.skel.h"
 
 static int duration;
 
@@ -81,6 +82,27 @@ static void test_null_check(void)
 	test_ksyms_btf_null_check__destroy(skel);
 }
 
+static void test_weak_syms(void)
+{
+	struct test_ksyms_weak *skel;
+	struct test_ksyms_weak__data *data;
+
+	skel = test_ksyms_weak__open_and_load();
+	if (CHECK(!skel, "test_ksyms_weak__open_and_load", "failed\n"))
+		return;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	data = skel->data;
+	ASSERT_EQ(data->out__existing_typed, 0, "existing typed ksym");
+	ASSERT_NEQ(data->out__existing_typeless, -1, "existing typeless ksym");
+	ASSERT_EQ(data->out__non_existent_typeless, 0, "nonexistent typeless ksym");
+	ASSERT_EQ(data->out__non_existent_typed, 0, "nonexistent typed ksym");
+
+	test_ksyms_weak__destroy(skel);
+}
+
 void test_ksyms_btf(void)
 {
 	int percpu_datasec;
@@ -105,4 +127,7 @@ void test_ksyms_btf(void)
 
 	if (test__start_subtest("null_check"))
 		test_null_check();
+
+	if (test__start_subtest("weak_ksyms"))
+		test_weak_syms();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
new file mode 100644
index 000000000000..8a7d69ddd89a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test weak ksyms.
+ *
+ * Copyright (c) 2021 Google
+ */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+
+int out__existing_typed = -1;
+__u64 out__existing_typeless = -1;
+
+__u64 out__non_existent_typeless = -1;
+__u64 out__non_existent_typed = -1;
+
+/* existing weak symbols */
+
+/* test existing weak symbols can be resolved. */
+extern const struct rq runqueues __ksym __weak; /* typed */
+extern const void bpf_prog_active __ksym __weak; /* typeless */
+
+
+/* non-existent weak symbols. */
+
+/* typeless symbols, default to zero. */
+extern const void bpf_link_fops1 __ksym __weak;
+
+/* typed symbols, default to zero. */
+extern const int bpf_link_fops2 __ksym __weak;
+
+/* typed symbols, pass if not referenced. */
+extern const int bpf_link_fops3 __ksym __weak;
+
+SEC("raw_tp/sys_enter")
+int pass_handler(const void *ctx)
+{
+	/* tests existing symbols. */
+	struct rq *rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, 0);
+	if (rq)
+		out__existing_typed = rq->cpu;
+	out__existing_typeless = (__u64)&bpf_prog_active;
+
+	/* tests non-existent symbols. */
+	out__non_existent_typeless = (__u64)&bpf_link_fops1;
+
+	/* tests non-existent symbols. */
+	out__non_existent_typed = (__u64)&bpf_link_fops2;
+
+	if (&bpf_link_fops2) /* can't happen */
+		out__non_existent_typed = (__u64)bpf_per_cpu_ptr(&bpf_link_fops2, 0);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.32.0.605.g8dce9f2422-goog


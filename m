Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28462E8DB
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiKQW4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiKQW4e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:56:34 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732DD62CE
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:33 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id b62so3494765pgc.0
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5mhxE7t9/w1waItLCLixY08yGr4GoIXj2ByOScU2oQ=;
        b=MAsB/at2Z1Tt+jyhoDIH3e0EEy7dQodrChafpxFPdC2uYHZjoVYfrhdszyAzXvMjrr
         fHTy/OuwzPPdyqJAMyYMohA0tk/5PDlU7u8qLsDLy0TN+GSdxH5nCa+iLqWn1sU6NdgS
         q65t2riPGC6zwQiD5vhVk/qbTcqZoIeUr/SY+8/wewHO3wVcnVq7ardMpeVbyfIcn2Fg
         5Z8k45/RKDdjq0o+3QKxeFHxIyB/5P/Q9zEUoEl9aVNBlxaEUtIAXBHcZ/e/RKZWEevy
         3Uk1APD5WzT9w6Eivr7iAJ8gzIsDuL3wHdj+Rp+1zsI11YGmsBrjch3cc6NF08LNHis8
         nRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5mhxE7t9/w1waItLCLixY08yGr4GoIXj2ByOScU2oQ=;
        b=QoUy5/OIZ9lPuWJ8xJxX9fQOPbrl92zpHbPXmLCJMZq67h9qeGq1QTtPO9iFS115fT
         hTQuPZJn4KpAhucrImje4OLZs3biDj2gmCkPhhQfiev7Edh/DWyvgQX3PrgiNruKUTWJ
         d8ZM9b0YlsyU2ChOmvRNNDEM8IMLlz8F7+o3YTrcVjaKWRjyY9hCEdbQorWjsdphYSxc
         BgVrrlU9z5cDDlk84ZFh9fjHAizTY3Yxs2mcFmErh2FzToCS4tSfJxDCuMVcEvPJNEMe
         i6yNr/3SKnUBiutuM+V6OHouiVW4OsXfL6s+97eOoUQGXCWsvU41DsiDQeWZJvhFDxGP
         PgZA==
X-Gm-Message-State: ANoB5pmLSnEy+XzUXWoiC+ODjvDjervHNODO26iqy6B0EPda8ndlQ9P3
        rn6tz1sNtrU09Zkj3TYN+ca9pjJV6W8=
X-Google-Smtp-Source: AA0mqf5ok8Sm0C/7vky++7foSwx5mzF40rtfIjZ5iI6xLw3i34yzay9SOxypkUQgn3BDA4n2IgTkZQ==
X-Received: by 2002:aa7:8694:0:b0:56d:78b0:16a0 with SMTP id d20-20020aa78694000000b0056d78b016a0mr4925577pfo.81.1668725792699;
        Thu, 17 Nov 2022 14:56:32 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id iw20-20020a170903045400b00179f370dbe7sm1848075plb.287.2022.11.17.14.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:56:32 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 21/23] selftests/bpf: Add failure test cases for spin lock pairing
Date:   Fri, 18 Nov 2022 04:25:08 +0530
Message-Id: <20221117225510.1676785-22-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10926; i=memxor@gmail.com; h=from:subject; bh=EgO226hLDLT8uUjs61C2Qe2aCLhsrlTx0+w4ds2Mqpc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkcgMT9Abs9cB+op+OrrkFyBfHhPTKvNDwLe6tH HY3gwCyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5HAAKCRBM4MiGSL8RyudaD/ sFMwhIylq6UGQnnNd++i0zhjQi0wiYn0kIqAhGFMBPC34FgaGsvWetRF3pY/Xls1Q327Xi92Rz0SV6 Mkqa46QpIzUJhDl6RJehIpa0FA1Ayr2ir/lq37oJL5NBIpwb8YTq8Go/wTzIz2MR/eqAqaWRcf3Mvf vJZe1/oSy2HVcjvrro6IpCeHalL5XMGLmPTq8wOHOpHf3KtBfJXQalY1d836DEjykj4gFXbdxmkPLw FBabFJBMB1UgmRFJyHq9BkoEUGzGeCSBAajlHMf5YMZKWLyumOZMbbkCEeAAAGbvQ6WdbX0eBBw8Yg mI/sPzdlM/phpZ++wakZVcFiUVNe9JkWe4YAuW5VLBuDs3y2E5xKy+fnX8PPYXf034iMXKmwbkAOdc 9uwp71ZXVNU0v8uvEJImTfeqWGf3H8BwdPQQqkpzjMjqcgolXlveTO7YoKpl/JtxgrZbzqcbu7Bw8o bnjgkdZYXE5YXlHuPHKdz51JX7Tk4usZ/HivO3sHfx/bHDsECkjJNsI91hPd5XedF+PLUpJFdaWErw 48VJ8/IuzKC1s+k+syb27gNg9kh2kga0lcdVP4e/gVt8fAhBuLkCgiAP9J2brEupdCoPN4MQzCfHiw 4xdHVB0+2/9MgeFb0SHdGAnEsWVItqcnuD/R3Hrykeih/+qjEDy5xxjbiVjw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First, ensure that whenever a bpf_spin_lock is present in an allocation,
the reg->id is preserved. This won't be true for global variables
however, since they have a single map value per map, hence the verifier
harcodes it to 0 (so that multiple pseudo ldimm64 insns can yield the
same lock object per map at a given offset).

Next, add test cases for all possible combinations (kptr, global, map
value, inner map value). Since we lifted restriction on locking in inner
maps, also add test cases for them. Currently, each lookup into an inner
map gets a fresh reg->id, so even if the reg->map_ptr is same, they will
be treated as separate allocations and the incorrect unlock pairing will
be rejected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/spin_lock.c      |  89 +++++++-
 .../selftests/bpf/progs/test_spin_lock_fail.c | 204 ++++++++++++++++++
 2 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_spin_lock_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/spin_lock.c b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
index fab061e9d77c..72282e92a78a 100644
--- a/tools/testing/selftests/bpf/prog_tests/spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spin_lock.c
@@ -3,6 +3,79 @@
 #include <network_helpers.h>
 
 #include "test_spin_lock.skel.h"
+#include "test_spin_lock_fail.skel.h"
+
+static char log_buf[1024 * 1024];
+
+static struct {
+	const char *prog_name;
+	const char *err_msg;
+} spin_lock_fail_tests[] = {
+	{ "lock_id_kptr_preserve",
+	  "5: (bf) r1 = r0                       ; R0_w=ptr_foo(id=2,ref_obj_id=2,off=0,imm=0) "
+	  "R1_w=ptr_foo(id=2,ref_obj_id=2,off=0,imm=0) refs=2\n6: (85) call bpf_this_cpu_ptr#154\n"
+	  "R1 type=ptr_ expected=percpu_ptr_" },
+	{ "lock_id_global_zero",
+	  "; R1_w=map_value(off=0,ks=4,vs=4,imm=0)\n2: (85) call bpf_this_cpu_ptr#154\n"
+	  "R1 type=map_value expected=percpu_ptr_" },
+	{ "lock_id_mapval_preserve",
+	  "8: (bf) r1 = r0                       ; R0_w=map_value(id=1,off=0,ks=4,vs=8,imm=0) "
+	  "R1_w=map_value(id=1,off=0,ks=4,vs=8,imm=0)\n9: (85) call bpf_this_cpu_ptr#154\n"
+	  "R1 type=map_value expected=percpu_ptr_" },
+	{ "lock_id_innermapval_preserve",
+	  "13: (bf) r1 = r0                      ; R0=map_value(id=2,off=0,ks=4,vs=8,imm=0) "
+	  "R1_w=map_value(id=2,off=0,ks=4,vs=8,imm=0)\n14: (85) call bpf_this_cpu_ptr#154\n"
+	  "R1 type=map_value expected=percpu_ptr_" },
+	{ "lock_id_mismatch_kptr_kptr", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_kptr_global", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_kptr_mapval", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_kptr_innermapval", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_global_global", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_global_kptr", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_global_mapval", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_global_innermapval", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_mapval_mapval", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_mapval_kptr", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_mapval_global", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_mapval_innermapval", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_innermapval_innermapval1", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_innermapval_innermapval2", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_innermapval_kptr", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_innermapval_global", "bpf_spin_unlock of different lock" },
+	{ "lock_id_mismatch_innermapval_mapval", "bpf_spin_unlock of different lock" },
+};
+
+static void test_spin_lock_fail_prog(const char *prog_name, const char *err_msg)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
+						.kernel_log_size = sizeof(log_buf),
+						.kernel_log_level = 1);
+	struct test_spin_lock_fail *skel;
+	struct bpf_program *prog;
+	int ret;
+
+	skel = test_spin_lock_fail__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "test_spin_lock_fail__open_opts"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto end;
+
+	bpf_program__set_autoload(prog, true);
+
+	ret = test_spin_lock_fail__load(skel);
+	if (!ASSERT_ERR(ret, "test_spin_lock_fail__load must fail"))
+		goto end;
+
+	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
+		fprintf(stderr, "Expected: %s\n", err_msg);
+		fprintf(stderr, "Verifier: %s\n", log_buf);
+	}
+
+end:
+	test_spin_lock_fail__destroy(skel);
+}
 
 static void *spin_lock_thread(void *arg)
 {
@@ -19,7 +92,7 @@ static void *spin_lock_thread(void *arg)
 	pthread_exit(arg);
 }
 
-void test_spinlock(void)
+void test_spin_lock_success(void)
 {
 	struct test_spin_lock *skel;
 	pthread_t thread_id[4];
@@ -47,3 +120,17 @@ void test_spinlock(void)
 end:
 	test_spin_lock__destroy(skel);
 }
+
+void test_spin_lock(void)
+{
+	int i;
+
+	test_spin_lock_success();
+
+	for (i = 0; i < ARRAY_SIZE(spin_lock_fail_tests); i++) {
+		if (!test__start_subtest(spin_lock_fail_tests[i].prog_name))
+			continue;
+		test_spin_lock_fail_prog(spin_lock_fail_tests[i].prog_name,
+					 spin_lock_fail_tests[i].err_msg);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
new file mode 100644
index 000000000000..86cd183ef6dc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+
+struct foo {
+	struct bpf_spin_lock lock;
+	int data;
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct foo);
+	__uint(max_entries, 1);
+} array_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct array_map);
+} map_of_maps SEC(".maps") = {
+	.values = {
+		[0] = &array_map,
+	},
+};
+
+SEC(".data.A") struct bpf_spin_lock lockA;
+SEC(".data.B") struct bpf_spin_lock lockB;
+
+SEC("?tc")
+int lock_id_kptr_preserve(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_this_cpu_ptr(f);
+	return 0;
+}
+
+SEC("?tc")
+int lock_id_global_zero(void *ctx)
+{
+	bpf_this_cpu_ptr(&lockA);
+	return 0;
+}
+
+SEC("?tc")
+int lock_id_mapval_preserve(void *ctx)
+{
+	struct foo *f;
+	int key = 0;
+
+	f = bpf_map_lookup_elem(&array_map, &key);
+	if (!f)
+		return 0;
+	bpf_this_cpu_ptr(f);
+	return 0;
+}
+
+SEC("?tc")
+int lock_id_innermapval_preserve(void *ctx)
+{
+	struct foo *f;
+	int key = 0;
+	void *map;
+
+	map = bpf_map_lookup_elem(&map_of_maps, &key);
+	if (!map)
+		return 0;
+	f = bpf_map_lookup_elem(map, &key);
+	if (!f)
+		return 0;
+	bpf_this_cpu_ptr(f);
+	return 0;
+}
+
+#define CHECK(test, A, B)                                      \
+	SEC("?tc")                                             \
+	int lock_id_mismatch_##test(void *ctx)                 \
+	{                                                      \
+		struct foo *f1, *f2, *v, *iv;                  \
+		int key = 0;                                   \
+		void *map;                                     \
+                                                               \
+		map = bpf_map_lookup_elem(&map_of_maps, &key); \
+		if (!map)                                      \
+			return 0;                              \
+		iv = bpf_map_lookup_elem(map, &key);           \
+		if (!iv)                                       \
+			return 0;                              \
+		v = bpf_map_lookup_elem(&array_map, &key);     \
+		if (!v)                                        \
+			return 0;                              \
+		f1 = bpf_obj_new(typeof(*f1));                 \
+		if (!f1)                                       \
+			return 0;                              \
+		f2 = bpf_obj_new(typeof(*f2));                 \
+		if (!f2) {                                     \
+			bpf_obj_drop(f1);                      \
+			return 0;                              \
+		}                                              \
+		bpf_spin_lock(A);                              \
+		bpf_spin_unlock(B);                            \
+		return 0;                                      \
+	}
+
+CHECK(kptr_kptr, &f1->lock, &f2->lock);
+CHECK(kptr_global, &f1->lock, &lockA);
+CHECK(kptr_mapval, &f1->lock, &v->lock);
+CHECK(kptr_innermapval, &f1->lock, &iv->lock);
+
+CHECK(global_global, &lockA, &lockB);
+CHECK(global_kptr, &lockA, &f1->lock);
+CHECK(global_mapval, &lockA, &v->lock);
+CHECK(global_innermapval, &lockA, &iv->lock);
+
+SEC("?tc")
+int lock_id_mismatch_mapval_mapval(void *ctx)
+{
+	struct foo *f1, *f2;
+	int key = 0;
+
+	f1 = bpf_map_lookup_elem(&array_map, &key);
+	if (!f1)
+		return 0;
+	f2 = bpf_map_lookup_elem(&array_map, &key);
+	if (!f2)
+		return 0;
+
+	bpf_spin_lock(&f1->lock);
+	f1->data = 42;
+	bpf_spin_unlock(&f2->lock);
+
+	return 0;
+}
+
+CHECK(mapval_kptr, &v->lock, &f1->lock);
+CHECK(mapval_global, &v->lock, &lockB);
+CHECK(mapval_innermapval, &v->lock, &iv->lock);
+
+SEC("?tc")
+int lock_id_mismatch_innermapval_innermapval1(void *ctx)
+{
+	struct foo *f1, *f2;
+	int key = 0;
+	void *map;
+
+	map = bpf_map_lookup_elem(&map_of_maps, &key);
+	if (!map)
+		return 0;
+	f1 = bpf_map_lookup_elem(map, &key);
+	if (!f1)
+		return 0;
+	f2 = bpf_map_lookup_elem(map, &key);
+	if (!f2)
+		return 0;
+
+	bpf_spin_lock(&f1->lock);
+	f1->data = 42;
+	bpf_spin_unlock(&f2->lock);
+
+	return 0;
+}
+
+SEC("?tc")
+int lock_id_mismatch_innermapval_innermapval2(void *ctx)
+{
+	struct foo *f1, *f2;
+	int key = 0;
+	void *map;
+
+	map = bpf_map_lookup_elem(&map_of_maps, &key);
+	if (!map)
+		return 0;
+	f1 = bpf_map_lookup_elem(map, &key);
+	if (!f1)
+		return 0;
+	map = bpf_map_lookup_elem(&map_of_maps, &key);
+	if (!map)
+		return 0;
+	f2 = bpf_map_lookup_elem(map, &key);
+	if (!f2)
+		return 0;
+
+	bpf_spin_lock(&f1->lock);
+	f1->data = 42;
+	bpf_spin_unlock(&f2->lock);
+
+	return 0;
+}
+
+CHECK(innermapval_kptr, &iv->lock, &f1->lock);
+CHECK(innermapval_global, &iv->lock, &lockA);
+CHECK(innermapval_mapval, &iv->lock, &v->lock);
+
+#undef CHECK
+
+char _license[] SEC("license") = "GPL";
-- 
2.38.1


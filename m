Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A46620373
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiKGXLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiKGXLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:11:22 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D702018E
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:11:21 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b11so12137436pjp.2
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIQCRURQA1zUo2qbQsX+DwVwv5vTUxhfroRc5uMhdlc=;
        b=nzCbu2WGr3sRsoYtnAa72cHCHWp2eS0JtvgedIhuXu55f2ehAbt7ZL1Vn96YdVLq06
         89QAQB/cPjDI/77vcLHGfHSu5UBWG39xZArpFU/W76aZgmPYhjNfa+Y3u8CdSEem4HUa
         WKMNp3J/5RQeBe5ipVlwCep3Ac5hAngWLMJechFI5JT6KPzG4AJyeWYUjFa6/FUXfHm3
         pzNT48TATOFiJrsrH2AhWSRWzjlVnIG2FShboslZrHmWmg4TawuPx08EbL+IqLXTDkJ2
         3QiE/uueGnw9ft1W4hl0pifAH3+KSw/Dp99TDl+CqE+5mzi8Al26uve3+UNhWn+q8DgQ
         WGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIQCRURQA1zUo2qbQsX+DwVwv5vTUxhfroRc5uMhdlc=;
        b=pMEuVmmsEPNHVOLdI5YB4LLg9q93D4jmTDokEnXCGrYSiIuYJPR2WSzaeqkE1hkaAD
         hORFh9M50RXHt7hOV9Wgmle997QSbe23oar5YBceAd7MwCZkbxTHu6ubrMMCn1miYfGc
         qaGK7dIq43EK8DiikckBxLvujzFsqH1Kr5CyjIiYzZOvZHLKui41JU3Ytau+mWKxXMBL
         f/oiLIStKmY9feDnHf0JbInW9GsHT4br8JPt2Ia4V1WYYawEZLMNSAPfDrFMeaz0nvL5
         vHvF3xJFZLVocd2O2WCY2ojbnwH6LK3TFd5k4hkjGeg83mypPT8MzT4pebrXvFByKr6t
         yDFA==
X-Gm-Message-State: ACrzQf1PFXtP3LBG9Sf5IeIqMX1nTnRoN7R7e9uq7vqvq8CGg1HdZnVh
        8etM67lj+jrIYMzipXWLL5ClDdjK9ZSmdw==
X-Google-Smtp-Source: AMsMyM6d1uOeKUw4El6up2sGaiwCKOx/iMjGg0446aiQy/iVFSTgEp8FbR0UkBXUCGKMxi3rZ53vWQ==
X-Received: by 2002:a17:90a:70c2:b0:214:132a:2b90 with SMTP id a2-20020a17090a70c200b00214132a2b90mr843454pjm.195.1667862680848;
        Mon, 07 Nov 2022 15:11:20 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id j63-20020a625542000000b005627868e27esm4976061pfb.127.2022.11.07.15.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:11:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 23/25] selftests/bpf: Add failure test cases for spin lock pairing
Date:   Tue,  8 Nov 2022 04:39:48 +0530
Message-Id: <20221107230950.7117-24-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10926; i=memxor@gmail.com; h=from:subject; bh=k+3ZSMEGNPAv+SyMd8Vm+yW877Fe7P+gsH1G641amws=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+4b1Z9fAX0VtDGxVkg4/+HY+waaHNmZ5KuyC1V bHbXgJ+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPuAAKCRBM4MiGSL8RyvUID/ wKgU/MJ8HU7bns4MaoeaALejNpdKPoJds56oA7uo27Ku99BdQCThdWbRn/Yz0tyzZLb6O38+WW4Y+L 5gPEY0LqZu6bfS/t3H1f7PXR6Q3rBtPQJHrapSvo//EhPI3zJWRO0GOlwEG8CJB04feU3ypfFC2Ejr M8HukN9/6glD2ex2iTHrqYg66kC9F+cnqb4PHWVVlvfayrN3GydcRwJOZyJbw4FPPu825G766ugroD QpEqOO1aSF8EmBbmdzqai8+3i/H100XPH/XRER1SH0FVA15hyUmMOYLdH6YUzY+4EFUnBgVrbNw2SJ y8gL8dmD/J36KCDj8lNgLsXuxFqBQLSUBflzvkUOoET0oXkO5CT2p/KtVfeH0IUmlHNM1CXtinsl2c Vf/W8ceZsncvSMDxJ7YSgq66RzuCua9JKVBneEU6P35zU5b2h76+5eB6AqGkZ8948k+VoVrTB9sNyz ygLFWMwNTY97+KEvL+9iuTzbQ5V0/zuS+u48kLonb0bZjYimeMD593qxfzJFkM2YF9TcJx7DXTqDXV eEWlipGC0YpCkPrqPaVvR8kBSGpjnpWJCAd3C23/Lh/5dUHQwb1FvgwnyrS8AdgAcdLp1PdLhCZ2cM gj9/b7DCOQfYIyTgUfAw51hxtQbg+acepdn4+KBXmdFkw9Dz4ooax8e9dzvg==
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
index 1f720002fe56..5df959c78fee 100644
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
@@ -44,3 +117,17 @@ void test_spinlock(void)
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


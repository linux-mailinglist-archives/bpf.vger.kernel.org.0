Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21038626212
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiKKTet (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiKKTem (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:34:42 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A2C787BD
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:40 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so5555328pji.0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqNJljVDIsXhhzjw1efhRO0V8DNidbAkWSwgvIaFExY=;
        b=dY9OgrxjSlFWxbj08dQOCaArL53A5lFxtilth8+uau8vC050IWJ2CnRqmFuFu6rywI
         FvxUhjg0G2UdWY1WorvDBCwO5FF/qzDjIesaV935we01aUv5hUqhE9yCr90NljhHI91T
         PZLgAB5w2opAUfaotBFxZ5F/m3n7Mk20fjE0bSukmhcnnD2Cw9ViwwMYS1+hGA/rEkMM
         tGDm9WmrHNERlfT5agHIU6hlDgz51rp6LOrIrRjJk9wINWWmJHkFyNdCT0syK2MEVfgx
         ViC3E2iS/tDq74/zSbJKYrRVB16s6icY/7mtjwTA3Bm4Rj7szjOQAO7DTUHn3dmQ1+w6
         FrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqNJljVDIsXhhzjw1efhRO0V8DNidbAkWSwgvIaFExY=;
        b=HuiSesG8F0GwAkEb3nBD0i5HamuZBfB8eFAJx0VtYzVks+Kpj/ZHf2iwSXOmLnxGl3
         n0L/wHZVCZ3LVyNXC8gzb2ICsWkOXU0JWXzpcBo/JKCzxdhTaRAxOvjh9joI0G2dseQW
         nyRrPXvHkZeoMqvoorwCOZd1bs26uoeUvmkRlp03ZDQnVLTT1w1eBrZhVCs9MKl5A2eq
         cEYz2s9fPnUXmGgGEqK3lOLReIbDwcUsnypouSDaXrmSyByVXD9WAAy1Cb3JSE97N+kv
         9t7CR65zx5yisHtlIftDIy30qQ3LmwNYvPxbEmMdgDI6Tnqc+fs1aIH85LyBMW/ICiJf
         fApQ==
X-Gm-Message-State: ANoB5plzq9zIOeu4k9bwaVI1lBRcjNyY2EWEtBzf1FMCLE2s4ArKOdgM
        3OQ30737M34hOzGUSw0JqhkaxWRpaQjM1w==
X-Google-Smtp-Source: AA0mqf4/ESAsCWz2HVUx0yjVBes9fZPET6JVp6HpsWM/kE7csiP/JdohCjRpcHrEMvU93+tBzDPevw==
X-Received: by 2002:a17:902:a508:b0:188:9542:515 with SMTP id s8-20020a170902a50800b0018895420515mr3770721plq.102.1668195279489;
        Fri, 11 Nov 2022 11:34:39 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id ch16-20020a17090af41000b00210125b789dsm1932341pjb.54.2022.11.11.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:34:39 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 25/26] selftests/bpf: Add BPF linked list API tests
Date:   Sat, 12 Nov 2022 01:02:23 +0530
Message-Id: <20221111193224.876706-26-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=35474; i=memxor@gmail.com; h=from:subject; bh=ym5zGZElr4FjpGXZRLgvXVHCu29Kyfq3u+6nwwTOb9k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIpeXj1Bit6Mr1FSEmhpj7QFg77VoSpOKZdIJK2 mErCvZ2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKQAKCRBM4MiGSL8Ryq5hD/ 9R2rq8Qulr9NZ0bcOhk0O7RPAGMqjDoSelbSuXk2sJ15NbL4zCwBq+MXf7pgOREL3EU5AOwEKAjuKF Gk+Eok5z4PwPy5LWmtRiwPX5YK6VPqHpbWTU1NJlW/o8BADOCZv4Foj5CbifTCM4d0rpoC1sYObN/R 6SRj2pDcgylS4XIOzhQZIINuSucLmhRFK44z99pKbqA1ptOR6e8Lp74L1DSuP6/ZsFBFNYJFMFiY4U OQyOs9pwKKLn50gxxS03QNu0XpgofbPFv/WT7q9/jgGWoyP3PvDrUcTRqClNomasivkpZQRo2B9uKF M2OegPVkI7K5j9k/zBAOijbzHqv4vRoImTo0oxNBH83Bs20HwYmsyVMwozKZtQvqCPa19MaaH1wSi1 /0/4tF+lcQXEXd1vk7napohdc8dg+gOoxB7i5Gvh1jvG0E3aWn8sPkjmLpswfqfJ5xcOfCzGPLfbnw p61WUMhmLBl011QhAbJc9D0rccmf48mxM5ocSQGR2+J9Y0E/lqYKYUAqoDhQNYHQg1+omZjjDeUQDe I8fdU9RJf5uuN9XcTf11koJV/g44QRIrnA6bk48w7sWI1h/1LHr8RAlUTmxj+GiAiQ3a1WnoQQiXBh 9geWbMsx4AQguqWv2igGsoWxon+2hwsDI1wC/9ZEC1rO/7A/QtA9xPnFKFxQ==
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

Include various tests covering the success and failure cases. Also, run
the success cases at runtime to verify correctness of linked list
manipulation routines, in addition to ensuring successful verification.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/linked_list.c    | 253 ++++++++
 .../testing/selftests/bpf/progs/linked_list.c | 370 +++++++++++
 .../testing/selftests/bpf/progs/linked_list.h |  56 ++
 .../selftests/bpf/progs/linked_list_fail.c    | 581 ++++++++++++++++++
 5 files changed, 1261 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_fail.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index be4e3d47ea3e..072243af93b0 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -33,6 +33,7 @@ ksyms_module                             # test_ksyms_module__open_and_load unex
 ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
 ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
 libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
+linked_list				 # JIT does not support calling kernel function                                (kfunc)
 lookup_key                               # JIT does not support calling kernel function                                (kfunc)
 lru_bug                                  # prog 'printk': failed to auto-attach: -524
 map_kptr                                 # failed to open_and_load program: -524 (trampoline)
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
new file mode 100644
index 000000000000..e8569db2f3bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "linked_list.skel.h"
+#include "linked_list_fail.skel.h"
+
+static char log_buf[1024 * 1024];
+
+static struct {
+	const char *prog_name;
+	const char *err_msg;
+} linked_list_fail_tests[] = {
+#define TEST(test, off) \
+	{ #test "_missing_lock_push_front", \
+	  "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
+	{ #test "_missing_lock_push_back", \
+	  "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
+	{ #test "_missing_lock_pop_front", \
+	  "bpf_spin_lock at off=" #off " must be held for bpf_list_head" }, \
+	{ #test "_missing_lock_pop_back", \
+	  "bpf_spin_lock at off=" #off " must be held for bpf_list_head" },
+	TEST(kptr, 32)
+	TEST(global, 16)
+	TEST(map, 0)
+	TEST(inner_map, 0)
+#undef TEST
+#define TEST(test, op) \
+	{ #test "_kptr_incorrect_lock_" #op, \
+	  "held lock and object are not in the same allocation\n" \
+	  "bpf_spin_lock at off=32 must be held for bpf_list_head" }, \
+	{ #test "_global_incorrect_lock_" #op, \
+	  "held lock and object are not in the same allocation\n" \
+	  "bpf_spin_lock at off=16 must be held for bpf_list_head" }, \
+	{ #test "_map_incorrect_lock_" #op, \
+	  "held lock and object are not in the same allocation\n" \
+	  "bpf_spin_lock at off=0 must be held for bpf_list_head" }, \
+	{ #test "_inner_map_incorrect_lock_" #op, \
+	  "held lock and object are not in the same allocation\n" \
+	  "bpf_spin_lock at off=0 must be held for bpf_list_head" },
+	TEST(kptr, push_front)
+	TEST(kptr, push_back)
+	TEST(kptr, pop_front)
+	TEST(kptr, pop_back)
+	TEST(global, push_front)
+	TEST(global, push_back)
+	TEST(global, pop_front)
+	TEST(global, pop_back)
+	TEST(map, push_front)
+	TEST(map, push_back)
+	TEST(map, pop_front)
+	TEST(map, pop_back)
+	TEST(inner_map, push_front)
+	TEST(inner_map, push_back)
+	TEST(inner_map, pop_front)
+	TEST(inner_map, pop_back)
+#undef TEST
+	{ "map_compat_kprobe", "tracing progs cannot use bpf_list_head yet" },
+	{ "map_compat_kretprobe", "tracing progs cannot use bpf_list_head yet" },
+	{ "map_compat_tp", "tracing progs cannot use bpf_list_head yet" },
+	{ "map_compat_perf", "tracing progs cannot use bpf_list_head yet" },
+	{ "map_compat_raw_tp", "tracing progs cannot use bpf_list_head yet" },
+	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_list_head yet" },
+	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
+	{ "obj_new_no_composite", "bpf_obj_new type ID argument must be of a struct" },
+	{ "obj_new_no_struct", "bpf_obj_new type ID argument must be of a struct" },
+	{ "obj_drop_non_zero_off", "R1 must have zero offset when passed to release func" },
+	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
+	{ "obj_new_acq", "Unreleased reference id=" },
+	{ "use_after_drop", "invalid mem access 'scalar'" },
+	{ "ptr_walk_scalar", "type=scalar expected=percpu_ptr_" },
+	{ "direct_read_lock", "direct access to bpf_spin_lock is disallowed" },
+	{ "direct_write_lock", "direct access to bpf_spin_lock is disallowed" },
+	{ "direct_read_head", "direct access to bpf_list_head is disallowed" },
+	{ "direct_write_head", "direct access to bpf_list_head is disallowed" },
+	{ "direct_read_node", "direct access to bpf_list_node is disallowed" },
+	{ "direct_write_node", "direct access to bpf_list_node is disallowed" },
+	{ "write_after_push_front", "only read is supported" },
+	{ "write_after_push_back", "only read is supported" },
+	{ "use_after_unlock_push_front", "invalid mem access 'scalar'" },
+	{ "use_after_unlock_push_back", "invalid mem access 'scalar'" },
+	{ "double_push_front", "arg#1 expected pointer to allocated object" },
+	{ "double_push_back", "arg#1 expected pointer to allocated object" },
+	{ "no_node_value_type", "bpf_list_node not found for allocated object\n" },
+	{ "incorrect_value_type", "bpf_list_head value type does not match arg#1" },
+	{ "incorrect_node_var_off", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
+	{ "incorrect_node_off1", "bpf_list_node not found at offset=1" },
+	{ "incorrect_node_off2", "arg#1 offset must be for bpf_list_node at off=0" },
+	{ "no_head_type", "bpf_list_head not found for allocated object" },
+	{ "incorrect_head_var_off1", "R1 doesn't have constant offset" },
+	{ "incorrect_head_var_off2", "variable ptr_ access var_off=(0x0; 0xffffffff) disallowed" },
+	{ "incorrect_head_off1", "bpf_list_head not found at offset=17" },
+	{ "incorrect_head_off2", "bpf_list_head not found at offset=1" },
+	{ "pop_front_off",
+	  "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) "
+	  "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) refs=2,4\n"
+	  "16: (85) call bpf_this_cpu_ptr#154\nR1 type=ptr_or_null_ expected=percpu_ptr_" },
+	{ "pop_back_off",
+	  "15: (bf) r1 = r6                      ; R1_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) "
+	  "R6_w=ptr_or_null_foo(id=4,ref_obj_id=4,off=40,imm=0) refs=2,4\n"
+	  "16: (85) call bpf_this_cpu_ptr#154\nR1 type=ptr_or_null_ expected=percpu_ptr_" },
+};
+
+static void test_linked_list_fail_prog(const char *prog_name, const char *err_msg)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
+						.kernel_log_size = sizeof(log_buf),
+						.kernel_log_level = 1);
+	struct linked_list_fail *skel;
+	struct bpf_program *prog;
+	int ret;
+
+	skel = linked_list_fail__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "linked_list_fail__open_opts"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto end;
+
+	bpf_program__set_autoload(prog, true);
+
+	ret = linked_list_fail__load(skel);
+	if (!ASSERT_ERR(ret, "linked_list_fail__load must fail"))
+		goto end;
+
+	if (!ASSERT_OK_PTR(strstr(log_buf, err_msg), "expected error message")) {
+		fprintf(stderr, "Expected: %s\n", err_msg);
+		fprintf(stderr, "Verifier: %s\n", log_buf);
+	}
+
+end:
+	linked_list_fail__destroy(skel);
+}
+
+static void clear_fields(struct bpf_map *map)
+{
+	char buf[24];
+	int key = 0;
+
+	memset(buf, 0xff, sizeof(buf));
+	ASSERT_OK(bpf_map__update_elem(map, &key, sizeof(key), buf, sizeof(buf), 0), "check_and_free_fields");
+}
+
+enum {
+	TEST_ALL,
+	PUSH_POP,
+	PUSH_POP_MULT,
+	LIST_IN_LIST,
+};
+
+static void test_linked_list_success(int mode, bool leave_in_map)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct linked_list *skel;
+	int ret;
+
+	skel = linked_list__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "linked_list__open_and_load"))
+		return;
+
+	if (mode == LIST_IN_LIST)
+		goto lil;
+	if (mode == PUSH_POP_MULT)
+		goto ppm;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_push_pop), &opts);
+	ASSERT_OK(ret, "map_list_push_pop");
+	ASSERT_OK(opts.retval, "map_list_push_pop retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.array_map);
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_push_pop), &opts);
+	ASSERT_OK(ret, "inner_map_list_push_pop");
+	ASSERT_OK(opts.retval, "inner_map_list_push_pop retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.inner_map);
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop), &opts);
+	ASSERT_OK(ret, "global_list_push_pop");
+	ASSERT_OK(opts.retval, "global_list_push_pop retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.data_A);
+
+	if (mode == PUSH_POP)
+		goto end;
+
+ppm:
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_push_pop_multiple), &opts);
+	ASSERT_OK(ret, "map_list_push_pop_multiple");
+	ASSERT_OK(opts.retval, "map_list_push_pop_multiple retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.array_map);
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_push_pop_multiple), &opts);
+	ASSERT_OK(ret, "inner_map_list_push_pop_multiple");
+	ASSERT_OK(opts.retval, "inner_map_list_push_pop_multiple retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.inner_map);
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_multiple), &opts);
+	ASSERT_OK(ret, "global_list_push_pop_multiple");
+	ASSERT_OK(opts.retval, "global_list_push_pop_multiple retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.data_A);
+
+	if (mode == PUSH_POP_MULT)
+		goto end;
+
+lil:
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_in_list), &opts);
+	ASSERT_OK(ret, "map_list_in_list");
+	ASSERT_OK(opts.retval, "map_list_in_list retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.array_map);
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.inner_map_list_in_list), &opts);
+	ASSERT_OK(ret, "inner_map_list_in_list");
+	ASSERT_OK(opts.retval, "inner_map_list_in_list retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.inner_map);
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_in_list), &opts);
+	ASSERT_OK(ret, "global_list_in_list");
+	ASSERT_OK(opts.retval, "global_list_in_list retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.data_A);
+end:
+	linked_list__destroy(skel);
+}
+
+void test_linked_list(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(linked_list_fail_tests); i++) {
+		if (!test__start_subtest(linked_list_fail_tests[i].prog_name))
+			continue;
+		test_linked_list_fail_prog(linked_list_fail_tests[i].prog_name,
+					   linked_list_fail_tests[i].err_msg);
+	}
+	test_linked_list_success(PUSH_POP, false);
+	test_linked_list_success(PUSH_POP, true);
+	test_linked_list_success(PUSH_POP_MULT, false);
+	test_linked_list_success(PUSH_POP_MULT, true);
+	test_linked_list_success(LIST_IN_LIST, false);
+	test_linked_list_success(LIST_IN_LIST, true);
+	test_linked_list_success(TEST_ALL, false);
+}
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
new file mode 100644
index 000000000000..2c7b615c6d41
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+#include "linked_list.h"
+
+static __always_inline
+int list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 2;
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(f);
+		return 3;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(f);
+		return 4;
+	}
+
+
+	bpf_spin_lock(lock);
+	f->data = 42;
+	bpf_list_push_front(head, &f->node);
+	bpf_spin_unlock(lock);
+	if (leave_in_map)
+		return 0;
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 5;
+	f = container_of(n, struct foo, node);
+	if (f->data != 42) {
+		bpf_obj_drop(f);
+		return 6;
+	}
+
+	bpf_spin_lock(lock);
+	f->data = 13;
+	bpf_list_push_front(head, &f->node);
+	bpf_spin_unlock(lock);
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 7;
+	f = container_of(n, struct foo, node);
+	if (f->data != 13) {
+		bpf_obj_drop(f);
+		return 8;
+	}
+	bpf_obj_drop(f);
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		return 9;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		return 10;
+	}
+	return 0;
+}
+
+
+static __always_inline
+int list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct foo *f[8], *pf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(f); i++) {
+		f[i] = bpf_obj_new(typeof(**f));
+		if (!f[i])
+			return 2;
+		f[i]->data = i;
+		bpf_spin_lock(lock);
+		bpf_list_push_front(head, &f[i]->node);
+		bpf_spin_unlock(lock);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(f); i++) {
+		bpf_spin_lock(lock);
+		n = bpf_list_pop_front(head);
+		bpf_spin_unlock(lock);
+		if (!n)
+			return 3;
+		pf = container_of(n, struct foo, node);
+		if (pf->data != (ARRAY_SIZE(f) - i - 1)) {
+			bpf_obj_drop(pf);
+			return 4;
+		}
+		bpf_spin_lock(lock);
+		bpf_list_push_back(head, &pf->node);
+		bpf_spin_unlock(lock);
+	}
+
+	if (leave_in_map)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(f); i++) {
+		bpf_spin_lock(lock);
+		n = bpf_list_pop_back(head);
+		bpf_spin_unlock(lock);
+		if (!n)
+			return 5;
+		pf = container_of(n, struct foo, node);
+		if (pf->data != i) {
+			bpf_obj_drop(pf);
+			return 6;
+		}
+		bpf_obj_drop(pf);
+	}
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		return 7;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		return 8;
+	}
+	return 0;
+}
+
+static __always_inline
+int list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct bar *ba[8], *b;
+	struct foo *f;
+	int i;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 2;
+	for (i = 0; i < ARRAY_SIZE(ba); i++) {
+		b = bpf_obj_new(typeof(*b));
+		if (!b) {
+			bpf_obj_drop(f);
+			return 3;
+		}
+		b->data = i;
+		bpf_spin_lock(&f->lock);
+		bpf_list_push_back(&f->head, &b->node);
+		bpf_spin_unlock(&f->lock);
+	}
+
+	bpf_spin_lock(lock);
+	f->data = 42;
+	bpf_list_push_front(head, &f->node);
+	bpf_spin_unlock(lock);
+
+	if (leave_in_map)
+		return 0;
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 4;
+	f = container_of(n, struct foo, node);
+	if (f->data != 42) {
+		bpf_obj_drop(f);
+		return 5;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ba); i++) {
+		bpf_spin_lock(&f->lock);
+		n = bpf_list_pop_front(&f->head);
+		bpf_spin_unlock(&f->lock);
+		if (!n) {
+			bpf_obj_drop(f);
+			return 6;
+		}
+		b = container_of(n, struct bar, node);
+		if (b->data != i) {
+			bpf_obj_drop(f);
+			bpf_obj_drop(b);
+			return 7;
+		}
+		bpf_obj_drop(b);
+	}
+	bpf_spin_lock(&f->lock);
+	n = bpf_list_pop_front(&f->head);
+	bpf_spin_unlock(&f->lock);
+	if (n) {
+		bpf_obj_drop(f);
+		bpf_obj_drop(container_of(n, struct bar, node));
+		return 8;
+	}
+	bpf_obj_drop(f);
+	return 0;
+}
+
+static __always_inline
+int test_list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head)
+{
+	int ret;
+
+	ret = list_push_pop(lock, head, false);
+	if (ret)
+		return ret;
+	return list_push_pop(lock, head, true);
+}
+
+static __always_inline
+int test_list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *head)
+{
+	int ret;
+
+	ret = list_push_pop_multiple(lock ,head, false);
+	if (ret)
+		return ret;
+	return list_push_pop_multiple(lock, head, true);
+}
+
+static __always_inline
+int test_list_in_list(struct bpf_spin_lock *lock, struct bpf_list_head *head)
+{
+	int ret;
+
+	ret = list_in_list(lock, head, false);
+	if (ret)
+		return ret;
+	return list_in_list(lock, head, true);
+}
+
+SEC("tc")
+int map_list_push_pop(void *ctx)
+{
+	struct map_value *v;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 1;
+	return test_list_push_pop(&v->lock, &v->head);
+}
+
+SEC("tc")
+int inner_map_list_push_pop(void *ctx)
+{
+	struct map_value *v;
+	void *map;
+
+	map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
+	if (!map)
+		return 1;
+	v = bpf_map_lookup_elem(map, &(int){0});
+	if (!v)
+		return 1;
+	return test_list_push_pop(&v->lock, &v->head);
+}
+
+SEC("tc")
+int global_list_push_pop(void *ctx)
+{
+	return test_list_push_pop(&glock, &ghead);
+}
+
+SEC("tc")
+int map_list_push_pop_multiple(void *ctx)
+{
+	struct map_value *v;
+	int ret;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 1;
+	return test_list_push_pop_multiple(&v->lock, &v->head);
+}
+
+SEC("tc")
+int inner_map_list_push_pop_multiple(void *ctx)
+{
+	struct map_value *v;
+	void *map;
+	int ret;
+
+	map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
+	if (!map)
+		return 1;
+	v = bpf_map_lookup_elem(map, &(int){0});
+	if (!v)
+		return 1;
+	return test_list_push_pop_multiple(&v->lock, &v->head);
+}
+
+SEC("tc")
+int global_list_push_pop_multiple(void *ctx)
+{
+	int ret;
+
+	ret = list_push_pop_multiple(&glock, &ghead, false);
+	if (ret)
+		return ret;
+	return list_push_pop_multiple(&glock, &ghead, true);
+}
+
+SEC("tc")
+int map_list_in_list(void *ctx)
+{
+	struct map_value *v;
+	int ret;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 1;
+	return test_list_in_list(&v->lock, &v->head);
+}
+
+SEC("tc")
+int inner_map_list_in_list(void *ctx)
+{
+	struct map_value *v;
+	void *map;
+	int ret;
+
+	map = bpf_map_lookup_elem(&map_of_maps, &(int){0});
+	if (!map)
+		return 1;
+	v = bpf_map_lookup_elem(map, &(int){0});
+	if (!v)
+		return 1;
+	return test_list_in_list(&v->lock, &v->head);
+}
+
+SEC("tc")
+int global_list_in_list(void *ctx)
+{
+	return test_list_in_list(&glock, &ghead);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/testing/selftests/bpf/progs/linked_list.h
new file mode 100644
index 000000000000..8db80ed64db1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_list.h
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef LINKED_LIST_H
+#define LINKED_LIST_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+
+struct bar {
+	struct bpf_list_node node;
+	int data;
+};
+
+struct foo {
+	struct bpf_list_node node;
+	struct bpf_list_head head __contains(bar, node);
+	struct bpf_spin_lock lock;
+	int data;
+	struct bpf_list_node node2;
+};
+
+struct map_value {
+	struct bpf_spin_lock lock;
+	int data;
+	struct bpf_list_head head __contains(foo, node);
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+};
+
+struct array_map array_map SEC(".maps");
+struct array_map inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct array_map);
+} map_of_maps SEC(".maps") = {
+	.values = {
+		[0] = &inner_map,
+	},
+};
+
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+private(A) struct bpf_spin_lock glock;
+private(A) struct bpf_list_head ghead __contains(foo, node);
+private(B) struct bpf_spin_lock glock2;
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
new file mode 100644
index 000000000000..1d9017240e19
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+#include "linked_list.h"
+
+#define INIT                                                  \
+	struct map_value *v, *v2, *iv, *iv2;                  \
+	struct foo *f, *f1, *f2;                              \
+	struct bar *b;                                        \
+	void *map;                                            \
+                                                              \
+	map = bpf_map_lookup_elem(&map_of_maps, &(int){ 0 }); \
+	if (!map)                                             \
+		return 0;                                     \
+	v = bpf_map_lookup_elem(&array_map, &(int){ 0 });     \
+	if (!v)                                               \
+		return 0;                                     \
+	v2 = bpf_map_lookup_elem(&array_map, &(int){ 0 });    \
+	if (!v2)                                              \
+		return 0;                                     \
+	iv = bpf_map_lookup_elem(map, &(int){ 0 });           \
+	if (!iv)                                              \
+		return 0;                                     \
+	iv2 = bpf_map_lookup_elem(map, &(int){ 0 });          \
+	if (!iv2)                                             \
+		return 0;                                     \
+	f = bpf_obj_new(typeof(*f));                          \
+	if (!f)                                               \
+		return 0;                                     \
+	f1 = f;                                               \
+	f2 = bpf_obj_new(typeof(*f2));                        \
+	if (!f2) {                                            \
+		bpf_obj_drop(f1);                             \
+		return 0;                                     \
+	}                                                     \
+	b = bpf_obj_new(typeof(*b));                          \
+	if (!b) {                                             \
+		bpf_obj_drop(f2);                             \
+		bpf_obj_drop(f1);                             \
+		return 0;                                     \
+	}
+
+#define CHECK(test, op, hexpr)                              \
+	SEC("?tc")                                          \
+	int test##_missing_lock_##op(void *ctx)             \
+	{                                                   \
+		INIT;                                       \
+		void (*p)(void *) = (void *)&bpf_list_##op; \
+		p(hexpr);                                   \
+		return 0;                                   \
+	}
+
+CHECK(kptr, push_front, &f->head);
+CHECK(kptr, push_back, &f->head);
+CHECK(kptr, pop_front, &f->head);
+CHECK(kptr, pop_back, &f->head);
+
+CHECK(global, push_front, &ghead);
+CHECK(global, push_back, &ghead);
+CHECK(global, pop_front, &ghead);
+CHECK(global, pop_back, &ghead);
+
+CHECK(map, push_front, &v->head);
+CHECK(map, push_back, &v->head);
+CHECK(map, pop_front, &v->head);
+CHECK(map, pop_back, &v->head);
+
+CHECK(inner_map, push_front, &iv->head);
+CHECK(inner_map, push_back, &iv->head);
+CHECK(inner_map, pop_front, &iv->head);
+CHECK(inner_map, pop_back, &iv->head);
+
+#undef CHECK
+
+#define CHECK(test, op, lexpr, hexpr)                       \
+	SEC("?tc")                                          \
+	int test##_incorrect_lock_##op(void *ctx)           \
+	{                                                   \
+		INIT;                                       \
+		void (*p)(void *) = (void *)&bpf_list_##op; \
+		bpf_spin_lock(lexpr);                       \
+		p(hexpr);                                   \
+		return 0;                                   \
+	}
+
+#define CHECK_OP(op)                                           \
+	CHECK(kptr_kptr, op, &f1->lock, &f2->head);            \
+	CHECK(kptr_global, op, &f1->lock, &ghead);             \
+	CHECK(kptr_map, op, &f1->lock, &v->head);              \
+	CHECK(kptr_inner_map, op, &f1->lock, &iv->head);       \
+                                                               \
+	CHECK(global_global, op, &glock2, &ghead);             \
+	CHECK(global_kptr, op, &glock, &f1->head);             \
+	CHECK(global_map, op, &glock, &v->head);               \
+	CHECK(global_inner_map, op, &glock, &iv->head);        \
+                                                               \
+	CHECK(map_map, op, &v->lock, &v2->head);               \
+	CHECK(map_kptr, op, &v->lock, &f2->head);              \
+	CHECK(map_global, op, &v->lock, &ghead);               \
+	CHECK(map_inner_map, op, &v->lock, &iv->head);         \
+                                                               \
+	CHECK(inner_map_inner_map, op, &iv->lock, &iv2->head); \
+	CHECK(inner_map_kptr, op, &iv->lock, &f2->head);       \
+	CHECK(inner_map_global, op, &iv->lock, &ghead);        \
+	CHECK(inner_map_map, op, &iv->lock, &v->head);
+
+CHECK_OP(push_front);
+CHECK_OP(push_back);
+CHECK_OP(pop_front);
+CHECK_OP(pop_back);
+
+#undef CHECK
+#undef CHECK_OP
+#undef INIT
+
+SEC("?kprobe/xyz")
+int map_compat_kprobe(void *ctx)
+{
+	bpf_list_push_front(&ghead, NULL);
+	return 0;
+}
+
+SEC("?kretprobe/xyz")
+int map_compat_kretprobe(void *ctx)
+{
+	bpf_list_push_front(&ghead, NULL);
+	return 0;
+}
+
+SEC("?tracepoint/xyz")
+int map_compat_tp(void *ctx)
+{
+	bpf_list_push_front(&ghead, NULL);
+	return 0;
+}
+
+SEC("?perf_event")
+int map_compat_perf(void *ctx)
+{
+	bpf_list_push_front(&ghead, NULL);
+	return 0;
+}
+
+SEC("?raw_tp/xyz")
+int map_compat_raw_tp(void *ctx)
+{
+	bpf_list_push_front(&ghead, NULL);
+	return 0;
+}
+
+SEC("?raw_tp.w/xyz")
+int map_compat_raw_tp_w(void *ctx)
+{
+	bpf_list_push_front(&ghead, NULL);
+	return 0;
+}
+
+SEC("?tc")
+int obj_type_id_oor(void *ctx)
+{
+	bpf_obj_new_impl(~0UL, NULL);
+	return 0;
+}
+
+SEC("?tc")
+int obj_new_no_composite(void *ctx)
+{
+	bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
+	return 0;
+}
+
+SEC("?tc")
+int obj_new_no_struct(void *ctx)
+{
+
+	bpf_obj_new(union { int data; unsigned udata; });
+	return 0;
+}
+
+SEC("?tc")
+int obj_drop_non_zero_off(void *ctx)
+{
+	void *f;
+
+	f = bpf_obj_new(struct foo);
+	if (!f)
+		return 0;
+	bpf_obj_drop(f+1);
+	return 0;
+}
+
+SEC("?tc")
+int new_null_ret(void *ctx)
+{
+	return bpf_obj_new(struct foo)->data;
+}
+
+SEC("?tc")
+int obj_new_acq(void *ctx)
+{
+	bpf_obj_new(struct foo);
+	return 0;
+}
+
+SEC("?tc")
+int use_after_drop(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_obj_drop(f);
+	return f->data;
+}
+
+SEC("?tc")
+int ptr_walk_scalar(void *ctx)
+{
+	struct test1 {
+		struct test2 {
+			struct test2 *next;
+		} *ptr;
+	} *p;
+
+	p = bpf_obj_new(typeof(*p));
+	if (!p)
+		return 0;
+	bpf_this_cpu_ptr(p->ptr);
+	return 0;
+}
+
+SEC("?tc")
+int direct_read_lock(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	return *(int *)&f->lock;
+}
+
+SEC("?tc")
+int direct_write_lock(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	*(int *)&f->lock = 0;
+	return 0;
+}
+
+SEC("?tc")
+int direct_read_head(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	return *(int *)&f->head;
+}
+
+SEC("?tc")
+int direct_write_head(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	*(int *)&f->head = 0;
+	return 0;
+}
+
+SEC("?tc")
+int direct_read_node(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	return *(int *)&f->node;
+}
+
+SEC("?tc")
+int direct_write_node(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	*(int *)&f->node = 0;
+	return 0;
+}
+
+static __always_inline
+int write_after_op(void (*push_op)(void *head, void *node))
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&glock);
+	push_op(&ghead, &f->node);
+	f->data = 42;
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int write_after_push_front(void *ctx)
+{
+	return write_after_op((void *)bpf_list_push_front);
+}
+
+SEC("?tc")
+int write_after_push_back(void *ctx)
+{
+	return write_after_op((void *)bpf_list_push_back);
+}
+
+static __always_inline
+int use_after_unlock(void (*op)(void *head, void *node))
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&glock);
+	f->data = 42;
+	op(&ghead, &f->node);
+	bpf_spin_unlock(&glock);
+
+	return f->data;
+}
+
+SEC("?tc")
+int use_after_unlock_push_front(void *ctx)
+{
+	return use_after_unlock((void *)bpf_list_push_front);
+}
+
+SEC("?tc")
+int use_after_unlock_push_back(void *ctx)
+{
+	return use_after_unlock((void *)bpf_list_push_back);
+}
+
+static __always_inline
+int list_double_add(void (*op)(void *head, void *node))
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&glock);
+	op(&ghead, &f->node);
+	op(&ghead, &f->node);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int double_push_front(void *ctx)
+{
+	return list_double_add((void *)bpf_list_push_front);
+}
+
+SEC("?tc")
+int double_push_back(void *ctx)
+{
+	return list_double_add((void *)bpf_list_push_back);
+}
+
+SEC("?tc")
+int no_node_value_type(void *ctx)
+{
+	void *p;
+
+	p = bpf_obj_new(struct { int data; });
+	if (!p)
+		return 0;
+	bpf_spin_lock(&glock);
+	bpf_list_push_front(&ghead, p);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int incorrect_value_type(void *ctx)
+{
+	struct bar *b;
+
+	b = bpf_obj_new(typeof(*b));
+	if (!b)
+		return 0;
+	bpf_spin_lock(&glock);
+	bpf_list_push_front(&ghead, &b->node);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int incorrect_node_var_off(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&glock);
+	bpf_list_push_front(&ghead, (void *)&f->node + ctx->protocol);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int incorrect_node_off1(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&glock);
+	bpf_list_push_front(&ghead, (void *)&f->node + 1);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int incorrect_node_off2(void *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&glock);
+	bpf_list_push_front(&ghead, &f->node2);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int no_head_type(void *ctx)
+{
+	void *p;
+
+	p = bpf_obj_new(typeof(struct { int data; }));
+	if (!p)
+		return 0;
+	bpf_spin_lock(&glock);
+	bpf_list_push_front(p, NULL);
+	bpf_spin_lock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int incorrect_head_var_off1(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&glock);
+	bpf_list_push_front((void *)&ghead + ctx->protocol, &f->node);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int incorrect_head_var_off2(struct __sk_buff *ctx)
+{
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	bpf_spin_lock(&glock);
+	bpf_list_push_front((void *)&f->head + ctx->protocol, &f->node);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+SEC("?tc")
+int incorrect_head_off1(void *ctx)
+{
+	struct foo *f;
+	struct bar *b;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+	b = bpf_obj_new(typeof(*b));
+	if (!b) {
+		bpf_obj_drop(f);
+		return 0;
+	}
+
+	bpf_spin_lock(&f->lock);
+	bpf_list_push_front((void *)&f->head + 1, &b->node);
+	bpf_spin_unlock(&f->lock);
+
+	return 0;
+}
+
+SEC("?tc")
+int incorrect_head_off2(void *ctx)
+{
+	struct foo *f;
+	struct bar *b;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 0;
+
+	bpf_spin_lock(&glock);
+	bpf_list_push_front((void *)&ghead + 1, &f->node);
+	bpf_spin_unlock(&glock);
+
+	return 0;
+}
+
+static __always_inline
+int pop_ptr_off(void *(*op)(void *head))
+{
+	struct {
+		struct bpf_list_head head __contains(foo, node2);
+		struct bpf_spin_lock lock;
+	} *p;
+	struct bpf_list_node *n;
+
+	p = bpf_obj_new(typeof(*p));
+	if (!p)
+		return 0;
+	bpf_spin_lock(&p->lock);
+	n = op(&p->head);
+	bpf_spin_unlock(&p->lock);
+
+	bpf_this_cpu_ptr(n);
+	return 0;
+}
+
+SEC("?tc")
+int pop_front_off(void *ctx)
+{
+	return pop_ptr_off((void *)bpf_list_pop_front);
+}
+
+SEC("?tc")
+int pop_back_off(void *ctx)
+{
+	return pop_ptr_off((void *)bpf_list_pop_back);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.38.1


Return-Path: <bpf+bounces-9160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAA790CBC
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 17:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2726F280F4B
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E783FFA;
	Sun,  3 Sep 2023 15:15:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF244539A
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 15:15:46 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E89133
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 08:15:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so330291b3a.2
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693754109; x=1694358909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emsdL79mNwcx/aHgJI1te2fCXQqPIdLIm3CHxHOThlg=;
        b=qflp8iqV0D+S/YmSc5D9odf0l2LBtJFOHKAsf1b86+FEsjyZnuRsc0PczI5DsXdj0C
         bAwJ+UHhtrB/lMIOLg93iB9JxDT75x/4NewaUtFjILhqX/3SUUbnntmXLkSikzxnHFD+
         NLqyMt8Vvh4oQghP6VvJi36mqjAXtkNsiE85qsHUk/ti8LeoHcYqZ4uoTVDyLF+HGWvf
         4dN6ltd/EgaHeNniPFL/gVRms3YZh+Ce6LCVUQQi6q0DCda76JMXsgI7oKcz1E+T5SCY
         2YDVj8O/PDvHk5UFqGdk1wmVucdJiQwPSw6wBwZssreqI82J5YmgtCP+WZTYGC7K5Y0Q
         +MoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754109; x=1694358909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emsdL79mNwcx/aHgJI1te2fCXQqPIdLIm3CHxHOThlg=;
        b=dH3idTzjpqB5l3qwneEP8BMEsar1Zh0gz4qEuFoSn8szMWHPWdBV1/r8vcjKSmO6sA
         J0SKoD2M2ewtG1dFYvBa4Osscp/DjgVqa4qnZoGdhU66wPSgEqaGKcagTty9UkqvBgTu
         90esLd0p1HFRFS6bddZN6NjR6+hP2C2ahN7fDAFUq0CGbl6XSYp7gWbJh4YQG2UonKzY
         2ZgaQRT2JhJCL5mRRicdwZtNhp9f0tAM+g+xSlBf1Hb5tezc23sq2GhoRo8PGtT9Abjc
         X4eATAFIewFjul5n2A3R6mkvprg3ElyXEP0Xbf3x1xitoXKk2ONv6yfd57JF/IXuUVmg
         OqqQ==
X-Gm-Message-State: AOJu0Yyrw7BO83dHUYk53NOYoJ5a8X/FIG1SRVyz6O4KHnYSaDjFtLTh
	vjT+G90O4/93BEQlpb+VVuQ=
X-Google-Smtp-Source: AGHT+IGQEkhpCFm1Mwy1/OQQ8/+bfCXwPLSw7cJMyjkv6v+xEos9bKcHwyn2qrbPEQIw6dEsPnkndw==
X-Received: by 2002:a05:6a20:9759:b0:10c:7c72:bdf9 with SMTP id hs25-20020a056a20975900b0010c7c72bdf9mr5813483pzc.29.1693754109555;
        Sun, 03 Sep 2023 08:15:09 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id x17-20020aa784d1000000b00686940bfb77sm5882268pfn.71.2023.09.03.08.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:15:09 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	iii@linux.ibm.com,
	jakub@cloudflare.com,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v4 4/4] selftests/bpf: Add testcases for tailcall infinite loop fixing
Date: Sun,  3 Sep 2023 23:14:48 +0800
Message-ID: <20230903151448.61696-5-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230903151448.61696-1-hffilwlqm@gmail.com>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add 4 test cases to confirm the tailcall infinite loop bug has been fixed.

Like tailcall_bpf2bpf cases, do fentry/fexit on the bpf2bpf, and then
check the final count result.

tools/testing/selftests/bpf/test_progs -t tailcalls
226/13  tailcalls/tailcall_bpf2bpf_fentry:OK
226/14  tailcalls/tailcall_bpf2bpf_fexit:OK
226/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
226/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
226     tailcalls:OK
Summary: 1/16 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 299 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
 3 files changed, 335 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index b20d7f77a5bce..331b4e455ad06 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -884,6 +884,297 @@ static void test_tailcall_bpf2bpf_6(void)
 	tailcall_bpf2bpf6__destroy(obj);
 }
 
+static void tailcall_bpf2bpf_fentry_fexit(bool test_fentry, bool test_fexit)
+{
+	struct bpf_object *tgt_obj = NULL, *fentry_obj = NULL, *fexit_obj = NULL;
+	struct bpf_link *fentry_link = NULL, *fexit_link = NULL;
+	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
+	struct bpf_map *prog_array, *data_map;
+	struct bpf_program *prog;
+	char buff[128] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load("tailcall_bpf2bpf2.bpf.o",
+				 BPF_PROG_TYPE_SCHED_CLS,
+				 &tgt_obj, &prog_fd);
+	if (!ASSERT_OK(err, "load tgt_obj"))
+		return;
+
+	prog = bpf_object__find_program_by_name(tgt_obj, "entry");
+	if (!ASSERT_OK_PTR(prog, "find entry prog"))
+		goto out;
+
+	main_fd = bpf_program__fd(prog);
+	if (!ASSERT_FALSE(main_fd < 0, "find entry prog fd"))
+		goto out;
+
+	prog_array = bpf_object__find_map_by_name(tgt_obj, "jmp_table");
+	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (!ASSERT_FALSE(map_fd < 0, "find jmp_table map fd"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(tgt_obj, "classifier_0");
+	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_FALSE(prog_fd < 0, "find classifier_0 prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	if (test_fentry) {
+		fentry_obj = bpf_object__open_file("tailcall_bpf2bpf_fentry.bpf.o",
+						   NULL);
+		if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
+			goto out;
+
+		prog = bpf_object__find_program_by_name(fentry_obj, "fentry");
+		if (!ASSERT_OK_PTR(prog, "find fentry prog"))
+			goto out;
+
+		err = bpf_program__set_attach_target(prog, prog_fd,
+						     "subprog_tail");
+		if (!ASSERT_OK(err, "set_attach_target subprog_tail"))
+			goto out;
+
+		err = bpf_object__load(fentry_obj);
+		if (!ASSERT_OK(err, "load fentry_obj"))
+			goto out;
+
+		fentry_link = bpf_program__attach_trace(prog);
+		if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
+			goto out;
+	}
+
+	if (test_fexit) {
+		fexit_obj = bpf_object__open_file("tailcall_bpf2bpf_fexit.bpf.o",
+						  NULL);
+		if (!ASSERT_OK_PTR(fexit_obj, "open fexit_obj file"))
+			goto out;
+
+		prog = bpf_object__find_program_by_name(fexit_obj, "fexit");
+		if (!ASSERT_OK_PTR(prog, "find fexit prog"))
+			goto out;
+
+		err = bpf_program__set_attach_target(prog, prog_fd,
+						     "subprog_tail");
+		if (!ASSERT_OK(err, "set_attach_target subprog_tail"))
+			goto out;
+
+		err = bpf_object__load(fexit_obj);
+		if (!ASSERT_OK(err, "load fexit_obj"))
+			goto out;
+
+		fexit_link = bpf_program__attach_trace(prog);
+		if (!ASSERT_OK_PTR(fexit_link, "attach_trace"))
+			goto out;
+	}
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+	ASSERT_EQ(topts.retval, 1, "tailcall retval");
+
+	data_map = bpf_object__find_map_by_name(tgt_obj, "tailcall.bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find tailcall.bss map"))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_FALSE(data_fd < 0, "find tailcall.bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "tailcall count");
+	ASSERT_EQ(val, 33, "tailcall count");
+
+	if (test_fentry) {
+		data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
+		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+				  "find tailcall_bpf2bpf_fentry.bss map"))
+			goto out;
+
+		data_fd = bpf_map__fd(data_map);
+		if (!ASSERT_FALSE(data_fd < 0,
+				  "find tailcall_bpf2bpf_fentry.bss map fd"))
+			goto out;
+
+		i = 0;
+		err = bpf_map_lookup_elem(data_fd, &i, &val);
+		ASSERT_OK(err, "fentry count");
+		ASSERT_EQ(val, 33, "fentry count");
+	}
+
+	if (test_fexit) {
+		data_map = bpf_object__find_map_by_name(fexit_obj, ".bss");
+		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+				  "find tailcall_bpf2bpf_fexit.bss map"))
+			goto out;
+
+		data_fd = bpf_map__fd(data_map);
+		if (!ASSERT_FALSE(data_fd < 0,
+				  "find tailcall_bpf2bpf_fexit.bss map fd"))
+			goto out;
+
+		i = 0;
+		err = bpf_map_lookup_elem(data_fd, &i, &val);
+		ASSERT_OK(err, "fexit count");
+		ASSERT_EQ(val, 33, "fexit count");
+	}
+
+out:
+	bpf_link__destroy(fentry_link);
+	bpf_link__destroy(fexit_link);
+	bpf_object__close(fentry_obj);
+	bpf_object__close(fexit_obj);
+	bpf_object__close(tgt_obj);
+}
+
+/* test_tailcall_bpf2bpf_fentry checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by fentry.
+ */
+static void test_tailcall_bpf2bpf_fentry(void)
+{
+	tailcall_bpf2bpf_fentry_fexit(true, false);
+}
+
+/* test_tailcall_bpf2bpf_fexit checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by fexit.
+ */
+static void test_tailcall_bpf2bpf_fexit(void)
+{
+	tailcall_bpf2bpf_fentry_fexit(false, true);
+}
+
+/* test_tailcall_bpf2bpf_fentry_fexit checks that the count value of the tail
+ * call limit enforcement matches with expectations when tailcall is preceded
+ * with bpf2bpf call, and the bpf2bpf call is traced by both fentry and fexit.
+ */
+static void test_tailcall_bpf2bpf_fentry_fexit(void)
+{
+	tailcall_bpf2bpf_fentry_fexit(true, true);
+}
+
+/* test_tailcall_bpf2bpf_fentry_entry checks that the count value of the tail
+ * call limit enforcement matches with expectations when tailcall is preceded
+ * with bpf2bpf call, and the bpf2bpf caller is traced by fentry.
+ */
+static void test_tailcall_bpf2bpf_fentry_entry(void)
+{
+	struct bpf_object *tgt_obj = NULL, *fentry_obj = NULL;
+	int err, map_fd, prog_fd, data_fd, i, val;
+	struct bpf_map *prog_array, *data_map;
+	struct bpf_link *fentry_link = NULL;
+	struct bpf_program *prog;
+	char buff[128] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load("tailcall_bpf2bpf2.bpf.o",
+				 BPF_PROG_TYPE_SCHED_CLS,
+				 &tgt_obj, &prog_fd);
+	if (!ASSERT_OK(err, "load tgt_obj"))
+		return;
+
+	prog_array = bpf_object__find_map_by_name(tgt_obj, "jmp_table");
+	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (!ASSERT_FALSE(map_fd < 0, "find jmp_table map fd"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(tgt_obj, "classifier_0");
+	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_FALSE(prog_fd < 0, "find classifier_0 prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	fentry_obj = bpf_object__open_file("tailcall_bpf2bpf_fentry.bpf.o",
+					   NULL);
+	if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(fentry_obj, "fentry");
+	if (!ASSERT_OK_PTR(prog, "find fentry prog"))
+		goto out;
+
+	err = bpf_program__set_attach_target(prog, prog_fd, "classifier_0");
+	if (!ASSERT_OK(err, "set_attach_target classifier_0"))
+		goto out;
+
+	err = bpf_object__load(fentry_obj);
+	if (!ASSERT_OK(err, "load fentry_obj"))
+		goto out;
+
+	fentry_link = bpf_program__attach_trace(prog);
+	if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+	ASSERT_EQ(topts.retval, 1, "tailcall retval");
+
+	data_map = bpf_object__find_map_by_name(tgt_obj, "tailcall.bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find tailcall.bss map"))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_FALSE(data_fd < 0, "find tailcall.bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "tailcall count");
+	ASSERT_EQ(val, 34, "tailcall count");
+
+	data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find tailcall_bpf2bpf_fentry.bss map"))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_FALSE(data_fd < 0,
+			  "find tailcall_bpf2bpf_fentry.bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "fentry count");
+	ASSERT_EQ(val, 1, "fentry count");
+
+out:
+	bpf_link__destroy(fentry_link);
+	bpf_object__close(fentry_obj);
+	bpf_object__close(tgt_obj);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -910,4 +1201,12 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_4(true);
 	if (test__start_subtest("tailcall_bpf2bpf_6"))
 		test_tailcall_bpf2bpf_6();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry"))
+		test_tailcall_bpf2bpf_fentry();
+	if (test__start_subtest("tailcall_bpf2bpf_fexit"))
+		test_tailcall_bpf2bpf_fexit();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry_fexit"))
+		test_tailcall_bpf2bpf_fentry_fexit();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry_entry"))
+		test_tailcall_bpf2bpf_fentry_entry();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
new file mode 100644
index 0000000000000..8436c6729167c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int count = 0;
+
+SEC("fentry/subprog_tail")
+int BPF_PROG(fentry, struct sk_buff *skb)
+{
+	count++;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
new file mode 100644
index 0000000000000..fe16412c6e6e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int count = 0;
+
+SEC("fexit/subprog_tail")
+int BPF_PROG(fexit, struct sk_buff *skb)
+{
+	count++;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.41.0



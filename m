Return-Path: <bpf+bounces-9763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 582DA79D44E
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8915D281BDC
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E618C07;
	Tue, 12 Sep 2023 15:05:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7AA952
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 15:05:04 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC771115
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 08:05:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bf55a81eeaso39313765ad.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694531103; x=1695135903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfVvgOJTXqrns/RXSyNCC8WwMRAz+jjmfx8yekQjfGE=;
        b=pKw6M3vw/84LphYHVc6BQjdSq6N9pBbs9VtdeaoMFLOn5wZRddWo00qj3hCVWutlti
         DyShWscduIM+NWbshxPhMye1Pgwnyq6/v1UAgYn4djmaXftofZl8z6I6CCjyj/YIMdaX
         Aro1Z8odiOwL8PWzwo9bhUsCeeQFjZo+rRJANsOIhdi2gPkDHe4W8CjE9cqC6cFV/jPw
         6UCYfs8tEYNR0jNttvC6wjixab5FqLpY8N2phvp3pNzdUMY/CjAykyF77p2wHTWH5143
         W61ghN+hyLnebWqYRF6XwhNY5Kgps6r5A87HGTLTcdrLnCzKhYdJpUovnoR1w9R81l+9
         LzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531103; x=1695135903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfVvgOJTXqrns/RXSyNCC8WwMRAz+jjmfx8yekQjfGE=;
        b=dzW+4LWlQRDmryGVrqi/JOssAaNwY3Jt3EfVsu9qGvS0sBdig5KHDB1WNoeZZEcFhW
         BwfRWdPAJZjrJbHywwytoQIvi+m6rviss32EjVGv0xlmuOPcEeH/fTOx01GjbTNQkTq1
         2J0KL1F1YQDQiuzqLRJ0AByA+Jlqv/kbbNyE5DpVKdk0HJca5oWCTdHjdkcx+eKSqcov
         /AwnlB/zVHiIoLawLDyITawpBmV+UtaVwxNHe9+W5u1k5AlQhxoBZbAgSQdIfLkey7P2
         rDdOVEfaLVP4FVmrw0wXLrge1dakaqP+ImDm7SWzghP2nnqqAK86zcH3DTG5G21h/OO5
         m4Dg==
X-Gm-Message-State: AOJu0YyeW1Estw2vHhLblNpkxNQRfQc4K1Hp5WQGUoC/T6TbqXTHo/Fl
	JVfeaHEkjCldcXhwEDbh0UydTcA5Xpk=
X-Google-Smtp-Source: AGHT+IF3x/UoirAEaU7h89t5BpycEGa+eJ3dO5jrMfhn90+5EFQAvlZKLlpyz1xi/WpxF1hFuLLjbw==
X-Received: by 2002:a17:902:da92:b0:1bb:b226:52b1 with SMTP id j18-20020a170902da9200b001bbb22652b1mr1866plx.17.1694531102406;
        Tue, 12 Sep 2023 08:05:02 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001b8b26fa6c1sm8526941pli.115.2023.09.12.08.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:05:02 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	song@kernel.org,
	iii@linux.ibm.com,
	xukuohai@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add testcases for tailcall infinite loop fixing
Date: Tue, 12 Sep 2023 23:04:42 +0800
Message-ID: <20230912150442.2009-4-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912150442.2009-1-hffilwlqm@gmail.com>
References: <20230912150442.2009-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 .../selftests/bpf/prog_tests/tailcalls.c      | 237 +++++++++++++++++-
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
 3 files changed, 269 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 09c189761926c..fc6b2954e8f50 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -218,12 +218,14 @@ static void test_tailcall_2(void)
 	bpf_object__close(obj);
 }
 
-static void test_tailcall_count(const char *which)
+static void test_tailcall_count(const char *which, bool test_fentry,
+				bool test_fexit)
 {
+	struct bpf_object *obj = NULL, *fentry_obj = NULL, *fexit_obj = NULL;
+	struct bpf_link *fentry_link = NULL, *fexit_link = NULL;
 	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
 	struct bpf_map *prog_array, *data_map;
 	struct bpf_program *prog;
-	struct bpf_object *obj;
 	char buff[128] = {};
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = buff,
@@ -265,6 +267,54 @@ static void test_tailcall_count(const char *which)
 	if (CHECK_FAIL(err))
 		goto out;
 
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
 	err = bpf_prog_test_run_opts(main_fd, &topts);
 	ASSERT_OK(err, "tailcall");
 	ASSERT_EQ(topts.retval, 1, "tailcall retval");
@@ -282,6 +332,40 @@ static void test_tailcall_count(const char *which)
 	ASSERT_OK(err, "tailcall count");
 	ASSERT_EQ(val, 33, "tailcall count");
 
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
 	i = 0;
 	err = bpf_map_delete_elem(map_fd, &i);
 	if (CHECK_FAIL(err))
@@ -291,6 +375,10 @@ static void test_tailcall_count(const char *which)
 	ASSERT_OK(err, "tailcall");
 	ASSERT_OK(topts.retval, "tailcall retval");
 out:
+	bpf_link__destroy(fentry_link);
+	bpf_link__destroy(fexit_link);
+	bpf_object__close(fentry_obj);
+	bpf_object__close(fexit_obj);
 	bpf_object__close(obj);
 }
 
@@ -299,7 +387,7 @@ static void test_tailcall_count(const char *which)
  */
 static void test_tailcall_3(void)
 {
-	test_tailcall_count("tailcall3.bpf.o");
+	test_tailcall_count("tailcall3.bpf.o", false, false);
 }
 
 /* test_tailcall_6 checks that the count value of the tail call limit
@@ -307,7 +395,7 @@ static void test_tailcall_3(void)
  */
 static void test_tailcall_6(void)
 {
-	test_tailcall_count("tailcall6.bpf.o");
+	test_tailcall_count("tailcall6.bpf.o", false, false);
 }
 
 /* test_tailcall_4 checks that the kernel properly selects indirect jump
@@ -884,6 +972,139 @@ static void test_tailcall_bpf2bpf_6(void)
 	tailcall_bpf2bpf6__destroy(obj);
 }
 
+/* test_tailcall_bpf2bpf_fentry checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by fentry.
+ */
+static void test_tailcall_bpf2bpf_fentry(void)
+{
+	test_tailcall_count("tailcall_bpf2bpf2.bpf.o", true, false);
+}
+
+/* test_tailcall_bpf2bpf_fexit checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by fexit.
+ */
+static void test_tailcall_bpf2bpf_fexit(void)
+{
+	test_tailcall_count("tailcall_bpf2bpf2.bpf.o", false, true);
+}
+
+/* test_tailcall_bpf2bpf_fentry_fexit checks that the count value of the tail
+ * call limit enforcement matches with expectations when tailcall is preceded
+ * with bpf2bpf call, and the bpf2bpf call is traced by both fentry and fexit.
+ */
+static void test_tailcall_bpf2bpf_fentry_fexit(void)
+{
+	test_tailcall_count("tailcall_bpf2bpf2.bpf.o", true, true);
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
@@ -910,4 +1131,12 @@ void test_tailcalls(void)
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



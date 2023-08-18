Return-Path: <bpf+bounces-8073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2940780EBF
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC27B1C21678
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77D18C30;
	Fri, 18 Aug 2023 15:12:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A7D18B09
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:12:50 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C434230
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:12:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-689fa6f94e1so837683b3a.1
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371558; x=1692976358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8S8IoAhjbFZeofOhQRb5ODQBnSkFGF/yd2MFLkn/fE=;
        b=nu09NDnCY0DOuMtrPYQ6lpfR+Phk7ERl3siZnTjsVnYKDXs13HzYeLXoapLVK8dAd0
         TwZxqcX/XdQzmfLWLuVMtbosJZSv3FNFwmEGaUH43sChQmHTLsW5n8gc35IudAGIzdGx
         RJFk4Hx/Ogw/fmEdhChqow0SIVYYXtU24ey6sptxG559+exsEPJMt0wVV01QOfF9c1O3
         2kAtj7CiiAsKvBy94wj0cRN9FEIewQJQkVJTrxDIH20Lncpa1pt7Jde85TKgVtF8hO5n
         C+OTGoLarUOW6zVfhNDGIsNXZfpmvayvv/6TlaTXaecPdueTE5eh7oSrKmF93isiW6/4
         WQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371558; x=1692976358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8S8IoAhjbFZeofOhQRb5ODQBnSkFGF/yd2MFLkn/fE=;
        b=JZX6OZ3q3wQX7mmWaXtuGapzZmmq9LdidEohDK1QGqlS0IVre6RRK3ubBtSGF7/F0d
         W5ApO5UWjdpfoU6Fj7mHkcNvUNd+wbcTQTg08JpstMnF6w19wtbmePVvgLNQW3n1oUDa
         MITtpmgHLpGlsT/1NmrkvoKiX+N3IrEc2qR+JsujoYrPeOtSi1GBH23UzcqGyiD5jtfW
         QYqPmkAg0rFxTTa09BaMTet0QNjPrp/vB1c89DBg/LX3nj0ORR+0lR7SR/PHFBzX4+uO
         hDuy3Q3FhuYfeAmZ22HqeR6rvotUJW+GB0SlWnPxJ8oK+YMJsmeUHJyUNE/N1PSskI8l
         0akw==
X-Gm-Message-State: AOJu0YwqNg4va6IL2J8JfOVmobq7XCEnhW962DOgyPVlH3cPJkmtXpua
	/sN5pQaFEvDPqktNc+zCFc4=
X-Google-Smtp-Source: AGHT+IFmsVGPFepQQ9jYMDpJeOMhPOt/ZmuNu/HDOdSp5mHb4p8auWYOtGZyGQY9VgyqmB/DliPkpQ==
X-Received: by 2002:a05:6a00:1346:b0:681:eddd:51fb with SMTP id k6-20020a056a00134600b00681eddd51fbmr3291275pfu.18.1692371558565;
        Fri, 18 Aug 2023 08:12:38 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id j19-20020a62b613000000b00686dd062207sm1650967pff.150.2023.08.18.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:38 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 2/2] selftests/bpf: Add testcases for tailcall infinite loop fixing
Date: Fri, 18 Aug 2023 23:12:16 +0800
Message-ID: <20230818151216.7686-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818151216.7686-1-hffilwlqm@gmail.com>
References: <20230818151216.7686-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add 3 test cases to confirm the tailcall infinite loop bug has been fixed.

Like tailcall_bpf2bpf cases, do fentry/fexit on the bpf2bpf, and then
check the final count result.

tools/testing/selftests/bpf/test_progs -t tailcalls
226/13  tailcalls/tailcall_bpf2bpf_fentry:OK
226/14  tailcalls/tailcall_bpf2bpf_fexit:OK
226/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
226     tailcalls:OK
Summary: 1/15 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 194 +++++++++++++++++-
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 58fe2c586ed76..a47c2fd6b8d37 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -634,7 +634,7 @@ static void test_tailcall_bpf2bpf_2(void)
 		return;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
+	if (CHECK_FAIL(data_fd < 0))
 		return;
 
 	i = 0;
@@ -884,6 +884,191 @@ static void test_tailcall_bpf2bpf_6(void)
 	tailcall_bpf2bpf6__destroy(obj);
 }
 
+static void __tailcall_bpf2bpf_fentry_fexit(bool test_fentry, bool test_fexit)
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
+				  "find tailcall_bpf2bpf_fentry.bss.bss map"))
+			goto out;
+
+		data_fd = bpf_map__fd(data_map);
+		if (!ASSERT_FALSE(data_fd < 0,
+				  "find tailcall_bpf2bpf_fentry.bss.bss map fd"))
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
+	__tailcall_bpf2bpf_fentry_fexit(true, false);
+}
+
+/* test_tailcall_bpf2bpf_fexit checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by fexit.
+ */
+static void test_tailcall_bpf2bpf_fexit(void)
+{
+	__tailcall_bpf2bpf_fentry_fexit(false, true);
+}
+
+/* test_tailcall_bpf2bpf_fentry_fexit checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by both fentry and fexit.
+ */
+static void test_tailcall_bpf2bpf_fentry_fexit(void)
+{
+	__tailcall_bpf2bpf_fentry_fexit(true, true);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -910,4 +1095,11 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_4(true);
 	if (test__start_subtest("tailcall_bpf2bpf_6"))
 		test_tailcall_bpf2bpf_6();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry"))
+		test_tailcall_bpf2bpf_fentry();
+	if (test__start_subtest("tailcall_bpf2bpf_fexit"))
+		test_tailcall_bpf2bpf_fexit();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry_fexit"))
+		test_tailcall_bpf2bpf_fentry_fexit();
 }
+
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



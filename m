Return-Path: <bpf+bounces-11451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3C7BA1C8
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 16:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6F48BB20AED
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F72E625;
	Thu,  5 Oct 2023 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4SR48wO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E418EA6
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 14:59:01 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D146BBBD
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:58:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6934202b8bdso895808b3a.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696517938; x=1697122738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8k/firFt8GFtmOzfzAkMAqTvf+tdjpGx4hzpKlHyVM=;
        b=K4SR48wOzBxsjPq/x37zYlH5nsuIMPfgEbvtev6v33mVRothlcD1PNSgHzqpw5vrfu
         jNnHHy8pzazKy3pvG3DxnP6TFZHpRROx/pt8wH7KRkJHasmj522dk2jpcH2AjuPdszdL
         Mhr+U0DpOiVdO00vCsQtx6YakYMQQipDxnyN64u55hTq9kI8mpvNRm2vaf0Wh/fBi8ML
         FUNKEGnBrL5B5WhyiYyjHev8L2n3AWMW6Fmv10VPlHVlTcO5sTFymB56zw+wL43rOX8e
         eFcaoNVeu/DJ9fk7z72JmxXIILX3P32zF8RkO+DGyR2lDiDofDkPrPo0Jj6i4BmRQusb
         jH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517938; x=1697122738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8k/firFt8GFtmOzfzAkMAqTvf+tdjpGx4hzpKlHyVM=;
        b=J0GTphPLQ9N5ZB40E1Wwi7/kGgSNvWiJYJ2Hh2nmPu3lKvFpU2emQ52Y2gAkiHqHrU
         BFNn+VE/lmPmP3Xl60Lf6ubSYrbDzt3DSsDoDl5uWds4dSB9nw6M4e/yMxDw9mSQm9aJ
         5L/u2jZGm6+AJRwIXw1hodTVQWq61aJN710d7dfDiPvrSilO3UaLTRmRDNoNDqsr9rZc
         46fxfcLzh61hkSfRNEnUjWNQM4NZg07OGOC9CmurqFNZ7namPFgkYO08zO/akINx/gy5
         FBieNpTYg7g1RNYrbcfwzD91NMCVXbtFKpdBex7aDFCn5SvTcuO2RK6YUgELEInJ2Sp5
         SOFA==
X-Gm-Message-State: AOJu0Yw0ZuuyR611gIJYAfvmOp4qkWUPTwT9WO5PRIM3j+y8srQj1264
	/910QI1Z0IiTbFnSqU9Z4wG1x5WPgfXZig==
X-Google-Smtp-Source: AGHT+IGcbd/8Rm0JUFrhp3tmByX06y/m2/qvk6wj/nD9S070sUdV+r4vvCotoBZKv+PiTsnW3q/qgg==
X-Received: by 2002:a05:6a21:71c1:b0:15d:ad11:748 with SMTP id ay1-20020a056a2171c100b0015dad110748mr5759508pzc.30.1696517937768;
        Thu, 05 Oct 2023 07:58:57 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902a3c100b001c61512f2a6sm1819930plb.220.2023.10.05.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:58:57 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com
Subject: [RFC PATCH bpf-next 3/3] selftests/bpf: Add testcases for tailcall hierarchy fixing
Date: Thu,  5 Oct 2023 22:58:14 +0800
Message-ID: <20231005145814.83122-4-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005145814.83122-1-hffilwlqm@gmail.com>
References: <20231005145814.83122-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add some test cases to confirm the tailcall hierarchy issue has been fixed.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 384 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 +++
 4 files changed, 519 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index fc6b2954e8f50..3133fe63808ac 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1105,6 +1105,378 @@ static void test_tailcall_bpf2bpf_fentry_entry(void)
 	bpf_object__close(tgt_obj);
 }
 
+
+static void test_tailcall_hierarchy_count(const char *which, bool test_fentry,
+					  bool test_fexit)
+{
+	int err, map_fd, prog_fd, main_data_fd, fentry_data_fd, fexit_data_fd, i, val;
+	struct bpf_object *obj = NULL, *fentry_obj = NULL, *fexit_obj = NULL;
+	struct bpf_link *fentry_link = NULL, *fexit_link = NULL;
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
+	err = bpf_prog_test_load(which, BPF_PROG_TYPE_SCHED_CLS, &obj,
+				 &prog_fd);
+	if (!ASSERT_OK(err, "load obj"))
+		return;
+
+	prog = bpf_object__find_program_by_name(obj, "entry");
+	if (!ASSERT_OK_PTR(prog, "find entry prog"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
+		goto out;
+
+	prog_array = bpf_object__find_map_by_name(obj, "jmp_table");
+	if (!ASSERT_OK_PTR(prog_array, "find jmp_table"))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (!ASSERT_GE(map_fd, 0, "map_fd"))
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
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+	ASSERT_EQ(topts.retval, 1, "tailcall retval");
+
+	data_map = bpf_object__find_map_by_name(obj, ".bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find data_map"))
+		goto out;
+
+	main_data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_GE(main_data_fd, 0, "main_data_fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(main_data_fd, &i, &val);
+	ASSERT_OK(err, "tailcall count");
+	ASSERT_EQ(val, 34, "tailcall count");
+
+	if (test_fentry) {
+		data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
+		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+				  "find tailcall_bpf2bpf_fentry.bss map"))
+			goto out;
+
+		fentry_data_fd = bpf_map__fd(data_map);
+		if (!ASSERT_GE(fentry_data_fd, 0,
+				  "find tailcall_bpf2bpf_fentry.bss map fd"))
+			goto out;
+
+		i = 0;
+		err = bpf_map_lookup_elem(fentry_data_fd, &i, &val);
+		ASSERT_OK(err, "fentry count");
+		ASSERT_EQ(val, 68, "fentry count");
+	}
+
+	if (test_fexit) {
+		data_map = bpf_object__find_map_by_name(fexit_obj, ".bss");
+		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+				  "find tailcall_bpf2bpf_fexit.bss map"))
+			goto out;
+
+		fexit_data_fd = bpf_map__fd(data_map);
+		if (!ASSERT_GE(fexit_data_fd, 0,
+				  "find tailcall_bpf2bpf_fexit.bss map fd"))
+			goto out;
+
+		i = 0;
+		err = bpf_map_lookup_elem(fexit_data_fd, &i, &val);
+		ASSERT_OK(err, "fexit count");
+		ASSERT_EQ(val, 68, "fexit count");
+	}
+
+	i = 0;
+	err = bpf_map_delete_elem(map_fd, &i);
+	if (!ASSERT_OK(err, "delete_elem from jmp_table"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+	ASSERT_EQ(topts.retval, 1, "tailcall retval");
+
+	i = 0;
+	err = bpf_map_lookup_elem(main_data_fd, &i, &val);
+	ASSERT_OK(err, "tailcall count");
+	ASSERT_EQ(val, 35, "tailcall count");
+
+	if (test_fentry) {
+		i = 0;
+		err = bpf_map_lookup_elem(fentry_data_fd, &i, &val);
+		ASSERT_OK(err, "fentry count");
+		ASSERT_EQ(val, 70, "fentry count");
+	}
+
+	if (test_fexit) {
+		i = 0;
+		err = bpf_map_lookup_elem(fexit_data_fd, &i, &val);
+		ASSERT_OK(err, "fexit count");
+		ASSERT_EQ(val, 70, "fexit count");
+	}
+
+out:
+	bpf_link__destroy(fentry_link);
+	bpf_link__destroy(fexit_link);
+	bpf_object__close(fentry_obj);
+	bpf_object__close(fexit_obj);
+	bpf_object__close(obj);
+}
+
+static void test_tailcall_bpf2bpf_hierarchy_1(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      false, false);
+}
+
+static void test_tailcall_bpf2bpf_hierarchy_fentry(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      true, false);
+}
+
+static void test_tailcall_bpf2bpf_hierarchy_fexit(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      false, true);
+}
+
+static void test_tailcall_bpf2bpf_hierarchy_fentry_fexit(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      true, true);
+}
+
+static void test_tailcall_bpf2bpf_hierarchy_2(void)
+{
+	int err, map_fd, prog_fd, data_fd, main_fd, i, val[2];
+	struct bpf_map *prog_array, *data_map;
+	struct bpf_object *obj = NULL;
+	struct bpf_program *prog;
+	char buff[128] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load("tailcall_bpf2bpf_hierarchy2.bpf.o",
+				 BPF_PROG_TYPE_SCHED_CLS,
+				 &obj, &prog_fd);
+	if (!ASSERT_OK(err, "load obj"))
+		return;
+
+	prog = bpf_object__find_program_by_name(obj, "entry");
+	if (!ASSERT_OK_PTR(prog, "find entry prog"))
+		goto out;
+
+	main_fd = bpf_program__fd(prog);
+	if (!ASSERT_GE(main_fd, 0, "main_fd"))
+		goto out;
+
+	prog_array = bpf_object__find_map_by_name(obj, "jmp_table");
+	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (!ASSERT_GE(map_fd, 0, "find jmp_table map fd"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(obj, "classifier_0");
+	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GE(prog_fd, 0, "find classifier_0 prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(obj, "classifier_1");
+	if (!ASSERT_OK_PTR(prog, "find classifier_1 prog"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GE(prog_fd, 0, "find classifier_1 prog fd"))
+		goto out;
+
+	i = 1;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+	ASSERT_EQ(topts.retval, 1, "tailcall retval");
+
+	data_map = bpf_object__find_map_by_name(obj, ".bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find .bss map"))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_GE(data_fd, 0, "find .bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "tailcall counts");
+	ASSERT_EQ(val[0], 33, "tailcall count0");
+	ASSERT_EQ(val[1], 0, "tailcall count1");
+
+out:
+	bpf_object__close(obj);
+}
+
+static void test_tailcall_bpf2bpf_hierarchy_3(void)
+{
+	int err, map_fd, prog_fd, data_fd, main_fd, i, val;
+	struct bpf_map *prog_array, *data_map;
+	struct bpf_object *obj = NULL;
+	struct bpf_program *prog;
+	char buff[128] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load("tailcall_bpf2bpf_hierarchy3.bpf.o",
+				 BPF_PROG_TYPE_SCHED_CLS,
+				 &obj, &prog_fd);
+	if (!ASSERT_OK(err, "load obj"))
+		return;
+
+	prog = bpf_object__find_program_by_name(obj, "entry");
+	if (!ASSERT_OK_PTR(prog, "find entry prog"))
+		goto out;
+
+	main_fd = bpf_program__fd(prog);
+	if (!ASSERT_GE(main_fd, 0, "main_fd"))
+		goto out;
+
+	prog_array = bpf_object__find_map_by_name(obj, "jmp_table0");
+	if (!ASSERT_OK_PTR(prog_array, "find jmp_table0 map"))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (!ASSERT_GE(map_fd, 0, "find jmp_table0 map fd"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(obj, "classifier_0");
+	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GE(prog_fd, 0, "find classifier_0 prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table0"))
+		goto out;
+
+	prog_array = bpf_object__find_map_by_name(obj, "jmp_table1");
+	if (!ASSERT_OK_PTR(prog_array, "find jmp_table1 map"))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (!ASSERT_GE(map_fd, 0, "find jmp_table1 map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table1"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+	ASSERT_EQ(topts.retval, 1, "tailcall retval");
+
+	data_map = bpf_object__find_map_by_name(obj, ".bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find .bss map"))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_GE(data_fd, 0, "find .bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "tailcall count");
+	ASSERT_EQ(val, 33, "tailcall count");
+
+out:
+	bpf_object__close(obj);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1139,4 +1511,16 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_fentry_fexit();
 	if (test__start_subtest("tailcall_bpf2bpf_fentry_entry"))
 		test_tailcall_bpf2bpf_fentry_entry();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_1"))
+		test_tailcall_bpf2bpf_hierarchy_1();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_fentry"))
+		test_tailcall_bpf2bpf_hierarchy_fentry();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_fexit"))
+		test_tailcall_bpf2bpf_hierarchy_fexit();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_fentry_fexit"))
+		test_tailcall_bpf2bpf_hierarchy_fentry_fexit();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_2"))
+		test_tailcall_bpf2bpf_hierarchy_2();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_3"))
+		test_tailcall_bpf2bpf_hierarchy_3();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
new file mode 100644
index 0000000000000..0bfbb7c9637b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int count = 0;
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return 0;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	volatile int ret = 1;
+
+	count++;
+	subprog_tail(skb);
+	subprog_tail(skb);
+
+	return ret;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
new file mode 100644
index 0000000000000..b84541546082e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int count0 = 0;
+int count1 = 0;
+
+static __noinline
+int subprog_tail0(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return 0;
+}
+
+SEC("tc")
+int classifier_0(struct __sk_buff *skb)
+{
+	count0++;
+	subprog_tail0(skb);
+	return 0;
+}
+
+static __noinline
+int subprog_tail1(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 1);
+	return 0;
+}
+
+SEC("tc")
+int classifier_1(struct __sk_buff *skb)
+{
+	count1++;
+	subprog_tail1(skb);
+	return 0;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	subprog_tail0(skb);
+	subprog_tail1(skb);
+
+	return 1;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
new file mode 100644
index 0000000000000..6398a1d277fc7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table0 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table1 SEC(".maps");
+
+int count = 0;
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb, void *jmp_table)
+{
+	bpf_tail_call_static(skb, jmp_table, 0);
+	return 0;
+}
+
+SEC("tc")
+int classifier_0(struct __sk_buff *skb)
+{
+	count++;
+	subprog_tail(skb, &jmp_table0);
+	subprog_tail(skb, &jmp_table1);
+	return 1;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table0, 0);
+
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.41.0



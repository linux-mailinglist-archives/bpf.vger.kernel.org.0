Return-Path: <bpf+bounces-11926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0AE7C5814
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FF92822BC
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A8208B1;
	Wed, 11 Oct 2023 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaVK4Gfd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17DC208A5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:27:51 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60761C6
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5859e22c7daso4635448a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697038068; x=1697642868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxzR9NLlC2+DuS+sWV6UtSEyEf7PN1ARSs2qggkMpjY=;
        b=KaVK4GfdgwDF64lgXUjc6YzlAwmRnQoVfccEklKNeIHXXfbG9BcW7Y8OSM0MftQfRE
         L+lLBscGRaslbYaLvOz9kdQFPteSTRtQuKPQUI3lfJ58LsZzDFTcPjQFru5G4eNXGxST
         C51wM/LKE7R8NKCzZgETxHHWfEfFsCmGwZaDplbm0ET10ek8o4if+RqHKlEvONrNe8fC
         1hezaEY5SWFYR+042YFHBCsaANs/aF1Mc4vQV+gSvjdWoD3Qngr0JaQVKz6Ti6XLtmmZ
         MM6BHwJAyMnMVMq1/s6+JmPltYNqZQ0ZuCI0ho2xANN1WgF0Y4Ls9pRd+YwwiEfbgbfs
         Z4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038068; x=1697642868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxzR9NLlC2+DuS+sWV6UtSEyEf7PN1ARSs2qggkMpjY=;
        b=X8retRRPW1NGPDDBrKv5XlGmZaKue/llEX6HPNXcJAEf/vRrg/J9x1hUH2OC3rqak9
         k5SQWXNmPadDnln80UaXD7TS2C4q4YYv2eI+DYlBpFN+AVY//8DG5MAjl9ghiTexI7N6
         4xdkvGy9nynCMgwdN7AoOe2uJ4EQPqhnl84aUArB6aSW9efZ0GONpEe9vM/yczAJ6pa/
         y9JX3VR/6XWSopcxgGRvT5YpvlIMpYd31W1fD8BE7DT2/N9+zCqqw85MZZhA2TLvarTX
         +LR7+bpeMcGFfQjPb1U70wISU5YNAtTOlOCHYCpoU79CTKJZGVCs7hgx0bul9Q02Zkbo
         LibQ==
X-Gm-Message-State: AOJu0Yx5+2H1+Wnj+0xzwgWt/Ue8NRsERcdJ1ZjQIVmQMm1vFYHYOJt7
	brXZX48nk8kVtCakbI1v9txV7qx6WNm6+A==
X-Google-Smtp-Source: AGHT+IEGVhYxqWRXpfF1MdeRoronRzS49GOKwhGwHWevrdT34kS0ypY5rd9EYijM0nE6kStkVpXUVw==
X-Received: by 2002:a05:6a20:96c7:b0:15d:2bff:77b with SMTP id hq7-20020a056a2096c700b0015d2bff077bmr16581261pzc.34.1697038068203;
        Wed, 11 Oct 2023 08:27:48 -0700 (PDT)
Received: from localhost.localdomain (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001c755810f89sm14092070plb.181.2023.10.11.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:27:47 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 4/4] selftests/bpf: Add testcases for tailcall hierarchy fixing
Date: Wed, 11 Oct 2023 23:27:25 +0800
Message-ID: <20231011152725.95895-5-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011152725.95895-1-hffilwlqm@gmail.com>
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
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

tools/testing/selftests/bpf/test_progs -t tailcalls
235/17  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
235/18  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
235/19  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
235/20  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
235/21  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
235/22  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
235     tailcalls:OK
Summary: 1/22 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 418 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
 4 files changed, 553 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index fc6b2954e8f50..49d9b7ed41950 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1105,6 +1105,412 @@ static void test_tailcall_bpf2bpf_fentry_entry(void)
 	bpf_object__close(tgt_obj);
 }
 
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
+/* test_tailcall_bpf2bpf_hierarchy_1 checks that the count value of the tail
+ * call limit enforcement matches with expectations when tailcalls are preceded
+ * with two bpf2bpf calls.
+ *
+ *         subprog --tailcall-> entry
+ * entry <
+ *         subprog --tailcall-> entry
+ */
+static void test_tailcall_bpf2bpf_hierarchy_1(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      false, false);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_fentry checks that the count value of the
+ * tail call limit enforcement matches with expectations when tailcalls are
+ * preceded with two bpf2bpf calls, and the two subprogs are traced by fentry.
+ */
+static void test_tailcall_bpf2bpf_hierarchy_fentry(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      true, false);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_fexit checks that the count value of the tail
+ * call limit enforcement matches with expectations when tailcalls are preceded
+ * with two bpf2bpf calls, and the two subprogs are traced by fexit.
+ */
+static void test_tailcall_bpf2bpf_hierarchy_fexit(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      false, true);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_fentry_fexit checks that the count value of
+ * the tail call limit enforcement matches with expectations when tailcalls are
+ * preceded with two bpf2bpf calls, and the two subprogs are traced by both
+ * fentry and fexit.
+ */
+static void test_tailcall_bpf2bpf_hierarchy_fentry_fexit(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      true, true);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_2 checks that the count value of the tail
+ * call limit enforcement matches with expectations:
+ *
+ *         subprog_tail0 --tailcall-> classifier_0 -> subprog_tail0
+ * entry <
+ *         subprog_tail1 --tailcall-> classifier_1 -> subprog_tail1
+ */
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
+/* test_tailcall_bpf2bpf_hierarchy_3 checks that the count value of the tail
+ * call limit enforcement matches with expectations:
+ *
+ *                                   subprog with jmp_table0 to classifier_0
+ * entry --tailcall-> classifier_0 <
+ *                                   subprog with jmp_table1 to classifier_0
+ */
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
@@ -1139,4 +1545,16 @@ void test_tailcalls(void)
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



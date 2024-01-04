Return-Path: <bpf+bounces-19028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786258243AA
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 15:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0574B2530B
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 14:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED677224FE;
	Thu,  4 Jan 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnSKyFQm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4093224E5
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28cb1286e10so368728a91.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 06:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704378195; x=1704982995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnwSmUkdDX0fU7kXOxEGZY6UxnQL18hcZFfgOpLYyjI=;
        b=DnSKyFQm2452URQOEJtNUGtuul5rkqGERWSiacJn21omilUy6AXMrx+mCB47nQakFl
         ZEoRefRppLyJm0x49hnx9YqrGGXwehQvIa4UaNrNya89pL49cVrMtER+HiQSbtm8bnDY
         ZVQVNNlYsM+CZbTt/R0AErXaxEx9NxHkmeRud14LGOMrkrod1mjgGswRm5wXbAJt1OxO
         kKXQjB9zaCh+st+lEqmtc7y/DS47Rt0bvjUeYnPjZXFZgyooSFjiZal3nCTXKYj84yR0
         8JkFNybEkavzHKW76QQXIWB59Bbx0wdU0uLKJJEQ/CStgAt5m2PLSnDExpfYhOMGBAZI
         SlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704378195; x=1704982995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnwSmUkdDX0fU7kXOxEGZY6UxnQL18hcZFfgOpLYyjI=;
        b=TSLDyMiqwIj84g5gcq+eMkelJgYPlfdI0qDwK+scMUH3Zz+Z5zWEySPAP4m+iK4zp0
         vbYMUDm0c1GwxWc0xA/gBBPWQaave1I6kM2Gmo+RPgCRUXDi6J42aV8XionGAby1YQJE
         T5onBgn7ZsfRczb+nt+oYyYVdxIv0K1fi4CIE22wV6X3JJgpflBjY7sXr22J/AGURh2h
         gLMsXQZJkaD7EqFsVXK3g87HjypGgxAgCi+bGZgkEturR1SEQg4WNn5Z4tSxVKykvsVz
         tKLFXKjic7KR+k+MOMn5xpPXJef65knjmM1y2YnqiRe1bd+0olQ9PgII6XvPICp17apY
         xUmQ==
X-Gm-Message-State: AOJu0YzPsf7R5pQj6v2VTcWACxfL8r2N5QQjvSpQ9rE0GrxqYzcbCkj8
	dGMk/YfgqKiNuO2jKU1VvwxBsMu71Pg=
X-Google-Smtp-Source: AGHT+IFtrmDWjGZxKoDgwuwSfbafUkm/lNVg88bYLCwg4/VCMHWf8hNzN1RkKZndQnNKRlF8wQKfww==
X-Received: by 2002:a17:90a:890c:b0:28c:acd8:c9cd with SMTP id u12-20020a17090a890c00b0028cacd8c9cdmr567787pjn.9.1704378195146;
        Thu, 04 Jan 2024 06:23:15 -0800 (PST)
Received: from localhost.localdomain (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a020a00b0028cb82a8da0sm4081507pjc.31.2024.01.04.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:23:14 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add testcases for tailcall hierarchy fixing
Date: Thu,  4 Jan 2024 22:22:26 +0800
Message-ID: <20240104142226.87869-5-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240104142226.87869-1-hffilwlqm@gmail.com>
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some test cases to confirm the tailcall hierarchy issue has been fixed.

tools/testing/selftests/bpf/test_progs -t tailcalls
305/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
305/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
305/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
305/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
305/22  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
305/23  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
305     tailcalls:OK
Summary: 1/23 PASSED, 0 SKIPPED, 0 FAILED

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
index 59993fc9c0d7e..e796328faf2e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1187,6 +1187,412 @@ static void test_tailcall_poke(void)
 	tailcall_poke__destroy(call);
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
@@ -1223,4 +1629,16 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_fentry_entry();
 	if (test__start_subtest("tailcall_poke"))
 		test_tailcall_poke();
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
2.42.1



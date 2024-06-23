Return-Path: <bpf+bounces-32852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C59913CAB
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 18:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3F4B217BC
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522771822F1;
	Sun, 23 Jun 2024 16:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw89mrCa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E3181D04
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159368; cv=none; b=Ntvj90FFRmke6UM7b8BsTnoriYfwC99BKsPKzmmEbMZoZ/+gOZLGjkfcex5xQE1OcWrM4AYF8MlJZzElY7gxPCW+gaS+00xhhDy+j/uEQl3NBBifF4++QlJRIS855E5p8pRdZNrh6tzAIGEuluLQLZxEacXFWSf1rFj2nP1ESNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159368; c=relaxed/simple;
	bh=xaBccPF5N5sZPmkFB4Cwx+3rwAuulD9VRRFKUU3ogRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTD5TlRgxjaffV/USgLYae4qfqVV08N/VmVoeEwSmAhAkXL4cb94TaAM63YhV54M3JPXMukkajn/roBIkifKhqydzZ40WPIhKuXLuw7Y+g3NrcyVM3t8kNCBtuXUu5+f6swUgWN03Rr8m6/9AxsPE0xZiSL0qpeLHqO8mQAqaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw89mrCa; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7067272245aso500004b3a.1
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719159365; x=1719764165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp/mU+znEWy6cwaETO3COQEbDlKg9FMYe1Lw4dGqTnY=;
        b=Fw89mrCa9l1nb4PR/upSyl+4X9D5YRxh2XHxI0Ir4DR5BwthloAXV4PnNvBnIjhr7c
         NdT9ijGMnr0HUlWNbOYsgEfrbWTrwVvZFhGcSvUk4b9l4pI/5QOT9WZHtTrBLQEKm2an
         B/RdZ69XOrbx1Zl9P/D6RK5kTAReOmPUW6LHuMxpuvN37IvQcb6EX4/8QNXMuWPXfmZ4
         ObWc2+dpKGx97dB5/yJ+AeeWgXagaHcDzALYO+f6LCIqfMJgKU8hpJaeB9WwI2g8/1Bb
         CzBfVOPJGFZW2gC2YfArQiw+oTBrWAQVko1tZAcRSJXEWCFLkwFsUGjh3mqWZuKNnUjj
         qteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719159365; x=1719764165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp/mU+znEWy6cwaETO3COQEbDlKg9FMYe1Lw4dGqTnY=;
        b=h8MtYfkgtQw7WBpdJfVZ6916eB3jHc/OPI6jXsDE+OXzRtgAKVjEpE4y4i3fQlh6Cs
         abqlND33K14cIQ0IIxoxVFd11Vm+/YYtItUFuEqnMft7cf6g7ctt0nHRBTnJdWJwGOAD
         2BijY9/ynhUn4NnfAqd79W9NN/IwlQpdjXTu84c2z5pB9t49ciPzEKy9X09LoBEzPNom
         h9HJZT/DDfSyopTA7aRP3tsQv73eTW5NEyJ0x5l++F4vd8fhjvFC+y8y0kE4o4JzOFka
         3D8hpDUozLYBzFr/3is0nOtf2t34RAZ7gWExwYtwr5suO9dMw/RPgNanDCaNzU7RzubO
         JD4g==
X-Gm-Message-State: AOJu0YysLkmdYo233/lH7kZZJiQ23lO6jwh/9ghEQK3H58211qFfHbxu
	VPaIJOHbrbfqcsl5l04fGcEBDZE24jvxshLKrivpfbU5vhbb8+adIL4MCQ==
X-Google-Smtp-Source: AGHT+IGeNpM+PKuWt84K5r5WVwfAaGsKzyh8zF/niROUeRbvdH3mwh2kBwCNtJKE8quv38BGyLIfww==
X-Received: by 2002:a05:6a20:baa2:b0:1b5:d172:91e8 with SMTP id adf61e73a8af0-1bcf7fc20cbmr1591927637.49.1719159364654;
        Sun, 23 Jun 2024 09:16:04 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651309bdbsm4621255b3a.210.2024.06.23.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 09:16:04 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	puranjay@kernel.org,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v5 bpf-next 3/3] selftests/bpf: Add testcases for tailcall hierarchy fixing
Date: Mon, 24 Jun 2024 00:15:28 +0800
Message-ID: <20240623161528.68946-4-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240623161528.68946-1-hffilwlqm@gmail.com>
References: <20240623161528.68946-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some test cases to confirm the tailcall hierarchy issue has been fixed.

On x64, the selftests result is:

cd tools/testing/selftests/bpf && ./test_progs -t tailcalls
327/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
327/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
327/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
327/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
327/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
327/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
327/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
327     tailcalls:OK
Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED

On arm64, the selftests result is:

cd tools/testing/selftests/bpf && ./test_progs -t tailcalls
327/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
327/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
327/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
327/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
327/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
327/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
327/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
327     tailcalls:OK
Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 479 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c |  35 ++
 tools/testing/selftests/bpf/progs/tc_dummy.c  |  12 +
 6 files changed, 661 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_dummy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 59993fc9c0d7e..d67ef079fc79e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1187,6 +1187,471 @@ static void test_tailcall_poke(void)
 	tailcall_poke__destroy(call);
 }
 
+static void test_tailcall_hierarchy_count(const char *which, bool test_fentry,
+					  bool test_fexit,
+					  bool test_fentry_entry)
+{
+	int err, map_fd, prog_fd, main_data_fd, fentry_data_fd, fexit_data_fd, i, val;
+	struct bpf_object *obj = NULL, *fentry_obj = NULL, *fexit_obj = NULL;
+	struct bpf_link *fentry_link = NULL, *fexit_link = NULL;
+	struct bpf_program *prog, *fentry_prog;
+	struct bpf_map *prog_array, *data_map;
+	int fentry_prog_fd;
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
+	if (test_fentry_entry) {
+		fentry_obj = bpf_object__open_file("tailcall_bpf2bpf_hierarchy_fentry.bpf.o",
+						   NULL);
+		if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
+			goto out;
+
+		fentry_prog = bpf_object__find_program_by_name(fentry_obj,
+							       "fentry");
+		if (!ASSERT_OK_PTR(prog, "find fentry prog"))
+			goto out;
+
+		err = bpf_program__set_attach_target(fentry_prog, prog_fd,
+						     "entry");
+		if (!ASSERT_OK(err, "set_attach_target entry"))
+			goto out;
+
+		err = bpf_object__load(fentry_obj);
+		if (!ASSERT_OK(err, "load fentry_obj"))
+			goto out;
+
+		fentry_link = bpf_program__attach_trace(fentry_prog);
+		if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
+			goto out;
+
+		fentry_prog_fd = bpf_program__fd(fentry_prog);
+		if (!ASSERT_GE(fentry_prog_fd, 0, "fentry_prog_fd"))
+			goto out;
+
+		prog_array = bpf_object__find_map_by_name(fentry_obj, "jmp_table");
+		if (!ASSERT_OK_PTR(prog_array, "find jmp_table"))
+			goto out;
+
+		map_fd = bpf_map__fd(prog_array);
+		if (!ASSERT_GE(map_fd, 0, "map_fd"))
+			goto out;
+
+		i = 0;
+		err = bpf_map_update_elem(map_fd, &i, &fentry_prog_fd, BPF_ANY);
+		if (!ASSERT_OK(err, "update jmp_table"))
+			goto out;
+
+		data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
+		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+				  "find data_map"))
+			goto out;
+
+	} else {
+		prog_array = bpf_object__find_map_by_name(obj, "jmp_table");
+		if (!ASSERT_OK_PTR(prog_array, "find jmp_table"))
+			goto out;
+
+		map_fd = bpf_map__fd(prog_array);
+		if (!ASSERT_GE(map_fd, 0, "map_fd"))
+			goto out;
+
+		i = 0;
+		err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+		if (!ASSERT_OK(err, "update jmp_table"))
+			goto out;
+
+		data_map = bpf_object__find_map_by_name(obj, ".bss");
+		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+				  "find data_map"))
+			goto out;
+	}
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
+				      false, false, false);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_fentry checks that the count value of the
+ * tail call limit enforcement matches with expectations when tailcalls are
+ * preceded with two bpf2bpf calls, and the two subprogs are traced by fentry.
+ */
+static void test_tailcall_bpf2bpf_hierarchy_fentry(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      true, false, false);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_fexit checks that the count value of the tail
+ * call limit enforcement matches with expectations when tailcalls are preceded
+ * with two bpf2bpf calls, and the two subprogs are traced by fexit.
+ */
+static void test_tailcall_bpf2bpf_hierarchy_fexit(void)
+{
+	test_tailcall_hierarchy_count("tailcall_bpf2bpf_hierarchy1.bpf.o",
+				      false, true, false);
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
+				      true, true, false);
+}
+
+/* test_tailcall_bpf2bpf_hierarchy_fentry_entry checks that the count value of
+ * the tail call limit enforcement matches with expectations when tailcalls are
+ * preceded with two bpf2bpf calls in fentry.
+ */
+static void test_tailcall_bpf2bpf_hierarchy_fentry_entry(void)
+{
+	test_tailcall_hierarchy_count("tc_dummy.bpf.o", false, false, true);
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
@@ -1223,4 +1688,18 @@ void test_tailcalls(void)
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
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_fentry_entry"))
+		test_tailcall_bpf2bpf_hierarchy_fentry_entry();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_2"))
+		test_tailcall_bpf2bpf_hierarchy_2();
+	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_3"))
+		test_tailcall_bpf2bpf_hierarchy_3();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
new file mode 100644
index 0000000000000..327ca395e8601
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
+	int ret = 1;
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
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
new file mode 100644
index 0000000000000..c87f9ca982d3e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
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
+int subprog_tail(void *ctx)
+{
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
+
+SEC("fentry/dummy")
+int BPF_PROG(fentry, struct sk_buff *skb)
+{
+	count++;
+	subprog_tail(ctx);
+	subprog_tail(ctx);
+
+	return 0;
+}
+
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tc_dummy.c b/tools/testing/selftests/bpf/progs/tc_dummy.c
new file mode 100644
index 0000000000000..69a3d0dc87879
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tc_dummy.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	return 1;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.44.0



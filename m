Return-Path: <bpf+bounces-34774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E109309F4
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 14:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B001F2175C
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 12:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25573469;
	Sun, 14 Jul 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7+7cEIp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79D21A0B
	for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960768; cv=none; b=HbN1AdA8jTFgjbcQoBC6AMc0VWhPw5Hify2qs5kQnR8KTV9PpZbfR9zs7ARIg/i1u1SFJEgLCtyScCkS/vkPI13/byO7ulWc4WT21S4ud9K1lsPKTKtHmxo9i9cS9K8sl7Amz6j7wxxmAMZQ6x7EoZhTwrg/h2JdynaP/LOLiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960768; c=relaxed/simple;
	bh=BPOtyMYzaZgsuYh0RUH8Q7Db6ZU9DfDYEs2qviCEZqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWU2YqCld683i2v1iso/CVgJ9onfcb7gvvKiLYYPyEBhovuvzVyOT29JeyxcTGnwTmI0jaMScitvpCdQHRbvKJzKYjx7QVl2ImdODbNu5ek/PT+u2lcr0aL/yE+timu3v9gqirQw/Xeeh1Ed7CUrWm1zAAvckkc/FgbneNI61r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7+7cEIp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so2137876a12.2
        for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960765; x=1721565565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj4uHqI8x+dZSCOF38s8hEBRc0/odK7tZI4FIzhi8MY=;
        b=f7+7cEIpGTLSJvRVly4nYpNDwXNtC3R0pdPvTFj7yAJgb4SRWmFpneD362eBM8MG73
         M0eHfdN6ooWIEXekKWi3JXHSBTdTtjtJsjsgtF132hGT3Av0ELTRUdC40vGtDh6bFJQS
         ZF+fCy661L+9jJP21H7Hpw9UdxvradE3VKjDQNql9oFz9XUMYiIoFTQee6HEx5sYF1Lk
         w+De6npqAq44D81na4iAKzPvlxq3TxRar6E0BVW2puQvdKCOqm8bvSaWRHjWSgKlSF/4
         9YQtoCly6a45LRwhFGAF1fUt4p5p7nEfTDYqYQ2XBGH1MNOGTfuSRWxD2pa0Mofob/cn
         drQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960765; x=1721565565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj4uHqI8x+dZSCOF38s8hEBRc0/odK7tZI4FIzhi8MY=;
        b=XNUMRyWDQdwr7T7cEAimkZ9ks8jwUUhrP2i3IHuNHAeuRDZsdsFB/dDiVoQKNNAL1Q
         7krxYIVc0ciKq9jZ2p3yqGBAkZBuLRnF3uBkx/3nH1NApjWqi/lPVeFJsm734FT6nnc2
         +FCv8Qq6NPfcFfd3hXcVpLdQo0EIN/l0JGhqkANEn9B3LJP4G/TlBpSgq/+iJyw1QPaN
         VdXle6++m6SQCEy8p14AKe84iQyl5BXGIwwKs2Ku/L1+FxQrj+989dCkLCydHBWJB8rX
         OzKU2n1Dhl3DNxOajxhP+i3VDDjQrhXgADTUjxpfvbuSuJfxgprIDlGmzeAIE3IkRpB8
         s5sQ==
X-Gm-Message-State: AOJu0Yy8X1DMCLSHTM5tbaE5Ssu0R7e6YmTFrT8l8R16s8XqqfzXmdxr
	KkewHASMMwZoAoB8VIY/UvYCapJiLkIyOASGzr0PACwn2UIt7J44xyyvpw==
X-Google-Smtp-Source: AGHT+IF+IZw6j8an7RBVJQnbNDfzxtPE+NSkVFfP2BKdamnAInHLT/7Sy8U2ToJt4aXH45tRryJd3Q==
X-Received: by 2002:a05:6a20:e188:b0:1c3:b295:47d with SMTP id adf61e73a8af0-1c3b29504d7mr9363506637.28.1720960765235;
        Sun, 14 Jul 2024 05:39:25 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4e4edsm22994635ad.266.2024.07.14.05.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:39:24 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	eddyz87@gmail.com,
	puranjay@kernel.org,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v6 bpf-next 3/3] selftests/bpf: Add testcases for tailcall hierarchy fixing
Date: Sun, 14 Jul 2024 20:39:02 +0800
Message-ID: <20240714123902.32305-4-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240714123902.32305-1-hffilwlqm@gmail.com>
References: <20240714123902.32305-1-hffilwlqm@gmail.com>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 320 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  70 ++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  62 ++++
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c |  35 ++
 tools/testing/selftests/bpf/progs/tc_dummy.c  |  12 +
 6 files changed, 533 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_dummy.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 59993fc9c0d7e..e01fabb8cc415 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -3,6 +3,8 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "tailcall_poke.skel.h"
+#include "tailcall_bpf2bpf_hierarchy2.skel.h"
+#include "tailcall_bpf2bpf_hierarchy3.skel.h"
 
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
@@ -1187,6 +1189,312 @@ static void test_tailcall_poke(void)
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
+	RUN_TESTS(tailcall_bpf2bpf_hierarchy2);
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
+	RUN_TESTS(tailcall_bpf2bpf_hierarchy3);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1223,4 +1531,16 @@ void test_tailcalls(void)
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
+	test_tailcall_bpf2bpf_hierarchy_2();
+	test_tailcall_bpf2bpf_hierarchy_3();
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
index 0000000000000..37604b0b97aff
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int classifier_0(struct __sk_buff *skb);
+int classifier_1(struct __sk_buff *skb);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+		[1] = (void *) &classifier_1,
+	},
+};
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
+__auxiliary
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
+__auxiliary
+SEC("tc")
+int classifier_1(struct __sk_buff *skb)
+{
+	count1++;
+	subprog_tail1(skb);
+	return 0;
+}
+
+__success
+__retval(33)
+SEC("tc")
+int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
+{
+	volatile int ret = 0;
+
+	subprog_tail0(skb);
+	subprog_tail1(skb);
+
+	asm volatile (""::"r+"(ret));
+	return (count1 << 16) | count0;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
new file mode 100644
index 0000000000000..0cdbb781fcbc5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int classifier_0(struct __sk_buff *skb);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table0 SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+	},
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table1 SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+	},
+};
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
+__auxiliary
+SEC("tc")
+int classifier_0(struct __sk_buff *skb)
+{
+	count++;
+	subprog_tail(skb, &jmp_table0);
+	subprog_tail(skb, &jmp_table1);
+	return count;
+}
+
+__success
+__retval(33)
+SEC("tc")
+int tailcall_bpf2bpf_hierarchy_3(struct __sk_buff *skb)
+{
+	volatile int ret = 0;
+
+	bpf_tail_call_static(skb, &jmp_table0, 0);
+
+	asm volatile (""::"r+"(ret));
+	return ret;
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



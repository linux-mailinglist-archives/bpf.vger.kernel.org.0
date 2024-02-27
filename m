Return-Path: <bpf+bounces-22755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A187A868584
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 02:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0781F23956
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1474C7C;
	Tue, 27 Feb 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS+qtaTf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456864C92
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995887; cv=none; b=c8sNvuU2Hd0q87FqoC2ODE45fdQlwTLMH7CpOJWh5SIuLUDEjpMztB8/QZ4wyc7uLGU6VoKV4Vyd0bV06jCUFrKxhjeXcqcWye7oSCajQ2HyO9eoP9q6I/wMFYvOsCs/C6i5DeCtV/WRxBlK99g3y+ESVL1W62Q8zaLOwUbGFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995887; c=relaxed/simple;
	bh=kn6v7KWUs2y1IgJecF+yvFbM27olTQ2TFVTijy4UfYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtXCOfRllR03QjO+ShJoXNXWc+8KT71X/RKfLBX8M/3ixkQVa0lQ1MjkiujQ0sAh5j0TR+/A7KglhwPJ8UaA3ZkWQVhg2KrJCIWMs+YcUFw9G1uTDHiAYGo1YjJkpeh8ts3BoR9fErNw6VRJUWnnpTakEYcYaqwfgRRBsstVUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS+qtaTf; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-608e0b87594so21894857b3.1
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 17:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995885; x=1709600685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD8m4gd8/Bnjn5MvoeiCe8GexY6YWfPcvCxDml5btb8=;
        b=OS+qtaTfQWXj8iicZlrInQQeGQrOS2fCP8p23az2uZCfyzd4+Jol+T3R4ae3tU98Ax
         o7B21bvgHK49ToY3L1V25e74DW0qTnYhp3pTrzIRdeb2uuP6UVEso6Cimx3H8nyhgFHA
         k5ufo05G36wXMQ5Hkvd/ERUR5y/QH7GtHT/Qlcf1Y+cVyx3RCda/nxRhMWp/KtRPHQnV
         jIsSyLJ9AP+H3oW9tnsFDSGq1wEVxq2E15NcY5Kxb5EnuyRQC/8RXH49CKV7xSNSbkli
         Lg4TZZaUh4UZBm9RqRRaeHn03tY8xvQv+ZY6cuohRh/s5LXSKlQgHLMUO5lFwUhCzGIW
         R+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995885; x=1709600685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD8m4gd8/Bnjn5MvoeiCe8GexY6YWfPcvCxDml5btb8=;
        b=vURdRyOUtzIV02uZP9HSpWMz7A10fPLVMNIlisAnyU5dxLMY2sd+PSvnsiVQpglWj4
         LkzHt0nxaDcTEmGFZqbu6TeLHFREA0nEZ+2Z9/hSMgsFKt6xZZ+GCsaYdIecselJl/Bh
         JlL86A2iQEstXKvH0Dmga75/k17pMj+LDtP+RHZ/dxlWdApaGtRoqzxsZ/BIEDAC0UHs
         4K0GtxQ9A5goGE/jzbpPhecn5vn5nIsq7DjRHOA3XGC7bd3E4ss4xIipAlyl58L4snyG
         sjaOK73/ON3+Vy4EO61r7FC/fCHwn6m0GyxFEbq93TrbFRDId+Q4E52nWYV6utsAHL93
         tneg==
X-Gm-Message-State: AOJu0YyfkVkkQqYktKHXRDhWGUOjdCzdRVoZRfmLq8hauyg0uvZwppfJ
	xGtjPddr543Qdh6R1QuepcPBegBNR4JjBDe1H6VT01fEOPsfvVqlH5+bac/f
X-Google-Smtp-Source: AGHT+IFYikZHYDXuA9KcsDiaYYUsMQU6J2Dq3bZMQaMZYyPumjT3RpyagdSas9ynXzN6L8oBv9z9YA==
X-Received: by 2002:a81:5751:0:b0:608:8f31:244f with SMTP id l78-20020a815751000000b006088f31244fmr669571ywb.51.1708995884994;
        Mon, 26 Feb 2024 17:04:44 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5f7:55e:ea3a:9865])
        by smtp.gmail.com with ESMTPSA id l141-20020a0de293000000b00607f8df2097sm1458818ywe.104.2024.02.26.17.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:04:44 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: Test if shadow types work correctly.
Date: Mon, 26 Feb 2024 17:04:32 -0800
Message-Id: <20240227010432.714127-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227010432.714127-1-thinker.li@gmail.com>
References: <20240227010432.714127-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the values of fields, including scalar types and function pointers,
and check if the struct_ops map works as expected.

The test changes the field "test_2" of "testmod_1" from the pointer to
test_2() to pointer to test_3() and the field "data" to 13. The function
test_2() and test_3() both compute a new value for "test_2_result", but in
different way. By checking the value of "test_2_result", it ensures the
struct_ops map works as expected with changes through shadow types.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 11 ++++++++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  8 ++++++++
 .../bpf/prog_tests/test_struct_ops_module.c   | 19 +++++++++++++++----
 .../selftests/bpf/progs/struct_ops_module.c   |  8 ++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 66787e99ba1b..098ddd067224 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -539,6 +539,15 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
 {
+	if (member->offset == offsetof(struct bpf_testmod_ops, data) * 8) {
+		/* For data fields, this function has to copy it and return
+		 * 1 to indicate that the data has been handled by the
+		 * struct_ops type, or the verifier will reject the map if
+		 * the value of the data field is not zero.
+		 */
+		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
+		return 1;
+	}
 	return 0;
 }
 
@@ -559,7 +568,7 @@ static int bpf_dummy_reg(void *kdata)
 	 * initialized, so we need to check for NULL.
 	 */
 	if (ops->test_2)
-		ops->test_2(4, 3);
+		ops->test_2(4, ops->data);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index c3b0cf788f9f..971458acfac3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,14 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+
+	/* The following fields are used to test shadow copies. */
+	char onebyte;
+	struct {
+		int a;
+		int b;
+	} unsupported;
+	int data;
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 8d833f0c7580..7d6facf46ebb 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -32,17 +32,23 @@ static void check_map_info(struct bpf_map_info *info)
 
 static void test_struct_ops_load(void)
 {
-	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct struct_ops_module *skel;
 	struct bpf_map_info info = {};
 	struct bpf_link *link;
 	int err;
 	u32 len;
 
-	skel = struct_ops_module__open_opts(&opts);
+	skel = struct_ops_module__open();
 	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
 		return;
 
+	skel->struct_ops.testmod_1->data = 13;
+	skel->struct_ops.testmod_1->test_2 = skel->progs.test_3;
+	/* Since test_2() is not being used, it should be disabled from
+	 * auto-loading, or it will fail to load.
+	 */
+	bpf_program__set_autoload(skel->progs.test_2, false);
+
 	err = struct_ops_module__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_module_load"))
 		goto cleanup;
@@ -56,8 +62,13 @@ static void test_struct_ops_load(void)
 	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
 	ASSERT_OK_PTR(link, "attach_test_mod_1");
 
-	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
-	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
+	/* test_3() will be called from bpf_dummy_reg() in bpf_testmod.c
+	 *
+	 * In bpf_testmod.c it will pass 4 and 13 (the value of data) to
+	 * .test_2.  So, the value of test_2_result should be 20 (4 + 13 +
+	 * 3).
+	 */
+	ASSERT_EQ(skel->bss->test_2_result, 20, "check_shadow_variables");
 
 	bpf_link__destroy(link);
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index b78746b3cef3..25952fa09348 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -21,9 +21,17 @@ void BPF_PROG(test_2, int a, int b)
 	test_2_result = a + b;
 }
 
+SEC("struct_ops/test_3")
+int BPF_PROG(test_3, int a, int b)
+{
+	test_2_result = a + b + 3;
+	return a + b + 3;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops testmod_1 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2,
+	.data = 0x1,
 };
 
-- 
2.34.1



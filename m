Return-Path: <bpf+bounces-29026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0BA8BF64C
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750F01F2385C
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 06:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3F199C7;
	Wed,  8 May 2024 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGAarL3+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB798846B
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149955; cv=none; b=Oq1/cy3reK8Kkuil5fPDrygOZjwdMeBn6hCrFvUywdSjYTwHYVlIKljoD79V07Af/4Ze2ozfBIik4Kgvs8LkVu7cUNNZo2sgwgS7WqfNER6YrjxhVsil2ep3ZuH3so07E0VapKar9/cBodxP1JYO27gteSkLU7XeJQQzLUAtH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149955; c=relaxed/simple;
	bh=184HSHS8K1pDQhxH155teo7Hn+PjBBhq6NMvMs9ANKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgYgBZsoM/Yce+y1FmbBUDkRDOocEGrqlK6j1kGz+bMjh3eWQ2pg4UZuZLxj8AY7jOpbKWZE9mQqwK/07dRruO9NYn6SSxyYIJev3B8MuzUq8lJbKeF3eQnc/yQajo0IoabWG/rKGzc/6RxLOAG1kNG3MGmwFMP6IIjVr5It9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGAarL3+; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c70d8bb618so2010186b6e.2
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 23:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715149953; x=1715754753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWwzY90xebc6YceOSeyo6ErhBa/XYlP1DhvcruTgZXw=;
        b=eGAarL3+mq/fBTGvohXjo1rZP37BCfr8syPIZyh3Aeam9CRIoE8ztrmDGlzmIncaqI
         glxSXsE0+zX4eeK1eR/Br1OLVp6XRvzuKTTnVabhfXufMZNI5HSwvylWvEAMPnGbaYLV
         bgbnfXeFunCbegupW+O2djJvMGcjYDk8pfitG60BekbS7ehirikNX/KnWQ7xRl20dkuf
         lJvv9pKgrTS7kxNb2ok9zPmJmxDkafRzllZuswimDcE24TZB6PK6JNlZykfKB0Wy7iDv
         p4Qz4wP+sfjkLe6M07W6sSqfSWNjMC7B9VbTcMKK4824UHWSOm6UA+QKVoh0lyPuE0TS
         bL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715149953; x=1715754753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWwzY90xebc6YceOSeyo6ErhBa/XYlP1DhvcruTgZXw=;
        b=jIfJx40GwrfueAHst1UUTz0joy8/6+pI0A93wGlQG5ckrnScQvuiml3W+RTD/FXx6U
         qbs0qs6ipJFCH20/yeRzcZWprgYsS5VWCjQLGPLzl/HKmdk6gAgFESqVEbOJZLv+fI6d
         ANRQHoowxDW2+jxFdMlU0wniMAYgxmU/MVYjbjJD7d16/z8ll++SKa0xt4Pxrcnyv2fy
         K11spssWHqxYX6nfHP2wfqFgDqIKr7mF2kJIOMfeOvHGgtH3vDytYV5kBcxbTwxrwum8
         8rRduSsOhU0eLRr6OQrqUlO94JygM+dHdm/HR4hsablfKfoS69qnNPQ9ZIL91HLSitsv
         n6WA==
X-Gm-Message-State: AOJu0Yx4o9UNki4PdijQFwh3lXSM6o82LZBaoYLHTLirFYNGwWrnA+vv
	yIcefSijdCf+98WQUwsa2r5k6jJ9fXptizrzeOFeQYtdfBlIRiWBM2W3iQ==
X-Google-Smtp-Source: AGHT+IEqZGeAJG42DNrLfY70WxDB2l2QXn8waka6PjhOv7YXke/0n9ihHvq6qiEawoPT6Fa27zX5Kg==
X-Received: by 2002:aca:1916:0:b0:3c8:69b6:9b78 with SMTP id 5614622812f47-3c9852cbe30mr2004580b6e.29.1715149952780;
        Tue, 07 May 2024 23:32:32 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:28e:823a:cbf2:fea6])
        by smtp.gmail.com with ESMTPSA id z22-20020a056808029600b003c9729ac86dsm841371oic.11.2024.05.07.23.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 23:32:32 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 8/9] selftests/bpf: Test global bpf_rb_root arrays and fields in nested struct types.
Date: Tue,  7 May 2024 23:32:17 -0700
Message-Id: <20240508063218.2806447-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508063218.2806447-1-thinker.li@gmail.com>
References: <20240508063218.2806447-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure global arrays of bpf_rb_root and fields of bpf_rb_root in nested
struct types work correctly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/rbtree.c | 47 +++++++++++
 tools/testing/selftests/bpf/progs/rbtree.c    | 77 +++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree.c b/tools/testing/selftests/bpf/prog_tests/rbtree.c
index e9300c96607d..9818f06c97c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/rbtree.c
+++ b/tools/testing/selftests/bpf/prog_tests/rbtree.c
@@ -31,6 +31,28 @@ static void test_rbtree_add_nodes(void)
 	rbtree__destroy(skel);
 }
 
+static void test_rbtree_add_nodes_nested(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .repeat = 1,
+	);
+	struct rbtree *skel;
+	int ret;
+
+	skel = rbtree__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rbtree__open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_add_nodes_nested), &opts);
+	ASSERT_OK(ret, "rbtree_add_nodes_nested run");
+	ASSERT_OK(opts.retval, "rbtree_add_nodes_nested retval");
+	ASSERT_EQ(skel->data->less_callback_ran, 1, "rbtree_add_nodes_nested less_callback_ran");
+
+	rbtree__destroy(skel);
+}
+
 static void test_rbtree_add_and_remove(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
@@ -53,6 +75,27 @@ static void test_rbtree_add_and_remove(void)
 	rbtree__destroy(skel);
 }
 
+static void test_rbtree_add_and_remove_array(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .repeat = 1,
+	);
+	struct rbtree *skel;
+	int ret;
+
+	skel = rbtree__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rbtree__open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.rbtree_add_and_remove_array), &opts);
+	ASSERT_OK(ret, "rbtree_add_and_remove_array");
+	ASSERT_OK(opts.retval, "rbtree_add_and_remove_array retval");
+
+	rbtree__destroy(skel);
+}
+
 static void test_rbtree_first_and_remove(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
@@ -104,8 +147,12 @@ void test_rbtree_success(void)
 {
 	if (test__start_subtest("rbtree_add_nodes"))
 		test_rbtree_add_nodes();
+	if (test__start_subtest("rbtree_add_nodes_nested"))
+		test_rbtree_add_nodes_nested();
 	if (test__start_subtest("rbtree_add_and_remove"))
 		test_rbtree_add_and_remove();
+	if (test__start_subtest("rbtree_add_and_remove_array"))
+		test_rbtree_add_and_remove_array();
 	if (test__start_subtest("rbtree_first_and_remove"))
 		test_rbtree_first_and_remove();
 	if (test__start_subtest("rbtree_api_release_aliasing"))
diff --git a/tools/testing/selftests/bpf/progs/rbtree.c b/tools/testing/selftests/bpf/progs/rbtree.c
index b09f4fffe57c..a3620c15c136 100644
--- a/tools/testing/selftests/bpf/progs/rbtree.c
+++ b/tools/testing/selftests/bpf/progs/rbtree.c
@@ -13,6 +13,15 @@ struct node_data {
 	struct bpf_rb_node node;
 };
 
+struct root_nested_inner {
+	struct bpf_spin_lock glock;
+	struct bpf_rb_root root __contains(node_data, node);
+};
+
+struct root_nested {
+	struct root_nested_inner inner;
+};
+
 long less_callback_ran = -1;
 long removed_key = -1;
 long first_data[2] = {-1, -1};
@@ -20,6 +29,9 @@ long first_data[2] = {-1, -1};
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
 private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_rb_root groot __contains(node_data, node);
+private(A) struct bpf_rb_root groot_array[2] __contains(node_data, node);
+private(A) struct bpf_rb_root groot_array_one[1] __contains(node_data, node);
+private(B) struct root_nested groot_nested;
 
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
@@ -71,6 +83,12 @@ long rbtree_add_nodes(void *ctx)
 	return __add_three(&groot, &glock);
 }
 
+SEC("tc")
+long rbtree_add_nodes_nested(void *ctx)
+{
+	return __add_three(&groot_nested.inner.root, &groot_nested.inner.glock);
+}
+
 SEC("tc")
 long rbtree_add_and_remove(void *ctx)
 {
@@ -109,6 +127,65 @@ long rbtree_add_and_remove(void *ctx)
 	return 1;
 }
 
+SEC("tc")
+long rbtree_add_and_remove_array(void *ctx)
+{
+	struct bpf_rb_node *res1 = NULL, *res2 = NULL, *res3 = NULL;
+	struct node_data *nodes[3][2] = {{NULL, NULL}, {NULL, NULL}, {NULL, NULL}};
+	struct node_data *n;
+	long k1 = -1, k2 = -1, k3 = -1;
+	int i, j;
+
+	for (i = 0; i < 3; i++) {
+		for (j = 0; j < 2; j++) {
+			nodes[i][j] = bpf_obj_new(typeof(*nodes[i][j]));
+			if (!nodes[i][j])
+				goto err_out;
+			nodes[i][j]->key = i * 2 + j;
+		}
+	}
+
+	bpf_spin_lock(&glock);
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			bpf_rbtree_add(&groot_array[i], &nodes[i][j]->node, less);
+	for (j = 0; j < 2; j++)
+		bpf_rbtree_add(&groot_array_one[0], &nodes[2][j]->node, less);
+	res1 = bpf_rbtree_remove(&groot_array[0], &nodes[0][0]->node);
+	res2 = bpf_rbtree_remove(&groot_array[1], &nodes[1][0]->node);
+	res3 = bpf_rbtree_remove(&groot_array_one[0], &nodes[2][0]->node);
+	bpf_spin_unlock(&glock);
+
+	if (res1) {
+		n = container_of(res1, struct node_data, node);
+		k1 = n->key;
+		bpf_obj_drop(n);
+	}
+	if (res2) {
+		n = container_of(res2, struct node_data, node);
+		k2 = n->key;
+		bpf_obj_drop(n);
+	}
+	if (res3) {
+		n = container_of(res3, struct node_data, node);
+		k3 = n->key;
+		bpf_obj_drop(n);
+	}
+	if (k1 != 0 || k2 != 2 || k3 != 4)
+		return 2;
+
+	return 0;
+
+err_out:
+	for (i = 0; i < 3; i++) {
+		for (j = 0; j < 2; j++) {
+			if (nodes[i][j])
+				bpf_obj_drop(nodes[i][j]);
+		}
+	}
+	return 1;
+}
+
 SEC("tc")
 long rbtree_first_and_remove(void *ctx)
 {
-- 
2.34.1



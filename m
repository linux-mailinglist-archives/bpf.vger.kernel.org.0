Return-Path: <bpf+bounces-29429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC218C1BF1
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 03:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E98628440B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC3113AA5E;
	Fri, 10 May 2024 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baLtnvEr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB013AA54
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715303606; cv=none; b=plEIOkBIn1FL3gfNLu9seCNMp+cpbc9Q12Zfn7OaWLRC008YS2dWUCBtqaW5v0YtXltz1T3BhD+jAZzQjXhuWbVUX5w1ecRASzOAgITB6VTB7puCaOV37yD/vcyJjp49S1dNbvdGcXg5sozAfrU/jPlUu11SeWytHnOdK4H8dic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715303606; c=relaxed/simple;
	bh=184HSHS8K1pDQhxH155teo7Hn+PjBBhq6NMvMs9ANKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCvTOEXO0bx0Z6wOB/D1hIs4SP47nvoUs3QyHxiXRkJwGdOPL/EGRxt1QiqrnBsMG6KT3hJS/QvvFZE2uO2A6Xb6Ud3eGymablD8rG9NvFoW1TQecWBN61/vOMZt6FM7ZTKEndltfAuRdmNJfp90i73o0ivpeiWHgffZVx4KzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baLtnvEr; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22e6b61d652so830538fac.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 18:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715303603; x=1715908403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWwzY90xebc6YceOSeyo6ErhBa/XYlP1DhvcruTgZXw=;
        b=baLtnvErRVNdoe0m0WHOSCzEy/68LsMXkKEIFBWoT/73+nTVcXPsorCCICETzsctAv
         U4tUKcn25KkzWUnRRA6f4eEUjTK32p4YNcIc4vuYDUf5X+rtwDYSuR30qSxGO0dLlr87
         f2MbFfP2mGufQUBnmT8lB8n0YrR8CYOWUAcvJe2DWiVfWKQLyXj4dRleGa8cLyTqcJyQ
         6Rn4rS+TNFMwLPkQJinRv7WKx+AEoqaAyFEdN3mf+HYL0Rbw+woSlXsOdUX1J7OedVk1
         3zSl89JN68sm9/n/TqpDhmDMwd+exvBBeSK7hi7aOi8SRBJusGqsXjg1QQ/S28gZc5Qj
         05vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715303603; x=1715908403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWwzY90xebc6YceOSeyo6ErhBa/XYlP1DhvcruTgZXw=;
        b=V0JV3MSL0Uz9aDjVAUsDOqBlSactycNM/wMFqURGJOp+9og73FoLLKgm4gThbl90CE
         P2ZzkNEz+0AJRL5r+Gy531eVe271On2qWKA+VKwd4r3cV1Xp8EXwjAqAIYpGE+LoAQSf
         zsSRlV3BCbw2RyaqlUMrqK3dO5u75FcaxTgToSomj4PreUlzScXCDVvgeRRh2Rbcr9Al
         d99mNnTdHJW2RVSuJK9rU7P5b2GEUR/vXstrOMt3TZ1W6UfIwiPrl8rQxA6OoKNGoZSX
         d+BM+yhccoUAddUEB8TseKzQXi3jSjCyyEdtpOOVeclULnMSS7ddqL55wtl32uXjnFhv
         Ao4Q==
X-Gm-Message-State: AOJu0Yzq7hkNnzraMOrIy0bhTgTRCfksNZXGuwryRBon8Y0bIIeP4M4y
	crtZxqm5Z9vspp4SP6Q7G9rNSxnIKFXah+ZwezYevfj1IA1FqScnDCoLmQ==
X-Google-Smtp-Source: AGHT+IGNEaUqfIpH6yLWtWhfLulMJc7Cs7w5uNdPdjbj7ui5ocypNOXn2KgxVrsIkRfiYBC64IXAsQ==
X-Received: by 2002:a05:6870:648f:b0:233:d4b3:9b30 with SMTP id 586e51a60fabf-24172a2371dmr1635109fac.1.1715303603078;
        Thu, 09 May 2024 18:13:23 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e01a8b23sm476874a34.6.2024.05.09.18.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:13:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 8/9] selftests/bpf: Test global bpf_rb_root arrays and fields in nested struct types.
Date: Thu,  9 May 2024 18:13:11 -0700
Message-Id: <20240510011312.1488046-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510011312.1488046-1-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
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



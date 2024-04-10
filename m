Return-Path: <bpf+bounces-26346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870989E707
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A71C210D6
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15253A6;
	Wed, 10 Apr 2024 00:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZQmNVu7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EA4A1B
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709727; cv=none; b=tlyXDizTOsEjoCAQdWZbBbQXhQQ1go14z0zSk+mifNMQfnZHIxcZmwzt+GyiFPgMURiZ6orR7V0SlwL5QDAFBg4IuIuRrCZyaX/FUwjKYp/UCng1HXGPPyCtlqCbUDI8VPIFnSjmbXEpMYtBzidvBCxUByvmghFGVNTFrJBadjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709727; c=relaxed/simple;
	bh=XCOrX2UCM/jR2fC0SWffLjWE7UO0dOeu2CDXbUUZo2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eo/JMrMQ9ethpewu8XLvtGVBzRrk8u8C16oqWbrpB7Nk62AHxKxE6Fd/vbIc4oR65jWBibte3IkALkQl/aoQ7KHj4cQW1oIUYHSny2N/wLhgdt2lOzhmQshAZh6amE4lJZT99Ns2ST9WfG1+S+sOdupAUGM2Xc1NHxKTqS8eP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZQmNVu7; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ea26393116so875946a34.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709724; x=1713314524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f51USvNE8y445K4bfiKnnRxSA5H877NAgdsZGb73FMA=;
        b=gZQmNVu7mo4PX3op5KYgaqLLfrikhqjX5VdfrlvmJs6LDNN8qXU9ENvLGz6tO2pLEN
         ML7nM+FFFaHSOl1QHSMc3xmGaPiQL4F4ywYyOjwMXphKW7hHjLtnHoF+R4WZmdGLV+ZP
         QqxTHvdB7wne0s+ZZzxzauJKlMZ44r/rCvkrnd9mUH/kxNDYkj00WnEss8MIprXdxdGb
         g0huYWc40DwQ6M0s8bXkTQqTgkpvvVdiKZDyTuIGuMMsG67ExzBXIaFckrRRP+XgXhla
         ocheicN2lc/zWP0MJ+yNyS1gjiaFCT2VdxkNiDPGdPVOQSRhumOaCHddIkYvd2qfCpFj
         kSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709724; x=1713314524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f51USvNE8y445K4bfiKnnRxSA5H877NAgdsZGb73FMA=;
        b=e4qAjy+fmECyXE5kkTDlVxcDHLLlLIZdjrH6AqVM1mScPpO3pJ85U4f0m0V6ytTpnE
         1DgnDtAOwkz0551WjvmdOiPrSoqDf0jyEFTQ+35CNGSUjyEBr6/UEL7nEdLxvRIJUpay
         gs0jR7Aw29nfz6r2GWXLWpbC9Lnq3FAdwu1tWveU/fxE7SexBpZ5NUF7i16uzxetMk5e
         +RBei+8J/u+E83VkN7d/l38MFJfYNWwoQp1+BDDCByH4za+ZA9anS9dmDQj2+ny2BR73
         R0YsugJfxFrEMNlNpumz8zlY8uDj3GaJLmSr3G7SUiNxnSEzqvHOpzfpDMtBSPjigEgK
         uUKA==
X-Gm-Message-State: AOJu0YzV24WL1AJSSltzS0VEOPDU777GYrPVeM48NUdYrJR4ZAeBN1Zl
	2Rig82Kva9KyH4e/zdXyqYaPR+UNr1GoY0YlitYhZQ3vRENYb6JlOwOdTMep
X-Google-Smtp-Source: AGHT+IHxDT9CBUimrEpuY+ifeQ7oQlRowvqzccIPLM3eGPf8KAWS/kJRFqbR1bo7rBc8iqWe6c3zxA==
X-Received: by 2002:a05:6808:18f:b0:3c5:fcfa:c268 with SMTP id w15-20020a056808018f00b003c5fcfac268mr1241716oic.29.1712709724438;
        Tue, 09 Apr 2024 17:42:04 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:42:04 -0700 (PDT)
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
Subject: [PATCH bpf-next 10/11] selftests/bpf: Test global bpf_rb_root arrays.
Date: Tue,  9 Apr 2024 17:41:49 -0700
Message-Id: <20240410004150.2917641-11-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure global arrays of bpf_rb_root work correctly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/rbtree.c | 23 +++++++
 tools/testing/selftests/bpf/progs/rbtree.c    | 63 +++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rbtree.c b/tools/testing/selftests/bpf/prog_tests/rbtree.c
index e9300c96607d..399d61b8a9a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/rbtree.c
+++ b/tools/testing/selftests/bpf/prog_tests/rbtree.c
@@ -53,6 +53,27 @@ static void test_rbtree_add_and_remove(void)
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
@@ -106,6 +127,8 @@ void test_rbtree_success(void)
 		test_rbtree_add_nodes();
 	if (test__start_subtest("rbtree_add_and_remove"))
 		test_rbtree_add_and_remove();
+	if (test__start_subtest("rbtree_add_and_remove_array"))
+		test_rbtree_add_and_remove_array();
 	if (test__start_subtest("rbtree_first_and_remove"))
 		test_rbtree_first_and_remove();
 	if (test__start_subtest("rbtree_api_release_aliasing"))
diff --git a/tools/testing/selftests/bpf/progs/rbtree.c b/tools/testing/selftests/bpf/progs/rbtree.c
index b09f4fffe57c..6bf7285944d6 100644
--- a/tools/testing/selftests/bpf/progs/rbtree.c
+++ b/tools/testing/selftests/bpf/progs/rbtree.c
@@ -20,6 +20,8 @@ long first_data[2] = {-1, -1};
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
 private(A) struct bpf_spin_lock glock;
 private(A) struct bpf_rb_root groot __contains(node_data, node);
+private(A) struct bpf_rb_root groot_array[2] __contains(node_data, node);
+private(A) struct bpf_rb_root groot_array_one[1] __contains(node_data, node);
 
 static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 {
@@ -109,6 +111,67 @@ long rbtree_add_and_remove(void *ctx)
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
+	if (k1 != 0 || k2 != 2)
+		return 2;
+	if (k3 != 4)
+		return 3;
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



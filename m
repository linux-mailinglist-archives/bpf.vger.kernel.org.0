Return-Path: <bpf+bounces-26668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8262A8A37AA
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE341F22D3A
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A64915533E;
	Fri, 12 Apr 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYrLXuvv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECB155337
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956111; cv=none; b=IGQpwcUKkzNVggma414Q5tdzkgu9omMN5vyEGlnFFtu/ISZzDWL6zb7i+XGqLG4PqJ7zuygpsnNfk/HEYBay1MTxQvBGuiAy06+6t5CQL4SHChJmQP53KYad232Uz6bCpEnwKGK6aUuP8QJGIMWm32wYAqT6Pe0pyxNtoM6Rplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956111; c=relaxed/simple;
	bh=XCOrX2UCM/jR2fC0SWffLjWE7UO0dOeu2CDXbUUZo2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5FFKgf933LxeGBZ4DCzZMizfICA5CUS+aw6aEdFhECo9HjoHdPgb5wmou3ruGKJXwDXYXyA7GIyrlK5sjZtrsCGRYNZNCm4ZBnBlh4s1W5YMHWxztD8Go9nPYB9GoMLMcxmhkkqW7ZpO9HwXim+ya6UIOLuVuZpAA6VGP2MNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYrLXuvv; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-22f32226947so777060fac.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956109; x=1713560909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f51USvNE8y445K4bfiKnnRxSA5H877NAgdsZGb73FMA=;
        b=FYrLXuvvCb5Arnjf5EcIPTkF1BUEerdFJlIf8njjeJXzuwcorIcpmKanlIzT6XD5dO
         MsuMHLpzumbYQhWBOFbOVJK6TPPbXbAGgxdFhzrb/CV5AeSmrPCHZZz2vCcXi8R4wlm/
         6ekDzbFBpmTE29ZlckIGouj8LoZehA9yME9+g9oAcG3i/we0y44HQ4yvVRIocHimzPrx
         +TY8UbYtLYtGLoTchY1iwG6RrrhAD7rauzwOhbpMnfr3on1ydBepuXupCmVbJh+Iwp6D
         iLvPEYfLkgohu9HXiwX3U1Srhdu4LkehlKN7bJwtQSTNr521bRgmuixM6X5ZmBd1XISi
         aFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956109; x=1713560909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f51USvNE8y445K4bfiKnnRxSA5H877NAgdsZGb73FMA=;
        b=jy3j1psjGBSl0se2IwAkbRH3qhHOw2aZAMWEsFaG7442vXTW76uW3bYcBo/qRpnNa6
         ufz8PgihxUrMY0n7lHB2Lmx9DmrjSEXFEizcCoXz8D8XfAodk93FESaXFvGFDzhxfA/m
         87InudCNKJl7dvwHlxr2EAOhmSPao+ZpZo2dt4DWxd4h4ExrE4iLpWY465EgW4fggIUb
         d+gfmRxvveHV3+KCzjs9OAHgspn9MQchTsx4QyLJ8j8V2HSSZdQTlhc34WvKI5qcQz2Q
         hAKs/9U/z+ZFKau1RuyICOiiY83EqesspdW8+6lgi0hwiTTIJDh6ngulzpqAqb99sRjv
         M/3Q==
X-Gm-Message-State: AOJu0YzZsaKU0Ep6EEFtS066skvxjmsnk1obKvwD7ov421TFZAeUfjLA
	6y0H01adkfFnw9/qlWS6HtxIqZxeTj5elQMzYfllienncGPIEgH56fBodA==
X-Google-Smtp-Source: AGHT+IGNw+Dgl/KiSIoJrpdmd8TTaVCci7JQ6e5Kc+9Q7EjW5TJY6/bggY/EIR5PvgmOC8fw1PsKrg==
X-Received: by 2002:a05:6870:390c:b0:222:4cb3:4e79 with SMTP id b12-20020a056870390c00b002224cb34e79mr4057449oap.12.1712956109379;
        Fri, 12 Apr 2024 14:08:29 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 10/11] selftests/bpf: Test global bpf_rb_root arrays.
Date: Fri, 12 Apr 2024 14:08:13 -0700
Message-Id: <20240412210814.603377-11-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
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



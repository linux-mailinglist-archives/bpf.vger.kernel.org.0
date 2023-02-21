Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7062869E8D7
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBUUHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBUUHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:07:03 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ABA2E803
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:59 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id o12so22379623edb.9
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/NVtpPbIharfM3JtAtkn9c6Phwb0DxB7fDZfLZuZSg=;
        b=hRzrm2WRDKcx6GUHKtujqu1frHFeH3Fp2etTPZIe+llPbYg7jpoata35B7wcp/x6bZ
         ZIbnFJb9gIWXLxJEC3e2WvH4yC0qdtUQJ3sQ346XB61cRmYkUVf8hhuzGEuUvl9o6XrQ
         MMtG7TijlsEJUgrDJzr1CDnEZyvXiOKqg6swLtPWqduCfLikn01uWWTlngXGtVK/H27o
         1mNS6lDZYHsXcBg0H5B96G0plr19jO++CNcgoe1Aho248fMdlGpv6khGR2Xy40135hAk
         IULyzkkzWLWYu8lNFWwgDtxGHrtdT6s3jXM2cypoOE8Qg8qSq0Z83blG09+EwOZApJyj
         GDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/NVtpPbIharfM3JtAtkn9c6Phwb0DxB7fDZfLZuZSg=;
        b=L7GC6IMBdi0q7tMe51Th+W1LIgC8z1yyOt/P/ZbUAY9k/GfvTKOejsGWpvGCw+HYB1
         s3B3lVbfRwqCgwMeHx5gfgoTQTSnnTsDCmgfrB7gJNo4yAJZ8pUXQxfOjQa+DfjLh6Ae
         cv48Q+zu835iSYlmXy7h9/fvMSLYrh9HpCveylyFUQHLBM7ydVxn/qPsQYOJCzNp7eGR
         Di05OGRL7f+kJR0BABXV90pMomEN04I21VqDjFdkKAVJ+Y+bQNw668VQyNzM++dY0pbI
         +OFG4pV8N2GHYVMYxQWOPCTRki4NcHKC8RgJsDeeV6olveGPPD4y32diQr02RdDkSjxX
         f6GQ==
X-Gm-Message-State: AO0yUKUfG6UoLJlISa5/QDdRIT+o9y8fN/sIAj+15iIxDZyNRPgx/dqG
        ueBeg3eJnjbR2OBAYV1h0tHlRqV4vGcy2g==
X-Google-Smtp-Source: AK7set/KRB4eBNvEjEuELEHcrfR5roDg83kOA728QYQz+oBXDM9e3AE60XRnCXubgLKs41XwZxuSVg==
X-Received: by 2002:a17:907:75c2:b0:8b1:3008:b4f3 with SMTP id jl2-20020a17090775c200b008b13008b4f3mr12940825ejc.52.1677010017199;
        Tue, 21 Feb 2023 12:06:57 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id z11-20020a1709060acb00b008ba9e67ea4asm5196967ejf.133.2023.02.21.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:06:56 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Add more tests for kptrs in maps
Date:   Tue, 21 Feb 2023 21:06:46 +0100
Message-Id: <20230221200646.2500777-8-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221200646.2500777-1-memxor@gmail.com>
References: <20230221200646.2500777-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19308; i=memxor@gmail.com; h=from:subject; bh=vSpSwfPNYeIwUOJaWTGbqKmoF26xmBGz6bWmsDk1WJY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj9SRMYN1QmBbrE8DyWDiPUMa0dZdeIzQnxwfaBFcc b88CySuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/UkTAAKCRBM4MiGSL8RyptSD/ wIUCCIV0GfTIFnWNokaHWwY8YAYHFUyw1choCoI/gEa6mELFzh9SrFgV1EezKNNMTyZuPxIgJb3817 Nscf/X29wAzfaXR17HhjVz1yIQyx0B6ae29idN0Y6T34tZYhg+IKRq+WA0/FOsBJdemNSrUpw9W7Kk ERH9K1Nl2NhrYyoIGuLMLgG6tSLbR1/5cGRrsDzJwZVz2lp8xI7x/+1ciohtc0B+GgyYM62fmM3OYI puOOZShuhfsd3AUuCC+UKi/wPZ2LT/a9l20kje8F6ZCr0ltGNBlbDS/xQWtfyRUfCijEx/NrXPoWM4 ffxT2WOb7bngtAnJHjsNM5lna13y+jXJvVh7IOroDMwbUXcvmH/N+L++CTNI/GwNXgYcd+A5UcBYoT MHo/pNTUuvfxafSry6A2mE7yMnbYxh2Tk8qWzwGwoyaNFkndB6Hefx2b+I1ewF9pi8rKW98NAmwG1Q 0dFIFdxdK3dncnZHJnUm5WYZJH0rOr8B78aMjY68azMN44fX7Ud20VqYUVzqwQhLcL7hho2Fx8AZe8 7VgdZqu6WhY9eGkhCU2AaTcXEtl6HJDmn2qEQmFNsb4W8CtvUv/k0HruRlAQ7fQo5HtMGrl0EvSZo9 baOGuDL7imtfhf4CbVDTqmksAl0dt7IsrS5pfuCo1UMTbzDizFp4VxYoOzgw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Firstly, ensure programs successfully load when using all of the
supported maps. Then, extend existing tests to test more cases at
runtime. We are currently testing both the synchronous freeing of items
and asynchronous destruction when map is freed, but the code needs to be
adjusted a bit to be able to also accomodate support for percpu maps.

We now do a delete on the item (and update for array maps which has a
similar effect for kptrs) to perform a synchronous free of the kptr, and
test destruction both for the synchronous and asynchronous deletion.
Next time the program runs, it should observe the refcount as 1 since
all existing references should have been released by then. By running
the program after both possible paths freeing kptrs, we establish that
they correctly release resources. Next, we augment the existing test to
also test the same code path shared by all local storage maps using a
task local storage map.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       | 122 ++++--
 tools/testing/selftests/bpf/progs/map_kptr.c  | 353 +++++++++++++++---
 2 files changed, 410 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 3533a4ecad01..550497ee04f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -7,67 +7,143 @@
 
 static void test_map_kptr_success(bool test_run)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, lopts);
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
 		.data_in = &pkt_v4,
 		.data_size_in = sizeof(pkt_v4),
 		.repeat = 1,
 	);
+	int key = 0, ret, cpu;
 	struct map_kptr *skel;
-	int key = 0, ret;
-	char buf[16];
+	struct bpf_link *link;
+	char buf[16], *pbuf;
 
 	skel = map_kptr__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
 		return;
 
-	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref), &opts);
-	ASSERT_OK(ret, "test_map_kptr_ref refcount");
-	ASSERT_OK(opts.retval, "test_map_kptr_ref retval");
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref1), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref1 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref1 retval");
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref2), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref2 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref2 retval");
 
+	link = bpf_program__attach(skel->progs.test_ls_map_kptr_ref1);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach ref1"))
+		goto exit;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_ls_map_kptr_ref1), &lopts);
+	ASSERT_OK(ret, "test_ls_map_kptr_ref1 refcount");
+	ASSERT_EQ((lopts.retval << 16) >> 16, 9000, "test_ls_map_kptr_ref1 retval");
+	if (!ASSERT_OK(bpf_link__destroy(link), "bpf_link__destroy"))
+		goto exit;
+
+	link = bpf_program__attach(skel->progs.test_ls_map_kptr_ref2);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach ref2"))
+		goto exit;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_ls_map_kptr_ref2), &lopts);
+	ASSERT_OK(ret, "test_ls_map_kptr_ref2 refcount");
+	ASSERT_EQ((lopts.retval << 16) >> 16, 9000, "test_ls_map_kptr_ref2 retval");
+	if (!ASSERT_OK(bpf_link__destroy(link), "bpf_link__destroy"))
+		goto exit;
+
 	if (test_run)
 		goto exit;
 
+	cpu = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(cpu, 0, "libbpf_num_possible_cpus"))
+		goto exit;
+
+	pbuf = calloc(cpu, sizeof(buf));
+	if (!ASSERT_OK_PTR(pbuf, "calloc(pbuf)"))
+		goto exit;
+
 	ret = bpf_map__update_elem(skel->maps.array_map,
 				   &key, sizeof(key), buf, sizeof(buf), 0);
 	ASSERT_OK(ret, "array_map update");
-	ret = bpf_map__update_elem(skel->maps.array_map,
-				   &key, sizeof(key), buf, sizeof(buf), 0);
-	ASSERT_OK(ret, "array_map update2");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	ret = bpf_map__update_elem(skel->maps.pcpu_array_map,
+				   &key, sizeof(key), pbuf, cpu * sizeof(buf), 0);
+	ASSERT_OK(ret, "pcpu_array_map update");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
-	ret = bpf_map__update_elem(skel->maps.hash_map,
-				   &key, sizeof(key), buf, sizeof(buf), 0);
-	ASSERT_OK(ret, "hash_map update");
 	ret = bpf_map__delete_elem(skel->maps.hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "hash_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	ret = bpf_map__delete_elem(skel->maps.pcpu_hash_map, &key, sizeof(key), 0);
+	ASSERT_OK(ret, "pcpu_hash_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
-	ret = bpf_map__update_elem(skel->maps.hash_malloc_map,
-				   &key, sizeof(key), buf, sizeof(buf), 0);
-	ASSERT_OK(ret, "hash_malloc_map update");
 	ret = bpf_map__delete_elem(skel->maps.hash_malloc_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "hash_malloc_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	ret = bpf_map__delete_elem(skel->maps.pcpu_hash_malloc_map, &key, sizeof(key), 0);
+	ASSERT_OK(ret, "pcpu_hash_malloc_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
-	ret = bpf_map__update_elem(skel->maps.lru_hash_map,
-				   &key, sizeof(key), buf, sizeof(buf), 0);
-	ASSERT_OK(ret, "lru_hash_map update");
 	ret = bpf_map__delete_elem(skel->maps.lru_hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "lru_hash_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	ret = bpf_map__delete_elem(skel->maps.lru_pcpu_hash_map, &key, sizeof(key), 0);
+	ASSERT_OK(ret, "lru_pcpu_hash_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	link = bpf_program__attach(skel->progs.test_ls_map_kptr_ref_del);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach ref_del"))
+		goto exit;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_ls_map_kptr_ref_del), &lopts);
+	ASSERT_OK(ret, "test_ls_map_kptr_ref_del delete");
+	skel->data->ref--;
+	ASSERT_EQ((lopts.retval << 16) >> 16, 9000, "test_ls_map_kptr_ref_del retval");
+	if (!ASSERT_OK(bpf_link__destroy(link), "bpf_link__destroy"))
+		goto exit;
 
+	free(pbuf);
 exit:
 	map_kptr__destroy(skel);
 }
 
 void test_map_kptr(void)
 {
-	if (test__start_subtest("success")) {
+	RUN_TESTS(map_kptr_fail);
+
+	if (test__start_subtest("success-map")) {
+		test_map_kptr_success(true);
+
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		/* Observe refcount dropping to 1 on bpf_map_free_deferred */
 		test_map_kptr_success(false);
-		/* Do test_run twice, so that we see refcount going back to 1
-		 * after we leave it in map from first iteration.
-		 */
+
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		/* Observe refcount dropping to 1 on synchronous delete elem */
 		test_map_kptr_success(true);
 	}
-
-	RUN_TESTS(map_kptr_fail);
 }
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index 228ec45365a8..f8d7f2adccc9 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -15,6 +15,13 @@ struct array_map {
 	__uint(max_entries, 1);
 } array_map SEC(".maps");
 
+struct pcpu_array_map {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} pcpu_array_map SEC(".maps");
+
 struct hash_map {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
@@ -22,6 +29,13 @@ struct hash_map {
 	__uint(max_entries, 1);
 } hash_map SEC(".maps");
 
+struct pcpu_hash_map {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} pcpu_hash_map SEC(".maps");
+
 struct hash_malloc_map {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
@@ -30,6 +44,14 @@ struct hash_malloc_map {
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 } hash_malloc_map SEC(".maps");
 
+struct pcpu_hash_malloc_map {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} pcpu_hash_malloc_map SEC(".maps");
+
 struct lru_hash_map {
 	__uint(type, BPF_MAP_TYPE_LRU_HASH);
 	__type(key, int);
@@ -37,6 +59,41 @@ struct lru_hash_map {
 	__uint(max_entries, 1);
 } lru_hash_map SEC(".maps");
 
+struct lru_pcpu_hash_map {
+	__uint(type, BPF_MAP_TYPE_LRU_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} lru_pcpu_hash_map SEC(".maps");
+
+struct cgrp_ls_map {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} cgrp_ls_map SEC(".maps");
+
+struct task_ls_map {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} task_ls_map SEC(".maps");
+
+struct inode_ls_map {
+	__uint(type, BPF_MAP_TYPE_INODE_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} inode_ls_map SEC(".maps");
+
+struct sk_ls_map {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} sk_ls_map SEC(".maps");
+
 #define DEFINE_MAP_OF_MAP(map_type, inner_map_type, name)       \
 	struct {                                                \
 		__uint(type, map_type);                         \
@@ -160,6 +217,58 @@ int test_map_kptr(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_map_kptr, struct cgroup *cgrp, const char *path)
+{
+	struct map_value *v;
+
+	v = bpf_cgrp_storage_get(&cgrp_ls_map, cgrp, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (v)
+		test_kptr(v);
+	return 0;
+}
+
+SEC("lsm/inode_unlink")
+int BPF_PROG(test_task_map_kptr, struct inode *inode, struct dentry *victim)
+{
+	struct task_struct *task;
+	struct map_value *v;
+
+	task = bpf_get_current_task_btf();
+	if (!task)
+		return 0;
+	v = bpf_task_storage_get(&task_ls_map, task, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (v)
+		test_kptr(v);
+	return 0;
+}
+
+SEC("lsm/inode_unlink")
+int BPF_PROG(test_inode_map_kptr, struct inode *inode, struct dentry *victim)
+{
+	struct map_value *v;
+
+	v = bpf_inode_storage_get(&inode_ls_map, inode, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (v)
+		test_kptr(v);
+	return 0;
+}
+
+SEC("tc")
+int test_sk_map_kptr(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	struct bpf_sock *sk;
+
+	sk = ctx->sk;
+	if (!sk)
+		return 0;
+	v = bpf_sk_storage_get(&sk_ls_map, sk, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (v)
+		test_kptr(v);
+	return 0;
+}
+
 SEC("tc")
 int test_map_in_map_kptr(struct __sk_buff *ctx)
 {
@@ -189,106 +298,266 @@ int test_map_in_map_kptr(struct __sk_buff *ctx)
 	return 0;
 }
 
-SEC("tc")
-int test_map_kptr_ref(struct __sk_buff *ctx)
+int ref = 1;
+
+static __always_inline
+int test_map_kptr_ref_pre(struct map_value *v)
 {
 	struct prog_test_ref_kfunc *p, *p_st;
 	unsigned long arg = 0;
-	struct map_value *v;
-	int key = 0, ret;
+	int ret;
 
 	p = bpf_kfunc_call_test_acquire(&arg);
 	if (!p)
 		return 1;
+	ref++;
 
 	p_st = p->next;
-	if (p_st->cnt.refs.counter != 2) {
+	if (p_st->cnt.refs.counter != ref) {
 		ret = 2;
 		goto end;
 	}
 
-	v = bpf_map_lookup_elem(&array_map, &key);
-	if (!v) {
-		ret = 3;
-		goto end;
-	}
-
 	p = bpf_kptr_xchg(&v->ref_ptr, p);
 	if (p) {
-		ret = 4;
+		ret = 3;
 		goto end;
 	}
-	if (p_st->cnt.refs.counter != 2)
-		return 5;
+	if (p_st->cnt.refs.counter != ref)
+		return 4;
 
 	p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
 	if (!p)
-		return 6;
-	if (p_st->cnt.refs.counter != 3) {
-		ret = 7;
+		return 5;
+	ref++;
+	if (p_st->cnt.refs.counter != ref) {
+		ret = 6;
 		goto end;
 	}
 	bpf_kfunc_call_test_release(p);
-	if (p_st->cnt.refs.counter != 2)
-		return 8;
+	ref--;
+	if (p_st->cnt.refs.counter != ref)
+		return 7;
 
 	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
 	if (!p)
-		return 9;
+		return 8;
 	bpf_kfunc_call_test_release(p);
-	if (p_st->cnt.refs.counter != 1)
-		return 10;
+	ref--;
+	if (p_st->cnt.refs.counter != ref)
+		return 9;
 
 	p = bpf_kfunc_call_test_acquire(&arg);
 	if (!p)
-		return 11;
+		return 10;
+	ref++;
 	p = bpf_kptr_xchg(&v->ref_ptr, p);
 	if (p) {
-		ret = 12;
+		ret = 11;
 		goto end;
 	}
-	if (p_st->cnt.refs.counter != 2)
-		return 13;
+	if (p_st->cnt.refs.counter != ref)
+		return 12;
 	/* Leave in map */
 
 	return 0;
 end:
+	ref--;
 	bpf_kfunc_call_test_release(p);
 	return ret;
 }
 
-SEC("tc")
-int test_map_kptr_ref2(struct __sk_buff *ctx)
+static __always_inline
+int test_map_kptr_ref_post(struct map_value *v)
 {
 	struct prog_test_ref_kfunc *p, *p_st;
-	struct map_value *v;
-	int key = 0;
-
-	v = bpf_map_lookup_elem(&array_map, &key);
-	if (!v)
-		return 1;
 
 	p_st = v->ref_ptr;
-	if (!p_st || p_st->cnt.refs.counter != 2)
-		return 2;
+	if (!p_st || p_st->cnt.refs.counter != ref)
+		return 1;
 
 	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
 	if (!p)
-		return 3;
-	if (p_st->cnt.refs.counter != 2) {
+		return 2;
+	if (p_st->cnt.refs.counter != ref) {
 		bpf_kfunc_call_test_release(p);
-		return 4;
+		return 3;
 	}
 
 	p = bpf_kptr_xchg(&v->ref_ptr, p);
 	if (p) {
 		bpf_kfunc_call_test_release(p);
-		return 5;
+		return 4;
 	}
-	if (p_st->cnt.refs.counter != 2)
-		return 6;
+	if (p_st->cnt.refs.counter != ref)
+		return 5;
+
+	return 0;
+}
+
+#define TEST(map)                            \
+	v = bpf_map_lookup_elem(&map, &key); \
+	if (!v)                              \
+		return -1;                   \
+	ret = test_map_kptr_ref_pre(v);      \
+	if (ret)                             \
+		return ret;
+
+#define TEST_PCPU(map)                                 \
+	v = bpf_map_lookup_percpu_elem(&map, &key, 0); \
+	if (!v)                                        \
+		return -1;                             \
+	ret = test_map_kptr_ref_pre(v);                \
+	if (ret)                                       \
+		return ret;
+
+SEC("tc")
+int test_map_kptr_ref1(struct __sk_buff *ctx)
+{
+	struct map_value *v, val = {};
+	int key = 0, ret;
+
+	bpf_map_update_elem(&hash_map, &key, &val, 0);
+	bpf_map_update_elem(&hash_malloc_map, &key, &val, 0);
+	bpf_map_update_elem(&lru_hash_map, &key, &val, 0);
+
+	bpf_map_update_elem(&pcpu_hash_map, &key, &val, 0);
+	bpf_map_update_elem(&pcpu_hash_malloc_map, &key, &val, 0);
+	bpf_map_update_elem(&lru_pcpu_hash_map, &key, &val, 0);
+
+	TEST(array_map);
+	TEST(hash_map);
+	TEST(hash_malloc_map);
+	TEST(lru_hash_map);
+
+	TEST_PCPU(pcpu_array_map);
+	TEST_PCPU(pcpu_hash_map);
+	TEST_PCPU(pcpu_hash_malloc_map);
+	TEST_PCPU(lru_pcpu_hash_map);
+
+	return 0;
+}
+
+#undef TEST
+#undef TEST_PCPU
+
+#define TEST(map)                            \
+	v = bpf_map_lookup_elem(&map, &key); \
+	if (!v)                              \
+		return -1;                   \
+	ret = test_map_kptr_ref_post(v);     \
+	if (ret)                             \
+		return ret;
+
+#define TEST_PCPU(map)                                 \
+	v = bpf_map_lookup_percpu_elem(&map, &key, 0); \
+	if (!v)                                        \
+		return -1;                             \
+	ret = test_map_kptr_ref_post(v);               \
+	if (ret)                                       \
+		return ret;
+
+SEC("tc")
+int test_map_kptr_ref2(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0, ret;
+
+	TEST(array_map);
+	TEST(hash_map);
+	TEST(hash_malloc_map);
+	TEST(lru_hash_map);
+
+	TEST_PCPU(pcpu_array_map);
+	TEST_PCPU(pcpu_hash_map);
+	TEST_PCPU(pcpu_hash_malloc_map);
+	TEST_PCPU(lru_pcpu_hash_map);
 
 	return 0;
 }
 
+#undef TEST
+#undef TEST_PCPU
+
+SEC("tc")
+int test_map_kptr_ref3(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long sp = 0;
+
+	p = bpf_kfunc_call_test_acquire(&sp);
+	if (!p)
+		return 1;
+	ref++;
+	if (p->cnt.refs.counter != ref) {
+		bpf_kfunc_call_test_release(p);
+		return 2;
+	}
+	bpf_kfunc_call_test_release(p);
+	ref--;
+	return 0;
+}
+
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(test_ls_map_kptr_ref1, int a, int *b)
+{
+	struct task_struct *current;
+	struct map_value *v;
+	int ret;
+
+	current = bpf_get_current_task_btf();
+	if (!current)
+		return 100;
+	v = bpf_task_storage_get(&task_ls_map, current, NULL, 0);
+	if (v)
+		return 150;
+	v = bpf_task_storage_get(&task_ls_map, current, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 200;
+	ret = test_map_kptr_ref_pre(v);
+	if (ret)
+		return ret;
+	return 9000;
+}
+
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(test_ls_map_kptr_ref2, int a, int *b)
+{
+	struct task_struct *current;
+	struct map_value *v;
+	int ret;
+
+	current = bpf_get_current_task_btf();
+	if (!current)
+		return 100;
+	v = bpf_task_storage_get(&task_ls_map, current, NULL, 0);
+	if (!v)
+		return 200;
+	ret = test_map_kptr_ref_post(v);
+	if (ret)
+		return ret;
+	return 9000;
+}
+
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(test_ls_map_kptr_ref_del, int a, int *b)
+{
+	struct task_struct *current;
+	struct map_value *v;
+	int ret;
+
+	current = bpf_get_current_task_btf();
+	if (!current)
+		return 100;
+	v = bpf_task_storage_get(&task_ls_map, current, NULL, 0);
+	if (!v)
+		return 200;
+	if (!v->ref_ptr)
+		return 300;
+	ret = bpf_task_storage_delete(&task_ls_map, current);
+	if (ret)
+		return ret;
+	return 9000;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.39.2


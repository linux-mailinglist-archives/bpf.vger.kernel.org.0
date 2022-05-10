Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6C7522067
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346693AbiEJQCC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 12:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347034AbiEJQBK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 12:01:10 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4C1A81A
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g6so33868482ejw.1
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrN6nPwFurvbWx2ZeJJIGVbJH9IswrpXbnSIRCX+UJg=;
        b=gIEmlV7wDIo/Ya2Sh8gVhQWtzVErlTnSvoFTAahEzPElZXYXjexjiFD3DcmKa9bb12
         uWzsGabGcXfGiMi5COQA/i1/pwTYyEH/Qbuq6wvGlNRBSvZjoCcDTv3GPREoNO2xzrAQ
         sknFm8YtriVRMd4qQ4vE3h7iZYpbG2FI0ibYQqKIZMf0BYlEZwnKIZtdXGXpBSQD5nza
         K4qw3BmhikU0DJKfstl0GXAJhFcNAHed4fLxNtDzM5aJA27886rfi69kcL8YHXTpK+ud
         HQjX+6aIuzYujb4RZbCququH61LJy6/ECgpqjh6eWwpG+funyAs5+YjfBOyJVN5h8+zt
         ca9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrN6nPwFurvbWx2ZeJJIGVbJH9IswrpXbnSIRCX+UJg=;
        b=Nm23XeOaPzzPWK46ENVS50baS8HBwTSYZr+CCX1ijVVvCDgmGKPYeYpKU4f/qmRmwy
         wzUEQfWbsU2/IBnqvEtuOC5HIGWixAA5GM8xI3TmkAOBIWvta7xAYJye9VBnsqjeNh92
         Ekgr8TSe1WETHKMFxRfLF+Iev/N8DGg+LrU3aS3mEwJktBmQVpZesPfvNFQdmFODjiyj
         vN0mDJwz23e/b95jc+DwmqA4XnYQTokLyBxUUypTA4cKkhsgGBF7wVRnLN4Hm72VsrLD
         h/A6VA0nwskdTNRNF/+pmRrBUYMUODnauZtdXRVJD5N2Afeup8vHu1CqI4SuT2Fz7PRD
         QgMQ==
X-Gm-Message-State: AOAM533YGFbesF2uH/azxGRvNon87uXu+VQTKLsnf1C1ADS1hjlE2ZqB
        nSLQOIx53waRHPSNAT117fzLG/XsESvKfQ==
X-Google-Smtp-Source: ABdhPJylNhJWVp0VRLMvsIw9D2XsNLfoyM3IJnZqaNA2ZUcGNE9/hInzuMrJL6N6PNdJPaV9UqbQyQ==
X-Received: by 2002:a17:906:314e:b0:6f0:659:963 with SMTP id e14-20020a170906314e00b006f006590963mr20727403eje.358.1652198026747;
        Tue, 10 May 2022 08:53:46 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-011-044.094.222.pools.vodafone-ip.de. [94.222.11.44])
        by smtp.gmail.com with ESMTPSA id s30-20020a508d1e000000b0042617ba63b0sm7806088eds.58.2022.05.10.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:53:46 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Use ASSERT_* instead of CHECK
Date:   Tue, 10 May 2022 17:52:32 +0200
Message-Id: <20220510155233.9815-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510155233.9815-1-9erthalion6@gmail.com>
References: <20220510155233.9815-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Replace usage of CHECK with a corresponding ASSERT_* macro for bpf_iter
tests. Only done if the final result is equivalent, no changes when
replacement means loosing some information, e.g. from formatting string.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 242 +++++++-----------
 1 file changed, 88 insertions(+), 154 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 6943209b7457..48289c886058 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -34,8 +34,7 @@ static void test_btf_id_or_null(void)
 	struct bpf_iter_test_kern3 *skel;
 
 	skel = bpf_iter_test_kern3__open_and_load();
-	if (CHECK(skel, "bpf_iter_test_kern3__open_and_load",
-		  "skeleton open_and_load unexpectedly succeeded\n")) {
+	if (!ASSERT_ERR_PTR(skel, "bpf_iter_test_kern3__open_and_load")) {
 		bpf_iter_test_kern3__destroy(skel);
 		return;
 	}
@@ -52,7 +51,7 @@ static void do_dummy_read(struct bpf_program *prog)
 		return;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	/* not check contents, but ensure read() ends without error */
@@ -87,8 +86,7 @@ static void test_ipv6_route(void)
 	struct bpf_iter_ipv6_route *skel;
 
 	skel = bpf_iter_ipv6_route__open_and_load();
-	if (CHECK(!skel, "bpf_iter_ipv6_route__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_ipv6_route__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_ipv6_route);
@@ -101,8 +99,7 @@ static void test_netlink(void)
 	struct bpf_iter_netlink *skel;
 
 	skel = bpf_iter_netlink__open_and_load();
-	if (CHECK(!skel, "bpf_iter_netlink__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_netlink__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_netlink);
@@ -115,8 +112,7 @@ static void test_bpf_map(void)
 	struct bpf_iter_bpf_map *skel;
 
 	skel = bpf_iter_bpf_map__open_and_load();
-	if (CHECK(!skel, "bpf_iter_bpf_map__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_map__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_bpf_map);
@@ -129,8 +125,7 @@ static void test_task(void)
 	struct bpf_iter_task *skel;
 
 	skel = bpf_iter_task__open_and_load();
-	if (CHECK(!skel, "bpf_iter_task__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_task);
@@ -161,8 +156,7 @@ static void test_task_stack(void)
 	struct bpf_iter_task_stack *skel;
 
 	skel = bpf_iter_task_stack__open_and_load();
-	if (CHECK(!skel, "bpf_iter_task_stack__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_stack__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_task_stack);
@@ -183,24 +177,22 @@ static void test_task_file(void)
 	void *ret;
 
 	skel = bpf_iter_task_file__open_and_load();
-	if (CHECK(!skel, "bpf_iter_task_file__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_file__open_and_load"))
 		return;
 
 	skel->bss->tgid = getpid();
 
-	if (CHECK(pthread_create(&thread_id, NULL, &do_nothing, NULL),
-		  "pthread_create", "pthread_create failed\n"))
+	if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing, NULL),
+		  "pthread_create"))
 		goto done;
 
 	do_dummy_read(skel->progs.dump_task_file);
 
-	if (CHECK(pthread_join(thread_id, &ret) || ret != NULL,
-		  "pthread_join", "pthread_join failed\n"))
+	if (!ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
+		  "pthread_join"))
 		goto done;
 
-	CHECK(skel->bss->count != 0, "check_count",
-	      "invalid non pthread file visit count %d\n", skel->bss->count);
+	ASSERT_EQ(skel->bss->count, 0, "check_count");
 
 done:
 	bpf_iter_task_file__destroy(skel);
@@ -224,7 +216,7 @@ static int do_btf_read(struct bpf_iter_task_btf *skel)
 		return ret;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	err = read_fd_into_buffer(iter_fd, buf, TASKBUFSZ);
@@ -238,9 +230,8 @@ static int do_btf_read(struct bpf_iter_task_btf *skel)
 	if (CHECK(err < 0, "read", "read failed: %s\n", strerror(errno)))
 		goto free_link;
 
-	CHECK(strstr(taskbuf, "(struct task_struct)") == NULL,
-	      "check for btf representation of task_struct in iter data",
-	      "struct task_struct not found");
+	ASSERT_HAS_SUBSTR(taskbuf, "(struct task_struct)",
+	      "check for btf representation of task_struct in iter data");
 free_link:
 	if (iter_fd > 0)
 		close(iter_fd);
@@ -255,8 +246,7 @@ static void test_task_btf(void)
 	int ret;
 
 	skel = bpf_iter_task_btf__open_and_load();
-	if (CHECK(!skel, "bpf_iter_task_btf__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_btf__open_and_load"))
 		return;
 
 	bss = skel->bss;
@@ -265,12 +255,10 @@ static void test_task_btf(void)
 	if (ret)
 		goto cleanup;
 
-	if (CHECK(bss->tasks == 0, "check if iterated over tasks",
-		  "no task iteration, did BPF program run?\n"))
+	if (!ASSERT_NEQ(bss->tasks, 0, "no task iteration, did BPF program run?"))
 		goto cleanup;
 
-	CHECK(bss->seq_err != 0, "check for unexpected err",
-	      "bpf_seq_printf_btf returned %ld", bss->seq_err);
+	ASSERT_EQ(bss->seq_err, 0, "check for unexpected err");
 
 cleanup:
 	bpf_iter_task_btf__destroy(skel);
@@ -281,8 +269,7 @@ static void test_tcp4(void)
 	struct bpf_iter_tcp4 *skel;
 
 	skel = bpf_iter_tcp4__open_and_load();
-	if (CHECK(!skel, "bpf_iter_tcp4__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_tcp4__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_tcp4);
@@ -295,8 +282,7 @@ static void test_tcp6(void)
 	struct bpf_iter_tcp6 *skel;
 
 	skel = bpf_iter_tcp6__open_and_load();
-	if (CHECK(!skel, "bpf_iter_tcp6__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_tcp6__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_tcp6);
@@ -309,8 +295,7 @@ static void test_udp4(void)
 	struct bpf_iter_udp4 *skel;
 
 	skel = bpf_iter_udp4__open_and_load();
-	if (CHECK(!skel, "bpf_iter_udp4__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_udp4__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_udp4);
@@ -323,8 +308,7 @@ static void test_udp6(void)
 	struct bpf_iter_udp6 *skel;
 
 	skel = bpf_iter_udp6__open_and_load();
-	if (CHECK(!skel, "bpf_iter_udp6__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_udp6__open_and_load"))
 		return;
 
 	do_dummy_read(skel->progs.dump_udp6);
@@ -349,7 +333,7 @@ static void test_unix(void)
 static int do_read_with_fd(int iter_fd, const char *expected,
 			   bool read_one_char)
 {
-	int err = -1, len, read_buf_len, start;
+	int len, read_buf_len, start;
 	char buf[16] = {};
 
 	read_buf_len = read_one_char ? 1 : 16;
@@ -363,9 +347,7 @@ static int do_read_with_fd(int iter_fd, const char *expected,
 	if (CHECK(len < 0, "read", "read failed: %s\n", strerror(errno)))
 		return -1;
 
-	err = strcmp(buf, expected);
-	if (CHECK(err, "read", "incorrect read result: buf %s, expected %s\n",
-		  buf, expected))
+	if (!ASSERT_STREQ(buf, expected, "read"))
 		return -1;
 
 	return 0;
@@ -378,19 +360,17 @@ static void test_anon_iter(bool read_one_char)
 	int iter_fd, err;
 
 	skel = bpf_iter_test_kern1__open_and_load();
-	if (CHECK(!skel, "bpf_iter_test_kern1__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_test_kern1__open_and_load"))
 		return;
 
 	err = bpf_iter_test_kern1__attach(skel);
-	if (CHECK(err, "bpf_iter_test_kern1__attach",
-		  "skeleton attach failed\n")) {
+	if (!ASSERT_OK(err, "bpf_iter_test_kern1__attach")) {
 		goto out;
 	}
 
 	link = skel->links.dump_task;
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto out;
 
 	do_read_with_fd(iter_fd, "abcd", read_one_char);
@@ -423,8 +403,7 @@ static void test_file_iter(void)
 	int err;
 
 	skel1 = bpf_iter_test_kern1__open_and_load();
-	if (CHECK(!skel1, "bpf_iter_test_kern1__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel1, "bpf_iter_test_kern1__open_and_load"))
 		return;
 
 	link = bpf_program__attach_iter(skel1->progs.dump_task, NULL);
@@ -447,12 +426,11 @@ static void test_file_iter(void)
 	 * should change.
 	 */
 	skel2 = bpf_iter_test_kern2__open_and_load();
-	if (CHECK(!skel2, "bpf_iter_test_kern2__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel2, "bpf_iter_test_kern2__open_and_load"))
 		goto unlink_path;
 
 	err = bpf_link__update_program(link, skel2->progs.dump_task);
-	if (CHECK(err, "update_prog", "update_prog failed\n"))
+	if (!ASSERT_OK(err, "update_prog"))
 		goto destroy_skel2;
 
 	do_read(path, "ABCD");
@@ -478,8 +456,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 	char *buf;
 
 	skel = bpf_iter_test_kern4__open();
-	if (CHECK(!skel, "bpf_iter_test_kern4__open",
-		  "skeleton open failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_test_kern4__open"))
 		return;
 
 	/* create two maps: bpf program will only do bpf_seq_write
@@ -515,8 +492,8 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 	}
 	skel->rodata->ret1 = ret1;
 
-	if (CHECK(bpf_iter_test_kern4__load(skel),
-		  "bpf_iter_test_kern4__load", "skeleton load failed\n"))
+	if (!ASSERT_OK(bpf_iter_test_kern4__load(skel),
+		  "bpf_iter_test_kern4__load"))
 		goto free_map2;
 
 	/* setup filtering map_id in bpf program */
@@ -538,7 +515,7 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 		goto free_map2;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	buf = malloc(expected_read_len);
@@ -574,22 +551,16 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 			goto free_buf;
 	}
 
-	if (CHECK(total_read_len != expected_read_len, "read",
-		  "total len %u, expected len %u\n", total_read_len,
-		  expected_read_len))
+	if (!ASSERT_EQ(total_read_len, expected_read_len, "read"))
 		goto free_buf;
 
-	if (CHECK(skel->bss->map1_accessed != 1, "map1_accessed",
-		  "expected 1 actual %d\n", skel->bss->map1_accessed))
+	if (!ASSERT_EQ(skel->bss->map1_accessed, 1, "map1_accessed"))
 		goto free_buf;
 
-	if (CHECK(skel->bss->map2_accessed != 2, "map2_accessed",
-		  "expected 2 actual %d\n", skel->bss->map2_accessed))
+	if (!ASSERT_EQ(skel->bss->map2_accessed, 2, "map2_accessed"))
 		goto free_buf;
 
-	CHECK(skel->bss->map2_seqnum1 != skel->bss->map2_seqnum2,
-	      "map2_seqnum", "two different seqnum %lld %lld\n",
-	      skel->bss->map2_seqnum1, skel->bss->map2_seqnum2);
+	ASSERT_EQ(skel->bss->map2_seqnum1, skel->bss->map2_seqnum2, "map2_seqnum");
 
 free_buf:
 	free(buf);
@@ -622,8 +593,7 @@ static void test_bpf_hash_map(void)
 	char buf[64];
 
 	skel = bpf_iter_bpf_hash_map__open();
-	if (CHECK(!skel, "bpf_iter_bpf_hash_map__open",
-		  "skeleton open failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_hash_map__open"))
 		return;
 
 	skel->bss->in_test_mode = true;
@@ -658,7 +628,7 @@ static void test_bpf_hash_map(void)
 		expected_val += val;
 
 		err = bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
-		if (CHECK(err, "map_update", "map_update failed\n"))
+		if (!ASSERT_OK(err, "map_update"))
 			goto out;
 	}
 
@@ -668,7 +638,7 @@ static void test_bpf_hash_map(void)
 		goto out;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	/* do some tests */
@@ -678,17 +648,11 @@ static void test_bpf_hash_map(void)
 		goto close_iter;
 
 	/* test results */
-	if (CHECK(skel->bss->key_sum_a != expected_key_a,
-		  "key_sum_a", "got %u expected %u\n",
-		  skel->bss->key_sum_a, expected_key_a))
+	if (!ASSERT_EQ(skel->bss->key_sum_a, expected_key_a, "key_sum_a"))
 		goto close_iter;
-	if (CHECK(skel->bss->key_sum_b != expected_key_b,
-		  "key_sum_b", "got %u expected %u\n",
-		  skel->bss->key_sum_b, expected_key_b))
+	if (!ASSERT_EQ(skel->bss->key_sum_b, expected_key_b, "key_sum_b"))
 		goto close_iter;
-	if (CHECK(skel->bss->val_sum != expected_val,
-		  "val_sum", "got %llu expected %llu\n",
-		  skel->bss->val_sum, expected_val))
+	if (!ASSERT_EQ(skel->bss->val_sum, expected_val, "val_sum"))
 		goto close_iter;
 
 close_iter:
@@ -717,16 +681,14 @@ static void test_bpf_percpu_hash_map(void)
 	void *val;
 
 	skel = bpf_iter_bpf_percpu_hash_map__open();
-	if (CHECK(!skel, "bpf_iter_bpf_percpu_hash_map__open",
-		  "skeleton open failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__open"))
 		return;
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
 
 	err = bpf_iter_bpf_percpu_hash_map__load(skel);
-	if (CHECK(!skel, "bpf_iter_bpf_percpu_hash_map__load",
-		  "skeleton load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_hash_map__load"))
 		goto out;
 
 	/* update map values here */
@@ -744,7 +706,7 @@ static void test_bpf_percpu_hash_map(void)
 		}
 
 		err = bpf_map_update_elem(map_fd, &key, val, BPF_ANY);
-		if (CHECK(err, "map_update", "map_update failed\n"))
+		if (!ASSERT_OK(err, "map_update"))
 			goto out;
 	}
 
@@ -757,7 +719,7 @@ static void test_bpf_percpu_hash_map(void)
 		goto out;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	/* do some tests */
@@ -767,17 +729,11 @@ static void test_bpf_percpu_hash_map(void)
 		goto close_iter;
 
 	/* test results */
-	if (CHECK(skel->bss->key_sum_a != expected_key_a,
-		  "key_sum_a", "got %u expected %u\n",
-		  skel->bss->key_sum_a, expected_key_a))
+	if (!ASSERT_EQ(skel->bss->key_sum_a, expected_key_a, "key_sum_a"))
 		goto close_iter;
-	if (CHECK(skel->bss->key_sum_b != expected_key_b,
-		  "key_sum_b", "got %u expected %u\n",
-		  skel->bss->key_sum_b, expected_key_b))
+	if (!ASSERT_EQ(skel->bss->key_sum_b, expected_key_b, "key_sum_b"))
 		goto close_iter;
-	if (CHECK(skel->bss->val_sum != expected_val,
-		  "val_sum", "got %u expected %u\n",
-		  skel->bss->val_sum, expected_val))
+	if (!ASSERT_EQ(skel->bss->val_sum, expected_val, "val_sum"))
 		goto close_iter;
 
 close_iter:
@@ -802,8 +758,7 @@ static void test_bpf_array_map(void)
 	int len, start;
 
 	skel = bpf_iter_bpf_array_map__open_and_load();
-	if (CHECK(!skel, "bpf_iter_bpf_array_map__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_array_map__open_and_load"))
 		return;
 
 	map_fd = bpf_map__fd(skel->maps.arraymap1);
@@ -816,7 +771,7 @@ static void test_bpf_array_map(void)
 			first_val = val;
 
 		err = bpf_map_update_elem(map_fd, &i, &val, BPF_ANY);
-		if (CHECK(err, "map_update", "map_update failed\n"))
+		if (!ASSERT_OK(err, "map_update"))
 			goto out;
 	}
 
@@ -829,7 +784,7 @@ static void test_bpf_array_map(void)
 		goto out;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	/* do some tests */
@@ -849,21 +804,16 @@ static void test_bpf_array_map(void)
 		  res_first_key, res_first_val, first_val))
 		goto close_iter;
 
-	if (CHECK(skel->bss->key_sum != expected_key,
-		  "key_sum", "got %u expected %u\n",
-		  skel->bss->key_sum, expected_key))
+	if (!ASSERT_EQ(skel->bss->key_sum, expected_key, "key_sum"))
 		goto close_iter;
-	if (CHECK(skel->bss->val_sum != expected_val,
-		  "val_sum", "got %llu expected %llu\n",
-		  skel->bss->val_sum, expected_val))
+	if (!ASSERT_EQ(skel->bss->val_sum, expected_val, "val_sum"))
 		goto close_iter;
 
 	for (i = 0; i < bpf_map__max_entries(skel->maps.arraymap1); i++) {
 		err = bpf_map_lookup_elem(map_fd, &i, &val);
-		if (CHECK(err, "map_lookup", "map_lookup failed\n"))
+		if (!ASSERT_OK(err, "map_lookup"))
 			goto out;
-		if (CHECK(i != val, "invalid_val",
-			  "got value %llu expected %u\n", val, i))
+		if (!ASSERT_EQ(i, val, "invalid_val"))
 			goto out;
 	}
 
@@ -888,16 +838,14 @@ static void test_bpf_percpu_array_map(void)
 	int len;
 
 	skel = bpf_iter_bpf_percpu_array_map__open();
-	if (CHECK(!skel, "bpf_iter_bpf_percpu_array_map__open",
-		  "skeleton open failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__open"))
 		return;
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
 	val = malloc(8 * bpf_num_possible_cpus());
 
 	err = bpf_iter_bpf_percpu_array_map__load(skel);
-	if (CHECK(!skel, "bpf_iter_bpf_percpu_array_map__load",
-		  "skeleton load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_percpu_array_map__load"))
 		goto out;
 
 	/* update map values here */
@@ -911,7 +859,7 @@ static void test_bpf_percpu_array_map(void)
 		}
 
 		err = bpf_map_update_elem(map_fd, &i, val, BPF_ANY);
-		if (CHECK(err, "map_update", "map_update failed\n"))
+		if (!ASSERT_OK(err, "map_update"))
 			goto out;
 	}
 
@@ -924,7 +872,7 @@ static void test_bpf_percpu_array_map(void)
 		goto out;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	/* do some tests */
@@ -934,13 +882,9 @@ static void test_bpf_percpu_array_map(void)
 		goto close_iter;
 
 	/* test results */
-	if (CHECK(skel->bss->key_sum != expected_key,
-		  "key_sum", "got %u expected %u\n",
-		  skel->bss->key_sum, expected_key))
+	if (!ASSERT_EQ(skel->bss->key_sum, expected_key, "key_sum"))
 		goto close_iter;
-	if (CHECK(skel->bss->val_sum != expected_val,
-		  "val_sum", "got %u expected %u\n",
-		  skel->bss->val_sum, expected_val))
+	if (!ASSERT_EQ(skel->bss->val_sum, expected_val, "val_sum"))
 		goto close_iter;
 
 close_iter:
@@ -965,17 +909,16 @@ static void test_bpf_sk_storage_delete(void)
 	char buf[64];
 
 	skel = bpf_iter_bpf_sk_storage_helpers__open_and_load();
-	if (CHECK(!skel, "bpf_iter_bpf_sk_storage_helpers__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_sk_storage_helpers__open_and_load"))
 		return;
 
 	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
 
 	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (CHECK(sock_fd < 0, "socket", "errno: %d\n", errno))
+	if (!ASSERT_GE(sock_fd, 0, "socket"))
 		goto out;
 	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
-	if (CHECK(err, "map_update", "map_update failed\n"))
+	if (!ASSERT_OK(err, "map_update"))
 		goto out;
 
 	memset(&linfo, 0, sizeof(linfo));
@@ -988,7 +931,7 @@ static void test_bpf_sk_storage_delete(void)
 		goto out;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	/* do some tests */
@@ -1026,22 +969,21 @@ static void test_bpf_sk_storage_get(void)
 	int sock_fd = -1;
 
 	skel = bpf_iter_bpf_sk_storage_helpers__open_and_load();
-	if (CHECK(!skel, "bpf_iter_bpf_sk_storage_helpers__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_sk_storage_helpers__open_and_load"))
 		return;
 
 	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (CHECK(sock_fd < 0, "socket", "errno: %d\n", errno))
+	if (!ASSERT_GE(sock_fd, 0, "socket"))
 		goto out;
 
 	err = listen(sock_fd, 1);
-	if (CHECK(err != 0, "listen", "errno: %d\n", errno))
+	if (!ASSERT_OK(err, "listen"))
 		goto close_socket;
 
 	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
 
 	err = bpf_map_update_elem(map_fd, &sock_fd, &val, BPF_NOEXIST);
-	if (CHECK(err, "bpf_map_update_elem", "map_update_failed\n"))
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
 		goto close_socket;
 
 	do_dummy_read(skel->progs.fill_socket_owner);
@@ -1077,15 +1019,14 @@ static void test_bpf_sk_storage_map(void)
 	char buf[64];
 
 	skel = bpf_iter_bpf_sk_storage_map__open_and_load();
-	if (CHECK(!skel, "bpf_iter_bpf_sk_storage_map__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_sk_storage_map__open_and_load"))
 		return;
 
 	map_fd = bpf_map__fd(skel->maps.sk_stg_map);
 	num_sockets = ARRAY_SIZE(sock_fd);
 	for (i = 0; i < num_sockets; i++) {
 		sock_fd[i] = socket(AF_INET6, SOCK_STREAM, 0);
-		if (CHECK(sock_fd[i] < 0, "socket", "errno: %d\n", errno))
+		if (!ASSERT_GE(sock_fd[i], 0, "socket"))
 			goto out;
 
 		val = i + 1;
@@ -1093,7 +1034,7 @@ static void test_bpf_sk_storage_map(void)
 
 		err = bpf_map_update_elem(map_fd, &sock_fd[i], &val,
 					  BPF_NOEXIST);
-		if (CHECK(err, "map_update", "map_update failed\n"))
+		if (!ASSERT_OK(err, "map_update"))
 			goto out;
 	}
 
@@ -1106,7 +1047,7 @@ static void test_bpf_sk_storage_map(void)
 		goto out;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	/* do some tests */
@@ -1116,14 +1057,10 @@ static void test_bpf_sk_storage_map(void)
 		goto close_iter;
 
 	/* test results */
-	if (CHECK(skel->bss->ipv6_sk_count != num_sockets,
-		  "ipv6_sk_count", "got %u expected %u\n",
-		  skel->bss->ipv6_sk_count, num_sockets))
+	if (!ASSERT_EQ(skel->bss->ipv6_sk_count, num_sockets, "ipv6_sk_count"))
 		goto close_iter;
 
-	if (CHECK(skel->bss->val_sum != expected_val,
-		  "val_sum", "got %u expected %u\n",
-		  skel->bss->val_sum, expected_val))
+	if (!ASSERT_EQ(skel->bss->val_sum, expected_val, "val_sum"))
 		goto close_iter;
 
 close_iter:
@@ -1146,8 +1083,7 @@ static void test_rdonly_buf_out_of_bound(void)
 	struct bpf_link *link;
 
 	skel = bpf_iter_test_kern5__open_and_load();
-	if (CHECK(!skel, "bpf_iter_test_kern5__open_and_load",
-		  "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_test_kern5__open_and_load"))
 		return;
 
 	memset(&linfo, 0, sizeof(linfo));
@@ -1166,8 +1102,7 @@ static void test_buf_neg_offset(void)
 	struct bpf_iter_test_kern6 *skel;
 
 	skel = bpf_iter_test_kern6__open_and_load();
-	if (CHECK(skel, "bpf_iter_test_kern6__open_and_load",
-		  "skeleton open_and_load unexpected success\n"))
+	if (!ASSERT_ERR_PTR(skel, "bpf_iter_test_kern6__open_and_load"))
 		bpf_iter_test_kern6__destroy(skel);
 }
 
@@ -1199,13 +1134,13 @@ static void test_task_vma(void)
 	char maps_path[64];
 
 	skel = bpf_iter_task_vma__open();
-	if (CHECK(!skel, "bpf_iter_task_vma__open", "skeleton open failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
 		return;
 
 	skel->bss->pid = getpid();
 
 	err = bpf_iter_task_vma__load(skel);
-	if (CHECK(err, "bpf_iter_task_vma__load", "skeleton load failed\n"))
+	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
 		goto out;
 
 	skel->links.proc_maps = bpf_program__attach_iter(
@@ -1217,7 +1152,7 @@ static void test_task_vma(void)
 	}
 
 	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.proc_maps));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto out;
 
 	/* Read CMP_BUFFER_SIZE (1kB) from bpf_iter. Read in small chunks
@@ -1229,7 +1164,7 @@ static void test_task_vma(void)
 					  MIN(read_size, CMP_BUFFER_SIZE - len));
 		if (!err)
 			break;
-		if (CHECK(err < 0, "read_iter_fd", "read_iter_fd failed\n"))
+		if (!ASSERT_GE(err, 0, "read_iter_fd"))
 			goto out;
 		len += err;
 	}
@@ -1237,18 +1172,17 @@ static void test_task_vma(void)
 	/* read CMP_BUFFER_SIZE (1kB) from /proc/pid/maps */
 	snprintf(maps_path, 64, "/proc/%u/maps", skel->bss->pid);
 	proc_maps_fd = open(maps_path, O_RDONLY);
-	if (CHECK(proc_maps_fd < 0, "open_proc_maps", "open_proc_maps failed\n"))
+	if (!ASSERT_GE(proc_maps_fd, 0, "open_proc_maps"))
 		goto out;
 	err = read_fd_into_buffer(proc_maps_fd, proc_maps_output, CMP_BUFFER_SIZE);
-	if (CHECK(err < 0, "read_prog_maps_fd", "read_prog_maps_fd failed\n"))
+	if (!ASSERT_GE(err, 0, "read_prog_maps_fd"))
 		goto out;
 
 	/* strip and compare the first line of the two files */
 	str_strip_first_line(task_vma_output);
 	str_strip_first_line(proc_maps_output);
 
-	CHECK(strcmp(task_vma_output, proc_maps_output), "compare_output",
-	      "found mismatch\n");
+	ASSERT_STREQ(task_vma_output, proc_maps_output, "compare_output");
 out:
 	close(proc_maps_fd);
 	close(iter_fd);
-- 
2.32.0


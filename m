Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96E5E9884
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiIZEvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiIZEvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4DB2655A
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:43 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbVbM5X2yzHtm4;
        Mon, 26 Sep 2022 12:46:55 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:40 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 01/11] bpf/selftests: convert sockmap_basic test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:01 +0800
Message-ID: <1664169131-32405-2-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
References: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert the selftest to use the preferred ASSERT_* macros instead of the
deprecated CHECK().

Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 87 ++++++++--------------
 1 file changed, 33 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index cec5c08..c0d1dd0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -27,21 +27,21 @@ static int connected_socket_v4(void)
 	int s, repair, err;
 
 	s = socket(AF_INET, SOCK_STREAM, 0);
-	if (CHECK_FAIL(s == -1))
+	if (!ASSERT_GE(s, 0, "socket"))
 		goto error;
 
 	repair = TCP_REPAIR_ON;
 	err = setsockopt(s, SOL_TCP, TCP_REPAIR, &repair, sizeof(repair));
-	if (CHECK_FAIL(err))
+	if (!ASSERT_OK(err, "setsockopt(TCP_REPAIR)"))
 		goto error;
 
 	err = connect(s, (struct sockaddr *)&addr, len);
-	if (CHECK_FAIL(err))
+	if (!ASSERT_OK(err, "connect"))
 		goto error;
 
 	repair = TCP_REPAIR_OFF_NO_WP;
 	err = setsockopt(s, SOL_TCP, TCP_REPAIR, &repair, sizeof(repair));
-	if (CHECK_FAIL(err))
+	if (!ASSERT_OK(err, "setsockopt(TCP_REPAIR)"))
 		goto error;
 
 	return s;
@@ -54,7 +54,7 @@ static int connected_socket_v4(void)
 static void compare_cookies(struct bpf_map *src, struct bpf_map *dst)
 {
 	__u32 i, max_entries = bpf_map__max_entries(src);
-	int err, duration = 0, src_fd, dst_fd;
+	int err, src_fd, dst_fd;
 
 	src_fd = bpf_map__fd(src);
 	dst_fd = bpf_map__fd(dst);
@@ -65,20 +65,18 @@ static void compare_cookies(struct bpf_map *src, struct bpf_map *dst)
 		err = bpf_map_lookup_elem(src_fd, &i, &src_cookie);
 		if (err && errno == ENOENT) {
 			err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
-			CHECK(!err, "map_lookup_elem(dst)", "element %u not deleted\n", i);
-			CHECK(err && errno != ENOENT, "map_lookup_elem(dst)", "%s\n",
-			      strerror(errno));
+			ASSERT_ERR(err, "map_lookup_elem(dst)");
+			ASSERT_OK(err && errno != ENOENT, "map_lookup_elem(dst)");
 			continue;
 		}
-		if (CHECK(err, "lookup_elem(src)", "%s\n", strerror(errno)))
+		if (!ASSERT_OK(err, "lookup_elem(src)"))
 			continue;
 
 		err = bpf_map_lookup_elem(dst_fd, &i, &dst_cookie);
-		if (CHECK(err, "lookup_elem(dst)", "%s\n", strerror(errno)))
+		if (!ASSERT_OK(err, "lookup_elem(dst)"))
 			continue;
 
-		CHECK(dst_cookie != src_cookie, "cookie mismatch",
-		      "%llu != %llu (pos %u)\n", dst_cookie, src_cookie, i);
+		ASSERT_EQ(dst_cookie, src_cookie, "cookie mismatch");
 	}
 }
 
@@ -89,20 +87,16 @@ static void test_sockmap_create_update_free(enum bpf_map_type map_type)
 	int s, map, err;
 
 	s = connected_socket_v4();
-	if (CHECK_FAIL(s < 0))
+	if (!ASSERT_GE(s, 0, "connected_socket_v4"))
 		return;
 
 	map = bpf_map_create(map_type, NULL, sizeof(int), sizeof(int), 1, NULL);
-	if (CHECK_FAIL(map < 0)) {
-		perror("bpf_cmap_create");
+	if (!ASSERT_GE(map, 0, "bpf_map_create"))
 		goto out;
-	}
 
 	err = bpf_map_update_elem(map, &zero, &s, BPF_NOEXIST);
-	if (CHECK_FAIL(err)) {
-		perror("bpf_map_update");
+	if (!ASSERT_OK(err, "bpf_map_update"))
 		goto out;
-	}
 
 out:
 	close(map);
@@ -115,32 +109,26 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
 	int err, map, verdict;
 
 	skel = test_skmsg_load_helpers__open_and_load();
-	if (CHECK_FAIL(!skel)) {
-		perror("test_skmsg_load_helpers__open_and_load");
+	if (!ASSERT_OK_PTR(skel, "test_skmsg_load_helpers__open_and_load"))
 		return;
-	}
 
 	verdict = bpf_program__fd(skel->progs.prog_msg_verdict);
 	map = bpf_map__fd(skel->maps.sock_map);
 
 	err = bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
-	if (CHECK_FAIL(err)) {
-		perror("bpf_prog_attach");
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
-	}
 
 	err = bpf_prog_detach2(verdict, map, BPF_SK_MSG_VERDICT);
-	if (CHECK_FAIL(err)) {
-		perror("bpf_prog_detach2");
+	if (!ASSERT_OK(err, "bpf_prog_detach2"))
 		goto out;
-	}
 out:
 	test_skmsg_load_helpers__destroy(skel);
 }
 
 static void test_sockmap_update(enum bpf_map_type map_type)
 {
-	int err, prog, src, duration = 0;
+	int err, prog, src;
 	struct test_sockmap_update *skel;
 	struct bpf_map *dst_map;
 	const __u32 zero = 0;
@@ -153,11 +141,11 @@ static void test_sockmap_update(enum bpf_map_type map_type)
 	__s64 sk;
 
 	sk = connected_socket_v4();
-	if (CHECK(sk == -1, "connected_socket_v4", "cannot connect\n"))
+	if (!ASSERT_NEQ(sk, -1, "connected_socket_v4"))
 		return;
 
 	skel = test_sockmap_update__open_and_load();
-	if (CHECK(!skel, "open_and_load", "cannot load skeleton\n"))
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		goto close_sk;
 
 	prog = bpf_program__fd(skel->progs.copy_sock_map);
@@ -168,7 +156,7 @@ static void test_sockmap_update(enum bpf_map_type map_type)
 		dst_map = skel->maps.dst_sock_hash;
 
 	err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
-	if (CHECK(err, "update_elem(src)", "errno=%u\n", errno))
+	if (!ASSERT_OK(err, "update_elem(src)"))
 		goto out;
 
 	err = bpf_prog_test_run_opts(prog, &topts);
@@ -188,17 +176,16 @@ static void test_sockmap_update(enum bpf_map_type map_type)
 static void test_sockmap_invalid_update(void)
 {
 	struct test_sockmap_invalid_update *skel;
-	int duration = 0;
 
 	skel = test_sockmap_invalid_update__open_and_load();
-	if (CHECK(skel, "open_and_load", "verifier accepted map_update\n"))
+	if (!ASSERT_NULL(skel, "open_and_load"))
 		test_sockmap_invalid_update__destroy(skel);
 }
 
 static void test_sockmap_copy(enum bpf_map_type map_type)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
-	int err, len, src_fd, iter_fd, duration = 0;
+	int err, len, src_fd, iter_fd;
 	union bpf_iter_link_info linfo = {};
 	__u32 i, num_sockets, num_elems;
 	struct bpf_iter_sockmap *skel;
@@ -208,7 +195,7 @@ static void test_sockmap_copy(enum bpf_map_type map_type)
 	char buf[64];
 
 	skel = bpf_iter_sockmap__open_and_load();
-	if (CHECK(!skel, "bpf_iter_sockmap__open_and_load", "skeleton open_and_load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "bpf_iter_sockmap__open_and_load"))
 		return;
 
 	if (map_type == BPF_MAP_TYPE_SOCKMAP) {
@@ -222,7 +209,7 @@ static void test_sockmap_copy(enum bpf_map_type map_type)
 	}
 
 	sock_fd = calloc(num_sockets, sizeof(*sock_fd));
-	if (CHECK(!sock_fd, "calloc(sock_fd)", "failed to allocate\n"))
+	if (!ASSERT_OK_PTR(sock_fd, "calloc(sock_fd)"))
 		goto out;
 
 	for (i = 0; i < num_sockets; i++)
@@ -232,11 +219,11 @@ static void test_sockmap_copy(enum bpf_map_type map_type)
 
 	for (i = 0; i < num_sockets; i++) {
 		sock_fd[i] = connected_socket_v4();
-		if (CHECK(sock_fd[i] == -1, "connected_socket_v4", "cannot connect\n"))
+		if (!ASSERT_NEQ(sock_fd[i], -1, "connected_socket_v4"))
 			goto out;
 
 		err = bpf_map_update_elem(src_fd, &i, &sock_fd[i], BPF_NOEXIST);
-		if (CHECK(err, "map_update", "failed: %s\n", strerror(errno)))
+		if (!ASSERT_OK(err, "map_update"))
 			goto out;
 	}
 
@@ -248,22 +235,20 @@ static void test_sockmap_copy(enum bpf_map_type map_type)
 		goto out;
 
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
-	if (CHECK(iter_fd < 0, "create_iter", "create_iter failed\n"))
+	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
-	if (CHECK(len < 0, "read", "failed: %s\n", strerror(errno)))
+	if (!ASSERT_GE(len, 0, "read"))
 		goto close_iter;
 
 	/* test results */
-	if (CHECK(skel->bss->elems != num_elems, "elems", "got %u expected %u\n",
-		  skel->bss->elems, num_elems))
+	if (!ASSERT_EQ(skel->bss->elems, num_elems, "elems"))
 		goto close_iter;
 
-	if (CHECK(skel->bss->socks != num_sockets, "socks", "got %u expected %u\n",
-		  skel->bss->socks, num_sockets))
+	if (!ASSERT_EQ(skel->bss->socks, num_sockets, "socks"))
 		goto close_iter;
 
 	compare_cookies(src, skel->maps.dst);
@@ -288,28 +273,22 @@ static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
 	int err, map, verdict;
 
 	skel = test_sockmap_skb_verdict_attach__open_and_load();
-	if (CHECK_FAIL(!skel)) {
-		perror("test_sockmap_skb_verdict_attach__open_and_load");
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		return;
-	}
 
 	verdict = bpf_program__fd(skel->progs.prog_skb_verdict);
 	map = bpf_map__fd(skel->maps.sock_map);
 
 	err = bpf_prog_attach(verdict, map, first, 0);
-	if (CHECK_FAIL(err)) {
-		perror("bpf_prog_attach");
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
-	}
 
 	err = bpf_prog_attach(verdict, map, second, 0);
 	ASSERT_EQ(err, -EBUSY, "prog_attach_fail");
 
 	err = bpf_prog_detach2(verdict, map, first);
-	if (CHECK_FAIL(err)) {
-		perror("bpf_prog_detach2");
+	if (!ASSERT_OK(err, "bpf_prog_detach2"))
 		goto out;
-	}
 out:
 	test_sockmap_skb_verdict_attach__destroy(skel);
 }
-- 
1.8.3.1


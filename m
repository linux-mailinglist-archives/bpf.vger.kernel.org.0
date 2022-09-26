Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE4D5E988B
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIZEvx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiIZEvw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5B26565
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:50 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MbVc727Vlz1P71s;
        Mon, 26 Sep 2022 12:47:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:47 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 08/11] bpf/selftests: convert tcp_hdr_options test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:08 +0800
Message-ID: <1664169131-32405-9-git-send-email-wangyufen@huawei.com>
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
 .../selftests/bpf/prog_tests/tcp_hdr_options.c     | 80 ++++++++--------------
 1 file changed, 28 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
index f24436d..617bbce 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
@@ -42,13 +42,10 @@ struct sk_fds {
 
 static int create_netns(void)
 {
-	if (CHECK(unshare(CLONE_NEWNET), "create netns",
-		  "unshare(CLONE_NEWNET): %s (%d)",
-		  strerror(errno), errno))
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
 		return -1;
 
-	if (CHECK(system("ip link set dev lo up"), "run ip cmd",
-		  "failed to bring lo link up\n"))
+	if (!ASSERT_OK(system("ip link set dev lo up"), "run ip cmd"))
 		return -1;
 
 	return 0;
@@ -80,16 +77,12 @@ static int sk_fds_shutdown(struct sk_fds *sk_fds)
 
 	shutdown(sk_fds->active_fd, SHUT_WR);
 	ret = read(sk_fds->passive_fd, &abyte, sizeof(abyte));
-	if (CHECK(ret != 0, "read-after-shutdown(passive_fd):",
-		  "ret:%d %s (%d)\n",
-		  ret, strerror(errno), errno))
+	if (!ASSERT_EQ(ret, 0, "read-after-shutdown(passive_fd):"))
 		return -1;
 
 	shutdown(sk_fds->passive_fd, SHUT_WR);
 	ret = read(sk_fds->active_fd, &abyte, sizeof(abyte));
-	if (CHECK(ret != 0, "read-after-shutdown(active_fd):",
-		  "ret:%d %s (%d)\n",
-		  ret, strerror(errno), errno))
+	if (!ASSERT_EQ(ret, 0, "read-after-shutdown(active_fd):"))
 		return -1;
 
 	return 0;
@@ -102,8 +95,7 @@ static int sk_fds_connect(struct sk_fds *sk_fds, bool fast_open)
 	socklen_t len;
 
 	sk_fds->srv_fd = start_server(AF_INET6, SOCK_STREAM, LO_ADDR6, 0, 0);
-	if (CHECK(sk_fds->srv_fd == -1, "start_server", "%s (%d)\n",
-		  strerror(errno), errno))
+	if (!ASSERT_NEQ(sk_fds->srv_fd, -1, "start_server"))
 		goto error;
 
 	if (fast_open)
@@ -112,28 +104,25 @@ static int sk_fds_connect(struct sk_fds *sk_fds, bool fast_open)
 	else
 		sk_fds->active_fd = connect_to_fd(sk_fds->srv_fd, 0);
 
-	if (CHECK_FAIL(sk_fds->active_fd == -1)) {
+	if (!ASSERT_NEQ(sk_fds->active_fd, -1, "")) {
 		close(sk_fds->srv_fd);
 		goto error;
 	}
 
 	len = sizeof(addr6);
-	if (CHECK(getsockname(sk_fds->srv_fd, (struct sockaddr *)&addr6,
-			      &len), "getsockname(srv_fd)", "%s (%d)\n",
-		  strerror(errno), errno))
+	if (!ASSERT_OK(getsockname(sk_fds->srv_fd, (struct sockaddr *)&addr6,
+				   &len), "getsockname(srv_fd)"))
 		goto error_close;
 	sk_fds->passive_lport = ntohs(addr6.sin6_port);
 
 	len = sizeof(addr6);
-	if (CHECK(getsockname(sk_fds->active_fd, (struct sockaddr *)&addr6,
-			      &len), "getsockname(active_fd)", "%s (%d)\n",
-		  strerror(errno), errno))
+	if (!ASSERT_OK(getsockname(sk_fds->active_fd, (struct sockaddr *)&addr6,
+				   &len), "getsockname(active_fd)"))
 		goto error_close;
 	sk_fds->active_lport = ntohs(addr6.sin6_port);
 
 	sk_fds->passive_fd = accept(sk_fds->srv_fd, NULL, 0);
-	if (CHECK(sk_fds->passive_fd == -1, "accept(srv_fd)", "%s (%d)\n",
-		  strerror(errno), errno))
+	if (!ASSERT_NEQ(sk_fds->passive_fd, -1, "accept(srv_fd)"))
 		goto error_close;
 
 	if (fast_open) {
@@ -141,8 +130,7 @@ static int sk_fds_connect(struct sk_fds *sk_fds, bool fast_open)
 		int ret;
 
 		ret = read(sk_fds->passive_fd, bytes_in, sizeof(bytes_in));
-		if (CHECK(ret != sizeof(fast), "read fastopen syn data",
-			  "expected=%lu actual=%d\n", sizeof(fast), ret)) {
+		if (!ASSERT_EQ(ret, sizeof(fast), "read fastopen syn data")) {
 			close(sk_fds->passive_fd);
 			goto error_close;
 		}
@@ -163,8 +151,7 @@ static int check_hdr_opt(const struct bpf_test_option *exp,
 			 const struct bpf_test_option *act,
 			 const char *hdr_desc)
 {
-	if (CHECK(memcmp(exp, act, sizeof(*exp)),
-		  "expected-vs-actual", "unexpected %s\n", hdr_desc)) {
+	if (!ASSERT_OK(memcmp(exp, act, sizeof(*exp)), hdr_desc)) {
 		print_option(exp, "expected: ");
 		print_option(act, "  actual: ");
 		return -1;
@@ -178,13 +165,11 @@ static int check_hdr_stg(const struct hdr_stg *exp, int fd,
 {
 	struct hdr_stg act;
 
-	if (CHECK(bpf_map_lookup_elem(hdr_stg_map_fd, &fd, &act),
-		  "map_lookup(hdr_stg_map_fd)", "%s %s (%d)\n",
-		  stg_desc, strerror(errno), errno))
+	if (!ASSERT_OK(bpf_map_lookup_elem(hdr_stg_map_fd, &fd, &act),
+		  "map_lookup(hdr_stg_map_fd)"))
 		return -1;
 
-	if (CHECK(memcmp(exp, &act, sizeof(*exp)),
-		  "expected-vs-actual", "unexpected %s\n", stg_desc)) {
+	if (!ASSERT_OK(memcmp(exp, &act, sizeof(*exp)), stg_desc)) {
 		print_hdr_stg(exp, "expected: ");
 		print_hdr_stg(&act, "  actual: ");
 		return -1;
@@ -228,9 +213,8 @@ static void check_hdr_and_close_fds(struct sk_fds *sk_fds)
 	if (sk_fds_shutdown(sk_fds))
 		goto check_linum;
 
-	if (CHECK(expected_inherit_cb_flags != skel->bss->inherit_cb_flags,
-		  "Unexpected inherit_cb_flags", "0x%x != 0x%x\n",
-		  skel->bss->inherit_cb_flags, expected_inherit_cb_flags))
+	if (!ASSERT_EQ(expected_inherit_cb_flags, skel->bss->inherit_cb_flags,
+		       "inherit_cb_flags"))
 		goto check_linum;
 
 	if (check_hdr_stg(&exp_passive_hdr_stg, sk_fds->passive_fd,
@@ -257,7 +241,7 @@ static void check_hdr_and_close_fds(struct sk_fds *sk_fds)
 		      "active_fin_in");
 
 check_linum:
-	CHECK_FAIL(check_error_linum(sk_fds));
+	ASSERT_FALSE(check_error_linum(sk_fds), "check_error_linum");
 	sk_fds_close(sk_fds);
 }
 
@@ -497,26 +481,20 @@ static void misc(void)
 		/* MSG_EOR to ensure skb will not be combined */
 		ret = send(sk_fds.active_fd, send_msg, sizeof(send_msg),
 			   MSG_EOR);
-		if (CHECK(ret != sizeof(send_msg), "send(msg)", "ret:%d\n",
-			  ret))
+		if (!ASSERT_EQ(ret, sizeof(send_msg), "send(msg)"))
 			goto check_linum;
 
 		ret = read(sk_fds.passive_fd, recv_msg, sizeof(recv_msg));
-		if (CHECK(ret != sizeof(send_msg), "read(msg)", "ret:%d\n",
-			  ret))
+		if (ASSERT_EQ(ret, sizeof(send_msg), "read(msg)"))
 			goto check_linum;
 	}
 
 	if (sk_fds_shutdown(&sk_fds))
 		goto check_linum;
 
-	CHECK(misc_skel->bss->nr_syn != 1, "unexpected nr_syn",
-	      "expected (1) != actual (%u)\n",
-		misc_skel->bss->nr_syn);
+	ASSERT_EQ(misc_skel->bss->nr_syn, 1, "unexpected nr_syn");
 
-	CHECK(misc_skel->bss->nr_data != nr_data, "unexpected nr_data",
-	      "expected (%u) != actual (%u)\n",
-	      nr_data, misc_skel->bss->nr_data);
+	ASSERT_EQ(misc_skel->bss->nr_data, nr_data, "unexpected nr_data");
 
 	/* The last ACK may have been delayed, so it is either 1 or 2. */
 	CHECK(misc_skel->bss->nr_pure_ack != 1 &&
@@ -525,12 +503,10 @@ static void misc(void)
 	      "expected (1 or 2) != actual (%u)\n",
 		misc_skel->bss->nr_pure_ack);
 
-	CHECK(misc_skel->bss->nr_fin != 1, "unexpected nr_fin",
-	      "expected (1) != actual (%u)\n",
-	      misc_skel->bss->nr_fin);
+	ASSERT_EQ(misc_skel->bss->nr_fin, 1, "unexpected nr_fin");
 
 check_linum:
-	CHECK_FAIL(check_error_linum(&sk_fds));
+	ASSERT_FALSE(check_error_linum(&sk_fds), "check_error_linum");
 	sk_fds_close(&sk_fds);
 	bpf_link__destroy(link);
 }
@@ -555,15 +531,15 @@ void test_tcp_hdr_options(void)
 	int i;
 
 	skel = test_tcp_hdr_options__open_and_load();
-	if (CHECK(!skel, "open and load skel", "failed"))
+	if (!ASSERT_OK_PTR(skel, "open and load skel"))
 		return;
 
 	misc_skel = test_misc_tcp_hdr_options__open_and_load();
-	if (CHECK(!misc_skel, "open and load misc test skel", "failed"))
+	if (!ASSERT_OK_PTR(misc_skel, "open and load misc test skel"))
 		goto skel_destroy;
 
 	cg_fd = test__join_cgroup(CG_NAME);
-	if (CHECK_FAIL(cg_fd < 0))
+	if (ASSERT_GE(cg_fd, 0, "join_cgroup"))
 		goto skel_destroy;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-- 
1.8.3.1


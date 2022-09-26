Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074685E988D
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiIZEv4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiIZEvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E32B25D
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:52 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbVdh3gMwzpVS4;
        Mon, 26 Sep 2022 12:48:56 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:49 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 10/11] bpf/selftests: convert tcpbpf_user test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:10 +0800
Message-ID: <1664169131-32405-11-git-send-email-wangyufen@huawei.com>
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
 .../testing/selftests/bpf/prog_tests/tcpbpf_user.c | 32 ++++++++--------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
index 87923d2..7e8fe1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
@@ -8,8 +8,6 @@
 #define LO_ADDR6 "::1"
 #define CG_NAME "/tcpbpf-user-test"
 
-static __u32 duration;
-
 static void verify_result(struct tcpbpf_globals *result)
 {
 	__u32 expected_events = ((1 << BPF_SOCK_OPS_TIMEOUT_INIT) |
@@ -22,9 +20,7 @@ static void verify_result(struct tcpbpf_globals *result)
 				 (1 << BPF_SOCK_OPS_TCP_LISTEN_CB));
 
 	/* check global map */
-	CHECK(expected_events != result->event_map, "event_map",
-	      "unexpected event_map: actual 0x%08x != expected 0x%08x\n",
-	      result->event_map, expected_events);
+	ASSERT_EQ(expected_events, result->event_map, "event_map");
 
 	ASSERT_EQ(result->bytes_received, 501, "bytes_received");
 	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
@@ -56,18 +52,15 @@ static void run_test(struct tcpbpf_globals *result)
 	int i, rv;
 
 	listen_fd = start_server(AF_INET6, SOCK_STREAM, LO_ADDR6, 0, 0);
-	if (CHECK(listen_fd == -1, "start_server", "listen_fd:%d errno:%d\n",
-		  listen_fd, errno))
+	if (!ASSERT_NEQ(listen_fd, -1, "start_server"))
 		goto done;
 
 	cli_fd = connect_to_fd(listen_fd, 0);
-	if (CHECK(cli_fd == -1, "connect_to_fd(listen_fd)",
-		  "cli_fd:%d errno:%d\n", cli_fd, errno))
+	if (!ASSERT_NEQ(cli_fd, -1, "connect_to_fd(listen_fd)"))
 		goto done;
 
 	accept_fd = accept(listen_fd, NULL, NULL);
-	if (CHECK(accept_fd == -1, "accept(listen_fd)",
-		  "accept_fd:%d errno:%d\n", accept_fd, errno))
+	if (!ASSERT_NEQ(accept_fd, -1, "accept(listen_fd)"))
 		goto done;
 
 	/* Send 1000B of '+'s from cli_fd -> accept_fd */
@@ -75,11 +68,11 @@ static void run_test(struct tcpbpf_globals *result)
 		buf[i] = '+';
 
 	rv = send(cli_fd, buf, 1000, 0);
-	if (CHECK(rv != 1000, "send(cli_fd)", "rv:%d errno:%d\n", rv, errno))
+	if (!ASSERT_EQ(rv, 1000, "send(cli_fd)"))
 		goto done;
 
 	rv = recv(accept_fd, buf, 1000, 0);
-	if (CHECK(rv != 1000, "recv(accept_fd)", "rv:%d errno:%d\n", rv, errno))
+	if (!ASSERT_EQ(rv, 1000, "recv(accept_fd)"))
 		goto done;
 
 	/* Send 500B of '.'s from accept_fd ->cli_fd */
@@ -87,11 +80,11 @@ static void run_test(struct tcpbpf_globals *result)
 		buf[i] = '.';
 
 	rv = send(accept_fd, buf, 500, 0);
-	if (CHECK(rv != 500, "send(accept_fd)", "rv:%d errno:%d\n", rv, errno))
+	if (!ASSERT_EQ(rv, 500, "send(accept_fd)"))
 		goto done;
 
 	rv = recv(cli_fd, buf, 500, 0);
-	if (CHECK(rv != 500, "recv(cli_fd)", "rv:%d errno:%d\n", rv, errno))
+	if (!ASSERT_EQ(rv, 500, "recv(cli_fd)"))
 		goto done;
 
 	/*
@@ -100,12 +93,12 @@ static void run_test(struct tcpbpf_globals *result)
 	 */
 	shutdown(accept_fd, SHUT_WR);
 	err = recv(cli_fd, buf, 1, 0);
-	if (CHECK(err, "recv(cli_fd) for fin", "err:%d errno:%d\n", err, errno))
+	if (!ASSERT_OK(err, "recv(cli_fd) for fin"))
 		goto done;
 
 	shutdown(cli_fd, SHUT_WR);
 	err = recv(accept_fd, buf, 1, 0);
-	CHECK(err, "recv(accept_fd) for fin", "err:%d errno:%d\n", err, errno);
+	ASSERT_OK(err, "recv(accept_fd) for fin");
 done:
 	if (accept_fd != -1)
 		close(accept_fd);
@@ -124,12 +117,11 @@ void test_tcpbpf_user(void)
 	int cg_fd = -1;
 
 	skel = test_tcpbpf_kern__open_and_load();
-	if (CHECK(!skel, "open and load skel", "failed"))
+	if (!ASSERT_OK_PTR(skel, "open and load skel"))
 		return;
 
 	cg_fd = test__join_cgroup(CG_NAME);
-	if (CHECK(cg_fd < 0, "test__join_cgroup(" CG_NAME ")",
-		  "cg_fd:%d errno:%d", cg_fd, errno))
+	if (!ASSERT_GE(cg_fd, 0, "test__join_cgroup(" CG_NAME ")"))
 		goto err;
 
 	skel->links.bpf_testcb = bpf_program__attach_cgroup(skel->progs.bpf_testcb, cg_fd);
-- 
1.8.3.1


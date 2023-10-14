Return-Path: <bpf+bounces-12218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E27C947A
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A441F21986
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ACC12B77;
	Sat, 14 Oct 2023 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1061096C;
	Sat, 14 Oct 2023 12:04:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCE6AD;
	Sat, 14 Oct 2023 05:04:28 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S726M0fHrzmXL5;
	Sat, 14 Oct 2023 20:01:47 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 14 Oct
 2023 20:04:24 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v6 7/7] selftests/bpf: add tests for verdict skmsg to closed socket
Date: Sat, 14 Oct 2023 20:17:06 +0800
Message-ID: <20231014121706.967988-8-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231014121706.967988-1-liujian56@huawei.com>
References: <20231014121706.967988-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add four tests for verdict skmsg to closed socket in sockmap_basic.c.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 42 +++++++++++++++----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index e7fb1a31bf61..a8b38de0a31a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -476,9 +476,10 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
-static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent, bool is_self)
+static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent, bool is_self,
+				     bool target_shutdown)
 {
-	int key, sent, recvd, recv_fd;
+	int key, sent, recvd, recv_fd, target_fd;
 	int err, map, verdict, s, c0, c1, p0, p1;
 	struct test_sockmap_msg_verdict *skel;
 	char buf[256] = "0123456789";
@@ -522,18 +523,22 @@ static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent, bool is
 		skel->bss->skmsg_redir_flags = BPF_F_INGRESS;
 		if (is_self) {
 			skel->bss->skmsg_redir_key = 0;
+			target_fd = p1;
 			recv_fd = p1;
 		} else {
 			skel->bss->skmsg_redir_key = 1;
+			target_fd = c1;
 			recv_fd = c1;
 		}
 	} else {
 		skel->bss->skmsg_redir_flags = 0;
 		if (is_self) {
 			skel->bss->skmsg_redir_key = 0;
+			target_fd = p1;
 			recv_fd = c1;
 		} else {
 			skel->bss->skmsg_redir_key = 2;
+			target_fd = p0;
 			recv_fd = c0;
 		}
 	}
@@ -546,6 +551,19 @@ static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent, bool is
 	recvd = recv_timeout(recv_fd, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
 	ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(recv_fd)");
 
+	if (target_shutdown) {
+		signal(SIGPIPE, SIG_IGN);
+		close(target_fd);
+		sent = send(p1, &buf, sizeof(buf), 0);
+		if (is_permanent) {
+			ASSERT_EQ(sent, -1, "xsend(p1)");
+			ASSERT_EQ(errno, EPIPE, "xsend(p1)");
+		} else {
+			ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
+		}
+		goto out_close;
+	}
+
 	sent = xsend(p1, &buf, sizeof(buf), 0);
 	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
 	recvd = recv_timeout(recv_fd, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
@@ -600,15 +618,23 @@ void test_sockmap_basic(void)
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap msg_verdict"))
-		test_sockmap_msg_verdict(false, false, false);
+		test_sockmap_msg_verdict(false, false, false, false);
 	if (test__start_subtest("sockmap msg_verdict ingress"))
-		test_sockmap_msg_verdict(true, false, false);
+		test_sockmap_msg_verdict(true, false, false, false);
 	if (test__start_subtest("sockmap msg_verdict permanent"))
-		test_sockmap_msg_verdict(false, true, false);
+		test_sockmap_msg_verdict(false, true, false, false);
 	if (test__start_subtest("sockmap msg_verdict ingress permanent"))
-		test_sockmap_msg_verdict(true, true, false);
+		test_sockmap_msg_verdict(true, true, false, false);
 	if (test__start_subtest("sockmap msg_verdict permanent self"))
-		test_sockmap_msg_verdict(false, true, true);
+		test_sockmap_msg_verdict(false, true, true, false);
 	if (test__start_subtest("sockmap msg_verdict ingress permanent self"))
-		test_sockmap_msg_verdict(true, true, true);
+		test_sockmap_msg_verdict(true, true, true, false);
+	if (test__start_subtest("sockmap msg_verdict permanent shutdown"))
+		test_sockmap_msg_verdict(false, true, false, true);
+	if (test__start_subtest("sockmap msg_verdict ingress permanent shutdown"))
+		test_sockmap_msg_verdict(true, true, false, true);
+	if (test__start_subtest("sockmap msg_verdict shutdown"))
+		test_sockmap_msg_verdict(false, false, false, true);
+	if (test__start_subtest("sockmap msg_verdict ingress shutdown"))
+		test_sockmap_msg_verdict(true, false, false, true);
 }
-- 
2.34.1



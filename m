Return-Path: <bpf+bounces-9144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D936790744
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1DB1C208EF
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00054AD54;
	Sat,  2 Sep 2023 10:04:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF5AD34;
	Sat,  2 Sep 2023 10:04:22 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4210EB;
	Sat,  2 Sep 2023 03:04:18 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rd9Px62PKzNn5F;
	Sat,  2 Sep 2023 18:00:37 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 2 Sep
 2023 18:04:15 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v4 5/7] selftests/bpf: add two skmsg verdict tests for BPF_F_PERMANENT flag
Date: Sat, 2 Sep 2023 18:07:42 +0800
Message-ID: <20230902100744.2687785-6-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230902100744.2687785-1-liujian56@huawei.com>
References: <20230902100744.2687785-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add two tests for BPF_F_PERMANENT flag in sockmap_basic.c.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c    | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 93bf1907abd9..1a29e76fe29f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -476,7 +476,7 @@ static void test_sockmap_skb_verdict_fionread(bool pass_prog)
 		test_sockmap_drop_prog__destroy(drop);
 }
 
-static void test_sockmap_msg_verdict(bool is_ingress)
+static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent)
 {
 	int key, sent, recvd, recv_fd;
 	int err, map, verdict, s, c0, c1, p0, p1;
@@ -528,11 +528,18 @@ static void test_sockmap_msg_verdict(bool is_ingress)
 		skel->bss->skmsg_redir_key = 2;
 	}
 
+	if (is_permanent)
+		skel->bss->skmsg_redir_flags |= BPF_F_PERMANENT;
+
 	sent = xsend(p1, &buf, sizeof(buf), 0);
 	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
 	recvd = recv_timeout(recv_fd, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
 	ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(recv_fd)");
 
+	sent = xsend(p1, &buf, sizeof(buf), 0);
+	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
+	recvd = recv_timeout(recv_fd, &buf, sizeof(buf), SOCK_NONBLOCK, IO_TIMEOUT_SEC);
+	ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(recv_fd)");
 out_close:
 	close(c0);
 	close(p0);
@@ -583,7 +590,11 @@ void test_sockmap_basic(void)
 	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap msg_verdict"))
-		test_sockmap_msg_verdict(false);
+		test_sockmap_msg_verdict(false, false);
 	if (test__start_subtest("sockmap msg_verdict ingress"))
-		test_sockmap_msg_verdict(true);
+		test_sockmap_msg_verdict(true, false);
+	if (test__start_subtest("sockmap msg_verdict permanent"))
+		test_sockmap_msg_verdict(false, true);
+	if (test__start_subtest("sockmap msg_verdict ingress permanent"))
+		test_sockmap_msg_verdict(true, true);
 }
-- 
2.34.1



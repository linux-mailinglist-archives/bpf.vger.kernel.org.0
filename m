Return-Path: <bpf+bounces-13550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 754477DA64A
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 11:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F53FB21574
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C315AEB;
	Sat, 28 Oct 2023 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A9DDCD;
	Sat, 28 Oct 2023 09:52:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD66E3;
	Sat, 28 Oct 2023 02:52:27 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SHZWF2z3NzrT1b;
	Sat, 28 Oct 2023 17:49:29 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 28 Oct
 2023 17:52:25 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v7 6/7] selftests/bpf: add tests for verdict skmsg to itself
Date: Sat, 28 Oct 2023 18:05:51 +0800
Message-ID: <20231028100552.2444158-7-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028100552.2444158-1-liujian56@huawei.com>
References: <20231028100552.2444158-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected

Add tests for verdict skmsg to itself in sockmap_basic.c

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index ef147d73ff47..75107762a86e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -525,7 +525,7 @@ static void test_sockmap_skb_verdict_peek(void)
 	test_sockmap_pass_prog__destroy(pass);
 }
 
-static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent)
+static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent, bool is_self)
 {
 	int key, sent, recvd, recv_fd;
 	int err, map, verdict, s, c0, c1, p0, p1;
@@ -568,13 +568,23 @@ static void test_sockmap_msg_verdict(bool is_ingress, bool is_permanent)
 		goto out_close;
 
 	if (is_ingress) {
-		recv_fd = c1;
 		skel->bss->skmsg_redir_flags = BPF_F_INGRESS;
-		skel->bss->skmsg_redir_key = 1;
+		if (is_self) {
+			skel->bss->skmsg_redir_key = 0;
+			recv_fd = p1;
+		} else {
+			skel->bss->skmsg_redir_key = 1;
+			recv_fd = c1;
+		}
 	} else {
-		recv_fd = c0;
 		skel->bss->skmsg_redir_flags = 0;
-		skel->bss->skmsg_redir_key = 2;
+		if (is_self) {
+			skel->bss->skmsg_redir_key = 0;
+			recv_fd = c1;
+		} else {
+			skel->bss->skmsg_redir_key = 2;
+			recv_fd = c0;
+		}
 	}
 
 	if (is_permanent)
@@ -641,11 +651,15 @@ void test_sockmap_basic(void)
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
 	if (test__start_subtest("sockmap msg_verdict"))
-		test_sockmap_msg_verdict(false, false);
+		test_sockmap_msg_verdict(false, false, false);
 	if (test__start_subtest("sockmap msg_verdict ingress"))
-		test_sockmap_msg_verdict(true, false);
+		test_sockmap_msg_verdict(true, false, false);
 	if (test__start_subtest("sockmap msg_verdict permanent"))
-		test_sockmap_msg_verdict(false, true);
+		test_sockmap_msg_verdict(false, true, false);
 	if (test__start_subtest("sockmap msg_verdict ingress permanent"))
-		test_sockmap_msg_verdict(true, true);
+		test_sockmap_msg_verdict(true, true, false);
+	if (test__start_subtest("sockmap msg_verdict permanent self"))
+		test_sockmap_msg_verdict(false, true, true);
+	if (test__start_subtest("sockmap msg_verdict ingress permanent self"))
+		test_sockmap_msg_verdict(true, true, true);
 }
-- 
2.34.1



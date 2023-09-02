Return-Path: <bpf+bounces-9140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD4579073C
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1536E281403
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B76613B;
	Sat,  2 Sep 2023 10:04:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429705671;
	Sat,  2 Sep 2023 10:04:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA48910F0;
	Sat,  2 Sep 2023 03:04:15 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rd9RB6qr2zVkGY;
	Sat,  2 Sep 2023 18:01:42 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 2 Sep
 2023 18:04:13 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v4 2/7] selftests/bpf: Add txmsg permanently test for sockmap
Date: Sat, 2 Sep 2023 18:07:39 +0800
Message-ID: <20230902100744.2687785-3-liujian56@huawei.com>
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

Add one test for txmsg ingress permanently test for sockmap.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 024a0faafb3b..bf2cef7ae3ae 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -77,6 +77,7 @@ int txmsg_end_push;
 int txmsg_start_pop;
 int txmsg_pop;
 int txmsg_ingress;
+int txmsg_permanent;
 int txmsg_redir_skb;
 int txmsg_ktls_skb;
 int txmsg_ktls_skb_drop;
@@ -107,6 +108,7 @@ static const struct option long_options[] = {
 	{"txmsg_start_pop",  required_argument,	NULL, 'w'},
 	{"txmsg_pop",	     required_argument,	NULL, 'x'},
 	{"txmsg_ingress", no_argument,		&txmsg_ingress, 1 },
+	{"txmsg_permanent", no_argument,	&txmsg_permanent, 1 },
 	{"txmsg_redir_skb", no_argument,	&txmsg_redir_skb, 1 },
 	{"ktls", no_argument,			&ktls, 1 },
 	{"peek", no_argument,			&peek_flag, 1 },
@@ -175,7 +177,7 @@ static void test_reset(void)
 	txmsg_start_push = txmsg_end_push = 0;
 	txmsg_pass = txmsg_drop = txmsg_redir = 0;
 	txmsg_apply = txmsg_cork = 0;
-	txmsg_ingress = txmsg_redir_skb = 0;
+	txmsg_ingress = txmsg_permanent = txmsg_redir_skb = 0;
 	txmsg_ktls_skb = txmsg_ktls_skb_drop = txmsg_ktls_skb_redir = 0;
 	txmsg_omit_skb_parser = 0;
 	skb_use_parser = 0;
@@ -1165,10 +1167,13 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		}
 
 		if (txmsg_ingress) {
-			int in = BPF_F_INGRESS;
+			int txmsg_flag = BPF_F_INGRESS;
+
+			if (txmsg_permanent)
+				txmsg_flag |= BPF_F_PERMANENT;
 
 			i = 0;
-			err = bpf_map_update_elem(map_fd[6], &i, &in, BPF_ANY);
+			err = bpf_map_update_elem(map_fd[6], &i, &txmsg_flag, BPF_ANY);
 			if (err) {
 				fprintf(stderr,
 					"ERROR: bpf_map_update_elem (txmsg_ingress): %d (%s)\n",
@@ -1506,6 +1511,14 @@ static void test_txmsg_ingress_redir(int cgrp, struct sockmap_options *opt)
 	test_send(opt, cgrp);
 }
 
+static void test_txmsg_ingress_redir_permanent(int cgrp, struct sockmap_options *opt)
+{
+	txmsg_pass = txmsg_drop = 0;
+	txmsg_ingress = txmsg_redir = 1;
+	txmsg_permanent = 1;
+	test_send(opt, cgrp);
+}
+
 static void test_txmsg_skb(int cgrp, struct sockmap_options *opt)
 {
 	bool data = opt->data_test;
@@ -1862,6 +1875,7 @@ struct _test test[] = {
 	{"txmsg test redirect wait send mem", test_txmsg_redir_wait_sndmem},
 	{"txmsg test drop", test_txmsg_drop},
 	{"txmsg test ingress redirect", test_txmsg_ingress_redir},
+	{"txmsg test ingress redirect permanent", test_txmsg_ingress_redir_permanent},
 	{"txmsg test skb", test_txmsg_skb},
 	{"txmsg test apply", test_txmsg_apply},
 	{"txmsg test cork", test_txmsg_cork},
-- 
2.34.1



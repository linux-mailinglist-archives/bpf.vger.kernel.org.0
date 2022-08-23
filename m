Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3834E59E89E
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiHWRHc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345018AbiHWRGS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 13:06:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759DD152C64
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 06:35:10 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MBqrW2mXMz1N7MB;
        Tue, 23 Aug 2022 21:31:39 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 21:35:07 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
        <edumazet@google.com>, <davem@davemloft.net>,
        <yoshfuji@linux-ipv6.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrii@kernel.org>, <mykolal@fb.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
        <song@kernel.org>, <yhs@fb.com>, <kpsingh@kernel.org>,
        <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
        <shuah@kernel.org>, <bpf@vger.kernel.org>
CC:     <liujian56@huawei.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add wait send memory test for sockmap redirect
Date:   Tue, 23 Aug 2022 21:37:55 +0800
Message-ID: <20220823133755.314697-3-liujian56@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823133755.314697-1-liujian56@huawei.com>
References: <20220823133755.314697-1-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add one test for wait redirect sock's send memory test for sockmap.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 0fbaccdc8861..95b9b45ad028 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -138,6 +138,7 @@ struct sockmap_options {
 	bool data_test;
 	bool drop_expected;
 	bool check_recved_len;
+	bool tx_wait_mem;
 	int iov_count;
 	int iov_length;
 	int rate;
@@ -578,6 +579,10 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 			sent = sendmsg(fd, &msg, flags);
 
 			if (!drop && sent < 0) {
+				if (opt->tx_wait_mem && errno == EACCES) {
+					errno = 0;
+					goto out_errno;
+				}
 				perror("sendmsg loop error");
 				goto out_errno;
 			} else if (drop && sent >= 0) {
@@ -644,6 +649,15 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 				goto out_errno;
 			}
 
+			if (opt->tx_wait_mem) {
+				FD_ZERO(&w);
+				FD_SET(fd, &w);
+				slct = select(max_fd + 1, NULL, NULL, &w, &timeout);
+				errno = 0;
+				close(fd);
+				goto out_errno;
+			}
+
 			errno = 0;
 			if (peek_flag) {
 				flags |= MSG_PEEK;
@@ -752,6 +766,22 @@ static int sendmsg_test(struct sockmap_options *opt)
 			return err;
 	}
 
+	if (opt->tx_wait_mem) {
+		struct timeval timeout;
+		int rxtx_buf_len = 1024;
+
+		timeout.tv_sec = 3;
+		timeout.tv_usec = 0;
+
+		err = setsockopt(c2, SOL_SOCKET, SO_SNDTIMEO, &timeout, sizeof(struct timeval));
+		err |= setsockopt(c2, SOL_SOCKET, SO_SNDBUFFORCE, &rxtx_buf_len, sizeof(int));
+		err |= setsockopt(p2, SOL_SOCKET, SO_RCVBUFFORCE, &rxtx_buf_len, sizeof(int));
+		if (err) {
+			perror("setsockopt failed()");
+			return errno;
+		}
+	}
+
 	rxpid = fork();
 	if (rxpid == 0) {
 		if (txmsg_pop || txmsg_start_pop)
@@ -788,6 +818,9 @@ static int sendmsg_test(struct sockmap_options *opt)
 		return errno;
 	}
 
+	if (opt->tx_wait_mem)
+		close(c2);
+
 	txpid = fork();
 	if (txpid == 0) {
 		if (opt->sendpage)
@@ -1452,6 +1485,14 @@ static void test_txmsg_redir(int cgrp, struct sockmap_options *opt)
 	test_send(opt, cgrp);
 }
 
+static void test_txmsg_redir_wait_sndmem(int cgrp, struct sockmap_options *opt)
+{
+	txmsg_redir = 1;
+	opt->tx_wait_mem = true;
+	test_send_large(opt, cgrp);
+	opt->tx_wait_mem = false;
+}
+
 static void test_txmsg_drop(int cgrp, struct sockmap_options *opt)
 {
 	txmsg_drop = 1;
@@ -1800,6 +1841,7 @@ static int populate_progs(char *bpf_file)
 struct _test test[] = {
 	{"txmsg test passthrough", test_txmsg_pass},
 	{"txmsg test redirect", test_txmsg_redir},
+	{"txmsg test redirect wait send mem", test_txmsg_redir_wait_sndmem},
 	{"txmsg test drop", test_txmsg_drop},
 	{"txmsg test ingress redirect", test_txmsg_ingress_redir},
 	{"txmsg test skb", test_txmsg_skb},
-- 
2.17.1


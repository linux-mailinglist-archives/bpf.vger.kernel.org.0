Return-Path: <bpf+bounces-10952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B267B000B
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 668042823DB
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7DA2421B;
	Wed, 27 Sep 2023 09:27:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E1323757;
	Wed, 27 Sep 2023 09:27:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534561B0;
	Wed, 27 Sep 2023 02:27:53 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RwWQy4hCLzVl6c;
	Wed, 27 Sep 2023 17:24:42 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 17:27:50 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v5 3/7] selftests/bpf: Add txmsg redir permanently test for sockmap
Date: Wed, 27 Sep 2023 17:30:09 +0800
Message-ID: <20230927093013.1951659-4-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927093013.1951659-1-liujian56@huawei.com>
References: <20230927093013.1951659-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add one test for txmsg redir permanently test for sockmap.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 .../selftests/bpf/progs/test_sockmap_kern.h   |  3 ++-
 tools/testing/selftests/bpf/test_sockmap.c    | 21 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
index 99d2ea9fb658..b0a2ddd55b83 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
@@ -298,8 +298,9 @@ int bpf_prog6(struct sk_msg_md *msg)
 
 	f = bpf_map_lookup_elem(&sock_redir_flags, &zero);
 	if (f && *f) {
-		key = 2;
 		flags = *f;
+		if (flags & BPF_F_INGRESS)
+			key = 2;
 	}
 #ifdef SOCKMAP
 	return bpf_msg_redirect_map(msg, &sock_map_redir, key, flags);
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index bf2cef7ae3ae..c602ac8780a8 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1166,6 +1166,19 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 
 		}
 
+		if (txmsg_permanent) {
+			int txmsg_flag = BPF_F_PERMANENT;
+
+			i = 0;
+			err = bpf_map_update_elem(map_fd[6], &i, &txmsg_flag, BPF_ANY);
+			if (err) {
+				fprintf(stderr,
+					"ERROR: bpf_map_update_elem (txmsg_permanent): %d (%s)\n",
+					err, strerror(errno));
+				goto out;
+			}
+		}
+
 		if (txmsg_ingress) {
 			int txmsg_flag = BPF_F_INGRESS;
 
@@ -1490,6 +1503,13 @@ static void test_txmsg_redir(int cgrp, struct sockmap_options *opt)
 	test_send(opt, cgrp);
 }
 
+static void test_txmsg_redir_permanent(int cgrp, struct sockmap_options *opt)
+{
+	txmsg_redir = 1;
+	txmsg_permanent = 1;
+	test_send(opt, cgrp);
+}
+
 static void test_txmsg_redir_wait_sndmem(int cgrp, struct sockmap_options *opt)
 {
 	txmsg_redir = 1;
@@ -1872,6 +1892,7 @@ static int populate_progs(char *bpf_file)
 struct _test test[] = {
 	{"txmsg test passthrough", test_txmsg_pass},
 	{"txmsg test redirect", test_txmsg_redir},
+	{"txmsg test redirect permanent", test_txmsg_redir_permanent},
 	{"txmsg test redirect wait send mem", test_txmsg_redir_wait_sndmem},
 	{"txmsg test drop", test_txmsg_drop},
 	{"txmsg test ingress redirect", test_txmsg_ingress_redir},
-- 
2.34.1



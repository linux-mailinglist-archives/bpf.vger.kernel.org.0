Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599DE5E9885
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiIZEvq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiIZEvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517AA2655C
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:44 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbVbN5NV1zHtmn;
        Mon, 26 Sep 2022 12:46:56 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:41 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 02/11] bpf/selftests: convert sockmap_ktls test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:02 +0800
Message-ID: <1664169131-32405-3-git-send-email-wangyufen@huawei.com>
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
 .../selftests/bpf/prog_tests/sockmap_ktls.c        | 39 ++++++----------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index e172d89..2d07963 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -15,16 +15,12 @@ static int tcp_server(int family)
 	int err, s;
 
 	s = socket(family, SOCK_STREAM, 0);
-	if (CHECK_FAIL(s == -1)) {
-		perror("socket");
+	if (!ASSERT_GE(s, 0, "socket"))
 		return -1;
-	}
 
 	err = listen(s, SOMAXCONN);
-	if (CHECK_FAIL(err)) {
-		perror("listen");
+	if (!ASSERT_OK(err, "listen"))
 		return -1;
-	}
 
 	return s;
 }
@@ -48,44 +44,31 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 		return;
 
 	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-	if (CHECK_FAIL(err)) {
-		perror("getsockopt");
+	if (!ASSERT_OK(err, "getsockopt"))
 		goto close_srv;
-	}
 
 	cli = socket(family, SOCK_STREAM, 0);
-	if (CHECK_FAIL(cli == -1)) {
-		perror("socket");
+	if (!ASSERT_GE(cli, 0, "socket"))
 		goto close_srv;
-	}
 
 	err = connect(cli, (struct sockaddr *)&addr, len);
-	if (CHECK_FAIL(err)) {
-		perror("connect");
+	if (!ASSERT_OK(err, "connect"))
 		goto close_cli;
-	}
 
 	err = bpf_map_update_elem(map, &zero, &cli, 0);
-	if (CHECK_FAIL(err)) {
-		perror("bpf_map_update_elem");
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
 		goto close_cli;
-	}
 
 	err = setsockopt(cli, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
-	if (CHECK_FAIL(err)) {
-		perror("setsockopt(TCP_ULP)");
+	if (!ASSERT_OK(err, "setsockopt(TCP_ULP)"))
 		goto close_cli;
-	}
 
 	err = bpf_map_delete_elem(map, &zero);
-	if (CHECK_FAIL(err)) {
-		perror("bpf_map_delete_elem");
+	if (!ASSERT_OK(err, "bpf_map_delete_elem"))
 		goto close_cli;
-	}
 
 	err = disconnect(cli);
-	if (CHECK_FAIL(err))
-		perror("disconnect");
+	ASSERT_OK(err, "disconnect");
 
 close_cli:
 	close(cli);
@@ -168,10 +151,8 @@ static void run_tests(int family, enum bpf_map_type map_type)
 	int map;
 
 	map = bpf_map_create(map_type, NULL, sizeof(int), sizeof(int), 1, NULL);
-	if (CHECK_FAIL(map < 0)) {
-		perror("bpf_map_create");
+	if (!ASSERT_GE(map, 0, "bpf_map_create"))
 		return;
-	}
 
 	if (test__start_subtest(fmt_test_name("disconnect_after_delete", family, map_type)))
 		test_sockmap_ktls_disconnect_after_delete(family, map);
-- 
1.8.3.1


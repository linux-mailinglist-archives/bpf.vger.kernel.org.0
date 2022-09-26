Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D55E9888
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiIZEvt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiIZEvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48052654B
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:46 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MbVc32sJCz1P6vX;
        Mon, 26 Sep 2022 12:47:31 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:43 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 04/11] bpf/selftests: convert sockopt_inherit test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:04 +0800
Message-ID: <1664169131-32405-5-git-send-email-wangyufen@huawei.com>
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
 .../selftests/bpf/prog_tests/sockopt_inherit.c     | 30 ++++++++++------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index c5cb6e8..2e853da8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -76,20 +76,16 @@ static void *server_thread(void *arg)
 	pthread_cond_signal(&server_started);
 	pthread_mutex_unlock(&server_started_mtx);
 
-	if (CHECK_FAIL(err < 0)) {
-		perror("Failed to listed on socket");
+	if (!ASSERT_GE(err, 0, "listed on socket"))
 		return NULL;
-	}
 
 	err += verify_sockopt(fd, CUSTOM_INHERIT1, "listen", 1);
 	err += verify_sockopt(fd, CUSTOM_INHERIT2, "listen", 1);
 	err += verify_sockopt(fd, CUSTOM_LISTENER, "listen", 1);
 
 	client_fd = accept(fd, (struct sockaddr *)&addr, &len);
-	if (CHECK_FAIL(client_fd < 0)) {
-		perror("Failed to accept client");
+	if (!ASSERT_GE(client_fd, 0, "accept client"))
 		return NULL;
-	}
 
 	err += verify_sockopt(client_fd, CUSTOM_INHERIT1, "accept", 1);
 	err += verify_sockopt(client_fd, CUSTOM_INHERIT2, "accept", 1);
@@ -183,20 +179,20 @@ static void run_test(int cgroup_fd)
 		goto close_bpf_object;
 
 	err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt", "_getsockopt");
-	if (CHECK_FAIL(err))
+	if (!ASSERT_OK(err, "prog_attach _getsockopt"))
 		goto close_bpf_object;
 
 	err = prog_attach(obj, cgroup_fd, "cgroup/setsockopt", "_setsockopt");
-	if (CHECK_FAIL(err))
+	if (!ASSERT_OK(err, "prog_attach _setsockopt"))
 		goto close_bpf_object;
 
 	server_fd = start_server();
-	if (CHECK_FAIL(server_fd < 0))
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto close_bpf_object;
 
 	pthread_mutex_lock(&server_started_mtx);
-	if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
-				      (void *)&server_fd))) {
+	if (!ASSERT_OK(pthread_create(&tid, NULL, server_thread,
+				      (void *)&server_fd), "pthread_create")) {
 		pthread_mutex_unlock(&server_started_mtx);
 		goto close_server_fd;
 	}
@@ -204,17 +200,17 @@ static void run_test(int cgroup_fd)
 	pthread_mutex_unlock(&server_started_mtx);
 
 	client_fd = connect_to_server(server_fd);
-	if (CHECK_FAIL(client_fd < 0))
+	if (!ASSERT_GE(client_fd, 0, "connect_to_server"))
 		goto close_server_fd;
 
-	CHECK_FAIL(verify_sockopt(client_fd, CUSTOM_INHERIT1, "connect", 0));
-	CHECK_FAIL(verify_sockopt(client_fd, CUSTOM_INHERIT2, "connect", 0));
-	CHECK_FAIL(verify_sockopt(client_fd, CUSTOM_LISTENER, "connect", 0));
+	ASSERT_OK(verify_sockopt(client_fd, CUSTOM_INHERIT1, "connect", 0), "verify_sockopt1");
+	ASSERT_OK(verify_sockopt(client_fd, CUSTOM_INHERIT2, "connect", 0), "verify_sockopt2");
+	ASSERT_OK(verify_sockopt(client_fd, CUSTOM_LISTENER, "connect", 0), "verify_sockopt ener");
 
 	pthread_join(tid, &server_err);
 
 	err = (int)(long)server_err;
-	CHECK_FAIL(err);
+	ASSERT_OK(err, "pthread_join retval");
 
 	close(client_fd);
 
@@ -229,7 +225,7 @@ void test_sockopt_inherit(void)
 	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/sockopt_inherit");
-	if (CHECK_FAIL(cgroup_fd < 0))
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
 		return;
 
 	run_test(cgroup_fd);
-- 
1.8.3.1


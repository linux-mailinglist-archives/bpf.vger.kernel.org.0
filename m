Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021E85E9887
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiIZEvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiIZEvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327B2655A
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:47 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbVc406TnzlWZy;
        Mon, 26 Sep 2022 12:47:32 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:44 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 05/11] bpf/selftests: convert sockopt_multi test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:05 +0800
Message-ID: <1664169131-32405-6-git-send-email-wangyufen@huawei.com>
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
 tools/testing/selftests/bpf/prog_tests/sockopt_multi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
index 28d592dc..7f56593 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
@@ -303,11 +303,11 @@ void test_sockopt_multi(void)
 	int err = -1;
 
 	cg_parent = test__join_cgroup("/parent");
-	if (CHECK_FAIL(cg_parent < 0))
+	if (!ASSERT_GE(cg_parent, 0, "join_cgroup /parent"))
 		goto out;
 
 	cg_child = test__join_cgroup("/parent/child");
-	if (CHECK_FAIL(cg_child < 0))
+	if (!ASSERT_GE(cg_child, 0, "join_cgroup /parent/child"))
 		goto out;
 
 	obj = bpf_object__open_file("sockopt_multi.bpf.o", NULL);
@@ -319,11 +319,11 @@ void test_sockopt_multi(void)
 		goto out;
 
 	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (CHECK_FAIL(sock_fd < 0))
+	if (!ASSERT_GE(sock_fd, 0, "socket"))
 		goto out;
 
-	CHECK_FAIL(run_getsockopt_test(obj, cg_parent, cg_child, sock_fd));
-	CHECK_FAIL(run_setsockopt_test(obj, cg_parent, cg_child, sock_fd));
+	ASSERT_OK(run_getsockopt_test(obj, cg_parent, cg_child, sock_fd), "getsockopt_test");
+	ASSERT_OK(run_setsockopt_test(obj, cg_parent, cg_child, sock_fd), "setsockopt_test");
 
 out:
 	close(sock_fd);
-- 
1.8.3.1


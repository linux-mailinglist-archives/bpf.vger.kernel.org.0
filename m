Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1AF5E988E
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiIZEwD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiIZEv7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6492B63C
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:53 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MbVfS50YHzHqLr;
        Mon, 26 Sep 2022 12:49:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:50 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 11/11] bpf/selftests: convert udp_limit test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:11 +0800
Message-ID: <1664169131-32405-12-git-send-email-wangyufen@huawei.com>
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
 tools/testing/selftests/bpf/prog_tests/udp_limit.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/udp_limit.c b/tools/testing/selftests/bpf/prog_tests/udp_limit.c
index 56c9d6b..2643d89 100644
--- a/tools/testing/selftests/bpf/prog_tests/udp_limit.c
+++ b/tools/testing/selftests/bpf/prog_tests/udp_limit.c
@@ -5,8 +5,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 
-static int duration;
-
 void test_udp_limit(void)
 {
 	struct udp_limit *skel;
@@ -14,11 +12,11 @@ void test_udp_limit(void)
 	int cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/udp_limit");
-	if (CHECK(cgroup_fd < 0, "cg-join", "errno %d", errno))
+	if (!ASSERT_GE(cgroup_fd, 0, "cg-join"))
 		return;
 
 	skel = udp_limit__open_and_load();
-	if (CHECK(!skel, "skel-load", "errno %d", errno))
+	if (!ASSERT_OK_PTR(skel, "skel-load"))
 		goto close_cgroup_fd;
 
 	skel->links.sock = bpf_program__attach_cgroup(skel->progs.sock, cgroup_fd);
@@ -32,11 +30,11 @@ void test_udp_limit(void)
 	 * verify that.
 	 */
 	fd1 = socket(AF_INET, SOCK_DGRAM, 0);
-	if (CHECK(fd1 < 0, "fd1", "errno %d", errno))
+	if (!ASSERT_GE(fd1, 0, "socket(fd1)"))
 		goto close_skeleton;
 
 	fd2 = socket(AF_INET, SOCK_DGRAM, 0);
-	if (CHECK(fd2 >= 0, "fd2", "errno %d", errno))
+	if (!ASSERT_LT(fd2, 0, "socket(fd2)"))
 		goto close_skeleton;
 
 	/* We can reopen again after close. */
@@ -44,7 +42,7 @@ void test_udp_limit(void)
 	fd1 = -1;
 
 	fd1 = socket(AF_INET, SOCK_DGRAM, 0);
-	if (CHECK(fd1 < 0, "fd1-again", "errno %d", errno))
+	if (!ASSERT_GE(fd1, 0, "socket(fd1-again)"))
 		goto close_skeleton;
 
 	/* Make sure the program was invoked the expected
@@ -54,13 +52,11 @@ void test_udp_limit(void)
 	 * - close fd1          - BPF_CGROUP_INET_SOCK_RELEASE
 	 * - open fd1 again     - BPF_CGROUP_INET_SOCK_CREATE
 	 */
-	if (CHECK(skel->bss->invocations != 4, "bss-invocations",
-		  "invocations=%d", skel->bss->invocations))
+	if (!ASSERT_EQ(skel->bss->invocations, 4, "bss-invocations"))
 		goto close_skeleton;
 
 	/* We should still have a single socket in use */
-	if (CHECK(skel->bss->in_use != 1, "bss-in_use",
-		  "in_use=%d", skel->bss->in_use))
+	if (!ASSERT_EQ(skel->bss->in_use, 1, "bss-in_use"))
 		goto close_skeleton;
 
 close_skeleton:
-- 
1.8.3.1


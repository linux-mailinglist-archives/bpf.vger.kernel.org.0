Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121115E988C
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 06:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiIZEvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 00:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiIZEvx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 00:51:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC2B2AE2E
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 21:51:51 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MbVdg3mgxzpVRf;
        Mon, 26 Sep 2022 12:48:55 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 12:51:48 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>
CC:     <bpf@vger.kernel.org>
Subject: [bpf-next 09/11] bpf/selftests: convert tcp_rtt test to ASSERT_* macros
Date:   Mon, 26 Sep 2022 13:12:09 +0800
Message-ID: <1664169131-32405-10-git-send-email-wangyufen@huawei.com>
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
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index 96ff2c2..8fe84da1 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -16,8 +16,7 @@ static void send_byte(int fd)
 {
 	char b = 0x55;
 
-	if (CHECK_FAIL(write(fd, &b, sizeof(b)) != 1))
-		perror("Failed to send single byte");
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
 }
 
 static int wait_for_ack(int fd, int retries)
@@ -51,10 +50,8 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 invoked,
 	int err = 0;
 	struct tcp_rtt_storage val;
 
-	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &client_fd, &val) < 0)) {
-		perror("Failed to read socket storage");
+	if (!ASSERT_GE(bpf_map_lookup_elem(map_fd, &client_fd, &val), 0, "read socket storage"))
 		return -1;
-	}
 
 	if (val.invoked != invoked) {
 		log_err("%s: unexpected bpf_tcp_sock.invoked %d != %d",
@@ -151,14 +148,14 @@ void test_tcp_rtt(void)
 	int server_fd, cgroup_fd;
 
 	cgroup_fd = test__join_cgroup("/tcp_rtt");
-	if (CHECK_FAIL(cgroup_fd < 0))
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /tcp_rtt"))
 		return;
 
 	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
-	if (CHECK_FAIL(server_fd < 0))
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto close_cgroup_fd;
 
-	CHECK_FAIL(run_test(cgroup_fd, server_fd));
+	ASSERT_OK(run_test(cgroup_fd, server_fd), "run_test");
 
 	close(server_fd);
 
-- 
1.8.3.1


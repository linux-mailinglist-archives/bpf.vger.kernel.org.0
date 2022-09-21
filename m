Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0975BF39E
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 04:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIUClF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 22:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiIUCk5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 22:40:57 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538F52E52
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 19:40:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MXN0H4X3LzlRl9
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 10:39:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH53CxeSpj9UifBA--.10379S6;
        Wed, 21 Sep 2022 10:40:52 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Free the allocated resources after test case succeeds
Date:   Wed, 21 Sep 2022 10:58:55 +0800
Message-Id: <20220921025855.115463-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220921025855.115463-1-houtao@huaweicloud.com>
References: <20220921025855.115463-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH53CxeSpj9UifBA--.10379S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry3JFyktr4UGF1ktrykGrg_yoW7trWrpF
        yrAw1jkFZ2vF42qrW3Xa4kWFWSgrnrX3yYk3ZYyw15Ar18Xr1fJr1xKa4DKFn5WrWSqF4a
        vas2kryfuayDJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFa9-UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Free the created fd or allocated bpf_object after test case succeeds,
else there will be resource leaks.

Spotted by using address sanitizer and checking the content of
/proc/$pid/fd directory.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/map_tests/array_map_batch_ops.c       |  1 +
 .../bpf/map_tests/htab_map_batch_ops.c        |  1 +
 .../bpf/map_tests/lpm_trie_map_batch_ops.c    |  1 +
 tools/testing/selftests/bpf/test_maps.c       | 24 ++++++++++++-------
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
index 78c76496b14a..cc95aafbd721 100644
--- a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
@@ -137,6 +137,7 @@ static void __test_map_lookup_and_update_batch(bool is_pcpu)
 	free(keys);
 	free(values);
 	free(visited);
+	close(map_fd);
 }
 
 static void array_map_batch_ops(void)
diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
index f807d53fd8dd..dbd680100e50 100644
--- a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
@@ -255,6 +255,7 @@ void __test_map_lookup_and_delete_batch(bool is_pcpu)
 	free(visited);
 	if (!is_pcpu)
 		free(values);
+	close(map_fd);
 }
 
 void htab_map_batch_ops(void)
diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
index 87d07b596e17..874688c6d221 100644
--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
@@ -150,4 +150,5 @@ void test_lpm_trie_map_batch_ops(void)
 	free(keys);
 	free(values);
 	free(visited);
+	close(map_fd);
 }
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index f0b830f3d7b8..ba7b2e0f9bf4 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -659,13 +659,13 @@ static void test_sockmap(unsigned int tasks, void *data)
 {
 	struct bpf_map *bpf_map_rx, *bpf_map_tx, *bpf_map_msg, *bpf_map_break;
 	int map_fd_msg = 0, map_fd_rx = 0, map_fd_tx = 0, map_fd_break;
+	struct bpf_object *parse_obj, *verdict_obj, *msg_obj;
 	int ports[] = {50200, 50201, 50202, 50204};
 	int err, i, fd, udp, sfd[6] = {0xdeadbeef};
 	u8 buf[20] = {0x0, 0x5, 0x3, 0x2, 0x1, 0x0};
 	int parse_prog, verdict_prog, msg_prog;
 	struct sockaddr_in addr;
 	int one = 1, s, sc, rc;
-	struct bpf_object *obj;
 	struct timeval to;
 	__u32 key, value;
 	pid_t pid[tasks];
@@ -761,6 +761,7 @@ static void test_sockmap(unsigned int tasks, void *data)
 		       i, udp);
 		goto out_sockmap;
 	}
+	close(udp);
 
 	/* Test update without programs */
 	for (i = 0; i < 6; i++) {
@@ -823,27 +824,27 @@ static void test_sockmap(unsigned int tasks, void *data)
 
 	/* Load SK_SKB program and Attach */
 	err = bpf_prog_test_load(SOCKMAP_PARSE_PROG,
-			    BPF_PROG_TYPE_SK_SKB, &obj, &parse_prog);
+			    BPF_PROG_TYPE_SK_SKB, &parse_obj, &parse_prog);
 	if (err) {
 		printf("Failed to load SK_SKB parse prog\n");
 		goto out_sockmap;
 	}
 
 	err = bpf_prog_test_load(SOCKMAP_TCP_MSG_PROG,
-			    BPF_PROG_TYPE_SK_MSG, &obj, &msg_prog);
+			    BPF_PROG_TYPE_SK_MSG, &msg_obj, &msg_prog);
 	if (err) {
 		printf("Failed to load SK_SKB msg prog\n");
 		goto out_sockmap;
 	}
 
 	err = bpf_prog_test_load(SOCKMAP_VERDICT_PROG,
-			    BPF_PROG_TYPE_SK_SKB, &obj, &verdict_prog);
+			    BPF_PROG_TYPE_SK_SKB, &verdict_obj, &verdict_prog);
 	if (err) {
 		printf("Failed to load SK_SKB verdict prog\n");
 		goto out_sockmap;
 	}
 
-	bpf_map_rx = bpf_object__find_map_by_name(obj, "sock_map_rx");
+	bpf_map_rx = bpf_object__find_map_by_name(verdict_obj, "sock_map_rx");
 	if (!bpf_map_rx) {
 		printf("Failed to load map rx from verdict prog\n");
 		goto out_sockmap;
@@ -855,7 +856,7 @@ static void test_sockmap(unsigned int tasks, void *data)
 		goto out_sockmap;
 	}
 
-	bpf_map_tx = bpf_object__find_map_by_name(obj, "sock_map_tx");
+	bpf_map_tx = bpf_object__find_map_by_name(verdict_obj, "sock_map_tx");
 	if (!bpf_map_tx) {
 		printf("Failed to load map tx from verdict prog\n");
 		goto out_sockmap;
@@ -867,7 +868,7 @@ static void test_sockmap(unsigned int tasks, void *data)
 		goto out_sockmap;
 	}
 
-	bpf_map_msg = bpf_object__find_map_by_name(obj, "sock_map_msg");
+	bpf_map_msg = bpf_object__find_map_by_name(verdict_obj, "sock_map_msg");
 	if (!bpf_map_msg) {
 		printf("Failed to load map msg from msg_verdict prog\n");
 		goto out_sockmap;
@@ -879,7 +880,7 @@ static void test_sockmap(unsigned int tasks, void *data)
 		goto out_sockmap;
 	}
 
-	bpf_map_break = bpf_object__find_map_by_name(obj, "sock_map_break");
+	bpf_map_break = bpf_object__find_map_by_name(verdict_obj, "sock_map_break");
 	if (!bpf_map_break) {
 		printf("Failed to load map tx from verdict prog\n");
 		goto out_sockmap;
@@ -1125,7 +1126,9 @@ static void test_sockmap(unsigned int tasks, void *data)
 	}
 	close(fd);
 	close(map_fd_rx);
-	bpf_object__close(obj);
+	bpf_object__close(parse_obj);
+	bpf_object__close(msg_obj);
+	bpf_object__close(verdict_obj);
 	return;
 out:
 	for (i = 0; i < 6; i++)
@@ -1283,8 +1286,11 @@ static void test_map_in_map(void)
 			printf("Inner map mim.inner was not destroyed\n");
 			goto out_map_in_map;
 		}
+
+		close(fd);
 	}
 
+	bpf_object__close(obj);
 	return;
 
 out_map_in_map:
-- 
2.29.2


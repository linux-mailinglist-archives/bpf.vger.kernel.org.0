Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7558B43E
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 09:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiHFHka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbiHFHk1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 03:40:27 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8830AB840
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 00:40:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M0DQX1gDqzKKtN
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 15:20:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHeVydFu5iXIYHAA--.28679S12;
        Sat, 06 Aug 2022 15:22:11 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
Subject: [PATCH bpf 8/9] selftests/bpf: Add write tests for sk storage map iterator
Date:   Sat,  6 Aug 2022 15:40:18 +0800
Message-Id: <20220806074019.2756957-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220806074019.2756957-1-houtao@huaweicloud.com>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHeVydFu5iXIYHAA--.28679S12
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1UWF4xKr4DCryUKw1rJFb_yoWrJryfpF
        yIq39Ikr1rXw4fZrnrJw4akryrt3W0qw13KrZ3Jr4rAr4kXF95Gr1fGF18ZFy3Gr9Yqr1f
        Ar9Ikay5CryxZ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUoeOJUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Add test to validate the overwrite of sock storage map value in map
iterator and another one to ensure out-of-bound value writing is
rejected.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 20 +++++++++++++++++--
 .../bpf/progs/bpf_iter_bpf_sk_storage_map.c   | 20 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 94c2c8df3fe4..f75308d75570 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1074,7 +1074,7 @@ static void test_bpf_sk_stoarge_map_iter_fd(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_sk_storage_map__open_and_load"))
 		return;
 
-	do_read_map_iter_fd(&skel->skeleton, skel->progs.dump_bpf_sk_storage_map,
+	do_read_map_iter_fd(&skel->skeleton, skel->progs.rw_bpf_sk_storage_map,
 			    skel->maps.sk_stg_map);
 
 	bpf_iter_bpf_sk_storage_map__destroy(skel);
@@ -1115,7 +1115,15 @@ static void test_bpf_sk_storage_map(void)
 	linfo.map.map_fd = map_fd;
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
-	link = bpf_program__attach_iter(skel->progs.dump_bpf_sk_storage_map, &opts);
+	link = bpf_program__attach_iter(skel->progs.oob_write_bpf_sk_storage_map, &opts);
+	err = libbpf_get_error(link);
+	if (!ASSERT_EQ(err, -EACCES, "attach_oob_write_iter")) {
+		if (!err)
+			bpf_link__destroy(link);
+		goto out;
+	}
+
+	link = bpf_program__attach_iter(skel->progs.rw_bpf_sk_storage_map, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		goto out;
 
@@ -1123,6 +1131,7 @@ static void test_bpf_sk_storage_map(void)
 	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
+	skel->bss->to_add_val = time(NULL);
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
@@ -1136,6 +1145,13 @@ static void test_bpf_sk_storage_map(void)
 	if (!ASSERT_EQ(skel->bss->val_sum, expected_val, "val_sum"))
 		goto close_iter;
 
+	for (i = 0; i < num_sockets; i++) {
+		err = bpf_map_lookup_elem(map_fd, &sock_fd[i], &val);
+		if (!ASSERT_OK(err, "map_lookup") ||
+		    !ASSERT_EQ(val, i + 1 + skel->bss->to_add_val, "check_map_value"))
+			break;
+	}
+
 close_iter:
 	close(iter_fd);
 free_link:
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
index 6b70ccaba301..6a82f8b0c0fa 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
@@ -16,9 +16,10 @@ struct {
 
 __u32 val_sum = 0;
 __u32 ipv6_sk_count = 0;
+__u32 to_add_val = 0;
 
 SEC("iter/bpf_sk_storage_map")
-int dump_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
+int rw_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
 {
 	struct sock *sk = ctx->sk;
 	__u32 *val = ctx->value;
@@ -30,5 +31,22 @@ int dump_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
 		ipv6_sk_count++;
 
 	val_sum += *val;
+
+	*val += to_add_val;
+
+	return 0;
+}
+
+SEC("iter/bpf_sk_storage_map")
+int oob_write_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
+{
+	struct sock *sk = ctx->sk;
+	__u32 *val = ctx->value;
+
+	if (sk == (void *)0 || val == (void *)0)
+		return 0;
+
+	*(val + 1) = 0xdeadbeef;
+
 	return 0;
 }
-- 
2.29.2


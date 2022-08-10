Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101EC58E81D
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiHJHsH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHJHri (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 03:47:38 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE796E8A2
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 00:47:37 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M2hnv4fzXzKpPD
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 15:46:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHsb2NYvNiIKmmAA--.61804S12;
        Wed, 10 Aug 2022 15:47:34 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Subject: [PATCH bpf v2 8/9] selftests/bpf: Add write tests for sk local storage map iterator
Date:   Wed, 10 Aug 2022 16:05:37 +0800
Message-Id: <20220810080538.1845898-9-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220810080538.1845898-1-houtao@huaweicloud.com>
References: <20220810080538.1845898-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHsb2NYvNiIKmmAA--.61804S12
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWkuw47KF15Jw4UZFW5ZFb_yoWrJFy3pF
        yIq3yakr1fXw4fZrnrJw4akryrtw10qw1fKrs3Gr45Ar4kXr95Gr1xKF10vF9xGr9Yqr1S
        yr1akay5Cry8Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
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

Add test to validate the overwrite of sock local storage map value in
map iterator and another one to ensure out-of-bound value writing is
rejected.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 20 +++++++++++++++--
 .../bpf/progs/bpf_iter_bpf_sk_storage_map.c   | 22 +++++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index b690c9e9d346..1571a6586b3b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -1076,7 +1076,7 @@ static void test_bpf_sk_stoarge_map_iter_fd(void)
 	if (!ASSERT_OK_PTR(skel, "bpf_iter_bpf_sk_storage_map__open_and_load"))
 		return;
 
-	do_read_map_iter_fd(&skel->skeleton, skel->progs.dump_bpf_sk_storage_map,
+	do_read_map_iter_fd(&skel->skeleton, skel->progs.rw_bpf_sk_storage_map,
 			    skel->maps.sk_stg_map);
 
 	bpf_iter_bpf_sk_storage_map__destroy(skel);
@@ -1117,7 +1117,15 @@ static void test_bpf_sk_storage_map(void)
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
 
@@ -1125,6 +1133,7 @@ static void test_bpf_sk_storage_map(void)
 	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
 
+	skel->bss->to_add_val = time(NULL);
 	/* do some tests */
 	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
 		;
@@ -1138,6 +1147,13 @@ static void test_bpf_sk_storage_map(void)
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
index 6b70ccaba301..c7b8e006b171 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_sk_storage_map.c
@@ -16,19 +16,37 @@ struct {
 
 __u32 val_sum = 0;
 __u32 ipv6_sk_count = 0;
+__u32 to_add_val = 0;
 
 SEC("iter/bpf_sk_storage_map")
-int dump_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
+int rw_bpf_sk_storage_map(struct bpf_iter__bpf_sk_storage_map *ctx)
 {
 	struct sock *sk = ctx->sk;
 	__u32 *val = ctx->value;
 
-	if (sk == (void *)0 || val == (void *)0)
+	if (sk == NULL || val == NULL)
 		return 0;
 
 	if (sk->sk_family == AF_INET6)
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
+	if (sk == NULL || val == NULL)
+		return 0;
+
+	*(val + 1) = 0xdeadbeef;
+
 	return 0;
 }
-- 
2.29.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C9258E820
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiHJHsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 03:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiHJHri (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 03:47:38 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087AC6E89E
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 00:47:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M2hnw59c5z6T8mc
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 15:46:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHsb2NYvNiIKmmAA--.61804S13;
        Wed, 10 Aug 2022 15:47:35 +0800 (CST)
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
Subject: [PATCH bpf v2 9/9] selftests/bpf: Ensure sleepable program is rejected by hash map iter
Date:   Wed, 10 Aug 2022 16:05:38 +0800
Message-Id: <20220810080538.1845898-10-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220810080538.1845898-1-houtao@huaweicloud.com>
References: <20220810080538.1845898-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHsb2NYvNiIKmmAA--.61804S13
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4kuw4xuw1DGrykAw45Awb_yoW8CrWUpa
        s7Xryjkr1fGanrXrnxGrsFgryrtF1kX3yUGF4fKry5Zr4DX3s7Wr1IgF10qF98WrZYvrna
        v34Sk34rCry8ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
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

Add a test to ensure sleepable program is rejected by hash map iterator.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c        | 6 ++++++
 .../testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c  | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 1571a6586b3b..e89685bd587c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -679,6 +679,12 @@ static void test_bpf_hash_map(void)
 			goto out;
 	}
 
+	/* Sleepable program is prohibited for hash map iterator */
+	linfo.map.map_fd = map_fd;
+	link = bpf_program__attach_iter(skel->progs.sleepable_dummy_dump, &opts);
+	if (!ASSERT_ERR_PTR(link, "attach_sleepable_prog_to_iter"))
+		goto out;
+
 	linfo.map.map_fd = map_fd;
 	link = bpf_program__attach_iter(skel->progs.dump_bpf_hash_map, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
index 0aa3cd34cbe3..d7a69217fb68 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c
@@ -112,3 +112,12 @@ int dump_bpf_hash_map(struct bpf_iter__bpf_map_elem *ctx)
 
 	return 0;
 }
+
+SEC("iter.s/bpf_map_elem")
+int sleepable_dummy_dump(struct bpf_iter__bpf_map_elem *ctx)
+{
+	if (ctx->meta->seq_num == 0)
+		BPF_SEQ_PRINTF(ctx->meta->seq, "map dump starts\n");
+
+	return 0;
+}
-- 
2.29.2


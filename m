Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE858B440
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 09:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiHFHkc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbiHFHk1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 03:40:27 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4344CBC8F
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 00:40:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M0DQX6LMdzKJ9B
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 15:20:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHeVydFu5iXIYHAA--.28679S13;
        Sat, 06 Aug 2022 15:22:12 +0800 (CST)
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
Subject: [PATCH bpf 9/9] selftests/bpf: Ensure sleepable program is rejected by hash map iter
Date:   Sat,  6 Aug 2022 15:40:19 +0800
Message-Id: <20220806074019.2756957-10-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220806074019.2756957-1-houtao@huaweicloud.com>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHeVydFu5iXIYHAA--.28679S13
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4DWrykZFW5Xw4xXw4rAFb_yoW8Aw4fpa
        4kX34jkr1fGanrXrnxGrsFgry5tF1kX3yUGF4fKry5ur4DX3s7Wr1xKF1FqF98WrZYvrna
        v34Sk34rCrW8ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
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

Add a test to ensure sleepable program is rejected by hash map iterator.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c        | 6 ++++++
 .../testing/selftests/bpf/progs/bpf_iter_bpf_hash_map.c  | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index f75308d75570..c0b4f8dd7f0f 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -677,6 +677,12 @@ static void test_bpf_hash_map(void)
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


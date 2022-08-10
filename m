Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD658E818
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiHJHsE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 03:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiHJHre (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 03:47:34 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF76F541
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 00:47:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M2hp320w4zlCnJ
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 15:46:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHsb2NYvNiIKmmAA--.61804S5;
        Wed, 10 Aug 2022 15:47:29 +0800 (CST)
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
Subject: [PATCH bpf v2 1/9] bpf: Acquire map uref in .init_seq_private for array map iterator
Date:   Wed, 10 Aug 2022 16:05:30 +0800
Message-Id: <20220810080538.1845898-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220810080538.1845898-1-houtao@huaweicloud.com>
References: <20220810080538.1845898-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHsb2NYvNiIKmmAA--.61804S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryftF17CFWkAr15Jw13Arb_yoW8WF1kpr
        WkXFWjka18Xr4j9F4kJayUuayrZ345W34rJFsYy34Y9FW3Xr1UZr18GFWjkFWY9Fy0kr1F
        qw1j9r48ua4UAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
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

bpf_iter_attach_map() acquires a map uref, and the uref may be released
before or in the middle of iterating map elements. For example, the uref
could be released in bpf_iter_detach_map() as part of
bpf_link_release(), or could be released in bpf_map_put_with_uref() as
part of bpf_map_release().

Alternative fix is acquiring an extra bpf_link reference just like
a pinned map iterator does, but it introduces unnecessary dependency
on bpf_link instead of bpf_map.

So choose another fix: acquiring an extra map uref in .init_seq_private
for array map iterator.

Fixes: d3cc2ab546ad ("bpf: Implement bpf iterator for array maps")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/arraymap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index d3e734bf8056..624527401d4d 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -649,6 +649,11 @@ static int bpf_iter_init_array_map(void *priv_data,
 		seq_info->percpu_value_buf = value_buf;
 	}
 
+	/* bpf_iter_attach_map() acquires a map uref, and the uref may be
+	 * released before or in the middle of iterating map elements, so
+	 * acquire an extra map uref for iterator.
+	 */
+	bpf_map_inc_with_uref(map);
 	seq_info->map = map;
 	return 0;
 }
@@ -657,6 +662,7 @@ static void bpf_iter_fini_array_map(void *priv_data)
 {
 	struct bpf_iter_seq_array_map_info *seq_info = priv_data;
 
+	bpf_map_put_with_uref(seq_info->map);
 	kfree(seq_info->percpu_value_buf);
 }
 
-- 
2.29.2


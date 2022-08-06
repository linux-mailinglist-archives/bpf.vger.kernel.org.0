Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222D158B43C
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbiHFHk3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiHFHk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 03:40:26 -0400
X-Greylist: delayed 1093 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Aug 2022 00:40:23 PDT
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E991B7D3
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 00:40:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M0DQW2Xdwz6R4sx
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 15:20:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHeVydFu5iXIYHAA--.28679S10;
        Sat, 06 Aug 2022 15:22:10 +0800 (CST)
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
Subject: [PATCH bpf 6/9] bpf: Only allow sleepable program for resched-able iterator
Date:   Sat,  6 Aug 2022 15:40:16 +0800
Message-Id: <20220806074019.2756957-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220806074019.2756957-1-houtao@huaweicloud.com>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHeVydFu5iXIYHAA--.28679S10
X-Coremail-Antispam: 1UD129KBjvJXoW7ury5KryktrW3Zw4rtFWfuFg_yoW8ZrWrpF
        Z3XFyqkr48Xws2yF1DAa1Dua45Aw18Wa43WFs2g34ayanru3srWrWrtF429Fn8Xry0krZa
        yFW0kw1jvrWUZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

When a sleepable program is attached to a hash map iterator, might_fault()
will report "BUG: sleeping function called from invalid context..." if
CONFIG_DEBUG_ATOMIC_SLEEP is enabled. The reason is that rcu_read_lock()
is held in bpf_hash_map_seq_next() and won't be released until all elements
are traversed or bpf_hash_map_seq_stop() is called.

Fixing it by reusing BPF_ITER_RESCHED to indicate that only non-sleepable
program is allowed for iterator without BPF_ITER_RESCHED. Another fine-grained
flag can be added later if needed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_iter.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 7e8fd49406f6..f4db589d1dc5 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -68,13 +68,18 @@ static void bpf_iter_done_stop(struct seq_file *seq)
 	iter_priv->done_stop = true;
 }
 
+static inline bool bpf_iter_target_support_resched(const struct bpf_iter_target_info *tinfo)
+{
+	return tinfo->reg_info->feature & BPF_ITER_RESCHED;
+}
+
 static bool bpf_iter_support_resched(struct seq_file *seq)
 {
 	struct bpf_iter_priv_data *iter_priv;
 
 	iter_priv = container_of(seq->private, struct bpf_iter_priv_data,
 				 target_private);
-	return iter_priv->tinfo->reg_info->feature & BPF_ITER_RESCHED;
+	return bpf_iter_target_support_resched(iter_priv->tinfo);
 }
 
 /* maximum visited objects before bailing out */
@@ -538,6 +543,10 @@ int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 	if (!tinfo)
 		return -ENOENT;
 
+	/* Only allow sleepable program for resched-able iterator */
+	if (prog->aux->sleepable && !bpf_iter_target_support_resched(tinfo))
+		return -EINVAL;
+
 	link = kzalloc(sizeof(*link), GFP_USER | __GFP_NOWARN);
 	if (!link)
 		return -ENOMEM;
-- 
2.29.2


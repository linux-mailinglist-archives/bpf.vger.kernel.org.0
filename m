Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4358B442
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiHFHkd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 03:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiHFHk2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 03:40:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199CFBE08
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 00:40:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M0DQS6g9szKHcy
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 15:20:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHeVydFu5iXIYHAA--.28679S7;
        Sat, 06 Aug 2022 15:22:08 +0800 (CST)
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
Subject: [PATCH bpf 3/9] bpf: Acquire map uref in .init_seq_private for sock local storage map iterator
Date:   Sat,  6 Aug 2022 15:40:13 +0800
Message-Id: <20220806074019.2756957-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220806074019.2756957-1-houtao@huaweicloud.com>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHeVydFu5iXIYHAA--.28679S7
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47AryrAw15ZFyDXF45GFg_yoW8AFyUpr
        1fAFnIkrW8X3yfCrsrJanrCr13Aw1qga45KFZ3Awsakr4vqFy5GF13GF1IyFy5CrW8XFna
        yr1a9Fy5CFykC3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
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

During bpf(BPF_LINK_CREATE) for BPF_TRACE_ITER, bpf_iter_attach_map()
has already acquired a map uref, but the uref may be released
by bpf_link_release() during th reading of map iterator.

So acquiring an extra map uref in bpf_iter_init_sk_storage_map() and
releasing it in bpf_iter_fini_sk_storage_map().

Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 net/core/bpf_sk_storage.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index a25ec93729b9..83b89ba824d7 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -875,10 +875,18 @@ static int bpf_iter_init_sk_storage_map(void *priv_data,
 {
 	struct bpf_iter_seq_sk_storage_map_info *seq_info = priv_data;
 
+	bpf_map_inc_with_uref(aux->map);
 	seq_info->map = aux->map;
 	return 0;
 }
 
+static void bpf_iter_fini_sk_storage_map(void *priv_data)
+{
+	struct bpf_iter_seq_sk_storage_map_info *seq_info = priv_data;
+
+	bpf_map_put_with_uref(seq_info->map);
+}
+
 static int bpf_iter_attach_map(struct bpf_prog *prog,
 			       union bpf_iter_link_info *linfo,
 			       struct bpf_iter_aux_info *aux)
@@ -924,7 +932,7 @@ static const struct seq_operations bpf_sk_storage_map_seq_ops = {
 static const struct bpf_iter_seq_info iter_seq_info = {
 	.seq_ops		= &bpf_sk_storage_map_seq_ops,
 	.init_seq_private	= bpf_iter_init_sk_storage_map,
-	.fini_seq_private	= NULL,
+	.fini_seq_private	= bpf_iter_fini_sk_storage_map,
 	.seq_priv_size		= sizeof(struct bpf_iter_seq_sk_storage_map_info),
 };
 
-- 
2.29.2


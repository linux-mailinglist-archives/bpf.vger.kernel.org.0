Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C271A58B43F
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 09:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiHFHkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbiHFHk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 03:40:26 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8CB7F9
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 00:40:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M0DQV0hwNz6S2G4
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 15:20:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHeVydFu5iXIYHAA--.28679S8;
        Sat, 06 Aug 2022 15:22:09 +0800 (CST)
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
Subject: [PATCH bpf 4/9] bpf: Acquire map uref in .init_seq_private for sock{map,hash} iterator
Date:   Sat,  6 Aug 2022 15:40:14 +0800
Message-Id: <20220806074019.2756957-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220806074019.2756957-1-houtao@huaweicloud.com>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHeVydFu5iXIYHAA--.28679S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tr47CrWxWr4ktr4rXw4kXrb_yoW8tryrpF
        9Yyws09w48XF4j9Fn8Ja9rZwnayFn3Ww1jqFn3Jas5CrnrGr47WF18tFyIkF4YkrW8Kry3
        Jrn29F1UG3y7C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
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

During bpf(BPF_LINK_CREATE), sock_map_iter_attach_target() has already
acquired a map uref, but the uref may be released by bpf_link_release()
during th reading of map iterator.

Fixing it by acquiring an extra map uref in .init_seq_private and
releasing it in .fini_seq_private.

Fixes: 0365351524d7 ("net: Allow iterating sockmap and sockhash")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 net/core/sock_map.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 028813dfecb0..9a9fb9487d63 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -783,13 +783,22 @@ static int sock_map_init_seq_private(void *priv_data,
 {
 	struct sock_map_seq_info *info = priv_data;
 
+	bpf_map_inc_with_uref(aux->map);
 	info->map = aux->map;
 	return 0;
 }
 
+static void sock_map_fini_seq_private(void *priv_data)
+{
+	struct sock_map_seq_info *info = priv_data;
+
+	bpf_map_put_with_uref(info->map);
+}
+
 static const struct bpf_iter_seq_info sock_map_iter_seq_info = {
 	.seq_ops		= &sock_map_seq_ops,
 	.init_seq_private	= sock_map_init_seq_private,
+	.fini_seq_private	= sock_map_fini_seq_private,
 	.seq_priv_size		= sizeof(struct sock_map_seq_info),
 };
 
@@ -1369,18 +1378,27 @@ static const struct seq_operations sock_hash_seq_ops = {
 };
 
 static int sock_hash_init_seq_private(void *priv_data,
-				     struct bpf_iter_aux_info *aux)
+				      struct bpf_iter_aux_info *aux)
 {
 	struct sock_hash_seq_info *info = priv_data;
 
+	bpf_map_inc_with_uref(aux->map);
 	info->map = aux->map;
 	info->htab = container_of(aux->map, struct bpf_shtab, map);
 	return 0;
 }
 
+static void sock_hash_fini_seq_private(void *priv_data)
+{
+	struct sock_hash_seq_info *info = priv_data;
+
+	bpf_map_put_with_uref(info->map);
+}
+
 static const struct bpf_iter_seq_info sock_hash_iter_seq_info = {
 	.seq_ops		= &sock_hash_seq_ops,
 	.init_seq_private	= sock_hash_init_seq_private,
+	.fini_seq_private	= sock_hash_fini_seq_private,
 	.seq_priv_size		= sizeof(struct sock_hash_seq_info),
 };
 
-- 
2.29.2


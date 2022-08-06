Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FE58B43B
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiHFHk3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbiHFHk0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 03:40:26 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EACDB7EC
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 00:40:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4M0DQS4WDgz6S3GS
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 15:20:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHeVydFu5iXIYHAA--.28679S6;
        Sat, 06 Aug 2022 15:22:07 +0800 (CST)
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
Subject: [PATCH bpf 2/9] bpf: Acquire map uref in .init_seq_private for hash map iterator
Date:   Sat,  6 Aug 2022 15:40:12 +0800
Message-Id: <20220806074019.2756957-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220806074019.2756957-1-houtao@huaweicloud.com>
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHeVydFu5iXIYHAA--.28679S6
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyxKw48ZF43Zr15XF1xGrg_yoWktFX_u3
        ykurn7Kr45Ca1S93yjkFn3ury8JrySqrWqkw4vqrZ3JryrA3WrGrWkZFZxZryxWwsrJFZr
        XFsakr9a9r17XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JrC_JFWl1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
        8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UHuWLUUUUU=
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

So acquiring an extra map uref in bpf_iter_init_hash_map() and
releasing it in bpf_iter_fini_hash_map().

Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index da7578426a46..da8c0177f773 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2064,6 +2064,7 @@ static int bpf_iter_init_hash_map(void *priv_data,
 		seq_info->percpu_value_buf = value_buf;
 	}
 
+	bpf_map_inc_with_uref(map);
 	seq_info->map = map;
 	seq_info->htab = container_of(map, struct bpf_htab, map);
 	return 0;
@@ -2073,6 +2074,7 @@ static void bpf_iter_fini_hash_map(void *priv_data)
 {
 	struct bpf_iter_seq_hash_map_info *seq_info = priv_data;
 
+	bpf_map_put_with_uref(seq_info->map);
 	kfree(seq_info->percpu_value_buf);
 }
 
-- 
2.29.2


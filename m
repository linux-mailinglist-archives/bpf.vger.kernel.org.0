Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B69607615
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 13:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJULXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJULXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 07:23:30 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26962630AD
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 04:23:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Mv28d1xCJz6R63t
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 19:21:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3PS4rgVJjbYvJAA--.39S6;
        Fri, 21 Oct 2022 19:23:27 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: [PATCH bpf v2 2/2] bpf: Use __llist_del_all() whenever possbile during memory draining
Date:   Fri, 21 Oct 2022 19:49:13 +0800
Message-Id: <20221021114913.60508-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021114913.60508-1-houtao@huaweicloud.com>
References: <20221021114913.60508-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3PS4rgVJjbYvJAA--.39S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1ruF1kAw13Wry3tr1fJFb_yoW8Ww1xpF
        W3Cry8Jr48AF9F9a1Utrn7ur95Xw4rGay3G3yUua4akr15Xw4DtrZ7Ww1jgFy3WrW0q343
        CrWvgF1xWF4UXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1sa9DUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Except for waiting_for_gp list, there are no concurrent operations on
free_by_rcu, free_llist and free_llist_extra lists, so use
__llist_del_all() instead of llist_del_all(). waiting_for_gp list can be
deleted by RCU callback concurrently, so still use llist_del_all().

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 4e4b3250aada..8f0d65f2474a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -423,14 +423,17 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	/* No progs are using this bpf_mem_cache, but htab_map_free() called
 	 * bpf_mem_cache_free() for all remaining elements and they can be in
 	 * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
+	 *
+	 * Except for waiting_for_gp list, there are no concurrent operations
+	 * on these lists, so it is safe to use __llist_del_all().
 	 */
 	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
 		free_one(c, llnode);
 	llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
 		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist))
+	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist))
 		free_one(c, llnode);
-	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
+	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_llist_extra))
 		free_one(c, llnode);
 }
 
-- 
2.29.2


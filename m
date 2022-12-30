Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439E0659498
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 05:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiL3EMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 23:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiL3EMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 23:12:09 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59821186DF;
        Thu, 29 Dec 2022 20:12:07 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NjsKD1stSz4f3k5d;
        Fri, 30 Dec 2022 12:12:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMPZa5j3H4SAw--.35465S7;
        Fri, 30 Dec 2022 12:12:02 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC PATCH bpf-next 3/6] bpf: Pass bitwise flags to bpf_mem_alloc_init()
Date:   Fri, 30 Dec 2022 12:11:48 +0800
Message-Id: <20221230041151.1231169-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221230041151.1231169-1-houtao@huaweicloud.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMPZa5j3H4SAw--.35465S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4xCryxKFyfuryfArW3trb_yoW5ur18pF
        Z7Gr48AFs0qF4kua17Krs7Aay5Xw1Fg3WxGay5XryFvr1rWrnrWr4DJryaqF909r4jyayf
        ArnYgrW0y34UZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Extend a boolean argument to a bitwise flags argument for
bpf_mem_alloc_init(), so more new flags can be added later.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h | 8 +++++++-
 kernel/bpf/core.c             | 2 +-
 kernel/bpf/hashtab.c          | 5 +++--
 kernel/bpf/memalloc.c         | 4 +++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3c287db087e7..b9f6b9155fa5 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -13,9 +13,15 @@ struct bpf_mem_alloc {
 	struct bpf_mem_cache __percpu *cache;
 	struct work_struct work;
 	void (*ctor)(struct bpf_mem_alloc *ma, void *obj);
+	unsigned int flags;
 };
 
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu,
+/* flags for bpf_mem_alloc_init() */
+enum {
+	BPF_MA_PERCPU = 1,
+};
+
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, unsigned int flags,
 		       void (*ctor)(struct bpf_mem_alloc *, void *));
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6da2f9a6b085..ca9a698c3f08 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2755,7 +2755,7 @@ static int __init bpf_global_ma_init(void)
 {
 	int ret;
 
-	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false, NULL);
+	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, 0, NULL);
 	bpf_global_ma_set = !ret;
 	return ret;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3d6557ec4b92..623111d4276d 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -574,13 +574,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false,
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, 0,
 					 htab_elem_ctor);
 		if (err)
 			goto free_map_locked;
 		if (percpu) {
 			err = bpf_mem_alloc_init(&htab->pcpu_ma,
-						 round_up(htab->map.value_size, 8), true, NULL);
+						 round_up(htab->map.value_size, 8),
+						 BPF_MA_PERCPU, NULL);
 			if (err)
 				goto free_map_locked;
 		}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 3ad2e25946b5..454c86596111 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -383,7 +383,7 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
  * kmalloc/kfree. Max allocation size is 4096 in this case.
  * This is bpf_dynptr and bpf_kptr use case.
  */
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu,
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, unsigned int flags,
 		       void (*ctor)(struct bpf_mem_alloc *, void *))
 {
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
@@ -391,7 +391,9 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu,
 	struct bpf_mem_cache *c, __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
 	int cpu, i, unit_size, percpu_size = 0;
+	bool percpu = (flags & BPF_MA_PERCPU);
 
+	ma->flags = flags;
 	ma->ctor = ctor;
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
-- 
2.29.2


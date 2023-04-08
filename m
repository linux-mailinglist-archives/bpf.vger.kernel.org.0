Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F16DBB3B
	for <lists+bpf@lfdr.de>; Sat,  8 Apr 2023 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDHNr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Apr 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjDHNry (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Apr 2023 09:47:54 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE768D530;
        Sat,  8 Apr 2023 06:47:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PtxPw0PzVz4f40lX;
        Sat,  8 Apr 2023 21:47:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCH77J_cDFk6gboGw--.47910S7;
        Sat, 08 Apr 2023 21:47:49 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC bpf-next v2 3/4] bpf: Pass bitwise flags to bpf_mem_alloc_init()
Date:   Sat,  8 Apr 2023 22:18:45 +0800
Message-Id: <20230408141846.1878768-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230408141846.1878768-1-houtao@huaweicloud.com>
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77J_cDFk6gboGw--.47910S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGr43Gw43ZFykuF13Wry7Awb_yoWrKF1UpF
        WxGF40yr4qqFs7ua17trs7Aa45X340g3WIkayUXryrZry5Wr1DWr4kJry3XF909r4jka1f
        ArnYgrW0934UXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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
X-Spam-Status: No, score=0.0 required=5.0 tests=KHOP_HELO_FCRDNS,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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
 kernel/bpf/cpumask.c          | 2 +-
 kernel/bpf/hashtab.c          | 5 +++--
 kernel/bpf/memalloc.c         | 8 +++++++-
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 3929be5743f4..148347950e16 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -12,6 +12,12 @@ struct bpf_mem_alloc {
 	struct bpf_mem_caches __percpu *caches;
 	struct bpf_mem_cache __percpu *cache;
 	struct work_struct work;
+	unsigned int flags;
+};
+
+/* flags for bpf_mem_alloc_init() */
+enum {
+	BPF_MA_PERCPU = 1U << 0,
 };
 
 /* 'size != 0' is for bpf_mem_alloc which manages fixed-size objects.
@@ -21,7 +27,7 @@ struct bpf_mem_alloc {
  * Alloc and free are done with bpf_mem_{alloc,free}() and the size of
  * the returned object is given by the size argument of bpf_mem_alloc().
  */
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, unsigned int flags);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
 /* kmalloc/kfree equivalent: */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b297e9f60ca1..fb4275afd1ad 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2762,7 +2762,7 @@ static int __init bpf_global_ma_init(void)
 {
 	int ret;
 
-	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
+	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, 0);
 	bpf_global_ma_set = !ret;
 	return ret;
 }
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 7efdf5d770ca..f40636796f75 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -445,7 +445,7 @@ static int __init cpumask_kfunc_init(void)
 		},
 	};
 
-	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), false);
+	ret = bpf_mem_alloc_init(&bpf_cpumask_ma, sizeof(struct bpf_cpumask), 0);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &cpumask_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &cpumask_kfunc_set);
 	return  ret ?: register_btf_id_dtor_kfuncs(cpumask_dtors,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 00c253b84bf5..93009b94ac9b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -576,12 +576,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, 0);
 		if (err)
 			goto free_map_locked;
 		if (percpu) {
 			err = bpf_mem_alloc_init(&htab->pcpu_ma,
-						 round_up(htab->map.value_size, 8), true);
+						 round_up(htab->map.value_size, 8),
+						 BPF_MA_PERCPU);
 			if (err)
 				goto free_map_locked;
 		}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0668bcd7c926..072102476019 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -98,6 +98,7 @@ struct bpf_mem_cache {
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
 	int percpu_size;
+	unsigned int flags;
 
 	struct rcu_head rcu;
 	struct llist_head free_by_rcu;
@@ -377,13 +378,14 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
  * kmalloc/kfree. Max allocation size is 4096 in this case.
  * This is bpf_dynptr and bpf_kptr use case.
  */
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, unsigned int flags)
 {
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
 	struct bpf_mem_caches *cc, __percpu *pcc;
 	struct bpf_mem_cache *c, __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
 	int cpu, i, unit_size, percpu_size = 0;
+	bool percpu = (flags & BPF_MA_PERCPU);
 
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
@@ -406,9 +408,11 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->unit_size = unit_size;
 			c->objcg = objcg;
 			c->percpu_size = percpu_size;
+			c->flags = flags;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
+		ma->flags = flags;
 		return 0;
 	}
 
@@ -428,10 +432,12 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c = &cc->cache[i];
 			c->unit_size = sizes[i];
 			c->objcg = objcg;
+			c->flags = flags;
 			prefill_mem_cache(c, cpu);
 		}
 	}
 	ma->caches = pcc;
+	ma->flags = flags;
 	return 0;
 }
 
-- 
2.29.2


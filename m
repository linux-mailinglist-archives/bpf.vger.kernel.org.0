Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730C969779C
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 08:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjBOHxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 02:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjBOHxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 02:53:16 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2BC29E18
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 23:53:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PGr0k177xz4f3l1p
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 15:53:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7Jjj+xjJrigDg--.18949S5;
        Wed, 15 Feb 2023 15:53:12 +0800 (CST)
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
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        houtao1@huawei.com
Subject: [PATCH bpf-next 1/2] bpf: Zeroing allocated object from slab in bpf memory allocator
Date:   Wed, 15 Feb 2023 16:21:31 +0800
Message-Id: <20230215082132.3856544-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230215082132.3856544-1-houtao@huaweicloud.com>
References: <20230215082132.3856544-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7Jjj+xjJrigDg--.18949S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZF13Gr1kWF47WFyfKFWkCrg_yoWrGF4xpF
        ZxWr4UGr48ZFs7A390qws3Cay7Awn3Ww1UKa98K34Yvr1Sqr9rWw1kJFyaqFy3Cr4vyF4r
        tFZ293yFy3yUu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2mL9UUUUU
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

Currently the freed element in bpf memory allocator may be immediately
reused, for htab map the reuse will reinitialize special fields in map
value (e.g., bpf_spin_lock), but lookup procedure may still access
these special fields, and it may lead to hard-lockup as shown below:

 NMI backtrace for cpu 16
 CPU: 16 PID: 2574 Comm: htab.bin Tainted: G             L     6.1.0+ #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
 RIP: 0010:queued_spin_lock_slowpath+0x283/0x2c0
 ......
 Call Trace:
  <TASK>
  copy_map_value_locked+0xb7/0x170
  bpf_map_copy_value+0x113/0x3c0
  __sys_bpf+0x1c67/0x2780
  __x64_sys_bpf+0x1c/0x20
  do_syscall_64+0x30/0x60
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
 ......
  </TASK>

For htab map, just like the preallocated case, these is no need to
initialize these special fields in map value again once these fields
have been initialized. For preallocated htab map, these fields are
initialized through __GFP_ZERO in bpf_map_area_alloc(), so do the
similar thing for non-preallocated htab in bpf memory allocator. And
there is no need to use __GFP_ZERO for per-cpu bpf memory allocator,
because __alloc_percpu_gfp() does it implicitly.

Fixes: 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h   | 7 +++++++
 kernel/bpf/hashtab.c  | 4 ++--
 kernel/bpf/memalloc.c | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be34f7deb6c3..520b238abd5a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -363,6 +363,13 @@ static inline void bpf_obj_init(const struct btf_field_offs *foffs, void *obj)
 		memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
 }
 
+/* 'dst' must be a temporary buffer and should not point to memory that is being
+ * used in parallel by a bpf program or bpf syscall, otherwise the access from
+ * the bpf program or bpf syscall may be corrupted by the reinitialization,
+ * leading to weird problems. Even 'dst' is newly-allocated from bpf memory
+ * allocator, it is still possible for 'dst' to be used in parallel by a bpf
+ * program or bpf syscall.
+ */
 static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 {
 	bpf_obj_init(map->field_offs, dst);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 66bded144377..5dfcb5ad0d06 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1004,8 +1004,6 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			l_new = ERR_PTR(-ENOMEM);
 			goto dec_count;
 		}
-		check_and_init_map_value(&htab->map,
-					 l_new->key + round_up(key_size, 8));
 	}
 
 	memcpy(l_new->key, key, key_size);
@@ -1592,6 +1590,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 			else
 				copy_map_value(map, value, l->key +
 					       roundup_key_size);
+			/* Zeroing special fields in the temp buffer */
 			check_and_init_map_value(map, value);
 		}
 
@@ -1792,6 +1791,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 						      true);
 			else
 				copy_map_value(map, dst_val, value);
+			/* Zeroing special fields in the temp buffer */
 			check_and_init_map_value(map, dst_val);
 		}
 		if (do_delete) {
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 490d03a4581a..5fcdacbb8439 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -143,7 +143,7 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
 		return obj;
 	}
 
-	return kmalloc_node(c->unit_size, flags, node);
+	return kmalloc_node(c->unit_size, flags | __GFP_ZERO, node);
 }
 
 static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
-- 
2.29.2


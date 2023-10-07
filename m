Return-Path: <bpf+bounces-11617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1743D7BC807
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 15:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD41281EEE
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE9E26E0A;
	Sat,  7 Oct 2023 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A4262B1
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 13:50:01 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFBCC2
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 06:50:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S2mrJ42nWz4f3knQ
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 21:49:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnvdz9YSFl4YF2CQ--.30763S9;
	Sat, 07 Oct 2023 21:49:57 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH bpf-next 5/6] bpf: Use bpf_global_percpu_ma for per-cpu kptr in __bpf_obj_drop_impl()
Date: Sat,  7 Oct 2023 21:51:05 +0800
Message-Id: <20231007135106.3031284-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231007135106.3031284-1-houtao@huaweicloud.com>
References: <20231007135106.3031284-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnvdz9YSFl4YF2CQ--.30763S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1xGryxGrWkZrWkCrW8Crg_yoW7uF1UpF
	4ftr12yr4kJFs2q3s8Gw4I9ryFqrW5Xa47G34kG34Fyr4avryDZw18CFyxua45trW8Kr1I
	y3Z09ry3A3y8AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

The following warning was reported when running "./test_progs -t
test_bpf_ma/percpu_free_through_map_free":

  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 68 at kernel/bpf/memalloc.c:342
  CPU: 1 PID: 68 Comm: kworker/u16:2 Not tainted 6.6.0-rc2+ #222
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  Workqueue: events_unbound bpf_map_free_deferred
  RIP: 0010:bpf_mem_refill+0x21c/0x2a0
  ......
  Call Trace:
   <IRQ>
   ? bpf_mem_refill+0x21c/0x2a0
   irq_work_single+0x27/0x70
   irq_work_run_list+0x2a/0x40
   irq_work_run+0x18/0x40
   __sysvec_irq_work+0x1c/0xc0
   sysvec_irq_work+0x73/0x90
   </IRQ>
   <TASK>
   asm_sysvec_irq_work+0x1b/0x20
  RIP: 0010:unit_free+0x50/0x80
   ......
   bpf_mem_free+0x46/0x60
   __bpf_obj_drop_impl+0x40/0x90
   bpf_obj_free_fields+0x17d/0x1a0
   array_map_free+0x6b/0x170
   bpf_map_free_deferred+0x54/0xa0
   process_scheduled_works+0xba/0x370
   worker_thread+0x16d/0x2e0
   kthread+0x105/0x140
   ret_from_fork+0x39/0x60
   ret_from_fork_asm+0x1b/0x30
   </TASK>
  ---[ end trace 0000000000000000 ]---

The reason is simple: __bpf_obj_drop_impl() does not know the freeing
field is a per-cpu pointer and it uses bpf_global_ma to free the
pointer. Because bpf_global_ma is not a per-cpu allocator, so ksize() is
used to select the corresponding cache. The bpf_mem_cache with 16-bytes
unit_size will always be selected to do the unmatched free and it will
trigger the warning in free_bulk() eventually.

Because per-cpu kptr doesn't support list or rb-tree now, so fix the
problem by only checking whether or not the type of kptr is per-cpu in
bpf_obj_free_fields(), and using bpf_global_percpu_ma to these kptrs.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c  | 22 ++++++++++++++--------
 kernel/bpf/internal.h |  2 +-
 kernel/bpf/syscall.c  |  4 ++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 07f49f8831c0..078217c921e8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1840,7 +1840,7 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
 		 * bpf_list_head which needs to be freed.
 		 */
 		migrate_disable();
-		__bpf_obj_drop_impl(obj, field->graph_root.value_rec);
+		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
 		migrate_enable();
 	}
 }
@@ -1879,7 +1879,7 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 
 
 		migrate_disable();
-		__bpf_obj_drop_impl(obj, field->graph_root.value_rec);
+		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
 		migrate_enable();
 	}
 }
@@ -1911,8 +1911,10 @@ __bpf_kfunc void *bpf_percpu_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 }
 
 /* Must be called under migrate_disable(), as required by bpf_mem_free */
-void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
+void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu)
 {
+	struct bpf_mem_alloc *ma;
+
 	if (rec && rec->refcount_off >= 0 &&
 	    !refcount_dec_and_test((refcount_t *)(p + rec->refcount_off))) {
 		/* Object is refcounted and refcount_dec didn't result in 0
@@ -1924,10 +1926,14 @@ void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
 	if (rec)
 		bpf_obj_free_fields(rec, p);
 
+	if (percpu)
+		ma = &bpf_global_percpu_ma;
+	else
+		ma = &bpf_global_ma;
 	if (rec && rec->refcount_off >= 0)
-		bpf_mem_free_rcu(&bpf_global_ma, p);
+		bpf_mem_free_rcu(ma, p);
 	else
-		bpf_mem_free(&bpf_global_ma, p);
+		bpf_mem_free(ma, p);
 }
 
 __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
@@ -1935,7 +1941,7 @@ __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
 	struct btf_struct_meta *meta = meta__ign;
 	void *p = p__alloc;
 
-	__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
+	__bpf_obj_drop_impl(p, meta ? meta->record : NULL, false);
 }
 
 __bpf_kfunc void bpf_percpu_obj_drop_impl(void *p__alloc, void *meta__ign)
@@ -1979,7 +1985,7 @@ static int __bpf_list_add(struct bpf_list_node_kern *node,
 	 */
 	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
 		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl((void *)n - off, rec);
+		__bpf_obj_drop_impl((void *)n - off, rec, false);
 		return -EINVAL;
 	}
 
@@ -2078,7 +2084,7 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root,
 	 */
 	if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
 		/* Only called from BPF prog, no need to migrate_disable */
-		__bpf_obj_drop_impl((void *)n - off, rec);
+		__bpf_obj_drop_impl((void *)n - off, rec, false);
 		return -EINVAL;
 	}
 
diff --git a/kernel/bpf/internal.h b/kernel/bpf/internal.h
index e233ea83eb0a..4c3cfdd6e6a2 100644
--- a/kernel/bpf/internal.h
+++ b/kernel/bpf/internal.h
@@ -6,6 +6,6 @@
 
 struct btf_record;
 
-void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
+void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
 #endif /* __BPF_INTERNAL_H_ */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7de4b9f97c8f..8dfc5d39c91d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -662,8 +662,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 									   field->kptr.btf_id);
 				migrate_disable();
 				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
-								 pointee_struct_meta->record :
-								 NULL);
+								 pointee_struct_meta->record : NULL,
+								 fields[i].type == BPF_KPTR_PERCPU);
 				migrate_enable();
 			} else {
 				field->kptr.dtor(xchgd_field);
-- 
2.29.2



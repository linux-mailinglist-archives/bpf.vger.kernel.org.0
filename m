Return-Path: <bpf+bounces-12559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3217CDA75
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD5A1C20C90
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A720B23;
	Wed, 18 Oct 2023 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC52D020
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:32:43 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF718E
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 04:32:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4S9TGh2fXcz4f3mJN
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 19:32:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnfd1Mwi9l9jYmDQ--.41845S7;
	Wed, 18 Oct 2023 19:32:33 +0800 (CST)
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
Subject: [PATCH bpf-next v2 3/7] bpf: Re-enable unit_size checking for global per-cpu allocator
Date: Wed, 18 Oct 2023 19:33:39 +0800
Message-Id: <20231018113343.2446300-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231018113343.2446300-1-houtao@huaweicloud.com>
References: <20231018113343.2446300-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnfd1Mwi9l9jYmDQ--.41845S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyfXr4kGrWktw4xCFWfZrb_yoW8Zry8pF
	WxGFyfKwsYvFWxAw1Iqr4kCay3Jw4kG3W7Jayag348ZrW8ZF1jgws8Jry5WFWFkrZ5CF13
	trZ5KF4xAFW5A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

With pcpu_alloc_size() in place, check whether or not the size of
the dynamic per-cpu area is matched with unit_size.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 3037f3e809d8..e52ef1e106ae 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -497,21 +497,17 @@ static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
 	struct llist_node *first;
 	unsigned int obj_size;
 
-	/* For per-cpu allocator, the size of free objects in free list doesn't
-	 * match with unit_size and now there is no way to get the size of
-	 * per-cpu pointer saved in free object, so just skip the checking.
-	 */
-	if (c->percpu_size)
-		return 0;
-
 	first = c->free_llist.first;
 	if (!first)
 		return 0;
 
-	obj_size = ksize(first);
+	if (c->percpu_size)
+		obj_size = pcpu_alloc_size(((void **)first)[1]);
+	else
+		obj_size = ksize(first);
 	if (obj_size != c->unit_size) {
-		WARN_ONCE(1, "bpf_mem_cache[%u]: unexpected object size %u, expect %u\n",
-			  idx, obj_size, c->unit_size);
+		WARN_ONCE(1, "bpf_mem_cache[%u]: percpu %d, unexpected object size %u, expect %u\n",
+			  idx, c->percpu_size, obj_size, c->unit_size);
 		return -EINVAL;
 	}
 	return 0;
@@ -979,6 +975,12 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
 
+/* The alignment of dynamic per-cpu area is 8, so c->unit_size and the
+ * actual size of dynamic per-cpu area will always be matched and there is
+ * no need to adjust size_index for per-cpu allocation. However for the
+ * simplicity of the implementation, use an unified size_index for both
+ * kmalloc and per-cpu allocation.
+ */
 static __init int bpf_mem_cache_adjust_size(void)
 {
 	unsigned int size;
-- 
2.29.2



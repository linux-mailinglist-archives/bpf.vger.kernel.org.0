Return-Path: <bpf+bounces-12560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9FD7CDA77
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 13:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975C3281C25
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD12E63E;
	Wed, 18 Oct 2023 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840E2D789
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 11:32:44 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D604193
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 04:32:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4S9TGl49mNz4f3n6R
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 19:32:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnfd1Mwi9l9jYmDQ--.41845S8;
	Wed, 18 Oct 2023 19:32:34 +0800 (CST)
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
Subject: [PATCH bpf-next v2 4/7] bpf: Use pcpu_alloc_size() in bpf_mem_free{_rcu}()
Date: Wed, 18 Oct 2023 19:33:40 +0800
Message-Id: <20231018113343.2446300-5-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnfd1Mwi9l9jYmDQ--.41845S8
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrCw1UJry8uFykArWrZrb_yoW5JrW7pF
	W7Kr10yr4kXF4rG3W2gr1xAa45Jw1Ig3WxKa47ury5uFWfWr1DGr4kGry7XFn09rWUGaya
	yrykKr4fCrWUA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

For bpf_global_percpu_ma, the pointer passed to bpf_mem_free_rcu() is
allocated by kmalloc() and its size is fixed (16-bytes on x86-64). So
no matter which cache allocates the dynamic per-cpu area, on x86-64
cache[2] will always be used to free the per-cpu area.

Fix the unbalance by checking whether the bpf memory allocator is
per-cpu or not and use pcpu_alloc_size() instead of ksize() to
find the correct cache for per-cpu free.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |  1 +
 kernel/bpf/memalloc.c         | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index d644bbb298af..bb1223b21308 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -11,6 +11,7 @@ struct bpf_mem_caches;
 struct bpf_mem_alloc {
 	struct bpf_mem_caches __percpu *caches;
 	struct bpf_mem_cache __percpu *cache;
+	bool percpu;
 	struct work_struct work;
 };
 
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index e52ef1e106ae..43bd4ce3947b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -531,6 +531,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	/* room for llist_node and per-cpu pointer */
 	if (percpu)
 		percpu_size = LLIST_NODE_SZ + sizeof(void *);
+	ma->percpu = percpu;
 
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
@@ -880,6 +881,17 @@ void notrace *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size)
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
 
+static notrace int bpf_mem_free_idx(void *ptr, bool percpu)
+{
+	size_t size;
+
+	if (percpu)
+		size = pcpu_alloc_size(*((void **)ptr));
+	else
+		size = ksize(ptr - LLIST_NODE_SZ);
+	return bpf_mem_cache_idx(size);
+}
+
 void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
 {
 	int idx;
@@ -887,7 +899,7 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
 	if (!ptr)
 		return;
 
-	idx = bpf_mem_cache_idx(ksize(ptr - LLIST_NODE_SZ));
+	idx = bpf_mem_free_idx(ptr, ma->percpu);
 	if (idx < 0)
 		return;
 
@@ -901,7 +913,7 @@ void notrace bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
 	if (!ptr)
 		return;
 
-	idx = bpf_mem_cache_idx(ksize(ptr - LLIST_NODE_SZ));
+	idx = bpf_mem_free_idx(ptr, ma->percpu);
 	if (idx < 0)
 		return;
 
-- 
2.29.2



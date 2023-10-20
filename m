Return-Path: <bpf+bounces-12821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC557D108C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73F7FB21561
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346151CF83;
	Fri, 20 Oct 2023 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1091BDDA
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 13:31:02 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646501A4
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:30:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBlpQ4rRFz4f3kpX
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 21:30:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBn+dgIgTJlmYjjDQ--.7231S7;
	Fri, 20 Oct 2023 21:30:56 +0800 (CST)
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
Subject: [PATCH bpf-next v3 3/7] bpf: Re-enable unit_size checking for global per-cpu allocator
Date: Fri, 20 Oct 2023 21:31:58 +0800
Message-Id: <20231020133202.4043247-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20231020133202.4043247-1-houtao@huaweicloud.com>
References: <20231020133202.4043247-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn+dgIgTJlmYjjDQ--.7231S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyfXr4kGrWkKrW7uFy3Jwb_yoW8ZryrpF
	WxKFyfGwsYvFW8Zw1Iqr4kCa13Jw4kG3W7Jayag348ZrW8ZF1jgw45Gry3WFWFkrZ5CF43
	tFWvkF4xAF45A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

From: Hou Tao <houtao1@huawei.com>

With pcpu_alloc_size() in place, check whether or not the size of
the dynamic per-cpu area is matched with unit_size.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 39ea316c55e79..776bdf5ffd80b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -491,21 +491,17 @@ static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
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
@@ -973,6 +969,12 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
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



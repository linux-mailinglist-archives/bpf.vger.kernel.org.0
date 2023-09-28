Return-Path: <bpf+bounces-11027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3A7B1822
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 12:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B2050281CCF
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02D4347DF;
	Thu, 28 Sep 2023 10:16:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367E8821
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 10:16:18 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC5F9C
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 03:16:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx8Wt6zF2z4f3nbq
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 18:16:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnt9ZnUhVlrrtkBg--.57931S4;
	Thu, 28 Sep 2023 18:16:09 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
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
	Nathan Chancellor <nathan@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	houtao1@huawei.com
Subject: [PATCH bpf] bpf: Use kmalloc_size_roundup() to adjust size_index
Date: Thu, 28 Sep 2023 18:15:58 +0800
Message-Id: <20230928101558.2594068-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnt9ZnUhVlrrtkBg--.57931S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47GFWxtw4UCw1DGw4xtFb_yoW5ur1rpr
	43tw1IyF98XFyxCr129a18u3yrWw1kG3W7Gay3X348Zry5Cr1xWrWqg3yrWFy0vrZa9a43
	XF4DKr4Fgw4rJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hou Tao <houtao1@huawei.com>

Commit d52b59315bf5 ("bpf: Adjust size_index according to the value of
KMALLOC_MIN_SIZE") uses KMALLOC_MIN_SIZE to adjust size_index, but as
reported by Nathan, the adjustment is not enough, because
__kmalloc_minalign() also decides the minimal alignment of slab object
as shown in new_kmalloc_cache() and its value may be greater than
KMALLOC_MIN_SIZE (e.g., 64 bytes vs 8 bytes under a riscv QEMU VM).

Instead of invoking __kmalloc_minalign() in bpf subsystem to find the
maximal alignment, just using kmalloc_size_roundup() directly to get the
corresponding slab object size for each allocation size. If these two
sizes are unmatched, adjust size_index to select a bpf_mem_cache with
unit_size equal to the object_size of the underlying slab cache for the
allocation size.

Fixes: 822fb26bdb55 ("bpf: Add a hint to allocated objects.")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/bpf/20230914181407.GA1000274@dev-arch.thelio-3990X/
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/memalloc.c | 44 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 1c22b90e754a..06fbb5168482 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -958,37 +958,31 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
 
-/* Most of the logic is taken from setup_kmalloc_cache_index_table() */
 static __init int bpf_mem_cache_adjust_size(void)
 {
-	unsigned int size, index;
+	unsigned int size;
 
-	/* Normally KMALLOC_MIN_SIZE is 8-bytes, but it can be
-	 * up-to 256-bytes.
+	/* Adjusting the indexes in size_index() according to the object_size
+	 * of underlying slab cache, so bpf_mem_alloc() will select a
+	 * bpf_mem_cache with unit_size equal to the object_size of
+	 * the underlying slab cache.
+	 *
+	 * The maximal value of KMALLOC_MIN_SIZE and __kmalloc_minalign() is
+	 * 256-bytes, so only do adjustment for [8-bytes, 192-bytes].
 	 */
-	size = KMALLOC_MIN_SIZE;
-	if (size <= 192)
-		index = size_index[(size - 1) / 8];
-	else
-		index = fls(size - 1) - 1;
-	for (size = 8; size < KMALLOC_MIN_SIZE && size <= 192; size += 8)
-		size_index[(size - 1) / 8] = index;
+	for (size = 192; size >= 8; size -= 8) {
+		unsigned int kmalloc_size, index;
 
-	/* The minimal alignment is 64-bytes, so disable 96-bytes cache and
-	 * use 128-bytes cache instead.
-	 */
-	if (KMALLOC_MIN_SIZE >= 64) {
-		index = size_index[(128 - 1) / 8];
-		for (size = 64 + 8; size <= 96; size += 8)
-			size_index[(size - 1) / 8] = index;
-	}
+		kmalloc_size = kmalloc_size_roundup(size);
+		if (kmalloc_size == size)
+			continue;
 
-	/* The minimal alignment is 128-bytes, so disable 192-bytes cache and
-	 * use 256-bytes cache instead.
-	 */
-	if (KMALLOC_MIN_SIZE >= 128) {
-		index = fls(256 - 1) - 1;
-		for (size = 128 + 8; size <= 192; size += 8)
+		if (kmalloc_size <= 192)
+			index = size_index[(kmalloc_size - 1) / 8];
+		else
+			index = fls(kmalloc_size - 1) - 1;
+		/* Only overwrite if necessary */
+		if (size_index[(size - 1) / 8] != index)
 			size_index[(size - 1) / 8] = index;
 	}
 
-- 
2.29.2



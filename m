Return-Path: <bpf+bounces-43125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 425949AF696
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 03:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F02DB20FC9
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E432AE84;
	Fri, 25 Oct 2024 01:20:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36081101E2
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819230; cv=none; b=Z1Xv3lqC4h39TqvCelivSJQq14xI468RihClvgpC/pUSKt4T5/P0h6KryEoPZwih24rqBeeqz5AHNw1SBxnhruCLnDvJrYi8W7chXjeVfieTHaPUxA8le++uiPh5adQ/77hz0mN15wjuAXZmKD9nVwTwUg73uBD3ZkEr9KwKle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819230; c=relaxed/simple;
	bh=bsl7zSI0Z2/07tz7PtPMyP0Vmk/WmN3dcQwUArY4KK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3UiW3cehJQQj3v6SSAaqsU8bUcppGX2ifnjtj+5/bbKUUqewo0BPCP5c4gY2N3tliC/nfYwwFCg6g03JKziqwtjGjZrPRDhtKwKmR4sQEf74asx1P44BVbB4nUT/Xb6l89y+8gD+boyt1utgoEBVSNQWPma6A6zDHAOuEDPUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZQ1z6NxGz4f3jXJ
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6365E1A0196
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCn28dU8hpnhzUqFA--.57458S6;
	Fri, 25 Oct 2024 09:20:25 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v3 2/5] bpf: Add bpf_mem_alloc_check_size() helper
Date: Fri, 25 Oct 2024 09:32:30 +0800
Message-Id: <20241025013233.804027-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241025013233.804027-1-houtao@huaweicloud.com>
References: <20241025013233.804027-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn28dU8hpnhzUqFA--.57458S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17Aw1rCFW3uF18ZrW7CFg_yoW5JryxpF
	W7tr18AFs8JF48W3W2gw1xAas8Xw40g3W7tay7XryUZF93GrnrWFs8Jry7WF9ayrW5Aayx
	JrnYgrWfAryUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UCZXrU
	UUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Introduce bpf_mem_alloc_check_size() to check whether the allocation
size exceeds the limitation for the kmalloc-equivalent allocator. The
upper limit for percpu allocation is LLIST_NODE_SZ bytes larger than
non-percpu allocation, so a percpu argument is added to the helper.

The helper will be used in the following patch to check whether the size
parameter passed to bpf_mem_alloc() is too big.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |  3 +++
 kernel/bpf/memalloc.c         | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index aaf004d94322..e45162ef59bb 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -33,6 +33,9 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
+/* Check the allocation size for kmalloc equivalent allocator */
+int bpf_mem_alloc_check_size(bool percpu, size_t size);
+
 /* kmalloc/kfree equivalent: */
 void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
 void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index b3858a76e0b3..146f5b57cfb1 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -35,6 +35,8 @@
  */
 #define LLIST_NODE_SZ sizeof(struct llist_node)
 
+#define BPF_MEM_ALLOC_SIZE_MAX 4096
+
 /* similar to kmalloc, but sizeof == 8 bucket is gone */
 static u8 size_index[24] __ro_after_init = {
 	3,	/* 8 */
@@ -65,7 +67,7 @@ static u8 size_index[24] __ro_after_init = {
 
 static int bpf_mem_cache_idx(size_t size)
 {
-	if (!size || size > 4096)
+	if (!size || size > BPF_MEM_ALLOC_SIZE_MAX)
 		return -1;
 
 	if (size <= 192)
@@ -1005,3 +1007,13 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
+
+int bpf_mem_alloc_check_size(bool percpu, size_t size)
+{
+	/* The size of percpu allocation doesn't have LLIST_NODE_SZ overhead */
+	if ((percpu && size > BPF_MEM_ALLOC_SIZE_MAX) ||
+	    (!percpu && size > BPF_MEM_ALLOC_SIZE_MAX - LLIST_NODE_SZ))
+		return -E2BIG;
+
+	return 0;
+}
-- 
2.29.2



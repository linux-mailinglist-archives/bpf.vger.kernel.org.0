Return-Path: <bpf+bounces-43129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F129AF699
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 03:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C471C211A4
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1457C433CE;
	Fri, 25 Oct 2024 01:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0130C8DF
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819232; cv=none; b=PoZr256LGZUS/K3i+8jAFbWvhqelA2T/I7SOIwFnfY2sOzp4aeBSb6eRjdeo1HvhR6rttGQNMfd3mov/g8PCl4VjRPiFfBnnTnNoTRujP8Joryc1qlQz2TiOG3+bhWZUtPK9cbBmxdxO2oBGJzk4aMEPtOt+hKqqZ7v3fFMvJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819232; c=relaxed/simple;
	bh=LHCPDr51jp8tVzf7wGEQjFJio98kSF4ByHIAACfT4Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OUtB+zrQ9kiG92E5nvNsIbdOCtbyqxrVt3pRKDzboLm+8eO9vuSAhGMxlRr1KPYcgJVxkPkFGcyd+MG3SRF6j052KhMxVt/7bY7NM54/i29QBYbC4zOAcMGacfYXjaEHcWeJbs2qwjO2J9BFvJcOTy/1uhnrrLtxZhdw6ZoMuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZQ203T25z4f3jXl
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F2FAB1A0359
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCn28dU8hpnhzUqFA--.57458S7;
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
Subject: [PATCH bpf v3 3/5] bpf: Check the validity of nr_words in bpf_iter_bits_new()
Date: Fri, 25 Oct 2024 09:32:31 +0800
Message-Id: <20241025013233.804027-4-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28dU8hpnhzUqFA--.57458S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWF17JF45ZFyxKFWxKw45Wrg_yoW5CF1rpF
	4fJ3ZxAr48JF42gw1Dta1UCa4rX34vqay7GFWxJr1S9Fs5WrnF9r12gr1Yqas3CrWjyF12
	vryv9ryfZayDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Check the validity of nr_words in bpf_iter_bits_new(). Without this
check, when multiplication overflow occurs for nr_bits (e.g., when
nr_words = 0x0400-0001, nr_bits becomes 64), stack corruption may occur
due to bpf_probe_read_kernel_common(..., nr_bytes = 0x2000-0008).

Fix it by limiting the maximum value of nr_words to 511. The value is
derived from the current implementation of BPF memory allocator. To
ensure compatibility if the BPF memory allocator's size limitation
changes in the future, use the helper bpf_mem_alloc_check_size() to
check whether nr_bytes is too larger. And return -E2BIG instead of
-ENOMEM for oversized nr_bytes.

Fixes: 4665415975b0 ("bpf: Add bits iterator")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 40ef6a56619f..daec74820dbe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
 	__u64 __opaque[2];
 } __aligned(8);
 
+#define BITS_ITER_NR_WORDS_MAX 511
+
 struct bpf_iter_bits_kern {
 	union {
 		unsigned long *bits;
@@ -2865,7 +2867,8 @@ struct bpf_iter_bits_kern {
  * @it: The new bpf_iter_bits to be created
  * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated over
  * @nr_words: The size of the specified memory area, measured in 8-byte units.
- * Due to the limitation of memalloc, it can't be greater than 512.
+ * The maximum value of @nr_words is @BITS_ITER_NR_WORDS_MAX. This limit may be
+ * further reduced by the BPF memory allocator implementation.
  *
  * This function initializes a new bpf_iter_bits structure for iterating over
  * a memory area which is specified by the @unsafe_ptr__ign and @nr_words. It
@@ -2878,8 +2881,7 @@ __bpf_kfunc int
 bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_words)
 {
 	struct bpf_iter_bits_kern *kit = (void *)it;
-	u32 nr_bytes = nr_words * sizeof(u64);
-	u32 nr_bits = BYTES_TO_BITS(nr_bytes);
+	u32 nr_bytes, nr_bits;
 	int err;
 
 	BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
@@ -2892,9 +2894,14 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 
 	if (!unsafe_ptr__ign || !nr_words)
 		return -EINVAL;
+	if (nr_words > BITS_ITER_NR_WORDS_MAX)
+		return -E2BIG;
+
+	nr_bytes = nr_words * sizeof(u64);
+	nr_bits = BYTES_TO_BITS(nr_bytes);
 
 	/* Optimization for u64 mask */
-	if (nr_bits == 64) {
+	if (nr_words == 1) {
 		err = bpf_probe_read_kernel_common(&kit->bits_copy, nr_bytes, unsafe_ptr__ign);
 		if (err)
 			return -EFAULT;
@@ -2903,6 +2910,9 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 		return 0;
 	}
 
+	if (bpf_mem_alloc_check_size(false, nr_bytes))
+		return -E2BIG;
+
 	/* Fallback to memalloc */
 	kit->bits = bpf_mem_alloc(&bpf_global_ma, nr_bytes);
 	if (!kit->bits)
-- 
2.29.2



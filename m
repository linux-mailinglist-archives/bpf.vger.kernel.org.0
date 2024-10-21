Return-Path: <bpf+bounces-42557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5974B9A588C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D8B1F21EC8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05CDDDA8;
	Mon, 21 Oct 2024 01:28:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C71CA94
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474088; cv=none; b=ualXMcoDRqn6IkWkZfPG+wDgxR9Vw7Va8sDfh4q1F42UPZdntrhc+bhB4+6V7Q9MmhK11uCL7GbKlCjm6eEdRX2+yqFX37NecmGzyqhdjMCl2Kdc7iCayGcyvbQo03ep0BtenYJ+h6JzL5Qjz6S/8lhmLG6xQ0/XPP7+Se6AO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474088; c=relaxed/simple;
	bh=xOoOZaH/EKzefihbXcTRsTEtTKcRgPpTWSV11au2TIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRkDvo8g1GX0JM4BbxqHLVANvBC61NLegMTwt+vqlwjYaLenkOFBArvzIU3UZQT87kPPMDvGsmFXml54DVhprv3+n+giqMQHxIlxlj02PpO9+pRTaLtlru76U9TJ/xXlM44FbQHnQ4ehvdpQNfwwfkRtkZhPDVpKzYfLLt2cxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XWyNX0brJz4f3jXv
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6802E1A0359
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYXrhVnot2wEg--.32425S8;
	Mon, 21 Oct 2024 09:27:57 +0800 (CST)
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
Subject: [PATCH bpf v2 4/7] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
Date: Mon, 21 Oct 2024 09:40:01 +0800
Message-Id: <20241021014004.1647816-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241021014004.1647816-1-houtao@huaweicloud.com>
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYXrhVnot2wEg--.32425S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr17tF47Ww1UKF4fCryfJFb_yoW5JFyxpr
	43Xw1UKr48JFsFyw1Ut3W5Ka45Jrs09ayDGFs5trn0yF45WFyDur15Gr1aqa98KrZ8tFW7
	Zr1vk34Fy3yUCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

bpf_iter_bits_destroy() uses "kit->nr_bits <= 64" to check whether the
bits are dynamically allocated. However, the check is incorrect and may
cause a kmemleak as shown below:

unreferenced object 0xffff88812628c8c0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294727320
  hex dump (first 32 bytes):
	b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U.............
	f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ................
  backtrace (crc 781e32cc):
	[<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
	[<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
	[<00000000597124d6>] __alloc.isra.0+0x89/0xb0
	[<000000004ebfffcd>] alloc_bulk+0x2af/0x720
	[<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
	[<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
	[<000000008b616eac>] bpf_global_ma_init+0x19/0x30
	[<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
	[<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
	[<00000000b119f72f>] kernel_init+0x20/0x160
	[<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
	[<0000000004671da4>] ret_from_fork_asm+0x1a/0x30

That is because nr_bits will be set as zero in bpf_iter_bits_next()
after all bits have been iterated.

Fix the problem by not setting nr_bits to zero in bpf_iter_bits_next().
Instead, use "bits >= nr_bits" to indicate when iteration is completed
and still use "nr_bits > 64" to indicate when bits are dynamically
allocated.

Fixes: 4665415975b0 ("bpf: Add bits iterator")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..62349e206a29 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2888,7 +2888,7 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 
 	kit->nr_bits = 0;
 	kit->bits_copy = 0;
-	kit->bit = -1;
+	kit->bit = 0;
 
 	if (!unsafe_ptr__ign || !nr_words)
 		return -EINVAL;
@@ -2934,15 +2934,13 @@ __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
 	const unsigned long *bits;
 	int bit;
 
-	if (nr_bits == 0)
+	if (kit->bit >= nr_bits)
 		return NULL;
 
 	bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
 	bit = find_next_bit(bits, nr_bits, kit->bit + 1);
-	if (bit >= nr_bits) {
-		kit->nr_bits = 0;
+	if (bit >= nr_bits)
 		return NULL;
-	}
 
 	kit->bit = bit;
 	return &kit->bit;
-- 
2.29.2



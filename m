Return-Path: <bpf+bounces-43126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375129AF695
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 03:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F080A2832BB
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D138F97;
	Fri, 25 Oct 2024 01:20:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01121DDC7
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819231; cv=none; b=RrEWNn1+lBjE0fsP7o66xRANwlgCPgsUI/LGpE6eayWDW7e/3WJ/lTK+gIahJRAmEEX6pbSR+3EyB+oQOsu0Huw0mkdlErLcS25bxio66zwr6PVs1sMPKXGvesCtkB2Rm31Uo4FTId50TwuhyqZ9PvAZK1JTx7OZjn6cB0VGF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819231; c=relaxed/simple;
	bh=3eArzCgR4fVylrSZwC0Mb589KGREOCXwGbKq6KDBXHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuMXIM/adfOhlVf7YNsg/m7pMSIaCJa57WB+ikNbYe7a7RRGg0EyteiqUxStr8/dX8/NUOdx3yZJoLV387sE4woanNcaXfLEN9Dp+d29fxkEX0489O2io/v83pkTiJVSleYEmeJSok/F5Y2BG3nPA3Q4PBW0iPK8Z0vnH2v7nCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZQ1z2BQDz4f3jJ1
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C5AA01A058E
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCn28dU8hpnhzUqFA--.57458S5;
	Fri, 25 Oct 2024 09:20:24 +0800 (CST)
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
Subject: [PATCH bpf v3 1/5] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
Date: Fri, 25 Oct 2024 09:32:29 +0800
Message-Id: <20241025013233.804027-2-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28dU8hpnhzUqFA--.57458S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDXrWfCF48XFW8tF48Crg_yoW5Zr43pF
	W3uw1DKr4xJFW2yw1Uta1UKFy5Jw4qkay8GF4rtrn09F45WFyDuF18GryfXa90kr45tFW2
	vw1vk34Fy3yDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQU
	UUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

bpf_iter_bits_destroy() uses "kit->nr_bits <= 64" to check whether the
bits are dynamically allocated. However, the check is incorrect and may
cause a kmemleak as shown below:

unreferenced object 0xffff88812628c8c0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294727320
  hex dump (first 32 bytes):
	b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U...........
	f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ..............
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

Fix the issue by setting kit->bit to kit->nr_bits instead of setting
kit->nr_bits to zero when the iteration completes in
bpf_iter_bits_next(). In addition, use "!nr_bits || bits >= nr_bits" to
check whether the iteration is complete and still use "nr_bits > 64" to
indicate whether bits are dynamically allocated. The "!nr_bits" check is
necessary because bpf_iter_bits_new() may fail before setting
kit->nr_bits, and this condition will stop the iteration early instead
of accessing the zeroed or freed kit->bits.

Considering the initial value of kit->bits is -1 and the type of
kit->nr_bits is unsigned int, change the type of kit->nr_bits to int.
The potential overflow problem will be handled in the following patch.

Fixes: 4665415975b0 ("bpf: Add bits iterator")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..40ef6a56619f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2856,7 +2856,7 @@ struct bpf_iter_bits_kern {
 		unsigned long *bits;
 		unsigned long bits_copy;
 	};
-	u32 nr_bits;
+	int nr_bits;
 	int bit;
 } __aligned(8);
 
@@ -2930,17 +2930,16 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
 {
 	struct bpf_iter_bits_kern *kit = (void *)it;
-	u32 nr_bits = kit->nr_bits;
+	int bit = kit->bit, nr_bits = kit->nr_bits;
 	const unsigned long *bits;
-	int bit;
 
-	if (nr_bits == 0)
+	if (!nr_bits || bit >= nr_bits)
 		return NULL;
 
 	bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
-	bit = find_next_bit(bits, nr_bits, kit->bit + 1);
+	bit = find_next_bit(bits, nr_bits, bit + 1);
 	if (bit >= nr_bits) {
-		kit->nr_bits = 0;
+		kit->bit = bit;
 		return NULL;
 	}
 
-- 
2.29.2



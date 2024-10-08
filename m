Return-Path: <bpf+bounces-41218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B49943A6
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5704F1F2192D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D31C3F08;
	Tue,  8 Oct 2024 09:05:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE91C1AD6
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378314; cv=none; b=QFgMHx3f6f3yDtjGmgVsiqH5VvRELxm9E/5jo+XT5FJK1ZAKd9qiwDK87NvuXXg6jpf85NgxtINVWYuKEUnXYhZ7Fn0Rii21l3LUIIgPRWfTs99PZw52IJBHbKN8Vz3jFBiGUwg09HZfnDpAwzb+IFL6UegJP0IHtNDwciYSB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378314; c=relaxed/simple;
	bh=So5PuQ+HpYvlfp4tZKpa5I3L21tGfB5H6UZQvNZgsBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWAR60tVIFUwDEu+Vf5VqbUeELmtlq57kfV3m8zqdiehuZnHbo1q9dEUEh04fcQdXzODd0QZb6IofAa5YFNeXuzT/cLAyFWqDWt6SaBv5xj1peJLxOY7u/sOtFqy6l2EKVv+C1ArwziUZc8896slQAT/2Jb1GYRQ3NPmz3wX4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN9893Bgqz4f3jt0
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:04:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2B17D1A018D
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:05:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3yobB9QRnm_6TDQ--.2069S7;
	Tue, 08 Oct 2024 17:05:08 +0800 (CST)
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
Subject: [PATCH bpf 3/7] bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
Date: Tue,  8 Oct 2024 17:17:14 +0800
Message-Id: <20241008091718.3797027-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241008091718.3797027-1-houtao@huaweicloud.com>
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3yobB9QRnm_6TDQ--.2069S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAryDXrWfCF4DJrW5ZryfXrb_yoW5Aw1xpF
	43Ww1DCr48JF42yw1Dta1UKa45JrWq9ay8GF4rtr1Y9Fs8XFyDGr1UWryfWa90yr4jyF47
	Zryvk34rtrWkAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UA
	CztUUUUU=
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

Fix the problem by introducing an extra allocated status in
bpf_iter_bits and using it to indicate whether the bits are
dynamically allocated.

Fixes: 4665415975b0 ("bpf: Add bits iterator")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..9484b5f7c4c0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2856,7 +2856,8 @@ struct bpf_iter_bits_kern {
 		unsigned long *bits;
 		unsigned long bits_copy;
 	};
-	u32 nr_bits;
+	u32 allocated:1;
+	u32 nr_bits:31;
 	int bit;
 } __aligned(8);
 
@@ -2886,6 +2887,7 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
 		     __alignof__(struct bpf_iter_bits));
 
+	kit->allocated = 0;
 	kit->nr_bits = 0;
 	kit->bits_copy = 0;
 	kit->bit = -1;
@@ -2914,6 +2916,7 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 		return err;
 	}
 
+	kit->allocated = 1;
 	kit->nr_bits = nr_bits;
 	return 0;
 }
@@ -2937,7 +2940,7 @@ __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
 	if (nr_bits == 0)
 		return NULL;
 
-	bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
+	bits = !kit->allocated ? &kit->bits_copy : kit->bits;
 	bit = find_next_bit(bits, nr_bits, kit->bit + 1);
 	if (bit >= nr_bits) {
 		kit->nr_bits = 0;
@@ -2958,7 +2961,7 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
 {
 	struct bpf_iter_bits_kern *kit = (void *)it;
 
-	if (kit->nr_bits <= 64)
+	if (!kit->allocated)
 		return;
 	bpf_mem_free(&bpf_global_ma, kit->bits);
 }
-- 
2.29.2



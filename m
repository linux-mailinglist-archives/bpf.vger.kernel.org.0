Return-Path: <bpf+bounces-41222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C7E9943A8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F253B286AB8
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFB21CACF5;
	Tue,  8 Oct 2024 09:05:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3901BFE1F
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378316; cv=none; b=IrXnSRRMh9gd8wIRH8ngUhAEO6SzujKzq2+u15flmgCTBdNp+EzX2SfUVmdMwjuafcrnO9GzV//Nw9cfwTTR3wjpmftm9/szmb4pHQaWriZBMC1HkxlTdZCLGGubnYseqCgbMcv08yEm1qtBPCB+F+6T/2HOScKgUSj9PRBda3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378316; c=relaxed/simple;
	bh=9/sVyKO+NkasV49hNLx9A5NfqUQp5bAGVI/E3mJ4oyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzC3lgmGHX91+ohNNPNKNL/y3ftX6qFzTt1y78z9s3GfOOqUZffRUW8nYw0XuOCO22bSobG5ZVYQCJ/Qepzi5Pe4AZcLHpd/Qn+KO8ZuWlNMMqs8xX3Hl8sJiuBt88pBRBpDdpvtKwJrDzdMJ4H41ATOkYAAZQPDbS5+sum6HXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN98B4Zp4z4f3jsy
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:04:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5A3321A08FC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:05:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3yobB9QRnm_6TDQ--.2069S9;
	Tue, 08 Oct 2024 17:05:10 +0800 (CST)
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
Subject: [PATCH bpf 5/7] bpf: Change the type of unsafe_ptr in bpf_iter_bits_new()
Date: Tue,  8 Oct 2024 17:17:16 +0800
Message-Id: <20241008091718.3797027-6-houtao@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgB3yobB9QRnm_6TDQ--.2069S9
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1UXr4ktr43JF47ur15Jwb_yoW5Ary8pF
	4fA3ZrAr48XF42gw1qqFWUCa45Xw1vqa48GrWxJw4YgFs8urnruF15WryUJas3KryjyF12
	vry0k34UXFWkA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Under 32-bits host (e.g, arm32) , when a bpf program passes an u64 to
bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to save the
content of the u64, but the size of bits_copy is only 4-bytes, and there
will be stack corruption.

Fix it by change the type of unsafe_ptr from u64 * to unsigned long *.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6c0205d5018c..dee69c3904a0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2852,7 +2852,7 @@ struct bpf_iter_bits {
 } __aligned(8);
 
 /* nr_bits only has 31 bits */
-#define BITS_ITER_NR_WORDS_MAX ((1U << 31) / BITS_PER_TYPE(u64))
+#define BITS_ITER_NR_WORDS_MAX ((1U << 31) / BITS_PER_TYPE(unsigned long))
 
 struct bpf_iter_bits_kern {
 	union {
@@ -2868,8 +2868,9 @@ struct bpf_iter_bits_kern {
  * bpf_iter_bits_new() - Initialize a new bits iterator for a given memory area
  * @it: The new bpf_iter_bits to be created
  * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterated over
- * @nr_words: The size of the specified memory area, measured in 8-byte units.
- * Due to the limitation of memalloc, it can't be greater than 512.
+ * @nr_words: The size of the specified memory area, measured in units of
+ * sizeof(unsigned long). Due to the limitation of memalloc, it can't be
+ * greater than 512.
  *
  * This function initializes a new bpf_iter_bits structure for iterating over
  * a memory area which is specified by the @unsafe_ptr__ign and @nr_words. It
@@ -2879,17 +2880,18 @@ struct bpf_iter_bits_kern {
  * On success, 0 is returned. On failure, ERR is returned.
  */
 __bpf_kfunc int
-bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_words)
+bpf_iter_bits_new(struct bpf_iter_bits *it, const unsigned long *unsafe_ptr__ign, u32 nr_words)
 {
-	struct bpf_iter_bits_kern *kit = (void *)it;
-	u32 nr_bytes = nr_words * sizeof(u64);
+	u32 nr_bytes = nr_words * sizeof(*unsafe_ptr__ign);
 	u32 nr_bits = BYTES_TO_BITS(nr_bytes);
+	struct bpf_iter_bits_kern *kit;
 	int err;
 
 	BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) != sizeof(struct bpf_iter_bits));
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_bits_kern) !=
 		     __alignof__(struct bpf_iter_bits));
 
+	kit = (void *)it;
 	kit->allocated = 0;
 	kit->nr_bits = 0;
 	kit->bits_copy = 0;
@@ -2900,8 +2902,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 	if (nr_words > BITS_ITER_NR_WORDS_MAX)
 		return -E2BIG;
 
-	/* Optimization for u64 mask */
-	if (nr_bits == 64) {
+	/* Optimization for unsigned long mask */
+	if (nr_words == 1) {
 		err = bpf_probe_read_kernel_common(&kit->bits_copy, nr_bytes, unsafe_ptr__ign);
 		if (err)
 			return -EFAULT;
-- 
2.29.2



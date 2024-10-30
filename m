Return-Path: <bpf+bounces-43536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4417D9B5F46
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 10:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E9B283A6A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A21E260D;
	Wed, 30 Oct 2024 09:53:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D01E230F
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281996; cv=none; b=UP3mOm7gn71RvcW/rcDtTYmih4vU2ddDw7FfyEDH5y1HtmqQIA/J8KZsjWl4VwXJdisxUvzU+eC0TKNpL+00Ix5Utd0qB9POm5iHFyPXrvELu99Vc+JoGjkWmrnU+0+QbQxQ6CmdMpAosiaOXSUKXvwAfag1M8GmWhYlUHDSw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281996; c=relaxed/simple;
	bh=EQwhzztD65cJj2p7AqI5ixXDqyiNWK4zQiyj2ETYCa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jqdm0tpB7/qmZDscnoeHN/8QxJUY14Ut2ITNEFsENoZ/GPgbYpyTHXd9bZCxVqnTpiWzM+BgtNGdIZF2bmVVSxFjCd/sGDGUe36MRwCndcELVmMEUNUARqd1ALmIvFT5wGt51HX7anwS4kaI9m/+Y0y9xQfz4lUqG+HMo7MAQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xdj9J1ng6z4f3jdl
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:52:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EBEE11A0568
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:53:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4cAAiJn97dvAQ--.24244S7;
	Wed, 30 Oct 2024 17:53:09 +0800 (CST)
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
Subject: [PATCH bpf v4 3/5] bpf: Check the validity of nr_words in bpf_iter_bits_new()
Date: Wed, 30 Oct 2024 18:05:14 +0800
Message-Id: <20241030100516.3633640-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241030100516.3633640-1-houtao@huaweicloud.com>
References: <20241030100516.3633640-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4cAAiJn97dvAQ--.24244S7
X-Coremail-Antispam: 1UD129KBjvJXoW7KryUZFWxurW8Kw13GF4DJwb_yoW5JrykpF
	4fJ3s0yr48tF4xGw1Dtan7Ca4rX3yktw17GFZ7Jr1a9Fs5WFnF9r17Kr1Yqas3CrWjvF12
	vryv9rySvayDZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UA
	CztUUUUU=
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
 kernel/bpf/helpers.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d913a8f1fbd9..018985ebc5ce 100644
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
@@ -2892,6 +2895,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 
 	if (!unsafe_ptr__ign || !nr_words)
 		return -EINVAL;
+	if (nr_words > BITS_ITER_NR_WORDS_MAX)
+		return -E2BIG;
 
 	/* Optimization for u64 mask */
 	if (nr_bits == 64) {
@@ -2903,6 +2908,9 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
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



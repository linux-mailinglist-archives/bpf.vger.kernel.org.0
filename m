Return-Path: <bpf+bounces-43539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8079B5F49
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E4228370A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0746E1E283F;
	Wed, 30 Oct 2024 09:53:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6CF47F69
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281997; cv=none; b=P3NtpyNeS0OURQkGlIv3WGau8cs0Q5JiiZbn2VA7SJXbJPjajVXfhKB//C2nShqOlAknmqdZE25yJ/WWaAzRZG2JV302ZXedZVF8+f8fZq8d2GKb3ew+m3qJ40JdLQXZyiZ/mAsh9pBwJFMSkUiwcdkuXlqcm545ldmADT4adn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281997; c=relaxed/simple;
	bh=a6twuHZGbim4aBOb2eIiGGxYEif9RXkVRwAD8Bc4L5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FiO81qzS4E4Ey9Fw4sbPXvCVuXFDhSmWmijJMxEamOWWsIHsg8i1oIU+n2f6vpJrr7I1lCIqumNB2xKmGMMPVtcg4HAbvPUINP+sJELcoyaaAzkcHlctB6pHeLhPrK9vYr3GwkOIcl8ZBJgsQTYPGjBIz/9jLkEXViTyRUzHLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xdj9J5qsjz4f3jXy
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:52:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 82FBF1A0359
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:53:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4cAAiJn97dvAQ--.24244S8;
	Wed, 30 Oct 2024 17:53:10 +0800 (CST)
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
Subject: [PATCH bpf v4 4/5] bpf: Use __u64 to save the bits in bits iterator
Date: Wed, 30 Oct 2024 18:05:15 +0800
Message-Id: <20241030100516.3633640-5-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXc4cAAiJn97dvAQ--.24244S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCw17Gry5Xr1DJw4UGFyrXrb_yoW5tw17pr
	4rCw1qyr48tFW2yw1avrWUWa45Awn7AayxGFZ3GrWruF47Xr95uryUK345Xan5Cry8ZF42
	vr9093sxCFWUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

On 32-bit hosts (e.g., arm32), when a bpf program passes a u64 to
bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to store the
content of the u64. However, bits_copy is only 4 bytes, leading to stack
corruption.

The straightforward solution would be to replace u64 with unsigned long
in bpf_iter_bits_new(). However, this introduces confusion and problems
for 32-bit hosts because the size of ulong in bpf program is 8 bytes,
but it is treated as 4-bytes after passed to bpf_iter_bits_new().

Fix it by changing the type of both bits and bit_count from unsigned
long to u64. However, the change is not enough. The main reason is that
bpf_iter_bits_next() uses find_next_bit() to find the next bit and the
pointer passed to find_next_bit() is an unsigned long pointer instead
of a u64 pointer. For 32-bit little-endian host, it is fine but it is
not the case for 32-bit big-endian host. Because under 32-bit big-endian
host, the first iterated unsigned long will be the bits 32-63 of the u64
instead of the expected bits 0-31. Therefore, in addition to changing
the type, swap the two unsigned longs within the u64 for 32-bit
big-endian host.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 018985ebc5ce..3d45ebe8afb4 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2855,13 +2855,36 @@ struct bpf_iter_bits {
 
 struct bpf_iter_bits_kern {
 	union {
-		unsigned long *bits;
-		unsigned long bits_copy;
+		__u64 *bits;
+		__u64 bits_copy;
 	};
 	int nr_bits;
 	int bit;
 } __aligned(8);
 
+/* On 64-bit hosts, unsigned long and u64 have the same size, so passing
+ * a u64 pointer and an unsigned long pointer to find_next_bit() will
+ * return the same result, as both point to the same 8-byte area.
+ *
+ * For 32-bit little-endian hosts, using a u64 pointer or unsigned long
+ * pointer also makes no difference. This is because the first iterated
+ * unsigned long is composed of bits 0-31 of the u64 and the second unsigned
+ * long is composed of bits 32-63 of the u64.
+ *
+ * However, for 32-bit big-endian hosts, this is not the case. The first
+ * iterated unsigned long will be bits 32-63 of the u64, so swap these two
+ * ulong values within the u64.
+ */
+static void swap_ulong_in_u64(u64 *bits, unsigned int nr)
+{
+#if (BITS_PER_LONG == 32) && defined(__BIG_ENDIAN)
+	unsigned int i;
+
+	for (i = 0; i < nr; i++)
+		bits[i] = (bits[i] >> 32) | ((u64)(u32)bits[i] << 32);
+#endif
+}
+
 /**
  * bpf_iter_bits_new() - Initialize a new bits iterator for a given memory area
  * @it: The new bpf_iter_bits to be created
@@ -2904,6 +2927,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 		if (err)
 			return -EFAULT;
 
+		swap_ulong_in_u64(&kit->bits_copy, nr_words);
+
 		kit->nr_bits = nr_bits;
 		return 0;
 	}
@@ -2922,6 +2947,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 		return err;
 	}
 
+	swap_ulong_in_u64(kit->bits, nr_words);
+
 	kit->nr_bits = nr_bits;
 	return 0;
 }
@@ -2939,7 +2966,7 @@ __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
 {
 	struct bpf_iter_bits_kern *kit = (void *)it;
 	int bit = kit->bit, nr_bits = kit->nr_bits;
-	const unsigned long *bits;
+	const void *bits;
 
 	if (!nr_bits || bit >= nr_bits)
 		return NULL;
-- 
2.29.2



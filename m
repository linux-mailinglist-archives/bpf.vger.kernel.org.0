Return-Path: <bpf+bounces-43127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2017B9AF697
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 03:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D042822B5
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84843D3B3;
	Fri, 25 Oct 2024 01:20:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B0101F7
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819232; cv=none; b=j3bMPnzk2vghBB6pHeHhJAjoCCvPgsSV2eJieeLPIFGVvcbU+UtWbK3kNl4qzUYtM3+BB7gz0wj4qOuLD0hawJDO1sv8GrnOizWisx2I6VHVnYGUMtlmA6Tb4A70TsTiOXF4CawfEes8qoBS5Lk7RRI6GURSh/lSMAsZOuH6M30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819232; c=relaxed/simple;
	bh=Sf3qTnf694uCUlQL9zmZybeEg0GNGrxj8RBiXVAqR7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKRu1NEFwq0HDDo2+k4paw3jiC84dHlBacO5ornMU4KvyW6XjusYUs2zFvZ7V3l+mpQOweJuJSW2zakiqrT2M3OIL11bt081gNykY01Bu4nZqO8MMHVNrquN4WVu1QAAPs8GHeKxPddCgmofiwFS1MfshRqsVv6c4RTJAwGUmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZQ2065hXz4f3lfh
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 28B921A018C
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:20:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCn28dU8hpnhzUqFA--.57458S9;
	Fri, 25 Oct 2024 09:20:26 +0800 (CST)
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
Subject: [PATCH bpf v3 5/5] selftests/bpf: Add three test cases for bits_iter
Date: Fri, 25 Oct 2024 09:32:33 +0800
Message-Id: <20241025013233.804027-6-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCn28dU8hpnhzUqFA--.57458S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4rZw4fXF4fAr15AF4xJFb_yoW5WFyDpa
	1kW3sxAr1rJr4akr4fCayjkFyrWr4vyayrCrZaqrW5CFn7Xr92gr1Skw45Xas5GrWjvwsY
	vFWqy3yxJrW8WaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add more test cases for bits iterator:

(1) huge word test
Verify the multiplication overflow of nr_bits in bits_iter. Without
the overflow check, when nr_words is 67108865, nr_bits becomes 64,
causing bpf_probe_read_kernel_common() to corrupt the stack.
(2) max word test
Verify correct handling of maximum nr_words value (511).
(3) bad word test
Verify early termination of bits iteration when bits iterator
initialization fails.

Also rename bits_nomem to bits_too_big to better reflect its purpose.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/progs/verifier_bits_iter.c  | 61 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
index f4da4d508ddb..156cc278e2fc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -15,6 +15,8 @@ int bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign,
 int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
 void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
 
+u64 bits_array[511] = {};
+
 SEC("iter.s/cgroup")
 __description("bits iter without destroy")
 __failure __msg("Unreleased reference")
@@ -110,16 +112,16 @@ int bit_index(void)
 }
 
 SEC("syscall")
-__description("bits nomem")
+__description("bits too big")
 __success __retval(0)
-int bits_nomem(void)
+int bits_too_big(void)
 {
 	u64 data[4];
 	int nr = 0;
 	int *bit;
 
 	__builtin_memset(&data, 0xff, sizeof(data));
-	bpf_for_each(bits, bit, &data[0], 513) /* Be greater than 512 */
+	bpf_for_each(bits, bit, &data[0], 512) /* Be greater than 511 */
 		nr++;
 	return nr;
 }
@@ -151,3 +153,56 @@ int zero_words(void)
 		nr++;
 	return nr;
 }
+
+SEC("syscall")
+__description("huge words")
+__success __retval(0)
+int huge_words(void)
+{
+	u64 data[8] = {0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1};
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data[0], 67108865)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("max words")
+__success __retval(4)
+int max_words(void)
+{
+	volatile int nr = 0;
+	int *bit;
+
+	bits_array[0] = (1ULL << 63) | 1U;
+	bits_array[510] = (1ULL << 33) | (1ULL << 32);
+
+	bpf_for_each(bits, bit, bits_array, 511) {
+		if (nr == 0 && *bit != 0)
+			break;
+		if (nr == 2 && *bit != 32672)
+			break;
+		nr++;
+	}
+	return nr;
+}
+
+SEC("syscall")
+__description("bad words")
+__success __retval(0)
+int bad_words(void)
+{
+	void *bad_addr = (void *)(3UL << 30);
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, bad_addr, 1)
+		nr++;
+
+	bpf_for_each(bits, bit, bad_addr, 4)
+		nr++;
+
+	return nr;
+}
-- 
2.29.2



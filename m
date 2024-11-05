Return-Path: <bpf+bounces-44004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611609BC44B
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 05:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173DD1F2201D
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 04:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684D31AC43A;
	Tue,  5 Nov 2024 04:18:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312581AF0B5
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780338; cv=none; b=A9hD5LhNLROWYBumd1Tqt4Em86DZnWNn3RTd8rBcu0FPE0CyaR8gq2l6xbvZ5f26bcdIWoDLwPCEVrJpfWam6bzpYCztkYCygkDbowxjwqVtDQp/E9Vl2K4oXEAsZu3TBz5h+C3iax9nAmtELZ16BWaHN0uZGdP+GI17AtXeCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780338; c=relaxed/simple;
	bh=0TsBMbtrgTCiLfWWDw9MPRT326Xl284xsOweH6V7JJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M2zsNqZZH1nrIG6VIKaUANLkOfRnRYpwmvwyTKkHm2AlQNBuD1ANvWtuqParqSxGBUVvxz6JD1hnSAtrXd5ugCTwBVVLnBNE44m1eR/8/rvbWtspFj3xIk8mafsDJMROGyVofIaZt4Diemb+6m2RkRCQ74wh/npvqE3YCzxVt8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XjFSk51wKz4f3jXb
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 12:18:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9D1501A0568
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 12:18:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXcYWknClnhcKQAw--.50856S4;
	Tue, 05 Nov 2024 12:18:46 +0800 (CST)
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
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Byeonguk Jeong <jungbu2855@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf] selftests/bpf: Use -4095 as the bad address for bits iterator
Date: Tue,  5 Nov 2024 12:30:57 +0800
Message-Id: <20241105043057.3371482-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXcYWknClnhcKQAw--.50856S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw15tFyfCr1xtFWUKr4fGrg_yoW5JF13pa
	yfZrZIyr48Ar42kwsrGF1jkFyfA3Z2yay5GrWrJr45CFn8Xryq9w1xKw1Yq3Z5JrWFqwsa
	vrWqkayfC3y8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

As reported by Byeonguk, the bad_words test in verifier_bits_iter.c
occasionally fails on s390 host. Quoting Ilya's explanation:

  s390 kernel runs in a completely separate address space, there is no
  user/kernel split at TASK_SIZE. The same address may be valid in both
  the kernel and the user address spaces, there is no way to tell by
  looking at it. The config option related to this property is
  ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.

  Also, unfortunately, 0 is a valid address in the s390 kernel address
  space.

Fix the issue by using -4096 as the bad address for bits iterator, as
suggested by Ilya. Verify that bpf_iter_bits_new() returns -EINVAL for
NULL address and -EFAULT for bad address.

Fixes: ebafc1e535db ("selftests/bpf: Add three test cases for bits_iter")
Reported-by: Byeonguk Jeong <jungbu2855@gmail.com>
Closes: https://lore.kernel.org/bpf/ZycSXwjH4UTvx-Cn@ub22/
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/progs/verifier_bits_iter.c  | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
index 156cc278e2fc..7c881bca9af5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -57,9 +57,15 @@ __description("null pointer")
 __success __retval(0)
 int null_pointer(void)
 {
-	int nr = 0;
+	struct bpf_iter_bits iter;
+	int err, nr = 0;
 	int *bit;
 
+	err = bpf_iter_bits_new(&iter, NULL, 1);
+	bpf_iter_bits_destroy(&iter);
+	if (err != -EINVAL)
+		return 1;
+
 	bpf_for_each(bits, bit, NULL, 1)
 		nr++;
 	return nr;
@@ -194,15 +200,33 @@ __description("bad words")
 __success __retval(0)
 int bad_words(void)
 {
-	void *bad_addr = (void *)(3UL << 30);
-	int nr = 0;
+	void *bad_addr = (void *)-4095;
+	struct bpf_iter_bits iter;
+	volatile int nr;
 	int *bit;
+	int err;
+
+	err = bpf_iter_bits_new(&iter, bad_addr, 1);
+	bpf_iter_bits_destroy(&iter);
+	if (err != -EFAULT)
+		return 1;
 
+	nr = 0;
 	bpf_for_each(bits, bit, bad_addr, 1)
 		nr++;
+	if (nr != 0)
+		return 2;
 
+	err = bpf_iter_bits_new(&iter, bad_addr, 4);
+	bpf_iter_bits_destroy(&iter);
+	if (err != -EFAULT)
+		return 3;
+
+	nr = 0;
 	bpf_for_each(bits, bit, bad_addr, 4)
 		nr++;
+	if (nr != 0)
+		return 4;
 
-	return nr;
+	return 0;
 }
-- 
2.29.2



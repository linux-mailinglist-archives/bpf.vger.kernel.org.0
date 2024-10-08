Return-Path: <bpf+bounces-41221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD49943AD
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F8EB2936C
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51871C9B99;
	Tue,  8 Oct 2024 09:05:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78C1C2DD3
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378316; cv=none; b=uWVRssmuZlS1NouVVfB8Zo2k3DkG69kkfMsikrISb9ZcyzIZ5KWe/0Cux+w0fGX8WpRRuV6FKwpTk5LczU1y343ZkT1xLX2Tfgu0KvwRfvjXxPCpo2wbXY2bCe9ayAU9GArcvPuZGs7priuzW1j0fBX3c0Dmi38//ZLm7fw8Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378316; c=relaxed/simple;
	bh=E2brk+fhgdmaDgyQyfWBHA6NlDzqwx79ck318myUSAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DppSmWz4BhpFXckOVkFFbm37raEqm6Bw1S4ZpTkmxloS72PyXPV8PMduLzy62+gO9BHXV76kd8KLZ0cS9VfD+ki63HEMm0kuA1phCMOqNfN+tLy+pw0+cJm89wLsubrQohZJbWzGuhpWV/R1s4xdEjTUi+/6JLmFAvuTnpqANmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XN9865K9qz4f3jY6
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:04:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 893C31A018D
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:05:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3yobB9QRnm_6TDQ--.2069S11;
	Tue, 08 Oct 2024 17:05:11 +0800 (CST)
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
Subject: [PATCH bpf 7/7] selftests/bpf: Pass a pointer of unsigned long to bpf_iter_bits_new()
Date: Tue,  8 Oct 2024 17:17:18 +0800
Message-Id: <20241008091718.3797027-8-houtao@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgB3yobB9QRnm_6TDQ--.2069S11
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy8urW8JFW5tFWxtr17GFg_yoW5tw13pa
	y8uwnFyrs5tw4a9ws7WayjkFyrXr4vqayUCw47XryruFn8XFnrWr1Sy34rX3Z0yrZ0vw1v
	vFWjy347JrZrJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The type of unsafe_ptr has been changed from u64 * to unsigned long *,
so update the type of data from u64 to unsigned long accordingly.

The results of bits_memalloc and bits_nomem should depend on the size of
unsigned long, so update these two test cases accordingly. A note is
needed for bits_memalloc() in which "int nr" needs the volatile
qualifier to prevent the optimization of the compiler.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/progs/verifier_bits_iter.c  | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
index 344b7eac15c8..4622897b8a24 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -10,7 +10,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-int bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign,
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const unsigned long *unsafe_ptr__ign,
 		      u32 nr_bits) __ksym __weak;
 int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
 void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
@@ -21,7 +21,7 @@ __failure __msg("Unreleased reference")
 int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 {
 	struct bpf_iter_bits it;
-	u64 data = 1;
+	unsigned long data = 1;
 
 	bpf_iter_bits_new(&it, &data, 1);
 	bpf_iter_bits_next(&it);
@@ -68,7 +68,7 @@ __description("bits copy")
 __success __retval(10)
 int bits_copy(void)
 {
-	u64 data = 0xf7310UL; /* 4 + 3 + 2 + 1 + 0*/
+	unsigned long data = 0xf7310UL; /* 4 + 3 + 2 + 1 + 0*/
 	int nr = 0;
 	int *bit;
 
@@ -79,17 +79,17 @@ int bits_copy(void)
 
 SEC("syscall")
 __description("bits memalloc")
-__success __retval(64)
+__success __retval(1)
 int bits_memalloc(void)
 {
-	u64 data[2];
-	int nr = 0;
+	unsigned long data[2];
+	volatile int nr = 0;
 	int *bit;
 
-	__builtin_memset(&data, 0xf0, sizeof(data)); /* 4 * 16 */
+	__builtin_memset(&data, 0xf0, sizeof(data));
 	bpf_for_each(bits, bit, &data[0], ARRAY_SIZE(data))
 		nr++;
-	return nr;
+	return nr == 4 * sizeof(data);
 }
 
 SEC("syscall")
@@ -97,7 +97,7 @@ __description("bit index")
 __success __retval(8)
 int bit_index(void)
 {
-	u64 data = 0x100;
+	unsigned long data = 0x100;
 	int bit_idx = 0;
 	int *bit;
 
@@ -114,12 +114,12 @@ __description("bits nomem")
 __success __retval(0)
 int bits_nomem(void)
 {
-	u64 data[4];
+	unsigned long data[4];
 	int nr = 0;
 	int *bit;
 
 	__builtin_memset(&data, 0xff, sizeof(data));
-	bpf_for_each(bits, bit, &data[0], 513) /* Be greater than 512 */
+	bpf_for_each(bits, bit, &data[0], 4096 / sizeof(data[0]) + 1)
 		nr++;
 	return nr;
 }
@@ -129,7 +129,7 @@ __description("fewer words")
 __success __retval(1)
 int fewer_words(void)
 {
-	u64 data[2] = {0x1, 0xff};
+	unsigned long data[2] = {0x1, 0xff};
 	int nr = 0;
 	int *bit;
 
@@ -143,7 +143,7 @@ __description("zero words")
 __success __retval(0)
 int zero_words(void)
 {
-	u64 data[2] = {0x1, 0xff};
+	unsigned long data[2] = {0x1, 0xff};
 	int nr = 0;
 	int *bit;
 
@@ -157,7 +157,7 @@ __description("big words")
 __success __retval(0)
 int big_words(void)
 {
-	u64 data[8] = {0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1};
+	unsigned long data[8] = {0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1};
 	int nr = 0;
 	int *bit;
 
-- 
2.29.2



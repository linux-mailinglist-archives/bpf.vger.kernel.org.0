Return-Path: <bpf+bounces-42558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA59A588D
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E420B217C5
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788F1CFBC;
	Mon, 21 Oct 2024 01:28:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3E17BBF
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474089; cv=none; b=cET6E9p4vlJNKKdU/vtuR5YDrlsNKX0XQsfWydQqVfWxvIlGVAqsJA9VKLlwNOzGNCggFRHiY3U/LhGrkEymeb8IFb4IVAWqXVP8mM+oEbXtb7yiaGZQUvUbQELbqoZQcIgciz7Qp0r6+8OBWR9A5DZ+q5YneesBiN0JaLts+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474089; c=relaxed/simple;
	bh=YZClfy9Bri4+3Vtc6QLb3qS16lWXR2kMUnMh7HJ5ZKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pihFUgja/ckvD2+4Iyu2bYtX3xb2XFgvS5rs9Jovw8m6iBDp9IPayW7EZxa1piJf3wzh5eJm8O+N7VRsc6YZcn/zYlzPnQQoyS/v9ESnWaXKGTQqxAbESUhj5tFmhKYw8mrYHkQeL/e6FpN5k/51JsKgHwm3+LGjaZJLBfS0tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XWyNg0XSSz4f3jkq
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4C97B1A018D
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYXrhVnot2wEg--.32425S11;
	Mon, 21 Oct 2024 09:27:59 +0800 (CST)
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
Subject: [PATCH bpf v2 7/7] selftests/bpf: Test multiplication overflow of nr_bits in bits_iter
Date: Mon, 21 Oct 2024 09:40:04 +0800
Message-Id: <20241021014004.1647816-8-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYXrhVnot2wEg--.32425S11
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW5Wr48Zr47KryUCF1xXwb_yoWDurXEyw
	4Sva48Kr4UtF97tFykZrn3urW5Cws29rWxGF43trWfA3WUXw1rJF4ktr18Zry8WrW5t39x
	Z3WqqF10gw43KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add a test to verify the multiplication overflow of nr_bits in bits_iter.
When nr_words is assigned as 67108865, nr_bits becomes 64, causing
bpf_probe_read_kernel_common() to corrupt the stack.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/progs/verifier_bits_iter.c       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
index f4da4d508ddb..344b7eac15c8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -151,3 +151,17 @@ int zero_words(void)
 		nr++;
 	return nr;
 }
+
+SEC("syscall")
+__description("big words")
+__success __retval(0)
+int big_words(void)
+{
+	u64 data[8] = {0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1};
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data[0], 67108865)
+		nr++;
+	return nr;
+}
-- 
2.29.2



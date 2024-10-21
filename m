Return-Path: <bpf+bounces-42556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A909A588B
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D5C282392
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7A1946B;
	Mon, 21 Oct 2024 01:28:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EADDA8
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474088; cv=none; b=Hi5dIGkjGFQAlHA4a2F/tn9zSzKMFZkuOhbOTnryDK+Xgi8ohj29XgD4353aSkmkumOqJXMCLetY3sHnTnQ/NU78D5GdIKApJqlpx6twXhoQqJ776F8coGz1D2pm4AQ/SPtAkQDefLqVjNIdk5XQU7x5olN9xirt5q8af6Mz1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474088; c=relaxed/simple;
	bh=/Rdx6qk/dV4KoO4bhE36gfZxFheqmBxWtvriac3vtrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ksr5dc7OCv065R06wOEsWQLGvtCEeG5lrOHRMUCrRQQR15cAwKnqdfxdzgFcnuQZaUByAfIWgmhIw6k+HZ7MLt2ejAI3I70nP51pmh4vkx+ppj77hOOApc5GPhxBowv818eQVae/G6ZXDrj8CRxlB7naxJ97NqfVKFkgSgTyPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XWyNd5jVxz4f3jkk
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0A8CF1A0568
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:27:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYXrhVnot2wEg--.32425S9;
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
Subject: [PATCH bpf v2 5/7] bpf: Check the validity of nr_words in bpf_iter_bits_new()
Date: Mon, 21 Oct 2024 09:40:02 +0800
Message-Id: <20241021014004.1647816-6-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXysYXrhVnot2wEg--.32425S9
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW3urW5tw4fJw4Dtr4Utwb_yoWkuFX_GF
	Wjqa4kKrs8uFs3tr1qyr1SvrW5tw18KF4rCw4UJrZ7ur1rA3Z5JF4rtryDZa97Wr1DAFsx
	Jws3XFWq9r1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
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
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	F9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Check the validity of nr_words in bpf_iter_bits_new(). Without this
check, when multiplication overflow occurs for nr_bits (e.g., when
nr_words = 0x0400-0001, nr_bits becomes 64), stack corruption may occur
due to bpf_probe_read_kernel_common(..., nr_bytes = 0x2000-0008).

Fix it by limiting the max value of nr_words to 512.

Fixes: 4665415975b0 ("bpf: Add bits iterator")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 62349e206a29..c147f75e1b48 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
 	__u64 __opaque[2];
 } __aligned(8);
 
+#define BITS_ITER_NR_WORDS_MAX 512
+
 struct bpf_iter_bits_kern {
 	union {
 		unsigned long *bits;
@@ -2892,6 +2894,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
 
 	if (!unsafe_ptr__ign || !nr_words)
 		return -EINVAL;
+	if (nr_words > BITS_ITER_NR_WORDS_MAX)
+		return -E2BIG;
 
 	/* Optimization for u64 mask */
 	if (nr_bits == 64) {
-- 
2.29.2



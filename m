Return-Path: <bpf+bounces-45066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E69D076D
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 02:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98917281FEB
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21E73B192;
	Mon, 18 Nov 2024 01:13:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCD1946B
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 01:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892438; cv=none; b=VoxCEAdqCmlksSO2TyZItJWJ9dr0TIrwSlU14nVHDl7I9CSxUqS69FBWViXiAELPBa5W76tcbydKRpGIVeJPWBOxFcUJnbXCwLa1eTrp7WohqESlTYs5nV+Kz1BdJ6G5+8hTX22gVj/8GkTl4nel48P2E5YWGrtg1Kz3Vrj+WPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892438; c=relaxed/simple;
	bh=YkIbSCeD1PXhVNI3KRAxnUyBFPS+VmerbPTNXeFCgJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSJvFkZ3K8Ak5zxeia3DMet1f2jEv4eSqJO0bdvaMUX4T5MD84U0QgNeoa9z4kcAHc7LToL/KtAcU+YmX/fwmQzjDH1D2Y1hxhSbHEv3FmA2YBYNNdh2AWX1Kex1k0+qv6E/98nd2AeJltkT7IH8qY4CHqhpcJtewLZ+Wev5mtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xs8Ls40S7z4f3jt9
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:55:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DFF951A0568
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:56:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4eckDpn2G5fCA--.44635S10;
	Mon, 18 Nov 2024 08:56:02 +0800 (CST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 06/10] bpf: Add bpf_mem_cache_is_mergeable() helper
Date: Mon, 18 Nov 2024 09:08:04 +0800
Message-Id: <20241118010808.2243555-7-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241118010808.2243555-1-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4eckDpn2G5fCA--.44635S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4DCryUJFWkXF1UXFW8WFg_yoW8Ww4fpF
	W2kr18AF4FvF48Xw47Wrn2ya98Xw4Ig3W7Ka43XryUur13urnrGws8Gry7XF9Yvrs8KF40
	kr1DKr4fC348ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add bpf_mem_cache_is_mergeable() to check whether two bpf mem allocator
for fixed-size objects are mergeable or not. The merging could reduce
the memory overhead of bpf mem allocator.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |  1 +
 kernel/bpf/memalloc.c         | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index e45162ef59bb..faa54b9c7a04 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -47,5 +47,6 @@ void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
 void bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr);
 void bpf_mem_cache_raw_free(void *ptr);
 void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
+bool bpf_mem_cache_is_mergeable(size_t size, size_t new_size, bool percpu);
 
 #endif /* _BPF_MEM_ALLOC_H */
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 889374722d0a..49dd08ad1d4f 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -1014,3 +1014,15 @@ int bpf_mem_alloc_check_size(bool percpu, size_t size)
 
 	return 0;
 }
+
+bool bpf_mem_cache_is_mergeable(size_t size, size_t new_size, bool percpu)
+{
+	/* Only for fixed-size object allocator */
+	if (!size || !new_size)
+		return false;
+
+	return (percpu && ALIGN(size, PCPU_MIN_ALLOC_SIZE) ==
+			  ALIGN(new_size, PCPU_MIN_ALLOC_SIZE)) ||
+	       (!percpu && kmalloc_size_roundup(size + LLIST_NODE_SZ) ==
+			   kmalloc_size_roundup(new_size + LLIST_NODE_SZ));
+}
-- 
2.29.2



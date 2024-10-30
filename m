Return-Path: <bpf+bounces-43535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99139B5F45
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 10:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A141C21231
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D831E25EC;
	Wed, 30 Oct 2024 09:53:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B901E22F5
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281995; cv=none; b=M0cgDXETmuNnOgYxzJorKYsBFzW4GABiVQNfgp4yAbqJpilp7Co7WkQanJ79F6NqinlmwjUSHp1WJ2fhDhELSCH48EQ+yZe6jlV0WRu/bcFzO+BrlqHGpctawv6gYiY+nitaRQt8vqCarNvp+tguZSP/XjT1HobjDywcZ+ekMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281995; c=relaxed/simple;
	bh=bsl7zSI0Z2/07tz7PtPMyP0Vmk/WmN3dcQwUArY4KK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQhCUGJm2RMuGLdjbhgeqFQU3hDSQ0IxPEMFXWWwZoDseNjaxU7quzwtkrMD0KhqKxMvBpQN74pERlcO2HknDkTPLbZ1rX+doYsdieNc6uxqvZdzk10mXcQMrdlemZjZ/2BWkTROunbabBF6bq2MCdXyc/8oZ3ntbm4Gypv2a3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xdj9G5vQfz4f3nb8
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:52:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5CB091A0196
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 17:53:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4cAAiJn97dvAQ--.24244S6;
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
Subject: [PATCH bpf v4 2/5] bpf: Add bpf_mem_alloc_check_size() helper
Date: Wed, 30 Oct 2024 18:05:13 +0800
Message-Id: <20241030100516.3633640-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCXc4cAAiJn97dvAQ--.24244S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17Aw1rCFW3uF18ZrW7CFg_yoW5JryxpF
	W7tr18AFs8JF48W3W2gw1xAas8Xw40g3W7tay7XryUZF93GrnrWFs8Jry7WF9ayrW5Aayx
	JrnYgrWfAryUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Introduce bpf_mem_alloc_check_size() to check whether the allocation
size exceeds the limitation for the kmalloc-equivalent allocator. The
upper limit for percpu allocation is LLIST_NODE_SZ bytes larger than
non-percpu allocation, so a percpu argument is added to the helper.

The helper will be used in the following patch to check whether the size
parameter passed to bpf_mem_alloc() is too big.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf_mem_alloc.h |  3 +++
 kernel/bpf/memalloc.c         | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index aaf004d94322..e45162ef59bb 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -33,6 +33,9 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
+/* Check the allocation size for kmalloc equivalent allocator */
+int bpf_mem_alloc_check_size(bool percpu, size_t size);
+
 /* kmalloc/kfree equivalent: */
 void *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size);
 void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index b3858a76e0b3..146f5b57cfb1 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -35,6 +35,8 @@
  */
 #define LLIST_NODE_SZ sizeof(struct llist_node)
 
+#define BPF_MEM_ALLOC_SIZE_MAX 4096
+
 /* similar to kmalloc, but sizeof == 8 bucket is gone */
 static u8 size_index[24] __ro_after_init = {
 	3,	/* 8 */
@@ -65,7 +67,7 @@ static u8 size_index[24] __ro_after_init = {
 
 static int bpf_mem_cache_idx(size_t size)
 {
-	if (!size || size > 4096)
+	if (!size || size > BPF_MEM_ALLOC_SIZE_MAX)
 		return -1;
 
 	if (size <= 192)
@@ -1005,3 +1007,13 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
+
+int bpf_mem_alloc_check_size(bool percpu, size_t size)
+{
+	/* The size of percpu allocation doesn't have LLIST_NODE_SZ overhead */
+	if ((percpu && size > BPF_MEM_ALLOC_SIZE_MAX) ||
+	    (!percpu && size > BPF_MEM_ALLOC_SIZE_MAX - LLIST_NODE_SZ))
+		return -E2BIG;
+
+	return 0;
+}
-- 
2.29.2



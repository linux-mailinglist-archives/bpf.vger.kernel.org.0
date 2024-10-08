Return-Path: <bpf+bounces-41208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55486994391
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F4D1C252BE
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312A1DEFE4;
	Tue,  8 Oct 2024 09:02:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341419994E
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378155; cv=none; b=domqBPv7AuMde/TzJnkoBfbwVI11tb2RWIo633c/7QZeRwF9U3sypboazSk1UcfW67WHs8ZV6vF80pVcPp0nDhD0upsuuyRULYUEcy0kmpvGzA1Qu4XtcqOThD/Z33XiD8d6MheJtQlKrDt3YWwazWQl1D/1msr6sw/Gm03lxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378155; c=relaxed/simple;
	bh=QLd+X2SvqaZ7PkkpneE9fez8BCTG0V4lLSMf7nduySU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmZsA2Ck5hOSNoHjQZ5bYRCHlr8Nptun3VTvXsWRCxzx6MXzHTSQN0n43pKZhxM3uh/AO7EN0JANjnT2eFtr8Tkt7k8tc9Ww+P2AXVX71/Zzecpl2TOXLA4xFvkH/XXKm3Gj39iTR5GwVxHfvgtjTPWmWFSYWALdPciGj7/kF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN9570CXCz4f3jt1
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BA7B41A08FC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S15;
	Tue, 08 Oct 2024 17:02:30 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 11/16] bpf: Add bpf_mem_alloc_check_size() helper
Date: Tue,  8 Oct 2024 17:14:56 +0800
Message-ID: <20241008091501.8302-12-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008091501.8302-1-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S15
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17AF1Uuw18XFWUXw4xJFb_yoW5Jry5pF
	47tr18AFs5JF48Wa42gw1xAas8Xw4vg3W7tay3XryUZF93GrnrWFs8try7XFnayrW5Aayx
	Jr1vgrWfCryUZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUoo7KUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Introduce bpf_mem_alloc_check_size() to check whether the allocation
size exceeds the limitation for kmalloc-equivalent allocator. Because
the upper limit for percpu allocation is LLIST_NODE_SZ bytes larger than
non-percpu allocation, so an extra percpu argument is added to the
helper.

It will be used by the following patch to check whether the maximum size
of variable-length key is valid.

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
2.44.0



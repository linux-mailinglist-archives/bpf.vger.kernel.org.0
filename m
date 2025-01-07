Return-Path: <bpf+bounces-48059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1512A03A00
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DCA1885C48
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2E1E3774;
	Tue,  7 Jan 2025 08:44:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FE1DE4F6;
	Tue,  7 Jan 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239442; cv=none; b=gm40np+9wX4iaBlKEET3rzq7V7Bu2sRl355NAy2xnM3UCE3pdKbJfXwqeh0V1l1H8iC1KSBgMsHCDR/OTnMdmteFyO+EQF96OEWX2Ry7pvCAGxXHreA2vszHunCeMDwaaCVIeXHdFFejAf/mGxDNP3bzbvs/tX9BTI9J4W5M2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239442; c=relaxed/simple;
	bh=tCq9JeQOYviZ+IktZeEb6m1RHkXkUOA/QzN3mDP9HTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXQF30frZ07gdvqCxto7RE6jb0STYVRGa+Gtq2ifRoI1a/a8nDD2YHoouZl4hhmpp+ogTLBNC1WbhGL55CsvJ78mGCGupxB6VIgJjtxBkcKvXE9823YwMYqb54wIFYgr4kQhQpnqJ6yqqXlcx0l9d327iXhGheeUjiqBtT2KZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YS4MV6km4z4f3lCf;
	Tue,  7 Jan 2025 16:43:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 458CD1A1674;
	Tue,  7 Jan 2025 16:43:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9E6XxnpFgeAQ--.43336S9;
	Tue, 07 Jan 2025 16:43:56 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 5/7] bpf: Factor out the element allocation for pre-allocated htab
Date: Tue,  7 Jan 2025 16:55:57 +0800
Message-Id: <20250107085559.3081563-6-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250107085559.3081563-1-houtao@huaweicloud.com>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9E6XxnpFgeAQ--.43336S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJF47Jr1kuw4DXw4fKFWDtwb_yoW5Wr4xpF
	WrGw1xAws5Xws2g395Xr409rW3Jrn5Gw4jk3y5Kw1Fyr98Crn7Gw47ZFyagry5Ary8CFyf
	X39Fva1rGa1Uu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

The element allocation for pre-allocated htab is composed of two logics:
1) when there is old_element, directly reuse per-cpu extra_elems
Also stash the old_element as the next per-cpu extra_elems
2) when no old_element, allocate from per-cpu free list

The reuse and stash of per-cpu extra_elems will be broken into two
independent steps. After the breaking, per-cpu extra_elems may be NULL
when trying to reuse it and the allocation needs to fall-back to per-cpu
free list when it happens.

Therefore, factor out the element allocation to a helper to make the
following change be straightforward.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 49 +++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3c6eebabb492..9211df2adda4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1021,6 +1021,34 @@ static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
 	       BITS_PER_LONG == 64;
 }
 
+static struct htab_elem *alloc_preallocated_htab_elem(struct bpf_htab *htab,
+						      struct htab_elem *old_elem)
+{
+	struct pcpu_freelist_node *l;
+	struct htab_elem *l_new;
+
+	if (old_elem) {
+		struct htab_elem **pl_new;
+
+		/* if we're updating the existing element,
+		 * use per-cpu extra elems to avoid freelist_pop/push
+		 */
+		pl_new = this_cpu_ptr(htab->extra_elems);
+		l_new = *pl_new;
+		*pl_new = old_elem;
+		return l_new;
+	}
+
+	l = __pcpu_freelist_pop(&htab->freelist);
+	if (!l)
+		return ERR_PTR(-E2BIG);
+
+	l_new = container_of(l, struct htab_elem, fnode);
+	bpf_map_inc_elem_count(&htab->map);
+
+	return l_new;
+}
+
 static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 					 void *value, u32 key_size, u32 hash,
 					 bool percpu, bool onallcpus,
@@ -1028,26 +1056,13 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 {
 	u32 size = htab->map.value_size;
 	bool prealloc = htab_is_prealloc(htab);
-	struct htab_elem *l_new, **pl_new;
+	struct htab_elem *l_new;
 	void __percpu *pptr;
 
 	if (prealloc) {
-		if (old_elem) {
-			/* if we're updating the existing element,
-			 * use per-cpu extra elems to avoid freelist_pop/push
-			 */
-			pl_new = this_cpu_ptr(htab->extra_elems);
-			l_new = *pl_new;
-			*pl_new = old_elem;
-		} else {
-			struct pcpu_freelist_node *l;
-
-			l = __pcpu_freelist_pop(&htab->freelist);
-			if (!l)
-				return ERR_PTR(-E2BIG);
-			l_new = container_of(l, struct htab_elem, fnode);
-			bpf_map_inc_elem_count(&htab->map);
-		}
+		l_new = alloc_preallocated_htab_elem(htab, old_elem);
+		if (IS_ERR(l_new))
+			return l_new;
 	} else {
 		if (is_map_full(htab))
 			if (!old_elem)
-- 
2.29.2



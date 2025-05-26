Return-Path: <bpf+bounces-58923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FFFAC39A7
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 08:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A416B3ACE1C
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6EB1D54FE;
	Mon, 26 May 2025 06:08:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306F1D5ABA
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239714; cv=none; b=hvoNupgaAW4/E0DrOHj7dq+oey7vES3vFZIUu7sCSvgo8uveC/a2ShfIJ3TuQqzGqRtCs8Ilp24vSeKhbSfTZBoP0Rq0ofTbqsb/hmjZdGK4m3v9cFlelbp1xzZ140PUUEFILUqbj6PXUl+zLvVS26iQFlIf1/DfYiUbHHQCTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239714; c=relaxed/simple;
	bh=dYnHZdsxk1qXHzS+htTqNGoaMHcfHFTRbAdPqwxtq68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jOS9Yw9ngIYnp+2tO1Qndp6gbJTMfH2NWUy/gdYIAFaVKaumrBWG49YMzz4iI4qc80jhD2/a6VFJFFyryhPsu/B+oY1tnt00qMKHE2ugzcX4g4Tt4uFrQIEgRZF/z5kPygzdgE8zAS3BDBansZ9d7E3C2evWRt2QsKEFQbBQgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b5QL10qR1z4f3k5c
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:08:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2F59E1A018D
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:08:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9aBTRoMQovNg--.11895S6;
	Mon, 26 May 2025 14:08:28 +0800 (CST)
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
	houtao1@huawei.com
Subject: [RFC PATCH bpf-next 2/3] bpf: Implement bpf mem allocator dtor for hash map
Date: Mon, 26 May 2025 14:25:54 +0800
Message-Id: <20250526062555.1106061-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250526062555.1106061-1-houtao@huaweicloud.com>
References: <20250526062555.1106061-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9aBTRoMQovNg--.11895S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyktrWkJr1xZFykWw43Awb_yoW5Jry5pF
	W8Wa4a9r48ZanrGa13tw4vkrW5uryFga4UCayYqa4Fkr15Xr9rWr4kJFW2qFyrAr4vywn3
	tr9FqFyfK3yUArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbJD
	G5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

BPF hash map supports special fields in its value, and BPF program is
free to manipulate these special fields even after the element is
deleted from the hash map. For non-preallocated hash map, these special
fields will be leaked when the map is destroyed. Therefore, implement
necessary BPF memory allocator dtor to free these special fields.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index dd6c157cb828..2531177d1464 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -128,6 +128,8 @@ struct htab_elem {
 	char key[] __aligned(8);
 };
 
+static void check_and_free_fields(struct bpf_htab *htab, struct htab_elem *elem);
+
 static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 {
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
@@ -464,6 +466,33 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
+static void htab_ma_dtor(void *obj, void *ctx)
+{
+	struct bpf_htab *htab = ctx;
+
+	/* The per-cpu pointer saved in the htab_elem may have been freed
+	 * by htab->pcpu_ma. Therefore, freeing the special fields in the
+	 * per-cpu pointer through the dtor of htab->pcpu_ma instead.
+	 */
+	if (htab_is_percpu(htab))
+		return;
+	check_and_free_fields(htab, obj);
+}
+
+static void htab_pcpu_ma_dtor(void *obj, void *ctx)
+{
+	struct bpf_htab *htab = ctx;
+	void __percpu *pptr;
+	int cpu;
+
+	if (IS_ERR_OR_NULL(htab->map.record))
+		return;
+
+	pptr = *(void __percpu **)obj;
+	for_each_possible_cpu(cpu)
+		bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
+}
+
 static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 {
 	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
@@ -568,13 +597,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false, NULL, NULL);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false,
+					 htab_ma_dtor, htab);
 		if (err)
 			goto free_map_locked;
 		if (percpu) {
 			err = bpf_mem_alloc_init(&htab->pcpu_ma,
 						 round_up(htab->map.value_size, 8), true,
-						 NULL, NULL);
+						 htab_pcpu_ma_dtor, htab);
 			if (err)
 				goto free_map_locked;
 		}
-- 
2.29.2



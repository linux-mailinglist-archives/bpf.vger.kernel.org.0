Return-Path: <bpf+bounces-53648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B701FA57A90
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD259189565F
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F31D5AD8;
	Sat,  8 Mar 2025 13:39:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C02CAB
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441158; cv=none; b=RM6h+nCasBp2/yXf6pF7ehyFqBKuSVuVT6m2gZIuldom2y711GcnbIF0NpWNMk9GLLwXolbGUBDGGenaKbO7xSaJr1SXqdKpt1+rkBDRHgNbzjhl2hRo+CvZ9qUJ7WJvpaBdVd9Z1LiiJde2Mqa9o3I8IvYfv09FNI2zBEXLJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441158; c=relaxed/simple;
	bh=uKSLhWFHfca0L3faSnUmjdx/11JeUrbp9n10WvPc8gA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAJs9AjM6zKx45KFnCcWkPVZPhqS4DMimisIz+gF/A2OE/czA2lPuw56Bamj18VHgXxD6TMhQ3SGBDxpI2I8/CkNkpaufhBZig3mm/BWFr92S2q1PKNKVYztAlnEDNwo2DiPdZfjYd7JnzZy3kxf5fyxAk7QOfmVKXZhaDglSMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z944P6qT8z4f3jd8
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:38:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3256D1A06D7
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:39:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl91SMxn+YeeFw--.42876S8;
	Sat, 08 Mar 2025 21:39:07 +0800 (CST)
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Zvi Effron <zeffron@riotgames.com>,
	Cody Haas <chaas@riotgames.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 4/6] bpf: Add is_fd_htab() helper
Date: Sat,  8 Mar 2025 21:51:08 +0800
Message-Id: <20250308135110.953269-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250308135110.953269-1-houtao@huaweicloud.com>
References: <20250308135110.953269-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl91SMxn+YeeFw--.42876S8
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWxKF4xGFW7AFyrJryfXrb_yoW8XF48pr
	W8GrW2ka18ZFZFvay8Ja1vk398tr1vyw17uFWrJ34FyF1Y9rZxX3WDCa4xtF93AFy0yFn3
	Ar4aqFySqw4rCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jIPfQUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Add is_fd_htab() helper to check whether the map is htab of maps.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 909639fe4df25..d0c10a899beb8 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -195,6 +195,11 @@ static bool htab_is_percpu(const struct bpf_htab *htab)
 		htab->map.map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
 }
 
+static inline bool is_fd_htab(const struct bpf_htab *htab)
+{
+	return htab->map.map_type == BPF_MAP_TYPE_HASH_OF_MAPS;
+}
+
 static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
 {
 	return l->key + round_up(key_size, 8);
@@ -1005,8 +1010,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 
 static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
 {
-	return htab->map.map_type == BPF_MAP_TYPE_HASH_OF_MAPS &&
-	       BITS_PER_LONG == 64;
+	return is_fd_htab(htab) && BITS_PER_LONG == 64;
 }
 
 static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
@@ -1845,7 +1849,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			}
 		} else {
 			value = htab_elem_value(l, key_size);
-			if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
+			if (is_fd_htab(htab)) {
 				struct bpf_map **inner_map = value;
 
 				 /* Actual value is the id of the inner map */
-- 
2.29.2



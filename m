Return-Path: <bpf+bounces-40126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF997D441
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FAC2859BB
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1CD13CA8D;
	Fri, 20 Sep 2024 10:37:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE0C18EB1;
	Fri, 20 Sep 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828624; cv=none; b=F99u15g/qEdm1MKWfK5rd3vMaMM4g8zBzs7deDIFBf2JjzOwepT4uipKoXgY//9ukvE4thHcUCU8jRSjqAsB15pU/5MeoopbC+Z80O9XxhUS3X3GTBYn8Y0AAmc4qoI89cpf/NE+xcXOkiclYS4UsrQMjHxI90V0gMi2X+oTDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828624; c=relaxed/simple;
	bh=kKm6dXRsLN9MTEsRKSsBZBUKFOW/QiBO/l27WGRyAmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lw9Y11veFHBgP0mbAUp4q7Ng8x2ovcme5fORooxOq6QK/7Htx87suDWARtJEKODhhzhO2qtYinr1qhEGwyEVVL955PQKW6bagzw447zti8FO++laNMS/rmnpABztELLVu5E4NFk8tVa7JcYbO59yxDlSSyq7UjOro0CM8GTqWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X982B6lnpz4f3jXV;
	Fri, 20 Sep 2024 18:36:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DB3421A0E62;
	Fri, 20 Sep 2024 18:36:50 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgAnUy8_UO1m+HIqBw--.12050S2;
	Fri, 20 Sep 2024 18:36:48 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Roman Gushchin <guro@fb.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH 5.10] bpf: Fix mismatch memory accounting for devmap maps
Date: Fri, 20 Sep 2024 10:39:50 +0000
Message-Id: <20240920103950.3931497-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnUy8_UO1m+HIqBw--.12050S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF15tFyUXF48Jr43GF1xKrg_yoW5Gw1DpF
	W8Ga45Jr40yrsFqrWrKa1v9w15Gw40gr1jyrZ8C34Fkr40grn0qFyxKF1aqF9IkrWxCF1f
	uFnFqayku348ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Commit 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for
devmap maps") relies on the v5.11+ basic mechanism of memcg-based memory
accounting [0]. The commit cannot be independently backported to the
5.10 stable branch, otherwise the related memory when creating devmap
will be unrestricted and the associated bpf selftest map_ptr will fail.
Let's roll back to rlimit-based memory accounting mode for devmap and
re-adapt the commit 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check
on 32-bit arches") to the 5.10 stable branch.

Link: https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com [0]
Fixes: 225da02acdc9 ("bpf: Fix DEVMAP_HASH overflow check on 32-bit arches")
Fixes: 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for devmap maps")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/devmap.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 07b5edb2c70f..7eb1282edc8e 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -109,6 +109,8 @@ static inline struct hlist_head *dev_map_index_hash(struct bpf_dtab *dtab,
 static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 {
 	u32 valsize = attr->value_size;
+	u64 cost = 0;
+	int err;
 
 	/* check sanity of attributes. 2 value sizes supported:
 	 * 4 bytes: ifindex
@@ -136,11 +138,21 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 			return -EINVAL;
 
 		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
+		cost += (u64) sizeof(struct hlist_head) * dtab->n_buckets;
+	} else {
+		cost += (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev *);
+	}
 
+	/* if map size is larger than memlock limit, reject it */
+	err = bpf_map_charge_init(&dtab->map.memory, cost);
+	if (err)
+		return -EINVAL;
+
+	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-			return -ENOMEM;
+			goto free_charge;
 
 		spin_lock_init(&dtab->index_lock);
 	} else {
@@ -148,10 +160,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 						      sizeof(struct bpf_dtab_netdev *),
 						      dtab->map.numa_node);
 		if (!dtab->netdev_map)
-			return -ENOMEM;
+			goto free_charge;
 	}
 
 	return 0;
+
+free_charge:
+	bpf_map_charge_finish(&dtab->map.memory);
+	return -ENOMEM;
 }
 
 static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
-- 
2.34.1



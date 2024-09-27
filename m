Return-Path: <bpf+bounces-40414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F466988688
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 15:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865041F24421
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC51BFE01;
	Fri, 27 Sep 2024 13:48:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E91BF7F4;
	Fri, 27 Sep 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444896; cv=none; b=uWReLxCBETzSGfWw/R6ovRzdKSjt6cxWWvWR/QVRa0VXbU0NVU+B9NlBj4qBHR6Kw5Yc2tM3ADMjIWPBYxRatHlulqo83BSHoKUsehIljUwMgJMj+ggU0GKwocSLNcZBi9qE6kc+KnJ2JVXs9c2T+Xwr9DY1rRKnpFZxijwV3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444896; c=relaxed/simple;
	bh=3XS7CLKtVGqvlaO053kCqrUefPxw1aTwb/HExk9EREc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qt3Ni6O8EboEXFWhol7Tvwn3HG/Fz2B0dKnvN9XGpYodHt64s4EQQn1yUS6WD2y+nf3GJUuWKqJF+ex9S24QbGxw5fSqN/P4FInhEQ5r3l6OqxTtZpWybLY6JR0yS4ifHKNkmC6r78HoeUYgN1pRkXswISPC+BGaewXCq3m0//Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFWxp44Qnz4f3jks;
	Fri, 27 Sep 2024 21:47:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D84EF1A08FC;
	Fri, 27 Sep 2024 21:48:09 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHvMiYt_Zm3kQCCg--.422S4;
	Fri, 27 Sep 2024 21:48:09 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH 5.10 v2 2/3] Revert "bpf: Eliminate rlimit-based memory accounting for devmap maps"
Date: Fri, 27 Sep 2024 13:51:17 +0000
Message-Id: <20240927135118.1432057-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927135118.1432057-1-pulehui@huaweicloud.com>
References: <20240927135118.1432057-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHvMiYt_Zm3kQCCg--.422S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1ftFWfCFW7Wr48ZFy7ZFb_yoW8KrWrpF
	W8Ja45Jr40qrZrXrW5Ka1v9w4Ygw40gr1jkrZxA34Fkr10grn0qFyIgF1aqF909rWxCF1f
	uF12qayv9348ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2a9aDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

This reverts commit 70294d8bc31f3b7789e5e32f757aa9344556d964.

Commit 70294d8bc31f ("bpf: Eliminate rlimit-based memory accounting for
devmap maps") is part of the v5.11+ base mechanism of memcg-based memory
accounting[0]. The commit cannot be independently backported to the 5.10
stable branch, otherwise the related memory when creating devmap will be
unrestricted. Let's roll back to rlimit-based memory accounting mode for
devmap.

Link: https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com [0]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/devmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index ca2cade2871b..01149821ded9 100644
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
@@ -133,13 +135,21 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 
 		if (!dtab->n_buckets) /* Overflow check */
 			return -EINVAL;
+		cost += (u64) sizeof(struct hlist_head) * dtab->n_buckets;
+	} else {
+		cost += (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev *);
 	}
 
+	/* if map size is larger than memlock limit, reject it */
+	err = bpf_map_charge_init(&dtab->map.memory, cost);
+	if (err)
+		return -EINVAL;
+
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-			return -ENOMEM;
+			goto free_charge;
 
 		spin_lock_init(&dtab->index_lock);
 	} else {
@@ -147,10 +157,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
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



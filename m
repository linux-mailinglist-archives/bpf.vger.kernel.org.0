Return-Path: <bpf+bounces-40415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709D98868B
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D56284080
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EA1BFE0F;
	Fri, 27 Sep 2024 13:48:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5B189F5C;
	Fri, 27 Sep 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444900; cv=none; b=Z0tkg0HEUgB3Og9A/L9Eyj3NrG1c7ZFRb9zMJIQAj0C1/uD9tO2A7yU8A2HmiKvAbzQjzL5YvxBHQgw56x0lAOumqv4vBzn08ZIXxpYe/mQQ/STZspEdoNsMX5i1koIMfBLAQBrt+X027SzVUtSxtA/325P8+5WtDP8oUKEVFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444900; c=relaxed/simple;
	bh=h/TN4It2tSZZZCVG4L5HrRpBnHVWcPsA9NitlW9EgIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4xmzyK5YqcXH6cOsdpDgKpqvApbQGZHf36H74Qd5KB3miXs5CKf2Vmd2IoCkBoUGyRu6XBPLU3QOsKH/2ZLYrvSiYSvlNfunevaFCfwE0z6LB9blvbwXUiaNYUwFdXZx/mwDlMt6mjxVw8H66m5bgQaoDCG16NhfpB7HTy3fFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XFWxj444kz4f3jry;
	Fri, 27 Sep 2024 21:47:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E109C1A092F;
	Fri, 27 Sep 2024 21:48:09 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHvMiYt_Zm3kQCCg--.422S5;
	Fri, 27 Sep 2024 21:48:09 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH 5.10 v2 3/3] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Date: Fri, 27 Sep 2024 13:51:18 +0000
Message-Id: <20240927135118.1432057-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927135118.1432057-1-pulehui@huaweicloud.com>
References: <20240927135118.1432057-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHvMiYt_Zm3kQCCg--.422S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWrAF1kJry3Xr15trW8WFg_yoW5JF1UpF
	WDC3Wjgrs7Jr12q34qv3W0grWjkr18ZF1avFWqy340kr9Igwn3X340qFy3WF98Zr109F1f
	Kr429Fy093y5uaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
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
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU20PfDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 281d464a34f540de166cee74b723e97ac2515ec3 ]

The devmap code allocates a number hash buckets equal to the next power
of two of the max_entries value provided when creating the map. When
rounding up to the next power of two, the 32-bit variable storing the
number of buckets can overflow, and the code checks for overflow by
checking if the truncated 32-bit value is equal to 0. However, on 32-bit
arches the rounding up itself can overflow mid-way through, because it
ends up doing a left-shift of 32 bits on an unsigned long value. If the
size of an unsigned long is four bytes, this is undefined behaviour, so
there is no guarantee that we'll end up with a nice and tidy 0-value at
the end.

Syzbot managed to turn this into a crash on arm32 by creating a
DEVMAP_HASH with max_entries > 0x80000000 and then trying to update it.
Fix this by moving the overflow check to before the rounding up
operation.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Message-ID: <20240307120340.99577-2-toke@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/devmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 01149821ded9..7eb1282edc8e 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -131,10 +131,13 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-		if (!dtab->n_buckets) /* Overflow check */
+		/* hash table size must be power of 2; roundup_pow_of_two() can
+		 * overflow into UB on 32-bit arches, so check that first
+		 */
+		if (dtab->map.max_entries > 1UL << 31)
 			return -EINVAL;
+
+		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
 		cost += (u64) sizeof(struct hlist_head) * dtab->n_buckets;
 	} else {
 		cost += (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev *);
-- 
2.34.1



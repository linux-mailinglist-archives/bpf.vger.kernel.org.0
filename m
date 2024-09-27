Return-Path: <bpf+bounces-40416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23A98868C
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EA7283C23
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297981BFE10;
	Fri, 27 Sep 2024 13:48:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBB19ADBF;
	Fri, 27 Sep 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444900; cv=none; b=V9sy0WRECt4vb3ZcRbatcckF9kSR+XifmM1uUB50U6TcMn4lmweD5mWh1eCxcjFKNbb15EDF/gt81+dpz+M0zggs1XK7ehzXXg7kbhLo8oGxzY5OY7Vge/aY4y6Fq0Utg4NucwZRUmlBi1AqmeiHtmb+2axsJd4g8Zf8Hud/Qvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444900; c=relaxed/simple;
	bh=V9eTCYU4XX+e3IYCCY9FtInd9JmbB7Kd/prqSuG1z9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwaf29A0oSz/49Ct57FkkrHjlN1ZEyuE5FtCzEZscWO6KsqCzQrl9WGVgXtJNayHID549YLtq8HcAwlmYcxnIoK+5g2Go7Jy7Tp4n6cAvemLhrdDt9xrkkM0TqK+pf2JjtXsn8cDybxooIj4AkT/WfP9K/ZtyJczoiUbmtBlcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XFWxj3CVxz4f3jXP;
	Fri, 27 Sep 2024 21:47:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C23D61A08FC;
	Fri, 27 Sep 2024 21:48:09 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHvMiYt_Zm3kQCCg--.422S3;
	Fri, 27 Sep 2024 21:48:09 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH 5.10 v2 1/3] Revert "bpf: Fix DEVMAP_HASH overflow check on 32-bit arches"
Date: Fri, 27 Sep 2024 13:51:16 +0000
Message-Id: <20240927135118.1432057-2-pulehui@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHvMiYt_Zm3kQCCg--.422S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw17Wr1kXFWDZw17JFyftFb_yoW8XF1rpr
	WrA3W5Ww48Jr9Fq39Yqa1vg3yjkw40gryavr9xA34Skr4Igrnaq34vy3WrWF9Ikry0kF1S
	qrn0qay0v34UuFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUw0eHUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

This reverts commit 225da02acdc97af01b6bc6ce1a3e5362bf01d3fb.

Commit 225da02acdc9 ("bpf: fix DEVMAP_HASH overflow check on 32-bit
architectures") relies on the v5.11+ base mechanism of memcg-based
memory accounting[0], which is not yet supported on the 5.10 stable
branch, so let's revert this commit in preparation for re-adapting it.

Link: https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com [0]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/devmap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 07b5edb2c70f..ca2cade2871b 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -129,14 +129,13 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		/* hash table size must be power of 2; roundup_pow_of_two() can
-		 * overflow into UB on 32-bit arches, so check that first
-		 */
-		if (dtab->map.max_entries > 1UL << 31)
-			return -EINVAL;
-
 		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
 
+		if (!dtab->n_buckets) /* Overflow check */
+			return -EINVAL;
+	}
+
+	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-- 
2.34.1



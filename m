Return-Path: <bpf+bounces-53650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 309AEA57A91
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 14:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258217A7BEA
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD921D63CC;
	Sat,  8 Mar 2025 13:39:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C31D4356
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441160; cv=none; b=Ey91gQZrO3TO+R2K9c/V2on1OCMBgz+2uPcjK7FOEW46RSKwN4cHxfN2skLGuOZb0eT5aCYCuHcU50IVsoqySkhN8y2S8JCZjns3+KaIB/CGOwKUUbI9xG6f+82Z9yR9m6BNd8cVcpetmZXvVFmY9+Oy9T3ggj0gMUOifWUCbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441160; c=relaxed/simple;
	bh=PSvj8NYvKDkdKdSd3BU+wXtKc18r/YYLWvDRWjE9no8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClQ2RV/FQ/uC8i66MoiVjIJoF6UbF9K/6aEUwjFUoAc1g+FZxD5aHAWn7hHkOusmoWwKV3aaQlObH8WJWOfbjZij67LosEtASaZxL4lLav+IPitO7E9fQMGYrqBCnFi7bdhsbactlgeiIeR0I90W2S0TKjXzPMGcajSTmkLwRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z944Q4F3Qz4f3jd9
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:38:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE58E1A058E
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:39:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl91SMxn+YeeFw--.42876S9;
	Sat, 08 Mar 2025 21:39:08 +0800 (CST)
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
Subject: [PATCH bpf-next v2 5/6] bpf: Don't allocate per-cpu extra_elems for fd htab
Date: Sat,  8 Mar 2025 21:51:09 +0800
Message-Id: <20250308135110.953269-6-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnSl91SMxn+YeeFw--.42876S9
X-Coremail-Antispam: 1UD129KBjvJXoW7tr18tr4rAFWfCw4UWF1Dtrb_yoW8ZryDpF
	4xGF129r1rXrs2gws8JanFkrWYvr1xtFyUCa90q34Fva4UZws2gr17Aa1I9FyFkryxtw1f
	XrySva4Svay8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
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

The update of element in fd htab is in-place now, therefore, there is no
need to allocate per-cpu extra_elems, just remove it.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d0c10a899beb8..36236d806bac7 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -226,9 +226,13 @@ static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
 }
 
+/* Both percpu and fd htab support in-place update, so no need for
+ * extra elem. LRU itself can remove the least used element, so
+ * there is no need for an extra elem during map_update.
+ */
 static bool htab_has_extra_elems(struct bpf_htab *htab)
 {
-	return !htab_is_percpu(htab) && !htab_is_lru(htab);
+	return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
 }
 
 static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
@@ -484,8 +488,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 {
 	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		       attr->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH);
-	bool lru = (attr->map_type == BPF_MAP_TYPE_LRU_HASH ||
-		    attr->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH);
 	/* percpu_lru means each cpu has its own LRU list.
 	 * it is different from BPF_MAP_TYPE_PERCPU_HASH where
 	 * the map's value itself is percpu.  percpu_lru has
@@ -591,10 +593,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		if (err)
 			goto free_map_locked;
 
-		if (!percpu && !lru) {
-			/* lru itself can remove the least used element, so
-			 * there is no need for an extra elem during map_update.
-			 */
+		if (htab_has_extra_elems(htab)) {
 			err = alloc_extra_elems(htab);
 			if (err)
 				goto free_prealloc;
-- 
2.29.2



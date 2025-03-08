Return-Path: <bpf+bounces-53646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97600A57A8D
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 14:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F00F3B340D
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4F1D07BA;
	Sat,  8 Mar 2025 13:39:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16671C84B7
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441158; cv=none; b=CLT0Sy2B1gPejk+VlPuJOw+gJM9MqxyR84/DkJtdZF5ifVNRXAwSg6hWuceVkIB5TmZ8vukKiKOB/r7oXcqWI1OdE3yZ+y6PqrYYyUz27o7DmksK7kxQEuzeLRJXTqPmKJjijTlT/NtzuRp5aSjH1xXmNSQcDpO4FJX8KCZS6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441158; c=relaxed/simple;
	bh=NA0d4ivkGss2moSgpe5rrOFcE68pJGUX2H+mhizGOXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1akzo+oCajvhsQuwQXrywENy6T4sA9rTtOZZ2CDoYXX4LL/bUzk6KoHizv8mfXdPl1SrQ8SU04uHnjaqRfNs745TAASmqnoKhj8HiBBThWW1PITipGuvOp+8xU08m3W08nOICgdZp8WEmke5T9kGxkw4fPX41O9Jx2B9Zfoy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z944M1XCCz4f3m7Z
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:38:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E20D81A058E
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:39:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl91SMxn+YeeFw--.42876S6;
	Sat, 08 Mar 2025 21:39:06 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/6] bpf: Rename __htab_percpu_map_update_elem to htab_map_update_elem_in_place
Date: Sat,  8 Mar 2025 21:51:06 +0800
Message-Id: <20250308135110.953269-3-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDnSl91SMxn+YeeFw--.42876S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4kZw1kKF1kAF43JF43Wrg_yoW5GFyxpF
	WrWFyIkr4IqFs0g3yrtw4agrW5Arn5Xw10ka4DKa4Fyr9Fgrn7Ar17JFZ2yr15Cr4UZr4r
	tF9FqFy2yayxurUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIID7
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Rename __htab_percpu_map_update_elem to htab_map_update_elem_in_place,
and add a new percpu argument for the helper to support in-place update
for both per-cpu htab and htab of maps.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0df86845c8472..8d78a518cf820 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1289,12 +1289,12 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	return ret;
 }
 
-static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
+static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 					  void *value, u64 map_flags,
-					  bool onallcpus)
+					  bool percpu, bool onallcpus)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	struct htab_elem *l_new = NULL, *l_old;
+	struct htab_elem *l_new, *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
 	struct bucket *b;
@@ -1326,19 +1326,18 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 		goto err;
 
 	if (l_old) {
-		/* per-cpu hash map can update value in-place */
+		/* Update value in-place */
 		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
 				value, onallcpus);
 	} else {
 		l_new = alloc_htab_elem(htab, key, value, key_size,
-					hash, true, onallcpus, NULL);
+					hash, percpu, onallcpus, NULL);
 		if (IS_ERR(l_new)) {
 			ret = PTR_ERR(l_new);
 			goto err;
 		}
 		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
 	}
-	ret = 0;
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 	return ret;
@@ -1417,7 +1416,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 static long htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 					void *value, u64 map_flags)
 {
-	return __htab_percpu_map_update_elem(map, key, value, map_flags, false);
+	return htab_map_update_elem_in_place(map, key, value, map_flags, true, false);
 }
 
 static long htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
@@ -2442,8 +2441,8 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 		ret = __htab_lru_percpu_map_update_elem(map, key, value,
 							map_flags, true);
 	else
-		ret = __htab_percpu_map_update_elem(map, key, value, map_flags,
-						    true);
+		ret = htab_map_update_elem_in_place(map, key, value, map_flags,
+						    true, true);
 	rcu_read_unlock();
 
 	return ret;
-- 
2.29.2



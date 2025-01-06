Return-Path: <bpf+bounces-47932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E52A02059
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49463A4A92
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D71D63CA;
	Mon,  6 Jan 2025 08:07:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F61A00EC;
	Mon,  6 Jan 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150833; cv=none; b=XELxjrnIn33ZuRN6hj8+xqMG/GG1RyeTxpRvUGB2Jzg4LsQ998N8S4XmAJGcd4C6gpDhCfqvzYrJrVsbMRqVPPHImjMMzQVH7Al2nTojvv2cPI+KhUaFZSr57/s43+xwjwGrsrksQT2eQUkaW4tKqoKFQrgL50S4FVlVH4z/mFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150833; c=relaxed/simple;
	bh=at3uEMnzEj2GGm7Y8UIrPau6TJoYjaGeAfrMnaI3nCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pgg5Cs6EjwJNw7bqovoQ3CH+PuiYhND6B9eVvzeQppe+KSrTfINW47n9PJpiw23YFpnT6s4ZHYqtxfpt2Io2qHMxaePLeUkyyYu/A5KUlUsigFTVu/vNHJ+QawFkQc+A+udztfD5vn46018RuY9IvqZ132mwz4Yb98TY70MZ574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRbX5hC1z4f3jss;
	Mon,  6 Jan 2025 16:06:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B6DC21A1485;
	Mon,  6 Jan 2025 16:07:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S19;
	Mon, 06 Jan 2025 16:07:03 +0800 (CST)
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 15/19] bpf: Disable migration before calling ops->map_free()
Date: Mon,  6 Jan 2025 16:18:56 +0800
Message-Id: <20250106081900.1665573-16-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250106081900.1665573-1-houtao@huaweicloud.com>
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S19
X-Coremail-Antispam: 1UD129KBjvJXoWxJw17Cr1ktFW3Aw4rJrWDJwb_yoWrXr4rpa
	n5Kryjkr40qF47u398Xan7Cry5Aw45K34aka95A34Fvr43Xr93Xrn2vFy3XFyY9r1ktr1F
	v3Z0g34Yk3y8urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Disabling migration before calling ops->map_free() to simplify the
freeing of map values or special fields allocated from bpf memory
allocator.

After disabling migration in bpf_map_free(), there is no need for
additional migration_{disable|enable} pairs in the ->map_free()
callbacks. Remove these redundant invocations.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/arraymap.c          | 2 --
 kernel/bpf/bpf_local_storage.c | 2 --
 kernel/bpf/hashtab.c           | 2 --
 kernel/bpf/range_tree.c        | 2 --
 kernel/bpf/syscall.c           | 8 +++++++-
 5 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 451737493b17..eb28c0f219ee 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -455,7 +455,6 @@ static void array_map_free(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
-	migrate_disable();
 	if (!IS_ERR_OR_NULL(map->record)) {
 		if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 			for (i = 0; i < array->map.max_entries; i++) {
@@ -472,7 +471,6 @@ static void array_map_free(struct bpf_map *map)
 				bpf_obj_free_fields(map->record, array_map_elem_ptr(array, i));
 		}
 	}
-	migrate_enable();
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
 		bpf_array_free_percpu(array);
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b649cf736438..12cf6382175e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -905,13 +905,11 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			migrate_disable();
 			if (busy_counter)
 				this_cpu_inc(*busy_counter);
 			bpf_selem_unlink(selem, true);
 			if (busy_counter)
 				this_cpu_dec(*busy_counter);
-			migrate_enable();
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8bf1ad326e02..6051f8a39fec 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1570,14 +1570,12 @@ static void htab_map_free(struct bpf_map *map)
 	 * underneath and is responsible for waiting for callbacks to finish
 	 * during bpf_mem_alloc_destroy().
 	 */
-	migrate_disable();
 	if (!htab_is_prealloc(htab)) {
 		delete_all_elements(htab);
 	} else {
 		htab_free_prealloced_fields(htab);
 		prealloc_destroy(htab);
 	}
-	migrate_enable();
 
 	bpf_map_free_elem_count(map);
 	free_percpu(htab->extra_elems);
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 5bdf9aadca3a..37b80a23ae1a 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -259,9 +259,7 @@ void range_tree_destroy(struct range_tree *rt)
 
 	while ((rn = range_it_iter_first(rt, 0, -1U))) {
 		range_it_remove(rn, rt);
-		migrate_disable();
 		bpf_mem_free(&bpf_global_ma, rn);
-		migrate_enable();
 	}
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0503ce1916b6..e7a41abe4809 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -835,8 +835,14 @@ static void bpf_map_free(struct bpf_map *map)
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
 
-	/* implementation dependent freeing */
+	/* implementation dependent freeing. Disabling migration to simplify
+	 * the free of values or special fields allocated from bpf memory
+	 * allocator.
+	 */
+	migrate_disable();
 	map->ops->map_free(map);
+	migrate_enable();
+
 	/* Delay freeing of btf_record for maps, as map_free
 	 * callback usually needs access to them. It is better to do it here
 	 * than require each callback to do the free itself manually.
-- 
2.29.2



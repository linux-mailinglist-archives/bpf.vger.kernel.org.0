Return-Path: <bpf+bounces-55034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C755A7744A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBEC1889709
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 06:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714521E0DEB;
	Tue,  1 Apr 2025 06:10:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BE1DC9B3
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487859; cv=none; b=nlSa8fswtO8qOqr4YCqaCLaPlqssz+6vjlaJoNHOgO5Cbbd6EksUsXtT8KI6a2Gywmfoa6CcqZXQACElXstgpqwJc9sOK0//W/Q6TkQspgNzhAS729rNfUM+K0ZUv8u+nl0MFa8ALgEXmWGBOSxencnIA3QXPyC6sDMg3XkyRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487859; c=relaxed/simple;
	bh=OgD/+uw0IzqXJEd7J8owG3Annzyp/JUQCAJGu+onx1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCaGWm58fOKa6D/aQ60Ahv3KbRnuXBdsRklndikAbtxsczuPvk7McxzurvstN1CAXYrE6mtWhi3HFw4WSyWAFs20qpZViVNvTaMMC02G7p3j3auoPYZucCsbrPTmOKG22M+dI8+QyyxxKycY1wG4QriIpnJw89Rppm5L1TdL6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZRd006QS6z4f3jHv
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0F6391A1103
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9ig+tnpa6yIA--.16784S6;
	Tue, 01 Apr 2025 14:10:47 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/6] bpf: Rename __htab_percpu_map_update_elem to htab_map_update_elem_in_place
Date: Tue,  1 Apr 2025 14:22:46 +0800
Message-Id: <20250401062250.543403-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250401062250.543403-1-houtao@huaweicloud.com>
References: <20250401062250.543403-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9ig+tnpa6yIA--.16784S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4fuw4xXr47Ary5KFyrXrb_yoW5Gw4xpF
	WrWFyIkr4IgFsYq3yrtw4agrW5Arn5Xw10kas8Ka4Fyr9Fgrn7Ar17GF97Ar15Cr45Zr4r
	tF9FqFW2yay8urUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0I3
	85UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Rename __htab_percpu_map_update_elem to htab_map_update_elem_in_place,
and add a new percpu argument for the helper to support in-place update
for both per-cpu htab and htab of maps.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0bebc919bbf7..9778e9871d86 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1258,12 +1258,12 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
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
@@ -1295,19 +1295,18 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
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
 	htab_unlock_bucket(b, flags);
 	return ret;
@@ -1386,7 +1385,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 static long htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 					void *value, u64 map_flags)
 {
-	return __htab_percpu_map_update_elem(map, key, value, map_flags, false);
+	return htab_map_update_elem_in_place(map, key, value, map_flags, true, false);
 }
 
 static long htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
@@ -2407,8 +2406,8 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
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



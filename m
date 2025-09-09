Return-Path: <bpf+bounces-67917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EFAB503ED
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313BB1C68122
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB72393DE3;
	Tue,  9 Sep 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="oIWgaX8z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5B36207D
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437238; cv=none; b=AbIQ6FRzo/jk8OPW0ahIdMiY3olcxRBEhI7mljGjIveb76n3D0cgZXTPC3v8Rym+OyE36OKHltWflT/K4gp54XV3BJlRTL8WfNmG04poKOK3EweYHwaDaBzsIQ/DrC4ZeWiz1S5dB0JDximBs5pWr0t23IPDam9mOo+oHWv/Gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437238; c=relaxed/simple;
	bh=DrqKifxp4/3EA1fZ8ZjyUxYSe6CL4DDCfmnwB3B6reE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgTu9PVjvFN0ZFLKpP+5DyuUU9Y0dA5SGJYMuSWoyeWXirSn0c5J/OrOWZvUZ+d6DKF31IqhZNZXOgigMug3VS+F/jhS0WLDTinL9sj1nWmNxRxalGVmxN72KtIR3ctZHGzPqc0YMaRA0V0yFrlyx4JrTj3/hfxArPPQk31W1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=oIWgaX8z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-248f2da72edso10699355ad.2
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437236; x=1758042036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9sO4b4SQnQcjqB44YTL9B44um/cVz3vo8RkSINUUVk=;
        b=oIWgaX8zHkQ9bZNoMbr43bbBe5W6hthTCbM6/YNxX7H17AggGvhvV8QeNuWVfumD9Q
         IM4g62aJGVx/SZ+EZ4z7wzrEVJhrOoG9pocJxTtYPZesg4VGwhr2GHJZDoUJtihZ+/X2
         5BN4B0aEHI6RbxgMDttsWozP0zepGRH5cFc0IRuQagShXvhepJ+MQfNZ82AklfeHk+nL
         zjZgmTtmM3IaZc72L4hJcj/jNqgOMPoiZ36NeDYDwL9IXZ+KMfcHHRdCpgpUCnR8iYOg
         M0fvUPNrP7LXeu8yf699b6X5panajWNAc6MPM4R/tXdCULWqobBfLuSHzfJuA5/Eb3jp
         zyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437236; x=1758042036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9sO4b4SQnQcjqB44YTL9B44um/cVz3vo8RkSINUUVk=;
        b=u8e0V+6L3Qvn+LaAy3HkpxAuY+OUwiNlCXnAiKeVgCd31J4SuJM71SzRR02UqelBjM
         yF1Fikc6FuVmM0GSiPyf+i4KTDLMbiCWQ5UQdA1wn/6ikZp3hFYNyl5ptfaw0ayWBNtR
         S/MaRJUywoxuTRe+qXZ7ToeVUeOQeBf9oM7Vgno2DGVj47kgUhYJhBweuPw2h6cx9JKf
         K4Lvm/Vwgwl1xXvpoDxpHVcBHY+bTFmUHFZuCQ7rc8v9siHvR1yuEZVKYh/HjwjT6sLL
         ONQdJlUIlEkAr9DL3B8uaHfOcC68CPkBD+7nim9Au4e05bu7dMz2sW8OeIiDgTvHQsjR
         yHDw==
X-Gm-Message-State: AOJu0YxXcioQftl1YlBcHNfSYzYhzY+0VMtTOWguzkKfzTlK2XuQjIJ6
	30RMBmVWBj5w2jSywHn7PiX9g5rwJ7eCjuxbRBngUaYur0f8Pc4Z0M/LVSOQYEft3gfNPU/V6pu
	/SGwu
X-Gm-Gg: ASbGncvn2oROZhJBGAVtwM0bvH4KTGG2tcjJVofXvZPgwD131LSkW0bmT7wOhBHoL72
	Jgf1Fb8GxlxmwpXn1IRaBIW3fUTO+7WnXPmbNu+Hc22MfYCjRLB/3XVYnM18EUusrfkhsTUe+nu
	Xb7WK4SsOVbCZi0V0X0YLBKtH6s3Bmehm/1jj2f5A7c88VeZpWqj692gXC9XMJQtGhEHKyGhaNV
	sYdwCHBu49MStI+v+MSp8gW6L/heLNHjpJiuuAiUZ0gwwEh04PT9McW3il+hQRGw0t13RCpSNme
	MF0GfmABov+cf7lgsTROZunGjSYSmL7lVlH8fOK73n0AG9r5iEecdN/rDDdBV+VBvX2arZIm08i
	eK3/chnRsWz0Dy1udoa7NCWC+
X-Google-Smtp-Source: AGHT+IHmeA4xr0wMTxD82gnCjaQ+kBc+jmaPm/QL2h2dL9R0uKiEB30aZwLUFV5TAiguztSTBxSVDQ==
X-Received: by 2002:a17:902:d486:b0:248:f30e:6a26 with SMTP id d9443c01a7336-25174c1b646mr93091795ad.7.1757437234373;
        Tue, 09 Sep 2025 10:00:34 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:33 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 07/14] bpf: Support key prefix filtering for socket hash iterators
Date: Tue,  9 Sep 2025 10:00:01 -0700
Message-ID: <20250909170011.239356-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complimenting the change to socket hashes that allows users to bucket
keys with the same prefix together, support a key prefix filter for
socket hash iterators that traverses all the sockets in the bucket
matching the provided prefix. Together, the bucketing control and key
prefix filter allow for efficient iteration over a set of sockets
whose keys share a common prefix without needing to iterate through
every key in every bucket to find those that we're interested in.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/linux/bpf.h            |  4 ++
 include/uapi/linux/bpf.h       |  7 ++++
 net/core/sock_map.c            | 67 ++++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  7 ++++
 4 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a8..1c7bb1fb3a80 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2632,6 +2632,10 @@ struct bpf_iter_aux_info {
 		enum bpf_iter_task_type	type;
 		u32 pid;
 	} task;
+	struct {
+		void *key_prefix;
+		u32 key_prefix_len;
+	} sockhash;
 };
 
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..22761dea4635 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -124,6 +124,13 @@ enum bpf_cgroup_iter_order {
 union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
+		union {
+			/* Parameters for socket hash iterators. */
+			struct {
+				__aligned_u64	key_prefix;	/* key prefix filter */
+				__u32		key_prefix_len; /* key_prefix length */
+			} sock_hash;
+		};
 	} map;
 	struct {
 		enum bpf_cgroup_iter_order order;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 51930f24d2f9..b0b428190561 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -889,10 +889,16 @@ static inline void sock_hash_elem_hash(const void *key, u32 *bucket_hash,
 	*hash = hash_len == key_size ? *bucket_hash : jhash(key, key_size, 0);
 }
 
+static inline u32 sock_hash_select_bucket_num(struct bpf_shtab *htab,
+					      u32 hash)
+{
+	return hash & (htab->buckets_num - 1);
+}
+
 static struct bpf_shtab_bucket *sock_hash_select_bucket(struct bpf_shtab *htab,
 							u32 hash)
 {
-	return &htab->buckets[hash & (htab->buckets_num - 1)];
+	return &htab->buckets[sock_hash_select_bucket_num(htab, hash)];
 }
 
 static struct bpf_shtab_elem *
@@ -1376,6 +1382,8 @@ struct sock_hash_seq_info {
 	struct bpf_map *map;
 	struct bpf_shtab *htab;
 	struct bpf_shtab_elem *next_elem;
+	void *key_prefix;
+	u32 key_prefix_len;
 	u32 bucket_id;
 };
 
@@ -1384,7 +1392,8 @@ static inline bool bpf_shtab_elem_unhashed(struct bpf_shtab_elem *elem)
 	return READ_ONCE(elem->node.pprev) == LIST_POISON2;
 }
 
-static struct bpf_shtab_elem *sock_hash_seq_hold_next(struct bpf_shtab_elem *elem)
+static struct bpf_shtab_elem *sock_hash_seq_hold_next(struct sock_hash_seq_info *info,
+						      struct bpf_shtab_elem *elem)
 {
 	hlist_for_each_entry_from_rcu(elem, node)
 		/* It's possible that the first element or its descendants were
@@ -1392,6 +1401,9 @@ static struct bpf_shtab_elem *sock_hash_seq_hold_next(struct bpf_shtab_elem *ele
 		 * until we get back to the main list.
 		 */
 		if (!bpf_shtab_elem_unhashed(elem) &&
+		    (!info->key_prefix ||
+		     !memcmp(&elem->key, info->key_prefix,
+			     info->key_prefix_len)) &&
 		    sock_hash_hold_elem(elem))
 			return elem;
 
@@ -1435,21 +1447,27 @@ static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
 	if (prev_elem) {
 		node = rcu_dereference(hlist_next_rcu(&prev_elem->node));
 		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
-		elem = sock_hash_seq_hold_next(elem);
+		elem = sock_hash_seq_hold_next(info, elem);
 		if (elem)
 			goto unlock;
-
-		/* no more elements, continue in the next bucket */
-		info->bucket_id++;
+		if (info->key_prefix)
+			/* no more elements, skip to the end */
+			info->bucket_id = htab->buckets_num;
+		else
+			/* no more elements, continue in the next bucket */
+			info->bucket_id++;
 	}
 
 	for (; info->bucket_id < htab->buckets_num; info->bucket_id++) {
 		bucket = &htab->buckets[info->bucket_id];
 		node = rcu_dereference(hlist_first_rcu(&bucket->head));
 		elem = hlist_entry_safe(node, struct bpf_shtab_elem, node);
-		elem = sock_hash_seq_hold_next(elem);
+		elem = sock_hash_seq_hold_next(info, elem);
 		if (elem)
 			goto unlock;
+		if (info->key_prefix)
+			/* no more elements, skip to the end */
+			info->bucket_id = htab->buckets_num;
 	}
 unlock:
 	/* sock_hash_put_elem() will free all elements up until the
@@ -1544,10 +1562,18 @@ static int sock_hash_init_seq_private(void *priv_data,
 				      struct bpf_iter_aux_info *aux)
 {
 	struct sock_hash_seq_info *info = priv_data;
+	u32 hash;
 
 	bpf_map_inc_with_uref(aux->map);
 	info->map = aux->map;
 	info->htab = container_of(aux->map, struct bpf_shtab, map);
+	info->key_prefix = aux->sockhash.key_prefix;
+	info->key_prefix_len = aux->sockhash.key_prefix_len;
+	if (info->key_prefix) {
+		sock_hash_elem_hash(info->key_prefix, &hash, &hash,
+				    info->key_prefix_len, info->key_prefix_len);
+		info->bucket_id = sock_hash_select_bucket_num(info->htab, hash);
+	}
 	return 0;
 }
 
@@ -2039,8 +2065,12 @@ static int sock_map_iter_attach_target(struct bpf_prog *prog,
 				       union bpf_iter_link_info *linfo,
 				       struct bpf_iter_aux_info *aux)
 {
+	void __user *ukey_prefix;
+	struct bpf_shtab *htab;
 	struct bpf_map *map;
+	u32 key_prefix_len;
 	int err = -EINVAL;
+	void *key_prefix;
 
 	if (!linfo->map.map_fd)
 		return -EBADF;
@@ -2053,6 +2083,27 @@ static int sock_map_iter_attach_target(struct bpf_prog *prog,
 	    map->map_type != BPF_MAP_TYPE_SOCKHASH)
 		goto put_map;
 
+	if (map->map_type == BPF_MAP_TYPE_SOCKHASH) {
+		ukey_prefix = u64_to_user_ptr(linfo->map.sock_hash.key_prefix);
+		key_prefix_len = linfo->map.sock_hash.key_prefix_len;
+		htab = container_of(map, struct bpf_shtab, map);
+
+		if (ukey_prefix) {
+			if (key_prefix_len != htab->hash_len)
+				goto put_map;
+			key_prefix = vmemdup_user(ukey_prefix, key_prefix_len);
+			if (IS_ERR(key_prefix)) {
+				err = PTR_ERR(key_prefix);
+				goto put_map;
+			}
+		} else if (linfo->map.sock_hash.key_prefix_len) {
+			goto put_map;
+		}
+
+		aux->sockhash.key_prefix_len = key_prefix_len;
+		aux->sockhash.key_prefix = key_prefix;
+	}
+
 	if (prog->aux->max_rdonly_access > map->key_size) {
 		err = -EACCES;
 		goto put_map;
@@ -2069,6 +2120,8 @@ static int sock_map_iter_attach_target(struct bpf_prog *prog,
 static void sock_map_iter_detach_target(struct bpf_iter_aux_info *aux)
 {
 	bpf_map_put_with_uref(aux->map);
+	if (aux->sockhash.key_prefix)
+		kvfree(aux->sockhash.key_prefix);
 }
 
 static struct bpf_iter_reg sock_map_iter_reg = {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..22761dea4635 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -124,6 +124,13 @@ enum bpf_cgroup_iter_order {
 union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
+		union {
+			/* Parameters for socket hash iterators. */
+			struct {
+				__aligned_u64	key_prefix;	/* key prefix filter */
+				__u32		key_prefix_len; /* key_prefix length */
+			} sock_hash;
+		};
 	} map;
 	struct {
 		enum bpf_cgroup_iter_order order;
-- 
2.43.0



Return-Path: <bpf+bounces-67719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166AB491D1
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DF0443A44
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFB530CD88;
	Mon,  8 Sep 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cROYxaXn"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C030CD8A
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342257; cv=none; b=PUZxerHi3Vy1WKJXCw3vWswXHatNqwxDpyMpDn1gozDxzfw75sVljzjA35eLHXIXigUjukpWWU8LbjF3ZWvOdgvJTU5V0BPQc/P55stdX15yxh5v+QAEtJoBLWBIixXcNtTRCrHGAvA7eytTBKk66Vqlj3u6L2PGQjU8GVvXYw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342257; c=relaxed/simple;
	bh=38XPSrTkFDdrKSbbHiBm0/u5lyISzsf8Ts3UPwBtVt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1Hm1avi5HT3t4WeQHhUNa3VyE2fd1rfg0GMGtvPCtpMgkH4gO9fz2wTBFT36UjRb1Duv18S/Bf/p3BuYdN0Uq8rrq8WEd43Ljp87rTfsqATrxCo10h25NXsRnxelvddJRxwqHHx38vRJnGe2BhsyuqKVKWqdMGhIS2R+pTNGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cROYxaXn; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757342253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkByU/HSwfoLHTAd2QY3K1C7U7ErURVH0AEhy+DETco=;
	b=cROYxaXn/Ed1Le72Sg0QB/P7pwPLmmzE8V0nMqm6Vv3CPvuVam1Le3O9JxEEXIULbTj+CV
	TpSANNPOWfXl7GT+bMCjO0IpB0i7F7PMQlmV+4oV6/2tSWbcUvDdKEYsjaaYwV3C6z+/nj
	nV//ThA/SsQoibnpfwqJ+IrkdMSznCU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v5 6/9] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps
Date: Mon,  8 Sep 2025 22:36:41 +0800
Message-ID: <20250908143644.30993-7-leon.hwang@linux.dev>
In-Reply-To: <20250908143644.30993-1-leon.hwang@linux.dev>
References: <20250908143644.30993-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_hash
maps to allow updating values for all CPUs with a single value for both
update_elem and update_batch APIs.

Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
maps to allow:

* update value for specified CPU for both update_elem and update_batch
  APIs.
* lookup value for specified CPU for both lookup_elem and lookup_batch
  APIs.

The BPF_F_CPU flag is passed via:

* map_flags along with embedded cpu info.
* elem_flags along with embedded cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/hashtab.c | 41 +++++++++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 67122f852f16d..2254aafc93773 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3756,6 +3756,8 @@ static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 {
 	switch (map_type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 		return true;
 	default:
 		return false;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8955ae8482065..48b45c0945923 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1259,9 +1259,15 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	if (percpu) {
+		ret = bpf_map_check_cpu_flags(map_flags, true);
+		if (unlikely(ret))
+			return ret;
+	} else {
+		if (unlikely(map_flags > BPF_EXIST))
+			/* unknown flags */
+			return -EINVAL;
+	}
 
 	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
 		     !rcu_read_lock_bh_held());
@@ -1322,9 +1328,9 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	ret = bpf_map_check_cpu_flags(map_flags, true);
+	if (unlikely(ret))
+		return ret;
 
 	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
 		     !rcu_read_lock_bh_held());
@@ -1689,9 +1695,19 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	int ret = 0;
 
 	elem_map_flags = attr->batch.elem_flags;
-	if ((elem_map_flags & ~BPF_F_LOCK) ||
-	    ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
-		return -EINVAL;
+	if (!do_delete && is_percpu) {
+		ret = bpf_map_check_lookup_batch_flags(map, elem_map_flags);
+		if (ret)
+			return ret;
+		ret = bpf_map_check_cpu_flags(elem_map_flags, false);
+		if (ret)
+			return ret;
+	} else {
+		if ((elem_map_flags & ~BPF_F_LOCK) ||
+		    ((elem_map_flags & BPF_F_LOCK) &&
+		     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
+			return -EINVAL;
+	}
 
 	map_flags = attr->batch.flags;
 	if (map_flags)
@@ -2355,8 +2371,13 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_fl
 {
 	struct htab_elem *l;
 	void __percpu *pptr;
-	int ret = -ENOENT;
 	u32 size;
+	int ret;
+
+	ret = bpf_map_check_cpu_flags(map_flags, false);
+	if (unlikely(ret))
+		return ret;
+	ret = -ENOENT;
 
 	/* per_cpu areas are zero-filled and bpf programs can only
 	 * access 'value_size' of them, so copying rounded areas
-- 
2.50.1



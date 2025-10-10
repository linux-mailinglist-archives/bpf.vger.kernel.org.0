Return-Path: <bpf+bounces-70761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B92BCE17D
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 19:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF2D3B9524
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820CF223702;
	Fri, 10 Oct 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIr48CZX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE92236E5
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117425; cv=none; b=I9cwjjpVXdYonmbS8WooH6qBgmOcV+24pRZn49WZQ/qNsnHQnBtxN69gxv6KLnA19LGpgIcFx0cYk++DF2gXdYdpJYx1ge94c23E20ULuJHPJnOAHFR1IJKPcZ4bRV8a+FGET+lpkL1oE3rPphlTG4Q7qc82/QfdArs0hUd0wfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117425; c=relaxed/simple;
	bh=ByhsrfOY2dWGL+UZQ+39guFkDTfibxHMRp0ZDKVJvXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvHN/zKVHjE6mJErBpE5dhoLX+ejLxDNlwteHl3KcKxralE3ALIE5t2NY6y9QafMEq/beUwavKRbirzf/XWCut5DwuMnC0e9yghqjZ61UKUICQCFSeAW/+0tJ/xG3C3MNCS4D7yBhr9TXZJMDJD7Ro6PieB4RiK7pdsvlGIqezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIr48CZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5799AC4CEF5;
	Fri, 10 Oct 2025 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760117424;
	bh=ByhsrfOY2dWGL+UZQ+39guFkDTfibxHMRp0ZDKVJvXM=;
	h=From:To:Cc:Subject:Date:From;
	b=dIr48CZXlo/EHGM4nng6fg14jsJM+1/MP0x2Acgvoc9lcya4ZhtIVaMXCPC+lo61p
	 yTVni9aFb6iZWzQTXRaletsyuK+lfGdwgPfUK6RysV7k6ICwwGtp7Rb/f7GMbIUJxY
	 PqZkMr8pVQSVeYXfCzkKY2raSx5tmZyi7nbidImK3ZegXzzW/ZUj78PppRb5P0NCeS
	 9gKBGFl17wuJxu7TD+mTpGgBRsWLxebV/vWG59lJQzoiZ/ivQvZZhnwuP0x7JcNSsb
	 VLQl/CxTRx5excNymg4krErIR7vVZ+UFCYbLczpAsPTPSKTtKIFhIm711uN4DXBtcT
	 NZsqXpEoTtXUA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: consistently use bpf_rcu_lock_held() everywhere
Date: Fri, 10 Oct 2025 10:30:21 -0700
Message-ID: <20251010173021.3952776-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have many places which open-code what's now is bpf_rcu_lock_held()
macro, so replace all those places with a clean and short macro invocation.
For that, move bpf_rcu_lock_held() macro into include/linux/bpf.h.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h               |  3 +++
 include/linux/bpf_local_storage.h |  3 ---
 kernel/bpf/hashtab.c              | 21 +++++++--------------
 kernel/bpf/helpers.c              | 12 ++++--------
 4 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..0933b3ffe74e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2417,6 +2417,9 @@ extern const struct bpf_prog_ops bpf_offload_prog_ops;
 extern const struct bpf_verifier_ops tc_cls_act_analyzer_ops;
 extern const struct bpf_verifier_ops xdp_analyzer_ops;
 
+#define bpf_rcu_lock_held() \
+	(rcu_read_lock_held() || rcu_read_lock_trace_held() || rcu_read_lock_bh_held())
+
 struct bpf_prog *bpf_prog_get(u32 ufd);
 struct bpf_prog *bpf_prog_get_type_dev(u32 ufd, enum bpf_prog_type type,
 				       bool attach_drv);
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index ab7244d8108f..782f58feea35 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -18,9 +18,6 @@
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
-#define bpf_rcu_lock_held()                                                    \
-	(rcu_read_lock_held() || rcu_read_lock_trace_held() ||                 \
-	 rcu_read_lock_bh_held())
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c2fcd0cd51e5..2f07aaf4d732 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -669,8 +669,7 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l;
 	u32 hash, key_size;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1098,8 +1097,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1206,8 +1204,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1275,8 +1272,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1338,8 +1334,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		/* unknown flags */
 		return -EINVAL;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1416,8 +1411,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
@@ -1452,8 +1446,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	u32 hash, key_size;
 	int ret;
 
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 
 	key_size = map->key_size;
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..500e141f6d94 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -42,8 +42,7 @@
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -59,8 +58,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -77,8 +75,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
@@ -134,8 +131,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto = {
 
 BPF_CALL_3(bpf_map_lookup_percpu_elem, struct bpf_map *, map, void *, key, u32, cpu)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
-		     !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	return (unsigned long) map->ops->map_lookup_percpu_elem(map, key, cpu);
 }
 
-- 
2.47.3



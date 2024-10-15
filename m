Return-Path: <bpf+bounces-41904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EB299DAD7
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B845B21E37
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB80F3B1A1;
	Tue, 15 Oct 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pW9ItJ8u"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7D482EB
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953434; cv=none; b=ix30GPuhJcCIKTQk0F9Qhu/N/otfQlnv0HZB0w8dGLT6d0PBzx5IqgVrmg8b1Xx8SdNAVIUDryW+E2Ffp/2j3hsEIHxlbj9bpE5v07HEpfJ13YT0E8LgKa4TcLFdoLl10JUjRa46uuXErCqQoce1YeZGKRjPhn/xgKZiizCmnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953434; c=relaxed/simple;
	bh=erruaj1mwgbTrLLH3N+xpCxIX0K1w+jQvUSbfxZ5jLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsKyfutR4LF8Z58/mdJpu4swSxH/vPWK8BRDZEm/sxUHSw/NMkS7HthqDtOUi7PHC98D7oLNX1mneDHQygpTSxZaJovng0riu37Vg3l0aB1mxDxe+VimSHZFXY/wVdoLKColeP8RVE6EKCdKTM97AtkbQFQhSWBmR6eebe+rPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pW9ItJ8u; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfPAZv3g3p1YW+XfbWwyzXFoGBD+werzQrmzFBuZb9g=;
	b=pW9ItJ8u5OjDGJYpJqR7oMbCH2kO+qlpmv2voaiTvlJZXavBDhdT8sjz3AdGc+F9DP+6bk
	7iCnjLZu44z06/aGSpdt4YVCHTDhIq+Ys0bKsi6R80Vg3NpZp8o0h4HMyrTt3hL5ddzyty
	8X5FC/lyW3uLS+fqYtI+zh9JvnWaGvQ=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 05/12] bpf: Postpone bpf_obj_free_fields to the rcu callback
Date: Mon, 14 Oct 2024 17:49:55 -0700
Message-ID: <20241015005008.767267-6-martin.lau@linux.dev>
In-Reply-To: <20241015005008.767267-1-martin.lau@linux.dev>
References: <20241015005008.767267-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

A later patch will enable the uptr usage in the task_local_storage map.
This will require the unpin_user_page() to be done after the rcu
task trace gp for the cases that the uptr may still be used by
a bpf prog. The bpf_obj_free_fields() will be the one doing
unpin_user_page(), so this patch is to postpone calling
bpf_obj_free_fields() to the rcu callback.

The bpf_obj_free_fields() is only required to be done in
the rcu callback when bpf->bpf_ma==true and reuse_now==false.

bpf->bpf_ma==true case is because uptr will only be enabled
in task storage which has already been moved to bpf_mem_alloc.
The bpf->bpf_ma==false case can be supported in the future
also if there is a need.

reuse_now==false when the selem (aka storage) is deleted
by bpf prog (bpf_task_storage_delete) or by syscall delete_elem().
In both cases, bpf_obj_free_fields() needs to wait for
rcu gp.

A few words on reuse_now==true. reuse_now==true when the
storage's owner (i.e. the task_struct) is destructing or the map
itself is doing map_free(). In both cases, no bpf prog should
have a hold on the selem and its uptrs, so there is no need to
postpone bpf_obj_free_fields(). reuse_now==true should be the
common case for local storage usage where the storage exists
throughout the lifetime of its owner (task_struct).

The bpf_obj_free_fields() needs to use the map->record. Doing
bpf_obj_free_fields() in a rcu callback will require the
bpf_local_storage_map_free() to wait for rcu_barrier. An optimization
could be only waiting for rcu_barrier when the map has uptr in
its map_value. This will require either yet another rcu callback
function or adding a bool in the selem to flag if the SDATA(selem)->smap
is still valid. This patch chooses to keep it simple and wait for
rcu_barrier for maps that use bpf_mem_alloc.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 09a67dff2336..ca871be1c42d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -209,8 +209,12 @@ static void __bpf_selem_free(struct bpf_local_storage_elem *selem,
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	/* The bpf_local_storage_map_free will wait for rcu_barrier */
+	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
+	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 	bpf_mem_cache_raw_free(selem);
 }
 
@@ -226,16 +230,25 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    struct bpf_local_storage_map *smap,
 		    bool reuse_now)
 {
-	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-
 	if (!smap->bpf_ma) {
+		/* Only task storage has uptrs and task storage
+		 * has moved to bpf_mem_alloc. Meaning smap->bpf_ma == true
+		 * for task storage, so this bpf_obj_free_fields() won't unpin
+		 * any uptr.
+		 */
+		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 		__bpf_selem_free(selem, reuse_now);
 		return;
 	}
 
-	if (!reuse_now) {
-		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
-	} else {
+	if (reuse_now) {
+		/* reuse_now == true only happens when the storage owner
+		 * (e.g. task_struct) is being destructed or the map itself
+		 * is being destructed (ie map_free). In both cases,
+		 * no bpf prog can have a hold on the selem. It is
+		 * safe to unpin the uptrs and free the selem now.
+		 */
+		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 		/* Instead of using the vanilla call_rcu(),
 		 * bpf_mem_cache_free will be able to reuse selem
 		 * immediately.
@@ -243,7 +256,10 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		migrate_disable();
 		bpf_mem_cache_free(&smap->selem_ma, selem);
 		migrate_enable();
+		return;
 	}
+
+	call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
 }
 
 static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
@@ -908,6 +924,9 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	synchronize_rcu();
 
 	if (smap->bpf_ma) {
+		rcu_barrier_tasks_trace();
+		if (!rcu_trace_implies_rcu_gp())
+			rcu_barrier();
 		bpf_mem_alloc_destroy(&smap->selem_ma);
 		bpf_mem_alloc_destroy(&smap->storage_ma);
 	}
-- 
2.43.5



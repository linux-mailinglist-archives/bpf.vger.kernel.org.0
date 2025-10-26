Return-Path: <bpf+bounces-72252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E09C0ACD3
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD28218813A5
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED22E8B98;
	Sun, 26 Oct 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fx8yniAq"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3FF253B58;
	Sun, 26 Oct 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493259; cv=none; b=NQwrCrhx5M16MQJjs5LaPl0uVtTVSVh3kAdkd3KloBlpIuevkipV9W6wvLoU84kTkL8MBP9pSt9Q3h7ok99szmLuiazDUR3DM48Fw195Xe9c7sIZzjy0N+OeINgkO0dlVxS4hbACDC2k7uIPmY2In+k74/QM0yIo+ffll/7Itnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493259; c=relaxed/simple;
	bh=X7SifmAEQtPtGTwptFSvQQj76o4yROrHVpi4rvR1QjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5cehDZoiHLWxv9ZRRIPkzgsf/FoFX+HWcKLRSAT7nXef/6ZEQ5AUAKF7GdUw44zD0d+lfu9J5WizdU5FJIOT0siORSxAnnh+Ks8SXND5ZtHEftti23ZO2gMCLrqa+yskHNlGySQmNKRMtJvEZ/0RbJ4mZQrhUA3/0GvhLOwNp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fx8yniAq; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761493256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AAgrBQP2Y1ONLw22Ac4cfKW6J+sJUDTFnmuPayNPe4=;
	b=Fx8yniAqIBRNggOhKdexNiDLm5Ri8VYEqPP7gmcl263G3X8A2OJ6OdKQFsH0FPTL6PBIlV
	hnGWGeFqF6WbU38if0GeGCNZxj3U6aLgLYbnhkOLgTmUYuhZY/C/zDE7NyLV4I0if5qYYu
	MhtLdklmKAkti5SAwmgHHqv0ef+mCgc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf v3 3/4] bpf: Free special fields when update local storage maps
Date: Sun, 26 Oct 2025 23:39:59 +0800
Message-ID: <20251026154000.34151-4-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-1-leon.hwang@linux.dev>
References: <20251026154000.34151-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating local storage maps with BPF_F_LOCK on the fast path, the
special fields were not freed after being replaced. This could cause
memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
map gets freed.

Similarly, on the other path, the old sdata's special fields were never
freed regardless of whether BPF_F_LOCK was used, causing the same issue.

Fix this by calling 'bpf_obj_free_fields()' after
'copy_map_value_locked()' to properly release the old fields.

Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_local_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54da..8e3aea4e07c50 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
+			bpf_obj_free_fields(smap->map.record, old_sdata->data);
 			return old_sdata;
 		}
 	}
@@ -641,6 +642,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
 		copy_map_value_locked(&smap->map, old_sdata->data, value,
 				      false);
+		bpf_obj_free_fields(smap->map.record, old_sdata->data);
 		selem = SELEM(old_sdata);
 		goto unlock;
 	}
@@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	/* Third, remove old selem, SELEM(old_sdata) */
 	if (old_sdata) {
+		bpf_obj_free_fields(smap->map.record, old_sdata->data);
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
 						true, &old_selem_free_list);
-- 
2.51.0



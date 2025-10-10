Return-Path: <bpf+bounces-70753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B1DBCDFA7
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 18:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E0D4262BC
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B072FC861;
	Fri, 10 Oct 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjV2r1bs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978721C16A
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114777; cv=none; b=Tb05NumVaZFn3XCcPNgDglDZ3KiR9osZ7PQ1T3FRviX85zN6r5sXmovqjRhJIc1NJCIx0NcUjywNivMsIqfaCduvz/jkvxrNNcfCVY2gDt/RvVK2QPV5hu+PGqQfkF/oaZ6/cTqK0+cjO1vS2s2jOEN7fIWyGGwlBvIoPdEHBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114777; c=relaxed/simple;
	bh=oME/+hzuiaGqyosVLKIvCUeXrS71HCR4GBalR30FlZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyJq3H+0su4MaYcpxElny8oGepu4e/xwJgsD9O3u8OtStF6UcJ4WdM9SsdoOh0aY740h2jLFD9gzosJuueMQ8CwIDpATT5Unjjw3Uv/YC7lyBrl8sqQ1AyPa/Y0RjmOg/OTvD8tQiLzO5vCxue5gNBy9ExQG0DMWQXwGnv0CYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjV2r1bs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee12807d97so904682f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 09:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760114774; x=1760719574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUSIun5eMgxCw3M8hzuIgKKExgOlyAvKwzs2ROP/c6M=;
        b=HjV2r1bsR2SB0vv7/7LfW0Qe7yMHbbCqoMTaaakvyj3PBsY5iqs2AwkeBvogZ4fDXi
         Zd3YcEfDLBbt0cIDi/x9l1k3oRhLzGnISWam4fjc5xST/I0vVuXxG44URdzQgV8cRyR2
         woZGvqEWjIAJe1IKq6w6bxzml8/lJrbN/d1thXHgy4Ebgs3PHCKNDg2eosR/+XafIQho
         0SCctBqVGdHOTC159+DSzdUzqHa++kZVY90TiQFLNOMs5W41LG+VRJc+2T9PvmvKzsLY
         Fah6YrMegzJXdMPqYW8DPx9GpQqjjRdNnrc5mY6O0Q6w9sp2ci3N3lRAUIp8fWjHR/WY
         OyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760114774; x=1760719574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUSIun5eMgxCw3M8hzuIgKKExgOlyAvKwzs2ROP/c6M=;
        b=JtXx84vwLZKlxRNV0j0QwFW1FKXKmAoIri0S+07r66eGS/obr2nKrw13m8nosIzNQt
         Ogp4rVgakqIwLKEAFKu9SmNgVh0dOsrNL8IreL2idlKR2nEhI+BPBJRA4iuJjYlmRR6P
         1S6kY3dwnp0UoYFi31TjoJ9Z4xjOCmMrFVk/gBW7mAKTsYxVD0yKx4DKUCNCziDEmP/N
         kSnrl7jjL6si84BOyYn+a1I+30QzFD7BMVmFT+xNjMMVxz953AR9b8XyBlqVu4VxTdTv
         1LKCqUUuphFrNlL3ZUA4YRpKg7tvDjZqXrHcsWYS1OsLgh1LfZu/5fZagFU5sBd/pI/f
         f7CQ==
X-Gm-Message-State: AOJu0YzKqD/VZcgYImg6PTDLXec+jl4M48AJFBgNtZu7aCia755POc3s
	fe7qA7Q9TzKaIUfzCuHjYjPOHHoCHvDdRVXxOPnN0P1tf8adg+fcjs7CnOenDQ==
X-Gm-Gg: ASbGncsMqoCQKsPF1kak4KEpIwND3oanH2jxism3jZ5HcwWGW08u1ynTO/NM5Z1L/xf
	a1YPT0i48VAZ1YxWumDWExU4UMjLuXinMD0x8DmMvIBR5AP+P5h88Ie24yk62CsMhO4LRVre/Uo
	l/IkMlXbmgynB9A+I+99ILDVT1pb58x3wvoj6i8Xdoxn4zMX3Hd6JELQ0NHZLK1pUQObwAOqQId
	xmfhTQoDJKzmYJeuc+bkIaUh79Oh7hBRQ+gHoXFcLNbhSEwhiPi2v1YVBabQp7K3uSbgdxbDDJm
	7WanLC7KHoLgDNg3cRIzsRuMXGAINGyKwS7e3bFxgbNXA9RkpTVcVvKNSRezU8yIZyEhPka+uku
	ia1yiDU4DQ3uyA5lUv7JID9s8HRRV0Gac1f8nHrGxZsSR0b15EfOeVWs=
X-Google-Smtp-Source: AGHT+IHRJ36OpIy0FbcfopnNp51JyHsk/nCX4483R/U/G6o16Iei/b7SD2MkkDGSKmCu97tfPI7tuA==
X-Received: by 2002:a05:6000:4283:b0:3e8:b4cb:c3dc with SMTP id ffacd0b85a97d-4266e7ce955mr8760279f8f.3.1760114774255;
        Fri, 10 Oct 2025 09:46:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d49bsm5256518f8f.10.2025.10.10.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 09:46:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 3/3] bpf: extract internal structs helpers
Date: Fri, 10 Oct 2025 17:46:06 +0100
Message-ID: <20251010164606.147298-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
References: <20251010164606.147298-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

arraymap and hashtab duplicate the logic that checks for and frees
internal structs (timer, workqueue, task_work) based on
BTF record flags. Centralize this by introducing two helpers:

  * bpf_map_has_internal_structs(map)
    Returns true if the map value contains any of internal structs:
    BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK.

  * bpf_map_free_internal_structs(map, obj)
    Frees the internal structs for a single value object.

Convert arraymap and both the prealloc/malloc hashtab paths to use the
new generic functions. This keeps the functionality for when/how to free
these special fields in one place and makes it easier to add support for
new internal structs in the future without touching every map
implementation.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   |  7 +++++++
 kernel/bpf/arraymap.c | 19 ++++++-------------
 kernel/bpf/hashtab.c  | 36 +++++++++++++-----------------------
 kernel/bpf/helpers.c  | 10 ++++++++++
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..f87fb203aaae 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -663,6 +663,13 @@ int map_check_no_btf(const struct bpf_map *map,
 bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1);
 
+static inline bool bpf_map_has_internal_structs(struct bpf_map *map)
+{
+	return btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK);
+}
+
+void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
+
 extern const struct bpf_map_ops bpf_map_offload_ops;
 
 /* bpf_type_flag contains a set of flags that are applicable to the values of
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 80b1765a3159..0ba790c2d2e5 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -448,19 +448,12 @@ static void array_map_free_internal_structs(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
-	/* We don't reset or free fields other than timer and workqueue
-	 * on uref dropping to zero.
-	 */
-	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
-		for (i = 0; i < array->map.max_entries; i++) {
-			if (btf_record_has_field(map->record, BPF_TIMER))
-				bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
-			if (btf_record_has_field(map->record, BPF_WORKQUEUE))
-				bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
-			if (btf_record_has_field(map->record, BPF_TASK_WORK))
-				bpf_obj_free_task_work(map->record, array_map_elem_ptr(array, i));
-		}
-	}
+	/* We only free internal structs on uref dropping to zero */
+	if (!bpf_map_has_internal_structs(map))
+		return;
+
+	for (i = 0; i < array->map.max_entries; i++)
+		bpf_map_free_internal_structs(map, array_map_elem_ptr(array, i));
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c2fcd0cd51e5..e7a6ba04dc82 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -215,19 +215,6 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
 	return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
 }
 
-static void htab_free_internal_structs(struct bpf_htab *htab, struct htab_elem *elem)
-{
-	if (btf_record_has_field(htab->map.record, BPF_TIMER))
-		bpf_obj_free_timer(htab->map.record,
-				   htab_elem_value(elem, htab->map.key_size));
-	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
-		bpf_obj_free_workqueue(htab->map.record,
-				       htab_elem_value(elem, htab->map.key_size));
-	if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
-		bpf_obj_free_task_work(htab->map.record,
-				       htab_elem_value(elem, htab->map.key_size));
-}
-
 static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
@@ -240,7 +227,8 @@ static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		htab_free_internal_structs(htab, elem);
+		bpf_map_free_internal_structs(&htab->map,
+					      htab_elem_value(elem, htab->map.key_size));
 		cond_resched();
 	}
 }
@@ -1509,8 +1497,9 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
 		struct htab_elem *l;
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node) {
-			/* We only free timer on uref dropping to zero */
-			htab_free_internal_structs(htab, l);
+			/* We only free internal structs on uref dropping to zero */
+			bpf_map_free_internal_structs(&htab->map,
+						      htab_elem_value(l, htab->map.key_size));
 		}
 		cond_resched_rcu();
 	}
@@ -1521,13 +1510,14 @@ static void htab_map_free_internal_structs(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
-	/* We only free timer and workqueue on uref dropping to zero */
-	if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
-		if (!htab_is_prealloc(htab))
-			htab_free_malloced_internal_structs(htab);
-		else
-			htab_free_prealloced_internal_structs(htab);
-	}
+	/* We only free internal structs on uref dropping to zero */
+	if (!bpf_map_has_internal_structs(map))
+		return;
+
+	if (htab_is_prealloc(htab))
+		htab_free_prealloced_internal_structs(htab);
+	else
+		htab_free_malloced_internal_structs(htab);
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..22fbff8310f6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4431,3 +4431,13 @@ void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len)
 		return NULL;
 	return (void *)__bpf_dynptr_data(ptr, len);
 }
+
+void bpf_map_free_internal_structs(struct bpf_map *map, void *val)
+{
+	if (btf_record_has_field(map->record, BPF_TIMER))
+		bpf_obj_free_timer(map->record, val);
+	if (btf_record_has_field(map->record, BPF_WORKQUEUE))
+		bpf_obj_free_workqueue(map->record, val);
+	if (btf_record_has_field(map->record, BPF_TASK_WORK))
+		bpf_obj_free_task_work(map->record, val);
+}
-- 
2.51.0



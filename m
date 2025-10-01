Return-Path: <bpf+bounces-70081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091F3BB07C2
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51ADD3A349E
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AA2F360B;
	Wed,  1 Oct 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFlbpUEw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2F62F2618
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324991; cv=none; b=dPLj8OqU4h2o0YWyCqJ4RCAhexo1YZEVvjB6dqPMu1mFyICkZG1Ds386rUop9nG+Dj/cmuDRHDdbCUBysPa0U7ExP/BPfeHbUJPGCIbi7DBkb1pong9lon8czcM7xAqH1+0ZyMajKCmx1JYqwLYfvFG7iH9xN3+g6T8fZxJiVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324991; c=relaxed/simple;
	bh=r5EojoNfka/u/xaX9UiWZ2COAONEoniLPV/egzvY1Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c267Fd7m3EqY9StdMnSD8FaNX3U0sMlsmvkED9R7fAFieHnpIgXbrAb4ZeCEKMM0agpIHfQgyO7LgKI9bH4ba+VH0Vh3YVZEclNCslbbB7MoKAX4tpKgf6bYfvswTGkDvgxb+/Kj0WSL77cFO4lfu+9MQJ98GFwlFBMxm5jWW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFlbpUEw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso51474705e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759324987; x=1759929787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Dsz82sLkxqeUky84+et8WUoSNbaJ8xeuZJqMw45RHk=;
        b=UFlbpUEwp6sepdjsaLtRutSDhOAdFaVCx2jdH5AGze/jUFEVShYtqSnFOLDpEj/xwM
         EnxMSVgoYWY3qs2HnHEN4LI+g9X3MAajBD7TvwhepRjEiOcDhID9kRpVPryLxfW5bplK
         I+/R+1OLzpIxsJJ9vp0RY0x24u3MY3W7FhvNnEIUVIvKXMW4P12C+mh4kAlEIY2AZ6+d
         wfuM/aZUH3jBLGkFnfht6E9z6VJYQ7xiXjnfMv7WJc65uypvLCfHf8sTbkRErQFzD37f
         qaTqBmBsioegw9/xNjKXuuHfP1nfLkGfqhqExnz/Kg5PubSvYpHnZp4DR0QJ1NBwcn8i
         a+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759324987; x=1759929787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Dsz82sLkxqeUky84+et8WUoSNbaJ8xeuZJqMw45RHk=;
        b=HdJ7pHaJrnuEW4ft3QLtQVLUMn61WZlk4xbCVw96FH36YkGB6DJRTs6W6WlkkpXopV
         XZbl2E2B4oIax6ne1AvNdmjew8OXqHtLTGB4ZnBafUv6QInQc3mua11L/8avF1uX0rlU
         O+0IMSqI7tdGiHWwZbuu08KOuMdsrDq9a/kWexr3xnhCKMka8zCH/8ALFX6BojBayhY8
         AnDQZGG2RbwlfxU9lQ89h5PXKwbPhQr3b40e/j+2aFKG9+PS/O0lK652LvFpoFzlfcbu
         SKsfXlYh0UMJ+jgjDFv2ZHS+saw+tSfpGNF8gcFKBCgNvnmGYHbs++E3Huhm48lHLVPh
         /rUA==
X-Gm-Message-State: AOJu0YySUe9L0IH2VcUXe/M7Om8lRD2gAJMMKmu/8gnxEhkYo4J/Xl6n
	fAwsdeZ+e75YfSA8xlD53kYP97STeCti18zsNoIXsPxI0ygCI2ocourWYsZDag==
X-Gm-Gg: ASbGncu0qJTFcY6K9bWVETyr2KpIkgIBIgR/y/rTuGILdTszNxiB4C1yVLgTZ3dStF8
	cFHLQ1jy1o7w/qKOXl8uv2Jg2XTtY2NWGSml3k9qihRgGsviLOFi6uK/S5FELb+YYTUUSxCAE3h
	BlpvFE0VafbP6OWOonQg03o8MvfwS/I36YSWO+9f+q6ZVZO4aKXN23SqfWr5eM/eRc7xTKS5CAy
	cDt3eLxgAa3jQL9UK9OETijnOgI4EvXmeH47Q8uaw6+4rLgrWCnU0kkTTjgGN/AarsZ0kXqc06q
	9Rt2PBG9c4JF0L6atHI4lX8wWRcxbC5hzUhihWtYVKs7Dz1+HA20qsAPJjovgZZ9YtVtP4BXmfT
	8T+oYL4o9lCx+yY3tEopWPtk5X89c5w==
X-Google-Smtp-Source: AGHT+IF558Fd2zC1YMUjJYkIIayPLPfOmrtXELL3qopfwlymb7LF8AIuXwp1DawrjOX/JjF/hq4M9g==
X-Received: by 2002:a05:600c:34c6:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46e612e3fa4mr32536595e9.36.1759324987385;
        Wed, 01 Oct 2025 06:23:07 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:a74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm11428725e9.4.2025.10.01.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 06:23:07 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1 2/2] bpf: extract internal structs helpers
Date: Wed,  1 Oct 2025 14:22:52 +0100
Message-ID: <20251001132252.385398-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
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
---
 include/linux/bpf.h   |  4 ++++
 kernel/bpf/arraymap.c | 17 ++++++----------
 kernel/bpf/hashtab.c  | 45 ++++++++++++++++++++++++-------------------
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..3f7525f5c436 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -663,6 +663,10 @@ int map_check_no_btf(const struct bpf_map *map,
 bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1);
 
+bool bpf_map_has_internal_structs(struct bpf_map *map);
+
+void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
+
 extern const struct bpf_map_ops bpf_map_offload_ops;
 
 /* bpf_type_flag contains a set of flags that are applicable to the values of
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 80b1765a3159..bfde60402fd5 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -448,19 +448,14 @@ static void array_map_free_internal_structs(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
-	/* We don't reset or free fields other than timer and workqueue
+	/* We don't reset or free fields other than timer, workqueue and task_work
 	 * on uref dropping to zero.
 	 */
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
+	if (!bpf_map_has_internal_structs(map))
+		return;
+
+	for (i = 0; i < array->map.max_entries; i++)
+		bpf_map_free_internal_structs(map, array_map_elem_ptr(array, i));
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c2fcd0cd51e5..40936dec0402 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -215,17 +215,19 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
 	return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
 }
 
-static void htab_free_internal_structs(struct bpf_htab *htab, struct htab_elem *elem)
+bool bpf_map_has_internal_structs(struct bpf_map *map)
 {
-	if (btf_record_has_field(htab->map.record, BPF_TIMER))
-		bpf_obj_free_timer(htab->map.record,
-				   htab_elem_value(elem, htab->map.key_size));
-	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
-		bpf_obj_free_workqueue(htab->map.record,
-				       htab_elem_value(elem, htab->map.key_size));
-	if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
-		bpf_obj_free_task_work(htab->map.record,
-				       htab_elem_value(elem, htab->map.key_size));
+	return btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK);
+}
+
+void bpf_map_free_internal_structs(struct bpf_map *map, void *obj)
+{
+	if (btf_record_has_field(map->record, BPF_TIMER))
+		bpf_obj_free_timer(map->record, obj);
+	else if (btf_record_has_field(map->record, BPF_WORKQUEUE))
+		bpf_obj_free_workqueue(map->record, obj);
+	else if (btf_record_has_field(map->record, BPF_TASK_WORK))
+		bpf_obj_free_task_work(map->record, obj);
 }
 
 static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
@@ -240,7 +242,8 @@ static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		htab_free_internal_structs(htab, elem);
+		bpf_map_free_internal_structs(&htab->map,
+					      htab_elem_value(elem, htab->map.key_size));
 		cond_resched();
 	}
 }
@@ -1509,8 +1512,9 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
 		struct htab_elem *l;
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node) {
-			/* We only free timer on uref dropping to zero */
-			htab_free_internal_structs(htab, l);
+			/* We only free timer, wq, task_work on uref dropping to zero */
+			bpf_map_free_internal_structs(&htab->map,
+						      htab_elem_value(l, htab->map.key_size));
 		}
 		cond_resched_rcu();
 	}
@@ -1521,13 +1525,14 @@ static void htab_map_free_internal_structs(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
-	/* We only free timer and workqueue on uref dropping to zero */
-	if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
-		if (!htab_is_prealloc(htab))
-			htab_free_malloced_internal_structs(htab);
-		else
-			htab_free_prealloced_internal_structs(htab);
-	}
+	/* We only free timer, workqueue, task_work on uref dropping to zero */
+	if (!bpf_map_has_internal_structs(map))
+		return;
+
+	if (htab_is_prealloc(htab))
+		htab_free_prealloced_internal_structs(htab);
+	else
+		htab_free_malloced_internal_structs(htab);
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
-- 
2.51.0



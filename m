Return-Path: <bpf+bounces-70518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F011DBC2234
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 18:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31EA34F7444
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF142E88B7;
	Tue,  7 Oct 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msJqzst7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8D2D9EE6
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855179; cv=none; b=VRBmxfTKXC6AATYTQNwpC4C0bMjvYjBksWSoMQlgegRm+FGxsjvJI1jhNvZWlPamuhWA5H1kWWKrcDlqIrjHVP/sIOUDBdYtP/KPMGFoHGl+hiy8M+gv0+PWfxNT5dwonIQhBcOwcjoGhQpLa3ayYc/71IfAmjmJLGj78OrV0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855179; c=relaxed/simple;
	bh=oME/+hzuiaGqyosVLKIvCUeXrS71HCR4GBalR30FlZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdpbiPlbdqaN0ftr4jYt8lZlF4MIlNMOhx114alMn5G4meFYZe/JBaFPChRkhKNTZkrhmV6W6e9aQOc2h19Pq9J64nugRTk18JThsF9JXufJzmkDHI0R7fHupIF8ZsT5j81Ibagazxj859ywRr0yp4PAjBBQvvSt59uwVfo42MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msJqzst7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so60775665e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759855175; x=1760459975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUSIun5eMgxCw3M8hzuIgKKExgOlyAvKwzs2ROP/c6M=;
        b=msJqzst7hlmkV8vTfiTRmBK8Cgm++RjbhihONfJq2gnqMdRZO1ln79u+bJtabiHHBZ
         qShcGVJU199UwvKPcKnEfsR5oGkm8vqwtiXXqybmdIlL5+CFjTbAvHJpUHoAj7yvpAZ+
         QX5QOPSAxOWVyjwJB1h71z0x6LULjUW2KJDjt/8lNQUW49l8a59Jm3deiZVsXqDn7dcu
         NuAxE5KZC+7jTCnfoAg3d17AXl4UJU7G8QOy0iBpE+mQLLHxJdDy/RT7GOU0OYbrRJcS
         bfWTZep2j41SUuhteNbqLuE0ViSyJqVQ2+WgAvc2xXxHApBLatCl20S3d5nPgdEFMYJl
         L4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855175; x=1760459975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUSIun5eMgxCw3M8hzuIgKKExgOlyAvKwzs2ROP/c6M=;
        b=fRxb8V/tCpFaGuqEHVpgy62gc/+H6geuvuZjg5378dEXOfFu10vmAlmfaBiPjnESYv
         hgfQTKbU/cd63aYfr9OXblTWqA81ZyATjp2EGFw35TnrSvg8iPAvFQ+jwAcRNIwb2Ysm
         2X+BBITMGNqQcX6HsGtr1SK44uB31XymtAyDLrzQ/cxA++Utv0YAO1tOKsMLK61P+JND
         FAPJ18a697iatJ51HrBdrDp2O9qGERljItoCoRfH80QoFxSBNUrOClwtYqgdtlt8yX+e
         qwyIy7MhC1UXzaAaPOzkvYzxkrHUvbXWdoZWInzHzpQ3ZSrTF9Uzlg8ydC0VpEQPEhTb
         UTyA==
X-Gm-Message-State: AOJu0Yy1SVw0Dzho/2yiJhjYhA9bq/Qge7FAzgBY8TY0FzoYSlpyq1Iy
	ODXyWvW1yKHWYUWAGP+wfzuEkDRwd4GaBWWbxVTwt779ddauyD4ptelsEhqjrA==
X-Gm-Gg: ASbGncvz4H2S+Q8hy3Bzt7DXujlDvYdxVVVktzd2xVTdGOlxJRF8bbq6v2bUzsIvdTP
	C+4L8toLgLTQjNFjTczUxDIo/sKR30Zsc8+KV/oPPBfkfyz1rvB241lIR20EXU+dEsX6CMgKzV2
	sVdbRdCb579WE569wmggB9m2WjjrX1StlrWsn0y1CgL5396bcU+NKFFlpHYe17p65y8n0cHS0v3
	KI3sj2LB6xizZ5eWzWexjXG4f24KerlUgKoq5Olz7lMIc87teLIiyS2Ew0IJv94P7WDAJdxqhqj
	9HBuccgca/gJTo7RHD3BmrJzIAc2BrwgFXIHr7ejVYdeCl0HOEZQi2QLx4vjnmz+WRFhCHYv0S7
	Up1Jx1ErWvqlfgw/kKrY+S2RFgLY6tji3mhOi653KXkVEFQ==
X-Google-Smtp-Source: AGHT+IEwpVjrnXMjorbVXxpwL2cR31XA/pym0GFUT5Xt0BkDpTPK5bORg67xyRGFzT6EMmoTEgJ6ag==
X-Received: by 2002:a05:600c:3b11:b0:46e:4c7c:515c with SMTP id 5b1f17b1804b1-46fa9b182e2mr1762825e9.34.1759855175144;
        Tue, 07 Oct 2025 09:39:35 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf6c64sm1602435e9.4.2025.10.07.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:39:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 3/3] bpf: extract internal structs helpers
Date: Tue,  7 Oct 2025 17:39:30 +0100
Message-ID: <20251007163930.731312-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007163930.731312-1-mykyta.yatsenko5@gmail.com>
References: <20251007163930.731312-1-mykyta.yatsenko5@gmail.com>
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



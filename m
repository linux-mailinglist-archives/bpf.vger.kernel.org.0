Return-Path: <bpf+bounces-37148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E83951319
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 05:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3122833C9
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4559B38F97;
	Wed, 14 Aug 2024 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOmzIFxz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396353BBD7
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606221; cv=none; b=XzjqvdTQcG9qR+EETi5NrBPNKzL7wR97Oe+QP5UpK1JpYlNeSh7lycpAyjYad3n+ZOIbJZEEyc2DsSMQMQwgAWTkJN73bzzOT3ffJny6do+0UCnXHpHjdTJN0BgsA/iAlsl3kTUKBZseHHI5smlBNKnwKzyeqKcQGNjcwWhWWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606221; c=relaxed/simple;
	bh=3RXSElFPxPpuRa/jOxAfV9bbnHRH02MiIHG6wFsVRhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guWorKOOX7d2VBz6/+DWnapyBSXc8ELzmrq2zo/RR/RK7ClG46SdHwyBGeHVNYo7TSc2I3smAzYSSjJHZ9z+mPOkOOZK6n2vWDXa136b7AgqBoE1KXt+Id7XPEx08t5cITBeUnlat7Vco6pU61fhvIONYvHWmFMoWJxCwob6FdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOmzIFxz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-685cc5415e8so63178887b3.3
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723606219; x=1724211019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DLFRUkWcH/DHpAQ3G3GNX5Iu0FHC4ZM55orknhqP+w=;
        b=lOmzIFxzZMCAgmkpUtL58LlnkfYE79ZzgNYcXFqM2p16zSXa5T2qdTqP6S7+lprNWw
         4YyBTaBf8wdNRyc2z8hML5AaOoHh3M+oIhjIjh4LgA8r2Reyk+cbrr6V7AxcBxAiXqyG
         AwFhHgRhhJ7/jF+wwBPRQw7MH4g2i36qRA7L6RAFagQ8W1QT1+g0RSccH++2ZaWEQg71
         l0OoVxl4iUM0d9h2r4VN5WbcnhHWdeTtSJZI99fuRf4D9bS3Vu+NdjKazdu3WeGAqQgh
         p8jR588kt+IXa9zX8CPqpoeMPA/oJkJvBVlsK9z4c3EGDXbzb6oJX+wyS5f6Ug4zqorX
         7HmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723606219; x=1724211019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DLFRUkWcH/DHpAQ3G3GNX5Iu0FHC4ZM55orknhqP+w=;
        b=qkBzR/x+xCZQ92OiCc8qbcXPUXSVLEHer1PZXhRxBI8y1PXiocIN0hD5Dm/cTkRmzi
         2D/0nxpaJV5Y1tIWR7IaT4yNY85J3q+q6ufKUK+Y+XAA1RLlXHhltBx/55r+YsGCOR8C
         w+NgiJlE8wn8ef26PodxEi+oIID2Ati+KIyEmjHGPwapvoXnyGDP1pA/LRHUwi7G93dY
         JEb5naDWugfOU0l+3HFwkaqSNCv5bNJ3L0MwTXrYErlkgpoZyI92ZV8K3wT47OSvK2DM
         P4UkqO/u7KTsu5AaECxiytQc1SO4vhx+gAafxma6nlhK1lUw5y5JtmvreEJj8Ohs8k16
         4MPg==
X-Gm-Message-State: AOJu0YwDtzpYDLNXomHVFQ2zP8HPsH5yb+8Q+LR+RDyYWgUXETSYvlv/
	xmbmFAEfwhm9tMg4BUUs7LJtxV3dZt2YVtp9yi1UUKYDP7RPMYAphU1cNO8i
X-Google-Smtp-Source: AGHT+IG5naNP1r+B5pmwh8q0atzk3SeDT4CJa+pjtriXsKo7BcLLR4RqGiZBj5PIyLF+Kxzk33OPFA==
X-Received: by 2002:a05:690c:4501:b0:64a:7040:2d8a with SMTP id 00721157ae682-6ac96f89bfcmr16131747b3.23.1723606219067;
        Tue, 13 Aug 2024 20:30:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3c23:99cc:16a9:8b68])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b597sm15109587b3.117.2024.08.13.20.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:30:18 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 5/7] bpf: pin, translate, and unpin __uptr from syscalls.
Date: Tue, 13 Aug 2024 20:30:08 -0700
Message-Id: <20240814033010.2980635-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814033010.2980635-1-thinker.li@gmail.com>
References: <20240814033010.2980635-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a user program updates a map value, every uptr will be pinned and
translated to an address in the kernel. This process is initiated by
calling bpf_map_update_elem() from user programs.

Currently, uptr is only supported by task storage maps and can only be set
by user programs through syscalls.

When the value of an uptr is overwritten or destroyed, the memory pointed
to by the old value must be unpinned. This is ensured by calling
bpf_obj_uptrcpy() and copy_map_uptr_locked() when updating map value and by
bpf_obj_free_fields() when destroying map value.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 23 ++++++++++++++-----
 kernel/bpf/syscall.c           | 40 +++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index c938dea5ddbf..2fafad53b9d9 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -99,8 +99,11 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	}
 
 	if (selem) {
-		if (value)
+		if (value) {
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
+			if (smap->map.map_type == BPF_MAP_TYPE_TASK_STORAGE)
+				bpf_obj_uptrcpy(smap->map.record, SDATA(selem)->data, value);
+		}
 		/* No need to call check_and_init_map_value as memory is zero init */
 		return selem;
 	}
@@ -575,8 +578,13 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
-			copy_map_value_locked(&smap->map, old_sdata->data,
-					      value, false);
+			if (smap->map.map_type == BPF_MAP_TYPE_TASK_STORAGE &&
+			    btf_record_has_field(smap->map.record, BPF_UPTR))
+				copy_map_uptr_locked(&smap->map, old_sdata->data,
+						     value, false);
+			else
+				copy_map_value_locked(&smap->map, old_sdata->data,
+						      value, false);
 			return old_sdata;
 		}
 	}
@@ -607,8 +615,13 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
-		copy_map_value_locked(&smap->map, old_sdata->data, value,
-				      false);
+		if (smap->map.map_type == BPF_MAP_TYPE_TASK_STORAGE &&
+		    btf_record_has_field(smap->map.record, BPF_UPTR))
+			copy_map_uptr_locked(&smap->map, old_sdata->data,
+					     value, false);
+		else
+			copy_map_value_locked(&smap->map, old_sdata->data,
+					      value, false);
 		selem = SELEM(old_sdata);
 		goto unlock;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d504f5eb955a..1854aeb13ff7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -287,8 +287,8 @@ static void bpf_obj_unpin_uptrs(struct btf_record *rec, void *src)
 	bpf_obj_unpin_uptrs_cnt(rec, rec->cnt, src);
 }
 
-static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
-				void *key, void *value, __u64 flags)
+static int bpf_map_update_value_inner(struct bpf_map *map, struct file *map_file,
+				      void *key, void *value, __u64 flags)
 {
 	int err;
 
@@ -340,6 +340,29 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 	return err;
 }
 
+static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
+				void *key, void *value, __u64 flags)
+{
+	int err;
+
+	if (map->map_type == BPF_MAP_TYPE_TASK_STORAGE) {
+		/* Pin user memory can lead to context switch, so we need
+		 * to do it before potential RCU lock.
+		 */
+		err = bpf_obj_trans_pin_uptrs(map->record, value,
+					      bpf_map_value_size(map));
+		if (err)
+			return err;
+	}
+
+	err = bpf_map_update_value_inner(map, map_file, key, value, flags);
+
+	if (err && map->map_type == BPF_MAP_TYPE_TASK_STORAGE)
+		bpf_obj_unpin_uptrs(map->record, value);
+
+	return err;
+}
+
 static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 			      __u64 flags)
 {
@@ -846,6 +869,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 				field->kptr.dtor(xchgd_field);
 			}
 			break;
+		case BPF_UPTR:
+			if (*(void **)field_ptr)
+				bpf_obj_unpin_uptr(field, *(void **)field_ptr);
+			*(void **)field_ptr = NULL;
+			break;
 		case BPF_LIST_HEAD:
 			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
 				continue;
@@ -1231,7 +1259,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
-				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE,
+				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1287,6 +1315,12 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 					goto free_map_tab;
 				}
 				break;
+			case BPF_UPTR:
+				if (map->map_type != BPF_MAP_TYPE_TASK_STORAGE) {
+					ret = -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				break;
 			case BPF_LIST_HEAD:
 			case BPF_RB_ROOT:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
-- 
2.34.1



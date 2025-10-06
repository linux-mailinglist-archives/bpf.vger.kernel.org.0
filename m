Return-Path: <bpf+bounces-70441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E645BBF230
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 22:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019B23BF912
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BA2D5436;
	Mon,  6 Oct 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxRr2zm0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED761A0BF1
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780967; cv=none; b=Gc4CpNXmmVhjqdhscOMTtY0Vd74jfLrb6lLBHUvM2lpAHPD8BpC9YnWTjzY4pID3ffeRlov/jC9XhkLKI8LuXiBFWZi89KdO/sTd1GBKVUwRFCxrBBlMuNjRBN1M082ObhGmP+NCarrYeygbBA+L+n0oS4zlk7Htw+NvI7tGjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780967; c=relaxed/simple;
	bh=Fp0F11U8lTn2xf5XyO7nUY8xXEczpNkop9Rv9CJxZxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTTxWw95FPsvIjCrM6PiRw/On5qd9EgzPTzQ8If/apKIrNNL1KuJlB0IbjPiEXBTENd2itHjj0a81Qo5ipzNUFOnwxQmHXLMTjq704d5Z9AUchbWcdXLc+HH46QYTsSc7YjSLXLxFTIo2hMlRFW2ZGcwovVxBPa9JAYmKw080+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxRr2zm0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e542196c7so35869325e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759780964; x=1760385764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymO7ewSDIMiHZtNJklqPjvmWMZntz1R3SEIdzA/q2BM=;
        b=bxRr2zm0/xzc66boDi2RbArDQfp0vdlu76TdIjcTo4rE3UUwTEJ43Q7Qj/FS0HB5Uj
         i+QqqyG9LZauttB3Q6ihRfqaEo+5oSenqFrvyUhMN+Brnr6TUWpr0OCeX/kqbqGbJPDC
         kySg3nvgqRSumcqvr59qXndi3KNr7Lhf2rI3PFrAXcSfbNDc0I5sAd7BdhwDeSd761AC
         XJekqlSkauwWERq2v7slE7Sqg6qa3MpHDEY97g6V+/4gcEL9ob9KIXHu6PRhGrAUm5S3
         0xBqldKpQV0aQ04/uhw13t5Ys+kA1epKNnWt8xMbDj4vELEbaeQyoBUQNueWH31VU69W
         BU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759780964; x=1760385764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymO7ewSDIMiHZtNJklqPjvmWMZntz1R3SEIdzA/q2BM=;
        b=tRtKHwn9g/nYdOwmvZ3iG5zwi4AfwJpdah6SSIz5in7USmleiGwYZzFT0cPyf8PsfD
         7mvyNzhD9OeLevB2v7cxo7zHMwe+66/WoikIeZuO8sTmGc/eoiiUCQfQmXMOvz/xv6vO
         x391ZuZC+aDkyQIomW0trQuy7CWej2N0l1ELrE4GVdNwGtl42PwrdzRfo4GS7LJNqN7W
         dutes2MrcZ9qifqAuTxhmmEdLi75MtS9KYzfX6h38plEQxrmpqNYev4JdnBIXZgcR2ty
         9t1APmpvmzB/+jhQ1cR5/fk4mGRjRvjmhKC5qniZgnxuncsKRMvWM6D3IKa8VZa5qsMD
         1xzw==
X-Gm-Message-State: AOJu0YyJMYcOJnFpDtrNhpK3rUEbF4gcn4UC7JBbOW5Lx6oRHHfPYugE
	OoKomXo7kp254iP1huR5zbOPJ8uNDLAOg+XKGmoKATQtndupD7MKsm6iKDMdcQ==
X-Gm-Gg: ASbGncuCst4YEb+etIPcWuNTIfCwItTyL0p//N2w4umfddM9ESNNlVjyIrn0BQIzGn+
	xOEwW2/LeXxSryX+zT/kvHiGS6GkCold/zYnFTd+siyvYd5a6vhsaiIl4GVcFmQMyaUFElFEFVF
	jZ3IqJd9pCQQD+V/cG025cDJHywCCn+7zYXS8WLr9EEm/vz6DpEgQFMYFBRipi85s8OhoHdqPUB
	jHoSaXSsspXqrTISAkQSh1Kv/9N9WvMBjCWh9CCDCUNyLJ0QBHW+Lp4aH6nyn5m8y6AqvNT3F35
	OCt4+0JKjbv6TMnkI4Z/RasnQ4COnsIg58434Kp5qpSafEnfflHDXlB3RCQMVT+iv6gQvaafFw/
	f7DONCzs8VxqqDPTFO57bRi8sX1Pjz8pa+JOxgCXNL2bhql31TD7nWRHy
X-Google-Smtp-Source: AGHT+IHBJ6hk1frZF1l/QLCXZWOQiADXEgilYQPjMdfG85m3NkIDJYKZxhdXK1ASKDMNaOQK/SBtiw==
X-Received: by 2002:a5d:5f48:0:b0:3e7:617f:8458 with SMTP id ffacd0b85a97d-425829ee6dfmr521996f8f.24.1759780964093;
        Mon, 06 Oct 2025 13:02:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f01a0sm21991391f8f.48.2025.10.06.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:02:43 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 3/3] bpf: extract internal structs helpers
Date: Mon,  6 Oct 2025 21:02:37 +0100
Message-ID: <20251006200237.252611-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006200237.252611-1-mykyta.yatsenko5@gmail.com>
References: <20251006200237.252611-1-mykyta.yatsenko5@gmail.com>
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



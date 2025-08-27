Return-Path: <bpf+bounces-66685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B78B387EE
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4319D4645E3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0EE28C5DE;
	Wed, 27 Aug 2025 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r+mcc03m"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1D27781E
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313132; cv=none; b=Hz2Xw+9ZbbIRYq5gdUFBmuT0O2cqmUUpeogMR4LlLEiCWhQOfNI50ZmC36sk4roBIFlb4CAkblTTEuf4hw21cSAzx/W04u3dbRQ7al0lyMEOi5o5GeZ17IIZ4Dogto1LD+alv7sj1VgnsJmCdsWxuG6adoTtHgS3yO5xQ0Pl5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313132; c=relaxed/simple;
	bh=1tgvd72PzRkagpmWp5bctUF15rGnnE+qr1ewOakJYMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmIbhShvq45SPGDB86k8wamea0c+qGKhrHBORfZGw2uJIg1ZqoI55vIUPZFpBXPVSqdF+taNsxmS1QuUaCcaK+v3Dpio5zWnp2UnxGaNPNZuYQGR2LuHKANB5ewNWbhtBV16UWcCsvlPF55DVEvz44qPhVrW/lvHQA+Etf8vzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r+mcc03m; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756313128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAF95+rzARq5pHhSsX8NW7HoiYhnZeeKViDQmJ8VGLs=;
	b=r+mcc03m8NvJ7pcqEseM5aO9Tm9nee4aerw8hgis3834Y1TBngR+Jq08YxE6J5ds3XfcKQ
	srOET1fvGHeK34Fc4kPaaBDYWOlUaozLmMqo1MBozeJI7x/moIpAXXLEJUY/FTozU0L48R
	eWeIB326nbmaBqknn3CAbqGryvGZ6SA=
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
Subject: [PATCH bpf-next v4 1/7] bpf: Introduce internal bpf_map_check_op_flags helper function
Date: Thu, 28 Aug 2025 00:45:03 +0800
Message-ID: <20250827164509.7401-2-leon.hwang@linux.dev>
In-Reply-To: <20250827164509.7401-1-leon.hwang@linux.dev>
References: <20250827164509.7401-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It is to unify map flags checking for lookup_elem, update_elem,
lookup_batch and update_batch APIs.

Therefore, it will be convenient to check BPF_F_CPU and BPF_F_ALL_CPUS
flags in it for these APIs in next patch.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h  | 28 ++++++++++++++++++++++++++++
 kernel/bpf/syscall.c | 34 +++++++++++-----------------------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a89..512717d442c09 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3709,4 +3709,32 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 extra_flags_mask)
+{
+	if (extra_flags_mask && (flags & extra_flags_mask))
+		return -EINVAL;
+
+	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int bpf_map_check_update_flags(struct bpf_map *map, u64 flags)
+{
+	return bpf_map_check_op_flags(map, flags, 0);
+}
+
+#define BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK (~BPF_F_LOCK)
+
+static inline int bpf_map_check_lookup_flags(struct bpf_map *map, u64 flags)
+{
+	return bpf_map_check_op_flags(map, flags, BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK);
+}
+
+static inline int bpf_map_check_batch_flags(struct bpf_map *map, u64 flags)
+{
+	return bpf_map_check_op_flags(map, flags, BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK);
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c392..4e04b35944a2b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1669,9 +1669,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
 	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1679,9 +1676,9 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
 		return -EPERM;
 
-	if ((attr->flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
-		return -EINVAL;
+	err = bpf_map_check_lookup_flags(map, attr->flags);
+	if (err)
+		return err;
 
 	key = __bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key))
@@ -1744,11 +1741,9 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	if ((attr->flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		err = -EINVAL;
+	err = bpf_map_check_update_flags(map, attr->flags);
+	if (err)
 		goto err_put;
-	}
 
 	key = ___bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
@@ -1952,13 +1947,9 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	void *key, *value;
 	int err = 0;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		return -EINVAL;
-	}
+	err = bpf_map_check_batch_flags(map, attr->batch.elem_flags);
+	if (err)
+		return err;
 
 	value_size = bpf_map_value_size(map);
 
@@ -2015,12 +2006,9 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	u32 value_size, cp, max_count;
 	int err;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
-		return -EINVAL;
+	err = bpf_map_check_batch_flags(map, attr->batch.elem_flags);
+	if (err)
+		return err;
 
 	value_size = bpf_map_value_size(map);
 
-- 
2.50.1



Return-Path: <bpf+bounces-67715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D0B491CF
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3C044333A
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA02FF155;
	Mon,  8 Sep 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GEJW0vO0"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BE15E97
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342242; cv=none; b=qb3RSqrDObIJo1ONsu+Q0gZhZ0aYilhWfCZfxawHV5umQw2SN4FFPXd0guDRgk0CeI/TAX8vi2oxJEJpCTeduEua1w6EzMBps+wXC2ljM0hFwYLLeh9OMIlYjrMkJZmLHGNrZMc/hXRNqKlczVHDNxkqMuuNQ8mwuMx+pVSpa+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342242; c=relaxed/simple;
	bh=KSw2Oq8HNwwhZjcLAvI679lL9umQxB3l+ZH/ZVAYAjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvH7WPNvdtkC7TrRywA3t+Q3d0bGIwlqb7lAD4044cvkmB7CTLPFItDvyepeDwPmcblTKiCHU3BZMWzdfZ4lcdajLW9gASou+0S2r50WsMiDANswSHiNiaxSDEgd92J2GlyophKzhhEYttOCOiR8lyayLlWTbEuYN2+IVMo3Ckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GEJW0vO0; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757342238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6gynNllnI50yA224Ve3if0/cQgyeUjrCIIO1+X9CjE=;
	b=GEJW0vO0zC7iFpntdbVyRflHs9T0TENbRDe/ziiVi6+0K0//buHSk2ydyyXhmv01aHQxnP
	Pf+bLh1gktCmtg4f3NBRw/1QG6xLUvh4NtGTrVMaG+y1FTAFv0G6YR4U/54iuQazFE+ie2
	7b24sh+4rCQgWJvgHAu57dfGC8bjEnI=
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
Subject: [PATCH bpf-next v5 2/9] bpf: Introduce internal bpf_map_check_op_flags helper function
Date: Mon,  8 Sep 2025 22:36:37 +0800
Message-ID: <20250908143644.30993-3-leon.hwang@linux.dev>
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

It is to unify map flags checking for lookup_elem, update_elem,
lookup_batch and update_batch APIs.

Therefore, it will be convenient to check BPF_F_CPU and BPF_F_ALL_CPUS
flags in it for these APIs in next patch.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h  | 31 +++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c | 34 +++++++++++-----------------------
 2 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ce523a49dc20c..55c98c7d52510 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3735,4 +3735,35 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
+{
+	if (flags & ~allowed_flags)
+		return -EINVAL;
+
+	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int bpf_map_check_lookup_flags(struct bpf_map *map, u64 flags)
+{
+	return bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
+}
+
+static inline int bpf_map_check_update_flags(struct bpf_map *map, u64 flags)
+{
+	return bpf_map_check_op_flags(map, flags, ~0);
+}
+
+static inline int bpf_map_check_lookup_batch_flags(struct bpf_map *map, u64 flags)
+{
+	return bpf_map_check_lookup_flags(map, flags);
+}
+
+static inline int bpf_map_check_update_batch_flags(struct bpf_map *map, u64 flags)
+{
+	return bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c392..3a51836f18915 100644
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
+	err = bpf_map_check_update_batch_flags(map, attr->batch.elem_flags);
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
+	err = bpf_map_check_lookup_batch_flags(map, attr->batch.elem_flags);
+	if (err)
+		return err;
 
 	value_size = bpf_map_value_size(map);
 
-- 
2.50.1



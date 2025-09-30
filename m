Return-Path: <bpf+bounces-70047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B30BADED9
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC35A1C7896
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2E306D5F;
	Tue, 30 Sep 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GpaEKuLX"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B86173
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246803; cv=none; b=TPY/OBucthLnUTbwVpVtXeymUXcqNWdzNpIyyNnhqM9mgVz5a7r/+B5SEbwPxRSaiUXKaaSTTGz9QdjiWmOtizCELNk7YbyuUbJovoFBxvpaZMazxNSl65mUBQApv7Vw/xFpoTIpWRhENzg831DNUffhFEh8F/bj97bYlzMpmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246803; c=relaxed/simple;
	bh=uXPo/Aq11+0K8t6nyIbg7++nL/bfWdPxinetl02+Vjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcNaJ2gxiC0df7Ax0zPdurHLYyj4b7n2UjppnE81b9yJ6ieggyh4n2cRp6P6//k3ct+cXqQhxaoxbsjMO1YefKo8WVUVzina9AmLayK1RV+DpzlcHG/yoS3OvOlZHQSDxM9xrAd7Q4SzZKhZ7FncHUadj37OO0GfPyBhzo0k9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GpaEKuLX; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759246799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzUaRGCtE2XKxahVtD+RWWaJ9Ix051cWP2mKABHF7/U=;
	b=GpaEKuLXApqpHKimfNOEL5Ro4R7bih2W4k00v/rL0CQWIR3zmVEa5SsUemvXM7O1OeXY3L
	Q2Lr0U7hYAf3gFnqM0wDwOmrRHneim/RQF7XDBIR5W5mQiSQSRFQoGNLhbum7sG2O4VRin
	Ac78d8vi7+hEaQE9cjq3Y5YXc8BgkHY=
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
Subject: [PATCH bpf-next v9 1/7] bpf: Introduce internal bpf_map_check_op_flags helper function
Date: Tue, 30 Sep 2025 23:39:36 +0800
Message-ID: <20250930153942.41781-2-leon.hwang@linux.dev>
In-Reply-To: <20250930153942.41781-1-leon.hwang@linux.dev>
References: <20250930153942.41781-1-leon.hwang@linux.dev>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h  | 11 +++++++++++
 kernel/bpf/syscall.c | 34 +++++++++++-----------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c833461347..fb48db5bde472 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3768,4 +3768,15 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
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
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a48fa86f82a7f..6c252d3337928 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1709,9 +1709,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
 	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1719,9 +1716,9 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
 		return -EPERM;
 
-	if ((attr->flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
-		return -EINVAL;
+	err = bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK);
+	if (err)
+		return err;
 
 	key = __bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key))
@@ -1784,11 +1781,9 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	if ((attr->flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		err = -EINVAL;
+	err = bpf_map_check_op_flags(map, attr->flags, ~0);
+	if (err)
 		goto err_put;
-	}
 
 	key = ___bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
@@ -1992,13 +1987,9 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	void *key, *value;
 	int err = 0;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		return -EINVAL;
-	}
+	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK);
+	if (err)
+		return err;
 
 	value_size = bpf_map_value_size(map);
 
@@ -2055,12 +2046,9 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	u32 value_size, cp, max_count;
 	int err;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
-		return -EINVAL;
+	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK);
+	if (err)
+		return err;
 
 	value_size = bpf_map_value_size(map);
 
-- 
2.51.0



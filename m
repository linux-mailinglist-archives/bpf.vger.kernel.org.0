Return-Path: <bpf+bounces-67871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2561B4FF1B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BC47B6203
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8621922FD;
	Tue,  9 Sep 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AL3RktDo"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEECA219A8A
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427284; cv=none; b=aAN48nP6qoMF0UGP7POO08w3pHWa4tqOPBYG95cd6ql6P9cK/F5r1AU6Kg3rYQUmRPJNtnMwtPiZYfs+mPH353hCVPMvFYPJVTpt0VQSgaefIxzGlRDvS2dni7RhcwTfjN0DVvySMW9+ftQbxihdkYy2ZNrJEsc5JegnGnusmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427284; c=relaxed/simple;
	bh=Q1pCKsko6epMpfiMks+HNF5TiLuwVAL+YMR7I0aq/KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i54y/tnQaYvLXs+X0Y98S6Tox+F4pB/41/TXSJN+3Jgr9UU0wHp+mm1+CmS9o0JZ+kfJtVLjGYbxRaczai7wdihU0AT88iU2IeaVDnGj2NKbMP411enJJIUEUOP2gXJBc8Ij4O20erO/l+6lq0tl/9v66WFOhbd7ywHTCojX5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AL3RktDo; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757427280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=siCNQn0lZt5Cb3ptl+i9fYSVKIKznC8dZhWUsZP1DoM=;
	b=AL3RktDocp+X4uqo/OMoBbyc+ZOoZPFxyg+687xUMC6G0gOLI91QAwz1k/f1pvA4EdWxlh
	5Gko3Nvxb7lZkK/ibAr+XAUjMvBBFdboS5Wp2j0eZk802zE6nraG43p+L8pdHO10djL3zx
	yn2e23iP0hZG2H4HHQbnypaXQI026Ds=
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
Subject: [PATCH bpf-next v6 1/7] bpf: Introduce internal bpf_map_check_op_flags helper function
Date: Tue,  9 Sep 2025 22:14:15 +0800
Message-ID: <20250909141422.45450-2-leon.hwang@linux.dev>
In-Reply-To: <20250909141422.45450-1-leon.hwang@linux.dev>
References: <20250909141422.45450-1-leon.hwang@linux.dev>
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
 kernel/bpf/syscall.c | 45 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3f178a0f8eb12..f5448e00a2e8f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -131,6 +131,17 @@ bool bpf_map_write_active(const struct bpf_map *map)
 	return atomic64_read(&map->writecnt) != 0;
 }
 
+static int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
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
 static u32 bpf_map_value_size(const struct bpf_map *map)
 {
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
@@ -1669,9 +1680,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
 	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1679,9 +1687,9 @@ static int map_lookup_elem(union bpf_attr *attr)
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
@@ -1744,11 +1752,9 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
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
@@ -1952,13 +1958,9 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
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
 
@@ -2015,12 +2017,9 @@ int generic_map_lookup_batch(struct bpf_map *map,
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
2.50.1



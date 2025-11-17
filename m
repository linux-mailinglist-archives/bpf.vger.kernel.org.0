Return-Path: <bpf+bounces-74756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B48C651AC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 57E5624125
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC32C027A;
	Mon, 17 Nov 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YF+fda+H"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7728E5
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396469; cv=none; b=gCDBsE1nN5NowRE8U1RW4gMFlBJaAfSKVjIgICMopg/p84qmd7lbXMqywsl57b++QEmLsKRFcU4R5ym3buG5wpI+Q4n2gnhMEW6fIa7ub3s7IUKbkzT2taNwJA+ROruVLEWRrFpqwpONiAvNjVJoyusaK4/V9rfKYYiIKAj84kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396469; c=relaxed/simple;
	bh=2ztbj4mPd31QuTuK5bnL2U2Lf7/tSl1r1lIzhSigxbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuRFQ7O6+kbVpiV0gFkDhLceKpBPrUfhD03ciYIdCUL6Bn8zOfpLemD/1Zl1ycy1yuQxpW4QMfY/k1uwOcgmUrmxW61iqx4y/zdZKLvG9MgYG7v3fB1pcT8tUwz2YXgM3nxof/Q5bHn57+sRorqckqsqPFWXYXfq2qOSWzdVjOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YF+fda+H; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763396464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nKXwMeuhN2JRrI0RevMzdYsiWcZ8g/Ifit1TxNI7Jq4=;
	b=YF+fda+Hh6KQfp6KcVut0vdPkT8q2sqzdkzFnYMP3I5cYfse85bSpAe/pglGvGIHKVPBej
	yJc95E/Qmh4WLJTLrEZ5lMzLGzW86VmqlVLYz1dcq/Y1ACU4fX6jt8MXbwwLqraQ1JOeNT
	FchzaGUU4bu5HZ/2esACFe6D5VinSEw=
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
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	shuah@kernel.org,
	kerneljasonxing@gmail.com,
	chen.dylane@linux.dev,
	willemb@google.com,
	paul.chaignon@gmail.com,
	a.s.protopopov@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	tklauser@distanz.ch,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v10 1/8] bpf: Introduce internal bpf_map_check_op_flags helper function
Date: Tue, 18 Nov 2025 00:20:26 +0800
Message-ID: <20251117162033.6296-2-leon.hwang@linux.dev>
In-Reply-To: <20251117162033.6296-1-leon.hwang@linux.dev>
References: <20251117162033.6296-1-leon.hwang@linux.dev>
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
index 09d5dc541d1ce..a900bc022b1cc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3813,4 +3813,15 @@ bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
 }
 #endif
 
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
index a2a441185f810..f3dc6e2c82411 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1725,9 +1725,6 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
 	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1735,9 +1732,9 @@ static int map_lookup_elem(union bpf_attr *attr)
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
@@ -1800,11 +1797,9 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
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
@@ -2008,13 +2003,9 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
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
 
@@ -2071,12 +2062,9 @@ int generic_map_lookup_batch(struct bpf_map *map,
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
2.51.2



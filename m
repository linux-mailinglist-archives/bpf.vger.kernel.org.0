Return-Path: <bpf+bounces-68167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4CB53961
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C085A234D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD1D350D61;
	Thu, 11 Sep 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PT5sbS49"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAA32A802
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608434; cv=none; b=LCDdyxE+Vfbb0VG3chOVfHlEwfjp0wHyOTs3yARA3swmNzVR0EF3frIIuWxjaWFfhu0F04AK6x5QbinhZIvPUyi46idwFkL1cle+yLEMcex7CGCC3ks7YmUGCr9H2N1yGk6TA36KxRhAdS7VOZ4FlUsCESRQV7XaINj2I/iM5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608434; c=relaxed/simple;
	bh=+sZeXVFvw3Xa9QP3lqSsQkieyWOeTQRpCj4Cyif6ccE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfJNVB+GnwUKTIN557KwLC89SVdRJ0s5U5Rw0lZSF4OK41NfGeHbbeEvQow+BWl7rTuMPQRCftNsGHtbD8fvY1sA4CcXdzzYOx4d8Pggpbl+pq0E4jm/4VZvvRDWtchbXrnNQvhka3unzNkVd2I3isnSGYdRhyleLLL+EYjYXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PT5sbS49; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757608430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vsy394ILV6CzTeZCVoMKDxHE9QGBE9j8dhcwgb0f2pY=;
	b=PT5sbS49AXUUoJCIKG3gv6t3i1frnSvSqWIgim0ip1l3zqNaIKEddqE9OsrjUNmQJ0nnNt
	I1XAOh2gCV4crPYg8YaVmdttBbI0/izTNoi7zvHUkNoWtBurssZdOx27zeM8u0w1xk5YFj
	DVcdourhHMCh8z96mogc5kzaJFoolRM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	menglong8.dong@gmail.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 4/6] bpf: Add common attr support for map_create
Date: Fri, 12 Sep 2025 00:33:26 +0800
Message-ID: <20250911163328.93490-5-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-1-leon.hwang@linux.dev>
References: <20250911163328.93490-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, many 'BPF_MAP_CREATE' failures return '-EINVAL' without
providing any explanation to user space.

With the extended BPF syscall support introduced in the previous patch,
detailed error messages can now be reported. This allows users to
understand the specific reason for a failed map creation, rather than
just receiving a generic '-EINVAL'.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 82 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5e5cf0262a14e..2f5e6005671b5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1340,12 +1340,13 @@ static bool bpf_net_capable(void)
 
 #define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bool kernel)
+static int map_create(union bpf_attr *attr, bool kernel, struct bpf_common_attr *common_attrs)
 {
+	u32 map_type = attr->map_type, log_true_size;
+	struct bpf_verifier_log *log = NULL;
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
 	int numa_node = bpf_map_attr_numa_node(attr);
-	u32 map_type = attr->map_type;
 	struct bpf_map *map;
 	bool token_flag;
 	int f_flags;
@@ -1355,6 +1356,18 @@ static int map_create(union bpf_attr *attr, bool kernel)
 	if (err)
 		return -EINVAL;
 
+	if (common_attrs->log_buf) {
+		log = kvzalloc(sizeof(*log), GFP_KERNEL);
+		if (!log)
+			return -ENOMEM;
+		err = bpf_vlog_init(log, BPF_LOG_FIXED, u64_to_user_ptr(common_attrs->log_buf),
+				    common_attrs->log_size, NULL);
+		if (err) {
+			kvfree(log);
+			return err;
+		}
+	}
+
 	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
 	 * to avoid per-map type checks tripping on unknown flag
 	 */
@@ -1363,16 +1376,24 @@ static int map_create(union bpf_attr *attr, bool kernel)
 
 	if (attr->btf_vmlinux_value_type_id) {
 		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
-		    attr->btf_key_type_id || attr->btf_value_type_id)
-			return -EINVAL;
+		    attr->btf_key_type_id || attr->btf_value_type_id) {
+			bpf_log(log, "Invalid use of btf_vmlinux_value_type_id.\n");
+			err = -EINVAL;
+			goto put_token;
+		}
 	} else if (attr->btf_key_type_id && !attr->btf_value_type_id) {
-		return -EINVAL;
+		bpf_log(log, "Invalid btf_value_type_id.\n");
+		err = -EINVAL;
+		goto put_token;
 	}
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
-	    attr->map_extra != 0)
-		return -EINVAL;
+	    attr->map_extra != 0) {
+		bpf_log(log, "Invalid map_extra.\n");
+		err = -EINVAL;
+		goto put_token;
+	}
 
 	f_flags = bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
@@ -1380,17 +1401,26 @@ static int map_create(union bpf_attr *attr, bool kernel)
 
 	if (numa_node != NUMA_NO_NODE &&
 	    ((unsigned int)numa_node >= nr_node_ids ||
-	     !node_online(numa_node)))
-		return -EINVAL;
+	     !node_online(numa_node))) {
+		bpf_log(log, "Invalid or offline numa_node.\n");
+		err = -EINVAL;
+		goto put_token;
+	}
 
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
 	map_type = attr->map_type;
-	if (map_type >= ARRAY_SIZE(bpf_map_types))
-		return -EINVAL;
+	if (map_type >= ARRAY_SIZE(bpf_map_types)) {
+		bpf_log(log, "Invalid map_type.\n");
+		err = -EINVAL;
+		goto put_token;
+	}
 	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
 	ops = bpf_map_types[map_type];
-	if (!ops)
-		return -EINVAL;
+	if (!ops) {
+		bpf_log(log, "Invalid map_type.\n");
+		err = -EINVAL;
+		goto put_token;
+	}
 
 	if (ops->map_alloc_check) {
 		err = ops->map_alloc_check(attr);
@@ -1399,13 +1429,20 @@ static int map_create(union bpf_attr *attr, bool kernel)
 	}
 	if (attr->map_ifindex)
 		ops = &bpf_map_offload_ops;
-	if (!ops->map_mem_usage)
-		return -EINVAL;
+	if (!ops->map_mem_usage) {
+		bpf_log(log, "map_mem_usage is required.\n");
+		err = -EINVAL;
+		goto put_token;
+	}
 
 	if (token_flag) {
 		token = bpf_token_get_from_fd(attr->map_token_fd);
-		if (IS_ERR(token))
-			return PTR_ERR(token);
+		if (IS_ERR(token)) {
+			bpf_log(log, "Invalid map_token_fd.\n");
+			err = PTR_ERR(token);
+			token = NULL;
+			goto put_token;
+		}
 
 		/* if current token doesn't grant map creation permissions,
 		 * then we can't use this token, so ignore it and rely on
@@ -1487,8 +1524,10 @@ static int map_create(union bpf_attr *attr, bool kernel)
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
-	if (err < 0)
+	if (err < 0) {
+		bpf_log(log, "Invalid map_name.\n");
 		goto free_map;
+	}
 
 	preempt_disable();
 	map->cookie = gen_cookie_next(&bpf_map_cookie);
@@ -1511,6 +1550,7 @@ static int map_create(union bpf_attr *attr, bool kernel)
 
 		btf = btf_get_by_fd(attr->btf_fd);
 		if (IS_ERR(btf)) {
+			bpf_log(log, "Invalid btf_fd.\n");
 			err = PTR_ERR(btf);
 			goto free_map;
 		}
@@ -1565,6 +1605,10 @@ static int map_create(union bpf_attr *attr, bool kernel)
 	bpf_map_free(map);
 put_token:
 	bpf_token_put(token);
+	if (err && log)
+		(void) bpf_vlog_finalize(log, &log_true_size);
+	if (log)
+		kvfree(log);
 	return err;
 }
 
@@ -6020,7 +6064,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr.is_kernel);
+		err = map_create(&attr, uattr.is_kernel, &common_attrs);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
-- 
2.50.1



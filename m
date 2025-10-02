Return-Path: <bpf+bounces-70207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE31BB4660
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9698D3C32E1
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C52235046;
	Thu,  2 Oct 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fAJAaBhi"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3223506F
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420181; cv=none; b=ZzvvTKAUx3oQR3nKHoP9KcNvVYJR9/G07CTcpdqpYAU9J+RxLoq/5sW478J+9HsYgEn1n5Y5DPD8tvDJVqAMOVAB5W2Sc4pkRibfKjKv4P/a/0jr/hozqWy+9pteFGjho+Ydx8/Wad+xAAnetKftyf3bZjqTeP8tVMW5qHfl8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420181; c=relaxed/simple;
	bh=mLYgHXouRtwxSJicre8dxBF78uaiyTPGrUuFQthdrKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6hjV7Yh0w91+GFN2R2w3WVjgU6MD502+8Ej090c4NDcRduNvbycuuxGd8pw4aw5sdx9F3LwNJRx9EVP+6fZWN7yYyvVjEQ+KOWuFAzjLqyo8YBaFyHerl6IoApqycAPnbU46uAB4sr2edUbjEMrrudI5dDAMdUUdAwJFfdK3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fAJAaBhi; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759420176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3phdKXYKnJH3t7twP4a8RmVBYTIKkqpCCWjdQUuBfc=;
	b=fAJAaBhiE4B7dCtyw4qWJaEc0wj+CLdGoccYTUDzQQDZGwPcaZMrdvXaFPpH2G84GKA487
	3fIL0tk0bLUhJHBryDhFdR7KnVrZFnb2bwXlAOnOvDQBHWn75qONTnmEjbfOf2nohwp4wa
	cs645x9xcX7OsmwkCQbslKbSclaDKNQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v3 08/10] bpf: Add common attr support for map_create
Date: Thu,  2 Oct 2025 23:48:39 +0800
Message-ID: <20251002154841.99348-9-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-1-leon.hwang@linux.dev>
References: <20251002154841.99348-1-leon.hwang@linux.dev>
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

With the extended BPF syscall support, detailed error messages can now be
reported. This allows users to understand the specific reason for a
failed map creation, rather than just receiving a generic '-EINVAL'.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 96 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 49db250a2f5da..24f46cf451bec 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1355,23 +1355,72 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
+struct bpf_vlog_wrapper {
+	struct bpf_common_attr *attr;
+	struct bpf_verifier_log *log;
+};
+
+static void bpf_vlog_wrapper_destructor(struct bpf_vlog_wrapper *w)
+{
+	if (!w->log)
+		return;
+
+	(void) bpf_vlog_finalize(w->log, &w->attr->log_true_size);
+	kfree(w->log);
+}
+
+#define DEFINE_BPF_VLOG_WRAPPER(name, common_attrs)				\
+	struct bpf_vlog_wrapper name __cleanup(bpf_vlog_wrapper_destructor) = {	\
+		.attr = common_attrs,						\
+	}
+
+static int bpf_vlog_wrapper_init(struct bpf_vlog_wrapper *w)
+{
+	struct bpf_common_attr *attr = w->attr;
+	struct bpf_verifier_log *log;
+	int err;
+
+	if (!attr->log_buf)
+		return 0;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return -ENOMEM;
+
+	err = bpf_vlog_init(log, attr->log_level, u64_to_user_ptr(attr->log_buf), attr->log_size);
+	if (err) {
+		kfree(log);
+		return err;
+	}
+
+	w->log = log;
+	return 0;
+}
+
 #define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bpfptr_t uattr)
+static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *common_attrs)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
+	struct bpf_verifier_log *log;
 	struct bpf_map *map;
 	bool token_flag;
 	int f_flags;
 	int err;
+	DEFINE_BPF_VLOG_WRAPPER(log_wrapper, common_attrs);
 
 	err = CHECK_ATTR(BPF_MAP_CREATE);
 	if (err)
 		return -EINVAL;
 
+	err = bpf_vlog_wrapper_init(&log_wrapper);
+	if (err)
+		return err;
+	log = log_wrapper.log;
+
 	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
 	 * to avoid per-map type checks tripping on unknown flag
 	 */
@@ -1379,17 +1428,25 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 	attr->map_flags &= ~BPF_F_TOKEN_FD;
 
 	if (attr->btf_vmlinux_value_type_id) {
-		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
-		    attr->btf_key_type_id || attr->btf_value_type_id)
+		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
+			bpf_log(log, "btf_vmlinux_value_type_id can only be used with struct_ops maps.\n");
+			return -EINVAL;
+		}
+		if (attr->btf_key_type_id || attr->btf_value_type_id) {
+			bpf_log(log, "btf_vmlinux_value_type_id is mutually exclusive with btf_key_type_id and btf_value_type_id.\n");
 			return -EINVAL;
+		}
 	} else if (attr->btf_key_type_id && !attr->btf_value_type_id) {
+		bpf_log(log, "Invalid btf_value_type_id.\n");
 		return -EINVAL;
 	}
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
-	    attr->map_extra != 0)
+	    attr->map_extra != 0) {
+		bpf_log(log, "Invalid map_extra.\n");
 		return -EINVAL;
+	}
 
 	f_flags = bpf_get_file_flag(attr->map_flags);
 	if (f_flags < 0)
@@ -1397,13 +1454,17 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	if (numa_node != NUMA_NO_NODE &&
 	    ((unsigned int)numa_node >= nr_node_ids ||
-	     !node_online(numa_node)))
+	     !node_online(numa_node))) {
+		bpf_log(log, "Invalid numa_node.\n");
 		return -EINVAL;
+	}
 
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
 	map_type = attr->map_type;
-	if (map_type >= ARRAY_SIZE(bpf_map_types))
+	if (map_type >= ARRAY_SIZE(bpf_map_types)) {
+		bpf_log(log, "Invalid map_type.\n");
 		return -EINVAL;
+	}
 	map_type = array_index_nospec(map_type, ARRAY_SIZE(bpf_map_types));
 	ops = bpf_map_types[map_type];
 	if (WARN_ON_ONCE(!ops))
@@ -1421,8 +1482,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	if (token_flag) {
 		token = bpf_token_get_from_fd(attr->map_token_fd);
-		if (IS_ERR(token))
+		if (IS_ERR(token)) {
+			bpf_log(log, "Invalid map_token_fd.\n");
 			return PTR_ERR(token);
+		}
 
 		/* if current token doesn't grant map creation permissions,
 		 * then we can't use this token, so ignore it and rely on
@@ -1504,8 +1567,10 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 	err = bpf_obj_name_cpy(map->name, attr->map_name,
 			       sizeof(attr->map_name));
-	if (err < 0)
+	if (err < 0) {
+		bpf_log(log, "Invalid map_name.\n");
 		goto free_map;
+	}
 
 	preempt_disable();
 	map->cookie = gen_cookie_next(&bpf_map_cookie);
@@ -1528,6 +1593,7 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 
 		btf = btf_get_by_fd(attr->btf_fd);
 		if (IS_ERR(btf)) {
+			bpf_log(log, "Invalid btf_fd.\n");
 			err = PTR_ERR(btf);
 			goto free_map;
 		}
@@ -6132,6 +6198,15 @@ static int __copy_common_attr_log_true_size(bpfptr_t uattr, unsigned int size, u
 	return 0;
 }
 
+static int copy_common_attr_log_true_size(bpfptr_t uattr, unsigned int size,
+					  struct bpf_common_attr *attr)
+{
+	if (!attr->log_true_size)
+		return 0;
+
+	return __copy_common_attr_log_true_size(uattr, size, &attr->log_true_size);
+}
+
 static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size,
 					struct bpf_common_attr *common_attrs, bpfptr_t uattr_common,
 					unsigned int size_common, bool log_common_attrs)
@@ -6226,7 +6301,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr);
+		common_attrs.log_true_size = 0;
+		err = map_create(&attr, uattr, &common_attrs);
+		ret = copy_common_attr_log_true_size(uattr_common, size_common, &common_attrs);
+		err = ret ? ret : err;
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
-- 
2.51.0



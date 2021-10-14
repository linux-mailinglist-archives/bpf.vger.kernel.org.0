Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04942DBCB
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJNOhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhJNOhH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2FDC061753
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o20so20242340wro.3
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4RNy5X261Bw5GoABW5M9NY6YANhIzj/Cy+s6jzCcUuM=;
        b=Lh8WFkd5Qr04JhRJ2xgcp08DXKOojyU1zFV3833LfJFzlNTWXQz3WqcHmc8RnknqeA
         foYJ/9c5LaAJ2OOsxOwyvTmnGTLRs1wAF5bOup8dCmrVqaSzp5V1G5eK5iGFKtsz9Zxp
         9XYPFr5d3QaCj6oBbeR241o2dTrCHsOyApiaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RNy5X261Bw5GoABW5M9NY6YANhIzj/Cy+s6jzCcUuM=;
        b=dvtnrPi8Mne5O4QgY2WVr+a3c/URpzdBIwUsG9tE1riLduY921OFChJKh/uHkdqJ+i
         b6cTA4O2L7TOc0fC8mOzTMCm9rxgdx5v5VB7XyNZTIqPfnYztYTudsX+5WYgAhgycwFN
         lW7TkFYDED+9cnotUXSCIWmQjgNU+JVtlYXAWXY0WQAlts02LrE1oqNc8YiTtqd7EXkg
         1mly0BmYP/yb/CuEfIifbRZqcJZ83vGj3UUk5sfa5ZI+FCDSgxfPo70Po4msZ0mFebYK
         BG2jr4M72oqaMSTWdGYRtHZGtvdMb2gnLOvs/OWVJGOQ2tPF08zBHOPD5ZJ84On4+tih
         tisA==
X-Gm-Message-State: AOAM5337zDDWeKikMzRmnHANL2dBHFvbI1xFgSX8LqoYJ6Gvv98h96Uo
        PSW+GFIhBjrHrrvOrfXXzAuS2g==
X-Google-Smtp-Source: ABdhPJxpG8DQt7UnxysqCytE0BSEN00WGVdGildStUwiNecZIKjmOgESJz9qUEHtBDjviwM2j9VzDA==
X-Received: by 2002:adf:fd4d:: with SMTP id h13mr6918728wrs.391.1634222100590;
        Thu, 14 Oct 2021 07:35:00 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:35:00 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 6/9] bpf: struct bpf_map_create_attr
Date:   Thu, 14 Oct 2021 15:34:32 +0100
Message-Id: <20211014143436.54470-9-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/linux/bpf.h      |  4 +--
 include/uapi/linux/bpf.h | 62 ++++++++++++++++++++++++++--------------
 kernel/bpf/syscall.c     | 15 ++++------
 3 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d604c8251d88..80c6dfdbd9d9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1617,8 +1617,8 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 /* Return map's numa specified by userspace */
 static inline int bpf_map_attr_numa_node(const union bpf_attr *attr)
 {
-	return (attr->map_flags & BPF_F_NUMA_NODE) ?
-		attr->numa_node : NUMA_NO_NODE;
+	return (attr->map_create.map_flags & BPF_F_NUMA_NODE) ?
+		attr->map_create.numa_node : NUMA_NO_NODE;
 }
 
 struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type type);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c1b1ce0e26a6..f1c163778d7a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1271,29 +1271,31 @@ enum {
 	BPF_OBJ_NAME_LEN = 16U,
 };
 
+struct bpf_map_create_attr {
+	__u32	map_type;	/* one of enum bpf_map_type */
+	__u32	key_size;	/* size of key in bytes */
+	__u32	value_size;	/* size of value in bytes */
+	__u32	max_entries;	/* max number of entries in a map */
+	__u32	map_flags;	/* BPF_MAP_CREATE related
+				 * flags defined above.
+				 */
+	__u32	inner_map_fd;	/* fd pointing to the inner map */
+	__u32	numa_node;	/* numa node (effective only if
+				 * BPF_F_NUMA_NODE is set).
+				 */
+	char	map_name[BPF_OBJ_NAME_LEN];
+	__u32	map_ifindex;	/* ifindex of netdev to create on */
+	__u32	btf_fd;		/* fd pointing to a BTF type data */
+	__u32	btf_key_type_id;	/* BTF type_id of the key */
+	__u32	btf_value_type_id;	/* BTF type_id of the value */
+	__u32	btf_vmlinux_value_type_id;	/* BTF type_id of a kernel-
+						 * struct stored as the
+						 * map value
+						 */
+};
+
 union bpf_attr {
-	struct { /* anonymous struct used by BPF_MAP_CREATE command */
-		__u32	map_type;	/* one of enum bpf_map_type */
-		__u32	key_size;	/* size of key in bytes */
-		__u32	value_size;	/* size of value in bytes */
-		__u32	max_entries;	/* max number of entries in a map */
-		__u32	map_flags;	/* BPF_MAP_CREATE related
-					 * flags defined above.
-					 */
-		__u32	inner_map_fd;	/* fd pointing to the inner map */
-		__u32	numa_node;	/* numa node (effective only if
-					 * BPF_F_NUMA_NODE is set).
-					 */
-		char	map_name[BPF_OBJ_NAME_LEN];
-		__u32	map_ifindex;	/* ifindex of netdev to create on */
-		__u32	btf_fd;		/* fd pointing to a BTF type data */
-		__u32	btf_key_type_id;	/* BTF type_id of the key */
-		__u32	btf_value_type_id;	/* BTF type_id of the value */
-		__u32	btf_vmlinux_value_type_id;/* BTF type_id of a kernel-
-						   * struct stored as the
-						   * map value
-						   */
-	};
+	struct bpf_map_create_attr map_create;
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
 		__u32		map_fd;
@@ -1506,6 +1508,22 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	/* DEPRECATED: these are kept for compatibility purposes. */
+	struct { /* anonymous struct used by BPF_MAP_CREATE command */
+		__u32	map_type;
+		__u32	key_size;
+		__u32	value_size;
+		__u32	max_entries;
+		__u32	map_flags;
+		__u32	inner_map_fd;
+		__u32	numa_node;
+		char	map_name[BPF_OBJ_NAME_LEN];
+		__u32	map_ifindex;
+		__u32	btf_fd;
+		__u32	btf_key_type_id;
+		__u32	btf_value_type_id;
+		__u32	btf_vmlinux_value_type_id;
+	};
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14c2cfe6ef38..337fbd2f1874 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -103,7 +103,7 @@ const struct bpf_map_ops bpf_map_offload_ops = {
 	.map_check_btf = map_check_no_btf,
 };
 
-static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
+static struct bpf_map *find_and_alloc_map(struct bpf_map_create_attr *attr)
 {
 	const struct bpf_map_ops *ops;
 	u32 type = attr->map_type;
@@ -118,13 +118,13 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
 		return ERR_PTR(-EINVAL);
 
 	if (ops->map_alloc_check) {
-		err = ops->map_alloc_check(attr);
+		err = ops->map_alloc_check((union bpf_attr *)attr); /* XXX: Dodgy cast */
 		if (err)
 			return ERR_PTR(err);
 	}
 	if (attr->map_ifindex)
 		ops = &bpf_map_offload_ops;
-	map = ops->map_alloc(attr);
+	map = ops->map_alloc((union bpf_attr *)attr); /* XXX: Dodgy cast */
 	if (IS_ERR(map))
 		return map;
 	map->ops = ops;
@@ -814,18 +814,14 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD btf_vmlinux_value_type_id
 /* called via syscall */
-static int map_create(union bpf_attr *attr)
+static int map_create(struct bpf_map_create_attr *attr)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_map *map;
 	int f_flags;
 	int err;
 
-	err = CHECK_ATTR(BPF_MAP_CREATE);
-	if (err)
-		return -EINVAL;
 
 	if (attr->btf_vmlinux_value_type_id) {
 		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
@@ -4570,7 +4566,8 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr);
+		err = CHECK_ATTR_TAIL(&attr, map_create);
+		err = err ?: map_create(&attr.map_create);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
-- 
2.30.2


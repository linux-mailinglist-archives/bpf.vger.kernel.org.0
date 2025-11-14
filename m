Return-Path: <bpf+bounces-74579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5382EC5F7F2
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 007B635E4FE
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161A35BDD7;
	Fri, 14 Nov 2025 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R49n12or"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5930DEC9
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158667; cv=none; b=CKEg50PF5WDGxx4SBaFGSjjurMGiBEgsojU3Uuq3mFvCz5L6X0QB4CGijwq1WGYfRiUVYvLKJfzJM5auCek6h4Ok39W7oxYKpzoZup/HeFhetqFWvhyDtWM2IhUng5EPNlwIkWjLQeXuZw14U1hPIC1F2oC6qJNBJca9vYjl2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158667; c=relaxed/simple;
	bh=rvCLSR7XEBMl3b3zN2j1T74yJUpxSS4IoQf8cPoM4Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nouj4KINSl1JlYExwTZ0Jid6OzZeiO0sb0wRuG5nLeq9+Ww44pAEjG2B58tANPDmGYkKahLkcwGDyGotR383Uyb+8Mi/h3IqFqol1gha2A4XyHSNwltRUO3pF7ggbJpth6UGBgQPTaYKwTXTcZcAbqElypwv2nKPMshP6tORu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R49n12or; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2980d9b7df5so23917075ad.3
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158665; x=1763763465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpNZAM6qFlUNvnGhkeeYUDtxqLPX2DZzSz3QQ5QOIQQ=;
        b=R49n12ory9t4cnAl7yt+VvN/zwnjsJnFDdXOFZJb5LfWQ5lxzmCn03dNElCPJ0myXw
         acATbokjfMKtOh6wRi3ynQb/fmGE9Ta4z9zs32nfmr3zidWK63U9XkRVSo5xGLz9Ig1K
         87WmIKAb76smb5WYaaheXTJRuFakgJrjXb0Q1uoi6sB0L7DmqoPFoQMg/cZfJecMTzC5
         XWTLTMJ/yeyz1co3vmzIX2cmhcPXr734HShF6WGLQqU9AkEnt0ZEFAqAQJ1xpc9rbBSF
         5Xg3uwuClGpDGhEkI6E2U2j+NK5GIo3vQmmPDqhCroL6c1xzAM/61SqVwjdbXRmhf2mN
         y1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158665; x=1763763465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HpNZAM6qFlUNvnGhkeeYUDtxqLPX2DZzSz3QQ5QOIQQ=;
        b=CCevpc+oUNP2W+giGDyoshbO6ppkzs9mCSSSW+r9Qt59gD0o5LRphV6hsE8HLie/lV
         U/+Q0KfdTTi9EUDKSbpvEXbffXZp9w0kArhAkPTIbwRnx5dYj0RCH3ojCFIw4/R7F8VQ
         ZoRLvecsS3WAbTrkCpvQOwFpeNNvzJaD7FGBGF8zSRVcEyhsP9yRlNgmxBmVnbmRq42c
         pvuSJs+zr3HYO4o1ET9xvnascfOake34F2LT2erHc3A9rP6SnRjBMSmhauw7shR1UQss
         7k/lYCiAdcjI6wbXvJ8+f1uCvnXEtucx7FlYagnbqnHJ0MuV/t5f+cdS5N+7m/0IDro0
         I0EA==
X-Gm-Message-State: AOJu0Yw1dCHlc4pcyIrxBfmtWE6E+Hdn/wO81oegEck5AwowtPaMgmMq
	cEZB6bug3LafvGBnYDCqXWWPm1chaBu8fG+h8vK7A9tDJ4U59uOFsOfenRyBmA==
X-Gm-Gg: ASbGncsCAxzEJ63G8MkZmzhsE7FHeTp0efmPCxqVrA6fJOp2QkiD8JHzN06D4k+DeUb
	QYZl07eBOsXMfx7Og+SrmJ5tcTCPLJ8QOwZOMlb9qxQTdyDpw0G2lRXP/jPI9hCrvyoFeYjxdiv
	Gdv/sC6Lb4XmBA3nHg1YUlVqq3U9UOBiMCUAy5qVJbIZy5cjX0kJQxuD4KNBIv3elwsPYXBABnd
	RY92/r6mLtf3sLQuBHH1q9ryJCrmxGIK/fdzU8g6L/Ums24MmHOUD/POBpkV/GgqA7SDoTjgxPR
	OdtV/OZ4Rt7cDsCqaNOO/UvZrcFckvGkopB0zG5uiP2mvI9AfrWOi88LuFsx+nPhoQnJ3imdpo0
	jh2Dx4q/0vLHK7kMcICf9t1fn6fZnOqFYYtKkJEoojcpBMCzjsQLnPyFCXCcsYZjRwqeNOVlPxu
	KdpjXuesHGq7fd
X-Google-Smtp-Source: AGHT+IG2wrcfCdFqJ1x6ykEUu888nogYO9aY/RmDm5ctZS+oRvmVfmjEUXMZ0E6QliDPoBc+SIryVw==
X-Received: by 2002:a17:902:ef0b:b0:298:1288:e873 with SMTP id d9443c01a7336-2986a76b819mr58790655ad.56.1763158664980;
        Fri, 14 Nov 2025 14:17:44 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07950b0sm10301185a91.11.2025.11.14.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:17:44 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 2/6] bpf: Support associating BPF program with struct_ops
Date: Fri, 14 Nov 2025 14:17:37 -0800
Message-ID: <20251114221741.317631-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114221741.317631-1-ameryhung@gmail.com>
References: <20251114221741.317631-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF command BPF_PROG_ASSOC_STRUCT_OPS to allow associating
a BPF program with a struct_ops map. This command takes a file
descriptor of a struct_ops map and a BPF program and set
prog->aux->st_ops_assoc to the kdata of the struct_ops map.

The command does not accept a struct_ops program nor a non-struct_ops
map. Programs of a struct_ops map is automatically associated with the
map during map update. If a program is shared between two struct_ops
maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
associated struct_ops is ambiguous. The pointer, once poisoned, cannot
be reset since we have lost track of associated struct_ops. For other
program types, the associated struct_ops map, once set, cannot be
changed later. This restriction may be lifted in the future if there is
a use case.

A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
the associated struct_ops pointer. The returned pointer, if not NULL, is
guaranteed to be valid and point to a fully updated struct_ops struct.
For struct_ops program reused in multiple struct_ops map, the return
will be NULL.

prog->aux->st_ops_assoc is protected by bumping the refcount for
non-struct_ops programs and RCU for struct_ops programs. Since it would
be inefficient to track programs associated with a struct_ops map, every
non-struct_ops program will bump the refcount of the map to make sure
st_ops_assoc stays valid. For a struct_ops program, it is protected by
RCU as map_free will wait for an RCU grace period before disassociating
the program with the map. The helper must be called in BPF program
context or RCU read-side critical section.

struct_ops implementers should note that the struct_ops returned may or
may not be attached. The struct_ops implementer will be responsible for
tracking and checking the state of the associated struct_ops map if the
use case requires an attached struct_ops.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h            | 16 ++++++
 include/uapi/linux/bpf.h       | 17 +++++++
 kernel/bpf/bpf_struct_ops.c    | 92 ++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c              |  3 ++
 kernel/bpf/syscall.c           | 46 +++++++++++++++++
 tools/include/uapi/linux/bpf.h | 17 +++++++
 6 files changed, 191 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a47d67db3be5..6c1c64400a86 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1726,6 +1726,8 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	struct mutex st_ops_assoc_mutex;
+	struct bpf_map __rcu *st_ops_assoc;
 };
 
 struct bpf_prog {
@@ -2026,6 +2028,9 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
 u32 bpf_struct_ops_id(const void *kdata);
 
 #ifdef CONFIG_NET
@@ -2073,6 +2078,17 @@ static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
 {
 	return -EOPNOTSUPP;
 }
+static inline int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
+{
+	return -EOPNOTSUPP;
+}
+static inline void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
+{
+}
+static inline void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+{
+	return NULL;
+}
 static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1d73f165394d..a2d8cfac8555 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -918,6 +918,16 @@ union bpf_iter_link_info {
  *		Number of bytes read from the stream on success, or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_PROG_ASSOC_STRUCT_OPS
+ * 	Description
+ * 		Associate a BPF program with a struct_ops map. The struct_ops
+ * 		map is identified by *map_fd* and the BPF program is
+ * 		identified by *prog_fd*.
+ *
+ * 	Return
+ * 		0 on success or -1 if an error occurred (in which case,
+ * 		*errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -974,6 +984,7 @@ enum bpf_cmd {
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
+	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
 };
 
@@ -1893,6 +1904,12 @@ union bpf_attr {
 		__u32		prog_fd;
 	} prog_stream_read;
 
+	struct {
+		__u32		map_fd;
+		__u32		prog_fd;
+		__u32		flags;
+	} prog_assoc_struct_ops;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index a41e6730edcf..626aa91979b2 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -533,6 +533,17 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
+static void bpf_struct_ops_map_dissoc_progs(struct bpf_struct_ops_map *st_map)
+{
+	u32 i;
+
+	for (i = 0; i < st_map->funcs_cnt; i++) {
+		if (!st_map->links[i])
+			break;
+		bpf_prog_disassoc_struct_ops(st_map->links[i]->prog);
+	}
+}
+
 static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_map)
 {
 	int i;
@@ -811,6 +822,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type);
 		*plink++ = &link->link;
 
+		err = bpf_prog_assoc_struct_ops(prog, &st_map->map);
+		if (err) {
+			bpf_prog_put(prog);
+			goto reset_unlock;
+		}
+
 		ksym = kzalloc(sizeof(*ksym), GFP_USER);
 		if (!ksym) {
 			err = -ENOMEM;
@@ -980,6 +997,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	if (btf_is_module(st_map->btf))
 		module_put(st_map->st_ops_desc->st_ops->owner);
 
+	bpf_struct_ops_map_dissoc_progs(st_map);
+
 	bpf_struct_ops_map_del_ksyms(st_map);
 
 	/* The struct_ops's function may switch to another struct_ops.
@@ -1394,6 +1413,79 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
+{
+	struct bpf_map *st_ops_assoc;
+
+	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+
+	st_ops_assoc = rcu_dereference_protected(prog->aux->st_ops_assoc,
+						 lockdep_is_held(&prog->aux->st_ops_assoc_mutex));
+	if (st_ops_assoc && st_ops_assoc == map)
+		return 0;
+
+	if (st_ops_assoc) {
+		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+			return -EBUSY;
+
+		rcu_assign_pointer(prog->aux->st_ops_assoc, BPF_PTR_POISON);
+	} else {
+		/*
+		 * struct_ops map does not track associated non-struct_ops programs.
+		 * Bump the refcount to make sure st_ops_assoc is always valid.
+		 */
+		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+			bpf_map_inc(map);
+
+		rcu_assign_pointer(prog->aux->st_ops_assoc, map);
+	}
+
+	return 0;
+}
+
+void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
+{
+	struct bpf_map *st_ops_assoc;
+
+	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+
+	st_ops_assoc = rcu_dereference_protected(prog->aux->st_ops_assoc,
+						 lockdep_is_held(&prog->aux->st_ops_assoc_mutex));
+	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
+		return;
+
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		bpf_map_put(st_ops_assoc);
+
+	RCU_INIT_POINTER(prog->aux->st_ops_assoc, NULL);
+}
+
+/*
+ * Get a reference to the struct_ops struct (i.e., kdata) associated with a
+ * program. Should only be called in BPF program context (e.g., in a kfunc).
+ *
+ * If the returned pointer is not NULL, it must points to a valid and
+ * initialized struct_ops. The struct_ops may or may not be attached.
+ * Kernel struct_ops implementers are responsible for tracking and checking
+ * the state of the struct_ops if the use case requires an attached struct_ops.
+ */
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+{
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *st_ops_assoc;
+
+	st_ops_assoc = rcu_dereference_check(aux->st_ops_assoc, bpf_rcu_lock_held());
+	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
+		return NULL;
+
+	st_map = (struct bpf_struct_ops_map *)st_ops_assoc;
+	if (smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_INIT)
+		return NULL;
+
+	return &st_map->kvalue.data;
+}
+EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);
+
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..441bfeece377 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -136,6 +136,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 	mutex_init(&fp->aux->used_maps_mutex);
 	mutex_init(&fp->aux->ext_mutex);
 	mutex_init(&fp->aux->dst_mutex);
+	mutex_init(&fp->aux->st_ops_assoc_mutex);
 
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_prog_stream_init(fp);
@@ -286,6 +287,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 	if (fp->aux) {
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
+		mutex_destroy(&fp->aux->st_ops_assoc_mutex);
 		kfree(fp->aux->poke_tab);
 		kfree(fp->aux);
 	}
@@ -2875,6 +2877,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 #endif
 	bpf_free_used_maps(aux);
 	bpf_free_used_btfs(aux);
+	bpf_prog_disassoc_struct_ops(aux->prog);
 	if (bpf_prog_is_dev_bound(aux))
 		bpf_prog_dev_bound_destroy(aux->prog);
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..dddbe89e9718 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6107,6 +6107,49 @@ static int prog_stream_read(union bpf_attr *attr)
 	return ret;
 }
 
+#define BPF_PROG_ASSOC_STRUCT_OPS_LAST_FIELD prog_assoc_struct_ops.prog_fd
+
+static int prog_assoc_struct_ops(union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	int ret;
+
+	if (CHECK_ATTR(BPF_PROG_ASSOC_STRUCT_OPS))
+		return -EINVAL;
+
+	if (attr->prog_assoc_struct_ops.flags)
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->prog_assoc_struct_ops.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+		ret = -EINVAL;
+		goto put_prog;
+	}
+
+	map = bpf_map_get(attr->prog_assoc_struct_ops.map_fd);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		goto put_prog;
+	}
+
+	if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
+		ret = -EINVAL;
+		goto put_map;
+	}
+
+	ret = bpf_prog_assoc_struct_ops(prog, map);
+
+put_map:
+	bpf_map_put(map);
+put_prog:
+	bpf_prog_put(prog);
+	return ret;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -6246,6 +6289,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_PROG_STREAM_READ_BY_FD:
 		err = prog_stream_read(&attr);
 		break;
+	case BPF_PROG_ASSOC_STRUCT_OPS:
+		err = prog_assoc_struct_ops(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1d73f165394d..a2d8cfac8555 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -918,6 +918,16 @@ union bpf_iter_link_info {
  *		Number of bytes read from the stream on success, or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_PROG_ASSOC_STRUCT_OPS
+ * 	Description
+ * 		Associate a BPF program with a struct_ops map. The struct_ops
+ * 		map is identified by *map_fd* and the BPF program is
+ * 		identified by *prog_fd*.
+ *
+ * 	Return
+ * 		0 on success or -1 if an error occurred (in which case,
+ * 		*errno* is set appropriately).
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -974,6 +984,7 @@ enum bpf_cmd {
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
 	BPF_PROG_STREAM_READ_BY_FD,
+	BPF_PROG_ASSOC_STRUCT_OPS,
 	__MAX_BPF_CMD,
 };
 
@@ -1893,6 +1904,12 @@ union bpf_attr {
 		__u32		prog_fd;
 	} prog_stream_read;
 
+	struct {
+		__u32		map_fd;
+		__u32		prog_fd;
+		__u32		flags;
+	} prog_assoc_struct_ops;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.47.3



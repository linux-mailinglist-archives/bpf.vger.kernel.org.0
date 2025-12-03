Return-Path: <bpf+bounces-75998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18700CA1F85
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 00:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859D3302049B
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 23:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772B12F12BE;
	Wed,  3 Dec 2025 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh33pL4P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A12EC0B5
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805075; cv=none; b=jSDEkMNSRJUJI+72nA/Z0nqQURKZjJUOtlFh2UKbW5NgXzIY7pOJWJcMhbE822xeeQjLsXwG8tcWU10t7L/wCWvIDYPUfWT94QSlUBjdsCQL3uZpvXTbw1EPIR5/niFhgNVMUGG0AeJgEiEMODYrY9MxSLaqn1belmfPryQ5oSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805075; c=relaxed/simple;
	bh=hxcN2r7zYrT2G9RoW7KYiFYC8yIrIIlBiBj6Q2dEe+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB5x2joBFELUHs1h86mirlpONTjA1v3kmMMt+KQGE3U/ErwRxqpy1Y9trWmaigjBhZOsx72CeWs+fIrWv0VOeqLqZiOYdGKnV0hgAkufHzczE3sc0L3sCDXAQmUXLsZdIa7vz/F21+o4k7IlRlrY3XvUqzIhlS0ACNaB8xDRQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fh33pL4P; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so247346a91.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764805072; x=1765409872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArAkS9Ao1ty6jCDF1m8pcjBkLYA2SQZxRjOmGtRR4bs=;
        b=Fh33pL4Pyk11zOdqigW9xSp/cZwsf+geCPbEAnIiqXyHIrkQfHX0G7IkQLC3aem1o+
         y6gjGaLaXOBad1lr6o5taOv+R/JwLc2wlWCDYfkrrVh+UqzTRNdPE1kspdDaP+LCq2JM
         BhcBsNDpkOb833Icr/XHGdh1lPC2KFRCLttuEKiRtFwqFVnVTCtt7FJ4TqXj1WPtPGwN
         5dz20KibiruvP0LGWfa/PjOK1a2kxQ/YvPWQMVjAGGbOIbYJaOXP6eTFikL5uzHVF6cI
         ieUrAWNOyw9CuDwm2W1NPImEQepwiPI4LRdFH1NfiBbn4SCnSK9DfiA836x6qA30RWQK
         dFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764805072; x=1765409872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArAkS9Ao1ty6jCDF1m8pcjBkLYA2SQZxRjOmGtRR4bs=;
        b=iKpjt0k8auAQXoNjWvh6mtHVwzX42ZEfanazkYMes+1d5LvvE5mZmgCKckrpMxyeVt
         yRLR3ub86QowcUtKFsQ7RnTbzJEcdclJ7kPlLU2WHikm3ZBR5loDRJyfvGdvkWEXazBo
         g56x0lLqMmNEF/iYpWZ2RPNMULHAPrlGDPNTufUIsD3VUP2uiWtCY463uK2sFJB622KT
         LybccawlS3Q3aX+qTtsvBcNROsxQyDcmWZzSleJcc1+PCZ3KD0iBxVUpFj6RAMyKXhjX
         74+rde/KIYKnzykEBFB7sLOyeRwVHHEfAbDmLnvo8k3dN0F3LpRJxjO3DPwfeh13fknE
         u3sA==
X-Gm-Message-State: AOJu0Yy1+7HiHsoM4WRaymJhjtA3TrL5c1iHXJoW44kSlxa5lHjpb08q
	MKFETVw8rRSVThPqeS9c4qttlLZSMKYPPtuH5qa2BGkdnyO6WNGV2/q3VaxS3A==
X-Gm-Gg: ASbGncuMJ2laE0/BubTCHYy7xdKWcG6BPs0xlbqDstFDXwIvqGXZGWLTR4he0rDQfeD
	eEX4RMahFxK/vISCqs4mdM9uK3zFUgS1fKBgJOMq0Tddh3dWj693VcSeZxO0wmCVU92X3/hUP6O
	/wteDOJiMCPPVFKTNztf8yPhWBDEErS5LbjTwFwp8+6ETc8YdxvIZGGd0hX5gGLLsPLus5w6gfw
	PwPr32mjnAb6VPYXwKGzR5nLZ6S6HLuKZB2sru5LUzrrow6Mln6v6cS0kUp3K6aAmalhhKtQjpG
	HkTFgj0vEvidV1KCG70USbMT1WHGFOluAdvcU4fETdgi7ccGqPvbdeLZENMhX44hksQRpXwky02
	QCs1r/s+333dw3fQv4mZA8s/mtNAOeq1UhprmEGi069yGTPCDU8xsWsE9nQBfFwg8jgqhm9WeFA
	7mvgiP4wHybVFvw446uXATOXvS
X-Google-Smtp-Source: AGHT+IGlEzKqgNNK27iHgsrQaTUXJ45eALUS9V8bJqt3MFBx4PPZmEuZkSWn/1IFWqG6T7/LzEbj2g==
X-Received: by 2002:a17:90b:380c:b0:340:f05a:3ecb with SMTP id 98e67ed59e1d1-349126f072bmr3999294a91.28.1764805072383;
        Wed, 03 Dec 2025 15:37:52 -0800 (PST)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494ea63e87sm59332a91.12.2025.12.03.15.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 15:37:51 -0800 (PST)
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
Subject: [PATCH bpf-next v8 2/6] bpf: Support associating BPF program with struct_ops
Date: Wed,  3 Dec 2025 15:37:44 -0800
Message-ID: <20251203233748.668365-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203233748.668365-1-ameryhung@gmail.com>
References: <20251203233748.668365-1-ameryhung@gmail.com>
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

struct_ops implementers should note that the struct_ops returned may not
be initialized nor attached yet. The struct_ops implementer will be
responsible for tracking and checking the state of the associated
struct_ops map if the use case expects an initialized or attached
struct_ops.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h            | 16 +++++++
 include/uapi/linux/bpf.h       | 17 +++++++
 kernel/bpf/bpf_struct_ops.c    | 88 ++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c              |  3 ++
 kernel/bpf/syscall.c           | 46 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 17 +++++++
 6 files changed, 187 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6498be4c44f8..28d8d6b7bb1e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1739,6 +1739,8 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	struct mutex st_ops_assoc_mutex;
+	struct bpf_map __rcu *st_ops_assoc;
 };
 
 struct bpf_prog {
@@ -2041,6 +2043,9 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
 u32 bpf_struct_ops_id(const void *kdata);
 
 #ifdef CONFIG_NET
@@ -2088,6 +2093,17 @@ static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
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
index f5713f59ac10..bf4e00b8e272 100644
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
 
@@ -1894,6 +1905,12 @@ union bpf_attr {
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
index a41e6730edcf..0e4cf643b76f 100644
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
@@ -801,6 +812,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
+		/* Poison pointer on error instead of return for backward compatibility */
+		bpf_prog_assoc_struct_ops(prog, &st_map->map);
+
 		link = kzalloc(sizeof(*link), GFP_USER);
 		if (!link) {
 			bpf_prog_put(prog);
@@ -980,6 +994,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	if (btf_is_module(st_map->btf))
 		module_put(st_map->st_ops_desc->st_ops->owner);
 
+	bpf_struct_ops_map_dissoc_progs(st_map);
+
 	bpf_struct_ops_map_del_ksyms(st_map);
 
 	/* The struct_ops's function may switch to another struct_ops.
@@ -1394,6 +1410,78 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
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
+ * If the returned pointer is not NULL, it must points to a valid struct_ops.
+ * The struct_ops map is not guaranteed to be initialized nor attached.
+ * Kernel struct_ops implementers are responsible for tracking and checking
+ * the state of the struct_ops if the use case requires an initialized or
+ * attached struct_ops.
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
+
+	return &st_map->kvalue.data;
+}
+EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);
+
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c8ae6ab31651..67226145a4db 100644
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
@@ -2896,6 +2898,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 #endif
 	bpf_free_used_maps(aux);
 	bpf_free_used_btfs(aux);
+	bpf_prog_disassoc_struct_ops(aux->prog);
 	if (bpf_prog_is_dev_bound(aux))
 		bpf_prog_dev_bound_destroy(aux->prog);
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ea4c19ae3edc..7f7c4cf74120 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6121,6 +6121,49 @@ static int prog_stream_read(union bpf_attr *attr)
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
@@ -6260,6 +6303,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
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
index f5713f59ac10..bf4e00b8e272 100644
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
 
@@ -1894,6 +1905,12 @@ union bpf_attr {
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



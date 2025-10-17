Return-Path: <bpf+bounces-71259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59DBEBDD6
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 23:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DFB5E1224
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276DD330B3A;
	Fri, 17 Oct 2025 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auXRTmsO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79662F12CA
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738193; cv=none; b=DBnzTr4Vtp9CFekAE7ifmeDApwq5zetLoXC7hBKWBbXzpQyDqTv/An+jSmgBgZkf2M4gBT4LogXxV+A2ratN3gkZ1WT4YHLjFGIjfwq293lUL4bzZYl/0I3D4TgcFJU/4qzFm4WmmMm5LRItsBCMGUvZkL2epiUdBdrPwuCleIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738193; c=relaxed/simple;
	bh=LvOv7OVXNsTq44zVHB+ABvTtIkp1/Rfixjy8r8veTeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBM1+RrGmGPRc3RdEwJH/vq+1YkOoMH0UNisayZZhYJkg4H+Qsw+ATVoj5UKPe5xzOHqlL+DRHNLAgpAQZPFvtdHLNn6UtIZaQrRA97Q4WhxkgClBOwy4xjSNL/USovcusicTb0J7jYMf7C2S6CN3Cgeaeprlf99pjYdJRzLISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auXRTmsO; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b593def09e3so1633380a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760738191; x=1761342991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGZHjDBEuDV+OSw60rT4oo/s5sL+wDH2z3MNvxhRfCA=;
        b=auXRTmsO5cI2rgn6bErXmc6YQ8rfFci+NhpSOf54CuqkbBnRmEvn+6CAv8KOSRPGbE
         fSOcygKLhqgcNb+CbSU2SEoPL9VQQNGOLqwVxrW9HdsH/9+BurQr+OBEuW18fa+2PUrw
         kAzpML9dlFHH3j06bfbKHi1bw08CWC08Uw3KRPRu8vTDAIdEWz0C3LCH8G709GzLD4LN
         hBOJhAas/3IMxOdSM/xccglW5szRzo9RHsaB9BETY823aI6QKL1wHKVpelzgWbFliJZ2
         cC8sGYkFH3ONFTAcYSmU9Romb5EGUAizif5NxAx7lN9sGRva7GkztpTV+mv7YuHRXRmp
         VuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738191; x=1761342991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGZHjDBEuDV+OSw60rT4oo/s5sL+wDH2z3MNvxhRfCA=;
        b=BSjUaWE8/VUTWPNvZhzznuvyY/TU+59scmBPBrBYSbejKJ/wLSFN6gf6LKPPq4yP5Q
         EBHngg4owRA1NIEdzQFArWqJcAKUYLOAisVNsEu2b1TAKpZ0KIYIeUCVejov8cI7VU7Q
         KIn7TeR+QrLzBzZQ1tYPEmChcikXiewsGxdQ7REGK/so4/A+2GANtRYdQzEFkdG5q5gm
         Y2OlNlA13hk/fdGgZJklf97+EdEgOzhf2ADQPjH9odDs6y7QF8O0PWyDitRCTyj9miH/
         EitPllRWER0EHZYJi9mDtbx5yDyR37lrmkjqjvxbPLc5Nt5HGaB3unD7tW7IcoVsWHNX
         P7ug==
X-Gm-Message-State: AOJu0Ywzros6tJtgb+4B3N+JMqeOq9N+WdGKIQt5IjJeXnuiovI0WCd1
	YQQEofgUhuqkte/uthpQ4+pKCQaA9H1FdQQ6vG4Bg1qFEGK0+fJyjxZw2+ZSdQ==
X-Gm-Gg: ASbGncuv+yEjFEj3lAdKShC2SpEBOzi043j+5uSGMZszMWDwqdPZ72bJZC9iSKtBGlO
	Y9dEhtM/9XStX5aBG1abXZ9TVbaPYqVGFRNaSm5siNSkNt1ld9BTeAb/GP2m0+xaqoKum35SDdw
	JoG66U0XE3jucllLtqG/ADT9rrfpMjo1bWfFnu3t4rkj9LoW1NYPiq6b7wu90SrV5h4nLyeBTVx
	PJsg5MvBxVQw08YghkETI8UuGu6//1fXuineBSzwBPusZ+/ncB7cxDIgsQsHR9mGefFj9LE1YNJ
	1zx7KO/uytobfI+6OZiI5q9qWhJAgs7/HgT3JF0ctxrtlkW+4tBkamYYqHO8RT/mS2cIZlS5lsj
	f6YvCd3kALn1vFit+6NtuyKFpfn/y7S8NFyCtusS3tIu1HnCk8b/9DZeYeJsREpIrHGA=
X-Google-Smtp-Source: AGHT+IGMnVJtUn9fSBv5sza92LpaJV3mTBN5QzC1RV6NXfMS2aAhDTDR21XFoED7bE08hN6nTzBGvw==
X-Received: by 2002:a17:903:2884:b0:266:3098:666 with SMTP id d9443c01a7336-290ca121a21mr46436005ad.32.1760738190969;
        Fri, 17 Oct 2025 14:56:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5c0bsm5345215ad.69.2025.10.17.14.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 14:56:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/4] bpf: Support associating BPF program with struct_ops
Date: Fri, 17 Oct 2025 14:56:25 -0700
Message-ID: <20251017215627.722338-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017215627.722338-1-ameryhung@gmail.com>
References: <20251017215627.722338-1-ameryhung@gmail.com>
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

The command does not accept a struct_ops program or a non-struct_ops
map. Programs of a struct_ops map is automatically associated with the
map during map update. If a program is shared between two struct_ops
maps, prog->aux->st_ops_assoc will be poisoned to indicate that the
associated struct_ops is ambiguous. The pointer, once poisoned, cannot
be reset since we have lost track of associated struct_ops. For other
program types, the associated struct_ops map, once set, cannot be
changed later. This restriction may be lifted in the future if there is
a use case.

A kernel helper bpf_prog_get_assoc_struct_ops() can be used to retrieve
the associated struct_ops pointer. The pointer returned, if not NULL, is
guaranteed to be valid and point to a fully updated struct_ops struct.
This is done by increasing the refcount of the map for every associated
non-struct_ops programs. For struct_ops program reused in multiple
struct_ops map, the return will be NULL. struct_ops implementers should
note that the struct_ops returned may or may not be attached. The
struct_ops implementer will be responsible for tracking and checking the
state of the associated struct_ops map if the use case requires an
attached struct_ops.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h            | 16 ++++++++
 include/uapi/linux/bpf.h       | 17 +++++++++
 kernel/bpf/bpf_struct_ops.c    | 70 ++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c              |  3 ++
 kernel/bpf/syscall.c           | 46 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 17 +++++++++
 6 files changed, 169 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..97147aacd8ab 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1710,6 +1710,8 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	struct mutex st_ops_assoc_mutex;
+	struct bpf_map *st_ops_assoc;
 };
 
 struct bpf_prog {
@@ -2010,6 +2012,9 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
 u32 bpf_struct_ops_id(const void *kdata);
 
 #ifdef CONFIG_NET
@@ -2057,6 +2062,17 @@ static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
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
index ae83d8649ef1..41cacdbd7bd5 100644
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
 
@@ -1890,6 +1901,12 @@ union bpf_attr {
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
index a41e6730edcf..6d09eb8a3255 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -528,6 +528,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	for (i = 0; i < st_map->funcs_cnt; i++) {
 		if (!st_map->links[i])
 			break;
+		bpf_prog_disassoc_struct_ops(st_map->links[i]->prog);
 		bpf_link_put(st_map->links[i]);
 		st_map->links[i] = NULL;
 	}
@@ -801,6 +802,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
+		err = bpf_prog_assoc_struct_ops(prog, &st_map->map);
+		if (err) {
+			bpf_prog_put(prog);
+			goto reset_unlock;
+		}
+
 		link = kzalloc(sizeof(*link), GFP_USER);
 		if (!link) {
 			bpf_prog_put(prog);
@@ -1394,6 +1401,69 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
+{
+	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+
+	if (prog->aux->st_ops_assoc && prog->aux->st_ops_assoc != map) {
+		if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
+			WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISON);
+			return 0;
+		}
+
+		return -EBUSY;
+	}
+
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		bpf_map_inc(map);
+
+	WRITE_ONCE(prog->aux->st_ops_assoc, map);
+	return 0;
+}
+
+void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
+{
+	struct bpf_map *map;
+
+	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+
+	map = READ_ONCE(prog->aux->st_ops_assoc);
+	if (!map || map == BPF_PTR_POISON)
+		return;
+
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		bpf_map_put(map);
+
+	WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
+}
+
+/*
+ * Get a pointer to the struct_ops struct (i.e., kdata) associated with a
+ * program.
+ *
+ * If the returned pointer is not NULL, it must points to a valid and
+ * initialized struct_ops. The struct_ops may or may not be attached.
+ * Kernel struct_ops implementers are responsible for tracking and checking
+ * the state of the struct_ops if the use case requires an attached struct_ops.
+ */
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+{
+	struct bpf_struct_ops_map *st_map;
+	struct bpf_map *map;
+
+	map = READ_ONCE(aux->st_ops_assoc);
+	if (!map || map == BPF_PTR_POISON)
+		return NULL;
+
+	st_map = (struct bpf_struct_ops_map *)map;
+
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
index a48fa86f82a7..c40fc1e50934 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6092,6 +6092,49 @@ static int prog_stream_read(union bpf_attr *attr)
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
@@ -6231,6 +6274,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
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
index ae83d8649ef1..41cacdbd7bd5 100644
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
 
@@ -1890,6 +1901,12 @@ union bpf_attr {
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



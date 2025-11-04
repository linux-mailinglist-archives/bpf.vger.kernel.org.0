Return-Path: <bpf+bounces-73468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CAFC32538
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A56454E7E69
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5C33B6FC;
	Tue,  4 Nov 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3VNgn5k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDFD330305
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277220; cv=none; b=iVrrtpBctXFenDaqSoOfF5nepqV/7ongR8WJ6qrm8uDaLCH4V/QG8KTWMUN2e2Exe9YqFtqKC3ReBjW/tZAKGo9e9JX8B711G1x6F1FF6SjBujoNk529uSw1PsyA1+WN5tq08eVsZL39kW1Ww4I4o1Iq9FZB1C/nkz08j6qnZM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277220; c=relaxed/simple;
	bh=AmxjQtjAmnFN/NOgV49D01IZmIdkLn9LXZunVoDiRIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o09mMBAnVo2uXySyxQJn8eQHHYX2mCE1NIFdLkNj5+FOirZrUhoRtBlm1rCVdEVErS6medWeB8RKx7pB80hXg9eCAn2oInk89dNwd0LRJLaVBFYbW4jvbEWGXO5Jpl8yN5NYPpwXZ2d7IfKa2buEbHZo6l08WQNK1m/+fuwfMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3VNgn5k; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781206cce18so48283b3a.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762277218; x=1762882018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB17NeSN53m7+EHqn57/zqq9l8oWLsYXEuHxOsehStA=;
        b=h3VNgn5kBb76DcyJ0W5O34Yzk10OtiGG7KopYqOHOqR3cb0w1K1p+BicKoxJt/iAD1
         QsztryTM9lTU8HE4kNh8Aq/4SBBoBa6/i88aYefYmPE8+Bhy9zzdX+RK+w/rQsRGsgXg
         EJOabMDyMG3Ku+B2yRqHluVgRrPqtH1wJf840c0wMCOAhjiJLl8YtIYSLrbwPQ1U/3CO
         BcxTsgHOJSwGKPgTEVgJoK0YOVEEuNQKLAccVsAM2pux+56ZHI6czNrWx/HaTNl+8doh
         PLK/xebD39GqpmCm7s+A45YBkQqdrPRshUsV8iqY8bsoYvH+dSDDti3zrHM4Ce9XSiep
         jUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277218; x=1762882018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zB17NeSN53m7+EHqn57/zqq9l8oWLsYXEuHxOsehStA=;
        b=PKGfGTx9tv/e++03+yVGVk7GGypKu5BfqapkTqVQBNKbUs7ByUMcwut4JVzYzahFjE
         nZNz/WGA5kD1aGgJ45sM3YDctoxRBzcU+O9mqiQWd1sdmIbnK92omXwhWuhY1jGG2/84
         p7CTIDjVx1DTVYfPRxBk3ub/UPjxoxiSi7kH6ly1b7oJ/JnHnuazBtzOhZ9rLCIetvw8
         /V0pL85usuBRYri/Ff7TxuOGXxhva8U4fOXsCe8BeJJE2bG93oyfVPlv8iZtvgCyEpXz
         cDTzd+j2CjFWrMpcXXmDoJK2QaeUZY3qe7qySlwCwNtPwjJsrfPpoqRpMvOoVhpIlw2F
         IMkQ==
X-Gm-Message-State: AOJu0YxbCplWKFmY7fLHPnEbyoPDRs0OrtmqdGLBCv5ayF5RmZxp9zWh
	fiqVic9FskjrcijtYRVsoyxenjOWU0fUHgQofZNXPftp6uWNeZN7RNAYfokFFQ==
X-Gm-Gg: ASbGncvHUu5s4l9GSfb57HQnAKL7AT3+jwOjuePW70IQ3s4HI4BXCjmudq3JXUq1nmS
	vEYsEoi9Usi0MrcrTBWwLu4BgYdI6jDKfiOtOx+P7ImpYY9F4U9OXi3ab8hasI14wXzscBlQcU7
	Zbj0vAINqKAPmaEj0E8t3uOtAsoTYwPs2j7LfTvsGqM1y/Ml6ZMNRN6ieoIoIWJsC2YMNdeTosH
	UP5Fv/S/GOpH0GGQmxZK70IsAgCp7Dbvo33OmHqroZjBvmhY1KQrbjj7qmOxhaYCRM2Y6POj17C
	mgM7RNb8qBVj1cnV5RY+amNlo4FQg+1DUnuGbGY14tKXLOGfZ2c1820dNdWkugzSwnkSp5WFK+i
	rI+G4XVVSQyBvsEcd7h3Um0XYpwOjrWt2gqhrLpOF7n8ZAzWm2UeUUyBu5ucovfv7NA==
X-Google-Smtp-Source: AGHT+IG7RTGi9kuw0LKIAGN8PcXtPqvP8OK1AhWGY+a4D/fwZMLwsPqZ9vFk/94OdQtgg4fHdm12Hg==
X-Received: by 2002:a05:6a00:7582:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7acbe8fa32cmr4756338b3a.1.1762277217692;
        Tue, 04 Nov 2025 09:26:57 -0800 (PST)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3d013e2sm3501677b3a.33.2025.11.04.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:26:57 -0800 (PST)
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
Subject: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with struct_ops
Date: Tue,  4 Nov 2025 09:26:47 -0800
Message-ID: <20251104172652.1746988-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104172652.1746988-1-ameryhung@gmail.com>
References: <20251104172652.1746988-1-ameryhung@gmail.com>
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

To make sure the returned pointer to be valid, the command increases the
refcount of the map for every associated non-struct_ops programs. For
struct_ops programs, the destruction of a struct_ops map already waits for
its BPF programs to finish running. A later patch will further make sure
the map will not be freed when an async callback schedule from struct_ops
is running.

struct_ops implementers should note that the struct_ops returned may or
may not be attached. The struct_ops implementer will be responsible for
tracking and checking the state of the associated struct_ops map if the
use case requires an attached struct_ops.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h            | 16 ++++++
 include/uapi/linux/bpf.h       | 17 +++++++
 kernel/bpf/bpf_struct_ops.c    | 90 ++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c              |  3 ++
 kernel/bpf/syscall.c           | 46 +++++++++++++++++
 tools/include/uapi/linux/bpf.h | 17 +++++++
 6 files changed, 189 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a47d67db3be5..0f71030c03e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1726,6 +1726,8 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	struct mutex st_ops_assoc_mutex;
+	struct bpf_map *st_ops_assoc;
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
index a41e6730edcf..0a19842da7a2 100644
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
@@ -801,6 +812,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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
@@ -980,6 +997,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	if (btf_is_module(st_map->btf))
 		module_put(st_map->st_ops_desc->st_ops->owner);
 
+	bpf_struct_ops_map_dissoc_progs(st_map);
+
 	bpf_struct_ops_map_del_ksyms(st_map);
 
 	/* The struct_ops's function may switch to another struct_ops.
@@ -1394,6 +1413,77 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
+{
+	struct bpf_map *st_ops_assoc;
+
+	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
+
+	st_ops_assoc = prog->aux->st_ops_assoc;
+
+	if (st_ops_assoc && st_ops_assoc == map)
+		return 0;
+
+	if (st_ops_assoc) {
+		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+			return -EBUSY;
+
+		WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISON);
+	} else {
+		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+			bpf_map_inc(map);
+
+		WRITE_ONCE(prog->aux->st_ops_assoc, map);
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
+	st_ops_assoc = prog->aux->st_ops_assoc;
+
+	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
+		return;
+
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
+		bpf_map_put(st_ops_assoc);
+
+	WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
+}
+
+/*
+ * Get a reference to the struct_ops struct (i.e., kdata) associated with a
+ * program.
+ *
+ * If the returned pointer is not NULL, it must points to a valid and
+ * initialized struct_ops. The struct_ops may or may not be attached.
+ * Kernel struct_ops implementers are responsible for tracking and checking
+ * the state of the struct_ops if the use case requires an attached struct_ops.
+ */
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+{
+	struct bpf_map *st_ops_assoc = READ_ONCE(aux->st_ops_assoc);
+	struct bpf_struct_ops_map *st_map;
+
+	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
+		return NULL;
+
+	st_map = (struct bpf_struct_ops_map *)st_ops_assoc;
+
+	if (smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_INIT) {
+		bpf_map_put(st_ops_assoc);
+		return NULL;
+	}
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



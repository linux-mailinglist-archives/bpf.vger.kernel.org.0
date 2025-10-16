Return-Path: <bpf+bounces-71156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B0BE56BD
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C95019A3DD7
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5C2E3B11;
	Thu, 16 Oct 2025 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf1VikCK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D62E0936
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647509; cv=none; b=do5W3X1tjnUz8PJq492IL3wgeFBBI27RdEirhbHRtj4/0JblT0BPTdr40dl4tZ4IHb0MYisfaeYIbCK9AUr2QiiYk8fSJ4by+MYnc+/K6bBWMbDNquvlJyKnhLG1cm25wExDirvPoqrSsndzy1rogkJJy70yufTmQxVW4KkRWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647509; c=relaxed/simple;
	bh=PSVWmPUiWu35MqlbCGHhIhdQ90LpgOSLi1R8lDUUEfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVhcwMLRiVI5NQVENhRQwwmO8fUrGzH0V9d6KJCqLB33bTTgMq3CnHjRjc2xfPZhi/252Q6WlD2t17sFJ/MpkgubxF1sYZmqcuc/W8bM9dIIEJqIcOgg4wQ9JzoKpDbmWzpD/fKASXT/4+TRjFzqDf9HSXT8scS2GT5HE8Vcnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf1VikCK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so1535899a91.2
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647506; x=1761252306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkOn4esVZWCrFe/Q8WL70PxdfJYLlzxqIAzQ9KzGceU=;
        b=Bf1VikCKiJtLTDv46ywxIh3QBBfmf/RtdLOoGlCy6488OrJPQFPHkzcJVl53gt9oro
         Q28+E82+InpM11dXwn3EcyKkloDy9fYfDLyWYaT0Zn6xmkNzdkDbrdI04ajGAEHj57Yp
         4k/Is+C8AoU6EBWkDIun+HUkkMGnFD4bgptGmbE3T7V2ry3g1LBhyudJEbhSakqOse3T
         c892U518Qjn4EmSOlkjZSSC3O24pOBk0mwaQhtgwycFNYyOkfGemyBMkKk/yjBOybbU7
         aAGxZLOMvN7a/izEKOGSXqbMsYBTJecjg0k8ng3RgiOsc54Wqc2FphNaGyBmdIYbsLzq
         s3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647506; x=1761252306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkOn4esVZWCrFe/Q8WL70PxdfJYLlzxqIAzQ9KzGceU=;
        b=xTv0hU9yN3Ui3so7pPbEl8sgX2wveaRL8+SjetvUJRlj40VU/hOfUf4K2mwhMeJBsb
         VyJ5JQnLmSwKMAu4Ny0yXsgQ+rqQwYPxEzGzRp5FIMDDBz5LTM+5evwJGqIZHgDb7a2D
         gQKXswFD9MAfNDW+6+/P8OIGg/qoF/gV7KqYQy1rrgeHGRCeZuvLiRmCKaDQNjjpXgsu
         tgEiFGFIo89za6P/sl9xYgIrS5HQUdegwai5aGJaJJahLm0JXkEQeXa2yXTPXvuzJOrS
         yRPBHu9SRdq+hw2BMx7DbfSzzmvLkUE6k7kahvnpmIoOTJlg1mUzqUE4juHoMZPzrzTC
         j1tw==
X-Gm-Message-State: AOJu0Yx6FlD8clE/jLkRjUAreViS56XE2q9EPgVCKyKIFq+HdO1hcjYv
	0QUfbns908BRklkXjjD8sVySzMDf/mrZ1xAh4ycHUrTpQSX7iIEvwzBRCJT+jQ==
X-Gm-Gg: ASbGncvoRm389TKEC/AUTvE8jMQ+ZnFg+mtX3NjTyQYbStZUncakwYgO2xcZBzgHaJ4
	ahXUeh3xg2v5DNYXiPT6LkScAcSIYGG1QTC1RgskhV2dVXc5NOMQZPGZeihaj22Qa6r7NaZeqlr
	OZw4F6Hmu/XEEw7ZDvwjNoYC6DWK0Ju0mW0tx79T+j8jo6WSpS8KI1E6bz+KnWTNgglc2r2px9M
	A+DXz0qN4SnAKQA8TB1m/55/ibpV63NrvEtt9obQ9AlkSZCo7ux61b+sOKshe6ITT/A7LwOZtgs
	+UadnpOIsmtzsAMW3pxMURNPsxlTqqdcsFdBg45gNnMLCAXwGIGYcpRXE9FxKHSH1FbxrfV2Rox
	j+Nm3smGCXr51Fvy5fY8N99xJ2+X7h0h0TW7c2sDP+aCFqMo6noozxZrNd8GDxhgs2azaiybyNG
	m8Xg==
X-Google-Smtp-Source: AGHT+IH3vf2vytD7+x4WXgJNrsjMqQPo5Rzdrc64pnzhYLKLNCqaROlJgGDz/DZPT1O4/NBvLe+Vww==
X-Received: by 2002:a17:90b:5105:b0:32e:e3af:45f6 with SMTP id 98e67ed59e1d1-33bcf87b6a4mr1399343a91.10.1760647505933;
        Thu, 16 Oct 2025 13:45:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd7b31724sm351610a91.14.2025.10.16.13.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:45:05 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/4] bpf: Support associating BPF program with struct_ops
Date: Thu, 16 Oct 2025 13:45:01 -0700
Message-ID: <20251016204503.3203690-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016204503.3203690-1-ameryhung@gmail.com>
References: <20251016204503.3203690-1-ameryhung@gmail.com>
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
associated struct_ops is ambiguous. A kernel helper
bpf_prog_get_assoc_struct_ops() can be used to retrieve the pointer.
The associated struct_ops map, once set, cannot be changed later. This
restriction may be lifted in the future if there is a use case.

Each associated programs except struct_ops programs of the map will take
a refcount on the map to pin it so that prog->aux->st_ops_assoc, if set,
is always valid. However, it is not guaranteed whether the map members
are fully updated nor is it attached or not. For example, a BPF program
can be associated with a struct_ops map before map_update. The
struct_ops implementer will be responsible for maintaining and checking
the state of the associated struct_ops map before accessing it.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h            | 16 +++++++++++
 include/uapi/linux/bpf.h       | 17 ++++++++++++
 kernel/bpf/bpf_struct_ops.c    | 44 ++++++++++++++++++++++++++++++
 kernel/bpf/core.c              |  6 ++++
 kernel/bpf/syscall.c           | 50 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 17 ++++++++++++
 6 files changed, 150 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a98c83346134..b2037e9b72a1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1710,6 +1710,8 @@ struct bpf_prog_aux {
 		struct rcu_head	rcu;
 	};
 	struct bpf_stream stream[2];
+	struct mutex st_ops_assoc_mutex;
+	void *st_ops_assoc;
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
index a41e6730edcf..e060d9823e4a 100644
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
@@ -801,6 +802,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			goto reset_unlock;
 		}
 
+		/* If the program is reused, prog->aux->st_ops_assoc will be poisoned */
+		bpf_prog_assoc_struct_ops(prog, &st_map->map);
+
 		link = kzalloc(sizeof(*link), GFP_USER);
 		if (!link) {
 			bpf_prog_put(prog);
@@ -1394,6 +1398,46 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	return err;
 }
 
+int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	void *kdata = &st_map->kvalue.data;
+	int ret = 0;
+
+	mutex_lock(&prog->aux->st_ops_assoc_mutex);
+
+	if (prog->aux->st_ops_assoc && prog->aux->st_ops_assoc != kdata) {
+		if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+			WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISON);
+
+		ret = -EBUSY;
+		goto out;
+	}
+
+	WRITE_ONCE(prog->aux->st_ops_assoc, kdata);
+out:
+	mutex_unlock(&prog->aux->st_ops_assoc_mutex);
+	return ret;
+}
+
+void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
+{
+	mutex_lock(&prog->aux->st_ops_assoc_mutex);
+	WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
+	mutex_unlock(&prog->aux->st_ops_assoc_mutex);
+}
+
+void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
+{
+	void *st_ops_assoc = READ_ONCE(aux->st_ops_assoc);
+
+	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
+		return NULL;
+
+	return st_ops_assoc;
+}
+EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);
+
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..f66831776760 100644
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
@@ -2875,6 +2877,10 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 #endif
 	bpf_free_used_maps(aux);
 	bpf_free_used_btfs(aux);
+	if (aux->st_ops_assoc) {
+		bpf_struct_ops_put(aux->st_ops_assoc);
+		bpf_prog_disassoc_struct_ops(aux->prog);
+	}
 	if (bpf_prog_is_dev_bound(aux))
 		bpf_prog_dev_bound_destroy(aux->prog);
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a48fa86f82a7..f4027e50e1d5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6092,6 +6092,53 @@ static int prog_stream_read(union bpf_attr *attr)
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
+	if (ret)
+		goto put_map;
+
+	bpf_prog_put(prog);
+	return 0;
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
@@ -6231,6 +6278,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
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



Return-Path: <bpf+bounces-13504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C867DA243
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1585DB2159A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9253FB2A;
	Fri, 27 Oct 2023 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUs640Ln"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9053FB1D
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:17:20 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D81AA
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7c08b7744so19240547b3.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441437; x=1699046237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdoKgDbw0RPOGc9eKfRxQYiqQHGExsmimc986Jd4TTw=;
        b=VUs640LnGMoTPRirY2Aao7z30WTG+f2DCpBD4r5XcwwwuAKrsp55XkSW2s6ia3496X
         u7ym4nvkv5QCOO11h39FTb5FkT1Llz2gezsV8u0S2/hW7xz5FtKj5BuE9qv9KTG5UhYx
         gEhFptn2ks73qxH8E44wRMahsqmGXxEZJR4GGy9NTHSo1bE1FwnppMIj1k2UP5yUZqMH
         SCmmS3rDnWLiL3W7eXSXvmf5pKceLMiUOv/q/yKXuu0FbhRh73qnfp12srxfKKbO9E3H
         x/VgRm6d9ln+/8VE9e9lOAK28pI90lIWyJGHqbaN/t3QKJJ7R88R7MyWlzZ0MLTVe4i8
         sajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441437; x=1699046237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdoKgDbw0RPOGc9eKfRxQYiqQHGExsmimc986Jd4TTw=;
        b=uwiKagKW4ACj0N4swT3c5uhHAUzWvNjWGRgMtYYG2VQ28lOJPl+k8KH+lKyrJj2FD8
         myXlKmAQBGVi1rllZLbbVV6wDO9Fw8c80hpDpEhCAd/JUvhbHjK0zyv5WrRpQRxOyFF9
         hD6aRryZe0tI6l+yEO54yhX++VFtLC0t2UxxyGPe32QssBKDO8jfHdjp81GV+lXTD9yQ
         12KhsDnMkyZ7y1rlwoYY+qhwIJ5CnxjTHc3d/AUX6gDT6GnvvUWe8c2KgCF4JCQfoakW
         eSwuegSDvbrH1RWTpX0uem8bHtvvZR/XC3hY8TOb6XQ+YSoD66EdJkJTBcRL/UcRtvEq
         I5DQ==
X-Gm-Message-State: AOJu0Yxb+2UOwRz8gRUm3EHnxjbKHxb4+oYoB8TF9CVuJt1jiYw6+G2x
	pcqmY4qDOr96/jlLc9vmOVFROqbL//U=
X-Google-Smtp-Source: AGHT+IEx16QTKewn59H6x407/HNIMaJBfShgn0C05LxTZ0PLYjhRONWqFW33Uml0pJIg5WHnNx8TLQ==
X-Received: by 2002:a81:764b:0:b0:5a8:204c:5c9b with SMTP id j11-20020a81764b000000b005a8204c5c9bmr3686254ywk.18.1698441437350;
        Fri, 27 Oct 2023 14:17:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:41cd:a94b:292d:cd8])
        by smtp.gmail.com with ESMTPSA id e133-20020a81698b000000b0059a34cfa2a5sm1080174ywc.67.2023.10.27.14.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:17:17 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 06/10] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Fri, 27 Oct 2023 14:16:58 -0700
Message-Id: <20231027211702.1374597-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027211702.1374597-1-thinker.li@gmail.com>
References: <20231027211702.1374597-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Giving a BTF, the bpf_struct_ops knows the right place to look up type info
associated with a type ID. This enables a user space program to load a
struct_ops object linked to a struct_ops type defined by a module, by
providing the module BTF (fd).

The bpf_prog includes attach_btf in aux which is passed along with the
bpf_attr when loading the program. The purpose of attach_btf is to
determine the btf type of attach_btf_id. The attach_btf_id is then used to
identify the traced function for a trace program. In the case of struct_ops
programs, it is used to identify the struct_ops type of the struct_ops
object that a program is attached to.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf_verifier.h   |  1 +
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/bpf_struct_ops.c    | 32 +++++++++++++++++++++++++-------
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          | 15 ++++++++++++++-
 tools/include/uapi/linux/bpf.h |  5 +++++
 6 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 24213a99cc79..c1461342f19e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -598,6 +598,7 @@ struct bpf_verifier_env {
 	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	const struct bpf_verifier_ops *ops;
+	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f6cdf52b1da..fd20c52606b2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1398,6 +1398,11 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+
+		__u32   value_type_btf_obj_fd;	/* fd pointing to a BTF
+						 * type data for
+						 * btf_vmlinux_value_type_id.
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 256516aba632..db2bbba50e38 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -694,6 +694,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	btf_put(st_map->st_ops_desc->btf);
 	bpf_map_area_free(st_map);
 }
 
@@ -735,16 +736,31 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	const struct btf_type *t, *vt;
 	struct module *mod = NULL;
 	struct bpf_map *map;
+	struct btf *btf;
 	int ret;
 
-	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
-	if (!st_ops_desc)
-		return ERR_PTR(-ENOTSUPP);
+	if (attr->value_type_btf_obj_fd) {
+		/* The map holds btf for its whole life time. */
+		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
+		if (IS_ERR(btf))
+			return ERR_PTR(PTR_ERR(btf));
+
+		if (btf != btf_vmlinux) {
+			mod = btf_try_get_module(btf);
+			if (!mod) {
+				ret = -EINVAL;
+				goto errout;
+			}
+		}
+	} else {
+		btf = btf_vmlinux;
+		btf_get(btf);
+	}
 
-	if (st_ops_desc->btf != btf_vmlinux) {
-		mod = btf_try_get_module(st_ops_desc->btf);
-		if (!mod)
-			return ERR_PTR(-EINVAL);
+	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
+	if (!st_ops_desc) {
+		ret = -ENOTSUPP;
+		goto errout;
 	}
 
 	vt = st_ops_desc->value_type;
@@ -805,7 +821,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	__bpf_struct_ops_map_free(map);
 	btf = NULL;		/* has been released */
 errout:
+	btf_put(btf);
 	module_put(mod);
+
 	return ERR_PTR(ret);
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ed286b8a0f0..974651fe2bee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1096,7 +1096,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD value_type_btf_obj_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bdd166cab977..d03b39fb0faa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20086,6 +20086,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -20093,8 +20094,18 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	btf = prog->aux->attach_btf;
+	if (btf != btf_vmlinux) {
+		/* Make sure st_ops is valid through the lifetime of env */
+		env->attach_btf_mod = btf_try_get_module(btf);
+		if (!env->attach_btf_mod) {
+			verbose(env, "owner module of btf is not found\n");
+			return -ENOTSUPP;
+		}
+	}
+
 	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
+	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
 	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
@@ -20805,6 +20816,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0f6cdf52b1da..fd20c52606b2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1398,6 +1398,11 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+
+		__u32   value_type_btf_obj_fd;	/* fd pointing to a BTF
+						 * type data for
+						 * btf_vmlinux_value_type_id.
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
-- 
2.34.1



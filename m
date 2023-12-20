Return-Path: <bpf+bounces-18449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4674981A92B
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4E61C230A5
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7090A4BA96;
	Wed, 20 Dec 2023 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5lYmRFi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CB4A997
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e54d40cca2so1876557b3.3
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 14:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703111227; x=1703716027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i7nUoAkkd694ijbCLduicVJ3KrFCpRdUkUsCCEao88=;
        b=K5lYmRFi8KlinQZimUIVBZALpnyefXOxIArbBg78WveNrJMmJFdax1+86I0XcdRcnY
         3PslBswB/t8T7PDWIOeSwyghvURM3He27eiIbd+vtAPEjyGhymZOmKHKTLVuWvmTQ42j
         lsjnf82hjphhhnlrLIM0b0zUpAWL2yxXx+LfBgTafPU5o05Tvswe6UHO084LU60+7KzE
         ypvVrTQY3+i4KpOeE8erA/OXPYsivK0rje6Y28mhKG0NcE4H1MmdZiAkJIt54wEVUfuu
         Sjvz3jmaiw7t/6Do9bLIaGb1PfxtXAU5benoT1HyRFNG4p3/d6w1L67nualtvo0v0A0+
         hgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111227; x=1703716027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7i7nUoAkkd694ijbCLduicVJ3KrFCpRdUkUsCCEao88=;
        b=nVsRUWx/d1pCUcmLSLfQ4u9bIiQpj8UZY/0CuhzeiS9U8uUH4/Yq8fCe9ZCev+KZZ8
         0tWjYRILuQV/WK/e08sZzzcIuNBWhq3rWoy/jR24mF9kmjH3M0WAGLnRr+hN47sibfet
         loQSPrTZS+aksDzG7NdeDwd9e8E6QSO3awZvIsAlZedg7qCBI3W9OT1+sPo+vedaWYqb
         AMxzQH6J5+o5hK7xqpi2FsWP3O4D1wiX3DDpaM13bN8w0jXsp1eoAtDdTnjlw66c38hZ
         N60rsZnEqd/B8BZJwpiVvqFnC2u3XH+Qu7URwyPqwC0IHUW1ylsk/4Mmx5BlW3NbBaKf
         eVXw==
X-Gm-Message-State: AOJu0Yyp+VQAzho5IIjAnu13LqC7Wj53mYQ30FNXaqx3IJDxsosxGb5I
	e8CdHrlkWrQeoLV01uyJSevKPrZhjcU=
X-Google-Smtp-Source: AGHT+IGfHQHAV/IZzDV+8MYjVtKgFZDQXeod/HOKW+OInDK5i0R9/OOEV6gdytLGieFMpT3/rXxBFQ==
X-Received: by 2002:a81:4942:0:b0:5e7:8d32:dbdb with SMTP id w63-20020a814942000000b005e78d32dbdbmr290653ywa.82.1703111227189;
        Wed, 20 Dec 2023 14:27:07 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8cc1:afcb:3651:3dad])
        by smtp.gmail.com with ESMTPSA id m125-20020a0dfc83000000b005ca4e49bb54sm284304ywf.142.2023.12.20.14.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:27:06 -0800 (PST)
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
Subject: [PATCH bpf-next v15 08/14] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Wed, 20 Dec 2023 14:26:48 -0800
Message-Id: <20231220222654.1435895-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220222654.1435895-1-thinker.li@gmail.com>
References: <20231220222654.1435895-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Pass the fd of a btf from the userspace to the bpf() syscall, and then
convert the fd into a btf. The btf is generated from the module that
defines the target BPF struct_ops type.

In order to inform the kernel about the module that defines the target
struct_ops type, the userspace program needs to provide a btf fd for the
respective module's btf. This btf contains essential information on the
types defined within the module, including the target struct_ops type.

A btf fd must be provided to the kernel for struct_ops maps struct_ops and
for the bpf programs attached to those maps.

In the case of the bpf programs, the attach_btf_obj_fd parameter is passed
as part of the bpf_attr and is converted into a btf. This btf is then
stored in the prog->aux->attach_btf field. Here, it just let the verifier
access attach_btf directly.

In the case of struct_ops maps, a btf fd is passed as value_type_btf_obj_fd
of bpf_attr. The bpf_struct_ops_map_alloc() function converts the fd to a
btf and stores it as st_map->btf.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/uapi/linux/bpf.h       |  5 +++
 kernel/bpf/bpf_struct_ops.c    | 62 ++++++++++++++++++++++++----------
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          |  9 +++--
 tools/include/uapi/linux/bpf.h |  5 +++
 5 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8eb949b52102..1b5bf5d60e38 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1403,6 +1403,11 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+
+		__s32   value_type_btf_obj_fd;	/* fd pointing to a BTF
+						 * type data for
+						 * btf_vmlinux_value_type_id.
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 7505f515aac3..71cd433fc521 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -641,6 +641,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	btf_put(st_map->btf);
 	bpf_map_area_free(st_map);
 }
 
@@ -681,15 +682,36 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
+	struct btf *btf;
 	int ret;
 
-	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
-	if (!st_ops_desc)
-		return ERR_PTR(-ENOTSUPP);
+	if (attr->value_type_btf_obj_fd >= 0) {
+		/* The map holds btf for its whole life time. */
+		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
+		if (IS_ERR(btf))
+			return ERR_CAST(btf);
+		if (!btf_is_module(btf)) {
+			btf_put(btf);
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		btf = bpf_get_btf_vmlinux();
+		if (IS_ERR(btf))
+			return ERR_CAST(btf);
+		btf_get(btf);
+	}
+
+	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
+	if (!st_ops_desc) {
+		ret = -ENOTSUPP;
+		goto errout;
+	}
 
 	vt = st_ops_desc->value_type;
-	if (attr->value_size != vt->size)
-		return ERR_PTR(-EINVAL);
+	if (attr->value_size != vt->size) {
+		ret = -EINVAL;
+		goto errout;
+	}
 
 	t = st_ops_desc->type;
 
@@ -700,17 +722,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		(vt->size - sizeof(struct bpf_struct_ops_value));
 
 	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
-	if (!st_map)
-		return ERR_PTR(-ENOMEM);
+	if (!st_map) {
+		ret = -ENOMEM;
+		goto errout;
+	}
 
 	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
 	ret = bpf_jit_charge_modmem(PAGE_SIZE);
-	if (ret) {
-		__bpf_struct_ops_map_free(map);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto errout_free;
 
 	st_map->image = arch_alloc_bpf_trampoline(PAGE_SIZE);
 	if (!st_map->image) {
@@ -719,24 +741,30 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		 * here.
 		 */
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
-		__bpf_struct_ops_map_free(map);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto errout_free;
 	}
 	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
 	st_map->links =
 		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
 				   NUMA_NO_NODE);
 	if (!st_map->uvalue || !st_map->links) {
-		__bpf_struct_ops_map_free(map);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto errout_free;
 	}
-
-	st_map->btf = btf_vmlinux;
+	st_map->btf = btf;
 
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
 
 	return map;
+
+errout_free:
+	__bpf_struct_ops_map_free(map);
+errout:
+	btf_put(btf);
+
+	return ERR_PTR(ret);
 }
 
 static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 44b07a08295c..bae096964930 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1123,7 +1123,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD value_type_btf_obj_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dafcd34be56b..822bb4f5e8a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20219,6 +20219,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -20226,8 +20227,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
+
 	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
+	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
 	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
@@ -20244,8 +20247,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	member = &btf_type_member(t)[member_idx];
-	mname = btf_name_by_offset(btf_vmlinux, member->name_off);
-	func_proto = btf_type_resolve_func_ptr(btf_vmlinux, member->type,
+	mname = btf_name_by_offset(btf, member->name_off);
+	func_proto = btf_type_resolve_func_ptr(btf, member->type,
 					       NULL);
 	if (!func_proto) {
 		verbose(env, "attach to invalid member %s(@idx %u) of struct %s\n",
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1949d881f230..118247962b73 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1403,6 +1403,11 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+
+		__s32   value_type_btf_obj_fd;	/* fd pointing to a BTF
+						 * type data for
+						 * btf_vmlinux_value_type_id.
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
-- 
2.34.1



Return-Path: <bpf+bounces-14320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D937E2DF3
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8BEB20B01
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1639F2E3EB;
	Mon,  6 Nov 2023 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG2PvN1X"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD02E63A
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:13 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C610EB
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:13:11 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59e88a28b98so42719867b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301589; x=1699906389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqAlLOKNQif6b9Pce867dvcA4+g9SmLIfm6t01dtofw=;
        b=ZG2PvN1XXI8JcWz8gLSXLEj1EvEp0jUC5Dj6zCt4nmumRCLYBcm/myWcPi8ZKr3YMY
         y8K4r+3pHV7BOC30fRTCfOzaME16NPZ63mdugcW1XS486IrlgZMjuF4ULMauuLNKqh+w
         I2xIz4CFQcz4ME4MdnI7ZpoMkLRPTkhqX3y0dI6D+3JUsIa8cs5p478VQHH4sfMeoY1O
         LaJdecbeOjnc7T8ZXu2kozX9tGa/cRpu/9K65N+kYQRpyykExMvFJVyxCl47bxNgxlS2
         F0MJ+ZDvA11uYoOVBORtu8dvW9tE0DhAyECCV6J9z+1oZAWcWniAe1DBINz7gYC+WJg4
         YRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301589; x=1699906389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqAlLOKNQif6b9Pce867dvcA4+g9SmLIfm6t01dtofw=;
        b=VN+159uU9/UUVOltz3q4ur7gWsTOseNN8PqWxgaybvgOQD44eDxHplHtFhU27z6Gt5
         RdHSvJoYBU49ThjDvuGVuZbrSvPd+vST+jzo74kyWFOltDYGOrSZPaH1U0F7LioC8ir1
         4wju0JRIoRTvuo/xiYKGHDEOIcPIUkPnMUxZp870vdCG+qncj2yFP60Nko5YdtL5qA81
         cBQNfdpCJJqgKwgTq0zalq4IDpKTOHWdL01o9qVQO30aZK+3CYGgT9L4m61a4OjGhMEV
         7OGN1ll7YgtbYGEfTjCSfFuV/bSY0Q+OTfMqf6bumyIaVwbe8PD1JqlrUI9lZMYypet/
         Cezw==
X-Gm-Message-State: AOJu0YxgX5UTbOTUqjC1ng/oTUnAP+EMXXe1nF5iv9+y+e7Fbnr1RSZc
	LA0IteGxhFdGLuiuR/vAHTn29azFsQs=
X-Google-Smtp-Source: AGHT+IFcX//JA6MvzX9T83rfcAtgUNbN8TZaXFu8H2mFpyO3rrTTkqYiB0nIof2YI4TD6oEeYuDTpQ==
X-Received: by 2002:a0d:dbcc:0:b0:5a8:1a54:ba4b with SMTP id d195-20020a0ddbcc000000b005a81a54ba4bmr462758ywe.13.1699301589397;
        Mon, 06 Nov 2023 12:13:09 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:13:08 -0800 (PST)
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
Subject: [PATCH bpf-next v11 07/13] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Mon,  6 Nov 2023 12:12:46 -0800
Message-Id: <20231106201252.1568931-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106201252.1568931-1-thinker.li@gmail.com>
References: <20231106201252.1568931-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Every kernel module has its BTF, comprising information on types defined in
the module. The BTF fd (attr->value_type_btf_obj_fd) passed from userspace
helps the bpf_struct_ops to lookup type information and description of the
struct_ops type, which is necessary for parsing the layout of map element
values and registering maps. The descriptions are looked up by matching a
type id (attr->btf_vmlinux_value_type_id) against bpf_struct_ops_desc(s)
defined in a BTF. If the struct_ops type is defined in a module, the
bpf_struct_ops needs to know the module BTF to lookup the
bpf_struct_ops_desc.

The bpf_prog includes attach_btf in aux which is passed along with the
bpf_attr when loading the program. The purpose of attach_btf is to
determine the btf type of attach_btf_id. The attach_btf_id is then used to
identify the traced function for a trace program. In the case of struct_ops
programs, it is used to identify the struct_ops type of the struct_ops
object that a program is attached to.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/uapi/linux/bpf.h       |  5 +++
 kernel/bpf/bpf_struct_ops.c    | 57 ++++++++++++++++++++++++----------
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          |  9 ++++--
 tools/include/uapi/linux/bpf.h |  5 +++
 5 files changed, 57 insertions(+), 21 deletions(-)

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
index 4ba6181ed1c4..2fb1b21f989a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -635,6 +635,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	btf_put(st_map->btf);
 	bpf_map_area_free(st_map);
 }
 
@@ -675,15 +676,30 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
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
+	} else {
+		btf = btf_vmlinux;
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
 
@@ -694,17 +710,18 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		(vt->size - sizeof(struct bpf_struct_ops_value));
 
 	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
-	if (!st_map)
-		return ERR_PTR(-ENOMEM);
+	if (!st_map) {
+		ret = -ENOMEM;
+		goto errout;
+	}
 
+	st_map->btf = btf;
 	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
 	ret = bpf_jit_charge_modmem(PAGE_SIZE);
-	if (ret) {
-		__bpf_struct_ops_map_free(map);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto errout_free;
 
 	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
 	if (!st_map->image) {
@@ -713,25 +730,31 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
 
-	st_map->btf = btf_vmlinux;
-
 	mutex_init(&st_map->lock);
 	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
 
 	return map;
+
+errout_free:
+	__bpf_struct_ops_map_free(map);
+	btf = NULL;		/* has been released */
+errout:
+	btf_put(btf);
+
+	return ERR_PTR(ret);
 }
 
 static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
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
index bdd166cab977..3f446f76d4bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20086,6 +20086,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -20093,8 +20094,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	btf = prog->aux->attach_btf;
+
 	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
+	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
 	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
@@ -20111,8 +20114,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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



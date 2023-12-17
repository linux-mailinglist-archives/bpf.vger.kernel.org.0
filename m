Return-Path: <bpf+bounces-18121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E677815E0A
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9757D1F224D2
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBE2599;
	Sun, 17 Dec 2023 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC+zJagY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4520EB
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so1369937276.0
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800712; x=1703405512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbQZZ67EiRiEqYh2CTsAlBEPPvOMdkhTkwDC7DgRYmM=;
        b=YC+zJagYzYpsauxyX7D9WyuNKaZB0XoNWS48l/TdxIJajoQDGPpFxd0zaU5/9+pp9U
         ZsrCuMoT+V4L04XZfIxTP9djR3uhI24lTB4pi10W6RmFMfpHeKcrkptgEj1BnwAyJPCB
         pFbKgEWLXZhd7Ski30OWBPe/xP/pWpKLBLitN6VU9lPF8bWWLhccUZcq5Lz3LcPVYng+
         ++EbzGzUn208HECzyxVRUf5lwAoDz1KDzlhcaWLD7AtMQKCv172ASf00vC2JSznZ18ng
         F94YLnRsZShg47Yp37aZmnzprIPpJlZ02/l8yJBADWOpFIG0gCW/cxm0m66tv9dIhtgr
         0FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800712; x=1703405512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbQZZ67EiRiEqYh2CTsAlBEPPvOMdkhTkwDC7DgRYmM=;
        b=owvdGwXwQOf1dY9Cp56Ubog8b/0RzYuC9Lb2+0ol4wD6pfk+fTuzO1EYNxm28P1+eQ
         VW4pQoVq00ehBfiNt9OeacAW6Cthb8nFa+GJXnHUiWu7jv4WIwNvzwjuLphNhaYmvERq
         Kt1fLJb+ClVoTtu4tAGBh+GPmlFljYX8L7rIaY6u2E2Eu7mLg04NKr/oJgUGJ6lW+hBW
         I/PMvssPEB2x/65y5KtEC6ZTt50IJp2BruoWORXevqsPO26l9OUJlwFOEXZ7Pc3NW1WC
         On40JixJtmjWxODvpQBMMJEriLlGRHU9cRc1pwRrnzWiUJB7GRE23pt9Dp89ty7jDYtK
         EVxg==
X-Gm-Message-State: AOJu0YxINW9ZF5rcFsPbFcABKuEqwzVAVOpeKwAZzkQG+dbP0THz2IPa
	PRZ8HkWc1eNQbsoekBGvclxp6HwUF3Y=
X-Google-Smtp-Source: AGHT+IHY/lBmwHz45gkmSAoQbcPFGioBFYXwVWdf6wEHvP3W4/KP0jjTg0HZ6HsS6QdHb8SOI9bUUA==
X-Received: by 2002:a0d:d9d0:0:b0:5e5:3d3:4e97 with SMTP id b199-20020a0dd9d0000000b005e503d34e97mr1607435ywe.101.1702800711716;
        Sun, 17 Dec 2023 00:11:51 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:51 -0800 (PST)
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
Subject: [PATCH bpf-next v14 08/14] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Sun, 17 Dec 2023 00:11:25 -0800
Message-Id: <20231217081132.1025020-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
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
index 7ab00babcccc..d72a16adfbb3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1438,6 +1438,11 @@ union bpf_attr {
 		 */
 		__u64	map_extra;
 		__u32	map_token_fd;
+
+		__u32   value_type_btf_obj_fd;	/* fd pointing to a BTF
+						 * type data for
+						 * btf_vmlinux_value_type_id.
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index bda31cc3bab0..381175f97b25 100644
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
+	if (attr->value_type_btf_obj_fd) {
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
index 54a97c269e7a..935a0e209ac9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1128,7 +1128,7 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
+#define BPF_MAP_CREATE_LAST_FIELD value_type_btf_obj_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52c530b5733c..970b601ac2ba 100644
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
 
+	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
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
index 7ab00babcccc..d72a16adfbb3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1438,6 +1438,11 @@ union bpf_attr {
 		 */
 		__u64	map_extra;
 		__u32	map_token_fd;
+
+		__u32   value_type_btf_obj_fd;	/* fd pointing to a BTF
+						 * type data for
+						 * btf_vmlinux_value_type_id.
+						 */
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
-- 
2.34.1



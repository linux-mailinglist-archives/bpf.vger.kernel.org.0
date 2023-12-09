Return-Path: <bpf+bounces-17285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E07180B0FA
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7021BB20CCF
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F5938C;
	Sat,  9 Dec 2023 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7xacn01"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A9C1729
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:22 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d05ff42db0so24685497b3.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081641; x=1702686441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub9qoi3PTEGZNBq4TRs3aeMktswSheoGW49AGywpBTQ=;
        b=V7xacn01tLgZFAaTEc85s+ohGFiLaOjvvOkWbYgI/IzrM3rPkIoSx1LTP+aVwcbCHw
         rx0U905QilvIq+GelHsgcfJEqupncDh/YQ5fX8uuC3wQAgtCDFL2KZICjS4Ql8Hpixxc
         kKzwxHA2JhF4sto+wGsEGLNpA+A6XVhrtGcIjmuyFrAPJabKgKJRiYkLpkRfYRRlx4Hg
         d0o31jYSzbg+RESFROaLWUM80T6d5oetIRaUFWQCSlAtOuHpV6mScXAHQQclLWEUD5O4
         lHobCJKZuviR27jWdy9yPctC+nn7ynyjP5vAJNWltH5v6642+VH16J+z4e7PeF3K8mM6
         t8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081641; x=1702686441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ub9qoi3PTEGZNBq4TRs3aeMktswSheoGW49AGywpBTQ=;
        b=tSfq+WhgAj9e9KTcKy2pF014ZUyT87OKxw++94sekHM82sYB3C/xcqVVG99JCJcnWN
         8LrBc7gBYjIB0vGSINI+I0ewZ8lrxbdTnOyjsnVDnetkB8AjFQqBusa0+6EI0uTKk0oq
         3lGgaw8QzyhyZtVaVjRfdgUI0HxqJoEop8qBNac+8byH9OxxAu9hS1Nv6R+gYZQGo5LP
         6lSLiqAsW3fPQnnwMVJGGgfB3zk3EBTyA+AZ2PKNCT+gaXSoc1gR3q1NiwlYdVDNGVd8
         l2UuwMWH8DXVcZWIaAkFdQXaDnljESUekqBt2uEG1eR5T0Nijm8iv/Ft/20wyxoomnum
         1SEA==
X-Gm-Message-State: AOJu0YzybBhxgnvnvEV5nMy+/7QDsHuvtG7GkvQsBE+OtH9Lr6R044At
	Q/mD8JZCu1M2CKAhkg+igbJn1DEP7rvUgg==
X-Google-Smtp-Source: AGHT+IGJKpJZfW1G1bRUXimEFHHbwnp8/DBBrrJ2f06Tj4VDXOvLxKse9cb1canzuAEbIOSD4MBeQg==
X-Received: by 2002:a0d:d4d0:0:b0:5cc:dcf:47a4 with SMTP id w199-20020a0dd4d0000000b005cc0dcf47a4mr890301ywd.40.1702081641057;
        Fri, 08 Dec 2023 16:27:21 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:20 -0800 (PST)
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
Subject: [PATCH bpf-next v13 07/14] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Fri,  8 Dec 2023 16:27:02 -0800
Message-Id: <20231209002709.535966-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
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
 kernel/bpf/bpf_struct_ops.c    | 56 +++++++++++++++++++++++-----------
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          |  9 ++++--
 tools/include/uapi/linux/bpf.h |  5 +++
 5 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0545201b55f..5c3838a97554 100644
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
index ed4d84a8437c..f943f8378e76 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -641,6 +641,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	btf_put(st_map->btf);
 	bpf_map_area_free(st_map);
 }
 
@@ -681,15 +682,30 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
 
@@ -700,17 +716,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
@@ -719,24 +735,30 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
index aff045eed375..4aced7e58904 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1126,7 +1126,7 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
+#define BPF_MAP_CREATE_LAST_FIELD value_type_btf_obj_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6b45f56f8d4c..795c16f9cf57 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20070,6 +20070,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -20077,8 +20078,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
@@ -20095,8 +20098,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
index e0545201b55f..5c3838a97554 100644
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



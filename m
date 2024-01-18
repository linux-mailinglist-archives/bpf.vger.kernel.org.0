Return-Path: <bpf+bounces-19781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BEF831111
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92EBB24B45
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E2C8F59;
	Thu, 18 Jan 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXMCeZkc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051D6132
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542601; cv=none; b=CAddGDQfL2XbT3T0hCvh+tWAtS/ZjLLJ+xIcW67ZaS2pgk2r3yBgUlRCIRSG9MqkuzsvL/ua24PSX1R1Sq4OMl9FoxDwfaEbufjO/zAyoAjPTRM9uDPyPVe71crLsEvoUrfr+rhBePo2Nl66UCPKHzDpenc/U799/QcZbLR2gPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542601; c=relaxed/simple;
	bh=WvCkmgY55g8iBKkRmUDJdCrbZ5jw3c9lemvyV/n4qe8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=d2Jr+nyO8m4KFIf5jU2Z/joQVtMUwKBJksSU3gaFaNjNbVqUxhC93DbMnPAMfKBcemJrEGImLcBKWqu4hvclNIF1zbs6yE1DwDovm/y4rkqpC2BDkQJbECsXS2TcrpiUqy6Um9PUQUXP9WfYJ8er8MQfwmukxVbjtbPT4a+2gpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXMCeZkc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5eefd0da5c0so121718717b3.2
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542598; x=1706147398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBK9IYm2aHddPI6w+02qZMwThls/3Mjssq7z6W9IB2I=;
        b=JXMCeZkcY+wo/dhAFhxAx8yvqpz1mE2YkD0Xm1+QBCwVFA//LCiWYwAD/Y7/SPtFCO
         R9dyJOtna6f8ijkXbFZK38TCimL5BkuMv4/yOVM8cNrjY/kGZ00vB52yulFZUMMr8+hN
         FUd0M2Km27XzaYWCrsUQCxVwlQvlZyLiKAJPh3/G4E96FKJB+wAQHKGxWdeyu4yOCsju
         o2uhdm2fuH9aG1wd6G725E6NhCfZuwoHpoukTq+gvUz2h1FE09btTRzpGZXP2pzheuBJ
         8zrtFAI5SnonVx82dHsER1clxjbj8kQAKcgotoPrc8NtAYb+Nv2sP/Y3Rtsx7CvAkxiG
         kLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542598; x=1706147398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBK9IYm2aHddPI6w+02qZMwThls/3Mjssq7z6W9IB2I=;
        b=vl+IAQdN7aCZsc1NGespEkdezb9oeQJLbXoLENterpKjtsxvwAJ4SG5fw29knYg6dR
         TdO18DrlBAf5rUAe4QXfVVVMpMzMuQuNELh28Kwk09+y37bShOTaTXgfuiNHxjiaNTnV
         yozksog6gG+wuSIBA4eJO+3SAcyp1kUhAbnTYaDZGByzhxZDWbDHVuUeVBB2caLMKTg5
         fZIXD8tYSIaGsjmuNhN2mBk2svaCbmZVdplhy8B2l4JD+UzTq/qrbZZBrzN4ePhKcvax
         PrXi6fSYzDECcrkGLBlbY8R9H5jrR8NmM4KSIVDYTN4unZsTIzjohToNt7eg7uKCbHVE
         Uq7Q==
X-Gm-Message-State: AOJu0Yx9M49lZJJ1wle7GYNAjzOGWtHdxSmEeW1W4NrooP1NdlNpUMEA
	c9af6rl3CeWUuaf/Jr0BvPq47+Nrrk4+8E0hS34NXM5Ff/GNV2Zin4UV0Dr9
X-Google-Smtp-Source: AGHT+IHcYAGjH8WhxpzRiPhyUa4QW9vyIxsgdPAsKZ02R4o49qf/oGWe8mKMxx1Ca5Tq9l53awQ54w==
X-Received: by 2002:a81:6544:0:b0:5ff:48b2:9551 with SMTP id z65-20020a816544000000b005ff48b29551mr156407ywb.66.1705542598288;
        Wed, 17 Jan 2024 17:49:58 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:49:57 -0800 (PST)
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
Subject: [PATCH bpf-next v16 08/14] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Wed, 17 Jan 2024 17:49:24 -0800
Message-Id: <20240118014930.1992551-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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

A btf fd must be provided to the kernel for struct_ops maps and for the bpf
programs attached to those maps.

In the case of the bpf programs, the attach_btf_obj_fd parameter is passed
as part of the bpf_attr and is converted into a btf. This btf is then
stored in the prog->aux->attach_btf field. Here, it just let the verifier
access attach_btf directly.

In the case of struct_ops maps, a btf fd is passed as value_type_btf_obj_fd
of bpf_attr. The bpf_struct_ops_map_alloc() function converts the fd to a
btf and stores it as st_map->btf. A flag BPF_F_VTYPE_BTF_OBJ_FD is added
for map_flags to indicate that the value of value_type_btf_obj_fd is set.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/uapi/linux/bpf.h       |  8 +++++
 kernel/bpf/bpf_struct_ops.c    | 65 ++++++++++++++++++++++++----------
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          |  9 +++--
 tools/include/uapi/linux/bpf.h |  8 +++++
 5 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8eb949b52102..adb4dc8582f7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1330,6 +1330,9 @@ enum {
 
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		= (1U << 14),
+
+/* Flag for value_type_btf_obj_fd, the fd is available */
+	BPF_F_VTYPE_BTF_OBJ_FD	= (1U << 15),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1403,6 +1406,11 @@ union bpf_attr {
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
index 7505f515aac3..3b8d689ece5d 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -641,6 +641,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	btf_put(st_map->btf);
 	bpf_map_area_free(st_map);
 }
 
@@ -669,7 +670,8 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->key_size != sizeof(unsigned int) || attr->max_entries != 1 ||
-	    (attr->map_flags & ~BPF_F_LINK) || !attr->btf_vmlinux_value_type_id)
+	    (attr->map_flags & ~(BPF_F_LINK | BPF_F_VTYPE_BTF_OBJ_FD)) ||
+	    !attr->btf_vmlinux_value_type_id)
 		return -EINVAL;
 	return 0;
 }
@@ -681,15 +683,36 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
+	struct btf *btf;
 	int ret;
 
-	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
-	if (!st_ops_desc)
-		return ERR_PTR(-ENOTSUPP);
+	if (attr->map_flags & BPF_F_VTYPE_BTF_OBJ_FD) {
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
 
@@ -700,17 +723,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
@@ -719,24 +742,30 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
index 05fe78ecc441..00b294ce0a61 100644
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
index 0744a1f194fa..ff41f7736618 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20234,6 +20234,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -20241,8 +20242,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
@@ -20259,8 +20262,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
index 1949d881f230..7f64865bf455 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1330,6 +1330,9 @@ enum {
 
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		= (1U << 14),
+
+/* Flag for value_type_btf_obj_fd, the fd is available */
+	BPF_F_VTYPE_BTF_OBJ_FD	= (1U << 15),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1403,6 +1406,11 @@ union bpf_attr {
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



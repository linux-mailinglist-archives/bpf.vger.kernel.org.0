Return-Path: <bpf+bounces-14178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27D7E0C25
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BEB1C21147
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00B25106;
	Fri,  3 Nov 2023 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA9FJhR6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453F262A6
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 23:22:23 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B3B7
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:22:22 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5842ea6f4d5so1433261eaf.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 16:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053741; x=1699658541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMLmcQzRw+g3bs33c0PgnlIa2CJCu2fyueTsDXsP0lI=;
        b=QA9FJhR6mKVmgv7EoF6ZcW+4bLLQysKPkMEWrs5Yb8PgLyYGTAsMID9zjkeW3xDSJ4
         VF5LerWfKDpirNL2jXByUm+ZSoBetRk1SSOFEwKy5K4lOVNHgEN6uOBIiA6nKIrEs2Rl
         jaNgfJwBEnTOVSkBZa+x0a+3l6yOlXSFFPqFhrqy8/mM2RlhixMVcMVpPB2ISy1vcGOC
         oGDMx20Ccd/rSHKPMof3dIeI6j7urTGTRsFvAOfdjCKSUd4aS3pvhMN2RZCuPdkcF4xb
         SCYyRldQP/TuSiOrFBoyar0ogZM5/iacNe6Z9tqqK7uOiNujRP0PS0hFq6p9nnU2GcAo
         Ql0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053741; x=1699658541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMLmcQzRw+g3bs33c0PgnlIa2CJCu2fyueTsDXsP0lI=;
        b=hlrwxnsDoPqQPaSxGYEsRDH62RhmXJVJOijLAMGnm/FNMpSbmBcRVYioD6anmFEkWu
         VTb6h8HpiNnecJDLvimpwy9WcZDKVywfTbZXOweWC96JnGtETV7GGg4dNBAHm9QLxeu9
         fdeo1Nau68yPnIRHPiGTb8LaBmtiiFq9pnxpx9fw1bEIHkjOZgwLgdy/JFcBvARb/zZy
         tAGNf2rjup/ycFgwDpwUSeGHm3nqsNM+9msrr18zzyoVtKoUz+0moSjmywn+ExPb5FqA
         aJTqvtJggR+I2BnGoWkAZ68ZhgTAHHKWhoQJgfKntcEg09E3+g7k3gAEWhPTD77+1Csx
         pfcw==
X-Gm-Message-State: AOJu0YxtSDqUkWVSn8Nng97WSO1o82nuYWlnFufE6rnfUSnq6/yHHNuv
	3HBKqAywRapJ82zFjMFAN9MMmO2tx9g=
X-Google-Smtp-Source: AGHT+IF1avbY3Wcr6XIAzwFqiVXcprCGXfBoYGdztNjyqb6e4XlAmZU1y+IhCWDhJSzanWraUo+abw==
X-Received: by 2002:a4a:a787:0:b0:57b:92f2:1f64 with SMTP id l7-20020a4aa787000000b0057b92f21f64mr20258753oom.8.1699053741046;
        Fri, 03 Nov 2023 16:22:21 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:287:9d8c:4ad:9459])
        by smtp.gmail.com with ESMTPSA id 186-20020a4a14c3000000b0057b8baf00bbsm532288ood.22.2023.11.03.16.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:22:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v10 07/13] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Fri,  3 Nov 2023 16:21:56 -0700
Message-Id: <20231103232202.3664407-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103232202.3664407-1-thinker.li@gmail.com>
References: <20231103232202.3664407-1-thinker.li@gmail.com>
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
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/bpf_struct_ops.c    | 31 ++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          |  9 ++++++---
 tools/include/uapi/linux/bpf.h |  5 +++++
 5 files changed, 43 insertions(+), 9 deletions(-)

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
index 4ba6181ed1c4..8aaaa5121a56 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -635,6 +635,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	btf_put(st_map->btf);
 	bpf_map_area_free(st_map);
 }
 
@@ -675,11 +676,24 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
 	if (attr->value_size != vt->size)
@@ -697,6 +711,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (!st_map)
 		return ERR_PTR(-ENOMEM);
 
+	st_map->btf = btf;
 	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
@@ -725,13 +740,19 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-ENOMEM);
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



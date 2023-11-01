Return-Path: <bpf+bounces-13829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690977DE6DE
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D187281A1F
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7DD1A26B;
	Wed,  1 Nov 2023 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AepvU5qf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEF12E44
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:45:40 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335C010C
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 13:45:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so190011276.2
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871535; x=1699476335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tynuz0fgTYxbBl2yuhgxDz0ux4d0VWM4jwwcy6q2XJs=;
        b=AepvU5qfMlYUJk7gYCi2GsvJUL3nxzKe/l3SazJUUZwna6Ft4zOS0Akx8yNVkBPxEA
         o3GpYE5YFaZnGj+Z2llCI2jiFTLxVyTgqEY6drGATpQdy02w8+pLJVCmm718PiVD0vnt
         aDYHC5jT0Ia1h32EQLqaSUxkWd6mwMEUpz+dKLuqRXf0jobUUw5W5KtvUsd5u2lstqX6
         BGqKHx4T+f2k75MHVBC3uvEZL8HJU4JtDcEQ7zoIjqJCmELOmsXlpyH1+vFg2msln4dF
         PJQGPFikjA25dErszAfisG5nTv6/asnUAiSEtPB6S5jvGw9kMkuqPM1F0ZIufKYpTLUZ
         gAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871535; x=1699476335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tynuz0fgTYxbBl2yuhgxDz0ux4d0VWM4jwwcy6q2XJs=;
        b=TrIepU5E/Bb0fNdF//Codu2Rd1bPb90twarqLqzR7Q4bi4TvvBipwJgMd/8NUD2jXh
         c5TCsJxdBbOjUvK487sApypPZqoSZIsBeiolRQNYTquZ/5WR/faNM9dYWyzEQfXyb1u3
         3lVW3O4JDXr7b51Xjz/1Qlk+uielPZVxji5gU/379m0DAG3ObDODz9IV6WYL2C9W0/3H
         nZ6Rl7qOb5D03ZLZP84T1+4+V7ueKOemYpYupaI1hUOT1T8qJd+6mtVb0OOKyxAltrgI
         OLtMYue4jo4+vb4pSTsMNbfFCqLaX+ujwMrluxK+TfnCpL/vvlI4evt8aIgFqPMNtZvA
         XeXQ==
X-Gm-Message-State: AOJu0YwdM+JykHmDBwt30sHBz74DjxY9L6DzsN239fNBUsDROduxYHTn
	HKznEko5DU/oZ8w+zLWwJQ4ulBFOBDw=
X-Google-Smtp-Source: AGHT+IFBoFRWe+8Hr9tfdHnt86CYSlBrhrkp9+ROG2nfVxRAszjNcDu9yi8fQPfc0ZlLETm55J9ASw==
X-Received: by 2002:a25:e74b:0:b0:d9a:ee0c:d444 with SMTP id e72-20020a25e74b000000b00d9aee0cd444mr13546658ybh.43.1698871534784;
        Wed, 01 Nov 2023 13:45:34 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id o83-20020a25d756000000b00da086d6921fsm342386ybg.50.2023.11.01.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:45:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 08/12] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Wed,  1 Nov 2023 13:45:15 -0700
Message-Id: <20231101204519.677870-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101204519.677870-1-thinker.li@gmail.com>
References: <20231101204519.677870-1-thinker.li@gmail.com>
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
 include/linux/bpf_verifier.h   |  1 +
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/bpf_struct_ops.c    | 36 +++++++++++++++++++++++++---------
 kernel/bpf/syscall.c           |  2 +-
 kernel/bpf/verifier.c          | 19 +++++++++++++++---
 tools/include/uapi/linux/bpf.h |  5 +++++
 6 files changed, 55 insertions(+), 13 deletions(-)

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
index bc855b2ef97e..2d853431bf09 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -677,6 +677,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
+	btf_put(st_map->btf);
 	bpf_map_area_free(st_map);
 }
 
@@ -718,16 +719,31 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
@@ -750,6 +766,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		goto errout;
 	}
 
+	st_map->btf = btf;
 	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
@@ -776,8 +793,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		goto errout_free;
 	}
 
-	st_map->btf = btf_vmlinux;
-
 	mutex_init(&st_map->lock);
 	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
@@ -788,8 +803,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 
 errout_free:
 	__bpf_struct_ops_map_free(map);
+	btf = NULL;		/* has been released */
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
index bdd166cab977..20d6d9665983 100644
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
@@ -20111,8 +20122,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	member = &btf_type_member(t)[member_idx];
-	mname = btf_name_by_offset(btf_vmlinux, member->name_off);
-	func_proto = btf_type_resolve_func_ptr(btf_vmlinux, member->type,
+	mname = btf_name_by_offset(btf, member->name_off);
+	func_proto = btf_type_resolve_func_ptr(btf, member->type,
 					       NULL);
 	if (!func_proto) {
 		verbose(env, "attach to invalid member %s(@idx %u) of struct %s\n",
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



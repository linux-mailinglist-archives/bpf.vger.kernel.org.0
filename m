Return-Path: <bpf+bounces-16968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC37807E04
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC6928100E
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C64A33;
	Thu,  7 Dec 2023 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7mmgInD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30581A5
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:14 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5d34f8f211fso1689687b3.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913213; x=1702518013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzh1eQX9qmrl8ZPxxUEtcmZnUDxIGpXg8T7pQMr7Xc4=;
        b=g7mmgInDNuuB1LtOPzgiaZ5IU+6CMe/ei1Nedt8pOAe0G5LseqAl2X60ZUMawYfVkp
         gD/iAuBKRN3AMLAmYFMXQ2xraBhut7ulzcxQegsVWDqJ/8bhFwLHMisZeC6icv3IOzXS
         GSAaIMf9gw9h/UCs0F5DwJj2NzO/MbKlO17Pydq+6EL882iCv5Hm4VjOSpib0wWWq6Nq
         jyvr/X6PHvpg3lUyn01+wkFNcOcsPoxt4Oiw75kyQuoIAx9mJ2hJBIoYMmqbXUB0dwk1
         ZgqE9Up4IZ1FBjEohhvOOEVijOaZu1HRDh1K6dDkO85ykOPaxaHq8LnXZVvNlDWr/Y9a
         lgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913213; x=1702518013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzh1eQX9qmrl8ZPxxUEtcmZnUDxIGpXg8T7pQMr7Xc4=;
        b=oAgqNtqq2K5UzUtd6O57IEQSYFR8udmM7xcvy78lKk1+Dd/iiHPk3His764PT1oqkm
         qyaF319l/dIZWMa6Q0vZfPq/EGVNdFVBecOZTV3F2C4UouEe7QAcYLoKbWMhiSvWqcqW
         KupQKtqeBNC4H3DuhGVX7MKZThK9csBRDzsgMq+q00Q6vnNctCHX9JqDLpMXZcE29CKg
         i7DFQnE+pHalUxPfvEmKKzs143IpjL++w35pwWVCcqRIbJ1Xeey5obG5WTq7QaczGi8x
         aFEc2L5poyB2KW/QQM8iTUrbMEBvZae5ZlpZ5E0lSwRLZwg+Qc5MWctEjUZavmx1ioXm
         nMjA==
X-Gm-Message-State: AOJu0YzpQUMV2xUg+/+rdU0bHI41PJVts6Q4LHme2SiUwoD7OWtI/5CT
	wyvxWr80/gzQ4Y4qzs0E0i2bxN0jpXs=
X-Google-Smtp-Source: AGHT+IE2DH3xOko5XqayrkqJNoHpOQEXEbwJH7rNltnG5rZFzKwg0kPBrnfGE8zqk8yZ3Xw0HpiDAA==
X-Received: by 2002:a05:690c:c:b0:5d7:ca4a:b1e1 with SMTP id bc12-20020a05690c000c00b005d7ca4ab1e1mr2233409ywb.73.1701913213308;
        Wed, 06 Dec 2023 17:40:13 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:12 -0800 (PST)
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
Subject: [PATCH bpf-next v12 07/14] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Wed,  6 Dec 2023 17:39:43 -0800
Message-Id: <20231207013950.1689269-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207013950.1689269-1-thinker.li@gmail.com>
References: <20231207013950.1689269-1-thinker.li@gmail.com>
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
index e88746ba7d21..8e5a188e2883 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1401,6 +1401,11 @@ union bpf_attr {
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
index 123ec76c48a9..3f647df50504 100644
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
 
@@ -694,17 +710,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
 
 	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
 	if (!st_map->image) {
@@ -713,25 +729,31 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
 	set_vm_flush_reset_perms(st_map->image);
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
index 5e43ddd1b83f..6df7edc4b5e3 100644
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
index 405aeee608aa..fccdab9db9ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20012,6 +20012,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -20019,8 +20020,10 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
@@ -20037,8 +20040,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
index e88746ba7d21..8e5a188e2883 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1401,6 +1401,11 @@ union bpf_attr {
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



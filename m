Return-Path: <bpf+bounces-12930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B0B7D2114
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A65DB2102A
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1021C30;
	Sun, 22 Oct 2023 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdUAtTQT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38EC17E6
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 05:03:56 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499CE124
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:55 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7be88e9ccso23273347b3.2
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697951034; x=1698555834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFGNJIKyLlK+zlHfxbHJFmSQZeBqEpwSA0br+5DVEHY=;
        b=jdUAtTQTCPwYJOdL3WkwGc8EtVO5Fj72E+BvjmqWGxvRaeYwxGhNrcFFjULA52y86i
         bIj5IBylRUSQCKjoKB34iMKntKzkjty1yL64K+6azoK2Mz8428NjkVAoieGl0xX7NVhh
         ty0b2R0fjOv/B8kvzSlS4BDHIXczDpXDVr3dlHFrV53TmHrmp83gnog3shULDphNVtlo
         SeU77ZFNVekswAzsnQX0fiV6JO/PfpMMCVgL4PlgI2G0NAHEyubNgasVjKlXU6Czg98l
         dOjpPNBtz8iC8Hpv6sgermxEa6aCX01aci7S2N7Mrse7+X4iFPdEtJVgNgy6HOBLu4Yy
         AlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697951034; x=1698555834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFGNJIKyLlK+zlHfxbHJFmSQZeBqEpwSA0br+5DVEHY=;
        b=WX5rmmyVus6+2oesVl4fixS9dagnJR/hGg6kU5ygtfBnpPvcjE6pvV2FzkB+wmAsIH
         8Wn6usQeAUI5dGf/SOssbxcEmiAzz8RtrxgvCWLb0Q6Q1hap3cp7Cfy3eYG3tq0mvyf2
         d4agALltUJF15N0yUQao+WpO/ITrVGxayjZQ4dHzvIZtMNfKDzZNuweoi2QdXKHSOlg5
         qJHNblPhB0Ndq8gV/WndH0nGitBM6PIodnxGm7O+2lMkcYQLAyWlXRZbmeKTH1jRtVxT
         aI9WUrdhvd6jhQFHdI3KOqZMVTobqPd9AIMD+wwk92PQ6PmT9AZFD7sUxn435JkuV5BH
         Zotw==
X-Gm-Message-State: AOJu0YzlACljLsnkKtsSKqqJvblp7rWAa9vud3Q5OJjRECNf4UwrZ8H4
	C8L0QLxHruIBBPh2dwtBEw6kwujWGoA=
X-Google-Smtp-Source: AGHT+IF6oUD8YsvqbyuiUAe/96Tt6W67fpJ1QZaMxe51dioDKva+eFvv1nlW4BJQ5HIlcTVNMj4lXw==
X-Received: by 2002:a05:690c:d8f:b0:5a7:c92b:f49 with SMTP id da15-20020a05690c0d8f00b005a7c92b0f49mr7925507ywb.21.1697951034226;
        Sat, 21 Oct 2023 22:03:54 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9904:3214:88c1:e733])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b005a8c392f498sm2035169ywe.82.2023.10.21.22.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 22:03:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 06/10] bpf: pass attached BTF to the bpf_struct_ops subsystem
Date: Sat, 21 Oct 2023 22:03:31 -0700
Message-Id: <20231022050335.2579051-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022050335.2579051-1-thinker.li@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
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
index 94ec766432f5..5dc4d5fd8ab5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -579,6 +579,7 @@ struct bpf_verifier_env {
 	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	const struct bpf_verifier_ops *ops;
+	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 73b155e52204..b5ef22f65f35 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1390,6 +1390,11 @@ union bpf_attr {
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
index 6367d42b2ce1..99ab61cc6cad 100644
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
index 85c1d908f70f..5daf8a2c2bba 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1097,7 +1097,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	return ret;
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD value_type_btf_obj_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d0cf7289092..0289574bb0d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19624,6 +19624,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	u32 btf_id, member_idx;
+	struct btf *btf;
 	const char *mname;
 
 	if (!prog->gpl_compatible) {
@@ -19631,8 +19632,18 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
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
@@ -20343,6 +20354,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 73b155e52204..b5ef22f65f35 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1390,6 +1390,11 @@ union bpf_attr {
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



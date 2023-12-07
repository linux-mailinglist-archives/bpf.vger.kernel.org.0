Return-Path: <bpf+bounces-16967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9455807E05
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44BB1B211BD
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D24A31;
	Thu,  7 Dec 2023 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7FroJ9E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E4719E
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 17:40:15 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d7a47d06eeso1526457b3.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 17:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913214; x=1702518014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbVOw5h0fir9A8MFg94tjGMMlHhVgEs/pXv85NJPuIo=;
        b=W7FroJ9E5QxpnUZXtqFw/gi4ue20JPsfz3TDd9diEIxmRbNT1pGeRG1vu3QcEmBHHL
         K0dOKe75u3CBAd2gfSK5y5WU+rwoDTN3NgHmZeYV/SfUDvHdsWDWBScsDYWkWVBA0kD/
         3HkRplKogRFeGXJ8V5g+wUpk/YN9n0XNR30KjQBPnFTgBJI7s6Eq+QPqwPcEikXchGBZ
         tx7V3YsXrL2JjWTlbxrBGFw7q/gaPlp32TuZnbsjUxE/Mxc1nRw0UvRggINv00l9gcOJ
         mdRveOudcARFGuBZfTBKtvy90ZKXTcow14FhtFylUDaliQ9A6CguxXeP4aLQeziOKCO2
         jquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913214; x=1702518014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbVOw5h0fir9A8MFg94tjGMMlHhVgEs/pXv85NJPuIo=;
        b=wVYi4J7V4+Z3kchtIk0zuht1kyjqeKRXGKZMV1/Sry8b2ZSWHKiq74jX8B+NpO8fN/
         RBVwt35B13Qbd8s3qbSDKMpmSiFV9M7qlcFlC7o/y+T7otdm2oBxxkJOBOmlFqQms0k7
         sH7b0Du7V7t4I7DZSt99NEvVBC5/vkVwx/8SwIs4mkUSczHtufFcsdtNh1gwtKafYRIV
         QhkCG/zYxGx1tB3luorf/dPjRUjjEjhMPnMfWwFCqFzpCp+7YrI+N4C9MEmypBn4/D9U
         XCUG3YV4PDQl3K5FC5vetSpIB0vd+LBd5alOxicU9xmgK8ZGsmx1V1k0RYSl+dI2iiWj
         bc/Q==
X-Gm-Message-State: AOJu0YzIrUZ/k5ZzxI1Ur8KI6O+e89epsQsCFgNgl7goXnp6zsmRBh6d
	+xno+Un9AGM8Tyl37rzFGwrFdBOb7hQ=
X-Google-Smtp-Source: AGHT+IHNFX+OVYM33t81/6aRDPbunI+N7sjkrZqVm7Kn4ErashtZEf5IBSN84U+7Boawsp5uNgo4QA==
X-Received: by 2002:a81:b649:0:b0:5d7:1940:f3d3 with SMTP id h9-20020a81b649000000b005d71940f3d3mr1672735ywk.59.1701913214446;
        Wed, 06 Dec 2023 17:40:14 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:14 -0800 (PST)
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
Subject: [PATCH bpf-next v12 08/14] bpf: hold module for bpf_struct_ops_map.
Date: Wed,  6 Dec 2023 17:39:44 -0800
Message-Id: <20231207013950.1689269-9-thinker.li@gmail.com>
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

To ensure that a module remains accessible whenever a struct_ops object of
a struct_ops type provided by the module is still in use.

struct bpf_strct_ops_map doesn't hold a refcnt to btf anymore sicne a
module will hold a refcnt to it's btf already. But, struct_ops programs are
different. They hold their associated btf, not the module since they need
only btf to assure their types (signatures).

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/bpf_struct_ops.c  | 28 +++++++++++++++++++++++-----
 kernel/bpf/verifier.c        | 10 ++++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 59d26203f4d2..4cc2dfcd49e6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1634,6 +1634,7 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata);
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
+	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3378cc753061..353578e6cd24 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -619,6 +619,7 @@ struct bpf_verifier_env {
 	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	const struct bpf_verifier_ops *ops;
+	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 3f647df50504..8ff86529b829 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -635,12 +635,15 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 	}
 	bpf_map_area_free(st_map->uvalue);
-	btf_put(st_map->btf);
 	bpf_map_area_free(st_map);
 }
 
 static void bpf_struct_ops_map_free(struct bpf_map *map)
 {
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+
+	module_put(st_map->st_ops_desc->st_ops->owner);
+
 	/* The struct_ops's function may switch to another struct_ops.
 	 *
 	 * For example, bpf_tcp_cc_x->init() may switch to
@@ -675,6 +678,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	size_t st_map_size;
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
+	struct module *mod = NULL;
 	struct bpf_map *map;
 	struct btf *btf;
 	int ret;
@@ -684,10 +688,20 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
 		if (IS_ERR(btf))
 			return ERR_PTR(PTR_ERR(btf));
-	} else {
+
+		if (btf != btf_vmlinux) {
+			mod = btf_try_get_module(btf);
+			if (!mod) {
+				btf_put(btf);
+				return ERR_PTR(-EINVAL);
+			}
+		}
+		/* mod (NULL for btf_vmlinux) holds a refcnt to btf. We
+		 * don't need an extra refcnt here.
+		 */
+		btf_put(btf);
+	} else
 		btf = btf_vmlinux;
-		btf_get(btf);
-	}
 
 	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
 	if (!st_ops_desc) {
@@ -751,7 +765,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 errout_free:
 	__bpf_struct_ops_map_free(map);
 errout:
-	btf_put(btf);
+	module_put(mod);
 
 	return ERR_PTR(ret);
 }
@@ -881,6 +895,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
+	/* The old map is holding the refcount for the owner module.  The
+	 * ownership of the owner module refcount is going to be
+	 * transferred from the old map to the new map.
+	 */
 	if (!st_map->st_ops_desc->st_ops->update)
 		return -EOPNOTSUPP;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fccdab9db9ed..cb282979d689 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20021,6 +20021,14 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf = prog->aux->attach_btf;
+	if (btf != btf_vmlinux) {
+		/* Make sure st_ops is valid through the lifetime of env */
+		env->attach_btf_mod = btf_try_get_module(btf);
+		if (!env->attach_btf_mod) {
+			verbose(env, "owner module of btf is not found\n");
+			return -ENOTSUPP;
+		}
+	}
 
 	btf_id = prog->aux->attach_btf_id;
 	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
@@ -20735,6 +20743,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-- 
2.34.1



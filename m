Return-Path: <bpf+bounces-18450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBBE81A92C
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9A41C23081
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DC4A9A6;
	Wed, 20 Dec 2023 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktKX6H/m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEB4A99B
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e7f0bf46a2so2204027b3.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 14:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703111228; x=1703716028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4tvO/5rJ44Lnd64sswUe7tYxq9EPVeVJQovKpj3u2U=;
        b=ktKX6H/mnmDt1bwk93orsLcerRH1Ue4QkAgewvJr6Vq9xNTh5Rh7BHyk7hPnZiPRNj
         FoKybSBFqBlvpUw9C2M8GwZ00OpNoNEEZzZ+WJNrYOD6Aos7utzLabc2+k9d3Nih7Hb5
         BwcwRW+kBxocYf3VsnjScZdCMl4okJsM47rOXqdk+C91oIsV9MlsvFL0amqh6DLqsqOV
         DOeZaKIoYDwXOFkjpty4p5grJy0B/VYDNYUrHnNKLkLB1mKdA22vYIpio3DBD1vF5OJr
         QBWkfQQym4WrGlxF4KhD3hHFOB7vwNmF8KZfSGGBeA7kjRoScPvGvBDGTl5Rz0ETEbuJ
         VhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111228; x=1703716028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4tvO/5rJ44Lnd64sswUe7tYxq9EPVeVJQovKpj3u2U=;
        b=R6XN3ttNHlM/a+ncgS72QsAZl3fooq/8yUZWQy4D15xfV36TfU9e4Q/isWal/WNNRZ
         GjiG3Wzhld/Kj9aYML4r7XF5XcvYQPAZvkGWHOVuRa+9F+REW5KmIFfqfE03qwnNAh3L
         mWRlv4vkH5PoK+ym31yuIuHg06MkIPfwC4XNj/xNuiz2EBXdnxJQLe43htes2IVDnAY9
         NIpfERBgMDUd6wRxvZHvoEfAH34YytZ2um2jT+IKbLj/DWQzS4VJ7F4V6orFFXUFBJNW
         88iBILL31q9eH/SVA0mre15pi0oSgE9OlFglRjueJI1ngsFU3yLGeGEaMLaGw71/yOb8
         rujw==
X-Gm-Message-State: AOJu0Yyl+HPKr6IGJ2p7zxzyi5h0fMb18n3nl9/xrSECgw30AjNgpR1k
	4GUwF943Sc6jScA286g0rmSHY+wOisQ=
X-Google-Smtp-Source: AGHT+IEK5F17k9TlB3YkAi8TiKEj/jZATPtUixTFgTcKZBi3mpcw+OqvlP2sYO4HrBcnePQKA7W0Kw==
X-Received: by 2002:a81:7b04:0:b0:5d7:1941:3562 with SMTP id w4-20020a817b04000000b005d719413562mr467218ywc.73.1703111228347;
        Wed, 20 Dec 2023 14:27:08 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8cc1:afcb:3651:3dad])
        by smtp.gmail.com with ESMTPSA id m125-20020a0dfc83000000b005ca4e49bb54sm284304ywf.142.2023.12.20.14.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:27:08 -0800 (PST)
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
Subject: [PATCH bpf-next v15 09/14] bpf: hold module refcnt in bpf_struct_ops map creation and prog verification.
Date: Wed, 20 Dec 2023 14:26:49 -0800
Message-Id: <20231220222654.1435895-10-thinker.li@gmail.com>
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

To ensure that a module remains accessible whenever a struct_ops object of
a struct_ops type provided by the module is still in use.

struct bpf_struct_ops_map doesn't hold a refcnt to btf anymore since a
module will hold a refcnt to it's btf already. But, struct_ops programs are
different. They hold their associated btf, not the module since they need
only btf to assure their types (signatures).

However, verifier holds the refcnt of the associated module of a struct_ops
type temporarily when verify a struct_ops prog. Verifier needs the help
from the verifier operators (struct bpf_verifier_ops) provided by the owner
module to verify data access of a prog, provide information, and generate
code.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/bpf_struct_ops.c  | 24 +++++++++++++++++++++---
 kernel/bpf/verifier.c        | 10 ++++++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2e2463bcff76..a4e6b109e7f8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1673,6 +1673,7 @@ struct bpf_struct_ops {
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
 	void *cfi_stubs;
+	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d07d857ca67f..e6cf025c9446 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -662,6 +662,7 @@ struct bpf_verifier_env {
 	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	const struct bpf_verifier_ops *ops;
+	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 71cd433fc521..dd1107143e2e 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -641,12 +641,20 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
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
+	/* st_ops->owner was acquired during map_alloc to implicitly holds
+	 * the btf's refcnt. The acquire was only done when btf_is_module()
+	 * st_map->btf cannot be NULL here.
+	 */
+	if (btf_is_module(st_map->btf))
+		module_put(st_map->st_ops_desc->st_ops->owner);
+
 	/* The struct_ops's function may switch to another struct_ops.
 	 *
 	 * For example, bpf_tcp_cc_x->init() may switch to
@@ -681,6 +689,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	size_t st_map_size;
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
+	struct module *mod = NULL;
 	struct bpf_map *map;
 	struct btf *btf;
 	int ret;
@@ -694,11 +703,20 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 			btf_put(btf);
 			return ERR_PTR(-EINVAL);
 		}
+
+		mod = btf_try_get_module(btf);
+		if (!mod) {
+			btf_put(btf);
+			return ERR_PTR(-EINVAL);
+		}
+		/* mod holds a refcnt to btf. We don't need an extra refcnt
+		 * here.
+		 */
+		btf_put(btf);
 	} else {
 		btf = bpf_get_btf_vmlinux();
 		if (IS_ERR(btf))
 			return ERR_CAST(btf);
-		btf_get(btf);
 	}
 
 	st_ops_desc = bpf_struct_ops_find_value(btf, attr->btf_vmlinux_value_type_id);
@@ -762,7 +780,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 errout_free:
 	__bpf_struct_ops_map_free(map);
 errout:
-	btf_put(btf);
+	module_put(mod);
 
 	return ERR_PTR(ret);
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 822bb4f5e8a6..64a913e780d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20228,6 +20228,14 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf = prog->aux->attach_btf ?: bpf_get_btf_vmlinux();
+	if (btf_is_module(btf)) {
+		/* Make sure st_ops is valid through the lifetime of env */
+		env->attach_btf_mod = btf_try_get_module(btf);
+		if (!env->attach_btf_mod) {
+			verbose(env, "owner module of btf is not found\n");
+			return -ENOTSUPP;
+		}
+	}
 
 	btf_id = prog->aux->attach_btf_id;
 	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
@@ -20942,6 +20950,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-- 
2.34.1



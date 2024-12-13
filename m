Return-Path: <bpf+bounces-46841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD739F0CFA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B240F1666ED
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACF1DFE29;
	Fri, 13 Dec 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Ond9wLFr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126101DFD87
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095275; cv=none; b=rjQhaMhsp7vREPFGf7Ma2lFO0o7m5BhDnd+ceLsyglcaubN8wXiQxB2r/Dl4F6WoS5Z579PyCAapWmNzpJcr/0Kv+lp8cKgBkIYeAHuaUThevoaRqoODW5lpNBdkK8sWDvXCArR6GpemOXbKciylwQ3bjKlQVHTfBKtH3FFkQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095275; c=relaxed/simple;
	bh=kTLGhW3bqEENrMuivHE/2qFmq/CjLhZv1p9xbW7daCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDVKOVs3kRBxSQ1RmvIqKz3cN8cKMVs0yNxQQqIfa47kEUAeNGOlwgC3n9Xk+bAK9nYzvGEvIqM7VXJNBiNXyTNzBhsfIE+h5eCgjgav7LICDPswgSO3p0y0cqIhv5TsSYLV8OimrR/Ya5ln77hHcmmkDYs+kmw8MSV4qKYgOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Ond9wLFr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so3028962a12.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 05:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734095271; x=1734700071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mxb+DMYr5DGjp3aEnRXc1ObBa5yaQwm/LTOdY6lxoaA=;
        b=Ond9wLFr+N0Oxg8h/EtUIlnTsZv9Ryhz5Q9+L/Zv2FYyFHRmfsWMJ4jF5t2h3pPiCx
         a+QiwmZ4iGinuVdxuts36wMS+HVA7PEUy6opWXiVercdiJtwIi1NgY6N20r5oLa78oeL
         EgiW70UEp2H5PurKG667wKbVCDn0dMZYSCpW7PVblezSuVO9uYUYjENuneyWL1jwp9Pe
         i2lJ/DfOsDUhp7YfI9azQboTYiJzX16glTvG00D9XMoXULQ+/RyMtaix6aa5rMZOwJW3
         zRPVUnmSkCiM7g0G7Pftre0dVzNqNprQunAfLtjNqQGCqQqsX539EuNuLSYJL3juZam+
         Zkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095271; x=1734700071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mxb+DMYr5DGjp3aEnRXc1ObBa5yaQwm/LTOdY6lxoaA=;
        b=UM8JFyAwqNX0DaCm4gsgB0KlXH7zpYrodj9AwaBlxXsOTJjM23Ffwl7SgdVO0nlKkn
         e8rEqbY9ja9zVY8FWoLd0JLOVLcLm5kxNPJuSpyh9QFDR+q301x6wCUtRizEbLi2j4wd
         CVgC0idrobgT7jjbFUBH/08GA4j428NbPJdNGlu+OxSjqBTjZoy1qbr52itNqh/hDM61
         nxZlYJ2Qyzpov0crTm7eSDvXkhEP7rIpmdm6vVfez/Ut31QDS8EL+N19JTrYWvC428qt
         0Asc0xMpYn/y8eNsKgIdoYxvXSwBDYgcwS6jOKoA6vhEH0ZCGUio9vkPJWaTemiIvK2Q
         z66w==
X-Gm-Message-State: AOJu0YxzbN027SPt7H/e27Gi2kKkw8k7X/XYcCFo3RyzXxTPvAUXZpJ5
	/uwknLsLo0K66Nh95dxNMt35F9tfSWJ/xouBw0ttbB++7blMt1SXRxaIxaaDJPSOxVRqsl7xLM4
	W
X-Gm-Gg: ASbGncuqovNhYovMP2tbYF5g6u0+dcMiVK/nHl91eIdEzMaTq7Rc88M2pKcaKAyrgto
	0kPOMgbJPvANl1cYH2/nFGl25SQytI82Ygsg8SmSB2whUUKtHaEfHsP73/2mMN8ctaQUKmGLhC0
	p/58+1DxnNHTo1Wuha7b5D1bUxr3QC/rIY0bBCGRoCUOOADBqmMxA2hCovaZBXewRzzyntwvSF7
	T4RoLM+CiT34HuZmm+xCumyNQPP4OdHeSNOaWP8HumShTxNSs3TtAkQXXdnsubb/uayCw==
X-Google-Smtp-Source: AGHT+IEh/oU9xkT77tA8g60ggnZI/92EQ2umc/hCpjqJFDLpTdhamJGA+jpsw8nk00uF8NC1UKoRsg==
X-Received: by 2002:a17:907:7842:b0:aa6:18b6:310e with SMTP id a640c23a62f3a-aab77e7b2e5mr249511366b.38.1734095270628;
        Fri, 13 Dec 2024 05:07:50 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa657abb2fbsm931248666b.128.2024.12.13.05.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 05:07:49 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 bpf-next 3/7] bpf: refactor check_pseudo_btf_id
Date: Fri, 13 Dec 2024 13:09:30 +0000
Message-Id: <20241213130934.1087929-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213130934.1087929-1-aspsk@isovalent.com>
References: <20241213130934.1087929-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper to add btfs to the env->used_maps array. Use it
to simplify the check_pseudo_btf_id() function. This new helper will
also be re-used in a consequent patch.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/verifier.c | 132 ++++++++++++++++++++++++------------------
 1 file changed, 76 insertions(+), 56 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 89bba0de853f..296765ffbdc5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19218,50 +19218,68 @@ static int find_btf_percpu_datasec(struct btf *btf)
 	return -ENOENT;
 }
 
+/*
+ * Add btf to the used_btfs array and return the index. (If the btf was
+ * already added, then just return the index.) Upon successful insertion
+ * increase btf refcnt, and, if present, also refcount the corresponding
+ * kernel module.
+ */
+static int __add_used_btf(struct bpf_verifier_env *env, struct btf *btf)
+{
+	struct btf_mod_pair *btf_mod;
+	int i;
+
+	/* check whether we recorded this BTF (and maybe module) already */
+	for (i = 0; i < env->used_btf_cnt; i++)
+		if (env->used_btfs[i].btf == btf)
+			return i;
+
+	if (env->used_btf_cnt >= MAX_USED_BTFS)
+		return -E2BIG;
+
+	btf_get(btf);
+
+	btf_mod = &env->used_btfs[env->used_btf_cnt];
+	btf_mod->btf = btf;
+	btf_mod->module = NULL;
+
+	/* if we reference variables from kernel module, bump its refcount */
+	if (btf_is_module(btf)) {
+		btf_mod->module = btf_try_get_module(btf);
+		if (!btf_mod->module) {
+			btf_put(btf);
+			return -ENXIO;
+		}
+	}
+
+	return env->used_btf_cnt++;
+}
+
 /* replace pseudo btf_id with kernel symbol address */
-static int check_pseudo_btf_id(struct bpf_verifier_env *env,
-			       struct bpf_insn *insn,
-			       struct bpf_insn_aux_data *aux)
+static int __check_pseudo_btf_id(struct bpf_verifier_env *env,
+				 struct bpf_insn *insn,
+				 struct bpf_insn_aux_data *aux,
+				 struct btf *btf)
 {
 	const struct btf_var_secinfo *vsi;
 	const struct btf_type *datasec;
-	struct btf_mod_pair *btf_mod;
 	const struct btf_type *t;
 	const char *sym_name;
 	bool percpu = false;
 	u32 type, id = insn->imm;
-	struct btf *btf;
 	s32 datasec_id;
 	u64 addr;
-	int i, btf_fd, err;
-
-	btf_fd = insn[1].imm;
-	if (btf_fd) {
-		btf = btf_get_by_fd(btf_fd);
-		if (IS_ERR(btf)) {
-			verbose(env, "invalid module BTF object FD specified.\n");
-			return -EINVAL;
-		}
-	} else {
-		if (!btf_vmlinux) {
-			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
-			return -EINVAL;
-		}
-		btf = btf_vmlinux;
-		btf_get(btf);
-	}
+	int i;
 
 	t = btf_type_by_id(btf, id);
 	if (!t) {
 		verbose(env, "ldimm64 insn specifies invalid btf_id %d.\n", id);
-		err = -ENOENT;
-		goto err_put;
+		return -ENOENT;
 	}
 
 	if (!btf_type_is_var(t) && !btf_type_is_func(t)) {
 		verbose(env, "pseudo btf_id %d in ldimm64 isn't KIND_VAR or KIND_FUNC\n", id);
-		err = -EINVAL;
-		goto err_put;
+		return -EINVAL;
 	}
 
 	sym_name = btf_name_by_offset(btf, t->name_off);
@@ -19269,8 +19287,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	if (!addr) {
 		verbose(env, "ldimm64 failed to find the address for kernel symbol '%s'.\n",
 			sym_name);
-		err = -ENOENT;
-		goto err_put;
+		return -ENOENT;
 	}
 	insn[0].imm = (u32)addr;
 	insn[1].imm = addr >> 32;
@@ -19278,7 +19295,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	if (btf_type_is_func(t)) {
 		aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
 		aux->btf_var.mem_size = 0;
-		goto check_btf;
+		return 0;
 	}
 
 	datasec_id = find_btf_percpu_datasec(btf);
@@ -19309,8 +19326,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			tname = btf_name_by_offset(btf, t->name_off);
 			verbose(env, "ldimm64 unable to resolve the size of type '%s': %ld\n",
 				tname, PTR_ERR(ret));
-			err = -EINVAL;
-			goto err_put;
+			return -EINVAL;
 		}
 		aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
 		aux->btf_var.mem_size = tsize;
@@ -19319,39 +19335,43 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 		aux->btf_var.btf = btf;
 		aux->btf_var.btf_id = type;
 	}
-check_btf:
-	/* check whether we recorded this BTF (and maybe module) already */
-	for (i = 0; i < env->used_btf_cnt; i++) {
-		if (env->used_btfs[i].btf == btf) {
-			btf_put(btf);
-			return 0;
-		}
-	}
 
-	if (env->used_btf_cnt >= MAX_USED_BTFS) {
-		err = -E2BIG;
-		goto err_put;
-	}
+	return 0;
+}
 
-	btf_mod = &env->used_btfs[env->used_btf_cnt];
-	btf_mod->btf = btf;
-	btf_mod->module = NULL;
+static int check_pseudo_btf_id(struct bpf_verifier_env *env,
+			       struct bpf_insn *insn,
+			       struct bpf_insn_aux_data *aux)
+{
+	struct btf *btf;
+	int btf_fd;
+	int err;
 
-	/* if we reference variables from kernel module, bump its refcount */
-	if (btf_is_module(btf)) {
-		btf_mod->module = btf_try_get_module(btf);
-		if (!btf_mod->module) {
-			err = -ENXIO;
-			goto err_put;
+	btf_fd = insn[1].imm;
+	if (btf_fd) {
+		CLASS(fd, f)(btf_fd);
+
+		btf = __btf_get_by_fd(f);
+		if (IS_ERR(btf)) {
+			verbose(env, "invalid module BTF object FD specified.\n");
+			return -EINVAL;
 		}
+	} else {
+		if (!btf_vmlinux) {
+			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=y is specified in Kconfig.\n");
+			return -EINVAL;
+		}
+		btf = btf_vmlinux;
 	}
 
-	env->used_btf_cnt++;
+	err = __check_pseudo_btf_id(env, insn, aux, btf);
+	if (err)
+		return err;
 
+	err = __add_used_btf(env, btf);
+	if (err < 0)
+		return err;
 	return 0;
-err_put:
-	btf_put(btf);
-	return err;
 }
 
 static bool is_tracing_prog_type(enum bpf_prog_type type)
-- 
2.34.1



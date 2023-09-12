Return-Path: <bpf+bounces-9829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E897A79DCAD
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30A42826C3
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5966F14ABF;
	Tue, 12 Sep 2023 23:32:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489F1429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:22 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB210FF
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-99bdcade7fbso769046366b.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561540; x=1695166340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnInjG/GiUGZnd4FDblN9l9WbO13rPNJBMBFSUVUPls=;
        b=i0ygThk33J2tbEvT1QbJweiD5mBITQJ1ZVHAo2mIplBrPhuJ2l+imvO+w24yNe26Eh
         yIMq++2/dXxJ8A2rM75lwi6vxAvUnJY+c9Z7yQX00D5ldHDO9+4d2ZC30sXvdlf+CGEF
         Dd03e8L4Ku/1zeu80ZSM50vyZcLjjHwADeAJdWPr43i7PjdBc/drkSKt+ddgeatzDQH6
         Q/H8WuTu9ePGGCZKGBYoWYA5Hxi4H4Ll7iw/JqDfcBEy3NQg72xXkimnMU+iCKw/eOlj
         mT8NnQ+ZxFTDXKM4gzlpzWSKhBkl4VEthJGnnK3m/YDV5FhAhS7RTzV0+EofHvNmhVao
         2JAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561540; x=1695166340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnInjG/GiUGZnd4FDblN9l9WbO13rPNJBMBFSUVUPls=;
        b=wTP6g2ZzwizT1UPxt8L9MS0DyHqPFPE4y+2gjf+2lHu1JWXp0kLclYv/QPuFLI3K0V
         jgEvwU9xYu1iclmH0qA+AW/M5By5YMHJHs4t09W0vondxn+ZfZteCZwZHJeFjhGvZ05m
         u7+XRdbwER4q/rUHVjbTxg6+LQ0ySduTLWYeYfSNAo8rFsQ6Ptw/uxE4C/n6IJdL2McC
         zeVpy9dbpAYgAK4kqa4+EE6ErKZkj1i60C7EDuDnMviufCc+VzDfR7qU5BYYrmPf9B2I
         OxALZQaZ2AN66Lncckz1BiHwC4/ROlhG/KoKNebtWK5WMwsX+CZnAAeLNVZBDf1Sc8oq
         5VeA==
X-Gm-Message-State: AOJu0YyxyEPbvX451C9BCIy2Z7jTH0pg95pxfIS3NIN3ZIY4q5noz2LB
	wzHfogWfgLmJkEG+Y9LgPhpEAv8fvxIihw==
X-Google-Smtp-Source: AGHT+IEDHXBr49p4haN+dJO2ObWGfLaD+m2z1Tf5uRp0SZkey96d3yc65OaW5oacSsM9/ICs5oWmnw==
X-Received: by 2002:a17:907:7714:b0:9a9:e53d:5d59 with SMTP id kw20-20020a170907771400b009a9e53d5d59mr435155ejc.25.1694561539712;
        Tue, 12 Sep 2023 16:32:19 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id oy25-20020a170907105900b0099d0c0bb92bsm7430481ejb.80.2023.09.12.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 05/17] bpf: Refactor check_btf_func and split into two phases
Date: Wed, 13 Sep 2023 01:32:02 +0200
Message-ID: <20230912233214.1518551-6-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7961; i=memxor@gmail.com; h=from:subject; bh=E2xIvz5e13nheKE0OeG1Qehip8VtJjWYOdIDnjR2D4k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSs53rV+MnMc4PA1jYNqb6XVsGGNZe6U5n9o aLTEH/dMQKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rAAKCRBM4MiGSL8R ygMND/48xFUhIxLjOMH3fHgkL9Yz6jpiZphZy+Dzh67/gmjktFT49+F78I4pL8/AVYmmHk99p0Y FISoFsb9HV1RoRYAwmrzCbGZ4RQkqBf4QbC9QzIbH5B02UZcDv8+bUJwyBlYKkoLJVpoP+BxiL2 +Xny4s9DyL0Ci2k8eD6lPZHdn+6K8DssODR0aYE+On7QmkqxLGQ1LC50NlPLZdLhg9nlT/mG2ff L7MSWCEQRp+0rR3GtPSGCLZ3+jzCFLMBVw5czVrvb7HV8ohrFSklC6r6Kjjc/UGW5r5GfPC6ZPr ycOV7yGJ+IlYlHrqz56vdyHZvfaZWmohOT/odGWYaTS9RqY7J+/RJtsHpFdllqIBN1qI6hmwCB3 MIO5H/J6VuxwP3wTdkDsiuNMaLmFIKYFRRaM/3OjfENUAh0ouL1x5JirLGc+3oKS1KdP6QNYPBw 8oLiNrKVcas3aviiGBf8sr7S48D1RGN/vGxm2UZUHonZNQrZdYi3ZTaKCqV4QIuwfzf0/+oQrE+ MMmytdWitH/5L1GGO3nht2oFBM1UR3uIyfj5xPEvdTlgyqzzWi4Gy5p1Kv/Oem3dECrt7ckp8GI LvES+uakiLRidlcBW2IiE3bZ44GJzoysEiEKPmf4leHej1rz9XsdqyxYOoeqLHSATaDMrq5FtQp pW/gXqh8dkR2WGA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This patch splits the check_btf_info's check_btf_func check into two
separate phases.  The first phase sets up the BTF and prepares
func_info, but does not perform any validation of required invariants
for subprogs just yet. This is left to the second phase, which happens
where check_btf_info executes currently, and performs the line_info and
CO-RE relocation.

The reason to perform this split is to obtain the userspace supplied
func_info information before we perform the add_subprog call, where we
would now require finding and adding subprogs that may not have a
bpf_pseudo_call or bpf_pseudo_func instruction in the program.

We require this as we want to enable userspace to supply exception
callbacks that can override the default hidden subprogram generated by
the verifier (which performs a hardcoded action). In such a case, the
exception callback may never be referenced in an instruction, but will
still be suitably annotated (by way of BTF declaration tags). For
finding this exception callback, we would require the program's BTF
information, and the supplied func_info information which maps BTF type
IDs to subprograms.

Since the exception callback won't actually be referenced through
instructions, later checks in check_cfg and do_check_subprogs will not
verify the subprog. This means that add_subprog needs to add them in the
add_subprog_and_kfunc phase before we move forward, which is why the BTF
and func_info are required at that point.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 128 +++++++++++++++++++++++++++++++++---------
 1 file changed, 100 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9baa6f187b38..ec767ae08c2b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15115,20 +15115,18 @@ static int check_abnormal_return(struct bpf_verifier_env *env)
 #define MIN_BPF_FUNCINFO_SIZE	8
 #define MAX_FUNCINFO_REC_SIZE	252
 
-static int check_btf_func(struct bpf_verifier_env *env,
-			  const union bpf_attr *attr,
-			  bpfptr_t uattr)
+static int check_btf_func_early(struct bpf_verifier_env *env,
+				const union bpf_attr *attr,
+				bpfptr_t uattr)
 {
-	const struct btf_type *type, *func_proto, *ret_type;
-	u32 i, nfuncs, urec_size, min_size;
 	u32 krec_size = sizeof(struct bpf_func_info);
+	const struct btf_type *type, *func_proto;
+	u32 i, nfuncs, urec_size, min_size;
 	struct bpf_func_info *krecord;
-	struct bpf_func_info_aux *info_aux = NULL;
 	struct bpf_prog *prog;
 	const struct btf *btf;
-	bpfptr_t urecord;
 	u32 prev_offset = 0;
-	bool scalar_return;
+	bpfptr_t urecord;
 	int ret = -ENOMEM;
 
 	nfuncs = attr->func_info_cnt;
@@ -15138,11 +15136,6 @@ static int check_btf_func(struct bpf_verifier_env *env,
 		return 0;
 	}
 
-	if (nfuncs != env->subprog_cnt) {
-		verbose(env, "number of funcs in func_info doesn't match number of subprogs\n");
-		return -EINVAL;
-	}
-
 	urec_size = attr->func_info_rec_size;
 	if (urec_size < MIN_BPF_FUNCINFO_SIZE ||
 	    urec_size > MAX_FUNCINFO_REC_SIZE ||
@@ -15160,9 +15153,6 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!krecord)
 		return -ENOMEM;
-	info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL | __GFP_NOWARN);
-	if (!info_aux)
-		goto err_free;
 
 	for (i = 0; i < nfuncs; i++) {
 		ret = bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
@@ -15201,11 +15191,6 @@ static int check_btf_func(struct bpf_verifier_env *env,
 			goto err_free;
 		}
 
-		if (env->subprog_info[i].start != krecord[i].insn_off) {
-			verbose(env, "func_info BTF section doesn't match subprog layout in BPF program\n");
-			goto err_free;
-		}
-
 		/* check type_id */
 		type = btf_type_by_id(btf, krecord[i].type_id);
 		if (!type || !btf_type_is_func(type)) {
@@ -15213,12 +15198,80 @@ static int check_btf_func(struct bpf_verifier_env *env,
 				krecord[i].type_id);
 			goto err_free;
 		}
-		info_aux[i].linkage = BTF_INFO_VLEN(type->info);
 
 		func_proto = btf_type_by_id(btf, type->type);
 		if (unlikely(!func_proto || !btf_type_is_func_proto(func_proto)))
 			/* btf_func_check() already verified it during BTF load */
 			goto err_free;
+
+		prev_offset = krecord[i].insn_off;
+		bpfptr_add(&urecord, urec_size);
+	}
+
+	prog->aux->func_info = krecord;
+	prog->aux->func_info_cnt = nfuncs;
+	return 0;
+
+err_free:
+	kvfree(krecord);
+	return ret;
+}
+
+static int check_btf_func(struct bpf_verifier_env *env,
+			  const union bpf_attr *attr,
+			  bpfptr_t uattr)
+{
+	const struct btf_type *type, *func_proto, *ret_type;
+	u32 i, nfuncs, urec_size, min_size;
+	u32 krec_size = sizeof(struct bpf_func_info);
+	struct bpf_func_info *krecord;
+	struct bpf_func_info_aux *info_aux = NULL;
+	struct bpf_prog *prog;
+	const struct btf *btf;
+	bpfptr_t urecord;
+	u32 prev_offset = 0;
+	bool scalar_return;
+	int ret = -ENOMEM;
+
+	nfuncs = attr->func_info_cnt;
+	if (!nfuncs) {
+		if (check_abnormal_return(env))
+			return -EINVAL;
+		return 0;
+	}
+	if (nfuncs != env->subprog_cnt) {
+		verbose(env, "number of funcs in func_info doesn't match number of subprogs\n");
+		return -EINVAL;
+	}
+
+	urec_size = attr->func_info_rec_size;
+
+	prog = env->prog;
+	btf = prog->aux->btf;
+
+	urecord = make_bpfptr(attr->func_info, uattr.is_kernel);
+	min_size = min_t(u32, krec_size, urec_size);
+
+	krecord = prog->aux->func_info;
+	info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL | __GFP_NOWARN);
+	if (!info_aux)
+		return -ENOMEM;
+
+	for (i = 0; i < nfuncs; i++) {
+		/* check insn_off */
+		ret = -EINVAL;
+
+		if (env->subprog_info[i].start != krecord[i].insn_off) {
+			verbose(env, "func_info BTF section doesn't match subprog layout in BPF program\n");
+			goto err_free;
+		}
+
+		/* Already checked type_id */
+		type = btf_type_by_id(btf, krecord[i].type_id);
+		info_aux[i].linkage = BTF_INFO_VLEN(type->info);
+		/* Already checked func_proto */
+		func_proto = btf_type_by_id(btf, type->type);
+
 		ret_type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
 		scalar_return =
 			btf_type_is_small_int(ret_type) || btf_is_any_enum(ret_type);
@@ -15235,13 +15288,10 @@ static int check_btf_func(struct bpf_verifier_env *env,
 		bpfptr_add(&urecord, urec_size);
 	}
 
-	prog->aux->func_info = krecord;
-	prog->aux->func_info_cnt = nfuncs;
 	prog->aux->func_info_aux = info_aux;
 	return 0;
 
 err_free:
-	kvfree(krecord);
 	kfree(info_aux);
 	return ret;
 }
@@ -15459,9 +15509,9 @@ static int check_core_relo(struct bpf_verifier_env *env,
 	return err;
 }
 
-static int check_btf_info(struct bpf_verifier_env *env,
-			  const union bpf_attr *attr,
-			  bpfptr_t uattr)
+static int check_btf_info_early(struct bpf_verifier_env *env,
+				const union bpf_attr *attr,
+				bpfptr_t uattr)
 {
 	struct btf *btf;
 	int err;
@@ -15481,6 +15531,24 @@ static int check_btf_info(struct bpf_verifier_env *env,
 	}
 	env->prog->aux->btf = btf;
 
+	err = check_btf_func_early(env, attr, uattr);
+	if (err)
+		return err;
+	return 0;
+}
+
+static int check_btf_info(struct bpf_verifier_env *env,
+			  const union bpf_attr *attr,
+			  bpfptr_t uattr)
+{
+	int err;
+
+	if (!attr->func_info_cnt && !attr->line_info_cnt) {
+		if (check_abnormal_return(env))
+			return -EINVAL;
+		return 0;
+	}
+
 	err = check_btf_func(env, attr, uattr);
 	if (err)
 		return err;
@@ -19990,6 +20058,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!env->explored_states)
 		goto skip_full_check;
 
+	ret = check_btf_info_early(env, attr, uattr);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = add_subprog_and_kfunc(env);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.41.0



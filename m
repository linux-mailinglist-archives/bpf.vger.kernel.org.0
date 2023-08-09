Return-Path: <bpf+bounces-7337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE33775DFA
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8AF1C21148
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1D17FFD;
	Wed,  9 Aug 2023 11:42:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C017AAB
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:42:22 +0000 (UTC)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CBE1FEE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:42:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1bc6bfc4b58so20662635ad.1
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581341; x=1692186141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUvv6Os60HAuReQRcsxzrHCKFcspSZmwRcjvI8hvxp8=;
        b=IkyD973lEYKAyevTIVociX0nWWUTH/Rfm9u9Jqvc/oYX70Ky9W2bYWky0InQZg+e67
         2yq3ddxMQGYOovqL5fF02w5V+NOQroVC20C/oYAUqOUWH63znP8/YoCqwelvNoXWdye3
         U4gqKFPVAyWWXlJVGjWpoJE7+WLxXyrK7nBHuPk2d/V88++z4UsHiuKdDFncaLzklOnG
         76ZG+TaPxUjrcg/dn2msj++outMB9ff6gzTwP4jk/wa4104AjlnxrkB5woj+jZGQA+/x
         X9aqSqWb8/H5xLgUVdQorElVCDYsnUh/qAa9yakYUnjBPfGJReHNf2b0LOvYiNHRyG39
         1axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581341; x=1692186141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUvv6Os60HAuReQRcsxzrHCKFcspSZmwRcjvI8hvxp8=;
        b=W+LmnrvuGNPwQMZwgIlPJRrz2k1DIDheWX3FISAuNPB1ka5cizLRmxLyyJvuX5J9Z+
         M1bBvid/da1RbbgcUWtCpeWukkL4Xtj4d7Xh3EhCVJa7JanlmffwEaNvZf0JRkRjmsTk
         SYuMha9M9sBuvDKsMqC64zPsLw73hGeP9jQUAhqwaP+GoTFmzoxhpkW0ENIbbIqYlvEc
         8yE1vrhZbkszDf+UUJ3/SOU6SMj4vOguwlbNPXeQScUNreCBcXnHAfNBfbLEY2FMSADa
         jKcOjIrNYgyeZfh+FmL1pDGgPSZnnCHCqaO2s1HGZF/6RL7ufUUwYMKSvV2lnA3fDUE+
         3nRg==
X-Gm-Message-State: AOJu0Yw5Ps5BswITVNpZhAwBlG27+huhwRjSPJMtFZ1ILGE7kzun8gLR
	ApKX4+yRuU8bsKdplC9WC+z4TAAPY91S9MnHQkY=
X-Google-Smtp-Source: AGHT+IEsUS89Z0GXi81R35KMMZFHS7hoF0cRZ6m22BQn85vmBu0AABhcd1wkLL85xvpZ2x3wlsdMVA==
X-Received: by 2002:a17:902:ec8a:b0:1b9:dea2:800f with SMTP id x10-20020a170902ec8a00b001b9dea2800fmr2817335plg.8.1691581340606;
        Wed, 09 Aug 2023 04:42:20 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709029b8500b001b8943b37a5sm10952157plp.24.2023.08.09.04.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:42:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 04/14] bpf: Refactor check_btf_func and split into two phases
Date: Wed,  9 Aug 2023 17:11:06 +0530
Message-ID: <20230809114116.3216687-5-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7961; i=memxor@gmail.com; h=from:subject; bh=s6wIRf1n0bide5l//ymRv094SUp/1VDFnOriLs97C6A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rImXWteajf3kSbJfQM+5x6N6GGf6Blgn1kv kZVboOnTEyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yAAKCRBM4MiGSL8R yvJrD/0bu2R8j+IHn+t3fh0XsWVVL70OLAfn0/iPQk37RfXu6FiI84YvXmQAUrqbv640K+k+/LQ qnvmPqw4+6Uu0IZLDaTl1b5jGhBv+s+4lWgGwTJLacHEopsbr4IMfzUeiCtPnZyQbFV0qRdK9sc IqhTVmyTpl9WXqVEftbHlxijClvKLcUpM790WyR9hrvXLrFiuFeRgRmonLfaqZf3Z+NejABYPQi RLBOFCthUqe1D1uUYOVEJ1YDJJOv4OCrGf7trAyQkHnIQ2WIXoaVKrq4MnFZPQSzQ5zGZyQHHcP VQYnQEy9pGpFgXrZztdUq7A1Rbq77z6zwiNGgp+jlHl3iRKSHQqZDe6oYmcg/Foa5eIUqOh1Sjt XgSITRlagP3DI9ID/n0Dh+ZfEhlwFZUo1f33rZlqvhcDqsu8L1Rrq4X69a1dGcyBySzkg66Mo1F 1j/Um29ZFUa/qNAjENKa3ULqdKUNzO8+Y2fu0dceHXScMiwAdbUezYQhN2lktlSHt8R5aBhN856 DcmWqT8WFOQMFI45fLoTxZ63QgGYW7P4QIjNIscl9gwTfaUMrv7dsaUszJPW6/l8aXNdxEiAfPB P622VDlQ3XNU7kygY2zbw7aJgr2+O6m719dOO2HQR0YRZ19T2pP8SDfgppYrGxFue8RweDiwOvm edbKQG/HcFa6UQg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 2ac0be088dd5..d0f6c984272b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15013,20 +15013,18 @@ static int check_abnormal_return(struct bpf_verifier_env *env)
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
@@ -15036,11 +15034,6 @@ static int check_btf_func(struct bpf_verifier_env *env,
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
@@ -15058,9 +15051,6 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	krecord = kvcalloc(nfuncs, krec_size, GFP_KERNEL | __GFP_NOWARN);
 	if (!krecord)
 		return -ENOMEM;
-	info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL | __GFP_NOWARN);
-	if (!info_aux)
-		goto err_free;
 
 	for (i = 0; i < nfuncs; i++) {
 		ret = bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
@@ -15099,11 +15089,6 @@ static int check_btf_func(struct bpf_verifier_env *env,
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
@@ -15111,12 +15096,80 @@ static int check_btf_func(struct bpf_verifier_env *env,
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
@@ -15133,13 +15186,10 @@ static int check_btf_func(struct bpf_verifier_env *env,
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
@@ -15357,9 +15407,9 @@ static int check_core_relo(struct bpf_verifier_env *env,
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
@@ -15379,6 +15429,24 @@ static int check_btf_info(struct bpf_verifier_env *env,
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
@@ -19842,6 +19910,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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



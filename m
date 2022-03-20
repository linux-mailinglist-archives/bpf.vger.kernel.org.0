Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C54E1C66
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbiCTP5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbiCTP5D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:57:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9E054188
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d18so10791755plr.6
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhcosv2Yhs3ivJRhHYG6HNFk8rBMBV1CSROMY3Yepw0=;
        b=c3l48mnTc/lNGdTzF5UUp9HfkxOHhnAVt+6FpAv3zGuG3W82wjX2EUlkH8Nu0MawfK
         k3CtL17ZCNPy9CZjXl9bIYzl+QVuHQF2Y33ZYZBz9gGxrmHH2TgEMLsyxU9JtAdD/XoL
         TgQX+3ckd/nm92ZNB1mMs+NnN+V7Tta6fP+6cYf5eVYilibGrSrHFoBlpzgEH9CFDOhU
         6HSsY2197a8YSPQMSJ7LFgN+IYvTrmhC04Ri8BO5MFTaO32F1eqLwPFWo4iiSrxMILes
         gZjnzqObj2IwvYluz16FzDhHAMdAyDAafqHTGAL8fszMZkoxwCKg1KWywuj/+QpPDDGQ
         BgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhcosv2Yhs3ivJRhHYG6HNFk8rBMBV1CSROMY3Yepw0=;
        b=KYYiF5mn4lbNGT4qOvD1rzdF9hfbANOpt5/JN23FlSlEdiuCTeVxsIblTM2HscI0iq
         FqX+qbQvR9PXMVrJG8ifjJvikly+vFCYufiITAt14Vw52nZ+4liqfkvU70ogLf8ntpiv
         VILU/Nhd9Vs9v7BtVOTh089+f9IFEyKSiQgzufwM3uHP44TKeqjU9lHD1de3gDMGoAIu
         1sqn8i1h+qjSs6JOqB7PAkh3DpA7gqezqA55+iJ6L+UFfktIhQ5oMrr5OSv2F/ztoJ+E
         huPMvwGWKRf5Ar3lkyCHMsVs8/YbybP5I2aS5LRMBPyOVCUXts7+4UIOoxxTX1qYIkUp
         V60Q==
X-Gm-Message-State: AOAM531QyTgAHzQt3GkKjdtzPpms9Gy36hRakB0Kd79enQA6fP1kyD9M
        hc/kmCP4shyFBmp05d0YCbrJgD0xnE8=
X-Google-Smtp-Source: ABdhPJzuyU7Tx+d0kBSi/AR8n9ZNxuu1xE3wR/U6J7zU7z1x6lL1y67OY7Uk3strgDo9iGJCEEdLHQ==
X-Received: by 2002:a17:902:e889:b0:151:a56d:eb8f with SMTP id w9-20020a170902e88900b00151a56deb8fmr8694194plg.142.1647791737273;
        Sun, 20 Mar 2022 08:55:37 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id o24-20020a17090a5b1800b001c6aaafa5fbsm7209763pji.24.2022.03.20.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:37 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 05/13] bpf: Allow storing referenced kptr in map
Date:   Sun, 20 Mar 2022 21:25:02 +0530
Message-Id: <20220320155510.671497-6-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320155510.671497-1-memxor@gmail.com>
References: <20220320155510.671497-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18542; h=from:subject; bh=ikKDWsO8n1tQZ31MblSQi8BLHzBlR9gwzkSc8pPnxy8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00ysVXL0rnNPMacyQt7R6X5gQzrTMUGZEGab5tH vhcX+5aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMgAKCRBM4MiGSL8RyjFtEA Cz5kaAwUdtx6Vw7/IL0mEhWymyYeNhVVTl3F0mRNT2pgnP7wgwfLROWIRmUbvMbhqb0CXIGhuzCjBk wDSk8lmzr675vUuBCPzBaRNT+AKocNfw444b2YuRJnJjPEoXSBq3qTrzGCr9zW+gxTuSA6SHKOYRuR /CJn+8mJ4euhArWkRjIEoVBqFrWjah2VCtKSIGH7Dh3ZzapClYiakUN4vakMzjh8fNA2Pcm8rowfKL pT1OnP0L1fDt3jm+VKP+Dg4RM3P/q9Woe7uKGE3iVc1/lkUwa382wstMYSX01c7EsSjusiZW3gv7mF 33hMOVYD7Aj8Sxod29WDN/ga8FNWAPuNpG80Ke9GXjdduqtKYGW0kaVHdXeohCad5a65oUYjMU9GX7 YmJ4P80oy0K2Ko4AOYDmPMLOdzH114fLepR+PP1lpHnaZQOlT0CCjxCKEHIOPEYujtHLz69AzzzudM gIbGbsstbxfLHfpffvhiFDEPPpiMHq02KgW0mZ22bzWpKxlD/p2igkp5KGp0OfwLRM2ly+NRQSTr+M 74FXVv51fojWG0ph4of4tHEKCsvgBQC3gZJ4vvkiM2eU1q3BAKka26Yxd6Dkt6mr3xMCWfb/3WmHZo gVj+nkuZYk9oXlh/JlCsRCou+qZKPQs6HVAnul4jBSkV2xG1wHMd/oBHrRvA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extending the code in previous commit, introduce referenced kptr
support, which needs to be tagged using 'kptr_ref' tag instead. Unlike
unreferenced kptr, referenced kptr have a lot more restrictions. In
addition to the type matching, only a newly introduced bpf_kptr_xchg
helper is allowed to modify the map value at that offset. This transfers
the referenced pointer being stored into the map, releasing the
references state for the program, and returning the old value and
creating new reference state for the returned pointer.

Similar to unreferenced pointer case, return value for this case will
also be PTR_TO_BTF_ID_OR_NULL. The reference for the returned pointer
must either be eventually released by calling the corresponding release
function, otherwise it must be transferred into another map.

It is also allowed to call bpf_kptr_xchg with a NULL pointer, to clear
the value, and obtain the old value if any.

BPF_LDX, BPF_STX, and BPF_ST cannot access referenced kptr. A future
commit will permit using BPF_LDX for such pointers, but attempt at
making it safe, since the lifetime of object won't be guaranteed.

There are valid reasons to enforce the restriction of permitting only
bpf_kptr_xchg to operate on referenced kptr. The pointer value must be
consistent in face of concurrent modification, and any prior values
contained in the map must also be released before a new one is moved
into the map. To ensure proper transfer of this ownership, bpf_kptr_xchg
returns the old value, which the verifier would require the user to
either free or move into another map, and releases the reference held
for the pointer being moved in.

In the future, direct BPF_XCHG instruction may also be permitted to work
like bpf_kptr_xchg helper.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |   7 ++
 include/uapi/linux/bpf.h       |  12 ++++
 kernel/bpf/btf.c               |  11 ++-
 kernel/bpf/helpers.c           |  22 ++++++
 kernel/bpf/verifier.c          | 128 ++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |  12 ++++
 6 files changed, 175 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 48ddde854d67..6814e4885fab 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -160,10 +160,15 @@ enum {
 	BPF_MAP_VALUE_OFF_MAX = 8,
 };
 
+enum {
+	BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
+};
+
 struct bpf_map_value_off_desc {
 	u32 offset;
 	u32 btf_id;
 	struct btf *btf;
+	int flags;
 };
 
 struct bpf_map_value_off {
@@ -413,6 +418,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_STACK,	/* pointer to stack */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
+	ARG_PTR_TO_KPTR,	/* pointer to kptr */
 	__BPF_ARG_TYPE_MAX,
 
 	/* Extended arg_types. */
@@ -422,6 +428,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
 	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
 	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
+	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7604e7d5438f..b4e89da75d77 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5143,6 +5143,17 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * void *bpf_kptr_xchg(void *map_value, void *ptr)
+ *	Description
+ *		Exchange kptr at pointer *map_value* with *ptr*, and return the
+ *		old value. *ptr* can be NULL, otherwise it must be a referenced
+ *		pointer which will be released when this helper is called.
+ *	Return
+ *		The old value of kptr (which can be NULL). The returned pointer
+ *		if not NULL, is a reference which must be released using its
+ *		corresponding release function, or moved into a BPF map before
+ *		program exit.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5339,6 +5350,7 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(kptr_xchg),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 92afbec0a887..e36ad26a5a6e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3175,6 +3175,7 @@ enum {
 struct btf_field_info {
 	const struct btf_type *type;
 	u32 off;
+	int flags;
 };
 
 static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
@@ -3191,6 +3192,8 @@ static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t
 static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 			       u32 off, int sz, struct btf_field_info *info)
 {
+	int flags;
+
 	/* For PTR, sz is always == 8 */
 	if (!btf_type_is_ptr(t))
 		return BTF_FIELD_IGNORE;
@@ -3201,7 +3204,11 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 	/* Reject extra tags */
 	if (btf_type_is_type_tag(btf_type_by_id(btf, t->type)))
 		return -EINVAL;
-	if (strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
+	if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
+		flags = 0;
+	else if (!strcmp("kptr_ref", __btf_name_by_offset(btf, t->name_off)))
+		flags = BPF_MAP_VALUE_OFF_F_REF;
+	else
 		return -EINVAL;
 
 	/* Get the base type */
@@ -3213,6 +3220,7 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 
 	info->type = t;
 	info->off = off;
+	info->flags = flags;
 	return BTF_FIELD_FOUND;
 }
 
@@ -3415,6 +3423,7 @@ struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
 		tab->off[i].offset = info_arr[i].off;
 		tab->off[i].btf_id = id;
 		tab->off[i].btf = off_btf;
+		tab->off[i].flags = info_arr[i].flags;
 		tab->nr_off = i + 1;
 	}
 	return tab;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 315053ef6a75..2e95f94d4efa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1374,6 +1374,26 @@ void bpf_timer_cancel_and_free(void *val)
 	kfree(t);
 }
 
+BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
+{
+	unsigned long *kptr = map_value;
+
+	return xchg(kptr, (unsigned long)ptr);
+}
+
+static u32 bpf_kptr_xchg_btf_id;
+
+const struct bpf_func_proto bpf_kptr_xchg_proto = {
+	.func         = bpf_kptr_xchg,
+	.gpl_only     = false,
+	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_btf_id   = &bpf_kptr_xchg_btf_id,
+	.arg1_type    = ARG_PTR_TO_KPTR,
+	.arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg2_btf_id  = &bpf_kptr_xchg_btf_id,
+	.arg2_release = true,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1452,6 +1472,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_timer_start_proto;
 	case BPF_FUNC_timer_cancel:
 		return &bpf_timer_cancel_proto;
+	case BPF_FUNC_kptr_xchg:
+		return &bpf_kptr_xchg_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b8cd34607215..f731a0b45acb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -258,6 +258,7 @@ struct bpf_call_arg_meta {
 	struct btf *ret_btf;
 	u32 ret_btf_id;
 	u32 subprogno;
+	struct bpf_map_value_off_desc *kptr_off_desc;
 };
 
 struct btf *btf_vmlinux;
@@ -480,7 +481,8 @@ static bool is_release_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_sk_release ||
 	       func_id == BPF_FUNC_ringbuf_submit ||
-	       func_id == BPF_FUNC_ringbuf_discard;
+	       func_id == BPF_FUNC_ringbuf_discard ||
+	       func_id == BPF_FUNC_kptr_xchg;
 }
 
 static bool may_be_acquire_function(enum bpf_func_id func_id)
@@ -500,7 +502,8 @@ static bool is_acquire_function(enum bpf_func_id func_id,
 	if (func_id == BPF_FUNC_sk_lookup_tcp ||
 	    func_id == BPF_FUNC_sk_lookup_udp ||
 	    func_id == BPF_FUNC_skc_lookup_tcp ||
-	    func_id == BPF_FUNC_ringbuf_reserve)
+	    func_id == BPF_FUNC_ringbuf_reserve ||
+	    func_id == BPF_FUNC_kptr_xchg)
 		return true;
 
 	if (func_id == BPF_FUNC_map_lookup_elem &&
@@ -3510,10 +3513,12 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 
 static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       struct bpf_map_value_off_desc *off_desc,
-			       struct bpf_reg_state *reg, u32 regno)
+			       struct bpf_reg_state *reg, u32 regno,
+			       bool ref_ptr)
 {
 	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
 	const char *reg_name = "";
+	bool fixed_off_ok = true;
 
 	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
 		goto bad_type;
@@ -3525,7 +3530,26 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
 	reg_name = kernel_type_name(reg->btf, reg->btf_id);
 
-	if (__check_ptr_off_reg(env, reg, regno, true))
+	if (ref_ptr) {
+		if (!reg->ref_obj_id) {
+			verbose(env, "R%d must be referenced %s%s\n", regno,
+				reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+			return -EACCES;
+		}
+		/* reg->off can be used to store pointer to a certain type formed by
+		 * incrementing pointer of a parent structure the object is embedded in,
+		 * e.g. map may expect unreferenced struct path *, and user should be
+		 * allowed a store using &file->f_path. However, in the case of
+		 * referenced pointer, we cannot do this, because the reference is only
+		 * for the parent structure, not its embedded object(s), and because
+		 * the transfer of ownership happens for the original pointer to and
+		 * from the map (before its eventual release).
+		 */
+		if (reg->off)
+			fixed_off_ok = false;
+	}
+	/* var_off is rejected by __check_ptr_off_reg for PTR_TO_BTF_ID */
+	if (__check_ptr_off_reg(env, reg, regno, fixed_off_ok))
 		return -EACCES;
 
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
@@ -3568,6 +3592,12 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	if (BPF_MODE(insn->code) != BPF_MEM)
 		goto end;
 
+	/* We cannot directly access kptr_ref */
+	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF) {
+		verbose(env, "accessing referenced kptr disallowed\n");
+		return -EACCES;
+	}
+
 	if (class == BPF_LDX) {
 		val_reg = reg_state(env, value_regno);
 		/* We can simply mark the value_regno receiving the pointer
@@ -3579,7 +3609,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
 		if (!register_is_null(val_reg) &&
-		    map_kptr_match_type(env, off_desc, val_reg, value_regno))
+		    map_kptr_match_type(env, off_desc, val_reg, value_regno, false))
 			return -EACCES;
 	} else if (class == BPF_ST) {
 		if (insn->imm) {
@@ -5255,6 +5285,59 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+static int process_kptr_func(struct bpf_verifier_env *env, int regno,
+			     struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_map_value_off_desc *off_desc;
+	struct bpf_map *map_ptr = reg->map_ptr;
+	u32 kptr_off;
+	int ret;
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env,
+			"R%d doesn't have constant offset. kptr has to be at the constant offset\n",
+			regno);
+		return -EINVAL;
+	}
+	if (!map_ptr->btf) {
+		verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
+			map_ptr->name);
+		return -EINVAL;
+	}
+	if (!map_value_has_kptr(map_ptr)) {
+		ret = PTR_ERR(map_ptr->kptr_off_tab);
+		if (ret == -E2BIG)
+			verbose(env, "map '%s' has more than %d kptr\n", map_ptr->name,
+				BPF_MAP_VALUE_OFF_MAX);
+		else if (ret == -EEXIST)
+			verbose(env, "map '%s' has repeating kptr BTF tags\n", map_ptr->name);
+		else
+			verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
+		return -EINVAL;
+	}
+
+	meta->map_ptr = map_ptr;
+	/* Check access for BPF_WRITE */
+	meta->raw_mode = true;
+	ret = check_helper_mem_access(env, regno, sizeof(u64), false, meta);
+	if (ret < 0)
+		return ret;
+
+	kptr_off = reg->off + reg->var_off.value;
+	off_desc = bpf_map_kptr_off_contains(map_ptr, kptr_off);
+	if (!off_desc) {
+		verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
+		return -EACCES;
+	}
+	if (!(off_desc->flags & BPF_MAP_VALUE_OFF_F_REF)) {
+		verbose(env, "off=%d kptr isn't referenced kptr\n", kptr_off);
+		return -EACCES;
+	}
+	meta->kptr_off_desc = off_desc;
+	return 0;
+}
+
 static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
 {
 	return base_type(type) == ARG_PTR_TO_MEM ||
@@ -5390,6 +5473,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
 
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
@@ -5417,11 +5501,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
 	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		= &timer_types,
+	[ARG_PTR_TO_KPTR]		= &kptr_types,
 };
 
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			  enum bpf_arg_type arg_type,
-			  const u32 *arg_btf_id)
+			  const u32 *arg_btf_id,
+			  struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	enum bpf_reg_type expected, type = reg->type;
@@ -5474,8 +5560,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			arg_btf_id = compatible->btf_id;
 		}
 
-		if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
-					  btf_vmlinux, *arg_btf_id)) {
+		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno, true))
+				return -EACCES;
+		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
+						 btf_vmlinux, *arg_btf_id)) {
 			verbose(env, "R%d is of type %s but %s is expected\n",
 				regno, kernel_type_name(reg->btf, reg->btf_id),
 				kernel_type_name(btf_vmlinux, *arg_btf_id));
@@ -5585,7 +5674,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		goto skip_type_check;
 
-	err = check_reg_type(env, regno, arg_type, fn->arg_btf_id[arg]);
+	err = check_reg_type(env, regno, arg_type, fn->arg_btf_id[arg], meta);
 	if (err)
 		return err;
 
@@ -5750,6 +5839,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "string is not zero-terminated\n");
 			return -EINVAL;
 		}
+	} else if (arg_type == ARG_PTR_TO_KPTR) {
+		if (process_kptr_func(env, regno, meta))
+			return -EACCES;
 	}
 
 	return err;
@@ -6092,10 +6184,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (fn->arg_type[i] == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
 			return false;
 
-		if (fn->arg_type[i] != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i])
+		if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i])
 			return false;
 	}
 
@@ -6979,21 +7071,25 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
 		}
 	} else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
+		struct btf *ret_btf;
 		int ret_btf_id;
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
-		ret_btf_id = *fn->ret_btf_id;
+		if (func_id == BPF_FUNC_kptr_xchg) {
+			ret_btf = meta.kptr_off_desc->btf;
+			ret_btf_id = meta.kptr_off_desc->btf_id;
+		} else {
+			ret_btf = btf_vmlinux;
+			ret_btf_id = *fn->ret_btf_id;
+		}
 		if (ret_btf_id == 0) {
 			verbose(env, "invalid return type %u of func %s#%d\n",
 				base_type(ret_type), func_id_name(func_id),
 				func_id);
 			return -EINVAL;
 		}
-		/* current BPF helper definitions are only coming from
-		 * built-in code with type IDs from  vmlinux BTF
-		 */
-		regs[BPF_REG_0].btf = btf_vmlinux;
+		regs[BPF_REG_0].btf = ret_btf;
 		regs[BPF_REG_0].btf_id = ret_btf_id;
 	} else {
 		verbose(env, "unknown return type %u of func %s#%d\n",
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7604e7d5438f..b4e89da75d77 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5143,6 +5143,17 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * void *bpf_kptr_xchg(void *map_value, void *ptr)
+ *	Description
+ *		Exchange kptr at pointer *map_value* with *ptr*, and return the
+ *		old value. *ptr* can be NULL, otherwise it must be a referenced
+ *		pointer which will be released when this helper is called.
+ *	Return
+ *		The old value of kptr (which can be NULL). The returned pointer
+ *		if not NULL, is a reference which must be released using its
+ *		corresponding release function, or moved into a BPF map before
+ *		program exit.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5339,6 +5350,7 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(kptr_xchg),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.35.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA04FA678
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiDIJfV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJfT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F2D62CC
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id c2so9831966pga.10
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Brnn4MIah6b3hwb4QYXboHgEElSRFVRUl3FUkRwNgKY=;
        b=Qbq7D887pgAM2wMt+qZgULAUlAauiAQKJDAOidY/d8am2pCmibn2Ko+U97NyNC6gpM
         MfPOaOP5CecKqIQt+hoUCYumW5HyvQgP0fxoA0lyJyeeW5nt7lEZPnq28BwlM06rlolZ
         RAenSy2ZleI4fS+k1pYFHKVIAKHiud8k0yZAWUvXMhdNqQSnpe1pueqMRanGHQsvm9sK
         NDW8EVpY0/n7lg8WzBMKvPEQLSDvLODkYY6M55mZRMcgvtrd0WyIF4Jp9eR/O0JtwvGw
         o5aM0kR2QgCNtZMAxkoEUh0mmpfJIHKLBGQFlhNbNGG01jmKQSosYbncdX3L49wzghab
         myEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Brnn4MIah6b3hwb4QYXboHgEElSRFVRUl3FUkRwNgKY=;
        b=uhlLx867kUwTGN0/4Zy4IREwKaFH8kdfsxgU5TVf61XIeUU5+VBOAU5BXt5nz3+vh1
         /KggzH2kTLoD1FlnIUxBjvpUGweJpxmADxXh2dY9M3S0EIGcWKty44XGdowv7oourr8v
         0DfGRe+sMN2TDCMnkjYUsmN5ShFgDmTotx8hEPBB2QN0BQKdg1g2+qjiforBHMgoa2fk
         nKyGlD7fpE5CIZN0cr9eQx1BTixYgExYCNvULXDdOsKzpgh3PxNHSwNPp8l0qFJhMMl4
         jNR297KBfI3ZJrqbr/YtJJw0iSi7k9ZtpYTO4TrTYyylkkcS0P1iWkpVyOnRx1zmdMKV
         OKwQ==
X-Gm-Message-State: AOAM533+JV0V7LfqtEL3xPJhjOz8jFZJmCoabzpSf27m63z6VGqZxCCO
        6rPiZ9mTxMgFMNErMNJWhtqAEsliBPI=
X-Google-Smtp-Source: ABdhPJw80YW3X/ocL257rtj3pkvCuiv5w2Cdy5JgPjnPgll/40OuY1kp+YpXr+LqcCl2trrwu4E4MA==
X-Received: by 2002:a63:b542:0:b0:399:40fd:3ac3 with SMTP id u2-20020a63b542000000b0039940fd3ac3mr18708923pgo.564.1649496791177;
        Sat, 09 Apr 2022 02:33:11 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id x24-20020a637c18000000b0039cc6a3f73fsm7136831pgc.41.2022.04.09.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:10 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 05/13] bpf: Allow storing referenced kptr in map
Date:   Sat,  9 Apr 2022 15:02:55 +0530
Message-Id: <20220409093303.499196-6-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16786; h=from:subject; bh=3fwzmLba5f2rff3J2pgLxhjtln2QDrJ7T1b7lW1hhr4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0cvsOnQIJxHQCak3QAd9RAo8o3XQlkuRGZQqR 01Kj/wGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8Ryj9SD/ 49gSlySv6h4Mee8fMXPIvdFsW8ldEhqswGY2BihGXTbgHWsEwPequBxqLr7RIBuXX9u0mR0Bq2hgng YM/VI0wNaRS9DPse7ExsD5epkJxx3xR6obhFTzRyteAf8GIRPg6NI3VIy5AbkZexlTT9zS8pRUY1j+ 3/06qjEhtE97m8vu0o2nEqI9twScSuvXw1M6eWEZWT1GQ2SD73BH3OhBqDI3PIc3CH5UertbBuGPS/ RPeNAQadl8FVwaIO7v4dL6whoCPdbM4PA5IovYUbV1/nQ7Igm69I26Z6AwX+iFoOTn9UXotLLGbSkY LJCGfQG6hdXEZaITkwgqbtOrMtIeZfD26UT15C7GaIyUX/F8rNVL0MWfFObHTY24r23TKTCbvJVLld DcHnCgdyJyKPt6EM6QPmFhjB/UElBjrWJp04Zn9KzIoPKB2RbugbfiXunCwJ4uWQR4W2GCsSgM1kK/ Bg27CbxSQw/kMsZFUmD5XhJ7bOqyRekoPSYH8Q12hg/1hkbl/h1HR+7sdUQJ+h0ieHB07IqOwu9ull sKMHeu9z47G1dpyVBBJjQZG9dCbtCwg2u3gRZ8Ml8Cvy4TNgtJjp37La+H7TnWcBETGHxaDYtkLxL6 71nXZgmcXt2tzLNQN/yshGodMNTeTnQkBfoQ8SLtTxJ15e1di5tH/QxvueEA==
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
 include/linux/bpf.h            |   7 +++
 include/uapi/linux/bpf.h       |  12 ++++
 kernel/bpf/btf.c               |  10 ++-
 kernel/bpf/helpers.c           |  21 +++++++
 kernel/bpf/verifier.c          | 107 +++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h |  12 ++++
 6 files changed, 155 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a6d1982e8118..bd682c29883a 100644
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
@@ -416,6 +421,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_STACK,	/* pointer to stack */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
+	ARG_PTR_TO_KPTR,	/* pointer to kptr */
 	__BPF_ARG_TYPE_MAX,
 
 	/* Extended arg_types. */
@@ -425,6 +431,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
 	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
 	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
+	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d14b10b85e51..444fe6f1cf35 100644
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
index 28b1d9e9124e..43ea9ed5652e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3177,6 +3177,7 @@ enum {
 struct btf_field_info {
 	u32 type_id;
 	u32 off;
+	int flags;
 };
 
 static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
@@ -3194,6 +3195,7 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 			       u32 off, int sz, struct btf_field_info *info)
 {
 	u32 res_id;
+	int flags;
 
 	/* For PTR, sz is always == 8 */
 	if (!btf_type_is_ptr(t))
@@ -3205,7 +3207,11 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
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
@@ -3216,6 +3222,7 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 
 	info->type_id = res_id;
 	info->off = off;
+	info->flags = flags;
 	return BTF_FIELD_FOUND;
 }
 
@@ -3420,6 +3427,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 		tab->off[i].offset = info_arr[i].off;
 		tab->off[i].btf_id = id;
 		tab->off[i].btf = off_btf;
+		tab->off[i].flags = info_arr[i].flags;
 		tab->nr_off = i + 1;
 	}
 	return tab;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 315053ef6a75..a437d0f0458a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1374,6 +1374,25 @@ void bpf_timer_cancel_and_free(void *val)
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
+	.arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | PTR_RELEASE,
+	.arg2_btf_id  = &bpf_kptr_xchg_btf_id,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1452,6 +1471,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_timer_start_proto;
 	case BPF_FUNC_timer_cancel:
 		return &bpf_timer_cancel_proto;
+	case BPF_FUNC_kptr_xchg:
+		return &bpf_kptr_xchg_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6cc08526e049..92efe6c3999c 100644
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
@@ -3525,6 +3528,12 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
 	reg_name = kernel_type_name(reg->btf, reg->btf_id);
 
+	/* For ref_ptr case, release function check should ensure we get one
+	 * referenced PTR_TO_BTF_ID, and that its fixed offset is 0. For the
+	 * normal store of unreferenced kptr, we must ensure var_off is zero.
+	 * Since ref_ptr cannot be accessed directly by BPF insns, checks for
+	 * reg->off and reg->ref_obj_id are not needed here.
+	 */
 	if (__check_ptr_off_reg(env, reg, regno, true))
 		return -EACCES;
 
@@ -3557,6 +3566,12 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
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
@@ -5278,6 +5293,59 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
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
+	if (!map_value_has_kptrs(map_ptr)) {
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
@@ -5418,6 +5486,7 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
 
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
@@ -5445,11 +5514,13 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
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
@@ -5502,8 +5573,11 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			arg_btf_id = compatible->btf_id;
 		}
 
-		if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
-					  btf_vmlinux, *arg_btf_id)) {
+		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
+				return -EACCES;
+		} else if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
+						 btf_vmlinux, *arg_btf_id)) {
 			verbose(env, "R%d is of type %s but %s is expected\n",
 				regno, kernel_type_name(reg->btf, reg->btf_id),
 				kernel_type_name(btf_vmlinux, *arg_btf_id));
@@ -5613,7 +5687,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		goto skip_type_check;
 
-	err = check_reg_type(env, regno, arg_type, fn->arg_btf_id[arg]);
+	err = check_reg_type(env, regno, arg_type, fn->arg_btf_id[arg], meta);
 	if (err)
 		return err;
 
@@ -5778,6 +5852,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "string is not zero-terminated\n");
 			return -EINVAL;
 		}
+	} else if (arg_type == ARG_PTR_TO_KPTR) {
+		if (process_kptr_func(env, regno, meta))
+			return -EACCES;
 	}
 
 	return err;
@@ -6120,10 +6197,10 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
-		if (fn->arg_type[i] == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
+		if (base_type(fn->arg_type[i]) == ARG_PTR_TO_BTF_ID && !fn->arg_btf_id[i])
 			return false;
 
-		if (fn->arg_type[i] != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i])
+		if (base_type(fn->arg_type[i]) != ARG_PTR_TO_BTF_ID && fn->arg_btf_id[i])
 			return false;
 	}
 
@@ -7007,21 +7084,25 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
index d14b10b85e51..444fe6f1cf35 100644
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


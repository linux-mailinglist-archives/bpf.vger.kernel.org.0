Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA5F50D55B
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiDXVvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiDXVvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:51:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92059644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:48:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k29so11835709pgm.12
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7H+xUauiJdq7AARUYBHDMY87ycq1gzj/7fRH1MiS2eU=;
        b=TsXXw/8VP+y7OdxSgLuZts14QPR4Jn7AM/++cEKqnBOSouSWtl15Z1HrXa9q20Nrpa
         R7FgUc5Pkh47gr+p/egmW+dof6Qcm++RJjZ/6xNKpv7LS+/Xx6tHh6oUYyfgPBxxGpNw
         JVOCH3esIv1LYPR7f8mjTlhNddbQbC9AvuNW11a664WQxKyf3jGJwwDBNTNoQsR17Y1V
         nOzimzcLZ0oWZwD8gZuQkzXKYYWM6XhH4mFsA3zSzQy0/o19alElD4ghvljbT2iIk2J5
         zkGcomZUT1WwyMB56J0/8cj32iFAhpQHcUe7l9fwsjNZu1Ojx3Iqq4aOnWbc43p5gkYV
         HNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7H+xUauiJdq7AARUYBHDMY87ycq1gzj/7fRH1MiS2eU=;
        b=oB4DXSWSz0n+eTalwg2hZUcqDZm2bWlo72GKt7XMpwZgvvt39yc9rnId69tFMMLHue
         2piVxM0pSow0EkOlulAyszbyQbNmyqpfUCK6PopQTvonh6OOueLiRAbojk+z4zjANwlS
         D0o4MdwY28c5044sf7sryVZ3obnMiKU0xnD8EbEaC+eQyiwpdmL8kX8myqM6LASRewgV
         RhCC0Ax2Yp2V4Sp5GpqBa5sWpmJDc53Dq7BpdHjXKKX7r3ONvmMxH2Aof0i8Fff/DxV4
         Ijh3goMs8LUxMbn7vU9QpDVCEue5S+H6VVnKA1YztUo5YO8kA2uiJ4YMiiEj566leb6q
         lWdg==
X-Gm-Message-State: AOAM531ppImzNFRtQO4WWullvu1g2N9seYNTGjaN1R9AitF3slL5dGsK
        oE5x6aV9tX9t4o5p0Jb2uLOHWpNW/UI=
X-Google-Smtp-Source: ABdhPJwHDTH78qFzt6BIEv3gdyjG6efbwaBxakqJIr6Theq4CdS6hu+2dIH6n/201Rc2FIPL5mWpvw==
X-Received: by 2002:a62:fb0f:0:b0:4f2:6d3f:5ffb with SMTP id x15-20020a62fb0f000000b004f26d3f5ffbmr15591481pfm.55.1650836931883;
        Sun, 24 Apr 2022 14:48:51 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a190300b001cd4989ff60sm12800458pjg.39.2022.04.24.14.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:48:51 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 02/13] bpf: Tag argument to be released in bpf_func_proto
Date:   Mon, 25 Apr 2022 03:18:50 +0530
Message-Id: <20220424214901.2743946-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13294; h=from:subject; bh=g/J+RpBtriVDYMF7S0ZLEWD5wnkdIAyMSqFz7CSRb0g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTKFiA2jj+3+Ic67uo7+MQkk2/Z/FZ4z/05KL0G zYPYkf2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEygAKCRBM4MiGSL8RytSeD/ 99iZeg0op6vQSOhaSYxaD551mIAACismNuRLw2HhAao2PAcuHyRg2Xy+zrTFb5WG3Inm15eonwhqJC rqW0ufdZOzZ9L0Afw4nWZ8Rk38/w2NpdyI+o/7Afqkh73HMJSNzQvkrlEWUp5WpX3OuoaAyVVLj+rU xEsO4m8FvZAOXOcvpFnJeHWYo9ENX6AVkSXkvZgVhXImLq9KX3OUU3o8KP/dQYgd6qn+xUUJJ2hPKt gpQD3x5G6vBlZ/R9aKopF2pWV3ozbSwGgiGxtLaW68q6BMWaGgJnn5MUgTbjqBEgE/w3pUTfvWEGO8 gQbOjGXfFgD7nXk1D/yXFKZuF5G+8OuJlxNu204kWPHUYvj9OODAkWQNQzYKRvnsS+cADAtqXtADRP mRfO7AcQ/OTdioltdlP0Msn2RhVjmAkMO7J9R5Wh0WY+hyaCYpzJs3xg8Hm8YougU8AblyvhosFTiq Fws1S9YdOEtoMZzDTKc5oXXAp9I8kKtiO1XXAhBqH2rNnYysmyKS7f4LnuLAoKuHa1dXcXPdoEDZ4G rV110rvpr+vr8vVZDq5qAuQO1vPYp3jIbAohquKZiqlORsKw9OJdrR6M980n3OFYknS2H/FvdxbPn6 ZcQTlu7qpC/V2nDHqhMvk6Q7u+p89pkLGoHSSoHJUfu10rG1t8JqPGtRnFuw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new type flag for bpf_arg_type that when set tells verifier that
for a release function, that argument's register will be the one for
which meta.ref_obj_id will be set, and which will then be released
using release_reference. To capture the regno, introduce a new field
release_regno in bpf_call_arg_meta.

This would be required in the next patch, where we may either pass NULL
or a refcounted pointer as an argument to the release function
bpf_kptr_xchg. Just releasing only when meta.ref_obj_id is set is not
enough, as there is a case where the type of argument needed matches,
but the ref_obj_id is set to 0. Hence, we must enforce that whenever
meta.ref_obj_id is zero, the register that is to be released can only
be NULL for a release function.

Since we now indicate whether an argument is to be released in
bpf_func_proto itself, is_release_function helper has lost its utitlity,
hence refactor code to work without it, and just rely on
meta.release_regno to know when to release state for a ref_obj_id.
Still, the restriction of one release argument and only one ref_obj_id
passed to BPF helper or kfunc remains. This may be lifted in the future.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  5 +-
 include/linux/bpf_verifier.h                  |  3 +-
 kernel/bpf/btf.c                              | 11 ++-
 kernel/bpf/ringbuf.c                          |  4 +-
 kernel/bpf/verifier.c                         | 76 +++++++++++--------
 net/core/filter.c                             |  2 +-
 .../selftests/bpf/verifier/ref_tracking.c     |  2 +-
 tools/testing/selftests/bpf/verifier/sock.c   |  6 +-
 8 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ce12124048c0..492edd2c5713 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -366,7 +366,10 @@ enum bpf_type_flag {
 	 */
 	MEM_PERCPU		= BIT(4 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_PERCPU,
+	/* Indicates that the argument will be released. */
+	OBJ_RELEASE		= BIT(5 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= OBJ_RELEASE,
 };
 
 /* Max number of base types. */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3a9d2d7cc6b7..1f1e7f2ea967 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -523,8 +523,7 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 		      const struct bpf_reg_state *reg, int regno);
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type,
-			   bool is_release_func);
+			   enum bpf_arg_type arg_type);
 int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 563ac61e6d6b..f0287342204f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6047,6 +6047,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	 * verifier sees.
 	 */
 	for (i = 0; i < nargs; i++) {
+		enum bpf_arg_type arg_type = ARG_DONTCARE;
 		u32 regno = i + 1;
 		struct bpf_reg_state *reg = &regs[regno];
 
@@ -6067,7 +6068,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		ret = check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
+		if (rel && reg->ref_obj_id)
+			arg_type |= OBJ_RELEASE;
+		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
 		if (ret < 0)
 			return ret;
 
@@ -6099,11 +6102,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			if (reg->type == PTR_TO_BTF_ID) {
 				reg_btf = reg->btf;
 				reg_ref_id = reg->btf_id;
-				/* Ensure only one argument is referenced
-				 * PTR_TO_BTF_ID, check_func_arg_reg_off relies
-				 * on only one referenced register being allowed
-				 * for kfuncs.
-				 */
+				/* Ensure only one argument is referenced PTR_TO_BTF_ID */
 				if (reg->ref_obj_id) {
 					if (ref_obj_id) {
 						bpf_log(log, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 710ba9de12ce..5173fd37590f 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -404,7 +404,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, flags)
 const struct bpf_func_proto bpf_ringbuf_submit_proto = {
 	.func		= bpf_ringbuf_submit,
 	.ret_type	= RET_VOID,
-	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
+	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | OBJ_RELEASE,
 	.arg2_type	= ARG_ANYTHING,
 };
 
@@ -417,7 +417,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
 const struct bpf_func_proto bpf_ringbuf_discard_proto = {
 	.func		= bpf_ringbuf_discard,
 	.ret_type	= RET_VOID,
-	.arg1_type	= ARG_PTR_TO_ALLOC_MEM,
+	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | OBJ_RELEASE,
 	.arg2_type	= ARG_ANYTHING,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17ca586e0585..5426bab7f02c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -245,6 +245,7 @@ struct bpf_call_arg_meta {
 	struct bpf_map *map_ptr;
 	bool raw_mode;
 	bool pkt_access;
+	u8 release_regno;
 	int regno;
 	int access_size;
 	int mem_size;
@@ -471,17 +472,6 @@ static bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
 
-/* Determine whether the function releases some resources allocated by another
- * function call. The first reference type argument will be assumed to be
- * released by release_reference().
- */
-static bool is_release_function(enum bpf_func_id func_id)
-{
-	return func_id == BPF_FUNC_sk_release ||
-	       func_id == BPF_FUNC_ringbuf_submit ||
-	       func_id == BPF_FUNC_ringbuf_discard;
-}
-
 static bool may_be_acquire_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_sk_lookup_tcp ||
@@ -5326,6 +5316,11 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type type)
 	       type == ARG_PTR_TO_LONG;
 }
 
+static bool arg_type_is_release(enum bpf_arg_type type)
+{
+	return type & OBJ_RELEASE;
+}
+
 static int int_ptr_type_to_size(enum bpf_arg_type type)
 {
 	if (type == ARG_PTR_TO_INT)
@@ -5536,11 +5531,10 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type,
-			   bool is_release_func)
+			   enum bpf_arg_type arg_type)
 {
-	bool fixed_off_ok = false, release_reg;
 	enum bpf_reg_type type = reg->type;
+	bool fixed_off_ok = false;
 
 	switch ((u32)type) {
 	case SCALAR_VALUE:
@@ -5558,7 +5552,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		/* Some of the argument types nevertheless require a
 		 * zero register offset.
 		 */
-		if (arg_type != ARG_PTR_TO_ALLOC_MEM)
+		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
 			return 0;
 		break;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
@@ -5566,19 +5560,17 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 */
 	case PTR_TO_BTF_ID:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
-		 * it's fixed offset must be 0. We rely on the property that
-		 * only one referenced register can be passed to BPF helpers and
-		 * kfuncs. In the other cases, fixed offset can be non-zero.
+		 * it's fixed offset must be 0.	In the other cases, fixed offset
+		 * can be non-zero.
 		 */
-		release_reg = is_release_func && reg->ref_obj_id;
-		if (release_reg && reg->off) {
+		if (arg_type_is_release(arg_type) && reg->off) {
 			verbose(env, "R%d must have zero offset when passed to release func\n",
 				regno);
 			return -EINVAL;
 		}
-		/* For release_reg == true, fixed_off_ok must be false, but we
-		 * already checked and rejected reg->off != 0 above, so set to
-		 * true to allow fixed offset for all other cases.
+		/* For arg is release pointer, fixed_off_ok must be false, but
+		 * we already checked and rejected reg->off != 0 above, so set
+		 * to true to allow fixed offset for all other cases.
 		 */
 		fixed_off_ok = true;
 		break;
@@ -5637,14 +5629,24 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (err)
 		return err;
 
-	err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
+	err = check_func_arg_reg_off(env, reg, regno, arg_type);
 	if (err)
 		return err;
 
 skip_type_check:
-	/* check_func_arg_reg_off relies on only one referenced register being
-	 * allowed for BPF helpers.
-	 */
+	if (arg_type_is_release(arg_type)) {
+		if (!reg->ref_obj_id && !register_is_null(reg)) {
+			verbose(env, "R%d must be referenced when passed to release function\n",
+				regno);
+			return -EINVAL;
+		}
+		if (meta->release_regno) {
+			verbose(env, "verifier internal error: more than one release argument\n");
+			return -EFAULT;
+		}
+		meta->release_regno = regno;
+	}
+
 	if (reg->ref_obj_id) {
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
@@ -6151,7 +6153,8 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
-static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
+static int check_func_proto(const struct bpf_func_proto *fn, int func_id,
+			    struct bpf_call_arg_meta *meta)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
@@ -6835,7 +6838,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	memset(&meta, 0, sizeof(meta));
 	meta.pkt_access = fn->pkt_access;
 
-	err = check_func_proto(fn, func_id);
+	err = check_func_proto(fn, func_id, &meta);
 	if (err) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d\n",
 			func_id_name(func_id), func_id);
@@ -6868,8 +6871,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			return err;
 	}
 
-	if (is_release_function(func_id)) {
-		err = release_reference(env, meta.ref_obj_id);
+	regs = cur_regs(env);
+
+	if (meta.release_regno) {
+		err = -EINVAL;
+		if (meta.ref_obj_id)
+			err = release_reference(env, meta.ref_obj_id);
+		/* meta.ref_obj_id can only be 0 if register that is meant to be
+		 * released is NULL, which must be > R0.
+		 */
+		else if (register_is_null(&regs[meta.release_regno]))
+			err = 0;
 		if (err) {
 			verbose(env, "func %s#%d reference has not been acquired before\n",
 				func_id_name(func_id), func_id);
@@ -6877,8 +6889,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
-	regs = cur_regs(env);
-
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
 		err = check_reference_leak(env);
diff --git a/net/core/filter.c b/net/core/filter.c
index 8847316ee20e..da04ad179fda 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
 	.func		= bpf_sk_release,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON | OBJ_RELEASE,
 };
 
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index fbd682520e47..57a83d763ec1 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -796,7 +796,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "reference has not been acquired before",
+	.errstr = "R1 must be referenced when passed to release function",
 },
 {
 	/* !bpf_sk_fullsock(sk) is checked but !bpf_tcp_sock(sk) is not checked */
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index 86b24cad27a7..d11d0b28be41 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -417,7 +417,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "reference has not been acquired before",
+	.errstr = "R1 must be referenced when passed to release function",
 },
 {
 	"bpf_sk_release(bpf_sk_fullsock(skb->sk))",
@@ -436,7 +436,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "reference has not been acquired before",
+	.errstr = "R1 must be referenced when passed to release function",
 },
 {
 	"bpf_sk_release(bpf_tcp_sock(skb->sk))",
@@ -455,7 +455,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "reference has not been acquired before",
+	.errstr = "R1 must be referenced when passed to release function",
 },
 {
 	"sk_storage_get(map, skb->sk, NULL, 0): value == NULL",
-- 
2.35.1


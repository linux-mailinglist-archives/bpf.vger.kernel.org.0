Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8052646283
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 21:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiLGUmC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 15:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLGUl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 15:41:57 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7534A30558
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 12:41:55 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 140so18514210pfz.6
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVJJ1TBXIeuiDVafpChCYPBWBDEdHKmbMIWBXkU4gwU=;
        b=gGlIR43fpiZQ8VVKywI8oewX+ZrLilhAySPBO8R39pTEVdyGeQzD0YvTA+p0IZuev0
         jADZyt7wtsDgBrHiLBV7APEsIqaZTDarbRMeZUlUION+Jm5dxLf1s1uWf9/CnNKhR2pN
         hAZPkXT7Klje7MnsY8aXBxF9DISoWobmiEvAxy5++Ny3yQoX72A7Bd5v+HK+4PGzPfk5
         Eej/7VfcYi3DPS4k5o+XnMw2z6R7TVEaej7j2K5ZBVTnp+JAyPSoJvSuyT5H4Jvut/sk
         QnOqcPRhMrJeIZPF9skVMKkJLcANX9EJbCBHg/NAqIi8YTTfdRETUDXjSjPqY4V/2fEF
         jVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVJJ1TBXIeuiDVafpChCYPBWBDEdHKmbMIWBXkU4gwU=;
        b=4x7hCXsnlA08qP3DftWKn45+jVWNTvBGRqyVlB0SNfdhW7DGr7va9Chb1ZrWKJ5CiS
         KfrvhH2iuXNtFmJTAGVUHsCPpCB+nlT6vh8EhGmYdTK4Tp2x9WLVwjzDTFcQjhWotCWY
         uvbWpvI9fAbAG0NtCW5kv0Ic9BGrpmWxylEeHy8y8RHT3I4axMnFB3UBSOzaP0A97Fcm
         pU8NR562Pu7xPdywHkqtIyCGPcinI3m7uFb1YpBbaD4wMZQrvbugZjSyIY4xSdQ6+5fj
         tpk8wAerBSa/VxCPtLV/fsXXTDW4pRMiolohMSN7tEmgxci4j7MWC4PRrJDp+FYMiAZx
         5vYQ==
X-Gm-Message-State: ANoB5plZUP1VV77k0WP8WbXb7CXdwdv8SSHWkYJY7eu5sKb20dlZFePj
        CnbuXAe4xqWn4oZaFiHv79OUV/ixbmfOmuas
X-Google-Smtp-Source: AA0mqf5tJ2ykBpREBp7Rt0zShErw7YgqKmqESSByOTuOW3jd6l8Hqp5PwJuhtKo4mLoJBluNosTBxA==
X-Received: by 2002:a62:8641:0:b0:577:6515:f257 with SMTP id x62-20020a628641000000b005776515f257mr5691014pfd.10.1670445714644;
        Wed, 07 Dec 2022 12:41:54 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id 13-20020a62180d000000b00573769811d6sm11647261pfy.44.2022.12.07.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:41:54 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 3/7] bpf: Rework process_dynptr_func
Date:   Thu,  8 Dec 2022 02:11:37 +0530
Message-Id: <20221207204141.308952-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207204141.308952-1-memxor@gmail.com>
References: <20221207204141.308952-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28270; i=memxor@gmail.com; h=from:subject; bh=E62m2OtYRTWsK1TraRoFKVviBq5MROTPLnzaqK8uOLw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjkPOopUvQPjCAXVKSXGPevby39bvJAooZ2je5DUvr F2PcG7SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY5DzqAAKCRBM4MiGSL8RysopD/ 0eG59XnRMBmVjp5VopSB9QA0+Xw+wGsAq23PvCce3sEOjrJHu/7YTwb49dJBr6WlRNgHnrjQmaK8qq ANBCmdrcjqpqDQoP7saX6JO8FyQDkJWT9RQaCfP0W3lgQYy/srOCSVDIZtuhlpZIlGlxl8Rs8rTJrp 4zsT4++e1U/mqBXfmxuzBTD7UiR9rUv48IOQXzLpt899jYApFUxgsu+IM0wFt2EYg59c6XK7HLXHQ+ tyHV3oNELmskmrEM6pcRD5n4kZ42OBUeL8aMQ60ax1sQXKu2933A4uW7gPK+Zamhzfzv51v5NDmjTH 1V8Zu8PpeLoKZy5QKm9b9m3h/1oW8kXS/psihWTD+gjBwozgSqlGQ2PjSQKRf3T/KoKESZp1uXPUdE YZkSCDCVGnyyYqjykixHsB3q/l5dnt4xpGaFu9nDHfiadk7rYw6nT8xoUaOVqM6W6ixE9l29sXjvr8 MrU+w+TltPCQDj+YD67BCQt8q3xtvxSr+i4DTzPOoOO9RjmoLmKhQmLUeiG6DTgCcn8gA1Jx6I1J3r 72DA1Z+aiMqT9xvOnkEBoEA3/DZAHG9kxdm/RzUx0oH/wae6fRf6hu9XruHf9rhht9pngUb6Wi+7xx dPi132U6cXTR3ZAngevNvEf5zu8uPpj/fc7E1bWiMdOVA3v0kbBdFoPkxQxw==
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

Recently, user ringbuf support introduced a PTR_TO_DYNPTR register type
for use in callback state, because in case of user ringbuf helpers,
there is no dynptr on the stack that is passed into the callback. To
reflect such a state, a special register type was created.

However, some checks have been bypassed incorrectly during the addition
of this feature. First, for arg_type with MEM_UNINIT flag which
initialize a dynptr, they must be rejected for such register type.
Secondly, in the future, there are plans to add dynptr helpers that
operate on the dynptr itself and may change its offset and other
properties.

In all of these cases, PTR_TO_DYNPTR shouldn't be allowed to be passed
to such helpers, however the current code simply returns 0.

The rejection for helpers that release the dynptr is already handled.

For fixing this, we take a step back and rework existing code in a way
that will allow fitting in all classes of helpers and have a coherent
model for dealing with the variety of use cases in which dynptr is used.

First, for ARG_PTR_TO_DYNPTR, it can either be set alone or together
with a DYNPTR_TYPE_* constant that denotes the only type it accepts.

Next, helpers which initialize a dynptr use MEM_UNINIT to indicate this
fact. To make the distinction clear, use MEM_RDONLY flag to indicate
that the helper only operates on the memory pointed to by the dynptr,
not the dynptr itself. In C parlance, it would be equivalent to taking
the dynptr as a point to const argument.

When either of these flags are not present, the helper is allowed to
mutate both the dynptr itself and also the memory it points to.
Currently, the read only status of the memory is not tracked in the
dynptr, but it would be trivial to add this support inside dynptr state
of the register.

With these changes and renaming PTR_TO_DYNPTR to CONST_PTR_TO_DYNPTR to
better reflect its usage, it can no longer be passed to helpers that
initialize a dynptr, i.e. bpf_dynptr_from_mem, bpf_ringbuf_reserve_dynptr.

A note to reviewers is that in code that does mark_stack_slots_dynptr,
and unmark_stack_slots_dynptr, we implicitly rely on the fact that
PTR_TO_STACK reg is the only case that can reach that code path, as one
cannot pass CONST_PTR_TO_DYNPTR to helpers that don't set MEM_RDONLY. In
both cases such helpers won't be setting that flag.

The next patch will add a couple of selftest cases to make sure this
doesn't break.

Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |   4 +-
 include/uapi/linux/bpf.h                      |   8 +-
 kernel/bpf/helpers.c                          |  18 +-
 kernel/bpf/verifier.c                         | 227 +++++++++++++-----
 scripts/bpf_doc.py                            |   1 +
 tools/include/uapi/linux/bpf.h                |   8 +-
 .../selftests/bpf/prog_tests/user_ringbuf.c   |   4 +-
 7 files changed, 191 insertions(+), 79 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4920ac252754..3de24cfb7a3d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -775,7 +775,7 @@ enum bpf_reg_type {
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
-	PTR_TO_DYNPTR,		 /* reg points to a dynptr */
+	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
 	__BPF_REG_TYPE_MAX,
 
 	/* Extended reg_types. */
@@ -2828,7 +2828,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
-u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
+u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f89de51a45db..464ca3f01fe7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5293,7 +5293,7 @@ union bpf_attr {
  *	Return
  *		Nothing. Always succeeds.
  *
- * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset, u64 flags)
+ * long bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr *src, u32 offset, u64 flags)
  *	Description
  *		Read *len* bytes from *src* into *dst*, starting from *offset*
  *		into *src*.
@@ -5303,7 +5303,7 @@ union bpf_attr {
  *		of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
  *		*flags* is not 0.
  *
- * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
+ * long bpf_dynptr_write(const struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
@@ -5313,7 +5313,7 @@ union bpf_attr {
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
  *		is a read-only dynptr or if *flags* is not 0.
  *
- * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u32 offset, u32 len)
  *	Description
  *		Get a pointer to the underlying dynptr data.
  *
@@ -5414,7 +5414,7 @@ union bpf_attr {
  *		Drain samples from the specified user ring buffer, and invoke
  *		the provided callback for each such sample:
  *
- *		long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
+ *		long (\*callback_fn)(const struct bpf_dynptr \*dynptr, void \*ctx);
  *
  *		If **callback_fn** returns 0, the helper will continue to try
  *		and drain the next sample, up to a maximum of
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 284b3ffdbe48..bf9a6a646254 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1404,7 +1404,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
 
-static bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
+static bool bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
@@ -1414,7 +1414,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
@@ -1438,7 +1438,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-static int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
+static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
 {
 	u32 size = bpf_dynptr_get_size(ptr);
 
@@ -1483,7 +1483,7 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
 };
 
-BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src,
+BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
 	   u32, offset, u64, flags)
 {
 	int err;
@@ -1506,12 +1506,12 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
-	.arg3_type	= ARG_PTR_TO_DYNPTR,
+	.arg3_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
+BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
 	   u32, len, u64, flags)
 {
 	int err;
@@ -1532,14 +1532,14 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
 	.func		= bpf_dynptr_write,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_DYNPTR,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg5_type	= ARG_ANYTHING,
 };
 
-BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
+BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
 {
 	int err;
 
@@ -1560,7 +1560,7 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
 	.func		= bpf_dynptr_data,
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_DYNPTR_MEM_OR_NULL,
-	.arg1_type	= ARG_PTR_TO_DYNPTR,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1af449c20a10..fdbaf22cdaf2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -592,7 +592,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		[PTR_TO_BUF]		= "buf",
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
-		[PTR_TO_DYNPTR]		= "dynptr_ptr",
+		[CONST_PTR_TO_DYNPTR]	= "dynptr_ptr",
 	};
 
 	if (type & PTR_MAYBE_NULL) {
@@ -725,6 +725,28 @@ static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 	return type == BPF_DYNPTR_TYPE_RINGBUF;
 }
 
+static void __mark_dynptr_reg(struct bpf_reg_state *reg,
+			      enum bpf_dynptr_type type,
+			      bool first_slot);
+
+static void __mark_reg_not_init(const struct bpf_verifier_env *env,
+				struct bpf_reg_state *reg);
+
+static void mark_dynptr_stack_regs(struct bpf_reg_state *sreg1,
+				   struct bpf_reg_state *sreg2,
+				   enum bpf_dynptr_type type)
+{
+	__mark_dynptr_reg(sreg1, type, true);
+	__mark_dynptr_reg(sreg2, type, false);
+}
+
+static void mark_dynptr_cb_reg(struct bpf_reg_state *reg,
+			       enum bpf_dynptr_type type)
+{
+	__mark_dynptr_reg(reg, type, true);
+}
+
+
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx)
 {
@@ -746,9 +768,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (type == BPF_DYNPTR_TYPE_INVALID)
 		return -EINVAL;
 
-	state->stack[spi].spilled_ptr.dynptr.first_slot = true;
-	state->stack[spi].spilled_ptr.dynptr.type = type;
-	state->stack[spi - 1].spilled_ptr.dynptr.type = type;
+	mark_dynptr_stack_regs(&state->stack[spi].spilled_ptr,
+			       &state->stack[spi - 1].spilled_ptr, type);
 
 	if (dynptr_type_refcounted(type)) {
 		/* The id is used to track proper releasing */
@@ -756,8 +777,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (id < 0)
 			return id;
 
-		state->stack[spi].spilled_ptr.id = id;
-		state->stack[spi - 1].spilled_ptr.id = id;
+		state->stack[spi].spilled_ptr.ref_obj_id = id;
+		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
 	}
 
 	return 0;
@@ -779,25 +800,23 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 	}
 
 	/* Invalidate any slices associated with this dynptr */
-	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
-		release_reference(env, state->stack[spi].spilled_ptr.id);
-		state->stack[spi].spilled_ptr.id = 0;
-		state->stack[spi - 1].spilled_ptr.id = 0;
-	}
-
-	state->stack[spi].spilled_ptr.dynptr.first_slot = false;
-	state->stack[spi].spilled_ptr.dynptr.type = 0;
-	state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
+	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type))
+		WARN_ON_ONCE(release_reference(env, state->stack[spi].spilled_ptr.ref_obj_id));
 
+	__mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
+	__mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
 	return 0;
 }
 
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi = get_spi(reg->off);
-	int i;
+	int spi, i;
+
+	if (reg->type == CONST_PTR_TO_DYNPTR)
+		return false;
 
+	spi = get_spi(reg->off);
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return true;
 
@@ -813,9 +832,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi = get_spi(reg->off);
+	int spi;
 	int i;
 
+	/* This already represents first slot of initialized bpf_dynptr */
+	if (reg->type == CONST_PTR_TO_DYNPTR)
+		return true;
+
+	spi = get_spi(reg->off);
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
 	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
 		return false;
@@ -834,15 +858,19 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type dynptr_type;
-	int spi = get_spi(reg->off);
+	int spi;
 
 	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
 	if (arg_type == ARG_PTR_TO_DYNPTR)
 		return true;
 
 	dynptr_type = arg_to_dynptr_type(arg_type);
-
-	return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
+	if (reg->type == CONST_PTR_TO_DYNPTR) {
+		return reg->dynptr.type == dynptr_type;
+	} else {
+		spi = get_spi(reg->off);
+		return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
+	}
 }
 
 /* The reg state of a pointer or a bounded scalar was saved when
@@ -1354,9 +1382,6 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
 	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
 };
 
-static void __mark_reg_not_init(const struct bpf_verifier_env *env,
-				struct bpf_reg_state *reg);
-
 /* This helper doesn't clear reg->id */
 static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
@@ -1419,6 +1444,19 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(regs + regno);
 }
 
+static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
+			      bool first_slot)
+{
+	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
+	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
+	 * set it unconditionally as it is ignored for STACK_DYNPTR anyway.
+	 */
+	__mark_reg_known_zero(reg);
+	reg->type = CONST_PTR_TO_DYNPTR;
+	reg->dynptr.type = type;
+	reg->dynptr.first_slot = first_slot;
+}
+
 static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 {
 	if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
@@ -5857,19 +5895,58 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+/* There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
+ * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
+ *
+ * In both cases we deal with the first 8 bytes, but need to mark the next 8
+ * bytes as STACK_DYNPTR in case of PTR_TO_STACK. In case of
+ * CONST_PTR_TO_DYNPTR, we are guaranteed to get the beginning of the object.
+ *
+ * Mutability of bpf_dynptr is at two levels, one is at the level of struct
+ * bpf_dynptr itself, i.e. whether the helper is receiving a pointer to struct
+ * bpf_dynptr or pointer to const struct bpf_dynptr. In the former case, it can
+ * mutate the view of the dynptr and also possibly destroy it. In the latter
+ * case, it cannot mutate the bpf_dynptr itself but it can still mutate the
+ * memory that dynptr points to.
+ *
+ * The verifier will keep track both levels of mutation (bpf_dynptr's in
+ * reg->type and the memory's in reg->dynptr.type), but there is no support for
+ * readonly dynptr view yet, hence only the first case is tracked and checked.
+ *
+ * This is consistent with how C applies the const modifier to a struct object,
+ * where the pointer itself inside bpf_dynptr becomes const but not what it
+ * points to.
+ *
+ * Helpers which do not mutate the bpf_dynptr set MEM_RDONLY in their argument
+ * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
+ */
 int process_dynptr_func(struct bpf_verifier_env *env, int regno,
-			enum bpf_arg_type arg_type,
-			struct bpf_call_arg_meta *meta)
+			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 
-	/* We only need to check for initialized / uninitialized helper
-	 * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
-	 * assumption is that if it is, that a helper function
-	 * initialized the dynptr on behalf of the BPF program.
+	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
+	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
+	 */
+	if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
+		verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
+		return -EFAULT;
+	}
+	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
+	 *		 constructing a mutable bpf_dynptr object.
+	 *
+	 *		 Currently, this is only possible with PTR_TO_STACK
+	 *		 pointing to a region of at least 16 bytes which doesn't
+	 *		 contain an existing bpf_dynptr.
+	 *
+	 *  MEM_RDONLY - Points to a initialized bpf_dynptr that will not be
+	 *		 mutated or destroyed. However, the memory it points to
+	 *		 may be mutated.
+	 *
+	 *  None       - Points to a initialized dynptr that can be mutated and
+	 *		 destroyed, including mutation of the memory it points
+	 *		 to.
 	 */
-	if (base_type(reg->type) == PTR_TO_DYNPTR)
-		return 0;
 	if (arg_type & MEM_UNINIT) {
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
@@ -5885,7 +5962,13 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 		}
 
 		meta->uninit_dynptr_regno = regno;
-	} else {
+	} else /* MEM_RDONLY and None case from above */ {
+		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
+		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
+			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
+			return -EINVAL;
+		}
+
 		if (!is_dynptr_reg_valid_init(env, reg)) {
 			verbose(env,
 				"Expected an initialized dynptr as arg #%d\n",
@@ -5893,7 +5976,8 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 
-		if (!is_dynptr_type_expected(env, reg, arg_type)) {
+		/* Fold modifiers (in this case, MEM_RDONLY) when checking expected type */
+		if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {
 			const char *err_extra = "";
 
 			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
@@ -6056,7 +6140,7 @@ static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } }
 static const struct bpf_reg_types dynptr_types = {
 	.types = {
 		PTR_TO_STACK,
-		PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
+		CONST_PTR_TO_DYNPTR,
 	}
 };
 
@@ -6241,12 +6325,16 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
 
-static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi = get_spi(reg->off);
+	int spi;
+
+	if (reg->type == CONST_PTR_TO_DYNPTR)
+		return reg->ref_obj_id;
 
-	return state->stack[spi].spilled_ptr.id;
+	spi = get_spi(reg->off);
+	return state->stack[spi].spilled_ptr.ref_obj_id;
 }
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
@@ -6311,11 +6399,22 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (arg_type_is_release(arg_type)) {
 		if (arg_type_is_dynptr(arg_type)) {
 			struct bpf_func_state *state = func(env, reg);
-			int spi = get_spi(reg->off);
+			int spi;
 
-			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
-			    !state->stack[spi].spilled_ptr.id) {
-				verbose(env, "arg %d is an unacquired reference\n", regno);
+			/* Only dynptr created on stack can be released, thus
+			 * the get_spi and stack state checks for spilled_ptr
+			 * should only be done before process_dynptr_func for
+			 * PTR_TO_STACK.
+			 */
+			if (reg->type == PTR_TO_STACK) {
+				spi = get_spi(reg->off);
+				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
+				    !state->stack[spi].spilled_ptr.ref_obj_id) {
+					verbose(env, "arg %d is an unacquired reference\n", regno);
+					return -EINVAL;
+				}
+			} else {
+				verbose(env, "cannot release unowned const bpf_dynptr\n");
 				return -EINVAL;
 			}
 		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
@@ -7289,11 +7388,10 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 {
 	/* bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void
 	 *			  callback_ctx, u64 flags);
-	 * callback_fn(struct bpf_dynptr_t* dynptr, void *callback_ctx);
+	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
 	 */
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
-	callee->regs[BPF_REG_1].type = PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
+	mark_dynptr_cb_reg(&callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
 	/* unused */
@@ -7687,7 +7785,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	regs = cur_regs(env);
 
+	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
+	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
+	 * is safe to do directly.
+	 */
 	if (meta.uninit_dynptr_regno) {
+		if (regs[meta.uninit_dynptr_regno].type == CONST_PTR_TO_DYNPTR) {
+			verbose(env, "verifier internal error: CONST_PTR_TO_DYNPTR cannot be initialized\n");
+			return -EFAULT;
+		}
 		/* we write BPF_DW bits (8 bytes) at a time */
 		for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
 			err = check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
@@ -7705,15 +7811,24 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	if (meta.release_regno) {
 		err = -EINVAL;
-		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
+		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
+		 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
+		 * is safe to do directly.
+		 */
+		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
+			if (regs[meta.release_regno].type == CONST_PTR_TO_DYNPTR) {
+				verbose(env, "verifier internal error: CONST_PTR_TO_DYNPTR cannot be released\n");
+				return -EFAULT;
+			}
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
-		else if (meta.ref_obj_id)
+		} else if (meta.ref_obj_id) {
 			err = release_reference(env, meta.ref_obj_id);
-		/* meta.ref_obj_id can only be 0 if register that is meant to be
-		 * released is NULL, which must be > R0.
-		 */
-		else if (register_is_null(&regs[meta.release_regno]))
+		} else if (register_is_null(&regs[meta.release_regno])) {
+			/* meta.ref_obj_id can only be 0 if register that is meant to be
+			 * released is NULL, which must be > R0.
+			 */
 			err = 0;
+		}
 		if (err) {
 			verbose(env, "func %s#%d reference has not been acquired before\n",
 				func_id_name(func_id), func_id);
@@ -7787,11 +7902,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 					return -EFAULT;
 				}
 
-				if (base_type(reg->type) != PTR_TO_DYNPTR)
-					/* Find the id of the dynptr we're
-					 * tracking the reference of
-					 */
-					meta.ref_obj_id = stack_slot_get_id(env, reg);
+				meta.ref_obj_id = dynptr_ref_obj_id(env, reg);
 				break;
 			}
 		}
@@ -8848,12 +8959,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
 			if (reg->type != PTR_TO_STACK &&
-			    reg->type != PTR_TO_DYNPTR) {
+			    reg->type != CONST_PTR_TO_DYNPTR) {
 				verbose(env, "arg#%d expected pointer to stack or dynptr_ptr\n", i);
 				return -EINVAL;
 			}
 
-			ret = process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, NULL);
+			ret = process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR | MEM_RDONLY, NULL);
 			if (ret < 0)
 				return ret;
 			break;
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index fdb0aff8cb5a..e8d90829f23e 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -752,6 +752,7 @@ class PrinterHelpers(Printer):
             'struct bpf_timer',
             'struct mptcp_sock',
             'struct bpf_dynptr',
+            'const struct bpf_dynptr',
             'struct iphdr',
             'struct ipv6hdr',
     }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f89de51a45db..464ca3f01fe7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5293,7 +5293,7 @@ union bpf_attr {
  *	Return
  *		Nothing. Always succeeds.
  *
- * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset, u64 flags)
+ * long bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr *src, u32 offset, u64 flags)
  *	Description
  *		Read *len* bytes from *src* into *dst*, starting from *offset*
  *		into *src*.
@@ -5303,7 +5303,7 @@ union bpf_attr {
  *		of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
  *		*flags* is not 0.
  *
- * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
+ * long bpf_dynptr_write(const struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
@@ -5313,7 +5313,7 @@ union bpf_attr {
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
  *		is a read-only dynptr or if *flags* is not 0.
  *
- * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u32 offset, u32 len)
  *	Description
  *		Get a pointer to the underlying dynptr data.
  *
@@ -5414,7 +5414,7 @@ union bpf_attr {
  *		Drain samples from the specified user ring buffer, and invoke
  *		the provided callback for each such sample:
  *
- *		long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
+ *		long (\*callback_fn)(const struct bpf_dynptr \*dynptr, void \*ctx);
  *
  *		If **callback_fn** returns 0, the helper will continue to try
  *		and drain the next sample, up to a maximum of
diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index 02b18d018b36..aefa0a474e58 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -673,8 +673,8 @@ static struct {
 	{"user_ringbuf_callback_write_forbidden", "invalid mem access 'dynptr_ptr'"},
 	{"user_ringbuf_callback_null_context_write", "invalid mem access 'scalar'"},
 	{"user_ringbuf_callback_null_context_read", "invalid mem access 'scalar'"},
-	{"user_ringbuf_callback_discard_dynptr", "arg 1 is an unacquired reference"},
-	{"user_ringbuf_callback_submit_dynptr", "arg 1 is an unacquired reference"},
+	{"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
+	{"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
 	{"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
 };
 
-- 
2.38.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818A3602DB0
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiJRN7m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 09:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiJRN7j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA62B6276
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so13384499pgb.6
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2PHPXhpAuJEPOETNHp23e+7fBIW1mr8BiqDC16XPmw=;
        b=iyUNhhzTFw9mORBjMVNQoi2Xz9aF0GLljmSP/1I3Mfu1UbVx6roAA1sCnKnSCCqw5K
         fqSCC3j6wPCzPa6DR3BAfpTqoUYzWCAfg95qz3A4Uq5LRNkaK1gGmYkwuPgQWkk30dJN
         HFR11OZXmrFiMgy1c645z63KtaIWUBwWk6IHn12d2vXgxMToXCffrI7oj2uKi4d1F+zq
         fPp7fpzStzKbJlkn/eWcqgjPH23m50o77mKudvRTbobHty/5vg4+Hu/yT1l7itg5E+nM
         Fo+dtInQfPyINLk5rJooEYYBGI6w7GXVgKuyR5uZvLN2HOJqtB/q3oV9W+qSRTvkSsyH
         66Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2PHPXhpAuJEPOETNHp23e+7fBIW1mr8BiqDC16XPmw=;
        b=149yav7b2x+5tfZfiwzurO3u3m22xegE1vj0DShbNHaob5oIwLG/adKm8I5nqLr7Q8
         CroCSpszhAOlYzvrZiJP+haS9I+xR9CMDEu25p41ocgBgbrqPdwbTfQN7zL/D3JDleSP
         K5qtV54Hs8JUR5jUmGNA/d+NnTWgFeYCzYR7tgNSyP2BDpyp//SEO4mCMTZUa9X9/cjq
         9HrSbrImWIVDwqwXtadyodd8i6hSR6BJDOsUF/BlBx1eE/R5avWsF54roLcsgP7fx7Fh
         dgqUzVNKwN50SblLiNMRDb5jd5IBu3Tue3oaFKBkDQaRg4Ke3Oh9fyW7MvtK+9yNrAUG
         PLvg==
X-Gm-Message-State: ACrzQf1rLk7uU+JTSKmLAoX6DFIs0zgW6jrpmLckI6NBdJsFxNYoBwl9
        BkDMXZQpzUUy616f+UH1clLF/qA7YJQYnA==
X-Google-Smtp-Source: AMsMyM5JNaHiqQXeJxdYPC1YkDl24jEdurrWgDTIcu0+Aql4AS++fz3My6k9Ndn6uwa/3mykqdiz9Q==
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id v13-20020a63464d000000b004415968cd0emr2827884pgk.595.1666101575910;
        Tue, 18 Oct 2022 06:59:35 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id g19-20020aa796b3000000b00528a097aeffsm9289819pfk.118.2022.10.18.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:35 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 02/13] bpf: Rework process_dynptr_func
Date:   Tue, 18 Oct 2022 19:29:09 +0530
Message-Id: <20221018135920.726360-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27742; i=memxor@gmail.com; h=from:subject; bh=+YQU9nIozIV1W0Qg3WMdBYzp7Eip+Fp7mUm5J+auNZM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEiqtfNZAX77LoMYo5YYfrFEyS8zZaqgs3MaNdf xYGEZjWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RyuNXD/ 0SMt3J5g37rW8FhcWTJxDHISLUKfNaR+XmWrPHNdef0zztx94/DzccjuCrAO9xczlSs2ACXmodKUGM VKsM1eAKHqFH6YeV+CCgvxDL92KK2BxWLVCNci5voBpRcZ1W0FqlHKjvXex7SKcFgOZBr6JNs9bPn9 qFdEedo+LUtfs8rdiOZa5f+dPm7xdpP+bhVO4R/w8tria+BRWjppAHFH+IiWZ4A2lTNp+Q+T59q6ru s3A3FfMtZHgzuEI9TRs1LPPPbpLiBUvThBTsqWStc0IyG5nAlIkLcO4LowzDOoaC6JMRZajf7MwhYi ISFS5oJKFQRE+FJOplG6QPv8XpzmfRglY5zKoHjTn4lZx6UpS719hvi7K078J2gtiWDZQesXkFz1wg 6ZRVBTi82cw0fDXvbwRS60Zne9AceXHgC02xv9QxUW1QyA92+gC1hfUnx7nqWAlYTZdslX0c3TWiXW 7lo8KZwX3a7J9NbgCfnftGxZfG6kfUfVIFqpAIQ68sCQSwWpMK/WxU8uI+GA4bg2TpFXFVP4hH8vCC P1AWvbl6G1+r6U744DoB2pnmzvmDNT3CwpEeBZ8cuOV3GADH4V/pq78ZAfLOeZyH8OZwHVFlVNlMO0 pLjlMMEGwRbq8zJ5FLyDPJm/YKy4g0IFUfmCcq83Bk37Nuipru+6NZ3X66rA==
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
Secondly, in the future, there are plans to dynptr helpers that operate
on the dynptr itself and may change its offset and other properties.

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
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |   4 +-
 include/uapi/linux/bpf.h                      |   8 +-
 kernel/bpf/btf.c                              |   7 +-
 kernel/bpf/helpers.c                          |  18 +-
 kernel/bpf/verifier.c                         | 203 ++++++++++++++----
 scripts/bpf_doc.py                            |   1 +
 tools/include/uapi/linux/bpf.h                |   8 +-
 .../selftests/bpf/prog_tests/user_ringbuf.c   |  10 +-
 8 files changed, 185 insertions(+), 74 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..13c6ff2de540 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -656,7 +656,7 @@ enum bpf_reg_type {
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
-	PTR_TO_DYNPTR,		 /* reg points to a dynptr */
+	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
 	__BPF_REG_TYPE_MAX,
 
 	/* Extended reg_types. */
@@ -2689,7 +2689,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
-u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
+u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 17f61338f8f8..2b490bde85a6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5282,7 +5282,7 @@ union bpf_attr {
  *	Return
  *		Nothing. Always succeeds.
  *
- * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset, u64 flags)
+ * long bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr *src, u32 offset, u64 flags)
  *	Description
  *		Read *len* bytes from *src* into *dst*, starting from *offset*
  *		into *src*.
@@ -5292,7 +5292,7 @@ union bpf_attr {
  *		of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
  *		*flags* is not 0.
  *
- * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
+ * long bpf_dynptr_write(const struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
@@ -5302,7 +5302,7 @@ union bpf_attr {
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
  *		is a read-only dynptr or if *flags* is not 0.
  *
- * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u32 offset, u32 len)
  *	Description
  *		Get a pointer to the underlying dynptr data.
  *
@@ -5403,7 +5403,7 @@ union bpf_attr {
  *		Drain samples from the specified user ring buffer, and invoke
  *		the provided callback for each such sample:
  *
- *		long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
+ *		long (\*callback_fn)(const struct bpf_dynptr \*dynptr, void \*ctx);
  *
  *		If **callback_fn** returns 0, the helper will continue to try
  *		and drain the next sample, up to a maximum of
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 1827d889e08a..b6cd91c23a27 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6479,14 +6479,15 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				}
 
 				if (arg_dynptr) {
-					if (reg->type != PTR_TO_STACK) {
-						bpf_log(log, "arg#%d pointer type %s %s not to stack\n",
+					if (reg->type != PTR_TO_STACK &&
+					    reg->type != CONST_PTR_TO_DYNPTR) {
+						bpf_log(log, "arg#%d pointer type %s %s not to stack or dynptr\n",
 							i, btf_type_str(ref_t),
 							ref_tname);
 						return -EINVAL;
 					}
 
-					if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, i, NULL))
+					if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR | MEM_RDONLY, i, NULL))
 						return -EINVAL;
 					continue;
 				}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a6b04faed282..0a4017eb3616 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1398,7 +1398,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
 
-static bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
+static bool bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
@@ -1408,7 +1408,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
@@ -1432,7 +1432,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 	memset(ptr, 0, sizeof(*ptr));
 }
 
-static int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
+static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
 {
 	u32 size = bpf_dynptr_get_size(ptr);
 
@@ -1477,7 +1477,7 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
 	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
 };
 
-BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src,
+BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
 	   u32, offset, u64, flags)
 {
 	int err;
@@ -1500,12 +1500,12 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
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
@@ -1526,14 +1526,14 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
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
 
@@ -1554,7 +1554,7 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
 	.func		= bpf_dynptr_data,
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_DYNPTR_MEM_OR_NULL,
-	.arg1_type	= ARG_PTR_TO_DYNPTR,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | MEM_RDONLY,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 31c0c999448e..87d9cccd1623 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -563,7 +563,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		[PTR_TO_BUF]		= "buf",
 		[PTR_TO_FUNC]		= "func",
 		[PTR_TO_MAP_KEY]	= "map_key",
-		[PTR_TO_DYNPTR]		= "dynptr_ptr",
+		[CONST_PTR_TO_DYNPTR]	= "dynptr",
 	};
 
 	if (type & PTR_MAYBE_NULL) {
@@ -697,6 +697,27 @@ static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 	return type == BPF_DYNPTR_TYPE_RINGBUF;
 }
 
+static void __mark_dynptr_regs(struct bpf_reg_state *reg1,
+			       struct bpf_reg_state *reg2,
+			       enum bpf_dynptr_type type);
+
+static void __mark_reg_not_init(const struct bpf_verifier_env *env,
+				struct bpf_reg_state *reg);
+
+static void mark_dynptr_stack_regs(struct bpf_reg_state *sreg1,
+				   struct bpf_reg_state *sreg2,
+				   enum bpf_dynptr_type type)
+{
+	__mark_dynptr_regs(sreg1, sreg2, type);
+}
+
+static void mark_dynptr_cb_reg(struct bpf_reg_state *reg1,
+			       enum bpf_dynptr_type type)
+{
+	__mark_dynptr_regs(reg1, NULL, type);
+}
+
+
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx)
 {
@@ -718,9 +739,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (type == BPF_DYNPTR_TYPE_INVALID)
 		return -EINVAL;
 
-	state->stack[spi].spilled_ptr.dynptr.first_slot = true;
-	state->stack[spi].spilled_ptr.dynptr.type = type;
-	state->stack[spi - 1].spilled_ptr.dynptr.type = type;
+	mark_dynptr_stack_regs(&state->stack[spi].spilled_ptr,
+			       &state->stack[spi - 1].spilled_ptr, type);
 
 	if (dynptr_type_refcounted(type)) {
 		/* The id is used to track proper releasing */
@@ -728,8 +748,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 		if (id < 0)
 			return id;
 
-		state->stack[spi].spilled_ptr.id = id;
-		state->stack[spi - 1].spilled_ptr.id = id;
+		state->stack[spi].spilled_ptr.ref_obj_id = id;
+		state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
 	}
 
 	return 0;
@@ -751,25 +771,23 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
 
+	if (reg->type == CONST_PTR_TO_DYNPTR)
+		return false;
+
+	spi = get_spi(reg->off);
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return true;
 
@@ -785,9 +803,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
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
@@ -806,15 +829,21 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type dynptr_type;
-	int spi = get_spi(reg->off);
+	int spi;
 
+	/* Fold MEM_RDONLY, caller already checked it */
+	arg_type &= ~MEM_RDONLY;
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
@@ -1317,9 +1346,6 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
 	BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
 };
 
-static void __mark_reg_not_init(const struct bpf_verifier_env *env,
-				struct bpf_reg_state *reg);
-
 /* This helper doesn't clear reg->id */
 static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
@@ -1382,6 +1408,25 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
 	__mark_reg_known_zero(regs + regno);
 }
 
+static void __mark_dynptr_regs(struct bpf_reg_state *reg1,
+			       struct bpf_reg_state *reg2,
+			       enum bpf_dynptr_type type)
+{
+	/* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
+	 * callback arguments, it does need to be CONST_PTR_TO_DYNPTR.
+	 */
+	__mark_reg_known_zero(reg1);
+	reg1->type = CONST_PTR_TO_DYNPTR;
+	reg1->dynptr.type = type;
+	reg1->dynptr.first_slot = true;
+	if (!reg2)
+		return;
+	__mark_reg_known_zero(reg2);
+	reg2->type = CONST_PTR_TO_DYNPTR;
+	reg2->dynptr.type = type;
+	reg2->dynptr.first_slot = false;
+}
+
 static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 {
 	if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
@@ -5571,19 +5616,62 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+/* Implementation details:
+ *
+ * There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
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
 			enum bpf_arg_type arg_type, int argno,
 			u8 *uninit_dynptr_regno)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 
-	/* We only need to check for initialized / uninitialized helper
-	 * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
-	 * assumption is that if it is, that a helper function
-	 * initialized the dynptr on behalf of the BPF program.
+	if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
+		verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
+		return -EFAULT;
+	}
+
+	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
+	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
+	 *
+	 *  MEM_UNINIT - Points to memory that is an appropriate candidate for
+	 *		 constructing a mutable bpf_dynptr object.
+	 *
+	 *		 Currently, this is only possible with PTR_TO_STACK
+	 *		 pointing to a region of atleast 16 bytes which doesn't
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
@@ -5597,9 +5685,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			verbose(env, "verifier internal error: multiple uninitialized dynptr args\n");
 			return -EFAULT;
 		}
-
 		*uninit_dynptr_regno = regno;
 	} else {
+		/* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
+		if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
+			verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
+			return -EINVAL;
+		}
+
 		if (!is_dynptr_reg_valid_init(env, reg)) {
 			verbose(env,
 				"Expected an initialized dynptr as arg #%d\n",
@@ -5607,6 +5700,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 
+		arg_type &= ~MEM_RDONLY;
 		if (!is_dynptr_type_expected(env, reg, arg_type)) {
 			const char *err_extra = "";
 
@@ -5762,7 +5856,7 @@ static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } }
 static const struct bpf_reg_types dynptr_types = {
 	.types = {
 		PTR_TO_STACK,
-		PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
+		CONST_PTR_TO_DYNPTR,
 	}
 };
 
@@ -5938,12 +6032,15 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
 
-static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi = get_spi(reg->off);
+	int spi;
 
-	return state->stack[spi].spilled_ptr.id;
+	if (reg->type == CONST_PTR_TO_DYNPTR)
+		return reg->ref_obj_id;
+	spi = get_spi(reg->off);
+	return state->stack[spi].spilled_ptr.ref_obj_id;
 }
 
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
@@ -6007,11 +6104,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	if (arg_type_is_release(arg_type)) {
 		if (arg_type_is_dynptr(arg_type)) {
 			struct bpf_func_state *state = func(env, reg);
-			int spi = get_spi(reg->off);
+			int spi;
 
-			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
-			    !state->stack[spi].spilled_ptr.id) {
-				verbose(env, "arg %d is an unacquired reference\n", regno);
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
@@ -6946,11 +7049,10 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
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
@@ -7328,6 +7430,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	regs = cur_regs(env);
 
+	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
+	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
+	 * is safe to do.
+	 */
 	if (meta.uninit_dynptr_regno) {
 		/* we write BPF_DW bits (8 bytes) at a time */
 		for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
@@ -7346,6 +7452,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	if (meta.release_regno) {
 		err = -EINVAL;
+		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
+		 * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
+		 * is safe to do.
+		 */
 		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
 			err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
 		else if (meta.ref_obj_id)
@@ -7428,11 +7538,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 					return -EFAULT;
 				}
 
-				if (base_type(reg->type) != PTR_TO_DYNPTR)
-					/* Find the id of the dynptr we're
-					 * tracking the reference of
-					 */
-					meta.ref_obj_id = stack_slot_get_id(env, reg);
+				/* Find the id of the dynptr we're
+				 * tracking the reference of
+				 */
+				meta.ref_obj_id = dynptr_ref_obj_id(env, reg);
 				break;
 			}
 		}
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index c0e6690be82a..2865f2b22eca 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -750,6 +750,7 @@ class PrinterHelpers(Printer):
             'struct bpf_timer',
             'struct mptcp_sock',
             'struct bpf_dynptr',
+            'const struct bpf_dynptr',
             'struct iphdr',
             'struct ipv6hdr',
     }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 17f61338f8f8..2b490bde85a6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5282,7 +5282,7 @@ union bpf_attr {
  *	Return
  *		Nothing. Always succeeds.
  *
- * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset, u64 flags)
+ * long bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr *src, u32 offset, u64 flags)
  *	Description
  *		Read *len* bytes from *src* into *dst*, starting from *offset*
  *		into *src*.
@@ -5292,7 +5292,7 @@ union bpf_attr {
  *		of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
  *		*flags* is not 0.
  *
- * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
+ * long bpf_dynptr_write(const struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
  *	Description
  *		Write *len* bytes from *src* into *dst*, starting from *offset*
  *		into *dst*.
@@ -5302,7 +5302,7 @@ union bpf_attr {
  *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
  *		is a read-only dynptr or if *flags* is not 0.
  *
- * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u32 offset, u32 len)
  *	Description
  *		Get a pointer to the underlying dynptr data.
  *
@@ -5403,7 +5403,7 @@ union bpf_attr {
  *		Drain samples from the specified user ring buffer, and invoke
  *		the provided callback for each such sample:
  *
- *		long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
+ *		long (\*callback_fn)(const struct bpf_dynptr \*dynptr, void \*ctx);
  *
  *		If **callback_fn** returns 0, the helper will continue to try
  *		and drain the next sample, up to a maximum of
diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
index 02b18d018b36..39882580cb90 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -668,13 +668,13 @@ static struct {
 	const char *expected_err_msg;
 } failure_tests[] = {
 	/* failure cases */
-	{"user_ringbuf_callback_bad_access1", "negative offset dynptr_ptr ptr"},
-	{"user_ringbuf_callback_bad_access2", "dereference of modified dynptr_ptr ptr"},
-	{"user_ringbuf_callback_write_forbidden", "invalid mem access 'dynptr_ptr'"},
+	{"user_ringbuf_callback_bad_access1", "negative offset dynptr ptr"},
+	{"user_ringbuf_callback_bad_access2", "dereference of modified dynptr ptr"},
+	{"user_ringbuf_callback_write_forbidden", "invalid mem access 'dynptr'"},
 	{"user_ringbuf_callback_null_context_write", "invalid mem access 'scalar'"},
 	{"user_ringbuf_callback_null_context_read", "invalid mem access 'scalar'"},
-	{"user_ringbuf_callback_discard_dynptr", "arg 1 is an unacquired reference"},
-	{"user_ringbuf_callback_submit_dynptr", "arg 1 is an unacquired reference"},
+	{"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
+	{"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
 	{"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
 };
 
-- 
2.38.0


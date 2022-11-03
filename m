Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8E0618851
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiKCTLk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiKCTLa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B6D1DA4A
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y203so2519544pfb.4
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWTuhUdTsoJJMSoUXUiqcLtS/v42WScBtGllQKlBmG8=;
        b=TjTpY/ZQAnu40D2SnEhJc2fvBa7Oqz7O8r9f3ddHrW2+mQTGEEsJraQqk6OQmFN+U5
         /Hkil3epRGo83JcQFBLomZzTeOYU8cwruzMDs5xGK3H+Duy2PjUTgAdxMFdDFM18N0n7
         kxFvrq/LYoCqkXZ5+V5f5aKocwlEfDYyYiUkX9HGWhl+JXzmfVaDaKeVs382S6zK+rmZ
         LPO6bqk0vR6u+uCKH4yo9PTgxHYi/h5J427GlZsmIIE+D9hbJRz4IM78kbcm/KhdHG3X
         CTbVkbFG15bzphYzHofKTWCriYBcsrJNU3ehasVEdvFF6xY2iKB7fhbgfWOwZrlFEtEs
         Or8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWTuhUdTsoJJMSoUXUiqcLtS/v42WScBtGllQKlBmG8=;
        b=b6hhmqrd82zvTkm6u6sdTx6TpvY4/NMj9U9bS6eudkueK76XV4u0nSRcxT1mR7rx6x
         R1QH9U26t/JV4X3f3zc2wQ7UPparkRPUjJgijUZVBl/YG/cCFks3eC8NXkXLrEMGYkKz
         loXDhEgDUOXj+OibyMNxBKjCsJeujCLhy4dh8Uo6D8NUc7s7MPRlyISJNFcf/iOpk0Ol
         tKjkMHcW9QeZmeRQ6Upd1I+Y5zcqJHU5jUz2OHsTBYqbvZvZHuyxErJUNeAH/1SmFvQO
         fRQNyY4H7pxxktNoT/bO0DuQTA/x5maOJFJi6IdAgLLa+JrYNiBhuG4gi7fqN7QAfv1V
         Aa8w==
X-Gm-Message-State: ACrzQf2WMFxmQnr/yL+5I5j5U6kQx4yjIowV6owPrJNsrkfvQ236iK42
        AeuQRfseH4jMEN23aWTakeOWXbq9YDHVkg==
X-Google-Smtp-Source: AMsMyM7k/dBLZ6pSeQjAu/SN5Yak9qcwY2V+IUQMC3cpfSzvv6Gob42xTlCKjEWzEv/W5NBPw71VAw==
X-Received: by 2002:a05:6a00:1f0e:b0:56e:1ce2:a4fd with SMTP id be14-20020a056a001f0e00b0056e1ce2a4fdmr8728669pfb.76.1667502689346;
        Thu, 03 Nov 2022 12:11:29 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001868981a18esm1061295plt.6.2022.11.03.12.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:28 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 17/24] bpf: Support constant scalar arguments for kfuncs
Date:   Fri,  4 Nov 2022 00:40:06 +0530
Message-Id: <20221103191013.1236066-18-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6081; i=memxor@gmail.com; h=from:subject; bh=CZNnVG4cpb7gTpxmPgHM5Y8cbZqvBrdHtioKiFAhX70=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIBHW4DihBG67QYjD2mQijkOvxnAyypCXtIBDEI 3Y5LhquJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAQAKCRBM4MiGSL8RyqgBD/ 4ouzl2MSSCOH6DZxlmSkW1a035kSpsfxYialxyCdQkskKnZq4X90XDwguWcfNNzpdAS1OKL8mUmIat hh1UO6RF2D6oy8cfMtkcbculEGpNqnR1DbABflSt61zfdLJ4+VX1xDwn9Qh6oJS22M6NAEJEcIcVTi 1k7iBbi9bZTR0uwSgwGi/kJNABGsveg20zJXGR/e3Mu97W+jt1W5n8sAe85X4ZjK84nzHeWk3heq30 T02VsPEtuOh92lTbRWSsPtlzqc3V6bJo5q0tk+0DQIXsVy0mpSgCSILEuziC6b9PPR8ljIqu7QBPHo ly+iNe1748sEtrMedNK4a0hzjuQc+tmL2iL1BU3ZMZq3jxv02oiG8S4jHqDOhq2rNa49+yifHRVTP/ 3lolBtq9MiZajMh4uojBw1qni9J8raW4h6d77iNTTUib+XXnqASXXYUDoli6XJ4L3HxcxvKOoDK1pG oSxPym6G9ashxmJfHXIi0DfuPQj4d4YegjU/DZX6dRQ8nUidWHnztCW4LcDMCuePA4aOKfOOHIIaum T3yqc96uBuy31QMFcenPmEGbjfGRb8qC3BEWIwAJVOWlsoIPonvlWA5O36yxzmfjswpNbYtQPV0SIO AlEte8+CMt23QVZlBXnFSXlrk+SlZz9VkGJfanxyon5gyeeAaQ/SYfjLICKQ==
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

Allow passing known constant scalars as arguments to kfuncs that do not
represent a size parameter. This makes the search pruning optimization
of verifier more conservative for such kfunc calls, and each
non-distinct argument is considered unequivalent.

We will use this support to then expose a global bpf_kptr_alloc function
where it takes the local type ID in program BTF, and returns a
PTR_TO_BTF_ID to the local type. These will be called local kptrs, and
allows programs to allocate their own objects.

However, this is still not completely safe, as mark_chain_precision
logic is buggy without more work when the constant argument is not a
size, but still needs precise marker propagation for pruning checks.
Next patch will fix this problem.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 30 ++++++++++++++++++
 kernel/bpf/verifier.c        | 59 +++++++++++++++++++++++++++---------
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0f858156371d..08f9a968d06d 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -72,6 +72,36 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
+2.2.1 __k Annotation
+--------------------
+
+This annotation is only understood for scalar arguments, where it indicates that
+the verifier must check the scalar argument to be a known constant, which does
+not indicate a size parameter. This distinction is important, as when the scalar
+argument does not represent a size parameter, verifier is more conservative in
+state search pruning and does not consider two arguments equivalent for safety
+purposes if the already verified value was within range of the new one.
+
+This assumption holds well for sizes (as memory accessed within smaller bounds
+in old verified state will also work for bigger bounds in current to be explored
+state), but not for other constant arguments where each carries a distinct
+semantic effect.
+
+An example is given below::
+
+        void *bpf_mem_alloc(u32 local_type_id__k)
+        {
+        ...
+        }
+
+Here, bpf_mem_alloc uses local_type_id argument to find out the size of that
+type ID in program's BTF and return a sized pointer to it. Each type ID will
+have a distinct size, hence it is crucial to treat each such call as distinct
+when values don't match.
+
+Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
+size parameter, __k suffix must be used.
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index effc417cc086..b22ad48bbecd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7687,6 +7687,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7724,30 +7728,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
 	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
 }
 
-static bool is_kfunc_arg_mem_size(const struct btf *btf,
-				  const struct btf_param *arg,
-				  const struct bpf_reg_state *reg)
+static bool __kfunc_param_match_suffix(const struct btf *btf,
+				       const struct btf_param *arg,
+				       const char *suffix)
 {
-	int len, sfx_len = sizeof("__sz") - 1;
-	const struct btf_type *t;
+	int suffix_len = strlen(suffix), len;
 	const char *param_name;
 
-	t = btf_type_skip_modifiers(btf, arg->type, NULL);
-	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
-		return false;
-
 	/* In the future, this can be ported to use BTF tagging */
 	param_name = btf_name_by_offset(btf, arg->name_off);
 	if (str_is_empty(param_name))
 		return false;
 	len = strlen(param_name);
-	if (len < sfx_len)
+	if (len < suffix_len)
 		return false;
-	param_name += len - sfx_len;
-	if (strncmp(param_name, "__sz", sfx_len))
+	param_name += len - suffix_len;
+	return !strncmp(param_name, suffix, suffix_len);
+}
+
+static bool is_kfunc_arg_mem_size(const struct btf *btf,
+				  const struct btf_param *arg,
+				  const struct bpf_reg_state *reg)
+{
+	const struct btf_type *t;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_scalar(t) || reg->type != SCALAR_VALUE)
 		return false;
 
-	return true;
+	return __kfunc_param_match_suffix(btf, arg, "__sz");
+}
+
+static bool is_kfunc_arg_sfx_constant(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__k");
 }
 
 static bool is_kfunc_arg_ret_buf_size(const struct btf *btf,
@@ -8023,7 +8037,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "R%d is not a scalar\n", regno);
 				return -EINVAL;
 			}
-			if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdonly_buf_size")) {
+			if (is_kfunc_arg_sfx_constant(meta->btf, &args[i])) {
+				/* kfunc is already bpf_capable() only, no need
+				 * to check it here.
+				 */
+				if (meta->arg_constant.found) {
+					verbose(env, "verifier internal error: only one constant argument permitted\n");
+					return -EFAULT;
+				}
+				if (!tnum_is_const(reg->var_off)) {
+					verbose(env, "R%d must be a known constant\n", regno);
+					return -EINVAL;
+				}
+				ret = mark_chain_precision(env, regno);
+				if (ret < 0)
+					return ret;
+				meta->arg_constant.found = true;
+				meta->arg_constant.value = reg->var_off.value;
+			} else if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdonly_buf_size")) {
 					meta->r0_rdonly = true;
 					is_ret_buf_sz = true;
 			} else if (is_kfunc_arg_ret_buf_size(btf, &args[i], reg, "rdwr_buf_size")) {
-- 
2.38.1


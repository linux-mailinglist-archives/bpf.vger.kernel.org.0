Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9754262E1AC
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbiKQQ0y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbiKQQ00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:26 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C07C44F
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:29 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso5839941pjg.5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eADGO9O0PgU+rJUyTCDLhtk/CaV3wC5RG4davPZNCZE=;
        b=ntehd7qOE3ZwYALKhLqxgkFx0NJiWalnrcOJ6qlbxRTqOSHwT5D4yn2IP6cmaUjIWo
         EC8wnS6hN38xi0xjsUtc/CeukRxGbViox0dG4gvJfo+XKgZ6mYLhqE/FQMlIwRg41F+R
         mxgSsGRu922W5ecFicDcaPms2e0R4fjW6VORADV04E4xwoaNc4Bq1idCt/2L+7kpDe4f
         re9Ms07HECwh+dkZJmL407EqDzpp9v401kioQyyMTnvy6vS9WLhX0bzxSsSbShOoXv/Q
         KaEIuz0sPadzsCggWxxOBtLvZET3VM64/BUu9s2hcAROAFDJpgTGswHaAs0PRnocPIKg
         4ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eADGO9O0PgU+rJUyTCDLhtk/CaV3wC5RG4davPZNCZE=;
        b=cUu8gGVaOc0N1+OoUDVJi9yncDGzqnTiOcvdHYILTxo3oPaN28+ucz+GnrHSBgqn3M
         t5LmbT3yc/jx36yx5d9V05mnFipeatCGySeYjUNxQG3VQeaVF1z7b63+0Y2mxs7pqkRe
         +R+fqGkklctyHsbm9khjXtBw7o6L8n2qSjpaE/0vvfsDnvjl7MQJb6dEOWKGGG/IPkPS
         ya6nxdnsiVIE6f9YYSXpAHCVAAG49vSNfyznXAhVRKOmgdJS1QTpRdHCCglHN1OesCHt
         AwGb0g+pfPVsDXFzReLPKTNzvrywVKAOstg6MbMNwiqOPN51C/1/9NnaOLBD/p+dbKRX
         qoCQ==
X-Gm-Message-State: ANoB5plDoMjE+GIrUMyMlz5t/tPqzT035MjVK9sDwcC/WI7WlrF7ovbs
        UxgtrIchsz06QtM2LynuNZEi3BMVibo=
X-Google-Smtp-Source: AA0mqf46wsYgHijXPFBkGIxLADcjCS7f2gTPAaCuQ7qRPAx3UgcxFctbncivFLawZaFEC4x/ASec6A==
X-Received: by 2002:a17:902:d502:b0:174:4ab2:6457 with SMTP id b2-20020a170902d50200b001744ab26457mr3427729plg.118.1668702329025;
        Thu, 17 Nov 2022 08:25:29 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00172e19c5f8bsm1596613pla.168.2022.11.17.08.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:28 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 12/22] bpf: Support constant scalar arguments for kfuncs
Date:   Thu, 17 Nov 2022 21:54:20 +0530
Message-Id: <20221117162430.1213770-13-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5687; i=memxor@gmail.com; h=from:subject; bh=u9Qjbd5URIRAYF6yjvJAaOF9VBbO7P61kGUXFF2hQC8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7/4DuaBoKZ23L+NfrC+h4L+X+ye0wfHKmzQ4Su b3KhvUaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/wAKCRBM4MiGSL8RymeJD/ 4zol2UskIStCtBrSFomsolKa8mWZPcdXa32lpgFnBHAmxIeGyxl7L7E3rTSPZL5s/Qj/WKJm3/N0mQ K6yiRuHMnzKkMVtpUuc9GtY5uwTHHOUhSxwi8NFZCiN1JSIKNvrZF/4qnVLxh/rHOuH0AAYTiBfZTj 8fvwcJkfx9t9s3xgerVbUUrCTUUkimYqftFHPXi7ce6zZBww7/eSr54nlA/Ony/4dKL35jQF8h0uE1 QMenojEnyyycVzzvU1bGfdVe0TvTO7fvaVnMeYSNOy7of4NVX1cC+FwsGL2Hvo3ke/vB88xrijlfXx LR/va75tuNlTnTsHE/W8qFLs5iT2OnMNAY4REkJ5EU5+wR6+SpUkU/DS02U3+/evi7W9l5H8sOblks nSiMZGF8pSOA4XtpkJUZkOdefGvpcdQyOaK6Th3IPBgAX5s11nnY72NMhT4B/xO1LkGNNIoDuaz2EZ BwiBidlCOJgqMWMzfw4Ch0FLXiHBI1JevJgNiMGRREIjEqK4kfESAtzd0G1/5Ch3E0KLW9OgjBnN9Y B19C8hI+J+1vuzO1AZkLx/okz0s9X7w45ErEc1y7mhCwP5Bx/kTP8m3tv8iKpPgm0yHaoeD7ZAjDlW aZtdwvSxmtSGp7ucPIVgy/88ZNE8DDLLUy3nVHpJ+I9d48C9jQ0K1MI+/JOQ==
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
represent a size parameter. We use mark_chain_precision for the constant
scalar argument to mark it precise. This makes the search pruning
optimization of verifier more conservative for such kfunc calls, and
each non-distinct argument is considered unequivalent.

We will use this support to then expose a bpf_obj_new function where it
takes the local type ID of a type in program BTF, and returns a
PTR_TO_BTF_ID | MEM_ALLOC to the local type, and allows programs to
allocate their own objects.

Each type ID resolves to a distinct type with a possibly distinct size,
hence the type ID constant matters in terms of program safety and its
precision needs to be checked between old and cur states inside regsafe.
The use of mark_chain_precision enables this.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 24 +++++++++++++++
 kernel/bpf/verifier.c        | 57 +++++++++++++++++++++++++++---------
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0f858156371d..3b1501c3b6cd 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -72,6 +72,30 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
+2.2.2 __k Annotation
+--------------------
+
+This annotation is only understood for scalar arguments, where it indicates that
+the verifier must check the scalar argument to be a known constant, which does
+not indicate a size parameter, and the value of the constant is relevant to the
+safety of the program.
+
+An example is given below::
+
+        void *bpf_obj_new(u32 local_type_id__k, ...)
+        {
+        ...
+        }
+
+Here, bpf_obj_new uses local_type_id argument to find out the size of that type
+ID in program's BTF and return a sized pointer to it. Each type ID will have a
+distinct size, hence it is crucial to treat each such call as distinct when
+values don't match during verifier state pruning checks.
+
+Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
+size parameter, and the value of the constant matters for program safety, __k
+suffix should be used.
+
 .. _BPF_kfunc_nodef:
 
 2.3 Using an existing kernel function
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d85ecc673631..293417e5d732 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7874,6 +7874,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7911,30 +7915,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
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
+static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__k");
 }
 
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
@@ -8204,7 +8218,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "R%d is not a scalar\n", regno);
 				return -EINVAL;
 			}
-			if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
+
+			if (is_kfunc_arg_constant(meta->btf, &args[i])) {
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
+			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdonly_buf_size")) {
 				meta->r0_rdonly = true;
 				is_ret_buf_sz = true;
 			} else if (is_kfunc_arg_scalar_with_name(btf, &args[i], "rdwr_buf_size")) {
-- 
2.38.1


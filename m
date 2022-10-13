Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142305FD4BD
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJMGYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJMGYW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC612EA57
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id pq16so1098773pjb.2
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thRXYODGkZhJAGjNygbPwNe/rZqkO2H0k9GRYqsaMnI=;
        b=oFVvFZoLVAvaaK6NUS38V9EdBjLM65gaHiSzI0h9vhjucT+q3pn1sylB26opTLHGuN
         vA33eNsc/A6BbJTob7ZRfe0hVW0bIFcbCAHIh/Oiqi8MPJGaZpIqzfkNH1WBACp+RKK2
         NqS1PkLiZ9h+X3WT7gd/5CRCEdnqcxQS+vyGVOo4LfDgZXwBJta+V3bDKJ/No/3/IrZI
         JKxgB4clIxwl09t+l5NFYC6VTf35cdOAR9So2wIes/wFtlA2aFzcPZkyHulq57NckKOO
         w+WKE7ifeWWwpw0hTsL8qhm87Y4RRtSTdb53LK3sZujUjVRHIJdzTtKbDcNrkq6lHew1
         eBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thRXYODGkZhJAGjNygbPwNe/rZqkO2H0k9GRYqsaMnI=;
        b=y+az3Hdcvf1VTMIRulaqMtPkXbmlME1tmNTjpOKldTKqyQ/KIwfHqFheZ5Z3InEG+G
         F85dFezoqZPxT88O1Fdjlk327ZOqsgKab3WdbwgcekUK2ZupTcYFFRHH1il1Jpsk6U2p
         muhjd9fIRg3GQoTAl5W+jx3gc8clyvmNjVSF9jT+XPBElC5cJW4JT8G3YwYEBgoF/YKJ
         wNS8zu1FtcgnrqLnzguFEI0ZIubUphcMPRhjFVqZyTRzKOdLeOJxOVdJ5daeZ94qIIkm
         /ePDQX8Fzf0ClrFXU9fNNGyirBvXk5bSYsD7YO5qGorYRsxHWeWio33DuUOUhiGWbwo0
         1XIA==
X-Gm-Message-State: ACrzQf2kUcnKRUT2nQqXcUxbZBpfgPgCHTBdaYfcWDI3OXds8m5i5TEC
        H5SJQeG3Nmm1ddwtKOu1QfcR+nzt2HI=
X-Google-Smtp-Source: AMsMyM7dvCq+C2H//MVxAZcM/Og2Ubg6yRaoBrGhLcY6XXtkwpJJjQfAKNXO3t5A1ttfweD9EeJjOg==
X-Received: by 2002:a17:902:ab06:b0:180:556e:1b5e with SMTP id ik6-20020a170902ab0600b00180556e1b5emr30824484plb.93.1665642260578;
        Wed, 12 Oct 2022 23:24:20 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id om7-20020a17090b3a8700b00200b12f2bf5sm5684704pjb.1.2022.10.12.23.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:20 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 17/25] bpf: Support constant scalar arguments for kfuncs
Date:   Thu, 13 Oct 2022 11:52:55 +0530
Message-Id: <20221013062303.896469-18-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6081; i=memxor@gmail.com; h=from:subject; bh=IMmWeXi4ScTk8RZZTE/txT0BmBUYW8l673MvtNJ51V0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67EV4T6S3zds4y7HihKMaK8+f2WQ5CGVEnIY4th ASaYrZuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8RyrheEA CzPFrE3lwbQ0wxOxOHogY8ssZkICZ1S7jy1b6V6wv0VeiF7rRSn4RGs+kDewW9HUl4NB/yGBNJAI81 6JdVRlLIs6hvgpqXaBYyXCWIRgHmCjPB9PbbE0Uj2ReQynnQgjT2nDO0ecfyWI7HS1Ex8460XfHgkC Uq/ay/JeVhWabxWhe7vs6rrDY1dg7sseW0kbdGDJ8x7rPIL/qFBv0D5u00s/ANrW0Lt3JtBzJFauCh Jtd6wiMm02LFB9i0zgJKpyv+YuMaaB7/szpX8Z0qTzjZ46ejFHCQZJ1UHwK0tz+9OEOwtLdknKCxGk 3m3QXygmJELvOHycd8ccY0R/KiG10iam8YvDzYvAcqzcIbEuhbrUA3mu9Oxl14nvtVOx4DFAtX2dkn mJ73xjwABWYsRyTCY9OHb8YeUaZ0hz1jBe9344eUwHYRpe+JIyvy+gI/hX98ZCHyMlJObdHLkdhkPE e/Q+6HKC0/0UGAQtA4hTc0v+n3vrec4mecTKG/OyMW1IYHh2/kIZWY+FV+h5WW7leGr8gs65sZtdnk ROWS69skrix+EZ2VkGwSitM1xF5GbDqmtk+smnuUC+l8L//uAK+hQWtxl5KtjZcdWUNhJbfyqD/wtH bpZ5GbOVdvdfb/23uy+WMNRsTVMjy954chUO1ur+glOjaDrLCxc6R0K/TcRA==
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
index 0ff021ab3064..7c3d7d07773f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7676,6 +7676,10 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u64 r0_size;
+	struct {
+		u64 value;
+		bool found;
+	} arg_constant;
 };
 
 static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
@@ -7713,30 +7717,40 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
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
@@ -8013,7 +8027,24 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
2.38.0


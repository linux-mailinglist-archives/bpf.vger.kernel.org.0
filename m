Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB74BC836
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 12:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiBSLiP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 06:38:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiBSLiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 06:38:13 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964F48E44
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:37:54 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x11so9121355pll.10
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mCuFSU0pgQmoZqeF4WCAOD5eINL/gG5jM8qfijaQs18=;
        b=APNb8jYC+z4iR/8/J/QngRmb3PNxGWLoDRWZo0/QZmCrraqH8pLsxhjCaDbMFRUlwQ
         5GjQuphKVIqhHPaGjF5C1YVyRepL09dYMvzqbVw9vMG1capxiO3PdMWBiYm4wB4EoChI
         Q/cTpTgv3rJattgWYCZsaUc4OV7aGebQik9G8VchT9pw1SLdSH9C+2f0l/LdHXJVmHoc
         plI1XEZ1Vk48EqlrMZ0bgeVzaM9mLTF4N7K8skfMobEe885pzslmW2PcWf0Mk0d6MMED
         Ts9KcClaAF9IZeJkV99K50Hpxd0aTQ3SIKQ4XOFG+pFpQNWiEGwmhAyUb62D8ipwPEew
         yS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCuFSU0pgQmoZqeF4WCAOD5eINL/gG5jM8qfijaQs18=;
        b=jI5sikRCKFMtWSz3ie5MQIEplhC+FBFHR/7t/66aKlnL9iyj+RV9yy21IlFiiKt7P5
         2L9EcPLCkIfnZfa4XVtg/2b8PS0xc0E7U36AlEOB2GiGenKFFBNtLpEv3cbS6Qz8BITW
         1pHUcRJZ7oT1b5XW+M9AuJ9T4vh92c9UdwuPW9BBKU2GC6eFl/fJyHLKT+z9fufVcrk2
         QNnv83RcL/BkKmck2vk2EX8a5RhSFTEdjUvlJoYW88IewtJzNUpfK1q+LyO+1YwxTLVy
         G/Wrv0OnRGxHbt7EiwHiE+RuMa/WBujVwNYUplCbK5RV/AeJ/r7VlGnHILTvSnb7deVl
         5hjg==
X-Gm-Message-State: AOAM530xCo77ZFw/1DE5moVcXAGbr0sb7Foqfi+F+7YFn165Njal71Qt
        7q4h2b/mzcUBbGle9ec+WmOmJ9USiZ4=
X-Google-Smtp-Source: ABdhPJyPlyAYbt/QrlFkG7sxRqWTniiSKvqKaq4slhNoZ9UajMxRMP1tNkEjbKPQdqCf08iZ3R/ABA==
X-Received: by 2002:a17:90b:1c88:b0:1b8:a77e:c9cb with SMTP id oo8-20020a17090b1c8800b001b8a77ec9cbmr16984438pjb.205.1645270673922;
        Sat, 19 Feb 2022 03:37:53 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id s6sm6167914pfk.86.2022.02.19.03.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:37:53 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v1 2/5] bpf: Restrict PTR_TO_BTF_ID offset to PAGE_SIZE when calling helpers
Date:   Sat, 19 Feb 2022 17:07:41 +0530
Message-Id: <20220219113744.1852259-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220219113744.1852259-1-memxor@gmail.com>
References: <20220219113744.1852259-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5603; h=from:subject; bh=JEFi8M1tQOcvCBGazVGbjS/2QIJA8KH1a58rRSZJ2G8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiENZ5P6yW1hOHylogdidZ9FgbqOwilqcn3PaRJm2B c1g2z1uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYhDWeQAKCRBM4MiGSL8RyuPPEA CXcpDxfBaCmQOG3fXew/rAsWSSeAHRxwYoCFwk3FI1fKD1JslhljQhr+XbKAMJQYIcwm8V0ioxwjYK kCulT2NwmJCpyAdjFSNEUkGx1bhws13TIJOYcDijLPXkfzoYXWBjhpmeGK811P6wiQPM2VO/64yDOz +dVDkf62MZpo7dCebhxilcY6IN4aqDqtI9xWE9C63Ojc1Ha82hYpPAY2G+cVd8xaweX95tqVv8ruOs FvS/s+b/daEEpYpqKPw4yj8YWyv5zDKj2GZ2yCl9ZNm7f17an0ZEHeDMdM2Yi+qHGEsm67GkiYgP02 y8OGAis1P4uALNYDKxoK6U3091EXGoxqqYgPbpIhmNrjMg1nCefCl406SAF558zEFr0C96YuDep/WA JiCDQsoyZ5g1KlaNevtcBIG3fkbLQ9Mga+luNn1dy0yAa+WhoPklf0GMMiFbk2wWnfwd3rAp9oFiCT jakXQghDcZn5vKuitKfaYY1oQA2Z9YZv8+NDbwuJebHmN7BSEhWMTb0ri97obTDhf7sDjF014A7D0b 2XbLu8o8HkVRYP7KKap+qPPdMqgHo27InusYSFe4XD1ytaKQjCTXpiixBUiPYNqHwsbzfzhgFbEuBO ZSu2cOhhXed8Miu8h0cSNnNZ2muQCvO3n0LzbpoYjty4mPtV8Av7RGdcz25g==
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

In the verifier, PTR_TO_BTF_ID is a bit special, as it can be NULL at
runtime. Helpers and kfuncs are expected to handle this case by NULL
checking even if not taking the OR_NULL variant of PTR_TO_BTF_ID, as it
can be obtained using pointer walking (btf_struct_walk) and be NULL.

The first job is to fix this assumption for all helpers, which
subsequent commits will do.

But a more serious issue occurs when the BTF ID that a helper or kfunc
is expecting may be an embedded object in another object whose
PTR_TO_BTF_ID program has access to. In that case, that parent pointer
may be NULL, and the pointer to member embedded in it would be formed by
adding member offset to the pointer.

Ultimately, verifier does a check using btf_struct_ids_match which takes
into account the non-zero reg->off and verifier the pointer to member
formed by pointer increment is same as the one helper is expecting.
However, it may have been formed using a parent pointer that is NULL.

This case would subvert the NULL check that (some) helpers correctly do,
hence some adjustment is needed, because the resulting pointer is NULL +
offset.

First, since all architectures fault in the first page size bytes for
NULL pointer dereference reliably (and consider any other faulting
address to be bad page fault), limit the offset that can be added and
passed to the helper function to PAGE_SIZE bytes, considering higher
address may be actually be valid.

This is a backwards incompatible change, as it restricts to forming
member pointers for structs whose size < PAGE_SIZE, or more precisely
member offset lies in first page, when passing to BPF helpers. The
kfuncs are already unstable so no concerns there. It could be possible
to bump it to higher limit as long as it doesn't overlap with valid
address range.

A test case in later commit is included which crashes the kernel by
forming a struct path * from a NULL struct file *, and then passes it to
bpf_d_path which uses struct path * without a NULL check, which causes
kernel crash without this fix.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   | 19 +++++++++++++++++++
 kernel/bpf/btf.c      |  7 +++++++
 kernel/bpf/verifier.c | 10 ++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d0ad379d1e62..17d4bbf69cb6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -494,6 +494,23 @@ enum bpf_reg_type {
 	 * assumptions about null or non-null when doing branch analysis.
 	 * Further, when passed into helpers the helpers can not, without
 	 * additional context, assume the value is non-null.
+	 *
+	 * All BPF helpers must use IS_PTR_TO_BTF_ID_ERR_OR_NULL when accepting
+	 * a PTR_TO_BTF_ID or PTR_TO_BTF_ID_OR_NULL from a BPF program.
+	 * Likewise, unstable kfuncs must do the same. This is because while
+	 * PTR_TO_BTF_ID may be NULL at runtime, a pointer to the embedded
+	 * object can be formed by adding the offset to the member, and then
+	 * passing verifier checks because verifier thinks that:
+	 *
+	 * (struct file *)ptr + offsetof(struct file, f_path) == (struct path *)
+	 *
+	 * This logic in BTF ID check is needed to pass pointer to objects
+	 * embedded in other objects user has pointer to, but in the NULL
+	 * pointer case for PTR_TO_BTF_ID reg state, it will allow passing
+	 * NULL + offset, which won't be rejected because it is not NULL.
+	 *
+	 * Hence, the IS_PTR_TO_BTF_ID_ERR_OR_NULL macro is needed to provide
+	 * safety for both NULL and this 'non-NULL but invalid pointer case'.
 	 */
 	PTR_TO_BTF_ID,
 	/* PTR_TO_BTF_ID_OR_NULL points to a kernel struct that has not
@@ -520,6 +537,8 @@ enum bpf_reg_type {
 };
 static_assert(__BPF_REG_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
 
+#define IS_PTR_TO_BTF_ID_ERR_OR_NULL(p) ((unsigned long)(p) < PAGE_SIZE)
+
 /* The information passed from prog-specific *_is_valid_access
  * back to the verifier.
  */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9c8c429aa4dc..9db92b60ea9e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5714,6 +5714,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 							    &reg_ref_id);
 			reg_ref_tname = btf_name_by_offset(reg_btf,
 							   reg_ref_t->name_off);
+
+			if (reg->type == PTR_TO_BTF_ID && (reg->off < 0 || reg->off >= PAGE_SIZE)) {
+				bpf_log(log,
+					"R%d type=ptr_%s off=%d must be in range [0, %lu) when passing into kfunc\n",
+					regno, reg_ref_tname, reg->off, PAGE_SIZE);
+			}
+
 			/* In case of PTR_TO_SOCKET, PTR_TO_SOCK_COMMON,
 			 * PTR_TO_TCP_SOCK, we do type check using BTF IDs of
 			 * in-kernel types they point to, but
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 732dcba85ce5..90972bff1c54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5257,6 +5257,16 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			arg_btf_id = compatible->btf_id;
 		}
 
+		/* reg->off may be < 0 here, as check_func_arg_reg_off is
+		 * called later.
+		 */
+		if (reg->off < 0 || reg->off >= PAGE_SIZE) {
+			verbose(env,
+				"R%d type=%s%s off=%d must be in range [0, %lu) when passing into helper\n",
+				regno, reg_type_str(env, reg->type), kernel_type_name(reg->btf, reg->btf_id),
+				reg->off, PAGE_SIZE);
+		}
+
 		if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
 					  btf_vmlinux, *arg_btf_id)) {
 			verbose(env, "R%d is of type %s but %s is expected\n",
-- 
2.35.1


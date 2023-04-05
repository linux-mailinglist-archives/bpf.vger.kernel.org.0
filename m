Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E146C6D7197
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 02:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjDEAnE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbjDEAnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:43:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABADC49F2
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:42:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so3118927wmb.3
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykGyOB5b209I2tk+Fxn9YOszRs2NFTKrGeaS8yYbBUI=;
        b=pTbe7A0gyLDyurGZIO8mBn1MN079JVFNMznzQ3okxQ9gYZBFvKUGVYbIXzfnsA2PNS
         JV3yGJTCP/9rWqxm3ZeUt7Fmt2++Achw8VbKnwK5q45MrhKAbyP82AciRH9P6mX9g4Lw
         uHphazfcChfRvrb2GiEln4UasbuBhwiY+h73jvhpBf2fujJ/KUgNRdvBspBwBRAFqxnA
         0d8laQ4IUeOZ37qMJIaAg1ONn7jt8cMi2Lt6HTZWIqy5nGWcnVwKTzl5q+tjZ7BSssUp
         8lD0esWrD1HztuREWnquCYWbzEAPrCAQ8U++5PMZFy5HO5ikwq1SkYeyQG4hxjzeGQX4
         I1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykGyOB5b209I2tk+Fxn9YOszRs2NFTKrGeaS8yYbBUI=;
        b=nQv94aKzY0Yl92ajAVAueOvCW2493CA/uGCFje+Zkb0RO5q69lIlcZHjnhTEnRqXy2
         y3b9HC0tt4Vr8rxDttf54D5a2OUaZjmeWlVs7FhfHg/yzK16RgNrhHk+Kuy9lBCmYdeP
         X0vnIB5lgjQtFh4koUtLtkFYCplX2fJUTjBDjQhfgSgu2mevmELU57WWnOmf6Ukyp+is
         El3bIstJHMymW9I0RO/rK/Fbi41sj9DMyL8VgLFuNWKSYvsiiF/RzzgMYPKFSd/Zjxvr
         BogAwCubr8Rek1FRqo+3IPsE63/2M5gtcZrGckeft40DSpjz3JUUmnntQGwM3mjQ6/Fo
         PeIA==
X-Gm-Message-State: AAQBX9dzce+PPhjV4zmdvkhvAX4SBcK4ZZWSH44zu0fK+Zvs67Sg3c9b
        TqvWn62v0RnXE+7x9fUwWMAd9URYiokVoQ==
X-Google-Smtp-Source: AKy350b7Mg21/D0iLIwgf3Pt4HLpU6hnUUymPvL/LFbTKPwPGCZ70QR+PKKunSIm24yTE9UPhoXTKA==
X-Received: by 2002:a1c:7501:0:b0:3dc:433a:e952 with SMTP id o1-20020a1c7501000000b003dc433ae952mr3145862wmc.33.1680655373702;
        Tue, 04 Apr 2023 17:42:53 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c210d00b003f0373d077csm401696wml.47.2023.04.04.17.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:42:53 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: [PATCH RFC bpf-next v1 8/9] bpf: Introduce BPF assertion macros
Date:   Wed,  5 Apr 2023 02:42:38 +0200
Message-Id: <20230405004239.1375399-9-memxor@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405004239.1375399-1-memxor@gmail.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; i=memxor@gmail.com; h=from:subject; bh=e7dZxPP9D8GUSLZ8fVHzJlD1B4G6/CZV8jJJ6/clzvo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBkLMPw6Cmx3fGPW5I4qIqYT7K7Q7PQ6eTUm02yc svbPGgZ25mJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZCzD8AAKCRBM4MiGSL8R yp2KEACSI1uFHdAz6mHYJgbDOZkgEJqJMdTNGPRxzCTZIQRRJi7jYJ++vbv7zh15Rf3LgluaM6n IZ72fhngErumDsF77ogSCcoaxQDYgyrz59NAsUS1YKHeJyib1qkpIL0psvA9Sl5GSqKAfZVH2v5 m7X85TJldPjll9IApN2sDX+Pb707oe1TMUEfl20ICa1BoJaBaimxtXeEILHjfKsmybyebiJr3/D 8moipw1CQQLw5oYpLxfGIiZ01oIkwfBDG5pGqkRs0sgDkYfJc32lcGannDeVE7OGtCHgcYrb9XX eWTAmkfLbFBHtmYLru58+U+/bv5BzdeaPE47YRLri476t08nKYV4/I4m1U3u952Tji3Rc7vD3We j8Lx/zH4xRmsp0mDPLBubs9ZlmwmYTp3a7KjZpGbBRbQzu9zDR8eiycKxIUudjTu9K8nsqpm+om sJrdBnkISbySGliv6BCqkIWlFGpfviGdYmRuKsP+2EmGVInhnpfGHNy+MaONLKkT8chVni0HGfm OVtFpioW1m5dkMFHmGcTTGE0i5OivWkvksIqHwWAAqyZlGgfdw3r/48NwSiDr4savphW5TSkTEk P1Xplo2dWp1Nmvcw3y20YyOI4mhHazeiMxYqzDub9ppYmFgEObZeP+GKRH7qx1gqKxdSkq5PXHt VPk4SYQ3AHKU3eA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement macros that allow for asserting conditions for with a given
register and constant value to prove a condition to the verifier, and
safely abort the program in case the condition is not true. The verifier
can still perform dead code elimination of the bpf_throw call if it can
actually prove the condition based on the seen data flow during path
exploration, and the function may not be marked as throwing.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index a9c75270e49b..aae358a8db4b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -109,4 +109,21 @@ extern void bpf_throw(void) __attribute__((noreturn)) __ksym;
  */
 extern void bpf_set_exception_callback(int (*)(void)) __ksym;
 
+#define __bpf_assert_op(LHS, op, RHS)								   \
+	_Static_assert(sizeof(&(LHS)), "1st argument must be an lvalue expression");		   \
+	_Static_assert(__builtin_constant_p((RHS)), "2nd argument must be a constant expression"); \
+	asm volatile ("if %[lhs] " op " %[rhs] goto +1; call bpf_throw"				   \
+		      : : [lhs] "r"(LHS) , [rhs] "i"(RHS) :)
+
+#define bpf_assert_eq(LHS, RHS) __bpf_assert_op(LHS, "==", RHS)
+#define bpf_assert_ne(LHS, RHS) __bpf_assert_op(LHS, "!=", RHS)
+#define bpf_assert_lt(LHS, RHS) __bpf_assert_op(LHS, "<", RHS)
+#define bpf_assert_gt(LHS, RHS) __bpf_assert_op(LHS, ">", RHS)
+#define bpf_assert_le(LHS, RHS) __bpf_assert_op(LHS, "<=", RHS)
+#define bpf_assert_ge(LHS, RHS) __bpf_assert_op(LHS, ">=", RHS)
+#define bpf_assert_slt(LHS, RHS) __bpf_assert_op(LHS, "s<", RHS)
+#define bpf_assert_sgt(LHS, RHS) __bpf_assert_op(LHS, "s>", RHS)
+#define bpf_assert_sle(LHS, RHS) __bpf_assert_op(LHS, "s<=", RHS)
+#define bpf_assert_sge(LHS, RHS) __bpf_assert_op(LHS, "s>=", RHS)
+
 #endif
-- 
2.40.0


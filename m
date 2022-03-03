Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A298B4CB5F8
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiCCEvi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiCCEvh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:37 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ADB11C7CE
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 20:50:53 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id k7so3124085ilo.8
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 20:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3JY0CiN7R1hjdSkgGD+nD1R0XsVkna0O56cVY6irWDA=;
        b=KLfzBDg82mDVzdyUr2vih4N4I2S+mibWK61x7MTe3E4EKogbxPxe6AZMPc+u0q/fX7
         7k4gZQrFo4R1rqD7na+IS9rNRRMlGBhOv8Z/HIDFAEESXIb/sFA/DyO+RRsHnRIvfLpk
         51S/pR/lITmgRkJqI729MdsrYIlLpYmdsm0u3D7+b8a2grGV3wueG97iE8C5hdLQtS/f
         Ex7Ez8IJMUJuetlqAHrTfPzJB44XzExQ/RVqnKE9wvTCCnOKAP23qfTBfUCP/35PtiN1
         WhuTvXrSFQyCz8WLd4z453m18UpUNMdcsohgDgYlpmUsjOUTULQdY1LD2GrXIPT91dYd
         qHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3JY0CiN7R1hjdSkgGD+nD1R0XsVkna0O56cVY6irWDA=;
        b=6Adi6/lwfSBco/albj/SO8MVjANxw6x4ha0RndSTnivI3E63yrP0CHzKiun4Ht6pfS
         yM/VuNRh7+tD0uguKDiugwSskNYaCYtPH2PZ2DV4sXzpGrcriikB+3h7+HG+Zg0n5OXs
         qJaap4OYoHRnsaDQxxJDz3wRaD8qcqO1HfvGiB8ILpOFzQ7ij/wBjOUbirTvMmsnWs4O
         UAkZvLAeL5COA+p5BOB5hS52o9TGNFhOTJGpa4WIXgRZcLTiWjBTWdQsWH592isXUjPU
         VZ6ufY35V2iX/5pLIsn0JIOkhUWwt5/sjAeT2O06EmIlTCGrdwWOP4EEHPu6ZKNPJwB4
         FRfg==
X-Gm-Message-State: AOAM532xhy63Nkyz1Krd9jEEfEpDO0/KQe4Vj4XrTrgypXN0LRdi8dgC
        vpa736jsaqQmHB1gnos3sjEfbqwnh4E=
X-Google-Smtp-Source: ABdhPJx31U+XRCTOiJaXKpxAIDjjLsarfoqPy7hDOauI7P3eIckR/wniOEjNe73rJTRSj1bR1KXBQw==
X-Received: by 2002:a05:6e02:1aab:b0:2c2:60ba:b21f with SMTP id l11-20020a056e021aab00b002c260bab21fmr30996513ilv.133.1646283052693;
        Wed, 02 Mar 2022 20:50:52 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id n7-20020a056602340700b006409737fa99sm696525ioz.27.2022.03.02.20.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:50:52 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH bpf-next v2 5/8] compiler-clang.h: Add __diag infrastructure for clang
Date:   Thu,  3 Mar 2022 10:20:26 +0530
Message-Id: <20220303045029.2645297-6-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303045029.2645297-1-memxor@gmail.com>
References: <20220303045029.2645297-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=memxor@gmail.com; h=from:subject; bh=peGyBKzfC1dDYXb1+KuztQMkZMDgg3j2AwxoL1PPC70=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj/tn1LqkPnefI77maK9lVgtxXBCE+KLM981Ap+ 0mBbmu6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/wAKCRBM4MiGSL8RylaAD/ 4tp0nrd35nK4EAI5fZF2usm7UOYLN7C8rTY4196i31M4ZqhleJV29sraSfnO9zo+EXb6zfFC6umWya jx2x56GF8+FaWR5sUtx2tRkAwqQFwPZib05/Bt7954gut/YD95aXNbhvzlfPwQIheVzlHxK6Tuc+2K WlcveQD0wKwySxp7e8wL8rSHCcwu3sj3PIwaobgZMm87OPQ59P/pUAO2bTQpA2mWGBBecAZhhryeiV t3zS2z4eWSEwxptbxTvLDhrEl1DY11BMnFzID8k6pHkPXb7yLYml+tCfcko7lYED5trn6eM+4KBmMt SGFIYvIFrddqWskndpaySVOo758X7LEJ7ypwdS/8Vn/J11I1Vp0yZgcj2QBZ7tHjLqwOAWfyBKz14Z Ikw3yXS0NhEqAQq4SVZ9tE4qCZnmrqvWhtnThRf2Pvze8AXDlFRctieXE63pUWYbQSeuLjPwGygvQM I5rl1PXN/9bEqERnmDdxvkHMRhSdBBg1sAx5oFsTNDF1xzu+C+FzqU+FpdhXJnX4OLD9/2Y/hK1SX/ W3tgkC73B3W02OGEvSY3U1+2yW875cC4LlvH5HOz9mWzfkBO9Vb1Tp3kccO5EFVne+L6gT1c0r4K5p hMNpx/+L4QPQr7JnL8rkvZ4skWzJ2zM49kLBKeVsWP2Q+yysGzVEYbznVvJQ==
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

From: Nathan Chancellor <nathan@kernel.org>

Add __diag macros similar to those in compiler-gcc.h, so that warnings
that need to be adjusted for specific cases but not globally can be
ignored for LLVM compilation mode as well.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/compiler-clang.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 3c4de9b6c6e3..f1aa41d520bd 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -68,3 +68,25 @@
 
 #define __nocfi		__attribute__((__no_sanitize__("cfi")))
 #define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
+
+/*
+ * Turn individual warnings and errors on and off locally, depending
+ * on version.
+ */
+#define __diag_clang(version, severity, s) \
+	__diag_clang_ ## version(__diag_clang_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_clang_ignore	ignored
+#define __diag_clang_warn	warning
+#define __diag_clang_error	error
+
+#define __diag_str1(s)		#s
+#define __diag_str(s)		__diag_str1(s)
+#define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
+
+#if CONFIG_CLANG_VERSION >= 110000
+#define __diag_clang_11(s)	__diag(s)
+#else
+#define __diag_clang_11(s)
+#endif
-- 
2.35.1


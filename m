Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC494CB5F9
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiCCEvl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCCEvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:41 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30B14A6DA;
        Wed,  2 Mar 2022 20:50:56 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id h28so3141719ila.3;
        Wed, 02 Mar 2022 20:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDVQJ3Fq8NBV53TAXzlYHtLwOtwjE+voGwaucY4wx34=;
        b=HOd3Bo2TJtj5RUF+AU2SbNMmTDqhHTL4q71s4CZQH+/qY7mTR7pEhhfpM9z5HxlfB1
         FMmQYP0i0TbI5Iesr/t3IULcSAQaVqSBJymDqOVcIPbOScVch8QPAmSvfEj5cZAVAxOn
         tHk0v3euML/2dPmoSUXxe+MQZpeYAAXzurpujrqJsbfcQikMIP4TnHrjqubjntAd4+uF
         IulMOwi0PYXF1ID8dlxtPTzZfl7CZsVpq1GpTQeoMs3d6NurigkGvGGdQ+wnYfvY/97H
         v0eY8Sz7Wx0Pfqn5btFW21BWQp1EXlgdxtqH2YEbUiuHnVMOoazKD+fhprEzweup43pD
         7ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDVQJ3Fq8NBV53TAXzlYHtLwOtwjE+voGwaucY4wx34=;
        b=mQjJ7gikDQdR6A4mUd0fF4XqsECs6gWBR44ULzwPGgr5C03dUS5m5t0jxSJsQT9y8c
         +P+zO723SBRxUnED/3L3xKH/7g0hjld98XAtxKZrNW9xy1gOLr4e+y+/MnKRCHhLck5R
         6QQ1aWqW4Dm81L/DgrjiDHo9iPUNdDWZpBlQ//DC2MVfQ0nomqJgq2qlP4N5NI+lgZjQ
         mNPXn+21megPmHTFwLlw/iYNYRm4oYallEv+JCPhOtYYv0U/6WWNpohgA9/NqA/0ij3b
         j2AYQFAn4u5iN6RZTdnIb7hMhqnB8mvNpqBYMisA8+1o23+hjulc3Vf47EjaDA/aUKCU
         LZXg==
X-Gm-Message-State: AOAM531q46OFMks6fLT/Dt5RPdGXvUaiYLp6XmEyl9iB8N5jWbO05jkg
        i8KzOR8W0Si18Zf5ZnYOxyOeVMW44pY=
X-Google-Smtp-Source: ABdhPJyu0K+8wWbtmHCooE/7xGVZrJwHUYIBOSWwylrdyuwWIVLeZHps3qXtK0k1ssPT2zqL4sLF8A==
X-Received: by 2002:a92:c8ca:0:b0:2c4:ff8b:98cb with SMTP id c10-20020a92c8ca000000b002c4ff8b98cbmr6853050ilq.183.1646283056143;
        Wed, 02 Mar 2022 20:50:56 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id b1-20020a926701000000b002c25d28d378sm672203ilc.71.2022.03.02.20.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:50:55 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 6/8] compiler_types.h: Add unified __diag_ignore_all for GCC/LLVM
Date:   Thu,  3 Mar 2022 10:20:27 +0530
Message-Id: <20220303045029.2645297-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303045029.2645297-1-memxor@gmail.com>
References: <20220303045029.2645297-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; h=from:subject; bh=GM32fUklsZxVmnh4SsQp2kGBKENfBpd3/E++0grOsvk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj/uurNr9aPwnll4PFTLHqfDRT07+h7GF9UMqxl cR9jt+uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/wAKCRBM4MiGSL8Ryn8/D/ 99KWLHtaGnFgQsA7AVZSnFtencmZK3cbVgcplr1rtdpVTlGzdtRKm3/Or4xvN5xvZ4kCo9kDxGd3x1 AHgpTraVqQvmewNp9UkCFkFAHuRKctzLWsXL78M8lAFevU+CAzv14T7NAQqsr4DMxK79imrF9cywRe op81+NJq+lLsN1FJmoZXfbzfYR5JSzYWovxljGqr7+mFcAz+kHISBWHk2nANiqX1N7YvGg80cpu/Ei JtPIyuIfgi+r1EbotrdXdsem7PMtzoqgPHFI45F2F0tmdE3ntk7QXcgQetT3AikKjQUxJoJVPOIDKK XqX+gfxLUJlZQ8ANSKIdywaG9jcP0B4TIxGX4XTvzTOOorKYgeIQFJ5hOTYl9VCptbobT7govsUZ54 6DOfk5WGwc4jzp+RIvCykaY+0z5c72o0Z5ENTq9Esl3I31Glco4FVuSIUMQPZCtV47nxP/pJuQ2sRj yeOlJSUx4KP2U3wQC06WntLHaXSCmf0yn0MYTb+VTVNiRMkduYcdw8uL8s0flkEyuVMi/3g9Se91x/ cWqbvCvefczEebnPP1fRjGFoAMPgEVkDq2dnI0v9vgkDNaFgZuxP3XDm2vDxc189cyd7j3FlXRyvXd 0DkSybogRC/Hxvd0iPxtDRL8cpzDFnyrNB41PElgPDUJybwS8pW2I5avDmag==
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

Add a __diag_ignore_all macro, to ignore warnings for both GCC and LLVM,
without having to specify the compiler type and version. By default, GCC
8 and clang 11 are used. This will be used by bpf subsystem to ignore
-Wmissing-prototypes warning for functions that are meant to be global
functions so that they are in vmlinux BTF, but don't have a prototype.

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/compiler-clang.h | 3 +++
 include/linux/compiler-gcc.h   | 3 +++
 include/linux/compiler_types.h | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index f1aa41d520bd..babb1347148c 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -90,3 +90,6 @@
 #else
 #define __diag_clang_11(s)
 #endif
+
+#define __diag_ignore_all(option, comment) \
+	__diag_clang(11, ignore, option)
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index ccbbd31b3aae..d364c98a4a80 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -151,6 +151,9 @@
 #define __diag_GCC_8(s)
 #endif
 
+#define __diag_ignore_all(option, comment) \
+	__diag_GCC(8, ignore, option)
+
 /*
  * Prior to 9.1, -Wno-alloc-size-larger-than (and therefore the "alloc_size"
  * attribute) do not work, and must be disabled.
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3f31ff400432..8e5d2f50f951 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -371,4 +371,8 @@ struct ftrace_likely_data {
 #define __diag_error(compiler, version, option, comment) \
 	__diag_ ## compiler(version, error, option)
 
+#ifndef __diag_ignore_all
+#define __diag_ignore_all(option, comment)
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.35.1


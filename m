Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101384CE064
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiCDWrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCDWrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:47:53 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F366821E01
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:47:04 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso8738288pjq.1
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 14:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqFnAABLSo4gfXyFqfRrTRulE33S0+Zc+dKAaTlLF8U=;
        b=lLJjzv1+FYk1VdnbZKAIMIKB0cy6msdnIWuscqTuvOHV4PpX6zcqXxkTiKtRHMD4oj
         s3cvLWeh4G3JElUPat3+xGuwZP4p7Q/cC9b5JWTB+D2Cr756tKVkN+ndNrCHcPP0zOtV
         Fn/VBQhBVFBW8PQ1v26Ixy/1YYRM5z9PrpywHmPCfQAlC93OuAJUyocnPHq+ItFfkoSq
         F8+0BUBoiP3r80HX0WSD0GYIhc5tmXuHVPx6f2vatj5PZOQJH7YDp2xwtsVpn0l8Qsrh
         HNz6VxyQJPQ3gtletkVWJNwSb1sTwSAoxBrRD53hmNbxvvPkdnlanDME0I+IydMVhiJB
         mzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqFnAABLSo4gfXyFqfRrTRulE33S0+Zc+dKAaTlLF8U=;
        b=OmwKSlhaQv633gRrXs5sC+LdTi9X6RwL/ytrPPZokBYtF5x+K0wQoNgQYVmN+c/g1y
         cH5jVZEF4sJuf3rbJrlLgBq+rKw5BKfaT2BrhUyCY0qOeZcC6RZ8MLtAEGdQGIoR3ew0
         V2tY+PEOmd3IXADGD9MzVcsnBJVVUNUyMChcJL39EFwklW6WsFE766M53sEwJXaYLKJ9
         Wk4NBIdoVVPnXYKX6QsFCNWe5j2uilVZQZISfu279/eVwNTQJLTwWxh8cPKwTCLs3OpA
         8/kCVlY4f34rzrJMSZQOF5RLxCKJAYh1cWECUq1E6Ffnx2RjD2/DjfrE/rKydm1DCXqR
         jmUw==
X-Gm-Message-State: AOAM532Ysdf1R1a110EliLFAH2jz/0eB8aLD6fpA92nwNYEfW7lfZhj1
        o/AkXZlhNnhC/aWNSeD1AoJ4hw0ASeE=
X-Google-Smtp-Source: ABdhPJz73/WMy+zgwFJkLyyXwHF7E3bL+m2EKEqOQym28gfI3VcXrgLKnIWKGdN2GInyd92w2mjEGA==
X-Received: by 2002:a17:90a:65c4:b0:1bd:2bcb:1f0c with SMTP id i4-20020a17090a65c400b001bd2bcb1f0cmr13045278pjs.114.1646434024417;
        Fri, 04 Mar 2022 14:47:04 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id e11-20020a63e00b000000b0037341d979b8sm5244760pgh.94.2022.03.04.14.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:47:04 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: [PATCH bpf-next v4 5/8] compiler-clang.h: Add __diag infrastructure for clang
Date:   Sat,  5 Mar 2022 04:16:42 +0530
Message-Id: <20220304224645.3677453-6-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=memxor@gmail.com; h=from:subject; bh=7uwK8ABZKnWenzz92bkM96adqDWIRLPqA7+NX3fqr7c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpasJj2xD950UpEJLjfy1eC9EWgGn5mvhwnzWnX4 Ex0bGAOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8RyjR5D/ 0SQSqGwX+xh6q4dgCpgzx8pkZO1uNRsbHpWc8D7crol/YKGU2E/Ya5swrFxD8vhTyChXWPomeoL0/u oGNhlB8RC7qK6rFaAyN4H7Le1B0Zhzo9+34QkK4E7cwlzWcS2qEs/iBNSWUIkErCak28pKgolBaug/ LDaumOcPt1njI3Iuv1v5g8gzRtFKVyZNrLvBQ17ONBu0L2DYbKStbgs99cIoco31i0ZbjXvffqEhj+ pBK0Y/RrnaNtWgmd6/mwtiqIP15joU7vQtc/dcdMt2t2H93ISLvQFSNmEyFrt55rZsvxEHE4ElMK+x lY7zlsXWNPAzNtl33RTS7WwYEjVJ87qYaOHYKKwzePF+nAwR+m2zv9dJUnC2Il2Uxw+D4QXqu9sX0X PyZl9ctpBOvMmFexp/aHlrJS5yDemqXKcXgdv4VJcoZBH1NlzLyVYsfiQYbi84FeMWM78mESeM4AwO L7mHR1YhY+AbmFZG9K0Nh+FGZFrlhS5fHdTPjI4qbem+yX4c0+8lS75M4PUogUwBqea5JlkgTu8un2 c0StSrwlhui4Z+dtI7PBPMGDzK9v9sxwQkAG0JB2BMKJRG+njkbm3Qtkzsc1UnWrLJv/7Npfi64tOm fNNhIKmuzHNqrVFq7tvhlxEoQq0pPVpROL+wJFY4RyOSc9MqNvn20Jh/t0Gw==
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
ignored when building with clang.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
[ Kartikeya: wrote commit message ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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


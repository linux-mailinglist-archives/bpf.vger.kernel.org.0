Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8D4CE065
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiCDWr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiCDWr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:47:56 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A93AC486C;
        Fri,  4 Mar 2022 14:47:08 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id m22so8521004pja.0;
        Fri, 04 Mar 2022 14:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDVQJ3Fq8NBV53TAXzlYHtLwOtwjE+voGwaucY4wx34=;
        b=cQX4egJFr/UsT0MoFjqn+ZGXBkeVx59n5M7Ak3uOP5xVpGX819Uo0iBwThR9nI+vyb
         +OTmF/ldolII50OaGanOHWb1t2B9h7HPlXBwWM1Noi4Qoa+RCsbRuAgJOvOjNhsREpm2
         jV3GS375sYtDnjFV2RjaNcZj4ktFQZZOvebDV7k3CmJ0ZWkBrGWdjq3TE0aFNTSQSQbs
         5oFyH8xsxfDumWwgby0z6neAO+PdnZdfqGdcy6acPEEuI6ahjMQ5B5itnWBo71SkmKoF
         e3ZIihmUfwQzOBzj48QbYPJz6TQx5FRGu9ul/CzNH5RCvRAJTgH0cfYQaM3ppCX304bW
         HRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDVQJ3Fq8NBV53TAXzlYHtLwOtwjE+voGwaucY4wx34=;
        b=QjkEIgX9OyQo9U4JuZ3+cbr4ammEZ1A3bsj2xiNqQH1OtdLNECEQfC+mmyseM87xF1
         joImM0hqF2NYPZxRj3rpwbpjIsroCg632pbRSNrMJIUls2Qn48orftNtJYXhy6g7YwOj
         /c/xRiE58mkSvKze7/Xj1Mxd61t6ihRG9qG6V07fvKfpKQZdjjlADsYEIsWk1fIOETnz
         vzxOxC+S5RPcuZLmbZX91SkUPAuifyc7xPMNYvAqRDf0ve1OY39/KtYxsTe5YZ0QC1vs
         7zk2vLDwvn2oTTiq/+6yy/Fs/yuGP86KzynVJBqtp8n8ITHTaXa0B9yWbJxqpYjaVeNY
         q1gg==
X-Gm-Message-State: AOAM532fKe8ypdK/eMEHmyAcpU2YQ47ZTTFJ2vDErhI4sfqQw6lvqzYH
        zBPNDsEVxAVoJVdyGITOHvfrvODtxas=
X-Google-Smtp-Source: ABdhPJxJDfGIuGe0xXShNIHDKj9nAksfu8yRx93btMTez2Lr5r24NNvWeaj4gtev66dGAU407XmGKQ==
X-Received: by 2002:a17:90b:4d8a:b0:1be:f63c:3dcc with SMTP id oj10-20020a17090b4d8a00b001bef63c3dccmr12923373pjb.133.1646434027642;
        Fri, 04 Mar 2022 14:47:07 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id o11-20020a056a0015cb00b004ce19332265sm7139105pfu.34.2022.03.04.14.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:47:07 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 6/8] compiler_types.h: Add unified __diag_ignore_all for GCC/LLVM
Date:   Sat,  5 Mar 2022 04:16:43 +0530
Message-Id: <20220304224645.3677453-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; h=from:subject; bh=GM32fUklsZxVmnh4SsQp2kGBKENfBpd3/E++0grOsvk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpasuurNr9aPwnll4PFTLHqfDRT07+h7GF9UMqxl cR9jt+uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8RymoID/ 95pTX6w/fUatq+X/t2Rg+1VTrzHVoB64CxITIqf1BoOpHmrUwxjJqn/U15VFxpVy6ZuY6A3zK9OCY/ OVynxqxvLOLQ2z9z0ZUHXTa+dybGYVMpWsSMvfcQLbZoeaPErVOVpuiPAtbiKRPKQ4qUIHHvPipKQf Df87l7AHDs6iY38OKb+blmNsqkfh5oULZfPsqRSyZmX+4WMbr4PiiElCHWaegVFR2m3gIZbWGorsuz LX4JXT3spJCVRguBMDwdWIRelznmR9kBdBCuSCIBxaM8LmPJsVR9mH1t8a3a+KIORR8eerGaS50KCt O13cDPV9Sg3KQ4woczfAcLVx2dCqPVFH3yPW2oOP3/bGJbEzKPJ6fb+c04YJpoGc/v1CXHaFm35Wet hVE4mQmEA8ITq5GiWgsMAhWyVfjmfqYomODa8ElJbiYVjiY3CvqoBIvaX/Jc7nvfDK+2wzoEdrQjdp WAUUycyTIpzl8nqBYUCc7VA+OVF/Vg8bNmXgxUs1+Az3sYqJCjC+uMudV77G9KLthzmpzUKP0mFPyc iriTeiOaPdYSyx2kCkj7QjYp73zv9Fj91cgBVrdK/jgjF94OXu3L+j8WjYy1ceiNZzv3nqjv4KA1U+ tCkQ7+sRf4n237nryAwKJEhxvS4meUOgjFvM9+QZCMdNFVlB6is3OOotfhSw==
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243384CCA76
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 01:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiCDAGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 19:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiCDAGR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 19:06:17 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E949ECB2E;
        Thu,  3 Mar 2022 16:05:31 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p17so6233379plo.9;
        Thu, 03 Mar 2022 16:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDVQJ3Fq8NBV53TAXzlYHtLwOtwjE+voGwaucY4wx34=;
        b=gPjui2DQAJT11QB7bvVksvTzwzRqpRLrNPFoj5FXj2Ut0PuKxsPx8oMNHtIQPSiyTt
         UJsVH2XelkWFeimWp1lQlsu5f3RvmBsaDAb3i48qI4bql6kiWZiUJusX0V970DvsGDki
         boZ7cHglI/P3s0pft6CfS6NvfO/eumlaHoD3DYSDfbfBiyQK2yLRXm5f504rO7Pp13Ei
         OLrNkARM3uHg764DbuLHtzGwhKq2xHrSdxIVLIeVc2Vck8kP3tTSX8//1LP/+IPizB6z
         O5kw9Dn4aPxFppudagbwz15ZbQgCCN43ILDi79dicsFvKAQ522Obc8ir2T10kku1o4g6
         UFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDVQJ3Fq8NBV53TAXzlYHtLwOtwjE+voGwaucY4wx34=;
        b=eXOAe3OVZDb3xpE+lu1zEpIqfrsjIidhm/sPI58CBECMMrPGoj4AzSyr+qiw97IfIb
         pzGFlSqzd/eGVK2fLiL4tgjQpIg4JcsDFNA3aZLjoMJ/VtBOKdnzVL1+rSAn3cUBRraE
         44gTUsdwOtjaVFwSmGXkJZJM1JtHVBcLlxn69epeRJo6jSW5Bylv0Rjmdcf3Oefoo/tO
         lZQbnkxoLsUJEahSo1++Cc2AAh6w1TIeYrRYGMiMzJJ5AF9YJ3bjEMU9i15m3wgtK2ph
         6s7BxR3wggTvJ3FRQQ8NjvTE/OzqP48FlYYK7dUVTYpcW93oIRss3Akhr6WdHR2N/Nmc
         G62Q==
X-Gm-Message-State: AOAM533nR/SGDiIJ6ORWnszwOhCm23SXw7d43xuRZqrGUXGr6WJjEawz
        t0xICo4+oENX/sMZg1UprJXD0O4tJJg=
X-Google-Smtp-Source: ABdhPJz3y6lV6BvGL2/RX1XgNR2fiySzaPtkag0ily56mlXWCNyI+gA7+An4+RMcQ4J2PxbcLbjutw==
X-Received: by 2002:a17:903:291:b0:150:4197:7cf2 with SMTP id j17-20020a170903029100b0015041977cf2mr33508491plr.173.1646352330829;
        Thu, 03 Mar 2022 16:05:30 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id h22-20020a056a001a5600b004f41a2a6cf9sm3485793pfv.134.2022.03.03.16.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:05:30 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 6/8] compiler_types.h: Add unified __diag_ignore_all for GCC/LLVM
Date:   Fri,  4 Mar 2022 05:35:06 +0530
Message-Id: <20220304000508.2904128-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304000508.2904128-1-memxor@gmail.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; h=from:subject; bh=GM32fUklsZxVmnh4SsQp2kGBKENfBpd3/E++0grOsvk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIVd/uurNr9aPwnll4PFTLHqfDRT07+h7GF9UMqxl cR9jt+uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiFXfwAKCRBM4MiGSL8RyqD2D/ 4o/FXw5ZfJ8g9L7BT/KdKZqz7RCXd4mDkVT//ppB84uVMF7ZlLimMv1+dpm29Ye5j/5GyQCqi4nwxO ty2dOkhePchauOqo4CM8XBDWKvtyY+xO7mgHSN0ceb9+MP9BAu9pkrPccQNzfB3CcfWSeoLooO1WfL lhl/qpU92S6EsBVTImcZz91u4nH0HpzuFJp627/6F3pP1vTJa2RwFykX3WMUQzSkG8uViJLPnnd1lw nMit8aKRVbGHzbslfebCLGbyiA8OycqDP6hKz8tPf2qJEsxTrWlFxbbfiGx120pHve8d4Z2Au1h5r1 Bp6wBXxVn4MuQLvoddcEkKpQdaaec2MV3ygx5DyEPofAtFY9Tjs69/A0piFbyL/xhFPD15HjW+RrsF 9hVkrkKFPrys9vMBG2epCRY3d2BQNbhB+7mxpN7DuFivnFMQffIS2IcszbLUtELxJloJurSv1frN0N INRa2PegVoJSRZFX5vp0+cgBdE5Q7LFuaMD7p4GrGuPieOzEKjVP9BttE8zBV3rxqVtGMW+WlhxqgX oT7+t8fUY8J6UkHN3Ovy4lC9euhhmhkw4hi+mt9l2vFoirIzXiO4lc4+5ZAWO78o/bCwFvbM4YDs9F UYhJa3LhyHfiAhcxEG7cJI4jF9c9Tha9sSg3O/bYYyVD+B0bfcMlJXtizO3A==
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


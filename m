Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28934CCA77
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 01:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiCDAGX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 19:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiCDAGU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 19:06:20 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B47ECB3A;
        Thu,  3 Mar 2022 16:05:34 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id e2so6238710pls.10;
        Thu, 03 Mar 2022 16:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHxvOvsF+Ys03+6wrkcWWXn79qRVd5rUbUqEe5lmuak=;
        b=ot7Y9R3GpTl98F0GYEXRKj9CviCbwuglvAK+a6EQu9zHWMkDb+Fq+YOl1SpYLULOuv
         FPWe+wEpeK7r5Xz6fAApG3TX/1V2y7kG60ZvVJ5NAzh/tIY4ly4qxbTYGSRJv/CE7bAn
         L/e8k26X4sMQoyYjEaJgsyksNhnEyJKmuLV8NcIwEkxXvMlsf2t/C3CEtFDSMkoEbGB4
         U/DZwqcAAClEKGyWzzviKWhXcBNZShr5nHniCQKX4zfXt+Nc15ecyV53SMT89S6okSF9
         4lkpu95v/dVnUXSh1A+ZHrpz76TTrOCk6yvzAD3CFuCYFGndbBBlxBbs4Sxgnjs9OaQR
         FDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHxvOvsF+Ys03+6wrkcWWXn79qRVd5rUbUqEe5lmuak=;
        b=RWTjwRrQU2ZxXBorHtftUs59BbOJcl697c/GF6MMGm6zPDsG5RO9UloEeYq3NyN6ZI
         nr4j5zvbajA+JR4+JWwXPbwuqWx7ix45J1/UVdhTadx3Y1jULdDkmExXOUWC5J1/brz2
         gsJYC2rLAmaGjiyjIWJWCKncEhlpfDNDMy+zYOvg3VJVUFhmVTvxBJyc6I0seFOjqsT7
         lS1CWdJKwR8KSoNmP7CP0d1n/YtoS26hVhctLoJuYLQyzLFbYFrRygGgXFAECdQ/r6xX
         78vwDChESdaJXb9CVQUbMTZqBen9IIjgg8gbCi6xNOiVla0QnZydmYZIHJ7w/AeOp8ka
         XkxA==
X-Gm-Message-State: AOAM530eiyP2e4MgQzl8x46dcjoywoAb52uqoB4l8GKw3O6TtPEoCM+Z
        6KPEgh8qZxgoHUv1PoJ/P1GLuCW6AYU=
X-Google-Smtp-Source: ABdhPJzZGrcyIt5m+UYpPs9N3ajwisofHy2+7u3B/UVCSdvw4i24wq303tUfXc7e0QDlRU/OQURW3g==
X-Received: by 2002:a17:90a:9292:b0:1bd:1bf0:30e6 with SMTP id n18-20020a17090a929200b001bd1bf030e6mr7893750pjo.73.1646352333867;
        Thu, 03 Mar 2022 16:05:33 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090aa00c00b001bc6f1baaaesm9179637pjp.39.2022.03.03.16.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:05:33 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        netfilter-devel@vger.kernel.org
Subject: [PATCH bpf-next v3 7/8] bpf: Replace __diag_ignore with unified __diag_ignore_all
Date:   Fri,  4 Mar 2022 05:35:07 +0530
Message-Id: <20220304000508.2904128-8-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304000508.2904128-1-memxor@gmail.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; h=from:subject; bh=/N0nS7sRMuholm5Xm4LDpnIHKIDwW8B47uKsPJl8FD0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIVd/tKHZfX8qLJG2j506OZBp1p0zlMK3RCT4IUEl VIceAWuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiFXfwAKCRBM4MiGSL8RyuY5EA CgCNo1ra1deMLlb8fJNc1smMJQEldSd/kI6IuI0KzNBJabRBALERBjPUh3j/Cjm8vdcPqWu612diQP jmPIZq+EmSiQjQz8MMdsvE1Irb6oBpDgb3w0NbQHNXeCc0liIps95Ni0lXpu/78T69X63/dbVlamde Q6+dglNPXjrWeX9zU/al3HlSvH8APcNsn6Os+aNrO2qP/GJN0whQJUIZQjcdgNYPid6gjhzugFh0Q3 PeoI6/VpGLhRCxfhTa5bzYTzyclcTUatxxse7qRxtqrx1kHlf5bop4ODHLOpoweU491XAoohEc8Moj FzWg/Tizn6TJlZaWGiGSNcM5q7hoKrOJGfLLOMbmQyZaseKjp68ldIlBX4EZBoQagTxbZDfqE2ssi0 kxnDYGpxX+hweJsX9yEyBUU/al286sKBSkif3s6zCwsrzELne+6vyWuNTo97Y2RMVgRnifTAQIgPsp hmPJflscpayLRNGNPv1Lzv0Dm7hJLJS7leU8oMhEVY290CGLwF9+MGGD4Croicib7xZPwFB4SZSLxJ s5g7kBr+ffVnd+iXe9rwsg9h4v3+ze2teO44oSsUVU1oASNPYZAdhATTHsQ5hM6531BY7Q3Qj50TYj fyYQopnM2TGXobmheQP6m3uolYA/+V5e7IkGPnhN1VjX9cWgY1VnosTTjsrA==
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

Currently, -Wmissing-prototypes warning is ignored for GCC, but not
clang. This leads to clang build warning in W=1 mode. Since the flag
used by both compilers is same, we can use the unified __diag_ignore_all
macro that works for all supported versions and compilers which have
__diag macro support (currently GCC >= 8.0, and Clang >= 11.0).

Also add nf_conntrack_bpf.h include to prevent missing prototype warning
for register_nf_conntrack_bpf.

Cc: netfilter-devel@vger.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c               | 4 ++--
 net/netfilter/nf_conntrack_bpf.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index eb129e48f90b..fcc83017cd03 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -201,8 +201,8 @@ static int bpf_test_finish(const union bpf_attr *kattr,
  * future.
  */
 __diag_push();
-__diag_ignore(GCC, 8, "-Wmissing-prototypes",
-	      "Global functions as their definitions will be in vmlinux BTF");
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
 int noinline bpf_fentry_test1(int a)
 {
 	return a + 1;
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 8ad3f52579f3..fe98673dd5ac 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -12,6 +12,7 @@
 #include <linux/btf_ids.h>
 #include <linux/net_namespace.h>
 #include <net/netfilter/nf_conntrack.h>
+#include <net/netfilter/nf_conntrack_bpf.h>
 #include <net/netfilter/nf_conntrack_core.h>
 
 /* bpf_ct_opts - Options for CT lookup helpers
@@ -102,8 +103,8 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
 }
 
 __diag_push();
-__diag_ignore(GCC, 8, "-Wmissing-prototypes",
-	      "Global functions as their definitions will be in nf_conntrack BTF");
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in nf_conntrack BTF");
 
 /* bpf_xdp_ct_lookup - Lookup CT entry for the given tuple, and acquire a
  *		       reference to it
-- 
2.35.1


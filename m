Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1FF4CE068
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiCDWsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiCDWr7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:47:59 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8862DBB0B8;
        Fri,  4 Mar 2022 14:47:11 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so11730419pjb.3;
        Fri, 04 Mar 2022 14:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHxvOvsF+Ys03+6wrkcWWXn79qRVd5rUbUqEe5lmuak=;
        b=Zs2jGUpuKyD47+ozBZmJfjgVUkO3Ka+XeByj7VbPTol7u6BxyBhUEWQagOz5Zy5BtT
         h/D6C7eROHjk+i148weYsSTXqAM3FaZM1cP6yvLSP0Mps3aaOfRAOPXSnFYB+1go0c17
         k3W6SH6fVpfJTqpx/VajEJRfLlj1Yf3q8R60Lnn5C0o1EPvMcTlmaca3wFwyeEBPrt/I
         kPuD2sAioDtN0KSfPTvqWI81RjOrFj1FJKKkmK+nmvcgGDB/Qv4b7YT5uD57kwxdY1YK
         nVmWZ8YludAuPALlVKFPwLt+xOT24FWWOTQsIrR7+nLJXwafZkSj5XRJPVWjWIkhUfv9
         QT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHxvOvsF+Ys03+6wrkcWWXn79qRVd5rUbUqEe5lmuak=;
        b=gNG+5cFTYWqRxiqnKvM7WLF3OrxjVDP4cBVTJTPBq28o/TH0LJ+FDW4bl5Tt/gzeOL
         qwp39LtSCAeIeI6dpMCthz7VgSPYMry9B2ttLTS3YwtL3a9S6oZvs76qWjvnZ0lYECUD
         Aiz3ND6/fw33xuQQBEKAgptIasjsUSh74cev/qX1gpGUIsFWKiBhiCFfFRNjkyNK4wsq
         V/npOVZlk5qaZyYtRbbOQikUF9a5bD0TbCwMCma7eLO7RCmkdMxc9m0XaE2HNoLV1fxJ
         84GmwgLzFhbHWdfwqpo0qPyZQyN3QDLHzRpTgGj8gk9jUaLpYDNfYO0TlA4XBTci1sru
         4FPQ==
X-Gm-Message-State: AOAM531KLwKKJEhZKK7onRWBNYgHMQNkeLdZfgz+idYYUaEdTOfH1DWN
        EJwnOOS1gjcqkW+vW+GpiLm5zkdKAFM=
X-Google-Smtp-Source: ABdhPJwyYcT/6aOfAzbHyLjUNStEwpya6O4BkUGISUk5NFfds5HAUzGSaBlpXR+vEAADMDAhHlTj8A==
X-Received: by 2002:a17:902:d50e:b0:151:b8a4:2a84 with SMTP id b14-20020a170902d50e00b00151b8a42a84mr560633plg.17.1646434030890;
        Fri, 04 Mar 2022 14:47:10 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id a5-20020a621a05000000b004e1cb7632a7sm7205381pfa.64.2022.03.04.14.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:47:10 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        netfilter-devel@vger.kernel.org
Subject: [PATCH bpf-next v4 7/8] bpf: Replace __diag_ignore with unified __diag_ignore_all
Date:   Sat,  5 Mar 2022 04:16:44 +0530
Message-Id: <20220304224645.3677453-8-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; h=from:subject; bh=/N0nS7sRMuholm5Xm4LDpnIHKIDwW8B47uKsPJl8FD0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIpastKHZfX8qLJG2j506OZBp1p0zlMK3RCT4IUEl VIceAWuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiKWrAAKCRBM4MiGSL8RyhubD/ 4hSJZeDFT9+IHlq5w8BhYEIAOz0F9X46oRuTFxBtADuO+9mSWrifaIrve/HX4kD+F9ASt9edWTBCuZ Q1vO6VqnpTcOpKzdfCAL6BKjWzAjAP1greJftRRjw0aXN9xVuDkpubIiAduGnsJc9sxvWHV72F6Q5j pHXIZcNoCEOoDnVOnamgMf6BSNOEd1sccgo1pcSaj2RxZLgxs7aBOkkbXrp2QoKmb3X/DMRny+Dlh9 2ltwOkANm8qv+FwAsscH42F2B8++qxZ/Tf5omHaGETQoG4Gf0s7EEI8bC7Yzn7lw5VuaU2oBDiu18Z v28Spqdpeq3aiZwoefNX65tFiHtzo6EP+aOQuTztqb+dWacH1VhiTlf2QsxiQeOUt5qRj1JKraP1z4 4ixEf1hfCV8UVS9lIXRvkDhvrjKsT4rV2ePaNK7PghCAjO4lf5G4ge3kwQIMRfrWEw0z7zbQWAPTSD dNUoP8BDzCLueCwlgE9xlqyd/ALnCzcBi/bDz3HbwdHA7jrLwreqhT1R3zgoO6woujZry/zCoy5x/Z ZFZmcXiY38gvol/PDHI1tG7Ns09FJ1ausP3mrAxUKYlx/Q1eQFWU+rM+As9pS1/dQBterpLdDtguov vT2fbnXac2xuvTNwdUD/69OqGzJP+DiGoTD5v+faJr3874MGq+3mo5Vhz/xQ==
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F624CB5FA
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiCCEvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCCEvo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:51:44 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3721480D2;
        Wed,  2 Mar 2022 20:51:00 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id q8so4499843iod.2;
        Wed, 02 Mar 2022 20:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpA4Tn4BdbASjtkdITkEnpeatMSnicVhaMI+Ia6lyaQ=;
        b=qzP2yBpi0W620+AMAYAxQpATXWfh/oQgeA8CUJMWUPV6pFewMt/tnr+dDc70eyGmCp
         7uHJfk/+umK/Bffg0w/EF5I2B05sE4BVSEwmn04wdG7z1ulItbDuwUcS/A0FIMnJzFBG
         vvxgr6RLm5fDu+13IzGX+LCmMi7CeQ2BhzGHxvl+PTR8y1/V5Vaz3w8+E20ojM+gw/N4
         7uZ5oFGwocuufFiqYmIcqH5FWCxNsUCucvnld31pnA5ShreAYNbI9+CU4cH3MM7pq3wJ
         pn0yylJjVs+9qOyEqkOEaxW0lLjiFWamVmZ1zzTyc3DWFh0HNiMJ6CuUwbj0gYFHs+/m
         JZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpA4Tn4BdbASjtkdITkEnpeatMSnicVhaMI+Ia6lyaQ=;
        b=HHIqQ9Xoe6mFjiaLCjuMGAOrqOc8BwFyX7ARSf2u+T1UL/nYzUsKyYpfBx1qgtqeYC
         jz0vHJSWfCzDEANAoSuM1rqtDXKgasztnBI9oVFuUJIdrekOib4K0M6SoK48B02Yq65T
         yc8VEXMutleVZMzdFbDBsgM57yRT5u4UPFVfD0cnBWQnH4Lr95LiwcMESICLeqlDSe4m
         B6m6FfDiI4yN721OLmLnFpv4z5V3xjfRwQr92kD1/jLgfCBKBlo3Er4rDcSMpvacwqJJ
         AbKRUayy2lPCrnTvWYP6cJIRz50VkCpapHm1+u/kO3URD18m16Qbk1RqNjR9wEJfIkxg
         Ealw==
X-Gm-Message-State: AOAM532R0Avl0E8xtovUZAHPJ5E86gHbjmBTn0vscV4opSJzs4KqkqDx
        TggS0gJ5fzRmdvRowXA2LaWN90PrBAk=
X-Google-Smtp-Source: ABdhPJxo6VNiNhWNfX+Ap4hGQnqL5MFsIMywISq0zdRjxQUXtgNWpu1Z6GK43SWvya4uiHTiwVCa6w==
X-Received: by 2002:a02:9305:0:b0:313:f281:cb5d with SMTP id d5-20020a029305000000b00313f281cb5dmr27190313jah.278.1646283059450;
        Wed, 02 Mar 2022 20:50:59 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id r9-20020a056e0219c900b002c5ffafa701sm706612ill.79.2022.03.02.20.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:50:59 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        netfilter-devel@vger.kernel.org
Subject: [PATCH bpf-next v2 7/8] bpf: Replace __diag_ignore with unified __diag_ignore_all
Date:   Thu,  3 Mar 2022 10:20:28 +0530
Message-Id: <20220303045029.2645297-8-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303045029.2645297-1-memxor@gmail.com>
References: <20220303045029.2645297-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2204; h=from:subject; bh=43ZTQRgaSQ039xdZjNAT/HKUOnjmRZaQgT2bLcV3jBE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiIEj/sCrbgGVbPjIlmvNDTlnlFsfB/PVyfDLIpeQ+ h+4CO6aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYiBI/wAKCRBM4MiGSL8RygrBD/ 9gKnljlm+wDuDLBaz8FMgbaWXeg0kCHGJ4U4VC9epo6hEfdc5KhP3WNCF8XE48+SLam8Nir0P+sOlL M6nKwGR5QyqP43N8JKwUYFXIKixz/TporcIY9cV3zaLTwbNs1cVk/iySfhLfJRsktJ54SLgLwlhwjo I77CzXsAU9vUQsg9VmGhU3WJk0U32YyQuqsZ5yTSVzAU1cQ723R1Dev4KBwluozOfr40C17+4sCSKB +KV+blIA9OPT9nDvcLcgEppEL4qvf7wTz4hA0dN/k7l5nDiOq6YpN6VV3bMo0m7MqrT2muBBu1YAc9 3cMSjZwakamL/YyWavaMh6GcBIJMTiqbyI+ddQBJuV2L9lZ9ykeV05nJ1KPXcf2yzza0EgP5IblsND v8o0j7cI75I4KGNOuQo61tUX/DopT0GGRKBMAHs4anU0btegq6VfRKR5oADWP7SFQlTQV9K9hfu14b vkebtCMI0KWRGiGst2ZyopC8sbzP2sbgrUK8tjN+979aBS3rdYtK3CE8KnHQ/Vnim6w+SHpQs6RP4m IlBjqqVEiF1WTEjLehOpmFnO55LedvT1uOc8u4CN30IixTYBXHOkqPNMWY+4CYR58hmty0DaIJkT1X L0nITSqHsamP1Z3lxVsxMjeiGoEKzwy9Fw897x9BrYkEOiphCrwp46SauBuw==
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
clang. This leads to clang builds warning on W=1 mode. Since the flag
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3746AE5C
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 00:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356749AbhLFX0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 18:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350577AbhLFX0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 18:26:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089A0C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:22:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso22381901ybs.14
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 15:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jVqdnJ4CZ/oDGDhnuy1cWmOJI5BBNYAYFnW1DKAwqBM=;
        b=dCjGR6iMVfxiLbBqKZu7zpj/GhhhxP2LnUgDYh8R0vky+nrKZj/e98+6Bkc7PhJWf3
         4L44xxsI1ytkW4/ln1OD3mOc35PaeG1LDAjf6nRjrYtNhoANzcrnUe46VvIhkDwkcD+G
         gWHXZOL0+I8cXW5c+MJYxwEmfUiCN82pJBicosnFVLu59tWTdH1Ay97lrqLiMo7paMeD
         Tl7GeGlk5jUN8wPp8W9/4TFVPvIALcDzDwJ6GH4ooRkwADi4eBMuki/dOSq/Wd9pvSBc
         +uNDrNU+D27bGrNpoCLOyJzfRg7QPKWMZxnIuD04S3GS1oBcSSuTHN7vJRql+cjCp9WJ
         LG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jVqdnJ4CZ/oDGDhnuy1cWmOJI5BBNYAYFnW1DKAwqBM=;
        b=7kDJQGp0BerWKhNbivDAdc1Uc6XVIICPS0fhoJqO4OqGBJEoHTzoyenj0DjGJ1STcd
         OSXlbUNT8Fg0YxMD7M9mlao//3qgeQuXcrSKpKbyR0KwkW6elMCeRSSEmdJCZiyEjHv9
         2GN/Q37DrhzUG1NBoYsm1vSedhWjv+8CHfQENH0LczmLuICaOfPq/t7SCsMPcptJhAXD
         Jb0V2poXxDhzjVr0SFHenTZ+ZMgPGbog6MCFtBqV7f0pD2i7PfdNz1N7ghUR4EZbaoBT
         zplgZohzOUu8vMQZv15YaTEjHcQC1KqnE8NL9F8LtjzbIxiE/SfraJCrYEWSLTqVXXOf
         Tlkg==
X-Gm-Message-State: AOAM533gejZIEyHP2tgZyxGgUT2upbztLLMFFJSXkKM8zR1TuavocVo3
        f3Uwx/ttEf0H4jSE17w/Ng5oxip3UAI=
X-Google-Smtp-Source: ABdhPJz0ZwYzYkYu8DK/m8rLjMGsZGLcE61QtPI3V5ROiYSHAnjhHliEV8tbv11D1sF2abbd8eVw6L33ylM=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:2977:d88c:3c3:c52a])
 (user=haoluo job=sendgmr) by 2002:a5b:611:: with SMTP id d17mr45415682ybq.196.1638832963199;
 Mon, 06 Dec 2021 15:22:43 -0800 (PST)
Date:   Mon,  6 Dec 2021 15:22:24 -0800
In-Reply-To: <20211206232227.3286237-1-haoluo@google.com>
Message-Id: <20211206232227.3286237-7-haoluo@google.com>
Mime-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH bpf-next v1 6/9] bpf: Convert PTR_TO_MEM_OR_NULL to composable types.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove PTR_TO_MEM_OR_NULL and replace it with PTR_TO_MEM combined with
flag PTR_MAYBE_NULL.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 1 -
 kernel/bpf/btf.c      | 2 +-
 kernel/bpf/verifier.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0d88e6027ca1..03418ab3f416 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -506,7 +506,6 @@ enum bpf_reg_type {
 	PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
 	PTR_TO_TCP_SOCK_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
 	PTR_TO_BTF_ID_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_BTF_ID,
-	PTR_TO_MEM_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_MEM,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a51b9f54b77a..7adc099bb24b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5860,7 +5860,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 
-			reg->type = PTR_TO_MEM_OR_NULL;
+			reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
 			reg->id = ++env->id_gen;
 
 			continue;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 66e3891f5811..f8b804918c35 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13303,7 +13303,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_known_zero(env, regs, i);
 			else if (regs[i].type == SCALAR_VALUE)
 				mark_reg_unknown(env, regs, i);
-			else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
+			else if (base_type(regs[i].type) == PTR_TO_MEM) {
 				const u32 mem_size = regs[i].mem_size;
 
 				mark_reg_known_zero(env, regs, i);
-- 
2.34.1.400.ga245620fadb-goog


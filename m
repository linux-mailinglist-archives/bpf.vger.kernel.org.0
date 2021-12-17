Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3D478156
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhLQAcQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAcP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:32:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CCAC061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l75-20020a25254e000000b005f763be2fecso1529905ybl.7
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gEvpFxld/FUGPvxxzq5X3U/ewdvgdwOk3Myu3GE/uxA=;
        b=YQihay5yVHt3YjBSKy5e5792Xdbi6WGwYRGyTy6u8P2uKXwpW3rg1+GN/k0PnocXhn
         y2/swzfbLn+DugEsJGUf8jzEI/TkO9cZmh1vseGodM6Bba5JIfItKTvkfEKFX8mfhcBh
         qtvC0NjxoxVQifCg3qAbZOrRmPLh9rHCoFwSwqkMdtU29pUhaOwGDt6dKwo8yH/Z9ZqH
         NSeVv0n2j1NxCRbcbFkc/XNzgfZuNdq2Q+NkkXpvoE4Dr5l2waN+RQZ171FGQxNMDmuA
         cVVidCDO0bImH3c+DQUkvnyVh3RSONHveAkWiR/JV6IxKNS3bnGj4cP432gOdpMeX51Z
         +lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gEvpFxld/FUGPvxxzq5X3U/ewdvgdwOk3Myu3GE/uxA=;
        b=0irV++oxyb7ZSiM+0SMcvFwOIJf2o063ilYOx94zjKtsii3urPZPje2vEeIYDD3oOJ
         BVTj9iNI8kaFzb5kH/+VWu1B5syHVGhBcGfW+Fo5th72wqJdX6TIDEEIESfikrq2unMX
         3ff9/lWduid6IgL8sSVV3t3pYXyx9Cpb6llsLRbP+N8PSrsuyuDIcXFIMHFqYEw7KInr
         gJketTT+IfVajcOq4yqQUnYwCNbiJq526D3DeYlSd0c8lxq4kE/T8GeiGwV7jN819fNd
         SikmE9THhiMBsdM0UW3bwE0Nt2MnmZgduN5UQ5hEbN62UkUE3dO8MdHriFTzZxFy9PcW
         M8SQ==
X-Gm-Message-State: AOAM53004IBNHyTUAO3KzqDLIkDw+V0RVDOJfzsPs0Tz1Usmm3meUnvD
        z6WPq+H0hsDTpBHAG3LYo5Sr16UZMiE=
X-Google-Smtp-Source: ABdhPJxwgyC0mZw1af4P/M9WKFA2GGo/CI2njCmAmfnfI4b1dlSGGWSLlDNnWjszu9tzKIkoNrbOlR+IoCk=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:9064:adcd:ab38:7d29])
 (user=haoluo job=sendgmr) by 2002:a05:6902:1021:: with SMTP id
 x1mr1097000ybt.335.1639701134850; Thu, 16 Dec 2021 16:32:14 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:31:49 -0800
In-Reply-To: <20211217003152.48334-1-haoluo@google.com>
Message-Id: <20211217003152.48334-7-haoluo@google.com>
Mime-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH bpf-next v2 6/9] bpf: Convert PTR_TO_MEM_OR_NULL to composable types.
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
index 126048110bdb..567d83bf28f9 100644
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
index d1447b075c73..d948b5be3bb8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5859,7 +5859,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 
-			reg->type = PTR_TO_MEM_OR_NULL;
+			reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
 			reg->id = ++env->id_gen;
 
 			continue;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a74fa9ed6a6..543e729fa3cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13510,7 +13510,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_known_zero(env, regs, i);
 			else if (regs[i].type == SCALAR_VALUE)
 				mark_reg_unknown(env, regs, i);
-			else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
+			else if (base_type(regs[i].type) == PTR_TO_MEM) {
 				const u32 mem_size = regs[i].mem_size;
 
 				mark_reg_known_zero(env, regs, i);
-- 
2.34.1.173.g76aa8bc2d0-goog


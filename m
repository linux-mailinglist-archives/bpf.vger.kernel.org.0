Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027DC44A484
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbhKICTb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbhKICTa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:30 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E10C061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:45 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 3-20020a620403000000b0044dbf310032so11959064pfe.0
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i2mVI49Mw6eAeYTaGKXIl+4Jv4Eq99aU4biyZahIpKg=;
        b=rH9AFygmOS38Ee2GkpWGYBsT0PSY/kG+xFuaveBKbmSH81bpl8xEpbyVDiqhrvoeHO
         pnI5cX5T4ApiatbYInUMU9ctZ9M8vMTkpborGwvJcW2Wuts3Q1IZm2tmBKaHJeNUBma9
         +gbxeaYqFHP/FIwutdort256X0MDyrKpQMK70/vJvlnyC8EnI105siNuRP2N1t067SGt
         OyZVhVuT7lzS0KwYIYQ3qD0qdNcROMCJNfXTqxSYRW95nXZQVnzzcFJ4TZ5SUpg1uuVo
         wWL/fwBYzQFPtMfgn+v32+ELsuZ/SU02GuJoizhdEtTKzkcwGOJXROvDknguPe7MLjPb
         kzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i2mVI49Mw6eAeYTaGKXIl+4Jv4Eq99aU4biyZahIpKg=;
        b=LjscicriXCS34fndlpOInlHnoDD/XJRsKrX2HVp8aERDjC0DADQTT22gs2KM7EPUQO
         JGIFimvKCDoY52zSQk/ccIZm//940DyvE2hf3ra2s12MHuLIWlTuPgXvud0q25VlCvgt
         nt2naEcBxjsDuah+4/3QHu5Myw+ga0DGqd4Ag6tfTLd40i3vE/LQCRz/e/o0sC6u88oG
         56/isDQKCz3NspNTOuf9oTAPv1IeDefT2/F4zFri0yuY+BP2hA0USB9zIsgocNFTARNc
         2HaUcefBBI+pmN4Ej19HhgNcRpeItvDcvGSyZu1KzZJdj+vPV1vOSaaiaQmb98gFvt/H
         /xxg==
X-Gm-Message-State: AOAM532MLKg6kPEIO/WeXKA6z5YsnRmH+GkOnSfS4MyH8YbveaPBzznk
        QcFqQ3AsUicAxp8UCTTOjOuTah9RVxg=
X-Google-Smtp-Source: ABdhPJx9ltK18YtS55shOGG6jtX0Vmyx8q1JzJepvucExB4DfiC6JmjcsIVIMUZBVIPawSGAepLiMtVEX+4=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a63:6c87:: with SMTP id h129mr3157580pgc.73.1636424205256;
 Mon, 08 Nov 2021 18:16:45 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:22 -0800
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Message-Id: <20211109021624.1140446-8-haoluo@google.com>
Mime-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 7/9] bpf: Remove ARG_PTR_TO_ALLOC_MEM_OR_NULL
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

Remove ARG_PTR_TO_ALLOC_MEM_OR_NULL and use flag to mark
that the argument may be null. This ARG type doesn't seem to be
used anywhere.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 1 -
 kernel/bpf/verifier.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 94eb776c925a..3313ba544758 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -332,7 +332,6 @@ struct bpf_arg_type {
 		ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 		ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
 		ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
-		ARG_PTR_TO_ALLOC_MEM_OR_NULL,	/* pointer to dynamically allocated memory or NULL */
 		ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
 		ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
 		ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f89cf2a59c82..2e53605a051a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -481,7 +481,6 @@ static bool arg_type_may_be_refcounted(struct bpf_arg_type arg)
 static bool arg_type_may_be_null(struct bpf_arg_type arg)
 {
 	return arg.flag & ARG_FLAG_MAYBE_NULL ||
-	       arg.type == ARG_PTR_TO_ALLOC_MEM_OR_NULL ||
 	       arg.type == ARG_PTR_TO_STACK_OR_NULL;
 }
 
@@ -5098,7 +5097,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MEM]		= &mem_types,
 	[ARG_PTR_TO_UNINIT_MEM]		= &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
-	[ARG_PTR_TO_ALLOC_MEM_OR_NULL]	= &alloc_mem_types,
 	[ARG_PTR_TO_INT]		= &int_ptr_types,
 	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
-- 
2.34.0.rc0.344.g81b53c2807-goog


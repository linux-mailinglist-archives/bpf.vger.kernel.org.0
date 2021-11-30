Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72E4629B5
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhK3Bd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbhK3BdZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:25 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DF6C061759
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:06 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x1-20020a17090a294100b001a6e7ba6b4eso8840397pjf.9
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RDCi8G7xVGRONUXV5pNIzgJCdUpec1072HiK9lskLRg=;
        b=M7p4kr805WvuaTVBprIrsbmVQ4GyaUlyBLrtLVXYzY8NEcFqNFIB/AbJgZZe0Z/TIn
         dNtuCSkLNPqa1H0Ogd3yJz738BYMEwBDnc89mU56J4v4sIHWZDkXvUkEtOu0A4Hyjb1/
         WXITPH8Srk2IY9O+I0L5p6ALPhWfICe+I6Exi4USVOvBtH7KGW2ATXZiGvRFkD4sXbfI
         7XgDD4obOzelCWNewVFvL9Vt+XbZsHCpVF4VZA5Melj9ZaXttV6gXshIP8b5CzqmJMos
         snlSTCc7DLEqHPpO0OH0BhrfPRr+wJhO6GY0XRlrU5TX3NHn/tALOUdg8pYZrQvaGIuL
         AXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RDCi8G7xVGRONUXV5pNIzgJCdUpec1072HiK9lskLRg=;
        b=BjsdiBtTCyyZEZ993nuA4G7tuUHrWfBbqVzrakhKLq0AS2JkY1WtkHFIvObxPca3it
         kgKHQGFLM7KXpdF2uRqCoxeSGessqSkvlBYksrkjvolr4IV39+SxBgNp5di2ktTsZmuL
         UxHibDi/KPqcQTF8BywVvLY7UNGk8XFzEl6U9FLp7eg3ghHRgsJvR8S84neMdRIpZ+L+
         N6ZZH8c97MVS9l96IFrG7YjzkIOe9apWc94Wynxe6SNv519MFaWVQ+GyVNQUW8GgtnC6
         2WA3P28ao921qQHxARRa+WaxssAsTHIZCoL5d+fm/o6Yzvd+c+r0P5x/IHEshoVI8P37
         Ujuw==
X-Gm-Message-State: AOAM530dboSrq+plh89hxMPqYqY8dWTJgRioxfRisBXc/I+GcbNGTPbF
        k9BkWIjZwoXg12+lH3o5vd1tA9PXB4U=
X-Google-Smtp-Source: ABdhPJwZz9hMdROefaUdisxZvfwft0wtZLlUQDXXN00Ocyo1RIBdMgQqx2Q8hf/Ay0SgTL81mo3bmMxcVrc=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bbf5:5c09:9dfe:483c])
 (user=haoluo job=sendgmr) by 2002:aa7:8153:0:b0:4a8:2c13:dab7 with SMTP id
 d19-20020aa78153000000b004a82c13dab7mr6514600pfn.51.1638235806061; Mon, 29
 Nov 2021 17:30:06 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:29:45 -0800
In-Reply-To: <20211130012948.380602-1-haoluo@google.com>
Message-Id: <20211130012948.380602-7-haoluo@google.com>
Mime-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC PATCH bpf-next v2 6/9] bpf: Convert PTR_TO_MEM_OR_NULL to
 composable types.
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
index 61b72dbaeae8..19d27d5a1d94 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -514,7 +514,6 @@ enum bpf_reg_type {
 	PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | PTR_TO_SOCK_COMMON,
 	PTR_TO_TCP_SOCK_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_TCP_SOCK,
 	PTR_TO_BTF_ID_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_BTF_ID,
-	PTR_TO_MEM_OR_NULL		= PTR_MAYBE_NULL | PTR_TO_MEM,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 19ddd6fe5663..776b90de0971 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5861,7 +5861,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 				return -EINVAL;
 			}
 
-			reg->type = PTR_TO_MEM_OR_NULL;
+			reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
 			reg->id = ++env->id_gen;
 
 			continue;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 27f3440f4b18..72c7135bee3e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13313,7 +13313,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 				mark_reg_known_zero(env, regs, i);
 			else if (regs[i].type == SCALAR_VALUE)
 				mark_reg_unknown(env, regs, i);
-			else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
+			else if (BPF_BASE_TYPE(regs[i].type) == PTR_TO_MEM) {
 				const u32 mem_size = regs[i].mem_size;
 
 				mark_reg_known_zero(env, regs, i);
-- 
2.34.0.384.gca35af8252-goog


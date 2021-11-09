Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9C544A485
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbhKICTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbhKICTc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:32 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C870DC061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:47 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 184-20020a6217c1000000b0049f9aad0040so7230949pfx.21
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EqJ8jwWGMzPbV8luoAMIHUo4M8MJvCBXrIbCycCKrxI=;
        b=eUJ9y29r1B9HHkxOB9sAszkdBTHJnDsDLF8B4KLty2D/iLb1SDvHpCh5AmBsGV2XVU
         EqL1lRHlLlyM0A/U50wa02R1MLA3E5lTXt5lRltlaY6CN/7WkYTFj9+37trimtXv+5lo
         XMiG/KqGTOe0H4Bmcnb9feJe8Ovs8Px2K7bm6uvghSaa4ZzOhdCe2GruEpxKyMoFLkI6
         mpQ0o9WN1D0cEi63A8+WqZ1amWm33FEuvktRiciDEaRi1qcyVOE/lhAUqzCG2vJwSNa+
         Z1zwNDMThjuh3j9wVRHyoblWn6V+uS6t0gVGQU1NoZJLr7K3WsV3AJKMHOUS6bFaqRaO
         dMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EqJ8jwWGMzPbV8luoAMIHUo4M8MJvCBXrIbCycCKrxI=;
        b=XFwrVGIl4CjwsKWm2ByxBuLZD0npskq/NsuHcTFOQthccQ0V9Qq8EIoAQFuFiZvjlM
         h7L08tpm3SJZfAojeeLT0IlvypIJ2BwY/7DgNpHD/Ye8u6X6j8BRFKepTIqHaSLs6BhK
         sLeorxr9ZCeIujaoxh5EhCooezZ6pPwJcRtl5Dl9nnAUeSJDPIxz3YquQu0+w9eVC1Nm
         zWplnkx4R4Vm8gLWyYgHBA1p8obrW0HUlilmdAp9xVIm/Y7xLggyWgm6k9YEn0Bfy9He
         A32uBfiK0xD/+5jfO7FpblJFg1sqTMlhcGoBnZM43qX7gGFCuo2j6np7KLROvPs0gT4g
         s36w==
X-Gm-Message-State: AOAM532u0uzb6+8RXkmclsHQHaHm/03LTaggtG8l6+keDimjAUMHxMJP
        QbRpWe76kbSg1JiEcWnUzrcXd/XCmd4=
X-Google-Smtp-Source: ABdhPJz1aopnmiVigurHtgl6eNuahNoSo/i72v39z4w9pY9oGRp2Q5X34eHOoW1Nu66+QFZm2+U7yYUwamI=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a63:6b03:: with SMTP id g3mr3194800pgc.123.1636424207320;
 Mon, 08 Nov 2021 18:16:47 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:23 -0800
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Message-Id: <20211109021624.1140446-9-haoluo@google.com>
Mime-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 8/9] bpf: Rename ARG_CONST_ALLOC_SIZE_OR_ZERO
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

Rename ARG_CONST_ALLOC_SIZE_OR_ZERO to ARG_CONST_ALLOC_SIZE and
use flag to mark that the argument may be zero.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 2 +-
 kernel/bpf/ringbuf.c  | 5 ++++-
 kernel/bpf/verifier.c | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3313ba544758..a6dd5e85113d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -332,7 +332,7 @@ struct bpf_arg_type {
 		ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 		ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
 		ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
-		ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
+		ARG_CONST_ALLOC_SIZE,	/* number of allocated bytes requested */
 		ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
 		ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
 		ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index a8af9c7c6423..132e03617881 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -363,7 +363,10 @@ const struct bpf_func_proto bpf_ringbuf_reserve_proto = {
 	.func		= bpf_ringbuf_reserve,
 	.ret_type	= RET_PTR_TO_ALLOC_MEM_OR_NULL,
 	.arg1		= { .type = ARG_CONST_MAP_PTR },
-	.arg2		= { .type = ARG_CONST_ALLOC_SIZE_OR_ZERO },
+	.arg2		= {
+		.type = ARG_CONST_ALLOC_SIZE,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg3		= { .type = ARG_ANYTHING },
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2e53605a051a..9c4a8df25ef2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4957,7 +4957,7 @@ static bool arg_type_is_mem_size(struct bpf_arg_type arg)
 
 static bool arg_type_is_alloc_size(struct bpf_arg_type arg)
 {
-	return arg.type == ARG_CONST_ALLOC_SIZE_OR_ZERO;
+	return arg.type == ARG_CONST_ALLOC_SIZE;
 }
 
 static bool arg_type_is_int_ptr(struct bpf_arg_type arg)
@@ -5084,7 +5084,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_VALUE]		= &map_key_value_types,
 	[ARG_PTR_TO_UNINIT_MAP_VALUE]	= &map_key_value_types,
 	[ARG_CONST_SIZE]		= &scalar_types,
-	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
+	[ARG_CONST_ALLOC_SIZE]		= &scalar_types,
 	[ARG_CONST_MAP_PTR]		= &const_map_ptr_types,
 	[ARG_PTR_TO_CTX]		= &context_types,
 	[ARG_PTR_TO_SOCK_COMMON]	= &sock_types,
-- 
2.34.0.rc0.344.g81b53c2807-goog


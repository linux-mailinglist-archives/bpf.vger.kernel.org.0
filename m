Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E010A44A486
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 03:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhKICTf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 21:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbhKICTe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 21:19:34 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999DFC061570
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 18:16:49 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id u10-20020a170902e80a00b001421d86afc4so7246507plg.9
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 18:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ow/bQhJ5ayiiUZXllV41DC1Xq3tIA+rpjyEckAEfFb0=;
        b=Ol46RKgIm961Ys4mFFcuf7Uacjeo05BLEdNccYkZTjX20rMnPt1EQ95hsyIoNdbobE
         FJ/rNHrmvySzdh0oxfHkMJMBPdn/XoZiCXLcBKm/sNS9D6835UhiCsk5HvDcZEsZApqj
         qFhsifEO37GRRKja/JOtOQpHzXimV2cLK+QIBWzUDLXf716vDQrEIPUCTdtl0FQW6KMo
         2Ve3Eaps3hskOrZ2Q3AccdE/xy4S85KkBFu+BQoK783suW/WjuoTLTmBrmMBJ2uVddMB
         EUVQMTJ+RsbZzL7+mOQeRo5YB2ZKUiX3FIvLISOtCgrc8peAA88xeZm8Ukm37rLcnV2u
         VZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ow/bQhJ5ayiiUZXllV41DC1Xq3tIA+rpjyEckAEfFb0=;
        b=zfQIJ+Z/8+LgeC25N3t7CHqEz54kfjnOSh6fn5q5dTRDN+5gjf7AWyU/VgfMa5IWUF
         bX05/hICXk7RQ3TQlFHB2z2aqvGi7UmNVKGexx+VfkdDOjfEr5/UrtQhcC1rWiMYTK5L
         g2FoAzIknV+otOz48Ga3UR5Wl5vkLhXXGa8sYiaGPhoT83HSJLvE7qyXxNAs0OYVxzgt
         GZnYcd9g/RXaDv477UodN+FAKW74W13AEsin80+1iz0CeY5zO87WclXWB7Gq7kXlv+mD
         LlNT1Ir9tZMRVj9ftcQC+3H+WmtxRukVn+pI5Mmvc69Bt+b1uRiidMlGDJXLayl0gxFZ
         EHvA==
X-Gm-Message-State: AOAM531VLBIxg1/Mm3xk0kQNURJNwatybpfKksfuz9tdJvUZR9FzjhOx
        383OlO91NeLNAgY1T6fLQ7bObXso2fc=
X-Google-Smtp-Source: ABdhPJy3Cb5kzc9a5RxO/VEBuTOIXhOQO8ibQg5j8ZPayd/v34LTFrOx+AXwYano+A1tIuTV1T2+XpCFXyM=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:4c6:4bbe:e4c5:ff76])
 (user=haoluo job=sendgmr) by 2002:a17:903:2283:b0:141:f858:f9af with SMTP id
 b3-20020a170903228300b00141f858f9afmr3497273plh.80.1636424209120; Mon, 08 Nov
 2021 18:16:49 -0800 (PST)
Date:   Mon,  8 Nov 2021 18:16:24 -0800
In-Reply-To: <20211109021624.1140446-1-haoluo@google.com>
Message-Id: <20211109021624.1140446-10-haoluo@google.com>
Mime-Version: 1.0
References: <20211109021624.1140446-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC PATCH bpf-next 9/9] bpf: Rename ARG_PTR_TO_STACK_OR_NULL
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

Rename ARG_PTR_TO_STACK_OR_NULL to ARG_PTR_TO_STACK and use flag
to mark that the argument may be null.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h    | 2 +-
 kernel/bpf/bpf_iter.c  | 5 ++++-
 kernel/bpf/task_iter.c | 5 ++++-
 kernel/bpf/verifier.c  | 5 ++---
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a6dd5e85113d..da4fa15127d6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -336,7 +336,7 @@ struct bpf_arg_type {
 		ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
 		ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
 		ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
-		ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
+		ARG_PTR_TO_STACK,	/* pointer to stack */
 		ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 		ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 		__BPF_ARG_TYPE_MAX,
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 4fdf225c01f9..d3bded3e05d3 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -711,6 +711,9 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1		= { .type = ARG_CONST_MAP_PTR },
 	.arg2		= { .type = ARG_PTR_TO_FUNC },
-	.arg3		= { .type = ARG_PTR_TO_STACK_OR_NULL },
+	.arg3		= {
+		.type = ARG_PTR_TO_STACK,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg4		= { .type = ARG_ANYTHING },
 };
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 0a5e3cf593b5..fc72701ae6b6 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -625,7 +625,10 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 	.arg1_btf_id	= &btf_task_struct_ids[0],
 	.arg2		= { .type = ARG_ANYTHING },
 	.arg3		= { .type = ARG_PTR_TO_FUNC },
-	.arg4		= { .type = ARG_PTR_TO_STACK_OR_NULL },
+	.arg4		= {
+		.type = ARG_PTR_TO_STACK,
+		.flag = ARG_FLAG_MAYBE_NULL,
+	},
 	.arg5		= { .type = ARG_ANYTHING },
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c4a8df25ef2..9c68b664f4f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -480,8 +480,7 @@ static bool arg_type_may_be_refcounted(struct bpf_arg_type arg)
 
 static bool arg_type_may_be_null(struct bpf_arg_type arg)
 {
-	return arg.flag & ARG_FLAG_MAYBE_NULL ||
-	       arg.type == ARG_PTR_TO_STACK_OR_NULL;
+	return arg.flag & ARG_FLAG_MAYBE_NULL;
 }
 
 /* Determine whether the function releases some resources allocated by another
@@ -5101,7 +5100,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
-	[ARG_PTR_TO_STACK_OR_NULL]	= &stack_ptr_types,
+	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
 	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		= &timer_types,
 };
-- 
2.34.0.rc0.344.g81b53c2807-goog


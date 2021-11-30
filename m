Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52344629B6
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhK3Bd2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbhK3Bd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:33:26 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6619DC061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:08 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 141-20020a630793000000b003214e421b2cso9425032pgh.5
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Exj4JgVtM9/UsOnf2JFyDxYEbR+L4FQfiDmLkQojLRI=;
        b=FfcLuhbtjHSR90YpI8fhwGAyUHqCSjEeioEkTQ7zineJEaL2u8ZA97LG3Twwd0uD4I
         ojWpGngE1t/a9FyFE1LeYLxk/86zZ3yOYwbs16uZIxemcSxFPJQCz8FiTPefowhlO7ND
         GXVWiFNWj+dpVwCs9IjIoA4WZhd/gxyPJEav5QYNCkUUS/0NPrgeYT6CY2bEamnkul1R
         qgPj4AXhhMvWN7oQjxDCzJns1EMrlIuCyTq48nImwGMILpMwPeGeniv+IWgqpFiRaEd4
         X0T2qg+GFyF/t7cwlItZ6/MdHa+ZWc7cOonXBTB7nFDhz5JKVmEGhU7FXsyHK8gtcT7j
         or8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Exj4JgVtM9/UsOnf2JFyDxYEbR+L4FQfiDmLkQojLRI=;
        b=ql5TQhLq2Rxu4o7kpORAhJNeuVgIu7lO/qbcAOAWi++GL1ZqLv+VFvpeHdajEykyMc
         ipHhiNOe3F0hTr/a7RP8L9072HixPasZMT/uFdbyPapC0oQ8Azap+0JUcR8vaMafPyO+
         3DYHr+m+o74Or1oRQVlDfrH4vM45fx+JaC84ve+Ddsbl0Vz7FIBnyJkzmkM9I83HtQld
         u+ElIpBPnPHzxHhs8xHxjLi3pI7P4XzcajhNHXVbYqXLSvwPYOv+fS3kU1H0ZU3wvqaH
         xqWxZ74Qa5tqamWARlJC1k3EnoMjlO2gpER5el9YbjUUynJ8ObYctkzCnybA6KtMaz2K
         2UTg==
X-Gm-Message-State: AOAM533MO4AgJsdilIyjzgfMGtQAL9jT/CNDX+oc/+QiewmcRfFUNBB7
        47IWMxKPWWihDcIUgG8qShbDAQ4pB30=
X-Google-Smtp-Source: ABdhPJzoJ7eFQ4bEDPChxmB+3zvSzyeOui3Vwq1YyDhujPt7qoxvvf35eNQ+645FU3+AOA0t9bisEhtyr8s=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:bbf5:5c09:9dfe:483c])
 (user=haoluo job=sendgmr) by 2002:a17:90b:4d84:: with SMTP id
 oj4mr2135863pjb.90.1638235807870; Mon, 29 Nov 2021 17:30:07 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:29:46 -0800
In-Reply-To: <20211130012948.380602-1-haoluo@google.com>
Message-Id: <20211130012948.380602-8-haoluo@google.com>
Mime-Version: 1.0
References: <20211130012948.380602-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [RFC PATCH bpf-next v2 7/9] bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
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

Tag the return type of {per, this}_cpu_ptr with RDONLY_MEM. The
returned value of this pair of helpers is kernel object, which
can not be updated by bpf programs. In addition to tagging these two
helpers, the verifier is now able to differentiate RDONLY MEM from
RDWR MEM.

Fixes: 63d9b80dcf2c ("bpf: Introducte bpf_this_cpu_ptr()")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 293d9314ec7f..a5e349c9d3e3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -667,7 +667,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.func		= bpf_per_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 	.arg2_type	= ARG_ANYTHING,
 };
@@ -680,7 +680,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
 const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
 	.func		= bpf_this_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72c7135bee3e..e2663544362a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4306,16 +4306,32 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				mark_reg_unknown(env, regs, value_regno);
 			}
 		}
-	} else if (reg->type == PTR_TO_MEM) {
+	} else if (BPF_BASE_TYPE(reg->type) == PTR_TO_MEM) {
+		bool rdonly_mem = reg_type_is_rdonly_mem(reg->type);
+
+		if (reg_type_may_be_null(reg->type)) {
+			verbose(env, "R%d invalid mem access '%s'\n", regno,
+				reg_type_str(reg->type));
+			return -EACCES;
+		}
+
+		if (t == BPF_WRITE && rdonly_mem) {
+			verbose(env, "R%d cannot write into rdonly %s\n",
+				regno, reg_type_str(reg->type));
+			return -EACCES;
+		}
+
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
 			verbose(env, "R%d leaks addr into mem\n", value_regno);
 			return -EACCES;
 		}
+
 		err = check_mem_region_access(env, regno, off, size,
 					      reg->mem_size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
-			mark_reg_unknown(env, regs, value_regno);
+			if (t == BPF_READ || rdonly_mem)
+				mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
 		struct btf *btf = NULL;
@@ -9345,7 +9361,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		mark_reg_known_zero(env, regs, insn->dst_reg);
 
 		dst_reg->type = aux->btf_var.reg_type;
-		switch (dst_reg->type) {
+		switch (BPF_BASE_TYPE(dst_reg->type)) {
 		case PTR_TO_MEM:
 			dst_reg->mem_size = aux->btf_var.mem_size;
 			break;
@@ -11489,7 +11505,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 			err = -EINVAL;
 			goto err_put;
 		}
-		aux->btf_var.reg_type = PTR_TO_MEM;
+		aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
 		aux->btf_var.mem_size = tsize;
 	} else {
 		aux->btf_var.reg_type = PTR_TO_BTF_ID;
-- 
2.34.0.384.gca35af8252-goog


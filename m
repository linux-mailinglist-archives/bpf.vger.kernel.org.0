Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531E7272376
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIUMNm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 08:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgIUMN3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 08:13:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77199C0613CF
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 05:13:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so12499986wrv.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ox5PpRMqd4iaf2Pybu9UcxXx6CAUb2mn6YIDK6B9Ras=;
        b=tQOOfjW0iEsr0j90OgVQGhqy6X008zkqUe5qyFXNT7xKVoRPg6TeJQY3+nk9H9mBPh
         +LpPzskAkg2t51k6Q8trvupC4F6a8ZboD3wrFaPCvQHDXoh2BROfItCJFXWYKXu2B2oQ
         q8n70yRhZuyOiqQGP7T/7Giv07JD6iyNXhv4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ox5PpRMqd4iaf2Pybu9UcxXx6CAUb2mn6YIDK6B9Ras=;
        b=gYnoW1d/pdyIjxmyuM164ZhVG8WBTrbgs8e1jbNo96ykTl+p0grgfMX4hubmTHFohq
         cbpma01BW5IkTystMm9pJ51atKpOBAqvO7ES0ydUsYCJx8TR2UuNuLzCAMF4wiTW4eEQ
         YB+FPtmmchCqGhpWVNHtQMepTp1AOaFGztgbzzOrbVue+Ft23QzH++K5/K/B/+26/DcC
         BVV9ziOfB8t79kOgsxXiOjB3Ix3iOZ9yPNaRe8MNl66q1rr2k9nd+ubUQFAy2ylfB7Vq
         QKLkJaMwOVegztE2ivgu7tpJBgbEJ2F/PzF8CgFpYwzBEtXGqUY64VbWGh+cai+BOHbN
         hcNA==
X-Gm-Message-State: AOAM531QV4r54xXKlv/QlJ/lQSIRR9zIBLk2i7thCI9huY588HXeR3oD
        LBxoFaYWQMF/p+MgmL0YxPPoug==
X-Google-Smtp-Source: ABdhPJyBwgoZ3If3ZbQ7kDTHIshhwzItWfJ8mjEqF/dC9SM9G7mVE4s/40+3f6a5ZhK/JV4kgeL0/g==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr53800608wrp.338.1600690408155;
        Mon, 21 Sep 2020 05:13:28 -0700 (PDT)
Received: from antares.lan (5.4.6.2.d.5.3.3.f.8.1.6.b.2.d.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8d2b:618f:335d:2645])
        by smtp.gmail.com with ESMTPSA id t15sm18466557wmj.15.2020.09.21.05.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 05:13:27 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 10/11] bpf: hoist type checking for nullable arg types
Date:   Mon, 21 Sep 2020 13:12:26 +0100
Message-Id: <20200921121227.255763-11-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921121227.255763-1-lmb@cloudflare.com>
References: <20200921121227.255763-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

check_func_arg has a plethora of weird if statements with empty branches.
They work around the fact that *_OR_NULL argument types should accept a
SCALAR_VALUE register, as long as it's value is 0. These statements make
it difficult to reason about the type checking logic.

Instead, skip more detailed type checking logic iff the register is 0,
and the function expects a nullable type. This allows simplifying the type
checking itself.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 64 ++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eefc8256df1c..d64ac79982ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -435,6 +435,15 @@ static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
 	return type == ARG_PTR_TO_SOCK_COMMON;
 }
 
+static bool arg_type_may_be_null(enum bpf_arg_type type)
+{
+	return type == ARG_PTR_TO_MAP_VALUE_OR_NULL ||
+	       type == ARG_PTR_TO_MEM_OR_NULL ||
+	       type == ARG_PTR_TO_CTX_OR_NULL ||
+	       type == ARG_PTR_TO_SOCKET_OR_NULL ||
+	       type == ARG_PTR_TO_ALLOC_MEM_OR_NULL;
+}
+
 /* Determine whether the function releases some resources allocated by another
  * function call. The first reference type argument will be assumed to be
  * released by release_reference().
@@ -3941,17 +3950,20 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 	}
 
+	if (register_is_null(reg) && arg_type_may_be_null(arg_type))
+		/* A NULL register has a SCALAR_VALUE type, so skip
+		 * type checking.
+		 */
+		goto skip_type_check;
+
 	if (arg_type == ARG_PTR_TO_MAP_KEY ||
 	    arg_type == ARG_PTR_TO_MAP_VALUE ||
 	    arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
 	    arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
 		expected_type = PTR_TO_STACK;
-		if (register_is_null(reg) &&
-		    arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL)
-			/* final test in check_stack_boundary() */;
-		else if (!type_is_pkt_pointer(type) &&
-			 type != PTR_TO_MAP_VALUE &&
-			 type != expected_type)
+		if (!type_is_pkt_pointer(type) &&
+		    type != PTR_TO_MAP_VALUE &&
+		    type != expected_type)
 			goto err_type;
 	} else if (arg_type == ARG_CONST_SIZE ||
 		   arg_type == ARG_CONST_SIZE_OR_ZERO ||
@@ -3966,11 +3978,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	} else if (arg_type == ARG_PTR_TO_CTX ||
 		   arg_type == ARG_PTR_TO_CTX_OR_NULL) {
 		expected_type = PTR_TO_CTX;
-		if (!(register_is_null(reg) &&
-		      arg_type == ARG_PTR_TO_CTX_OR_NULL)) {
-			if (type != expected_type)
-				goto err_type;
-		}
+		if (type != expected_type)
+			goto err_type;
 	} else if (arg_type == ARG_PTR_TO_SOCK_COMMON) {
 		expected_type = PTR_TO_SOCK_COMMON;
 		/* Any sk pointer can be ARG_PTR_TO_SOCK_COMMON */
@@ -3979,11 +3988,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	} else if (arg_type == ARG_PTR_TO_SOCKET ||
 		   arg_type == ARG_PTR_TO_SOCKET_OR_NULL) {
 		expected_type = PTR_TO_SOCKET;
-		if (!(register_is_null(reg) &&
-		      arg_type == ARG_PTR_TO_SOCKET_OR_NULL)) {
-			if (type != expected_type)
-				goto err_type;
-		}
+		if (type != expected_type)
+			goto err_type;
 	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
 		expected_type = PTR_TO_BTF_ID;
 		if (type != expected_type)
@@ -3994,27 +4000,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			goto err_type;
 	} else if (arg_type_is_mem_ptr(arg_type)) {
 		expected_type = PTR_TO_STACK;
-		/* One exception here. In case function allows for NULL to be
-		 * passed in as argument, it's a SCALAR_VALUE type. Final test
-		 * happens during stack boundary checking.
-		 */
-		if (register_is_null(reg) &&
-		    (arg_type == ARG_PTR_TO_MEM_OR_NULL ||
-		     arg_type == ARG_PTR_TO_ALLOC_MEM_OR_NULL))
-			/* final test in check_stack_boundary() */;
-		else if (!type_is_pkt_pointer(type) &&
-			 type != PTR_TO_MAP_VALUE &&
-			 type != PTR_TO_MEM &&
-			 type != PTR_TO_RDONLY_BUF &&
-			 type != PTR_TO_RDWR_BUF &&
-			 type != expected_type)
+		if (!type_is_pkt_pointer(type) &&
+		    type != PTR_TO_MAP_VALUE &&
+		    type != PTR_TO_MEM &&
+		    type != PTR_TO_RDONLY_BUF &&
+		    type != PTR_TO_RDWR_BUF &&
+		    type != expected_type)
 			goto err_type;
 	} else if (arg_type_is_alloc_mem_ptr(arg_type)) {
 		expected_type = PTR_TO_MEM;
-		if (register_is_null(reg) &&
-		    arg_type == ARG_PTR_TO_ALLOC_MEM_OR_NULL)
-			/* final test in check_stack_boundary() */;
-		else if (type != expected_type)
+		if (type != expected_type)
 			goto err_type;
 	} else if (arg_type_is_int_ptr(arg_type)) {
 		expected_type = PTR_TO_STACK;
@@ -4051,6 +4046,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 	}
 
+skip_type_check:
 	if (reg->ref_obj_id) {
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-- 
2.25.1


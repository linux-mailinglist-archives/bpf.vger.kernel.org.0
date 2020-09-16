Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FF26C695
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgIPRzY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbgIPRy3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64153C061355
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so3953526wmk.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ox5PpRMqd4iaf2Pybu9UcxXx6CAUb2mn6YIDK6B9Ras=;
        b=aP+Hf6yGcWytiXcJa/z/kZW3EJ8o7tUM/L6Xi5QKTIFircsi941wHTRPVSL9el8H9+
         g1A764XZ+Qy9V1IN5V6BK3J0NYNV6bDLPx43+lFc413/fkyAks23AxxkxGCV8VPw1m/S
         6R9VZ1IXVQYtjrfV6b9GNZLpzsXG29qGoSCTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ox5PpRMqd4iaf2Pybu9UcxXx6CAUb2mn6YIDK6B9Ras=;
        b=MIdBoNYdH29xz12PmoVNmUoVfHm+05fARUrnI9290Coq/hRW9d7+v7wJYuOp9ZCcFb
         Rz12c0IN4dXdIIaCobV2jjeEHb/GFTFSRVr7FspN2jNQgkekNtlvvFiOP6duTEESlGCK
         +z7yQ92SuFqL8ap7SC124U1+MUYdFzw8HwrkSxDezfGjF0DjxlSW9kx7HFkKEkcl6bAA
         9nSFdcvCIQGCT0xKuL3JyVoVl00bK98xg0u067arO83qOoCUuZgRWXG4jVP9qums/C2g
         IYTk4H3S5MA3HYFFO5lA82XRfOx2cxRmzbM+P/sNFZXz8gCPJ8o64Zg6vU7aB73BlyzB
         e+9g==
X-Gm-Message-State: AOAM531vOty2/mOyhO6qni/WABGgjRlA9Uk+Sgq/bk+2D8nbUz2d2lxf
        n+TtyzsB2UTm7sGH9XQZzl5SjA==
X-Google-Smtp-Source: ABdhPJyVw++lo3yIF+zVFmRB0hdIuds1aPh4SzHdDITL/U7sLoM7YhQHR2ImMte0f1SKdZlT394yOg==
X-Received: by 2002:a05:600c:c5:: with SMTP id u5mr5815404wmm.14.1600278825009;
        Wed, 16 Sep 2020 10:53:45 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:44 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 10/11] bpf: hoist type checking for nullable arg types
Date:   Wed, 16 Sep 2020 18:52:54 +0100
Message-Id: <20200916175255.192040-11-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916175255.192040-1-lmb@cloudflare.com>
References: <20200916175255.192040-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
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


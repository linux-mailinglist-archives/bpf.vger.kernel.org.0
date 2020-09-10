Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658AC26467E
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 15:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgIJNCJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730863AbgIJM7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:59:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F68C06179F
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so6577165wrm.9
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgOfVKiukMVYw8gjT+O2u7q6lkrJccwwvIGwMbbjBUA=;
        b=tN543buLTjrOx2kqLT+su3jEjWw7m9s3ruIVzHh274eKhdq7fNy+ALKiyaqqwMpNnX
         kb6RfmTrF3sRtWQ3hxoTAt7hoh37mfVYBbQIRYOv1DTm+V/kSMcnTAlTJPD6MJ45lFUl
         dU2XDYf4bJ+wkeZPLzO3ZNTjd2I13B4JJ0cR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgOfVKiukMVYw8gjT+O2u7q6lkrJccwwvIGwMbbjBUA=;
        b=DQdaBJwSt+QAnpQzs2p0WgD2ySJaViN+F6hcxN5tOdrqLBvaUeusTvPuTra2zXk7Eu
         v4IDtLgvjAVTojW2IAWY2aqOSokrfCiyU9F2loalbXOZMuL9GLjGEhWAN6sS0fT+H2TM
         9H/dCKa30XWCsADvwqaoJrV7UcL3ahz2AsOuZEjXqRQZQ9vlaTAbYj6z8hC1GYrsI1iQ
         MFec/Hj1HBlCURxZFjOoEZBj3aMzPZOI4SNhZ7lnov7HJl6xPibnUQo7Rtx8Uw8AqedQ
         8xxw0VJm1TwSQBmVeNVxQPoWK1RVHQ3OFNlKCcL/bXaTxh3fxtZ/TB8piB5XU0mf+v5D
         3UHA==
X-Gm-Message-State: AOAM531qdMwCt0oTV4PWlx85Mb87pSloc1sVhieLGOo8iuRb6RkgpAHS
        TzeTA5+gRx5S3X3m/m3bsuwFkg==
X-Google-Smtp-Source: ABdhPJyBe6/dYcJkdnVHfXy9PD7R72C8EOnzH3LIWgTgMjkl1NxqOZRrFT21mJgGdZE1IHYyIvLA3Q==
X-Received: by 2002:a5d:4152:: with SMTP id c18mr9450760wrq.277.1599742656534;
        Thu, 10 Sep 2020 05:57:36 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:35 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 10/11] bpf: hoist type checking for nullable arg types
Date:   Thu, 10 Sep 2020 13:56:30 +0100
Message-Id: <20200910125631.225188-11-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910125631.225188-1-lmb@cloudflare.com>
References: <20200910125631.225188-1-lmb@cloudflare.com>
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
index b228467cf837..3e5a3b6f5679 100644
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


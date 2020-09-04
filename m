Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409B025D72A
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgIDL1U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgIDL0U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86822C0619C8
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so6381785wrr.4
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PawVYjT5/eWIPnpFICuKYzn2R6ZAhUHfnyNB/zWr9kI=;
        b=kLN2gbh2C6rZRiVPngrgnJYmrvXKhdbY0HrcGEmok7EFh7EtUOYg+cHLD0COdgFaFE
         x3k5W3SKbk1aU4ZENvRT/4wAsZl4I9MD6jJdf1TCfWDy8K+cCHYbqok6sa+BSCancQVY
         0GMkeoeaF8Wnq1QJmUbuJwS4mJ3yG9m4tTWxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PawVYjT5/eWIPnpFICuKYzn2R6ZAhUHfnyNB/zWr9kI=;
        b=Gm13V4FddOAf8VAfkTdKfDHIQZWe76iv972Rkt826AD4LY1PnQP4CtmyP/+2ZVGNp2
         hdd7lIek08bZwORw9MNT1FWvg7ERGTbsnvp9QdwMKqMVvFAsiZkEFjuJOMga9BLGp1oV
         xQz9breLzeRUH/PsBZRXEEgn/KiUc1WXWCbi41fIKiy97hX2sUn918GACxqsclUwKsP1
         F7OHe0qDpfe52luTi2RqHYeHE07lzDTNGOK54aG4B5cU3v5fGYzgd+iJ1jSURW7stcbv
         ONXYkLZj5KD4cIve0+gnDYE561b2hQQA6R5aktH2LHwo44jYHsVcIQ64cZCrs2mj/y9g
         rhaA==
X-Gm-Message-State: AOAM530AOEniWNTPqAphUrPr0BPL9rcWrSG8MQaBmBKw4QsjRU7PL+gt
        skPUud38CUECcJa8kPPfSCr0B6M5nAdNHw==
X-Google-Smtp-Source: ABdhPJyZGPO53IDXjhfYt3swBWDuoMxXBQdAbaL8s7gG08i8PQIjOJ4XlO4itdmJLC8KAuiZMFy/VA==
X-Received: by 2002:adf:9795:: with SMTP id s21mr7081627wrb.418.1599218665200;
        Fri, 04 Sep 2020 04:24:25 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:24 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 10/11] bpf: hoist type checking for nullable arg types
Date:   Fri,  4 Sep 2020 12:24:00 +0100
Message-Id: <20200904112401.667645-11-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
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
---
 kernel/bpf/verifier.c | 66 ++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d060da0b068..f124551c316a 100644
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
@@ -3946,17 +3955,20 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -3971,11 +3983,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -3984,12 +3993,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	} else if (arg_type == ARG_PTR_TO_SOCKET ||
 		   arg_type == ARG_PTR_TO_SOCKET_OR_NULL) {
 		expected_type = PTR_TO_SOCKET;
-		if (!(register_is_null(reg) &&
-		      arg_type == ARG_PTR_TO_SOCKET_OR_NULL)) {
-			if (type != expected_type &&
-			    type != PTR_TO_BTF_ID)
-				goto err_type;
-		}
+		if (type != expected_type &&
+			type != PTR_TO_BTF_ID)
+			goto err_type;
 		btf_ids = &btf_fullsock_ids;
 	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
 		expected_type = PTR_TO_BTF_ID;
@@ -4001,27 +4007,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -4056,6 +4051,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 	}
 
+skip_type_check:
 	if (reg->ref_obj_id) {
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
-- 
2.25.1


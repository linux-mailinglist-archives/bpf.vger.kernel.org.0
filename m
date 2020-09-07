Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C1525FDFB
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgIGQEJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgIGOsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:48:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B4BC061756
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so14468483wmm.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmVqWjcSMQaUhOrqAhhgjsf1XhmhvdxSOSZRzY4PrPY=;
        b=P6W93AJI2TuCIV+txKN1dFEZnN675MBF6B8HGrQ67CRDnKXcGg24L5XlpfUy3WOVVb
         8Fw3irXJJdqGEhYppUujcCew1+WIK79AaOcUg67Yq1IJRIN5hhYQtoJhnkSU0Fz8Ttbe
         NBLh+HUGKH8OgIabYtk9RdrCSF0OdnedEw/EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmVqWjcSMQaUhOrqAhhgjsf1XhmhvdxSOSZRzY4PrPY=;
        b=cpcS/ekOp5QcJmtYs6+pwPDyFpTQO/GgFxBnSCOAHgAeupbvFYRnck7omuaGZ0aMau
         nhOeGbbDMq8Kew8DlJL39LYuj0TD6W9NTOSpsBSqJF9Yt2WMEQhxx7tJkD1wJ+OZS//W
         6E0g0Gea8+Zq07xxwS5PTsKkiJ0oSU/fQerXjE1yVqI2/mD59DNkvgfKQBwr0fHxEBLc
         PVr4FwmLbApm0kiJchBiCfMwU9AIJpq6+OkbSJdTLmxjpFaArtj0ZlEPLIKO3pTTEJkl
         dEM+ZraEFbjYdPUN1R0yEfMEV35406BJBwkOEfO6pF1z5m39x1IWgj6OTtaL7SMVlLfy
         UBkA==
X-Gm-Message-State: AOAM532kG4+juihIhXt0bVgh8BXIcdJtzoVO79RUZfMf8514UgHdTk4u
        IF4+JhoWSsxmJ9LhvH59DAcutA==
X-Google-Smtp-Source: ABdhPJxKoIxaPLnvtZgRAKldcf+5DA+XYcxlgEZjcrxY4f5XFhOWlkutUeH3mS+IUTlmeMKyIkfRLA==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr20423690wmb.166.1599490108258;
        Mon, 07 Sep 2020 07:48:28 -0700 (PDT)
Received: from antares.lan (2.e.3.8.e.0.6.b.6.2.5.e.8.e.4.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b4e8:e526:b60e:83e2])
        by smtp.gmail.com with ESMTPSA id 59sm8816834wro.82.2020.09.07.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:48:27 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 1/7] bpf: Allow passing BTF pointers as PTR_TO_SOCK_COMMON
Date:   Mon,  7 Sep 2020 15:46:55 +0100
Message-Id: <20200907144701.44867-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907144701.44867-1-lmb@cloudflare.com>
References: <20200907144701.44867-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tracing programs can derive struct sock pointers from a variety
of sources, e.g. a bpf_iter for sk_storage maps receives one as
part of the context. It's desirable to be able to pass these to
functions that expect PTR_TO_SOCK_COMMON. For example, it enables us
to insert such a socket into a sockmap via map_elem_update.

Note that we can't use struct sock* in cases where a function
expects PTR_TO_SOCKET: not all struct sock* that a tracing program
may derive are indeed for a full socket, code must check the
socket state instead.

Teach the verifier that a PTR_TO_BTF_ID for a struct sock is
equivalent to PTR_TO_SOCK_COMMON. There is one hazard here:
bpf_sk_release also takes a PTR_TO_SOCK_COMMON, but expects it to be
refcounted. Since this isn't the case for pointers derived from
BTF we must prevent them from being passed to the function.
Luckily, we can simply check that the ref_obj_id is not zero
in release_reference, and return an error otherwise.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b4e9c56b8b32..f1f45ce42d60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3908,6 +3908,9 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	return 0;
 }
 
+BTF_ID_LIST(btf_sock_common_ids)
+BTF_ID(struct, sock)
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -3984,7 +3987,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	} else if (arg_type == ARG_PTR_TO_SOCK_COMMON) {
 		expected_type = PTR_TO_SOCK_COMMON;
 		/* Any sk pointer can be ARG_PTR_TO_SOCK_COMMON */
-		if (!type_is_sk_pointer(type))
+		if (!type_is_sk_pointer(type) &&
+		    type != PTR_TO_BTF_ID)
 			goto err_type;
 		if (reg->ref_obj_id) {
 			if (meta->ref_obj_id) {
@@ -3995,6 +3999,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			}
 			meta->ref_obj_id = reg->ref_obj_id;
 		}
+		meta->btf_id = btf_sock_common_ids[0];
 	} else if (arg_type == ARG_PTR_TO_SOCKET ||
 		   arg_type == ARG_PTR_TO_SOCKET_OR_NULL) {
 		expected_type = PTR_TO_SOCKET;
@@ -4004,33 +4009,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				goto err_type;
 		}
 	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
-		bool ids_match = false;
-
 		expected_type = PTR_TO_BTF_ID;
 		if (type != expected_type)
 			goto err_type;
-		if (!fn->check_btf_id) {
-			if (reg->btf_id != meta->btf_id) {
-				ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
-								 meta->btf_id);
-				if (!ids_match) {
-					verbose(env, "Helper has type %s got %s in R%d\n",
-						kernel_type_name(meta->btf_id),
-						kernel_type_name(reg->btf_id), regno);
-					return -EACCES;
-				}
-			}
-		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
-			verbose(env, "Helper does not support %s in R%d\n",
-				kernel_type_name(reg->btf_id), regno);
-
-			return -EACCES;
-		}
-		if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
-			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
-				regno);
-			return -EACCES;
-		}
 	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
 		if (meta->func_id == BPF_FUNC_spin_lock) {
 			if (process_spin_lock(env, regno, true))
@@ -4085,6 +4066,33 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return -EFAULT;
 	}
 
+	if (type == PTR_TO_BTF_ID) {
+		bool ids_match = false;
+
+		if (!fn->check_btf_id) {
+			if (reg->btf_id != meta->btf_id) {
+				ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
+								 meta->btf_id);
+				if (!ids_match) {
+					verbose(env, "Helper has type %s got %s in R%d\n",
+						kernel_type_name(meta->btf_id),
+						kernel_type_name(reg->btf_id), regno);
+					return -EACCES;
+				}
+			}
+		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
+			verbose(env, "Helper does not support %s in R%d\n",
+				kernel_type_name(reg->btf_id), regno);
+
+			return -EACCES;
+		}
+		if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
+			verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
+				regno);
+			return -EACCES;
+		}
+	}
+
 	if (arg_type == ARG_CONST_MAP_PTR) {
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
 		meta->map_ptr = reg->map_ptr;
@@ -4561,6 +4569,9 @@ static int release_reference(struct bpf_verifier_env *env,
 	int err;
 	int i;
 
+	if (!ref_obj_id)
+		return -EINVAL;
+
 	err = release_reference_state(cur_func(env), ref_obj_id);
 	if (err)
 		return err;
-- 
2.25.1


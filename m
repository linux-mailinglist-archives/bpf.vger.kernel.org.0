Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FBD25D585
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgIDJ71 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 05:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgIDJ70 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 05:59:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC2C061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 02:59:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u18so5502354wmc.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 02:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBg7pzHbUy+TteUYYcU5RnIAdV4RCIGAhmMWijOI+mU=;
        b=GnccJ2Lm1l1Z07hva7P7+o9/Rz37K3XrqW4TgqwdxJ1znVU4i/swERMMTNm7gTTMGZ
         DUZbH5PXk85ofydLM/3/A1/CvpjqivupBj2Yz3WOuin8Yfo6Y0qchs6oi8McsYkkuikN
         Gu2HyMIWUY3ZXzEMNtpZmc9YafA3OshKmWgXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBg7pzHbUy+TteUYYcU5RnIAdV4RCIGAhmMWijOI+mU=;
        b=c/0yS+MmdR738A4CpCDMpC1XLPC65uEOgjNMzJKNcok5jgDz1yXyWxzXLZ9zSMCkIu
         pFSR+ogTWuI7EewEv5IYX9MCxdDZjj0IvcPnIdRFhFBAbNSqt9xP1r3Co9TnA06P1GDx
         yaGi+iANa1weIn5nJh63SdLGYNbvgSDGmQc2X5GyssYEy9yHH4dXV5HRA79dBTgJU24I
         bUZF3z4uRvfedKmKk6uwmABpi1kj/bK0cThRbkCmo47R7l2UpDcTNnmCbJRCqxtOzhxE
         NFbPQF0QwFW9ROfCsFoFQ8rPcpazD8J4lnU/dCos51h3Z6+aTSXZaUoSjw+vKZEqqo9l
         Ot2Q==
X-Gm-Message-State: AOAM532lq5u8FspBvzVG5zo/9BYuvrtWrvluSaQj4ImqCtD0mAyVyJwq
        3L7GRGrLEUSzBp//7lXMwPeGlg==
X-Google-Smtp-Source: ABdhPJwRruz6d6QHKruPLoaDhiFAZqG34vnHtypKxnAjypHRQgTkPA3AwprcLLIyKg5VsJAapkTU8Q==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr6635645wmc.81.1599213563824;
        Fri, 04 Sep 2020 02:59:23 -0700 (PDT)
Received: from antares.lan (a.6.f.d.9.5.a.d.2.b.c.0.f.d.4.2.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:24df:cb2:da59:df6a])
        by smtp.gmail.com with ESMTPSA id c18sm11648088wrx.63.2020.09.04.02.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:59:23 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 1/6] bpf: Allow passing BTF pointers as PTR_TO_SOCKET
Date:   Fri,  4 Sep 2020 10:58:59 +0100
Message-Id: <20200904095904.612390-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904095904.612390-1-lmb@cloudflare.com>
References: <20200904095904.612390-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tracing programs can derive struct sock pointers from a variety
of sources, e.g. a bpf_iter for sk_storage maps receives one as
part of the context. It's desirable to be able to pass these to
functions that expect PTR_TO_SOCKET. For example, it enables us
to insert such a socket into a sockmap via map_elem_update.

Teach the verifier that a PTR_TO_BTF_ID for a struct sock is
equivalent to PTR_TO_SOCKET. There is one hazard here:
bpf_sk_release also takes a PTR_TO_SOCKET, but expects it to be
refcounted. Since this isn't the case for pointers derived from
BTF we must prevent them from being passed to the function.
Luckily, we can simply check that the ref_obj_id is not zero
in release_reference, and return an error otherwise.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b4e9c56b8b32..509754c3aa7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3908,6 +3908,9 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	return 0;
 }
 
+BTF_ID_LIST(btf_fullsock_ids)
+BTF_ID(struct, sock)
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -4000,37 +4003,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		expected_type = PTR_TO_SOCKET;
 		if (!(register_is_null(reg) &&
 		      arg_type == ARG_PTR_TO_SOCKET_OR_NULL)) {
-			if (type != expected_type)
+			if (type != expected_type &&
+			    type != PTR_TO_BTF_ID)
 				goto err_type;
 		}
+		meta->btf_id = btf_fullsock_ids[0];
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


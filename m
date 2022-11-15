Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3665F628DE2
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 01:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKOAC4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 19:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKOABq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 19:01:46 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A791FB1ED
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:45 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w23so5175779ply.12
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 16:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmkzNiMhMpzVxaMwoGjL9LJGwwdguwmfc96PIBOM3ZA=;
        b=Ava8re4a3pTJmdbRGzKolVMPiBHb6aa1cZxm30imlN3TdIhXpHNnljcwa/bUSf/uUh
         eXE5Eeg7lNKiQD1ik5i3gpAgtMprSr1kc7I5qwibPIhKe0M4NQLXVICnVnCXxyJBQWSh
         LvjxrlxN7j2JGv48s4sEnSfMS7kjNRbrbYR+Y5cuNSijDHmTll3TuRsIEVbB70h/5pxU
         iFfTKjfYgzOp/kF/TOwRbNc0RaOablZ1UMHMQFuBZCKq7qG2D4sNJNPpj7sLhmmYPM/Q
         O6hFS0TU6V24lH13vJGYfyMKJ10YMZmRoMyLH9iNND6DrDmd/m5rPakdUrwdzwEwzQt7
         jbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmkzNiMhMpzVxaMwoGjL9LJGwwdguwmfc96PIBOM3ZA=;
        b=vzaOUgti3NWb7VLlYUMXZJ276B++OzguNHIwrmOsdKHsgAX8626SIIpQG5XGJcbbwI
         wNV4ibIqdeTshKw3TkXgF+zIH0oJZclVsp0nvVYRs4AzlkS8qrLCwIULV4CpZBdHl/DJ
         +jEGQ/5tztmpsZRC256LTw+2EEC+oosZBZdWwFmdYiwvm/oL2guUFI6uaqFXex2NIkQk
         jQpdreuw97ZWdmJ0ApINfEGWdwJ0u6Dqo6s4jyN7El8N52Xt6Z0cSuE9dFZcKdFiYTde
         v76Z6rte2qOUmn5ud9aI6vThxFKU8mRhBHF68qMjxTcXiZHzkEVqOwW30K1lpzRqQHI2
         /pBA==
X-Gm-Message-State: ANoB5pnzkUpCyCiCrW8oH01lrUEjCd15itgJk5HCRaI18GDcH18cBpjq
        8uF+YlU6IvWRQRYz+cA/YYXXB7PSJA9lOQ==
X-Google-Smtp-Source: AA0mqf6UcCKkl7Cl401fVOkX7kYhu/Ib5/zZcKiqZef9f9La4tWBJmLqkkqAyVm46BnPFoe2H2gecw==
X-Received: by 2002:a17:90a:6f61:b0:215:db2e:bb17 with SMTP id d88-20020a17090a6f6100b00215db2ebb17mr15889830pjk.166.1668470505082;
        Mon, 14 Nov 2022 16:01:45 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a8b8600b0020ad86f4c54sm7150820pjn.16.2022.11.14.16.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:01:44 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 4/7] bpf: Rework check_func_arg_reg_off
Date:   Tue, 15 Nov 2022 05:31:27 +0530
Message-Id: <20221115000130.1967465-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115000130.1967465-1-memxor@gmail.com>
References: <20221115000130.1967465-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6373; i=memxor@gmail.com; h=from:subject; bh=Qvz4MOK2PUkz7b8XDLMgB2UMc4dEh3SP1U0Ifo75YT8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjctaC7kT5AnynkXcc0YTmJ/gSuG7EDRuyDNRE6WBc 9HmnR0yJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3LWggAKCRBM4MiGSL8RytRRD/ 9WGzbQuJAcUL1vNB+XqrIYqE9/02466aIwF+N5yeiu3/AGMQdXIxCQcO7r+62pKEyqDFOMB+L8ASSw 3H0rOO6yl224WnsfWbFQnYi4rILOqxpOyu9EsSnFtjWxY3OLnF0yGbEPMs5Bt2EqzWCQPwBYc3A7N1 ZEaJWdmv/jiZpcFD86OxGF8p4BsJ8NU49FgYcCf6uecPJYWYY4h9sI4OOYHZKGVGxkFI/03azmCAXe L0ITYXbL4URxFr3UPqWDQWGjjv+lXsIk7ZeMACN4Aek258rz2cwEGGB4/BvVdeAtWEoZ9hs9oFbM8k kCi+w32tbxH/WuyEbAc9r/tFxhb5nWTHZBsUByJREaueCZ+EP7MCXbK3eIW9r46+RHql4UjMhG2nRx 5GPlGbJFZyXzKnEahQn5qlkvkXF3iXBS8Ts3M7oMsaK8Ns3rsIyP+YK4BYafQqQcMj21+vlySzqTRd ObquGzMaEy7gDbY5V4VtBp3uRe2d7hZyrsA5sorcfSedhOBoHj+W2t+BEkmoOk+48jzlHsNLB/W9IP 0CwNfwBuM5zeTXJlYfnYYVGQzD0F+Ulqv5TPnke3IgmYxiq3ZVMdGHS2Cc6Bf7BeXizwF0zfXqU9eV Mhu98O3De4fNFnW+Fe6LFljQXplxEv4bJs8a0237RyahmnHGkdaglyfHW2Bw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While check_func_arg_reg_off is the place which performs generic checks
needed by various candidates of reg->type, there is some handling for
special cases, like ARG_PTR_TO_DYNPTR, OBJ_RELEASE, and
ARG_PTR_TO_ALLOC_MEM.

This commit aims to streamline these special cases and instead leave
other things up to argument type specific code to handle. The function
will be restrictive by default, and cover all possible cases when
OBJ_RELEASE is set, without having to update the function again (and
missing to do that being a bug).

This is done primarily for two reasons: associating back reg->type to
its argument leaves room for the list getting out of sync when a new
reg->type is supported by an arg_type.

The other case is ARG_PTR_TO_ALLOC_MEM. The problem there is something
we already handle, whenever a release argument is expected, it should
be passed as the pointer that was received from the acquire function.
Hence zero fixed and variable offset.

There is nothing special about ARG_PTR_TO_ALLOC_MEM, where technically
its target register type PTR_TO_MEM | MEM_ALLOC can already be passed
with non-zero offset to other helper functions, which makes sense.

Hence, lift the arg_type_is_release check for reg->off and cover all
possible register types, instead of duplicating the same kind of check
twice for current OBJ_RELEASE arg_types (alloc_mem and ptr_to_btf_id).

For the release argument, arg_type_is_dynptr is the special case, where
we go to actual object being freed through the dynptr, so the offset of
the pointer still needs to allow fixed and variable offset and
process_dynptr_func will verify them later for the release argument case
as well.

This is not specific to ARG_PTR_TO_DYNPTR though, we will need to make
this exception for any future object on the stack that needs to be
released. In this sense, PTR_TO_STACK as a candidate for object on stack
argument is a special case for release offset checks, and they need to
be done by the helper releasing the object on stack.

Since the check has been lifted above all register type checks, remove
the duplicated check that is being done for PTR_TO_BTF_ID.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 62 ++++++++++++-------
 .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c484e632b0cd..34e67d04579b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6092,11 +6092,38 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
 			   enum bpf_arg_type arg_type)
 {
-	enum bpf_reg_type type = reg->type;
-	bool fixed_off_ok = false;
+	u32 type = reg->type;
 
-	switch ((u32)type) {
-	/* Pointer types where reg offset is explicitly allowed: */
+	/* When referenced register is passed to release function, it's fixed
+	 * offset must be 0.
+	 *
+	 * We will check arg_type_is_release reg has ref_obj_id when storing
+	 * meta->release_regno.
+	 */
+	if (arg_type_is_release(arg_type)) {
+		/* ARG_PTR_TO_DYNPTR with OBJ_RELEASE is a bit special, as it
+		 * may not directly point to the object being released, but to
+		 * dynptr pointing to such object, which might be at some offset
+		 * on the stack. In that case, we simply to fallback to the
+		 * default handling.
+		 */
+		if (!arg_type_is_dynptr(arg_type) || type != PTR_TO_STACK) {
+			/* Doing check_ptr_off_reg check for the offset will
+			 * catch this because fixed_off_ok is false, but
+			 * checking here allows us to give the user a better
+			 * error message.
+			 */
+			if (reg->off) {
+				verbose(env, "R%d must have zero offset when passed to release func\n",
+					regno);
+				return -EINVAL;
+			}
+			return __check_ptr_off_reg(env, reg, regno, false);
+		}
+		/* Fallback to default handling */
+	}
+	switch (type) {
+	/* Pointer types where both fixed and variable offset is explicitly allowed: */
 	case PTR_TO_STACK:
 		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
 			verbose(env, "cannot pass in dynptr at an offset\n");
@@ -6113,35 +6140,22 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case SCALAR_VALUE:
-		/* Some of the argument types nevertheless require a
-		 * zero register offset.
-		 */
-		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
-			return 0;
-		break;
+		return 0;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
-		 * can be non-zero.
+		 * can be non-zero. This was already checked above. So pass
+		 * fixed_off_ok as true to allow fixed offset for all other
+		 * cases. var_off always must be 0 for PTR_TO_BTF_ID, hence we
+		 * still need to do checks instead of returning.
 		 */
-		if (arg_type_is_release(arg_type) && reg->off) {
-			verbose(env, "R%d must have zero offset when passed to release func\n",
-				regno);
-			return -EINVAL;
-		}
-		/* For arg is release pointer, fixed_off_ok must be false, but
-		 * we already checked and rejected reg->off != 0 above, so set
-		 * to true to allow fixed offset for all other cases.
-		 */
-		fixed_off_ok = true;
-		break;
+		return __check_ptr_off_reg(env, reg, regno, true);
 	default:
-		break;
+		return __check_ptr_off_reg(env, reg, regno, false);
 	}
-	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
 
 static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c b/tools/testing/selftests/bpf/verifier/ringbuf.c
index b64d33e4833c..92e3f6a61a79 100644
--- a/tools/testing/selftests/bpf/verifier/ringbuf.c
+++ b/tools/testing/selftests/bpf/verifier/ringbuf.c
@@ -28,7 +28,7 @@
 	},
 	.fixup_map_ringbuf = { 1 },
 	.result = REJECT,
-	.errstr = "dereference of modified alloc_mem ptr R1",
+	.errstr = "R1 must have zero offset when passed to release func",
 },
 {
 	"ringbuf: invalid reservation offset 2",
-- 
2.38.1


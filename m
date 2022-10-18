Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4783602DB3
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 15:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJRN7s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 09:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiJRN7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 09:59:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F2D6314
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:43 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f140so14161416pfa.1
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P53Tm+dK7GmyEk+HnF9ZWyrUeeMfEERVdJscIZTe1s=;
        b=oemsODqSOJVGwPXy0JRcH//O5Po5XzavztZbzwVzUdRpJ/xKh8RcPAGxicP2QzR2sA
         nyarQreyqaq2s5msLrCTJyN6jXhEb2t1iPXgZzXRiSlAFoDMkiu2EploRo78mPfTaQBp
         FaTGNBC/BDnr+UhzN/HS9L9GJ8UhqGKxeqZmx6bFxugmBPT0BAn5h+jozYKM5g++oydf
         FB/iR3EHs7VWaIjhMIV40yav4xs3sAf++eJnlTsQlhS0YDuiN7PZz4P83Li9jdkXFRNg
         KK2LqPtI+/r+OvVFjT3PFFggIrMyugNDEJk0hRcXMiEudznZVJWRORlNtIwgWeVPiAWA
         wuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7P53Tm+dK7GmyEk+HnF9ZWyrUeeMfEERVdJscIZTe1s=;
        b=Iia1K7N/vLPriAHsJuW3qdOyMKo8mayC3FsduC+pNj5QVrz3ZwNpNu06XCn90gkKfc
         0KgNfznc/1U54U8ou8jU1E2qZIvcPIdIBvmNDwneLUnWkjRF2cp39vpFMniMOYH5yjkL
         X//LgPNZs8o6kBvdKIbtE+8KKAhpmvo1dJ2Hm1S14kWzeHJlNBLsThIFy1fZQh+QR0Y+
         +4FNVehroQplygaFEVbGZN8M4bdGxBVEWKTDKxbr2w27OCyLYxJ9uzOWoKy8kMToP4V9
         OuM7QH1ttBG1+9Ua7VohDt9FTSiATu9tPPnEypeCerd+K5cpAyIS3qtGmrHwRC2xYPPg
         c88w==
X-Gm-Message-State: ACrzQf0pe6yN7Gb/8xRAeQR3iNzeExbDW4Wt2eu03nlvK8k7tjTrLvfV
        IfjczcUkzp3ypzMhzD8aCOB1IkmjbF3Gww==
X-Google-Smtp-Source: AMsMyM4YqBYfI0eajUxB+bBIIIxdXTuGJLfMfKEyy5WegfI/gLm6bQEyjEyyvUV4sI9XRyVCEe//Cw==
X-Received: by 2002:aa7:9614:0:b0:562:b07b:ad62 with SMTP id q20-20020aa79614000000b00562b07bad62mr3377173pfg.79.1666101582192;
        Tue, 18 Oct 2022 06:59:42 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id x32-20020a634a20000000b00456891e1dacsm7938022pga.68.2022.10.18.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:59:41 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 04/13] bpf: Rework check_func_arg_reg_off
Date:   Tue, 18 Oct 2022 19:29:11 +0530
Message-Id: <20221018135920.726360-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018135920.726360-1-memxor@gmail.com>
References: <20221018135920.726360-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5989; i=memxor@gmail.com; h=from:subject; bh=iGBUAdNuqJJP0N6+hvkkSz4lq1kmz+JLsrg6rQs+HAk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjTrEiTpGfzukt7E/RSn9qZoBlrAabWRhqTT+EGtU/ yjAA+ZOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY06xIgAKCRBM4MiGSL8RypdRD/ 9a7hwUyeZfEZLwF6l3IphOo3asWNPHkU4aaj94ebrsoh2dyzZemW+BCOKSm8T8lFmcutuahC0IC5FX iyah4jvY/rcGZIWVtnbR6RYqcfZsfq30VQVi9HhQ+niCEqI/aE+v47UV5ydCN/H7A9R44DZG1K11Dg q95YOoP9KysLBF1NcT/tRm7N/aAjWMspcJBTnZDVRqaoNF/bjsHvfQz127SgjNELxCGGIQKNpfuvhg f0iCSUlTen2PJmRYpCUXXJzfscQdQvfCidEgdh/wkXg03+16hzYnSnGPmzLfgCOTSBNRFCGxapivct mBSz+bJ6jILlE6AdlK2W2oKODINfrJNEjVHi2CZloXphrNc/LN5nz+oRQ+c7z6aQJvTch6WiTOBFsH xBs0zR4KkM3N544TRUO/GumRT4ql9ZOJhItD5R+W7V85zC+9v0Z61rvkRHyyxoy8OFSvxaut1TcKWc y1T48lKldbYUt+Fcc+yP/BEFxanRHeDKaJp3/Q8HFF/Oh4IQ4Ha3VIBx4lhKQyNx4YuikupalHR2Lh aAwTQa5Ipf9Z0PYebtAMmg+2jpuSZ6uk9jtQYMKdcVF9SDcdvegHOpQm89yrM2YihF2a5+QDaIX+Cx s6HhPyDnCHPJP0BP+eANLbGOJ8ms6esH2Qh7dWVkqXhvHMj4xvRSrNkaaESg==
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
other things up to argument type specific code to handle.

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

Finally, for the release argument, arg_type_is_dynptr is the special
case, where we go to actual object being freed through the dynptr, so
the offset of the pointer still needs to allow fixed and variable offset
and process_dynptr_func will verify them later for the release argument
case as well.

Finally, since check_func_arg_reg_off is meant to be generic, move
dynptr specific check into process_dynptr_func.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 55 +++++++++++++++----
 .../testing/selftests/bpf/verifier/ringbuf.c  |  2 +-
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a49b95c1af1b..a8c277e51d63 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5654,6 +5654,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 		return -EFAULT;
 	}
 
+	/* CONST_PTR_TO_DYNPTR has fixed and variable offset as zero, ensured by
+	 * check_func_arg_reg_off, so this is only needed for PTR_TO_STACK.
+	 */
+	if (reg->off % BPF_REG_SIZE) {
+		verbose(env, "cannot pass in dynptr at an offset\n");
+		return -EINVAL;
+	}
+
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
 	 *
@@ -5672,6 +5680,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 *		 destroyed, including mutation of the memory it points
 	 *		 to.
 	 */
+
 	if (arg_type & MEM_UNINIT) {
 		if (!is_dynptr_reg_valid_uninit(env, reg)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
@@ -5983,14 +5992,37 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	enum bpf_reg_type type = reg->type;
 	bool fixed_off_ok = false;
 
-	switch ((u32)type) {
-	/* Pointer types where reg offset is explicitly allowed: */
-	case PTR_TO_STACK:
-		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
-			verbose(env, "cannot pass in dynptr at an offset\n");
+	/* When referenced register is passed to release function, it's fixed
+	 * offset must be 0.
+	 *
+	 * We will check arg_type_is_release reg has ref_obj_id when storing
+	 * meta->release_regno.
+	 */
+	if (arg_type_is_release(arg_type)) {
+		/* ARG_PTR_TO_DYNPTR is a bit special, as it may not directly
+		 * point to the object being released, but to dynptr pointing
+		 * to such object, which might be at some offset on the stack.
+		 *
+		 * In that case, we simply to fallback to the default handling.
+		 */
+		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
+			goto check_type;
+		/* Going straight to check will catch this because fixed_off_ok
+		 * is false, but checking here allows us to give the user a
+		 * better error message.
+		 */
+		if (reg->off) {
+			verbose(env, "R%d must have zero offset when passed to release func\n",
+				regno);
 			return -EINVAL;
 		}
-		fallthrough;
+		goto check;
+	}
+check_type:
+	switch ((u32)type) {
+	/* Pointer types where both fixed and variable reg offset is explicitly
+	 * allowed: */
+	case PTR_TO_STACK:
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 	case PTR_TO_MAP_KEY:
@@ -6001,12 +6033,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
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
@@ -6023,12 +6050,16 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		/* For arg is release pointer, fixed_off_ok must be false, but
 		 * we already checked and rejected reg->off != 0 above, so set
 		 * to true to allow fixed offset for all other cases.
+		 *
+		 * var_off always must be 0 for PTR_TO_BTF_ID, hence we still
+		 * need to do checks instead of returning.
 		 */
 		fixed_off_ok = true;
 		break;
 	default:
 		break;
 	}
+check:
 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
 
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
2.38.0


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF114DC559
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiCQMBu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiCQMBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:01:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0017DCA6
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h5so4246601plf.7
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQQ2O0CJkKadJhQ3DG7ltpqnIn2bih78Mpe73SZTUjU=;
        b=SG4d89wkuyNWx50JmFbRFeP3FfFjzJzaAV8Fx4JSExN90wiZmXylA93sY9WkDWNh+4
         vvgTP/EMLfBCxEwLPfObSrVgrV/gysA8FCBLzeNKIhkxJ3wxlkwq4sGra2092JzQF1vg
         kb5pjLmDXGEsO32JYNAxcxH3Vp0PT3g9Xy7dFf2EmZCb3v3DSiwxhykbOFBerqaatlfj
         3z+PQE6G0yJLJMcmfION8p+hozfhNz5MZrCmnTHV/BnmugNAnavpBLbDbs6huIYg9tcW
         7eZK3+1nD1peA9/b9/PYOf47ncIAIj+OZ7hZOyP0q+i3q3g7GOqqhHLULEowKkJDUTI3
         EZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQQ2O0CJkKadJhQ3DG7ltpqnIn2bih78Mpe73SZTUjU=;
        b=D8k2JmAvjRkN0HahoQoHiudeUDOCNvcwOZWLCxlXrDPRVw8jA4JUk/b6RDcSgCA5oe
         eY53an3CjTgeMsXsudXCYsHVpp8C7oDegpyj1YHqPHcxett8TmeGWB3qSCAN/TztSVlc
         bR28zmCbRpa2q716130N2Xmf9FG8mMFnufjlCX4AwGz0Ss14SzuTBl/Xs6o+r0Z6oGQj
         KIpAzeJDTPysPB3VEOrJNBfJpjM/YgWkJylj57r/kpb8HelKhi9OC5ygnxcwar37MiDy
         M3+fjb8ssv445nOwDhr7BjdW3HuBcf/9mY/AoJdKBkB9k1EonGv//sDQBxw9oKhZMT04
         881Q==
X-Gm-Message-State: AOAM532x74du4pvRaO8XzZgweQH8yAFQXE8B5TkDTuFExTOUwke843wZ
        YHCpm/rUAZ2N+bKRi43zkoCx/aHDXcs=
X-Google-Smtp-Source: ABdhPJzOspTFgMmR1mzyaEVduhSBnPVR7AfRzzq5FKQgL7bjIp6W+C4fQYsut5QRFqDdmGKoP2Krug==
X-Received: by 2002:a17:90a:fe14:b0:1c3:4c3:3148 with SMTP id ck20-20020a17090afe1400b001c304c33148mr4822142pjb.51.1647518433298;
        Thu, 17 Mar 2022 05:00:33 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00218600b004f65315bb37sm7119385pfi.13.2022.03.17.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:33 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 07/15] bpf: Prevent escaping of kptr loaded from maps
Date:   Thu, 17 Mar 2022 17:29:49 +0530
Message-Id: <20220317115957.3193097-8-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5853; h=from:subject; bh=W7weng3wgd2EWIyYcrfcFOy/TDa2nur6ENjXQAwFpLQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKjwJEr3E5YPj+z0rDexrU6MKgDsPAbL0KImk+A hKILgyGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiowAKCRBM4MiGSL8RykMJEA CNNi2YT7qpC6x94cI3L9v7y6rkEvR4D5pVx2jKQeJnnD/5MeiCHxFJ7rlV5mH4Awd5XrlM6YnGFBYl wwDl0JJfMLyHEXcoRVPWfYzkGrviZCUy59nw2ORT4SwyugY6XN4sg5wHH2cVzbXIwiJnAIiPK9j3R0 c0dpaa5EKlT6ycQVgWS1KPZxG2BbpT+nI1pRr1PBL8jqEUf7+mq7JtAv+lI7nNfcbez8RtzYOAckNg R/wsDh/aeH5pmwdt1caJzMyOkTGQezkDe+qfZY5um1S+aAd4SC66zn4gNeJeJttPWlIINH5fS3u0dj iuFMviKkoQwRIO+eeSL02BP4+w50vDavnnbIuUV8nS+WSwSqiBw/2ugHODW1CvqCVKpCkEP0vW3Phv pONjZGul42NbzExqlZBWEvnTEyD+swhTMcVpIIgmLgpvblUKVbFoEdWjzE19nsNFMxbvuSQPc8Fp7h q/RfDp8AHrRTWvrDw/CINHMRncZbAwXROeDNe1I6VvRFUPqCMnJuofuQhnZG63ow8fAuOeJiUuhYAr 1ytAfaORetj4nAeqkUiQhkV0w0fUctPadC8qaahEYmTzWhA3J/Htf4sCl0SwhyW3fbV8eZSXBIEqE8 N23SmA4X9nd5r5VdtNenFhISrcUWTHCIYgQ9RROBTh6+FH5cKS2YdjDXoGng==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While we can guarantee that even for unreferenced kptr, the object
pointer points to being freed etc. can be handled by the verifier's
exception handling (normal load patching to PROBE_MEM loads), we still
cannot allow the user to pass these pointers to BPF helpers and kfunc,
because the same exception handling won't be done for accesses inside
the kernel. The same is true if a referenced pointer is loaded using
normal load instruction. Since the reference is not guaranteed to be
held while the pointer is used, it must be marked as untrusted.

Hence introduce a new type flag, PTR_UNTRUSTED, which is used to mark
all registers loading unreferenced and referenced kptr from BPF maps,
and ensure they can never escape the BPF program and into the kernel by
way of calling stable/unstable helpers.

In check_ptr_to_btf_access, the !type_may_be_null check to reject type
flags is still correct, as apart from PTR_MAYBE_NULL, only MEM_USER,
MEM_PERCPU, and PTR_UNTRUSTED may be set for PTR_TO_BTF_ID. The first
two are checked inside the function and rejected using a proper error
message, but we still want to allow dereference of untrusted case.

Also, we make sure to inherit PTR_UNTRUSTED when chain of pointers are
walked, so that this flag is never dropped once it has been set on a
PTR_TO_BTF_ID (i.e. trusted to untrusted transition can only be in one
direction).

In convert_ctx_accesses, extend the switch case to consider untrusted
PTR_TO_BTF_ID in addition to normal PTR_TO_BTF_ID for PROBE_MEM
conversion for BPF_LDX.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   | 10 +++++++++-
 kernel/bpf/verifier.c | 29 +++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 989f47334215..8ac3070aa5e6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -371,7 +371,15 @@ enum bpf_type_flag {
 	 */
 	MEM_PERCPU		= BIT(4 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_PERCPU,
+	/* PTR is not trusted. This is only used with PTR_TO_BTF_ID, to mark
+	 * unreferenced and referenced kptr loaded from map value using a load
+	 * instruction, so that they can only be dereferenced but not escape the
+	 * BPF program into the kernel (i.e. cannot be passed as arguments to
+	 * kfunc or bpf helpers).
+	 */
+	PTR_UNTRUSTED		= BIT(5 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= PTR_UNTRUSTED,
 };
 
 /* Max number of base types. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5325cc37797a..1130a74ad864 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -579,6 +579,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		strncpy(prefix, "user_", 32);
 	if (type & MEM_PERCPU)
 		strncpy(prefix, "percpu_", 32);
+	if (type & PTR_UNTRUSTED)
+		strncpy(prefix, "untrusted_", 32);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -3529,10 +3531,16 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 		if (reg->type != (PTR_TO_BTF_ID | MEM_PERCPU) &&
 		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_PERCPU))
 			goto bad_type;
-	} else { /* referenced and unreferenced case */
+	} else if (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF) {
 		if (reg->type != PTR_TO_BTF_ID &&
 		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL))
 			goto bad_type;
+	} else { /* only unreferenced case accepts untrusted pointers */
+		if (reg->type != PTR_TO_BTF_ID &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL) &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_UNTRUSTED) &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_UNTRUSTED))
+			goto bad_type;
 	}
 
 	if (!btf_is_kernel(reg->btf)) {
@@ -3622,18 +3630,20 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	ref_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_REF;
 	percpu_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU;
 	user_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_USER;
+
 	if (percpu_ptr)
 		reg_flags |= MEM_PERCPU;
 	else if (user_ptr)
 		reg_flags |= MEM_USER;
+	else
+		reg_flags |= PTR_UNTRUSTED;
 
 	if (insn_class == BPF_LDX) {
 		if (WARN_ON_ONCE(value_regno < 0))
 			return -EFAULT;
-		if (ref_ptr) {
-			verbose(env, "accessing referenced kptr disallowed\n");
-			return -EACCES;
-		}
+		/* We allow loading referenced kptr, since it will be marked as
+		 * untrusted, similar to unreferenced kptr.
+		 */
 		val_reg = reg_state(env, value_regno);
 		/* We can simply mark the value_regno receiving the pointer
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
@@ -4414,6 +4424,12 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
+	/* If this is an untrusted pointer, all pointers formed by walking it
+	 * also inherit the untrusted flag.
+	 */
+	if (type_flag(reg->type) & PTR_UNTRUSTED)
+		flag |= PTR_UNTRUSTED;
+
 	if (atype == BPF_READ && value_regno >= 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 
@@ -13109,7 +13125,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		if (!ctx_access)
 			continue;
 
-		switch (env->insn_aux_data[i + delta].ptr_type) {
+		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
 		case PTR_TO_CTX:
 			if (!ops->convert_ctx_access)
 				continue;
@@ -13126,6 +13142,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
 			break;
 		case PTR_TO_BTF_ID:
+		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
-- 
2.35.1


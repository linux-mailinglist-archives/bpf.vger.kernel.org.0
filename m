Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0E24FA679
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbiDIJfX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJfX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE726F7
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f10so9930167plr.6
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UadNUW914ouE7xsVF1EEIHllnCOL8a/PjurGZE8kR0c=;
        b=Arf9awg3PNt6S/oeRzXzTnYAXmx8qR8EYl6gDElGNmHK/7wEmRY2alTirtjfrP0FZ3
         2LTGy+Dj89S95NWuqv7ba4I6i6gwBevIsohLfKH07XcudPfu+cK/XMXJQT1vActWeaP7
         y3lpr13+rYB3YE/0bQNQAs+MX7BMVzz3Jj9E3khp2KPCgwEhXcj1PfzBQAvwyfcUenAh
         QUgHiPZtQ8F3uWBl+eWxgq/DiX4wtOL0V/EmpGj6Ea90zzDSsgUGrVDwGSApHJlXogOY
         VToQIwCUiPAHRQ1bNr0p4MwIx143/yk5PsqSv55leDYDI6cTAG8I12kl3cI8vn91D2Zz
         qIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UadNUW914ouE7xsVF1EEIHllnCOL8a/PjurGZE8kR0c=;
        b=1CT22gGKKdhXANjo5TVpJDty0LQZpiyfiW+MREJdk2vgW1jFtxKJOsPQZUa3KWwVYo
         PRpuNHHn2f8RKtPPDE045I3cO+sbOU6Q7MrIFXwDsGaUMF6MECdU4IIYPU92rGVfOUCK
         S8acS4bOAaQTLjLKGwGcMfxtZMTlFaBU6abVfHT0wHIJbB9QECdNevTzNd6QPhFLOrmc
         Uf+mv2XJkUY31Yh6TRqStABsJdqLuu0CBbP3SZJgfOrm8mUuPWJ7NwX99gmoewIdAqhZ
         kpj342C4rugzucTfZNu4rmDqGfpvYWoCUWgpmu8aaaJGpNCQRiHQ+onyTU772uh8X8aa
         zT3A==
X-Gm-Message-State: AOAM5333OlIIYTZWD6+gVZpZvkpCf281GHmw36nxRHRTEr0kiuH00WVM
        haXEr1gHLdAzHZ4weQ+NNcyaq7B3VPA=
X-Google-Smtp-Source: ABdhPJywEJouFFDkvp15H/l2WmZSL46uL0p8P5U9xL7iO9Pcc4eQXdrt/KNl8/yWEW4qGAM8lpLjGw==
X-Received: by 2002:a17:90a:d3d4:b0:1ca:c492:9a92 with SMTP id d20-20020a17090ad3d400b001cac4929a92mr25750917pjw.115.1649496796139;
        Sat, 09 Apr 2022 02:33:16 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id n19-20020a62e513000000b005048eef5827sm9609002pff.142.2022.04.09.02.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:15 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 06/13] bpf: Prevent escaping of kptr loaded from maps
Date:   Sat,  9 Apr 2022 15:02:56 +0530
Message-Id: <20220409093303.499196-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6442; h=from:subject; bh=paulW85uS2jEy0qBuKBQgjpwace8rSKDScFTZj2DdZY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0KfYNKug0rizSf9rhOb3CTrTHVUM8sxOZUPV9 RZHbkHOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8RyqfLEA CSvdF4DfydpEaBvrm6Pg4PWQDqtcRUt7t6aBDlsxmgf8yc5Hsm/IsiuUMQzaZdyQuZbLkLNmTXZ2UF 9iSIJMYftrAMZrDzfgAT7WnTj2lvlmVi/GiEATx1keIH5jLwy8smxp8t/RSMks8urDdHS0GnAWCaPa xjwXbCFMK+qfu/G9ncXu9RsO+3ryvOfqSOwZJYopHHouJl0rCB9gdHOSRPjGEYTfzzBWV+b6C1GIB0 2Z4U+7TRY5RHo8co5+R3eMrvheY6NOgyOa06zHDDmxHZJrlwywHpxI3zOhbM28q3z5tnjzRcnl+Iy1 +FfjeRgusnrDVlGbDKCr6XGOyzXJh5Jn0ZZrdE2KzIp0TlwQjiyGgJmY1IfZ184yosH6Ac3ovDJj5p 09gUNACTvQ4rOJ/ZhzJJjt9CqAwANbkRQOygn+LHqcYzKs3l6vuuwY7Q5I1PtHmzyAqPSpAW4qbXYQ KQWRuf+2tgye2LTkMrL3U76noeQy/fhhAjuXY6LTPlOv4d2v8Xq0+cFo6nS1MSewbW6Q5zidStClNk 3R6D2wTQ2ccU/GJHKOTAH8/t+AhSjC1yUQ9u3Ae9JfZiU/XETadZX3TwyUt/WAq3eXd2AhF8/K7UTP woyN2PzL5AHmEZxyMz5Dc3235E3AtmEhwIXCr/McdGyqf6f9XN85obXDtDXg==
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
 kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bd682c29883a..e9791ecafa5d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -372,7 +372,15 @@ enum bpf_type_flag {
 	/* Indicates that the pointer argument will be released. */
 	PTR_RELEASE		= BIT(5 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= PTR_RELEASE,
+	/* PTR is not trusted. This is only used with PTR_TO_BTF_ID, to mark
+	 * unreferenced and referenced kptr loaded from map value using a load
+	 * instruction, so that they can only be dereferenced but not escape the
+	 * BPF program into the kernel (i.e. cannot be passed as arguments to
+	 * kfunc or bpf helpers).
+	 */
+	PTR_UNTRUSTED		= BIT(6 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= PTR_UNTRUSTED,
 };
 
 /* Max number of base types. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 92efe6c3999c..c6cc4180ae45 100644
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
@@ -3516,9 +3518,14 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, u32 regno)
 {
 	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
+	int perm_flags = PTR_MAYBE_NULL;
 	const char *reg_name = "";
 
-	if (base_type(reg->type) != PTR_TO_BTF_ID || type_flag(reg->type) != PTR_MAYBE_NULL)
+	/* Only unreferenced case accepts untrusted pointers */
+	if (!off_desc->flags)
+		perm_flags |= PTR_UNTRUSTED;
+
+	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
 		goto bad_type;
 
 	if (!btf_is_kernel(reg->btf)) {
@@ -3544,7 +3551,12 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 bad_type:
 	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
 		reg_type_str(env, reg->type), reg_name);
-	verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	verbose(env, "expected=%s%s", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	if (!off_desc->flags)
+		verbose(env, " or %s%s\n", reg_type_str(env, PTR_TO_BTF_ID | PTR_UNTRUSTED),
+			targ_name);
+	else
+		verbose(env, "\n");
 	return -EINVAL;
 }
 
@@ -3566,9 +3578,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	if (BPF_MODE(insn->code) != BPF_MEM)
 		goto end;
 
-	/* We cannot directly access kptr_ref */
-	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF) {
-		verbose(env, "accessing referenced kptr disallowed\n");
+	/* We only allow loading referenced kptr, since it will be marked as
+	 * untrusted, similar to unreferenced kptr.
+	 */
+	if (class != BPF_LDX && (off_desc->flags & BPF_MAP_VALUE_OFF_F_REF)) {
+		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
 
@@ -3578,7 +3592,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->btf,
-				off_desc->btf_id, PTR_MAYBE_NULL);
+				off_desc->btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
 		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
@@ -4343,6 +4357,12 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
 
@@ -13078,7 +13098,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		if (!ctx_access)
 			continue;
 
-		switch (env->insn_aux_data[i + delta].ptr_type) {
+		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
 		case PTR_TO_CTX:
 			if (!ops->convert_ctx_access)
 				continue;
@@ -13095,6 +13115,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
 			break;
 		case PTR_TO_BTF_ID:
+		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
-- 
2.35.1


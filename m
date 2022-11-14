Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F58628908
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiKNTQ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiKNTQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:20 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392B275DC
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:16 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so14733288pjk.2
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvd8qgc4ej2kNh64oFLXyThd9oPpY3rKbUoisAxMSCs=;
        b=EZctqYZUV35xaI2bdjqTpRfNxVzF4WPvxCCY7ze8y4T2sksjbLFNHxfg6dcn6RfTQ6
         tBRPOfSC+Y54G+BbWk06oGCg8idh5BiH9eoNz7sdVBTNCCh2Snh8eYWo0y4iRUKVIP5n
         Nxu20+wBKw+maVPjAvUEIjV9MNMp9g/zvD9Owwr8ShsDwlISRJTqR/CaLYk3BWNMqEwX
         O1lc4DLfcKyqmjnTRPJf9G+Eg3NpVSMtYX1rmZFbWQ2CEWGG8mOI7AlarrdDBY9xmIn6
         d1gy8HEulHWIkVE7GIWri3RmoLIty4xL4m8qSXNx8q8PfYRlgACpgZnsoAA1EmzgUzhl
         aE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvd8qgc4ej2kNh64oFLXyThd9oPpY3rKbUoisAxMSCs=;
        b=4+ytCyLuno3xBozPfWGG4CfLmMIPXM2dqVg5buss4U/8kQkZLyzqzOSomRp5hp2eZG
         7y9YPvtpahg1uHF4PHusAFRFtL6gjmFe+qJNP3waZC91vcPEbeTBtTD1AawR3MCwCqJz
         +0ZX5aPxgs1g8YAsI0XOZ+X0apWiUsjNKijnJCdzfLUI1iNg4E5aYle4OewpFKDoxGPY
         Xs9hP/1V+iso4+ndtaLft/lVUEhWVYlsom1ppLmVhQLM2vfnhl1aeNVGYtdJtrPLqLal
         vjHPz1EOcnNrEhxnVFlq3TTxTq7+9d8DlckVTTt50DAblKx803NxqUTN+2eT7cr7Exhp
         drag==
X-Gm-Message-State: ANoB5pliuq12ZE/9NSQsb2NB2vpfNNRGCsHn9mBa0HX+NGixRvmYMf7x
        LxnVPG38neJmWvAzoXwr/ScJM1dufY6geA==
X-Google-Smtp-Source: AA0mqf5BgU/qx54NNYHgvSaBWOfxOzhKGHhofBXFOzh/2NQvfczt5c2AW2EO5UUoGzjAB1mIsXK1lw==
X-Received: by 2002:a17:902:8686:b0:186:a97d:6bcc with SMTP id g6-20020a170902868600b00186a97d6bccmr602412plo.121.1668453376251;
        Mon, 14 Nov 2022 11:16:16 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b0018157b415dbsm7904687plb.63.2022.11.14.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 08/26] bpf: Introduce allocated objects support
Date:   Tue, 15 Nov 2022 00:45:29 +0530
Message-Id: <20221114191547.1694267-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4871; i=memxor@gmail.com; h=from:subject; bh=2bRFzWQZD+aRTzydvT9JdLEXlBlGePU3cnRGLh5a31Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPIBHPCFUoG4d+/0JATJLRbv4bgzO8EFPfe7HMg nO5SCASJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyAAKCRBM4MiGSL8RyjhlD/ 4uqbeQasVpRzlUXZKoiEkKqwZZwsUrwz9WTGnSTmEXPmlvP4EGot/KdnnxTBGOoZGxA5MgG+9uTMYi NvIdRipVumgDl/f/9vkoE5kyjsQ1qEDJUw3Gy2AK4eIFuEGTicx5QCc1xaUbK2KKYjedbvxw2HD50j DGl6rhpa8/1GaJTABH4c6sKB40Wv7xJlaEQflkkvfvv81g9/e2P3SPTxW8gKSeCPHxXvZrsq8Hrguu eDNCFm4izGa8DzFs1zeTdOlxv/ZU834dVOzEoVYG5thcOXX3zX5jUDMiBBGin2SBOQ1kWTSzhffXHy sxCx7mxIo/hEjQkrGR3rIi1VMgO0K7euH1WQ2Xj+qHy/SB1Lm+Fe5vjv0Z/E9PJj1OMpGnFMaqqGCh mxZteeR3B1GWitg8iVIWNOEZohylGeua7pxyQrvvWCnSs2QY/fiDw5JfBvU6r7oGcJJA5tgbHN+CmB 5fScQxiDcU1dOzif3pgB7o/2ltzORxrRed+ZhWMw4Xi2+bavqBu0BEU4WSHOioUFIvyRoSZG6JqlNj b8hDe4IfSMeBoDxoJVIBKcXwqyYzPn9eJLhq2UMAMgPNF5fC60oTP4eLS+SsYfyeKoXglCX/QjoMO4 /DM9ddyIQwldyqiQp2Sso20h88ZudQ1GBNlycfKbrixl6XeozV1n8e0dpQZA==
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

Introduce support for representing pointers to objects allocated by the
BPF program, i.e. PTR_TO_BTF_ID that point to a type in program BTF.
This is indicated by the presence of MEM_ALLOC type flag in reg->type to
avoid having to check btf_is_kernel when trying to match argument types
in helpers.

Whenever walking such types, any pointers being walked will always yield
a SCALAR instead of pointer. In the future we might permit kptr inside
such allocated objects (either kernel or local), and it will then form a
PTR_TO_BTF_ID of the respective type.

For now, such allocated objects will always be referenced in verifier
context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
to such objects, as long fields that are special are not touched
(support for which will be added in subsequent patches). Note that once
such a pointer is marked PTR_UNTRUSTED, it is no longer allowed to write
to it.

No PROBE_MEM handling is therefore done for loads into this type unless
PTR_UNTRUSTED is part of the register type, since they can never be in
an undefined state, and their lifetime will always be valid.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   | 11 +++++++++++
 kernel/bpf/btf.c      |  5 +++++
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 49f9d2bec401..3cab113b149e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -524,6 +524,11 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is of a an allocated object of type from program BTF. This is
+	 * used to tag PTR_TO_BTF_ID allocated using bpf_obj_new.
+	 */
+	MEM_ALLOC		= BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -2791,4 +2796,10 @@ struct bpf_key {
 	bool has_ref;
 };
 #endif /* CONFIG_KEYS */
+
+static inline bool type_is_alloc(u32 type)
+{
+	return type & MEM_ALLOC;
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 875355ff3718..9a596f430558 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6034,6 +6034,11 @@ int btf_struct_access(struct bpf_verifier_log *log,
 
 		switch (err) {
 		case WALK_PTR:
+			/* For local types, the destination register cannot
+			 * become a pointer again.
+			 */
+			if (type_is_alloc(reg->type))
+				return SCALAR_VALUE;
 			/* If we found the pointer or scalar on t+off,
 			 * we're done.
 			 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e74f460dfd0..d726d55622c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4687,14 +4687,27 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (env->ops->btf_struct_access) {
+	if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
+		if (!btf_is_kernel(reg->btf)) {
+			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
+			return -EFAULT;
+		}
 		ret = env->ops->btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
 	} else {
-		if (atype != BPF_READ) {
+		/* Writes are permitted with default btf_struct_access for local
+		 * kptrs (which always have ref_obj_id > 0), but not for
+		 * untrusted PTR_TO_BTF_ID | MEM_ALLOC.
+		 */
+		if (atype != BPF_READ && reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 			verbose(env, "only read is supported\n");
 			return -EACCES;
 		}
 
+		if (type_is_alloc(reg->type) && !reg->ref_obj_id) {
+			verbose(env, "verifier internal error: ref_obj_id for allocated object must be non-zero\n");
+			return -EFAULT;
+		}
+
 		ret = btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
 	}
 
@@ -5973,6 +5986,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | MEM_ALLOC:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
@@ -13659,6 +13673,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
+		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
+		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
+		 * any faults for loads into such types. BPF_WRITE is disallowed
+		 * for this case.
+		 */
+		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
-- 
2.38.1


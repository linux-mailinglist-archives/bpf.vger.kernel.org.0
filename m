Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407F562E1A0
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiKQQ0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiKQQ0X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:23 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D797C441
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:00 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id io19so2070634plb.8
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWEXkOCkwXXMGqCPYq1KccYYNIXFmgDqg+Pvxcs/nb0=;
        b=K3XM6StXg30BTtPAfiWC0GTDIAebVGeEWI0M8OGb+NAv0YgZMqCk/gpOro7BkrvKyf
         U0OFg8fsMHOje7K4PlGp2cLuRkaq59FwD/z02c8YuygTd10ztbvazMrxPm9NDQYhN1IW
         cpWZiAjJJc1wLYnlyvyuGZD9F9YdRu/I4K/q75Rd2Pk5BABj1dEJrdBuyl6g3ODldTjZ
         N0W1iUPI3318Gl1xjHSAhMzp+I1qwOXnDSsdmjhNUl1icFimaiM75q/fxS+hrVh4iqiZ
         Cyu5fdSmMa/dAnY940HCLaUvkEIHv7D3MzyFQVGcXoD9GuWY5BQyHuSd/o6pTlpfUrMq
         3Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWEXkOCkwXXMGqCPYq1KccYYNIXFmgDqg+Pvxcs/nb0=;
        b=MI9N7tpejJXhkL/ftQWdrZP1SRaXfR6UYBgcNMF/gtlIFiTeRRQsv5KabSIUum2Hbg
         1N2PSL/bwtsbkpRMVbb2/k1cS0bV7PAOTUkSa/1V90Kdb35CD4JfNQ4OTjBKJHPDtiqt
         haxj2wa7e56vlK3G4Qgps0cmaOYBTrzQCjlGm0ScPahUkvBw1d3D4mv9r/6Uf86FRQVJ
         QyB9nebgUbhdTpyK708B8Aa+WTaY/W3G0JNmemrM3J6MoBt9A0VdhG+N3KfwHuhqbwQD
         sHpkSJidTwnzRIEU1usKvMg0l3x9gGtmrygYyXkuCc/o3/3caeiOPaRBSMP3yCVcpIyZ
         P5UQ==
X-Gm-Message-State: ANoB5pl6c63n9WTg84ZuoopIDN5QujVaHm503JczHVYzVKvxFXFjeIxa
        Buog18gtdlaU5Gr4CrAuC7wnD0glTbQ=
X-Google-Smtp-Source: AA0mqf5zATWwnAsSk8GigNC5yrItIN9ZI98D95nKC1yf/S/n7jO/Jg0udee5KCKkeM6+NMHswV5z9Q==
X-Received: by 2002:a17:902:f10c:b0:176:d217:7e68 with SMTP id e12-20020a170902f10c00b00176d2177e68mr3441360plb.63.1668702300055;
        Thu, 17 Nov 2022 08:25:00 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id s184-20020a625ec1000000b0056ba7ce4d5asm1360283pfb.52.2022.11.17.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:24:59 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 05/22] bpf: Introduce allocated objects support
Date:   Thu, 17 Nov 2022 21:54:13 +0530
Message-Id: <20221117162430.1213770-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4893; i=memxor@gmail.com; h=from:subject; bh=CH78Zd/IJvjHgHBfOoFLama9Di30yIFuK7q41JG0EwY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7+vyj8qoLXn8SBnLP6GEcvcJHFXCZz8PQsm62f aOxmK1KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/gAKCRBM4MiGSL8RysjHD/ 429vc8a7oiiz4vlvJbcVv1xsY3wLTt1iBRzD8uMRS69pE34ENNzFHM2DrxfDRmsoOdw/FANUSm5qSJ i+kjSK6dat/G1JRTFRQC8yEgCSUI6gzfpD4j0n49n7x+9pG5wkrUVcjS7pvARojmn5+HUM/RJk4TQU Fa3rUIR8cVBBkb+HTlBcAxbaFbB/HuefsA64lcaHQXTjfKbI6kMwSkeZTqTvUAAU7oxDWh74oKNl+5 2eGLyHSaza34sQneGYTRviHkNLz+JhP6WCuXfjnmSWHGFlVvBuun+vBf2pnZHmAD1vx4pHHICczMo8 zJyZUJUalND4/rMsJdHPJCzdN3mUuYvEZzJZhE1RGcYf+rUo2tsnns0pPY4mc9OXmCzgpZUngFCDIY P8qn4/MXCQdzxexymWC4CBhz0/gFg0FIRoZo3EVf+eZpdN9RCi4545kX+Ml5wLiUzmrTTSRd5w3Xm6 jgXIkOUzVCf1U2YkscH7jztZgERz1b0rdQw+4PstO4y63Pid2nsNtJa54kN80DXFodRX3mKpZ8F6Y2 1AlezhU+iuUzDkwi7mDLv6KtWN1VGjAmNMBO6dASZCGLkBvHD9B4BP9naxAhPywRrUEc3yprUDI3Vo o/q6yIH3YJHMg4GzGAfelFSZ8ukORaiJ90J7KvG9w2ct1PPEo+muX5FPktmg==
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
such allocated objects (either kernel or program allocated), and it will
then form a PTR_TO_BTF_ID of the respective type.

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
index 54462dd28824..53c47c8c6230 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -524,6 +524,11 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* MEM is of an allocated object of type in program BTF. This is used to
+	 * tag PTR_TO_BTF_ID allocated using bpf_obj_new.
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
index 0312d9ce292f..49e08c1c2c61 100644
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
+		/* Writes are permitted with default btf_struct_access for
+		 * program allocated objects (which always have ref_obj_id > 0),
+		 * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
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
@@ -13690,6 +13704,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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


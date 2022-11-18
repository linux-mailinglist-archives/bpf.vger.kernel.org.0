Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7456762EB67
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbiKRB4k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbiKRB4g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:36 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF86373BBF
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:34 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b29so3508990pfp.13
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dEo1al8fIigkT4udLYOJzh2efBnOQsqXleDSugVnjg=;
        b=auqc8iPvMgSN245AgsrA7URQUnhYp7PxQwHeS8Vw8+5XwfV2Ee/P86TF5NlWkOKrif
         JnTzjJwrbNIAt+YzZ+K61yxF+ikbKZtVDUUDe2kepqZBzG21tOfQLMFo6pjlyIx2FVjJ
         dw1SQf8457teGSuX6aN29ZBNWMSBXghJXk6LiZqmLsREsp9jLbsahwh6d/19RHWuCfcX
         e7JhBzeMTTBTk6e1DDKTCVRDZhYaHVhJTRsd8vkPU1DPnj+GaYjxk3A5KCKV4rxCO+1N
         xJyj+Z9r29nLympYCTr9hQgJBGcTcyDnP9lbY/oYeNnRIkYHiWICMnxow7Gifd+vVzFi
         hIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dEo1al8fIigkT4udLYOJzh2efBnOQsqXleDSugVnjg=;
        b=eTf7VCTgIvJJzksqbskD5xy69mqbCZbKDIlPOy6D5o1ycZGAxfGOH1Lw+oUXZxD4xI
         EfRGbyECHqlwl3d0OGNPKBuAx3XxreEjm5FPH0CvoFBW0TPHf5tJdjBCxLu3KVHQES6d
         3kVNeFm1Qa1k8Ugfl61q9h5DCjnHMaavTyBVtnRgc8JtHckBXQq2ru/egaP4/Ys5gkCv
         YFfeqM/uD3/uHfhKWSGyim3Nr0vc1TYO0b4psE6m7p97Rk7mWxk8q7nXysAf/MfMOWft
         /Zt2MZ5sDeaZdhLHulEoC9b46x9dhYFmMblcEHTHmUqCcggNNU0TrtxKGF9UomBr+thX
         gTaQ==
X-Gm-Message-State: ANoB5pleQajr6FSyHEkLF8FRXl3i31YzBEYMsJELXLvUtXeYjyDxRPjb
        TwUm3bahi/G4OpWC46s0FTJGLLSDPaM=
X-Google-Smtp-Source: AA0mqf4JZGQdrSPsd7MRnR6S3wZqSwTVGKDnxPaL61gnIiyT5RFEfXcuUgvYcK2N96VKzkqHAXC7pw==
X-Received: by 2002:a63:1015:0:b0:470:5f22:1496 with SMTP id f21-20020a631015000000b004705f221496mr4489834pgl.585.1668736593989;
        Thu, 17 Nov 2022 17:56:33 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709027c9300b0017f9db0236asm2128406pll.82.2022.11.17.17.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:33 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 05/24] bpf: Introduce allocated objects support
Date:   Fri, 18 Nov 2022 07:25:55 +0530
Message-Id: <20221118015614.2013203-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4893; i=memxor@gmail.com; h=from:subject; bh=bHOSzfm0SbGE8NR+y0cBZt0ThH4SH0n2SmsrPhxvaV8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXOKMre9cC5HaqcRxm4o8C4RgWVPDo7F/cJZ0b4 oQX18jiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RyiLmD/ 48rIkjGbYBKaI8XqUgAofn9sYoF1cgC7ws2txwsgbu4EWOLZvzAv9b7N6woepejN1ZAWYlpuMUrXiR Tbn6oX9l3uicIamv6t4zvLiSPYz+qGxhwbqjjcdV9j3IxvkJnvvZzESp8CQvVkTvfrVI6QprPZsiou 7zyys7TuLrnUB8/wgJ6BYKC3LYfVvWEcoD/L8OudJ4IcCex4Rskf/UY0tdbFy+7CGBJmN4GhD8EvIY l83VC6WHebB8L2dK9/pki+cXDX8LXopaYW5wudb0rKlX8hQLZ2GAhagFC/OoHX0hNBiIRSHPelUYzw WI8G0xaRScMfS634IhEWeNoThIodRP0oXyTowLGeVmMImPjN5eo02lPUjpbm0Nb6edikAiEgTuz5rP LtpWOc+NoW6iRC4RgiyAt8yp2KAlRgEiQI6P9Dgg22K1lI6qoeSmPdVKOkr74QXiSv5J8i1ZQ1B8pt edlVXbEXwrg4NE3i9VckkDpr1AeoREc30s3WeTbp+w9+UPQRNoA5HINVwnL97V4pT8XuzCuuIjreaZ mdH9Ic4s7H7wyDCSDVoKwXR7EV2+wtdeEYUaxdX3ZAkZRCf/cz7ppMexhMv7DqgIR6vzP2JyJK/FRB eEIhZTfLLRcI/8JIKJUC5/yqq5QATfp5TSq/SY5Di1O4Uizg9TGzje4vhFeQ==
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
index e60a5c052473..7440c20c4192 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -525,6 +525,11 @@ enum bpf_type_flag {
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
@@ -2792,4 +2797,10 @@ struct bpf_key {
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


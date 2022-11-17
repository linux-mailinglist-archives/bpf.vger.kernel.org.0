Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D462062E8CA
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiKQWzj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiKQWzh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:55:37 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF862CE
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:36 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y10so1802528plp.3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dEo1al8fIigkT4udLYOJzh2efBnOQsqXleDSugVnjg=;
        b=dT4mH/aISJwAAmAGzhZjNFy4ouoCf63hy6duiDZCR1XlVHOFA2D6DmzE55dIBjyXBQ
         e4BvQKZ7t4z7kBMgO+B7ZKq7MA8TOmBXxE1korCsByO0YjA6y6mIG2+ELj1NMgCSZLsg
         d7W7UMT8wxkUKCVeZgZxJJSpcomEuwiBaatGO+Ek363x15JOvejuKT6AhUDoLuOi7jZ/
         hUo8e2oCAs8kMUmQcjEHjqdPGiDf4NFET8SA5ybklP/zyhsyb2acILhJ6BFGQQaRoKu6
         hqCIfexpTEKqI6E/oFPJPnElZATG37uY7wu/ojxQa/31n+wdz3q1ACSzHqf4j7ZaJgPH
         /gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dEo1al8fIigkT4udLYOJzh2efBnOQsqXleDSugVnjg=;
        b=ZM2u0jp+14pOqLqjdp4lH9Bth6Kpt/Ev8iZpqhF0Bnt806vGgMCJcxg/t8elZKkhv0
         5xu2MuaRYqi34b1dicjp8KhjtTp5ZXKxTP4qgh59D+FXmO0k3DgVH5udCr4lzEwOIYVe
         ke3YBpPKC2m97nszszzPcHDB3icq2WrVHN4eeN/kbVRTtODqUiCMaFoC4k055o/GdINg
         8Tbjc9yrsUHCO6n9AdmYrxuXNimu+2xGykTGskvak5FKoA2r7PK1Fp2Kf8w9zDvci8ic
         rlcGzHtlbkDfltryU92CLKLhh8LftQWkN9p5iGSmOWzLRboDvD9Av+rSTkV5r2WgAmjX
         4Qxw==
X-Gm-Message-State: ANoB5pm3wLvqdbf/yH3bw0mP9eOEocKdZouWIXb0tuEMUrb5w8g+ZYFA
        RWo0vh4V4JBumDX8/AMlfJ3Rj9HWwe0=
X-Google-Smtp-Source: AA0mqf7x/HMmU9y1c/0rMCouwiVCeyEOEvSUJ4MzFqNKn9UX0CreS5jwCy+/qRezEfB6K2f9BMMMAg==
X-Received: by 2002:a17:90a:5607:b0:218:7d9e:f8ed with SMTP id r7-20020a17090a560700b002187d9ef8edmr1998465pjf.160.1668725735753;
        Thu, 17 Nov 2022 14:55:35 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id g28-20020aa79f1c000000b0056da2bf607csm1624238pfr.214.2022.11.17.14.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:55:34 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 05/23] bpf: Introduce allocated objects support
Date:   Fri, 18 Nov 2022 04:24:52 +0530
Message-Id: <20221117225510.1676785-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4893; i=memxor@gmail.com; h=from:subject; bh=bHOSzfm0SbGE8NR+y0cBZt0ThH4SH0n2SmsrPhxvaV8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkbKMre9cC5HaqcRxm4o8C4RgWVPDo7F/cJZ0b4 oQX18jiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5GwAKCRBM4MiGSL8RysrzD/ 4j1CjfwmwzVoHfRmJAAtn3p22t2JFXytPdaEhT0957reUeOVTI8ezvXG65J+q90sV62QAk7TXxmsvn /ZubeevxUN/pdKRF3REgDNrWgegJuRalsvmtwtx5Gf/95oNnblOLxIfElRND/W3Jt4u63z9Isu3RJS zFUEDEkLOe9QUOUCfrCbZrrZNJ4yn5Hqr83EYbvrVlKlccaGCFBa+oFxSaTGh3u+tZn1PsxVKjPk2O yceXO4OuU4n0QENIjVD5bZUQcB55p8/DC/vDNKjH5w/DQT2Cg/Xf8RfOlH8ON6NsMX83TrM7/iU/Wj NKAJryv0+060X84UUgE821cJqL1mY9tuOtB+y/2UYlqeb14VtHhjCnhAvAebL4ILJvOyWMM3AzvcJ8 OKDfWGo6lfNSi1Ea4cDHuTMroYkBCJZJE1cW3G4aKtZWJl03bFfE/v6LSHEiYjcoTP74UNcwUqczOB CZICp3Vv4fyfMLwELzH3dHGRVxt7hNDyPnDYAhhaqFrlrFY7urcyZ8jT4N2W5J1CnZMDpDtLkVq1QO IhKeDqEuJJRju6wJFdiNx0ZVGecezVLYBYf1t3NPjL7FpYiuXtjnR+DPx4dhIClDcKgITkRwgOdqiC riglKinTgqDRO6NB2wJVay0Q8jgN5gsRPMFRsGdzO0ujlol91s75ZJwRiUJw==
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C26261FE
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiKKTdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiKKTdg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:36 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107712AD4
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:35 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id b62so5160882pgc.0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkCP4Dony/PsvTJnx7VXRtAY09Fp+elLOavyTVsL+mM=;
        b=O6EEv9Zn/QdYjXyJkambhe8De3lN2lBQmXNkhVlUtGVpGEPtGa0B42FatsfrrPub37
         wjD1aqT63Oo4uZxK8+f8Ic3Fw9IIMFsvyiE572gkpMqLhZlg299ERvbROPvVVoiqQcXK
         POi2I4yY6gntkzYN5+Pgbb+vTzBe6XecXro/jcsmCre3JLlU9s0lTvajslftKZ89Uu+d
         LnWStP6z3r3Ne/bfpDA3OqKYcE9oEsibotezHOUa3ZiTm3ZlYW6joIkN9XuuTFullnxM
         GdFbj9gkj7KwR/s74b8KMwfhds5997fuwLKuuCHeJafnqupgglL7KvKHDdbdy1CL7i33
         G1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkCP4Dony/PsvTJnx7VXRtAY09Fp+elLOavyTVsL+mM=;
        b=pgH3zfJgVI4i3DWUP1ehSssa/DlYu/lv7phNNmTsS0P/W8Z/HokjxPrfaIsslJXpto
         K3ZsggYB7NPqr/7+j3Qh7x7lw1YKYkI+mSAxLTH5MPk10OeeZKS2868QobWRKL7izuvP
         XHWjf0L3bIVVrpF+SetxZF1143iWGddFZA6h0CA3jk0YqPh+pY2bFO5Mt8eG+xhGCWCg
         ixYqvPdv466gmwwHj0FMSYWnaWTydtdPfjTEjYl7c9hXhZ7qG7z/fk05DmoTGDmB+AkM
         Lx6q2uqH9yQ0IfhK6mDDmfHBhHI0LaQD9Q0VXOJNkVdczADasa/cy9hzj83dSD4aj/gA
         tyOQ==
X-Gm-Message-State: ANoB5plwebz8lG8zWkxID6lSF/Z1o6QxqfT1sB7DdEJ4y75qUVYajBv5
        XUTUqX0i2cof/OKEyUSRm4kJ2UclK6mZFg==
X-Google-Smtp-Source: AA0mqf6jF0yHfS4VbGr42Dg87w+qb37XiIdNf3nmDXbtWnuF6xjenR+C9M2/J6v7TOfEdEXHoYn1uw==
X-Received: by 2002:a63:1665:0:b0:426:9c23:9f94 with SMTP id 37-20020a631665000000b004269c239f94mr2929036pgw.105.1668195214260;
        Fri, 11 Nov 2022 11:33:34 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b00172e19c5f8bsm2089877plg.168.2022.11.11.11.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:33 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 08/26] bpf: Introduce allocated objects support
Date:   Sat, 12 Nov 2022 01:02:06 +0530
Message-Id: <20221111193224.876706-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4871; i=memxor@gmail.com; h=from:subject; bh=meS7gQZTEGq/DUEJpmd9jyqWTUThhVE5S28cbBs7iUA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIo0xyMZd3AtlXePT7oI/kJPUEhIBQ1Tl7N1l1f t0tz1JaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKAAKCRBM4MiGSL8Ryk17EA CZIAsithALdp/QdbU9kHEYOH1EgKJlh4WqdQ5Wecvz4eFTDOcfFtnXwCFwOzWKvYIsDaTuOGu60yXO NR5aDUaxVmFOyuhU/XCX7yMHKXl1qg4f7e7D28C1nl0uPiYN4Y8hgMpdNpPybQEbKm1aLlrJWm8QaX H+7IIZwewP844hw+sd8adNWMsDP0wKcKBrXzotf/aX6u+Qdgqke1jazmZdoJ2JlMPHm1aR3lEhINAe OPiz6ulKw0AtYzLGzLsWl7u0qqqu120KCvkIj9VeVvL1LBh9xwKHYwBawiA+04mlvkBJ2SZUaPfY9n XdAQf23GfT1kIWJOz4+O/5adfe8FKFtJGOc2+oDb4tTP37Ona3z0XH+KfeAISvrO3HuStEvtvQegaH sFeDadm+KXpYO4sMhgdOUi92D/sYWwm1WBXl+ofKu9PI/3WHfgqQVdTdJcDd810Xyp2ywZNoqNkFSr kyn4PBEJC750ltQi4XGtqdSzXzMTyGkNkK6X1OjPQxbvfwGbaXngNF1hStspqPovOZwWIpUB0sbK4B HHa2+UFNUywdpFuh7cOn/CVrYtXpgha1CPxCo6LmuDex0JBsbdAf5HghwBC3oPluFWCkPPo/8LhtWA YYPWmJNa+J/SNByItwugDIdOUz9I5/JyFY+HPlsD4zR1oYDqv0X4swBakfeQ==
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
index bbbb0f27c7d1..5cf14c1391a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4682,14 +4682,27 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
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
 
@@ -5968,6 +5981,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | MEM_ALLOC:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
@@ -13650,6 +13664,13 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA55B4CDD44
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 20:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiCDTSH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 14:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiCDTSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 14:18:06 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3D230E49
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 11:17:09 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dbf52cc4b9so79191717b3.18
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 11:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EJCHN7+lWdL8WYCXAfrmjUR1COHaUhE3YyahfzOO8g4=;
        b=PBr9MMZ9ptlNQ20PjeIu5hZyLBUgYOlo0yZxVWmP7J7zM0upQpS0O2Un7EGSUOxrlw
         F1nKNyhldYOOsxG/g9fx7dYZ01FZDOmEJpKnPxIcLA6WkDFY6oCnVz7l2uOvWe/6sNYY
         OKnfJLLG59Y+/O40MS1zdrakSFAe0t3YeusHzKCynK27OH55lJWDld80FcuqcyQ7EFY/
         1gwyFynXU9izJQimV60Bq9cqTq74OJoTBWljFj+J3SEpyUmn5q38PP+NE/9vd7TBNFg+
         ddAgIPMyQH0nzSvGqWhubeDM7AcMshisqCAs7Ppgm8ZzSRw4F9Y10ofRdE2dZhLvOsH1
         GJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EJCHN7+lWdL8WYCXAfrmjUR1COHaUhE3YyahfzOO8g4=;
        b=hKXFcOrRW2zcDOZZVxki5tRSww856zQoCs4fqJJ7faNIjOzvTS6ZJ7EgVIdpna4oNK
         pU2iSAbB4AeCvbaKxyLmrQXEF8NHsTa58JBnGKXRNWAFQzKBUHYRSU5b7SILLxD3a1xj
         8K6L9+FSHgU+Fq2ZRa7w/v6uV6F84axAtBYg8C44L2js3DzytDnesuxH2VHLy8XqXZC7
         OzA0kuhA0zaan/dPt1FPNFq0ViE/2svIWE5hEEu04y1enr/6T+Ql3B6APgoI1aXal0Iy
         cc8pAAbdwrCVJp0O3fWufk4CrZ6pHzxRBrX7kBL2Fhsh0ejyEjbZ7oSgd94dWlbS1nUf
         OGyw==
X-Gm-Message-State: AOAM533N6JWrsY6BD0CEzpE6/W+O3HNsBGZbqLgeOyKLd4a/NvrxLJMH
        Ghicj8RsTD9LpMPuLoMqOfM+QcEc+5o=
X-Google-Smtp-Source: ABdhPJwO383XNlCHn38VXCdCnRrmvxaz64GBphzFH674uew3YXxRxdfaKxEnSWAwU2la9DXIidYxkeqMG1w=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:d204:6f81:5498:9251])
 (user=haoluo job=sendgmr) by 2002:a25:305:0:b0:628:b49a:29c4 with SMTP id
 5-20020a250305000000b00628b49a29c4mr11922962ybd.425.1646421428739; Fri, 04
 Mar 2022 11:17:08 -0800 (PST)
Date:   Fri,  4 Mar 2022 11:16:56 -0800
In-Reply-To: <20220304191657.981240-1-haoluo@google.com>
Message-Id: <20220304191657.981240-4-haoluo@google.com>
Mime-Version: 1.0
References: <20220304191657.981240-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH bpf-next v1 3/4] bpf: Reject programs that try to load
 __percpu memory.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, yhs@fb.com
Cc:     acme@kernel.org, KP Singh <kpsingh@kernel.org>,
        bpf@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the introduction of the btf_type_tag "percpu", we can add a
MEM_PERCPU to identify those pointers that point to percpu memory.
The ability of differetiating percpu pointers from regular memory
pointers have two benefits:

 1. It forbids unexpected use of percpu pointers, such as direct loads.
    In kernel, there are special functions used for accessing percpu
    memory. Directly loading percpu memory is meaningless. We already
    have BPF helpers like bpf_per_cpu_ptr() and bpf_this_cpu_ptr() that
    wrap the kernel percpu functions. So we can now convert percpu
    pointers into regular pointers in a safe way.

 2. Previously, bpf_per_cpu_ptr() and bpf_this_cpu_ptr() only work on
    PTR_TO_PERCPU_BTF_ID, a special reg_type which describes static
    percpu variables in kernel (we rely on pahole to encode them into
    vmlinux BTF). Now, since we can identify __percpu tagged pointers,
    we can also identify dynamically allocated percpu memory as well.
    It means we can use bpf_xxx_cpu_ptr() on dynamic percpu memory.
    This would be very convenient when accessing fields like
    "cgroup->rstat_cpu".

Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h   | 11 +++++++++--
 kernel/bpf/btf.c      |  8 +++++++-
 kernel/bpf/verifier.c | 24 ++++++++++++++----------
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f19abc59b6cd..88449fbbe063 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -334,7 +334,15 @@ enum bpf_type_flag {
 	/* MEM is in user address space. */
 	MEM_USER		= BIT(3 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_USER,
+	/* MEM is a percpu memory. MEM_PERCPU tags PTR_TO_BTF_ID. When tagged
+	 * with MEM_PERCPU, PTR_TO_BTF_ID _cannot_ be directly accessed. In
+	 * order to drop this tag, it must be passed into bpf_per_cpu_ptr()
+	 * or bpf_this_cpu_ptr(), which will return the pointer corresponding
+	 * to the specified cpu.
+	 */
+	MEM_PERCPU		= BIT(4 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= MEM_PERCPU,
 };
 
 /* Max number of base types. */
@@ -516,7 +524,6 @@ enum bpf_reg_type {
 	 */
 	PTR_TO_MEM,		 /* reg points to valid memory region */
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
-	PTR_TO_PERCPU_BTF_ID,	 /* reg points to a percpu kernel variable */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
 	__BPF_REG_TYPE_MAX,
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b472cf0c8fdb..f9f2218b27fe 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5057,6 +5057,8 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		tag_value = __btf_name_by_offset(btf, t->name_off);
 		if (strcmp(tag_value, "user") == 0)
 			info->reg_type |= MEM_USER;
+		if (strcmp(tag_value, "percpu") == 0)
+			info->reg_type |= MEM_PERCPU;
 	}
 
 	/* skip modifiers */
@@ -5285,12 +5287,16 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 				return -EACCES;
 			}
 
-			/* check __user tag */
+			/* check type tag */
 			t = btf_type_by_id(btf, mtype->type);
 			if (btf_type_is_type_tag(t)) {
 				tag_value = __btf_name_by_offset(btf, t->name_off);
+				/* check __user tag */
 				if (strcmp(tag_value, "user") == 0)
 					tmp_flag = MEM_USER;
+				/* check __percpu tag */
+				if (strcmp(tag_value, "percpu") == 0)
+					tmp_flag = MEM_PERCPU;
 			}
 
 			stype = btf_type_skip_modifiers(btf, mtype->type, &id);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d63b1f40e029..093e47360d6d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -554,7 +554,6 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		[PTR_TO_TP_BUFFER]	= "tp_buffer",
 		[PTR_TO_XDP_SOCK]	= "xdp_sock",
 		[PTR_TO_BTF_ID]		= "ptr_",
-		[PTR_TO_PERCPU_BTF_ID]	= "percpu_ptr_",
 		[PTR_TO_MEM]		= "mem",
 		[PTR_TO_BUF]		= "buf",
 		[PTR_TO_FUNC]		= "func",
@@ -562,8 +561,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 	};
 
 	if (type & PTR_MAYBE_NULL) {
-		if (base_type(type) == PTR_TO_BTF_ID ||
-		    base_type(type) == PTR_TO_PERCPU_BTF_ID)
+		if (base_type(type) == PTR_TO_BTF_ID)
 			strncpy(postfix, "or_null_", 16);
 		else
 			strncpy(postfix, "_or_null", 16);
@@ -575,6 +573,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		strncpy(prefix, "alloc_", 32);
 	if (type & MEM_USER)
 		strncpy(prefix, "user_", 32);
+	if (type & MEM_PERCPU)
+		strncpy(prefix, "percpu_", 32);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -697,8 +697,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 			const char *sep = "";
 
 			verbose(env, "%s", reg_type_str(env, t));
-			if (base_type(t) == PTR_TO_BTF_ID ||
-			    base_type(t) == PTR_TO_PERCPU_BTF_ID)
+			if (base_type(t) == PTR_TO_BTF_ID)
 				verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
 			verbose(env, "(");
 /*
@@ -2783,7 +2782,6 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	case PTR_TO_XDP_SOCK:
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BUF:
-	case PTR_TO_PERCPU_BTF_ID:
 	case PTR_TO_MEM:
 	case PTR_TO_FUNC:
 	case PTR_TO_MAP_KEY:
@@ -4197,6 +4195,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	if (reg->type & MEM_PERCPU) {
+		verbose(env,
+			"R%d is ptr_%s access percpu memory: off=%d\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access) {
 		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
 						  off, size, atype, &btf_id, &flag);
@@ -4803,7 +4808,7 @@ static int check_stack_range_initialized(
 		}
 
 		if (is_spilled_reg(&state->stack[spi]) &&
-		    state->stack[spi].spilled_ptr.type == PTR_TO_BTF_ID)
+		    base_type(state->stack[spi].spilled_ptr.type) == PTR_TO_BTF_ID)
 			goto mark;
 
 		if (is_spilled_reg(&state->stack[spi]) &&
@@ -5259,7 +5264,7 @@ static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | ME
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
-static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
+static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
@@ -9639,7 +9644,6 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			dst_reg->mem_size = aux->btf_var.mem_size;
 			break;
 		case PTR_TO_BTF_ID:
-		case PTR_TO_PERCPU_BTF_ID:
 			dst_reg->btf = aux->btf_var.btf;
 			dst_reg->btf_id = aux->btf_var.btf_id;
 			break;
@@ -11839,7 +11843,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	type = t->type;
 	t = btf_type_skip_modifiers(btf, type, NULL);
 	if (percpu) {
-		aux->btf_var.reg_type = PTR_TO_PERCPU_BTF_ID;
+		aux->btf_var.reg_type = PTR_TO_BTF_ID | MEM_PERCPU;
 		aux->btf_var.btf = btf;
 		aux->btf_var.btf_id = type;
 	} else if (!btf_type_is_struct(t)) {
-- 
2.35.1.616.g0bdcbb4464-goog


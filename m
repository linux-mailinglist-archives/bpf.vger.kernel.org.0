Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324D44DC55A
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiCQMBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiCQMBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:01:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D52179B13
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p17so4238465plo.9
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5HBrknq7vOB1mY1RMSFj97nJQN4PxhZmLhwNej4Y9A=;
        b=Gv76lyLIVcrdvRpn+z7LKd8pSpj+CyC4laaV6n2DSrFdpPNKaKJcickgLZeChkyiVk
         G/1vUZrzRqno1VwdWNS8DoI+5TLIwViix7PPUvQ4ngdu6zU1Y3x7loeRIn0Y1JgofW+E
         inmjRSUB/HtuHN0j3l6GR7ui0XNz9aNipj78lM5nBsOYW5DMjEi77ni9hHwvKKJOHt+C
         +8vlcjCcMl5mkYib75MHYCfSIajC0VqMFmI6D10VpmfPmZDBip4gSXHTXXFYEDBZy+pu
         pqBNamfM/CQDbX5rwrZAVNj7avRLVOjS4JQMZRj+7V1i8Z7wPQKpiRINe/wbSXRuH9sd
         h6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5HBrknq7vOB1mY1RMSFj97nJQN4PxhZmLhwNej4Y9A=;
        b=1SlOQxuMCk4eyQjIB/ihNTFD2BUdbfpC1qvpYDQhpmq7cKa37X8Uq6N8pYVi/K2kHV
         jCuJWVlhmTujqHVYvw9oIllsw0RDp2KQ7PlXCPhsAd76ncMnLNqSlOffVnjZhsDveIXM
         AnPS6xr1MWeEurB7+jvVRffJ2wCnEz0LbtTGE8bFNqfmaASSj736b/hqOTzgxlV+/AOz
         RR0H41ABzoS7p8XHY0iOMeV8uvQX0NWB9KqV6RtHwIknT0eaPL8d96BA9kCdflfMhcDK
         hNk7iduBUF2fXf1Tojhse2AxoV+o0AzoScMN3CbWwhWcH5LcE9TeM1F51wV3GD9FHOW1
         VcvQ==
X-Gm-Message-State: AOAM533uv8UeSTpdK4ej8lbcMlWvabfGMHEQYkv1emV47lDfpkkunzRQ
        UizL+JbaL8QJHsJzj1X1o5R8/yIAavo=
X-Google-Smtp-Source: ABdhPJxkSDS13xU4eXS7GjWL1Nrio2s6GyOa3X57DBUgi3RAkvRwnWmII9bacVTu6vVCS3i0p9AfgA==
X-Received: by 2002:a17:90a:d3d0:b0:1bb:f5b3:2fbf with SMTP id d16-20020a17090ad3d000b001bbf5b32fbfmr4911187pjw.87.1647518423383;
        Thu, 17 Mar 2022 05:00:23 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id m7-20020a056a00080700b004f6ff260c9dsm7143100pfk.154.2022.03.17.05.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:23 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 05/15] bpf: Allow storing percpu kptr in map
Date:   Thu, 17 Mar 2022 17:29:47 +0530
Message-Id: <20220317115957.3193097-6-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5393; h=from:subject; bh=iBpaf6jQ+4o41K9HhwOO9wcaLW6hDaC1KFWmC/TE64I=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKjXtJRhrrCmWlvtkVOcBOu8n+49lOPUL1vj7W0 3xLyUb6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiowAKCRBM4MiGSL8Rysd6D/ 0ZQodGm/Vvk+GgPbqbWpFIasV6Mw4jIL6ChV9NFnYxlvf2bCQGgemY8FyjPVdXksrfj9Yn96gh0PYb 3s2gQhjPk4u+ZL8G5boTH8tn6wimM3KzK9XYPDkQjLOQI83WBp+A2/OLIl1ejZGm7r3xjV/Q1K6ZW0 Nyv9nqRk5iWoaz+FvZMRHFQ91fYXTHgot71iGkNhNsvmCqNZm5+cwSsQ1d4vxNYVui0uMMcSEtbVmj 6g0pk4n7qEz2FNAH7wOsa+AgRxffDMaoLAxslMHfIt8k4BuXyPVPgtkmXaGoBWjH8RPWLXAK+WgbvU NdhmGNcaxVzMdHRMElo41cY7FRyjh4nHYw7Wf+bj/4Z3EmBZbkuB2xxZv70XY3gUwRhuVVypjZkSxX 2ErekQAlL+JV3sFK5Xyb0iC2LQgzEfB+k6hq93TIdS2bexSH5mZmzPocDUhzv35l7gpv9sZYbuUtlq 4hbotvP+xhBz6PS5gL1QpGpRi4OdtqbQU8B21D67RbuksxbZClVXQk4FBzWQwQ2pQ7v+xc9Gwkoupn pllvXVLCfT06fWE5Ce7mVC/O5I69g/3ZqbStKezKCpms0uKDfxtnBdl4FqyXvWlFXUPEWyDuNNq4gY gFRqUV83HvYnJ9ok7aosQ42WYsG6zyxLECS8bNUvz1qHU99J+YrZdmwvPznQ==
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

Make adjustments to the code to allow storing percpu PTR_TO_BTF_ID in a
map. Similar to 'kptr_ref' tag, a new 'kptr_percpu' allows tagging types
of pointers accepting stores of such register types. On load, verifier
marks destination register as having type PTR_TO_BTF_ID | MEM_PERCPU |
PTR_MAYBE_NULL.

Cc: Hao Luo <haoluo@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/btf.c      | 13 ++++++++++---
 kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 702aa882e4a3..433f5cb161cf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -161,7 +161,8 @@ enum {
 };
 
 enum {
-	BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
+	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
+	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),
 };
 
 struct bpf_map_value_off_desc {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7b4179667bf1..04d604931f59 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3197,7 +3197,7 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 			       u32 off, int sz, struct btf_field_info *info,
 			       int info_cnt, int idx)
 {
-	bool kptr_tag = false, kptr_ref_tag = false;
+	bool kptr_tag = false, kptr_ref_tag = false, kptr_percpu_tag = false;
 	int tags;
 
 	/* For PTR, sz is always == 8 */
@@ -3216,12 +3216,17 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 			if (kptr_ref_tag)
 				return -EEXIST;
 			kptr_ref_tag = true;
+		} else if (!strcmp("kptr_percpu", __btf_name_by_offset(btf, t->name_off))) {
+			/* repeated tag */
+			if (kptr_percpu_tag)
+				return -EEXIST;
+			kptr_percpu_tag = true;
 		}
 		/* Look for next tag */
 		t = btf_type_by_id(btf, t->type);
 	}
 
-	tags = kptr_tag + kptr_ref_tag;
+	tags = kptr_tag + kptr_ref_tag + kptr_percpu_tag;
 	if (!tags)
 		return BTF_FIELD_IGNORE;
 	else if (tags > 1)
@@ -3236,7 +3241,9 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 
 	if (idx >= info_cnt)
 		return -E2BIG;
-	if (kptr_ref_tag)
+	if (kptr_percpu_tag)
+		info[idx].flags = BPF_MAP_VALUE_OFF_F_PERCPU;
+	else if (kptr_ref_tag)
 		info[idx].flags = BPF_MAP_VALUE_OFF_F_REF;
 	else
 		info[idx].flags = 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f8738054aa52..cc8f7250e43e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3517,11 +3517,19 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       bool ref_ptr)
 {
 	const char *targ_name = kernel_type_name(off_desc->btf, off_desc->btf_id);
+	enum bpf_reg_type reg_type;
 	const char *reg_name = "";
 	bool fixed_off_ok = true;
 
-	if (reg->type != PTR_TO_BTF_ID && reg->type != PTR_TO_BTF_ID_OR_NULL)
-		goto bad_type;
+	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU) {
+		if (reg->type != (PTR_TO_BTF_ID | MEM_PERCPU) &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_PERCPU))
+			goto bad_type;
+	} else { /* referenced and unreferenced case */
+		if (reg->type != PTR_TO_BTF_ID &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL))
+			goto bad_type;
+	}
 
 	if (!btf_is_kernel(reg->btf)) {
 		verbose(env, "R%d must point to kernel BTF\n", regno);
@@ -3557,9 +3565,13 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 		goto bad_type;
 	return 0;
 bad_type:
+	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU)
+		reg_type = PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_PERCPU;
+	else
+		reg_type = PTR_TO_BTF_ID | PTR_MAYBE_NULL;
 	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
 		reg_type_str(env, reg->type), reg_name);
-	verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
+	verbose(env, "expected=%s%s\n", reg_type_str(env, reg_type), targ_name);
 	return -EINVAL;
 }
 
@@ -3572,10 +3584,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 {
 	struct bpf_reg_state *reg = reg_state(env, regno), *val_reg;
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
+	enum bpf_type_flag reg_flags = PTR_MAYBE_NULL;
+	bool ref_ptr = false, percpu_ptr = false;
 	struct bpf_map_value_off_desc *off_desc;
 	int insn_class = BPF_CLASS(insn->code);
 	struct bpf_map *map = reg->map_ptr;
-	bool ref_ptr = false;
 
 	/* Things we already checked for in check_map_access:
 	 *  - Reject cases where variable offset may touch BTF ID pointer
@@ -3601,6 +3614,9 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	}
 
 	ref_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_REF;
+	percpu_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU;
+	if (percpu_ptr)
+		reg_flags |= MEM_PERCPU;
 
 	if (insn_class == BPF_LDX) {
 		if (WARN_ON_ONCE(value_regno < 0))
@@ -3614,7 +3630,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
 		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->btf,
-				off_desc->btf_id, PTR_MAYBE_NULL);
+				off_desc->btf_id, reg_flags);
 		val_reg->id = ++env->id_gen;
 	} else if (insn_class == BPF_STX) {
 		if (WARN_ON_ONCE(value_regno < 0))
-- 
2.35.1


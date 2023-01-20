Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB80675DEB
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjATTZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjATTZ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:25:29 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83968CE73;
        Fri, 20 Jan 2023 11:25:25 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id t10so6785778vsr.3;
        Fri, 20 Jan 2023 11:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESy1fVVagaREWYuH9eDGpGhexrbo4+TLl3+9CSn0llE=;
        b=YYrZmFXzOQ4lcZZTMEyxAkYK6Mgep9nrtseIPeho/6qfxGM1aB0IfSBK6dVNqV9zek
         WrUO9mj+B6Mk/7E6us1pp+WiOrJCZ2WT4wszFbq8BBePWa0QKTrRvlf0dHcWMYhXucqx
         f6a7DlVXKCwY/9+x1B7MqJykl37qgg80Xq93X7DEvD5/2cRHkLSmv7ULnQsq28+6XKjY
         LG8ne3rmuC/lFtvje6QtgJgSiR5j+hWR9i67el16JJTro0wWNiU9bOcda75URx9YOJqA
         pmwZ4Q+6JVIUfh0k4Ys822HQNKEnH9FNfYbL2HE8HSO0oNeV4pSvZM1tfcI5wkcqoWvi
         s10w==
X-Gm-Message-State: AFqh2kpPtWHKYuLDVJen1vrX6Pvu4PZeZfEtADn7zwzijAGNmRfwtveP
        guOlgKnMbgps2j9BHtMutO/Uqk9qxgJkFzJN
X-Google-Smtp-Source: AMrXdXv2hrd6e5Ghj3T+ZpuuvCJJQ1txz5HFv3moNRZu9lybdo7h4PQvk+cDbtyhy5ZT/iTEddNT4Q==
X-Received: by 2002:a67:5e83:0:b0:3ce:e81e:323f with SMTP id s125-20020a675e83000000b003cee81e323fmr22488081vsb.18.1674242724200;
        Fri, 20 Jan 2023 11:25:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id g19-20020a05620a40d300b006cec8001bf4sm26890971qko.26.2023.01.20.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:25:23 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v2 1/9] bpf: Enable annotating trusted nested pointers
Date:   Fri, 20 Jan 2023 13:25:15 -0600
Message-Id: <20230120192523.3650503-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120192523.3650503-1-void@manifault.com>
References: <20230120192523.3650503-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In kfuncs, a "trusted" pointer is a pointer that the kfunc can assume is
safe, and which the verifier will allow to be passed to a
KF_TRUSTED_ARGS kfunc. Currently, a KF_TRUSTED_ARGS kfunc disallows any
pointer to be passed at a nonzero offset, but sometimes this is in fact
safe if the "nested" pointer's lifetime is inherited from its parent.
For example, the const cpumask_t *cpus_ptr field in a struct task_struct
will remain valid until the task itself is destroyed, and thus would
also be safe to pass to a KF_TRUSTED_ARGS kfunc.

While it would be conceptually simple to enable this by using BTF tags,
gcc unfortunately does not yet support this. In the interim, this patch
enables support for this by using a type-naming convention. A new
BTF_TYPE_SAFE_NESTED macro is defined in verifier.c which allows a
developer to specify the nested fields of a type which are considered
trusted if its parent is also trusted. The verifier is also updated to
account for this. A patch with selftests will be added in a follow-on
change, along with documentation for this feature.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h   |  4 +++
 kernel/bpf/btf.c      | 61 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++---
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ae7771c7d750..283e96e5b228 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2186,6 +2186,10 @@ struct bpf_core_ctx {
 	const struct btf *btf;
 };
 
+bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
+				const struct bpf_reg_state *reg,
+				int off);
+
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4ba749fcce9d..dd05b5f2c1d8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8227,3 +8227,64 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	}
 	return err;
 }
+
+bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
+				const struct bpf_reg_state *reg,
+				int off)
+{
+	struct btf *btf = reg->btf;
+	const struct btf_type *walk_type, *safe_type;
+	const char *tname;
+	char safe_tname[64];
+	long ret, safe_id;
+	const struct btf_member *member, *m_walk = NULL;
+	u32 i;
+	const char *walk_name;
+
+	walk_type = btf_type_by_id(btf, reg->btf_id);
+	if (!walk_type)
+		return false;
+
+	tname = btf_name_by_offset(btf, walk_type->name_off);
+
+	ret = snprintf(safe_tname, sizeof(safe_tname), "%s__safe_fields", tname);
+	if (ret < 0)
+		return false;
+
+	safe_id = btf_find_by_name_kind(btf, safe_tname, BTF_INFO_KIND(walk_type->info));
+	if (safe_id < 0)
+		return false;
+
+	safe_type = btf_type_by_id(btf, safe_id);
+	if (!safe_type)
+		return false;
+
+	for_each_member(i, walk_type, member) {
+		u32 moff;
+
+		/* We're looking for the PTR_TO_BTF_ID member in the struct
+		 * type we're walking which matches the specified offset.
+		 * Below, we'll iterate over the fields in the safe variant of
+		 * the struct and see if any of them has a matching type /
+		 * name.
+		 */
+		moff = __btf_member_bit_offset(walk_type, member) / 8;
+		if (off == moff) {
+			m_walk = member;
+			break;
+		}
+	}
+	if (m_walk == NULL)
+		return false;
+
+	walk_name = __btf_name_by_offset(btf, m_walk->name_off);
+	for_each_member(i, safe_type, member) {
+		const char *m_name = __btf_name_by_offset(btf, member->name_off);
+
+		/* If we match on both type and name, the field is considered trusted. */
+		if (m_walk->type == member->type && !strcmp(walk_name, m_name))
+			return true;
+	}
+
+	return false;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca7db2ce70b9..7f973847b58e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4755,6 +4755,25 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val)
 	return 0;
 }
 
+#define BTF_TYPE_SAFE_NESTED(__type)  __PASTE(__type, __safe_fields)
+
+BTF_TYPE_SAFE_NESTED(struct task_struct) {
+	const cpumask_t *cpus_ptr;
+};
+
+static bool nested_ptr_is_trusted(struct bpf_verifier_env *env,
+				  struct bpf_reg_state *reg,
+				  int off)
+{
+	/* If its parent is not trusted, it can't regain its trusted status. */
+	if (!is_trusted_reg(reg))
+		return false;
+
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_NESTED(struct task_struct));
+
+	return btf_nested_type_is_trusted(&env->log, reg, off);
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs,
 				   int regno, int off, int size,
@@ -4843,10 +4862,17 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (type_flag(reg->type) & PTR_UNTRUSTED)
 		flag |= PTR_UNTRUSTED;
 
-	/* By default any pointer obtained from walking a trusted pointer is
-	 * no longer trusted except the rcu case below.
+	/* By default any pointer obtained from walking a trusted pointer is no
+	 * longer trusted, unless the field being accessed has explicitly been
+	 * marked as inheriting its parent's state of trust.
+	 *
+	 * An RCU-protected pointer can also be deemed trusted if we are in an
+	 * RCU read region. This case is handled below.
 	 */
-	flag &= ~PTR_TRUSTED;
+	if (nested_ptr_is_trusted(env, reg, off))
+		flag |= PTR_TRUSTED;
+	else
+		flag &= ~PTR_TRUSTED;
 
 	if (flag & MEM_RCU) {
 		/* Mark value register as MEM_RCU only if it is protected by
-- 
2.39.0


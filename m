Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDEB6747AC
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 00:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjASX6v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 18:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjASX6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:49 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E66A25AB;
        Thu, 19 Jan 2023 15:58:36 -0800 (PST)
Received: by mail-qv1-f42.google.com with SMTP id d13so2699753qvj.8;
        Thu, 19 Jan 2023 15:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGgllfnamKoMB7NglMYoKPB7FJSqNfqPQ0lhd43zF6A=;
        b=Px8tLhsnAXMvQL3nNFKkfMLMaH5FCRCuOP1up2JWzr0XU22u0ZtzfsIz5K+mQqE8Ca
         sHb0Vs4ULVzJ5rXKQAY31+jLKY+rpikD7BYjFs6K1lUikpGqFLXc5hQkjFz9Zz/G2B2k
         0GlskyOycT/oFYDpza8CcIUPTHGhgB5JGpmu++NauB/UKv1f8/HeWRpy2FJITM0fM5eQ
         PXUYVj0gMWPwyrsaQnFCMpBmgkBplj4PFAEbxRLeAvMAqsOzgtQfQXaaL1lHmdDmUmeJ
         d7Dp98C6l015bvWBy0tBo1mgclzGDLsZqq9NnpYcBtcmWKXdmZhj7orLJS9M1/mOla3e
         YuAA==
X-Gm-Message-State: AFqh2kqoQbdlagZY92XiSKuBaTva6YgTrGaaM3tkafuLcIeSD2wMrNem
        138rA2HSF2sGKY+GgRyr1Vs4aytfoaYzEe8T
X-Google-Smtp-Source: AMrXdXtoWOGHcjX8V38cgTIt82cwCjuXRFbG6cpPzBjFu54VH2Jejv9JRh3icYkPRXGQoAYju1nycg==
X-Received: by 2002:a0c:aace:0:b0:535:5cd6:38a6 with SMTP id g14-20020a0caace000000b005355cd638a6mr2679941qvb.50.1674172714601;
        Thu, 19 Jan 2023 15:58:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a16aa00b006cfc9846594sm15573699qkj.93.2023.01.19.15.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:34 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 1/8] bpf: Enable annotating trusted nested pointers
Date:   Thu, 19 Jan 2023 17:58:26 -0600
Message-Id: <20230119235833.2948341-2-void@manifault.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235833.2948341-1-void@manifault.com>
References: <20230119235833.2948341-1-void@manifault.com>
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
 kernel/bpf/btf.c      | 64 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++--
 3 files changed, 96 insertions(+), 4 deletions(-)

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
index 4ba749fcce9d..fcd66edc22af 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -24,6 +24,7 @@
 #include <linux/perf_event.h>
 #include <linux/bsearch.h>
 #include <linux/kobject.h>
+#include <linux/stringify.h>
 #include <linux/sysfs.h>
 #include <net/sock.h>
 #include "../tools/lib/bpf/relo_core.h"
@@ -529,7 +530,7 @@ s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 	return -ENOENT;
 }
 
-static s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
+s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 {
 	struct btf *btf;
 	s32 ret;
@@ -8227,3 +8228,64 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
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


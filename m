Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8802A4706E3
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhLJRYP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 12:24:15 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38898 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhLJRYP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 12:24:15 -0500
Received: by mail-wr1-f44.google.com with SMTP id q3so16074902wru.5;
        Fri, 10 Dec 2021 09:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UPtpPyTcTLAr0Y+ki41sa9PpOJk2ubMA71yleCKj8eo=;
        b=IvK78siDabj3LU7VpE3kSD8HmSSHb0PEQA/jZHFnl8TpltlFf9ZzSL09PzwLYqvdI2
         S20OVZ023T8TgRLGvUJeZ1s+WhUP8b9iXaQT4VQLNn72PYRWGNe9amD3i2EOeueyV99R
         o2cQQyQctoxoc3J8yDUzJzW7ruAa10ap64vcysKSYQ1oGUrEKM8VoAd2XIbWAeFK3L8Q
         5+pUQbI55PGs2VoOae7LbYXwl4ejG8ZF5OrUpaYTfyiCmqKi9f7FIacIgdjaQdIqBFvj
         OoAfsJNtEqhRh8fOBOYi4rA3WZbYKxGSMJ2T3TCmrhrJPCfMaWqp2gAOFGkGeaUw4MQb
         68Nw==
X-Gm-Message-State: AOAM531944CEZZt+qdvbz7iDKPLZaQnP0L4CEA58fudXw+QsFC6TEgSH
        iahck2KEyyydwWmTx6fxn2cQ+BUXWJs=
X-Google-Smtp-Source: ABdhPJwvniM4NbshjHSpU/4i2Ga+N9Dud1w54XjdXS8aHUFEl384nnRfGo7ZVJ79sjn07pD4RMa1Tw==
X-Received: by 2002:adf:fed0:: with SMTP id q16mr16251740wrs.276.1639156838969;
        Fri, 10 Dec 2021 09:20:38 -0800 (PST)
Received: from t490s.fritz.box (host-95-251-171-173.retail.telecomitalia.it. [95.251.171.173])
        by smtp.gmail.com with ESMTPSA id q8sm2999656wrx.71.2021.12.10.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:20:38 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
Date:   Fri, 10 Dec 2021 18:20:34 +0100
Message-Id: <20211210172034.13614-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

In userspace, bpf_core_types_are_compat() is a recursive function which
can't be put in the kernel as is.
Limit the recursion depth to 2, to avoid potential stack overflows
in kernel.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 include/linux/btf.h |   5 +++
 kernel/bpf/btf.c    | 107 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index acef6ef28768..03162ae04ace 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -300,6 +300,11 @@ static inline const struct btf_var_secinfo *btf_type_var_secinfo(
 	return (const struct btf_var_secinfo *)(t + 1);
 }
 
+static inline struct btf_param *btf_params(const struct btf_type *t)
+{
+	return (struct btf_param *)(t + 1);
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 struct bpf_prog;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 27b7de538697..dcbf127ad6d2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6418,10 +6418,115 @@ bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 DEFINE_KFUNC_BTF_ID_LIST(bpf_tcp_ca_kfunc_list);
 DEFINE_KFUNC_BTF_ID_LIST(prog_test_kfunc_list);
 
+#define MAX_TYPES_ARE_COMPAT_DEPTH 2
+
+static
+int __bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
+				const struct btf *targ_btf, __u32 targ_id,
+				int level)
+{
+	const struct btf_type *local_type, *targ_type;
+	int depth = 32; /* max recursion depth */
+
+	if (level <= 0)
+		return -EINVAL;
+
+	/* caller made sure that names match (ignoring flavor suffix) */
+	local_type = btf_type_by_id(local_btf, local_id);
+	targ_type = btf_type_by_id(targ_btf, targ_id);
+	if (btf_kind(local_type) != btf_kind(targ_type))
+		return 0;
+
+recur:
+	depth--;
+	if (depth < 0)
+		return -EINVAL;
+
+	local_type = btf_type_skip_modifiers(local_btf, local_id, &local_id);
+	targ_type = btf_type_skip_modifiers(targ_btf, targ_id, &targ_id);
+	if (!local_type || !targ_type)
+		return -EINVAL;
+
+	if (btf_kind(local_type) != btf_kind(targ_type))
+		return 0;
+
+	switch (btf_kind(local_type)) {
+	case BTF_KIND_UNKN:
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_FWD:
+		return 1;
+	case BTF_KIND_INT:
+		/* just reject deprecated bitfield-like integers; all other
+		 * integers are by default compatible between each other
+		 */
+		return btf_int_offset(local_type) == 0 && btf_int_offset(targ_type) == 0;
+	case BTF_KIND_PTR:
+		local_id = local_type->type;
+		targ_id = targ_type->type;
+		goto recur;
+	case BTF_KIND_ARRAY:
+		local_id = btf_array(local_type)->type;
+		targ_id = btf_array(targ_type)->type;
+		goto recur;
+	case BTF_KIND_FUNC_PROTO: {
+		struct btf_param *local_p = btf_params(local_type);
+		struct btf_param *targ_p = btf_params(targ_type);
+		__u16 local_vlen = btf_vlen(local_type);
+		__u16 targ_vlen = btf_vlen(targ_type);
+		int i, err;
+
+		if (local_vlen != targ_vlen)
+			return 0;
+
+		for (i = 0; i < local_vlen; i++, local_p++, targ_p++) {
+			btf_type_skip_modifiers(local_btf, local_p->type, &local_id);
+			btf_type_skip_modifiers(targ_btf, targ_p->type, &targ_id);
+			err = __bpf_core_types_are_compat(local_btf, local_id,
+							  targ_btf, targ_id,
+							  level - 1);
+			if (err <= 0)
+				return err;
+		}
+
+		/* tail recurse for return type check */
+		btf_type_skip_modifiers(local_btf, local_type->type, &local_id);
+		btf_type_skip_modifiers(targ_btf, targ_type->type, &targ_id);
+		goto recur;
+	}
+	default:
+		pr_warn("unexpected kind %s relocated, local [%d], target [%d]\n",
+			btf_type_str(local_type), local_id, targ_id);
+		return 0;
+	}
+}
+
+/* Check local and target types for compatibility. This check is used for
+ * type-based CO-RE relocations and follow slightly different rules than
+ * field-based relocations. This function assumes that root types were already
+ * checked for name match. Beyond that initial root-level name check, names
+ * are completely ignored. Compatibility rules are as follows:
+ *   - any two STRUCTs/UNIONs/FWDs/ENUMs/INTs are considered compatible, but
+ *     kind should match for local and target types (i.e., STRUCT is not
+ *     compatible with UNION);
+ *   - for ENUMs, the size is ignored;
+ *   - for INT, size and signedness are ignored;
+ *   - for ARRAY, dimensionality is ignored, element types are checked for
+ *     compatibility recursively;
+ *   - CONST/VOLATILE/RESTRICT modifiers are ignored;
+ *   - TYPEDEFs/PTRs are compatible if types they pointing to are compatible;
+ *   - FUNC_PROTOs are compatible if they have compatible signature: same
+ *     number of input args and compatible return and argument types.
+ * These rules are not set in stone and probably will be adjusted as we get
+ * more experience with using BPF CO-RE relocations.
+ */
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id)
 {
-	return -EOPNOTSUPP;
+	return __bpf_core_types_are_compat(local_btf, local_id,
+					   targ_btf, targ_id,
+					   MAX_TYPES_ARE_COMPAT_DEPTH);
 }
 
 static bool bpf_core_is_flavor_sep(const char *s)
-- 
2.33.1


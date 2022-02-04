Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138884A91C6
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 01:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356319AbiBDAzn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 19:55:43 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36840 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356309AbiBDAzm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 19:55:42 -0500
Received: by mail-wr1-f47.google.com with SMTP id u15so8338369wrt.3;
        Thu, 03 Feb 2022 16:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TX/t2a+cGE9g7yrB/Jazqo9Ut3nEa2N6/yICGhz19Yw=;
        b=VLr9l8UibQ6BSCriIHdeaDjAkkdEpRH9h8RzY3zuTgthcSUJF1d4JCsKTUqQmtvPKQ
         fpadWvm2Uj6fUpPESZ/M41BMgs648ehWcD4sVwcXR8w99l7eDeb5Hx1qszg6OTlG2AFR
         NlVW4PSB45WZEG2OiM8FNwVU4Qqv/wcwCf1+OV1Fs8cT19MYZkqNdOWeBKuLJi53V3sn
         F0bpedhvmP77MezmRWaW7aw9IPI2Bp4tXapbzmQI53YE8yIQCustRruK2gNpZcCW3dUx
         znhYRhJDT/gu6QL7jGzGEYUA9QiOBfADQ4ZqvlLV/4TWwJCz4qCbMkPPUCNfaId/qUcJ
         f8NA==
X-Gm-Message-State: AOAM531q9hDuu28stSgMsFDOzSHdFxU+RzLpIPKuKpeZhYnA+CZ2cGv6
        GxXgKvot2Br1RpJjMlMWCck=
X-Google-Smtp-Source: ABdhPJwkj9zsYhD2Ex5of+R59baxTDwRHh3dvxJPmjyY9H/2oZFsFAgGGDn7Z30SNsVUbRjPtvHtSQ==
X-Received: by 2002:adf:de0c:: with SMTP id b12mr398274wrm.26.1643936141499;
        Thu, 03 Feb 2022 16:55:41 -0800 (PST)
Received: from t490s.teknoraver.net (net-2-35-22-35.cust.vodafonedsl.it. [2.35.22.35])
        by smtp.gmail.com with ESMTPSA id c8sm240391wmq.34.2022.02.03.16.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:55:41 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf: limit bpf_core_types_are_compat() recursion
Date:   Fri,  4 Feb 2022 01:55:18 +0100
Message-Id: <20220204005519.60361-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204005519.60361-1-mcroce@linux.microsoft.com>
References: <20220204005519.60361-1-mcroce@linux.microsoft.com>
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
 kernel/bpf/btf.c    | 105 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f6c43dd513fa..36bc09b8e890 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -327,6 +327,11 @@ static inline const struct btf_var_secinfo *btf_type_var_secinfo(
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
index b983cee8d196..fcc3d9e45320 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6785,10 +6785,113 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 }
 EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
 
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
+			if (level <= 1)
+				return -EINVAL;
+
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
2.34.1


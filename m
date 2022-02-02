Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047CD4A7A13
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 22:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347432AbiBBVNf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 16:13:35 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39803 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347279AbiBBVNe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 16:13:34 -0500
Received: by mail-wr1-f45.google.com with SMTP id g18so586938wrb.6;
        Wed, 02 Feb 2022 13:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TX/t2a+cGE9g7yrB/Jazqo9Ut3nEa2N6/yICGhz19Yw=;
        b=zSTTes+Lhnhvvz0dvrBrbKrEPrAm4dAUL6iuuyEyQaNVrFj6Cxvwg5QAH5GzL9X8Ia
         ftsQ8uz+rhnB4rpvmuxw84Je3gFEnPS1LjknYCSxv4mzIcMIIYevwKsX6VnTruMruDgP
         wyiVMr+6KphTVNUkvIt1j22Z6lG1Onwvay+tSWS9vXUl37ganqlaScVABRsVn9sSoBXB
         CmMm0I2cly2WBA2xRLWuTZxFodRPQnqpIH7Fcp1LUPuCJzv0OjjXYwrJK2Oa54G1BFPK
         BbO6bpM/AFbcVJYG96AL+IIdzyoJOttULrVyIsdqepF9fRSZmRih9mA4+xYBQLG0VTtB
         NZeQ==
X-Gm-Message-State: AOAM532ZvH1j9Jmr+kx5EN0DmAJ3UpCBPvkjTtd1MMug61lgbRFI5rin
        tgOnmBw6f3N9cmpimLBdhbw=
X-Google-Smtp-Source: ABdhPJwWyyp9C/HTTv/2ef06uIXYUm2abe28sfLXjAK2AkXk7SUxbKBm6mxDkNaq7GwBmGIAfE5nMw==
X-Received: by 2002:a05:6000:3c1:: with SMTP id b1mr27148792wrg.14.1643836413364;
        Wed, 02 Feb 2022 13:13:33 -0800 (PST)
Received: from t490s.teknoraver.net (net-2-35-22-35.cust.vodafonedsl.it. [2.35.22.35])
        by smtp.gmail.com with ESMTPSA id f5sm13914322wry.64.2022.02.02.13.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:13:32 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: limit bpf_core_types_are_compat() recursion
Date:   Wed,  2 Feb 2022 22:13:27 +0100
Message-Id: <20220202211328.176481-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202211328.176481-1-mcroce@linux.microsoft.com>
References: <20220202211328.176481-1-mcroce@linux.microsoft.com>
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED362890D
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiKNTQc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbiKNTQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:23 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3026AEB
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:22 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so12968310pjh.1
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnt6anqQzqYDHqUQyjvXxXZhTpxeJ8+rhETmsNNiKKM=;
        b=bnWGTKMHx57Rx5R+RQWQw6ujZN08ia1ihTGT6IQVOBFTUXkm+1p6NBn3Xq+4DFX1l5
         jYLDhVOWcIk2SOHexS+yUcY74TXl8BlvyF5b7QPYXkU5Ou1pZyGCxr+n2UU6soTwHsmt
         brT8DuFUNl17ktulUPL2shtMFBTHUjVOg7tQBqFv9UVLCnkV0opspv9hZSe6OINgfwQs
         OYg4p6EBnZSs70PbTG7e/Lcse6T/x4qTjSI9bhNMLki1K/M+oHg8pF85pFBjR1MLHPgi
         jiyzC2QGEUvgJ4oOokCtTeDPx4SxRSYaOOaJIT2lGx+elxTnTkAd03oYoloFw06eZj2I
         4qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnt6anqQzqYDHqUQyjvXxXZhTpxeJ8+rhETmsNNiKKM=;
        b=4tKejnyQSGUTOOl/im72iMKhTU6u80Ue4zxNtHkP3m3/moNh3mn0/kS15T91FLlWII
         QFIe9Y3g58fDm9Ac8EvPrmYQ6TChKY+lG0X+VbMmvlebeDKta6f3648CY5QKJKuCL3Zj
         GIs6dUUtB8XmH627iMNfPTfuEnzyHAhuV/HlUBN133Yqn2/XaWItbUYkZX5l7GigSlCo
         lNB2AYVZR6n34t5g1rFDbEJLOkO0CA6Qk8GJsLmLUyB7kXfTGX2myQzxwgLiKKBNaorU
         KP6/puqDitgfax3Gp6VU/JiFdBvYr1syx4Dq+ISF0gbzwToc9IYD8+sT3p8pCOuyH3B7
         2P3Q==
X-Gm-Message-State: ANoB5pm3tDQy8rddDbEB2Fj39STrzNIfaQxMvFgzzsiE1glyls1BCnlg
        gKpzYb9wnrSFhVvYwHvE2KixA4QJEVcEyQ==
X-Google-Smtp-Source: AA0mqf4VHTBQ1rSXVV/SqPXkARPjpxFZ4F+eP3a6Cuf/7ZOYoe0GbdPLLrDFQBhJ0DW6jyvE7/Jozw==
X-Received: by 2002:a17:90a:c393:b0:213:8126:867c with SMTP id h19-20020a17090ac39300b002138126867cmr14795011pjt.183.1668453381940;
        Mon, 14 Nov 2022 11:16:21 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056babe4fb8asm6188777pfp.49.2022.11.14.11.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:21 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 10/26] bpf: Verify ownership relationships for user BTF types
Date:   Tue, 15 Nov 2022 00:45:31 +0530
Message-Id: <20221114191547.1694267-11-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5571; i=memxor@gmail.com; h=from:subject; bh=S5uXjiFY72vxSDVNadqIFQRVCO6rmBYigteqvunocwU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPI0f7fhq5upMc2hexjc+2pS5EY8TS1fdAcuPSL vlyKqQeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyAAKCRBM4MiGSL8RyivzD/ 0YdmvxCcyRaQQ0TV0x1g9ZNj+Hon4sTu2wbbhqQFTaiA1doQ8EATEe0N3TrE7mtLqSdqUsLnBvzY2/ VH4+7URhh3zN0KoN50YsfUq6SAWIdmvn8i4vz0qOow2DjoyJFC0yr/u+0IRH6xKt/br7pyd95agoAk zjRc4qiOamAS1ibjnCoxZ3OiVvKpk8pi0pzAQlsyyjp6JSt0CVQxUzvvf91TEXXaXTqZLiYTsu5cBx OxckqgsKq9y39jiGsWL+EBmsLav97duYWK7CTktz7wCa7rdTCTWUwOGrp/X2BSl0DYRhxwhIzpYpHm O2rxcBF2kPITlV5VlLggqr6Qas/Ooxw72fn7n4GVXo2fLj9pQ5HxtK/D0YgwsMH79B2jv80zEwgywe TyvYsqg60SuSljx3eGq0z/StVpY46QbWFq30695vxcxjuU/JY/MXM+2a/ylteipKgtKwGrXZ2yRRob qigBVF/hrrc6D9vAykDWp1iLd69JD+O0LwbjECJDkTmYSRpNyhydOKygxjTHu/WRs4wRIgwcVtyILT ZmJ2O6kWafCLt4ZI6bWVoCjnYErnkI75cTtnbRUbzx2lihigW1PA5BNsAnYv8Ho1AzBfuAzJ+C7hqe EI+MUC1nON+k2+94aETNYLYrLJEg5WRRn23uZoW8sR+vPZ0Llfhbfv339epQ==
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

Ensure that there can be no ownership cycles among different types by
way of having owning objects that can hold some other type as their
element. For instance, a map value can only hold allocated objects, but
these are allowed to have another bpf_list_head. To prevent unbounded
recursion while freeing resources, elements of bpf_list_head in local
kptrs can never have a bpf_list_head which are part of list in a map
value. Later patches will verify this by having dedicated BTF selftests.

Also, to make runtime destruction easier, once btf_struct_metas is fully
populated, we can stash the metadata of the value type directly in the
metadata of the list_head fields, as that allows easier access to the
value type's layout to destruct it at runtime from the btf_field entry
of the list head itself.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  |  1 +
 include/linux/btf.h  |  1 +
 kernel/bpf/btf.c     | 71 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c |  4 +++
 4 files changed, 77 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4cd3c9e6f50b..c88f75a68893 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -190,6 +190,7 @@ struct btf_field_list_head {
 	struct btf *btf;
 	u32 value_btf_id;
 	u32 node_offset;
+	struct btf_record *value_rec;
 };
 
 struct btf_field {
diff --git a/include/linux/btf.h b/include/linux/btf.h
index a01a8da20021..42d8f3730a8d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -178,6 +178,7 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size);
+int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
 struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c0c2db93e0de..10644343d877 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3723,6 +3723,67 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
 
+int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
+{
+	int i;
+
+	/* There are two owning types, kptr_ref and bpf_list_head. The former
+	 * only supports storing kernel types, which can never store references
+	 * to program allocated local types, atleast not yet. Hence we only need
+	 * to ensure that bpf_list_head ownership does not form cycles.
+	 */
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & BPF_LIST_HEAD))
+		return 0;
+	for (i = 0; i < rec->cnt; i++) {
+		struct btf_struct_meta *meta;
+		u32 btf_id;
+
+		if (!(rec->fields[i].type & BPF_LIST_HEAD))
+			continue;
+		btf_id = rec->fields[i].list_head.value_btf_id;
+		meta = btf_find_struct_meta(btf, btf_id);
+		if (!meta)
+			return -EFAULT;
+		rec->fields[i].list_head.value_rec = meta->record;
+
+		if (!(rec->field_mask & BPF_LIST_NODE))
+			continue;
+
+		/* We need to ensure ownership acyclicity among all types. The
+		 * proper way to do it would be to topologically sort all BTF
+		 * IDs based on the ownership edges, since there can be multiple
+		 * bpf_list_head in a type. Instead, we use the following
+		 * reasoning:
+		 *
+		 * - A type can only be owned by another type in user BTF if it
+		 *   has a bpf_list_node.
+		 * - A type can only _own_ another type in user BTF if it has a
+		 *   bpf_list_head.
+		 *
+		 * We ensure that if a type has both bpf_list_head and
+		 * bpf_list_node, its element types cannot be owning types.
+		 *
+		 * To ensure acyclicity:
+		 *
+		 * When A only has bpf_list_head, ownership chain can be:
+		 *	A -> B -> C
+		 * Where:
+		 * - B has both bpf_list_head and bpf_list_node.
+		 * - C only has bpf_list_node.
+		 *
+		 * When A has both bpf_list_head and bpf_list_node, some other
+		 * type already owns it in the BTF domain, hence it can not own
+		 * another owning type through any of the bpf_list_head edges.
+		 *	A -> B
+		 * Where:
+		 * - B only has bpf_list_node.
+		 */
+		if (meta->record->field_mask & BPF_LIST_HEAD)
+			return -ELOOP;
+	}
+	return 0;
+}
+
 static int btf_field_offs_cmp(const void *_a, const void *_b, const void *priv)
 {
 	const u32 a = *(const u32 *)_a;
@@ -5414,6 +5475,16 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	}
 	btf->struct_meta_tab = struct_meta_tab;
 
+	if (struct_meta_tab) {
+		int i;
+
+		for (i = 0; i < struct_meta_tab->cnt; i++) {
+			err = btf_check_and_fixup_fields(btf, struct_meta_tab->types[i].record);
+			if (err < 0)
+				goto errout_meta;
+		}
+	}
+
 	if (log->level && bpf_verifier_log_full(log)) {
 		err = -ENOSPC;
 		goto errout_meta;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c96039a4e57f..4669020bb47d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1044,6 +1044,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		}
 	}
 
+	ret = btf_check_and_fixup_fields(btf, map->record);
+	if (ret < 0)
+		goto free_map_tab;
+
 	if (map->ops->map_check_btf) {
 		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
 		if (ret < 0)
-- 
2.38.1


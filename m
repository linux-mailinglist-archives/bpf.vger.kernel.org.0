Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7F62EB69
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiKRB4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbiKRB4n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:43 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A92D8756A
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:42 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3707291pjc.5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59LPQzxnxExTrnm9z27ZdhRyWEMEvy8zkWsOH6jmk1I=;
        b=AZVN9D/RppIsjjdyyrG2vA4fNt0hzl0cwNnJXIZc1XzOzgvcQvaOEXCn9wraTd8jN4
         hdullS4eEUyuo7fGv4u5JkaeqOuPYOcV2y2YRzdo7u3gUY2+KZF2PlSFmNIer2P2+wcF
         CI1B5J+vfJRWNqePZcfNqeCgQwK4UQiEGm73h9vc/NKaPWJo+mkokOmAIFXV//gWk8n7
         a07oB26V3AkPyMFwEgVtrXG/mDRGY7vhiR4Anq7l9Z45SR1NXO7ty8WmitnEyykiNOGn
         A38refpbn7jXUUEbztFk3ATNZyc4a7DsknNuokJ/asshwGXvMbAyAvBPQlFw1tT1HL2C
         cQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59LPQzxnxExTrnm9z27ZdhRyWEMEvy8zkWsOH6jmk1I=;
        b=oxpvoWdpkPGPIpcRBB5HXvCNgcmu42SqUshSFJiXk2oBmQnP0EqTuc7Dct6/pQOTa2
         21mpgi841OWRRtFAtYamaZjAeYG+oHRMgaU8AFNoOh5NJ9ENezaKw3OvkncnoLhL1TQh
         sCygCIqyh5Qfp9t5NKyHpoQZJXkc47GLdNjwWnZ/yMGTd1v+3sDUn7Vyhbongn2kl0S3
         mFHR8ysgrzK9YO2ndMhnWV2aAYk1/qjpVtL7DP23WiKG0OllRwH/w9b6pjOWnbro8KC9
         V5p7P/WQpzh9BJ9p+rIqkwAV6hOp7unvoNt9G8ebFab41jAjPv9AIgApUYzeYpAa9dCz
         /k9g==
X-Gm-Message-State: ANoB5pmZr8M+T9k+dqM30YoxTphQf9C0DHPQC/0AH6TbKHNwoPULyXXh
        FSl5E8bG05zP37nJNi8sIT5RtifGXMw=
X-Google-Smtp-Source: AA0mqf4V0W9WCPyygWI+R++Xh4bAE+po+HR53vuCihcbEOvQUZCPkjGyAeRxZzAVCawH99stc+g1ZQ==
X-Received: by 2002:a17:90b:3d84:b0:213:f8a9:fd49 with SMTP id pq4-20020a17090b3d8400b00213f8a9fd49mr5520681pjb.73.1668736601469;
        Thu, 17 Nov 2022 17:56:41 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00186b69157ecsm2120306plr.202.2022.11.17.17.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:41 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 07/24] bpf: Verify ownership relationships for user BTF types
Date:   Fri, 18 Nov 2022 07:25:57 +0530
Message-Id: <20221118015614.2013203-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5571; i=memxor@gmail.com; h=from:subject; bh=yjHfgHm/5+Ygd2drsc/Tti6WmbVZpvw5QJdLaHTdJrM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXOBmK1fKl3Ixaf3FLvq3rDvimWbGzprZ//M+bf XUHGe2OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RyucuD/ 9m0YhZr6bxnGvoDxbBHAu8rgTwegyOYmTN/Skpf5JyyRne7r2M/lLXnVHjNEoZfdBr6CE0TlfzLobH jVnwRJu/1PvTzGv5cBbPOspxLVxHFq2gtVlugcKagVa9t+bjcgPFi9a8H9wrwTknyZUtCC28tINIXl 4GMWQY/lO81DgptCiZXCJUV4WHJY9qe2asO+FwetVOBdhbyhDgMSNPqp5U8TVMy+8/0xqj20jaspaL qbnoQ39X2jCNZO6z5IiKAacAFekM2/62ENBTTEfCqgX5UBIBYgEpJ92v7AYK6HFxDl2RoUcYzdmgou ZH0INR3Z/DG4Ouj68UfA98fkNqcKvgbRikhMrYgYg0Se9gPi2iWnH06/DEF/ASqXLFGLUFGm85uEKV baWKwOeGO93YvO355X8Nmq78vdKgX6WstPCK2+Bv6nf6Sfoh1ZbM9TssvtrV0nbR08bZpa4Jirnhey 4T4VmzvLGJ+oyJu4ajqa1X2WUEA8MWbb1MsYc4FgyfKJ+7ZzrhJT8C82KRa3CBBOewxrjLXNFu6spd gz55d7faJWwS8Oz/p7otG752Pdop46ZMbG4/cXl81cOu63g5rCu4qApvX0fGnTx16hVkHU0PS9e6f1 c1w9NfJVBP/eweg6eCeRNcxdi2RfbhBtpaBqEStdUn46y9jrYMPwP9ATxIzA==
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
index eb6ea53fa5a2..323985a39ece 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -191,6 +191,7 @@ struct btf_field_list_head {
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
index a04e10477567..91aa9c96621f 100644
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
@@ -5413,6 +5474,16 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
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
index 56ae97d490f4..6140cbc3ed8a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1054,6 +1054,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
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


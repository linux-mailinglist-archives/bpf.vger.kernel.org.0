Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A654862E8CC
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiKQWzs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiKQWzo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:55:44 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F0762CE
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:43 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3390615pjl.3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59LPQzxnxExTrnm9z27ZdhRyWEMEvy8zkWsOH6jmk1I=;
        b=CiEbwjfJhTyyHuW28tXo+HFVt6J9/53Ftsl8aIOzPqrL8QPpPfm67CNSOOlvFNYjeP
         mmJRRuFDfdpatCB1dZitk8FgpqLX9nOs3SXFFMLce6ceFmjyUnCyTEeHqB7r5f9oX/Kd
         haRbSiBIN66+wLmPv7yv5WEHaDDlTV2QIcmC7qT+y4vbyKKQUJTjQBatifLj4BoIJl91
         EmeHiewR49RNAzk16j0Oxf7Xsdy7Av+0r90FEwCW592kg6Zodql3wiLdgRCTG6yMaMxw
         y4hiQh/e0T0Ay3ekr2OBvUlWjFpa+G+7l/0gKpGZc6E31wNMD043aSXEVvR9wTxPnKQt
         wpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59LPQzxnxExTrnm9z27ZdhRyWEMEvy8zkWsOH6jmk1I=;
        b=cN43JjWp7IG7YLT17He5KNNbl/IVRf6ExT8F+f/h0RlIXXYAYOPdqb6mdvZBD3EFMu
         LZHLjhUq/Mzrb0KyynJhClDExF+B5kuJd+CD3fDxh7jmXXB/040VJaw3Zv+jqWJ8hwM3
         S+FSoBzXyxvEpuxTPN4xN1WzHYB5J0CDxLbyAG+zcsmkxWHWsuNvgOI3YaM54LEwi3Oz
         MEC6HTiFB2ElYQrkYzAtNZ5aT1/QK4lQodPV8mKLpj/WOI2PGVCYW2Rm1edu/UIJMZ8g
         dCqTf8/yx8HTCuxv6VSSriokOhpcSgSZiOAiFdYmQLMitKS6BkM39HH6TNpXxgLNBeVP
         J4vw==
X-Gm-Message-State: ANoB5plwrau3HEx8FeFK5PaBggkjKEhsWkIt1qpymsAzhsgI7GTPo57X
        nT9qgk2B3fjwV6VBOvRarMQZQL1W0po=
X-Google-Smtp-Source: AA0mqf58+zZjkH0CyzpyzMpEhKdOeF/cA58fRQRbasaL2bkoFS6iyDzPQclmry6gcUdbbZlGHMoBDA==
X-Received: by 2002:a17:902:bd96:b0:181:b55a:f987 with SMTP id q22-20020a170902bd9600b00181b55af987mr4890823pls.67.1668725743129;
        Thu, 17 Nov 2022 14:55:43 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id iw20-20020a170903045400b00179f370dbe7sm1847384plb.287.2022.11.17.14.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:55:42 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 07/23] bpf: Verify ownership relationships for user BTF types
Date:   Fri, 18 Nov 2022 04:24:54 +0530
Message-Id: <20221117225510.1676785-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5571; i=memxor@gmail.com; h=from:subject; bh=yjHfgHm/5+Ygd2drsc/Tti6WmbVZpvw5QJdLaHTdJrM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkbBmK1fKl3Ixaf3FLvq3rDvimWbGzprZ//M+bf XUHGe2OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5GwAKCRBM4MiGSL8RyvJbD/ 9HqaY4aL9pfovYru3Zm/u0O26mfjgbsbQSNsQqm3RW2hhcUzezEXheX5Zs5DIvfRQGqryYyzeTQeix flKSeG59S2FF0+WSIoK2+aLYmmK0ZBojePNsP3nQpIz4+rFoOeLlZaGijS9OrK6EGqVQhgEvdoMdTH tIl41ktxruvuk1W+eUUXSrQvbYiOc4CbXmAUj+VYHFCOr+g6w+inJEFYaiGImDKDAokNbW/NxuRkKD F6tczFfVuE7OaBuoi4v84PAxW8FY70dgmZyTFbfqt3hMr8nHLjxKn+u1T88KwaV6fmNaLDyzrpJgqM oRfInbft/CPMUSH+HIFgsAiCm/f+QWuQ1f6AIR/VIhU4T5PtXxFzbAY9F3QBASqYGLTLYZsAThGc5f AWlutjPTwImXlmB9vDyB082EcwkeHZOVpixv/nwUURhfqxR4GtLTTWN7kJmxLiuM6P5Loz+G7YMpDv kgOMDQF+Hp5ylwsKyh9Z11lfWUGXoAM8hKgiI9R+X+UvTFM5m53NzIp9nSXW2J34fazq0j9cCV/YTC CaV09sB0rQ/ZipHlNHwBBxa7UTDx6V/YLPN/NVq19Ibeqded72clj+QlHUDIS/VGn/1QdScModa12c lyGUJoNpRVWfW6ScEi6txJK0WcK2OhI6yf/R6eTO8vS4Eep7o8kGsgQCkruA==
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


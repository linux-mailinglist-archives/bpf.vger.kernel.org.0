Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D4561884C
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiKCTLO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiKCTLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180C81D674
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v3so2498388pgh.4
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEsagIRtKd7rcMR0o09yWgazQvX+Qgs6VqyXVqjeiVM=;
        b=IjGzEHiU9MgvAQWUsczKFnm+GtduLSyTYqIeDMEWl0OuzJtQ9CDPSu84fAFWBuQf14
         W/Zj3FMxKdbWEBG3WeykUYDdkNunWzTg3AeyKNJ08eT4hZYkglMcccPiLss6xQNYjALe
         /+y3tzbfkJHvDS1VcCW8HKb386c1+xUZijdC2O2nevMVw6d9IAzyfhAcSWBWI2KEF/DY
         ov1gSJ6sTLv8Db9JizMmY37YyInZza5AS6csctkuda5XrdpjMiD/wRG+YGmkw069the1
         D/LvKbED1r5HwE0CXsub0juSKeIunhG26mVYnBSFnG0zBM7x5+4a1d2PVYJ52JWxJy8R
         tqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEsagIRtKd7rcMR0o09yWgazQvX+Qgs6VqyXVqjeiVM=;
        b=n8/bcgwtxqkC2gZsWH1MjaXQo9PP9nM0fXcR76+NGeqIV+CLA7nVUOyxqOvNWDKMdm
         HYKy8EymlKbofPV9/z3NwEu4o4QF2Oy8v6eppHx2yDyLffBGqNb0nIRDVnCc1c8vbt6Y
         p53hcGLehmSgKx4leQqOXMMB0APXvMM5leWml5JWssl1xnuUnD54MbQFodjChayNm1Oq
         72B3GbJl6SzZ1QNO8eoV64WN/W7zwgcWyfGUv/Wfozu5tJ4+k/VrodkspfW3gsFGTeSP
         loE+BKEbE5qdscCLUvouOsgEyoohm3KxHdciL5Jvki2Hb42/RYpAbDHKpwE5Iy5cMXUE
         RMmw==
X-Gm-Message-State: ACrzQf1VoHfbrx+8zSV8tillvlFqH3PBHJB+IP6qOHz6Nm8qqtV3wwvj
        EihJmNrM1sWZy7QHvDpPcbQl7m7g1Kfprw==
X-Google-Smtp-Source: AMsMyM55BWmUodx/xQwJqz0J747GhnFB/b9BPimigTbysM4t0VeBWOLNwGi2bAhJ+xm0ui8S2KYZMg==
X-Received: by 2002:a63:8943:0:b0:46f:3a91:3618 with SMTP id v64-20020a638943000000b0046f3a913618mr27562913pgd.16.1667502671347;
        Thu, 03 Nov 2022 12:11:11 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b00186c5e8b1d0sm1037147plx.149.2022.11.03.12.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:11 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 12/24] bpf: Verify ownership relationships for user BTF types
Date:   Fri,  4 Nov 2022 00:40:01 +0530
Message-Id: <20221103191013.1236066-13-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5499; i=memxor@gmail.com; h=from:subject; bh=fX6SrE08+/ydTI+u69Pjd+hS+2ZUGf+e6zqBgorcGPY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIBP7upP+fw+VrImSJ8j2IkK8VFPgI/kT/ql+A5 MnkPM5OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAQAKCRBM4MiGSL8RyvhrD/ 4qHfSsK6qvZswdum5C8NoJH9iGcQwH6anXoPD1olVeavsun2k7eff78zwJpcGWr+C+0bQ6XTqnG80K J++tKJ0sBYwZSLg0vMCCna+KX3JbX8kaJQoBK2t7aN2yM8htJBC4/3RRmJb6ZOwOb1gaU9U7Kh+B4J G0D3qDGaZAGenK1NFbjPacQCi7YUf1Mm+eetaoEAahR0Dhyc1l/t8cfJ8oouKxxouDatmhe3K964Bf pajHSOp5S/lHAiWU7HMjzF4AZH+Rol5/c3xqEdsuimOxAYWeTn7NR5Aif6FSsNI23DZYbqpX/w9o33 9ITLWNvlZ6ZjWqvc881rDHfrrZPaQ/pO12l2JNsiXbPRikb7E+gwbvc/WviVtVP2IjaKZ0pFO/pIPs nVs0FgXDOprkMwZXnBiBTnII98E1CRAnFgzH46dhF0eKhNf5uveBNROJAXp5nk5cajDtw2WAiRFjFd ViT658TLcpR1o1CWmuMAf4f1GlhnBUDl3iQ5ukxbbI8Kd3z+sNw/H83FkAPqmrHEpWY2DlQXrH1MsX SRNXSl1Pv4gNV9r8CGZRGvIqzuXfvkAGS6nTnQqPLUaaGKJwUHGmwKHiY3CD4ryFA8nux/QOu61kZi pzRH4pGEUyunRgV4n5P0u36ml7ej1uSrGBI9ctGBk3W1jMnmAVlyu5fUr4Vw==
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
element. For instance, a map value can only hold local kptrs, but these
are allowed to have another bpf_list_head. To prevent unbounded
recursion while freeing resources, elements of bpf_list_head in local
kptrs can never have a bpf_list_head which are part of list in a map
value.

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
index 0797c467e894..fb2659c1c10c 100644
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
index ffe9d5b182e6..514219a790f4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3722,6 +3722,67 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
@@ -5411,6 +5472,16 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
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


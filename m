Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D662E1A6
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiKQQ0q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbiKQQ0Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:24 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B3073B8A
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:09 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b11so2098909pjp.2
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4mZ6hP9ObJ5uQf5JqTcbQKElLyiJzgs0Cf81+J0nCQ=;
        b=Il+JEOK5Do3cP8ik4X+B5lEK0GFItcbrQl1vf/Z1USIHDpTtnz/r14MrSdND1CfsHo
         SecF6f17JGP78t3uUgC9ZDiy/l0tDRol+xUQLihKx7AheoZTOly2jFB3Okr+LnZz8R+3
         mS8t7VGdIadKAuL52gZ/KfpciiOB4KpGoCfJmC+abu3snBKghSNaPalPmfxJSK+UCKlb
         +Z5g+LlSwIHnJzA496uaN/uLy+EPy5QAthk80bywhcjRLrp4IEfUkhft9ggiyr/uyBsS
         T9h9umyVA8HrmBRp+/6oAmJ4+VV//fIzGdFL1GonXcPTMNt6LUUxnH410351tSaykqxh
         l2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4mZ6hP9ObJ5uQf5JqTcbQKElLyiJzgs0Cf81+J0nCQ=;
        b=qnExRVGg97UwLI8op7p+oMEzzIFQfS2DgrRP+HDERR88tfxdkQffvjKF8AnMhjT/x5
         A3Z46r82axVUS37h1xQhs0QewTX+dznd9G5iAR/KFXMcEjqJtyMXml/Jh7RSyUAjOudz
         LQyaDhAqmkOd1tLxPiblNDCKT/1g2DrdTm9mjyUkqTUJEohCmh0G4yYB03+yItLMvaPy
         1yeX677DbnneUGpgFyBJpfl3c63D6a/u6UYpoR055tcy+8Wv36vBLQQTG6nSVIrGaqig
         2KtqVHOU4F1XWk7HCk9JR9HNBp3C9HH96o65TOZ1uT/hxsxGdEbfNO7vDkuZThLJBTmp
         8TmQ==
X-Gm-Message-State: ANoB5pkd8xyzLI3Wa4rK9jnKi4oZ7LD0VFycdSIJZWhGCBLb8Wi64u2H
        QgdSrMiXupC7D/Ki13TKdJ4V8zXXNLA=
X-Google-Smtp-Source: AA0mqf4/+0mq5v39qdXDVHKdJaoIxznG5yu8cgos8jLt5c+vEhV0M4kd7eeijemYS2aPZNbvrcHR5w==
X-Received: by 2002:a17:902:e807:b0:17e:539:c405 with SMTP id u7-20020a170902e80700b0017e0539c405mr3475369plg.53.1668702308531;
        Thu, 17 Nov 2022 08:25:08 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b00188f9534a3esm221456pli.87.2022.11.17.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:08 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 07/22] bpf: Verify ownership relationships for user BTF types
Date:   Thu, 17 Nov 2022 21:54:15 +0530
Message-Id: <20221117162430.1213770-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5571; i=memxor@gmail.com; h=from:subject; bh=4XpdADs4wUXZzYe4sFC8jTKjE7hThtzyMgL0BDjwri0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7+n/f/lYI7oMalgTVkux/lqAAyehT2pCDt/UlU ZUWi01GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/gAKCRBM4MiGSL8RyuGeD/ wNmp/DPN6Jv/SZb0vKayGNxzxNyNp1HhOpk4C/uUrhgbeycVZ2ICz/ZYYhrklGhPucUbaRFgGU55BV ohFGY2fu+VeUWC6AaOURGRCjrr91lTipXDIqiaTK/pQTHjfEBEF8o8tBTtjFWZ+9cDKN8RfZ5Ow0lm 5sNZpQBXDemp4WKH5Lfz7F4em8kLbWpwFvRAUr0k6rLpUQFn0e7iCcpoUZZITcWP+4gxhDm3GciZYi 0MLAECoa+KJHDdM1pFsUo8WTAOKL/le++sKEGIH0tAInZfbKH1PBxYQfa6cdwvWOovdcfqi7GgGAxO wAGI9a3HSTkGHsb2lHlo8XvbgH5J5bsZMve9vWGbOfhcQQ7KKn6bR+0iHpqH6FMyozIH7m1eBRQPgZ +qSWErlgyWJfkxJdvwTlv3WhKoT4SlhKJC42mD1m2w+2e+KRthlqwG/R7RNcVp4gQcb4uZMXTwEJLX u/n/n0rYpOC501mjTp8zATVYKFsf/ELs3wukxUlOa26OxOiVLA5iyqDIF95UVu28qPFjxzqssnV9R4 Qd/uPWJbRi0UszHWLmghGGKBGDwvXykkKEjqpcxl0cUyiXuuXRm7ioeD++sUy4pnjn8df2206NtHow DXRiLgVTjBL7QyLxLWhx9z8CMASkl7GdX7sJFhnjgjFTQyfV/iLZjMu73Mkw==
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
index 45d9323d44ba..7994222f1058 100644
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
index 75f86e621058..fcf17ef42d56 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1045,6 +1045,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
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


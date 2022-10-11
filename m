Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24795FAA0C
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJKB0Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJKB0E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:26:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB31839D
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:25:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so14541141pjs.4
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6HfjkzrwKt+imTfngBptJXj/x6023U8OdWhlwfcr9w=;
        b=SpCLD7dlZRJx1CAzSnqdaxQmK9SUMzRZbTOAo/d2Cphdjpt08gWK8AIbVnm3+GgshU
         S6pjWXes6qfO44acRHyoYG1WNH7Y9rRbz4l/qGpiiOF3O8XCoY8MpH9oyP/51GAyvOKy
         h3WkecFYxNZjzdPlAJQnp7uw/GMhTSgah9nq5/Ka3khnD1S8TtZgOyXGTWbxTRgC/KvK
         +6+rg+UuR0S4NLHCQHYhEf4uoxRhm0XWB37xhUEg1nJMPmsfGK1LClIF6YYLGkh8BG4u
         VCVi/07QimUGt9hc/R6iZfP+wd029fd3QhKzYuiDNVAW2jBOb1MZu48dOlt5lQ7aY1KM
         s62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6HfjkzrwKt+imTfngBptJXj/x6023U8OdWhlwfcr9w=;
        b=fmkI0cd97BhcPKFF0kNGNKU6p/RDXJPauJvTbdjv/pqKhLquhB35MroEKYnXkVryZv
         /CTHWZD6bpuP0cjkvNZesfkKBz/1lha+gK3fO4dcrq2YyBXCNcTDLttKCI8S3cK0LLXk
         7G0+vZt271MgkEqddKNsou/KahVJ0Cs7ra4SawhbP5hVzQkWkp9tnmitFxTHYLnyttg5
         ysvLKcFwBLZ7aY0CJs0Kd2wtopVWsG6a4fe22m0w1fVwCZ4sEbnebQ8TaIx8VGokhBvF
         ym/i5wcWem/eoHjnmfBqw09772rJtF0yuws1QGlR0E9p9spuIC0HqSYZhFBC81VuUBdF
         5xcw==
X-Gm-Message-State: ACrzQf0o1RTS3cSUUUGNtxapUw/D5/rFYyULHTZJOXDyxs7M0N/8SvnC
        f2dmb+SId3hqCVFCAjyuO3L40V9/332Akg==
X-Google-Smtp-Source: AMsMyM5ykeNvnQXa1lrkOmVDHSAGKlVtv9uT8sS4y7VcfWn50RCOnai1wBTFEro9Ir5z5LuSGhrpHA==
X-Received: by 2002:a17:902:cf42:b0:180:d75e:6792 with SMTP id e2-20020a170902cf4200b00180d75e6792mr15973845plg.130.1665451546262;
        Mon, 10 Oct 2022 18:25:46 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017f7bef8cfasm7314421ple.281.2022.10.10.18.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:25:45 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 12/25] bpf: Verify ownership relationships for owning types
Date:   Tue, 11 Oct 2022 06:52:27 +0530
Message-Id: <20221011012240.3149-13-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5464; i=memxor@gmail.com; h=from:subject; bh=FrGg0KDeqbB2+UcZWL9WxngGeePdYddRTyn7rJKLARo=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUamM5QFADqUX2q0Sn4zf5uNvOKhsLuXmg3gmzv EJTCMBuJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8Ryv1aD/ 4yNAhqHD9fS8FOJGWH99ocRie+ZzSQme7RF/XjaWeb7b4v55PADqM4AeVIbKkaPtdaDDr57KYiIKh9 QRFd611OA9tguxpiz+SUPL+0i9ZUgYbw2iMz7iodXTWgMiN6aWGzaXgOGhqvkd1gdB0Qha7juBU0WP 0NiotQ4PwPGycF+YYKYAN2sOC2G/QNP9NSPm+81cSoqBYMoE9GKvMnlYwbr5XG5iV7OoZ2tUk/SNjT mcUhK8+qtax5aMK8tAvzj1ZDeLJX2drsEeBQjjEMMvrYIY/Hctdi2E9ixO5ANF3I9NI/RNlsQDhsqo GD8TmY2mZyBDxb2b3YOaMKUfyjApE5DaOkRiL8Rk8W98yw5DDhXTDrs20/0yN4h5gRXrzNbxBnd6Bg aoIeqcDo29ghXLp6rw7aRsn6AfpSwefaUAwH3bOrJFd/0oE4RjGSVl9y7GqE1axH4NqRcqS9nX14ix A++qs9NzxXm1TiaKlgK2rU41BRX6CUgYlC/FFASt3tXKPMvozdWKGt9+sHkD2Gy2gMBQqHL89uxLQk +tRKXNeUHDcyBWwnSkt6ZVtu1PTInq8vO2IZhOFyo1TOBQxV+w8qxW8PtBNBZZQ8vsJA4KAA3/FsT9 eDs2NTDYwbI+Ig/G7Tx9WcLuB8W6q6IPAmD3JB30A5BpldXfvuBkOk4r6Ncw==
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
index 76548a9d57db..b2419752542a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -192,6 +192,7 @@ struct btf_field_list_head {
 	struct btf *btf;
 	u32 value_btf_id;
 	u32 node_offset;
+	struct btf_type_fields *value_tab;
 };
 
 struct btf_field {
diff --git a/include/linux/btf.h b/include/linux/btf.h
index b63c88de3135..4492636c3571 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -179,6 +179,7 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 					 const struct btf_type *t,
 					 u32 field_mask, u32 value_size);
+int btf_check_and_fixup_fields(const struct btf *btf, struct btf_type_fields *tab);
 struct btf_type_fields_off *btf_parse_fields_off(struct btf_type_fields *tab);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d6aeb0a4d4b7..c038ba873ba4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3730,6 +3730,67 @@ struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 	return ERR_PTR(ret);
 }
 
+int btf_check_and_fixup_fields(const struct btf *btf, struct btf_type_fields *tab)
+{
+	int i;
+
+	/* There are two owning types, kptr_ref and bpf_list_head. The former
+	 * only supports storing kernel types, which can never store references
+	 * to program allocated local types, atleast not yet. Hence we only need
+	 * to ensure that bpf_list_head ownership does not form cycles.
+	 */
+	if (IS_ERR_OR_NULL(tab) || !(tab->field_mask & BPF_LIST_HEAD))
+		return 0;
+	for (i = 0; i < tab->cnt; i++) {
+		struct btf_struct_meta *meta;
+		u32 btf_id;
+
+		if (!(tab->fields[i].type & BPF_LIST_HEAD))
+			continue;
+		btf_id = tab->fields[i].list_head.value_btf_id;
+		meta = btf_find_struct_meta(btf, btf_id);
+		if (!meta)
+			return -EFAULT;
+		tab->fields[i].list_head.value_tab = meta->fields_tab;
+
+		if (!(tab->field_mask & BPF_LIST_NODE))
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
+		if (meta->fields_tab->field_mask & BPF_LIST_HEAD)
+			return -ELOOP;
+	}
+	return 0;
+}
+
 static int btf_type_fields_off_cmp(const void *_a, const void *_b, const void *priv)
 {
 	const u32 a = *(const u32 *)_a;
@@ -5414,6 +5475,16 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	}
 	btf->struct_meta_tab = struct_meta_tab;
 
+	if (struct_meta_tab) {
+		int i;
+
+		for (i = 0; i < struct_meta_tab->cnt; i++) {
+			err = btf_check_and_fixup_fields(btf, struct_meta_tab->types[i].fields_tab);
+			if (err < 0)
+				goto errout_meta;
+		}
+	}
+
 	if (log->level && bpf_verifier_log_full(log)) {
 		err = -ENOSPC;
 		goto errout_meta;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c60bf641301d..c8e1bdcbc205 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1043,6 +1043,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		}
 	}
 
+	ret = btf_check_and_fixup_fields(btf, map->fields_tab);
+	if (ret < 0)
+		goto free_map_tab;
+
 	if (map->ops->map_check_btf) {
 		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
 		if (ret < 0)
-- 
2.34.1


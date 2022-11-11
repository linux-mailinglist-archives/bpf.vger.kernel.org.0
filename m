Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF05626200
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiKKTdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiKKTdo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:44 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9373FCD0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:43 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y13so5693119pfp.7
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJoDj6xrXZktYRxgvC1zzU8QhhM+z5Xg3gZS3dvgLB4=;
        b=enPQg/Zx6GAniJGD4re64/imcXgUX3pKLjBjOK8YotWPe65MKWjBtF+KLwp9jO45Lf
         SC2luCJTFU3BXq/DjkaNpevfCstfcl6gvzsdKvJtcja0Z9y6L82o0PzWx4HZ9SVz5/Z7
         tGSivYpzerSAJ9T3tSFOW4HlPKMRUkeBbb7nCOFufb931Z3eaIRIHqzW7KauKspfou82
         nNv4fMz3LusjSDxknYpyvbLYqHetwlXhV7UzEv7HLnA4wL5Ww872VWd2k2R2d5y2IpW1
         LMcfeyLj2uZ+Z2auoJX8LI7Cl6QKZYSTyv6pfnWp0CFa4DpN/kG8hEMd7cnCSaX9+2G5
         hOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJoDj6xrXZktYRxgvC1zzU8QhhM+z5Xg3gZS3dvgLB4=;
        b=Fh4fbC2bf664JMdKEM3/OsAzA18dQG+fuFUgntDdwGp8SA0tMP3FKg4BCKSnYkOxFu
         gXy0HlrXrVZWqMjFK6lUZ7yCOGG5REDUe12G+/gIPPw2UiS9e4uDl/kYTyaJYHsJ8WMO
         NayCIhVsKzJ2auTrPnutsZGjRzk/TJjfgp0hpDkILOLdx4FQULRXMu/sWB66pxRpyaJu
         KHsOFa4FqGyTLhHtJ+bd+aS1UZpJraZd3iiyoXq4iZ4CvLu9tlQ+QdIDOqwnx2w010X6
         2frEwlZXQr2LT3MS0+TSpd8wZMJwA9rd8bwzKrei492xJGFDazFWyMEOYwncLcEz7AL4
         WRxw==
X-Gm-Message-State: ANoB5pl8+UwwNjsdqXTzNSYyzIvymPSk8Dx3We+9gutn3QTto2/r31n9
        03yor3eU+xNVirULUxzBYAmhLX8aXrHt5Q==
X-Google-Smtp-Source: AA0mqf5zZWtrJzgT0Iyn6JZC+TPeuSYtNsOKHs+Jh6X+yUap44YjsA2ZGuStkCuKKZ34dOFQquDBWA==
X-Received: by 2002:a05:6a00:2487:b0:56c:afe:e8bf with SMTP id c7-20020a056a00248700b0056c0afee8bfmr4149122pfv.51.1668195222900;
        Fri, 11 Nov 2022 11:33:42 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id x12-20020aa79acc000000b0056ddd2b5e9bsm1941489pfp.41.2022.11.11.11.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:42 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 10/26] bpf: Verify ownership relationships for user BTF types
Date:   Sat, 12 Nov 2022 01:02:08 +0530
Message-Id: <20221111193224.876706-11-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5571; i=memxor@gmail.com; h=from:subject; bh=ixmYvmiPkP0VLegCTd0JqLgG+KhMlzR4IX850VHvYng=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIoVisz7aF7uHg3UxnNyEgFFhl7I1JfrCtmfRj+ zl7HHfKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKAAKCRBM4MiGSL8Ryu6KD/ 4rW+dxhYQYDMVOFHGn3aBHRDFeBJ+SXJKDJRoY0gGVIBb9UDa89BYxLKu8yQlLGPejQTzKEKDSr3e1 Dxg9N5iI4GMr3qEUH9uDdNJbAXgcAjzEybOFk+dHCAV0Y86wN+h8aUTI+UuFMQoggakmDEqH11i0kJ lg83GXm8MzcUhQD8WlMEZn/O1Yf4JxUCZVr8vO8wL+BJ60viHNknkjci7xsBYmLFtmFlgr0HplJJat SMg1DJnMfEE62uKIpbc5fCez1L59g4tn4DF0Cxe+Vxsnjtcap3gxA/qUKYZktypdaBJ0Y6IFTadKpc wHFPROre67jzcvboWiyS1+LHZhBCV6MPajERYwcNZnEeUa0I0Vl8Ixyjjsh+gEX3TGF7Oag4Yg5maD TZ1jABjWotmhtRoCWG011jSprZHVkDLXft/BLm4rdDL1Pr2XYkGQ/BAVgPfy/D5kzL0uJpTM1DneTH NyPA6RxHTtXmOGH/COpI/CVfUC/xVmjb2fHzPBVrSULp/3FF4lPOgr250J55kCWEnblh4+VWGxaUbj cIGxi0DeV38jqeAJ7uGV0SOBYhrDEnwOWKF+wDFysCwLWgSrKCSlOcP/b8N2/pCz1HQIgAvYX1GJH3 8hQjl5Q2NaTpGBpwfECVisOOrRYuUjbJ7zaqOAk25rCvPKkBySmW78o12k8Q==
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
index fbcb846188e2..ef8710fab997 100644
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
@@ -5412,6 +5473,16 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
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


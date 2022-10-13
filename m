Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE9A5FD4B6
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJMGYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJMGYF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:05 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8F123457
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g28so1073335pfk.8
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqze95EOpyzbMPQ6A66j5GQcWPdi+32A/wOM3wUp7us=;
        b=pO7X6x2padgNX0FJp+LVWehPDfTPSw+Q/CM9/qhQtXdVhHTHN45Ql9P+qwGMZosSvc
         IP/JOoNFsiRqenw7FWQKBs800zFP3txtqVih2gG87HRjQMwhFEQbMG/ov012glwwqpmC
         kdh1BTjqHnvo82RwQEIEZ+lsbpeSbDg5YaTJG5dOvvF4EalQxWcHzgDwbdOdRjbuGPAA
         q+E+siNZJy8TrChMyeNsBMSeR2CbG0gX7O4rfzxInJsqZciRrr+ussh/t41R/vSgd10U
         4CwAa2IvyV4o2hWgyOmxcL5gTG3MJLvtKoCRk9v5rRniUzNpB0GSfNFTawmd28HkGJxy
         bfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqze95EOpyzbMPQ6A66j5GQcWPdi+32A/wOM3wUp7us=;
        b=XfdbFVu8MqK8rDLMuVxw+RSORfiwP6K+giiNUdntyJ4rUq1maHDrnk2rbo+39iTXai
         NJndZDfWvlCntd6JqKBEuvN6itTBBj5o72rB5uFobuPN+4iqLHSsYpK6QKa3sNkUPmVE
         5eVOGL5VTMWLKVr7lp2LvFQw3hk1/u5Btk7agIUvXmpGoz3IVBKF35J2+Lo80odxggVn
         +ROqSd1FiRzKzm/G8WiQkVaDxGdUcVwSkpNpEsos79FHmbj2WLs+upm5hf81VbsSgg39
         Klhi3l1mwofuQPv3TnYw4PE1KiLqnjDh+/q8UClJ7L9eXn47r2XAQFVUghuSb2xVpR0D
         koFw==
X-Gm-Message-State: ACrzQf0rSbIebDxW4QNPBw/PxplC/8RzVNpO9qIgMAKR90psjrwfKfOH
        whIGQTOUbS5enzyQEJxZHARhkemh4JU=
X-Google-Smtp-Source: AMsMyM7FbSJPFrSM8KuGWWZXOWnKnnOLPTbKMa8kl6TPwhoIXZ6XgWZRrD2RYTu7uK9jvIT/z+VR3A==
X-Received: by 2002:a63:4f19:0:b0:43b:ddc9:387c with SMTP id d25-20020a634f19000000b0043bddc9387cmr28164205pgb.333.1665642240811;
        Wed, 12 Oct 2022 23:24:00 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id f24-20020aa79698000000b00561c3ec5346sm982074pfk.129.2022.10.12.23.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:00 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 12/25] bpf: Verify ownership relationships for owning types
Date:   Thu, 13 Oct 2022 11:52:50 +0530
Message-Id: <20221013062303.896469-13-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5464; i=memxor@gmail.com; h=from:subject; bh=cKEv7L9CpU4sp4r1V9ds0C+DlTv1OMs+Hex+bQyfwvA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67D1lYcdg13Wk7cgaNnKvOJUNvXpA3qzlcWJYCF xVjdACGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwwAKCRBM4MiGSL8Ryj0pEA Crx+yANFbYiw9Vkrclneh25EGlPVy9y/2IiPlYvdayZTGdpE60zOMABjL4Hd1zvrAApVKgKHkTvl9d s9Xk5VBEWHTDh88cKwR8VlsAOg+DYHj0+osxxsz7fvPN/ADj8TqqMr08SyitM7BqGa/IHGMk5XqZKM 32deMmAQg6TqDyLinlmrzwFZDy5upvJ4F80XOmIgnHRziRhA/8ryzOc5KZTqM8plLr3KxsbZ0mCYR/ tHTSmxHpP+OFfQaHHVivRnanl02nE9UJxLFj359DcZ/HzNVll/D53ZvTvNEkJxsOstzqX7rFDCfJKO lSWsPB6fl1iWLu3LsR/Nsou4ro47nDKNTWWcoDhSt7ln2ShwBx7YSGA1z2Ga/7SsDJIH+4HyccZGQk YnJNY3AQyqVmSyN0BKu76HvGUzQ2Iq+b/HzhtJnob3toCRgVQY1jJMdMpD0VH5ipU2mXyu6l+Sa4FX +0f1CaeoEDT3VVfHse7kFPVt1gJbFmHIxFkbZ49YNJ8x/edQExvaBjfciXNjagD45ubb6uBA1sufwz Lp1WzA69sP9t0wqYZpYO+YRbGc8HS6ju+J7q+8GpE1Yknz3qbi+RfdEd9bkAZ/3YuThYKz6hDX+2b4 svDu89aXhe8DEyQyAdH76Sg+vbxBk3C9BKZ/IqUmHr228E5CT/ekI3n1ckhQ==
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
index 6c4701f7c938..86ee5841d8dc 100644
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
2.38.0


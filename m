Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8905FD4B3
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJMGXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJMGXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66D120BF2
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id bh13so776546pgb.4
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIG5ZY4eax1XFEC6PgBRN8oaOisdQkut4wPyL/W6jHc=;
        b=Bzq9UN1cvVWTchAk69M8g7u8Fv+LCQSRb9Bi/3JE0gfptVJ/kiyFVa6tbrm1Cha4rk
         9Hge/yepB5kU1DttcXJrsMfEkvr2LyKSH/CpdhIV0A4POzMFih9bb1oB4VUbLvhKFVNg
         wkw5rG4X9ophRjwdlcNdvDtD9jzpM0coOmN6PWCidw3YPs75jzOHivjVXj/BJ6WX1c4L
         XAGMfQnQq2Qy5HFD3cLneydB44O7RoGB62p/rMgQsUWpbQnr7X/v/eTBOg532YH/0V6o
         Xb7hF3LE3yetmRcIX7PNE6JQ2syd3h4AGsxOku40sdrDq+r7AMmU2B97Ml0ewHGzYG0p
         lhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIG5ZY4eax1XFEC6PgBRN8oaOisdQkut4wPyL/W6jHc=;
        b=f+LuU14Fs67AInRiR1UY9QPHNojMa+91cxSOtWMoMLvVmruA3t4nuewiIQrR54QIcd
         1ZHH3tGLVNfD1ENuGIpwOiQKkOnPWKfZpzmbI9GMz9rCla21rqEYFlOj19d12vq36/ru
         djU1VpGV3T9IqoNkDZA+ZRXgLvq4VSchamBdC4oBY10xClshNfvrsGMpsPyvrMr10qQV
         fuMmhEkf6EEcMJXzsqC6DI2BgKHAXFBjWw6mJYRi3wBIB1QYckLkUzdnOuHD80r0gDIY
         AoR25jz21GstilchJ3fiOvljHy2HU/NaM0tlwpyd0z/pSpkcoWB2OMBwPijsQh/1QMeR
         b7Qw==
X-Gm-Message-State: ACrzQf2IIr6A7bUpRkdwxX2qLrIjxc2tE38E86XI4NykYH9SmHftS/O+
        TrzRFzRLfyHF7hnx+jGOTr+cLzjAfek=
X-Google-Smtp-Source: AMsMyM72r99AA2s6FBkDvjnbeL5zMaUqHcvoH71l48h7GJ8tjSUNc64lharV1AqX1I8PG+018DJ71w==
X-Received: by 2002:aa7:951c:0:b0:562:ca32:3d3f with SMTP id b28-20020aa7951c000000b00562ca323d3fmr31159659pfp.33.1665642228732;
        Wed, 12 Oct 2022 23:23:48 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id g6-20020a63e606000000b0046aff3ce339sm633009pgh.23.2022.10.12.23.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:23:48 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 09/25] bpf: Support bpf_list_head in map values
Date:   Thu, 13 Oct 2022 11:52:47 +0530
Message-Id: <20221013062303.896469-10-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15697; i=memxor@gmail.com; h=from:subject; bh=IrwHh6xYX/97VwxoB7IOsKHf+yN2ZMp83IU+86ljlBo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67DU0PsA1KfZ22pRSeaW9UhHbnp2Es4t3xSNAdf dQxkEL6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwwAKCRBM4MiGSL8RyiWfD/ wM3LKVC4NJQBn2T0v6G455IX8iJTs448PYih87KOnuF/Glmk8KSq+NprpvboE1u2HsS6Wbv5zTwgYJ Qghbg4O7HgtL6E5yenhCY8n7ubEGWj6hjWG72BJJW9VJiqrOFELxeozS9H5r0wSEzqobdFKKZJOsVt Mi7uaDxXrvSAxOOcQlVUUQfOutn1nmbRNiBmUobfkr2XRrnJK9Kz2SiE/w1sMBfxQ80RrSjeJvYjg5 QD98RGZ/lKnvwnA7d/PM14U24ylS216xLGfwy0PnbAdaEfH47xLgABI8qcfcWuWzg4Nl8XOwuXOKfE X3ThoVYFbaXUY2Anm/zWl2YpoFPWEotITZTLk1WtOdBsugYy+sHVdsfydf9jfTLQEnl8/nvMoqpgcf HXrh6tE8ZS3nYvQ1SM0KaSioUBB2JZa2dnDn2oAFCJLj5oU5NC53Q87bgdnTx0/RLLghRvaQoLItqp XIXgvCyo+lXzPmGrZHWzBnsaO88a+7iBDM70Zuh29ALIY+89iHiyNVv8UJEXNVkHrYqUU18WF+QCBA lhMk8Xqw65gCnuJx0v+dg/AdmiG5nEupqEwbEYtysoIW7Tk4LOOyhVEK8A0ExmFEHoRn+1qH/EGyIO loAmIcRBfsyuS6HTeUUMn+2A5WjC8CooAW/mJFL2fYqcvdAD3S1wRvfl3IJg==
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

Add the basic support on the map side to parse, recognize, verify, and
build metadata table for a new special field of the type struct
bpf_list_head. To parameterize the bpf_list_head for a certain value
type and the list_node member it will accept in that value type, we use
BTF declaration tags.

The definition of bpf_list_head in a map value will be done as follows:

struct foo {
	struct bpf_list_node node;
	int data;
};

struct map_value {
	struct bpf_list_head head __contains(foo, node);
};

Then, the bpf_list_head only allows adding to the list 'head' using the
bpf_list_node 'node' for the type struct foo.

The 'contains' annotation is a BTF declaration tag composed of four
parts, "contains:kind:name:node" where the kind and name is then used to
look up the type in the map BTF. The node defines name of the member in
this type that has the type struct bpf_list_node, which is actually used
for linking into the linked list. For now, 'kind' part is hardcoded as
struct.

This allows building intrusive linked lists in BPF, using container_of
to obtain pointer to entry, while being completely type safe from the
perspective of the verifier. The verifier knows exactly the type of the
nodes, and knows that list helpers return that type at some fixed offset
where the bpf_list_node member used for this list exists. The verifier
also uses this information to disallow adding types that are not
accepted by a certain list.

For now, no elements can be added to such lists. Support for that is
coming in future patches, hence draining and freeing items is done
with a TODO that will be resolved in a future patch.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  19 +++
 kernel/bpf/btf.c                              | 147 +++++++++++++++++-
 kernel/bpf/helpers.c                          |  32 ++++
 kernel/bpf/syscall.c                          |  22 ++-
 kernel/bpf/verifier.c                         |   7 +
 .../testing/selftests/bpf/bpf_experimental.h  |  23 +++
 6 files changed, 246 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bc8e7a132664..46330d871d4e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -27,6 +27,8 @@
 #include <linux/bpfptr.h>
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
+/* Experimental BPF APIs header for type definitions */
+#include "../tools/testing/selftests/bpf/bpf_experimental.h"
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -175,6 +177,7 @@ enum btf_field_type {
 	BPF_KPTR_UNREF = (1 << 2),
 	BPF_KPTR_REF   = (1 << 3),
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
+	BPF_LIST_HEAD  = (1 << 4),
 };
 
 struct btf_field_kptr {
@@ -184,11 +187,18 @@ struct btf_field_kptr {
 	u32 btf_id;
 };
 
+struct btf_field_list_head {
+	struct btf *btf;
+	u32 value_btf_id;
+	u32 node_offset;
+};
+
 struct btf_field {
 	u32 offset;
 	enum btf_field_type type;
 	union {
 		struct btf_field_kptr kptr;
+		struct btf_field_list_head list_head;
 	};
 };
 
@@ -266,6 +276,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return "kptr";
+	case BPF_LIST_HEAD:
+		return "bpf_list_head";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -282,6 +294,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return sizeof(u64);
+	case BPF_LIST_HEAD:
+		return sizeof(struct bpf_list_head);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -298,6 +312,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return __alignof__(u64);
+	case BPF_LIST_HEAD:
+		return __alignof__(struct bpf_list_head);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -401,6 +417,9 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
 void bpf_timer_cancel_and_free(void *timer);
+void bpf_list_head_free(const struct btf_field *field, void *list_head,
+			struct bpf_spin_lock *spin_lock);
+
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
 struct bpf_offload_dev;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index daadcd8641b5..066984d73a8b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3205,9 +3205,15 @@ enum {
 struct btf_field_info {
 	enum btf_field_type type;
 	u32 off;
-	struct {
-		u32 type_id;
-	} kptr;
+	union {
+		struct {
+			u32 type_id;
+		} kptr;
+		struct {
+			const char *node_name;
+			u32 value_btf_id;
+		} list_head;
+	};
 };
 
 static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
@@ -3261,6 +3267,69 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	return BTF_FIELD_FOUND;
 }
 
+static const char *btf_find_decl_tag_value(const struct btf *btf,
+					   const struct btf_type *pt,
+					   int comp_idx, const char *tag_key)
+{
+	int i;
+
+	for (i = 1; i < btf_nr_types(btf); i++) {
+		const struct btf_type *t = btf_type_by_id(btf, i);
+		int len = strlen(tag_key);
+
+		if (!btf_type_is_decl_tag(t))
+			continue;
+		/* TODO: Instead of btf_type pt, it would be much better if we had BTF
+		 * ID of the map value type. This would avoid btf_type_by_id call here.
+		 */
+		if (pt != btf_type_by_id(btf, t->type) ||
+		    btf_type_decl_tag(t)->component_idx != comp_idx)
+			continue;
+		if (strncmp(__btf_name_by_offset(btf, t->name_off), tag_key, len))
+			continue;
+		return __btf_name_by_offset(btf, t->name_off) + len;
+	}
+	return NULL;
+}
+
+static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
+			      const struct btf_type *t, int comp_idx,
+			      u32 off, int sz, struct btf_field_info *info)
+{
+	const char *value_type;
+	const char *list_node;
+	s32 id;
+
+	if (!__btf_type_is_struct(t))
+		return BTF_FIELD_IGNORE;
+	if (t->size != sz)
+		return BTF_FIELD_IGNORE;
+	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
+	if (!value_type)
+		return -EINVAL;
+	if (strncmp(value_type, "struct:", sizeof("struct:") - 1))
+		return -EINVAL;
+	value_type += sizeof("struct:") - 1;
+	list_node = strstr(value_type, ":");
+	if (!list_node)
+		return -EINVAL;
+	value_type = kstrndup(value_type, list_node - value_type, GFP_ATOMIC);
+	if (!value_type)
+		return -ENOMEM;
+	id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
+	kfree(value_type);
+	if (id < 0)
+		return id;
+	list_node++;
+	if (str_is_empty(list_node))
+		return -EINVAL;
+	info->type = BPF_LIST_HEAD;
+	info->off = off;
+	info->list_head.value_btf_id = id;
+	info->list_head.node_name = list_node;
+	return BTF_FIELD_FOUND;
+}
+
 static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 			      int *align, int *sz)
 {
@@ -3284,6 +3353,12 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 			goto end;
 		}
 	}
+	if (field_mask & BPF_LIST_HEAD) {
+		if (!strcmp(name, "bpf_list_head")) {
+			type = BPF_LIST_HEAD;
+			goto end;
+		}
+	}
 	/* Only return BPF_KPTR when all other types with matchable names fail */
 	if (field_mask & BPF_KPTR) {
 		type = BPF_KPTR_REF;
@@ -3317,6 +3392,8 @@ static int btf_find_struct_field(const struct btf *btf,
 			return field_type;
 
 		off = __btf_member_bit_offset(t, member);
+		if (i && !off)
+			return -EFAULT;
 		if (off % 8)
 			/* valid C code cannot generate such BTF */
 			return -EINVAL;
@@ -3339,6 +3416,12 @@ static int btf_find_struct_field(const struct btf *btf,
 			if (ret < 0)
 				return ret;
 			break;
+		case BPF_LIST_HEAD:
+			ret = btf_find_list_head(btf, t, member_type, i, off, sz,
+						 idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
 		default:
 			return -EFAULT;
 		}
@@ -3373,6 +3456,8 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			return field_type;
 
 		off = vsi->offset;
+		if (i && !off)
+			return -EFAULT;
 		if (vsi->size != sz)
 			continue;
 		if (off % align)
@@ -3393,6 +3478,12 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			if (ret < 0)
 				return ret;
 			break;
+		case BPF_LIST_HEAD:
+			ret = btf_find_list_head(btf, var, var_type, -1, off, sz,
+						 idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
 		default:
 			return -EFAULT;
 		}
@@ -3491,6 +3582,44 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 	return ret;
 }
 
+static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
+			       struct btf_field_info *info)
+{
+	const struct btf_type *t, *n = NULL;
+	const struct btf_member *member;
+	u32 offset;
+	int i;
+
+	t = btf_type_by_id(btf, info->list_head.value_btf_id);
+	/* We've already checked that value_btf_id is a struct type. We
+	 * just need to figure out the offset of the list_node, and
+	 * verify its type.
+	 */
+	for_each_member(i, t, member) {
+		if (strcmp(info->list_head.node_name, __btf_name_by_offset(btf, member->name_off)))
+			continue;
+		/* Invalid BTF, two members with same name */
+		if (n)
+			return -EINVAL;
+		n = btf_type_by_id(btf, member->type);
+		if (!__btf_type_is_struct(n))
+			return -EINVAL;
+		if (strcmp("bpf_list_node", __btf_name_by_offset(btf, n->name_off)))
+			return -EINVAL;
+		offset = __btf_member_bit_offset(n, member);
+		if (offset % 8)
+			return -EINVAL;
+		offset /= 8;
+		if (offset % __alignof__(struct bpf_list_node))
+			return -EINVAL;
+
+		field->list_head.btf = (struct btf *)btf;
+		field->list_head.value_btf_id = info->list_head.value_btf_id;
+		field->list_head.node_offset = offset;
+	}
+	return 0;
+}
+
 struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 					 const struct btf_type *t,
 					 u32 field_mask,
@@ -3542,6 +3671,11 @@ struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_LIST_HEAD:
+			ret = btf_parse_list_head(btf, &tab->fields[i], &info_arr[i]);
+			if (ret < 0)
+				goto end;
+			break;
 		default:
 			ret = -EFAULT;
 			goto end;
@@ -3550,6 +3684,13 @@ struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 		tab->cnt++;
 	}
 	tab->cnt = cnt;
+
+	/* bpf_list_head requires bpf_spin_lock */
+	if (btf_type_fields_has_field(tab, BPF_LIST_HEAD) && tab->spin_lock_off < 0) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	return tab;
 end:
 	btf_type_fields_free(tab);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8f425596b9c6..a2f2fe43916b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1700,6 +1700,38 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	}
 }
 
+void bpf_list_head_free(const struct btf_field *field, void *list_head,
+			struct bpf_spin_lock *spin_lock)
+{
+	struct list_head *head = list_head, *orig_head = head;
+	unsigned long flags;
+
+	BUILD_BUG_ON(sizeof(struct bpf_list_head) != sizeof(struct list_head));
+	BUILD_BUG_ON(__alignof__(struct bpf_list_head) != __alignof__(struct list_head));
+
+	/* __bpf_spin_lock_irqsave cannot be used here, as we may take a spin
+	 * lock again when we call bpf_obj_free_fields in the loop, and it will
+	 * overwrite the per-CPU local_irq_save state.
+	 */
+	local_irq_save(flags);
+	__bpf_spin_lock(spin_lock);
+	if (!head->next || list_empty(head))
+		goto unlock;
+	head = head->next;
+	while (head != orig_head) {
+		void *obj = head;
+
+		obj -= field->list_head.node_offset;
+		head = head->next;
+		/* TODO: Rework later */
+		kfree(obj);
+	}
+unlock:
+	INIT_LIST_HEAD(head);
+	__bpf_spin_unlock(spin_lock);
+	local_irq_restore(flags);
+}
+
 BTF_SET8_START(tracing_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3f3f9697d299..92486d777246 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -536,6 +536,9 @@ void btf_type_fields_free(struct btf_type_fields *tab)
 				module_put(tab->fields[i].kptr.module);
 			btf_put(tab->fields[i].kptr.btf);
 			break;
+		case BPF_LIST_HEAD:
+			/* Nothing to release for bpf_list_head */
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
@@ -578,6 +581,9 @@ struct btf_type_fields *btf_type_fields_dup(const struct btf_type_fields *tab)
 				goto free;
 			}
 			break;
+		case BPF_LIST_HEAD:
+			/* Nothing to acquire for bpf_list_head */
+			break;
 		default:
 			ret = -EFAULT;
 			WARN_ON_ONCE(1);
@@ -637,6 +643,11 @@ void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj)
 		case BPF_KPTR_REF:
 			field->kptr.dtor((void *)xchg((unsigned long *)field_ptr, 0));
 			break;
+		case BPF_LIST_HEAD:
+			if (WARN_ON_ONCE(tab->spin_lock_off < 0))
+				continue;
+			bpf_list_head_free(field, field_ptr, obj + tab->spin_lock_off);
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
@@ -965,7 +976,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (!value_type || value_size != map->value_size)
 		return -EINVAL;
 
-	map->fields_tab = btf_parse_fields(btf, value_type, BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR,
+	map->fields_tab = btf_parse_fields(btf, value_type,
+					   BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
 					   map->value_size);
 	if (!IS_ERR_OR_NULL(map->fields_tab)) {
 		int i;
@@ -1011,6 +1023,14 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 					goto free_map_tab;
 				}
 				break;
+			case BPF_LIST_HEAD:
+				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+				    map->map_type != BPF_MAP_TYPE_ARRAY) {
+					ret = -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				break;
 			default:
 				/* Fail if map_type checks are missing for a field type */
 				ret = -EOPNOTSUPP;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8660d08589c8..3c47cecda302 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12643,6 +12643,13 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
+	if (btf_type_fields_has_field(map->fields_tab, BPF_LIST_HEAD)) {
+		if (is_tracing_prog_type(prog_type)) {
+			verbose(env, "tracing progs cannot use bpf_list_head yet\n");
+			return -EINVAL;
+		}
+	}
+
 	if ((bpf_prog_is_dev_bound(prog->aux) || bpf_map_is_dev_bound(map)) &&
 	    !bpf_offload_prog_map_match(prog, map)) {
 		verbose(env, "offload device mismatch between prog and map\n");
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
new file mode 100644
index 000000000000..4e31790e433d
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -0,0 +1,23 @@
+#ifndef __KERNEL__
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+#else
+
+struct bpf_list_head {
+	__u64 __a;
+	__u64 __b;
+} __attribute__((aligned(8)));
+
+struct bpf_list_node {
+	__u64 __a;
+	__u64 __b;
+} __attribute__((aligned(8)));
+
+#endif
+
+#ifndef __KERNEL__
+#endif
-- 
2.38.0


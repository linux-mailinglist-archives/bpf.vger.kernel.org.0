Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8E618849
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKCTLF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKCTLE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60161F2FA
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id io19so2832887plb.8
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgmna5A56+CwH9G6iMb8+4cgI2GWA5uCGuvkzy84WSw=;
        b=fHo7wUJmLRWSiUxfnOlnWipACxwbLlmfJyYIZNcMrL8InQPxV1K9aR79i+U13xjg4t
         fhhx0Lstk853sIoH8B3NjVp7dfaFndH2805Pom3zs6NJfoMjgt7NqO1/KRc/LO4oRTuT
         u4JEwk++48oh2Ds3iye6/jT8m7hAAd13yIqOXCZwCgYfvHic8B1DLgL8m8QP0tTNtA+B
         Ye2w4qAzPythnWZezSCZPaFjwAGstGhOyxWik8RUhNRNxI/V2930YH+pzSefy4KZ7Y0A
         2OkP15F+yJGgdNHHadeIv2f9KHwzfQPHxdrpdB87dIgupCjEW7TK87yw1fPgfxAWspF/
         PF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgmna5A56+CwH9G6iMb8+4cgI2GWA5uCGuvkzy84WSw=;
        b=CQDYA44jCm2HQKUiQi5fsHqub/c31+ULLL9KiU4BciCvOg9CpHhRf6o1lTpE7p0NJE
         BzP0oEt8lw8Ucf6r8roetbwtb/nvgdGWdibqswAmfa30JMyjSMuyylrkRTPulmTLZ3o8
         DruRYtnwtIkgnI8rnFb2bHAbsQ1ExRwyhwgvtkQvUnvvqPXXQIuTnjlQ0X/6+iM6Sug8
         V4pCJYs0PxSUb3zYDu22pva//SG9jEoOkZ8xx/g10/MLS3zG6A+yRJ8YY0Jckadmwrrt
         Zqr27aAADrRy4TRNO1LDj05TWGksXFn2BPbSDtMoG7/9JZiYqY2tW6/T1g3ZjtHAvDDN
         sNrg==
X-Gm-Message-State: ACrzQf2kZQEbFWZzOFCjbFdgRvxF9sREmq6UNh2K4Kuhn1EZtgo1v/YL
        zYi7v5qhJe5tbRW80mmo38pgHfYyGlaOIw==
X-Google-Smtp-Source: AMsMyM5zcGWcwpamdLhxBy6zCHq1D5N5bd9hbGxBuHJXHfFiX6EW6P5vZOQhq1zKPoJb77QRK7576w==
X-Received: by 2002:a17:902:f691:b0:186:b250:9763 with SMTP id l17-20020a170902f69100b00186b2509763mr32232634plg.62.1667502661945;
        Thu, 03 Nov 2022 12:11:01 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id n62-20020a632741000000b0046feca0883fsm1057341pgn.64.2022.11.03.12.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:01 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 09/24] bpf: Support bpf_list_head in map values
Date:   Fri,  4 Nov 2022 00:39:58 +0530
Message-Id: <20221103191013.1236066-10-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15678; i=memxor@gmail.com; h=from:subject; bh=8ALFLCSJaIM3zUm0zLOuGInXM/xKyNnIXNNQmi823Dw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIA44Jp6wXtdNwMKyqeib8K2oJoC/tOHsd+iA7/ 8FLIpbuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RypC9D/ 9mkAbsmS4joGRulT3uE54IRxykLcLLzDE6Iwcv+98IDcOh0F+jeKd6aV13fN9gBmNu4JWBMEtEIwcx jFYeZnAYs3YSbzXjwrDmMmZbcUB+DA6n9TJzaXarPd//ui+Z82crqAbsf+cimnh1XMDIXcr6OSMe0U Ls+ScCxVdhjRocIzIcThEm4+JhvC9ZK4q/e3F8lkeVDQQ8xjBrEsRfj0tmRfnf86NUZ+jtdFlGzBOS dkOhKxQ0uLRRkK91rVJXfeU6XIrnbWqzRd0gKxS2DXzN7FQ2ML54KPyAgDmaTMKjz3vnQaFWX+hDKG KJsBwyy1F7Mvrnak4HJt5TlYsNhHdgqXeCO2T3GzL1OV40RwWd/U2G9c+wiFeUOHXW1VzYT1zZMZ8M VIMct+l0yjxzPOr+YpPa7c6rtfL5cJNJ40Hc+aC3imPSKvoZpEIwlyTQp/vMhJ88ZcrcrQe1QPQ6a4 +ZDuttEq7Am+za/0c6LxgMbem+cqpQUcoNFDGwJzu4JYu+q40KxG2cp94ctw3ZN1U/sbaJF2TGjlh3 VAV1xkuOqkuEM0ga5lKZ8fz09Qf7evGwHM0U1LEdx+d0XyJNSqj/WlZG8EjvhVa4TKHGw1OjAsTc0x NySNitc4eXorltVRQKv/yJfP5wiMqs9ooex4VwcmaFoe1BfxZ9oeVV1neFdQ==
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
parts, "contains:name:node" where the name is then used to look up the
type in the map BTF, with its kind hardcoded to BTF_KIND_STRUCT during
the lookup. The node defines name of the member in this type that has
the type struct bpf_list_node, which is actually used for linking into
the linked list. For now, 'kind' part is hardcoded as struct.

This allows building intrusive linked lists in BPF, using container_of
to obtain pointer to entry, while being completely type safe from the
perspective of the verifier. The verifier knows exactly the type of the
nodes, and knows that list helpers return that type at some fixed offset
where the bpf_list_node member used for this list exists. The verifier
also uses this information to disallow adding types that are not
accepted by a certain list.

For now, no elements can be added to such lists. Support for that is
coming in future patches, hence draining and freeing items is done with
a TODO that will be resolved in a future patch.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |  17 ++++
 include/uapi/linux/bpf.h       |  10 +++
 kernel/bpf/btf.c               | 144 ++++++++++++++++++++++++++++++++-
 kernel/bpf/helpers.c           |  32 ++++++++
 kernel/bpf/syscall.c           |  22 ++++-
 kernel/bpf/verifier.c          |   7 ++
 tools/include/uapi/linux/bpf.h |  10 +++
 7 files changed, 238 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bb96bf947e53..2d9ebe9efcad 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -176,6 +176,7 @@ enum btf_field_type {
 	BPF_KPTR_UNREF = (1 << 2),
 	BPF_KPTR_REF   = (1 << 3),
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
+	BPF_LIST_HEAD  = (1 << 4),
 };
 
 struct btf_field_kptr {
@@ -185,11 +186,18 @@ struct btf_field_kptr {
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
 
@@ -267,6 +275,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return "kptr";
+	case BPF_LIST_HEAD:
+		return "bpf_list_head";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -283,6 +293,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return sizeof(u64);
+	case BPF_LIST_HEAD:
+		return sizeof(struct bpf_list_head);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -299,6 +311,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return __alignof__(u64);
+	case BPF_LIST_HEAD:
+		return __alignof__(struct bpf_list_head);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -404,6 +418,9 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
 void bpf_timer_cancel_and_free(void *timer);
+void bpf_list_head_free(const struct btf_field *field, void *list_head,
+			struct bpf_spin_lock *spin_lock);
+
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
 struct bpf_offload_dev;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 94659f6b3395..dd381086bad9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6887,6 +6887,16 @@ struct bpf_dynptr {
 	__u64 :64;
 } __attribute__((aligned(8)));
 
+struct bpf_list_head {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
+struct bpf_list_node {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 197687c86dc1..e56025505467 100644
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
@@ -3261,6 +3267,66 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
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
+	list_node = strstr(value_type, ":");
+	if (!list_node)
+		return -EINVAL;
+	value_type = kstrndup(value_type, list_node - value_type, GFP_KERNEL | __GFP_NOWARN);
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
@@ -3284,6 +3350,12 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
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
@@ -3317,6 +3389,8 @@ static int btf_find_struct_field(const struct btf *btf,
 			return field_type;
 
 		off = __btf_member_bit_offset(t, member);
+		if (i && !off)
+			return -EFAULT;
 		if (off % 8)
 			/* valid C code cannot generate such BTF */
 			return -EINVAL;
@@ -3339,6 +3413,12 @@ static int btf_find_struct_field(const struct btf *btf,
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
@@ -3373,6 +3453,8 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			return field_type;
 
 		off = vsi->offset;
+		if (i && !off)
+			return -EFAULT;
 		if (vsi->size != sz)
 			continue;
 		if (off % align)
@@ -3393,6 +3475,12 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
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
@@ -3491,6 +3579,44 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
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
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
@@ -3539,12 +3665,24 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_LIST_HEAD:
+			ret = btf_parse_list_head(btf, &rec->fields[i], &info_arr[i]);
+			if (ret < 0)
+				goto end;
+			break;
 		default:
 			ret = -EFAULT;
 			goto end;
 		}
 		rec->cnt++;
 	}
+
+	/* bpf_list_head requires bpf_spin_lock */
+	if (btf_record_has_field(rec, BPF_LIST_HEAD) && rec->spin_lock_off < 0) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	return rec;
 end:
 	btf_record_free(rec);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 283f55bbeb70..339cce94b408 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1706,6 +1706,38 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	}
 }
 
+void bpf_list_head_free(const struct btf_field *field, void *list_head,
+			struct bpf_spin_lock *spin_lock)
+{
+	struct list_head *head = list_head, *orig_head = head;
+	unsigned long flags;
+
+	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
+	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
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
index 85532d301124..fdbae52f463f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -536,6 +536,9 @@ void btf_record_free(struct btf_record *rec)
 				module_put(rec->fields[i].kptr.module);
 			btf_put(rec->fields[i].kptr.btf);
 			break;
+		case BPF_LIST_HEAD:
+			/* Nothing to release for bpf_list_head */
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
@@ -578,6 +581,9 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 				goto free;
 			}
 			break;
+		case BPF_LIST_HEAD:
+			/* Nothing to acquire for bpf_list_head */
+			break;
 		default:
 			ret = -EFAULT;
 			WARN_ON_ONCE(1);
@@ -637,6 +643,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		case BPF_KPTR_REF:
 			field->kptr.dtor((void *)xchg((unsigned long *)field_ptr, 0));
 			break;
+		case BPF_LIST_HEAD:
+			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
+				continue;
+			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
@@ -965,7 +976,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (!value_type || value_size != map->value_size)
 		return -EINVAL;
 
-	map->record = btf_parse_fields(btf, value_type, BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR,
+	map->record = btf_parse_fields(btf, value_type,
+				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1012,6 +1024,14 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
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
index 73a3516f1a48..168cd8bb9fd6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12643,6 +12643,13 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
+	if (btf_record_has_field(map->record, BPF_LIST_HEAD)) {
+		if (is_tracing_prog_type(prog_type)) {
+			verbose(env, "tracing progs cannot use bpf_list_head yet\n");
+			return -EINVAL;
+		}
+	}
+
 	if ((bpf_prog_is_dev_bound(prog->aux) || bpf_map_is_dev_bound(map)) &&
 	    !bpf_offload_prog_map_match(prog, map)) {
 		verbose(env, "offload device mismatch between prog and map\n");
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 94659f6b3395..dd381086bad9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6887,6 +6887,16 @@ struct bpf_dynptr {
 	__u64 :64;
 } __attribute__((aligned(8)));
 
+struct bpf_list_head {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
+struct bpf_list_node {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
 				 * Allows 1,2,4-byte read, but no write.
-- 
2.38.1


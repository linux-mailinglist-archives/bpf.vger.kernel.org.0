Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090AE6261FA
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiKKTdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiKKTdT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:19 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3A779D09
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:17 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o13so5118605pgu.7
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFePjJAHPjAYwZJgMSRWyERIm/Ls7dFNVc7DC7N9KCo=;
        b=XHwjYOLUIsHB4uO2afJmShl+3dZt3D743dzOi3hIcTC8SHtbtOIErXpdI2V50x/7fi
         3PYBSre6kenySSks7SGTiyQJe0botJdV1U7138nyHzmchD0vemKVZP12DkXCmQipfsGm
         M7Xg77MEHCn/ZSeIIfkSmSq4EviZ8DH6zOXiK95kJ9cp84rFBs5XBcs/edhLRLHrpy1l
         DZRnP0RQf7+Ij0SWN3DA0HwbFDJ3ssa1qNvfRazXi8IWIWHssGK9DABb0c3ktmIM8J9x
         ZBAPZQ3l52SoqViHGVplZWXnWcSnT4WR9P7e/eOy3uz9GrSdzUomK3bDopqXcZ6bmD9r
         YhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFePjJAHPjAYwZJgMSRWyERIm/Ls7dFNVc7DC7N9KCo=;
        b=BXHKeHMMX1JR/5qfDk2GUlHr6PJtEUCrP/VxgXgkUZ29RFLjNxFfu9R7RtLUuQ/vab
         SdJJv2wKpx7Jh0QtzLvAvHyayJYDEOZoPJab6CleHl8IV2unhV420fLh7bCz6RTHb5p+
         PhzbZ6Q9kDMVTzs2+aaygI6o4048CtfcKbZdXkoCs0NDjLDOAsug2zi3QdFLRejsLGSm
         8yXVHZ7BTG3avlZ8BJERbEjosUcxP6z/4gocxxG+wO4Ik0jGZp7BwbquX6I6mrKHmXMr
         EYGiBsah5/kDVutznJ64ezsPZEFcfXB1iuFuthg0fmynY5MX2dD/PB1GNmOkxADLCct9
         cjhw==
X-Gm-Message-State: ANoB5pma93GeE85Wp/QaHVNv9aL//rTzZ49eI7nixq49Ap03cPW4PNwj
        pR8egZgF3IGMUYzb7599dqeGB1eIFWu8RA==
X-Google-Smtp-Source: AA0mqf4A7RWq0CMmSWvrbIhIMT7+s9HJYOqGEzlX6EPD9JR8kMy4IukBVuMmhTvfm9KYqoYQqp4lsg==
X-Received: by 2002:a63:5b5b:0:b0:46e:dc0a:ba96 with SMTP id l27-20020a635b5b000000b0046edc0aba96mr2995275pgm.419.1668195196738;
        Fri, 11 Nov 2022 11:33:16 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id i13-20020a056a00004d00b0056286c552ecsm1932333pfk.184.2022.11.11.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 04/26] bpf: Support bpf_list_head in map values
Date:   Sat, 12 Nov 2022 01:02:02 +0530
Message-Id: <20221111193224.876706-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16631; i=memxor@gmail.com; h=from:subject; bh=hjbmIBlRmEo7a2ts8DdFZUrI4CFe+Q1/4QATKUQTqZQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqInXouMquh+40o9Xor5anaRd5Wm+cIeVRsbjfhY I36ntuaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iJwAKCRBM4MiGSL8Ryo2oD/ 0XvyAA5LytcBuyrD/RRxlynKE22onV1CgieRqUuuTRzR2FYIDPU1U8j8dcLBVNX/bipin3UVCgHHS6 e4bcVL78OS9sQawUh79hWpvrFRm2tCt1CqH+clSZ7jkfbDpz6ccB7L388g3idgz/0R4IVKxSahclRJ nuWfM4UkHct2ySqHN+iN+tK6Rql+HxaFx9sxuUfouNvOA0abhDq8o/DyjnacoesSfjrw9AA8DiiK0x WFPaY8+quIWWIUkdxsw7CIKB/9a1JTKwK+lArOan2TUu4BSnaSnLc2EI023qNE+XKUcwlGnDXBSaEK f1CJTJBX4jCijPOQI7YJx/q9oeFAkyDZlww2cCmp5pvGMTqzQoEuyeU3pyi2ZXs1yKCSF60UCEQ8Lv Bjk7HcKpb8NGeqizdXka0Q1TiyTAhxmq+rFCvXpLcHadG2TjCac1d9rJYspw0OTbVA/cgb9o1Y9Yg1 6HstT7cK9fQIGTNQh0qlbNnAEXLEJpuK4QI1UscsiVM5F/W2NVuuN0nGOQ0qbM7B6U2EOk2yBsRuWe Z0mFFdmK19wm1lfy2h0XvmlrwxUkOjPAeSGcQeq5ZlwOmzUA3qxPXAlb+JEiw/KiK4V7W/Uo8C3N6T yqKd/jDbUxy6qRUJ/dXJUWcbL6GQtbHAAmIrE6qWcpxBYZwdIoFj2PVl0JyA==
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

Add the support on the map side to parse, recognize, verify, and build
metadata table for a new special field of the type struct bpf_list_head.
To parameterize the bpf_list_head for a certain value type and the
list_node member it will accept in that value type, we use BTF
declaration tags.

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

Note that the bpf_list_head_free function moves the list out to a local
variable under the lock and releases it, doing the actual draining of
the list items outside the lock. While this helps with not holding the
lock for too long pessimizing other concurrent list operations, it is
also necessary for deadlock prevention: unless every function called in
the critical section would be notrace, a fentry/fexit program could
attach and call bpf_map_update_elem again on the map, leading to the
same lock being acquired if the key matches and lead to a deadlock.
While this requires some special effort on part of the BPF programmer to
trigger and is highly unlikely to occur in practice, it is always better
if we can avoid such a condition.

While notrace would prevent this, doing the draining outside the lock
has advantages of its own, hence it is used to also fix the deadlock
related problem.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |  17 ++++
 include/uapi/linux/bpf.h       |  10 +++
 kernel/bpf/btf.c               | 145 ++++++++++++++++++++++++++++++++-
 kernel/bpf/helpers.c           |  32 ++++++++
 kernel/bpf/syscall.c           |  22 ++++-
 kernel/bpf/verifier.c          |   7 ++
 tools/include/uapi/linux/bpf.h |  10 +++
 7 files changed, 239 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f08eb2d27de0..05f98e9e5c48 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -175,6 +175,7 @@ enum btf_field_type {
 	BPF_KPTR_UNREF = (1 << 2),
 	BPF_KPTR_REF   = (1 << 3),
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
+	BPF_LIST_HEAD  = (1 << 4),
 };
 
 struct btf_field_kptr {
@@ -184,11 +185,18 @@ struct btf_field_kptr {
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
 
@@ -266,6 +274,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return "kptr";
+	case BPF_LIST_HEAD:
+		return "bpf_list_head";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -282,6 +292,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return sizeof(u64);
+	case BPF_LIST_HEAD:
+		return sizeof(struct bpf_list_head);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -298,6 +310,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return __alignof__(u64);
+	case BPF_LIST_HEAD:
+		return __alignof__(struct bpf_list_head);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -403,6 +417,9 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
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
index 12361d7b2498..c0d73d71c539 100644
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
@@ -3261,6 +3267,63 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
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
@@ -3284,6 +3347,12 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
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
@@ -3339,6 +3408,12 @@ static int btf_find_struct_field(const struct btf *btf,
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
@@ -3393,6 +3468,12 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
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
@@ -3491,11 +3572,52 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
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
+	if (!n)
+		return -ENOENT;
+	return 0;
+}
+
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
 	struct btf_field_info info_arr[BTF_FIELDS_MAX];
 	struct btf_record *rec;
+	u32 next_off = 0;
 	int ret, i, cnt;
 
 	ret = btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_arr));
@@ -3517,6 +3639,11 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			ret = -EFAULT;
 			goto end;
 		}
+		if (info_arr[i].off < next_off) {
+			ret = -EEXIST;
+			goto end;
+		}
+		next_off = info_arr[i].off + btf_field_type_size(info_arr[i].type);
 
 		rec->field_mask |= info_arr[i].type;
 		rec->fields[i].offset = info_arr[i].off;
@@ -3539,12 +3666,24 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
index 283f55bbeb70..7bc71995f17c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1706,6 +1706,38 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	}
 }
 
+void bpf_list_head_free(const struct btf_field *field, void *list_head,
+			struct bpf_spin_lock *spin_lock)
+{
+	struct list_head *head = list_head, *orig_head = list_head;
+
+	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
+	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
+
+	/* Do the actual list draining outside the lock to not hold the lock for
+	 * too long, and also prevent deadlocks if tracing programs end up
+	 * executing on entry/exit of functions called inside the critical
+	 * section, and end up doing map ops that call bpf_list_head_free for
+	 * the same map value again.
+	 */
+	__bpf_spin_lock_irqsave(spin_lock);
+	if (!head->next || list_empty(head))
+		goto unlock;
+	head = head->next;
+unlock:
+	INIT_LIST_HEAD(orig_head);
+	__bpf_spin_unlock_irqrestore(spin_lock);
+
+	while (head != orig_head) {
+		void *obj = head;
+
+		obj -= field->list_head.node_offset;
+		head = head->next;
+		/* TODO: Rework later */
+		kfree(obj);
+	}
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
index d3b75aa0c54d..0374f03d1f56 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12805,6 +12805,13 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
+	if (btf_record_has_field(map->record, BPF_LIST_HEAD)) {
+		if (is_tracing_prog_type(prog_type)) {
+			verbose(env, "tracing progs cannot use bpf_list_head yet\n");
+			return -EINVAL;
+		}
+	}
+
 	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
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


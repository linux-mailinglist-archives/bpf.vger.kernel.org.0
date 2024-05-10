Return-Path: <bpf+bounces-29524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFBA8C2A84
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC521F23BC7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45FD5026E;
	Fri, 10 May 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAEiTwa6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E524DA0C;
	Fri, 10 May 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369060; cv=none; b=qL2oQln4tpIPy9JjjGKd6A986Hq7HZB4UZ4GdsCr7M+V+H9Etee1VOf/K6168NsxrPDzxTIvDJr6NuACQBiwUGiRROM++NqbAcH3c3OxvJKMACWfcztqgSK9j+bEoKbVlT8X4UuJnNOMD8+Oi8lvlimGWQFQEAEbIQ3RSZv4OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369060; c=relaxed/simple;
	bh=78O1fK/GWjByrVCvMdKfc79ioEJO6ct+eeRphv1z7IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nk2I5eQ7BFF6QA7+qspkwc6NPHGsmSte7SnlBLU5EIjrHl08/8FYAm8t1TiSIuAHUzVq5YQZBzW8x78oDVRM4LgJa4Gtc5yVeY/DqkF2ad54Zug8u0HKrtBbfbmioDkEbu9joyeFkMzEgEvGbLG4zbg35ZFW4pZuhJj0jrid0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAEiTwa6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43d4538b16fso7992601cf.2;
        Fri, 10 May 2024 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369057; x=1715973857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHnVB9wqlBS1hWFoiolkVuBl1TTtjZBWgIt5tZVd4p4=;
        b=cAEiTwa6Q9dlihhuWVtDf+lkMxCpl5X1j/gmjEN6TKkedlJwF99l5jB5nzDqK7dPpi
         jD8sGhOParXkkG59u9rIjE1Iw09gFryUmNmvIUi4Qk2IffsToZ5ecMxWGfj0mNuJ9E4z
         J0oLBmlgVt6m8k03FIOIK4G2qsMW5fC30Vo1dYRRT9CpJqOKLlinlIFKL0DwoeifN/9p
         tZUggDGf9lUSHblmivjX/4VNpe4hTq6XaWX7leja2PYv3QKvWJm5dJ8YHNVecBlA7B9Q
         4/zWQ0Gob5lABJ06kc5RvOqOm2a32ED6BsyXE/73TPz0i7ORWGnvrOyDbLTKToa6GQqW
         4ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369057; x=1715973857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHnVB9wqlBS1hWFoiolkVuBl1TTtjZBWgIt5tZVd4p4=;
        b=rhF954kMsH+vaTkIqCRBWE59xdrjRs7r4TMdxQSN1v5FyIaBoFnlZ6MlG9VRAoQBLg
         Tf4rhXqWx953uEbggjgzKjwFiEQE96Ko1jSOwQ7Pjy+yJt0WPMRsXY2W2g/Rqn9vmvy5
         wFvwej+YFYbP/L26cIqCo6xwzbLuhAEXbQluh0vgqZNLDBgwCWeDlGOubNyassgPhxIB
         rVpzQG20iS7Ok3CO+SxuZIEDfWzVQwgEDtfmOFw8lNWqjvhzhS87CRcA/NGNDnXK4REA
         ENZJyyG9rFZe5deCwUeHFdMqp5nzIryRXGN6ya920e+1ZKh6so+tN6JoUfCXlADhERB+
         Fusw==
X-Gm-Message-State: AOJu0Yz1fTTsShvDs2E+0ooxiRa10bJ3JjSyEdNX9LK4vDS6XKTYSFOY
	KJ78WXEJgyQqpSnbdSoQJGrEJ8X9QhAGrlXxdaesbABzJj7GQ2Rnyr8ZUQ==
X-Google-Smtp-Source: AGHT+IFuuRfA0Vq97IXe4fcfze9EwMIXXr90yLUiW+tK0dOBSBN5CD6++tu3Ju08PfH+q5hTt3gxVg==
X-Received: by 2002:a05:622a:1193:b0:43d:f840:52d1 with SMTP id d75a77b69052e-43dfdd0c2damr36627341cf.60.1715369057308;
        Fri, 10 May 2024 12:24:17 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [RFC PATCH v8 06/20] bpf: Recognize kernel types as graph values
Date: Fri, 10 May 2024 19:23:58 +0000
Message-Id: <20240510192412.3297104-7-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240510192412.3297104-1-amery.hung@bytedance.com>
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch teaches bpf to recognize graphs that contain kernel objects
as graph values. BPF programs can use a new BTF declaration tag
"contain_kptr" to signal that the value of a graph will be a kernel type.
"contains_kptr" follows the same annotation format as "contains".

For the implementation, when the value is a kernel type, we uses kernel
BTF for node and roots as well so that we don't need to match the same
type in different BTF. Since graph values can be kernel types, we can
no longer make the assumption that the BTF is from programs when finding
and parsing graph nodes and roots. Therefore, we record the BTF of a
node in btf_field_info and use it later.

No kernel object can be added to bpf graphs yet. In later patches,
we will teach the verifier to allow moving kptr in and out collections.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/btf.h                           |  4 +-
 kernel/bpf/btf.c                              | 49 ++++++++++++-------
 kernel/bpf/syscall.c                          |  2 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  1 +
 4 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9e56fd12a9f..2579b8a51172 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -219,7 +219,7 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size);
-int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
+int btf_check_and_fixup_fields(struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p);
@@ -569,7 +569,7 @@ static inline int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dt
 {
 	return 0;
 }
-static inline struct btf_struct_meta *btf_find_struct_meta(const struct btf *btf, u32 btf_id)
+static inline struct btf_struct_meta *btf_find_struct_meta(u32 btf_id)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5ee6ccc2fab7..37fb6143da79 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3296,6 +3296,7 @@ struct btf_field_info {
 		struct {
 			const char *node_name;
 			u32 value_btf_id;
+			const struct btf *btf;
 		} graph_root;
 	};
 };
@@ -3405,7 +3406,9 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 		    enum btf_field_type head_type)
 {
 	const char *node_field_name;
+	bool value_is_kptr = false;
 	const char *value_type;
+	struct btf *kptr_btf;
 	s32 id;
 
 	if (!__btf_type_is_struct(t))
@@ -3413,15 +3416,26 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 	if (t->size != sz)
 		return BTF_FIELD_IGNORE;
 	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
-	if (IS_ERR(value_type))
-		return -EINVAL;
+	if (!IS_ERR(value_type))
+		goto found;
+	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains_kptr:");
+	if (!IS_ERR(value_type)) {
+		value_is_kptr = true;
+		goto found;
+	}
+	return -EINVAL;
+found:
 	node_field_name = strstr(value_type, ":");
 	if (!node_field_name)
 		return -EINVAL;
 	value_type = kstrndup(value_type, node_field_name - value_type, GFP_KERNEL | __GFP_NOWARN);
 	if (!value_type)
 		return -ENOMEM;
-	id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
+	if (value_is_kptr)
+		id = bpf_find_btf_id(value_type, BTF_KIND_STRUCT, &kptr_btf);
+	else
+		id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
+
 	kfree(value_type);
 	if (id < 0)
 		return id;
@@ -3431,6 +3445,7 @@ btf_find_graph_root(const struct btf *btf, const struct btf_type *pt,
 	info->type = head_type;
 	info->off = off;
 	info->graph_root.value_btf_id = id;
+	info->graph_root.btf = value_is_kptr ? kptr_btf : btf;
 	info->graph_root.node_name = node_field_name;
 	return BTF_FIELD_FOUND;
 }
@@ -3722,13 +3737,13 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 	return ret;
 }
 
-static int btf_parse_graph_root(const struct btf *btf,
-				struct btf_field *field,
+static int btf_parse_graph_root(struct btf_field *field,
 				struct btf_field_info *info,
 				const char *node_type_name,
 				size_t node_type_align)
 {
 	const struct btf_type *t, *n = NULL;
+	const struct btf *btf = info->graph_root.btf;
 	const struct btf_member *member;
 	u32 offset;
 	int i;
@@ -3766,18 +3781,16 @@ static int btf_parse_graph_root(const struct btf *btf,
 	return 0;
 }
 
-static int btf_parse_list_head(const struct btf *btf, struct btf_field *field,
-			       struct btf_field_info *info)
+static int btf_parse_list_head(struct btf_field *field, struct btf_field_info *info)
 {
-	return btf_parse_graph_root(btf, field, info, "bpf_list_node",
-					    __alignof__(struct bpf_list_node));
+	return btf_parse_graph_root(field, info, "bpf_list_node",
+				    __alignof__(struct bpf_list_node));
 }
 
-static int btf_parse_rb_root(const struct btf *btf, struct btf_field *field,
-			     struct btf_field_info *info)
+static int btf_parse_rb_root(struct btf_field *field, struct btf_field_info *info)
 {
-	return btf_parse_graph_root(btf, field, info, "bpf_rb_node",
-					    __alignof__(struct bpf_rb_node));
+	return btf_parse_graph_root(field, info, "bpf_rb_node",
+				    __alignof__(struct bpf_rb_node));
 }
 
 static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
@@ -3859,12 +3872,12 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 				goto end;
 			break;
 		case BPF_LIST_HEAD:
-			ret = btf_parse_list_head(btf, &rec->fields[i], &info_arr[i]);
+			ret = btf_parse_list_head(&rec->fields[i], &info_arr[i]);
 			if (ret < 0)
 				goto end;
 			break;
 		case BPF_RB_ROOT:
-			ret = btf_parse_rb_root(btf, &rec->fields[i], &info_arr[i]);
+			ret = btf_parse_rb_root(&rec->fields[i], &info_arr[i]);
 			if (ret < 0)
 				goto end;
 			break;
@@ -3901,7 +3914,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
 
-int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
+int btf_check_and_fixup_fields(struct btf_record *rec)
 {
 	int i;
 
@@ -3917,11 +3930,13 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
 		return 0;
 	for (i = 0; i < rec->cnt; i++) {
 		struct btf_struct_meta *meta;
+		struct btf *btf;
 		u32 btf_id;
 
 		if (!(rec->fields[i].type & BPF_GRAPH_ROOT))
 			continue;
 		btf_id = rec->fields[i].graph_root.value_btf_id;
+		btf = rec->fields[i].graph_root.btf;
 		meta = btf_find_struct_meta(btf, btf_id);
 		if (!meta)
 			return -EFAULT;
@@ -5630,7 +5645,7 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		int i;
 
 		for (i = 0; i < struct_meta_tab->cnt; i++) {
-			err = btf_check_and_fixup_fields(btf, struct_meta_tab->types[i].record);
+			err = btf_check_and_fixup_fields(struct_meta_tab->types[i].record);
 			if (err < 0)
 				goto errout_meta;
 		}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e44c276e8617..9e93d48efe19 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1157,7 +1157,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 		}
 	}
 
-	ret = btf_check_and_fixup_fields(btf, map->record);
+	ret = btf_check_and_fixup_fields(map->record);
 	if (ret < 0)
 		goto free_map_tab;
 
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index a5b9df38c162..a4da75df819c 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -7,6 +7,7 @@
 #include <bpf/bpf_core_read.h>
 
 #define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+#define __contains_kptr(name, node) __attribute__((btf_decl_tag("contains_kptr:" #name ":" #node)))
 
 /* Description
  *	Allocates an object of the type represented by 'local_type_id' in
-- 
2.20.1



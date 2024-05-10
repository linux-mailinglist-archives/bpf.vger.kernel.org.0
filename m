Return-Path: <bpf+bounces-29532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F38C2A93
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E231C20DD7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8FE502B1;
	Fri, 10 May 2024 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq1djXYV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400D50A87;
	Fri, 10 May 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369065; cv=none; b=pcJP0Bf7Md3T2kPxy86be2+qBkqZXX60c0+PV2xNstnXvZ35rD8vukZGBst/UHE3AUvXDNttojwmMXUCDYtjhlfM4t3qqWVayeo34VmMv8HUD34tjma/W36wgpmKQOss2KZUlWDxFU8WAHKOytFpc8TzKgrpScjBE9iaP0VdMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369065; c=relaxed/simple;
	bh=0ABJ9EGtHlMzRO8t2wR9+4kAyrBkPtWe5FOnV9rV9/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQuHDDnL7hCprpR9ziZG5GoIOaXU0TIgZ2ugGddZ5Inlg2aMrQrVtlswzgLbA7wlJMoKD8suKRO8R+t4fiUZ9xlX8B5Qukd713B80hosiyHspABBkEOCexC9q7nb5cjOJutBSJdqEIsGvkqprA8Cnj4b9UHrhk0vSlOIOc/Kd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq1djXYV; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43de92e234dso24396381cf.1;
        Fri, 10 May 2024 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715369061; x=1715973861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY/IGGUIFdyzwo5w0wCes/hxX7mNMzc6kH+nYlLXTM0=;
        b=Nq1djXYVzp+i3KaMRrW72BOZutNurQV2l1C59sah9hzXibjIwpMf1V5tkRjo3alQpY
         w6ivTkWvpGAjCpSBDSZfTBe4udGmrCbCscZSDM80a/To53poQP8BP7ulp78Ce67GIae7
         LHFcMxO2Bpv9EbPXtK5x8I282QmB9d3BSKEEuMgr4VV56I/H2MtVh4rYYcAHpDrhvITP
         NpiyeNHNDBkHdO6uX3gZ3XO2vPFJDSFfRRg701IJFwKP7+3vXuRHm81MZHJPCtqKUGz/
         LR6AWeug7P/yPFlDvgBsUVYArT0adGqzQKun/Qekx1whM5W9DxrxO5uFx5iVy52WaOkg
         a3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715369061; x=1715973861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BY/IGGUIFdyzwo5w0wCes/hxX7mNMzc6kH+nYlLXTM0=;
        b=q7UDYPSuguqlcx1ok+d3EL5g7ENMiSBi4UQV+EPIX6gJOcoKoliekxU/ZHmP9eXDP5
         RdEBz7XjzXA1y0vCmppyhA5rOmZVVqJRq/bQysnmzgRYdnDv9shCsn1Eg6oQVCNtlQNC
         a2sorryg+S89CDsJODvSsKIrWtRvoQT8sk8u7LOX8usmAg87SwOBSqSz+7efZnSwoXUq
         V0Rxnoi5V96ng5Lg3u6pxB5fTyARPdQBneEMquBGRVmYmXzCl97Z9HpDvjsu9gxn3w9F
         fnkCiNWmXLlbciy0uyb0spxe3RSyTyVaThuczqfqMVvqQQSpDCXP/Ho4latFQCCGJzK2
         so/Q==
X-Gm-Message-State: AOJu0Yzkfj3ziNTq8VtkIdG9zebbFxvBOnx4Yccv1XKtBv07GP0kPFQU
	4o+906/qAMX9nK82aCNk1aTApXoHw7qT+gEJPr7INnn3+Y/EHsP9RHTE4w==
X-Google-Smtp-Source: AGHT+IHDloUvoXMyn50szuMjCDLkltoo8/ncszUXxwdABD5IOz67IM+jNMNmQPUpiaJOeVDcnFmYjQ==
X-Received: by 2002:a05:622a:152:b0:43a:f5db:88b8 with SMTP id d75a77b69052e-43dfce260ebmr58982781cf.24.1715369059804;
        Fri, 10 May 2024 12:24:19 -0700 (PDT)
Received: from n36-183-057.byted.org ([147.160.184.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df5b46a26sm23863251cf.80.2024.05.10.12.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 12:24:19 -0700 (PDT)
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
Subject: [RFC PATCH v8 10/20] bpf: Introduce exclusive-ownership list and rbtree nodes
Date: Fri, 10 May 2024 19:24:02 +0000
Message-Id: <20240510192412.3297104-11-amery.hung@bytedance.com>
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

This patch reintroduces the semantic of exclusive ownership of a
reference. The main motivation is to save spaces and avoid changing
kernel structure layout. Existing bpf graph nodes add an additional
owner field to list_head and rb_node to safely support shared ownership
of a reference. The previous patch supports adding kernel objects to
collections by including bpf_list_node or bpf_rb_node in a kernel
structure same as user-defined local objects. However, some kernel
objects' layout have been optimized through out the years and cannot be
easily changed. For example, a bpf_rb_node cannot be added in the union
at offset=0 in sk_buff since bpf_rb_node is larger than other members.
Exclusive ownership solves the problem as "owner" is no longer needed
and both graph nodes can be at the same offset.

To achieve this, bpf_list_excl_node and bpf_rb_excl_node are first
introduced. They simply wrap list_head and rb_node, and serve as
annotations in BTF. Then, we make sure that they cannot co-exist with
bpf_refcount, bpf_list_node and bpf_rb_nodes in the same structure when
parsing btf. This will prevent the user from acquiring more than one
reference to a object with a exclusive node.

No exclusive node can be added to collection yet. We will teach the
verifier to accept exclusive nodes as valid nodes and then skip the
ownership checks in graph kfuncs.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/linux/bpf.h          | 27 ++++++++++++---
 include/linux/rbtree_types.h |  4 +++
 include/linux/types.h        |  4 +++
 kernel/bpf/btf.c             | 64 +++++++++++++++++++++++++++++++++---
 kernel/bpf/syscall.c         | 20 +++++++++--
 5 files changed, 108 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6aabca1581fe..49c29c823fb3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -197,11 +197,16 @@ enum btf_field_type {
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF | BPF_KPTR_PERCPU,
 	BPF_LIST_HEAD  = (1 << 5),
 	BPF_LIST_NODE  = (1 << 6),
-	BPF_RB_ROOT    = (1 << 7),
-	BPF_RB_NODE    = (1 << 8),
-	BPF_GRAPH_NODE = BPF_RB_NODE | BPF_LIST_NODE,
+	BPF_LIST_EXCL_NODE = (1 << 7),
+	BPF_RB_ROOT    = (1 << 8),
+	BPF_RB_NODE    = (1 << 9),
+	BPF_RB_EXCL_NODE = (1 << 10),
+	BPF_GRAPH_EXCL_NODE = BPF_RB_EXCL_NODE | BPF_LIST_EXCL_NODE,
+	BPF_GRAPH_NODE = BPF_RB_NODE | BPF_LIST_NODE |
+			 BPF_RB_EXCL_NODE | BPF_LIST_EXCL_NODE,
 	BPF_GRAPH_ROOT = BPF_RB_ROOT | BPF_LIST_HEAD,
-	BPF_REFCOUNT   = (1 << 9),
+	BPF_GRAPH_NODE_OR_ROOT = BPF_GRAPH_NODE | BPF_GRAPH_ROOT,
+	BPF_REFCOUNT   = (1 << 11),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -321,10 +326,14 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_list_head";
 	case BPF_LIST_NODE:
 		return "bpf_list_node";
+	case BPF_LIST_EXCL_NODE:
+		return "bpf_list_excl_node";
 	case BPF_RB_ROOT:
 		return "bpf_rb_root";
 	case BPF_RB_NODE:
 		return "bpf_rb_node";
+	case BPF_RB_EXCL_NODE:
+		return "bpf_rb_excl_node";
 	case BPF_REFCOUNT:
 		return "bpf_refcount";
 	default:
@@ -348,10 +357,14 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_list_head);
 	case BPF_LIST_NODE:
 		return sizeof(struct bpf_list_node);
+	case BPF_LIST_EXCL_NODE:
+		return sizeof(struct bpf_list_excl_node);
 	case BPF_RB_ROOT:
 		return sizeof(struct bpf_rb_root);
 	case BPF_RB_NODE:
 		return sizeof(struct bpf_rb_node);
+	case BPF_RB_EXCL_NODE:
+		return sizeof(struct bpf_rb_excl_node);
 	case BPF_REFCOUNT:
 		return sizeof(struct bpf_refcount);
 	default:
@@ -375,10 +388,14 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_list_head);
 	case BPF_LIST_NODE:
 		return __alignof__(struct bpf_list_node);
+	case BPF_LIST_EXCL_NODE:
+		return __alignof__(struct bpf_list_excl_node);
 	case BPF_RB_ROOT:
 		return __alignof__(struct bpf_rb_root);
 	case BPF_RB_NODE:
 		return __alignof__(struct bpf_rb_node);
+	case BPF_RB_EXCL_NODE:
+		return __alignof__(struct bpf_rb_excl_node);
 	case BPF_REFCOUNT:
 		return __alignof__(struct bpf_refcount);
 	default:
@@ -396,10 +413,12 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 		refcount_set((refcount_t *)addr, 1);
 		break;
 	case BPF_RB_NODE:
+	case BPF_RB_EXCL_NODE:
 		RB_CLEAR_NODE((struct rb_node *)addr);
 		break;
 	case BPF_LIST_HEAD:
 	case BPF_LIST_NODE:
+	case BPF_LIST_EXCL_NODE:
 		INIT_LIST_HEAD((struct list_head *)addr);
 		break;
 	case BPF_RB_ROOT:
diff --git a/include/linux/rbtree_types.h b/include/linux/rbtree_types.h
index 45b6ecde3665..fc5185991fb1 100644
--- a/include/linux/rbtree_types.h
+++ b/include/linux/rbtree_types.h
@@ -28,6 +28,10 @@ struct rb_root_cached {
 	struct rb_node *rb_leftmost;
 };
 
+struct bpf_rb_excl_node {
+	struct rb_node rb_node;
+};
+
 #define RB_ROOT (struct rb_root) { NULL, }
 #define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
 
diff --git a/include/linux/types.h b/include/linux/types.h
index 2bc8766ba20c..71429cd80ce2 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -202,6 +202,10 @@ struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
 
+struct bpf_list_excl_node {
+	struct list_head list_head;
+};
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 25a5dc840ac3..a641c716e0fa 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3484,6 +3484,8 @@ static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
 	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
 	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
+	field_mask_test_name(BPF_LIST_EXCL_NODE, "bpf_list_excl_node");
+	field_mask_test_name(BPF_RB_EXCL_NODE,   "bpf_rb_excl_node");
 
 	/* Only return BPF_KPTR when all other types with matchable names fail */
 	if (field_mask & BPF_KPTR) {
@@ -3504,6 +3506,8 @@ static int btf_get_union_field_types(const struct btf *btf, const struct btf_typ
 	const struct btf_member *member;
 	const struct btf_type *t;
 
+	field_mask &= BPF_GRAPH_EXCL_NODE;
+
 	for_each_member(i, u, member) {
 		t = btf_type_by_id(btf, member->type);
 		field_type = btf_get_field_type(__btf_name_by_offset(btf, t->name_off),
@@ -3552,13 +3556,28 @@ static int btf_find_struct_field(const struct btf *btf,
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_LIST_NODE:
+		case BPF_LIST_EXCL_NODE:
 		case BPF_RB_NODE:
+		case BPF_RB_EXCL_NODE:
 		case BPF_REFCOUNT:
 			ret = btf_find_struct(btf, member_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
 				return ret;
 			break;
+		case BPF_GRAPH_EXCL_NODE:
+			ret = btf_find_struct(btf, member_type, off, sz,
+					      BPF_LIST_EXCL_NODE,
+					      idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			++idx;
+			ret = btf_find_struct(btf, member_type, off, sz,
+					      BPF_RB_EXCL_NODE,
+					      idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
@@ -3619,7 +3638,9 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_LIST_NODE:
+		case BPF_LIST_EXCL_NODE:
 		case BPF_RB_NODE:
+		case BPF_RB_EXCL_NODE:
 		case BPF_REFCOUNT:
 			ret = btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
@@ -3827,14 +3848,24 @@ static int btf_parse_graph_root(struct btf_field *field,
 
 static int btf_parse_list_head(struct btf_field *field, struct btf_field_info *info)
 {
-	return btf_parse_graph_root(field, info, "bpf_list_node",
-				    __alignof__(struct bpf_list_node));
+	int err;
+
+	err = btf_parse_graph_root(field, info, "bpf_list_node",
+				   __alignof__(struct bpf_list_node));
+
+	return err ? btf_parse_graph_root(field, info, "bpf_list_excl_node",
+					  __alignof__(struct bpf_list_excl_node)) : 0;
 }
 
 static int btf_parse_rb_root(struct btf_field *field, struct btf_field_info *info)
 {
-	return btf_parse_graph_root(field, info, "bpf_rb_node",
-				    __alignof__(struct bpf_rb_node));
+	int err;
+
+	err = btf_parse_graph_root(field, info, "bpf_rb_node",
+				   __alignof__(struct bpf_rb_node));
+
+	return err ? btf_parse_graph_root(field, info, "bpf_rb_excl_node",
+					  __alignof__(struct bpf_rb_excl_node)) : 0;
 }
 
 static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
@@ -3864,6 +3895,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		return NULL;
 
 	cnt = ret;
+
 	/* This needs to be kzalloc to zero out padding and unused fields, see
 	 * comment in btf_record_equal.
 	 */
@@ -3881,7 +3913,9 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			ret = -EFAULT;
 			goto end;
 		}
-		if (info_arr[i].off < next_off) {
+		if (info_arr[i].off < next_off &&
+		    !(info_arr[i].off == info_arr[i - 1].off &&
+		     (info_arr[i].type | info_arr[i - 1].type) == BPF_GRAPH_EXCL_NODE)) {
 			ret = -EEXIST;
 			goto end;
 		}
@@ -3925,6 +3959,8 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			if (ret < 0)
 				goto end;
 			break;
+		case BPF_LIST_EXCL_NODE:
+		case BPF_RB_EXCL_NODE:
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 			break;
@@ -3949,6 +3985,21 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		goto end;
 	}
 
+	if (rec->refcount_off >= 0 &&
+	    (btf_record_has_field(rec, BPF_LIST_EXCL_NODE) ||
+	     btf_record_has_field(rec, BPF_RB_EXCL_NODE))) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if ((btf_record_has_field(rec, BPF_LIST_EXCL_NODE) ||
+	     btf_record_has_field(rec, BPF_RB_EXCL_NODE)) &&
+	    (btf_record_has_field(rec, BPF_LIST_NODE) ||
+	     btf_record_has_field(rec, BPF_RB_NODE))) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	sort_r(rec->fields, rec->cnt, sizeof(struct btf_field), btf_field_cmp,
 	       NULL, rec);
 
@@ -5434,8 +5485,10 @@ static const char *alloc_obj_fields[] = {
 	"bpf_spin_lock",
 	"bpf_list_head",
 	"bpf_list_node",
+	"bpf_list_excl_node",
 	"bpf_rb_root",
 	"bpf_rb_node",
+	"bpf_rb_excl_node",
 	"bpf_refcount",
 };
 
@@ -5536,6 +5589,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		type->btf_id = id;
 		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
 						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
+						  BPF_LIST_EXCL_NODE | BPF_RB_EXCL_NODE |
 						  BPF_KPTR, t->size);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9e93d48efe19..25fad6293720 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -528,13 +528,23 @@ struct btf_field *btf_record_find(const struct btf_record *rec, u32 offset,
 				  u32 field_mask)
 {
 	struct btf_field *field;
+	u32 i;
 
 	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & field_mask))
 		return NULL;
 	field = bsearch(&offset, rec->fields, rec->cnt, sizeof(rec->fields[0]), btf_field_cmp);
-	if (!field || !(field->type & field_mask))
+	if (!field)
 		return NULL;
-	return field;
+	if (field->type & field_mask)
+		return field;
+	if (field->type & BPF_GRAPH_EXCL_NODE && field_mask & BPF_GRAPH_EXCL_NODE) {
+		i = field - rec->fields;
+		if (i > 0 && (field - 1)->type & field_mask)
+			return field - 1;
+		if (i < rec->cnt - 1 && (field + 1)->type & field_mask)
+			return field + 1;
+	}
+	return NULL;
 }
 
 void btf_record_free(struct btf_record *rec)
@@ -554,8 +564,10 @@ void btf_record_free(struct btf_record *rec)
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_LIST_NODE:
+		case BPF_LIST_EXCL_NODE:
 		case BPF_RB_ROOT:
 		case BPF_RB_NODE:
+		case BPF_RB_EXCL_NODE:
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
@@ -603,8 +615,10 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_LIST_NODE:
+		case BPF_LIST_EXCL_NODE:
 		case BPF_RB_ROOT:
 		case BPF_RB_NODE:
+		case BPF_RB_EXCL_NODE:
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
@@ -711,7 +725,9 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
 		case BPF_LIST_NODE:
+		case BPF_LIST_EXCL_NODE:
 		case BPF_RB_NODE:
+		case BPF_RB_EXCL_NODE:
 		case BPF_REFCOUNT:
 			break;
 		default:
-- 
2.20.1



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8256DCB4B
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDJTI5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDJTI4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:08:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A428A170B
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:55 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AGGbDn016525
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wfA3SDduKwJ24EbZJDFiR0jDDyXompKDpD/7qM2S9a8=;
 b=iMDg2FIXmRuFQummNIgMZqbHD9FciKh6vYiEpNyfKbmKLN7KS8wDtcak19d9/O8BbA6J
 TppkGBzHSnjmWiFCXRDvJhfiD5wH2TaKbqiCZpTuDCH0jF+Xfht1y6k2ldKssjkuqrBq
 J/Luko3kgNQFSnTbxoJ2URD0P27unaNoGPc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pu4an31hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:55 -0700
Received: from twshared8612.02.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:08:54 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 0FE661BB3FCDC; Mon, 10 Apr 2023 12:08:41 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 2/9] bpf: Introduce opaque bpf_refcount struct and add btf_record plumbing
Date:   Mon, 10 Apr 2023 12:07:46 -0700
Message-ID: <20230410190753.2012798-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410190753.2012798-1-davemarchevsky@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZdkFZgakMDa3pVxefM3gSjeB5ASZt3wa
X-Proofpoint-GUID: ZdkFZgakMDa3pVxefM3gSjeB5ASZt3wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_14,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A 'struct bpf_refcount' is added to the set of opaque uapi/bpf.h types
meant for use in BPF programs. Similarly to other opaque types like
bpf_spin_lock and bpf_rbtree_node, the verifier needs to know where in
user-defined struct types a bpf_refcount can be located, so necessary
btf_record plumbing is added to enable this. bpf_refcount is sized to
hold a refcount_t.

Similarly to bpf_spin_lock, the offset of a bpf_refcount is cached in
btf_record as refcount_off in addition to being in the field array.
Caching refcount_off makes sense for this field because further patches
in the series will modify functions that take local kptrs (e.g.
bpf_obj_drop) to change their behavior if the type they're operating on
is refcounted. So enabling fast "is this type refcounted?" checks is
desirable.

No such verifier behavior changes are introduced in this patch, just
logic to recognize 'struct bpf_refcount' in btf_record.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h            |  8 ++++++++
 include/uapi/linux/bpf.h       |  4 ++++
 kernel/bpf/btf.c               | 12 +++++++++++-
 kernel/bpf/syscall.c           |  6 +++++-
 tools/include/uapi/linux/bpf.h |  4 ++++
 5 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 314f911fcf91..afb82e623663 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -187,6 +187,7 @@ enum btf_field_type {
 	BPF_RB_NODE    =3D (1 << 7),
 	BPF_GRAPH_NODE_OR_ROOT =3D BPF_LIST_NODE | BPF_LIST_HEAD |
 				 BPF_RB_NODE | BPF_RB_ROOT,
+	BPF_REFCOUNT   =3D (1 << 8),
 };
=20
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -223,6 +224,7 @@ struct btf_record {
 	u32 field_mask;
 	int spin_lock_off;
 	int timer_off;
+	int refcount_off;
 	struct btf_field fields[];
 };
=20
@@ -293,6 +295,8 @@ static inline const char *btf_field_type_name(enum bt=
f_field_type type)
 		return "bpf_rb_root";
 	case BPF_RB_NODE:
 		return "bpf_rb_node";
+	case BPF_REFCOUNT:
+		return "bpf_refcount";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -317,6 +321,8 @@ static inline u32 btf_field_type_size(enum btf_field_=
type type)
 		return sizeof(struct bpf_rb_root);
 	case BPF_RB_NODE:
 		return sizeof(struct bpf_rb_node);
+	case BPF_REFCOUNT:
+		return sizeof(struct bpf_refcount);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -341,6 +347,8 @@ static inline u32 btf_field_type_align(enum btf_field=
_type type)
 		return __alignof__(struct bpf_rb_root);
 	case BPF_RB_NODE:
 		return __alignof__(struct bpf_rb_node);
+	case BPF_REFCOUNT:
+		return __alignof__(struct bpf_refcount);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e3d3b5160d26..678b48374518 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6975,6 +6975,10 @@ struct bpf_rb_node {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+struct bpf_refcount {
+	__u32 :32;
+} __attribute__((aligned(4)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index acd379361b4c..9fb29b41247c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3391,6 +3391,7 @@ static int btf_get_field_type(const char *name, u32=
 field_mask, u32 *seen_mask,
 	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
 	field_mask_test_name(BPF_RB_NODE,   "bpf_rb_node");
+	field_mask_test_name(BPF_REFCOUNT,  "bpf_refcount");
=20
 	/* Only return BPF_KPTR when all other types with matchable names fail =
*/
 	if (field_mask & BPF_KPTR) {
@@ -3439,6 +3440,7 @@ static int btf_find_struct_field(const struct btf *=
btf,
 		case BPF_TIMER:
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
+		case BPF_REFCOUNT:
 			ret =3D btf_find_struct(btf, member_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3504,6 +3506,7 @@ static int btf_find_datasec_var(const struct btf *b=
tf, const struct btf_type *t,
 		case BPF_TIMER:
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
+		case BPF_REFCOUNT:
 			ret =3D btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3734,6 +3737,7 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
=20
 	rec->spin_lock_off =3D -EINVAL;
 	rec->timer_off =3D -EINVAL;
+	rec->refcount_off =3D -EINVAL;
 	for (i =3D 0; i < cnt; i++) {
 		field_type_size =3D btf_field_type_size(info_arr[i].type);
 		if (info_arr[i].off + field_type_size > value_size) {
@@ -3763,6 +3767,11 @@ struct btf_record *btf_parse_fields(const struct b=
tf *btf, const struct btf_type
 			/* Cache offset for faster lookup at runtime */
 			rec->timer_off =3D rec->fields[i].offset;
 			break;
+		case BPF_REFCOUNT:
+			WARN_ON_ONCE(rec->refcount_off >=3D 0);
+			/* Cache offset for faster lookup at runtime */
+			rec->refcount_off =3D rec->fields[i].offset;
+			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			ret =3D btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
@@ -5307,6 +5316,7 @@ static const char *alloc_obj_fields[] =3D {
 	"bpf_list_node",
 	"bpf_rb_root",
 	"bpf_rb_node",
+	"bpf_refcount",
 };
=20
 static struct btf_struct_metas *
@@ -5380,7 +5390,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log=
, struct btf *btf)
 		type =3D &tab->types[tab->cnt];
 		type->btf_id =3D i;
 		record =3D btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BP=
F_LIST_NODE |
-						  BPF_RB_ROOT | BPF_RB_NODE, t->size);
+						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT, t->size);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret =3D PTR_ERR_OR_ZERO(record) ?: -EFAULT;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7fb962858d30..62f48ad72ac4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -552,6 +552,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_RB_NODE:
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_REFCOUNT:
 			/* Nothing to release */
 			break;
 		default:
@@ -599,6 +600,7 @@ struct btf_record *btf_record_dup(const struct btf_re=
cord *rec)
 		case BPF_RB_NODE:
 		case BPF_SPIN_LOCK:
 		case BPF_TIMER:
+		case BPF_REFCOUNT:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -705,6 +707,7 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
 			break;
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
+		case BPF_REFCOUNT:
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -1032,7 +1035,7 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
=20
 	map->record =3D btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
-				       BPF_RB_ROOT,
+				       BPF_RB_ROOT | BPF_REFCOUNT,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1071,6 +1074,7 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 				break;
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
+			case BPF_REFCOUNT:
 				if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
 				    map->map_type !=3D BPF_MAP_TYPE_PERCPU_HASH &&
 				    map->map_type !=3D BPF_MAP_TYPE_LRU_HASH &&
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index d6c5a022ae28..775a3c775e23 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6975,6 +6975,10 @@ struct bpf_rb_node {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+struct bpf_refcount {
+	__u32 :32;
+} __attribute__((aligned(4)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
--=20
2.34.1


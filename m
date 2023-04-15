Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903EC6E3378
	for <lists+bpf@lfdr.de>; Sat, 15 Apr 2023 22:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDOUS2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Apr 2023 16:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDOUS1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Apr 2023 16:18:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA3B2D7E
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:25 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33FIjmFQ016737
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=r6qnqUrbZeB4mmxJkD9lQwpqOoINR9KFO1u5pzQiSgA=;
 b=Whv+5VAIVJGcrE6oJnTlIVjL9lGLjr15Dqaj89yn/w75lSl4aVNLT7VpZU07lcp5itNP
 2HEP/vk3LHrXGf3y/pPxF4AO0eNWsG3+I9DwcdSX50LAIjW5/mOCjqyluzrX7WDfQAkT
 qqp1KfUznc4SSVR6PRCJB38K9wYX5aygmzs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pyqkxa3cy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 15 Apr 2023 13:18:24 -0700
Received: from twshared7147.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 15 Apr 2023 13:18:23 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 3FEAC1C270227; Sat, 15 Apr 2023 13:18:14 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 2/9] bpf: Introduce opaque bpf_refcount struct and add btf_record plumbing
Date:   Sat, 15 Apr 2023 13:18:04 -0700
Message-ID: <20230415201811.343116-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415201811.343116-1-davemarchevsky@fb.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zQTTd8R_oVSbLvhb-kKpcV1lNu2RMwqm
X-Proofpoint-GUID: zQTTd8R_oVSbLvhb-kKpcV1lNu2RMwqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_10,2023-04-14_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 7888ed497432..be44d765b7a4 100644
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
index 3823100b7934..4b20a7269bee 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6985,6 +6985,10 @@ struct bpf_rb_node {
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
index f3c998feeccb..14889fd5ba8e 100644
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
@@ -5308,6 +5317,7 @@ static const char *alloc_obj_fields[] =3D {
 	"bpf_list_node",
 	"bpf_rb_root",
 	"bpf_rb_node",
+	"bpf_refcount",
 };
=20
 static struct btf_struct_metas *
@@ -5381,7 +5391,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *log=
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
index c08b7933bf8f..28eac7434d32 100644
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
index 3823100b7934..4b20a7269bee 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6985,6 +6985,10 @@ struct bpf_rb_node {
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


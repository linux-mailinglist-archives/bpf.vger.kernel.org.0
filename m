Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F257E698
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiGVSfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbiGVSfD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 14:35:03 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C6C9FE1A
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:02 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MC8QaF022622
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1y1r6kY8FMLTpTnnl89OSJNgwHtRLzSDIWIoWncIqwU=;
 b=ITFhu94pamM3xYoIQSICqVo/Irp96ZUCw1iPYfgiYhAq0i6OLx6y3GoGG0mcVZXJA2jP
 0dovpB9oWv0wWoxgFuqukVjxz14OZ12m8GNlgI9OcX8iKDidTj9Cl+hqC6Me0jjIA+6c
 Ob8nSXL6xANgBwxRCFpHXKoHSfe9CmRrjpY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hf7fc10es-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 11:35:01 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 22 Jul 2022 11:35:00 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id D66F6AB6F199; Fri, 22 Jul 2022 11:34:47 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [RFC PATCH bpf-next 03/11] bpf: Add rb_node_off to bpf_map
Date:   Fri, 22 Jul 2022 11:34:30 -0700
Message-ID: <20220722183438.3319790-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RrDwewK-_3DYQtZudeDukARh_oHwys-y
X-Proofpoint-ORIG-GUID: RrDwewK-_3DYQtZudeDukARh_oHwys-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to other protected fields which might be in a map value -
bpf_spin_lock and bpf_timer - keep track of existence and offset of
struct rb_node within map value struct. This will allow later patches in
this series to prevent writes to rb_node field.

Allowing bpf programs to modify the rbtree node struct's rb_node field
would allow parent and children node pointers to be changed, which could
corrupt an otherwise-valid rbtree.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h  |  6 ++++++
 include/linux/btf.h  |  1 +
 kernel/bpf/btf.c     | 21 +++++++++++++++++++++
 kernel/bpf/syscall.c |  3 +++
 4 files changed, 31 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a97751d845c9..eb8c550db0e2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -214,6 +214,7 @@ struct bpf_map {
 	int spin_lock_off; /* >=3D0 valid offset, <0 error */
 	struct bpf_map_value_off *kptr_off_tab;
 	int timer_off; /* >=3D0 valid offset, <0 error */
+	int rb_node_off; /* >=3D0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
 	u32 btf_key_type_id;
@@ -263,6 +264,11 @@ static inline bool map_value_has_kptrs(const struct =
bpf_map *map)
 	return !IS_ERR_OR_NULL(map->kptr_off_tab);
 }
=20
+static inline bool map_value_has_rb_node(const struct bpf_map *map)
+{
+	return map->rb_node_off >=3D 0;
+}
+
 static inline void check_and_init_map_value(struct bpf_map *map, void *d=
st)
 {
 	if (unlikely(map_value_has_spin_lock(map)))
diff --git a/include/linux/btf.h b/include/linux/btf.h
index cdb376d53238..1d8b1bcf0396 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -152,6 +152,7 @@ bool btf_member_is_reg_int(const struct btf *btf, con=
st struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
+int btf_find_rb_node(const struct btf *btf, const struct btf_type *t);
 struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 					  const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7ac971ea98d1..3a7096da7f20 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3195,6 +3195,7 @@ enum btf_field_type {
 	BTF_FIELD_SPIN_LOCK,
 	BTF_FIELD_TIMER,
 	BTF_FIELD_KPTR,
+	BTF_FIELD_RB_NODE,
 };
=20
 enum {
@@ -3282,6 +3283,7 @@ static int btf_find_struct_field(const struct btf *=
btf, const struct btf_type *t
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
+		case BTF_FIELD_RB_NODE:
 			ret =3D btf_find_struct(btf, member_type, off, sz,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3332,6 +3334,7 @@ static int btf_find_datasec_var(const struct btf *b=
tf, const struct btf_type *t,
 		switch (field_type) {
 		case BTF_FIELD_SPIN_LOCK:
 		case BTF_FIELD_TIMER:
+		case BTF_FIELD_RB_NODE:
 			ret =3D btf_find_struct(btf, var_type, off, sz,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3374,6 +3377,11 @@ static int btf_find_field(const struct btf *btf, c=
onst struct btf_type *t,
 		sz =3D sizeof(struct bpf_timer);
 		align =3D __alignof__(struct bpf_timer);
 		break;
+	case BTF_FIELD_RB_NODE:
+		name =3D "rb_node";
+		sz =3D sizeof(struct rb_node);
+		align =3D __alignof__(struct rb_node);
+		break;
 	case BTF_FIELD_KPTR:
 		name =3D NULL;
 		sz =3D sizeof(u64);
@@ -3420,6 +3428,19 @@ int btf_find_timer(const struct btf *btf, const st=
ruct btf_type *t)
 	return info.off;
 }
=20
+int btf_find_rb_node(const struct btf *btf, const struct btf_type *t)
+{
+	struct btf_field_info info;
+	int ret;
+
+	ret =3D btf_find_field(btf, t, BTF_FIELD_RB_NODE, &info, 1);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -ENOENT;
+	return info.off;
+}
+
 struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 					  const struct btf_type *t)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83c7136c5788..3947fbd137af 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1052,6 +1052,8 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 		}
 	}
=20
+	map->rb_node_off =3D btf_find_rb_node(btf, value_type);
+
 	if (map->ops->map_check_btf) {
 		ret =3D map->ops->map_check_btf(map, btf, key_type, value_type);
 		if (ret < 0)
@@ -1115,6 +1117,7 @@ static int map_create(union bpf_attr *attr)
=20
 	map->spin_lock_off =3D -EINVAL;
 	map->timer_off =3D -EINVAL;
+	map->rb_node_off =3D -EINVAL;
 	if (attr->btf_key_type_id || attr->btf_value_type_id ||
 	    /* Even the map's value is a kernel's struct,
 	     * the bpf_prog.o must have BTF to begin with
--=20
2.30.2


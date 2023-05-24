Return-Path: <bpf+bounces-1188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB570FF97
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 23:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7981B1C20D6F
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8972262A;
	Wed, 24 May 2023 21:03:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EEB182A2
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 21:03:06 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50137BF
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:03:05 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHerVp017652
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:03:04 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qscwrwnpm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:03:04 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 14:03:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 71A2C31486DA4; Wed, 24 May 2023 14:02:49 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH RFC bpf-next 2/3] bpf: use new named bpf_attr substructs for few commands
Date: Wed, 24 May 2023 14:02:42 -0700
Message-ID: <20230524210243.605832-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524210243.605832-1-andrii@kernel.org>
References: <20230524210243.605832-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Xzm45j_fprA6itsbBeni3LC3LC-Z71nW
X-Proofpoint-ORIG-GUID: Xzm45j_fprA6itsbBeni3LC3LC-Z71nW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Switch to new named bpf_xxx_attr substructs for a few commands to
demonstrate how minimal are the changes, especially for simple commands.

For more "sprawling" commands like BPF_MAP_CREATE and BPF_PROG_LOAD
changes will be of a similar nature (replacing union bpf_attr with
command-specific struct bpf_xxx_attr), but will touch more of helper
functions. Given the RFC status I wanted to avoid unnecessary mundane
work before getting a green light for the entire approach.

Note the changes to CHECK_ATTR() implementation. It's equivalent in
functionality, but, IMO, more straightforward and actually support both
old-style `union bpf_attr` and new-style `struct bpf_xxx_attr` usage
transparently.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index babf1d56c2d9..fbc5c86c7bca 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -974,11 +974,8 @@ int bpf_get_file_flag(int flags)
=20
 /* helper macro to check that unused fields 'union bpf_attr' are zero */
 #define CHECK_ATTR(CMD) \
-	memchr_inv((void *) &attr->CMD##_LAST_FIELD + \
-		   sizeof(attr->CMD##_LAST_FIELD), 0, \
-		   sizeof(*attr) - \
-		   offsetof(union bpf_attr, CMD##_LAST_FIELD) - \
-		   sizeof(attr->CMD##_LAST_FIELD)) !=3D NULL
+	memchr_inv((void *)attr + offsetofend(union bpf_attr, CMD##_LAST_FIELD)=
, 0, \
+		   sizeof(union bpf_attr) - offsetofend(union bpf_attr, CMD##_LAST_FIE=
LD)) !=3D NULL
=20
 /* dst and src must have at least "size" number of bytes.
  * Return strlen on success and < 0 on error.
@@ -1354,7 +1351,7 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key=
_size)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_MAP_LOOKUP_ELEM_LAST_FIELD map_elem.flags
=20
-static int map_lookup_elem(union bpf_attr *attr)
+static int map_lookup_elem(struct bpf_map_elem_attr *attr)
 {
 	void __user *ukey =3D u64_to_user_ptr(attr->key);
 	void __user *uvalue =3D u64_to_user_ptr(attr->value);
@@ -1429,7 +1426,7 @@ static int map_lookup_elem(union bpf_attr *attr)
=20
 #define BPF_MAP_UPDATE_ELEM_LAST_FIELD map_elem.flags
=20
-static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
+static int map_update_elem(struct bpf_map_elem_attr *attr, bpfptr_t uatt=
r)
 {
 	bpfptr_t ukey =3D make_bpfptr(attr->key, uattr.is_kernel);
 	bpfptr_t uvalue =3D make_bpfptr(attr->value, uattr.is_kernel);
@@ -1485,7 +1482,7 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
=20
 #define BPF_MAP_DELETE_ELEM_LAST_FIELD map_elem.key
=20
-static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
+static int map_delete_elem(struct bpf_map_elem_attr *attr, bpfptr_t uatt=
r)
 {
 	bpfptr_t ukey =3D make_bpfptr(attr->key, uattr.is_kernel);
 	int ufd =3D attr->map_fd;
@@ -1540,7 +1537,7 @@ static int map_delete_elem(union bpf_attr *attr, bp=
fptr_t uattr)
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_MAP_GET_NEXT_KEY_LAST_FIELD map_next_key.next_key
=20
-static int map_get_next_key(union bpf_attr *attr)
+static int map_get_next_key(struct bpf_map_next_key_attr *attr)
 {
 	void __user *ukey =3D u64_to_user_ptr(attr->key);
 	void __user *unext_key =3D u64_to_user_ptr(attr->next_key);
@@ -1912,7 +1909,7 @@ static int map_lookup_and_delete_elem(union bpf_att=
r *attr)
=20
 #define BPF_MAP_FREEZE_LAST_FIELD map_freeze.map_fd
=20
-static int map_freeze(const union bpf_attr *attr)
+static int map_freeze(const struct bpf_map_freeze_attr *attr)
 {
 	int err =3D 0, ufd =3D attr->map_fd;
 	struct bpf_map *map;
@@ -3710,7 +3707,7 @@ static int bpf_prog_test_run(const union bpf_attr *=
attr,
=20
 #define BPF_OBJ_GET_NEXT_ID_LAST_FIELD obj_next_id.next_id
=20
-static int bpf_obj_get_next_id(const union bpf_attr *attr,
+static int bpf_obj_get_next_id(const struct bpf_obj_next_id_attr *attr,
 			       union bpf_attr __user *uattr,
 			       struct idr *idr,
 			       spinlock_t *lock)
@@ -5064,19 +5061,19 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, uns=
igned int size)
 		err =3D map_create(&attr);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
-		err =3D map_lookup_elem(&attr);
+		err =3D map_lookup_elem(&attr.map_elem);
 		break;
 	case BPF_MAP_UPDATE_ELEM:
-		err =3D map_update_elem(&attr, uattr);
+		err =3D map_update_elem(&attr.map_elem, uattr);
 		break;
 	case BPF_MAP_DELETE_ELEM:
-		err =3D map_delete_elem(&attr, uattr);
+		err =3D map_delete_elem(&attr.map_elem, uattr);
 		break;
 	case BPF_MAP_GET_NEXT_KEY:
-		err =3D map_get_next_key(&attr);
+		err =3D map_get_next_key(&attr.map_next_key);
 		break;
 	case BPF_MAP_FREEZE:
-		err =3D map_freeze(&attr);
+		err =3D map_freeze(&attr.map_freeze);
 		break;
 	case BPF_PROG_LOAD:
 		err =3D bpf_prog_load(&attr, uattr, size);
@@ -5100,15 +5097,15 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, uns=
igned int size)
 		err =3D bpf_prog_test_run(&attr, uattr.user);
 		break;
 	case BPF_PROG_GET_NEXT_ID:
-		err =3D bpf_obj_get_next_id(&attr, uattr.user,
+		err =3D bpf_obj_get_next_id(&attr.obj_next_id, uattr.user,
 					  &prog_idr, &prog_idr_lock);
 		break;
 	case BPF_MAP_GET_NEXT_ID:
-		err =3D bpf_obj_get_next_id(&attr, uattr.user,
+		err =3D bpf_obj_get_next_id(&attr.obj_next_id, uattr.user,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
-		err =3D bpf_obj_get_next_id(&attr, uattr.user,
+		err =3D bpf_obj_get_next_id(&attr.obj_next_id, uattr.user,
 					  &btf_idr, &btf_idr_lock);
 		break;
 	case BPF_PROG_GET_FD_BY_ID:
@@ -5158,7 +5155,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsig=
ned int size)
 		err =3D bpf_link_get_fd_by_id(&attr);
 		break;
 	case BPF_LINK_GET_NEXT_ID:
-		err =3D bpf_obj_get_next_id(&attr, uattr.user,
+		err =3D bpf_obj_get_next_id(&attr.obj_next_id, uattr.user,
 					  &link_idr, &link_idr_lock);
 		break;
 	case BPF_ENABLE_STATS:
--=20
2.34.1



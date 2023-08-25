Return-Path: <bpf+bounces-8687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A476788F6B
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9037528184F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8619381;
	Fri, 25 Aug 2023 19:53:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83E322B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:53:54 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B21987
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:53:52 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7297F25659FC1; Fri, 25 Aug 2023 12:53:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 02/13] bpf: Add BPF_KPTR_PERCPU as a field type
Date: Fri, 25 Aug 2023 12:53:38 -0700
Message-Id: <20230825195338.92830-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825195328.92126-1-yonghong.song@linux.dev>
References: <20230825195328.92126-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF_KPTR_PERCPU represents a percpu field type like below

  struct val_t {
    ... fields ...
  };
  struct t {
    ...
    struct val_t __percpu_kptr *percpu_data_ptr;
    ...
  };

where
  #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))

While BPF_KPTR_REF points to a trusted kernel object or a trusted
local object, BPF_KPTR_PERCPU points to a trusted local
percpu object.

This patch added basic support for BPF_KPTR_PERCPU
related to percpu_kptr field parsing, recording and free operations.
BPF_KPTR_PERCPU also supports the same map types
as BPF_KPTR_REF does.

Note that unlike a local kptr, it is possible that
a BPF_KTPR_PERCPU struct may not contain any
special fields like other kptr, bpf_spin_lock, bpf_list_head, etc.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h  | 18 ++++++++++++------
 kernel/bpf/btf.c     |  5 +++++
 kernel/bpf/syscall.c |  4 ++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 144dbddf53bd..d7ef65846903 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -180,14 +180,15 @@ enum btf_field_type {
 	BPF_TIMER      =3D (1 << 1),
 	BPF_KPTR_UNREF =3D (1 << 2),
 	BPF_KPTR_REF   =3D (1 << 3),
-	BPF_KPTR       =3D BPF_KPTR_UNREF | BPF_KPTR_REF,
-	BPF_LIST_HEAD  =3D (1 << 4),
-	BPF_LIST_NODE  =3D (1 << 5),
-	BPF_RB_ROOT    =3D (1 << 6),
-	BPF_RB_NODE    =3D (1 << 7),
+	BPF_KPTR_PERCPU =3D (1 << 4),
+	BPF_KPTR       =3D BPF_KPTR_UNREF | BPF_KPTR_REF | BPF_KPTR_PERCPU,
+	BPF_LIST_HEAD  =3D (1 << 5),
+	BPF_LIST_NODE  =3D (1 << 6),
+	BPF_RB_ROOT    =3D (1 << 7),
+	BPF_RB_NODE    =3D (1 << 8),
 	BPF_GRAPH_NODE_OR_ROOT =3D BPF_LIST_NODE | BPF_LIST_HEAD |
 				 BPF_RB_NODE | BPF_RB_ROOT,
-	BPF_REFCOUNT   =3D (1 << 8),
+	BPF_REFCOUNT   =3D (1 << 9),
 };
=20
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -300,6 +301,8 @@ static inline const char *btf_field_type_name(enum bt=
f_field_type type)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return "kptr";
+	case BPF_KPTR_PERCPU:
+		return "percpu_kptr";
 	case BPF_LIST_HEAD:
 		return "bpf_list_head";
 	case BPF_LIST_NODE:
@@ -325,6 +328,7 @@ static inline u32 btf_field_type_size(enum btf_field_=
type type)
 		return sizeof(struct bpf_timer);
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
+	case BPF_KPTR_PERCPU:
 		return sizeof(u64);
 	case BPF_LIST_HEAD:
 		return sizeof(struct bpf_list_head);
@@ -351,6 +355,7 @@ static inline u32 btf_field_type_align(enum btf_field=
_type type)
 		return __alignof__(struct bpf_timer);
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
+	case BPF_KPTR_PERCPU:
 		return __alignof__(u64);
 	case BPF_LIST_HEAD:
 		return __alignof__(struct bpf_list_head);
@@ -389,6 +394,7 @@ static inline void bpf_obj_init_field(const struct bt=
f_field *field, void *addr)
 	case BPF_TIMER:
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
+	case BPF_KPTR_PERCPU:
 		break;
 	default:
 		WARN_ON_ONCE(1);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 249657c466dd..d98b76c128db 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3293,6 +3293,8 @@ static int btf_find_kptr(const struct btf *btf, con=
st struct btf_type *t,
 		type =3D BPF_KPTR_UNREF;
 	else if (!strcmp("kptr", __btf_name_by_offset(btf, t->name_off)))
 		type =3D BPF_KPTR_REF;
+	else if (!strcmp("percpu_kptr", __btf_name_by_offset(btf, t->name_off))=
)
+		type =3D BPF_KPTR_PERCPU;
 	else
 		return -EINVAL;
=20
@@ -3457,6 +3459,7 @@ static int btf_find_struct_field(const struct btf *=
btf,
 			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
 			ret =3D btf_find_kptr(btf, member_type, off, sz,
 					    idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3523,6 +3526,7 @@ static int btf_find_datasec_var(const struct btf *b=
tf, const struct btf_type *t,
 			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
 			ret =3D btf_find_kptr(btf, var_type, off, sz,
 					    idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3783,6 +3787,7 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
 			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
 			ret =3D btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
 			if (ret < 0)
 				goto end;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ebeb0695305a..e25e7e059d7d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -514,6 +514,7 @@ void btf_record_free(struct btf_record *rec)
 		switch (rec->fields[i].type) {
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
 			if (rec->fields[i].kptr.module)
 				module_put(rec->fields[i].kptr.module);
 			btf_put(rec->fields[i].kptr.btf);
@@ -560,6 +561,7 @@ struct btf_record *btf_record_dup(const struct btf_re=
cord *rec)
 		switch (fields[i].type) {
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
 			btf_get(fields[i].kptr.btf);
 			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) =
{
 				ret =3D -ENXIO;
@@ -650,6 +652,7 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
 			WRITE_ONCE(*(u64 *)field_ptr, 0);
 			break;
 		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
 			xchgd_field =3D (void *)xchg((unsigned long *)field_ptr, 0);
 			if (!xchgd_field)
 				break;
@@ -1045,6 +1048,7 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 				break;
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
+			case BPF_KPTR_PERCPU:
 			case BPF_REFCOUNT:
 				if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
 				    map->map_type !=3D BPF_MAP_TYPE_PERCPU_HASH &&
--=20
2.34.1



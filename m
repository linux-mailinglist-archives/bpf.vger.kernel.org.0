Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74E6DCB4C
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjDJTJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDJTI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 15:08:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E91987
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:57 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AG7Ppm029478
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0YnaCONXsvYHMp2FbE50XupdFHxwWI6EWDSWNucUisg=;
 b=DVLKmFCFkCL4yxEbRg2Hgspw6bHQ7w4xDuAhEGBR814qEs7nNMyt0nQOzsG2t3NVkoW4
 ZtBs6r0op6oG2nZE5Z6kzeJfJRA4SU/r/uUunT6lzV5jSReX4U5bdtxV2Bn1nxJo/5+B
 KIGVYp6NcFU2u9bP9zPo3MYWcE1qOG6DbCI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pu5t22ghy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Apr 2023 12:08:56 -0700
Received: from twshared8612.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 12:08:54 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 6148F1BB3FCD6; Mon, 10 Apr 2023 12:08:40 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 1/9] bpf: Remove btf_field_offs, use btf_record's fields instead
Date:   Mon, 10 Apr 2023 12:07:45 -0700
Message-ID: <20230410190753.2012798-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410190753.2012798-1-davemarchevsky@fb.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yWruhGmbkoIMRVm2sVPDTlaSayqr3m2d
X-Proofpoint-GUID: yWruhGmbkoIMRVm2sVPDTlaSayqr3m2d
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

The btf_field_offs struct contains (offset, size) for btf_record fields,
sorted by offset. btf_field_offs is always used in conjunction with
btf_record, which has btf_field 'fields' array with (offset, type), the
latter of which btf_field_offs' size is derived from via
btf_field_type_size.

This patch adds a size field to struct btf_field and sorts btf_record's
fields by offset, making it possible to get rid of btf_field_offs. Less
data duplication and less code complexity results.

Since btf_field_offs' lifetime closely followed the btf_record used to
populate it, most complexity wins are from removal of initialization
code like:

  if (btf_record_successfully_initialized) {
    foffs =3D btf_parse_field_offs(rec);
    if (IS_ERR_OR_NULL(foffs))
      // free the btf_record and return err
  }

Other changes in this patch are pretty mechanical:

  * foffs->field_off[i] -> rec->fields[i].offset
  * foffs->field_sz[i] -> rec->fields[i].size
  * Sort rec->fields in btf_parse_fields before returning
    * It's possible that this is necessary independently of other
      changes in this patch. btf_record_find in syscall.c expects
      btf_record's fields to be sorted by offset, yet there's no
      explicit sorting of them before this patch, record's fields are
      populated in the order they're read from BTF struct definition.
      BTF docs don't say anything about the sortedness of struct fields.
  * All functions taking struct btf_field_offs * input now instead take
    struct btf_record *. All callsites of these functions already have
    access to the correct btf_record.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h     | 44 +++++++++----------
 include/linux/btf.h     |  2 -
 kernel/bpf/btf.c        | 93 ++++++++++-------------------------------
 kernel/bpf/helpers.c    |  2 +-
 kernel/bpf/map_in_map.c | 15 -------
 kernel/bpf/syscall.c    | 17 +-------
 6 files changed, 43 insertions(+), 130 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 002a811b6b90..314f911fcf91 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -210,6 +210,7 @@ struct btf_field_graph_root {
=20
 struct btf_field {
 	u32 offset;
+	u32 size;
 	enum btf_field_type type;
 	union {
 		struct btf_field_kptr kptr;
@@ -225,12 +226,6 @@ struct btf_record {
 	struct btf_field fields[];
 };
=20
-struct btf_field_offs {
-	u32 cnt;
-	u32 field_off[BTF_FIELDS_MAX];
-	u8 field_sz[BTF_FIELDS_MAX];
-};
-
 struct bpf_map {
 	/* The first two cachelines with read-mostly members of which some
 	 * are also accessed in fast-path (e.g. ops, max_entries).
@@ -257,7 +252,6 @@ struct bpf_map {
 	struct obj_cgroup *objcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
-	struct btf_field_offs *field_offs;
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
 	 */
@@ -360,14 +354,14 @@ static inline bool btf_record_has_field(const struc=
t btf_record *rec, enum btf_f
 	return rec->field_mask & type;
 }
=20
-static inline void bpf_obj_init(const struct btf_field_offs *foffs, void=
 *obj)
+static inline void bpf_obj_init(const struct btf_record *rec, void *obj)
 {
 	int i;
=20
-	if (!foffs)
+	if (IS_ERR_OR_NULL(rec))
 		return;
-	for (i =3D 0; i < foffs->cnt; i++)
-		memset(obj + foffs->field_off[i], 0, foffs->field_sz[i]);
+	for (i =3D 0; i < rec->cnt; i++)
+		memset(obj + rec->fields[i].offset, 0, rec->fields[i].size);
 }
=20
 /* 'dst' must be a temporary buffer and should not point to memory that =
is being
@@ -379,7 +373,7 @@ static inline void bpf_obj_init(const struct btf_fiel=
d_offs *foffs, void *obj)
  */
 static inline void check_and_init_map_value(struct bpf_map *map, void *d=
st)
 {
-	bpf_obj_init(map->field_offs, dst);
+	bpf_obj_init(map->record, dst);
 }
=20
 /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
@@ -399,14 +393,14 @@ static inline void bpf_long_memcpy(void *dst, const=
 void *src, u32 size)
 }
=20
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could =
be one of each. */
-static inline void bpf_obj_memcpy(struct btf_field_offs *foffs,
+static inline void bpf_obj_memcpy(struct btf_record *rec,
 				  void *dst, void *src, u32 size,
 				  bool long_memcpy)
 {
 	u32 curr_off =3D 0;
 	int i;
=20
-	if (likely(!foffs)) {
+	if (IS_ERR_OR_NULL(rec)) {
 		if (long_memcpy)
 			bpf_long_memcpy(dst, src, round_up(size, 8));
 		else
@@ -414,49 +408,49 @@ static inline void bpf_obj_memcpy(struct btf_field_=
offs *foffs,
 		return;
 	}
=20
-	for (i =3D 0; i < foffs->cnt; i++) {
-		u32 next_off =3D foffs->field_off[i];
+	for (i =3D 0; i < rec->cnt; i++) {
+		u32 next_off =3D rec->fields[i].offset;
 		u32 sz =3D next_off - curr_off;
=20
 		memcpy(dst + curr_off, src + curr_off, sz);
-		curr_off +=3D foffs->field_sz[i] + sz;
+		curr_off +=3D rec->fields[i].size + sz;
 	}
 	memcpy(dst + curr_off, src + curr_off, size - curr_off);
 }
=20
 static inline void copy_map_value(struct bpf_map *map, void *dst, void *=
src)
 {
-	bpf_obj_memcpy(map->field_offs, dst, src, map->value_size, false);
+	bpf_obj_memcpy(map->record, dst, src, map->value_size, false);
 }
=20
 static inline void copy_map_value_long(struct bpf_map *map, void *dst, v=
oid *src)
 {
-	bpf_obj_memcpy(map->field_offs, dst, src, map->value_size, true);
+	bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
 }
=20
-static inline void bpf_obj_memzero(struct btf_field_offs *foffs, void *d=
st, u32 size)
+static inline void bpf_obj_memzero(struct btf_record *rec, void *dst, u3=
2 size)
 {
 	u32 curr_off =3D 0;
 	int i;
=20
-	if (likely(!foffs)) {
+	if (IS_ERR_OR_NULL(rec)) {
 		memset(dst, 0, size);
 		return;
 	}
=20
-	for (i =3D 0; i < foffs->cnt; i++) {
-		u32 next_off =3D foffs->field_off[i];
+	for (i =3D 0; i < rec->cnt; i++) {
+		u32 next_off =3D rec->fields[i].offset;
 		u32 sz =3D next_off - curr_off;
=20
 		memset(dst + curr_off, 0, sz);
-		curr_off +=3D foffs->field_sz[i] + sz;
+		curr_off +=3D rec->fields[i].size + sz;
 	}
 	memset(dst + curr_off, 0, size - curr_off);
 }
=20
 static inline void zero_map_value(struct bpf_map *map, void *dst)
 {
-	bpf_obj_memzero(map->field_offs, dst, map->value_size);
+	bpf_obj_memzero(map->record, dst, map->value_size);
 }
=20
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/include/linux/btf.h b/include/linux/btf.h
index d53b10cc55f2..f28797624a2d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -113,7 +113,6 @@ struct btf_id_dtor_kfunc {
 struct btf_struct_meta {
 	u32 btf_id;
 	struct btf_record *record;
-	struct btf_field_offs *field_offs;
 };
=20
 struct btf_struct_metas {
@@ -207,7 +206,6 @@ int btf_find_timer(const struct btf *btf, const struc=
t btf_type *t);
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct =
btf_type *t,
 				    u32 field_mask, u32 value_size);
 int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record =
*rec);
-struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 593c45a294d0..acd379361b4c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1666,10 +1666,8 @@ static void btf_struct_metas_free(struct btf_struc=
t_metas *tab)
=20
 	if (!tab)
 		return;
-	for (i =3D 0; i < tab->cnt; i++) {
+	for (i =3D 0; i < tab->cnt; i++)
 		btf_record_free(tab->types[i].record);
-		kfree(tab->types[i].field_offs);
-	}
 	kfree(tab);
 }
=20
@@ -3700,12 +3698,24 @@ static int btf_parse_rb_root(const struct btf *bt=
f, struct btf_field *field,
 					    __alignof__(struct bpf_rb_node));
 }
=20
+static int btf_field_cmp(const void *_a, const void *_b, const void *pri=
v)
+{
+	const struct btf_field *a =3D (const struct btf_field *)_a;
+	const struct btf_field *b =3D (const struct btf_field *)_b;
+
+	if (a->offset < b->offset)
+		return -1;
+	else if (a->offset > b->offset)
+		return 1;
+	return 0;
+}
+
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct =
btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
 	struct btf_field_info info_arr[BTF_FIELDS_MAX];
+	u32 next_off =3D 0, field_type_size;
 	struct btf_record *rec;
-	u32 next_off =3D 0;
 	int ret, i, cnt;
=20
 	ret =3D btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_ar=
r));
@@ -3725,7 +3735,8 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
 	rec->spin_lock_off =3D -EINVAL;
 	rec->timer_off =3D -EINVAL;
 	for (i =3D 0; i < cnt; i++) {
-		if (info_arr[i].off + btf_field_type_size(info_arr[i].type) > value_si=
ze) {
+		field_type_size =3D btf_field_type_size(info_arr[i].type);
+		if (info_arr[i].off + field_type_size > value_size) {
 			WARN_ONCE(1, "verifier bug off %d size %d", info_arr[i].off, value_si=
ze);
 			ret =3D -EFAULT;
 			goto end;
@@ -3734,11 +3745,12 @@ struct btf_record *btf_parse_fields(const struct =
btf *btf, const struct btf_type
 			ret =3D -EEXIST;
 			goto end;
 		}
-		next_off =3D info_arr[i].off + btf_field_type_size(info_arr[i].type);
+		next_off =3D info_arr[i].off + field_type_size;
=20
 		rec->field_mask |=3D info_arr[i].type;
 		rec->fields[i].offset =3D info_arr[i].off;
 		rec->fields[i].type =3D info_arr[i].type;
+		rec->fields[i].size =3D field_type_size;
=20
 		switch (info_arr[i].type) {
 		case BPF_SPIN_LOCK:
@@ -3808,6 +3820,9 @@ struct btf_record *btf_parse_fields(const struct bt=
f *btf, const struct btf_type
 		goto end;
 	}
=20
+	sort_r(rec->fields, rec->cnt, sizeof(struct btf_field), btf_field_cmp,
+	       NULL, rec);
+
 	return rec;
 end:
 	btf_record_free(rec);
@@ -3889,61 +3904,6 @@ int btf_check_and_fixup_fields(const struct btf *b=
tf, struct btf_record *rec)
 	return 0;
 }
=20
-static int btf_field_offs_cmp(const void *_a, const void *_b, const void=
 *priv)
-{
-	const u32 a =3D *(const u32 *)_a;
-	const u32 b =3D *(const u32 *)_b;
-
-	if (a < b)
-		return -1;
-	else if (a > b)
-		return 1;
-	return 0;
-}
-
-static void btf_field_offs_swap(void *_a, void *_b, int size, const void=
 *priv)
-{
-	struct btf_field_offs *foffs =3D (void *)priv;
-	u32 *off_base =3D foffs->field_off;
-	u32 *a =3D _a, *b =3D _b;
-	u8 *sz_a, *sz_b;
-
-	sz_a =3D foffs->field_sz + (a - off_base);
-	sz_b =3D foffs->field_sz + (b - off_base);
-
-	swap(*a, *b);
-	swap(*sz_a, *sz_b);
-}
-
-struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec)
-{
-	struct btf_field_offs *foffs;
-	u32 i, *off;
-	u8 *sz;
-
-	BUILD_BUG_ON(ARRAY_SIZE(foffs->field_off) !=3D ARRAY_SIZE(foffs->field_=
sz));
-	if (IS_ERR_OR_NULL(rec))
-		return NULL;
-
-	foffs =3D kzalloc(sizeof(*foffs), GFP_KERNEL | __GFP_NOWARN);
-	if (!foffs)
-		return ERR_PTR(-ENOMEM);
-
-	off =3D foffs->field_off;
-	sz =3D foffs->field_sz;
-	for (i =3D 0; i < rec->cnt; i++) {
-		off[i] =3D rec->fields[i].offset;
-		sz[i] =3D btf_field_type_size(rec->fields[i].type);
-	}
-	foffs->cnt =3D rec->cnt;
-
-	if (foffs->cnt =3D=3D 1)
-		return foffs;
-	sort_r(foffs->field_off, foffs->cnt, sizeof(foffs->field_off[0]),
-	       btf_field_offs_cmp, btf_field_offs_swap, foffs);
-	return foffs;
-}
-
 static void __btf_struct_show(const struct btf *btf, const struct btf_ty=
pe *t,
 			      u32 type_id, void *data, u8 bits_offset,
 			      struct btf_show *show)
@@ -5385,7 +5345,6 @@ btf_parse_struct_metas(struct bpf_verifier_log *log=
, struct btf *btf)
 	for (i =3D 1; i < n; i++) {
 		struct btf_struct_metas *new_tab;
 		const struct btf_member *member;
-		struct btf_field_offs *foffs;
 		struct btf_struct_meta *type;
 		struct btf_record *record;
 		const struct btf_type *t;
@@ -5427,17 +5386,7 @@ btf_parse_struct_metas(struct bpf_verifier_log *lo=
g, struct btf *btf)
 			ret =3D PTR_ERR_OR_ZERO(record) ?: -EFAULT;
 			goto free;
 		}
-		foffs =3D btf_parse_field_offs(record);
-		/* We need the field_offs to be valid for a valid record,
-		 * either both should be set or both should be unset.
-		 */
-		if (IS_ERR_OR_NULL(foffs)) {
-			btf_record_free(record);
-			ret =3D -EFAULT;
-			goto free;
-		}
 		type->record =3D record;
-		type->field_offs =3D foffs;
 		tab->cnt++;
 	}
 	return tab;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b6a5cda5bb59..b37a44c9e5dc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1893,7 +1893,7 @@ __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_i=
d__k, void *meta__ign)
 	if (!p)
 		return NULL;
 	if (meta)
-		bpf_obj_init(meta->field_offs, p);
+		bpf_obj_init(meta->record, p);
 	return p;
 }
=20
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 38136ec4e095..2c5c64c2a53b 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -56,18 +56,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		ret =3D PTR_ERR(inner_map_meta->record);
 		goto free;
 	}
-	if (inner_map_meta->record) {
-		struct btf_field_offs *field_offs;
-		/* If btf_record is !IS_ERR_OR_NULL, then field_offs is always
-		 * valid.
-		 */
-		field_offs =3D kmemdup(inner_map->field_offs, sizeof(*inner_map->field=
_offs), GFP_KERNEL | __GFP_NOWARN);
-		if (!field_offs) {
-			ret =3D -ENOMEM;
-			goto free_rec;
-		}
-		inner_map_meta->field_offs =3D field_offs;
-	}
 	/* Note: We must use the same BTF, as we also used btf_record_dup above
 	 * which relies on BTF being same for both maps, as some members like
 	 * record->fields.list_head have pointers like value_rec pointing into
@@ -88,8 +76,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
=20
 	fdput(f);
 	return inner_map_meta;
-free_rec:
-	btf_record_free(inner_map_meta->record);
 free:
 	kfree(inner_map_meta);
 put:
@@ -99,7 +85,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
=20
 void bpf_map_meta_free(struct bpf_map *map_meta)
 {
-	kfree(map_meta->field_offs);
 	bpf_map_free_record(map_meta);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e18ac7fdc210..7fb962858d30 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -717,14 +717,13 @@ void bpf_obj_free_fields(const struct btf_record *r=
ec, void *obj)
 static void bpf_map_free_deferred(struct work_struct *work)
 {
 	struct bpf_map *map =3D container_of(work, struct bpf_map, work);
-	struct btf_field_offs *foffs =3D map->field_offs;
 	struct btf_record *rec =3D map->record;
=20
 	security_bpf_map_free(map);
 	bpf_map_release_memcg(map);
 	/* implementation dependent freeing */
 	map->ops->map_free(map);
-	/* Delay freeing of field_offs and btf_record for maps, as map_free
+	/* Delay freeing of btf_record for maps, as map_free
 	 * callback usually needs access to them. It is better to do it here
 	 * than require each callback to do the free itself manually.
 	 *
@@ -733,7 +732,6 @@ static void bpf_map_free_deferred(struct work_struct =
*work)
 	 * eventually calls bpf_map_free_meta, since inner_map_meta is only a
 	 * template bpf_map struct used during verification.
 	 */
-	kfree(foffs);
 	btf_record_free(rec);
 }
=20
@@ -1125,7 +1123,6 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 static int map_create(union bpf_attr *attr)
 {
 	int numa_node =3D bpf_map_attr_numa_node(attr);
-	struct btf_field_offs *foffs;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -1205,17 +1202,9 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
=20
-
-	foffs =3D btf_parse_field_offs(map->record);
-	if (IS_ERR(foffs)) {
-		err =3D PTR_ERR(foffs);
-		goto free_map;
-	}
-	map->field_offs =3D foffs;
-
 	err =3D security_bpf_map_alloc(map);
 	if (err)
-		goto free_map_field_offs;
+		goto free_map;
=20
 	err =3D bpf_map_alloc_id(map);
 	if (err)
@@ -1239,8 +1228,6 @@ static int map_create(union bpf_attr *attr)
=20
 free_map_sec:
 	security_bpf_map_free(map);
-free_map_field_offs:
-	kfree(map->field_offs);
 free_map:
 	btf_put(map->btf);
 	map->ops->map_free(map);
--=20
2.34.1


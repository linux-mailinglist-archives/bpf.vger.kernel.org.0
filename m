Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8627DF81
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgI3E2Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10058 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgI3E2Y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:24 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4SJQ9021027
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mB3s5/FJri5tbAwdBl6FAX2+1wPbtj+OZtFVZQs5FHo=;
 b=K906t3AaRK3PST3UtAUNZSP7leYBVJPQmiQQUdzKe8g45MLUHSvfGTinW2fzdOi4HSIK
 nlleChXYpCxlpPhKL8XqSSINaEeDORbnFawP0pE9P+8woR/5runI7cXNnppR+xMFt5pE
 W1IBJAHSX2HDeiQJHpwZzfVLeFZGM0A5WXM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33t3fhh1nv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:20 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:00 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 8B2BD2EC77F1; Tue, 29 Sep 2020 21:28:00 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 04/11] btf_loader: use libbpf to load BTF
Date:   Tue, 29 Sep 2020 21:27:35 -0700
Message-ID: <20200930042742.2525310-5-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 suspectscore=38 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch BTF loading to completely use libbpf's own struct btf and related =
APIs.
BTF encoding is still happening with pahole's own code, so these two code
paths are not sharing anything now. String fetching is happening based on
whether btfe->strings were set to non-NULL pointer by btf_encoder.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_loader.c | 244 +++++++++++++++++++--------------------------------
 libbtf.c     | 116 +++++-------------------
 libbtf.h     |  11 +--
 3 files changed, 113 insertions(+), 258 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 9db76957a7e5..c31ee61060f1 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -46,21 +46,17 @@ static void *tag__alloc(const size_t size)
 }
=20
 static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto=
, uint32_t tag,
-			       uint32_t type, uint16_t vlen, struct btf_param *args, uint32_t=
 id)
+			       const struct btf_type *tp, uint32_t id)
 {
-	int i;
+	const struct btf_param *param =3D btf_params(tp);
+	int i, vlen =3D btf_vlen(tp);
=20
 	proto->tag.tag	=3D tag;
-	proto->tag.type =3D type;
+	proto->tag.type =3D tp->type;
 	INIT_LIST_HEAD(&proto->parms);
=20
-	for (i =3D 0; i < vlen; ++i) {
-		struct btf_param param =3D {
-		       .name_off =3D btf_elf__get32(btfe, &args[i].name_off),
-		       .type	 =3D btf_elf__get32(btfe, &args[i].type),
-		};
-
-		if (param.type =3D=3D 0)
+	for (i =3D 0; i < vlen; ++i, param++) {
+		if (param->type =3D=3D 0)
 			proto->unspec_parms =3D 1;
 		else {
 			struct parameter *p =3D tag__alloc(sizeof(*p));
@@ -68,25 +64,22 @@ static int btf_elf__load_ftype(struct btf_elf *btfe, =
struct ftype *proto, uint32
 			if (p =3D=3D NULL)
 				goto out_free_parameters;
 			p->tag.tag  =3D DW_TAG_formal_parameter;
-			p->tag.type =3D param.type;
-			p->name	    =3D param.name_off;
+			p->tag.type =3D param->type;
+			p->name	    =3D param->name_off;
 			ftype__add_parameter(proto, p);
 		}
 	}
=20
-	vlen *=3D sizeof(*args);
 	cu__add_tag_with_id(btfe->priv, &proto->tag, id);
=20
-	return vlen;
+	return 0;
 out_free_parameters:
 	ftype__delete(proto, btfe->priv);
 	return -ENOMEM;
 }
=20
-static int create_new_function(struct btf_elf *btfe, struct btf_type *tp=
, uint64_t size, uint32_t id)
+static int create_new_function(struct btf_elf *btfe, const struct btf_ty=
pe *tp, uint32_t id)
 {
-	strings_t name =3D btf_elf__get32(btfe, &tp->name_off);
-	unsigned int type_id =3D btf_elf__get32(btfe, &tp->type);
 	struct function *func =3D tag__alloc(sizeof(*func));
=20
 	if (func =3D=3D NULL)
@@ -96,8 +89,8 @@ static int create_new_function(struct btf_elf *btfe, st=
ruct btf_type *tp, uint64
 	// but the prototype, the return type is the one in type_id
 	func->btf =3D 1;
 	func->proto.tag.tag =3D DW_TAG_subprogram;
-	func->proto.tag.type =3D type_id;
-	func->name =3D name;
+	func->proto.tag.type =3D tp->type;
+	func->name =3D tp->name_off;
 	cu__add_tag_with_id(btfe->priv, &func->proto.tag, id);
=20
 	return 0;
@@ -165,26 +158,24 @@ static struct variable *variable__new(strings_t nam=
e, uint32_t linkage)
 	return var;
 }
=20
-static int create_new_base_type(struct btf_elf *btfe, void *ptr, struct =
btf_type *tp, uint32_t id)
+static int create_new_base_type(struct btf_elf *btfe, const struct btf_t=
ype *tp, uint32_t id)
 {
-	uint32_t *enc =3D ptr;
-	uint32_t eval =3D btf_elf__get32(btfe, enc);
-	uint32_t attrs =3D BTF_INT_ENCODING(eval);
-	strings_t name =3D btf_elf__get32(btfe, &tp->name_off);
-	struct base_type *base =3D base_type__new(name, attrs, 0,
-						BTF_INT_BITS(eval));
+	uint32_t attrs =3D btf_int_encoding(tp);
+	strings_t name =3D tp->name_off;
+	struct base_type *base =3D base_type__new(name, attrs, 0, btf_int_bits(=
tp));
+
 	if (base =3D=3D NULL)
 		return -ENOMEM;
=20
 	base->tag.tag =3D DW_TAG_base_type;
 	cu__add_tag_with_id(btfe->priv, &base->tag, id);
=20
-	return sizeof(*enc);
+	return 0;
 }
=20
-static int create_new_array(struct btf_elf *btfe, void *ptr, uint32_t id=
)
+static int create_new_array(struct btf_elf *btfe, const struct btf_type =
*tp, uint32_t id)
 {
-	struct btf_array *ap =3D ptr;
+	struct btf_array *ap =3D btf_array(tp);
 	struct array_type *array =3D tag__alloc(sizeof(*array));
=20
 	if (array =3D=3D NULL)
@@ -200,81 +191,67 @@ static int create_new_array(struct btf_elf *btfe, v=
oid *ptr, uint32_t id)
 		return -ENOMEM;
 	}
=20
-	array->nr_entries[0] =3D btf_elf__get32(btfe, &ap->nelems);
+	array->nr_entries[0] =3D ap->nelems;
 	array->tag.tag =3D DW_TAG_array_type;
-	array->tag.type =3D btf_elf__get32(btfe, &ap->type);
+	array->tag.type =3D ap->type;
=20
 	cu__add_tag_with_id(btfe->priv, &array->tag, id);
=20
-	return sizeof(*ap);
+	return 0;
 }
=20
-static int create_members(struct btf_elf *btfe, void *ptr, int vlen, str=
uct type *class,
-			  bool kflag)
+static int create_members(struct btf_elf *btfe, const struct btf_type *t=
p,
+			  struct type *class)
 {
-	struct btf_member *mp =3D ptr;
-	int i;
+	struct btf_member *mp =3D btf_members(tp);
+	int i, vlen =3D btf_vlen(tp);
=20
 	for (i =3D 0; i < vlen; i++) {
 		struct class_member *member =3D zalloc(sizeof(*member));
-		uint32_t offset;
=20
 		if (member =3D=3D NULL)
 			return -ENOMEM;
=20
 		member->tag.tag    =3D DW_TAG_member;
-		member->tag.type   =3D btf_elf__get32(btfe, &mp[i].type);
-		member->name	   =3D btf_elf__get32(btfe, &mp[i].name_off);
-		offset =3D btf_elf__get32(btfe, &mp[i].offset);
-		if (kflag) {
-			member->bit_offset =3D BTF_MEMBER_BIT_OFFSET(offset);
-			member->bitfield_size =3D BTF_MEMBER_BITFIELD_SIZE(offset);
-		} else {
-			member->bit_offset =3D offset;
-			member->bitfield_size =3D 0;
-		}
+		member->tag.type   =3D mp[i].type;
+		member->name	   =3D mp[i].name_off;
+		member->bit_offset =3D btf_member_bit_offset(tp, i);
+		member->bitfield_size =3D btf_member_bitfield_size(tp, i);
 		member->byte_offset =3D member->bit_offset / 8;
 		/* sizes and offsets will be corrected at class__fixup_btf_bitfields *=
/
 		type__add_member(class, member);
 	}
=20
-	return sizeof(*mp);
+	return 0;
 }
=20
-static int create_new_class(struct btf_elf *btfe, void *ptr, int vlen,
-			    struct btf_type *tp, uint64_t size, uint32_t id,
-			    bool kflag)
+static int create_new_class(struct btf_elf *btfe, const struct btf_type =
*tp, uint32_t id)
 {
-	strings_t name =3D btf_elf__get32(btfe, &tp->name_off);
-	struct class *class =3D class__new(name, size);
-	int member_size =3D create_members(btfe, ptr, vlen, &class->type, kflag=
);
+	struct class *class =3D class__new(tp->name_off, tp->size);
+	int member_size =3D create_members(btfe, tp, &class->type);
=20
 	if (member_size < 0)
 		goto out_free;
=20
 	cu__add_tag_with_id(btfe->priv, &class->type.namespace.tag, id);
=20
-	return (vlen * member_size);
+	return 0;
 out_free:
 	class__delete(class, btfe->priv);
 	return -ENOMEM;
 }
=20
-static int create_new_union(struct btf_elf *btfe, void *ptr,
-			    int vlen, struct btf_type *tp,
-			    uint64_t size, uint32_t id,
-			    bool kflag)
+static int create_new_union(struct btf_elf *btfe, const struct btf_type =
*tp, uint32_t id)
 {
-	strings_t name =3D btf_elf__get32(btfe, &tp->name_off);
-	struct type *un =3D type__new(DW_TAG_union_type, name, size);
-	int member_size =3D create_members(btfe, ptr, vlen, un, kflag);
+	struct type *un =3D type__new(DW_TAG_union_type, tp->name_off, tp->size=
);
+	int member_size =3D create_members(btfe, tp, un);
=20
 	if (member_size < 0)
 		goto out_free;
=20
 	cu__add_tag_with_id(btfe->priv, &un->namespace.tag, id);
=20
-	return (vlen * member_size);
+	return 0;
 out_free:
 	type__delete(un, btfe->priv);
 	return -ENOMEM;
@@ -293,22 +270,20 @@ static struct enumerator *enumerator__new(strings_t=
 name, uint32_t value)
 	return en;
 }
=20
-static int create_new_enumeration(struct btf_elf *btfe, void *ptr,
-				  int vlen, struct btf_type *tp,
-				  uint16_t size, uint32_t id)
+static int create_new_enumeration(struct btf_elf *btfe, const struct btf=
_type *tp, uint32_t id)
 {
-	struct btf_enum *ep =3D ptr;
-	uint16_t i;
+	struct btf_enum *ep =3D btf_enum(tp);
+	uint16_t i, vlen =3D btf_vlen(tp);
 	struct type *enumeration =3D type__new(DW_TAG_enumeration_type,
-					     btf_elf__get32(btfe, &tp->name_off),
-					     size ? size * 8 : (sizeof(int) * 8));
+					     tp->name_off,
+					     tp->size ? tp->size * 8 : (sizeof(int) * 8));
=20
 	if (enumeration =3D=3D NULL)
 		return -ENOMEM;
=20
 	for (i =3D 0; i < vlen; i++) {
-		strings_t name =3D btf_elf__get32(btfe, &ep[i].name_off);
-		uint32_t value =3D btf_elf__get32(btfe, (uint32_t *)&ep[i].val);
+		strings_t name =3D ep[i].name_off;
+		uint32_t value =3D ep[i].val;
 		struct enumerator *enumerator =3D enumerator__new(name, value);
=20
 		if (enumerator =3D=3D NULL)
@@ -319,32 +294,25 @@ static int create_new_enumeration(struct btf_elf *b=
tfe, void *ptr,
=20
 	cu__add_tag_with_id(btfe->priv, &enumeration->namespace.tag, id);
=20
-	return (vlen * sizeof(*ep));
+	return 0;
 out_free:
 	enumeration__delete(enumeration, btfe->priv);
 	return -ENOMEM;
 }
=20
-static int create_new_subroutine_type(struct btf_elf *btfe, void *ptr,
-				      int vlen, struct btf_type *tp,
-				      uint32_t id)
+static int create_new_subroutine_type(struct btf_elf *btfe, const struct=
 btf_type *tp, uint32_t id)
 {
-	struct btf_param *args =3D ptr;
-	unsigned int type =3D btf_elf__get32(btfe, &tp->type);
 	struct ftype *proto =3D tag__alloc(sizeof(*proto));
=20
 	if (proto =3D=3D NULL)
 		return -ENOMEM;
=20
-	vlen =3D btf_elf__load_ftype(btfe, proto, DW_TAG_subroutine_type, type,=
 vlen, args, id);
-	return vlen < 0 ? -ENOMEM : vlen;
+	return btf_elf__load_ftype(btfe, proto, DW_TAG_subroutine_type, tp, id)=
;
 }
=20
-static int create_new_forward_decl(struct btf_elf *btfe, struct btf_type=
 *tp,
-				   uint64_t size, uint32_t id)
+static int create_new_forward_decl(struct btf_elf *btfe, const struct bt=
f_type *tp, uint32_t id)
 {
-	strings_t name =3D btf_elf__get32(btfe, &tp->name_off);
-	struct class *fwd =3D class__new(name, size);
+	struct class *fwd =3D class__new(tp->name_off, 0);
=20
 	if (fwd =3D=3D NULL)
 		return -ENOMEM;
@@ -353,41 +321,33 @@ static int create_new_forward_decl(struct btf_elf *=
btfe, struct btf_type *tp,
 	return 0;
 }
=20
-static int create_new_typedef(struct btf_elf *btfe, struct btf_type *tp,=
 uint64_t size, uint32_t id)
+static int create_new_typedef(struct btf_elf *btfe, const struct btf_typ=
e *tp, uint32_t id)
 {
-	strings_t name =3D btf_elf__get32(btfe, &tp->name_off);
-	unsigned int type_id =3D btf_elf__get32(btfe, &tp->type);
-	struct type *type =3D type__new(DW_TAG_typedef, name, size);
+	struct type *type =3D type__new(DW_TAG_typedef, tp->name_off, 0);
=20
 	if (type =3D=3D NULL)
 		return -ENOMEM;
=20
-	type->namespace.tag.type =3D type_id;
+	type->namespace.tag.type =3D tp->type;
 	cu__add_tag_with_id(btfe->priv, &type->namespace.tag, id);
=20
 	return 0;
 }
=20
-static int create_new_variable(struct btf_elf *btfe, void *ptr, struct b=
tf_type *tp,
-			       uint64_t size, uint32_t id)
+static int create_new_variable(struct btf_elf *btfe, const struct btf_ty=
pe *tp, uint32_t id)
 {
-	strings_t name =3D btf_elf__get32(btfe, &tp->name_off);
-	unsigned int type_id =3D btf_elf__get32(btfe, &tp->type);
-	struct btf_var *bvar =3D ptr;
-	uint32_t linkage =3D btf_elf__get32(btfe, &bvar->linkage);
-	struct variable *var =3D variable__new(name, linkage);
+	struct btf_var *bvar =3D btf_var(tp);
+	struct variable *var =3D variable__new(tp->name_off, bvar->linkage);
=20
 	if (var =3D=3D NULL)
 		return -ENOMEM;
=20
-	var->ip.tag.type =3D type_id;
+	var->ip.tag.type =3D tp->type;
 	cu__add_tag_with_id(btfe->priv, &var->ip.tag, id);
-	return sizeof(*bvar);
+	return 0;
 }
=20
-static int create_new_datasec(struct btf_elf *btfe, void *ptr, int vlen,
-			      struct btf_type *tp, uint64_t size, uint32_t id,
-			      bool kflag)
+static int create_new_datasec(struct btf_elf *btfe, const struct btf_typ=
e *tp, uint32_t id)
 {
 	//strings_t name =3D btf_elf__get32(btfe, &tp->name_off);
=20
@@ -397,12 +357,11 @@ static int create_new_datasec(struct btf_elf *btfe,=
 void *ptr, int vlen,
 	 * FIXME: this will not be used to reconstruct some original C code,
 	 * its about runtime placement of variables so just ignore this for now
 	 */
-	return vlen * sizeof(struct btf_var_secinfo);
+	return 0;
 }
=20
-static int create_new_tag(struct btf_elf *btfe, int type, struct btf_typ=
e *tp, uint32_t id)
+static int create_new_tag(struct btf_elf *btfe, int type, const struct b=
tf_type *tp, uint32_t id)
 {
-	unsigned int type_id =3D btf_elf__get32(btfe, &tp->type);
 	struct tag *tag =3D zalloc(sizeof(*tag));
=20
 	if (tag =3D=3D NULL)
@@ -419,104 +378,77 @@ static int create_new_tag(struct btf_elf *btfe, in=
t type, struct btf_type *tp, u
 		return 0;
 	}
=20
-	tag->type =3D type_id;
+	tag->type =3D tp->type;
 	cu__add_tag_with_id(btfe->priv, tag, id);
=20
 	return 0;
 }
=20
-void *btf_elf__get_buffer(struct btf_elf *btfe)
-{
-	return btfe->data;
-}
-
-size_t btf_elf__get_size(struct btf_elf *btfe)
-{
-	return btfe->size;
-}
-
 static int btf_elf__load_types(struct btf_elf *btfe)
 {
-	void *btf_buffer =3D btf_elf__get_buffer(btfe);
-	struct btf_header *hp =3D btf_buffer;
-	void *btf_contents =3D btf_buffer + sizeof(*hp),
-	     *type_section =3D (btf_contents + btf_elf__get32(btfe, &hp->type_o=
ff)),
-	     *strings_section =3D (btf_contents + btf_elf__get32(btfe, &hp->str=
_off));
-	struct btf_type *type_ptr =3D type_section,
-			*end =3D strings_section;
-	uint32_t type_index =3D 0x0001;
-
-	while (type_ptr < end) {
-		uint32_t val  =3D btf_elf__get32(btfe, &type_ptr->info);
-		uint32_t type =3D BTF_INFO_KIND(val);
-		int	 vlen =3D BTF_INFO_VLEN(val);
-		void	 *ptr =3D type_ptr;
-		uint32_t size =3D btf_elf__get32(btfe, &type_ptr->size);
-		bool     kflag =3D BTF_INFO_KFLAG(val);
-
-		ptr +=3D sizeof(struct btf_type);
+	uint32_t type_index;
+	int err;
+
+	for (type_index =3D 1; type_index <=3D btf__get_nr_types(btfe->btf); ty=
pe_index++) {
+		const struct btf_type *type_ptr =3D btf__type_by_id(btfe->btf, type_in=
dex);
+		uint32_t type =3D btf_kind(type_ptr);
=20
 		switch (type) {
 		case BTF_KIND_INT:
-			vlen =3D create_new_base_type(btfe, ptr, type_ptr, type_index);
+			err =3D create_new_base_type(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_ARRAY:
-			vlen =3D create_new_array(btfe, ptr, type_index);
+			err =3D create_new_array(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_STRUCT:
-			vlen =3D create_new_class(btfe, ptr, vlen, type_ptr, size, type_index=
, kflag);
+			err =3D create_new_class(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_UNION:
-			vlen =3D create_new_union(btfe, ptr, vlen, type_ptr, size, type_index=
, kflag);
+			err =3D create_new_union(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_ENUM:
-			vlen =3D create_new_enumeration(btfe, ptr, vlen, type_ptr, size, type=
_index);
+			err =3D create_new_enumeration(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_FWD:
-			vlen =3D create_new_forward_decl(btfe, type_ptr, size, type_index);
+			err =3D create_new_forward_decl(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_TYPEDEF:
-			vlen =3D create_new_typedef(btfe, type_ptr, size, type_index);
+			err =3D create_new_typedef(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_VAR:
-			vlen =3D create_new_variable(btfe, ptr, type_ptr, size, type_index);
+			err =3D create_new_variable(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_DATASEC:
-			vlen =3D create_new_datasec(btfe, ptr, vlen, type_ptr, size, type_ind=
ex, kflag);
+			err =3D create_new_datasec(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_VOLATILE:
 		case BTF_KIND_PTR:
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
-			vlen =3D create_new_tag(btfe, type, type_ptr, type_index);
+			err =3D create_new_tag(btfe, type, type_ptr, type_index);
 			break;
 		case BTF_KIND_UNKN:
 			cu__table_nullify_type_entry(btfe->priv, type_index);
-			fprintf(stderr, "BTF: idx: %d, off: %zd, Unknown kind %d\n",
-				type_index, ((void *)type_ptr) - type_section, type);
+			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
 			fflush(stderr);
-			vlen =3D 0;
+			err =3D 0;
 			break;
 		case BTF_KIND_FUNC_PROTO:
-			vlen =3D create_new_subroutine_type(btfe, ptr, vlen, type_ptr, type_i=
ndex);
+			err =3D create_new_subroutine_type(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_FUNC:
 			// BTF_KIND_FUNC corresponding to a defined subprogram.
-			vlen =3D create_new_function(btfe, type_ptr, size, type_index);
+			err =3D create_new_function(btfe, type_ptr, type_index);
 			break;
 		default:
-			fprintf(stderr, "BTF: idx: %d, off: %zd, Unknown kind %d\n",
-				type_index, ((void *)type_ptr) - type_section, type);
+			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
 			fflush(stderr);
-			vlen =3D 0;
+			err =3D 0;
 			break;
 		}
=20
-		if (vlen < 0)
-			return vlen;
-
-		type_ptr =3D ptr + vlen;
-		type_index++;
+		if (err < 0)
+			return err;
 	}
 	return 0;
 }
diff --git a/libbtf.c b/libbtf.c
index 7a01ded4e612..02a55dbd7e13 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -62,89 +62,29 @@ static int btf_var_secinfo_cmp(const void *a, const v=
oid *b)
 	return av->offset - bv->offset;
 }
=20
-uint32_t btf_elf__get32(struct btf_elf *btfe, uint32_t *p)
-{
-	uint32_t val =3D *p;
-
-	if (btfe->swapped)
-		val =3D ((val >> 24) |
-		       ((val >> 8) & 0x0000ff00) |
-		       ((val << 8) & 0x00ff0000) |
-		       (val << 24));
-	return val;
-}
-
-static int btf_raw__load(struct btf_elf *btfe)
+static int libbpf_log(enum libbpf_print_level level, const char *format,=
 va_list args)
 {
-        size_t read_cnt;
-        struct stat st;
-        void *data;
-        FILE *fp;
-
-        if (stat(btfe->filename, &st))
-                return -1;
-
-        data =3D malloc(st.st_size);
-        if (!data)
-                return -1;
-
-        fp =3D fopen(btfe->filename, "rb");
-        if (!fp)
-                goto cleanup;
-
-        read_cnt =3D fread(data, 1, st.st_size, fp);
-        fclose(fp);
-        if (read_cnt < st.st_size)
-                goto cleanup;
-
-	btfe->swapped	=3D 0;
-	btfe->data	=3D data;
-	btfe->size	=3D read_cnt;
-	return 0;
-cleanup:
-        free(data);
-        return -1;
+	return vfprintf(stderr, format, args);
 }
=20
 int btf_elf__load(struct btf_elf *btfe)
 {
-	if (btfe->raw_btf)
-		return btf_raw__load(btfe);
-
-	int err =3D -ENOTSUP;
-	GElf_Shdr shdr;
-	Elf_Scn *sec =3D elf_section_by_name(btfe->elf, &btfe->ehdr, &shdr, ".B=
TF", NULL);
+	int err;
=20
-	if (sec =3D=3D NULL)
-		return -ESRCH;
-
-	Elf_Data *data =3D elf_getdata(sec, NULL);
-	if (data =3D=3D NULL) {
-		fprintf(stderr, "%s: cannot get data of BTF section.\n", __func__);
-		return -1;
-	}
-
-	struct btf_header *hp =3D data->d_buf;
-	size_t orig_size =3D data->d_size;
-
-	if (hp->version !=3D BTF_VERSION)
-		goto out;
+	libbpf_set_print(libbpf_log);
=20
-	err =3D -EINVAL;
-	if (hp->magic =3D=3D BTF_MAGIC)
-		btfe->swapped =3D 0;
+	/* free initial empty BTF */
+	btf__free(btfe->btf);
+	if (btfe->raw_btf)
+		btfe->btf =3D btf__parse_raw(btfe->filename);
 	else
-		goto out;
+		btfe->btf =3D btf__parse_elf(btfe->filename, NULL);
=20
-	err =3D -ENOMEM;
-	btfe->data =3D malloc(orig_size);
-	if (btfe->data !=3D NULL) {
-		memcpy(btfe->data, hp, orig_size);
-		btfe->size =3D orig_size;
-		err =3D 0;
-	}
-out:
-	return err;
+	err =3D libbpf_get_error(btfe->btf);
+	if (err)
+		return err;
+
+	return 0;
 }
=20
=20
@@ -251,26 +191,17 @@ void btf_elf__delete(struct btf_elf *btfe)
=20
 	__gobuffer__delete(&btfe->types);
 	__gobuffer__delete(&btfe->percpu_secinfo);
+	btf__free(btfe->btf);
 	free(btfe->filename);
 	free(btfe->data);
 	free(btfe);
 }
=20
-char *btf_elf__string(struct btf_elf *btfe, uint32_t ref)
+const char *btf_elf__string(struct btf_elf *btfe, uint32_t ref)
 {
-	struct btf_header *hp =3D btfe->hdr;
-	uint32_t off =3D ref;
-	char *name;
-
-	if (off >=3D btf_elf__get32(btfe, &hp->str_len))
-		return "(ref out-of-bounds)";
-
-	if ((off + btf_elf__get32(btfe, &hp->str_off)) >=3D btfe->size)
-		return "(string table truncated)";
+	const char *s =3D btf__str_by_offset(btfe->btf, ref);
=20
-	name =3D ((char *)(hp + 1) + btf_elf__get32(btfe, &hp->str_off) + off);
-
-	return name[0] =3D=3D '\0' ? NULL : name;
+	return s && s[0] =3D=3D '\0' ? NULL : s;
 }
=20
 static void *btf_elf__nohdr_data(struct btf_elf *btfe)
@@ -310,8 +241,10 @@ static const char *btf_elf__name_in_gobuf(const stru=
ct btf_elf *btfe, uint32_t o
 {
 	if (!offset)
 		return "(anon)";
-	else
+	else if (btfe->strings)
 		return &btfe->strings->entries[offset];
+	else
+		return btf__str_by_offset(btfe->btf, offset);
 }
=20
 static const char * btf_elf__int_encoding_str(uint8_t encoding)
@@ -836,11 +769,6 @@ out:
 	return err;
 }
=20
-static int libbpf_log(enum libbpf_print_level level, const char *format,=
 va_list args)
-{
-	return vfprintf(stderr, format, args);
-}
-
 int btf_elf__encode(struct btf_elf *btfe, uint8_t flags)
 {
 	struct btf_header *hdr;
@@ -886,7 +814,7 @@ int btf_elf__encode(struct btf_elf *btfe, uint8_t fla=
gs)
 		return -1;
 	}
 	if (btf__dedup(btf, NULL, NULL)) {
-		fprintf(stderr, "%s: btf__dedup failed!", __func__);
+		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
 	}
=20
diff --git a/libbtf.h b/libbtf.h
index be06480bf854..5f29b427c4fd 100644
--- a/libbtf.h
+++ b/libbtf.h
@@ -11,6 +11,7 @@
=20
 #include <stdbool.h>
 #include <stdint.h>
+#include "lib/bpf/src/btf.h"
=20
 struct btf_elf {
 	union {
@@ -26,7 +27,6 @@ struct btf_elf {
 	struct gobuffer   percpu_secinfo;
 	char		  *filename;
 	size_t		  size;
-	int		  swapped;
 	int		  in_fd;
 	uint8_t		  wordsize;
 	bool		  is_big_endian;
@@ -34,6 +34,7 @@ struct btf_elf {
 	uint32_t	  type_index;
 	uint32_t	  percpu_shndx;
 	uint64_t	  percpu_base_addr;
+	struct btf	  *btf;
 };
=20
 extern uint8_t btf_elf__verbose;
@@ -70,13 +71,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe=
, const char *section_name
 void btf_elf__set_strings(struct btf_elf *btf, struct gobuffer *strings)=
;
 int  btf_elf__encode(struct btf_elf *btf, uint8_t flags);
=20
-char *btf_elf__string(struct btf_elf *btf, uint32_t ref);
+const char *btf_elf__string(struct btf_elf *btf, uint32_t ref);
 int btf_elf__load(struct btf_elf *btf);
=20
-uint32_t btf_elf__get32(struct btf_elf *btf, uint32_t *p);
-
-void *btf_elf__get_buffer(struct btf_elf *btf);
-
-size_t btf_elf__get_size(struct btf_elf *btf);
-
 #endif /* _LIBBTF_H */
--=20
2.24.1


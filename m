Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E40C43A7F6
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhJYXEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 19:04:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234415AbhJYXEs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 19:04:48 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMiVNp001546
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:02:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=GJxcjDpboT/z5ZFkETewbIMI32iTXzDMkoypypbpCGU=;
 b=LRFw6dMQ2GNuS013yNOJ/ciD33xq2y93YAjiqwHreJN2Hh5AW3LPaiWpqKoHuSUIR8Q3
 XD7Y3+vNSNebmsQvYcexjPmfkdIs6bqxXofPwfkWk/bFf0iOjdQ0HPnTxdCcasb+t2ml
 GiJ/RpbuCCwulJLRXGHwsrf3vD+dHAhrj8k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4e7gky0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 16:02:24 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 16:02:24 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1F7D6181A2B6; Mon, 25 Oct 2021 16:02:20 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves] btf: rename btf_tag to btf_decl_tag
Date:   Mon, 25 Oct 2021 16:02:20 -0700
Message-ID: <20211025230220.3250968-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: UeVNaoQywUQ3aHH-4POvkT5ek_L79JSJ
X-Proofpoint-ORIG-GUID: UeVNaoQywUQ3aHH-4POvkT5ek_L79JSJ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110250131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kernel commit ([1]) renamed btf_tag to btf_decl_tag
for uapi btf.h and libbpf api's. The reason is a new
clang attribute, btf_type_tag, is introduced ([2]).
Renaming btf_tag to btf_decl_tag makes it easier to
distinghish from btf_type_tag.

I also pulled in latest libbpf repo since it
contains renamed libbpf api function btf__add_decl_tag().

  [1] https://lore.kernel.org/bpf/20211012164838.3345699-1-yhs@fb.com/
  [2] https://reviews.llvm.org/D111199

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c  | 16 ++++++++--------
 dwarf_loader.c |  6 +++---
 dwarves.h      |  2 +-
 lib/bpf        |  2 +-
 pahole.c       | 12 ++++++------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c341f95..968af92 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -141,7 +141,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_VAR]          =3D "VAR",
 	[BTF_KIND_DATASEC]      =3D "DATASEC",
 	[BTF_KIND_FLOAT]        =3D "FLOAT",
-	[BTF_KIND_TAG]          =3D "TAG",
+	[BTF_KIND_DECL_TAG]     =3D "DECL_TAG",
 };
=20
 static const char *btf__printable_name(const struct btf *btf, uint32_t off=
set)
@@ -645,20 +645,20 @@ static int32_t btf_encoder__add_datasec(struct btf_en=
coder *encoder, const char
 	return id;
 }
=20
-static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const cha=
r *value, uint32_t type,
-				    int component_idx)
+static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, cons=
t char *value, uint32_t type,
+					 int component_idx)
 {
 	struct btf *btf =3D encoder->btf;
 	const struct btf_type *t;
 	int32_t id;
=20
-	id =3D btf__add_tag(btf, value, type, component_idx);
+	id =3D btf__add_decl_tag(btf, value, type, component_idx);
 	if (id > 0) {
 		t =3D btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "type_id=3D%u component_i=
dx=3D%d",
 				      t->type, component_idx);
 	} else {
-		btf__log_err(btf, BTF_KIND_TAG, value, true, "component_idx=3D%d Error e=
mitting BTF type",
+		btf__log_err(btf, BTF_KIND_DECL_TAG, value, true, "component_idx=3D%d Er=
ror emitting BTF type",
 			     component_idx);
 	}
=20
@@ -1267,7 +1267,7 @@ static int btf_encoder__encode_cu_variables(struct bt=
f_encoder *encoder, struct
 		}
=20
 		list_for_each_entry(annot, &var->annots, node) {
-			int tag_type_id =3D btf_encoder__add_tag(encoder, annot->value, id, ann=
ot->component_idx);
+			int tag_type_id =3D btf_encoder__add_decl_tag(encoder, annot->value, id=
, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to variable '%s' wit=
h component_idx %d\n",
 					annot->value, name, annot->component_idx);
@@ -1438,7 +1438,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu)
 		btf_type_id =3D type_id_off + core_id;
 		ns =3D tag__namespace(pos);
 		list_for_each_entry(annot, &ns->annots, node) {
-			tag_type_id =3D btf_encoder__add_tag(encoder, annot->value, btf_type_id=
, annot->component_idx);
+			tag_type_id =3D btf_encoder__add_decl_tag(encoder, annot->value, btf_ty=
pe_id, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to %s '%s' with comp=
onent_idx %d\n",
 					annot->value, pos->tag =3D=3D DW_TAG_structure_type ? "struct" : "uni=
on",
@@ -1490,7 +1490,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu)
 		}
=20
 		list_for_each_entry(annot, &fn->annots, node) {
-			tag_type_id =3D btf_encoder__add_tag(encoder, annot->value, btf_fn_id, =
annot->component_idx);
+			tag_type_id =3D btf_encoder__add_decl_tag(encoder, annot->value, btf_fn=
_id, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to func %s with comp=
onent_idx %d\n",
 					annot->value, name, annot->component_idx);
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 48e1bf0..fc7490e 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -866,12 +866,12 @@ static int add_llvm_annotation(Dwarf_Die *die, int co=
mponent_idx, struct conf_lo
 	struct llvm_annotation *annot;
 	const char *name;
=20
-	if (conf->skip_encoding_btf_tag)
+	if (conf->skip_encoding_btf_decl_tag)
 		return 0;
=20
-	/* Only handle btf_tag annotation for now. */
+	/* Only handle btf_decl_tag annotation for now. */
 	name =3D attr_string(die, DW_AT_name, conf);
-	if (strcmp(name, "btf_tag") !=3D 0)
+	if (strcmp(name, "btf_decl_tag") !=3D 0)
 		return 0;
=20
 	annot =3D zalloc(sizeof(*annot));
diff --git a/dwarves.h b/dwarves.h
index 30d33fa..8e293bd 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -58,7 +58,7 @@ struct conf_load {
 	bool			ignore_inline_expansions;
 	bool			ignore_labels;
 	bool			ptr_table_stats;
-	bool			skip_encoding_btf_tag;
+	bool			skip_encoding_btf_decl_tag;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/lib/bpf b/lib/bpf
index 980777c..f05791d 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
+Subproject commit f05791d8cfcbbf9092b4099b9d011bb72e241ef8
diff --git a/pahole.c b/pahole.c
index 80271b5..23e1256 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1124,7 +1124,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_versi=
on;
 #define ARGP_sort_output	   328
 #define ARGP_hashbits		   329
 #define ARGP_devel_stats	   330
-#define ARGP_skip_encoding_btf_tag 331
+#define ARGP_skip_encoding_btf_decl_tag 331
=20
 static const struct argp_option pahole__options[] =3D {
 	{
@@ -1496,9 +1496,9 @@ static const struct argp_option pahole__options[] =3D=
 {
 		.doc  =3D "Print internal data structures stats",
 	},
 	{
-		.name =3D "skip_encoding_btf_tag",
-		.key  =3D ARGP_skip_encoding_btf_tag,
-		.doc  =3D "Do not encode TAGs in BTF."
+		.name =3D "skip_encoding_btf_decl_tag",
+		.key  =3D ARGP_skip_encoding_btf_decl_tag,
+		.doc  =3D "Do not encode DECL_TAGs in BTF."
 	},
 	{
 		.name =3D NULL,
@@ -1648,8 +1648,8 @@ static error_t pahole__options_parser(int key, char *=
arg,
 		conf_load.hashtable_bits =3D atoi(arg);	break;
 	case ARGP_devel_stats:
 		conf_load.ptr_table_stats =3D true;	break;
-	case ARGP_skip_encoding_btf_tag:
-		conf_load.skip_encoding_btf_tag =3D true;	break;
+	case ARGP_skip_encoding_btf_decl_tag:
+		conf_load.skip_encoding_btf_decl_tag =3D true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
--=20
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94253410E07
	for <lists+bpf@lfdr.de>; Mon, 20 Sep 2021 02:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhITAhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Sep 2021 20:37:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36012 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231184AbhITAhZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 19 Sep 2021 20:37:25 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18JNervj019559
        for <bpf@vger.kernel.org>; Sun, 19 Sep 2021 17:35:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=kEsdTA7mTXux4udHt4rwtSHYinliCqXgZz784GX4qsY=;
 b=AiDBio4UNafm8F/PMxakX0TEAQIjIySHZ1zyP8hgDGRHmaCo6Xcf4Y+o2LemB4umkDlG
 yO4uOgjkpOiT76HwuX0GyE4tJpTCWuX76rlVTOYPYGgpoDr1sl66zRxDZ1Tw1dNV6icF
 c1Q2UEJHoO+lGHhvPmMPDWkFN/ypTsI+4LE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6f2r844c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 19 Sep 2021 17:35:59 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 19 Sep 2021 17:35:58 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 518C27713272; Sun, 19 Sep 2021 17:35:50 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH dwarves 1/2] dwarf_loader: parse dwarf tag DW_TAG_LLVM_annotation
Date:   Sun, 19 Sep 2021 17:35:50 -0700
Message-ID: <20210920003550.3525047-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920003545.3524231-1-yhs@fb.com>
References: <20210920003545.3524231-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: hMVwoue4ypvq64OFxxEB2WPWGTh9tlR1
X-Proofpoint-GUID: hMVwoue4ypvq64OFxxEB2WPWGTh9tlR1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Parse dwarf tag DW_TAG_LLVM_annotation. Only record
annotations with btf_tag name which corresponds to
btf_tag attributes in C code. Such information will
be used later by btf_encoder for BTF conversion.

LLVM implementation only supports btf_tag annotations
on struct/union, func, func parameter and variable ([1]).
So we only check existence of corresponding DW tags
in these places. A flag "--skip_encoding_btf_tag"
is introduced if for whatever reason this feature
needs to be disabled.

 [1] https://reviews.llvm.org/D106614

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++----
 dwarves.h      | 10 ++++++
 pahole.c       |  8 +++++
 3 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 0213e42..48e1bf0 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -52,6 +52,10 @@
 #define DW_OP_addrx 0xa1
 #endif
=20
+#ifndef DW_TAG_LLVM_annotation
+#define DW_TAG_LLVM_annotation 0x6000
+#endif
+
 static pthread_mutex_t libdw__lock =3D PTHREAD_MUTEX_INITIALIZER;
=20
 static uint32_t hashtags__bits =3D 12;
@@ -602,6 +606,7 @@ static void namespace__init(struct namespace *namespace=
, Dwarf_Die *die,
 {
 	tag__init(&namespace->tag, cu, die);
 	INIT_LIST_HEAD(&namespace->tags);
+	INIT_LIST_HEAD(&namespace->annots);
 	namespace->name  =3D attr_string(die, DW_AT_name, conf);
 	namespace->nr_tags =3D 0;
 	namespace->shared_tags =3D 0;
@@ -719,6 +724,7 @@ static struct variable *variable__new(Dwarf_Die *die, s=
truct cu *cu, struct conf
 		/* non-defining declaration of an object */
 		var->declaration =3D dwarf_hasattr(die, DW_AT_declaration);
 		var->scope =3D VSCOPE_UNKNOWN;
+		INIT_LIST_HEAD(&var->annots);
 		var->ip.addr =3D 0;
 		if (!var->declaration && cu->has_addr_info)
 			var->scope =3D dwarf__location(die, &var->ip.addr, &var->location);
@@ -854,6 +860,51 @@ static int tag__recode_dwarf_bitfield(struct tag *tag,=
 struct cu *cu, uint16_t b
 	return -ENOMEM;
 }
=20
+static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct c=
onf_load *conf,
+			       struct list_head *head)
+{
+	struct llvm_annotation *annot;
+	const char *name;
+
+	if (conf->skip_encoding_btf_tag)
+		return 0;
+
+	/* Only handle btf_tag annotation for now. */
+	name =3D attr_string(die, DW_AT_name, conf);
+	if (strcmp(name, "btf_tag") !=3D 0)
+		return 0;
+
+	annot =3D zalloc(sizeof(*annot));
+	if (!annot)
+		return -ENOMEM;
+
+	annot->value =3D attr_string(die, DW_AT_const_value, conf);
+	annot->component_idx =3D component_idx;
+	list_add_tail(&annot->node, head);
+	return 0;
+}
+
+static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
+				      struct conf_load *conf, struct list_head *head)
+{
+	Dwarf_Die child;
+	int ret;
+
+	if (!dwarf_haschildren(die) || dwarf_child(die, &child) !=3D 0)
+		return 0;
+
+	die =3D &child;
+	do {
+		if (dwarf_tag(die) =3D=3D DW_TAG_LLVM_annotation) {
+			ret =3D add_llvm_annotation(die, component_idx, conf, head);
+			if (ret)
+				return ret;
+		}
+	} while (dwarf_siblingof(die, die) =3D=3D 0);
+
+	return 0;
+}
+
 int class_member__dwarf_recode_bitfield(struct class_member *member,
 					struct cu *cu)
 {
@@ -1092,6 +1143,7 @@ static struct function *function__new(Dwarf_Die *die,=
 struct cu *cu, struct conf
 		func->accessibility   =3D attr_numeric(die, DW_AT_accessibility);
 		func->virtuality      =3D attr_numeric(die, DW_AT_virtuality);
 		INIT_LIST_HEAD(&func->vtable_node);
+		INIT_LIST_HEAD(&func->annots);
 		INIT_LIST_HEAD(&func->tool_node);
 		func->vtable_entry    =3D -1;
 		if (dwarf_hasattr(die, DW_AT_vtable_elem_location))
@@ -1304,16 +1356,21 @@ static struct tag *die__create_new_string_type(Dwar=
f_Die *die, struct cu *cu)
 static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct ftype *ftype,
 					     struct lexblock *lexblock,
-					     struct cu *cu, struct conf_load *conf)
+					     struct cu *cu, struct conf_load *conf,
+					     int param_idx)
 {
 	struct parameter *parm =3D parameter__new(die, cu, conf);
=20
 	if (parm =3D=3D NULL)
 		return NULL;
=20
-	if (ftype !=3D NULL)
+	if (ftype !=3D NULL) {
 		ftype__add_parameter(ftype, parm);
-	else {
+		if (param_idx >=3D 0) {
+			if (add_child_llvm_annotations(die, param_idx, conf, &(tag__function(&f=
type->tag)->annots)))
+				return NULL;
+		}
+	} else {
 		/*
 		 * DW_TAG_formal_parameters on a non DW_TAG_subprogram nor
 		 * DW_TAG_subroutine_type tag happens sometimes, likely due to
@@ -1346,7 +1403,10 @@ static struct tag *die__create_new_variable(Dwarf_Di=
e *die, struct cu *cu, struc
 {
 	struct variable *var =3D variable__new(die, cu, conf);
=20
-	return var ? &var->ip.tag : NULL;
+	if (var =3D=3D NULL || add_child_llvm_annotations(die, -1, conf, &var->an=
nots))
+		return NULL;
+
+	return &var->ip.tag;
 }
=20
 static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
@@ -1371,7 +1431,7 @@ static struct tag *die__create_new_subroutine_type(Dw=
arf_Die *die,
 			tag__print_not_supported(dwarf_tag(die));
 			continue;
 		case DW_TAG_formal_parameter:
-			tag =3D die__create_new_parameter(die, ftype, NULL, cu, conf);
+			tag =3D die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
 			break;
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms =3D 1;
@@ -1455,6 +1515,7 @@ static int die__process_class(Dwarf_Die *die, struct =
type *class,
 			      struct cu *cu, struct conf_load *conf)
 {
 	const bool is_union =3D tag__is_union(&class->namespace.tag);
+	int member_idx =3D 0;
=20
 	do {
 		switch (dwarf_tag(die)) {
@@ -1497,8 +1558,15 @@ static int die__process_class(Dwarf_Die *die, struct=
 type *class,
=20
 			type__add_member(class, member);
 			cu__hash(cu, &member->tag);
+			if (add_child_llvm_annotations(die, member_idx, conf, &class->namespace=
.annots))
+				return -ENOMEM;
+			member_idx++;
 		}
 			continue;
+		case DW_TAG_LLVM_annotation:
+			if (add_llvm_annotation(die, -1, conf, &class->namespace.annots))
+				return -ENOMEM;
+			continue;
 		default: {
 			struct tag *tag =3D die__process_tag(die, cu, 0, conf);
=20
@@ -1699,6 +1767,7 @@ static struct tag *die__create_new_inline_expansion(D=
warf_Die *die,
 static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
 {
+	int param_idx =3D 0;
 	Dwarf_Die child;
 	struct tag *tag;
=20
@@ -1742,7 +1811,7 @@ static int die__process_function(Dwarf_Die *die, stru=
ct ftype *ftype,
 			tag__print_not_supported(dwarf_tag(die));
 			continue;
 		case DW_TAG_formal_parameter:
-			tag =3D die__create_new_parameter(die, ftype, lexblock, cu, conf);
+			tag =3D die__create_new_parameter(die, ftype, lexblock, cu, conf, param=
_idx++);
 			break;
 		case DW_TAG_variable:
 			tag =3D die__create_new_variable(die, cu, conf);
@@ -1771,6 +1840,10 @@ static int die__process_function(Dwarf_Die *die, str=
uct ftype *ftype,
 			if (die__create_new_lexblock(die, cu, lexblock, conf) !=3D 0)
 				goto out_enomem;
 			continue;
+		case DW_TAG_LLVM_annotation:
+			if (add_llvm_annotation(die, -1, conf, &(tag__function(&ftype->tag)->an=
nots)))
+				goto out_enomem;
+			continue;
 		default:
 			tag =3D die__process_tag(die, cu, 0, conf);
=20
diff --git a/dwarves.h b/dwarves.h
index 0b69312..30d33fa 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -58,6 +58,7 @@ struct conf_load {
 	bool			ignore_inline_expansions;
 	bool			ignore_labels;
 	bool			ptr_table_stats;
+	bool			skip_encoding_btf_tag;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
@@ -594,6 +595,12 @@ static inline struct ptr_to_member_type *
 	return (struct ptr_to_member_type *)tag;
 }
=20
+struct llvm_annotation {
+	const char		*value;
+	int16_t			component_idx;
+	struct list_head	node;
+};
+
 /** struct namespace - base class for enums, structs, unions, typedefs, etc
  *
  * @tags - class_member, enumerators, etc
@@ -605,6 +612,7 @@ struct namespace {
 	uint16_t	 nr_tags;
 	uint8_t		 shared_tags;
 	struct list_head tags;
+	struct list_head annots;
 };
=20
 static inline struct namespace *tag__namespace(const struct tag *tag)
@@ -686,6 +694,7 @@ struct variable {
 	enum vscope	 scope;
 	struct location	 location;
 	struct hlist_node tool_hnode;
+	struct list_head annots;
 	struct variable  *spec;
 };
=20
@@ -818,6 +827,7 @@ struct function {
 	uint8_t		 btf:1;
 	int32_t		 vtable_entry;
 	struct list_head vtable_node;
+	struct list_head annots;
 	/* fields used by tools */
 	union {
 		struct list_head  tool_node;
diff --git a/pahole.c b/pahole.c
index 7f1771b..80271b5 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1124,6 +1124,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_versi=
on;
 #define ARGP_sort_output	   328
 #define ARGP_hashbits		   329
 #define ARGP_devel_stats	   330
+#define ARGP_skip_encoding_btf_tag 331
=20
 static const struct argp_option pahole__options[] =3D {
 	{
@@ -1494,6 +1495,11 @@ static const struct argp_option pahole__options[] =
=3D {
 		.key  =3D ARGP_devel_stats,
 		.doc  =3D "Print internal data structures stats",
 	},
+	{
+		.name =3D "skip_encoding_btf_tag",
+		.key  =3D ARGP_skip_encoding_btf_tag,
+		.doc  =3D "Do not encode TAGs in BTF."
+	},
 	{
 		.name =3D NULL,
 	}
@@ -1642,6 +1648,8 @@ static error_t pahole__options_parser(int key, char *=
arg,
 		conf_load.hashtable_bits =3D atoi(arg);	break;
 	case ARGP_devel_stats:
 		conf_load.ptr_table_stats =3D true;	break;
+	case ARGP_skip_encoding_btf_tag:
+		conf_load.skip_encoding_btf_tag =3D true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
--=20
2.30.2


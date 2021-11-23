Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331F0459B54
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 05:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhKWE7i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 23:59:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36912 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232196AbhKWE7i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 23:59:38 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN3n3A8014424
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 20:56:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=55V/t2dsIVBsr/m39srW2ScG3rrwc17lYoziGXY7zWI=;
 b=SbtNZoqKbJc+1hd/ouCf721rNzis60gWVsSX6MccPdwpnLf5MwfC6Ltp3uljzAxMyJHE
 V/IA2l9EtSe/gMUEd9Vr60FQqYbIsI7ZjeBPRnav7LiNoPVMYk3uIoMrPM09AaK2/Mg/
 YJMbT7BsX9/Pq59LoEIoj1CXxRn2ali/izM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgrqj870a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 20:56:30 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 20:56:30 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1E5EE2CD49DD; Mon, 22 Nov 2021 20:56:28 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 3/4] dwarf_loader: support btf_type_tag attribute
Date:   Mon, 22 Nov 2021 20:56:28 -0800
Message-ID: <20211123045628.1388788-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123045612.1387544-1-yhs@fb.com>
References: <20211123045612.1387544-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: lwkXQhDyVrsXospbJ-lmd750N5MJ0cKC
X-Proofpoint-ORIG-GUID: lwkXQhDyVrsXospbJ-lmd750N5MJ0cKC
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_01,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111230025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LLVM patches ([1] for clang, [2] and [3] for BPF backend)
added support for btf_type_tag attributes. The following is
an example:
  [$ ~] cat t.c
  #define __tag1 __attribute__((btf_type_tag("tag1")))
  #define __tag2 __attribute__((btf_type_tag("tag2")))
  int __tag1 * __tag1 __tag2 *g __attribute__((section(".data..percpu")));
  [$ ~] clang -O2 -g -c t.c
  [$ ~] llvm-dwarfdump --debug-info t.o
  t.o:    file format elf64-x86-64
  ...
  0x0000001e:   DW_TAG_variable
                  DW_AT_name      ("g")
                  DW_AT_type      (0x00000033 "int **")
                  DW_AT_external  (true)
                  DW_AT_decl_file ("/home/yhs/t.c")
                  DW_AT_decl_line (3)
                  DW_AT_location  (DW_OP_addr 0x0)
  0x00000033:   DW_TAG_pointer_type
                  DW_AT_type      (0x0000004b "int *")
  0x00000038:     DW_TAG_LLVM_annotation
                    DW_AT_name    ("btf_type_tag")
                    DW_AT_const_value     ("tag1")
  0x00000041:     DW_TAG_LLVM_annotation
                    DW_AT_name    ("btf_type_tag")
                    DW_AT_const_value     ("tag2")
  0x0000004a:     NULL
  0x0000004b:   DW_TAG_pointer_type
                  DW_AT_type      (0x0000005a "int")
  0x00000050:     DW_TAG_LLVM_annotation
                    DW_AT_name    ("btf_type_tag")
                    DW_AT_const_value     ("tag1")
  0x00000059:     NULL
  0x0000005a:   DW_TAG_base_type
                  DW_AT_name      ("int")
                  DW_AT_encoding  (DW_ATE_signed)
                  DW_AT_byte_size (0x04)
  0x00000061:   NULL

From the above example, you can see that DW_TAG_pointer_type
may contain one or more DW_TAG_LLVM_annotation btf_type_tag tags.
If DW_TAG_LLVM_annotation tags are present inside
DW_TAG_pointer_type, for BTF encoding, pahole will need
to follow [3] to generate a type chain like
  var -> ptr -> tag2 -> tag1 -> ptr -> tag1 -> int

This patch implemented dwarf_loader support. If a pointer type
contains DW_TAG_LLVM_annotation tags, a new type
btf_type_tag_ptr_type will be created which will store
the pointer tag itself and all DW_TAG_LLVM_annotation tags.
During recoding stage, the type chain will be formed properly
based on the above example.

An option "--skip_encoding_btf_type_tag" is added to disable
this new functionality.

  [1] https://reviews.llvm.org/D111199
  [2] https://reviews.llvm.org/D113222
  [3] https://reviews.llvm.org/D113496
---
 dwarf_loader.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++--
 dwarves.h      |  33 +++++++++++-
 pahole.c       |   8 +++
 3 files changed, 173 insertions(+), 4 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1b07a62..e30b03c 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1206,6 +1206,89 @@ static struct tag *die__create_new_tag(Dwarf_Die *di=
e, struct cu *cu)
 	return tag;
 }
=20
+static struct btf_type_tag_ptr_type *die__create_new_btf_type_tag_ptr_type=
(Dwarf_Die *die, struct cu *cu)
+{
+	struct btf_type_tag_ptr_type *tag;
+
+	tag  =3D tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_ptr_type));
+	if (tag =3D=3D NULL)
+		return NULL;
+
+	tag__init(&tag->tag, cu, die);
+	tag->tag.has_btf_type_tag =3D true;
+	INIT_LIST_HEAD(&tag->tags);
+	return tag;
+}
+
+static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_D=
ie *die, struct cu *cu,
+								   struct conf_load *conf)
+{
+	struct btf_type_tag_type *tag;
+
+	tag  =3D tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_type));
+	if (tag =3D=3D NULL)
+		return NULL;
+
+	tag__init(&tag->tag, cu, die);
+	tag->value =3D attr_string(die, DW_AT_const_value, conf);
+	return tag;
+}
+
+static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *=
cu,
+					       struct conf_load *conf)
+{
+	struct btf_type_tag_ptr_type *tag =3D NULL;
+	struct btf_type_tag_type *annot;
+	Dwarf_Die *cdie, child;
+	const char *name;
+	uint32_t id;
+
+	/* If no child tags or skipping btf_type_tag encoding, just create a new =
tag
+	 * and return
+	 */
+	if (!dwarf_haschildren(die) || dwarf_child(die, &child) !=3D 0 ||
+	    conf->skip_encoding_btf_type_tag)
+		return tag__new(die, cu);
+
+	/* Otherwise, check DW_TAG_LLVM_annotation child tags */
+	cdie =3D &child;
+	do {
+		if (dwarf_tag(cdie) !=3D DW_TAG_LLVM_annotation)
+			continue;
+
+		/* Only check btf_type_tag annotations */
+		name =3D attr_string(cdie, DW_AT_name, conf);
+		if (strcmp(name, "btf_type_tag") !=3D 0)
+			continue;
+
+		if (tag =3D=3D NULL) {
+			/* Create a btf_type_tag_ptr type. */
+			tag =3D die__create_new_btf_type_tag_ptr_type(die, cu);
+			if (!tag)
+				return NULL;
+		}
+
+		/* Create a btf_type_tag type for this annotation. */
+		annot =3D die__create_new_btf_type_tag_type(cdie, cu, conf);
+		if (annot =3D=3D NULL)
+			return NULL;
+
+		if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
+			return NULL;
+
+		struct dwarf_tag *dtag =3D annot->tag.priv;
+		dtag->small_id =3D id;
+		cu__hash(cu, &annot->tag);
+
+		/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
+		 * the tag->tags contains tag3 -> tag2 -> tag1.
+		 */
+		list_add(&annot->node, &tag->tags);
+	} while (dwarf_siblingof(cdie, cdie) =3D=3D 0);
+
+	return tag ? &tag->tag : tag__new(die, cu);
+}
+
 static struct tag *die__create_new_ptr_to_member_type(Dwarf_Die *die,
 						      struct cu *cu)
 {
@@ -1903,12 +1986,13 @@ static struct tag *__die__process_tag(Dwarf_Die *di=
e, struct cu *cu,
 	case DW_TAG_const_type:
 	case DW_TAG_imported_declaration:
 	case DW_TAG_imported_module:
-	case DW_TAG_pointer_type:
 	case DW_TAG_reference_type:
 	case DW_TAG_restrict_type:
 	case DW_TAG_unspecified_type:
 	case DW_TAG_volatile_type:
 		tag =3D die__create_new_tag(die, cu);		break;
+	case DW_TAG_pointer_type:
+		tag =3D die__create_new_pointer_tag(die, cu, conf);	break;
 	case DW_TAG_ptr_to_member_type:
 		tag =3D die__create_new_ptr_to_member_type(die, cu); break;
 	case DW_TAG_enumeration_type:
@@ -2192,6 +2276,45 @@ static void lexblock__recode_dwarf_types(struct lexb=
lock *tag, struct cu *cu)
 	}
 }
=20
+static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type=
 *tag,
+					      uint32_t pointee_type)
+{
+	struct btf_type_tag_type *annot;
+	struct dwarf_tag *annot_dtag;
+	struct tag *prev_tag;
+
+	/* Given source like
+	 *   int tag1 tag2 tag3 *p;
+	 * the tag->tags contains tag3 -> tag2 -> tag1, the final type chain look=
s like:
+	 *   pointer -> tag3 -> tag2 -> tag1 -> pointee
+	 *
+	 * Basically it means
+	 *   - '*' applies to "int tag1 tag2 tag3"
+	 *   - tag3 applies to "int tag1 tag2"
+	 *   - tag2 applies to "int tag1"
+	 *   - tag1 applies to "int"
+	 *
+	 * This also makes final source code (format c) easier as we can do
+	 *   emit for "tag3 -> tag2 -> tag1 -> int"
+	 *   emit '*'
+	 *
+	 * For 'tag3 -> tag2 -> tag1 -> int":
+	 *   emit for "tag2 -> tag1 -> int"
+	 *   emit tag3
+	 *
+	 * Eventually we can get the source code like
+	 *   int tag1 tag2 tag3 *p;
+	 * and this matches the user/kernel code.
+	 */
+	prev_tag =3D &tag->tag;
+	list_for_each_entry(annot, &tag->tags, node) {
+		annot_dtag =3D annot->tag.priv;
+		prev_tag->type =3D annot_dtag->small_id;
+		prev_tag =3D &annot->tag;
+	}
+	prev_tag->type =3D pointee_type;
+}
+
 static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 {
 	struct dwarf_tag *dtag =3D tag->priv;
@@ -2301,7 +2424,10 @@ static int tag__recode_dwarf_type(struct tag *tag, s=
truct cu *cu)
 	}
=20
 	if (dtag->type.off =3D=3D 0) {
-		tag->type =3D 0; /* void */
+		if (tag->tag !=3D DW_TAG_pointer_type || !tag->has_btf_type_tag)
+			tag->type =3D 0; /* void */
+		else
+			dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), 0);
 		return 0;
 	}
=20
@@ -2313,7 +2439,11 @@ check_type:
 		return 0;
 	}
 out:
-	tag->type =3D dtype->small_id;
+	if (tag->tag !=3D DW_TAG_pointer_type || !tag->has_btf_type_tag)
+		tag->type =3D dtype->small_id;
+	else
+		dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), dtype->sma=
ll_id);
+
 	return 0;
 }
=20
diff --git a/dwarves.h b/dwarves.h
index 0d3e204..4425d3c 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -63,6 +63,7 @@ struct conf_load {
 	bool			ptr_table_stats;
 	bool			skip_encoding_btf_decl_tag;
 	bool			skip_missing;
+	bool			skip_encoding_btf_type_tag;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
@@ -413,6 +414,7 @@ struct tag {
 	uint16_t	 tag;
 	bool		 visited;
 	bool		 top_level;
+	bool		 has_btf_type_tag;
 	uint16_t	 recursivity_level;
 	void		 *priv;
 };
@@ -533,7 +535,8 @@ static inline int tag__is_tag_type(const struct tag *ta=
g)
 	       tag->tag =3D=3D DW_TAG_restrict_type ||
 	       tag->tag =3D=3D DW_TAG_subroutine_type ||
 	       tag->tag =3D=3D DW_TAG_unspecified_type ||
-	       tag->tag =3D=3D DW_TAG_volatile_type;
+	       tag->tag =3D=3D DW_TAG_volatile_type ||
+	       tag->tag =3D=3D DW_TAG_LLVM_annotation;
 }
=20
 static inline const char *tag__decl_file(const struct tag *tag,
@@ -606,6 +609,34 @@ struct llvm_annotation {
 	struct list_head	node;
 };
=20
+/** struct btf_type_tag_type - representing a btf_type_tag annotation
+ *
+ * @tag   - DW_TAG_LLVM_annotation tag
+ * @value - btf_type_tag value string
+ * @node  - list_head node
+ */
+struct btf_type_tag_type {
+	struct tag		tag;
+	const char		*value;
+	struct list_head	node;
+};
+
+/** The struct btf_type_tag_ptr_type - type containing both pointer type a=
nd
+ *  its btf_type_tag annotations
+ *
+ * @tag  - pointer type tag
+ * @tags - btf_type_tag annotations for the pointer type
+ */
+struct btf_type_tag_ptr_type {
+	struct tag		tag;
+	struct list_head 	tags;
+};
+
+static inline struct btf_type_tag_ptr_type *tag__btf_type_tag_ptr(struct t=
ag *tag)
+{
+	return (struct btf_type_tag_ptr_type *)tag;
+}
+
 /** struct namespace - base class for enums, structs, unions, typedefs, etc
  *
  * @tags - class_member, enumerators, etc
diff --git a/pahole.c b/pahole.c
index 5fc1cca..f3a51cb 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1126,6 +1126,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_versi=
on;
 #define ARGP_devel_stats	   330
 #define ARGP_skip_encoding_btf_decl_tag 331
 #define ARGP_skip_missing          332
+#define ARGP_skip_encoding_btf_type_tag 333
=20
 static const struct argp_option pahole__options[] =3D {
 	{
@@ -1506,6 +1507,11 @@ static const struct argp_option pahole__options[] =
=3D {
 		.key  =3D ARGP_skip_missing,
 		.doc =3D "skip missing types passed to -C rather than stop",
 	},
+	{
+		.name =3D "skip_encoding_btf_type_tag",
+		.key  =3D ARGP_skip_encoding_btf_type_tag,
+		.doc  =3D "Do not encode TAGs in BTF."
+	},
 	{
 		.name =3D NULL,
 	}
@@ -1658,6 +1664,8 @@ static error_t pahole__options_parser(int key, char *=
arg,
 		conf_load.skip_encoding_btf_decl_tag =3D true;	break;
 	case ARGP_skip_missing:
 		conf_load.skip_missing =3D true;          break;
+	case ARGP_skip_encoding_btf_type_tag:
+		conf_load.skip_encoding_btf_type_tag =3D true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
--=20
2.30.2


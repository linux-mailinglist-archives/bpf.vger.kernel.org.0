Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2254D4F1
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 01:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347282AbiFOXDc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 19:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiFOXDX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 19:03:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC022510
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 16:03:22 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25FLpnBl003716
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 16:03:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=acysx/nqpOjLF+DPp/1rFItU+e/H0dFxPRoP0i+Hsfs=;
 b=Uynlphg+KuwUjb/QinVvLS5L9ukeeO7bY73ItC1dq+2lTHzQReubeEf6XDVACTMoz3id
 MuzjPoRHl7ZS0Bk2q8eGCJ61I7612rTP9Q8v4xlw6Y7DM7rrrrMF0vc6aKU+2G18/kQH
 r/P+LsqTFXuFQtO2n1jnEM21iY0VmoPMRKQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gpr0ee12k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 16:03:21 -0700
Received: from twshared22934.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 15 Jun 2022 16:03:20 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 8F3FCBA4C530; Wed, 15 Jun 2022 16:03:17 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 2/2] btf: Support BTF_KIND_ENUM64
Date:   Wed, 15 Jun 2022 16:03:17 -0700
Message-ID: <20220615230317.852304-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615230306.851750-1-yhs@fb.com>
References: <20220615230306.851750-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _8w04du0iWHvqqatFDLK5_P_GqJv2viE
X-Proofpoint-GUID: _8w04du0iWHvqqatFDLK5_P_GqJv2viE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_16,2022-06-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF_KIND_ENUM64 is supported with latest libbpf, which
supports 64-bit enum values. Latest libbpf also supports
signedness for enum values. Add enum64 support in
dwarf-to-btf conversion.

The following is an example of new encoding which covers
signed/unsigned enum64/enum variations.

  $cat t.c
  enum { /* signed, enum64 */
    A =3D -1,
    B =3D 0xffffffff,
  } g1;
  enum { /* unsigned, enum64 */
    C =3D 1,
    D =3D 0xfffffffff,
  } g2;
  enum { /* signed, enum */
    E =3D -1,
    F =3D 0xfffffff,
  } g3;
  enum { /* unsigned, enum */
    G =3D 1,
    H =3D 0xfffffff,
  } g4;
  $ clang -g -c t.c
  $ pahole -JV t.o
  btf_encoder__new: 't.o' doesn't have '.data..percpu' section
  Found 0 per-CPU variables!
  File t.o:
  [1] ENUM64 (anon) size=3D8
          A val=3D-1
          B val=3D4294967295
  [2] INT long size=3D8 nr_bits=3D64 encoding=3DSIGNED
  [3] ENUM64 (anon) size=3D8
          C val=3D1
          D val=3D68719476735
  [4] INT unsigned long size=3D8 nr_bits=3D64 encoding=3D(none)
  [5] ENUM (anon) size=3D4
          E val=3D-1
          F val=3D268435455
  [6] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  [7] ENUM (anon) size=3D4
          G val=3D1
          H val=3D268435455
  [8] INT unsigned int size=3D4 nr_bits=3D32 encoding=3D(none)

With the flag to skip enum64 encoding,

  $ pahole -JV t.o --skip_encoding_btf_enum64
  btf_encoder__new: 't.o' doesn't have '.data..percpu' section
  Found 0 per-CPU variables!
  File t.o:
  [1] ENUM (anon) size=3D8
        A val=3D4294967295
        B val=3D4294967295
  [2] INT long size=3D8 nr_bits=3D64 encoding=3DSIGNED
  [3] ENUM (anon) size=3D8
        C val=3D1
        D val=3D4294967295
  [4] INT unsigned long size=3D8 nr_bits=3D64 encoding=3D(none)
  [5] ENUM (anon) size=3D4
        E val=3D4294967295
        F val=3D268435455
  [6] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  [7] ENUM (anon) size=3D4
        G val=3D1
        H val=3D268435455
  [8] INT unsigned int size=3D4 nr_bits=3D32 encoding=3D(none)

In the above btf encoding without enum64, all enum types
with the same type size as the corresponding enum64. All these
enum types have unsigned type (kflag =3D 0) which is required
before kernel enum64 support.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c     | 65 +++++++++++++++++++++++++++++++++++------------
 btf_encoder.h     |  2 +-
 dwarf_loader.c    | 12 +++++++++
 dwarves.h         |  4 ++-
 dwarves_fprintf.c |  6 ++++-
 pahole.c          | 10 +++++++-
 6 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9e708e4..96de54c 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -144,6 +144,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_FLOAT]        =3D "FLOAT",
 	[BTF_KIND_DECL_TAG]     =3D "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]     =3D "TYPE_TAG",
+	[BTF_KIND_ENUM64]	=3D "ENUM64",
 };
=20
 static const char *btf__printable_name(const struct btf *btf, uint32_t o=
ffset)
@@ -490,34 +491,64 @@ static int32_t btf_encoder__add_struct(struct btf_e=
ncoder *encoder, uint8_t kind
 	return id;
 }
=20
-static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const =
char *name, uint32_t bit_size)
+static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const =
char *name, uint32_t bit_size,
+				     bool is_signed, bool no_enum64)
 {
 	struct btf *btf =3D encoder->btf;
 	const struct btf_type *t;
 	int32_t id, size;
+	bool is_enum32;
=20
 	size =3D BITS_ROUNDUP_BYTES(bit_size);
-	id =3D btf__add_enum(btf, name, size);
+	is_enum32 =3D size <=3D 4 || no_enum64;
+	if (is_enum32)
+		id =3D btf__add_enum(btf, name, size);
+	else
+		id =3D btf__add_enum64(btf, name, size, is_signed);
 	if (id > 0) {
 		t =3D btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "size=3D%u", t->size);
 	} else {
-		btf__log_err(btf, BTF_KIND_ENUM, name, true,
+		btf__log_err(btf, is_enum32 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name, t=
rue,
 			      "size=3D%u Error emitting BTF type", size);
 	}
 	return id;
 }
=20
-static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const =
char *name, int32_t value)
+static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const =
char *name, int64_t value,
+				     bool is_signed, bool is_enum64, bool no_enum64)
 {
-	int err =3D btf__add_enum_value(encoder->btf, name, value);
+	const char *fmt_str;
+	int err;
+
+	/* If enum64 is not allowed, generate enum32 with unsigned int value. I=
n enum64-supported
+	 * libbpf library, btf__add_enum_value() will set the kflag (sign bit) =
in common_type
+	 * if the value is negative.
+	 */
+	if (no_enum64)
+		err =3D btf__add_enum_value(encoder->btf, name, (uint32_t)value);
+	else if (is_enum64)
+		err =3D btf__add_enum64_value(encoder->btf, name, value);
+	else
+		err =3D btf__add_enum_value(encoder->btf, name, value);
=20
 	if (!err) {
-		if (encoder->verbose)
-			printf("\t%s val=3D%d\n", name, value);
+		if (encoder->verbose) {
+			if (no_enum64) {
+				printf("\t%s val=3D%u\n", name, (uint32_t)value);
+			} else {
+				fmt_str =3D is_signed ? "\t%s val=3D%lld\n" : "\t%s val=3D%llu\n";
+				printf(fmt_str, name, (unsigned long long)value);
+			}
+		}
 	} else {
-		fprintf(stderr, "\t%s val=3D%d Error emitting BTF enum value\n",
-			name, value);
+		if (no_enum64) {
+			fprintf(stderr, "\t%s val=3D%u Error emitting BTF enum value\n", name=
, (uint32_t)value);
+		} else {
+			fmt_str =3D is_signed ? "\t%s val=3D%lld Error emitting BTF enum valu=
e\n"
+					    : "\t%s val=3D%llu Error emitting BTF enum value\n";
+			fprintf(stderr, fmt_str, name, (unsigned long long)value);
+		}
 	}
 	return err;
 }
@@ -844,27 +875,29 @@ static uint32_t array_type__nelems(struct tag *tag)
 	return nelem;
 }
=20
-static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, s=
truct tag *tag)
+static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, s=
truct tag *tag, bool no_enum64)
 {
 	struct type *etype =3D tag__type(tag);
 	struct enumerator *pos;
 	const char *name =3D type__name(etype);
 	int32_t type_id;
=20
-	type_id =3D btf_encoder__add_enum(encoder, name, etype->size);
+	type_id =3D btf_encoder__add_enum(encoder, name, etype->size, etype->is=
_signed_enum, no_enum64);
 	if (type_id < 0)
 		return type_id;
=20
 	type__for_each_enumerator(etype, pos) {
 		name =3D enumerator__name(pos);
-		if (btf_encoder__add_enum_val(encoder, name, pos->value))
+		if (btf_encoder__add_enum_val(encoder, name, pos->value, etype->is_sig=
ned_enum,
+					      etype->size > 32, no_enum64))
 			return -1;
 	}
=20
 	return type_id;
 }
=20
-static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct t=
ag *tag, uint32_t type_id_off)
+static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct t=
ag *tag, uint32_t type_id_off,
+				   struct conf_load *conf_load)
 {
 	/* single out type 0 as it represents special type "void" */
 	uint32_t ref_type_id =3D tag->type =3D=3D 0 ? 0 : type_id_off + tag->ty=
pe;
@@ -903,7 +936,7 @@ static int btf_encoder__encode_tag(struct btf_encoder=
 *encoder, struct tag *tag,
 		encoder->need_index_type =3D true;
 		return btf_encoder__add_array(encoder, ref_type_id, encoder->array_ind=
ex_id, array_type__nelems(tag));
 	case DW_TAG_enumeration_type:
-		return btf_encoder__add_enum_type(encoder, tag);
+		return btf_encoder__add_enum_type(encoder, tag, conf_load->skip_encodi=
ng_btf_enum64);
 	case DW_TAG_subroutine_type:
 		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_o=
ff);
 	default:
@@ -1422,7 +1455,7 @@ void btf_encoder__delete(struct btf_encoder *encode=
r)
 	free(encoder);
 }
=20
-int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
+int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, s=
truct conf_load *conf_load)
 {
 	uint32_t type_id_off =3D btf__type_cnt(encoder->btf) - 1;
 	struct llvm_annotation *annot;
@@ -1446,7 +1479,7 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu)
 	}
=20
 	cu__for_each_type(cu, core_id, pos) {
-		btf_type_id =3D btf_encoder__encode_tag(encoder, pos, type_id_off);
+		btf_type_id =3D btf_encoder__encode_tag(encoder, pos, type_id_off, con=
f_load);
=20
 		if (btf_type_id < 0 ||
 		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
diff --git a/btf_encoder.h b/btf_encoder.h
index 339fae2..a65120c 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -21,7 +21,7 @@ void btf_encoder__delete(struct btf_encoder *encoder);
=20
 int btf_encoder__encode(struct btf_encoder *encoder);
=20
-int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu);
+int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, s=
truct conf_load *conf_load);
=20
 void btf_encoders__add(struct list_head *encoders, struct btf_encoder *e=
ncoder);
=20
diff --git a/dwarf_loader.c b/dwarf_loader.c
index a0d964b..4767602 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -632,6 +632,18 @@ static void type__init(struct type *type, Dwarf_Die =
*die, struct cu *cu, struct
 	type->resized		 =3D 0;
 	type->nr_members	 =3D 0;
 	type->nr_static_members	 =3D 0;
+	type->is_signed_enum	 =3D 0;
+
+	Dwarf_Attribute attr;
+	if (dwarf_attr(die, DW_AT_type, &attr) !=3D NULL) {
+		Dwarf_Die type_die;
+		if (dwarf_formref_die(&attr, &type_die) !=3D NULL) {
+			uint64_t encoding =3D attr_numeric(&type_die, DW_AT_encoding);
+
+			if (encoding =3D=3D DW_ATE_signed || encoding =3D=3D DW_ATE_signed_ch=
ar)
+				type->is_signed_enum =3D 1;
+		}
+	}
 }
=20
 static struct type *type__new(Dwarf_Die *die, struct cu *cu, struct conf=
_load *conf)
diff --git a/dwarves.h b/dwarves.h
index 4d0e4b6..bec9f08 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -65,6 +65,7 @@ struct conf_load {
 	bool			skip_encoding_btf_decl_tag;
 	bool			skip_missing;
 	bool			skip_encoding_btf_type_tag;
+	bool			skip_encoding_btf_enum64;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
@@ -1046,6 +1047,7 @@ struct type {
 	uint8_t		 definition_emitted:1;
 	uint8_t		 fwd_decl_emitted:1;
 	uint8_t		 resized:1;
+	uint8_t		 is_signed_enum:1;
 };
=20
 void __type__init(struct type *type);
@@ -1365,7 +1367,7 @@ static inline struct string_type *tag__string_type(=
const struct tag *tag)
 struct enumerator {
 	struct tag	 tag;
 	const char	 *name;
-	uint32_t	 value;
+	uint64_t	 value;
 	struct tag_cu	 type_enum; // To cache the type_enum searches
 };
=20
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 2cec584..ce64c79 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -437,7 +437,11 @@ size_t enumeration__fprintf(const struct tag *tag, c=
onst struct conf_fprintf *co
 	type__for_each_enumerator(type, pos) {
 		printed +=3D fprintf(fp, "%.*s\t%-*s =3D ", indent, tabs,
 				   max_entry_name_len, enumerator__name(pos));
-		printed +=3D fprintf(fp, conf->hex_fmt ?  "%#x" : "%u", pos->value);
+		if (conf->hex_fmt)
+			printed +=3D fprintf(fp, "%#llx", (unsigned long long)pos->value);
+		else
+			printed +=3D fprintf(fp, type->is_signed_enum ?  "%lld" : "%llu",
+					   (unsigned long long)pos->value);
 		printed +=3D fprintf(fp, ",\n");
 	}
=20
diff --git a/pahole.c b/pahole.c
index 78caa08..e87d9a4 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1220,6 +1220,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =3D dwarves_print_ver=
sion;
 #define ARGP_compile		   334
 #define ARGP_languages		   335
 #define ARGP_languages_exclude	   336
+#define ARGP_skip_encoding_btf_enum64 337
=20
 static const struct argp_option pahole__options[] =3D {
 	{
@@ -1622,6 +1623,11 @@ static const struct argp_option pahole__options[] =
=3D {
 		.arg  =3D "LANGUAGES",
 		.doc  =3D "Don't consider compilation units written in these languages=
"
 	},
+	{
+		.name =3D "skip_encoding_btf_enum64",
+		.key  =3D ARGP_skip_encoding_btf_enum64,
+		.doc  =3D "Do not encode ENUM64sin BTF."
+	},
 	{
 		.name =3D NULL,
 	}
@@ -1787,6 +1793,8 @@ static error_t pahole__options_parser(int key, char=
 *arg,
 		/* fallthru */
 	case ARGP_languages:
 		languages.str =3D arg;			break;
+	case ARGP_skip_encoding_btf_enum64:
+		conf_load.skip_encoding_btf_enum64 =3D true;	break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -3067,7 +3075,7 @@ static enum load_steal_kind pahole_stealer(struct c=
u *cu,
 			encoder =3D btf_encoder;
 		}
=20
-		if (btf_encoder__encode_cu(encoder, cu)) {
+		if (btf_encoder__encode_cu(encoder, cu, conf_load)) {
 			fprintf(stderr, "Encountered error while encoding BTF.\n");
 			exit(1);
 		}
--=20
2.30.2


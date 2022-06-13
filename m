Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8388549B86
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245637AbiFMSaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbiFMS3y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 14:29:54 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA06B4D9C3
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 07:44:55 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25CNk7KC005066
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 07:44:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZWEb9W444UQHB0OAOfzDsFFZgYxXWVzU5dPxOH+dhU4=;
 b=hSoICeE9asiiEPvGlhN4lvHo41sbknB01Ip3DRMbHSPkYZbWEYMHtmKUIon0ePvQh9Es
 Jnjfn1s+uQ97P24mjr+hInH816qXqqxiVaGs9aACmwu3LwxF7n4FWojI4XkaOY6tagFN
 2mOtPU9FFjHFjECAHQ2UzVBhTglq1eY8iCQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmrsxrq8g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 07:44:55 -0700
Received: from twshared17349.03.ash7.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 13 Jun 2022 07:44:52 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B8CFBB8DCBFA; Mon, 13 Jun 2022 07:44:50 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves 2/2] btf: Support BTF_KIND_ENUM64
Date:   Mon, 13 Jun 2022 07:44:50 -0700
Message-ID: <20220613144450.4107806-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144440.4107327-1-yhs@fb.com>
References: <20220613144440.4107327-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: A3A2zBwpIQf-4xGDMYwtsNvM2onFe6xB
X-Proofpoint-ORIG-GUID: A3A2zBwpIQf-4xGDMYwtsNvM2onFe6xB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_06,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c     | 38 +++++++++++++++++++++++++++-----------
 dwarf_loader.c    | 12 ++++++++++++
 dwarves.h         |  3 ++-
 dwarves_fprintf.c |  6 +++++-
 4 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9e708e4..4b33b95 100644
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
@@ -490,34 +491,48 @@ static int32_t btf_encoder__add_struct(struct btf_e=
ncoder *encoder, uint8_t kind
 	return id;
 }
=20
-static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const =
char *name, uint32_t bit_size)
+static int32_t btf_encoder__add_enum(struct btf_encoder *encoder, const =
char *name, uint32_t bit_size,
+				     bool is_signed)
 {
 	struct btf *btf =3D encoder->btf;
 	const struct btf_type *t;
 	int32_t id, size;
=20
 	size =3D BITS_ROUNDUP_BYTES(bit_size);
-	id =3D btf__add_enum(btf, name, size);
+	if (size > 4)
+		id =3D btf__add_enum64(btf, name, size, is_signed);
+	else
+		id =3D btf__add_enum(btf, name, size);
 	if (id > 0) {
 		t =3D btf__type_by_id(btf, id);
 		btf_encoder__log_type(encoder, t, false, true, "size=3D%u", t->size);
 	} else {
-		btf__log_err(btf, BTF_KIND_ENUM, name, true,
+		btf__log_err(btf, size <=3D 4 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name,=
 true,
 			      "size=3D%u Error emitting BTF type", size);
 	}
 	return id;
 }
=20
-static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const =
char *name, int32_t value)
+static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const =
char *name, int64_t value,
+				     bool is_signed, bool is_enum64)
 {
-	int err =3D btf__add_enum_value(encoder->btf, name, value);
+	const char *fmt_str;
+	int err;
+
+	if (is_enum64)
+		err =3D btf__add_enum64_value(encoder->btf, name, value);
+	else
+		err =3D btf__add_enum_value(encoder->btf, name, value);
=20
 	if (!err) {
-		if (encoder->verbose)
-			printf("\t%s val=3D%d\n", name, value);
+		if (encoder->verbose) {
+			fmt_str =3D is_signed ? "\t%s val=3D%lld\n" : "\t%s val=3D%llu\n";
+			printf(fmt_str, name, (unsigned long long)value);
+		}
 	} else {
-		fprintf(stderr, "\t%s val=3D%d Error emitting BTF enum value\n",
-			name, value);
+		fmt_str =3D is_signed ? "\t%s val=3D%lld Error emitting BTF enum value=
\n"
+				    : "\t%s val=3D%llu Error emitting BTF enum value\n";
+		fprintf(stderr, fmt_str, name, (unsigned long long)value);
 	}
 	return err;
 }
@@ -851,13 +866,14 @@ static int32_t btf_encoder__add_enum_type(struct bt=
f_encoder *encoder, struct ta
 	const char *name =3D type__name(etype);
 	int32_t type_id;
=20
-	type_id =3D btf_encoder__add_enum(encoder, name, etype->size);
+	type_id =3D btf_encoder__add_enum(encoder, name, etype->size, etype->is=
_signed_enum);
 	if (type_id < 0)
 		return type_id;
=20
 	type__for_each_enumerator(etype, pos) {
 		name =3D enumerator__name(pos);
-		if (btf_encoder__add_enum_val(encoder, name, pos->value))
+		if (btf_encoder__add_enum_val(encoder, name, pos->value, etype->is_sig=
ned_enum,
+					      etype->size > 32))
 			return -1;
 	}
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
index 4d0e4b6..32c9508 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1046,6 +1046,7 @@ struct type {
 	uint8_t		 definition_emitted:1;
 	uint8_t		 fwd_decl_emitted:1;
 	uint8_t		 resized:1;
+	uint8_t		 is_signed_enum:1;
 };
=20
 void __type__init(struct type *type);
@@ -1365,7 +1366,7 @@ static inline struct string_type *tag__string_type(=
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
--=20
2.30.2


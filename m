Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAE27DF7A
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgI3E2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38752 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgI3E2N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:13 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4S9CF011189
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SIVW82mMAURBIIG5qba82CuM/+1N1gWvTKffUJQorps=;
 b=OnQMWHrZzFHKQrYOYT+HmZN8zoL9hWnnw765U/ippqg/d70LqVYRVBFykZ1nZG0XN6hx
 MZyuOdLHyDw86Y9GndmNYzl4ZA4h1T1eNhLdsN/WXohWo7xsluOIuSVKzf8gB3A49yVa
 t3lUuxZJV01+XDH6nATLDw4rk3oNc+Doi/U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33v1ndd3vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:13 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:12 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 025802EC77F1; Tue, 29 Sep 2020 21:28:04 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 06/11] btf_encoder: fix emitting __ARRAY_SIZE_TYPE__ as index range type
Date:   Tue, 29 Sep 2020 21:27:37 -0700
Message-ID: <20200930042742.2525310-7-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=15 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the logic of determining if __ARRAY_SIZE_TYPE__ needs to be emitted.
Previously, such type could be emitted unnecessarily due to some particul=
ar CU
not having an int type in it. That would happen even if there was no arra=
y
type in that CU. Fix it by keeping track of 'int' type across CUs and onl=
y
emitting __ARRAY_SIZE_TYPE__ if a given CU has array type, but we still
haven't found 'int' type.

Testing against vmlinux shows that now there are no __ARRAY_SIZE_TYPE__
integers emitted.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 btf_encoder.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0a9db2938422..91b68694bca5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -147,6 +147,8 @@ static int32_t enumeration_type__encode(struct btf_el=
f *btfe, struct cu *cu, str
 	return type_id;
 }
=20
+static bool need_index_type;
+
 static int tag__encode_btf(struct cu *cu, struct tag *tag, uint32_t core=
_id, struct btf_elf *btfe,
 			   uint32_t array_index_id, uint32_t type_id_off)
 {
@@ -179,6 +181,7 @@ static int tag__encode_btf(struct cu *cu, struct tag =
*tag, uint32_t core_id, str
 			return structure_type__encode(btfe, cu, tag, type_id_off);
 	case DW_TAG_array_type:
 		/* TODO: Encode one dimension at a time. */
+		need_index_type =3D true;
 		return btf_elf__add_array(btfe, ref_type_id, array_index_id, array_typ=
e__nelems(tag));
 	case DW_TAG_enumeration_type:
 		return enumeration_type__encode(btfe, cu, tag);
@@ -193,6 +196,7 @@ static int tag__encode_btf(struct cu *cu, struct tag =
*tag, uint32_t core_id, str
=20
 static struct btf_elf *btfe;
 static uint32_t array_index_id;
+static bool has_index_type;
=20
 int btf_encoder__encode()
 {
@@ -228,7 +232,6 @@ static struct variable *hashaddr__find_variable(const=
 struct hlist_head hashtabl
 int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		   bool skip_encoding_vars)
 {
-	bool add_index_type =3D false;
 	uint32_t type_id_off;
 	uint32_t core_id;
 	struct function *fn;
@@ -254,18 +257,26 @@ int cu__encode_btf(struct cu *cu, int verbose, bool=
 force,
 		if (!btfe)
 			return -1;
=20
-		/* cu__find_base_type_by_name() takes "type_id_t *id" */
-		type_id_t id;
-		if (!cu__find_base_type_by_name(cu, "int", &id)) {
-			add_index_type =3D true;
-			id =3D cu->types_table.nr_entries;
-		}
-		array_index_id =3D id;
+		has_index_type =3D false;
+		need_index_type =3D false;
+		array_index_id =3D 0;
=20
 		if (verbose)
 			printf("File %s:\n", btfe->filename);
 	}
=20
+	if (!has_index_type) {
+		/* cu__find_base_type_by_name() takes "type_id_t *id" */
+		type_id_t id;
+		if (cu__find_base_type_by_name(cu, "int", &id)) {
+			has_index_type =3D true;
+			array_index_id =3D id;
+		} else {
+			has_index_type =3D false;
+			array_index_id =3D cu->types_table.nr_entries;
+		}
+	}
+
 	btf_elf__verbose =3D verbose;
 	type_id_off =3D btf__get_nr_types(btfe->btf);
=20
@@ -279,12 +290,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool=
 force,
 		}
 	}
=20
-	if (add_index_type) {
+	if (need_index_type && !has_index_type) {
 		struct base_type bt =3D {};
=20
 		bt.name =3D 0;
 		bt.bit_size =3D 32;
 		btf_elf__add_base_type(btfe, &bt, "__ARRAY_SIZE_TYPE__");
+		has_index_type =3D true;
 	}
=20
 	cu__for_each_function(cu, core_id, fn) {
--=20
2.24.1


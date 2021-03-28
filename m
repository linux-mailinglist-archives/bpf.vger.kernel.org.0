Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D2234BB3F
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 08:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC1GRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 02:17:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50070 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhC1GRA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Mar 2021 02:17:00 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12S6AOjM024844
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 23:17:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=njsMw4rGb7jllOX7DaELjG0m88UBvki5SzaY1CEzzms=;
 b=XE+TIE4FWo3B3vYG4UA2poqhcPB3R6n0SNyCMQ/WXycVqEqqqOw0j9HtGFd3TJ8rxClA
 iRgE7H2DyLn9gc6q7+K6GiXwhgCDdFca4dEYsI6V0aOMqTaxTdx7ihuvfMAD5mIbGaq8
 dSC2Ik3AlPDPJxO7CxtET6Fgd2NE287D5cY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37j27saxxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 23:17:00 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 27 Mar 2021 23:16:59 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 94BDAC8F3C4; Sat, 27 Mar 2021 23:16:51 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH dwarves v2 1/3] dwarf_loader: permits flexible HASHTAGS__BITS
Date:   Sat, 27 Mar 2021 23:16:51 -0700
Message-ID: <20210328061651.1956098-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328061646.1955678-1-yhs@fb.com>
References: <20210328061646.1955678-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rk5LUw3sg_lLFO62LnsVvhIWWFEdywHk
X-Proofpoint-GUID: Rk5LUw3sg_lLFO62LnsVvhIWWFEdywHk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_04:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=963
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, types/tags hash table has fixed HASHTAGS__BITS =3D 15.
That means the number of buckets will be 1UL << 15 =3D 32768.
In my experiments, a thin-LTO built vmlinux has roughly 9M entries
in types table and 5.2M entries in tags table. So the number
of buckets is too less for an efficient lookup. This patch
refactored the code to allow the number of buckets to be changed.

In addition, currently hashtags__fn(key) return value is
assigned to uint16_t. Change to uint32_t as in a later patch
the number of hashtag bits can be increased to be more than 16.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index c106919..5a1e860 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -50,7 +50,12 @@ struct strings *strings;
 #define DW_FORM_implicit_const 0x21
 #endif
=20
-#define hashtags__fn(key) hash_64(key, HASHTAGS__BITS)
+static uint32_t hashtags__bits =3D 15;
+
+static uint32_t hashtags__fn(Dwarf_Off key)
+{
+	return hash_64(key, hashtags__bits);
+}
=20
 bool no_bitfield_type_recode =3D true;
=20
@@ -102,9 +107,6 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dta=
g, dwarf_off_ref spec)
 	*(dwarf_off_ref *)(dtag + 1) =3D spec;
 }
=20
-#define HASHTAGS__BITS 15
-#define HASHTAGS__SIZE (1UL << HASHTAGS__BITS)
-
 #define obstack_chunk_alloc malloc
 #define obstack_chunk_free free
=20
@@ -118,22 +120,41 @@ static void *obstack_zalloc(struct obstack *obstack=
, size_t size)
 }
=20
 struct dwarf_cu {
-	struct hlist_head hash_tags[HASHTAGS__SIZE];
-	struct hlist_head hash_types[HASHTAGS__SIZE];
+	struct hlist_head *hash_tags;
+	struct hlist_head *hash_types;
 	struct obstack obstack;
 	struct cu *cu;
 	struct dwarf_cu *type_unit;
 };
=20
-static void dwarf_cu__init(struct dwarf_cu *dcu)
+static int dwarf_cu__init(struct dwarf_cu *dcu)
 {
+	uint64_t hashtags_size =3D 1UL << hashtags__bits;
+	dcu->hash_tags =3D malloc(sizeof(struct hlist_head) * hashtags_size);
+	if (!dcu->hash_tags)
+		return -ENOMEM;
+
+	dcu->hash_types =3D malloc(sizeof(struct hlist_head) * hashtags_size);
+	if (!dcu->hash_types) {
+		free(dcu->hash_tags);
+		return -ENOMEM;
+	}
+
 	unsigned int i;
-	for (i =3D 0; i < HASHTAGS__SIZE; ++i) {
+	for (i =3D 0; i < hashtags_size; ++i) {
 		INIT_HLIST_HEAD(&dcu->hash_tags[i]);
 		INIT_HLIST_HEAD(&dcu->hash_types[i]);
 	}
 	obstack_init(&dcu->obstack);
 	dcu->type_unit =3D NULL;
+	return 0;
+}
+
+static void dwarf_cu__delete(struct cu *cu)
+{
+	struct dwarf_cu *dcu =3D cu->priv;
+	free(dcu->hash_tags);
+	free(dcu->hash_types);
 }
=20
 static void hashtags__hash(struct hlist_head *hashtable,
@@ -151,7 +172,7 @@ static struct dwarf_tag *hashtags__find(const struct =
hlist_head *hashtable,
=20
 	struct dwarf_tag *tpos;
 	struct hlist_node *pos;
-	uint16_t bucket =3D hashtags__fn(id);
+	uint32_t bucket =3D hashtags__fn(id);
 	const struct hlist_head *head =3D hashtable + bucket;
=20
 	hlist_for_each_entry(tpos, pos, head, hash_node) {
@@ -2429,7 +2450,9 @@ static int cus__load_debug_types(struct cus *cus, s=
truct conf_load *conf,
 			}
 			cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
=20
-			dwarf_cu__init(dcup);
+			if (dwarf_cu__init(dcup) !=3D 0)
+				return DWARF_CB_ABORT;
+
 			dcup->cu =3D cu;
 			/* Funny hack.  */
 			dcup->type_unit =3D dcup;
@@ -2521,7 +2544,9 @@ static int cus__load_module(struct cus *cus, struct=
 conf_load *conf,
=20
 		struct dwarf_cu dcu;
=20
-		dwarf_cu__init(&dcu);
+		if (dwarf_cu__init(&dcu) !=3D 0)
+			return DWARF_CB_ABORT;
+
 		dcu.cu =3D cu;
 		dcu.type_unit =3D type_cu ? &type_dcu : NULL;
 		cu->priv =3D &dcu;
@@ -2672,5 +2697,6 @@ struct debug_fmt_ops dwarf__ops =3D {
 	.tag__decl_file	     =3D dwarf_tag__decl_file,
 	.tag__decl_line	     =3D dwarf_tag__decl_line,
 	.tag__orig_id	     =3D dwarf_tag__orig_id,
+	.cu__delete	     =3D dwarf_cu__delete,
 	.has_alignment_info  =3D true,
 };
--=20
2.30.2


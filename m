Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFD459B55
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 05:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhKWE7r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 23:59:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39858 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232662AbhKWE7q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Nov 2021 23:59:46 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN0KId9026280
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 20:56:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=odDHSc5u7mPeJUGZBEqXhlLUCYerDkSzOy5Wc0oaYJA=;
 b=CT9kPDH7P8h6ZsRUrZy/zVZZC/p2K4ZoCv4kl1WZmVFHAZvyGzjbWF42FOKonIeNxZzO
 Pze/U0fuZA9RnIhFVmzivFdQtt5oAP8mzCPfTWZLD97+xzkFRoWlseuFQKUxVmzoVO1q
 ZLX1Et1G0VbumfGjRwwVbBPWj07Y4MRKSZA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cgnnth8yh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 20:56:38 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 22 Nov 2021 20:56:38 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5A5FD2CD4A37; Mon, 22 Nov 2021 20:56:33 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves v2 4/4] btf_encoder: support btf_type_tag attribute
Date:   Mon, 22 Nov 2021 20:56:33 -0800
Message-ID: <20211123045633.1389158-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123045612.1387544-1-yhs@fb.com>
References: <20211123045612.1387544-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: EHdqsVkg0LkZ-YtIwoJUZlV3aEPkiSA0
X-Proofpoint-GUID: EHdqsVkg0LkZ-YtIwoJUZlV3aEPkiSA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_01,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following is an example.
  [$ ~] cat t.c
  #define __tag1 __attribute__((btf_type_tag("tag1")))
  #define __tag2 __attribute__((btf_type_tag("tag2")))
  int __tag1 * __tag1 __tag2 *g __attribute__((section(".data..percpu")))=
;
  [$ ~] clang -O2 -g -c t.c
  [$ ~] pahole -JV t.o
  Found per-CPU symbol 'g' at address 0x0
  Found 1 per-CPU variables!
  File t.o:
  [1] TYPE_TAG tag1 type_id=3D5
  [2] TYPE_TAG tag2 type_id=3D1
  [3] PTR (anon) type_id=3D2
  [4] TYPE_TAG tag1 type_id=3D6
  [5] PTR (anon) type_id=3D4
  [6] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  search cu 't.c' for percpu global variables.
  Variable 'g' from CU 't.c' at address 0x0 encoded
  [7] VAR g type=3D3 linkage=3D1
  [8] DATASEC .data..percpu size=3D8 vlen=3D1
          type=3D7 offset=3D0 size=3D8
  [$ ~]

You can see for the source
  int __tag1 * __tag1 __tag2 *g __attribute__((section(".data..percpu")))=
;
the following type chain is generated:
  var -> ptr -> tag2 -> tag1 -> ptr -> tag1 -> int

The following shows pahole option "--skip_encoding_btf_type_tag"
can prevent BTF_KIND_TYPE_TAG generation.
  [$ ~] pahole -JV t.o --skip_encoding_btf_type_tag
  Found per-CPU symbol 'g' at address 0x0
  Found 1 per-CPU variables!
  File t.o:
  [1] PTR (anon) type_id=3D2
  [2] PTR (anon) type_id=3D3
  [3] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  search cu 't.c' for percpu global variables.
  Variable 'g' from CU 't.c' at address 0x0 encoded
  [4] VAR g type=3D1 linkage=3D1
  [5] DATASEC .data..percpu size=3D8 vlen=3D1
          type=3D4 offset=3D0 size=3D8
  [$ ~]

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 btf_encoder.c | 7 +++++++
 dwarves.h     | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 117656e..9d015f3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -143,6 +143,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
 	[BTF_KIND_DATASEC]      =3D "DATASEC",
 	[BTF_KIND_FLOAT]        =3D "FLOAT",
 	[BTF_KIND_DECL_TAG]     =3D "DECL_TAG",
+	[BTF_KIND_TYPE_TAG]     =3D "TYPE_TAG",
 };
=20
 static const char *btf__printable_name(const struct btf *btf, uint32_t o=
ffset)
@@ -393,6 +394,9 @@ static int32_t btf_encoder__add_ref_type(struct btf_e=
ncoder *encoder, uint16_t k
 	case BTF_KIND_TYPEDEF:
 		id =3D btf__add_typedef(btf, name, type);
 		break;
+	case BTF_KIND_TYPE_TAG:
+		id =3D btf__add_type_tag(btf, name, type);
+		break;
 	case BTF_KIND_FWD:
 		id =3D btf__add_fwd(btf, name, kind_flag);
 		break;
@@ -862,6 +866,9 @@ static int btf_encoder__encode_tag(struct btf_encoder=
 *encoder, struct tag *tag,
 	case DW_TAG_typedef:
 		name =3D namespace__name(tag__namespace(tag));
 		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_i=
d, name, false);
+	case DW_TAG_LLVM_annotation:
+		name =3D tag__btf_type_tag(tag)->value;
+		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_=
id, name, false);
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
 	case DW_TAG_class_type:
diff --git a/dwarves.h b/dwarves.h
index 4425d3c..52d162d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -637,6 +637,11 @@ static inline struct btf_type_tag_ptr_type *tag__btf=
_type_tag_ptr(struct tag *ta
 	return (struct btf_type_tag_ptr_type *)tag;
 }
=20
+static inline struct btf_type_tag_type *tag__btf_type_tag(struct tag *ta=
g)
+{
+	return (struct btf_type_tag_type *)tag;
+}
+
 /** struct namespace - base class for enums, structs, unions, typedefs, =
etc
  *
  * @tags - class_member, enumerators, etc
--=20
2.30.2


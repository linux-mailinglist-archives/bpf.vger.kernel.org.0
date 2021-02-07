Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A7312231
	for <lists+bpf@lfdr.de>; Sun,  7 Feb 2021 08:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhBGHSQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Feb 2021 02:18:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18656 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhBGHSP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Feb 2021 02:18:15 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1177EChS015678
        for <bpf@vger.kernel.org>; Sat, 6 Feb 2021 23:17:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5PC7WYr1QotyXssiolMqSmbktTZof/unhpuMu7UmYg8=;
 b=Horn5KpBJGE9vi7+/eTpDowUsfEvkktC8lIcBLOXqdf+RY0OpHoJXK/O5JY424q6kPaw
 ftM8pF4Q9rcdLlwXV2PJc7xR+rm2BInbn+fbJVDLwcFdIv2R5+ANWmxN6oTjyAW9vn3q
 SynEytotsmelujVvOrQhtfCEBv/rPvK/zLQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hsgtapp3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 23:17:34 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Feb 2021 23:17:32 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 049413705541; Sat,  6 Feb 2021 23:17:26 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <acme@kernel.org>, <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, <andriin@fb.com>, <mark@klomp.org>,
        <ndesaulniers@google.com>, <sedat.dilek@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH dwarves v2] btf_encoder: sanitize non-regular int base type
Date:   Sat, 6 Feb 2021 23:17:26 -0800
Message-ID: <20210207071726.3969978-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-07_03:2021-02-05,2021-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=968 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102070052
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

clang with dwarf5 may generate non-regular int base type,
i.e., not a signed/unsigned char/short/int/longlong/__int128.
Such base types are often used to describe
how an actual parameter or variable is generated. For example,

0x000015cf:   DW_TAG_base_type
                DW_AT_name      ("DW_ATE_unsigned_1")
                DW_AT_encoding  (DW_ATE_unsigned)
                DW_AT_byte_size (0x00)

0x00010ed9:         DW_TAG_formal_parameter
                      DW_AT_location    (DW_OP_lit0,
                                         DW_OP_not,
                                         DW_OP_convert (0x000015cf) "DW_A=
TE_unsigned_1",
                                         DW_OP_convert (0x000015d4) "DW_A=
TE_unsigned_8",
                                         DW_OP_stack_value)
                      DW_AT_abstract_origin     (0x00013984 "branch")

What it does is with a literal "0", did a "not" operation, and the conver=
ted to
one-bit unsigned int and then 8-bit unsigned int.

Another example,

0x000e97e4:   DW_TAG_base_type
                DW_AT_name      ("DW_ATE_unsigned_24")
                DW_AT_encoding  (DW_ATE_unsigned)
                DW_AT_byte_size (0x03)

0x000f88f8:     DW_TAG_variable
                  DW_AT_location        (indexed (0x3c) loclist =3D 0x000=
08fb0:
                     [0xffffffff82808812, 0xffffffff82808817):
                         DW_OP_breg0 RAX+0,
                         DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
                         DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
                         DW_OP_stack_value,
                         DW_OP_piece 0x1,
                         DW_OP_breg0 RAX+0,
                         DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
                         DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
                         DW_OP_lit8,
                         DW_OP_shr,
                         DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
                         DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
                         DW_OP_stack_value,
                         DW_OP_piece 0x3
                     ......

At one point, a right shift by 8 happens and the result is converted to
32-bit unsigned int and then to 24-bit unsigned int.

BTF does not need any of these DW_OP_* information and such non-regular i=
nt
types will cause libbpf to emit errors.
Let us sanitize them to generate BTF acceptable to libbpf and kernel.

Cc: Sedat Dilek <sedat.dilek@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 libbtf.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/libbtf.c b/libbtf.c
index 9f76283..5843200 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -373,6 +373,7 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, =
const struct base_type *bt,
 	struct btf *btf =3D btfe->btf;
 	const struct btf_type *t;
 	uint8_t encoding =3D 0;
+	uint16_t byte_sz;
 	int32_t id;
=20
 	if (bt->is_signed) {
@@ -384,7 +385,43 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe,=
 const struct base_type *bt,
 		return -1;
 	}
=20
-	id =3D btf__add_int(btf, name, BITS_ROUNDUP_BYTES(bt->bit_size), encodi=
ng);
+	/* dwarf5 may emit DW_ATE_[un]signed_{num} base types where
+	 * {num} is not power of 2 and may exceed 128. Such attributes
+	 * are mostly used to record operation for an actual parameter
+	 * or variable.
+	 * For example,
+	 *     DW_AT_location        (indexed (0x3c) loclist =3D 0x00008fb0:
+	 *         [0xffffffff82808812, 0xffffffff82808817):
+	 *             DW_OP_breg0 RAX+0,
+	 *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
+	 *             DW_OP_convert (0x000e97df) "DW_ATE_unsigned_8",
+	 *             DW_OP_stack_value,
+	 *             DW_OP_piece 0x1,
+	 *             DW_OP_breg0 RAX+0,
+	 *             DW_OP_convert (0x000e97d5) "DW_ATE_unsigned_64",
+	 *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
+	 *             DW_OP_lit8,
+	 *             DW_OP_shr,
+	 *             DW_OP_convert (0x000e97da) "DW_ATE_unsigned_32",
+	 *             DW_OP_convert (0x000e97e4) "DW_ATE_unsigned_24",
+	 *             DW_OP_stack_value, DW_OP_piece 0x3
+	 *     DW_AT_name    ("ebx")
+	 *     DW_AT_decl_file       ("/linux/arch/x86/events/intel/core.c")
+	 *
+	 * In the above example, at some point, one unsigned_32 value
+	 * is right shifted by 8 and the result is converted to unsigned_32
+	 * and then unsigned_24.
+	 *
+	 * BTF does not need such DW_OP_* information so let us sanitize
+	 * these non-regular int types to avoid libbpf/kernel complaints.
+	 */
+	byte_sz =3D BITS_ROUNDUP_BYTES(bt->bit_size);
+	if (!byte_sz || (byte_sz & (byte_sz - 1))) {
+		name =3D "__SANITIZED_FAKE_INT__";
+		byte_sz =3D 4;
+	}
+
+	id =3D btf__add_int(btf, name, byte_sz, encoding);
 	if (id < 0) {
 		btf_elf__log_err(btfe, BTF_KIND_INT, name, true, "Error emitting BTF t=
ype");
 	} else {
--=20
2.24.1


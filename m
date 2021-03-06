Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC6232F7CD
	for <lists+bpf@lfdr.de>; Sat,  6 Mar 2021 03:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhCFCXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 21:23:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229976AbhCFCWa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 21:22:30 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12622tdH178153;
        Fri, 5 Mar 2021 21:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UvMzac4fR3M6FuykqJViT1F13H50kgoqaTJEK4Bek/8=;
 b=RR2N2AIEJBF7lR9kRNCHZTQmt2CclielzUSdvHhoReMjX1/trXyLNAhUlGhcYbUvhMTL
 xgnSD9vxfSO3ESm2jNqhlCl5a95E4CBODeROfS/euJv3K8qgaXpIG7+wYI4AxjUydwdg
 bPfTiDuLObiLCZLP/10KgWlwfEyq99ljd5NuMv5hXCiEPZhUkHeW1En/jXqIzDtz7YHw
 Qv2mLX1Nwk09wZnwackipZDqkO682KjtNQxOmpZAygTQ2tGAfd7f8RX4u9KE7VYFZDms
 S6K6/mWNu4swEfCfo/4aiaot4ZovgsaVS25FZnZU1fK76XriHt1jypg42UNjlpCif4Tc zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3740byghg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 21:22:17 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1262C23b013590;
        Fri, 5 Mar 2021 21:22:17 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3740byghfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 21:22:16 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1262IIvc015130;
        Sat, 6 Mar 2021 02:22:15 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 371162m8gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Mar 2021 02:22:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1262MCmj42860982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 6 Mar 2021 02:22:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B6564C04A;
        Sat,  6 Mar 2021 02:22:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A85C4C040;
        Sat,  6 Mar 2021 02:22:11 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  6 Mar 2021 02:22:11 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] btf: Add support for the floating-point types
Date:   Sat,  6 Mar 2021 03:22:03 +0100
Message-Id: <20210306022203.152930-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_16:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103060011
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some BPF programs compiled on s390 fail to load, because s390
arch-specific linux headers contain float and double types.

Fix as follows:

- Make DWARF loader fill base_type.float_type.

- libbpf introduced support for the floating-point types in commit
  986962fade5, so update the libbpf submodule to that version and use
  the new btf__add_float() function in order to emit the floating-point
  types when base_type.float_type is set.

Example of the resulting entry in the vmlinux BTF:

    [7164] FLOAT 'double' size=8

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 btf_loader.c   | 21 +++++++++++++++++++--
 dwarf_loader.c | 11 +++++++++++
 lib/bpf        |  2 +-
 libbtf.c       | 28 +++++++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index ec286f4..7cc39aa 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -160,7 +160,7 @@ static struct variable *variable__new(strings_t name, uint32_t linkage)
 	return var;
 }
 
-static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
+static int create_new_int_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
 {
 	uint32_t attrs = btf_int_encoding(tp);
 	strings_t name = tp->name_off;
@@ -175,6 +175,20 @@ static int create_new_base_type(struct btf_elf *btfe, const struct btf_type *tp,
 	return 0;
 }
 
+static int create_new_float_type(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
+{
+	strings_t name = tp->name_off;
+	struct base_type *base = base_type__new(name, 0, BT_FP_SINGLE, tp->size * 8);
+
+	if (base == NULL)
+		return -ENOMEM;
+
+	base->tag.tag = DW_TAG_base_type;
+	cu__add_tag_with_id(btfe->priv, &base->tag, id);
+
+	return 0;
+}
+
 static int create_new_array(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
 {
 	struct btf_array *ap = btf_array(tp);
@@ -397,7 +411,7 @@ static int btf_elf__load_types(struct btf_elf *btfe)
 
 		switch (type) {
 		case BTF_KIND_INT:
-			err = create_new_base_type(btfe, type_ptr, type_index);
+			err = create_new_int_type(btfe, type_ptr, type_index);
 			break;
 		case BTF_KIND_ARRAY:
 			err = create_new_array(btfe, type_ptr, type_index);
@@ -442,6 +456,9 @@ static int btf_elf__load_types(struct btf_elf *btfe)
 			// BTF_KIND_FUNC corresponding to a defined subprogram.
 			err = create_new_function(btfe, type_ptr, type_index);
 			break;
+		case BTF_KIND_FLOAT:
+			err = create_new_float_type(btfe, type_ptr, type_index);
+			break;
 		default:
 			fprintf(stderr, "BTF: idx: %d, Unknown kind %d\n", type_index, type);
 			fflush(stderr);
diff --git a/dwarf_loader.c b/dwarf_loader.c
index b73d786..c5e6681 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -461,6 +461,16 @@ static struct ptr_to_member_type *ptr_to_member_type__new(Dwarf_Die *die,
 	return ptr;
 }
 
+static uint8_t encoding_to_float_type(uint64_t encoding)
+{
+	switch (encoding) {
+	case DW_ATE_complex_float:	return BT_FP_CMPLX;
+	case DW_ATE_float:		return BT_FP_SINGLE;
+	case DW_ATE_imaginary_float:	return BT_FP_IMGRY;
+	default:			return 0;
+	}
+}
+
 static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu)
 {
 	struct base_type *bt = tag__alloc(cu, sizeof(*bt));
@@ -474,6 +484,7 @@ static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu)
 		bt->is_signed = encoding == DW_ATE_signed;
 		bt->is_varargs = false;
 		bt->name_has_encoding = true;
+		bt->float_type = encoding_to_float_type(encoding);
 	}
 
 	return bt;
diff --git a/lib/bpf b/lib/bpf
index 5af3d86..986962f 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
+Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
diff --git a/libbtf.c b/libbtf.c
index 9f76283..ccd9f90 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -227,6 +227,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_FUNC_PROTO]	= "FUNC_PROTO",
 	[BTF_KIND_VAR]          = "VAR",
 	[BTF_KIND_DATASEC]      = "DATASEC",
+	[BTF_KIND_FLOAT]        = "FLOAT",
 };
 
 static const char *btf_elf__printable_name(const struct btf_elf *btfe, uint32_t offset)
@@ -367,6 +368,27 @@ static void btf_log_func_param(const struct btf_elf *btfe,
 	}
 }
 
+static int32_t btf_elf__add_float_type(struct btf_elf *btfe,
+				       const struct base_type *bt,
+				       const char *name)
+{
+	int32_t id;
+
+	id = btf__add_float(btfe->btf, name, BITS_ROUNDUP_BYTES(bt->bit_size));
+	if (id < 0) {
+		btf_elf__log_err(btfe, BTF_KIND_FLOAT, name, true, "Error emitting BTF type");
+	} else {
+		const struct btf_type *t;
+
+		t = btf__type_by_id(btfe->btf, id);
+		btf_elf__log_type(btfe, t, false, true,
+				  "size=%u nr_bits=%u",
+				  t->size, bt->bit_size);
+	}
+
+	return id;
+}
+
 int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
 			       const char *name)
 {
@@ -380,7 +402,11 @@ int32_t btf_elf__add_base_type(struct btf_elf *btfe, const struct base_type *bt,
 	} else if (bt->is_bool) {
 		encoding = BTF_INT_BOOL;
 	} else if (bt->float_type) {
-		fprintf(stderr, "float_type is not supported\n");
+		if (bt->float_type == BT_FP_SINGLE ||
+		    bt->float_type == BT_FP_DOUBLE ||
+		    bt->float_type == BT_FP_LDBL)
+			return btf_elf__add_float_type(btfe, bt, name);
+		fprintf(stderr, "Complex, interval and imaginary float types are not supported\n");
 		return -1;
 	}
 
-- 
2.29.2


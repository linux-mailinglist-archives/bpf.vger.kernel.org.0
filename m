Return-Path: <bpf+bounces-27695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC5C8B0EFC
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2871C23C38
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E2815FCE1;
	Wed, 24 Apr 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hIeMOx6S"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4ED1607B8
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973741; cv=none; b=RmiZcWGfoWJD1bSsP1urZFHg2wdbg6LTNHAn2raj6Adii7d7umQJw+vIPeebuxgsGruwY4hgSbHaoFpXi1MGTWDv1jdu0w648NjptnTUQtMvGKeAoaMREIom+70hVxkUZy0CJJlIPM4w2n+xTa2+LKizn6+R8RgCLF8ZCEkJ07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973741; c=relaxed/simple;
	bh=1Tm64U2VXDNxRKAQFFzWe7+YlLEjWBfe7UGqNk3HrFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJnlRKFwlpazyA2IDx5Vffw06Pyi9038+hfVPGpgZmh6e4tWFkM75u7jtejoFq8C7W3kjn/IYxKyJZZUKsleqgswOtEEOYmsYtMqhHQYLIQyXPzNpYX+KT/O0RGDP/NP5cFDKWWry6/aeYq2bmQPqHnSOqhomFf8/b0/6oi9j54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hIeMOx6S; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OFa4Bi009710;
	Wed, 24 Apr 2024 15:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=UAjEGmcXA0+jAPQBfwk/h4UgTHuvNnI0HhOIA5YT7tY=;
 b=hIeMOx6SRBT0ex4QUahICSB+CNBXYHO+YgP1lV83T9zgkpLp3xjyEmlNvnvLXzhzCa+r
 M2919Z+9OUCXgjQVXBsFMWr/siQ5JAhbmO/ZMi6JamSSqbOW5R7RDSToUco6/awFHB+c
 2drt6vjqB0acZ5DdUyuifXzTRO9EDqb2LBl3znbQY+q4Z1SX06A+dhMmbst4M8fNDsWN
 2pqPjsOpWHhnK3mvzEEHCzRg6c78Oys19WGG/ODZFk6uXsAXVJxRKfQiN/oYRDgqfpzK
 1sReyCUH0RTlru6R4UUk13dd6hPbiDjLnaGZbkZNPUVQRQvB+TZmZfpt7TwplnoWvcGx Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbs3tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OEguDx025273;
	Wed, 24 Apr 2024 15:48:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45faybm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 15:48:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OFmCoU008769;
	Wed, 24 Apr 2024 15:48:27 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-216-158.vpn.oracle.com [10.175.216.158])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xm45faxuq-4;
	Wed, 24 Apr 2024 15:48:27 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
        eddyz87@gmail.com, mykolal@fb.com, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 03/13] selftests/bpf: test distilled base, split BTF generation
Date: Wed, 24 Apr 2024 16:47:56 +0100
Message-Id: <20240424154806.3417662-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240424154806.3417662-1-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_13,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240063
X-Proofpoint-GUID: hW0Xf4b7er45WY4soSZNvZWA6MrCiICt
X-Proofpoint-ORIG-GUID: hW0Xf4b7er45WY4soSZNvZWA6MrCiICt

Test generation of split+distilled base BTF, ensuring that

- base BTF STRUCTs which are embedded in split BTF structs are
  represented as 0-member sized structs, allowing size checking
- FWDs are used in place of full named struct/union declarations
- FWDs are used in place of full named enum declarations
- anonymous struct/unions are represented in full
- anonymous enums are represented in full
- types unreferenced from split BTF are not present in distilled
  base BTF

Also test that with vmlinux BTF and split BTF based upon it,
we only represent needed base types referenced from split BTF
in distilled base.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 253 ++++++++++++++++++
 1 file changed, 253 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
new file mode 100644
index 000000000000..aae9aef68bd6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
+
+/* Fabricate base, split BTF with references to base types needed; then create
+ * split BTF with distilled base BTF and ensure expectations are met:
+ *  - only referenced base types from split BTF are present
+ *  - struct/union/enum are represented as FWDs unless anonymous, when they
+ *    are represented in full, or if embedded in a split BTF struct, in which
+ *    case they are represented by a STRUCT with specified size and vlen=0.
+ */
+static void test_distilled_base(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_ptr(btf1, 1);				/* [2] ptr to int */
+	btf__add_struct(btf1, "s1", 8);			/* [3] struct s1 { */
+	btf__add_field(btf1, "f1", 2, 0, 0);		/*      int *f1; */
+							/* } */
+	btf__add_struct(btf1, "", 12);			/* [4] struct { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+	btf__add_field(btf1, "f2", 3, 32, 0);		/*	struct s1 f2; */
+							/* } */
+	btf__add_int(btf1, "unsigned int", 4, 0);	/* [5] unsigned int */
+	btf__add_union(btf1, "u1", 12);			/* [6] union u1 { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+	btf__add_field(btf1, "f2", 2, 0, 0);		/*	int *f2; */
+							/* } */
+	btf__add_union(btf1, "", 4);			/* [7] union { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+							/* } */
+	btf__add_enum(btf1, "e1", 4);			/* [8] enum e1 { */
+	btf__add_enum_value(btf1, "v1", 1);		/*	v1 = 1; */
+							/* } */
+	btf__add_enum(btf1, "", 4);			/* [9] enum { */
+	btf__add_enum_value(btf1, "av1", 2);		/*	av1 = 2; */
+							/* } */
+	btf__add_enum64(btf1, "e641", 8, true);		/* [10] enum64 { */
+	btf__add_enum64_value(btf1, "v1", 1024);	/*	v1 = 1024; */
+							/* } */
+	btf__add_enum64(btf1, "", 8, true);		/* [11] enum64 { */
+	btf__add_enum64_value(btf1, "v1", 1025);	/*	v1 = 1025; */
+							/* } */
+	btf__add_struct(btf1, "unneeded", 4);		/* [12] struct unneeded { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+							/* } */
+	btf__add_struct(btf1, "embedded", 4);		/* [13] struct embedded { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+							/* } */
+	btf__add_func_proto(btf1, 1);			/* [14] int (*)(int *p1); */
+	btf__add_func_param(btf1, "p1", 1);
+
+	btf__add_array(btf1, 1, 1, 3);			/* [15] int [3]; */
+
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=8 vlen=1\n"
+		"\t'f1' type_id=2 bits_offset=0",
+		"[4] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=3 bits_offset=32",
+		"[5] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)",
+		"[6] UNION 'u1' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=0",
+		"[7] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[8] ENUM 'e1' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'v1' val=1",
+		"[9] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[10] ENUM64 'e641' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1024",
+		"[11] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[12] STRUCT 'unneeded' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[13] STRUCT 'embedded' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[14] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[15] ARRAY '(anon)' type_id=1 index_type_id=1 nr_elems=3");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+
+	btf__add_ptr(btf2, 3);				/* [16] ptr to struct s1 */
+	/* add ptr to struct anon */
+	btf__add_ptr(btf2, 4);				/* [17] ptr to struct (anon) */
+	btf__add_const(btf2, 6);			/* [18] const union u1 */
+	btf__add_restrict(btf2, 7);			/* [19] restrict union (anon) */
+	btf__add_volatile(btf2, 8);			/* [20] volatile enum e1 */
+	btf__add_typedef(btf2, "et", 9);		/* [21] typedef enum (anon) */
+	btf__add_const(btf2, 10);			/* [22] const enum64 e641 */
+	btf__add_ptr(btf2, 11);				/* [23] restrict enum64 (anon) */
+	btf__add_struct(btf2, "with_embedded", 4);	/* [24] struct with_embedded { */
+	btf__add_field(btf2, "f1", 13, 0, 0);		/*	struct embedded f1; */
+							/* } */
+	btf__add_func(btf2, "fn", BTF_FUNC_STATIC, 14);	/* [25] int fn(int p1); */
+	btf__add_typedef(btf2, "arraytype", 15);	/* [26] typedef int[3] foo; */
+
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=8 vlen=1\n"
+		"\t'f1' type_id=2 bits_offset=0",
+		"[4] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=3 bits_offset=32",
+		"[5] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)",
+		"[6] UNION 'u1' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=0",
+		"[7] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[8] ENUM 'e1' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'v1' val=1",
+		"[9] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[10] ENUM64 'e641' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1024",
+		"[11] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[12] STRUCT 'unneeded' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[13] STRUCT 'embedded' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[14] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[15] ARRAY '(anon)' type_id=1 index_type_id=1 nr_elems=3",
+		"[16] PTR '(anon)' type_id=3",
+		"[17] PTR '(anon)' type_id=4",
+		"[18] CONST '(anon)' type_id=6",
+		"[19] RESTRICT '(anon)' type_id=7",
+		"[20] VOLATILE '(anon)' type_id=8",
+		"[21] TYPEDEF 'et' type_id=9",
+		"[22] CONST '(anon)' type_id=10",
+		"[23] PTR '(anon)' type_id=11",
+		"[24] STRUCT 'with_embedded' size=4 vlen=1\n"
+		"\t'f1' type_id=13 bits_offset=0",
+		"[25] FUNC 'fn' type_id=14 linkage=static",
+		"[26] TYPEDEF 'arraytype' type_id=15");
+
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf4,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FWD 's1' fwd_kind=struct",
+		"[3] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=32",
+		"[4] FWD 'u1' fwd_kind=union",
+		"[5] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[6] ENUM 'e1' encoding=UNSIGNED size=4 vlen=0",
+		"[7] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[8] ENUM64 'e641' encoding=SIGNED size=8 vlen=0",
+		"[9] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[10] STRUCT 'embedded' size=4 vlen=0",
+		"[11] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[12] ARRAY '(anon)' type_id=1 index_type_id=1 nr_elems=3",
+		"[13] PTR '(anon)' type_id=2",
+		"[14] PTR '(anon)' type_id=3",
+		"[15] CONST '(anon)' type_id=4",
+		"[16] RESTRICT '(anon)' type_id=5",
+		"[17] VOLATILE '(anon)' type_id=6",
+		"[18] TYPEDEF 'et' type_id=7",
+		"[19] CONST '(anon)' type_id=8",
+		"[20] PTR '(anon)' type_id=9",
+		"[21] STRUCT 'with_embedded' size=4 vlen=1\n"
+		"\t'f1' type_id=10 bits_offset=0",
+		"[22] FUNC 'fn' type_id=11 linkage=static",
+		"[23] TYPEDEF 'arraytype' type_id=12");
+
+cleanup:
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
+/* create split reference BTF from vmlinux + split BTF with a few type references;
+ * ensure the resultant split reference BTF is as expected, containing only types
+ * needed to disambiguate references from split BTF.
+ */
+static void test_distilled_base_vmlinux(void)
+{
+	struct btf *split_btf = NULL, *vmlinux_btf = btf__load_vmlinux_btf();
+	struct btf *split_dist = NULL, *base_dist = NULL;
+	__s32 int_id, sk_buff_id;
+
+	if (!ASSERT_OK_PTR(vmlinux_btf, "load_vmlinux"))
+		return;
+	int_id = btf__find_by_name_kind(vmlinux_btf, "int", BTF_KIND_INT);
+	if (!ASSERT_GT(int_id, 0, "find_int"))
+		goto cleanup;
+	sk_buff_id = btf__find_by_name_kind(vmlinux_btf, "sk_buff", BTF_KIND_STRUCT);
+	if (!ASSERT_GT(sk_buff_id, 0, "find_sk_buff_id"))
+		goto cleanup;
+	split_btf = btf__new_empty_split(vmlinux_btf);
+	if (!ASSERT_OK_PTR(split_btf, "new_split"))
+		goto cleanup;
+	btf__add_typedef(split_btf, "myint", int_id);
+	btf__add_ptr(split_btf, sk_buff_id);
+
+	if (!ASSERT_EQ(btf__distill_base(split_btf, &base_dist, &split_dist), 0,
+		       "distill_vmlinux_base"))
+		goto cleanup;
+
+	if (!ASSERT_OK_PTR(split_dist, "split_distilled") ||
+	    !ASSERT_OK_PTR(base_dist, "base_dist"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		split_dist,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] FWD 'sk_buff' fwd_kind=struct",
+		"[3] TYPEDEF 'myint' type_id=1",
+		"[4] PTR '(anon)' type_id=2");
+
+cleanup:
+	btf__free(split_dist);
+	btf__free(base_dist);
+	btf__free(split_btf);
+	btf__free(vmlinux_btf);
+}
+
+void test_btf_distill(void)
+{
+	if (test__start_subtest("distilled_base"))
+		test_distilled_base();
+	if (test__start_subtest("distilled_base_vmlinux"))
+		test_distilled_base_vmlinux();
+}
-- 
2.31.1



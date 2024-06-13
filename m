Return-Path: <bpf+bounces-32054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BE90694A
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC5286229
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D817014037D;
	Thu, 13 Jun 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ScldR3Ye"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3605140384
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272260; cv=none; b=oCpIJ6/z4H0t05oj29O6wlwdbxATPXYJS44p3+1mFj0iMy2LALGMkgM/FeJy/PPQ/rmXPrMvn/5R618Ai4a8OGdObx4mSE1cT/G7VjH3jGyHycS7vmxNvuIHVw6n9c9yBHCK2WfKunWRydC7GB1zkNaG8WqUGDLge48W+5p5XKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272260; c=relaxed/simple;
	bh=jaQUYwxa9axfpVXNQTKvLiQAohdbZYiSGuDob0tjzXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rF+y2qDny1TwQDym1PpByotKjSqO934G1g+tne7lZo3uACD/MQl/UqVcPokHSm+uIm9hL6q9Sv3bq0PTs3b78majEg+U/1JXYFbRAEKFpzPbO3QjiBW3BSYmr+epk9S6bMIny5qEi8oQWR7Y8k3fIa+YWb5zsfqGVJaw5h9Sp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ScldR3Ye; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7tYfF031506;
	Thu, 13 Jun 2024 09:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=0
	x8mhd+XnjkdRcRF83IL1XR9DpoG9Su2WW6GEUnN2LE=; b=ScldR3Ye64wbIFhIk
	yIYzlyWnzi5sWxeMPmATcvXgpKWMc54k8Wwa7tax9oRSpy/4swgGVibG6m/ZpbKH
	jNBpzpJac9AuxUCBkTT40jrvtoXMAPK4Ns5GFe1dnljmJTb7y4qkwZWp5EC1LmCX
	c/Ji0o21qACiTPsPls+ILOiMOhRF4TawBdxUoMj/4ksQU0j9778Y8BxXRvkNe6tc
	4XvUPif+VqZQjqYh0puI923fgUdQ8uyl1TSVUCz3PUu9p/9JYG6zRhT2qfL39mio
	OwByMJTD8GgZXqfJCkbq1yBkshuZfKKVb3YZZw/bD0gTKn4slhLOnZs4d4pvQDm6
	+wEJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7ds5u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D8cR9x014365;
	Thu, 13 Jun 2024 09:50:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncewnkyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:29 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45D9oJps005489;
	Thu, 13 Jun 2024 09:50:28 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-187.vpn.oracle.com [10.175.212.187])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yncewnkqw-3;
	Thu, 13 Jun 2024 09:50:28 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 2/9] selftests/bpf: test distilled base, split BTF generation
Date: Thu, 13 Jun 2024 10:50:07 +0100
Message-Id: <20240613095014.357981-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240613095014.357981-1-alan.maguire@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130070
X-Proofpoint-GUID: ojKS1maD9jTYbXMM9iwY3QeQ6wyBDmLL
X-Proofpoint-ORIG-GUID: ojKS1maD9jTYbXMM9iwY3QeQ6wyBDmLL

Test generation of split+distilled base BTF, ensuring that

- named base BTF STRUCTs and UNIONs are represented as 0-vlen sized
  STRUCT/UNIONs
- named ENUM[64]s are represented as 0-vlen named ENUM[64]s
- anonymous struct/unions are represented in full in split BTF
- anonymous enums are represented in full in split BTF
- types unreferenced from split BTF are not present in distilled
  base BTF

Also test that with vmlinux BTF and split BTF based upon it,
we only represent needed base types referenced from split BTF
in distilled base.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 274 ++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
new file mode 100644
index 000000000000..5c3a38747962
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -0,0 +1,274 @@
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
+ *  - struct/union/enum are represented as empty unless anonymous, when they
+ *    are represented in full in split BTF
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
+	btf__add_struct(btf1, "from_proto", 4);		/* [16] struct from_proto { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	int f1; */
+							/* } */
+	btf__add_union(btf1, "u1", 4);			/* [17] union u1 { */
+	btf__add_field(btf1, "f1", 1, 0, 0);		/*	 int f1; */
+							/* } */
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
+		"[15] ARRAY '(anon)' type_id=1 index_type_id=1 nr_elems=3",
+		"[16] STRUCT 'from_proto' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[17] UNION 'u1' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0");
+
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+
+	btf__add_ptr(btf2, 3);				/* [18] ptr to struct s1 */
+	/* add ptr to struct anon */
+	btf__add_ptr(btf2, 4);				/* [19] ptr to struct (anon) */
+	btf__add_const(btf2, 6);			/* [20] const union u1 */
+	btf__add_restrict(btf2, 7);			/* [21] restrict union (anon) */
+	btf__add_volatile(btf2, 8);			/* [22] volatile enum e1 */
+	btf__add_typedef(btf2, "et", 9);		/* [23] typedef enum (anon) */
+	btf__add_const(btf2, 10);			/* [24] const enum64 e641 */
+	btf__add_ptr(btf2, 11);				/* [25] restrict enum64 (anon) */
+	btf__add_struct(btf2, "with_embedded", 4);	/* [26] struct with_embedded { */
+	btf__add_field(btf2, "f1", 13, 0, 0);		/*	struct embedded f1; */
+							/* } */
+	btf__add_func(btf2, "fn", BTF_FUNC_STATIC, 14);	/* [27] int fn(int p1); */
+	btf__add_typedef(btf2, "arraytype", 15);	/* [28] typedef int[3] foo; */
+	btf__add_func_proto(btf2, 1);			/* [29] int (*)(struct from proto p1); */
+	btf__add_func_param(btf2, "p1", 16);
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
+		"[16] STRUCT 'from_proto' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[17] UNION 'u1' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[18] PTR '(anon)' type_id=3",
+		"[19] PTR '(anon)' type_id=4",
+		"[20] CONST '(anon)' type_id=6",
+		"[21] RESTRICT '(anon)' type_id=7",
+		"[22] VOLATILE '(anon)' type_id=8",
+		"[23] TYPEDEF 'et' type_id=9",
+		"[24] CONST '(anon)' type_id=10",
+		"[25] PTR '(anon)' type_id=11",
+		"[26] STRUCT 'with_embedded' size=4 vlen=1\n"
+		"\t'f1' type_id=13 bits_offset=0",
+		"[27] FUNC 'fn' type_id=14 linkage=static",
+		"[28] TYPEDEF 'arraytype' type_id=15",
+		"[29] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=16");
+
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
+	    !ASSERT_EQ(8, btf__type_cnt(btf3), "distilled_base_type_cnt"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf4,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] STRUCT 's1' size=8 vlen=0",
+		"[3] UNION 'u1' size=12 vlen=0",
+		"[4] ENUM 'e1' encoding=UNSIGNED size=4 vlen=0",
+		"[5] ENUM 'e641' encoding=UNSIGNED size=8 vlen=0",
+		"[6] STRUCT 'embedded' size=4 vlen=0",
+		"[7] STRUCT 'from_proto' size=4 vlen=0",
+		/* split BTF; these types should match split BTF above from 17-28, with
+		 * updated type id references
+		 */
+		"[8] PTR '(anon)' type_id=2",
+		"[9] PTR '(anon)' type_id=20",
+		"[10] CONST '(anon)' type_id=3",
+		"[11] RESTRICT '(anon)' type_id=21",
+		"[12] VOLATILE '(anon)' type_id=4",
+		"[13] TYPEDEF 'et' type_id=22",
+		"[14] CONST '(anon)' type_id=5",
+		"[15] PTR '(anon)' type_id=23",
+		"[16] STRUCT 'with_embedded' size=4 vlen=1\n"
+		"\t'f1' type_id=6 bits_offset=0",
+		"[17] FUNC 'fn' type_id=24 linkage=static",
+		"[18] TYPEDEF 'arraytype' type_id=25",
+		"[19] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=7",
+		/* split BTF types added from original base BTF below */
+		"[20] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=32",
+		"[21] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[22] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[23] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[24] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[25] ARRAY '(anon)' type_id=1 index_type_id=1 nr_elems=3");
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
+	__s32 int_id, myint_id;
+
+	if (!ASSERT_OK_PTR(vmlinux_btf, "load_vmlinux"))
+		return;
+	int_id = btf__find_by_name_kind(vmlinux_btf, "int", BTF_KIND_INT);
+	if (!ASSERT_GT(int_id, 0, "find_int"))
+		goto cleanup;
+	split_btf = btf__new_empty_split(vmlinux_btf);
+	if (!ASSERT_OK_PTR(split_btf, "new_split"))
+		goto cleanup;
+	myint_id = btf__add_typedef(split_btf, "myint", int_id);
+	btf__add_ptr(split_btf, myint_id);
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
+		"[2] TYPEDEF 'myint' type_id=1",
+		"[3] PTR '(anon)' type_id=2");
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



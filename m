Return-Path: <bpf+bounces-29933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9368C84B5
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 12:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69501283F3C
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1536B09;
	Fri, 17 May 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fNzCeVli"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE03B36B1D
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941416; cv=none; b=cFXEP1guGrxbdOa5mXRudcX7dLoYuRnt97lusk8HWhQyg0dEC6IyDTeGtFDWZuIO9DgAJ/+imxEU3XwshBq6BQhcehxX8Qt5/oMkPvWYE4+MUG4Q5D6J7upKVWz1k/apzZErGMMghkoXcP3uL+iX7CVhV+f9sT4iYBrZTpU1NSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941416; c=relaxed/simple;
	bh=kvZcZfElvXPoJHIb6kL3M0t1ACxvRp6K8QlXKKeKCyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOB0CYmxaLNx7HKuSL2wS3PD1TA9OZJRrpQXiNfN4h0l/d37R7FlOFVK/AvAzN9s9tET6QN1l8NkuFpLG7iXnRoWCYwb37Gkh3gj0CDmxqJOiJmLhQTb91E0pWo0WylsMY65B+PaROCsoUAFxtL2mu81ELg85vUP2aJRxiGEH9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fNzCeVli; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44HA3DI2020469;
	Fri, 17 May 2024 10:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=82V+LpPII3apndW5F1O3nzJBL+KgnFPQDc3BDb9mujM=;
 b=fNzCeVlijQF5tg5PI3ZQJ9FyZ9ghoP6mnGD9ilsjYxPldA4Dnyl7UhW6GiCxam4rDs69
 JtENNZbo9QAZAiQwEUYtaVI2MBsM+J/quNDtv8JJypPnELQxfzYfh0xYr7wE1wRUVEZ1
 whCfzTHQ1aXwlRm4ZmGtwx9MhNm0IwFy4AG7W/0V58DikP74VQlewP280g2tV5aC0Z4e
 fVtvrGFPgJHsycUzYYW+cHVofBBuubb3zS1y3OnLoVWC98wFKO404mmC8Kdq2UAURe3f
 wVLO2YI3O8O83ijApMm/JEp6Jvm/PUUFNEGy2F9QP+Hz9lIIDcM60GGqh58ZS731fVOO pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4fhg67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HA2YPK000531;
	Fri, 17 May 2024 10:23:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fsuqrx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:04 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HAMqFc036134;
	Fri, 17 May 2024 10:23:03 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-196-17.vpn.oracle.com [10.175.196.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y4fsuqrr2-3;
	Fri, 17 May 2024 10:23:03 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 02/11] selftests/bpf: test distilled base, split BTF generation
Date: Fri, 17 May 2024 11:22:37 +0100
Message-Id: <20240517102246.4070184-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240517102246.4070184-1-alan.maguire@oracle.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170082
X-Proofpoint-ORIG-GUID: UN_nbyYQgt0NZwfkYlR_6KqNmegvpjLW
X-Proofpoint-GUID: UN_nbyYQgt0NZwfkYlR_6KqNmegvpjLW

Test generation of split+distilled base BTF, ensuring that

- base BTF STRUCTs which are embedded in split BTF structs are
  represented as 0-member sized structs, allowing size checking
- base BTF UNION which has a duplicate-named UNION is represented
  as a 0-member sized union, helping clarify which union is referred
  to
- FWDs are used in place of full named struct/union declarations
- FWDs are used in place of full named enum declarations
- anonymous struct/unions are represented in full in split BTF
- anonymous enums are represented in full in split BTF
- types unreferenced from split BTF are not present in distilled
  base BTF

Also test that with vmlinux BTF and split BTF based upon it,
we only represent needed base types referenced from split BTF
in distilled base.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 279 ++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_distill.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
new file mode 100644
index 000000000000..4ab522df041c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -0,0 +1,279 @@
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
+ *    are represented in full, or if embedded in a split BTF struct or duplicated
+ *    case they are represented by a STRUCT/UNION with specified size and vlen=0.
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
+		"[2] FWD 's1' fwd_kind=struct",
+		"[3] UNION 'u1' size=12 vlen=0",
+		"[4] ENUM 'e1' encoding=UNSIGNED size=4 vlen=0",
+		"[5] ENUM 'e641' encoding=UNSIGNED size=8 vlen=0",
+		"[6] STRUCT 'embedded' size=4 vlen=0",
+		"[7] FWD 'from_proto' fwd_kind=struct",
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



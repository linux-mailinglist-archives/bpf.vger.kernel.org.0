Return-Path: <bpf+bounces-31446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D398FD1BE
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D16BB29C40
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 15:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0F761FDF;
	Wed,  5 Jun 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H8H/NaD3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08E48CFC
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601639; cv=none; b=Eve+dRldFE/K6ir0kecJTIhvfhK3UjUPuXZC8QTzipwbXysmIDisVCEc0bXnW5XQ4kw135eoZGOylFhGiDDTWcRfSj3atK8hjdsbUBX4VGJUrcnOnViMlAiBwmL1P4QFHQNgQMHgUk3pGHYS5Hc0laeSJamHkqdHq7BvdYJyHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601639; c=relaxed/simple;
	bh=5XrE2ZsABpzGGdz3yuXJ5GWjz36eHT5q+NO7eHVtbVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrIUlcnOUyBsjNXEOcifcot5414juooOkhlAfN5LGzNl1arhgUVw86vSrpNxJ7//JGhPh2PcRTQ7wS9HidtOHy9uR/EUIyOcxDHkPACYeyWbC/TP/KCexhjyb5l+nfMJT6Xx1jpzCJd/T7C1g0eUwf19+TtApp3qsJio+kqeDQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H8H/NaD3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 455CV23I026622;
	Wed, 5 Jun 2024 15:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=corp-2023-11-20;
 bh=2ajI3rU0eItHv+4852ck+j5iC5UW0yA8UO1QDfS1bEo=;
 b=H8H/NaD3x69EIVKTXnHk5b8GDPENyjeXN4aWYnfaMf+9c1XJLN7APzelrw+jiSC0c2t7
 K/FVjDBov8B/Ez0wy0bfqEtV5b9cULyvFImJF3X90C0NZmM4KpU885C0Z8aunswI/XZu
 lXv2GVclTmy3vEGnhxqv+CaLzJyMf6uCDUuDQnC0/V72XzyTHty2VysYPztqkd5xK7K+
 UkZjCv+GPY6xywWl5H9HF9gWE3NhcJTbyanbcECivMfb5RimnFEBfT5fxq/nOXJ+c4cd
 xFI4oVBZuXTdxOCHjp6IfCr26/T7r8Q6nG7mlvqb3dXKQ+oq55oRLEJAPjuJXEhFGbqH LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn1k0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 15:33:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 455F1nXm016188;
	Wed, 5 Jun 2024 15:33:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsbpx38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Jun 2024 15:33:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 455FXWff001117;
	Wed, 5 Jun 2024 15:33:32 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-181-216.vpn.oracle.com [10.175.181.216])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ygrsbpwsy-1;
	Wed, 05 Jun 2024 15:33:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, jolsa@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] selftests/bpf: add btf_field_iter selftests
Date: Wed,  5 Jun 2024 16:33:14 +0100
Message-Id: <20240605153314.3727466-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406050118
X-Proofpoint-ORIG-GUID: KnVEi-ujymWPDvfkfICCun643erR7xL_
X-Proofpoint-GUID: KnVEi-ujymWPDvfkfICCun643erR7xL_

Selftests verify that for every BTF kind we iterate correctly
over consituent strings and ids.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_field_iter.c | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_field_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c b/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
new file mode 100644
index 000000000000..32159d3eb281
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_field_iter.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
+#include "bpf/libbpf_internal.h"
+
+struct field_data {
+	__u32 ids[5];
+	const char *strs[5];
+} fields[] = {
+	{ .ids = {},		.strs = {} },
+	{ .ids = {},		.strs = { "int" } },
+	{ .ids = {},		.strs = { "int64" } },
+	{ .ids = { 1 },		.strs = { "" } },
+	{ .ids = { 2, 1 },	.strs = { "" } },
+	{ .ids = { 3, 1 },	.strs = { "s1", "f1", "f2" } },
+	{ .ids = { 1, 5 },	.strs = { "u1", "f1", "f2" } },
+	{ .ids = {},		.strs = { "e1", "v1", "v2" } },
+	{ .ids = {},		.strs = { "fw1" } },
+	{ .ids = { 1 },		.strs = { "t" } },
+	{ .ids = { 2 },		.strs = { "" } },
+	{ .ids = { 1 },		.strs = { "" } },
+	{ .ids = { 3 },		.strs = { "" } },
+	{ .ids = { 1, 1, 3 },	.strs = { "", "p1", "p2" } },
+	{ .ids = { 13 },	.strs = { "func" } },
+	{ .ids = { 1 },		.strs = { "var1" } },
+	{ .ids = { 3 },		.strs = { "var2" } },
+	{ .ids = {},		.strs = { "float" } },
+	{ .ids = { 11 },	.strs = { "decltag" } },
+	{ .ids = { 6 },		.strs = { "typetag" } },
+	{ .ids = {},		.strs = { "e64", "eval1", "eval2", "eval3" } },
+	{ .ids = { 15, 16 },	.strs = { "datasec1" } }
+
+};
+
+/* Fabricate BTF with various types and check BTF field iteration finds types,
+ * strings expected.
+ */
+void test_btf_field_iter(void)
+{
+	struct btf *btf = NULL;
+	int id;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "empty_btf"))
+		return;
+
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);	/* [1] int */
+	btf__add_int(btf, "int64", 8, BTF_INT_SIGNED);	/* [2] int64 */
+	btf__add_ptr(btf, 1);				/* [3] int * */
+	btf__add_array(btf, 1, 2, 3);			/* [4] int64[3] */
+	btf__add_struct(btf, "s1", 12);			/* [5] struct s1 { */
+	btf__add_field(btf, "f1", 3, 0, 0);		/*      int *f1; */
+	btf__add_field(btf, "f2", 1, 0, 0);		/*	int f2; */
+							/* } */
+	btf__add_union(btf, "u1", 12);			/* [6] union u1 { */
+	btf__add_field(btf, "f1", 1, 0, 0);		/*	int f1; */
+	btf__add_field(btf, "f2", 5, 0, 0);		/*	struct s1 f2; */
+							/* } */
+	btf__add_enum(btf, "e1", 4);			/* [7] enum e1 { */
+	btf__add_enum_value(btf, "v1", 1);		/*	v1 = 1; */
+	btf__add_enum_value(btf, "v2", 2);		/*	v2 = 2; */
+							/* } */
+
+	btf__add_fwd(btf, "fw1", BTF_FWD_STRUCT);	/* [8] struct fw1; */
+	btf__add_typedef(btf, "t", 1);			/* [9] typedef int t; */
+	btf__add_volatile(btf, 2);			/* [10] volatile int64; */
+	btf__add_const(btf, 1);				/* [11] const int; */
+	btf__add_restrict(btf, 3);			/* [12] restrict int *; */
+	btf__add_func_proto(btf, 1);			/* [13] int (*)(int p1, int *p2); */
+	btf__add_func_param(btf, "p1", 1);
+	btf__add_func_param(btf, "p2", 3);
+
+	btf__add_func(btf, "func", BTF_FUNC_GLOBAL, 13);/* [14] int func(int p1, int *p2); */
+	btf__add_var(btf, "var1", BTF_VAR_STATIC, 1);	/* [15] static int var1; */
+	btf__add_var(btf, "var2", BTF_VAR_STATIC, 3);	/* [16] static int *var2; */
+	btf__add_float(btf, "float", 4);		/* [17] float; */
+	btf__add_decl_tag(btf, "decltag", 11, -1);	/* [18] decltag const int; */
+	btf__add_type_tag(btf, "typetag", 6);		/* [19] typetag union u1; */
+	btf__add_enum64(btf, "e64", 8, true);		/* [20] enum { */
+	btf__add_enum64_value(btf, "eval1", 1000);	/*	 eval1 = 1000, */
+	btf__add_enum64_value(btf, "eval2", 2000);	/*	 eval2 = 2000, */
+	btf__add_enum64_value(btf, "eval3", 3000);	/*	 eval3 = 3000 */
+							/* } */
+	btf__add_datasec(btf, "datasec1", 12);		/* [21] datasec datasec1 */
+	btf__add_datasec_var_info(btf, 15, 0, 4);
+	btf__add_datasec_var_info(btf, 16, 4, 8);
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int64' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[3] PTR '(anon)' type_id=1",
+		"[4] ARRAY '(anon)' type_id=2 index_type_id=1 nr_elems=3",
+		"[5] STRUCT 's1' size=12 vlen=2\n"
+		"\t'f1' type_id=3 bits_offset=0\n"
+		"\t'f2' type_id=1 bits_offset=0",
+		"[6] UNION 'u1' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=5 bits_offset=0",
+		"[7] ENUM 'e1' encoding=UNSIGNED size=4 vlen=2\n"
+		"\t'v1' val=1\n"
+		"\t'v2' val=2",
+		"[8] FWD 'fw1' fwd_kind=struct",
+		"[9] TYPEDEF 't' type_id=1",
+		"[10] VOLATILE '(anon)' type_id=2",
+		"[11] CONST '(anon)' type_id=1",
+		"[12] RESTRICT '(anon)' type_id=3",
+		"[13] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'p1' type_id=1\n"
+		"\t'p2' type_id=3",
+		"[14] FUNC 'func' type_id=13 linkage=global",
+		"[15] VAR 'var1' type_id=1, linkage=static",
+		"[16] VAR 'var2' type_id=3, linkage=static",
+		"[17] FLOAT 'float' size=4",
+		"[18] DECL_TAG 'decltag' type_id=11 component_idx=-1",
+		"[19] TYPE_TAG 'typetag' type_id=6",
+		"[20] ENUM64 'e64' encoding=SIGNED size=8 vlen=3\n"
+		"\t'eval1' val=1000\n"
+		"\t'eval2' val=2000\n"
+		"\t'eval3' val=3000",
+		"[21] DATASEC 'datasec1' size=12 vlen=2\n"
+		"\ttype_id=15 offset=0 size=4\n"
+		"\ttype_id=16 offset=4 size=8");
+
+	for (id = 1; id < btf__type_cnt(btf); id++) {
+		struct btf_type *t = btf_type_by_id(btf, id);
+		struct btf_field_iter it_strs, it_ids;
+		int str_idx = 0, id_idx = 0;
+		__u32 *next_str, *next_id;
+
+		if (!ASSERT_OK_PTR(t, "btf_type_by_id"))
+			break;
+		if (!ASSERT_OK(btf_field_iter_init(&it_strs, t, BTF_FIELD_ITER_STRS),
+			       "iter_init_strs"))
+			break;
+		if (!ASSERT_OK(btf_field_iter_init(&it_ids, t, BTF_FIELD_ITER_IDS),
+			       "iter_init_ids"))
+			break;
+		while ((next_str = btf_field_iter_next(&it_strs))) {
+			const char *str = btf__str_by_offset(btf, *next_str);
+
+			if (!ASSERT_OK(strcmp(fields[id].strs[str_idx], str), "field_str_match"))
+				break;
+			str_idx++;
+		}
+		/* ensure no more strings are expected */
+		ASSERT_EQ(fields[id].strs[str_idx], NULL, "field_str_cnt");
+
+		while ((next_id = btf_field_iter_next(&it_ids))) {
+			if (!ASSERT_EQ(*next_id, fields[id].ids[id_idx], "field_id_match"))
+				break;
+			id_idx++;
+		}
+		/* ensure no more ids are expected */
+		ASSERT_EQ(fields[id].ids[id_idx], 0, "field_id_cnt");
+	}
+	btf__free(btf);
+}
-- 
2.31.1



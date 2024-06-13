Return-Path: <bpf+bounces-32055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337B490694E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EF5B24D43
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF08C1411CE;
	Thu, 13 Jun 2024 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gTlbayLe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E613F449
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272261; cv=none; b=K0SwsKBHPW3zB+t6FP6YOftah9wNRII7+/P73iWi+1OKhltqKa9ei+blwgzYV8woFpsAnctecy+6aI77wkUsFH9m2kouR2+LlPdWBhEWa8PWITbkQKB1O7nhD4w7Hr1YmqmwuW0aAlAJNFPlseLtBg1VwingZnxhAJBKVNTvqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272261; c=relaxed/simple;
	bh=xKH++J+rB9qYgQnhsujo9LpI+bxa3xjt1QbVlg6clEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iAGgHn/wlq7V1mvFxvIlY0UKQWuzyYgbgRDWCHtJMkKCVRwiNKhR9sM29M35dt+CigxFPLy81+MOdiZgX9SM1+blvuHs8Iw4dULJm5MOIMGsjJgQ/7PDo4OT+/fUwKdSo0uTRr+ohCJNH787VzGGI5x2iWyT+yUKjUF1F/QJrO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gTlbayLe; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D7tUeb017810;
	Thu, 13 Jun 2024 09:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=J
	LMbu+g2Is+MJheHTIspnxwjvso/T0cseKlnbsM69Ik=; b=gTlbayLeea3bSMH3M
	ShayTSJiY2Ef0Ao1Hyql94Gca6nGHH+crBO+RLohMkzYUqXa4Ia1Ci7gvMrBVn4s
	XWjWfL3oHf27yeYmKnJ77eM+AtEA05MpGu5AUJm2S9fZh/giQwxFlOxtU1ojrJGu
	bsYn59uWtb9F1pxyygEWPfFFkpXzVsJ7b9LIsqlLrh/q3LU59xeW5mXbb44HTWRL
	ReEjcaHbkbAiUFy9mt2LC0C/4ghMKaBNKP5EBlKh+NWxlUJUOe2x98tekl7PbVVQ
	+p9aknw9viRAojuuCSZxmjfFT2Tvn2/rq/8URQlodgENSYJq5fHRKYNoo+wxSRjJ
	3zd/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj96f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45D8N8p6014326;
	Thu, 13 Jun 2024 09:50:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncewnm6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 09:50:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45D9oJpw005489;
	Thu, 13 Jun 2024 09:50:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-187.vpn.oracle.com [10.175.212.187])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yncewnkqw-5;
	Thu, 13 Jun 2024 09:50:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 bpf-next 4/9] selftests/bpf: extend distilled BTF tests to cover BTF relocation
Date: Thu, 13 Jun 2024 10:50:09 +0100
Message-Id: <20240613095014.357981-5-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: VO4rD7mG1J5E_Z49mlabqycd89yoSI07
X-Proofpoint-ORIG-GUID: VO4rD7mG1J5E_Z49mlabqycd89yoSI07

Ensure relocated BTF looks as expected; in this case identical to
original split BTF, with a few duplicate anonymous types added to
split BTF by the relocation process.  Also add relocation tests
for edge cases like missing type in base BTF and multiple types
of the same name.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 278 ++++++++++++++++++
 1 file changed, 278 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index 5c3a38747962..bfbe795823a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -217,7 +217,277 @@ static void test_distilled_base(void)
 		"\t'p1' type_id=1",
 		"[25] ARRAY '(anon)' type_id=1 index_type_id=1 nr_elems=3");
 
+	if (!ASSERT_EQ(btf__relocate(btf4, btf1), 0, "relocate_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf4,
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
+		"[19] PTR '(anon)' type_id=30",
+		"[20] CONST '(anon)' type_id=6",
+		"[21] RESTRICT '(anon)' type_id=31",
+		"[22] VOLATILE '(anon)' type_id=8",
+		"[23] TYPEDEF 'et' type_id=32",
+		"[24] CONST '(anon)' type_id=10",
+		"[25] PTR '(anon)' type_id=33",
+		"[26] STRUCT 'with_embedded' size=4 vlen=1\n"
+		"\t'f1' type_id=13 bits_offset=0",
+		"[27] FUNC 'fn' type_id=34 linkage=static",
+		"[28] TYPEDEF 'arraytype' type_id=35",
+		"[29] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=16",
+		/* below here are (duplicate) anon base types added by distill
+		 * process to split BTF.
+		 */
+		"[30] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=3 bits_offset=32",
+		"[31] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[32] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[33] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[34] FUNC_PROTO '(anon)' ret_type_id=1 vlen=1\n"
+		"\t'p1' type_id=1",
+		"[35] ARRAY '(anon)' type_id=1 index_type_id=1 nr_elems=3");
+
+cleanup:
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
+/* ensure we can cope with multiple types with the same name in
+ * distilled base BTF.  In this case because sizes are different,
+ * we can still disambiguate them.
+ */
+static void test_distilled_base_multi(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	btf__add_int(btf1, "int", 8, BTF_INT_SIGNED);	/* [2] int */
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED");
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+	btf__add_ptr(btf2, 1);
+	btf__add_const(btf2, 2);
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[3] PTR '(anon)' type_id=1",
+		"[4] CONST '(anon)' type_id=2");
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
+	    !ASSERT_EQ(3, btf__type_cnt(btf3), "distilled_base_type_cnt"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		btf3,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED");
+	if (!ASSERT_EQ(btf__relocate(btf4, btf1), 0, "relocate_split"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf4,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[3] PTR '(anon)' type_id=1",
+		"[4] CONST '(anon)' type_id=2");
+
+cleanup:
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
+/* If a needed type is not present in the base BTF we wish to relocate
+ * with, btf__relocate() should error our.
+ */
+static void test_distilled_base_missing_err(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL, *btf5 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	btf__add_int(btf1, "int", 8, BTF_INT_SIGNED);   /* [2] int */
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED");
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+	btf__add_ptr(btf2, 1);
+	btf__add_const(btf2, 2);
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED",
+		"[3] PTR '(anon)' type_id=1",
+		"[4] CONST '(anon)' type_id=2");
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
+	    !ASSERT_EQ(3, btf__type_cnt(btf3), "distilled_base_type_cnt"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		btf3,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED");
+	btf5 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
+		return;
+	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	VALIDATE_RAW_BTF(
+		btf5,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+	ASSERT_EQ(btf__relocate(btf4, btf5), -EINVAL, "relocate_split");
+
+cleanup:
+	btf__free(btf5);
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
+/* With 2 types of same size in distilled base BTF, relocation should
+ * fail as we have no means to choose between them.
+ */
+static void test_distilled_base_multi_err(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);   /* [2] int */
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+	btf__add_ptr(btf2, 1);
+	btf__add_const(btf2, 2);
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[3] PTR '(anon)' type_id=1",
+		"[4] CONST '(anon)' type_id=2");
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
+	    !ASSERT_EQ(3, btf__type_cnt(btf3), "distilled_base_type_cnt"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		btf3,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+	ASSERT_EQ(btf__relocate(btf4, btf1), -EINVAL, "relocate_split");
+cleanup:
+	btf__free(btf4);
+	btf__free(btf3);
+	btf__free(btf2);
+	btf__free(btf1);
+}
+
+/* With 2 types of same size in base BTF, relocation should
+ * fail as we have no means to choose between them.
+ */
+static void test_distilled_base_multi_err2(void)
+{
+	struct btf *btf1 = NULL, *btf2 = NULL, *btf3 = NULL, *btf4 = NULL, *btf5 = NULL;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "empty_main_btf"))
+		return;
+	btf__add_int(btf1, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	VALIDATE_RAW_BTF(
+		btf1,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+	btf2 = btf__new_empty_split(btf1);
+	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
+		goto cleanup;
+	btf__add_ptr(btf2, 1);
+	VALIDATE_RAW_BTF(
+		btf2,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1");
+	if (!ASSERT_EQ(0, btf__distill_base(btf2, &btf3, &btf4),
+		       "distilled_base") ||
+	    !ASSERT_OK_PTR(btf3, "distilled_base") ||
+	    !ASSERT_OK_PTR(btf4, "distilled_split") ||
+	    !ASSERT_EQ(2, btf__type_cnt(btf3), "distilled_base_type_cnt"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		btf3,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+	btf5 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf5, "empty_reloc_btf"))
+		return;
+	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [1] int */
+	btf__add_int(btf5, "int", 4, BTF_INT_SIGNED);   /* [2] int */
+	VALIDATE_RAW_BTF(
+		btf5,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED");
+	ASSERT_EQ(btf__relocate(btf4, btf5), -EINVAL, "relocate_split");
 cleanup:
+	btf__free(btf5);
 	btf__free(btf4);
 	btf__free(btf3);
 	btf__free(btf2);
@@ -269,6 +539,14 @@ void test_btf_distill(void)
 {
 	if (test__start_subtest("distilled_base"))
 		test_distilled_base();
+	if (test__start_subtest("distilled_base_multi"))
+		test_distilled_base_multi();
+	if (test__start_subtest("distilled_base_missing_err"))
+		test_distilled_base_missing_err();
+	if (test__start_subtest("distilled_base_multi_err"))
+		test_distilled_base_multi_err();
+	if (test__start_subtest("distilled_base_multi_err2"))
+		test_distilled_base_multi_err2();
 	if (test__start_subtest("distilled_base_vmlinux"))
 		test_distilled_base_vmlinux();
 }
-- 
2.31.1



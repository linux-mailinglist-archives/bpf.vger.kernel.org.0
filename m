Return-Path: <bpf+bounces-58493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EA4ABC513
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79994189C944
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820828852A;
	Mon, 19 May 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WmupQ4Ix"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08527B4E2
	for <bpf@vger.kernel.org>; Mon, 19 May 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674015; cv=none; b=g90pF+MjWdRUbb/sgmlPtC3DIULotS/lFGzKaBw1UGbmO4t9foqhDsYI33NBZl3pyPXiPwyM2c530vW6DNFiqn1Eh72xKCDkAT4+/rgLFACRqEOB/16TAnUe+Dm62VBaSUkCa6b+LMWBCUONC6jBNIxIclaUx44SDcJK7wC9jCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674015; c=relaxed/simple;
	bh=p4zjZcyTBjEQw+wmwQGmtrnQP110Bdios6ltYTHav98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKMtozh3W5D3eNmg5KkZe/m4c07HLwd+wdv+fz7JInoQ0bUxNgOWBXIpZQySsVh63mdG6FFUQEme8h++Du6u+3X6XhnRA6ARwOImq7gn1GkLclCXB8gH42Tv5yOuOX862yEhKb93Iwe4sCVF2uIYgCctwcYNwg5tfZM1TaGUQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WmupQ4Ix; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMq3S028829;
	Mon, 19 May 2025 16:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=F45b+
	qWjYPWb28J5lR8FBrMYDQRWHfslkF5cJxl0FMg=; b=WmupQ4IxXNNntAh027lzA
	YEOvTaIlQib9StidKqZZRaWaVKBieNokNtSNKyV7VaiEFjzdYXfIqbVLvBlck/1p
	N0c9B/j8LndlVKkmMd6HyfZ5N8FvZcfE+pYIdr4krTw54QbhOtAR8904gYzaaG98
	P3Z8liQRBch9x3l3WvBwWe3KirInbmPQph8TanTbEedUITa1Lv7ZB20iY2cmNiQp
	2Ia0WRwxY/y81IljdOP7MNI56CWd2I73tCmMjAQJDHBhahRpIwrtSMQc0NGLSHtg
	7vHGhf2D2y/U5qvumYl37gMcQJnkIa48gdl540eBmKUXzJqlHqjNBg99d1L+aB3m
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcufdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 16:59:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFIR3W002297;
	Mon, 19 May 2025 16:59:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6q2mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 16:59:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54JGu0Jp010939;
	Mon, 19 May 2025 16:59:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-48-230.vpn.oracle.com [10.154.48.230])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46pgw6q2f5-3;
	Mon, 19 May 2025 16:59:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, ttreyer@meta.com, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test multi-split BTF
Date: Mon, 19 May 2025 17:59:35 +0100
Message-ID: <20250519165935.261614-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250519165935.261614-1-alan.maguire@oracle.com>
References: <20250519165935.261614-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190158
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b6384 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=oa78NvRptp_1-OHcjvsA:9
X-Proofpoint-GUID: R6pbqsXy4KL6ZE-ABT9Csj3yBGqnudGm
X-Proofpoint-ORIG-GUID: R6pbqsXy4KL6ZE-ABT9Csj3yBGqnudGm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1OCBTYWx0ZWRfX9IIhQ1NlGhfX fV3+sbtqZLQb1bqpgc8xiuW9xNRqVb4/h0c7/X8jd3urEsdNS+5fZZGilLi8Kq6e+kKWGycdM3K 79BAbQuHTYlbvZkPoOHhSAg9ici4jQaHORAJU2xeEs0WMu5KFtlKZ2ovbql8p/arfcfdGfkkDjV
 BKv7Irg3MAG+h4lFIo5jxvZWqQQXlhPxlgU3hmPUkU7uzS8Cx1pLEebkFeUl52yJ7ZbZ3mjMrS1 XAAWjXjbKrQVNwYsBmxXk00Xe6J0jG1nt3yIsM1iVToYiwqRzsgzsIRbsRRvaEgygzBuKuO+4+M Vr9Rhp3BJ6Sg4KkKG8Nlwps0oOzex569Mu/PUl6VfsHqcreaZfjJpVWBlGUqfvpCoDTF3BcVeqs
 Jtvhe5uTKsRtScg8envmV6IpJJBrU+LzkOdoh+N5eqEPbuU1DAoithiakr+8uQ/dkUzppJ7K

Extend split BTF test to cover case where we create split BTF on top of
existing split BTF and add info to it; ensure that such BTF can be
created and handled by searching within it, dumping/comparing to expected.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_split.c      | 58 +++++++++++++++++--
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
index eef1158676ed..3696fb9a05ed 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
@@ -12,10 +12,11 @@ static void btf_dump_printf(void *ctx, const char *fmt, va_list args)
 	vfprintf(ctx, fmt, args);
 }
 
-void test_btf_split() {
+static void __test_btf_split(bool multi)
+{
 	struct btf_dump *d = NULL;
 	const struct btf_type *t;
-	struct btf *btf1, *btf2;
+	struct btf *btf1, *btf2, *btf3 = NULL;
 	int str_off, i, err;
 
 	btf1 = btf__new_empty();
@@ -63,14 +64,46 @@ void test_btf_split() {
 	ASSERT_EQ(btf_vlen(t), 3, "split_struct_vlen");
 	ASSERT_STREQ(btf__str_by_offset(btf2, t->name_off), "s2", "split_struct_name");
 
+	if (multi) {
+		btf3 = btf__new_empty_split(btf2);
+		if (!ASSERT_OK_PTR(btf3, "multi_split_btf"))
+			goto cleanup;
+	} else {
+		btf3 = btf2;
+	}
+
+	btf__add_union(btf3, "u1", 16);			/* [5] union u1 {	*/
+	btf__add_field(btf3, "f1", 4, 0, 0);		/*	struct s2 f1;	*/
+	btf__add_field(btf3, "uf2", 1, 0, 0);		/*	int f2;		*/
+							/* } */
+
+	if (multi) {
+		t = btf__type_by_id(btf2, 5);
+		ASSERT_NULL(t, "multisplit_type_in_first_split");
+	}
+
+	t = btf__type_by_id(btf3, 5);
+	if (!ASSERT_OK_PTR(t, "split_union_type"))
+		goto cleanup;
+	ASSERT_EQ(btf_is_union(t), true, "split_union_kind");
+	ASSERT_EQ(btf_vlen(t), 2, "split_union_vlen");
+	ASSERT_STREQ(btf__str_by_offset(btf3, t->name_off), "u1", "split_union_name");
+	ASSERT_EQ(btf__type_cnt(btf3), 6, "split_type_cnt");
+
+	t = btf__type_by_id(btf3, 1);
+	if (!ASSERT_OK_PTR(t, "split_base_type"))
+		goto cleanup;
+	ASSERT_EQ(btf_is_int(t), true, "split_base_int");
+	ASSERT_STREQ(btf__str_by_offset(btf3, t->name_off), "int", "split_base_type_name");
+
 	/* BTF-to-C dump of split BTF */
 	dump_buf_file = open_memstream(&dump_buf, &dump_buf_sz);
 	if (!ASSERT_OK_PTR(dump_buf_file, "dump_memstream"))
 		return;
-	d = btf_dump__new(btf2, btf_dump_printf, dump_buf_file, NULL);
+	d = btf_dump__new(btf3, btf_dump_printf, dump_buf_file, NULL);
 	if (!ASSERT_OK_PTR(d, "btf_dump__new"))
 		goto cleanup;
-	for (i = 1; i < btf__type_cnt(btf2); i++) {
+	for (i = 1; i < btf__type_cnt(btf3); i++) {
 		err = btf_dump__dump_type(d, i);
 		ASSERT_OK(err, "dump_type_ok");
 	}
@@ -79,12 +112,15 @@ void test_btf_split() {
 	ASSERT_STREQ(dump_buf,
 "struct s1 {\n"
 "	int f1;\n"
-"};\n"
-"\n"
+"};\n\n"
 "struct s2 {\n"
 "	struct s1 f1;\n"
 "	int f2;\n"
 "	int *f3;\n"
+"};\n\n"
+"union u1 {\n"
+"	struct s2 f1;\n"
+"	int uf2;\n"
 "};\n\n", "c_dump");
 
 cleanup:
@@ -94,4 +130,14 @@ void test_btf_split() {
 	btf_dump__free(d);
 	btf__free(btf1);
 	btf__free(btf2);
+	if (btf2 != btf3)
+		btf__free(btf3);
+}
+
+void test_btf_split(void)
+{
+	if (test__start_subtest("single_split"))
+		__test_btf_split(false);
+	if (test__start_subtest("multi_split"))
+		__test_btf_split(true);
 }
-- 
2.39.3



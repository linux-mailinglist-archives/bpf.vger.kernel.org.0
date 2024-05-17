Return-Path: <bpf+bounces-29938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885148C84BB
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F98B2304C
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F6381C7;
	Fri, 17 May 2024 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KxAplLWk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA0364BE
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941444; cv=none; b=sRGlANZc++xrCtWmP0VsqFcDaGFPLdo6UAH5ymOevQybwHg3O6drBuG+2P3g2BxkuyN5pAezJ99QzeGcdR8bOpQ1ZnpNSCSDIzlidRaF9ek+AdkmGtqDLO7mM0zh2f0XNUjfRf9hshg/ixffI9SXjpsth9SZfsTw5LZd3OnAW8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941444; c=relaxed/simple;
	bh=DiS6lwhbi6MtEiLrvEax32w8r/IwjnZcNvxoRJTS8l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxzmUM6zGsbg2RQMcUEmvh5LEEoFoCLE9bb+k6stvBOJ0pxI/oHBMZERiwwxRftBSqo6Un2OvM2EAZl46+9vWiVEMZk36KhmLTMBE5hBL5j87RuZLESk0VADG9VlaOfzizt4L4C8JWmxV6Ln6DProvbHB5ZBsjVKGcUO6ZxYkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KxAplLWk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44H9doDN026934;
	Fri, 17 May 2024 10:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Xrqxmo/cOr7wDIK2H4sXnWi4svfwfASWxHqpe9g3XUk=;
 b=KxAplLWk3N7doxzyTkNsFAMFqpA4xE31au/NjdUPREDRRrMzZ7baYhSaSZ3qxbfCMXIF
 BFen52MutblSfzQaXGMy6uskt60smqlGthk89mtrUtTqwLQLd5+hJ1/7FuEem2QIrfeN
 P4EE0W+YU7i+u8S4a4ogiIx9o2r7kYToQSH1+GyzjsOKCQc/K7lG4zvfWXCf1gWVVMmz
 URi0XEv1huFkjdtqRt031TuLwZkCbHJ0j/++YP+lS9uccTtVN2p3haNN6ooBV6hil1jB
 wwPyjhbEL4WANUSf9t2cYq7hmoUEag09cKYbxSj2ng6A9FqaxIWeLOexCdvuyEL8/KPq Jg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y4c8r75vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HAAoBF000425;
	Fri, 17 May 2024 10:23:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y4fsuqsa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 10:23:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HAMqFo036134;
	Fri, 17 May 2024 10:23:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-196-17.vpn.oracle.com [10.175.196.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y4fsuqrr2-9;
	Fri, 17 May 2024 10:23:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 08/11] selftests/bpf: extend distilled BTF tests to cover BTF relocation
Date: Fri, 17 May 2024 11:22:43 +0100
Message-Id: <20240517102246.4070184-9-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: Hx6-gf5UlTYNw6gOPDNg6aTI3mtjCztL
X-Proofpoint-GUID: Hx6-gf5UlTYNw6gOPDNg6aTI3mtjCztL

Ensure relocated BTF looks as expected; in this case identical to
original split BTF, with a few duplicate anonymous types added to
split BTF by the relocation process.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_distill.c    | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
index 4ab522df041c..442627719edc 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
@@ -218,6 +218,73 @@ static void test_distilled_base(void)
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
 cleanup:
 	btf__free(btf4);
 	btf__free(btf3);
-- 
2.31.1



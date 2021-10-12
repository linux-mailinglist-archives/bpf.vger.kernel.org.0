Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB665429BA6
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 04:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhJLCxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 22:53:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231672AbhJLCxh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 22:53:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C2g7ur014649;
        Mon, 11 Oct 2021 22:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xYqeXchHEW1P/AnDNf/4ITuRTVdjA655bkxy8OJILVE=;
 b=d7PY52UN8WwpWf2dlDlC9aBB4Or/Mg+plEFVaAQOz7Qu3vq6PtSwJgmzbLxZku+2f4z5
 3nl/4OEPGzaZUjooQu6B1ZXjMoDNWKvEZgAcna8xU8RJwSHdgrK6Wtge/wWdmn4S7Nuu
 CELc+akIwk0Bw6ZE7J67nretug9qzhNlTnb4TI/Sy4O9vw+6v/ZJB0EXTKvMUT1I5I7F
 ie/FrpsW0CeC0I1nJFcqjniYswMIKT6MxdDq2ztnaJeZRBa4Q+9yikA7tTPyI24NcKTp
 EH4AyHt4x/q7fxu8SoFHpy4V5u3K/p3XBxRWDkiPdkfRsKTYTM8CnIv7v1fs5ynXiQ2c Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bn1t9g3vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:51:24 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19C2pNAo017132;
        Mon, 11 Oct 2021 22:51:23 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bn1t9g3tu-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 22:51:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19C2BLhT009794;
        Tue, 12 Oct 2021 02:32:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9be7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 02:32:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19C2WKfS18678204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 02:32:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA44811C054;
        Tue, 12 Oct 2021 02:32:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A5F111C050;
        Tue, 12 Oct 2021 02:32:20 +0000 (GMT)
Received: from vm.lan (unknown [9.145.45.184])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 02:32:20 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Use cpu_number only on arches that have it
Date:   Tue, 12 Oct 2021 04:32:16 +0200
Message-Id: <20211012023218.399568-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012023218.399568-1-iii@linux.ibm.com>
References: <20211012023218.399568-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vTuccsjHYX8zwnplm3xVYGEn_97kD7Sa
X-Proofpoint-GUID: DKaW5zZTMfq-d_Vx87WsO89eUcSxdrtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_11,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120008
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cpu_number exists only on Intel and aarch64, so skip the test involing
it on other arches. An alternative would be to replace it with an
exported non-ifdefed primitive-typed percpu variable from the common
code, but there appears to be none.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 87f9df653e4e..12f457b6786d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -778,8 +778,10 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
 static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 				   char *str)
 {
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
+#endif
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_profile_flip", int, BTF_F_COMPACT,
 			  "static int cpu_profile_flip = (int)2", 2);
 }
-- 
2.31.1


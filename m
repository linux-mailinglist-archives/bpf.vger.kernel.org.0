Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B729426B8D7
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 02:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIPAvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 20:51:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726357AbgIOLkK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Sep 2020 07:40:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FBV9Nx135772;
        Tue, 15 Sep 2020 07:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pFwT6MGucH8P0i7tbOUSoTpi/YpLa/ghGvGJO5yqF2M=;
 b=HdMTR3ehhWeKoYZmF0V3FsRhwQwjgbM4AhrpCvWZrPthhkFNVujHKGE7nQR4F2dwvn51
 ZZLH8R616Y02Sn7RBObs3hnm+/z3i6tcT8BVJcLf+ZzkWbCbRbbc9hDg9asjLOsOMmQA
 MA+IU6MZxpBl3M01KwBqqx9PO0qS3KCML0yP9B4tRNMrxV4dmrfD/vTmXR75r4atAcOK
 5dD0qkjzydrXgvTPM+hWZVIEwA7mTkK80hR4W61WxOgNjRpjntZwsI5yqE4PCtNqu+xM
 HRULdKnajd2HTWTjEFFXM2b31DdX9VfVZ4J6qK6GrCb5K942Ymx3nnuPwr1TYLHmGO1K 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33juctjt26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 07:39:35 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FBWgpO140029;
        Tue, 15 Sep 2020 07:39:34 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33juctjt1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 07:39:34 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FBb7GM017326;
        Tue, 15 Sep 2020 11:39:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 33hb1j2jxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 11:39:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FBdU3s26345786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 11:39:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1113EA4059;
        Tue, 15 Sep 2020 11:39:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 985C5A4053;
        Tue, 15 Sep 2020 11:39:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.7.183])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Sep 2020 11:39:29 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix endianness issue in test_sockopt_sk
Date:   Tue, 15 Sep 2020 13:39:28 +0200
Message-Id: <20200915113928.3768496-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_08:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150097
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

getsetsockopt() calls getsockopt() with optlen == 1, but then checks
the resulting int. It is ok on little endian, but not on big endian.

Fix by checking char instead.

Fixes: 8a027dc0 ("selftests/bpf: add sockopt test that exercises sk helpers")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1->v2: Also pass a single byte to log_err.

 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 5f54c6aec7f0..b25c9c45c148 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -45,9 +45,9 @@ static int getsetsockopt(void)
 		goto err;
 	}
 
-	if (*(int *)big_buf != 0x08) {
+	if (*big_buf != 0x08) {
 		log_err("Unexpected getsockopt(IP_TOS) optval 0x%x != 0x08",
-			*(int *)big_buf);
+			(int)*big_buf);
 		goto err;
 	}
 
-- 
2.25.4


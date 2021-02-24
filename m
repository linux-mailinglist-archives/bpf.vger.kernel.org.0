Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C62432479D
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhBXXqv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:46:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232929AbhBXXqt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:46:49 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ONWodA040446;
        Wed, 24 Feb 2021 18:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ozt/lwUKcnsTuX5mLpJbdZlcmTxAjkcDNP+uVlMHa7I=;
 b=kN3iZyt3ZZOOGAxQJH1zcLT6FRXSBSdC2TfWKYvBvlzT6NHpo/IHRBju4Na0l57HoQc2
 RLaI5MmqlUiw5KqbVP2YAHcWOJMiyfHw77/xUhRBmlX58FLctbgHPBN1AM82mcfl5Drj
 CENRkGrqnZYt1dz86nJD20velp1jFZO+YwwivvushbBO4gwYsGo6yOihfbjNezQGN6EW
 U5Z1EGAskgc5Hb48pDI6guaPf52O75TPJ30xArQKJ88zCyzsgjD/LsgMDNUH5x9l1/J6
 1WSHu2mJorXGE4K0X1JUUEIyxUitmz4cMLz1Fo76RCW7GZzf7Np3J+L29ekqC1r68cPz lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wgu6rve2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:56 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ONXQQZ041362;
        Wed, 24 Feb 2021 18:45:56 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wgu6rvcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:56 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ONiRDU029925;
        Wed, 24 Feb 2021 23:45:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 36tt28a2rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:45:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ONjoYQ22151586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:45:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BAF942047;
        Wed, 24 Feb 2021 23:45:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4D4E42041;
        Wed, 24 Feb 2021 23:45:49 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:45:49 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v6 bpf-next 5/9] selftests/bpf: Use the 25th bit in the "invalid BTF_INFO" test
Date:   Thu, 25 Feb 2021 00:45:31 +0100
Message-Id: <20210224234535.106970-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224234535.106970-1-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240184
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bit being checked by this test is no longer reserved after
introducing BTF_KIND_FLOAT, so use the next one instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 6a7ee7420701..c29406736138 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -1903,7 +1903,7 @@ static struct btf_raw_test raw_tests[] = {
 	.raw_types = {
 		/* int */				/* [1] */
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),
-		BTF_TYPE_ENC(0, 0x10000000, 4),
+		BTF_TYPE_ENC(0, 0x20000000, 4),
 		BTF_END_RAW,
 	},
 	.str_sec = "",
-- 
2.29.2


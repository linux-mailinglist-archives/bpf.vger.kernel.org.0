Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233E5263AFD
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 04:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgIJB6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:58:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbgIJBfW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:35:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089N1uLR025476;
        Wed, 9 Sep 2020 19:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ppmp+LdKfRhGSOfxacmlYmZEN1CSIgx406jU2hr8aDY=;
 b=TjYSNa89poNFn/QEK9CQsIcvYMkxWbpf+Fxvmgn7uf0Dl7iyjtox/LGRov7RBDmjVC5N
 FlK8nVHrlCaZH4U6E2b8GAcn+SlNJqIKvcRG6bnd2dENlf22uUAVzVgFthv/BgWPbUd0
 QEC5AKt6tUD9c100CjPVEumTABLVw521eLjfq9B7JyKDxyIOVE4M6rgOn/PEEL701WKr
 1hDrhApzTBYV+GCzKgEnZRsmhsLjDc/mtUizBXixFpPQatURmL8tCGdKaTmW49Tl+oxF
 PJja3WisfrdVEZw2lDtE6CsuwwBdrq4XLHeXzSgq7gh9ZMs0t91w2/lNAQwTDtfkTlUd nw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f8310tt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:25:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NIn4I031119;
        Wed, 9 Sep 2020 23:25:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 33cm5hjnyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:25:02 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NOx8724117540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:24:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F9C311C058;
        Wed,  9 Sep 2020 23:24:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A99111C054;
        Wed,  9 Sep 2020 23:24:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:24:59 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Fix endianness issue in test_sockopt_sk
Date:   Thu, 10 Sep 2020 01:24:41 +0200
Message-Id: <20200909232443.3099637-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909232443.3099637-1-iii@linux.ibm.com>
References: <20200909232443.3099637-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090197
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
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 5f54c6aec7f0..ba4da50987d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -45,7 +45,7 @@ static int getsetsockopt(void)
 		goto err;
 	}
 
-	if (*(int *)big_buf != 0x08) {
+	if (*big_buf != 0x08) {
 		log_err("Unexpected getsockopt(IP_TOS) optval 0x%x != 0x08",
 			*(int *)big_buf);
 		goto err;
-- 
2.25.4


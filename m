Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7491C26B8D9
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 02:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgIPAvi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 20:51:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34544 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgIOLix (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Sep 2020 07:38:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FBWDMD139726;
        Tue, 15 Sep 2020 07:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=a+WFPgPq1BUP9A9vHwnviv5oV+m8Unu0tqCjn9jAyv0=;
 b=r+/xXiF3LEMfLKs7aDRVmXNUcEduqLo+FpvqXn468BAXr9mxOkhmcexMy4h/oFxNg+DN
 R3YYPSjNfViLep9IPFA8GBUC3FG02JWvhZkF37qkoZ4P8Q/ibGG63CxJMkcVn0jh64w1
 LtVgcko5jY1AsL3hiSL6E/jhijYMd7K+UNegkas+WPvYhzcEJYngfCik369/RwqbtW8k
 WNNm8cyEZuBEujbGyjuFePk93maDG3yBtEIPpo9dcHlGxbu6S2N9LfFR97NUCAoIZL8A
 pIoNQ8hGBvLdy3/RnOwuOXGtMEDiM8bT5un9VaoNjxDKuU/NbXxNi91cr+aWEsjcP6WJ 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33jvsb86mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 07:38:27 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FBWoRU141282;
        Tue, 15 Sep 2020 07:38:27 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33jvsb86kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 07:38:27 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FBb9Ql017329;
        Tue, 15 Sep 2020 11:38:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33hb1j2jwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 11:38:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08FBcMhd7274776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 11:38:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02327A4040;
        Tue, 15 Sep 2020 11:38:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87D77A404D;
        Tue, 15 Sep 2020 11:38:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.7.183])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Sep 2020 11:38:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix endianness issue in sk_assign
Date:   Tue, 15 Sep 2020 13:38:15 +0200
Message-Id: <20200915113815.3768217-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_08:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150097
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

server_map's value size is 8, but the test tries to put an int there.
This sort of works on x86 (unless followed by non-0), but hard fails on
s390.

Fix by using __s64 instead of int.

Fixes: 2d7824ffd25c ("selftests: bpf: Add test for sk_assign")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1->v2: Use __s64.

tools/testing/selftests/bpf/prog_tests/sk_assign.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index a49a26f95a8b..3a469099f30d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -265,7 +265,7 @@ void test_sk_assign(void)
 		TEST("ipv6 udp port redir", AF_INET6, SOCK_DGRAM, false),
 		TEST("ipv6 udp addr redir", AF_INET6, SOCK_DGRAM, true),
 	};
-	int server = -1;
+	__s64 server = -1;
 	int server_map;
 	int self_net;
 	int i;
-- 
2.25.4


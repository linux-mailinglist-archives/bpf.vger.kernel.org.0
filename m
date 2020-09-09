Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE62639A1
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 03:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgIJB7E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:59:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56392 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729988AbgIJBrU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:47:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089N2A12021186;
        Wed, 9 Sep 2020 19:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5Ett6H8Obtx9/GzXTM58LW/1sj8qeGjV1ztDgScsHQ0=;
 b=iWflUAL5BS/D7/IRdlOcxLt1o27VMLvK5XLOBa+x5qXiq17D2v8DRqe+IKItDD/0S+Ev
 Sxx5WU5X/ucLqN2BiFVKZYXbcebXniYqxuCbCAz51h2d34lJSBhIyDn8GmIdtK38+XSA
 08haZ2ChyKbXoq+Kfl7V0Xuk8w78YFCoGUL0W27SkROxxmzmMpVGG0gePrJKfr/vQGze
 q48u2bIAsrUTwjGwdTNxg0QV9aZ/Gn+6RCWALVySDYejR8DbWZhpvkE7oQKmylnVuiUk
 ZmEzHzFrh6IgqD8OIxGjdyNVBbggQDZqfcOW8gdzc5Vb8GfzSeslFHQV84zwv3w6lBiX QA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f7v5938v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 19:25:49 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089NIdXq007980;
        Wed, 9 Sep 2020 23:25:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 33e5gms5gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 23:25:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089NPjtk22610418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 23:25:45 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E743011C04A;
        Wed,  9 Sep 2020 23:25:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E3E311C04C;
        Wed,  9 Sep 2020 23:25:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.5.224])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 23:25:44 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Fix endianness issue in sk_assign
Date:   Thu, 10 Sep 2020 01:24:43 +0200
Message-Id: <20200909232443.3099637-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200909232443.3099637-1-iii@linux.ibm.com>
References: <20200909232443.3099637-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090197
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

server_map's value size is 8, but the test tries to put an int there.
This sort of works on x86 (unless followed by non-0), but hard fails on
s390.

Fix by using long instead of int.

Fixes: 2d7824ffd25c ("selftests: bpf: Add test for sk_assign")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/sk_assign.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index a49a26f95a8b..402d0da8e05a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -265,7 +265,7 @@ void test_sk_assign(void)
 		TEST("ipv6 udp port redir", AF_INET6, SOCK_DGRAM, false),
 		TEST("ipv6 udp addr redir", AF_INET6, SOCK_DGRAM, true),
 	};
-	int server = -1;
+	long server = -1;
 	int server_map;
 	int self_net;
 	int i;
-- 
2.25.4


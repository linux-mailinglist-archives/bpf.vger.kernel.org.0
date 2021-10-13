Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2037B42C5E1
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhJMQLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 12:11:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7606 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhJMQLd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 12:11:33 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DENj7d008772;
        Wed, 13 Oct 2021 12:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xYqeXchHEW1P/AnDNf/4ITuRTVdjA655bkxy8OJILVE=;
 b=BPWgYoG81/DJFjBEHyNb7DEKc5t/evahFT0LAxsfG0TQklepFuvcJusQY+oblphmyen1
 YrUBPxstodInUedfvLvSe4NAradhHClO0rqYKRTWY0bX+eVt/Ig2CDIjMXVQWVXNZ7aX
 t+4oxuiIddSQqsMvgyxh7ujMi6rzGmCXhnI0OOLApgACekCE+djt9HU1M28fOI/mYsHX
 AqKxE1fb+tqOLPDcCTUJk71cg+jpbqlj3JbQXs4ol8Od9z96mq1EhG0/5IkBGjXL0y/G
 k/DBRhoBHdMkNcrQDmXzEOSoBtItOLBAHyG0Ke6Pmoof7oQvNf3TXB84VMlq+p3Z/1/V 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnpf3gwq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:18 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DFi9SI016216;
        Wed, 13 Oct 2021 12:09:17 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnpf3gwpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:17 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DG7XU9021046;
        Wed, 13 Oct 2021 16:09:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2qacgb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:09:15 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DG95XL5571318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 16:09:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D642AE05A;
        Wed, 13 Oct 2021 16:09:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1E30AE063;
        Wed, 13 Oct 2021 16:09:04 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 16:09:04 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: Use cpu_number only on arches that have it
Date:   Wed, 13 Oct 2021 18:08:59 +0200
Message-Id: <20211013160902.428340-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013160902.428340-1-iii@linux.ibm.com>
References: <20211013160902.428340-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mWCTIp010i-hnDgBCjkLGTjBayCSglCU
X-Proofpoint-ORIG-GUID: kE1lBMfjrXU7hKpwJ9_Yez_GGet0i-sm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130102
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44D3268AB
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBZUZB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:25:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230459AbhBZUYH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:24:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QK4U7Q175648;
        Fri, 26 Feb 2021 15:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zf6Wznv7oNyRxLhj+QBYbAt/ZctSMwTAQhSlwxEZYio=;
 b=k6rALCXhe860yjBufxyGt6gTivS3uvAoEKDje/0UX1/qIsH2isUm8extY/p6b9e32RVn
 cQIX77deC+8GnWaQsqzeeZgpeQbirLSf4tFeakB0gUJ2dQy1wSy71p4bt/qebxGv0YeO
 EqXUGPlhm/a5aFR+umWRacjF4SLwZeybIV/bFQT8ATrfAKQuyJ2sh7ueBRS+lR/gYIi2
 9+/5AHi+keMDoBlu76bvou1uUseTZHohb13TTC1EbW+qn65Td2nKaYejMGI/G7CSbxZ0
 gqbAEC7/0mwl77DPLd/uSts8MO9e1Vm/Z6NK94pwqDdCE/vrHo4Q6ehJR3t3PxRb+2gk PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y3wafw38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:11 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QK5EY0179340;
        Fri, 26 Feb 2021 15:23:10 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36y3wafw2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:10 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QKMIaS026257;
        Fri, 26 Feb 2021 20:23:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt285mnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 20:23:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QKN5tB45416936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:23:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BFD611C050;
        Fri, 26 Feb 2021 20:23:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ECBD11C058;
        Fri, 26 Feb 2021 20:23:04 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 20:23:04 +0000 (GMT)
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
Subject: [PATCH v7 bpf-next 05/10] selftests/bpf: Use the 25th bit in the "invalid BTF_INFO" test
Date:   Fri, 26 Feb 2021 21:22:51 +0100
Message-Id: <20210226202256.116518-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210226202256.116518-1-iii@linux.ibm.com>
References: <20210226202256.116518-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260148
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bit being checked by this test is no longer reserved after
introducing BTF_KIND_FLOAT, so use the next one instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Yonghong Song <yhs@fb.com>
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


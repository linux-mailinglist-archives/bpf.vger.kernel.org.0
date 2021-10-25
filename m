Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C01439745
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhJYNPE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 09:15:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233438AbhJYNPD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 09:15:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PCM1bo003311;
        Mon, 25 Oct 2021 13:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oJcj0bwXRu/VwnBMVxZyVRbcfqa4HlnBXlQ44yGofss=;
 b=QmFPPZx+n6xDypubsoyqXNYYbt5NXAFuNzYBL05x/lGaOXW8obGxHO+rm6cPZWUQ7DEo
 aaBBxcjpGhD8JiXaMebOHj1aXR+ZwmMxwLLeHQ4mCFffyW5ZFSNvgdz5TusrrF7MryHf
 OtZDMvAz6vEr1m69d4YeuBe++bNbXtXBAxFUknnFtu5pnzzbdGXgVWp6m2/sdRLwYqL0
 /wpzoy+6z8zZdDNYmLJXo2dglP0UGC3BJn0P0Ic6uhmc8TziN2fhCJxD0az/Sm8M5MP9
 GM9d2FmLfbhEudRbgSq8O9ueILO3Nspg/aaAN5Qb6rXGyRghN/WrLsztpUAtiL7Lm9zv aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bwt23nb41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:28 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19PCM0uV003189;
        Mon, 25 Oct 2021 13:12:28 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bwt23nb2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:27 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19PD845b011086;
        Mon, 25 Oct 2021 13:12:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3bva19nb4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19PDCJjr49086880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Oct 2021 13:12:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A5C4A4078;
        Mon, 25 Oct 2021 13:12:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE623A4059;
        Mon, 25 Oct 2021 13:12:18 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Oct 2021 13:12:18 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 4/5] selftests/seccomp: Use __BYTE_ORDER__
Date:   Mon, 25 Oct 2021 15:12:13 +0200
Message-Id: <20211025131214.731972-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025131214.731972-1-iii@linux.ibm.com>
References: <20211025131214.731972-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lfpetKeOR4C52mDkS4LDwIZqxEEE4WJJ
X-Proofpoint-GUID: NIzF2I9IgrPPPF1L2reVAfiIakvx92qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the compiler-defined __BYTE_ORDER__ instead of the libc-defined
__BYTE_ORDER for consistency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 1d64891e6492..d425688cf59c 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -276,12 +276,12 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
 }
 #endif
 
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]) + sizeof(__u32))
 #else
-#error "wut? Unknown __BYTE_ORDER?!"
+#error "wut? Unknown __BYTE_ORDER__?!"
 #endif
 
 #define SIBLING_EXIT_UNKILLED	0xbadbeef
-- 
2.31.1


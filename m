Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD64E439742
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhJYNPC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 09:15:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233371AbhJYNPC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 09:15:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PCM1Bf021913;
        Mon, 25 Oct 2021 13:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s1k2TD0Qrcb9vKYI8rZr0EVa6rS0hMGvSNluFaVQbSA=;
 b=JhlX8AeIxRcuEcQhu6KODfaO+JgFTHlBL8lNQUuB++w3Jld+zCghxo1YHwD4h+lmB4Fb
 4x5tjv1sI+nrVEKHLYDd+rghDdAk5VVbBZZD7ekMvgydgpEqGZI+14ywIcBSuaZfp8dR
 YsihYwR4ANpjRjy+M/6oAclkRwzvXUrv73nbxreNePTfRCWOBXb6xfMiflv2tYFQexfq
 iShQjhYyw37DB6MRKmAm6WVv3bAKsq6y8DdlzyGqKd7+Wg+OiwgH1V8Uf/Xh3qsu35xm
 PVMbnrvP6/o58VUSsaajgqGrSShSNCwtfN0UHVRyQ8tf2aNkIKisLob0/nW7tHH2Oeoc lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bwsy859wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:27 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19PCQn7X008259;
        Mon, 25 Oct 2021 13:12:27 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bwsy859v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19PD8nji023713;
        Mon, 25 Oct 2021 13:12:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3bv9njf1wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:23 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19PDCIRp5243598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Oct 2021 13:12:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F30EA4083;
        Mon, 25 Oct 2021 13:12:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 394A4A404D;
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
Subject: [PATCH bpf-next v2 3/5] samples: seccomp: use __BYTE_ORDER__
Date:   Mon, 25 Oct 2021 15:12:12 +0200
Message-Id: <20211025131214.731972-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025131214.731972-1-iii@linux.ibm.com>
References: <20211025131214.731972-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _Dd0zDBrLIYjerofQnHz9HcVUIgWM3zV
X-Proofpoint-GUID: w6-8zZPCi7nEBdKBXmZvtjov_bi-cxdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the compiler-defined __BYTE_ORDER__ instead of the libc-defined
__BYTE_ORDER for consistency.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 samples/seccomp/bpf-helper.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/seccomp/bpf-helper.h b/samples/seccomp/bpf-helper.h
index 0cc9816fe8e8..417e48a4c4df 100644
--- a/samples/seccomp/bpf-helper.h
+++ b/samples/seccomp/bpf-helper.h
@@ -62,9 +62,9 @@ void seccomp_bpf_print(struct sock_filter *filter, size_t count);
 #define EXPAND(...) __VA_ARGS__
 
 /* Ensure that we load the logically correct offset. */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define LO_ARG(idx) offsetof(struct seccomp_data, args[(idx)])
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define LO_ARG(idx) offsetof(struct seccomp_data, args[(idx)]) + sizeof(__u32)
 #else
 #error "Unknown endianness"
@@ -85,10 +85,10 @@ void seccomp_bpf_print(struct sock_filter *filter, size_t count);
 #elif __BITS_PER_LONG == 64
 
 /* Ensure that we load the logically correct offset. */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define ENDIAN(_lo, _hi) _lo, _hi
 #define HI_ARG(idx) offsetof(struct seccomp_data, args[(idx)]) + sizeof(__u32)
-#elif __BYTE_ORDER == __BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define ENDIAN(_lo, _hi) _hi, _lo
 #define HI_ARG(idx) offsetof(struct seccomp_data, args[(idx)])
 #endif
-- 
2.31.1


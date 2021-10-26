Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9940F43A993
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhJZBLS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:11:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232679AbhJZBLQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 21:11:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PLW8Al024772;
        Tue, 26 Oct 2021 01:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=s1k2TD0Qrcb9vKYI8rZr0EVa6rS0hMGvSNluFaVQbSA=;
 b=Xz2bMPCk1Qz+RRQxNJZp4YBeeKsOOiJrD4cSeEMMvqh+hz478dhArCa0KSZoLj2iMq0d
 2Za+WEHpFQ8Mf7ubv4L6YhgwQoIL9T2zAuNT8S1l+JNy2GE83QGl8E0SD/aWleBEQ82g
 Y1ftGaVC4QPrFZ/AWuPQ6olXCjwG221qxbXm808YPQ/VnThzMGHw9ATHCpy2HzKVaOwi
 rw21ItHSVbz3UVWyq4tQPsK2khKGaepb0dAgwUGryxksb/1ZRkmsb2idkWR1lyDGwqiJ
 GBoYPUhC306Me5v1s/F6a89LP97zYt96ntuY2wOoX5YywgvU2lfYaa5El6IEsr0DcPv7 SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx4k5bsam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:41 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q0dsR5004067;
        Tue, 26 Oct 2021 01:08:40 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bx4k5bsa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:40 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q149aK030604;
        Tue, 26 Oct 2021 01:08:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3bx4epgq42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q18ZDN3408494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 01:08:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 761944203F;
        Tue, 26 Oct 2021 01:08:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1958642041;
        Tue, 26 Oct 2021 01:08:35 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 01:08:35 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 4/6] samples: seccomp: use __BYTE_ORDER__
Date:   Tue, 26 Oct 2021 03:08:29 +0200
Message-Id: <20211026010831.748682-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026010831.748682-1-iii@linux.ibm.com>
References: <20211026010831.748682-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1kT3Rd7rwe0jZ0tu2A9n2tvZvRK61iek
X-Proofpoint-GUID: -3PVNkOABl23Fy4kq_YGl0dqt3lal2sz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260001
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


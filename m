Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB93EAD5F
	for <lists+bpf@lfdr.de>; Fri, 13 Aug 2021 00:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhHLWtE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Aug 2021 18:49:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238417AbhHLWtE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Aug 2021 18:49:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CMbYpm009572;
        Thu, 12 Aug 2021 18:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=r5VbE9AZLrl3NRrfWsDS4zNqPk35WaoV3XSLErVCPsI=;
 b=lr4oNSBObqngXskUikfMarHB76DJcseAi2qjpkIKHfDCMzqdfI3u0OrKS99CKU5h7uiP
 E2Hm72YXVjdwC9q8rVtXEkcGhberkxePvfz/8ZXWBNg6cSTvogeAKkEZju+m3f/TUEXP
 jFdK0uGb41ojHVPfysw/1pPlpuYTSpii2H5WB4Fiy3vgJcZKrvY0vO4WIyawj++FXdvF
 Q0zzH3x8SNQOy/mONSlsel6z0gaxpW3W7PxA+cX2lECzcqwit0O1DTuTeJyzE6eGreWA
 wCKQcmwVwJcNTtRD+wndFQ7jCg9/PSSA8D1YkFTFT2zYy1jORVB0jK86U7R/9hBn01vV iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3accugavrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 18:48:26 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17CMhEM3026379;
        Thu, 12 Aug 2021 18:48:26 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3accugavrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 18:48:26 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CMlvH8014708;
        Thu, 12 Aug 2021 22:48:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3acn76aprw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 22:48:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CMmKUQ55968060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 22:48:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29FA74C066;
        Thu, 12 Aug 2021 22:48:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4EB14C052;
        Thu, 12 Aug 2021 22:48:19 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 22:48:19 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix test_core_autosize on big-endian machines
Date:   Fri, 13 Aug 2021 00:48:14 +0200
Message-Id: <20210812224814.187460-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2l8jHRU3Gt2J8hTXOT6Y47cmMH36MvV6
X-Proofpoint-ORIG-GUID: YkLtJ7Se3DIbcKFw5PR-2LKw-CBs321v
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_06:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120141
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The "probed" part of test_core_autosize copies an integer using
bpf_core_read() into an integer of a potentially different size.
On big-endian machines a destination offset is required for this to
produce a sensible result.

Fixes: 888d83b961f6 ("selftests/bpf: Validate libbpf's auto-sizing of LD/ST/STX instructions")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/test_core_autosize.c  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_core_autosize.c b/tools/testing/selftests/bpf/progs/test_core_autosize.c
index 44f5aa2e8956..9a7829c5e4a7 100644
--- a/tools/testing/selftests/bpf/progs/test_core_autosize.c
+++ b/tools/testing/selftests/bpf/progs/test_core_autosize.c
@@ -125,6 +125,16 @@ int handle_downsize(void *ctx)
 	return 0;
 }
 
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define bpf_core_read_int bpf_core_read
+#else
+#define bpf_core_read_int(dst, sz, src) ({ \
+	/* Prevent "subtraction from stack pointer prohibited" */ \
+	volatile long __off = sizeof(*dst) - (sz); \
+	bpf_core_read((char *)(dst) + __off, sz, src); \
+})
+#endif
+
 SEC("raw_tp/sys_enter")
 int handle_probed(void *ctx)
 {
@@ -132,23 +142,23 @@ int handle_probed(void *ctx)
 	__u64 tmp;
 
 	tmp = 0;
-	bpf_core_read(&tmp, bpf_core_field_size(in->ptr), &in->ptr);
+	bpf_core_read_int(&tmp, bpf_core_field_size(in->ptr), &in->ptr);
 	ptr_probed = tmp;
 
 	tmp = 0;
-	bpf_core_read(&tmp, bpf_core_field_size(in->val1), &in->val1);
+	bpf_core_read_int(&tmp, bpf_core_field_size(in->val1), &in->val1);
 	val1_probed = tmp;
 
 	tmp = 0;
-	bpf_core_read(&tmp, bpf_core_field_size(in->val2), &in->val2);
+	bpf_core_read_int(&tmp, bpf_core_field_size(in->val2), &in->val2);
 	val2_probed = tmp;
 
 	tmp = 0;
-	bpf_core_read(&tmp, bpf_core_field_size(in->val3), &in->val3);
+	bpf_core_read_int(&tmp, bpf_core_field_size(in->val3), &in->val3);
 	val3_probed = tmp;
 
 	tmp = 0;
-	bpf_core_read(&tmp, bpf_core_field_size(in->val4), &in->val4);
+	bpf_core_read_int(&tmp, bpf_core_field_size(in->val4), &in->val4);
 	val4_probed = tmp;
 
 	return 0;
-- 
2.31.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3514C425993
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbhJGRfn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 13:35:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242002AbhJGRfn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Oct 2021 13:35:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197HX1dF013726;
        Thu, 7 Oct 2021 13:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uK+ASkqbIWfUQDgZat8wa6GEPzRNLEu604spGba5UWU=;
 b=DuAR6Rt9nQQlJxl6dsLpIg7m99EDoxSTgAXAWK/pobXy2jRkzkxfnBhVc22jtPhwOrqi
 jcQarVRGvUCYbBsYJ9EKcXjRBctp53pp5n8abbC4PLuXKLxVsqCb7xF9QDJmGhTpQJZZ
 Xb5Eb2jDkepB4FHTsw+l7KITR8Obdm88wkPf5MOiDCHe/okXDxL+GR8ienuEPrc3RfvF
 M3I+CkCzvjxkhb32ioRAFzSyJfMHKgD32P89xa1ZqTvIdTmK1GkHkGYpmWOIzsIuIgFC
 iuqRGjxStrrfC2KRBKGjo8lGZF4mrZyAtCjQRTXDx6BVN512zHmHFIsIiydknSrcmEmN JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bj4gm1g72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 13:33:36 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 197HXaoA016199;
        Thu, 7 Oct 2021 13:33:36 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bj4gm1g6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 13:33:35 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 197HVwK3014219;
        Thu, 7 Oct 2021 17:33:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3bef2a7642-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 17:33:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 197HXU4o40108468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Oct 2021 17:33:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A020DA4054;
        Thu,  7 Oct 2021 17:33:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B746A4064;
        Thu,  7 Oct 2021 17:33:30 +0000 (GMT)
Received: from vm.lan (unknown [9.145.45.184])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Oct 2021 17:33:30 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] bpf, selftests: Skip verifier tests that fail to load with ENOTSUPP
Date:   Thu,  7 Oct 2021 19:33:28 +0200
Message-Id: <20211007173329.381754-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8pAZ0sBG4WNJJCtUmGwspceXQpRB5ZsN
X-Proofpoint-ORIG-GUID: zkPSq5g_ojRQkgZQD7nhDiBqutBEuLNr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070113
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier tests added in commit c48e51c8b07a ("bpf: selftests: Add
selftests for module kfunc support") fail on s390, since the JIT does
not support calling kernel functions. This is most likely an issue for
all the other non-Intel arches, as well as on Intel with
!CONFIG_DEBUG_INFO_BTF or !CONFIG_BPF_JIT.

Trying to check for messages from all the possible add_kfunc_call()
failure cases in test_verifier looks pointless, so do a much simpler
thing instead: just like it's already done in do_prog_test_run(), skip
the tests that fail to load with ENOTSUPP.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 3a9e332c5e36..25afe423b3f0 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -47,6 +47,10 @@
 #include "test_btf.h"
 #include "../../../include/linux/filter.h"
 
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
@@ -974,7 +978,7 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 
 	if (err) {
 		switch (saved_errno) {
-		case 524/*ENOTSUPP*/:
+		case ENOTSUPP:
 			printf("Did not run the program (not supported) ");
 			return 0;
 		case EPERM:
@@ -1119,6 +1123,12 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		goto close_fds;
 	}
 
+	if (fd_prog < 0 && saved_errno == ENOTSUPP) {
+		printf("SKIP (program uses an unsupported feature)\n");
+		skips++;
+		goto close_fds;
+	}
+
 	alignment_prevented_execution = 0;
 
 	if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
-- 
2.31.1


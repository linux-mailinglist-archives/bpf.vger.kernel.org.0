Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6798D67488
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2019 19:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfGLRpj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jul 2019 13:45:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727362AbfGLRpj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jul 2019 13:45:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CHgYqx033619
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2019 13:45:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tpxugr2am-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2019 13:45:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Fri, 12 Jul 2019 18:45:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 18:45:34 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CHjWEG50790502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 17:45:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09A5AE05F;
        Fri, 12 Jul 2019 17:45:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6FA2AE05D;
        Fri, 12 Jul 2019 17:45:32 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.237])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 17:45:32 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     gor@linux.ibm.com, heiko.carstens@de.ibm.com,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf] selftests/bpf: fix test_send_signal_nmi on s390
Date:   Fri, 12 Jul 2019 19:45:28 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071217-0016-0000-0000-000002921FE8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071217-0017-0000-0000-000032EFE59E
Message-Id: <20190712174528.1767-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120179
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Many s390 setups (most notably, KVM guests) do not have access to
hardware performance events.

Therefore, use the software event instead.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 67cea1686305..4a45ea0b8448 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -176,10 +176,19 @@ static int test_send_signal_tracepoint(void)
 static int test_send_signal_nmi(void)
 {
 	struct perf_event_attr attr = {
+#if defined(__s390__)
+		/* Many s390 setups (most notably, KVM guests) do not have
+		 * access to hardware performance events.
+		 */
+		.sample_period = 1,
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_CPU_CLOCK,
+#else
 		.sample_freq = 50,
 		.freq = 1,
 		.type = PERF_TYPE_HARDWARE,
 		.config = PERF_COUNT_HW_CPU_CYCLES,
+#endif
 	};
 
 	return test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT, "perf_event");
-- 
2.21.0


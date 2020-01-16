Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD313EDBC
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 19:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406918AbgAPSEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 13:04:48 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:31614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391543AbgAPRkR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Jan 2020 12:40:17 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00GHZF00002993
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 09:40:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=IsyfGF2opnoXCh5u1tRp3Qee/auKwMGtuLIRG3zB0iA=;
 b=HKyJwpC+U+OZu1U59NuOejiy1DPDdHf5wFozFGhUWXNd855IWxhmcdDjw0nS5ocG7mWW
 t5V5nfV00N8QsTewOI87vmQ7SSt2fKwOJNMyLRG9utwhTZtiRCO5F/qZP04nvyxAUWcD
 cUrABrF+lpCQT6ljSVmuMz/cHB+LGOYqRyA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2xj6p45hn0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 09:40:16 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jan 2020 09:40:15 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 946463701489; Thu, 16 Jan 2020 09:40:04 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next] selftests/bpf: fix test_progs send_signal flakiness with nmi mode
Date:   Thu, 16 Jan 2020 09:40:04 -0800
Message-ID: <20200116174004.1522812-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_05:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 suspectscore=13 phishscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001160142
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei observed that test_progs send_signal may fail if run
with command line "./test_progs" and the tests will pass
if just run "./test_progs -n 40".

I observed similar issue with nmi subtest failure
and added a delay 100 us in Commit ab8b7f0cb358
("tools/bpf: Add self tests for bpf_send_signal_thread()")
and the problem is gone for me. But the issue still exists
in Alexei's testing environment.

The current code uses sample_freq = 50 (50 events/second), which
may not be enough. But if the sample_freq value is larger than
sysctl kernel/perf_event_max_sample_rate, the perf_event_open
syscall will fail.

This patch changed nmi perf testing to use sample_period = 1,
which means trying to sampling every event. This seems fixing
the issue.

Fixes: ab8b7f0cb358 ("tools/bpf: Add self tests for bpf_send_signal_thread()")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/send_signal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index d4cedd86c424..504abb7bfb95 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -76,9 +76,6 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
 		goto skel_open_load_failure;
 
-	/* add a delay for child thread to ramp up */
-	usleep(100);
-
 	if (!attr) {
 		err = test_send_signal_kern__attach(skel);
 		if (CHECK(err, "skel_attach", "skeleton attach failed\n")) {
@@ -155,8 +152,7 @@ static void test_send_signal_perf(bool signal_thread)
 static void test_send_signal_nmi(bool signal_thread)
 {
 	struct perf_event_attr attr = {
-		.sample_freq = 50,
-		.freq = 1,
+		.sample_period = 1,
 		.type = PERF_TYPE_HARDWARE,
 		.config = PERF_COUNT_HW_CPU_CYCLES,
 	};
-- 
2.17.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D0C3046D8
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 19:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbhAZRTN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 26 Jan 2021 12:19:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388785AbhAZGv3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 26 Jan 2021 01:51:29 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10Q6WYRT003232
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 22:50:39 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 368gbvdxqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 22:50:39 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 25 Jan 2021 22:50:37 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B0C292ECE7B0; Mon, 25 Jan 2021 22:50:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: don't exit on failed bpf_testmod unload
Date:   Mon, 25 Jan 2021 22:50:18 -0800
Message-ID: <20210126065019.1268027-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_04:2021-01-25,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=920 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix bug in handling bpf_testmod unloading that will cause test_progs exiting
prematurely if bpf_testmod unloading failed. This is especially problematic
when running a subset of test_progs that doesn't require root permissions and
doesn't rely on bpf_testmod, yet will fail immediately due to exit(1) in
unload_bpf_testmod().

Fixes: 9f7fa225894c ("selftests/bpf: Add bpf_testmod kernel module for testing")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 213628ee721c..6396932b97e2 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -390,7 +390,7 @@ static void unload_bpf_testmod(void)
 			return;
 		}
 		fprintf(env.stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
-		exit(1);
+		return;
 	}
 	if (env.verbosity > VERBOSE_NONE)
 		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
-- 
2.24.1


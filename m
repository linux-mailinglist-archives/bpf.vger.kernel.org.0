Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B40438042
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhJVWfC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 22 Oct 2021 18:35:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5372 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233793AbhJVWfB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 18:35:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MLCZKo020827
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:44 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bum5j0mgh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:43 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 15:32:42 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 68F1870D5F8F; Fri, 22 Oct 2021 15:32:41 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Jussi Maki <joamaki@gmail.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: mark tc_redirect selftest as serial
Date:   Fri, 22 Oct 2021 15:32:27 -0700
Message-ID: <20211022223228.99920-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022223228.99920-1-andrii@kernel.org>
References: <20211022223228.99920-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: WyJghi4vqpDGpsQQE3FG12-ignpb141E
X-Proofpoint-ORIG-GUID: WyJghi4vqpDGpsQQE3FG12-ignpb141E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It seems to cause a lot of harm to kprobe/tracepoint selftests. Yucong
mentioned before that it does manipulate sysfs, which might be the
reason. So let's mark it as serial, though ideally it would be less
intrusive on the system at test.

Cc: Jussi Maki <joamaki@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index e87bc4466d9a..53672634bc52 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -769,7 +769,7 @@ static void *test_tc_redirect_run_tests(void *arg)
 	return NULL;
 }
 
-void test_tc_redirect(void)
+void serial_test_tc_redirect(void)
 {
 	pthread_t test_thread;
 	int err;
-- 
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D273644743F
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhKGQ61 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 11:58:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54556 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234380AbhKGQ60 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 11:58:26 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A777VfC004550
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 08:55:43 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c6962u0fc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:55:43 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 08:55:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5EE4B8394BA3; Sun,  7 Nov 2021 08:55:39 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 bpf-next 8/9] selftests/bpf: destroy XDP link correctly
Date:   Sun, 7 Nov 2021 08:55:20 -0800
Message-ID: <20211107165521.9240-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107165521.9240-1-andrii@kernel.org>
References: <20211107165521.9240-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GcXblx5e8qu47sUWcoLTMrscOvm5XFwG
X-Proofpoint-GUID: GcXblx5e8qu47sUWcoLTMrscOvm5XFwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_09,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=626 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_link__detach() was confused with bpf_link__destroy() and leaves
leaked FD in the process. Fix the problem.

Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
index 7589c03fd26b..eb2feaac81fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c
@@ -204,8 +204,8 @@ static int pass_ack(struct migrate_reuseport_test_case *test_case)
 {
 	int err;
 
-	err = bpf_link__detach(test_case->link);
-	if (!ASSERT_OK(err, "bpf_link__detach"))
+	err = bpf_link__destroy(test_case->link);
+	if (!ASSERT_OK(err, "bpf_link__destroy"))
 		return -1;
 
 	test_case->link = NULL;
-- 
2.30.2


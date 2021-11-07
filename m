Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5678D44716A
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 05:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhKGEG6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 00:06:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25166 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhKGEG5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 00:06:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A72rNHx002089
        for <bpf@vger.kernel.org>; Sat, 6 Nov 2021 21:04:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c5qhvm3d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 21:04:15 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sat, 6 Nov 2021 21:04:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 254448289C70; Sat,  6 Nov 2021 21:04:08 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 8/9] selftests/bpf: destroy XDP link correctly
Date:   Sat, 6 Nov 2021 21:03:42 -0700
Message-ID: <20211107040343.583332-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107040343.583332-1-andrii@kernel.org>
References: <20211107040343.583332-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 0aM9nuya3oXeg1e7mnhyMnp9r6PGrZGn
X-Proofpoint-ORIG-GUID: 0aM9nuya3oXeg1e7mnhyMnp9r6PGrZGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=606 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_link__detach() was confused with bpf_link__destroy() and leaves
leaked FD in the process. Fix the problem.

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


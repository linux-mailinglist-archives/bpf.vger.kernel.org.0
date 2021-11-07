Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB39C447169
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 05:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhKGEGx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 00:06:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhKGEGx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 00:06:53 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A73X90u008674
        for <bpf@vger.kernel.org>; Sat, 6 Nov 2021 21:04:11 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c5qdt440s-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 21:04:11 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sat, 6 Nov 2021 21:04:10 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 601078289C68; Sat,  6 Nov 2021 21:04:06 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 7/9] selftests/bpf: avoid duplicate btf__parse() call
Date:   Sat, 6 Nov 2021 21:03:41 -0700
Message-ID: <20211107040343.583332-8-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107040343.583332-1-andrii@kernel.org>
References: <20211107040343.583332-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 04D_z7_ejhPwQdXr-7eA1CB4LyKkMV7z
X-Proofpoint-ORIG-GUID: 04D_z7_ejhPwQdXr-7eA1CB4LyKkMV7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1034 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf__parse() is repeated after successful setup, leaving the first
instance leaked. Remove redundant and premature call.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 55ec85ba7375..1041d0c593f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -433,7 +433,7 @@ static int setup_type_id_case_local(struct core_reloc_test_case *test)
 
 static int setup_type_id_case_success(struct core_reloc_test_case *test) {
 	struct core_reloc_type_id_output *exp = (void *)test->output;
-	struct btf *targ_btf = btf__parse(test->btf_src_file, NULL);
+	struct btf *targ_btf;
 	int err;
 
 	err = setup_type_id_case_local(test);
-- 
2.30.2


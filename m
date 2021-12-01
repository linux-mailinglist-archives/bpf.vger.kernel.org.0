Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005FF4659DE
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 00:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbhLAXe2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Dec 2021 18:34:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52150 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343755AbhLAXe2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 18:34:28 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1LckA2011280
        for <bpf@vger.kernel.org>; Wed, 1 Dec 2021 15:31:06 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cp74ndrcn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 15:31:06 -0800
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:31:05 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1FC8DB7A0AC7; Wed,  1 Dec 2021 15:28:33 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/9] selftests/bpf: remove recently reintroduced legacy btf__dedup() use
Date:   Wed, 1 Dec 2021 15:28:19 -0800
Message-ID: <20211201232824.3166325-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201232824.3166325-1-andrii@kernel.org>
References: <20211201232824.3166325-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: IgUxB4p4pOvtSHrvINAvCBo4hU15MoVG
X-Proofpoint-ORIG-GUID: IgUxB4p4pOvtSHrvINAvCBo4hU15MoVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 mlxlogscore=655 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We've added one extra patch that added back the use of legacy
btf__dedup() variant. Clean that up.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
index 94ff9757557a..878a864dae3b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup_split.c
@@ -364,7 +364,7 @@ static void test_split_dup_struct_in_cu()
 			"\t'f2' type_id=1 bits_offset=32");
 
 	/* ..dedup them... */
-	err = btf__dedup(btf1, NULL, NULL);
+	err = btf__dedup(btf1, NULL);
 	if (!ASSERT_OK(err, "btf_dedup"))
 		goto cleanup;
 
@@ -405,7 +405,7 @@ static void test_split_dup_struct_in_cu()
 			"\t'f1' type_id=4 bits_offset=0\n"
 			"\t'f2' type_id=4 bits_offset=32");
 
-	err = btf__dedup(btf2, NULL, NULL);
+	err = btf__dedup(btf2, NULL);
 	if (!ASSERT_OK(err, "btf_dedup"))
 		goto cleanup;
 
-- 
2.30.2


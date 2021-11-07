Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F544716B
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 05:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhKGEHH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 00:07:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229743AbhKGEHG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 00:07:06 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A73nWoJ029038
        for <bpf@vger.kernel.org>; Sat, 6 Nov 2021 21:04:23 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c5n7cck1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 21:04:23 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sat, 6 Nov 2021 21:04:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2F8E38289C78; Sat,  6 Nov 2021 21:04:11 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 9/9] selftests/bpf: fix bpf_object leak in skb_ctx selftest
Date:   Sat, 6 Nov 2021 21:03:43 -0700
Message-ID: <20211107040343.583332-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107040343.583332-1-andrii@kernel.org>
References: <20211107040343.583332-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: rGkvhXEeOZbT9SPkpThjForNRTRKrWx_
X-Proofpoint-GUID: rGkvhXEeOZbT9SPkpThjForNRTRKrWx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=703 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111070023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

skb_ctx selftest didn't close bpf_object implicitly allocated by
bpf_prog_test_load() helper. Fix the problem by explicitly calling
bpf_object__close() at the end of the test.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
index c437e6ba8fe2..db4d72563aae 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -111,4 +111,6 @@ void test_skb_ctx(void)
 		   "ctx_out_mark",
 		   "skb->mark == %u, expected %d\n",
 		   skb.mark, 10);
+
+	bpf_object__close(obj);
 }
-- 
2.30.2


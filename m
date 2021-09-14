Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8E40B47A
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 18:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhINQX7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 14 Sep 2021 12:23:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229720AbhINQX6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 12:23:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG2wFY026788
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 09:22:41 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3b2k1rm2mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 09:22:40 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 09:22:39 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7D13440693FF; Tue, 14 Sep 2021 09:22:29 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix .gitignore to not ignore test_progs.c
Date:   Tue, 14 Sep 2021 09:22:28 -0700
Message-ID: <20210914162228.3995740-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: rt4YJBcC5J_QqPNRpJYkWWxpjHCR97CW
X-Proofpoint-ORIG-GUID: rt4YJBcC5J_QqPNRpJYkWWxpjHCR97CW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_06,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

List all possible test_progs flavors explicitly to avoid accidentally
ignoring valid source code files. In this case, test_progs.c was still
ignored after recent 809ed84de8b3 ("selftests/bpf: Whitelist test_progs.h
from .gitignore") fix that added exception only for test_progs.h.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule"
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 433f8bef261e..1dad8d617da8 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -9,8 +9,9 @@ test_tag
 FEATURE-DUMP.libbpf
 fixdep
 test_dev_cgroup
-/test_progs*
-!test_progs.h
+/test_progs
+/test_progs-no_alu32
+/test_progs-bpf_gcc
 test_verifier_log
 feature
 test_sock
-- 
2.30.2


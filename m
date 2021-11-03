Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06296443CCD
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 06:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhKCFn4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 01:43:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48698 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231138AbhKCFnx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 01:43:53 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LZFwY023387
        for <bpf@vger.kernel.org>; Tue, 2 Nov 2021 22:41:17 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3dch2dpj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 22:41:17 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 22:41:16 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 90A237C6976C; Tue,  2 Nov 2021 22:41:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: make netcnt selftests serial to avoid spurious failures
Date:   Tue, 2 Nov 2021 22:41:13 -0700
Message-ID: <20211103054113.2130582-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 4Qm89FJtzBf1CgwKAdMk-rIK1lc7I9aK
X-Proofpoint-ORIG-GUID: 4Qm89FJtzBf1CgwKAdMk-rIK1lc7I9aK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 clxscore=1034 lowpriorityscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=827 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When running `./test_progs -j` test_netcnt fails with a very high
probability, undercounting number of packets received (9999 vs expected
10000). It seems to be conflicting with other cgroup/skb selftests. So
make it serial for now to make parallel mode more robust.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/netcnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/netcnt.c b/tools/testing/selftests/bpf/prog_tests/netcnt.c
index 6ede48bde91b..954964f0ac3d 100644
--- a/tools/testing/selftests/bpf/prog_tests/netcnt.c
+++ b/tools/testing/selftests/bpf/prog_tests/netcnt.c
@@ -8,7 +8,7 @@
 
 #define CG_NAME "/netcnt"
 
-void test_netcnt(void)
+void serial_test_netcnt(void)
 {
 	union percpu_net_cnt *percpu_netcnt = NULL;
 	struct bpf_cgroup_storage_key key;
-- 
2.30.2


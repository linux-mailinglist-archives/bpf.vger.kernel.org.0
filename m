Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D397944D160
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 06:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhKKFU6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 11 Nov 2021 00:20:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhKKFU6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 00:20:58 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB58JL3026795
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:18:09 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c8n6w3823-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 21:18:09 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 10 Nov 2021 21:18:08 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C0FD28B0865B; Wed, 10 Nov 2021 21:18:03 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: fix bpf_prog_test_load() logic to pass extra log level
Date:   Wed, 10 Nov 2021 21:17:58 -0800
Message-ID: <20211111051758.92283-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111051758.92283-1-andrii@kernel.org>
References: <20211111051758.92283-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: EiTmzxyk1FQ46KcEFKjxm99cXRgXXf22
X-Proofpoint-ORIG-GUID: EiTmzxyk1FQ46KcEFKjxm99cXRgXXf22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After recent refactoring bpf_prog_test_load(), used across multiple
selftests, lost ability to specify extra log_level 1 or 2 (for -vv and
-vvv, respectively). Fix that problem by using bpf_object__load_xattr()
API that supports extra log_level flags. Also restore
BPF_F_TEST_RND_HI32 prog_flags by utilizing new bpf_program__set_extra_flags()
API.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: f87c1930ac29 ("selftests/bpf: Merge test_stub.c into testing_helpers.c")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/testing_helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index ef61d43adfe4..52c2f24e0898 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -88,6 +88,7 @@ int extra_prog_load_log_flags = 0;
 int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 		       struct bpf_object **pobj, int *prog_fd)
 {
+	struct bpf_object_load_attr attr = {};
 	struct bpf_object *obj;
 	struct bpf_program *prog;
 	int err;
@@ -105,7 +106,11 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	if (type != BPF_PROG_TYPE_UNSPEC)
 		bpf_program__set_type(prog, type);
 
-	err = bpf_object__load(obj);
+	bpf_program__set_extra_flags(prog, BPF_F_TEST_RND_HI32);
+
+	attr.obj = obj;
+	attr.log_level = extra_prog_load_log_flags;
+	err = bpf_object__load_xattr(&attr);
 	if (err)
 		goto err_out;
 
-- 
2.30.2


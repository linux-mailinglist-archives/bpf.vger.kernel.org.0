Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B214468D46
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 21:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbhLEUg3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 5 Dec 2021 15:36:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23480 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238690AbhLEUg3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 5 Dec 2021 15:36:29 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1B552xue029240
        for <bpf@vger.kernel.org>; Sun, 5 Dec 2021 12:33:01 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3crpx6jyy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 05 Dec 2021 12:33:01 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 5 Dec 2021 12:33:00 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 93244BFD77C3; Sun,  5 Dec 2021 12:32:58 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 10/11] selftests/bpf: remove the only use of deprecated bpf_object__load_xattr()
Date:   Sun, 5 Dec 2021 12:32:33 -0800
Message-ID: <20211205203234.1322242-11-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211205203234.1322242-1-andrii@kernel.org>
References: <20211205203234.1322242-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 6sfCeI3fiXKI8lSElziwaUCeuj_XTCZg
X-Proofpoint-ORIG-GUID: 6sfCeI3fiXKI8lSElziwaUCeuj_XTCZg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112050123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch from bpf_object__load_xattr() to bpf_object__load() and
kernel_log_level in bpf_object_open_opts.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/testing_helpers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index 0f1c37ac6f2c..795b6798ccee 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -88,13 +88,15 @@ int extra_prog_load_log_flags = 0;
 int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 		       struct bpf_object **pobj, int *prog_fd)
 {
-	struct bpf_object_load_attr attr = {};
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.kernel_log_level = extra_prog_load_log_flags,
+	);
 	struct bpf_object *obj;
 	struct bpf_program *prog;
 	__u32 flags;
 	int err;
 
-	obj = bpf_object__open(file);
+	obj = bpf_object__open_file(file, &opts);
 	if (!obj)
 		return -errno;
 
@@ -110,9 +112,7 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
 	flags = bpf_program__flags(prog) | BPF_F_TEST_RND_HI32;
 	bpf_program__set_flags(prog, flags);
 
-	attr.obj = obj;
-	attr.log_level = extra_prog_load_log_flags;
-	err = bpf_object__load_xattr(&attr);
+	err = bpf_object__load(obj);
 	if (err)
 		goto err_out;
 
-- 
2.30.2


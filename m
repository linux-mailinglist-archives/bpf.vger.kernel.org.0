Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B49044743B
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhKGQ60 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 11:58:26 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235945AbhKGQ6V (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 11:58:21 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A793pbR004398
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 08:55:38 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c6avujdar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:55:38 -0800
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 08:55:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BC2438394B9A; Sun,  7 Nov 2021 08:55:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 bpf-next 6/9] selftests/bpf: clean up btf and btf_dump in dump_datasec test
Date:   Sun, 7 Nov 2021 08:55:18 -0800
Message-ID: <20211107165521.9240-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107165521.9240-1-andrii@kernel.org>
References: <20211107165521.9240-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: By4_ofaCVttZ-CE00r-8R-Ep2TMBP7fs
X-Proofpoint-ORIG-GUID: By4_ofaCVttZ-CE00r-8R-Ep2TMBP7fs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_09,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=880 suspectscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1034 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Free up used resources at the end and on error. Also make it more
obvious that there is btf__parse() call that creates struct btf
instance.

Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index aa76360d8f49..a04961942dfa 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -814,21 +814,25 @@ static void test_btf_datasec(struct btf *btf, struct btf_dump *d, char *str,
 
 static void test_btf_dump_datasec_data(char *str)
 {
-	struct btf *btf = btf__parse("xdping_kern.o", NULL);
+	struct btf *btf;
 	struct btf_dump_opts opts = { .ctx = str };
 	char license[4] = "GPL";
 	struct btf_dump *d;
 
+	btf = btf__parse("xdping_kern.o", NULL);
 	if (!ASSERT_OK_PTR(btf, "xdping_kern.o BTF not found"))
 		return;
 
 	d = btf_dump__new(btf, NULL, &opts, btf_dump_snprintf);
 	if (!ASSERT_OK_PTR(d, "could not create BTF dump"))
-		return;
+		goto out;
 
 	test_btf_datasec(btf, d, str, "license",
 			 "SEC(\"license\") char[4] _license = (char[4])['G','P','L',];",
 			 license, sizeof(license));
+out:
+	btf_dump__free(d);
+	btf__free(btf);
 }
 
 void test_btf_dump() {
-- 
2.30.2


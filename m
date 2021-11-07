Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061D94473ED
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 17:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhKGQt0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 11:49:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35622 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234852AbhKGQt0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Nov 2021 11:49:26 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A7AuZm7020258
        for <bpf@vger.kernel.org>; Sun, 7 Nov 2021 08:46:43 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c6962tyms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 08:46:43 -0800
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 7 Nov 2021 08:46:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B0E83838FACB; Sun,  7 Nov 2021 08:46:33 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v3 bpf-next 4/9] selftests/bpf: free per-cpu values array in bpf_iter selftest
Date:   Sun, 7 Nov 2021 08:46:19 -0800
Message-ID: <20211107164624.4137512-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211107164624.4137512-1-andrii@kernel.org>
References: <20211107164624.4137512-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: qiv23Lpckvdl-VOQdaIH9rYews5CduxQ
X-Proofpoint-GUID: qiv23Lpckvdl-VOQdaIH9rYews5CduxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-07_09,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=965 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111070108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Array holding per-cpu values wasn't freed. Fix that.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 9454331aaf85..3e10abce3e5a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -699,14 +699,13 @@ static void test_bpf_percpu_hash_map(void)
 	char buf[64];
 	void *val;
 
-	val = malloc(8 * bpf_num_possible_cpus());
-
 	skel = bpf_iter_bpf_percpu_hash_map__open();
 	if (CHECK(!skel, "bpf_iter_bpf_percpu_hash_map__open",
 		  "skeleton open failed\n"))
 		return;
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
+	val = malloc(8 * bpf_num_possible_cpus());
 
 	err = bpf_iter_bpf_percpu_hash_map__load(skel);
 	if (CHECK(!skel, "bpf_iter_bpf_percpu_hash_map__load",
@@ -770,6 +769,7 @@ static void test_bpf_percpu_hash_map(void)
 	bpf_link__destroy(link);
 out:
 	bpf_iter_bpf_percpu_hash_map__destroy(skel);
+	free(val);
 }
 
 static void test_bpf_array_map(void)
@@ -870,14 +870,13 @@ static void test_bpf_percpu_array_map(void)
 	void *val;
 	int len;
 
-	val = malloc(8 * bpf_num_possible_cpus());
-
 	skel = bpf_iter_bpf_percpu_array_map__open();
 	if (CHECK(!skel, "bpf_iter_bpf_percpu_array_map__open",
 		  "skeleton open failed\n"))
 		return;
 
 	skel->rodata->num_cpus = bpf_num_possible_cpus();
+	val = malloc(8 * bpf_num_possible_cpus());
 
 	err = bpf_iter_bpf_percpu_array_map__load(skel);
 	if (CHECK(!skel, "bpf_iter_bpf_percpu_array_map__load",
@@ -933,6 +932,7 @@ static void test_bpf_percpu_array_map(void)
 	bpf_link__destroy(link);
 out:
 	bpf_iter_bpf_percpu_array_map__destroy(skel);
+	free(val);
 }
 
 /* An iterator program deletes all local storage in a map. */
-- 
2.30.2


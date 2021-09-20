Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0224412953
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 01:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhITXW0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 20 Sep 2021 19:22:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232776AbhITXUZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 19:20:25 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18KHwc9K016854
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:18:58 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3b6jr0dxt2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:18:58 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 16:18:56 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2A182487A9D4; Mon, 20 Sep 2021 16:16:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: adopt attach_probe selftest to work on old kernels
Date:   Mon, 20 Sep 2021 16:16:15 -0700
Message-ID: <20210920231617.3141867-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920231617.3141867-1-andrii@kernel.org>
References: <20210920231617.3141867-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 8ojsHtLAbDymmGN-_0Ldi9QlO0kUveDB
X-Proofpoint-GUID: 8ojsHtLAbDymmGN-_0Ldi9QlO0kUveDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure to not use ref_ctr_off feature when running on old kernels
that don't support this feature. This allows to test libbpf's legacy
kprobe and uprobe logic on old kernels.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/attach_probe.c      | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index bf307bb9e446..cbd6b6175d5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -14,6 +14,12 @@ void test_attach_probe(void)
 	struct test_attach_probe* skel;
 	size_t uprobe_offset;
 	ssize_t base_addr, ref_ctr_offset;
+	bool legacy;
+
+	/* check is new-style kprobe/uprobe API is supported */
+	legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
+
+	legacy = true;
 
 	base_addr = get_base_addr();
 	if (CHECK(base_addr < 0, "get_base_addr",
@@ -45,10 +51,11 @@ void test_attach_probe(void)
 		goto cleanup;
 	skel->links.handle_kretprobe = kretprobe_link;
 
-	ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
+	if (!legacy)
+		ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
 
 	uprobe_opts.retprobe = false;
-	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
 	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
 						      0 /* self pid */,
 						      "/proc/self/exe",
@@ -58,11 +65,12 @@ void test_attach_probe(void)
 		goto cleanup;
 	skel->links.handle_uprobe = uprobe_link;
 
-	ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
+	if (!legacy)
+		ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
 
 	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
 	uprobe_opts.retprobe = true;
-	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
 	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe,
 							 -1 /* any pid */,
 							 "/proc/self/exe",
-- 
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB61413BDF
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 23:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhIUVCe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 21 Sep 2021 17:02:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63000 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231145AbhIUVC1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 17:02:27 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LH95jQ024011
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:00:47 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7cgh4v9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:00:47 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 14:00:45 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 328CF49ACF03; Tue, 21 Sep 2021 14:00:42 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/4] selftests/bpf: adopt attach_probe selftest to work on old kernels
Date:   Tue, 21 Sep 2021 14:00:34 -0700
Message-ID: <20210921210036.1545557-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921210036.1545557-1-andrii@kernel.org>
References: <20210921210036.1545557-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: fysav00R9b-fuAEixT892i4-6NjC6AkO
X-Proofpoint-GUID: fysav00R9b-fuAEixT892i4-6NjC6AkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_06,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure to not use ref_ctr_off feature when running on old kernels
that don't support this feature. This allows to test libbpf's legacy
kprobe and uprobe logic on old kernels.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index bf307bb9e446..6c511dcd1465 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -14,6 +14,20 @@ void test_attach_probe(void)
 	struct test_attach_probe* skel;
 	size_t uprobe_offset;
 	ssize_t base_addr, ref_ctr_offset;
+	bool legacy;
+
+	/* Check if new-style kprobe/uprobe API is supported.
+	 * Kernels that support new FD-based kprobe and uprobe BPF attachment
+	 * through perf_event_open() syscall expose
+	 * /sys/bus/event_source/devices/kprobe/type and
+	 * /sys/bus/event_source/devices/uprobe/type files, respectively. They
+	 * contain magic numbers that are passed as "type" field of
+	 * perf_event_attr. Lack of such file in the system indicates legacy
+	 * kernel with old-style kprobe/uprobe attach interface through
+	 * creating per-probe event through tracefs. For such cases
+	 * ref_ctr_offset feature is not supported, so we don't test it.
+	 */
+	legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
 
 	base_addr = get_base_addr();
 	if (CHECK(base_addr < 0, "get_base_addr",
@@ -45,10 +59,11 @@ void test_attach_probe(void)
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
@@ -58,11 +73,12 @@ void test_attach_probe(void)
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


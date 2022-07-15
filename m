Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0EF576A6E
	for <lists+bpf@lfdr.de>; Sat, 16 Jul 2022 01:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiGOXKJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 15 Jul 2022 19:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGOXKI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 19:10:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2CC3719F
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:10:07 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FKnOjO016680
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:10:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hb892uuq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 16:10:07 -0700
Received: from twshared13579.04.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 16:10:06 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4920B1C65B750; Fri, 15 Jul 2022 16:09:58 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: test eager BPF ringbuf size adjustment logic
Date:   Fri, 15 Jul 2022 16:09:52 -0700
Message-ID: <20220715230952.2219271-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220715230952.2219271-1-andrii@kernel.org>
References: <20220715230952.2219271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: riCmeEnePalBUQEqQZFhsp58msnfKLKa
X-Proofpoint-GUID: riCmeEnePalBUQEqQZFhsp58msnfKLKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_13,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test validating that libbpf adjusts (and reflects adjusted) ringbuf
size early, before bpf_object is loaded. Also make sure we can't
successfully resize ringbuf map after bpf_object is loaded.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/ringbuf_multi.c  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index eb5f7f5aa81a..1455911d9fcb 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -50,6 +50,13 @@ void test_ringbuf_multi(void)
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
 		return;
 
+	/* validate ringbuf size adjustment logic */
+	ASSERT_EQ(bpf_map__max_entries(skel->maps.ringbuf1), page_size, "rb1_size_before");
+	ASSERT_OK(bpf_map__set_max_entries(skel->maps.ringbuf1, page_size + 1), "rb1_resize");
+	ASSERT_EQ(bpf_map__max_entries(skel->maps.ringbuf1), 2 * page_size, "rb1_size_after");
+	ASSERT_OK(bpf_map__set_max_entries(skel->maps.ringbuf1, page_size), "rb1_reset");
+	ASSERT_EQ(bpf_map__max_entries(skel->maps.ringbuf1), page_size, "rb1_size_final");
+
 	proto_fd = bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0, page_size, NULL);
 	if (CHECK(proto_fd < 0, "bpf_map_create", "bpf_map_create failed\n"))
 		goto cleanup;
@@ -65,6 +72,10 @@ void test_ringbuf_multi(void)
 	close(proto_fd);
 	proto_fd = -1;
 
+	/* make sure we can't resize ringbuf after object load */
+	if (!ASSERT_ERR(bpf_map__set_max_entries(skel->maps.ringbuf1, 3 * page_size), "rb1_resize_after_load"))
+		goto cleanup;
+
 	/* only trigger BPF program for current process */
 	skel->bss->pid = getpid();
 
-- 
2.30.2


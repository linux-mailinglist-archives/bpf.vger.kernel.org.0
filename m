Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD851F262
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiEIBbJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 8 May 2022 21:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiEIAqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:46:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05406573
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:14 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2490R6Tr012471
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:14 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fxhwws2bn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:14 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A748A19A4AD81; Sun,  8 May 2022 17:42:07 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 9/9] selftests/bpf: test libbpf's ringbuf size fix up logic
Date:   Sun, 8 May 2022 17:41:48 -0700
Message-ID: <20220509004148.1801791-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AnGkfIfr7_iZWlXU1lIVaOB5B1BBe1D4
X-Proofpoint-ORIG-GUID: AnGkfIfr7_iZWlXU1lIVaOB5B1BBe1D4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure we always excercise libbpf's ringbuf map size adjustment logic
by specifying non-zero size that's definitely not a page size multiple.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/ringbuf_multi.c | 12 ------------
 .../testing/selftests/bpf/progs/test_ringbuf_multi.c |  2 ++
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index e945195b24c9..eb5f7f5aa81a 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -50,18 +50,6 @@ void test_ringbuf_multi(void)
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
 		return;
 
-	err = bpf_map__set_max_entries(skel->maps.ringbuf1, page_size);
-	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
-		goto cleanup;
-
-	err = bpf_map__set_max_entries(skel->maps.ringbuf2, page_size);
-	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
-		goto cleanup;
-
-	err = bpf_map__set_max_entries(bpf_map__inner_map(skel->maps.ringbuf_arr), page_size);
-	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
-		goto cleanup;
-
 	proto_fd = bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0, page_size, NULL);
 	if (CHECK(proto_fd < 0, "bpf_map_create", "bpf_map_create failed\n"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
index 197b86546dca..e416e0ce12b7 100644
--- a/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_multi.c
@@ -15,6 +15,8 @@ struct sample {
 
 struct ringbuf_map {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	/* libbpf will adjust to valid page size */
+	__uint(max_entries, 1000);
 } ringbuf1 SEC(".maps"),
   ringbuf2 SEC(".maps");
 
-- 
2.30.2


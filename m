Return-Path: <bpf+bounces-10784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E513E7AE0FE
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 578DE1F25012
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338B2421A;
	Mon, 25 Sep 2023 21:52:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09062420F
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:32 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EACAF
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:30 -0700 (PDT)
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PE1xYp020891;
	Mon, 25 Sep 2023 21:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=P5GUbZOx+qmnaD17cFxjA7z9CKXPoygw9BNJj8DGy1A=; b=ZNPNq6ulLykT
	DmpBV0drYnshNbWHcdN02Mr272aZKHUJBtQTfBLy+jxhS0bRvGG0yuoaTsVJz20u
	34/twRv7AGai6KxBizn6zjC02vptEXR2bZLr979/TBp5wE+4NlwHhN+nkF5h3jbP
	qNnKZlv+GcNbVYCoOcIqFQwoK0GgdeqR8P6rcNV49ut2iUi6N3CSx4kK9irpPEFm
	3HlRsvNF/p1YiwqDwbKX24g6Pw9fZkHOFQME2oIf1bdQRF/PJNFdavZgEPVotOQZ
	rpwhjPvzu/DYiOsismMg0A2q3gR4ej9WxhaS2BCbEmm//+MplmKcwqgZCY02ISCl
	yIhO5YDdxw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3tac99mtfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:09 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:07 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 04/14] selftests/bpf: add tests for ring_buffer__ring
Date: Mon, 25 Sep 2023 14:50:35 -0700
Message-ID: <20230925215045.2375758-5-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925215045.2375758-1-martin.kelly@crowdstrike.com>
References: <20230925215045.2375758-1-martin.kelly@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH12.crowdstrike.sys (10.100.11.116) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: q9gSQyKjdjeCb4VI17fKVkM7zXnpw6Se
X-Proofpoint-GUID: q9gSQyKjdjeCb4VI17fKVkM7zXnpw6Se
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=698
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tests for the new API ring_buffer__ring.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/ringbuf_multi.c      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index 1455911d9fcb..58522195081b 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -42,6 +42,8 @@ void test_ringbuf_multi(void)
 {
 	struct test_ringbuf_multi *skel;
 	struct ring_buffer *ringbuf = NULL;
+	struct ring *ring_old;
+	struct ring *ring;
 	int err;
 	int page_size = getpagesize();
 	int proto_fd = -1;
@@ -84,11 +86,24 @@ void test_ringbuf_multi(void)
 	if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n"))
 		goto cleanup;
 
+	/* verify ring_buffer__ring returns expected results */
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_idx_0"))
+		goto cleanup;
+	ring_old = ring;
+	ring = ring_buffer__ring(ringbuf, 1);
+	ASSERT_ERR_PTR(ring, "ring_buffer__ring_idx_1");
+
 	err = ring_buffer__add(ringbuf, bpf_map__fd(skel->maps.ringbuf2),
 			      process_sample, (void *)(long)2);
 	if (CHECK(err, "ringbuf_add", "failed to add another ring\n"))
 		goto cleanup;
 
+	/* verify adding a new ring didn't invalidate our older pointer */
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (!ASSERT_EQ(ring, ring_old, "ring_buffer__ring_again"))
+		goto cleanup;
+
 	err = test_ringbuf_multi__attach(skel);
 	if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n", err))
 		goto cleanup;
-- 
2.34.1



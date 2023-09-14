Return-Path: <bpf+bounces-10104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2A7A117D
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53F0282278
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08163D528;
	Thu, 14 Sep 2023 23:12:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962033F2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:33 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811F92707
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:33 -0700 (PDT)
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8gaX005492;
	Thu, 14 Sep 2023 23:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=ab7bWV5Qt7+BdpIxfO13A0i2nk0unwWCSp+LT827bss=; b=QQc6GqA+pcWV
	nITLXQjNz0WUC6jEynm3oc0proNkvANM5LJ/wAYu7i5BxrFnV34ll3jndwgifCQc
	4cWFnILhj2NJf6Uqn6l5BdqtiBRlaazQUE1NHKp/3trpvkkXDKj1JA+7a3xlGsGb
	SOGO5B/4loxSm3wDlTS7QWuMHzjAX7O8TaPyMUBSpPUKQ09gtq9SzZUfUK0Gb8aC
	KzBLFPGs/BlUdPI41wuZtdlqv0TTxwStFQ4sLOJRXV3Pn8ZkKfR3VN6Y3zOn32AT
	ZG4z/fTVWiCb36qYtFFpXvoxHbRXJzEf4+fqAdNFMy+vewViXXRbIvXvrzd9oYTp
	wI+yIRpa8g==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t2ybue89n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:15 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:13 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 04/14] selftests/bpf: add tests for ring_buffer__ring
Date: Thu, 14 Sep 2023 16:11:13 -0700
Message-ID: <20230914231123.193901-5-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914231123.193901-1-martin.kelly@crowdstrike.com>
References: <20230914231123.193901-1-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: zkZYY4iOls6n6LmK9xYBJmN6lwZ1pAlS
X-Proofpoint-ORIG-GUID: zkZYY4iOls6n6LmK9xYBJmN6lwZ1pAlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=718 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140202

Add tests for the new API ring_buffer__ring.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/ringbuf_multi.c     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index 1455911d9fcb..f0729ffaf030 100644
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
@@ -84,11 +86,25 @@ void test_ringbuf_multi(void)
 	if (CHECK(!ringbuf, "ringbuf_create", "failed to create ringbuf\n"))
 		goto cleanup;
 
+	/* verify ring_buffer__ring returns expected results */
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (CHECK(ring == NULL, "ringbuf_ring", "valid index returning NULL\n"))
+		goto cleanup;
+	ring_old = ring;
+	ring = ring_buffer__ring(ringbuf, 1);
+	if (CHECK(ring != NULL, "ringbuf_ring", "invalid index not rejected\n"))
+		goto cleanup;
+
 	err = ring_buffer__add(ringbuf, bpf_map__fd(skel->maps.ringbuf2),
 			      process_sample, (void *)(long)2);
 	if (CHECK(err, "ringbuf_add", "failed to add another ring\n"))
 		goto cleanup;
 
+	/* verify adding a new ring didn't invalidate our older pointer */
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (CHECK(ring != ring_old, "ringbuf_ring", "old ring invalidated\n"))
+		goto cleanup;
+
 	err = test_ringbuf_multi__attach(skel);
 	if (CHECK(err, "skel_attach", "skeleton attachment failed: %d\n", err))
 		goto cleanup;
-- 
2.34.1



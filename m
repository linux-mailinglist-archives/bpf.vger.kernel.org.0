Return-Path: <bpf+bounces-10109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6757A1185
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273F02821EB
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30021DDAC;
	Thu, 14 Sep 2023 23:12:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6ED2F0
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:37 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7C270E
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:36 -0700 (PDT)
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8gFs005495;
	Thu, 14 Sep 2023 23:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=7dE0tgoc6k+fmrl+soSplJRLAwsaa1MEaYoklIccHws=; b=u4Za0N/ocKkF
	1NXpNN7cAU+WlIqnlXqiDC2VLOSX81EMrZdJmIevlQxTTC+3rg+aISA2AOEnkerS
	walPeit5iAZXMTRvUBpG1SDgZrUnphXtpA0GBZoMFsiK0TGwpDZkjgqEkhmJHHQS
	fLBQ6T2zGdOa2lJOAwvYW6LcqllF8PQhvW7ngF7e4/YsoAq9svONKPKH+JLwT/vL
	74pjyzqZDAZS6yD5kZZPaSCnS3a9Xso1hCQwMONmzBJyO5+MIZjpRyX7oVcwaiEx
	fq6j2X7bIW8VrQEK0i4VpZuRgCH+oAY9lE8lsjUJQbsmG3QKLNuXF8IPheIi9rTM
	3Qo0PQCgCg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t2ybue89q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:17 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:15 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 06/14] selftests/bpf: add tests for ring__*_pos
Date: Thu, 14 Sep 2023 16:11:15 -0700
Message-ID: <20230914231123.193901-7-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: 3mkhMCSKZZ1wvnO07vOR1JxYqYD9vqm6
X-Proofpoint-ORIG-GUID: 3mkhMCSKZZ1wvnO07vOR1JxYqYD9vqm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=970 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140202

Add tests for the new APIs ring__producer_pos and ring__consumer_pos.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 .../testing/selftests/bpf/prog_tests/ringbuf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index ac104dc652e3..0400123da690 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -91,6 +91,8 @@ static void ringbuf_subtest(void)
 	int err, cnt, rb_fd;
 	int page_size = getpagesize();
 	void *mmap_ptr, *tmp_ptr;
+	struct ring *ring;
+	unsigned long cons_pos, prod_pos;
 
 	skel = test_ringbuf_lskel__open();
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
@@ -162,6 +164,10 @@ static void ringbuf_subtest(void)
 
 	trigger_samples();
 
+	ring = ring_buffer__ring(ringbuf, 0);
+	if (CHECK(ring == NULL, "ringbuf_ring", "valid index returning NULL\n"))
+		goto cleanup;
+
 	/* 2 submitted + 1 discarded records */
 	CHECK(skel->bss->avail_data != 3 * rec_sz,
 	      "err_avail_size", "exp %ld, got %ld\n",
@@ -176,6 +182,18 @@ static void ringbuf_subtest(void)
 	      "err_prod_pos", "exp %ld, got %ld\n",
 	      3L * rec_sz, skel->bss->prod_pos);
 
+	/* verify getting this data directly via the ring object yields the same
+	 * results
+	 */
+	cons_pos = ring__consumer_pos(ring);
+	CHECK(cons_pos != 0,
+	      "err_ring_cons_pos", "exp %ld, got %ld\n",
+	      0L, cons_pos);
+	prod_pos = ring__producer_pos(ring);
+	CHECK(prod_pos != 3 * rec_sz,
+	      "err_ring_prod_pos", "exp %ld, got %ld\n",
+	      3L * rec_sz, prod_pos);
+
 	/* poll for samples */
 	err = ring_buffer__poll(ringbuf, -1);
 
-- 
2.34.1



Return-Path: <bpf+bounces-9473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F1797F4A
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316B31C20B94
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546E14A98;
	Thu,  7 Sep 2023 23:42:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BC14A87
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 23:42:14 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7342A1BD2
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:42:13 -0700 (PDT)
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 387HPVQw016732;
	Thu, 7 Sep 2023 23:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=Az8uD3vR+LqKVSBoaSF5yKiMSRElub0jbj9JLqszPf4=; b=QWzi33yBtDCs
	4qAcrA8Os7LKI21Pj623p5Ro/FGxpBmOdrf/v2l8kyjjBjAICe2ICbPo8SnRrNa6
	d8FEYjjRmWOj5BKZW3UPisQWs+jWxHg92bfpTqdnG5doT+Fja3T9XrCB+GKeHfSg
	q/7GwkjVK5lOBvQq4cSSbVnBHbMP2nG2o03TKIXkVr91REY+tiG0xudqNfgHsIBQ
	CxzSmcIcnouN6XVx0MT66YO4jmsTfnPEhxPYWak35LNemUAkTbEBPMRUHwvOaznx
	bjhnazR5IZURiENAo182jB+74twB1veofspkDyDcLrdbzss7PgpMHXJv4BYnDkX4
	sVX67VA3dQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3svhhabsfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Sep 2023 23:42:00 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 7 Sep 2023 23:41:58 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Kelly
	<martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add tests for ring_buffer__query
Date: Thu, 7 Sep 2023 16:40:41 -0700
Message-ID: <20230907234041.58388-3-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907234041.58388-1-martin.kelly@crowdstrike.com>
References: <20230907234041.58388-1-martin.kelly@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH11.crowdstrike.sys (10.100.11.115) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: 2_x1Oeyr1c0NuqcRHgwO0FTqYOlzg6ae
X-Proofpoint-GUID: 2_x1Oeyr1c0NuqcRHgwO0FTqYOlzg6ae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309070208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Confirm we get the same results using ring_buffer__query from the
usermode side as from the corresponding BPF helper.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 .../selftests/bpf/prog_tests/ringbuf.c        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index ac104dc652e3..93dcb92fc0c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -91,6 +91,7 @@ static void ringbuf_subtest(void)
 	int err, cnt, rb_fd;
 	int page_size = getpagesize();
 	void *mmap_ptr, *tmp_ptr;
+	__u64 val;
 
 	skel = test_ringbuf_lskel__open();
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
@@ -176,6 +177,27 @@ static void ringbuf_subtest(void)
 	      "err_prod_pos", "exp %ld, got %ld\n",
 	      3L * rec_sz, skel->bss->prod_pos);
 
+	/* verify the same results from the usermode side */
+	val = ring_buffer__query(ringbuf, 0, BPF_RB_AVAIL_DATA);
+	CHECK(val != 3 * rec_sz,
+	      "err_query_avail_size", "exp %ld, got %llu\n",
+	      3L * rec_sz, val);
+
+	val = ring_buffer__query(ringbuf, 0, BPF_RB_RING_SIZE);
+	CHECK(val != page_size,
+	      "err_query_ring_size", "exp %ld, got %llu\n",
+	      (long)page_size, val);
+
+	val = ring_buffer__query(ringbuf, 0, BPF_RB_CONS_POS);
+	CHECK(val != 0,
+	      "err_query_cons_pos", "exp %ld, got %llu\n",
+	      0L, val);
+
+	val = ring_buffer__query(ringbuf, 0, BPF_RB_PROD_POS);
+	CHECK(val != 3 * rec_sz,
+	      "err_query_prod_pos", "exp %ld, got %llu\n",
+	      3L * rec_sz, val);
+
 	/* poll for samples */
 	err = ring_buffer__poll(ringbuf, -1);
 
-- 
2.34.1



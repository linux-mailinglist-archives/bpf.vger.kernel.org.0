Return-Path: <bpf+bounces-10786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54717AE100
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 60716281885
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA3F250E8;
	Mon, 25 Sep 2023 21:52:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350102421C
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:31 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15307116
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:30 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PFRvLs007108;
	Mon, 25 Sep 2023 21:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=tIaiACjOb4wLrjbzF7OFknVvow8wjMS/QHTg2pjKZf0=; b=x2+DcDlW1Shs
	EE2GTlB2Onp868Chz8ZlrIBxAMVaGW7HFcmn9oD7aigJmWdZLgOb04xMjIhlgU9P
	JnPpO4ctizSZNZjAoXs786hCYvCKGF/aKCM6myJtived62YgyrF0yuLQlUKak1uS
	z1wFch57MaDp8X993CQYVBXR2VOiJCOjNzktGG1TSn6du5aBfnaHGMcuEgSuEn8o
	cX0WM68eiHlQa4F7sTvqSGTA6d0VbVk9uOEH0v/9mPHJCdlrM6+WDK2ciYXE4D3z
	uXL6ULzYz6OSPMcUO/BK+bS2t9DTNhiFHXPDgKWbiUSSjMyC0TVMCL8IJJdbRFgw
	ggLHTFFLKw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3tab8xcpjt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:11 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:10 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 06/14] selftests/bpf: add tests for ring__*_pos
Date: Mon, 25 Sep 2023 14:50:37 -0700
Message-ID: <20230925215045.2375758-7-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: n3cszQsS290a4hWoMD2DVYad3803kAjn
X-Proofpoint-ORIG-GUID: n3cszQsS290a4hWoMD2DVYad3803kAjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=961 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tests for the new APIs ring__producer_pos and ring__consumer_pos.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index ac104dc652e3..994a36a2b589 100644
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
+	if (!ASSERT_OK_PTR(ring, "ring_buffer__ring_idx_0"))
+		goto cleanup;
+
 	/* 2 submitted + 1 discarded records */
 	CHECK(skel->bss->avail_data != 3 * rec_sz,
 	      "err_avail_size", "exp %ld, got %ld\n",
@@ -176,6 +182,14 @@ static void ringbuf_subtest(void)
 	      "err_prod_pos", "exp %ld, got %ld\n",
 	      3L * rec_sz, skel->bss->prod_pos);
 
+	/* verify getting this data directly via the ring object yields the same
+	 * results
+	 */
+	cons_pos = ring__consumer_pos(ring);
+	ASSERT_EQ(cons_pos, 0, "ring_cons_pos");
+	prod_pos = ring__producer_pos(ring);
+	ASSERT_EQ(prod_pos, 3 * rec_sz, "ring_prod_pos");
+
 	/* poll for samples */
 	err = ring_buffer__poll(ringbuf, -1);
 
-- 
2.34.1



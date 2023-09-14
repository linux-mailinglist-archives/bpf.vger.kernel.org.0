Return-Path: <bpf+bounces-10102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3AF7A117B
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AFD282274
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924E9D51B;
	Thu, 14 Sep 2023 23:12:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE69D2FF
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:32 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE672710
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:32 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL98Zk004048;
	Thu, 14 Sep 2023 23:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=xHsuaCF+ji5JlvQ6uEDscbrgcEVIoNUmC1moDiZoHbY=; b=EtIe3b2jboAa
	eKflg8S2/pBvDJa3VepOv/OhuSRCl5dcVj/9wuqzPVNoSA1zMyG7sZrQNJxjNyAP
	nfcQ1RD5xuT10GnDaZDQJ7Pqn/KkOciYDxZyx3NRLp+d5NzFpeveepcDS1GUKLsT
	7KE7eFDbHf6C6FNSLAqAIhgh34WBZkk8E5NlQidh9b1Z0Y3lR6wTjG4CoBUw3Xl2
	9yzjLWEBARWhMLTH7jLJzktwrO1yn8+DBGAJY//GXsGJC/Q06zBK4N6kpUrSFzaP
	Wy4aJN3d0f3sTCkWclyelf9dR4cEACf1fHhoQt4jQq2I+ry1A8Ss2c9aI1rlCYuN
	ybGIdF6Llw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9966na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:19 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:17 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 08/14] selftests/bpf: add tests for ring__avail_data_size
Date: Thu, 14 Sep 2023 16:11:17 -0700
Message-ID: <20230914231123.193901-9-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: Qy2_Vo5qfXw3G4q-FE1W92bgas_vOg78
X-Proofpoint-ORIG-GUID: Qy2_Vo5qfXw3G4q-FE1W92bgas_vOg78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=955
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140202

Add test for the new API ring__avail_data_size.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 0400123da690..e4e1171e2e4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -92,7 +92,7 @@ static void ringbuf_subtest(void)
 	int page_size = getpagesize();
 	void *mmap_ptr, *tmp_ptr;
 	struct ring *ring;
-	unsigned long cons_pos, prod_pos;
+	unsigned long avail_data, cons_pos, prod_pos;
 
 	skel = test_ringbuf_lskel__open();
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
@@ -185,6 +185,10 @@ static void ringbuf_subtest(void)
 	/* verify getting this data directly via the ring object yields the same
 	 * results
 	 */
+	avail_data = ring__avail_data_size(ring);
+	CHECK(avail_data != 3 * rec_sz,
+	      "err_ring_avail_size", "exp %ld, got %ld\n",
+	      3L * rec_sz, avail_data);
 	cons_pos = ring__consumer_pos(ring);
 	CHECK(cons_pos != 0,
 	      "err_ring_cons_pos", "exp %ld, got %ld\n",
-- 
2.34.1



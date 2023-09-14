Return-Path: <bpf+bounces-10110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D77A1186
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF1A28209F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63905DDB4;
	Thu, 14 Sep 2023 23:12:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ADBD532
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:37 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FE2707
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:36 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8ekA001454;
	Thu, 14 Sep 2023 23:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=Ch7VhHiePgS8Q0D71JWR8zQBruQX4+TcUucDmG89W98=; b=Fl6eMc1+wFUU
	U5xHmWHVtBzg6x4iLQrrCSOZEehqy6YclVA8FTGUExDCMsCRG5obP3nF3PsbJTRG
	bYlG5/uRev/kxG1vVBSUIY0iyZ8BmOYMWiRm012koTUm/6rEpZf5KXY3e1rnuf7z
	rJwq5I3RI2/Z0xZoDVfUfzHNHjszyMULzYW0VkGgoiX/j1AlF6VOy8gfSh38zQuV
	aGUGB0Hr+a0lgxTv2iHopbOFCbkzkhMJRvvvb8nVQQHVSyjWwKiky2NHR5z6xqWL
	WRl4CTTBD1xh/34m4JGxVWA/AsnkSZtKGBM0t4H63zfrjbHwHm++Bv/JTV+fgPST
	xxStOscR9A==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9fpcpb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:22 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:20 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 10/14] selftests/bpf: add tests for ring__size
Date: Thu, 14 Sep 2023 16:11:19 -0700
Message-ID: <20230914231123.193901-11-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: nSHa_Iun6sOXQKchJPEf6hLlHi4NAJFZ
X-Proofpoint-GUID: nSHa_Iun6sOXQKchJPEf6hLlHi4NAJFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=903 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2309140202

Add tests for the new API ring__size.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index e4e1171e2e4d..962dc1bc5f3b 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -92,7 +92,7 @@ static void ringbuf_subtest(void)
 	int page_size = getpagesize();
 	void *mmap_ptr, *tmp_ptr;
 	struct ring *ring;
-	unsigned long avail_data, cons_pos, prod_pos;
+	unsigned long avail_data, ring_size, cons_pos, prod_pos;
 
 	skel = test_ringbuf_lskel__open();
 	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
@@ -189,6 +189,10 @@ static void ringbuf_subtest(void)
 	CHECK(avail_data != 3 * rec_sz,
 	      "err_ring_avail_size", "exp %ld, got %ld\n",
 	      3L * rec_sz, avail_data);
+	ring_size = ring__size(ring);
+	CHECK(ring_size != page_size,
+	      "err_ring_ring_size", "exp %ld, got %ld\n",
+	      (long)page_size, ring_size);
 	cons_pos = ring__consumer_pos(ring);
 	CHECK(cons_pos != 0,
 	      "err_ring_cons_pos", "exp %ld, got %ld\n",
-- 
2.34.1



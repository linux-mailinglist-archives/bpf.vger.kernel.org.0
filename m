Return-Path: <bpf+bounces-10114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1E97A118B
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB3A281667
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB7FDDD1;
	Thu, 14 Sep 2023 23:12:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797CD50B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:41 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670482707
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:41 -0700 (PDT)
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL93lT028253;
	Thu, 14 Sep 2023 23:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=VrfPEWAq4OgcOa0ko6k7Jvndb7aRLhovk7zAmOOZtX4=; b=rz1BuWctLz5O
	TGGTR7ZgS07z9AZgR1iDpk0FxA1q3fmFRsvdi+3f0q07PXa7jr+dzfmptNth7nVY
	nMvB5FpsgePe6fq8v75gbZ4jD1ED9X2R7lMKs/2e92MKMrtZfib92s9PAM4THPE9
	ijYZW1lEjHMrimj3JJhrjEp73+CznqavlGF7uXRhBxZXibrq+cRZPRcU9xqPKxFE
	UaLs7VKHX81hAaTkRxcvmRU/2503E94Njb1HZlE2Djv286qwsnEagsw2e0u0+P/i
	FwX1CFPSwI3exHHL+8hTtAnof/lTunC7mP6qkL5MgmeHoFMi4VXFLy3WsnbK2o/k
	FGyear3Mfg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9dedpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:26 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:24 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 14/14] selftests/bpf: add tests for ring__consume
Date: Thu, 14 Sep 2023 16:11:23 -0700
Message-ID: <20230914231123.193901-15-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: U9cFYydQenEd-DUYyWCWoJoYqihWS0fv
X-Proofpoint-ORIG-GUID: U9cFYydQenEd-DUYyWCWoJoYqihWS0fv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=797 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2309140202

Add tests for new API ring__consume.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 27149dee0e2c..ccf13f0e36c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -312,7 +312,11 @@ static void ringbuf_subtest(void)
 	 * samples, so consume them here to collect all the samples
 	 */
 	err = ring_buffer__consume(ringbuf);
-	CHECK(err < 0, "rb_consume", "failed: %d\b", err);
+	CHECK(err < 0, "ringbuffer_consume", "failed: %d\b", err);
+
+	/* also consume using ring__consume to make sure it works the same */
+	err = ring__consume(ring);
+	CHECK(err < 0, "ring_consume", "failed: %d\b", err);
 
 	/* 3 rounds, 2 samples each */
 	cnt = atomic_xchg(&sample_cnt, 0);
-- 
2.34.1



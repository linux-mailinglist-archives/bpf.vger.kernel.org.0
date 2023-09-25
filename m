Return-Path: <bpf+bounces-10787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BB7AE101
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9F7EF281F70
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF325114;
	Mon, 25 Sep 2023 21:52:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66405250FC
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:34 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAAA11F
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:33 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PEER51001812;
	Mon, 25 Sep 2023 21:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=bDw2Pl2awiN60nMJK0eNIWeQ3BOshAh1vlLDBof1OTk=; b=tMW3cE6qAbPA
	xdAPq99OzHXsY2sWPM0XVhsqrlZItXE3vK8ygx19lGM0w+CzifHCsot8YQTRYHlG
	bFvEBoJi6lEXZnyOVDWgYsDgcSpgQ3Y/+NaoVfzvh2eD6/hrigaEc0BvdCXM8Kuy
	k0/Zh/X7qKtMD2nUDWW4ttw3iEJudXvTq/nRDapIhZe0VHtdNu6l3iblv5pRsss7
	qVSDP3ck7J+rFDrTqohUTd2ksRpJ8Z5SN1oaFmxDtJJOFgHD+qmF89ULihpTb/2r
	yavE8/q3JsP41ICAWyosDZzJSxPhTetDwfZBgRKZ85fd2DghfSyyK3KYob6c5jw3
	d/NL5/McZQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3taayjmyy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:20 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:18 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 14/14] selftests/bpf: add tests for ring__consume
Date: Mon, 25 Sep 2023 14:50:45 -0700
Message-ID: <20230925215045.2375758-15-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: M7-iYYctAQngJH85ccRidHlNNazM4TrA
X-Proofpoint-GUID: M7-iYYctAQngJH85ccRidHlNNazM4TrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=843 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tests for new API ring__consume.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index c23f6c54b373..48c5695b7abf 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -304,6 +304,10 @@ static void ringbuf_subtest(void)
 	err = ring_buffer__consume(ringbuf);
 	CHECK(err < 0, "rb_consume", "failed: %d\b", err);
 
+	/* also consume using ring__consume to make sure it works the same */
+	err = ring__consume(ring);
+	ASSERT_GE(err, 0, "ring_consume");
+
 	/* 3 rounds, 2 samples each */
 	cnt = atomic_xchg(&sample_cnt, 0);
 	CHECK(cnt != 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
-- 
2.34.1



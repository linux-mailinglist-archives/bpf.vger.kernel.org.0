Return-Path: <bpf+bounces-10777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE577AE0F7
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 01E3A281153
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640A82420A;
	Mon, 25 Sep 2023 21:52:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CC2420D
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:29 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F013121
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:28 -0700 (PDT)
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PJcluV030865;
	Mon, 25 Sep 2023 21:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=a+rXgYO4GK65zO6ggrR0jbICTPYtZIKKvieFi1uaE34=; b=QkjnMiDdwdT0
	w9l2/Nh1zGsZjcaMr3bhjfkQ0QdkRxEWmtW0iT9V/Blnn1rsrOplfBwGe/k91pvI
	28i4VMMTaZzKURO9Ck/2ec0i4AmIHkxRPCtJP4uAkgTOBswSMkw8BdR68Q3bQUa5
	SXluolFrC/084T3M4zixyX29XOJ9NwMX30kWW7TG5eS7dxyfXV57k4CdsV0QJFEI
	mxxVg+AmEFevtWqRJjVoLhAlLTZuj1H23U6jKgzC2mc0ErlVy0iJhr7zR0tTayki
	kkvc+E522x37D889eNvC5nJgoNSgSbqeFtUQBu4I9HGphRhPyRiaOoJ8Pcbxfs0U
	feZQCvKUtA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3tb9ae9ngr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:16 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:14 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 10/14] selftests/bpf: add tests for ring__size
Date: Mon, 25 Sep 2023 14:50:41 -0700
Message-ID: <20230925215045.2375758-11-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: Lxyxr6MzenBjiSfWbBWpWsb_4jsPTC3Z
X-Proofpoint-GUID: Lxyxr6MzenBjiSfWbBWpWsb_4jsPTC3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=823 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add tests for the new API ring__size.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 254b25b8614c..c5be480a6ef6 100644
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
@@ -187,6 +187,8 @@ static void ringbuf_subtest(void)
 	 */
 	avail_data = ring__avail_data_size(ring);
 	ASSERT_EQ(avail_data, 3 * rec_sz, "ring_avail_size");
+	ring_size = ring__size(ring);
+	ASSERT_EQ(ring_size, page_size, "ring_ring_size");
 	cons_pos = ring__consumer_pos(ring);
 	ASSERT_EQ(cons_pos, 0, "ring_cons_pos");
 	prod_pos = ring__producer_pos(ring);
-- 
2.34.1



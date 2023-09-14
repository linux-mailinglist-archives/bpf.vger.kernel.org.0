Return-Path: <bpf+bounces-10112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE97A1188
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3141C20988
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B03DDBF;
	Thu, 14 Sep 2023 23:12:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2828D50B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:38 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FE2709
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:38 -0700 (PDT)
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8jj2017098;
	Thu, 14 Sep 2023 23:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=QBwyFplwddx7ulxwXt3kk57rIQOzdJYq+Ciie+FnD5Q=; b=mwuvRjiEQ2Sg
	yrTeRsPiVS8aYqASD0uT0Z9GuneW5iMJUOvWxqc6TsRe84c9CnrMGi16XM9yvm50
	SZvu0eFYKHS4NVJue4nz9lhDD+MaQzDkfpDpDYnJIJOKUOgDIK1az8Sa6wPpqhLk
	kELHejk+j0i4M40BIHHD9G2DxHh0kZ0690KrKZyyiT1QvRGuTJ0UXCkV7Md+a6oK
	IqtJzdm7dbt/ejKdw2SdksgG+GnHSxi5IRNoCOOvDIe0NnNWBR4af7o8NEHRkwQn
	OYaUOxlBxZ8yFddLtqdgwxF00RA6Hmvt1m99MfbBOYS8+rMD6Pau0+bBP8T+aWla
	1pzEcH2l7Q==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t2ybtx6yx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:24 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:22 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 12/14] selftests/bpf: add tests for ring__map_fd
Date: Thu, 14 Sep 2023 16:11:21 -0700
Message-ID: <20230914231123.193901-13-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: P8F9sMY_FOC1W3LxIHYCIlz6jz-7ecgo
X-Proofpoint-ORIG-GUID: P8F9sMY_FOC1W3LxIHYCIlz6jz-7ecgo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=923
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140201

Add tests for the new API ring__map_fd.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 962dc1bc5f3b..27149dee0e2c 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -92,6 +92,7 @@ static void ringbuf_subtest(void)
 	int page_size = getpagesize();
 	void *mmap_ptr, *tmp_ptr;
 	struct ring *ring;
+	int map_fd;
 	unsigned long avail_data, ring_size, cons_pos, prod_pos;
 
 	skel = test_ringbuf_lskel__open();
@@ -168,6 +169,11 @@ static void ringbuf_subtest(void)
 	if (CHECK(ring == NULL, "ringbuf_ring", "valid index returning NULL\n"))
 		goto cleanup;
 
+	map_fd = ring__map_fd(ring);
+	CHECK(map_fd != skel->maps.ringbuf.map_fd,
+	      "err_map_fd", "exp %d, got %d\n",
+	      skel->maps.ringbuf.map_fd, map_fd);
+
 	/* 2 submitted + 1 discarded records */
 	CHECK(skel->bss->avail_data != 3 * rec_sz,
 	      "err_avail_size", "exp %ld, got %ld\n",
-- 
2.34.1



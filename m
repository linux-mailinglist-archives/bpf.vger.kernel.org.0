Return-Path: <bpf+bounces-9472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF724797F4B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 01:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFC41C20AD4
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 23:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF2514A9A;
	Thu,  7 Sep 2023 23:42:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A441426E
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 23:42:13 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5851BC6
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:42:12 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 387KL0Xp020656;
	Thu, 7 Sep 2023 23:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=JjNkcXKIh
	AEmoezmKbDmTfH4rsh6tU+U8OAIsX5+T9k=; b=kq8G9L+jGbB9oXFWQnTxQVFnI
	Yme0EGKejtmb1G1eglfeW82u3RmgNm0R3Z3UD5vq2FMv6enkuNBo9rNkhcfajZL5
	hMDn6q+DDUW1iIozWlmOe22qHqfY+VF/h7jiYv+OgmS3FDchNVegMla+AhymY3h5
	pR5NIF1dw7mo61klTzkZARD7bjG9Bx9aUnqeSGMBIj7w0UVU/m14Qu58qoKH/6gn
	dDCTfkKGO+65PL1zSY/sPmPGt595cW/8MyweFvrqmkXv3kYkjl9XSmNCYPcpt8qA
	gbV94pdQUREUXJ/k56/wvims0N6SUK0BL4o+A5/gPIlJvbsnJF0PmTwyPaIcA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3sycyahn8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Sep 2023 23:41:51 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 7 Sep 2023 23:41:50 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Kelly
	<martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 0/2] add ring_buffer__query
Date: Thu, 7 Sep 2023 16:40:39 -0700
Message-ID: <20230907234041.58388-1-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: MYl30GfQb760A8xWFO9wCEYFGaGjAOBs
X-Proofpoint-ORIG-GUID: MYl30GfQb760A8xWFO9wCEYFGaGjAOBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 mlxlogscore=637 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309070208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a ring_buffer__query function mimicking the existing bpf_ringbuf_query
helper but accessible from usermode. This can be useful for programs to query
ringbuffer information at runtime, e.g. seeing how much free space the
ringbuffers currently have.

Martin Kelly (2):
  libbpf: add ring_buffer__query
  selftests/bpf: add tests for ring_buffer__query

 tools/lib/bpf/libbpf.h                        |  2 ++
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/lib/bpf/ringbuf.c                       | 33 +++++++++++++++++++
 .../selftests/bpf/prog_tests/ringbuf.c        | 22 +++++++++++++
 4 files changed, 58 insertions(+)

-- 
2.34.1



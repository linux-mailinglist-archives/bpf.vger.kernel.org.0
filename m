Return-Path: <bpf+bounces-10100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AC37A1177
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAC9282280
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82720D30A;
	Thu, 14 Sep 2023 23:12:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908B33F2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:31 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55DE1BFA
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:30 -0700 (PDT)
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8jj0017098;
	Thu, 14 Sep 2023 23:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=HHfUMBfHd
	3sOc4eCmcNWhBk1jB7nHOmKYKkRPXMcQ2c=; b=yqDS9QP4EKmNoC8ani4HEXg7G
	FBm8saDffyaJMTfB3xk+MaMdIf84B/ZY7NO+ETgKD/Lp5Z/6b0eNrS9lfFvUDaL+
	8XUnS7RYmH+Ky5fTzpCSLjPNqDqDa20k47viSQkPnmE6QI6A2ZK/5maK8aK1BP0J
	1QY0vWOEbVJln3VAnOT12yJt0a1+ZPDYIiGQisIaYcma4KdNg4XowOLscdrJYbrg
	hHFb2BcUdMf0Q/xS8GYyTHv/dGsdU7Ljh/MIJyLDJ90hoeCrCRmojqOYZeeF0L1q
	+tyBCda1gcF0ijkKZ2dVBHW1zNc7TwvOFLMyPTfj3UAN3KhLM1PfFzIhIlsRA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t2ybtx6yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:10 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:08 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 00/14] add libbpf getters for individual ringbuffers
Date: Thu, 14 Sep 2023 16:11:09 -0700
Message-ID: <20230914231123.193901-1-martin.kelly@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH12.crowdstrike.sys (10.100.11.116) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-GUID: 9dcksltxV32ZX9IkKTHH7XWDP8cRiEBy
X-Proofpoint-ORIG-GUID: 9dcksltxV32ZX9IkKTHH7XWDP8cRiEBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=906
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140201

This patch series adds a new ring__ API to libbpf exposing getters for accessing
the individual ringbuffers inside a struct ring_buffer. This is useful for
polling individually, getting available data, or similar use cases. The API
looks like this, and was roughly proposed by Andrii Nakryiko in another thread:

Getting a ring struct:
struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx);

Using the ring struct:
unsigned long ring__consumer_pos(const struct ring *r);
unsigned long ring__producer_pos(const struct ring *r);
size_t ring__avail_data_size(const struct ring *r);
size_t ring__size(const struct ring *r);
int ring__map_fd(const struct ring *r);
int ring__consume(struct ring *r);

Martin Kelly (14):
  libbpf: refactor cleanup in ring_buffer__add
  libbpf: switch rings to array of pointers
  libbpf: add ring_buffer__ring
  selftests/bpf: add tests for ring_buffer__ring
  libbpf: add ring__producer_pos, ring__consumer_pos
  selftests/bpf: add tests for ring__*_pos
  libbpf: add ring__avail_data_size
  selftests/bpf: add tests for ring__avail_data_size
  libbpf: add ring__size
  selftests/bpf: add tests for ring__size
  libbpf: add ring__map_fd
  selftests/bpf: add tests for ring__map_fd
  libbpf: add ring__consume
  selftests/bpf: add tests for ring__consume

 tools/lib/bpf/libbpf.h                        | 68 +++++++++++++++
 tools/lib/bpf/libbpf.map                      |  7 ++
 tools/lib/bpf/ringbuf.c                       | 87 +++++++++++++++----
 .../selftests/bpf/prog_tests/ringbuf.c        | 38 +++++++-
 .../selftests/bpf/prog_tests/ringbuf_multi.c  | 16 ++++
 5 files changed, 199 insertions(+), 17 deletions(-)

-- 
2.34.1



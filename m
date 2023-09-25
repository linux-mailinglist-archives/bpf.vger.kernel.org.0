Return-Path: <bpf+bounces-10776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97AF7AE0F6
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1ADBE2817B8
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CBA24207;
	Mon, 25 Sep 2023 21:52:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C52420C
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:29 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B600AF
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:28 -0700 (PDT)
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PEcdfl018150;
	Mon, 25 Sep 2023 21:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=NgLyr5aHb
	9TYYydwVYjiQcM46l/frgZXX9eFVzO8l+4=; b=V50mjv+pwaEOKBy9obajTQzxe
	59cf0+rsSPxFyl5WBwK71EOSufyOnoy+8rsx+2KD7zzca3iqhZidMWlOMO9h5qb8
	v6509+fzsrdXb3d/c7Swd6xPWV1+tPEdrXmoRsmPOVhvSRJbaN1tE63cEzSGDtJ5
	SOeAluoLTXEiUzTZo3IYmj31eIO5C8L4g79E0kMZoHWPFE4kSll71mZrTEja864n
	bVuVz65WmolfIUb0yL7zw75Fydsc3Gm9hnylJ9oQZiJSZ8sEOC2bi1JUFii8kA9G
	EkXP3STpRBgWtQOLU7Ep3Ey2wG2IyHVaHL5Nt0QZMfzEMcckprdp8XgIejITA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3taatvvybd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:05 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:03 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 00/14] add libbpf getters for individual ringbuffers
Date: Mon, 25 Sep 2023 14:50:31 -0700
Message-ID: <20230925215045.2375758-1-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: ewRFsK7hR83oq_cYLGfgjC5fbB4g1vzB
X-Proofpoint-ORIG-GUID: ewRFsK7hR83oq_cYLGfgjC5fbB4g1vzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=927
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series adds a new ring__ API to libbpf exposing getters for
accessing the individual ringbuffers inside a struct ring_buffer. This is
useful for polling individually, getting available data, or similar use
cases. The API looks like this, and was roughly proposed by Andrii Nakryiko
in another thread:

Getting a ring struct:
struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx);

Using the ring struct:
unsigned long ring__consumer_pos(const struct ring *r);
unsigned long ring__producer_pos(const struct ring *r);
size_t ring__avail_data_size(const struct ring *r);
size_t ring__size(const struct ring *r);
int ring__map_fd(const struct ring *r);
int ring__consume(struct ring *r);

Changes in v2:
- Addressed all feedback from Andrii Nakryiko

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

 tools/lib/bpf/libbpf.h                        | 73 ++++++++++++++++
 tools/lib/bpf/libbpf.map                      |  7 ++
 tools/lib/bpf/ringbuf.c                       | 85 ++++++++++++++++---
 .../selftests/bpf/prog_tests/ringbuf.c        | 26 ++++++
 .../selftests/bpf/prog_tests/ringbuf_multi.c  | 15 ++++
 5 files changed, 193 insertions(+), 13 deletions(-)

-- 
2.34.1



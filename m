Return-Path: <bpf+bounces-9474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24B797F4C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 01:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB2A1C20B7F
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247A414AA2;
	Thu,  7 Sep 2023 23:42:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E9914A9D
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 23:42:14 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7171BD3
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:42:13 -0700 (PDT)
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 387GvAtM021267;
	Thu, 7 Sep 2023 23:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=oXT3tCQf+HMM+M0J1xLiShITznYZpY7YxbJRw5eV81M=; b=dyJq0MEXeuZw
	+jjqr9rE7qFtx/uRzf0cXAOSFIdynA2zPdfTg4BRMSpk4I1yQiuemMx3jFxJBigV
	bZLH+61RQGL3PzxHIpWclteCLM65BAnlk8jR0yC2dyWPzP6S3nJML+Yd+dJMNfak
	PPYzEC/jxSls1F8BQXyG+o+yhwmOX92W2rm5DvoWOHdQyyXRjOa1NMgKm/srcCOy
	rpfgcv7Ju1Cf3gNCw4N240pW6RbotR4syRoT6I8G1d6yVfZ46gBda4+hdVD0UBwq
	+H2xdOQoORYprbl3n3Wu14pGw3VimAbDeWkm1kbR68dJGhwxLBznGKjL7/KAI93s
	ccpsAjZPCA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3syjg4gsuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Sep 2023 23:41:57 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 7 Sep 2023 23:41:55 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Kelly
	<martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 1/2] libbpf: add ring_buffer__query
Date: Thu, 7 Sep 2023 16:40:40 -0700
Message-ID: <20230907234041.58388-2-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907234041.58388-1-martin.kelly@crowdstrike.com>
References: <20230907234041.58388-1-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: 2ywK5kpBgxDOQRM2XE6rSxDd0l2DuZYI
X-Proofpoint-ORIG-GUID: 2ywK5kpBgxDOQRM2XE6rSxDd0l2DuZYI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=994 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2309070208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ring_buffer__query to fetch ringbuffer information from userspace,
working the same as the bpf_ringbuf_query helper.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   |  2 ++
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0e52621cba43..4ceed3ffabc2 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1248,6 +1248,8 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
+LIBBPF_API __u64 ring_buffer__query(struct ring_buffer *rb, unsigned int index,
+				    __u64 flags);
 
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 57712321490f..cbb3dc39446e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,4 +400,5 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		ring_buffer__query;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db13..85ccac7a2db3 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -69,6 +69,15 @@ static void ringbuf_unmap_ring(struct ring_buffer *rb, struct ring *r)
 	}
 }
 
+static unsigned long ringbuf_avail_data_sz(struct ring *r)
+{
+	unsigned long cons_pos, prod_pos;
+
+	cons_pos = smp_load_acquire(r->consumer_pos);
+	prod_pos = smp_load_acquire(r->producer_pos);
+	return prod_pos - cons_pos;
+}
+
 /* Add extra RINGBUF maps to this ring buffer manager */
 int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 		     ring_buffer_sample_fn sample_cb, void *ctx)
@@ -323,6 +332,30 @@ int ring_buffer__epoll_fd(const struct ring_buffer *rb)
 	return rb->epoll_fd;
 }
 
+/* A userspace analogue to bpf_ringbuf_query for a particular ringbuffer index
+ * managed by this ringbuffer manager. Flags has the same arguments as
+ * bpf_ringbuf_query, and the index given is a 0-based index tracking the order
+ * the ringbuffers were added via ring_buffer__add. Returns the data requested
+ * according to flags.
+ */
+__u64 ring_buffer__query(struct ring_buffer *rb, unsigned int index, __u64 flags)
+{
+	struct ring *ring = &rb->rings[index];
+
+	switch (flags) {
+	case BPF_RB_AVAIL_DATA:
+		return ringbuf_avail_data_sz(ring);
+	case BPF_RB_RING_SIZE:
+		return ring->mask + 1;
+	case BPF_RB_CONS_POS:
+		return smp_load_acquire(ring->consumer_pos);
+	case BPF_RB_PROD_POS:
+		return smp_load_acquire(ring->producer_pos);
+	default:
+		return 0;
+	}
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.34.1



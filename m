Return-Path: <bpf+bounces-10105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1687A117E
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26975282271
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE0D52C;
	Thu, 14 Sep 2023 23:12:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB672D2F0
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:32 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AE32709
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:32 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8dDl002136;
	Thu, 14 Sep 2023 23:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=SQP4iEAw/GljMVcq4u4y5F3eR/d7O4E/fRrndxsgaVQ=; b=UAn4d3kSzeTP
	XeCiNk+1TcQf/mpqoSWrCGbc7fkeu30XWu2fHeQgWO1G4XRqh12lr0OAN6DGOt0Q
	9s2Q+3KmUGnOBSy8nywfiSsJULmwnMUXPcYLQQHLcO9m0OqCo9JEPzlHSQ05rTOX
	OoEkhDLMfX8ZpdWLCKDKZQ3O4GxNdteJmFv7pDLEcfxsqhKX2P5BtLzl/XLJg/zN
	Nffla6Xvgmh5/C2OeUPYNqI/aos+5QTRNjWIAK8sLIBs9BMMkIT2kaTiWIAdR8rd
	BDbEhpaCtnN9RLMiV0KWCXlvOl9g9N0FCU8JcTIFWUq8wn+Bf47h1PbArbVrhkw4
	uRpf07al8Q==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9966n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:12 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:11 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 02/14] libbpf: switch rings to array of pointers
Date: Thu, 14 Sep 2023 16:11:11 -0700
Message-ID: <20230914231123.193901-3-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: 6nRTDrdXyDj9HKa3uXF30XXMvq2fui11
X-Proofpoint-ORIG-GUID: 6nRTDrdXyDj9HKa3uXF30XXMvq2fui11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140202

Switch rb->rings to be an array of pointers instead of a contiguous
block. This allows for each ring pointer to be stable after
ring_buffer__add is called, which allows us to expose struct ring * to
the user without gotchas. Without this change, the realloc in
ring_buffer__add could invalidate a struct ring *, making it unsafe to
give to the user.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/ringbuf.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index f2020807996c..c2c79e10cfea 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -34,7 +34,7 @@ struct ring {
 
 struct ring_buffer {
 	struct epoll_event *events;
-	struct ring *rings;
+	struct ring **rings;
 	size_t page_size;
 	int epoll_fd;
 	int ring_cnt;
@@ -57,7 +57,7 @@ struct ringbuf_hdr {
 	__u32 pad;
 };
 
-static void ringbuf_unmap_ring(struct ring_buffer *rb, struct ring *r)
+static void ringbuf_free_ring(struct ring_buffer *rb, struct ring *r)
 {
 	if (r->consumer_pos) {
 		munmap(r->consumer_pos, rb->page_size);
@@ -67,6 +67,8 @@ static void ringbuf_unmap_ring(struct ring_buffer *rb, struct ring *r)
 		munmap(r->producer_pos, rb->page_size + 2 * (r->mask + 1));
 		r->producer_pos = NULL;
 	}
+
+	free(r);
 }
 
 /* Add extra RINGBUF maps to this ring buffer manager */
@@ -107,8 +109,10 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 		return libbpf_err(-ENOMEM);
 	rb->events = tmp;
 
-	r = &rb->rings[rb->ring_cnt];
-	memset(r, 0, sizeof(*r));
+	r = calloc(1, sizeof(*r));
+	if (!r)
+		return libbpf_err(-ENOMEM);
+	rb->rings[rb->ring_cnt] = r;
 
 	r->map_fd = map_fd;
 	r->sample_cb = sample_cb;
@@ -159,7 +163,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 
 err_out:
 	err = -errno;
-	ringbuf_unmap_ring(rb, r);
+	ringbuf_free_ring(rb, r);
 	return libbpf_err(err);
 }
 
@@ -171,7 +175,7 @@ void ring_buffer__free(struct ring_buffer *rb)
 		return;
 
 	for (i = 0; i < rb->ring_cnt; ++i)
-		ringbuf_unmap_ring(rb, &rb->rings[i]);
+		ringbuf_free_ring(rb, rb->rings[i]);
 	if (rb->epoll_fd >= 0)
 		close(rb->epoll_fd);
 
@@ -279,7 +283,7 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	int i;
 
 	for (i = 0; i < rb->ring_cnt; i++) {
-		struct ring *ring = &rb->rings[i];
+		struct ring *ring = rb->rings[i];
 
 		err = ringbuf_process_ring(ring);
 		if (err < 0)
@@ -306,7 +310,7 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 
 	for (i = 0; i < cnt; i++) {
 		__u32 ring_id = rb->events[i].data.fd;
-		struct ring *ring = &rb->rings[ring_id];
+		struct ring *ring = rb->rings[ring_id];
 
 		err = ringbuf_process_ring(ring);
 		if (err < 0)
-- 
2.34.1



Return-Path: <bpf+bounces-10778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C77AE0F8
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B891A281A7F
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21C250EC;
	Mon, 25 Sep 2023 21:52:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441124212
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:30 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA3E11F
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:28 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PEYNow032155;
	Mon, 25 Sep 2023 21:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=aW0HDDBA4c83GEOOknjkukcLXuT9U0g63V3k85Li8jc=; b=LpObpGzwwvmQ
	pMZy5jqjvnDcYTYlG40GSK9CdNS6nsi1eFeTK4/NUrPbDvyeEhJ8FdhwvZCtSVfX
	9T4BOCMqHIL8M0ANH+wk5EXabIu6l3oxMIqG+G5VCora4wMl+bIgbqSxFNgTHt/A
	dDboocPQF03fRCvwYJjSej074h0XAuRvv+u2uxwK4ctA184Z21v6LYV1b96Tc7uh
	NBGOt99tNA1UiDJniLtaniPOoLKG5JCSbZVRfpPuybTOjFdQWYK6VosyxMNTJcuF
	4LnIjJ9k3t/WuosMV/epnhERSXytI9dC/28kejkc0UaLljoOhpQMJPyp5kdoM59P
	AyXEj1frbg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3taayjmyxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:07 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:05 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 02/14] libbpf: switch rings to array of pointers
Date: Mon, 25 Sep 2023 14:50:33 -0700
Message-ID: <20230925215045.2375758-3-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: -0ejOJh8YP1_pnM3TiT3hq9ehan_Wt34
X-Proofpoint-GUID: -0ejOJh8YP1_pnM3TiT3hq9ehan_Wt34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 29b0d19d920f..94d11fb44a49 100644
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
@@ -161,7 +165,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	return 0;
 
 err_out:
-	ringbuf_unmap_ring(rb, r);
+	ringbuf_free_ring(rb, r);
 	return libbpf_err(err);
 }
 
@@ -173,7 +177,7 @@ void ring_buffer__free(struct ring_buffer *rb)
 		return;
 
 	for (i = 0; i < rb->ring_cnt; ++i)
-		ringbuf_unmap_ring(rb, &rb->rings[i]);
+		ringbuf_free_ring(rb, rb->rings[i]);
 	if (rb->epoll_fd >= 0)
 		close(rb->epoll_fd);
 
@@ -281,7 +285,7 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	int i;
 
 	for (i = 0; i < rb->ring_cnt; i++) {
-		struct ring *ring = &rb->rings[i];
+		struct ring *ring = rb->rings[i];
 
 		err = ringbuf_process_ring(ring);
 		if (err < 0)
@@ -308,7 +312,7 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 
 	for (i = 0; i < cnt; i++) {
 		__u32 ring_id = rb->events[i].data.fd;
-		struct ring *ring = &rb->rings[ring_id];
+		struct ring *ring = rb->rings[ring_id];
 
 		err = ringbuf_process_ring(ring);
 		if (err < 0)
-- 
2.34.1



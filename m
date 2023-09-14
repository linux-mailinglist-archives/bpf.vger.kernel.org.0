Return-Path: <bpf+bounces-10108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFAB7A1182
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB936282270
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD05DDA5;
	Thu, 14 Sep 2023 23:12:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABDD50B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:35 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ECF2711
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:34 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8YFb001185;
	Thu, 14 Sep 2023 23:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=weyxGZ+zIAZpTxNjkrw+h0hb9W7VWwg5fe+e8YDoqeo=; b=nxY78WPqGabZ
	B835BAoYTgMt4DhyzKesKlum64HTSZkwQQHRV+eOrbVscwN49TgLQvvMqDmY+WjG
	QR/e9KAOba8WCb2XA81i0+ju0B5+zu3M0TBJny109+YojD+kFCuhJSYPPhI3vs+D
	fdiBWkBTVPuKYPZ1GGfvGSRRYcCMQpsihwsDgPnrhYsvS5gxBsIBS45zW5vwdfvL
	7SqYh3rPFnSsV12deK+JnctD9xgLszhBoBpfMYAxymQG0iRsVv2CzntUuRQ52A/r
	F4qxGjcVY8eRA5FSEkbObGF/5k1/fphAQHlEjXHc8h2F/LFlK+Vc0xCmQNbwc3Bl
	3p5CUkb7Pw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9fpcp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:16 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:14 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 05/14] libbpf: add ring__producer_pos, ring__consumer_pos
Date: Thu, 14 Sep 2023 16:11:14 -0700
Message-ID: <20230914231123.193901-6-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: sbBV6UewNuLk2BjQq2O4BY06yYWwd1y4
X-Proofpoint-GUID: sbBV6UewNuLk2BjQq2O4BY06yYWwd1y4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=841 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2309140202

Add APIs to get the producer and consumer position for a given
ringbuffer.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/ringbuf.c  | 14 ++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2d6c39e20863..935162dbb3bf 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1263,6 +1263,22 @@ LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 LIBBPF_API struct ring *ring_buffer__ring(struct ring_buffer *rb,
 					  unsigned int idx);
 
+/**
+ * @brief **ring__consumer_pos()** returns the current consumer position.
+ *
+ * @param r A ring object.
+ * @return The current consumer position.
+ */
+LIBBPF_API unsigned long ring__consumer_pos(const struct ring *r);
+
+/**
+ * @brief **ring__producer_pos()** returns the current producer position.
+ *
+ * @param r A ring object.
+ * @return The current producer position.
+ */
+LIBBPF_API unsigned long ring__producer_pos(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7a7370c2bc25..1c532fe7a445 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -401,4 +401,6 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
 		ring_buffer__ring;
+		ring__consumer_pos;
+		ring__producer_pos;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 2857df0f2d03..54c596db57a4 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -336,6 +336,20 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
 	return rb->rings[idx];
 }
 
+unsigned long ring__consumer_pos(const struct ring *r)
+{
+	/* Synchronizes with smp_store_release() in ringbuf_process_ring(). */
+	return smp_load_acquire(r->consumer_pos);
+}
+
+unsigned long ring__producer_pos(const struct ring *r)
+{
+	/* Synchronizes with smp_store_release() in __bpf_ringbuf_reserve() in
+	 * the kernel.
+	 */
+	return smp_load_acquire(r->producer_pos);
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.34.1



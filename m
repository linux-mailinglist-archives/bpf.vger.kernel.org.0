Return-Path: <bpf+bounces-10781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343E7AE0FB
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3F19C281A0A
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA8250FF;
	Mon, 25 Sep 2023 21:52:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49E2421E
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:31 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315A6126
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:29 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PFRvLr007108;
	Mon, 25 Sep 2023 21:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=39xGN0YT7tclBFE+BEooISMWhOCQKPLKqMXlIycZuUs=; b=uMaFzrLE/Pvu
	cRt0WrswyJzqGl+HSx2nAuQFlYhK2Z1XSUxttFL0vFkbkZUFpifUqLaxehJSEbNZ
	/y/6LLc9ZLe9t7WscbtTn9NYVJIrIxVSQaW+He7TJNj9QmsYrevgGS3V/818/3C3
	DRBnGWpaiuGqtDM7iAmD/Y3HYzGCaGFX34xHWakcjwhpUjKlOXl+0jvxEQ6prXPm
	gKd4S9D3cc9gVorctcvZbT4rfR9/DB1QyVkSdXVzt7fOeKj4dleeIXQ9P3zjptju
	DXJq189wMxnOYfIBRxvlkKvE4Gee5xJfgC5EOJ+TtGJ+0uEJVO6EieU9aWQMijy/
	eu7FVJ+eJg==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3tab8xcpjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:10 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:09 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 05/14] libbpf: add ring__producer_pos, ring__consumer_pos
Date: Mon, 25 Sep 2023 14:50:36 -0700
Message-ID: <20230925215045.2375758-6-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: uc80B6T8sl-WOCH6jH1fwcm6nx3vOKqy
X-Proofpoint-ORIG-GUID: uc80B6T8sl-WOCH6jH1fwcm6nx3vOKqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=830 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add APIs to get the producer and consumer position for a given
ringbuffer.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 18 ++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/ringbuf.c  | 14 ++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index de3ef59b9641..ab470179b7fe 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1264,6 +1264,24 @@ LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 LIBBPF_API struct ring *ring_buffer__ring(struct ring_buffer *rb,
 					  unsigned int idx);
 
+/**
+ * @brief **ring__consumer_pos()** returns the current consumer position in the
+ * given ringbuffer.
+ *
+ * @param r A ringbuffer object.
+ * @return The current consumer position.
+ */
+LIBBPF_API unsigned long ring__consumer_pos(const struct ring *r);
+
+/**
+ * @brief **ring__producer_pos()** returns the current producer position in the
+ * given ringbuffer.
+ *
+ * @param r A ringbuffer object.
+ * @return The current producer position.
+ */
+LIBBPF_API unsigned long ring__producer_pos(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7a7370c2bc25..3bec002449d5 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,5 +400,7 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		ring__consumer_pos;
+		ring__producer_pos;
 		ring_buffer__ring;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index efde453395b0..d14a607f6b66 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -338,6 +338,20 @@ struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
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



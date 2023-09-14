Return-Path: <bpf+bounces-10101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637197A117A
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE4C282289
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5A6D505;
	Thu, 14 Sep 2023 23:12:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54311CA64
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:32 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58A270A
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:31 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8nlh001980;
	Thu, 14 Sep 2023 23:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=R4+yoAEM79jcxe8kOCqRQxtZAWTFTTDFOkFWMt9EKN4=; b=RA8xWqFybRPw
	2SptNA0Jsn3JBzeq9tdKIyoyNvuNCtXMu5F7D7KHGhxG5p6wglT1kLJhzXE+H9zR
	VxHCk1CnCbE5JPcaUh8/IYVIyCtTpDqkUS6j98d2RXuMDxigfl02rvyUXKTIX2eP
	Ut/nobhJkBRzG0HSU4qGDRQ5Nxy6o9IKkuLfRoqFnxZYyiOwadofP9RJbZYdy8n1
	gkQRXEESvDIuuGzYpRpN3SUiA+rIYiiR7jMHBScu3PuPJ9uDgepWe1a5Ih7aV8ha
	0QZLOo69ZdOO8PRiFK1L/sAw6G8iZTzti4SK3L66sCp1Ef16VUlwS5OFn/rW6DOZ
	23TawU7NBA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9fpcp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:18 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:16 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 07/14] libbpf: add ring__avail_data_size
Date: Thu, 14 Sep 2023 16:11:16 -0700
Message-ID: <20230914231123.193901-8-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: K4PTiDE5R7MyH4LjH6Y_mRq1YbYFXebp
X-Proofpoint-GUID: K4PTiDE5R7MyH4LjH6Y_mRq1YbYFXebp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=874 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2309140202

Add ring__avail_data_size for querying the currently available data in
the ringbuffer, similar to the BPF_RB_AVAIL_DATA flag in
bpf_ringbuf_query. This is racy during ongoing operations but is still
useful for overall information on how a ringbuffer is behaving.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 11 +++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 935162dbb3bf..87e3bad37737 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1279,6 +1279,17 @@ LIBBPF_API unsigned long ring__consumer_pos(const struct ring *r);
  */
 LIBBPF_API unsigned long ring__producer_pos(const struct ring *r);
 
+/**
+ * @brief **ring__avail_data_size()** returns the number of bytes in this
+ * ringbuffer not yet consumed. This has no locking associated with it, so it
+ * can be inaccurate if operations are ongoing while this is called. However, it
+ * should still show the correct trend over the long-term.
+ *
+ * @param r A ring object.
+ * @return The number of bytes not yet consumed.
+ */
+LIBBPF_API size_t ring__avail_data_size(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1c532fe7a445..f66d7f0bc224 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -401,6 +401,7 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
 		ring_buffer__ring;
+		ring__avail_data_size;
 		ring__consumer_pos;
 		ring__producer_pos;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 54c596db57a4..f51ad1af6ab8 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -350,6 +350,11 @@ unsigned long ring__producer_pos(const struct ring *r)
 	return smp_load_acquire(r->producer_pos);
 }
 
+size_t ring__avail_data_size(const struct ring *r)
+{
+	return ring__producer_pos(r) - ring__consumer_pos(r);
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.34.1



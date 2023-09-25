Return-Path: <bpf+bounces-10779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA0F7AE0F9
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id DF22C1C20919
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C324210;
	Mon, 25 Sep 2023 21:52:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5124217
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:30 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECC1120
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:28 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PEjCW7013860;
	Mon, 25 Sep 2023 21:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=G/8+UC2KpNIesKKY6ckrfrdiwxKXxs3rfIs2PjH6V8I=; b=gjD/OftGQCEm
	lK64eOHDS8qVLln4+jvRgnW7eHZQ5yS6XRGIg5syz1yeAnAKfvjDbfZfV1KGyzNM
	+M4ajfpgE1/8wrJSvt8TlATi4KvrElD/+ka7LsW45FLlj6R5E6MCSHUs8rwPDiOo
	hQGwtNHh6pUqwutFdH+wuaY75TLv15ie3Vdg2RscrT4eOp3Wl+lcp5XkDHHpJcCA
	K1LESdlxFigMmkCgylbntpgACS0dItnTLuBSNFuLTmIreL8lwFnzTEVKoHNvM57z
	ojMMjLAuaXZ0ZGo6sZXDrVeGG49EyI9pS31iQccXER+SQYjxUJuSR2JWux1uxxIM
	WVSfnZ25Qw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3taayjmyy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:15 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:13 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 09/14] libbpf: add ring__size
Date: Mon, 25 Sep 2023 14:50:40 -0700
Message-ID: <20230925215045.2375758-10-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: bcOrXlenA69PSpF5SgoUuvHlz0YedpnY
X-Proofpoint-GUID: bcOrXlenA69PSpF5SgoUuvHlz0YedpnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=956 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ring__size to get the total size of a given ringbuffer.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 10 ++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  |  5 +++++
 3 files changed, 16 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d60254c5edc6..53e2a645c560 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1293,6 +1293,16 @@ LIBBPF_API unsigned long ring__producer_pos(const struct ring *r);
  */
 LIBBPF_API size_t ring__avail_data_size(const struct ring *r);
 
+/**
+ * @brief **ring__size()** returns the total size of the ringbuffer's map data
+ * area (excluding special producer/consumer pages). Effectively this gives the
+ * amount of usable bytes of data inside the ringbuffer.
+ *
+ * @param r A ringbuffer object.
+ * @return The total size of the ringbuffer map data area.
+ */
+LIBBPF_API size_t ring__size(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5184c94c0502..a116d0bb3c5d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -403,5 +403,6 @@ LIBBPF_1.3.0 {
 		ring__avail_data_size;
 		ring__consumer_pos;
 		ring__producer_pos;
+		ring__size;
 		ring_buffer__ring;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 07fbc6adcdd9..98d0767dbb50 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -361,6 +361,11 @@ size_t ring__avail_data_size(const struct ring *r)
 	return prod_pos - cons_pos;
 }
 
+size_t ring__size(const struct ring *r)
+{
+	return r->mask + 1;
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.34.1



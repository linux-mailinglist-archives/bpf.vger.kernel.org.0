Return-Path: <bpf+bounces-10111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B727A1187
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC16282188
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674CFDDBA;
	Thu, 14 Sep 2023 23:12:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F36BDDA1
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:38 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369991BFA
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:38 -0700 (PDT)
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8jj1017098;
	Thu, 14 Sep 2023 23:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=+M1vRc/4xHORdUwzGt3H4oXGfvUpu2T9wLydZea1Dgg=; b=dDfU9xdtagps
	wIY0m4T8VZ1z7M+5I5qneSe7EmPRabx8dQi1UBOdrJT6soCvZy3/iGMUop+416fD
	sOsIBVq/VULsK3yN1EPkB60jIUf1tsEBiJXhP+wL0whxPJfYmR87mHmW/KlcLiVY
	3vxq2v97vIXfCLeQ/WGEcY3JIqGCKDGL0Y6AqMUml9JdFGFvbl7OjJ4z22ylfdsq
	VZXtIjrEaBfGOn/bd0T1DO1NEAZTlCGbtzG3b9YTsvJt2wGOo6onIfIQztjIZMui
	nkPN7pbW88OetDqX682ZINmn7hIfomBx9sMqlI9+GE8F4eyp/gZwQTp8gH20GZ3P
	4ZhYALbcDw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3t2ybtx6yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:23 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:21 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 11/14] libbpf: add ring__map_fd
Date: Thu, 14 Sep 2023 16:11:20 -0700
Message-ID: <20230914231123.193901-12-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: v4asiSnA8PU1yUlPsTqfoFeNFuet0lQk
X-Proofpoint-ORIG-GUID: v4asiSnA8PU1yUlPsTqfoFeNFuet0lQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=943
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140201

Add ring__map_fd to get the file descriptor underlying a given
ringbuffer.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 9 +++++++++
 tools/lib/bpf/libbpf.map | 1 +
 tools/lib/bpf/ringbuf.c  | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 299d98402ad4..d2a237086c2c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1298,6 +1298,15 @@ LIBBPF_API size_t ring__avail_data_size(const struct ring *r);
  */
 LIBBPF_API size_t ring__size(const struct ring *r);
 
+/**
+ * @brief **ring__map_fd()** returns the file descriptor underlying the given
+ * ringbuffer.
+ *
+ * @param r A ring object.
+ * @return The underlying ringbuffer file descriptor
+ */
+LIBBPF_API int ring__map_fd(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 4ca77e715667..13800b73c343 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -403,6 +403,7 @@ LIBBPF_1.3.0 {
 		ring_buffer__ring;
 		ring__avail_data_size;
 		ring__consumer_pos;
+		ring__map_fd;
 		ring__producer_pos;
 		ring__size;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 52c385195f32..2dba2836d85b 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -360,6 +360,11 @@ size_t ring__size(const struct ring *r)
 	return r->mask + 1;
 }
 
+int ring__map_fd(const struct ring *r)
+{
+	return r->map_fd;
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.34.1



Return-Path: <bpf+bounces-10783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DEF7AE0FD
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D1060281C0A
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D82421F;
	Mon, 25 Sep 2023 21:52:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C5250E3
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:32 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45C112
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:30 -0700 (PDT)
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PEC9Wj023153;
	Mon, 25 Sep 2023 21:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=DekCw+Oeo9KDW9kCjnfpOUz6j1k/JxNmOvdZTxQuiMQ=; b=AWSNUSLauJEi
	woZmEz6dkAvNlwyrrNuDSvnfcH0I3GMQmR41yhs6PZwfDNAR8w5FkuPzWAYZYoii
	OPDFGg7KBuQbc7LzxC5RltyDRxksESmBcJavrGTswtg0ugMiESqUsA9kQh31mX5O
	wXYDvhHpaeTREWaOP0WH4g6uMjtVys3BFwLsmIphGivfbf81Xp8E7duQgw8+59b+
	Cbe8W9U6KtIedgWi3I0k0HNngjsRjIcwXc8snGHbbc2L1nHOsWAOXnZ2DDuroZIt
	gaOro00CZ/Y4yUqhMuTWBDDk8AMqS/5lQJ1wBlJE77+c/60/Y5KeWrWoyrJTko30
	zhRSlh9yLA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3taatvvybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:17 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:15 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 11/14] libbpf: add ring__map_fd
Date: Mon, 25 Sep 2023 14:50:42 -0700
Message-ID: <20230925215045.2375758-12-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: NrOmeAaS2k9nDNv-gd9sANbACGEMUk4U
X-Proofpoint-ORIG-GUID: NrOmeAaS2k9nDNv-gd9sANbACGEMUk4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=895
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ring__map_fd to get the file descriptor underlying a given
ringbuffer.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 9 +++++++++
 tools/lib/bpf/libbpf.map | 1 +
 tools/lib/bpf/ringbuf.c  | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 53e2a645c560..114e306c6507 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1303,6 +1303,15 @@ LIBBPF_API size_t ring__avail_data_size(const struct ring *r);
  */
 LIBBPF_API size_t ring__size(const struct ring *r);
 
+/**
+ * @brief **ring__map_fd()** returns the file descriptor underlying the given
+ * ringbuffer.
+ *
+ * @param r A ringbuffer object.
+ * @return The underlying ringbuffer file descriptor
+ */
+LIBBPF_API int ring__map_fd(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a116d0bb3c5d..1b4225327ab6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -402,6 +402,7 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_uprobe_multi;
 		ring__avail_data_size;
 		ring__consumer_pos;
+		ring__map_fd;
 		ring__producer_pos;
 		ring__size;
 		ring_buffer__ring;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 98d0767dbb50..8aec20216b7b 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -366,6 +366,11 @@ size_t ring__size(const struct ring *r)
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



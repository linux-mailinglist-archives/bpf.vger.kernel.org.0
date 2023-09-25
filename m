Return-Path: <bpf+bounces-10780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD57AE0FA
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 543BD1C20864
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E19250FA;
	Mon, 25 Sep 2023 21:52:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265324216
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:30 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EAC124
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:28 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PEQxeW025692;
	Mon, 25 Sep 2023 21:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=AfSJ6rNMJSOm7YNpC/uAinPGG72J5dg3ndCToaP6cFA=; b=rPNxX4G9zI+E
	e2bruCf4LfTW8Ke0lnPCHbfIuf6eRiAhG5X5eehVxdbYLqxdkMg8wg+qegG8odNY
	81abnAsA0k/kRv3Mb+6N5W7NbqI9XyFNjCyU0Ua6h6D6Hq/rFyQIfWuV097z8qc+
	ONAEhhw7qTj57IBgIESz8Lvsnz0yqFa3H5He/jafx3tw2HpqyKlxrqyV6IDC8atA
	IRMQh2nQkiJs4sWQpkZw7FwaFvCL3fin6xYtzWdRjuxXS/wWimnY/2eKnta12Lg5
	Y6Bycbfdc03E4JI1nZMAoABvMwji8P+EHTym3QOyapNJWNLCTPq7cW4c8kFQ3cnw
	xBRPMRlvQQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3tab8xcpjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:08 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:06 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 03/14] libbpf: add ring_buffer__ring
Date: Mon, 25 Sep 2023 14:50:34 -0700
Message-ID: <20230925215045.2375758-4-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: VM1ZWLZWHyIMWrRL-TSW_k5xNxPS4Y4a
X-Proofpoint-ORIG-GUID: VM1ZWLZWHyIMWrRL-TSW_k5xNxPS4Y4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=940 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new function ring_buffer__ring, which exposes struct ring * to the
user, representing a single ringbuffer.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 15 +++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  |  8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0e52621cba43..de3ef59b9641 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1229,6 +1229,7 @@ LIBBPF_API int bpf_tc_query(const struct bpf_tc_hook *hook,
 
 /* Ring buffer APIs */
 struct ring_buffer;
+struct ring;
 struct user_ring_buffer;
 
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
@@ -1249,6 +1250,20 @@ LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
+/**
+ * @brief **ring_buffer__ring()** returns the ringbuffer object inside a given
+ * ringbuffer manager representing a single BPF_MAP_TYPE_RINGBUF map instance.
+ *
+ * @param rb A ringbuffer manager object.
+ * @param idx An index into the ringbuffers contained within the ringbuffer
+ * manager object. The index is 0-based and corresponds to the order in which
+ * ring_buffer__add was called.
+ * @return A ringbuffer object on success; NULL and errno set if the index is
+ * invalid.
+ */
+LIBBPF_API struct ring *ring_buffer__ring(struct ring_buffer *rb,
+					  unsigned int idx);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 57712321490f..7a7370c2bc25 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -400,4 +400,5 @@ LIBBPF_1.3.0 {
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
 		bpf_program__attach_uprobe_multi;
+		ring_buffer__ring;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 94d11fb44a49..efde453395b0 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -330,6 +330,14 @@ int ring_buffer__epoll_fd(const struct ring_buffer *rb)
 	return rb->epoll_fd;
 }
 
+struct ring *ring_buffer__ring(struct ring_buffer *rb, unsigned int idx)
+{
+	if (idx >= rb->ring_cnt)
+		return errno = ERANGE, NULL;
+
+	return rb->rings[idx];
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.34.1



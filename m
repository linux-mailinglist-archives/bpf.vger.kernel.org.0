Return-Path: <bpf+bounces-10107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DBC7A1181
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC5A28223B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E3D53B;
	Thu, 14 Sep 2023 23:12:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0013CA64
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:34 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F4270A
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:34 -0700 (PDT)
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8VrW021548;
	Thu, 14 Sep 2023 23:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=x83qySIrIUy/SYYqXs0puUkglIaLH27hbJ/l+sB9BaY=; b=AsMj2gwV4l7K
	qG4A+QDlApK/rgfxJg1aC6QlsF1VVMrb5+FlWNlB7dwZCCpXUhsqcB1yBYkn7kgF
	5zRkD7VhGcPZ67EdIchjNImmjKaJriVw8pLpCCe6b9toT7+0iSoyKzAgrSc7zjFA
	Q3a0vBtkymqsFe+ypz7QnSVYrjRDWW5K6DTttuI+pybTi4rIZkmIPLk7shxUbz1N
	AxwVnwFeC6bDNIxui+/xKoXkRAqXeRNdgLx62C3UG5k09hDVXVuAjyxZE9PWCp5C
	im8viy30cYKzzZe9Avwk2RVIDaIDC35QMUL4mSzJmr5id1qCuQO6jYwmyfuKNTi0
	paa204Wdsw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9d6e8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:14 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:12 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 03/14] libbpf: add ring_buffer__ring
Date: Thu, 14 Sep 2023 16:11:12 -0700
Message-ID: <20230914231123.193901-4-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: gNy_2KJkj8yAX4LZX3tau46jvOfntptB
X-Proofpoint-GUID: gNy_2KJkj8yAX4LZX3tau46jvOfntptB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxlogscore=918 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309140202

Add a new function ring_buffer__ring, which exposes struct ring * to the
user, representing a single ringbuffer.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 14 ++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  |  8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0e52621cba43..2d6c39e20863 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1229,6 +1229,7 @@ LIBBPF_API int bpf_tc_query(const struct bpf_tc_hook *hook,
 
 /* Ring buffer APIs */
 struct ring_buffer;
+struct ring;
 struct user_ring_buffer;
 
 typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
@@ -1249,6 +1250,19 @@ LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
+/**
+ * @brief **ring_buffer__ring()** returns the ring object inside a given
+ * ringbuffer.
+ *
+ * @param rb A ringbuffer object.
+ * @param idx An index into the rings contained within the ringbuffer object.
+ * The index is 0-based and corresponds to the order in which ring_buffer__add
+ * was called.
+ * @return A ring object on success; NULL and errno set if the index is invalid.
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
index c2c79e10cfea..2857df0f2d03 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -328,6 +328,14 @@ int ring_buffer__epoll_fd(const struct ring_buffer *rb)
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



Return-Path: <bpf+bounces-10103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4736A7A117C
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214651C20C98
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7044D2FF;
	Thu, 14 Sep 2023 23:12:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A0D2FC
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:32 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C74270E
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:32 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8nlg001980;
	Thu, 14 Sep 2023 23:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=3VKnBjyqIG9ubd52IwIp0UBhKUowISe6tTaia/J8dsE=; b=kCpOh7hOdZmQ
	uNrQ94Z7Xbf/+bgXLfNt8DKkGNwEAhjFp7JuuVd6ckHP3rUGp8ocNZlTbbXCLkeI
	fEZp3TAhns2Fvk29OjU7gRiGSZz/v8wIby2y25ar5kk3jzO+R7PaoVNUtoRtnDcM
	JKOSmToZh/028eRg7rcOvq0+mINXfcQ0w5WhVlZHnvTj/cdUJHrPtKH5JE5/8CiN
	Jifw1bMma+4EoBVc+QY6Lg7/mvbYQgtM9nOcOSGESV6SXVV8tCKkth8Rj8MvK1qe
	4Ei2lk1IzDN7kLowOUmmK+UbC/KSAL3cOEebijPbQbRLXzU5ZS0ubKheuBjVa8/U
	8MQfZhnupQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9fpcp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:11 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:09 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 01/14] libbpf: refactor cleanup in ring_buffer__add
Date: Thu, 14 Sep 2023 16:11:10 -0700
Message-ID: <20230914231123.193901-2-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: tpSbVQu2kUsCcw_blFOVvPBM7F1n9TgV
X-Proofpoint-GUID: tpSbVQu2kUsCcw_blFOVvPBM7F1n9TgV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=607 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2309140202

Refactor the cleanup code in ring_buffer__add to use a unified err_out
label. This reduces code duplication, as well as plugging a potential
leak if mmap_sz != (__u64)(size_t)mmap_sz (currently this would miss
unmapping tmp because ringbuf_unmap_ring isn't called).

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/ringbuf.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db13..f2020807996c 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -118,10 +118,9 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	/* Map writable consumer page */
 	tmp = mmap(NULL, rb->page_size, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
 	if (tmp == MAP_FAILED) {
-		err = -errno;
 		pr_warn("ringbuf: failed to mmap consumer page for map fd=%d: %d\n",
 			map_fd, err);
-		return libbpf_err(err);
+		goto err_out;
 	}
 	r->consumer_pos = tmp;
 
@@ -131,16 +130,15 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	 */
 	mmap_sz = rb->page_size + 2 * (__u64)info.max_entries;
 	if (mmap_sz != (__u64)(size_t)mmap_sz) {
+		errno = E2BIG;
 		pr_warn("ringbuf: ring buffer size (%u) is too big\n", info.max_entries);
-		return libbpf_err(-E2BIG);
+		goto err_out;
 	}
 	tmp = mmap(NULL, (size_t)mmap_sz, PROT_READ, MAP_SHARED, map_fd, rb->page_size);
 	if (tmp == MAP_FAILED) {
-		err = -errno;
-		ringbuf_unmap_ring(rb, r);
 		pr_warn("ringbuf: failed to mmap data pages for map fd=%d: %d\n",
 			map_fd, err);
-		return libbpf_err(err);
+		goto err_out;
 	}
 	r->producer_pos = tmp;
 	r->data = tmp + rb->page_size;
@@ -151,15 +149,18 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	e->events = EPOLLIN;
 	e->data.fd = rb->ring_cnt;
 	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, e) < 0) {
-		err = -errno;
-		ringbuf_unmap_ring(rb, r);
 		pr_warn("ringbuf: failed to epoll add map fd=%d: %d\n",
 			map_fd, err);
-		return libbpf_err(err);
+		goto err_out;
 	}
 
 	rb->ring_cnt++;
 	return 0;
+
+err_out:
+	err = -errno;
+	ringbuf_unmap_ring(rb, r);
+	return libbpf_err(err);
 }
 
 void ring_buffer__free(struct ring_buffer *rb)
-- 
2.34.1



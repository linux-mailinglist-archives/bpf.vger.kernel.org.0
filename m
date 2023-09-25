Return-Path: <bpf+bounces-10774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE117AE0F4
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5307E281448
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342D12420A;
	Mon, 25 Sep 2023 21:52:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DA5241FA
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 21:52:26 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57436AF
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 14:52:25 -0700 (PDT)
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38PF7NxV006685;
	Mon, 25 Sep 2023 21:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=ZYvawROEYx3id48z8q6ojMBqyEktlKiFNiYZTTR9uDE=; b=EPbMBlg+bnE2
	JVvh38SuR4mt+UZvuC3RstqC34Grw/Gz2OWBxXfZMkJelH0JZ39ji624FqynktjW
	YXGIDLs+YvcjOOK+dI85WQk8X60AZiP4nPULwjyiyofdtFGP2ujWP8JdV0+u37go
	9e4L+4Lp5sHR2v5ATTcBtillKzUmylmBN1Aq0JtJX/UiyH4O6++o8366KakQJyMa
	YczMFIwgB6Rhv7FthLdudpsqeX8P3y26XY4HXoQ5wGJ3Tw0NUbo5NrLdpPL3slBe
	lmBiVxffaYwKw1+p/ax4PFpLj+XahkPNzmtknl8R8GfolccmzEg0qA168lDVG3jo
	0AYEUQc5kw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3tab8xcpjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Sep 2023 21:52:06 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Mon, 25 Sep 2023 21:52:04 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 01/14] libbpf: refactor cleanup in ring_buffer__add
Date: Mon, 25 Sep 2023 14:50:32 -0700
Message-ID: <20230925215045.2375758-2-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: 4ytP_lTS83IDNhAVEl2tCf1q9erCdQpY
X-Proofpoint-ORIG-GUID: 4ytP_lTS83IDNhAVEl2tCf1q9erCdQpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=640 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309250168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor the cleanup code in ring_buffer__add to use a unified err_out
label. This reduces code duplication, as well as plugging a potential
leak if mmap_sz != (__u64)(size_t)mmap_sz (currently this would miss
unmapping tmp because ringbuf_unmap_ring isn't called).

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/ringbuf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db13..29b0d19d920f 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -121,7 +121,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 		err = -errno;
 		pr_warn("ringbuf: failed to mmap consumer page for map fd=%d: %d\n",
 			map_fd, err);
-		return libbpf_err(err);
+		goto err_out;
 	}
 	r->consumer_pos = tmp;
 
@@ -131,16 +131,16 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	 */
 	mmap_sz = rb->page_size + 2 * (__u64)info.max_entries;
 	if (mmap_sz != (__u64)(size_t)mmap_sz) {
+		err = -E2BIG;
 		pr_warn("ringbuf: ring buffer size (%u) is too big\n", info.max_entries);
-		return libbpf_err(-E2BIG);
+		goto err_out;
 	}
 	tmp = mmap(NULL, (size_t)mmap_sz, PROT_READ, MAP_SHARED, map_fd, rb->page_size);
 	if (tmp == MAP_FAILED) {
 		err = -errno;
-		ringbuf_unmap_ring(rb, r);
 		pr_warn("ringbuf: failed to mmap data pages for map fd=%d: %d\n",
 			map_fd, err);
-		return libbpf_err(err);
+		goto err_out;
 	}
 	r->producer_pos = tmp;
 	r->data = tmp + rb->page_size;
@@ -152,14 +152,17 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	e->data.fd = rb->ring_cnt;
 	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, e) < 0) {
 		err = -errno;
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
+	ringbuf_unmap_ring(rb, r);
+	return libbpf_err(err);
 }
 
 void ring_buffer__free(struct ring_buffer *rb)
-- 
2.34.1



Return-Path: <bpf+bounces-10106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D37A1180
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 01:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332231C20CAC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B428D534;
	Thu, 14 Sep 2023 23:12:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21292D313
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 23:12:33 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF61BFA
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:12:33 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EL8ek8001454;
	Thu, 14 Sep 2023 23:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=default;
	 bh=vZ+v7zLwrlmk80tgmjuy2nUvxsrDAWGMOvunLQkD9KI=; b=cYwxiguNWDud
	kBq++A4KJhVqg4dwm3iNabHjm4Uyd5gekAGKy7mBslKrkLEmeu66yzLrOKye1UPV
	S/Bzy/k5ED0yK7cbKk+rzh0MDLyn5smAY3d2D2gFKgUHEoiY5h7HaGoA8J+OkRqB
	v8MqogB/EalopAQHGTKdCQpFkZuGs5IdkYNDl6BoQfthTpmCQfqhDlaLE4pgDJVx
	Gs6405pCo9MucaABw5nuepXfKr69dwLBjBGYHNinGUoR9oV60mfTlGlqz+m9sdMr
	BySedxNuScqqq4aN8KiI+h+HIdCWsBsvHsQv9TVtWvqEDu89+6pJxBv02NPI2T+W
	Xc5Ax2EYdw==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3t2y9fpcpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Sep 2023 23:12:20 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 14 Sep 2023 23:12:19 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next 09/14] libbpf: add ring__size
Date: Thu, 14 Sep 2023 16:11:18 -0700
Message-ID: <20230914231123.193901-10-martin.kelly@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: 0UcfJpvaw06Acdsag3o4HWERpoHebpJi
X-Proofpoint-GUID: 0UcfJpvaw06Acdsag3o4HWERpoHebpJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=843 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2309140202

Add ring__size to get the total size of a given ringbuffer.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.h   | 8 ++++++++
 tools/lib/bpf/libbpf.map | 1 +
 tools/lib/bpf/ringbuf.c  | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 87e3bad37737..299d98402ad4 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1290,6 +1290,14 @@ LIBBPF_API unsigned long ring__producer_pos(const struct ring *r);
  */
 LIBBPF_API size_t ring__avail_data_size(const struct ring *r);
 
+/**
+ * @brief **ring__size()** returns the total size of the ringbuffer.
+ *
+ * @param r A ring object.
+ * @return The total size of the ringbuffer.
+ */
+LIBBPF_API size_t ring__size(const struct ring *r);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f66d7f0bc224..4ca77e715667 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -404,4 +404,5 @@ LIBBPF_1.3.0 {
 		ring__avail_data_size;
 		ring__consumer_pos;
 		ring__producer_pos;
+		ring__size;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index f51ad1af6ab8..52c385195f32 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -355,6 +355,11 @@ size_t ring__avail_data_size(const struct ring *r)
 	return ring__producer_pos(r) - ring__consumer_pos(r);
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



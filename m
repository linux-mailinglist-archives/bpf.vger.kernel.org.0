Return-Path: <bpf+bounces-31504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E089F8FF043
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671F72893EF
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A651990BE;
	Thu,  6 Jun 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IN9jBHxm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D28160883;
	Thu,  6 Jun 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685960; cv=none; b=gh136ijCWKHjvDmyWyhDOmunqBRq8mMAS1zJ/4LdjMojGZrQRq9DYrCjEr8dhXi4PcQ07k7aGahqH7oTf8oQRmv44lxHYCvpSNzdFWlfio66EhNWmi/vqr+L6i36FDoU2m1VK/c/EtcZisyeSxVeG+d0gDqik2jYp/YmeDNVocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685960; c=relaxed/simple;
	bh=BRGnyOwwjTHwr0xT9vdi9DzwEcX4YRBHEHgtn2zbuM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iufVGveZfHJoQxanP9srshypgW4EbYMOW7SpOFrBDTAnKtB/1jyrGFMM7HfGCVf9uMh7Kvf4qSIopDW1aMyV8PMsIQbFmwGIPzVJHchksYWLhG30tnwsrHj+S1Xj9VE9hHPWcJ9MCJnUca7eP+9ZYFa6VXI8o+h6E1Lb+neuLYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IN9jBHxm; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4566pTZn005391;
	Thu, 6 Jun 2024 07:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=cKMJQJ4Rp5oacvYwiEuAS+UkHPdvMyAPI0+A5pHgks8=;
 b=IN9jBHxmp0bO5MW50AqWGl7BKg2tuRREdahIhVIKM6MUcU6wyF2nmYUuEOKW74DaFTuV
 Dp3hHCAHiM3MCipPJOBac4TdrQKiPdcfhF55w8NcIRgissLoEcjZMmS1pmpcWteQYvNP
 lIRY01RYAOnNKb3SdvBc8598ZtZobr6Rgh1wCVuM0UWAE2pI+jY2Py6I/jaXoCtb0P8j
 A0TKPNGzg0qjb9cRS5AmVtZGXwKQVKUlISvDHkN76nfhGDMYphjNwnYbpemJPmuNw7GJ
 g6lv/gAAfRh+oLjJJvAiCps9E+e5BKs3yvgiID8klmuCpIk6qqTOiznbVq4Tvszn8Utq 2A== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yk875tj41-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 06 Jun 2024 07:59:01 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 6 Jun 2024 14:58:58 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>,
        Martin KaFai Lau
	<martin.lau@linux.dev>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next v4 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
Date: Thu, 6 Jun 2024 07:58:50 -0700
Message-ID: <20240606145851.229116-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QFiacBrSKKvzZpKxfZADse4zWTlejvvK
X-Proofpoint-GUID: QFiacBrSKKvzZpKxfZADse4zWTlejvvK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01

Add special flag to validate that TC BPF program properly updates
checksum information in skb.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
v3 -> v4:
 - use network header offset as starting point for checksum
 - use folded checksum values to compare results
v2 -> v3:
 - remove BIT() macro from uapi bpf.h
 - change error code to EBADMSG
v1 -> v2:
 - clean unused variable
---
 include/uapi/linux/bpf.h       |  2 ++
 net/bpf/test_run.c             | 28 +++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  2 ++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 25ea393cf084..35bcf52dbc65 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1425,6 +1425,8 @@ enum {
 #define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
 /* If set, XDP frames will be transmitted after processing */
 #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
+/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
+#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f6aad4ed2ab2..c87df2c4cd57 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -977,7 +977,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	void *data;
 	int ret;
 
-	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
+	if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
+	    kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
 	data = bpf_test_init(kattr, kattr->test.data_size_in,
@@ -1025,6 +1026,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
 	__skb_put(skb, size);
+
 	if (ctx && ctx->ifindex > 1) {
 		dev = dev_get_by_index(net, ctx->ifindex);
 		if (!dev) {
@@ -1060,9 +1062,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		__skb_push(skb, hh_len);
 	if (is_direct_pkt_access)
 		bpf_compute_data_pointers(skb);
+
 	ret = convert___skb_to_skb(skb, ctx);
 	if (ret)
 		goto out;
+
+	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
+		const int off = skb_network_offset(skb);
+		int len = skb->len - off;
+
+		skb->csum = skb_checksum(skb, off, len, 0);
+		skb->ip_summed = CHECKSUM_COMPLETE;
+	}
+
 	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
 	if (ret)
 		goto out;
@@ -1077,6 +1089,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		}
 		memset(__skb_push(skb, hh_len), 0, hh_len);
 	}
+
+	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
+		const int off = skb_network_offset(skb);
+		int len = skb->len - off;
+		__wsum csum;
+
+		csum = skb_checksum(skb, off, len, 0);
+
+		if (csum_fold(skb->csum) != csum_fold(csum)) {
+			ret = -EBADMSG;
+			goto out;
+		}
+	}
+
 	convert_skb_to___skb(skb, ctx);
 
 	size = skb->len;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 25ea393cf084..35bcf52dbc65 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1425,6 +1425,8 @@ enum {
 #define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
 /* If set, XDP frames will be transmitted after processing */
 #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
+/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
+#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
-- 
2.43.0



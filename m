Return-Path: <bpf+bounces-30302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 025758CC39B
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7121F2306F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC3208C4;
	Wed, 22 May 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="huZXihql"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6E1CD16;
	Wed, 22 May 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389862; cv=none; b=oQgeVkQpSp0a3THbLs24m39zaqowijXZWDKDC9WGBjuhevqcmlaiKctaPDIbRrOa7Y20vGQKO6uckgdEFJB3FSHvdzXpd9RGhzjP1qiwQpUFO9Hel+0OVAAme7rsz5nJ+Sea6hhG1pauiFoz+Lck+d7TibnhMd6l3zpK+BRBhBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389862; c=relaxed/simple;
	bh=pQBNxtCwqRBfHoza8gVPTs0GuyS6y6tCfPhw6gYt354=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SI0cdOQwx4qE3xwRnwnSdeF4ZAvsW7dZg/vtXYAGvxRLQAgdvq2hC7s1brxFLlceVUybbtRcjEiX6Pdx5c3s9WmBUD2qL3vU7Kko7fHqqJexBeqlBNXExmjCDocjO5QtAfvbGkbcvDhEZ8n8Mz9LY3G6KY7xNo9d6PdrBrg8QdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=huZXihql; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 44MAY754003497;
	Wed, 22 May 2024 07:57:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=TyrAxx8h6NEXxO7Pi0+xsoDGCi8mE5xhc9IsGWQSqow=;
 b=huZXihql1JAtHwyasgD22Nnt4F/3UYluzYvm3mBeUax7eYrbhwfvzJLPgbeQ9oyQw9Z6
 DAl5XJpenyMMfvWi39oI3uuw0/yTXfqcsYBeP/I4d4xJUKC33GeucNYFbKw8o1VeHWoi
 4V15vGLvPOxAPgLaGh4tR0eBqxzHWIwK9YVPI4S/KurSCcgcYOTQNcpRAgY5n4NVPm0D
 8IhfRkKAXoXcI2PFrUBWTEPOphyrnV1r38weWywULoRYcNlaZgeQnb++pUc/leHY/MGo
 CJx2bejohhB9aRQrF0qlXL8hMTaaRemljWWZBJvTFsyLpK8nU57M1mXLhnxa0MtPMF4W Fg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3y91bsnsv4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 22 May 2024 07:57:21 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 22 May 2024 14:57:19 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
Date: Wed, 22 May 2024 07:57:10 -0700
Message-ID: <20240522145712.3523593-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pBLwyzx2-0S20J3Zgxk5dAvGL5BbwQHW
X-Proofpoint-ORIG-GUID: pBLwyzx2-0S20J3Zgxk5dAvGL5BbwQHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01

Add special flag to validate that TC BPF program properly updates
checksum information in skb.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 include/uapi/linux/bpf.h       |  2 ++
 net/bpf/test_run.c             | 19 ++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 90706a47f6ff..f7d458d88111 100644
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
index f6aad4ed2ab2..841552785c65 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -974,10 +974,13 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	int hh_len = ETH_HLEN;
 	struct sk_buff *skb;
 	struct sock *sk;
+	__wsum csum;
+	__sum16 sum;
 	void *data;
 	int ret;
 
-	if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
+	if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
+	    kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
 	data = bpf_test_init(kattr, kattr->test.data_size_in,
@@ -1025,6 +1028,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
 	__skb_put(skb, size);
+
+	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
+		skb->csum = skb_checksum(skb, 0, skb->len, 0);
+		skb->ip_summed = CHECKSUM_COMPLETE;
+	}
+
 	if (ctx && ctx->ifindex > 1) {
 		dev = dev_get_by_index(net, ctx->ifindex);
 		if (!dev) {
@@ -1079,6 +1088,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 	convert_skb_to___skb(skb, ctx);
 
+	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
+		csum = skb_checksum(skb, 0, skb->len, 0);
+		if (skb->csum != csum) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
 	size = skb->len;
 	/* bpf program can never convert linear skb to non-linear */
 	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 90706a47f6ff..f7d458d88111 100644
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



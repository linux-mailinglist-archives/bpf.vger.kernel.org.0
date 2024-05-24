Return-Path: <bpf+bounces-30478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A998CE4A8
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1095B1C21666
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EAB84E0F;
	Fri, 24 May 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Q67TJrCK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33265538A;
	Fri, 24 May 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548845; cv=none; b=quNZ3K7n0AO/tpKJcXY743DiG5K3K/Xyyhn700XBc2tJu/JGxYz9I6by+dcabXHVmxq1PXjwNjupcvHWT4ZgPbhMDJD34Iuq2T2pghYPXKRCFm8QAPDl9vleDWVk2BWIXFo7w905Eb1FrDDp5bJBNVbNU0cawIiN20VfCaWI6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548845; c=relaxed/simple;
	bh=UE3jy3zFh/c6NQWrovwjNIcisNg3j4klg8dpXsoqg5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kPicNe8vVVK0UKrOh4mKHE3uozMVkIhy0htUqAdRaZB9NlOFM2LRFH4H7Gk4N7JMxsUH/8iBlWxRs0SdKfJRaARqPlS0F0WdnCld/7wc6NDribN3GcJC8GNn6CV7P7ebZvC+c0J4+gFUqMUh4L7ePE4GbUCwJfcloLdd8QFyMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Q67TJrCK; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 44O7rHcS012621;
	Fri, 24 May 2024 04:07:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=4wVN9uy2SQb3ooGo+DAW3A2Lx0NK5VTY8+0sdFaXHwE=;
 b=Q67TJrCKqDHt4S3cQ1KPSflEtuttdTLgFeJHWIco40NrWppuiudO1XKuIkZ49T1QMnGq
 fI8+GPNtZubKrOeCFz8LnrF765VJcAB+TlbNIlyqVws8CUo26r2Ng9DfOJ3tUgPUdSZy
 j0NcfMV/E+EpgjCfludph4dQVG9Pbd22IBBJKZskqdiQl53MPfU3lj6JxDbuZABqZmGa
 B3nHzukgBau4cIhRkcZrqN7yoLHd4aSGnLsEb+MsqYpMjOIKaAQo973nKPEfjKO57ZQn
 N36A1P9bgp44F9iW9y7Yg/Aa3xplDQ9HkpLrknYfwVJBmkhw0jUp/o+DupwnjM0Aa60n 4g== 
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3yapw68tm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 May 2024 04:07:17 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Fri, 24 May 2024 11:07:14 +0000
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
Subject: [PATCH bpf-next v2 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
Date: Fri, 24 May 2024 04:06:58 -0700
Message-ID: <20240524110659.3612077-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qyg0uD1H-3zvb-KtnIr0TXVWDHN6J97b
X-Proofpoint-GUID: qyg0uD1H-3zvb-KtnIr0TXVWDHN6J97b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-23_01,2024-05-17_01

Add special flag to validate that TC BPF program properly updates
checksum information in skb.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 include/uapi/linux/bpf.h       |  2 ++
 net/bpf/test_run.c             | 17 ++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

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
index f6aad4ed2ab2..c6189bb9bf67 100644
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
@@ -1025,6 +1026,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
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
@@ -1079,6 +1086,15 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 	convert_skb_to___skb(skb, ctx);
 
+	if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
+		__wsum csum = skb_checksum(skb, 0, skb->len, 0);
+
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
+#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	BIT(2)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
-- 
2.43.0



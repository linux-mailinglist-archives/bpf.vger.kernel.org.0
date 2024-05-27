Return-Path: <bpf+bounces-30695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F758D0A97
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 21:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832141F226CE
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D401667C1;
	Mon, 27 May 2024 19:01:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053C15A879;
	Mon, 27 May 2024 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836461; cv=none; b=SVybDCGwGRRsdPwk6i0hoh9rgm2RO1XhRKJR1DxChVltfyAz18cN1vywCav9j83rN9Ob2Oo3gUBZJCmB2mugCnAPtmrw35oaPjvg04TApGBgQFwKuuOhR6SujX8Pw+ZWeRUsd1xTP978d8utlZaMfVpqAt08Cf4z/AT/ZD9/6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836461; c=relaxed/simple;
	bh=yLU8t/0iJ5/QQHKe8t+Yev7MWlW75NtnS3A9bPZ1tQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iloUTYqaIiYaevNS12lYE1/d8puMg73bqEwelNVvLXg70cRfKJXvqNrPhWcDlyn8Rc4xolwzNqTAZEjuwvNpU4xkCQ+erFn3kZT8SlE7+6pBxLtOA8p56Xk4/dunpmqVWYk+uUp23fNPMFFhcaG/9XZ8xMsu1ozsiG4lQmdvkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RIQb8R007199;
	Mon, 27 May 2024 12:00:23 -0700
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dmeta.com;_h=3Dc?=
 =?UTF-8?Q?c:content-transfer-encoding:content-type:date:from:message-id:m?=
 =?UTF-8?Q?ime-version:subject:to;_s=3Ds2048-2021-q4;_bh=3DW4OmNPrht9nkzrN?=
 =?UTF-8?Q?Um0QI3Obq8q8zB90+87BVHnIVV5Q=3D;_b=3DiCzv3oXY55/IDKGfZvco/XlTuV?=
 =?UTF-8?Q?Ol7b8toVnL+H+3kna9eXLk1MZ2Rol2tEznK0gq2qFI_TqN3uhnu6nWdW2I4/2Om?=
 =?UTF-8?Q?y2rJe7fXcgA5kFOXT0N0IkLRd36AS7KjHv6DDFcbnBCIvyJz_GeBtS14elPAL5E?=
 =?UTF-8?Q?Y7PzfsSaMUaqgcuzo7gINGqZgsIs1kQTLPSQ2WPkQP0gLNjMKbx+/p_aY7gpr0g?=
 =?UTF-8?Q?jT+MLzKgxxS2hsyB7pME5E5C2hep6E1zu0rZMIw6h/TnEO8wqk1oeDl7B3iJ_qr?=
 =?UTF-8?Q?zfVAz6kCywOExYX1iboRUaV00AL0DiA46bHszW6gydLnVt1jwlygFX2i2nutu4n?=
 =?UTF-8?Q?BEK_uA=3D=3D_?=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ybdr3234w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 27 May 2024 12:00:22 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Mon, 27 May 2024 19:00:21 +0000
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
Subject: [PATCH bpf-next v3 1/2] bpf: add CHECKSUM_COMPLETE to bpf test progs
Date: Mon, 27 May 2024 11:59:27 -0700
Message-ID: <20240527185928.1871649-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RkYHWvO3YaOReyy3ChZRdIbSe5Ct2J20
X-Proofpoint-ORIG-GUID: RkYHWvO3YaOReyy3ChZRdIbSe5Ct2J20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01

Add special flag to validate that TC BPF program properly updates
checksum information in skb.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 include/uapi/linux/bpf.h       |  2 ++
 net/bpf/test_run.c             | 18 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

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
index f6aad4ed2ab2..4c21562ad526 100644
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
+			ret = -EBADMSG;
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



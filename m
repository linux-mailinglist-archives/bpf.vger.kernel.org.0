Return-Path: <bpf+bounces-30887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FF08D4296
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 02:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9B1F21EE1
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 00:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBDBF4FB;
	Thu, 30 May 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WgYt+R64"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F431C14F;
	Thu, 30 May 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030479; cv=none; b=twzXx9YPPsf1Ilgvs9YC0Uh36Mg3joltyfffSIlyfrzt+U+tljQEL/ypPkO6XXYJiLwpOSqF50mNq1XASVyTsVh4/zJTZdVRwC8cuMcpiWL/76kvusk9BS9IL6LqVp7g0d6WgUNQAj746wR/mLo43TR/8pMd7Er0l7Z9TY7wPIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030479; c=relaxed/simple;
	bh=ZLZvK70J7dzK/liNvZM3bw+pDlcX659UoYR6RqaFFD0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Juns1l6vCROnBlDtI2qdupbBdpXyeKxztjsEjPfzFZHKDphjhzkhn8c4E6QhSECWIDCOax/+yuNZpwPhxW4yaVrAuZ/qNCybaBzzlSJbHBX8mpKYT0/QkB75UnRJTbiseEC8nEgMBJlCY609wfjwHtmP08/tjxtNfH5buwF+YPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WgYt+R64; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TN0Itb016820;
	Thu, 30 May 2024 00:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=cc:date:from:message-id:subject:to; s=corp-2023-11-20;
 bh=WtYI8PHFyipbQc0+WD8LMMKrLJos4GRp31+t3Pdq25g=;
 b=WgYt+R64oTBw07YlnLaL206xhzeNXVoSybKMnLsF9CmSAhv85+3e/pgfabAIcSoHoor8
 ikWKttJYUnTeChsFoVkHmxgtHF5EsyVKi/BOn21U6FrXUAe5yxeXXFW73J4eZ6O6jmQC
 oNqMJN7bloirj1Uhl0qJNLkw5jfymeHrx6o9SZ4w5hC0Y/EnR0oAI295+Q/O3zdOmOMD
 mPBF40TzGm9JRIDoKxNzr1n8FnmgPzpdVJQYcINWwqsS7HGF9M8MD7wDU7VeITzdnkGD
 esTcxdjgrZDaA7szUFDK78nyIGTlrzPkR7XU5FbjWqjK4U7foqFws3TKZ+oIQNhLOPQJ qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g47x2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 00:54:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TN5QKX010665;
	Thu, 30 May 2024 00:54:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50yy6e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 00:54:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44U0sMfI017218;
	Thu, 30 May 2024 00:54:22 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com [10.153.73.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3yc50yy6dn-1;
	Thu, 30 May 2024 00:54:22 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mst@redhat.com, boris.ostrovsky@oracle.com
Subject: [PATCH] net: tap: validate metadata and length for XDP buff before building up skb
Date: Wed, 29 May 2024 16:42:21 -0700
Message-Id: <1717026141-25716-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300005
X-Proofpoint-GUID: tZmsOaspPiyTAjdS_3bLsp7xd0OvjDyb
X-Proofpoint-ORIG-GUID: tZmsOaspPiyTAjdS_3bLsp7xd0OvjDyb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The cited commit missed to check against the validity of the length
and various pointers on the XDP buff metadata in the tap_get_user_xdp()
path, which could cause a corrupted skb to be sent downstack. For
instance, tap_get_user() prohibits short frame which has the length
less than Ethernet header size from being transmitted, while the
skb_set_network_header() in tap_get_user_xdp() would set skb's
network_header regardless of the actual XDP buff data size. This
could either cause out-of-bound access beyond the actual length, or
confuse the underlayer with incorrect or inconsistent header length
in the skb metadata.

Propose to drop any frame shorter than the Ethernet header size just
like how tap_get_user() does. While at it, validate the pointers in
XDP buff to avoid potential size overrun.

Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
Cc: jasowang@redhat.com
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/net/tap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index bfdd3875fe86..69596479536f 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1177,6 +1177,13 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	struct sk_buff *skb;
 	int err, depth;
 
+	if (unlikely(xdp->data < xdp->data_hard_start ||
+		     xdp->data_end < xdp->data ||
+		     xdp->data_end - xdp->data < ETH_HLEN)) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	if (q->flags & IFF_VNET_HDR)
 		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
 
-- 
2.39.3



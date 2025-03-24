Return-Path: <bpf+bounces-54594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D81A6D46F
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 07:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8899F16903E
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 06:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B49204C1D;
	Mon, 24 Mar 2025 06:53:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEA202C22;
	Mon, 24 Mar 2025 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799211; cv=none; b=n7fZ0XCXf2UfqspMhHpKrmljMM9JUvYAEiGlt5QI+ApNJzu+R7BL64m3jaWT5MHMzC2jtBIX0QWYH1Pxvhbi/wssNxXbQ7HGFUx0GCctwo/GUJ90MHGUlxao8LkIIu1UBnBkQ93YshwEQidAJG2GqrZ3VsZ3XUaILpyuAycfxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799211; c=relaxed/simple;
	bh=nkrvSw/90gggkSHojkoVxU+WAa1fXW0Z4hxUc0n7bRM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhjE2ccdfn96mkWz5ZfHG2rJe1oLAP8hpjaLTtOnCgfz/BafE5xcOTaiQbFVqw4MMYjUK+5Aofr4tWGAU9lt5Ez5+4irGrqiHB/5PZLXZuQHg/Mmb6g9MgLfjehMe4AxchvjxSRfV3EpHmDeeli7Dce5MzEeMmPNsGDZncAUREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5jeav006903;
	Mon, 24 Mar 2025 06:53:06 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hje1hth0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 24 Mar 2025 06:53:06 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 23 Mar 2025 23:53:04 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 23 Mar 2025 23:52:59 -0700
From: <jianqi.ren.cn@windriver.com>
To: <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <jianqi.ren.cn@windriver.com>,
        <shravya.k-n@broadcom.com>, <michael.chan@broadcom.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <somnath.kotur@broadcom.com>, <ajit.khaparde@broadcom.com>,
        <andrew.gospodarek@broadcom.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: [PATCH 6.6.y] bnxt_en: Fix receive ring space parameters when XDP is active
Date: Mon, 24 Mar 2025 14:52:58 +0800
Message-ID: <20250324065258.3795814-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KPVaDEFo c=1 sm=1 tr=0 ts=67e10152 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Vs1iUdzkB0EA:10 a=Q-fNiiVtAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=fl9wSW5VptL9eKRiuLsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: AvZ1eSOouUOQTrkOF6mQ1EP2wtzvCLn0
X-Proofpoint-ORIG-GUID: AvZ1eSOouUOQTrkOF6mQ1EP2wtzvCLn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240049

From: Shravya KN <shravya.k-n@broadcom.com>

[ Upstream commit 3051a77a09dfe3022aa012071346937fdf059033 ]

The MTU setting at the time an XDP multi-buffer is attached
determines whether the aggregation ring will be used and the
rx_skb_func handler.  This is done in bnxt_set_rx_skb_mode().

If the MTU is later changed, the aggregation ring setting may need
to be changed and it may become out-of-sync with the settings
initially done in bnxt_set_rx_skb_mode().  This may result in
random memory corruption and crashes as the HW may DMA data larger
than the allocated buffer size, such as:

BUG: kernel NULL pointer dereference, address: 00000000000003c0
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 17 PID: 0 Comm: swapper/17 Kdump: loaded Tainted: G S         OE      6.1.0-226bf9805506 #1
Hardware name: Wiwynn Delta Lake PVT BZA.02601.0150/Delta Lake-Class1, BIOS F0E_3A12 08/26/2021
RIP: 0010:bnxt_rx_pkt+0xe97/0x1ae0 [bnxt_en]
Code: 8b 95 70 ff ff ff 4c 8b 9d 48 ff ff ff 66 41 89 87 b4 00 00 00 e9 0b f7 ff ff 0f b7 43 0a 49 8b 95 a8 04 00 00 25 ff 0f 00 00 <0f> b7 14 42 48 c1 e2 06 49 03 95 a0 04 00 00 0f b6 42 33f
RSP: 0018:ffffa19f40cc0d18 EFLAGS: 00010202
RAX: 00000000000001e0 RBX: ffff8e2c805c6100 RCX: 00000000000007ff
RDX: 0000000000000000 RSI: ffff8e2c271ab990 RDI: ffff8e2c84f12380
RBP: ffffa19f40cc0e48 R08: 000000000001000d R09: 974ea2fcddfa4cbf
R10: 0000000000000000 R11: ffffa19f40cc0ff8 R12: ffff8e2c94b58980
R13: ffff8e2c952d6600 R14: 0000000000000016 R15: ffff8e2c271ab990
FS:  0000000000000000(0000) GS:ffff8e3b3f840000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000003c0 CR3: 0000000e8580a004 CR4: 00000000007706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 __bnxt_poll_work+0x1c2/0x3e0 [bnxt_en]

To address the issue, we now call bnxt_set_rx_skb_mode() within
bnxt_change_mtu() to properly set the AGG rings configuration and
update rx_skb_func based on the new MTU value.
Additionally, BNXT_FLAG_NO_AGG_RINGS is cleared at the beginning of
bnxt_set_rx_skb_mode() to make sure it gets set or cleared based on
the current MTU.

Fixes: 08450ea98ae9 ("bnxt_en: Fix max_mtu setting for multi-buf XDP")
Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c440f4d8d43a..1dd873338ec0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3986,7 +3986,7 @@ int bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode)
 	struct net_device *dev = bp->dev;
 
 	if (page_mode) {
-		bp->flags &= ~BNXT_FLAG_AGG_RINGS;
+		bp->flags &= ~(BNXT_FLAG_AGG_RINGS | BNXT_FLAG_NO_AGG_RINGS);
 		bp->flags |= BNXT_FLAG_RX_PAGE_MODE;
 
 		if (bp->xdp_prog->aux->xdp_has_frags)
@@ -12795,6 +12795,14 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 		bnxt_close_nic(bp, true, false);
 
 	dev->mtu = new_mtu;
+
+	/* MTU change may change the AGG ring settings if an XDP multi-buffer
+	 * program is attached.  We need to set the AGG rings settings and
+	 * rx_skb_func accordingly.
+	 */
+	if (READ_ONCE(bp->xdp_prog))
+		bnxt_set_rx_skb_mode(bp, true);
+
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
-- 
2.25.1



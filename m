Return-Path: <bpf+bounces-59027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67C9AC5C5F
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471EE3A4F61
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 21:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B79214A94;
	Tue, 27 May 2025 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Tmh43fxQ"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020099.outbound.protection.outlook.com [52.101.61.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C482C1ACEAC;
	Tue, 27 May 2025 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748382222; cv=fail; b=cSD0EyCJouGU0AjU9NwnzzJgnISXVW6CjVsqshyE7sYLzX5OFsC949p8glqd5At+LKlQ6T+MwUXepcw5TUpPBlgTx8Cnr9bb1jI57cE3cUFJlWqcUTBUtrDJxC2qrhIzw4O9kslbkLjJHZ3Epk3ERKV5mF6lx+ULLneamQefZc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748382222; c=relaxed/simple;
	bh=f8VK67e4BcQW2yIVhiPqTVje5WOnKHbb3YgsJYhvXdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=soquUbz+cUzeSCI52bFvWFKfzXkSMuk5WPtcFg45w/KwoquFr9QRAOMGFEVIt0M2pRHiDGAb37gOhzDH9VqQjQadUykU1FuOZCj4uDRHytBoPREyz16B38Slp6PHpWOCXnoewQ9O+zuDkD1y0CrKr3dD/AqY2eXCWY3KCrRbiww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Tmh43fxQ; arc=fail smtp.client-ip=52.101.61.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEnX2XZwr6kde0Y/lT01JurI0rqs/YPwSRqTt8YxcV+B4H4iXzU0/wN8z7JGf4kaWmANvLiav32jTAIt4zbyg/R/tjmbrpM10In+NQ5ixjc4B8wfJG/IxSG+8Tp5gt0z/P08yMN02ptuTjAHxWPVYfmkU/Q41y2ulR69Wmdx+RKVzIjKw653PwPZ6BO3Azl4Do7T30XlL+I1X9eSJO7rsjggrhhTEAqX2BSwkqtTVlrsDKwZCgA3b1aWDCJAWvyZnnDuZ8A+2aHj48zYWgus6wgzrhsDzJdW7Y+VOmwxY/iposRAu8T12r7KPBlvsHUw78re7DHD0eB41rW/qW129w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEVJy38ZhR1vIrKiCt4/w60bcbF60LsE0SdQYNHt1d4=;
 b=aB9+/kKXBVWTBQG2gufHHZAhR3uHxfnji6ebD+sxFtukaUqpRZNbagZygDmS70Jh284xH71rkXTAo9fK9gDVjfW/RXnMilss5bbUb/jhciBnLPauwW6zxN3X+EGTc9jl69GfEYcNu78jMWtERWfqKtcKrzD9iHheXDZTOog95h9ftY9rfngwbzbVqik3PKOp/54SZ8nP76O216ssP6BC5PdhOvLVs9I3si5odM31I91YlDcSX+U1f6VZGPz+Qrns8nPq+ehGwF6wRONH7R6wAy5ljbkmNqWqLUShQ/vCfUeBACKeM36p7cHYOEFhB9bP+p3iZDq/G1DuiAxEFbIAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEVJy38ZhR1vIrKiCt4/w60bcbF60LsE0SdQYNHt1d4=;
 b=Tmh43fxQ07UM/0WXc3MVg0H7YVFGzPak8hRG/eOHKERUtUUAGkjQj/a9CZ0yPiAHemXXH8sRkzFmAqSLO2ZN/GRI6GVLyv7eu95p/dRNJFT0DD5apCNEIZ7OpSMYWu7NlhJtVM9Zzcq/n9vp50lEtsUkZ9N7KuZIHpvKs+EcPqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MN0PR21MB3606.namprd21.prod.outlook.com (2603:10b6:208:3d1::17)
 by BL1PR21MB3043.namprd21.prod.outlook.com (2603:10b6:208:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.6; Tue, 27 May
 2025 21:43:36 +0000
Received: from MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::5120:641f:e060:2dc4]) by MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::5120:641f:e060:2dc4%4]) with mapi id 15.20.8769.001; Tue, 27 May 2025
 21:43:36 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	stephen@networkplumber.org,
	kys@microsoft.com,
	paulros@microsoft.com,
	olaf@aepfle.de,
	vkuznets@redhat.com,
	davem@davemloft.net,
	wei.liu@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	ast@kernel.org,
	hawk@kernel.org,
	tglx@linutronix.de,
	shradhagupta@linux.microsoft.com,
	andrew+netdev@lunn.ch,
	kotaranov@microsoft.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v6] net: mana: Add handler for hardware servicing events
Date: Tue, 27 May 2025 14:42:46 -0700
Message-Id: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:303:b8::15) To MN0PR21MB3606.namprd21.prod.outlook.com
 (2603:10b6:208:3d1::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR21MB3606:EE_|BL1PR21MB3043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0f2dbf-a0fd-4ea4-a7e0-08dd9d6788d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uav/7sCx3Vy+2kZwVUK5Z72gMSAFFU87mF5etmF9ytPmjb9RG0fPT/a3WFnY?=
 =?us-ascii?Q?MuY3C51DOW8S6DmsxZA24SWTXwY9+c8W/b9EU/Eim4ty6T5ldkOEUwqZgQ7n?=
 =?us-ascii?Q?O79lVV3+yNrlDexqBvhVxyVoMMNFLJwG0bxWQ41fSTFSsHgWcaI4mIoow6RQ?=
 =?us-ascii?Q?Y8D/XpNw1e42D5Xp2EiV3O1cn9rGv6I/V3/YfBAdzlr2sd/MfCY31HU4jvYc?=
 =?us-ascii?Q?LDJq52i6zUbpuO4BqmNoJVlhOQnm5TNdybahqHEufGHPg+0/Q9rqKAHVHcCX?=
 =?us-ascii?Q?gjn5FKNvL3985gdBVQCN/NmvMNSsBPEDp/ihZ57gnGDXn9BvhjU5rzMlBswt?=
 =?us-ascii?Q?UBVRJDnrkf1BBnRYhynCTZxL0qpodNObH2GIY02fhhSMJ5+Zk26dJzmkkQYk?=
 =?us-ascii?Q?3Bfk1uqC+95A0AkXaayuKYGV/YRXXvrrJcwPzCnSAiQAFrY+xMLJPS0HNiz1?=
 =?us-ascii?Q?E8ux7jH+vpO5G7h1d70E8m5kjudwsfehG+54gp6K5Zz8AhAhA5O62Qdtnrd9?=
 =?us-ascii?Q?Q5u0Ip/0G4rBTYiTia3k9cAVRuFpG5A3ao7uh0Hp5OEkB/be241F+UvVwRHw?=
 =?us-ascii?Q?u7PamfM3myzXBqM8ZVFVDxb/dQIdmtvdXQzXDUimg8Spk3pFwprGFByvwJce?=
 =?us-ascii?Q?1QROorhOPxO35rKRLbJN5/QySDO9qaQpNJbYS0NkLq3OtrfgeTHc/2EHRKwv?=
 =?us-ascii?Q?qyzYznS2527nCHsqmZGYcWM/zlKUdtGGMikaf7OA1x72jnY9uM0xXeLm24//?=
 =?us-ascii?Q?V59JX1Pk4obAftFRY1S4xR501rNEEsSR6b2cwKjVsQ0pETPTqJxn6/3yOE7m?=
 =?us-ascii?Q?D78cNeLUWL/uSuzc+EZRd2JRamjmtkGKQHBx3Ngb9qW0Y6ieubN+AG8SXu/m?=
 =?us-ascii?Q?IT2F/fLItFKmxiPVpOVdS8w8ti2HByVpciNPm31k9qS74lF61h/YEXRzQa/O?=
 =?us-ascii?Q?JolYEhdsjHRFF8d5oTraevTPrN6O26OOkw2NmrZghpdn4ShG66kvbE3XnGPf?=
 =?us-ascii?Q?9ZYjcEZeoEFnqTqne4MQU23DH7Xr2IEXuhxC0D97gENSdP+RAQ0HshPbAFoU?=
 =?us-ascii?Q?Kv1dBgV6FNWhdQ/Q47+phS2ez3jx4aXwQvtWkZfao/ihOcE9HbsdH5+GsoDd?=
 =?us-ascii?Q?bx6eHRTtM6EVMcDD+zWIYHpJvUSv6ggUL1NAN1iE0svspeZ16eQfJ12pWb1b?=
 =?us-ascii?Q?ECSpCc8AbvR7DYQkyyc6tHFCGYtt4MOSt6BjJgYNbJfChD6NcbhEzaeZD/bv?=
 =?us-ascii?Q?yGdIfvEPhVKL9ANot7RTP118fCAspAz94CdmCBHQYXoIshaaUTZpRUE8NG6Q?=
 =?us-ascii?Q?FipDE6rfNACY0xhQH1CwKi2Jr9/7eg+4FLtTF/SvIjg56ymXWmCRZ9X+r9vt?=
 =?us-ascii?Q?fJRJKELBz0aBnHLYWlDYZcghUIa/HEdPpZ2A4O5gdeQL0aplInrGCHhqsQaY?=
 =?us-ascii?Q?KgF8BnKbtrTAr69hQzA/9lATcJXvCNE88bHHcBcMIbXAfbBAafGIPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3606.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oo2EVoHSm0/Hq8K1BB2iV/rD3XxDfwVXz0Pj3jdBJYIKNCZ6pnua3pBPpSko?=
 =?us-ascii?Q?301iEmTuIVfq8VT9BQrqLg5oYhFKu8W+rwwDUy5nhyWp43bviykZvJzMjrTt?=
 =?us-ascii?Q?9XDjIWcF9L/Vyu81JIGDR/IWlQtGpizxUUHT+E7oxLFyPuxELCKZBzwpX2QC?=
 =?us-ascii?Q?OJbhaST5IW9m22nOY/zmch3y6q7x8daaMmc1/VVvAJ4FyN+5Zxw+BIAQZcLT?=
 =?us-ascii?Q?Pte4CQBxGk53plB+rJ1ceqEFNcK5agVlbE4AnmIlMrRIUo4H3yGohd0H8FLo?=
 =?us-ascii?Q?XjDdM/WmarurweUv0+nr1dR+rqxwnb2Hc2rlfueaiM+Ot2cmZz1UXb4HQcv+?=
 =?us-ascii?Q?DVQ7ABv2PVc1FyHRxbKrSPe+hDEjngh1nTUS2UcZKy6kVwdae2WEAT2fON0q?=
 =?us-ascii?Q?y/Pcep91oXpKsqc3RXouu5E5u5Un2Cdw+zxcWopUkMKc7Db/VQyw4acOqmOV?=
 =?us-ascii?Q?dUpFc621mKzEu1KmYQRszr+3VaqhWuJMstvjhzvwmenSm/27t6wRK8Qcqooz?=
 =?us-ascii?Q?yzsEbjv2C1mWgoMRI0QiH3oST65Nv/ooYs5lkl7J2ffiaCMshAuf2fzCuG0S?=
 =?us-ascii?Q?5iVuctTZkn0jdPmMXtaSalbwKkxW6pwWZFgtX+cIuabRoJj1EEvG3De2fWRp?=
 =?us-ascii?Q?bmy6I+pVteMHiEi8RS1MRXRpfGzSllPrjOuGcyjhszNA0VKqN/uE/5wvMmbE?=
 =?us-ascii?Q?oyGcgl4UXPfHTBqtMbr77wjiT4uFOmfz+er1IrHxKBFflrhzODe24MbLkAvp?=
 =?us-ascii?Q?qTcL9DXANlKyYXEzpUi5BvpxNU1EZr6xGD21G+8OeWoAcENH3togXtCAvJZJ?=
 =?us-ascii?Q?9PCCJeLLnLnSMiqbUBhUoEL+GQVuCqUycVCHvnyTfl90iAWj4NDQiyil6rbk?=
 =?us-ascii?Q?abbnPWq9U7DTjzaGaLwPOP7EZnIsX1uw38+w2J/s3H/GksQBT3uEILWn58S8?=
 =?us-ascii?Q?7NAWxV5ijpzrfHg0sMn5Ac774rJGCiOGyJl61LkrKgwazZYyY8t3M/oNW/Vq?=
 =?us-ascii?Q?iEAwBdY75kcCSOvqBOazCuTQvGG/zS4LBUnZMjFaND4hbB2cJjadBL5n/Yzq?=
 =?us-ascii?Q?+4oOamZkKZmc8rCG497cC8O7/ABkyCY1GrDEoa133XubVBGCzrH+BBqRK4hI?=
 =?us-ascii?Q?xp17y1CWNxATnX621BpW2L10UuzakSdb4QG2RBcVbq4H7yYFtmBuHlZs7+Ea?=
 =?us-ascii?Q?BwpfPLh3ccDV5clA6GZU384j44k0HovBuhPUFGcCtwwHBFuBC7jjZJpH1YSn?=
 =?us-ascii?Q?V9jvWXHPkpmaaMdkOsGIbnKF07g0b8uNHeWVlZw9D16De+TAQFp0l5SOM4dE?=
 =?us-ascii?Q?qg1/lw24jxfit0yPtVm7y+POe3WRyYJIT7j4jZtmNMeqirmozqRVW0+2szOj?=
 =?us-ascii?Q?2ugcRCuY1+8qBVdzeNdmtL5oRHxAsCN94Sj89UbJBtakEPa5gdVUAIUom3ji?=
 =?us-ascii?Q?xrUEhxr6SpHkGhJ1PSJU+mmHVGS9NcKg+E12RN5YxlG28RI9MrJSoruvp2iF?=
 =?us-ascii?Q?7xHGn3XHAbcMsxCYsGSH7qoNpsOk3cvhDqAZ8OORSZbXYGdGW/wjsWOxki4O?=
 =?us-ascii?Q?IApxAqF38o7u9s+46yW8sqJCu0lGnHHdOGn3epb/?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0f2dbf-a0fd-4ea4-a7e0-08dd9d6788d0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3606.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 21:43:36.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8qRowfqynfB6Ipe+eKJnPVGhclxD9a5tD3sKAKAfI1CsedTTI0rNDjrCIuQwws5X2Rxz2Vc+vT+3giGS9FjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3043

To collaborate with hardware servicing events, upon receiving the special
EQE notification from the HW channel, remove the devices on this bus.
Then, after a waiting period based on the device specs, rescan the parent
bus to recover the devices.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v6:
Not acquiring module refcnt as suggested by Paolo Abeni.

v5:
Get refcnt of the pdev struct to avoid removal before running the work
as suggested by Jakub Kicinski.

v4:
Renamed EQE type 135 to GDMA_EQE_HWC_RESET_REQUEST, since there can
be multiple cases of this reset request.

v3:
Updated for checkpatch warnings as suggested by Simon Horman.

v2:
Added dev_dbg for service type as suggested by Shradha Gupta.
Added driver cap bit.
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 67 +++++++++++++++++++
 include/net/mana/gdma.h                       | 10 ++-
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..999cf7f88d5d 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -352,11 +352,58 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
 }
 EXPORT_SYMBOL_NS(mana_gd_ring_cq, "NET_MANA");
 
+#define MANA_SERVICE_PERIOD 10
+
+struct mana_serv_work {
+	struct work_struct serv_work;
+	struct pci_dev *pdev;
+};
+
+static void mana_serv_func(struct work_struct *w)
+{
+	struct mana_serv_work *mns_wk;
+	struct pci_bus *bus, *parent;
+	struct pci_dev *pdev;
+
+	mns_wk = container_of(w, struct mana_serv_work, serv_work);
+	pdev = mns_wk->pdev;
+
+	pci_lock_rescan_remove();
+
+	if (!pdev)
+		goto out;
+
+	bus = pdev->bus;
+	if (!bus) {
+		dev_err(&pdev->dev, "MANA service: no bus\n");
+		goto out;
+	}
+
+	parent = bus->parent;
+	if (!parent) {
+		dev_err(&pdev->dev, "MANA service: no parent bus\n");
+		goto out;
+	}
+
+	pci_stop_and_remove_bus_device(bus->self);
+
+	msleep(MANA_SERVICE_PERIOD * 1000);
+
+	pci_rescan_bus(parent);
+
+out:
+	pci_unlock_rescan_remove();
+
+	pci_dev_put(pdev);
+	kfree(mns_wk);
+}
+
 static void mana_gd_process_eqe(struct gdma_queue *eq)
 {
 	u32 head = eq->head % (eq->queue_size / GDMA_EQE_SIZE);
 	struct gdma_context *gc = eq->gdma_dev->gdma_context;
 	struct gdma_eqe *eq_eqe_ptr = eq->queue_mem_ptr;
+	struct mana_serv_work *mns_wk;
 	union gdma_eqe_info eqe_info;
 	enum gdma_eqe_type type;
 	struct gdma_event event;
@@ -400,6 +447,26 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		eq->eq.callback(eq->eq.context, eq, &event);
 		break;
 
+	case GDMA_EQE_HWC_FPGA_RECONFIG:
+		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
+
+		if (gc->in_service) {
+			dev_info(gc->dev, "Already in service\n");
+			break;
+		}
+
+		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
+		if (!mns_wk)
+			break;
+
+		dev_info(gc->dev, "Start MANA service type:%d\n", type);
+		gc->in_service = true;
+		mns_wk->pdev = to_pci_dev(gc->dev);
+		pci_dev_get(mns_wk->pdev);
+		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
+		schedule_work(&mns_wk->serv_work);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 228603bf03f2..150ab3610869 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -58,7 +58,7 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
 	GDMA_EQE_HWC_INIT_DONE		= 131,
-	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
+	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
 	GDMA_EQE_RNIC_QP_FATAL		= 176,
 };
@@ -388,6 +388,8 @@ struct gdma_context {
 	u32			test_event_eq_id;
 
 	bool			is_pf;
+	bool			in_service;
+
 	phys_addr_t		bar0_pa;
 	void __iomem		*bar0_va;
 	void __iomem		*shm_base;
@@ -558,12 +560,16 @@ enum {
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
 
+/* Driver can self reset on FPGA Reconfig EQE notification */
+#define GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE BIT(17)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
 	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
-	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
+	 GDMA_DRV_CAP_FLAG_1_HANDLE_RECONFIG_EQE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.34.1



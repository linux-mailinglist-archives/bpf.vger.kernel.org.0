Return-Path: <bpf+bounces-57665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5215DAAE5EB
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2613BF242
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8DA4D599;
	Wed,  7 May 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LHumsCHQ"
X-Original-To: bpf@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020125.outbound.protection.outlook.com [52.101.61.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704E28B7EA;
	Wed,  7 May 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633571; cv=fail; b=LvFiFL6uxCuKp1RmsAd3/j3SVLnLEhifCEJj2+2v97QNPEbaZSGtN6DdROL2nVke0YG6vwlEJ8DW742iUSElspVTmkTJ9inyJjrL08zaH935zsR4ZWGDllPN/4FiuFuWVkkaWOQLx1DoqEtI4fFbdRha8BOWTtXsFE76f3BTb5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633571; c=relaxed/simple;
	bh=cek2ZGdDAZZ/CZKdCPaaN6KMtRjGM1zyoAskoXtTKOo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ACWO2Ww4VucPJxZoAj2tQCZiFC1//oQgNuAzLSNCs79fRKf5AuwVeU7evfw2DfaA7y/MJztNV9iq03y4ZD8VJnbpTl4WMRCNoiLpKTpJltGOo+DXZbG5t1lwYCtXP3WCdYwAkUNorDaYjYiiFRZTwuHg/9j1TnJjgxRieGtKJdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LHumsCHQ; arc=fail smtp.client-ip=52.101.61.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnYjrDg6BRomRrrVkH+kRpaEk1o9/C7r1haH5xVbwZsvv8zYHWXWUtDHU95lGZkLjEU0KulseR7E14Fy3TeIAU60arygUtv3PARIqFFJJXRPx5nUv6ZlW4p7Dko8tL6co7Lrwg1Q7rFgIJu5QPZwawA+t8GF+K3tsm5x3HnKgUw4RQN12fS4l8OrjBppCiUgdwLMwfF16Jfda4e6oPQUxeRLY0Evmhwq1iZDEIcVeVTUJNWYHxy7RDm0QEj+9pU8F1eC8bo9rEcyiU2idaQHWGvzU038K9HtQW0FPU0oSvA9c+mW52PIRu2YEWZxZWMgpY/OAgCdFWscJ35IjP2ukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScwWN27k1a8cYXP3CAKrgled8pU81Yy7slLf5PSJc5s=;
 b=UrOWL1pLw/SIxQLVPj8Nq8D+cdHOyfGjXo6AVQDF91XKcR84+yHXG59LxEiYePnXSZ5kqh2iSuJHzK5TFvYsBhLnk7PH2ivSjkp5TPDwMdWHmB86Vfbp7gxOS1CoTWm/NDpWo8TDfKyPWECMUtcPW18R7HCaWHaz5XAICZaZaQ8v7r8Q9mkm1TZ4XcvHLkpiqDoEeoMmrdWu2X9SIgEc6RAIFaW5oKqv7lQlkKng5UxEdJfXGGZEGqKYh+e6DSYn49UAkAOOHFcssT3194EvcjWaov9uZ6fwVixV0memHxyxSIEetyJlv/uzryzI2sqvC/U09omhW+xLRAHKOKO5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScwWN27k1a8cYXP3CAKrgled8pU81Yy7slLf5PSJc5s=;
 b=LHumsCHQZ+ISjTQRtaYHNhuYXVFr4Cq1dcQySQE5CdB/3X7xmRTqF9NUrwVSFsALCA6LP6eknj/jtrKnU7HAg1yv23c87jQatYNdZqbPHAhvYAxrtK81QCZb8+yk7m1hvOWpGrcAC837+7nrZJ1Cr9kY+3N7q0A59RkRnr0014c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by BY1PR21MB4489.namprd21.prod.outlook.com (2603:10b6:a03:5be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:59:24 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%7]) with mapi id 15.20.8722.018; Wed, 7 May 2025
 15:59:24 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mana: Add handler for hardware servicing events
Date: Wed,  7 May 2025 08:58:39 -0700
Message-Id: <1746633519-17549-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|BY1PR21MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 6428d717-0b39-4dce-4447-08dd8d8022cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TXDzT3U8sG79nF5hnWkR+G8A5AgH5Dhxdz+QeEmCUzYVIcYEBDag9Fxt+EoR?=
 =?us-ascii?Q?nw2vrjDdJ8ikJI6LMYJ/0Oc6s46zeihrapArpGTIEMYZtZFeM8nQ+p9POipz?=
 =?us-ascii?Q?F5SU5TTz5/ufkeXDkPegDn5aY283YTOesOU96c2LUn1qmfcUZrARUSH9HmHO?=
 =?us-ascii?Q?uqB0cNgdeAlHodi7HhQcYEu9trYC480g8efCyiVNEXLUyyiDNbTXNrtIuluW?=
 =?us-ascii?Q?IimQAoMAP6D++VgHLSZGx3Wq2iv/fxS88pYjTNwvbr4ckHAx0VKkAweA2uQW?=
 =?us-ascii?Q?WwyVamWQHFh1Uc3p4cNwdDgqDELoV/uYlbpkUSsGKgTDqMcdF1lBQGvPt8FF?=
 =?us-ascii?Q?WShjrpd80eZ6Bf3TXXvSEvKIfEw2557oFBvnMSCg6g6NfvgO5h0ZpCPJ/cne?=
 =?us-ascii?Q?Vw47HHC+w72jzsm/z1+2Wm2v0zIsPLvuxke43G2ATjOzysUGL7LRcwyNiUha?=
 =?us-ascii?Q?4bsC7bQBSwVfFIdjxTsf2xKGYQWeyrJLmebZpSEw3l7UQkP6zhlfq7GqQKoT?=
 =?us-ascii?Q?RADnBYTUthADwyJOIbaN4uWKo7piCY0ZSVHi3pmpupaNQphaWjXEewPh5fL2?=
 =?us-ascii?Q?UVOslg+E8j1qAkuE8blSFui7T3m/RWox6BuD4IDNzZQk3S+gtx47JrtNo99W?=
 =?us-ascii?Q?30a4WB2AsWuI5wdWLV6Ia81s/S1VYpvSajVrqJAunnqeCT0ZLLVvdWNV4A8F?=
 =?us-ascii?Q?vkzLSLhThaAPtyker2y7MLf3jQ0+rNg9SlcdwbcJvdJiBYXEYnWzEUVy+Dyo?=
 =?us-ascii?Q?XVyYiMcEP9eeI1ihEAI28LT2uliYgljRN3arajCNC/5cId6D6zwj7mB6U6lX?=
 =?us-ascii?Q?4+9jrS+VkiAZSw+RQilf2jZgEoF29WpOZVugUeujPnPOnQ7rW6hO0ggzlpNs?=
 =?us-ascii?Q?5aobeUf3AzTQ0pp1D0wssC8vs/zCymM5E56VXbMpHqFdEg6mavhkx634mwV0?=
 =?us-ascii?Q?4XWNa8CRxeRSRcSydwNf/xeyCrnnxLMybc3hNIAYZMD/eBQMtZstO4uY9PhT?=
 =?us-ascii?Q?oEpS1kdHumrmLZA2sVZtaADUwUr2WUxgvEfjrVhh5z+9hzajUq+F55x1s3W9?=
 =?us-ascii?Q?+8QK1GNUtzQS/ut/y/vaFy1dSC9qgyCYayp12ohvH/L4DD6lNVrLtfim7nuL?=
 =?us-ascii?Q?dMFaTpj8/I1ORYBWgdg9WkuIA+hKcT87FHuXP7yA4urwZvwrk3kQ9p2AaAZj?=
 =?us-ascii?Q?gPW5pEmAhhHt3zxrN2FE+cX9Ep6RxxYB9W0lI30MuXAgc/EFE9U87uP3Y1uG?=
 =?us-ascii?Q?tT9PM/q7ChG5NqYLRvXOLggb1i8mTL+VtNzTK7zTnL3PjTs4iWrZvmLMwLP0?=
 =?us-ascii?Q?Tc/zvEJjUSE/lP/XalZwVTrsnUnI4Zy+kAeaDcLT5EnDA/BDZb8QvaEdvO7J?=
 =?us-ascii?Q?dfQYHbyz/luantqQp6v5PSB9Ct6+AlnzsaFJLhsRyXqZHsFGXupwf9kyBbwk?=
 =?us-ascii?Q?2zaxDeqngp3SA53fcCkCEzUuIC1Uen2/8gnO42f3VPbbvuVESJMyFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xg5GBEshmfd+X0/Ge+WDkJ1JUD3A+BffSvSn2tg0mk1iuaDLS7rQqnGqhfpN?=
 =?us-ascii?Q?J+kGu66FFMjaicdar5OAR60H/pZCye2+vYAUsxAAD9c49lOe8nGzbgBbyijT?=
 =?us-ascii?Q?LMKY8xjg2HWSf0jdt0nAtyBuxoa3EurTo6UMZIkmobe6V7qspL7bsdIPzAzI?=
 =?us-ascii?Q?AQHwqD/YsC0mfFGudwj0Tasj5jEcE7bifnBMNf99mUPa8ksrc1V89JHaXCTY?=
 =?us-ascii?Q?L6XFGUQFo/bQsG3TEkoZlJApk00fhOkidBjX7GL85jK84svzAjFEnFrKlXFB?=
 =?us-ascii?Q?GwVSxuvWOyolPFd1ZiSDQCqJ6mFYfcycaUBcOrtSNhjk1jJdQqsARYMVuRqC?=
 =?us-ascii?Q?bVY6hmvJM3ruayoCpHrSft4Czf4QMdLodSifP1Ct4XJyYsbnuohHJ/xObIPZ?=
 =?us-ascii?Q?/GrhJxGIvPg3V4387JhJhz6ElzB+4jaeOZ8/SfxHuO3/3GLDMj1nqIYNOOj3?=
 =?us-ascii?Q?EOmlK6jZzuVyeIGF2tQ9P8GJeJFG6ITpmaARMSJkOTpliIAyC7w2BCAnVzK5?=
 =?us-ascii?Q?sPVqHUnRWrEYQnD4xRhQydK6jnSxKcEWDGDnhLVUi6XgM8Px7MhoCZFXNfb9?=
 =?us-ascii?Q?iw7e8GwqSxR+hnogdbRrx7WYrM3yyuxgGU89RhV+8Y5I64tt/nyYZmxPRbul?=
 =?us-ascii?Q?YNi5PIcD2CQbGbwIjAFZIhYO8xlV96XQwM7fNTKYsGLqneEvyG3phpy23npF?=
 =?us-ascii?Q?pk7nJySIi84Mvddkov1XBvur26Qcl3kgcTlfGvRlXz6hjQMQXxiHBOvY4zXp?=
 =?us-ascii?Q?5s9i1Q14eP2two6BvuXceqvJkrhT1yO6pOaUnSgrIOSGNWZYAna8JjznBfOw?=
 =?us-ascii?Q?OQjs4pLPJFYOvzrNfXC8/fX2/cQ+zIlRu76efu6l6K/xkqJqr5uRteqhdWx2?=
 =?us-ascii?Q?QKHMONNZGJmyc1m7+c338NkUCEmmjH/SszcggYMD36y2ZBEOsy8eJITippYV?=
 =?us-ascii?Q?MqxGhenzyxa1vbg5MbYGJ5VUo7KxGbRvD0k/8ylDY57oD+UoITAUXjxDlPGb?=
 =?us-ascii?Q?Bc+XR+0nCYjho2bxOw1SxpjT6HD0J6qo19W9SDr6HdCce2/QW/yhtM/PJV78?=
 =?us-ascii?Q?qhGykB9wTARbGhhgPv2cXUMdaV8u6QDRVUiB/0qBCPtl9DX0ETYLrV+yLRsN?=
 =?us-ascii?Q?MB2acaJKZ6UE/iq/RUvGvGlIOQH4af3kQkrSgxo+AEEEha/9gfsrRZaIeJ1g?=
 =?us-ascii?Q?YtT+7cAIucJUKANROpp0ezCAk/ZIBo++tyEMk8wsBZxvhJaTg9Iff/6cqADB?=
 =?us-ascii?Q?Foq67WUGMh0k8fyCy5qvZSqv5dJPvV5nQ0jkevPzgJb7MZ2dUggvzGh1Jg3o?=
 =?us-ascii?Q?WJD/TKi7mi1sW7IY+mAxVNX98KGmvam7nw6hPmADQ3wa6dAc7/t75U0CZXJj?=
 =?us-ascii?Q?/niYUU679ULc66ABSVe9I6sMMzNWRiW1HCctrfjfzfVgCkl7kbKfDBCDaPrW?=
 =?us-ascii?Q?2xCDEfmI4/CtaIoX+NThLNEcYO5mg5qz+ca5F7VcuqGsy1yz/5feGCJfA+li?=
 =?us-ascii?Q?qiAiVVD0ZAjHqeCq/ZYjgtQGDrd64dJRrk8uhYPkvrHZrQSd5BwcB/ownG6m?=
 =?us-ascii?Q?JzHyrIAZ21/Y40nZRgFiCeNxDViGCY6fsvZJanMo?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6428d717-0b39-4dce-4447-08dd8d8022cf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:59:24.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ot2517ozBJlAbE17Zl3Su/OOnMkpX46JCyqVleNrRJ9oFsM0dHkVRVlTg75Ujwqkn4dLvf8EAtOOgCVZSZ13uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB4489

To collaborate with hardware servicing events, upon receiving the special
EQE notification from the HW channel, remove the devices on this bus.
Then, after a waiting period based on the device specs, rescan the parent
bus to recover the devices.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 61 +++++++++++++++++++
 include/net/mana/gdma.h                       |  5 +-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..aa2ccf4d0ec6 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -352,11 +352,52 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
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
+	struct mana_serv_work *mns_wk = container_of(w, struct mana_serv_work, serv_work);
+	struct pci_dev *pdev = mns_wk->pdev;
+	struct pci_bus *bus, *parent;
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
+	pci_stop_and_remove_bus_device_locked(bus->self);
+
+	msleep(MANA_SERVICE_PERIOD * 1000);
+
+	pci_lock_rescan_remove();
+	pci_rescan_bus(parent);
+	pci_unlock_rescan_remove();
+
+out:
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
@@ -400,6 +441,26 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		eq->eq.callback(eq->eq.context, eq, &event);
 		break;
 
+	case GDMA_EQE_HWC_FPGA_RECONFIG:
+	case GDMA_EQE_HWC_SOCMANA_CRASH:
+		if (gc->in_service) {
+			dev_info(gc->dev, "Already in service\n");
+			break;
+		}
+
+		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
+		if (!mns_wk) {
+			dev_err(gc->dev, "Fail to alloc mana_serv_work\n");
+			break;
+		}
+
+		dev_info(gc->dev, "Start MANA service\n");
+		gc->in_service = true;
+		mns_wk->pdev = to_pci_dev(gc->dev);
+		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
+		schedule_work(&mns_wk->serv_work);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 228603bf03f2..13cfbcf67815 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -58,8 +58,9 @@ enum gdma_eqe_type {
 	GDMA_EQE_HWC_INIT_EQ_ID_DB	= 129,
 	GDMA_EQE_HWC_INIT_DATA		= 130,
 	GDMA_EQE_HWC_INIT_DONE		= 131,
-	GDMA_EQE_HWC_SOC_RECONFIG	= 132,
+	GDMA_EQE_HWC_FPGA_RECONFIG	= 132,
 	GDMA_EQE_HWC_SOC_RECONFIG_DATA	= 133,
+	GDMA_EQE_HWC_SOCMANA_CRASH	= 135,
 	GDMA_EQE_RNIC_QP_FATAL		= 176,
 };
 
@@ -388,6 +389,8 @@ struct gdma_context {
 	u32			test_event_eq_id;
 
 	bool			is_pf;
+	bool			in_service;
+
 	phys_addr_t		bar0_pa;
 	void __iomem		*bar0_va;
 	void __iomem		*shm_base;
-- 
2.34.1



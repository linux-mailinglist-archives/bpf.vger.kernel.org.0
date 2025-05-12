Return-Path: <bpf+bounces-58046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A98AB4544
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3737E3B555E
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B911298CCE;
	Mon, 12 May 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jbm3NX2P"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020095.outbound.protection.outlook.com [52.101.85.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267501DF72E;
	Mon, 12 May 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747079907; cv=fail; b=E+9NPRxHFDqEDzGmkSZXrWy3obo0WdMQclk04f6YF9v51TmBf/aKJ+LtpCYqvsTnlrrdBwuupTJEzjo2qj4VO7yYdkmPLMh6RWD4FCl+LA8URqJBn1Jq+Z+gXqALlcMmD9osk8zUKVrL1cGcrfvC5drHywbWtGR4833tS2Zgx4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747079907; c=relaxed/simple;
	bh=LEngm/xLPpsFgX+gUxZX/1e29TQi4ivFUGuVYLSKgiE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HjxxhZjJ2Sw9T5bEiMaCbCvanQWYhXS+nIaHciWtDFcnzvVMueGNmyk4QzK0DLTSHyxL/tnFZMb1BQfBu6Y55vUAX2bbaxzHVRm2w63gUgfeZAs1WBqqlPjCnuCZ3Wwch5tehplfEyqsXUtpb4VqeLsY8EvqrzRj5uwKxFiEzcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=jbm3NX2P; arc=fail smtp.client-ip=52.101.85.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGR8YQQ85K+HnBXpmJFqN5lOr2uPI49CfDcDygexYSmCHVL5wHBAm7x3B3MWvrG82FebrpydlhW6TfNwEKRxZxpL63ASRDRmyCSju/xqd5noYEJwjuh2knzwGYcIiijKavDr2/wETMwlXKCdzhncsV1CqnSP300kff6A5OWlTV91rgY52lWSESdp2ReRbRGAO7inljgTip1xamdgz2wL1eva3WxmmR56Uq3dLQFktwtRIaacSaS9XzRF3mldQ/e84n5q/VAlCqKL50hgbTymrtgK/0tV34lcIXJ7eRodGMQj81MvMuW8YdJxeR2GIWzbLoXRXMs9tTThipKjYFqDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQJDZcPQXpthoi04DZYKOPKMiwpU5vd1cMvpAegNEzQ=;
 b=T/OxkA54nE60dXDJq5ZqPhvpQ7/6wrf4AK1pMQ6T88d3pEg9h6hO93cr4vOHG7mXriRh8AHjdYwjRlPBj5ATnsXKAQmh0jWnXgEFnLOv5Q3CRHaTaDY59Mmph+rpX5+Cw8ejTSujKOtDCzc8LLZb5LiEq6H9RRrHIfNxb7EPbGrWd0nN9PiLc4zNUgFQVXFfFZ7QqlMLZ6etYUgpgDJxHtZ1lk5AmWNrQ8O9XQ3godjfDK1G66hQSu3sLZUfHiLcNcUucDT0VvpGagQgY0HQxLIrPAH3nWbymbauVSu2PnJHFl2S1NFMafpAJWJpS1B6kJVEN0eTxrK5wKu1eCZb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQJDZcPQXpthoi04DZYKOPKMiwpU5vd1cMvpAegNEzQ=;
 b=jbm3NX2PjtNkBmgKHPjfzjnY8QIOeeyQ9rEdLerfjgAyA+PHN2yoOp03cgJQYOMl3Eeo2zI/iCxc+WlBmw6VZSU4r/oDTls715WjG6wkzbl7J/aYR2eFELkvX/E5Qrr0eEYXgXRUk7raqfHjzJmCVxJiaeCft/4gtEr+KzQdxIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ1PR21MB3411.namprd21.prod.outlook.com (2603:10b6:a03:451::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.13; Mon, 12 May
 2025 19:58:23 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%7]) with mapi id 15.20.8769.001; Mon, 12 May 2025
 19:58:23 +0000
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
Subject: [PATCH net-next,v3] net: mana: Add handler for hardware servicing events
Date: Mon, 12 May 2025 12:57:54 -0700
Message-Id: <1747079874-9445-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To BY5PR21MB1443.namprd21.prod.outlook.com
 (2603:10b6:a03:21f::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ1PR21MB3411:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a2ff60-34e5-4001-89dc-08dd918f59a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yY95ImzLmYS08RjKPnEZ/XTgEFORK//kYuAPKKabzf1iOipjGZl8fe1vqf5F?=
 =?us-ascii?Q?urn4lvynXfnKysDuZtush3PzLm/3Hx5qRfSUx201EliFZNdMRYibiMBf7xv6?=
 =?us-ascii?Q?Aw6eY9+DAsi6zHKSa5ayEBS69y1g+z0INqDvqg3sAz9BIx5/pIzhHOxsodZB?=
 =?us-ascii?Q?AaDj0/T+hTinnVyMTpdpJgKrcDzRmyUTo+F1IBTRMMnOu3rqXZk4jf84hO0J?=
 =?us-ascii?Q?LeqPMr0TFDA6qLoarcFTPZiXf1L8Z69Khj5S+8CDnPtlaDhCuj/haPm0MHzJ?=
 =?us-ascii?Q?pEGinm/C58yTjt2xbcgCHDyjXpG2HBN87kNYoRdo7QJR8FPtop7yPSxgj/X5?=
 =?us-ascii?Q?6aXEC1LvH5FuAYEhGc2uMWV30a2mqUnQXywi4QEUKNRVLWPQuU/m6mHfleUI?=
 =?us-ascii?Q?tr/V6KPjEjAwPkGxcE5aokuu3hFUxBP9cXGEwVADfD6yptbSvdewbVQ2wYLn?=
 =?us-ascii?Q?SZJmkSpPXLlw3q+K9ty68y2FLaPxWJybCocDxoftYG9H0JnmKtPvXYrsfbPC?=
 =?us-ascii?Q?cGxgf0l6fZ3yRYO2d8mMOf+lpnR+ta1DO1SnZz6OaOEyC6kQm9UNGi/yQtjf?=
 =?us-ascii?Q?dDcC5IsESISrkpmY9lOWWMBlQEG08YI7+ljmR7AijOAetHZl/pn8RNbpuXVJ?=
 =?us-ascii?Q?0dp2Blgmqg0BOA6untkXKSiu9KUQdyv/S5y9TETUrf+liDizN18oY/5by1No?=
 =?us-ascii?Q?Be/anneP61mzB/8XCDRgXpvswzigzFaifytKr/769gM16bo0pSsizWRG8+io?=
 =?us-ascii?Q?KiVHbtstKtjMGxZlbPU06rT6UWxp7k5gY+74/8/4r7gvUFWaJ84gJ6gri+WY?=
 =?us-ascii?Q?W9UzeqZ9Hf+NzYNHH2b30z+u/9xnBng6VOY0ao9YtDwtuFtdIralevWMK5Aq?=
 =?us-ascii?Q?1EacTuLaHlW9ZKngPoz3mG0kZbBjsgleZNvQDZcJNmr9kVdPiZ8sW6f1lTp7?=
 =?us-ascii?Q?VKcnKoNemJaPY83mcrf2eiTHqGnYi8yxv/df/zlde8XahOSWvpydRjR7JX8d?=
 =?us-ascii?Q?2ijBVcDK6li4J/PDhlFMSMLtrHJpl5QVmRmvNK4D1l0s2ydmdZcAP/2l9HV7?=
 =?us-ascii?Q?GtK0yfCFVO3pdwbxzQV0nf+Ky3P0tC3Fm7AQCrueFMiYCViseBYeSLRQwdrM?=
 =?us-ascii?Q?Z0Vtreea8M5REXAU7cIuoto2Y3Cq6ISn/20t2RNsxaNhbfBMIfQQg3AEGScb?=
 =?us-ascii?Q?O5+MTK3G/EteMzAFEn/1sTRQ1WFhVNojJrvIXe7xWJWmZpqBmR2AqplLiBCC?=
 =?us-ascii?Q?MGIx7erNVkNnIFuKzkqkXIxEEaSwAUKMexBVqNmXp1YnBE4X/XkDjCcuANj6?=
 =?us-ascii?Q?Yz5x4Z9AGs0/yZzpcIW4+2P+drYutw0sO+GbZizH4d6QZ4E1+P6KqOuRXrFY?=
 =?us-ascii?Q?oV8mL7Bw59ecyqMFlSi6ePXOJUp+5uJ7Y2VdOjzZ0Xa+HWy6SEDQFRY+whOX?=
 =?us-ascii?Q?8SeONZjfkcTGml16LeLwittKbCpYB2JCDqmoHzzgmikFvCRzLIJufw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Na9OKzc4WV+J88CTGa9hGpz2mNukK+sEYUlO98y7G2u+LkvXbyad9anAZfjm?=
 =?us-ascii?Q?eW09qv+e0Kaiqy5+abz4pXDS4AmYrkNfdEsPJczcSBAvYpDfQXtanGpqBxlY?=
 =?us-ascii?Q?vGyYws/jIQvp6UOTFTDzixrRnMPzrxyEAafYIBDR5oipBYeYM5TqQbZ/lXp3?=
 =?us-ascii?Q?ys+fVwl2RrwB1v6wzEtfM2+WRjU8TF1DEzraBY1RZhYedvgbvwbqHvd4uCcq?=
 =?us-ascii?Q?br7bB6nVHfUMTrKCn7oR8K4KJ2N9jYv3N36DYvf3U3BiMvTyktAR9Di3u5h7?=
 =?us-ascii?Q?PseMO9WOD7c1opFkWhTMdYg3PjbKd/P05vfibMkDWn7pScxnMObi98w95B7U?=
 =?us-ascii?Q?/JKCaIjCJ7FyTLJ03I1SXNpA9IUUF8XTVNw/bZJbbKFzkiRlco+bRZ5F8ldQ?=
 =?us-ascii?Q?pBCqbk0BceeiLEggeiPz4LRsc9b6EUxDmOWqDE7Q0E3K7ZbMBjGdTS7C7eFi?=
 =?us-ascii?Q?DG/2HStIS59cCtHSFHFIJ44ewFPzrCMQLmI97+nOsQ28k+Vc6hbB5f0Nnucb?=
 =?us-ascii?Q?FUg6K6Wj5yv2fZSHAUbsjPQWxnxMK3Us6ZJnjH79km5G/hMrutKf6bZSdgCf?=
 =?us-ascii?Q?A0WTRXL+AXvtSp4fivePXUFBuDt8SSnQG9qa6SGzuoyiCZSnTQybqSaQwrP0?=
 =?us-ascii?Q?+CfFomzRk8uYIx19fYJ1a1ndwQ7oDcr3tAAVHOzoQRwJ5ILuvcXNXctWHGhE?=
 =?us-ascii?Q?bZrWMOAoCOUGDhd1ZR1PbYTHjGDVLxcgkWUHpedzcSNV2FNI7OE1ufI9kSQN?=
 =?us-ascii?Q?I8y/P2Faqj4GBoQPvZlkiyIBSrvOxX5WNLVgzAZJER3Si5BGoO6UryD1fKxO?=
 =?us-ascii?Q?sGq+JEwd/uUpsVuS8WFrA3/Z0KC+Ul8JSkQDmJ6tWUiQkOskkDzwgnFiaRkW?=
 =?us-ascii?Q?zYk2ig4UEHJV+km714CN/jsfdtlhMgwu/5/+v5P3cEp6kqlHfOxZAVXF3iQo?=
 =?us-ascii?Q?bR6NvVLIuBizt67oCTXviAdyjM4zLoFCXPtq6ChQxmaraUBa6qIGLg193nlk?=
 =?us-ascii?Q?nqPydLGIOtTY/fPxmE5emEuqlg53LZRTEBBxccGXgYk6hjHimVuzbOSfvGPY?=
 =?us-ascii?Q?2Iqs4rUBKGOx9iEpVu5qKyjles/fVhw5iFE6TpDHRTh+1WfT5qHz7+mkVYLQ?=
 =?us-ascii?Q?b+o/ZQp+BZeC/QonXBcXS+ZggubDSzOyYG+xI5AZQbSm9QB6eM0FLVsGXP6s?=
 =?us-ascii?Q?ES2BmEMFh0CKtEv4n9vGlk0QZGdlz74Y9vH94Z8SHySerQ11rmVNQOlyJx0Z?=
 =?us-ascii?Q?RoL65X4YaamRSPEdQVZSK/ctT6v53OSxyBdRDfyED1F/PSM9Enn1z5m42f4C?=
 =?us-ascii?Q?YABN1tGa2YVYVAJckn84hArP6njZYm8b5AfW8lFFhdJfopOlFXoj2pYCT23f?=
 =?us-ascii?Q?5DEQJtuElvTb1lW+mKwUxhSnYUkP1B0WgI3O8fwi/bP0xnO1tekLxoNuGqEU?=
 =?us-ascii?Q?8zorNRDIpbFYST6HO+e03H3cyvvjxwaRdanpjOa9+n6fji/YbCLwR7ZBI+UI?=
 =?us-ascii?Q?UowiEj6h+vroaK8j4TJm/juit5kRJiA0MDnMAvbs/6ayAzGvtTPOA0kuqjr+?=
 =?us-ascii?Q?m+gQL7KkV9MsV+AAD2Pl1FQm3V5Oaoe7gBApKPjD?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a2ff60-34e5-4001-89dc-08dd918f59a4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 19:58:23.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Bz3ncaIcLnEy0iXLhgwcVesEmW9xzhhefrRok2tGAT5AIE6lrj3XIIYzZyGaGlZWq3WTe6cirLO0uKAlLoMSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3411

To collaborate with hardware servicing events, upon receiving the special
EQE notification from the HW channel, remove the devices on this bus.
Then, after a waiting period based on the device specs, rescan the parent
bus to recover the devices.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v3:
Updated for checkpatch warnings as suggested by Simon Horman.

v2:
Added dev_dbg for service type as suggested by Shradha Gupta.
Added driver cap bit.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 64 +++++++++++++++++++
 include/net/mana/gdma.h                       | 11 +++-
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 4ffaf7588885..3102bd2b875b 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -352,11 +352,55 @@ void mana_gd_ring_cq(struct gdma_queue *cq, u8 arm_bit)
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
@@ -400,6 +444,26 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
 		eq->eq.callback(eq->eq.context, eq, &event);
 		break;
 
+	case GDMA_EQE_HWC_FPGA_RECONFIG:
+	case GDMA_EQE_HWC_SOCMANA_CRASH:
+		dev_dbg(gc->dev, "Recv MANA service type:%d\n", type);
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
+		INIT_WORK(&mns_wk->serv_work, mana_serv_func);
+		schedule_work(&mns_wk->serv_work);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 228603bf03f2..d0fbc9c64cc8 100644
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
@@ -558,12 +561,16 @@ enum {
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
 
+/* Driver can self reset on EQE notification */
+#define GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE BIT(14)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
 	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
-	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP | \
+	 GDMA_DRV_CAP_FLAG_1_SELF_RESET_ON_EQE)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.34.1



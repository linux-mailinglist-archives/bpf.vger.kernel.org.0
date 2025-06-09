Return-Path: <bpf+bounces-60052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780CEAD2116
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FAB188A7EA
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD0C25DD0F;
	Mon,  9 Jun 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F0jTwKPU"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023109.outbound.protection.outlook.com [52.101.44.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243AA25CC54;
	Mon,  9 Jun 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479843; cv=fail; b=jMKxNrGUkARUzwcX3kAxzEV5N74bKgZKS45EaeNbUq0bskrbAav5F1+ai/o6exuEgfkhXtXXmVSm/lQx1Q7aRpJPOZYdj4g3EGWUYgSY+xgVVVQ20FHV1PhqOnH2Eqw/u6zs1T7TBxpYfzII7iv8tuw05ZbKNfeJsFuBP2Rr/WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479843; c=relaxed/simple;
	bh=f8VK67e4BcQW2yIVhiPqTVje5WOnKHbb3YgsJYhvXdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ba0HGWN4sgTDOejxJU5dbt1RuR1D5oztANJfFp+/btG0KutUtYQOav+DjpOA6az6pxRjxpYLH764xbeQJONV78vDfAHsN5psQxebBZl/xffnbSI2S8gJvjDOP01/n8Yms+alhchmx/UqjhqkmpgQWtmyiB2poAMGF8OXWDietwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=F0jTwKPU; arc=fail smtp.client-ip=52.101.44.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/sEkdSvAWFdVyhHLYTGbVZSkfgP/0cW51qTEDcgWKJDjuYmlIfuJ85SJzHKT0Nz//Y6XsYd1GepZZvxXh8NCPawTUZA3VC0nIwaOECohzB8BjCcHQUETOy3V9nJVxQZeS+p2Mr1rCEYBSXEa5Ggt1LSLm3SzD4mWxmcHlYlaOUw6Ynnx/HxOkrxEjO6kuEnyedHOjedrmfvVwV3P26QyMpSTnj9EnJep/+G4H7nmclfiDzcXA4V/8icftFt5ySUIvyzwCrdU1qhPfRcfWlu5n+lYu7RWRM6MJYTq8cJTpL443rt0Cufw6GQ96aPxf6B+YPP8xslVnqmPSJviziJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEVJy38ZhR1vIrKiCt4/w60bcbF60LsE0SdQYNHt1d4=;
 b=eozY3zPxbPhnnUtI+8ppYbuB/ArvwXhb8oebo2Ds4koAoxw87jlaBqtIKc9HFzsdJcQJH4z/D/nMfasuDxaqV7ObSS0VPRRm0WpoC4ql/mbCLivEdr1diPhy/qsaWVX58V/+4/eUkKVmYs/XFH2Zmhbu/AI0FcizxGbKAgIDwXlvtIsu/6T4pN5+W66x5RKGQmcxy7Wffa/FS+mTLRgTe6MHjjsuaQpW1wpOYxtkR8o9CGtV1mMiorHOuUvLYT5QuF7S9zyuj0aTCrLO5FJJx8FgTbdcdHJdnNYS4F4sNyjUGljxGgqRLsrcA81qn5knXBORx+YFLlSfn9m9RnCJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEVJy38ZhR1vIrKiCt4/w60bcbF60LsE0SdQYNHt1d4=;
 b=F0jTwKPUzmBxlRgWEJS0k3mTOCrnz+Fzg0UP21F0thG5L/9382WX/CX+jbfloqWrGu8ICA8F9kmcf5BjUSvAn0qu6ukK5V25ceNNXPBzv6QfZi9yeNdVsEp5ELTGd0CNYiO4Q+bDWu5n+NIdxp/gv7jL2BImABrj5V1pRHHpY8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MN0PR21MB3606.namprd21.prod.outlook.com (2603:10b6:208:3d1::17)
 by MN0PR21MB3727.namprd21.prod.outlook.com (2603:10b6:208:3ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.9; Mon, 9 Jun
 2025 14:37:18 +0000
Received: from MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::5120:641f:e060:2dc4]) by MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::5120:641f:e060:2dc4%6]) with mapi id 15.20.8813.008; Mon, 9 Jun 2025
 14:37:17 +0000
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
Date: Mon,  9 Jun 2025 07:36:04 -0700
Message-Id: <1749479764-5992-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To MN0PR21MB3606.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MN0PR21MB3606:EE_|MN0PR21MB3727:EE_
X-MS-Office365-Filtering-Correlation-Id: 97399c15-c88b-45f8-5b1c-08dda7632200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddTIsUCW3yULj0GKAfEJ5zGuLjhkVuGZu8pk7D8pSgJsdka1Ml7TCuwx4L9n?=
 =?us-ascii?Q?Tw3KNqANws3F/uFtNB3LKHWt1pcRmTaoZQBgLBJgQyxa/mqxtZ5f+B5F8IEe?=
 =?us-ascii?Q?Ns1P5EHRCiX3R3Sy3NVgIajyw6GAr75CSNJnsGbkrKRDl8jM4kHBFaAyQOTf?=
 =?us-ascii?Q?C3yM+hMjik+WxRoxdSlapY1YoJuj0QRaANdgfgqKqJ8Zp4+kR+Dz4LTo4Czc?=
 =?us-ascii?Q?y85un1SVEpYi8d4EioSSp/SCUUA1bQV7gZA2RdY8JZFltFwjQbwDpkSUXBtQ?=
 =?us-ascii?Q?I2rlR/OK1E2+qGSbbNO9UEyg9/FCzmnvdswdXg8qqmeA0CM8vOIy/jGdsfTX?=
 =?us-ascii?Q?ye1gQnELEgiELI0JQKLqJJbX/+I4wH3/FWekBxLuWFmL7K+/+PM57F3j7yUF?=
 =?us-ascii?Q?++KBnlP9urXGZzGSwEzglgiTB2yps7JhbRQRtwHBunyziNBRmycNsyaOAsdA?=
 =?us-ascii?Q?RS4rtL5UokJkziK77cMhkmaqU0LDMjrsvsfXMabbvZKumvfVWhKeWLEAEUiN?=
 =?us-ascii?Q?EU+UoF+LmxIvUTHAk97SqBiIgCztXK4tvZ/y82+PluG6QyVExS2QYoS91tUK?=
 =?us-ascii?Q?G1Kq/tjtU6go4MH9vOJYiHUUrgbVdDs4Up9JvOOPbXJ9c4JuLfPvMuvFEAMx?=
 =?us-ascii?Q?WNwMuiEYrMhujABabO3pCRWw0tA1jcvPkRuRmcOP4Qz+hTqHUqSzCH7bHwgD?=
 =?us-ascii?Q?zg8vxHkY1a3idYZ83UWCO8121OBhWNC/gU+Ic3Dw2lUxm7EnjORKPYcBHP6w?=
 =?us-ascii?Q?tT4zqzfOWj/apUIjRaCYFoPrTJ1zePlyMvjrwtoo+qGJnLE2F3V7ckA1SYex?=
 =?us-ascii?Q?avqwobsm+nb7NNpgKKH4o5yLEGJmuAUQ8vFJGAN/vVQ/8EINguzfdzpv1jMN?=
 =?us-ascii?Q?kdtUDSPSH2FG+LfEkdVhr1kD+89lMSDtB2GnISXRk8c/y06ZSa16y4p5V9ap?=
 =?us-ascii?Q?ag7F7Rr6SAlm47D+VHkRyKxNJmKU5ynd6O8tRMyo4eX+itulLSyUBvnIBZuo?=
 =?us-ascii?Q?vw9lK4PUlJpGKnEOyUg+eh6c806rEysJ5DfYHb3hNt6i17ZvmIfRCON5HQYW?=
 =?us-ascii?Q?nO7G+TSQOV1t1X/ABwNadFQzpmmjxn40bfnzr2hgooVDg7H0UkV5f/OqwQ61?=
 =?us-ascii?Q?27cRXx7nSW0ZJdh4/x6fKM1T5I+B149VtXu6rYHpEXxlITubDZOIOwdQtKRn?=
 =?us-ascii?Q?QDY9895ULmYAqrzFIYQC4/+H0dfMOoV05OumVQDerEJkYJCfovOTQo3E8nPD?=
 =?us-ascii?Q?5CHSMFkOAZbPRFbxdyWi0SuL9rbJQe19PUIE0sJOT/fBhE1jm2hXGBDja7F+?=
 =?us-ascii?Q?veRJBKQ6PTu3wHSEUX7AVEHgZ65Q+4xQl8rQfpSsolDnITJ7QYXziLTfhEr9?=
 =?us-ascii?Q?nM5BTeT4W9xryZAFHzLJgxJSgU7dW2f2bI4xlpcJuoqVIAmHG7wfRrebB7D5?=
 =?us-ascii?Q?Mag1CHTedU8plwEW3fGyXXNsleFlF1kMMDP2j3S3qSaaLuKqzLGOMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3606.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RiMwzWqppG4dyS3fHB1P28zbU+G3k/pO8gkPBRER+tBtoadYNGrVHgngp2zS?=
 =?us-ascii?Q?t4Re2LCMNTh4AZV3ysVk39g7mzTu5UzpQf4EUSEU2OgXMeOStHzkAfm5hvUl?=
 =?us-ascii?Q?CKzw1gsJ2Pm3TuBkT5j7ZqZ+y1XjOlwNQs637gw7NnK/W72O23b9s/KeCDco?=
 =?us-ascii?Q?mhYeEoja6rfKqE01ZbpcmhkubEwZXY0MJApx3F91OT/kAnNnnHPhcnBvOTsK?=
 =?us-ascii?Q?gWPnBEGASyEjEmlzBXE01HF/NaGSwuYhmG2bBkGxGExXv+6AV6TjwbP8OJVH?=
 =?us-ascii?Q?DaUhT9MNzkFKjXrUulrSqtpmEsekWBzasRIf8uDfcPLH9ArGEBlNK/irM0UC?=
 =?us-ascii?Q?xyimg1E3D1fAVhmEPC3hU3mTpDtPHg6RFJz6ipwkOwgMGButvXzEE8bvVjEp?=
 =?us-ascii?Q?uPmnVve2Vm6Hqg90ni9yw75VLy1TRk2siJnij3ce7ZcRUvLvg8VUN6BbsTKc?=
 =?us-ascii?Q?CVAjNMRxYbA8+uZGhFYKsuPXEciEsWBBkhE591shzrYsdpH2rakE6lVJhhPp?=
 =?us-ascii?Q?B2j3+EXaAqJJSfi4t6RoLOfo5yoxLEOJGN8+CkN5MfIf/Mg12VpPSWF5o998?=
 =?us-ascii?Q?aI5kvbFB2lLA0uSp+CcwfQFKydHXs9cT+3Oosbt7uFTl4LOjxFP1WT1xXfm8?=
 =?us-ascii?Q?Q6QuNc7XYFCHnK/W3gg4NFqjc9IS26FDBYFkLCRBnjuIko1BB1iNbRQ9f+hK?=
 =?us-ascii?Q?Be+Geyyc7mgN9rQhqCIsbzWa6rOVpVRr62N8ZouTZ7/pIp2Mmm3BpIa3yz6c?=
 =?us-ascii?Q?J3ab0OFAS87oNKQfoChqbx+kTHwA/v9/T4bSr35QX0ojKS3WiSWNmuXGBO1f?=
 =?us-ascii?Q?krgSDb4ZFkp4T5dPU2XedYa2Ffjpik7y+0DN5G0RvV8IuP/n0Y0PPUh9cN3z?=
 =?us-ascii?Q?jIGjiQ7A1xoABkFWoSww37zKbzPu5QdO2+VpOePEAZd9UOBPg0q8nToAyloH?=
 =?us-ascii?Q?neumb6kM2yRhpVtuFwhLl4PgXqdcBmV8khLSgo9d5X1DrdLZObfAW1SpmTnw?=
 =?us-ascii?Q?E5b/GDiwMXJ8ZNC7zU1UVyGaHC1U+SjnhRVmtI5mwt1g0H3aIHjNV/96t1IO?=
 =?us-ascii?Q?OsfFYm836bR7M+zHI7LeALY0LaM75reBvEW/AA+jZkUK9KxzQtk4CfEQJ904?=
 =?us-ascii?Q?GkvzOf5J3bKZ/dYdSZAHFS0ReSlu8eU93BYjNuLuphAqV84MsJhtmVd+weMW?=
 =?us-ascii?Q?nFqTChgQR/k4orIa2PF4Le3nGUH/hVoqAJU+cg+X8JbkmX7hiFD0tEcrRO59?=
 =?us-ascii?Q?wLDy++XpLEqANFpbzPhetqZFWOSY9zM6/LrCIoFxU2j6ulNf0lUUgzJ7FB3u?=
 =?us-ascii?Q?VTAbYnqFm3iDuRsiJusBdreW/CxFdh+Tj5T4eQdtv6DBHpAyUXIfX8PsHeYx?=
 =?us-ascii?Q?MUHRF6V9gwuX8qFC0fQU6N54V9LGUW9x+woF464H2r6d9IYsICclXfA4O0iw?=
 =?us-ascii?Q?2+FWB7GCC2LUe7SmNy1p27UywkLUlSbsNLnhbpMxPzxEdWu4Yzx+6DRs4A4L?=
 =?us-ascii?Q?xQejODAB1q/pPVGGhDObq4040dlCOCElR/jko1pu323n1fyj9+FuqHf2abWc?=
 =?us-ascii?Q?yzJKv5n0uZfsrMrT5Na8CHe43o0eLfxsvq1P1QFB?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97399c15-c88b-45f8-5b1c-08dda7632200
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3606.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:37:17.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KUEihu9lrR4ZjJ33r4+TbUj1k91PHkQOFJxhfSF3Mj2RVAAbM35i+dthOGYEYPOu2xmoRsLK+fV2qzSiQvHhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3727

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



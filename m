Return-Path: <bpf+bounces-53857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87B6A5D090
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6D2179FD0
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F021E264A86;
	Tue, 11 Mar 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bPMjhQFS"
X-Original-To: bpf@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020143.outbound.protection.outlook.com [52.101.85.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DA26462C;
	Tue, 11 Mar 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724008; cv=fail; b=BZtz9mnfLrrRnEQco2zHFuwb8GL2GIwAiJwAgdnKuz6S6FOpZiF246LI3KFd3TjS0zEMXVRUk9HDtKL9EM12xBJRGNfmDnEFBZRy5+Hr6tq6x355Dz0k7r3SXl5d9VgOSpmvjYXdj8iPfP64mKpwavjnfT7cdjH/FBPqdCo/n+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724008; c=relaxed/simple;
	bh=LgPH+DyIlSRITmrnlMnG10XrRBzOJ4PmfZNZR0pR3E4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oc2HIfsrsmVw4XCVQ7R3jG5SWGmC1UQKIrFc1DOunYs9QGKfWkknb40ACvsF+oVF0VyHECYg53Iul4nCa9MUduphQYSwzZuSCJ3g1WX5wco7WvX2q+dPnbeaxTWrqD10Y1f9on2SyQUNGc33YO48pYiljocQM4xFcJD+OokmCRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bPMjhQFS; arc=fail smtp.client-ip=52.101.85.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1Vitpqevki20Kp8kxf+h+5gv2UTUlS5ekAsPqibOsxO/n2QdTnRTuEewdr/D5mjmm5QtXfeb4gooH5fkR7xUladWbi/rGFav9YTQMD3Uejb4mt1SIjuOQSH+ZsTHfRgMM0/+lJQ9fXkS92BalLdJo7uh5wpaaFFQZ1tOd4T0FEpWPTwUhpnDl5XwICleVVibcOAkM2tjAXLfIhsWyRbXf164d6nZMR4lJaGpShhWW6lKpNnukSCtfyojJ1PttubMKz/V4n6GMPn7rR/742IJuzjOjuarZRwylyyogSfWjX3fvvvUXIYODJilBYQzfewCoqGsBRgbytqf8yycreJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwfUjudnt9L6qZ9VPPEDvpVZrWWTW5TFNeQ6a60MwIs=;
 b=eNcnJr/a/Ud2A96jhW1YQJ2JNuLbwmyFI0DCNgtR9QJH2Rj9VKt+5KTpfSQxh/LBkTsPUxiVt62nXBicqhMPEXCOoncTHYpZI2h8IEEPKwxyPM0UtSc9nZqJ50fFVKiaOOu0+HSUaGlwbJMpMZMv2HbXfei8bzEgLfeXHgoodGyZbtcOQ7zzxIBk6rXpgYLvXrfkSfJBjqVdoh7GFaiXDDk/XJbazw9BtRxorrdjZen7oYz51qZqnbnfj2pmmVAu6COY8O3PMSkrqhuOoV3S+9DYH/XwmhFFiMtpOxlduUzaehVObDPVXABZx0RWKoxMpOEbyHP0p8ngm29aImNaUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwfUjudnt9L6qZ9VPPEDvpVZrWWTW5TFNeQ6a60MwIs=;
 b=bPMjhQFSlmBn+hJB21TNvmwRpDA6jdwRMX6NMoIERZ2i4bXb6IbDrJEscjyLi2P+l8b78ls7YEN9zCPA3hT61iixIXRRJ5dqWz7mJ8U3QfTvTC8nXUBVL9IAm1Yn8KHvHH/lOoqhVp/6hmT02IBYgEbL2kp2u0RDq93UtMZtcVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ1PR21MB3576.namprd21.prod.outlook.com (2603:10b6:a03:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.8; Tue, 11 Mar
 2025 20:13:23 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::5490:14c7:52e2:e12f%7]) with mapi id 15.20.8534.018; Tue, 11 Mar 2025
 20:13:23 +0000
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net, v2] net: mana: Support holes in device list reply msg
Date: Tue, 11 Mar 2025 13:12:54 -0700
Message-Id: <1741723974-1534-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29)
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ1PR21MB3576:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f64be3f-9354-4c37-70c0-08dd60d92ca2
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?aJShAhVlBcanItYY8PbVrdLY6EIjyiF4dH39uBtOG7QTLTw6eM3DRMDW57oU?=
 =?us-ascii?Q?N8nywHF4gN2ue+rUnjoQ0F8wjdMpKJ9NpvnmQQW2CG7+aHTtVIGdMYNcrkIe?=
 =?us-ascii?Q?Z4qKPmnj8Ki/OdXi3k7ACddYPrR/8nofq9UU5/w0fs7F2iEubevlfjQUMoIU?=
 =?us-ascii?Q?yjbA4lJNLhNc01Jmw/T2uqxuoEeeb14/yS3X+uiQvUSa0W3+gyzHDyLdAbBA?=
 =?us-ascii?Q?ndmlHcTHB4+nuO8rFWHkzZMOMxOIaVCkX0ZULcccIuwkbtRwTA0S/EFOhnfz?=
 =?us-ascii?Q?jSCehGgWdfUILcJd3VE2d6RHR55Mf0TbUy9myIFG2XgbZQWeYuq9NJ2wXyTz?=
 =?us-ascii?Q?58Jmjdh45lSYD8FjM331ZYhgLx9mKpd09R3GQFjjZpf1xMRhB7JS+2O8i5Ku?=
 =?us-ascii?Q?SpcCyLsYLCbeZB/YXOl+qjjsIrFs0rr8niuJmW1ZB8LlpyNdg0Q81N4Jh5sa?=
 =?us-ascii?Q?ZhPvuTxBWXPtK51zyuhlePh/tigd6vxBf6ooH8LyudD0VxWaTq6EkXPKtpZ2?=
 =?us-ascii?Q?7pHeoGLliinqtdGIRq5SIuYJfcMGxiWcFmM6mgiQbp7vVyl+ldXFWo1xMkC+?=
 =?us-ascii?Q?a7M6Xsi1l5/faV5nnMmiNZR5xYIGJOVTULrBDd5PGBhHz6jZmx0kMchjIJkw?=
 =?us-ascii?Q?RS7cMjQuLpiGXAWlqUsJOkNjI1Wke3r7iYGhPy/wVeUZ8XyeLGb/F8GVf22x?=
 =?us-ascii?Q?YmcXqRQD5GggoojIQP+2R8Z+N9T0GcE6Eb3KoQw3C/s3XpDCklt6rRfAJLR6?=
 =?us-ascii?Q?gluzjJ2m+7QDIyzDEz6XhxMVJYDteyfRVFu8Lo02FRh4kWKDSZjqIleNUZHq?=
 =?us-ascii?Q?yClcTzt6tSk5itQeiugBJJmAITq4GRdoWdkcpfnrGpoC84ok9ErzsXMLQLM6?=
 =?us-ascii?Q?jHVNecZGRlDOnAV6o/YMEkWF6sk0MzL8nQdABdJOHGcgtrGlVvaUWDq4KP9x?=
 =?us-ascii?Q?h0qDUddO1FWvEJKVM+bTV525NSpbqiX7c6yusF5joyUP3Sgm2GmJcxwOV5S8?=
 =?us-ascii?Q?85PiqcUW/ejvK7vT2OCXmrLni23o64jqbBVEdtebxnuNdysla4yYHspflPjC?=
 =?us-ascii?Q?WbsuvXqItLlnH/q9a/gnLv3DLpiiLvzhS6OLqEF4ov03Ow3Wny4OddTLHmeo?=
 =?us-ascii?Q?uLpv2lUc4Yv4fBahu5Axzt8bj+pusQnzHrapd7nybGaAyihalcn3kwq9d+U/?=
 =?us-ascii?Q?IjfS6KFGUjXLLwoXWKMfQq6xePeZJUdROqKYmRS1Wiow1GSBFqZP14v8wIWI?=
 =?us-ascii?Q?+077PPEESE8A7HL3uRnyjcvriB/rKB9e3WOZ2tEpbyLXBHw7yOxeIO/ThANX?=
 =?us-ascii?Q?yHv/fJNKCFAlKVZnWAbShEcci+2XpSKeuO7SH01Sg7lWdecIxuMcoApHAEfu?=
 =?us-ascii?Q?3SM/G23RMabPXiyjRdNP31al1GsW2EAYZCOT6PnMIMZmIJLMcFPij8CYxGV4?=
 =?us-ascii?Q?a1NbBl6ka9nqXiS6v+v+7645Z+QcpW51?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?w9b26j7KeMPGR1pxCg9IpfmoqjEvC5f2nrPEr4zvht2T2jUspqEmLAfxY4Tt?=
 =?us-ascii?Q?JrkvUJz1Bm9tqcpyQsXoLydIosl4l1IIGuHr1rUpFWJoNXj88ugw+2r2xDXH?=
 =?us-ascii?Q?RJ8RcNTELiT3k1bUPbrow7+5JbUfVSQN6QB7Qc+cDehN3neYlYo9jGH5UwJe?=
 =?us-ascii?Q?M5KN82v6dQUYY11zqPlysOnjX/ckmFNrEgb5ZDzKHj92ws7DtWF+JTtLkmRq?=
 =?us-ascii?Q?9uvzczKtLE2ef7UttXnDS8/CrFIkyCtYTJNWzSXjDok1lleSRo3x6qToYtby?=
 =?us-ascii?Q?KQTEbZhHCCD/+IHWLj/W9zqknxE6qkZS7qV2gwEYbcmcHSMtTXb/EUN54o2n?=
 =?us-ascii?Q?qgzwSZdsD8mxkFNBV2FBdo5qEqFj5jJdchTamowPXVCgnH74KYIMu0iuBUdU?=
 =?us-ascii?Q?9YX5+G+Ius6sQ1HRkB8q03OQWz19isCadJP7uSSLrcG9WFEIYKED7fK84ivs?=
 =?us-ascii?Q?sRTLTo2QkuYPhWuUE8cFVoF/BjcupDUM/X0f0zmM0aXd8qjP9vOtlwzP/+1a?=
 =?us-ascii?Q?lGojnvJAa1c/PCiT3jKZdZ0mDI7CzmIQroh056zM04GtJIsl0ulpraRcSGJ3?=
 =?us-ascii?Q?kn5MTdTLRUFeYEDn5xacc8FdPKBieZPBykC5QOVJHUvKSdLbPaXifoyZEvad?=
 =?us-ascii?Q?SpzeOipgKzr4Zl9W2qFrpzR/ubzDmWopTJYC97BGdDfVRo2NDsgJXbdO7WIo?=
 =?us-ascii?Q?qS7uPQNWv3eDh6T/gGJFfbhsc56dg6t6TwG99+oGGWI7UpFWycnkFnPE7O3/?=
 =?us-ascii?Q?9L2HJQQC+WUlEN2aaEe+PiMbnkXksY0VKGm5UMBXXhLtCfFYNBTAQ9UdLjAc?=
 =?us-ascii?Q?gmCYl6fTB54lI7YdnKdNQ/uA5tQzcxLwJx7k1kXEveAEz6RzWWWRJUAZwX9X?=
 =?us-ascii?Q?Gv3mW27CRqO5av4rzhN9uB1tB5F4x5nDkv3h/8+t0ZifqlkLPaZZq2bGpvfr?=
 =?us-ascii?Q?bygi+1FuRKgPEKiQPrDxlYBxCy3CBCs2jvBRPgOsXqRRhxiNYrVH7A/kWVnV?=
 =?us-ascii?Q?Ysyzo6/pJXSkBc/isLSP1n5R4ShPwYQMWc/x17kwjT6UzblDGVFvAae/IqlX?=
 =?us-ascii?Q?aFj2dnQ6Ce8eQWY23zZh72ciFk2iAijkJggv1fmNElVqJbCvpS9aJtv9/T/T?=
 =?us-ascii?Q?rnpXXZA9hCvj45DAXZAoHkivZ/3X7UCtAlF4cSE7GpMZNcFEo9JMi75bZqvK?=
 =?us-ascii?Q?3NMxAVLzokapHe/RkEk2q6G3CXd7ToxqZ+bju8dcKt8f5U2BKThzUqcRYSz4?=
 =?us-ascii?Q?iJBW5xoo7cuL3GSVTD8IYk1L4mzvzYgPImayKiw/AokX7TB20gCJBDsiRmsp?=
 =?us-ascii?Q?NjDM+p3iJAOG6Vv6Hy4y6fLatHBQxM6NRV4xs7fAo4arqN1WsSOHAbnaOm13?=
 =?us-ascii?Q?b5Df2ZkTtJaPLF/U/98DQb8xaQ5WvzVDuATfKNbwi1O1Plr4KAdRYoBQDHQH?=
 =?us-ascii?Q?pozPjowMmidhM8a7F949CT4DWDY2pHJyBmJrJ8TGeZ/VZFp5dYU3AlY9iw0M?=
 =?us-ascii?Q?WHKVVwoI6EmHOutn+tyvY9lSTj/i029dc7UR8J/r6jm0cr44CoDEGPsxoBRp?=
 =?us-ascii?Q?kyGu3FGpcug76j+L/q14tLAlPBCIc0dYN4vU+nGb?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f64be3f-9354-4c37-70c0-08dd60d92ca2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:13:23.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vE6jDjDFOKe1Ti3S2CeUXfq6BuEE0Ye0sfLGyVepxk45b2qcNB4Sb2oYMhFlpZcoHxtdpiuNyyjQzv9X1qGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3576

According to GDMA protocol, holes (zeros) are allowed at the beginning
or middle of the gdma_list_devices_resp message. The existing code
cannot properly handle this, and may miss some devices in the list.

To fix, scan the entire list until the num_of_devs are found, or until
the end of the list.

Cc: stable@vger.kernel.org
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@microsoft.com>
---
v2: Fix alignment, extra dmesg.

---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 14 ++++++++++----
 include/net/mana/gdma.h                         | 11 +++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index c15a5ef4674e..af63d844b3bc 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -134,9 +134,10 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 	struct gdma_list_devices_resp resp = {};
 	struct gdma_general_req req = {};
 	struct gdma_dev_id dev;
-	u32 i, max_num_devs;
+	int found_dev = 0;
 	u16 dev_type;
 	int err;
+	u32 i;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_LIST_DEVICES, sizeof(req),
 			     sizeof(resp));
@@ -148,12 +149,17 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 		return err ? err : -EPROTO;
 	}
 
-	max_num_devs = min_t(u32, MAX_NUM_GDMA_DEVICES, resp.num_of_devs);
-
-	for (i = 0; i < max_num_devs; i++) {
+	for (i = 0; i < GDMA_DEV_LIST_SIZE &&
+	     found_dev < resp.num_of_devs; i++) {
 		dev = resp.devs[i];
 		dev_type = dev.type;
 
+		/* Skip empty devices */
+		if (dev.as_uint32 == 0)
+			continue;
+
+		found_dev++;
+
 		/* HWC is already detected in mana_hwc_create_channel(). */
 		if (dev_type == GDMA_DEVICE_HWC)
 			continue;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 90f56656b572..62e9d7673862 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -408,8 +408,6 @@ struct gdma_context {
 	struct gdma_dev		mana_ib;
 };
 
-#define MAX_NUM_GDMA_DEVICES	4
-
 static inline bool mana_gd_is_mana(struct gdma_dev *gd)
 {
 	return gd->dev_id.type == GDMA_DEVICE_MANA;
@@ -556,11 +554,15 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
 
+/* Driver can handle holes (zeros) in the device list */
+#define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
-	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT)
+	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
@@ -621,11 +623,12 @@ struct gdma_query_max_resources_resp {
 }; /* HW DATA */
 
 /* GDMA_LIST_DEVICES */
+#define GDMA_DEV_LIST_SIZE 64
 struct gdma_list_devices_resp {
 	struct gdma_resp_hdr hdr;
 	u32 num_of_devs;
 	u32 reserved;
-	struct gdma_dev_id devs[64];
+	struct gdma_dev_id devs[GDMA_DEV_LIST_SIZE];
 }; /* HW DATA */
 
 /* GDMA_REGISTER_DEVICE */
-- 
2.34.1



Return-Path: <bpf+bounces-32340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5290F90BBF8
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B876D283765
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C9D19B5A2;
	Mon, 17 Jun 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V44x4KTt"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2119.outbound.protection.outlook.com [40.107.212.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4B19AD74;
	Mon, 17 Jun 2024 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655481; cv=fail; b=d/r6OSlBqQoGIL+7iM7gb3r1fmRrkg9hISlGE/1O5AYTB8FUNEsY1yKkW65ZuVYwv2IYRrohZ18V50HgL3wCyoudfwSlu25aj+Vgnoo/U6vAZ76Q7Ugt+fO3/XcpyYYyFFKisWIZOn86UcDnC/Nxvc4yfXQTsVNDMYcc/QjTY2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655481; c=relaxed/simple;
	bh=qiKNJ8UVrJKAn1PBpX6jNP/5ZmROv7iV6C2/wZyK2Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hvm1G7aYUrgSqBS7D9nzgG2MrXxhBCUgSjSCOTe6v3H++IdR3BOxRbJeJFd69NpaWdO9av06q50CoGqyhIZtvcF4t2ZDKd1OJdozCdr4JY8gE77ukLw0LRbSGpj84PinBqXHOb56WiX2xjWlvA1DI8/6ah7s3MhVJBDtkavszM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=V44x4KTt; arc=fail smtp.client-ip=40.107.212.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MixjAlSDqdlVpOnwgVtitkpot1OdY8MYFirHPTFzyty/nzMLB2sbTfGtl0BkSuZHkiV5FJHHBe+EUs2T9tlYT9qzF8Ly8QfWIWTd8R0QpHPAKlqZIbJBoglhM92ovCKqKzorxlM/MkrtlOgAX+Nnn2m8UtRah4gzhUJOq+RIwtXSkE8A7S2SPnxhn174L1Ii9NttNvklMlO69Z8cTrfEIT45+2cfy/qTIU+kCdntEeATnpLvGLehiOYT3BE0o0Kl8enSJPG3LbiiVlYGBx+yayffslTWu6x3wTpBmhTzxscG0wiG50qmAo62cUuAunz58MqXELpxPIWucUk0FCCyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HYUiF36VAQygZk04mouuaiq8J+XwsDnFl/8YNF5QoI=;
 b=bwDLFCam30cPC0PT/yVdAAqYzU8p5ehP2QcAoJcMiuFuE/XHDt2VLZTiEJM5c1IPAqX0riWgfuenTqPWCtbYyuwvmbKLegEuPQzkhaDXRjJEfXGJS0jTflmXSj0PyvFxK7rTq3BKBfLBCj2LMm/GZLcWVsPoSyWTpwhm+gCeAqcc6uDhPLGWegknVqiSOl0TWfP40Z+FMmtKQeaqzva1k3cXHKRg7/nA3yKTBENE9ZG5ZTqd9NFRXWnQjeLYms/WCN4YdbgETjOtVdmd2IsW9tM4t3Dc8tMEARKdr9VEae3N+08rNWRbR/cOn8yq9mYfFFNxcXXb5T51AJilg7Zs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HYUiF36VAQygZk04mouuaiq8J+XwsDnFl/8YNF5QoI=;
 b=V44x4KTt8OAeDdqtbKsK/3NNNKuPTAmQKDacK7LETKPmKBXt0gxfPGYHXOc8pi2jVxS/Sxav5mmj2Miv8BGUOMOy3fb8/lvon6zLCwftF/BFVCSdg13h5bmBNw01grXLTKyV2rzwASelcToLullZo8qValTFBsF6ebbnl/rgTiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DS7PR21MB3551.namprd21.prod.outlook.com (2603:10b6:8:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.7; Mon, 17 Jun
 2024 20:17:50 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%4]) with mapi id 15.20.7698.007; Mon, 17 Jun 2024
 20:17:50 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3,net-next] net: mana: Add support for page sizes other than 4KB on ARM64
Date: Mon, 17 Jun 2024 13:17:26 -0700
Message-Id: <1718655446-6576-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0379.namprd04.prod.outlook.com
 (2603:10b6:303:81::24) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|DS7PR21MB3551:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3d5153-2ee7-4c05-80fe-08dc8f0a8f4c
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|52116011|376011|366013|7416011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?nttNluiRPWdqnv9cVjxEokiYlVpRweRa4VzHh1CDMRZxIef0SUHUMlP6tdXC?=
 =?us-ascii?Q?SN2nYJOpp9gCPUtWCE/iaYK85FR0g7F9ytF9KVKGrAv5w63wI5cXeZzKQFeM?=
 =?us-ascii?Q?tRbqjMdOxKhmZs1n4LHBcEOv4ODb3ql0xKUYZoD49//lmFmkBDkLzKhVi7vV?=
 =?us-ascii?Q?HqMTbiX8aUBfK8ZwCIQQsYYCpc5Vtp8Aq63r2oOqi7FGNUxHccUku2akVGNy?=
 =?us-ascii?Q?s2LAH3/IT0nI49dqGbQrLWrYeMEE26F7T6N2dU+AGMce/TanHsYpZsavUvNP?=
 =?us-ascii?Q?Q3uAX5U1FXuu+3NCHwX0vozH5FU4vC0NqY3iSobWE2wfSexEeUuDhRW2DrpB?=
 =?us-ascii?Q?HHc+jB2rXDenhwDY1pqd7/sO+miF0x1js9DGPGepOjTzJfgLEbgxPJIsqtE/?=
 =?us-ascii?Q?QKHXCGBydfTXHzgkPe7QfGS68zfp3gLX8GoozE5vpGsM/QcLO5aemX8r19hO?=
 =?us-ascii?Q?6p0mlPYT+d28nghMc1afvNRRbNvJZISjhMEilnzo/dLltE7bsXp22aFAc+EW?=
 =?us-ascii?Q?Yi3dFqZ7MBhPXhvr1kfLma/0jdCC59/uehSJ+LhAvOho4AqhM6vgLXABNbDC?=
 =?us-ascii?Q?go6oBtoyunHqLwdD7T9z5r7q+UVAw48G2Y+9rtVaBo3iXWpJllFmlUxw7OUx?=
 =?us-ascii?Q?rwu24aSrQAXxt7iYZ9VhTbS0vTlu8xiaH9nSe0ZMO6I7QP8W6JxfhVk8NEuE?=
 =?us-ascii?Q?l90G0SNdv+DtpMWLmI1upnTPE8iULzOo7KHGyf9taQ/HTrIDXbajAL2iLrh3?=
 =?us-ascii?Q?Zq6k+ffHXpFHN1uDTE5B9EDFIwjh6Nd8CwsWdCoco4AOxTkv2rbz0zkog4nL?=
 =?us-ascii?Q?CgTRL5YFP9qm17987DGgMnsvxuzU8h+xwTWQfP8dyrmNwQuysh0giEaWqzzS?=
 =?us-ascii?Q?KSIAmfec56JwjSNPrDxLMf2uvPH/wVWJtB9VRwAzu2ZpKwujE7cTY1OkwlMH?=
 =?us-ascii?Q?qgIWvLM7EYC4reNtbImwlK1Lguv0DTUrrLXhxv2+5hT6r8lxFxDmvXUXKG1S?=
 =?us-ascii?Q?7mHBek2sWWlaVjAxx3soyILOwiN0f0zUHGmVlNUPy7mof0XMc2fBJHYqs5HJ?=
 =?us-ascii?Q?nvsUUpyEWj5UcNxtQ3GzlwSHpdd/MMPb8Kaume2f8KxHBBDVe+9Ykayj033m?=
 =?us-ascii?Q?E2NnDHisJrWxGPyJ6qIhhgrnnTJ89CvhDumdzJWKDd2DoWlDcvQjIInHbVOf?=
 =?us-ascii?Q?nIfJ1bL+3/OsAsraBp8mhXHWnVU43mstAi8Gl4Oe7h3VtW9uz0g6+0MRH1rE?=
 =?us-ascii?Q?V0oBO16doRqpoGvt7hXnHtuwO6tgCJ1MH0njdl5nHOq1/o8NyjPaKTjKdHDP?=
 =?us-ascii?Q?Lzj6VSbdephU4S5X4pwh0WYxB/kDHJ80eP2fHIZK1BFPV8NeBybANFgqmLSz?=
 =?us-ascii?Q?rg/fn/c=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(366013)(7416011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?MFY8AcW0EzpHW7NZUWwOc0nqteNdWBTVYwEegxrzDRjefNcpgBKDY5jjmBir?=
 =?us-ascii?Q?Vg6w2iEyNMFVjjLWUaCZR8XPIiCttcYyDovUtKvyqp7epvD6FikNubQPNegA?=
 =?us-ascii?Q?b+neu6q3quw3t2+fEg53ioSoUG0fY6OfWMpTfHoNdAL/CmsjSZIjDwn6U+qv?=
 =?us-ascii?Q?hubQF94r8XIu2Uwh5MaHfgORuHZXZFu1rm/wrIQ8P/bgRHKd83nmTqeJcYO7?=
 =?us-ascii?Q?NnECUIpVOH4MiIxwZICZtLis5Se4GjLUEz/O7L/nxU1r8fks1I3hapn61cS1?=
 =?us-ascii?Q?VMHPoYRawmiMFRJ//GIa1avLP+6QRRF2DKRBeP5aqwKCkdAfJ3G/8xJj1p8X?=
 =?us-ascii?Q?r9o92SHpdvnB+wXheBVHmip2/FvxWSnKj01EeSei7/eJhCQHagCcUbbzgHzL?=
 =?us-ascii?Q?QUsSTVNlm39hSOIf+AgWgo4HAzeaL9kYzmsOKHdYOAttOnYJgVOWTEMnx37W?=
 =?us-ascii?Q?8Cz5509awp9RJ5eXM3xAGwqIEIk1zntmjt+HMKTcwKOgXYkRcHOJomQnfeOK?=
 =?us-ascii?Q?uwUO4iRvDVSqFp/jCG/SZkODVc2WlT6gKCfbfw2O8BJSMhd3PSYGr/TsJIT/?=
 =?us-ascii?Q?60b7h8Qfe36yKGjEAxP6GLMzGaW6SPFWJBTG0sLMyQRwWeSZrLjXhzsjZXQE?=
 =?us-ascii?Q?MtDfW/4xAdLw/SwiiTyFdMfheVr9kb+9te60aXuLPay26Y/UZgsy9VNIFR0z?=
 =?us-ascii?Q?D3bC6qafEHskOqyjypSsTzQEv2tofTZ0Lzh4EQFrhY7qUK2pcGwFLQr1ZL9V?=
 =?us-ascii?Q?eok5TbhruDJHq/a3ihLydQfbHlLJEkmBBY8+Ix5dweWvrC25ke+AamGLMLMZ?=
 =?us-ascii?Q?9G2If+EAE9DISiHdMnLgAlCGWFPQiCsShbQJd/GygYzrPnK7aMBZTMiFWXe1?=
 =?us-ascii?Q?ZASvdN8ZF9M6hT11UIuAvSCO3WILpQ9sSWo8IR8AhtCYmzxEQZC1tX3gm0ca?=
 =?us-ascii?Q?MfoiDNKsMD8e2LB8UsMt2V1bXvYkoZ+jzWXz516ZBtjALsRCDHBhXYJUvqXH?=
 =?us-ascii?Q?ULlTXw/0NNNlOoKseJyVorjHP3JyhWTNMMwooJRZQAj66FBqYZzrZpXCuGHM?=
 =?us-ascii?Q?DEYzAUq7YFd3XS0DqeBQ494YAJR+CzfjQlhg+uUU7MYmGvA59x6gnBEDca01?=
 =?us-ascii?Q?Wi37Uy4bKkShMC4t7+cRiNy/fjZrHJpJCMBa1SxlVkpVWNZFFnXjcVf1vFHH?=
 =?us-ascii?Q?bT4U8QTSZxTmTW8hj/tVuvdWZteZu5A92/2eTqrbqtspSImJih2HxYMSIilg?=
 =?us-ascii?Q?bE9Pj89dD99+1S/PYACA/O7gxVTVj2ehnEWAN2Jpj2+xehQE/2GOM7AKf/9S?=
 =?us-ascii?Q?WoIz9Nheo44PZZqjyraD/kbGEby+R5IFhyqc6ziYM8GZuESpq5H3d956iINH?=
 =?us-ascii?Q?uo4hCi1/tSO4w2M8DsUQLrS3zvE2IZ7NU+2Uxbgna/SULtaDgryjtV5L356K?=
 =?us-ascii?Q?SKo8uNIISB2PVI3+SR97uqlt3OJHJUAHyiUcyw42js6/6cTe9vNJAe21MIbu?=
 =?us-ascii?Q?+Avi9cZV5VqyHQrGDHe0aMUIDK9zacOZnk/P3pI4iHhd+iy3Lzfc2+jvcNn8?=
 =?us-ascii?Q?kxugjVaaQqTHYD0Mu43NCJbAT7VDdXC2ZcbVsNMI?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3d5153-2ee7-4c05-80fe-08dc8f0a8f4c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:17:50.0928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uf9ymco/IjJYqixVQwk7hGJo2s8ApFJnn6zzcmI5XXLKdpyBi1R++G8vwC9+/dM6XiNpDqFWSOewF/frWaW9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3551

As defined by the MANA Hardware spec, the queue size for DMA is 4KB
minimal, and power of 2. And, the HWC queue size has to be exactly
4KB.

To support page sizes other than 4KB on ARM64, define the minimal
queue size as a macro separately from the PAGE_SIZE, which we always
assumed it to be 4KB before supporting ARM64.

Also, add MANA specific macros and update code related to size
alignment, DMA region calculations, etc.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

---
v3: Updated two lenth checks as suggested by Michael.

v2: Updated alignments, naming as suggested by Michael and Paul.

---
 drivers/net/ethernet/microsoft/Kconfig            |  2 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c   | 10 +++++-----
 drivers/net/ethernet/microsoft/mana/hw_channel.c  | 14 +++++++-------
 drivers/net/ethernet/microsoft/mana/mana_en.c     |  8 ++++----
 drivers/net/ethernet/microsoft/mana/shm_channel.c | 13 +++++++------
 include/net/mana/gdma.h                           | 10 +++++++++-
 include/net/mana/mana.h                           |  3 ++-
 7 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 286f0d5697a1..901fbffbf718 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -18,7 +18,7 @@ if NET_VENDOR_MICROSOFT
 config MICROSOFT_MANA
 	tristate "Microsoft Azure Network Adapter (MANA) support"
 	depends on PCI_MSI
-	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
+	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
 	select PAGE_POOL
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 1332db9a08eb..e1d70d21e207 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc, unsigned int length,
 	dma_addr_t dma_handle;
 	void *buf;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_PAGE_SIZE || !is_power_of_2(length))
 		return -EINVAL;
 
 	gmi->dev = gc->dev;
@@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region, NET_MANA);
 static int mana_gd_create_dma_region(struct gdma_dev *gd,
 				     struct gdma_mem_info *gmi)
 {
-	unsigned int num_page = gmi->length / PAGE_SIZE;
+	unsigned int num_page = gmi->length / MANA_PAGE_SIZE;
 	struct gdma_create_dma_region_req *req = NULL;
 	struct gdma_create_dma_region_resp resp = {};
 	struct gdma_context *gc = gd->gdma_context;
@@ -727,10 +727,10 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	int err;
 	int i;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_PAGE_SIZE || !is_power_of_2(length))
 		return -EINVAL;
 
-	if (offset_in_page(gmi->virt_addr) != 0)
+	if (!MANA_PAGE_ALIGNED(gmi->virt_addr))
 		return -EINVAL;
 
 	hwc = gc->hwc.driver_data;
@@ -751,7 +751,7 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	req->page_addr_list_len = num_page;
 
 	for (i = 0; i < num_page; i++)
-		req->page_addr_list[i] = gmi->dma_handle +  i * PAGE_SIZE;
+		req->page_addr_list[i] = gmi->dma_handle +  i * MANA_PAGE_SIZE;
 
 	err = mana_gd_send_request(gc, req_msg_size, req, sizeof(resp), &resp);
 	if (err)
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index bbc4f9e16c98..cafded2f9382 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -362,12 +362,12 @@ static int mana_hwc_create_cq(struct hw_channel_context *hwc, u16 q_depth,
 	int err;
 
 	eq_size = roundup_pow_of_two(GDMA_EQE_SIZE * q_depth);
-	if (eq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		eq_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (eq_size < MANA_MIN_QSIZE)
+		eq_size = MANA_MIN_QSIZE;
 
 	cq_size = roundup_pow_of_two(GDMA_CQE_SIZE * q_depth);
-	if (cq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		cq_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (cq_size < MANA_MIN_QSIZE)
+		cq_size = MANA_MIN_QSIZE;
 
 	hwc_cq = kzalloc(sizeof(*hwc_cq), GFP_KERNEL);
 	if (!hwc_cq)
@@ -429,7 +429,7 @@ static int mana_hwc_alloc_dma_buf(struct hw_channel_context *hwc, u16 q_depth,
 
 	dma_buf->num_reqs = q_depth;
 
-	buf_size = PAGE_ALIGN(q_depth * max_msg_size);
+	buf_size = MANA_PAGE_ALIGN(q_depth * max_msg_size);
 
 	gmi = &dma_buf->mem_info;
 	err = mana_gd_alloc_memory(gc, buf_size, gmi);
@@ -497,8 +497,8 @@ static int mana_hwc_create_wq(struct hw_channel_context *hwc,
 	else
 		queue_size = roundup_pow_of_two(GDMA_MAX_SQE_SIZE * q_depth);
 
-	if (queue_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		queue_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (queue_size < MANA_MIN_QSIZE)
+		queue_size = MANA_MIN_QSIZE;
 
 	hwc_wq = kzalloc(sizeof(*hwc_wq), GFP_KERNEL);
 	if (!hwc_wq)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b89ad4afd66e..1381de866b2e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1904,10 +1904,10 @@ static int mana_create_txq(struct mana_port_context *apc,
 	 *  to prevent overflow.
 	 */
 	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
-	BUILD_BUG_ON(!PAGE_ALIGNED(txq_size));
+	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
 
 	cq_size = MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
-	cq_size = PAGE_ALIGN(cq_size);
+	cq_size = MANA_PAGE_ALIGN(cq_size);
 
 	gc = gd->gdma_context;
 
@@ -2204,8 +2204,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	if (err)
 		goto out;
 
-	rq_size = PAGE_ALIGN(rq_size);
-	cq_size = PAGE_ALIGN(cq_size);
+	rq_size = MANA_PAGE_ALIGN(rq_size);
+	cq_size = MANA_PAGE_ALIGN(cq_size);
 
 	/* Create RQ */
 	memset(&spec, 0, sizeof(spec));
diff --git a/drivers/net/ethernet/microsoft/mana/shm_channel.c b/drivers/net/ethernet/microsoft/mana/shm_channel.c
index 5553af9c8085..0f1679ebad96 100644
--- a/drivers/net/ethernet/microsoft/mana/shm_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/shm_channel.c
@@ -6,6 +6,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 
+#include <net/mana/gdma.h>
 #include <net/mana/shm_channel.h>
 
 #define PAGE_FRAME_L48_WIDTH_BYTES 6
@@ -155,8 +156,8 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 		return err;
 	}
 
-	if (!PAGE_ALIGNED(eq_addr) || !PAGE_ALIGNED(cq_addr) ||
-	    !PAGE_ALIGNED(rq_addr) || !PAGE_ALIGNED(sq_addr))
+	if (!MANA_PAGE_ALIGNED(eq_addr) || !MANA_PAGE_ALIGNED(cq_addr) ||
+	    !MANA_PAGE_ALIGNED(rq_addr) || !MANA_PAGE_ALIGNED(sq_addr))
 		return -EINVAL;
 
 	if ((eq_msix_index & VECTOR_MASK) != eq_msix_index)
@@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* EQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(eq_addr);
+	frame_addr = MANA_PFN(eq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -191,7 +192,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* CQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(cq_addr);
+	frame_addr = MANA_PFN(cq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -199,7 +200,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* RQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(rq_addr);
+	frame_addr = MANA_PFN(rq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -207,7 +208,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* SQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(sq_addr);
+	frame_addr = MANA_PFN(sq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index c547756c4284..83963d9e804d 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -224,7 +224,15 @@ struct gdma_dev {
 	struct auxiliary_device *adev;
 };
 
-#define MINIMUM_SUPPORTED_PAGE_SIZE PAGE_SIZE
+/* MANA_PAGE_SIZE is the DMA unit */
+#define MANA_PAGE_SHIFT 12
+#define MANA_PAGE_SIZE BIT(MANA_PAGE_SHIFT)
+#define MANA_PAGE_ALIGN(x) ALIGN((x), MANA_PAGE_SIZE)
+#define MANA_PAGE_ALIGNED(addr) IS_ALIGNED((unsigned long)(addr), MANA_PAGE_SIZE)
+#define MANA_PFN(a) ((a) >> MANA_PAGE_SHIFT)
+
+/* Required by HW */
+#define MANA_MIN_QSIZE MANA_PAGE_SIZE
 
 #define GDMA_CQE_SIZE 64
 #define GDMA_EQE_SIZE 16
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 59823901b74f..e39b8676fe54 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -42,7 +42,8 @@ enum TRI_STATE {
 
 #define MAX_SEND_BUFFERS_PER_QUEUE 256
 
-#define EQ_SIZE (8 * PAGE_SIZE)
+#define EQ_SIZE (8 * MANA_PAGE_SIZE)
+
 #define LOG2_EQ_THROTTLE 3
 
 #define MAX_PORTS_IN_MANA_DEV 256
-- 
2.34.1



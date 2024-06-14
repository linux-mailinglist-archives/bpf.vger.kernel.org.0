Return-Path: <bpf+bounces-32197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE316909260
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 20:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C8D289447
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4E19EEBF;
	Fri, 14 Jun 2024 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WGd8URWl"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2119.outbound.protection.outlook.com [40.107.94.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB141474C5;
	Fri, 14 Jun 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390207; cv=fail; b=bNz2XyJ/a+TpdoJ6C/Gmt0Vs/RQB6r+MTi0ScJgal6Htug5T00s1ntBkeIE35Bh9l6SHvMzsOO+vBG/RnyoOCdZFg7SRMUTnNs/kygO3eN5A7q0j+yB73l3pfIYC57G05dWEZUplQOjqdkcS3Wed8vY26V0SJtOhtMpN89RX6GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390207; c=relaxed/simple;
	bh=stgAqYfRmkZX3fg6RtC3wXGoPjoI+GafLwCR/fJ/+iY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YLLqBZzpa9JAkhXcZWAPloBGfg6vxCHtMTbS6LEH/H9635BtDnSJ860h4jV+Xd4SLHGOlOLTIDZNvk0X6O/Qw98AywZmvYXZ5fsYJGKU/DehEivcGgXXqBqkyNCVjU7j65X2aLYM5J1qK173WUasTrozdJV1n4iV7cGVrwgzHSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WGd8URWl; arc=fail smtp.client-ip=40.107.94.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZT85L0ZZU+oY1KNJ4rpeEub1UfLeMvrow+trkmwrawLmB1BBf/lxTq6jItqJQNfvXg295fBd7/IQy/d4Kb5iekdtcvgQqYObC8FCoLO5PauY6BYv/tzsyrub+LP9TUU4AoRpzE0ncJBxo+pAnBVGCYOD3hSwixRok/zTqZ5ClBW99BsVMhxwdyxw2Be3Ht2+Gxm227mLD90wHFGwDxNqHkM2BlbtQOsOXREp74yx8J8mJSHCDTuAL4G/DFOcIqqGKPUWDjCXW2sgSxLLs6UX3fYq3CcvasfpDM/IERgFpt9ms/N3pw/8oaZcE+lPgs8nUSS/Ou3imOvjVLWcFFQowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO2nARQBI58QVt4K6CP0sMfcKVezqzCrGwCMDcNk9jY=;
 b=P0IWgsWW4JcJYG8nN/pdJI/3Hzsdnue3ihSoFbAiY7nu7H6M6Zmm3I5K2eGfpaEZKhlXmmFk6Sn3qZlsKgRqWJ9lIRvdtirSThnH8J8+OP+OSopPe6eZKRNH83WmMVaDIn1geQWK6p3+ncW8HXb5wme1+nuRa/0k5TIHcam84AYo9mkqIktIPqzY8J7s+MMrzYgP6FC3TObyoJj73yD1d8Ou2778ZjjBpJn3i/kj8Nm//Y6jydEqXRPFBlmQhe19Al/Ku7Fh3t7LKf1nFT4UFrJ1atGyvL/kwJSPBB49/H1BEjvIQj2kdt+PMFjt3yr306lLsMMcQT15r2bC6hC0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO2nARQBI58QVt4K6CP0sMfcKVezqzCrGwCMDcNk9jY=;
 b=WGd8URWlmXHCp9YOyot6f3aNt9pP/EEHiGtaU8L6Ki9ydHgS6kunyxqJfA8p/2fWSEnLVdheL13m3F2i8D0vF9B2oKMJQ3cjpJ87ShEqKuYl9YJd5BWj4eWyCCvbycyRwb/YsHePU4oZUsvG6hF53/TYS0yKzlW3kJap1aIeNwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ0PR21MB2056.namprd21.prod.outlook.com (2603:10b6:a03:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Fri, 14 Jun
 2024 18:36:37 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%4]) with mapi id 15.20.7698.007; Fri, 14 Jun 2024
 18:36:37 +0000
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
Subject: [PATCH v2, net-next] net: mana: Add support for page sizes other than 4KB on ARM64
Date: Fri, 14 Jun 2024 11:35:36 -0700
Message-Id: <1718390136-25954-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:907:1::29) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ0PR21MB2056:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b76bcb-0961-475b-c437-08dc8ca0eb9f
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|366013|7416011|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Do1BwiiZTgHKO9J4thuBDouWJyFr9VOpex15m9BkWSzZvC2V/lfEfvck8yMv?=
 =?us-ascii?Q?B5KVxwFlaqPLaUb/iYAN4TtpgUFcMvYxopxnImgN/CsKf/PfjLgGKRSvCFCR?=
 =?us-ascii?Q?86rHusGiNt9GUgju1NkYILd6Xm5iBsqyn6RiAfiJ8ChjUt3bMXvQBEBrW848?=
 =?us-ascii?Q?l+aHpG4OkVuZfpeu0r1DSP/0O/+gCpXrBVQezmd6dWUFMPAvwVxLtbYhwkSZ?=
 =?us-ascii?Q?9QBqEaYTbylblMGDwoNI6LPuMKZWhLGVBGA6iEcJeUiIe/oW+dSl0+tAIktr?=
 =?us-ascii?Q?tsBY8ZNniLbJ/7QJDoUdMC86VJGoI+kOyhholmE9U3n6RILw4pLBOt2C32Ax?=
 =?us-ascii?Q?zX97V4mBWtVHCTch8xZYvwxfvRscHFLY5nXlI2qCQvOeEfkmnG5dlGUpV9S9?=
 =?us-ascii?Q?wMRMeQt8l1U1X3mM9i5LrII2vqsapqCIMR8mMO3eaKsy4LN7t9sRTZg9Pe2p?=
 =?us-ascii?Q?aaghtuTcv5ljLIl1JSBU4DYjDbp0W4KD02oilpV/hfObUTvaEGoHQYhGJAxY?=
 =?us-ascii?Q?LqRWU7fqyxAqPYUqrNCWim0DEfv6KD0oDvgj9dQ+N2Jl6O9ipAWRxAhGoOc1?=
 =?us-ascii?Q?Oc473FIJ4EfTW6aBI6G3ILhbQmhuIWPMrl3wR+jo7F1kwF53j/kAms6Ttt3z?=
 =?us-ascii?Q?hVxDhd3FzAEsNR6CJ97gNxm4NkbxQNRIkWHylajzrXiX1oB+wBRe8KzzwHuV?=
 =?us-ascii?Q?itgzXLEuqwUVoImt5jwSYRDmZ5q8olW/nYFvyakxeSib2ECLSgdJrhGb8QI/?=
 =?us-ascii?Q?jZu45ZP5KtXERAynXHVXNToQwgT8sBTsRrgUBdzB5FY9PO1112+aq/Gb49Xn?=
 =?us-ascii?Q?CLDoFC0RPJPIMyZTqfJTSoRfQPTztRf1Jui+81+IxzAPHbz2dQO9wyDA7E+Y?=
 =?us-ascii?Q?aidZrjOIhSFAR8nXhOK93krJ+g+G+UJHosGW71MhWkD3kh/Pd0/3SsBm6buQ?=
 =?us-ascii?Q?qmunrPJA1Y+vElShUgw3N2zh/XZmXevu/y30yJX0T9m212QiwRrPj2mVWF1u?=
 =?us-ascii?Q?Q2mpEz5EAwRpuNfOqAYU9pl/jfStcrS2WJEtmNzsLmQBq2x6dmhaYiy98So1?=
 =?us-ascii?Q?dHh3Toq5yuvnjhyKqbN/1sMMW0mheoXiDBQ9gsCPDFlVyXddwk0YdX5v+KdO?=
 =?us-ascii?Q?S63w1Zqq/gin+1wFT6EAjaaPqeaRFWoQS0dPhaQWnUh7VzVQZzU2vRARZVHa?=
 =?us-ascii?Q?OWO9AJtScWoR3H1h89L9Ms5nmQV3iYIT60wS84AKTWOZ4rBohtOpxRr3/41q?=
 =?us-ascii?Q?4DoDGbRXAuThHIHzi7he9IS3L/Q0oTvlqCagm49fos+AiBIcAyayGMA39KbN?=
 =?us-ascii?Q?uT0JLIDppJekfQMNOthDI/TjL0SYaj9pggSqvOe3VKdPHIiPOeWcBBoBidjn?=
 =?us-ascii?Q?j2ohwNM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?6xFMZQzR8ksbHSmxsiCC7i7TwfGBpUjMMskd+JVwUlpkDbFy+0bFqUGoJAQL?=
 =?us-ascii?Q?MvrnH8MxEWdQ+UujMd/ngGU8/W7Mrz9BYq1OWEptg4YbWFjitLvxs+g2pTdu?=
 =?us-ascii?Q?2n3OrZ1OuFj9vKbRVfPJ3tKx/tlVk6DAeIRBYPqDzJdqcJAa5JGkvOb+JKjo?=
 =?us-ascii?Q?P4UhmyJ0DvRJCMG3COP9T302jnKYVuYnSf3mqjgI7mEAxuegx0WVf6hGoM6f?=
 =?us-ascii?Q?tGhcuUJXptmCggPZ2FC65GwP9tN6I8PE+i8YGVlsw/rSSkWPUfOpgzRwHfxa?=
 =?us-ascii?Q?8EVITTW9I893YM/cy/MsP4qfJJ7d3GHaBcOJn9vS+tnOlNASxhFDzrAtVgbe?=
 =?us-ascii?Q?5bAFu/QeLVcYpKBtKEJuquMC8e8fLcXaSEr2WsPqSXPqQheoMNrK94JFyqN5?=
 =?us-ascii?Q?tdz92VfinuS9dMmzbJHcp9XLtT/hLKOsZJ0PNqdBrZqugGnQGxNKyYUexCU+?=
 =?us-ascii?Q?BL0fvIAWtL/yNBRZTBmmljhK879nhB7c6130QIKulD+tV6/kFGefjkMTX4LZ?=
 =?us-ascii?Q?L5dC5i9QvwHN/kPKsATK6t9lU1/xrjtVZF6LWLfywb666ywdA/fHsFbP/aYh?=
 =?us-ascii?Q?O+wAC6TLwLFuKKH9Qy5yY9np/x9dGP+XeVcbQ5lJt8ckoZlURSQNPAGNngEh?=
 =?us-ascii?Q?CsjKgpTCKYsAhHYUpTzJA/a9bJsgTZwNsLh2PrL/a9qa+DA/DSjfNwVg1d/s?=
 =?us-ascii?Q?5wwwtRqoe1KlR3ZEQR/EGDGVca9rQuw8164qg/nxWI2bciSYxJ+mM9YHm+k5?=
 =?us-ascii?Q?1LYgg8Ov5p1RPzrfdKa8VpNIjMiMruhB3fL5gUJwH8/WmfR8fG/2uwbQbEPX?=
 =?us-ascii?Q?PrAcrQZIHVEvm3DNyrhtf9i8jRuX71sDdiKR+imfAGq7p7wWMz3ThpIV4XVM?=
 =?us-ascii?Q?huKlkz4EejKiU5QrYav/ZOVhk4yxWXocAgwK9HLa9gruQDwBZXfIe1QHWQTg?=
 =?us-ascii?Q?52N7jRfxfJqtvK4bdRaSpgF8iDVXn9TEcnQgSH7q5/wDOqoaf9uexFDw0Fdi?=
 =?us-ascii?Q?w3GAl0ipEfmx8/x/ts6AlM/EdaoXnaJABfSchc88BEAqBuxAWlrGWoEbvQOB?=
 =?us-ascii?Q?aQs2VnnMEeaWkWS6eIrcEUjwehJnd653UBltZQIxh2lBbsDYuTBl6a+XVNQ/?=
 =?us-ascii?Q?lT2uHY2RBLnwQtpFNJhBk1u8PyZRJXa4grE5t652Qgi3fNhh++DOuoRI4gCr?=
 =?us-ascii?Q?H8CbpD6nF/Hr7NKC0nn6E7k6q1v88U8A6UPfk1cXSwo38Nv2eYjQp1DiZVOb?=
 =?us-ascii?Q?zTDbva4hIj0vqZMXuCnUOnbB5CbBNeLLOpSQifjM+jo8i5XPZ68VFPKVoPxu?=
 =?us-ascii?Q?3CFfrL8E6Bhz5Ik3T+HO2IOfg5DNG9pX+ebsW1Zx+phHf57bPY2Y+a/+0uB1?=
 =?us-ascii?Q?AupE2BFK0TdCzJ7y24qWWfGPdtsoVrQy2EgtAiHVNpQMaNNP0LUXshX76Bo9?=
 =?us-ascii?Q?2cqmjG7ebafuaEvk6+DL3ryfyeWaGrAuoBDo89h6X9g88lx1GWOGD4JnSTvS?=
 =?us-ascii?Q?W5kn0GJDeZ9B0oDfNm06z5dVqgjKIQN8gwob8tRaLZUybw6ePFIfQsVuPoHV?=
 =?us-ascii?Q?1vhkPyI3LKV9XtEf9MC8I9p4Xeo4cPBEuLbSkZzI?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b76bcb-0961-475b-c437-08dc8ca0eb9f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:36:37.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LGp+dS1aoiU8LlR7robLnFUmAt2PgGwmPEeRsum5O0QO4pUfgL9S6VKxYBQj8bNKgQda80VpXh5HhMpW05CrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2056

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
index 1332db9a08eb..aa215e2e9606 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc, unsigned int length,
 	dma_addr_t dma_handle;
 	void *buf;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
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
+	if (length < MANA_MIN_QSIZE || !is_power_of_2(length))
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



Return-Path: <bpf+bounces-36799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF994D84C
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 23:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A331C21710
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FEF16A36E;
	Fri,  9 Aug 2024 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fItNfY0S"
X-Original-To: bpf@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020139.outbound.protection.outlook.com [52.101.193.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE9347B4;
	Fri,  9 Aug 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723237357; cv=fail; b=QVNL8AXHQ+BsLodszBm8/LEkiuVGWlszEZJBb0I639zJGAN8V9k6cTMZozVX92jP1GLvaR70f1zyhGs+hzsmky/F1S+n6CPH6v5BxAfy9YyRXtiTg6dVM0diyCfJ0/QorRTmcL1jTgGD0wceoJ3g0vMABEfQvqea+a/vBitRPWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723237357; c=relaxed/simple;
	bh=OhYa2EMV2Sk+J4U+DEBiARgdxkuHtXje8OzlTB7JtDg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uNGceIVVe4Wk0vZemCevtvKK3QTHdNpp25/YNghj1RPzHBq3lvECXcBinFlLU8O0JMLBlSjqaPvFKHG9XdMOZ5fwdX3R5n2Ct951wFIHkTWNw8mlHlcpd4VLo6+Os8xZndRMQ38Sjx6q649D6Aechtz3KyNZuv400+2Sim/290I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fItNfY0S; arc=fail smtp.client-ip=52.101.193.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibatZ5dFSqMWwVvnhBsdY0aE6ia/xFFaw6ABWFni7vDTVj+nUzOh5y5LJ/13iGKjrLsNtfNJbsPb9EU6KyRWALNaVsetNZuGsnnjTvo64RuO0BYpselqh8B+A99gnaeyB8gikKOc71+ggLRkvdSuxn3DVN4lEKQNEpcZm+KoA1wLny4yFUZ2BV6up0G7LYOuo7s+g2bd0Pw0YY+vPMjccIAj9PXLHGqK5E7x3nuyI5KGZc5Xkz+OZTdZp/lE+OIzAtNSGiI60qcFMgGUFaSUcCrT+scojnqRC3fZWeIadSjBwS4Qbcec57sUgLRV5eLRaH354iarfw2d6cfSoKnUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKAGq2vUwbf8XSdZtj0VjqLutUZ+SvrOSbmJPk7sRKA=;
 b=P55h69Ixx7cVMSPNe+sKTPG/3EQ1KRibA41261PL1qs41Rdht08GxGT27oV/haq0UdNTFwOWhW5V3EBjrIyQ4dBWRe6UXoiE4/DhdOXDWVpO3o8X7NEL6LQwmOG22RCmWQv05/m6lv9FBPnGEqNtMHZ/SMheYUBrSC9Uy50xT/1Ym78fkpkN12LEp1D1zu99TZIIN6XCTPpfpRbR8uG9iCLnfIhZbxa8TGnk7SjMfHwqmFMbmBh6c0aj1fz2f4MKtyOEM1FvOETSnGSE3hCA4vjvW+tnB24ufvgbdOmxGtDzxooyQasfVk3U4GbpX+jImS06IHYVlLPdnXV/ZOiPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKAGq2vUwbf8XSdZtj0VjqLutUZ+SvrOSbmJPk7sRKA=;
 b=fItNfY0SxSJt5v5vQpeuBgALmBG+aUosUnEezeLntqv8CokbeL4o958kQttQchxTjOJIq+PsLEhOJrBhJG93BDlcHbnOw2PxhPWDU+KnZg9MC5BeRFpJZuhcz5mjg22yYy9gK/yV35qurcLcDehVbCvOENm+9dA7ugtqeSiKrEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by DM6PR21MB1402.namprd21.prod.outlook.com (2603:10b6:5:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.10; Fri, 9 Aug
 2024 21:02:32 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%5]) with mapi id 15.20.7875.009; Fri, 9 Aug 2024
 21:02:32 +0000
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
Subject: [PATCH net] net: mana: Fix RX buf alloc_size alignment and atomic op panic
Date: Fri,  9 Aug 2024 14:01:24 -0700
Message-Id: <1723237284-7262-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:303:b9::11) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|DM6PR21MB1402:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c29816-963b-4226-87f3-08dcb8b69605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PhwtuAJgCbHBf/z8uU5KU8sXMwAGurTYfzDsnnGOy3oo5cEFgFoDzoFYFbR6?=
 =?us-ascii?Q?nAJymfo38CPqVPOg5vhA04IV5MpFM62he3izZTwUoY4TOziQJIvJfxp6Fwfb?=
 =?us-ascii?Q?H6AfEgsOxC+IzJWv366vIW0dhYZjrTnFmfqY78sH9XuUoeIacuO48ivVA1TA?=
 =?us-ascii?Q?GAblmGD7PCDOIh9AIqdbwg01Fp+sFdeb5DvWgglNR8Ej58xY/EEjvbvOkd7q?=
 =?us-ascii?Q?LC9aWd4pEwkgsuJE0Z2cgAZjdEVRwVLjtZbCKrT16VmD+nIarpTUI97uL7EL?=
 =?us-ascii?Q?wQPsxo7V1zLj12VW/gPwIBc1qCujGsREzfXW7ticWhbNrWwf1w82H2WjsN5G?=
 =?us-ascii?Q?DEQLlan8zJpbqB4Em1VkaiVXjdS8CobVnRmINc++IWwbUMgfDWkyz48oq4wF?=
 =?us-ascii?Q?ue8++FWKjXjcc5tBGJqOD8c56XDny6omG813SM4X8b6jG8Gkfk22BYIpHZGb?=
 =?us-ascii?Q?6YQTQmAUJRADNvbCmgi1ehe+WWXvFw2KtjQWKqRH/Gm1x5nnc+yjMOGi37E5?=
 =?us-ascii?Q?LG5lFbTyh3O4UEOLEYtfFcRCJZXZ3VyJuDfnoIChv2uV7ZUy1AI0Rv80CShO?=
 =?us-ascii?Q?5QoCpXwwTdcxKp79rzy7pgDkxwTFyWQpI03k2qkUmUY8omdyNqGCQKzi6BUB?=
 =?us-ascii?Q?44j1WtSozun/yxAJXcf9J45yRk0AXqb/n9IdUBUjIDgKcy7rblh8noiDWvhd?=
 =?us-ascii?Q?ZanG/MvMBGJaWne///UYtuxPmMc+NGImeGDuUiruvV0kTztdKdx8JirDSSzn?=
 =?us-ascii?Q?ysNzIjTQP/tEklpqG5rpt8pmnzQqBFGg1PRcCHLaNXdcLknFA8tF0E+R9vdj?=
 =?us-ascii?Q?TovXy+K3M5T+4rg+UDgU4rg0muWZwmul+QHV6/UBY6W9HxbkX449mOATaHrj?=
 =?us-ascii?Q?ZwpxMKlKsPCiglLn1tbK0mlHOhct7LCp/BoWN2WW0hJMdAXXYbfSCm0ZblF2?=
 =?us-ascii?Q?pMy7E4qdRUacJKcVMr3Wkk5bCvOb4HY0wK6jeW76U6o9ogXl2Eg5tFwv2z+v?=
 =?us-ascii?Q?GW2sAqVtOwPGjq2NqiIc9TboOCDcF6I/IATC+czgJiF6fOsZxjoOmj+rOQIq?=
 =?us-ascii?Q?GWaUEaaEhVkhd58XOTbnZY/CGhf/fq7cVJSqGUGaqvJeQnrCyHv3N5PudJ9b?=
 =?us-ascii?Q?lZGdRGy6c+ox+D75R4gm/2qTdos1q1q4I2TlHh8c+sDogMKBeFBR+a3gVUdT?=
 =?us-ascii?Q?8402MO7kaOc4lj/labx1Ab1PoJc7Ahmb+knUf0vNANbjQMuUH146jx2nSXhJ?=
 =?us-ascii?Q?LoCdbBMrl0gMS/g36nDUsGFXYVDPvVl2Rgc502nElO4JpsXMu7VVuzz789vZ?=
 =?us-ascii?Q?nYVJHS8yJtGVcOlk719e75y0e+bERiJhjSEIhwcGYi8g7LukbyzaFJGNGGn3?=
 =?us-ascii?Q?z8/qy1zQqXQlfIA72IrNmLOfkk60dCwG/QAj9NaTAXEMVMfu3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PjuZbfbkL/CLBv4Ps4uRnaxJBU0jByyf05lOI+p0lmKJXw06A7BTPhS0v5zy?=
 =?us-ascii?Q?78z9rbnlN8mMpZ07OpoOkmibA4KUe+ZN3qODRkfmb79LfE/AQB2bhx9JknbQ?=
 =?us-ascii?Q?X1YISCl8OMhBnGvDLUSX9vUKun+YyYZdr5rRpgMH42qWsvSKIR/J1ktRuYuj?=
 =?us-ascii?Q?tETrVvGXwb2LZC2MhPAYjG0ZleqdhpNaEZQ6a2fj8ukKZQBDlUxMOE/hcjDu?=
 =?us-ascii?Q?mnUn5C4NbtAG5ktLwNS4xYsOWb5mjYzpRIMNHN5m9MLg17bEUwDX8J09jSaZ?=
 =?us-ascii?Q?aJWeLdySul6zmD5kiOwjp/SdeWt55xitvIuLTMU3FAex0rtkthYbyqQC7d5j?=
 =?us-ascii?Q?k7geqvbSxqabtnWDwrTgARvJKz0SUX7HxX9TsmzPVP+I5UdXyX9Ei7jHWb0N?=
 =?us-ascii?Q?hCyUiQoLtST7LoIzXrXyUH4PxlRpcyDEh6iL9r/T+9Hjq+5rmGvsT+S1JhxS?=
 =?us-ascii?Q?pOD1Nh4Q2mARumMaGCIMMDUcaImtfE3Y+et8kUi90zYyNv4YWy+K+7bVO7jB?=
 =?us-ascii?Q?WSKNyc/fXtiNxeyXIpkLgQ3gzDc5fOXlOaIlPGy3Rv1IuVeAE2rKl1wbwV5O?=
 =?us-ascii?Q?3ckndnzjypeUymOaQ9N2BRmTmjG8mGMmbLnbKaRpv886EOGUkWxd2ieqAlRg?=
 =?us-ascii?Q?rsQeMP8ktH9Ti0d6ueHahTAf1hY/+/f5iXeaOv1CNu5N+TKJaT7Q/3vZjuFU?=
 =?us-ascii?Q?DStJbCgO/C1VEzDgtrMdmMgbam6osdDBNHuh9mWlxF10s9W6dZjk+LF0Z1dw?=
 =?us-ascii?Q?sVIzGXT0Xh8Vwel+Ge+Nj4RE156k0Quoc4nSE95AFvmnWCbqhimjq+HQB+bA?=
 =?us-ascii?Q?JmTL3czM9iBNN8PqHdlDnuivCWyuaZk+FRBZ3uia/chH3BEYtjYdaRfY34V0?=
 =?us-ascii?Q?BRFppKYeZVrudZk3/GqHGGzPuAZJBoS0zgFJnXBErjH/pu+CPfZI2TQL+3Uj?=
 =?us-ascii?Q?DEyDxjIY1k5LALQRBh1lu9DCdQO5GwNR66kyHo0CGPfhTS2hfq5SpWODj4tM?=
 =?us-ascii?Q?oK9MNZcAtUE4rYoGvFlIXZsO739mvZB0LGRRGM+b4cRPPoqoOYBWGlRG8k/u?=
 =?us-ascii?Q?M1DkThJMrD0+Tk5Pz08vKkpUt7pz5joxP4K4Q1cqbKt3sVjPjk6AwLB1qIba?=
 =?us-ascii?Q?oH+OAyCKxIJLy/f/Ll18QNsae1I3S1SI4cfkIX+MIrnG3+1xSbtmzCqSJ19y?=
 =?us-ascii?Q?wlJCxoXtVzweaL9m/NhwFhpaqb24TMtUjrEkU2jqhXrBB6ijBcos+p7H7Tcz?=
 =?us-ascii?Q?hoMDIeUGG+oX7XQR5dmN4y/+S6mgTWaRfh8CLNoZlbh1Y+oMmWjD6eq1gIq6?=
 =?us-ascii?Q?5bWUp4OuO7SG116+l2OSIkYRlWN7SFdBTuuC7oj8HqCt5P31As++s+PZSfsZ?=
 =?us-ascii?Q?AbCTgUpzy3hHJb9hasc9rGJoLhPRWAWTPUZXQAgRrySmOfJeGCbF0TWwk3x9?=
 =?us-ascii?Q?upYmqD6E+uctALOafgeOuxX30gQCUHA8exSkdL0KAaxCuTLBu6T0GL1K5i3A?=
 =?us-ascii?Q?553p3X0AcAwWwGvjyc3LGtN07MKmYVpV8z1a76cT0nIe2/LSdM2Hh95wS4kL?=
 =?us-ascii?Q?Fd7/iXG+yIppymVQZ8+zZL64oQymbBSItcBfbnzb?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c29816-963b-4226-87f3-08dcb8b69605
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 21:02:32.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6SyPGwLIT4Lp7BGglUyZALx6Ok9KechgKOkToKqAMOycXawCQuca7gc5LaKgdNRkVbwIPRsY5b82jJeZ50jIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1402

The MANA driver's RX buffer alloc_size is passed into napi_build_skb() to
create SKB. skb_shinfo(skb) is located at the end of skb, and its alignment
is affected by the alloc_size passed into napi_build_skb(). The size needs
to be aligned properly for better performance and atomic operations.
Otherwise, on ARM64 CPU, for certain MTU settings like 4000, atomic
operations may panic on the skb_shinfo(skb)->dataref due to alignment fault.

To fix this bug, add proper alignment to the alloc_size calculation.

Sample panic info:
[  253.298819] Unable to handle kernel paging request at virtual address ffff000129ba5cce
[  253.300900] Mem abort info:
[  253.301760]   ESR = 0x0000000096000021
[  253.302825]   EC = 0x25: DABT (current EL), IL = 32 bits
[  253.304268]   SET = 0, FnV = 0
[  253.305172]   EA = 0, S1PTW = 0
[  253.306103]   FSC = 0x21: alignment fault
Call trace:
 __skb_clone+0xfc/0x198
 skb_clone+0x78/0xe0
 raw6_local_deliver+0xfc/0x228
 ip6_protocol_deliver_rcu+0x80/0x500
 ip6_input_finish+0x48/0x80
 ip6_input+0x48/0xc0
 ip6_sublist_rcv_finish+0x50/0x78
 ip6_sublist_rcv+0x1cc/0x2b8
 ipv6_list_rcv+0x100/0x150
 __netif_receive_skb_list_core+0x180/0x220
 netif_receive_skb_list_internal+0x198/0x2a8
 __napi_poll+0x138/0x250
 net_rx_action+0x148/0x330
 handle_softirqs+0x12c/0x3a0

Cc: stable@vger.kernel.org
Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d2f07e179e86..ae717d06e66f 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -599,7 +599,11 @@ static void mana_get_rxbuf_cfg(int mtu, u32 *datasize, u32 *alloc_size,
 	else
 		*headroom = XDP_PACKET_HEADROOM;
 
-	*alloc_size = mtu + MANA_RXBUF_PAD + *headroom;
+	*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
+
+	/* Using page pool in this case, so alloc_size is PAGE_SIZE */
+	if (*alloc_size < PAGE_SIZE)
+		*alloc_size = PAGE_SIZE;
 
 	*datasize = mtu + ETH_HLEN;
 }
-- 
2.34.1



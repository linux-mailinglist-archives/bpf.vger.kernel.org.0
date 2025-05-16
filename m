Return-Path: <bpf+bounces-58422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B3DABA461
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 21:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF507AC5CC
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482ED27F73B;
	Fri, 16 May 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aA7jcvqr"
X-Original-To: bpf@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020094.outbound.protection.outlook.com [52.101.56.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1902AEFE;
	Fri, 16 May 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425115; cv=fail; b=tMdJZ2h38rsGcdR+g/FSGYt1mFGF0N+UMdEQfG5P7gnPHsRHyMknSEQr1FaiTA5Xmo+Tgi7O/Pcbw5PhvOwsayE+JyNNtQsXMIT8+U8yjzhUh4BvyfbdzRkV0/yYZdg9q08ZXQeVKT1toI1mLn6jUlDyZuUWr6vQ3V+vk9a2xvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425115; c=relaxed/simple;
	bh=0X0qzrdRTyhaY7HKZKzY8PLcPa9RaklJUjSLccXMnLg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rbwP0Con4h3HR7aPjcpyzSZDJ3O4Pfw720M1Ye1n8BjA1M/fxi0Cr9I5b0k4JUf+qs6jSmUwgtP+ax6cpbCAVeQbyOPv4XZw9lopht/Hw7Usa6iXQNmFMnoD1vUWvtW0CRPSAJV2ox+lZgLM+oJMRKn/voJxA3n2ON1YU8P0gtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=aA7jcvqr; arc=fail smtp.client-ip=52.101.56.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqQ0uiSjFOA2rpuxMHclYv3zJFPJkW9BJKESToIAyDAmruq9TC/ZVoG6pjoz3n0nCcyso4SVNG8j0lrg2MdocAmVZXJJhR1LEOcTGT3cPZkEktQCQTOtoR86RjfX+eDs3frQpvqJb3HpKwp/vPfjMcNMKIfdKldeJz7hM8FMUiD62PCxyNOXkvuJeqM/iiEbiW7MzeIqyKp49AQguhBmGT8BlT2NOJkWfe+YAWWRfmk/NsCNIRLsEcquWiMmdMLBGK7WpkINWqcKXLznAFHmyan4uZaVH6+pANQJUvHwqsjKTk8mDA2KR+F+VDZXvpxe1mhOKSsq11vgn/vKVxgcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/PJ9gXiTRJcQ0m+75bRiF3DBVJlXm9BHFZ62CdNCOM=;
 b=apApS6T8tyCwmXS2TDFlWtdkb9NhwyTgeFwsFaWzidntD8Xm0cZSu3f0bVLxCdVmIv+uuU0pIInEWQT5C0KUj0cxpJ+DzmyWX1+Jq/oRGhimdusN2Ju0ckD1TGYjkEa6Kc6FcHyrN29PP3XRsrTVXva1tQBKzAwB+6sqUYYOiH/5Z9AtPRLCzF9dkzUgJyIddtlMTLalBlxfXc1hEYdsYautpASsYNgI7QbzzDpi/yunj4z1SCsoQXJ/P+x4M/zCVFAw/EhodQuA1Sm9P/8SrjHYEOUpeZvaLNylvH15rciETklY7VGSSNfCUrXpxencotI3A0VuCuQ3gbtB/goTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/PJ9gXiTRJcQ0m+75bRiF3DBVJlXm9BHFZ62CdNCOM=;
 b=aA7jcvqrImMueXLNHnpWfW9vxoh9kD9X4Pv8mc8T1AYZAmIUTHEGEjkIVGpZBgo6N5l1MVT/TFXUaUBB8lXc4pil/GIZ/8f1OiLwMizWQ/S7SuFVyrStJEbII99O8za+MowgauVtFhFn/je3BhanIczzjdZW8+53tfkbH38wg4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY5PR21MB1443.namprd21.prod.outlook.com (2603:10b6:a03:21f::18)
 by SJ1PR21MB3579.namprd21.prod.outlook.com (2603:10b6:a03:451::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.16; Fri, 16 May
 2025 19:51:49 +0000
Received: from BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef]) by BY5PR21MB1443.namprd21.prod.outlook.com
 ([fe80::2c5a:1a34:2c8d:48ef%7]) with mapi id 15.20.8769.013; Fri, 16 May 2025
 19:51:49 +0000
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
Subject: [PATCH net-next] net: mana: Add support for Multi Vports on Bare metal
Date: Fri, 16 May 2025 12:51:39 -0700
Message-Id: <1747425099-25830-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0186.namprd04.prod.outlook.com
 (2603:10b6:303:86::11) To BY5PR21MB1443.namprd21.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BY5PR21MB1443:EE_|SJ1PR21MB3579:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e7b98f-9b12-4d45-0717-08dd94b31895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xv9mGrBIZ5TRNKg/H608Ydt9fNAIJwPWJoVMbC1MGOuOsC8G24UDaaxXNEMn?=
 =?us-ascii?Q?xQ8W3lD7pxwJcrjUJLcaIOx/Iw+sgv6u/ic8WryuoUoONMtpCD2Td2rI/8Iv?=
 =?us-ascii?Q?D8GuPd1xo364qyUAUTiNRHO2R1OSf/VcRB9eIg6ygRzik26/nv3hfq/FeNZo?=
 =?us-ascii?Q?kH3jMJ34I7llhN4AwHxA7jGS9Vq+CQOJk1KE03L1NQ5+VP83nobgKZt14h9Y?=
 =?us-ascii?Q?bpAMSUAlAkZd1F5uk0P9C4Y3SdU0dqLRaWkCGgC3r9YnDlhd7azVHKAY3Z5V?=
 =?us-ascii?Q?CGmnAqscA1FKX0yjlD/8rD4QnP1ZnTz9e1yJG1Xk2cGxkc1KH7VcJxtYOgUi?=
 =?us-ascii?Q?vik0RDx6QeLRcbK6xI+EB+Ol3jmYIVKKo3z84nXD/YXs0RlVfEYVhAyIWnyh?=
 =?us-ascii?Q?gN6eGMRvf1tVQSKKpLQi0vFKaiSLmg6qVzB0ECwBDhHI/2qdyj1OJKmzva39?=
 =?us-ascii?Q?WVxdivolR88TpwgbZEVVvqF64Rz7ZY2jO5u/vb1NOHjlnyqAG+EVu4MxHZm0?=
 =?us-ascii?Q?mnIudZc1nGyHHc6tpVSevRooGerFKEwBqTQ9PROjxSwrJkcKmDj/8ON9gUVA?=
 =?us-ascii?Q?fgEeT5N4s0xA/ESvN3PuY449188FWcdkN1VNi5wKn4C8+21Pi3+wazmatww4?=
 =?us-ascii?Q?ITuHL/CuO+GuCyrNlUBp/txnt61hGT//2ixH0vqgBUlSw3viuitC7jvUOjXa?=
 =?us-ascii?Q?cLSK4JaMl73skbe5Fn9ZSdAUpl1O+iemF8WPyCBJGLT9f1+e/kzO+eLY/kIA?=
 =?us-ascii?Q?dgKMqRU26if93XUi+7UAuiw2vUw30vtekgWTHoR8dMuSq5eSlBqtccfEVeq1?=
 =?us-ascii?Q?psjZByMo6P8ige/mLO4ohXTmolVeyBGtI5S3yBeoh1j2Pa7d1GmI0ALxGRZS?=
 =?us-ascii?Q?TrlGfUW3ua74auDrXr1sgKgQZoqEsWttxOqUHbagB4iuB+25R1CTaJBc/SLY?=
 =?us-ascii?Q?PGzYB84juqL0d0bqrDxcoLqpze3Wyb92wTePyqV9uFgJw0rI0t+ZNwzkv6zS?=
 =?us-ascii?Q?WoK1FYfZb/JArPqdOkCy1LaXoTq4gT0HEQeiDQN8NcW3PHeywcJTVTMGmNfx?=
 =?us-ascii?Q?7k1J+RP9zJusuV7iHUBDtvjRXzUhLMpQQPYcUrivN14+ctCb5RxCtTZCxF4D?=
 =?us-ascii?Q?oFjul1bH7ekshxKKJYOIJLshNXynEf8zrPkDdz2m+j+Iy5ukaXD/7R5BCnyi?=
 =?us-ascii?Q?NU4+i343/6vSx32VHldkcMw3lnidTctreeIJ0kCPVccHAh4aHVJyazGUSsRb?=
 =?us-ascii?Q?AqrsfjqL3zAyEL4ggz45oKyb/wLwqBNGK/oSnptzfSPJk8c97YiI+HkIOeOi?=
 =?us-ascii?Q?0kKVSNvmbPuqKSuxr/eIsMl6NL9ruMDJN183swG5b5ThfM0NE5CsRcfNUsqz?=
 =?us-ascii?Q?DwKkXO0fdVHz9SF6dVnaSn3o9RKItpTroVwIPmMgq4OKWktqp3iH6MWEiDuB?=
 =?us-ascii?Q?lVMYfDhkxjnh8qV+X7WRYnSA59A4evTkIJrQbUjEswXkVBSEJ3GACw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1443.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HddCmVXkLiYKhqJ1oymmDcu0mibIvGjpoqEmiMLvindhC+Vq9SbbYTx0xhuW?=
 =?us-ascii?Q?Qr77ua4dWISpDMOn8mcU6rwJZiny8KXGhE/qlKsH2CVW+Kdc5vNcyHgkL5DV?=
 =?us-ascii?Q?fgnl74n8iRkuNA066KMpdsRKTrqBBGU7Q3BAWhpuzDrX0rbw2Csczuvqo3dg?=
 =?us-ascii?Q?JRovsDKWIHUWGwN7cOAcVvByRLxXrXdmDKSslNx2nt114yRypI1vhVvHDS4C?=
 =?us-ascii?Q?qRAfsWULB+4oWHDzjvnG8DpER7+hWjCz5RUMsMADX11lV/qgPTwJzuykDXf7?=
 =?us-ascii?Q?JEzeQt90dReZ44UIncZszNoYP6mSld1AxaLPRbhyLzJmgT4AFI7sspT6NBZ6?=
 =?us-ascii?Q?ExdI2SPrEdFhD/ykPBi7OZ0oEurOrOWe4Cn8yj5fEA0rufuTrluEddckMdFC?=
 =?us-ascii?Q?injNZh3THyqeUZaF8Y7/qL3QZMUpHbw3LOyRszg2aKTgwMXNYMa6tXAL9Z/M?=
 =?us-ascii?Q?qzOPbmcbIQXvsxkV5VVSnCyihuljxq0tC10dT54LhpIqx5BmOCujhPCe5yD6?=
 =?us-ascii?Q?1HSOXCq4ndSWv+3fNKeiUS9br5SIaTwwUQzhnNEmO6O8BqR54LqOQTcOLg5e?=
 =?us-ascii?Q?Bk6A88PIjz6RjfEJSXtYi64O6qtNw92jw8bI+20KoouMmHfdZm2CQW2EI1ql?=
 =?us-ascii?Q?3E6DJthAHNxvRmFiHv6Vu+mAWwAEIjKo1SrPiQgEGlKJ34efxL7log2xCSzd?=
 =?us-ascii?Q?ztGw97QNb+h1jRaFaVSDnFZZ42vF6SXzyH8HQ9wpBibophqqLTB05ygpBQcu?=
 =?us-ascii?Q?2yfgBqPBBwZq/KnGv2O0+0Z84hWTG73pCBDHMoS58YUaHglkWKXWaKhz999N?=
 =?us-ascii?Q?OpxIRZ6/kdyHRPdw9k7L9NoR7QKHaTCA3/XFEUhTnK1mH08vQwBseb0H/TQ7?=
 =?us-ascii?Q?VuLTA3U9YtYEeUCDci9Lwa9CP42NvEf65mJjwIXsYTVL3t8doUedC2EJcumR?=
 =?us-ascii?Q?Gaw1nSx/TLEhcJ2wNWpx5wqZhCCM1cn13Tz6E8Q0k2kci2SCelrTYHM6Obn2?=
 =?us-ascii?Q?IhAIIZhwhUza4qoshwTNiQqMgjbGocEEtNqUh7rbZPWuKICuHo6YVjnUaCXg?=
 =?us-ascii?Q?EhYQVcY32AFQ/ymt47yQfVMpBgPsozwL9gsJeTlTlOrfnio3FUZymTNRO0UP?=
 =?us-ascii?Q?a+yr0tFg0wSR+KA5EA/di7aV7YnHloPrXb/7AkCA64Gcqxh4JuO0TBGnscgA?=
 =?us-ascii?Q?aTCpUDSNskt6HTBoIsUnHA5aXO/St9zEsMkxfQhJufZQNHDN87eropzdSCLE?=
 =?us-ascii?Q?cyQ/o9LzrsCVKBxxMqobtALbH2CaDH2ETzXlPXkgXzBgijujMUii7pEd69dx?=
 =?us-ascii?Q?ipVNfVsYq4/9mR8pQ3B28QX7VGgKQ0fJ+J8LTbpVzgDNqHl/D9GdtHH6wITH?=
 =?us-ascii?Q?bjAYO7fBZ/IETxpd3H55seesxNLrDEF9+MG8R+ydpJ6mYVMq8WchtKRDxBB2?=
 =?us-ascii?Q?juaMbpwqGwmmRDHJu5grjjvMwjzlvAKM5KMUO0OcC7cuks5LSezmeIDmdz/W?=
 =?us-ascii?Q?8HkyLXHH+2LJ0VIK4OgYhoNtuKHRgV0Os02J1MNdfnIQaCj6cWRtAWijZlB/?=
 =?us-ascii?Q?9E1of3N4d2ogWMeSH8OHh9/+QEaq//mV1Gisij2L?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e7b98f-9b12-4d45-0717-08dd94b31895
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1443.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 19:51:49.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obBSkah7C6O2Sv7r3pWu+XRpY1E05dens9kAydkm8ZGv4HE2fgV8KbYv5E2bxTB8fcZii3MoFHhvE3EIDt9m/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3579

To support Multi Vports on Bare metal, increase the device config response
version. And, skip the register HW vport, and register filter steps, when
the Bare metal hostmode is set.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 22 +++++++++++++------
 include/net/mana/mana.h                       |  4 +++-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 2bac6be8f6a0..0273696d254b 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -921,7 +921,7 @@ static void mana_pf_deregister_filter(struct mana_port_context *apc)
 
 static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 				 u32 proto_minor_ver, u32 proto_micro_ver,
-				 u16 *max_num_vports)
+				 u16 *max_num_vports, u8 *bm_hostmode)
 {
 	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct mana_query_device_cfg_resp resp = {};
@@ -932,7 +932,7 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_DEV_CONFIG,
 			     sizeof(req), sizeof(resp));
 
-	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;
+	req.hdr.resp.msg_version = GDMA_MESSAGE_V3;
 
 	req.proto_major_ver = proto_major_ver;
 	req.proto_minor_ver = proto_minor_ver;
@@ -961,6 +961,11 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	else
 		gc->adapter_mtu = ETH_FRAME_LEN;
 
+	if (resp.hdr.response.msg_version == GDMA_MESSAGE_V3)
+		*bm_hostmode = resp.bm_hostmode;
+	else
+		*bm_hostmode = 0;
+
 	debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc->adapter_mtu);
 
 	return 0;
@@ -2441,7 +2446,7 @@ static void mana_destroy_vport(struct mana_port_context *apc)
 	mana_destroy_txq(apc);
 	mana_uncfg_vport(apc);
 
-	if (gd->gdma_context->is_pf)
+	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
 		mana_pf_deregister_hw_vport(apc);
 }
 
@@ -2453,7 +2458,7 @@ static int mana_create_vport(struct mana_port_context *apc,
 
 	apc->default_rxobj = INVALID_MANA_HANDLE;
 
-	if (gd->gdma_context->is_pf) {
+	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode) {
 		err = mana_pf_register_hw_vport(apc);
 		if (err)
 			return err;
@@ -2689,7 +2694,7 @@ int mana_alloc_queues(struct net_device *ndev)
 		goto destroy_vport;
 	}
 
-	if (gd->gdma_context->is_pf) {
+	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode) {
 		err = mana_pf_register_filter(apc);
 		if (err)
 			goto destroy_vport;
@@ -2751,7 +2756,7 @@ static int mana_dealloc_queues(struct net_device *ndev)
 
 	mana_chn_setxdp(apc, NULL);
 
-	if (gd->gdma_context->is_pf)
+	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
 		mana_pf_deregister_filter(apc);
 
 	/* No packet can be transmitted now since apc->port_is_up is false.
@@ -2998,6 +3003,7 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	struct gdma_context *gc = gd->gdma_context;
 	struct mana_context *ac = gd->driver_data;
 	struct device *dev = gc->dev;
+	u8 bm_hostmode = 0;
 	u16 num_ports = 0;
 	int err;
 	int i;
@@ -3026,10 +3032,12 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 	}
 
 	err = mana_query_device_cfg(ac, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
-				    MANA_MICRO_VERSION, &num_ports);
+				    MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
 	if (err)
 		goto out;
 
+	ac->bm_hostmode = bm_hostmode;
+
 	if (!resuming) {
 		ac->num_ports = num_ports;
 	} else {
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0f78065de8fe..b352d2a7118e 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -408,6 +408,7 @@ struct mana_context {
 	struct gdma_dev *gdma_dev;
 
 	u16 num_ports;
+	u8 bm_hostmode; /* Bare Metal Host Mode Enabled */
 
 	struct mana_eq *eqs;
 	struct dentry *mana_eqs_debugfs;
@@ -557,7 +558,8 @@ struct mana_query_device_cfg_resp {
 	u64 pf_cap_flags4;
 
 	u16 max_num_vports;
-	u16 reserved;
+	u8 bm_hostmode; /* response v3: Bare Metal Host Mode Enabled */
+	u8 reserved;
 	u32 max_num_eqs;
 
 	/* response v2: */
-- 
2.34.1



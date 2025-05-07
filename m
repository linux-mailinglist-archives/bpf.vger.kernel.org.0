Return-Path: <bpf+bounces-57629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB42AAD640
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50661B68B6D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54CE2116E9;
	Wed,  7 May 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="sndkvaP0"
X-Original-To: bpf@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217EB21147D;
	Wed,  7 May 2025 06:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599934; cv=fail; b=YHhwsZ7K0ZolMl8j8Jgc+yiE03HM6o1l7jwp3rzuYP99ZdWdtkbvkjaYgNYP1+Awo0B4A2K6sQVaJfinWKsv8qx00j5S/RtjxGmiAcbBk0QCiW+W1MXZB1fHf1/LXpG0h8fX80T11+JCfKZ1CwOaneX3iYNbbhqQts688YZCzyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599934; c=relaxed/simple;
	bh=2WdnxOOo74eutaydWestecJG9JylPdPzM84F9gn3IZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzD4n+GzBB4wP976nhH1rHtGR1/bvwK4zaTGdJtCyihZsPR2Pgkr2Mxkr7Q2KLnjAUeTgVObvVZcU7AP55AXRDjzm4PHzoP0tjfCxoKM+duoIljODBGCYSL8rt/YhlQmo/Z7RcWrBiWt0pUns7Ea28EBM60yTqQZMqiEgJowttI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=sndkvaP0; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7qjMMLNnF8/WGUN4IAfA/RLXXLCutBKK7e3Z3GFP1rgtlkap2rTlncZxoNLIHNHbV8wEK1JjAAkJi8dm1Tu88gC/m42e4Puc73lgnlmcrKlUAefYQqUIZZc8Itl9MzTssKy6NTXCoOmnKpL0JW2yWuu65hrAE3aaPoYJDKe1RL/EYL9LxlVXG341wNZSvo+Pbr1+HOcDFGhQ7+AfMUU2oPkZQW7oMiHWYs6DHnaHsuwnRWS4+4g1bU3RYZbZ9wWSMOR/0xlH3cmxazeBbknNOwnZmaZolVnU7JIxQo8fnzi8tuim9Sr3s1NJOI+pOrTH4LO+UMnhlPUmkbMiH+NUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgE+5rcYEb8I2oibgRIOV8PYXnvDsqbtJCkqjd1oRcw=;
 b=ND3+cytnwlwEPVILYfDTEqcuyDc2KIVJbeg1IId+8CNzqdf5pj8nC+3VEbNWW2elJTb2jHfhJIXvk1+hx4Hd7MfDDboIR8Gkk5T2OA5EhQKUHMnklTpmLFXrWAt6iXi0Zo6/TNANlFZd1gamoEwIGCxnyN4uk9+AVRmTRGKFUYGiG9KaTbwWslBvm6PRAIQdfYkKaRRVKiJcPnoNPPECUvIhAm4s+divudIBPdj28pbrOg87f/9IJ96jSueHNWC1ySCIrId6j++p9ilCVoHZZHvunm3H8ihx/h5QEP8hGKB9HRVoYntLozZyf54uiXMQ1TLXNAYdIN/4R4UtH7l3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgE+5rcYEb8I2oibgRIOV8PYXnvDsqbtJCkqjd1oRcw=;
 b=sndkvaP0M828Wh3jqxTcxYYH6ALB17zY3tabb3nJ6g2mk0fIy41zzucQq9U6Td2zrzXPl7p0q6hDtfqgU8OL13poNX0FcrurhtfPV0T9qAS7ci5u0w8nBYdEuoL1SyNzoGSniXFOuZFrEXbciwZJnLfiVK7bycefelFiVMH3ZVO5zVNJ1oJdhwD7A60owRTW2xa7qiEjk3876lSgH6LZbIPC7WoHmHzC1YgzthV7NT8QyK3lWbAzjnVdrykirtTh7bNUVfJCTJtoQEuRqnQ4VWVIdV67SPWxpqRHRaafYHQSwZnEAdMHnkGjrUWtM2lHXBtbodyFI9FwvYoMIUhc+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by MN2PR03MB5088.namprd03.prod.outlook.com (2603:10b6:208:1b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 06:38:44 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 06:38:44 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH net-next v5 1/3] net: stmmac: Refactor VLAN implementation
Date: Wed,  7 May 2025 14:38:10 +0800
Message-Id: <20250507063812.34000-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250507063812.34000-1-boon.khai.ng@altera.com>
References: <20250507063812.34000-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|MN2PR03MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c485eb-c00f-4c8d-870e-08dd8d31cfd6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d1Q0d0iA2BBjympC2iL7mdCPcF1/SxhMjwWwmLeSnyDgHq+Oxk5YDB8bwh+j?=
 =?us-ascii?Q?d2PL066WEpJBKMWWhu7J3cHvtR0Oki9Jwwfv/N6LAxuT1XZ9lOkD3D5Rt4vi?=
 =?us-ascii?Q?YACR7W2iQvluRFyuGPgWWfBTOyRIVPbpoKKQ0+k3WdoM2GU744dE1mUR+kgF?=
 =?us-ascii?Q?PLK09aiipvvWaVd66JMuJQWtguZOxMlSZ411R6MJitR4frTxw9Xbgp1fiGLw?=
 =?us-ascii?Q?B+Vl0tpn1b678/GnV0xwFhH104KlyIpG5U9qCAwsQ4DeW3oY8wLzbvLpbHG2?=
 =?us-ascii?Q?De/KO1+p0UHkSp1uwv6wPrpcFVVOy5/faMCxSNB818TJp1kA2NfV9LvIHhAv?=
 =?us-ascii?Q?Irf1ucNf/Ju+SinJL5VfF5Xb2EtJ7w+j+Se6V8vQCSNmUg92OzaINQBJLfPU?=
 =?us-ascii?Q?+IaLfF56MrN1PU9IpkQIopPU2SPCSdntfziVkxZdgrh04yWyHzpPLfyEvfTt?=
 =?us-ascii?Q?o1yOgU6Q5VCS6fEKAUQEwbrs9tLg5qIdygY9cQ5XCFjNuGOP/u+NZXfbWqtP?=
 =?us-ascii?Q?nPmJC+z9eDLBPSZjXM94LgwHbjnKm9v0QqMu9hqQLYGgpw4jOmDoYb/ecwZO?=
 =?us-ascii?Q?lIHhcndMSdTf5zW4VhwlpiOza/FTRkV3eqx5HnZ5EEyxffmB4li82OyjJ1wZ?=
 =?us-ascii?Q?8zIC2yJZgZBoi4K6AutyLOZERqs3bk8b+nEBTurP27lCXU7wwomov1ttjHK3?=
 =?us-ascii?Q?UzAA0PHi8x60ykvvbhBn48C0B7KEZ5t+eeO2OUCdiKU2En4hvtez/Y3PiCZa?=
 =?us-ascii?Q?QDu2la/zKzDrzDJ7KwZIwDPB+hsNNlS1jbHqTknZT0fQlK0WzvWDd6Ng3AEb?=
 =?us-ascii?Q?MtTpfVY63otj8QhtqH36y8zWqs4RXdNNEGW9TOy/WfH2T44NcBfvkSihsfTi?=
 =?us-ascii?Q?2VzfIO579Ju/BenaZ0RCT3QnBuOFKQPnaH7i8KKnLP66IIqPGeU18HwwwiNH?=
 =?us-ascii?Q?wZmI/6z3J7YBdQkA8B4DMDqH/gyyvtOI79+EZwpF2FEa4ybLOfLVXM2O41Gi?=
 =?us-ascii?Q?pZc2JLMKt9kiLy05N5FI8orHr99qasixJfbVRKUdEDfqzmPmxLEgtfBpxTEl?=
 =?us-ascii?Q?X60nCokW/1YUFLR1ozlxbkvW9qjHNa5ZdGtf9Bwqb7AjC7dPHXYZL4XhQx9d?=
 =?us-ascii?Q?dwcPSv+ZMSBoJtsyRDWKeJia1M5NqbrsnQw0069mT9krOyGYvf2taR2eiDCu?=
 =?us-ascii?Q?rAV8Y1zJPKFZweATHs3eBRh45GmKVpT8MBIH8acQX6jJKazljphsFaENFJwv?=
 =?us-ascii?Q?lLbaBER4pSTILtGfqDk7cyqlo9J3SkeHGN9vWX9APTK8VCCnyg+KLlKwnfxn?=
 =?us-ascii?Q?Z2dFsJ9tGLx16Ef0zJ3B0jCclYOtXdaGAQT2WTa7bofwL3OTfGKz9MBZ9hLl?=
 =?us-ascii?Q?HxyITmDbow7RNp5iDd6z9VR2EalaflkeYV+mxQfnhuNSYRfQssK14++GJkc/?=
 =?us-ascii?Q?LJA38x2MFQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?38ARMpY/J7GsgNP91Bo91SgKOqqBEEzlceCAwKVoOYh6OeL+ZnDF+gnsTX1q?=
 =?us-ascii?Q?oE2C7TioI7ibFY9kzUgZp07N7Vo9Tw2Z95YitsLYk7FYbWnJcJzn2Ik0pSxb?=
 =?us-ascii?Q?BFaFrsRAJ2jD3kwsQhrIzNeC7EpS1FNls/bmKq38/k1l/CN9N4J/DTmDtAMz?=
 =?us-ascii?Q?Lkxled6V3lV0heLP/9J8AwiBEF4Jef9WYkd2rsdTByUA+eWCwq3xAC31wBsF?=
 =?us-ascii?Q?bxzKCSrVI9AJr0i943z9r77mb0UMqlOS9heHCyznk5123uXNCrhmEE3Y2Ecy?=
 =?us-ascii?Q?pJTMrCu7bZ7sBukLBsXLQ96xAKBpxkARZgzXbwtwv06ehl8Vq6j2O2E6MJK2?=
 =?us-ascii?Q?kpPeMId+sOL0R0K6EmGBPdfWRzJbieAzv/croWNiXQiBcSsvGoSPV0yXjQJS?=
 =?us-ascii?Q?kHAJvNZ7erf1aoxgacnqUUcC3kubm6F4VqdkQsolI+ykOgKdJnS42X1Oxu7l?=
 =?us-ascii?Q?KjpKecqF8WBAYCInmQSKXuTyJx8rzyzq78/uJ6mvgqtp2SX38eGV31wx5Uc3?=
 =?us-ascii?Q?ufViEUBcwq8hbIbaW3ijYsI74ITW6JK88WoTg59D9olgYpWPPdR4RajJyS2V?=
 =?us-ascii?Q?z4GdM6DkbpI8vGE00Fr01tAUF4sakXVqv9jRQn2F+JDGUfd4Sj5fif66eQBu?=
 =?us-ascii?Q?zAJRTd4SnZuA4JIfaGLdVnGr1c+jWVm1bQseBZvh2Y2Bw/uK2NqRVimBWUa2?=
 =?us-ascii?Q?G9hAOqatng9Qer8sFmLI4gZFK3oUDXHNN6IjqfVqbXYylH/Q0pXbpLi9JJWF?=
 =?us-ascii?Q?6tJNODkSKama0/1vgDBK2k9f/lbBFyG2vikWVbrqG6tzVaLqqeJ91QfVDHph?=
 =?us-ascii?Q?GINMyQXXUcAj6MGxs3sQu7FgZptILUhPdtNyE6Htt8SFUI+G585qqoVkugUa?=
 =?us-ascii?Q?Qu72c9ENzr9GodVmpJH5M5wWhm/jO6SFbofuZLKrzDa95Bw+CjhmV3rWnRfA?=
 =?us-ascii?Q?I+/1YKdcfuAZaHHfwwm4eCRrTxlV6QyfSlC+6nWWZpV12gv8ir4YptGRthek?=
 =?us-ascii?Q?ix1r1YlTMqyn8UB0E3Fnen7BxpyXiqSvsFZdEDrK9T9eIwCwyUiHhdEIkN16?=
 =?us-ascii?Q?80VYK1k5IjIEKfHy68ftfQSggYtw3405PgEB56TCVUSMxX1wlP5DQXxLnvQ7?=
 =?us-ascii?Q?PEoJxJZP8L2007aOrzLmTgmp28khVMrhCY01Zx35S6TwV/j0gEaOw7B+xYdS?=
 =?us-ascii?Q?pdBqV2+ihMEGE6fzwT+U0K+iyomja35H5dt+WQ1Gpi7d4eI7eU2mO/9Npo0I?=
 =?us-ascii?Q?d3N6qnYBLgAxunj3QssbeS+tnAuyydHXNDXrhyXSik1eeL7eh44pxgZblV3M?=
 =?us-ascii?Q?Bj3BaS11cdYlM586vIA6+HCXfDN5rTOXJxH7+0Ss1owHbh4t8oDU1BO6SmqF?=
 =?us-ascii?Q?pR7T9kkDsdKz23JvaSn8TrbG4eh9VofnmvR7CTgp3YgOsFzgxOlpR1hN9930?=
 =?us-ascii?Q?cDp81YbI5tdmyltu/KNdUuM0154SSHjo+ny2P6JAiFr+iXh/KjDG+icOub8f?=
 =?us-ascii?Q?Y/t/6OzOStOKtvYVMDUtjbgzsPreN2fcDSxBZ04T3m92PL+K+/jr0YdOujz8?=
 =?us-ascii?Q?fnteSKEDLyTEWVm/wmraKSOgQWfhtx7EFZKQ7N5WkCTccQvoqflaz8MLRqQw?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c485eb-c00f-4c8d-870e-08dd8d31cfd6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 06:38:44.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzNuk8fJYzQgKCSyU8zC87IrLMhJTBl6dCywhXc0uZT+HELtNPCYKDpaoeasBivP5wKvO/p5FfJxS6tKhnbiHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5088

Refactor VLAN implementation by moving common code for DWMAC4 and
DWXGMAC IPs into a separate VLAN module. VLAN implementation for
DWMAC4 and DWXGMAC differs only for CSR base address, the descriptor
for the VLAN ID and VLAN VALID bit field.

The descriptor format for VLAN is not moved to the common code due
to hardware-specific differences between DWMAC4 and DWXGMAC.

For the DWMAC4 IP, the Receive Normal Descriptor 0 (RDES0) is
formatted as follows:
    31                                                0
      ------------------------ -----------------------
RDES0| Inner VLAN TAG [31:16] | Outer VLAN TAG [15:0] |
      ------------------------ -----------------------

For the DWXGMAC IP, the RDES0 format varies based on the
Tunneled Frame bit (TNP):

a) For Non-Tunneled Frame (TNP=0)

    31                                                0
      ------------------------ -----------------------
RDES0| Inner VLAN TAG [31:16] | Outer VLAN TAG [15:0] |
      ------------------------ -----------------------

b) For Tunneled Frame (TNP=1)

     31                   8 7                3 2      0
      --------------------- ------------------ -------
RDES0| VNID/VSID           | Reserved         | OL2L3 |
      --------------------- ------------------ ------

The logic for handling tunneled frames is not yet implemented
in the dwxgmac2_wrback_get_rx_vlan_tci() function. Therefore,
it is prudent to maintain separate functions within their
respective descriptor driver files
(dwxgmac2_descs.c and dwmac4_descs.c).

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  40 --
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 293 +------------
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  13 -
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  87 ----
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   9 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  62 +--
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.c | 402 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_vlan.h |  80 ++++
 10 files changed, 527 insertions(+), 462 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 91050215511b..b591d93f8503 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o \
+	      stmmac_xdp.o stmmac_est.o stmmac_fpe.o stmmac_vlan.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 412b07e77945..ea5da5793362 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -602,6 +602,7 @@ struct mac_device_info {
 	const struct stmmac_tc_ops *tc;
 	const struct stmmac_mmc_ops *mmc;
 	const struct stmmac_est_ops *est;
+	const struct stmmac_vlan_ops *vlan;
 	struct dw_xpcs *xpcs;
 	struct phylink_pcs *phylink_pcs;
 	struct mii_regs mii;	/* MII register Addresses */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 5f387ec27c8c..f4694fd576f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -17,11 +17,7 @@
 #define GMAC_EXT_CONFIG			0x00000004
 #define GMAC_PACKET_FILTER		0x00000008
 #define GMAC_HASH_TAB(x)		(0x10 + (x) * 4)
-#define GMAC_VLAN_TAG			0x00000050
-#define GMAC_VLAN_TAG_DATA		0x00000054
-#define GMAC_VLAN_HASH_TABLE		0x00000058
 #define GMAC_RX_FLOW_CTRL		0x00000090
-#define GMAC_VLAN_INCL			0x00000060
 #define GMAC_QX_TX_FLOW_CTRL(x)		(0x70 + x * 4)
 #define GMAC_TXQ_PRTY_MAP0		0x98
 #define GMAC_TXQ_PRTY_MAP1		0x9C
@@ -81,42 +77,6 @@
 
 #define GMAC_MAX_PERFECT_ADDRESSES	128
 
-/* MAC VLAN */
-#define GMAC_VLAN_EDVLP			BIT(26)
-#define GMAC_VLAN_VTHM			BIT(25)
-#define GMAC_VLAN_DOVLTC		BIT(20)
-#define GMAC_VLAN_ESVL			BIT(18)
-#define GMAC_VLAN_ETV			BIT(16)
-#define GMAC_VLAN_VID			GENMASK(15, 0)
-#define GMAC_VLAN_VLTI			BIT(20)
-#define GMAC_VLAN_CSVL			BIT(19)
-#define GMAC_VLAN_VLC			GENMASK(17, 16)
-#define GMAC_VLAN_VLC_SHIFT		16
-#define GMAC_VLAN_VLHT			GENMASK(15, 0)
-
-/* MAC VLAN Tag */
-#define GMAC_VLAN_TAG_VID		GENMASK(15, 0)
-#define GMAC_VLAN_TAG_ETV		BIT(16)
-
-/* MAC VLAN Tag Control */
-#define GMAC_VLAN_TAG_CTRL_OB		BIT(0)
-#define GMAC_VLAN_TAG_CTRL_CT		BIT(1)
-#define GMAC_VLAN_TAG_CTRL_OFS_MASK	GENMASK(6, 2)
-#define GMAC_VLAN_TAG_CTRL_OFS_SHIFT	2
-#define GMAC_VLAN_TAG_CTRL_EVLS_MASK	GENMASK(22, 21)
-#define GMAC_VLAN_TAG_CTRL_EVLS_SHIFT	21
-#define GMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
-
-#define GMAC_VLAN_TAG_STRIP_NONE	(0x0 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_PASS	(0x1 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_FAIL	(0x2 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-#define GMAC_VLAN_TAG_STRIP_ALL		(0x3 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
-
-/* MAC VLAN Tag Data/Filter */
-#define GMAC_VLAN_TAG_DATA_VID		GENMASK(15, 0)
-#define GMAC_VLAN_TAG_DATA_VEN		BIT(16)
-#define GMAC_VLAN_TAG_DATA_ETV		BIT(17)
-
 /* MAC RX Queue Enable */
 #define GMAC_RX_QUEUE_CLEAR(queue)	~(GENMASK(1, 0) << ((queue) * 2))
 #define GMAC_RX_AV_QUEUE_ENABLE(queue)	BIT((queue) * 2)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index cc4ddf608652..55f9614cd6a4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -18,6 +18,7 @@
 #include "stmmac.h"
 #include "stmmac_fpe.h"
 #include "stmmac_pcs.h"
+#include "stmmac_vlan.h"
 #include "dwmac4.h"
 #include "dwmac5.h"
 
@@ -448,165 +449,6 @@ static void dwmac4_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + GMAC4_LPI_TIMER_CTRL);
 }
 
-static void dwmac4_write_single_vlan(struct net_device *dev, u16 vid)
-{
-	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
-	u32 val;
-
-	val = readl(ioaddr + GMAC_VLAN_TAG);
-	val &= ~GMAC_VLAN_TAG_VID;
-	val |= GMAC_VLAN_TAG_ETV | vid;
-
-	writel(val, ioaddr + GMAC_VLAN_TAG);
-}
-
-static int dwmac4_write_vlan_filter(struct net_device *dev,
-				    struct mac_device_info *hw,
-				    u8 index, u32 data)
-{
-	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
-	int ret;
-	u32 val;
-
-	if (index >= hw->num_vlan)
-		return -EINVAL;
-
-	writel(data, ioaddr + GMAC_VLAN_TAG_DATA);
-
-	val = readl(ioaddr + GMAC_VLAN_TAG);
-	val &= ~(GMAC_VLAN_TAG_CTRL_OFS_MASK |
-		GMAC_VLAN_TAG_CTRL_CT |
-		GMAC_VLAN_TAG_CTRL_OB);
-	val |= (index << GMAC_VLAN_TAG_CTRL_OFS_SHIFT) | GMAC_VLAN_TAG_CTRL_OB;
-
-	writel(val, ioaddr + GMAC_VLAN_TAG);
-
-	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
-				 !(val & GMAC_VLAN_TAG_CTRL_OB),
-				 1000, 500000);
-	if (ret) {
-		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
-static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
-				      struct mac_device_info *hw,
-				      __be16 proto, u16 vid)
-{
-	int index = -1;
-	u32 val = 0;
-	int i, ret;
-
-	if (vid > 4095)
-		return -EINVAL;
-
-	/* Single Rx VLAN Filter */
-	if (hw->num_vlan == 1) {
-		/* For single VLAN filter, VID 0 means VLAN promiscuous */
-		if (vid == 0) {
-			netdev_warn(dev, "Adding VLAN ID 0 is not supported\n");
-			return -EPERM;
-		}
-
-		if (hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) {
-			netdev_err(dev, "Only single VLAN ID supported\n");
-			return -EPERM;
-		}
-
-		hw->vlan_filter[0] = vid;
-		dwmac4_write_single_vlan(dev, vid);
-
-		return 0;
-	}
-
-	/* Extended Rx VLAN Filter Enable */
-	val |= GMAC_VLAN_TAG_DATA_ETV | GMAC_VLAN_TAG_DATA_VEN | vid;
-
-	for (i = 0; i < hw->num_vlan; i++) {
-		if (hw->vlan_filter[i] == val)
-			return 0;
-		else if (!(hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN))
-			index = i;
-	}
-
-	if (index == -1) {
-		netdev_err(dev, "MAC_VLAN_Tag_Filter full (size: %0u)\n",
-			   hw->num_vlan);
-		return -EPERM;
-	}
-
-	ret = dwmac4_write_vlan_filter(dev, hw, index, val);
-
-	if (!ret)
-		hw->vlan_filter[index] = val;
-
-	return ret;
-}
-
-static int dwmac4_del_hw_vlan_rx_fltr(struct net_device *dev,
-				      struct mac_device_info *hw,
-				      __be16 proto, u16 vid)
-{
-	int i, ret = 0;
-
-	/* Single Rx VLAN Filter */
-	if (hw->num_vlan == 1) {
-		if ((hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) == vid) {
-			hw->vlan_filter[0] = 0;
-			dwmac4_write_single_vlan(dev, 0);
-		}
-		return 0;
-	}
-
-	/* Extended Rx VLAN Filter Enable */
-	for (i = 0; i < hw->num_vlan; i++) {
-		if ((hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VID) == vid) {
-			ret = dwmac4_write_vlan_filter(dev, hw, i, 0);
-
-			if (!ret)
-				hw->vlan_filter[i] = 0;
-			else
-				return ret;
-		}
-	}
-
-	return ret;
-}
-
-static void dwmac4_restore_hw_vlan_rx_fltr(struct net_device *dev,
-					   struct mac_device_info *hw)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-	u32 hash;
-	u32 val;
-	int i;
-
-	/* Single Rx VLAN Filter */
-	if (hw->num_vlan == 1) {
-		dwmac4_write_single_vlan(dev, hw->vlan_filter[0]);
-		return;
-	}
-
-	/* Extended Rx VLAN Filter Enable */
-	for (i = 0; i < hw->num_vlan; i++) {
-		if (hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN) {
-			val = hw->vlan_filter[i];
-			dwmac4_write_vlan_filter(dev, hw, i, val);
-		}
-	}
-
-	hash = readl(ioaddr + GMAC_VLAN_HASH_TABLE);
-	if (hash & GMAC_VLAN_VLHT) {
-		value = readl(ioaddr + GMAC_VLAN_TAG);
-		value |= GMAC_VLAN_VTHM;
-		writel(value, ioaddr + GMAC_VLAN_TAG);
-	}
-}
-
 static void dwmac4_set_filter(struct mac_device_info *hw,
 			      struct net_device *dev)
 {
@@ -965,45 +807,6 @@ static void dwmac4_set_mac_loopback(void __iomem *ioaddr, bool enable)
 	writel(value, ioaddr + GMAC_CONFIG);
 }
 
-static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				    u16 perfect_match, bool is_double)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	writel(hash, ioaddr + GMAC_VLAN_HASH_TABLE);
-
-	value = readl(ioaddr + GMAC_VLAN_TAG);
-
-	if (hash) {
-		value |= GMAC_VLAN_VTHM | GMAC_VLAN_ETV;
-		if (is_double) {
-			value |= GMAC_VLAN_EDVLP;
-			value |= GMAC_VLAN_ESVL;
-			value |= GMAC_VLAN_DOVLTC;
-		}
-
-		writel(value, ioaddr + GMAC_VLAN_TAG);
-	} else if (perfect_match) {
-		u32 value = GMAC_VLAN_ETV;
-
-		if (is_double) {
-			value |= GMAC_VLAN_EDVLP;
-			value |= GMAC_VLAN_ESVL;
-			value |= GMAC_VLAN_DOVLTC;
-		}
-
-		writel(value | perfect_match, ioaddr + GMAC_VLAN_TAG);
-	} else {
-		value &= ~(GMAC_VLAN_VTHM | GMAC_VLAN_ETV);
-		value &= ~(GMAC_VLAN_EDVLP | GMAC_VLAN_ESVL);
-		value &= ~GMAC_VLAN_DOVLTC;
-		value &= ~GMAC_VLAN_VID;
-
-		writel(value, ioaddr + GMAC_VLAN_TAG);
-	}
-}
-
 static void dwmac4_sarc_configure(void __iomem *ioaddr, int val)
 {
 	u32 value = readl(ioaddr + GMAC_CONFIG);
@@ -1014,19 +817,6 @@ static void dwmac4_sarc_configure(void __iomem *ioaddr, int val)
 	writel(value, ioaddr + GMAC_CONFIG);
 }
 
-static void dwmac4_enable_vlan(struct mac_device_info *hw, u32 type)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	value = readl(ioaddr + GMAC_VLAN_INCL);
-	value |= GMAC_VLAN_VLTI;
-	value |= GMAC_VLAN_CSVL; /* Only use SVLAN */
-	value &= ~GMAC_VLAN_VLC;
-	value |= (type << GMAC_VLAN_VLC_SHIFT) & GMAC_VLAN_VLC;
-	writel(value, ioaddr + GMAC_VLAN_INCL);
-}
-
 static void dwmac4_set_arp_offload(struct mac_device_info *hw, bool en,
 				   u32 addr)
 {
@@ -1143,35 +933,6 @@ static int dwmac4_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 	return 0;
 }
 
-static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
-			      struct dma_desc *rx_desc, struct sk_buff *skb)
-{
-	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
-		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
-
-		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
-	}
-}
-
-static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value = readl(ioaddr + GMAC_VLAN_TAG);
-
-	value &= ~GMAC_VLAN_TAG_CTRL_EVLS_MASK;
-
-	if (hw->hw_vlan_en)
-		/* Always strip VLAN on Receive */
-		value |= GMAC_VLAN_TAG_STRIP_ALL;
-	else
-		/* Do not strip VLAN on Receive */
-		value |= GMAC_VLAN_TAG_STRIP_NONE;
-
-	/* Enable outer VLAN Tag in Rx DMA descriptor */
-	value |= GMAC_VLAN_TAG_CTRL_EVLRXS;
-	writel(value, ioaddr + GMAC_VLAN_TAG);
-}
-
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
@@ -1201,17 +962,10 @@ const struct stmmac_ops dwmac4_ops = {
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
-	.update_vlan_hash = dwmac4_update_vlan_hash,
 	.sarc_configure = dwmac4_sarc_configure,
-	.enable_vlan = dwmac4_enable_vlan,
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
 const struct stmmac_ops dwmac410_ops = {
@@ -1244,18 +998,11 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_filter = dwmac4_set_filter,
 	.flex_pps_config = dwmac5_flex_pps_config,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
-	.update_vlan_hash = dwmac4_update_vlan_hash,
 	.sarc_configure = dwmac4_sarc_configure,
-	.enable_vlan = dwmac4_enable_vlan,
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
 	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
 const struct stmmac_ops dwmac510_ops = {
@@ -1292,51 +1039,13 @@ const struct stmmac_ops dwmac510_ops = {
 	.rxp_config = dwmac5_rxp_config,
 	.flex_pps_config = dwmac5_flex_pps_config,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
-	.update_vlan_hash = dwmac4_update_vlan_hash,
 	.sarc_configure = dwmac4_sarc_configure,
-	.enable_vlan = dwmac4_enable_vlan,
 	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
 	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
-	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
-	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
-	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
-	.rx_hw_vlan = dwmac4_rx_hw_vlan,
-	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
-static u32 dwmac4_get_num_vlan(void __iomem *ioaddr)
-{
-	u32 val, num_vlan;
-
-	val = readl(ioaddr + GMAC_HW_FEATURE3);
-	switch (val & GMAC_HW_FEAT_NRVF) {
-	case 0:
-		num_vlan = 1;
-		break;
-	case 1:
-		num_vlan = 4;
-		break;
-	case 2:
-		num_vlan = 8;
-		break;
-	case 3:
-		num_vlan = 16;
-		break;
-	case 4:
-		num_vlan = 24;
-		break;
-	case 5:
-		num_vlan = 32;
-		break;
-	default:
-		num_vlan = 1;
-	}
-
-	return num_vlan;
-}
-
 int dwmac4_setup(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index a03f5d771566..5e369a9a2595 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -57,19 +57,6 @@
 #define XGMAC_FILTER_PR			BIT(0)
 #define XGMAC_HASH_TABLE(x)		(0x00000010 + (x) * 4)
 #define XGMAC_MAX_HASH_TABLE		8
-#define XGMAC_VLAN_TAG			0x00000050
-#define XGMAC_VLAN_EDVLP		BIT(26)
-#define XGMAC_VLAN_VTHM			BIT(25)
-#define XGMAC_VLAN_DOVLTC		BIT(20)
-#define XGMAC_VLAN_ESVL			BIT(18)
-#define XGMAC_VLAN_ETV			BIT(16)
-#define XGMAC_VLAN_VID			GENMASK(15, 0)
-#define XGMAC_VLAN_HASH_TABLE		0x00000058
-#define XGMAC_VLAN_INCL			0x00000060
-#define XGMAC_VLAN_VLTI			BIT(20)
-#define XGMAC_VLAN_CSVL			BIT(19)
-#define XGMAC_VLAN_VLC			GENMASK(17, 16)
-#define XGMAC_VLAN_VLC_SHIFT		16
 #define XGMAC_RXQ_CTRL0			0x000000a0
 #define XGMAC_RXQEN(x)			GENMASK((x) * 2 + 1, (x) * 2)
 #define XGMAC_RXQEN_SHIFT(x)		((x) * 2)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a6d395c6bacd..d9f41c047e5e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -614,76 +614,6 @@ static int dwxgmac2_rss_configure(struct mac_device_info *hw,
 	return 0;
 }
 
-static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      u16 perfect_match, bool is_double)
-{
-	void __iomem *ioaddr = hw->pcsr;
-
-	writel(hash, ioaddr + XGMAC_VLAN_HASH_TABLE);
-
-	if (hash) {
-		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
-
-		value |= XGMAC_FILTER_VTFE;
-
-		writel(value, ioaddr + XGMAC_PACKET_FILTER);
-
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
-
-		value |= XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV;
-		if (is_double) {
-			value |= XGMAC_VLAN_EDVLP;
-			value |= XGMAC_VLAN_ESVL;
-			value |= XGMAC_VLAN_DOVLTC;
-		} else {
-			value &= ~XGMAC_VLAN_EDVLP;
-			value &= ~XGMAC_VLAN_ESVL;
-			value &= ~XGMAC_VLAN_DOVLTC;
-		}
-
-		value &= ~XGMAC_VLAN_VID;
-		writel(value, ioaddr + XGMAC_VLAN_TAG);
-	} else if (perfect_match) {
-		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
-
-		value |= XGMAC_FILTER_VTFE;
-
-		writel(value, ioaddr + XGMAC_PACKET_FILTER);
-
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
-
-		value &= ~XGMAC_VLAN_VTHM;
-		value |= XGMAC_VLAN_ETV;
-		if (is_double) {
-			value |= XGMAC_VLAN_EDVLP;
-			value |= XGMAC_VLAN_ESVL;
-			value |= XGMAC_VLAN_DOVLTC;
-		} else {
-			value &= ~XGMAC_VLAN_EDVLP;
-			value &= ~XGMAC_VLAN_ESVL;
-			value &= ~XGMAC_VLAN_DOVLTC;
-		}
-
-		value &= ~XGMAC_VLAN_VID;
-		writel(value | perfect_match, ioaddr + XGMAC_VLAN_TAG);
-	} else {
-		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
-
-		value &= ~XGMAC_FILTER_VTFE;
-
-		writel(value, ioaddr + XGMAC_PACKET_FILTER);
-
-		value = readl(ioaddr + XGMAC_VLAN_TAG);
-
-		value &= ~(XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV);
-		value &= ~(XGMAC_VLAN_EDVLP | XGMAC_VLAN_ESVL);
-		value &= ~XGMAC_VLAN_DOVLTC;
-		value &= ~XGMAC_VLAN_VID;
-
-		writel(value, ioaddr + XGMAC_VLAN_TAG);
-	}
-}
-
 struct dwxgmac3_error_desc {
 	bool valid;
 	const char *desc;
@@ -1300,19 +1230,6 @@ static void dwxgmac2_sarc_configure(void __iomem *ioaddr, int val)
 	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
-static void dwxgmac2_enable_vlan(struct mac_device_info *hw, u32 type)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_VLAN_INCL);
-	value |= XGMAC_VLAN_VLTI;
-	value |= XGMAC_VLAN_CSVL; /* Only use SVLAN */
-	value &= ~XGMAC_VLAN_VLC;
-	value |= (type << XGMAC_VLAN_VLC_SHIFT) & XGMAC_VLAN_VLC;
-	writel(value, ioaddr + XGMAC_VLAN_INCL);
-}
-
 static int dwxgmac2_filter_wait(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -1534,12 +1451,10 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.safety_feat_dump = dwxgmac3_safety_feat_dump,
 	.set_mac_loopback = dwxgmac2_set_mac_loopback,
 	.rss_configure = dwxgmac2_rss_configure,
-	.update_vlan_hash = dwxgmac2_update_vlan_hash,
 	.rxp_config = dwxgmac3_rxp_config,
 	.get_mac_tx_timestamp = dwxgmac2_get_mac_tx_timestamp,
 	.flex_pps_config = dwxgmac2_flex_pps_config,
 	.sarc_configure = dwxgmac2_sarc_configure,
-	.enable_vlan = dwxgmac2_enable_vlan,
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
@@ -1590,12 +1505,10 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.safety_feat_dump = dwxgmac3_safety_feat_dump,
 	.set_mac_loopback = dwxgmac2_set_mac_loopback,
 	.rss_configure = dwxgmac2_rss_configure,
-	.update_vlan_hash = dwxgmac2_update_vlan_hash,
 	.rxp_config = dwxgmac3_rxp_config,
 	.get_mac_tx_timestamp = dwxgmac2_get_mac_tx_timestamp,
 	.flex_pps_config = dwxgmac2_flex_pps_config,
 	.sarc_configure = dwxgmac2_sarc_configure,
-	.enable_vlan = dwxgmac2_enable_vlan,
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 31bdbab9a46c..d801cd40b529 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -9,6 +9,7 @@
 #include "stmmac_fpe.h"
 #include "stmmac_ptp.h"
 #include "stmmac_est.h"
+#include "stmmac_vlan.h"
 #include "dwmac4_descs.h"
 #include "dwxgmac2.h"
 
@@ -120,6 +121,7 @@ static const struct stmmac_hwif_entry {
 	const void *tc;
 	const void *mmc;
 	const void *est;
+	const void *vlan;
 	int (*setup)(struct stmmac_priv *priv);
 	int (*quirks)(struct stmmac_priv *priv);
 } stmmac_hw[] = {
@@ -175,6 +177,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac4_ops,
+		.vlan = &dwmac4_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
@@ -197,6 +200,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac410_ops,
+		.vlan = &dwmac410_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
@@ -219,6 +223,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac410_ops,
+		.vlan = &dwmac410_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
@@ -241,6 +246,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac510_ops,
+		.vlan = &dwmac510_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
@@ -264,6 +270,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxgmac210_ops,
+		.vlan = &dwxgmac210_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
@@ -287,6 +294,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwxgmac210_desc_ops,
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxlgmac2_ops,
+		.vlan = &dwxlgmac2_vlan_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
@@ -368,6 +376,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		mac->tc = mac->tc ? : entry->tc;
 		mac->mmc = mac->mmc ? : entry->mmc;
 		mac->est = mac->est ? : entry->est;
+		mac->vlan = mac->vlan ? : entry->vlan;
 
 		priv->hw = mac;
 		priv->fpe_cfg.reg = entry->regs.fpe_reg;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 27c63a9fc163..ae4efffb785f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -398,21 +398,6 @@ struct stmmac_ops {
 	/* RSS */
 	int (*rss_configure)(struct mac_device_info *hw,
 			     struct stmmac_rss *cfg, u32 num_rxq);
-	/* VLAN */
-	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 u16 perfect_match, bool is_double);
-	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
-	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
-			   struct sk_buff *skb);
-	void (*set_hw_vlan_mode)(struct mac_device_info *hw);
-	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
-				   struct mac_device_info *hw,
-				   __be16 proto, u16 vid);
-	int (*del_hw_vlan_rx_fltr)(struct net_device *dev,
-				   struct mac_device_info *hw,
-				   __be16 proto, u16 vid);
-	void (*restore_hw_vlan_rx_fltr)(struct net_device *dev,
-					struct mac_device_info *hw);
 	/* TX Timestamp */
 	int (*get_mac_tx_timestamp)(struct mac_device_info *hw, u64 *ts);
 	/* Source Address Insertion / Replacement */
@@ -498,20 +483,6 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, set_mac_loopback, __args)
 #define stmmac_rss_configure(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, rss_configure, __args)
-#define stmmac_update_vlan_hash(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, update_vlan_hash, __args)
-#define stmmac_enable_vlan(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, enable_vlan, __args)
-#define stmmac_rx_hw_vlan(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, rx_hw_vlan, __args)
-#define stmmac_set_hw_vlan_mode(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, set_hw_vlan_mode, __args)
-#define stmmac_add_hw_vlan_rx_fltr(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, add_hw_vlan_rx_fltr, __args)
-#define stmmac_del_hw_vlan_rx_fltr(__priv, __args...) \
-	stmmac_do_callback(__priv, mac, del_hw_vlan_rx_fltr, __args)
-#define stmmac_restore_hw_vlan_rx_fltr(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, restore_hw_vlan_rx_fltr, __args)
 #define stmmac_get_mac_tx_timestamp(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, get_mac_tx_timestamp, __args)
 #define stmmac_sarc_configure(__priv, __args...) \
@@ -659,6 +630,39 @@ struct stmmac_est_ops {
 #define stmmac_est_irq_status(__priv, __args...) \
 	stmmac_do_void_callback(__priv, est, irq_status, __args)
 
+struct stmmac_vlan_ops {
+	/* VLAN */
+	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
+				 u16 perfect_match, bool is_double);
+	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
+	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
+			   struct sk_buff *skb);
+	void (*set_hw_vlan_mode)(struct mac_device_info *hw);
+	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
+				   struct mac_device_info *hw,
+				   __be16 proto, u16 vid);
+	int (*del_hw_vlan_rx_fltr)(struct net_device *dev,
+				   struct mac_device_info *hw,
+				   __be16 proto, u16 vid);
+	void (*restore_hw_vlan_rx_fltr)(struct net_device *dev,
+					struct mac_device_info *hw);
+};
+
+#define stmmac_update_vlan_hash(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, update_vlan_hash, __args)
+#define stmmac_enable_vlan(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, enable_vlan, __args)
+#define stmmac_rx_hw_vlan(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, rx_hw_vlan, __args)
+#define stmmac_set_hw_vlan_mode(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, set_hw_vlan_mode, __args)
+#define stmmac_add_hw_vlan_rx_fltr(__priv, __args...) \
+	stmmac_do_callback(__priv, vlan, add_hw_vlan_rx_fltr, __args)
+#define stmmac_del_hw_vlan_rx_fltr(__priv, __args...) \
+	stmmac_do_callback(__priv, vlan, del_hw_vlan_rx_fltr, __args)
+#define stmmac_restore_hw_vlan_rx_fltr(__priv, __args...) \
+	stmmac_do_void_callback(__priv, vlan, restore_hw_vlan_rx_fltr, __args)
+
 struct stmmac_regs_off {
 	const struct stmmac_fpe_reg *fpe_reg;
 	u32 ptp_off;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
new file mode 100644
index 000000000000..c84d92174de7
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Altera Corporation
+ * stmmac VLAN (802.1Q) handling
+ */
+
+#include "stmmac.h"
+#include "stmmac_vlan.h"
+
+static void dwmac4_write_single_vlan(struct net_device *dev, u16 vid)
+{
+	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
+	u32 val;
+
+	val = readl(ioaddr + GMAC_VLAN_TAG);
+	val &= ~GMAC_VLAN_TAG_VID;
+	val |= GMAC_VLAN_TAG_ETV | vid;
+
+	writel(val, ioaddr + GMAC_VLAN_TAG);
+}
+
+static int dwmac4_write_vlan_filter(struct net_device *dev,
+				    struct mac_device_info *hw,
+				    u8 index, u32 data)
+{
+	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
+	int ret;
+	u32 val;
+
+	if (index >= hw->num_vlan)
+		return -EINVAL;
+
+	writel(data, ioaddr + GMAC_VLAN_TAG_DATA);
+
+	val = readl(ioaddr + GMAC_VLAN_TAG);
+	val &= ~(GMAC_VLAN_TAG_CTRL_OFS_MASK |
+		GMAC_VLAN_TAG_CTRL_CT |
+		GMAC_VLAN_TAG_CTRL_OB);
+	val |= (index << GMAC_VLAN_TAG_CTRL_OFS_SHIFT) | GMAC_VLAN_TAG_CTRL_OB;
+
+	writel(val, ioaddr + GMAC_VLAN_TAG);
+
+	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
+				 !(val & GMAC_VLAN_TAG_CTRL_OB),
+				 1000, 500000);
+	if (ret) {
+		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
+				      struct mac_device_info *hw,
+				      __be16 proto, u16 vid)
+{
+	int index = -1;
+	u32 val = 0;
+	int i, ret;
+
+	if (vid > 4095)
+		return -EINVAL;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		/* For single VLAN filter, VID 0 means VLAN promiscuous */
+		if (vid == 0) {
+			netdev_warn(dev, "Adding VLAN ID 0 is not supported\n");
+			return -EPERM;
+		}
+
+		if (hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) {
+			netdev_err(dev, "Only single VLAN ID supported\n");
+			return -EPERM;
+		}
+
+		hw->vlan_filter[0] = vid;
+		dwmac4_write_single_vlan(dev, vid);
+
+		return 0;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	val |= GMAC_VLAN_TAG_DATA_ETV | GMAC_VLAN_TAG_DATA_VEN | vid;
+
+	for (i = 0; i < hw->num_vlan; i++) {
+		if (hw->vlan_filter[i] == val)
+			return 0;
+		else if (!(hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN))
+			index = i;
+	}
+
+	if (index == -1) {
+		netdev_err(dev, "MAC_VLAN_Tag_Filter full (size: %0u)\n",
+			   hw->num_vlan);
+		return -EPERM;
+	}
+
+	ret = dwmac4_write_vlan_filter(dev, hw, index, val);
+
+	if (!ret)
+		hw->vlan_filter[index] = val;
+
+	return ret;
+}
+
+static int dwmac4_del_hw_vlan_rx_fltr(struct net_device *dev,
+				      struct mac_device_info *hw,
+				      __be16 proto, u16 vid)
+{
+	int i, ret = 0;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		if ((hw->vlan_filter[0] & GMAC_VLAN_TAG_VID) == vid) {
+			hw->vlan_filter[0] = 0;
+			dwmac4_write_single_vlan(dev, 0);
+		}
+		return 0;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	for (i = 0; i < hw->num_vlan; i++) {
+		if ((hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VID) == vid) {
+			ret = dwmac4_write_vlan_filter(dev, hw, i, 0);
+
+			if (!ret)
+				hw->vlan_filter[i] = 0;
+			else
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+static void dwmac4_restore_hw_vlan_rx_fltr(struct net_device *dev,
+					   struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+	u32 hash;
+	u32 val;
+	int i;
+
+	/* Single Rx VLAN Filter */
+	if (hw->num_vlan == 1) {
+		dwmac4_write_single_vlan(dev, hw->vlan_filter[0]);
+		return;
+	}
+
+	/* Extended Rx VLAN Filter Enable */
+	for (i = 0; i < hw->num_vlan; i++) {
+		if (hw->vlan_filter[i] & GMAC_VLAN_TAG_DATA_VEN) {
+			val = hw->vlan_filter[i];
+			dwmac4_write_vlan_filter(dev, hw, i, val);
+		}
+	}
+
+	hash = readl(ioaddr + GMAC_VLAN_HASH_TABLE);
+	if (hash & GMAC_VLAN_VLHT) {
+		value = readl(ioaddr + GMAC_VLAN_TAG);
+		value |= GMAC_VLAN_VTHM;
+		writel(value, ioaddr + GMAC_VLAN_TAG);
+	}
+}
+
+static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
+				    u16 perfect_match, bool is_double)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	writel(hash, ioaddr + GMAC_VLAN_HASH_TABLE);
+
+	value = readl(ioaddr + GMAC_VLAN_TAG);
+
+	if (hash) {
+		value |= GMAC_VLAN_VTHM | GMAC_VLAN_ETV;
+		if (is_double) {
+			value |= GMAC_VLAN_EDVLP;
+			value |= GMAC_VLAN_ESVL;
+			value |= GMAC_VLAN_DOVLTC;
+		}
+
+		writel(value, ioaddr + GMAC_VLAN_TAG);
+	} else if (perfect_match) {
+		u32 value = GMAC_VLAN_ETV;
+
+		if (is_double) {
+			value |= GMAC_VLAN_EDVLP;
+			value |= GMAC_VLAN_ESVL;
+			value |= GMAC_VLAN_DOVLTC;
+		}
+
+		writel(value | perfect_match, ioaddr + GMAC_VLAN_TAG);
+	} else {
+		value &= ~(GMAC_VLAN_VTHM | GMAC_VLAN_ETV);
+		value &= ~(GMAC_VLAN_EDVLP | GMAC_VLAN_ESVL);
+		value &= ~GMAC_VLAN_DOVLTC;
+		value &= ~GMAC_VLAN_VID;
+
+		writel(value, ioaddr + GMAC_VLAN_TAG);
+	}
+}
+
+static void dwmac4_enable_vlan(struct mac_device_info *hw, u32 type)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	value = readl(ioaddr + GMAC_VLAN_INCL);
+	value |= GMAC_VLAN_VLTI;
+	value |= GMAC_VLAN_CSVL; /* Only use SVLAN */
+	value &= ~GMAC_VLAN_VLC;
+	value |= (type << GMAC_VLAN_VLC_SHIFT) & GMAC_VLAN_VLC;
+	writel(value, ioaddr + GMAC_VLAN_INCL);
+}
+
+static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
+			      struct dma_desc *rx_desc, struct sk_buff *skb)
+{
+	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
+		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
+
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+}
+
+static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value = readl(ioaddr + GMAC_VLAN_TAG);
+
+	value &= ~GMAC_VLAN_TAG_CTRL_EVLS_MASK;
+
+	if (hw->hw_vlan_en)
+		/* Always strip VLAN on Receive */
+		value |= GMAC_VLAN_TAG_STRIP_ALL;
+	else
+		/* Do not strip VLAN on Receive */
+		value |= GMAC_VLAN_TAG_STRIP_NONE;
+
+	/* Enable outer VLAN Tag in Rx DMA descriptor */
+	value |= GMAC_VLAN_TAG_CTRL_EVLRXS;
+	writel(value, ioaddr + GMAC_VLAN_TAG);
+}
+
+static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
+				      u16 perfect_match, bool is_double)
+{
+	void __iomem *ioaddr = hw->pcsr;
+
+	writel(hash, ioaddr + XGMAC_VLAN_HASH_TABLE);
+
+	if (hash) {
+		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
+
+		value |= XGMAC_FILTER_VTFE;
+
+		writel(value, ioaddr + XGMAC_PACKET_FILTER);
+
+		value = readl(ioaddr + XGMAC_VLAN_TAG);
+
+		value |= XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV;
+		if (is_double) {
+			value |= XGMAC_VLAN_EDVLP;
+			value |= XGMAC_VLAN_ESVL;
+			value |= XGMAC_VLAN_DOVLTC;
+		} else {
+			value &= ~XGMAC_VLAN_EDVLP;
+			value &= ~XGMAC_VLAN_ESVL;
+			value &= ~XGMAC_VLAN_DOVLTC;
+		}
+
+		value &= ~XGMAC_VLAN_VID;
+		writel(value, ioaddr + XGMAC_VLAN_TAG);
+	} else if (perfect_match) {
+		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
+
+		value |= XGMAC_FILTER_VTFE;
+
+		writel(value, ioaddr + XGMAC_PACKET_FILTER);
+
+		value = readl(ioaddr + XGMAC_VLAN_TAG);
+
+		value &= ~XGMAC_VLAN_VTHM;
+		value |= XGMAC_VLAN_ETV;
+		if (is_double) {
+			value |= XGMAC_VLAN_EDVLP;
+			value |= XGMAC_VLAN_ESVL;
+			value |= XGMAC_VLAN_DOVLTC;
+		} else {
+			value &= ~XGMAC_VLAN_EDVLP;
+			value &= ~XGMAC_VLAN_ESVL;
+			value &= ~XGMAC_VLAN_DOVLTC;
+		}
+
+		value &= ~XGMAC_VLAN_VID;
+		writel(value | perfect_match, ioaddr + XGMAC_VLAN_TAG);
+	} else {
+		u32 value = readl(ioaddr + XGMAC_PACKET_FILTER);
+
+		value &= ~XGMAC_FILTER_VTFE;
+
+		writel(value, ioaddr + XGMAC_PACKET_FILTER);
+
+		value = readl(ioaddr + XGMAC_VLAN_TAG);
+
+		value &= ~(XGMAC_VLAN_VTHM | XGMAC_VLAN_ETV);
+		value &= ~(XGMAC_VLAN_EDVLP | XGMAC_VLAN_ESVL);
+		value &= ~XGMAC_VLAN_DOVLTC;
+		value &= ~XGMAC_VLAN_VID;
+
+		writel(value, ioaddr + XGMAC_VLAN_TAG);
+	}
+}
+
+static void dwxgmac2_enable_vlan(struct mac_device_info *hw, u32 type)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value;
+
+	value = readl(ioaddr + XGMAC_VLAN_INCL);
+	value |= XGMAC_VLAN_VLTI;
+	value |= XGMAC_VLAN_CSVL; /* Only use SVLAN */
+	value &= ~XGMAC_VLAN_VLC;
+	value |= (type << XGMAC_VLAN_VLC_SHIFT) & XGMAC_VLAN_VLC;
+	writel(value, ioaddr + XGMAC_VLAN_INCL);
+}
+
+const struct stmmac_vlan_ops dwmac4_vlan_ops = {
+	.update_vlan_hash = dwmac4_update_vlan_hash,
+	.enable_vlan = dwmac4_enable_vlan,
+	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
+	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
+	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
+	.rx_hw_vlan = dwmac4_rx_hw_vlan,
+	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
+};
+
+const struct stmmac_vlan_ops dwmac410_vlan_ops = {
+	.update_vlan_hash = dwmac4_update_vlan_hash,
+	.enable_vlan = dwmac4_enable_vlan,
+	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
+	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
+	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
+	.rx_hw_vlan = dwmac4_rx_hw_vlan,
+	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
+};
+
+const struct stmmac_vlan_ops dwmac510_vlan_ops = {
+	.update_vlan_hash = dwmac4_update_vlan_hash,
+	.enable_vlan = dwmac4_enable_vlan,
+	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
+	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
+	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
+	.rx_hw_vlan = dwmac4_rx_hw_vlan,
+	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
+};
+
+const struct stmmac_vlan_ops dwxgmac210_vlan_ops = {
+	.update_vlan_hash = dwxgmac2_update_vlan_hash,
+	.enable_vlan = dwxgmac2_enable_vlan,
+};
+
+const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
+	.update_vlan_hash = dwxgmac2_update_vlan_hash,
+	.enable_vlan = dwxgmac2_enable_vlan,
+};
+
+u32 dwmac4_get_num_vlan(void __iomem *ioaddr)
+{
+	u32 val, num_vlan;
+
+	val = readl(ioaddr + GMAC_HW_FEATURE3);
+	switch (val & GMAC_HW_FEAT_NRVF) {
+	case 0:
+		num_vlan = 1;
+		break;
+	case 1:
+		num_vlan = 4;
+		break;
+	case 2:
+		num_vlan = 8;
+		break;
+	case 3:
+		num_vlan = 16;
+		break;
+	case 4:
+		num_vlan = 24;
+		break;
+	case 5:
+		num_vlan = 32;
+		break;
+	default:
+		num_vlan = 1;
+	}
+
+	return num_vlan;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
new file mode 100644
index 000000000000..c318e58110ce
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025, Altera Corporation
+ * stmmac VLAN(802.1Q) handling
+ */
+
+#ifndef __STMMAC_VLAN_H__
+#define __STMMAC_VLAN_H__
+
+#include <linux/bitfield.h>
+#include "dwmac4.h"
+#include "dwxgmac2.h"
+
+/* DWMAC4 Setting */
+#define GMAC_VLAN_TAG			0x00000050
+#define GMAC_VLAN_TAG_DATA		0x00000054
+#define GMAC_VLAN_HASH_TABLE		0x00000058
+#define GMAC_VLAN_INCL			0x00000060
+
+/* MAC VLAN */
+#define GMAC_VLAN_EDVLP			BIT(26)
+#define GMAC_VLAN_VTHM			BIT(25)
+#define GMAC_VLAN_DOVLTC		BIT(20)
+#define GMAC_VLAN_ESVL			BIT(18)
+#define GMAC_VLAN_ETV			BIT(16)
+#define GMAC_VLAN_VID			GENMASK(15, 0)
+#define GMAC_VLAN_VLTI			BIT(20)
+#define GMAC_VLAN_CSVL			BIT(19)
+#define GMAC_VLAN_VLC			GENMASK(17, 16)
+#define GMAC_VLAN_VLC_SHIFT		16
+#define GMAC_VLAN_VLHT			GENMASK(15, 0)
+
+/* MAC VLAN Tag */
+#define GMAC_VLAN_TAG_VID		GENMASK(15, 0)
+#define GMAC_VLAN_TAG_ETV		BIT(16)
+
+/* MAC VLAN Tag Control */
+#define GMAC_VLAN_TAG_CTRL_OB		BIT(0)
+#define GMAC_VLAN_TAG_CTRL_CT		BIT(1)
+#define GMAC_VLAN_TAG_CTRL_OFS_MASK	GENMASK(6, 2)
+#define GMAC_VLAN_TAG_CTRL_OFS_SHIFT	2
+#define GMAC_VLAN_TAG_CTRL_EVLS_MASK	GENMASK(22, 21)
+#define GMAC_VLAN_TAG_CTRL_EVLS_SHIFT	21
+#define GMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
+
+#define GMAC_VLAN_TAG_STRIP_NONE	(0x0 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define GMAC_VLAN_TAG_STRIP_PASS	(0x1 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define GMAC_VLAN_TAG_STRIP_FAIL	(0x2 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define GMAC_VLAN_TAG_STRIP_ALL		(0x3 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+
+/* MAC VLAN Tag Data/Filter */
+#define GMAC_VLAN_TAG_DATA_VID		GENMASK(15, 0)
+#define GMAC_VLAN_TAG_DATA_VEN		BIT(16)
+#define GMAC_VLAN_TAG_DATA_ETV		BIT(17)
+
+/* DWXGMAC Setting */
+#define XGMAC_VLAN_TAG			0x00000050
+#define XGMAC_VLAN_EDVLP		BIT(26)
+#define XGMAC_VLAN_VTHM			BIT(25)
+#define XGMAC_VLAN_DOVLTC		BIT(20)
+#define XGMAC_VLAN_ESVL			BIT(18)
+#define XGMAC_VLAN_ETV			BIT(16)
+#define XGMAC_VLAN_VID			GENMASK(15, 0)
+#define XGMAC_VLAN_HASH_TABLE		0x00000058
+#define XGMAC_VLAN_INCL			0x00000060
+#define XGMAC_VLAN_VLTI			BIT(20)
+#define XGMAC_VLAN_CSVL			BIT(19)
+#define XGMAC_VLAN_VLC			GENMASK(17, 16)
+#define XGMAC_VLAN_VLC_SHIFT		16
+#define XGMAC_FILTER_VTFE		BIT(16)
+
+extern const struct stmmac_vlan_ops dwmac4_vlan_ops;
+extern const struct stmmac_vlan_ops dwmac410_vlan_ops;
+extern const struct stmmac_vlan_ops dwmac510_vlan_ops;
+extern const struct stmmac_vlan_ops dwxgmac210_vlan_ops;
+extern const struct stmmac_vlan_ops dwxlgmac2_vlan_ops;
+
+u32 dwmac4_get_num_vlan(void __iomem *ioaddr);
+
+#endif /* __STMMAC_VLAN_H__ */
-- 
2.25.1



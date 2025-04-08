Return-Path: <bpf+bounces-55445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B4A7F789
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 10:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37F37A9D7D
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4B2641DF;
	Tue,  8 Apr 2025 08:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="U/PaVQru"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11013045.outbound.protection.outlook.com [52.101.44.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2A2594;
	Tue,  8 Apr 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100174; cv=fail; b=FrcAFXkO89Lgk+7RSd86I9jdu5hChbbME1Yjuk+EQYQuo7c/Ga98Qx2jBiw/8auBzLRlWqmX5KsXhHS8bW0tDPgW+x8rThKlYscthC/XiWCTrLKz5AYChjCLw2cGYC6i8g5YbYHmLjMmjTZCDmJ5g0K64Pk4zlw/6LID4tQAoyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100174; c=relaxed/simple;
	bh=0GUE3wiCmY3gms6UdAsnfhmDeNc/A03tyZ3e9fPCSbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=em9YuHZEjtZpMS9obdLGYtY18/jxbllglNftwbCSm4M9qIUOGAAhy2PZKM0xXcT7QSDlFxsrzY9G60hiL0BqQBgFMP4oLthrJa0YWD2wERW2ddyM4illflo8pSz73EgRduy2AdFj01F7mX7kabeNOj39+hsJGw5tHvWJB2PumjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=U/PaVQru; arc=fail smtp.client-ip=52.101.44.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz/RsX0RAk55dfunrBlkeLbKkLk0erXy0wxd3mM/PBXQh3CvuymiP9v4oUQAmbo2Ha4lnyLdirpH//xTH+fqFoRdRAzj3PoruYSM+28SfJrtPXrP6ohRRXIGs49nA2f0i5y1ykMWWLvvtACUc6smJql64oo5Kq4eLKr/3dvY9UR9ZvoBF7QlCvbt80cju9Tf4Dj+cH7jnjupZnEahBOLc3c2qqLA1USMV89yZVis1+MKVHqOdUMvwgEk7OQrhp5qLaY/u3nEXAfeV0URqwSg3biQPhvFxwlU0gop/g5MeD8RZv/RytMufK/uPXYtdJF0mkMvjSCJ+X08RSZhXbJowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byAT1aBxCoYU8l4jOjhOmS1gPbFxDAbVfnOFvMl3LHk=;
 b=h2QaLMym5oGwOb/ZY3NAH8gjf1sSpfqqe+L12+8EY5WHFzC3Icj/lHE2S36sD8Drc+ougcBGD3pwy1oq8NAB1Gob7iGwK+AdDdAiFEgGHeI6GWiMyWMipx/TuTyWGXfvcVJTQ+n4RMiztcC0HaUZF1uXV8vdglPANZvsxtFzsV5lRKbzajXDeJbLcYYY44I6jRLmo2jpseQpYyL4xSL/qJq3kofhGwq66zykmYgRkH1C1lXKkka+NFsY/eGxr76fvHmDenyIhv+Ox990CGJ0EziSz+MRgBLY77+GzytXWpvbFqXcupWyvXGosxNYr7OJQklO/n6iI331B91u5+foWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byAT1aBxCoYU8l4jOjhOmS1gPbFxDAbVfnOFvMl3LHk=;
 b=U/PaVQruQtFxTwYzoeioDkM1qSSlUGslp4spwI4s2VqcBB7oDB2x1CHyLINBM05/u/FmzZHf/hH2fFXHspBMlalcN6blXHMz9XMHpfAd5Y8kBOrzma0LdUmMUwphCWJdiR0IrbioZAWnrpLAWgZIYZmFjLw+m4svO3TqqGUytTc223QILCkiHJJLRvbe+FrqYGlWie1hwotJGFBoH6d8d45QxTosOymqXxzgMbBjNLtdXlpv2u+eHTamsm5nXy0TFk9wtFfl74gAUKLsblWs+bUbVtWHONA/igqQg204CqRhVBiKGI+rxQPpU1tIGbqm4JLTiYLMaDpVOK8lSlxqbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN8PR03MB5073.namprd03.prod.outlook.com (2603:10b6:408:dc::21)
 by CO1PR03MB5666.namprd03.prod.outlook.com (2603:10b6:303:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Tue, 8 Apr
 2025 08:16:10 +0000
Received: from BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a]) by BN8PR03MB5073.namprd03.prod.outlook.com
 ([fe80::7483:7886:9e3d:f62a%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 08:16:09 +0000
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
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>,
	G Thomas Rohan <rohan.g.thomas@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH net-next v3 2/2] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping
Date: Tue,  8 Apr 2025 16:13:54 +0800
Message-Id: <20250408081354.25881-3-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408081354.25881-1-boon.khai.ng@altera.com>
References: <20250408081354.25881-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::30) To BN8PR03MB5073.namprd03.prod.outlook.com
 (2603:10b6:408:dc::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR03MB5073:EE_|CO1PR03MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ee993b-cf90-48ef-28d6-08dd76759e57
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HYgxfCMuiN7GxnfXr7E20vc/LZfvOUwS4+kokQJVITTufC8lQGH721QIIspb?=
 =?us-ascii?Q?tBztVkQ0qaVQwGK8sjNhNt+6CvwOparreLbxrxdcXEidy9VNSYqKGA9gfqb3?=
 =?us-ascii?Q?g+GZHVqfHPSg5SZh5NA6y2rkIJOccL8QaAYSFO9avUI1wZhWZqVzdvUk1jP3?=
 =?us-ascii?Q?Si/k9uxemNh6LgE/sKCFv1cgGiTwdW9WSnAthF/dZYNZ/y4GCmdMYGwjeFpG?=
 =?us-ascii?Q?RLP/cSfZ8oQeif/P1ERAUgG7zzEh8UsoBHxQfEl3OpwzZtvleAYwiUhDgFT9?=
 =?us-ascii?Q?HEtGTl/l8gSIj8PH32uWbwk3fOEK7ZOoG6gATYy7Q/k6PD4zCRQ/1/3NzqFm?=
 =?us-ascii?Q?nBTlCfq2loarhJX0TJ1PYyZKOGdadqketlE7Clr6MZUiRGATQNolCjoT9jCr?=
 =?us-ascii?Q?iQb5fISr0trIYD9QR1+D7RrUOvkXW/UoH9BgfUQvxyRW6pHj1eUTVy2oj1e7?=
 =?us-ascii?Q?ucilA7vvyxqgty8YHlc8FUe8wQniEGTX9Stp7Sht/WInWRs8HbqZ1kt6j64D?=
 =?us-ascii?Q?mmw+zXtAp4O2q/Pzch5NDY1G4lRfg+ypvtqKfbpTgA5IA8Np6a1DP8zjilCn?=
 =?us-ascii?Q?ToVEi73x52DvJh+a7ElreQe1fmf5yDV5xpwUfXb5n6Z1gtGHplKvFxia5RI5?=
 =?us-ascii?Q?2bhx9Hfk0g+GVFKi25uikkR3gC5c0SAMp3Lpum9qybDoX1t+ZV4hqR9peuda?=
 =?us-ascii?Q?R9hBG2JYQ7VEyKEIEF7X0DK5eeXs45l1eiSgPdr2M6KyUWYWMy4orvRTdXMf?=
 =?us-ascii?Q?211M1bXXMuXSPqYytRbsrsPrmg/CgR+4ddomDPaNZZA4+pZJQhhm0jc8piwf?=
 =?us-ascii?Q?Sa13BFdeSSFiQ15/7v+u0mK7bKbMOgf70b2lWbALYxzA2cdEb6cLUAn4A8Qe?=
 =?us-ascii?Q?56zP4TNPz8HLNNrTocrPRgf7jwDXDhRNqXm1YVv2gMBs9Uaw6Ifhx3xDEZZT?=
 =?us-ascii?Q?rARUwItbmjXILiGDBiWsGW86N4xQXuEDbpOCHXPlFKG+62gnTYkixC6QPuqV?=
 =?us-ascii?Q?7WnW5Uk9YJPWyo3739TKS4RmeDBaUokDVbXJCn/bxbpC13KdLiC/Mosw3BBh?=
 =?us-ascii?Q?aXsYLp3IHxr+uFINGc4PKiz+m/BPZBXVMo3/3alcEytP/7x8um7gSE+pPZfj?=
 =?us-ascii?Q?KS7VQTr8H7PvqdOkegnpfhz3iZaHhLE9JgQ/FNIUQbvQtsQvHX7/MViiB89C?=
 =?us-ascii?Q?MlPT4T357d1KXTMbwbrovlP4PYNMdtwZUFol5QDmCsT2YQN+/o3tLHto35du?=
 =?us-ascii?Q?ZAKptLeoEs/stpw1MIiHPR00/TGavupfPHMi7Jyjms3l6TKh4TDQ+MrYSPim?=
 =?us-ascii?Q?Flb05IPmbKafyhA0unO6uGQdWfUEV3xak6oPQFncxaiU4wYoq2eNCr3+RqmK?=
 =?us-ascii?Q?u3A2aWfbmCW7443+iuBOu9Km851v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB5073.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yEzN/fbh4NnoH8qilKsSWPgohIkBjaEMNQhS2WvwYkYbQb1Xc707lhrlcGY9?=
 =?us-ascii?Q?7u3UlJSETRg19t/KsCecQxkNLr0g6B99QHRGMU1kngeyTCPRhT5gDQHUS85s?=
 =?us-ascii?Q?5CHeAtufdhFCJWyb5jiVqeJn8oAHBK3+mF31lRwMumcxfHFZiS64nc+Egm8X?=
 =?us-ascii?Q?oRwZN22RlKV1WQVqYTYB1LmwpNN+jpc4p6w4/W13sNe9RvMref3stmFWS+Yc?=
 =?us-ascii?Q?oS5XhWL+ijlw6Ri7icF3vTXXoojiUneRLbPPT062j5tXalpKGw57SMdD3CVT?=
 =?us-ascii?Q?OVs5FwLVpSWRn90uNdQJaUIcrU26BE13ECiaC77JrmjMZ9yp4qC+D1pgNo7j?=
 =?us-ascii?Q?zyTZ3ZAdP+Xs9ptZNpvB7V6grhOpVO0WpejYdRl2mnrv4KvpglHwJwHBTI03?=
 =?us-ascii?Q?AjZP4dP8devt8FY5jzaPNRxAz9wKSyjSUBFV3zpL1QQQwap+6Bb4rmDpY0pk?=
 =?us-ascii?Q?e4GBXwexPcnTfveC12wDiTOm2QA8g9+CPKOYEx117soLXyiMq7K5nYw/4Us7?=
 =?us-ascii?Q?m83IjK7E1Okq6EPlpDGldl7WidcVtUV9K/tqqPdI9Fv7aL5OMibXodwPshEs?=
 =?us-ascii?Q?NU2XjJVLsn7DFrr2fl1yePvZ6AjryRzS7EUeCzXCrSgb1jSVa+8IPIcqUD4S?=
 =?us-ascii?Q?3m0aFgLBXJRGA4n6MbQcFal7/FfIhI4fN33U/fYum2y5d0/lMG/3TelC96mU?=
 =?us-ascii?Q?6n2uYuH3N+qrtUHNhHwy0G3vUva8RgbjYfFqIfiwLNVep+VEKh7JGg81RGbk?=
 =?us-ascii?Q?INlsn2aRNCGUvNhDEmMzqGcBLt4O3zJc4fzR1pxgHSunqMVuBAG29V2/8b4P?=
 =?us-ascii?Q?c24mgjK+v0y6QaXUpXd03dF5HkjSLEHiLK5iDVUtjWLgxIXfhvP3Y5v7ce8o?=
 =?us-ascii?Q?akMADjvA7zmrcn/e8OrsiTb3MTmXgPD7WN/GtEi1DlTFRNUhE0u09YVA8pyF?=
 =?us-ascii?Q?9FpelGxZxQgZMKuhfrzeYTui8h+AHyLoanlt1QM9hjtSpUISNk1nMH8Tv29f?=
 =?us-ascii?Q?vDGm7EcD8DLLolIL3AS0yQgIh82dPzgNtx0aP/qxSguRGDjbO7RBJvcjV6rO?=
 =?us-ascii?Q?u7RawwQtem3NJ1zIsHr+GB1C57Uvkt+b1MO2ukgk2al3MuXhyEEkjhn4F0As?=
 =?us-ascii?Q?MK4vHmWHXWlWjC8ALg5UjBIrB0Lz+MRCjwtyRWi7Z1DIAWXnqSQxcb6RfK+p?=
 =?us-ascii?Q?lX8uno0zFZXh+ZNGtMeABDeX5cexdkxq7++V8435NNy0P9j/mV0dqfdKIys+?=
 =?us-ascii?Q?ag5qgo6R2B6diK0FqYIK+CIqZrI/aDg5JLgAybg+HND2yiur8BoqUDlXoo3A?=
 =?us-ascii?Q?JoEVdZIMJ/JIE+X3EEF7ALWArOuPzDkN21W6/sqyFW1BwaEI1vfX9N5Hg2j+?=
 =?us-ascii?Q?OXjHGwzo/xWWIXqBHINhvHTwlKNluUy627TXVkjMbJ6ZpC7SlVE2y5b2JayS?=
 =?us-ascii?Q?m2Okw2ZcEYuhILuUvvlzVHN+JLHp5YuEVYdC6V2b2HuAc9Kq/p5s6SUyZgEJ?=
 =?us-ascii?Q?83Z4V/310jcMEDwY0iZVrdIfTDd+sS23vTe/hbie58DC7fsdEWhg9KMM8M5K?=
 =?us-ascii?Q?0OtGKNr+23fKyIHs2T1LV6/oLDF6bYFak6G4ulUw?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ee993b-cf90-48ef-28d6-08dd76759e57
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB5073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:16:09.8859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hWTmNs+q5trz6GDFqe9Vl+dllUQU/tF8pZaS+r1zCXU/GgOlhuCtVim9CSu8NrUFgqJngndOVHeA9kC/nYJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5666

This patch adds support for MAC level VLAN tag stripping for the
dwxgmac2 IP. This feature can be configured through ethtool.
If the rx-vlan-offload is off, then the VLAN tag will be stripped
by the driver. If the rx-vlan-offload is on then the VLAN tag
will be stripped by the MAC.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h | 12 ++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c   | 18 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 5e369a9a2595..0d408ee17f33 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -464,6 +464,7 @@
 #define XGMAC_RDES3_RSV			BIT(26)
 #define XGMAC_RDES3_L34T		GENMASK(23, 20)
 #define XGMAC_RDES3_L34T_SHIFT		20
+#define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
 #define XGMAC_L34T_IP4TCP		0x1
 #define XGMAC_L34T_IP4UDP		0x2
 #define XGMAC_L34T_IP6TCP		0x9
@@ -473,6 +474,17 @@
 #define XGMAC_RDES3_TSD			BIT(6)
 #define XGMAC_RDES3_TSA			BIT(4)
 
+/* RDES0 (write back format) */
+#define XGMAC_RDES0_VLAN_TAG_MASK	GENMASK(15, 0)
+
+/* Error Type or L2 Type(ET/LT) Field Number */
+#define XGMAC_ET_LT_VLAN_STAG		8
+#define XGMAC_ET_LT_VLAN_CTAG		9
+#define XGMAC_ET_LT_DVLAN_CTAG_CTAG	10
+#define XGMAC_ET_LT_DVLAN_STAG_STAG	11
+#define XGMAC_ET_LT_DVLAN_CTAG_STAG	12
+#define XGMAC_ET_LT_DVLAN_STAG_CTAG	13
+
 extern const struct stmmac_ops dwxgmac210_ops;
 extern const struct stmmac_ops dwxlgmac2_ops;
 extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index d9f41c047e5e..6cadf8de4fdf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -10,6 +10,7 @@
 #include "stmmac.h"
 #include "stmmac_fpe.h"
 #include "stmmac_ptp.h"
+#include "stmmac_vlan.h"
 #include "dwxlgmac2.h"
 #include "dwxgmac2.h"
 
@@ -1551,6 +1552,7 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	mac->mii.reg_mask = GENMASK(15, 0);
 	mac->mii.clk_csr_shift = 19;
 	mac->mii.clk_csr_mask = GENMASK(21, 19);
+	mac->num_vlan = stmmac_get_num_vlan(priv->ioaddr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index 389aad7b5c1e..55921c88efd0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -4,6 +4,7 @@
  * stmmac XGMAC support.
  */
 
+#include <linux/bitfield.h>
 #include <linux/stmmac.h>
 #include "common.h"
 #include "dwxgmac2.h"
@@ -69,6 +70,21 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
 }
 
+static u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
+{
+	return (le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK);
+}
+
+static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)
+{
+	u32 et_lt;
+
+	et_lt = FIELD_GET(XGMAC_RDES3_ET_LT, le32_to_cpu(p->des3));
+
+	return et_lt >= XGMAC_ET_LT_VLAN_STAG &&
+	       et_lt <= XGMAC_ET_LT_DVLAN_STAG_CTAG;
+}
+
 static int dwxgmac2_get_rx_frame_len(struct dma_desc *p, int rx_coe)
 {
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_PL);
@@ -351,6 +367,8 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.set_tx_owner = dwxgmac2_set_tx_owner,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
 	.get_tx_ls = dwxgmac2_get_tx_ls,
+	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
+	.get_rx_vlan_valid = dwxgmac2_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
 	.enable_tx_timestamp = dwxgmac2_enable_tx_timestamp,
 	.get_tx_timestamp_status = dwxgmac2_get_tx_timestamp_status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 279532609707..eb03d6950903 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7644,7 +7644,7 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
-	if (priv->plat->has_gmac4) {
+	if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
 		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
 		priv->hw->hw_vlan_en = true;
 	}
-- 
2.25.1



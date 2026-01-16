Return-Path: <bpf+bounces-79264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D15CD32BB5
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C7EE30A4310
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F023933F1;
	Fri, 16 Jan 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hwG/cEiJ"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DE33554C;
	Fri, 16 Jan 2026 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574056; cv=fail; b=dJfa6zvnJ2ubJbnZNV/+DESjmTSFzhwbKD6yybcBS20Oh97JV6ubfAwMCTmyoc6cWvJ5XBEDjh8WrmRdhV0sCj7TGdarHuiyh2gTLdoqhBDwP+J0A6k6fMCGWvcwgRSXyYqJCpcs1aSeql7f43H1ChBuglEksz79oZkEmSYqdgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574056; c=relaxed/simple;
	bh=JbQWds0E862en74PEyawFYzzWh0EuuiqKbINh6CbTqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E4v0iLDibhqX4Yl1Qhcrw3fzxrjB4c8zDEkb52SVDQgrUNA7EqvEu+ffgLUU6lGa69GCV3xEC9tGtDo+N0xBP4w3/0QJLr2fOWXMOaw2do1eq2s6CfxOXpqHRoe4hSl9Moauk+bwDUJ2HgvmJJU/H89mlYduxkvq1EMaU6/8d9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hwG/cEiJ; arc=fail smtp.client-ip=52.101.72.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ0pKZWNVWu4nI3U800nH8nG9Qw1FncV5266pDwxrnVZ5Ue4F3U7lOGvmwsks3Z2pkMLW198zZRJLRWyt8FJ9OAEDynQBm8WP/YY6I/6uErnojO4JeT5R07Kh/qChsaTPguPA/zG+MvqSNDZnOV5XNK20HPCSX8v4QdysZBSx/O2OhCGFCAGfBw1xnHNjDPwITNl3iLXJth/bbqHUAIg2f571Bipi9NbOUPeWTQ34QgRXHAPJjLRq9tKjoLTInu2m7o0PR82dO5lDFHluL1Q3iLVouLR4lsERcgaj70g9GBnYQjpvX8oW75FeodySSnXNCW5KEhWjT9lEvpaHDecnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9OVw7rjnFsSN/humhxTDaEShgh3l0O2lVt5LZdG/OE=;
 b=Snqm413i6r59DuKwOuiXRwusP0e/V+BbTxSRWEy36uoLTXqlkI/fjMTtPR1mSRXykhFIqZJ3PSkINSMVXuLVxA0g8GNdcnBKYzLCngeyrUj1Ydb6342lI2ptgTm1k1gy5K2Js4+axAPARsNSgtHuWibKwrULgsMU3XQw4D68NrVoja9MThtSnPfgPynZxfdWqQLArIn+PDwG3ugtIBEcJEuaaOZqVBPEsP3OhHMNn1u7ZWEI9OfgX2PScHKaoBMskRelx5uOiHfyOE1WbxdzxaJLTva+Bsb0ILR3+ddYZ24cleP6o5MOXi5c4rYFYi0B6xfh1VjUlTe5fCoCWH1Kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9OVw7rjnFsSN/humhxTDaEShgh3l0O2lVt5LZdG/OE=;
 b=hwG/cEiJwjs84plGpIpRJbmVk5FziU7KMj9eH9xYtWE00U6UZHjhoG1ZAhdcnsiQ75XfmVTMCHTZWhFbCRtRreeclmUt5f0pu56Didl1RF36Oca4Q1XB+bVXjlC4NSBYa/3rq0KtbGYdQeFvUESqq8+n6AO2SF2MiKOAaiVuII2GkVaivmVpQHgQuLdC1RJHS8xTWYW9vRCmoLnSIxUQOKQ7z+L8vVGg9sAvMi+BvoIWUpxCAxPucIEjCAC1HOL3Rxe3MBmfbK2RPmDAfHBKnN1BZJepcz90X5sz57g2P/ccumcxRnQorM1peI27Z6FitNQetywoL9D+HZlIQBFBBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:34:12 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:34:12 +0000
Date: Fri, 16 Jan 2026 09:34:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 11/14] net: fec: move xdp_rxq_info* APIs out
 of fec_enet_create_page_pool()
Message-ID: <aWpMW+jgIJpqH8NE@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-12-wei.fang@nxp.com>
X-ClientProxiedBy: PH7PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:510:325::18) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: c51c56ac-f902-4978-74d4-08de550c50e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcbP4Cl8x/0a+evsU6IL4gH8lE+2sDWJgTTNnwmRl9Mo/e9qLM1jnl3l9Faj?=
 =?us-ascii?Q?/tX3xMbxG0ncygWxkFq8kYy9SiEH5+/fguCEGvy7DRATKl76svg9Q/8gUe8g?=
 =?us-ascii?Q?ZTw6a5kPUD+53rQKPHwEcWCn73Wf75sfEqltW189Qdqk/skxYInoHcNy/T2A?=
 =?us-ascii?Q?WcT7ER51uMUUfHGSuzLaaCUd0tyj3ykriPhg95JhCRP/3Wn6J0RsBh66qgbP?=
 =?us-ascii?Q?VGYUyMe4hPf/6kTXoANm0fFj9SpbBK96H/R1IZpu6/83OqKlD0zhgvrwi2/E?=
 =?us-ascii?Q?xIAnnvk41w7tc5+CcVu/P3lTPPIUqQR+gGR1vn1eFHdXX06aBsmH5nOZ29a7?=
 =?us-ascii?Q?E+2V1YA6RAloxxh5omcmQny5iI/sk2Kt3nzxVX+k+6HWvYxN7UPkMcojOTe3?=
 =?us-ascii?Q?daSGzIHCe5ZlhjkDIg5ImUmZs06hrIiVdM+u1RkXIy8c2dqAbKCQx9PHNfwH?=
 =?us-ascii?Q?12Qb6ExNZnoxmlv5+YbTb3QXmX7diJ2jjdWx4lBKha316GjoO4cWuVQVGM+t?=
 =?us-ascii?Q?gUUUXRMbzq1/8O0omsmJOEZyktifIr+VBMY/UDT5MGZG8qDpGD6JZNGQYFag?=
 =?us-ascii?Q?KOWj1idEDNe1M44S8PppQCzhosb6wl0ivNRqqBlkMJj1XWR5GRHPdxi4N4VI?=
 =?us-ascii?Q?26ViOapWoe9mkwp4zeCnFyNcQzDbl/TPf9QGD7Dpx26UK0S75V0G80xo977v?=
 =?us-ascii?Q?3ubSN0orF/o2BSAuYpps4tSqsiTXmmey7AAO4vfNDKhtvLpOnTNQYcS+Asew?=
 =?us-ascii?Q?Wz6sz5q0ar2Ph/irBIRdCoStmzzV/FhrtN6WgZrdfW7DWi0PcIo+P53g0j5b?=
 =?us-ascii?Q?kBDITwqFnsf/xbim5UkUr1Y/Kg91r2kk9Y97dWNhc+ZHiUzGdnHEYXCX/Q/g?=
 =?us-ascii?Q?UV8VMuFp1f7i3C7Yh+ZoAXVNcZsK7tjB/DMB6IevsHfIwmR+6+Dl3QfjNFvU?=
 =?us-ascii?Q?c1uF/vY1PS+EFoIOmsmWYz+W7ln88UFr4G6xGli148Mnjtf5/AbdllXHZiDZ?=
 =?us-ascii?Q?xWkgtnCcQEsBFzwI9OwtoBWvb6l/rM2eIPjHpxCGroGjf/5AVtM7v5o+Ch0x?=
 =?us-ascii?Q?wKp2DuEv1s4P8OwbzCYIcdMGuB8PeLXPyKNC7B4fOVYzaT76cshZPQFYRJ+V?=
 =?us-ascii?Q?AmpVLALdVeuXV1nWIRhSl/xiEEMDbSW+0kd26qzcx+P0Hke1irU7+Kpgs6gl?=
 =?us-ascii?Q?XXZjKHuq8NPkMlogc0mY/X7wLaLnR6whuyNZDtJb/pNVH1ZBTDRoTSwz5EtN?=
 =?us-ascii?Q?Ol0sR2FGjUPBenyklJluotIsORVjDwr+n239JkQDlWxeO21m6w0r4Bp6CmXu?=
 =?us-ascii?Q?orkc9AFvhGX5w0648ili4/6QBoDLjN881iJirAnC9yhRm2rNV0BesmvzYmhJ?=
 =?us-ascii?Q?JnqllYCA3iWfN3jW5yNGGjhFi5xirgajMc4AyB9tvGlibVt9UG7/SPeCRAzt?=
 =?us-ascii?Q?AXZbdnBB0rj6mqRFply0M+hG5MWD9B316DwrebBML9dLSY/OuBkDfu+nJqmO?=
 =?us-ascii?Q?L093e0NXWG95DFhBk/n063l+59a+UDc2p2ezpND7mNe19MtuJPSVEKSerYzG?=
 =?us-ascii?Q?BeTTc32rjxno8f2uF0+omtFzcdut4JKhJrdAHz6IJJMX/ATkfDoG4O7ChRef?=
 =?us-ascii?Q?QPECsWQI6zZs2dROe+OvSB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kUk2Cr2Rv6l7Vcn2RSeTZ/WG9Xly6ghGdZ46n/+/z3W4EDO1L7xD9jcV3GF6?=
 =?us-ascii?Q?trCb41TkHB8bsqo4uVUcBL8/djOYNpW9eboXupjuRuxr1qqJ9GEohSh2GLRB?=
 =?us-ascii?Q?9OcteN73srM8OcB+/Sfy1DSU8pw1z2re9VLEFs1G0IVcZ1BUoLEO9NuTZdGI?=
 =?us-ascii?Q?9P2178CLLoaE4uV1IEGkzFtyeOt5xchBjbpln/PVWQ0dVs55uYPVCrCkret5?=
 =?us-ascii?Q?CS4bWMsmz+vw+oxxacTNu56NZvOttsAbFCome9vFXH2+WxKxQcYJfmxUZubP?=
 =?us-ascii?Q?tGwaSparhwofRPSARk6sM5geKkzhmFPHc0p4jSVKTGQjuD8TAx3jutCtz77s?=
 =?us-ascii?Q?Cr+MZNLuBkZxIBk+gqagw79OIWGj3NDjSiU9KicwJ+iT85laBEI6i/iRv522?=
 =?us-ascii?Q?IjNTO0JKNDXBZ/IRYmInTd100k5buM0KnyeUqC5vy0G5XIkXBDs1PtRP+L1k?=
 =?us-ascii?Q?6VmOpbFFkmqmtC88FGE6jmLFUzxAICPV/lWoNm1uniR8OxN0sM4edBC1iNLT?=
 =?us-ascii?Q?P2rSmr3MaGh73gpmV/SB37k8G6zQaDj4LyLNatNcYydaWGTZZZk+A/ZqaghJ?=
 =?us-ascii?Q?krQvUj8YndJrsVHbmNp2n6CrYEVQJa18iVAqZNUGrskGWV6K8XYlXpaYGlHk?=
 =?us-ascii?Q?PTFOo1YqeTWYGOiVnEmSQzaVJuefnT+qGWyLXD+ZfU/phuXbyIxFytV2hNsw?=
 =?us-ascii?Q?KpsGfCr+S/kvu4L2hNOKsEihxnsschA8gZAGhiM3Lz7XxwOWeGpB7CyuqaFt?=
 =?us-ascii?Q?GnZ6o4aSAuzldifr3Q0235BN6N1NqAKnN1TfX4V3UjSgNOVmfPH1U048G6Mk?=
 =?us-ascii?Q?TfGORlrpkXlW0MvT/w7JC+QHiuFt+iav3P3FjLlAkZh9vwngKHBtkzmaVDOW?=
 =?us-ascii?Q?Y/CJMhQr4K3yLMJJIsHPpakkG1DgXaj6hNCQ1FxpGN4afVqbqknjtx662eLS?=
 =?us-ascii?Q?PH2fa77suyTe3c3o+fh7up9krTrKKxzCwho+Cgm3A5ltkj1NpFfMzMuUPqlF?=
 =?us-ascii?Q?cYaANBDG3Wcq4f98ObqAQULf4jcS7xl1zhyoEwUG6ZXYn7WOMxv5pdPLqd8p?=
 =?us-ascii?Q?dVGH+2+P2WiZmc4EVAMZy/ywp5+sFArjDSSOvM8ycsmda3E3Fuimqhs0zS5b?=
 =?us-ascii?Q?uaVfgFe2eUZooKlTdMhEn3uzc3AFeU4O7U5ey3is40VAGFzaGn/8EkkuEp/V?=
 =?us-ascii?Q?Jsn2zuE0hF9VaEkQwi2hCZzyFKOHUGAHoqw5ARK9a5mfnxaBZodU09bbsw6x?=
 =?us-ascii?Q?Tv5fh+xzP25osOu/B5Cr1xZwihiPt2dhmymEvPzi1L0aKJ0Rc2F5Y7XIyDII?=
 =?us-ascii?Q?ejbkDog2S0mqvRVnq5jp9HznhmtisrkKSXIcZs6Lbd2GmRfKMokPBG//da1V?=
 =?us-ascii?Q?yqwso8G8uDnoRjstYr61to0kzqYSqMLetpkw8PfbCELiatDzcill/vMPNUtu?=
 =?us-ascii?Q?roCRXh2vLw17KwCbYo+F+2GoQy6BaGMX05U1ylfpWFonvzeJeaRYD/pe5dwu?=
 =?us-ascii?Q?RNJd1Vx/pvBoqd+9qp9NMglbQXfYf/mnfNqb+UHbtaNTOpqQttDHvKoF6Gw/?=
 =?us-ascii?Q?gsuTtdjS96MokB0Bg2SGBxt0rEoFUD2FG4YyTCv38C3RnbJLf42dfqY0DJPd?=
 =?us-ascii?Q?i7EM99mfyDAGT2eWrEas61jWp9DZZ/LuecMJh5pSlqdEheXuqS5PNOac7zPY?=
 =?us-ascii?Q?kU778+HKhYMYKGqFKUrpyfaG8DEhb29Fs7Qymq9ubeZUhThSzeLS04neCm9s?=
 =?us-ascii?Q?i+EcyklDHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51c56ac-f902-4978-74d4-08de550c50e6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:34:11.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukNeGA5gmLv4I7DWG5d7KXLZQD+J/uYUOlveiAe/CXxtUeI09h61iA1bIwenwbSGTEXLI27DAH+055XeMx3YIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749

On Fri, Jan 16, 2026 at 03:40:24PM +0800, Wei Fang wrote:
> Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and move
> it out of fec_enet_create_page_pool(), so that it can be reused in the
> subsequent patches to support XDP zero copy mode.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
>  1 file changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index c1786ccf0443..a418f0153d43 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -489,23 +489,7 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
>  		return err;
>  	}
>
> -	err = xdp_rxq_info_reg(&rxq->xdp_rxq, fep->netdev, rxq->id, 0);
> -	if (err < 0)
> -		goto err_free_pp;
> -
> -	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
> -					 rxq->page_pool);
> -	if (err)
> -		goto err_unregister_rxq;
> -
>  	return 0;
> -
> -err_unregister_rxq:
> -	xdp_rxq_info_unreg(&rxq->xdp_rxq);
> -err_free_pp:
> -	page_pool_destroy(rxq->page_pool);
> -	rxq->page_pool = NULL;
> -	return err;

Noramlly this patch should put helper fec_xdp_rxq_info_reg() before
fec_enet_create_page_pool(). then call fec_xdp_rxq_info_reg() here.

>  }
>
>  static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
> @@ -3419,6 +3403,38 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
>  	.self_test		= net_selftest,
>  };
>
> +static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
> +				struct fec_enet_priv_rx_q *rxq)
> +{
> +	struct net_device *ndev = fep->netdev;
> +	int err;
> +
> +	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
> +	if (err) {
> +		netdev_err(ndev, "Failed to register xdp rxq info\n");
> +		return err;
> +	}
> +
> +	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
> +					 rxq->page_pool);
> +	if (err) {
> +		netdev_err(ndev, "Failed to register XDP mem model\n");
> +		xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
> +{
> +	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq)) {
> +		xdp_rxq_info_unreg_mem_model(&rxq->xdp_rxq);
> +		xdp_rxq_info_unreg(&rxq->xdp_rxq);
> +	}
> +}
> +
>  static void fec_enet_free_buffers(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> @@ -3430,6 +3446,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>
>  	for (q = 0; q < fep->num_rx_queues; q++) {
>  		rxq = fep->rx_queue[q];
> +
> +		fec_xdp_rxq_info_unreg(rxq);
> +
>  		for (i = 0; i < rxq->bd.ring_size; i++)
>  			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
>  						false);
> @@ -3437,8 +3456,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>  		for (i = 0; i < XDP_STATS_TOTAL; i++)
>  			rxq->stats[i] = 0;
>
> -		if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
> -			xdp_rxq_info_unreg(&rxq->xdp_rxq);

why put fec_xdp_rxq_info_unreg() here to do exactly replacement.

Frank
>  		page_pool_destroy(rxq->page_pool);
>  		rxq->page_pool = NULL;
>  	}
> @@ -3593,6 +3610,11 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>  	/* Set the last buffer to wrap. */
>  	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
>  	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
> +
> +	err = fec_xdp_rxq_info_reg(fep, rxq);
> +	if (err)
> +		goto err_alloc;
> +
>  	return 0;
>
>   err_alloc:
> --
> 2.34.1
>


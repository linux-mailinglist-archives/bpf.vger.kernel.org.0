Return-Path: <bpf+bounces-79253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25CD3258A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA58F314B632
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A429CB57;
	Fri, 16 Jan 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AHBGYvxW"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FF29D289;
	Fri, 16 Jan 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572224; cv=fail; b=e60Hppfc6rus5pg/duHKGwuK0LCnSAbfeNc8MRPbMW6i0lM+pvFkfKhCR5i+X3DQA0v/NWWF8lekFB97kNZRUsGOITXHf/WgSSErb8r7rTP2/X9N7rpGbabtKdm2jg+X4wR1Io9RtDCMS+KdufvtfM5WmhmCBeq+tY2YVOamToE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572224; c=relaxed/simple;
	bh=AKP0LURNnuj6CHSHiJ26DePl7bXoOFNkERu2FpWWcOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nm0bgEdCFNoD2zqdA8ARSB2pnkOFZvdGwueHn7mcuHkXO4oHBwu4fIBuYPfestgBEOqmmWKuWKvMOewZpW20HdrMrZn+hddGv3OLoViuUGAmV2M9yBQLwiKLgxp/fI64ri4sXc7BkJRBmd4oAdjDD0ENnWOrxtl8HbUaGFh90j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AHBGYvxW; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px7HFMaB1jKbOwbOCRXf+sshjTgOQ7f+eCJ/NiLRs2cpZvBviRBA6LwYZQ0Yj/4ErwILcq1I579L0X+L91cqU9ym7+SwcMc+AYOhIWtaAsYPI8iZ6V20492APDmM0UgBC8pC9qHN4hKSd5BIb+9DuN7IfAM0/Jp9JQbRqEpsZQRc/U5jURWQXEhMOcDYfmxUOIvTpNtD0BL+xdu/GSQ6arJbbFs+2W9884nfKORHLQtmdD3m5a+8yepvWWFXgP9fkhLbYYJW92k52qOHDo/LppUBzQNSCo4HedckxAopCOSLrG3WcbXE+ks+y4nHptz//TTkp9y6VYeIF+lZkAF4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZdZ7Dnbo60mTcTnJyey6hVkyf15Fvp0UfLaB17AoBA=;
 b=y5ZzKb8/M4ObWcXyItfXwvKTyC2yWpIVZelBDHRAjjVU0zoKXa38Qnp6Jndw65jPqKEWfuu3TlgmQbtl0G4iowr0JbvoszwRIF8F13i2h7cr175MBSvThCCMtH924eEJbWzHNgLBBZmWqE74Gredemr9/BF6kSXR4ZLIIx+NA0Tp9q3lfGifQ05e/ZEn3nggodoOyY6wrd6rIoxUUAAdJFZuojMPigbXi3jsAtx1uvgGysdAe6oHtGJht5zITKwGAFsbhQXLaZ8t97UkESvY8m/3OrGfTCtzM1+waKdEcnnp0cGBSCwIsU0V53hsb53P0kZY8fJiDDKtqY5QzQn+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZdZ7Dnbo60mTcTnJyey6hVkyf15Fvp0UfLaB17AoBA=;
 b=AHBGYvxW0YsRxosKmILKHFLQ2vRUu4ZVZ0/fg1ryMWqFBvA650h9W+bxsraFxe6AaVcOjH8kwLefcZZyDNGHaM5FaGk3Xvy7l2rTOqXUabGmRRZrtlBnAVmBrbjGAL6Gm8Bb0R6yzhjW4a109QKS4mMbomFEkXWnTbGefZBF1qrrqMKwCYz713uKCtxkKma3N1s93Bc3nPNN7n1A/0lJqidm9ONtw2VsjbMgy9WFhr4LQceM3tlzfkVX7f8lniB1xSW5ZZy//fp5DjKx+1NbOv1nnHWOHDpgozgMEiLS7pcGkvVx+3EKXD84Z//CdhTw4UpJWlAyGmnWXDDk8D30Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI0PR04MB10758.eurprd04.prod.outlook.com (2603:10a6:800:25c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 14:03:34 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 14:03:34 +0000
Date: Fri, 16 Jan 2026 09:03:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 net-next 05/14] net: fec: improve fec_enet_rx_queue()
Message-ID: <aWpFLnaKDPU5ThFn@lizhi-Precision-Tower-5810>
References: <20260116074027.1603841-1-wei.fang@nxp.com>
 <20260116074027.1603841-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074027.1603841-6-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI0PR04MB10758:EE_
X-MS-Office365-Filtering-Correlation-Id: ade77f8b-e191-4cea-ae1f-08de5508098a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sw/AdsCLB72lFRZkwFB+7YL2gbmbnEPEEYmixL23mowW5N+AHe8eEDJa6ymY?=
 =?us-ascii?Q?0e7OKND21C2Kg5LVBgGnV/3BmO5toa5tODvnZjO44LxBUMxCeL6OGZzsLpd+?=
 =?us-ascii?Q?qs/CDwUdWxg3/qHkkq711SNQ8T+1GyfaWuFngtiGunDJ4zNOHA+8vYPd4szI?=
 =?us-ascii?Q?09mUVagnkVjA5RwSf2wL+92WPM0IoOJAE3tRCEpIGK9YmPMOFHgAw9bw0+Kq?=
 =?us-ascii?Q?L+r3/5SqWeiFYCHpV0UHNuneQO1Z8aGuBGG4j/whnt1mE1iy08rrS9wxQolT?=
 =?us-ascii?Q?nkMtEPiUiFZP01DFptF/MEQimef3CHikJLdJIzUtVca3GdtVe45KHgF8/JNO?=
 =?us-ascii?Q?3+F3j5xL7iv8Qxlm0iAfegwjLHyUW1Hm39icMF9eJhEZ3cJX6hPPaiIq02QS?=
 =?us-ascii?Q?rjnsorTBhT2W10mNXBjRfD6zqJ9Cw2wLOZVleMFodPHkISfFG5TUx7ssHXEz?=
 =?us-ascii?Q?m3Kj5zOujyXs7XP8Pf9tqYoKEfr1GrEbrKmyCeawepasWTGfq4+ifnQR0wTL?=
 =?us-ascii?Q?1n1/GSFwVRRybzU/j6xTYjX9iGiWhnJ2x4/pGYUamn5/6ZkhabV1Msc4Qj/p?=
 =?us-ascii?Q?rN0TQL3IBCbdcROuWFCmX7Bq/mndsEv/cAWpmIMtjzb5Bbq8tTE6T4+yQo//?=
 =?us-ascii?Q?deN3UMHL5m6cqSvpekLxKsVO1z1ftewLPOgFhCrRvRLWaUH60YdKnhj9KZMS?=
 =?us-ascii?Q?w4Q3kA7beTS89uGLxwAOdSqi2ul8VgJDhRZ6bB5e+FB8C+5Rs5/sBtLm8Y5b?=
 =?us-ascii?Q?JsMf96lK3L/Qkcf/0Hp3Vnlu3cipbkaB4CLwvsEd4lZ17hXwoBbnHvabJZ8I?=
 =?us-ascii?Q?Ol1z3s0rwh65ZPc4ee6Yykuet/F+ycvYqwetyZwbilUylMHB1kGlAiYVLLqE?=
 =?us-ascii?Q?9+K3W2Pd2FNNWLEGEEINnCYgZgle4PAQF582K9F0AzHC3iaPyw1tHGNqo38i?=
 =?us-ascii?Q?0THIeaRPXEtpksWyRWTVylbjM08m9HZpHWyHMBydAtmoNC/zZ0VPcT1AS0ZL?=
 =?us-ascii?Q?0rhcuY824tGMNJmyiQGfYNS8CEjOZvHztUo3zp8ldviVO2C6a2VVg5hciRp4?=
 =?us-ascii?Q?vhvihOaa1uYVX97fMhVyXTZormGkFkOC9Xd/ZPdDYLynuv2Vo3106Myx9oMZ?=
 =?us-ascii?Q?WTeyEx1Z49YbM0URYQAQwQcmRGpq9pLluVe7JOnqltR4no0iGdN9WD6eLqvY?=
 =?us-ascii?Q?yHaI0XYRwb9x6ta1hdk3SlKFGceCqFtug2NismJZbOQ9j+IzuLu2XzWiaoqq?=
 =?us-ascii?Q?JiwGUiZztW44THTjA6C3hZzt1ELUIpMcFa8yM0UNjEkvBm2H8jcZJmYTa6TC?=
 =?us-ascii?Q?NAQxgFQ6LrYx2S5w6O2eEGp/2xEOrT/SEyC415S6KFV9+n8Q1POe6TUr2LQH?=
 =?us-ascii?Q?8/ABEvR2RV3YvcQDTyJzj5N/pjq3atmsSKU71DAmktt3xCQ2NsYyKwd/4FqW?=
 =?us-ascii?Q?4pJJEQgCWtypOAWEm1EFp458bKqXnTQYtGSDFBCdKUT7TNSOMBtCFbHrF/A2?=
 =?us-ascii?Q?u/DjPL3dUhsRwNsFqaJ1vvJthX9YMsVFUzDmm159amXc3eiHNqNPew08kZb3?=
 =?us-ascii?Q?aGSSwn9WW/2PnVtA1MDu+Y68/fSYL2F1DuGJPCkSl3ECdsbgpvanDzYkyvAc?=
 =?us-ascii?Q?ewpR/BlokEpXzjrrsbu9xQM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1No8W2zA36a7R4oxmS1TM/8e3B3QPwnzOsVyLfygHnyt7T2zKiStDvqZFihd?=
 =?us-ascii?Q?i8EYJ8m2tzfvm610Kpft4eIu5hOjluKf/54YocEAppeCd8PJR7DGeY1ZefWF?=
 =?us-ascii?Q?vUZPqznfjJXqjVDItkOVLNMOp2bUDGo/ZINQcejfXlgAew4DoXIDNkzlFoLO?=
 =?us-ascii?Q?Rm3rsNKp3W6rpz3VALbGh+tcBCPHFwUWbqN4SVD79ylpIdVbwkYr2RA00WQh?=
 =?us-ascii?Q?zsS1yMKyYQvu5IOFW0OCUcBZlucxjbbZPh4n+lmG0sSG3JDaj2gabB/xsaGH?=
 =?us-ascii?Q?PihxF+BYX9xrBf4xM96UpIXej93DkfnCkPQBDEzULI2t+8unSUx17ODaQ+DZ?=
 =?us-ascii?Q?PDOB2FDTupNnBE49h2cFiUZeTTH+AuglkDNqf8nNfmgmP8pgnwLbvGY6v50T?=
 =?us-ascii?Q?756vKPcmL3Vr+uibU9KQvlSytvlZoN1c0DgRcVabR8Pun3++gkNwLwJx74py?=
 =?us-ascii?Q?cl//yTI3dWC0NcQ3MEnHHH0MXp+c5Mhkq0FfMaZsKgykcNqbhuC6H7Ae6NgI?=
 =?us-ascii?Q?o8hW0+miIGkG0k275WErz/aFFvFaiNrI82/Z1Q8sJBChWRxMsULQL7xVI/0p?=
 =?us-ascii?Q?ofZE+6k+58SXOeMn/Ei0nw+oVQMiRNQHdJkjv/vxBthkicCERCYctETPrzIU?=
 =?us-ascii?Q?TLXMuYuGTtCzn5XhP0agyE7ps0zISIvGU2bsbkb0rho4qT3YScfno3BwqbJ2?=
 =?us-ascii?Q?zStpRa3un5VVYjdyEtwqGQHW2klO76rxDFmATV/v3lJVOMHtf3XiRjp7JVKf?=
 =?us-ascii?Q?ajM8pNub/jtqOTzg1L5/Lz/1xPS2dMcx1YlddqvFdAsT7eL3xwoEuiOO3fwM?=
 =?us-ascii?Q?glDYUH/A0BQWQ2pLpwzGVMZ3wSt3rgzOexsk8VjhQ7GfOzdz9lrrz4az0IVn?=
 =?us-ascii?Q?f38J//c5CL0eELgYv3SSTNAhCqPg9dAS7EhRIA6AJN8W0Dv3madP1wQ8rrF4?=
 =?us-ascii?Q?cQ5HSqbkkOPwbGtNBA2mGgfyYq1CFG8Xivo5BmN20xt17Oq2n7B7+znkWAN5?=
 =?us-ascii?Q?NquuT5TNUOknWmshVUNis8HIaWVHdMyG0mjKFz+e7NxqefTdR6yYqGqgj93W?=
 =?us-ascii?Q?ZH2XzUAh4JKEWPwdmzua5TjfVITl2dd+sdG1kYMMlA5ROrQk+THNEgfhKeoi?=
 =?us-ascii?Q?iu5Ulm+laA5nSr24xtRzPUOrAzlVSLNQ0izWGG5zDp8Vr0Kgehm3U4ONWOpW?=
 =?us-ascii?Q?rzkx7dTQwyidS4b9npBEqElBtJPU3Ql3qVWxI5QsxAtYkEmwjpSCk1b5GZUs?=
 =?us-ascii?Q?qv83fQ6bg+OmuzqMxj/X2VdjJK4sWRTnAJ9qYPXU/p3VZClbVPXvSEW/HWMg?=
 =?us-ascii?Q?oZwyZW2ArmyHAu+cKXOv0uPWl8Tv1pnIXDlA7voK7n3w/aVQ7B7M7qzvpx3U?=
 =?us-ascii?Q?p/ZBdJ8PBXcTqr1J/1whXbnsB8uasMFSjKFtOJnxYh+6QPmoafDBacPWlwzD?=
 =?us-ascii?Q?gD9WpSkBo0rU3r40Q5itLsi1otmlEGbesyNB9q9tf7NFaYvKigBsZqVkTcAm?=
 =?us-ascii?Q?WQY4iRzde6uBdIRfcBMMa/bB/KgG/AkIx+sc4YZyf56AdYoPOiijGet9kjRm?=
 =?us-ascii?Q?Smnu2OzhIHrVPiea+ziuvsS90aQkfF3tbCFbPFbvbSPxvAGjuEloc54iFLrf?=
 =?us-ascii?Q?N2tzY7xYXgcSzaoSdsnXIkd7Ktd6/gjXDWYaYlWpPjMOk1jksxIJzRxaZJ++?=
 =?us-ascii?Q?kxVX7EHEbdxAUGN0vKmgtQAJ7MKGg70ofRallAHoqea7JUHM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade77f8b-e191-4cea-ae1f-08de5508098a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:03:34.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4amoeEC2KZ6/KkJZaVFy/MahniiIOo9BGPPlzTW4ijUwQubtONTnFmvspu3gkSPW9R+SUSCPZXO3FQXpeczrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10758

On Fri, Jan 16, 2026 at 03:40:18PM +0800, Wei Fang wrote:
> This patch has made the following adjustments to fec_enet_rx_queue().
>
> 1. The function parameters are modified to maintain the same style as
> subsequently added XDP-related interfaces.
>
> 2. Some variables are initialized at the time of declaration, and the
> order of local variables is updated to follow the reverse xmas tree
> style.
>
> 3. Replace variable cbd_bufaddr with dma.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/fec_main.c | 35 ++++++++++-------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 7e8ac9d2a5ff..0529dc91c981 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1839,26 +1839,25 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
>   * not been given to the system, we just set the empty indicator,
>   * effectively tossing the packet.
>   */
> -static int
> -fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
> +static int fec_enet_rx_queue(struct fec_enet_private *fep,
> +			     u16 queue, int budget)
>  {
> -	struct fec_enet_private *fep = netdev_priv(ndev);
> -	struct fec_enet_priv_rx_q *rxq;
> -	struct bufdesc *bdp;
> -	unsigned short status;
> -	struct  sk_buff *skb;
> -	ushort	pkt_len;
> -	int	pkt_received = 0;
> -	int	index = 0;
> -	bool	need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
>  	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
> +	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
>  	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
> +	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
>  	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
> +	struct net_device *ndev = fep->netdev;
> +	struct bufdesc *bdp = rxq->bd.cur;
>  	u32 sub_len = 4 + fep->rx_shift;
>  	int cpu = smp_processor_id();
> +	int pkt_received = 0;
> +	u16 status, pkt_len;
> +	struct sk_buff *skb;
>  	struct xdp_buff xdp;
>  	struct page *page;
> -	__fec32 cbd_bufaddr;
> +	dma_addr_t dma;
> +	int index;
>
>  #if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
>  	/*
> @@ -1867,12 +1866,10 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  	 */
>  	flush_cache_all();
>  #endif
> -	rxq = fep->rx_queue[queue_id];
>
>  	/* First, grab all of the stats for the incoming packet.
>  	 * These get messed up if we get called due to a busy condition.
>  	 */
> -	bdp = rxq->bd.cur;
>  	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
>
>  	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
> @@ -1881,7 +1878,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  			break;
>  		pkt_received++;
>
> -		writel(FEC_ENET_RXF_GET(queue_id), fep->hwp + FEC_IEVENT);
> +		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
>
>  		/* Check for errors. */
>  		status ^= BD_ENET_RX_LAST;
> @@ -1895,15 +1892,13 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>
>  		index = fec_enet_get_bd_index(bdp, &rxq->bd);
>  		page = rxq->rx_buf[index];
> -		cbd_bufaddr = bdp->cbd_bufaddr;
> +		dma = fec32_to_cpu(bdp->cbd_bufaddr);
>  		if (fec_enet_update_cbd(rxq, bdp, index)) {
>  			ndev->stats.rx_dropped++;
>  			goto rx_processing_done;
>  		}
>
> -		dma_sync_single_for_cpu(&fep->pdev->dev,
> -					fec32_to_cpu(cbd_bufaddr),
> -					pkt_len,
> +		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
>  					DMA_FROM_DEVICE);
>  		prefetch(page_address(page));
>
> @@ -1979,7 +1974,7 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
>
>  	/* Make sure that AVB queues are processed first. */
>  	for (i = fep->num_rx_queues - 1; i >= 0; i--)
> -		done += fec_enet_rx_queue(ndev, i, budget - done);
> +		done += fec_enet_rx_queue(fep, i, budget - done);
>
>  	return done;
>  }
> --
> 2.34.1
>


Return-Path: <bpf+bounces-65452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9569B239DE
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFFA17D51D
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430D2C324C;
	Tue, 12 Aug 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIL81V3X"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D52F067B;
	Tue, 12 Aug 2025 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029986; cv=fail; b=lKyWV4XY+4D5qkVhY7kVKFhVyElRZZgXUnDymn+KytLkQwOO2/YDauSivP+hQhayJcpX3TuYlUYrnM0jlg75/sheuLpoOJefs4WskM9J+h4zWMIEfEuEvvshjvKdE8yFHrvl0yElJdt0/0mcnZLRikxJRwDBVaKmbtkvMgMv+C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029986; c=relaxed/simple;
	bh=mB5QoW0vPnsAWws0uuEBYMPsAXJiY6UFaPsSXu00Gr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aEJlwMnE8o7WXIm7vY5+V7ZwgDI76dmRZVFT8/nKNw0GrihR5zIPlD4oOd1v3G2/J6sRhT4ItPdMNTRYy+oZzCWUFTFrycP9IEtAwRX+Od/PmdTUmVD03WTxaAiMPLCRaFYkVCwhrMOMm1hbPkk4eFHgGqiSL8OYhTSWSLKgDN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIL81V3X; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPnAs+6/nhLnNu93u61bxNByDupRC1xABgC+S2YACP7wap421Ai6UihOpqRLZR6myAIlBByrqFFaduDjd75NeB7Oe28HYi9amHl8/bcFDGhoHV0fopkYOzZBAo39TW6jxJ4QPjnNScOU6Z3vzfaWJDgnFrpRdBnoX1ljAyNP08s7rIeNuN/ym/GKhVHCl4OqdnMgBxjbGPJIH1brqXh8Mkzc0nw69qp6JSOypJ28a/IlC63GvtYBGt6L/XzeDXQ82/XRSZVdwrHt9btTysJqv6oe1iWOj+dJvnVxtInwWgeSAixUj+thHvzykevXulo0WPgKPWQpMErs1tH5uwOK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGkYanvViB+XVg48likEYHD30A9xH4qNeTYgACnLJpI=;
 b=VXfSstVYg9GJp88GIwi1V/mIrtAFQBMHJtb8uUZhU291J/A+oaGDXOmAb/MwnWiHSr3nx/Dr74qpNP78+5gBcePLXWvTT9LaMfpMuoDFdmdxSbi2vtiEeoYzT2U1JiPnOJbQ69bf1yX9RzOieja0hg92EzTwSMIOQiy65cBMHY3GKJ7D6tEPC4zXSdzlT74ZmVPDYQvxAkiUaNWce7W/aAh6ezAt9Pk+KIMIybALk53Rd07VWJniK5TQPuzR7kJvod4GbDP6hahW5E4CwnkmnXnov9R01s8b0XzCuywsxnfJNyBkjBoc38v+vC/KnYXU9WEVHT6KiziItDEA1hhnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGkYanvViB+XVg48likEYHD30A9xH4qNeTYgACnLJpI=;
 b=rIL81V3XM+5IufbRLne4wYe3yhS9NgVPZSIk8UHYMeIn2Zdm07nQlvi8+sg0SlNkE7fCRn5imA7VDz5Fe30BlCgCEP3ic9WG2/A609eEiDt4CBND0ZMFAkEop5EJs6v87nqut1P+irTPIDKfCfDcclVCBr9G3jvWoThagM+f3G7+VQLyPSXcRNie59VS8Dcrcw0ZEq45GHJQALTYYTwTh/6km248MNEX/CUIH5ACu260ieVuX34ZVI6uOsqRUtb59YcyAv9X08syoa+CeE4Y+AMxnFq6S7J3Gd67gMiZOjZ1SPJJmvnw5ZnFNRKNZgFRnqkCsEhPA6k7DnFh7WcqPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 20:19:40 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 20:19:34 +0000
Date: Tue, 12 Aug 2025 20:19:30 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
	Chris Arges <carges@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com, 
	saeedm@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Simon Horman <horms@kernel.org>, Andrew Rzeznik <arzeznik@cloudflare.com>, 
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <72vpwjc4tosqt2djhyatkycofi2hlktulevzlszmhb6w3mlo46@63sxu3or7suc>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
 <aIEuZy6fUj_4wtQ6@861G6M3>
 <jlvrzm6q7dnai6nf5v3ifhtwqlnvvrdg5driqomnl5q4lzfxmk@tmwaadjob5yd>
 <aJTYNG1AroAnvV31@861G6M3>
 <hlsks2646fmhbnhxwuihheri2z4ymldtqlca6fob7rmvzncpat@gljjmlorugzw>
 <aqti6c3imnaffenkgnnw5tnmjwrzw7g7pwbt47bvbgar2c4rbv@af4mch7msf3w>
 <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b27d605-9211-43c9-aa49-62bbf87f7574@cloudflare.com>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c679be-c599-4989-7642-08ddd9dd8d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OyqTklqAU7VvlAoYottKAR8GGf/XL5+T+/+UKw+loHCMp0onu+U8LX1CrjA9?=
 =?us-ascii?Q?GpDr0YrNcB7411HhEhoiZutQ1DvztU/0s6YnSC5hj4NEfhpSx/bZsZrtzYr0?=
 =?us-ascii?Q?j2tGDug0mOFsmO8Nvm9OzH9FtK6Wa4saHiHfb1reAk8VMNcKNOwWdQA7PGuw?=
 =?us-ascii?Q?KEFpQNOpuwyBAwsPiG3Kmv4vqNxH9W3tMgfp7wDKCTN+Ioq9x7SNSB+FZ0xU?=
 =?us-ascii?Q?UNHnHaOalG+qjK9HnyOE7Lx75mtHB+kCp/krALj9eeZ4Qu5hw39rjU/Owi/L?=
 =?us-ascii?Q?MM+3Q5X2fU0lF79/pm2e5pxlk9oBhccrUjb3iRNH3SnI63lkaavoP7C1jhBX?=
 =?us-ascii?Q?jLlyCzp2R9ovX1tG6PJtsVwi/55mVR/mWJBw+x1DWZOdJd2czLEVC6KdpWkG?=
 =?us-ascii?Q?TCown0Ben2SoWgwt82SGuk2ZamtJeNrDdH4VZefBZHuAQEffKlMIR++Q81Db?=
 =?us-ascii?Q?Hy9U2zEBt/tzsfCyJ1Bo4EKZiMqJgC9gwxl9FDk+FmR00IaUgFeXQgMi/m9P?=
 =?us-ascii?Q?JiNo92iKe66fbZC//PmL0TnVN17Bp+YZjcITQ7ZDT0dewVDdXlUdp7KiZu4J?=
 =?us-ascii?Q?5kRa8O96c4v2QbFGz6KjQum8LOJsmB/TMvPF7AF6wx7xT7gqNDmFA/C5qpK+?=
 =?us-ascii?Q?pab2U2XAy1AFKjE3M6Mg9aklH9QrV8HeHxmqsmt1DNRGVHgRdKGkLdZ/XKu/?=
 =?us-ascii?Q?QW6TxZV398VYaV8vv23g5EJIc3y7Oyk1Pcjip5SfkhRqKIE5LVMQDwlP9d1h?=
 =?us-ascii?Q?YBwf/LJw1YMfFbJSJPfoZjopgYhPpV1rLJCVTkZtBnOP9yNwGGTTofL+MKqV?=
 =?us-ascii?Q?dT2nwRhkYqiPoJRr6iuirnaHrUyLkAcGlAJqqb6LHrgaljLS5GXHGpWUdO5A?=
 =?us-ascii?Q?qmJ2cpKIl0JNc/RRfNSD/hhR8rYkeq4FCQvq8uHV+E5CrnuZt8UpxW0oBkq3?=
 =?us-ascii?Q?vkS1q12FTJA9tjJQw2k3Bl9QAlVvqAXndVhhlljXwhpplbDv6BkQpiQX60FI?=
 =?us-ascii?Q?TKq3sCPvjJTJLXLQm4aZtUO28fmHFMSXuLPiDT54uFEnjZKsAzrTJJcZE1AH?=
 =?us-ascii?Q?vSOKeXEximwH+Vm5ZLVAQL/idzzhiyolapl8KKwHERdaqAL0eA8yZV837mtI?=
 =?us-ascii?Q?Xbj7x6XROVJw0gKJRy9hJ8zrnSQ5m5MtvNK8PR654/BYcDpe5w8OJ199OAvx?=
 =?us-ascii?Q?Tyb0SjJwG5jAQLreBo65lAp4gKtMIysVP4CuDwsjPUra/s683W1hKZw4VQ8k?=
 =?us-ascii?Q?9ZYq9gEFzYOc9H8LO0AMSUiWUTteO0gYMf+ctyW8dRh8fQRljaCvNsIBPuHs?=
 =?us-ascii?Q?Rxwbc03ozCvqCC8SOVAeEezlRuFDtoH/k1xFGEiyuXwPxyPfJiUPhvJg7D9N?=
 =?us-ascii?Q?K42AiTXgc6kqmS1fCPBRjEw1wlR4B+pCHjCNs6xbQiGg2PZVy4UMyYpzA8/q?=
 =?us-ascii?Q?J0UlBLt5nmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9MZEt7pHXlIrBVl1dHLHN8TCPVrZbfWwbhQ7/hafBy13HuE5Q93a/k957k7y?=
 =?us-ascii?Q?b/zirEWagSS40L6IZMQoUyR/yAPewF4Z44EAfHxSb9OV+klmuhaxuIOEZGv7?=
 =?us-ascii?Q?nv93V/GmFk7SuCWtjYT9zGoGsOZ3ddRPOEnueG1Lu4594gcwuxt3HFJ9dyS1?=
 =?us-ascii?Q?G7Fy5+fxYKUJqoBF1PsvlAyQsVklTuXvnonddlWpSC0gsG5Gxp2bhQdwHGrh?=
 =?us-ascii?Q?8vSCJzDUxD0kcUUekpNHpEMrDi4osI57nxY/v9TPa4D3tkdgYBOJm5ggagSU?=
 =?us-ascii?Q?iiK5AeWKAD0M7i5LIdNKODkcdAGInSOELfJfr7QG6DB1useXxdmO0UKbawYC?=
 =?us-ascii?Q?YT/3C9QLdWP6loe2nQUEv7ApBlZL71KZVJ8H4T5CLrw4YO+ifDuPxTIYjCKT?=
 =?us-ascii?Q?0LramVVwLeghpHdiXFF4jyXH9af7DZPuBIGOAQJdfh4SD0rVny9j9wWnmnWg?=
 =?us-ascii?Q?+A4zwt2drkbCvqYFMdfyDfB4DI48imbjMHJqHT3Ljwi6J2SJk7EaxFLyXKuS?=
 =?us-ascii?Q?0DPhJfC76ibwlLNOEWfH9nzbN6Bcor0qNuWb7pgKVZf5rWbMerd7ngmKs2k1?=
 =?us-ascii?Q?NhHblF0JTqRKF704OJswpECQ23vTNgPhV2ej6W0ziQf4aIs/6kGA04d093cw?=
 =?us-ascii?Q?gUqESdc3nEtusmqgFDBi4nSS0MDP7XmkEvwRyX3/mce/mgXLdoZ/xIp6aNhw?=
 =?us-ascii?Q?A4bCMKPLddhNAGGZ/rFo+1AajLM7ERD4JRnHkjS9+zXW5EZORxIw4D2FDYfj?=
 =?us-ascii?Q?J7IEnUxIcvDMYRtwaLN3TZiGcVx7LUpq0ZOv128PVZ+eUa8jGwok6xB1nE2r?=
 =?us-ascii?Q?Y9TpgGx/hmJhG+bvbJ2CX3mMBepfVdoEcUfsM/E92aUihstjyvgW8HexCYjZ?=
 =?us-ascii?Q?B4ej8vKayINy0/SUE0tR4PTip5372zCWa8vU4PMa8BBRW8XkvUy/oM/caIP9?=
 =?us-ascii?Q?4ykXP5wMpmFFTJAjPKePR7yzEd4oc2SCc/wGf4lwnEb6EKWCS1brpnc94G2c?=
 =?us-ascii?Q?Mq/NMFnGKB0hZU9f6MTza2GDmqsbw6PinmYp/eXwwwL+J2g9BJByMmh05tVE?=
 =?us-ascii?Q?ZlvfxrXZs3jShbL37kxb80uxBZ86tacOhMxcQsBotmtUcmibIM5Z4WihHSDe?=
 =?us-ascii?Q?X45GRxeQPZVcxieVD1mTXg9DAbX4RnJSmghLHx4Er6NYboeNerZNUrGcOHXe?=
 =?us-ascii?Q?Sj0QutRSHQ9Lb1Y4I7BkgMj5NJY8KrRnpJKmHQ9IdvnorzntMKzozr/T8An5?=
 =?us-ascii?Q?A+38u8G7SCMebeA7qMro/6oJNqF6rwXSceQEJxNrrYYDf1kuSXqSE8t57X/G?=
 =?us-ascii?Q?HeeFBIi8OJGTzGmys9lOSoyCGdvF8c6jQyQCVSWGIOhsAinmKjmkVtvNWpXa?=
 =?us-ascii?Q?Y3uWICyrbbXuN1C9dE9yG0j/yLmpvEkRec2LDxmaz8RHhtmJe7LwDAscVS7J?=
 =?us-ascii?Q?1Dk52U0d7mW4U9fb9TXzyd79tGK5/box9TbkdiEyFihgmjGEohxLhF/Yp6km?=
 =?us-ascii?Q?/BbiLvkPbC4S1Lw9Ykh0DUHNwuEkwbIpc55IiGBeKt4PyA0OtLHAfeD42DfR?=
 =?us-ascii?Q?zuiggFMM5QjN+qcE53HhUYlZYTnFbn8mpfxIzZTu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c679be-c599-4989-7642-08ddd9dd8d65
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 20:19:34.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kN2BlV6aPAQiB0Yx6guuHcuqT4Rd5r35hWsmgV+IPCH4sGZbw01dZnYe/k5KcIRI6q9qe+jFnb65cEn0oLzJ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

On Tue, Aug 12, 2025 at 11:55:39AM -0700, Jesse Brandeburg wrote:
> On 8/12/25 8:44 AM, 'Dragos Tatulea' via kernel-team wrote:
> 
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index 482d284a1553..484216c7454d 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -408,8 +408,10 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
> >          /* If not all frames have been transmitted, it is our
> >           * responsibility to free them
> >           */
> > +       xdp_set_return_frame_no_direct();
> >          for (i = sent; unlikely(i < to_send); i++)
> >                  xdp_return_frame_rx_napi(bq->q[i]);
> > +       xdp_clear_return_frame_no_direct();
> 
> Why can't this instead just be xdp_return_frame(bq->q[i]); with no
> "no_direct" fussing?
> 
> Wouldn't this be the safest way for this function to call frame completion?
> It seems like presuming the calling context is napi is wrong?
>
It would be better indeed. Thanks for removing my horse glasses!

Once Chris verifies that this works for him I can prepare a fix patch.

> The other option here seems to be using the xdp_return_frame_bulk() but
> you'd need to be careful to make sure the rcu lock was taken or already
> held, but it should already be, since it's taken inside xdp_do_flush.
>
That would be even better, but bq_xmit_all() is also called by
bq_enqueue() which doesn't seem to have the rcu lock taken.

Thannks,
Dragos


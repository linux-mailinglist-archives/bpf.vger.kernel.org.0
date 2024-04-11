Return-Path: <bpf+bounces-26504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 364B78A1314
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 13:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DF01F2278E
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7B148FE3;
	Thu, 11 Apr 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3BCELdK"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F36BB29;
	Thu, 11 Apr 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835281; cv=fail; b=OpNWyyOSnJ+4iu4BTta0VRfV22aj05bgnY+Cv38Z7f5/ZqXB3izAfjG4hrCY7rfKo14bza1ME7NH8BI5rgJwjzHTVi4CyhJ7MGw8n1mh71B4Y4KqKf2bLU91KnUfLncEPDjvtEFHg4AMssCTk6HjbAby0NCioQHCd+8uNm5MPP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835281; c=relaxed/simple;
	bh=HauHJk5gtZM9JPJhhi8HjMBTtcNE1bpYr8/bmHEt6Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E0M4sb2j2iqbD/NOEmA9ym7TYhO5kvA7CqYFaB1jMfTC1IJoGFV2kvtrPYW+Cs6sBKwkmabP57k8bgEaoccWb0qaKRxY93irLwSNGDcmSdKxwzZXIn4/KkbzsHl5NxjKEWcYfTj5zaYVjelfQCk+EljpCZBSR3vvhr3JTEeBFBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=k3BCELdK; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUeAnsd6LVtw53b25qSKPVjQ5Gm/oyJwfbost7zd1XuC0RYlGd2+K0z/8s20I5NFEmP0UIqun72bVnUS3hx0WyKPc4TVpyLD6cEWLxOA9NTdcwd5FKiuTvthz9X/0T9crxhrSQnx9CExcdw6w6xvwyBC4t7zV17yKs+KRXONTg+chBEhzaq+5Fxu06saRbRr0PQnOMABtrgdyPWbRwMJBLd4v7bXX6LQoSqiwYTUOaiQPYgfsMFGlvBvhNxo3DFwTXNLAeRhqSnkW1y6XvTZ1AbtuziGrBMoGlnpPZ23M+j21QeHnhkczgmEyyL0Tk4ppe9y2wrfj0+PI/Ej1JACYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2SiR8bA2CbPROE9xekVxKhP0OSFwySnsZIujpK4jSA=;
 b=RnWJBqXr4wnJnQdanphnL8iHWOeZwPcXSCmso0HW+S72EQtAWfRu1bk4ZmeE4ncwk4BtDcK6JBzsfYzCtLmUwoCmZErKe3dkLwkKV+s1P3VOn1qGiOBF2/fpQGICWhCyNiSGDnY65jhOl7I29nZmaF+b0UO9cT3E6+qi+8CLTQXPyxoALTY4XYpbyAWl95cTuT5UkVxvq+/bTBm99gBW0ldy1MZAa8S3UYLsaw2QMTqDe+ZGYckELya8gXMPGJCEKkPf5UHg3/yJq6vAoMxHtoImwNDi/R78XKe3IUN9YGB7rW7sFfJz1OQxL53L9WzPipB+Ep23Yeca4/kUED1eUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2SiR8bA2CbPROE9xekVxKhP0OSFwySnsZIujpK4jSA=;
 b=k3BCELdK+MphHTR0EhJCIaR2PpCWYp100pgrFCrnthTge61nSToI0q3qLApssc8oGjxpe4mLKo6vZRp4WsCmHEl1s6jQNILZ9D+HqUY3Jews2Xt9Nygmax15CmKmR0Klv3m6DHUdO7la082BWjXb8G9vmfvmRQXmf5FKRQ2X25M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:34:36 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::2975:705f:b952:c7f6%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 11:34:35 +0000
Date: Thu, 11 Apr 2024 14:34:33 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Camelia Groza <camelia.groza@nxp.com>,
	David Gouarin <dgouarin@gmail.com>, david.gouarin@thalesgroup.com,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net v4] dpaa_eth: fix XDP queue index
Message-ID: <20240411113433.ulnnink3trehi44b@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410194055.2bc89eeb@kernel.org>
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AS1PR04MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: c04d8b9a-f303-4e41-1d7d-08dc5a1b5d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GBsNrHlfWf2mBWjn2PBcSesF3Ho0mhb9D5kzl26RJc9owyMe3H0Cp48NFeVS0/QggOtL16OgA3bxmpXfhGOx3EzhANqIrh1/2/qoqkg/2ee4Szd9Zaj0LT9h1UBqlZZg8mJh1CFDmN0WxIVbPBHGzIPP788BpR0p9pX7S9tHE40DJzdFOEH4TbRUhPrIBgi4Tv1YL6Mw+xC7P/TxGJixbIZxd4drB6E5KmlCLGd3TVRGBZmknzWnqEYwqMQzfStdt+2LgEZonSiJM2/xYxoebaUZB79OdEfh6Y7Gdl5Ymy0PnevibLIdRjTBS3PvXBqcuRSlXWFGnCKy5ue0noAzryZ46HOAkkyW6e8ATaA73rZAFsaNEt9R0d3Iy1xlz2UMFRRXsJV8p876+y++hjCR8T2eR5tAiL2/Xa6/bfI904vXue6vwk5mX3SIJZaaNR8MU/0rCDsurBfgH02PSKzsIpAjjjkcXNADvIub80qi+tiN1ShpmDB4JuIMYSyPNb16Exr3sGSbD5453zi+l4tDzog8xMOqELjM+WgFAhSyTFyqTGa7GRErlyOXhv4qrKokL4EVCXU9qaSfCEcDtzai/AnLpLc1FX1cGgLNglL+g+QNZ6rj9oRsmIUvvHlcirFDs/h/3QZyr2PT3vckEAk9Blh7dPvNxtkLzYsNVumGxcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dGTE4nfq2vahUXCZFxNwTrwOiw4ZDljInS3YX4D1AO3I0feMKnzvtwXa1Qw2?=
 =?us-ascii?Q?wTaWWavswsNQPO7iWSuKAbUZR4yyKlgIqpmACL0zOFZzCYbwp4lMNNuu98Qu?=
 =?us-ascii?Q?ObBgKbKEBapjGicnYwlK6NK5BEvmnwrcPEb0cM/GVjHA5+Igr5f7OQajOMbs?=
 =?us-ascii?Q?kGq1VPCD0SuXmpD9YC4Z+HCTefRSDQTQx/4ncACclqBrZrw5GFC4rzRQfRgU?=
 =?us-ascii?Q?eHfWhf6XrZqiM2SBPO29oMyEM30BwjvHSNwqsZDfO1cr9iKV5oAmcO9Z8uyW?=
 =?us-ascii?Q?e++rs8lCAw9cpgf76gY34brIQhwQW25rt1yWAbBWGvDOaYQqm5ubYIRkUFZd?=
 =?us-ascii?Q?C2uhOqD6vb17j6hcxE/+1yPwB3oq0Ip4NPprVrEXF5aHjQqPCW3mAAMXbDOl?=
 =?us-ascii?Q?b6YDo9mfEu/sCm+tB8ASKg4nWaUtsYuwzppzI7OL+AiQ0hfMmyjyvdp6lo6I?=
 =?us-ascii?Q?MB2+H79+2hJPz88AZnif3VGVHSp5zGbzTHoCR77tJ5zmvXlJfEOpYHiJGc+o?=
 =?us-ascii?Q?lCz5ouSvIQE5eQkkHZnhlQttElr6RIs5E53mp4V3LhPTkyCqbjmU65q2mQlU?=
 =?us-ascii?Q?xzkWmRHBCDUo0iT+kRXuUl3msMwv48WSvfh0DBsIxVSszdLxGzMz2EBPNOv6?=
 =?us-ascii?Q?bEreE4xlIIt3cw514/Q9IOwKyt9+/R1OxIcaF2Hn+6c9WWVXOQltQG94CPoZ?=
 =?us-ascii?Q?QrPIwmQo6h6ft+qOsBIUtx7iS+e1bpot5gsh1AqUxbEXSSYAUQzkJuduRjtS?=
 =?us-ascii?Q?knJvq4kKyi3x3avFXzknRVSYa+/xJh2zwbpPnpFbmE1zJ4XWKKmBCR+uLBqc?=
 =?us-ascii?Q?+J/S6HA412XNDLq8xSW/AByb0a5cB4P8wECkd7e5Vme+UuCmEzoMsD/qthci?=
 =?us-ascii?Q?En+epTVVVJTCVj30U2BzAU+pYCqHddO5zWBLl6uRJ6cb7aS3TeUKFcr5VLc3?=
 =?us-ascii?Q?cnwLuMqS3sL1/8T3nHRORTBmAuHxgTXMQKuDW2AKtTVlXYq+gAKvulR50F0m?=
 =?us-ascii?Q?c001eBNO8gW1zcxNJRfb1YVKGWcLR5fwZoNB9kAFlkoqhYlhoecyMediPdN4?=
 =?us-ascii?Q?SzY/pmjwH6PU4vi8/qbvp+4aicfk6c6brL1DX8im0SjFa9qYZLQzgEdWuf3q?=
 =?us-ascii?Q?dX5DEc8U32JnSA1veYilC1YiTDgSHdyKc2grnMFRgR8rMdzlGw/mOkx++UEH?=
 =?us-ascii?Q?yTo5Hpge82bLH0U0n6KNBh8M00IFE62nWuoi8Vj9W1TCzIF2Znpc+9IdhNAD?=
 =?us-ascii?Q?E/tWxkd7mG6yX4iOCppYAEMHWTeoAOHgdjdhJ7FxG7dqMUIFg5s8ZISOxdj/?=
 =?us-ascii?Q?eoE/BppgyzFt6ezKI3Hmy2kHgwEJ9kC7zQkShqtKqIhFLKL2WDN3pftQxf3U?=
 =?us-ascii?Q?gHp2IK45KJ1i7U6cwiWAgWXLGMFZ/5JW5DT6qRGnA9MFKtA86CSiK8dVjtPV?=
 =?us-ascii?Q?hbJfNVucKPoNznpqs0iwzCHn90LGKExbAxntn0e7g41IVftTc5Sv7CdVW2Mn?=
 =?us-ascii?Q?V0WDOiAkRrSvzO3SNPgeZ1WGNjZRn19uEUQJ7Jc7fsJhweUcFPh5yxqTdmzO?=
 =?us-ascii?Q?9nhnuaNdg8Uq2Jv2xWdK8ut5pny5OF0U4rhdiHVTQr+QpglcxXw9YFcmcYws?=
 =?us-ascii?Q?vKDF7cRnjks0zcxKlpucSXk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04d8b9a-f303-4e41-1d7d-08dc5a1b5d56
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:34:35.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtjCgpd9UJ3/I98WPrUNGmY5YXpibpO/9GFh1UyC2vJ1ZZ6AwSG1B9hB2+kIsQWd6WMGnuJGX1INej3H0gD0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9559

On Wed, Apr 10, 2024 at 07:40:55PM -0700, Jakub Kicinski wrote:
> On Tue,  9 Apr 2024 11:30:46 +0200 David Gouarin wrote:
> > Make it possible to bind a XDP socket to a queue id.
> > The DPAA FQ Id was passed to the XDP program in the
> > xdp_rxq_info->queue_index instead of the Ethernet device queue number,
> > which made it unusable with bpf_map_redirect.
> > Instead of the DPAA FQ Id, initialise the XDP rx queue with the queue number.
> 
> Camelia, looks good?

Please allow me some time to prepare a response, even if this means the
patch misses this week's 'net' pull request.


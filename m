Return-Path: <bpf+bounces-27116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C2E8A9475
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456DC1C216F0
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A0762DE;
	Thu, 18 Apr 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PoUdZCEw"
X-Original-To: bpf@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A156F53D;
	Thu, 18 Apr 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426698; cv=fail; b=MeJeADZ99JBQht5ofoHIPHU0oSP2NzZ795fRgpi3Gzwm6kiPaYFXVzlFIk+8fBctXWEzjHq4GJBng3Zv0hiyDDDlSOV4g7DowSj/RcQiPeWBPwv4L3ibP9XTfWln9xElAiaGa3ZtlagSk7FC7pmcb6a171oIhbT8HJ0cTivD93c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426698; c=relaxed/simple;
	bh=Jytr5VoVlhnxNbrW44asW7FcGLHL7Lhd9yGYC8AdJFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dcRtj+iHOIvImuYoUrPLH+L0RsKwsOBl/xmFZeC3F6j4LpRqfEkyfLNZvkGl+M8R2GurLUStSud34uNWCR01+twS+giPlwZF3E/KcPId1AF5ci32ZZPJM6tUsT5oIeTi42lr0xffjM2IUmPvBtUtsYcXRaOGkzNrxMr+cR4xS5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PoUdZCEw; arc=fail smtp.client-ip=40.107.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKMvQKwP+8BIwXXYTaJMFM6YlRYsPHYo381KRpdjGns2+EFPtUdZ19QlypjgAgl/FgjwuNYYRrgG9f48ZSbOifKa6nFcYhGNT3A80blpRjTY55b23kEo9HAPGqIU2xHppNlG7BxiaQt0v/xteIDcz5vrBlyGqV64C1pHKK1a/5DbkVnTj+MLIWVwEGvdTDgGdMM9rUp6imrPc3JCx+dP2AKnrwwpzSBrfqvusAvXg1S6dPgEvsNrev8X31kH3zmm/aOhhHi+LWrVwZKATsmdLGCp6IBri43k4CTXkh6QT91jYpsw3yBiDuwl95/QtJTVucNFY4h1sbhZeJgbQAbFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBZRM6BtiZvG4F2pOY3C29vZF5sMxENSXtTs9a1AHNk=;
 b=OmiQ5F/UiL1j8pXrAh+37ti1tdsaIuxTy8KbeXOY2zFP61kX9xbQ5zkzYOuo98h884Nu+XtlZFdHkzRAgU4zunlV7ie7znXnyEliopZNLQJ53Xyz8eLQ+/Y06ZxnBOf3S/ZEs3zkHRVHPlhTekIylyrATYwqOc0C+Ff1bLyYLGJoXhvsCA7Vt3eLRHal6qVraUvKTeNe55Yqrz5XBOkMre7fhZin1yFZ+RDr9qs1Zg3iAGEs6AqNxgJi3VufTPtgty1B3DZTOYnvk8YbIDhNSGoCUsrgh7yc9xhbYz07BgpoNwffQqDnAkx56n2tSk820AdniHEjSgZyiD1jDXAfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBZRM6BtiZvG4F2pOY3C29vZF5sMxENSXtTs9a1AHNk=;
 b=PoUdZCEwPbE7GbKtQL+N65ovQ9Y6P9LrDupOGNuziEtKmloh6GU4pftFiZJUucMHJsmbaa3Le5XKg9d4/qCyIFprcel46iTgnY4JwuzVmFBsRrTrmCjDSeu6DF67MMNTkGHmNGHu1kM3wGZZByGk3ivfW8Wer4dKdZmIy2uvWDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PR3PR04MB7371.eurprd04.prod.outlook.com (2603:10a6:102:87::17)
 by AM0PR04MB6915.eurprd04.prod.outlook.com (2603:10a6:208:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 07:51:32 +0000
Received: from PR3PR04MB7371.eurprd04.prod.outlook.com
 ([fe80::ff04:1157:85ba:a13a]) by PR3PR04MB7371.eurprd04.prod.outlook.com
 ([fe80::ff04:1157:85ba:a13a%6]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:51:32 +0000
Date: Thu, 18 Apr 2024 10:51:28 +0300
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
Message-ID: <20240418075128.m4v4f3nlrzn3qlfl@skbuf>
References: <20240410194055.2bc89eeb@kernel.org>
 <20240411113433.ulnnink3trehi44b@skbuf>
 <20240417181734.7ebc844f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417181734.7ebc844f@kernel.org>
X-ClientProxiedBy: VE1PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::31) To PR3PR04MB7371.eurprd04.prod.outlook.com
 (2603:10a6:102:87::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR04MB7371:EE_|AM0PR04MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: e089c523-8491-4a25-d56c-08dc5f7c5cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yhy6JDnJ6QVjYXrfjgP2ybbSuiXZ2dfOGbc4wVzs+87GRae7iVavgnn/6DmcZwMEINcljDXsAbsRfMksoAAUeZahPUV8OshV5+D8pV2Q6X/MH9nFqo0P9Y0JXeuRbZsSg2bCbMAO5nw9sqmz3kzEyoOOS/K7gbK7+eeXI4fy+f81aY1IHMVwoNEKJv3UZD8WUUe9HWksE6mcO2AkSXJxbf7By0+4jtGAfbzfVyOuTMTimT8weCkeC48Z6WnVej8GvjcINXfF6J9GaO0oNYMlicw2pz66/q25j7iq9NASCSdtruN3HdTPcgfAwKewAWPNdvvLoJIIl+CfnYRE4l8t09dPXukuIPkpbKqITxEMaZKvWcFqjVQ3zbJFhGykiEm0jAs/fo2KtG7AKeIoGyoNoFbw+SS+W7NMImKkZbJamuIlPH5k23kL+Wg1SNMoJ5cMvSrC0pfHSmp7JrXGIR97aor82qFcRfAu7JJSNabop+gd+OrE1QqxrIq/9CWJO5QSFwFPCdBBI+yyKQ4E15RkMHUWkXAvLjcXO7h2dJCzCfMTkMoISv3A8qzmVmqJIpC3rqXJMcwyHgYQpqGgLo++KDUtu6P4hBZLtq+Xjtbryy/oDO7EOHFqgy0FLBjbgt//EqnmjlumtSZunHEQiSYZ07k2oLKXTKZxIixxV7uCZOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PnftYX6FQYtdWWLpsLnhHIFIhrvcCF+ekGzFuQdi3zJU6D44BNUGcQERO2Fg?=
 =?us-ascii?Q?uDm89zJ3gxBrY5guRTarNrqRJqDQAEyzK5UWksN7vr+JTqQSOdew7XqkY8Ks?=
 =?us-ascii?Q?YrN8pRPnukdIBYbmHCucUWTUcSnJvuyqaUqOWGXm5DMw51o491sRiCMCU4e4?=
 =?us-ascii?Q?0f/pCBd1PbV2b+MbrWKjnhUGU6lUTNdnZ66wBOgpwAgfDKTTwxwnDuP58ctG?=
 =?us-ascii?Q?zYAJ+7L64oZ4A7F+FJVknGTK53ryTrWAp1pvQq1JRIlDrZ3V1hoFhN8d/fxh?=
 =?us-ascii?Q?NKjiMtSB/2WR8iTtjCrDOIrWygMeJfOfXSICfsEzonlmaqWfh9OZ/jXNOi5S?=
 =?us-ascii?Q?S7+DK6rfRUeJ20U2o9mWZK3OXpgBGjS4NKZ7WYiimrTVBJC6b9MyeOBzAsD9?=
 =?us-ascii?Q?ebQhC5Xy5P4QdNU7Z2NAtDUitZkOwu5kQzY/9K4WeHaX8wcmPC5A6Rd/rR7A?=
 =?us-ascii?Q?zfVVgecjwD7g5zPUNzeRJX6zG6nTz0opB0BB4w8k7+6H8/GGBVM5t7wdkZ+Q?=
 =?us-ascii?Q?BaTusix+IXJEzzfkYG5ayrTVl+d7Fm9YqxApWEoJoRKTNLRO99k6g1TkbtQJ?=
 =?us-ascii?Q?hZvQPUxJs0JJ6a0s7Rpamp93/JkUcrzmtdPAWn1oEbTZQlGLi/joU56qCxIH?=
 =?us-ascii?Q?9195biybSidz1g3VFpmCYXfZIu7bEECYDiB8IxR4I1CF+ZYfPXMWyWlvZPFb?=
 =?us-ascii?Q?KLhWI8WNXxZLuDuKPgK3x7ivS+IA2NCmOPR8nwyPH3uj5iVDFtRttBcO9uH3?=
 =?us-ascii?Q?Tfl3e2CXngOlUhdc0D5y7vEASX7A7FJKslLHs1nvfUbtLJdIN7Acr/MTpzIW?=
 =?us-ascii?Q?OImYUqqdWfQShA6qj5cd51OXvJ341liGS+Ctj50EJ48K6ayLkdXGcuiztrq2?=
 =?us-ascii?Q?192bFAwrGlg9DibU11MkMK7A6i+1N7+WCHfzTCueGmRStIdas2MaRqnQA6NV?=
 =?us-ascii?Q?aVhRqc5L6/F1Z9wVtjx/sZmLHO1gM2CSJMSbSrSISOKXzJsimyKU5DB2+zL8?=
 =?us-ascii?Q?f8ENRYiD3IkdBeXzOMuTFlqts9LZwqLIKak6QPtPyNfr01yLFZxDLLM6DzuR?=
 =?us-ascii?Q?pgBkzRKhsoFfDPSnXPdsZzLFq0r47QCaFvO2uXQp7FMLnpTxcXwDbFuSYjNT?=
 =?us-ascii?Q?CfIQds7qjGqaMpzf/xK8nCjtGIJ9xJLyqwUcnj16aeVv8DMsDZuITuul9Bsi?=
 =?us-ascii?Q?8PSgKSNTZ73iRmqbl3gQdooOeTC9gPs7tzx3OYi2CigQY3AfuRDOlMe8fOzN?=
 =?us-ascii?Q?MV9ZVRsW+Z6PsJ9VgVAi6giid+jAjA6Ruc/nzmxO/Aty/2wZLSq+RPGR8bWK?=
 =?us-ascii?Q?/21i64V2qGAsgN5x6OagFQ2mMep3u1LkVL735EQzNOGGZ/8NE1uq6awwHz9G?=
 =?us-ascii?Q?loB7jg8zKuEG8uwU18YYh8oTUZ2qSbE/x5s8aBOKDsLbmIN6+rUSi8BQryXa?=
 =?us-ascii?Q?kCjAXUp1Qkze9y0Qk3sEByDUKoMMq/O5En+YIAbbgcdVd6E+myUoT5AreVwd?=
 =?us-ascii?Q?YvmLQgc9YMPFBkFGit6QCTKZ4LdSiYI1IsY8sD9mPBgVfWg8eGc/yjV0j1iH?=
 =?us-ascii?Q?dzb6hrOkPm7In99i4oSDiSPW+TfImU6CyPT41yvHIMrYK6h/JlhklQua+cQu?=
 =?us-ascii?Q?nM7noOFtjU0hb0h1KYTMEx4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e089c523-8491-4a25-d56c-08dc5f7c5cca
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:51:32.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anibqSbS5FFzw5+4eeZ+eUacJRImf/au65k4E0lhPIUmFL4qJ3uqPZ/ELRbYv6I8/Ro3YSu0149QOChq8GCe9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6915

On Wed, Apr 17, 2024 at 06:17:34PM -0700, Jakub Kicinski wrote:
> On Thu, 11 Apr 2024 14:34:33 +0300 Vladimir Oltean wrote:
> > On Wed, Apr 10, 2024 at 07:40:55PM -0700, Jakub Kicinski wrote:
> > > On Tue,  9 Apr 2024 11:30:46 +0200 David Gouarin wrote:  
> > > > Make it possible to bind a XDP socket to a queue id.
> > > > The DPAA FQ Id was passed to the XDP program in the
> > > > xdp_rxq_info->queue_index instead of the Ethernet device queue number,
> > > > which made it unusable with bpf_map_redirect.
> > > > Instead of the DPAA FQ Id, initialise the XDP rx queue with the queue number.  
> > > 
> > > Camelia, looks good?  
> > 
> > Please allow me some time to prepare a response, even if this means the
> > patch misses this week's 'net' pull request.
> 
> We're getting close to the 'net' pull request of the following week :)
> The bug has been around for a while so no huge rush, but would be nice
> to get rid of this from patchwork. If you don't have time - would you
> be willing to repost it once you found the time to investigate?

I have been looking into this, but I do not have a definitive response yet.
The dpaa_fq->channel replacement is not the zero-based RX queue number
that David is looking for, either.

We will work this out. Please remove this patch from patchwork for now.


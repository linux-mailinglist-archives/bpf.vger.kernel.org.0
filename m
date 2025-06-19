Return-Path: <bpf+bounces-61033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E00ADFE8C
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E949B175571
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256A2512FA;
	Thu, 19 Jun 2025 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bgHJxT5D"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A223A98E;
	Thu, 19 Jun 2025 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317604; cv=fail; b=e54vJGDcUu9tFXzxuzHUSkZ/F5foOhDfgC2FEcbWOPCqU79KvDikpb4c4P8wiFEzAYtEYIx7/i1l2W5SIRYsPgFaVow1Q6H8Gi6lt05qF+bYIzmQ+1/h1JI8JtkYVUJxqgdf4JvAX7sweWbS1YSn8njbWlGbQkas6fQgUbxyedA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317604; c=relaxed/simple;
	bh=asNlkjogE3LHOKQWvWZI7orqyZSLSdHxedohfwE4XQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XCWP0zFqJoqxjFFF3UaANH7BVZFpUrzIJ4OWlrHrbbCaEF7eJCCiaTV1VIKWe4hT1xjRyBjYm5wpLdm5hRAtfERd0ZPMg86i5T619Xust6UUFKxkYnhzE0xtSeNXOHcyy9J9VcQoiX5DQ94VZP5QukPl70HXMqvL4kwCVvNXzPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bgHJxT5D; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV+rvrUPUAglwaCIC6/ZFf+DcqPPsRWWbba3CIS9LFrcF7q+5+sd0rflurvTjDwDiCVNRtnyNOoh/my7mI8SUNjBSu+1rJj3GQsIdCvtBlz2XCQwZua0vabVp7Oi+IBJ9Vm0j15nKYSGseP0us7TgfSZkjrF3HD7P26HdWcoWrmCwBYgwXG9Ld/1Y4YKbD7L79wwD6I9C4sR4n6MTL8rSIAdFC6oUF6F9GGoKipdfobg6RPINs1VebHLyjstp0ALuWpeC+X392/b2DxZBOMcRt30k/P72vvaTaUaR2WRqUyf3uvUqFyuahkqZBqqZNG/J1R6G7u9JdobSWPi4wl9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCqem0dPRs/G6fDquxnX91Jeh1TEckbakh2IrNGlEsQ=;
 b=aV87EXmkKviTf8s3WZdPu4st9Wx0Fo253j1eFH23SmzfFAuUp1b0FSTXqf7aGCt2c+n6NSK/pG0zU6h7ca+yKICmfXhDVdPCOp8DsLVq+isyMF1nWK3VFJAjv/9BHbrNgiDKeaqiND4C9IUZzbDdFzQ6Iuf+llsOMOq3g7G33usatwsIcnUwXMNIpKpdt+SUhO/TUsRh2h//cdcPPthaXdrZXyMEWRobXpju2EcoUs0oHjN5Ia8QW+YZMzoOMHsk+B9/t7szP+bhS0NnWH3ktL0aM+3uDLwvPWu0dcSTITxwM2Q70Y9QwJ/Bw2vbk+GSFSOAT312BcpZ/F/eiNmTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCqem0dPRs/G6fDquxnX91Jeh1TEckbakh2IrNGlEsQ=;
 b=bgHJxT5Dcm8KEXmAM7JeKus5crqna5KxElGAmYY+C3PvLPUXWiid1hxbDCiIJNGUl+uH5+Rm2cFuxuQ6E72Ep9eabxyLXNg6dBIN2Wa9ZRnIsbHXbgZpLTGnVYSt71b5mw9zUQM/K/XY3xSmwOQFlOoZXzCum9PepLobqD11TxLMUGGxKF8585up+7d93RfZCn7F7/gSb/NeuxF6J0TiMxH8xWpUUzxINBIAxXjs6itPUJ2V18GrSciB+AbtJpUzDw++kiVu7Ba26dza0waZIzEY/ntJhhleLJ4KxrymYIWWOVhrRZwOwMPiW0z1hg8v+lxdvaLgw6iCtAVqe5mJJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Thu, 19 Jun
 2025 07:19:57 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 07:19:57 +0000
Date: Thu, 19 Jun 2025 07:19:52 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
	Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, 
	tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next v6 12/12] net/mlx5e: Add TX support for netmems
Message-ID: <q7ed7rgg4uakhcc3wjxz3y6qzrvc3mhrdcpljlwfsa2a7u3sgn@6f2ronq35nee>
References: <20250616141441.1243044-1-mbloch@nvidia.com>
 <20250616141441.1243044-13-mbloch@nvidia.com>
 <aFM6r9kFHeTdj-25@mini-arch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFM6r9kFHeTdj-25@mini-arch>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: fc871838-e057-493a-311b-08ddaf01b1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3cz4O5/TsaWx5sZm3sKShWSvBPS6+T9K2fRePHi3+23g81ziTHfxtw14GHLv?=
 =?us-ascii?Q?8hJGhxB6qrZtwXjvSPuRRnxotM21Q7U+zGGvlV68lYYVYqD11ooPkx6zC6cZ?=
 =?us-ascii?Q?lE2iD7hRqOn4TZiJyqi4p8DdnaATn2+2s1RfPncQyrYCPawtKmfgc+HSomQ0?=
 =?us-ascii?Q?h709ySJcGtKB1DU7Vkm6xv7a/XiUp8QIFAGpNsNyX7ctkQL8K/9AbnopcLqm?=
 =?us-ascii?Q?ebT7D16JPwCFIE31rMdHHdc1lVd4ZkX/Kw+ndZsEgUdhJRyzb2att3ud7BSE?=
 =?us-ascii?Q?COSMxiYxPX8Oh8qhr92QFbOUhSOAJxBvfKAXMKg9ER8zhBlGajnp1p8ZIi/5?=
 =?us-ascii?Q?Vh8WJUqWv5H2DKmHWLvwSRbQrqODtMnVeyzHJrCqqxfzq4TTanqg8BbN+yxx?=
 =?us-ascii?Q?LVLbzTvR1raxJt6ZFAepCyi//gLW83O+w9IF3rRlo7jxRJFihhrKlzJISNjY?=
 =?us-ascii?Q?4doSo5zehhtOVi6wrjykVEyYamw2ydlxStwppNCDxwLcApAuq0Ul7JkCMbdd?=
 =?us-ascii?Q?LcggKqrpb8+2NaGFukC+Dn/2Kp8ciQpL/npQ1+QLqEQFxhadNKRfGnH1Gagz?=
 =?us-ascii?Q?l3rNDpGKHkZwQrX+Y1xe+u1T0kciXqKeFDTX0uOoD1CxFM4stxMO6czWQxwf?=
 =?us-ascii?Q?Q+SIT3fpyiqwMk5FhLOO7KDcHan9uJSsUclvFypssCt8DWGTsGR9gtYah49N?=
 =?us-ascii?Q?vdfzZA4GEAWkRC7Ia3K3O/XFVZDz5EqucbuqMqv01V1WD3eyYha2czhGG7r1?=
 =?us-ascii?Q?QjiaIICVxZdz5VL36h4+ZRXT9ArcNw+CqhWUaxn3h3ei/zVdAS5S4Kq/ytF7?=
 =?us-ascii?Q?NYbkkCBBIgCLN9t3zmCayLXP88C7BHpH78cml0BWSW4Kq2VuoIu3Pk6SrTda?=
 =?us-ascii?Q?nj1kIUZGt9UX9XPCqcHW3FqYWFgZgN5tz6Mz7bPFTq3cjuWEc1bnlzLrHOON?=
 =?us-ascii?Q?PiBlDjDwbObORhPCBpg/CS/lJBNH3akvDwjDhG0TDMiCdpWsaXmVOMai0jUF?=
 =?us-ascii?Q?rcqZMx9NVpzXUnh0DnbEU02TY0T621IYXsIZrS6D0fVeRPY1ZT8ALyXUAzKv?=
 =?us-ascii?Q?RN3mapPdJv6ERZJgi36wesCKXcObGcm1gQySwotKwOlrmBqQJD1yENAb2ZW0?=
 =?us-ascii?Q?+cI6XRxBJ4bNF5Oosyal0gcgUQFLnyljUX9HzASmmIPg3c2BXE9ETyaqBS6/?=
 =?us-ascii?Q?qZl1BL2YRa+ST0DucNlCKSymUhlX7mzoHil0/jwlVq84lh1OjkIcebE7byb5?=
 =?us-ascii?Q?zDQsEIo+9cJALK2ojMGkTop0nShmnPlEaUZ0TnpRaIG9IReh1cgXJCt2p2bW?=
 =?us-ascii?Q?tsoajVv588msY+4xoMNhRwFoqrR/rZi6k6Eq3aUAPpOIG4LiaC3ObVFAAtOB?=
 =?us-ascii?Q?L5llow6P6nS8dpk34aLQ1UWZSmx+/eMbd1uwnyS09OhL7HQq6plxLwJ8yZ0z?=
 =?us-ascii?Q?zl9l0FOiyhU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a660zOWS97nHhGMqHaRDPuUrQTVTyI73pT3GN1Ul2sLh4dOzagGfvfv3xgcE?=
 =?us-ascii?Q?bAvfN7FG/R5RQHiE3f4eNeEKjBbIJzWeM3G5QZm7zlXmBaa/eQom6VgHZ0YU?=
 =?us-ascii?Q?ZrmbiTk1hJlFrxKMoFqF+ZyVKsEP8g4a5iKP4CS6JFGBtr1sUMM7+MQiBNyc?=
 =?us-ascii?Q?4FMAtWeTwmtG9AW5orjU4h0EU9ZwKeHJZQrjBXsKOjd1p/gox0u8jZhoRAv/?=
 =?us-ascii?Q?W+WgKBITjnaGyE/7puh4ufhrgl1Q3L/PhCpXMTqZuQhHg+SK/zGuSqCsJPEx?=
 =?us-ascii?Q?BTNVPlrdfRNtNayCDC6FGHUd3p+mhWKoDxjSsD3epNOWOTnE4OdDaOwr7qPV?=
 =?us-ascii?Q?psZ338syXGELcIv1nOnw2S4D6R1x3oaSjGufV9BhlcjsOF1CngdrZJG9lTF3?=
 =?us-ascii?Q?kFl5+dkJoigbwq9K9GEnjaOlLDnpUaTLw0lPjrdBmaX42TG7PzLKyBY7hzOn?=
 =?us-ascii?Q?xiybQh2zwCaygSZOEgIJ5qSakzLIC0KBYtnxYE0OZexLwy62Is4NGzq5Tcqo?=
 =?us-ascii?Q?dFArgzE3nC+uDNxbjsk0sZkp7EV5Oogu+Plun9OP7m5OFD4Rrcl+Urt2DqiV?=
 =?us-ascii?Q?U0Y6b4nlmEFa4KkI1DLRMGvdmJEGT/vkfsE6OsL6soIMXj1nGWVRndAxClV1?=
 =?us-ascii?Q?k3uMCCwVsSOXFKvaRnnFR7yB7Kv5rIi5tekdMZOyHsckANVxmTM99outI9qR?=
 =?us-ascii?Q?lMhVyvQHRqmQo7qXMxqX+Z8DFiN8iHn7HDKVswr97PQd++pUv6y01o/+ZNhc?=
 =?us-ascii?Q?m/fAtmkGoOXXDms5yLV67deYVHtVMRi0KzkQbkDtj1cnVl6GtIBW5nPDA4t3?=
 =?us-ascii?Q?HSWIi/XgSb9HgCOxNBSbEHIcoAapXcH7gMe8C14G/pm8tY0Kakv2vWLtOdLF?=
 =?us-ascii?Q?kq4JEUEFp88XHY2W5awsJktgLWbZ/+CPBasixHTM5epcMgc65ATM/JiV+0EA?=
 =?us-ascii?Q?DUu7j8nfKrpBjhwSGqWPaEjHSOiraE0deDWEpRItX781YrMYwj+Q2BoqIOR0?=
 =?us-ascii?Q?4Osp9R/6ad4buzitRjvvxwAuPytSRjMlXS8WlVasY61pWhV8E9DHnOuMtTo2?=
 =?us-ascii?Q?8yX0Thzm6x91huiXwzHL+OnJGdZUB07uFIDSlwO8hq8PtuZ09OIhNgUaZKHH?=
 =?us-ascii?Q?lUgzheoIyIExGe2mplQq85tW+2CqTD1cXdljTVHYQRU6RBXGCDcnAo+ROcUH?=
 =?us-ascii?Q?yP6X8pNqZYcUOYPRWMZ24Z7TxN2DdQA7O5sfQ+hQ8YZbGv3N0NNfIHcGWmQh?=
 =?us-ascii?Q?K7lKgNd+MkWaW6HhJ/z3lwutL82/SJYFwaXlm+jaru35bWNNuLY513WTBVAe?=
 =?us-ascii?Q?OvinLCweUOmHm85WnoA+q4+tZRnUSUfIUZs2tgStXicg3mFQtKdndvLUxgKJ?=
 =?us-ascii?Q?PRek3iA6QteJ/FkTvRI7qQCYvBJ8ZjYnjbaFqrpKq0w7yKEEma8uSu0wyR01?=
 =?us-ascii?Q?GRslesO9MCHJxXujc17L20noEJ/cQDhYgg/ADFyQNeZQGcjYS49PYrY++h6M?=
 =?us-ascii?Q?0qE24UyItEoOSxwXTXnlPgru8fAd9rwKYe17wmay1qVRQnrSOVuSeQIQSHZ3?=
 =?us-ascii?Q?HhoT2rr7tj1/bHxB5Juu7i9BOe6m+SUJb2uLuC71?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc871838-e057-493a-311b-08ddaf01b1d0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:19:57.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVtB6oZkkSTE/OyyDycqHf1Vx7sD8eQqaZJo5F8Ikf4FckSWJxFtot/XxX3O8nfK+RYVAzsVXxpM6G370SmpaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

On Wed, Jun 18, 2025 at 03:16:15PM -0700, Stanislav Fomichev wrote:
> On 06/16, Mark Bloch wrote:
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> > 
> > Declare netmem TX support in netdev.
> > 
> > As required, use the netmem aware dma unmapping APIs
> > for unmapping netmems in tx completion path.
> > 
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 3 ++-
> >  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > index e837c21d3d21..6501252359b0 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> > @@ -362,7 +362,8 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
> >  		dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
> >  		break;
> >  	case MLX5E_DMA_MAP_PAGE:
> > -		dma_unmap_page(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
> > +		netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
> > +					    DMA_TO_DEVICE, 0);
> 
> For this to work, the dma->addr needs to be 0, so the callers of the
> dma_map() need to be adjusted as well, or am I missing something?
> There is netmem_dma_unmap_addr_set to handle that, but I don't see
> anybody calling it. Do we need to add the following (untested)?
>
Hmmmm... yes. I figured that skb_frag_dma_map() would do the work
but I was wrong, it is not enough.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> index 55a8629f0792..fb6465210aed 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -210,7 +210,9 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
>  		if (unlikely(dma_mapping_error(sq->pdev, dma_addr)))
>  			goto dma_unmap_wqe_err;
>  
> -		dseg->addr       = cpu_to_be64(dma_addr);
> +		dseg->addr = 0;
> +		if (!netmem_is_net_iov(skb_frag_netmem(frag)))
> +			dseg->addr = cpu_to_be64(dma_addr);
AFAIU we still want to pass the computed dma_address to the data segment
to the HW. We only need to make sure in mlx5e_dma_push() to set dma_addr
to 0, to avoid calling netmem_dma_unmap_page_attrs() with dma->addr 0.
Like in the snippet below. Do you agree?

We will send a fix patch once the above question is answered. Also, is
there a way to test this with more confidence? The ncdevmem tx test
passed just fine.

Thanks,
Dragos

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 55a8629f0792..ecee2e4f678b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -214,6 +214,9 @@ mlx5e_txwqe_build_dsegs(struct mlx5e_txqsq *sq, struct sk_buff *skb,
                dseg->lkey       = sq->mkey_be;
                dseg->byte_count = cpu_to_be32(fsz);
 
+               if (!netmem_is_net_iov(skb_frag_netmem(frag)))
+                       dma_addr = 0;
+
                mlx5e_dma_push(sq, dma_addr, fsz, MLX5E_DMA_MAP_PAGE);
                num_dma++;
                dseg++;


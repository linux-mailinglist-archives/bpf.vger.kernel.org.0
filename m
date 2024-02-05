Return-Path: <bpf+bounces-21257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E064684AA5D
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 00:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6460A1F2B976
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 23:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B933481BF;
	Mon,  5 Feb 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIVKbzf8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E23482F5
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174794; cv=fail; b=c2pLwJKGlt49r+Dz+xu6nUZ3WhY+sqR+yu+pzyefpuVifd1FNCi9CQ3Zhfznv41YwGw/fRJ0+buuslCKZOehmCUKd5FOLaqu6nFHgO6zlyeR0QbLmUJNGnr07yFsrAPSdVcawupzVe+GJLCP+wza8VKdS4IAM425eDwueFDckLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174794; c=relaxed/simple;
	bh=ICmioG6rlYdqjMKmRo3xl7Q0ZZG5Ly6FxRsiH/5IegA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hTc7vXgs7LRSTM1AFW3vgGUKgCrNO6znlqx1VhQP307DxDwAgncPsdP/6BF9Xhip2akNaCbWKJ2WdCjvUxYKPgSv9u5UD0uwAPo82V7oqv3wdzFDZJ0ljD6olv2RyMV6s7bvaCDDYfheH/44Eqq898rGn+0He7RJXEZUZGjbK7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIVKbzf8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707174794; x=1738710794;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ICmioG6rlYdqjMKmRo3xl7Q0ZZG5Ly6FxRsiH/5IegA=;
  b=IIVKbzf8Ywdf7m4JNLYuDkJdrxgkowIgXXZ2YgshVyN13OKlyZW/NLdz
   Abku2PnG5wEaSzP1ejoj7BFClhJ968SSAbptlwTGZjWZtzH/vNlMMpmTG
   g55kyye8CJzmWFP6hjx0ek7IVopRQSFZmW6Df7F70xoKlvlfgypacGFJu
   n/efkh7Tlz4S+Fia+G8aHREDgGOqZQ/BX9opEYqk0OnfQH7q9mV7lhzlM
   eh3htiIxZYUqxcZGBzGhoFNk6BUSgb3jqijpfgAIXpnynTevitLt3Bamy
   rC7Jrbv8BTnbp3San8uoCYLW5AMiI0VhYXZ+tzdN8hXKaJ2jjDShc06MB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18051456"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="18051456"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 15:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="823993304"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="823993304"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 15:13:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 15:13:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 15:13:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 15:13:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoQkzoDA9fNM2DdAMgOndKz23tOwBXayzakN0VlxygZc2HsSeYLaq+CLXXpTm3Pl5Hr8jea9+BipjiTmVdv6h3KToUYyAGqWq6HBOgrzPaWWJ6v2QXnKYBKx9kwvUs5tH8K22Smhz4uxetCxRG3Rsz/rhKXHj9ILtSanlGTTbD/mALfHDZRsdx1oi0oaRibxsXhT4R46BdMaWzWn11w8jy8ePUiCn6eCDxhuxHpx9r5qCeiCR9tRMCoXtokAMQ1Ky4NTqhgxP/4f5Q/n1BA8mvUr/L00usjAWd/Gejys0VFPxbFGxXdyyt28QgBbpAzUBGV+O95kzqe+c5jM5+Hbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP07GRYmEqgBmZFVYtdwb61MX/7aoUHuar7CrdB6eXM=;
 b=ibNT2HpwRAVmh0lEygY+RC3BKKrqZwqSIk1G2PjGOzv2w3iQdr+aYKRzfHsRmjcy7zJvLOMTpogjZsdonDXRjvrCKWTl4R7nXjhPQDdHSrWl7v5tPZvQ/FkZKYuZaasdosaeGi4B0D5vThsfIdUijr/WnybNNwVvU4ki3iXHjo9bi4AZO7RKJwiHafrtCgul5ezJIigxIKPRnR3zWX2hqtGVq1ojgZ4ifpx4dRPDJW3fWH7W3CYe9fs2yH85xGvbkDfTSlmWQ7+QwFYylkQI3plRO60nqf8FXyZoI0xqO8NvJ0Y+fDfdffhmDpV1eMuBiJ1pOG23cHosLdX9LpMFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 23:13:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 23:13:09 +0000
Date: Tue, 6 Feb 2024 00:13:05 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <bpf@vger.kernel.org>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, "Jonathan
 Lemon" <jonathan.lemon@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH bpf] xsk: Add truesize to skb_add_rx_frag().
Message-ID: <ZcFrgRdCRnGUmE+S@boxer>
References: <20240202163221.2488589-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240202163221.2488589-1-bigeasy@linutronix.de>
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 46453c21-dc61-41d8-c9c7-08dc26a004c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RYq8B/GuC2o0PZ7ZWJXRIx/cbKCHdKiEp9dqzFocmns4xndQPT80tmtrfhTyd9zoqZbwVimbsQJbM3TH94vFaDeGcFP0KjhZ918XUpUz7zzMIExVwqLFLkuvXllDzoaI4gB8ULswGZMjtxBp7m9M2ebMcrwty7h2hNglFXwr9WrljGKoKt22+0sIhZ5kaqQ1XDJHsj2wGSDU5nBV65Ou1w+YADU90kWHaZWOOOvnvp5YjSghdT8pJJ+m4lSjx1SMd8b3fPegeZWQByxMLE/fGSftzJmnFJOi876PgAak09pfrOKWvKBIGGytMV2Uu0MmEhufExy1H5qqiX/O/BFpLUfBMwPvQpPBj+7Udpd8O51EzZEcX3zkpGHGuf/+8dPwTqSOBnR5kECeFcdPq7hoSPY7IDF+FtwgBH4RWjHhDJ/wgoRygSZoKYPBWG5W/cu2Xy8fsI1GD/1LyNzbnHMFDmJiljygi78yqKOZ12FmfdxIiuUC/iU96Yf8EPcdvT7xCBIGESyWHxFZrOmrMUQZTQ9eEri5HIMi7h4xTS2cFkFCmWBt0R5MYZnfXB7pVw+gwgrUOz20MmnlZoq+erTmPixNAgL+cqHA2YEepaek5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(26005)(6506007)(6512007)(66556008)(66946007)(6666004)(66476007)(478600001)(9686003)(6486002)(33716001)(316002)(6916009)(83380400001)(54906003)(2906002)(4326008)(8936002)(5660300002)(44832011)(8676002)(86362001)(38100700002)(82960400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSGmyyerkJBM193k13RESm7sDSW4kRtg7FLUNHlDROgOnh0/9DQkDfSmmV3A?=
 =?us-ascii?Q?aO81mPSVpTIX5iryB3C8kt3ZhTTBVwWzL54kCGmMt2EqES5pj923Eh15yVUD?=
 =?us-ascii?Q?shX8JnavuNStEVrXR+/6wXoykKGCXT4yx2wDaiJUbScw1ed/3Ok9cKLh5zN0?=
 =?us-ascii?Q?S/Glmo6RIU52LZqnxNtN95/9N/QReT+N09MSrRSVS3xcEgLQRuUQivT7W56B?=
 =?us-ascii?Q?xcBjhI7PK9d6dEdoEv0vZGkcv5NM7pZJyyVRqf1EE4LG7IPnGTf9yKcmZtoL?=
 =?us-ascii?Q?1ZyWulK/uxGStHn0BeKglqXXxQlN1vgGwksFn0g4hWwXz7DMtXeXn/3eNtGo?=
 =?us-ascii?Q?7MEEpKxVC8oS1WudPl4mwFiCjmq8lLDqzy4tKMSizXGeOzByg1vh2g/Ub6BM?=
 =?us-ascii?Q?y2jKB2QgFKqiOM0+JuRF6U5hIMH9Usgv/HNceQJswXnDUWHwYIUEOPM6F3Pz?=
 =?us-ascii?Q?l1rw1lEPobs1lU4zH8FFuz+PyFjaVisoFB1iHYzhuSqDhJbCeSNrU8HEG4XJ?=
 =?us-ascii?Q?pMAGS/jZtg3Bazcs8sg/NZYWDqzhoecaBwchw7NuTG30ZpKUD46AVjYjEo8N?=
 =?us-ascii?Q?LGGw57egcEcF0KaV3eRAThW/iTeM+RWUdyJYCclpIecRRM9xdiIbiN1lb1x5?=
 =?us-ascii?Q?u1wD6QlxnYuVbiuZqzO6gIXzoZgOI1+acPA4VW98IRXxKKhI21MxLHKiHUsY?=
 =?us-ascii?Q?HYUwHN0i1dPKcI+UDyIcczdhOBLWxaF/2Ml2/h1ipRptoM6yfIIXiS7BynNu?=
 =?us-ascii?Q?tjFPVEmYcqp6T70rhV7nbQyqIIocLnucnHWxjzFGXeHX5kt4imzWoAn9BGuY?=
 =?us-ascii?Q?7aEqOk8By1dRHqCFcHLwuEs9aKAQuZ1Z3tsKAGxfCwDw8cGJAHmm7vXgXntR?=
 =?us-ascii?Q?26Q0IoV0SBQP0wQ6H9zRXvDylbFtXx/cyb7yKyspqPxD2YjgcKbYKKBsIzp6?=
 =?us-ascii?Q?wvoWVNt3fdWccZuXorJLzUyOwzmoJW/MjJ0H54N3YvMEEdUl7R3T16/fws2A?=
 =?us-ascii?Q?VfgwSqUVnjR/Ttx+CVPh7kkUlKX4etU6cvzHTsOaALSnfPxehhUO7+xqQLLh?=
 =?us-ascii?Q?tqmcM9uFocsPuPYtfex9CFBUTeyTlxcvk1cSc1Ocweoc7veDFGin2sl+ZYez?=
 =?us-ascii?Q?0jUdbjuOfkQojXv/Ntjx808yX6Vxc8auKQv2vivCmaB3as0mtxV5fjut887/?=
 =?us-ascii?Q?7sBZffSDgUxH4VjAbcgAby2jIFwDNqwDuvVsoobEFOKHtfP8Dmy8d8Ek8GT5?=
 =?us-ascii?Q?s2At8zcMdIQ32WBhbxnxTq/lrGk1+mfbAo1U8ixgsh23rN7zRT3QV7oVzV4h?=
 =?us-ascii?Q?2iqvXIC6lCcqYIghKgY31S99Wj1mcQMB1EiwrEzp/xfASaCB4EsuvrkLCnDC?=
 =?us-ascii?Q?w04GLWp0NcW8Kq57zFFcKeVKcm2LF+KteVnZJB3baTFoHk7A3U5JGPYbh5ZU?=
 =?us-ascii?Q?m8yKtunXAgOMXJMO6LJRSwH0o/vJ+rqLHobE+mmCn2GAslkCUqMiKWgwbzLf?=
 =?us-ascii?Q?YPiuMcB7MDb4DIDXn6fqhStxtZX5zFTNIXQuI0nuMxx9JCUk2xlGv4C0aSFH?=
 =?us-ascii?Q?bVmuNKjN+TgqNkHfVa69dCbdsx8+WaVxgv0AkjlrL2GKPegkuh+w9CmR4iEI?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46453c21-dc61-41d8-c9c7-08dc26a004c9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 23:13:09.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ETfT0U9YYE4AGizpM9UIXF9Jc2L8NEYA+DiQqhn0r7dNNywuGmU39sn2LELX9ZmIQJiP8uJNhIrwc8a+4jlZiYNrI9Fw6S0wjpMz13Cs0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
X-OriginatorOrg: intel.com

On Fri, Feb 02, 2024 at 05:32:20PM +0100, Sebastian Andrzej Siewior wrote:
> xsk_build_skb() allocates a page and adds it to the skb via
> skb_add_rx_frag() and specifies 0 for truesize. This leads to a warning
> in skb_add_rx_frag() with CONFIG_DEBUG_NET enabled because size is
> larger than truesize.
> 
> Increasing truesize requires to add the same amount to socket's
> sk_wmem_alloc counter in order not to underflow the counter during
> release in the destructor (sock_wfree()).
> 
> Pass the size of the allocated page as truesize to skb_add_rx_frag().
> Add this mount to socket's sk_wmem_alloc counter.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks a lot! Of course fix is totally correct.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> Noticed by running test_xsk.sh
> 
>  net/xdp/xsk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 0348e4bde23b2..3050739cfe1e0 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -744,7 +744,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			memcpy(vaddr, buffer, len);
>  			kunmap_local(vaddr);
>  
> -			skb_add_rx_frag(skb, nr_frags, page, 0, len, 0);
> +			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
> +			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>  		}
>  
>  		if (first_frag && desc->options & XDP_TX_METADATA) {
> -- 
> 2.43.0
> 


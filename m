Return-Path: <bpf+bounces-18861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA05D822CA2
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 13:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76F91C2197B
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C95818EB3;
	Wed,  3 Jan 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJbSdqpM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA718EA0;
	Wed,  3 Jan 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704283521; x=1735819521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8EThJZcMkigWCsCQXFFluagiibC5dUw4m6J3qD/xOVk=;
  b=GJbSdqpMryR+2NQevgGU6oYAeC9OeEieVmukOUkchhQWCftmeZW6dErd
   uIcvNjDyIIHlYPapfLVpU9S7biyKWYv4HYRp69+pegvCcpuR0J543tH34
   13nMquaK5vpqZwux/DBvNVUB/yP9oaKlYz0FCuOzQa+D3g6+SUriclcHx
   A6SIXDjKQX4TANmtn9hcnb75a00xzB9j29erDOgS5ferju7LJQJrjCxOv
   rU2yAwSK0q7m4x7CsNxv++BD6sJwlMuBP+6GtVHsitBQoS3vFj7l8E9cs
   gPCUZ97i4kssc9lCAP9KWt+X2HkApzgs6eeV+/eJBqqrSzusTF9aj4e0L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3822942"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="3822942"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 04:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="845860347"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="845860347"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 04:05:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 04:05:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 04:05:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 04:05:19 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 04:05:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh/IPngo2Ij0BahqVGygLDp5G+Sdk8WLz5kni6D3/ye9F9piB0OjTwpcBPo00ULr+ueHHLQU0hfOfRJHQ5HMi+3WtTt5HmJXvneMRPa+W2Sa9CXflUziCk+/7r7TNgrPpvPP/cnS6lSj2JKlaAUlV9yd38DA1XfQqbFSIHbHY6e8bbwleWiPGPCUlamVsmDcGHjZiaCoG45X9Z9IJVPBApHMso7kXeVSXztLcPRfdQ7jQ9O+oLCNka3TPAczqPOVHofc0ayXbQVqU1/5HmS00QpeDkFTdFl12ckb5FRtSq4vVCKV/qyd8X/SfcU849T1nur30TJikqbp1OhVovDTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gEmxpqEdcdC8snn41i7Qn/PY2J0hRIGoYIVi0hlNNY=;
 b=A0Rt4XZ+7YRBEcRVtIqg4XS9HdEoBCq7wSzZ7pXkMgGJTls/qwQs+vHGQzNV6oWD1LUxI3lqlw9qZkV0Ldv1Bfx4u1/oY7Oh5/vh+BdIIFjdsPjChEMCEq15Mse9ej3DY5YRhg3u0TkwsTxwdL7nsfSZnNnirH1jOqT1DyTtjDgN6eOe51YnxMeQC6W33aS9CeMYKMuMIVqCkPBgb/9XIBptu/eOddCpdlXqHh2S8YNHuKE64nZqLI9svj/1KHaOm1sEPdwn7+zcCGH/jMcGQDmot5YWhK+iZrN3UXectmDRR0no+fpMMPSkK5wG85w1GiEzmR65gIL/QRvG8ApdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB5581.namprd11.prod.outlook.com (2603:10b6:a03:305::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.14; Wed, 3 Jan 2024 12:05:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 12:05:10 +0000
Date: Wed, 3 Jan 2024 13:04:59 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <bjorn@kernel.org>,
	<echaudro@redhat.com>, <lorenzo@kernel.org>, <tirthendu.sarkar@intel.com>,
	<bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>
Subject: Re: [PATCH v3 bpf 2/4] xsk: fix usage of multi-buffer BPF helpers
 for ZC XDP
Message-ID: <ZZVNa6CN8Y1KUtNM@boxer>
References: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
 <20231221132656.384606-3-maciej.fijalkowski@intel.com>
 <dadb229a-d811-4542-a53f-3a78e559e639@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dadb229a-d811-4542-a53f-3a78e559e639@linux.dev>
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: a61bc432-a389-4f20-5c2a-08dc0c543bce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqGW0Phe3xnAa9LU1j16+X71paD71lKj9ztPdUocDJvuhAfu+vHoZyoYRxl8SDbSCOOsy6U80ZCDcqMZx27UPqU30QvctM0xOXBDBKklf1V+oqDxQflA+Xgkm83hUAa9Q19Vj7JBhIWnuIHcMRa18HZZbSZP6EZyHyJOq/l0e/TcNbF5fyC9VFQPp2Rtu0QLar0CqUp8LoF9kiuEZ4CGuVlPMS79znVxbRUepNQ2d02QWrs1QKxsNXX7J+MRJrbU/TIjf9qZbqaKmKmA3T1GH9sR4RQdi3NfIx2hh85u75RjaeG8NdxG56vI2vuX2ujIhIAiG0+qnzL3r0KtAYpW0CsrcHkLDUoVca70d9VfK0isn0DXwUScmZul6JCVKE2sKkkd2cf2rnZ5XFxbyfhP6tdHCkRoNJBzBQOK/x8GNgi7KeXLsnpWtYbph45MdQGNXlEKN7eJn/l/Weg6QbZLModK10xSQpGp1SYyD0+IJgYDWu1xyuVdxGFeeuvXFWoyBx6cOG2504cykFseaHVFz0aYg1lu1aeg005IBni5CssmsK2J3bro8r48qAKeO0a7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(38100700002)(44832011)(82960400001)(26005)(6486002)(478600001)(33716001)(6916009)(83380400001)(66946007)(66556008)(66476007)(53546011)(6512007)(6506007)(9686003)(41300700001)(6666004)(8676002)(8936002)(86362001)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Q8wGMyuHkMQ5jj1ZQVMg4IGV3SrEsw7yZ5a3q6PZ5okvvegJ8A7qtD6g69n?=
 =?us-ascii?Q?gUnKkeGYqI8wI+oCtEgeRx53uL4DGM1Yy7xJ5e8OGFEEISrteY8QmSUDFqFi?=
 =?us-ascii?Q?NLlYO5ni6EFzu3dkHLqav11JRAPzK5FvNynnij7hVcxDk4PMsNkZtljimIKV?=
 =?us-ascii?Q?UVue05bP9O5lmX2T3D2m7PO4Dyi405Lvc2VBIlo9AysBsg4I0GXyh/lSgLGP?=
 =?us-ascii?Q?XlhFaDUawZDRZQKwrK97nrAAz4BNp6LMGq/GbHIZKWCCemMzgK1Rf0xd0z27?=
 =?us-ascii?Q?an+3ip24RuwFG2ZDKsfKyNr9jnAOQUhyFaMISAP6dBYgVFnf4DFdpVwj9k4N?=
 =?us-ascii?Q?WOgyTz/Jin+/UUEkBJKDhKOYjgBeYYmeqgHou/m0y9Ne0HdT0C1qlgnVa1Bq?=
 =?us-ascii?Q?w1SlNKHob520ZQb+u5uNWbok1Y4ira+pPYv5I7Jwley+z3KXcSAzKr2ZJtZe?=
 =?us-ascii?Q?xaPgN3AlsbnAmbXg0tiwDc+I/U1br8PQROp9/EXpZuS4nwFcoxC+imLZELVS?=
 =?us-ascii?Q?fEYWbYd20yjmnmq41sTowFCKYy5yyzWGaFG5eNVxIRcHXSqjYT1iA9zK0lJw?=
 =?us-ascii?Q?LTDZjDLHGDt+GybzfCUtEQ9lrwIoCLAMWxpNWc7V4FwGZAYZbObjRZbqQp10?=
 =?us-ascii?Q?F8aOU9waMO/ggFlbhY+BS+CEzmzCz/LDexwUSv3D9O9jGiidovYIlNXpsMQd?=
 =?us-ascii?Q?rLAfj13GExk/HOe6sEgfjl9MY1En3YdMRJP8HasTtegyBpe6HL1/Aqx4TtKO?=
 =?us-ascii?Q?a49XKpQCsX1h9rUpFNESDFnfKihZbPX3cfqjeDTJLQ8coXMNNDZrJBRrM/e8?=
 =?us-ascii?Q?JMRz/TuO60xVXnvvFdOnZS4DNZgVSSaqv47c0Ym6vVBz1yqYtWmscx7RnZyP?=
 =?us-ascii?Q?/MHURyL/+uFcyXkSg20XUKj8wUdbXZLjQ0H/ZBF+jD1zUdUvE52Twpp+qngB?=
 =?us-ascii?Q?GUbaJiMd27KT83/JJEMZI1CdM2AJ5VMCfRBo8BrmN24A7gGG9c/VwwuXsjsg?=
 =?us-ascii?Q?tCmQahJ5XfZInZ2DsZ9RZ5aPW6jTgWln9boicjz+TZEA/EgHNuDaV/J8nCdA?=
 =?us-ascii?Q?O2/Gxd/0Jq3tlj8yVacey8gbD65F+ozePKjJ58YtDNuYvF7uPwoO3ESYZl24?=
 =?us-ascii?Q?KQW79UAeCpVFEFBq/qzldDRLAClAl66/Hg3N9uHQF1PcHiEhoBJ9+3U6WF+R?=
 =?us-ascii?Q?gLdA+BKVduzB7KODIYXJrx7SW/76SlHLAKntfxhRlM4HKhrjDwGIxJPWc3F3?=
 =?us-ascii?Q?PFs0gQplnJk+KTs5EV7qsWHqgX3UT7POfbl7eLSry3CkzDfqfp4Hd+NGCV1s?=
 =?us-ascii?Q?CrkDknur2X0Wa08bsIFI/vv87E3/i/liPjXKA/V161SGkoAkrfB1vfXKI5Zv?=
 =?us-ascii?Q?AOa/jh6gfRyQd8pjVX0BPRC1ViDlXjQ5zIo9J427EZwAffZlLB7zS3kkgqpP?=
 =?us-ascii?Q?JAsNdarMRgwQyebfhin+cUCfCn/U3pNb6xGxlufCrtj/dvP39vjaUWCxMZb9?=
 =?us-ascii?Q?NF5PLKe0mqXYdjoFFmA7UtdFS/hqVAZ7KcKP3Nh/ZkrYHEXUKxtI6obUhk2G?=
 =?us-ascii?Q?HS7MFdJOi83aYhONuSJSJ1oO4tTg8xecCLbJVDqZqrm3rKw1Xg1sz9JP9gDg?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a61bc432-a389-4f20-5c2a-08dc0c543bce
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 12:05:10.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwx5ln4zgJv3sQb9yyiIbWJl9UJ1rYiEFqfTCVSHI8gv8seZllvoAtJ+HM4asbOeDeJw8xXEDIHQcHvcu6T42C6XWnqBScOfMPFqy/pB4c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5581
X-OriginatorOrg: intel.com

On Tue, Jan 02, 2024 at 02:58:00PM -0800, Martin KaFai Lau wrote:
> On 12/21/23 5:26 AM, Maciej Fijalkowski wrote:
> > This comes from __xdp_return() call with xdp_buff argument passed as
> > NULL which is supposed to be consumed by xsk_buff_free() call.
> > 
> > To address this properly, in ZC case, a node that represents the frag
> > being removed has to be pulled out of xskb_list. Introduce
> > appriopriate xsk helpers to do such node operation and use them
> > accordingly within bpf_xdp_adjust_tail().
> 
> [ ... ]
> 
> > +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> > +{
> > +	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> > +	struct xdp_buff_xsk *frag;
> > +
> > +	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> > +			       xskb_list_node);
> > +	return &frag->xdp;
> > +}
> > +
> 
> [ ... ]
> 
> > +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> > +			  skb_frag_t *frag, int shrink)
> > +{
> > +	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > +		struct xdp_buff *tail = xsk_buff_get_tail(xdp);
> > +
> > +		if (tail)
> > +			tail->data_end -= shrink;
> > +	}
> > +	skb_frag_size_sub(frag, shrink);
> > +}
> > +
> > +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
> > +{
> > +	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> > +
> > +	if (skb_frag_size(frag) == shrink) {
> > +		struct page *page = skb_frag_page(frag);
> > +		struct xdp_buff *zc_frag = NULL;
> > +
> > +		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > +			zc_frag = xsk_buff_get_tail(xdp);
> > +
> > +			if (zc_frag) {
> 
> Based on the xsk_buff_get_tail(), would zc_frag ever be NULL?

Hey Martin thanks for taking a look, I had to do this in order to satisfy
!CONFIG_XDP_SOCKETS builds :/

> 
> > +				xdp_buff_clear_frags_flag(zc_frag);
> > +				xsk_buff_del_tail(zc_frag);
> > +			}
> > +		}
> > +
> > +		__xdp_return(page_address(page), mem_info, false, zc_frag);
> 
> and iiuc, this patch is fixing a bug when zc_frag is NULL and
> MEM_TYPE_XSK_BUFF_POOL.

Generally I don't see the need for xdp_return_buff() (which calls in the
end __xdp_return() being discussed) to handle MEM_TYPE_XSK_BUFF_POOL, this
could be refactored later and then probably this fix would look different,
but this is out of the scope now.

> 
> > +		return true;
> > +	}
> > +	__shrink_data(xdp, mem_info, frag, shrink);
> > +	return false;
> > +}
> > +
> 
> 


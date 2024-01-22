Return-Path: <bpf+bounces-20006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7413A83651D
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 15:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2462528DA07
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF13D38E;
	Mon, 22 Jan 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/qC1PnE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877073D0CE;
	Mon, 22 Jan 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932502; cv=fail; b=NGM4eKxrxAep83mU46rm/EWenRfm16+BfIeY3VVeFD+Q+KyTvkmWZq91eRTX8XZs4mQU3fDvezgMxQ566UTc3Kzi/a9KHaNNpnrpJxaslr925DmpYQfhR/gtL8wEnF7VoLn+a1Wb0X3r1Z/iLWqnlcvgJbYFVVdviXkCfuTX+/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932502; c=relaxed/simple;
	bh=9u5012Wh21UKzcSLspVNNnrWGEZe0ZkxBmOqzPWgdYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WV9CYxog/qoZL47JhGfeozGPlVh9tZeXXqAP3SBobDWR1p5QWgxyqGFZ3QYHIrRf6WTNutqTtsJkTVnUK8nx3klUhlAVucL1qZ7A5DeN5OT/uIDvwoQiKsKlr/Ytxed1PWfBtgiE9/vsQ93VmjTAXcXjAZTG3i6QeJVZHkbGT/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/qC1PnE; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705932501; x=1737468501;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9u5012Wh21UKzcSLspVNNnrWGEZe0ZkxBmOqzPWgdYs=;
  b=I/qC1PnEIG0spWl/xk2B6K5+CEFecmC+nsENzBbG6kVKKQA+4o749bD7
   9uFFhE9ib8Sofyp1+LubNkKVa5yTsC1+1J03RYkfqrCwpxfYLDpGjEO6q
   Tas44mWEekbKUJFxXJK5Zzzlqv32uJ1JJBbe4dNunwfYT6J1ZcWyRgSaA
   Tn4ilDixqDUr8XPn6FN1wCU6XTTqy44CDEVRASOj9trScFCCpdvxO95bB
   uR8S7gdIAczglW75RDZCfhjD3+L6vDq/H/do1mZiCPp8L/DmzCZz4Icgu
   1S3x/CjCrvxWIgFpQ6RSneI5V8mZUhulK7w52RJEJF0MemvtdOlMcLcpK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="106922"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="106922"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 06:08:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="875985139"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="875985139"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 06:08:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 06:08:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 06:08:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 06:08:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjloOObe4tT2sPnw+uRtgRtY+JvBchNpmZaGTJiuznOnrs8ZkuWZaPC+ZJ7HvkKtKBDNCFhwqlWpHDHMzzmQFXgPwZTGLKmja3ntms0YvoCbvtR6r4M1R8CV7oM5XzpV7m+BdN5s2tUhikA2McO0kOIw20mM1F7i0EJ8oj5a6cdGv+eOWgwkG4wzwlbXcYGsLjfZCHkzkEtOhRXRYXCTdPn2PL5TVJhpD9VQvf+KQkZSCdqxzKl4yLoFcvEuXn0mk4iK9M+ICt79BKrZbo2s4LLIXYfcVDM3Hz7l9WDPVS0W+YyMlnXE64yUnoH+whVHdVWalwBfSYSuM0JkGnFsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9h7ifSDQ+elTgq/7i5fl2I1V0G0QpT3MVc3A4BQeF4=;
 b=XnB+nvL5f4AtZF6uyeyv2n3L5ZoHeZOg0OiOnzMMBMiWtlHzqUM1sMADN6fVeT7ygceZtcU7BFSp17StygKq6eYDhQKV193jgUiObmI9kzK3S/glWaKbaakaVEdBeGY1oc5G5O3jq4B//19OsAS/QqmuPJDjuDaTGIkcNQOC4t9WjjCuNQuzeQ04WnF7PhCgvhZK0GjPo8zww9+JM8FOGSoVEGsrv+7vqVS5LRIosFA2XW6h0JWY0PAF2guIursq6AqbCsZjnFS302AuQ71bodoJAasUcWeI0WTZA3abxGfA3su1TcwXqS1vowuo1bEeubAwU0TB7STKzi5W/81u/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.34; Mon, 22 Jan 2024 14:08:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 14:08:12 +0000
Date: Mon, 22 Jan 2024 15:08:06 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
	<martin.lau@linux.dev>, <tirthendu.sarkar@intel.com>,
	<john.fastabend@gmail.com>
Subject: Re: [PATCH v4 bpf 05/11] i40e: handle multi-buffer packets that are
 shrunk by xdp prog
Message-ID: <Za52xrO7G6AVG9SG@boxer>
References: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
 <20240119233037.537084-6-maciej.fijalkowski@intel.com>
 <20240120113541.GA110624@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240120113541.GA110624@kernel.org>
X-ClientProxiedBy: DU2PR04CA0223.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 05efa3e3-763e-4795-025e-08dc1b5391cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nf9TxNdyNqUj85ZWgyJ91eBf/GFnRsHZh3IYLR85+Zja9h6DYFbEX0Ei3lgmP983NP6PYk+2EgQ64em1NRgnSpLvwkJEG1tXblncHdt1S1bF4SIV0ajfl9OmL4+eMLr0/sZ2AWeC5vtv8CxlbJQx8t6tm0OcL8uMg3fifZzGEhsrGVdryYqANaWsRA7yP1CGb0lIJfYp1i1Ouiim7oCHipgpNESeNiPmwfaphGmcfkG3Prim9YVBYkc9WZIAWW6DGihPOPhW+hHBrwAYofDL5g+ZCGuEXrQcoBJTaB85t71GCXS/z/mdOoCCrbuPq40/9DqQtLpo64ucII7UvcGh1mUId5qNO5/OrxLZAMi8y6EOwyDhF3wDt4GFjJU6O1rHNdLgQ8OLPd2tMS3w7w13EMmN5IGGUJVTgKetu/Fnyi/ZuRWZ+rbc80VsFf52XuibzkfVWlMSbkXmRzRq853MnDW/qeIK506HaZacvAXDHkjhva48gpAwqZlv49PHMh9nXMaVFu9vaqEAVCcCqdSKyI079maF3tU7kDHGGML0cO5PaKp5g5lOkSKPitkBc4Je
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(2906002)(7416002)(33716001)(86362001)(41300700001)(82960400001)(6916009)(316002)(478600001)(66556008)(66476007)(6666004)(66946007)(9686003)(6512007)(6506007)(6486002)(4326008)(44832011)(8676002)(5660300002)(83380400001)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4hzsdwddKTufrDaNpa1Z99zF4s+0lNPX1UID11BB3ouVKYIZyWpzuNHajLo?=
 =?us-ascii?Q?JHy3QqXu1F0mXj3MLnTBlO62hxRiJl8Ji8BlOoyR6PAUruGy4tRXim7Gs6qU?=
 =?us-ascii?Q?RRZdrI9ydUexdftEHL2Zy5ApBw9xAUZ50C7OViMRDSBgO3bxVzbJbvyGGtS1?=
 =?us-ascii?Q?VyiCgJ5jz/WhGK56ncBaUCevoxHIrYNWncJPuYd+Z23yPJMW08PU9oCZfus9?=
 =?us-ascii?Q?egImPkPXXl+VSWdtqiMuuAEyHHGAi04jYgM0zqsZW5Ghcjhki/W8JkPACmRG?=
 =?us-ascii?Q?5RtXM/dyf6n1X26/kRyEUqdxuUhYOjkE2P/JwVij/Uzwp7jlMAJh93g58PUG?=
 =?us-ascii?Q?T4EnH0I0uPr5nohfTVJsKMZny3i5yypdBIFW+vAiTc+1ay2mGpsVy6Fs7Qpr?=
 =?us-ascii?Q?L763yJgqn7zxaP86Y4GbJ2geGHKBFtywaI5GcWADTR8sX4On2kxEWzF5RQcI?=
 =?us-ascii?Q?hXCjpZkJbQ0tpUxEPfpEO8DvbbAG8n+iPf5QefftJvW45m9aDCx5a3K1CNSM?=
 =?us-ascii?Q?D5MKwRytH1ee+o4XPIGqomtCMT8VbLWYynfTwZIFg8DMRMCmbXwFzN5y65D6?=
 =?us-ascii?Q?y0diYqFp1GHlNWcOeauJcrsWDL7J/OyP1XVRuiKxCykiLBERH1TgEMSnbprw?=
 =?us-ascii?Q?40czQpVENaIK/Ty01DizBYk03Fp8NKv6gmsAHDd+OH3+VJmoDEdoNHfkBbvC?=
 =?us-ascii?Q?/rA/uCO/BUew940JQVutQWgVH+PUqdPb/wVYhhvJfCR7hX+Px8Ll5v52naF6?=
 =?us-ascii?Q?nAbZP7H0PhHSEs//6S0CNyEchY598h7pNnHud70OzYTP2vyp72M1K8bomK7D?=
 =?us-ascii?Q?g9+jyuWIFPmx8MB8fDlYiYlQBIoDyfgjwyAZ6+7p8jjzsJW/z13C/sjwMnct?=
 =?us-ascii?Q?mnuyYUU5hLAxPiQktkSL8s1NOA1YDZYam0KXlgX6KYJmFwDHs2Sq53wcORGV?=
 =?us-ascii?Q?e5ZdCdNBx1GDwyZtClV807q4epsrTVl4Njd+WcqnWquOr0hOpulwcnjKaESo?=
 =?us-ascii?Q?sZ0AdtN+wZ1OlFulNvO7OutzK9KU1tY2ewWyjBXjFRZK10AlcSdQrKKUWrOM?=
 =?us-ascii?Q?T5rpupkfQ3KFyzE09ORyeCfnoQZ3KoWgIf+w9hQXghDzE23ITH1WYvMcXImc?=
 =?us-ascii?Q?Cs0TdQMQnXFm3MPkO8sE+dIpO7WaxJHdcfeRbZoeYrcwLLkUS1oD0xdWCyze?=
 =?us-ascii?Q?K/XlsJlVQ1axMpdeOzwJYnFLMh1EIkww9BRQbnO9LARHQaoavVMqeX8Gvg00?=
 =?us-ascii?Q?3rmx8LJrnlh29hJ+SDrQOPlJD68k0MdREVhxE9v6FN6sXFpCtFZdasUujVHY?=
 =?us-ascii?Q?KhcolmfK893hT42g1o7+lrKXic+giCGNgwbP0nma6Rz2eS2Vu4jGYLyV3rPa?=
 =?us-ascii?Q?8rzwLiGwhg8EqYd91+37cJQy10PBmPLaUTlLR3PeK/9wQlyYnRpES4lzlbpN?=
 =?us-ascii?Q?6Cgy6aXWWPH/c0mlGQ7dRkXXSmGLz8wlEiCEGTW+hj6ln/pnPvIPZyfwZiHk?=
 =?us-ascii?Q?dHXPVHhpFk1ooyC7g538vY92M2oB8iYPfATchB5wTX0IQ0tdoNuiU5vowKa3?=
 =?us-ascii?Q?MVoONqAjm1Xlz+IgRdCLBsTOPSezK1Cdo9rcqghaIksxXDuJnMaNTlRNTW7Z?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05efa3e3-763e-4795-025e-08dc1b5391cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:08:12.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JORI8/Q35LGjz70i8NgzM/8yQQs+X0nT7qmeoSHQu/Bx8Es0HfCTgrp7fIGzs8IQpg4NO0hqLlnKa0r24YoXPe91hRzKvOJCa2VSMMnoLKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com

On Sat, Jan 20, 2024 at 11:35:41AM +0000, Simon Horman wrote:
> On Sat, Jan 20, 2024 at 12:30:31AM +0100, Maciej Fijalkowski wrote:
> > From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> > 
> > XDP programs can shrink packets by calling the bpf_xdp_adjust_tail()
> > helper function. For multi-buffer packets this may lead to reduction of
> > frag count stored in skb_shared_info area of the xdp_buff struct. This
> > results in issues with the current handling of XDP_PASS and XDP_DROP
> > cases.
> > 
> > For XDP_PASS, currently skb is being built using frag count of
> > xdp_buffer before it was processed by XDP prog and thus will result in
> > an inconsistent skb when frag count gets reduced by XDP prog. To fix
> > this, get correct frag count while building the skb instead of using
> > pre-obtained frag count.
> > 
> > For XDP_DROP, current page recycling logic will not reuse the page but
> > instead will adjust the pagecnt_bias so that the page can be freed. This
> > again results in inconsistent behavior as the page count has already
> > been changed by the helper while freeing the frag(s) as part of
> > shrinking the packet. To fix this, only adjust pagecnt_bias for buffers
> > that are stillpart of the packet post-xdp prog run.
> > 
> > Fixes: e213ced19bef ("i40e: add support for XDP multi-buffer Rx")
> > Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> 
> ...
> 
> > @@ -2129,20 +2130,20 @@ static void i40e_process_rx_buffs(struct i40e_ring *rx_ring, int xdp_res,
> >   * i40e_construct_skb - Allocate skb and populate it
> >   * @rx_ring: rx descriptor ring to transact packets on
> >   * @xdp: xdp_buff pointing to the data
> > - * @nr_frags: number of buffers for the packet
> >   *
> >   * This function allocates an skb.  It then populates it with the page
> >   * data from the current receive descriptor, taking care to set up the
> >   * skb correctly.
> >   */
> >  static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
> > -					  struct xdp_buff *xdp,
> > -					  u32 nr_frags)
> > +					  struct xdp_buff *xdp)
> >  {
> >  	unsigned int size = xdp->data_end - xdp->data;
> >  	struct i40e_rx_buffer *rx_buffer;
> > +	struct skb_shared_info *sinfo;
> >  	unsigned int headlen;
> >  	struct sk_buff *skb;
> > +	u32 nr_frags;
> >  
> >  	/* prefetch first cache line of first page */
> >  	net_prefetch(xdp->data);
> > @@ -2180,6 +2181,10 @@ static struct sk_buff *i40e_construct_skb(struct i40e_ring *rx_ring,
> >  	memcpy(__skb_put(skb, headlen), xdp->data,
> >  	       ALIGN(headlen, sizeof(long)));
> >  
> > +	if (unlikely(xdp_buff_has_frags(xdp))) {
> > +		sinfo = xdp_get_shared_info_from_buff(xdp);
> > +		nr_frags = sinfo->nr_frags;
> > +	}
> >  	rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
> >  	/* update all of the pointers */
> >  	size -= headlen;
> 
> Hi Maciej,
> 
> Above, nr_frags is initialised only if xdp_buff_has_frags(xdp) is true.
> The code immediately following this hunk is:
> 
> 	if (size) {
> 		if (unlikely(nr_frags >= MAX_SKB_FRAGS)) {
> 			...
> 
> Can it be the case that nr_frags is used uninitialised here?
> 
> Flagged by Smatch.

Argh. Picked the old version of patch from Tirtha. Will resend with a
correct one.

> 
> ...


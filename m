Return-Path: <bpf+bounces-20222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE5583A86D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 12:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EF91C20AFB
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 11:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936151033;
	Wed, 24 Jan 2024 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOzjwZJz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195150A8A;
	Wed, 24 Jan 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096578; cv=fail; b=OSZ38IUDK+W0BVvW4WvL5l39jwokZ6wlwHGto7sSeXjY83P4EgD/fb0/DZJyR5d1gUxxbtNFv9iTLqwIT1X+PnI0wxT8p7nrEXuC6V16yvulhpC9mZVFvduuXMIlllFmrC6omzPofhL6fkIQj+41/TOXWYmOwignlOaI/l6kuf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096578; c=relaxed/simple;
	bh=fFd2m8JnQgwVe8iY7MGkML6lSv6VHZB9rBIRB0RWqGc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DrtrP1EBbSpVBs7rc1l+mUYh2DSH3vAHArR/pJdfFjNv42nHPWdNKgIsVm1WwSZ+Fbz4MxrhoYTyF79/mHFESYCJBq39R+4VQMwFq2oWUuWXxq4llf5mtwApDUJDvxFUtiH1NDdM+cx1PKBQjAarWFUs+jzG599GmhRz6tgb4iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOzjwZJz; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706096576; x=1737632576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fFd2m8JnQgwVe8iY7MGkML6lSv6VHZB9rBIRB0RWqGc=;
  b=bOzjwZJzgbw1nyjuYiTyycP80jTTsplnX4pLvjEufLhiOruIWVQ0Obw4
   sEIdsVdwrmf/ab+iMDOGma6vHKAGLL2p1q5wSpyftLVLhnB+2Q3z6IyZH
   S9EVn6dOeX0xl2a2FFSGh/oeBiLGREwFm1w3GiEx6Pb+WQiOpctgg0B/n
   UBUAnCvmcwkwysQ9H+VvAyuA1nPafVPjHNq97Rp7zYN5hUsdUHr679Cid
   r0n41RZkomA5kCav5GDsAxlKTN5Mn0j+Hm9OBMG3TdraJKYpp6zJRHMOk
   1bx0a0z2jiZ+hydZlCC2svbry/p1GxeqstbViIP+iqcCA8vIN+6ljlsZ0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401480797"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401480797"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:42:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735907245"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735907245"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 03:42:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 03:42:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 03:42:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 03:42:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhNIaKIKKadFM0XGRcm0PBCqiYVsCbIC6IRzqpsu6ry22tN7uoM12p4vMohC4A6PARSNyePDcGoOPMENjtJflxzUFnTWw1qy7WlXecvUPjMirRQkVQicLbcxVOofIt9jAKN7whFa1OzPZgTqM13R1ctk1OIVaiukmRacY4lmgyaiwnl48t9aST4s42czzZX9YnwrjhqWnZe0jHjaWQnTUm8IC/ND9yVuH5+vg8O1z6imY8g251ExD4liwtSVA5WPcQRH8ivVl2ROS1iWODPaMCeWV6nDdRDBwNGD0B6dLSLN3beTK8ah+lYAJOJnl8NElpGpFvHbRoyQWNEXX3O3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHVTKE4e4LdB53/nqKoL8q6lAlsaa43HkuzPDFKIVlQ=;
 b=F/rNX6fRaNC2NnH4YCgG8Fazfesw42bWwprL4Eho3Zn+J2dzKF1kt+qrPO4fXcBFuJ3f+0A8vw1DeXy/WpCpHchwJYRHrblzcxX6k74wIHIucD6QZAsCy2PO6doUczh5Po7Al7w/BcYanpbeqxxaPDFtW3IMVGEzZov/EegRRBvqZwNgxfM4yAZjB6vk1P6cBWYgWyWxoC3HNHWtzTUbYaTl3gWzF7vAHNKCTkaE/n5UWWnPOITxZJx4zEZQntB/0+kn6sOYWTiyZYaFdBlM3rMjoaEcVMJ3lggya9qv1Aqx0AfZ/L40OjE0Jwu33+pBK375Ic9si/K2abyxBK+guw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5445.namprd11.prod.outlook.com (2603:10b6:208:30b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Wed, 24 Jan 2024 11:42:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 11:42:50 +0000
Date: Wed, 24 Jan 2024 12:42:45 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
	<martin.lau@linux.dev>, <tirthendu.sarkar@intel.com>,
	<john.fastabend@gmail.com>, <horms@kernel.org>
Subject: Re: [PATCH v5 bpf 02/11] xsk: make xsk_buff_pool responsible for
 clearing xdp_buff::flags
Message-ID: <ZbD3tbiM/xD+aEJB@boxer>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
 <20240122221610.556746-3-maciej.fijalkowski@intel.com>
 <CAJ8uoz2W6nqJ=vk6+RR7zEohkv7CTBO+2KsAQAfgp=gf_5-ycA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz2W6nqJ=vk6+RR7zEohkv7CTBO+2KsAQAfgp=gf_5-ycA@mail.gmail.com>
X-ClientProxiedBy: VI1PR04CA0057.eurprd04.prod.outlook.com
 (2603:10a6:802:2::28) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7bb349-2982-4608-5158-08dc1cd19801
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3UkfLygVNzbKm+umgHMbacIl10nUdMCgxz/wiCaispFgITKHYS+t6eatPYKlx0FpEwKyfefF5hAoVSnMX6T8kDZWWv1HSFP/uHv/DLPAXFBQp6xFmbCRF6wErQQd9UNDNGXQOw3TRqGKGY0X9wzIu5JxB2YH0H8YaIW5oHhIICP6lw+nWce+GmCryDhgpZSfVEkTcXmEI5AkzOF0tdBvpkEFtgdvQwBNoAMIvdadzH+R7uG10321asbI33Q7yME/iSVNe0OnCBg5i/ai8WV0mfVoJW/44YZI5/fvxMRd8yymn4WCJfaAGQZ1FHKyFmli1TplOVhsM/MTpMB0uuQCPjFwGttS5vlsmtKVJvfJSAFuCSw9eWc2wVGpAruSEf4NkKSZQA9pAhJqoAAkm5yZ213TD/rN5P1FL5okR7+LMsvzT2w2Vq3VZjcdSe6mqvihe/hWY8IJtB2bNwd6vNT5EsQ5s2C5hcR3NrtfefnZM93yzBT5kKQpxZnHlYlsfCTENCVcqEEhVBIavpnrJRAoDHbmzSma1G6kfuszUTAb8kene7gRbTkn3bgkM7QwoOn5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(6512007)(6506007)(6666004)(8936002)(9686003)(83380400001)(33716001)(5660300002)(8676002)(7416002)(44832011)(2906002)(4326008)(41300700001)(478600001)(6486002)(66946007)(6916009)(38100700002)(316002)(66476007)(66556008)(82960400001)(86362001)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6kwT0Xf8F+CNTVywovvivE5ZXalPyl+leZl20j8jKs4xAh5ttD0RDnVoCe7H?=
 =?us-ascii?Q?XBlmUAFrvElfcex8rHDo0v3vYO/dJfdOsYtoknntoWAw+mw+Mi9rV+ZRunIo?=
 =?us-ascii?Q?QGW9JxSVYRhlvsWN5LW86g+CF8yTv5+OrmS4qDjST9hyC2pxmrXEO51V3HKY?=
 =?us-ascii?Q?6V46M9fV4PUJJ+Hq+3OpjVekmS+eL7Y2/ozUQaWTaoSFQEj3OCkraU6zYWwj?=
 =?us-ascii?Q?5zzJTms3MRQP+VzFiT+KrNkdstt4v0cz77+HebvxkHejtt9ANF0NRMXw1YKe?=
 =?us-ascii?Q?LkBOdLrbxVch53MxoU2Nq4/C4JPOIdm43+AUC4G23MdwIA2ZMa6y7K1ndSwy?=
 =?us-ascii?Q?+YyEqW3h7atl2F2oJd6VJA7N3syduSktl6koRbGxJKTU42PMLxIjz7SEC7Qp?=
 =?us-ascii?Q?AKMLtcEDeD+vjTNk7fUyypN0O+iCmReVCeZd1DOpYPnQ+qnPSPhGHmNbMluQ?=
 =?us-ascii?Q?RdcV3sECSj1LDPkZL8ddqTFOmt2wWBezpv0SSnR4RKO49gHJWh+drZrRZf7+?=
 =?us-ascii?Q?RtpmvDU7HaorrM5ERLzTOkh/cdNTsrPnjfTuvlYHHiZ9k2IFLYSZlIMvfjs0?=
 =?us-ascii?Q?S474MtLpKQPu+oOKTi9GVU8cYB72Xn0jO2m8OYJkG0ZqUqtcYQ3lt1QCKjuY?=
 =?us-ascii?Q?4/CO5jpiI06neFSN5lNIZsnNGlyJeCWTawSipZDQ5S3XtJQKjk2hCJ7uIVmu?=
 =?us-ascii?Q?GbUtn/ITUq1Mk7LJQ2c7fEcqsVLK533vK+yjzCdjSBsabW+1hBXooAcvUzOR?=
 =?us-ascii?Q?X9xOsWTz0ovuckKmX6qRgEC1r0HXN3ZGEu93tO/BlnAYrxkvE3f0SZpBYE7z?=
 =?us-ascii?Q?mV7aIxCkk8mZZ2TnU3UNKt63v+4pmCKqV746NUkqDJI6cWJfM1q2DWDojRLN?=
 =?us-ascii?Q?ey/wTv9W7yS2GCuPadiYMWfot7DcLmxcehNdZmYAI0+FAZGN0ab7lg3TWd/p?=
 =?us-ascii?Q?uTuOw34A/4U5FlPQlce0iWdiWt7hBcBGF6lgk9dfINwyyivRif3FDwytgBpP?=
 =?us-ascii?Q?JAbTdeyKrHpzIb8899QPCmBO8RCPqZbzGOOWbqVSMP+TMvtBdg9HjkB6nFOk?=
 =?us-ascii?Q?JVE6BG45pZGMBWOu0i4/nscfv+GL2re9eILTUvRMRA75bj6/fFfHYrI4wuG7?=
 =?us-ascii?Q?dJmHYfJuiDD5311uf83r+TfQA7xiq4Dzj5upWZUJzRK1XEX4sK4uoUMBTQ+Q?=
 =?us-ascii?Q?12lKgmt7Z3+0jyakhvFJyBkHwFTzepbEcOEgCxupc6FdEMaEjFl5NXPzsbEF?=
 =?us-ascii?Q?rQ3s0wOV7REr9f6UfVsxU++EI2OYQQiNgZ1g8C7WN85idVoy0OP5cax4SzCm?=
 =?us-ascii?Q?5TeJqx8wITy4Ll/JJu+0c4kRBiJXZegEllgQ/U06HHOw9RtHeaJkxX7XvBwx?=
 =?us-ascii?Q?CoP/WGSsQXQ4Y2BqtZFTPN89V5KRsxc+ETDyYLPfRr7DpE6XxzuTzU/E0roO?=
 =?us-ascii?Q?+4XOBlPazxWMl+yT8PWGOoVB6vRT5ObEwOEtYGSZUDjopya37skO0NvU9f+B?=
 =?us-ascii?Q?oDuo9idt5Lr/tJ4uNodnkEiujRJlyfFnRA6zQcT5GWhXb5S3z2jHQ19Echmt?=
 =?us-ascii?Q?6kpkI1nr4D9+puASHXG3AXX7hOzyENA+t7/7f5GyOW0l9nWePe5UQozSKKZ1?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7bb349-2982-4608-5158-08dc1cd19801
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:42:50.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C8twy5ZedGRabVDndja1BLvimxszEft67D524iKJ4cSbpRmmppYyltkik+Tnc/C6B37qqQZMKxYKtqv9/o4n/yTTO0yEWo1BSArevo3Euk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5445
X-OriginatorOrg: intel.com

On Wed, Jan 24, 2024 at 09:20:26AM +0100, Magnus Karlsson wrote:
> On Mon, 22 Jan 2024 at 23:16, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > XDP multi-buffer support introduced XDP_FLAGS_HAS_FRAGS flag that is
> > used by drivers to notify data path whether xdp_buff contains fragments
> > or not. Data path looks up mentioned flag on first buffer that occupies
> > the linear part of xdp_buff, so drivers only modify it there. This is
> > sufficient for SKB and XDP_DRV modes as usually xdp_buff is allocated on
> > stack or it resides within struct representing driver's queue and
> > fragments are carried via skb_frag_t structs. IOW, we are dealing with
> > only one xdp_buff.
> >
> > ZC mode though relies on list of xdp_buff structs that is carried via
> > xsk_buff_pool::xskb_list, so ZC data path has to make sure that
> > fragments do *not* have XDP_FLAGS_HAS_FRAGS set. Otherwise,
> > xsk_buff_free() could misbehave if it would be executed against xdp_buff
> > that carries a frag with XDP_FLAGS_HAS_FRAGS flag set. Such scenario can
> > take place when within supplied XDP program bpf_xdp_adjust_tail() is
> > used with negative offset that would in turn release the tail fragment
> > from multi-buffer frame.
> >
> > Calling xsk_buff_free() on tail fragment with XDP_FLAGS_HAS_FRAGS would
> > result in releasing all the nodes from xskb_list that were produced by
> > driver before XDP program execution, which is not what is intended -
> > only tail fragment should be deleted from xskb_list and then it should
> > be put onto xsk_buff_pool::free_list. Such multi-buffer frame will never
> > make it up to user space, so from AF_XDP application POV there would be
> > no traffic running, however due to free_list getting constantly new
> > nodes, driver will be able to feed HW Rx queue with recycled buffers.
> > Bottom line is that instead of traffic being redirected to user space,
> > it would be continuously dropped.
> >
> > To fix this, let us clear the mentioned flag on xsk_buff_pool side at
> > allocation time, which is what should have been done right from the
> > start of XSK multi-buffer support.
> >
> > Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> > Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> > Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
> >  drivers/net/ethernet/intel/ice/ice_xsk.c   | 1 -
> >  net/xdp/xsk_buff_pool.c                    | 3 +++
> >  3 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index e99fa854d17f..fede0bb3e047 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -499,7 +499,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
> >                 xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
> >                 i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
> >                                           &rx_bytes, xdp_res, &failure);
> > -               first->flags = 0;
> >                 next_to_clean = next_to_process;
> >                 if (failure)
> >                         break;
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 5d1ae8e4058a..d9073a618ad6 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -895,7 +895,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> >
> >                 if (!first) {
> >                         first = xdp;
> > -                       xdp_buff_clear_frags_flag(first);
> >                 } else if (ice_add_xsk_frag(rx_ring, first, xdp, size)) {
> >                         break;
> >                 }
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 28711cc44ced..dc5659da6728 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -555,6 +555,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
> >
> >         xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
> >         xskb->xdp.data_meta = xskb->xdp.data;
> > +       xskb->xdp.flags = 0;
> >
> >         if (pool->dma_need_sync) {
> >                 dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
> > @@ -601,6 +602,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
> >                 }
> >
> >                 *xdp = &xskb->xdp;
> > +               xskb->xdp.flags = 0;
> 
> Thanks for catching this. I am thinking we should have an if-statement
> here and only do this when multi-buffer is enabled. The reason that we
> have two different paths for aligned mode and unaligned mode here is
> that we do not have to touch the xdp_buff at all at allocation time in
> aligned mode, which provides a nice speed-up. So let us only do this
> when necessary. What do you think? Same goes for the line in
> xp_alloc_reused().
> 

Good point. How about keeping flags = 0 in xp_alloc() and adding it to
xsk_buff_set_size() ? We do touch xdp_buff there and these two paths cover
batched and non-batched APIs. I do agree that doing it in
xp_alloc_new_from_fq() and in xp_alloc_reused() is not really handy.

> >                 xdp++;
> >         }
> >
> > @@ -621,6 +623,7 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
> >                 list_del_init(&xskb->free_list_node);
> >
> >                 *xdp = &xskb->xdp;
> > +               xskb->xdp.flags = 0;
> >                 xdp++;
> >         }
> >         pool->free_list_cnt -= nb_entries;
> > --
> > 2.34.1
> >
> >


Return-Path: <bpf+bounces-20238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6583AE3F
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7371F28008
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67527CF31;
	Wed, 24 Jan 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwYggG5J"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5FD7CF19;
	Wed, 24 Jan 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113318; cv=fail; b=NyXQ3YH/NjrsaI6YFuIjq+yXRWPS4fTvM4ePwA68bx+Z6924ONzbVVSgXyd+MG5ZnAbZVrWCgetZRDK3qIv70Z44m0r+lOwBvOEve8tzfd0qXOFJ7V7YToCIwhMeb8adEVyE4nSj9w5Fv8ng9WrEkZPxPY8SXMjGaKiZFaXa7h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113318; c=relaxed/simple;
	bh=R5NS/xAPF0XxxGb6zVAeTnyMSHnOhF4eD54t53sxXN4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bd19q4P/cO9Px3MEsBso+k+k7Oav3BWfF8Kt+Elhw++5uJQdSMm96GT2+3v5oER9lvKSsYQBfob84jqUNeptvX1YyAs8+J6agCgwlTaCqmKW82tZedFg/B+eNF6giITvuNlFdnMBn+f3kobGtQaIf/ie64P9bfoC0+shKitxuCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwYggG5J; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706113316; x=1737649316;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R5NS/xAPF0XxxGb6zVAeTnyMSHnOhF4eD54t53sxXN4=;
  b=jwYggG5JT9BHPSuGjUuxqSTqFRdnY9imT7Q4IWfFSjN8W3yiHcj0HREE
   b2DLgFgZ5ipdrU/8RsDg0q2GZ9Pf+hyXNZBa7CtMCigMVQb/YCaRLrGC0
   In//Vy4rhgaTmXhuwStKvsuHeR44UJ0SOtnSRUpCniq50FI9Af/bvZrN3
   MwUISKysf0cSYIHDU1MegYr26sg/7Pseo9MOwUdQv4TSISK7X3wuZC1N0
   c3iUsPba9234becjmjIjtxv91qVr9mr/mjAQCAdTw08ui4eRk8YSxy3SK
   Rm2WsU/gU1T8GVnDvsn+1oyHbQeBCzA3UKwiEM8w/Y0sfG+Us9wKdhH7o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400748909"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400748909"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 08:21:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117663391"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117663391"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 08:21:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 08:21:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 08:21:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 08:21:53 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 08:21:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq5x6tDe6M780MWECRF+hYzvaiTSmpSANwahsl+qANCckQWmw4Qo8fNg/QwFyuAPZ8D6OCRljMfkiqCWuJBBN3Ujb0Tp4gNbUjXusGTqaIDETc4yiXYwzO22k1uELZNx5a8Jjfh05HbrzAKG2Aw4FjkXhZ9Jsq+r6s779XJ+VRwUx6lLYJE1n7qDvNxUzF6+KwdB9wbsZcbmvbhIzXF4trErHWcEmvRAsn3ObpzoNneQd4urcGdFLslWauod8BRtkFSOXP0ganW5p9r2xpHnTOvcPnbLRmQEKndd3q0PetLlki07y3Dil1meralOpZUqT6oD5I8tSfy7DYxz0vrMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZrM+7tByHz/KEg/n4VomH65ZV160EtLY1fW57qgdEk=;
 b=TpaFiixE4kyGNr7KFxY4vNp1vYps1KlLZy/lKZDqITDLkXLT6LGaPwTA0l0vUz6aCpYFS2wdcu0+bnfYCWPkuwKfiPolX6z9hvdJWhe1tLjpmZzajpApRDW04EnhY0etKHyXe7iBbHzUscir2lGFYkiZn1+3VPO6VuiBS4K0btLPnaxzxPoK6amX49xcPMO4FQj/G9BEmHYA7UPo1ygqXHq0OZA+XYtGSHVTirjF9Ef8iabeXtFCw+NXQzlYJIfdJVSnD8Pu0mtLv025jnAr/t3kGXdO6jS5nyyaCpUFKZf+b2CUX2tvMh/x++PXKOO2sFFHEjBZ1Mhr672gl+8h/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 16:21:48 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 16:21:48 +0000
Date: Wed, 24 Jan 2024 17:21:42 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <echaudro@redhat.com>, <lorenzo@kernel.org>,
	<martin.lau@linux.dev>, <tirthendu.sarkar@intel.com>,
	<john.fastabend@gmail.com>, <horms@kernel.org>
Subject: Re: [PATCH v5 bpf 07/11] intel: xsk: initialize
 skb_frag_t::bv_offset in ZC drivers
Message-ID: <ZbE5Fu0vUlyqfszq@boxer>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
 <20240122221610.556746-8-maciej.fijalkowski@intel.com>
 <CAJ8uoz2d-ybdO5P54jmjVgfzH-qODuSAPcToFGqJ+fQo4Sc5JQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz2d-ybdO5P54jmjVgfzH-qODuSAPcToFGqJ+fQo4Sc5JQ@mail.gmail.com>
X-ClientProxiedBy: VI1P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c14efc-6222-4b95-ef0b-08dc1cf89096
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zNoVAdT6mOoT5l+YY07axPsDFj6a5Sw0EQZk1UwMYPV5R8lx6m/Mo+aVwOfwi8RjC2ikQfeVzIH3pF1XErOJWym0GWtp/SxSn4qSX6RJtTKjen0hX9/v93/5gde1jKWRgUnXtTzV3zXs9imU04IYe3sE3mjk1hZJmcZStE3of9mNbgSzeWrZCbRgNUdbPsHyF9Md6YMkl5J8OuUcSDrujXLYG6sBKlkzVl5U9GCmUu9fSMFo0iUsKRB3nVj3NoeQCp6Os3RdBG9BZ/0zCScepMd5yTJHXpU+rs3mXBc4CCTdiL/jPvxkjYZbHu4yYH/9WtkWTBJlktVVhxmEUEwChgbJqww9AVLXq4Yee0iiqz8nKwbkRc92PVjcm9Y2rWWL9CN4wfzxi6PlGZq2t2hvAPpcYRs+0rm42zZDgw+aYpWWxsfBkdSHIwxzWTgIDHkG1MiCjtfOVzBjrptmKUEz/VFfj+FiWvRu874Av6OlfMjbHcJGl6YFH3Y9J3XZxSP4QDCZBs8TVRqtwRVUtTqAHRp1YyqJ+vAeqNlzFdUaG6IgZgaLO37LkKAQJVwAAIHcHK00ghDWuFvQzLV0JDENNpZEVeYSdnsax1c4EkcBtltWyQDSN8VJgRbtBWVg9Rz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(39860400002)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(7416002)(8676002)(9686003)(83380400001)(5660300002)(8936002)(6666004)(4326008)(6512007)(66556008)(66476007)(6506007)(478600001)(44832011)(66946007)(316002)(26005)(38100700002)(2906002)(33716001)(6916009)(6486002)(82960400001)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j7rw2jjL1o0IrAPgpu4lf9rbyMDMcAU1jPUf6Cun5ScnUJbw5Xb/yumiVuER?=
 =?us-ascii?Q?YrT03LFraOXQeyew/CqswJfHD9Lq0dturK8Pq7xhD5C+/swbKsDNYx9jgt9p?=
 =?us-ascii?Q?jH6bVriA4D7Gs/sKivI15q93vNNMQTcitzQgy6RRevzHbb4TAppv2dCYybLw?=
 =?us-ascii?Q?Pm8+9pYFbtU5MOE5Qy2FXAOH78maNCiXGVKiuSQgPuXubgl/niAgN3n0OKIJ?=
 =?us-ascii?Q?f8AWb8UDryZ7hJngRqzPlPqEGoTfDwAh0kKP9L50K7QFFRY5m00WNCE2w9SW?=
 =?us-ascii?Q?yv2qa3yeMr8WWifLp1c5Mgvwwxe96vMY+NgdzDyj4m39xFDn3oP7ufvKvQo0?=
 =?us-ascii?Q?OGmItfF/kN6FnOrc7J7Gba6VxIjeKqMjSS1/AA320r/RH9ZJeXossYVirCCE?=
 =?us-ascii?Q?Sn7JxMjRCxkUrFZm5lLXnzHSjk0rxPNPJxXbIImow0ccTdi6qbjEscXv8dD+?=
 =?us-ascii?Q?GLbHrK0JHcqNlXtoKy1Sai9q+otq+T3cE1oTWeg1AqUwudNZI3tcV0wh1z2X?=
 =?us-ascii?Q?qp9KsFfLcc9qtbcieJ61PZWNhBK5pr6OzD8Xs1wF13yMvnP1fD44P5g/kyEa?=
 =?us-ascii?Q?MX1/cHNofdXgO5zcG6rn3BxoWC32O8jWAdi9ZRiXoUjAYuDw/9JmVy16yVau?=
 =?us-ascii?Q?11hdXUdJoEgQCBQBGimmLz6uremEh0zlZL/19PS9tS1+pQrHgRoBCzAH9tJl?=
 =?us-ascii?Q?/45U9pBwSXe1wNGRLVDTYIA+Xcf16kwsSoxWfYhn4gbGMEKY9BohQKZfrGRC?=
 =?us-ascii?Q?90TTZg/O+y+O2F14BCUgP5CfQR+s0FNWO3kgp3f3/2xj7AtNhWG0UEoe+pRj?=
 =?us-ascii?Q?fftut+/QyPiWRbsM3e+WpzIevws43kHPgC5dVi4BOsdedxW8LrZ0eo09jmtH?=
 =?us-ascii?Q?gLVRmt3iVLNssID+VtA/ZpRoM8I8KRo/W8iESkhbtSq9itzhii5+A44sAYnt?=
 =?us-ascii?Q?QrP6Dcp7Ua5E+u5gm6e2chd6ly0zpzdloqxBioWPVU8JE0fmMf7arUTKbQQF?=
 =?us-ascii?Q?hY3jGNhLFIxwWCgUlt5jdB3hkr7DNCHO90CrxF8ufEcUsDqMhRsQv4H2cPI8?=
 =?us-ascii?Q?GDYD+nX01drzskcY2lYshvjP3HMhXESsu7W/ujtlFaIPanQQIhORoIT6Fv/J?=
 =?us-ascii?Q?KQK/3YKwscB3jEv45B8p70hY/ojtL5IBrgGD5aAay0KRR+zGanvS1mM8aDIW?=
 =?us-ascii?Q?I0NXZQqeNRRjDjSZSBdp+mKFJ0Qhm4/ktXfxWtzggEtObakG1hFowXw10mkC?=
 =?us-ascii?Q?mpWNtVZlUq0G+iVlVzAVwHGuhM5B4+Jt+c+HIIb82mgFpenmivHJPILIJ2cV?=
 =?us-ascii?Q?0+gri+vRiuf3CsY/3o2OO4HORNg4FIKUU9DTKyR+H/0VUZqTtveY5JyZYEkq?=
 =?us-ascii?Q?cTsne+Hs8ZkmQSiQIw1f+L/seKxz/B3dDFhXx8IfKW2lIeEouP6HR4OcXxkZ?=
 =?us-ascii?Q?4CSQ+6rruVtgXWkAgf29SZe/nGMiQt7EgcNF/+hLl7divtBpVeMLKGx34O33?=
 =?us-ascii?Q?igCnqusehw3nFVqCEhS+jQwujZFtMmN7LALkTi3Bc973t57x17MLF3IUlrt8?=
 =?us-ascii?Q?OR7JqXoJqet2cKHTuR7k2uGU/OBhnRwj9HWxTRy1m1aFEmpWDUV+v1WO6m9l?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c14efc-6222-4b95-ef0b-08dc1cf89096
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 16:21:48.4605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJIDh0byxK1n/HSC2UiI+fd8gT5ts4Xrbyk9bG0ZNKvZ3rYXKZykqhJmjkPiwB0G+L4VVH35mQ0vZy9JoQl06Mt9b8uT6ABGmt9pgZFI8oI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com

On Wed, Jan 24, 2024 at 09:44:03AM +0100, Magnus Karlsson wrote:
> On Mon, 22 Jan 2024 at 23:17, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Ice and i40e ZC drivers currently set offset of a frag within
> > skb_shared_info to 0, wchih is incorrect. xdp_buffs that come from
> 
> Is "wchih" Polish? Just kidding with you ;-)!

Huh, I was missing codespell on my system. There's another one on other
commit:

Commit ab19f322eda5 ("xsk: fix usage of multi-buffer BPF helpers for ZC
XDP")
-----------------------------------------------------------------------------
WARNING: 'appriopriate' may be misspelled - perhaps 'appropriate'?
#64:
appriopriate xsk helpers to do such node operation and use them
^^^^^^^^^^^^

so I'll address those two. Thanks!

> 
> > xsk_buff_pool always have 256 bytes of a headroom, so they need to be
> > taken into account to retrieve xdp_buff::data via skb_frag_address().
> > Otherwise, bpf_xdp_frags_increase_tail() would be starting its job from
> > xdp_buff::data_hard_start which would result in overwriting existing
> > payload.
> 
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> > Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> > Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 3 ++-
> >  drivers/net/ethernet/intel/ice/ice_xsk.c   | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index fede0bb3e047..65f38a57b3df 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -414,7 +414,8 @@ i40e_add_xsk_frag(struct i40e_ring *rx_ring, struct xdp_buff *first,
> >         }
> >
> >         __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
> > -                                  virt_to_page(xdp->data_hard_start), 0, size);
> > +                                  virt_to_page(xdp->data_hard_start),
> > +                                  XDP_PACKET_HEADROOM, size);
> >         sinfo->xdp_frags_size += size;
> >         xsk_buff_add_frag(xdp);
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index d9073a618ad6..8b81a1677045 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -825,7 +825,8 @@ ice_add_xsk_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *first,
> >         }
> >
> >         __skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
> > -                                  virt_to_page(xdp->data_hard_start), 0, size);
> > +                                  virt_to_page(xdp->data_hard_start),
> > +                                  XDP_PACKET_HEADROOM, size);
> >         sinfo->xdp_frags_size += size;
> >         xsk_buff_add_frag(xdp);
> >
> > --
> > 2.34.1
> >
> >


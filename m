Return-Path: <bpf+bounces-19065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B390824987
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CFC1C22A0B
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182452C69C;
	Thu,  4 Jan 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhiqChDm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C32C687;
	Thu,  4 Jan 2024 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704399801; x=1735935801;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4uyMXuA06Nh7xXtPomAsqaFXra6boiNWAIeN99X7drg=;
  b=XhiqChDmfJ+wGFiLNwiyuPqSEGYXGQkNdZYI4N2MYgeN+rbUzOTdeDZj
   1veAG34dDeD9L3esppz5296mwC0pQ//0yA/j81OaD8RcQzYI4rNnS1Dtr
   PgqBmv7A1M8c0wpmGIV6uhn4lBsrkJBovkNnVRAvgt1RevOtb8Z2U0SsO
   qh8N65EgZvGIFQ0RozqHiButupQiK6HEjqOllUq5iNxBzSwnK25z33nSu
   p6kVqzBNIMlyZ7A/jYZSGfu663WuyjjEJKF9dsb8raJ1HUDMkbSPV9HFN
   JGjLUTZylcZfgjlIaBLL15jgqkLYBjXYd+2fiBAhkX53YnVCcGIWnsRwU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="15977811"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="15977811"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 12:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="899420306"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="899420306"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 12:23:18 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 12:23:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 12:23:18 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 12:23:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYx2EymUoilf8J/+IT9leoxb5SPVGHGTGM++9m89t6Geij0+0/F9sl579wPdtHmQQipRfnaYKemqOHdfXFPnKjiRvXhe8Hs/CeLPujNKEhlEgYXsr3bPf6YXq1RyoCwHk06alPI8dZ5IC6cE1+ZuqsGSCKrDvQILNtOW7xyfGkde0Nr8sntrX8x6qlP6NVf1CEaAU+cLkF7SOXIDabR/mGGaqg1zsjhgC/a9bWuIbNukp5AybA/uyG2wYGN0uHMzcitVpvVbmFISpufkMbsLDkTRaiH5IS8z5htZHQR5dCdf6LEA7KIdYnVeuWum2qM6Nj5c6mOWkazW6Kx5sX2qiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsRKneKWKJzGRLcubOv3UJVU95WtL7D0c8QqDKOBE9I=;
 b=AYOxAZwjrgRi4xT0qOOi3c7jo8V71P5qoWKIYlziDMC4k71okwzc6WXuoynvbTB2Yvw1bLYJmN2aql+ACM9co4Ogdoaw8zsrsytKF9a7+98alcDvUZDATa5f+k8QyDdPdjj2JEcw7Thpl70y06qF1D66e7Cof/iadatK+dizeyFDwJVdNbXK0COj21FzE8CMnbelNrp7pB6eaX5ZdxlLX/sJRA12asmsE2g73ZwF9LGNecX4gex/LDIjHuBhLSfUQCivauohyqeNginu+LMZJmrSWzdvje3X8bb0/LKsDw0aw2ez2rdLoJnXlmN3SU8T8oTZpc5Ak2LV5a+Zy5tfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB8288.namprd11.prod.outlook.com (2603:10b6:510:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 20:23:13 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 20:23:13 +0000
Date: Thu, 4 Jan 2024 21:23:08 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <bjorn@kernel.org>,
	<echaudro@redhat.com>, <lorenzo@kernel.org>, <tirthendu.sarkar@intel.com>,
	<bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>
Subject: Re: [PATCH v3 bpf 2/4] xsk: fix usage of multi-buffer BPF helpers
 for ZC XDP
Message-ID: <ZZcTrLaTKXZpwvOE@boxer>
References: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
 <20231221132656.384606-3-maciej.fijalkowski@intel.com>
 <dadb229a-d811-4542-a53f-3a78e559e639@linux.dev>
 <ZZVNa6CN8Y1KUtNM@boxer>
 <7d2cd6c4-0d65-4a65-beb1-2dd995ac9b2f@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d2cd6c4-0d65-4a65-beb1-2dd995ac9b2f@linux.dev>
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: ae22aefe-82b4-4bf9-aa07-08dc0d62fa00
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2ecb+oYn64cT+pLptzB8pi0h6tAQlmb8dxDRsUmfI3bGkyubYgXCUM2sZopzPuKC3BLjAZxgBbbrUNNUvDmjx1Se7CNKnHPzd4LbsXep57ewBSlHc2z4kv+nSFDtCNs6shLnB2KwHmzgW0lPyhY/7/Ex6TnXJOjUtcebnNGGSHiU99AOf7uZSO25eUY4/TQbof3oQVS2yUXCO49QIF7/L2XobkHt4xA/mNS5IYzQFVGdTAvjNEe400/+0feJrsgRdVIk/YoZdiQxTJVwgCHJLMReP/4V+NBTlcSGpeQAPNXls8NYdF5C8Fi3SHnCCTLnhNgdK2e1Up/6nZRVuuPRh9gYkbMBOmLjav5dgP/M5E//HX3nf7fYylyu2LMZ/nYl/qhXHsUCbYQiEirxcq4ASPgCnTbbd02bvJuWXVrU94TvL0Q9RwhXFFi7CY8nCEc2K6EHRgzF1M1JVM83NBqwmXd4SLaX7thX1+DJ4bgl3CF8OCBzHjZJIYWvTQM+QLsWqJenFrgLJOGNSJKuRkjQtOfmTDAyOqLyuirnL+xPyd1+LRKsGAJr/cJOEmNjyrifzYzUD0keHMiQMN2zbJB3NIazA9AwOuM5yPoKYKPY52OYdDFNbP1OS1lVwMnUkYm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(6506007)(53546011)(38100700002)(4326008)(66946007)(2906002)(82960400001)(33716001)(83380400001)(316002)(5660300002)(8676002)(44832011)(41300700001)(8936002)(6666004)(6916009)(66476007)(26005)(66556008)(6512007)(478600001)(86362001)(6486002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sZrQRY/7gAHXVTO4dZnEWAw87by1JsiY0WU1nPkVKnFy4eV8siu1Zlt22HOM?=
 =?us-ascii?Q?L8hSA35Z+svvXSaXfnx5u5mYjAshMFftpLHHD1ZMFQVq46tlH8ybiwfQlGdh?=
 =?us-ascii?Q?Y6knlwj9YhEENoOU9Q0G4UP2yw9wtNNtEv8AF1mShxRjrbbXaFVQMD5uBDqB?=
 =?us-ascii?Q?LisgM4Y8z/DZcTpw5R5VOMH7Hv7zBYbkT/cbFGuvIbP+S6LKGIthEjguxIOU?=
 =?us-ascii?Q?UN2ZO1mwftuXT9xHnRm/4TCRFmDuT07oi8WfRueacOtKgyHXT470+92IZxeg?=
 =?us-ascii?Q?6FsE0KBkXmYIoL8WIV9YTY7KnyU3oKMK7mdagisrgOs0ftVk/XhOlFXOrGro?=
 =?us-ascii?Q?We1uTH9BAVQhTcw7t7qd6aMhxqMuo2ZSBOJKEr0WeISpI3nd+dlOUI3sh+p/?=
 =?us-ascii?Q?Lc/B79GSdTpfV6ay2OoIwVgl85LiyxUOYt+Oo3trVnnJiXKrH8f5QoWcWQjX?=
 =?us-ascii?Q?Cuzb6k8i2RWGXvk31fI5AZAstLeUSyennHnvVJfZ1BKO8KRf7pey4CthQu/R?=
 =?us-ascii?Q?0pf12ppjOkAdwGv9gtRt6JciO8E6est2qCreqQ3ouJyEqLuIAo4ZJjDxb/3p?=
 =?us-ascii?Q?v/Vu8A8n6bhtfDiIXAgOiJGxEZI1itGa8mtvV1zNohNH5itIRenVvl2h5tUj?=
 =?us-ascii?Q?SZsbyhD8j7WiSeDiTWSYFOIqfw3G20CRtAlgGVRePyrqidu762rKlDJEa4zI?=
 =?us-ascii?Q?KgCX+vxl6b54Jz2uB64TTC8gHXAHZ0FzMBXE+oegSY256nmONuXKGPXEp5Vr?=
 =?us-ascii?Q?qNft5E2X66SWlcSvTnifOBd9xXovdupyJnLqadlXlAiCGnOca4i94uSAi4Yw?=
 =?us-ascii?Q?Dj9YE7kTTR8pr3Ae7RVvxvBDI13626ZRby/nY6rA0npmNdQ4vQbxtmJzL989?=
 =?us-ascii?Q?ri9WTlqQgM6cBLF9zYM+NWSamA9qqbtfe6r2GcBh3zddau6hKwXC7dVwB9HS?=
 =?us-ascii?Q?1XMpbAyM4CM3zKI2e49+2ztangjAPhkrMnml9CDx0l+r7Mvhza7YsfyEk/GK?=
 =?us-ascii?Q?jgEOyVdt0dJ3pgI2rQlT6+Wx8aNSVO+r4qSgBSqDpt8D3S6xX5cjyJ8Gv6+y?=
 =?us-ascii?Q?wUjWHw42fMgD2DsAEvnVo8+Or7H9DztwJE8oWYG7Zh0pDUswikQCZSp7QEzr?=
 =?us-ascii?Q?U8+apDhmgEJ7wzb5Lo661I3RwhOm/pOXx1NmXSatnWOaXpg/LnqH/AQWmuuh?=
 =?us-ascii?Q?ms72ViKMLzLCfhHBcQVzLRZOq+BXBSMUU8pqoqBOL63rPyf0K0OKJA6L7RBP?=
 =?us-ascii?Q?M59WHqhejx8AmARyKC7WSTpBCy5zimqmjWDdJnE4oA6FimJmzItc9OKnxMBn?=
 =?us-ascii?Q?NJ8laMlsCnrd7j9BpruBI86aH1uIIajTicIdII/Cnq7Wiypy5FlJOy3Gjuek?=
 =?us-ascii?Q?nAKPHd+KJYN1k/01XTIEKD79rzTS1TYuqnprNt73amTgrf19cfxv8K9ARlgU?=
 =?us-ascii?Q?8IvrMYxwbN+yesNGQ7ZFdJxMwtvo0kWjOU+nVJtjlxaG4JV3A+p+Qlm2JzYi?=
 =?us-ascii?Q?An1+dPYbxubw/whllwS/NQrZtlg23uMHEad7FpHep0ioAsvW+xQxq2K+NTg2?=
 =?us-ascii?Q?RMxkuqDxqgiP8zD4OF6OXZbOAVu62EsJVFhMvjbAhcGQd5TwBp5bmqtOMw7I?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae22aefe-82b4-4bf9-aa07-08dc0d62fa00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 20:23:13.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbPLdSvnk2jf0r/Et2N9IVcXDzx3RiGQhvEom1ujH2Gw5BwxBgJdVPoW9owMlWVs72WsD5WX3RhXQkl2Uw4sUqvUkloKKSnAgSopbu+oxiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8288
X-OriginatorOrg: intel.com

On Wed, Jan 03, 2024 at 02:53:20PM -0800, Martin KaFai Lau wrote:
> On 1/3/24 4:04 AM, Maciej Fijalkowski wrote:
> > On Tue, Jan 02, 2024 at 02:58:00PM -0800, Martin KaFai Lau wrote:
> > > On 12/21/23 5:26 AM, Maciej Fijalkowski wrote:
> > > > This comes from __xdp_return() call with xdp_buff argument passed as
> > > > NULL which is supposed to be consumed by xsk_buff_free() call.
> > > > 
> > > > To address this properly, in ZC case, a node that represents the frag
> > > > being removed has to be pulled out of xskb_list. Introduce
> > > > appriopriate xsk helpers to do such node operation and use them
> > > > accordingly within bpf_xdp_adjust_tail().
> > > 
> > > [ ... ]
> > > 
> > > > +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> > > > +{
> > > > +	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> > > > +	struct xdp_buff_xsk *frag;
> > > > +
> > > > +	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> > > > +			       xskb_list_node);
> > > > +	return &frag->xdp;
> > > > +}
> > > > +
> > > 
> > > [ ... ]
> > > 
> > > > +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> > > > +			  skb_frag_t *frag, int shrink)
> > > > +{
> > > > +	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > > > +		struct xdp_buff *tail = xsk_buff_get_tail(xdp);
> > > > +
> > > > +		if (tail)
> > > > +			tail->data_end -= shrink;
> > > > +	}
> > > > +	skb_frag_size_sub(frag, shrink);
> > > > +}
> > > > +
> > > > +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
> > > > +{
> > > > +	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> > > > +
> > > > +	if (skb_frag_size(frag) == shrink) {
> > > > +		struct page *page = skb_frag_page(frag);
> > > > +		struct xdp_buff *zc_frag = NULL;
> > > > +
> > > > +		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> > > > +			zc_frag = xsk_buff_get_tail(xdp);
> > > > +
> > > > +			if (zc_frag) {
> > > 
> > > Based on the xsk_buff_get_tail(), would zc_frag ever be NULL?
> > 
> > Hey Martin thanks for taking a look, I had to do this in order to satisfy
> > !CONFIG_XDP_SOCKETS builds :/
> 
> There is compilation/checker warning if it does not check for NULL?
> 
> hmm... but it still should not reach here in the runtime and call
> xsk_buff_get_tail() in the !CONFIG_XDP_SOCKETS build. Can the NULL test on
> the get_tail() return value be removed? The above "mem_info->type ==
> MEM_TYPE_XSK_BUFF_POOL" should have avoided the get_tail() call for the
> !CONFIG_XDP_SOCKETS build. Otherwise, it could be passing NULL to the
> __xdp_return() and hit the same bug again. The NULL check here is pretty
> hard to reason logically.

Thanks for bringing this up, you are of course right. I'll address that.

> 
> > 
> > > 
> > > > +				xdp_buff_clear_frags_flag(zc_frag);
> > > > +				xsk_buff_del_tail(zc_frag);
> > > > +			}
> > > > +		}
> > > > +
> > > > +		__xdp_return(page_address(page), mem_info, false, zc_frag);
> > > 
> > > and iiuc, this patch is fixing a bug when zc_frag is NULL and
> > > MEM_TYPE_XSK_BUFF_POOL.
> > 
> > Generally I don't see the need for xdp_return_buff() (which calls in the
> > end __xdp_return() being discussed) to handle MEM_TYPE_XSK_BUFF_POOL, this
> > could be refactored later and then probably this fix would look different,
> > but this is out of the scope now.
> > 
> > > 
> > > > +		return true;
> > > > +	}
> > > > +	__shrink_data(xdp, mem_info, frag, shrink);
> > > > +	return false;
> > > > +}
> > > > +
> > > 
> > > 
> > 
> 
> 


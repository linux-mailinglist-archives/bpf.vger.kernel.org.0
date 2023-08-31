Return-Path: <bpf+bounces-9042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF1D78EB29
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63449281479
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE28F66;
	Thu, 31 Aug 2023 10:56:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264563CC;
	Thu, 31 Aug 2023 10:56:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E6CDD;
	Thu, 31 Aug 2023 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693479372; x=1725015372;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a87WVT+pbzimt5MFDG/iAuhshNR5J3F7udVnUlXrxw0=;
  b=QFae8beVOoak1XWduPhRwCTud7mK2IBkURrUT3r47z0TKdWv2Xz2o0is
   7NnWftKiUhCSbsQiE4OyefLlPIPYvwE9W+PizPdArgwK+iSYZnNMvsfQq
   c9zG/vQvOxdAolcmaY2nBYRD+mXiJhunu139oRbBnUPO3Hv5bWSGZcEpV
   rer8B4W9YO3tJc2ZfraGb+2ZG4TW9d6hPeHiULy+Ce5R3Ip5HHV+3s/X1
   p89nCG+9p5YR03XTO0ftZNZGcAnOYeMIK4auWe26O+wZ3S2mtqBBjgcqk
   mz8TJ0HOC4Yk5jb/4Cv+7UB7JcK1tS9jQSK9qfMena+f4YsCdHvdJhOlz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374811357"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="374811357"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="689280936"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="689280936"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 03:56:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 03:56:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 03:56:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 03:56:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTpuhLHnBp0B9OmYKSmDil0j3Jwkp29MsEPFfwFqkTT1ETbCEN2Dv5bEG3mVbNzWADSi2mH+6Dy+czUTet6HHQUgLHir7MOiGH+tb1D78j8VIFEyDOFv/PZwtZ8733gE3ppZSlZdsODcoN5Xp2sc2cOhHrZXn2oRI3eVHy4YmuKL/ltUpWc4NPattYcUrxS5e3CMzMSahYWcY/hz8/PGd3uGO+MvlT8hklVROesVAlKut+CNpaaEzp/svDcqvz0xCG2N1BSagYtPoEWYxQE0tMtW8NHxkJZX8wv118Z5Hjd5b0m5jOOZnl4BunB5dmAC3yIONgXNPyBLhTYxmLN8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPRL7/Gare9vIqiI9c0O8lppSDM0G8/uxt2B/jsweyc=;
 b=fF6JUJZGpfA4obefWYK36jM1ppDrWnHLbZAq3RwR86vhNXT3UhKu7E64VzPxi8FIrucPHEocHByG82MJsPu2+iP8uN+4ev9hG5zmGc17HfyWPxmFWdwqdVWJSKVlwHD/R4D1cDGde9eEk+V8Mme/6ko2hnFifcVBvyy27iqbDfizHRQ7+r8VODr0LzSZ9wsDZaYUNXJHtn13GIcMZ6/4Lm8tB10xA8+aWu592LqSiv8Z96L26GlAr5sY3fe3zneLdI3gLz/sCx2MLzRCLA6VTsLC+RQuAyIaLvlXrz0odg/9BdHBUl/neYcb0DnNyBlVnR8AmXL5/5jUTeAphGlcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5110.namprd11.prod.outlook.com (2603:10b6:510:3f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Thu, 31 Aug 2023 10:56:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 10:56:06 +0000
Date: Thu, 31 Aug 2023 12:55:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <jonathan.lemon@gmail.com>,
	<bpf@vger.kernel.org>,
	<syzbot+822d1359297e2694f873@syzkaller.appspotmail.com>
Subject: Re: [PATCH bpf v2] xsk: fix xsk_diag use-after-free error during
 socket cleanup
Message-ID: <ZPBxv6Hud3K1KYjA@boxer>
References: <20230831100119.17408-1-magnus.karlsson@gmail.com>
 <ZPBt2RdiWstRa5WY@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPBt2RdiWstRa5WY@boxer>
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 77541d15-25fb-4d9d-eff2-08dbaa10e041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wm5Z6KXFTcAJ0NLsiJCin/FqhnO+1zcSNvXxg0zfGpxfj2Mwzrytf09Xop5nKJh3ycfXqbxcAM8W3+Zj8obp8k0g1JMUHW8u88EXdVE8Tw83refpHmAxmVXpA4QMEoyAfz7NI5A2zBYnE5EUGkiV1DqclAN0kIGosHZAJ731fod4Euswk3OM+LxDkSZF1cX6O5x5aba63lGQG6LOW03RwUYIhleHSMJszYfKEd77uO9Vvi+6PA8TQdg8XSOA12kYUWL+EGlEGCetCyhXCWNUlcNmoPus+H0b/zRaLRxa7Tm7GEpD8U1GxTT0CTvEGHdnFNQsm9Wi68LQsTWa/6fQZeFmJ5hE3Oqa62nY4gt4Rod17jFnfGG9kEUPNazcy8/K84BpKyFjRNxCHOl8n88fLl/oFqrLdg1RL8QF5RmmwNP08EknfG41/FNVONvW2s6T/9rd0b8mxiWhKxiGFm+TGpF14v7nu4WjLkH/ALhVie66LF7000FOr2TGYZDfDLUuoy0Zan48yoLRKBKzam7YKHAyHbm4RRcpbDehExg/5t7NXZOVkk7JEvkN4SkVw1Nf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199024)(1800799009)(186009)(6512007)(9686003)(38100700002)(41300700001)(82960400001)(316002)(33716001)(5660300002)(4326008)(83380400001)(44832011)(86362001)(26005)(8676002)(2906002)(6916009)(8936002)(6666004)(66556008)(6506007)(6486002)(66476007)(478600001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AZyl7/rm8u5ldw+3FnIfoKZ9x2M3RCVXsUc7jHOP7NpJ67QaIPbVicjcHsHA?=
 =?us-ascii?Q?M1LFGRJaL0wwOBuJ0gY1GgE3ktjt2V9QTrqel9e3DMcOZEJ2JDr9fcBkB9cM?=
 =?us-ascii?Q?kb5xuFUqqBsrPna6+e7to9r6IphLYut2uOj1zgsyAedwPCv/AG3ZI941n4Ja?=
 =?us-ascii?Q?JtoISWz6U18LZYndqKw2dWd18TDP97uzmteXry+jOWD4m4FplaullDBPIUD6?=
 =?us-ascii?Q?Nxv3AWdR8TPZzXpy7TXUbEBr/71B7MvsBT/48yx5vtLPFkWoR7r4rzUuiDp2?=
 =?us-ascii?Q?ZoDeZvC6OvZrc6TZXsuu8wi2A6tn6bMSS6PN3Qsm/i7PdkIcUo6hYMygiN0R?=
 =?us-ascii?Q?FlhjZGix1ZdTTkXhx+WOKI+8eSjDB+OFd4IfPIrYSriHHIrp//h30TMoBOFY?=
 =?us-ascii?Q?PnLD6o4X3rLy3NcypnCbv32XvkJ6niIeDRRFYo1Vt14dbv9CV29Nh9XHra+3?=
 =?us-ascii?Q?d0x6cJ5qPkbAgAJHsqixFkXyttlMxYayA21Q+/zrXofWRk2AK9uOI1l5E+jT?=
 =?us-ascii?Q?tnHYDOgAMo9a49QBPmJRLjwHLYGNo8uIxcT+tQz2HgB9BFfetTfePOtqOz8C?=
 =?us-ascii?Q?mVTYl0XezFe04l/8JdMW3hXCFYNlqTAvwIVmACTFKYYEsfwnMOAuUpxMze09?=
 =?us-ascii?Q?hbMEdzwnv2VPVi717IQkwLrRWxIJgVaFtm1LtJqclYIgb+QkcSoG/ikLfHbM?=
 =?us-ascii?Q?+Fc/joJMUDlFvYvrmDEjDBZOenKYcEHllqaPGC0JJkl03yHWby1YPZgLDDTf?=
 =?us-ascii?Q?Tc2OIfQrrDL5pnLQb/t6ADTj8mUBFlgHuNr8oEXVJA2aOgYVSEiNkSdr7xBN?=
 =?us-ascii?Q?mvAjUc4FKJIfbP6Z/TSm0ggArHt3CP0v08Ql1t/0I/ePAssprF+cqzux3Sdo?=
 =?us-ascii?Q?OAhVY8qg0f29xgyS6fOcGKaqzDvPMNy51a13jYP0ThnqjQqmg0z6q4d/2j5Y?=
 =?us-ascii?Q?2aXXyo3Z8kJdXmt12FazoFMbSWaEEnz3Np0hWZfQi3j2I9a9+VQkXUXv9FqI?=
 =?us-ascii?Q?52IQMUW6Q+01duytrfKDk7edLmYG/ImmTM0qhBOjTsdBAc5iBiy6zHmI6Xs2?=
 =?us-ascii?Q?h1lcmajOHW8b/SL/ajMymDrAchWfUPOUpwHsTMSbq5Ktgxwql9KQc8mSnIka?=
 =?us-ascii?Q?f8bDTS4lI7lpeGw3DqFlaiL8GOVFhehjpnK78zBAHnLpT9Zf5qLUVFKEHPLD?=
 =?us-ascii?Q?MtEF1VqSaz6V14Gezku1B8l9wZNfraYbDHkkr2PW7HAwxHv6ACRvnuPzWps5?=
 =?us-ascii?Q?X1B4P7bOpeIOoyZxdFIEz8DeIl6luJ7yK44mEM2Vpwqjy9HQBvt659iMzU+M?=
 =?us-ascii?Q?NrdpqycCAAp60VZTsrwmm4iE6hzaOCQQov8kL5RPxrckDOlvWIzzNrqxBfB7?=
 =?us-ascii?Q?jRzqDiXg88k5Te8PAk7iHgkGTMN8pZ6yGAeilEmqn9FVI47Mmkn2D6mdbjUP?=
 =?us-ascii?Q?LQ9m6FXtgZCdptWKcczTovkJxPLVO5t7+XEYriTFKArV6rJlwVAus3VZlv+t?=
 =?us-ascii?Q?LWcDzpuXAMUGMT1vea/m6SeOwQr9h6DhdsvGHiQCmsFBZst4tKEw94eQ1VaX?=
 =?us-ascii?Q?usapDZK/fPo2nQFkg4MgDDl2qqS12qbMsqCWEE8Xhgc0XIHRbVxf/C+oJ9VP?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77541d15-25fb-4d9d-eff2-08dbaa10e041
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 10:56:06.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3tYLC+esMxpDVKOVTSuTfmTaMv0Let8+R8CW5wV39Lwkikj/X80N3qb5Ap0WEpVVrbn9MUWpnXPWzExP3HhiDT4qz8yRI5orJpAdISKIkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5110
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 12:39:21PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 31, 2023 at 12:01:17PM +0200, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > 
> > Fix a use-after-free error that is possible if the xsk_diag interface
> > is used after the socket has been unbound from the device. This can
> > happen either due to the socket being closed or the device
> > disappearing. In the early days of AF_XDP, the way we tested that a
> > socket was not bound to a device was to simply check if the netdevice
> > pointer in the xsk socket structure was NULL. Later, a better system
> > was introduced by having an explicit state variable in the xsk socket
> > struct. For example, the state of a socket that is on the way to being
> > closed and has been unbound from the device is XSK_UNBOUND.
> > 
> > The commit in the Fixes tag below deleted the old way of signalling
> > that a socket is unbound, setting dev to NULL. This in the belief that
> > all code using the old way had been exterminated. That was
> > unfortunately not true as the xsk diagnostics code was still using the
> > old way and thus does not work as intended when a socket is going
> > down. Fix this by introducing a test against the state variable. If
> > the socket is in the state XSK_UNBOUND, simply abort the diagnostic's
> > netlink operation.
> > 
> > Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
> > Reported-and-tested-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

FWIW also tested that issue is no longer triggered on my local system:
Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>


> 
> > ---
> > v1 -> v2:
> >   * Added READ_ONCE for the state variable [Magnus]
> >   * Improved commit message [Maciej]
> > 
> >  net/xdp/xsk_diag.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
> > index c014217f5fa7..22b36c8143cf 100644
> > --- a/net/xdp/xsk_diag.c
> > +++ b/net/xdp/xsk_diag.c
> > @@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
> >  	sock_diag_save_cookie(sk, msg->xdiag_cookie);
> > 
> >  	mutex_lock(&xs->mutex);
> > +	if (READ_ONCE(xs->state) == XSK_UNBOUND)
> > +		goto out_nlmsg_trim;
> > +
> >  	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
> >  		goto out_nlmsg_trim;
> > 
> > 
> > base-commit: 7d35eb1a184a3f0759ad9e9cde4669b5c55b2063
> > --
> > 2.42.0


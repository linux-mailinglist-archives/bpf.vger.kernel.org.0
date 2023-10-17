Return-Path: <bpf+bounces-12459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFA57CC90C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C7B2814A6
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46F2D04B;
	Tue, 17 Oct 2023 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cr0wsbtg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B142D024;
	Tue, 17 Oct 2023 16:46:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201594;
	Tue, 17 Oct 2023 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697561178; x=1729097178;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oLtGJQ0xnpF4Jg0t/ycLfvcfgeW7k0OpuN4vC6rZCoA=;
  b=Cr0wsbtg5K9+6vrk21kz+bawfDeeRx0vZMnlCWY8BzrY2OInad37vtl3
   bVcMNbK5AzwH0ovUbanbWhhydXhXs8Xs9lwUii1mH4lYVbKJkqNKGQHbc
   Gj7WZs03NMtOji/SS7PMjwsX0Ao07VQtitjIMOnHhGTKA6RT711Q1N8jg
   Eo3gqDmQGYoAL/rugiRs7hL7tFgkTQDsTdiY76/VIMWjx8OljDKZmjR3/
   cu9fLM54IjlnEURQscFrcWaV8tHHJexGUYz1PcokM/85gGdTHmxOEjraP
   L3yxW96zmshTy611j6sBQTM2lpTlUr65vCFhp1G+3Zrj55wO2xorT60MD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385664235"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="385664235"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="749761286"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="749761286"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 09:45:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:45:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:45:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 09:45:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 09:45:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NomHe6bbinxof7yIMlLGgsDkNt/nSq51ZeqBdTzYv/I3rxYw+/TfyIdCLLD4rtfNLaU/cORAhb8EgQRlsmXkozn+Tth54sqxsdmy3o7ZkDjWQmFmK9F7vCxIBVf41E7PLUOLPF/wJ5an4hZgEJR/2gngwiLZnHQzr6FdJWL8zxgYkjyT1GLSsqJ+hhbi/K17JJA7mky5ixKKoQis1hwBP5egV6tgCGjAVCsmcDS69zvt4nv9wRP/xu5CruUkqbxViYj3xHXHpLnpkzx4SEQXDAi6oy410dSS9prQaxTGz0anRbUuHT5sIlcJb3D15a6q7r1Bm+Hd+Wrfhe/ZcoG2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfEMgBe0rR88P7q6Ix8UadomOhFMfJsn+6ty9XDpqi4=;
 b=j2lGmvnF28EM1qj99AGci21/qTu+fgbrwhrZn1pyHJMyhaCOrB3ycD7n6u06AJyhgrgLnlGEEDNcBkZFIRJJwaLiLriHo6XVm2BsKsRfejyCWp6DM0YmcCKP4pfUnjXpkceyFkSS7yQwC3FdRl5AcLOmtlX1bmkmCBqNImgWDj193CQywg92cAMLMncT/XZfTeHrOWTlo0iJE/+Qk/7xnyyRIAUr2+YiTqNk9v0NyeiQ6u6ynZLE6DdXFm6ZS50yYS91fZdrrxPCU8/IqaIlKLD5nVRubSNTn4CA2hziBGj8GITXNgKU/i/ulAGi9LuSE5jhL8v+IEqZzBYwZ7B2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4959.namprd11.prod.outlook.com (2603:10b6:a03:2de::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.46; Tue, 17 Oct 2023 16:45:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 16:45:17 +0000
Date: Tue, 17 Oct 2023 18:45:02 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Maryam Tahhan <mtahhan@redhat.com>, <xdp-hints@xdp-project.net>,
	<netdev@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Simon Horman
	<simon.horman@corigine.com>, Tariq Toukan <tariqt@mellanox.com>, "Saeed
 Mahameed" <saeedm@mellanox.com>, <magnus.karlsson@intel.com>
Subject: Re: [PATCH bpf-next v6 07/18] ice: Support XDP hints in AF_XDP ZC
 mode
Message-ID: <ZS66DrMFeuerTI01@boxer>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-8-larysa.zaremba@intel.com>
 <ZS6yqqMZD1mojQNr@boxer>
 <CAJ8uoz3Bqtb-F1bpKWKx8bhftJW7g1BEyjxnQZprRv4NxsXi9Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz3Bqtb-F1bpKWKx8bhftJW7g1BEyjxnQZprRv4NxsXi9Q@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: a194943b-3442-4081-fe3b-08dbcf307160
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsum3OqlUIosZatrKm0IaqDvnx57aV3z59C4KBNa/VXyD5XJo47j4RslPGiM6KeYwxZC/Kg9LQzfSEGrwnz1SjA9ci2NWcfdA0iXZpoAFGmj7UjRFOzEYWGchBtUQDtZ0bCq6Ez7qERrZWA2O2KXA6IZXULjehihmL/dYE4cIfeA+pkZBLnkaYCuujZ0qO33vd1BQtNAptREPeXanzUdbw/Yq5Wd+zFJILoU/LU8z20k1sj0UfJFpidzKmAld3uj+4D2YZajnUqj6ICc1fZkhE6CD9ATEDkJv+Uq20v5h55CtBQPEbLqkNxVtVfVbmBhCCMyHCtf5TIwdZ+J5P1HH6rJLC+XWYe0WUWiGdy0aXQsbVEAwXzv8VUqdlVC/3mGDAdD7L/BXOKni/zJjHspoXy3PnzIA2ZVchEyu8F0CWBzRTyfJh8woogGbKU55N6pTtrhqZP2NUwm1nioShRRDT9Vxm04ojJrORElfyqUsvLZxWSVVSK8a/HYeY7htIi3dSHfpLehXJ0u/sZlGhYUiPPGgr4Fpkn93gbNa9x4Y5Kkapyog2utBaEdMcIFsSg0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6666004)(6486002)(6916009)(66946007)(66476007)(54906003)(478600001)(83380400001)(66556008)(6512007)(38100700002)(9686003)(107886003)(26005)(44832011)(6506007)(5660300002)(2906002)(86362001)(7416002)(316002)(8676002)(8936002)(41300700001)(33716001)(82960400001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ytQmjqDz2fg5YNdZbM0evYyoJ6X0Osrqs4OtGt02IbZDbtplQyg+nn1YSpI?=
 =?us-ascii?Q?boJ+AK7mKvgSImt6UKShw6OMNDIPK3WMQKeBqjxnIUzEnJMEdY9LVVHhKJBv?=
 =?us-ascii?Q?Q/6IbWG1fNUTYHWZA6QVb6H75z5R4u3jbjFpb//5E8xr+PS+QbT6PgLMdIN3?=
 =?us-ascii?Q?GpBJ9Fj7dcZimIN3fZZUqBa9iJsEUEgP4caMB/BFCxlyrztEnON9n+DIxcCW?=
 =?us-ascii?Q?Ox6QlKHpte3WFJWRLT572433am6ArpqUxSYn/gAo4Ll0eQ/B8/x00CK6udkJ?=
 =?us-ascii?Q?vK9ZTDpoo8lh3b8sfwx3THv+ItatP/AJ5jzRBrFLw5/imLyCgipMErmoW9+4?=
 =?us-ascii?Q?1pPxO3WPar4h6XYIkDpwXtO6ofooR0StWJSS4Z+XgXa9sMAzxP+IIeLUOS0K?=
 =?us-ascii?Q?/vGwhrAwyOs0M4fIN5fEqHpujgjwTp78kr1LsWF9hxtDK8q6/g1RLrURfwJQ?=
 =?us-ascii?Q?nZTGML2UIvi3znVMmwGno+rrw/n4DbyjGKbDpd0dGylLt17oU092jEDZzvHY?=
 =?us-ascii?Q?Vv7hzdunzbVynn1G9Xiw5q1alBXMGKztuCrqpVQnwZ38GVU0kN4AJ2OiAWja?=
 =?us-ascii?Q?4foJ5GIXUglPDe9CBmKTnFMAg3wHQMgFC89hvTA4z7E2TOviwzfVR6e3nsZE?=
 =?us-ascii?Q?DnZkvpZGN/+ffwhrwzqRoogyRJeTvpbZd9LLO7X0aZVXRjlg2x8CZk2NYTym?=
 =?us-ascii?Q?d4UL/+wjsEQ4KoRd0py0hJqQ/nIEPNRZf3wI3v35fvd+U9tSI5TX3wo4pZnR?=
 =?us-ascii?Q?CsRr7MTxhujO2lKby8fllL+LmChx8GZAoYySD2fTfQpXAZDUcrJquJbYXIZa?=
 =?us-ascii?Q?iGh/C7F+IRTrv9awGMidvNkz1lGIeTvBuLlEVb37nhjdp4CjtGZHc5qUJAPo?=
 =?us-ascii?Q?QHFbO9gjZprpWH2Rz7taREPfqzqFolpKpPsnQWiq/gtZUP6e/1t9MphIUsf/?=
 =?us-ascii?Q?84gukXNN1dFd0S1zf77cMLP+tTJTQWsdeKx7gItoCj84hZlF51T94DU7x0GY?=
 =?us-ascii?Q?8H1Nf/owu1wHAer9XI2gxf8rGT4ySGs93961vCAOcdQ4z2hWIp2DyNa/csp5?=
 =?us-ascii?Q?WbeDquelM4gknnrkmzA9s8tBr4sF9zUl/Yik3JAXzmG7NxSGmtsNijWd+lfU?=
 =?us-ascii?Q?kUJs2pvAXGShtwiD2h7J+wC3BmpDhdaR6RIOlQ81OSO+oD6egxUqFYwatCol?=
 =?us-ascii?Q?eivuu8VdAa77AFEr8YCoagIjxIzTgtEcWVgAsnYaPa12wpUdLaOBpCKLIC3I?=
 =?us-ascii?Q?Bdt9/KOBANcptjQ22aR7znnLbInR4APAfAu49ucEMudHe80jazpkluI2cxn5?=
 =?us-ascii?Q?HT1m4wa7ClyMx9v5aOGCPf0ZotiA2mShPwND2+dKZ3p0G2p9gdQhWk2n+3uH?=
 =?us-ascii?Q?Dz8/BrXWbFU5e2XVNyvqT+EkddT+pBruHCneB+7+pQ7/SS5sYJS2Bs1esqEy?=
 =?us-ascii?Q?77WIUou+OMQtdoI89/IKBNqrTKn1PqRMzr2D2XI35UKAF1Bdy/jT5wDd6U/G?=
 =?us-ascii?Q?k8eAo2o9RvVzi46naKMLtwliuptvg0hNlB4gZvGOhbWE3NeF8pYhbQ9Pbwjr?=
 =?us-ascii?Q?iujK50OZ7z56wbFEGKQy+MKRLcLkTRMeaPcMHBysQgjJbgcSVOIuhm157oN2?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a194943b-3442-4081-fe3b-08dbcf307160
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:45:17.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFhCGOOnKsPDvf1S3ZetTyY/oqfVyeBmqRyMLK+OkJLCfRyj69vPVoO936+H0sG+xbCdEk5BJvYfAeu9MgU8tBh8zgVOuCY7V1SJ77VklFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4959
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 06:37:07PM +0200, Magnus Karlsson wrote:
> On Tue, 17 Oct 2023 at 18:13, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, Oct 12, 2023 at 07:05:13PM +0200, Larysa Zaremba wrote:
> > > In AF_XDP ZC, xdp_buff is not stored on ring,
> > > instead it is provided by xsk_buff_pool.
> > > Space for metadata sources right after such buffers was already reserved
> > > in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> > > This makes the implementation rather straightforward.
> > >
> > > Update AF_XDP ZC packet processing to support XDP hints.
> > >
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_xsk.c | 34 ++++++++++++++++++++++--
> > >  1 file changed, 32 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > index ef778b8e6d1b..6ca620b2fbdd 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > @@ -752,22 +752,51 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
> > >       return ICE_XDP_CONSUMED;
> > >  }
> > >
> > > +/**
> > > + * ice_prepare_pkt_ctx_zc - Prepare packet context for XDP hints
> > > + * @xdp: xdp_buff used as input to the XDP program
> > > + * @eop_desc: End of packet descriptor
> > > + * @rx_ring: Rx ring with packet context
> > > + *
> > > + * In regular XDP, xdp_buff is placed inside the ring structure,
> > > + * just before the packet context, so the latter can be accessed
> > > + * with xdp_buff address only at all times, but in ZC mode,
> > > + * xdp_buffs come from the pool, so we need to reinitialize
> > > + * context for every packet.
> > > + *
> > > + * We can safely convert xdp_buff_xsk to ice_xdp_buff,
> > > + * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> > > + * right after xdp_buff, for our private use.
> > > + * XSK_CHECK_PRIV_TYPE() ensures we do not go above the limit.
> > > + */
> > > +static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> > > +                                union ice_32b_rx_flex_desc *eop_desc,
> > > +                                struct ice_rx_ring *rx_ring)
> > > +{
> > > +     XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> > > +     ((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
> >
> > I will be loud thinking over here, but this could be set in
> > ice_fill_rx_descs(), while grabbing xdp_buffs from xsk_pool, should
> > minimize the performance overhead.
> >
> > But then again you address that with static branch in later patch.
> >
> > OTOH, I was thinking that we could come with xsk_buff_pool API that would
> > let drivers assign this at setup time. Similar what is being done with dma
> > mappings.
> >
> > Magnus, do you think it is worth the hassle? Thoughts?
> 
> I would measure the overhead of the current assignment and if it is
> significant (incurs a cache miss for example), then why not try out
> your idea. Usually good not to have to touch things when not needed.

Larysa measured that because I asked for that previously and impact was
around 6%. Then look at patch 11/18 how this was addressed.

Other ZC drivers didn't report the impact but i am rather sure they were also
affected. So i was thinking whether we should have some generic solution
within pool or every ZC driver handles that on its own.

> 
> > Or should we advise any other driver that support hints to mimic static
> > branch solution?
> >
> > > +     ice_xdp_meta_set_desc(xdp, eop_desc);
> > > +}
> > > +
> > >  /**
> > >   * ice_run_xdp_zc - Executes an XDP program in zero-copy path
> > >   * @rx_ring: Rx ring
> > >   * @xdp: xdp_buff used as input to the XDP program
> > >   * @xdp_prog: XDP program to run
> > >   * @xdp_ring: ring to be used for XDP_TX action
> > > + * @rx_desc: packet descriptor
> > >   *
> > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > >   */
> > >  static int
> > >  ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > -            struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
> > > +            struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > +            union ice_32b_rx_flex_desc *rx_desc)
> > >  {
> > >       int err, result = ICE_XDP_PASS;
> > >       u32 act;
> > >
> > > +     ice_prepare_pkt_ctx_zc(xdp, rx_desc, rx_ring);
> > >       act = bpf_prog_run_xdp(xdp_prog, xdp);
> > >
> > >       if (likely(act == XDP_REDIRECT)) {
> > > @@ -907,7 +936,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> > >               if (ice_is_non_eop(rx_ring, rx_desc))
> > >                       continue;
> > >
> > > -             xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
> > > +             xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
> > > +                                      rx_desc);
> > >               if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> > >                       xdp_xmit |= xdp_res;
> > >               } else if (xdp_res == ICE_XDP_EXIT) {
> > > --
> > > 2.41.0
> > >


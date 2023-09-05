Return-Path: <bpf+bounces-9268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB8E792C56
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 19:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B081C209F1
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FD3DDB4;
	Tue,  5 Sep 2023 17:24:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB738D524;
	Tue,  5 Sep 2023 17:24:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E169C6EE;
	Tue,  5 Sep 2023 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693934649; x=1725470649;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cy0Tby6m1rM1isr8LGI7CeyECDFm0NLx0MC6IcEVGUk=;
  b=D6JHxR4LQBbMQUdaAnlNL+Mjbs6iRB4VtlpeXGmdh8wAzNKkUCREDgjI
   PRXzZlwfjoO8U7XVzI9yxUJSqMedbgJZQU8UevhQZTWRuEJvJkotU46cj
   pG5w2sq0nJIwyU0TIDEcCCjbftfB8vvo4M50o6ZKSaAt1cXPgV9bDj8dP
   r2p6aJkhZLVvvdbEySdgYphfgGzd+HCyxGZ07OlsIKvZkEaNCjc9Q2vFU
   HLavSe1dY2CkKqFWI6wi+5HEPu4mMAOEwjmn3YqrM3DlUBJJxeQ9x6/M0
   ECs58epFFoRf4ABJS/bvn5AAEDgD8fVU9uhL/BaXFgyocUXIMW77e5uEx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="463228642"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="463228642"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="1072047761"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="1072047761"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 10:18:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 10:18:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 10:18:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 10:18:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 10:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRsz73AGdKyvsXWopluChH5ueUetpDTIPMbizDG7VNDL9gUQqj+n513rMlLvckAJuog+xRVSDbseAgJ/Eb5mfVBv0FzS/dOZ4T200ePAbULqhmHjD0GZvmoLl1lGZjUM89Q9ne6VbIzTbyxdDlJeJmQWdXN0FT8f20eq9eFNn51NHpDwJGuehA9umj930K7YKTnfp7Hu1j6dD/4grZJzV/gyr0H0/c/hwRUNQ/c5MD3UPDBipjdBPXvspjagRnDlriW4usHBFtGVpOMLHcrIvpgifxN3jmhIF0dUGzc8KjQMxS/XTRt76XR5SKJdPDsCsCpbH16g5nCV+JPdzswBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvA2Lsfv1qMjVnrnlV0ODUXtZ2NUy59zVa6/CcRWLLo=;
 b=I8rJ+0ToQj9xLdcf4+3HUDsKS2sdO2sSuBjg0gyGscceLIbWKJC+5FOovDCIntD7sQEA07sC3YzQE3yOQY+TaAvfLvSJncQESQyNxPtpP5bmWBSOEiGCAgxTbiE+Ap5kgWt4Uvtg/6UwoLN9qVfOD3W/fiWBYWDwlh5nnzXtDsHjr60vlDm9MqzAXaGV0p9f7OCVda6PY/0M52ZRDqXbG5L1spLZA2svVR3ObvorxmSw/XEsba2WI5OZY71GJxj7dwicb7S/A+GNC7h07JaHfSlyCQuIaTWpGADKBfWZzYpiwtxQDOrunEXik26uDBgd/eY5otp5sJAIjj1ZPUS6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB6220.namprd11.prod.outlook.com (2603:10b6:208:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 17:18:22 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 17:18:22 +0000
Date: Tue, 5 Sep 2023 19:09:54 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [xdp-hints] [RFC bpf-next 07/23] ice: Support RX hash XDP hint
Message-ID: <ZPdg4hYQ71B+dvmT@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-8-larysa.zaremba@intel.com>
 <ZPdMTG6INvxUV0Jh@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPdMTG6INvxUV0Jh@boxer>
X-ClientProxiedBy: DU2PR04CA0355.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::34) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4eda13-e383-48f3-694c-08dbae341a24
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 164gW6307nMCyzTdZSZCV+3OiyCVSa7oSeWk9iHAg87rFD/1m6CQ3daZ+qzep9FPlLnapvlfNA67XI2pVOJ7XzOtnorXT/U5++jYUEA4TICIlHdNGUasxTI+HvB14cWw4Ww2E510XUjgTQMiZrlQL6waW2ntiTG+Nr3IaXrF0vBLQRr1ZXduT7XVNM1xhyOoiPHPRSUESPPjyCmMAX++V24G6iVZrGpT/Uu77z3zWIJ95RlYhNYEzohK4VQ61DFC41XUGCsBOfiH+T4/CQOIB1ESEVUCKL9uRQxQMXH8tW2qt7ivYgC7AuJahgiZp/mt22JFtuX7Wo4XtDbfWxiAOdAAy0hFyTJAI84ATMTVSpdeIHoTAnKNNtIoS1ALdepfDYtLKMAAe9Lq7oxRVuaMpza/dawvMut2dMQ1jkYOAyfC75tBDqIFAjxqZk4faKlE1BK3TzZHneXVCIbP31z20vwunzLOYqx90w3dnaUApjd+/6Fjubhqo2WrnYvbtipP1A3w1gof124NM/+uafVGBhCl2q9aGpysnomqNuhvKaL/v07WD/ffN8hS89zi9Z0suiCYuDz1CWKkmLwQXDhoCSr2Ugxf62WQR7tBCbGWegeCh3LWNcCJ/maYrfJ8yBlq42mitCN1P9IAInikTl0RGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(396003)(346002)(366004)(186009)(451199024)(1800799009)(41300700001)(7416002)(38100700002)(33716001)(82960400001)(86362001)(6666004)(478600001)(83380400001)(26005)(9686003)(6512007)(6486002)(6506007)(66946007)(54906003)(66476007)(2906002)(6636002)(66556008)(316002)(30864003)(8936002)(5660300002)(44832011)(6862004)(8676002)(4326008)(21314003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ScnRMgLcv3nSEteInXJw+mmKVVutM1VRRxKN22hB+gLZoSajpt7DNnDfpJIl?=
 =?us-ascii?Q?cJzF7Ls2Dw3DRqHmYpK8oTn35Hywh4LZbzzDdUamnJF9z/Yii50dZ29h74lq?=
 =?us-ascii?Q?0oL8U4cyX+kKXFyRY3X9qCn2joWbHk1GaLx0ShFwyvGjhriq5HSnB9vdYNte?=
 =?us-ascii?Q?HNxW+nGAXS0+XxTgdU6gB5tnDyXAUxefeT6rX9VS6I0Vt623EMJU6TlKd6uM?=
 =?us-ascii?Q?qwhclCMgzJR/CiypHulf4yV53sYz9+YpJ5hIVtkNpPeMeZwVYryOwFyg4r4Y?=
 =?us-ascii?Q?nnZ5FRPdCrTxeJVp7lHYaosgR3mH6MPwnN5TCxPr0GtrBquDLZADGopFUpd+?=
 =?us-ascii?Q?VWT/fVGKWi/S+BToVX8doWA5haIP4u+9nhIm/PdcECMGT0Gw1ZkBhKUJZ7Zh?=
 =?us-ascii?Q?3cfmCaRf9Fqtk6Ts7pbzo42m2KlyCiytTowAzUnaDDp8/QVhTZ6MWXsfiQGA?=
 =?us-ascii?Q?4KBmWuR6sqJzuJzT7CNP4V+j1T6HjMI5Tx/nToenmYdtH2gi83Mw/cywr0xr?=
 =?us-ascii?Q?RkVMYKVFXZhV3OAN0x+x9BdfagLVBVlIdEtzCjPWqhPWKiU55vLXYELJ0A6o?=
 =?us-ascii?Q?vW+3JZnz/UUV1L3FidPKoexsYZaA6Y+jRnK6INq9MVQXHgkGrVoz79aLGNQ6?=
 =?us-ascii?Q?YHNPnJf3Iqohadeg8+9cD16+ypz285KiFKsj8l0/tjz4y867Q3jbr8r6La4r?=
 =?us-ascii?Q?s0iRlrCO4heMiP7emX0TG8ilVAEgU9479apzq4MrZVKmt5EgWbTPcwTdf7uz?=
 =?us-ascii?Q?j7HC+MbCAw3FG3dHj7NFV9nxpqCSpzMDgHzwL4IUL4+SP7T2W0KysolNcybJ?=
 =?us-ascii?Q?OF3/h9Z+Po3xWvZxEywS257uYNwrP0vvrqVkVuxmPG3mUoZ8a8ZdoOFS8+x+?=
 =?us-ascii?Q?N6uYr8dLq1kisdfRaXwp8r6gKjcIj7mc68aQsgCjnxu1ZlG9HYuRDfDfwb02?=
 =?us-ascii?Q?nTO43O4OI42Fi+j508Qf/v4+T0cT4xFt/ku7/ZYzGhaUrUiHFtIweQUn/bEG?=
 =?us-ascii?Q?Bf3Mg9dipnUV/o+Njsesk3bdJfDGZ/fN47yA0B+L4w8g6eZI5TQx6CHBYTJA?=
 =?us-ascii?Q?6S8SUWf+ACXljFTHSZSj2GcqKai0BgdTbVpS8fUAXWeHgDZStnALtBOoYSgn?=
 =?us-ascii?Q?DkHn0K7xprxCtoZlmShad1KjAjxzXk8IrY1/tfKoW5XccdavKrOoVwYYeF5b?=
 =?us-ascii?Q?eFMLqn6ULAz7m41QWdcCOQQwZ/h/Z7kmjwON3SeXNRPKCi/e+Xn0AHYCXvCh?=
 =?us-ascii?Q?0S0Ctx+Jg3tksIqPqyxx1VQO0LooRkPrbtveqB5xttLdA5kKxLCXKtLSflcW?=
 =?us-ascii?Q?xEhS4JpyjyEpizxZ+BOAhSh3XkkElCnY2FePvQtOoDUqrfwDoPFJp5IVjy2C?=
 =?us-ascii?Q?2ugciLV0sox+DkXnYnlMua6clmzjNhDEDxqf1v9R9upZECzS64SXahY6n2dF?=
 =?us-ascii?Q?jDXpFj+349chEGn3nAffhbYlPrnvteoGIHvhC4BLnnwJR1nmG6OpaaGS3LqB?=
 =?us-ascii?Q?8JUtteHK17x+x5ThkEOnr/gK03xXzdcpBUACXNWAIplhZ8xqHQRzo358KAge?=
 =?us-ascii?Q?wmbQ5LyJI8cE2Zq7GCrWhFmFVx2TwKrucS5JsQWLU3JujSIou+H8/vlbnWyt?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4eda13-e383-48f3-694c-08dbae341a24
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 17:18:22.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7csW/Hr49enjvR0o/0b5KdHSpk2MEp+oU8PdzXKfsVzkovGqOUuUjshassysnPv2CQBuH+z4ubCKacjS/ypYYfAhnky08El7iFucZcDs+Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6220
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 05:42:04PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 24, 2023 at 09:26:46PM +0200, Larysa Zaremba wrote:
> > RX hash XDP hint requests both hash value and type.
> > Type is XDP-specific, so we need a separate way to map
> > these values to the hardware ptypes, so create a lookup table.
> > 
> > Instead of creating a new long list, reuse contents
> > of ice_decode_rx_desc_ptype[] through preprocessor.
> > 
> > Current hash type enum does not contain ICMP packet type,
> > but ice devices support it, so also add a new type into core code.
> > 
> > Then use previously refactored code and create a function
> > that allows XDP code to read RX hash.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 412 +++++++++---------
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  73 ++++
> >  include/net/xdp.h                             |   3 +
> >  3 files changed, 284 insertions(+), 204 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> > index 89f986a75cc8..d384ddfcb83e 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> > +++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
> > @@ -673,6 +673,212 @@ struct ice_tlan_ctx {
> >   *      Use the enum ice_rx_l2_ptype to decode the packet type
> >   * ENDIF
> >   */
> > +#define ICE_PTYPES								\
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #34: FILE: drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h:676:
> +#define ICE_PTYPES                                                             \
>

If I remember correctly, I have tried to fix this by adding parentheses, but 
this would break the array definition.

Also XDP_METADATA_KFUNC_xxx is defined the same way.

> (...)
> 
> > +	/* L2 Packet types */							\
> > +	ICE_PTT_UNUSED_ENTRY(0),						\
> > +	ICE_PTT(1, L2, NONE, NOF, NONE, NONE, NOF, NONE, PAY2),			\
> > +	ICE_PTT_UNUSED_ENTRY(2),						\
> > +	ICE_PTT_UNUSED_ENTRY(3),						\
> > +	ICE_PTT_UNUSED_ENTRY(4),						\
> > +	ICE_PTT_UNUSED_ENTRY(5),						\
> > +	ICE_PTT(6, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),			\
> > +	ICE_PTT(7, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),			\
> > +	ICE_PTT_UNUSED_ENTRY(8),						\
> > +	ICE_PTT_UNUSED_ENTRY(9),						\
> > +	ICE_PTT(10, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),		\
> > +	ICE_PTT(11, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),		\
> > +	ICE_PTT_UNUSED_ENTRY(12),						\
> > +	ICE_PTT_UNUSED_ENTRY(13),						\
> > +	ICE_PTT_UNUSED_ENTRY(14),						\
> > +	ICE_PTT_UNUSED_ENTRY(15),						\
> > +	ICE_PTT_UNUSED_ENTRY(16),						\
> > +	ICE_PTT_UNUSED_ENTRY(17),						\
> > +	ICE_PTT_UNUSED_ENTRY(18),						\
> > +	ICE_PTT_UNUSED_ENTRY(19),						\
> > +	ICE_PTT_UNUSED_ENTRY(20),						\
> > +	ICE_PTT_UNUSED_ENTRY(21),						\
> > +										\
> > +	/* Non Tunneled IPv4 */							\
> > +	ICE_PTT(22, IP, IPV4, FRG, NONE, NONE, NOF, NONE, PAY3),		\
> > +	ICE_PTT(23, IP, IPV4, NOF, NONE, NONE, NOF, NONE, PAY3),		\
> > +	ICE_PTT(24, IP, IPV4, NOF, NONE, NONE, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(25),						\
> > +	ICE_PTT(26, IP, IPV4, NOF, NONE, NONE, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(27, IP, IPV4, NOF, NONE, NONE, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(28, IP, IPV4, NOF, NONE, NONE, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv4 --> IPv4 */							\
> > +	ICE_PTT(29, IP, IPV4, NOF, IP_IP, IPV4, FRG, NONE, PAY3),		\
> > +	ICE_PTT(30, IP, IPV4, NOF, IP_IP, IPV4, NOF, NONE, PAY3),		\
> > +	ICE_PTT(31, IP, IPV4, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(32),						\
> > +	ICE_PTT(33, IP, IPV4, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(34, IP, IPV4, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(35, IP, IPV4, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv4 --> IPv6 */							\
> > +	ICE_PTT(36, IP, IPV4, NOF, IP_IP, IPV6, FRG, NONE, PAY3),		\
> > +	ICE_PTT(37, IP, IPV4, NOF, IP_IP, IPV6, NOF, NONE, PAY3),		\
> > +	ICE_PTT(38, IP, IPV4, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(39),						\
> > +	ICE_PTT(40, IP, IPV4, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(41, IP, IPV4, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(42, IP, IPV4, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv4 --> GRE/NAT */							\
> > +	ICE_PTT(43, IP, IPV4, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),		\
> > +										\
> > +	/* IPv4 --> GRE/NAT --> IPv4 */						\
> > +	ICE_PTT(44, IP, IPV4, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),		\
> > +	ICE_PTT(45, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),		\
> > +	ICE_PTT(46, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(47),						\
> > +	ICE_PTT(48, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(49, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(50, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv4 --> GRE/NAT --> IPv6 */						\
> > +	ICE_PTT(51, IP, IPV4, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),		\
> > +	ICE_PTT(52, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),		\
> > +	ICE_PTT(53, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(54),						\
> > +	ICE_PTT(55, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(56, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(57, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv4 --> GRE/NAT --> MAC */						\
> > +	ICE_PTT(58, IP, IPV4, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),	\
> > +										\
> > +	/* IPv4 --> GRE/NAT --> MAC --> IPv4 */					\
> > +	ICE_PTT(59, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),	\
> > +	ICE_PTT(60, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),	\
> > +	ICE_PTT(61, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),	\
> > +	ICE_PTT_UNUSED_ENTRY(62),						\
> > +	ICE_PTT(63, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),	\
> > +	ICE_PTT(64, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),	\
> > +	ICE_PTT(65, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),	\
> > +										\
> > +	/* IPv4 --> GRE/NAT -> MAC --> IPv6 */					\
> > +	ICE_PTT(66, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),	\
> > +	ICE_PTT(67, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),	\
> > +	ICE_PTT(68, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),	\
> > +	ICE_PTT_UNUSED_ENTRY(69),						\
> > +	ICE_PTT(70, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),	\
> > +	ICE_PTT(71, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),	\
> > +	ICE_PTT(72, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),	\
> > +										\
> > +	/* IPv4 --> GRE/NAT --> MAC/VLAN */					\
> > +	ICE_PTT(73, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),	\
> > +										\
> > +	/* IPv4 ---> GRE/NAT -> MAC/VLAN --> IPv4 */				\
> > +	ICE_PTT(74, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),	\
> > +	ICE_PTT(75, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),	\
> > +	ICE_PTT(76, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),	\
> > +	ICE_PTT_UNUSED_ENTRY(77),						\
> > +	ICE_PTT(78, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),	\
> > +	ICE_PTT(79, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),	\
> > +	ICE_PTT(80, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),	\
> > +										\
> > +	/* IPv4 -> GRE/NAT -> MAC/VLAN --> IPv6 */				\
> > +	ICE_PTT(81, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),	\
> > +	ICE_PTT(82, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),	\
> > +	ICE_PTT(83, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),	\
> > +	ICE_PTT_UNUSED_ENTRY(84),						\
> > +	ICE_PTT(85, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),	\
> > +	ICE_PTT(86, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),	\
> > +	ICE_PTT(87, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),	\
> > +										\
> > +	/* Non Tunneled IPv6 */							\
> > +	ICE_PTT(88, IP, IPV6, FRG, NONE, NONE, NOF, NONE, PAY3),		\
> > +	ICE_PTT(89, IP, IPV6, NOF, NONE, NONE, NOF, NONE, PAY3),		\
> > +	ICE_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(91),						\
> > +	ICE_PTT(92, IP, IPV6, NOF, NONE, NONE, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(93, IP, IPV6, NOF, NONE, NONE, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(94, IP, IPV6, NOF, NONE, NONE, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv6 --> IPv4 */							\
> > +	ICE_PTT(95, IP, IPV6, NOF, IP_IP, IPV4, FRG, NONE, PAY3),		\
> > +	ICE_PTT(96, IP, IPV6, NOF, IP_IP, IPV4, NOF, NONE, PAY3),		\
> > +	ICE_PTT(97, IP, IPV6, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(98),						\
> > +	ICE_PTT(99, IP, IPV6, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(100, IP, IPV6, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(101, IP, IPV6, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv6 --> IPv6 */							\
> > +	ICE_PTT(102, IP, IPV6, NOF, IP_IP, IPV6, FRG, NONE, PAY3),		\
> > +	ICE_PTT(103, IP, IPV6, NOF, IP_IP, IPV6, NOF, NONE, PAY3),		\
> > +	ICE_PTT(104, IP, IPV6, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(105),						\
> > +	ICE_PTT(106, IP, IPV6, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(107, IP, IPV6, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(108, IP, IPV6, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv6 --> GRE/NAT */							\
> > +	ICE_PTT(109, IP, IPV6, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),		\
> > +										\
> > +	/* IPv6 --> GRE/NAT -> IPv4 */						\
> > +	ICE_PTT(110, IP, IPV6, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),		\
> > +	ICE_PTT(111, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),		\
> > +	ICE_PTT(112, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(113),						\
> > +	ICE_PTT(114, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(115, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(116, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv6 --> GRE/NAT -> IPv6 */						\
> > +	ICE_PTT(117, IP, IPV6, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),		\
> > +	ICE_PTT(118, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),		\
> > +	ICE_PTT(119, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),		\
> > +	ICE_PTT_UNUSED_ENTRY(120),						\
> > +	ICE_PTT(121, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),		\
> > +	ICE_PTT(122, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),		\
> > +	ICE_PTT(123, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),		\
> > +										\
> > +	/* IPv6 --> GRE/NAT -> MAC */						\
> > +	ICE_PTT(124, IP, IPV6, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),	\
> > +										\
> > +	/* IPv6 --> GRE/NAT -> MAC -> IPv4 */					\
> > +	ICE_PTT(125, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),	\
> > +	ICE_PTT(126, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),	\
> > +	ICE_PTT(127, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),	\
> > +	ICE_PTT_UNUSED_ENTRY(128),						\
> > +	ICE_PTT(129, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),	\
> > +	ICE_PTT(130, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),	\
> > +	ICE_PTT(131, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),	\
> > +										\
> > +	/* IPv6 --> GRE/NAT -> MAC -> IPv6 */					\
> > +	ICE_PTT(132, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),	\
> > +	ICE_PTT(133, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),	\
> > +	ICE_PTT(134, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),	\
> > +	ICE_PTT_UNUSED_ENTRY(135),						\
> > +	ICE_PTT(136, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),	\
> > +	ICE_PTT(137, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),	\
> > +	ICE_PTT(138, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),	\
> > +										\
> > +	/* IPv6 --> GRE/NAT -> MAC/VLAN */					\
> > +	ICE_PTT(139, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),	\
> > +										\
> > +	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv4 */				\
> > +	ICE_PTT(140, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),	\
> > +	ICE_PTT(141, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),	\
> > +	ICE_PTT(142, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),	\
> > +	ICE_PTT_UNUSED_ENTRY(143),						\
> > +	ICE_PTT(144, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),	\
> > +	ICE_PTT(145, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),	\
> > +	ICE_PTT(146, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),	\
> > +										\
> > +	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv6 */				\
> > +	ICE_PTT(147, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),	\
> > +	ICE_PTT(148, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),	\
> > +	ICE_PTT(149, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),	\
> > +	ICE_PTT_UNUSED_ENTRY(150),						\
> > +	ICE_PTT(151, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),	\
> > +	ICE_PTT(152, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),	\
> > +	ICE_PTT(153, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
> > +
> > +#define ICE_NUM_DEFINED_PTYPES	154
> >  
> >  /* macro to make the table lines short, use explicit indexing with [PTYPE] */
> >  #define ICE_PTT(PTYPE, OUTER_IP, OUTER_IP_VER, OUTER_FRAG, T, TE, TEF, I, PL)\
> > @@ -695,212 +901,10 @@ struct ice_tlan_ctx {
> >  
> >  /* Lookup table mapping in the 10-bit HW PTYPE to the bit field for decoding */
> >  static const struct ice_rx_ptype_decoded ice_ptype_lkup[BIT(10)] = {
> > -	/* L2 Packet types */
> > -	ICE_PTT_UNUSED_ENTRY(0),
> > -	ICE_PTT(1, L2, NONE, NOF, NONE, NONE, NOF, NONE, PAY2),
> > -	ICE_PTT_UNUSED_ENTRY(2),
> > -	ICE_PTT_UNUSED_ENTRY(3),
> > -	ICE_PTT_UNUSED_ENTRY(4),
> > -	ICE_PTT_UNUSED_ENTRY(5),
> > -	ICE_PTT(6, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
> > -	ICE_PTT(7, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
> > -	ICE_PTT_UNUSED_ENTRY(8),
> > -	ICE_PTT_UNUSED_ENTRY(9),
> > -	ICE_PTT(10, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
> > -	ICE_PTT(11, L2, NONE, NOF, NONE, NONE, NOF, NONE, NONE),
> > -	ICE_PTT_UNUSED_ENTRY(12),
> > -	ICE_PTT_UNUSED_ENTRY(13),
> > -	ICE_PTT_UNUSED_ENTRY(14),
> > -	ICE_PTT_UNUSED_ENTRY(15),
> > -	ICE_PTT_UNUSED_ENTRY(16),
> > -	ICE_PTT_UNUSED_ENTRY(17),
> > -	ICE_PTT_UNUSED_ENTRY(18),
> > -	ICE_PTT_UNUSED_ENTRY(19),
> > -	ICE_PTT_UNUSED_ENTRY(20),
> > -	ICE_PTT_UNUSED_ENTRY(21),
> > -
> > -	/* Non Tunneled IPv4 */
> > -	ICE_PTT(22, IP, IPV4, FRG, NONE, NONE, NOF, NONE, PAY3),
> > -	ICE_PTT(23, IP, IPV4, NOF, NONE, NONE, NOF, NONE, PAY3),
> > -	ICE_PTT(24, IP, IPV4, NOF, NONE, NONE, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(25),
> > -	ICE_PTT(26, IP, IPV4, NOF, NONE, NONE, NOF, TCP,  PAY4),
> > -	ICE_PTT(27, IP, IPV4, NOF, NONE, NONE, NOF, SCTP, PAY4),
> > -	ICE_PTT(28, IP, IPV4, NOF, NONE, NONE, NOF, ICMP, PAY4),
> > -
> > -	/* IPv4 --> IPv4 */
> > -	ICE_PTT(29, IP, IPV4, NOF, IP_IP, IPV4, FRG, NONE, PAY3),
> > -	ICE_PTT(30, IP, IPV4, NOF, IP_IP, IPV4, NOF, NONE, PAY3),
> > -	ICE_PTT(31, IP, IPV4, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(32),
> > -	ICE_PTT(33, IP, IPV4, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),
> > -	ICE_PTT(34, IP, IPV4, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),
> > -	ICE_PTT(35, IP, IPV4, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),
> > -
> > -	/* IPv4 --> IPv6 */
> > -	ICE_PTT(36, IP, IPV4, NOF, IP_IP, IPV6, FRG, NONE, PAY3),
> > -	ICE_PTT(37, IP, IPV4, NOF, IP_IP, IPV6, NOF, NONE, PAY3),
> > -	ICE_PTT(38, IP, IPV4, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(39),
> > -	ICE_PTT(40, IP, IPV4, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),
> > -	ICE_PTT(41, IP, IPV4, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),
> > -	ICE_PTT(42, IP, IPV4, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),
> > -
> > -	/* IPv4 --> GRE/NAT */
> > -	ICE_PTT(43, IP, IPV4, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),
> > -
> > -	/* IPv4 --> GRE/NAT --> IPv4 */
> > -	ICE_PTT(44, IP, IPV4, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),
> > -	ICE_PTT(45, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),
> > -	ICE_PTT(46, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(47),
> > -	ICE_PTT(48, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),
> > -	ICE_PTT(49, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),
> > -	ICE_PTT(50, IP, IPV4, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),
> > -
> > -	/* IPv4 --> GRE/NAT --> IPv6 */
> > -	ICE_PTT(51, IP, IPV4, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),
> > -	ICE_PTT(52, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),
> > -	ICE_PTT(53, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(54),
> > -	ICE_PTT(55, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),
> > -	ICE_PTT(56, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),
> > -	ICE_PTT(57, IP, IPV4, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),
> > -
> > -	/* IPv4 --> GRE/NAT --> MAC */
> > -	ICE_PTT(58, IP, IPV4, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),
> > -
> > -	/* IPv4 --> GRE/NAT --> MAC --> IPv4 */
> > -	ICE_PTT(59, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),
> > -	ICE_PTT(60, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),
> > -	ICE_PTT(61, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(62),
> > -	ICE_PTT(63, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),
> > -	ICE_PTT(64, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),
> > -	ICE_PTT(65, IP, IPV4, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),
> > -
> > -	/* IPv4 --> GRE/NAT -> MAC --> IPv6 */
> > -	ICE_PTT(66, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),
> > -	ICE_PTT(67, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),
> > -	ICE_PTT(68, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(69),
> > -	ICE_PTT(70, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),
> > -	ICE_PTT(71, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),
> > -	ICE_PTT(72, IP, IPV4, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),
> > -
> > -	/* IPv4 --> GRE/NAT --> MAC/VLAN */
> > -	ICE_PTT(73, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),
> > -
> > -	/* IPv4 ---> GRE/NAT -> MAC/VLAN --> IPv4 */
> > -	ICE_PTT(74, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),
> > -	ICE_PTT(75, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),
> > -	ICE_PTT(76, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(77),
> > -	ICE_PTT(78, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),
> > -	ICE_PTT(79, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),
> > -	ICE_PTT(80, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),
> > -
> > -	/* IPv4 -> GRE/NAT -> MAC/VLAN --> IPv6 */
> > -	ICE_PTT(81, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),
> > -	ICE_PTT(82, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),
> > -	ICE_PTT(83, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(84),
> > -	ICE_PTT(85, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),
> > -	ICE_PTT(86, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),
> > -	ICE_PTT(87, IP, IPV4, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
> > -
> > -	/* Non Tunneled IPv6 */
> > -	ICE_PTT(88, IP, IPV6, FRG, NONE, NONE, NOF, NONE, PAY3),
> > -	ICE_PTT(89, IP, IPV6, NOF, NONE, NONE, NOF, NONE, PAY3),
> > -	ICE_PTT(90, IP, IPV6, NOF, NONE, NONE, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(91),
> > -	ICE_PTT(92, IP, IPV6, NOF, NONE, NONE, NOF, TCP,  PAY4),
> > -	ICE_PTT(93, IP, IPV6, NOF, NONE, NONE, NOF, SCTP, PAY4),
> > -	ICE_PTT(94, IP, IPV6, NOF, NONE, NONE, NOF, ICMP, PAY4),
> > -
> > -	/* IPv6 --> IPv4 */
> > -	ICE_PTT(95, IP, IPV6, NOF, IP_IP, IPV4, FRG, NONE, PAY3),
> > -	ICE_PTT(96, IP, IPV6, NOF, IP_IP, IPV4, NOF, NONE, PAY3),
> > -	ICE_PTT(97, IP, IPV6, NOF, IP_IP, IPV4, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(98),
> > -	ICE_PTT(99, IP, IPV6, NOF, IP_IP, IPV4, NOF, TCP,  PAY4),
> > -	ICE_PTT(100, IP, IPV6, NOF, IP_IP, IPV4, NOF, SCTP, PAY4),
> > -	ICE_PTT(101, IP, IPV6, NOF, IP_IP, IPV4, NOF, ICMP, PAY4),
> > -
> > -	/* IPv6 --> IPv6 */
> > -	ICE_PTT(102, IP, IPV6, NOF, IP_IP, IPV6, FRG, NONE, PAY3),
> > -	ICE_PTT(103, IP, IPV6, NOF, IP_IP, IPV6, NOF, NONE, PAY3),
> > -	ICE_PTT(104, IP, IPV6, NOF, IP_IP, IPV6, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(105),
> > -	ICE_PTT(106, IP, IPV6, NOF, IP_IP, IPV6, NOF, TCP,  PAY4),
> > -	ICE_PTT(107, IP, IPV6, NOF, IP_IP, IPV6, NOF, SCTP, PAY4),
> > -	ICE_PTT(108, IP, IPV6, NOF, IP_IP, IPV6, NOF, ICMP, PAY4),
> > -
> > -	/* IPv6 --> GRE/NAT */
> > -	ICE_PTT(109, IP, IPV6, NOF, IP_GRENAT, NONE, NOF, NONE, PAY3),
> > -
> > -	/* IPv6 --> GRE/NAT -> IPv4 */
> > -	ICE_PTT(110, IP, IPV6, NOF, IP_GRENAT, IPV4, FRG, NONE, PAY3),
> > -	ICE_PTT(111, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, NONE, PAY3),
> > -	ICE_PTT(112, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(113),
> > -	ICE_PTT(114, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, TCP,  PAY4),
> > -	ICE_PTT(115, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, SCTP, PAY4),
> > -	ICE_PTT(116, IP, IPV6, NOF, IP_GRENAT, IPV4, NOF, ICMP, PAY4),
> > -
> > -	/* IPv6 --> GRE/NAT -> IPv6 */
> > -	ICE_PTT(117, IP, IPV6, NOF, IP_GRENAT, IPV6, FRG, NONE, PAY3),
> > -	ICE_PTT(118, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, NONE, PAY3),
> > -	ICE_PTT(119, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(120),
> > -	ICE_PTT(121, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, TCP,  PAY4),
> > -	ICE_PTT(122, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, SCTP, PAY4),
> > -	ICE_PTT(123, IP, IPV6, NOF, IP_GRENAT, IPV6, NOF, ICMP, PAY4),
> > -
> > -	/* IPv6 --> GRE/NAT -> MAC */
> > -	ICE_PTT(124, IP, IPV6, NOF, IP_GRENAT_MAC, NONE, NOF, NONE, PAY3),
> > -
> > -	/* IPv6 --> GRE/NAT -> MAC -> IPv4 */
> > -	ICE_PTT(125, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, FRG, NONE, PAY3),
> > -	ICE_PTT(126, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, NONE, PAY3),
> > -	ICE_PTT(127, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(128),
> > -	ICE_PTT(129, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, TCP,  PAY4),
> > -	ICE_PTT(130, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, SCTP, PAY4),
> > -	ICE_PTT(131, IP, IPV6, NOF, IP_GRENAT_MAC, IPV4, NOF, ICMP, PAY4),
> > -
> > -	/* IPv6 --> GRE/NAT -> MAC -> IPv6 */
> > -	ICE_PTT(132, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, FRG, NONE, PAY3),
> > -	ICE_PTT(133, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, NONE, PAY3),
> > -	ICE_PTT(134, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(135),
> > -	ICE_PTT(136, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, TCP,  PAY4),
> > -	ICE_PTT(137, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, SCTP, PAY4),
> > -	ICE_PTT(138, IP, IPV6, NOF, IP_GRENAT_MAC, IPV6, NOF, ICMP, PAY4),
> > -
> > -	/* IPv6 --> GRE/NAT -> MAC/VLAN */
> > -	ICE_PTT(139, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, NONE, NOF, NONE, PAY3),
> > -
> > -	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv4 */
> > -	ICE_PTT(140, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, FRG, NONE, PAY3),
> > -	ICE_PTT(141, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, NONE, PAY3),
> > -	ICE_PTT(142, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(143),
> > -	ICE_PTT(144, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, TCP,  PAY4),
> > -	ICE_PTT(145, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, SCTP, PAY4),
> > -	ICE_PTT(146, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV4, NOF, ICMP, PAY4),
> > -
> > -	/* IPv6 --> GRE/NAT -> MAC/VLAN --> IPv6 */
> > -	ICE_PTT(147, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, FRG, NONE, PAY3),
> > -	ICE_PTT(148, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, NONE, PAY3),
> > -	ICE_PTT(149, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, UDP,  PAY4),
> > -	ICE_PTT_UNUSED_ENTRY(150),
> > -	ICE_PTT(151, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, TCP,  PAY4),
> > -	ICE_PTT(152, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, SCTP, PAY4),
> > -	ICE_PTT(153, IP, IPV6, NOF, IP_GRENAT_MAC_VLAN, IPV6, NOF, ICMP, PAY4),
> > +	ICE_PTYPES
> >  
> >  	/* unused entries */
> > -	[154 ... 1023] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
> > +	[ICE_NUM_DEFINED_PTYPES ... 1023] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
> >  };
> >  
> >  static inline struct ice_rx_ptype_decoded ice_decode_rx_desc_ptype(u16 ptype)
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index 463d9e5cbe05..b11cfaedb81c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -567,6 +567,79 @@ static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
> >  	return 0;
> >  }
> >  
> > +/* Define a ptype index -> XDP hash type lookup table.
> > + * It uses the same ptype definitions as ice_decode_rx_desc_ptype[],
> > + * avoiding possible copy-paste errors.
> > + */
> > +#undef ICE_PTT
> > +#undef ICE_PTT_UNUSED_ENTRY
> > +
> > +#define ICE_PTT(PTYPE, OUTER_IP, OUTER_IP_VER, OUTER_FRAG, T, TE, TEF, I, PL)\
> > +	[PTYPE] = XDP_RSS_L3_##OUTER_IP_VER | XDP_RSS_L4_##I | XDP_RSS_TYPE_##PL
> > +
> > +#define ICE_PTT_UNUSED_ENTRY(PTYPE) [PTYPE] = 0
> 
> ERROR: space prohibited before open square bracket '['
> #476: FILE: drivers/net/ethernet/intel/ice/ice_txrx_lib.c:580:
> +#define ICE_PTT_UNUSED_ENTRY(PTYPE) [PTYPE] = 0
> 
> total: 2 errors, 0 warnings, 0 checks, 525 lines checked

Now, this one is a true false positive. Seems like checkpatch would stop 
complainining, if I did:

#define ICE_PTT_UNUSED_ENTRY(PTYPE)\
	[PTYPE] = 0

But is it worth it?

> 
> > +
> > +/* A few supplementary definitions for when XDP hash types do not coincide
> > + * with what can be generated from ptype definitions
> > + * by means of preprocessor concatenation.
> > + */
> > +#define XDP_RSS_L3_NONE		XDP_RSS_TYPE_NONE
> > +#define XDP_RSS_L4_NONE		XDP_RSS_TYPE_NONE
> > +#define XDP_RSS_TYPE_PAY2	XDP_RSS_TYPE_L2
> > +#define XDP_RSS_TYPE_PAY3	XDP_RSS_TYPE_NONE
> > +#define XDP_RSS_TYPE_PAY4	XDP_RSS_L4
> > +
> > +static const enum xdp_rss_hash_type
> > +ice_ptype_to_xdp_hash[ICE_NUM_DEFINED_PTYPES] = {
> > +	ICE_PTYPES
> > +};
> > +
> > +#undef XDP_RSS_L3_NONE
> > +#undef XDP_RSS_L4_NONE
> > +#undef XDP_RSS_TYPE_PAY2
> > +#undef XDP_RSS_TYPE_PAY3
> > +#undef XDP_RSS_TYPE_PAY4
> > +
> > +#undef ICE_PTT
> > +#undef ICE_PTT_UNUSED_ENTRY
> > +
> > +/**
> > + * ice_xdp_rx_hash_type - Get XDP-specific hash type from the RX descriptor
> > + * @eop_desc: End of Packet descriptor
> > + */
> > +static enum xdp_rss_hash_type
> > +ice_xdp_rx_hash_type(const union ice_32b_rx_flex_desc *eop_desc)
> > +{
> > +	u16 ptype = ice_get_ptype(eop_desc);
> > +
> > +	if (unlikely(ptype >= ICE_NUM_DEFINED_PTYPES))
> > +		return 0;
> > +
> > +	return ice_ptype_to_xdp_hash[ptype];
> > +}
> > +
> > +/**
> > + * ice_xdp_rx_hash - RX hash XDP hint handler
> > + * @ctx: XDP buff pointer
> > + * @hash: hash destination address
> > + * @rss_type: XDP hash type destination address
> > + *
> > + * Copy RX hash (if available) and its type to the destination address.
> > + */
> > +static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> > +			   enum xdp_rss_hash_type *rss_type)
> > +{
> > +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> > +
> > +	*hash = ice_get_rx_hash(xdp_ext->pkt_ctx.eop_desc);
> > +	*rss_type = ice_xdp_rx_hash_type(xdp_ext->pkt_ctx.eop_desc);
> > +	if (!likely(*hash))
> > +		return -ENODATA;
> > +
> > +	return 0;
> > +}
> > +
> >  const struct xdp_metadata_ops ice_xdp_md_ops = {
> >  	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
> > +	.xmo_rx_hash			= ice_xdp_rx_hash,
> >  };
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index de08c8e0d134..1e9870d5f025 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -416,6 +416,7 @@ enum xdp_rss_hash_type {
> >  	XDP_RSS_L4_UDP		= BIT(5),
> >  	XDP_RSS_L4_SCTP		= BIT(6),
> >  	XDP_RSS_L4_IPSEC	= BIT(7), /* L4 based hash include IPSEC SPI */
> > +	XDP_RSS_L4_ICMP		= BIT(8),
> >  
> >  	/* Second part: RSS hash type combinations used for driver HW mapping */
> >  	XDP_RSS_TYPE_NONE            = 0,
> > @@ -431,11 +432,13 @@ enum xdp_rss_hash_type {
> >  	XDP_RSS_TYPE_L4_IPV4_UDP     = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
> >  	XDP_RSS_TYPE_L4_IPV4_SCTP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
> >  	XDP_RSS_TYPE_L4_IPV4_IPSEC   = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
> > +	XDP_RSS_TYPE_L4_IPV4_ICMP    = XDP_RSS_L3_IPV4 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
> >  
> >  	XDP_RSS_TYPE_L4_IPV6_TCP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_TCP,
> >  	XDP_RSS_TYPE_L4_IPV6_UDP     = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_UDP,
> >  	XDP_RSS_TYPE_L4_IPV6_SCTP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_SCTP,
> >  	XDP_RSS_TYPE_L4_IPV6_IPSEC   = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_IPSEC,
> > +	XDP_RSS_TYPE_L4_IPV6_ICMP    = XDP_RSS_L3_IPV6 | XDP_RSS_L4 | XDP_RSS_L4_ICMP,
> >  
> >  	XDP_RSS_TYPE_L4_IPV6_TCP_EX  = XDP_RSS_TYPE_L4_IPV6_TCP  | XDP_RSS_L3_DYNHDR,
> >  	XDP_RSS_TYPE_L4_IPV6_UDP_EX  = XDP_RSS_TYPE_L4_IPV6_UDP  | XDP_RSS_L3_DYNHDR,
> > -- 
> > 2.41.0
> > 


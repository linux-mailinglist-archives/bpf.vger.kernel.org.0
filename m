Return-Path: <bpf+bounces-12462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1DD7CC96B
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E2B281B49
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C343A8B;
	Tue, 17 Oct 2023 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNr0s/Iy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E802D028;
	Tue, 17 Oct 2023 17:04:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC3ED;
	Tue, 17 Oct 2023 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697562256; x=1729098256;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sNwQWpLxf54q4vrhuWq3s8SRnTucCtdUajiLa9ZR5J0=;
  b=JNr0s/Iy6fVc1dWgGsMTRCzp1zwsYsH41aqd+gfOIH+3PB2tMC5DLO9U
   wL2FF+Hr6E7h/hVzfdNAdIjywki8Y2ByghqJ4XjKyByijoeVLsPiMRfHA
   UFADlpEnQqERD2k5VE02IJlXnSfMl87BDdk3rnGN/da/fj8K8Ii1qgYX+
   YWsP6dseHe3vKW1Tkpx3tmLok0QDZF+Z/byBKZGYHdRENVmfrK+115+gI
   ooy2U9edvb+SnxEBh7a5QupER/2y8zgpbqbpWFN2IV5gXarbLAh42iv4i
   a8gOPJLwhU3GtwhaWNSN2B+UgzZwLVjmH8oJ4cARxr4IUfhKDQMZQQsmE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383058387"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="383058387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 10:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826512323"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="826512323"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 10:04:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:04:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 10:04:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 10:04:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsWoCuGBskZAsAio29YjfoMfJsbuJqYh2LKf8ekdOIOUD23+0jDDdSDDjaPPJLsDVWtfTtSFjt6Pj47Su/53ZFBxC2xQEEdOaz8GmCMZkUYmK0DPVRtLEOZV7x9wQvCw9fybkyeNmQ3ACIe9wBOhQ0ALF3+ruOps7fqIrlpbDtJjx81b10Q7UWkJXtWrEiHEIxL4MDwPSoFFvWryMVQwgCkTszTHhCNx5TzsHWIgPNVx+RuGk0iEJkePaHAK8GRoyuejfXVAxB4Apz06U1Qxi+W4zePCM0nCYax2UvJ73xk572DFUWiPCJP01yfZQu1xuE3ibNF5aHyrG1ML9/bVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE8vIOZwsK8zjY0qnkiDDu6psz31F+Dar/CewJRWS3M=;
 b=bVBdXIXt6bFyXde9Xf5ceh4mUFfItQhA+eFAIiRNFiXP32TG7pbbzQOvUNT6wovPrDkLkO8cEpjxEN1c1m6jY1IFnTKJ52qKjIJkgdtBL9atEogbr+6Xm1zmvA029yHNIsmu62b+fE51IC3P0S7W1bnX7drVKBNRfce2ge4e8/UPpYL7b+CZmqSxbW8dub4zLw3UmpetbVjvyIzgvHi8074ejuHCf0/4UPH+XR79tT2rmzGH0TexAMg6kdVKwPj/zr9RdwBu17rMO95qXs1XlY0d1S3/WtZ9j/LcQarDL/UUVE/36aRJI5/sZTyhfl+ZJVlcg637BBaa1F/cFdrAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CH0PR11MB8233.namprd11.prod.outlook.com (2603:10b6:610:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 17:04:11 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::8947:cca7:ef62:7936]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::8947:cca7:ef62:7936%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 17:04:10 +0000
Date: Tue, 17 Oct 2023 19:03:57 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, <bpf@vger.kernel.org>,
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
Message-ID: <ZS6+fcfjQgIdD+6G@lzaremba-mobl.ger.corp.intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-8-larysa.zaremba@intel.com>
 <ZS6yqqMZD1mojQNr@boxer>
 <CAJ8uoz3Bqtb-F1bpKWKx8bhftJW7g1BEyjxnQZprRv4NxsXi9Q@mail.gmail.com>
 <ZS66DrMFeuerTI01@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZS66DrMFeuerTI01@boxer>
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CH0PR11MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0626ddea-5d94-4a40-3a67-08dbcf33150f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZck/TBHVJ87mJkJHDlLXQQrX66x50tNkv7K+QNhiTb5rXb7FOY/FIuMhz4g/Y6CEjIff+qjlr/TK3E1K78df0G9NkB63uGGgwof4G49iDZmoYUBGDmtZ1Q7pzpC7MbiJTw4Cllmfdr8lN3JS0FhMWixTneKE4i9apKWcjYMytdY3MmdCNho2m8Ah4dA1F5x4smHfe2syYEuFn8JozFXqe89SxJFvbmGJZ51y3e0WWg5thnWuWfEO8BFa3OnhQgWFuAgmPraoeEJ/yvAZZ0ATp0jQoliDc0Z3HgxKwnAqrpTSzFR/5lqQEWiLu4RvZVN7V40yqJSnkadYboPWokrV/vEvwRVCKVsdwWzfPWPz1nq8F2idHObcj0bIFvQ7DQTl1BMQT7Ilte5U4+3UiDqJf898kSC4V8LmUt6JB9wBRCije2Xpmw967vf1fAAJZOtpq8dMT56sbWD+tyLkr6tejm9MrjwjtZCVtNNaoz/gQR+sM626D9ux0lkIkxle7EAhFZE5/JpNMZJs9V3kVJ3Pj2c1zn0+h5fhxiOIdwe49vMG/PUaznbxwCzILJzZAmB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(478600001)(66556008)(66476007)(66946007)(6636002)(54906003)(107886003)(83380400001)(26005)(86362001)(82960400001)(38100700002)(6506007)(316002)(6666004)(6512007)(7416002)(2906002)(41300700001)(5660300002)(8676002)(8936002)(6862004)(4326008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nG3xZCkAmuWV6hLiMIB5krwss07kVOb2QTPtLGcNKanFyb/2Kya2AyMPkd0i?=
 =?us-ascii?Q?IsPyAusgEhi1fbZ/hbHmr6EOqDg7wieyTs2VzShKdx28i68qzE6DX8U52xGW?=
 =?us-ascii?Q?6TwIOaP+IALky3Nk9eWDcwQbBFVuHIf1lXRuEIj2hpnOfjWGu/s7dRTDOSTq?=
 =?us-ascii?Q?2IygPPQixbL6TCL3bto20Y2K9lDcb0nS9g1ayha6LcaSaSOkXCq9ddwCzzTE?=
 =?us-ascii?Q?/qPTo5dQHs88A0/R44/EfWznzBc3obSykVWwQ4V0yK6KEoORw5tIIf56uHk3?=
 =?us-ascii?Q?iTDO6ujCHIaRHHKSs5IHUzfYEwoyNc78fGd+0uI9lMCIRrf3iahaoBD4Ju9g?=
 =?us-ascii?Q?DN/8IMIrduBHfpDcCfnLUWSn8xbew07fUnprns5Ayc83sX4hRGtPWnJv6bF9?=
 =?us-ascii?Q?etC5uM17PXCR3IGwRmYYXNuS8R2OeY1HNcCReaoV1pqtU0OlWdfl5a8ptzHU?=
 =?us-ascii?Q?RlT/FX+k4psRRaTfPraxr9nsuR5VKzkHwvtrhcwca7Eqzcd35LrqizgxcyF+?=
 =?us-ascii?Q?zgpy5bQKyaZMhn+9Z9NaZxJmhDZA3F874Z4EcfLoUfdUulB/rr2ODKz2PLJt?=
 =?us-ascii?Q?JookzIdpy4wuC7m23m1Em4FKOCKtzkaTbrzGVJFhYDtnr2ohDQqF7fpVAij3?=
 =?us-ascii?Q?Alq1cgbzyXcj7MUcmOcNviQKW9bP+himsk9NHuu2XJbOs/csSxjum9SHShSD?=
 =?us-ascii?Q?1X0E872ZHtpPLHaC+vnG8m8nfsyZCr7r5PpGN6yEHeX6vfSl/CzNgJP7p00d?=
 =?us-ascii?Q?un19W9z+eXCTMi0p2e28/RZSSAAkiy1lUADT4ixiKmwBLtOCIBkHORgL1wkY?=
 =?us-ascii?Q?PJoVA4/O9xu8/vrpreCCtNPuh6QJyHXE2oYGH+F4Xm2273xfFTl7Lh0b3K0x?=
 =?us-ascii?Q?bVw8tRiTxbSbr8+iWnVND5LxdEt4WWhlHd4ygmYVpdRh9CTGxFL9UfnU2bhJ?=
 =?us-ascii?Q?KK3SlxppuurIxrOZ3/Z0RTnAkh7LRLwcKrTRi7JGVsGTl1sksWpFJI1/eMHd?=
 =?us-ascii?Q?xqEbclhysXXqS/rItPcAW2faY0rFuqk0hcU+heZMRpLZLJ8GFBSMK8DmxPAc?=
 =?us-ascii?Q?TyLWKLbhgvYvzE/cm/C7jgYyxdRDMGc9G15tKrWDVWuNhUijvRC5rh71C3f1?=
 =?us-ascii?Q?UyDOkmzMBHi690V752XkcH89lgJLGbYMjrsJbLJG0mLhFGsZSnt5tMSVmt2Z?=
 =?us-ascii?Q?CYcCZCNUtVxxIO7JnRcQlEYGKUTGP0ZO361DE7KTinv5oAjCYWT5v4JvMrm6?=
 =?us-ascii?Q?TC6v3hftq3JBMWD9IYUXCuZgBtN8s9YesMXHFMPnQnhtxM1lwxT36Fo2mw1n?=
 =?us-ascii?Q?UMrt0CHQj/V9TgsWusULYIhyoSiUmV2i59sE7ghPdejEa2GVTehZ4pk3SBKM?=
 =?us-ascii?Q?o/gZeUciYoV/dd41lUkV13Vnk4Nkq3k9zVR3x2pg7vcLh6k7+36qYizivyQG?=
 =?us-ascii?Q?9jWQUvrVJT14/xLIDxc7JISx+d7lXLsUZRRhkQr3luNR8YeG5DcBtShDEVZo?=
 =?us-ascii?Q?8tmMptfX01z3CGgwntFQw9t1boog19mCx4NE/2KDnpzI00KR5+Bq2FuM0wfQ?=
 =?us-ascii?Q?5tv85fjGhUUtjqLzTTOTQcxI2BmhUFbMa3OLSjFqhxpo8DtYaGi9RD6d6n4w?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0626ddea-5d94-4a40-3a67-08dbcf33150f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:04:10.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cm9xG4arLDK/o2bLgntpaWQFbqXd/0+ztVa4v6G8pZaBjzb80Qak3nDgjr/2oPsVhtNB9NYrhgLhudx8Y2LMwQ0+ZQ1nTpUqFqpa560btcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8233
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 06:45:02PM +0200, Maciej Fijalkowski wrote:
> On Tue, Oct 17, 2023 at 06:37:07PM +0200, Magnus Karlsson wrote:
> > On Tue, 17 Oct 2023 at 18:13, Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, Oct 12, 2023 at 07:05:13PM +0200, Larysa Zaremba wrote:
> > > > In AF_XDP ZC, xdp_buff is not stored on ring,
> > > > instead it is provided by xsk_buff_pool.
> > > > Space for metadata sources right after such buffers was already reserved
> > > > in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").
> > > > This makes the implementation rather straightforward.
> > > >
> > > > Update AF_XDP ZC packet processing to support XDP hints.
> > > >
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  drivers/net/ethernet/intel/ice/ice_xsk.c | 34 ++++++++++++++++++++++--
> > > >  1 file changed, 32 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > index ef778b8e6d1b..6ca620b2fbdd 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > > @@ -752,22 +752,51 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
> > > >       return ICE_XDP_CONSUMED;
> > > >  }
> > > >
> > > > +/**
> > > > + * ice_prepare_pkt_ctx_zc - Prepare packet context for XDP hints
> > > > + * @xdp: xdp_buff used as input to the XDP program
> > > > + * @eop_desc: End of packet descriptor
> > > > + * @rx_ring: Rx ring with packet context
> > > > + *
> > > > + * In regular XDP, xdp_buff is placed inside the ring structure,
> > > > + * just before the packet context, so the latter can be accessed
> > > > + * with xdp_buff address only at all times, but in ZC mode,
> > > > + * xdp_buffs come from the pool, so we need to reinitialize
> > > > + * context for every packet.
> > > > + *
> > > > + * We can safely convert xdp_buff_xsk to ice_xdp_buff,
> > > > + * because there are XSK_PRIV_MAX bytes reserved in xdp_buff_xsk
> > > > + * right after xdp_buff, for our private use.
> > > > + * XSK_CHECK_PRIV_TYPE() ensures we do not go above the limit.
> > > > + */
> > > > +static void ice_prepare_pkt_ctx_zc(struct xdp_buff *xdp,
> > > > +                                union ice_32b_rx_flex_desc *eop_desc,
> > > > +                                struct ice_rx_ring *rx_ring)
> > > > +{
> > > > +     XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
> > > > +     ((struct ice_xdp_buff *)xdp)->pkt_ctx = rx_ring->pkt_ctx;
> > >
> > > I will be loud thinking over here, but this could be set in
> > > ice_fill_rx_descs(), while grabbing xdp_buffs from xsk_pool, should
> > > minimize the performance overhead.

I am not sure about that. Packet context consists of:
* VLAN protocol
* cached time

Both of those can be updated without stopping traffic, so we cannot set this 
at setup time.

> > >
> > > But then again you address that with static branch in later patch.
> > >
> > > OTOH, I was thinking that we could come with xsk_buff_pool API that would
> > > let drivers assign this at setup time. Similar what is being done with dma
> > > mappings.
> > >
> > > Magnus, do you think it is worth the hassle? Thoughts?
> > 
> > I would measure the overhead of the current assignment and if it is
> > significant (incurs a cache miss for example), then why not try out
> > your idea. Usually good not to have to touch things when not needed.
> 
> Larysa measured that because I asked for that previously and impact was
> around 6%. Then look at patch 11/18 how this was addressed.
> 
> Other ZC drivers didn't report the impact but i am rather sure they were also
> affected. So i was thinking whether we should have some generic solution
> within pool or every ZC driver handles that on its own.
> 
> > 
> > > Or should we advise any other driver that support hints to mimic static
> > > branch solution?
> > >
> > > > +     ice_xdp_meta_set_desc(xdp, eop_desc);
> > > > +}
> > > > +
> > > >  /**
> > > >   * ice_run_xdp_zc - Executes an XDP program in zero-copy path
> > > >   * @rx_ring: Rx ring
> > > >   * @xdp: xdp_buff used as input to the XDP program
> > > >   * @xdp_prog: XDP program to run
> > > >   * @xdp_ring: ring to be used for XDP_TX action
> > > > + * @rx_desc: packet descriptor
> > > >   *
> > > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > > >   */
> > > >  static int
> > > >  ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > -            struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring)
> > > > +            struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > > +            union ice_32b_rx_flex_desc *rx_desc)
> > > >  {
> > > >       int err, result = ICE_XDP_PASS;
> > > >       u32 act;
> > > >
> > > > +     ice_prepare_pkt_ctx_zc(xdp, rx_desc, rx_ring);
> > > >       act = bpf_prog_run_xdp(xdp_prog, xdp);
> > > >
> > > >       if (likely(act == XDP_REDIRECT)) {
> > > > @@ -907,7 +936,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
> > > >               if (ice_is_non_eop(rx_ring, rx_desc))
> > > >                       continue;
> > > >
> > > > -             xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring);
> > > > +             xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
> > > > +                                      rx_desc);
> > > >               if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> > > >                       xdp_xmit |= xdp_res;
> > > >               } else if (xdp_res == ICE_XDP_EXIT) {
> > > > --
> > > > 2.41.0
> > > >


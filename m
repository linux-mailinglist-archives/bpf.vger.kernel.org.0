Return-Path: <bpf+bounces-4239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1E749CBF
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674AB1C20B83
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BE8F71;
	Thu,  6 Jul 2023 12:53:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13328F59;
	Thu,  6 Jul 2023 12:53:52 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41582171A;
	Thu,  6 Jul 2023 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688648030; x=1720184030;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bkIBwkTm0koXkKn77SoNSJyRiPsjwjvg1biXnRn6apI=;
  b=m0ohlc4NLFht6qLrRjY91nJLR5DJ2KjRptD2wBEw9BlC3qvHX+UJjqEn
   pbwNyN6tTtmUdtjB5a0Mb0SBy5sEOJHYytp2GApviF64toMbXbqruWHZZ
   KW7ECHspK6YG/OJl44uXxwJLbmkP4qffhie34pClx3pWYWATGcfSXdxRC
   lhRfIEXOKWU3bIPNWiqpZdYhdsje4Rv+gWhj5L3GbxsjxFFk+DxxIdqr+
   wm64OiYA/kVCjlpB7rtos1+PrtbJnJgQ/LTbnXfzhpFlfTbQBxT6o3cPP
   s7GUT90aK/NCM4pshbJE6mMErYaabyRpe+wuP3pEipbwhO2Kj9QBPmWdU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="343182656"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343182656"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="789538576"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="789538576"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2023 05:53:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:53:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:53:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 05:53:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 05:53:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qreqt2PCYhzmPyX89EakhFuWeR+C7B6DzH1Fpe9QhiUr+y5XiZSzqtDSAGFgbgM74zd+M7fQW34EyZKkKcOefQ5kaXAeYnBoxehODQt4W+p9Xk13q5DsTZONJfncZ9rPCO8s/qmS44skGAljqvwC24TAs+pfbqCT6xSSrroTMpD9lQH2hSIysQeHFKIgkfeppGOyLfBuNXkIgbiFM6M9n3nBHzbnGzotnt6FeKwEtJZmpLRutZtYiWZwz3HwocLYwP/ScQ/m2voTgHYReWSWRiGmmr8dVDCyqBLaetzafv/MuVSgD3ezl6Kjjq9P4bz9OLoNGu9BGOqlNa6L2kYUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vithOUA0ChgTnwKJIcs9wQE2btDy34X5SNxz0ham2SM=;
 b=WGK1YV2ypNVBBMkkuvaksFNobFZHZaZsjWjA7sxp5Ow4hNZHIyRPbDZOgD357/o8MIPujJ5rWSZokcy8EscJdGhtE51smMuc5fg698HJ+Xf9mXNd5U9yKzwM6l+Qj3vHfYP7t2pWesV6yDskhkWdy1aIDKgZECWvR4yfsVM/IHa8RJONxsoNUsdHkFtisBZ6qdRFCarayEU/Ek2TOaMwIF3+JYzFe25QKBQ/DqdjvoIoclGIVoQ3b8YRC5VX/NNAdIKwKp4/zVAn0G/+BBKWyEeYjX1vGQ27kC/gCU5TiIZ15NUQBDHIi5jXE10gQFXxkAd/GmMO9m6am9Jlv0zZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BL1PR11MB5416.namprd11.prod.outlook.com (2603:10b6:208:319::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 12:53:45 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:53:45 +0000
Date: Thu, 6 Jul 2023 14:49:44 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
CC: John Fastabend <john.fastabend@gmail.com>, <brouer@redhat.com>,
	<bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Alexander Duyck
	<alexander.duyck@gmail.com>
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v2 12/20] xdp: Add checksum
 level hint
Message-ID: <ZKa4aCHDrG2ZVI8H@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
 <64a331c338a5a_628d3208cb@john.notmuch>
 <ZKPlZ6Z8ni5+ZJCK@lincoln>
 <9cd44759-416c-7274-f805-ee9d756f15b1@redhat.com>
 <ZKQAPBcIE/iCkiX2@lincoln>
 <64a656273ee15_b20ce2087a@john.notmuch>
 <3cc1d2ba-e084-8fc4-aa31-856bc532d1a7@redhat.com>
 <ZKa1ydBpmDCw4Ejp@lincoln>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZKa1ydBpmDCw4Ejp@lincoln>
X-ClientProxiedBy: BE0P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::13) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BL1PR11MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e894d5-7f51-41bb-225a-08db7e20083e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyUIS95hRfxQq0RtFFIZcsJ3cn17EB95uxZ+VKiH+6gHPQiZ7sTKc5i8VdgfPLFdS9YRnNmICalAaGSPo1//lUuvs6XiD+6v8LCe7mvUgDahot30od+lJlfxsDrziwltrLcmD9KI1aX2cyooM2A/McAPaeB+rGBZoyF4e6uU57ZI8mvriBD7+SGvowv1SAOkf2L5waiqP3PWIqH+7Ay6pVaHTnq7ehmgVrOTiQkSbo4GUgWOvCBqu3xbF4nFEVHPQSr+oQL52DNscdnkXA846xkjG0V2Uvr/a8GP54kNTkRkkQtEz4Hh0ebLqY3Yp/ffOD9D7WMm0TOGiw+soM/zfzM85rtwS7SiYBhzDtSkPQ7iWSYNzRpSa1lECBtg96QXkIwUrfLh+lNW7yobSRuKksha9PxrMyc2au5Y/RYxVKJE9wYOhdx0AtzcIITXcEET7hwRtHbcXobXd+yGisOozNBIVgTJ9IGvC+d0QWWWgtQmTf4e567DLzzBkCnLGU/Ns0keaNU35jjKlPBRlSKBVAn9+Pq4GR7ya0POcOV0EYtmq902L9jU2uBbgX8qg2KUYx9DGD3m6S/P6e1Sn/gjRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(478600001)(6486002)(54906003)(6506007)(26005)(186003)(9686003)(6512007)(966005)(66946007)(2906002)(33716001)(41300700001)(316002)(66556008)(66476007)(6916009)(4326008)(5660300002)(7416002)(44832011)(8936002)(8676002)(38100700002)(82960400001)(86362001)(83380400001)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/X3vjk2Y3si0Rr32fadC8u4Ce8cX6WILAFXxtwrAmFsu8s5xhW89b3iS8Y88?=
 =?us-ascii?Q?E2QQpBsdtf5yvL3iUnSZw40l8WsFa7z6F8ZZRN8kR70wn5dHxDI2XASHzb7x?=
 =?us-ascii?Q?PNALy+RD3tXEYwajt2EEBbsdpiSW/RmwywOuLnmf6hHxUdvddJgPcpQaskb4?=
 =?us-ascii?Q?AMtocl0D3neuYOLCC3Y+h8GFDW0/ueR/FINH/Iz5V/IJs9JX2DEfTylha/dp?=
 =?us-ascii?Q?ZLNNK6+AukUgpilH+yE99lw+y4SaANT2ZXQ+FBfoGyEIWA+uSbFuuxJb5LcY?=
 =?us-ascii?Q?vO1o7WsKy+Pos4CJaptjtRg7EjiN5aNMq7Xs3WjBh+a95JP/UjZ5JKmOZyHi?=
 =?us-ascii?Q?KnFaWH6DaP1SkaHmoRYDEE21yI/Od9VIkYRiXrmsHBx0cUllpTB/dXUJJVdX?=
 =?us-ascii?Q?CxIk96mRylqz8F1osuYRhhz/Ysbb5waU3Jk8VCpC70mv7uKKi9BvSj45Tkyd?=
 =?us-ascii?Q?j9gvwtepboXxyulYuMlOPGiD9Azyxp/hkEIp6j3lulKzNl4COFj2QWJufHb0?=
 =?us-ascii?Q?weY0b94TIORbIZ3aQkgEnfMpg9/6nlNG95A3uDlVSnQYyhxWjVTjL7JlwOua?=
 =?us-ascii?Q?CMz46GkGuQKceTe6jWcgX9NP7xkzpx/sgmnLo9TdFy8hKX4J+3u3pty1XCOb?=
 =?us-ascii?Q?EYIA9TclrnxSyD93RZ0A3OBOVOTfQgb01lP96Mwfv6RDfrvyZ+c2XL+HbjRP?=
 =?us-ascii?Q?bC+x5uACl4W4/oud0i7qWQwYZlBhffJYw14RMKGsc9wV/yccxuArnGBq0nmv?=
 =?us-ascii?Q?bmj9km5EfUHk/yBJAsBKiqjusyWJu41XLv/llBYHOwXaw6Pn7dB1sUxQmWlf?=
 =?us-ascii?Q?6y4wmlBp70mfLPHmuJKMFTSbIJbMOiQXVsEtvJvND1yBmlFHFmEIHsChtcO1?=
 =?us-ascii?Q?mZIRLHQG7i6sNwuEiqXxk6j48T5Tiepe8sDhh3WXBtvfMyj11E/CoZbzkL7t?=
 =?us-ascii?Q?SKrO/vU+mIgtxi3T08t0eIumT9RN4Ikc7ddTwqMRqtqa0Cq8/mheRGD7hsRD?=
 =?us-ascii?Q?071wrHk79nfDvSutew/yWzpGHh8MEGW+jfHuNu3ASDukRmT6AMR/iBlnwI3U?=
 =?us-ascii?Q?Rw1GzuzFQ7FhU4KsuC4y0/3r2UX9026oJcoZS9vxPC6O+4M44vTyI+uJFUgF?=
 =?us-ascii?Q?yBrI1+29vMgoyfKr7nHTfrPcMMPicWo6sftadBzKVqbvbSziZCBO1peDqGZ6?=
 =?us-ascii?Q?5O9kC+x/MGBIfZwiluPmhgVefFsjJEdUFrOaAi3Ha0E4cEvB5KgVGFEOUOKh?=
 =?us-ascii?Q?gUz61t8Rev7dD45FTEic3kMWWVywMDLp+oldIx/lcUd68WmJNWHqcBWLmdR9?=
 =?us-ascii?Q?zZl3ll4bHhfHpdovcleeNAu3HmQKd/m7kwZHREEi7g0o133t48l9iRSoO2kq?=
 =?us-ascii?Q?l0/d2HuCZ8Sk5IkQ2P2toIsMAh9NjUOF1YP5bKUP+/G3qt6w80rLpB0QbyyM?=
 =?us-ascii?Q?the4quXuVUCdHZt4oI+S2HeK/G62ZhBI97ta0emDhEhbXUPdSCLzJpn1VfI9?=
 =?us-ascii?Q?pZz3dzdU9Mvhr2gBqVQc8Ms9QgCWZohb9vbM35BYsG/LHOnwf55RLlav0tRd?=
 =?us-ascii?Q?Qqliuq925YystqDbTsRsM6unf3s2y/LFTS2t8BOItDPBRhk8CcNslCQ4/5R3?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e894d5-7f51-41bb-225a-08db7e20083e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:53:44.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp7F/Q0I45/RakDJdG43pmWuWC3yJDNNJwzHhRSyPSGyZPXDFG19uUeZiSuMhjai2cdQkP2Jbf+eSJNc3fkHAunru4oktgYxo4xJI5ZrrmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5416
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 02:38:33PM +0200, Larysa Zaremba wrote:
> On Thu, Jul 06, 2023 at 11:04:49AM +0200, Jesper Dangaard Brouer wrote:
> > 
> > 
> > On 06/07/2023 07.50, John Fastabend wrote:
> > > Larysa Zaremba wrote:
> > > > On Tue, Jul 04, 2023 at 12:39:06PM +0200, Jesper Dangaard Brouer wrote:
> > > > > Cc. DaveM+Alex Duyck, as I value your insights on checksums.
> > > > > 
> > > > > On 04/07/2023 11.24, Larysa Zaremba wrote:
> > > > > > On Mon, Jul 03, 2023 at 01:38:27PM -0700, John Fastabend wrote:
> > > > > > > Larysa Zaremba wrote:
> > > > > > > > Implement functionality that enables drivers to expose to XDP code,
> > > > > > > > whether checksums was checked and on what level.
> > > > > > > > 
> > > > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > > > ---
> > > > > > > >    Documentation/networking/xdp-rx-metadata.rst |  3 +++
> > > > > > > >    include/linux/netdevice.h                    |  1 +
> > > > > > > >    include/net/xdp.h                            |  2 ++
> > > > > > > >    kernel/bpf/offload.c                         |  2 ++
> > > > > > > >    net/core/xdp.c                               | 21 ++++++++++++++++++++
> > > > > > > >    5 files changed, 29 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > > index ea6dd79a21d3..4ec6ddfd2a52 100644
> > > > > > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > > > > > > >    .. kernel-doc:: net/core/xdp.c
> > > > > > > >       :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > > > > +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
> > > > > > > > +
> > > > > > > >    An XDP program can use these kfuncs to read the metadata into stack
> > > > > > > >    variables for its own consumption. Or, to pass the metadata on to other
> > > > > > > >    consumers, an XDP program can store it into the metadata area carried
> > > > > > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > > > > > index 4fa4380e6d89..569563687172 100644
> > > > > > > > --- a/include/linux/netdevice.h
> > > > > > > > +++ b/include/linux/netdevice.h
> > > > > > > > @@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
> > > > > > > >    			       enum xdp_rss_hash_type *rss_type);
> > > > > > > >    	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
> > > > > > > >    				   __be16 *vlan_proto);
> > > > > > > > +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
> > > > > > > >    };
> > > > > > > >    /**
> > > > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > > > index 89c58f56ffc6..61ed38fa79d1 100644
> > > > > > > > --- a/include/net/xdp.h
> > > > > > > > +++ b/include/net/xdp.h
> > > > > > > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > > > > > >    			   bpf_xdp_metadata_rx_hash) \
> > > > > > > >    	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > > > > > > >    			   bpf_xdp_metadata_rx_vlan_tag) \
> > > > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
> > > > > > > > +			   bpf_xdp_metadata_rx_csum_lvl) \
> > > > > > > >    enum {
> > > > > > > >    #define XDP_METADATA_KFUNC(name, _) name,
> > > > > > > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > > > > > > index 986e7becfd42..a133fb775f49 100644
> > > > > > > > --- a/kernel/bpf/offload.c
> > > > > > > > +++ b/kernel/bpf/offload.c
> > > > > > > > @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
> > > > > > > >    		p = ops->xmo_rx_hash;
> > > > > > > >    	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
> > > > > > > >    		p = ops->xmo_rx_vlan_tag;
> > > > > > > > +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
> > > > > > > > +		p = ops->xmo_rx_csum_lvl;
> > > > > > > >    out:
> > > > > > > >    	up_read(&bpf_devs_lock);
> > > > > > > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > > > > > > index f6262c90e45f..c666d3e0a26c 100644
> > > > > > > > --- a/net/core/xdp.c
> > > > > > > > +++ b/net/core/xdp.c
> > > > > > > > @@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
> > > > > > > >    	return -EOPNOTSUPP;
> > > > > > > >    }
> > > > > > > > +/**
> > > > > > > > + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
> > > > > > > > + * @ctx: XDP context pointer.
> > > > > > > > + * @csum_level: Return value pointer.
> > > > > > > > + *
> > > > > > > > + * In case of success, csum_level contains depth of the last verified checksum.
> > > > > > > > + * If only the outermost checksum was verified, csum_level is 0, if both
> > > > > > > > + * encapsulation and inner transport checksums were verified, csum_level is 1,
> > > > > > > > + * and so on.
> > > > > > > > + * For more details, refer to csum_level field in sk_buff.
> > > > > > > > + *
> > > > > > > > + * Return:
> > > > > > > > + * * Returns 0 on success or ``-errno`` on error.
> > > > > > > > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > > > > > > > + * * ``-ENODATA``    : Checksum was not validated
> > > > > > > > + */
> > > > > > > > +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
> > > > > > > 
> > > > > > > Istead of ENODATA should we return what would be put in the ip_summed field
> > > > > > > CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,
> > > > > 
> > > > > I was thinking the same, what about checksum "type".
> > > > > 
> > > > > > > 
> > > > > > >    bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);
> > > > > > > 
> > > > > > > or something like that? Or is the thought that its not really necessary?
> > > > > > > I don't have a strong preference but figured it was worth asking.
> > > > > > > 
> > > > > > 
> > > > > > I see no value in returning CHECKSUM_COMPLETE without the actual checksum value.
> > > > > > Same with CHECKSUM_PARTIAL and csum_start. Returning those values too would
> > > > > > overcomplicate the function signature.
> > > > > 
> > > > > So, this kfunc bpf_xdp_metadata_rx_csum_lvl() success is it equivilent to
> > > > > CHECKSUM_UNNECESSARY?
> > > > 
> > > > This is 100% true for physical NICs, it's more complicated for veth, bacause it
> > > > often receives CHECKSUM_PARTIAL, which shouldn't normally apprear on RX, but is
> > > > treated by the network stack as a validated checksum, because there is no way
> > > > internally generated packet could be messed up. I would be grateful if you could
> > > > look at the veth patch and share your opinion about this.
> > > > 
> > > > > 
> > > > > Looking at documentation[1] (generated from skbuff.h):
> > > > >   [1] https://kernel.org/doc/html/latest/networking/skbuff.html#checksumming-of-received-packets-by-device
> > > > > 
> > > > > Is the idea that we can add another kfunc (new signature) than can deal
> > > > > with the other types of checksums (in a later kernel release)?
> > > > > 
> > > > 
> > > > Yes, that is the idea.
> > > 
> > > If we think there is a chance we might need another kfunc we should add it
> > > in the same kfunc. It would be unfortunate to have to do two kfuncs when
> > > one would work. It shouldn't cost much/anything(?) to hardcode the type for
> > > most cases? I think if we need it later I would advocate for updating this
> > > kfunc to support it. Of course then userspace will have to swivel on the
> > > kfunc signature.
> > > 
> > 
> > I think it might make sense to have 3 kfuncs for checksumming.
> > As this would allow BPF-prog to focus on CHECKSUM_UNNECESSARY, and then
> > only call additional kfunc for extracting e.g csum_start  + csum_offset
> > when type is CHECKSUM_PARTIAL.
> > 
> > We could extend bpf_xdp_metadata_rx_csum_lvl() to give the csum_type
> > CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}.
> > 
> >  int bpf_xdp_metadata_rx_csum_lvl(*ctx, u8 *csum_level, u8 *csum_type)
> > 
> > And then add two kfunc e.g.
> >  (1) bpf_xdp_metadata_rx_csum_partial(ctx, start, offset)
> >  (2) bpf_xdp_metadata_rx_csum_complete(ctx, csum)
> > 
> > Pseudo BPF-prog code:
> > 
> >  err = bpf_xdp_metadata_rx_csum_lvl(ctx, level, type);
> >  if (!err && type != CHECKSUM_UNNECESSARY) {
> >      if (type == CHECKSUM_PARTIAL)
> >          err = bpf_xdp_metadata_rx_csum_partial(ctx, start, offset);
> >      if (type == CHECKSUM_COMPLETE)
> >          err = bpf_xdp_metadata_rx_csum_complete(ctx, csum);
> >  }
> > 
> > Looking at code, I feel we could rename [...]_csum_lvl to csum_type.
> > E.g. bpf_xdp_metadata_rx_csum_type.
> >
> 
> What about:
> 
> union csum_info {
> 	struct {
> 		u16 csum_start;
> 		u16 csum_offset;
> 	};
> 	u32 checksum;
> 	u8 checksum_level;
> };
> 
> bpf_xdp_metadata_rx_csum(*ctx, u8 *csum_status, union csum_info *info);
> 
> One thing that is worth considering in my opinion is whether some hardware can 
> provide both CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE. Judging by [0], this 
> does occur. I such cases using an enum to represent the checksum status would 
> artificially limit the capabilities. Now, imagine the situation:
> 
> - You want to use your XDP program with 2 different NICs
> 
> [...]
> 
> err = bpf_xdp_metadata_rx_csum(*ctx, &status, &info);
> if (!err && status == CHECKSUM_UNNECESSARY)
> 	/* Do stuff */
> 
> [...]
> - One NIC can both calculate CHECKSUM_COMPLETE and parse headers, another one 
>   is only able to parse headers. Those can be very similar NICs from different 
>   generation.
> - You test your program on the simpler NIC, program works fine.
> - You tests your program on the more advanced one and suddenly you need an 
>   'else if' case with some additional calculations.
> 
> Please write, whether this makes sense :D and if so, we can work out a solution.
>

Forgot the link:
[0] https://elixir.bootlin.com/linux/v6.4.2/source/include/linux/skbuff.h#L143
 
> > Feel free to disagree,
> > --Jesper
> > 
> > 
> 


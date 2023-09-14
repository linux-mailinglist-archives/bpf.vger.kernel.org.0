Return-Path: <bpf+bounces-10048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED517A0ACF
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B770F1F2430B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D038266B6;
	Thu, 14 Sep 2023 16:30:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888A286B1;
	Thu, 14 Sep 2023 16:30:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9669F1FC7;
	Thu, 14 Sep 2023 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694709023; x=1726245023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cnW13R9R1t1LWV3oqtndbRT8EzxLwk4o4wjiSOcVw4k=;
  b=fblu9QanngWVitZLqUFVUWQM2Tqphvr6OisNk+pOLz5NmUOllM2dDRG8
   u44O6fgzEYHGht9wbpyExMqnKXk2ow4xDKrCQuuCqCsbh2nfq6x3FYZUY
   ae0ssTAFPBZl0bNh15ucyCosw8s46WIXsZKHA38wdFLieD63QMwQfAPfv
   JgVE2ML1SrRZZ4pTRNX5BlfOEJgKADchN51DBphXREtS9WcSSD0WdGNd8
   ruyWGl4kJ+RngQ/y+BCXKn0lFbT052PHTVks4hAM4iqvniDtTYK07nxGR
   YNx0GabaL4lOyEIsPSYJ0NAA+6T9SvKKfkeXSx1VW/M7/Z0ULO1DcSWaK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="359264326"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="359264326"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="918314919"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="918314919"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:27:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:27:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:27:02 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:27:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXNU0WUUR8RSVXsrlduxnOgkm+jyw/iFS0jXVB5jJfHOScOKTaz7WEe7b8cAzK9z5u+CHxgP+bHQ7dj1NcuMICEpQ7dr97vM/Wy4Q6F1fSO8yQVvSAjcHIVcBoP3G4qvTw3mTcRnPzHAsS+WJdpatR3Y2FxsOgpA/VolvhMKiXQjbIy3x0rFLoVOZj9KmwJiszxhHBDz83+fBf8/lcF6qLhjOrayv9RCkycWtaZEEjlWFszh44/xdzmZfmnDqZll/jf2b3Ht3C0UYoYlUqcM5xNcUNWe5ECpXIxeq1yHYRaBMH/qWHQ4DOhWoshqX9PBaFx7WxAGm9MP+Rpwtx1s8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dJtAy04/y8AADIhm1irCPztQukbykElXC3IG0U06UY=;
 b=GXU5GyXazwSqU8g4cvS46DBvhEsAK5Tf1DNOTSsdoSzC6Mo/emP7xW9Vl4aq9F2WvDYyw1hjw07h+ERvqrF5waKLH8dHhrSPDzFdpc+Kwya3Ed7bEctVU5byBvAcpxTdEzDM7Xg8B1a5R/SWFa8ryQxxJBXHGjF0ocG6v98ILzqJ7MiMHKtLhIZ2ScZljYTFN3YmLMzAKWJL8lmnQX0BUfsjTWm2cJGMtEWAdoxS2hL67705Jc51PHhSxYxVA3wtqZn+1s+pMojUSMXf2ESlv6oYT0jf26G/77wJlvVb7wmRubsIpnUyhZFNayvFCVEO0l4v0ojPpbsK0kxyllPQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 14 Sep
 2023 16:26:59 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:26:59 +0000
Date: Thu, 14 Sep 2023 18:21:16 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
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
Subject: Re: [RFC bpf-next 09/23] xdp: Add VLAN tag hint
Message-ID: <ZQMy/FEgxaLsRb8n@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-10-larysa.zaremba@intel.com>
 <2c1f16fe-df92-08bc-e24f-a95edb2eadd0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2c1f16fe-df92-08bc-e24f-a95edb2eadd0@intel.com>
X-ClientProxiedBy: BE1P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c169056-2e1b-460d-c8c4-08dbb53f6b5c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaXGiOsGU9JG7A1CS5Hu0F4qZTsgfweYppQQ7802S6/wPAunJS79RVm+hZOFiErYJTtbrxYn5DAN5++7XgjEqV1swIfIPAnNEutR3UbKApwsL8vNev0DpIppMBkgWb+mzVmkHgNxWkH5p394VrGukHV1XTzpE6hrz9QolPCZyVC/0PgUXKWslRnuVqeXTfUySvpcx15WTDXeD9UdNBMEq5IuD17zJyWGo3gyjl4YzsW4F9+zRJHzdwECbFfeoIccXK6DIOVrbPlzLJdIOx2Dz6AICWTFCs6P8dI+4uR8jGf8BoG/4ZxzHEThJcltdbGSxGNZG8xfAmuVde39LEIh0cDuE4Ola6ROLDm2nujXIrmCynq9Rw/GoDrDJ8LTYtVMdiu0dqFMAHmLKeenkLXfeGc9CrED6OHvOx7wUDNOuTdFAEM0Ki/cTDE9J5snJA2t8Z/epROKyIPymRUVz95omaBUKykfjjKmXrhsL5wB4dEHNIc6qn5m0iuHZmUjcGOC8Nsnf45k2eXCbrJrJltCODdDyKxQhj6ZLlStaOpXT4tL9cPHWstTc+DEXKTA9Fbk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(396003)(136003)(39860400002)(186009)(1800799009)(451199024)(86362001)(41300700001)(9686003)(83380400001)(6486002)(7416002)(478600001)(6506007)(6666004)(38100700002)(33716001)(6512007)(26005)(54906003)(66946007)(66556008)(6636002)(2906002)(66476007)(82960400001)(4326008)(6862004)(44832011)(316002)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9syFJxKbk/DGi2P9VUpuS047TiD84COdkoQXO11YWh2LAPVFeRLAH08uc7B?=
 =?us-ascii?Q?hNhXfTxg3yKF7byAZ0AoQas6lvqQSOi6cd9MZGn5I1pvef4i1rqfesf0Deiy?=
 =?us-ascii?Q?X2aZlYmbMMntYZ3pEaGylKaYHBS6kkPCDhPz2SYfQpCF+1rRzNFyBCrsrUxW?=
 =?us-ascii?Q?Pl1nDBXY6BNmqo3US2rIr6bCs+/5OmwOs8PgFaqCNeo11qxZNYkfygnKqmRy?=
 =?us-ascii?Q?R6XkV1H/2D4Z7DqBNRXI5iDNk4mF4gYijLyKtSf49UubNbPD3tRtJRqaMv0S?=
 =?us-ascii?Q?8owG+LtLIPaOdSDngUR3N4NfoCmFHTxfHQSKw7yCkkqaTIjc8FAAUsZT1+Zp?=
 =?us-ascii?Q?c+8hfwYEAM2ymYA47jEOjdBxxpAHcKrtx4j6QImyJfPCj61Y0dqQy3Tlz1LD?=
 =?us-ascii?Q?XBmEo06ymHiAf1NIHIiHV/BLOvXUJ+tPVeTYu0Tw6u+33YOPK7AqVgY+mnkI?=
 =?us-ascii?Q?lANnutmfld0EfcjSaaqbyAWd3dWsX8BnNTSjpGcb3nWhaRvcgnyAGc/chxgw?=
 =?us-ascii?Q?fyF+me1uMWFmk86+4DXAjMbCeNvgGcGtdlibejByTkNxrOIatTubTg4iN0Q8?=
 =?us-ascii?Q?x5jzKln03HdEZ/oBoBhC/HBtVCTGYnRqPmBq9MlloXxygvWsD6onx+9qh02U?=
 =?us-ascii?Q?mYkWBhtuQaBF0IDXaGPI0KRtJS0ERGePYCE7FU6ookaqRTqvhpxNuqCDly6q?=
 =?us-ascii?Q?ZLwIDcR80dIsEg58BPwr1ja0vo7/q9tNzuswshS1fCDlSmh5Z3gLKl5vnyXD?=
 =?us-ascii?Q?y4/R+Im6mJv5osc7a0XRxyyYqNLVsc9ZvCSnC9L5ZWh0b7TYAstmGsXm36vq?=
 =?us-ascii?Q?29yy3fnpzm8U8oOMohhNKncjortTdtaNUKjTEtfkQe+TD9BnPHweyn/eAsTU?=
 =?us-ascii?Q?rtZMSgFknRHpr/CjqHuoPyTKN2b3Eq5resagikthf6AI1keSd0usU4JrLuy4?=
 =?us-ascii?Q?f2ff07xkHtRElErMN+SZIHYf8Y75wR8b9urNrfEjQe26DQlprpnibAU8XV8V?=
 =?us-ascii?Q?SZtSAzY5IUUkScP6Iaxhs6/Ln/scbVpdnY/ekwASS+0DTfUmJaLrD+HR0lLc?=
 =?us-ascii?Q?UkBj8LbA695Tu9fC/1VtXLpAG8Majnja/sZ35VIKM+5JmvCYlj6ETMRRXxqT?=
 =?us-ascii?Q?oqb8vn5vw48WZpSj9CpAj+mkgJLW8QQkythlu0OeVju01cBXt5pVUDCWm7Q0?=
 =?us-ascii?Q?z1oLFpYT6V1diFHUAMwKPea8PQaVR1hgwm8//FcYk52CzchZYoBAj4RjLhuw?=
 =?us-ascii?Q?cLs0S5enRsO6r4ltlT9PkFJsgxuiDuqruHu0aa0qL1SzkZH5xhgOdmjhUOP1?=
 =?us-ascii?Q?cCESAMt/x2xle2sbzqFpU3047YdphjsJy7EEIm6xeAXIGF7Kkdqd33zTdMnd?=
 =?us-ascii?Q?d3rcfvafip/vdvAqa6YCwfuGjR0hWYFb1G8S6ZaTP5H2gB9CXTNdfgoAMA1Q?=
 =?us-ascii?Q?TccAhpNtUf0XOwosx726DVe5uZ+kjXG1v5INFfSfay234kLdMLmJMtu2Fai/?=
 =?us-ascii?Q?AyGtUgA/+27bYSKoSPzeSLTYwAWTBRkIsn15gdNreIwfUoX9J9RZqhQqPTLb?=
 =?us-ascii?Q?0FOcoS2gv7FIn8vy35mGvnsUU7rMFOqzA8cw3DhFC/14xp9toWrjGkT2uVkO?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c169056-2e1b-460d-c8c4-08dbb53f6b5c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:26:59.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHYfuB4m2VaO02AkRduynpitFUH3axn+p1LVi/Q64gC1Gc0SI3lMIzwUIIo3DkDhG0QheQ1fRSKMwmT9hdtg6SgLgvA+cw/wsug0F/5paDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com

On Thu, Sep 14, 2023 at 06:18:40PM +0200, Alexander Lobakin wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> Date: Thu, 24 Aug 2023 21:26:48 +0200
> 
> > Implement functionality that enables drivers to expose VLAN tag
> > to XDP code.
> 
> I'd leave a couple more words here. Mention that it exports both tag and
> protocol, for example. That TCI is host-Endian and proto is BE (just
> like how skb stores them and it's fine).
>

OK

> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  Documentation/networking/xdp-rx-metadata.rst |  8 ++++-
> >  include/net/xdp.h                            |  4 +++
> >  kernel/bpf/offload.c                         |  2 ++
> >  net/core/xdp.c                               | 34 ++++++++++++++++++++
> >  4 files changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > index 25ce72af81c2..ea6dd79a21d3 100644
> > --- a/Documentation/networking/xdp-rx-metadata.rst
> > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
> >  metadata is supported, this set will grow:
> >  
> >  .. kernel-doc:: net/core/xdp.c
> > -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
> > +   :identifiers: bpf_xdp_metadata_rx_timestamp
> > +
> > +.. kernel-doc:: net/core/xdp.c
> > +   :identifiers: bpf_xdp_metadata_rx_hash
> > +
> > +.. kernel-doc:: net/core/xdp.c
> > +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
> >  
> >  An XDP program can use these kfuncs to read the metadata into stack
> >  variables for its own consumption. Or, to pass the metadata on to other
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 1e9870d5f025..8bb64fc76498 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -388,6 +388,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> >  			   bpf_xdp_metadata_rx_timestamp) \
> >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
> >  			   bpf_xdp_metadata_rx_hash) \
> > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > +			   bpf_xdp_metadata_rx_vlan_tag) \
> >  
> >  enum {
> >  #define XDP_METADATA_KFUNC(name, _) name,
> > @@ -449,6 +451,8 @@ struct xdp_metadata_ops {
> >  	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
> >  	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
> >  			       enum xdp_rss_hash_type *rss_type);
> > +	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
> > +				   __be16 *vlan_proto);
> 
> Was "TCI first, proto second" aligned with something or I can ask "why
> not proto first, TCI second"?

No particular reason. Now I have looked it up and this is the other way in all 
places >_<. I do probably need to switch this. Time to put my regular expressions 
skills to the test.

> 
> >  };
> >  
> >  #ifdef CONFIG_NET
> 
> [...]
> 
> Thanks,
> Olek


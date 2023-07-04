Return-Path: <bpf+bounces-3966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1B746FD0
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 13:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC91C208C2
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B1B5683;
	Tue,  4 Jul 2023 11:23:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E916D566B;
	Tue,  4 Jul 2023 11:23:17 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378A10C7;
	Tue,  4 Jul 2023 04:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688469790; x=1720005790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p4O7jS6lkZKq7X5OOjNf8YTM6VvX1OF4so3R9N6mRug=;
  b=iotmZcXQ+WahHdejqyNoAcj7oxEVTTqeseFOwz4gz8upS2v5/ObeTxDH
   NFEILdehVIo+v3G0NTgOf+3IHcGhAOvkBvY5jnuOYr9RiRs9SZY39MmpD
   /7+a8y7UE80azqO9Dc3zYEt0w4uapidQJ4z12E2etnHzYtNvnhfnhb0Ts
   GrBxKwPGDGYjqevySRLwqRqgDmUdtQdlMJQ5gXn/v/7MAECd3ZP4dJB83
   +1nkAPhNLh5agWSuDDgdJJdZDH9YT5MFHz90/y1JXiCkIetxwnA+3IArN
   6fQW8GTFwfNP3krnCs3b8PSq5kuwi9xatM6RTCCiuqLDAxh0wpct4AYe3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366581646"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="366581646"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 04:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="718886301"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="718886301"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 04 Jul 2023 04:23:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 04:23:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 04:23:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 04:23:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 04:23:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXLDOXPozkaikG3Uzi/+ATRqt8hysuhvw9olhjZ/ZAjNQMGLk9CelDXV2GZl4Z6lFL/xns06kPv3Qvl4JJRB5dtyzdOPEO+bAIL4y+PAD6NVI42Y5YBWFHwkwhJA9yCcsBBj28Ce2ApvbN6ji/A9Q1f0Qynx8wkX76Jzdy1NPZY2gnd/B0AENckZYZ4qsB/NKcWYcJ61zIAYQX8h2bZIQgo2kWgCaBHUIlBEyM9tgz7lgM2zNNlU4cAJcLj6o8TAuh7fvxLWKn2Cx3ssTjxI3WhmLUnc7cMSNof6o5pjNwmWPF/j5AyqCXScTWpLDv6XxogG0IciZuSfAgOI4dZG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SpUmBEif3mpbzsB+0riT8fQY8arLc9+aWd1jqb8fTk=;
 b=M2r68Kk7M5HFS5hRfPf1piv2WQjFs3xCaKE5AmWwWepO6yNaVVSiXFyAEFmB+NnjsxOL8XJc3YVZiSYmYNXNCUMDlor7+6o7a+oP1fUy/+t7/5mE37+oGHrsiFD0bxyTqbxsUge/pKaSPYVyvnnrL531W8zA6gnCzV2FqD2n5KwFoUnCje6h3QAXogebcg82iad3nMo7MaKqodGkziQZYEumrPrgzOjJEUqUvm14x5ydq/dbKigk/jnPso+0fHT7KXEFy40W0/R2SYFizW07pts6bsmIghE6n1aOO4YKBnfw0kzw2Zbwl5VvxfAcUZ18k5TM8DSAgYeUil076Lu7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Tue, 4 Jul
 2023 11:23:04 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 11:23:04 +0000
Date: Tue, 4 Jul 2023 13:19:24 +0200
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
Subject: Re: [PATCH bpf-next v2 12/20] xdp: Add checksum level hint
Message-ID: <ZKQAPBcIE/iCkiX2@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
 <64a331c338a5a_628d3208cb@john.notmuch>
 <ZKPlZ6Z8ni5+ZJCK@lincoln>
 <9cd44759-416c-7274-f805-ee9d756f15b1@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9cd44759-416c-7274-f805-ee9d756f15b1@redhat.com>
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BL1PR11MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 33298b87-dcca-4791-46b4-08db7c810888
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m11ozp+P/FF2/qLMbGzwBE9JddNIYPTOaDk72sqK96aZYWG7PaTWOoYNiRyvJ4pRHd0697g1MnEfSh8ErOHsh+QK0GXbp4BKzTQjYL1zPlLFNQz2LbZ/MQNoagaEh3ofqL0+8vrKb3BFh5rHrzEgepl/ZjqFtJwuojGorXIEtsreShqQmlvc5NsVGS0r95OTxWH89eWekqIgkoODaUjdJ6IAvXZjURKRINf3Ygb7QEj88E8Vz9Zyb6kltpywwUd66gERsafjJGOsZV2abW6TRK95axLxTFBoJv+ZMvVE27gtFX24nDwl42yVF15XsgwO3gqw6H0j9C1Ks+EaUO6RWocSEX9AupjdNGnqPrSyS1Q3jparhcywY3MozPFCNf1/idZHjiq9Zhr3/EUi75q34M+aSstDOM5yzJvSGqqfWZqtGfiPMnm2V+6v0LbKQlYFYVXwWAWlhRWF6b+ISKnf8G5Xb0/sZ8I5n5ns0ZnPI/tMYiArlJUslzCeBwMbplDHMqXd9G7yEOZY2zvQnNzNlju/tlJL15xtTBepfbGTalc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(41300700001)(5660300002)(54906003)(6486002)(44832011)(2906002)(316002)(8676002)(8936002)(7416002)(66899021)(4326008)(6916009)(66476007)(66556008)(33716001)(6666004)(6512007)(966005)(478600001)(82960400001)(38100700002)(186003)(86362001)(66946007)(83380400001)(6506007)(9686003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LK0DZMANIjSu+0sRUeDUbPerTmnCQHr1v+wOa3LisiPZUoVmMreECJ2p71D6?=
 =?us-ascii?Q?zVpSHVb7pHb6Zm8CaZPDiWEvO+wXI5BFZTwUB60X6I4iccAiajvyycD4AbAX?=
 =?us-ascii?Q?e/lRE1TI+Y6yFghxIvvUUye1v3h3g/DCsg+Ed3ELdSAkUBlc/XELVxx3PldZ?=
 =?us-ascii?Q?6uI31VbRHV9ahFqNZf5u9EDVwhDbd8iT/NGelm4Z7qE+oK8yDoTPnLeJwU5m?=
 =?us-ascii?Q?vkoD1ngua71dM94UvQ5eBfMiHdK3qriEQkG/amzamtPLynLcNYpzwWnJWpax?=
 =?us-ascii?Q?5ORg/KoA4U23qmRC1QtieMYkA/ZzHTflXLXh0Yppaa66SFR1nu2Ay+5gkBr+?=
 =?us-ascii?Q?LkC4Kcvqz06KLuvzsJHIuuZ8bM9IiRZnYATE+kOknXdezp1cxhojV8OQnsoh?=
 =?us-ascii?Q?HYjpEy6DeyEYBpsN/Cxp/hNtfaOslPQVLBjrnK0ih14e++nWpg9koanYDXxD?=
 =?us-ascii?Q?3e+Nv+/IFs3t46B3HL9kPKqqXKJhDudWiuVZYY9+ABtDXRMX+/uXGNsIwyGu?=
 =?us-ascii?Q?DjbIZGOH4x9RGAa3p+DQEpC5OXpXVGHu9mnZCle7sE/zWvy3SK/HxVixR+Xa?=
 =?us-ascii?Q?l4iPtlB+r/4rqgNgZhrplJhYakZnJvBEIHr8BbQX+mOwegYy56m3rt27TCPa?=
 =?us-ascii?Q?fGiUkgMLljb681R54EwMouZreP/Sry6m/zM80mOes7RYmjgs8kHPuWtBwHU6?=
 =?us-ascii?Q?qEHqhj58MqX1c/52Z+j9xxOjIRaUsdONH7yezxPjXQOGacusKsg0DX447dW0?=
 =?us-ascii?Q?6aXLBTHtZWouSq4n01yOTU2PNRlM8Q+6n3fVTPKUfBDDhLQbcWUO24SF8u2e?=
 =?us-ascii?Q?4ZkTSCOuWMxGK7TnhtNLGu2tit1r8FzOJb6ormN0kCzIzh3Kqy5oJHPC9tT5?=
 =?us-ascii?Q?SHOvnStc/t9D5OHjxFjlo+RYHINeE9iTuDc24EKQ/5XgkNf2S2VMNGaKlsHb?=
 =?us-ascii?Q?FoIRk7f5B6zoMEPd6SQ4Q2iP5juYajbvwMsvXmAcbJb7QaT4GdHzM2TOODb0?=
 =?us-ascii?Q?OLuP9gnB501M4RZJebFPJKhbKhN2zAgte9rrCCi3TcNG6I/eDuWNOGlyeiXM?=
 =?us-ascii?Q?DDoAYy/qTRBbTywBh4WiwAVjnmXCigCyUsydGsB/XhcGF/5RAjNrPWsQpoUL?=
 =?us-ascii?Q?+vK78Xq6V8Uqg0BeD0UmoPK6i8scjzfs6k6HCQ6QpF870q6AduSBWZ2zl3jz?=
 =?us-ascii?Q?Xsp/myJ1wUwDUWBQcP0HK/J+g1ldX7+a01I0bAip9VvYPWLuBDhps9QPFiTm?=
 =?us-ascii?Q?THCMdo4VfWiDJ/XlJ0pccG7QayQhDkON0KclK6+lJbXz++xtwB4PZ8xaNAd7?=
 =?us-ascii?Q?RB5mySOkoQakAxHxmJWwDgBSzyuvq4f/9W/MDe/MniUDFPucJmIJUh3nt1b9?=
 =?us-ascii?Q?SLXPG9Q0BlO5j6YantZL0GpxKX8HRaWIfFNwN+Ic/19CyhopT8tYU3Zz64KL?=
 =?us-ascii?Q?z21wbQRp2tz2SERukq+WWSIN6xI3Ok/X1f6rd92ot+w5lXPuFeTCZLQQaxzo?=
 =?us-ascii?Q?dxAuCqH2VTpCY4Aa8SX4BiGNczgmt+VtJqdquoQlriqZDpzsfAoNYIMNJMx6?=
 =?us-ascii?Q?XBjl1L1fQQ3JZThFOSLu9t1kIBYSBEEQ6YxED2orkTZi7d0nkC7OhbGa88iZ?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33298b87-dcca-4791-46b4-08db7c810888
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 11:23:04.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVkU+bMCZmpJ5PQPQrl6PfebUFKLIAc0ipKizLiRyaXNxKyglunjUe++mOkje7pA38/9nN7Wi0mYmigjGhx0WaA+mG+q6ZDcOGBg6BC3r8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 12:39:06PM +0200, Jesper Dangaard Brouer wrote:
> Cc. DaveM+Alex Duyck, as I value your insights on checksums.
> 
> On 04/07/2023 11.24, Larysa Zaremba wrote:
> > On Mon, Jul 03, 2023 at 01:38:27PM -0700, John Fastabend wrote:
> > > Larysa Zaremba wrote:
> > > > Implement functionality that enables drivers to expose to XDP code,
> > > > whether checksums was checked and on what level.
> > > > 
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >   Documentation/networking/xdp-rx-metadata.rst |  3 +++
> > > >   include/linux/netdevice.h                    |  1 +
> > > >   include/net/xdp.h                            |  2 ++
> > > >   kernel/bpf/offload.c                         |  2 ++
> > > >   net/core/xdp.c                               | 21 ++++++++++++++++++++
> > > >   5 files changed, 29 insertions(+)
> > > > 
> > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > index ea6dd79a21d3..4ec6ddfd2a52 100644
> > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > > >   .. kernel-doc:: net/core/xdp.c
> > > >      :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > +.. kernel-doc:: net/core/xdp.c
> > > > +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
> > > > +
> > > >   An XDP program can use these kfuncs to read the metadata into stack
> > > >   variables for its own consumption. Or, to pass the metadata on to other
> > > >   consumers, an XDP program can store it into the metadata area carried
> > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > index 4fa4380e6d89..569563687172 100644
> > > > --- a/include/linux/netdevice.h
> > > > +++ b/include/linux/netdevice.h
> > > > @@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
> > > >   			       enum xdp_rss_hash_type *rss_type);
> > > >   	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
> > > >   				   __be16 *vlan_proto);
> > > > +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
> > > >   };
> > > >   /**
> > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > index 89c58f56ffc6..61ed38fa79d1 100644
> > > > --- a/include/net/xdp.h
> > > > +++ b/include/net/xdp.h
> > > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > >   			   bpf_xdp_metadata_rx_hash) \
> > > >   	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > > >   			   bpf_xdp_metadata_rx_vlan_tag) \
> > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
> > > > +			   bpf_xdp_metadata_rx_csum_lvl) \
> > > >   enum {
> > > >   #define XDP_METADATA_KFUNC(name, _) name,
> > > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > > index 986e7becfd42..a133fb775f49 100644
> > > > --- a/kernel/bpf/offload.c
> > > > +++ b/kernel/bpf/offload.c
> > > > @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
> > > >   		p = ops->xmo_rx_hash;
> > > >   	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
> > > >   		p = ops->xmo_rx_vlan_tag;
> > > > +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
> > > > +		p = ops->xmo_rx_csum_lvl;
> > > >   out:
> > > >   	up_read(&bpf_devs_lock);
> > > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > > index f6262c90e45f..c666d3e0a26c 100644
> > > > --- a/net/core/xdp.c
> > > > +++ b/net/core/xdp.c
> > > > @@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
> > > >   	return -EOPNOTSUPP;
> > > >   }
> > > > +/**
> > > > + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
> > > > + * @ctx: XDP context pointer.
> > > > + * @csum_level: Return value pointer.
> > > > + *
> > > > + * In case of success, csum_level contains depth of the last verified checksum.
> > > > + * If only the outermost checksum was verified, csum_level is 0, if both
> > > > + * encapsulation and inner transport checksums were verified, csum_level is 1,
> > > > + * and so on.
> > > > + * For more details, refer to csum_level field in sk_buff.
> > > > + *
> > > > + * Return:
> > > > + * * Returns 0 on success or ``-errno`` on error.
> > > > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > > > + * * ``-ENODATA``    : Checksum was not validated
> > > > + */
> > > > +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
> > > 
> > > Istead of ENODATA should we return what would be put in the ip_summed field
> > > CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,
> 
> I was thinking the same, what about checksum "type".
> 
> > > 
> > >   bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);
> > > 
> > > or something like that? Or is the thought that its not really necessary?
> > > I don't have a strong preference but figured it was worth asking.
> > > 
> > 
> > I see no value in returning CHECKSUM_COMPLETE without the actual checksum value.
> > Same with CHECKSUM_PARTIAL and csum_start. Returning those values too would
> > overcomplicate the function signature.
> 
> So, this kfunc bpf_xdp_metadata_rx_csum_lvl() success is it equivilent to
> CHECKSUM_UNNECESSARY?

This is 100% true for physical NICs, it's more complicated for veth, bacause it 
often receives CHECKSUM_PARTIAL, which shouldn't normally apprear on RX, but is 
treated by the network stack as a validated checksum, because there is no way 
internally generated packet could be messed up. I would be grateful if you could 
look at the veth patch and share your opinion about this.

> 
> Looking at documentation[1] (generated from skbuff.h):
>  [1] https://kernel.org/doc/html/latest/networking/skbuff.html#checksumming-of-received-packets-by-device
> 
> Is the idea that we can add another kfunc (new signature) than can deal
> with the other types of checksums (in a later kernel release)?
>

Yes, that is the idea.
 
> 
> > > > +{
> > > > +	return -EOPNOTSUPP;
> > > > +}
> > > > +
> > > >   __diag_pop();
> > 
> 


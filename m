Return-Path: <bpf+bounces-4238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC0749C10
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF4C2812C2
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6338F62;
	Thu,  6 Jul 2023 12:42:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB513086;
	Thu,  6 Jul 2023 12:42:39 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98950171D;
	Thu,  6 Jul 2023 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688647357; x=1720183357;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dcqITd1FT/YToV04kKsN6SHpZazkz0zC/GYQ6GRqNM4=;
  b=kJP0XRxCO50vacazXO45ZAtweSB4XgttpKRUITAkJRNeHz/bEGosyFfU
   E3Eg1YsHWWBRO4JgHCbbvkpI2hVF4IXbXsXmEorcx6giVLoQWPJbZKy1g
   8Z3NlzlDft9GLqh9AUzPadfp/+7DjYk7AECeR2Ka/sIMSA150W0QId4Fu
   aZSCaM6w/1+HML18caBWcrOWk16yoBVkkOdZuxlJ/Gns2JRJBoSfy8s8s
   lhAVRNWL2tHknlVOlCKPAx6joLrClMk7jzYoPVJOlxCLCsI4kNXA+STaC
   GgPqhHWoY3pygOZIpGh4Tdm7d49t3VMuc/GPslxXwOAzP5HwWrOxi1nHt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="367082196"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="367082196"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="832926733"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="832926733"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2023 05:42:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 05:42:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 05:42:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 05:42:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dU/S69rwjEK1doLLi6KmGfIn0Gr+jMNrLunDEZdFZnLvxINbWv2fQYQl9BKVlJhKsrGjGlXjKrFgNcoDuQvYKdiSqTKsULwoSzO1abTpe0gpmuhpK461XSc3h1LvnT78grjQpPPpQcewd4f3LuP+xg51f2fsSIwounEzOUG9q53ak9FV3RsrkCfISddErJuSFGKU/cChBnghAZ/d4Dh/fVpPbnawh+2biyytwS4ATNUdO6S9ycp25h/arxjetlSaAhAmkt2VVJqPQeiY8GJLOV2OkerFIGR6FiHxYXTql83ZSd6GJVkthlAEIskWU6eMbjXlJf7tD4tEy8NsZpxHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itJtzNeQUiYmM6oAMWPI5MmiHNmH7T9Q/8NsftK3+ik=;
 b=Q3wJUaO4ON/1SGdf+cAWu/kOi5bXN9EUAabZXTw9bJAgZ6v0mCbAbgrJUP1Y6WCBdtulzDhpAU5VOElLZwx5C8D3+D2TMQwLR3TXZku+bKgJwPphE3wEFkq1rrJdv5nTJwrgf/Ro20fHvOf2J1QlOgoIZdxzzsy2kHREypNs0P/0I77j1+hMdqVV8XdelFo2yIGnYPG8Efsm/RrVIlPJt8nfdBxcUicwXAUshZp6i5YiA2uvRKS2K6OCd6Rk8j1Wd19FYFAM9AI6oTPFs3KDERIbdYoswx8AHhBfHP7e1erR/oAWMnzwbdEmMfIKc2pMXbIyOGDkCAsRRq9+5tXDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CY5PR11MB6138.namprd11.prod.outlook.com (2603:10b6:930:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 12:42:33 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:42:33 +0000
Date: Thu, 6 Jul 2023 14:38:33 +0200
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
Message-ID: <ZKa1ydBpmDCw4Ejp@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
 <64a331c338a5a_628d3208cb@john.notmuch>
 <ZKPlZ6Z8ni5+ZJCK@lincoln>
 <9cd44759-416c-7274-f805-ee9d756f15b1@redhat.com>
 <ZKQAPBcIE/iCkiX2@lincoln>
 <64a656273ee15_b20ce2087a@john.notmuch>
 <3cc1d2ba-e084-8fc4-aa31-856bc532d1a7@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3cc1d2ba-e084-8fc4-aa31-856bc532d1a7@redhat.com>
X-ClientProxiedBy: FR3P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::6) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CY5PR11MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 03062b66-a080-44fa-2487-08db7e1e775f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45E3aL6TznJamS0i8zLOp3VOj2s2wYtlpPTihUR4fKum127HCo8mzlC9D5qESlAT4rYinqNY7lz5kasBp49aCj2QvjetoI+RHeQrAfR8FjeDfQTziELb/hMMArjHurTbcBMNdPEREQ2LFZ09WHli1kvmtxl/iocI/cngAAeKHRQ1mN9Arzeaabokoosonx5m/ybPKNkBB/yDaYld8QVFCij81a8My8+EaTmnUCd+JYw8azyNH+uUMGW+GuPx3x/AOG3hhJ5sNkmute1L9LeU/VdE+jyX2lQVBbkt7g72IrmZU73W9PTpYg0ZdMYa0fKmHXPY9a6Tdrt6z2bl/qHAujxQKJSZrqkecz9lClqE6Sjt7BN1n5CV+C55Ql/rBk13gredbxpT242C7Zt8AmKhJcALlU1jNWa3Ibq1/InKnIDnqIgDaJ9YKDe6qx6p5m58RUipUz+1ptckg+ODs/GybMUE1l/hq/JfivACpQNbuwQZrlE9clF5L4FQixH+9jk+qPD6UJ7Q801n2kjQKPXN+qGWKCl4y3o4DDa5WrucHYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(38100700002)(9686003)(6486002)(26005)(6512007)(186003)(6506007)(82960400001)(966005)(54906003)(66946007)(4326008)(83380400001)(316002)(44832011)(6916009)(66476007)(66556008)(5660300002)(2906002)(7416002)(86362001)(66899021)(8676002)(41300700001)(8936002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J4HeXhO20FSfjasHyUvKyg74vRJm0hlGzZ4ESYMDJExUmQc4pikXy4czQNus?=
 =?us-ascii?Q?+KZ4cRW09V0vo7rluqhZqa3HHFY6gZ+J398dGu037pmBvY33K8IG6XXiCUu+?=
 =?us-ascii?Q?8kpKixFZlvwFLYg8P4HOrZzvepvvgX0VA5MxMF5fVHQHg3J6sNdQbik0ddHm?=
 =?us-ascii?Q?vDWef1dvufzHYLohS3V6ZYhbNnMhdU+sPSxoo3vIy6vkiWDgIaoAl8CkaTwt?=
 =?us-ascii?Q?N5dx8DWfP7Dqm52i76zUBsbuPvrw6PHubUcLH6dv2WN96MlZocUWmZbGNG1/?=
 =?us-ascii?Q?vbca9DWcUdhTBV0KarLQkvKOSKAWY1OHbhTu4HplhBxgz6GkVxqCssZR69Uy?=
 =?us-ascii?Q?U4ENMJQV0hurHVE1cNe4+jJ8MoY4BogazIKwISXr/FPecI1P1TdCi4vkDlXp?=
 =?us-ascii?Q?olToyMSFDnYssLw9tHbB1Y2f4E9ELkERjSOHbm74JFIEX5RpmUG555aVQ/mS?=
 =?us-ascii?Q?qUKuPuGmZzMZugA6Ay7ccB51ieglHnaKVRTJknn315WUTG70BxHKTwDGrTXg?=
 =?us-ascii?Q?He9kLPppJYAeo/NmLE26SmlVlr2FUrb64qIujd11TkdqGDuricBrIiltb4cs?=
 =?us-ascii?Q?6LKGGYPjTSfisSenOKqpf7o/UuBhGbZX1hKUjMGnE5P/QMj47fSPBVXZZqT1?=
 =?us-ascii?Q?DaBJOp8XGlaT2IRQoqthK7LZ+qVCyj5t8VkMvGcnsJSh0Dz9WGK+wDZ0fTcO?=
 =?us-ascii?Q?+cMraz6j4oNh9oSfldrkdSp+Yn8qRB4ezXzxIB4cr48vUB5Uaakry6IyZqcN?=
 =?us-ascii?Q?IO7EwxJ0sLJtzdqH1AGSeT16x51WKChQiwTdAwNttN70utIXYM7Znb05woIV?=
 =?us-ascii?Q?dIPM/BUdruaZPokTIzwkMjVd/IuQ/uAmrUAJaxhIb+335zvm1vio/jy5955m?=
 =?us-ascii?Q?SBpoao4bW4WqXICRAl47AQYJD5JX3wyLmBaT2csnvUgzNMuVx3pnQaDN6gwv?=
 =?us-ascii?Q?3i3C/MBHT3t17o0/Qqd2LpbaQqqPKI+MvLWZDqsyU5hXbXYraVwhKIYZMZsZ?=
 =?us-ascii?Q?tGQPaECVTtpTb3xud4NQwzfIF4vnDK1tusHbsinrfTd1p6CBusIdzNPlrJjh?=
 =?us-ascii?Q?FLwvcRm+pFYUPY1PXul69/43hYg65D+nb77D2krN7rZzwpSuvZvW1Wy9WHvq?=
 =?us-ascii?Q?+P/U7yfiDfnkeXjt/LuXyfOXIoWbi7mZ7EegzXj+zX7aBkCUTDNOPwHOGbNk?=
 =?us-ascii?Q?yq9QZLc19RsaHjG/7JTQPtJKgJ2wXIw3vdmsqN8G+KX3GGMQz547s2yASWOh?=
 =?us-ascii?Q?LSt63+LkS3xCF07/7MVQvc2m3YhWfKkgrlt4noYkFsDf3Xc6eYFCCWhjxlDm?=
 =?us-ascii?Q?urF7x7HmD+UJPG5ZakbkofWAJXFkT4chPNLEB6JPAebwLPo1yJ29gLUqnRcx?=
 =?us-ascii?Q?dIZKXSc5TheKB91jI8eNGOU2RsDELXpCHF5cNBjCKNAPv4b5NH307a6HI/8R?=
 =?us-ascii?Q?IBe8PW1Zi+ULmONzBIhevyzRlPJoHZ/PpRQ+lV6M/FTmYR07QoX6VxKm7JYK?=
 =?us-ascii?Q?QroMEftd84kumY0Z6XIkHCOQD8vM3fqSJKI0YtQ+epiLJo/dj/cCYOZfNz5O?=
 =?us-ascii?Q?fM1lO1iS1rWV1CsZSB1jjxDL/43rH8xVzvujf9Cuk+E3eSya6miMabFojGKG?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03062b66-a080-44fa-2487-08db7e1e775f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:42:32.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1b/cjvgRDPAIRj4FJXYo730O3B+CKq53wmTGWxDUwjxuI/xcluCV74n1Pjb+u1LJnPl1nrDa70q+jjfRECBeEeyz78i2pa2MfeSnd+UxClI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6138
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 11:04:49AM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 06/07/2023 07.50, John Fastabend wrote:
> > Larysa Zaremba wrote:
> > > On Tue, Jul 04, 2023 at 12:39:06PM +0200, Jesper Dangaard Brouer wrote:
> > > > Cc. DaveM+Alex Duyck, as I value your insights on checksums.
> > > > 
> > > > On 04/07/2023 11.24, Larysa Zaremba wrote:
> > > > > On Mon, Jul 03, 2023 at 01:38:27PM -0700, John Fastabend wrote:
> > > > > > Larysa Zaremba wrote:
> > > > > > > Implement functionality that enables drivers to expose to XDP code,
> > > > > > > whether checksums was checked and on what level.
> > > > > > > 
> > > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > > ---
> > > > > > >    Documentation/networking/xdp-rx-metadata.rst |  3 +++
> > > > > > >    include/linux/netdevice.h                    |  1 +
> > > > > > >    include/net/xdp.h                            |  2 ++
> > > > > > >    kernel/bpf/offload.c                         |  2 ++
> > > > > > >    net/core/xdp.c                               | 21 ++++++++++++++++++++
> > > > > > >    5 files changed, 29 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > index ea6dd79a21d3..4ec6ddfd2a52 100644
> > > > > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > > > > > >    .. kernel-doc:: net/core/xdp.c
> > > > > > >       :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > > > +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
> > > > > > > +
> > > > > > >    An XDP program can use these kfuncs to read the metadata into stack
> > > > > > >    variables for its own consumption. Or, to pass the metadata on to other
> > > > > > >    consumers, an XDP program can store it into the metadata area carried
> > > > > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > > > > index 4fa4380e6d89..569563687172 100644
> > > > > > > --- a/include/linux/netdevice.h
> > > > > > > +++ b/include/linux/netdevice.h
> > > > > > > @@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
> > > > > > >    			       enum xdp_rss_hash_type *rss_type);
> > > > > > >    	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
> > > > > > >    				   __be16 *vlan_proto);
> > > > > > > +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
> > > > > > >    };
> > > > > > >    /**
> > > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > > index 89c58f56ffc6..61ed38fa79d1 100644
> > > > > > > --- a/include/net/xdp.h
> > > > > > > +++ b/include/net/xdp.h
> > > > > > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > > > > >    			   bpf_xdp_metadata_rx_hash) \
> > > > > > >    	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > > > > > >    			   bpf_xdp_metadata_rx_vlan_tag) \
> > > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
> > > > > > > +			   bpf_xdp_metadata_rx_csum_lvl) \
> > > > > > >    enum {
> > > > > > >    #define XDP_METADATA_KFUNC(name, _) name,
> > > > > > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > > > > > index 986e7becfd42..a133fb775f49 100644
> > > > > > > --- a/kernel/bpf/offload.c
> > > > > > > +++ b/kernel/bpf/offload.c
> > > > > > > @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
> > > > > > >    		p = ops->xmo_rx_hash;
> > > > > > >    	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
> > > > > > >    		p = ops->xmo_rx_vlan_tag;
> > > > > > > +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
> > > > > > > +		p = ops->xmo_rx_csum_lvl;
> > > > > > >    out:
> > > > > > >    	up_read(&bpf_devs_lock);
> > > > > > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > > > > > index f6262c90e45f..c666d3e0a26c 100644
> > > > > > > --- a/net/core/xdp.c
> > > > > > > +++ b/net/core/xdp.c
> > > > > > > @@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
> > > > > > >    	return -EOPNOTSUPP;
> > > > > > >    }
> > > > > > > +/**
> > > > > > > + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
> > > > > > > + * @ctx: XDP context pointer.
> > > > > > > + * @csum_level: Return value pointer.
> > > > > > > + *
> > > > > > > + * In case of success, csum_level contains depth of the last verified checksum.
> > > > > > > + * If only the outermost checksum was verified, csum_level is 0, if both
> > > > > > > + * encapsulation and inner transport checksums were verified, csum_level is 1,
> > > > > > > + * and so on.
> > > > > > > + * For more details, refer to csum_level field in sk_buff.
> > > > > > > + *
> > > > > > > + * Return:
> > > > > > > + * * Returns 0 on success or ``-errno`` on error.
> > > > > > > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > > > > > > + * * ``-ENODATA``    : Checksum was not validated
> > > > > > > + */
> > > > > > > +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
> > > > > > 
> > > > > > Istead of ENODATA should we return what would be put in the ip_summed field
> > > > > > CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,
> > > > 
> > > > I was thinking the same, what about checksum "type".
> > > > 
> > > > > > 
> > > > > >    bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);
> > > > > > 
> > > > > > or something like that? Or is the thought that its not really necessary?
> > > > > > I don't have a strong preference but figured it was worth asking.
> > > > > > 
> > > > > 
> > > > > I see no value in returning CHECKSUM_COMPLETE without the actual checksum value.
> > > > > Same with CHECKSUM_PARTIAL and csum_start. Returning those values too would
> > > > > overcomplicate the function signature.
> > > > 
> > > > So, this kfunc bpf_xdp_metadata_rx_csum_lvl() success is it equivilent to
> > > > CHECKSUM_UNNECESSARY?
> > > 
> > > This is 100% true for physical NICs, it's more complicated for veth, bacause it
> > > often receives CHECKSUM_PARTIAL, which shouldn't normally apprear on RX, but is
> > > treated by the network stack as a validated checksum, because there is no way
> > > internally generated packet could be messed up. I would be grateful if you could
> > > look at the veth patch and share your opinion about this.
> > > 
> > > > 
> > > > Looking at documentation[1] (generated from skbuff.h):
> > > >   [1] https://kernel.org/doc/html/latest/networking/skbuff.html#checksumming-of-received-packets-by-device
> > > > 
> > > > Is the idea that we can add another kfunc (new signature) than can deal
> > > > with the other types of checksums (in a later kernel release)?
> > > > 
> > > 
> > > Yes, that is the idea.
> > 
> > If we think there is a chance we might need another kfunc we should add it
> > in the same kfunc. It would be unfortunate to have to do two kfuncs when
> > one would work. It shouldn't cost much/anything(?) to hardcode the type for
> > most cases? I think if we need it later I would advocate for updating this
> > kfunc to support it. Of course then userspace will have to swivel on the
> > kfunc signature.
> > 
> 
> I think it might make sense to have 3 kfuncs for checksumming.
> As this would allow BPF-prog to focus on CHECKSUM_UNNECESSARY, and then
> only call additional kfunc for extracting e.g csum_start  + csum_offset
> when type is CHECKSUM_PARTIAL.
> 
> We could extend bpf_xdp_metadata_rx_csum_lvl() to give the csum_type
> CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}.
> 
>  int bpf_xdp_metadata_rx_csum_lvl(*ctx, u8 *csum_level, u8 *csum_type)
> 
> And then add two kfunc e.g.
>  (1) bpf_xdp_metadata_rx_csum_partial(ctx, start, offset)
>  (2) bpf_xdp_metadata_rx_csum_complete(ctx, csum)
> 
> Pseudo BPF-prog code:
> 
>  err = bpf_xdp_metadata_rx_csum_lvl(ctx, level, type);
>  if (!err && type != CHECKSUM_UNNECESSARY) {
>      if (type == CHECKSUM_PARTIAL)
>          err = bpf_xdp_metadata_rx_csum_partial(ctx, start, offset);
>      if (type == CHECKSUM_COMPLETE)
>          err = bpf_xdp_metadata_rx_csum_complete(ctx, csum);
>  }
> 
> Looking at code, I feel we could rename [...]_csum_lvl to csum_type.
> E.g. bpf_xdp_metadata_rx_csum_type.
>

What about:

union csum_info {
	struct {
		u16 csum_start;
		u16 csum_offset;
	};
	u32 checksum;
	u8 checksum_level;
};

bpf_xdp_metadata_rx_csum(*ctx, u8 *csum_status, union csum_info *info);

One thing that is worth considering in my opinion is whether some hardware can 
provide both CHECKSUM_UNNECESSARY and CHECKSUM_COMPLETE. Judging by [0], this 
does occur. I such cases using an enum to represent the checksum status would 
artificially limit the capabilities. Now, imagine the situation:

- You want to use your XDP program with 2 different NICs

[...]

err = bpf_xdp_metadata_rx_csum(*ctx, &status, &info);
if (!err && status == CHECKSUM_UNNECESSARY)
	/* Do stuff */

[...]
- One NIC can both calculate CHECKSUM_COMPLETE and parse headers, another one 
  is only able to parse headers. Those can be very similar NICs from different 
  generation.
- You test your program on the simpler NIC, program works fine.
- You tests your program on the more advanced one and suddenly you need an 
  'else if' case with some additional calculations.

Please write, whether this makes sense :D and if so, we can work out a solution.

> Feel free to disagree,
> --Jesper
> 
> 


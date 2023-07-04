Return-Path: <bpf+bounces-3964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A7746F62
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 13:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AC11C208C2
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 11:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3806A5679;
	Tue,  4 Jul 2023 11:05:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5264EBC;
	Tue,  4 Jul 2023 11:05:56 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BAA3;
	Tue,  4 Jul 2023 04:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688468755; x=1720004755;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hT/A2TMge2QjE3MiBFSlD5bjoBNGNEhYWLLK3ZlahtM=;
  b=NX2KU3/Jpb6sAtBScCBwZL6PdIin4Badfg6g6zJPE/HsTbEdCORg4TBJ
   vWC3TiMddjfT9EazSSS/3A0NY9O8gK8iqqcXC6sqKcDKvXqId6evCk5H5
   BajhpQrr/RGg8zFDWZkHVA7uDk1xhA/9IKAc4lSsbO4BZvskgHKCKXVu+
   fjsLBm5L/igYbnZKjwAVugBQRn7HoK6Qu3Q5Rnu1idpbrNMdsosSStVs/
   lvrDczQwObX3z5YeFOfYvtSRTMFC0Jsi7f7jtPbsXI3H5oRIOFxh2qH8h
   ZUgboSW1Upfx9C+uANrPphhFP9OcqWm25BGEOzdlorlVUHDk8Z+IxT1hk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393842450"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="393842450"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 04:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788827358"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="788827358"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2023 04:05:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 04:05:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 04:05:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 04:05:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgW6mv131WsobjeLFgZ7lgFwLiqUagb1NlsT2TIKON0Vc8DQWdtbW7usuyCzh04BChjA5grwdV1/8Fn8GWKr/vbeJn+bEp+KHDGCB4wZXxgtcCUkyV0+n1Bjtk+/q9MWibMJGhtfnLEIbteXjaXORgy48PgUuiOu3ctSoEm/korOZTPd7l9pdbz4xEkO51TwD2MNqXoONxaw/qjRjWBKymYOBSTBuvu7wLUCqvTFYSeJaPlk1WI5sQxbuPWvuW/PCQhUyNdqjM6Mioa2juc/77kbYeexaT4McHTFmM3t2XZwmQQyO9mAbSgIXlSDgsm3gbnYLvMbbnQmlepJMdcWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQWs7izG4bxyFtEeZXmqwPfKWDNgpepew4Z9cJVHZf8=;
 b=m3gRXt0AV3TlNsEf0SksoSVK+lQC8WdBe3hxJPqQ9JuyLISl6AilRahHZADV01S56pEPWPsqgVlzh2SKz6pVm+thx01YHu4MCnVCXHK8szPAIgZcz3ZjGOfCco7A1ZPoz68cUi+WWwBR9SSTd9ah1UNnlqNtW3Q+xz3mK6b2FzzqpSHef/SE/oa+XrKp4OG83ktyl8xifZfw/YQH0TotswLi5HEK/1uNvsxb4yPeFi1UdMIyqJPkoND4BOQPrTrS/nllTgNpvUtv1ZXpjBhePD4vge6Eg7/u38/kR9Eps6b2qPD4sTaxkBdWfgtXzlinVz20YitysELSpDxtyscFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 11:05:44 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 11:05:43 +0000
Date: Tue, 4 Jul 2023 13:02:01 +0200
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
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH bpf-next v2 09/20] xdp: Add VLAN tag hint
Message-ID: <ZKP8KRy04IqyHXuI@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-10-larysa.zaremba@intel.com>
 <64a32c661648e_628d32085f@john.notmuch>
 <ZKPW6azl0Ak27wSO@lincoln>
 <f7aa7eb6-4600-cebf-bd09-d05fc627fd0d@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7aa7eb6-4600-cebf-bd09-d05fc627fd0d@redhat.com>
X-ClientProxiedBy: BE1P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::6) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: e85be7f1-1d31-4b72-7686-08db7c7e9c36
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXDl2WRNKXyL1IPGUtJcOikKNRwJo3AkWl+N02kVJ1/1D7Duo1dgaLHkag3bMS2bCI9CEpd9T0n03jf+HaLF8plBLbROBBahMRt6bNU3xcBoeJC4CSwak83Q7aRPXWf37rtfzDVtqk9GTDHjeLx6aWHqG3S5FDF8t3rRP1krxRh1WoI6jNAUCK0BHhhO4Vi/rPUO4U8iRk+MN2ErCFjMV1MJhUjclzQpw71pk1ADbseE4TxbgI4zs0cr/NoHlFcGGtkfB/rnSl0tDWyssHgs3wOPBMWvbUOv96XNUfyg3D4tq6wAMpC8khQGZf+XUwHabbBToVCSD+lOEEMR+2kOf63ds5W+uxDgydGqOxrbo5CXLSH3vJcBfVCx9Fymqd7gwUFxZqrSgZBpfoD8ooE6ktae+7TkbCF7bDJaHqcPq+NJWbouGHopjWxZG+UkSTRpI+CSDNWlqgWCtct/g0q89W8a2Q3BR2YOO5WYVTQHhOXthponVsDr7kkJfQsuD0WgVm/hgSarS0FRCcnDyKL9xGQN0x7J76AipK01v6nlF+fCae8s1hseNZmMW10tArqe2Mp7GuL3QJuPjixwkGZUmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(26005)(478600001)(9686003)(82960400001)(6666004)(6512007)(966005)(6506007)(86362001)(186003)(38100700002)(54906003)(66476007)(6916009)(66556008)(4326008)(66946007)(83380400001)(6486002)(316002)(8676002)(8936002)(44832011)(7416002)(41300700001)(2906002)(5660300002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Mz4M1n9iWNAs4oyHWBbL1JY2JAX8PCmX+PiYdgSrTwZjsgL7l2Fq39gu6BU?=
 =?us-ascii?Q?So7x1AE8vvSq/elmvRi2+/RrPQbUrFSanAfSDkKtrq2TOCllxoNXBQyLg+mJ?=
 =?us-ascii?Q?dmNES+jWvDnoDmQOpuyaDo1QvP++2WJt9J6718IFxlvdkHTRPuzBe0Iga6kP?=
 =?us-ascii?Q?ngR6gMmmiMUAKQQh62mktEAUH2kblDF8X70Bs6vmfeSyMWZnL5o8s/GmXg3t?=
 =?us-ascii?Q?kAy/l73udryGubC/+o94UbjtR+VoYp0/GvIjw8XefTGwmjyGzwcInu9ONLbf?=
 =?us-ascii?Q?9LAYBCWqslO5WyDkMqUKSuY91Vr6kKnjG13QUxisPT5vgUDqi6Ki39yE4KEh?=
 =?us-ascii?Q?aQKDnVcde1NekicYsb3r6dVMNiVqmyRynI/t/RumSXboqp0otxfref3pOXj/?=
 =?us-ascii?Q?JtZomSuqNW0UXK0SUVFnkU3eS0Rfgb75rSI9na2A7yWKyWJItX/GewdDRBRz?=
 =?us-ascii?Q?zxyGhK1X2LYrGnJFOYVlETymrbbbFEsgv1Yj8JxcxLOMfLK7mDfQtL4uT98v?=
 =?us-ascii?Q?Vk7kTOGVCr0biH4SzomJXpGZFoQeAhvAiSzMc9vaBNfXksppxHwZJejmczGP?=
 =?us-ascii?Q?zazYNPY6GzOnIV45AzRuse6+GZO7K+aTYvz9blctfBWAOXwrcaX2aB0UrG3O?=
 =?us-ascii?Q?aKWElDEW3OosFOv3HZFWKFgBNqiQFPxtzTGaNA+K4COA+UzhikRXxygXiBzR?=
 =?us-ascii?Q?w6n3epmMekWNc1PQU99AFPSM0b6O8F1Sy07X0cwixXhrzcDuwm6QgxiBN0OL?=
 =?us-ascii?Q?SFmmlp+MU30MYNP+4DnpQokPwhPbVvyeG7WzUogm21z/CBBC75xyj+isYYE/?=
 =?us-ascii?Q?tkJLhkOs1jAhY9GVp4toeOzhByJHyO3BNs4rs4slcMd1GjjYTn7g1dBnW1EM?=
 =?us-ascii?Q?JH9rPkn0xWIkTml2UsH4LGrV26girjslv+wKqS6C6gZnUL9Tjws+T6HDKEe6?=
 =?us-ascii?Q?CkvTTdfoiqcnL2qS6dWNgLKOmSrq7Ebca7kQOzIwfHj0Lr4OG0VWZRTRwziJ?=
 =?us-ascii?Q?pzEmxvzDkUQOJSr9f8DIq3CqBiXRjMVAnn+Onaw1QZ3ksRPy203ndyOVzm8/?=
 =?us-ascii?Q?3ovHYmudSaVuf9n7zikty7CwSDrTrgo+dXz8L+2AN7q/pLVxLsAaRcBFEfud?=
 =?us-ascii?Q?JDe8gd6V23uCwz+6bv9i073r4T8wjJ6KNdWKJj//xSpsWS9oMXyutl0+OWAn?=
 =?us-ascii?Q?92A/DI0te1Ts2eegH54jhcoX2LG9FM3x01UprOEdOQMJKKAN4aUnAvsp8aWY?=
 =?us-ascii?Q?Ks5WBGdeKo4CA15Yw+tf3UOGsFx4or8dvLgHjJvc361vIpaePE6+PjYIiAjh?=
 =?us-ascii?Q?nuAfm7FN64NLdCQMlr4KUNSKTG4Frz1nJ1ZItcNozeI/+qXABqeGgbAQbla2?=
 =?us-ascii?Q?Ye7lw4SHARy+wqmuWRlMnYzvnH5C2lo6v1vxix4l90ijTfu1Sa7YcnBzyRg2?=
 =?us-ascii?Q?H1kReKd9ganPnrrzO8LvVBZwU0y9DojHYzFmHSVJLOM7qKT33zMPQbu8Pusn?=
 =?us-ascii?Q?I5Kw4+h+8hyKk+8W0iKs8bnLeh4m4xAVcacuNjy3DN5TavE9gRYgHWRzAOqe?=
 =?us-ascii?Q?zaZVyxGZzfiSGSfD6s8s6O6pa6YAOwXoPfoz4Pri3mTvcv3iIxkfeV8Mp13j?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e85be7f1-1d31-4b72-7686-08db7c7e9c36
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 11:05:43.3083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OzyerWSTwZW820YzjTkWbJLZ/ytkEHVyQz4m20EQC26OoD9hR/rIkecxUUVVXaLJNkvnnnwBahTC1PWw+W2wek/9Cr95IMnTUX4Q6lvt5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 12:23:45PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 04/07/2023 10.23, Larysa Zaremba wrote:
> > On Mon, Jul 03, 2023 at 01:15:34PM -0700, John Fastabend wrote:
> > > Larysa Zaremba wrote:
> > > > Implement functionality that enables drivers to expose VLAN tag
> > > > to XDP code.
> > > > 
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >   Documentation/networking/xdp-rx-metadata.rst |  8 +++++++-
> > > >   include/linux/netdevice.h                    |  2 ++
> > > >   include/net/xdp.h                            |  2 ++
> > > >   kernel/bpf/offload.c                         |  2 ++
> > > >   net/core/xdp.c                               | 20 ++++++++++++++++++++
> > > >   5 files changed, 33 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > index 25ce72af81c2..ea6dd79a21d3 100644
> > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
> > > >   metadata is supported, this set will grow:
> > > >   .. kernel-doc:: net/core/xdp.c
> > > > -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
> > > > +   :identifiers: bpf_xdp_metadata_rx_timestamp
> > > > +
> > > > +.. kernel-doc:: net/core/xdp.c
> > > > +   :identifiers: bpf_xdp_metadata_rx_hash
> > > > +
> > > > +.. kernel-doc:: net/core/xdp.c
> > > > +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > >   An XDP program can use these kfuncs to read the metadata into stack
> > > >   variables for its own consumption. Or, to pass the metadata on to other
> [...]
> > > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > > index 41e5ca8643ec..f6262c90e45f 100644
> > > > --- a/net/core/xdp.c
> > > > +++ b/net/core/xdp.c
> > > > @@ -738,6 +738,26 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
> > > >   	return -EOPNOTSUPP;
> > > >   }
> > > > +/**
> > > > + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag with protocol
> > > > + * @ctx: XDP context pointer.
> > > > + * @vlan_tag: Destination pointer for VLAN tag
> > > > + * @vlan_proto: Destination pointer for VLAN protocol identifier in network byte order.
> > > > + *
> > > > + * In case of success, vlan_tag contains VLAN tag, including 12 least significant bytes
> > > > + * containing VLAN ID, vlan_proto contains protocol identifier.
> > > 
> > > Above is a bit confusing to me at least.
> > > 
> > > The vlan tag would be both the 16bit TPID and 16bit TCI. What fields
> > > are to be included here? The VlanID or the full 16bit TCI meaning the
> > > PCP+DEI+VID?
> > 
> > It contains PCP+DEI+VID, in patch 16 ("selftests/bpf: Add flags and new hints to
> > xdp_hw_metadata") this is more clear, because the tag is parsed.
> > 
> 
> Do we really care about the "EtherType" proto (in VLAN speak TPID = Tag
> Protocol IDentifier)?
> I mean, it can basically only have two values[1], and we just wanted to
> know if it is a VLAN (that hardware offloaded/removed for us):

If we assume everyone follows the standard, this would be correct.
But apparently, some applications use some ambiguous value as a TPID [0].

So it is not hard to imagine, some NICs could alllow you to configure your 
custom TPID. I am not sure if any in-tree drivers actually do this, but I think 
it's nice to provide some flexibility on XDP level, especially considering 
network stack stores full vlan_proto.

[0] 
https://techhub.hpe.com/eginfolib/networking/docs/switches/7500/5200-1938a_l2-lan_cg/content/495503472.htm

> 
>  static __always_inline int proto_is_vlan(__u16 h_proto)
>  {
> 	return !!(h_proto == bpf_htons(ETH_P_8021Q) ||
> 		  h_proto == bpf_htons(ETH_P_8021AD));
>  }
> 
> [1] https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L75-L79
> 
> Cc. Andrew Lunn, as I notice DSA have a fake VLAN define ETH_P_DSA_8021Q
> (in file include/uapi/linux/if_ether.h)
> Is this actually in use?
> Maybe some hardware can "VLAN" offload this?
> 
> 
> > What about rephrasing it this way:
> > 
> > In case of success, vlan_proto contains VLAN protocol identifier (TPID),
> > vlan_tag contains the remaining 16 bits of a 802.1Q tag (PCP+DEI+VID).
> > 
> 
> Hmm, I think we can improve this further. This text becomes part of the
> documentation for end-users (target audience).  Thus, I think it is
> worth being more verbose and even mention the existing defines that we
> are expecting end-users to take advantage of.
> 
> What about:
> 
> In case of success. The VLAN EtherType is stored in vlan_proto (usually
> either ETH_P_8021Q or ETH_P_8021AD) also known as TPID (Tag Protocol
> IDentifier). The VLAN tag is stored in vlan_tag, which is a 16-bit field
> containing sub-fields (PCP+DEI+VID). The VLAN ID (VID) is 12-bits
> commonly extracted using mask VLAN_VID_MASK (0x0fff).  For the meaning
> of the sub-fields Priority Code Point (PCP) and Drop Eligible Indicator
> (DEI) (formerly CFI) please reference other documentation. Remember
> these 16-bit fields are stored in network-byte. Thus, transformation
> with byte-order helper functions like bpf_ntohs() are needed.
> 

AFAIK, vlan_tag is stored in host byte order, this is how it is in skb.
In ice, we receive VLAN tag in descriptor already in LE.
Only protocol is BE (network byte order). So I would replace the last 2 
sentences with the following:

vlan_tag is stored in host byte order, so no byte order conversion is needed.
vlan_proto is stored in network byte order, the suggested way to use this value:

vlan_proto == bpf_htons(ETH_P_8021Q)

> 
> 
> > > I think by "including 12 least significant bytes" you
> > > mean bits,
> > 
> > Yes, my bad.
> > 
> > > but also not clear about those 4 other bits.
> > > 
> > > I can likely figure it out in next patches from implementation but
> > > would be nice to clean up docs.
> > > 
> > > > + *
> > > > + * Return:
> > > > + * * Returns 0 on success or ``-errno`` on error.
> > > > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > > > + * * ``-ENODATA``    : VLAN tag was not stripped or is not available
> > > > + */
> > > > +__bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tag,
> > > > +					     __be16 *vlan_proto)
> > > > +{
> > > > +	return -EOPNOTSUPP;
> > > > +}
> > > > +
> 
> 


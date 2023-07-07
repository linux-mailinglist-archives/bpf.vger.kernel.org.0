Return-Path: <bpf+bounces-4471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20774B613
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A8A2818A8
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55CE171C2;
	Fri,  7 Jul 2023 18:03:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBA11181;
	Fri,  7 Jul 2023 18:03:19 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857AE2110;
	Fri,  7 Jul 2023 11:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688752997; x=1720288997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J7dKqVbPXkxdhfaClt5rRZ0WeTA5vbHhKCv+P+AxX6g=;
  b=QJNyQUv0sCR1DaO6fe5yy/5QJKolvbhwEORpKTAVToJKZwn9wYJrvqgN
   yrKPc9daZS2Jv4HZcQZFJSvULdwtOBmORo1dzXt7UdJhO2a7QgNKm1EYt
   PgIgNERNtroKGmwdeVELfsa/5s0NPqEzLd+AUIE272+t24RzQ/WG8d55x
   tfa7DVun5qQKiyD2bRxcjncILYMYVK5TbqEq61MqDwEpekUGOEXMPsmuN
   TkNjfmp8xhcEFaeTjqid4n8pi6gmJFPQ69QYPbYAwLXrcEjWrKGC6oCK5
   Dvs7hnHmLFyuiGTJARBjv3mZafF2gwgzNGfug7ybl3uozcv1DOlhQhUiC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="343537076"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="343537076"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 11:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="1050630728"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="1050630728"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2023 11:02:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 11:02:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 11:02:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 11:02:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 11:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuNa0GRn83kQB5g80o/KGdmkLzhKstfowSKNj4pJUrVb2YJuqdvq39LHy2jIxTJab09i9JrNrPF3Yi3sXsQ343Z0mGKLyYGaI3g55S4GqwAWXgMXdiy7za/oJkkLxBE8q6ud6JyJsFyxwkPF6b4ElS453bfWu7Y9T6xvwskXYOlCnatua70X0F6MQobMldor9hInSPuX1o1dI3Qy1KdE4EOvuDmhZej9TlUoAYK6LKAkBOKs2lJ/4kfXmq3q75Ws+bol/l4wrBpKQQ/PD2C/SonUuCW5V2AmtIIfhv+k39vcLM/uaWn7Zs90kxKBxY/ldjto0+vcpe6LsWx5DIDYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP3E70C1ZmZISNqc/wP6oePnkvS8e2IFSfSsFCQDJ1w=;
 b=Nn5kTqU5NOUBLy7PrLRN45TT0GlWrjbpEHhPXNvJf4N5GMKy/8Ug58TozKBSsbjRqWQpg2h1/0gVjqD5YSI4hFmaAmCvApD3UFVca9XWalCN1siYgWNoD9SXaSzc+8HwFC99liyL4dYlURr6G0BpRXN0XKC5+ezfycmjWvTpbK5MWSB318r9mV3xrnhyk97bwwZIC2qxnV8STUArZpjNpzkNIqw07+LTEKHVUwUUQnIwJeAbTQXERplrjfZpu2tubCGqlzdyRo3b+kJansBMwdKsyVL2dvS1SeOqA3cinptjiMCF88ML8fpq7B3hVEUdAALGeRJWfwDvyPU9angGwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BN9PR11MB5369.namprd11.prod.outlook.com (2603:10b6:408:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 18:02:34 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 18:02:33 +0000
Date: Fri, 7 Jul 2023 19:58:21 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
CC: <brouer@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
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
Message-ID: <ZKhSPRYHGgFvG3BD@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-10-larysa.zaremba@intel.com>
 <64a32c661648e_628d32085f@john.notmuch>
 <ZKPW6azl0Ak27wSO@lincoln>
 <f7aa7eb6-4600-cebf-bd09-d05fc627fd0d@redhat.com>
 <ZKP8KRy04IqyHXuI@lincoln>
 <e0050610-ee6f-7c3c-a303-7cddc73cff7c@redhat.com>
 <ZKbTxDKCRlnJxyf0@lincoln>
 <bb8e2be1-4df9-8b26-468e-4d5d13e006c1@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bb8e2be1-4df9-8b26-468e-4d5d13e006c1@redhat.com>
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BN9PR11MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: fb428066-63ef-4662-cc02-08db7f145561
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyDE1m59rC83p195fjAbGZqgnoQMIxgvyDni5OZKw9/zu/FKKJl8/wryL2dvImgsWwdtpY1L7GwGHga4me0PaXvFZQDlSDPcGUliKR6tD76/LBTUQ0I6W5Mw3ibPV3XB1e6nSMw/p24wUS/R9bMQx1p0ol8n5JXgf4cbnm3wQGnno/N9aZJEEt+Ov7WITGehApNEE3bOSqHOb4SRbJFHwZDhpKZe71l1PNtYTJG05Pk3z75YVwxgXVO9lMbs4kEkxZiB8YNq2e/n5dkUGNk3lEOxSQ0YmScus9F52Ay3n2gvtV/yaawfDmYyVi2O8aKNRZHuV3iVyzYZ521+ZZKuWh8XS9LhLurEGCCrhqwnH0jmIZV7ZRFT9zU3J/eybs8qN2AalG9llqB74tpu6BLqgexUuuWHwgGvFnofymECOFXmMns21MR4WIuVYMIDbMTEAWRD3WtEsjy6e7zUhuB1Vzlkmaucxx0CYlk04RacBeu+1Pob1Farrm56Xwq4PFX+K84ttjWbqdoO2Rdi7g9SH1M9F92/iBkyyKebRQ0KRajxufweTP8ODvCHZ7jUAbU3MkZvXuA9FM1+gbYZSlxv4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(2906002)(41300700001)(8936002)(5660300002)(8676002)(7416002)(44832011)(33716001)(478600001)(26005)(966005)(82960400001)(6506007)(6512007)(186003)(6666004)(9686003)(6486002)(316002)(86362001)(6916009)(66556008)(66476007)(66946007)(4326008)(54906003)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OlBySWsYkQb0dO4WO47lOjQUchiCae3XUPnjG8Oafinnusne5H6EYadnVtFO?=
 =?us-ascii?Q?oxiHjXPEmTXAGqPrZYAxWBLoHp2vIvrXJ0b7uwr7fiTw/LyhoOeUF3/OFIJT?=
 =?us-ascii?Q?xdIRp+KTXDy8sjHY5+eTYz5zHpOKuc3X7/6fIF1J/LeW3rA4lGuAQOQcEMsO?=
 =?us-ascii?Q?wGmrXbL1TSmkZ08sTlUs8CeiVoJtVgkkOaK6Bxw7lnhb7YJXn6lkRJHUYFss?=
 =?us-ascii?Q?Zo0NSJuznVgWYEdyrzHIXPKIVbzh46ZV/0jW9Rc6z5H3l6FsYYnRqwMtmw/V?=
 =?us-ascii?Q?9Sb6AV15tg9vmVwkV7+1K+Hin+AwEzuq0oin8raujXtwfBupOZ1FKj0iaSXL?=
 =?us-ascii?Q?h/nFtrlCYq9Ll96SW0NlMPinju4Re4lCZQqtjexSjGsS2Kz/omKOnzhKo1dh?=
 =?us-ascii?Q?0HOSfKjUUjgJefyVZwng3vU6bpbbU86tAIggh6ypJWaKjmz0WMNvVPgXV2CT?=
 =?us-ascii?Q?hSOHZIdOXw1rn5pe4eAJ80aozC7d9oxkBCKuKdAKFP+MKXxls0Vr2YuQpWnh?=
 =?us-ascii?Q?BueO6erq5HHgXJo7K+ggwOnZvDqiwwZdOnXfFTVtNCXmTMM7ucZIGKi4ldYr?=
 =?us-ascii?Q?3MCLN6R/ECGHVNJBzvwV2pUAMt8/lAwFU3TBJVX42MkdQkjegP9HOIOGm4rI?=
 =?us-ascii?Q?OwH9ZJhdDoldG/zyvsu/T5cfXeHVN3z/ClUmv7PnP1i8vvGCsF2lQix9C1o7?=
 =?us-ascii?Q?VmUy/1kilt9KI1FJhqqTLSk7sr+Wn2BV/VS8LegIW2fCjiW1f7pJ6X6prb4t?=
 =?us-ascii?Q?moG3FMU/ajcjjNM8quHfUqSXkxZ+SVWlkkSCcAZoAHuawWpS4ETUAtyEjRpw?=
 =?us-ascii?Q?kYJpUUkbkRB45cSL28p28OWlDtjo2uGr4y62eo5QsnCcsvKwRePt7h7O1szq?=
 =?us-ascii?Q?HLZ3I9cSdrR6XQiLx3WZcSaoiOyiepzexS3ikjmCbkLj7z4B35tZjS3CnCV2?=
 =?us-ascii?Q?AAr9yyMRnQVZZPQan+cmf8QiGtHQJAiaw7E5X/IaXqX7JsOUoclYwzNFtvJv?=
 =?us-ascii?Q?E8CW2pQ1QpNVSAvRhkPfVaf/fUAE2Kb4dDJLTRBrOGajw/uJIwFVCMA8tiz4?=
 =?us-ascii?Q?i4221n+DFM0Ezpk8cV6ME9Ze6IOMEWIW887s4sS1znVQblx9+4mChwWy9lo8?=
 =?us-ascii?Q?HsAUBS5iQp8nsCK6YC4nsEXeuAYO9+cHhK4hN2GJVJdkBwD4lPVn4UL/zKIR?=
 =?us-ascii?Q?d0l2kZJe/VWzm1/oJnurUMhcTrKZQC4Wtz1rDMSQWn+v2vrW19riatBLLzdl?=
 =?us-ascii?Q?dh7GePvdIV86z31V4bVK1Y1pR9ycFxQv/n9N081FmgahN4KQYScphaLsnPv4?=
 =?us-ascii?Q?Bj6FGqds0rAXFI1E5dsnH7EUgjwnZBOvqVkgy/N8EwjVR3MM8xOJiXfhBlkV?=
 =?us-ascii?Q?+CAfErk8Wsk/UzMWNFW1j8OxsExpIwBeDHWH/c1Yjk7y4p+ixDN2wjy7aQLe?=
 =?us-ascii?Q?4A8zryweOadKl05IBwRerUV6rlJOuktyogP6koQaXD11scBYRbQoe+t1nx9L?=
 =?us-ascii?Q?SmfDyW/waoIvcoBXSpWWYVSNFm3aVwYwKSmuEE6dFeL6RRCBD7L8P11Lrliw?=
 =?us-ascii?Q?Vp0aMFHQt56k+8btry57T4AJyYVqsdf3taLQUouho28WDmI67Mq4zuOxEX+v?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb428066-63ef-4662-cc02-08db7f145561
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 18:02:31.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnvCOAHtcfH+moNptq7fBaIT+Fax9nw+fw/tmKva4dZLqFjfBII9dr2nz2429wEM++o7t7dAD5n9ZiFQ6E9fI8g5q7IvJXsVvzsu2p5erzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5369
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 03:57:13PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 06/07/2023 16.46, Larysa Zaremba wrote:
> > On Tue, Jul 04, 2023 at 04:18:04PM +0200, Jesper Dangaard Brouer wrote:
> > > 
> > > 
> > > On 04/07/2023 13.02, Larysa Zaremba wrote:
> > > > On Tue, Jul 04, 2023 at 12:23:45PM +0200, Jesper Dangaard Brouer wrote:
> > > > > 
> > > > > On 04/07/2023 10.23, Larysa Zaremba wrote:
> > > > > > On Mon, Jul 03, 2023 at 01:15:34PM -0700, John Fastabend wrote:
> > > > > > > Larysa Zaremba wrote:
> > > > > > > > Implement functionality that enables drivers to expose VLAN tag
> > > > > > > > to XDP code.
> > > > > > > > 
> > > > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > > > ---
> > > > > > > >     Documentation/networking/xdp-rx-metadata.rst |  8 +++++++-
> > > > > > > >     include/linux/netdevice.h                    |  2 ++
> > > > > > > >     include/net/xdp.h                            |  2 ++
> > > > > > > >     kernel/bpf/offload.c                         |  2 ++
> > > > > > > >     net/core/xdp.c                               | 20 ++++++++++++++++++++
> > > > > > > >     5 files changed, 33 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > > index 25ce72af81c2..ea6dd79a21d3 100644
> > > > > > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > > @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
> > > > > > > >     metadata is supported, this set will grow:
> > > > > > > >     .. kernel-doc:: net/core/xdp.c
> > > > > > > > -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
> > > > > > > > +   :identifiers: bpf_xdp_metadata_rx_timestamp
> > > > > > > > +
> > > > > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > > > > +   :identifiers: bpf_xdp_metadata_rx_hash
> > > > > > > > +
> > > > > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > > > > +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > > > > >     An XDP program can use these kfuncs to read the metadata into stack
> > > > > > > >     variables for its own consumption. Or, to pass the metadata on to other
> > > > > [...]
> > > > > > > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > > > > > > index 41e5ca8643ec..f6262c90e45f 100644
> > > > > > > > --- a/net/core/xdp.c
> > > > > > > > +++ b/net/core/xdp.c
> > > > > > > > @@ -738,6 +738,26 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
> > > > > > > >     	return -EOPNOTSUPP;
> > > > > > > >     }
> > > > > > > > +/**
> > > > > > > > + * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag with protocol
> > > > > > > > + * @ctx: XDP context pointer.
> > > > > > > > + * @vlan_tag: Destination pointer for VLAN tag
> > > > > > > > + * @vlan_proto: Destination pointer for VLAN protocol identifier in network byte order.
> > > > > > > > + *
> > > > > > > > + * In case of success, vlan_tag contains VLAN tag, including 12 least significant bytes
> > > > > > > > + * containing VLAN ID, vlan_proto contains protocol identifier.
> > > > > > > 
> > > > > > > Above is a bit confusing to me at least.
> > > > > > > 
> > > > > > > The vlan tag would be both the 16bit TPID and 16bit TCI. What fields
> > > > > > > are to be included here? The VlanID or the full 16bit TCI meaning the
> > > > > > > PCP+DEI+VID?
> > > > > > 
> > > > > > It contains PCP+DEI+VID, in patch 16 ("selftests/bpf: Add flags and new hints to
> > > > > > xdp_hw_metadata") this is more clear, because the tag is parsed.
> > > > > > 
> > > > > 
> > > > > Do we really care about the "EtherType" proto (in VLAN speak TPID = Tag
> > > > > Protocol IDentifier)?
> > > > > I mean, it can basically only have two values[1], and we just wanted to
> > > > > know if it is a VLAN (that hardware offloaded/removed for us):
> > > > 
> > > > If we assume everyone follows the standard, this would be correct.
> > > > But apparently, some applications use some ambiguous value as a TPID [0].
> > > > 
> > > > So it is not hard to imagine, some NICs could alllow you to configure your
> > > > custom TPID. I am not sure if any in-tree drivers actually do this, but I think
> > > > it's nice to provide some flexibility on XDP level, especially considering
> > > > network stack stores full vlan_proto.
> > > > 
> > > 
> > > I'm buying your argument, and agree it makes sense to provide TPID in
> > > the call signature.  Given weird hardware exists that allow people to
> > > configure custom TPID.
> > > 
> > > Looking through kernel defines (in uapi/linux/if_ether.h) I see evidence
> > > that funky QinQ EtherTypes have been used in the past:
> > > 
> > >   #define ETH_P_QINQ1	0x9100		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
> > > REGISTERED ID ] */
> > >   #define ETH_P_QINQ2	0x9200		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
> > > REGISTERED ID ] */
> > >   #define ETH_P_QINQ3	0x9300		/* deprecated QinQ VLAN [ NOT AN OFFICIALLY
> > > REGISTERED ID ] */
> > > 
> > > 
> > > > [0]
> > > > https://techhub.hpe.com/eginfolib/networking/docs/switches/7500/5200-1938a_l2-lan_cg/content/495503472.htm
> > > > 
> > > > > 
> > > > >    static __always_inline int proto_is_vlan(__u16 h_proto)
> > > > >    {
> > > > > 	return !!(h_proto == bpf_htons(ETH_P_8021Q) ||
> > > > > 		  h_proto == bpf_htons(ETH_P_8021AD));
> > > > >    }
> > > > > 
> > > > > [1] https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L75-L79
> > > > > 
> > > > > Cc. Andrew Lunn, as I notice DSA have a fake VLAN define ETH_P_DSA_8021Q
> > > > > (in file include/uapi/linux/if_ether.h)
> > > > > Is this actually in use?
> > > > > Maybe some hardware can "VLAN" offload this?
> > > > > 
> > > > > 
> > > > > > What about rephrasing it this way:
> > > > > > 
> > > > > > In case of success, vlan_proto contains VLAN protocol identifier (TPID),
> > > > > > vlan_tag contains the remaining 16 bits of a 802.1Q tag (PCP+DEI+VID).
> > > > > > 
> > > > > 
> > > > > Hmm, I think we can improve this further. This text becomes part of the
> > > > > documentation for end-users (target audience).  Thus, I think it is
> > > > > worth being more verbose and even mention the existing defines that we
> > > > > are expecting end-users to take advantage of.
> > > > > 
> > > > > What about:
> > > > > 
> > > > > In case of success. The VLAN EtherType is stored in vlan_proto (usually
> > > > > either ETH_P_8021Q or ETH_P_8021AD) also known as TPID (Tag Protocol
> > > > > IDentifier). The VLAN tag is stored in vlan_tag, which is a 16-bit field
> > > > > containing sub-fields (PCP+DEI+VID). The VLAN ID (VID) is 12-bits
> > > > > commonly extracted using mask VLAN_VID_MASK (0x0fff).  For the meaning
> > > > > of the sub-fields Priority Code Point (PCP) and Drop Eligible Indicator
> > > > > (DEI) (formerly CFI) please reference other documentation. Remember
> > > > > these 16-bit fields are stored in network-byte. Thus, transformation
> > > > > with byte-order helper functions like bpf_ntohs() are needed.
> > > > > 
> > > > 
> > > > AFAIK, vlan_tag is stored in host byte order, this is how it is in skb.
> > > 
> > > I'm not sure we should follow SKB storage scheme for XDP.
> > > 
> > 
> > I think following SKB convention is a good idea in this particular case. As I
> > have mentioned below, in ice VLAN TCI in descriptor already comes in LE, so no
> > point in converting it into BE, so somebody would use bpf_ntohs() later anyway.
> > We are not the only manufacturer that does this.
> > 
> 
> As long as other NIC hardware does the same this seems okay.
> 
> 
> > > > In ice, we receive VLAN tag in descriptor already in LE.
> > > > Only protocol is BE (network byte order). So I would replace the last 2
> > > > sentences with the following:
> > > > 
> > > > vlan_tag is stored in host byte order, so no byte order conversion is needed.
> > > 
> > > Yikes, that was unexpected.  This needs to be heavily documented in docs.
> > 
> > You mean the motivation, why it is so and not the other way around?
> > 
> 
> No, I don't mean the motivation.
> I simply mean write it in *bold*.
> 
> Look at the description for bpf_xdp_metadata_rx_hash, how it gets
> rendered [1] and how the code comments look [2].
> 
>  [1] https://kernel.org/doc/html/latest/networking/xdp-rx-metadata.html#general-design
>  [2] https://elixir.bootlin.com/linux/v6.4/source/net/core/xdp.c#L724
> 
> To save you some time compiling htmldocs target:
> 
>  make SPHINXDIRS="networking" V=1  htmldocs
> 

Ok, will do :)

> > > 
> > > When parsing packets, it is in network-byte-order, else my code is wrong
> > > here[1]:
> > > 
> > >    [1] https://github.com/xdp-project/bpf-examples/blob/master/include/xdp/parsing_helpers.h#L122
> > > 
> > > I'm accessing the skb->vlan_tci here [2], and I notice I don't do any
> > > byte-order conversions, so fortunately I didn't make a code mistake.
> > > 
> > >    [2] https://github.com/xdp-project/bpf-examples/blob/master/traffic-pacing-edt/edt_pacer_vlan.c#L215
> > > 
> > 
> > In raw packet, VLAN TCI is in network byte order, but skb requires NIC/driver
> > to convert it into host byte order before putting it into skb.
> > 
> 
> I'm interested in if *most* NIC hardware will deliver this in LE
> (Little-Endian) which is host-byte order on x86 ?
>

At least intel, pensando and some broadcom products get VLAN TCI in LE.
Mellanox gets in BE.

> 
> > > > vlan_proto is stored in network byte order, the suggested way to use this value:
> > > > 
> > > > vlan_proto == bpf_htons(ETH_P_8021Q)
> > > > 
> > > > > 
> > > > > 
> > > 
> > > --Jesper
> > > 
> > 
> 


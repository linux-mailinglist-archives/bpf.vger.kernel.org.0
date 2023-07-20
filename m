Return-Path: <bpf+bounces-5497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C9A75B3C3
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF365281F0D
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594119BA7;
	Thu, 20 Jul 2023 16:04:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2B918C35;
	Thu, 20 Jul 2023 16:04:28 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8FFFD;
	Thu, 20 Jul 2023 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689869067; x=1721405067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y/q70f0iuqKbGr63+XgFxJnEGlfHFL8ec/ky27m8rSA=;
  b=eDNB8N+y7IIb4XwF7RwenhWDHTNeUh84uM4QqX/zMjChRHNYE17L+T++
   TDQiXrMK4fnUstunXwEtWwV/09uIH4b9bqzRDYMyrrEBQJukF2KM4AfQ5
   wkG8Fw+4MOBQ0K752mSPQUzokk06cHD6PsCC8zr0wgYD+nseSXUZR2G28
   4c9KEMjBPPfF0mbvKGZ6yFI96Q0L1bQoUwm/hCTsPWIAXvgFGSrd9bPVQ
   MrVas7EcJF7175P5SxC1yndUxpp9AdUvRFdp7eIiP/P262AF3kaqiXhMl
   B+IzaW5rOL3b62WqBYNw3dmiyHMK6Rfwer72Ouvlw35NYurAwep9BsDPP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="430574939"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="430574939"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="754107095"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="754107095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2023 09:03:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 09:03:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 09:03:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 09:03:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 09:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7BJBupdAV6nHcAP1IVg5t3QsnfgIWWmk9pB9nB6t46UgmtLNu6TL6n8YFloEHqxSWUOtvWjnMJIPEfzb8tecnkXRQ061t5ZFQT6fp09grD99cszn9lifyd+HwSxtopz4VCZLjqsTMaubO+YabrW7btseQY84OuRu3BPB2aitca5WYGNtU7rXgbqvonb/rbt75T8I+3p6mCUFBzjIGke8qh8QWHpYsAFxy6vNcCuBS1k12EJeBQRTW2+hhRFEzCAdhnu1A0xb33li5exWYqf1OODWtPM0fg+FctzG53JvN4zEZk5DrJXkVtF8tOv6xKt8yyGzo4D4nIhc6vHRTAYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwEg7O69jGOUVsZazSidrE2UK+m819sUNmnEuh7Q4W4=;
 b=KGK7jC2lavEfN+c0BZi7cCCpzcHySsPvuHLpMlmWiQG8c4pM8JJ7ljB2SiFXM3qitSRHqnjGZRW0+tTkqNc5cf1Qd7K2AZoKGXWePXxdVK5uqZ68JmfeuFofyq8VCHBBR7sNMl4t0lC/ipN7P7SfpxUBaAwjSBolC7ZPvgSiwv/gdEB/2ZSe4vLASIwoxaTjcqQ+f0Y0Y1IAUSdJkNRyPykn/GNP15XNEDzOLxD41yGYCQrf9ymKCBM8rhDwWZIv1ditK9sIsmUIBPXnyH9xk9hsz2PP4ci1BcrlM921jx7ryGk2MU1172vQduvVRyp+QHaPtwbr9FUxhYdqMCDsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 16:03:30 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 16:03:30 +0000
From: "Zaremba, Larysa" <larysa.zaremba@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com"
	<yhs@fb.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Brouer, Jesper"
	<brouer@redhat.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, "Tahhan, Maryam" <mtahhan@redhat.com>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 12/21] xdp: Add checksum hint
Thread-Topic: [PATCH bpf-next v3 12/21] xdp: Add checksum hint
Thread-Index: Adm7I7oe9Af2qre8YU2aGST0pWWO4Q==
Date: Thu, 20 Jul 2023 16:03:30 +0000
Message-ID: <ZLlZ2E4rdKdBTqsf@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-13-larysa.zaremba@intel.com>
 <64b858ac9edd3_2849c129476@willemb.c.googlers.com.notmuch>
 <ZLkD/XWi+eQU9AQC@lincoln> <ZLkHK6Zbqwkxc8WM@lincoln>
 <64b93cc46ad9b_2ad92129445@willemb.c.googlers.com.notmuch>
In-Reply-To: <64b93cc46ad9b_2ad92129445@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|SJ0PR11MB5136:EE_
x-ms-office365-filtering-correlation-id: 0ae6bdd8-f0eb-47e5-a89e-08db893adc9f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xpaZGP3biX8jCf8rtCPlqlf1oAED0bu1Xne7SuzWvigXN6CuXbyUkK0qefi12huAmfTjEwrlpAZ9w+YE509jmUDQ35OYwJy1ao6hmsk267Ic+cgWmfICfig5NGcT066NM19QLIGJguLy8qjdjUlCKj2Xynle7gBaFikqtfKyMnd1Nz1gSbCdqZ+xsh2runG4J8mJlzgYkEcEYMfijtN0HGRSfnK9gKb6q+3oJXdou8L0G5VsT9Zilyn7V1KYVcwHEJZJYcaX3sGAyve0RHl73TOFgkus5jPVEs37zJuFqF07RgNR0mnnhi3jotF7cGuP5/WMGjilmwjcTg8To/7H6SrIOmYjUkZY74OApg4FTEl0p4bZsLCk7Jk7dnSX62Axz44OW4FGEsgQJvGz6Lb+Tqk0djaYXyAfAUTr56cP1h06Ewm8m+/NFVy3osfrOnPwvaJmm+1GZrH3xfbSOG94lKMO9ZC8gyzvI4VA/fNOs4D2nRPoStIfUvw0Ztk933udFzyA7RdqeVItBpVmSkzWweixwO0Pmvc9OHUP8t53HmhKm1kYJkJigU2Z4LQ4cFlQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(6486002)(9686003)(6512007)(478600001)(71200400001)(83380400001)(26005)(6506007)(5660300002)(186003)(7416002)(33716001)(66446008)(6916009)(64756008)(4326008)(66946007)(66476007)(54906003)(66556008)(8676002)(316002)(8936002)(41300700001)(2906002)(86362001)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FvaLzQZBwQt+7sFvmYqMykuam3dT9W2SGFMG2tFgBJrWCjmG15MaDNyL4abX?=
 =?us-ascii?Q?9mKSN0ZlTAgDzOq/gaFLVfRcXuCr0zB8FHVH2qdUtO4i6rwxmpoqhV23Nxt1?=
 =?us-ascii?Q?V/ayYW+Y2MIzIID5wJubhjyd/HYI1LYpesiemFh2CpUTfZ0pVQElE5CeeWpM?=
 =?us-ascii?Q?qh8ImoTdoQSrnrc91W7AW6B53Uzm9TnsSbGh89E3k+cpbBGhbViQzIfvMOYV?=
 =?us-ascii?Q?hpWS1cTPg133ohA8LJy3/KbBXCh9MB8XOWD8kEnXTOpBEJfWMzd01cD+MAr6?=
 =?us-ascii?Q?Uzf2jj1YXbbKx5UfcxoYkMIq6sQZyYXHpLWKJRhZp0sVkHhk3JCNv1RRvohr?=
 =?us-ascii?Q?N21cFVl2csfHuJmAY2M2CK+Jwvn+GrvvuPeqyzEAamZ33YfPiUk7t2Fe1tX3?=
 =?us-ascii?Q?huxaKaK87IV2xCi4LKkUAE4T6geawgqaKrgProPh5YSP5RdmN4ptNVQvlCVz?=
 =?us-ascii?Q?1+NPetGNkVC2R5EYdMPSYXt7ihx2tD3trYVjjJdw9vGJ/jtxcNc+32V7MDwQ?=
 =?us-ascii?Q?W1E9Gl7f97eygBpGvLMx0ams4ivstzcs9d2QN40zEj3r1e840fw+oF4iXr17?=
 =?us-ascii?Q?WfDjQuDmDgqZFUSGIxbvu4pu3E6q/2bTon70GN4SrE+68ArHNs2DgBLSkV1b?=
 =?us-ascii?Q?n+webTDrPR/ouEQ8JwhANDbUzZ/S9iOOfwsVKP4xTrM40ExyBAGo4QHjhYJ3?=
 =?us-ascii?Q?1YPKWn9idcsqS7JvoAE/0GCFD1F2sLmXof4gjzCHOTn3iCHUjd2WCwJFWk8W?=
 =?us-ascii?Q?LTxg7UeRvUu9xsS4KkwuwCeIUFwKweIYpXXmtU1yuIvZWHOaaTrg5ps3UdMf?=
 =?us-ascii?Q?MyP4M1+3zZ5wlWAdsghuAXbD58/GAteSq5tGfv5zRwXO4sZnQN862JpE7raM?=
 =?us-ascii?Q?DUPghuhABYuqA2ZVEAEuEgSLb6IB0MUydcbyoCoGpcvEV36Xwfc6s0eN/9Wz?=
 =?us-ascii?Q?QNGkm/B8vyd0kYzgFeIwnPe3Jd+t8aM/P3L2l2YjFmXgGHMDXNuaB1a8HsCr?=
 =?us-ascii?Q?JaRS/vV67QTpBRH76Wl3CIe+Pe/aPpkKK7hkVY4r55UdA/BDu8ejgeyZlevX?=
 =?us-ascii?Q?rDIYhu9rLqsrh+SQLSckoLz40qayIF6LmYmF8pKZt2bVYN114Vti1YiD4pAi?=
 =?us-ascii?Q?0OWsL6GlRwY+WCaOJf/Gcc/S9nDj9A1zU94ttS0Emi2czJHeoANIdyniSIrg?=
 =?us-ascii?Q?OabOXq2Odm7ixQvBYxHLPCsMeulQKu8lM2iO971dh9CEEM3HfVMYHDvF5SO/?=
 =?us-ascii?Q?vNMg5uHYJZ0UE3Q+Eibl+pn0MmWzWEbimPRMr6oow/AWzZiyCthVFqtjxo/0?=
 =?us-ascii?Q?byR3HIwsCNG2TNlU4q7MS/rzQibZ+NSHBruRcl6RJ5AEby4BRRuC7GJZWoPN?=
 =?us-ascii?Q?d7DWkBPBHLhE92KViisSZBDX9KPIGsEPoRww9hnFZPr1sAHolJmV2UEJgFmz?=
 =?us-ascii?Q?DiMpNrgOTWOQGGjzieqMpbBOkOQWPb8f81qPj3mxZPWKISk0ZLyb1iAKtYon?=
 =?us-ascii?Q?YDe5T+hVAEIsUtQrSxhgBTnFrHVhGA3l2IW8fB8/kES8GfQ/fdelFPW5r/2O?=
 =?us-ascii?Q?bJon9ufO93DwRiNVWzr+e3FrJluGKMQgbfOixAtbYZOYZ16iiaqPAUVwiqZ7?=
 =?us-ascii?Q?cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23F02B6546FBD5418FFE3E739038DFB9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae6bdd8-f0eb-47e5-a89e-08db893adc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 16:03:30.5116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ubgqYVJgi0A2BTtxZNz7fSwDK443SK8egJ9P1y+N6Sz4bWqKSuyh21s2LHJJILVJ6osASj3KBZowZXoO8KKx4vzN/7+1yU15TtUfcjTFJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 09:55:16AM -0400, Willem de Bruijn wrote:
> Zaremba, Larysa wrote:
> > On Thu, Jul 20, 2023 at 09:57:05AM +0000, Zaremba, Larysa wrote:
> > > On Wed, Jul 19, 2023 at 05:42:04PM -0400, Willem de Bruijn wrote:
> > > > Larysa Zaremba wrote:
> > > > > Implement functionality that enables drivers to expose to XDP cod=
e checksum
> > > > > information that consists of:
> > > > >=20
> > > > > - Checksum status - bitfield that consists of
> > > > >   - number of consecutive validated checksums. This is almost the=
 same as
> > > > >     csum_level in skb, but starts with 1. Enum names for those bi=
ts still
> > > > >     use checksum level concept, so it is less confusing for drive=
r
> > > > >     developers.
> > > > >   - Is checksum partial? This bit cannot coexist with any other
> > > > >   - Is there a complete checksum available?
> > > > > - Additional checksum data, a union of:
> > > > >   - checksum start and offset, if checksum is partial
> > > > >   - complete checksum, if available
> > > > >=20
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >  Documentation/networking/xdp-rx-metadata.rst |  3 ++
> > > > >  include/linux/netdevice.h                    |  3 ++
> > > > >  include/net/xdp.h                            | 46 ++++++++++++++=
++++++
> > > > >  kernel/bpf/offload.c                         |  2 +
> > > > >  net/core/xdp.c                               | 23 ++++++++++
> > > > >  5 files changed, 77 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Docum=
entation/networking/xdp-rx-metadata.rst
> > > > > index ea6dd79a21d3..7f056a44f682 100644
> > > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > > > >  .. kernel-doc:: net/core/xdp.c
> > > > >     :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > > =20
> > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > +   :identifiers: bpf_xdp_metadata_rx_csum
> > > > > +
> > > > >  An XDP program can use these kfuncs to read the metadata into st=
ack
> > > > >  variables for its own consumption. Or, to pass the metadata on t=
o other
> > > > >  consumers, an XDP program can store it into the metadata area ca=
rried
> > > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.=
h
> > > > > index 1749f4f75c64..4f6da36ac123 100644
> > > > > --- a/include/linux/netdevice.h
> > > > > +++ b/include/linux/netdevice.h
> > > > > @@ -1660,6 +1660,9 @@ struct xdp_metadata_ops {
> > > > >  			       enum xdp_rss_hash_type *rss_type);
> > > > >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
> > > > >  				   __be16 *vlan_proto);
> > > > > +	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
> > > > > +			       enum xdp_csum_status *csum_status,
> > > > > +			       union xdp_csum_info *csum_info);
> > > > >  };
> > > > > =20
> > > > >  /**
> > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > index 89c58f56ffc6..2b7a7d678ff4 100644
> > > > > --- a/include/net/xdp.h
> > > > > +++ b/include/net/xdp.h
> > > > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachme=
nt_info *info,
> > > > >  			   bpf_xdp_metadata_rx_hash) \
> > > > >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > > > >  			   bpf_xdp_metadata_rx_vlan_tag) \
> > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
> > > > > +			   bpf_xdp_metadata_rx_csum) \
> > > > > =20
> > > > >  enum {
> > > > >  #define XDP_METADATA_KFUNC(name, _) name,
> > > > > @@ -448,6 +450,50 @@ enum xdp_rss_hash_type {
> > > > >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP | XD=
P_RSS_L3_DYNHDR,
> > > > >  };
> > > > > =20
> > > > > +union xdp_csum_info {
> > > > > +	/* Checksum referred to by ``csum_start + csum_offset`` is cons=
idered
> > > > > +	 * valid, but was never calculated, TX device has to do this,
> > > > > +	 * starting from csum_start packet byte.
> > > > > +	 * Any preceding checksums are also considered valid.
> > > > > +	 * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``.
> > > > > +	 */
> > > > > +	struct {
> > > > > +		u16 csum_start;
> > > > > +		u16 csum_offset;
> > > > > +	};
> > > > > +
> > > > > +	/* Checksum, calculated over the whole packet.
> > > > > +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > > > +	 */
> > > > > +	u32 checksum;
> > > > > +};
> > > > > +
> > > > > +enum xdp_csum_status {
> > > > > +	/* HW had parsed several transport headers and validated their
> > > > > +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> > > > > +	 * 3 least significat bytes contain number of consecutive check=
sum,
> > > >=20
> > > > typo: significant
> > > >=20
> > > > (I did not scan for typos, just came across this when trying to und=
erstand
> > > > the skb->csum_level + 1 trick. Probably good to run a spell check).
> > > >
> >=20
> > Oh, and about skb->csum_level + 1, maybe this way it would be more=20
> > understandable: XDP_CHECKSUM_VALID_LVL0 + skb->csum_level?
>=20
> Agreed, that would help document the intent.
> =20
> > Using number of valid checksums (starts with 1) instead of checksum lev=
el=20
> > (starts with 0) is a debatable decision, but I have decided to go with =
it under=20
> > 2 assumptions:
> >=20
> > - the only reason checksum level in skb starts with 0 is to use less bi=
ts
> > - checksum number would be more intuitive for XDP/AF_XDP application de=
velopers
> >=20
> > I encourage everyone to share their opinion on that.
>=20
> I assumed this offset by one was because csum_status zero implicitly
> meant XDP_CHECKSUM_NONE. Is that not correct? That should probably
> get an explicit name.
>=20

Well, I was not sure, whether I should add XDP_CHECKSUM_NONE, because it wo=
uld=20
be equal to returning -ENODATA from kfunc, but after giving it some thought=
 now,=20
it is worth to have XDP_CHECKSUM_NONE for packets that have no checksum to=
=20
check, like for hash there is XDP_RSS_TYPE_L2.


Return-Path: <bpf+bounces-2984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5291737D2D
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3E62813B4
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E373C8C1;
	Wed, 21 Jun 2023 08:16:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D0E2AB55;
	Wed, 21 Jun 2023 08:16:09 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7519A1;
	Wed, 21 Jun 2023 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687335366; x=1718871366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2xcOPbX1DdUySYKbMp949A8XnZ4eN8565fGdYNWZUM0=;
  b=fOMNPbUwm7VUkJwAXWbmcMzErv4mGDGnDHAUvrEKJVKyiNExl8PzRRt8
   7GNQLBffgb/KJ/sZ2MnX8htrXlMpsoikhUJbANwMwyqlJQ0tFfpFuuACF
   kSOMGdeRwWv2PRl8z+icOn5hjrluRU2Zj2BL2hR5MEjhtncvJv41Op4rF
   KkWZWbHsKoNWxy55TTOTTrYr6T6Kcw6A47g+sGkf69ISeclPkjEy5zE2H
   5ClDpc0uenqMRbxcjOaN17VUgWlkpsLNSIuZVYFTCitVSb2FsY/FxkYEQ
   HCX5a1WVDIQ18LbnMFUoT1pMH14ljML8lIgJVub6GaSXiAlRMScaNiO41
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="426060045"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="426060045"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 01:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888573705"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="888573705"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 01:16:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 01:16:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 01:16:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 01:16:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwtQNPQgndKBimbLmGwXpfjspw/F2GUL2yOgRg2QHko508e7avB9O4WygvJ/CYroTQoPqxXPTPSawDRD/pbINmv8Tw3YIzm7V90Dqcxq7KTWs4/R8GHXPhIZs/QjuJaM4dx3EpZovQSimsg4wvJ217x8OKArSAo1v617x5obh5MJAa9XwJ3AbMkgDFGk832Dd+hOfDoSFRwgNFdW4jrwSdOd1PjP59O5w6MwA1EwiukskK5WAQguquc3AmtCwKZoQkC3aXttEC589C27U5159Zksu7z96NDYJFlv/kYjtowbKmUSMif3pVqHC9N8LTyTlE7l/V7h4ib/0PtzOCDdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAAgi3tAT5Ju7RzgXJcGZuUZQv9ylkgmoZ+ExYLPT5k=;
 b=AxjOErCP9592AJ7xA+gHmzv2vHk1BUTb243mimLrBLrYnqgsAdafOmVssYqRwfNZIktX6+O4l1Pud5ZMj8l4COaXBp5R593c4yiY+wjKt/QHJdwOmsnwOMVpoZoTKUvO5WgoVWizGeEcdDxwWH58lER/Tq9ItRL63u/rRF0xzjSgCTHzzuD8mW88/sq28q5MAqadIrd9g0/+JT9aMxUBPVeJfM5fNtROo4A+xv7sUO7HEckmesizhqw1Bf8UZQfuYOhpOzF9AxeR4eYddYTYB42TXwbPpe+YpZuxqimX9n/3SaO881GJ6dwt/DjjoA6A8+oXb7/nPJ7p6m5Vi5C+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 08:15:59 +0000
Received: from SN7PR11MB6655.namprd11.prod.outlook.com
 ([fe80::b883:574:e550:3d67]) by SN7PR11MB6655.namprd11.prod.outlook.com
 ([fe80::b883:574:e550:3d67%6]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 08:15:59 +0000
From: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
To: =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>
Subject: RE: [PATCH v4 bpf-next 06/22] xsk: introduce wrappers and helpers for
 supporting multi-buffer in Tx path
Thread-Topic: [PATCH v4 bpf-next 06/22] xsk: introduce wrappers and helpers
 for supporting multi-buffer in Tx path
Thread-Index: AQHZn66M9KVHikymvU6aRq3dvwXcuK+T+RCAgAD3qSA=
Date: Wed, 21 Jun 2023 08:15:59 +0000
Message-ID: <SN7PR11MB665536C0588850F0374EFBA3905DA@SN7PR11MB6655.namprd11.prod.outlook.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-7-maciej.fijalkowski@intel.com>
 <87352mdp10.fsf@toke.dk>
In-Reply-To: <87352mdp10.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6655:EE_|IA1PR11MB6217:EE_
x-ms-office365-filtering-correlation-id: 9a5b30a4-34da-4b48-664b-08db722fbee0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iryX+bAZGKcB0fh2E35aMOwFznbISys6NokVQoXZFTeoebDF45hHdTJWRthIAS0ciTyKkos6z6m+UEiJ8l+IOm9Wqi71J2yKVlHKyAYUUgh06wVb6AgRuemqMkIYqz65dEe9BywcAk48kfxvCk6RZNUPGhN+xRLzZExWNOW/OMRC1DophCisasP0V4Sb1xDdDnSGFKoMxqftsgRZme7rqAqLw4VdIRpZhnyGB4EZ5wZiry/rJ/FB5D2YZn/ew9JPbkGNhE+iR0yVzCHrgLgTl4KvP6LOc/QQH+v9PWAdHdf7Z6lfN+1yCSNirsPncBVmjudYxOcH4bmcQ7jZNVkOYAjX5ilczi8LCv7bmE441anj2tniG4o2P9j/tnYsinYkrJGm/iMWD/URAnJJbZwZqh1lzc6qyhJKaKPeGL6ftm5Q8ziPHcjbyysqldubzFmQyQ3CCLlo188hnTfsaT7IZEaDj6A1ogWD8Qs5/mgJx2uESwhcUEzj7LlOY84vebODQ3tIzpb51tp/3WJDOSVyY7m1kycJi3Tmg3QF5Joo9aKVX1bd/VxELa1BJbaqdGISS3rSzwFQD4aYNnLtqhaAOz/QdPsTXyW3M997LC6wNPyLhJDuVxFuMnX6kZ9PuZBP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(82960400001)(38070700005)(86362001)(33656002)(38100700002)(122000001)(66574015)(83380400001)(478600001)(110136005)(54906003)(7696005)(71200400001)(64756008)(316002)(66476007)(4326008)(66446008)(76116006)(66946007)(66556008)(55016003)(6506007)(53546011)(8676002)(8936002)(41300700001)(186003)(9686003)(26005)(2906002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5vm1SpFh4omW/gxf6JkWnmdCv02A6dYlPK9v9lqhxqhRGKqu2l7r5s080V?=
 =?iso-8859-1?Q?drk9ZWBWo7E2ERl/6pZqSNTY1mMaXJl77vzWYkJa9rYom2CdUakkTnABKK?=
 =?iso-8859-1?Q?p2prkiEtIrFTmswKzD5ZVZOWHt39qG3QuEpAE06IFIMDqYzWlJmDogJlYb?=
 =?iso-8859-1?Q?34SRDNZo28WydkmuFrzon6NyMH42GnQRy1izuTg0sGR24T72T7UsB1O9N6?=
 =?iso-8859-1?Q?b7degRNA4vEL9KM8EYV8l0U9bBOQOVnwnKoI0017513k0BBVRteL8EXMmy?=
 =?iso-8859-1?Q?w3I99Ws+ry5p8ymLUfoSLnt9WMgRucalqIFKmZCYdtN42KNtiL9N5rbOsr?=
 =?iso-8859-1?Q?PWfBy9tDInXs9IzGxM9jfdAEp/mnwEF6VHijsmrLTqpZHX0oodFYwUlXy3?=
 =?iso-8859-1?Q?AtnC18Q68f5+WZhDAvpy8AFeDRjRUwT7Hk235glAoGO6hZ7IZxaLvImZ2z?=
 =?iso-8859-1?Q?p7KrkvTX75fparrvuld/4SKNTqwSD4q7U1AzwoDnlXd5Jmmu2f5tpr2uSr?=
 =?iso-8859-1?Q?jDE2QSZbkyYgCAUwz5wqrhymM5EmrRDMieMwbNq1KE0UjpH4g63I3QOIPZ?=
 =?iso-8859-1?Q?irmXxu4sQC+EzOKlcK1r759bAjkz6jA5l1xfZGUtNKcYtVo+Y0KMSn1c2e?=
 =?iso-8859-1?Q?vGyliqCtK80iNe7rvSSz8wLfEPWFdeS9G9O9C5vTUAFAhfKVPpQg//pW9g?=
 =?iso-8859-1?Q?WR67sP7nFExHot27MUJfs8saPubpNGLUSZQB3EJuuqTrWalvoE5eh1o0Hu?=
 =?iso-8859-1?Q?G+S42/rBTvCHJXagIWKTe28b6d3ov584tMoygqKKCNk/NEKOB8qFF0VEx3?=
 =?iso-8859-1?Q?dh0YiLgIUScrHYbyVGc3DLE9whuA7rDCJqJpv8bYbAzW1BC6ylJpb5ifeW?=
 =?iso-8859-1?Q?6506H1ysVWwhSTbNswKyyS+ckvWni0mmfcQxBoCmprfQ8BaeBf1TsvH4+B?=
 =?iso-8859-1?Q?R4XF+hxSVfXktiPrc0pULDxHa4KAdGyPWJ+nUvqD96uQ63cI4mxJCU//jO?=
 =?iso-8859-1?Q?8vXhqF9nHtPeTaLr4ZyWwn8yJDc/cqHGGcVUBwWcffFWZ2n8KXsjd5BzWU?=
 =?iso-8859-1?Q?yD9j25FcXCQUXbXzrF+AAPT2nAS9LpJ21hiAn98ngbHOSvM/DCqEry6x6L?=
 =?iso-8859-1?Q?mU1p5VxUJlFP5blaiMowqs8t6bjVf4bOJzKr3DTb04C2xGTofagEsowqHc?=
 =?iso-8859-1?Q?hy/1VzMEcgRJX45NDVirxsdoeBcVNWGcYT121LuYVLl9Xmhas/tjiRQYIc?=
 =?iso-8859-1?Q?wi4OZcjM6iwZ7LSAS8tv6nXCalGdeNWb0ShO5UDSQkDIyYljaTM2GQgHVe?=
 =?iso-8859-1?Q?OKvuIAhu/gfDLQK7SeuLd0ZaSRpxCg6d/Bo0iTj+j6yFzBTRBFOdKTgzrB?=
 =?iso-8859-1?Q?F0QjR2e2N4UqeGXJbxtvXJTaUft7/KZw4WiMwUqDpVpSJiE+Wp+L63Ksli?=
 =?iso-8859-1?Q?WP+7pVgNHZ8+SPx85P/SGWnAErOm51cT8JsM/h+ktFRPN11VCYaZP2Nc5T?=
 =?iso-8859-1?Q?4VSIQmeQsaR+9mKytD70I0Oxkz5A7PZCJkUQ6Npa0mYjFy4ERCoIkmzU6D?=
 =?iso-8859-1?Q?yeKSgM8hVseB3y+8nPFWmroQYFLRRkMqYk4HaanyOq+8P5zZIUdJS3p00t?=
 =?iso-8859-1?Q?C3lSeeLQn+WQ4ekgpzotZKCjUpWJcqVBij?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5b30a4-34da-4b48-664b-08db722fbee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 08:15:59.4231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PO1zAP/PevbVN2yuf0Hl3aJfVDvZkCfF77C3nF/jDyGFj3sqn7nlJozpc57HN3tcf6Rf7IDdBXXp9JFEsMedBNF5IxL1194tQF1Q5OV0ORg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
> Sent: Tuesday, June 20, 2023 10:56 PM
>>
> Subject: Re: [PATCH v4 bpf-next 06/22] xsk: introduce wrappers and helper=
s
> for supporting multi-buffer in Tx path
>=20
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>=20
> > From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> >
> > In Tx path, xsk core reserves space for each desc to be transmitted in
> > the completion queue and it's address contained in it is stored in the
> > skb destructor arg. After successful transmission the skb destructor
> > submits the addr marking completion.
> >
> > To handle multiple descriptors per packet, now along with reserving
> > space for each descriptor, the corresponding address is also stored in
> > completion queue. The number of pending descriptors are stored in skb
> > destructor arg and is used by the skb destructor to update completions.
> >
> > Introduce 'skb' in xdp_sock to store a partially built packet when
> > __xsk_generic_xmit() must return before it sees the EOP descriptor for
> > the current packet so that packet building can resume in next call of
> > __xsk_generic_xmit().
> >
> > Helper functions are introduced to set and get the pending descriptors
> > in the skb destructor arg. Also, wrappers are introduced for storing
> > descriptor addresses, submitting and cancelling (for unsuccessful
> > transmissions) the number of completions.
> >
> > Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> > ---
> >  include/net/xdp_sock.h |  6 ++++
> >  net/xdp/xsk.c          | 74 ++++++++++++++++++++++++++++++------------
> >  net/xdp/xsk_queue.h    | 19 ++++-------
> >  3 files changed, 67 insertions(+), 32 deletions(-)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 36b0411a0d1b..1617af380162 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -68,6 +68,12 @@ struct xdp_sock {
> >  	u64 rx_dropped;
> >  	u64 rx_queue_full;
> >
> > +	/* When __xsk_generic_xmit() must return before it sees the EOP
> descriptor for the current
> > +	 * packet, the partially built skb is saved here so that packet build=
ing
> can resume in next
> > +	 * call of __xsk_generic_xmit().
> > +	 */
> > +	struct sk_buff *skb;
>=20
> What ensures this doesn't leak? IIUC, when the loop in
> __xsk_generic_xmit() gets to the end of a batch, userspace will get an
> EAGAIN error and be expected to retry the call later, right? But if
> userspace never retries, could the socket be torn down with this pointer
> still populated? I looked for something that would prevent this in
> subsequent patches, but couldn't find it; am I missing something?
>=20
> -Toke
>=20

Thanks for catching this. We will add cleanup during socket termination in =
v5.



Return-Path: <bpf+bounces-5584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C530275BFFE
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE332821B8
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B353D84;
	Fri, 21 Jul 2023 07:41:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC52102;
	Fri, 21 Jul 2023 07:41:32 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31D5273F;
	Fri, 21 Jul 2023 00:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689925290; x=1721461290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VmRIZA3Vs3ISAP4HSFw76VsZy1AP1o0HJMYK2xi76zo=;
  b=auOB931gbEaVofMJMrPA4i0slEaPBBewRN/nCTW4kmO0nH1dtIWuq68m
   GqguK3zg0+oBSvD1J8EK4Zw0gwNLZ1p93PAra0eTjtyQpbOweefn/WPhZ
   aPjhxX/cMCMSTGHrS9s8HaHGOyQm62/blvGFYZWJ5Z8jzT6hbevUs1whq
   75Y6Qs7L2FA4kM8c4JCCN5kME9yd5BdKWD8tZvfNAurywLJiLOJ8uzmPB
   10O5PQiB/go5LOhRfh+4NXrCfX0I2MATCuvESXFReukx66ppoyMAHCjv0
   iJVxCvqZVIP7lbOSddUPH1kkZxZyX2fKJUvmS9GARNLF/kA2MUWQ+2hlv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433189974"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433189974"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 00:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868143871"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 00:41:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 00:41:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 00:41:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 00:41:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 00:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4peq8Q8hWnShgHSIW/PF0fzNL+enw9jNDuDm+nbLRhMZ2zQ/p/gy4lYDxyyUN89SeaPCpFilsDqODObw55PiadZmJwz2QGhKtVv61J4PFdHvWuBgDpcBhj6nroxBvqDAwzdHT/o7cxTaHiRP3tybscnHjmrNOZ9c9OZ+45YkmP4SxL5IJhdQgozXlrD4o+arHMmUWhmkfe8npctcOM5i2T/P6h7DgE55NsfjQhoR/yRugx4KRq2QpWASzRx//EvlY/LeBIv0FZ7caHir4EFyS7lOQ8/aB44MJFFVRkouRQgYBfvJgybLaj3xXenfJLXkPSDsFjD3IYcINrYThdTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8nfUEvON45cXn/KUpT7w+UJwhpBV1PVPWEWI5Kb+UE=;
 b=W+tmyPVnMU8pCXQEuMG2sJypzIk5mFKuJkgibExKSmYyC5Uf4ABoyTL+w3IuyrXPZc96wysURIhsedXHN5idmpzqNh3Jb4jHxMbtfoDd4ZierMMGmdD/R3YMHYLEy1XfmwnolzkuiHj56MObYTLM1HgTJujNOFzGfqdf0KiQcqzBhhu03fl6ta81bcbgLuuwlXF2mmBTl/sU1hc0gCJsv8C2ac6hmQm/m+DucH5QTBcpJbwWC605YtX1uU/mYe7td3QlyX8Ark8g7CxOmmLH2YtQmw1Q3jyJ/0wZcwF24KJaeVZHJJ38FgD/kKUomQNMbfHnaAufMRktpVdRv5HdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 07:41:17 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 07:41:17 +0000
From: "Zaremba, Larysa" <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com"
	<yhs@fb.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, David Ahern
	<dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn
	<willemb@google.com>, "Brouer, Jesper" <brouer@redhat.com>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
	"Tahhan, Maryam" <mtahhan@redhat.com>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 16/21] selftests/bpf: Add flags and new hints
 to xdp_hw_metadata
Thread-Topic: [PATCH bpf-next v3 16/21] selftests/bpf: Add flags and new hints
 to xdp_hw_metadata
Thread-Index: Adm7pruRFF3WWxNw+E+C/o4XnP59Iw==
Date: Fri, 21 Jul 2023 07:41:16 +0000
Message-ID: <ZLo1n+T1A9o04DiM@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-17-larysa.zaremba@intel.com>
 <ZLmukOljt4ujHLH6@google.com>
In-Reply-To: <ZLmukOljt4ujHLH6@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|SJ2PR11MB7574:EE_
x-ms-office365-filtering-correlation-id: bb03d553-ac25-4af3-08aa-08db89bdde0b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0Fn4ZzwjaMeBIz8gLS96V6h9S8o0hn06zCieS7tDiQRjlAXNMgxxTYc9bu9woApw0KOyWSwuL48aiIpmbnWcUucx45K1xHmdSdGKDJpYg1f5WfCQLEAbRtZ7T2gsR6EatBCOPYQGfz21NWo04zjf7MfX7IiBecSfCPP4uejikcjSAyj0zzhv50NCE40ziN9XrRB6ubJafqRcqueQoDawE2G+zKtdEnhy2fmuMIoSYz37P0uOUCTvvnJ/8rh+KlbkrIjo5gkTOXQohiUJL8HN63GNe4NYi9kpAP6f99eFJH+ZVuvlfikSXi0JvRwf78ZY05gL2ns75KCQ7GdOlgHUP7QlXzK+2X+Sja0CPfR+uIrRV7KrsPDlMdpWKdKD3rzDo2ComsKd9I/yDiRtYrTAkPvVzEuRCyPvANfmzkaz+qrUVinbKMNKvBcnwwLFv1ZZ7mestHsfBRMyqZIkmQyGeg/7sfjTtOr4ziH4vWbTgDGPXaRYzxbhmTqFkBs0LHwVFvE/tEvmwMSzic/FjqB9nTlgTZw7hK1BYQZserW9I3oMWAyN4mU+a30TzTLwsP2gQ1H0jDYhUlc1PqeU7GYvvFPKJ65reHrXBhXshDMS8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(38100700002)(6506007)(186003)(26005)(8676002)(8936002)(7416002)(5660300002)(41300700001)(86362001)(2906002)(33716001)(478600001)(54906003)(316002)(4326008)(6916009)(66946007)(64756008)(66446008)(66476007)(66556008)(71200400001)(82960400001)(9686003)(6486002)(6512007)(83380400001)(122000001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QRZEDHxK6fGY+T7IqKXdh8IpcV66MtdOgK7yaFlTVrQXsqpjP/b0Cwq/FNvt?=
 =?us-ascii?Q?TelupEI6ESd4XdALB4DHDqt5sxlw+7gJZ2aTVULDXdWEs7ofhxxl1/QwsHKS?=
 =?us-ascii?Q?ZS9ZWTvXIz3PFMYrr6YLAHs1VpGuPYIPBVjesB6CczNNWix5zStQYdhzxqkn?=
 =?us-ascii?Q?2f8sqBEedDAr0OCYoIYigGWBqqGhJnvL6EP5xXsXr22XZE8Ok9Z8gVCqYBhO?=
 =?us-ascii?Q?GXhe3ZiSxRO7RTMk0SQ0yAo/trivloBJDLSc0gPy20WYDHZh6ruXG6F52uVv?=
 =?us-ascii?Q?mrUQmOttiTNUbPsTtkAoPGOi4dDFz5OlZ042EHKg7JX9SDpCbWwxp5jc3AN5?=
 =?us-ascii?Q?HcC2ROQGu+3y+yolfWEV6Pz8f45d/MTdhsJxbtPSTjlmLP3gObQAeGwjfMLK?=
 =?us-ascii?Q?ZyTq23I1NNF1MKDTp56/g9l8ph241eOvAzVXOzhljgGNZfjppLvacIPoMMaY?=
 =?us-ascii?Q?fHLoqN0bMgP3q4exh7RPwAe8XahLvJGza0hdSZraIKpAe4lXOormBX/EmAYx?=
 =?us-ascii?Q?dfbNS9x/vQ/MfuyJYpclK2jBwTQEnqZR/wMOqqXnvNMms6aUT2qXmQQP7vlW?=
 =?us-ascii?Q?Uj0Zy+3VjnIHZVL23Kpa3uEb4dlNV3LAmWn/r6s/QKjqWCDUQqwV+By8tS9e?=
 =?us-ascii?Q?E8lRMiJU8CWkyx6F+A6+2lHtpfqXoNst3yqzAElCCBkAVXt+XGazgDRnp0c/?=
 =?us-ascii?Q?cgsLOc/Xcg2eBoFJRky44/wMcG7uWE6lNycd+BAHdFxs3zov7H6UTdCPTr92?=
 =?us-ascii?Q?HCFZecGg9YacW5GwInYjPzNxFLl+IzX55rcKIBLXnM4tvNdLkLEOtybV9TAO?=
 =?us-ascii?Q?N9liAjAm+9sOdDaWTrkh+gBQ9JVjpH6eifQ7DQtUFnspJTLxfUa0iVKCRKtR?=
 =?us-ascii?Q?D1WJEcxy1Nr3zhy4sTmLMMyZVR/HXj9VKvekHE2iMeLnNl9RTFMnADt0y/8d?=
 =?us-ascii?Q?srfFabzvMT8HLIiakZJD59KpchSQE9XWMPrxdC6Th/OF0wrsykn0pGWxjh86?=
 =?us-ascii?Q?6Dn20TdyI7LEvsNSLpl3B6h8PefXpUCz0wCNfgZ/4oadTWGeSPDd7+P7YbF0?=
 =?us-ascii?Q?C91xijfoeHvnT1f/XCW/7AxtinPt5dp/S14McLbJ13s8bByl8hXIIfSJJT2O?=
 =?us-ascii?Q?ESJEpHaCh3bpW9y3w1tmei6dsgaXpwsYmF6n5K2kjVNGJhKQc+b3IOEjLi3L?=
 =?us-ascii?Q?BPSD8irRRDkeq4v7mpfokoe4P5JmGFCgX3GnkaRXafLG82DC5Ne5n1ut8fzo?=
 =?us-ascii?Q?MRxtyzax6a/UH0xD8Yed2kUg2m3UosMp2jOA9+piby7QTj+99Ra/aYiI1U1b?=
 =?us-ascii?Q?BUWRAyyu0bzHbPNv61IOIOV0I/4jx3BK4JuZniiHXPXqYH5nULZeggMJ6XG0?=
 =?us-ascii?Q?96bUPVdiMQ8htCPBcy1e1Ry649mxDyI+2iA41ZJGB5v6IiO6/j2TbhwJcP+S?=
 =?us-ascii?Q?msSN317SBTUjKV09Rs0p63Jl0TMpVSUq5XUes3DK9SMdpv3l+ueFdOlZ+HYq?=
 =?us-ascii?Q?KzK8Y8v9oYbaUt6NwOSzX27O3d+aI1y4pAuhANoqpNCT0/3NNpaHMPKbhMQc?=
 =?us-ascii?Q?lezkV+2uR3mPz/BEQ+5Tc0UA8oO5/rmaw4Tt9XSCPl2kbW07VX2pLTioUz+x?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34FD6364B3652B44B80CB6892F684029@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb03d553-ac25-4af3-08aa-08db89bdde0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 07:41:17.0142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmVF2WofZvjsb6Aepa9uOPSDektK9ueaOANPubAhhjBHAnImNoKOGmyHiUuxcek5xgLtQtHdrM52nPPdJt0EouTd7oRygt3uoteEzsZtB6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 03:00:48PM -0700, Stanislav Fomichev wrote:
> On 07/19, Larysa Zaremba wrote:
> > Add hints added in the previous patches (VLAN tag and checksum)
> > to the xdp_hw_metadata program.
> >=20
> > Also, to make metadata layout more straightforward, add flags field
> > to pass information about validity of every separate hint separately.
> >=20
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>=20
> Acked-by: Stanislav Fomichev <sdf@google.com>
>=20
> with a small nit below
>=20
> > ---
> >  .../selftests/bpf/progs/xdp_hw_metadata.c     | 37 +++++++--
> >  tools/testing/selftests/bpf/xdp_hw_metadata.c | 79 +++++++++++++++++--
> >  tools/testing/selftests/bpf/xdp_metadata.h    | 31 +++++++-
> >  3 files changed, 135 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tool=
s/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > index 63d7de6c6bbb..75a61317668d 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> > @@ -20,6 +20,12 @@ extern int bpf_xdp_metadata_rx_timestamp(const struc=
t xdp_md *ctx,
> >  					 __u64 *timestamp) __ksym;
> >  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *h=
ash,
> >  				    enum xdp_rss_hash_type *rss_type) __ksym;
> > +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> > +					__u16 *vlan_tci,
> > +					__be16 *vlan_proto) __ksym;
> > +extern int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
> > +				    enum xdp_csum_status *csum_status,
> > +				    union xdp_csum_info *csum_info) __ksym;
> > =20
> >  SEC("xdp")
> >  int rx(struct xdp_md *ctx)
> > @@ -84,15 +90,36 @@ int rx(struct xdp_md *ctx)
> >  		return XDP_PASS;
> >  	}
> > =20
> > +	meta->hint_valid =3D 0;
> > +
> >  	err =3D bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
> > -	if (!err)
> > +	if (err) {
> > +		meta->rx_timestamp_err =3D err;
> > +	} else {
> > +		meta->hint_valid |=3D XDP_META_FIELD_TS;
> >  		meta->xdp_timestamp =3D bpf_ktime_get_tai_ns();
> > +	}
>=20
> Maybe we can call bpf_ktime_get_tai_ns unconditionally? Then it will
> match the rest formatting-wise (no {}).
>=20
> meta->xdp_timestamp =3D bpf_ktime_get_tai_ns();
>=20
> err =3D bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
> if (err)
> 	meta->rx_timestamp_err =3D err;
> else
> 	meta->hint_valid |=3D XDP_META_FIELD_TS;
>=20
> WDYT?
>

Will do
=20
> > +
> > +	err =3D bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash,
> > +				       &meta->rx_hash_type);
> > +	if (err)
> > +		meta->rx_hash_err =3D err;
> >  	else
> > -		meta->rx_timestamp =3D 0; /* Used by AF_XDP as not avail signal */
> > +		meta->hint_valid |=3D XDP_META_FIELD_RSS;
> > =20
> > -	err =3D bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_=
type);
> > -	if (err < 0)
> > -		meta->rx_hash_err =3D err; /* Used by AF_XDP as no hash signal */
> > +	err =3D bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci,
> > +					   &meta->rx_vlan_proto);
> > +	if (err)
> > +		meta->rx_vlan_tag_err =3D err;
> > +	else
> > +		meta->hint_valid |=3D XDP_META_FIELD_VLAN_TAG;
> > +
> > +	err =3D bpf_xdp_metadata_rx_csum(ctx, &meta->rx_csum_status,
> > +				       (void *)&meta->rx_csum_info);
> > +	if (err)
> > +		meta->rx_csum_err =3D err;
> > +	else
> > +		meta->hint_valid |=3D XDP_META_FIELD_CSUM;
> > =20
> >  	__sync_add_and_fetch(&pkts_redir, 1);
> >  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/test=
ing/selftests/bpf/xdp_hw_metadata.c
> > index 613321eb84c1..a045de7dc910 100644
> > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > @@ -19,6 +19,9 @@
> >  #include "xsk.h"
> > =20
> >  #include <error.h>
> > +#include <linux/kernel.h>
> > +#include <linux/bits.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/errqueue.h>
> >  #include <linux/if_link.h>
> >  #include <linux/net_tstamp.h>
> > @@ -150,21 +153,70 @@ static __u64 gettime(clockid_t clock_id)
> >  	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
> >  }
> > =20
> > +#define VLAN_PRIO_MASK		GENMASK(15, 13) /* Priority Code Point */
> > +#define VLAN_DEI_MASK		GENMASK(12, 12) /* Drop Eligible Indicator */
> > +#define VLAN_VID_MASK		GENMASK(11, 0)	/* VLAN Identifier */
> > +static void print_vlan_tci(__u16 tag)
> > +{
> > +	__u16 vlan_id =3D FIELD_GET(VLAN_VID_MASK, tag);
> > +	__u8 pcp =3D FIELD_GET(VLAN_PRIO_MASK, tag);
> > +	bool dei =3D FIELD_GET(VLAN_DEI_MASK, tag);
> > +
> > +	printf("PCP=3D%u, DEI=3D%d, VID=3D0x%X\n", pcp, dei, vlan_id);
> > +}
> > +
> > +#define XDP_CHECKSUM_VALID_NUM_MASK	GENMASK(2, 0)
> > +#define XDP_CHECKSUM_PARTIAL		BIT(3)
> > +#define XDP_CHECKSUM_COMPLETE		BIT(4)
> > +
> > +struct partial_csum_info {
> > +	__u16 csum_start;
> > +	__u16 csum_offset;
> > +};
> > +
> > +static void print_csum_state(__u32 status, __u32 info)
> > +{
> > +	u8 csum_num =3D status & XDP_CHECKSUM_VALID_NUM_MASK;
> > +
> > +	printf("Checksum status: ");
> > +	if (status !=3D XDP_CHECKSUM_PARTIAL &&
> > +	    status & ~(XDP_CHECKSUM_COMPLETE | XDP_CHECKSUM_VALID_NUM_MASK))
> > +		printf("cannot be interpreted, status=3D0x%X\n", status);
> > +
> > +	if (status =3D=3D XDP_CHECKSUM_PARTIAL) {
> > +		struct partial_csum_info *partial_info =3D (void *)&info;
> > +
> > +		printf("partial, csum_start=3D%u, csum_offset=3D%u\n",
> > +		       partial_info->csum_start, partial_info->csum_offset);
> > +		return;
> > +	}
> > +
> > +	if (status & XDP_CHECKSUM_COMPLETE)
> > +		printf("complete, checksum=3D0x%X%s", info,
> > +		       csum_num ? ", " : "\n");
> > +
> > +	if (csum_num > 1)
> > +		printf("%u consecutive checksums are verified\n", csum_num);
> > +	else if (csum_num)
> > +		printf("outermost checksum is verified\n");
> > +}
> > +
> >  static void verify_xdp_metadata(void *data, clockid_t clock_id)
> >  {
> >  	struct xdp_meta *meta;
> > =20
> >  	meta =3D data - sizeof(*meta);
> > =20
> > -	if (meta->rx_hash_err < 0)
> > -		printf("No rx_hash err=3D%d\n", meta->rx_hash_err);
> > -	else
> > +	if (meta->hint_valid & XDP_META_FIELD_RSS)
> >  		printf("rx_hash: 0x%X with RSS type:0x%X\n",
> >  		       meta->rx_hash, meta->rx_hash_type);
> > +	else
> > +		printf("No rx_hash, err=3D%d\n", meta->rx_hash_err);
> > +
> > +	if (meta->hint_valid & XDP_META_FIELD_TS) {
> > +		printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
> > +		       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
> > =20
> > -	printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
> > -	       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
> > -	if (meta->rx_timestamp) {
> >  		__u64 usr_clock =3D gettime(clock_id);
> >  		__u64 xdp_clock =3D meta->xdp_timestamp;
> >  		__s64 delta_X =3D xdp_clock - meta->rx_timestamp;
> > @@ -179,8 +231,23 @@ static void verify_xdp_metadata(void *data, clocki=
d_t clock_id)
> >  		       usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
> >  		       (double)delta_X2U / NANOSEC_PER_SEC,
> >  		       (double)delta_X2U / 1000);
> > +	} else {
> > +		printf("No rx_timestamp, err=3D%d\n", meta->rx_timestamp_err);
> >  	}
> > =20
> > +	if (meta->hint_valid & XDP_META_FIELD_VLAN_TAG) {
> > +		printf("rx_vlan_proto: 0x%X\n", ntohs(meta->rx_vlan_proto));
> > +		printf("rx_vlan_tci: ");
> > +		print_vlan_tci(meta->rx_vlan_tci);
> > +	} else {
> > +		printf("No rx_vlan_tci or rx_vlan_proto, err=3D%d\n",
> > +		       meta->rx_vlan_tag_err);
> > +	}
> > +
> > +	if (meta->hint_valid & XDP_META_FIELD_CSUM)
> > +		print_csum_state(meta->rx_csum_status, meta->rx_csum_info);
> > +	else
> > +		printf("Checksum was not checked, err=3D%d\n", meta->rx_csum_err);
> >  }
> > =20
> >  static void verify_skb_metadata(int fd)
> > diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing=
/selftests/bpf/xdp_metadata.h
> > index 6664893c2c77..95e7b53d6bfb 100644
> > --- a/tools/testing/selftests/bpf/xdp_metadata.h
> > +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> > @@ -17,12 +17,41 @@
> >  #define ETH_P_8021AD 0x88A8
> >  #endif
> > =20
> > +#ifndef BIT
> > +#define BIT(nr)			(1 << (nr))
> > +#endif
> > +
> > +enum xdp_meta_field {
> > +	XDP_META_FIELD_TS	=3D BIT(0),
> > +	XDP_META_FIELD_RSS	=3D BIT(1),
> > +	XDP_META_FIELD_VLAN_TAG	=3D BIT(2),
> > +	XDP_META_FIELD_CSUM	=3D BIT(3),
> > +};
> > +
> >  struct xdp_meta {
> > -	__u64 rx_timestamp;
> > +	union {
> > +		__u64 rx_timestamp;
> > +		__s32 rx_timestamp_err;
> > +	};
> >  	__u64 xdp_timestamp;
> >  	__u32 rx_hash;
> >  	union {
> >  		__u32 rx_hash_type;
> >  		__s32 rx_hash_err;
> >  	};
> > +	union {
> > +		struct {
> > +			__u16 rx_vlan_tci;
> > +			__be16 rx_vlan_proto;
> > +		};
> > +		__s32 rx_vlan_tag_err;
> > +	};
> > +	union {
> > +		struct {
> > +			__u32 rx_csum_status;
> > +			__u32 rx_csum_info;
> > +		};
> > +		__s32 rx_csum_err;
> > +	};
> > +	enum xdp_meta_field hint_valid;
> >  };
> > --=20
> > 2.41.0
> >=20
>=20


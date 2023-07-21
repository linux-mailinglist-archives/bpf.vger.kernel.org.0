Return-Path: <bpf+bounces-5582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2990475BFEC
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB7E1C21627
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44743211F;
	Fri, 21 Jul 2023 07:38:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D420F2;
	Fri, 21 Jul 2023 07:38:43 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2F11D;
	Fri, 21 Jul 2023 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689925108; x=1721461108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xg/5/DWXHaupFWp0D9WILPltC8LGTHxM3Eujlax5Vl8=;
  b=E45BE2jxzWv98db4Vcx4TpTO5EREcim2IYMCgpX9171yJltZXUolPx1w
   +gekJBNnm5YfOBstVIdUgLeue9hbm+RhmUq927YyrFemZTMA7IK0n3OzQ
   XJRpKsXKYwOs2rD3W0//1oB0HX/KFnRU9JFHDBoMNBTo1x0cWum8+mAZe
   TZZWT4G7OGHA2sULf7+U6gX7WGLdcIw/YQZJccXqbU/zELkGrp5GHNodI
   Um5UuLK4XCTR8oV/nY84oEqaWJ2PZvUYMZMoKDl04Q1tW+nAkhOX5zj2I
   g0yeOxC5c9MXYYROtCa6n7efZM+0hcBwtvNQZDOMckRNLhGNFSBKMA/OK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356948213"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="356948213"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 00:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="754358057"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="754358057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 00:38:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 00:38:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 00:38:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 00:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiTvVyqkVpcOEa2st7ZwkQpAuOdJmv9cbImZHvfQiFU5z8BbmOfkyTMeeRPbQeOhTVjiCyBsOAmVziDHzxhuetoz4r0iL/z8hg8Q85R04ZXOVw5lgZvhTBUrB3nxABMLG0jX7JW39XETgYDspRdUixcQRrH5CIuTyR1iu+gxvkoc/8Lfe6GXFqZ6DPDhYMnG3mPdRT2oUFazdFwCYBAJIc7WNhn4UlXTV20SjLu4dJjd84rW3sT692TrmD9snM4OC1bgTHBYy+KZ7dXuWqGUPPGlrRDNIJXxTJEqdKguF8yVtoZ6b30lCFT8nHdnqUvheGN+VbkANzqaWm3mdYeVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE5mvFcYudNdDhIIhyFCCM3dOkUtF5vlFTlotxd+brw=;
 b=UpTiRZHc2pt7oeofKJxzebdRMqZUTBh1+j1+wZs22ZWbZ0FTaHhiwoLbK1yKrzVsF8UJ30kjq2jbbXRFkAxbPunPVWP/sTMgJSM0qlZoU0NYEZUntVnPFV0V98g9mKoHzdHTCDDg0x6Hrr8HhStc48lRo4/V5kt2PaegvC2yE1DXq7gawnFGvJ8slfiZsDADNUrXD1AwSZeptGo5eX9ZfbwiUn95cKV83N64rKy3h03fWBds7xR/0StJFPxOpZPhM2X5OWp2c0uNycK0mTAZP8SwzuwBc8tE1gG1zZAGUcgiJcUaJDKOqsAWkniqV8KPMpZnn2jdeuDp1lrtZnJ4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 07:38:22 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 07:38:22 +0000
From: "Zaremba, Larysa" <larysa.zaremba@intel.com>
To: Simon Horman <simon.horman@corigine.com>
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
Subject: Re: [PATCH bpf-next v3 10/21] ice: Implement VLAN tag hint
Thread-Topic: [PATCH bpf-next v3 10/21] ice: Implement VLAN tag hint
Thread-Index: Adm7plMYVU/XJIBxok23w5f4P+UJoQ==
Date: Fri, 21 Jul 2023 07:38:21 +0000
Message-ID: <ZLo08euaO5pyEyly@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-11-larysa.zaremba@intel.com>
 <ZLmB88LX7lb7J+zC@corigine.com>
In-Reply-To: <ZLmB88LX7lb7J+zC@corigine.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|SJ2PR11MB7574:EE_
x-ms-office365-filtering-correlation-id: 3c803ee9-5402-4d06-514d-08db89bd7598
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1m/qmvWSuehWAAmy+Y4vdeTYHhl6VdTXlp/Zj2tfkJXFsjJCq+hDXfHnL9LFwK33cFVOB0gE/ZEO7NM2PuQHCtklX7k6Eyh+5jz/cL+RS7y/w5R9f+u1rP4gFw08c1KCCl7MLMrf7REZq8w2Xm0M9BBNad9YklWYlbd9iSO2fSN51dO20zbwIpGpaylleEAPsutCGW1Ztbz7UnMHtOrzDcjttqFt+rIittsLpSW2yTZda00IVufKldH39jxkcP4Y9YkQu5i/SXaESv9LA4S3FnBJpUoixTzA71aRkhdY1hjXPKxVzuzMlnuszRsWHmeDAF/x2VALvMHAjhr/YGvqHQRxP5X4fTmlf60E/Awu+THBUX9qvx2Ft8M5IinjQCdzopQWuppEhoPWPp4YnmQasTR/AYJhC5WmA8T5JkUVeB6Kz134nRUehV/7yuWSeG3+071PqDWaiT66TbDtFJyvMYRSWpg2pnw/umVn3fLSMH6VpXdDSWMt8vauTiaVidrwn88T+SEcdNjXZNrE01Oya5r40X80HTpNrY/U3FrSHx0p8xe5PAMAL2LPrOT9/dy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(38100700002)(6506007)(186003)(26005)(8676002)(8936002)(7416002)(5660300002)(41300700001)(86362001)(2906002)(33716001)(478600001)(54906003)(316002)(4326008)(6916009)(66946007)(64756008)(66446008)(66476007)(66556008)(71200400001)(82960400001)(9686003)(6486002)(6512007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?suChkUhmxKkhcwwf1jA0W+38/Autb0VldAS9qgqJLcflKRUsYhusLF6Ibx/B?=
 =?us-ascii?Q?Oz/vZ9uk3k+lZN6J4IyvRb4f/+nvuCiUwjarYTSehOzYEXfWK/GnFQVxQfDR?=
 =?us-ascii?Q?JSIqvADWa1kMmNxjSHCgQA694opQLXnNB5f8wykP3+XxfCu7EJHspid/cVF3?=
 =?us-ascii?Q?jUDqtMeYBRtoHtF5meY9IqGUZIY9UNPwVhxtrSacuQKxBlIG1J2i2kmzFOYm?=
 =?us-ascii?Q?1oo/zyShY5AyShYZRi3IiuLK/vQNeGkIa+MUWMGxD5pHvg4EFqkAr+3jPTsO?=
 =?us-ascii?Q?TyOSmTqLR3uIH+aiDDuX9iFSAbiY0OaS1j5s1oUEJoi/8y329/OEbd1zGjDz?=
 =?us-ascii?Q?++hnLLwMzbunHRtg0tcnME/sAQ4m4puEtezJSaTv+PHJa6jHMwc4ouwyLkSY?=
 =?us-ascii?Q?tvq0NfADYRi4ZDckQKb9MKwtyGBJ5FwEWWDtfLHwnhiMYd4GLn4RxG7/S69r?=
 =?us-ascii?Q?/qE8XVlZk7A6cMHs7pwLfwgD0Iy9aE6sWUHAWITgDgNeFchzhjz9mGYUzTGx?=
 =?us-ascii?Q?o1yaiY8xqCCc2WCI4GYuCDbiphCe/CbhLqhV9FCLID54ZFreT5tYj4hdkOHf?=
 =?us-ascii?Q?ZKO+4AKsRgbmE7AyzRpHChvfIN2HxgPp/W1d321crYJO5U0MixgerjhmBuQR?=
 =?us-ascii?Q?SmHxrf0IEYf1bloghDWvIEmYQe7GFVBGUhSiarP97NIVedGP+DCanPAK8IDu?=
 =?us-ascii?Q?9BMoJ8maWx/Pl5oKEfVxSWkwlcMjef9Mko3J/6wND6jqdnAJh6T+7DtJRnOd?=
 =?us-ascii?Q?3Kz71LUq7gU/FukX1BUYh8gCaDBFQtPxsZA//nr+aKyf5WPkDHuxg+UE9bYT?=
 =?us-ascii?Q?aDoIsHAOknE3RpwfaEIZAVQJKvqqjvowb804uMDvuHYTE67k512hAnCPCOom?=
 =?us-ascii?Q?4ZPV0kuLpKDbtDpNnCW2nP1d+8xguqFHOx+3Q3FHOQAm/+N9H4Izhkh9IzKw?=
 =?us-ascii?Q?vV11U9v3TZpaSSahLBYx2bxADAgptUkpbnfeqOR1vB3rya3TlJnmSwllk1Ot?=
 =?us-ascii?Q?xnrkB/RcYJ04pVucg/0MSAYGtMOTTXfckqwO+88eihCNFGDNEOcEqjHAl+ND?=
 =?us-ascii?Q?NggE+KlSQVV0otFV/73/dXa2ofyBZBiDS/HZx9HtJ2+u0xz9qAbK3Ab3q4H/?=
 =?us-ascii?Q?6U+Ea8naECG0m6BOgXba8Abcj/4gFtspRG0nYxBSp8abO2090y4eAoW+0JaQ?=
 =?us-ascii?Q?S9Of6pVfY6/t92zGphz4C8QpAJIClj9hjo1zpzmQYh7U1TzsWcCrXm0SGP/y?=
 =?us-ascii?Q?jtiZ8xIc08zCqZfFe4y+N3XWFmF2z+QBZbyquUvr0r36uguKiJ/vTL2+IpOG?=
 =?us-ascii?Q?CT6CXNPvutFCeDL5wGP1oa/seMhXvPcF39kAeeYVvfRBwH3FyYdOKuSaRmPT?=
 =?us-ascii?Q?ln0ioKY6eIvMHZkkMmpc9bMUg0IGD/9AZ8ggGFod1gpsIcSmWbqCP0JeTWXl?=
 =?us-ascii?Q?YhKl4IdNP8Xmr42LDmexIDmFrgqYu2445Kx7HiMwGKUaObU6quaaNG9z79Wg?=
 =?us-ascii?Q?AL+1j2op8GMm5GRmnAYftm5jFSXG1UaoLik5wxABBQLvpwnSAzJGvBhyLsCG?=
 =?us-ascii?Q?g3iDcJXlIbPdUH1+BdeA0Zip/F+mWi16pH+rIRbRAHAodRquTrWHiLhvqTlz?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A6445254970DC4189FB21E2B677F3E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c803ee9-5402-4d06-514d-08db89bd7598
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 07:38:21.7566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZRIJzlKJw9uHiHDZojpCO+QH64fqjO6aCkp5166WWryMiD2D2mZVr6gORJxWZF7g1YLaQGCjPSFlItGfOQIT4lL0+G4p+NDgSS3krXPiGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 07:50:27PM +0100, Simon Horman wrote:
> On Wed, Jul 19, 2023 at 08:37:23PM +0200, Larysa Zaremba wrote:
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/ne=
t/ethernet/intel/ice/ice_txrx_lib.c
> > index b11cfaedb81c..4ad6db83674e 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -639,7 +639,33 @@ static int ice_xdp_rx_hash(const struct xdp_md *ct=
x, u32 *hash,
> >  	return 0;
> >  }
> > =20
> > +/**
> > + * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
> > + * @ctx: XDP buff pointer
> > + * @vlan_tci: destination address for VLAN tag
> > + * @vlan_proto: destination address for VLAN protocol
> > + *
> > + * Copy VLAN tag (if was stripped) and corresponding protocol
> > + * to the destination address.
> > + */
> > +static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci=
,
> > +			       __be16 *vlan_proto)
> > +{
> > +	const struct ice_xdp_buff *xdp_ext =3D (void *)ctx;
> > +
> > +	*vlan_proto =3D xdp_ext->pkt_ctx.vlan_proto;
> > +	if (!*vlan_proto)
> > +		return -ENODATA;
> > +
> > +	*vlan_tci =3D ice_get_vlan_tci(xdp_ext->pkt_ctx.eop_desc);
> > +	if (!*vlan_tag)
>=20
> Hi Larysa,
>=20
> Should this be vlan_tci rather than vlan_tag?
>=20

Yes! I have no idea, how this has happened >_<

> > +		return -ENODATA;
> > +
> > +	return 0;
> > +}
> > +
>=20
> ...


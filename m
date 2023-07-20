Return-Path: <bpf+bounces-5435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB4875AB47
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 11:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966721C211A5
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 09:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C9174E6;
	Thu, 20 Jul 2023 09:47:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE09199FD;
	Thu, 20 Jul 2023 09:47:32 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C948635BF;
	Thu, 20 Jul 2023 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689846448; x=1721382448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y/N0DbLi0mcbls9a+pxxB48RtykQhDTsIVMi7DbI2d8=;
  b=TAONctkoodTtn1aD95+Yn222PQhh5xKfvlfnfTdL88powno7h3hCO4H/
   2ZrLyjRdpXPwGtyVgQ+Rb3LNxmaZBlXy41uKSK0i6u1/+EzAe2eZVP3Q2
   BpDX2QrqSPaU8UHtFLyXo86+ztrQYfiq8k1zYXIvHqEXOa/T9+Z7SbdEz
   bSrBDgiQS93+q7Poiu5YvyU2Kf+UQckGhWfOPqnie7g2VnxOJieje9uO0
   MFqnViPv/HWJh7elSypGEPCcmhRU20ooOw937jRdQa5ZGpAv2aBv4k6oo
   PbZVV59jZWKoXH0fyeva7L6nh68ixO7GoAff0ZfUAn/VEwhrsUMmqTZy1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397561303"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="397561303"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 02:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="898222889"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="898222889"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 20 Jul 2023 02:47:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 02:47:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 02:47:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 02:47:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 02:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsByP/Jrem9vDndrly/RJ/4TZwirH/PulVTwg0weH2ONxpoof0oVThpItyExJ/iD5nBdBp3ODRieQGFFbsmQfoZ7G0NLA7ptSytqO8irMu8eHGU3zfp0nlCN0zlzvinKSYc+9fvQVERH+pfIRDGMVUxwbBl3cNtI7g57rmt5a6GdM4lr291bwv0J0Ey5Ql3kMRCsLAAMcKnwZoXUuiG7DxArDbSQRbVSQqeJV9QTX5iPQoeivrfxxILm3wxmcvyoTiJhGerR7gWSOuhvZ3D1ypVDgfCuNW3tUvADuBmgeMC0nxaOaeUbbVYpx6/fbrdQNDLHqmTzPGtCZEM+GI7o4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP+SwIg90OeBMTuV+XnaIgwZxWnaLV4xD2/aN+UfNCo=;
 b=VBfjCr4OuvdhrkKoBVnvugHHFLZZCcP94cmrWf9aRSnNLPxbAN1RQrC/xKO75uZx0CzGqzZH7/DPMfFnk0xEabL02WvNZRRVuFYD0QjUaEQBPNj7oQLauL3cWtsWqOO3gBWMS5o5Q7daJQsUOmWe9q2NEDjmLBKwxcZn2aQ9NKK3nmiHKJFQEZPRwkaUSop2gD32l8Xw/b0Y3YXARBM+JQmOVoNTiWaHGC3/D8J5EPg970AG2b0C++GvBFVBne8xVlJihKQbWx1V8CP/BeeNNzfeIFR1tMGBG5rky70VD1Ifcq0tXWcpXGrFKfIg5aoDbNVH+5w+EZ7kXWy2T8bb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 09:47:16 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 09:47:16 +0000
From: "Zaremba, Larysa" <larysa.zaremba@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>
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
Subject: Re: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
Thread-Topic: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
Thread-Index: Adm67yrQwS2hXoqOmk6c7XBao3Kphw==
Date: Thu, 20 Jul 2023 09:47:16 +0000
Message-ID: <ZLkBrfex1ENbVDwF@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-14-larysa.zaremba@intel.com>
 <20230719185930.6adapqctxfdsfmye@macbook-pro-8.dhcp.thefacebook.com>
 <64b85ad52d012_2849c1294df@willemb.c.googlers.com.notmuch>
In-Reply-To: <64b85ad52d012_2849c1294df@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: BE1P281CA0295.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::18) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|PH0PR11MB7709:EE_
x-ms-office365-filtering-correlation-id: cf987d14-7efe-4cb2-6ed5-08db89064d4b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePuN6EsOtGLhZazQbL579g+rWeOUSNBKYvYV2GRuiZ/5gJGqV7c+sdpRcnrvRLY6qQadMt2bQKGbC7mGGpr9YEGi3LrnEVLX6PcWqvf3ORPNYWBZLWXvsopjjqySYVVqh3Y+VTnL8Hkxf/QmUvJVI8ZQDmsBbOleGeSrMCLtTMpFa11JXsaBKtdK/c2R4/GUhmUlc4hVstnS6+TqhLbQXG4T9Lj6FgHjpQFE4qYQulL5brNQ8Fi55Q4sCiq3siZkqRT+9Ls4JRtctHEPl18jZUxCXDm6K8RZIoJb2O5sgIz27+Y+x83SEog7DvMpNlPMaYWdCTBIlPekYPxO1mD40tOIAIgf26XU40W43AHawCB9PrOxBi2cHij8s/gGZV4CBN/0bpLw1CfTV+A2at7Ha6Uj/jlVr/zAiMUDKn5g0l8TCnsTkWxM7XMCDCHfyjtqXQvNnRCNCSrtswTqHxYcBWpZp6qrzF4x0o9foJbOI/fM6KvbSNyV+1Z9cQ6NLX31+HQ91J/ly8E5e7HPmdxw4MBq2xyOcyk94Av+VwRWNYKn0SxUCRMEDUa1T0Ek6eBY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(316002)(41300700001)(66446008)(66476007)(4326008)(66946007)(64756008)(5660300002)(8936002)(8676002)(33716001)(66556008)(83380400001)(38100700002)(86362001)(122000001)(82960400001)(26005)(9686003)(6506007)(6486002)(186003)(6512007)(110136005)(54906003)(478600001)(71200400001)(7416002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xqqXGO98sPmJVLyihUONsYMjDVaNxLCM0Kg8M9MnbrKx2c6F5zeRUTvpLkUu?=
 =?us-ascii?Q?S4ROURwvYVbi4TJll7BMbS2GGmEsVLzk0+DWRZsNSBishagf1yZtQxTxsbZW?=
 =?us-ascii?Q?0gqGPlzjovn5ENSD7JZGw2YilLN3ZI2ngihdWpP/I8v/76xevGKZCVSMKZhB?=
 =?us-ascii?Q?OUdRvm6M0mDZ21ZgLrnzZ9Qd3xU/tEMaNbxUQzXa7raBxBY+4whQe2+f8sUo?=
 =?us-ascii?Q?9x+4Scte11P0udvxHZ0ekutgK/ebwMZF+xwi+BJAotVmVJK3YcAGkPPW/hxd?=
 =?us-ascii?Q?3BKUexEKJx66jcPw8qa6aFd35slgXEDM08S3/V+mjpc+8JmgDy1vw1qr1XQh?=
 =?us-ascii?Q?I+SJ8t4qPYaxcLVidNMZ85VEkW6b+fFANyDnjYQ7E1FzrPv7vs4XWd8P3+gU?=
 =?us-ascii?Q?CIA/WSGyQu/W7StUYmtBrRa6ha7BJAa57FbzdQC6HL2u8A1uHJC7sRgmojO4?=
 =?us-ascii?Q?ApOGXAC/32dzqkD179D0MWyoA4ernX8TJAQzbF8TmEbfruHG+jZC1Tvw9OtJ?=
 =?us-ascii?Q?KDn2/FAB85yVMGGgaaNHXX9pIHuQU32Lri4t28BPOkKOVQlWbotv49C9r6yL?=
 =?us-ascii?Q?2ltvD7H5Mg79ha8W4bWYax0x9w+ENgCk8jSilruTyOz9Zm6rx11NVxdsWo0r?=
 =?us-ascii?Q?/jhpyfuujSE9VmTm2CnrZsVfMTKCZo/0/3wsvzjjGs3Oyoy9a5b+XQxQWkts?=
 =?us-ascii?Q?/mZxiPw4UTPF8+3t+ZfLV9xW+NUTjmGIVTLp4nwYroWh4XvytlQvJx+J3dst?=
 =?us-ascii?Q?R3cmGlLVQhUjLFBbRyNkL2R6jEel6zn1PV7ngRZSNX9wap3VAQk75s3OCAQ5?=
 =?us-ascii?Q?RPM0vRUTEA3vr9EwGn+tjiIiCMgxWsj7h+PIKKTO8UbftsfqaBjt7HkgZAZx?=
 =?us-ascii?Q?lrTzY2LSxUaLo1xk6EyiBrgWpkHcerR6PQzGQRUFW2LMafEMYVXBVmzNH5bn?=
 =?us-ascii?Q?UdzRkLQvlKoKoiIgEHmcnAl1K9OyVMtq5hGePohTw2KqyEdgimBSqAAFWsar?=
 =?us-ascii?Q?lHDAiSWB7qOiJ0roUiqHTKRxUKfDOOM3G8XNpczMfsLjKzkC8sIf671FcxZi?=
 =?us-ascii?Q?lBksupDfk6IpR+EfY9MOXZ/B//XFWVpXgV4mOTvgJeIXTQElkLWXxCxYCYih?=
 =?us-ascii?Q?3cCJ6/tsb1jL+5NC+kxMJr9VwRuNbpSwFfexoARQtftnDxcQ1RuWm9h1yE+W?=
 =?us-ascii?Q?AmUmYZ0CJ812jexcLCYkXJ+C3gaNuGvhWbxZd0RK5M80rUBfWNOLCOzrqoTY?=
 =?us-ascii?Q?FjY/b/EHaKk3EeJ1t0v+FMu+6FHTrj98igdclFuinlsCA6rhZXhRmSdC8jHc?=
 =?us-ascii?Q?lWDNcgxxX89PpuMdK5qwXPbkok9PusrcNqfnebqN07FlkR0D/hlZ1VGitLhV?=
 =?us-ascii?Q?NNE80jjGLirN8adcrIrKJuVWELIA8MDLTgKde04JbUvuLPckNkMR+XIAtoRh?=
 =?us-ascii?Q?rQ8FRlvD2nQVusHX2+BNlkckTd37pCv25j0z+6H8mVJcP+BU/cLnUU3RIzmN?=
 =?us-ascii?Q?S5M4VhEwRj6b1B8g/ZYFR5ZQ4Cy7ND+PJA1FNqh488oTSFxtPQdsQ7KkXrrd?=
 =?us-ascii?Q?lveeHgndznyMVgfn2iDtDXcTb/15vek/pXBZsCuILjhtRSsmbX+Wdx+maemg?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E2F5B1CC0854E42BC9E5EF8C5A7E19F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf987d14-7efe-4cb2-6ed5-08db89064d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 09:47:16.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07t5wW5Vmbv9fB8IhnhSv/Af5KAVAM5PpA1ddUr9iRdwrWOTTBHwhcz1l72pVyn5ePkao9qhVc6Pzsa9JTkUANrXcbkIPAL/YxVBW6CU5Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 05:51:17PM -0400, Willem de Bruijn wrote:
> Alexei Starovoitov wrote:
> > On Wed, Jul 19, 2023 at 08:37:26PM +0200, Larysa Zaremba wrote:
> > > Implement .xmo_rx_csum callback to allow XDP code to determine,
> > > whether HW has validated any checksums.
> > >=20
> > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 29 +++++++++++++++++=
++
> > >  1 file changed, 29 insertions(+)
> > >=20
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/=
net/ethernet/intel/ice/ice_txrx_lib.c
> > > index 54685d0747aa..6647a7e55ac8 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > > @@ -660,8 +660,37 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_=
md *ctx, u16 *vlan_tci,
> > >  	return 0;
> > >  }
> > > =20
> > > +/**
> > > + * ice_xdp_rx_csum_lvl - Get level, at which HW has checked the chec=
ksum
> > > + * @ctx: XDP buff pointer
> > > + * @csum_status: destination address
> > > + * @csum_info: destination address
> > > + *
> > > + * Copy HW checksum level (if was checked) to the destination addres=
s.
> > > + */
> > > +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> > > +			   enum xdp_csum_status *csum_status,
> > > +			   union xdp_csum_info *csum_info)
> > > +{
> > > +	const struct ice_xdp_buff *xdp_ext =3D (void *)ctx;
> > > +	const union ice_32b_rx_flex_desc *eop_desc;
> > > +	enum ice_rx_csum_status status;
> > > +	u16 ptype;
> > > +
> > > +	eop_desc =3D xdp_ext->pkt_ctx.eop_desc;
> > > +	ptype =3D ice_get_ptype(eop_desc);
> > > +
> > > +	status =3D ice_get_rx_csum_status(eop_desc, ptype);
> > > +	if (status & ICE_RX_CSUM_NONE)
> > > +		return -ENODATA;
> > > +
> > > +	*csum_status =3D ice_rx_csum_lvl(status) + 1;
> > > +	return 0;
> > > +}
> >=20
> > and xdp_csum_info from previous patch left uninitialized?
> > What was the point adding it then?
>=20
> I suppose this driver only returns CHECKSUM_NONE or
> CHECKSUM_UNNECESSARY? Also based on a grep of the driver dir.
>=20

Yes, correct, current ice HW cannot produce complete checksum,
so only CHECKSUM_UNNECESSARY for known protocols, CHECKSUM_NONE otherwise,
nothing to initialize csum_info with in either case.

xdp_csum_info is initialized in veth implementation though, but only=20
csum_start/offset, so complete XDP checksum has no users in this patchset.
Is this a problem?

In previous version I had CHECKSUM_UNNECESSARY-only kfunc, but I think ever=
yone=20
has agreed, csum hint kfunc should give more comprehensive output.

> In general the layout makes sense to me, and +1 on supporting
> other drivers that do return CHECKSUM_COMPLETE or CHECKSUM_PARTIAL
> rigth from the start.
>=20


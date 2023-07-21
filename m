Return-Path: <bpf+bounces-5589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E532375C0A8
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 10:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A11C21496
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 08:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD714F63;
	Fri, 21 Jul 2023 08:01:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4C8463;
	Fri, 21 Jul 2023 08:01:32 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDC130E6;
	Fri, 21 Jul 2023 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689926483; x=1721462483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+lltSolutNQcfkGM13lNrS1lSivb3138jn4/Xx9K/tM=;
  b=LjLrPtblggAjzrYA3HBrGbHLreOe/+Fv1DnKaYIZ3DKme2wF+WvxiL2I
   LGamOUqnmNce5URNnPt2oZLyTASh/uOINeG1jWAnyt+yEoWWpz02YzbA0
   DiRW20RKJwe7ujaz7qRQk7oa3no/GYfH6vkG+2CVlVD1/CB26f0sOq9eM
   hNZHBjy2peCWmMK8EQtmpGey1usz47ez8j/yOLbiKah9yB9q/vLuWhMys
   lIUKr4usgLzzGCwUQKHBRcKc2OcRf0PpHWpN8qE9rsXNTdP3vmlA+WgKA
   ytMgTJZDIn+WEBNCcdWqjkmIutuGVesaxcdbBO3xIlqqhdhOoH4FQDVA6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351847025"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="351847025"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 01:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="1055484307"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="1055484307"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 01:01:22 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 01:01:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 01:01:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 01:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9MRalvczZxFw6z0jd1hq/k9yikXTjbFnSmfWj9pK/kletCnkwI7yrnJBZUpiySp4Y9ofG5VcHZuKL1Gp/+dEhMBEpewhDeMEjRlqX18t3Dhax+43DRGQq+hAxHW/h5O/f2U9d7LBFXcjOueE3AZyiHNVLVczAOvkQ7jBJahYnflSNW+xd6R+ygxj+N83gs0HT+rDpmS13IDsYOP8c8+LqmHyOSOs7McqiN73SeRe345qtHsvUOF+LaxY71TkOIAFYXAvClkCqflIvLkFiCaGcPzcxa5/vWQtlOWsxdGho2hVcqeek3BlF7vzXSS11DCYcqltsGkXFWHHf5w42Qy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfnQxAg9To4AFFyjcqEQY/d4IqZbdNBnGQd08QBp2eY=;
 b=RxM8MFcFct5n653p1jGONPWL4+Ol0B9guUIMiOehAFIyzUESwaehvWTEATgzRiTKztl0wlnns1Hayc61GRrozS4zMgY3uwTvltTyIUejl4x/VtnBWLidDqj+Fw1HSygR3yaRMiMJOaNqmfx4rV8tVRwdiqvXAwbv1rKtYPh6fFudfjeEyu/oXfJ4PlyweyIhwFh2JW/H/Gjdzo3wCVjbCTcARCf3wEncvJ12U6hboPnOsx3RxHq48Js1ukCchf24LU6YfAb+GIJw93sd3zJShu6uJFFoLnrupMiGeKhIlufA3X1HzCnGtLiEMJXtcdDEJu654s5Lky+k6THUsZclSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB7943.namprd11.prod.outlook.com (2603:10b6:208:3fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 08:01:19 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 08:01:18 +0000
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
Thread-Index: Adm7qYeo2c6BdmEjGkmGw1MvgjWlTg==
Date: Fri, 21 Jul 2023 08:01:18 +0000
Message-ID: <ZLo6Stj4HofGOcGO@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-13-larysa.zaremba@intel.com>
 <64b858ac9edd3_2849c129476@willemb.c.googlers.com.notmuch>
 <ZLkD/XWi+eQU9AQC@lincoln> <ZLkHK6Zbqwkxc8WM@lincoln>
 <64b93cc46ad9b_2ad92129445@willemb.c.googlers.com.notmuch>
 <ZLlZ2E4rdKdBTqsf@lincoln>
 <64b9b4ddae4e7_2c3d502944a@willemb.c.googlers.com.notmuch>
In-Reply-To: <64b9b4ddae4e7_2c3d502944a@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|IA1PR11MB7943:EE_
x-ms-office365-filtering-correlation-id: 70729ec1-bee5-4d87-410a-08db89c0aa2e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HkKA56DRAbnNuXdh2kXm1G50cHN0piz4ZILgAetdfKQQH7/vX7MSDtyxYmTt1zKxxzZr6qjYWGqavhbDnmwtU1R1CyH7BbaT1bzq274FqkAcbU5lmRbwoZaxq/BqIi4tTMTjxf7JCB1j6chnCWh/8/J3CXrZeCN1sq+HEytafjeRboWcMwGDRq+mBjpg65uVUBWRzWKmiYx653TRXFApq2hJY1oiHUQjNbeaPkMhk+q+Zwuw9WF3dD6UZGzPclj+4f9BfhxNGfN0tbAvHwm2LzBpk0hiL7o6BmG31AdPBLmZXuhQJVO8yCrRSfqg8qgpUeWixfbKA/18jLpAd4b2OXuNv+3/VrbzYu4uXjjLRZ27ME0kzzWpys5UOInhERgXKo5ZkcbPnx/0mfRQ58e5Sbqm18WmSMGy3ZnOXaskXJnD1bFrusaJIrsz5E0fRM4l7NQ3XiseW+fWzH4hFyfQ7Ct3TUv6JbW+qDow196HF1TXFAs4mw0RbssqDEO8U9el7uQe606U/eJIy//i1ZFft+1eyaKbx34WojS/xS9S7ulJ4y67+7GOTGAz6pQ8ZZ6I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(86362001)(82960400001)(122000001)(38100700002)(33716001)(2906002)(478600001)(54906003)(83380400001)(186003)(26005)(6506007)(71200400001)(41300700001)(6486002)(5660300002)(8676002)(8936002)(9686003)(6512007)(66476007)(66556008)(7416002)(66446008)(316002)(6916009)(66946007)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2mtDHH0jFg/uRRy6rI+Jq0tG/mWHA2pPeT1sqepjmBR2ncnxGOhBiCmMPLk?=
 =?us-ascii?Q?f3rWJFrevkv8Gjoi4By/CPXFK1S388ozBDLm+o4anCBBf8tYjeNMqbb2R/yq?=
 =?us-ascii?Q?vucjOGCyFO+qG1HE9mf/4MnXAqC2/TwsY9/sUtHYN7ITFDaQCQY5czSR28uA?=
 =?us-ascii?Q?w2fqG+t7SF4GmDK/3uDV0OPYt1K7tW++s2GqDnh1v1ZsJbLOSd6Nwa6fyjPs?=
 =?us-ascii?Q?7Gv/ijx3u8bu8hopCwIQ9jhB3REpz3O+Ggtt15PMfH+oweX2AqpiwWS2mneh?=
 =?us-ascii?Q?9O/X/vG6lr+LCOgIJW9bGvmo67Fm5zVKvL2ZAfXYyxgbI9H5lRzVCzKpFrLc?=
 =?us-ascii?Q?ena8wlLQdKTeQcYdR2i79vz4gy41bDGH2Hq5qInZUt4apNj2WNG9AOgp7QaP?=
 =?us-ascii?Q?tSjjQI0W2BJc5OY++LCmXZ2QTUF0zl+jd+KzE+bTmvPNn3eslIjii3VQIntJ?=
 =?us-ascii?Q?t+5unKGVsM2JObWcQVCR27GDX6kMNpoWScxpjuwy8wbzOPfH1Wsd0zQbbPqO?=
 =?us-ascii?Q?16dTxB3wvqfnl1lSrji1It26YXg+tLC0o/Lpxx+fT497I8yJn4KCl7mm5nPP?=
 =?us-ascii?Q?dWHy5vvrYZG23k8I0heaNDygOA1Gm9kVkRBR43aRaf9Lt0/xbpJ3TyS+VHvu?=
 =?us-ascii?Q?D4U7lc4x4yHhJakfk5dsrMcMgmaNRt8J5sfNLZ4CHgc+PxkvfqXWdSLtRKHx?=
 =?us-ascii?Q?yvzYCQ0+XGVz0oZslrt3dHqDdST4Vjy2Vf4kUWauS9vaAgm5/n42NHsNHw0h?=
 =?us-ascii?Q?KCq4fVIQfMvrov+TXCX6XphXBonfWyBBtCXlirC9cWHox9MnyAvkyGsYzbbV?=
 =?us-ascii?Q?PugeZCg3Q0ewKNOvgiUAYc35r4qOoVD54c9Xcrhu5LrsXiI1gGNAcSmFqE8I?=
 =?us-ascii?Q?CUY5EFx9R+mqoRI5p3GlKEi+FoyYo19zQ2X4d7GSmMHO7GDRpLHMf0P+QMEM?=
 =?us-ascii?Q?Jn74Nb99YiHw18I3d0DX/dhC4HfY2oZRURB50l1c2HWsU9gv5cnDPSOa7gvG?=
 =?us-ascii?Q?UQhTRhQ1KGBnvZvbMYOi+tqShKt41DrNHp7SVZ677AujeZfBZUqQvTq6YrGt?=
 =?us-ascii?Q?m+NU/tmHTUYpGUfUAVZeauwFvr6o1bXS0OfZbLGIc/snmqtqgG2H2VKo+sY3?=
 =?us-ascii?Q?gS4npXvb2+aeZ4quHVhTh9ZXIOfFFjl4A5/OK/aTwCPOF+f9tr4gpKwDHQGN?=
 =?us-ascii?Q?cF7F8/o4f3SSPK98nnYXVCddAl4y7N0OlzoPzQKbMicfSY/kEFx4MGQaZ6S2?=
 =?us-ascii?Q?8Mh7AIW/cDylX6K57NoGglr/lbCMrYtfiUa6bxI6vd2z6EVTipYRobmvOrU3?=
 =?us-ascii?Q?/ZKLSviornyNCA4RdES08rrN6j2bawiIlFuOa8C1QgxoG9sPjIS/UGJVlaLQ?=
 =?us-ascii?Q?9l+NvvZDSWCTusLcQdkLJoXaKn1+1QzjohSD0I5dvIc5Av3xg7w3dF8APxPP?=
 =?us-ascii?Q?VS1GlXVRhARDDVHdfSscSxo5VEBjLX0bt/r/BBp9y/oq7GCvYFOM7pE6/YT/?=
 =?us-ascii?Q?TfvNf0BuvL5/AHXS72QUxn1B+f6ASy19DMh5ObjxDUzGE+TrXG+FkG5U3fe5?=
 =?us-ascii?Q?UQSRvvYCD0pZzUnK+sy0ijcZof+2TOx82+GZzmB1eaFpJtaRGJKi5po3nI5V?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C5503771A2979499580C463DE27DBCF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70729ec1-bee5-4d87-410a-08db89c0aa2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 08:01:18.4701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Nwt5ETtl3iW4DVC2+RICi/qujTVXhLKjogXDj5DNWqyJ+nd/sAVnFyr0OfRTKVJElqeNLJIhLLaifQuT3kXWgg4vxFOACmK1K+1dvSak8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 06:27:41PM -0400, Willem de Bruijn wrote:
> Zaremba, Larysa wrote:
> > On Thu, Jul 20, 2023 at 09:55:16AM -0400, Willem de Bruijn wrote:
> > > Zaremba, Larysa wrote:
> > > > On Thu, Jul 20, 2023 at 09:57:05AM +0000, Zaremba, Larysa wrote:
> > > > > On Wed, Jul 19, 2023 at 05:42:04PM -0400, Willem de Bruijn wrote:
> > > > > > Larysa Zaremba wrote:
> > > > > > > Implement functionality that enables drivers to expose to XDP=
 code checksum
> > > > > > > information that consists of:
> > > > > > >=20
> > > > > > > - Checksum status - bitfield that consists of
> > > > > > >   - number of consecutive validated checksums. This is almost=
 the same as
> > > > > > >     csum_level in skb, but starts with 1. Enum names for thos=
e bits still
> > > > > > >     use checksum level concept, so it is less confusing for d=
river
> > > > > > >     developers.
> > > > > > >   - Is checksum partial? This bit cannot coexist with any oth=
er
> > > > > > >   - Is there a complete checksum available?
> > > > > > > - Additional checksum data, a union of:
> > > > > > >   - checksum start and offset, if checksum is partial
> > > > > > >   - complete checksum, if available
> > > > > > >=20
> > > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > > ---
> > > > > > >  Documentation/networking/xdp-rx-metadata.rst |  3 ++
> > > > > > >  include/linux/netdevice.h                    |  3 ++
> > > > > > >  include/net/xdp.h                            | 46 ++++++++++=
++++++++++
> > > > > > >  kernel/bpf/offload.c                         |  2 +
> > > > > > >  net/core/xdp.c                               | 23 ++++++++++
> > > > > > >  5 files changed, 77 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/D=
ocumentation/networking/xdp-rx-metadata.rst
> > > > > > > index ea6dd79a21d3..7f056a44f682 100644
> > > > > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > > > > > >  .. kernel-doc:: net/core/xdp.c
> > > > > > >     :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > > > > =20
> > > > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > > > +   :identifiers: bpf_xdp_metadata_rx_csum
> > > > > > > +
> > > > > > >  An XDP program can use these kfuncs to read the metadata int=
o stack
> > > > > > >  variables for its own consumption. Or, to pass the metadata =
on to other
> > > > > > >  consumers, an XDP program can store it into the metadata are=
a carried
> > > > > > > diff --git a/include/linux/netdevice.h b/include/linux/netdev=
ice.h
> > > > > > > index 1749f4f75c64..4f6da36ac123 100644
> > > > > > > --- a/include/linux/netdevice.h
> > > > > > > +++ b/include/linux/netdevice.h
> > > > > > > @@ -1660,6 +1660,9 @@ struct xdp_metadata_ops {
> > > > > > >  			       enum xdp_rss_hash_type *rss_type);
> > > > > > >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_=
tci,
> > > > > > >  				   __be16 *vlan_proto);
> > > > > > > +	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
> > > > > > > +			       enum xdp_csum_status *csum_status,
> > > > > > > +			       union xdp_csum_info *csum_info);
> > > > > > >  };
> > > > > > > =20
> > > > > > >  /**
> > > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > > index 89c58f56ffc6..2b7a7d678ff4 100644
> > > > > > > --- a/include/net/xdp.h
> > > > > > > +++ b/include/net/xdp.h
> > > > > > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_atta=
chment_info *info,
> > > > > > >  			   bpf_xdp_metadata_rx_hash) \
> > > > > > >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > > > > > >  			   bpf_xdp_metadata_rx_vlan_tag) \
> > > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
> > > > > > > +			   bpf_xdp_metadata_rx_csum) \
> > > > > > > =20
> > > > > > >  enum {
> > > > > > >  #define XDP_METADATA_KFUNC(name, _) name,
> > > > > > > @@ -448,6 +450,50 @@ enum xdp_rss_hash_type {
> > > > > > >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX =3D XDP_RSS_TYPE_L4_IPV6_SCTP =
| XDP_RSS_L3_DYNHDR,
> > > > > > >  };
> > > > > > > =20
> > > > > > > +union xdp_csum_info {
> > > > > > > +	/* Checksum referred to by ``csum_start + csum_offset`` is =
considered
> > > > > > > +	 * valid, but was never calculated, TX device has to do thi=
s,
> > > > > > > +	 * starting from csum_start packet byte.
> > > > > > > +	 * Any preceding checksums are also considered valid.
> > > > > > > +	 * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``.
> > > > > > > +	 */
> > > > > > > +	struct {
> > > > > > > +		u16 csum_start;
> > > > > > > +		u16 csum_offset;
> > > > > > > +	};
> > > > > > > +
> > > > > > > +	/* Checksum, calculated over the whole packet.
> > > > > > > +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > > > > > +	 */
> > > > > > > +	u32 checksum;
> > > > > > > +};
> > > > > > > +
> > > > > > > +enum xdp_csum_status {
> > > > > > > +	/* HW had parsed several transport headers and validated th=
eir
> > > > > > > +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff=
``.
> > > > > > > +	 * 3 least significat bytes contain number of consecutive c=
hecksum,
> > > > > >=20
> > > > > > typo: significant
> > > > > >=20
> > > > > > (I did not scan for typos, just came across this when trying to=
 understand
> > > > > > the skb->csum_level + 1 trick. Probably good to run a spell che=
ck).
> > > > > >
> > > >=20
> > > > Oh, and about skb->csum_level + 1, maybe this way it would be more=
=20
> > > > understandable: XDP_CHECKSUM_VALID_LVL0 + skb->csum_level?
> > >=20
> > > Agreed, that would help document the intent.
> > > =20
> > > > Using number of valid checksums (starts with 1) instead of checksum=
 level=20
> > > > (starts with 0) is a debatable decision, but I have decided to go w=
ith it under=20
> > > > 2 assumptions:
> > > >=20
> > > > - the only reason checksum level in skb starts with 0 is to use les=
s bits
> > > > - checksum number would be more intuitive for XDP/AF_XDP applicatio=
n developers
> > > >=20
> > > > I encourage everyone to share their opinion on that.
> > >=20
> > > I assumed this offset by one was because csum_status zero implicitly
> > > meant XDP_CHECKSUM_NONE. Is that not correct? That should probably
> > > get an explicit name.
> > >=20
> >=20
> > Well, I was not sure, whether I should add XDP_CHECKSUM_NONE, because i=
t would=20
> > be equal to returning -ENODATA from kfunc, but after giving it some tho=
ught now,=20
> > it is worth to have XDP_CHECKSUM_NONE for packets that have no checksum=
 to=20
> > check, like for hash there is XDP_RSS_TYPE_L2.
>=20
> On receive, CHECKSUM_NONE means that the packet has not been checked, not
> necessarily that it has no checksum. Perhaps the device was unable to
> parse the protocol.
>=20
> (on transmit, it conveys that a transmit checksum is not required.)

Oh, my bad, I have re-read the docs and for packets without checksum,=20
CHECKSUM_UNNECESSARY instead conveys "CRC in OK". In such case,=20
XDP_CHECKSUM_NONE becomes a full equivalent of returning -ENODATA from kfun=
c, so=20
I do not think XDP_CHECKSUM_NONE enum is worth including, because it coud l=
ead=20
to new people writing programs in such way:

if (bpf_xdp_metadata_rx_csum(ctx, &csum_status, &rx_csum_info))
	fallback();

if (csum_status =3D=3D XDP_CHECKSUM_NONE)
	fallback();
[...]


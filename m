Return-Path: <bpf+bounces-5585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C6975C056
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 09:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053FF1C210CC
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 07:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710C8463;
	Fri, 21 Jul 2023 07:47:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798D2102;
	Fri, 21 Jul 2023 07:47:52 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B4E0;
	Fri, 21 Jul 2023 00:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689925633; x=1721461633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I+u1JZP6QGe8S4cNYG1BeDoKNnweQ5fMlWnxynY0gyA=;
  b=EC6jT1+TqHTC2Q8mQDz+ctghh/1/EKSPC0v86/JezMHaPce54lhZACV+
   4gr2ILr70ng53QMj4Zn/DkFeFt3K7n6SijjqyMADXH9YjDExJ7prxFe/1
   ryAawhhQMbaF4i38ZxNK02tjPaAkrehzEijReNm1ApnMe5nocAUAfVq0b
   ++L9yQYoqCRNNtqqqLoSO6TW82DvdTyXpMUZ8zK996UDotxkulqkmL0xY
   AROFjHnN0cdgQrNmsQsFrmzxY+qw3A93oSdGN7H8eOQFvXoM0i1HZIHlP
   JRS/d6e3q8g3xaTAPnsZpmk6eYn8a6QLScade/8oQDsP/4YGydUwjEz6d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356950155"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="356950155"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 00:47:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="898619865"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="898619865"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2023 00:47:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 00:47:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 00:47:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 00:47:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 00:47:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bskH2Nn8WDfMfozspvnf71DTVzQEJRQWkJN3ko3UV3u0XFG9d9xHwJraIz+AfxpoV9pNSo5BsVwBrGSZJrtHEFW3G411kejrwnS3HuZPZAqwv5fqEibfNlL0nLYUBYmIW++yHZcjoKqnk7NU9QpWnNCNIyym9DuYAoanhPnTpEg/Y6HCsS9LQLOKbTpixprD4xbtTWUZ2SnAshxQpUeMGh6WD24jUVKffsTSzaov8Hzpjrh0TBcytIY/ZGhuLSHwRrKE2gosrJs4L5jcOWHhRkkY2VwSDgxwz3Eb/m+475nt60Mbi7ybL6OQ1SB0QhdB+3myt/IfZT53hAZCPnrMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bKoZGLUnrb6x0ykEHBNwchYNVPVr+dzOaZ+An9OZxw=;
 b=YIruCNcocJ0FbHAGSym8SM52+oJeQjaRRXrsKzsI6GIKKoIV9vWu0jIVbDvD6FpLmULGvg7KyWPzIrNB+k8yL9YbTKv3Z4pjBIRooLDz+QSj1UEAgyFx1Z78SqUzkw2FLyHlxwwd2RNK8zRqsHgp6u89MYTy3Uf3tHi3BQ3fAr3or9Y3U6qPTQsjqF0pMiXJN941HoWHwaNsDw8KgKac1651mZCBkwEiHBRukz8JE8pHddtq2X8riZLRSyhKPf/L5BHBTyqoFF0ZkMY8rkwe7SOUYKy30E1jDObJg7A2Hb4YLprUdc9a6yxPQIN2GRL3pQjQ9+fML0eXA+fkLcvzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 07:46:57 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 07:46:56 +0000
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
Subject: Re: [PATCH bpf-next v3 20/21] selftests/bpf: Check VLAN tag and proto
 in xdp_metadata
Thread-Topic: [PATCH bpf-next v3 20/21] selftests/bpf: Check VLAN tag and
 proto in xdp_metadata
Thread-Index: Adm7p4XrvVIDs6/Llk+tMbC8E5LCrg==
Date: Fri, 21 Jul 2023 07:46:56 +0000
Message-ID: <ZLo29C1kpx99+u6G@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-21-larysa.zaremba@intel.com>
 <ZLmxt3744Q1e42pT@google.com>
In-Reply-To: <ZLmxt3744Q1e42pT@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|CY8PR11MB7292:EE_
x-ms-office365-filtering-correlation-id: 9281a571-b3f9-415a-d52a-08db89bea86b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NcQo/Y4gZLXC3QCaS67I0XmZYb2NpPs0F4nbZGEFtRAfomxKGGbR0x7WTzg1HYKDFhntSlHG3YeEykpsMdir2EssAO4bIci5jKtRjvz5uMZxiP9JDtkXBUMRw7ALIjf2QwtkHETQTNLDK+TuulsdTOAVc7gcSsgIktfjRTneyT2eveCTRuSGlYpwDubU11tASOHZ49B0unvMXlPbpOKfViknWGx0Bn2i66LhDsPx5tEwRsF8umHxcJk6OpYAIijlinnowPGjU8Z9Tl1W0xY0m5nZcMtAfZwZeZACRJ2R9Km3bDbrPuQKD+SoxR7S9jxlVMqXIw5c6t3a0ZMqk1mULo+sZvMl91ptB9RtJvKXUelKnC4Hf4mCGBXBDta7nRJr9yxB4tuolrKw6upQ2P/W9Batp9Oll5dBQVaoXG78HJjjZkIcJtom6n+0wYeYlcZvTnEkn5kl4ZyX5rFBPNE4bEbHBzWMx22aDNzMbuoyCJZ+h8LyjKj8Pb+59rd12I6RaW7cAlRjn0fYtab2IVIqnlQ9m65wg8qqgP8Xz7+5umCTPJxmp3nzvkbOvnUrVoyiSOL2mwOxEuMSRubI5YiEmb04HAGZOaj7gaGbKxdUTZo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(26005)(41300700001)(316002)(6506007)(6512007)(9686003)(186003)(83380400001)(82960400001)(478600001)(6916009)(71200400001)(54906003)(122000001)(6486002)(66556008)(4326008)(66446008)(64756008)(66946007)(66476007)(38100700002)(7416002)(86362001)(8676002)(5660300002)(2906002)(33716001)(8936002)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DSLopnbODLMwJZGsnvGdqng4+pr2r7Hdd9fZwsz+QhVOTojXdLQ4i8YYIgA5?=
 =?us-ascii?Q?ZuyMfMpUPugPdgSlph6rxGQuGGzFET+5OtnheWkvTBRf79zLQaF7tEAMv/cR?=
 =?us-ascii?Q?PL9swQXMpyhu9f1TXevbupsbJQbD5rIMLiPKSE1qWeVMaeHQFWz4kldAJi+W?=
 =?us-ascii?Q?Lg7bRiLInD2y6o+f8egMHUHwPRkVu0MxOntHB3+KMoD7BK1IZSSU3p7amOD6?=
 =?us-ascii?Q?GLhjiGtr2bqNJfSfnv5PmRiWIcvTPFhqMpJ90bdyHQFo3ckr+z9skLqqW411?=
 =?us-ascii?Q?9HAdZWDVFMeZM+S9MGcf8MbjceXjDnNAkm9tTRvvEyxNClSfVt2qUnIw6YCx?=
 =?us-ascii?Q?to1izqaM1fdR6I7sQII7+3OzHEIEWXr8OBqqSo+Z+K0QTOjqs6edGx6zyR+J?=
 =?us-ascii?Q?Yc9dHXiKbVZKkdHpnopD4ipecsvuwhJ6+pZOnTKe5UkVGPDDG0AEVYvppgt5?=
 =?us-ascii?Q?f+GAEtqLl6qxPB5nRKNjP6q+NQ5WRtGsxihBoP1tcg4h9Ts3J5EXhpNfqGPQ?=
 =?us-ascii?Q?vtPwn0gmVVie0/i6XzZ+E81IXpQkBlr5Lcv2W6TPNHAX61fC+/RIxZBzTPZc?=
 =?us-ascii?Q?nlRVJGoh8GGXzDiSU5VgUlvn6SAnYHLWSGI+XvxDuZIMwLBpgXhmwA7S2Rwv?=
 =?us-ascii?Q?rBlLwIIUGXbOGRM9SUEmwlFUfgFS6V1h5oi7FWqHZHEZFE4/9rEIKvxpCyPm?=
 =?us-ascii?Q?hL4AfEit+becwA0p7PqGAVsvLSp+c34M0ve1nfbY3Tta8rNWABqwC+XZZ9xb?=
 =?us-ascii?Q?cIsR02V5D6YEk4dzSfr5DVpXXcD4Y3CkXh6BBfuOTsXhefUoZnwfZT6iVBSP?=
 =?us-ascii?Q?8nmvBIbem4drA5xeao/5DvhwMQWrdeoS9V1aWXgddoLHEmvh1k7fsfG+kTQp?=
 =?us-ascii?Q?FR/wputBCbmt2qBXyuTCfgh7GBaIeJJw00N+d3dVxlRLe3kt/8VbZM95n7rl?=
 =?us-ascii?Q?vPlUDxWSMcehnL+4Mj3n6FTfyjAhRJXR1cQ0hxK2FLH91x8Q0u0vkElLw8Hs?=
 =?us-ascii?Q?78YVuITUVFCniozqeDYTbAPoCj05yT4vXU3pYkdca569APw7HKbTf5eDSVxt?=
 =?us-ascii?Q?g5gAnThlQ4npp2ZHz1ZpZNg4Gnoq3GsyKfEq4BnN+fw4v349ZE5diFLdUakw?=
 =?us-ascii?Q?Yq3l43ai6yH/2c579TRjZaLoezbWMHMvTF7ig1Q0TuU7Q/8/33YEwGC3Jqj+?=
 =?us-ascii?Q?Pe9rbgtzuyJbRJGpMBt7GAcoAyWORsJUeVliLQ8GQVRS1vVGq25ZimFmkMN1?=
 =?us-ascii?Q?SSr0OKLLwrPEWdgP86oNmc+XrVe7bn63oh9bp/8O/hBGUbTyNeZxM9Y93rPS?=
 =?us-ascii?Q?jXF8nG0nHeiB2lTZa5aHgDTWTx7HYMaGfbQwBmHJ7SzKy6r/6l3pIkr1DsQY?=
 =?us-ascii?Q?J6MiVC39NCRzpOaalfr22z7+7Co1FEQDjEZvqgzdoc/4IUYDt63pBqpKnBbl?=
 =?us-ascii?Q?MYoBkWfYj6y45YpTyOTEny2tY15pshvSnp8ZlQLZ2zjLJn2XVLQolJ1y67+z?=
 =?us-ascii?Q?4QjWbWQ0OCkmlJ1xCcinJt5WA5iUSUWrtS3VqxM/hPPCOmyJqjeub6ru7TJu?=
 =?us-ascii?Q?RzuPtW++apGdgBcs9WPoG5szgpBhCobvMQIn5+AKv4Wglr04tPolC0S9nwGb?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <583F53258A9DE447B4302837B7DC2435@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9281a571-b3f9-415a-d52a-08db89bea86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 07:46:56.5133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJ3O/kNvZGriE/BirkcBTE2Yq/CdO5/p4YxdrrL0e6BZpsQbCDX1106jfPMab7f/4cF9BSOeIWCWYVGRQHyemIa/SAONA0GmDjR6KWGjELU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 03:14:15PM -0700, Stanislav Fomichev wrote:
> On 07/19, Larysa Zaremba wrote:
> > Verify, whether VLAN tag and proto are set correctly.
> >=20
> > To simulate "stripped" VLAN tag on veth, send test packet from VLAN
> > interface.
> >=20
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>=20
> Acked-by: Stanislav Fomichev <sdf@google.com>
>=20
> > ---
> >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 22 +++++++++++++++++--
> >  .../selftests/bpf/progs/xdp_metadata.c        |  4 ++++
> >  2 files changed, 24 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/to=
ols/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > index 1877e5c6d6c7..6665cf0c59cc 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > @@ -38,7 +38,15 @@
> >  #define TX_MAC "00:00:00:00:00:01"
> >  #define RX_MAC "00:00:00:00:00:02"
> > =20
> > +#define VLAN_ID 59
> > +#define VLAN_ID_STR "59"
>=20
> I was looking whether we have some str(x) macro in the selftests,
> but doesn't look like we have any...
>=20

I could add one, if you could hint me at the file, where it would need to g=
o.
Or just add it locally for now?

> > +#define VLAN_PROTO "802.1Q"
> > +#define VLAN_PID htons(ETH_P_8021Q)
> > +#define TX_NAME_VLAN TX_NAME "." VLAN_ID_STR
> > +#define RX_NAME_VLAN RX_NAME "." VLAN_ID_STR
> > +
> >  #define XDP_RSS_TYPE_L4 BIT(3)
> > +#define VLAN_VID_MASK 0xfff
> > =20
> >  struct xsk {
> >  	void *umem_area;
> > @@ -215,6 +223,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
> >  	if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_typ=
e"))
> >  		return -1;
> > =20
> > +	if (!ASSERT_EQ(meta->rx_vlan_tci & VLAN_VID_MASK, VLAN_ID, "rx_vlan_t=
ci"))
> > +		return -1;
> > +
> > +	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
> > +		return -1;
> > +
> >  	xsk_ring_cons__release(&xsk->rx, 1);
> >  	refill_rx(xsk, comp_addr);
> > =20
> > @@ -248,10 +262,14 @@ void test_xdp_metadata(void)
> > =20
> >  	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
> >  	SYS(out, "ip link set dev " TX_NAME " up");
> > -	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> > +
> > +	SYS(out, "ip link add link " TX_NAME " " TX_NAME_VLAN
> > +		 " type vlan proto " VLAN_PROTO " id " VLAN_ID_STR);
> > +	SYS(out, "ip link set dev " TX_NAME_VLAN " up");
> > +	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME_VLAN);
> > =20
> >  	/* Avoid ARP calls */
> > -	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME=
);
> > +	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME=
_VLAN);
> >  	close_netns(tok);
> > =20
> >  	tok =3D open_netns(RX_NETNS_NAME);
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/t=
esting/selftests/bpf/progs/xdp_metadata.c
> > index d151d406a123..d3111649170e 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > @@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct=
 xdp_md *ctx,
> >  					 __u64 *timestamp) __ksym;
> >  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *h=
ash,
> >  				    enum xdp_rss_hash_type *rss_type) __ksym;
> > +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> > +					__u16 *vlan_tci,
> > +					__be16 *vlan_proto) __ksym;
> > =20
> >  SEC("xdp")
> >  int rx(struct xdp_md *ctx)
> > @@ -57,6 +60,7 @@ int rx(struct xdp_md *ctx)
> >  		meta->rx_timestamp =3D 1;
> > =20
> >  	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> > +	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci, &meta->rx_vlan_=
proto);
> > =20
> >  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> >  }
> > --=20
> > 2.41.0
> >=20
>=20


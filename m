Return-Path: <bpf+bounces-7175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EEC77296D
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 17:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98DF1C20BE3
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD1111A1;
	Mon,  7 Aug 2023 15:38:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72999BA40;
	Mon,  7 Aug 2023 15:38:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FAD172B;
	Mon,  7 Aug 2023 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691422686; x=1722958686;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KJsSH/K6CitrEb6Qt2X87PeALgbdNk36LEg3y9Z4cVE=;
  b=DHLFH5UKdCd2oop7EzLFxKQRfdZZwJTuL3+EeBq8YDcyL7TEuV7CDd9B
   dlaoR9Mf4pwpbMNmOcI0hiotO6GTlXEW4NG2L9wqA/YIU+SQ6ayHrlGOH
   k0LH8bRi9810RK4ZiJOrBt9Htl1fWW4VqeNjdek6DGMLaIP9IJId7Jx7Y
   lS91mjeIvr9q60IydGc8CjIOhy0TrG1+Z9aMO38TrONq+Wxv/AzCIdR0Z
   is8Xa1f2TeB9teMoxmYPP/CAcIEn8bBXvrNJfgtcRdig4+oPaPeyo+sQc
   P0++5+MqzaoF6GVVHdOUg7ytqhMeb82VEBbOzFAGXqy6klyrwunzKT9OL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360662518"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="360662518"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 08:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="874353510"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2023 08:38:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 08:38:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 08:38:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 08:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3r/ZCHPyARzuB3piTd+cjezg6u48dxptSJNuuge3dRlX2qji3SUmH6WsHs1TrCd9XBPkoNZajsUZiiygLf2R15SpFdtEtS51fsRHUZyzZaNJCaO7R08xHUW3vmI6IDasp9bvxIVPLLVcTqXSwqQ3cV2ehyiAqFJ2Jj6lJiowdx5cfKvRT0dxeqjcS5+qJtE5kS6o+NNv3vG7M02WFTNLAol2wbVyvO530pRwzIZSIzbxvN6JsvIRhOTBxHjc9jjamZ+a003TOqkXAsKMgyldjxwLU1SeAeaMfzJoO9iivsbaTyV2w3rvGbr0GlMvWPW1NrZ4UkEVhGBNrucoH0JNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5m8ppHSTrVpfCYqKcqC/Ej74RKjb/SDYMnMRX8YAfU=;
 b=WqHvR6hLuqIxqRjeaJdqZjS4LHt2chaxu0nv+T/kLsn9WKqQ01FrPnhZ/eF0Z2dCqdpsZOY2s7sRcZnTUwaXatDt7SzFxp5pDX3uEJRYv+oiWrcY46LM/DDWYsHurUxXbDPmUurpXXatQYoOLEX0gXAICKR1ncPjz3dqI19/Xdf/+NNgXhztmGd5inae6MsI+VuhNfbVzEeL+2NXe/TeCQDtY1/c/E57iAPgsPwlW9+4KGHTQtklLBgQjS6SbBvDpq/HaPnCO5MDgQz0O+H+4/3X43aJCyrTamOUaw1CFkZAxCv2ExNWcmMvd0heQk5n28+2kJ4wyc/GY0UatXaAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB8229.namprd11.prod.outlook.com (2603:10b6:8:15e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 15:38:01 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:38:01 +0000
Date: Mon, 7 Aug 2023 17:32:15 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Stanislav Fomichev <sdf@google.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern
	<dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn
	<willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>, Alexander Lobakin
	<alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, "Network
 Development" <netdev@vger.kernel.org>, Simon Horman
	<simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
Message-ID: <ZNEOf3vTu6pmNG1J@lincoln>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com>
 <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
 <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
 <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
 <ZMeSUrOfhq9dWz6f@lincoln>
 <CAADnVQJPgpo7J0qVTQJYYocZ=Jnw=O5GfN2=PyAQ55+WWG_DVg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJPgpo7J0qVTQJYYocZ=Jnw=O5GfN2=PyAQ55+WWG_DVg@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 45666d97-af31-4039-5aa3-08db975c4853
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OszyL1JKBOk8lY85ZZaDIEW1qcJt2gUuNhbwhayJH3g26aUyp5FvD8YQcL9Pmy2ZurLV9V3dqilMTGGHhNUhMMtmkiGlNQ4gsdJIniVQG05GcEHzG0WFjDOMZr17vLCrX14RcCtK+ffzUOH8/tFRNDqIUtQ/Iro1eFPnD2n75D0B1JlNg0qa5tds5Wx/FYQFpbs8PIWc84C0mcJBoYJfO/HLGqmoD1BtfO9FCUXF8m1fq9PTDJiE4emQ4eyv3TuvvCSfFqRviAZUXPYxuo7mmK28LJQvo91UyH3O158qHG7esciupYhaKwX4UJK5JeWotrdO3SgL/MnHTlPAucWer9LrE75fc5MmBxaf15H/OH8YzpE/HrnIfxdscEBkXnmQfDSpApICVWbMz2gHikJU5L9gxA4or2QQwpPYu5ZEA5qhIKD2uEz3gYXIjpdd94LS6yg3NkIhr6vekdw1HedNcXg6fk4BF5bjjHn3zVLS9ws1rc4MBkoQTmM1O7B+MVGTxn9I+WlExGBZYl5z2HGB/TjeN/jYZz7fg3B85UPUe2hnzfaVq27Pm0aSXNBO53/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(1800799003)(186006)(6486002)(6666004)(9686003)(478600001)(6512007)(33716001)(82960400001)(86362001)(26005)(6506007)(53546011)(41300700001)(5660300002)(8936002)(316002)(8676002)(7416002)(44832011)(54906003)(110136005)(2906002)(4326008)(66476007)(66556008)(66946007)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG0xSTdScHdVeXVmRS83SFJremhWQXQzN2JhbFhEWWxPVklZUWltd2RnajFu?=
 =?utf-8?B?TURET014S1A5cFcyZG16Vnc2TmJVYjYzZ09vWEdQTHFpTnlRT3lQbkNkUlEy?=
 =?utf-8?B?VEJqUlNMOXIwcnJaOEFycGY0YnFiOGliTExLaFp1Tk9tSXIwWS9TSXdkaUlG?=
 =?utf-8?B?M1BvcDVnakVUQUpGdng2Mk1BbFBPQm16SW9OZERPaXMzcjJOYW50eW9IMjR2?=
 =?utf-8?B?Y2xFMU42SVpKbjZLUHRwSVF5cTNNWTJSbXNpSFRScWdUdk01T1lLc2FCa1Vv?=
 =?utf-8?B?by9veUNGV1lZK3Q2aDZBaGVVanA4bVZtdTBFbkNFRTk5NDdnWHVvQUpBa0lY?=
 =?utf-8?B?VkIxTTM5QVlLTUg0WGt2V2lMY3o1Q2R0TVNic1UrVWpwVWZSeVFUOXZ1WXFx?=
 =?utf-8?B?Ti9QLzh3YU5wWlNsVWxLb1VoeUxRL1l3eFk2b2YxWU5JNHdFc25tWUNrdnU2?=
 =?utf-8?B?RVBKSkxwaHJoTDBkaFpGY1QzSHFSS2xJa3BJeHJYZmxZbHRoYnZVSGlGVmZS?=
 =?utf-8?B?aTE4NmUzZERveVB2TkZ6LzV6RzVzTytwNGpPakZqUDdWKzlNUmo5VHJYdy9o?=
 =?utf-8?B?TjVZTmUxdFNBVVJhQVpVelZkN2w3V3NmbEpDbTBsc1ptbldPZ0VyeUg4VVV2?=
 =?utf-8?B?dWlzSzJpdlMxTTZ5MU16ZzRTRnk3b0RLR1R4bTJMRUR5ZTlDc2NlcFFWYnhD?=
 =?utf-8?B?aElmeXdnSEVHcDFkbEJmMnpyMUhsa2prc1ZJOWxvWVUzaWFKK2RrYVprRUlQ?=
 =?utf-8?B?U25KaEtTaTVDNkFhT0pHWnlNVUVFMk9jMWh6OWsyb005b2Q3bGMwR2J3Vzhj?=
 =?utf-8?B?Rk5jOWxHY0hnWllZRHZwdW5GVW9yQ0NDUkZZWWdOOVloeU1HSXBFTEV6VE8x?=
 =?utf-8?B?b1NJa1BxT0Z1cG1ONS9leG13cmNON09rZUJJL0haVUF6VVhHWHdYbjhxekZR?=
 =?utf-8?B?dklHbld4Q3Z5cDEwZFVEVHdkZGFrdEwwMTNNQTlxSW9KRjlVSURMR1dRTWU0?=
 =?utf-8?B?eW5DVHhKWmdsbnhQNllaMk1rUUJjL0llRDZ5aW1hMHd2SWprZXpleDZUWjlZ?=
 =?utf-8?B?Yk9ZQ2NnR2FoWi9JbDRUTE9Fc0g1dkR6czRhK0x2eEJ3SjlEbGdwMGtVcGl2?=
 =?utf-8?B?TDdiNVBQaHNNdkhVY29RR25meE85RzYyUVZtTmltTHc4aTUzVCtDUHF6K1Zm?=
 =?utf-8?B?ZjhpQnhRdWhDWFR0VkNzVHkwc2JVbWpjZ3dvUFo3d1NoTUprREtVZDV2UXh6?=
 =?utf-8?B?L0JPcWhqZUVGeXM5SGpRbnFXekJpeWJtNFJiZ1JIVkxENnVPbkdyemcxVmN0?=
 =?utf-8?B?K2xkblJ1TURUNlRKUWpsMlgxN0ZGNFdZeWoydGVNczJTZWFubkFWMkFJOXlG?=
 =?utf-8?B?LzAzV2J0akVXLzhjTUc3cUZ2OERaRnpidVR0cmxsUVVkZU5UWnJHOVB3UE9O?=
 =?utf-8?B?TFJBRHd6R0EvZmVCcHdtMUdDQVFqbXVzT2FkNzFyV2RWbGdhc1ZGQ0pnMVJo?=
 =?utf-8?B?VGxQOVJINE9iRXJkSGFrbHppRGQybFk1SHlRSHhxbUF3THB3QURxbG1XZS9o?=
 =?utf-8?B?emlxYUtFcWdNZDluQlk4UUJaVW1WOElZbFdlYS9XbXo4NExiQThtdXYycTY0?=
 =?utf-8?B?QWZ1M3JUT2treHhzTzZQTThBNU84RVdOdE9wbjA0djEvYUVuNkhVTExUcWsw?=
 =?utf-8?B?MDNTQ3F6b2JXZDRsUHZJTjA0N09IU0s3WUJ2RzIzWmJhU241YzcwMVdEUGMy?=
 =?utf-8?B?QXczTTZmTkVuS2FyckdHNGdpcDFTTVhGamh3a09kbkRZTG9sNUtkL2xRTFdr?=
 =?utf-8?B?bnN1a0RSUzNmZDkwZkF3RjhPSVpBdGFuR2p3a0lZN1NhaytYdHpKVTdyQTlD?=
 =?utf-8?B?WE5wWWdNWjlVU3dKSkhGRkQ5ZmVPSTdYRXl1UFhScFJwOTdWTnpROFhCMEtN?=
 =?utf-8?B?MFhIemFQMlhtTjJoR1NReTJiUnNiWVB6WTZlYW5JMkRzbUlSWkloZjZMYWt3?=
 =?utf-8?B?alF0QlVIZjRPTXBoM2l2VE1GZVRYSnViTVdkZFBhWGlWSUsxZXhwWUtOOStZ?=
 =?utf-8?B?UHRkVnVQaGNKT1FJa3U3V3h1dzRTSlFKeVBIL2N4L1BjMkdxUGNiNFlZQmxT?=
 =?utf-8?B?V0NFbUJjeENYMUJzTERsVStWNEdpU2Z4MHR5VmcxUUZxT2MrSjlHR3o3ZGFi?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45666d97-af31-4039-5aa3-08db975c4853
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:38:01.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3Xkjlzk8wJEJeOtVxVV56ci86pKdYuln3zovBdi9YCkOUSH8vUNdoTeUukzAxMul8VqHn4ptlKvi4CTlZGEA55e60rBDV60HhzNjIcNvvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8229
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 06:03:26PM -0700, Alexei Starovoitov wrote:
> On Mon, Jul 31, 2023 at 3:56 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > On Sun, Jul 30, 2023 at 09:13:02AM -0400, Willem de Bruijn wrote:
> > > Alexei Starovoitov wrote:
> > > > On Sat, Jul 29, 2023 at 9:15 AM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Alexei Starovoitov wrote:
> > > > > > On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrote:
> > > > > > >
> > > > > > > +union xdp_csum_info {
> > > > > > > +   /* Checksum referred to by ``csum_start + csum_offset`` is considered
> > > > > > > +    * valid, but was never calculated, TX device has to do this,
> > > > > > > +    * starting from csum_start packet byte.
> > > > > > > +    * Any preceding checksums are also considered valid.
> > > > > > > +    * Available, if ``status == XDP_CHECKSUM_PARTIAL``.
> > > > > > > +    */
> > > > > > > +   struct {
> > > > > > > +           u16 csum_start;
> > > > > > > +           u16 csum_offset;
> > > > > > > +   };
> > > > > > > +
> > > > > >
> > > > > > CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see in the above.
> > > > >
> > > > > It can be observed on RX when packets are looped.
> > > > >
> > > > > This may be observed even in XDP on veth.
> > > >
> > > > veth and XDP is a broken combination. GSO packets coming out of containers
> > > > cannot be parsed properly by XDP.
> > > > It was added mainly for testing. Just like "generic XDP".
> > > > bpf progs at skb layer is much better fit for veth.
> > >
> > > Ok. Still, seems forward looking and little cost to define the
> > > constant?
> > >
> >
> > +1
> > CHECKSUM_PARTIAL is mostly for testing and removing/adding it doesn't change
> > anything from the perspective of the user that does not use it, so I think it is
> > worth having.
> 
> "little cost to define the constant".
> Not really. A constant in UAPI is a heavy burden.

Sorry for the delayed response.

I still do not comprehend the problem fully for this particular case, 
considering it shouldn't block any future changes to the API by itself.

But, I personally have no reason to push hard the veth-supporting changes 
(aside from wanting the tests to look nicer).

Still, before removing this in v5, I would like to get some additional feedback 
on this, preferably from Jesper (who, if I remember correctly, takes an interest 
in XDP on veth) or Stanislav.

If instead of union xdp_csum_info we will have just checksum as a second 
argument, there will be no going back for this particular kfunc, so I want to be 
sure nobody will ever need such feature.

[...]


Return-Path: <bpf+bounces-5490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9790E75B337
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474ED281F0F
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149DA18C2E;
	Thu, 20 Jul 2023 15:42:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951EB18C1A;
	Thu, 20 Jul 2023 15:42:03 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245C610A;
	Thu, 20 Jul 2023 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689867721; x=1721403721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wxy3v9HN0QnPXpCwwFTM3y5Wl2dJtCVWSWyA/sHy7vc=;
  b=Ijf++cSlSZuO0IPlvPoUhLkhVK0aKrQlDT4m/SvC2a/UAGAcACQmE1Wz
   X/Mv4lcG+a5sbTJcqPriW4QBC8NZnFoDiBbnJl0/0xs9qaNxy5448Sjk/
   3Jo/HX5zxbXl+6u3JnaZ316QwfNxh958nLfTG6qRtHVDtPyaXOXAbO02t
   47hbGx41ec/0cHswXiNhvp18ZEsSmULtVPdaqJK20Fuet11CemZUhbf9K
   VM800ZtlU8jgVl/5B2cho7jm44s8ALWNCebYn1nDbwNfq7TtHaeSpLVUW
   POon/XY41ZbV5SBymCfZYtwZflo7WiAsKFbUmZ5uGRdjMbTjcdh5hqClr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="397660345"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="397660345"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 08:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759605356"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="759605356"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2023 08:42:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 08:41:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 08:41:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 08:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyQIlvq0X9hXeXuuyhjMewRrY1nN/mAMi5i9mqNOIxb6lL4oOa/APC5iNELspFMDgdj5SKz6Xz40tgMzA6kG7Y7+0IwsX2duZsWvFwR18eRFusuv/ULJ3KtlLSPoVbSf5W2o9egvQNPQgd5EEUPs6yuF8qXXC+J4izgDBIthYzVui41FV53f+i/7YKp1gDE+51MN3bQedwjrf0DYg+wuVyDTQn6wWnPrKTilxWeho1+LwvXlTH82xx2Lxz6DosugJ5UMuvheeI50NtdMsMnWywMcmFLsVKr+FrB1xS1hcE9oWbMYx57wFacmkkk2+DbwKR0GmWdGN071XiBYhyNQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxy3v9HN0QnPXpCwwFTM3y5Wl2dJtCVWSWyA/sHy7vc=;
 b=MsesLcMcgLc2Wa11Dq0lOia4hPa73orxHDlcxs4lcWr/FQ4ubHaVa5OOiEnKVuBaM4SKGJDIVFS1jqaY+c+yCiCS8UH5eWdnZQrN5EFKXYVgBaPR/1z5hhJ7Qch3XAgCZx4hA1yc225JIzCSSJRWdht3fn4AVzPRGORp5JHIMXR+d6qSXZADNXB5Sh7LiO7UbbJLdn2HFAhTooxWVArlqfor6oE1i7GSWX5Ng0i/jvsIpskYgMDuxqYKrbNT+ggE+HPb6na8h/tns8MA/u9QJ5rqMt/QngAPhLrsoT2BhAc3Hz3sNxO45JzipW2ygGY0OUBdNupoQKLHrlSPW1K+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 15:41:56 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.022; Thu, 20 Jul 2023
 15:41:54 +0000
From: "Zaremba, Larysa" <larysa.zaremba@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, David Ahern
	<dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn
	<willemb@google.com>, "Brouer, Jesper" <brouer@redhat.com>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
	"Tahhan, Maryam" <mtahhan@redhat.com>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
Thread-Topic: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
Thread-Index: Adm7ILVRye3hpYV/LECafuH/T/xGdA==
Date: Thu, 20 Jul 2023 15:41:53 +0000
Message-ID: <ZLlUyJdj50UqFM0m@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-14-larysa.zaremba@intel.com>
 <20230719185930.6adapqctxfdsfmye@macbook-pro-8.dhcp.thefacebook.com>
 <64b85ad52d012_2849c1294df@willemb.c.googlers.com.notmuch>
 <ZLkBrfex1ENbVDwF@lincoln>
 <CAADnVQKF3j-_qLM4MWkJKK=ZyPuWrLnmGfgf9BC4zm-4=1qSfw@mail.gmail.com>
In-Reply-To: <CAADnVQKF3j-_qLM4MWkJKK=ZyPuWrLnmGfgf9BC4zm-4=1qSfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: 8409154a-f6ab-4430-8eac-08db8937d7cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: amt2ica77qguEoGiFyhZf7fc2pORZCAgzAEjx21ts+ym97cxJ+/DEWPWbkTGpzCP+2xuHMn6sefZ6/Ju924muesbq2qE5XDeJ4pwUP4/1EVIzus125aZQ/2FXFQcDC1rjTdVxBPb8nXq0mlEkaX3pqSniZkwdZuklXXvH0pcUj1Ali6+YBfnbn8ZPDGCtdeS8N/gePQypswoUmLlAA9RQUQYVsSj0xhH5zmgnZJgawBX4LMrZoyc1QseiVOlvGS4l/5Aj3UVA/Qchr3KhrQo/vvkkKstvRl3zYrXrA5gGz5gEfV/gq2/RO8LD7HBrY1nMHkKBf7Ietwi3dEvvNrsNI8/Kkop+fkOJ79I1aXpJ60vbo+CMOWDghkZHtgj+0YPBaGK4rH4j/sYLyEeC/hlm6xNimLx5xtfhHIHWyoljXZmxb54OLfHWoUUOsPFTvakN4+fGzPy3q0v+yGAJc9NaQ0AHJi7k8wLyfHDiZx1vyQaoX42ETnUiJNokRq3mi0XiqOc2ufjNOui3JW4vHhwp9jlP2gRUQJIMTNGDDx+GPAX0V5u1dSmrnNiXNT/Dki5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(83380400001)(2906002)(38100700002)(82960400001)(122000001)(26005)(6916009)(66446008)(66556008)(66946007)(64756008)(66476007)(4326008)(316002)(186003)(5660300002)(53546011)(6506007)(6486002)(6512007)(41300700001)(9686003)(54906003)(478600001)(71200400001)(33716001)(86362001)(8936002)(8676002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmhnZWNZVHdvZU5zTUk0LzI4Y1lkeCtGTHRoWlFnOG1QdnBlQ2M1ajVXZlo3?=
 =?utf-8?B?TDhyVTJmbFBURGo2Rm55OTNoMnUrb1dhOVN2UU41MW4xVjhkVVNBRWRmN1Y0?=
 =?utf-8?B?TmFjMENGYlRycVNvM0Qvdk1sYjA3U2ZzSnlRNkF2ZFgyVVdTd3ZOWE9ydlpL?=
 =?utf-8?B?S2VwZUNXRktzcXplRkdWWGlJYUNjeUFCa0FsK0xHTnJ2QmJvbG9xZkRKZS9C?=
 =?utf-8?B?VHhlK01CNzNLK3FlbkNLVHJpczJJSTloRFdLanBuZU1hYURieURVeGtUTlFP?=
 =?utf-8?B?dW5YM0szeVg0TG04bjVZVk1HZ1Y3YUFnTXZxdFpkZlRTUG9IclJ4ZW12Ulhu?=
 =?utf-8?B?TTJhL2NGMzUyL1E1dnJtWFY2K0Y2MnNVYVp0bFExeG5MV1piY0dhT2ltUXQw?=
 =?utf-8?B?VXRTWG9EMng4L2lxVXpZc3d4VnNPamNDL2FuNFVEZ2pUZ3YxWitpaXdVOHU5?=
 =?utf-8?B?ZTYrdzlBWERiV2p4UFRabThUMkRiL3lYaUlEVThrTU5iaWRONFZSM1Z3ZERS?=
 =?utf-8?B?U21Xc0F4cmxXWTdWZWpiVWU4Y2JrSGJPUWlCR2tNWjNXNi9NTU1qRTIySzQ0?=
 =?utf-8?B?VDRlK2hRUFUvVjNsbGprNGsyeUJDSXFTSVBDMkpmeHBZR3hIcXNKY2NQVWVv?=
 =?utf-8?B?cVhhdXlOc2xxWlVJOS8zeGJQeEtiZlM0QkRBd2htRklDZHpxOWRTdENpREl6?=
 =?utf-8?B?ZFJxSzBScEN5bnAweVVpMzFMK1RjTE5ML0MxV0V3em1mZ0VpQTJPWnZaM0Vs?=
 =?utf-8?B?S3J4T05qWEc1UEFsbUpYTitNVEhIM1FwNEJySUwrU0J5eEZBQnBpNWhwWHVu?=
 =?utf-8?B?YktsZ3FMSkJGVDVlN2pvY2hYaVZ5bzlLVk5GTGZTWUUySmJFTmp5YnFDY3RK?=
 =?utf-8?B?TG0yMkZtM05RYmFCUEp0ZFMweXR5bFl6VStzamVTZ2NJSll2ZnVyeU1LWkU0?=
 =?utf-8?B?RlNQVEdLR2JWZ2ZXT2ZuMmxUd2p2WDRWZkFIUW1DdVJNSTU3OGxubGxTb1Zl?=
 =?utf-8?B?TGtsWmE0MDJJeUw2VTVudlpXbk5yZ2NCellVT1RMQ3F1bldUcEFPdXo2MXFN?=
 =?utf-8?B?RWdnM1ZIZWpOZkN1OHR2RnB0K1ovMXNNQmc4RXpSWGNNVHkrelRFcHFFS2Zn?=
 =?utf-8?B?MWxnS2YyWFZ2dk0ycHZNMWcyRjlTNGdZQUpnWUgzR2RWcEs3Wk1PK2hBWkZ6?=
 =?utf-8?B?NlRXQ0F0NnZTNVFGdGRSMGdZeTZMcU9wSTRGQ2FCUVFoUmVhWE1CUW0yd1dq?=
 =?utf-8?B?R0Y3WE5VKytKSFVmamhxZG9Ob01SaHN2c01DcXJiY1JURkpGd052Z0xGUGdr?=
 =?utf-8?B?UGhScHNvdmpqajBYZGhrQ3A0aFR4YU5yT3RiMXdVY0VCMjQ2enVDdElMU1ho?=
 =?utf-8?B?ZGM2S3lWVWYwNWx5eFMzVDd5UE13NVo2K01qcytOdk5aaTBCWWNBZlhXbEZX?=
 =?utf-8?B?ZVBoUURIOUZOVGVOSFprTFlyQUNKRG1iV2tlYVRmajhEYkJaSFJOdjRDdUVW?=
 =?utf-8?B?dTV2TmF0WWg2dmhOTTdWamxVWjFTYm9LRnRkUmxkV0tqN3NKN3BWekVKdUJ1?=
 =?utf-8?B?dVUwcDdGZytOZFdKMXVWTG9LK0ZJd3FxTWlEb0xnOC9JWFV5MFhmMjdiNGkx?=
 =?utf-8?B?TkF6czFPZ09qczB0K2ZPZmM3ZWdFR1JRdnh2RFZzckFLWHBRTjQ3RTZ2TG9B?=
 =?utf-8?B?ekxDZVlWaDZQVVNtckJxbS9rdGdzdmk5enJDemFBMUtQNk4zdHI4UkRxbVMy?=
 =?utf-8?B?WnY1dWdCUFo2OWZtU3JzMGpUdGZrY2VFMDJHaUlHNi82bXR2M2RFb2p3ejdK?=
 =?utf-8?B?MGRvQjhVSXNNWnhTd0JvR3o0b1VidndSenRmS0xqK01MVG1LY3ppYVA3ZGlP?=
 =?utf-8?B?bmdwQnI0cThBb2cyTGxXUlp5TXE5ZnpOL0JxTXUxRUg3LzlCYzNtUW4rWDY0?=
 =?utf-8?B?Q1g0T2xpQ3F2UVFLdTUxVGFoYTZwRkJEZmRCVnNpWURoTFM3alF6WGtOKy9o?=
 =?utf-8?B?dEd1UzVRc3pySldoN0t6VEJNUG5GUW1MTWdFdzZ1MlBRem1iaVJtYVVlU0xw?=
 =?utf-8?B?akFEWTBIaUhXbDY4QUpic3N0SVN6dVNXV01HUzJobEIrNHlQay94WEw4UXpw?=
 =?utf-8?B?d2NCaHY3cTI5N1RmRmU1REY1QjNvOHNBSjJhK1hjQ2tENFFiMm5sRldELzNi?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F92729876B61434D9B3A7DF93FD2EF69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8409154a-f6ab-4430-8eac-08db8937d7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 15:41:53.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miA6P4/kaMFidsOopXB0fBZGUgLBWPxR8cyljDglKKCygzkJgqAYXFa9vPVBxd+B4CbqBylx1+EVpHUVseD5wGeT/ZWmbLGCtpwXjR9vKLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgMDg6MTQ6NTJBTSAtMDcwMCwgQWxleGVpIFN0YXJvdm9p
dG92IHdyb3RlOg0KPiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAyOjQ34oCvQU0gWmFyZW1iYSwg
TGFyeXNhDQo+IDxsYXJ5c2EuemFyZW1iYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24g
V2VkLCBKdWwgMTksIDIwMjMgYXQgMDU6NTE6MTdQTSAtMDQwMCwgV2lsbGVtIGRlIEJydWlqbiB3
cm90ZToNCj4gPiA+IEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCBK
dWwgMTksIDIwMjMgYXQgMDg6Mzc6MjZQTSArMDIwMCwgTGFyeXNhIFphcmVtYmEgd3JvdGU6DQo+
ID4gPiA+ID4gSW1wbGVtZW50IC54bW9fcnhfY3N1bSBjYWxsYmFjayB0byBhbGxvdyBYRFAgY29k
ZSB0byBkZXRlcm1pbmUsDQo+ID4gPiA+ID4gd2hldGhlciBIVyBoYXMgdmFsaWRhdGVkIGFueSBj
aGVja3N1bXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMYXJ5c2EgWmFy
ZW1iYSA8bGFyeXNhLnphcmVtYmFAaW50ZWwuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3R4cnhfbGliLmMgfCAyOSArKysr
KysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25z
KCspDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV90eHJ4X2xpYi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV90eHJ4X2xpYi5jDQo+ID4gPiA+ID4gaW5kZXggNTQ2ODVkMDc0N2FhLi42NjQ3YTdl
NTVhYzggMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWNlL2ljZV90eHJ4X2xpYi5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV90eHJ4X2xpYi5jDQo+ID4gPiA+ID4gQEAgLTY2MCw4ICs2NjAsMzcgQEAg
c3RhdGljIGludCBpY2VfeGRwX3J4X3ZsYW5fdGFnKGNvbnN0IHN0cnVjdCB4ZHBfbWQgKmN0eCwg
dTE2ICp2bGFuX3RjaSwNCj4gPiA+ID4gPiAgIHJldHVybiAwOw0KPiA+ID4gPiA+ICB9DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiArLyoqDQo+ID4gPiA+ID4gKyAqIGljZV94ZHBfcnhfY3N1bV9sdmwg
LSBHZXQgbGV2ZWwsIGF0IHdoaWNoIEhXIGhhcyBjaGVja2VkIHRoZSBjaGVja3N1bQ0KPiA+ID4g
PiA+ICsgKiBAY3R4OiBYRFAgYnVmZiBwb2ludGVyDQo+ID4gPiA+ID4gKyAqIEBjc3VtX3N0YXR1
czogZGVzdGluYXRpb24gYWRkcmVzcw0KPiA+ID4gPiA+ICsgKiBAY3N1bV9pbmZvOiBkZXN0aW5h
dGlvbiBhZGRyZXNzDQo+ID4gPiA+ID4gKyAqDQo+ID4gPiA+ID4gKyAqIENvcHkgSFcgY2hlY2tz
dW0gbGV2ZWwgKGlmIHdhcyBjaGVja2VkKSB0byB0aGUgZGVzdGluYXRpb24gYWRkcmVzcy4NCj4g
PiA+ID4gPiArICovDQo+ID4gPiA+ID4gK3N0YXRpYyBpbnQgaWNlX3hkcF9yeF9jc3VtKGNvbnN0
IHN0cnVjdCB4ZHBfbWQgKmN0eCwNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICBlbnVt
IHhkcF9jc3VtX3N0YXR1cyAqY3N1bV9zdGF0dXMsDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgdW5pb24geGRwX2NzdW1faW5mbyAqY3N1bV9pbmZvKQ0KPiA+ID4gPiA+ICt7DQo+ID4g
PiA+ID4gKyBjb25zdCBzdHJ1Y3QgaWNlX3hkcF9idWZmICp4ZHBfZXh0ID0gKHZvaWQgKiljdHg7
DQo+ID4gPiA+ID4gKyBjb25zdCB1bmlvbiBpY2VfMzJiX3J4X2ZsZXhfZGVzYyAqZW9wX2Rlc2M7
DQo+ID4gPiA+ID4gKyBlbnVtIGljZV9yeF9jc3VtX3N0YXR1cyBzdGF0dXM7DQo+ID4gPiA+ID4g
KyB1MTYgcHR5cGU7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgZW9wX2Rlc2MgPSB4ZHBfZXh0
LT5wa3RfY3R4LmVvcF9kZXNjOw0KPiA+ID4gPiA+ICsgcHR5cGUgPSBpY2VfZ2V0X3B0eXBlKGVv
cF9kZXNjKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyBzdGF0dXMgPSBpY2VfZ2V0X3J4X2Nz
dW1fc3RhdHVzKGVvcF9kZXNjLCBwdHlwZSk7DQo+ID4gPiA+ID4gKyBpZiAoc3RhdHVzICYgSUNF
X1JYX0NTVU1fTk9ORSkNCj4gPiA+ID4gPiArICAgICAgICAgcmV0dXJuIC1FTk9EQVRBOw0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArICpjc3VtX3N0YXR1cyA9IGljZV9yeF9jc3VtX2x2bChzdGF0
dXMpICsgMTsNCg0KSSdsbCBkdXBsaWNhdGUgYW4gaW1wcm92ZWQgdmVyc2lvbiBvZiB0aGlzIGxp
bmUgZnJvbSBhbm90aGVyIHRocmVhZCBpbiBjYXNlIGl0IA0KY291bGQgaGVscCB3aXRoIHRoZSBj
b21wcmVoZW5zaW9uIGR1cmluZyByZXZpZXc6DQoNCipjc3VtX3N0YXR1cyA9IFhEUF9DSEVDS1NV
TV9WQUxJRF9MVkwwICsgaWNlX3J4X2NzdW1fbHZsKHN0YXR1cyk7DQoNCj4gPiA+ID4gPiArIHJl
dHVybiAwOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+DQo+ID4gPiA+IGFuZCB4ZHBfY3N1bV9pbmZv
IGZyb20gcHJldmlvdXMgcGF0Y2ggbGVmdCB1bmluaXRpYWxpemVkPw0KPiA+ID4gPiBXaGF0IHdh
cyB0aGUgcG9pbnQgYWRkaW5nIGl0IHRoZW4/DQo+ID4gPg0KPiA+ID4gSSBzdXBwb3NlIHRoaXMg
ZHJpdmVyIG9ubHkgcmV0dXJucyBDSEVDS1NVTV9OT05FIG9yDQo+ID4gPiBDSEVDS1NVTV9VTk5F
Q0VTU0FSWT8gQWxzbyBiYXNlZCBvbiBhIGdyZXAgb2YgdGhlIGRyaXZlciBkaXIuDQo+ID4gPg0K
PiA+DQo+ID4gWWVzLCBjb3JyZWN0LCBjdXJyZW50IGljZSBIVyBjYW5ub3QgcHJvZHVjZSBjb21w
bGV0ZSBjaGVja3N1bSwNCj4gPiBzbyBvbmx5IENIRUNLU1VNX1VOTkVDRVNTQVJZIGZvciBrbm93
biBwcm90b2NvbHMsIENIRUNLU1VNX05PTkUgb3RoZXJ3aXNlLA0KPiA+IG5vdGhpbmcgdG8gaW5p
dGlhbGl6ZSBjc3VtX2luZm8gd2l0aCBpbiBlaXRoZXIgY2FzZS4NCj4gPg0KPiA+IHhkcF9jc3Vt
X2luZm8gaXMgaW5pdGlhbGl6ZWQgaW4gdmV0aCBpbXBsZW1lbnRhdGlvbiB0aG91Z2gsIGJ1dCBv
bmx5DQo+ID4gY3N1bV9zdGFydC9vZmZzZXQsIHNvIGNvbXBsZXRlIFhEUCBjaGVja3N1bSBoYXMg
bm8gdXNlcnMgaW4gdGhpcyBwYXRjaHNldC4NCj4gPiBJcyB0aGlzIGEgcHJvYmxlbT8NCj4gPg0K
PiA+IEluIHByZXZpb3VzIHZlcnNpb24gSSBoYWQgQ0hFQ0tTVU1fVU5ORUNFU1NBUlktb25seSBr
ZnVuYywgYnV0IEkgdGhpbmsgZXZlcnlvbmUNCj4gPiBoYXMgYWdyZWVkLCBjc3VtIGhpbnQga2Z1
bmMgc2hvdWxkIGdpdmUgbW9yZSBjb21wcmVoZW5zaXZlIG91dHB1dC4NCj4gDQo+IGNzdW0ga2Z1
bmMgc3VwcG9zZWQgdG8gYmUgZ2VuZXJpYy4NCj4gSWYgZm9yIElDRSBpdCBmaWxscyBpbiBvbmUg
YXJndW1lbnQgYW5kIGZvciB2ZXRoIGFub3RoZXIgdGhlbiB0aGUgd2hvbGUNCj4gaWRlYSBvZiBn
ZW5lcmljIGFwaSBpcyBub3Qgd29ya2luZy4NCg0KQm90aCBpY2UgYW5kIHZldGggZmlsbCBpbiB0
aGUgY3N1bV9zdGF0dXMsIHRoZSBuZWVkIHRvIGZpbGwgaW4gdGhlIGNzdW1faW5mbyBpcyANCmRl
dGVybWluZWQgYnkgdGhlIHN0YXR1cy4gSSBkb24gbm90IHNlZSBhIHByb2JsZW0gd2l0aCB0aGF0
Lg0KDQpNYXliZSB5b3UgaGF2ZSBhbiBpc3N1ZSB3aXRoIHB1dHRpbmcgYSB2YWxpZCBjaGVja3N1
bSBudW1iZXIgaW50byBhIHN0YXR1cyANCmluc3RlYWQgb2YgaW5mbz8gUGxlYXNlIGNsYXJpZnku
DQo=


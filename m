Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC786DF3F0
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDLLmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 07:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDLLmP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 07:42:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59C49FD
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 04:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681299715; x=1712835715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=syycDIYIzswV9lNmILEP2tKun3bXf+K2hf1maSNosJQ=;
  b=WIVH9reqnm7ZIDZZuLDcgkzVPGX5xYaUp9KqACW+bk05u2eQGdwv/L57
   +PqKlLpTqqPYA/OdSsaWwCFWO4+5bSJyVYAsxuUHj3nVEbW7aZacp0YG3
   INwsN47aQx3OQj47Xxoj69dAxGgBmULIwLuWxCeV8hriPOINiiwQY19/C
   1zugTHPyg/hgIm3YYaaLc2n3mTz9Tz3JIXHBdHLWAwDbzqrIxjp0gLqME
   sszOih8r1L0UBPtRYfje++hSFYRFPvLOtCZubXEybuKmMoLcJgYCOL/mN
   UQnsJOwcSyZCD8rJBq4O1MUW5fyo2eaht4yAooJILorjvRtLtGxJFsBnv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="323492653"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323492653"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="639188501"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639188501"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 12 Apr 2023 04:40:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 04:40:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 04:40:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 04:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pn//SdYvu9HCnTx1gPCGJsVZ7AG9GYIMfMyIulelvGciqwlClrNxYEPOrqssf4VCD3zGEUVY4YVqL1zDAAUlQXBpRePzhrwCmt+1I4/rfiZ+IIsu/SX+7oeqFtaVBqzTho8xMKfLktYKI5v7lq90SAt2uEjyh/B3oF3Co5kXneJX4NgQgdFehYI6DjNQzu12Ompvp1myb8OsqnAobuNZlvTLkN9LSNXeU6GgWtj7Y/njnmoR59N1imZ22XG/oQSnAkYynLVkSNOWRm4u1lYKE3t7dC87bC9QJCX1IVXc+giEkxTW/mEj6CBkHEryK17xTTasWkmMV46mQh/EQQSh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syycDIYIzswV9lNmILEP2tKun3bXf+K2hf1maSNosJQ=;
 b=LllBlAkINbWMS99kMu7FMBi4qr1Ogy6BS4hVUFhJkuwmUk7jF/8VMTyP+a35fEnkvPI0hRNJ+gk6TTig9eg9vagKuC4yIuCXPQtlZ6HYRmm01sz9bblgWn34GdHNdBDACRvvVqWbEHI/4fZcCN44uVkRt0LAVjhisTTR2Gok88vv+kdJPOdtl7kpjGVXykG71zcls6XCq9f7mCetRrTwKBft+Jtfx4BV0Fm4DVcbmeah7DIHIfLT7u1Nl4a7bnOigUCvPUDjEKMP1unwFtS8W/f6qiU+/yY8BjvSvnomROPQQGy5vEE9eJX1rOOwyWhvXjwk3jq4H10+FFmxh1e5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 11:40:43 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%2]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 11:40:43 +0000
From:   "Song, Yoong Siang" <yoong.siang.song@intel.com>
To:     "Brouer, Jesper" <brouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "Brouer, Jesper" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH bpf-next V3 5/6] igc: add XDP hints kfuncs for RX
 timestamp
Thread-Topic: [PATCH bpf-next V3 5/6] igc: add XDP hints kfuncs for RX
 timestamp
Thread-Index: AQHZXNeuS7IymFh/rkioE9W/4bejnq8nrPug
Date:   Wed, 12 Apr 2023 11:40:43 +0000
Message-ID: <PH0PR11MB5830A6488CD7AB8AB0C89A42D89B9@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <167950085059.2796265.16405349421776056766.stgit@firesoul>
 <167950089764.2796265.5969267586331535957.stgit@firesoul>
In-Reply-To: <167950089764.2796265.5969267586331535957.stgit@firesoul>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|CO1PR11MB5154:EE_
x-ms-office365-filtering-correlation-id: f92cf011-5cb4-4b29-ae6d-08db3b4abfe9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SKFmDWfgtakT3kUPbX3lP/MxkFGQJ/bS9DyK29inRQ0m5SobrkTEn61vClnzkoz2c2c5f9cm4dZxctFy7e3vDAtvOOp8M7ej5llwweNiz93RxuO5gJcC5ehYvxUm07UAZaDAtWY5l5LHyuyPnmdCiEl+ua4LhwbSRsxAStVtwj+zecfD1QH7idLXhLEJGoEKmuLPDX9D6FCd5uC6LyrACVimTPejqwKWQ/2dH7pv6lxKaYybjSjdE6vi5CnOgu57JVi8ePbjYoN4FZ6fcnwXAw8XPxMnPdetPOF9ebiEdEecuPKySLsLK8l68sbyeD9nGfkvCt9jSMJXxdrBqr5B4a+pFqO/EwzQe8ZyNUmc2aqdqJjL11tkavhhYbEdI98u0bNwBGekhM2nG0OgwgCgulHOIgeZaMBoOj2S8Xc4kg03xOpuSpSbC5DuwU6ZvpZDouiJVhwBH1jizrKgc/iXnZyhqxE+tUPnnDi/YiLgoTf6d6g2G6+F+eTpPVZYiLUXUhfvowUy30TM0HkDpaQP9EiLtgkC9Uff8H98J3R3js88V1MJNVQc4hNG1ZMHN/fQQU9z7Z4ZGnetEppWKCQqJA0sJB82ZQFZqsvgmoWFQ198XMt5r0LH2LaBCbgG21XmB+ak3tZAYYByMQYE25aJFpaWYRpetK+z6VV7vcYEGss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(86362001)(186003)(33656002)(82960400001)(4326008)(55016003)(41300700001)(66446008)(64756008)(55236004)(9686003)(53546011)(316002)(26005)(6506007)(7696005)(71200400001)(83380400001)(478600001)(110136005)(38070700005)(38100700002)(8936002)(8676002)(2906002)(66556008)(76116006)(66476007)(66946007)(122000001)(52536014)(54906003)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTRlWEdva1FGNWxURHhJU0kyTUkyUWs5QkdvOW04d0FPSXIyV3J2Q3k4SXVK?=
 =?utf-8?B?ai9uOVoweldaODJRYytHUHBmbWdRLzdoNGVORTJ2VlUyb2NuNnU3NlA4ekU3?=
 =?utf-8?B?c3k0NzkzUlZkSDN4NWZBdHhmMThyVGRkNzgyQ1FpMkJCOFRXZW9hd1kwcncw?=
 =?utf-8?B?WDd0WVhST2lrK2lrbW16UVpIWEQwQXBacS9sMGJRVmowblNaTzBPYmpEZjI5?=
 =?utf-8?B?eFhoek9yYXJHdjlhbFJsU04veDBGcXl5SFMzSnJGOE5LSUdBRndiZXBadlcv?=
 =?utf-8?B?ZmNncVZwWFVSdlJwUUdvd01iL3JXNG4zWFpPVGtEenZZcHBvdVh6T1FiamRJ?=
 =?utf-8?B?QWFiTERxaVZqOHNPVlFYZlc0TUIrK3grQlpGNTNLOHhXOGdUNzB6WjJVNy9Q?=
 =?utf-8?B?NFVRZkVKZGlHVzNFVFhLR3JZaVVsSCtMdCtRcFRRRkdLZGtpeDhzUG9KNk1H?=
 =?utf-8?B?TWRacXQvUjNqcVhsZjd0NGs5OUlGUjZtZGxNeXBtSFJuR25LcUhLRTZFVmMy?=
 =?utf-8?B?ditiM3M2MXZlRHBNNlNFbDdFNjhOa2p1SGkyRGNSSGI0ZHBoc0V5Z0s0UFdx?=
 =?utf-8?B?YWFhWjg0QkVCYnFVc1RxOTM1TG53RDlzZmV4cjNPSTVIK3cxYjBTSHlPYlhT?=
 =?utf-8?B?bzF5N0lacyt2V1BPVHV4L2lQZlZEaHFvT0gyM1ZCUW9SZmRyLzVVYTJ2SmhG?=
 =?utf-8?B?RmRXMkRZY3M3RDg2a0p6cm1EMXBYaHJHQzFTeEhIZmNjOXZLZnFzdzVydzJr?=
 =?utf-8?B?Vk04WVdlOFV3dWNtV2xMZk5ZcWpHQVUzR0R1T3hvZEtuT3NWV0o3UTNVU3M2?=
 =?utf-8?B?UllFdGVoek1SZC9EQ2lYTFpLT0dROE13bUdsRFIzZzljTExleFRqOENRdE1w?=
 =?utf-8?B?RThuZ0ZZSkkzK1BkOXdIZXE0WkNObFQxM243Sll0SUN3TE52cXBvcFZlckRi?=
 =?utf-8?B?b0JEWlRubzZaazJVSHhDRk42MitvenZGOVpZWmJGS01UQ0Z6N3Q1R28zdVVi?=
 =?utf-8?B?cmE5QWlsWkFUM091cUs0NGQyMmFMWi9JMzRCc0xGK0VPNEMzTUpRUmQyUG1V?=
 =?utf-8?B?THYrVVZMSFRwdFJPbXlXQXV4NlhOR0RmS2JWYUh2RUNpeE9KcDkrVUZBdTF0?=
 =?utf-8?B?ZGJldGE3elVqKzNzTnl2K1RwdmRRTGY0YTV2eE5xd1J3em00ZHRqMkM4Ykls?=
 =?utf-8?B?TCtzUExyL0tGenVFcitOOTMwTXNGTmpUNFlVaFFaK2dyR3lQRFdsd2VGK3B6?=
 =?utf-8?B?am9VeU53QlV5bW5DRUJXcm9TRVVCODVZNE9MaVhucjN6QVZhbWhvZFd0dnRh?=
 =?utf-8?B?R1BvTDMzTlA0YXJNUFkxVGhEay85UXd6VkZTUy8wZlcyRGlVZks1ZVkva3JP?=
 =?utf-8?B?ZzQ2aUpJWXJaYWc4K3YzWXBQelczTWQ3bEhwRmhjaWNEWU1XZ3ovUTQvNGlt?=
 =?utf-8?B?RUVIZ05Bb3lzR1BsR1NNUmpteHlJNXdDYWN1LzFrV0tkcE54NkJCUERRWDdZ?=
 =?utf-8?B?eEMySDBkNzVFb2ZpRFQrdFl2Ni85WmdzUWhLb2YxbEhpS2tGNVhEVlU1TXk4?=
 =?utf-8?B?VStuZDJWamFiT1hwalZmZDV5QWV4SzF1YVBHVjNMYmJmeGMwOUUrd3VhMW54?=
 =?utf-8?B?WGZ2UDBCVXhaakFPK2pETjhrY3AvNUlKRjF2MkZ0eUJwT1k4K3FZQjFCS2Vk?=
 =?utf-8?B?a0w4dmcxWFY3UEFyajFDYmRyMStrdDByUHhoL2Q5a3IxdDVxZkZCakE0WjVv?=
 =?utf-8?B?R2xSbVBFaEdncExZUTZwYmUrcWZlbTk4emNwaXdFWVFvb21QcFJrbjlEWllj?=
 =?utf-8?B?WVhLamtyS0RCY2t0S0hra2xFb3lXLzE3ekVFVkxscnpMR1dWWmh5NFYzekJB?=
 =?utf-8?B?UmRtbFhZNlBwTlRVS3hyVjN6OHJBUzM1VjVNQXlGbFduTkp5ZXMrNnBLaWQ0?=
 =?utf-8?B?VUoyTmtoazV1WHJlbFkzdnFnOXZkcDR0VUJRbHlIVGdlZ1ZUOVdscHltMVlC?=
 =?utf-8?B?RG1LazJKWVFtTUtUUFV5Z3pDdGNHclYyUUNqQTNib3FVdGQ5WFJMcVNrZDFP?=
 =?utf-8?B?Qi9GUG9ReTQwN2hhcCthbmRVZ1Z6QUJvZ2NOTjlNRVlCM0pZSERCT3pTRlNW?=
 =?utf-8?Q?QB4VCpEFnfOGkodDnIcyccLB7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92cf011-5cb4-4b29-ae6d-08db3b4abfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 11:40:43.6303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEWzd9YZ8iRXPwkr/kLq3eFLUezAzWNbQfUZxJxTBVds0O6jYiuQfOiFxG9q/GIpPSjvR/+tqlqC/5E1UQe4eCl127Dt1aA34kkJQF/YpHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5154
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1cnNkYXksIE1hcmNoIDIzLCAyMDIzIDEyOjAyIEFNICwgSmVzcGVyIERhbmdhYXJkIEJy
b3VlciA8YnJvdWVyQHJlZGhhdC5jb20+IHdyb3RlOg0KPlRoZSBOSUMgaGFyZHdhcmUgUlggdGlt
ZXN0YW1waW5nIG1lY2hhbmlzbSBhZGRzIGFuIG9wdGlvbmFsIHRhaWxvcmVkIGhlYWRlcg0KPmJl
Zm9yZSB0aGUgTUFDIGhlYWRlciBjb250YWluaW5nIHBhY2tldCByZWNlcHRpb24gdGltZS4gT3B0
aW9uYWwgZGVwZW5kaW5nIG9uDQo+UlggZGVzY3JpcHRvciBUU0lQIHN0YXR1cyBiaXQgKElHQ19S
WERBRFZfU1RBVF9UU0lQKS4gSW4gY2FzZSB0aGlzIGJpdCBpcyBzZXQNCj5kcml2ZXIgZG9lcyBv
ZmZzZXQgYWRqdXN0bWVudHMgdG8gcGFja2V0IGRhdGEgc3RhcnQgYW5kIGV4dHJhY3RzIHRoZSB0
aW1lc3RhbXAuDQo+DQo+VGhlIHRpbWVzdGFtcCBuZWVkIHRvIGJlIGV4dHJhY3RlZCBiZWZvcmUg
aW52b2tpbmcgdGhlIFhEUCBicGZfcHJvZywgYmVjYXVzZQ0KPnRoaXMgYXJlYSBqdXN0IGJlZm9y
ZSB0aGUgcGFja2V0IGlzIGFsc28gYWNjZXNzaWJsZSBieSBYRFAgdmlhIGRhdGFfbWV0YSBjb250
ZXh0DQo+cG9pbnRlciAoYW5kIGhlbHBlciBicGZfeGRwX2FkanVzdF9tZXRhKS4gVGh1cywgYW4g
WERQIGJwZl9wcm9nIGNhbiBwb3RlbnRpYWxseQ0KPm92ZXJ3cml0ZSB0aGlzIGFuZCBjb3JydXB0
IGRhdGEgdGhhdCB3ZSB3YW50IHRvIGV4dHJhY3Qgd2l0aCB0aGUgbmV3IGtmdW5jIGZvcg0KPnJl
YWRpbmcgdGhlIHRpbWVzdGFtcC4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBKZXNwZXIgRGFuZ2FhcmQg
QnJvdWVyIDxicm91ZXJAcmVkaGF0LmNvbT4NCj4tLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWdjL2lnYy5oICAgICAgfCAgICAxICsNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWdjL2lnY19tYWluLmMgfCAgIDIwICsrKysrKysrKysrKysrKysrKysrDQo+IDIgZmlsZXMg
Y2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZ2MvaWdjLmgNCj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ln
Yy9pZ2MuaA0KPmluZGV4IGJjNjdhNTJlNDdlOC4uMjk5NDE3MzRmMWExIDEwMDY0NA0KPi0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaA0KPisrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaA0KPkBAIC01MDMsNiArNTAzLDcgQEAgc3RydWN0IGln
Y19yeF9idWZmZXIgeyAgc3RydWN0IGlnY194ZHBfYnVmZiB7DQo+IAlzdHJ1Y3QgeGRwX2J1ZmYg
eGRwOw0KPiAJdW5pb24gaWdjX2Fkdl9yeF9kZXNjICpyeF9kZXNjOw0KPisJa3RpbWVfdCByeF90
czsgLyogZGF0YSBpbmRpY2F0aW9uIGJpdCBJR0NfUlhEQURWX1NUQVRfVFNJUCAqLw0KPiB9Ow0K
Pg0KPiBzdHJ1Y3QgaWdjX3FfdmVjdG9yIHsNCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2lnYy9pZ2NfbWFpbi5jDQo+aW5kZXggYTc4ZDdlNmJjZmQ2Li5mNjYyODVjODU0NDQgMTAwNjQ0
DQo+LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4rKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPkBAIC0yNTM5LDYg
KzI1MzksNyBAQCBzdGF0aWMgaW50IGlnY19jbGVhbl9yeF9pcnEoc3RydWN0IGlnY19xX3ZlY3Rv
cg0KPipxX3ZlY3RvciwgY29uc3QgaW50IGJ1ZGdldCkNCj4gCQlpZiAoaWdjX3Rlc3Rfc3RhdGVy
cihyeF9kZXNjLCBJR0NfUlhEQURWX1NUQVRfVFNJUCkpIHsNCj4gCQkJdGltZXN0YW1wID0gaWdj
X3B0cF9yeF9wa3RzdGFtcChxX3ZlY3Rvci0+YWRhcHRlciwNCj4gCQkJCQkJCXBrdGJ1Zik7DQo+
KwkJCWN0eC5yeF90cyA9IHRpbWVzdGFtcDsNCj4gCQkJcGt0X29mZnNldCA9IElHQ19UU19IRFJf
TEVOOw0KPiAJCQlzaXplIC09IElHQ19UU19IRFJfTEVOOw0KPiAJCX0NCj5AQCAtMjcyNyw2ICsy
NzI4LDcgQEAgc3RhdGljIGludCBpZ2NfY2xlYW5fcnhfaXJxX3pjKHN0cnVjdCBpZ2NfcV92ZWN0
b3INCj4qcV92ZWN0b3IsIGNvbnN0IGludCBidWRnZXQpDQo+IAkJaWYgKGlnY190ZXN0X3N0YXRl
cnIoZGVzYywgSUdDX1JYREFEVl9TVEFUX1RTSVApKSB7DQo+IAkJCXRpbWVzdGFtcCA9IGlnY19w
dHBfcnhfcGt0c3RhbXAocV92ZWN0b3ItPmFkYXB0ZXIsDQo+IAkJCQkJCQliaS0+eGRwLT5kYXRh
KTsNCj4rCQkJY3R4LT5yeF90cyA9IHRpbWVzdGFtcDsNCj4NCj4gCQkJYmktPnhkcC0+ZGF0YSAr
PSBJR0NfVFNfSERSX0xFTjsNCj4NCj5AQCAtNjQ4MSw2ICs2NDgzLDIzIEBAIHUzMiBpZ2NfcmQz
MihzdHJ1Y3QgaWdjX2h3ICpodywgdTMyIHJlZykNCj4gCXJldHVybiB2YWx1ZTsNCj4gfQ0KPg0K
PitzdGF0aWMgaW50IGlnY194ZHBfcnhfdGltZXN0YW1wKGNvbnN0IHN0cnVjdCB4ZHBfbWQgKl9j
dHgsIHU2NA0KPisqdGltZXN0YW1wKSB7DQo+Kwljb25zdCBzdHJ1Y3QgaWdjX3hkcF9idWZmICpj
dHggPSAodm9pZCAqKV9jdHg7DQo+Kw0KPisJaWYgKGlnY190ZXN0X3N0YXRlcnIoY3R4LT5yeF9k
ZXNjLCBJR0NfUlhEQURWX1NUQVRfVFNJUCkpIHsNCj4rCQkqdGltZXN0YW1wID0gY3R4LT5yeF90
czsNCj4rDQo+KwkJcmV0dXJuIDA7DQo+Kwl9DQo+Kw0KPisJcmV0dXJuIC1FTk9EQVRBOw0KPit9
DQo+Kw0KPitjb25zdCBzdHJ1Y3QgeGRwX21ldGFkYXRhX29wcyBpZ2NfeGRwX21ldGFkYXRhX29w
cyA9IHsNCg0KSGkgSmVzcGVyLA0KDQpTaW5jZSBpZ2NfeGRwX21ldGFkYXRhX29wcyBpcyB1c2Vk
IG9uIGlnY19tYWluLmMgb25seSwgd2UgY2FuIG1ha2UNCml0IHN0YXRpYyB0byBhdm9pZCBmb2xs
b3dpbmcgYnVpbGQgd2FybmluZzoNCg0KZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2ln
Y19tYWluLmM6NjQ5OTozMTogd2FybmluZzogc3ltYm9sDQonaWdjX3hkcF9tZXRhZGF0YV9vcHMn
IHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQoNClRoYW5rcyAmIFJlZ2Fy
ZHMNClNpYW5nDQoNCj4rCS54bW9fcnhfdGltZXN0YW1wCQk9IGlnY194ZHBfcnhfdGltZXN0YW1w
LA0KPit9Ow0KPisNCj4gLyoqDQo+ICAqIGlnY19wcm9iZSAtIERldmljZSBJbml0aWFsaXphdGlv
biBSb3V0aW5lDQo+ICAqIEBwZGV2OiBQQ0kgZGV2aWNlIGluZm9ybWF0aW9uIHN0cnVjdCBAQCAt
NjU1NCw2ICs2NTczLDcgQEAgc3RhdGljIGludA0KPmlnY19wcm9iZShzdHJ1Y3QgcGNpX2RldiAq
cGRldiwNCj4gCWh3LT5od19hZGRyID0gYWRhcHRlci0+aW9fYWRkcjsNCj4NCj4gCW5ldGRldi0+
bmV0ZGV2X29wcyA9ICZpZ2NfbmV0ZGV2X29wczsNCj4rCW5ldGRldi0+eGRwX21ldGFkYXRhX29w
cyA9ICZpZ2NfeGRwX21ldGFkYXRhX29wczsNCj4gCWlnY19ldGh0b29sX3NldF9vcHMobmV0ZGV2
KTsNCj4gCW5ldGRldi0+d2F0Y2hkb2dfdGltZW8gPSA1ICogSFo7DQo+DQo+DQoNCg==

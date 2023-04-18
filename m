Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB82D6E5801
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 06:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDREQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 00:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDREQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 00:16:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9153A46A0
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 21:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681791399; x=1713327399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gzHc+AtOj68j5SRgh0TLDmhOEDsB5xFzJhExtgN/ugU=;
  b=dbInT048cJ1PFyVfLcb4JNUlRiG37c6m/PoHlOyXse7d4G6PBmbQjCqt
   1iGe+KzQwVF/CtcBH70zyrMNMYXWwZ39LMj08TCCyHWNjF6HqcTVfRcMi
   R8n7gTNJrLgl8jt4stAPtFT2n37/+UShvWCtmcs5Pa7Yb6O+oIaOuNwnJ
   b8oRdP4qTjDdrI2kldXhFDuGS0NTg9HqAVrnwbgnXQ+8BMNxEX1uh8qwV
   6dnetcwLWH559gRp5dxMovbYUGLJFBA/nSpXqYqsDs5q0cxh277eqHPyw
   SD1hoJVpqJlYuEq9xYGl1ePIsA2brqbjXZDCnvbW0K8C3M4ubgm+C8Hmv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="325409530"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="325409530"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 21:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="780363485"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="780363485"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2023 21:16:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 21:16:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 21:16:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 21:16:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWsWqPuZpbhIQEGr8HQsP49WP8ynYoyPRdF7eIcw8O9h+l9ge6jCw9pnvEBWi+7dWA7DNWH9Uvk+iTNJGUhDh5yurLCsQWTGbHp7jTPDl99Viv+Z5QsONg7sTBIJ3fFOMnpJ3Jzt8Z0gIA2J1jI/qLrISN71rDkSrfoBii+hCRzh16zEHBq8sby8NCbndsaSySx/QLuuFH5YJt2mnB6vVdWdJrH86kJJZy9CyUgHhe4uACt55fK9oSf7oU3hez7jHpAB+Jta1QaELRO/nXLZq8gY9r6NX3jK5PQgUXv346jTTzcCEl4UrmpgGsySi4BX/18FQ57fM6Dp91UhgizUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzHc+AtOj68j5SRgh0TLDmhOEDsB5xFzJhExtgN/ugU=;
 b=oO9iuZSzVCq5H5f+wSkqsjwjSCgCRL3tqcMpvmrVSQF9NicRbc/Sp4CZiCEXS21aVKDsZSgKIq+SxPWi7fOorR8k6GqKtFKlBdb0SUxu4fMhY9AEbhlN5/URB4Hp5u/PuCB8nEcdXsu2pDgMDjbjYVWDsh2mHlPFKwY4o0SYjom1J7FxGTBxL9eznQfxyi/czyNtqUxkvW462ItKatYgj4RQAjSOGqMYyeyxiyha0BvYQBTuWkSCUeLQd3HDht3VjOiQa9L2UzZORoqtPKJXZfVSPDijITKbSAG0IEgFVp9FuUHYxnWprooBvxxYDEZFTPTcgp/wIUubaIXGIiHkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SJ2PR11MB7502.namprd11.prod.outlook.com (2603:10b6:a03:4d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 04:16:00 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 04:16:00 +0000
From:   "Song, Yoong Siang" <yoong.siang.song@intel.com>
To:     "Brouer, Jesper" <brouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
CC:     "Brouer, Jesper" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [xdp-hints] [PATCH bpf-next V1 3/5] igc: add XDP hints kfuncs for
 RX timestamp
Thread-Topic: [xdp-hints] [PATCH bpf-next V1 3/5] igc: add XDP hints kfuncs
 for RX timestamp
Thread-Index: AQHZcTz2BbWXLatjdkK2Zh0AJYDmgK8wdUYQ
Date:   Tue, 18 Apr 2023 04:16:00 +0000
Message-ID: <PH0PR11MB5830F70FAC28BDBDE63AF01DD89D9@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <168174338054.593471.8312147519616671551.stgit@firesoul>
 <168174343801.593471.10686331901576935015.stgit@firesoul>
In-Reply-To: <168174343801.593471.10686331901576935015.stgit@firesoul>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SJ2PR11MB7502:EE_
x-ms-office365-filtering-correlation-id: e1b18f11-ac86-4a24-0f02-08db3fc39dbe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsEkWRPuL75h+ehy7w3j/pv4fO+NoHry3isODx6SSPcxzQ2M0cazmE2QKd8whONgfKu8ju1LK8kVCUe3dw0CO9wWgsc1PJEjUf9WAkt053nUDoYkjL1ajka+kFbxzXPz9oVPoRYx+9Srb+yvwDausb6M1Dx25uqHEWLsGIPNMrMcGx8w8LGdHq2DCF9PqvWisNvMnEGBGwclhsoZpGwo6WFXjy+4Kuz1SrfEnZozaPa2Wjm01HnnRlk/SCCbVL+7kd1jLP/HPKcjm+ob7LWW57oLaCF1G9ajWAx+PGEoY5/HB2/BVArmaUbiA1zXgHk7q8uDe+XaVNRjKBqWvPi6Ge8IzhxRUNthEJTLyCNu4DX6eX4GG2AAJq0iDD3NWXXJjGkodW5rIUZpglQVsjRiM4BkxKHu48OjpuPpTuso1qlrJw5bklrE+NtIk+4F6JA61jH/d60Nkd3L/hjH2Y6eDK+cADug4hOT6zpBeUm9R8R23k1iM9FLD6BMDhYFuTX2n6pNfywKWw02qILJ9F4Li/VUpwH0WqNy3yhC/SCYC9ADtPj0sbo34zco1lC2pQ318WVQLVjs/BR+SMuVCYBqW/ACuNrM03syROpSQ014ImXHdUKm4HQ860tPQu/XhfOy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(38070700005)(8936002)(8676002)(41300700001)(82960400001)(122000001)(52536014)(7416002)(38100700002)(5660300002)(33656002)(86362001)(55016003)(478600001)(54906003)(110136005)(55236004)(9686003)(6506007)(26005)(71200400001)(186003)(7696005)(53546011)(76116006)(4326008)(83380400001)(316002)(66946007)(66556008)(66476007)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q21GOStjaWgrMkRQZUwyeldkSFJ6VW4zRGJVeFpGMFhlRVRnTmtLbTR5MkY5?=
 =?utf-8?B?Mk9EdG1Vcy94dTBDMG0yUFJualJkTXJobkFQUnAwTWd0TmYrc3Z4ZHhtNVVK?=
 =?utf-8?B?NG5JZFdjWVh0aThtMlNiTEtkbXE4Y1lpRVM4aCtFM2N6Z3VlOWZnazVPNXcz?=
 =?utf-8?B?bUdmbXBWUFVhNzFPRE8vVmN0YlRXUkFxK29iQ2V2MEtuUzZFNGNHKzNpbjRp?=
 =?utf-8?B?RmVnOVV5U01ReGtKY1VSZU5pQi9jYjF5NjBWalIrT3grS3R0RDhHblNrVnBK?=
 =?utf-8?B?Z1hxWTJBK1M4L2IxU1FEMEZZT2RZNm9VWGRJRm1DZ0ZFU011dnlFV1pkWTZB?=
 =?utf-8?B?S25zRmNMNkNCUmwxVTc5NUYrYXI3dWl1SGR4ZFo0MmdONjduQzRzbTNRanls?=
 =?utf-8?B?NU9reTBCaWhWNXR0T3p1VWZPYTF5a1dUQU9qVk5vQ2YzKzJkbnNDUXhHM1Zh?=
 =?utf-8?B?d2ZjdStSSU1tbjA2VzVrb1p3ejVBdm1jQlZHS2hjQ3hjbWxOMWtueGY2akto?=
 =?utf-8?B?ZUpvRFNzMWVSQ2tscVBKcmRsVkNMMTJKUHZQMFRkOWhaNUNrNWRTNkxnS1BO?=
 =?utf-8?B?dUNBQ0RGUTVzOFFoK0RPWW5pbTJSUWFGY3NYNDZXT1BFT0t0UzF4K2lhZHhh?=
 =?utf-8?B?d3I2Vm02aEFIUGQzWERMS3BnbitiMHFVaUFOMHZoTmpSK0h2YU1Bd1NhbllZ?=
 =?utf-8?B?c2lySUpPd1VJajNDeXJlRGZKUGNqOHZDNGx5VXhhSUs0YnluZndFdHozRVJv?=
 =?utf-8?B?bHkwVm9QSnlIL3lSUjJXd0FHTVF6TFl0ZnNSUCtvaW9ZMnl2TnpQMk12SnhP?=
 =?utf-8?B?OUNCdDFuV1ZuYUF0UXROc05FQmNYQ01GUlRkR0VRTWdNMU1ScUwyOVpnNW03?=
 =?utf-8?B?cENqUXYzNTRhMWN6NFBIZ3dpUTEzelgwa1hGWjN0aDdxYmlmZ2RYek1XSlJ6?=
 =?utf-8?B?T2hDSEovK2NTNVAzeXJSNzN0blVlVERaTERRcTQyeVAycHIxTVlnWS9jVE9O?=
 =?utf-8?B?aTNBdTdCanlaeStGZ1hDaFdiQWZLUmtXaWVheWhDdGIrT2w4cXVzT1Jadyty?=
 =?utf-8?B?bXVVb0ZyMGljdlltQzRwMWN1akFFeXNLMGw2ZWx3QzNMTDlncE5lZVlQSTFV?=
 =?utf-8?B?QTh1YkVHNjhXZ1EvTWg3dHduQzdDenhKdHAxeFp1UnAzOWo5bHprMHNhU1k4?=
 =?utf-8?B?VkdwUFhLT1hUbkY0NTdzYXpmaHptcVhIZ0VUbS9RS25raHJhVE40VjYwdzdw?=
 =?utf-8?B?Y0dsUTNQc3REUHhUdWJ0Z2luS2tEb1EvZDhueEpDZlJIK2dGV0FOZ1AzcHEz?=
 =?utf-8?B?aWF3cVZtZjFUN3JKQzlvQzhKenRNREhmTU1Vc1JJOUFHNHZQOEk5MEcrazhV?=
 =?utf-8?B?d0ZIRUZ6anJDNkw2NDNQMUJMNjJNMlFNSFFWNkMyUXZrV0h0cmttRFNIZm1x?=
 =?utf-8?B?ZEVQQmhraXJ4em1YU09qVFdSQ2d4aWVEYzJRZWJYVHh4dVo1R2o5N0lweTZ6?=
 =?utf-8?B?NDNHWGM5V0tER0NWcWNyMWZYUzROOGRMeWlUUUU0b25xaGtjUG9KWEpVV0RN?=
 =?utf-8?B?RG1xTEtheEZua3ZZNUUweWVEdFNsbE94c1RsKzVNaVlmV0JnTEMxSzR0RzhB?=
 =?utf-8?B?WTR0eGdmMS9pLytjckIvSEJGQ2xoblZKcFpvcWJKb2VBOW9Yd20zSkQvdHZa?=
 =?utf-8?B?WW9rTE1jOEo2WE8vRi9wWmgrRCsySDJkZG9pQ0JtT3pPY1lMZDdDOGMrcFQy?=
 =?utf-8?B?cXdzVnhVNXVrRXA4ZFdadVBVbU5Pbmtqek0wTDkrUUN4NTZ5OEg4SkZVSjFT?=
 =?utf-8?B?UGN5VnRDN05MTG5iQnJwR0dRNmxBRlNhNGVCVlo4cjNFaHJWMml2ZmZIbFBy?=
 =?utf-8?B?NGliNWFwby9aNEQ3SndEMlVGWnR0NGo5VEF3Y01ORHRyTFJCWEVqc3FlYnRs?=
 =?utf-8?B?NkVzNis5eTA5QW91Q2pmMC82UWpWRHFNVW9CWnJtWDdmQW9NT0EvL1JOcFRU?=
 =?utf-8?B?YWlXMHc4RkVpSW5OMDJXVUYzUm1uSlV5cjZzTHdsSlJUdDE3NmV5MlpOMXRr?=
 =?utf-8?B?bXJRT3dHMEdWUkJCSVh3MUFMOUtsVHI4VGNjYTB6U0NxdHRCSE9CUWFBcEsr?=
 =?utf-8?B?Nks4T244K0hPRmVWTTR1WFVtcW5jY3BwcnpRSVFWcFNpZ1lUM1ROTmhyOGU1?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b18f11-ac86-4a24-0f02-08db3fc39dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 04:16:00.0580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xDqYfbmjX4vt5uRkXVaPPt8BVevIbnWbq86xIXNdDMBjVrBJKdU1zcLRCOiFNlZh4skXZwrcVevBd9N1bL1ZkOsw332CGv89G/jaJo/vPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7502
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uZGF5LCBBcHJpbCAxNywgMjAyMyAxMDo1NyBQTSwgSmVzcGVyIERhbmdhYXJkIEJyb3Vl
ciA8YnJvdWVyQHJlZGhhdC5jb20+IHdyb3RlOg0KPlRoZSBOSUMgaGFyZHdhcmUgUlggdGltZXN0
YW1waW5nIG1lY2hhbmlzbSBhZGRzIGFuIG9wdGlvbmFsIHRhaWxvcmVkIGhlYWRlcg0KPmJlZm9y
ZSB0aGUgTUFDIGhlYWRlciBjb250YWluaW5nIHBhY2tldCByZWNlcHRpb24gdGltZS4gT3B0aW9u
YWwgZGVwZW5kaW5nIG9uDQo+UlggZGVzY3JpcHRvciBUU0lQIHN0YXR1cyBiaXQgKElHQ19SWERB
RFZfU1RBVF9UU0lQKS4gSW4gY2FzZSB0aGlzIGJpdCBpcyBzZXQNCj5kcml2ZXIgZG9lcyBvZmZz
ZXQgYWRqdXN0bWVudHMgdG8gcGFja2V0IGRhdGEgc3RhcnQgYW5kIGV4dHJhY3RzIHRoZSB0aW1l
c3RhbXAuDQo+DQo+VGhlIHRpbWVzdGFtcCBuZWVkIHRvIGJlIGV4dHJhY3RlZCBiZWZvcmUgaW52
b2tpbmcgdGhlIFhEUCBicGZfcHJvZywgYmVjYXVzZQ0KPnRoaXMgYXJlYSBqdXN0IGJlZm9yZSB0
aGUgcGFja2V0IGlzIGFsc28gYWNjZXNzaWJsZSBieSBYRFAgdmlhIGRhdGFfbWV0YSBjb250ZXh0
DQo+cG9pbnRlciAoYW5kIGhlbHBlciBicGZfeGRwX2FkanVzdF9tZXRhKS4gVGh1cywgYW4gWERQ
IGJwZl9wcm9nIGNhbiBwb3RlbnRpYWxseQ0KPm92ZXJ3cml0ZSB0aGlzIGFuZCBjb3JydXB0IGRh
dGEgdGhhdCB3ZSB3YW50IHRvIGV4dHJhY3Qgd2l0aCB0aGUgbmV3IGtmdW5jIGZvcg0KPnJlYWRp
bmcgdGhlIHRpbWVzdGFtcC4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBKZXNwZXIgRGFuZ2FhcmQgQnJv
dWVyIDxicm91ZXJAcmVkaGF0LmNvbT4NCj4tLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWdjL2lnYy5oICAgICAgfCAgICAxICsNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwv
aWdjL2lnY19tYWluLmMgfCAgIDIwICsrKysrKysrKysrKysrKysrKysrDQo+IDIgZmlsZXMgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pZ2MvaWdjLmgNCj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9p
Z2MuaA0KPmluZGV4IGM2MDlhMmU2NDhmOC4uMThkNGFmOTM0ZDhjIDEwMDY0NA0KPi0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2MuaA0KPisrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2lnYy9pZ2MuaA0KPkBAIC01MDMsNiArNTAzLDcgQEAgc3RydWN0IGlnY19y
eF9idWZmZXIgeyAgc3RydWN0IGlnY194ZHBfYnVmZiB7DQo+IAlzdHJ1Y3QgeGRwX2J1ZmYgeGRw
Ow0KPiAJdW5pb24gaWdjX2Fkdl9yeF9kZXNjICpyeF9kZXNjOw0KPisJa3RpbWVfdCByeF90czsg
LyogZGF0YSBpbmRpY2F0aW9uIGJpdCBJR0NfUlhEQURWX1NUQVRfVFNJUCAqLw0KPiB9Ow0KPg0K
PiBzdHJ1Y3QgaWdjX3FfdmVjdG9yIHsNCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ln
Yy9pZ2NfbWFpbi5jDQo+aW5kZXggM2E4NDRjZjViZTNmLi44NjI3NjhkNWQxMzQgMTAwNjQ0DQo+
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4rKysgYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPkBAIC0yNTUyLDYgKzI1
NTIsNyBAQCBzdGF0aWMgaW50IGlnY19jbGVhbl9yeF9pcnEoc3RydWN0IGlnY19xX3ZlY3RvciAq
cV92ZWN0b3IsIGNvbnN0IGludCBidWRnZXQpDQo+IAkJaWYgKGlnY190ZXN0X3N0YXRlcnIocnhf
ZGVzYywgSUdDX1JYREFEVl9TVEFUX1RTSVApKSB7DQo+IAkJCXRpbWVzdGFtcCA9IGlnY19wdHBf
cnhfcGt0c3RhbXAocV92ZWN0b3ItPmFkYXB0ZXIsDQo+IAkJCQkJCQlwa3RidWYpOw0KPisJCQlj
dHgucnhfdHMgPSB0aW1lc3RhbXA7DQo+IAkJCXBrdF9vZmZzZXQgPSBJR0NfVFNfSERSX0xFTjsN
Cj4gCQkJc2l6ZSAtPSBJR0NfVFNfSERSX0xFTjsNCj4gCQl9DQo+QEAgLTI3NDAsNiArMjc0MSw3
IEBAIHN0YXRpYyBpbnQgaWdjX2NsZWFuX3J4X2lycV96YyhzdHJ1Y3QgaWdjX3FfdmVjdG9yICpx
X3ZlY3RvciwgY29uc3QgaW50IGJ1ZGdldCkNCj4gCQlpZiAoaWdjX3Rlc3Rfc3RhdGVycihkZXNj
LCBJR0NfUlhEQURWX1NUQVRfVFNJUCkpIHsNCj4gCQkJdGltZXN0YW1wID0gaWdjX3B0cF9yeF9w
a3RzdGFtcChxX3ZlY3Rvci0+YWRhcHRlciwNCj4gCQkJCQkJCWJpLT54ZHAtPmRhdGEpOw0KPisJ
CQljdHgtPnJ4X3RzID0gdGltZXN0YW1wOw0KPg0KPiAJCQliaS0+eGRwLT5kYXRhICs9IElHQ19U
U19IRFJfTEVOOw0KPg0KPkBAIC02NDkyLDYgKzY0OTQsMjMgQEAgdTMyIGlnY19yZDMyKHN0cnVj
dCBpZ2NfaHcgKmh3LCB1MzIgcmVnKQ0KPiAJcmV0dXJuIHZhbHVlOw0KPiB9DQo+DQo+K3N0YXRp
YyBpbnQgaWdjX3hkcF9yeF90aW1lc3RhbXAoY29uc3Qgc3RydWN0IHhkcF9tZCAqX2N0eCwgdTY0
ICp0aW1lc3RhbXApIHsNCj4rCWNvbnN0IHN0cnVjdCBpZ2NfeGRwX2J1ZmYgKmN0eCA9ICh2b2lk
ICopX2N0eDsNCj4rDQo+KwlpZiAoaWdjX3Rlc3Rfc3RhdGVycihjdHgtPnJ4X2Rlc2MsIElHQ19S
WERBRFZfU1RBVF9UU0lQKSkgew0KPisJCSp0aW1lc3RhbXAgPSBjdHgtPnJ4X3RzOw0KPisNCj4r
CQlyZXR1cm4gMDsNCj4rCX0NCj4rDQo+KwlyZXR1cm4gLUVOT0RBVEE7DQo+K30NCj4rDQo+K2Nv
bnN0IHN0cnVjdCB4ZHBfbWV0YWRhdGFfb3BzIGlnY194ZHBfbWV0YWRhdGFfb3BzID0gew0KDQpT
aW5jZSBpZ2NfeGRwX21ldGFkYXRhX29wcyBpcyB1c2VkIGluIGlnY19tYWluLmMgb25seSwgc3Vn
Z2VzdCB0byBtYWtlIGl0IHN0YXRpYy4NCg0KVGhhbmtzICYgUmVnYXJkcw0KU2lhbmcNCg0KPisJ
Lnhtb19yeF90aW1lc3RhbXAJCT0gaWdjX3hkcF9yeF90aW1lc3RhbXAsDQo+K307DQo+Kw0KPiAv
KioNCj4gICogaWdjX3Byb2JlIC0gRGV2aWNlIEluaXRpYWxpemF0aW9uIFJvdXRpbmUNCj4gICog
QHBkZXY6IFBDSSBkZXZpY2UgaW5mb3JtYXRpb24gc3RydWN0DQo+QEAgLTY1NjUsNiArNjU4NCw3
IEBAIHN0YXRpYyBpbnQgaWdjX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiAJaHctPmh3
X2FkZHIgPSBhZGFwdGVyLT5pb19hZGRyOw0KPg0KPiAJbmV0ZGV2LT5uZXRkZXZfb3BzID0gJmln
Y19uZXRkZXZfb3BzOw0KPisJbmV0ZGV2LT54ZHBfbWV0YWRhdGFfb3BzID0gJmlnY194ZHBfbWV0
YWRhdGFfb3BzOw0KPiAJaWdjX2V0aHRvb2xfc2V0X29wcyhuZXRkZXYpOw0KPiAJbmV0ZGV2LT53
YXRjaGRvZ190aW1lbyA9IDUgKiBIWjsNCj4NCj4NCg0K

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E92354849
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 23:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241342AbhDEVtp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 17:49:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:10445 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237567AbhDEVto (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 17:49:44 -0400
IronPort-SDR: ZbWi64Hx3nNmrkhjXRjvLoCvxSsvd0S4uAdEPTHHFGUgjfzjZN1LrVM7Sq0Z30Ue1e7bWAFOMT
 cOUWHI5JsprA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="189713118"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="189713118"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:37 -0700
IronPort-SDR: yvZ+YWfK9l0bMoQwFneL14E1pp7MDBcjkljzpe7uxyTUxxss/i1bLtiJsl8J49Kx7FpsAuHnyP
 5rWpFiR0cdIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="457569808"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2021 14:49:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Apr 2021 14:49:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 5 Apr 2021 14:49:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 5 Apr 2021 14:49:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwz4p0u+iF+JhoxzDueHRizcPGDabkeID0i80NRTmAx0CP9PJStDXuoJxaxJHxfvArHj5CXZMZcB3qCJ067O4uv7lGatvOIdU3Z4T1JLz0tde85VodXn3byr6TxE/18sdBwruNlPKuq/iN8cuUtFWIiAkqrpWkScAkUvuVZYee6oUQLOW97X8hoZUnP4PNktXpa3t+fmZXmaN4WZUAOHV9G5WzNmWmewyF7R05wsV/j9OO+T5zlDyreMSXNPnpXCw4N4Dy0tHx+bFt7hNKBJl6TQOOAUrqep0xELrC8TMEv0FQ9iiuoEP6MtfaL4nTD/PogF23+fRQvxzIiyDGks5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeHMZ1Zkh27JqCe5wIFtZ2ZagopTmA3IHhYhcmgy9IY=;
 b=F7bMIwvWqvVmgCgn/21UWQIky1PVKrdDcxm8+p0vM0k7GX/4ZCtfSWR81KMCIdg0IyEpsui6tlO7VkAnlDBm+DPBLzDR+yGAKq6jF7I9HcX4xHxdWa2l3u/k9IfgHFWdP6jRnbmTL1hbTCcXCJGam0MVv7x4hxWIryi7lkmKjsVgE+NDBJWmbqQ84aGvYjDV25yOKUbIM2dKVM7nhH/TQ9JF53mpoNXdd9lKLDVibyOkq9YoIDEJHc4ACJMvKCsiYP1IR/3axaoisqtfEBiQAWl5vp6LfUIe9el1oJmo7jzUv7Q1XYVeDTf+D1dguMRZtWK94wFj72FMbTMqxk3SWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeHMZ1Zkh27JqCe5wIFtZ2ZagopTmA3IHhYhcmgy9IY=;
 b=ASEveZ3FeS1rdvoRHVynokAhhcImqE5abzDaYTBHXr5jIlKf5In4OoTTSRVfbUwKPPSZuYqU+CvBTxtMlIgWkueZ1umDtoLOtkpx657U0H0VOyk9XWpp775X+Qew3v8CUHwkxuDHeZ31inQLL+dDx93r6LJUSJCeuVuvpV6s8q8=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 21:49:30 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::cd24:a9b7:365a:9a4b]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::cd24:a9b7:365a:9a4b%7]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 21:49:30 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "willy@infradead.org" <willy@infradead.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [RFC 2/3] vmalloc: Support grouped page allocations
Thread-Topic: [RFC 2/3] vmalloc: Support grouped page allocations
Thread-Index: AQHXKlwTWbZ5r45W4Eav1hIQzLwkw6qmaRwAgAAIngCAAASpgA==
Date:   Mon, 5 Apr 2021 21:49:29 +0000
Message-ID: <5cd26497530f153b0356f72ee016362e8db884cc.camel@intel.com>
References: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
         <20210405203711.1095940-3-rick.p.edgecombe@intel.com>
         <971aae01-32a0-3f45-1810-010e3295b1c4@intel.com>
         <20210405213248.GN2531743@casper.infradead.org>
In-Reply-To: <20210405213248.GN2531743@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 734d723b-a0e1-4431-35ea-08d8f87cb0e7
x-ms-traffictypediagnostic: SA2PR11MB4844:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB4844887AC478CF443B591069C9779@SA2PR11MB4844.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O1KHE1x8GAL7VBg6qjFs2vMyLGUPwww6FPnuhHBwUJ6//n4mXOhvYBCOtDZjY76DzNcGIjY8OFqZl+dDHwMKSCSwJQaPTR6Ra4/WDSpc423DNJbENCFJwuQxFM9Cqju2Mdkrgq4B8ETDHh3SkW8IpVL/hc+nlXO7NRpFb8uvUGY6A/7ehXnrm/vEFCoGYYbIHoZHzULpjIjv1oevjd55YU1loLLPbtPhsbL7/wCmsD1yXnBcP3AL2wIrZ+gDl+DFmFSQDoYgEpH6uk4l0AWOFju6JNzW1F5P0y3uzEa0mOSzBh8FZn2gQVoco2gp9W2wZ9BaqvPvL4cm/wmS5JS9iAwZfG2g2jPnPFId/WZI6e42EmclWQfS4z1aa30uAdW9HQ8UvqO3D4anwABER4GoC69LXYKyJvj/+W0pJYJ3A1k0guLw5Ylp5n7Vb/SMa4JvCQsVJwq0yEc2gLR6uOAnHAU1R5qra7kKwvyBdwZO8jl1xzhEMJmnsu3rki0LtE4Z/xK6g/QVmBtzDIscfVniMQ8qTivMVo8NV2ZDkm1n/7aSF2avyanD3dKbQnFJdiSJ5ZdNVF363wIc/HNjFKUWpmDnb+JzLXPQoIW0H9bruMaRfCS5tzIojMTQBJJhwmNuZ+MPG+cnC5D6yd99cVo7iks3/5AJ1VcgoAl6HHfoR/4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(7416002)(38100700001)(4326008)(2906002)(26005)(36756003)(53546011)(8936002)(316002)(2616005)(5660300002)(6486002)(110136005)(76116006)(71200400001)(86362001)(83380400001)(66446008)(64756008)(66556008)(6636002)(66946007)(66476007)(478600001)(6506007)(54906003)(6512007)(91956017)(8676002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SCtIV3VCWGJNc3hyNXI1YnVqeEJrZHZBck1LRWZZNU9UUDZnN3VWbklzRkM1?=
 =?utf-8?B?NkI4cWVnQ3V0N3ordnNvREdEOWh5TW44aC95UlQ3dXBENVVzZW9UbEk5YlFy?=
 =?utf-8?B?aFFHcENpT1Q0YVJqR2Uvd1U2bTY0WitpRHpMdG9Cc2VITll1Zzhhd2lXc0ZJ?=
 =?utf-8?B?Z2ZjQUZoRFZNWnBubjQrcFcrdlF3NTZDNi9JOUFLYVdsNW04bGtjK21LMEdW?=
 =?utf-8?B?TXZrVkg1OXNZMFl2Q3J1RmlyaWdJNG54VkpqT0J3VVNVUUpKRVU5Q0FUVzRm?=
 =?utf-8?B?NDhNSFh1N2lSekZqcUwvaTdBQU1ab3U0ZFBvZ0dHangrMFhsN2FORHZZKytx?=
 =?utf-8?B?dVJYK3JvMUVLQy9Wd3IvMEQxTEE2VXBlRTFEWERMMVZER3greEduUTdkQ2J1?=
 =?utf-8?B?bHlVayt4Kzc4YVQvMzFiVDVaNUlFU2FKTXhxWjI5NHQ4UW1Rb0txa1ErR21C?=
 =?utf-8?B?R1JTTkV5SEx1dFpUMTBLTkUzdEoyOXhUTmV6UnZHQitQTkpCU0ZHSm5TMDc1?=
 =?utf-8?B?WVdjMlJVOUc2QVZTc08rd3RCMWJrcGtJb0t4cnVXVmk3bzJJTGhZNU1GNGEy?=
 =?utf-8?B?NjNIenZMYUpGMVQwNlhiWERQbTEzc2owWVkrZ0lDekNqUnlIMzNVeVAyeEQ3?=
 =?utf-8?B?ejllNlVnZHA3dTYwYytldjc1YUMzK3JtWndMUmp4c0RrVG1FL0NQTDJqK2RF?=
 =?utf-8?B?dE14MWxHZHFsZHo1aGR1VHRxeFQ0QU5PMnNlU0ZZbEswdm1pSUFFeFVtbVNT?=
 =?utf-8?B?NVVCT2tkWTNEL0tkSFprQ0FsTllQM3gzUU5WMGVhc1JENmRFc1paWlF5MHFE?=
 =?utf-8?B?MTFnYUdEaTBVS3FNMEdPc0d0WjVXUlc5aitUNm00VDc3SFBybDlHVFBMRjMx?=
 =?utf-8?B?cXYwOVFHVEtjajlFZHBaY0ppYis5UG90V2tra1VwRnpjTHMvV213T2I5Z0RP?=
 =?utf-8?B?UjhFb2JISWVLbnFTeCtyNzlaNm12QzdMOGJVVzZIWS90dnlkK0JlRkxHbGNi?=
 =?utf-8?B?eUExbzAyVUptenJKd083aDZqZ0RwaDI0YXV6QUVUQzNQZ0Jua1dycVVaZXlY?=
 =?utf-8?B?WTBZT1FmNnJoaERpRnBzWHIxNjkyL0x3M3FoTkZvVTZBRUtSMjdhcmYwOVNY?=
 =?utf-8?B?TjFXOGJEdlRzNTFHcksvYUFuZUhUK0Y1R3lLWE1xV1RTc1JaTm9XTTBCUXdT?=
 =?utf-8?B?MVB6WDdqbngwZ21oODhmR0kzakd4NmVEMGJrNyttRnp6czh1bHcwcXU0cHRs?=
 =?utf-8?B?eWRaL1NVSFp4T0R6UWZCdU01UE1nVVVPM29OR2tka1EvU25jRnBtbkVLckpl?=
 =?utf-8?B?bDRqZHRwaFhjVVRNZXdKcWpxYzE0MUhCUXdLQlgvUS9ZUmF5dHhqeUFad0t1?=
 =?utf-8?B?MHp4SlF0MmVWbGlLeFZxSFdNOXdWdUJkSENYZVRxOG1uL0oxdjlmTjhHZXRU?=
 =?utf-8?B?L2NSUERqS1FLZWYvZ1N4cUk1Y3F5aUI3U2htbldYQjBkVTgyNDBDQ3VjTFc0?=
 =?utf-8?B?ZlJ6d3l2bjgzRVBYMDAzWFFxdWV6R3dMNGNMYlc3UkNUbUtGRms0MitBc1Yx?=
 =?utf-8?B?eDQ0NTAwSmVuWHpPM3lzTDBUSzM3ek1SVkk1RTZjd2VJdlE3S1hDYVBUU01S?=
 =?utf-8?B?VVE5ZVBtdGd6QWdBTnlnRDFkQTNyUWtUU2wzWHRnMitKRDVzNHQ3MG01NDZs?=
 =?utf-8?B?S1JsdFlQZ0VBeE9oTU1IZkdYTUxRNFBoQ1FpeFNoK2dDZ1hsOTh4c0MvYlAz?=
 =?utf-8?B?U0Zrd2xzU3VZSGlTSUZCV2NWOEJjV1V0Y1pTQk5qcGdaOTJnOXQyRDdHMG1m?=
 =?utf-8?B?WHRtT1JEMVNZeVJUTVVoUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAC8582C80E75740B33C96BA0D7A3303@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734d723b-a0e1-4431-35ea-08d8f87cb0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 21:49:29.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDuSWnMcnSWriYxKZPKABoj/ZC11iN0RVpBt56IrP2IEeod3MCWmZkmAZwSYPqgM5YoUpBpFTpPnZ4ecZECe06IHaun7WXpWn0mZRPaBiu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTA1IGF0IDIyOjMyICswMTAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gTW9uLCBBcHIgMDUsIDIwMjEgYXQgMDI6MDE6NThQTSAtMDcwMCwgRGF2ZSBIYW5zZW4g
d3JvdGU6DQo+ID4gT24gNC81LzIxIDE6MzcgUE0sIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+
ID4gK3N0YXRpYyB2b2lkIF9fZGlzcG9zZV9wYWdlcyhzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQ0K
PiA+ID4gK3sNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBsaXN0X2hlYWQgKmN1ciwgKm5l
eHQ7DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNoX3NhZmUoY3Vy
LCBuZXh0LCBoZWFkKSB7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGlz
dF9kZWwoY3VyKTsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAvKiBUaGUgbGlzdCBoZWFkIGlzIHN0b3JlZCBhdCB0aGUgc3RhcnQgb2YgdGhlDQo+ID4gPiBw
YWdlICovDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnJlZV9wYWdlKCh1
bnNpZ25lZCBsb25nKWN1cik7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiArfQ0KPiA+
IA0KPiA+IFRoaXMgaXMgaW50ZXJlc3RpbmcuDQo+ID4gDQo+ID4gV2hpbGUgdGhlIHBhZ2UgaXMg
aW4gdGhlIGFsbG9jYXRvciwgeW91J3JlIHVzaW5nIHRoZSBwYWdlIGNvbnRlbnRzDQo+ID4gdGhl
bXNlbHZlcyB0byBzdG9yZSB0aGUgbGlzdF9oZWFkLsKgIEl0IHRvb2sgbWUgYSBtaW51dGUgdG8g
ZmlndXJlDQo+ID4gb3V0DQo+ID4gd2hhdCB5b3Ugd2VyZSBkb2luZyBoZXJlIGJlY2F1c2U6ICJz
dGFydCBvZiB0aGUgcGFnZSIgaXMgYSBiaXQNCj4gPiBhbWJpZ3VvdXMuwqAgSXQgY291bGQgbWVh
bjoNCj4gPiANCj4gPiDCoCogdGhlIGZpcnN0IDE2IGJ5dGVzIGluICdzdHJ1Y3QgcGFnZScNCj4g
PiBvcg0KPiA+IMKgKiB0aGUgZmlyc3QgMTYgYnl0ZXMgaW4gdGhlIHBhZ2UgaXRzZWxmLCBha2Eg
KnBhZ2VfYWRkcmVzcyhwYWdlKQ0KPiA+IA0KPiA+IFRoZSBmYWN0IHRoYXQgdGhpcyBkb2Vzbid0
IHdvcmsgb24gaGlnbWVtIHN5c3RlbXMgbWFrZXMgdGhpcyBhbiBPSw0KPiA+IHRoaW5nDQo+ID4g
dG8gZG8sIGJ1dCBpdCBpcyBhIGJpdCB3ZWlyZC7CoCBJdCdzIGFsc28gZG91Ymx5IHN1c2NlcHRp
YmxlIHRvIGJ1Z3MNCj4gPiB3aGVyZSB0aGVyZSdzIGEgcGFnZV90b192aXJ0KCkgb3IgdmlydF90
b19wYWdlKCkgc2NyZXd1cC4NCj4gPiANCj4gPiBJIHdhcyAqaG9waW5nKiB0aGVyZSB3YXMgc3Rp
bGwgc3VmZmljaWVudCBzcGFjZSBpbiAnc3RydWN0IHBhZ2UnDQo+ID4gZm9yDQo+ID4gdGhpcyBz
ZWNvbmQgbGlzdF9oZWFkIGluIGFkZGl0aW9uIHRvIHBhZ2UtPmxydS7CoCBJIHRoaW5rIHRoZXJl
DQo+ID4gKnNob3VsZCoNCj4gPiBiZS7CoCBUaGF0IHdvdWxkIGF0IGxlYXN0IG1ha2UgdGhpcyBh
bGxvY2F0b3IgYSBiaXQgbW9yZSAibm9ybWFsIiBpbg0KPiA+IG5vdA0KPiA+IGNhcmluZyBhYm91
dCBwYWdlIGNvbnRlbnRzIHdoaWxlIHRoZSBwYWdlIGlzIGZyZWUgaW4gdGhlDQo+ID4gYWxsb2Nh
dG9yLsKgIElmDQo+ID4geW91IHdlcmUgYWJsZSB0byBkbyB0aGF0IHlvdSBjb3VsZCBkbyB0aGlu
Z3MgbGlrZSBrbWVtY2hlY2sgb3IgcGFnZQ0KPiA+IGFsbG9jIGRlYnVnZ2luZyB3aGlsZSB0aGUg
cGFnZSBpcyBpbiB0aGUgYWxsb2NhdG9yLg0KPiA+IA0KPiA+IEFueXdheSwgSSB0aGluayBJJ2Qg
cHJlZmVyIHRoYXQgeW91ICp0cnkqIHRvIHVzZSAnc3RydWN0IHBhZ2UnDQo+ID4gYWxvbmUuDQo+
ID4gQnV0LCBpZiB0aGF0IGRvZXNuJ3Qgd29yayBvdXQsIHBsZWFzZSBjb21tZW50IHRoZSBzbm90
IG91dCBvZiB0aGlzDQo+ID4gdGhpbmcNCj4gPiBiZWNhdXNlIGl0IF9pc18gd2VpcmQuDQo+IA0K
PiBIaSHCoCBDdXJyZW50IGNsb3Nlc3QtdGhpbmctd2UtaGF2ZS10by1hbi1leHBlcnQtb24tc3Ry
dWN0LXBhZ2UgaGVyZSENCj4gDQo+IEkgaGF2ZW4ndCByZWFkIG92ZXIgdGhlc2UgcGF0Y2hlcyB5
ZXQuwqAgSWYgdGhlc2UgcGFnZXMgYXJlIGluIHVzZSBieQ0KPiB2bWFsbG9jLCB0aGV5IGNhbid0
IHVzZSBtYXBwaW5nK2luZGV4IGJlY2F1c2UgZ2V0X3VzZXJfcGFnZXMoKSB3aWxsDQo+IGNhbGwN
Cj4gcGFnZV9tYXBwaW5nKCkgYW5kIHRoZSBsaXN0X2hlYWQgd2lsbCBjb25mdXNlIGl0LsKgIEkg
dGhpbmsgaXQgY291bGQNCj4gdXNlDQo+IGluZGV4K3ByaXZhdGUgZm9yIGEgbGlzdF9oZWFkLg0K
PiANCj4gSWYgdGhlIHBhZ2VzIGFyZSBpbiB0aGUgYnVkZHksIEkgX3RoaW5rXyBtYXBwaW5nK2lu
ZGV4IGFyZSBmcmVlLsKgDQo+IHByaXZhdGUNCj4gaXMgaW4gdXNlIGZvciBidWRkeSBvcmRlci7C
oCBCdXQgSSBoYXZlbid0IHJlYWQgdGhyb3VnaCB0aGUgYnVkZHkgY29kZQ0KPiBpbiBhIHdoaWxl
Lg0KPiANCj4gRG9lcyBpdCBuZWVkIHRvIGJlIGEgZG91Ymx5IGxpbmtlZCBsaXN0P8KgIENhbiBp
dCBiZSBhbiBobGlzdD8NCg0KSXQgZG9lcyBuZWVkIHRvIGJlIGEgZG91Ymx5IGxpbmtlZCBsaXN0
LiBJIHRoaW5rIHRoZXkgc2hvdWxkIG5ldmVyIGJlDQptYXBwZWQgdG8gdXNlcnNwYWNlLiBBcyBm
YXIgYXMgdGhlIHBhZ2UgYWxsb2NhdG9yIGlzIGNvbmNlcm5lZCB0aGVzZQ0KcGFnZXMgYXJlIG5v
dCBmcmVlLiBBbmQgdGhleSBhcmUgbm90IGNvbXBvdW5kLg0KDQpPcmlnaW5hbGx5IEkgd2FzIGp1
c3QgdXNpbmcgdGhlIGxydSBtZW1iZXIuIFdvdWxkIGl0IGJlIG9rIGluIHRoYXQNCmNhc2U/DQo=

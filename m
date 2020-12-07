Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC42D1E9A
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 00:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgLGXzp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 18:55:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:6580 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgLGXzp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 18:55:45 -0500
IronPort-SDR: pr+B07zqJAjGgR2Wb7YpYXH60jw0YSwvCxicsUG7UmBGQaa8ZRFi7ksreFemXnvf6IZkk9OB8w
 qjJg0A+02GAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="237906843"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="237906843"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 15:55:04 -0800
IronPort-SDR: 0Dwe2whlPoXI9aRGcZFb3G5hAdqI1sCCV7k1MjeK3w9QHbeXUYGnNszsl/Diw1rzPIvb1RjteQ
 TWe6i+TD1yGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="332316162"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2020 15:55:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Dec 2020 15:55:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Dec 2020 15:55:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 7 Dec 2020 15:55:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 7 Dec 2020 15:55:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWZPefIp8G/rqfkNz1anq+j1ynLC4J9aHsGa0+Nr8vZ8+NjTYI3B4qiUTimwokEs1iOPKBxKG8NOtCQ/cBbGPpOnXXiMrLOyX0lqza9L4kgQaZ6iGD3WCIgt3XA2J2v9gJm/VgVANt+XeGB16IM77YI0Li+ZNx2E3GSWjrtLrf1akwo0K2GIhWHiIKQsZ0zZSlnKBu/Nli+vX71xIueb+3uv4DhsQP7tYx3R5vyHEKD8kT4YG1ceKX+SLygwAxwePE8ut4TYytWxVKJyTsliuJLJ9TIQ44H+5dNCKhrku36/yktdLN8G76OP3pD7ruE1dXHxgErPGGhxOFdM/BIX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVjSvKF8hC45Lf4T+jVlncZljzVF5EFuz6+77SUkQHs=;
 b=OBaJ06QLwBbNbhHM2vxWsR2xzCIIOA8l6ssprcdwMHPzP/a67340T5UmKYBV8wSQugSFGMsIM2EYCen1PWAgg8tWWlSXwe9lIIIVlZJKoq9/+H2iUzQq2+/qx0pbUFouQbnNinPTfgy1glAN/zgxLMPtlPseLIaJOwEXP1SMhvmmwuWmwnDLfvk3niTv/LwdDH7VJEvld0RP/FK9BkWFRx7IcksXH+xKHo5WivvStXzJgXkXfjUxsvGwleFnSeGREquBBbrNYZhSiZHegp2sd6ZlzxRhoQzgWhyiYBdyoi2WTmUwBaly1aL4Gcy2+pymHSl+qr5uELWWpWhwdlD1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVjSvKF8hC45Lf4T+jVlncZljzVF5EFuz6+77SUkQHs=;
 b=VkdbrV7Sz7NrHX6n9zHPl3iX0Tf+mfl96QbSCpW/NrNf4m78jdUWw2hBaPhb3yhRJFZceieeU4iwNRSE1Op8tajYGlTwoQEJnXaTmjo8MVBnaaB03x4juNAiomebj08uWBesJXPnRZ4HSKHJHTJ2G+D0dGY0FbzPtnriSoCGqiA=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB3373.namprd11.prod.outlook.com (2603:10b6:805:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.22; Mon, 7 Dec
 2020 23:55:00 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412%6]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 23:55:00 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "seanjc@google.com" <seanjc@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "luto@kernel.org" <luto@kernel.org>
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Thread-Topic: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Thread-Index: AQHWv3v0VGlTYBJQUE2XnxoQHVHqeqnnqkAAgAS/hYA=
Date:   Mon, 7 Dec 2020 23:55:00 +0000
Message-ID: <e7d08b99f133e901dfdf5c42d86a717062fb166d.camel@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
         <20201120202426.18009-2-rick.p.edgecombe@intel.com>
         <X8rFLHGSqJ7JCZ/N@google.com>
In-Reply-To: <X8rFLHGSqJ7JCZ/N@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 018735a0-d0d2-41ce-ca88-08d89b0b8255
x-ms-traffictypediagnostic: SN6PR11MB3373:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3373209367337077DBCCBC54C9CE0@SN6PR11MB3373.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bn79Ro/5BZSt6id/MhgrVN34D/glr8Umq47h8brsu068NEnxW57PPapNYcNy1KhhAdHCOAHWQSzwYV6yE1aojGHl0NU5L3ub4JW8BRk/xBCMKzKuvKsFxiX0cYjAnjwTS33aBCJ6Nb5pDadvnlPtGqsYy4zuaz8w0laYb7fusHKKjmoOSJviAPP02un/hBlWLJWJSAhGNvkbyLD4XpEtKdLPToyThZrKJh5uL6Hh4KSUjgBk/kYbirVgUbuE4ALAfYBicQUSMeXqKos2mNZzmpC+ZpY20j4pc3Vmd7lOjRl/EiRm0Mqtl18AwpfXNJTZU3Wfi9dOInYLsCcwVWT2AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66946007)(54906003)(26005)(186003)(478600001)(76116006)(66446008)(5660300002)(66476007)(4326008)(91956017)(66556008)(83380400001)(2616005)(316002)(86362001)(6506007)(8676002)(6916009)(6486002)(2906002)(71200400001)(7416002)(64756008)(6512007)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dWdkN0I4TmdybEM1OWphYkhqQWYvc0w5R2hjQVZMTjNtVnljbjdidFlKN1Jy?=
 =?utf-8?B?WjVGb2MxNjhRNWpBNm1QY0ZVSmc3S2p4eUYrMjJHek85NENhclJIWm42QnpM?=
 =?utf-8?B?ZjN2UGN6di9pRElqd0RQWmVVUnRHVVZIQmRaVkxld25GVVNDVUtTUklyZWg3?=
 =?utf-8?B?ak5SN0IyU3pYU0RyUFhKOUY5QmMyNi9iOU1BYkIzeUcvK3oxbFZ0R1RUM1FJ?=
 =?utf-8?B?clUyU0N2NThMRUNEZzhrK2ZYUWRlWk5DQWdsV0k0UWlBWWJlNFRBekp4TGpy?=
 =?utf-8?B?Uk1NNi9DN0xvTy9BTjZYaThuWUVuMlBNUHphaDNGb3U0VGRVYVh5aDQ0VCs2?=
 =?utf-8?B?aHFuV1dhK0xNVTlXaVlaMlRHZ3pDYWJLblJmYkdFbDU1MGFrYjJ6WmhZU1JZ?=
 =?utf-8?B?bTllOURxVENIelNmaHBzUW8welpNVmlBN2R1TDNWL3hxME1CaEE5dGY4MGFU?=
 =?utf-8?B?bWlUUUttd3BYTUh6S25yNlkzMDgvR2tHd0laZDk4TG9oclBmNHp5SW9FV2V1?=
 =?utf-8?B?bkd2eWVpaTRIM09paDdKTkNrSWpneWwrUE12aDVXZkx3RGo3eVBxaVVBUVpV?=
 =?utf-8?B?MUppK3ZHQjFjN0plZ0V5MnBLamg0cHM4RTdzV25UbllnWXZ4V05JSm5oNjJO?=
 =?utf-8?B?RU44OGVZZUpJY2RvZmZjTmJXOU5aLzFrZU5jbGo2cm5oL1F4c2dPV2MzNTlW?=
 =?utf-8?B?ekRYWXRNaVplM1NoVXkyTDN2ZW1HWU82emtKTktZK0lVR1M3NGZKZmlzc1FV?=
 =?utf-8?B?OU5ScVpIZTJoRU01ZTR1TGx3L3J6WEN0c0JNelp2UVJYSmFMTmRneHhDUWRT?=
 =?utf-8?B?TEYzVlAxa05IbEwvUXVid0NnRFhqaWxHeHZWQlk1ZWJsbHhGU0lCdnJXVkl4?=
 =?utf-8?B?clN4YXpWcGtUSVVOTExoZUYrS3RWTThCNFNoV1FDck5QNzk4MmorOE9WL2Fo?=
 =?utf-8?B?NExHc3dPWUorSkNvWnBVWm0vd1lLSHBoVkpGMGRNTXV0NWxYQmhRT1ptb1My?=
 =?utf-8?B?aUwyZU1JQkFjMlRzcTI3WnFSdS9PQUh4M3ZQUFcyQ2YwOFBQZjQ0cGVPcUFK?=
 =?utf-8?B?UGlsNkR4djAvSVd5ZXRvWFd6UGs0S0tGSVFhTnRQRGllWVQ1c1g3c254cEEx?=
 =?utf-8?B?THBXWkJiSG4wcXZOcjZRTTUrQnZkK0p1bmN0NUdzVlg4L0hhd2hmclRITWkx?=
 =?utf-8?B?SGhqM0s4Yms2WEt4dEJ4TWFPVzJuZ1Q1WE4vVDV4aVNCOENqM096V09hUEtY?=
 =?utf-8?B?MDU0ZGljcExzRVNranJRRDA0WXJjc3lVSzFLYi9YOU1rZDVvVHhoOTBiWlc3?=
 =?utf-8?Q?7rcpi+CYLZjYm9GLNv+VmM0jj9Hz5+1FbX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4FC1F89903F0646A6F0A5815DB27AA7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018735a0-d0d2-41ce-ca88-08d89b0b8255
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 23:55:00.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAqP7On3RfpxRPeTdDucF+vvPHvOWOmro3Skygk+GRepSSDPXOUt8FP9jhnKbdWDXEYKiNA4G1Ff1vEXpYfCLWEhJtPZej5QweMy1fCIgjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3373
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDE1OjI0IC0wODAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBGcmksIE5vdiAyMCwgMjAyMCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4g
K3N0cnVjdCBwZXJtX2FsbG9jYXRpb24gew0KPiA+ICsJc3RydWN0IHBhZ2UgKipwYWdlczsNCj4g
PiArCXZpcnR1YWxfcGVybSBjdXJfcGVybTsNCj4gPiArCXZpcnR1YWxfcGVybSBvcmlnX3Blcm07
DQo+ID4gKwlzdHJ1Y3Qgdm1fc3RydWN0ICphcmVhOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBvZmZz
ZXQ7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHNpemU7DQo+ID4gKwl2b2lkICp3cml0YWJsZTsNCj4g
PiArfTsNCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIEFsbG9jYXRlIGEgc3BlY2lhbCBwZXJtaXNz
aW9uIGt2YSByZWdpb24uIFRoZSByZWdpb24gbWF5IG5vdCBiZQ0KPiA+IG1hcHBlZA0KPiA+ICsg
KiB1bnRpbCBhIGNhbGwgdG8gcGVybV93cml0YWJsZV9maW5pc2goKS4gQSB3cml0YWJsZSByZWdp
b24gd2lsbA0KPiA+IGJlIG1hcHBlZA0KPiA+ICsgKiBpbW1lZGlhdGVseSBhdCB0aGUgYWRkcmVz
cyByZXR1cm5lZCBieSBwZXJtX3dyaXRhYmxlX2FkZHIoKS4NCj4gPiBUaGUgYWxsb2NhdGlvbg0K
PiA+ICsgKiB3aWxsIGJlIG1hZGUgYmV0d2VlbiB0aGUgc3RhcnQgYW5kIGVuZCB2aXJ0dWFsIGFk
ZHJlc3Nlcy4NCj4gPiArICovDQo+ID4gK3N0cnVjdCBwZXJtX2FsbG9jYXRpb24gKnBlcm1fYWxs
b2ModW5zaWduZWQgbG9uZyB2c3RhcnQsIHVuc2lnbmVkDQo+ID4gbG9uZyB2ZW5kLCB1bnNpZ25l
ZCBsb25nIHBhZ2VfY250LA0KPiA+ICsJCQkJICAgdmlydHVhbF9wZXJtIHBlcm1zKTsNCj4gDQo+
IElNTywgJ3Blcm0nIGFzIHRoZSByb290IG5hbWVzcGFjZSBpcyB0b28gZ2VuZXJpYywgYW5kIHBl
cm1fIGlzDQo+IGFscmVhZHkgdmVyeQ0KPiBwcmV2ZWxhbnQgdGhyb3VnaG91dCB0aGUga2VybmVs
LiAgRS5nLiBpdCdzIG5vdCBvYnZpb3VzIHdoZW4gbG9va2luZw0KPiBhdCB0aGUNCj4gY2FsbGVy
cyB0aGF0IHBlcm1fYWxsb2MoKSBpcyB0aGUgZmlyc3Qgc3RlcCBpbiBzZXR0aW5nIHVwIGFuDQo+
IGFsdGVybmF0ZSBrZXJuZWwNCj4gVkEtPlBBIG1hcHBpbmcuDQo+IA0KPiBJIGRvbid0IGhhdmUg
YSBzdWdnZXN0aW9uIGZvciBhIG1vcmUgaW50dWl0aXZlIG5hbWUsIGJ1dCBpbiB0aGUNCj4gYWJz
ZW5jZSBvZiBhDQo+IHBlcmZlY3QgbmFtZSwgSSdkIHZvdGUgZm9yIGFuIGFjcm9ueW0gdGhhdCBp
cyBlYXN5IHRvDQo+IGdyZXAuICBTb21ldGhpbmcgbGlrZQ0KPiBwdm1hcD8gIFRoYXQgaXNuJ3Qg
Y3VycmVudGx5IHVzZWQgaW4gdGhlIGtlcm5lbCwgdGhvdWdoIEkgY2FuJ3QgaGVscA0KPiBidXQg
cmVhZCBpdA0KPiBhcyAicGFyYXZpcnQgbWFwIi4uLg0KDQpHb29kIHBvaW50LCB0aGFua3MuDQoN
CkFmdGVyIENocmlzdG9waCdzIGNvbW1lbnRzIHRvIHJldHVybiBhIHZtX3N0cnVjdCBwb2ludGVy
LCBJIHdhcyBnb2luZw0KdG8gdHJ5IHRvIHBpY2sgc29tZSBtb3JlIHZtYWxsb2MtbGlrZSBuYW1l
cy4gTGlrZSB2bWFsbG9jX3Blcm0oKSwNCnZtYWxsb2Nfd3JpdGFibGVfZmluaXNoKCksIGV0Yy4g
U3RpbGwgaGF2ZSB0byBwbGF5IGFyb3VuZCB3aXRoIGl0IHNvbWUNCm1vcmUuDQoNCg==

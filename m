Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1C3B38F5
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhFXV5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 17:57:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:17542 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhFXV5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Jun 2021 17:57:16 -0400
IronPort-SDR: DpwuoytRxKDAZMR9pJsWbpAccE2ZLyIwKYTnWyaJUfd2sBvJ0/hR6QKvHQAmuIC+Yyz4NHZWYR
 jynLuiiO+Y8A==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207384144"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="207384144"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 14:54:54 -0700
IronPort-SDR: FFJQAAEJ5ZXsy453oNZEXkbulwabkVm39Fllvj6HXnFd09pEKZDzM3UnhvvaHwiebdRiQ2ZJav
 hLzOhSSlJWJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="487934210"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2021 14:54:53 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 24 Jun 2021 14:54:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 24 Jun 2021 14:54:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 24 Jun 2021 14:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccbrHyuFYuWe3WQW3WQPdPCd2A4IQ4YGkqhL0Jgttc1QONsz8ULpOZF42FO2B5PKGUzAlXUBOiIZyiB7ffokA00q3DT6AXy71ns2x7pdcO+CQJ8qyVmirPbySElHR5wj9P+59fnVIVTxPooimx4RxOAVgfROL8pw3p8DBP0tnceKBTEcd3/nWVybPWt8l0+JkLnWfLeXPVmOHJ6rKrOcTbVr/9ZtSii9QPzV35rs28axnBuTtHW99dlY4cHq0WJwFHQdejMOsJJIHyEKmJjMQrtqwC3Ry9r85jd4t8lqfuR9EZMimK3O+0yeHOR0iUdrlq6cps4ro63pX0zVMxCBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7JqAT080QUrciNq45mFYntaZSYmPf1iOQJ5Sfe283Y=;
 b=ogPojMMcwLt1mlpCRQlAvAxxgDgzSLouTCenOhXQqNtqJ3OO4GcAUz0l1pQRpdVX4/GBp559++FMeQZgOW8e7EYLGhwVWdgvQWNmd0P9HMub1SynH+ErlCEzqoWBnlkZcyg04isPW08XAr8JXtF5APeMub6MvslIhS0iGubwfj8G9H13kfyZM+nInFk+lrZN19riUl+hBRhgUqLQBLvTmRD4cls0oMRkDV+fC3FwKPRlb/tVirVA2Ol/tblpTXrFBMU1FdOe6KjfAupmrlq/17QlOzyvFXjQpZujYlBwqUzwWLZ1EOV5CP/RS3R1AopIr60IAuH+7ZnsKWK6lCmn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7JqAT080QUrciNq45mFYntaZSYmPf1iOQJ5Sfe283Y=;
 b=gSeeBqrqE8wmJ1ScVJq5seOCxXyrX07c1Yj6TKLPFcUfshPVab8LKSETn41fSwTPmxpgqYWwFxtPg33Pspgyzc/fxpYzgbRCJQnUIZqr9+reP+KMH/hlQWMweBToliS05Gbtknv73ioawqRpB6+gkg2gfT9CmUmE2X7lEXml8dY=
Received: from CY4PR11MB1624.namprd11.prod.outlook.com (2603:10b6:910:8::12)
 by CY4PR1101MB2263.namprd11.prod.outlook.com (2603:10b6:910:19::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Thu, 24 Jun
 2021 21:54:47 +0000
Received: from CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::d9f8:2dbd:528:b467]) by CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::d9f8:2dbd:528:b467%4]) with mapi id 15.20.4242.025; Thu, 24 Jun 2021
 21:54:47 +0000
From:   "Desouza, Ederson" <ederson.desouza@intel.com>
To:     "brouer@redhat.com" <brouer@redhat.com>
CC:     "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "saeed@kernel.org" <saeed@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: A look into XDP hints for AF_XDP
Thread-Topic: A look into XDP hints for AF_XDP
Thread-Index: AQHXaI1NCoqWOcnh50mPov3W8E+846sjlEyAgAAhr4A=
Date:   Thu, 24 Jun 2021 21:54:46 +0000
Message-ID: <adfc8f598e5de10fa40a4e791a1e8722edae1136.camel@intel.com>
References: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
         <20210624215411.79324c9d@carbon>
In-Reply-To: <20210624215411.79324c9d@carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.2 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2601:1c0:6902:8a70:9eb6:d0ff:fed2:f387]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e53d8821-0908-4736-78dd-08d9375aaef2
x-ms-traffictypediagnostic: CY4PR1101MB2263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2263E1C37D74491C4BF9FE31F6079@CY4PR1101MB2263.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1+NskLHsERCtcY4D5IhC1IpMP2lo0P9gynVvJRPRRLoi92ZRKopQuCwQj6lHYh60TkbHgmHJ5JFXmZVUvsiYs370BC8wxQC8iphtRcNpHXGV16npiSXMGDZWLKbfAKdiEUYUnwbkGwPRrrd4HUaDYTA2hsC0N4N5nVqJTUiOQdlH5FD8/AV+jNIooPwslrHQGdlo0Trx3UNVkkNQCC/hAAVSQ/VXR9Ta+dO+BIuTkvbvOfm0V9Eb8RajnR1pijgqvizNvyptcNd/3LgfIafo5TnRGYZJWiW49hK5us+XraSWgR9yx0BWG4RO0c6ALfG7CAqQruygDGPpvf7T/OJhf8nStPRNNtmlN9Bw9ZPyB/nfZsROyxxxN6nD1cPmSKMNScQDKYkSiNay3KYZ73sVRlzT9pI7HeKQa5ckpOPF2paT/NKdgC7lIoprvD/mJh9MPN+4zgucR0/eQ/QnTPz3RzPaGrUrBh7FSFe1pVIaPcrEIkesiH50ssZmIWKWx5Yux7GmkVfTTksDE1jONk1CzeNJ6NdAzS9q88yotohUc4u20Nu4qAIentUlXLhW0heopS9khJngVbLOy88VnvAXgKawlpIJvEhQw/u62ftrqisdgNSf1zQWnzt5MM/Klq4QHF3mSNF8gXac0Yq5B1qqZoPzuia2IROvZWau6YkogVq3FRtSDdw1Lw/+ZG0Z3/yCBEYMm2DoYndETe9Hx8ozSJ6L6y9vRhEu2x8vVFxZDpgEvpwJBRIMd8Gzz3PyEw7x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(346002)(396003)(6512007)(2616005)(66946007)(76116006)(91956017)(5660300002)(86362001)(66476007)(66556008)(83380400001)(64756008)(122000001)(6916009)(38100700002)(66446008)(6486002)(54906003)(2906002)(316002)(186003)(478600001)(8676002)(4326008)(966005)(71200400001)(36756003)(8936002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnQvekJKb0xlNEFzUmRYY1p1QkhpQ1dlUnI3YUxvY0xreGlJMWNkRDk3OWpz?=
 =?utf-8?B?dWNud2pHNVFqaExDMVhPSkxHL3JwaXoxcThFaEVnQjEvL0xzd2toRSt2cC82?=
 =?utf-8?B?N0d2YkFnN2FkYWVtS3lvWCtSSldsUWtleEErSUtDWk8yYUxkUkl0Z0dGUk9z?=
 =?utf-8?B?cGJpSEhjYTMvWUIydnBIeW5ZUGRoUjd3MHFWMnM5RXBtNXIxM3N6U0hnVEdi?=
 =?utf-8?B?WVlUaURXZUpLWGhHa2tEanRyNUczVG81cHFpemlQOGR0V0VJWUdKbEpoYnN2?=
 =?utf-8?B?bitkYVI3ZlJWYTlWc0crRTUrbkFDbGFvVFluYzlnbEJkOUJ2bWlyU3RuNCtv?=
 =?utf-8?B?UjVrQWtNSjQ0SkJYWXJJNjRMcFE0YXZDMWRTWHYzb1RVbVU3eTc3N3F3bFdT?=
 =?utf-8?B?STZGdGllNTJBcm5QT2g1cVdOdTJ1L2RaZ1pWbnBVUnVvVXc5SXZqdEM0SkxG?=
 =?utf-8?B?RjlLZjNZdE5wZUpLSWtseDdPQldWT05JSzlaN1pRMTVtUmRPWUMwQlZhMEpk?=
 =?utf-8?B?clJqWGc2RVRON1MwTTZVcUttdlhTSHlwckJaU2xnd0FwV0hHZDM2bGszM3RF?=
 =?utf-8?B?cjVwNmttQ3AvQjVySnpFNDJTb1ZZRGhHRFN1NUxBZTV1elpVUWV4UGZ5MmRa?=
 =?utf-8?B?SU1Qb3VIWUEyTUJVWXVCVThia3ptaVFOc2srakVtaXVPbTZJVjcvUnM4RHRC?=
 =?utf-8?B?cUlrMHFEeExDUEwyVHoxOHdBZXR5L3VBb2VpQVVpZDVTazhoTnRwaXF2TVR1?=
 =?utf-8?B?ZDRHaWZBMDhUNngxZ3g3dXpHR0s3QXhsMDdlSG5IZXpRN3FKVlhJZG45QUU2?=
 =?utf-8?B?TFN2NXk1TWt4L0tyckZWZ1dOaDlLYVlVWXVmZGdpNm9DL0Yrck84d0JWak5M?=
 =?utf-8?B?TXhOTWQ0VnMwTzhTd3dNZ2JEUVUzWVJMOVNDOEprL1A4WEdnS0RlMU1TaHl6?=
 =?utf-8?B?WldyRVZrUXRMc282bHRKS3dENVZKUVkxZjJQZUMzNGdkeXBMWGlTRFMxK3J4?=
 =?utf-8?B?TkxiS2g3Q2dvS1VTZyt6ZHRLU0lNMDNvL3FvNmJqL0ZHOFhDZ2Jxek4reHhF?=
 =?utf-8?B?OENuZFFNM3VyUjk2UkJ6bnl2cjFMRzZwUG51ZUZDWjZITEVWOFVnZ2d3SUV0?=
 =?utf-8?B?NUhLQUtaVjQ2TiszTmhETlFLQTJDc0c2aG1iMU9naEkrc0dGYUlVNThvNVUv?=
 =?utf-8?B?TEwvVnVwTFBBT0VkZkJKY2NnZG02YndMSk52OUxGRjRud05DdStrV0tyK2ww?=
 =?utf-8?B?OWRuWHZvUEhjN0VicEVrUkdNQzIyNWp5ZkVHQkpOZkozRzNuR1NmdXBUUXBi?=
 =?utf-8?B?N2F2dmx1aWxDOEx0eEtpWVMvVWNkdUNLRzVJbGRLWlQrSmJ6SFV1RGVPdHFZ?=
 =?utf-8?B?R2d4ejZMZ2piNGNlTnQ0NW4vOTRLR1VCMTVJd1U5YkV4T2lSNUJjUEI4RGVp?=
 =?utf-8?B?OU1wUGcwYzRSNnM3Zmc4M04wN0hHTTEzRlptT2FmVVptdDZld3pySURXOHNk?=
 =?utf-8?B?eFJsc0dQUFpHemRLNWZLY1o0NnpjK1I0cVdQSURsSVdzYmNRT1prMmYrV21L?=
 =?utf-8?B?QWZnSHNjQnJFL3hBRXR4aXBmSE4wUG1QZGxRL21tb3JKaUNUbFd4Rnl5YUYr?=
 =?utf-8?B?SDhFbWJ3QmFCTUx5NUg0bjBWaTNIQWRlRjl5aEdnRXpGSkxYak4vZVBFY3Zn?=
 =?utf-8?B?V05rcEpqOWxIYkZzd25xS1phd05wb0FhRzFZUnkrb1gwWlJyTDBDUXpZOFgy?=
 =?utf-8?B?QVRhbWh2V2w2T3ZGdk14dmRMYm9LaERVTEI2SU8zbWcxVXFkRHpDN2wrMkVV?=
 =?utf-8?B?U1Q2d1VkUVJSa3IvcjNnZ2MrMDhOdkJvS1JtdDFjWFd6S3lTZ2d0azNSNkZ0?=
 =?utf-8?Q?knJrQY2IG3xIY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A286C71E76635F4DAF82DA5459A80E77@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53d8821-0908-4736-78dd-08d9375aaef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 21:54:46.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzyOgWebyRP8V0g0zkatHDkbmL1BcwkRY4zrHxHbPUmt3RmKfi8LKJz5+wxLhJt1fcPCMIzwtGPZKVzm2zt6Yl2Fo2G+oogcREHKEn4iMDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2263
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTI0IGF0IDIxOjU0ICswMjAwLCBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVy
IHdyb3RlOg0KPiBPbiBUaHUsIDI0IEp1biAyMDIxIDAwOjEwOjEyICswMDAwDQo+ICJEZXNvdXph
LCBFZGVyc29uIiA8ZWRlcnNvbi5kZXNvdXphQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEZv
bGxvd2luZyBjdXJyZW50IGRpc2N1c3Npb25zIGFyb3VuZCBYRFAgaGludHMsIGl0J3MgY2xlYXIg
dGhhdA0KPiA+IGN1cnJlbnRseSB0aGUgZm9jdXMgaXMgb24gQlBGIGFwcGxpY2F0aW9ucy4gQnV0
IG15IGludGVyZXN0IGlzIGluIHRoZQ0KPiA+IEFGX1hEUCBzaWRlIG9mIHRoaW5ncyAtIHVzZXIg
c3BhY2UgYXBwbGljYXRpb25zLg0KPiANCj4gSSBhZ3JlZSwgdGhhdCBtb3N0IG9mIHRoZSBkaXNj
dXNzaW9uIGlzIGZvY3VzZWQgb24gQlBGLXByb2dyYW1zIGJlaW5nDQo+IGxvYWRlZCBpbnRvIHRo
ZSBrZXJuZWwgdmlhIGxpYmJwZi4gIEkgYWN0dWFsbHkgYWxzbyBjYXJlIGFib3V0IGdldHRpbmcN
Cj4gdGhpcyB3b3JraW5nIGZvciBBRl9YRFAuDQo+IA0KPiBXZSd2ZSBkaXNjdXNzZWQgdGhpcyB3
aXRoIE1hZ251cyAobWVldGluZyB5ZXN0ZXJkYXkpIGFuZCBJIHRoaW5rIHdlDQo+IGFncmVlIHRo
YXQgdGhpcyBpcyBhbHNvIHNvbWV0aGluZyB3ZSB3YW50IGZvciBBRl9YRFAuICBJSVJDIHRoZSBw
bGFuIGlzDQo+IHRvIHVzZSBvbmUgYml0IHRvIGluZGljYXRlIGlmIGEgcGFja2V0IGlzIGNhcnJ5
aW5nIGluZm8gaW4gbWV0YWRhdGENCj4gYXJlYSwgYXMgKDEpIEFGX1hEUCBkZXNjcmlwdG9yIGRv
bid0IGhhdmUgcm9vbSBmb3Igc3RvcmluZyB0aGUgQlRGLUlELA0KPiBhbmQgKDIpIGlmIGJpdCBp
cyBub3Qgc2V0LCB0aGVuIHdlIGNhbiBhdm9pZCB0b3VjaGluZyB0aGF0IGNhY2hlLWxpbmUuDQo+
IElmIHRoZSBiaXQgaXMgc2V0LCB0aGVuIHRoZSBCVEYtSUQgaXMgc3RvcmVkIGluIG1ldGFkYXRh
IGFyZWENCj4gKHByZWZlcmFibHkgYXMgdGhlIGxhc3QgbWVtYmVyLCBhcyBjdHgtPmRhdGFfbWV0
YSBpcyBhIG1pbnVzIG9mZnNldA0KPiBmcm9tIGN0eC0+ZGF0YSwgbWFraW5nIGl0IGFjY2Vzc2li
bGUgdmlhIGEgZml4ZWQgb2Zmc2V0IGZyb20gZGF0YSkuDQo+IA0KPiBGb3IgdGhlIEJQRi1wcm9n
cmFtcyBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIHN0b3JlIHRoZSBCVEYtSUQgaW4NCj4geGRwX2J1
ZmYveGRwX2ZyYW1lIGFuZCBtYWtlIGl0IGFjY2Vzc2libGUgdmlhIHhkcF9tZCAoY3R4IHNlZW4g
ZnJvbQ0KPiBCUEYtcHJvZykuICBUbyBoZWxwIEFGX1hEUCB0aGUgKnByb3Bvc2FsKiBpcyB0byAo
YWxzbykgc3RvcmUgaXQgaW4NCj4gbWV0YWRhdGEgYXJlYSBpdHNlbGYuDQo+IA0KPiANCj4gPiBJ
biB0aGVyZSwgdGhlcmUncyBub3QgbXVjaCBoZWxwIGZyb20gQlBGIENPLVJFIC0gd2hvJ3MgZ29p
bmcgdG8gcmV3cml0ZQ0KPiA+IHVzZXIgc3BhY2Ugc3RydWN0cywgYWZ0ZXIgYWxsPyANCj4gDQo+
IFdlbGwsIEFGQUlLIG1vc3Qgb2YgdGhlIG9mZnNldCByZWxvY2F0aW9uIGhhcHBlbnMgaW4gdXNl
ci1zcGFjZSBieQ0KPiBsaWJicGYuICBXaGljaCBBbGV4ZWkgYWxzbyBpbmRpY2F0ZSBpbiB0aGUg
b3RoZXIgdGhyZWFkWzFdLiBUbyBiZXR0ZXINCj4gdW5kZXJzdGFuZCBCVEYvQ08tUkUgSSd2ZSBj
b2RlZCB1cCBhbiBleGFtcGxlIGhlcmVbMl0uIA0KPiANCj4gIFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9icGYvQ0FBRG5WUUt2NVNMQmZuQlduRUJGcWYwLURRditOWnVpeEdpQ1Z4MWhld2ZR
RmhIU0tnQG1haWwuZ21haWwuY29tLw0KPiAgWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS94ZHAtcHJv
amVjdC9icGYtZXhhbXBsZXMvYmxvYi9tYXN0ZXIva3RyYWNlLUNPLVJFL2t0cmFjZTAxX2tlcm4u
Yw0KPiANCj4gSSdtIHRyeWluZyB0byB1bmRlcnN0YW5kIGhvdyBsaWJicGYgZG9lcyB0aGlzLiAg
U28sIEkgYWRkZWQgYSAtLWRlYnVnDQo+IG9wdGlvbiB0aGF0IG1ha2VzIGxpYmJwZiBwcmludCB2
ZXJib3NlIG1lc3NhZ2VzLiBTZWUgY29tbWl0WzNdIHRoYXQNCj4gYWxzbyBjb250YWlucyBvdXRw
dXQgZXhhbXBsZS4NCj4gDQo+ICBbM10gaHR0cHM6Ly9naXRodWIuY29tL3hkcC1wcm9qZWN0L2Jw
Zi1leGFtcGxlcy9jb21taXQvMDU0MmQ4YTdhMzI3YjY0MmQxMDUNCj4gDQo+IFNvbWUgb2YgdGhl
IC0tZGVidWcgb3V0cHV0Og0KPiANCj4gIGxpYmJwZjogbG9hZGluZyBrZXJuZWwgQlRGICcvc3lz
L2tlcm5lbC9idGYvdm1saW51eCc6IDANCj4gIFsuLi5dDQo+ICBsaWJicGY6IENPLVJFIHJlbG9j
YXRpbmcgWzBdIHN0cnVjdCBza19idWZmX19fbG9jYWw6IGZvdW5kIHRhcmdldCBjYW5kaWRhdGUg
WzI5NjVdIHN0cnVjdCBza19idWZmIGluIFt2bWxpbnV4XQ0KPiAgbGliYnBmOiBwcm9nICd1ZHBf
c2VuZF9za2InOiByZWxvICMxOiBtYXRjaGluZyBjYW5kaWRhdGUgIzAgWzI5NjVdIHN0cnVjdCBz
a19idWZmLmhhc2ggKDA6NTUgQCBvZmZzZXQgMTQ4KQ0KPiAgbGliYnBmOiBwcm9nICd1ZHBfc2Vu
ZF9za2InOiByZWxvICMxOiBwYXRjaGVkIGluc24gIzEgKEFMVS9BTFU2NCkgaW1tIDQgLT4gMTQ4
DQo+ICBsaWJicGY6IHByb2cgJ3VkcF9zZW5kX3NrYic6IHJlbG8gIzI6IGtpbmQgPGJ5dGVfb2Zm
PiAoMCksIHNwZWMgaXMgWzddIHN0cnVjdCBza19idWZmX19fbG9jYWwubGVuICgwOjAgQCBvZmZz
ZXQgMCkNCj4gIGxpYmJwZjogcHJvZyAndWRwX3NlbmRfc2tiJzogcmVsbyAjMjogbWF0Y2hpbmcg
Y2FuZGlkYXRlICMwIFsyOTY1XSBzdHJ1Y3Qgc2tfYnVmZi5sZW4gKDA6NiBAIG9mZnNldCAxMTIp
DQo+ICBsaWJicGY6IHByb2cgJ3VkcF9zZW5kX3NrYic6IHJlbG8gIzI6IHBhdGNoZWQgaW5zbiAj
OCAoQUxVL0FMVTY0KSBpbW0gMCAtPiAxMTINCj4gIGxpYmJwZjogcHJvZyAndWRwX3NlbmRfc2ti
JzogcmVsbyAjMzoga2luZCA8dGFyZ2V0X3R5cGVfaWQ+ICg3KSwgc3BlYyBpcyBbN10gc3RydWN0
IHNrX2J1ZmZfX19sb2NhbA0KPiAgbGliYnBmOiBwcm9nICd1ZHBfc2VuZF9za2InOiByZWxvICMz
OiBtYXRjaGluZyBjYW5kaWRhdGUgIzAgWzI5NjVdIHN0cnVjdCBza19idWZmDQo+ICBsaWJicGY6
IHByb2cgJ3VkcF9zZW5kX3NrYic6IHJlbG8gIzM6IHBhdGNoZWQgaW5zbiAjMjQgKEFMVS9BTFU2
NCkgaW1tIDcgLT4gMjk2NQ0KPiANCj4gQXMgaW5kaWNhdGVkIGluIFsxXSBhIEJURiBtYXRjaGlu
ZyBpcyBiZWluZyBkb25lIGluIHVzZXJzcGFjZS4gRmlyc3QNCj4gbGliYnBmIGxvYWRzIGtlcm5l
bHMgQlRGIGZyb20gJy9zeXMva2VybmVsL2J0Zi92bWxpbnV4Jy4gIFRoZW4gaXQgaGF2ZQ0KPiB0
aGUgQlRGIGZyb20gQlBGLXByb2cgJ3NrX2J1ZmZfX19sb2NhbCcgd2hpY2ggZmluZHMgdGFyZ2V0
ICdzdHJ1Y3QNCj4gc2tfYnVmZicgYXMgYnRmX2lkIDI5NjUuICBBZnRlcndhcmRzIGl0IHBhdGNo
ZXMgdGhlIHJlbG9jYXRpb25zIGluIHRoZQ0KPiBieXRlIGNvZGUuDQo+IA0KDQpIbW1tLi4uIHRo
YXQncyBzb21ldGhpbmcgSSBkZWZpbml0ZWx5IHdhbnQgdG8gdHJ5ID1EDQoNCj4gDQo+ID4gU28s
IEkgZGVjaWRlZCB0byBnaXZlIGEgdHJ5IGF0IGEgcG9zc2libGUgaW1wbGVtZW50YXRpb24sIHVz
aW5nIGlnYw0KPiA+IGRyaXZlciBhcyBJJ20gbW9yZSB1c2VkIHRvIGl0LCBhbmQgY29tZSBoZXJl
IGFzayBzb21lIHF1ZXN0aW9ucyBhYm91dA0KPiA+IGl0Lg0KPiA+IA0KPiA+IEZvciB0aGUgY3Vy
aW91cywgaGVyZSdzIG15IGJyYW5jaCB3aXRoIGN1cnJlbnQgd29yazoNCj4gPiANCj4gPiBodHRw
czovL2dpdGh1Yi5jb20vZWRlcnNvbmRpc291emEvbGludXgvdHJlZS94ZHAtaGludHMNCj4gPiAN
Cj4gPiBJdCdzIG9uIHRvcCBvZiBBbGV4YW5kciBMb2Jha2luIGFuZCBNaWNoYWwgU3dpYXRrb3dz
a2kgd29yayAtIGJ1dCBJDQo+ID4gZGVjaWRlZCB0byBpbmNvcnBvcmF0ZSBzb21lIG9mIHRoZSBD
Ty1SRSByZWxhdGVkIGZlZWRiYWNrLCBzbyBJIGNvdWxkDQo+ID4gaGF2ZSBzb21ldGhpbmcgdGhh
dCBhbHNvIHdvcmtzIHdpdGggQlBGIGFwcGxpY2F0aW9ucy4gUGxlYXNlIG5vdCB0aGF0DQo+ID4g
SSdtIG5vdCB0cnlpbmcgdG8ganVtcCBhaGVhZCBvZiB0aGVtIGluIGluY29ycG9yYXRpbmcgdGhl
IGZlZWRiYWNrIC0NCj4gPiBwcm9iYWJseSB0aGV5IGhhdmUgc29tZXRoaW5nIG1vcmUgcm9idXN0
IGhlcmUgLSBidXQgaWYgeW91IHNlZSBzb21lDQo+ID4gdmFsdWUgaW4gbXkgcGF0Y2hlcywgZmVl
bCBmcmVlIHRvIHJldXNlL2luY29ycG9yYXRlIHRoZW0gKGlmIHRoZXkgYXJlDQo+ID4ganVzdCBh
biBleGFtcGxlIG9mIHdoYXQgbm90IHRvIGRvLCBpdCdzIHN0aWxsIGFuIGV4YW1wbGUgPUQgKS4N
Cj4gPiBJIGFsc28gYWRkZWQgc29tZSBYRFAgWkMgcGF0Y2hlcyBmb3IgaWdjIHRoYXQgYXJlIHN0
aWxsIG1vdmluZyB0bw0KPiA+IG1haW5saW5lLg0KPiA+IA0KPiA+IEluIHRoZXJlLCBJIGJhc2lj
YWxseSBkZWZpbmVkIGEgc2FtcGxlIG9mICJnZW5lcmljIGhpbnRzIiwgdGhhdCBpcw0KPiA+IGJh
c2ljYWxseSBhbiBzdHJ1Y3Qgd2l0aCBjb21tb24gaGludHMsIHN1Y2ggYXMgUlggYW5kIFRYIHRp
bWVzdGFtcCwNCj4gPiBoYXNoLCBldGMuIEkgYWxzbyBpbmNsdWRlZCB0d28gbW9yZSBtZW1iZXJz
IHRvIHRoYXQgc3RydWN0OiBmaWVsZF9tYXANCj4gPiBhbmQgZXh0ZW5zaW9uX2lkLiBUaGUgZmly
c3QsIHNob3dzIHdoaWNoIG1lbWJlcnMgYXJlIGFjdHVhbGx5IHZhbGlkIGluDQo+ID4gdGhlIGRh
dGEsIHRoZSBzZWNvbmQgaXMgYW4gYXJiaXRyYXJ5IGlkIHRoYXQgZHJpdmVycyBjYW4gdXNlIHRv
IHNheQ0KPiA+ICJ0aGVyZSdzIGV4dHJhIGRhdGEiIGJleW9uZCB0aGUgZ2VuZXJpYyBtZW1iZXJz
LCBhbmQgaG93IHRvIGludGVycHJldA0KPiA+IHdoYXQncyB0aGVyZSBpcyBkcml2ZXIgc3BlY2lm
aWMuIEEgQlRGIGlzIGFsc28gY3JlYXRlZCB0byByZXByZXNlbnQNCj4gPiB0aGlzIHN0cnVjdCwg
YW5kIHJlZ2lzdGVyaW5nIGlzIGRvbmUgdGhlIHNhbWUgd2F5IFNhZWVkJ3MgcGF0Y2ggZGlkLg0K
PiA+IA0KPiA+IFVzZXIgc3BhY2UgZGV2ZWxvcGVycyB0aGF0IG5lZWQgdG8gZ2V0IHRoZSBzdHJ1
Y3QgY2FuIHVzZSBzb21ldGhpbmcNCj4gPiBsaWtlIHRvIGdldCBpdCBmcm9tIHRoZSBkcml2ZXI6
DQo+ID4gDQo+ID4gICAjIHRvb2xzL2JwZi9icGZ0b29sL2JwZnRvb2wgbmV0IHhkcCBzaG93DQo+
ID4gICB4ZHA6DQo+ID4gICBlbnA2czAoNSkgbWRfYnRmX2lkKDYwKSBtZF9idGZfZW5hYmxlZCgx
KQ0KPiA+IA0KPiA+IEFuZCB1c2UgdGhlIGJ0Zl9pZCB0byBnZXQgdGhlIHN0cnVjdDoNCj4gPiAN
Cj4gPiAgICMgYnBmdG9vbCBidGYgZHVtcCBmaWxlIC9zeXMva2VybmVsL2J0Zi9pZ2MgZm9ybWF0
IGMNCj4gPiANCj4gPiBDdXJyZW50bHkgdGhvdWdoLCB0aGF0J3MgYmFkIC0gYXMgaW4gdGhpcyBj
YXNlIHRoZSBzdHJ1Y3QgaGFzIG5vDQo+ID4gdHlwZXMsIG9ubHkgdGhlIGZpZWxkIG5hbWVzLiBX
aHk/DQo+IA0KPiBJIGRvbid0IGZvbGxvdywgd2hhdCBpcyBub3Qgd29ya2luZz8NCg0KSSBnZXQg
c29tZXRoaW5nIGxpa2UgdGhpczoNCg0KICBzdHJ1Y3QgeGRwX2hpbnRzIHsNCiAgICAgICAgIHll
dF9hbm90aGVyX3RpbWVzdGFtcDsNCiAgICAgICAgIHJ4X3RpbWVzdGFtcDsNCiAgICAgICAgIHR4
X3RpbWVzdGFtcDsNCiAgICAgICAgIGhhc2gzMjsNCiAgICAgICAgIGV4dGVuc2lvbl9pZDsNCiAg
ICAgICAgIGZpZWxkX21hcDsNCiAgfTsNCg0KTm90ZSBob3cgdGhlcmUncyBubyB0eXBlIGJlZm9y
ZSB0aGUgZmllbGRzLCBvbmUgaGFzIHRvIGZpZ3VyZSBvdXQgaWYNCmByeF90aW1lc3RhbXBgIGlz
IHUzMiBvciB1NjQuDQoNCg0KPiANCj4gPiBXaXRoIHRoZSBkcml2ZXIgc3BlY2lmaWMgc3RydWN0
IChvciBieSB1c2luZyB0aGUgZ2VuZXJpYyBvbmUsIGlmIG5vDQo+ID4gc3BlY2lmaWMgZmllbGRz
IGFyZSBuZWVkZWQpLCB0aGUgYXBwbGljYXRpb24gY2FuIHRoZW4gYWNjZXNzIHRoZSBYRFANCj4g
PiBmcmFtZSBtZXRhZGF0YS4gSSd2ZSBhbHNvIGFkZGVkIHNvbWUgaGVscGVycyB0byBhaWQgZ2V0
dGluZyB0aGUNCj4gPiBtZXRhZGF0YS4NCj4gPiANCj4gPiBJIGFkZGVkIHNvbWUgZXhhbXBsZXMg
b24gaG93IHRvIHVzZSB0aG9zZSAodGhleSBtYXkgYmUgdG9vIHNpbXBsaXN0aWMpLA0KPiA+IHNv
IGl0J3MgcG9zc2libGUgdG8gZ2V0IGEgZmVlbCBvbiBob3cgdGhpcyBBUEkgbWlnaHQgd29yay4N
Cj4gPiANCj4gPiBNeSBnb2FscyBmb3IgdGhpcyBlbWFpbCBhcmUgdG8gY2hlY2sgaWYgdGhpcyBh
cHByb2FjaCBpcyB2YWxpZCBhbmQgd2hhdA0KPiA+IHBpdGZhbGxzIGNhbiB5b3Ugc2VlLiBJIGRp
ZG4ndCBzZW5kIGEgcGF0Y2ggc2VyaWVzIHlldCB0byBub3QganVtcA0KPiA+IGFoZWFkIEFsZXhh
bmRyIGFuZCBNaWNoYWwgd29yayAoSSBjYW4gcmViYXNlIG9uIHRvcCBvZiB0aGVpciB3b3JrDQo+
ID4gbGF0ZXIpIGFuZCBiZWNhdXNlIHRoZSBpZ2MgUlggYW5kIFRYIHRpbWVzdGFtcCBpbXBsZW1l
bnRhdGlvbiBJJ20gdXNpbmcNCj4gPiB0byBwcm92aWRlIG1vcmUgcmVhbCBsb29raW5nIGRhdGEg
aXMgbm90IHlldCBjb21wbGV0ZS4NCj4gPiANCj4gPiBBbm90aGVyIGdvYWwgaXMgdG8gZW5zdXJl
IHRoYXQgQUZfWERQIHNpZGUgaXMgbm90IGZvcmdvdHRlbiBpbiB0aGUgWERQDQo+ID4gaGludHMg
ZGlzY3Vzc2lvbiA9RA0KPiANCj4gVGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dCA6LSkNCj4g
DQo+ID4gTmF0dXJhbGx5LCBpZiBzb21lb25lIGZpbmRzIGFueSBpc3N1ZSB0cnlpbmcgdGhvc2Ug
cGF0Y2hlcywgcGxlYXNlIGxldA0KPiA+IG1lIGtub3chDQo+IA0KDQo=

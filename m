Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14BB354837
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 23:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhDEVij (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 17:38:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:21934 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237293AbhDEVih (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 17:38:37 -0400
IronPort-SDR: n5gxRxSKNYRuMD6B+Vb1NwhPiMoO+S5bInZud8R9+yLR7Ssbs2cl0tSq9bTgezFE6PXfSrF69e
 Hf33btbTc93w==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="192967920"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="192967920"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:38:29 -0700
IronPort-SDR: GipemXWwqACx9oecvidB04GpWNOkqHatJlHaWS5CrSgjtPNjnq3n/8wECQ16Cgferig2QXBEjW
 wbt1iBmh7Jrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="395956653"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2021 14:38:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Apr 2021 14:38:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 5 Apr 2021 14:38:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 5 Apr 2021 14:38:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H49jLf16xQJJ/EXQgDQIyAkXrO3GxwsAEL4QzVrVno3soM7xvImXSpjVTFPJ9tt4W0ku+OTWvABsvrFBmtmcCFPIArI9E04PdE4mn2uj89nttksWX1ZycYIRO782N4uDPIVLnuolB8ycN5kNwBznZrXju2ZtA0DsRNjg6mBLXH0KYBu5JyyaAHCOPEfoVY5/WoASNzJZ0e+ksCmXq5pd4dbEoTE7JsILWcKLrD22FSZUNOiPREtI75odO86vNDCrrp+fiITnZ0qemsUr6ybgLGVMQvJxE/MNMAkXYiLuovq/3dRe3tOF2aHD03vILiacCkJDROxuLV9SoclcO1gSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg+HZMEjpyYwUCQ8qSj5cM5yvZUt6FpoujZVQiBnh/o=;
 b=iZMhaD8ZMEeBvUX/oOnINaIbEJRxUCfPYPX31lPjvZQNr9vBB2LlhHbZnjlh8D9ZQo+Bd/SfDAzy+7NaypysMDp7F4U6kofJAVg0Hnpg8iNCBN3LrfMgUIZagzTJFeYic5liXkaMCAd4H76mI5ozg+Mg2WUVs1Z98DDw6rXk5edd/jlMyyjIMIkfTzlmIjGzGV7Iwm7waxwcBQgC18Apf6SnUisEfcr7yB9YtafuiIAbmGHL2L8Vjbc1LHPS69d82dyeJC4lpGdGhzxdWBhqkO3xs+f4GRZyPaNLnfQsFG1sOEnHBSBz/W1IOBKkHV5I9E7g69h06GLLROQu6yRKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg+HZMEjpyYwUCQ8qSj5cM5yvZUt6FpoujZVQiBnh/o=;
 b=NpcwEXSU424mJwP0oc8c9/83QflrLhUhEGhu0LETE0f6X3KdWwCFNfZ6vsx8ic+fPfV0n12ZMEa/e+Prejo5ux0kKdrqY9BxEkKBbh+AYlaqhuWf0T8Eb6wBjyKHhFBpXQ9aZYAgDoaQ8D5ibevmEpu0LbO7QuC1+RO9oRx/8ms=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 21:38:23 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::cd24:a9b7:365a:9a4b]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::cd24:a9b7:365a:9a4b%7]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 21:38:23 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "luto@kernel.org" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 2/3] vmalloc: Support grouped page allocations
Thread-Topic: [RFC 2/3] vmalloc: Support grouped page allocations
Thread-Index: AQHXKlwTWbZ5r45W4Eav1hIQzLwkw6qmaRwAgAAKLAA=
Date:   Mon, 5 Apr 2021 21:38:22 +0000
Message-ID: <95a608e850a66af2add6ffcdeb5c6b5c057f1002.camel@intel.com>
References: <20210405203711.1095940-1-rick.p.edgecombe@intel.com>
         <20210405203711.1095940-3-rick.p.edgecombe@intel.com>
         <971aae01-32a0-3f45-1810-010e3295b1c4@intel.com>
In-Reply-To: <971aae01-32a0-3f45-1810-010e3295b1c4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89b81599-7d24-42e3-b682-08d8f87b235a
x-ms-traffictypediagnostic: SA2PR11MB4796:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB479612022403CC97BCC808D1C9779@SA2PR11MB4796.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lgGqjx7O0EyevwZaM7d9zNCNnBFMF5GsgI2SgaDbPRwJvE3PtlC6NMp4XBTpzFFDF2L221QI0mzxaTB0aQ/x/7lHhiZdV8odq9cSraShWTMRbV3McMY0mxuQWNHcZtwIONFulxO9GBokP+Gp9CPh56Z0spTHkdFDlwyagLVfSGKVjWHwJ5WWMF2lmX4uSZiZVw6brZAWHtdpAVJ/lPcpNyeAl6UdLxCHkNFNv9O429WYubX5NlgCSzb4dCg7WXlgZW6yO9oPBDC6rOENuXenj1rbZlXaGzqsxtiD52zCzrqBFO928Q/d9EvqwyAi12vnp6iycSpYYa/utbJG6WG/Aezzj8V+VPcImQpGGYJVAJMOGVRdinIKb+BF6BTfJlhEoQltq14gfGQlTxMdkiFkaUmVRaGSBSbp4xECHxQE178U5EBnihpGFfjJ6DkL3exydW+E0RITkK0z3MsoW+5pZ8GTvg+zWTda10qN/sqpt0Jgs+U57bfvI5Q9w9Dxn4i903sDNUqNMewxe/EmvV4UU0N9j6QRk0liLPwYCyCaW36OkeGprzIGAmSQPN81J4A/HxlZzqw/5p5T7DdOS4Qm0B3v2ZvqsLr399o6Gz/AJVglMAuaQcRZmnGdYZ47vk6Hu/ntiIag5mbOZAZ14DLegtCCCzarF6j0p4TevRkGRq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(66946007)(66556008)(186003)(66476007)(76116006)(8676002)(110136005)(64756008)(66446008)(8936002)(54906003)(7416002)(2906002)(36756003)(6506007)(91956017)(4326008)(6512007)(83380400001)(6486002)(26005)(478600001)(2616005)(86362001)(71200400001)(316002)(53546011)(38100700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M214Y0J3OTBaazVwNXBhd3dqaFFwOGF5bmdsT3dWVzh4TUpCbTR4TzgrQktY?=
 =?utf-8?B?ZERxd1h6WUk5Q0pWa2Rza2xwcEpoSDVHSFEyamhwMGJOQk1kSDM1VlBtSVNv?=
 =?utf-8?B?cHhtOWNzNzJpUTI1TUJDbTBqWFN6TVVWZzdvNk56czhmQkV3eWM3NkVqdjdn?=
 =?utf-8?B?SlY0cHhFajRVNXhwM2duWjVleVNNanhaQnE4M3Q0V2JEekRJRTlFSEZUNk1M?=
 =?utf-8?B?ajdGU2FSOGltbFhpTUpNdXkrWXpsbzZ3dHp3MWZIMFZFYnEzN091b0YxTnBs?=
 =?utf-8?B?RHp4dHN2ZWJObXRxOWF4U0FhNW1IcGNpeWRROFZoemc2MTFUL0hBRUQwVHlZ?=
 =?utf-8?B?U1c3aDk0MGVXdklIWnJHVEw5TWVmY1FyWGlKcWtKS2k5L0NWTVhqaDdCcnQ0?=
 =?utf-8?B?OHkyWDVMd0htSEprVElEc21uZnEvb3Bwek1hcmNnN2FDSGpyN24wRnBmOTN3?=
 =?utf-8?B?RENxN0ZrY3JnNlpwQjViQUQybUNTN29TWUJQZ1l1c0creUFJTkVwazl0OWpH?=
 =?utf-8?B?NzZYSVNlVUJZMFFwQ0VyMUFnLzkwQy90ZGQxM1JlK1Rxb2FrWDFUejU3U0lp?=
 =?utf-8?B?R2lMRmxmRHUza28zQTNKK0g0OEFLcndXR1owSzM2UXR4Q2xXZW9rQmRsY2ZV?=
 =?utf-8?B?WE5yV0VzTm41b0x5UEttaXVBNWd4NU9FU1R6TEJ6Y0VOZGczY0FtRVUyMkM5?=
 =?utf-8?B?Q3Rya3cxaEdHaWtmcVIySFVUaXc0d1FVUHpaMmZKTDByaWpwci91N2l2RFRm?=
 =?utf-8?B?bS9SMS9hYklRMTZwWGR5MjdpQ3ZFQjFzZkhlb2RKUXNOUmFsSEJ1QkhSU3Jq?=
 =?utf-8?B?Q00vaUZ0UTJraFlKRDdtSk1VMnlHR3h0WXhjeURGclhVQWFCZFJaa21Vdmpy?=
 =?utf-8?B?RVdYMDRLZFNHaVdHZXRJMFV6Q3RwalNXWmhjTUZNUThuNGZRQklaa0FkbFNO?=
 =?utf-8?B?V0hXSEdKUTJrbUtCN3JNZVF5WHR0dy9UY2kvazZheEo4dG9YL0lHeUNEakhw?=
 =?utf-8?B?cFo5ekhwSlN0elhKZUNyV3pia2Zqa2xKc2cxWE9kekE1UDBtVEw3SE9iUitY?=
 =?utf-8?B?SjUwN0xoMmFXN1pGSm05U1lXMHh0cmY4bzBZNGk1cmN3Z0I1LzVFYXk1Zy81?=
 =?utf-8?B?VzFnMFlxayt2RGJ1RkdIM1FDS2ZGSXFvWlp6aFJoYkNBMHI4SGVkS3haM0Nu?=
 =?utf-8?B?OHdHZFROLzJYUDJGUkwydXZNTE1Bbi92VHJ1TXJjQXdHSjl1VnMvTzdrbWJs?=
 =?utf-8?B?UGhmNjZvb1FFbUorTlh2Y3NtcUtjdFFuZlFtWUhsdnVPSXN1OExJeWRYTFh4?=
 =?utf-8?B?dFR0SFFSbEdoUytDeEJVd0lONWZ6UGxiaGZwbzJGTXZxU2E1eHdoUGozVEFI?=
 =?utf-8?B?THpUamMwZjVQNXNWU1loYTk3VTM0RkUwT1FGYWtPY25HQWdLci9iVERITVpp?=
 =?utf-8?B?ZUN0N1dsdXhUUTNGR3lRT3Flc0dTYkRMWVRCcWpwSHJYY3E3U1NDOC9BUGxh?=
 =?utf-8?B?bGhId2lFMzM1b1J0TmtyZFR5U1ZTQm1ET1BJYkVvYnpBMUovV3JmN2MweTR1?=
 =?utf-8?B?NTUyNjJjdmkyOTM0ZzdEUHdxeVFHQWlGL3RzM0JaeEJDSjA1NTBSVi9vV0xR?=
 =?utf-8?B?M1VDNldtVUx5RDR5aHNkUWQ0NEtaT1dEWlhaTlJlWHBmSWZzejNSczlNWXZj?=
 =?utf-8?B?RDVWNnBUdm9JSkQvWEJONU1yUVVaSnlQWWMxYmpXMmZNWTErRktMMFZDWlY2?=
 =?utf-8?Q?Zz3eLnyEcZN3FyWTERA8AQxCGmfhVX9b6pGHqRp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86E01A3548E88E47A12B2C6426A19F19@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b81599-7d24-42e3-b682-08d8f87b235a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 21:38:22.9569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXj40pmWKH+LteMb7lh/vBWV7FKZh10QxHqCuPbFO6cuhL3zOLtC5L5Lb8aKtBonQhIz1OC2aDXcocANENJVGndVwZG7/I/5mcRee8u6QCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIxLTA0LTA1IGF0IDE0OjAxIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNC81LzIxIDE6MzcgUE0sIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+ICtzdGF0aWMgdm9p
ZCBfX2Rpc3Bvc2VfcGFnZXMoc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkNCj4gPiArew0KPiA+ICvC
oMKgwqDCoMKgwqDCoHN0cnVjdCBsaXN0X2hlYWQgKmN1ciwgKm5leHQ7DQo+ID4gKw0KPiA+ICvC
oMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfc2FmZShjdXIsIG5leHQsIGhlYWQpIHsNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGlzdF9kZWwoY3VyKTsNCj4gPiArDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFRoZSBsaXN0IGhlYWQgaXMgc3RvcmVk
IGF0IHRoZSBzdGFydCBvZiB0aGUgcGFnZQ0KPiA+ICovDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGZyZWVfcGFnZSgodW5zaWduZWQgbG9uZyljdXIpOw0KPiA+ICvCoMKgwqDC
oMKgwqDCoH0NCj4gPiArfQ0KPiANCj4gVGhpcyBpcyBpbnRlcmVzdGluZy4NCj4gDQo+IFdoaWxl
IHRoZSBwYWdlIGlzIGluIHRoZSBhbGxvY2F0b3IsIHlvdSdyZSB1c2luZyB0aGUgcGFnZSBjb250
ZW50cw0KPiB0aGVtc2VsdmVzIHRvIHN0b3JlIHRoZSBsaXN0X2hlYWQuwqAgSXQgdG9vayBtZSBh
IG1pbnV0ZSB0byBmaWd1cmUgb3V0DQo+IHdoYXQgeW91IHdlcmUgZG9pbmcgaGVyZSBiZWNhdXNl
OiAic3RhcnQgb2YgdGhlIHBhZ2UiIGlzIGEgYml0DQo+IGFtYmlndW91cy7CoCBJdCBjb3VsZCBt
ZWFuOg0KPiANCj4gwqAqIHRoZSBmaXJzdCAxNiBieXRlcyBpbiAnc3RydWN0IHBhZ2UnDQo+IG9y
DQo+IMKgKiB0aGUgZmlyc3QgMTYgYnl0ZXMgaW4gdGhlIHBhZ2UgaXRzZWxmLCBha2EgKnBhZ2Vf
YWRkcmVzcyhwYWdlKQ0KPiANCj4gVGhlIGZhY3QgdGhhdCB0aGlzIGRvZXNuJ3Qgd29yayBvbiBo
aWdtZW0gc3lzdGVtcyBtYWtlcyB0aGlzIGFuIE9LDQo+IHRoaW5nDQo+IHRvIGRvLCBidXQgaXQg
aXMgYSBiaXQgd2VpcmQuwqAgSXQncyBhbHNvIGRvdWJseSBzdXNjZXB0aWJsZSB0byBidWdzDQo+
IHdoZXJlIHRoZXJlJ3MgYSBwYWdlX3RvX3ZpcnQoKSBvciB2aXJ0X3RvX3BhZ2UoKSBzY3Jld3Vw
Lg0KPiANCj4gSSB3YXMgKmhvcGluZyogdGhlcmUgd2FzIHN0aWxsIHN1ZmZpY2llbnQgc3BhY2Ug
aW4gJ3N0cnVjdCBwYWdlJyBmb3INCj4gdGhpcyBzZWNvbmQgbGlzdF9oZWFkIGluIGFkZGl0aW9u
IHRvIHBhZ2UtPmxydS7CoCBJIHRoaW5rIHRoZXJlDQo+ICpzaG91bGQqDQo+IGJlLsKgIFRoYXQg
d291bGQgYXQgbGVhc3QgbWFrZSB0aGlzIGFsbG9jYXRvciBhIGJpdCBtb3JlICJub3JtYWwiIGlu
DQo+IG5vdA0KPiBjYXJpbmcgYWJvdXQgcGFnZSBjb250ZW50cyB3aGlsZSB0aGUgcGFnZSBpcyBm
cmVlIGluIHRoZSBhbGxvY2F0b3IuwqANCj4gSWYNCj4geW91IHdlcmUgYWJsZSB0byBkbyB0aGF0
IHlvdSBjb3VsZCBkbyB0aGluZ3MgbGlrZSBrbWVtY2hlY2sgb3IgcGFnZQ0KPiBhbGxvYyBkZWJ1
Z2dpbmcgd2hpbGUgdGhlIHBhZ2UgaXMgaW4gdGhlIGFsbG9jYXRvci4NCj4gDQo+IEFueXdheSwg
SSB0aGluayBJJ2QgcHJlZmVyIHRoYXQgeW91ICp0cnkqIHRvIHVzZSAnc3RydWN0IHBhZ2UnIGFs
b25lLg0KPiBCdXQsIGlmIHRoYXQgZG9lc24ndCB3b3JrIG91dCwgcGxlYXNlIGNvbW1lbnQgdGhl
IHNub3Qgb3V0IG9mIHRoaXMNCj4gdGhpbmcNCj4gYmVjYXVzZSBpdCBfaXNfIHdlaXJkLg0KDQpZ
ZXMgc29ycnksIHRoYXQgZGVzZXJ2ZWQgbW9yZSBleHBsYW5hdGlvbi4gSSB0cmllZCBwdXR0aW5n
IGl0IGluIHN0cnVjdA0KcGFnZSBhY3R1YWxseS4gVGhlIHByb2JsZW0gd2FzIGxpc3RfbHJ1IGF1
dG9tYXRpY2FsbHkgZGV0ZXJtaW5lcyB0aGUNCm5vZGUgaWQgZnJvbSB0aGUgbGlzdF9oZWFkIHBy
b3ZpZGVkIHRvIGl0IHZpYQ0KcGFnZV90b19uaWQodmlydF90b19wYWdlKGhlYWQpKS4gSSBndWVz
cyBpdCBhc3N1bWVzIHRoZSBsaXN0X2hlYWQgaXMgb24NCnRoZSBhY3R1YWwgaXRlbS4gSSBzdGFy
dGVkIGFkZGluZyBhbm90aGVyIGxpc3RfbHJ1IGZ1bmN0aW9uIHRoYXQgbGV0DQp0aGUgbm9kZSBp
ZCBiZSBwYXNzZWQgaW4gc2VwYXJhdGVseSwgYnV0IEkgcmVtZW1iZXJlZCB0aGlzIHRyaWNrIGZy
b20NCnRoZSBkZWZlcnJlZCBmcmVlIGxpc3QgaW4gdm1hbGxvYy4NCg0KSWYgdGhpcyBldmVyIGV4
cGFuZHMgdG8gaGFuZGxlIGRpcmVjdCBtYXAgdW5tYXBwZWQgcGFnZXMgKHdoaWNoIHdvdWxkDQpw
cm9iYWJseSBiZSB0aGUgbmV4dCBzdGVwKSwgdGhlIGxpc3RfaGVhZCB3aWxsIGhhdmUgdG8gYmUg
bW92ZWQgb3V0IG9mDQp0aGUgYWN0dWFsIHBhZ2UgYW55d2F5LiBCdXQgaW4gdGhlIG1lYW50aW1l
IGl0IHJlc3VsdGVkIGluIHRoZSBzbWFsbGVzdA0KY2hhbmdlLg0KDQpJIGNhbiB0cnkgdGhlIG90
aGVyIHdheSBpZiBpdCdzIHN0aWxsIHRvbyB3ZWlyZC4NCg0K

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030B43CACA8
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244291AbhGOTlC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 15:41:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:3220 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245485AbhGOTh2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 15:37:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="190990529"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="190990529"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="562902238"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 15 Jul 2021 12:34:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 15 Jul 2021 12:34:22 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 15 Jul 2021 12:34:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 15 Jul 2021 12:34:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 15 Jul 2021 12:34:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/ABy283kj6u37cKzhj8RuXY7QvtuvtsBouZI2phtVID3IZ4sVyTYJyWxIXRqLNoXFYOlYLLG4qZf1+y9iLHOs2qjuaTX4QmB5rQSL1rrLVjzx48M5dRPyiBDIGz1z/aikIj58L8A2hTVuLKtfiZQNNLJCX27yuULVtKFKULVPrtc8itRN7qbpXCtbbWvP1CyeMt8GdrjpuQqwozVtErV9NHYkVTt4eKzLcpUak1ZHtB3NyLtqfw4StTUHaxEpsPV9TvluzdyhtYcHrfLp1e/qWLPq6UlMykA1h+lbhlvBxt3IWKxe3mYdqyy1fMJt5UXZG6OcN1tkx4vAJBfGZguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Z+D15Bl0zz20MgHDO4cOsVAgtq3KzPZSKEeVsoUPYQ=;
 b=SDLqQtWv6t3TmDNoA0K828P8yMBu+IW5PZk24XGW1345hXf0kxQrlETKut1tXVDO6VWelJfEj7wrIc/VDjHSm0cXHoAoqhd4C4N1m7+Riq5phJtuXSrTe1yRaK+ToOW+tyBSVE3Svn8rOYfSa/rxx0fb0TKxomVo+UC29UldIAW5+Qd7/344E/8PJNemsx/MFsCWtbu2iyffMOwmRDn39HWii18KMshehK3jzfReoMg8Edasm/G5EnqBmhYukdfIfl/E9C0E3Gd2gAF7lV38mjjQ/d12vJDhixYxPDmqAwb9WfwXP//gSim1wdFyMcQq6HBlzTHEGBhXTIm9v0KwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Z+D15Bl0zz20MgHDO4cOsVAgtq3KzPZSKEeVsoUPYQ=;
 b=hEQWKNYoGdqXiAd2yWzEmujgd9rzrOeeIFUbQdg57U8TFCrmMp/vQPxfVlrf4HqLqOhRn4tPWaS8zULFEq7xGHSnRwlFwch/Sk/m2ITyHYgCu5V8l6/OSI1Xu9LZw4RVtkhKQXHtywkukYCOCVYrpd+Cau0ynaoT2bKbGVvwy/Y=
Received: from CY4PR11MB1624.namprd11.prod.outlook.com (2603:10b6:910:8::12)
 by CY4PR1101MB2086.namprd11.prod.outlook.com (2603:10b6:910:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 19:34:21 +0000
Received: from CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::d9f8:2dbd:528:b467]) by CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::d9f8:2dbd:528:b467%4]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 19:34:21 +0000
From:   "Desouza, Ederson" <ederson.desouza@intel.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "saeed@kernel.org" <saeed@kernel.org>
Subject: Re: A look into XDP hints for AF_XDP
Thread-Topic: A look into XDP hints for AF_XDP
Thread-Index: AQHXaI1NCoqWOcnh50mPov3W8E+846sjlEyAgAAhr4CAFHdFgIAMYnSA
Date:   Thu, 15 Jul 2021 19:34:20 +0000
Message-ID: <de1d83e6d50131858184adf750f6509db425c107.camel@intel.com>
References: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
         <20210624215411.79324c9d@carbon>
         <adfc8f598e5de10fa40a4e791a1e8722edae1136.camel@intel.com>
         <CAEf4BzYHZRRGTwMswAUrtcpSyox_-5p1yMDwf21oK7tBCqViZA@mail.gmail.com>
In-Reply-To: <CAEf4BzYHZRRGTwMswAUrtcpSyox_-5p1yMDwf21oK7tBCqViZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.3 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38efeb17-295a-4201-6833-08d947c78b43
x-ms-traffictypediagnostic: CY4PR1101MB2086:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB208681C59B3BB5976C3CB6CEF6129@CY4PR1101MB2086.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yr6ma06HW03j5z4M/VgaYFgLoO8i9xightECDhns6AFcAs1jyzIJeB45JvFjhxH1sAcz5bQkf96s9Lzrsx0mMamrKci7dLyeY3pmGIwMElTU1IYMboly70ejPbjkwSniOFOQXYr0/+p9SlMuhfddylaEReIEwl8MkyarRS55s3PNQt7M44eCYIjQCMn4dM8UUN7NToWnlCadBUJdvctX2JAeS5B0xIyaLfvFMDrQ9T5Zlt43me+UB0elGjhLdimHjEMuZ6TAXMr7Tq+yqfjoZXdyX+/4obGNgh3pTU/+wzI6GdVYdfjIr7NvRuEcqNK9KIufQrzf5ctdIWxGOBALupR/ktvW2nB3Q0DKlE/Voov9TCrF5+cGHNkrS2rkKNVdUHEqD1d1r3C9GWMhl1Opu9che8wwwPWSDgc8d2/IEZ0J5H4r7GP8UP5+uGFdKp6KOhlCx5jwkxCRd9xyNXlkjOdPD4iQ3hxsc28NhOFHXkTl/Nb/SZ17H43lIcx4tXVwa+AdtqkiUPgDBuUL3P6NRGRmXJ1lo2ke/bSYmycvJwswmdwDp5Io/S2NbvrPdDw8xgzqDQ1Hb/E4GUHhraQXE52XMJCpeXJLEC0levGf+q84ev+GcA0A5PVyEjHNub8WG6ZxGa/8vVisPnKc0kl5OPPGT7Gkdu7KaRAHTd4cr8cjUkRQaIpf2QvpuuVOoR7q+hH8/2YYOj8USQTeKRsUVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(6506007)(71200400001)(2616005)(316002)(478600001)(6486002)(38100700002)(54906003)(122000001)(4326008)(8676002)(86362001)(8936002)(66556008)(66476007)(6916009)(91956017)(2906002)(5660300002)(186003)(83380400001)(36756003)(64756008)(66946007)(6512007)(66446008)(76116006)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDhCakNqdS9sc1k1TDRhbjh5L2tQWXJVeFl2TFZwWlZ6Ykh3OTN5R1Y3bWNO?=
 =?utf-8?B?YkRMeTFCVzlMczRVcHFqdHRSM1hjaVZtcXNrblc1WjNCWG9wenhFdVB3RG5Y?=
 =?utf-8?B?NnVKSzVjVU9LcVByZTRxY1ZqZHJEL2Z6bUE5ajB1aDdodFY1bW9USVFRVUpX?=
 =?utf-8?B?MDhSY0ZOSGJqQWV5eDNHL2FCOG41dmxGb3dJWlVsUE9tY3RRSGhPdWdNbFFu?=
 =?utf-8?B?R2hpeEovbFFPVTYzY0RGeTJGTmtQUUp6NVlUeFY0bzNud0VMdkttR2VIcStE?=
 =?utf-8?B?djVPMnNjSGE1bWZ4NU40cmt1a0V0UUtFc08zSFlWbE9ZdlREU3ZpTkErOUlK?=
 =?utf-8?B?NkhYeGI1Y3Y5R2FjalZOMVo3bjNxR1RHalJhZ3NUUjhvY2IwM2Q1ejNSMHh1?=
 =?utf-8?B?cndCL1Z0WUZLamNDUWdOVm81ejVHS2ZzTFJCbVVxQy9KZHlFYm5ZMG5zWDdr?=
 =?utf-8?B?MWo1WGthaGFENjVzNzV5SXRXejA3ZHFCUk5IczRxdUFCMW12UXBYRllLL1Ay?=
 =?utf-8?B?TjZON1oyOVJRMlR3VWdNNVJUakVtUnZZSnREMVRKVm4ybWV4SkwvU3dXeVly?=
 =?utf-8?B?dE5LUGJpYVoyOGZ6citJamtLYjk4cU8wamE2VjcxS2JyTEd6N1NBTVR2bDl5?=
 =?utf-8?B?M051dy85RllkMVBkekFhVDRBWkg3Q0dCc2RoamlMdG92a0VnaDBIN0NRaVJI?=
 =?utf-8?B?ZTBjckJsSWF3dWxyMU5VZm9hSGpHd1BOV3lTQkwwenJ0ZmxaTUswTkxSMlc5?=
 =?utf-8?B?cVRYbDJ1dldmK29pY3ZNMmN4YkZsb2FacFk3TVZibHFHNW1iRG1KQ05NQkpm?=
 =?utf-8?B?QmNxNGN1dUJvL01VY1lIditndGl3bFF1LzcxcUFCQktTQ2Fub1pXRmxjR2Ex?=
 =?utf-8?B?UkxrQ2c3bWJQTGZvY2RIWWxVL3pLVElBdWZFYytoUjZCUGFUbXpTSWtnZDhq?=
 =?utf-8?B?MVY3ckhrdlM1MWRJeGZadFc2QlNMWnJlaGdxWHE5SlBwSTNzaGk5M1cxSlFl?=
 =?utf-8?B?czlQSlAwUXBwZUxqQVRnZ09uVnVQUWgxbEVkQllaSFh2MW12SlM2dk9vaTZG?=
 =?utf-8?B?RElLVURQTGxZNThzZVorTW43UnJJYjgrVTFkUzc2QlZIRldML3ZrUjlWS1B6?=
 =?utf-8?B?U0hnS1VPSnFIdFVKcFlkRlVrc1YwcW1SZ0xLaWxTelFsTDJNVUJXUkI0RDA5?=
 =?utf-8?B?L3FKeDAwUUVPRTRzYVF4dHZaYXV0b3cxRVVDZlY0RzFzcXg3NUhPWk1CQnJ5?=
 =?utf-8?B?b0ltTEx5SlkrUFVZNHpqQVo0MXFseFo4RmxWbVpxNHB0bHBEMDE5TXFHZTRP?=
 =?utf-8?B?U1NYYURwc2s5UHZFdHAyajFVNUxVOGtxSmxIQ3hNNnpqM3FtbUJsRHhJZysz?=
 =?utf-8?B?NUZpNDlWbUVEKzViK2tCSHVzdmtaM0NyNEtibEIxdko2MWk1cGhOMEd0aDBy?=
 =?utf-8?B?eW0zMnM1RmEvdHRpb1V1RUdVUlFXRFE4RStzVWQ1dUsvUHZjVjc1U0h1RXIz?=
 =?utf-8?B?eXRlU21LK2FJa3NJdlZQWG1GQ2hZWFVxRlF2d21sbXBhN1RTcFNOQkZ1d1E1?=
 =?utf-8?B?UVhUcGhRZGFiUDR6RW1YRmFudit0Yll6aXhmbmtidEw2WjBoMDlFYXpNZ29D?=
 =?utf-8?B?R0w0RndMaW1ZV2NvNUovcERWbnhhZ3BoVUUyMmdRbndDYjFBNUUwSFhpaktC?=
 =?utf-8?B?UWJ4d0YzOU4vWWdpa2RDR0tKU1UvcGZGWk1hNnpkRU9SaGpUeWFoenVXcmkr?=
 =?utf-8?B?Y0lFanpsaEVwenMxMFVIejRpK1lmRlUwQlpZY0FYSkxGcEp5OG1vZTNYSXdm?=
 =?utf-8?B?STNUd2Mrbml5UzFwanNxT1VpNndPbCtaRHBNaStPeVBEa2o4SGd2N3hMSjl1?=
 =?utf-8?Q?uWLNcusQGwkQx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6940DEE6327844F899E578212AEC970@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38efeb17-295a-4201-6833-08d947c78b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 19:34:20.4972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZE07aU6VEVjNjt0tVH+LDQacK/4Jkq4wPXNen7CNqAjqpxnwlue0d9Za2he+VoRo2E7DRD1cd/NI+KK3hjV6/PPdUDbifwF6byAWOdvY+0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2086
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTA3IGF0IDE1OjI2IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQpbc25pcF0NCj4gPiA+IEkgZG9uJ3QgZm9sbG93LCB3aGF0IGlzIG5vdCB3b3JraW5nPw0KPiA+
IA0KPiA+IEkgZ2V0IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+ID4gDQo+ID4gICBzdHJ1Y3QgeGRw
X2hpbnRzIHsNCj4gPiAgICAgICAgICB5ZXRfYW5vdGhlcl90aW1lc3RhbXA7DQo+ID4gICAgICAg
ICAgcnhfdGltZXN0YW1wOw0KPiA+ICAgICAgICAgIHR4X3RpbWVzdGFtcDsNCj4gPiAgICAgICAg
ICBoYXNoMzI7DQo+ID4gICAgICAgICAgZXh0ZW5zaW9uX2lkOw0KPiA+ICAgICAgICAgIGZpZWxk
X21hcDsNCj4gPiAgIH07DQo+IA0KPiBpdCBjb3VsZCBiZSBkdWUgdG8gY29ycnVwdGVkIEJURi4g
Q2FuIHlvdSBzaG93IG91dHB1dCBvZg0KPiANCj4gYnBmdG9vbCBidGYgZHVtcCBmaWxlIC9zeXMv
a2VybmVsL2J0Zi9pZ2MNCj4gDQo+IChub3RlIG5vICJmb3JtYXQgYyIpLg0KPiANCg0KRXJyci4u
LiBmb3VuZCBvdXQgdGhlIGlzc3VlIG9uIG15IHNpZGUgLSB0aGlzIGlzIGEgQlRGIGRlc2NyaWJl
ZCBieQ0KaGFuZCwgYW5kIEkgZGlkbid0IG5hbWUgdGhlIHR5cGVzIC0gb25seSBkZWZpbmVkIHRo
ZWlyIHNpemUgYW5kDQpiaXRzX29mZnNldC4gU29ycnkgZm9yIHRoZSBub2lzZSENCg0KPiA+IA0K
PiA+IE5vdGUgaG93IHRoZXJlJ3Mgbm8gdHlwZSBiZWZvcmUgdGhlIGZpZWxkcywgb25lIGhhcyB0
byBmaWd1cmUgb3V0IGlmDQo+ID4gYHJ4X3RpbWVzdGFtcGAgaXMgdTMyIG9yIHU2NC4NCj4gPiAN
Cj4gPiANCj4gPiA+IA0KPiA+ID4gPiBXaXRoIHRoZSBkcml2ZXIgc3BlY2lmaWMgc3RydWN0IChv
ciBieSB1c2luZyB0aGUgZ2VuZXJpYyBvbmUsIGlmIG5vDQo+ID4gPiA+IHNwZWNpZmljIGZpZWxk
cyBhcmUgbmVlZGVkKSwgdGhlIGFwcGxpY2F0aW9uIGNhbiB0aGVuIGFjY2VzcyB0aGUgWERQDQo+
ID4gPiA+IGZyYW1lIG1ldGFkYXRhLiBJJ3ZlIGFsc28gYWRkZWQgc29tZSBoZWxwZXJzIHRvIGFp
ZCBnZXR0aW5nIHRoZQ0KPiA+ID4gPiBtZXRhZGF0YS4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgYWRk
ZWQgc29tZSBleGFtcGxlcyBvbiBob3cgdG8gdXNlIHRob3NlICh0aGV5IG1heSBiZSB0b28gc2lt
cGxpc3RpYyksDQo+ID4gPiA+IHNvIGl0J3MgcG9zc2libGUgdG8gZ2V0IGEgZmVlbCBvbiBob3cg
dGhpcyBBUEkgbWlnaHQgd29yay4NCj4gPiA+ID4gDQo+ID4gPiA+IE15IGdvYWxzIGZvciB0aGlz
IGVtYWlsIGFyZSB0byBjaGVjayBpZiB0aGlzIGFwcHJvYWNoIGlzIHZhbGlkIGFuZCB3aGF0DQo+
ID4gPiA+IHBpdGZhbGxzIGNhbiB5b3Ugc2VlLiBJIGRpZG4ndCBzZW5kIGEgcGF0Y2ggc2VyaWVz
IHlldCB0byBub3QganVtcA0KPiA+ID4gPiBhaGVhZCBBbGV4YW5kciBhbmQgTWljaGFsIHdvcmsg
KEkgY2FuIHJlYmFzZSBvbiB0b3Agb2YgdGhlaXIgd29yaw0KPiA+ID4gPiBsYXRlcikgYW5kIGJl
Y2F1c2UgdGhlIGlnYyBSWCBhbmQgVFggdGltZXN0YW1wIGltcGxlbWVudGF0aW9uIEknbSB1c2lu
Zw0KPiA+ID4gPiB0byBwcm92aWRlIG1vcmUgcmVhbCBsb29raW5nIGRhdGEgaXMgbm90IHlldCBj
b21wbGV0ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEFub3RoZXIgZ29hbCBpcyB0byBlbnN1cmUgdGhh
dCBBRl9YRFAgc2lkZSBpcyBub3QgZm9yZ290dGVuIGluIHRoZSBYRFANCj4gPiA+ID4gaGludHMg
ZGlzY3Vzc2lvbiA9RA0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0
IDotKQ0KPiA+ID4gDQo+ID4gPiA+IE5hdHVyYWxseSwgaWYgc29tZW9uZSBmaW5kcyBhbnkgaXNz
dWUgdHJ5aW5nIHRob3NlIHBhdGNoZXMsIHBsZWFzZSBsZXQNCj4gPiA+ID4gbWUga25vdyENCj4g
PiA+IA0KPiA+IA0KDQo=

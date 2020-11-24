Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04BA2C318B
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgKXUAI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 15:00:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:2109 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbgKXUAH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 15:00:07 -0500
IronPort-SDR: JqCsP3h9xJn95PVYBiBmi+Ih7UF/RcY06Yx8Cc2Jw560LJNB2JOjjXSvHw9HFoZyVPJItwEJX+
 roGbpSAYQq8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="171228572"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="171228572"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 12:00:06 -0800
IronPort-SDR: wKUitP142p1sERWd2KnEkMbD9ckchbPd0UqajJR4cajIitYnabQTYSH4+0tfwAtIeJl3BuBqXC
 kEclC3F5Utag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="534992569"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2020 12:00:06 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 12:00:06 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 12:00:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Nov 2020 12:00:05 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 24 Nov 2020 12:00:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNdT596xEwt1YQlacsLY7vimhfX163UUPQnK1hYbL2uS16kwVLwi+oQ22WA7JvWwo5nnBStz2tULq1br1AjFkoW9kXbGobv9jSMEGMVaChuVNxfqKTb12hiogo0d/FU5doPpjunBi6iecI7U1ZLl9CjlOR4DJOHwSC6XMmjY5kNSD1aZT8oZRRgeTCdGbJe26m9Sc5e1xqPoJHN41DA3lWkEStJunPgMrsl+aIoB6gryyJ6oUBCfRDyyPf2Hn6VQvcTiS81F06oNE/KLvCTmqycSv13MNrIBjOHrXdBmBlR4WIKSjsVjC5uL6NJbgcPjQUMQ63/UBt78Rjdk6p8eKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMuENziv0INemCv3e9MWWCLrJYQyOVxrkf+mRHWX9R8=;
 b=RfqC0nBII1E5aAF5D5s4+aNuWcWVYMfUY2savb1Ao1aKzIDWXyQNc2inhBM8lhEUyjIpb4CDl1bfbN4vl66tSZierWftekvXVWKpORLtnhyu3/pncFXAQIL3u3EzdQujvCyzOkPBbWf6FyWqMAZBU7jLhgwT8kHD+FoBwdbOJbuZAC7waEE6xYQVrnPemNPwOMydabx3oZaiPc18g27S0jMwQTcQuJgh+f3IQNPXuqRb6zZDamyIbNdxU9pfYeijT7VGmwglG210xe6HZj4Zo5XuCMxvoYN2NR6cFbz2zzQFRHJewZ7cHKGAVCyxbP8rqMn6AwzBuo+SoX0Znk+5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMuENziv0INemCv3e9MWWCLrJYQyOVxrkf+mRHWX9R8=;
 b=OlXo/JmEOnTobuXaCHsTCUxUVeKm2ru5zqPL2L2i1g5wRAAfjfBPXmIfov4odI0PWCFuD95e5HhnYm2OjrtwkA2TnpQ3NO1s+RY3tCteqyX+BBkoo4gnWgx7cL5dcbR3klSgcI445oy1sK9UVYiYYiUumzXcSVpD3IL+B4r97d4=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 20:00:04 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412%6]) with mapi id 15.20.3589.025; Tue, 24 Nov 2020
 20:00:03 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
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
Thread-Index: AQHWv3v0VGlTYBJQUE2XnxoQHVHqeqnTi8sAgAFM2ICAAj5EAIAAousA
Date:   Tue, 24 Nov 2020 20:00:03 +0000
Message-ID: <3138ecaa5214e4db873ac614b3a9b329e92ec50b.camel@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
         <20201120202426.18009-2-rick.p.edgecombe@intel.com>
         <CALCETrUjpdSGg0T8vehkXszDJKx5AS0BHP9qFRsakPABzPM2GA@mail.gmail.com>
         <90d528be131a77a167df757b83118a275d9cb35f.camel@intel.com>
         <20201124101656.GA9682@infradead.org>
In-Reply-To: <20201124101656.GA9682@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34195911-1de7-4490-5657-08d890b38896
x-ms-traffictypediagnostic: SA2PR11MB5035:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB50352F205D10D90D72EA3353C9FB0@SA2PR11MB5035.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pcb01xblKMXHqk9bMxzX+MGArajQjr/a1U82LDeMObEx9iR4KWUOLugTc4D+n2u32PQq263qyHmqtAuv15T8Uwwrl1+dvLZGGjOH0dtRxethWUBbBle5lWpDV0RtmgNsCIW8ML4u10Y2iP2JI2bMixDXLbkauDg5ZVhy3uv7adOF3HiHWn5kv7jbp+nhn7isZScFPIFX5TeSSHKo+yVPFNUEH/ImGeYUCn3zRvSS+4AsngrMkEJBRb17Ipa0RoMM5V0bfJniHT/Q1orupDOjgVf6UJj6zPLq8ddFQY1kvYHU8d5oMMsSpR45IUTimyysdfb3oFt8rpplYd+4sEDnjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(316002)(54906003)(6506007)(2906002)(2616005)(26005)(186003)(5660300002)(36756003)(66946007)(66556008)(7416002)(71200400001)(64756008)(76116006)(478600001)(8936002)(91956017)(86362001)(8676002)(6486002)(4744005)(66476007)(4326008)(6916009)(66446008)(6512007)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RktjeGdoR1NzaHRZWWRuWVMzSitQcy9wTi8wK1lQWnhBRUN3UlViSnBFZXpX?=
 =?utf-8?B?dWVrRmNQejVMWmVvOTlPZmZmdEQxMzVLWEowU21KY3JiVldYaUhzSENRYXdE?=
 =?utf-8?B?QlFESmI0bUJEQmFBZVZKYUpYV1B3K2RqeVNHSG5hUnpPZlVTalM3TEFzOW56?=
 =?utf-8?B?VVhRNS8rYkR2bTRTU2NhS3pSdWJ3TFJrYWJjUVdhMTVWNXpiMmdVaDREVEM3?=
 =?utf-8?B?ZHEwTjZmNmFhclBSa082c0pJTjllM1E5NTFzZnVTN3h5Q2NwTGpwcElKbnFM?=
 =?utf-8?B?RkIrTHIwdDhnSWVaSjZkOGJyT2U1WDUzTFZMc2dhMGl3TEliYjhQWHFWc1Qr?=
 =?utf-8?B?b2EvRUk4SldhWnJGYlBuYlJsQjd5RFUrUFdHeUtjbmJ4L0xQb1lHblVIdEpi?=
 =?utf-8?B?ZkFNNVJhZUxudU1Ld0ZtSnA0ditGUFh3azB0eWhiMWNCSTUwbHhOdmxzU016?=
 =?utf-8?B?MWM1WVE0aExOM0k4c2RwSGxub2NaSktVOHhreXFjQ2REME5zcHNjNEJUWktN?=
 =?utf-8?B?YzhhRUNhQU9hVEF3UVRyZ2JMYjVDMzZ6REFGczdsdG5DcTFXekNvUDhRcDdM?=
 =?utf-8?B?RlN1VnVnWDArR2JZZlFzK3htN3VPVVRiWEdKT0dkRlRGa1l5dmw3VVQ3SzM3?=
 =?utf-8?B?WEZCQWZDTUFEUytaYys5NWZLOEFkNURlS1cxM1pSVW9WVTR3SFZpdzUrMmUy?=
 =?utf-8?B?azFQcDArVlVabUdBU21yZndaYXc1eVY4R3BlZlNPMnFlNXRPckVtdXNLT2VJ?=
 =?utf-8?B?bkMraSs5bjNrVXVrRlYrZTM2Qm5XMW9EN1E3ZG8rR3R6bWUyeFpTK3IvZk8z?=
 =?utf-8?B?VUpvajBxbzRMbDdlYk83Nm1RUElIYXRsR2JlVS9VdlgrUGxDZkd1VFhFZUZZ?=
 =?utf-8?B?bFNvdXJQdGlyRGVSVG5ramhLdy9IRTIvblpWY3hOU1Mxc2xPMmdkWFVEWGpt?=
 =?utf-8?B?U1hQcHRtdXNJN1k0ekNnWXpzNVRxNFhPdkp1TW5aRjA3MGVHS3Z1L1JQcjZ3?=
 =?utf-8?B?YXYzT2pabDVHdkZWdWdXd1hJWnZDY0NMeUtnbG92d2JER3RHUk8zZlV5SXJI?=
 =?utf-8?B?VXdWc3RJQlRhbWRZZkF6YXRUQ1lzSjhJVnRGSjh0L0JrVEVxYklNdWplaG5H?=
 =?utf-8?B?SWFNc3lwTi9uYkRwbllPaDFUWExNb3I3bEdqbC93cm8xdVRoa21VOFlDcmVL?=
 =?utf-8?B?UWZEb080TjFQRS9RRVdwaktDaTNPSWZ2WUNZSW45K3pOS2VHTDJnWWZiNmZG?=
 =?utf-8?B?ZU5OSW5XbGxhSHYvUFo4b3EwdGt0U2lZbzNvMWlRVlloZis4aEJtVDRiNlFy?=
 =?utf-8?Q?rdK/dVR9cagNXA7ZvomXAmCHm3XfHGd3y1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD8BA5E3EA057D49A288C8AEB80E5D7B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34195911-1de7-4490-5657-08d890b38896
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 20:00:03.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuZ9IY6CuHsVYcWMxgStDSSWA90TrODB/I8JUiuDheuYTDmiswA0QYoDq3PmYOu/VszMT6xlSRnhbsQwjXNZuRebgMtwxETOAp4EjnCTGtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTI0IGF0IDEwOjE2ICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgMTI6MDE6MzVBTSArMDAwMCwgRWRnZWNvbWJl
LCBSaWNrIFAgd3JvdGU6DQo+ID4gQW5vdGhlciBvcHRpb24gY291bGQgYmUgcHV0dGluZyB0aGUg
bmV3IG1ldGFkYXRhIGluIHZtX3N0cnVjdCBhbmQNCj4gPiBqdXN0DQo+ID4gcmV0dXJuIHRoYXQs
IGxpa2UgZ2V0X3ZtX2FyZWEoKS4gVGhlbiB3ZSBkb24ndCBuZWVkIHRvIGludmVudCBhIG5ldw0K
PiA+IHN0cnVjdC4gQnV0IHRoZW4gbm9ybWFsIHZtYWxsb2MoKSdzIHdvdWxkIGhhdmUgYSBiaXQg
b2Ygd2FzdGVkDQo+ID4gbWVtb3J5DQo+ID4gc2luY2UgdGhleSBkb24ndCBuZWVkIHRoaXMgbWV0
YWRhdGEuDQo+IA0KPiBUaGF0IHdvdWxkIHNlZW0gbW9zdCBuYXR1cmFsIHRvIG1lLiAgV2UnbGwg
bmVlZCB0byBmaWd1cmUgb3V0IGhvdyB3ZQ0KPiBjYW4gZG8gdGhhdCB3aXRob3V0IGJsb2F0aW5n
IHZtX3N0cnVjdCB0b28gbXVjaC4gIE9uZSBvcHRpb24gd291bGQNCj4gYmUgYSBiaWdnZXIgc3Ry
dWN0dXJlIHRoYXQgZW1iZWRkcyB2bV9zdHJ1Y3QgYW5kIGNhbiBiZSByZXRyZWl2ZWQNCj4gdXNp
bmcNCj4gY29udGFpbmVyX29mKCkuDQoNCkhtbSwgbmVhdC4gSSBjYW4gY2hhbmdlIHRoaXMgaW4g
dGhlIG5leHQgdmVyc2lvbi4NCg==

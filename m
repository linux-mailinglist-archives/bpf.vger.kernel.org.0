Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20392BFD2F
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 01:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgKWABl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Nov 2020 19:01:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:63592 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgKWABl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Nov 2020 19:01:41 -0500
IronPort-SDR: tT5WC1X9GWoTsHWstme7sSJLVVtQ6Vg6alMcOQ3KhAyn5DX7MmgEOtK3itf1tKZv/QCRsG8AdE
 l1Ke7F/6WRpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159447598"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="159447598"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 16:01:40 -0800
IronPort-SDR: GMXsy0jsvzKYHcP9J42S32qOcAwOHRP6G6J+kjKY4GzRcItDeBI4MFWuHVlW4+NgT/9xuE/JVX
 Eeub1tq/mA2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="477921202"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 22 Nov 2020 16:01:39 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Nov 2020 16:01:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 22 Nov 2020 16:01:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 22 Nov 2020 16:01:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqfXEhdH1eTae3rF8FEqv90DKyTGVtxQkUY2R7u3EhMqObliviyVMPLUsCq9g4hUoaXl2rusvFj4qT5Zq//WR6mhFuCzpnKcWbU3ONX8zWo6VxDlh3PxzCUgqnCfrSSDVO/MDXgkKQ9lbIyi3FfeXcW3UgzT2PHauYM3adCtbQQWdGV032yx1CQqrnGCF2fogFLWVWyRajmFqL3VUS78nDmp93iZT6N2uZk+nocvUgxWRHTLcfuj+v3eOsL46K0nl7OSlr3kNWWDQ9aCcwJxMVOM67hovMs8IK+6jRdxh2r+7wYuuSTaD1lHjNDlJ2NvnbCrYbMoWItzwuhhrTEiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc9kOowHyfg63f8zPUNhnmNwY448k03KLpEf6dxq4Eo=;
 b=FB7+5FlMjYtNtdzelgRT+g9RvZ8vObuIrYTBzsnX2RR/BpPldX8D/HXz5TD3SBWf43A7MnH/75/oZZDdhwFTfbl7B7v5fH+ILyt755lEKRloKoiYZ6q/0zHgiH9tMhY18Aa27ZAb7aOv2aK/ImvhTEPhk8DSYcbfc6xXjPj4VmVelyUE2Q7n+rUDhlZDAyqkflGd2iOzwavJ4WsxdZy0Zjv0sQJS+k7IWYn+RPzODFczE1ByFs1cXnD8YGp8c+LPK3/U8s5KPEt//hZsLoCSCxkJG/Rs/y15ET3m4DneSwhhng7i8b7zgH5FkNgOKmh3jUvcg5MdtzJ6Av2FJv8SDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc9kOowHyfg63f8zPUNhnmNwY448k03KLpEf6dxq4Eo=;
 b=LBquraX3472rwdWrnfGnz4ZLGmjo/s96tz9slm924ak6wU31JRZUkNITKg9eXIbTS6ZOeQnVmL8MGBL8EnVicLenTG7BWpWgjjHppdSeRJVCbhhLvAWotj0jO9omZ+wCaiVmjLQhryLAENxcc6IeYuhME6X4r1XdzmeGkJYciTo=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB3119.namprd11.prod.outlook.com (2603:10b6:805:cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 23 Nov
 2020 00:01:35 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412%6]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 00:01:35 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "luto@kernel.org" <luto@kernel.org>
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
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Thread-Topic: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Thread-Index: AQHWv3v0VGlTYBJQUE2XnxoQHVHqeqnTi8sAgAFM2IA=
Date:   Mon, 23 Nov 2020 00:01:35 +0000
Message-ID: <90d528be131a77a167df757b83118a275d9cb35f.camel@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
         <20201120202426.18009-2-rick.p.edgecombe@intel.com>
         <CALCETrUjpdSGg0T8vehkXszDJKx5AS0BHP9qFRsakPABzPM2GA@mail.gmail.com>
In-Reply-To: <CALCETrUjpdSGg0T8vehkXszDJKx5AS0BHP9qFRsakPABzPM2GA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6804ffcb-82a9-4e12-691a-08d88f42f17c
x-ms-traffictypediagnostic: SN6PR11MB3119:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB31192133A676AE64B52B624FC9FC0@SN6PR11MB3119.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K93SXbRei8OlfGTl86H1UkkF7+9MVR/8MZFXRUxNAyhWg8oHn7eYR/X4NoJJ0eEBZynRMiCsSjDCPF1DzNyGhwnP1qBOQuJIefT2Wfliq/V1Zgnu/8ttdV32J9xKSTJVpQuWSWeYB4sreh58u0kc3Ez4zjz1nAeG4ZK9V8/Idbcf3JcPvcmugoQa4bCQ9YGkrO5ndl67KpRQUDp5TH973xJZow0mMFuJOmlbwEpoy/i57RWa1FN4zPl8JsqWwKBNSP/sy9Dj/f+9CibvgTLQ1YiTZxSpgDb5BPMb3AZSuKMbl+dC4A6w7y1WTlSEEPHR9lxK42qqFMe9Pm4IvW+ANw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(66476007)(91956017)(76116006)(4001150100001)(64756008)(66946007)(6506007)(8936002)(66556008)(66446008)(5660300002)(6916009)(53546011)(6512007)(4326008)(83380400001)(71200400001)(7416002)(6486002)(186003)(8676002)(26005)(2616005)(316002)(54906003)(86362001)(2906002)(36756003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: j06TPIUdEfQAQsf22FLomFTjhOZCykYuJSFBIcoaydrtey8wNewIyQ/A9jGobMqVH6rBxHmO79L34gj3H+oIMXDm5uGO2iFNwBqArMXwdsCyWs1WDJ+5bZY0JCQrLRC/59pRiUSzGkUctFdQYy6Nl3+6tI2vMlDSb566x4kUw+PbGYv7HDouz8z5VXaXpVMFyTtxEpyilmuYh/lk0lnxFZg3TbSY/gybX6oua+GH6zISkp5wq5KKrzK/kU1KQVKXZNpUfmVjnDScTL2DiluFeCgcISMG7eIbvLSAsgbIZkCaHP0zcgI/6hxoE1rVQO6cydQHzRrA7U63DYcxR1ShGdNusA8taKPhBVDqkYO1NTjyHPqkASiEddprrtDWqgeB7+OUOFrfr/CYjYyXJI73FxMqMIYNu6e6lOEvQiR1NcgUedu3MiTDNp9e+divLW/lzc9Zb5bhmOE3SkCIQ4hCq+XAicpBMYotBrdiRV1gkhAmXWzC/W5PIpw4pkmc5ZHFHZ8RbjTKgvbEBh9e2lVPWHnqeaHLZxp28I2vyGhBhACcV3PYgTz4EsXCyZXD8YzGGsGU571I2vzibBFulXgEbLx8bhGxp5tTLbZko7fC8iU2jasC5va9pcPBwE55eaHb28ZpJioS+FhX40LMuvsiib3FFWdkX+Mi2EWSo4PPOLJgokhDhVo1Fy97Oq+/sB5fEA334KbsDBuD1Pdr/dkoisiOVFyfkjUSihD/xnEeRTXcAf5L7BV9iaCIqThUUUTGAJ4KMjh5xu8Ar9odeuwS83D7debjrS7DtLc5Uv5B8R+6rXdXBDrcInJoUX1q8uzL8oQ/KCiq0GdTWwtpJKMeJ4fETIYWx0/K3XDLFFXtwbFFpMc8I7IKSLyxVcjFfi3dEq0+SD/rwurhHZOLKznVgA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D3694FC895D7244B9E7ACE12F9A3064@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6804ffcb-82a9-4e12-691a-08d88f42f17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 00:01:35.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/BjXziqvPlScFW6eItk7mEJon+IfA46YDnRZn3ZPqsSsFujEshkaK1sBMAwN4qytuyd7BMDwNEu86yQy2xdaNhKSw8lKOK7FyNpSna0e9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3119
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gU2F0LCAyMDIwLTExLTIxIGF0IDIwOjEwIC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIEZyaSwgTm92IDIwLCAyMDIwIGF0IDEyOjMwIFBNIFJpY2sgRWRnZWNvbWJlDQo+IDxy
aWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gSW4gb3JkZXIgdG8gYWxsb3cg
Zm9yIGZ1dHVyZSBhcmNoIHNwZWNpZmljIG9wdGltaXphdGlvbnMgZm9yDQo+ID4gdm1hbGxvYw0K
PiA+IHBlcm1pc3Npb25zLCBmaXJzdCBhZGQgYW4gaW1wbGVtZW50YXRpb24gb2YgYSBuZXcgaW50
ZXJmYWNlIHRoYXQNCj4gPiB3aWxsDQo+ID4gd29yayBjcm9zcyBhcmNoIGJ5IHVzaW5nIHRoZSBl
eGlzdGluZyBzZXRfbWVtb3J5XygpIGZ1bmN0aW9ucy4NCj4gPiANCj4gPiBXaGVuIGFsbG9jYXRp
bmcgc29tZSBtZW1vcnkgdGhhdCB3aWxsIGJlIFJPLCBmb3IgZXhhbXBsZSBpdCBzaG91bGQNCj4g
PiBiZSB1c2VkDQo+ID4gbGlrZToNCj4gPiANCj4gPiAvKiBSZXNlcnZlIHZhICovDQo+ID4gc3Ry
dWN0IHBlcm1fYWxsb2NhdGlvbiAqYWxsb2MgPSBwZXJtX2FsbG9jKHZzdGFydCwgdmVuZCwgcGFn
ZV9jbnQsDQo+ID4gUEVSTV9SKTsNCj4gDQo+IEknbSBzdXJlIEkgY291bGQgcmV2ZXJzZS1lbmdp
bmVlciB0aGlzIGZyb20gdGhlIGNvZGUsIGJ1dDoNCj4gDQo+IFdoZXJlIGRvIHZzdGFydCBhbmQg
dmVuZCBjb21lIGZyb20/DQoNClRoZXkgYXJlIHRoZSBzdGFydCBhbmQgZW5kIHZpcnR1YWwgYWRk
cmVzcyByYW5nZSB0byB0cnkgdG8gYWxsb2NhdGUgaW4sDQpsaWtlIF9fdm1hbGxvY19ub2RlX3Jh
bmdlKCkgaGFzLiBTbyBsaWtlLCBNT0RVTEVTX1ZBRERSIGFuZA0KTU9EVUxFU19FTkQuIFNvcnJ5
IGZvciB0aGUgdGVyc2UgZXhhbXBsZS4gVGhlIGhlYWRlciBpbiB0aGlzIHBhdGNoIGhhcw0Kc29t
ZSBjb21tZW50cyBhYm91dCBlYWNoIG9mIHRoZSBuZXcgZnVuY3Rpb25zIHRvIHN1cHBsZW1lbnQg
aXQgYSBiaXQuDQoNCj4gRG9lcyBwZXJtX2FsbG9jKCkgYWxsb2NhdGUgbWVtb3J5IG9yIGp1c3Qg
dmlydHVhbCBhZGRyZXNzZXM/IElzIHRoZQ0KPiBjYWxsZXIgZXhwZWN0ZWQgdG8gY2FsbCB2bWFs
bG9jKCk/DQoNClRoZSBjYWxsZXIgZG9lcyBub3QgbmVlZCB0byBjYWxsIHZtYWxsb2MoKS4gcGVy
bV9hbGxvYygpIGJlaGF2ZXMNCnNpbWlsYXIgdG8gX192bWFsbG9jX25vZGVfcmFuZ2UoKSwgd2hl
cmUgaXQgYWxsb2NhdGVzIGJvdGggbWVtb3J5IGFuZA0KdmlydHVhbCBhZGRyZXNzZXMuIEkgbGVm
dCBhIGxpdHRsZSB3aWdnbGUgcm9vbSBpbiB0aGUgZGVzY3JpcHRpb25zIGluDQp0aGUgaGVhZGVy
LCB0aGF0IHRoZSB2aXJ0dWFsIGFkZHJlc3MgcmFuZ2UgZG9lc24ndCBhY3R1YWxseSBuZWVkIHRv
IGJlDQptYXBwZWQgdW50aWwgYWZ0ZXIgcGVybV93cml0YWJsZV9maW5pc2goKS4gQnV0IGJvdGgg
b2YgdGhlDQppbXBsZW1lbnRhdGlvbnMgaW4gdGhpcyBzZXJpZXMgd2lsbCBtYXAgaXQgcmlnaHQg
YXdheSBsaWtlIGEgdm1hbGxvYygpLg0KDQpTbyB0aGUgaW50ZXJmYWNlIGNvdWxkIGFjdHVhbGx5
IHByZXR0eSBlYXNpbHkgYmUgY2hhbmdlZCB0byBsb29rIGxpa2UNCmFub3RoZXIgZmxhdm9yIG9m
IHZtYWxsb2MoKSB0aGF0IGp1c3QgcmV0dXJucyBhIHBvaW50ZXIgdG8gYWxsb2NhdGlvbi4NClRo
ZSByZWFzb24gd2h5IGl0IHJldHVybnMgdGhpcyBuZXcgc3RydWN0IGluc3RlYWQgaXMgdGhhdCwg
dW5saWtlIG1vc3QNCnZtYWxsb2MoKSdzLCB0aGUgY2FsbGVycyB3aWxsIGJlIGxvb2tpbmcgdXAg
bWV0YWRhdGEgYWJvdXQgdGhlDQphbGxvY2F0aW9uIGEgYnVuY2ggb2YgdGltZXMgKHRoZSB3cml0
YWJsZSBhZGRyZXNzKS4gSGF2aW5nIHRoaXMNCm1ldGFkYXRhIHN0b3JlZCBpbiBzb21lIHN0cnVj
dCBpbnNpZGUgdm1hbGxvYyB3b3VsZCBtZWFuDQpwZXJtX3dyaXRhYmxlX2FkZHIoKSB3b3VsZCBo
YXZlIHRvIGRvIHNvbWV0aGluZyBsaWtlIGZpbmRfdm1hcF9hcmVhKCkNCmV2ZXJ5IHRpbWUgaW4g
b3JkZXIgdG8gZmluZCB0aGUgd3JpdGFibGUgYWxsb2NhdGlvbiBhZGRyZXNzIGZyb20gdGhlDQph
bGxvY2F0aW9ucyBhZGRyZXNzIHBhc3NlZCBpbi4gU28gcmV0dXJuaW5nIGEgc3RydWN0IG1ha2Vz
IGl0IHNvIHRoZQ0Kd3JpdGFibGUgdHJhbnNsYXRpb24gY2FuIHNraXAgYSBnbG9iYWwgbG9jayBh
bmQgbG9va3VwLiANCg0KQW5vdGhlciBvcHRpb24gY291bGQgYmUgcHV0dGluZyB0aGUgbmV3IG1l
dGFkYXRhIGluIHZtX3N0cnVjdCBhbmQganVzdA0KcmV0dXJuIHRoYXQsIGxpa2UgZ2V0X3ZtX2Fy
ZWEoKS4gVGhlbiB3ZSBkb24ndCBuZWVkIHRvIGludmVudCBhIG5ldw0Kc3RydWN0LiBCdXQgdGhl
biBub3JtYWwgdm1hbGxvYygpJ3Mgd291bGQgaGF2ZSBhIGJpdCBvZiB3YXN0ZWQgbWVtb3J5DQpz
aW5jZSB0aGV5IGRvbid0IG5lZWQgdGhpcyBtZXRhZGF0YS4NCg0KQSBuaWNlIHRoaW5nIGFib3V0
IHRoYXQgdGhvdWdoLCBpcyB0aGVyZSB3b3VsZCBiZSBhIGNlbnRyYWwgcGxhY2UgdG8NCnRyYW5z
bGF0ZSB0byB0aGUgd3JpdGFibGUgYWRkcmVzc2VzIGluIGNhc2VzIHdoZXJlIG9ubHkgYSB2aXJ0
dWFsDQphZGRyZXNzIGlzIGF2YWlsYWJsZS4gSW4gbGF0ZXIgcGF0Y2hlcyBoZXJlLCBhIHNpbWls
YXIgbG9va3VwIGhhcHBlbnMNCmFueXdheSBmb3IgbW9kdWxlcyB1c2luZyBfX21vZHVsZV9hZGRy
ZXNzKCkgdG8gZ2V0IHRoZSB3cml0YWJsZQ0KYWRkcmVzcy4gVGhpcyBpcyBkdWUgdG8gc29tZSBl
eGlzdGluZyBjb2RlIHdoZXJlIHBsdW1iaW5nIHRoZSBuZXcNCnN0cnVjdCBhbGwgdGhlIHdheSB0
aHJvdWdoIHdvdWxkIGhhdmUgcmVzdWx0ZWQgaW4gdG9vIG1hbnkgY2hhbmdlcy4NCg0KSSdtIG5v
dCBzdXJlIHdoaWNoIGlzIGJlc3QuDQoNCj4gSG93IGRvZXMgb25lIGZyZWUgdGhpcyB0aGluZz8N
Cg0Kdm9pZCBwZXJtX2ZyZWUoc3RydWN0IHBlcm1fYWxsb2NhdGlvbiAqYWxsb2MpOw0KDQo=

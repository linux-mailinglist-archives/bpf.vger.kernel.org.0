Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE1A2C16FD
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 21:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgKWUoY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 15:44:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:63585 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgKWUoY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 15:44:24 -0500
IronPort-SDR: ivWnwom6eU+ioojZo0THsiFEqPui6SYu2BrCDnV0YnLdYHB7mPdvZSvAXjXxU8kiRgWZZtNNPY
 CIdoH0e35Tiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="171939356"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="171939356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 12:44:22 -0800
IronPort-SDR: 6jiXOubPDNhFW3QgLCyGcsL7Setw73oe21Tpbg02OCkYPj5GbRmQrstxpsahXWqN1gTI5fqHyL
 qrmh6uImVa6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="534590930"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Nov 2020 12:44:22 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 12:44:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Nov 2020 12:44:22 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.58) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 23 Nov 2020 12:44:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgdnekKg/dQHHQsb0nOBxsb1a8rYxLmAYiAXVc0cld+IdqMxWqJzB2ugOVgI7OHZpNLA0vvPpDWhqH64gjYab0VsgsyjZ2jiyMMgTBasGYu8l/CjYcIXE6WEJLj9pZh6IOrxP/2VdVzwDnUwZ14PZ0QtGZGqxztnD0iWwnjDhfS/tRdLpvmbOlTgnb3DyL1BgSWN0oceEF3eKg0LUQkL5FoIbiDdAJ6qDuOIVmIRZxx2yDtSpvoLrFJNViaszYJ1P+ZtIT8/Zn6+Y/VUCRITbs7ynMukwPhQ9lxFVYlRvPImhdDnyT2sX+JfI+0n1Ggn+WondTJJtZmNIvqFLPOtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/ySh1yeJXpI+usAcp02xnJ/mUu9TY6ez/9tBj2cTI8=;
 b=maTfMlPBhvXsK6ZSZcmHDvh1q+cYZGFYnRpL5Rpeij/aE4IVycQnSv4fOEsGRaCDgPuUJeJK6IPFaCbrCLLLmkCPoPAJvgOHaF0oO+speccbx1fcJApZbKWVcc0NJk7MFry1ZVSy51+ZuHAjIOPYIEvda9EyzOYSebBr5GKlbxiw/rg5UujUOgjGaYaAAfhnZQlpGWoLufaa0eWG+S/k9KCiLswPufIdQdC4GXokDCdOrnrRelKa0uNuDhjoVlWWDtKXbl7tnwmRFcmLl/qdLGyMWjpoUnmO4L2QJ19UXj5ixWST46suMSFubtsP2stOxa7ffPqdSRcP3Pgn3JTLQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/ySh1yeJXpI+usAcp02xnJ/mUu9TY6ez/9tBj2cTI8=;
 b=u4plPNBXgYurY1NReZvJCvI9CktVJWOPdbUJ3dy6bItXKWKy/m1mjmu8Kp+sEECio+zCSQ1VVVBde3EKgKbRIFZNM+xJexYyRX2GES+DS6QoScJVnNUYD/7dYDIhMPVnZy2p1tB3JwpLABoJxlrlZHsyalA4q/tx2gA+WMLpldg=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB3133.namprd11.prod.outlook.com (2603:10b6:805:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Mon, 23 Nov
 2020 20:44:12 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412%6]) with mapi id 15.20.3589.025; Mon, 23 Nov 2020
 20:44:12 +0000
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
Thread-Index: AQHWv3v0VGlTYBJQUE2XnxoQHVHqeqnVb0MAgADEkIA=
Date:   Mon, 23 Nov 2020 20:44:12 +0000
Message-ID: <eccaa448f82e90c924d51d52525f766340026dfe.camel@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
         <20201120202426.18009-2-rick.p.edgecombe@intel.com>
         <20201123090040.GA6334@infradead.org>
In-Reply-To: <20201123090040.GA6334@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6931952-060d-424a-253b-08d88ff08906
x-ms-traffictypediagnostic: SN6PR11MB3133:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB313374FFF9AFA1149AAE7BEFC9FC0@SN6PR11MB3133.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kUc5t1Gp1Q+X6WwHNo3iMyj5OAmHFVCZqm0tvjhDHZTzMaY0VX9eZ+K9UL+RyxooOFi+Lx4BC0R0KvaGnb3fITwrndKGVoG9p8AFxpTstbC5K8IbFuE85i3d+A2nrftlW/tXxcCS2Paxk+6O0HqVAxWLJttG7A8kx0GRz4ttIBQAFjBodAsEUQEb48jmXRwWk3fgHDo9x2y09RltUUwT7VdIxChTNQWLeBfHY7zDy3B5nMFCEEeFHercVHen1vjia8hXNAYNsIYxLv497SfVa/lDhrXNzD5rQDbU8RDqUGatGyjttsga0XWrOYsCy2SB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(91956017)(316002)(66946007)(6486002)(26005)(83380400001)(36756003)(71200400001)(6916009)(186003)(54906003)(66556008)(66476007)(7416002)(64756008)(5660300002)(76116006)(8676002)(6506007)(4001150100001)(66446008)(2906002)(2616005)(6512007)(4326008)(478600001)(8936002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bW9GRlhYZWhWNWZsbzlPQ0RkZzBJSmkzYzdveFQvKyt2NTNxWVJxaThEbEJO?=
 =?utf-8?B?b3FFZkZEUkEzTUVqUXdSQmpXZHJjR2tHZDE0TXpXR0hSM1BWM0xsTjYrcDUw?=
 =?utf-8?B?QUJFOXJEQ2hrOVdwYkIzZzNpM0l6eTVKTkNubHpJSE1MVVBJNk0vY1BYNU52?=
 =?utf-8?B?bkUraGNpd2NScERlQXlUWkplZmYwT1NkenF5cURXMlRmQkM4OFhqTGdMZ0hV?=
 =?utf-8?B?WHVlMnMxS1QzUlhjRmxjY3BjejFaTEZhOVlKZzRwSk92NE9tTXEvQ0NhQTBi?=
 =?utf-8?B?bE14SS94R0J6MzFvLzNlRzhLYU5DQ2QzMTRwczJENFIwd0RjbjNhMmlJTnZB?=
 =?utf-8?B?V29ML0o0SFVBY2dBTXo2STR2MlNVQ1NSZnZwQlZ3bENETitPUlMrZFJOZWZa?=
 =?utf-8?B?SVNmVnlVZFF4UU94cXcrMzVMNEw5aDhRUjdsWmt1QVZhaTV6QjlWblRQTHNl?=
 =?utf-8?B?N3FDcXpnTnZUaTljd3dqbmdtN2VTNEh1SmVZSC9NZmVwZW5ObFRxcXVOMHI0?=
 =?utf-8?B?c0VXT1pFNHZyS3hBZmEvQUx6S09FVkRFTitlc29TK09RdlhIbXlzRG9SYnho?=
 =?utf-8?B?eVg1UEZqYUtYMWROZHlIRFFBKzl2TklXb1JCTHRrMmpaaGxoQ1NRaStNdzVq?=
 =?utf-8?B?TVhRbU51RE4zcW1HSUFQSDhUcCtDNzBvRTYxQUw3VjM5Q3ZoZGVjdWdPNDFK?=
 =?utf-8?B?cWR6ZkNnWml2VjRDQVBVUGN2UXNDNkJYdlBrVTFNUFpEYXdlb1lOZ2JBQkRj?=
 =?utf-8?B?S1ZlVktPMEdWMDgyOFgwTFhwV2xGYzZFN3VrUjl1QzRYVGFOdWpsT1RoWlBJ?=
 =?utf-8?B?RGpXTWJRZ0pGUnBNNEhtTWZvZzZTMkQ0QWRvU0tyZnFQcDI1Wkd6Y3BkRVJV?=
 =?utf-8?B?VEQwOWNHUlFBQU9nSURZWnduTXRYWE1meVQ3SUp5bVNYTm5ldmhHdU1scGIy?=
 =?utf-8?B?WXJTTjF3SFJWb1RjTDhCM1NGREVPdi94TFNBaUJCeUlnS1htOEltRjU5Smd6?=
 =?utf-8?B?VHdvQTNtaVZvU3pnOUtUaUlHYXhQeGxqYzFjZXpDcUdlaklpWVd1NlEzYUE5?=
 =?utf-8?B?Sm9HTmErckJjS1U4bEcrV1NDQkVYTVNTbk9RTkJpWUpYWnVlOVpzTlpMazVn?=
 =?utf-8?B?Yzc4OVpValdjZEdCRmFmQ3RFZnN3dHBaQUtDbEU5OTNPVTFPUmtac0pYTS9i?=
 =?utf-8?B?bUlZTEthcHk4QzJYZlVOSTUvSS9CZmxoMS8vNWt2cUV6dGRXVW1jVlltQThM?=
 =?utf-8?B?czFnY2ZKMGJGVU9ndERIVERnTnJnWlVNZFJZYUp6dXdwa29SdWpyQzBkUDZ6?=
 =?utf-8?Q?JEQ3AXAD5T28NHssluwblr1Fgk9jNNZrNu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB1BBC5BD1795749965D819ED0AF4700@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6931952-060d-424a-253b-08d88ff08906
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 20:44:12.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpM1B1X2Xe6krEAHKlmECWtRELezBi1nIKwt7Mad/oT2mvJ6LwQl8qgynnu8JB8VMzGaJw8vAq8USJqkBZIS+AhbcME/7q0KXYbJ9NVu+d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3133
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTIzIGF0IDA5OjAwICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gRmlyc3QgdGhhbmtzIGZvciBkb2luZyB0aGlzLCBoYXZpbmcgYSB2bWFsbG9jIHZhcmlh
bnQgdGhhdCBzdGFydHMgb3V0DQo+IHdpdGggcHJvcGVyIHBlcm1pc3Npb25zIGhhcyBiZWVuIG9u
IG15IHRvZG8gbGlzdCBmb3IgYSB3aGlsZS4NCj4gDQo+ID4gKyNkZWZpbmUgUEVSTV9SCTENCj4g
PiArI2RlZmluZSBQRVJNX1cJMg0KPiA+ICsjZGVmaW5lIFBFUk1fWAk0DQo+ID4gKyNkZWZpbmUg
UEVSTV9SV1gJKFBFUk1fUiB8IFBFUk1fVyB8IFBFUk1fWCkNCj4gPiArI2RlZmluZSBQRVJNX1JX
CQkoUEVSTV9SIHwgUEVSTV9XKQ0KPiA+ICsjZGVmaW5lIFBFUk1fUlgJCShQRVJNX1IgfCBQRVJN
X1gpDQo+IA0KPiBXaHkgY2FuJ3QgdGhpcyB1c2UgdGhlIG5vcm1hbCBwZ3Byb3QgZmxhZ3M/DQo+
IA0KDQpXZWxsLCB0aGVyZSB3ZXJlIHR3byByZWFzb25zOg0KMS4gTm9uLXN0YW5kYXJkIG5hbWlu
ZyBmb3IgdGhlIFBBR0VfRk9PIGZsYWdzLiBGb3IgZXhhbXBsZSwNClBBR0VfS0VSTkVMX1JPWCB2
cyBQQUdFX0tFUk5FTF9SRUFEX0VYRUMuIFRoaXMgY291bGQgYmUgdW5pZmllZC4gSQ0KdGhpbmsg
aXQncyBqdXN0IHJpc2N2IHRoYXQgYnJlYWtzIHRoZSBjb252ZW50aW9ucy4gT3RoZXJzIGFyZSBq
dXN0DQptaXNzaW5nIHNvbWUuDQoNCjIuIFRoZSBuZWVkIHRvIHRyYW5zbGF0ZSBiZXR3ZWVuIHRo
ZSBmbGFncyBhbmQgc2V0X21lbW9yeV9mb28oKSBjYWxscy4NCkZvciBleGFtcGxlIGlmIGEgcGVy
bWlzc2lvbiBpcyBSVyBhbmQgdGhlIGNhbGxlciBpcyBhc2tpbmcgdG8gY2hhbmdlIGl0DQp0byBS
V1guIFNvbWUgYXJjaGl0ZWN0dXJlcyBoYXZlIGFuIFggcGVybWlzc2lvbiBhbmQgb3RoZXJzIGFu
IE5YDQpwZXJtaXNzaW9uLCBhbmQgaXQncyB0aGUgc2FtZSB3aXRoIHJlYWQgb25seSB2cyB3cml0
YWJsZS4gU28gdGhlc2UNCmZsYWdzIGFyZSB0cnlpbmcgdG8gYmUgbW9yZSBhbmFsb2dvdXMgb2Yg
dGhlIGNyb3NzLWFyY2ggc2V0X21lbW9yeV8oKQ0KZnVuY3Rpb24gbmFtZXMgcmF0aGVyIHRoYW4g
cGdwcm90IGZsYWdzLg0KDQpJIGd1ZXNzIHlvdSBjb3VsZCBkbyBzb21ldGhpbmcgbGlrZSAocGdw
cm90X3ZhbChQQUdFX0tFUk5FTF9FWEVDKSAmDQp+cGdwcm90X3ZhbChQQUdFX0tFUk5FTCkpIGFu
ZCBhc3N1bWUgaWYgdGhlcmUgYXJlIGFueSBiaXRzIHNldCBpdCBpcyBhDQpwb3NpdGl2ZSBwZXJt
aXNzaW9uIGFuZCBmcm9tIHRoYXQgZGVkdWNlIHdoZXRoZXIgdG8gY2FsbCBzZXRfbWVtb3J5X254
KCkgb3Igc2V0X21lbW9yeV94KCkuDQoNCkJ1dCBJIHRob3VnaHQgdGhhdCB1c2luZyB0aG9zZSBw
Z3Byb3QgZmxhZ3Mgd2FzIHN0aWxsIHNvcnQgb3ZlcmxvYWRpbmcNCnRoZSBtZWFuaW5nIG9mIHBn
cHJvdC4gTXkgdW5kZXJzdGFuZGluZyB3YXMgdGhhdCBpdCBpcyBzdXBwb3NlZCB0byBob2xkDQp0
aGUgYWN0dWFsIGJpdHMgc2V0IGluIHRoZSBQVEUuIEZvciBleGFtcGxlIGxhcmdlIHBhZ2VzIG9y
IFRMQiBoaW50cw0KKGxpa2UgUEFHRV9LRVJORUxfRVhFQ19DT05UKSBjb3VsZCBzZXQgb3IgdW5z
ZXQgZXh0cmEgYml0cywgc28gYXNraW5nDQpmb3IgUEFHRV9LRVJORUxfRVhFQyB3b3VsZG4ndCBu
ZWNlc3NhcmlseSBtZWFuICJzZXQgdGhlc2UgYml0cyBpbiBhbGwNCm9mIHRoZSBQVEVzIiwgaXQg
Y291bGQgbWVhbiBzb21ldGhpbmcgbW9yZSBsaWtlICJpbmZlciB3aGF0IEkgd2FudCBmcm9tDQp0
aGVzZSBiaXRzIGFuZCBkbyB0aGF0Ii4NCg0KeDg2J3MgY3BhIHdpbGwgYWxzbyBhdm9pZCBjaGFu
Z2luZyBOWCBpZiBpdCBpcyBub3Qgc3VwcG9ydGVkLCBzbyBpZiB0aGUNCmNhbGxlciBhc2tlZCBm
b3IgUEFHRV9LRVJORUwtPlBBR0VfS0VSTkVMX0VYRUMgaW4gcGVybV9jaGFuZ2UoKSBpdA0Kc2hv
dWxkIG5vdCBuZWNlc3NhcmlseSBib3RoZXIgc2V0dGluZyBhbGwgb2YgdGhlIFBBR0VfS0VSTkVM
X0VYRUMgYml0cw0KaW4gdGhlIGFjdHVhbCBQVEVzLiBBc2tpbmcgZm9yIFBFUk1fUlctPlBFUk1f
UldYIG9uIHRoZSBvdGhlciBoYW5kLA0Kd291bGQgbGV0IHRoZSBpbXBsZW1lbnRhdGlvbiBkbyB3
aGF0ZXZlciBpdCBuZWVkcyB0byBzZXQgdGhlIG1lbW9yeQ0KZXhlY3V0YWJsZSwgbGlrZSBzZXRf
bWVtb3J5X3goKSBkb2VzLiBJdCBzaG91bGQgd29yayBlaXRoZXIgd2F5IGJ1dA0Kc2VlbXMgbGlr
ZSB0aGUgZXhwZWN0YXRpb25zIHdvdWxkIGJlIGEgbGl0dGxlIGNsZWFyZXIgd2l0aCB0aGUgUEVS
TV8NCmZsYWdzLg0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgY3JlYXRpbmcgYSB3aG9sZSBuZXcgc2V0
IG9mIGZsYWdzIGlzIG5vdCBpZGVhbA0KZWl0aGVyLiBCdXQgdGhhdCB3YXMganVzdCBteSByZWFz
b25pbmcuIERvZXMgaXQgc2VlbSB3b3J0aCBpdD8NCg0KPiA+ICt0eXBlZGVmIHU4IHZpcnR1YWxf
cGVybTsNCj4gDQo+IFRoaXMgd291bGQgbmVlZCBfX2JpdHdpc2UgYW5ub3RhdGlvbnMgdG8gYWxs
b3cgc3BhcnNlIHRvIHR5cGVjaGVjaw0KPiB0aGUNCj4gZmxhZ3MuDQo+IA0KDQpPaywgdGhhbmtz
Lg0KDQo+ID4gKy8qDQo+ID4gKyAqIEFsbG9jYXRlIGEgc3BlY2lhbCBwZXJtaXNzaW9uIGt2YSBy
ZWdpb24uIFRoZSByZWdpb24gbWF5IG5vdCBiZQ0KPiA+IG1hcHBlZA0KPiA+ICsgKiB1bnRpbCBh
IGNhbGwgdG8gcGVybV93cml0YWJsZV9maW5pc2goKS4gQSB3cml0YWJsZSByZWdpb24gd2lsbA0K
PiA+IGJlIG1hcHBlZA0KPiA+ICsgKiBpbW1lZGlhdGVseSBhdCB0aGUgYWRkcmVzcyByZXR1cm5l
ZCBieSBwZXJtX3dyaXRhYmxlX2FkZHIoKS4NCj4gPiBUaGUgYWxsb2NhdGlvbg0KPiA+ICsgKiB3
aWxsIGJlIG1hZGUgYmV0d2VlbiB0aGUgc3RhcnQgYW5kIGVuZCB2aXJ0dWFsIGFkZHJlc3Nlcy4N
Cj4gPiArICovDQo+ID4gK3N0cnVjdCBwZXJtX2FsbG9jYXRpb24gKnBlcm1fYWxsb2ModW5zaWdu
ZWQgbG9uZyB2c3RhcnQsIHVuc2lnbmVkDQo+ID4gbG9uZyB2ZW5kLCB1bnNpZ25lZCBsb25nIHBh
Z2VfY250LA0KPiA+ICsJCQkJICAgdmlydHVhbF9wZXJtIHBlcm1zKTsNCj4gDQo+IFBsZWFzZSBh
dm9pZCB0b3RhbGx5IHBvaW50bGVzcyBvdmVybHkgbG9uZyBsaW5lIChhbGwgb3ZlciB0aGUgc2Vy
aWVzKQ0KDQpDb3VsZCBlYXNpbHkgd3JhcCB0aGlzIG9uZSwgYnV0IGp1c3QgdG8gY2xhcmlmeSwg
ZG8geW91IG1lYW4gbGluZXMgb3Zlcg0KODAgY2hhcnM/IFRoZXJlIHdlcmUgYWxyZWFkeSBzb21l
IG92ZXIgODAgaW4gdm1hbGxvYyBiZWZvcmUgdGhlIG1vdmUgdG8NCjEwMCBjaGFycywgc28gZmln
dXJlZCBpdCB3YXMgb2sgdG8gc3RyZXRjaCBvdXQgbm93Lg0KDQo+IEFsc28gSSBmaW5kIHRoZSB1
bnNpZ25lZCBsb25nIGZvciBrZXJuZWwgdmlydHVhbCBhZGRyZXNzIGludGVyZmFjZQ0KPiBzdHJh
bmdlLCBidXQgSSdsbCB0YWtlIGEgbG9vayBhdCB0aGUgY2FsbGVycyBsYXRlci4NCg0KWWVhLCBz
b21lIG9mIHRoZSBjYWxsZXJzIG5lZWQgdG8gY2FzdCBlaXRoZXIgd2F5LiBJIHRoaW5rIEkgY2hh
bmdlZCBpdA0KdG8gdW5zaWduZWQgbG9uZywgYmVjYXVzZSBjYXN0aW5nICh2b2lkICopIHdhcyBz
bWFsbGVyIGluIHRoZSBjb2RlIHRoYW4NCih1bnNpZ25lZCBsb25nKSBhbmQgaXQgc2hvcnRlZCBz
b21lIGxpbmUgbGVuZ3Rocy4NCg==

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406993ED112
	for <lists+bpf@lfdr.de>; Mon, 16 Aug 2021 11:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhHPJdq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 05:33:46 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com ([40.107.20.133]:51937
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230506AbhHPJdq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 05:33:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIpjSNC/3S0uT6e2tvDB4Tdl0RoUQUOp8ltS2ci5TzJ+wsCUjU+feGcNG5k3o5rY/f6t3dbH9uHMHAtBDJnKMCG8dvrvRhbCfvZ286eKlmhc7plgnnmpw8Pb1DeG8MMJ9Kp+dpUuohQCdcGpKnIudkgMluWs05IQwz3IQXRMeMKllwK0Jwh0/l/nz7M5A7TAclZdCf0RrcphkfuGiw1EF8yqtlhbssWAWTMwlw+QInXZZOsVMWJU9rDFc9rADbbU7t45OtWdoW0LakHaBhP/OMB1LrTaDGJcbyMwEx+yH4JMTOJ8xo9rHk6SUUvfK5nuMatsPt6BsdN8COZ7/Ocuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No+wCWyuVDApTs6bFNq4Hgmu+OCSSQJrQYpCqamvbFM=;
 b=M6gNZCaDgvIZBYdU34qKoup2jJL2uXmKot7VsSoXxLAswY3qVSrlTjKmApXajXX1ra+8Ei9Vnw7GRmG8o+mhmKVkKEgK+AV3wPejyu0mRFjRGeKmBQV6hS2c34aGZq2F8DqRuyc0P8ZT0bylhHQU06r2T2uJx1TEbx1FcZEmRyDocrBlqqbAOpWdzMM6UmaCSfaA+/fQrcKPg1kPmo4fmoGbkHuZDrSQ/07Ae3iwI0HktmRaymXm7M9YY6cq2okvcV4lXHZoQc/9V8Jr+NpwTi+RCp/ybFHbnPgNjI0QRA4xbns3RKnqRew+F7y7ph2lX2Bcx2l+BRqwOq/Z82hfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No+wCWyuVDApTs6bFNq4Hgmu+OCSSQJrQYpCqamvbFM=;
 b=gSPkNbQN++9/RNu0UF2Q2xobKpCY1IKp6hkqfxS+Y8MVmMgQC8pcpYHqm9YL4nRBf68sw37SCxsYmaMHqYukxUa7SyTP+Z/8plr/jeYA/tGVslaMg7zro2mmM02rZrUq3RCqbFVlBva84mqcdbrHCyOJTG+51Sa112duy+xb9/w=
Received: from HE1PR83MB0380.EURPRD83.prod.outlook.com (2603:10a6:7:63::13) by
 HE1PR83MB0361.EURPRD83.prod.outlook.com (2603:10a6:7:63::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.3; Mon, 16 Aug 2021 09:33:12 +0000
Received: from HE1PR83MB0380.EURPRD83.prod.outlook.com
 ([fe80::5486:d64b:6a6a:c8c0]) by HE1PR83MB0380.EURPRD83.prod.outlook.com
 ([fe80::5486:d64b:6a6a:c8c0%4]) with mapi id 15.20.4457.003; Mon, 16 Aug 2021
 09:33:12 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
CC:     bpf <bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: signal/signal_deliver and bpf_send_signal()
Thread-Topic: [EXTERNAL] Re: signal/signal_deliver and bpf_send_signal()
Thread-Index: AdeQKDHCoRVxaytpS+OXCpLUfp+NfAAPyYMAAAwuEYAAejWrsA==
Date:   Mon, 16 Aug 2021 09:33:12 +0000
Message-ID: <HE1PR83MB0380CCCFC5FB4867D29F3BCEFBFD9@HE1PR83MB0380.EURPRD83.prod.outlook.com>
References: <HE1PR83MB038015B1D19B02219FB1315BFBFA9@HE1PR83MB0380.EURPRD83.prod.outlook.com>
 <bda97fe2-d8b5-2539-273e-275276947b49@fb.com>
 <CAEf4BzaPAdRpQ7Pi-GxqRG1f_7+EmAZKu=FLNchO3EnnyFhrjg@mail.gmail.com>
In-Reply-To: <CAEf4BzaPAdRpQ7Pi-GxqRG1f_7+EmAZKu=FLNchO3EnnyFhrjg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-16T09:33:11Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6bdd051b-560d-43c1-8da8-67b30c9964ad;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9c2af19-8bb0-4ba2-9c92-08d96098ddf7
x-ms-traffictypediagnostic: HE1PR83MB0361:
x-microsoft-antispam-prvs: <HE1PR83MB03615380953B3D3BEA422758FBFD9@HE1PR83MB0361.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qFdWf0iAWkX6DcQ+uFdxY2MdiCTeb0pZdCjWQeaF/oVVt3ROaALeLN2ZNL66/39nR60voz/eOq4cP/Tu/uF0v4gQb8Zqrfsjjua5tpZGD5qfwTD8tg1CBhKRjGpq8Oj143pQTheGBAi3PCUzfvIAEF/crtkt88E1uvfbY7d9Ce0KKdHNvhA3Rd9v1RRb1Ji1+NuiIeOiKXt54lPGfY70foy4XZYxTwGc9T7yfjaQ+PndRVJpaf/i78r4naUkJiU0t/t0jFncGf2NAv+5uZOP1aI48jmsJPaOVEQiLikRKifedIB6oIwbRPU14egIjAzP4ICI0wCOxsmNNV/iTQaW9qx6DDUREhafzvgU4hLDs+VVmFIjTTLpQyjsyUFeTpWBOnGFCUt8R0GPKGzD4ZPw5VsGjxbLDh1dzi4a/YTZiC8xEXkS7mWy5jwzz/vb8PJAc8t+UUJiWR/35qRiQLsKT0xIS3P1dFXrCawwgLfs4tySF5lKlyBZximVCyBBw9j0oTICyXDVSZfhqyobRluKek7BkEa0nUdu0WHMFBCD2t53buKvUd1/fPppMkRb45Ad0OppCACLQXemTDOrEzbEXAqIF+Jzb09Znh4vC00prBEVfm3s10IF+Fr/bMzmc7fm93xfzWofHXDOCb4Sa2Si3/XPsA9EPngJV1AEJ77nTJ+8PjX4GCgeiktTbPVNrS1cOLEX6Bf8qaXOiQnU+WPSbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR83MB0380.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8936002)(86362001)(122000001)(38070700005)(316002)(52536014)(8676002)(110136005)(5660300002)(6506007)(55016002)(53546011)(9686003)(38100700002)(7696005)(26005)(64756008)(66446008)(10290500003)(71200400001)(66476007)(186003)(82950400001)(76116006)(2906002)(82960400001)(66556008)(508600001)(8990500004)(33656002)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHRsY29oZHk4bFg2U2d3NWdqdUk5SE9pdzJlK1BlQXA5QjVDVnp1bHIzcExr?=
 =?utf-8?B?ZW9JS2NETGk5L2kyekMwc1kza2gyY296bXlwKy9mQXhNeFE0ODVKN2VYQUxP?=
 =?utf-8?B?amRnNTN5bnROekF6NHdJS0laNEF1akwzcWtkOE1FOWFsNGNKallvMmNoRmpF?=
 =?utf-8?B?T09nS0Zrb1lOZGFFS3l2bGkyOVpqUE8wYmcxMSt4SDhvakVRME5HdncyaDRm?=
 =?utf-8?B?YzgwSU55RlhYNTM5Rko1OUVyQzhQMU91d0l1VFRCc2ZPQldobUgxdTJSYTRn?=
 =?utf-8?B?dDRXRmhOV25iRngwVXFFQVVhdm5XZzUvVktTVWxhRFlhNG5sUzdBZnhybm1y?=
 =?utf-8?B?RkhHd252MFNLVnJqVWdwTmVPQ3FBTVRmelNaVjVzN1E3TUJ2cVpabUlpZ0ho?=
 =?utf-8?B?MWZ2UUttSkVHaFZNcm1aMTBJUkh6MUlKekZMMXFCT0JFNXJ4WjlhSXNZbmIz?=
 =?utf-8?B?aFhNTXNUUXZWVHM4WjRuMTdnRlhLTXB2WE5tY1N3V3BWN1dtb3VSaUtkZkRL?=
 =?utf-8?B?S3BUUmRpZnZIVy9WVFVIajVzUzc1V21xTHFDRDBnYW9hYllCa01VWWMvVTI2?=
 =?utf-8?B?a1B2NXhrb24rZVdFRmowNjJMTEowWUJWQWRqU3dvVjZsZFR0OTZuYlNrUWtB?=
 =?utf-8?B?c1lDaWRnZzdFZWhFdjRON2FQWW55NW83MGVuRmJET0d6NkhuL0w5MFRISnpa?=
 =?utf-8?B?UmFWMEtIZXJYc01mWkdEQ0J0eHRVTTFJcFVZRGcwbFRBdkdvUUNWd2lKRWNO?=
 =?utf-8?B?TEJIL3AvV0ZkQkpuNk9FNHY3ME85TS9TSGJZbWNxbHZiemZWMGFIR0tKQzdG?=
 =?utf-8?B?N3V0RnhMTWkyc3lKTzhrcDB0MFl0RlpUcEV0YlZZOEF3MmNuU0lkcTFpS2Mx?=
 =?utf-8?B?MVJVZlFYMlhyQllYRkk5QVQyQW83YjdLam9Fc3ErK2ovNnJQLzcvNUhRNGVt?=
 =?utf-8?B?MDdNZnl4RFVSckQydnlQbjRJS00vQ3A3NWk3T2M5bXU3MTBLNGppcFZwYWND?=
 =?utf-8?B?c0xyUS9MMk5LbjlDOHVVMWg4U2ZmU081aHhBb250L1BKK3dkbDFZcGZtaEEv?=
 =?utf-8?B?cFNlM3p6aGNjUHJGeWZqdFJONHVYTlJncDVnMVVlaUNtaXg0ZW16Yng4WDNF?=
 =?utf-8?B?YlpuMXlGVit3ZFJ4QmpDSjJpelFLdlBBdTgzNVg2ZlU5Vk9MUXZFTS9YSHl4?=
 =?utf-8?B?ejZkN1Bjd1I3MXk5QzQ3MVV5UlFSNC9wOWdQV2xpcjNSZ2JlN0ZsdGNuancx?=
 =?utf-8?B?empyOE5JT1ZSdTBqQXl5ekU5ZytJc0FWZFhZVDlBSndFaHh1WmcxaXIxdmlq?=
 =?utf-8?B?L0dobktnT2hWVW5CN3U1QUxHcGhnd2ZLZ3RvS0hRSW01M0lreENkZk9QRWts?=
 =?utf-8?B?THNJeUt4SFRKV2c5blg3eE9CenkzaTQ3WVRaR1Bnc0pjY2c0MWt4b1RLTC94?=
 =?utf-8?B?MEtuR240VWorRVFhRGFBRjBKVG0ybTE3M1MzY0ZZM2tlOWRyanFnRmlLVWhn?=
 =?utf-8?B?bDdYdlBBaHQrcCtKOTF4WFRqcmNaUDlCbXJQUUViMm5yMjlDQ0JtaUFieWNU?=
 =?utf-8?B?WW81bXB3cVBhMXR6amVSYmlIUllIWnBhb0Y1U1Q0dVVHNHN1Z3BReFdxcnBk?=
 =?utf-8?B?ejYzaVgxaEh2UGJvRDFyeWl3WG1iaktYK1FuTDdSaW1pTzNOclF3SGVMNDlr?=
 =?utf-8?B?RGhYZDhWcTU3ZlFWNEJROWVIdlQ2dk0wb0FBYVo2RjVJV09JNEJ2WURSWE0w?=
 =?utf-8?Q?lLUlhCkJjq8kGRU1sTkorgZ+2O2aNA861tPZrzP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR83MB0380.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c2af19-8bb0-4ba2-9c92-08d96098ddf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 09:33:12.3284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jp9eCeYsEavK1SVHj2/H1DStMY0qGrSmXtT7FS5oFqqa4j8wi6p+ixA445WPvGITulC9n/T1J6/Po8nqFwMQBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR83MB0361
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyaWkgTmFrcnlpa28gPGFu
ZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+DQo+IFNlbnQ6IDE0IEF1Z3VzdCAyMDIxIDAwOjA4DQo+
IFRvOiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPg0KPiBDYzogS2V2aW4gU2hlbGRyYWtlIDxL
ZXZpbi5TaGVsZHJha2VAbWljcm9zb2Z0LmNvbT47IGJwZg0KPiA8YnBmQHZnZXIua2VybmVsLm9y
Zz4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogc2lnbmFsL3NpZ25hbF9kZWxpdmVyIGFuZCBi
cGZfc2VuZF9zaWduYWwoKQ0KPiANCj4gT24gRnJpLCBBdWcgMTMsIDIwMjEgYXQgMTA6MjAgQU0g
WW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gT24g
OC8xMy8yMSAyOjU3IEFNLCBLZXZpbiBTaGVsZHJha2Ugd3JvdGU6DQo+ID4gPiBIZWxsbw0KPiA+
ID4NCj4gPiA+IEkgaGF2ZSBhIHJlcXVpcmVtZW50IHRvIGNhdGNoIGEgc3BlY2lmaWMgc2lnbmFs
IGhpdHRpbmcgYSBzcGVjaWZpYyBwcm9jZXNzDQo+IGFuZCB0byBzZW5kIGl0IGEgU0lHU1RPUCBi
ZWZvcmUgdGhhdCBzaWduYWwgYXJyaXZlcy4gIFRoaXMgaXMgc28gdGhhdCB0aGUgcHJvY2Vzcw0K
PiBjYW4gdGhlbiBiZSBhdHRhY2hlZCB3aXRoIHB0cmFjZSgpLCBidXQgd2l0aG91dCB0aGUgbmVj
ZXNzaXR5IG9mIHB0cmFjZSgpaW5nDQo+IHRoZSBwcm9jZXNzIGNvbnRpbnVvdXNseSBiZWZvcmVo
YW5kIChkdWUgdG8gcGVyZm9ybWFuY2UgYW5kIHN0YWJpbGl0eQ0KPiByZWFzb25zKS4gIEkgdGhv
dWdodCB0aGlzIG1pZ2h0IGJlIHBvc3NpYmxlIHdpdGggYW4gZUJQRiBwcm9ncmFtIGF0dGFjaGVk
IHRvDQo+IGEgdHJhY2Vwb2ludC4NCj4gPiA+DQo+ID4gPiBJIGF0dGFjaGVkIGEgcHJvZ3JhbSB0
byB0aGUgc2lnbmFsL3NpZ25hbF9kZWxpdmVyIHRyYWNlcG9pbnQgYW5kIHVzZWQNCj4gYnBmX3Nl
bmRfc2lnbmFsKCkgdG8gc2VuZCB0aGUgU0lHU1RPUCBidXQgaXQgZGlkbid0IHN0b3AgdGhlIHBy
b2Nlc3MuICBJZiBJDQo+IHNlbnQgU0lHVEVSTSBvciBTSUdIVVAgaW5zdGVhZCBpdCB3b3JrZWQg
YXMgZXhwZWN0ZWQsIGp1c3Qgbm90IFNJR1NUT1Agb3INCj4gU0lHVFNUUC4NCj4gPiA+DQo+ID4g
PiBTZW5kaW5nIGEgU0lHU1RPUCBwcmlvciB0byBhbm90aGVyIHNpZ25hbCAoZWcgU0lHU0VHVikg
d29ya3MgZnJvbQ0KPiB1c2VybGFuZCAtIHRoZSBwcm9jZXNzIHN0b3BzIGFuZCB0aGUgb3RoZXIg
c2lnbmFsIGlzIHF1ZXVlZC4NCj4gPiA+DQo+ID4gPiBJJ20gZ3Vlc3NpbmcgdGhhdCB0aGUgcmVh
c29uIGlzIHRoYXQgYnBmX3NlbmRfc2lnbmFsKCkgYWRkcyB0aGUgKG5vbi0NCj4gc3RhdGUgdHJh
bnNpdGlvbmluZykgc2lnbmFsIHRvIHRoZSBwcm9jZXNzIHNpZ25hbCBxdWV1ZSwgaWdub3Jpbmcg
U0lHU1RPUCwNCj4gU0lHVFNUUCwgU0lHS0lMTCwgU0lHQ09OVCwgYnV0IGRvZXNuJ3QgY2hhbmdl
IHRoZSBzdGF0ZSBvZiBwcm9jZXNzZXMuICBDYW4NCj4gYW55b25lIGNvbmZpcm0gaWYgdGhhdCBp
cyBjb3JyZWN0IG9yIGlmIHRoZXJlJ3MgYW5vdGhlciBwb3NzaWJsZSByZWFzb24gdGhhdA0KPiBi
cGZfc2VuZF9zaWduYWwgc2VlbXMgdG8gZmFpbCB0byBzZW5kIGEgU0lHU1RPUD8gIElmIHNvLCBp
cyB0aGlzIGRvY3VtZW50ZWQNCj4gYW55d2hlcmU/ICBJcyB0aGVyZSBhbm90aGVyIHdheSB0byBk
byB0aGlzIHdpdGggZUJQRj8NCj4gPg0KPiA+IEtlcm5lbCBoYXMgU0lHX0tFUk5FTF9JR05PUkVf
TUFTSyBsaWtlIGJlbG93DQo+ID4NCj4gPiAjZGVmaW5lIFNJR19LRVJORUxfSUdOT1JFX01BU0sg
KFwNCj4gPiAgICAgICAgICBydF9zaWdtYXNrKFNJR0NPTlQpICAgfCAgcnRfc2lnbWFzayhTSUdD
SExEKSAgIHwgXA0KPiA+ICAgICAgICAgIHJ0X3NpZ21hc2soU0lHV0lOQ0gpICB8ICBydF9zaWdt
YXNrKFNJR1VSRykgICAgKQ0KPiA+DQo+ID4gU28gU0lHQ09OVCB3aWxsIGJlIGlnbm9yZWQgZm9y
IGJwZl9zZW5kX3NpZ25hbCgpIGhlbHBlci4NCj4gPg0KPiA+IEZvciBvdGhlciBzaWduYWxzIGUu
Zy4sIFNJR1NUT1AvU0lHS0lMTCwgdGhlcmUgYXJlIHNvbWUgY29tbWVudHMgc2F5aW5nDQo+ID4g
c3BlY2lhbCBwcm9jZXNzaW5nIG1pZ2h0IGJlIG5lZWRlZC4gQnV0IEkgdGhpbmsgdGhleSBtYXkg
c3RpbGwgZ2V0DQo+ID4gZGVsaXZlcmVkLiBJZiB5b3UgdXNlIHNpZ25hbC9zaWduYWxfZGVsaXZl
ciB3aGVuIFNJR1NFR1YgaXMgZGVsaXZlcmVkLA0KPiA+IGlzIGl0IGFscmVhZHkgdG9vIGxhdGUg
dG8gZG8gYnBmX3NlbmRfc2lnbmFsKCkgU0lHU1RPUCBzaW5jZSB0aGF0DQo+ID4gd2lsbCBiZSBw
cm9jZXNzZWQgYWZ0ZXIgU0lHU0VHVj8gTm90ZSB0aGF0IFNJR1NFR1YgaXMgYWxyZWFkeSBkZWxp
dmVyZWQ/DQoNClRoYW5rcyBib3RoIGZvciB5b3VyIHJlc3BvbnNlcy4gIFJlZ2FyZGluZyB0aGlz
IG9uZSwgaWYgSSBzZW5kIFNJR0hVUCBvcg0KU0lHVEVSTSB0aGVuIGl0IGFycml2ZXMgYmVmb3Jl
IHRoZSBTSUdTRUdWLCBzbyBJIGRvbid0IGJlbGlldmUgaXQgaXMgYSBjYXNlDQpPZiBTSUdTRUdW
IHdpbm5pbmcgdGhlIHJhY2UuICBJJ20gdGhlcmVmb3JlIGdvaW5nIHRvIGFzc3VtZSB0aGUgc3Bl
Y2lhbA0KcHJvY2Vzc2luZyBpcyBuZWVkZWQgYW5kIG1pc3NpbmcuICBUaGFua3MgZm9yIGxvb2tp
bmcgaW50byB0aGlzIHRob3VnaC4NCg0KPiBUb28gbGF6eSB0byByZWFkIHRoZSBjb2RlIHRvIGtu
b3cgaWYgdGhpcyB3aWxsIHdvcmssIGJ1dCBJJ2xsIGFzaw0KPiBhbnl3YXkuIFdvdWxkIGl0IHdv
cmsgdG8gZG8gZm1vZF9yZXQgQlBGIHByb2cgcmlnaHQgb24gdGhlIGVudHJ5IHBvaW50DQo+IGlu
IHRoZSBrZXJuZWwgd2hlcmUgdGhlIHNpZ25hbCBpcyBqdXN0IHN0YXJ0aW5nIHRvIGJlIHByb2Nl
c3NlZCwgYW5kDQo+IGlnbm9yaW5nIFNJR1NFR1YgY29tcGxldGVseT8gVGhlbiBkb2luZyBzZW5k
X3NpZ25hbChTSUdTVE9QKSwgYW5kIHRoZW4NCj4gYWdhaW4gZm9yIFNJR1NFR1Y/DQo+IA0KPiBT
bywgaW50ZXJjZXB0IGFuZCBjYW5jZWwgb3JpZ2luYWwgc2lnbmFsLCBpbmplY3QgU0lHU1RPUCwg
cmUtaW50cm9kdWNlDQo+IG9yaWdpbmFsIHNpZ25hbD8NCg0KVGhpcyBpcyBhIGNsZXZlciBpZGVh
IGJ1dCBJJ20gdGFyZ2V0aW5nIGtlcm5lbHMgcHJlIDUuNSB3aGVyZSBmZW50cnkgZXRjDQp3ZXJl
IGludHJvZHVjZWQuICBJZiBJIGNhbiBzaGlmdCB0aGUgcmVxdWlyZW1lbnRzIHRvID49NS41IHRo
ZW4gSSdsbA0KZ28gZG93biB0aGlzIHJvdXRlIGFuZCByZXBvcnQgYmFjay4gIFRoYW5rcyBmb3Ig
dGhlIGlkZWEuDQoNCktldg0KDQotLQ0KS2V2aW4gU2hlbGRyYWtlDQpNaWNyb3NvZnQgVGhyZWF0
IEludGVsbGlnZW5jZSBDZW50cmUNCg0K

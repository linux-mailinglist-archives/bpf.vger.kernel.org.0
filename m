Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0D2A7CE1
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 12:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKELYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 06:24:45 -0500
Received: from mail-eopbgr60132.outbound.protection.outlook.com ([40.107.6.132]:4238
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730270AbgKELYp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 06:24:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afXgGuIrgZ7EBvaHGV1MqA6croCKVA7gbjE3bcuPLXjbH4snWII2RKi1kdce2C5CQPcJ/jCeAYfI6BmA9NY7isTrv/iAMA4RMzjiDF8pgkcfo8eueADMXByv08JLM7gvG+fmwr7fJKwMajytwwGOKTY+9e1sJ9VgRaT3okiKNu5DZivAQHLedQrb46evpxmZitQ5hF2/AQ+bdWVL3C/pk6Lr9mALmjoa72fOjoiz3SskObH0GlqGEsstlXPBF7y0uqmTjdS6mMAcXKV5YUqHFsbfDJgSK1vudipMAjA05eale/wQRykOMkmfXCUoOq60ITRfsE39xjV8aTCRF5VB9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgIXIGtB2Q7iO10E8kQ1NU+PTRfPkp4FxRb55BizI8Y=;
 b=PUGYZ1uuFuN3ScqykLM0PVvszSl3BNm844C9/9BnNVaIelJk/yeDFVBM1kvbdbmZIByANAtitO30+mxg0bgJBOUA/8eF+ixTz5qXU3DlXUNcZhAks7fIceIVniWXf3oILA95ibaPQjBO+tKe6Vg9zsFgztjdSkbGGN9lAzTqmf0W2YFoqmMH1wFb5igg4DuLGtO3FPbmuDUQtUQcObitWMptQOilMVWXQ0fGY/orGk8VZtgZgJd9hdFKreHQV50Es4zn9lH6L/dfECOoKkPpTRfj+IEsH6RU8Q8EFfPZdr7n0gxydWsAxDwH4ioXDo1+iH/qblv8MGCkUwZ1x/GS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgIXIGtB2Q7iO10E8kQ1NU+PTRfPkp4FxRb55BizI8Y=;
 b=bhQmYARP2qv+c8DDrE5L/PKCnmOKGpzCKk3LjXlGzkQi0GoDfThwNzIsLgBzOYHQ06KWIR1R9rXX7M73KUuGdQM5z1Yv2BJKToG3f3pPcOFGhKUg1pfPUJAcaZptFS9Sm7sdz27tSa2/ekaetbEBLOEDGq0gAVuAg5HdyJRTEzc=
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 (2603:10a6:820:1b::23) by VI1PR83MB0256.EURPRD83.prod.outlook.com
 (2603:10a6:802:78::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Thu, 5 Nov
 2020 11:24:40 +0000
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99]) by VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99%10]) with mapi id 15.20.3564.010; Thu, 5 Nov 2020
 11:24:40 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@google.com>
Subject: RE: [EXTERNAL] Re: [PATCH bpf-next] Update perf ring buffer to
 prevent corruption
Thread-Topic: [EXTERNAL] Re: [PATCH bpf-next] Update perf ring buffer to
 prevent corruption
Thread-Index: AdazYC1vg+x0B4GYSm+iiVVe+II4ywABZuYAAAAGmTA=
Date:   Thu, 5 Nov 2020 11:24:40 +0000
Message-ID: <VI1PR8303MB0080BEF79FD7CF83959A092BFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
References: <VI1PR8303MB00802B04481D53CBBEBCF0DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
 <CACYkzJ7uUb97TeWi+r8zLAOMUMk8z_zVvQ=c7p8z2gAP0X5C3A@mail.gmail.com>
In-Reply-To: <CACYkzJ7uUb97TeWi+r8zLAOMUMk8z_zVvQ=c7p8z2gAP0X5C3A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-05T11:24:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=21c98253-5022-41c9-bfb5-df14b4de02be;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e95524b8-259d-4b29-cf9e-08d8817d6305
x-ms-traffictypediagnostic: VI1PR83MB0256:
x-microsoft-antispam-prvs: <VI1PR83MB0256898978F79B60AA934EB1FBEE0@VI1PR83MB0256.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NG/AaYHiebVga5JuEWIWCliLegAoWsh4TkM7el1fa8ByiZONO7b+/1INiEjgbZ2t4Y1a4kL/E4Zf7IXsSIILGDz74bq1TLVn4uS8w7UbjDgB1TANXAfaF52kriT835qDwUTe81IknkJEMfFhlqw5YB8HLjAXug4bdVYkJR0faTA/3gR2mcrFPOariX0xyeAWEhJ3E05If66np6e4wJkLIaD7e1TLYj40xce//mlP+lqgDqrA90QnqbWxcLEzPVh+JXMmVA2BF4VZYwd60rngukX7KOfdEmq42UHtDzcLkz1gr29zh1Wsu9EfqFq5he/7zbbi9D7+O2cfFGoqXoci4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR8303MB0080.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(6916009)(86362001)(9686003)(55016002)(478600001)(54906003)(5660300002)(4326008)(316002)(10290500003)(76116006)(8936002)(52536014)(8676002)(66446008)(66556008)(66476007)(66946007)(83380400001)(82960400001)(8990500004)(82950400001)(186003)(26005)(7696005)(6506007)(53546011)(71200400001)(15650500001)(2906002)(33656002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KzgjfbArDwFvc7d9bwShePyEOYjZ3Erwsts5yshE/D2zlcD8MGK+TROvf0jcpk5UZ18dgW1YlfmG6OKlycl/oxitOGZbSzpjZ/M/r6T5KDg/1w6MR2J5lzBc8/KIvgyWSAfN2myJhuFBTcScvpHdLtjZ5riePqi9uBaCy4KduldWm42yO1Ez1aL2iBvm3bMPT7+u99r0+EA3YRWm6P963XuvFPENn9lMGBtawKVNUgJNljubaZT9gNkDEeOjN808wwTJrfg4zQIOE6uzb7l/jf4TgViTSlPIXYGI9ZcCWpkgVlnRR9eULdKt6d7R0fYwEfmntSR6oHEDVnG2M1HtQYL4MIKsLlKh3BI3nbOXMlHqVkxbhlJhLf2ST8Itvl6GbKWg0zknb9IYAwZXjB25RkWYvoIaAWyiKKgsR12GEt69PzGEuMd8UFuOfn5UIiDANs3o5uqMeZPWDt4NB/8HmsLjOnUORQwxkBYS6CDc//Hcz5T/TkhGwNLactmE1H0eilb6h7MPZ/PiWteV4V3yZN7zs3a4YlfQz/xWugHTOMO9C18D/lXi21xiEsdxFG2dyOjtHtsjcCFCBLA95DH4TXRmbvMkVeIuoD2fjO4pKe1KqPwl7jbEV+NZCQlVDOShuJBlxbr6KwX4M7n+dLyPBpRaY9A5PNRoQDS9UMa7UvPcyIaTrsDXF5iSU99kDKk11KU6OruWPSYR5mvZi0Y5ny4jzBJn9Wn6LWmSgIv/N7VHF3tSZUNezTfkDVjrb/OMffx03kQDnIyThOxIgy5LAb1MzS39t+rJvA6DTaBYA77o9wk8JXRKd48VsHhTKeMAgsYIaSzPKwt7XoX7A0sPVCugjBYZXAUv7HqWALDhOkzPGenSEEy3IqZBtT5zw9DbJYU0yK+Klhdpyjtif6JAAA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR8303MB0080.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95524b8-259d-4b29-cf9e-08d8817d6305
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 11:24:40.2536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTBbir/Mwj5Tl91aBdhOc7Bi5GWGoQquQmQpzRbth9INxLRaY7CFNhbWxGeosP+htA5hON1VvOScoBfM36zN5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0256
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLUCBTaW5naCA8a3BzaW5naEBj
aHJvbWl1bS5vcmc+DQo+IFNlbnQ6IDA1IE5vdmVtYmVyIDIwMjAgMTE6MjENCj4gVG86IEtldmlu
IFNoZWxkcmFrZSA8S2V2aW4uU2hlbGRyYWtlQG1pY3Jvc29mdC5jb20+DQo+IENjOiBicGZAdmdl
ci5rZXJuZWwub3JnOyBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+
OyBLUA0KPiBTaW5naCA8a3BzaW5naEBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxd
IFJlOiBbUEFUQ0ggYnBmLW5leHRdIFVwZGF0ZSBwZXJmIHJpbmcgYnVmZmVyIHRvDQo+IHByZXZl
bnQgY29ycnVwdGlvbg0KPiANCj4gT24gVGh1LCBOb3YgNSwgMjAyMCBhdCAxMTo0MSBBTSBLZXZp
biBTaGVsZHJha2UNCj4gPEtldmluLlNoZWxkcmFrZUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IEZyb20gODQyNTQyNmQwZmIyNTZhY2Y3YzJlNTBmMGFhNjQyNDUwYWRjMzY2YSBNb24g
U2VwIDE3IDAwOjAwOjAwDQo+IDIwMDENCj4gPiBGcm9tOiBLZXZpbiBTaGVsZHJha2UgPGtldmlu
LnNoZWxkcmFrZUBtaWNyb3NvZnQuY29tPg0KPiA+IERhdGU6IFdlZCwgNCBOb3YgMjAyMCAxNTo0
Mjo1NCArMDAwMA0KPiA+IFN1YmplY3Q6IFtQQVRDSF0gVXBkYXRlIHBlcmYgcmluZyBidWZmZXIg
dG8gcHJldmVudCBjb3JydXB0aW9uIGZyb20NCj4gPiAgYnBmX3BlcmZfb3V0cHV0X2V2ZW50KCkN
Cj4gPg0KPiA+IFRoZSBicGZfcGVyZl9vdXRwdXRfZXZlbnQoKSBoZWxwZXIgdGFrZXMgYSBzYW1w
bGUgc2l6ZSBwYXJhbWV0ZXIgb2YNCj4gdTY0LCBidXQNCj4gPiB0aGUgdW5kZXJseWluZyBwZXJm
IHJpbmcgYnVmZmVyIHVzZXMgYSB1MTYgaW50ZXJuYWxseS4gVGhpcyA2NEtCIG1heGltdW0NCj4g
c2l6ZQ0KPiA+IGhhcyB0byBhbHNvIGFjY29tbW9kYXRlIGEgdmFyaWFibGUgc2l6ZWQgaGVhZGVy
LiBGYWlsdXJlIHRvIG9ic2VydmUgdGhpcw0KPiA+IHJlc3RyaWN0aW9uIGNhbiByZXN1bHQgaW4g
Y29ycnVwdGlvbiBvZiB0aGUgcGVyZiByaW5nIGJ1ZmZlciBhcyBzYW1wbGVzDQo+ID4gb3Zlcmxh
cC4NCj4gPg0KPiA+IFRydW5jYXRlIHRoZSByYXcgc2FtcGxlIHR5cGUgdXNlZCBieSBFQlBGIHNv
IHRoYXQgdGhlIHRvdGFsIHNpemUgb2YgdGhlDQo+ID4gc2FtcGxlIGlzIDwgVTE2X01BWC4gVGhl
IHNpemUgcGFyYW1ldGVyIG9mIHRoZSByZWNlaXZlZCBzYW1wbGUgd2lsbA0KPiBtYXRjaCB0aGUN
Cj4gPiBzaXplIG9mIHRoZSB0cnVuY2F0ZWQgc2FtcGxlLCBzbyB1c2VycyBjYW4gYmUgY29uZmlk
ZW50IGFib3V0IGhvdyBtdWNoDQo+IGRhdGENCj4gPiB3YXMgcmVjZWl2ZWQuDQo+ID4NCj4gDQo+
IEkgZG9uJ3QgdGhpbmsgdHJ1bmNhdGlvbiB3aXRob3V0IGFueSBpbmRpY2F0aW9uIHRvIHRoZSB1
c2VyIGlzIGEgZ29vZA0KPiBpZGVhIGFuZCBjYW4gbGVhZCB0byBvdGhlciBzdXJwcmlzaW5nIHBy
b2JsZW1zDQo+IChlc3BlY2lhbGx5IHdoZW4gdGhlIHVzZXJzcGFjZSBleHBlY3RzIHRoZSBkYXRh
IHRvIGJlIGluIGEgY2VydGFpbiBmb3JtYXQsDQo+IHdoaWNoIGl0IGFsbW9zdCBhbHdheXMgZG9l
cykuDQo+IA0KPiBJIHRoaW5rIHRoZSBjb21wbGV0ZSBzYW1wbGUgc2hvdWxkIGJlIGRpc2NhcmRl
ZCBpZiB0aGUgc2l6ZSBpcyB0b28gYmlnIGFuZCBhbg0KPiBFMkJJRyAvIG9yIHNvbWUgZXJyb3Ig
c2hvdWxkIGJlIHJldHVybmVkLg0KDQpJJ20gaGFwcHkgdG8gZG8gZWl0aGVyOyBJJ2xsIG1ha2Ug
YW4gYWx0ZXJuYXRpdmUgdGhhdCBqdXN0IHJldHVybnMgYW4gZXJyb3IuDQoNClRoYW5rcw0KDQpL
ZXYNCg0K

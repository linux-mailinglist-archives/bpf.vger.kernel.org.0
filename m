Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61F252E9B
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 14:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgHZMTk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 08:19:40 -0400
Received: from mail-eopbgr150094.outbound.protection.outlook.com ([40.107.15.94]:38950
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728682AbgHZMTj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 08:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beIUGiqBFX3SGPJbajHnCz1mD06m5tk9fPc3MkmO8SYSVzrD1+JRXxKFtPZBYwx0nlgssUTn/f64MJ50OF+mzibySKp/clkbbwea7PRACIhNPyoW3fjxcsbvXk9rPqvCkzI8RfcRix4qxsCGj/T0c58UocMINYBALx8iIQsRfRQfWuEdhkp6w4tjOzMotlKW+UEWCPN9vXYLJmVX0S/R7zxWglse0xS4BYI9cIzqR85lvFVPlUsp1T9rj5R2HZ5qyF3B1ACjJjn1+nSbZ/mnZCNVClHg0mxZYJSyJwzWS7oDvFivFCgIep1Cnb8rvnONOLXF+ESKJahnJ7mZL3qo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1io2rGKtYlqZnhdum4MoDcbUgkbtqt42/FXvw/upfU=;
 b=eUquV46XBGg02kSEp9I5GHGYhLvrWShsE7DSvxhAb7G3mOw1IQku8qh7ViJSnJVw635g1JjpzG+hI91mdQDxcPWGLIdvizemp+kVa1qzYP+j8r/QMEMp+oksp8KANUeRWdjNS0d9S7UfcyPtz9C2qt0Pj5eSQBvsiFPzUY0B74B9AHl5IGXFkRoEOvcya/LNYRyzVspx/mpwMJc4RI6j91XuMpm4UoJC2wEQB8mtPBNLk126ioaPg80r02NBZJxQHh6Xo93IUsFPel/CFi5haMdg/7Gd503qPh6wvFKWDs8w6XDGaYIQAbAAx4yDn7juIakG0BI4zG9Sz3i1WJI2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1io2rGKtYlqZnhdum4MoDcbUgkbtqt42/FXvw/upfU=;
 b=Ab8NV8Gvrsufw4UEv0xWnX+LDBdlQhAMyTygQGp59cS9GnJV/0iFOGCL9bL2fhGYpB/qyVpTdlAwXzcxENsDc5LRgtqLzMBdQkPTxCL2FuFr6O68AyfKZozDYcuiaO1BJ7BjWfT0ZkWwU2bPz3LEXmm2lL9tSXgENCB1/oxF/9w=
Received: from AM0PR83MB0275.EURPRD83.prod.outlook.com (2603:10a6:208:94::26)
 by AM0PR83MB0273.EURPRD83.prod.outlook.com (2603:10a6:208:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Wed, 26 Aug
 2020 12:19:32 +0000
Received: from AM0PR83MB0275.EURPRD83.prod.outlook.com
 ([fe80::4dd5:3b7e:321f:b1bd]) by AM0PR83MB0275.EURPRD83.prod.outlook.com
 ([fe80::4dd5:3b7e:321f:b1bd%8]) with mapi id 15.20.3348.005; Wed, 26 Aug 2020
 12:19:32 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Clang | llc incorrect jumps
Thread-Topic: [EXTERNAL] Re: Clang | llc incorrect jumps
Thread-Index: AdZ6+BhyKlwHLo/hTjGCiXuCkGGBSQAB3rQAACiyYNA=
Date:   Wed, 26 Aug 2020 12:19:31 +0000
Message-ID: <AM0PR83MB02753E93882896A2138995ADFB540@AM0PR83MB0275.EURPRD83.prod.outlook.com>
References: <AM0PR83MB0275B96730F50564861C3C55FB570@AM0PR83MB0275.EURPRD83.prod.outlook.com>
 <CAADnVQ+BpWg5aFMG2QV1OWvPgzrwqpPO+9fJ6NfwEPLp3Gp6Mw@mail.gmail.com>
In-Reply-To: <CAADnVQ+BpWg5aFMG2QV1OWvPgzrwqpPO+9fJ6NfwEPLp3Gp6Mw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kesheldr@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-26T12:19:28.9062338Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41a2629c-0c62-4158-93d1-7b6a297316e5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04bd2c34-960f-4761-2b5a-08d849ba49c1
x-ms-traffictypediagnostic: AM0PR83MB0273:
x-microsoft-antispam-prvs: <AM0PR83MB02737AE48637AF7A8B1BBFC1FB540@AM0PR83MB0273.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0zUQ+CmgutfublKROlj2TfUJUrry9kkdVSHONbgx7WeHxnjwyogPFF4tlrhHyj5Bgw4miruImhtxeEcN1tMPCAJwGaDselNcaRLHAks1HXDSgFbBMlv3U13yBopDVOI22JheKGNUndX4qOJUe+TmUe29/8zfFOLvsfV7uwroIDhJQ+2SNfuWg7aboYrZoEWIVYNLgJC/hgpHdt7rvJyaBfUAfK5rBCd5HRa9SYDoDAjcOPgZ40O6h2jcz9QDFQ7HL1JHGZRVK1JPJd/pBTGEdsl6NU/YEJb8ha1wNECcu0BPSOqufRx1qlqe8cwSaIsS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR83MB0275.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(316002)(110136005)(33656002)(8676002)(66446008)(8936002)(83380400001)(82950400001)(82960400001)(7696005)(64756008)(10290500003)(66556008)(186003)(71200400001)(76116006)(66946007)(6506007)(2906002)(53546011)(52536014)(86362001)(9686003)(5660300002)(4326008)(8990500004)(26005)(55016002)(478600001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XKUHtk3sFv5IIE+qHFbDWBrUAvOuHyHX2FqiG+3b090qu8t+UG/y9RcYXzvyLOo0o6WoKRWPhCMqL37nCLckjroYGC7eKZ0/EtwEkXgVIXuLOTXNwGl8ZqnzQ5wLRqLu9O4dmNBSKqmmZNCOojchUjI2huep++R+szDwTiVhjuaZpDK9rP3InxhEXZXcabpELBM+uCnbXqppBfDRPRKoeKukpiThFh8EpFIc36BJgJYz/6fAKhfzf9m4LY0gI/wA7BGNx6RvH+a/iHxy35V0EingP2diPGKSJp8GNhmZiE9sI9auJ8sEuq3pXmVgzc2X69wdYsVaIXwcZklnzDtaOjWIpYCRLod1pkPkOiKMnZKWbG2JJBxOSXMvJL66ZpDVphTf1DGELxDS//HCShJmTPBYy9Lbqr3SlTiEVCTXGFQEykz4g6ZONUJshZwDHBncNkARIgITV093wQdgIp+kDNqfEksxe5Y2cBT0Y29M3in+u5Hxfcaa57nDa+nJqH2A76sE7r4x8YN6hBdfdwXxhwYK6lFEkFV6qOHq+HSdHmL7je32gDQ5ud7hTbpXLSBx+XaOm1R0kx3UCB4ApAiB3KZv27aDuTO3w15LzEBPW7EB3gAgE6sNw0LGGR8z8M83nkGmU4zxqeRjZhBmuuYygg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR83MB0275.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd2c34-960f-4761-2b5a-08d849ba49c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 12:19:32.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqSno1al/+8S8HF1biryoHNC7CgXIjYN7kZZjozclD0j47N2vvUUL7vEc0oJRK6iMe7PUJCbEzKk0LS4g/e84A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR83MB0273
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQpPbiBUdWUsIEF1ZyAyNSwgMjAyMCBhdCA1OjQ5IFBNIEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxl
eGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IE9uIFR1ZSwgQXVnIDI1LCAyMDIw
IGF0IDk6MzQgQU0gS2V2aW4gU2hlbGRyYWtlDQo+IDxLZXZpbi5TaGVsZHJha2VAbWljcm9zb2Z0
LmNvbT4gd3JvdGU6DQo8U05JUD4NCj4gPiBJZiBJIHJlbW92ZSBvbmUgc2VjdGlvbiBvZiBjb2Rl
LCB1bnJlbGF0ZWQgdG8gd2hlcmUgdGhlIGlsbGVnYWwganVtcHMgYXJlLA0KPiByZWR1Y2luZyB0
aGUgb3ZlcmFsbCBzaXplIHRvIDI0NDgwIGluc3RydWN0aW9ucywgdGhlIGlsbGVnYWwganVtcHMg
ZGlzYXBwZWFyLiAgSWYNCj4gSSByZWVuYWJsZSB0aGF0IHNlY3Rpb24gb2YgY29kZSBhbmQgcmVt
b3ZlIGEgZGlmZmVyZW50IHNlY3Rpb24gb2YgY29kZSwgYWxzbw0KPiB1bnJlbGF0ZWQgdG8gdGhl
IGlsbGVnYWwganVtcHMsIHJlZHVjaW5nIHRoZSBvdmVyYWxsIHNpemUgdG8gNDc0NDQgaW5zdHJ1
Y3Rpb25zLA0KPiB0aGUgaWxsZWdhbCBqdW1wcyBkaXNhcHBlYXIgYWdhaW4uDQo+IA0KPiBJIHN1
c3BlY3QgaXQncyBhIGJ1ZyBpbiBsbHZtLiBJdCBkb2Vzbid0IGhhdmUgYSBjaGVjayB0aGF0IHRo
ZSBicmFuY2ggdGFyZ2V0IGZpdHMNCj4gaW50byAxNi1iaXRzLg0KPiBJdCBzaW1wbHkgZG9lczoN
Cj4gbGx2bS9saWIvVGFyZ2V0L0JQRi9NQ1RhcmdldERlc2MvQlBGQXNtQmFja2VuZC5jcHANCj4g
ICAgIFZhbHVlID0gKHVpbnQxNl90KSgoVmFsdWUgLSA4KSAvIDgpOw0KPiAgICAgc3VwcG9ydDo6
ZW5kaWFuOjp3cml0ZTx1aW50MTZfdD4oJkRhdGFbRml4dXAuZ2V0T2Zmc2V0KCkgKyAyXSwgVmFs
dWUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFbmRpYW4pOyBDb3Vs
ZCB5b3UgYWRkIGEgbG9nIGFyb3VuZCB0aGF0IGxpbmUgdG8gZG91YmxlDQo+IGNoZWNrIHRoYXQn
cyB0aGUgY2FzZT8NCj4gTWF5IGJlIHlvdSBjb3VsZCBzZW5kIGEgcGF0Y2ggdG8gYWRkIGFuIGFz
c2VydCB0aGVyZT8NCj4gSXQgd2lsbCBoZWxwIG90aGVycyBhdm9pZCB0aGlzIGRlYnVnZ2luZy4N
Cj4gDQo+IEluIHRoZSBwYXN0IHdlJ3ZlIHRhbGtlZCBhYm91dCBleHRlbmRpbmcgQlBGIElTQSB3
aXRoIDMyLWJpdCB1bmNvbmRpdGlvbmFsDQo+IGp1bXAgaW5zdHJ1Y3Rpb24uDQo+IEJ1dCBubyBv
bmUgZGlkbid0IGNvbWUgYXJvdW5kIHRvIGFjdHVhbGx5IGltcGxlbWVudGluZyBpdC4NCj4gT25j
ZSB3ZSBoYXZlIHN1Y2ggaW5zbiBsbHZtIHNob3VsZCBiZSBhYmxlIHRvIGRldGVjdCB0aGlzIDE2
LWJpdCBvdmVyZmxvdw0KPiBhbmQgdXNlIHRoaXMgbmV3IGptcCBpbnNuLg0KDQpIZWxsbyBBbGV4
ZWkNCg0KVGhhbmsgeW91IGZvciB0aGlzIGluc2lnaHQgLSB0aGF0J3MgcmVhbGx5IGhlbHBmdWwu
ICBJJ2xsIGdldCBvbiBpdCB3aGVuIEknbSBiYWNrIGF0IHdvcmsgb24gRnJpZGF5IGFuZCBJJ2xs
IHN1Ym1pdCBhIHBhdGNoLg0KDQpUaGFua3MNCg0KS2V2aW4gU2hlbGRyYWtlDQoNCg==

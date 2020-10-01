Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7202B280064
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 15:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgJANpb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 09:45:31 -0400
Received: from mail-eopbgr80107.outbound.protection.outlook.com ([40.107.8.107]:7652
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732018AbgJANpa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 09:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofNjYtCk8LGUQerVxrYViGtEstGFQNF4T1IMmtk1xlCky0XFQCE5lwe2bYBQc49sfoTw04xIcXSGzgQpVcviCGaPb7s+haLvb4lMV9A/wlV04qMsoUX0qvEPS0WPpnlATyXD3z+3Y9NiXDYR/P002bsbtN+g89Vi92ZympkKqzxHVjAjZsoU/7XJtYGaT2XxvJzZN00+25zkIk9WueSPb9W8xT3oNwlYhjwGpoFTie7rGRCpM1w6l7T4i5+W1NsUBpFKdy30aD0fet22LHecyZ1Hd8Kh+BwlKszkjH60s2vxTwexItLAvpzM/jyqyd/Pj1blhvazXK1qMd24xRcqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62sEQ86WyZTEuuTtKbNmoCy8d4panfFfbR0h5G966hc=;
 b=EtR5oBKJRXuLXrWhsBuU0y/6bpk5Q0gbjEksLXgocMw0nPFn/kJjrKnWVbE7PaONPuCfiUKULDr+eC3BsqdN5mGiSN43Z3YGWrJoJ9zagrp2BZSk1kljkF47Cq7nfGw3MlFXmDWhFTR9cT08zVylpGUgCv8LSw/ZlISG4Sg5XRWyhWdtCj+9erPW+nfW/LobL5H72PKG35OST2fjN+8n3urdvyVmJi8iH3Dys+Tigz3IxTvbvFsNKxEJFcRbzaHWNBzvR0fr/FcS7DtKtVe1JXPY0neiS6lWCjStqsb1EUeIthlgf4bs5Exowf4YG0+ZvhCfiuM68c99EN/f2+H0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62sEQ86WyZTEuuTtKbNmoCy8d4panfFfbR0h5G966hc=;
 b=OJUdGwuILNh4mW6rD+U15gs0z84JtMJC3rTpbOtng2pTnxdMNNnJtS0PVeApBCCFofE8e3dpdreZbssQv4HC74aNZgxkZxCS382XuNy1bdU4Sg3EY0DI254aKWKilqFuu6vzHxRGbstpJNHP9vzRffNfp8V72Aiqt17bii1CO9g=
Received: from VI1PR83MB0254.EURPRD83.prod.outlook.com (2603:10a6:802:78::25)
 by VI1PR83MB0448.EURPRD83.prod.outlook.com (2603:10a6:800:193::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.7; Thu, 1 Oct
 2020 13:45:26 +0000
Received: from VI1PR83MB0254.EURPRD83.prod.outlook.com
 ([fe80::ddc6:7443:478b:8514]) by VI1PR83MB0254.EURPRD83.prod.outlook.com
 ([fe80::ddc6:7443:478b:8514%4]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 13:45:26 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: BTF without CONFIG_DEBUG_INFO_BTF=y
Thread-Topic: [EXTERNAL] Re: BTF without CONFIG_DEBUG_INFO_BTF=y
Thread-Index: AdaX253QAMQ5d8YuR4qajmYBYHeBJAAAqj0AAATKhIAAASE7AAAAgfAAAAAuGzA=
Date:   Thu, 1 Oct 2020 13:45:25 +0000
Message-ID: <VI1PR83MB025405E9346E8EA4C0459428FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
References: <VI1PR83MB02542417DBEF45BBA9C90FF7FB300@VI1PR83MB0254.EURPRD83.prod.outlook.com>
 <87h7rejkwh.fsf@toke.dk> <20201001125029.GE3169811@kernel.org>
 <20201001132250.GF3169811@kernel.org> <87v9fuhxt9.fsf@toke.dk>
In-Reply-To: <87v9fuhxt9.fsf@toke.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kesheldr@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-01T13:45:24.2864551Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=163dd318-44f2-4dc3-8f66-a59dff84ed92;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e045c53c-8268-4f87-2f8c-08d8661040ac
x-ms-traffictypediagnostic: VI1PR83MB0448:
x-microsoft-antispam-prvs: <VI1PR83MB0448C7700D299112D069D7A8FB300@VI1PR83MB0448.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKVJZNfv+EkadmyLGQRe0q+4IC4zGRApEZGNVJF3ULzzOl8SoOcL9CQeR0imgWZOsbKgvE8L1AUlSCZaFGsGsAVF5UnDRlcnsYcPFXW9PFxITQaRATe62NN/36wpjHcP5xff81E/r+fOEbBbXpmtAXw5+4PRU3UZmjn3s1u/knK/RJtgSBwC3Dz3vY0i+REfuoN4Q4uiqgcszLrDQsUEvpohxbDS7JJDLNFU4c9F1zKgmXN1D1c4CmgKmA9+i/97apmZOoAs9gsC6R9si8zq4PJ5/0gwrw+WGKGLGoNyELfF+NYpa57yRHDDfGODUTmn/Dfc/d7NnRLwnP2Vm7Wxdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR83MB0254.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(2906002)(66574015)(7696005)(186003)(26005)(316002)(82950400001)(82960400001)(83380400001)(8990500004)(6506007)(76116006)(86362001)(5660300002)(52536014)(8676002)(8936002)(4326008)(55016002)(66946007)(33656002)(9686003)(10290500003)(71200400001)(66446008)(478600001)(66476007)(64756008)(66556008)(53546011)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0clNlrW8HBYmuE1b+blZhXMXyKiD83wdfrLWrhd58ZB1ncd2ZtUqzeI4UAIR9J/Bp/ZmqjRlP5glf9G2po743NpjQSfdx6f7a/XP9ZpDniRS1JB/sGgiwAdt2DI6FWskJl1wvMWnUOwWv4t3t+lSo7/W5+gJCmVSPSLkASBXlc2WuPV+gJqnXpMkj5WG/g+IPNZsneLFA4biBN8Z/Dx6X2NBWhdsMGhzTeTVPsZmbWUp+dfg5+RT27V64Db5CtVUTcwBhSTaR4fB8sx6abOf7Lp3R/5tGPEu0b6d1t4RL3Ll9E37tSxg/1kWvmCWsS1cdHjMyViVmmFdjwx60JtJOrTWRz0+2ppQfAJTXPC5+LeJeUPOFdSvHFyJJVybykt8SQfCEyWmEFxG+rZBdVNyo03e9PBN0rqosgouxJAbMHbTIw6UdLAqxXRg2yfsvMzo7cq6rlbelsSul0pKYGs7PO4+oCoIaSLiNJ1fj6Io5Rc4MWam255sUIjpB1IFz7DWn47zQLlKgm3uzWe9DeQAWDvlurcOx9EnjP1VYuS6AlyxtXHu/0W2NOzJK+MsBC9fKFTyQIpOq0jkyuoO5XiAOnfQZjm41p7cHAKZWO7kGkd7YFDiDEAUnJI40a0/fGUdyDIZM2mv/SWzmCkfrFcJaA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR83MB0254.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e045c53c-8268-4f87-2f8c-08d8661040ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 13:45:26.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5hpdRNYAN3cYXtVz846xzMmquxO8x/TYeoeScERjYmv9Jao3/FeEdt1Kzw0632ql95GVTfGsqGHdS77uMCz4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0448
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9rZSBIw7hpbGFuZC1K
w7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDAxIE9jdG9iZXIgMjAyMCAxNDoz
Nw0KPiBUbzogQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQGtlcm5lbC5vcmc+DQo+IENj
OiBLZXZpbiBTaGVsZHJha2UgPEtldmluLlNoZWxkcmFrZUBtaWNyb3NvZnQuY29tPjsNCj4gYnBm
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBCVEYgd2l0aG91dCBD
T05GSUdfREVCVUdfSU5GT19CVEY9eQ0KPiANCj4gQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxh
Y21lQGtlcm5lbC5vcmc+IHdyaXRlczoNCj4gDQo+ID4gRW0gVGh1LCBPY3QgMDEsIDIwMjAgYXQg
MDk6NTA6MjlBTSAtMDMwMCwgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+IGVzY3JldmV1Og0K
PiA+PiBFbSBUaHUsIE9jdCAwMSwgMjAyMCBhdCAxMjozMzoxOFBNICswMjAwLCBUb2tlIEjDuGls
YW5kLUrDuHJnZW5zZW4NCj4gZXNjcmV2ZXU6DQo+ID4+ID4gS2V2aW4gU2hlbGRyYWtlIDxLZXZp
bi5TaGVsZHJha2VAbWljcm9zb2Z0LmNvbT4gd3JpdGVzOg0KPiA+PiA+ID4gSSd2ZSBzZWVuIG1l
bnRpb24gYSBmZXcgdGltZXMgdGhhdCBCVEYgaW5mb3JtYXRpb24gY2FuIGJlIG1hZGUNCj4gPj4g
PiA+IGF2YWlsYWJsZSBmcm9tIGEga2VybmVsIHRoYXQgd2Fzbid0IGNvbmZpZ3VyZWQgd2l0aA0K
PiA+PiA+ID4gQ09ORklHX0RFQlVHX0lORk9fQlRGLiBQbGVhc2UgY2FuIHNvbWVvbmUgdGVsbCBt
ZSBpZiB0aGlzIGlzIHRydWUNCj4gPj4gPiA+IGFuZCwgaWYgc28sIGhvdyBJIGNvdWxkIGdvIGFi
b3V0IGFjY2Vzc2luZyBhbmQgdXNpbmcgaXQgaW4NCj4gPj4gPiA+IGtlcm5lbHMgNC4xNSB0byA1
Ljg/DQo+ID4NCj4gPj4gPiA+IEkgaGF2ZSBidWlsdCB0aGUgZHdhcnZlcyBwYWNrYWdlIGZyb20g
dGhlIGdpdGh1YiBsYXRlc3QgYW5kIHJ1bg0KPiA+PiA+ID4gcGFob2xlIHdpdGggJy1KJyBhZ2Fp
bnN0IG15IGtlcm5lbCBpbWFnZSB0byBubyBhdmFpbCAtIGl0DQo+ID4+ID4gPiBhY3R1YWxseSBz
ZWcNCj4gPj4gPiA+IGZhdWx0czoNCj4gPg0KPiA+PiA+ID4gfi9kd2FydmVzL2J1aWxkICQgc3Vk
byAuL3BhaG9sZSAvYm9vdC92bWxpbnV6LTUuMy4wLTEwMjItYXp1cmUNCj4gPj4gPiA+IGJ0Zl9l
bGZfX25ldzogY2Fubm90IGdldCBlbGYgaGVhZGVyLg0KPiA+PiA+ID4gY3RmX19uZXc6IGNhbm5v
dCBnZXQgZWxmIGhlYWRlci4NCj4gPj4gPiA+IH4vZHdhcnZlcy9idWlsZCAkIHN1ZG8gLi9wYWhv
bGUgLUogL2Jvb3Qvdm1saW51ei01LjMuMC0xMDIyLWF6dXJlDQo+ID4+ID4gPiBidGZfZWxmX19u
ZXc6IGNhbm5vdCBnZXQgZWxmIGhlYWRlci4NCj4gPj4gPiA+IGN0Zl9fbmV3OiBjYW5ub3QgZ2V0
IGVsZiBoZWFkZXIuDQo+ID4+ID4gPiBTZWdtZW50YXRpb24gZmF1bHQNCj4gPj4gPiA+IH4vZHdh
cnZlcy9idWlsZCAkIHN1ZG8gLi9wYWhvbGUgLS12ZXJzaW9uDQo+ID4+ID4gPiB2MS4xNw0KPiA+
DQo+ID4+ID4gPiBKdWRnaW5nIGJ5IHRoZSBvdXRwdXQsIEknbSBndWVzc2luZyB0aGF0IG15IGtl
cm5lbCBpbWFnZSBpc24ndA0KPiA+PiA+ID4gdGhlIHJpZ2h0IGtpbmQgb2YgZmlsZS4gQ2FuIHNv
bWVvbmUgcG9pbnQgbWUgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbj8NCj4gPg0KPiA+PiA+IHZtbGlu
dXogaXMgYSBjb21wcmVzc2VkIGltYWdlLiBUaGVyZSdzIGEgc2NyaXB0IGluIHRoZSBrZXJuZWwN
Cj4gPj4gPiBzb3VyY2UgdHJlZSAoc2NyaXB0cy9leHRyYWN0LXZtbGludXgpLCBob3dldmVyIHRo
ZSBrZXJuZWwgaW1hZ2UgaW4NCj4gPj4gPiAvYm9vdC8gcHJvYmFibHkgYWxzbyBoYXMgZGVidWcg
aW5mb3JtYXRpb24gc3RyaXBwZWQgZnJvbSBpdCwgc28NCj4gPj4gPiB0aGF0IGxpa2VseSB3b24n
dCBoZWxwIHlvdS4gWW91J2xsIG5lZWQgdG8gZ2V0IGhvbGQgb2YgYSBrZXJuZWwNCj4gPj4gPiBp
bWFnZSB3aXRoIGRlYnVnIGluZm9ybWF0aW9uIHN0aWxsIGludGFjdCBzb21laG93Li4uDQo+ID4N
Cg0KU05JUA0KPiA+ICAgICBSZXBvcnRlZC1ieTogS2V2aW4gU2hlbGRyYWtlIDxLZXZpbi5TaGVs
ZHJha2VAbWljcm9zb2Z0LmNvbT4NCj4gPiAgICAgQ2M6IFRva2UgSMO4aWxhbmQtSsO4cmdlbnNl
biA8dG9rZUByZWRoYXQuY29tPg0KPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBBcm5hbGRvIENhcnZh
bGhvIGRlIE1lbG8gPGFjbWVAcmVkaGF0LmNvbT4NCj4gDQo+IFllYWgsIHRoYXQncyBtdWNoIGJl
dHRlciENCj4gDQo+IEFja2VkLWJ5OiBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gPHRva2VAcmVk
aGF0LmNvbT4NCg0KVGhhbmsgeW91IHRvIEFybmFsZG8gZm9yIGlkZW50aWZ5aW5nIGFuZCBmaXhp
bmcgdGhlIHNlZyBmYXVsdC4NCg0KQW0gSSByaWdodCBpbiB0aGlua2luZyB0aGF0IHBhaG9sZSBj
YW4ndCB3b3JrIG9uIGEgc3RhbmRhcmQgb3V0LW9mLXRoZS1ib3ggZGlzdHJvIHN1Y2ggYXMgVWJ1
bnR1IDE2LjA0ICh2NC4xNSkgb3IgMTguMDQgKHY1LjMvNS40KSBhcyBkZWJ1Z2dpbmcgaW5mb3Jt
YXRpb24gaXNuJ3QgYXZhaWxhYmxlIGluIHRoZSBrZXJuZWwsIGFuZCBlcXVhbGx5IGlzbid0IGF2
YWlsYWJsZSBhbnl3aGVyZSBlbHNlLCB3aXRob3V0IHJlY29tcGlsaW5nIGl0Pw0KDQpNYW55IHRo
YW5rcw0KDQpLZXYNCg0K

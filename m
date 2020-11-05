Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74E2A7C1C
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 11:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgKEKrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 05:47:00 -0500
Received: from mail-am6eur05on2108.outbound.protection.outlook.com ([40.107.22.108]:7873
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbgKEKq7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 05:46:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1RqczFmng1Cb3HJkY/zU4Z9PHtV4GVTbVmcViP3FYQOfxaI/BzwDm+cno0csBs0F+mbSEc34AmxvKKNnUddHoVoMXgEdchYnE0XNHEpOTIfG3fcpRhhXhtA7gJuH+FlaQNSG/k4RXIF9l9yo0MBlo49WCJoAHSPmaoCJxUpDRuuWJ5+mTfMLd+eJJTHpVsXFo5a6BkjX5syM3y2kLletSxnw/bUeukA0i3Es317C95bk81RfpacoX/zOD8is9hkg+fZ2gsgZY7rJwPoOXGPTBRbkSC2qZSon83oZuSxrVFlFiImuo2ZSd6yriNZgY8GbEpmyRB+KD3aRg4Vb+WLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHDkGar590XOs/mS1KWVi98ohGWJM1LvcOu+NgJzq+I=;
 b=j1Qyj2N1OOM72pZmPmq2/j4fvYobWGL0KChBCkSUn0z8OVLIGIxyD5qvdtdGMtNJ4dGH+uvxZ5J0NgnlnyMa7A5qmquRUzE9WBIRjAPKpnzu2t/3vEenxGlgQX7hTl/FPHK/9iBpp0lpb3RjX2HSFRFZpQm7k2Ha8Ac3VwoLGw8alNCrridMblL+QpeHky66i6T3+IlHJ27g8hYJJDdVixbXP2JpwdUDfFF8GbUnjpfY08X1n996s7OLBp7Zg0NXbIBaHqRHcOcv97NA10xbfMLpmbiRmTWHTd0ATFm4u1jIHF/e28Cd7NTLaL9uykuwHslUgtk32s4vfRLTP+aysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHDkGar590XOs/mS1KWVi98ohGWJM1LvcOu+NgJzq+I=;
 b=TqRwftrLolmDBPYTYOu1zpkgJvPN9g2AyL3M9KQKh9aokL+w02WkMEcqJtg8jToiSGRDaXY87wQd7RKJSV52atK7FIwhQ9pnmARU3ENTOr8AHrdaruC05rbFC22EDM4ATiEDDeNcsvqwN6+srH6eZXonhjPo0nabqER/lvJ3UF8=
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 (2603:10a6:820:1b::23) by VI1PR83MB0174.EURPRD83.prod.outlook.com
 (2603:10a6:802:3b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Thu, 5 Nov
 2020 10:46:56 +0000
Received: from VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99]) by VI1PR8303MB0080.EURPRD83.prod.outlook.com
 ([fe80::c857:1a78:d155:fc99%10]) with mapi id 15.20.3564.010; Thu, 5 Nov 2020
 10:46:56 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        KP Singh <kpsingh@google.com>
Subject: RE: [EXTERNAL] Re: [PATCH bpf-next] bpf: update verifier to stop perf
 ring buffer corruption
Thread-Topic: [EXTERNAL] Re: [PATCH bpf-next] bpf: update verifier to stop
 perf ring buffer corruption
Thread-Index: AdautGZ4+1YSnWihRZa8ESQSP7NSdQANOrqAAR28kqA=
Date:   Thu, 5 Nov 2020 10:46:56 +0000
Message-ID: <VI1PR8303MB0080C6107883B839835953DFFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
References: <VI1PR8303MB008003C9E3B937033A593C47FB150@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
 <CAEf4Bza-KX7C5ghXSVs30R_xkKtqjDwM8snH2B2A_VCAxSim2g@mail.gmail.com>
In-Reply-To: <CAEf4Bza-KX7C5ghXSVs30R_xkKtqjDwM8snH2B2A_VCAxSim2g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-05T10:41:48Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6c76da68-a215-402e-b096-b0921d5a4bfd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [149.12.0.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 084ed22e-6388-4acc-430c-08d881781d87
x-ms-traffictypediagnostic: VI1PR83MB0174:
x-microsoft-antispam-prvs: <VI1PR83MB01748AE2122398CBFB67CA18FBEE0@VI1PR83MB0174.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFzhi3FfbvGWdwH8oIQZzntFE5Y5WBEgl0ypTUa4nr60bnCciAigwHCEhKNPyiNkkJtX9sSeihiamNiOGy9NBlZBBUqIGbw3RMhDzO+6+mTWq46hZJFDqYsIlFDXT6n9e6VW39Py+AeyrXQR2PwdBIu3FXrppzlbkZkoi17m5ypu27epREk422MSobDLuLOc2eZ/MaItnWiI47TvXT/osn0roKiOjBbUwvEZtemAkV8pxH1opW5nM5880Sfy6Na5LGNS722YCqMYoyYEfxukGn158C590oxw6HY6a3JXcGb0zp9HCNgqhiFpv4HOLmioVHgbG5kJLVAqzTl2XqoSYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR8303MB0080.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(66476007)(66556008)(4326008)(54906003)(66946007)(64756008)(76116006)(52536014)(86362001)(478600001)(66446008)(2906002)(8990500004)(186003)(9686003)(8676002)(26005)(15650500001)(55016002)(10290500003)(83380400001)(316002)(53546011)(8936002)(7696005)(82960400001)(71200400001)(82950400001)(6916009)(6506007)(33656002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yFG8TypwPCrGIuruU/qyg5ZoNUpa7XzK5Sa9PyXmd5Qfis8bh0xNqkVQD/3Jz3f6kIo9h4b+yO/PxHANnDOlhhQ3FJgMCywlUOL9ZMORgqMtEpqc8WgFFY6E5QIVLEkr2fsK/Juik5m5IbJ2SolrFbHC4ySemqCho7LONxKfARzfE8mgy33jLsX+AxEJm/12uajL5RXyxckDCnQWvJd7TsxJV/6mBX5lwKzCJ58uMruUZOknGqo/kYgetYEmX/Ld75W8GZnNB+kr1DCuG+n93Q3dks8Y3jk3suLSONqRXfZmt0Vx//3o1fviPzUJTeB656b5epZtNxrYaeKKbbnyJFvgpYCtdyWbRek6suq8mcNOZ1i1Ou6/KPLmOMLMNfFMRnXW4fWnsdrT0I8YbQHzZ33p/pc9aSO70Ewi96j3K5mEY8J6FjYA4mXAKnuoBeh7FLXW6vKjb8+PMdvAfqJPnIhByTU71mAwM5xZH4S/wRjAmi6y9kozPk0vN1zDyn86YaM2Ewo8OXJiVNRRlDptcRrcHQy9JIkrC4C/da2wXDwHANDJ68PMy7JaCcs5NsEXCz/5+r019tC8vNKDms5HUcGxeStEuo8AxTWSfeAxtVDn7NPKUsycLJ5iSMGIkVcGYhW/Nn/JBrgm87bS8SJUq3bzUDUV+T4gy9iL2Ycw6A/0+YU6ueG2T5w3gBDnI0tWpwEedKQ3tUO18owbUB79LqfAaAYfxuix+qniMOF+g6hp0i2mymoBBAsr8UAkd5Tga+KX7t3cnqt6Mq5GjjU1nb4feH4R9fzqYu+DcOuUfJI6b8HQXfELVu3WI2DfMPdDM7QFqnewQlXpO278Rhav40zy08gy/bPs/KHqziZYFwFVfltp+qnDGkx1dwPItdeI+tKZuUusbNglLBw9Ie9pcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR8303MB0080.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084ed22e-6388-4acc-430c-08d881781d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 10:46:56.1968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTyaSFnLyHWSwwG5pV49x/C71fBRCw0O627UD7RjQ4Qn/QvMJX1SKOzCuWn0MnLVydMBrcR70RJSUDEi19sHDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR83MB0174
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmlpIE5ha3J5aWtv
IDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPg0KPiBTZW50OiAzMCBPY3RvYmVyIDIwMjAgMTg6
MjANCj4gVG86IEtldmluIFNoZWxkcmFrZSA8S2V2aW4uU2hlbGRyYWtlQG1pY3Jvc29mdC5jb20+
DQo+IENjOiBicGZAdmdlci5rZXJuZWwub3JnOyBLUCBTaW5naCA8a3BzaW5naEBnb29nbGUuY29t
Pg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggYnBmLW5leHRdIGJwZjogdXBkYXRl
IHZlcmlmaWVyIHRvIHN0b3AgcGVyZg0KPiByaW5nIGJ1ZmZlciBjb3JydXB0aW9uDQo+IA0KWy4u
Ll0NCj4gU2VlIFswXSBmb3Igc29tZSBndWlkZWxpbmVzLiBJIHVzZSBnaXQgZm9ybWF0LXBhdGNo
IGFuZCBnaXQgc2VuZC1lbWFpbCBmb3IgbXkNCj4gcGF0Y2ggd29ya2Zsb3cuIEFuZCBwbGVhc2Ug
bWFrZSBzdXJlIHlvdXIgZW1haWwgY2xpZW50L2VkaXRvciB3cmFwcyB0aGUNCj4gbGluZXMsIGl0
J3MgaGFyZCB0byByZXBseSBpZiB0aGUgZW50aXJlIHBhcmFncmFwaCBpcyBvbmUgbG9uZyBsaW5l
Lg0KDQpUaGFuayB5b3UgZm9yIHRoZSByZWZlcmVuY2VzLiAgSG9wZWZ1bGx5IG15IG5ld2x5IHN1
Ym1pdHRlZCBwYXRjaCAod2l0aCBhDQpuZXcvYXBwcm9wcmlhdGUgc3ViamVjdCBsaW5lKSBhZGRy
ZXNzZXMgdGhlc2UgaXNzdWVzLg0KDQpbLi4uXQ0KPiBTbyAtMjQgc2hvdWxkIGhhdmUgYmVlbiBh
IGNsdWUgdGhhdCBzb21ldGhpbmcgZmlzaHkgaXMgZ29pbmcgb24uIExvb2sgYXQNCj4gcGVyZl9w
cmVwYXJlX3NhbXBsZSgpIGluIGtlcm5lbC9ldmVudHMvY29yZS5jLiBoZWFkZXItPnNpemUgKHdo
aWNoIGlzIHUxNikNCj4gY29udGFpbnMgdGhlIGVudGlyZSBzaXplIG9mIHRoZSBkYXRhIGluIHRo
ZSBwZXJmIGV2ZW50LiBUaGlzIGluY2x1ZGVzIHJhdyBkYXRhDQo+IHRoYXQgeW91IHNlbmQgd2l0
aCBicGZfcGVyZl9ldmVudF9vdXRwdXQoKSwgYnV0IGl0IGNhbiBhbHNvIGhhdmUgdG9ucyBvZg0K
PiBvdGhlciBzdHVmZiAoZS5nLiwgY2FsbCBzdGFja3MsIExCUiBkYXRhLCBldGMpLg0KPiBXaGF0
IGdldHMgYWRkZWQgdG8gdGhlIHBlcmYgc2FtcGxlIGRlcGVuZHMgb24gaG93IHRoZSBwZXJmIGV2
ZW50IHdhcw0KPiBjb25maWd1cmVkIGluIHRoZSBmaXJzdCBwbGFjZS4gQW5kIGl0IGhhcHBlbnMg
YXV0b21hdGljYWxseSBvbiBlYWNoIHBlcmYgZXZlbnQNCj4gb3V0cHV0Lg0KPiANCj4gU28sIGFs
bCB0aGF0IG1lYW5zIHRoYXQgdGhlcmUgY291bGQgYmUgbm8gcmVsaWFibGUgc3RhdGljIGNoZWNr
IGluIHRoZSB2ZXJpZmllcg0KPiB3aGljaCB3b3VsZCBwcmV2ZW50IHRoZSBjb3JydXB0aW9uLiBJ
dCBoYXMgdG8gYmUgY2hlY2tlZCBieQ0KPiBwZXJmX3ByZXBhcmVfc2FtcGxlKCkgaW4gcnVudGlt
ZSBiYXNlZCBvbiB0aGUgYWN0dWFsIHNpemUgb2YgdGhlIHNhbXBsZS4NCj4gV2UgY2FuIGRvIGFu
IGV4dHJhIGNoZWNrIGluIHZlcmlmaWVyLCBidXQgSSB3b3VsZG4ndCBib3RoZXIgYmVjYXVzZSBp
dCdzIG5ldmVyDQo+IGdvaW5nIHRvIGJlIDEwMCUgY29ycmVjdC4NCj4gDQoNClRoYW5rIHlvdSBh
Z2FpbjsgSSd2ZSBidWlsdCBhIGNoZWNrIGludG8gcGVyZl9wcmVwYXJlX3NhbXBsZSgpLg0KDQpb
Li4uXQ0K

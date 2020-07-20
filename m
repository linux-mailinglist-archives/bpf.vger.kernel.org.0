Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD78225D8B
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGTLjr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 07:39:47 -0400
Received: from mail-eopbgr60107.outbound.protection.outlook.com ([40.107.6.107]:11872
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbgGTLjq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 07:39:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHVjvM5cxo9u721CmTK/kOQ9JHVTF0RqM2Zv/1KizptlPbZotwQsP8B9ay1B7v2hQJBPQ13Q98MubN09RApP0OM8g4SQNb+zi0uwmi2DWLNZgF2ZLInSgIEM9cqqsmMbTacCH0F4SWZIvcxz1AehsOkEMttS0CHaCHXsm77OqUR+/CzaPJi5w6UmOm4vuC/l3JIYRttyj4FQMr2GNFWciP+/mxdQQv4UZHJWDz2a6vUswlM2LhIAZCzzPcVQouFyLlJ8K1lhWEq5fSVeno+jotRjowrWPFr17uSe0SYwk5R8ru7TbqmxJU4kcgiERollM8cekNKIrlDFCSF3boU9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIOqNBNxrk6OVFwUzFcraKaYg/sDNbshhpIStr1Vm20=;
 b=fnUg4ZV6kB/P5qvDCRRQ73tUeSBEngw2+BBbQTmZsO4L4Me7WK1kJYmnvZeiOonn6ZYJJ6/uk84R+GXKj7fneKuEMHf1uqtbDGdn/zT07Gjz0b4U5JXBG+Pjgrd4O+6bPorkqGUmRpPCXStQ9taLwt/t1DeDA/6vfjdCacXZDjvNJZcbRgZWuGzE++UwVEOHDj3A44ffKpybmQgTFHM5gIvln989BX9o69PLsCYnHfDxT8bOEFBCVG75E80kjsu49wHiNF2//c3fxL4pCzMaXJP6pTf0pEA7Z+f71wj6oyXuFqOOOjdhl71BBn9rY6y3l8IAm9ohMKdQZOwZO3tsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIOqNBNxrk6OVFwUzFcraKaYg/sDNbshhpIStr1Vm20=;
 b=c7nBAKhWzpCltlRf11keZYKB9bEKdPNJgi6xru+B6iqXDoTm9sg+ALvhiE9LLQwFjZK+NYRD2xVxzKn1zpnNXOYCGPEuZLhVm9+sfCi57rb3WJ8xwhPsumEIFPl1liSdUSKfoB46x3YdWuh9T4tFP2M29XnYLd0U22F9IcZUWnk=
Received: from HE1PR83MB0220.EURPRD83.prod.outlook.com (2603:10a6:23:31::27)
 by HE1PR83MB0329.EURPRD83.prod.outlook.com (2603:10a6:7:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.1; Mon, 20 Jul
 2020 11:39:41 +0000
Received: from HE1PR83MB0220.EURPRD83.prod.outlook.com
 ([fe80::68:5319:d4f1:a11e]) by HE1PR83MB0220.EURPRD83.prod.outlook.com
 ([fe80::68:5319:d4f1:a11e%12]) with mapi id 15.20.3239.003; Mon, 20 Jul 2020
 11:39:36 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
Thread-Topic: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
Thread-Index: AdZcRdT23AT0UyAxRuO+fVAupufT3wCCVcuAAA6Q+FA=
Date:   Mon, 20 Jul 2020 11:39:36 +0000
Message-ID: <HE1PR83MB0220F45891B3B413F6634662FB7B0@HE1PR83MB0220.EURPRD83.prod.outlook.com>
References: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
 <CAEf4BzbE5+V8GJJwASgJJyCdX3P41GeoK14szprZq4i_OrQFOg@mail.gmail.com>
In-Reply-To: <CAEf4BzbE5+V8GJJwASgJJyCdX3P41GeoK14szprZq4i_OrQFOg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kesheldr@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-20T11:39:34.8600033Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6a6b00fb-56c4-452f-a6d4-4d0d21445068;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [149.22.2.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d67f80e-e74a-4f6b-691e-08d82ca194a4
x-ms-traffictypediagnostic: HE1PR83MB0329:
x-microsoft-antispam-prvs: <HE1PR83MB032985A6AA5DA025C43D63EFFB7B0@HE1PR83MB0329.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJQt52QTuM8b+s5IQPCogDRsN2rv9wlOQsWs5imFhV+I51oZ7cjLsSfQ4MKG86RSdNoT+1JxCb1LaFE6lxyHsb5Q8zELHZNP9OIQg01OZnGpM/PsNLFI3fUr/VSay46mwj9A7X6RvYBPpgvC5SxJ3IgdiI+d2jevasgOcSbXMWI2874yzOicSdlQyqLVtlhGkoaWRVqBHHJuix4I3eawmp7tEys00ZsrgWoggs5+8vhKCTI7GKZu/ODth0jmdmPuOSOxLOuHsk4r+zEawaogleF4+8SZ/GYTdYniMBVPpccX5W8pJSnIycCunkMT4JwMcQMCKQIHhSXRegrP99En0LILdvqm7Kpy1HDBtBqa74vrhHsr1LSeUGqm/cWz3LdHwux9jBQDZgslsr3IDtsDoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR83MB0220.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(83380400001)(7696005)(4326008)(71200400001)(8990500004)(55016002)(9686003)(8936002)(66946007)(82960400001)(82950400001)(33656002)(66446008)(66556008)(76116006)(5660300002)(86362001)(2906002)(316002)(8676002)(6916009)(186003)(6506007)(966005)(10290500003)(53546011)(52536014)(478600001)(66476007)(64756008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wj4UYefZNssUcxUXEPLWzCV8mnNSpOf+HhLpUbDkPljiVXogigOr5miqZsA4rsM4wIVI21Bj/dMldirVmFdWI3iPcgWHPkFxNAaIwoenNlNPLj9+TLwEkRNjNiqFOmi7WPrftwKrL6WxkwIusnF0jlHSEplQiV1XtQdRuWt15PdP5HYEyYcFj3y/vCfQWVI5dppsSqL/YK0rYXW/zyDdRJNrHY/QcAESjasTA8fpm30aunoyNNgLcJ89lSUheIKwTyriGFc+QIGaVFZkisOBmQBenefZ5XVmNhw/oTZr1ad5drnfugIdFD0IhWkqOhQjRvyEZ/2OMk/9cKKPIaZuoKhfWS2Fbb0Aau4ptvqGTEcld+RN8SLo8yesGMqYjJDMmkT7ieNYPDnX34J5wPVyY5VuktYspmWiAXT8oBjeAgJh3+qZwk0xuHYibCTjOIvAzGp6vpAbtyTqyqpizMuVcqq/26G47nNoe7CySU7HzKRNoSUFFu/RUJESAZCH13JQQDjw6dqtBTuZWc2dGRsGLZEvpLxhyGCU9ahoTTjdKRqQia5vdOp4+X3qgrP6kO3+/Jt0yc5sPBL5BXurlBbbjh9Jex4kcZ6BwQ2SQoJG/FfhpbLUGETqdzKBt+CkOFWgEAfQvZtxDHkedt6DCC+Szg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR83MB0220.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d67f80e-e74a-4f6b-691e-08d82ca194a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 11:39:36.5316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJC6thNYbboFURTS0sDHBTx0UuxoAU92XWJg8SlyObLqoiFtjxCUcqUq1vgGwy7Zt6HFzH7WN58Sr8F3UFZj0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR83MB0329
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGVsbG8NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlOyBJIGhvcGUgeW91IGRvbid0IG1p
bmQgbWUgdG9wLXBvc3RpbmcuICBJJ3ZlIHB1dCB0b2dldGhlciBhIFBPQyB0aGF0IGRlbW9uc3Ry
YXRlcyBteSByZXN1bHRzLiAgRWRpdCB0aGUgc2l6ZSBvZiB0aGUgZGF0YSBjaGFyIGFycmF5IGlu
IGV2ZW50X2RlZnMuaCB0byBjaGFuZ2UgdGhlIGJlaGF2aW91ci4NCg0KaHR0cHM6Ly9naXRodWIu
Y29tL21pY3Jvc29mdC9PTVMtQXVkaXRkLVBsdWdpbi90cmVlL01TVElDLVJlc2VhcmNoL2VicGZf
cGVyZl9vdXRwdXRfcG9jDQoNClVuZm9ydHVuYXRlbHksIG91ciBwcm9qZWN0IGFpbXMgdG8gcnVu
IG9uIG9sZGVyIGtlcm5lbHMgdGhhbiA1Ljggc28gdGhlIGJwZiByaW5nIGJ1ZmZlciB3b24ndCB3
b3JrIGZvciB1cy4NCg0KVGhhbmtzIGFnYWluDQoNCktldmluIFNoZWxkcmFrZQ0KDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBicGYtb3duZXJAdmdlci5rZXJuZWwub3JnIDxi
cGYtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgQW5kcmlpIE5ha3J5aWtvDQpT
ZW50OiAyMCBKdWx5IDIwMjAgMDU6MzUNClRvOiBLZXZpbiBTaGVsZHJha2UgPEtldmluLlNoZWxk
cmFrZUBtaWNyb3NvZnQuY29tPg0KQ2M6IGJwZkB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtF
WFRFUk5BTF0gUmU6IE1heGltdW0gc2l6ZSBvZiByZWNvcmQgb3ZlciBwZXJmIHJpbmcgYnVmZmVy
Pw0KDQpPbiBGcmksIEp1bCAxNywgMjAyMCBhdCA3OjI0IEFNIEtldmluIFNoZWxkcmFrZSA8S2V2
aW4uU2hlbGRyYWtlQG1pY3Jvc29mdC5jb20+IHdyb3RlOg0KPg0KPiBIZWxsbw0KPg0KPiBJJ20g
YnVpbGRpbmcgYSB0b29sIHVzaW5nIEVCUEYvbGliYnBmL0MgYW5kIEkndmUgcnVuIGludG8gYW4g
aXNzdWUgdGhhdCBJJ2QgbGlrZSB0byBhc2sgYWJvdXQuICBJIGhhdmVuJ3QgbWFuYWdlZCB0byBm
aW5kIGRvY3VtZW50YXRpb24gZm9yIHRoZSBtYXhpbXVtIHNpemUgb2YgYSByZWNvcmQgdGhhdCBj
YW4gYmUgc2VudCBvdmVyIHRoZSBwZXJmIHJpbmcgYnVmZmVyLCBidXQgZXhwZXJpbWVudGF0aW9u
IChvbiBrZXJuZWwgNS4zICh4NjQpIHdpdGggbGF0ZXN0IGxpYmJwZiBmcm9tIGdpdGh1Yikgc3Vn
Z2VzdHMgaXQgaXMganVzdCBzaG9ydCBvZiA2NEtCLiAgUGxlYXNlIGNvdWxkIHNvbWVvbmUgY29u
ZmlybSBpZiB0aGF0J3MgdGhlIGNhc2Ugb3Igbm90PyAgTXkgZXhwZXJpbWVudHMgc3VnZ2VzdCB0
aGF0IHNlbmRpbmcgYSByZWNvcmQgdGhhdCBpcyBncmVhdGVyIHRoYW4gNjRLQiByZXN1bHRzIGlu
IHRoZSBzaXplIHJlcG9ydGVkIGluIHRoZSBjYWxsYmFjayBiZWluZyBjb3JyZWN0IGJ1dCB0aGUg
cmVjb3JkcyBvdmVybGFwcGluZywgY2F1c2luZyBjb3JydXB0aW9uIGlmIHRoZXkgYXJlIG5vdCBz
ZXJ2aWNlZCBhcyBxdWlja2x5IGFzIHRoZXkgYXJyaXZlLiAgU2V0dGluZyB0aGUgcmVjb3JkIHRv
IGV4YWN0bHkgNjRLQiByZXN1bHRzIGluIG5vIHJlY29yZHMgYmVpbmcgcmVjZWl2ZWQgYXQgYWxs
Lg0KPg0KPiBGb3IgcmVmZXJlbmNlLCBJJ20gdXNpbmcgcGVyZl9idWZmZXJfX25ldygpIGFuZCBw
ZXJmX2J1ZmZlcl9fcG9sbCgpIG9uIHRoZSB1c2VybGFuZCBzaWRlOyBhbmQgYnBmX3BlcmZfZXZl
bnRfb3V0cHV0KGN0eCwgJmV2ZW50X21hcCwgQlBGX0ZfQ1VSUkVOVF9DUFUsIGV2ZW50LCBzaXpl
b2YoZXZlbnRfcykpIG9uIHRoZSBFQlBGIHNpZGUuDQo+DQo+IEFkZGl0aW9uYWxseSwgaXMgdGhl
cmUgYSBiZXR0ZXIgYXJjaGl0ZWN0dXJlIGZvciBzZW5kaW5nIGxhcmdlIHZvbHVtZXMgb2YgZGF0
YSAoPjY0S0IpIGJhY2sgZnJvbSB0aGUgRUJQRiBwcm9ncmFtIHRvIHVzZXJsYW5kLCBzdWNoIGFz
IGEgZGlmZmVyZW50IHJpbmcgYnVmZmVyLCBhIG1hcCwgc29tZSBraW5kIG9mIHNoYXJlZCBtbWFw
ZWQgc2VnbWVudCwgZXRjLCBvdGhlciB0aGFuIHNpbXBseSBmcmFnbWVudGluZyB0aGUgZGF0YT8g
IFBsZWFzZSBleGN1c2UgbXkgbmFpdmV0eSBhcyBJJ20gcmVsYXRpdmVseSBuZXcgdG8gdGhlIHdv
cmxkIG9mIEVCUEYuDQo+DQoNCkknbSBub3QgYXdhcmUgb2YgYW55IHN1Y2ggbGltaXRhdGlvbnMg
Zm9yIHBlcmYgcmluZyBidWZmZXIgYW5kIEkgaGF2ZW4ndCBoYWQgYSBjaGFuY2UgdG8gdmFsaWRh
dGUgdGhpcy4gSXQgd291bGQgYmUgZ3JlYXQgaWYgeW91IGNhbiBwcm92aWRlIGEgc21hbGwgcmVw
cm8gc28gdGhhdCBzb21lb25lIGNhbiB0YWtlIGEgZGVlcGVyIGxvb2ssIGl0IGRvZXMgc291bmQg
bGlrZSBhIGJ1ZywgaWYgeW91IHJlYWxseSBnZXQgY2xvYmJlcmVkIGRhdGEuIEl0IG1pZ2h0IGJl
IGFjdHVhbGx5IGhvdyB5b3Ugc2V0IHVwIHBlcmZidWYsIEFGQUlLLCBpdCBoYXMgYSBtb2RlIHdo
ZXJlIGl0IHdpbGwgb3ZlcnJpZGUgdGhlIGRhdGEsIGlmIGl0J3Mgbm90IGNvbnN1bWVkIHF1aWNr
bHkgZW5vdWdoLCBidXQgeW91IG5lZWQgdG8gY29uc2Npb3VzbHkgZW5hYmxlIHRoYXQgbW9kZS4N
Cg0KQnV0IGFwYXJ0IGZyb20gdGhhdCwgc2hhbWVsZXNzIHBsdWcgaGVyZSwgeW91IGNhbiB0cnkg
dGhlIG5ldyBCUEYgcmluZyBidWZmZXIgKFswXSksIGF2YWlsYWJsZSBpbiA1LjgrIGtlcm5lbHMu
IEl0IHdpbGwgYWxsb3cgeW91IHRvIGF2b2lkIGV4dHJhIGNvcHkgb2YgZGF0YSB5b3UgZ2V0IHdp
dGggYnBmX3BlcmZfZXZlbnRfb3V0cHV0KCksIGlmIHlvdSB1c2UgQlBGIHJpbmdidWYncyBicGZf
cmluZ2J1Zl9yZXNlcnZlKCkgKyBicGZfcmluZ2J1Zl9jb21taXQoKSBBUEkuIEl0IGFsc28gaGFz
IGJwZl9yaW5nYnVmX291dHB1dCgpIEFQSSwgd2hpY2ggaXMgbG9naWNhbGx5ICBlcXVpdmFsZW50
IHRvIGJwZl9wZXJmX2V2ZW50X291dHB1dCgpLiBBbmQgaXQgaGFzIGEgdmVyeSBoaWdoIGxpbWl0
IG9uIHNhbXBsZSBzaXplLCB1cCB0byA1MTJNQiBwZXIgc2FtcGxlLg0KDQpLZWVwIGluIG1pbmQs
IEJQRiByaW5nYnVmIGlzIE1QU0MgZGVzaWduIGFuZCBpZiB5b3UgdXNlIGp1c3Qgb25lIEJQRiBy
aW5nYnVmIGFjcm9zcyBhbGwgQ1BVcywgeW91IG1pZ2h0IHJ1biBpbnRvIHNvbWUgY29udGVudGlv
biBhY3Jvc3MgbXVsdGlwbGUgQ1BVLiBJdCBpcyBhY2NlcHRhYmxlIGluIGEgbG90IG9mIGFwcGxp
Y2F0aW9ucyBJIHdhcyB0YXJnZXRpbmcsIGJ1dCBpZiB5b3UgaGF2ZSBhIGhpZ2ggZnJlcXVlbmN5
IG9mIGV2ZW50cyAoa2VlcCBpbiBtaW5kLCB0aHJvdWdocHV0IGRvZXNuJ3QgbWF0dGVyLCBvbmx5
IGNvbnRlbnRpb24gb24gc2FtcGxlIHJlc2VydmF0aW9uIG1hdHRlcnMpLCB5b3UgbWlnaHQgd2Fu
dCB0byB1c2UgYW4gYXJyYXkgb2YgQlBGIHJpbmdidWZzIHRvIHNjYWxlIHRocm91Z2hwdXQuIFlv
dSBjYW4gZG8gMSByaW5nYnVmIHBlciBlYWNoIENQVSBmb3IgdWx0aW1hdGUgcGVyZm9ybWFuY2Ug
YXQgdGhlIGV4cGVuc2Ugb2YgbWVtb3J5IHVzYWdlICh0aGF0J3MgcGVyZiByaW5nIGJ1ZmZlciBz
ZXR1cCksIGJ1dCBCUEYgcmluZ2J1ZiBpcyBmbGV4aWJsZSBlbm91Z2ggdG8gYWxsb3cgYW55IHRv
cG9sb2d5IHRoYXQgbWFrZXMgc2Vuc2UgZm9yIHlvdSB1c2UgY2FzZSwgZnJvbSAxIHNoYXJlZCBy
aW5nYnVmIGFjcm9zcyBhbGwgQ1BVcywgdG8gYW55dGhpbmcgaW4gYmV0d2Vlbi4NCg0KDQo=

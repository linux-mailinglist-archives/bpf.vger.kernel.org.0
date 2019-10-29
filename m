Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F185CE8BAD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2019 16:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbfJ2PTu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Oct 2019 11:19:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbfJ2PTu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Oct 2019 11:19:50 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TFGwwi029895;
        Tue, 29 Oct 2019 08:19:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=PnrQLCy4DE2QCktjuQsEuLgIxGhMRlpphJ+rGqZFZPk=;
 b=jVcAe1b3rSkDSrT2zG2BH1COnJ3Qr6hYH4/wzuReYdpHZnmVuigC/Qg6mEMavMmkolYl
 6ATOzOSQR+E3OnX+NvSVoC9kJJCBoMyzXkUAbE6+yWqEPoXIi2iWTRmbAi7SicNLp7jY
 L7PQfI0qWhYNh6kFkKS7LHSrT83PCqRcWKs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vxqx100hq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Oct 2019 08:19:34 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 29 Oct 2019 08:19:33 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 29 Oct 2019 08:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVNKfLBvtBgdZXaoGion5whnEoS4DImsbkpLXD3n3ImoezvynkMaRWeWaqnV6tJy996Tq15Ytzo05tNRGE9EasJ5qj7h8moSQrNeUPLUAJNaf78hOpLWiQxO8SDi0M5htGzkC5XwbVS7NBvZhcp4Ah/3pTCM2jv9Ny7J8PYFThdNX+DIngDD4Ses5mKMQ4mfiBIWfT9gi4sAh7dmtn4OKGyfRc1rxp3H22hmuAA99qkyqIXQMAn25nHwSXX9ZfYlEZBIWliaoYzatrHPMkPJ+nRG3TB8t8q2E+5qBUr1TPMDvIuBakopy7eolbIdukSDADwKu6j4YvawAOKSUmz+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnrQLCy4DE2QCktjuQsEuLgIxGhMRlpphJ+rGqZFZPk=;
 b=URcOIZuDwstQFaXJGlHbDAgiuayt7ne2uE+e0RRNN5FoZuaQOuTTPOgdhKokKaDHEi5BC/v2JwqT+S1iq1agbKOF6oba59JKYy/kKC5+CxFYch/c8anDpasBCHMAPrwvK05b3PCM8hdVbc0+MrSakKk+E3aawVsjR7nhgBQogN9FXNvBAfGOcyydBhiiqRqaLy+rU+lRfWEawBVxOmPAtj5F4Sq4giMTwKZ1wmVdR8caA6TvwZrk94FVpuTiUH3J/cJUD8HWddC4vH+Oe/PYdvQYrt+/4Ge5A1ZaAa9QwEn0GkuFmg60IYh0nnSVAebl/z2Xmdz5Il1HyKQPgTQXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnrQLCy4DE2QCktjuQsEuLgIxGhMRlpphJ+rGqZFZPk=;
 b=Pxxuw1kXglarvdJqPoGfjC7T4K49v5GDdNTVG3cg7UzFNR/UaiWGxLPyUmuedt8gb85vDBu3LzW7dRhXReld67VOhxETH0BZ2c4Oqdzu7v4Angdm7aAEOrv6THVU+unLBmAsEaAXXoIi82bSL9ooPKC5FiLOazsMi8N6VFjE6Zw=
Received: from MWHPR15MB1375.namprd15.prod.outlook.com (10.173.233.21) by
 MWHPR15MB1503.namprd15.prod.outlook.com (10.173.234.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Tue, 29 Oct 2019 15:19:31 +0000
Received: from MWHPR15MB1375.namprd15.prod.outlook.com
 ([fe80::e917:269c:162c:2142]) by MWHPR15MB1375.namprd15.prod.outlook.com
 ([fe80::e917:269c:162c:2142%12]) with mapi id 15.20.2387.025; Tue, 29 Oct
 2019 15:19:31 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
Thread-Topic: [PATCH bpf] bpf: allow narrow loads of bpf_sysctl fields with
 offset > 0
Thread-Index: AQHVjYtVYSZ15vhmGUeukQkXXEg0BqdxvW4A
Date:   Tue, 29 Oct 2019 15:19:31 +0000
Message-ID: <20191029151930.GA84963@rdna-mbp>
References: <20191028122902.9763-1-iii@linux.ibm.com>
In-Reply-To: <20191028122902.9763-1-iii@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:301:3a::31) To MWHPR15MB1375.namprd15.prod.outlook.com
 (2603:10b6:300:ba::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::b373]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbbd40b6-8e19-4dad-e84e-08d75c83658a
x-ms-traffictypediagnostic: MWHPR15MB1503:
x-microsoft-antispam-prvs: <MWHPR15MB15036CB9BE653B116CEFF867A8610@MWHPR15MB1503.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(39860400002)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(305945005)(186003)(66476007)(66556008)(14444005)(316002)(6436002)(66946007)(66446008)(64756008)(8936002)(5024004)(4326008)(256004)(478600001)(6246003)(14454004)(71200400001)(54906003)(4001150100001)(71190400001)(25786009)(2906002)(476003)(6116002)(1076003)(8676002)(81156014)(11346002)(6512007)(46003)(86362001)(81166006)(7736002)(76176011)(386003)(52116002)(102836004)(33656002)(486006)(6916009)(446003)(99286004)(6486002)(5660300002)(33716001)(6506007)(9686003)(229853002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1503;H:MWHPR15MB1375.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGH/VtfoP1fEk8UNmmBrJixg11GmU3M81wBI1qa0iQuiBKN0PWkDZ01pPR4hl2O8sdGDRxHrrqdiOMcBSL/7NP1dn46Pehz7U367Sbj1MjrTge2CsvnxjO7e4QwWbtIjsVVT72EArdsWg6h8UrZMZ+hsnrmMQeB307e8+uCFvMDrmIZ29RmRjzbpY7s12p7cGRhygephfkja24/yu0TFXu5Pp1mMHfs6mKu0mP7tFuc7qJJOxSjQwiXTdBMArPNs5nBoNqynqtflhEF4EqvmKbd8fUUOMkq66l7Ss/TPOXMAWbg13YdmHanrPmMIjRWk1UI4R82WkCpqL/R9gKEpWPxtqmxSKYsiUYsvtrmD25kfCMRLJpPGcd4vCFN/Kors+ubZe+paayssY0ov4x+tjDMPCeGsRehFRsZsecYLe/fi7GeGQagnOFB9pGBfToqB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <01C686FD4AC89B41B1731C6B1A1A01FE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbd40b6-8e19-4dad-e84e-08d75c83658a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:19:31.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7f18f9e2j6gHc/cnAd9K2po0Z/ySPyL1DYT2nBTDnlwZDNvSBdwXKzIGemBbdlUZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290142
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+IFtNb24sIDIwMTktMTAtMjggMDU6
MjkgLTA3MDBdOg0KPiAiY3R4OmZpbGVfcG9zIHN5c2N0bDpyZWFkIHJlYWQgb2sgbmFycm93IiB3
b3JrcyBvbiBzMzkwIGJ5IGFjY2lkZW50OiBpdA0KPiByZWFkcyB0aGUgd3JvbmcgYnl0ZSwgd2hp
Y2ggaGFwcGVucyB0byBoYXZlIHRoZSBleHBlY3RlZCB2YWx1ZSBvZiAwLg0KPiBJbXByb3ZlIHRo
ZSB0ZXN0IGJ5IHNlZWtpbmcgdG8gdGhlIDR0aCBieXRlIGFuZCBleHBlY3RpbmcgNCBpbnN0ZWFk
IG9mDQo+IDAuDQo+IA0KPiBUaGlzIG1ha2VzIHRoZSBsYXRlbnQgcHJvYmxlbSBhcHBhcmVudDog
dGhlIHRlc3QgYXR0ZW1wdHMgdG8gcmVhZCB0aGUNCj4gZmlyc3QgYnl0ZSBvZiBicGZfc3lzY3Rs
LmZpbGVfcG9zLCBhc3N1bWluZyB0aGlzIGlzIHRoZSBsZWFzdC1zaWduaWZpY2FudA0KPiBieXRl
LCB3aGljaCBpcyBub3QgdGhlIGNhc2Ugb24gYmlnLWVuZGlhbiBtYWNoaW5lczogYSBub24temVy
byBvZmZzZXQgaXMNCj4gbmVlZGVkLg0KPiANCj4gVGhlIHBvaW50IG9mIHRoZSB0ZXN0IGlzIHRv
IHZlcmlmeSBuYXJyb3cgbG9hZHMsIHNvIHdlIGNhbm5vdCBjaGVhdCBvdXINCj4gd2F5IG91dCBi
eSBzaW1wbHkgdXNpbmcgQlBGX1cuIFRoZSBleGlzdGVuY2Ugb2YgdGhlIHRlc3QgbWVhbnMgdGhh
dCBzdWNoDQo+IGxvYWRzIGhhdmUgdG8gYmUgc3VwcG9ydGVkLCBtb3N0IGxpa2VseSBiZWNhdXNl
IGxsdm0gY2FuIGdlbmVyYXRlIHRoZW0uDQo+IEZpeCB0aGUgdGVzdCBieSBhZGRpbmcgYSBiaWct
ZW5kaWFuIHZhcmlhbnQsIHdoaWNoIHVzZXMgYW4gb2Zmc2V0IHRvDQo+IGFjY2VzcyB0aGUgbGVh
c3Qtc2lnbmlmaWNhbnQgYnl0ZSBvZiBicGZfc3lzY3RsLmZpbGVfcG9zLg0KPiANCj4gVGhpcyBy
ZXZlYWxzIHRoZSBmaW5hbCBwcm9ibGVtOiB2ZXJpZmllciByZWplY3RzIGFjY2Vzc2VzIHRvIGJw
Zl9zeXNjdGwNCj4gZmllbGRzIHdpdGggb2Zmc2V0ID4gMC4gU3VjaCBhY2Nlc3NlcyBhcmUgYWxy
ZWFkeSBhbGxvd2VkIGZvciBhIHdpZGUNCj4gcmFuZ2Ugb2Ygc3RydWN0czogX19za19idWZmLCBi
cGZfc29ja19hZGRyIGFuZCBza19tc2dfbWQgdG8gbmFtZSBhIGZldy4NCj4gRXh0ZW5kIHRoaXMg
c3VwcG9ydCB0byBicGZfc3lzY3RsIGJ5IHVzaW5nIGJwZl9jdHhfcmFuZ2UgaW5zdGVhZCBvZg0K
PiBvZmZzZXRvZiB3aGVuIG1hdGNoaW5nIGZpZWxkIG9mZnNldHMuDQo+IA0KPiBGaXhlczogN2Ix
NDZjZWJlMzBjICgiYnBmOiBTeXNjdGwgaG9vayIpDQo+IEZpeGVzOiBlMTU1MGJmZTBkZTQgKCJi
cGY6IEFkZCBmaWxlX3BvcyBmaWVsZCB0byBicGZfc3lzY3RsIGN0eCIpDQo+IEZpeGVzOiA5YTEw
MjdlNTI1MzUgKCJzZWxmdGVzdHMvYnBmOiBUZXN0IGZpbGVfcG9zIGZpZWxkIGluIGJwZl9zeXNj
dGwgY3R4IikNCj4gU2lnbmVkLW9mZi1ieTogSWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4Lmli
bS5jb20+DQoNClRoYW5rcyBmb3IgZm9sbG93aW5nIHVwIHdpdGggdGhlIHRlc3QgY2FzZSBhbmQg
Zm9yIHRoZSBidWdmaXggaXRzZWxmIQ0KDQpBY2tlZC1ieTogQW5kcmV5IElnbmF0b3YgPHJkbmFA
ZmIuY29tPg0KDQo+IC0tLQ0KPiAga2VybmVsL2JwZi9jZ3JvdXAuYyAgICAgICAgICAgICAgICAg
ICAgICAgfCA0ICsrLS0NCj4gIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3N5c2N0
bC5jIHwgOCArKysrKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9jZ3JvdXAuYyBiL2tl
cm5lbC9icGYvY2dyb3VwLmMNCj4gaW5kZXggZGRkOGFkZGNkYjVjLi5hM2VhZjA4ZTdkZDMgMTAw
NjQ0DQo+IC0tLSBhL2tlcm5lbC9icGYvY2dyb3VwLmMNCj4gKysrIGIva2VybmVsL2JwZi9jZ3Jv
dXAuYw0KPiBAQCAtMTMxMSwxMiArMTMxMSwxMiBAQCBzdGF0aWMgYm9vbCBzeXNjdGxfaXNfdmFs
aWRfYWNjZXNzKGludCBvZmYsIGludCBzaXplLCBlbnVtIGJwZl9hY2Nlc3NfdHlwZSB0eXBlLA0K
PiAgCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4gIAlzd2l0Y2ggKG9mZikgew0KPiAtCWNhc2Ugb2Zm
c2V0b2Yoc3RydWN0IGJwZl9zeXNjdGwsIHdyaXRlKToNCj4gKwljYXNlIGJwZl9jdHhfcmFuZ2Uo
c3RydWN0IGJwZl9zeXNjdGwsIHdyaXRlKToNCj4gIAkJaWYgKHR5cGUgIT0gQlBGX1JFQUQpDQo+
ICAJCQlyZXR1cm4gZmFsc2U7DQo+ICAJCWJwZl9jdHhfcmVjb3JkX2ZpZWxkX3NpemUoaW5mbywg
c2l6ZV9kZWZhdWx0KTsNCj4gIAkJcmV0dXJuIGJwZl9jdHhfbmFycm93X2FjY2Vzc19vayhvZmYs
IHNpemUsIHNpemVfZGVmYXVsdCk7DQo+IC0JY2FzZSBvZmZzZXRvZihzdHJ1Y3QgYnBmX3N5c2N0
bCwgZmlsZV9wb3MpOg0KPiArCWNhc2UgYnBmX2N0eF9yYW5nZShzdHJ1Y3QgYnBmX3N5c2N0bCwg
ZmlsZV9wb3MpOg0KPiAgCQlpZiAodHlwZSA9PSBCUEZfUkVBRCkgew0KPiAgCQkJYnBmX2N0eF9y
ZWNvcmRfZmllbGRfc2l6ZShpbmZvLCBzaXplX2RlZmF1bHQpOw0KPiAgCQkJcmV0dXJuIGJwZl9j
dHhfbmFycm93X2FjY2Vzc19vayhvZmYsIHNpemUsIHNpemVfZGVmYXVsdCk7DQo+IGRpZmYgLS1n
aXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9zeXNjdGwuYyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2JwZi90ZXN0X3N5c2N0bC5jDQo+IGluZGV4IGEzMjBlMzg0NGIxNy4u
N2M2ZTViMTczZjMzIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYv
dGVzdF9zeXNjdGwuYw0KPiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvdGVzdF9z
eXNjdGwuYw0KPiBAQCAtMTYxLDkgKzE2MSwxNCBAQCBzdGF0aWMgc3RydWN0IHN5c2N0bF90ZXN0
IHRlc3RzW10gPSB7DQo+ICAJCS5kZXNjciA9ICJjdHg6ZmlsZV9wb3Mgc3lzY3RsOnJlYWQgcmVh
ZCBvayBuYXJyb3ciLA0KPiAgCQkuaW5zbnMgPSB7DQo+ICAJCQkvKiBJZiAoZmlsZV9wb3MgPT0g
WCkgKi8NCj4gKyNpZiBfX0JZVEVfT1JERVIgPT0gX19MSVRUTEVfRU5ESUFODQo+ICAJCQlCUEZf
TERYX01FTShCUEZfQiwgQlBGX1JFR183LCBCUEZfUkVHXzEsDQo+ICAJCQkJICAgIG9mZnNldG9m
KHN0cnVjdCBicGZfc3lzY3RsLCBmaWxlX3BvcykpLA0KPiAtCQkJQlBGX0pNUF9JTU0oQlBGX0pO
RSwgQlBGX1JFR183LCAwLCAyKSwNCj4gKyNlbHNlDQo+ICsJCQlCUEZfTERYX01FTShCUEZfQiwg
QlBGX1JFR183LCBCUEZfUkVHXzEsDQo+ICsJCQkJICAgIG9mZnNldG9mKHN0cnVjdCBicGZfc3lz
Y3RsLCBmaWxlX3BvcykgKyAzKSwNCj4gKyNlbmRpZg0KPiArCQkJQlBGX0pNUF9JTU0oQlBGX0pO
RSwgQlBGX1JFR183LCA0LCAyKSwNCj4gIA0KPiAgCQkJLyogcmV0dXJuIEFMTE9XOyAqLw0KPiAg
CQkJQlBGX01PVjY0X0lNTShCUEZfUkVHXzAsIDEpLA0KPiBAQCAtMTc2LDYgKzE4MSw3IEBAIHN0
YXRpYyBzdHJ1Y3Qgc3lzY3RsX3Rlc3QgdGVzdHNbXSA9IHsNCj4gIAkJLmF0dGFjaF90eXBlID0g
QlBGX0NHUk9VUF9TWVNDVEwsDQo+ICAJCS5zeXNjdGwgPSAia2VybmVsL29zdHlwZSIsDQo+ICAJ
CS5vcGVuX2ZsYWdzID0gT19SRE9OTFksDQo+ICsJCS5zZWVrID0gNCwNCj4gIAkJLnJlc3VsdCA9
IFNVQ0NFU1MsDQo+ICAJfSwNCj4gIAl7DQo+IC0tIA0KPiAyLjIzLjANCj4gDQoNCi0tIA0KQW5k
cmV5IElnbmF0b3YNCg==

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D53ABB2D73
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2019 02:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfIOAeX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Sep 2019 20:34:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52566 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfIOAeW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Sep 2019 20:34:22 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8F0S8dn017033;
        Sat, 14 Sep 2019 17:33:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=n/IX4E51JRMLg73DXutECP6HD8hjiBKq6IC8y4NliKk=;
 b=ixun8VSCA4ETHrwKrUiLYm2USZoNvFXyB9VarpUcJA1HcVAIA7xdguZz+mFql+lu/hjN
 Dd1ImVNwikfHLvK7YL2abXu4cFDfxqPPz9tVUeujYd4XEgviiBpd+hGZKS6dbnbD0aGv
 aXdPWCkqNnITGmZvTn+EopShlEbQnoJ74y8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v0ygv1npx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 14 Sep 2019 17:33:44 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 14 Sep 2019 17:33:42 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 14 Sep 2019 17:33:42 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 14 Sep 2019 17:33:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVDo9zvYwMMEZu+LSbA+PepjPcTwEx6Qgr5HmgW5wxf2uJqlwOspp6uJ9m1cnocoqMZaB8ZWswfzjlTxPPtkO8ji9V58rD4VJd0EJU1+S1J9CV1T8vHYQgRILyJ1+zPdBr6sIjxgbqiJ1jtPaIHN167+x6EPnYFu9sHwBGHaKkRWpDCMan7DvfCRHSYvjYrF4BVpmIXG8wHRXmcDyTLk1d256icrHRJmVtnv8kEtRANrz6X1ZH3wqFhFZdzvdzztfU0e0Jot8EJ1uKN9OIbI/mSlbI9PHJ+cbzmdWGEzJihc/bVvJBLfxY4c6HVvdvGwWdp6WTLtQJoL9I56+PX8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/IX4E51JRMLg73DXutECP6HD8hjiBKq6IC8y4NliKk=;
 b=DS8bqNPeUwqKseYUiDlR8MfsDtqSLOoqzehZFcWd7zogmXzIv+WHaVHKce9c9GtVb73uWRDNQZAb5DbItiXEeN60AxjEbPiZBOxGHbIJls1NJbitQSaIaUD63klkA7wz646+BeBPs3SxwkrbXZ8emY4smsrYbP6o7wQieTqKEklJ72I+P7zqhlq1R3Wn0PpVJVuHQuV2vTo7Vf70OhIgVA2VGfc/x2exrJoqjeU6feHVoIVB2PRxjWzIDVYhxnorMVjxQWMeer8hPKBDjelT17YuT5gnGpUXUsYUHL4JanTxm53j6klWzPvfdbdWUEQEG5pKYy+bVLbXoN1tSfGiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/IX4E51JRMLg73DXutECP6HD8hjiBKq6IC8y4NliKk=;
 b=TWytUEYaencUPKNy0o/L60CGPXVRIlmYEqhBQ7ZoQpIJW62Faguw72/t3ixjzu6cEInUT6gYXztMOi/IMSlgiKJ8QwBe4gawNgA6LQ+Q/RrSI0SoWDPK8/0m2VMlAunBrAO2m1eETF2yHxOSy9NuhYEuIOG69Op4pAPEMUk1fCs=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYASPR01MB0052.namprd15.prod.outlook.com (20.178.206.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Sun, 15 Sep 2019 00:33:41 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2263.021; Sun, 15 Sep 2019
 00:33:41 +0000
From:   Yonghong Song <yhs@fb.com>
To:     KP Singh <kpsingh@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        "Michael Halcrow" <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "Andrey Ignatov" <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [RFC v1 14/14] krsi: Pin arg pages only when needed
Thread-Topic: [RFC v1 14/14] krsi: Pin arg pages only when needed
Thread-Index: AQHVZ87hbuOgQ0AyT0uRpdYgTl4mM6cr6s4A
Date:   Sun, 15 Sep 2019 00:33:41 +0000
Message-ID: <d9b7b968-c3a7-48a4-2eb0-85d5ac9dd196@fb.com>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-15-kpsingh@chromium.org>
In-Reply-To: <20190910115527.5235-15-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:104:6::31) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::69e8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c874f94-b8ad-4c20-c243-08d739745b5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYASPR01MB0052;
x-ms-traffictypediagnostic: BYASPR01MB0052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYASPR01MB0052D96C11B1CC66CA5C4708D38D0@BYASPR01MB0052.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01613DFDC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(31686004)(99286004)(6246003)(52116002)(102836004)(6506007)(76176011)(2906002)(386003)(53546011)(25786009)(478600001)(5024004)(36756003)(14454004)(5660300002)(256004)(66946007)(4326008)(14444005)(53936002)(66446008)(66476007)(66556008)(64756008)(6512007)(81156014)(6116002)(8936002)(8676002)(110136005)(54906003)(31696002)(229853002)(476003)(2616005)(71200400001)(46003)(486006)(86362001)(6436002)(186003)(2201001)(81166006)(446003)(11346002)(6486002)(71190400001)(305945005)(2501003)(7416002)(7736002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYASPR01MB0052;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CpDNCRxDye555YULnQfOLIe4dk6bLFLUQ4uJRAZKnOmsT7ySckFSkszbpSb6QYyeJNbE6QF3pOOPY3gcOxzUwj1eRQGspQHHzjiiM28yaqoLprjyKCatD8YWC+LJ52v+QoRVy/V26eUEXAXgrTIbITbc3Nd70WKDw89KeM+YLp6mniEwQ5oY9dqIhuT32tOYRXpZ367Weo3vqJMRjqPQ4Jvt3/2Su9nbR2dhKj98xe4k3K1Gq6KS8hbP1obB8VnWus2C67d2+oUIWbUG7ww+dLhR4ekaPoYu8ghxChtR2Uvmr57NboyFbk3wKIEuMOJ+Z6KUOMelX16P33ufWmhYh7FtgWIsFEF30lGZ+oftzOlmzGOXKNxVwUTx9Jd/I0Uop795mXzwNLfjGDtoOw4EaJ7aAstZj1W8x4tgPyxKbAQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5324BC150B332A468D7198AFAC5C29DD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c874f94-b8ad-4c20-c243-08d739745b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2019 00:33:41.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmKk1o6hEnycuv4OjvZL4LSrP++YEagHV7BYcW8EHMcMYX7s+iOORQnBRgxirK/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0052
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-14_07:2019-09-11,2019-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909150002
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDkvMTAvMTkgMTI6NTUgUE0sIEtQIFNpbmdoIHdyb3RlOg0KPiBGcm9tOiBLUCBTaW5n
aCA8a3BzaW5naEBnb29nbGUuY29tPg0KPiANCj4gQWRkcyBhIGNhbGxiYWNrIHdoaWNoIGlzIGNh
bGxlZCB3aGVuIGEgbmV3IHByb2dyYW0gaXMgYXR0YWNoZWQNCj4gdG8gYSBob29rLiBUaGUgY2Fs
bGJhY2sgcmVnaXN0ZXJlZCBieSB0aGUgcHJvY2Vzc19leGVjdGlvbiBob29rDQo+IGNoZWNrcyBp
ZiBhIHByb2dyYW0gdGhhdCBoYXMgY2FsbHMgdG8gYSBoZWxwZXIgdGhhdCByZXF1aXJlcyBwYWdl
cyB0bw0KPiBiZSBwaW5uZWQgKGVnLiBrcnNpX2dldF9lbnZfdmFyKS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEtQIFNpbmdoIDxrcHNpbmdoQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUv
bGludXgva3JzaS5oICAgICAgICAgICAgICB8ICAxICsNCj4gICBzZWN1cml0eS9rcnNpL2luY2x1
ZGUvaG9va3MuaCAgICAgfCAgNSArKy0NCj4gICBzZWN1cml0eS9rcnNpL2luY2x1ZGUva3JzaV9p
bml0LmggfCAgNyArKysrDQo+ICAgc2VjdXJpdHkva3JzaS9rcnNpLmMgICAgICAgICAgICAgIHwg
NjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgIHNlY3VyaXR5L2tyc2kvb3Bz
LmMgICAgICAgICAgICAgICB8IDEwICsrKystDQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCA3NyBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgva3JzaS5oIGIvaW5jbHVkZS9saW51eC9rcnNpLmgNCj4gaW5kZXggYzdkMTc5MGQwYzFmLi5l
NDQzZDAzMDk3NjQgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgva3JzaS5oDQo+ICsrKyBi
L2luY2x1ZGUvbGludXgva3JzaS5oDQo+IEBAIC03LDYgKzcsNyBAQA0KPiAgIA0KPiAgICNpZmRl
ZiBDT05GSUdfU0VDVVJJVFlfS1JTSQ0KPiAgIGludCBrcnNpX3Byb2dfYXR0YWNoKGNvbnN0IHVu
aW9uIGJwZl9hdHRyICphdHRyLCBzdHJ1Y3QgYnBmX3Byb2cgKnByb2cpOw0KPiArZXh0ZXJuIGNv
bnN0IHN0cnVjdCBicGZfZnVuY19wcm90byBrcnNpX2dldF9lbnZfdmFyX3Byb3RvOw0KPiAgICNl
bHNlDQo+ICAgc3RhdGljIGlubGluZSBpbnQga3JzaV9wcm9nX2F0dGFjaChjb25zdCB1bmlvbiBi
cGZfYXR0ciAqYXR0ciwNCj4gICAJCQkJICAgc3RydWN0IGJwZl9wcm9nICpwcm9nKQ0KPiBkaWZm
IC0tZ2l0IGEvc2VjdXJpdHkva3JzaS9pbmNsdWRlL2hvb2tzLmggYi9zZWN1cml0eS9rcnNpL2lu
Y2x1ZGUvaG9va3MuaA0KPiBpbmRleCBlMDcwYzQ1MmI1ZGUuLjM4MjkzMTI1ZmY5OSAxMDA2NDQN
Cj4gLS0tIGEvc2VjdXJpdHkva3JzaS9pbmNsdWRlL2hvb2tzLmgNCj4gKysrIGIvc2VjdXJpdHkv
a3JzaS9pbmNsdWRlL2hvb2tzLmgNCj4gQEAgLTgsNyArOCw3IEBADQo+ICAgICoNCj4gICAgKiBG
b3JtYXQ6DQo+ICAgICoNCj4gLSAqICAgS1JTSV9IT09LX0lOSVQoVFlQRSwgTkFNRSwgTFNNX0hP
T0ssIEtSU0lfSE9PS19GTikNCj4gKyAqICAgS1JTSV9IT09LX0lOSVQoVFlQRSwgTkFNRSwgTFNN
X0hPT0ssIEtSU0lfSE9PS19GTiwgQ0FMTEJBQ0spDQo+ICAgICoNCj4gICAgKiBLUlNJIGFkZHMg
b25lIGxheWVyIG9mIGluZGlyZWN0aW9uIGJldHdlZW4gdGhlIG5hbWUgb2YgdGhlIGhvb2sgYW5k
IHRoZSBuYW1lDQo+ICAgICogaXQgZXhwb3NlcyB0byB0aGUgdXNlcnNwYWNlIGluIFNlY3VyaXR5
IEZTIHRvIHByZXZlbnQgdGhlIHVzZXJzcGFjZSBmcm9tDQo+IEBAIC0xOCw0ICsxOCw1IEBADQo+
ICAgS1JTSV9IT09LX0lOSVQoUFJPQ0VTU19FWEVDVVRJT04sDQo+ICAgCSAgICAgICBwcm9jZXNz
X2V4ZWN1dGlvbiwNCj4gICAJICAgICAgIGJwcm1fY2hlY2tfc2VjdXJpdHksDQo+IC0JICAgICAg
IGtyc2lfcHJvY2Vzc19leGVjdXRpb24pDQo+ICsJICAgICAgIGtyc2lfcHJvY2Vzc19leGVjdXRp
b24sDQo+ICsJICAgICAgIGtyc2lfcHJvY2Vzc19leGVjdXRpb25fY2IpDQo+IGRpZmYgLS1naXQg
YS9zZWN1cml0eS9rcnNpL2luY2x1ZGUva3JzaV9pbml0LmggYi9zZWN1cml0eS9rcnNpL2luY2x1
ZGUva3JzaV9pbml0LmgNCj4gaW5kZXggNjE1Mjg0N2MzYjA4Li45OTgwMWQ1YjI3M2EgMTAwNjQ0
DQo+IC0tLSBhL3NlY3VyaXR5L2tyc2kvaW5jbHVkZS9rcnNpX2luaXQuaA0KPiArKysgYi9zZWN1
cml0eS9rcnNpL2luY2x1ZGUva3JzaV9pbml0LmgNCj4gQEAgLTMxLDYgKzMxLDggQEAgc3RydWN0
IGtyc2lfY3R4IHsNCj4gICAJfTsNCj4gICB9Ow0KPiAgIA0KPiArdHlwZWRlZiBpbnQgKCprcnNp
X3Byb2dfYXR0YWNoX3QpIChzdHJ1Y3QgYnBmX3Byb2dfYXJyYXkgKik7DQo+ICsNCj4gICAvKg0K
PiAgICAqIFRoZSBMU00gY3JlYXRlcyBvbmUgZmlsZSBwZXIgaG9vay4NCj4gICAgKg0KPiBAQCAt
NjEsNiArNjMsMTEgQEAgc3RydWN0IGtyc2lfaG9vayB7DQo+ICAgCSAqIFRoZSBlQlBGIHByb2dy
YW1zIHRoYXQgYXJlIGF0dGFjaGVkIHRvIHRoaXMgaG9vay4NCj4gICAJICovDQo+ICAgCXN0cnVj
dCBicGZfcHJvZ19hcnJheSBfX3JjdQkqcHJvZ3M7DQo+ICsJLyoNCj4gKwkgKiBUaGUgYXR0YWNo
IGNhbGxiYWNrIGlzIGNhbGxlZCBiZWZvcmUgYSBuZXcgcHJvZ3JhbSBpcyBhdHRhY2hlZA0KPiAr
CSAqIHRvIHRoZSBob29rIGFuZCBpcyBwYXNzZWQgdGhlIHVwZGF0ZWQgYnBmX3Byb2dfYXJyYXkg
YXMgYW4gYXJndW1lbnQuDQo+ICsJICovDQo+ICsJa3JzaV9wcm9nX2F0dGFjaF90IGF0dGFjaF9j
YWxsYmFjazsNCj4gICB9Ow0KPiAgIA0KPiAgIGV4dGVybiBzdHJ1Y3Qga3JzaV9ob29rIGtyc2lf
aG9va3NfbGlzdFtdOw0KPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkva3JzaS9rcnNpLmMgYi9zZWN1
cml0eS9rcnNpL2tyc2kuYw0KPiBpbmRleCAwMGE3MTUwYzFiMjIuLmE0NDQzZDdhYTE1MCAxMDA2
NDQNCj4gLS0tIGEvc2VjdXJpdHkva3JzaS9rcnNpLmMNCj4gKysrIGIvc2VjdXJpdHkva3JzaS9r
cnNpLmMNCj4gQEAgLTUsMTUgKzUsNjUgQEANCj4gICAjaW5jbHVkZSA8bGludXgvYnBmLmg+DQo+
ICAgI2luY2x1ZGUgPGxpbnV4L2JpbmZtdHMuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvaGlnaG1l
bS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2tyc2kuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvbW0u
aD4NCj4gICANCj4gICAjaW5jbHVkZSAia3JzaV9pbml0LmgiDQo+ICAgDQo+ICsvKg0KPiArICog
bmVlZF9hcmdfcGFnZXMgaXMgb25seSB1cGRhdGVkIGluIGJwcm1fY2hlY2tfc2VjdXJpdHlfY2IN
Cj4gKyAqIHdoZW4gYSBtdXRleCBvbiBrcnNpX2hvb2sgZm9yIGJwcm1fY2hlY2tfc2VjdXJpdHkg
aXMgYWxyZWFkeQ0KPiArICogaGVsZC4gbmVlZF9hcmdfcGFnZXMgYXZvaWRzIHBpbm5pbmcgcGFn
ZXMgd2hlbiBubyBwcm9ncmFtDQo+ICsgKiB0aGF0IG5lZWRzIHRoZW0gaXMgYXR0YWNoZWQgdG8g
dGhlIGhvb2suDQo+ICsgKi8NCj4gK3N0YXRpYyBib29sIG5lZWRfYXJnX3BhZ2VzOw0KPiArDQo+
ICsvKg0KPiArICogQ2hlY2tzIGlmIHRoZSBpbnN0cnVjdGlvbiBpcyBhIEJQRl9DQUxMIHRvIGFu
IGVCUEYgaGVscGVyIGxvY2F0ZWQNCj4gKyAqIGF0IHRoZSBnaXZlbiBhZGRyZXNzLg0KPiArICov
DQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgYnBmX2lzX2NhbGxfdG9fZnVuYyhzdHJ1Y3QgYnBmX2lu
c24gKmluc24sDQo+ICsJCQkJICAgICAgIHZvaWQgKmZ1bmNfYWRkcikNCj4gK3sNCj4gKwl1OCBv
cGNvZGUgPSBCUEZfT1AoaW5zbi0+Y29kZSk7DQo+ICsNCj4gKwlpZiAob3Bjb2RlICE9IEJQRl9D
QUxMKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwlpZiAoaW5zbi0+c3JjX3JlZyA9PSBC
UEZfUFNFVURPX0NBTEwpDQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKw0KPiArCS8qDQo+ICsJICog
VGhlIEJQRiB2ZXJpZmllciB1cGRhdGVzIHRoZSB2YWx1ZSBvZiBpbnNuLT5pbW0gZnJvbSB0aGUN
Cj4gKwkgKiBlbnVtIGJwZl9mdW5jX2lkIHRvIHRoZSBvZmZzZXQgb2YgdGhlIGFkZHJlc3Mgb2Yg
aGVscGVyDQo+ICsJICogZnJvbSB0aGUgX19icGZfY2FsbF9iYXNlLg0KPiArCSAqLw0KPiArCXJl
dHVybiBfX2JwZl9jYWxsX2Jhc2UgKyBpbnNuLT5pbW0gPT0gZnVuY19hZGRyOw0KDQpJbiBob3cg
bWFueSBjYXNlcywga3JzaSBwcm9ncmFtIGRvZXMgbm90IGhhdmUga3JzaV9nZXRfZW52X3Zhcigp
IGhlbHBlcj8NCg0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGtyc2lfcHJvY2Vzc19leGVjdXRp
b25fY2Ioc3RydWN0IGJwZl9wcm9nX2FycmF5ICphcnJheSkNCj4gK3sNCj4gKwlzdHJ1Y3QgYnBm
X3Byb2dfYXJyYXlfaXRlbSAqaXRlbSA9IGFycmF5LT5pdGVtczsNCj4gKwlzdHJ1Y3QgYnBmX3By
b2cgKnA7DQo+ICsJY29uc3Qgc3RydWN0IGJwZl9mdW5jX3Byb3RvICpwcm90byA9ICZrcnNpX2dl
dF9lbnZfdmFyX3Byb3RvOw0KPiArCWludCBpOw0KPiArDQo+ICsJd2hpbGUgKChwID0gUkVBRF9P
TkNFKGl0ZW0tPnByb2cpKSkgew0KPiArCQlmb3IgKGkgPSAwOyBpIDwgcC0+bGVuOyBpKyspIHsN
Cj4gKwkJCWlmIChicGZfaXNfY2FsbF90b19mdW5jKCZwLT5pbnNuc2lbaV0sIHByb3RvLT5mdW5j
KSkNCj4gKwkJCQluZWVkX2FyZ19wYWdlcyA9IHRydWU7DQo+ICsJCX0NCj4gKwkJaXRlbSsrOw0K
PiArCX0NCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgIHN0cnVjdCBrcnNpX2hvb2sga3Jz
aV9ob29rc19saXN0W10gPSB7DQo+IC0JI2RlZmluZSBLUlNJX0hPT0tfSU5JVChUWVBFLCBOQU1F
LCBILCBJKSBcDQo+ICsJI2RlZmluZSBLUlNJX0hPT0tfSU5JVChUWVBFLCBOQU1FLCBILCBJLCBD
QikgXA0KPiAgIAkJW1RZUEVdID0geyBcDQo+ICAgCQkJLmhfdHlwZSA9IFRZUEUsIFwNCj4gICAJ
CQkubmFtZSA9ICNOQU1FLCBcDQo+ICsJCQkuYXR0YWNoX2NhbGxiYWNrID0gQ0IsIFwNCj4gICAJ
CX0sDQo+ICAgCSNpbmNsdWRlICJob29rcy5oIg0KPiAgIAkjdW5kZWYgS1JTSV9IT09LX0lOSVQN
Cj4gQEAgLTc1LDkgKzEyNSwxMSBAQCBzdGF0aWMgaW50IGtyc2lfcHJvY2Vzc19leGVjdXRpb24o
c3RydWN0IGxpbnV4X2JpbnBybSAqYnBybSkNCj4gICAJCS5icHJtID0gYnBybSwNCj4gICAJfTsN
Cj4gICANCj4gLQlyZXQgPSBwaW5fYXJnX3BhZ2VzKCZjdHguYnBybV9jdHgpOw0KPiAtCWlmIChy
ZXQgPCAwKQ0KPiAtCQlnb3RvIG91dF9hcmdfcGFnZXM7DQo+ICsJaWYgKFJFQURfT05DRShuZWVk
X2FyZ19wYWdlcykpIHsNCj4gKwkJcmV0ID0gcGluX2FyZ19wYWdlcygmY3R4LmJwcm1fY3R4KTsN
Cj4gKwkJaWYgKHJldCA8IDApDQo+ICsJCQlnb3RvIG91dF9hcmdfcGFnZXM7DQo+ICsJfQ0KPiAg
IA0KPiAgIAlyZXQgPSBrcnNpX3J1bl9wcm9ncyhQUk9DRVNTX0VYRUNVVElPTiwgJmN0eCk7DQo+
ICAgCWtmcmVlKGN0eC5icHJtX2N0eC5hcmdfcGFnZXMpOw0KPiBAQCAtODcsNyArMTM5LDcgQEAg
c3RhdGljIGludCBrcnNpX3Byb2Nlc3NfZXhlY3V0aW9uKHN0cnVjdCBsaW51eF9iaW5wcm0gKmJw
cm0pDQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBzdHJ1Y3Qgc2VjdXJpdHlfaG9va19saXN0IGty
c2lfaG9va3NbXSBfX2xzbV9yb19hZnRlcl9pbml0ID0gew0KPiAtCSNkZWZpbmUgS1JTSV9IT09L
X0lOSVQoVCwgTiwgSE9PSywgSU1QTCkgTFNNX0hPT0tfSU5JVChIT09LLCBJTVBMKSwNCj4gKwkj
ZGVmaW5lIEtSU0lfSE9PS19JTklUKFQsIE4sIEhPT0ssIElNUEwsIENCKSBMU01fSE9PS19JTklU
KEhPT0ssIElNUEwpLA0KPiAgIAkjaW5jbHVkZSAiaG9va3MuaCINCj4gICAJI3VuZGVmIEtSU0lf
SE9PS19JTklUDQo+ICAgfTsNCj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2tyc2kvb3BzLmMgYi9z
ZWN1cml0eS9rcnNpL29wcy5jDQo+IGluZGV4IDFkYjk0ZGZhYWMxNS4uMmRlNjgyMzcxZWZmIDEw
MDY0NA0KPiAtLS0gYS9zZWN1cml0eS9rcnNpL29wcy5jDQo+ICsrKyBiL3NlY3VyaXR5L2tyc2kv
b3BzLmMNCj4gQEAgLTEzOSw2ICsxMzksMTQgQEAgaW50IGtyc2lfcHJvZ19hdHRhY2goY29uc3Qg
dW5pb24gYnBmX2F0dHIgKmF0dHIsIHN0cnVjdCBicGZfcHJvZyAqcHJvZykNCj4gICAJCWdvdG8g
dW5sb2NrOw0KPiAgIAl9DQo+ICAgDQo+ICsJaWYgKGgtPmF0dGFjaF9jYWxsYmFjaykgew0KPiAr
CQlyZXQgPSBoLT5hdHRhY2hfY2FsbGJhY2sobmV3X2FycmF5KTsNCj4gKwkJaWYgKHJldCA8IDAp
IHsNCj4gKwkJCWJwZl9wcm9nX2FycmF5X2ZyZWUobmV3X2FycmF5KTsNCj4gKwkJCWdvdG8gdW5s
b2NrOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICAgCXJjdV9hc3NpZ25fcG9pbnRlcihoLT5wcm9n
cywgbmV3X2FycmF5KTsNCj4gICAJYnBmX3Byb2dfYXJyYXlfZnJlZShvbGRfYXJyYXkpOw0KPiAg
IA0KPiBAQCAtMjc4LDcgKzI4Niw3IEBAIEJQRl9DQUxMXzUoa3JzaV9nZXRfZW52X3Zhciwgc3Ry
dWN0IGtyc2lfY3R4ICosIGN0eCwgY2hhciAqLCBuYW1lLCB1MzIsIG5fc2l6ZSwNCj4gICAJcmV0
dXJuIGdldF9lbnZfdmFyKGN0eCwgbmFtZSwgZGVzdCwgbl9zaXplLCBzaXplKTsNCj4gICB9DQo+
ICAgDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGJwZl9mdW5jX3Byb3RvIGtyc2lfZ2V0X2Vudl92
YXJfcHJvdG8gPSB7DQo+ICtjb25zdCBzdHJ1Y3QgYnBmX2Z1bmNfcHJvdG8ga3JzaV9nZXRfZW52
X3Zhcl9wcm90byA9IHsNCj4gICAJLmZ1bmMgPSBrcnNpX2dldF9lbnZfdmFyLA0KPiAgIAkuZ3Bs
X29ubHkgPSB0cnVlLA0KPiAgIAkucmV0X3R5cGUgPSBSRVRfSU5URUdFUiwNCj4gDQo=

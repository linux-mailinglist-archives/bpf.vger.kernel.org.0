Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03CDB2D75
	for <lists+bpf@lfdr.de>; Sun, 15 Sep 2019 02:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfIOAi0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Sep 2019 20:38:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50768 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbfIOAi0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Sep 2019 20:38:26 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8F0ZE8r015066;
        Sat, 14 Sep 2019 17:38:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=AZHntNs1Ka+XNc4dKFHkFLet0QX/dlcmtsA+NQ96gEI=;
 b=djpE5fJhacFxYhiAWXxVUKLDPuh2r+YEOaF3dTHM8f7Gbwe7rAmujRMZrKNfOstEfEB3
 q25cyujfpxGKlrqsOVUBWIb4Wz3ls623Z44i8Cf4FHhkIcIYqBrATsfc46ZdV0s6eEfn
 X4HpOYCTjGCSiXWc4MhdLiSCEWbJMt2aTDc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v0wwb1vaw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 14 Sep 2019 17:38:00 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 14 Sep 2019 17:37:31 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 14 Sep 2019 17:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlVQwahAccXdmtr2WfSlC9JiiSzcOYYjJSt8flk4+oEq+23dS/YUzmYpfP92mjduT/TC/eqmFTL5YgZ0DPt05LCZS/kbXVAqnl1vPMra12haZ5xRnAzfbLNLBEYE+zVzst84V7W01ZJK4fDoGMIihdKhc3i8NCXFmODmwsxI8TSsZOJUVNSJXLNAd5pODtVQTOc8qzLvTJDS3I4wZJDcsK/3InEEpNkcusLdG4VCOMPvJRkXIkR2JXUnheD41UCr3EKEomYZBmA2BpEbnmWuUzfMBti6QYTRvrNlz394PV3wFzUnnZ3fXqzRKq7EeeGT8ZsUuWYIRjJPdbyL3+8Iew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZHntNs1Ka+XNc4dKFHkFLet0QX/dlcmtsA+NQ96gEI=;
 b=blRUKM0I7av82eMZ68Ht6fgJY/73iMWnOXYjiLE6VTBBSnG2GQnlurLe7y46tVhXkcZJxI5q6ftgY/CnD5PvtHVFXiurKJ35PMPQYFawJWu1oL2GOdGLKeQiuej93A2diiL9+Mzcqi9kvdzfSu890e41ia3OST0W92rWiCCh+rQT7TayDy7mrvqA5Tkw3uiNGSmeNg0N0b5yrYsgualGBCxn6W6t7UrsSFS6M3W6ZtqXqNwqLSpdELqhMFAsiiprteWhFqyWArK8LHuBD0B8hrfMm2L4nWaxFvhDpZ4vLs5RfHWNz0y2gHpMnH/hJEeDFOH1nN8Zop4SIHTY57uv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZHntNs1Ka+XNc4dKFHkFLet0QX/dlcmtsA+NQ96gEI=;
 b=SZW8qyeU414TEfITypB2TQo8X2nNCKL4hcQNEeF7HZF/wDAhp9rU+2U5WjVjEloE/hbxEnaxvt1Wj90c2nVAPESeW1OSiD2l7ZAe7KkwlKjBL3beqjD0gygfBZLLJ0QW4uXzryggf1itr47/cuT5SMgMp9iWV3ZcCtFqXcP1+Os=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYASPR01MB0052.namprd15.prod.outlook.com (20.178.206.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Sun, 15 Sep 2019 00:37:30 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2263.021; Sun, 15 Sep 2019
 00:37:29 +0000
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
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, "Joe Stringer" <joe@wand.net.nz>
Subject: Re: Re: [RFC v1 06/14] krsi: Implement eBPF operations, attachment
 and execution
Thread-Topic: Re: [RFC v1 06/14] krsi: Implement eBPF operations, attachment
 and execution
Thread-Index: AQHVZ87TGQ2rzc/y1EW6zOg/S4OXiacq9dGAgAD2DoA=
Date:   Sun, 15 Sep 2019 00:37:29 +0000
Message-ID: <f2732b46-d4d1-c811-dd6b-ad0ef280513f@fb.com>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-7-kpsingh@chromium.org>
 <bb2d4453-f01f-8fb2-d901-a7a0a5eb4a4d@fb.com>
In-Reply-To: <bb2d4453-f01f-8fb2-d901-a7a0a5eb4a4d@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0014.namprd22.prod.outlook.com
 (2603:10b6:301:28::27) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::65fb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b06741e-8155-4a65-f0b0-08d73974e386
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYASPR01MB0052;
x-ms-traffictypediagnostic: BYASPR01MB0052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYASPR01MB0052B403FB098929B78E627DD38D0@BYASPR01MB0052.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01613DFDC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(31686004)(99286004)(6246003)(52116002)(102836004)(6506007)(76176011)(2906002)(386003)(53546011)(25786009)(478600001)(5024004)(36756003)(14454004)(5660300002)(256004)(66946007)(4326008)(14444005)(53936002)(66446008)(66476007)(66556008)(64756008)(6512007)(81156014)(6116002)(8936002)(8676002)(110136005)(54906003)(31696002)(229853002)(476003)(2616005)(71200400001)(46003)(486006)(86362001)(6436002)(186003)(2201001)(81166006)(446003)(11346002)(6486002)(71190400001)(305945005)(2501003)(7416002)(7736002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYASPR01MB0052;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2LcB5DKBBT81YlJABhELa0sMIJnuhf9GAvGiVn0e0sOyUT7iWgwYG1hHrOe3K9oHiXfa5PMSEQ16xdPtfxn9cfrlijBEI+v9dX23t2CJcx788OOv/eVo3im3Bl8Hsy0l4aHU14rOaDZY2HBAoBNBRHhjGf+jUqKoGs5Q9347kMgsqOgntZin0k/I65uYPBtP1qsyMV3qWWn/+WRfcQZcdMxRLaqkirNurPggWvqE0IyM8G/hNJ+zlNqWdkMTPSvJR8yAGYEruS0rs58HUaj6wZRve6fU8qS9sjh3MpE/z+VkDP65Px6ghBycxYnQBzafO+26+DOLM/KhzRptTM2Y7kVcmSKzmSIIhn5M/YMV3nXaZ0TonxFNvKFJY6x/Fhr+o0uVe72uK653G4Fi7brK+lt+EtfEyAMUbr/2QZnQwcs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <407AB75E52F631499C4B693B6709784A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b06741e-8155-4a65-f0b0-08d73974e386
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2019 00:37:29.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xyDuC+OjuTm9Z3wZz62N+SKzjEi6k4rxCF7xl6P7BPHMjwn54JGAhqCHCFHBDMmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0052
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-14_07:2019-09-11,2019-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909150003
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDkvMTQvMTkgNTo1NiBQTSwgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4gDQo+IA0KPiBP
biA5LzEwLzE5IDEyOjU1IFBNLCBLUCBTaW5naCB3cm90ZToNCj4+IEZyb206IEtQIFNpbmdoIDxr
cHNpbmdoQGdvb2dsZS5jb20+DQo+Pg0KPj4gQSB1c2VyIHNwYWNlIHByb2dyYW0gY2FuIGF0dGFj
aCBhbiBlQlBGIHByb2dyYW0gYnk6DQo+Pg0KPj4gICAgIGhvb2tfZmQgPSBvcGVuKCIvc3lzL2tl
cm5lbC9zZWN1cml0eS9rcnNpL3Byb2Nlc3NfZXhlY3V0aW9uIiwgT19SRFdSKQ0KPj4gICAgIHBy
b2dfZmQgPSBicGYoQlBGX1BST0dfTE9BRCwgLi4uKQ0KPj4gICAgIGJwZihCUEZfUFJPR19BVFRB
Q0gsIGhvb2tfZmQsIHByb2dfZmQpDQo+Pg0KPj4gV2hlbiBzdWNoIGFuIGF0dGFjaCBjYWxsIGlz
IHJlY2VpdmVkLCB0aGUgYXR0YWNobWVudCBsb2dpYyBsb29rcyB1cCB0aGUNCj4+IGRlbnRyeSBh
bmQgYXBwZW5kcyB0aGUgcHJvZ3JhbSB0byB0aGUgYnBmX3Byb2dfYXJyYXkuDQo+Pg0KPj4gVGhl
IEJQRiBwcm9ncmFtcyBhcmUgc3RvcmVkIGluIGEgYnBmX3Byb2dfYXJyYXkgYW5kIHdyaXRlcyB0
byB0aGUgYXJyYXkNCj4+IGFyZSBndWFyZGVkIGJ5IGEgbXV0ZXguIFRoZSBlQlBGIHByb2dyYW1z
IGFyZSBleGVjdXRlZCBhcyBhIHBhcnQgb2YgdGhlDQo+PiBMU00gaG9vayB0aGV5IGFyZSBhdHRh
Y2hlZCB0by4gSWYgYW55IG9mIHRoZSBlQlBGIHByb2dyYW1zIHJldHVybg0KPj4gYW4gZXJyb3Ig
KC1FTk9QRVJNKSB0aGUgYWN0aW9uIHJlcHJlc2VudGVkIGJ5IHRoZSBob29rIGlzIGRlbmllZC4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBLUCBTaW5naCA8a3BzaW5naEBnb29nbGUuY29tPg0KPj4g
LS0tDQo+PiAgICBpbmNsdWRlL2xpbnV4L2tyc2kuaCAgICAgICAgICAgICAgfCAgMTggKysrKysr
DQo+PiAgICBrZXJuZWwvYnBmL3N5c2NhbGwuYyAgICAgICAgICAgICAgfCAgIDMgKy0NCj4+ICAg
IHNlY3VyaXR5L2tyc2kvaW5jbHVkZS9rcnNpX2luaXQuaCB8ICA1MSArKysrKysrKysrKysrKysN
Cj4+ICAgIHNlY3VyaXR5L2tyc2kva3JzaS5jICAgICAgICAgICAgICB8ICAxMyArKystDQo+PiAg
ICBzZWN1cml0eS9rcnNpL2tyc2lfZnMuYyAgICAgICAgICAgfCAgMjggKysrKysrKysNCj4+ICAg
IHNlY3VyaXR5L2tyc2kvb3BzLmMgICAgICAgICAgICAgICB8IDEwMiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+ICAgIDYgZmlsZXMgY2hhbmdlZCwgMjEzIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9r
cnNpLmgNCj4+DQpbLi4uXQ0KPj4gICAgDQo+PiArc3RhdGljIGlubGluZSBpbnQga3JzaV9ydW5f
cHJvZ3MoZW51bSBrcnNpX2hvb2tfdHlwZSB0LCBzdHJ1Y3Qga3JzaV9jdHggKmN0eCkNCj4+ICt7
DQo+PiArCXN0cnVjdCBicGZfcHJvZ19hcnJheV9pdGVtICppdGVtOw0KPj4gKwlzdHJ1Y3QgYnBm
X3Byb2cgKnByb2c7DQo+PiArCXN0cnVjdCBrcnNpX2hvb2sgKmggPSAma3JzaV9ob29rc19saXN0
W3RdOw0KPj4gKwlpbnQgcmV0LCByZXR2YWwgPSAwOw0KPiANCj4gUmV2ZXJzZSBjaHJpc3RtYXMg
dHJlZSBzdHlsZT8NCj4gDQo+PiArDQo+PiArCXByZWVtcHRfZGlzYWJsZSgpOw0KPiANCj4gRG8g
d2UgbmVlZCBwcmVlbXB0X2Rpc2FibGUoKSBoZXJlPw0KDQogRnJvbSB0aGUgZm9sbG93aW5nIHBh
dGNoZXMsIEkgc2VlIHBlcmZfZXZlbnRfb3V0cHV0KCkgaGVscGVyDQphbmQgcGVyLWNwdSBhcnJh
eSB1c2FnZS4gU28sIGluZGVlZCBwcmVlbXB0X2Rpc2FibGUoKSBpcyBuZWVkZWQuDQoNCj4gDQo+
PiArCXJjdV9yZWFkX2xvY2soKTsNCj4+ICsNCj4+ICsJaXRlbSA9IHJjdV9kZXJlZmVyZW5jZSho
LT5wcm9ncyktPml0ZW1zOw0KPj4gKwl3aGlsZSAoKHByb2cgPSBSRUFEX09OQ0UoaXRlbS0+cHJv
ZykpKSB7DQo+PiArCQlyZXQgPSBCUEZfUFJPR19SVU4ocHJvZywgY3R4KTsNCj4+ICsJCWlmIChy
ZXQgPCAwKSB7DQo+PiArCQkJcmV0dmFsID0gcmV0Ow0KPj4gKwkJCWdvdG8gb3V0Ow0KPj4gKwkJ
fQ0KPj4gKwkJaXRlbSsrOw0KPj4gKwl9DQo+PiArDQo+PiArb3V0Og0KPj4gKwlyY3VfcmVhZF91
bmxvY2soKTsNCj4+ICsJcHJlZW1wdF9lbmFibGUoKTsNCj4+ICsJcmV0dXJuIElTX0VOQUJMRUQo
Q09ORklHX1NFQ1VSSVRZX0tSU0lfRU5GT1JDRSkgPyByZXR2YWwgOiAwOw0KPj4gK30NCj4+ICsN
ClsuLi5dDQo=

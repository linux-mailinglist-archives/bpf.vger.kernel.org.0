Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F35B2C28
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2019 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfINQKp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Sep 2019 12:10:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbfINQKp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Sep 2019 12:10:45 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x8EG9SGb011504;
        Sat, 14 Sep 2019 09:09:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lHZgafwaOhXW050f9XzRWLK628AQ375m39gWz1Hd6ZI=;
 b=klqGHLH9Jafxt1VUjod+y5hLCTO21PXJOlp6nt14tDymQVpb+05CYxF/g9vCLe3YUdCb
 +24+CpXjykNlFDTcKehYcZwfy/KqMWrbU5+wAZusrZC3GGsWHJdFu+3NY7NKSaM48nTG
 r/hWdgNU1hjQd50VXTK7+TIoS10IqF4K3UA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2v0uq1125j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 14 Sep 2019 09:09:51 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sat, 14 Sep 2019 09:09:50 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Sat, 14 Sep 2019 09:09:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngJWjRuI07DgC/tokKP+X8piEiVxFCaa3jtRxuM0yHIoKPVdB/NadVLwLVPnUe6HIwzH3h3Fht2/mdlPqis7wEQ3QmKmv6sMQwyoMJjkfj4GuYKyCDf9rFOWQ0rbRIIlc/UHWUgJV4ineUkmPp6KNjf/nwsknY97NNHvEE0pf7nXugwx9Ac90Xs19PGRXz08U9lRk5+3nDYNbHeaZnEyM4pX4i6A64iay05hUhZaPCQ/I829rwfiwMPguVe02Q+seyTjEe1aVKtzSNpj0Cq5JiP9Jmt4eLGdyM0XvV8jc5alHsobsvZ+NJ0Hzjs3PDzI6bpBdz0g6fB5FaB5FWqzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHZgafwaOhXW050f9XzRWLK628AQ375m39gWz1Hd6ZI=;
 b=eAiMOIoEIlvqTPCOBrZmGcodaik9HQiL0k5TFJYxX0WeXKdoqlzXIzbytqq/k5ISifkoC6WStrE4odEBynTtEQJcWrzqzQX3f0FZm7kQdAEhLKE6mpeawYX6HNc4+00g4kEDS2wc+wphI2IojEgqKUSR/Y9Y4gHeX/AfYWyhp5x+++atiILsDM1+RC2u1ltGDTCnzrf4A8y7qIVtj1G1GsjeR0TX32nITgsK4THuVCdX5rnjuUYZgvbosVDG6sDZB2+NbHPnEFw2xeGI6nZR1gRxVKtCw6dC08jlv091rw0P7MYQ6aoAqyrYqRRIpWwPCfjDmXD3IrD8MvZ9P/O/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHZgafwaOhXW050f9XzRWLK628AQ375m39gWz1Hd6ZI=;
 b=SwUyMuxdKBHvaMEcYzTd3Khogccj6r9o60LMCN1LLVa2DROkm9JaWI9f0NS0eNW49IGI0l7GYYMw5Woiwebbv0hv1ynLbwMoxRug6oDaORv8yWNAGb/ytdiTho9wolZDtTF39dDIaOsIgDXuKs/K4Zt+UYkq5zpljNjKfTyOW/4=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB3399.namprd15.prod.outlook.com (20.179.58.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.22; Sat, 14 Sep 2019 16:09:34 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2263.021; Sat, 14 Sep 2019
 16:09:34 +0000
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
Subject: Re: [RFC v1 04/14] krsi: Add support in libbpf for BPF_PROG_TYPE_KRSI
Thread-Topic: [RFC v1 04/14] krsi: Add support in libbpf for
 BPF_PROG_TYPE_KRSI
Thread-Index: AQHVZ87VSxZSYD3ITEGtHJmrXTy7aqcrXfWA
Date:   Sat, 14 Sep 2019 16:09:34 +0000
Message-ID: <d971c3b9-b64c-b12b-a1af-1abeb39151b8@fb.com>
References: <20190910115527.5235-1-kpsingh@chromium.org>
 <20190910115527.5235-5-kpsingh@chromium.org>
In-Reply-To: <20190910115527.5235-5-kpsingh@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::9917]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3538491-f40a-4642-f821-08d7392deef3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3399;
x-ms-traffictypediagnostic: BYAPR15MB3399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB339982E2BDD232EF69038708D3B20@BYAPR15MB3399.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01604FB62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(53936002)(71190400001)(71200400001)(81156014)(86362001)(81166006)(8676002)(6436002)(14454004)(46003)(8936002)(6486002)(64756008)(66446008)(2906002)(99286004)(66476007)(66556008)(36756003)(66946007)(256004)(14444005)(102836004)(229853002)(186003)(53546011)(31686004)(52116002)(2201001)(4326008)(76176011)(386003)(6506007)(6116002)(110136005)(316002)(7416002)(5660300002)(54906003)(6512007)(2501003)(305945005)(6246003)(31696002)(5024004)(2616005)(486006)(476003)(478600001)(25786009)(7736002)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3399;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lmtijJmQoFFuzyc/yR+9Jr4gWyKw+ttxWQEunDuTcFKf9r6u2wSpecLcoOuZGdJGtWm1l0k3+3KVGlzuA74qiPtkTe5RYXSOdrLZdOczcJQt2i5oVoEb3AlzMQVvUF0PH+qr5dVDBfDHTmBp+Q1XSaNxcdavEHBgrBWOFtB1bISYGeO//GRqfK707T/osa0BGKy+izlxmfOoDjUMDp/Z2vLDSSw0gCxU8q1l0e4Xqx2mjHheZ3No+ocZ4S9N9htpN5rdYZh6Ip+ybySebOFf2qaTTBi8gCda3BnKz673meJzMJe01fxmw5NTDM83U3Tfq7QMZdYRHvwexlvwLBJEKgqSRpteVNO2xjEYE6kqzOjbnttr/mTaZFXARk8Zdw3rErywjYXaPh/WNZ7R8WnPI3EIwBk0M9wo1lOG5ma4yDQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47AF58383AFF894D9057974204ACBFCB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c3538491-f40a-4642-f821-08d7392deef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2019 16:09:34.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7elzrGTEeuRRCgfObPMFS4y3aGy+IOoxzu3pLKRB/KUIp2SC8Q+gxknjgDQzjmHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3399
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-14_05:2019-09-11,2019-09-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909140171
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDkvMTAvMTkgMTI6NTUgUE0sIEtQIFNpbmdoIHdyb3RlOg0KPiBGcm9tOiBLUCBTaW5n
aCA8a3BzaW5naEBnb29nbGUuY29tPg0KPiANCj4gVXBkYXRlIHRoZSBsaWJicGYgbGlicmFyeSB3
aXRoIGZ1bmN0aW9uYWxpdHkgdG8gbG9hZCBhbmQNCj4gYXR0YWNoIGEgcHJvZ3JhbSB0eXBlIEJQ
Rl9QUk9HX1RZUEVfS1JTSS4NCj4gDQo+IFNpbmNlIHRoZSBicGZfcHJvZ19sb2FkIGRvZXMgbm90
IGFsbG93IHRoZSBzcGVjaWZpY2F0aW9uIG9mIGFuDQo+IGV4cGVjdGVkIGF0dGFjaCB0eXBlLCBp
dCdzIHJlY29tbWVuZGVkIHRvIHVzZSBicGZfcHJvZ19sb2FkX3hhdHRyIGFuZA0KPiBzZXQgdGhl
IGV4cGVjdGVkIGF0dGFjaCB0eXBlIGFzIEtSU0kuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLUCBT
aW5naCA8a3BzaW5naEBnb29nbGUuY29tPg0KPiAtLS0NCj4gICB0b29scy9saWIvYnBmL2xpYmJw
Zi5jICAgICAgICB8IDQgKysrKw0KPiAgIHRvb2xzL2xpYi9icGYvbGliYnBmLmggICAgICAgIHwg
MiArKw0KPiAgIHRvb2xzL2xpYi9icGYvbGliYnBmLm1hcCAgICAgIHwgMiArKw0KPiAgIHRvb2xz
L2xpYi9icGYvbGliYnBmX3Byb2Jlcy5jIHwgMSArDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL2xpYmJwZi5jIGIv
dG9vbHMvbGliL2JwZi9saWJicGYuYw0KPiBpbmRleCAyYjU3ZDdlYTc4MzYuLjNjYzg2YmJjNjhj
ZCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbGliL2JwZi9saWJicGYuYw0KPiArKysgYi90b29scy9s
aWIvYnBmL2xpYmJwZi5jDQo+IEBAIC0yNjc2LDYgKzI2NzYsNyBAQCBzdGF0aWMgYm9vbCBicGZf
cHJvZ190eXBlX19uZWVkc19rdmVyKGVudW0gYnBmX3Byb2dfdHlwZSB0eXBlKQ0KPiAgIAljYXNl
IEJQRl9QUk9HX1RZUEVfUEVSRl9FVkVOVDoNCj4gICAJY2FzZSBCUEZfUFJPR19UWVBFX0NHUk9V
UF9TWVNDVEw6DQo+ICAgCWNhc2UgQlBGX1BST0dfVFlQRV9DR1JPVVBfU09DS09QVDoNCj4gKwlj
YXNlIEJQRl9QUk9HX1RZUEVfS1JTSToNCj4gICAJCXJldHVybiBmYWxzZTsNCj4gICAJY2FzZSBC
UEZfUFJPR19UWVBFX0tQUk9CRToNCj4gICAJZGVmYXVsdDoNCj4gQEAgLTM1MzYsNiArMzUzNyw3
IEBAIGJvb2wgYnBmX3Byb2dyYW1fX2lzXyMjTkFNRShjb25zdCBzdHJ1Y3QgYnBmX3Byb2dyYW0g
KnByb2cpCVwNCj4gICB9CQkJCQkJCQlcDQo+ICAgDQo+ICAgQlBGX1BST0dfVFlQRV9GTlMoc29j
a2V0X2ZpbHRlciwgQlBGX1BST0dfVFlQRV9TT0NLRVRfRklMVEVSKTsNCj4gK0JQRl9QUk9HX1RZ
UEVfRk5TKGtyc2ksIEJQRl9QUk9HX1RZUEVfS1JTSSk7DQo+ICAgQlBGX1BST0dfVFlQRV9GTlMo
a3Byb2JlLCBCUEZfUFJPR19UWVBFX0tQUk9CRSk7DQo+ICAgQlBGX1BST0dfVFlQRV9GTlMoc2No
ZWRfY2xzLCBCUEZfUFJPR19UWVBFX1NDSEVEX0NMUyk7DQo+ICAgQlBGX1BST0dfVFlQRV9GTlMo
c2NoZWRfYWN0LCBCUEZfUFJPR19UWVBFX1NDSEVEX0FDVCk7DQo+IEBAIC0zNTkwLDYgKzM1OTIs
OCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHsNCj4gICAJQlBGX1BST0dfU0VDKCJsd3Rfb3V0IiwJ
CQlCUEZfUFJPR19UWVBFX0xXVF9PVVQpLA0KPiAgIAlCUEZfUFJPR19TRUMoImx3dF94bWl0IiwJ
CUJQRl9QUk9HX1RZUEVfTFdUX1hNSVQpLA0KPiAgIAlCUEZfUFJPR19TRUMoImx3dF9zZWc2bG9j
YWwiLAkJQlBGX1BST0dfVFlQRV9MV1RfU0VHNkxPQ0FMKSwNCj4gKwlCUEZfQVBST0dfU0VDKCJr
cnNpIiwJCQlCUEZfUFJPR19UWVBFX0tSU0ksDQo+ICsJCQkJCQlCUEZfS1JTSSksDQo+ICAgCUJQ
Rl9BUFJPR19TRUMoImNncm91cF9za2IvaW5ncmVzcyIsCUJQRl9QUk9HX1RZUEVfQ0dST1VQX1NL
QiwNCj4gICAJCQkJCQlCUEZfQ0dST1VQX0lORVRfSU5HUkVTUyksDQo+ICAgCUJQRl9BUFJPR19T
RUMoImNncm91cF9za2IvZWdyZXNzIiwJQlBGX1BST0dfVFlQRV9DR1JPVVBfU0tCLA0KPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvbGliL2JwZi9saWJicGYuaCBiL3Rvb2xzL2xpYi9icGYvbGliYnBmLmgN
Cj4gaW5kZXggNWNiZjQ1OWVjZTBiLi44NzgxZDI5YjQwMzUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xz
L2xpYi9icGYvbGliYnBmLmgNCj4gKysrIGIvdG9vbHMvbGliL2JwZi9saWJicGYuaA0KPiBAQCAt
MjYxLDYgKzI2MSw3IEBAIExJQkJQRl9BUEkgaW50IGJwZl9wcm9ncmFtX19zZXRfc2NoZWRfY2xz
KHN0cnVjdCBicGZfcHJvZ3JhbSAqcHJvZyk7DQo+ICAgTElCQlBGX0FQSSBpbnQgYnBmX3Byb2dy
YW1fX3NldF9zY2hlZF9hY3Qoc3RydWN0IGJwZl9wcm9ncmFtICpwcm9nKTsNCj4gICBMSUJCUEZf
QVBJIGludCBicGZfcHJvZ3JhbV9fc2V0X3hkcChzdHJ1Y3QgYnBmX3Byb2dyYW0gKnByb2cpOw0K
PiAgIExJQkJQRl9BUEkgaW50IGJwZl9wcm9ncmFtX19zZXRfcGVyZl9ldmVudChzdHJ1Y3QgYnBm
X3Byb2dyYW0gKnByb2cpOw0KPiArTElCQlBGX0FQSSBpbnQgYnBmX3Byb2dyYW1fX3NldF9rcnNp
KHN0cnVjdCBicGZfcHJvZ3JhbSAqcHJvZyk7DQo+ICAgTElCQlBGX0FQSSB2b2lkIGJwZl9wcm9n
cmFtX19zZXRfdHlwZShzdHJ1Y3QgYnBmX3Byb2dyYW0gKnByb2csDQo+ICAgCQkJCSAgICAgIGVu
dW0gYnBmX3Byb2dfdHlwZSB0eXBlKTsNCj4gICBMSUJCUEZfQVBJIHZvaWQNCj4gQEAgLTI3NSw2
ICsyNzYsNyBAQCBMSUJCUEZfQVBJIGJvb2wgYnBmX3Byb2dyYW1fX2lzX3NjaGVkX2Nscyhjb25z
dCBzdHJ1Y3QgYnBmX3Byb2dyYW0gKnByb2cpOw0KPiAgIExJQkJQRl9BUEkgYm9vbCBicGZfcHJv
Z3JhbV9faXNfc2NoZWRfYWN0KGNvbnN0IHN0cnVjdCBicGZfcHJvZ3JhbSAqcHJvZyk7DQo+ICAg
TElCQlBGX0FQSSBib29sIGJwZl9wcm9ncmFtX19pc194ZHAoY29uc3Qgc3RydWN0IGJwZl9wcm9n
cmFtICpwcm9nKTsNCj4gICBMSUJCUEZfQVBJIGJvb2wgYnBmX3Byb2dyYW1fX2lzX3BlcmZfZXZl
bnQoY29uc3Qgc3RydWN0IGJwZl9wcm9ncmFtICpwcm9nKTsNCj4gK0xJQkJQRl9BUEkgYm9vbCBi
cGZfcHJvZ3JhbV9faXNfa3JzaShjb25zdCBzdHJ1Y3QgYnBmX3Byb2dyYW0gKnByb2cpOw0KPiAg
IA0KPiAgIC8qDQo+ICAgICogTm8gbmVlZCBmb3IgX19hdHRyaWJ1dGVfXygocGFja2VkKSksIGFs
bCBtZW1iZXJzIG9mICdicGZfbWFwX2RlZicNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYv
bGliYnBmLm1hcCBiL3Rvb2xzL2xpYi9icGYvbGliYnBmLm1hcA0KPiBpbmRleCBmOWQzMTZlODcz
ZDguLjc1YjhmZTQxOWMxMSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbGliL2JwZi9saWJicGYubWFw
DQo+ICsrKyBiL3Rvb2xzL2xpYi9icGYvbGliYnBmLm1hcA0KPiBAQCAtNjgsNiArNjgsNyBAQCBM
SUJCUEZfMC4wLjEgew0KPiAgIAkJYnBmX3Byb2dfdGVzdF9ydW5feGF0dHI7DQo+ICAgCQlicGZf
cHJvZ3JhbV9fZmQ7DQo+ICAgCQlicGZfcHJvZ3JhbV9faXNfa3Byb2JlOw0KPiArCQlicGZfcHJv
Z3JhbV9faXNfa3JzaTsNCj4gICAJCWJwZl9wcm9ncmFtX19pc19wZXJmX2V2ZW50Ow0KPiAgIAkJ
YnBmX3Byb2dyYW1fX2lzX3Jhd190cmFjZXBvaW50Ow0KPiAgIAkJYnBmX3Byb2dyYW1fX2lzX3Nj
aGVkX2FjdDsNCj4gQEAgLTg1LDYgKzg2LDcgQEAgTElCQlBGXzAuMC4xIHsNCj4gICAJCWJwZl9w
cm9ncmFtX19zZXRfZXhwZWN0ZWRfYXR0YWNoX3R5cGU7DQo+ICAgCQlicGZfcHJvZ3JhbV9fc2V0
X2lmaW5kZXg7DQo+ICAgCQlicGZfcHJvZ3JhbV9fc2V0X2twcm9iZTsNCj4gKwkJYnBmX3Byb2dy
YW1fX3NldF9rcnNpOw0KPiAgIAkJYnBmX3Byb2dyYW1fX3NldF9wZXJmX2V2ZW50Ow0KPiAgIAkJ
YnBmX3Byb2dyYW1fX3NldF9wcmVwOw0KPiAgIAkJYnBmX3Byb2dyYW1fX3NldF9wcml2Ow0KDQpQ
bGVhc2UgcHV0IHRoZSBhYm92ZSB0d28gbmV3IEFQSSBmdW5jdGlvbnMgaW4gdmVyc2lvbiBMSUJC
UEZfMC4wLjUuDQoNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvbGliYnBmX3Byb2Jlcy5j
IGIvdG9vbHMvbGliL2JwZi9saWJicGZfcHJvYmVzLmMNCj4gaW5kZXggYWNlMWEwNzA4ZDk5Li5j
YzUxNWEzNjc5NGQgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL2xpYi9icGYvbGliYnBmX3Byb2Jlcy5j
DQo+ICsrKyBiL3Rvb2xzL2xpYi9icGYvbGliYnBmX3Byb2Jlcy5jDQo+IEBAIC0xMDIsNiArMTAy
LDcgQEAgcHJvYmVfbG9hZChlbnVtIGJwZl9wcm9nX3R5cGUgcHJvZ190eXBlLCBjb25zdCBzdHJ1
Y3QgYnBmX2luc24gKmluc25zLA0KPiAgIAljYXNlIEJQRl9QUk9HX1RZUEVfRkxPV19ESVNTRUNU
T1I6DQo+ICAgCWNhc2UgQlBGX1BST0dfVFlQRV9DR1JPVVBfU1lTQ1RMOg0KPiAgIAljYXNlIEJQ
Rl9QUk9HX1RZUEVfQ0dST1VQX1NPQ0tPUFQ6DQo+ICsJY2FzZSBCUEZfUFJPR19UWVBFX0tSU0k6
DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlicmVhazsNCj4gICAJfQ0KPiANCg==

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F75C52F
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 23:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGAVwI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 17:52:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34474 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbfGAVwI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Jul 2019 17:52:08 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61Lms4f026035;
        Mon, 1 Jul 2019 14:51:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xxDN0MgqRaSVmWPKtnc5w6wR3S9316BxoOW8lTKRS44=;
 b=XTKFl97m2MGdAUHp1NZYMnwOQAR8+0912yN9bnnWG3rfN4Qjgk2HxFz+qUFQBR2YPzmZ
 kfKSMbmqlxSX8ppKdZMzpxii/9NYHg/NTx2hhOQAqGs3Ml0a6upWZgKQY2DBNmuvB473
 A216YwK1NdOost8pTTR8I4yMXyv4McA8rmk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tfhgnj4gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Jul 2019 14:51:45 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 1 Jul 2019 14:51:27 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 1 Jul 2019 14:51:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 1 Jul 2019 14:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=H40UfFI1t30q/qceWx76GvXL7K66jeiAJJ6n/i6h5L6bjtAqL7zrGmGTSRi1L8zCBKa2MADfQtUvkrPBU0bmS7EVUkODyP1MH0/CG6OAWdVBAcDYPTiZNHn5dpNDMuUQVizqSYhmK2G9pPp2YLIHSD+EbqzN/E/p+Fw/ZSY6KLg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxDN0MgqRaSVmWPKtnc5w6wR3S9316BxoOW8lTKRS44=;
 b=GOpRfYuSs9Yct41S2qecEmM53tecb+F8HJ+pHtRuvhS4HiAKm5Ggzb5QajsorFxA/yaCewi+vxZ/a1LNM5XsIJHMHq4VUGSiSTMNUON/sMGKaZfWk2DooK1v4nIiY/rJb0kGD1DRElSGrNCNFvkVASj/7/ApmLV86skAAz7Z/vo=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxDN0MgqRaSVmWPKtnc5w6wR3S9316BxoOW8lTKRS44=;
 b=QPHzMmPI/bjyzJ8Ip9SLfu8FAtZDzOI5PAtIffVG78kotB3WHIfGIn4Mv2iG6/3PaPxW2wSfHnam1llHoNwNVjfnziNeoGqPpPfCZS3P8am1VhI70d3GQ0OAte9ij8RdcF152MHa6qFDI76214YdkiEqRSko6QujtgqxEOGMzMk=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2485.namprd15.prod.outlook.com (52.135.194.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 1 Jul 2019 21:51:26 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::850b:bed:29d5:ae79]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::850b:bed:29d5:ae79%7]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 21:51:26 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Paolo Pisati <p.pisati@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [RESEND] test_verifier #13 fails on arm64: "retval 65507 != -29"
Thread-Topic: [RESEND] test_verifier #13 fails on arm64: "retval 65507 != -29"
Thread-Index: AQHVMAPBDdUL3Hum/U6zKAIOtp5Ynaa2TjYA
Date:   Mon, 1 Jul 2019 21:51:25 +0000
Message-ID: <68248069-bcf6-69dd-b0a9-f4ec11e50092@fb.com>
References: <20190701115414.GA4452@harukaze>
In-Reply-To: <20190701115414.GA4452@harukaze>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:300:ee::11) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:fe3a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85e89968-e098-41a7-0b40-08d6fe6e43d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2485;
x-ms-traffictypediagnostic: BYAPR15MB2485:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB2485E8C72FDEF877EE5715AFD3F90@BYAPR15MB2485.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(376002)(39860400002)(189003)(199004)(8676002)(8936002)(71200400001)(81156014)(71190400001)(36756003)(64756008)(66476007)(66556008)(446003)(11346002)(81166006)(66946007)(2616005)(476003)(73956011)(305945005)(46003)(68736007)(6486002)(86362001)(486006)(2906002)(31686004)(7736002)(66446008)(256004)(110136005)(316002)(54906003)(31696002)(478600001)(52116002)(6436002)(6512007)(76176011)(14444005)(229853002)(6306002)(4326008)(186003)(25786009)(102836004)(53936002)(6116002)(99286004)(386003)(6506007)(53546011)(5660300002)(966005)(14454004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2485;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Pfbiv0sdsFEBCspT9vxFqdy8xexTezYdQtEK4lGh0doxrvrzopoz+snl87gO9bS+Cs4AtsikvIAVJils8O79SGj6DbpQUZrpCitBBlwbUu/NhcS199jDn9uMFEPG4YTjOaKp3z7MUVd+PmQWlURU0mU4pwoyC3+PQQKIiUJFQM6VtOiFS4llqLj8QPiRIO0I/BNh9FYpUTG9qWYYnJoAsvKq3aGLbHT37wjxm3VUurjfJ2lmivoetfygcj4M8ehhyGplXMWAZEaaMd5GyQAFDoaST2GqxpqlXx2tN01OSzODIoFanZi3qM8j3uNQp0EHyej0IXL7A8ijyAfbM/vusfHXkKoKBUT4XYKucp8dlUMkKdn9s2I83lecBrZpaE9WVBozLwIKDkGyMA/hVwJVrCu5VT6oQp1l7K8IQ+BRcc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02868A6A3D71B34BB9616B359447EC31@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e89968-e098-41a7-0b40-08d6fe6e43d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 21:51:25.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhs@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2485
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=989 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010252
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDcvMS8xOSA0OjU0IEFNLCBQYW9sbyBQaXNhdGkgd3JvdGU6DQo+IEZ1bGwgZmFpbHVy
ZSBtZXNzYWdlOg0KPiANCj4gLi4uDQo+ICMxMy9wIHZhbGlkIHJlYWQgbWFwIGFjY2VzcyBpbnRv
IGEgcmVhZC1vbmx5IGFycmF5IDIgRkFJTCByZXR2YWwgNjU1MDcgIT0gLTI5DQo+IHZlcmlmaWNh
dGlvbiB0aW1lIDE0IHVzZWMNCj4gc3RhY2sgZGVwdGggOA0KPiBwcm9jZXNzZWQgMTQgaW5zbnMg
KGxpbWl0IDEwMDAwMDApIG1heF9zdGF0ZXNfcGVyX2luc24gMCB0b3RhbF9zdGF0ZXMgMg0KPiBw
ZWFrX3N0YXRlcyAyIG1hcmtfcmVhZCAxDQo+IC4uLg0KPiANCj4gdGhpcyBvbiA1LjItcmM2LCBh
cm02NCBkZWZjb25maWcgKyBDT05GSUdfQlBGKiBlbmFibGVkIChmdWxsIGNvbmZpZyBoZXJlIFsx
XSkuDQo+IEFueSBpZGVhIHdoYXQgY291bGQgYmUgd3Jvbmc/DQoNCkJlbG93IGlzIHRoZSB0ZXN0
IGNhc2UuDQp7DQogICAgICAgICAidmFsaWQgcmVhZCBtYXAgYWNjZXNzIGludG8gYSByZWFkLW9u
bHkgYXJyYXkgMiIsDQogICAgICAgICAuaW5zbnMgPSB7DQogICAgICAgICBCUEZfU1RfTUVNKEJQ
Rl9EVywgQlBGX1JFR18xMCwgLTgsIDApLA0KICAgICAgICAgQlBGX01PVjY0X1JFRyhCUEZfUkVH
XzIsIEJQRl9SRUdfMTApLA0KICAgICAgICAgQlBGX0FMVTY0X0lNTShCUEZfQURELCBCUEZfUkVH
XzIsIC04KSwNCiAgICAgICAgIEJQRl9MRF9NQVBfRkQoQlBGX1JFR18xLCAwKSwNCiAgICAgICAg
IEJQRl9SQVdfSU5TTihCUEZfSk1QIHwgQlBGX0NBTEwsIDAsIDAsIDAsIA0KQlBGX0ZVTkNfbWFw
X2xvb2t1cF9lbGVtKSwNCiAgICAgICAgIEJQRl9KTVBfSU1NKEJQRl9KRVEsIEJQRl9SRUdfMCwg
MCwgNiksDQoNCiAgICAgICAgIEJQRl9NT1Y2NF9SRUcoQlBGX1JFR18xLCBCUEZfUkVHXzApLA0K
ICAgICAgICAgQlBGX01PVjY0X0lNTShCUEZfUkVHXzIsIDQpLA0KICAgICAgICAgQlBGX01PVjY0
X0lNTShCUEZfUkVHXzMsIDApLA0KICAgICAgICAgQlBGX01PVjY0X0lNTShCUEZfUkVHXzQsIDAp
LA0KICAgICAgICAgQlBGX01PVjY0X0lNTShCUEZfUkVHXzUsIDApLA0KICAgICAgICAgQlBGX1JB
V19JTlNOKEJQRl9KTVAgfCBCUEZfQ0FMTCwgMCwgMCwgMCwNCiAgICAgICAgICAgICAgICAgICAg
ICBCUEZfRlVOQ19jc3VtX2RpZmYpLA0KICAgICAgICAgQlBGX0VYSVRfSU5TTigpLA0KICAgICAg
ICAgfSwNCiAgICAgICAgIC5wcm9nX3R5cGUgPSBCUEZfUFJPR19UWVBFX1NDSEVEX0NMUywNCiAg
ICAgICAgIC5maXh1cF9tYXBfYXJyYXlfcm8gPSB7IDMgfSwNCiAgICAgICAgIC5yZXN1bHQgPSBB
Q0NFUFQsDQogICAgICAgICAucmV0dmFsID0gLTI5LA0KfSwNCg0KVGhlIGlzc3VlIG1heSBiZSB3
aXRoIGhlbHBlciBicGZfY3N1bV9kaWZmKCkuDQpNYXliZSB5b3UgY2FuIGNoZWNrIGJwZl9jc3Vt
X2RpZmYoKSBoZWxwZXIgcmV0dXJuIHZhbHVlDQp0byBjb25maXJtIGFuZCB0YWtlIGEgZnVydGhl
ciBsb29rIGF0IGJwZl9jc3VtX2RpZmYgaW1wbGVtZW50YXRpb25zDQpiZXR3ZWVuIHg2NCBhbmQg
YW1kNjQuDQoNCj4gDQo+IDE6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91
cmw/dT1odHRwLTNBX19wYXN0ZS51YnVudHUuY29tX3BfdFhYRkdDUHdicF8mZD1Ed0lCQWcmYz01
VkQwUlR0TmxUaDN5Y2Q0MWIzTVV3JnI9REE4ZTFCNXIwNzN2SXFSckZ6N01SQSZtPVpGTWgwMTV5
Q0huLVVPendUZk9udjVFVWw4Ukh6V1NnV3lBN1Z6RUFNVGsmcz1aZ0VBME5PcFB1ZXBJMkRRaWs4
Y3YzYlREeUY2V3g2MXlPQjFPdG5wQ2cwJmU9DQo+IA0K

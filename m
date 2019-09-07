Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38083AC4EC
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2019 08:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406482AbfIGGiJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 Sep 2019 02:38:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733303AbfIGGiJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 7 Sep 2019 02:38:09 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x876Z1uw027231;
        Fri, 6 Sep 2019 23:38:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JsJOrfxWtrsRGB7L1LrEVqLKaoXUFdXhJwlyfd2tr9s=;
 b=WnNsVE+Qb+Dv5kdckGHge2gafcW85SmKQBBsup1QSuWXc7tG8Gt9EmSv3MzSyEs5/PUo
 FBKGm6lFG8MzC3opbTT3lTd5h8pJhS1USl4YiRVmTNj61jOL0YcQT/QTmgwCnkDN00jq
 XZ8M3M+XgqAjxrvCmFwlICLLbIIPkA7krZA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2uus7ckmhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 23:38:03 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 6 Sep 2019 23:38:03 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 6 Sep 2019 23:38:02 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 6 Sep 2019 23:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS9hC/hpdhsNyzQCMHNIj7yI5FHhfnp7hSgd6p0wMwE5RVyNl3rJSsEAzrJzdf6PLI2lqDOIw8+eXZbrMO4PI17jTpTTdusIvCCas/5u+sMBu9nr0DM9nyl1AGiRUkvrh0BNhq8V0DwKsrmKWO0keQMTP40qbshYqkzItBuqI0Z3VZtkoRYBbVWx/E4zwDqECLtz/uPNIfwZFSxob0699JQL2mVh9TL2K1cUgAaBhRIz6o1C+73dczVcAm3a/D7Th686tbc7fT9npl9AC3qfJDxcXhpIjqmQ7aQqGtumYDDV7uwBzE7FqGouc+8/hP95TLqbnoSj3KYJdUlQdyznYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsJOrfxWtrsRGB7L1LrEVqLKaoXUFdXhJwlyfd2tr9s=;
 b=cyuqf0u6Vml7uXKOdk619uBBtgJ3ObRMu8TzkfcPOYPk3kd80rWaK/Cu3JAK2tmjY2ozOF1GaP3Tm3QdniKBfLmEqfZdlhSA4uuRWPQATkoTKxb5vhao3iNBhHsUOIL7jb4Xe8oAGoGXlqzYGc27e/nrQMfU82pS7kPjNHdB98KcwCNMs7sfbXDDo6KE5KyfBA6jAeg4/H4QkWl5H1haL627Hfq0SOS/4qiXN0WNgPvsEJudOUyQWW38wknmtB70ZAuKvZLWNMXblV1zqK43hM1h1AoqDISKALYcojgsCTWPeAFkkntx7TQccBPrYe5dd1H+UMgBmDtrKg4/yTRq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsJOrfxWtrsRGB7L1LrEVqLKaoXUFdXhJwlyfd2tr9s=;
 b=SbIAG5DEdgWdkhEi8xP+hYCGz2dVQMldu2mUHkGja0BV+2ukpO6qvonJF9swYxBUBilS5/t3GLAz/bcEKqhMn3gsKxwW7uXjXQ4XRO2f4oYNgcxidDAoBkBoS6IwsEOqWdSn2OdJPZHucBYN0nDYOwffx8orrh/FOuEncaqSONY=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2936.namprd15.prod.outlook.com (20.178.237.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Sat, 7 Sep 2019 06:38:01 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::95ab:61a0:29f4:e07e%6]) with mapi id 15.20.2241.014; Sat, 7 Sep 2019
 06:38:01 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "kulkarni@ucla.edu" <kulkarni@ucla.edu>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Per cgroup accounting of context switches
Thread-Topic: Per cgroup accounting of context switches
Thread-Index: AQHVZTUEE75TpeO4R0W4D03/i7UTX6cfwyeA
Date:   Sat, 7 Sep 2019 06:38:01 +0000
Message-ID: <e8c05dab-1d14-4cd4-ad63-2a8f0dbb7ece@fb.com>
References: <CANZ-dUobRee1NrntgZsnvZN7HmbAgszjX4t4bV5-27sR+fVHWA@mail.gmail.com>
In-Reply-To: <CANZ-dUobRee1NrntgZsnvZN7HmbAgszjX4t4bV5-27sR+fVHWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::7c8a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d910e08-d74d-4215-4d34-08d7335dede9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2936;
x-ms-traffictypediagnostic: BYAPR15MB2936:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB29362C6900754496B34D8B8BD3B50@BYAPR15MB2936.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(486006)(2501003)(86362001)(46003)(478600001)(31686004)(476003)(256004)(5024004)(446003)(186003)(2616005)(31696002)(11346002)(8676002)(81156014)(81166006)(8936002)(305945005)(7736002)(14444005)(36756003)(99286004)(71190400001)(71200400001)(5660300002)(66946007)(52116002)(2906002)(66446008)(64756008)(6116002)(110136005)(66476007)(15650500001)(66556008)(316002)(6512007)(6486002)(6306002)(14454004)(6506007)(76176011)(25786009)(229853002)(966005)(386003)(53936002)(53546011)(102836004)(6246003)(2171002)(6436002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2936;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8o3msyRXsIGcJBU95bt0B5ZHGGQN3JOMO3tuJvzfFSq8crHaUWuVVhGwabSLdpPO4t7XF18PMu/qNh9P7CVMW8s+sP6M/YsHpLAEiOybuYBr2d8LuOqwEL905hf6RlI8ZUFSXQqWpZjay6PRHAUkueYwSwVXaOXvY81ftbYCaOOps9GyYUlkUdaKgHw0DfMsFr7cfHxJ/WMm4io3drn7zBwlG3QHistBcEToqqtedwSCmZQQSTo4j39gxUhWJaF2/yBdWyol/2FT0E+ApK7EUq7tRKtT/u5d+4m9gBupb/ej3sfKyMYWVEp35Vc88H9dlA2xQntUJGDLLNYBErjBVYo/+9sP3J2S0HImTHW/84mmbepO1enIS4ELwKDv/l2lxrB/mqMiJv2xOY6ILHVh/2I/1HyveeFE/m12KKbFP5Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DDEAFE7B54CFB438AA9746001E71AED@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d910e08-d74d-4215-4d34-08d7335dede9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 06:38:01.4438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXkQgosreqoK1msOx/EFPSvaeIFE1xDY00BsppxQ0Fmh1YujoGh4c4OxB8Mqk4jj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2936
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-07_02:2019-09-04,2019-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1909070070
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDkvNi8xOSA5OjMwIFBNLCBHYXV0YW0gS3Vsa2Fybmkgd3JvdGU6DQo+IEhpLA0KPiAN
Cj4gV2UgYXJlIGV2YWx1YXRpbmcgZUJQRiBhcyBhIG1lYW5zIHRvIGFjY291bnQgdm9sdW50YXJ5
IGFuZA0KPiBub24tdm9sdW50YXJ5IGNvbnRleHQgc3dpdGNoZXMgYWdhaW5zdCBjZ3JvdXBzLiBD
dXJyZW50bHksIHRoaXMNCj4gaW5mb3JtYXRpb24gaXMgb25seSBwcmVzZW50IGluIHRoZSB0YXNr
X3N0cnVjdCBmb3IgYW4gaW5kaXZpZHVhbA0KPiBwcm9jZXNzIGFuZCBub3QgaW4gdGhlIGNncm91
cCBkYXRhIHN0cnVjdHVyZS4NCj4gDQo+IFdpdGggdGhpcyBjb250ZXh0LCBJIHdhcyBsb29raW5n
IGZvciByZWNvbW1lbmRhdGlvbiBvbiB0aGUgZm9sbG93aW5nDQo+IHBvc3NpYmxlIGFwcHJvYWNo
ZXM6DQo+IA0KPiAxLiBVc2UgdGhlIGV4aXN0aW5nIHRyYWNlcG9pbnQgKHRyYWNlX3NjaGVkX3N3
aXRjaCkgYXMgaXQgZXhpc3RzIGhlcmUNCj4gd2l0aCBCUEZfUFJPR19UWVBFX1RSQUNFUE9JTlQ6
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9rZXJuZWwv
c2NoZWQvY29yZS5jI0wzODc3DQo+IEhvd2V2ZXIsIGJhc2VkIG9uIHRoZSB0cmFjZSBmb3JtYXQs
IHRoZSBrZXJuZWwgZG9lcyBub3QgZXhwb3NlDQo+IHByZXYtPm5pdmNzdyBhbmQgcHJldi0+bnZj
c3cuIER1ZSB0byB0aGlzLCBJIGZlZWwgbGlrZSB0aGlzIGFwcHJvYWNoDQo+IG1heSBub3QgYmUg
ZmVhc2libGUuIElzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8NCg0KWW91IGNhbiB1c2UgQlBG
X1JBV19UUkFDRVBPSU5UX09QRU4gYW5kIGBwcmV2YCBhcmd1bWVudCB3aWxsDQpiZSBhdmFpbGFi
bGUgdG8gYnBmIHByb2dyYW1zLg0KDQo+IA0KPiAyLiBBdHRhY2ggYSBrcHJvYmUgdG8gX19zY2hl
ZHVsZSgpIGFuZCB1c2UgQlBGX1BST0dfVFlQRV9LUFJPQkUNCj4gVGhpcyB3aWxsIGFsbG93IHVz
IGFjY2VzcyB0byB0aGUgcHJldiBwb2ludGVyLiBGcm9tIHRoZSBwcmV2DQo+ICh0YXNrX3N0cnVj
dCksIHdlIGNhbiBhY2Nlc3MgdGhlIGNncm91cCBhbmQgdXNlIGFuIGVCUEYgbWFwIHRvDQo+IGFj
Y3VtdWxhdGUgcGVyIGNncm91cCBjb3VudHMgb2YgY29udGV4dCBzd2l0Y2hlcy4NCj4gDQo+IDMu
IEltcGxlbWVudCBhIGtlcm5lbCBtb2R1bGUgdGhhdCBhdHRhY2hlcyBhIGtwcm9iZSB0byBfX3Nj
aGVkdWxlKCkNCj4gYW5kIGltcGxlbWVudCB0aGUgbWFwIGluIHRoZSBrcHJvYmUgaGFuZGxlci4N
Cj4gDQo+IDQuIE1vZGlmeSB0aGUga2VybmVsIHRvIGhhdmUgY29udGV4dCBzd2l0Y2ggaW5mb3Jt
YXRpb24gaW4gdGFza19ncm91cC4NCj4gV291bGQgdGhpcyBiZSBzb21ldGhpbmcgdGhhdCB3b3Vs
ZCBtYWtlIHNlbnNlIHRvIHRoZSBjb21tdW5pdHk/DQo+IA0KPiBJIHdvdWxkIGhpZ2hseSBhcHBy
ZWNpYXRlIGFueSBmZWVkYmFjayBvbiB0aGlzLg0KPiANCj4gUmVnYXJkcywNCj4gR2F1dGFtDQo+
IA0K

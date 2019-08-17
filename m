Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D290BA0
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2019 02:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfHQAGr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 20:06:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38656 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbfHQAGr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 20:06:47 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7H03OMN017713;
        Fri, 16 Aug 2019 17:06:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=c0sUaxRuiPwzxKiSd/5OwEhJdgQ0ULn/dLrRQudwIgI=;
 b=GM6XwgCmiVcSVrM/Bp2AyNRJ1DDKYuAFJi78tF1u3txlpE2+E4B0MJD5T8NC1PVdH/JC
 aJiJuKM+lIxQNomuiauvr3rvMWFlfVZ6/MbveGSFkJQOn85U+MQnSNiUunQeejZLv7KE
 CQj4aoXVTFw7oKue3ulW2PIHj1L3hITmxTY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ue3e88qxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 16 Aug 2019 17:06:13 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 16 Aug 2019 17:06:12 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 16 Aug 2019 17:06:12 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 16 Aug 2019 17:06:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM8KKVzUtS0Upn2ZtnXIl/awVRQU/n/qRQHaqjIeWnCCyv0riY8FS6JuDS6TigvSYMLYhlRI89OA1wO8GOwiBTbRl+JR/o0KVuNmWuZfVjqzjbdY2ZbTxIO6T8qwwSKjBAyNQRwke60pB3TRZIpXIjivyCHT1Cbdv7/AHaU+uqNghLuelDgSVfzyZpbbhFppNSKGiD7iHypa1vyioRuEPdfPYLWjjWBefDU15DdMD2SbVr8aAHDR/fKfrrVsnpROaJrGfiLUYcSQ/d7vI4PkH3V1X+9HvgzW20Hr5wsgCpyeGKVUxgUaWC6X6EXa1lg4wqZwviiX7UNd9nPeNOkikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0sUaxRuiPwzxKiSd/5OwEhJdgQ0ULn/dLrRQudwIgI=;
 b=XK2hpPlJAdR/5QmxvTx5kvMV+ZGrqhfmFl2cHmJPtkC+d1jtfyNjsKZBreciSUbwoQhFYzoQNnG1/FBUFyoEzL1pnEUsEZ+jbTmewLe4ryxpWS4BNRv6R7FiqurWHPP44nMsPXeyhId6POu03Ui9xXKc8Ii18IqbvreUhjTJzkXz/M5tQl4ZJb45xGUgzkHCju4KzDvYFBwiRwmmvHcL+UckrqYLbQo6Okoaay2UUi9Fym6HKH8Lq17H1ca15Qjtl1jQRjxPySzEBlOqk0mqUtwEFW5ly68Xu5ebt+Lo6SdOdxFNQEappTKLBQpaW7gBSKllh057lTZk4gic0I9sZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0sUaxRuiPwzxKiSd/5OwEhJdgQ0ULn/dLrRQudwIgI=;
 b=eXdJw8Ej7gMOmEOn9DKIxGbSFQzaL4juXHLl0S5vMOZTTPm5nuVKK+Hl+buS/vwkXdU1tQhgudtoa5fxzyHbhNOCqJIleMKJhq+ifSOpKbLzIyQVUKTVkA/vXSKdf3vMUScBGM7nkVgmt6N7jLmT6F40/FViaj2Kyok9fwm76kk=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2262.namprd15.prod.outlook.com (52.135.197.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 17 Aug 2019 00:06:10 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978%5]) with mapi id 15.20.2157.022; Sat, 17 Aug 2019
 00:06:10 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix endianness issues in test_sysctl
Thread-Topic: [PATCH bpf] selftests/bpf: fix endianness issues in test_sysctl
Thread-Index: AQHVU8ZSr+W6lQSZGka9gEkiaXERSKb9pnMAgADRIQA=
Date:   Sat, 17 Aug 2019 00:06:10 +0000
Message-ID: <290c0812-59e7-f8f6-6dd4-c98eb7513708@fb.com>
References: <20190815122525.41073-1-iii@linux.ibm.com>
 <076513cd-fbde-cf66-ce3b-a6143878f786@fb.com>
 <91EFE17B-3835-4679-8464-A76C885BCD46@linux.ibm.com>
In-Reply-To: <91EFE17B-3835-4679-8464-A76C885BCD46@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:300:115::25) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:9590]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b61e41e-9414-4284-f1d0-08d722a6b591
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2262;
x-ms-traffictypediagnostic: BYAPR15MB2262:
x-microsoft-antispam-prvs: <BYAPR15MB22623AC530D81E482830825FD3AE0@BYAPR15MB2262.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0132C558ED
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(4326008)(6486002)(6246003)(54906003)(25786009)(316002)(66446008)(229853002)(5660300002)(6916009)(14454004)(66556008)(66476007)(478600001)(305945005)(7736002)(64756008)(66946007)(6436002)(31696002)(8936002)(81166006)(81156014)(8676002)(446003)(46003)(76176011)(52116002)(186003)(386003)(53546011)(31686004)(6506007)(102836004)(6512007)(2906002)(6116002)(36756003)(53936002)(71190400001)(71200400001)(99286004)(486006)(11346002)(476003)(2616005)(86362001)(256004)(461764006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2262;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1TezY1CEwKxOL6KMQKxUt9LdOLO8/CgMzLjUGcgiJlCgQQCTrPytlHvoKeWHgqaAUw2ScONf1vbEmBrqvw6hDvlqCoeFMvfYUM5FHYAg//qRQOSqhsFY+zIoIW35lFonHwg5axjqDoKCKCVhpH2f66+w2WGzeFTqBIkRiSFssk+5VTqXJFbYmkLRqBYfYxOY22MltxVzcdvUdqUKZn0HppzI+aCPyc1iS0yFyaQDRex/HGBkJjIBpKooyrDxQUd6yuB4qKcZvIXYNjH7AX+kjZ4shfzKm6joZzyDqnNFokU1YpxASty5ehZRwWDmJ8Mc/z8cnBEjA2MoU1Q0/EBaS4FyvEdE7BLFZA1VM5sSd/fgKuj8Oss8fjmhHy6jqgJxCqUEQ8BII/4XGEDxPfgI0lQu4dyILb6h2LsfAUCmqs0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E458449871FF242B68BD5214ADBF1B4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b61e41e-9414-4284-f1d0-08d722a6b591
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2019 00:06:10.4689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqg//jLdxdVspuaHJgkER9g0irW65PLXLBApsFm49IzxyihvBHdKrt4O4UyerI3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160244
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvMTYvMTkgNDozNyBBTSwgSWx5YSBMZW9zaGtldmljaCB3cm90ZToNCj4+IEFtIDE2
LjA4LjIwMTkgdW0gMDI6MDUgc2NocmllYiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPjoNCj4+
DQo+Pj4gKyMgZGVmaW5lIF9fYnBmX2NvbnN0YW50X2JlNjRfdG9fY3B1KHgpCV9fX2NvbnN0YW50
X3N3YWI2NCh4KQ0KPj4NCj4+IGJwZl9lbmRpYW4uaCBpcyB1c2VkIGZvciBib3RoIGJwZiBwcm9n
cmFtIGFuZCBuYXRpdmUgYXBwbGljYXRpb25zLg0KPj4gQ291bGQgeW91IG1ha2Ugc3VyZSBpdCB3
b3JrcyBmb3IgYnBmIHByb2dyYW1zPyBJdCBzaG91bGQgYmUsIGJ1dCB3YW50IHRvDQo+PiBkb3Vi
bGUgY2hlY2suDQo+IA0KPiBZZXM6DQo+IA0KPiAjaW5jbHVkZSA8bGludXgvY29tcGlsZXJfYXR0
cmlidXRlcy5oPg0KPiAjaW5jbHVkZSAiYnBmX2VuZGlhbi5oIg0KPiB1NjQgYW5zd2VyKCkgeyBy
ZXR1cm4gX19icGZfY29uc3RhbnRfYmU2NF90b19jcHUoNDIpOyB9DQo+IA0KPiBjb21waWxlcyB0
bw0KPiANCj4gICAgICAgICAgcjAgPSAzMDI2NDE4OTQ5NTkyOTczMzEyIGxsDQo+ICAgICAgICAg
IGV4aXQNCj4gDQo+IG9uIHg4Ni4NCj4gDQo+PiBUaGUgX19jb25zdGFudF9zd2FiNjQgbG9va3Mg
bGlrZSBhIGxpdHRsZSBiaXQgZXhwZW5zaXZlDQo+PiBmb3IgYnBmIHByb2dyYW1zIGNvbXBhcmVk
IHRvIF9fYnVpbHRpbl9ic3dhcDY0LiBCdXQNCj4+IF9fYnVpbHRpbl9ic3dhcDY0IG1heSBub3Qg
YmUgYXZhaWxhYmxlIGZvciBhbGwgYXJjaGl0ZWN0dXJlcywgZXNwLg0KPj4gMzJiaXQgc3lzdGVt
LiBTbyBtYWNybyBfX2JwZl9fIGlzIHJlcXVpcmVkIHRvIHVzZSBpdC4NCj4gDQo+IElzbid0IF9f
X2NvbnN0YW50X3N3YWI2NCBzdXBwb3NlZCB0byBiZSAxMDAlIGNvbXBpbGUtdGltZT8NCj4gDQo+
IEFsc28sIEkgdGhpbmsgX19idWlsdGluX2Jzd2FwNjQgc2hvdWxkIGJlIGF2YWlsYWJsZSBldmVy
eXdoZXJlIGZvcg0KPiB1c2Vyc3BhY2UuIEF0IGxlYXN0IHRoZSBmb2xsb3dpbmcgdGVzdCBkb2Vz
IG5vdCBpbmRpY2F0ZSBhbnkgcHJvYmxlbXM6DQo+IA0KPiBmb3IgY2MgaW4gIng4Nl82NC1saW51
eC1nbnUtZ2NjIC1tMzIiIFwNCj4gICAgICAgICAgICAieDg2XzY0LWxpbnV4LWdudS1nY2MgLW02
NCIgXA0KPiAgICAgICAgICAgICJhYXJjaDY0LWxpbnV4LWdudS1nY2MiIFwNCj4gICAgICAgICAg
ICAiYXJtLWxpbnV4LWdudWVhYmloZi1nY2MiIFwNCj4gICAgICAgICAgICAibWlwczY0ZWwtbGlu
dXgtZ251YWJpNjQtZ2NjIiBcDQo+ICAgICAgICAgICAgInBvd2VycGM2NGxlLWxpbnV4LWdudS1n
Y2MgLW0zMiIgXA0KPiAgICAgICAgICAgICJzMzkweC1saW51eC1nbnUtZ2NjIC1tMzEiIFwNCj4g
ICAgICAgICAgICAiczM5MHgtbGludXgtZ251LWdjYyAtbTY0IiBcDQo+ICAgICAgICAgICAgInNw
YXJjNjQtbGludXgtZ251LWdjYyAtbTMyIiBcDQo+ICAgICAgICAgICAgInNwYXJjNjQtbGludXgt
Z251LWdjYyAtbTY0IiBcDQo+ICAgICAgICAgICAgImNsYW5nIC10YXJnZXQgYnBmIC1tMzIiIFwN
Cj4gICAgICAgICAgICAiY2xhbmcgLXRhcmdldCBicGYgLW02NCI7IGRvDQo+IAllY2hvICIqKiog
JGNjICoqKiINCj4gCWVjaG8gImxvbmcgbG9uZyBmKGxvbmcgbG9uZyB4KSB7IHJldHVybiBfX2J1
aWx0aW5fYnN3YXA2NCh4KTsgfSIgfCBcDQo+IAkkY2MgLXggYyAtUyAtIC1PMyAtbyAtOw0KPiBk
b25lDQo+IA0KPiBPbmx5IHNwYXJjNjQgZG9lc24ndCBzdXBwb3J0IGl0IGRpcmVjdGx5LCBidXQg
dGhlbiBpdCBqdXN0IGNhbGxzDQo+IGxpYmdjYydzIF9fYnN3YXBkaTIuIFRoaXMgbWlnaHQgbm90
IGJlIG9rIG9ubHkgZm9yIGtlcm5lbCBuYXRpdmUgY29kZQ0KPiAodGhvdWdoIGV2ZW4gdGhlcmUg
d2UgaGF2ZSBlLmcuIGFyY2gvYXJtL2xpYi9ic3dhcHNkaTIuUyksIGJ1dCBJIGRvbid0DQo+IHRo
aW5rIHRoaXMgaGVhZGVyIGlzIHVzZWQgaW4gc3VjaCBjb250ZXh0IGFueXdheS4NCg0KR3JlYXQg
dG8ga25vdy4gTWF5YmUgd2UgY2FuIGRlZmluZQ0KICAgIF9fYnBmX2JlNjRfdG9fY3B1ICAvLyB1
c2luZyBfX2J1aWx0aW5fYnN3YXA2NA0KICAgIF9fYnBmX2NvbnN0YW50X2JlNjRfdG9fY3B1ICAg
Ly8gdXNlIHlvdXIgYWJvdmUgZGVmaW5pdGlvbg0KICAgIGJwZl9iZTY0X3RvX2NwdSh4KSAgIC8v
IGNoZWNrIHdoZXRoZXIgeCBpcyBfX2J1aWx0aW5fY29uc3RhbnRfcCgpDQogICAgICAgICAgICAg
ICAgICAgICAgICAgLy8gb3Igbm90LCBhbmQgdGhlbiBjYWxsIHRoZSBhYm92ZSB0d28uDQoNCmJw
Zl9iZTY0X3RvX2NwdSgpIGNhbiBiZSB1c2VkIGluIHRlc3Rfc3lzY3RsLmMuDQoNCj4gDQo+Pj4N
Cj4+PiAgIAkJCUJQRl9NT1Y2NF9SRUcoQlBGX1JFR18xLCBCUEZfUkVHXzcpLA0KPj4+IEBAIC0x
MzQ0LDIwICsxMzc5LDI2IEBAIHN0YXRpYyBzaXplX3QgcHJvYmVfcHJvZ19sZW5ndGgoY29uc3Qg
c3RydWN0IGJwZl9pbnNuICpmcCkNCj4+PiAgIHN0YXRpYyBpbnQgZml4dXBfc3lzY3RsX3ZhbHVl
KGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGJ1Zl9sZW4sDQo+Pj4gICAJCQkgICAgICBzdHJ1Y3Qg
YnBmX2luc24gKnByb2csIHNpemVfdCBpbnNuX251bSkNCj4+PiAgIHsNCj4+PiAtCXVpbnQzMl90
IHZhbHVlX251bSA9IDA7DQo+Pj4gKwl1aW50NjRfdCB2YWx1ZV9udW0gPSAwOw0KPj4+ICAgCXVp
bnQ4X3QgYywgaTsNCj4+Pg0KPj4+ICAgCWlmIChidWZfbGVuID4gc2l6ZW9mKHZhbHVlX251bSkp
IHsNCj4+PiAgIAkJbG9nX2VycigiVmFsdWUgaXMgdG9vIGJpZyAoJXpkKSB0byB1c2UgaW4gZml4
dXAiLCBidWZfbGVuKTsNCj4+PiAgIAkJcmV0dXJuIC0xOw0KPj4+ICAgCX0NCj4+PiArCWlmIChw
cm9nW2luc25fbnVtXS5jb2RlICE9IChCUEZfTEQgfCBCUEZfRFcgfCBCUEZfSU1NKSkgew0KPj4+
ICsJCWxvZ19lcnIoIkNhbiBmaXh1cCBvbmx5IEJQRl9MRF9JTU02NCBpbnNucyIpOw0KPj4+ICsJ
CXJldHVybiAtMTsNCj4+PiArCX0NCj4+Pg0KPj4+ICAgCWZvciAoaSA9IDA7IGkgPCBidWZfbGVu
OyArK2kpIHsNCj4+PiAgIAkJYyA9IGJ1ZltpXTsNCj4+PiAgIAkJdmFsdWVfbnVtIHw9IChjIDw8
IGkgKiA4KTsNCj4+PiAgIAl9DQo+Pj4gKwl2YWx1ZV9udW0gPSBfX2JwZl9sZTY0X3RvX2NwdSh2
YWx1ZV9udW0pOw0KPj4NCj4+IENhbiB3ZSBhdm9pZCB0byB1c2UgX19icGZfbGU2NF90b19jcHU/
DQo+PiBMb29rIGxpa2Ugd2UgYWxyZWFkeSBoYXZpbmcgdGhlIHZhbHVlIGluIGJ1ZiwgY2FuIHdl
IGp1c3QgY2FzdCBpdA0KPj4gdG8gZ2V0IHZhbHVlX251bS4gTm90ZSB0aGF0IGJwZiBwcm9ncmFt
IGFuZCBob3N0IGFsd2F5cyBoYXZlDQo+PiB0aGUgc2FtZSBlbmRpYW5uZXNzLiBUaGlzIHdheSwg
bm8gZW5kaWFubmVzcyBjb252ZXJzaW9uDQo+PiBpcyBuZWVkZWQuDQo+IA0KPiBJIHRoaW5rIHRo
aXMgbWlnaHQgYmUgZGFuZ2Vyb3VzIGluIGNhc2UgYnVmIGlzIHNtYWxsZXIgdGhhbiA4IGJ5dGVz
Lg0KDQpJbnN0ZWFkIG9mIGNhbGN1bGF0aW5nIHRoZSB2YWx1ZV9udW0gYXMgdGhlIGFib3ZlLCBt
YXliZSB3ZSBjb3VsZA0KZG8gc29tZXRoaW5nIGxpa2UgYmVsb3c6DQoNCiAgICAgICB1bmlvbiB7
DQogICAgICAgICAgICAgICB1aW50OF90IHZhbHVlc1tzaXplb2YoX191NjQpXTsNCiAgICAgICAg
ICAgICAgIF9fdTY0IHZhbDsNCiAgICAgICB9IHUgPSB7fTsNCg0KICAgICAgIG1lbWNweSh1LnZh
bHVlcywgYnVmLCBidWZfbGVuKTsNCg0KICAgICAgIC8qIHUudmFsIHNob3VsZCBob2xkIGEgdTY0
IHZhbHVlIHdoaWNoIHlvdSBjYW4gdXNlDQogICAgICAgICogZm9yIExEX0lNTTY0IGNhbiB1c2Uu
DQogICAgICAgICovDQo=

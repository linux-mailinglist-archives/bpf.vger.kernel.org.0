Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41435F27C4
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 07:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfKGGth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 01:49:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26868 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfKGGth (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 01:49:37 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA76jEb2008644;
        Wed, 6 Nov 2019 22:49:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pwxwhI2lsuP2MNptKAPIV33mn1mW52MNP3jznD8m34c=;
 b=HCVnKv5hk0WklL3uTfcvPpV85CJNM86TEKhpMDzPxl2u+QfCh2zWGq+0x1+bQQ8aXSI+
 ODh1w0+bZfTcroNPrywiW2w4jeHfCYObhkQzTscHNg7kAvUBH5v/cF9gvMWVb8RKVLOm
 Tl9ItTqrXH3WEYUdpdK/tJSlifnviEQMOP0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41ujbnrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Nov 2019 22:49:34 -0800
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 22:49:33 -0800
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 22:49:32 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 22:49:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqjlZj9c8AgR9yEOV/A6D4yeGf7bmIP7fBYqliaiaDo3pl9vgqZB621fqyEKAbzd2izszV397pBRakOZio8YZwPHm5N1Jvi1GBAB2lGn4piznU6Lb7f0V+2D/Q7q50LuMdDSJzwHzkh0DtEeCeqx+z/+aY9IIribs5UfKapeqGZ9ufcMYT6P6aH41xqq9DVrdvdDOpCS1nrH9FcH38Zb/7+Azv1RbsG62P3iW30B5ruQ1IDDD3WbNi9mko7WQn5iVQlWROQjjOzBv/2BZ9LTtg3a8dwWyvM12tmqivSaz8oFn3uC2aD5kgo4d+xNAyy6E0di8ZXnT5c8n/AsZmU5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwxwhI2lsuP2MNptKAPIV33mn1mW52MNP3jznD8m34c=;
 b=jUijaOHG+ooqGNHUwgl/Uw5MCA3AmoE4DohMzRjngo0jpSlcwctldm+95B/hjti+yuId9FLUwfFRrxMKxBl2Ug5ogGooialc60vvobmw8VFFT8erYrAleEn12z62y3MG1+x981dt3opjEwoAJiM+UnnOeSP/jupneAhrEldnYpPGW/wuzxkrp9nO5lXTRbk4lbHsTjHBbV0QlG/bq4UDe2PaRsD9db+jabLVziW9riJ+gxrYS0iDARCpeAjvKmA4nayxyEU93kwFIJOTz0FusJz41R794wm1BvT6TDFDICPAyPOjQBoQ8SPTCydiGpyPs9Dot3rLrIu4JCWfF3AeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwxwhI2lsuP2MNptKAPIV33mn1mW52MNP3jznD8m34c=;
 b=FBPPZGGU/NmyBmHPve1RqhwwOYgg2eShbh0niYq7ASX157x89RIIJmh6bT+71a36ZLnpvhIY2GBqFoia+jIcR+SXznqpi2WkSPQupBpX5GtaoAjlXyIqQMgf5Msn2t2thaZY9jUMGzB3K9qIpoJcdRKQoC4Io1FFfduVUrqz3UE=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2550.namprd15.prod.outlook.com (20.179.155.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 06:49:31 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d%5]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 06:49:31 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: initiated discussion to support attribute address_space in clang
Thread-Topic: initiated discussion to support attribute address_space in clang
Thread-Index: AQHViovtf36A5WULmUOUs3re8NDO8Kd63jufgAR7ngA=
Date:   Thu, 7 Nov 2019 06:49:31 +0000
Message-ID: <c75d6a0e-2519-e229-113a-533659318ae7@fb.com>
References: <87lfutgvsu.fsf@oracle.com>
 <79a43f7f-b463-5f40-7830-f488d178b0a4@fb.com> <87tv7kyma9.fsf@oracle.com>
In-Reply-To: <87tv7kyma9.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:104:4::25) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::3750]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10746c59-23a8-44d1-83e7-08d7634ea432
x-ms-traffictypediagnostic: BYAPR15MB2550:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR15MB2550BEADCF3220EB191D5DF1D3780@BYAPR15MB2550.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(346002)(396003)(39860400002)(136003)(199004)(189003)(6116002)(478600001)(6916009)(2906002)(561944003)(386003)(186003)(316002)(4326008)(53546011)(99286004)(31686004)(14454004)(52116002)(25786009)(102836004)(305945005)(966005)(76176011)(7736002)(229853002)(71200400001)(256004)(71190400001)(14444005)(36756003)(11346002)(8936002)(2616005)(476003)(486006)(6506007)(6436002)(81156014)(66446008)(64756008)(6246003)(5660300002)(66946007)(66556008)(8676002)(31696002)(81166006)(6306002)(86362001)(46003)(66476007)(6512007)(446003)(6486002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2550;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnm+jZPYgdmDk6elgSdddshUrwtslZ2Yn4RNr4I0qJONJNt8RaFOc5OEQ0Po/Xr2pPT1aZeoakuEZ5Cscqin5JwNaVJnxNX/JF05lSbhjNq3kWqoJEfMulfGPUOA2vlyfrzSI94kvlg2iewnYDEH/riNkcAnY02v3R4qOP24Bs72jBpfFqRb27t30FeOREiTVzg+mCx/7XPKB3UT45rqwJZescKN82caK3sP14Py1s9QwyWCZbUEwljDiQY3x5x90L9BPDLmq8SPTOapo5e4Pikim2x4Un2VqeMD01ucOfhlq+KGdYHlwKXoXfmFOo7QGQYUpfJDtE6ZUibQQs+fuGaaYlhMKd33QLyNJDZ1xpoHFz6N/JBxZbM0EWLpLsUQG/AEm9py1r5d83N6mKqlbenhP4zLVAgAaKZ1i1DYto09N+nYUgltzjkRC4gwZD5krcpN3Yk7BLOdQhpML8hElkMW4rjPaoWKSdBM2nJWTcY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E663060C5CDCF49A559EAF5DFE0C7F1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10746c59-23a8-44d1-83e7-08d7634ea432
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 06:49:31.2495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chnm+dZxlE7eBTORIlTMKiAV1y5H3LHUHoML9beTKVP5gPJwriODrw7AdFZ/H9wi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2550
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_09:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070068
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDExLzQvMTkgMjoyMSBBTSwgSm9zZSBFLiBNYXJjaGVzaSB3cm90ZToNCj4gDQo+IEhp
IFlvbmdob25nLg0KPiAgICAgIA0KPiAgICAgIEkganVzdCBpbml0aWF0ZWQgYSBkaXNjdXNzaW9u
IChSRkMgcGF0Y2gNCj4gICAgICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIv
dXJsP3U9aHR0cHMtM0FfX3Jldmlld3MubGx2bS5vcmdfRDY5MzkzJmQ9RHdJQkFnJmM9NVZEMFJU
dE5sVGgzeWNkNDFiM01VdyZyPURBOGUxQjVyMDczdklxUnJGejdNUkEmbT1IVlpPM2JJR2pqd3N6
Zmh0UE1PN0J4Y1E4RzNxMHpsNFlXQmxrdU5Ud29FJnM9M1N6a1NsakVtdk1NcnlkMjR3OVVZWjMt
V3M2M1hWOHNFSVdzZ1RfWERtSSZlPSApIGZvciBsbHZtL2NsYW5nIHRvIHN1cHBvcnQgdXNlcg0K
PiAgICAgIGFkZHJlc3Nfc3BhY2UgYXR0cmlidXRlLg0KPiAgICAgIA0KPiAgICAgIEkgYW0gbm90
IGFibGUgdG8gYWRkIHlvdXIgbmFtZSBpbiBzdWJzY3JpYmVyIGxpc3QgYXMgeW91IHByb2JhYmx5
DQo+ICAgICAgbm90IHJlZ2lzdGVyZWQgd2l0aCBsbHZtIG1haWxpbmcgbGlzdCBvciBwaGFicmlj
YXRvci4NCj4gICAgICANCj4gICAgICBKdXN0IGxldCB5b3Uga25vdyBzbyB3ZSBjYW4gaGF2ZSBh
biBldmVudHVhbCBwcm9wb3NhbCB3aGljaA0KPiAgICAgIHdpbGwgYmUgYWxzbyBnb29kIGZvciBn
Y2MuIFBsZWFzZSBwYXJ0aWNpcGF0ZSBpbiBkaXNjdXNzaW9uLg0KPiANCj4gVGhhbmtzIGZvciBy
ZWFjaGluZyBvdXQsIGFuZCBzb3JyeSBmb3IgdGhlIGRlbGF5IGluIHJlcGx5aW5nOiBJIG5lZWRl
ZA0KPiBzb21lIHRpbWUgdG8gcHJvY2VzcyBteSBiYWNrbG9nIGFmdGVyIGEgY291cGxlIG9mIHdl
ZWtzIG9mZi4NCj4gDQo+IEkganVzdCBjcmVhdGVkIGFuIGFjY291bnQgaW4gcGhhYnJpY2F0b3Ig
KGplbWFyY2gpLiAgV2lsbCBmb2xsb3cgdXANCj4gdGhlcmUuDQoNClNvdW5kcyBnb29kLiBKdXN0
IGxldCBtZSBrbm93IG9yIGNvbW1lbnQgb24gdGhlIHBhdGNoIGlmIHlvdSBoYXZlIHNvbWUgDQpp
ZGVhcyBob3cgdGhpbmdzIHNob3VsZCBiZSBkb25lIGluIG9yZGVyIGZvciBnY2MgdG8gc3VwcG9y
dCB0aGUgZmVhdHVyZS4NCg0KVGhhbmtzIQ0KDQo+IA0KPiBTYWx1ZCENCj4gDQo=

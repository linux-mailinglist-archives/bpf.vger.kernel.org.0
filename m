Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6539E49D1E0
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 19:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiAZSjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 13:39:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40562 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbiAZSji (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 13:39:38 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QDT75c006632;
        Wed, 26 Jan 2022 10:39:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EdTwoe9vKtcCuzh8chV3k8F3zi0ZtM1YTTnX0WoxTeg=;
 b=Pfr93U9892funhRPOHVIsn9oT0/sC4/pWXB8ocDNVOGy9iTo44gnmFLK9NI/PBtz5lUp
 qqDn13LGQ/cBelNYoQ/zHD2iM3N1+UyW5xUGZ/HbLspSl16ml+X30uDhR8BgsgSwpb0n
 vGDBlHkmGkykD8+GKffbT+LmJKGb4gGU84w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtrpf68rr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Jan 2022 10:39:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 10:39:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG6wa4QXghOsyD8UYgm6F/CTimPYUGk2fiJ4ScKljRU6JgtKrSC0+i0z5KIXlEDPG2rCorSQbuMqe8bXTn4nEOjBbmB14/OeLWRN33I7EdYKUsaZnHjBtjcvFEJOEOs7mb5FbUdG3nMSApRqKsa0ZokTKSvXDniIcoO9MEllJ6pLFXHL0nMRQaVE9KMpQjFpvfH4afapyWB9u+Ejv7BRmABi2S69Y1+uptcATBFr6E3mbWEBWToK+SbOtX77aPpqCOHPUH6MRWj7GVPdm5jZA+UvC09rgKGGQA4W43jCIgNjMB89DBoWk+/2D4JYEvXBxNuDmVOMwN9p/8SIY8E6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdTwoe9vKtcCuzh8chV3k8F3zi0ZtM1YTTnX0WoxTeg=;
 b=TAdyikPXFhbj75fp1tB2stVDQZAejcZw878IbsjfhF0eMEg5n5QcQ+thueQJg+s8/QyrMjvLTFIGCeJgmcG39/JMvMSGCAp9orOZ8NXAxYk8sd1LT9fPSGPZmB/R/6pKcP6g/nH7wVapceeZs6SFEFhseYQxaowYvkzh35ugVY+kWoH0ZY2+EMszyaaWU9vAGlcGe2H6U3j56xwphg/YRiWIiOKr/z/mnQMCW8cWR0RShcXugfe57oO93mPh5J6YUzKET7XeF6yHJa87YjgJfbUNauhoglfOsD9MHEPjILGAZWIVvXiPs1WZL8J5OSGoJHaqK74tdxdVJV0/+mnltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by CH2PR15MB3640.namprd15.prod.outlook.com (2603:10b6:610:7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 26 Jan
 2022 18:39:35 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 18:39:35 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v3 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
Thread-Topic: [PATCH dwarves v3 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
Thread-Index: AQHYEmo3NPDDDRKYR0u1uamtuCgIkqx00RsAgADSMAA=
Date:   Wed, 26 Jan 2022 18:39:35 +0000
Message-ID: <624acf82a7c43ca0f9b0203a77b13fa6539ce967.camel@fb.com>
References: <20220126040509.1862767-1-kuifeng@fb.com>
         <20220126040509.1862767-4-kuifeng@fb.com>
         <CAEf4BzYsjsWZASrF0rjBYion7nL7L9gRvGm_VJ7-1Ojds34b=A@mail.gmail.com>
In-Reply-To: <CAEf4BzYsjsWZASrF0rjBYion7nL7L9gRvGm_VJ7-1Ojds34b=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 596d5e73-3a03-474e-f453-08d9e0fb3365
x-ms-traffictypediagnostic: CH2PR15MB3640:EE_
x-microsoft-antispam-prvs: <CH2PR15MB3640A83FAA56ABA379CB8DA4CC209@CH2PR15MB3640.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: il1P6afhqdb8XdBen/XcpFmIinuBIlvYROkb9DZcBqgCK7cglYMGcTGarHMEfYDrxWWBRxmmMSkPLoEKBvrUt02agQyYVvWZw1Ss7e+jdCoVLN+ZVyFz/yI8vOBfikYNcLkN37qmFsv/KV5b+AMvzPTYCE314THqDuVCKTcvsiXHFvyAraoPS7xP2PHdIYw8mdu9vxrmIhxqfTl6B71XsbOwM/DvwHpRFsddmRtBpdtG2C0dk5ygs36VyNnO6DnHI4RCwF7lyZDegwmPoIY/6TgH3fi4DbVrjUDcXSV01zV9auc6FWIrZ4muWKC5MSkrf5IV9zlL+cKsxEaeo+DR6dY/8DylSzeBSho8TE497CafcHu2u2BAcF2HgjqGfUl+wTBAMXXPO0O/vJ7lpISQ7x99nycsFjPmt2EMLAYwWocTNtZwTL9mymSS/BB/9xTE+GLPkELSpEnOn+90wK1jH7/17ZYdFJowHTpEF2gXQwIkXdl12LqOe1qQtMzVP2/2uCnT33uY8tYUt9NYUkca6kY9vKXV9xuX3cESc57qe2xn+9CiIxRchPuGC76VR3f3t/5C6poPyIce4XdqiVSX7yfXwAtWBMDDu0/5qZuMM8QPK+sxh7e+qurnNHREmCOqEWowfhscH8arh2JQC6/InPaBCpnEwMgKKAx/EneXbJSfxfmllTmv36/dDoWGayvldT4hfNJqmXKTax0eacKwqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(66946007)(6486002)(2616005)(36756003)(76116006)(53546011)(2906002)(508600001)(5660300002)(71200400001)(6506007)(66556008)(4326008)(8676002)(54906003)(6916009)(316002)(38070700005)(66476007)(66446008)(64756008)(83380400001)(8936002)(186003)(38100700002)(86362001)(122000001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDZFVWdvMUo5YmtyMFB5RkUrQXlDdVkxZzNGMG16MHNST0hMZXdQWG9ycUJL?=
 =?utf-8?B?cnROei9qc2tiRVM2MGQ5Sk9NSWJmZlNBek94bmY3YzRFcVBqZTZCSHM1cHBJ?=
 =?utf-8?B?OFNTc3pIM0VxdGZtVXNtdE5VdDVzSHFxM1ZYNGZWYTh5dy94dlFHS3JZMENs?=
 =?utf-8?B?T1duL2RYV085UU5NUmdLL3JpWnE5elM3MFArcFN3OFg3c1pGN2dhVDN0bzFx?=
 =?utf-8?B?eFZLZTNtUzBLdit1Y1ZCUlpQZ2JWbXJ4Q2RrQkhSWkVrNmJaL3c4K0lWUG9j?=
 =?utf-8?B?RE5aeWVYWlpFbzZ4RXdhSDVHS0ZSNlhQTzlBSndGWiszNjh0S0hSREZINEZ2?=
 =?utf-8?B?ellMRDZZa3B3d2swR3h6QVRBZGcyRk1Makw3SGZ4ckQ0YTBBaklLQUNib0R0?=
 =?utf-8?B?OWR5VTNGQ0pLVXdTdzIzVDhzaDFKWStGU2FET3FKMjZ1czh5SHFLTTFDKzFz?=
 =?utf-8?B?RkxqRW11MXVEd0dVcCs3N3Ruc1NkeWMxeE1ESnE3WjIrOEl6QU5rbWwwUWZp?=
 =?utf-8?B?bzdpeEc3YWErT1phTHNnNmpQMVhnRDZTNE0xdWpPb2lFMEF1eHgrTEtHVk8r?=
 =?utf-8?B?NGZiRHNwVFJ2aVNCUG9TcElDZ2F4Vi81WHdTai80Q3UyazFYRi9LYzJXbm1r?=
 =?utf-8?B?ZEJ3TlgxMGUrQ0dDSm15R2N2bS9uVlBkZ0ZmZkxub0dJU25GNk1zTVNCeEx6?=
 =?utf-8?B?RU82bGJNekVBWUNjajBZUUN0MjFBTFcyMzl5NTczQXFVaWNSYVhSd0RHY3Bp?=
 =?utf-8?B?cWpIT3pZWVpUbFFrZTFKU1ZPY0RYLzVUc0Y1dVpZTmx4SjVGRy9VL09idER3?=
 =?utf-8?B?a1JhLzQ4ZjBQVHdvalEraDV3SW5tMUxaTFoyTXdBdncyRVRVYjBneXdxRkc0?=
 =?utf-8?B?SzVrQlFSRThSU0liY2pYbHVudVVaQ0ZkTkFXWEd1akJBZDd2M0tnMDVXN0x6?=
 =?utf-8?B?UXJrWkVUN2ZNOS9FVkVMQUFPeFlHNU1xcXBRaGRJOWZpTXh2aWt5OHFaVzk4?=
 =?utf-8?B?b2xoc0JPdFNJRUNJSW9OU1lGN0JVb21tL2dacm90MURZMG40SVd6eHg3SVFR?=
 =?utf-8?B?Vk5VVG80bDZMQ2wvclRUNjRQc2ZVK2UzOTc4alM1c2VuWGRjSTlvMXFRaGY5?=
 =?utf-8?B?cERrUjBtU1ptOG9DNGVOMSsxQk1nb1BVUFlhdHZBV054QUpHdjd1UVozWGxr?=
 =?utf-8?B?Si9KLy9xc0YrRHZGbXphdkFLM3B6cE1HVFpnK1IrU2lXQ0UzUHAyVy9QQXBS?=
 =?utf-8?B?ZWtMSzByMWhYSXZxRWtadm9NM3hNL1NHdTJIenNpWU9WdnVMN1JZeXJpRVRN?=
 =?utf-8?B?Rkxwd1JRS0U5dVZaQWM5ZHVQMGY3am90eU8zbWFkSnZNMnRsdXBsUGhGYXRK?=
 =?utf-8?B?V3psOVY2ams4VzU1dkREU1E3eWg0SFZ2aVRCRkIvU1A5RmE3dUxqbWpjODR0?=
 =?utf-8?B?cFpRdVBtSzlTM1RUYTcremovOGJLTGxIZ2ZXdlVkTURxVVBkdFZvb2kvcnNz?=
 =?utf-8?B?QkJKNDRtd01obUxoLzlhUTQza3pMTmN3d1NCcEdrR21lTmg3UEI5SENuTzBw?=
 =?utf-8?B?VHVpaU1pZW9zK0RsTkhSWlIvTUtSbW1Lb3QrZmdGby9Gd21ISkpmRXduOGRh?=
 =?utf-8?B?NGxjbEdJRGJ4bklBazJ2emNEeUpKOFlWRUtZS0V1VTNSd0hhNzkxOTJ0NXhz?=
 =?utf-8?B?RndxZnZRSnd4dmJSYjhkakdTT1RaYVNtL3RFS0htUC9tb2pSWnJhOUc4MWtG?=
 =?utf-8?B?Z2ZsR2JFNFh3YXlsOWVNT3hUMHJuL2s2Tmk3NWxFV2NxRDhpZW51aVVoMXNI?=
 =?utf-8?B?K2FOQ080bm5qOTZWZUlFOFZPZFlmNDc5empYZWM1RGROVS95WHNHb0E0Zm1F?=
 =?utf-8?B?VTQ3dU5HbnovS3MyOTI1VlViQnZXUXdHZ3ZkQVlESHhPN3EwUWpSSXNscldO?=
 =?utf-8?B?L1YrL2MvRlpPSVd0TGdwcmlXUFdNUmp3S2EzSEVyd3ZqUnppN2phVXBkcTJ4?=
 =?utf-8?B?ZmNnOUVJeXhMUjJXdDZXTWt0Z0dKbDNWclh0dmhJdlA3SnFRSnRWbGhKcVI3?=
 =?utf-8?B?dDBPbHp1KzQwRFl6aDQ2Tnh0MVE2dlBTSEZpdVY3aTRmTmVQL2Jvd1B6N3du?=
 =?utf-8?B?dmNNdzNZc21UZjZDV0dtYkxSUVIvWk5ZMktLakNmV1VVMThOOTFWeFllekZK?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AE63DD903849F4AB2D3326B01BB05AC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596d5e73-3a03-474e-f453-08d9e0fb3365
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 18:39:35.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iE/ZMKCAKLSuWhG19KI95xpNJ0x7Cbi6CP6ALQ8irLzSp8cs6T1CGQEwjPwkvsEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3640
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JN1w0HW-dp5oL2iMF-agqSIJdgY_5ehQ
X-Proofpoint-ORIG-GUID: JN1w0HW-dp5oL2iMF-agqSIJdgY_5ehQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_06,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTAxLTI1IGF0IDIyOjA3IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFR1ZSwgSmFuIDI1LCAyMDIyIGF0IDg6MDcgUE0gS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQ3JlYXRlIGFuIGluc3RhbmNlIG9mIGJ0ZiBmb3Ig
ZWFjaCB3b3JrZXIgdGhyZWFkLCBhbmQgYWRkIHR5cGUgaW5mbw0KPiA+IHRvDQo+ID4gdGhlIGxv
Y2FsIGJ0ZiBpbnN0YW5jZSBpbiB0aGUgc3RlYWwtZnVuY3Rpb24gb2YgcGFob2xlIHdpdGhvdXQN
Cj4gPiBtdXRleA0KPiA+IGFjcXVpcmluZy7CoCBPbmNlIGZpbmlzaGVkIHdpdGggYWxsIHdvcmtl
ciB0aHJlYWRzLCBtZXJnZSBhbGwNCj4gPiBwZXItdGhyZWFkIGJ0ZiBpbnN0YW5jZXMgdG8gdGhl
IHByaW1hcnkgYnRmIGluc3RhbmNlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEt1aS1GZW5n
IExlZSA8a3VpZmVuZ0BmYi5jb20+DQo+ID4gDQouLi4uLi4uLi4uLi4gY3V0IC4uLi4uLi4uLi4u
DQo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgdGhyZWFkX2RhdGEgKnRocmVhZCA9IHRocl9kYXRh
Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIGlmICh0aHJlYWQgPT0gTlVMTCkNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiArDQo+ID4gK8KgwqDCoMKg
wqDCoCAvKg0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIEhlcmUgd2Ugd2lsbCBjYWxsIGJ0Zl9fZGVk
dXAoKSBoZXJlIG9uY2Ugd2UgZXh0ZW5kDQo+ID4gK8KgwqDCoMKgwqDCoMKgICogYnRmX19kZWR1
cCgpLg0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqLw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIGlm
ICh0aHJlYWQtPmVuY29kZXIgPT0gYnRmX2VuY29kZXIpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAvKiBSZWxlYXNlIHRoZSBsb2NrIGFjdXFpcmVkIHdoZW4gY3JlYXRlZA0K
PiA+IGJ0Zl9lbmNvZGVyICovDQo+IA0KPiB0eXBvOiBhY3F1aXJlZA0KPiANCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdGhyZWFkX211dGV4X3VubG9jaygmYnRmX2VuY29kZXJf
bG9jayk7DQo+IA0KPiBTcGxpdHRpbmcgcHRocmVhZF9tdXRleCBsb2NrL3VubG9jayBsaWtlIHRo
aXMgaXMgZXh0cmVtZWx5IGRhbmdlcm91cw0KPiBhbmQgZXJyb3IgcHJvbmUuIElmIHRoYXQncyB0
aGUgcHJpY2UgZm9yIHJldXNpbmcgZ2xvYmFsIGJ0Zl9lbmNvZGVyDQo+IGZvciBmaXJzdCB3b3Jr
ZXIsIHRoZW4gSSdkIHJhdGhlciBub3QgcmV1c2UgYnRmX2VuY29kZXIgb3IgcmV2ZXJ0DQo+IGJh
Y2sNCj4gdG8gZG9pbmcgYnRmX19hZGRfYnRmKCkgYW5kIGRvaW5nIGJ0Zl9lbmNvZGVyX19kZWxl
dGUoKSBpbiB0aGUgbWFpbg0KPiB0aHJlYWQuDQo+IA0KPiBQbGVhc2UgcXVlc3Rpb24gYW5kIHB1
c2ggYmFjayB0aGUgYXBwcm9hY2ggYW5kIGNvZGUgcmV2aWV3IGZlZWRiYWNrDQo+IGlmDQo+IHNv
bWV0aGluZyBkb2Vzbid0IGZlZWwgbmF0dXJhbCBvciBpcyBjYXVzaW5nIG1vcmUgcHJvYmxlbXMg
dGhhbg0KPiBzb2x2ZXMuDQo+IA0KPiBJIHRoaW5rIHRoZSBjbGVhbmVzdCBzb2x1dGlvbiB3b3Vs
ZCBiZSB0byBub3QgcmV1c2UgZ2xvYmFsIGJ0Zl9lbmNvZGVyDQo+IGZvciB0aGUgZmlyc3Qgd29y
a2VyLiBJIHN1c3BlY3QgdGhlIHRpbWUgZGlmZmVyZW5jZSBpc24ndCBiaWcsIHNvIEknZA0KPiBv
cHRpbWl6ZSBmb3Igc2ltcGxpY2l0eSBhbmQgY2xlYW4gc2VwYXJhdGlvbi4gQnV0IGlmIGl0IGlz
IGNhdXNpbmcNCj4gdW5uZWNlc3Nhcnkgc2xvd2Rvd24sIHRoZW4gYXMgSSBzYWlkLCBsZXQncyBq
dXN0IHJldmVydCBiYWNrIHRvIHlvdXINCj4gcHJldmlvdXMgYXBwcm9hY2ggd2l0aCBkb2luZyBi
dGZfX2FkZF9idGYoKSBpbiB0aGUgbWFpbiB0aHJlYWQuDQo+IA0KDQpZb3VyIGNvbmNlcm5zIG1h
a2Ugc2Vuc2UuDQpJIHRyaWVkIHRoZSBzb2x1dGlvbnMgdy8gJiB3L28gcmV1c2luZyBidGZfZW5j
b2Rlci4gIFRoZSBkaWZmZXJlbmNpZXMNCmFyZSBvYnZpb3VzbHkuICBTbywgSSB3aWxsIHJvbGxi
YWNrIHRvIGNhbGxpbmcgYnRmX19hZGRfYnRmKCkgYXQgdGhlDQptYWluIHRocmVhZC4NCg0Kdy9v
IHJldXNpbmc6IEFWRyA1Ljc4NDY3IFA1MCA1Ljg4IFA3MCA2LjAzIFA5MCA2LjEwDQp3LyAgcmV1
c2luZzogQVZHIDUuMzA0IFA1MCA1LjEyIFA3MCA1LjE3IFA5MCA1LjQ2DQoNCg0KDQo=

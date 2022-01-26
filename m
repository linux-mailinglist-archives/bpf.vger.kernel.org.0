Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9449D346
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 21:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiAZUOm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 15:14:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230233AbiAZUOm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 15:14:42 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QE75wg022429;
        Wed, 26 Jan 2022 12:14:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zunpZC3Ew2UnMnc2t4typQyd/KuKyZ4Ff80hVaqE/os=;
 b=ib/3OyGx+FFxYdD5Diq7flAneGYnFAVZRHlAJHMA5q+JBtw2/8jHeD8AHcB+akejpdxz
 rYXqRHLcWMT7PZSY+tthl0VrN7etTVeTabKH7BSok5vjadAiv4fMjmq0GAjguigpbs2j
 ZVqUUi/Q50LMisqwonBUVzdRcmmFhGGpnJg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtfjgjq5t-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Jan 2022 12:14:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 12:14:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7Q0nDEV9fUEHoShK/uB0WhbH5tD4H+YYp+oi0ia3vSWN2mKIeB5kr6RlZKSgp/h2CJiJMU5yhCWmlrx0REnzgXHCxZl+te6qbUsMP5Hw+cG44uvzkTSfQXrfvjwiiABxVGq3heCut2u0FzMAMYbtSfOUUASjKXBP3o/ZmGXnDz/nrtj4dQOEBxTI7Iwr+1Rff70+6E0Q9D3p2t/wMCXQJf1CLajT6RE5bdOFTJWXbr4OvtHf+XRqCsPDd7d368CYGz2lVQVAH4RFTGB7zrb9fHgXVfTNJ694zkvPSumPs91aow9MN5rTe59ptXVy8SphS68vt3x3nXDslo1Pk2VOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zunpZC3Ew2UnMnc2t4typQyd/KuKyZ4Ff80hVaqE/os=;
 b=aAMlObPc6OUpiPb1FsVTcbGq1RkO3nsEts340XUZFQEbnNJUk/lJluuVOuzibixC40SMb8AwRopGmPcq4y3JE+BDuxFKbrIEZU3qR8jO9q/EvVacUtt1zxfw9xQRpSdZjDVYWIa8LP4/gXfEmtVuvQ+RzJMQD/+2s4ZPg+ooV9z+e3dwH0qJgAVl2sU/xYjAPd1zI/RkgHMDpNtXD9er5b6dX1o/nWHjTZQZEHzm2j0OgZGrXhAvhSSnU+COtH1MjnasHtpvrpgrYoO5/Y3vlMird+3GJIpuRuhxE+q4ePghMfJJhPZmAPLl+Y07ZPPsfohVyRYWDOTpK0YXWfU6mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BYAPR15MB2838.namprd15.prod.outlook.com (2603:10b6:a03:b4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 20:14:38 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 20:14:38 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
Thread-Topic: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
Thread-Index: AQHYEunVOisdcUIjZ0CcgaB8+KOaz6x1t32AgAAFXoA=
Date:   Wed, 26 Jan 2022 20:14:38 +0000
Message-ID: <d40bae209cf32312e0d6e882fa27514858b586b7.camel@fb.com>
References: <20220126192039.2840752-1-kuifeng@fb.com>
         <20220126192039.2840752-2-kuifeng@fb.com>
         <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
In-Reply-To: <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5a53a2d-2f9a-4a5a-d032-08d9e1087ab7
x-ms-traffictypediagnostic: BYAPR15MB2838:EE_
x-microsoft-antispam-prvs: <BYAPR15MB2838A7994D2074FBCE80934ECC209@BYAPR15MB2838.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vIrI6Y+eN9ejRspQxlFYBLX2wKJX2rJ5AG39gtGob0m81Rf1pseIRa2Jasny/z57jKkxzOeCrdZl6TWmSSFKt0fddqX5bxtcff+ZEJsH6gm2eC+iaHunsK1PhCw33EAqHGw/j3gZ3mv1GJQyACg5ziQ9s/0MPV09YkPr5OquefyCTCIUMPmaFNv5aMEo3f1m5+JhZraMoUBSThkQIgVDtYWNqEzshhMhx1VZYcne66h8l0TPE9Pwitaig6Cn2rR2nzxKpr8lTxmqiNsbMPh8rbIYWhbRfYFupdAb9S0Sd/IpvdPVXhIShpd/OvsdxsGeCnVrGjuO89hhc+ulioV1F0dzC0FkMQqJIbn119+CwrshLVp43eNkmj1h5mzKcC4ccmWHXpTLsQGpn+Q88jJzFtXH9Ayy7hG+0u/BqyoaSgpUCz1O/odHeLkL1F+nLRbnhcU15KpSVJelQhkleignkvZpdrYjcynUnQ1LRbBitNTggVbB3/dsseIrYbEh8J02Qo/DQX27i5tyeJwezwohItW+mf26dXoxkPDLgXGNN8TEv79PkhPs8YwQCVL2Tv3PxwsMz/viSG4gwTqE6TDR2VhaHxXfehW4RgQJpfCpfb7Vum+zXSmSJW4fQ/M8EJVXhoy0bgDpw44Dm1RjdnlqWaHRnPzbnEDkvJhs9I92RSyWzjqghn4gNYHTwMy+PXW84SrrVHu5bHIMxeaUzopYWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(122000001)(5660300002)(38100700002)(71200400001)(38070700005)(4326008)(36756003)(66446008)(66556008)(66476007)(66946007)(54906003)(6506007)(6916009)(316002)(64756008)(8936002)(76116006)(8676002)(6486002)(53546011)(508600001)(6512007)(86362001)(186003)(2616005)(2906002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnFWU3Y3SFlLdHJybGFNbTZxOHYzNnErTE1ZdCtKTDFqQ29Sc0RMdlJ1RTNw?=
 =?utf-8?B?TEo0V1ZNVnJubHlGcjR4dTRsNTNNY3B6dmhnU2FDMnpWMEhhMTUxK0FFNEVa?=
 =?utf-8?B?RHhaYi9yYmNucDBKdGdYQi8wOFBTZW5qNm40NkZvM3pPWHN6K21sYXNyUk9W?=
 =?utf-8?B?Sk4xdzloaXBUdTFncVJSRnVUZlc0WW9YRUpvM0dUdGJnYVJXL2NhTUpCcGt3?=
 =?utf-8?B?cGxWZ1RwalBKTG9lcWQ0dWN3Q01SNnFxNDdwbGMvRkVzUGZqY0FCRzJza203?=
 =?utf-8?B?RHBzUXZaR1N5SElzVWlvaFRXVW82bkd4VG44MHVCT29MYXRoOE5Dd0R5R0RJ?=
 =?utf-8?B?S3NQcFhwbjhqUTVxR0FMcEtBcWhyRmlXcGhlK0RKQmZxT2t0UUFmc05YSzFF?=
 =?utf-8?B?bk0vWnJzRXZhRHp0MjV1QjArQzhJa0ZYTXIrb29BYlJrUHFqTmFlRjAwKzly?=
 =?utf-8?B?Z0tBblVYSDBwK0hZZk1Ca3J5QzAwZHNmWHljRFE3ZU1LVVlRNnJRaU5SaEg3?=
 =?utf-8?B?aE5hUW9yWjZNM0psUkxtcGlvTU8wanRhSUplQm5XKzdZZFd3MmZFeHhUWGRt?=
 =?utf-8?B?Nm01ZktjL1lWNkdYcG9pNTlJamFWMFIvVlJLWnlIdCtnWHc4VU5xbExKTUk3?=
 =?utf-8?B?L2dWaDFZUlJvSUcybks2MjJCeVdzbld1YmpXM0QzWVlNMVRNVUlKWXdKSWdQ?=
 =?utf-8?B?blZRMzFtUXcxSHE0S0d0L2xMNVhXT0FYOVV5eEpDVkN4TFBuM29WckRqS2Jw?=
 =?utf-8?B?c0ZGSUxDQWJDMXRRN0lzL2xkSnBoL2hPRlNBc1pQZTM4c1haMlZvc3N6bU80?=
 =?utf-8?B?WDBoUE1QMmN6R1hDOFNrcU1OOG85b2NTajNSYjVpM0ZWcDN3bnRIU3ZuQUJC?=
 =?utf-8?B?bGF1Uy8wbzBsa0JFZHp6MWZsTVhkVlZWVXhhTk1nRnhFcVdKZ1lpeGtLN0FK?=
 =?utf-8?B?UHYrRnEyaCt0WTM3dnpWNGZHeElBVFBKaEVOTk54N3Q1NWFTYm5CL0lVVzBq?=
 =?utf-8?B?SVZ6NTZGMUpoQUpZZG5yY2RZRVRxcis2UEp1QjN4MXRQd2k4SnJxbUJmYlB6?=
 =?utf-8?B?emd3RlJNa2JDblNqdEJENVFPRkdqamJyeFRtQkRtN0JvSUo1aFVMOFphWnBk?=
 =?utf-8?B?L21aaWpUTGdSR2Q5dklsSDFvbVB2bjVuWkMwa2w0MEtxSytueTM3dTFIaGJO?=
 =?utf-8?B?THlpaEx1OHhFVmNMZnc3ZVdzYlJGQjBzemZXUFF3N3ZzY2FLb1lKVHA5aWxy?=
 =?utf-8?B?TnpZUFdYUGk2ZkVKR1grclNhendkMFFsMFVzYU8vZmJGNFBuTUc2enFueXRz?=
 =?utf-8?B?bjFrSjdYbWF2eXAydmpuMXpNVzBZMkJkUDA1T3dRNEE0R0JOWldxVk1vTm9l?=
 =?utf-8?B?T3g1OXlBVzNudVU4cGNydVRQZWE0Q0pjWERVSHZNRHBNNWsyZzN2aElTb3N5?=
 =?utf-8?B?L3VsdWY3UXFUYU9GVEFGTW5SQ1R2NTlObUh5SU9SZCtxdVZnOTNnVXpuZFc1?=
 =?utf-8?B?OTJBOE1oQk53YnhGZGxmV0svd2JtRVVoSjROcFkrQzFDZEE0SVYyUDRhaCtw?=
 =?utf-8?B?L25lZXFZMm9TTEhIeitWazM0aUhiUmJaY3hKQW54TlBMTkxndDVUODNyYm15?=
 =?utf-8?B?UHZNeUYxaUtJd29VaEpMdDM0UENreW5WY01KaDBRWk0yMGlLbW9pc2xLTDhS?=
 =?utf-8?B?eGUybHJ6UFlQT3RBOFdXU3pnZlM0OXN3enoybHJ4MitiTThOM0tkM29LM2t5?=
 =?utf-8?B?VVJLWHA4V0hsTFp4R3NFKzd1RTE2bHdSa2RndU1wekVaaTlLZFE2Rlkwb0lD?=
 =?utf-8?B?ZnJlMUJxWXRlbDhqbjZ1TXlUbDFGRFBISHQreGl4YzhtNyt5SXpBdWRRT2RL?=
 =?utf-8?B?TEFrOHp2L0lwcHpMenFmVzRRcWliNjRKQTFhbDluOXBYL2RVVjdOUzh2OFUv?=
 =?utf-8?B?VlJOdXlVVkdaMHpIMHk5WWlSS2JNY1QxenFITTV1R2R5SlczRHJ2bGNMYWlI?=
 =?utf-8?B?QTNHNXBGVGw4UEtQaTFsWkQ0Z1FEdDZCRWxEOHVQMkl0SDlSMUJWOWsydDdW?=
 =?utf-8?B?Nko5YTRSRGFKV2R0S0pmV3hLZjM0Q01WSmpvK3N0eXdMUncxeFFsZURGYTY5?=
 =?utf-8?B?VHVONVJIekdNeDZVQW1SWFlvOENaNkhlNUhtTk8zK3NsZFRDa3lNYVJZUnB0?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4544422552CEDB41B86D0A11FB257200@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a53a2d-2f9a-4a5a-d032-08d9e1087ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 20:14:38.3553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jF7zJcPoKpEM6Thq5ejY5VjEVXDJqOWY9MGohA0G84Z6x32NTtO0lMpCAVOzLxN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2838
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 5J5y9jH4hBVDjbynpqJ1NWyhn6fHHq2O
X-Proofpoint-ORIG-GUID: 5J5y9jH4hBVDjbynpqJ1NWyhn6fHHq2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_07,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTI2IGF0IDExOjU1IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFdlZCwgSmFuIDI2LCAyMDIyIGF0IDExOjIwIEFNIEt1aS1GZW5nIExlZSA8a3VpZmVu
Z0BmYi5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEFkZCBhcmd1bWVudHMgdG8gc3RlYWwgYW5kIHRo
cmVhZF9leGl0IGNhbGxiYWNrcyBvZiBjb25mX2xvYWQgdG8NCj4gPiByZWNlaXZlIHBlci10aHJl
YWQgZGF0YS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPg0KPiA+IC0tLQ0KPiANCj4gUGxlYXNlIGNhcnJ5IG92ZXIgYWNrcyB5b3UgZ290IG9u
IHByZXZpb3VzIHJldmlzaW9ucywgdW5sZXNzIHlvdSBkaWQNCj4gc29tZSBkcmFzdGljIGNoYW5n
ZXMgdG8gYWxyZWFkeSBhY2tlZCBwYXRjaGVzLg0KPiANCj4gQWNrZWQtYnk6IEFuZHJpaSBOYWty
eWlrbyA8YW5kcmlpQGtlcm5lbC5vcmc+DQoNClNvcnJ5IGZvciB0aGF0ISAgSXQgaXMgbXkgZmly
c3QgdGltZSByZWNlaXZpbmcgYWNrcy4NCg0K

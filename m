Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B84A68E3
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbiBBACA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 19:02:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48252 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230081AbiBBACA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 19:02:00 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 211MNF5D014228
        for <bpf@vger.kernel.org>; Tue, 1 Feb 2022 16:01:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=80rH/n0ufIuMf0go4OAuTVqiSJpVNugUAS+FmbLmU6Q=;
 b=Q8gJfqupuGCSPFqoj+Ncw+If/rN6MmnLJ3GHKuflXfooXGf4UyGMbfhDNXIApZUWCpki
 cZzEIe+A5aM/Y2bmotZEFT4mOZLZ/HW6XATzWLKA0kDM4rvL51D6M3D4PUixwdQ3QWA8
 /QD8XQMOK7rTWK7z2Bb7AQyjcY9iZgQYHUY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dybqp18yx-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 16:01:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 16:01:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMu6onoHEvdaeyCAOdOvWgS6zomt3sfI9tQwenKWtle7iKfoGdFBQalaPl38ZZqjQPh/C7atwzppBBPtonxsYAU0di6qERBZiPhYNDliK7wBN2wRT+9RIidV1ZnG07P5gkvR20czZRzCODQCy+OK99tTWol6JR8YTNDsBwCmqRO1JqQD2w8W4qfOqW8DPGGeKyG7gR1wluOSwTJO4A7Kj5VeMGmjgO7yPaFO8Vm/RfKh8tboZZgdzMQkeh4uyZ3smngyeo+M9zsSRcpGIlPbi3S+PxKluLIaMNexAERXZgIL2KISP+rp/uy0GH1XUoI6d4r2KN4zA1z9Nukr8YbIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80rH/n0ufIuMf0go4OAuTVqiSJpVNugUAS+FmbLmU6Q=;
 b=Z/PlbekBRgyQ0lfqB+XLijdqf+TmY9BU3ve5qx2fKOiarDeCKEHZTncfB07Qs9B48wmw44G+RFBP6l1ACUXnQfxJ+1pJ/caVegG0iOiWu/IuglRGMLWqhfy0C2h6NLwipR0Zw0JZRI/MvbwWjJjhUzUK7uYR7+C7jPnzvsbBp2qXP44gx0obKU3zpQ2xVsdxS0K2vf11BxBS96Yy/842TbbKeyYeL0CJ2kjCesAoQLou0ifD+kKwNLh+lS3IoCwoQSwHIiEtm7hUbA8EX1UTr4UF0xrnVonaHdDUUvfW0IQ5zqo3DWllejrkOsXRHQoldrifU8EkuqMdv0q05Q5PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB2778.namprd15.prod.outlook.com (2603:10b6:5:1ab::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Wed, 2 Feb
 2022 00:01:50 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::f1fc:6c73:10d4:1098%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 00:01:48 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/4] selftests: bpf: migrate from
 bpf_prog_test_run
Thread-Topic: [PATCH bpf-next v2 1/4] selftests: bpf: migrate from
 bpf_prog_test_run
Thread-Index: AQHYE+YFTof37UwljUKpPvaQGdR+1Kx97QSAgAF7VQA=
Date:   Wed, 2 Feb 2022 00:01:48 +0000
Message-ID: <ae55c8fc5d43517b29b1d6532eace60d82accd8a.camel@fb.com>
References: <20220128012319.2494472-1-delyank@fb.com>
         <20220128012319.2494472-2-delyank@fb.com>
         <CAEf4Bzbg50Ki=ii-Y0AqzpyQnAUEc5qGLx7LW5yGebDeb540BA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbg50Ki=ii-Y0AqzpyQnAUEc5qGLx7LW5yGebDeb540BA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c88e0b4c-67cf-4cba-069a-08d9e5df358f
x-ms-traffictypediagnostic: DM6PR15MB2778:EE_
x-microsoft-antispam-prvs: <DM6PR15MB2778C64265C81F3CAF94A757C1279@DM6PR15MB2778.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QetxgWIQ+MJe42+U/rr04FSPAn8LVCDiOvFCfwGCjnFQnS8FrImNLKjlYG3Mzarq+gPkUgCPih3yyCAhKq4MsZ8U0AO33kING1xN//RgoMW8M+IatikmSUiWKJgQDKoQdC5pglHfLwfWrNCrdyHxhtKv7oiD5M8pxVvVvRt6hxGISa8UfA2VYQoKdhf0xr6wmvRdT86z5U975vUaL1QzFL2KpFrqTOZvODX6daY80KkFV+xjH2b6bBcDBcoxcVPBwmfsmI4r6fuD+mIZTtG+EVfRBWqJV6ICeTNPmhj2MJBFcGseIO41pPngXOvA0yDxM+SFkKQ9sQHQRZ6TgcvAS0q05cyH/i4dpa67IX6MANG9sX9d9x5SJVl4cWScaTKRCl5eNoeFAuyqy0L5lWgW6MdKcOlTrW3aYe1XZD86t6FOb+iybHs/6YtPJpnZFdfTfQw2ykaVdp8sCFvpyI9Hbx7uG0up83ATzhJOb2v7XFP67BQtEZBOQNiGSVftwofJZX4OhPurgoFU8XS9aZofu8gwlSOnXEJBGKSC2MIyXU6eprOjbSbL6krYvbGfZw1YqWhawNqOPdvpYcnIwBChrzdJ/XqZgZ72/xGdTHDIcR2MDma6FKsvGx0+SMlKogpQ05WwRQEWvVMkm696O7HX4+D3aIJDpiprxWup6WFY3gMhVXoxqiek0mRzuabpT5WvUK/wBuyv3TbYUJ95jGMwTO5jTjCMnfqcb2Z/iSNUsGA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(91956017)(6916009)(36756003)(54906003)(316002)(186003)(2616005)(2906002)(6506007)(86362001)(508600001)(71200400001)(38070700005)(38100700002)(6512007)(5660300002)(4326008)(66946007)(122000001)(66556008)(66476007)(8936002)(76116006)(66446008)(8676002)(64756008)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THFqY1Z5T3BiQVkvYlorK2JQN3F6SlRtQnExS24vOUVWaXRwaE85djBOSjZm?=
 =?utf-8?B?SkV3QUlnbFJIN2dQbHN5TVRINnh4SXlkQzhUaUMvZXAwYmIwUlhTMkNIRmtO?=
 =?utf-8?B?cDBoRldPejhqdWx6bjlnWDNCUGNPMU1yT2lkNWtVVnNiN3liTE13VDhYK1k1?=
 =?utf-8?B?K1RTMEhRdVB6NGpobjNEbmd5dGFJdFpKYXI4anhpWTgvbU84LzJLYzJnbXJV?=
 =?utf-8?B?c0ROWUxYSmNBNjc0RXNLUnkxQ0JVc2p4K2tlcDlwQU9WampmYTF2cUxOSG4v?=
 =?utf-8?B?MFZwZVJ1YW9rLzZBTjVsT0hobFJYbFMwcHBLOU9RZi9SSHA4M1hwekRaMTVJ?=
 =?utf-8?B?eTlCZ1JBMlFBcFUvZDVJSFJ2dkpSNXV4OVRpeEtKeGVFSEJOM1E1K0s5Ukxi?=
 =?utf-8?B?elBMMlNYaEpUQWlZTDkxc0pRWXMxMlcvV0RYOHBPWjlKQ1c1cVY2L3NLZFUz?=
 =?utf-8?B?bU9SU0Y1WkNGQmNlRWZKU0tkT2ppNWZvYmJYTjc5YXQ3N0IxUkQyOVV0djZi?=
 =?utf-8?B?KzI3amlIVVovRU9jV0VuNC81RnUzSFRDYmN6Rkt2U0o5eitReU1sS2JaUXZj?=
 =?utf-8?B?bldaK1hRa202Qzd6R0NYVks4S0g5L0dPb0UyMmYwUVhRM3A2NXNDa3kybmdV?=
 =?utf-8?B?VitwZXNLNlNDeDJxK0Jid2dKS3FlczVZNDFTbGxVWkd6L1c3T0hnekROSEZw?=
 =?utf-8?B?T1RzRW5TaXprRmRxdC8vK2hPaXlXR29tRjdzRzZQdEhyakUrSUVFd21jekgr?=
 =?utf-8?B?bThZU2JidlZhN0FOT1A0a0JYUUowUUoyc3BxVUQ4b3kzTTNDOVM3N0Z5N0h1?=
 =?utf-8?B?eW1NMHlPR1J3ZEs5WjdjR3ZEWkpqcGUrVi9oK3VzOTNCdjI4ZDVlRVlBNjJu?=
 =?utf-8?B?NlJmM3g5cG9RV2ZVUVN5S3VwSnU5bmdZbFF1UFg2cU1iOU01RFBHNTBPdXlU?=
 =?utf-8?B?M0pwRzFpQjAxak0xL240UHloK1VNSWxlYkdRYXRzZ0lJYUpybi8yeFhORUcx?=
 =?utf-8?B?VzNxd3cycnl1dVV1czhLdmxmeTl5NWNmY2lDMVIxOWtVb3RWZmFldzNJajBs?=
 =?utf-8?B?T2tnRzFoUVVpWGltT0xwMzZIU1RWTERuUWxWR3hnSk9VTkF0M2Z5R2EycEI1?=
 =?utf-8?B?YUNzNStscXFTbFA0M3hRcDdSRnBWNkVMS05FOEk0RG8ydjQ3c2dRcnFuT0FP?=
 =?utf-8?B?L0oyK2tEQnAxQzJPZDhVQTJVbTlnc1djZ0gybDhyMEdrNkNJZUl1SFRtKzQ4?=
 =?utf-8?B?QjdhRGJJVlVOaUZ2OEhzR3BtRDVRRUZTcnRPMnpYLzNSeUF4THFJRm4rdlYw?=
 =?utf-8?B?YW05R2k1MXhsUk1GZmh0R1FQM0U0RVpNWUdmZnhZOVNHOTRHdWIwdTBEVTJC?=
 =?utf-8?B?QkwrTFlWUkk4aEszaCtuMmtpUUlwS2xENGNFM1FrUzNNYmsyRUFTZGVsMzFh?=
 =?utf-8?B?ZG85T0FJSEZSV0dPbE9CUEZRem1jTGhqUU9HNy9lclhWaG9zcTU0WnlHVEVS?=
 =?utf-8?B?S0tBKzBKVjRMR3FnMCtGMkNJNVZFSlkzWU1DYlRDaHNJRW1OYXQxZXRnd2Rz?=
 =?utf-8?B?bFkrVHByOWdseGkzTXp1N2dVam5rNm9vVG4xSTdqMUZFc3hIOERrUy9yREZ3?=
 =?utf-8?B?S25SYnFpZE1wS1BIK2lrbWUra0VGQk05UXpNWVpSaEtLWG9rbEZCM0N5eW1S?=
 =?utf-8?B?VUtIbG8yNklhbkZZR0JqZkZwcVBqbFhOMUdhc2pWRXFRb2dYQmNybGhlQlhv?=
 =?utf-8?B?TFh6YjFQdGRXc2pKcmFnZmEyTGdOL2lLNiszUW9wZ3JndlByeCt3MEVlenIw?=
 =?utf-8?B?elFKUzVyanJKSC9TcXMrMUdsZ1Uxd2ltd3NrY2JHQ1NXcnhsREh5VlVWWDRn?=
 =?utf-8?B?UzY3eUxUYlU4N0ZWSzVBN3daOTE3WkJleDF0NVU5RXp6ajBQWU5wTDFpYkFs?=
 =?utf-8?B?Q2grdTVoVlVRUzlBYzgvT2hBalN2UlhMOS9OditSLzVObWRVdG5yZms3N1Ft?=
 =?utf-8?B?RmFzUU96dVpCR3l4a01qbGV0WmdnMGlvMnRGMUd1RnY4NVlkbGhhUDBWcG1M?=
 =?utf-8?B?d0NRYndMQzVJeStxV0M3Wm53NkovWkZyRTJkd1lQYmFVbUlkV2ZaZHAvdlJG?=
 =?utf-8?B?RTN1SlFPOVFqWStvQk9mOGlDMzFsc2FGRTJ2ZCtsK21sOGlXQjB3aUE2QXUr?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2DF30109A4480489AAA6E81CA28FE83@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88e0b4c-67cf-4cba-069a-08d9e5df358f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 00:01:48.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fHtNTbodjSq6MIYPqfxE5/ptUCyMNpEJDLpvhEKEzFFPUfm2fbkx5Q/adSPom7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2778
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: nZUjBz4wAwkjvsLz-WEOp7n0Br7r-4kH
X-Proofpoint-ORIG-GUID: nZUjBz4wAwkjvsLz-WEOp7n0Br7r-4kH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=934 mlxscore=0 impostorscore=0 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTMxIGF0IDE3OjI0IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IGZvciBzaW1wbGUgY2FzZSBsaWtlIHRoaXMgeW91IGNhbiBqdXN0IGtlZXAgaXQgc2luZ2xl
IGxpbmU6DQo+IA0KPiBMSUJCUEZfT1BUUyhicGZfdGVzdF9ydW5fb3B0cywgdG9wdHMsIC5yZXBl
YXQgPSAxKQ0KPiANCj4gQnV0LCBpdCBzZWVtcyBsaWtlIHRoZSBrZXJuZWwgZG9lcyBgaWYgKCFy
ZXBlYXQpIHJlcGVhdCA9IDE7YCBsb2dpYw0KPiBmb3IgcHJvZ3JhbSB0eXBlcyB0aGF0IHN1cHBv
cnQgcmVwZWF0IGZlYXR1cmUsIHNvIEknZCBzdWdnZXN0IGp1c3QNCj4gZHJvcCAucmVwZWF0ID0g
MSBhbmQga2VlcCBpdCBzaW1wbGUuDQoNClN1cmUuDQoNCj4gDQo+IGxldCdzIG5vdCBhZGQgbmV3
IENIRUNLKigpIHZhcmlhbnRzLCBDSEVDSygpIGFuZCBpdHMgZGVyaXZhdGl2ZSBhcmUNCj4gZGVw
cmVjYXRlZCwgd2UgYXJlIHVzaW5nIEFTU0VSVF94eHgoKSBtYWNyb3MgZm9yIGFsbCBuZXcgY29k
ZS4NCj4gDQo+IEluIHRoaXMgY2FzZSwgSSB0aGluayBpdCdzIGJlc3QgdG8gcmVwbGFjZSBDSEVD
SygpIHdpdGgganVzdDoNCj4gDQo+IEFTU0VSVF9PSyhlcnIsICJydW5fZXJyIik7DQo+IEFTU0VS
VF9PSyh0b3B0cy5yZXR2YWwsICJydW5fcmV0X3ZhbCIpOw0KPiANCj4gSSBkb24ndCB0aGluayBs
b2dnaW5nIGR1cmF0aW9uIGlzIHVzZWZ1bCBmb3IgbW9zdCwgaWYgbm90IGFsbCwgdGVzdHMsDQo+
IHNvIEkgd291bGRuJ3QgYm90aGVyLg0KDQpBaCwgdGhpcyBtYWtlcyBhIGxvdCBvZiBzZW5zZSwg
SSB3YXMgd29uZGVyaW5nIHdoYXQgd2FzIGdvaW5nIG9uIHdpdGggdGhlc2UNCnF1aXRlIHVucmVh
ZGFibGUgQ0hFQ0t7LF9BVFRSfSBtYWNyb3MuIEknbGwgcmV3cml0ZSB0aGUgb25lcyBJJ20gY2hh
bmdpbmcgaW4NCnRoaXMgc2VyaWVzIHRvIHVzZSBBU1NFUlRfKiBpZiB5b3UncmUgb2theSB3aXRo
IHRoYXQgYW1vdW50IG9mIGNodXJuPw0KDQo+IFlvdSBkaWRuJ3QgaGF2ZSB0byB0b3VjaCB0aGlz
IGNvZGUsIHlvdSBjb3VsZCBoYXZlIGp1c3Qga2VwdCBkdXJhdGlvbg0KPiA9IDAgKHdoaWNoIENI
RUNLKCkgaW50ZXJuYWxseSBhc3N1bWVzLCB1bmZvcnR1bmF0ZWx5KS4NCg0KSSBkaWRuJ3QgKmhh
dmUqIHRvIGJ1dCBsZWF2aW5nIHRoZSB2YXJpYWJsZSBhcm91bmQgdG8gc2F0aXNmeSBhIG1hY3Jv
IGZlZWxzDQpzdXBlciBhd2t3YXJkLiBIYXBweSB0byBtaW5pbWl6ZSB0aGVzZSBjaGFuZ2VzLCBp
ZiB0aGV5J3JlIGdvaW5nIG92ZXJib2FyZCBidXQNCkknZCByYXRoZXIgY2xlYW4gdXAgdGhlIENI
RUNLIHVzYWdlIHdoZXJlIEkgY2FuLg0KDQo+IA0KPiBBbHRlcm5hdGl2ZWx5LCBqdXN0IHN3aXRj
aCB0byBBU1NFUlRfT0tfUFRSKGZlbnRyeV9za2VsLA0KPiAiZmVudHJ5X3NrZWxfbG9hZCIpOyBh
bmQgYmUgZG9uZSB3aXRoIGl0LiBBcyBJIG1lbnRpb25lZCwgd2UgYXJlIGluIGENCj4gZ3JhZHVh
bCBwcm9jZXNzIG9mIHJlbW92aW5nIENIRUNLKClzLCANCj4gWy4uLl0NCj4gQXQgc29tZSBwb2lu
dCB3ZSdsbCBkbyB0aGUgZmluYWwgcHVzaCBhbmQgcmVtb3ZlIENIRUNLKCkgYWx0b2dldGhlciwN
Cj4gYnV0IGl0IGRvZXNuJ3QgaGF2ZSB0byBiZSBwYXJ0IG9mIHRoaXMgcGF0Y2ggc2V0ICh1bmxl
c3MgeW91IGFyZQ0KPiBpbnRlcmVzdGVkIGluIGRvaW5nIHNvbWUgbW9yZSBtZWNoYW5pY2FsIGNv
bnZlcnNpb25zLCBvZiBjb3Vyc2UsIGl0J3MNCj4gZ3JlYXRseSBhcHByZWNpYXRlZCwgYnV0IEkg
ZGlkbid0IHlldCBoYXZlIGhlYXJ0IHRvIGFzayBhbnlvbmUgdG8gZG8NCj4gdGhvc2UgMjAwMCBj
b252ZXJzaW9ucy4uLikuDQoNCkkgZG9uJ3QgdGhpbmsgSSBoYXZlIGl0IGluIG1lIHRvIHZvbHVu
dGVlciBmb3IgdGhlIHdob2xlIHJlZmFjdG9yIGJ1dCBJJ2xsIGRvIG15DQpiaXQgaW4gdGhlIHVz
YWdlcyB0aGlzIHNlcmllcyB0b3VjaGVzLiANCg==

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA064B19AB
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 00:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345801AbiBJXkm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 18:40:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbiBJXkl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 18:40:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452B95F6E
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:40:42 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21ANSQZX028721
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:40:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YukLQDAC/bE+0v2Gx4lJ5kmgiNK0Cv3nfIG4V1NXfgg=;
 b=qU4yKR+fCFdeDKox1rwjoFeyPwhL2HUCjCF0y+aOujqeHc+rCnr6+XNkR6s3r/0CJ8iM
 R2B0IRyVTi8FxHQfsoLikxSGjHfYxpBLa33g5YHlatShy3gxDIzXSdzGsopetyQBRh2n
 dlIgxnhFtbBAfgR34vbc4zJDKU+1WtovBPA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3e58p99q53-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 15:40:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 15:40:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpdI7xBiGmS8DxL6QUgUC018fOqoCHYcB4J2g7SguwwPZhB42QUvG+rz6JxivaxNZZ8l2lnxB4cp9MZU9BHQ3oKZ3Uei7KXsCg1HLFaO/xt2Ny1ZPVvyZ+SJDOKQTWIwDrdUYTgFFWxandnBWPQ7sZ38mqHvaz1D4lzl7MdPt2DfHZ6jBExEKOd7CcQcUDPg/vMsUxFMJ4OwIwnBeLYZb9H7OrGdcoNfPHU8ovqAIlbgqpQTSYcaILZ2eFB50mV9du2THdNUdLYV/y4BgZXCVauRVDeSA5IXwKBDFNcd8RjZpwi6RsHjJBHpEHIpNJYNIA6/84WNEs0Q0grRpmxgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YukLQDAC/bE+0v2Gx4lJ5kmgiNK0Cv3nfIG4V1NXfgg=;
 b=Ve8CWzscsQkNoPR40QGAQnYLLfgUdO4ny2y7NkfM83xoWN7HVhjYbtf/EnTNODH3VZLAYMHCEvXRYYIU/5FIMmQk8HJ1fWPX0Kz9QxgrgivtGLPXr1v+odUeSSWPruikxjl3lEjBK2jS0a2LH7AuDhFlh69aYXAY6F02V26Zz5eEkwQBUL95EUbvD6o6QSaEvwHG6P1Apw5wfwmZJgPpu5Jji2cOBPAyEVlG1AqF6o4LYR9qF1guz00PUkitaeQ42nAP6YkwCvDDjAYhPdOTXF0Qn8m1C/Nvt5w924q1aNfZd5QDeHkNHIFc/VGlUUxwcF+I/mjb4Hwjzw6YVWbOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BL0PR1501MB4258.namprd15.prod.outlook.com (2603:10b6:208:88::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 10 Feb
 2022 23:40:37 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7867:90d0:bcaa:2ea7%5]) with mapi id 15.20.4975.012; Thu, 10 Feb 2022
 23:40:37 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] libbpf: btf_dump can produce explicitly
 sized ints
Thread-Topic: [PATCH bpf-next v1 1/3] libbpf: btf_dump can produce explicitly
 sized ints
Thread-Index: AQHYHhZN6oKvYnNMn0ufaBhT1TB7uKyNYPEAgAAQsQA=
Date:   Thu, 10 Feb 2022 23:40:37 +0000
Message-ID: <b0d0b506851f5a17a24b7bafa2a6937e693b57b6.camel@fb.com>
References: <cover.1644453291.git.delyank@fb.com>
         <c37e39653b133b230dee3b393a07b4def697b61a.1644453291.git.delyank@fb.com>
         <CAEf4BzY4RdsGHFdJH-chAMpFnP+rGojbBkOEEgjcS09nwU8XTg@mail.gmail.com>
In-Reply-To: <CAEf4BzY4RdsGHFdJH-chAMpFnP+rGojbBkOEEgjcS09nwU8XTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75721e3-7db7-4540-f0a6-08d9eceebd59
x-ms-traffictypediagnostic: BL0PR1501MB4258:EE_
x-microsoft-antispam-prvs: <BL0PR1501MB42587898F9A268901B858A19C12F9@BL0PR1501MB4258.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xoZnS8jFPrZUUUxaWxU9GGBTOetmjz6NSMyA2jl3w1LB6aNMGYghPgj482k/SFiw11KvWb6aSBzhjzT18iHfM9CAhSOdVah1vPDgJjTLCB117eyrSxp00/eX1+iAmIJ6MRctwUytrMtQbdLOiAyLO8nqu6xNwhY54bJtxJDGEBTEdYF/KIf/mEkm6y8IEYcYDH3y9E3hbUb9Koroz13yjv5kxUr4KqeeBv6nlLMaL9Ai8tyJpgaF5D5ZtYhFMfPJZ+MMIA7sGiYhwf4f4Yj6ovLiHOy0XLwpZJxc2qWtKeI2Cfb0T83pua0dna5dkNMIxkk80IKF0fYan5/o6xXEG9Tt/sMxgzvMxR//RghxR32QPwG6iVNlpwIjm9bnO+tVPRn1e52EFKNwyehlR9nM80FwmeH+fzu/GWP0xkQoaj7zahRYcJpHJT53YC6MDNGXUgKj/Wg6O2AlhTTXviLi0Uva5Pp+7tP2SVixgIdyW/KPFGGwbYacxr0e/JCKEywYP8tHH3OfTguaaxuGjGbwCYftDZpyGjWln/w8LS0qLPu9AS3966tN37MzU8D0ZvqWQ6ko0SGmQ2zF649o/vvJev53ndEN/ojBr1kG8mlMQcWLfs0vMLTYhMNGu1P/pHwGcmbbwiqTVQcm4KHGUG/0wSbYjakzUvlQlV0MJr6n2Jlb5X2Mm5eX8Uyj7OnD7KOUTd7LpOecY0loQaUJ95iKQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66946007)(66476007)(76116006)(66446008)(66556008)(38100700002)(64756008)(122000001)(2906002)(4326008)(6506007)(6512007)(6486002)(91956017)(8676002)(508600001)(6916009)(316002)(186003)(86362001)(38070700005)(2616005)(54906003)(36756003)(8936002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGpJU0xmb2lycldRbHdrcUJxano5ajJrOTBuTkZRQ1ZJazAzUXFpWGdFbVly?=
 =?utf-8?B?QUZmNTVrRWhjY3hMd1phSHdOTEJmTy9yYU1PdUJqSnBQeVgwZXlSUVRsb1Rn?=
 =?utf-8?B?YzFLWkJiTFYzWEVIb25SRXc5Q0JDcStxR1V6UDBVYjJ6d3U5RlIvdG45YXhL?=
 =?utf-8?B?eWRVbWlpUlIwdGZsa0tZQzhuZ0lWa3Robkxpd2N5MnVudG5hTTdxbTc3T2Vq?=
 =?utf-8?B?WVI0L3hKOE5yRTNtTEk5QjM2TUJYR1A3Yk5nWmlXRmZtWXduQk5la0UwSUJh?=
 =?utf-8?B?VFJzMDFHRWZLdklZblZmZXI3cnhncFVKbjhUMFJ2SnJzWXpnWENpQ0JoUkhs?=
 =?utf-8?B?cVNPMHF6cDRSdFU4TG95MmxrblZsdEl2SUNNdFFaU1RZVGlkTHp5R2V5ZWY5?=
 =?utf-8?B?SjBoa2NwR0RiemRkaTBtLzczTWxSUTJXNkxnbEw3Nk1NUmIzcHZsRVY3Um95?=
 =?utf-8?B?Wm9VOTN1elJKeUYrSVJVR3BjcXpNUXF4Skt5NGRvUWVHQVgrY25yS2hnVlNB?=
 =?utf-8?B?ZHhobXB2OUlxR3FaMUZKd09SdEhqYWlzK2hoNXlleHFsWVduSjZjNmJ3K2c0?=
 =?utf-8?B?bk5ybk1TU29ONE5yTDcxNzh5SW8ra0w2REdVTXoxZnhSNDdUUkNadGdiMy9I?=
 =?utf-8?B?NjZxaUVTZWR5NktPL2NVbUZkSmF4aFVBc3FTTVRjenRiNUwza29oSTl5RDZj?=
 =?utf-8?B?NXJjRzNOVFBtYmtFU1ZxWW9YUjJCVmlrRkoxek11MEc3V21CbnhiOXJBaVd4?=
 =?utf-8?B?Yk01YWVXMFI0Sk5Ta0w1d0Fkb29YUnVrWXYrMHJ2aG42UVVMd2R0b3dwa2ts?=
 =?utf-8?B?QlVCdXVXdXI5aXF6NFRSQ1MvTS9JcXhjZlBZcVJzb1ZiOXhocE9ydjF1dk5P?=
 =?utf-8?B?YUIyeUh6SmkxYWJYaCtWYmtYdHBRMWV2Wi96REZqMmlrZFgyMnZqcGJobHdr?=
 =?utf-8?B?c1lWNENKS0tRUGxibFN0VXZ4OHJxeVFDTmxIb1NFUjlyc2tRMUlDWGRncUhh?=
 =?utf-8?B?Z3IwNFh2Y2lQSnVGOHJFR2pxSWtPa2l3dHdFeDRCNk01Q3RDa0Y4OUlFZk43?=
 =?utf-8?B?V0FYd3hMSmlkdzlLWGQzNFJGN1krTVZBNG02dmkvaW9DNktEM2Y1K0ZoUzBy?=
 =?utf-8?B?d1JKWEpMMWhIaFExeThjMnNBYWEvRHpWdzRnQzBENXVsQzNjZi9UNTVQMExj?=
 =?utf-8?B?TUZIUjFleVRxK1hjZDNaM3NPaGRWS2I0ZWJSbmY3ZzJIdGtKRGI0aEljOG1O?=
 =?utf-8?B?WkVVQUhTR0l5UHlncFd5VkM1ZXdYWTIwM1U1bitKSk1DWUVLdnU0NDZrcitQ?=
 =?utf-8?B?d3I2dWdmN3N3aERuSnY5NWVPVzR2QzlsVjY2ajlLWDhRUkd4eHpNZmNaclNW?=
 =?utf-8?B?cUVnQTJneVdSMUMyWlBpZGxyLzB6WEo5M2FUZ0RyYUdkYUh6Y3U5ZW9IM0dx?=
 =?utf-8?B?enFFU2gvMVBBekRDK2lCbnBjU3Brd1BQOVlYR1d4SWFwNGJ3L0oxUDd4ZnJq?=
 =?utf-8?B?RkdLRXJZb3UrOFFQTDhjM3dVYm9UTU9FZWZaYUt0M1JpakNHTTRnMEdwc1A2?=
 =?utf-8?B?U0kvNXNxQlJ1QzY0VGUwV25PeHFONUxVRU1xQ2YvVFdVaWQwQnh6UkNBWFdz?=
 =?utf-8?B?d29FK01yZHZBeHlqV1VLSWR5dFEzbGFld2pRc2NOZHl0b1BqTmFaYnFQVndX?=
 =?utf-8?B?ci9ndmtuZWJ6NlpGMUJKZDRHVEpQbE1QTUx0a3FoQVREOW1oMThEUjdYMVBM?=
 =?utf-8?B?clB4KzN6KzhkTENhaWJBYUZiQmZDa2FwR0dLSTFPRGNUTzFsdWdiVEFBNTh6?=
 =?utf-8?B?cWVKUFVtM1BsS1c5eGt1V1V2bGRKZk1vMGxuMTFZU1hDRXJlaFpQN1BWZ1di?=
 =?utf-8?B?b0xYM0xhYW8rVzhmVmRVZHg1bjM4SHovS3o4eFl0ZEZ0NG93bnQ1eFVQMUNT?=
 =?utf-8?B?b3lmYksrOWRpYXVDRHo0T0VHRWZZb3ljOFc0d3NkVVU1SlROY2J5cDcwUm9W?=
 =?utf-8?B?a2ZwaXFVZFBHUHA3cHkrbXQ4L3BQV2kyNlR3OFE1cGxtSHVsRi9jZkFGVDk4?=
 =?utf-8?B?UkJuWFc4YjBPZWdqeUVNcGMySHB1ekMzR3ExQm9FK05PcDNRcjZwODhjR0ZL?=
 =?utf-8?B?S1VZRklEMks0bDV5eDFCRW1iRTRiK1hQRk5rY1JSWG9kS1pCRUxidmNjaGhz?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26118B6BA7373D498124C008E0991681@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75721e3-7db7-4540-f0a6-08d9eceebd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 23:40:37.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/lPuxd4pFsYkgeZoqxINzt4YF/HE7rrNPBAa3z/qGlhVKmQnitGJlSDFjuKmCjp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB4258
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: BpY1CNb9L5SEruLMuxHeShKnfTs1D4na
X-Proofpoint-ORIG-GUID: BpY1CNb9L5SEruLMuxHeShKnfTs1D4na
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=545 malwarescore=0 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100121
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTAyLTEwIGF0IDE0OjM1IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IGxldCdzIHN0aWNrIHRvIGNvbnNpc3RlbnQgc25ha2VfY2FzZSBuYW1pbmcgY29udmVudGlv
bg0KPiANCj4gbGV0J3MgYWxzbyBjYWxsIGl0IHdoYXQgdGhlIGNvbW1lbnQgY2FsbHMgaXQgOikg
Im5vcm1hbGl6ZV9pbnRzIiA/DQo+IA0KU3VyZSwgbmFtaW5nIGlzIGhhcmQuDQoNCj4gU28gSSB0
aG91Z2h0IGFib3V0IHRoaXMgYSBiaXQsIEkgc2VlIGhvdyB0aGVyZSBjb3VsZCBiZSBhIGRpZmZl
cmVuY2UNCj4gb2YgJWxsZCB2cyAlbGQgYW5kIHN1Y2gsIGJ1dCBJIHRoaW5rIG5vcm1hbGl6ZSBz
aG91bGQgbWVhbiBub3JtYWxpemUNCj4gYWxsIGludHMsIHdpdGhvdXQgYW55IGV4Y2VwdGlvbnMg
Zm9yIGtlcm5lbCBhbGlhc2VzLiBMZXQncyBrZWVwIHRoZQ0KPiBydWxlIHNpbXBsZTogZXZlcnl0
aGluZyBidXQgY2hhciBhbmQgYm9vbCBnZXRzIGNvbnZlcnRlZCB0byBpdHMNCj4gY29ycmVzcG9u
ZGluZyBzdGFuZGFyZCBpbnRlZ2VyIGFsaWFzLg0KPiANCj4gV29yc3QgY2FzZSBmZXcgdXNlcnMg
bWlnaHQgbmVlZCB0byBhZGp1c3QgdGhlaXIgcHJpbnRmIHNwZWNpZmllciBhZnRlcg0KPiBzZWVp
bmcgYSBjb21waWxlciB3YXJuaW5nLg0KDQpXaGVuIEkgZmlyc3QgdHJpZWQgdG8gZG8gdGhpcywg
dGhlcmUgd2VyZSBhIGNvdXBsZSBvZiB3YXlzIGluIHdoaWNoIGl0IHdhcw0KcHJvYmxlbWF0aWM6
DQoNCjEuIGZvcm1hdCBzcGVjaWZpZXJzIGFyZSBhbGwgb3ZlciBzZWxmdGVzdHMNCjIuIHBhc3Np
bmcgdWludDY0X3QqIHRvIHRoaW5ncyBleHBlY3RpbmcgdTY0KiBpbiB0aGUgdXNlcnNwYWNlIGNv
ZGUNCg0KVWx0aW1hdGVseSwgdGhpcyBmZWx0IGxpa2UgYSBnb29kIGNvbXByb21pc2UgYmV0d2Vl
biBrZWVwaW5nIGV4aXN0aW5nIGNvZGUNCndvcmtpbmcgYW5kIGFsc28gYXZvaWRpbmcgdGhlIG1h
am9yIHBpdGZhbGxzIG9mIG5vbi1zaXplZCB0eXBlcy4NCkFub3RoZXIgcXVlc3Rpb24gaGVyZSBp
cyB3aGV0aGVyIGEgbWlub3IgcmVsZWFzZSBvZiBsaWJicGYgc2hvdWxkIGJlIGFsbG93ZWQgdG8N
CmJyZWFrIHRoZSBidWlsZCBvZiBhcHBsaWNhdGlvbnMgdXNpbmcgLVdlcnJvci4NCg0KV2UgY291
bGQgcG90ZW50aWFsbHkgZ2F0ZSB0aGlzIGJlaGF2aW9yIGJlaGluZCBhIHJ1bnRpbWUgYXJnIGJ1
dCB0aGF0J3Mgbm90DQpleGFjdGx5IGEgInBpdCBvZiBzdWNjZXNzIiB0eXBlIG9mIGRlc2lnbi4N
Cg0KPiB0aGlzIGlzIGEgZGlmZmVyZW50IHVzZSBjYXNlLCBsZXQncyBub3Qgbm9ybWFsaXplIGFu
eXRoaW5nIHVuY29uZGl0aW9uYWxseQ0KDQpNeSBiYWQsIG1lYW50IHRvIHJlbW92ZSB0aGlzIGJl
Zm9yZSBzdWJtaXR0aW5nLg0KDQoNCg==

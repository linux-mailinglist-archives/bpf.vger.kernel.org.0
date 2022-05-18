Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA052C258
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 20:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbiERSbv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbiERSbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 14:31:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8908065412;
        Wed, 18 May 2022 11:31:49 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24IHDUib020337;
        Wed, 18 May 2022 11:31:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vSbq+ZV5ANAA7xPtNVNKSnbE878dDRdEeL96IEwkYVQ=;
 b=cb6POgZAs8qH7gr6tGxpZc1IAzRhKIVoXOueek+dTKz2z3/6q/ctuz46P+8oDN+enP6u
 QYkLg6ZZ4Xn3/x7xrFQUsil/1A6hqjG4uPUGbsGBM56Ofhtv2zTbZAqb1ba4f9tEZn6c
 pksQmlwrhnjw/2hslWGpG1eH8UQbQVbor6E= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g4myhpac6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 11:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaXuoStDaQ40ars6gZzhF6Jmo1se+yY3t2B+BHfEWrRF2SHa+2RSzHogYyrmfGUppljdttnbWgOKaMcRj06GsxSJUOgaMmKL3pQYNI5scQ4cQTPrXHWTvkp9IuG7y9j05ucNRhq2lLA/8yAsJjGuMsUCmgpX+wV97rTXI4watBdCMqNeIw8z6xNkv5oAtvJ43r5w1LeAoDF7dSh5w+eCFpYyOQzEi4nJLQj0ldanU0TN7oXC+uFfCYDLA5FsDcvenzUfqDcU5WOX/e8CCn0QdW34Sys2KFD91EuERlO35Ud7ZFKs2z0FSyddqvLmNrJghUQAuP567EEsh2FBBchqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSbq+ZV5ANAA7xPtNVNKSnbE878dDRdEeL96IEwkYVQ=;
 b=b8+yyPwfdOpTEs7cMP1ZHzgSCk80p6w5m//dSGE+Tx44Rs7qDsoVX76FJ0K3ZX5VWE2xxcudoF7eezSI2jr2fTBrAQGjpThASLG0ObacK/E0UnyVaSYTkky8hWrHBYckTW/Xb0hQYauC7CwTSPQenhjyPNbyUoUHNg+fYuNoF+Noqv15paJdaXScDLc4krpA5YFX5B3vNkwz9z/YZR1QxGrcscTE9TGO63XRfyk1ugBUjOBpXR8VP1nBcuWsmMGvq+O6t3ve8laIRG6QoCHmR0Wlx6qXe1c1ULcVmrswOzJVMGf23DIbtlbqOQvCHDrMWOOOJBa3CG2P3USGMF20dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY3PR15MB4865.namprd15.prod.outlook.com (2603:10b6:a03:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 18:31:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%4]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 18:31:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Kernel Team <Kernel-team@fb.com>,
        "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for bpf_prog_pack
Thread-Topic: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYaOeMGoBl3hFoL0eR1OYIkVdnbK0jcwCAgAAfoYCAAC+jgIAAbBSAgACuWQCAAByMAA==
Date:   Wed, 18 May 2022 18:31:46 +0000
Message-ID: <08D418F5-0FAA-4544-B6DE-FA2371D3AAF7@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-6-song@kernel.org>
 <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
 <68615225-D09D-465A-8EEC-6F81EF074854@fb.com>
 <dc23afb892846ef41d73a41d58c07f6620cb6312.camel@intel.com>
 <42042EE3-EDDF-4DBF-AFD5-89A5CCC59AA3@fb.com>
 <3ab4c6cf8158891167c145015bdf5754f972223a.camel@intel.com>
In-Reply-To: <3ab4c6cf8158891167c145015bdf5754f972223a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccd852a0-b164-40a1-acb1-08da38fcaa02
x-ms-traffictypediagnostic: BY3PR15MB4865:EE_
x-microsoft-antispam-prvs: <BY3PR15MB486523B12FC9A15B9E2526E5B3D19@BY3PR15MB4865.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hC3bxdvxSOFb3WQt+Y6hpcgNqGxN58yiHVP/9oz3/1/3mPnRI56xGI8dy1h3yaEJsbgRKWWi5E1S/hgj6/ESiIlr9T4BaYLChJYbx25A3InWbycC304PQcuPr+Vmbdddc82Lzi5b6B13ujEyUuiSA0/zroS0ZWT2LiVMfZ07zRBjHz3FMwH33npt/XG5/1g09A7dcM4LTqcGg2CyN8lTUcLcbQPCkIGWbjVkofzJZ54drzSDx6PpNY+QRWeauVMEKe1BgZw0/rA0q/KI7Z5k1/MFRUqcUUVQlnZ/3nTW2BHyUopVU8bHdi4McWGfz6eL+G+LtJSZra3t1qVptEybGiEh3olxzDrb9uMm1invPlCdbS5zLN3xO3t9NM+eu53bpfRA5wWVjLpbqTSRV0Z2rFP1ZSWqZBwAYCtHA2tHe3vRUFfZjCZy2AdvKVjmnMUmtPx9YHSdo4CtsY3Q5yilrLziYAglab1LsC7XA3mKXLXK/tKPz/dqJmkQbZd+R1hDCJ+jpfMsSgobkha6gce7EwZZ2LVtfND0+2Q3YVcnTQX10qZ8jXW+Rild3Hnqh6CR03DR6vUEWspgZ+9rPXJ+9U/6N5upnPaCGNbdlbhIe9bcSt2ca9IEbLv4QRkLvCIAp5ktbvYo0RgG4xMvTxM/39Wtsh8C0M8zq/0h/HOyjyfpX3hEl7zlD1DtjBzXkpuCEUdMUHIc8CwsCBJmTFeHMufhxNbShEsgEun0hGutUJSJGOYaXEn7tswz3m/YLQQh7JQAEIm20aCXNYuKZtKnA6KZRjHKdnSr90dqBtJwV1vdpKc/GZD/gDDJ1bnjuuypU0Q+PC56Vb5qSGnm4t8AdAU8LhFN/Y0X6w+idEtjCfQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6486002)(966005)(508600001)(5660300002)(71200400001)(38100700002)(38070700005)(33656002)(316002)(8936002)(4326008)(66556008)(66946007)(64756008)(66446008)(8676002)(6506007)(6512007)(83380400001)(2616005)(86362001)(76116006)(66476007)(91956017)(122000001)(6916009)(54906003)(36756003)(186003)(53546011)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1pJSXN2L0EzZHhBOFJlT0FVOFV6ZjhLYUl1QitEK2x0aFRlUWdNQWYrdzR6?=
 =?utf-8?B?dHpQMlQ4MzBJOVc1UFRnUmZxVFRad3lRVnBCY1JEMUZsQTE5c0NRMDJua3M1?=
 =?utf-8?B?Q3RyNTR2anVEMHpRV21VOHhGOFROWWgyNmRwejI4bSt3VFdrdStDMFMxeVYw?=
 =?utf-8?B?UC9JOEVia3BnWlZuZjlKTlQ5OU9LOXY4bEhCZzVpYnduUitmYlNHR2dHditi?=
 =?utf-8?B?c3YyZVRpWjNycEp4VVgyaUgyejFoelNWcktLRVJVdDgwUnJUQzN5NlRGSVR0?=
 =?utf-8?B?WEVSUkJQQ09DOWpEaWxwTDRwOHk2SjcrRlFYV0FoMC9ENXVZSlpQcXJpZjBi?=
 =?utf-8?B?dzYyMldHaUJuUENQZ25iT1d3UGRhUUxTNXRkWnoxWk1NYmNmSCtCWm1IZzAr?=
 =?utf-8?B?MGNOSWsrbzhPZUxKWjRjNSsrOTRkMWVFWGc1RDYvWnBKT3I0YklnWjZvV0hD?=
 =?utf-8?B?MEg5Rlg0VEtOYXRQUEdVejRXVk5oSmU1bGlDMkgwd2Vld1F2aXRWUnlMMUtX?=
 =?utf-8?B?YkNmMktMOWxnYlR5cU5mVDhNZnIycEdvZjJZaThZdEY5OSsvU2FORG5WTUJW?=
 =?utf-8?B?V2VNRWRub2pvSmZXMzhPUGFmc3VlMkk4ZkxpZ0hxalMrZ0JFT1dObU5KcDgx?=
 =?utf-8?B?WkMwVzcxZk55Q1hDYWl6ZEdxY1dqaTN2ZFVXQUdkSXNBaVhGd3dEb3lMek1O?=
 =?utf-8?B?M3RWNUNNR2FteklPQUU1ZCs4alpzMGVaQkRXK1gxVlh5S2FCb25wbDhrd1Uw?=
 =?utf-8?B?R2N5UnZmZ21wUDFPVGhBUjBRaGlRZGw2SGVoZXZQb3NMOUdDRzRmRk4wV1R2?=
 =?utf-8?B?eGJZMzlnZER4S1JsY1Q4WW82K1dnUWY0Q2ZybVllMFBFbFVOczd1anR4TVZq?=
 =?utf-8?B?SklpVEJVcFYvOHBWMzcrN3B6OXdXeWo4dDFCem9ZeTk1OUN0YTYwQjAxRm1S?=
 =?utf-8?B?V1lpSE9kUm9uQ0tQOTQwWUxiNXZvTFowU1dUcnBubnMyTWt6UUZyeFVETFIy?=
 =?utf-8?B?dGtpZjVrRXhvNW1iVDUyVE1naExGSXY3dGhhR0w2RHhIWFBGcmpJNFlaOW9I?=
 =?utf-8?B?QVBDSzFHc2lWdGVyNEVUSDc2eEt2VkxPdGM1UDVQNlArOWh1Tlp3cHBMM1hO?=
 =?utf-8?B?TjEvK2xWeGR4Ry9pQ2FCWDQ2ZEFiT1R4VUJnNkdnZy9qRVU3MVBhR1JYVFRx?=
 =?utf-8?B?UlJ2NmR1UnZWYVptZUlBMHRTcHZGUWpSc1dVZHRKb2UvYm5ZZFVmRExSKzNq?=
 =?utf-8?B?bE9KWng3NEF2blIzaXlHWGZ1eWhFa2Y5eXk3Qyt4ZHVzd3Iza0NpNVVlcVEv?=
 =?utf-8?B?dmVBRjd3cjU0eHBOMWFpTG9oZUZweHNmVHpqODVTMndRTno4NTE2MzV0VkpO?=
 =?utf-8?B?djVDUE9nck9lbFFUM3p6aCs2TTI3eDVqbExiaGtwL25zb2N5RlVsSkIzT2k2?=
 =?utf-8?B?MHdiSTIxemErZVNRMzhoMzFNOE9TaEdIeFJFMzAwbEJIckNjeUNhZzI1QmNt?=
 =?utf-8?B?SlN2TkN5RHdReFh1YWpYbDZpRkEzcDhLa282b1l2dzRlWTFRNjg4RjhZRWww?=
 =?utf-8?B?QU5mTnVQNWdtaEdnbTNCOGxRWjF3Uk5VSU1PYzFUc2M1dWZQWkhmV3RFdk8v?=
 =?utf-8?B?djlkZ1BMbHpWL3B2cVFwOGNtSHQxNEV1TEtseC81bzlNQU42bVd4bGkwclk5?=
 =?utf-8?B?cVkrMlBvWVFmSjVNc0llQ0NlNzM1Y1lld2VOVkx5MFIrSVd6RmcrSGQ4WEo0?=
 =?utf-8?B?d0hpNkplelA3OTU4ZWY4SlZ0SGYrcDJJeDRJNmdwaU1JY05VbkVJT3BDRGJE?=
 =?utf-8?B?SmI5MVJkUUVFRTFUUG1FUFVWV1pONE03cGRoTHF2YXBCdlMwQzRsUUpPWk9z?=
 =?utf-8?B?VUxrT2k3LyttcTZnRlY3N1B6NUthOW9YK0pvQmRFZUNpYWJiMHF4Y0dka2lo?=
 =?utf-8?B?Z0JLSkxwOTBzOUN6MThMMjYyaWxQbk5XeG9jSS9zaDlXUGc0UCtZQVIza3Zk?=
 =?utf-8?B?VExDRjNKTFkxTm9oS2NuNnhEVE1LQTNQZmRUY0JYM2xyT08vb0ZWelFLSXM2?=
 =?utf-8?B?MTZLWVRDOGlCdVo4RmszQk13enMxNXg5bnJrMytXaXZIcTd1b08rYVZjaFhU?=
 =?utf-8?B?TWZkdzYyMVNVRnpoZ0c2SDRXKzZXWE0vc0hZMUllWFM3WDFiK1dQdDQwOG1z?=
 =?utf-8?B?T2lHUENhTlA4RGd3TnJURnpvVWNYVE1KNFNWM25oM3gwaWMwQmtCWm4vYlR4?=
 =?utf-8?B?LzNaUnNTejBuazZobGRNV0tVdGZhSEZhM0dTaG5TOEMwSUJ5S2h3WnFvYmJK?=
 =?utf-8?B?ZUxoR3lSWDcrbWJjbjJDRzhrY0oyRzdBYVh0R3VMRmlURk9HRmtXeFl6VVN2?=
 =?utf-8?Q?6lw5GLwbsJfbaOWFfWalKpw/VZJqTSU/YkBZA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C20A7CCBE01A944E9AEC6B04B0BC38F8@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd852a0-b164-40a1-acb1-08da38fcaa02
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 18:31:46.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/60q0KmegcEJJZLZWKnTM7HmGePzLIjO7rI96E2hflnQmAo9wVZuyYemKv1335znqk2juIdgaCMBCKVURwFcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4865
X-Proofpoint-ORIG-GUID: DwFu3gPYBCJU9CAioGjgjt4M8aqOqKFr
X-Proofpoint-GUID: DwFu3gPYBCJU9CAioGjgjt4M8aqOqKFr
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gTWF5IDE4LCAyMDIyLCBhdCA5OjQ5IEFNLCBFZGdlY29tYmUsIFJpY2sgUCA8cmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCAyMDIyLTA1LTE4
IGF0IDA2OjM0ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4+Pj4gSSBhbSBub3QgcXVpdGUgc3Vy
ZSB0aGUgZXhhY3Qgd29yayBuZWVkZWQgaGVyZS4gUmljaywgd291bGQgeW91DQo+Pj4+IGhhdmUN
Cj4+Pj4gdGltZSB0byBlbmFibGUgVk1fRkxVU0hfUkVTRVRfUEVSTVMgZm9yIGh1Z2UgcGFnZXM/
IEdpdmVuIHRoZQ0KPj4+PiBtZXJnZSANCj4+Pj4gd2luZG93IGlzIGNvbWluZyBzb29uLCBJIGd1
ZXNzIHdlIG5lZWQgY3VycmVudCB3b3JrIGFyb3VuZCBpbg0KPj4+PiA1LjE5LiANCj4+PiANCj4+
PiBJIHdvdWxkIGhhdmUgaGFyZCB0aW1lIHNxdWVlemluZyB0aGF0IGluIG5vdy4gVGhlIHZtYWxs
b2MgcGFydCBpcw0KPj4+IGVhc3ksDQo+Pj4gSSB0aGluayBJIGFscmVhZHkgcG9zdGVkIGEgZGlm
Zi4gQnV0IGZpcnN0IGhpYmVybmF0ZSBuZWVkcyB0byBiZQ0KPj4+IGNoYW5nZWQgdG8gbm90IGNh
cmUgYWJvdXQgZGlyZWN0IG1hcCBwYWdlIHNpemVzLg0KPj4gDQo+PiBJIGd1ZXNzIEkgbWlzc2Vk
IHRoZSBkaWZmLCBjb3VsZCB5b3UgcGxlYXNlIHNlbmQgYSBsaW5rIHRvIGl0Pw0KPiANCj4gDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNWJkMTZlMmMwNmEyZGYzNTc0MDA1NTZjNmFl
MDFiYjVkM2M1YzMyYS5jYW1lbEBpbnRlbC5jb20vDQo+IA0KPiBUaGUgcmVtYWluaW5nIHByb2Js
ZW0gaXMgdGhhdCBoaWJlcm5hdGUgbWF5IGVuY291bnRlciBOUCBwYWdlcyB3aGVuDQo+IHNhdmlu
ZyBtZW1vcnkgdG8gZGlzay4gSXQgcmVzZXRzIHRoZW0gd2l0aCBDUEEgY2FsbHMgNGsgYXQgYSB0
aW1lLiBTbw0KPiBpZiBhIHBhZ2UgaXMgTlAsIGhpYmVybmF0ZSBuZWVkcyBpdCB0byBiZSBhbHJl
YWR5IGJlIDRrIG9yIGl0IG1pZ2h0DQo+IG5lZWQgdG8gc3BsaXQuIEkgdGhpbmsgaGliZXJuYXRl
IHNob3VsZCBqdXN0IHV0aWxpemUgYSBkaWZmZXJlbnQNCj4gbWFwcGluZyB0byBnZXQgYXQgdGhl
IHBhZ2Ugd2hlbiBpdCBlbmNvdW50ZXJzIHRoaXMgcmFyZSBzY2VuYXJpby4gSW4NCj4gdGhhdCBk
aWZmIEkgcHV0IHNvbWUgbG9ja2luZyBzbyB0aGF0IGhpYmVybmF0ZSBjb3VsZG4ndCByYWNlIHdp
dGggYQ0KPiBodWdlIE5QIHBhZ2UsIGJ1dCB0aGVuIEkgdGhvdWdodCB3ZSBzaG91bGQganVzdCBj
aGFuZ2UgaGliZXJuYXRlLg0KDQpJIGFtIG5vdCBxdWl0ZSBzdXJlIGhvdyB0byB0ZXN0IHRoZSBo
aWJlcm5hdGUgcGF0aC4gR2l2ZW4gdGhlIG1lcmdlDQp3aW5kb3cgaXMgY29taW5nIHNvb24sIGhv
dyBhYm91dCB3ZSBzaGlwIHRoaXMgcGF0Y2ggaW4gNS4xOSwgYW5kIGZpeA0KVk1fRkxVU0hfUkVT
RVRfUEVSTVMgaW4gYSBsYXRlciByZWxlYXNlPw0KDQo+IA0KPj4gDQo+Pj4gDQo+Pj4+IA0KPj4+
Pj4gDQo+Pj4+Pj4gDQo+PiANCj4+PiANCj4+PiBJJ20gYWxzbyBub3QgY2xlYXIgd2h5IHdlIHdv
dWxkbid0IHdhbnQgdG8gdXNlIHRoZSBwcm9nIHBhY2sNCj4+PiBhbGxvY2F0b3INCj4+PiBldmVu
IGlmIHZtYWxsb2MgaHVnZSBwYWdlcyB3YXMgZGlzYWJsZWQuIERvZXNuJ3QgaXQgaW1wcm92ZQ0K
Pj4+IHBlcmZvcm1hbmNlDQo+Pj4gZXZlbiB3aXRoIHNtYWxsIHBhZ2Ugc2l6ZXMsIHBlciB5b3Vy
IGJlbmNobWFya3M/IFdoYXQgaXMgdGhlDQo+Pj4gZG93bnNpZGUNCj4+PiB0byBqdXN0IGFsd2F5
cyB1c2luZyBpdD8NCj4+IA0KPj4gV2l0aCBjdXJyZW50IHZlcnNpb24sIHdoZW4gaHVnZSBwYWdl
IGlzIGRpc2FibGVkLCB0aGUgcHJvZyBwYWNrDQo+PiBhbGxvY2F0b3INCj4+IHdpbGwgdXNlIDRr
QiBwYWdlcyBmb3IgZWFjaCBwYWNrLiBXZSBzdGlsbCBnZXQgYWJvdXQgMC41JSBwZXJmb3JtYW5j
ZQ0KPj4gaW1wcm92ZW1lbnQgd2l0aCA0a0IgcHJvZyBwYWNrcy4gDQo+IA0KPiBPaCwgSSB0aG91
Z2h0IHlvdSB3ZXJlIGNvbXBhcmluZyBhIDJNQiBzaXplZCwgc21hbGwgcGFnZSBtYXBwZWQNCj4g
YWxsb2NhdGlvbiB0byBhIDJNQiBzaXplZCwgaHVnZSBwYWdlIG1hcHBlZCBhbGxvY2F0aW9uLg0K
PiANCj4gSXQgbG9va3MgbGlrZSB0aGUgbG9naWMgaXMgdG8gZnJlZSBhIHBhY2sgaWYgaXQgaXMg
ZW1wdHksIHNvIHRoZW4gZm9yDQo+IHNtYWxsZXIgcGFja3MgeW91IGFyZSBtb3JlIGxpa2VseSB0
byBsZXQgdGhlIHBhZ2VzIGdvIGJhY2sgdG8gdGhlIHBhZ2UNCj4gYWxsb2NhdG9yLiBUaGVuIGZ1
dHVyZSBhbGxvY2F0aW9ucyB3b3VsZCBicmVhayBtb3JlIHBhZ2VzLg0KDQpUaGlzIGlzIGNvcnJl
Y3QuIFRoaXMgaXMgdGhlIGN1cnJlbnQgdmVyc2lvbiB3ZSBoYXZlIHdpdGggNS4xOC1yYzcuIA0K
DQo+IA0KPiBTbyBJIHRoaW5rIHRoYXQgaXMgbm90IGEgZnVsbHkgYXBwbGVzIHRvIGFwcGxlcyB0
ZXN0IG9mIGh1Z2UgbWFwcGluZw0KPiBiZW5lZml0cy4gSSdkIGJlIHN1cnByaXNlZCBpZiB0aGVy
ZSByZWFsbHkgd2FzIG5vIGh1Z2UgbWFwcGluZyBiZW5lZml0LA0KPiBzaW5jZSBpdHMgYmVlbiBz
ZWVuIHdpdGggY29yZSBrZXJuZWwgdGV4dC4gRGlkIHlvdSBub3RpY2UgaWYgdGhlIGRpcmVjdA0K
PiBtYXAgYnJlYWthZ2Ugd2FzIGRpZmZlcmVudCBiZXR3ZWVuIHRoZSB0ZXN0cz8NCg0KSSBkaWRu
4oCZdCBjaGVjayBzcGVjaWZpY2FsbHksIGJ1dCBpdCBpcyBleHBlY3RlZCB0aGF0IHRoZSA0a0Ig
cHJvZyBwYWNrDQp3aWxsIGNhdXNlIG1vcmUgZGlyZWN0IG1hcCBicmVha2FnZS4gDQoNClRoYW5r
cywNClNvbmcNCg0KDQo=

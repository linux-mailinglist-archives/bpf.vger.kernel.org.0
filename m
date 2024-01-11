Return-Path: <bpf+bounces-19387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB982B7D4
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 00:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742771C24B3B
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5818C57870;
	Thu, 11 Jan 2024 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Bxede+YF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BCBFC08
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BMVnul005784
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 15:06:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=O0qugYhR7wQPSdHOAHFf5/OSsBw4cEEbP04C533Jl94=;
 b=Bxede+YFmxDVnzI1Or6EFIvACl8SfE7S0v6tJdRq+piBUp9Dng2AN2yB0ZpDWb1YfIy7
 MSE5XrNFJkDtYCYwMemOxh47fuV9rsiHlXZYg9ybH4wRR2VpauNZwdxqe7gmdLIG2rw/
 rU1uDj0qOIQ4w9KL6nDpdDM6s+sx5oaBfmV6tWZAyaOkEFH5I9Rz+Xf0q6jnNuVPb8LV
 xEVhuOBqGRdvwTePFZauqbOO2MG3+vTXY3K32ieuxIGSxqZanOtIymaZzopSEMyyrolH
 AioCcbqWNIXAaKRBmaMQDWQjYmkhbM335wHnPgPbIYE469KHkv91lh3wxU17JGspJPdf 8A== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vjp869d2b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 15:06:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8brQv0IDVhMRHCokp9vMvY1zEKdXdhLTrf+bL4kwqyr9T+5sBFuBoKtsLZu2xvUak2VtnibcyGY4JV63YVNYRr7tfb1uK+zXPFfJB1RRpWwNdkYF0jITSJgXCSy81Yk7fSUShLNc+JMzCH71b+Ec2DQ8SlzGEXa/Udn7lZNuGHSHfB+wtKRBU9pAG/Gmde++dpxC3VZMLrWeglR3QOVL0t7gcGivKVKlmV+VsmAznC5EK+wTnwVcUj0ZiRQHz5t/ig07zSA3YsFOM/ZRcHANpte4yWj2CE8xaJ8N7C8ilKX6dBU0SBpETQXtnZbiwMu5qjb6FMelP/u1MTg8LvaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0qugYhR7wQPSdHOAHFf5/OSsBw4cEEbP04C533Jl94=;
 b=cQKqDaHOPcJAVQqIxm8D50csigZGIB2+6M5SKtbYezI0tRGuLJgt75xcFTnWKLza0H0GjQSsIr2df4bfgFVlhrMf6rTwqfR5Ze9L/pigR2qHNmoBKiou/bKofOTMJ0Yb4+JoaCs5TzcmgxPhWd+RBn+dSZc6p1RFBpgAJg5B6IMwKVTI8foE8tDW/dZX6pGPJ7xiSkac7oYRXu5fGInW3mhTGuKv20p9NUVVmd86M/TdpSyihu9CMMo4cewUaVZ3pv7S/ig7Z8NKlBiaGANFlzXfWZv08Fu+77alLuuI/652rQ9KcSt5CEBgr04ffRWrOiN3Gryh2bzuUno/wgYzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW5PR15MB5171.namprd15.prod.outlook.com (2603:10b6:303:199::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 23:06:23 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f568:18bc:2915:d378]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f568:18bc:2915:d378%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 23:06:23 +0000
From: Song Liu <songliubraving@meta.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: Song Liu <songliubraving@meta.com>, bpf <bpf@vger.kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alan
 Maguire <alan.maguire@oracle.com>,
        Jordan Rome <jordalgo@meta.com>, Yonghong
 Song <yhs@meta.com>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: RFC: Mark "inlined by some callers" functions in BTF
Thread-Topic: RFC: Mark "inlined by some callers" functions in BTF
Thread-Index: AQHaRNhGas8sywhOAEu7Lx4Jcjz6cbDVNwCAgAAE2QA=
Date: Thu, 11 Jan 2024 23:06:23 +0000
Message-ID: <DF3DD763-E5F2-4032-8F54-E25AA1270E12@fb.com>
References: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>
 <rclqt5yod7n5l3cjuptadouxw3xshcedibgfe4fc3qjy6psuf7@qj2cjmzu5iwe>
In-Reply-To: <rclqt5yod7n5l3cjuptadouxw3xshcedibgfe4fc3qjy6psuf7@qj2cjmzu5iwe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW5PR15MB5171:EE_
x-ms-office365-filtering-correlation-id: 72dd6c5a-6d5e-4767-89ef-08dc12f9ee23
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 r+X10jQIZIqvAtbx/6qSxtjmAXZfkxQ13sDc2AsChJRgiex2oM5IjtO6Nhjhy6CNcRkxdza9obGEt0xs7P6goFHjSQ/babkThLUA16ZmmoNwgdGxNs5va4HCzVqztW0wIXxhhT7uk7qkCvEBrE2zscgHIHHVOyoJl9fLrUgM3ZQek7GZk9kLtukHXKtuxLRie4Y2i2SKtHuQx6jpinnM56DZvEHwAA3vPYjwfSAQqxRLUamKsefujYrKuQhfqdR00yTFsAJ+oDdHgUKxUPfkQSEGEHPkLUhliJciiw7THcuMYPwtHt4EWIJxDQaXkRLR2KeG8LCp63hVwEs2jnB7NAhpJ206/TRTZG0M0osUgFO5YSh17OvW1kwrEGAo9ILmMWgyMyBGX3mEmHj+MnpQiFBlbeNfRtKXuvPmDEsj8Av9R6d3Fgm1loIzBSwMTwl1FYinj+GxNhfetbilrwuaET0Bc2oltTjzeAwGtNnUzcL7uFZRhn6XGCUmlROddQHcJ2w8bEFZtpfg/kXO0ML8l4j6w9Lbj1tggxbHaEcFuIWEd0sBIWORbQH+GEmDQfuJ6mjbrAlMHHnhv71kE9D2PFSprPsmh/b3SqyG/1Yhi5x2f/x1lp7vn48uUSfjpsoV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39850400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(6916009)(316002)(66556008)(66476007)(76116006)(66946007)(64756008)(54906003)(66446008)(91956017)(71200400001)(38070700009)(53546011)(107886003)(9686003)(33656002)(122000001)(8936002)(8676002)(36756003)(4326008)(5660300002)(38100700002)(86362001)(6486002)(6506007)(6512007)(41300700001)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cFJIM3FlQzJPbWNjbEdmN1NmVVcvZU04ajN4cFhqVHY3L0xtcXAzcVo4Q21T?=
 =?utf-8?B?L211dHdQRHZRSUdabllLMWlyc0ZnUThhV1d6VUJrODZ0SEU2dXFZeGg3QmN3?=
 =?utf-8?B?MXIvdkk3VVkxcmpYOFhkd2tzbXQrajVTQk9IclBRYUJmbVdOa3FGZmt4RWFJ?=
 =?utf-8?B?ckRoamlmRWY1a0YwS3V2Mm1IS2FyeVJ4NWZaWFh4cm1sbVhGQ3RWcVNJaUNj?=
 =?utf-8?B?TGtYNHh5eUtBcU5WZTF4aHRNcXlhOGYxeEYxUGV4ODlsaS9sejBPVnVxQmV1?=
 =?utf-8?B?QlVWOUN0UGZNU3ZOQnVlUGlYMTZEZ0k5K25LKzJDTHhIaFJhRll1VFVnTGhn?=
 =?utf-8?B?TmlJTzBLMUJJQWRZNHhKRzFmMm9nejJiVlVnVlAzMG9UOHRzMFZIZGc2TjZs?=
 =?utf-8?B?S3FOOWpucEVhQ0JJa3c0dUk4a3FYVEU2U05qMjlZdFcxa09UV09tUFg1aERD?=
 =?utf-8?B?Wk1GdXhBcnhld3phWGRNSU95cyt6YkdyRWhGdm5zVndHS2pQbTNsOHdCd3lr?=
 =?utf-8?B?MHF2L2JqQ3pzaVlxSUFuQzJramoyRCs5cU81V0ZFcXlxVDZkY3JTUU8raEp2?=
 =?utf-8?B?WnlucVkxU3d3RnJiQWt2c0hDRTJrT2grcWJlb3lYRy9wMWdPbStRdkNQNE9x?=
 =?utf-8?B?ZHlGN2FwT2xENDVxdit2WWpUei81a0Eyb0lYS3RGdWRSQ2lHY1JQdmc1K3BP?=
 =?utf-8?B?ZzdCQm51enVQbTlLQUhRcms2enJGd1Iyb1N6UlRXcUxNb3V2M0hvUWlHelAw?=
 =?utf-8?B?NUY2aHBQUVl0QUNiU0FTdndLdDhoKzU0L0x4d0Z1ZGllTnNNUGRIWFBYbTBH?=
 =?utf-8?B?djJPNCtPcHlpc2d3Z2dYa3BIN3dSKzhRUlFweE5qakVyY2xjUk94M2FLNFBp?=
 =?utf-8?B?bFlVTTVwVE9xcC9NNzJNZ3o2VndzMjRaVEtwUjdMdURtWFJhQ3FFVGtlSDhY?=
 =?utf-8?B?WEpKMXpwcW9XK0lDMndMSHdtcm5uazVOeVhCTHd0VXJvWVRpYllRa1VMQU5P?=
 =?utf-8?B?M0hWU2RZUVFZTUkyMzVBRmZyWUt5MTQyd1QvcFZGMXJJZ0NXZ1NKZjdlSXVp?=
 =?utf-8?B?RGpLT0Jab0h2Vi9xQmk1QmZVOHhMQThDOWpjVEZkMVJnRlI3L04xeWRRdkVx?=
 =?utf-8?B?YUZoK2hJWWVtZEdaMit4QXY4M3EvaUdSNGN0bXBqS0c5WUZUUHlQV09GMTJJ?=
 =?utf-8?B?ZFJIVGI1ZDgyWnBlSlZXcTR6bHRnaXJqQ3p2RmlPSFZid2lDSi9XekE5cWZm?=
 =?utf-8?B?N0M1cTJWb2VMVml2YnB3M3dXTEJyVVB5cXd0TnNhQzg2bGJkR1hjMlA3b2dE?=
 =?utf-8?B?ME01RG40d3VJRW1QT2ZSRnJXcWtpUkRrWFZvZU54N2Z2YlVnZEZXQURhaWZH?=
 =?utf-8?B?WFd0elJCc2Q0L2hSR056eDdNcjJ3UXBnTzJCRE1BTjNpQzhkQnhUN2Y3ODh5?=
 =?utf-8?B?Z2V1MWd3RnFpUGNqVDlmMklxM21sK2VOcjFqNExXTDVtWTNOalYxdlJUZ0t2?=
 =?utf-8?B?VVJoNExUaFpiRDBwZGt2RWJzQkdtbFdLNERkK3RvNlEyMnVjdTlzdkxOcU4x?=
 =?utf-8?B?U0lhZkg5dWprb1kvbHhTNUluRnF3Rk54SWVhSTRrSy9yUDJLaWFRQVZla1dw?=
 =?utf-8?B?ajFLa1p5eEgvLzNDcGNMK25yenZlR0grblZuQzg5elZWcHYycFNBVFhJdGxw?=
 =?utf-8?B?eWJRM0sxSC80ZGRKUWVtaWJyVndTZDd5MDZCZVBzZEhjQ244M20xNktFUFpi?=
 =?utf-8?B?ZDd4aEVFbTMwOUNuMENPNmVObk1uaWJFSjBvdDAvRWJJZlRCNk9pbytnb05G?=
 =?utf-8?B?U1NxbFVxeW84SGRXRVNNaENwV0Y5R0NVdWI3ZEE2dUcrVHpXdFJUbWRUbTVJ?=
 =?utf-8?B?TnVoWXpzY09CWXBIdzhWM3Y3SFBEdGVyRnB4ODNhSjZpZkVxYS82Qng3MFZw?=
 =?utf-8?B?Rys3cnZqbkZ2aWRaaFlRUUtiRStZKyttL1h2QmtrZWkrU3kvL2tKRmRJMmxH?=
 =?utf-8?B?SDVNc1lzVDk1TDh3ajRXVytvNzBPYUFXTm1jTXZrYkFlaXBZeGJLdmYzYlB3?=
 =?utf-8?B?SnJEQ0hXM3RjcDBzV2RQZmZwa3pXRk9ONzN1SjQ3eHMrYmY1eEYydjRhajlN?=
 =?utf-8?B?OHBYUUczL3dKOUN6VkN2NUdveW12YW4zODN0U2FvTXpianJEUHU3NStYT2Rp?=
 =?utf-8?Q?PVhCpJws66130gKd6L5WMFk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9431E980949FE44FBBF162DB7DD61B5D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dd6c5a-6d5e-4767-89ef-08dc12f9ee23
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 23:06:23.1132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fO3kmOACnALATzA0xGibSdFwL71A/lD9wX1izq/XyUmLICPDpK9eCfL0qp+CAWgDRDh+XO/bhljM36iyKR5OCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5171
X-Proofpoint-GUID: 3m_OLPWy0jFqPonOY1xkFoQpdbTFIld6
X-Proofpoint-ORIG-GUID: 3m_OLPWy0jFqPonOY1xkFoQpdbTFIld6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_13,2024-01-11_01,2023-05-22_02

DQoNCj4gT24gSmFuIDExLCAyMDI0LCBhdCAyOjQ44oCvUE0sIERhbmllbCBYdSA8ZHh1QGR4dXV1
Lnh5ej4gd3JvdGU6DQo+IA0KPiBIaSBTb25nLA0KPiANCj4gT24gVGh1LCBKYW4gMTEsIDIwMjQg
YXQgMDk6NTE6MDVQTSArMDAwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBUaGUgcHJvYmxlbQ0KPj4g
DQo+PiBJbmxpbmluZyBjYW4gY2F1c2Ugc3VycHJpc2VzIHRvIHRyYWNpbmcgdXNlcnMsIGVzcGVj
aWFsbHkgd2hlbiB0aGUgdG9vbA0KPj4gYXBwZWFycyB0byBiZSB3b3JraW5nLiBGb3IgZXhhbXBs
ZSwgd2l0aA0KPj4gDQo+PiAgICBbcm9vdEAgfl0jIGJwZnRyYWNlIC1lICdrcHJvYmU6c3dpdGNo
X21tIHt9Jw0KPj4gICAgQXR0YWNoaW5nIDEgcHJvYmUuLi4NCj4+IA0KPj4gVGhlIHVzZXIgbWF5
IG5vdCByZWFsaXplIHN3aXRjaF9tbSgpIGlzIGlubGluZWQgYnkgbGVhdmVfbW0oKSwgYW5kIHdl
IGFyZQ0KPj4gbm90IHRyYWNpbmcgdGhlIGNvZGUgcGF0aCBsZWF2ZV9tbSA9PiBzd2l0Y2hfbW0u
IChUaGlzIGlzIHg4Nl82NCwgYW5kIGJvdGgNCj4+IGZ1bmN0aW9ucyBhcmUgaW4gYXJjaC94ODYv
bW0vdGxiLmMuKQ0KPj4gDQo+PiBXZSBoYXZlIGZvbGtzIHdvcmtpbmcgb24gaWRlYXMgdG8gY3Jl
YXRlIG9mZmxpbmUgdG9vbHMgdG8gZGV0ZWN0IHN1Y2gNCj4+IGlzc3VlcyBmb3IgY3JpdGljYWwg
dXNlIGNhc2VzIGF0IGNvbXBpbGUgdGltZS4gSG93ZXZlciwgSSB0aGluayBpdCBpcw0KPj4gbmVj
ZXNzYXJ5IHRvIGhhbmRsZSBpdCBhdCBwcm9ncmFtIGxvYWQvYXR0YWNoIHRpbWUuDQo+IA0KPiBD
b3VsZCB5b3UgY2xhcmlmeSB3aGF0IG9mZmxpbmUgbWVhbnM/DQoNClRoZSBpZGVhIGlzIHRvIGtl
ZXAgYSBsaXN0IG9mIGtlcm5lbCBmdW5jdGlvbnMgdXNlZCBieSBrZXkgc2VydmljZXMuIEF0IA0K
a2VybmVsIGJ1aWxkIHRpbWUsIHdlIGNoZWNrIHdoZXRoZXIgYW55IG9mIHRoZXNlIGZ1bmN0aW9u
cyBhcmUgaW5saW5lZC4gDQpJZiBzbywgdGhlIHRvb2wgd2lsbCBjYXRjaCBpdCwgYW5kIHdlIG5l
ZWQgdG8gYWRkIG5vaW5saW5lIHRvIHRoZSBmdW5jdGlvbi4gDQoNCj4gDQo+IEkgd29uZGVyIGlm
IGxpYmJwZiBzaG91bGQganVzdCBnaXZlIGEgd2F5IGZvciBhcHBsaWNhdGlvbnMgdG8gcXVlcnkN
Cj4gaW5saW5lIHN0YXR1cy4gU2VlbXMgbW9zdCBmbGV4aWJsZS4gIEFuZCBtYXliZSBhbHNvIGEg
c3BlY2lhbCBTRUMoKSBkZWY/DQoNCkFQSSB0byBxdWVyeSBpbmxpbmUgc3RhdHVzIG1ha2VzIHNl
bnNlLiBXaGF0IGRvIHdlIGRvIHdpdGggU0VDKCk/DQoNCj4gDQo+IEFsdGhvdWdoIEkgc3VzcGVj
dCBlbmQgdXNlcnMgbWlnaHQgd2FudCBhIGZsYWcgdG8gImF0dGFjaCBhbnl3YXlzOyBJJ20NCj4g
YXdhcmUiLCBzbyBhIG1vcmUgZ2VuZXJpYyBhcGkgKGVnIGBidGZfX2lzX2lubGluZWQoLi4pYCkg
cmVzdWx0cyBpbiBhDQo+IHNtYWxsZXIgYW5kIG1heGltYWxseSBmbGV4aWJsZSByZXN1bHQuDQo+
IA0KPj4gRGV0ZWN0ICJpbmxpbmVkIGJ5IHNvbWUgY2FsbGVycyIgZnVuY3Rpb25zDQo+PiANCj4+
IFRoaXMgYXBwZWFycyB0byBiZSBzdHJhaWdodGZvcndhcmQgaW4gcGFob2xlLiBTb21ldGhpbmcg
bGlrZSB0aGUgZm9sbG93aW5nDQo+PiBzaG91bGQgZG8gdGhlIHdvcms6DQo+PiANCj4+IGRpZmYg
LS1naXQgaS9idGZfZW5jb2Rlci5jIHcvYnRmX2VuY29kZXIuYw0KPj4gaW5kZXggZmQwNDAwODY4
MjdlLi5lNTQ2YTA1OWViNGIgMTAwNjQ0DQo+PiAtLS0gaS9idGZfZW5jb2Rlci5jDQo+PiArKysg
dy9idGZfZW5jb2Rlci5jDQo+PiBAQCAtODg1LDYgKzg4NSwxNSBAQCBzdGF0aWMgaW50MzJfdCBi
dGZfZW5jb2Rlcl9fYWRkX2Z1bmMoc3RydWN0IGJ0Zl9lbmNvZGVyICplbmNvZGVyLCBzdHJ1Y3Qg
ZnVuY3Rpbw0KPj4gICAgICAgIHN0cnVjdCBsbHZtX2Fubm90YXRpb24gKmFubm90Ow0KPj4gICAg
ICAgIGNvbnN0IGNoYXIgKm5hbWU7DQo+PiANCj4+ICsgICAgICAgaWYgKGZ1bmN0aW9uX19pbmxp
bmVkKGZuKSkgew0KPj4gKyAgICAgICAgICAgICAgIC8qIFRoaXMgZnVuY3Rpb24gaXMgaW5saW5l
ZCBieSBzb21lIGNhbGxlcnMuICovDQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICAgICAgICBidGZf
Zm5wcm90b19pZCA9IGJ0Zl9lbmNvZGVyX19hZGRfZnVuY19wcm90byhlbmNvZGVyLCAmZm4tPnBy
b3RvKTsNCj4+ICAgICAgICBuYW1lID0gZnVuY3Rpb25fX25hbWUoZm4pOw0KPj4gICAgICAgIGJ0
Zl9mbl9pZCA9IGJ0Zl9lbmNvZGVyX19hZGRfcmVmX3R5cGUoZW5jb2RlciwgQlRGX0tJTkRfRlVO
QywgYnRmX2ZucHJvdG9faWQsIG5hbWUsIGZhbHNlKTsNCj4+IA0KPj4gDQo+PiBNYXJrICJpbmxp
bmVkIGJ5IHNvbWUgY2FsbGVycyIgZnVuY3Rpb25zDQo+PiANCj4+IFdlIGhhdmUgYSBmZXcgb3B0
aW9ucyB0byBtYXJrIHRoZXNlIGZ1bmN0aW9ucy4NCj4+IA0KPj4gMS4gV2UgY2FuIHNldCBzdHJ1
Y3QgYnRmX3R5cGUuaW5mby5raW5kX2ZsYWcgZm9yIGlubGluZWQgZnVuY3Rpb24uIE9yIHdlDQo+
PiAgIGNhbiB1c2UgYSBiaXQgZnJvbSBpbmZvLnZsZW4uDQo+IA0KPiBTZWVtcyByZWFzb25hYmxl
LiBEZWNsIHRhZyBpcyBhbm90aGVyIG9wdGlvbiBidXQgcHJvYmFibHkgdG9vIGhlYXZ5Lg0KPiAN
Cj4+IDIuIFdlIGNhbiBzaW1wbHkgbm90IGdlbmVyYXRlIGJ0ZiBmb3IgdGhlc2UgZnVuY3Rpb25z
LiBUaGlzIGlzIHNpbWlsYXIgdG8NCj4+ICAgLS1za2lwX2VuY29kaW5nX2J0Zl9pbmNvbnNpc3Rl
bnRfcHJvdG8uDQo+IA0KPiBUaGlzIG9wdGlvbiBzZWVtcyBhIGJpdCBjb25mdXNpbmcuIEJhc2lj
YWxseSB5b3UncmUgc3VnZ2VzdGluZyB0aGF0Og0KPiANCj4gICAgICAgIGZ1bmNfaW5fYXZpbGFi
bGVfZmlsdGVyX2Z1bmN0aW9ucyAmJiAhZnVuY19pbl9idGYNCj4gDQo+IGltcGxpZXMgcGFydGlh
bGx5IGlubGluZWQgZnVuY3Rpb24sIHJpZ2h0PyBTZWVtcyBhIGJpdCBub24tb2J2aW91cy4NCg0K
SSBkaWRuJ3QgdGhpbmsgYWJvdXQgYXZhaWxhYmxlX2ZpbHRlcl9mdW5jdGlvbnMuIE15IG9yaWdp
bmFsIGlkZWEgd2FzIHRvDQpub3QgZ2VuZXJhdGUgQlRGIGZvciB0aGVzZSBmdW5jdGlvbnMsIGFu
ZCB0aHVzIGRpc2FsbG93IGF0dGFjaGluZyAoc29tZSkNCkJQRiBwcm9ncmFtcyB0byB0aGVtLiBJ
IGd1ZXNzIHRoYXQgd2lsbCBub3Qgc3RvcCByZWd1bGFyIGtwcm9iZSBhdHRhY2guIA0KDQpUaGFu
a3MsDQpTb25nDQoNCg==


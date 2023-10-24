Return-Path: <bpf+bounces-13187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D58157D5E9F
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 01:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E80B21106
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DA144486;
	Tue, 24 Oct 2023 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WPwRjhtX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F572D63D
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 23:21:19 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32EAD7A
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 16:21:17 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39OH2Nts028601
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 16:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=InrUg1Gc7o2eMaEDgB1f7MTl1DVeS1dvQHwmt6lC2LA=;
 b=WPwRjhtXZ2VXJaOfg9m59cTGcZio5md01X88i4adLTgx/j/KW/54HicG6fKvmMaKL5AD
 yWWmU0Ic6vHQLDyxzjcCh6Nnt+oFfb5/3Ibvram3r93nRtRUiLWReDpAiHiQuca0dNzZ
 kNJEEJLUQ92pc9D2yWtZCS/tZXTucR6oUdhVIIXKF93IvokmKsc/sQTI26M8VF71GblN
 vzT2Ds5ulMTnV0n9CuV0YOt4FVH1C/tmBMowjaHExvSoVm/dGp9GXAxYRMNdGh+hAvqG
 dtEsoe7n6R7CYvXUP71ACVFnVvgIQIYhSmhhZnCWZLm5P4qv89Y0GYBOHbwq/NyG7HEr CA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by m0001303.ppops.net (PPS) with ESMTPS id 3tx9jknn2b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 16:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB0ZB9LlVEp0u1gPJPfDDRgSV5q9sbbRMOCnu//OxDq1wgWnSv+DqHOtmJvbWNiyhCO5+4E2E4vZYxYixGF6lbm5+KQ5T1RTqJeIrzPrA6jswn8ilTXqmjzsxhn71c2og+25UVsL0oRx11hFn/K9sj1TKcuX6horopBzI2QEi2cdB/208QnF+PLZWiFAIAdlUiN8le2eVIDSDqz0B72UZVbehTgJuwwxATQ0DyOcBBZjRA0Puv6QwfrqoWuisr24eQ6F+yUdu6RJ+k9pnjTu21n0STu4auY3QUwMxgPHvFCd6QNSuUl/Ru11ktyVP1IPfbZjNXCxAb3nN2TJLYcl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InrUg1Gc7o2eMaEDgB1f7MTl1DVeS1dvQHwmt6lC2LA=;
 b=f+eDVocN+SmKgbICiniqlMB0xIFE55Vpe4gtU7L1eCGAJecjL4JUWq13WYLHVZ9XdCeXfMgBdvJ45Tw29CLyKV/lUUozoPDR0VeNdWAAoLTi8omv8bz9bs+PE340TQtLiEYh4SWjaVh6W6M+Bs8Me4W3QYcTtVUyX1LVPjkkGtDb/5Gi6MpdobKrgpl2IOtw0CUiKwIaEEUMNQZCn4ztFaoM8V1kaPmiqB7vBN1OD0/Z3WiKESXYSId/rLVKoxRT6ojmsve1C4DNCgvWeEZ3A6lBF5RZeQG+NhukUiJHzHMB9JIeYAcN833X6Ma+NFx6MIlRCiRwtTWoin8xb3I19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB5992.namprd15.prod.outlook.com (2603:10b6:610:166::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 23:21:14 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c495:8487:66f1:18be]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c495:8487:66f1:18be%4]) with mapi id 15.20.6933.014; Tue, 24 Oct 2023
 23:21:14 +0000
From: Song Liu <songliubraving@meta.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>, Theodore Ts'o <tytso@mit.edu>,
        "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v5 bpf-next 5/9] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Thread-Topic: [PATCH v5 bpf-next 5/9] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Thread-Index: AQHaBkPBpZYYcaedJUy7sDUe/MhhI7BZkByAgAAE34A=
Date: Tue, 24 Oct 2023 23:21:14 +0000
Message-ID: <27D20897-366E-484A-8335-9427FB98B96F@fb.com>
References: <20231024063056.1008702-1-song@kernel.org>
 <20231024063056.1008702-6-song@kernel.org>
 <20231024230337.GA2320@sol.localdomain>
In-Reply-To: <20231024230337.GA2320@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB5992:EE_
x-ms-office365-filtering-correlation-id: 9d65b495-a1f6-4727-cb80-08dbd4e7ea9b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 k2Y6GeR8CmsyslmEJiOpK0ti873IwdSySX2ZIiuUVByXOBIQJNbJBm2RTjz7Fnpdbu3sK/wVCop96gupJpARxw1ZOGPpSGD3+D/In9BAlgaBYeqQW3WzRDjIEPcKa4wUtTXug8+buCroHteQXhho+uxIPpjQCuDvGzZ5+Z4ebgb1TkH2Fsk6uXmUc/p/8+QSM3mPOs5aI8tDelPTG2NnhXCkiAxuvAQ1rkqjVkhnDTOrowscwT4wLX4JBdDufoIzAvI5TmQYMX6EO9VPeea7ZgwejDvDuqw9bt08EFoqlwDdcF/izqqwItrf2pAYPLi8pTrqFgQRFcTWLZ32yzuePvpZfGOeR9rgQXSVi92EQL1+CAeSjk4UWsd2QOdWjuUPYkrwPSwFCEtZJAdwtsV4n954/iz2ca/vdmIt71gjcqd9w9d1ygl+VdXXNNz8la5tfS1Ndu/K6IbaFJJvze/KfezB01V9jYAuZfag5Cp3fu/0h+psZKzvCNVQ4On5xYVx7g1V+m4PAA2pZ+2J9K2yxlIYt7xvzhUVU74PCCwgs5JXrclXhy8LU7DspnSeWeU3Xn1VQqIgQz1WAfxelKim0qfqnQ8xgg0VaLf9kS7rN3AVuSXnWPM5fuJurhKlL/Rp
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(38070700009)(478600001)(53546011)(6512007)(9686003)(36756003)(38100700002)(33656002)(122000001)(86362001)(83380400001)(8936002)(66556008)(6506007)(41300700001)(7416002)(2906002)(6486002)(71200400001)(8676002)(4326008)(66446008)(316002)(6916009)(5660300002)(64756008)(54906003)(76116006)(66476007)(91956017)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?blQveXhqQ1FGZEdNR20zaVg4SHA3by96NkxmNWFnYXRndnhDUktQdlpVQjJa?=
 =?utf-8?B?VjZ3Wi9HQUdJZnBtUDhONDlJL3lSQzdnSmY0Z1hjNHRPenJhN0tXenBDcEw2?=
 =?utf-8?B?UUI2K1BjcFFjRThMU3BkQmZKRWpsVDcvL1ZVYUtSTnNmdjd2dmJJUCtNV2tQ?=
 =?utf-8?B?S1V2azRSOGVtMXd2S25mQ3hGeE9acTFxSDkwTDRaMFgzYnJCTTJTOG0yYkFE?=
 =?utf-8?B?dVliZEllSjkvemgrQ2ZKR05DWlFLTUZud0NxSVo5bDNQYXVSYnJhS2FPUmFx?=
 =?utf-8?B?am1aNlBxSkZNRUZGc1MxZGk0bUp2OUpid0gremUvanNqcTNBYjRxNXJSN25p?=
 =?utf-8?B?bUlNVlp6dm5FLzlHWWkzS2FRNG93bmpvTjgyTnFEZkJuZXQ1ekc5RWozRkE2?=
 =?utf-8?B?OFNsNWdvSWJUZ2VLb0llWkdWVUpXNEpjaExlcGU5L0YraXgrSzVSVFhxNTY3?=
 =?utf-8?B?bkdyQjdTdFdRSmhGYk5DUmU2UVFVSzU1a2pFc3lTN3A1bmc1am9uUEFFK1po?=
 =?utf-8?B?Tk9jM1cvUGg0U1h6dGxsL0x2UWdnSDBoREhzVVV2K2xEQlJqSUlMM0o0ekdz?=
 =?utf-8?B?ZzNxTVhUT0pVUHlRMXljR1ZUUlJXWFdWcmtPSmRUdVY5ZEF5UUtUcEc3b3By?=
 =?utf-8?B?NTZISzkrRzMxMGFtWlJNSlNBNjhMejhvbXBKQXBRV1JISEZTc2thYWFDbXFX?=
 =?utf-8?B?SFE4R1lIU3djYlE1RFQwdnIzbGpZZUtRM1hOMFF5M2I5NFhxYlhETkNPeUFU?=
 =?utf-8?B?d1ZRMjF1aVZsWlZnQVpkcEpQRHNDcnhwbzNMaERyZGJ6N1EvYVRHdEZ5L1dm?=
 =?utf-8?B?L2pmTEpsb0ZuakRtZlpZK1BLNzFlenZISmF5QmQvYmdUUW5BZTVEa0hNczRR?=
 =?utf-8?B?VWg1SnFNOE02eW9Yd3d2NWNPTTYzOXNuYmZJQ0g1cXF1K0c3c1VrRXJRNU1I?=
 =?utf-8?B?RnhYSm94eFdpeDVZMGZoQ2t0QlVRVTBrWWMrT0FwWGV6QnkvOG5wcG02SWhD?=
 =?utf-8?B?UUlML0JmbDMvTUpLSkQ1L0x5TFFHZjRYYlFWcXNGQ0QwV0s2UndJc08zMkpr?=
 =?utf-8?B?TkJHV3U1WEJFMDNDbW9XWUhWdWVFM0RlbVcvTTNXakpadXRrRVptNDRLczlD?=
 =?utf-8?B?cSs4SjV0S1dMa090STIxeWJxeDR4QnlrZkdPRGlwMG00OURCN1dHZzZoQXQ1?=
 =?utf-8?B?QmQ2eHMwajBZajNTcWVUUm9OdzFQREVOd3NOdkRwZ3d3NHNvR3MwUFBCM2xj?=
 =?utf-8?B?N05sa1NWeHNlOUVYRGltcVpwdHloQ091WWl4RzdJYnRnd3U1R0tVZ2Z4MTFp?=
 =?utf-8?B?ZXRiNHpRYXh2bnVKUHI0R0t5TUNQVSsrRFhIQzlUWHR4QzFteGkvLzAvKzYv?=
 =?utf-8?B?VUJyYVpGWStXdUphYTM3emZ6Mzd1U0UxUWFhcHZYVFhWSVNBZVUyOVdhcGhP?=
 =?utf-8?B?bzhjT3dnKzBXNk9PamNabFkwNTA2azBlN0JwWCtWSFQvajZhSzltUWx5RkMz?=
 =?utf-8?B?L09scVk3MFJZWXB4bGZVSE9HQ0JOQU9TYnpaSVMvOHgxdVZTRmpXQjZuaXNC?=
 =?utf-8?B?Z0tXMnJlekFTbTNIaXRZN0tpRXRxSXA1bG1uY01wbWJ6bExTcUdvTzZaZDdO?=
 =?utf-8?B?dnVYcDJQUGo3d05kNFhUTkp0K3pOVy9lYnZoRUl1SXA0YUYvbUNsRzBobWtH?=
 =?utf-8?B?aEFScjNBTHp6WXdpczZ6TlE3MGRjNmhZSFRDQ2lEWUNrYmhiWVViOHN1V2d0?=
 =?utf-8?B?WmtadHFkVGlWNU5YY3lnT25hRGIvaC9mUmF2OG4wWG1TUGluQXRSYVNQZE15?=
 =?utf-8?B?a0RmeEFCeVpmYUFEZVhFREM4ZnRGdTJ0cDFHWm5uUmE1a0VvcTB3Zm9kUzJR?=
 =?utf-8?B?TGZadEl2cVNRYUNqT0ZJY1JXQ0diMlRHMkhKMzBwWlF3WDBRUFJZL0FYUmg1?=
 =?utf-8?B?blRrWlVMQnhDeTZaTFRsVitReHBPdUdZWjlkWFlHbUR0Tng0MmJONzV0dXlu?=
 =?utf-8?B?L01vMk5rQjZlcmNpVnBWbEJ0akRhdU9VRkpkTzBLSFQrQ2ZzZE1rM1RmUDdV?=
 =?utf-8?B?Vk52NnZheTd5VWRDVXVSUnhSclQ5ZEd2ZDExL3dCem9KTzN6M1cyYVpFTjI5?=
 =?utf-8?B?QnZ5cG5PZU1OWWROb2QydktwSDZacTNTVXJTR0g4NTcwRjU1WVJnUDNwWlBv?=
 =?utf-8?Q?p7S7RNjvRZ0wGpmkk1/oN8Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99D49A2ADA18FE40AEA75BC1F6FD94D5@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d65b495-a1f6-4727-cb80-08dbd4e7ea9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 23:21:14.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89RxPInTeYfZukCbAqltVsC6gw62lDUVufsbmXSMLXno1BaKXN1EVLb0u8aj9cGVQ25ZTswNgtbJ6w5xOUqgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5992
X-Proofpoint-ORIG-GUID: Sl2vHzE5Z8m3MaMdteZc3eTpyJywqkon
X-Proofpoint-GUID: Sl2vHzE5Z8m3MaMdteZc3eTpyJywqkon
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_22,2023-10-24_01,2023-05-22_02

DQoNCj4gT24gT2N0IDI0LCAyMDIzLCBhdCA0OjAz4oCvUE0sIEVyaWMgQmlnZ2VycyA8ZWJpZ2dl
cnNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIE9jdCAyMywgMjAyMyBhdCAxMToz
MDo1MlBNIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4+IGZzdmVyaXR5IHByb3ZpZGVzIGZhc3Qg
YW5kIHJlbGlhYmxlIGhhc2ggb2YgZmlsZXMsIG5hbWVseSBmc3Zlcml0eV9kaWdlc3QuDQo+PiBU
aGUgZGlnZXN0IGNhbiBiZSB1c2VkIGJ5IHNlY3VyaXR5IHNvbHV0aW9ucyB0byB2ZXJpZnkgZmls
ZSBjb250ZW50cy4NCj4+IA0KPj4gQWRkIG5ldyBrZnVuYyBicGZfZ2V0X2ZzdmVyaXR5X2RpZ2Vz
dCgpIHNvIHRoYXQgd2UgY2FuIGFjY2VzcyBmc3Zlcml0eSBmcm9tDQo+PiBCUEYgTFNNIHByb2dy
YW1zLiBUaGlzIGtmdW5jIGlzIGFkZGVkIHRvIGZzL3Zlcml0eS9tZWFzdXJlLmMgYmVjYXVzZSBz
b21lDQo+PiBkYXRhIHN0cnVjdHVyZSB1c2VkIGluIHRoZSBmdW5jdGlvbiBpcyBwcml2YXRlIHRv
IGZzdmVyaXR5DQo+PiAoZnMvdmVyaXR5L2ZzdmVyaXR5X3ByaXZhdGUuaCkuDQo+PiANCj4+IFRv
IGF2b2lkIHJlY3Vyc2lvbiwgYnBmX2dldF9mc3Zlcml0eV9kaWdlc3QgaXMgb25seSBhbGxvd2Vk
IGluIEJQRiBMU00NCj4+IHByb2dyYW1zLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExp
dSA8c29uZ0BrZXJuZWwub3JnPg0KPj4gLS0tDQo+PiBmcy92ZXJpdHkvZnN2ZXJpdHlfcHJpdmF0
ZS5oIHwgMTAgKysrKysNCj4+IGZzL3Zlcml0eS9pbml0LmMgICAgICAgICAgICAgfCAgMSArDQo+
PiBmcy92ZXJpdHkvbWVhc3VyZS5jICAgICAgICAgIHwgODUgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+PiAzIGZpbGVzIGNoYW5nZWQsIDk2IGluc2VydGlvbnMoKykNCj4+
IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL3Zlcml0eS9mc3Zlcml0eV9wcml2YXRlLmggYi9mcy92ZXJp
dHkvZnN2ZXJpdHlfcHJpdmF0ZS5oDQo+PiBpbmRleCBkMDcxYTZlMzI1ODEuLmY3MTI0Zjg5YWI2
ZiAxMDA2NDQNCj4+IC0tLSBhL2ZzL3Zlcml0eS9mc3Zlcml0eV9wcml2YXRlLmgNCj4+ICsrKyBi
L2ZzL3Zlcml0eS9mc3Zlcml0eV9wcml2YXRlLmgNCj4+IEBAIC0xNDUsNCArMTQ1LDE0IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBmc3Zlcml0eV9pbml0X3NpZ25hdHVyZSh2b2lkKQ0KPj4gDQo+PiB2
b2lkIF9faW5pdCBmc3Zlcml0eV9pbml0X3dvcmtxdWV1ZSh2b2lkKTsNCj4+IA0KPj4gKy8qIG1l
YXN1cmUuYyAqLw0KPj4gKw0KPj4gKyNpZmRlZiBDT05GSUdfQlBGX1NZU0NBTEwNCj4+ICtpbnQg
X19pbml0IGZzdmVyaXR5X2luaXRfYnBmKHZvaWQpOw0KPj4gKyNlbHNlDQo+PiArc3RhdGljIGlu
bGluZSBpbnQgZnN2ZXJpdHlfaW5pdF9icGYodm9pZCkNCj4+ICt7DQo+PiArfQ0KPj4gKyNlbmRp
Zg0KPiANCj4gVGhpcyBkb2VzIG5vdCBjb21waWxlIHdoZW4gIUNPTkZJR19CUEZfU1lTQ0FMTC4N
Cj4gDQo+IGZzdmVyaXR5X2luaXRfYnBmKCkgcHJvYmFibHkgc2hvdWxkbid0IGhhdmUgYSByZXR1
cm4gdmFsdWUsIGdpdmVuIHRoYXQgdGhpcyBjb2RlDQo+IGNhbm5vdCBiZSBjb21waWxlZCBhcyBh
IGxvYWRhYmxlIG1vZHVsZS4gIFlvdSBjYW4gZWl0aGVyIHBhbmljIG9uIGVycm9yLCBvcg0KPiBp
Z25vcmUgdGhlIGVycm9yLiAgSSBkb24ndCB0aGluayB0aGVyZSBhcmUgYW55IG90aGVyIG9wdGlv
bnMuDQoNCkdvdCBpdC4gVXBkYXRlZCBmc3Zlcml0eV9pbml0X2JwZiB0byByZXR1cm4gdm9pZC4g
DQoNCj4gDQo+IEFsc28sIHBsZWFzZSBrZWVwIHRoZSBzZWN0aW9ucyBvZiB0aGlzIGZpbGUgaW4g
YWxwaGFiZXRpY2FsIG9yZGVyLiAgVGhlDQo+IG1lYXN1cmUuYyBzZWN0aW9uIHNob3VsZCBnbyBi
ZXR3ZWVuIGluaXQuYyBhbmQgb3Blbi5jIHNlY3Rpb25zLg0KPiANCj4gDQo+PiBkaWZmIC0tZ2l0
IGEvZnMvdmVyaXR5L21lYXN1cmUuYyBiL2ZzL3Zlcml0eS9tZWFzdXJlLmMNCj4+IGluZGV4IGVl
YzU5NTYxNDFkYS4uNGIwNjE3ZWEwNDk5IDEwMDY0NA0KPj4gLS0tIGEvZnMvdmVyaXR5L21lYXN1
cmUuYw0KPj4gKysrIGIvZnMvdmVyaXR5L21lYXN1cmUuYw0KPj4gQEAgLTgsNiArOCw4IEBADQo+
PiAjaW5jbHVkZSAiZnN2ZXJpdHlfcHJpdmF0ZS5oIg0KPj4gDQo+PiAjaW5jbHVkZSA8bGludXgv
dWFjY2Vzcy5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9icGYuaD4NCj4+ICsjaW5jbHVkZSA8bGlu
dXgvYnRmLmg+DQo+IA0KPiBLZWVwIGluY2x1ZGVzIGluIGFscGhhYmV0aWNhbCBvcmRlciwgcGxl
YXNlLg0KDQpGaXhlZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLiANCg0KVGhhbmtzLA0KU29uZw0KDQo=


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DF04F6DF5
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 00:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiDFWrP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiDFWrP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 18:47:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE1E65F9
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 15:45:14 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 236LJ3q4000974
        for <bpf@vger.kernel.org>; Wed, 6 Apr 2022 15:45:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+wSYwMV6GXQg8YSg4cmBVGxlwhPQgMRcX12lwAtz6S0=;
 b=UKZOZuNB8DDSUzCD7nBH/0lwzzH/PChCTvZKVGoZ7WQbV0MnjbzS7VZ9ivtEvjHMud6o
 luJg5mfuUJUwvTSsGaGOLU2v7Hqih0ostRyldw0Uaw9avRz58yIwfwN9iWw2slt7Vwt6
 YiwVK8z4uBxNkpS1eHgD/LTlIn/ejVCyMiM= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f90n77v9h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 15:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsO8oDO6xO2vJ27rbOR1FH4J1c7+hkoihqDtiOloQtMYaV3hp6g/ZiZc+xOgV6eIkFsZBGpGcvVB/HD1BHq1gH6Ml30RbwAE0SxXCW7gHL0ur2rsisQgXfv7wL8lXHY98FfixS3Pvfiz5n+ov4HXVyDhMR3FyZeZkdu4U4ncCaQrihkqX+kcMr+o/9GMq//0W5n3BmGW2OnWR5AJiTKSBVy+QO+BHZ4VTY2FoT/fq6cN6CGVaQ4IrcbfIyM3LUYH8PsKGBDwg5j2hr5pPdcBvtjUKasajUjKi//vgbl66CxRY5w8Hg6O5ocKyEdkU432cEWLmhwKBOn3SiSTb4Np5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wSYwMV6GXQg8YSg4cmBVGxlwhPQgMRcX12lwAtz6S0=;
 b=GLPvF7NNpvRvBUAWNjxDO1sYNRP8cN+OlcgIGKEb7lTGD3ADMlL3xKUwGRKjSSk/CklnOFNmfHYveZBXfrAz0t/tqtLWioCFrrDnDuE9skVPp7vPPZElx055cLe8CZNiaM2U3OwQq/3+yUk39D81waWnCIQcFb5tuHNuayDZcAqlf2Riem8v5NO+vv7M5ztNt+P4YOD6yKGE68/Fyd2xBjoJxvSpMskgLIt4pzcxfLwMgsN424h2hP5AnkAze9DAvi4Pc2FX9Q5XOTU+B0/FQ7R+c7QNL5BDCLBj1LeJUjhGvrxWGmsAEfIze8uv/Sxfd4ci3qQ1YMIdJpJ6RLNEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BN8PR15MB2818.namprd15.prod.outlook.com (2603:10b6:408:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 22:44:58 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5123.025; Wed, 6 Apr 2022
 22:44:58 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Thread-Topic: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Thread-Index: AQHYOM8IO1xa8/UtYkS3jv5jd0HQ6KzKgjEAgAEaPICAAFNYgIAXrn6A
Date:   Wed, 6 Apr 2022 22:44:57 +0000
Message-ID: <4c9bf775cb7b84147fad0e4a7969797f6cf92bb6.camel@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
         <20220316004231.1103318-4-kuifeng@fb.com>
         <CAEf4BzYmFUKF0BFnJ62-yayopcwvxGMUogf+Wduwoab3L9m8fg@mail.gmail.com>
         <6a14b18ab0d17cacf5dbaa7689eaaa7938cd998b.camel@fb.com>
         <CAEf4BzZb2WLKfQEJR_o9M1CsrbT=jzfw9LHAJfWxALomX5eE2A@mail.gmail.com>
In-Reply-To: <CAEf4BzZb2WLKfQEJR_o9M1CsrbT=jzfw9LHAJfWxALomX5eE2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc2d60ec-4f24-4a1a-7b31-08da181f13ca
x-ms-traffictypediagnostic: BN8PR15MB2818:EE_
x-microsoft-antispam-prvs: <BN8PR15MB2818D0F9BA469890121F77D0CCE79@BN8PR15MB2818.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: crxWZ9gM2qTibMAnJXc1KoLCF2V3q7rbFK3TpAGORjooct1ZVmdVnpnCIkWelMHjOT/A3uGIIsjRLUKzFqgtBbAgnKMAvyqN37SS9gjadrjWHad42g2+EHhOGmCo8SI/EPi4Aa/dlPhU5MZLTdrVsMbKTx3oq5wXWLrAFvc7O9cEvSSdxfz/av5epEl7tSJGO7H8vbnjbBnM15ZLTeVurIP+UsB1EqJ7M97E57LgRCqAoP0FwIX4TwXS2Gj0Pk6G4EfBEJkX9D3NQdjCNoIoM+YlKKZGlhPhT+FBLjn7PVPLWUH6oPKbVoTU0FPckRTSzjGFmRJJRnMEVxZjdAa513ONevMVk+vcqYlC/R+dosrqEwNs+Mzm85YdNPhhc/tjPFzCsAP5WBL5v5lHWLKQ++jfdGHeAxjeCCrnJdksxp0jDpbslE3oh4GYdQd3Dei9B/nSH7UPwJafw2qbmBlt7HgwmKt/P3veHdhNCUTa4Z0eczQ74gmnS/KJbkWC5FGnzNJ1e0JrmksGSK4L/QHrf71186gmaxTicut0GHtnP1WKy3RWsU2ZSiNrOKTYIlN+A2EevhoUIOCx8qmZTqkmEFyaNvPi8DiBMrjgjLBx5nfaSigHef6SCbYD5lEC3Z/5EKMGsfVVtmVDi53OQzDKYPNZ+JO6amOmq7gnO670Iqg8LtqPVNxDyqNlDC5GCgT2K9jlCYYda2Xtnay5KwQCiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(76116006)(64756008)(66476007)(66446008)(66556008)(38070700005)(66946007)(2906002)(8936002)(86362001)(83380400001)(122000001)(5660300002)(4326008)(38100700002)(53546011)(186003)(2616005)(36756003)(316002)(54906003)(6512007)(6916009)(6486002)(71200400001)(6506007)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVJkTTJxM2Y4Q0VoTThDRTF6UkI2dzk3ZTFRdEluckplNWJycDh0aHU4cEVF?=
 =?utf-8?B?RitCNVU4ay9CVTdmK2Q4RU5MV2swdEhRY2ZhNnZkMHFoamVYVEhoRFkrTE11?=
 =?utf-8?B?dW1GK3dBdVVhWllXS2ZtSmw0SHZkcjRBRHNWa3dMc0dZT2xVNnE5VWJodmdJ?=
 =?utf-8?B?SUtQckV4TEdsTXoybzJxdWJLbUxqZC93czlqM2djYVhkMG9PS0pEODE2Nk9H?=
 =?utf-8?B?V1o4TEZHSHlxdjBVR09YU2U1OGszamkyekVaaFR2MGJTZTZURC9sK1U1YmNQ?=
 =?utf-8?B?b2pJa1JNMkRienAvOHVNK0JPQXhOSUlFSFkvbUFQOFlIa2JhRDBzL2FmbWl2?=
 =?utf-8?B?TnJQZWY1anZlQ0owYWhhay8yUE1rZEdiaWJsZXFzT0pMbkRhZFFCZ3hMbEpx?=
 =?utf-8?B?dVcrMmoxcDcrS3BLRml3ckRSMHpuNG8yTkd6ZlFvaG9KN3FYSDU0TUovSWx1?=
 =?utf-8?B?ekRYOTl6ays1d1JTc2VWNzlEUmhBT2ozeEtoemNmdU5yTEtjNEJNMHJXTnpy?=
 =?utf-8?B?NkhjN1UrSm40bmFmUWZRVzNSQjJ6MlBvWGVyeisyRWUyY2swM3pYb3pxejRR?=
 =?utf-8?B?VDNhenFHU2hQOC9QMHdWQm42SGQ1Y1laektia1VsaUovU0pqcEpPOTNWQk1n?=
 =?utf-8?B?Q1N6ajJqak1uV0I3bDEzS0JWTG1jNnJiOW9POHhXMWQ3bEE5QzdNMmpMREJk?=
 =?utf-8?B?SkNYclpSZXFuZTducTVXVm9VWlZkcHhFTkUxV3Z0UW9RdkQvZTVsWXNkOGVD?=
 =?utf-8?B?d2dLeml1cXF1Sms0dndiMlR2UExvVGlrYWZRclg1Snp0WUJaNWZ6M0JGSldt?=
 =?utf-8?B?S3VDQ1dCbFVJbTVOWnhoR0JlWXhiUkpvd0NuZHk4K0lNTWpPV2ViWG1LVzE5?=
 =?utf-8?B?aUkzRktvMG82Vmp6YUJwOWZTTlNjYUYzK1IvemJnclZIeTVOSlp2S3M5eDBP?=
 =?utf-8?B?S2N6dUd4aVJLSVlQMExBTXNZOTY4TDU3bFM4ZkhRWVpWZjZQRmZieTBjOHB2?=
 =?utf-8?B?Qzd5KzJwemxGUnJNYVhNbTJscHQ4WFZpOGUxSHNxQWdJaHZETkg3Z2dDNkxQ?=
 =?utf-8?B?dXRTSld3OGoyS1BUbzlvTVVCRFh1bks4T3llc1k4TjF5VFhLRWFtNFI0eHd5?=
 =?utf-8?B?WEY5cWRYVTZaNUhpSFkvM2FpSXFQRjFzeWkyZitvN09HR05rRERQaEFPT3BJ?=
 =?utf-8?B?ZXNzTENQYUZhUlJCSUJFdm9PdmpEMm9aVEQ4QkQ2RWFJNTFmdDVqUXhpam1Z?=
 =?utf-8?B?VDNqcHc4MU5peU9LbTM5YXZ2dnl4b0pMcCtyUWphb0V1NlhlMm1qanRWKzhs?=
 =?utf-8?B?ZXJFRUN6M0hjdElMTnp3aVdiZzRWNk1LK0VUYzRGRE05MFRsb0E3VzVwMEMy?=
 =?utf-8?B?Q1Q5OURiWk41VTFBNC9jRWoxQ3g1aEJCVjYyY25FU3RzSW5HeHNFNjh3TkR5?=
 =?utf-8?B?azBSeS9IUm8wOU9JWkxQSWlqNmZtb0lXOVRVNGovQ3dyL0xYUUpsaGp4REdp?=
 =?utf-8?B?V3dqalA5U0Q1T0ZrWlNwcG85MnNFazBaOHVxWGVYTlNub0R5bmFscU1JY1FN?=
 =?utf-8?B?MnE5eWJRMERCSXdoS2lRM081UnQyZllpcnRLN2wzclhUZ1NaeHh4N0ptKzdY?=
 =?utf-8?B?cS9halRSRzNQUnp0SHlYVUJJaEF1eml3SUM3RUw1czZ4bWErNklWcWNDLzcv?=
 =?utf-8?B?TXczVEVrK1krMU5OREdMbVRQUHJpVDF2R3d6WG9PaElCMU1aYUxrOTN4Q1V4?=
 =?utf-8?B?ck1mRWlCUFAzaVM1L29iRi8xaEV3N0J0dll4ZWNEZXk4Zzh3YVk5TVpFc1Nu?=
 =?utf-8?B?bGNoaXJwNFEzSHk3RnJjemNiMzlwZys1c2FPS3VZVEtOaDk0bHl2K21xalhz?=
 =?utf-8?B?S2Y0cWxscTU5QkFOWG1iTmRILzQ0U2tsNjFhRXNUTWtjWGcrQ0JaclVSWDI5?=
 =?utf-8?B?YnpYMmxzZGxkYUgyQmU2NGh2QTJUN2pGWERjaUY3MEQzNmpacml1UHhTSlI4?=
 =?utf-8?B?eDZqZDQrMEE5ZVp2WUkwYUhxMG5FTWUwckNmcmFNWFdpZWJWdXN2M0kvdEpm?=
 =?utf-8?B?N3hzUDU3QURoTzJzZ1dkZzBRRy9SME5LNWRlaFBZWTJobmVNaFVDSTlMSHJz?=
 =?utf-8?B?bEM0MkhIZXgxaVdPekJ0TXZ6OC85OUNlVnN4SHlBMm1jK21xa2sycUhwTDJO?=
 =?utf-8?B?VUwyU2Q3Qmg2UkVhTVBBb2ZoVUp6T3lkRUV5Y2pWSHpZcVhYeW9qckN2V3lW?=
 =?utf-8?B?NVAxQ2ZDWCs1dzF3T0c4SDhMV3d6V0x3U1pZZ2N6aVRqNU55clpyZVE0bjlj?=
 =?utf-8?B?OFMvUVB6bVQxUW12dGVvSXZpb2tLcmpDN0lDM0FhTks0WW95MGlvNHRiU3A3?=
 =?utf-8?Q?OBTLUq3iWXslWHCU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2E62FBA1388D54B9AEB352CA7791199@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2d60ec-4f24-4a1a-7b31-08da181f13ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 22:44:58.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: me1xFfl0BN/2F1USvp7jswoq/AC4Yq/Ev/qJXH1Y66BseuOk90RmhfysmaYkWQgy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2818
X-Proofpoint-ORIG-GUID: JsEb-OdZf_Rl8ABCKm3xCpFmQ6h5WJj4
X-Proofpoint-GUID: JsEb-OdZf_Rl8ABCKm3xCpFmQ6h5WJj4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_13,2022-04-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTIyIGF0IDE0OjA2IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFR1ZSwgTWFyIDIyLCAyMDIyIGF0IDk6MDggQU0gS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9uLCAyMDIyLTAzLTIxIGF0IDE2OjE4IC0w
NzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIE1hciAxNSwgMjAyMiBh
dCA1OjQ0IFBNIEt1aS1GZW5nIExlZSA8a3VpZmVuZ0BmYi5jb20+DQo+ID4gPiB3cm90ZToNCj4g
PiA+ID4gDQo+ID4gPiA+IEFkZCBhIGJwZl9jb29raWUgZmllbGQgdG8gYXR0YWNoIGEgY29va2ll
IHRvIGFuIGluc3RhbmNlIG9mDQo+ID4gPiA+IHN0cnVjdA0KPiA+ID4gPiBicGZfbGluay7CoCBU
aGUgY29va2llIG9mIGEgYnBmX2xpbmsgd2lsbCBiZSBpbnN0YWxsZWQgd2hlbg0KPiA+ID4gPiBj
YWxsaW5nDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBhc3NvY2lhdGVkIHByb2dyYW0gdG8gbWFrZSBp
dCBhdmFpbGFibGUgdG8gdGhlIHByb2dyYW0uDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBLdWktRmVuZyBMZWUgPGt1aWZlbmdAZmIuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4g
wqBhcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmPCoMKgwqAgfMKgIDQgKystLQ0KPiA+ID4gPiDC
oGluY2x1ZGUvbGludXgvYnBmLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiA+
ID4gwqBpbmNsdWRlL3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+ID4g
PiDCoGtlcm5lbC9icGYvc3lzY2FsbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMSArKysrKysr
LS0tLQ0KPiA+ID4gPiDCoGtlcm5lbC90cmFjZS9icGZfdHJhY2UuY8KgwqDCoMKgwqDCoCB8IDE3
ICsrKysrKysrKysrKysrKysrDQo+ID4gPiA+IMKgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2Jw
Zi5oIHzCoCAxICsNCj4gPiA+ID4gwqB0b29scy9saWIvYnBmL2JwZi5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gPiA+IMKgdG9vbHMvbGliL2JwZi9icGYu
aMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+ID4gPiDCoHRvb2xzL2xpYi9icGYv
bGliYnBmLm1hcMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+ID4gPiA+IMKgOSBmaWxlcyBjaGFuZ2Vk
LCA0NSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L25ldC9icGZfaml0X2NvbXAuYw0KPiA+ID4gPiBiL2FyY2gveDg2
L25ldC9icGZfaml0X2NvbXAuYw0KPiA+ID4gPiBpbmRleCAyOTc3NWE0NzU1MTMuLjVmYWI4NTMw
ZTkwOSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jDQo+
ID4gPiA+ICsrKyBiL2FyY2gveDg2L25ldC9icGZfaml0X2NvbXAuYw0KPiA+ID4gPiBAQCAtMTc1
Myw4ICsxNzUzLDggQEAgc3RhdGljIGludCBpbnZva2VfYnBmX3Byb2coY29uc3Qgc3RydWN0DQo+
ID4gPiA+IGJ0Zl9mdW5jX21vZGVsICptLCB1OCAqKnBwcm9nLA0KPiA+ID4gPiANCj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqAgRU1JVDEoMHg1Mik7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHB1
c2ggcmR4ICovDQo+ID4gPiA+IA0KPiA+ID4gPiAtwqDCoMKgwqDCoMKgIC8qIG1vdiByZGksIDAg
Ki8NCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCBlbWl0X21vdl9pbW02NCgmcHJvZywgQlBGX1JFR18x
LCAwLCAwKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCAvKiBtb3YgcmRpLCBjb29raWUgKi8NCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoCBlbWl0X21vdl9pbW02NCgmcHJvZywgQlBGX1JFR18xLCAobG9u
ZykgbC0+Y29va2llID4+DQo+ID4gPiA+IDMyLA0KPiA+ID4gPiAodTMyKSAobG9uZykgbC0+Y29v
a2llKTsNCj4gPiA+IA0KPiA+ID4gd2h5IF9fdTY0IHRvIGxvbmcgY2FzdGluZz8gSSBkb24ndCB0
aGluayB5b3UgbmVlZCB0byBjYXN0DQo+ID4gPiBhbnl0aGluZyBhdA0KPiA+ID4gYWxsLCBidXQg
aWYgeW91IHdhbnQgdG8gbWFrZSB0aGF0IG1vcmUgZXhwbGljaXQgdGhhbiBqdXN0IGNhc3RpbmcN
Cj4gPiA+IHRvDQo+ID4gPiAodTMyKSBzaG91bGQgYmUgZmluZSwgbm8/DQo+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIC8qIFByZXBhcmUgc3RydWN0IGJwZl90cmFjZV9y
dW5fY3R4Lg0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgICogc3ViIHJzcCwgc2l6ZW9mKHN0cnVj
dCBicGZfdHJhY2VfcnVuX2N0eCkNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
YnBmLmggYi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+ID4gPiA+IGluZGV4IGQyMGEyMzk1MzY5Ni4u
OTQ2OWY5MjY0YjRmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+
ID4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4gPiA+ID4gQEAgLTEwNDAsNiArMTA0
MCw3IEBAIHN0cnVjdCBicGZfbGluayB7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBi
cGZfcHJvZyAqcHJvZzsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHdvcmtfc3RydWN0
IHdvcms7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBobGlzdF9ub2RlIHRyYW1wX2hs
aXN0Ow0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIHU2NCBjb29raWU7DQo+ID4gPiANCj4gPiA+IEkg
d2FzIGEgYml0IGhlc2l0YW50IGFib3V0IGFkZGluZyB0cmFtcF9obGlzdCBpbnRvIGdlbmVyaWMg
c3RydWN0DQo+ID4gPiBicGZfbGluaywgYnV0IG5vdyB3aXRoIGFsc28gY29va2llIHRoZXJlIEkn
bSBldmVuIG1vcmUgY29udmluY2VkDQo+ID4gPiB0aGF0DQo+ID4gPiBpdCdzIG5vdCB0aGUgcmln
aHQgdGhpbmcgdG8gZG8uLi4gU29tZSBCUEYgbGlua3Mgd29uJ3QgaGF2ZQ0KPiA+ID4gY29va2ll
LA0KPiA+ID4gc29tZSAobGlrZSBtdWx0aS1rcHJvYmUpIHdpbGwgaGF2ZSBsb3RzIG9mIHRoZW0u
DQo+ID4gPiANCj4gPiA+IFNob3VsZCB3ZSBjcmVhdGUgc3RydWN0IGJwZl90cmFtcF9saW5rIHt9
IHdoaWNoIHdpbGwgaGF2ZQ0KPiA+ID4gdHJhbXBfaGxpc3QNCj4gPiA+IGFuZCBjb29raWU/IEFz
IGZvciB0cmFtcF9obGlzdCwgd2UgY2FuIHByb2JhYmx5IGFsc28ga2VlcCBpdCBiYWNrDQo+ID4g
PiBpbg0KPiA+ID4gYnBmX3Byb2dfYXV4IGFuZCBqdXN0IGZldGNoIGl0IHRocm91Z2ggbGluay0+
cHJvZy0+YXV4LQ0KPiA+ID4gPnRyYW1wX2hsaXN0DQo+ID4gPiBpbg0KPiA+ID4gdHJhbXBvbGlu
ZSBjb2RlLiBUaGlzIG1pZ2h0IHJlZHVjZSBhbW91bnQgb2YgY29kZSBjaHVybiBpbiBwYXRjaA0K
PiA+ID4gMS4NCj4gPiANCj4gPiBEbyB5b3UgbWVhbiBhIHN0cnVjdCBsaWtlcyBsaWtlPw0KPiA+
IA0KPiA+IHN0cnVjdCBicGZfdHJhbXBfbGluayB7DQo+ID4gwqAgc3RydWN0IGJwZl9saW5rIGxp
bms7DQo+ID4gwqAgc3RydWN0IGhsaXN0X25vZGUgdHJhbXBfaGxpc3Q7DQo+ID4gwqAgdTY0IGNv
b2tpZTsNCj4gPiB9Ow0KPiANCj4gc29tZXRoaW5nIGxpa2UgdGhpcywgeWVzLiBLZWVwIGluIG1p
bmQgdGhhdCB3ZSBhbHJlYWR5IHVzZSBzdHJ1Y3QNCj4gYnBmX3RyYWNpbmdfbGluayB3aGljaCBp
cyB1c2VkIGZvciBhbGwgdHJhbXBvbGluZS1iYXNlZCBwcm9ncmFtcywNCj4gZXhjZXB0IGZvciBz
dHJ1Y3Rfb3BzLiBTbyB3ZSBjYW4gZWl0aGVyIHNvbWVob3cgbWFrZSBzdHJ1Y3Rfb3BzIGp1c3QN
Cj4gcmVzdWx0IHN0cnVjdCBicGZfdHJhY2luZ19saW5rIChjYyBNYXJ0aW4gZm9yIGlkZWFzLCBo
ZSB3YXMgdGhpbmtpbmcNCj4gYWJvdXQgZG9pbmcgcHJvcGVyIGJwZl9saW5rIHN1cHBvcnQgZm9y
IHN0cnVjdF9vcHMgYW55d2F5cyksIG9yIHdlJ2xsDQo+IG5lZWQgdGhpcyBraW5kIG9mIHN0cnVj
dCBpbmhlcml0YW5jZSB0byByZXVzZSB0aGUgc2FtZSBsYXlvdXQgYmV0d2Vlbg0KPiBzdHJ1Y3Rf
b3BzIGFuZCBzdHJ1Y3QgYnBmX3RyYWNpbmdfbGluay4NCg0KSSBqdXN0IGludHJvZHVjZWQgYnBm
X3RyYW1wX2xpbmsuIEJ1dCwgbW92ZWQgY29va2llIHRvDQpicGZfdHJhY2luZ19saW5rLiAgQW5k
LCBzdHJ1Y3Rfb3BzIGNyZWF0ZXMgYnBmX3RyYW1wX2xpbmsgaW5zdGVhZCBvZg0KYnBmX2xpbmsu
DQoNCg0K

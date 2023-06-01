Return-Path: <bpf+bounces-1601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A571EFC0
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 304B81C20E4B
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75C4079B;
	Thu,  1 Jun 2023 16:54:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7813AC3
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:54:13 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC31B0
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 09:54:10 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351FSYMd025664
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 09:54:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=r7Kb4W4xNTcmHBRvXHf4tv+B3Qdcwyr3G51S0DPKeU8=;
 b=J/Z9ruJQCOf+XpWreBQI9NxX1KNK0dZVs1Gs0RuzCFL1ngyuGl5eEyXJlfxRlWYSxWdR
 BBkTS1zal8m3n+evS3HRokMA/ugI3MCmGTOJvhenn0AalBXStfvUxqlU+vwg02Hs07vg
 Csx5mJ2wPucOh4BgHa9xmfGRT3/5eZq2uNf56YO7kBLN2NfvgRTkRldqa35tjXcv1SSh
 cx/DHokw0JcIReCXRhfaFMnJVCrrFcyizs0La5gT7spaQf1oRqBwIMDPE3dalKoMNrf8
 /pkJ5J03cZyxdTqj/9cONhsTlCXGo22fQ1mzdt1CF/r5OE40SN1Qw0RDaXo+I/zaJ1RC PQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxj0ywnka-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 09:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp4vx/7zl74rDRNZPhtsgYY27/yD7ortrmELBK+lJYvNAq7a5jEAETX94MPujfKPUFuMK05ZB9YS8nO3XBWwvoPqjdvpmqQOmQ+SztmlXbRAVlcp9DOSybymaQR0Yc2iZnPfAEjCEFRTcQL1Ja0HYgDNCCxLY7CN5DTO6tnxgs6W3fvW5wMI8FAEjtT1Bg9WcOEfHcna/XbahaLunGmoKFcEb8VoF4PcIE5qCew0he7/Knp8qow4aHL3P69k5RDp/XQaXAMTpo1MmcPf+HtZpzrzE5Z1tog/E9CA4OjoDEsoBPGccABY2icZKczpwTRFdJjcGR2Hs8+emknMD+Z05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7Kb4W4xNTcmHBRvXHf4tv+B3Qdcwyr3G51S0DPKeU8=;
 b=O/NOOaRvtWZbou5+W/bq6iCK7nIywudLevvmteS0qR/P20ncD9Ten88/Nv9M+KlCJMn85KNTJk6AKlAJqSZb/1n+2t8nbZwVxyQmLB6og1+fqdZct4GjX3o2jffUA3jmobeaKx9QMcYbJHrpI5NMRg4zKcUR8I1efXjd0NdQXtOW2cuLPx2KSfbbM1hhqGJQTz+aGbQBDOgouDosuvRlbYKeqMF7qF9oJ8wmAajKZVepFYsu1Qwp6/NG8snMS4LpjFDXfCRWJL5UbINTOb2VrDWcBpg1Sst/3CD5aFmHPWqYaNVr18U0RJ0eZ5yYy9xqzWbZzuivjLXvKGVFLEcOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CY5PR15MB5440.namprd15.prod.outlook.com (2603:10b6:930:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 16:54:06 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 16:54:06 +0000
From: Song Liu <songliubraving@meta.com>
To: KP Singh <kpsingh@kernel.org>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin Lau
	<kafai@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kuba
 Piecuch <jpiecuch@google.com>
Subject: Re: [PATCH bpf] bpf: Fix UAF in task local storage
Thread-Topic: [PATCH bpf] bpf: Fix UAF in task local storage
Thread-Index: AQHZlIRRuOeDW5Wmyk2yi5IND0JOU692IFKAgAAClICAAAdegA==
Date: Thu, 1 Jun 2023 16:54:06 +0000
Message-ID: <5486EA34-136F-45EA-BD9B-EA54EC436CA1@fb.com>
References: <20230601122622.513140-1-kpsingh@kernel.org>
 <CAPhsuW45Sb0TeOYouTvaVDhOGfz+2nBht0AmGyF4=yq15HE8AA@mail.gmail.com>
 <CACYkzJ7S7JwX77NSSurr1wWYnFQs0TZwUKcwW5Zmva3CkkAx5w@mail.gmail.com>
In-Reply-To: 
 <CACYkzJ7S7JwX77NSSurr1wWYnFQs0TZwUKcwW5Zmva3CkkAx5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CY5PR15MB5440:EE_
x-ms-office365-filtering-correlation-id: ea819e03-0c0a-4db9-08bf-08db62c0cfee
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 M9bomioO4PDOU0B2kTXypz+9EVzBYe43myss6wG86MehI/8COcsRumGqkhCX4DTgdNkpfQk1+hktnezfkbmLs/kvmeP+pZBraheHoHuJ9e+klxC6wfR2b11FRVBQ2YG1zDHX6bbf9BnUBRUG9MCNUMm39rLgBt4QadXGHM6NXnspJWOdWkMp9JovljCuZnpaVWk/1OrHiwcSNrSgKNhht6Bp2KToIzxavJen1l/sVvvFm54emE45buS47w5H8ZAebXKr5eq+6i2UkdWxRYd/qvUnX7SrMo2ccRwPF6G6bS1oYTaeMnL7gV0HYsdcGZAaKrsuEWdzvK22w549cQGrH1w3PhT5yy6y0VbTbyrtC0jo/ouum0axHwsgKcznGgOSseNAnTDBgXawVPuZD8tJzubNFR0kYiDXpt4GgB96SkkHIA55ao76anFiH4J6CwiHwIq6jRGm30gU4Y5jCsHPXC9/uIl8Jr2v07GX/N82aw6kUx2gISllADT6AnigfSwpIbtP09FiBCosjR83kk4c5CKxgY94LFsI9xT0Z9WW9B9nf5lLBXpEEsf7+NUayGCBnYK+VbHWj0O1AiwNYsHijGARgNxNSAt4Dao6KxjV7HPV/T/WXH5cEY4Lqkv1awE6
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(316002)(71200400001)(186003)(54906003)(6486002)(86362001)(41300700001)(83380400001)(478600001)(38070700005)(2906002)(66446008)(91956017)(66476007)(64756008)(66556008)(66946007)(6916009)(76116006)(9686003)(6512007)(5660300002)(6506007)(53546011)(36756003)(33656002)(8676002)(38100700002)(4326008)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UFRGZzNVSEdZQmVUUTZxK29hWGFTdjJTa2R1Ly9DS3BqNmJ4bGJNcHpjb0I3?=
 =?utf-8?B?bzhkcVUzT1JJbjhOT3RhNUFtZWdBQ0plOWFGeTMvSm1nZGFtLzJXOXVhU2xD?=
 =?utf-8?B?Um15YmY1QVUyRVFVWEx3R3ZIM0VsN3I4NDhkektsUVkxOTVTVkVLYVMxR1dY?=
 =?utf-8?B?U0h6ZVdqYVJZaXhnUC85TXB2dnU4K3pHMk9wRHhXRUh3bkl4LysyaVhPNmhs?=
 =?utf-8?B?dlBFZ2tlMktqeXJxbndhRDZGelU1TVk0UllLNUpkMUEzN28rWFhTam5YeW5R?=
 =?utf-8?B?N0NiS0ZrZUxjalN5K1NZWTFNaFcwQktyd1N4dmEzcWhrRFNIbUVKUGdFaS9R?=
 =?utf-8?B?ZEZjYzJkUnc2c0UyQXdSK2kzUWNXREJvczBhNXdidHlwUllNQnYxejJ3Q3Js?=
 =?utf-8?B?eFYrOUxWYnJvUGo3MFVRNmRkY0xhOFdRa2Q2Mi9kbVZya3lBcy9PVG9ZYysv?=
 =?utf-8?B?YTc4cXVZRTZzV1FDaGVHMkF3akVvc0VwVXRDOFlnWVYyMUJPLzFtL1UzT3Q2?=
 =?utf-8?B?NXc1OVZFcG9IbVFhb1E1SmFQVGFrRk5acHR6L25Qb1B3alp6RHBWalVhM2I0?=
 =?utf-8?B?YVZ4OG5EZXU4M3hXS0JDZE8yN2daZ2lCKy9MNWFPd3lEemhIM0ZxYTdGZmUx?=
 =?utf-8?B?dXMzSkF1a05YcGZHWDNQeTJJOENBWUlpQVJZTG5VZHRhRXQ4UHBDQWpQb1I3?=
 =?utf-8?B?MzIxWU1KSE9PSDVJQnUxNDM1ZG1rQVB4SllDU3N0aGc1eGwwaHhoMkVWc05B?=
 =?utf-8?B?VUJLcms0NzJ4M0hJVWV4QmozcGZVeWJoZytZSysrenE0MWVnM3hydS9MdVEr?=
 =?utf-8?B?MWttK09LS2NQZjQrZ3NoblRkcForanVwM2J5MmdGL1pkdjcvQ1lORE53TFRX?=
 =?utf-8?B?RWViT2wxMWlXWDhJcXRGVEFzWi9RYXFpNURsbmM5VTNsNWFtMUEyZ1ZjMWlN?=
 =?utf-8?B?dGRMamFveHFpOXVuK090RzRaanNFdlRwNlJ5NkhaZUgrVmJrcGpRcXh1NS9r?=
 =?utf-8?B?djdNNHJOeFhTS2RHMVhpRXV4VTZtWW9jeDNEYzBvYW5JbW9mVE40R21pWE5o?=
 =?utf-8?B?ZUZUU2ZTOEFIVU5nSFozMXdzMDRTSGF5TlRPYkM2eURVQituQnZPYWp0VWVQ?=
 =?utf-8?B?T2NNWDMwVmk4Nis0L05jZ3N6SDJodEphZUo5ZHBLQkNVZjVLR0RZTmwrWVZz?=
 =?utf-8?B?VHZTWlJWdWl2RDJoOXJZcDA2L1JMaUEyeUh1cWJud1ZCNENuK2dMUzMxQzlq?=
 =?utf-8?B?MEs4aXpKUWcrVGpub0VpQmZTMFJHcHZoQlI2a2VOc3hMYXgrRXRLMGczVEhH?=
 =?utf-8?B?OUdaR2t2Yjd1RkJySFVGZDlQTVl2SVFTTUJNQlBqNVhWVENPaWlTc2tmc1Qw?=
 =?utf-8?B?OUQrVnBwSXppdlJNSnQrdHhhelRpcCtzWTNZejJwNGlML2YxVkg1YzV5NFpk?=
 =?utf-8?B?czBjbXBHVVJ5bnFiVzJsMDZucUIvZnlJSUd4L1krNkVSR3N4Qkdrb0RtcmNE?=
 =?utf-8?B?Z2NJMU95SENOK2d2bFlhQ0pYeThIaDlMcURzUDQydkxMbVBmVk1XdTJUQ3dv?=
 =?utf-8?B?dndWSmJ2OTRMZnpVeVRjV3hhekg3cTZKTEc3VGFsdURWdFppWkdPVGt3TU44?=
 =?utf-8?B?OTFoUUxaR1FEcEVabUtQUXBJU0ZkZjRNY0xFZnl2aUE2alBSRDAxN2w0OTNF?=
 =?utf-8?B?cGROcTBMVzNBbHNjTWg3NzFzdGpDYTlXUnZMLy9JcElpSUNYald3bldUQTc0?=
 =?utf-8?B?aDk5Q1haT2NsY005cStIVzYxVWNDQS9HSHM0b1lnb1k4bnExd0JoQU9CYmZ4?=
 =?utf-8?B?S29HTnBQeFBQekhQMzlXL0FVamNhM0tXdTJ5OERacHlqenF2NWhETHo2emlY?=
 =?utf-8?B?aE9vOTZ4MzlNc21lek1EZjJOeGVhSEVkZHk1bFhVcGtJb01PTXFSSTlzL0Uv?=
 =?utf-8?B?azRWRWdUbmpNRm9JNkZPOFdISlBkV0lHZkdqMzJjTW5hdDE4ZzRGWHB3eE1B?=
 =?utf-8?B?bXhBQUlqd25oa0VBaDZoOWFqbEZucXdPZ2hYSTJOeGh3eTRQRmdWMVJOcWtB?=
 =?utf-8?B?RUVjSHlvUFd3bjR4dVpqS0RQRjQ4Tmx0a2crYXpyU1RvVVlWTi9hTGV5YWQ4?=
 =?utf-8?B?dFZPQUJ1eUVwTGpPQVB6Uy9veW5GNkhjL3JtazczeVlkQnRJNUlia2RVZkhl?=
 =?utf-8?Q?5DrViC3/Io+FPLecZmCMwhs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC854556C87DF643ADA0EEBC13AD213C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea819e03-0c0a-4db9-08bf-08db62c0cfee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 16:54:06.4682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmsoZEWE3Lzvh13a2iU+RghQuo6STRdNFXPfMXpdQCXaz6dzl3HT3WkcxQZRKOgN5Rve+vjz1bA3oFlHsGCAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5440
X-Proofpoint-ORIG-GUID: 8aYfBcZ26xIIvlVf5cjsBbFkpYzfhvV5
X-Proofpoint-GUID: 8aYfBcZ26xIIvlVf5cjsBbFkpYzfhvV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gSnVuIDEsIDIwMjMsIGF0IDk6MjcgQU0sIEtQIFNpbmdoIDxrcHNpbmdoQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdW4gMSwgMjAyMyBhdCA2OjE44oCvUE0gU29u
ZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4gd3JvdGU6DQo+PiANCj4+IE9uIFRodSwgSnVuIDEsIDIw
MjMgYXQgNToyNuKAr0FNIEtQIFNpbmdoIDxrcHNpbmdoQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IFdoZW4gdGhlIHRoZSB0YXNrIGxvY2FsIHN0b3JhZ2Ugd2FzIGdlbmVyYWxpemVkIGZv
ciB0cmFjaW5nIHByb2dyYW1zLCB0aGUNCj4+PiBicGZfdGFza19sb2NhbF9zdG9yYWdlIGNhbGxi
YWNrIHdhcyBtb3ZlZCBmcm9tIGEgQlBGIExTTSBob29rIGNhbGxiYWNrDQo+Pj4gZm9yIHNlY3Vy
aXR5X3Rhc2tfZnJlZSBMU00gaG9vayB0byBpdCdzIG93biBjYWxsYmFjay4gQnV0IGEgZmFpbHVy
ZSBjYXNlDQo+Pj4gaW4gYmFkX2ZvcmtfY2xlYW51cF9zZWN1cml0eSB3YXMgbWlzc2VkIHdoaWNo
LCB3aGVuIHRyaWdnZXJlZCwgbGVkIHRvIGEgZGFuZ2xpbmcNCj4+PiB0YXNrIG93bmVyIHBvaW50
ZXIgYW5kIGEgc3Vic2VxdWVudCB1c2UtYWZ0ZXItZnJlZS4NCj4+PiANCj4+PiBUaGlzIGlzc3Vl
IHdhcyBub3RpY2VkIHdoZW4gYSBCUEYgTFNNIHByb2dyYW0gd2FzIGF0dGFjaGVkIHRvIHRoZQ0K
Pj4+IHRhc2tfYWxsb2MgaG9vayBvbiBhIGtlcm5lbCB3aXRoIEtBU0FOIGVuYWJsZWQuIFRoZSBw
cm9ncmFtIHVzZWQNCj4+PiBicGZfdGFza19zdG9yYWdlX2dldCB0byBjb3B5IHRoZSB0YXNrIGxv
Y2FsIHN0b3JhZ2UgZnJvbSB0aGUgY3VycmVudA0KPj4+IHRhc2sgdG8gdGhlIG5ldyB0YXNrIGJl
aW5nIGNyZWF0ZWQuDQo+PiANCj4+IFRoaXMgaXMgcHJldHR5IHRyaWNreS4gTGV0J3MgYWRkIGEg
c2VsZnRlc3QgZm9yIHRoaXMuDQo+IA0KPiBJIGRvbid0IGhhdmUgYW4gZWFzeSByZXBybyBmb3Ig
dGhpcyAodGhlIFVBRiBkb2VzIG5vdCB0cmlnZ2VyDQo+IGltbWVkaWF0ZWx5KSwgQWxzbyBJIGFt
IG5vdCBzdXJlIGhvdyBvbmUgd291bGQgdGVzdCBhIFVBRiBpbiBhDQo+IHNlbGZ0ZXN0LiBXaGF0
IGFjdHVhbGx5IGhhcHBlbnMgaXM6DQo+IA0KPiAqIFdlIGhhdmUgYSBkYW5nbGluZyB0YXNrIHBv
aW50ZXIgaW4gbG9jYWwgc3RvcmFnZS4NCj4gKiBUaGlzIGlzIHVzZWQgc29tZXRpbWUgbGF0ZXIg
d2hpY2ggdGhlbiBsZWFkcyB0byB3ZWlyZCBtZW1vcnkNCj4gY29ycnVwdGlvbiBlcnJvcnMuDQoN
CkkgdGhpbmsgd2Ugd2lsbCBzZWUgaXQgZWFzaWx5IHdpdGggS0FTQU4sIG5vPyANCg0KPiANCj4+
IA0KPj4+IA0KPj4+IEZpeGVzOiBhMTA3ODdlNmQ1OGMgKCJicGY6IEVuYWJsZSB0YXNrIGxvY2Fs
IHN0b3JhZ2UgZm9yIHRyYWNpbmcgcHJvZ3JhbXMiKQ0KPj4+IFJlcG9ydGVkLWJ5OiBLdWJhIFBp
ZWN1Y2ggPGpwaWVjdWNoQGdvb2dsZS5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogS1AgU2luZ2gg
PGtwc2luZ2hAa2VybmVsLm9yZz4NCj4+PiAtLS0NCj4+PiANCj4+PiBUaGlzIGZpeGVzIHRoZSBy
ZWdyZXNzaW9uIGZyb20gdGhlIExTTSBibG9iIGJhc2VkIGltcGxlbWVudGF0aW9uLCB3ZSBjYW4N
Cj4+PiBzdGlsbCBoYXZlIFVBRnMsIGlmIGJwZl90YXNrX3N0b3JhZ2VfZ2V0IGlzIGludm9rZWQg
YWZ0ZXIgYnBmX3Rhc2tfc3RvcmFnZV9mcmVlDQo+Pj4gaW4gdGhlIGNsZWFudXAgcGF0aC4NCj4+
IA0KPj4gQ2FuIHdlIGZpeCB0aGlzIGJ5IGNhbGxpbmcgYnBmX3Rhc2tfc3RvcmFnZV9mcmVlKCkg
ZnJvbSBmcmVlX3Rhc2soKT8NCj4gDQo+IEkgdGhpbmsgd2UgY2FuIHllYWguIEJ1dCwgdGhpcyBp
cyB5ZXQgYW5vdGhlciBkZXZpYXRpb24gZnJvbSBob3cgdGhlDQo+IHNlY3VyaXR5IGJsb2IgaXMg
bWFuYWdlZCAoc2VjdXJpdHlfdGFza19mcmVlKSBmcmVlcyB0aGUgYmxvYiB0aGF0IHdlDQo+IHdl
cmUgcHJldmlvdXNseSB1c2luZy4NCg0KWWVhaCwgdGhpcyB3aWxsIG1ha2UgdGhlIGNvZGUgZXZl
biBtb3JlIHRyaWNreS4gDQoNCkFub3RoZXIgaWRlYSBJIGhhZCBpcyB0byBmaWx0ZXIgb24gdGFz
ay0+X19zdGF0ZSBpbiB0aGUgaGVscGVyLiBJT1csIA0KdGFzayBsb2NhbCBzdG9yYWdlIGRvZXMg
bm90IHdvcmsgb24gc3RhcnRpbmcgb3IgZGllZCB0YXNrcy4gQnV0IEkgYW0NCm5vdCBzdXJlIHdo
ZXRoZXIgdGhpcyB3aWxsIG1ha2UgQlBGX0xTTSBsZXNzIGVmZmVjdGl2ZSAobm90IGNvdmVyaW5n
DQpjZXJ0YWluIHRhc2tzKS4gDQoNClRoYW5rcywNClNvbmcgDQoNCg0K


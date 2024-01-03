Return-Path: <bpf+bounces-18889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E8D82351E
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786D11C20B59
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275F1CA8E;
	Wed,  3 Jan 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="62nQnw8a"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410011CA89
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403Fp0qo030132;
	Wed, 3 Jan 2024 18:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=E561jtmrnDt7Ze5Zq9dRl38HujKkNUw+GX0sajMaGw8=; b=6
	2nQnw8a5Hjwnd7fpyyOKSAFZxJRHWjGrH56EJi+436uDeR+XIcHtI/gkTVfaSJYU
	qdKjIVmrvJEldDAhckdmAKJh60nxx16/0MPTstmUjux45h1vqp4DJ6Fm8JMl/5eF
	BESOxUK6ZE5Ll/WNtbBt+66x9JTRME+FOaS3Ea7KNep+uw32UuSS8VdPs3OE1kgK
	HkmGs0T+zxVeBwhyzvr/nhN+EVSm8A73RQopog+8Ld+QPfn9FNmSEqMT/uVk/RZP
	l82FTT9t3RsKToaxhwWB8M/Pgi4AOSiLjBbXz4NVPCkbhs4/QNSn/D0hqxzowvnj
	6AiNXOWLcWNikMTvv137A==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3vcv45j3ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 18:56:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf9kbk7KzLFpeyT9yw5yAxOWpCIZkfnzqpHxWIaPb20uQgQykvQby0L406GcGmV46HEubHztmI+Hdkpz2Qr8W+adfB1CZduFnJ5Fg2/FQ/HJou9y0gJQM2oZSE6BdpBJp5wuUOZy72n73WIkqr5o2EcNWu8tOXtuQ6VrgURi2DgvD6Riicd9MTNGNsWLUW4Toya03GIsbMrmKuP4RibVNIB2qGNJVs35CbXToXD84dD30pU5GBZo5vicKIDNr64nVOoLfikgt1kr7Zr6WMBKjWUt1w7eJ/VFMZaIBhl8DMEhvIrRTbWQShse+0ktVtfWB/JUxPerLUhMFX68qYYtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E561jtmrnDt7Ze5Zq9dRl38HujKkNUw+GX0sajMaGw8=;
 b=Ncil29uKX3x8FYsyL09qj8yA312hajDhidl4/JPfgt+sUXx92mydgdCROSoR9g5xzuw0Cx9io+70BvDZGHoth8CPDRY1AHYDyG77sbs+xNlHSCgjKSk4D+mdtQ0HoHZIaXJjBP6ZnBN9zihqsW/wJFcS+DJgIKZOD5mmEyrtcNHUm151PzfNuX1Y8O7S/jKPtg+uQRNkjUdj02RTiS7O/AflrRg77fqSlpmZ8TTXyLkaMAudvuHKgJd+UCeX7uqqW+em2BgFg0+V4fOTAAXRzlYm7P4cf8U+wIm9wLxMBcoLsNIghQO5P51sJt9JwrWMEvUSX2TMg0+6CnJC+Tj/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by KL1PR0302MB5412.apcprd03.prod.outlook.com (2603:1096:820:36::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 18:56:06 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 18:56:06 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrew Wheeler
	<awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?=
	<quebs2@motorola.com>,
        "di_jin@brown.edu" <di_jin@brown.edu>
Subject: Re: FW: BPF-NX+CFI is a good upstreaming candidate
Thread-Topic: FW: BPF-NX+CFI is a good upstreaming candidate
Thread-Index: AQHaPnaBc6FJFHpxH0GB4r9C5LRB/g==
Date: Wed, 3 Jan 2024 18:56:05 +0000
Message-ID: 
 <SEZPR03MB678613E8257AD66C6CE47410B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <SEZPR03MB6786598744F4D5DE29C46651B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <2024010317-undercoat-widow-e087@gregkh>
In-Reply-To: <2024010317-undercoat-widow-e087@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|KL1PR0302MB5412:EE_
x-ms-office365-filtering-correlation-id: c3ff03f1-8092-4e71-6916-08dc0c8da3f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PJ/or7orV4ChVG4ejp4l3l7kzgzDrzoZrNUbUGzFhgL612MCjB6wBszBjNh06TJR5s/J0UrjMCCNw+kcKmhDEfKtKNKVMn9BYX4pygAjmu9gSp1zu/BE4/hhab7Tx3Kk0jn4QZUdxcC3D9sThd2W1O6pxuudKl5SEgdEHRTyEaGKf6ujDLF9wK6iMj+jyMMrlLAa3uX4qa4b7/MgQBNWXN38IhwWiSv61QPPJJmzI+6P01wCeMOGQJHuTuYlZcheAE0GuyxPjgRNo/egM2GSne+bA73OjtZ1wgOy8WfbiecUmAYNAvV8m2kMLTLXkGDjfYOsfjuKMCLRV3y7weMGIaPV8d8tkVLIWZuCwwEc5Tj3wnhfr802k/9+xeM2DfWZmp/e3cGKDfZHec4OtNrL3nbJUsBMF1fmF8B6UvjI10gis9Xun6tPFtm/jC/Tzgc2KDicm6pKmAv3t8YomZqPwCoGG987SwTUbuPS+wSFulLs5rcbvLHGoiYM3tkmYU5EphqqVvPVKlFQUG9x/0cB1op7JZvJHXNIIiNweVbEacPmzh3s1XhshFFZA5tednh+HLOsE+yy5Ns1pAS1mDrTHQPL69mtnRgQ8GVTxKzLm36prVyg5uLzz3qcMVdoBaxBoqvipnqkXUdoNCr/krxkRNC0do4DpoJ55rxJdeYcb/Z5prTPoEpfftfPyGj3kx7X
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(33656002)(83380400001)(55016003)(7696005)(2906002)(64756008)(66476007)(76116006)(66556008)(66446008)(316002)(54906003)(66946007)(966005)(38070700009)(38100700002)(478600001)(6506007)(71200400001)(26005)(53546011)(45080400002)(9686003)(6916009)(86362001)(82960400001)(122000001)(5660300002)(8936002)(8676002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VkE0RzQxeXRYYTlZVlZvNGlhdHlBK0VHcS9xNHNvUnIvRTRicUVPU1FMMGdL?=
 =?utf-8?B?am44Q2pIaUc2NVliUlhjYUg5WUZMMUxITzFGUFcvcU9OTERzd3VjZ0cwb1ow?=
 =?utf-8?B?VC9SKzVIVlF0WXB5dVNxd0l3cW5VVHJTQUtVVHFVVFJmNmxuRGpNbWlSUW9h?=
 =?utf-8?B?WDB1MHc0WWJQYnM2SWYvNXBWSk5lcXh2dEk5Wm9TZnBJbHNadngwNWRBVEV0?=
 =?utf-8?B?UlgvSld2TFlCYXZQQzFpMmdzbXFtUVlyMmZZMms1Ylh6M2Z5MUZtU0JNWmRT?=
 =?utf-8?B?Zm9nUENEY0pxT1oyQVBNL041Y2JsNWxTWmVXcU5Td09MbTVSMjJ1UTRKMGxh?=
 =?utf-8?B?QkJaUjE4SFJFNGlicDU3blFUTi9vVWdITmM4VVZIazZadmxibW9MRkFXSHdR?=
 =?utf-8?B?UW1IVVVYUGpYZFh0cS84VjB5Y2tjdHNnaGl4UnNyaXl6TTJ1TnUwRGMxRHpP?=
 =?utf-8?B?eUZHNjhvTXFyZ25yYW9yb3ZLbkVpVFZ5T0ZxTUdyOXNEZkhqR04rWjJSUlh3?=
 =?utf-8?B?T2FLRG82cjRqbklKWUhWc2RBdmZwZVNSWmtEK2tMWmc2Sm5mRDBtSjc4YXRN?=
 =?utf-8?B?cmZzUW1ub3ZZQUVqMUNKYXJRblVYVjhMeDNWSlk1QS9EQzQyRkhGOE0rcDZM?=
 =?utf-8?B?a3BxWnd4STRXMHlaYzVGSysvSEltL3hZN2hJN0RWSEVScEw0SjZORTVRdzRs?=
 =?utf-8?B?UTlOZENpRVNtNHNQekw5RnMzcjdLK0xLb3RxbnhGZXlzS0pxVzNpNXQvRWps?=
 =?utf-8?B?U2ZuYVBCZVNtd1hQRE1FWjB0V0NqRmZEcmUrU3BvQ1UvanNzSDltV2tsdUxI?=
 =?utf-8?B?ZDBKeDhJR0VnSmdaVC81OStjQkpsMDNKd1cwTVVTcjlKNkMzRnZvVXViWW1m?=
 =?utf-8?B?VldNOVRMZEZtUzI2cFNvTGtZUnluQjgzYS96aExwdmIvZUE3SnVBNW1yQ0FB?=
 =?utf-8?B?c2llcUdpQjhNRTU0aTUvRU1TSWFCQ1RGakZVUzg3bkt3b0J4TUlWVlZ3NE00?=
 =?utf-8?B?UGs3U29nNXRXTHhGQUQySmZpbXM4TkN2b2JTcXpyQXdEeDBiQkZ1RjQzMFkr?=
 =?utf-8?B?ZWRRTE00cjhtVythTVVzRGdCNXhzR3EvdlhOZTFORnVpQ0pqbDhwRTljUCt0?=
 =?utf-8?B?b01wbzIwelVuaENFc0JOZnRFeEFCMXBGR3NZbjJvUGVzVEFvcHdZamMxN3lj?=
 =?utf-8?B?MFpDckp0ZiswU25KOURVcSttcWdDYnF0bVBQTVA1SXJkNHBIMFhmOXRhdXdq?=
 =?utf-8?B?eDVxYWR4RG5GQ0Fzd2ZqTys1YkdYRklDZnB4RnA1VEJHZkFOcGRYbUJVUys5?=
 =?utf-8?B?VGJqK2U2VVpYUkNvQzdCRmh4K0FGVFBoZURTRVY0SHdoZTBpSGlHRHprU3F3?=
 =?utf-8?B?NGNPMlNjYVI2RU1HU2dSR1JGSUREMkxxdUI4MmdETmNCbDF6cE9PY1pDNkt6?=
 =?utf-8?B?eU1JamZOZGd1eXJxdGJ1RVVsazhoQmRUVTdIU3NDZ3NuVkJFc292bmZ5eUZl?=
 =?utf-8?B?aGIzWXJYQUxObUp6MkxQSyt0L3crNE1wM3JzNjF4OE56NkNZVzJRRTRDV0Q0?=
 =?utf-8?B?NExoWTVvWGErNWU1V2Fqb3B1NDV6eXM1MnBOcnhMMm5LMHhwK0pHTkExcXFZ?=
 =?utf-8?B?TlpLNkViU3BFK2hKRWhicG52MWFNRW4wZGdNU3JhWjRtc1VFbUxQb3FjS2Ns?=
 =?utf-8?B?dDBaK25YL2J6WXZpdEh2cC9Ock13ZEtHRStnbm1rWmJUNWhrWC8waWVIajVR?=
 =?utf-8?B?VGhzS1loNTI0UFBYbU80dm5mdzRKRStKbG4vOGNxWm1nNDVpbnpjb2luRVNR?=
 =?utf-8?B?TmdtbEE3ZHpnM1hVc3ltYUovNWVTUUNMd1dOd3VSemM1VHF5cHo3UHNmbnJi?=
 =?utf-8?B?ekcyYSsxblZQYVFrcmo5VHBPWXlvaXpnWGNoL2N1Mk9DWC8wTCtaKzgzS2hh?=
 =?utf-8?B?OVUrMVZpZE4xZnN3RzRTeEdxVDhsRzhyV2VQb2ZBQy9taWtyQ3ZhaEhZZVFK?=
 =?utf-8?B?dStRZGhBZE5zSHNYMk9Gc2FQQlRvUHhMZ0VkQUJBYVJjN2dqd1dRV3VtdlFq?=
 =?utf-8?B?c28vaG9ZRWNFN3grTTRiRWxoTHlzU245MmRqS0NtbVFWbnRqSjZGb1UyRGhH?=
 =?utf-8?Q?UD7w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ff03f1-8092-4e71-6916-08dc0c8da3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 18:56:06.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfeZb5J11SCL+kA1MTP/q+Sg7BqW9fyDHiIxXAJoZgS5Y8pLu7eiCLjRblLDgK+wgUrP2KeNgkk6ajANdAv9rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5412
X-Proofpoint-ORIG-GUID: ojLzhsJhF66Ry-nveWOAwlKQ3GIuYXOm
X-Proofpoint-GUID: ojLzhsJhF66Ry-nveWOAwlKQ3GIuYXOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401030153

PiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogV2Vk
bmVzZGF5LCBKYW51YXJ5IDMsIDIwMjQgMTA6MjggQU0NCj4gVG86IE1heHdlbGwgQmxhbmQgPG1i
bGFuZEBtb3Rvcm9sYS5jb20+DQo+IENjOiBicGZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFtFeHRlcm5hbF0gUmU6IEZXOiBCUEYtTlgrQ0ZJIGlzIGEgZ29vZCB1cHN0cmVhbWluZyBjYW5k
aWRhdGUNCj4NCj4gT24gV2VkLCBKYW4gMDMsIDIwMjQgYXQgMDQ6MDY6MzJQTSArMDAwMCwgTWF4
d2VsbCBCbGFuZCB3cm90ZToNCj4gPiBGb3J3YXJkaW5nIHRvIEJQRiBtYWlsaW5nIGxpc3QgYXMg
cGxhaW50ZXh0IHRvIG1hdGNoIHRoZSBtYWlsIHNlcnZlcg0KPiByZXN0cmljdGlvbnMuDQo+ID4N
Cj4gPiBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kLCBMaW51eCBzZWN1cml0eSB0ZWFtIGlzIHJlYWN0
aXZlIHJhdGhlciB0aGFuDQo+ID4gcHJvYWN0aXZlLCBzbyBtYXliZSB0aGUgYmVsb3cgaXMgYSBt
b290IHBvaW50LCBidXQgSSdkIGxvdmUgdG8gc2VlDQo+ID4gQlBGLU5YK0NGSSBpZiBwb3NzaWJs
ZS4NCj4NCj4gc2VjdXJpdHlAa2VybmVsLm9yZyBpcyByZWFjdGl2ZSwgYXMgdGhhdCBpcyBpdCdz
IHJlcXVpcmVtZW50LCBidXQgdGhlcmUgYXJlIG1hbnkNCj4gb3RoZXIgZ3JvdXBzIHRoYXQgd29y
ayBvbiBwcm9hY3RpdmUgc2VjdXJpdHksIHNlZSB0aGUgbGludXgtaGFyZGVuaW5nIHByb2plY3QN
Cj4gZm9yIGxvdHMgb2Ygd29yayBoYXBwZW5pbmcgdGhlcmUgdGhhdCBpcyBhZGRpbmcgbG9hZHMg
b2YgZ29vZCBzdHVmZiB0byB0aGUNCj4ga2VybmVsLg0KPg0KPiA+DQo+ID4gT3JpZ2luYWxseSBz
ZW50IHRvIGRpX2ppbkBicm93bi5lZHU7IHYuYXRsaWRha2lzQGdtYWlsLmNvbTsNCj4gPiB2cGtA
Y3MuYnJvd24uZWR1OyBkYm9ya21hbkBrZXJuZWwub3JnOw0KPiA+IGxzZi1wY0BsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgQW5kcmV3IFdoZWVsZXINCj4g
PiA8YXdoZWVsZXJAbW90b3JvbGEuY29tPjsgU2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw0KPiA8
cXVlYnMyQG1vdG9yb2xhLmNvbT4NCj4gPg0KPiA+IERlYXIgSmluIGV0IGFsLiBEYW5pZWwgQm9y
a21hbiwgYW5kIExTRi9CUEYgbWFpbGluZyBsaXN0cywNCj4gPg0KPiA+IEFsdGhvdWdoIGEgZmV3
IG1vbnRocyBsYXRlLCBKaW4gZXQgYWwu4oCZcyBVU0VOSVggQVRD4oCZMjMgRVBGIHB1YmxpY2F0
aW9uIGhlcmUNCj4gKGh0dHBzOi8vY3MuYnJvLw0KPiB3bi5lZHUlMkZ+dnBrJTJGcGFwZXJzJTJG
ZXBmLmF0YzIzLnBkZiZkYXRhPTA1JTdDMDIlN0NtYmxhbmQlNDANCj4gbW90b3JvbGEuY29tJTdD
N2ViNDY3ZWUzNzIzNDZlYjM4MWQwOGRjMGM3OGVjMmYlN0M1YzdkMGIyOGJkZjg0MQ0KPiAwY2Fh
OTM0ZGYzNzJiMTYyMDMlN0MwJTdDMCU3QzYzODM5ODk2MDcxODA3MTE1NyU3Q1Vua25vd24lN0NU
DQo+IFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRp
STZJazFoYVd3aUxDSg0KPiBYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2RhdGE9THklMkZ3
aFhLQzNic0JReVcwd3d6VGx4Yw0KPiBoZm5kRUhxN1Q4WVR4UWhGVjQwMCUzRCZyZXNlcnZlZD0w
KSBpcyBncmVhdC4gSXQgd2FzIGEgcmVsaWVmIHRvIHNlZSB0aGUNCj4gZWZmb3J0cyBpbg0KPiBo
dHRwczovL2dpdGxhYi8uDQo+IGNvbSUyRmJyb3duLXNzbCUyRmVwZiUyRi0lMkZibG9iJTJGbWFz
dGVyJTJGbGludXgtDQo+IDUuMTAlMkZwYXRjaGVzJTJGMDAwMy1BZGRpbmctQlBGLQ0KPiBOWC5w
YXRjaCUzRnJlZl90eXBlJTNEaGVhZHMmZGF0YT0wNSU3QzAyJTdDbWJsYW5kJTQwbW90b3JvbGEu
Y28NCj4gbSU3QzdlYjQ2N2VlMzcyMzQ2ZWIzODFkMDhkYzBjNzhlYzJmJTdDNWM3ZDBiMjhiZGY4
NDEwY2FhOTM0ZGYzDQo+IDcyYjE2MjAzJTdDMCU3QzAlN0M2MzgzOTg5NjA3MTgwNzExNTclN0NV
bmtub3duJTdDVFdGcGJHWnNiDQo+IDNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1
TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMA0KPiAlM0QlN0MzMDAwJTdDJTdDJTdDJnNk
YXRhPUhod2V4eXkxM3RjWHpwZWJFVTRQdVh3TlFvQSUyRktKZEwNCj4gWGNhZnE5RTVCRk0lM0Qm
cmVzZXJ2ZWQ9MCBhbmQgcmVsYXRlZCBmaWxlcy4NCj4gPg0KPiA+IEJQRi1OWCtDRkkgd291bGQv
Y291bGQvc2hvdWxkIGJlIGEgZ3JlYXQgdXBzdHJlYW1pbmcgY2FuZGlkYXRlLiBJIGFtIG5vdA0K
PiBzdXJlIGhvdyB3ZWxsIEJQRi1OWCtDRkkgZ2VuZXJhbGl6ZXMgdG8gdGhlIGZ1bGwga2VybmVs
IGVjb3N5c3RlbSBnaXZlbiB0aGUNCj4gYXBwcm9hY2ggcmVxdWlyZXMgYSBkZWRpY2F0ZWQgdm1h
bGxvYyBtZW1vcnkgcmVnaW9uLCBidXQgdGhlIGlkZWEgUFhOIGlzIG5vDQo+IGxvbmdlciBiZSBl
bmZvcmNlZCBhdCBhIFBNRC1sZXZlbCBncmFudWxhcml0eSBiZWNhdXNlIG9mIGVCUEYgaXMgdW5m
b3J0dW5hdGUuDQo+ID4NCj4gPiBCUEYtSVNSIGlzIGxpa2VseSBvdmVya2lsbCBwZXJmb3JtYW5j
ZS13aXNlIGFzIGEgbWVjaGFuaXNtIGFuZCBjYW4gYmUNCj4gaGFuZGxlZC9yZWZpbmVkIHZpYSBr
cHJvYmVzIHJhdGhlciB0aGFuIGRpcmVjdCBwYXRjaGVzLg0KPiA+DQo+ID4gSmluIGV0IGFsLiwg
ZG8geW91IGhhcHBlbiB0byBoYXZlIHBlcmZvcm1hbmNlIG51bWJlcnMgZm9yIGp1c3QgTlgrQ0ZJ
LCBvcg0KPiBrbm93bGVkZ2Ugb2YgaG93IHdlbGwgdGhpcyBtYXkgYXBwbHkgdG8gNi4qKyBrZXJu
ZWxzPyBXaXRoIHlvdXIgYmxlc3NpbmcsDQo+IGFuZCBpZiB0aGUgbWFpbGluZyBsaXN0IHBlZXJz
IGFyZSBzdXBwb3J0aXZlLCB3ZSBzaG91bGQgZGlzY3VzcyB5b3VyIHdvcmsgYW5kDQo+IEJQRiBz
ZWN1cml0eSBhdA0KPiBodHRwczovL2V2ZW50cy8NCj4gLmxpbnV4Zm91bmRhdGlvbi5vcmclMkZs
c2ZtbWJwZiUyRnByb2dyYW0lMkZjZnAlMkYmZGF0YT0wNSU3QzAyJTcNCj4gQ21ibGFuZCU0MG1v
dG9yb2xhLmNvbSU3QzdlYjQ2N2VlMzcyMzQ2ZWIzODFkMDhkYzBjNzhlYzJmJTdDNWM3DQo+IGQw
YjI4YmRmODQxMGNhYTkzNGRmMzcyYjE2MjAzJTdDMCU3QzAlN0M2MzgzOTg5NjA3MTgwNzExNTcl
N0NVDQo+IG5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lW
Mmx1TXpJaUxDSkJUaUk2DQo+IElrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdD
JnNkYXRhPXVza0Z6ZURGU0JVVzlTYzkNCj4gWDUlMkJCNmd2dDhMVTM0cTkxcG9rWHNSd2ZTRUkl
M0QmcmVzZXJ2ZWQ9MC4NCj4NCj4gQXJlIHRoZXJlIHdvcmtpbmcgcGF0Y2hlcyBzb21ld2hlcmU/
ICA1LjEwLnkgaXMgdmVyeSBvbGQgYW5kIG9ic29sZXRlLg0KPg0KPiB0aGFua3MsDQo+DQo+IGdy
ZWcgay1oDQoNCldlbnQgYWhlYWQgYW5kIGFwcGxpZWQgdGhlIHBhdGNoZXMgZm9yIE5YIGFuZCBD
RkkgdG8gVG9ydmFsZHMgdjYuNy1yYzggdXBzdHJlYW0uIFNlbnQgdG8gbWFpbGluZyBsaXN0cyBh
cyBzZXBhcmF0ZSBwYXRjaCBlbWFpbHM6ICJbUEFUQ0ggMS8yXSBBZGRpbmcgQlBGIE5YIiBhbmQg
IltQQVRDSCAyLzJdIEFkZGluZyBCUEYgQ0ZJIiwgYnV0IG5vdCB0ZXN0ZWQuIFNob3VsZCBiZSBP
Sy4NCg0KTm90IHN1cmUgSSAxMDAlIGxpa2UgdGhlIGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBtZXRo
b2Qgb2YgaGFuZGxpbmcgdGhlIHZtYWxsb2MgcmVnaW9uIG9yIHRoZSBLQ29uZmlnIGRlcGVuZGVu
Y2Ugb24geDg2LiBXb3VsZCBiZSBiZXR0ZXIgdG8gYWdub3N0aWNhbGx5IHNldCBhc2lkZSBhIHNl
Z21lbnQgb2YgdGhlIHZhZGRyIHNwYWNlLCBidXQgSSBhbSBub3Qgc3VyZSBob3cuDQoNClJlZ2Fy
ZHMsDQpNYXh3ZWxsIEJsYW5kDQoNCg0K


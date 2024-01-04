Return-Path: <bpf+bounces-19060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EBA824953
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43324284835
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE62C1BC;
	Thu,  4 Jan 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="uNzWkXUZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B567F2C1AC
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404HXU7J021099;
	Thu, 4 Jan 2024 20:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=eyzCJCBtSyEyNPQL3IOrR3+jom9DwTxubCRH6OO6fZ4=; b=u
	NzWkXUZXrZdVwJosRX/nWbyB3Z1KJZB7MTigxjlm8UC63GKGtVR/B+qaoENEaj21
	qzWCoII8oF4UnJW59tuR6LJaphk+vnG3TUU5A+D9WVjRodTiXnofkVefXcXg1WJ0
	15q5rggjnbiHhEhh+kzTMCC9bT9+6+JZkRJkVMfAb1lS42pG6ddXfl4kSMNWfQ7u
	Cet1YWi4brrWgFJAN1+I/ngsYbz9ZHq8gFyaBf7lNAPJvqpH1AHZxJ7uFbJK3Sef
	WE46OUh34+4XMgFLvBln1GG0bxYGoVfXtdlzdd9zsKn4poBdYoDppFlMGA0E7Aqz
	a6Rs+CKEqlpaEHh5MLM9Q==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3ve162079m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 20:00:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPW/57uilWOxZWbURjQdwk+yflpA3EUDDLoGUl2PCUE0SXkcnt6BS0a0dZCckeuQqPvZgvb0R1KV7JPVLXuBPZRExSf6GcnYZZPd3QlEisEELPeFYEVbJUtLL19V7BXy0zAqmVCydOuIvM5ofFWeeBJjFvwXH/feMBLZ8OJKTe5NKBo0d5fqNHmvRfiAgOUpbrtJ+e1wgdoWPFvHN1pEiXGVwGqODhcXur6kVWNouUaT4fTfeG+eR9qbvwz8ufZWCkjDQ8pTXY4+yx5BDCbm6j2Mp98C9I/dyqnhhTv3vmjc5a6dE8Cbww3O5exSY9uNsU1YxreiRuYMUvryU3gzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyzCJCBtSyEyNPQL3IOrR3+jom9DwTxubCRH6OO6fZ4=;
 b=jPqBSLkGRRktmI8dOOqkBRuRYxqotySaAp1IKXwkMWirV0PNPFbptze6QfwE6UuyzHp2sebh0GMFvvK6ZNR5H7E0o7Sp1VsJ3VYVX0xZhuV/arZvTXts9gkYZ9mxyR1iV3F0qUjpihJWmI3IcfYywm6rhqOxBq6ER/bRuKYm8XVvozYAS+1xYPECCIIA97w7/8dYQyOe1ozJ7cLi1VvOOXXzDFPWGa0/5ARMclrrif/XoEGt3givo+7Kczk59/WzSZdZ8HFQeFue9VzAOwShCLLkOP+chhZEcQS+sJqnYmI8Znp1U3cBMKPyUADugorzLBbdHzEtv9IvtNep7/i3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by TYZPR03MB8704.apcprd03.prod.outlook.com (2603:1096:405:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 20:00:55 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 20:00:55 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: "Jin, Di" <di_jin@brown.edu>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "v.atlidakis@gmail.com" <v.atlidakis@gmail.com>,
        "vpk@cs.brown.edu"
	<vpk@cs.brown.edu>,
        Andrew Wheeler <awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>,
        Peter
 Zijlstra <peterz@infradead.org>
Subject: RE: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
Thread-Topic: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
Thread-Index: AQHaPpWonDW/eHWeP0q2GVAamFCjbrDIvSYAgAAkCQCAAQxXwA==
Date: Thu, 4 Jan 2024 20:00:55 +0000
Message-ID: 
 <SEZPR03MB6786133101DAE1355F5C2127B4672@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
 <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
In-Reply-To: 
 <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|TYZPR03MB8704:EE_
x-ms-office365-filtering-correlation-id: de946837-0277-494c-6a7d-08dc0d5fdcbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8C0paY0SxpUkVe28N8TYGldqBz4dH18o3G/f+/IRYzCk+xJkwFrL9bhlo+QPTjQJ3eeN486FYlIqm9Nm54M3lEoRkf7s2kBSjCoPegtl2/Ah0br1BbeSHGJb83r6OVYh5bs5yrVf0voeYKiNGV2bpuv1kHvYbSP+HLXBVq4iS20T/ZRBQHFqd4pWv3gnDZpe6Hq7Q5xpshR2/kPcH60uyK8fEzJ4y5dwpY1gi7y/bcC+rIbPM+3pg0vV0GCSBS+z8wFdvcxQjhfgfpQFRMqq+fe81MlGKFIBmMEatWlYwB0fZzmV/gU94j/M/7djMZtBRgvaeLJmvD4LSC5oCyde2Mx8QQa+Qp+ix5hD/W8qSIr3Sy7RS9dpKEAVXmIA6pJOskB3ZcvZTHoUrv48zZ0P3KsQ8aAnJx05gy240Fi9yt5J7LufkW9yhoiW7uvh1x9t7oM4BzjHC3CF46rsrA1cJt2fPspMEZmuFvBF1dcgWlvGXG5zj1IA1nShWRV+lqJX4au4pPasIcTJQgFz29UNpBGwtkkNwtiAK8g/h9gW22aPhZ9rfbiv36D98leW35sXltr3h8IiB2Mp/It4JaJa0gzC2Hmwws8G+bPC1eDR7CJsz5it3KPuNH2wycyjZa+tk9IOf9Zl3eHb+dYGoxiG57aPjMVlAcW3h7IZ+qSoYnnoiTIKBITm9QxL/sUOQbNE
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(66946007)(66476007)(64756008)(26005)(53546011)(54906003)(66446008)(76116006)(66556008)(8936002)(8676002)(316002)(4326008)(966005)(83380400001)(71200400001)(478600001)(7696005)(45080400002)(6506007)(52536014)(6916009)(9686003)(5660300002)(41300700001)(2906002)(33656002)(38070700009)(38100700002)(122000001)(82960400001)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RzFadEduUXFHc2R0emtKRnJWeG94ZUdSODFjcmdTc2FLcVQ3MDN4VzQ2Vitp?=
 =?utf-8?B?RDhFVFpZSFg0VVhhMWtWUEw1cEwvaWhibjZVcjRnZlcwaXFJOVVCZjk3RTVj?=
 =?utf-8?B?T0d0Y3pESUxlZjc2aWI2REMxQnVJallDdStSU1pxL0MxY0QwU2xWY2dJanZ2?=
 =?utf-8?B?MW5Gc2laOE4xTEdUSmJXcEpRZVhLd3dpcEwwUlZvV3J4ZnROUmh0YVp4dGht?=
 =?utf-8?B?di8vTG03cnlaNnB3K0d3U2E3RlErRTBMTWhXa3ovTDlSWUg1b2pQYk5YWU9L?=
 =?utf-8?B?YStHVnpoZ1NhWXcvWEVPYWgyWFNabGpmOVlyaHRXUVlHSEc0Q2EycUtFaFJO?=
 =?utf-8?B?dnhoWm51VHhlRTN6SDdiaDdIZjBaZ0pJYXkvSXhkdHlXUVdvQXowbnNvbDdu?=
 =?utf-8?B?N04weCtjZXNYQ3l1ckJUVUZtTjR4Z3psYUFZaEErQjQ1dmx5dUx4Vy9GZDU4?=
 =?utf-8?B?cEEwem9YbjQ0eU85VC80alRKRFN6NDBKSHl5SVl4U1ZtdFR1b3FJUUYyNFhy?=
 =?utf-8?B?UVE1b1BmZDNQbWRVU3c5NU9GRnRkS095M3V1TzlXUTM1UUxNNUVMM1JZdmpV?=
 =?utf-8?B?NjR6RXl6V2lvYTdaeTF3R0lRbHlTVFlCQU80UTJuVXErZ1IyUkliaEFxZFVY?=
 =?utf-8?B?WkdQbnpoYnFZUXNnS2JiSjlGd0ZrV0ZGczJjVS94MXdHekpnbnM0MldpUEta?=
 =?utf-8?B?ZzhOSVRtSk8wWlNhbEJhRm1KaHZZdHRZK2tHWWJybUVUSzNKWGdWNEl6cW1y?=
 =?utf-8?B?Tm9ZVHRzZlJjbHpML2NnZlNpWVRINCtYSFhQTFk4MkV3Y3h3YzhWRUkxdUdu?=
 =?utf-8?B?Mlk1eXFQWm1DMG80QVhZaHVQdjJncDQydmZwSU8wSndDY08rcU9TYlVDSWZ1?=
 =?utf-8?B?WXpQUnhKODhnSlJtTXJMMzVDWHMzU29RNXRFUThhMEhHbm9CU001T203V0di?=
 =?utf-8?B?ZXhYYjVwSGkzQ2c4Q1V0UXh3OWNHOE5LRzI3NHNkenpMeU51OHd4Z1ZmNnVP?=
 =?utf-8?B?OXdzcGsxakNNbkRNdFhkZWhDK3N3Zk80R1ZqSmZDOXdaMUtLMjZkUld5UXp0?=
 =?utf-8?B?MEljZTV2SGUzQ1laSFMvYVZ3NVQ0TlVBOVBFQm96dmNNSC9USmxxZzRvczZ3?=
 =?utf-8?B?TU9UTmFVVW04NFJWQWNJUWpXTTc1V2UwRmdGV2Y2WHBKdkxaMHQwUit3R0dT?=
 =?utf-8?B?OFJjQVVFUTlDcWVVdTBTeUpuVTNVNGRmZm8xSm1KYjRBaE5KYndybUE0TnJq?=
 =?utf-8?B?V3FTbVp6VmlzSVdwVnkxVm9xZldRNHVQR2hrdEF1SzI2Zy93NWwrZzRFR0Vs?=
 =?utf-8?B?cVdNMWFkVnZGT2NxWFNPWjJyUjhrc1NQWXVCZE9iL3A5NHVlc0tQVTNyRVRH?=
 =?utf-8?B?N0NPdHRTclYybGxYU0ZKMk1Dc1B3QW1WU3pxMGFRbUtoaGJFMXZiTkhkVVdY?=
 =?utf-8?B?RmVtVjh0a3U0cTJhRVlhVGowMS9qbTQ1WkxJWWZ3dzlnN0l4YTMrbkVZYzFW?=
 =?utf-8?B?ZDZTdVQrRmdMV1drbnZlK0hDUWNrajQ4amlXWlJRQUluTGVBUko4ZDVwLzBp?=
 =?utf-8?B?V0llUUZpU0dMN01DM1E3VGc4SlRkeXYxMS9zRXJwcXRZZ2lSdHJ6SEhFOVEr?=
 =?utf-8?B?NUdXN0RFajhWbFVKaTdzcjg2a2NQemxYNXFBaHRPZURPMkJlejZwUmw2c0VM?=
 =?utf-8?B?blBIbktKZlZ0cHJRdDl4MTBaYzg3ZnlKdmQ5NlVlTlUzbWlzR215TnBsaHZG?=
 =?utf-8?B?VnpsVUV3V3pqS1FhWjRTekZZZE16OHk2VTZXY043QkNJOE01ZEp2S3A4WHIr?=
 =?utf-8?B?bjExOXhWeGpMZXpFYmlvVElNa1ptQ0xtdERLenNXa3pjbFV0UVRnN0IzZTBs?=
 =?utf-8?B?V0tmOXZGa3BKeGZ5Vjc0OVZ0SERwcCtDYmV5Z3NkNlpMOHhnaVhnb2oxMmZQ?=
 =?utf-8?B?WTcvVDRidDl6WldxQXN1L3pYcHZMSkR1Z1c2TjNucVI4ZG4zdTdnNGppU0dj?=
 =?utf-8?B?dHRLaDNDOStTOFdFUmVnbzBmcWpqTEhiMjhmTE1vdEMyMFBURGZXTkVEU0FR?=
 =?utf-8?B?ZFArYVlUVzVRbGtZN2xOOHZnbC9HdGVHSkdpQnVEMmx6eGdocW5GbHpXWnI1?=
 =?utf-8?Q?sIEw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de946837-0277-494c-6a7d-08dc0d5fdcbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 20:00:55.5835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3JHdmGhmD+kggZ7bx5/H/am0c9Ob4V16UlBolYJWj+ctxz/rV00ydj2mTtB2OCBDWqkhaI9MV2sHjv62o5tpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8704
X-Proofpoint-GUID: bn5t4DA1cdJKWTuqmq2ufkzm941qIuD1
X-Proofpoint-ORIG-GUID: bn5t4DA1cdJKWTuqmq2ufkzm941qIuD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040156

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFy
eSAzLCAyMDI0IDc6NDIgUE0NCj4gVG86IE1heHdlbGwgQmxhbmQgPG1ibGFuZEBtb3Rvcm9sYS5j
b20+DQo+IENjOiBKaW4sIERpIDxkaV9qaW5AYnJvd24uZWR1PjsgYnBmQHZnZXIua2VybmVsLm9y
Zzsgdi5hdGxpZGFraXNAZ21haWwuY29tOw0KPiB2cGtAY3MuYnJvd24uZWR1OyBBbmRyZXcgV2hl
ZWxlciA8YXdoZWVsZXJAbW90b3JvbGEuY29tPjsgU2FtbXkNCj4gQlMyIFF1ZSB8IOmYmeaWjOeU
nyA8cXVlYnMyQG1vdG9yb2xhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtFeHRlcm5hbF0gRndkOiBC
UEYtTlgrQ0ZJIGlzIGEgZ29vZCB1cHN0cmVhbWluZyBjYW5kaWRhdGUNCj4NCj4gT24gV2VkLCBK
YW4gMywgMjAyNCBhdCAzOjQ14oCvUE0gTWF4d2VsbCBCbGFuZCA8bWJsYW5kQG1vdG9yb2xhLmNv
bT4NCj4gd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBKaW4sIERpIDxkaV9qaW5AYnJvd24uZWR1Pg0KPiA+ID4gU2VudDogV2VkbmVzZGF5
LCBKYW51YXJ5IDMsIDIwMjQgNDozOSBQTQ0KPiA+ID4gVG86IGJwZkB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiA+IFN1YmplY3Q6IFtFeHRlcm5hbF0gRndkOiBCUEYtTlgrQ0ZJIGlzIGEgZ29vZCB1cHN0
cmVhbWluZyBjYW5kaWRhdGUNCj4gPiA+DQo+ID4gPiAtLS0tLS0tLS0tIEZvcndhcmRlZCBtZXNz
YWdlIC0tLS0tLS0tLQ0KPiA+ID4gRnJvbTogSmluLCBEaSA8ZGlfamluQGJyb3duLmVkdT4NCj4g
PiA+IERhdGU6IFdlZCwgSmFuIDMsIDIwMjQgYXQgNToxOeKAr1BNDQo+ID4gPiBTdWJqZWN0OiBS
ZTogQlBGLU5YK0NGSSBpcyBhIGdvb2QgdXBzdHJlYW1pbmcgY2FuZGlkYXRlDQo+ID4gPiBUbzog
TWF4d2VsbCBCbGFuZCA8bWJsYW5kQG1vdG9yb2xhLmNvbT4NCj4gPiA+IENjOiB2LmF0bGlkYWtp
c0BnbWFpbC5jb20gPHYuYXRsaWRha2lzQGdtYWlsLmNvbT4sIHZwa0Bjcy5icm93bi5lZHUNCj4g
PiA+IDx2cGtAY3MuYnJvd24uZWR1PiwgZGJvcmttYW5Aa2VybmVsLm9yZyA8ZGJvcmttYW5Aa2Vy
bmVsLm9yZz4sDQo+IGxzZi0NCj4gPiA+IHBjQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnIDxs
c2YtcGNAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+LA0KPiA+ID4gYnBmQHZnZXIua2VybmVs
Lm9yZyA8YnBmQHZnZXIua2VybmVsLm9yZz4sIEFuZHJldyBXaGVlbGVyDQo+ID4gPiA8YXdoZWVs
ZXJAbW90b3JvbGEuY29tPiwgU2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw0KPiA+ID4gPHF1ZWJz
MkBtb3Rvcm9sYS5jb20+DQo+ID4gPg0KPiA+ID4NCj4gPiA+IERlYXIgYWxsLA0KPiA+ID4NCj4g
PiA+IFRoZXJlIGFyZSBhIGNvdXBsZSBvZiBub3Rld29ydGh5IHRoaW5ncyBhYm91dCB0aGUgcGF0
Y2hlczoNCj4gPiA+IDEuIFRoZXkgY3VycmVudGx5IGRvbid0IHdvcmsgd2l0aCBDT05GSUdfUkFO
RE9NSVpFX01FTU9SWSwgd2hpY2gNCj4gPiA+IHNob3VsZCBwcm9iYWJseSBiZSBhZGRyZXNzZWQu
DQo+ID4gPiAyLiBCUEYtQ0ZJIHRyaWVzIHRvIGVuc3VyZSB0aGUgaW50ZXJwcmV0ZXIgc3RhcnRz
IGZyb20gdGhlIGNvcnJlY3QNCj4gPiA+IG9mZnNldCB1bmRlciBjb2RlLXJldXNlIGF0dGFja3Ms
IHdoaWNoIG1lYW5zIGl0IG5lZWRzIHNvbWUgZm9ybSBvZg0KPiBjb250cm9sIGZsb3cgaW50ZWdy
aXR5Lg0KPiA+ID4gSGVyZSB3ZSBhcmUgZW5mb3JjaW5nIHRoYXQgd2l0aCB0aGUgc3RhdGUgb2Yg
YSByZWFkLW9ubHkgdmFyaWFibGUsDQo+ID4gPiB3aGljaCBpcyB0b2dnbGVkIGJ5IHRlbXBvcmFy
aWx5IGRpc2FibGluZyB0aGUgV1AgYml0LiBUaGlzIGFsc28NCj4gPiA+IGludHJvZHVjZXMgdGhl
IHByb2JsZW0gb2YgaGF2aW5nIHRvIGRpc2FibGUgaW50ZXJydXB0IGR1cmluZyB0aGUNCj4gPiA+
IGludGVycHJldGVyJ3MgZXhlY3V0aW9uIG90aGVyd2lzZSB0aGUgdmFyaWFibGUgd2lsbCBiZSBp
biB0aGUgd3JvbmcNCj4gPiA+IHN0YXRlIGR1cmluZyBpbnRlcnJ1cHQuIEluIHRoZSBwYXBlciB3
ZSBvcHRpbWl6ZWQgYXdheSB0aGUgdG9nZ2xpbmcNCj4gPiA+IG9mIHRoZSBXUCBiaXQgYnkgc29t
ZSB0cmljayBpbnZvbHZpbmcgdHVybmluZyBvZmYgcHJvdGVjdGlvbiBsaWtlDQo+ID4gPiBTTUFQ
IGR1cmluZyB0aGUgaW50ZXJwcmV0ZXIncyBleGVjdXRpb24sIHdoaWNoIGlzIGZhc3RlciBpbiB0
ZXJtcyBvZg0KPiA+ID4gcGVyZm9ybWFuY2UsIGJ1dCB0aGUgc2VjdXJpdHkgdHJhZGUtb2ZmIGlz
IGEgYml0IG1vcmUgc3VidGxlLiBUaGUNCj4gPiA+IGFyZ3VtZW50IGJlaW5nIHRoYXQgU01BUCAo
b3IgUEFOKSBhcmUgY29udHJpYnV0aW5nIHZlcnkgbWFyZ2luYWxseQ0KPiA+ID4gd2hlbiBCUEYg
cHJvZ3JhbXMgYXJlIGJlaW5nIGV4ZWN1dGVkLCBzaW5jZSB0aGUgdGhpbmdzIHRoZXkgYXJlDQo+
ID4gPiBkZWZlbmRpbmcgYWdhaW5zdCwgbmFtZWx5IHVzZXItY29udHJvbGxlZCBtZW1vcnkgY29u
dGVudCwgYXJlDQo+ID4gPiBhbHJlYWR5IHByZXNlbnQgaW4gdGhlIGV4ZWN1dGlvbiBjb250ZXh0
LiBUaGlzIHZlcnNpb24gb2YgQlBGLUNGSSBzaG91bGQNCj4gaW5jdXIgYWxtb3N0IG5vIG92ZXJo
ZWFkLiBUaGUgV1AgYml0IHRvZ2dsaW5nIHZlcnNpb24gSSBkb24ndCBoYXZlIG51bWJlcnMNCj4g
YXQgaGFuZC4NCj4gPiA+DQo+ID4gPiBATWF4d2VsbDogSWYgeW91IGFyZSBub3QgaW4gYSBodXJy
eSAoSSB3aWxsIG5lZWQgYSBjb3VwbGUgb2YgZGF5cykgSQ0KPiA+ID4gY2FuIGdlbmVyYXRlIGEg
c2V0IG9mIHBhdGNoZXMgdGhhdCBhcmUgY29tcGF0aWJsZSBmb3IgcGF0Y2gNCj4gPiA+IHN1Ym1p
c3Npb24gKHByb3BlciBuYW1lIGFuZCBlbWFpbCBhZGRyZXNzLCBzaWdub2ZmLCBmb3JtYXR0aW5n
LA0KPiA+ID4gZXRjLiksIGR1cmluZyB3aGljaCBJIGNhbiBhbHNvIGdldCBzb21lIHBlcmZvcm1h
bmNlIG51bWJlcnMuIFdlIGNhbg0KPiA+ID4gZGlzY3VzcyBhdXRob3JzaGlwIGRlcGVuZGluZyBv
biBob3cgbXVjaCB5b3Ugd2FudCB0byBhZGFwdCB0aGVzZQ0KPiBwYXRjaGVzLg0KPiA+ID4NCj4g
PiA+IFJlZ2FyZHMsDQo+ID4gPiBEaSBKaW4NCj4gPg0KPiA+IEhpIERpIEppbiwNCj4gPg0KPiA+
IFRoYW5rcyEgSSBzZW50IHNvbWUgZm9ybWF0dGVkIHBhdGNoZXMgZm9yIHJldmlldyBhIGJpdCBl
YXJsaWVyIHRvZGF5LiBTZWUNCj4gaHR0cHM6Ly9sb3JlLmtlLw0KPiBybmVsLm9yZyUyRmJwZiUy
RlNFWlBSMDNNQjY3ODYxMEVFQkE1MTQwQkFBNEQxRjEzRUI0NjAyJTQwU0VaUA0KPiBSMDNNQjY3
ODYuYXBjcHJkMDMucHJvZC5vdXRsb29rLmNvbSUyRiZkYXRhPTA1JTdDMDIlN0NtYmxhbmQlNDAN
Cj4gbW90b3JvbGEuY29tJTdDMTE5ZjM2ZDA2YWE5NDllOGM1M2QwOGRjMGNjNjU4NGYlN0M1Yzdk
MGIyOGJkZjg0MTANCj4gY2FhOTM0ZGYzNzJiMTYyMDMlN0MwJTdDMCU3QzYzODM5OTI5MzIyNDQ5
MDg5MiU3Q1Vua25vd24lN0NUDQo+IFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pR
SWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSg0KPiBYVkNJNk1uMCUzRCU3QzMwMDAlN0Ml
N0MlN0Mmc2RhdGE9MG5ZWUxDbXlkMm11VXkzUk1GYkgxQ3FuDQo+IEdxJTJCczg2ODJnZUFIbndJ
QlRPMCUzRCZyZXNlcnZlZD0wLiBUaGVyZSB3YXMgZ3JlYXQgZmVlZGJhY2sgZnJvbQ0KPiBBbGV4
ZWkgU3Rhcm92b2l0b3Ygb24gdGhlIGlzc3VlIG9mIFNwZWN0cmUgZWZmZWN0aW5nIHRoZSBpbnRl
cnByZXRlciB3aGVuIEpJVCBpcw0KPiBlbmFibGVkLCBzbyB0aGVyZSBpcyBhIG11dHVhbCBjb25m
bGljdCB3aXRoIGFueSBoYXJkZW5pbmcgb3B0aW9ucyB3aGljaA0KPiBkaXNhYmxlIEpJVC4gVGhp
cyBzZWVtcyB0byBiZSBhIG1ham9yIGJhcnJpZXIuDQo+DQo+IE5vdCBxdWl0ZS4gVGhlIHByZXNl
bmNlIG9mIF9hbnlfIGludGVycHJldGVyIGluIHRoZSBrZXJuZWwgdGV4dCBpcyBhIHByb2JsZW0N
Cj4gcmVnYXJkbGVzcyBvZiB3aGV0aGVyIEpJVC1pbmcgaXMgZW5hYmxlZCBvciBub3QuDQo+IElu
IGJwZiBjYXNlIHdlIGNhbiBhbHdheXMgdXNlIEpJVCBhbmQgcmVtb3ZlIHRoZSBpbnRlcnByZXRl
ciBmcm9tIHZtbGludXguDQo+IEhlbmNlICJKSVQgYWx3YXlzIG9uIiBpcyBhIHNlY3VyaXR5IGZp
eC4NCg0KVWdoLCBzdHVwaWQgdHlwby0tLXRoZXJlIGlzIG5vIGV4Y3VzZSwgYXBvbG9naWVzLg0K
DQpUaGUgYmVuZWZpdCBvZiBodHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvU0VaUFIwM01CNjc4
NkIyNzQ0NkRFMjYxODkzRDkxMUI1QjQ2MDJAU0VaUFIwM01CNjc4Ni5hcGNwcmQwMy5wcm9kLm91
dGxvb2suY29tLw0KdG8gbWUgaXMgbm90IGluIHRoZSBpbnRlcnByZXRlciBjaGFuZ2VzIGJ1dCBp
biB0aGUgc2VwYXJhdGlvbiBvZiBCUEYgY29kZSBwYWdlcyBmcm9tIHRoZSByZXN0IG9mIHRoZSB2
bWFsbG9jIHJlZ2lvbi4NCldpdGhvdXQgdGhpcywgb25lIGh5cG90aGV0aWNhbGx5IHdvdWxkIG5l
ZWQgdG8ga25vdyB3aGljaCBQVEVzIGFyZSBCUEYtb3duZWQgc28gdGhleSBrbm93IHdoaWNoIFBU
RXMnIFggYml0cyBhcmUgKG5vdCkgbWFsaWNpb3VzLiAoLTsNClVuZm9ydHVuYXRlbHksIHRoYXQg
aXMgYWxsIEkgY2FuIHNheSBmb3Igbm93LiBUYXJnZXRpbmcgQVJNK3g4Ni4NCg0KSWYgdGhpcyBp
cyBPSyBqdXN0aWZpY2F0aW9uIChJIGRvIG5vdCBrbm93IGl0IHdpbGwgYmUpLCBteXNlbGYgb3Ig
RGkgSmluIGNvdWxkIHN1Ym1pdCBhbm90aGVyIHBhdGNoIHdpdGggdGhlIGludGVycHJldGVyIHBv
cnRpb25zIHJlbW92ZWQ/DQoNClBldGVyIFppamxzdHJhJ3MgQ0ZJIHBhdGNoZXMgZm9yIHg4NiBs
b29rIGxpa2UgYSByZWFzb25hYmxlIGFwcHJvYWNoIHRvIHRoZSBDRkkgc2lkZS4NCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2JwZi8yMDIzMTIxNTA5MjcwNy4yMzEwMzgxNzRAaW5mcmFkZWFkLm9y
Zy9ULyBJIGltYWdpbmUgQVJNIHdvdWxkIGxpa2VseSBmb2xsb3cgc3VpdC4NCk1heWJlIFBldGVy
IGNhbiB3ZWlnaCBpbiBvbiB0aGUgcGxhbnMgaGVyZSBhbmQgaWRlYXMgYWJvdmUsIHNpbmNlIGl0
IGxvb2tzIGxpa2UgSW50ZWwgYWxzbyB3YW50cyBCUEYgaGFyZGVuaW5nLg0KDQpIb3BlZnVsbHkg
bm90IHRvdGFsbHkgb2ZmIGJhc2UgaGVyZSBhbmQgaG9wZWZ1bGx5IHR5cG8tZnJlZS4gSGVyZeKA
mXMgdG8gdGhlIGNvbW11bml0eSwgYW5kIHRoYW5rIHlvdS4NCk1heHdlbGwgQmxhbmQNCg==


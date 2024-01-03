Return-Path: <bpf+bounces-18897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76711823575
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475AEB2376D
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43E1CA9F;
	Wed,  3 Jan 2024 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="4ba/9cSm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF61CA9B
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403FTCEG030178;
	Wed, 3 Jan 2024 19:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=D3Bdefyh9QiPcAwH0oDuF6vXMRvmnFTRihAGrJAtxio=; b=4
	ba/9cSmtubC/XtupFEBwclUs1/Jno6ChsR5rUMGVDmS4QNu233eOEPedpHtv9jBX
	CYEoWiiZwHt/Wcdwr+vvpKYdiI9UdF+QncoWbyabQ/NXpbL9DZtX9tRtDsVNXFh9
	y6lS7d5Uuo5NZMUlOfx6axgrD/c0KEJoh/98WXMbdvpUWqQhTJ2873dxNwNOM0GG
	Bwv2lexufSOx6LEKPEyIkV8NspY1/7Q5bp6h2XQCq//NoWD+KhnRIMmykpRpSCvL
	hCmylwdR7wRs41TBwKhwoHkfS7U/hB3rS/ArbNcOmf2CEkw4cAM1qWPbDU9wpFUa
	5OSMX9hD8JI4iAWdyxZKA==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3vcv45j4pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 19:17:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0GcQPeQnZRv9Ujqa4LIr5Yp6jUFTzuoDGwO6joXwrPJ3Ut79HBGHGTGXxeJC0wbpdSY6Y6o2koFfUCaTKJljvZ/OlWN4DWDVzjvmLCiF0k+K++7cP9Vr5F+UxlGQ29bqdEYVRvxahQtrGxqfBbMtt1mmA8e5+HwQD/EcQuwOXKadGUzmUJc5SyqLGOoiCCnvsIYcfUDFgOy9WjS4vyD0UkU84lR8ljKKQMPQ9ueB3C/CIT3JlFo5EGJWSg/bQ+YZeldixmij1/OawcgnGKSc/unJizCt8f+ez2g3P+d2NKZLff0ItMYUBJrYxRsCWrBnzw/JiTGtNh3spvNd608qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3Bdefyh9QiPcAwH0oDuF6vXMRvmnFTRihAGrJAtxio=;
 b=gf1bc8bCdTgbopcZFXF91nez/arSmCCWc1povTdL+f3aWFW/K4mJNb072FCBjHeEc2mzkQLsr25PxN5mYheNVQiw4odhVsHVWsyhHiN6/WsWyAgAzYUWL8QIw1HeBz77iFrGrKkIelSB18kL+58OIyE+w0fRR7fFfI+4cv/PbvcgaoEGuHcINpoApFA/Zu5U1YlrmuHrIWSnek58VIp9s61tfIv5NQKmY3fiulRI0C8hEtKeo8/LljNa4figfmXdBzLGfzVhA11iBlQMBjKgfjFRWT6Vv+/GGid1y/7J1yghMqqsvJo+6mSPvDnk9pOZ/GWY3V4r4lTwdW0s76WEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by TYZPR03MB5437.apcprd03.prod.outlook.com (2603:1096:400:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 19:17:24 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 19:17:24 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrew Wheeler
	<awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?=
	<quebs2@motorola.com>,
        "di_jin@brown.edu" <di_jin@brown.edu>
Subject: [PATCH 2/2] Adding BPF CFI
Thread-Topic: [PATCH 2/2] Adding BPF CFI
Thread-Index: AQHaPnl7djtOTwLDhUGiaFvJDuPOjw==
Date: Wed, 3 Jan 2024 19:17:24 +0000
Message-ID: 
 <SEZPR03MB6786D49D9668F8F091598FA2B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <SEZPR03MB6786598744F4D5DE29C46651B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <2024010317-undercoat-widow-e087@gregkh>
 <SEZPR03MB678613E8257AD66C6CE47410B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <SEZPR03MB6786B27446DE261893D911B5B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
In-Reply-To: 
 <SEZPR03MB6786B27446DE261893D911B5B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|TYZPR03MB5437:EE_
x-ms-office365-filtering-correlation-id: eb7db95c-988b-4435-c56c-08dc0c909dec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xZz6dRUi33Fjvj8oVfhEbKop+6oxhL+/mrAGtN09S/I6ahOzLYck633QLJtplhM9/p0Ek6JWBEh0cgF8Fj4ThrORvFn3GtcR2oLOCJWfetCOzzIn1Trq506ptHiA2WdmCRRA2JKF2kRE6Pa2VWEH844FlsN9UhMWBJxPaOGC2skchDo1BTWAvaxHsE3xVHgpHsHB6mKRV6gSLQSlRpadZPDjYSGk8YF9EOEce78e/L9ucT6mYSlfMtkBNMVEwtaaomUnPQrOSgjjugBiRyrTJmaBb3hg2BSLLNJ0xV4qtvoaWo1nHoiB1z9W8x7edsyMll0w509XdmhiiRHbWmNya9yGnhDuRiF+Fw5jO4x760xRtnw+IJNmkFVZNnH9cTIoV/heBFTntfCqMqsxeLq053e7JMySXlkXfBwDvui3OPsOASYB1aQzopkyHn6viIkn9Bne0eTQATk+tpHkTn0uyM8G39GYOuX6B3NMLTGcRVcoIgg7rdkLXQdWeVwGgX5l5q6ZhjBWEVW2QLelFkWM4j48odzWM3gWp6Ritz2B1PyuOTTcvBBjkX8CDHZSeXd428rfvBJ/xeAewzmikSwa48rjckL10dXPo8kYUqtxQF32GUsP85lSKj4XdfQgmYPlwW52D1+n/9Q3gVA6Jqwy9MLYDO2/pBv5UwyGGYLA9R0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(41300700001)(2906002)(26005)(38100700002)(2940100002)(122000001)(82960400001)(54906003)(8676002)(52536014)(8936002)(316002)(71200400001)(5660300002)(4326008)(478600001)(6506007)(64756008)(7696005)(66556008)(76116006)(9686003)(66476007)(66446008)(6916009)(66946007)(86362001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eGRzYnFsUEpHazZQOXRGNHJIL09RUVZCcS9CVHpUcHpSdExaQmFBOS9lVWlB?=
 =?utf-8?B?L1haa3hhZUhxdW8vVU1IUHNrNGQxQjhuTE9pWlFHK0N6bDhIVUJyMzA5azVz?=
 =?utf-8?B?Zit5bm14bC8xVW5LUG81QWdPdmdEcERZcGZkb0ZaaTFUczZaa1BjVHZCRzc4?=
 =?utf-8?B?eXA4WFd1UVJjcURLcHIxbXdpeWxHeXU3YnZCcEo4UzJuQnVNK1dRcEZrWTk4?=
 =?utf-8?B?VXUvTDBsZlpqM0g4MWo4QlM3Yk5pSnBaQTIvWFhPV2ZkdGRzd0hHUWtnL3ZL?=
 =?utf-8?B?TSs5U0E5VlZJRTlxRnV6b29nL3JCaTZUODlSODcxRHFOeHV5Z1FFczMyckxZ?=
 =?utf-8?B?S1FiUnRzU0ZhZE9ZRm1HTWd0NWlZbkliL1VKdkk3eGNtMGthL3Y4eGlsVTVo?=
 =?utf-8?B?a2F2U0Jqd3NnWHBXZ2IwcnNKVFNGdS9uMDZMMStxK3NaM2tsbllpcEcrSVpo?=
 =?utf-8?B?RjNhalhYdjhWdE4vdHJUb29BUDFQcnNYSitMMXlWZStWYXovVVA5NXVTenR3?=
 =?utf-8?B?ckRnRzhMTXA4VFBYVklhM0lPM2d1cUhheXQ5S21CQWFWMHRjTjJ4aEVzT3Js?=
 =?utf-8?B?STVHTU4wVlNOZElvTnBmdlczV3k3NVlta3ZUS3JsblBKb0szeXRWTnArSmN5?=
 =?utf-8?B?YThkdS9GQUhVZU9KTStNVUx4TFdmTER1dVRFc1N6eXF1QXp2aTZjVEVuc21W?=
 =?utf-8?B?Vzk4NXloYTZIYThoL3NCS2wxQWNta0F6YWF6SFV2RFZveHJOMXpURldBS3NQ?=
 =?utf-8?B?S21LYnQvUlRET3ZWRWJxaTdUL244Q2hPSnRUSk4yNmh6ZUppc0ptWnFyN0xt?=
 =?utf-8?B?T2VtbklZcjRHN2Jiczhvdkg5UzdmY1lYZVdVOWI3bU5VNXNBZGorbEtnN2Rs?=
 =?utf-8?B?VTkwbUdTUkZkejcwL1g2anVjRU8wcFNjZ1ljdGdJc3ZsdDB4RWpmOUFlWGdx?=
 =?utf-8?B?WmZibXZYa05zbDUweVZFQWJ0cjRsR2crRmtyY2FNQ0tubkZweUdyWHo1MG1H?=
 =?utf-8?B?Y3huT3kwSDRDMUhNZTJ6blBOeTB0RGxlMHVmczMxdHRsaUVseFlHQnZTbEFY?=
 =?utf-8?B?R09lcGptMXFyZE83c1d4WXRWbUF6NUMvVHZRb0tFaXJDL0FXeXVJS1c5MzRF?=
 =?utf-8?B?allHcUUyQ3hvN3hwSG9ZVFpYeU1BN0pnckFRdzNoOGx1cmxzaGxCWEdoZjZH?=
 =?utf-8?B?OVArQjNVblQ1dWlwOEM2ZWovUUhJcDdSb3lmODk4M3gyTVVubG56czE2RHpD?=
 =?utf-8?B?NDRUdS9vM0ZUQldncldTUm5mMUQxZVBCckFNU3MyZjYxYTZLUndhWkk5aGVy?=
 =?utf-8?B?eTdDcTJMZDhDdTVFQTVSdEl6Y2NQVmNHc1FTRDVEcElWZzIxOTVvbmZ6eHFH?=
 =?utf-8?B?WVgydVFFdkc5NUF1UnFYdGE0MS94YTVOK211dFB5VHpUNlVxaStXdkNKNlZj?=
 =?utf-8?B?Wis5UTZqLzE0TlJGbjBhVUdWbm91NWZNRTlkbHNjMkxYOXRTZkMvbHNJQnMx?=
 =?utf-8?B?dzg1aXFWYXpBbWV0bEgrSnFtTGhZTlhSRlR6WjZkL2NLc1hMdE1LL1NKbXk5?=
 =?utf-8?B?WmZUbGYxdWZidnQ1NmIxeUhWVVdWUUR4TjhDQ3JWOG9KTzVBbzRsMlNwM3lR?=
 =?utf-8?B?YVhjT3pKcUYvaTF2c0xYOE1sajFnZ1RFUDVRcTd1bG5vRjBjcGRyTGRvYVJE?=
 =?utf-8?B?MWw4aFdjUW5aN3FlQTdHa1FBVVByWnZoaFVFU2NQclA5U1ZpS25sSHhOVTkr?=
 =?utf-8?B?eXZ2bjc4SDFrUVNlSklkbHZ0cGhhT1o2M3BmZ3UwdjZuZEdDelN2YWNscTM4?=
 =?utf-8?B?RU1WR3I5Y2dBQUhNYmtYQWZXdUw2VFpyMS9QS2JmSFVRTzJaS2E2alpjaU92?=
 =?utf-8?B?dXpSYWp1SHJvSnl4SmhDQWJiSG5nbjZ5ZWdPY2UrSDRsTC95TG5kZnI5b2VX?=
 =?utf-8?B?empEeFNPMEtFQ0Z1YncyelN5SWh2OS9Xam1uWWVYOG44VkNDUTlsam1FQng1?=
 =?utf-8?B?MEZ3MWJCTzZ0SUNHQ3FxczNMam1lc0NFUlpxYndLUzhMYjBKUHQ4dktOMS85?=
 =?utf-8?B?R2tjZVdsVXN0bWZIaW5QVkNadHR1NFZoM3MvRnAwQzdKVkJoY2JhakFsUXh1?=
 =?utf-8?Q?Ez2A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7db95c-988b-4435-c56c-08dc0c909dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 19:17:24.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m11nfkYtFrnbu7zPF5CJGUhPkzjwsqj2jc83CLWiBdQRuRQiI5DWk3eYYLurHgmY4A8pFhqIfpxpR7V7ei1D4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5437
X-Proofpoint-ORIG-GUID: sBo8_t8Y677zAl4lHgS1aEVYwlOJ-gqV
X-Proofpoint-GUID: sBo8_t8Y677zAl4lHgS1aEVYwlOJ-gqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030156

RnJvbTogVGVudXQgPHRlbnV0QE5pb2JpdW0+DQpTdWJqZWN0OiBbUEFUQ0ggMi8yXSBBZGRpbmcg
QlBGIENGSQ0KDQpDaGVjayBvZmZzZXQgb2YgQlBGIGluc3RydWN0aW9ucyBpbiB0aGUgaW50ZXJw
cmV0ZXIgdG8gbWFrZSBzdXJlIHRoZSBCUEYgcHJvZ3JhbSBpcyBleGVjdXRlZCBmcm9tIHRoZSBj
b3JyZWN0IHN0YXJ0aW5nIHBvaW50DQoNClNpZ25lZC1vZmYtYnk6IE1heHdlbGwgQmxhbmQgPG1i
bGFuZEBtb3Rvcm9sYS5jb20+DQotLS0NCmtlcm5lbC9icGYvS2NvbmZpZyB8IDEwICsrKysrKysN
CiBrZXJuZWwvYnBmL2NvcmUuYyAgfCA3OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDg5IGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvS2NvbmZpZyBiL2tlcm5lbC9icGYvS2NvbmZp
ZyBpbmRleCA3MTYwZGNhYWE1OGEuLjljNjRkYjBkZGQ2MyAxMDA2NDQNCi0tLSBhL2tlcm5lbC9i
cGYvS2NvbmZpZw0KKysrIGIva2VybmVsL2JwZi9LY29uZmlnDQpAQCAtOTQsNiArOTQsNyBAQCBj
b25maWcgQlBGX0hBUkRFTklORw0KIAloZWxwDQogCSAgRW5oYW5jZSBicGYgaW50ZXJwcmV0ZXIn
cyBzZWN1cml0eQ0KIA0KK2lmIEJQRl9IQVJERU5JTkcNCiBjb25maWcgQlBGX05YDQogYm9vbCAi
RW5hYmxlIGJwZiBOWCINCiAJZGVwZW5kcyBvbiBCUEZfSEFSREVOSU5HICYmICFEWU5BTUlDX01F
TU9SWV9MQVlPVVQgQEAgLTEwMiw2ICsxMDMsMTUgQEAgYm9vbCAiRW5hYmxlIGJwZiBOWCINCiAJ
ICBBbGxvY2F0ZSBlQlBGIHByb2dyYW1zIGluIHNlcGVyYXRlIGFyZWEgYW5kIG1ha2Ugc3VyZSB0
aGUNCiAJICBpbnRlcnByZXRlZCBwcm9ncmFtcyBhcmUgaW4gdGhlIHJlZ2lvbi4NCiANCitjb25m
aWcgQlBGX0NGSQ0KKwlib29sICJFbmFibGUgYnBmIENGSSINCisJZGVwZW5kcyBvbiBCUEZfTlgN
CisJZGVmYXVsdCBuDQorCWhlbHANCisJICBFbmFibGUgYWxpZ25tZW50IGNoZWNrcyBmb3IgZUJQ
RiBwcm9ncmFtIHN0YXJ0aW5nIHBvaW50cw0KKw0KK2VuZGlmDQorDQogc291cmNlICJrZXJuZWwv
YnBmL3ByZWxvYWQvS2NvbmZpZyINCiANCiBjb25maWcgQlBGX0xTTQ0KZGlmZiAtLWdpdCBhL2tl
cm5lbC9icGYvY29yZS5jIGIva2VybmVsL2JwZi9jb3JlLmMgaW5kZXggNTZkOWU4ZDRhNmRlLi5k
ZWUwZDI3MTNjM2IgMTAwNjQ0DQotLS0gYS9rZXJuZWwvYnBmL2NvcmUuYw0KKysrIGIva2VybmVs
L2JwZi9jb3JlLmMNCkBAIC0xMTYsNiArMTE2LDc1IEBAIHN0YXRpYyB2b2lkIGJwZl9pbnNuX2No
ZWNrX3JhbmdlKGNvbnN0IHN0cnVjdCBicGZfaW5zbiAqaW5zbikgIH0gICNlbmRpZiAvKiBDT05G
SUdfQlBGX05YICovDQogDQorI2lmZGVmIENPTkZJR19CUEZfQ0ZJDQorI2RlZmluZSBCUEZfT04g
IDENCisjZGVmaW5lIEJQRl9PRkYgMA0KKw0KK3N0cnVjdCBicGZfbW9kZV9mbGFnIHsNCisJdTgg
Ynl0ZV9hcnJheVtQQUdFX1NJWkVdOw0KK307DQorREVGSU5FX1BFUl9DUFVfUEFHRV9BTElHTkVE
KHN0cnVjdCBicGZfbW9kZV9mbGFnLCBicGZfZXhlY19tb2RlKTsNCisNCitzdGF0aWMgdm9pZCBf
X2luaXQgbG9ja19icGZfZXhlY19tb2RlKHZvaWQpIHsNCisJc3RydWN0IGJwZl9tb2RlX2ZsYWcg
KmZsYWdfcGFnZTsNCisJaW50IGNwdTsNCisJZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkgew0K
KwkJZmxhZ19wYWdlID0gcGVyX2NwdV9wdHIoJmJwZl9leGVjX21vZGUsIGNwdSk7DQorCQlzZXRf
bWVtb3J5X3JvKCh1bnNpZ25lZCBsb25nKWZsYWdfcGFnZSwgMSk7DQorCX07DQorfQ0KK3N1YnN5
c19pbml0Y2FsbChsb2NrX2JwZl9leGVjX21vZGUpOw0KKw0KK3N0YXRpYyB2b2lkIHdyaXRlX2Ny
MF9ub2NoZWNrKHVuc2lnbmVkIGxvbmcgdmFsKSB7DQorCWFzbSB2b2xhdGlsZSgibW92ICUwLCUl
Y3IwIjogIityIiAodmFsKSA6IDogIm1lbW9yeSIpOyB9DQorDQorLyoNCisgKiBOb3RpY2UgdGhh
dCBnZXRfY3B1X3ZhciBhbHNvIGRpc2FibGVzIHByZWVtcHRpb24gc28gbm8NCisgKiBleHRyYSBj
YXJlIG5lZWRlZCBmb3IgdGhhdC4NCisgKi8NCitzdGF0aWMgdm9pZCBlbnRlcl9icGZfZXhlY19t
b2RlKHVuc2lnbmVkIGxvbmcgKmZsYWdzcCkgew0KKwlzdHJ1Y3QgYnBmX21vZGVfZmxhZyAqZmxh
Z19wYWdlOw0KKwlmbGFnX3BhZ2UgPSAmZ2V0X2NwdV92YXIoYnBmX2V4ZWNfbW9kZSk7DQorCWxv
Y2FsX2lycV9zYXZlKCpmbGFnc3ApOw0KKwl3cml0ZV9jcjBfbm9jaGVjayhyZWFkX2NyMCgpICYg
flg4Nl9DUjBfV1ApOw0KKwlmbGFnX3BhZ2UtPmJ5dGVfYXJyYXlbMF0gPSBCUEZfT047DQorCXdy
aXRlX2NyMF9ub2NoZWNrKHJlYWRfY3IwKCkgfCBYODZfQ1IwX1dQKTsgfQ0KKw0KK3N0YXRpYyB2
b2lkIGxlYXZlX2JwZl9leGVjX21vZGUodW5zaWduZWQgbG9uZyAqZmxhZ3NwKSB7DQorCXN0cnVj
dCBicGZfbW9kZV9mbGFnICpmbGFnX3BhZ2U7DQorCWZsYWdfcGFnZSA9IHRoaXNfY3B1X3B0cigm
YnBmX2V4ZWNfbW9kZSk7DQorCXdyaXRlX2NyMF9ub2NoZWNrKHJlYWRfY3IwKCkgJiB+WDg2X0NS
MF9XUCk7DQorCWZsYWdfcGFnZS0+Ynl0ZV9hcnJheVswXSA9IEJQRl9PRkY7DQorCXdyaXRlX2Ny
MF9ub2NoZWNrKHJlYWRfY3IwKCkgfCBYODZfQ1IwX1dQKTsNCisJbG9jYWxfaXJxX3Jlc3RvcmUo
KmZsYWdzcCk7DQorCXB1dF9jcHVfdmFyKGJwZl9leGVjX21vZGUpOw0KK30NCisNCitzdGF0aWMg
dm9pZCBjaGVja19icGZfZXhlY19tb2RlKHZvaWQpDQorew0KKwlzdHJ1Y3QgYnBmX21vZGVfZmxh
ZyAqZmxhZ19wYWdlOw0KKwlmbGFnX3BhZ2UgPSB0aGlzX2NwdV9wdHIoJmJwZl9leGVjX21vZGUp
Ow0KKwlCVUdfT04oZmxhZ19wYWdlLT5ieXRlX2FycmF5WzBdICE9IEJQRl9PTik7IH0NCisNCitz
dGF0aWMgdm9pZCBicGZfY2hlY2tfY2ZpKGNvbnN0IHN0cnVjdCBicGZfaW5zbiAqaW5zbikgew0K
Kwljb25zdCBzdHJ1Y3QgYnBmX3Byb2cgKmZwOw0KKwlmcCA9IGNvbnRhaW5lcl9vZihpbnNuLCBz
dHJ1Y3QgYnBmX3Byb2csIGluc25zaVswXSk7DQorCWlmICghSVNfQUxJR05FRCgodW5zaWduZWQg
bG9uZylmcCwgQlBGX01FTU9SWV9BTElHTikpDQorCQlCVUcoKTsNCit9DQorDQorI2Vsc2UgLyog
Q09ORklHX0JQRl9DRkkgKi8NCitzdGF0aWMgdm9pZCBjaGVja19icGZfZXhlY19tb2RlKHZvaWQp
IHt9ICNlbmRpZiAvKiBDT05GSUdfQlBGX0NGSSAqLw0KKw0KIHN0cnVjdCBicGZfcHJvZyAqYnBm
X3Byb2dfYWxsb2Nfbm9fc3RhdHModW5zaWduZWQgaW50IHNpemUsIGdmcF90IGdmcF9leHRyYV9m
bGFncykgIHsNCiAJZ2ZwX3QgZ2ZwX2ZsYWdzID0gYnBmX21lbWNnX2ZsYWdzKEdGUF9LRVJORUwg
fCBfX0dGUF9aRVJPIHwgZ2ZwX2V4dHJhX2ZsYWdzKTsgQEAgLTE3MTksMTEgKzE3ODgsMTggQEAg
c3RhdGljIHU2NCBfX19icGZfcHJvZ19ydW4odTY0ICpyZWdzLCBjb25zdCBzdHJ1Y3QgYnBmX2lu
c24gKmluc24pICAjdW5kZWYgQlBGX0lOU05fMl9MQkwNCiAJdTMyIHRhaWxfY2FsbF9jbnQgPSAw
Ow0KIA0KKyNpZmRlZiBDT05GSUdfQlBGX0NGSQ0KKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KKwll
bnRlcl9icGZfZXhlY19tb2RlKCZmbGFncyk7DQorCWJwZl9jaGVja19jZmkoaW5zbik7DQorI2Vu
ZGlmDQorDQogI2RlZmluZSBDT05UCSAoeyBpbnNuKys7IGdvdG8gc2VsZWN0X2luc247IH0pDQog
I2RlZmluZSBDT05UX0pNUCAoeyBpbnNuKys7IGdvdG8gc2VsZWN0X2luc247IH0pDQogDQogc2Vs
ZWN0X2luc246DQogCWJwZl9pbnNuX2NoZWNrX3JhbmdlKGluc24pOw0KKwljaGVja19icGZfZXhl
Y19tb2RlKCk7DQogCWdvdG8gKmp1bXB0YWJsZVtpbnNuLT5jb2RlXTsNCiANCiAJLyogRXhwbGlj
aXRseSBtYXNrIHRoZSByZWdpc3Rlci1iYXNlZCBzaGlmdCBhbW91bnRzIHdpdGggNjMgb3IgMzEg
QEAgLTIwMzQsNiArMjExMCw5IEBAIHN0YXRpYyB1NjQgX19fYnBmX3Byb2dfcnVuKHU2NCAqcmVn
cywgY29uc3Qgc3RydWN0IGJwZl9pbnNuICppbnNuKQ0KIAkJaW5zbiArPSBpbnNuLT5pbW07DQog
CQlDT05UOw0KIAlKTVBfRVhJVDoNCisjaWZkZWYgQ09ORklHX0JQRl9DRkkNCisJCWxlYXZlX2Jw
Zl9leGVjX21vZGUoJmZsYWdzKTsNCisjZW5kaWYNCiAJCXJldHVybiBCUEZfUjA7DQogCS8qIEpN
UCAqLw0KICNkZWZpbmUgQ09ORF9KTVAoU0lHTiwgT1BDT0RFLCBDTVBfT1ApCQkJCVwNCg==


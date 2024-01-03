Return-Path: <bpf+bounces-18968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECAD82394E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E71B248BD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5D1F92C;
	Wed,  3 Jan 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="IiNcZ945"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21521F939
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403G5v5H020239;
	Wed, 3 Jan 2024 23:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=qb6ndRFzhcSPrzRimuYn9xNILJd+SUAFgxsFg8yqdIE=; b=I
	iNcZ945iB4vqAdQngjfLjL/mOxI1v0u6zPan0JRRhoejkDSzCZyIODn4aEBapXWI
	UfZMw4mTpsDdaGnFQAaeQ3qHWcpHbOqxAQYWGT4fiVyHovyi9gH0mN8kgg/wnos/
	MUcdoqujzFQdUfWx87p2qVkvTn/a6sDYs8Ezv7UUefNfhm0ekbpZ17/mq32zaMbg
	1x9xE2eBufqzLQgcR7ISxusyLuebyb+stGTLHGP62W254AjU+zrx6FCjVdTHCHyB
	KItEWwbkvxNk7DkyzzJCPCy7tI8dcFrmBIylU6Jxj1Ok5tSew3gmNGHHo6IyfixH
	d6qCPo7tf4li7JSVk1T/A==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3vcxh6t51f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 23:45:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYZeSX/p3z9773VI0VbWQtgGkE9SXntxndrQ4JCzAX1E9KMGQvpc3mPPFfGGXofntzxWw3NmnbgMv/RgsvMduNuegVDUqv9Wh3dGh4VLvAXflo1w17cLQRT82wMNxvlZnsvm+QSgeDQwhk5GeZMFPC2pHoh0jqqftmhrGcYdJmMlMyuJ70mCrjHh1b3XkF1G62LKGrcrLFXUmzZqFWj0XjDFrXLQwmMOb8ytJ1lY5LMxKRm84ruMUWQu5jIR92u4H/ihTlmvyY0eT13sXRvZP36d8WN9xHE6946ccFQWXf7vwIyrrI1nhG8FN1BMYnvd1+iHVM9FqTqftsT6PXcShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb6ndRFzhcSPrzRimuYn9xNILJd+SUAFgxsFg8yqdIE=;
 b=Eivu68pFPVf77ui0EYGRVbQyQC7liOrhNYxE6OwAqgwYuvOz2QFs1JHaxtF0FCFPvGHrzYFPafFSj2clfR5VFrta4C1qlPonTLmUTUVWTcn9qqV8IVNAwJZdyzqLzbhoCYXgpxlnYbp+DTW+gJQGxXyZD5vy4t/YWh3qQkPSZnRHGY7f5QwUXaO3m4ZXkxH2ZNU+0xTCE1QQiGTHWfdM2cKv/C8XelnPfx9kLztUy/H7fwxFoPwkwAAPMGcZQdr6QkEMxJWpdn08UexnHIfR21L0ot4gtjEh6YViWiqF9oqLwmW65hqqnuryDrsjZkkQYQhdyxoP0MD906+gD2rqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by TYZPR03MB5485.apcprd03.prod.outlook.com (2603:1096:400:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 23:45:28 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 23:45:28 +0000
From: Maxwell Bland <mbland@motorola.com>
To: "Jin, Di" <di_jin@brown.edu>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "v.atlidakis@gmail.com"
	<v.atlidakis@gmail.com>,
        "vpk@cs.brown.edu" <vpk@cs.brown.edu>,
        Andrew
 Wheeler <awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: RE: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
Thread-Topic: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
Thread-Index: AQHaPpWonDW/eHWeP0q2GVAamFCjbrDIvSYA
Date: Wed, 3 Jan 2024 23:45:28 +0000
Message-ID: 
 <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
In-Reply-To: 
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|TYZPR03MB5485:EE_
x-ms-office365-filtering-correlation-id: 8cacff41-4346-4de1-26fd-08dc0cb610df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JMtjBfAWBoPkNpJ6yT389v2l/k3q25Us5M6T7C9bu7gygXAa9tu5Zyml669n7TybqWxwVwJjlJJIZmPdioXNMilfHb8v6NfAkpotPm+pFSwE8750Rzo4xOFTOyr96Cua5olC7JRVYtHAHAf4vzatUhkIBpQkLKefm0/bli0bjU4mnIl+mWaBdEgoTNWzG/dYL3mPA2LWOP9kFxv+344M9n72/EjYP4hOFL8tatb5O6wnzA9sHO4YVfNYYkHgpe97F4mEdg/XESvDIJjG904y4+n8Jiqag3i5zTOXdaQ5i2eHVEC0XTXfQSx30tN1X2uOKUEsfC1v3N8X5h5HRNlOM2cCdW7EisAOpoeRgQgDeCwpdq/+UF7TWI+hYqJtBQtZiHD4zYcgKgQzvFMc5ZIA/D41G5kB6EN7Ny5n8x8j1jMHAXshSOm6CPJBnxBYmJeN72Ty5ktYkOAu2CW72pSDsbQS1nePmtlGk3bebZgE5eg1DB5WcrIaocfPmJkpUWAR1KkR6euxGrhmh372oFzavWcqnAgKwYdY8ho9olvHqwGh9zKCIE5tKU0CFiAUFSNUAjxrxjm/gZGcLl3AT1xW+jEkKmjisthexETULQQKhJqs1T4QdEVkyy5uTyLnq/rV4ig21/sUfVtXcN1K98q0sUvkU5uJ7Yp++KZ9Ah6i1As7MNWq/vtjsc3eDl/UfG75
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(55016003)(45080400002)(966005)(478600001)(6506007)(53546011)(9686003)(33656002)(41300700001)(4326008)(71200400001)(26005)(83380400001)(66556008)(54906003)(64756008)(66476007)(66446008)(6916009)(7696005)(38070700009)(76116006)(66946007)(86362001)(82960400001)(2906002)(38100700002)(316002)(5660300002)(52536014)(122000001)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U1B1ZkpGbzQybkM0V0R5SWNIRy9JZXhYajZDNmpwOFFSSTZibVBHRkQreklo?=
 =?utf-8?B?eDJPTkNXRjNNbXgxSzNZOFRqUVFheHQ1cXZpRW54ekZZaVQ2ME1DRVU4Nmx1?=
 =?utf-8?B?bXhhNWdTaXQ2b0NlWTRxNEJPUkJ3YVlXekxkenJRVDJRS1ovQndFTkNCaWN0?=
 =?utf-8?B?RDdWV1BlZ1hGZnA4YmJwQ01uM3phQzhQRG5UOGd4b2wzYmRncUdRZGdXUXpQ?=
 =?utf-8?B?TW1TMnVyb0VVdUlaSjRzT1JUZ09tYTFiTS9mOFpaSXUzZjBBdGtyM2JLNjdJ?=
 =?utf-8?B?OUhzTkV2ZUdmWkdQU0d2YWV3UUNkKzhNUjVSL0YvaG9Gc0I4RnBDUWQwL3Y1?=
 =?utf-8?B?MU9vT1NKMkIwQmM4V0NmRXlubDRlTEhXMmplZ3pHQ1ZhaDRkNHozWUFvUnFH?=
 =?utf-8?B?U3NQNllzcnpwdzVxMnhKS0xSYnNuQ21kNWZJN3lMbmlmaFNIRzR0M3JuSnNw?=
 =?utf-8?B?QWdvVW5NOVJDYzlHK0FkaXI1aTNEQllqQWRJc2JodlFiSDZqaXVMNGZvV2Ri?=
 =?utf-8?B?SlhlR0dqKzFiUDJxL2c5VHBZaEpoMHpVcUdXQVRsL1Q5ZVoxWmMycFBjb0dk?=
 =?utf-8?B?M2xpV056ZG1kSHRzNmxWbDk5eldjYmdiZmNtUDFKV2sxdlZWR3BRRlRIc3pK?=
 =?utf-8?B?eUhtVjVRVDJkOUw2ekQxM3hSNFJXNmtwRVNTam9OY0tZOXpLNE9haGtxSTUx?=
 =?utf-8?B?T3pMRXhVeFJ6K1RnUWZwdWk2dWorM1FBZTlqNlRvdTIza3ptVlA2SU5hT0hX?=
 =?utf-8?B?OUFmRUhHaGhBcm1uRFNwbG1sNW5JQTNCc2o4OWhFRm8yWU9kZUlaVWtIakNC?=
 =?utf-8?B?ZmJvR3o4UmwwSTBJbjR0dC9udHdKNVFUejBoWG5ZYjZwZGs4SHZGOHZWMlFt?=
 =?utf-8?B?ZEkyVjJ0TVptYXNRNWNJdnY1N1FsMlpEcGE1N3dzV2owVGZUaE5ROGVicCtZ?=
 =?utf-8?B?LytlTU1FOUsvNTVKNzkrTDBYRmJBN2NlOU5YZEZqNUM4aWU3QllveWdaR1hD?=
 =?utf-8?B?dkY3V25SN2VCTUZSZjVCTjloSklUQ3lrM25PN2NiTitnQ0ozeElNa2dMYTZW?=
 =?utf-8?B?dDBxTVB2MDVGam1qRjJFODQ1eFRRY0E2eVVqaU5Ndy8ySS9DUG5nL0YvVDNj?=
 =?utf-8?B?cGY4QlJpMGpMZnB0NWxQRXFtSHJ5cFh2a2FndzExRzA2bW1RUERqc2czVWNJ?=
 =?utf-8?B?QTAvWlFHZExTTzAraGFBcmJtdEx6SUZtUmErU0JvMkVxbWl0aEpQQkpCREhZ?=
 =?utf-8?B?MGpFd2JKYlZhSmpQVmNiMkY1SFFVeTNHS1JUSVdJYXJTWHhmcFhkR0I0eGRN?=
 =?utf-8?B?cVIyckVRbENJV3M1VjV4QnR4RmVzTjBJSXZiY0ZFNWFvVm5NRytzWkxwVFM3?=
 =?utf-8?B?bVhCWS9pVndPWGY4Vm5adVBLODJ1TENpejJQSGVOcG5DZCttOUJPTHZ3NHIr?=
 =?utf-8?B?N3h3ZytvRzVDZXlzMGx6MTZuNG9nYm1PWkNyVmJlOTEvL1NTQTdraW5pZWhx?=
 =?utf-8?B?cktySzhRQjR5bTlhbWs1K2cvcDlLNmNTWk5DYVR0UjdlTlZQN2liT2lxeFNm?=
 =?utf-8?B?L2xjd0hiRFpJeDFDOUVvb3ZnZ2h1aUhvVng1Yi91Sll2Y2k4M1FUT2VBZ0hD?=
 =?utf-8?B?eTkxWDd4Zm9XM1BEWkpLWTh2cXF0SU95MTh0YXg3SjlsZkdMSysyc1NSTUM4?=
 =?utf-8?B?aXlkVlVjeXI0ZzBucTFIU0syb1dkTml2d0hZZVdweEVOcXdWbTZ6dW10OE9j?=
 =?utf-8?B?SEF2WFoxMFBVNVB2L0xyaEY1YlNsQjFuWm55RVBjbmUrdkp6RFFvWjdrWG5F?=
 =?utf-8?B?S3lZTndBU1U2eHR0ZGdJV3Nnd2ZXbjJ5U0NVbzg0RFY4dFlDbHZML0tIVk9u?=
 =?utf-8?B?RTQzZkJDaXpWemZvSkMrdlBSSkNZZ3NiM3ZySHVzN2pnMlE3WFp1OGl5cFdV?=
 =?utf-8?B?bzRJbmlkalRIdXRFTEQ2NVBNQ2hDYU9WUTNZcDI3eU5PRHE1R09zbURnaDk4?=
 =?utf-8?B?eGVYWnVDaEJQTy9wN0pxUC9KMjNvUk5UYWk1WjJvRnYvd1oxRkEwaEFYQWpU?=
 =?utf-8?B?MkRIeThCa25aNGs0ZEo5QXorcHA5VVhMbTRlbWx5MW42aTM2alh0UDQ4alF1?=
 =?utf-8?Q?33pw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cacff41-4346-4de1-26fd-08dc0cb610df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 23:45:28.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXlJUJtHQR0D3sO3QN8FLwIXeQ5d/yg8Gvg+162z13QBJU27j+BUfbEmWbQQ/1RboEx5DBQZmy8Sz0gZTYe8Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5485
X-Proofpoint-ORIG-GUID: rUmmllFZmMuC7-bSfR4Zh2CSU-FyR65h
X-Proofpoint-GUID: rUmmllFZmMuC7-bSfR4Zh2CSU-FyR65h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_02,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=968 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030190

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaW4sIERpIDxkaV9qaW5AYnJv
d24uZWR1Pg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMywgMjAyNCA0OjM5IFBNDQo+IFRv
OiBicGZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFeHRlcm5hbF0gRndkOiBCUEYtTlgr
Q0ZJIGlzIGEgZ29vZCB1cHN0cmVhbWluZyBjYW5kaWRhdGUNCj4gDQo+IC0tLS0tLS0tLS0gRm9y
d2FyZGVkIG1lc3NhZ2UgLS0tLS0tLS0tDQo+IEZyb206IEppbiwgRGkgPGRpX2ppbkBicm93bi5l
ZHU+DQo+IERhdGU6IFdlZCwgSmFuIDMsIDIwMjQgYXQgNToxOeKAr1BNDQo+IFN1YmplY3Q6IFJl
OiBCUEYtTlgrQ0ZJIGlzIGEgZ29vZCB1cHN0cmVhbWluZyBjYW5kaWRhdGUNCj4gVG86IE1heHdl
bGwgQmxhbmQgPG1ibGFuZEBtb3Rvcm9sYS5jb20+DQo+IENjOiB2LmF0bGlkYWtpc0BnbWFpbC5j
b20gPHYuYXRsaWRha2lzQGdtYWlsLmNvbT4sIHZwa0Bjcy5icm93bi5lZHUNCj4gPHZwa0Bjcy5i
cm93bi5lZHU+LCBkYm9ya21hbkBrZXJuZWwub3JnIDxkYm9ya21hbkBrZXJuZWwub3JnPiwgbHNm
LQ0KPiBwY0BsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyA8bHNmLXBjQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnPiwNCj4gYnBmQHZnZXIua2VybmVsLm9yZyA8YnBmQHZnZXIua2VybmVsLm9y
Zz4sIEFuZHJldyBXaGVlbGVyDQo+IDxhd2hlZWxlckBtb3Rvcm9sYS5jb20+LCBTYW1teSBCUzIg
UXVlIHwg6ZiZ5paM55SfDQo+IDxxdWViczJAbW90b3JvbGEuY29tPg0KPiANCj4gDQo+IERlYXIg
YWxsLA0KPiANCj4gVGhlcmUgYXJlIGEgY291cGxlIG9mIG5vdGV3b3J0aHkgdGhpbmdzIGFib3V0
IHRoZSBwYXRjaGVzOg0KPiAxLiBUaGV5IGN1cnJlbnRseSBkb24ndCB3b3JrIHdpdGggQ09ORklH
X1JBTkRPTUlaRV9NRU1PUlksIHdoaWNoDQo+IHNob3VsZCBwcm9iYWJseSBiZSBhZGRyZXNzZWQu
DQo+IDIuIEJQRi1DRkkgdHJpZXMgdG8gZW5zdXJlIHRoZSBpbnRlcnByZXRlciBzdGFydHMgZnJv
bSB0aGUgY29ycmVjdCBvZmZzZXQgdW5kZXINCj4gY29kZS1yZXVzZSBhdHRhY2tzLCB3aGljaCBt
ZWFucyBpdCBuZWVkcyBzb21lIGZvcm0gb2YgY29udHJvbCBmbG93IGludGVncml0eS4NCj4gSGVy
ZSB3ZSBhcmUgZW5mb3JjaW5nIHRoYXQgd2l0aCB0aGUgc3RhdGUgb2YgYSByZWFkLW9ubHkgdmFy
aWFibGUsIHdoaWNoIGlzDQo+IHRvZ2dsZWQgYnkgdGVtcG9yYXJpbHkgZGlzYWJsaW5nIHRoZSBX
UCBiaXQuIFRoaXMgYWxzbyBpbnRyb2R1Y2VzIHRoZSBwcm9ibGVtDQo+IG9mIGhhdmluZyB0byBk
aXNhYmxlIGludGVycnVwdCBkdXJpbmcgdGhlIGludGVycHJldGVyJ3MgZXhlY3V0aW9uIG90aGVy
d2lzZSB0aGUNCj4gdmFyaWFibGUgd2lsbCBiZSBpbiB0aGUgd3Jvbmcgc3RhdGUgZHVyaW5nIGlu
dGVycnVwdC4gSW4gdGhlIHBhcGVyIHdlIG9wdGltaXplZA0KPiBhd2F5IHRoZSB0b2dnbGluZyBv
ZiB0aGUgV1AgYml0IGJ5IHNvbWUgdHJpY2sgaW52b2x2aW5nIHR1cm5pbmcgb2ZmIHByb3RlY3Rp
b24NCj4gbGlrZSBTTUFQIGR1cmluZyB0aGUgaW50ZXJwcmV0ZXIncyBleGVjdXRpb24sIHdoaWNo
IGlzIGZhc3RlciBpbiB0ZXJtcyBvZg0KPiBwZXJmb3JtYW5jZSwgYnV0IHRoZSBzZWN1cml0eSB0
cmFkZS1vZmYgaXMgYSBiaXQgbW9yZSBzdWJ0bGUuIFRoZSBhcmd1bWVudA0KPiBiZWluZyB0aGF0
IFNNQVAgKG9yIFBBTikgYXJlIGNvbnRyaWJ1dGluZyB2ZXJ5IG1hcmdpbmFsbHkgd2hlbiBCUEYN
Cj4gcHJvZ3JhbXMgYXJlIGJlaW5nIGV4ZWN1dGVkLCBzaW5jZSB0aGUgdGhpbmdzIHRoZXkgYXJl
IGRlZmVuZGluZyBhZ2FpbnN0LA0KPiBuYW1lbHkgdXNlci1jb250cm9sbGVkIG1lbW9yeSBjb250
ZW50LCBhcmUgYWxyZWFkeSBwcmVzZW50IGluIHRoZSBleGVjdXRpb24NCj4gY29udGV4dC4gVGhp
cyB2ZXJzaW9uIG9mIEJQRi1DRkkgc2hvdWxkIGluY3VyIGFsbW9zdCBubyBvdmVyaGVhZC4gVGhl
IFdQIGJpdA0KPiB0b2dnbGluZyB2ZXJzaW9uIEkgZG9uJ3QgaGF2ZSBudW1iZXJzIGF0IGhhbmQu
DQo+IA0KPiBATWF4d2VsbDogSWYgeW91IGFyZSBub3QgaW4gYSBodXJyeSAoSSB3aWxsIG5lZWQg
YSBjb3VwbGUgb2YgZGF5cykgSSBjYW4NCj4gZ2VuZXJhdGUgYSBzZXQgb2YgcGF0Y2hlcyB0aGF0
IGFyZSBjb21wYXRpYmxlIGZvciBwYXRjaCBzdWJtaXNzaW9uIChwcm9wZXINCj4gbmFtZSBhbmQg
ZW1haWwgYWRkcmVzcywgc2lnbm9mZiwgZm9ybWF0dGluZywgZXRjLiksIGR1cmluZyB3aGljaCBJ
IGNhbiBhbHNvIGdldA0KPiBzb21lIHBlcmZvcm1hbmNlIG51bWJlcnMuIFdlIGNhbiBkaXNjdXNz
IGF1dGhvcnNoaXAgZGVwZW5kaW5nIG9uIGhvdw0KPiBtdWNoIHlvdSB3YW50IHRvIGFkYXB0IHRo
ZXNlIHBhdGNoZXMuDQo+IA0KPiBSZWdhcmRzLA0KPiBEaSBKaW4NCg0KSGkgRGkgSmluLA0KDQpU
aGFua3MhIEkgc2VudCBzb21lIGZvcm1hdHRlZCBwYXRjaGVzIGZvciByZXZpZXcgYSBiaXQgZWFy
bGllciB0b2RheS4gU2VlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi9TRVpQUjAzTUI2Nzg2
MTBFRUJBNTE0MEJBQTREMUYxM0VCNDYwMkBTRVpQUjAzTUI2Nzg2LmFwY3ByZDAzLnByb2Qub3V0
bG9vay5jb20vLiBUaGVyZSB3YXMgZ3JlYXQgZmVlZGJhY2sgZnJvbSBBbGV4ZWkgU3Rhcm92b2l0
b3Ygb24gdGhlIGlzc3VlIG9mIFNwZWN0cmUgZWZmZWN0aW5nIHRoZSBpbnRlcnByZXRlciB3aGVu
IEpJVCBpcyBlbmFibGVkLCBzbyB0aGVyZSBpcyBhIG11dHVhbCBjb25mbGljdCB3aXRoIGFueSBo
YXJkZW5pbmcgb3B0aW9ucyB3aGljaCBkaXNhYmxlIEpJVC4gVGhpcyBzZWVtcyB0byBiZSBhIG1h
am9yIGJhcnJpZXIuDQoNCkFuIGFyY2hpdGVjdHVyZS1pbmRlcGVuZGVudCBpbXBsZW1lbnRhdGlv
biB3b3VsZCBhbHNvIGJlIGEgbmljZS10by1oYXZlIGFuZCBhZGRyZXNzIHRoZSBDT05GSUdfUkFO
RE9NSVpFX01FTU9SWSBpc3N1ZSwgcmVxdWlyaW5nIHNvbWUgYWRkaXRpb25hbCB3b3JrIHdpdGgg
dm1hbGxvYyB0byBwcm92aWRlIGFnbm9zdGljIHNlZ21lbnRhdGlvbiBiZXR3ZWVuIHRoZSBhbGxv
Y2F0aW9uIG9mIGtlcm5lbC1wcml2aWxlZ2VkIGNvZGUgYW5kIGRhdGEuIEFsc28sIGZlZWwgZnJl
ZSB0byByZWFjaCBvdXQgdG8gbWUgZGlyZWN0bHkgd2l0aCBhbnkgcXVlc3Rpb25zLCBzbyBhcyB0
byBub3QgY3Jvd2QgdGhlIG1haWxpbmcgbGlzdC4NCg0KUmVnYXJkcywNCk1heHdlbGwgQmxhbmQN
Cg==


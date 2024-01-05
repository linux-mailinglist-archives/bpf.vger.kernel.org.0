Return-Path: <bpf+bounces-19139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889F0825B38
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 20:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1095828574B
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 19:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EB35F17;
	Fri,  5 Jan 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="sREucmbm"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F735F15
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.17.1.24/8.17.1.24) with ESMTP id 405GW2xM016173;
	Fri, 5 Jan 2024 19:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=eMYJ9uzjsZaxLbkQ3gnrFi+rbrSfUmOzdkJfS/tqsd8=; b=s
	REucmbmznzXpLJ84Ry3xl4PdrDeQGrpEvuaOExsz9IK5kWChHqhIcZUx09L8MRtS
	2PRqNAtMSGFvW2io7HM1XeiO5KRb+MiIniG9zs6mtX97PyRTtQre/adoPThzN/5H
	ye3JmkGlkVNch2cl6cj0qjffLCMKhJo5RKQdfJp+aidx8cybkHwNCyZqoA3dklY8
	wDe8FxFmge3hpds50gTL3OkQiwPPBoiTShNWmzf/TiGEhZ99wx2krXWVkj34GOaF
	DOdNGJuu5UEkqhbEJwqKQOlLwAu1NRUySZ9srM7cOBVXy2lLzxUSXZVriO3lLfER
	nOFaTd6mOxdwX5UtUCw4w==
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by m0355090.ppops.net (PPS) with ESMTPS id 3vencer7nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 19:52:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f14tB5NYMz2H21pLXgIOTMcrO6+D62pPcQarlz6k34vt6341iYTSj12mSv7YRDq8DqZibG+KrHoGARnlP8sLXLyYCALkM7f7tSvgA+ftWODoLBN7ZXbc4q4pJnVUptqYkgZJ4xwovfrR6OXkz4HWfDDqrupYLOxwDR4z+euprAJjIcEau0xsa5AG9PYirigeRFRNvMgwvuk7QdoZcZI1GGDXNvHAuZn1GWQQJUuZOb1cM04bVsE8zivpA7kp2R2e09s6SZ9fmC63x962dVPUX+dwAbsWlLg/yuZk8n6WzeySFdLZdVqZOv2e+9pqBLpsB13zXLgpzV3xtmEaVpJOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMYJ9uzjsZaxLbkQ3gnrFi+rbrSfUmOzdkJfS/tqsd8=;
 b=XZaUSDbhdjuUQ+MI24M/nLl7MRsTFw3xqJwsQH/l7vb1e0OGTDAanRCf+A7629VKTtLqNjyWbM8FikhRsq6q/SxZVmXZzMk8oXv/sNzSPFzGiOGG9wOqF9uZ+RxYOl1ZaRrdjX39+dYuip16+Zdh6NX9ITs7Y60QaK5y3BRNi4Yi/lyxW+0xOtmreEyuNrz09Y441FO4BNbV6CFGoTwq4+F8ne9y+t6vv0DuoKga0+a88+KGRk/1YaFWq4zqlIJewOfu6pOkYmvllSVeYv74cAAwjg1AAZSWQQu494LjN0Y0pfH5DtmZDv43hguk0p2j+D70QWYCzmtAy2ZavnLKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by PSAPR03MB5382.apcprd03.prod.outlook.com (2603:1096:301:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Fri, 5 Jan
 2024 19:52:23 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 19:52:23 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Maxwell Bland <mbland@motorola.com>, "Jin, Di" <di_jin@brown.edu>,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "v.atlidakis@gmail.com"
	<v.atlidakis@gmail.com>,
        "vpk@cs.brown.edu" <vpk@cs.brown.edu>,
        Andrew
 Wheeler <awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>
Subject: BPF not using ARM64 module_alloc?
Thread-Topic: BPF not using ARM64 module_alloc?
Thread-Index: AQHaQBCzzoJ//sOYx0O9BXTBuvYKZQ==
Date: Fri, 5 Jan 2024 19:52:23 +0000
Message-ID: 
 <SEZPR03MB67867AEFDAF7538F047DAAF3B4662@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
 <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
 <CAKOkDnPZ5SKYOQhE646Se5oYCi7Rc3ubUTnrE+-aXiViTsA1jQ@mail.gmail.com>
 <SEZPR03MB6786BF42E7105E8B55C5788DB4662@SEZPR03MB6786.apcprd03.prod.outlook.com>
In-Reply-To: 
 <SEZPR03MB6786BF42E7105E8B55C5788DB4662@SEZPR03MB6786.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|PSAPR03MB5382:EE_
x-ms-office365-filtering-correlation-id: 82458afe-c536-455d-841e-08dc0e27d5af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 WiYJYScjJ/WQucdlCFaw6eXY5ZiO30R4GYo/HTIW94+wp8mEei8oOnMsAUs+n/XLgtsXmAYfQT9wDwooqyKzxgaUVC0EALpm5iy82TA9KxbMsdfoNERJVUbzVNB2dd+t8LjE9HjoCAOpynz8VKEGS/jy5JoRvCYe6nzBC1ItF3zI71sOdxPEcDDEzMuPlXb4snf9tfRjgNqCbdA8LqTJ1ySrp40MZlHbDuTJlQA3cjET3BYLYX5aRzSyrjhPC2E6O9ftDI4SqpVrw6Bg6VFTVIgvwDQzQuUnSZjlO7zEW2IUrvysEnpCP92QC7X/q5N/+i7dAddRhZyX1HoYm+QJAl3Gv4/uAtgEBAB/qCHdy9Mhp8Y8sGConFDQx0tScICv/EVVX2OOI6E4sr00f4GdZZWZWd4oTUo17Vj7w5NTV0uzCvQXaZq7o2bLRw0lmmtDmOa2d3LAVRj7sP+VyFtw++B+zAUfdT42nAoJdkIUnvb6ja69m5tV77m0DDC2Ry4bR10x+pESP8MeIhNCBAmg3hBRLntcQyc3wKZD4N/hZCprJQNJXo0s0m2tOYPt6h1fH6moZS3K//4npDYq9jvsfGc9JxxRdGdxM363pPAsYwxlQN5menNibhSrQNceKu3ieZZTdGRoqtROSpd6AXntcKnvakmE1lHa0RkP+zIyqV2Ic2/ibg7jR6dvRXn2s17Y
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(52536014)(8936002)(8676002)(4326008)(76116006)(66946007)(82960400001)(66556008)(316002)(54906003)(110136005)(41300700001)(66476007)(66446008)(64756008)(38070700009)(2906002)(33656002)(5660300002)(86362001)(2940100002)(26005)(107886003)(83380400001)(38100700002)(478600001)(122000001)(966005)(9686003)(71200400001)(7696005)(6506007)(53546011)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VlNQSjNjRkdPcVdnK0M1cWFrU2hZSVFEbmZyTFg0MXVsMmdvR2xXalVQWmcx?=
 =?utf-8?B?WU0vSDl6SXA0VzhUTjFoL1orTk1taWpiSHAwY3p1bkUvd3Y0N2pMSk5TNHNv?=
 =?utf-8?B?OUpLZ1FrdjhjbmVLSERpK1hiWVRTTXpKMVFPeGlDR1VzMjF3UDFsSmdnbE0z?=
 =?utf-8?B?STNEd1ViSVhyd0FuQlBzN1NWSDloeXBJSnF0d3ErUnA1VHJJMlUyVEFyV0Zh?=
 =?utf-8?B?VHZpYm9CYk9PU0RlS1paQ0IrSUFhSHpqekRnYWdLdjZNZytITFJmd0lUVmF4?=
 =?utf-8?B?akRmeVlxS2dQUDI0RUJsRzVDUWE5YytjTFhSL2pwWE4rTEp6UStVckE1NHBB?=
 =?utf-8?B?N1hFM2pUUmk1U0RVVXJEZThQZVBjSHEwQVhtVnBSQzMwTlF3QkNKZVV0dURi?=
 =?utf-8?B?Z1E0NWZIbkliUTZweVlHSEk1K1FGN1J4Q1Y3ajQwcVpuZ0UzU0p2MUo3emJF?=
 =?utf-8?B?RGZOQmF1SzVkaTV1bTdaczEra21wNzJ4cVhBYkdHVEI4RjFNQnJMNDNpODIr?=
 =?utf-8?B?NEk5Qnp0cUFCcDRDenROTlM5WmU0K09iUW9hTWZZOWdPVmpIRUtwU1hDVFFk?=
 =?utf-8?B?alExZjF5QzRIZTkwSllWdjZBc0p6bThtRHJTNXlVOTg0WndyZlEzRmtrU0tQ?=
 =?utf-8?B?TklSbkZCcmtBdjg2R3BYZzRmNUx3cWlraE9yMWUvZVRmSmdUOFQrS0hwVFl3?=
 =?utf-8?B?elBZWTFCZlZuL0JTcXM3VTRMaGF5VVVqcm9WZGRRZnJDZlBHYXlpZmlPRUJq?=
 =?utf-8?B?YXpsSVl4blpUV1dTM0Y3d0JwaVVReVorcmF4VWJtV0N2R3A2SzJoQTFWNCtj?=
 =?utf-8?B?aEhMU0VuN2FNODM0byt0TnNmVTZseERtUEhMbG5HSnhidmhoUURpcXV4Rk13?=
 =?utf-8?B?UjYxcnZheUhMTXJDalpzT2xETUwyYXByL3Q2ckRPdWJjMHpkdkpxNWx5eHJx?=
 =?utf-8?B?cVMrcmJyM0IrZkwyNHRzYXV2WWtZQ1NMSVZUdTdvck14dUxDbDR4N2NpcUhQ?=
 =?utf-8?B?SFMrMzdNS2drZWp1UFNsR2pDNmxNaWhiK2FpSmgrNjIra2h4eVU4dmZwLzZK?=
 =?utf-8?B?TnM2TUd1ckR1UFo5WW5LYTBJdFBJUFBIVkh6M1NZR3lva0UveFRXc0xVeEcw?=
 =?utf-8?B?L09YRktpWmhJS2hLZFlWaGlHNFdrUmlNenBuRlJsR0JZR29mUjBOUVBnYzZq?=
 =?utf-8?B?ZWpmY05Fc29jWXV1NHRnRnJNU2s0Yk1PejRIbDNZVVJBWG9tSDlaalpWSldW?=
 =?utf-8?B?WnJUVzR4bnZIT0FCaWlVWFZJeGRoNHRkeXU3NHRxYXd0SDFJODFvR1UxeHdz?=
 =?utf-8?B?VFNzVEZsbmxibHZQSHNnbXJBN3ZLUHYxWHFOK2QxSFJIc2NEMkxqaDkvaVg2?=
 =?utf-8?B?N0tvRURGb01RRElEZ3hJRnIwemtRd1pnRm1nQ0RGYnpWSVF2SWVtdFMyQkFM?=
 =?utf-8?B?eFlMUHBrR0JmcVArVWZXTkYxY3p2akhSMEhvZ1A1MTJRZzI3VGNBRVpScFFM?=
 =?utf-8?B?aTQzU21MKzdvYmEwSnhLb0RJZ0hLM1FrcUNjUUpoSVZ0Q0lpMnJKSy82NStK?=
 =?utf-8?B?bkYwbUtOTlV1OGxBS1VPZDN6TjBLeUUzS0ZTc29xY3EyempNU294aWZXMnMv?=
 =?utf-8?B?UjlyVFZ4Nzc3Y0M1d2k4TDVkZmJoQlRoKzZ2enRqZlFybHZ4aDVCUExZdzhs?=
 =?utf-8?B?bkFxUXVmWC9SZDVpYkdkdlNDeHhvRVY0bEdGY2tkNGlVckFnRW93Y2VRcVh4?=
 =?utf-8?B?T2RLcExMcG9RTXc4TlpQeGlYeFYrRldEd0I4U2ZBUGp5MHhHd3hqbU9QbE9J?=
 =?utf-8?B?MnBNajVTQ3l0UnpxYUF1SHRwclhwQkgzTWNVSGpRWnA0eFIwNENmY01UcTA1?=
 =?utf-8?B?TFVjYkZ5MG5BcG82bFEyOVpGQUF0RVBKbVR4T2ZsbGduejhXWDh5VTg5ei83?=
 =?utf-8?B?cDRsNVQ0eDhtUUk5ODllWG9UMXdyTkh1OXkxVmJuRFJvZzJzZ2ZZV2tDWUlr?=
 =?utf-8?B?SDRBTHJTUjBwRUZ1THY2S2Z4NSsrM2tacjRjWWRKYlZSVzJKQ2dkdmFDcmE5?=
 =?utf-8?B?RVJuUGRWdFlJOWM5a05PTnh0bUJVR096UlBIWkxrc1lZZkNyZlBnRmszYXZo?=
 =?utf-8?Q?HYNg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82458afe-c536-455d-841e-08dc0e27d5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 19:52:23.1268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z05eYU32BtmZb5P8DTUWzzFiFnOXRqGSMjT8oiEXaS1vQEmlvS1i92/gXBLehPL7XkrWyeBc5GYgeqMQR4GRhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5382
X-Proofpoint-GUID: fTyA4_o0ejuj2M0N6btN8Xzehkdwp2Oh
X-Proofpoint-ORIG-GUID: fTyA4_o0ejuj2M0N6btN8Xzehkdwp2Oh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050160

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXh3ZWxsIEJsYW5kIDxtYmxh
bmRAbW90b3JvbGEuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgNSwgMjAyNCAxMDo1OSBB
TQ0KPiBUbzogSmluLCBEaSA8ZGlfamluQGJyb3duLmVkdT47IEFsZXhlaSBTdGFyb3ZvaXRvdg0K
PiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4NCj4gQ2M6IGJwZkB2Z2VyLmtlcm5lbC5v
cmc7IHYuYXRsaWRha2lzQGdtYWlsLmNvbTsgdnBrQGNzLmJyb3duLmVkdTsgQW5kcmV3DQo+IFdo
ZWVsZXIgPGF3aGVlbGVyQG1vdG9yb2xhLmNvbT47IFNhbW15IEJTMiBRdWUgfCDpmJnmloznlJ8N
Cj4gPHF1ZWJzMkBtb3Rvcm9sYS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbRXh0ZXJuYWxdIEZ3ZDog
QlBGLU5YK0NGSSBpcyBhIGdvb2QgdXBzdHJlYW1pbmcgY2FuZGlkYXRlDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogSmluLCBEaSA8ZGlfamluQGJyb3duLmVk
dT4NCj4gPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA0LCAyMDI0IDg6MDIgUE0NCj4gPiBUbzog
QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPg0KPiA+IENj
OiBNYXh3ZWxsIEJsYW5kIDxtYmxhbmRAbW90b3JvbGEuY29tPjsgYnBmQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiB2LmF0bGlkYWtpc0BnbWFpbC5jb207IHZwa0Bjcy5icm93bi5lZHU7IEFuZHJldyBX
aGVlbGVyDQo+ID4gPGF3aGVlbGVyQG1vdG9yb2xhLmNvbT47IFNhbW15IEJTMiBRdWUgfCDpmJnm
loznlJ8NCj4gPiA8cXVlYnMyQG1vdG9yb2xhLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW0V4dGVy
bmFsXSBGd2Q6IEJQRi1OWCtDRkkgaXMgYSBnb29kIHVwc3RyZWFtaW5nDQo+ID4gY2FuZGlkYXRl
DQo+ID4NCj4gPiBEZWFyIEFsZXhlaSBhbmQgdGhlIHJlc3Qgb2YgdGhlIGNvbW11bml0eSwNCj4g
Pg0KPiA+IEkgZG8gd2FudCB0byBtYWtlIGEgbm90ZSBhYm91dCB0aGUgY29uY2VwdCBvZiB0aGUg
aW50ZXJwcmV0ZXIgYmVpbmcNCj4gPiAibGVzcyBzZWN1cmUiLg0KPiA+DQo+ID4gRmlyc3RseSB0
aGUgaW50ZXJwcmV0ZXIgaXMgbm90IGNvbnRyaWJ1dGluZyB0aGF0IG11Y2ggdG8gdGhlDQo+ID4g
ZXhwbG9pdGF0aW9uIG9mIFNwZWN0cmUuIFdoaWxlIEdvb2dsZSBQcm9qZWN0IFplcm8gZGlkIHNh
eSB3aXRob3V0IHRoZQ0KPiA+IGludGVycHJldGVyIGJ1aWxkaW5nIHRoZSBzcGVjaWZpYyBleHBs
b2l0IHRoZXkgaGFkIGZvciBTcGVjdHJlIFYyDQo+ID4gc2VlbXMgImFubm95aW5nIiwgdGhhdCBp
cyBhbGwgdGhlcmUgaXMgdG8gaXQsIHRoZSBzZWN1cml0eSBiZW5lZml0IG9mDQo+ID4gcmVtb3Zp
bmcgdGhlIGludGVycHJldGVyIGlzIG1vcmUgbGlrZSBhbiBhbm5veWFuY2UgaW5zdGVhZCBvZiBh
DQo+ID4gcm9hZGJsb2NrLiBJdCBpcyBxdWl0ZSBsaWtlbHkgdGhhdCBhdXRvbWF0ZWQgdG9vbHMg
Y2FuIGZpbmQgZ2FkZ2V0cw0KPiA+IHRoYXQgY2FuIGRvIHRoZSBqb2JzIHdpdGhvdXQgdG9vIG11
Y2ggdHJvdWJsZSwgdGhlIG9ubHkgYW5ub3lpbmcgYml0DQo+ID4gd291bGQgYmUgdGhlIGF0dGFj
a2VycyB3b3VsZCBoYXZlIHRvIGZpbmQgZGlmZmVyZW50IGdhZGdldHMgZm9yIGRpZmZlcmVudGx5
DQo+IGJ1aWx0IGtlcm5lbHMuDQo+ID4NCj4gPiBHcmFudGVkLCByZW1vdmluZyBhbnkgdW51c2Vk
IGZ1bmN0aW9uYWxpdHkgY2FuIGJlIGFuIGltcHJvdmVtZW50IGZvciBhDQo+ID4gc3lzdGVtJ3Mg
c2VjdXJpdHksIGFuZCB0aGUgb2JzZXJ2YXRpb24gdGhhdCB0aGUgaW50ZXJwcmV0ZXIgY2FuIGJl
DQo+ID4gcmVtb3ZlZCB3aXRob3V0IHRvbyBtdWNoIHBhaW4gd2FzIHF1aXRlIGludGVyZXN0aW5n
IHdoZW4gdGhlIG9wdGlvbg0KPiA+IHdhcyBpbnRyb2R1Y2VkLiBCdXQgaW4gdGhpcyBzcGVjaWZp
YyBjYXNlLCB0aGUgc2VjdXJpdHkgdHJhZGUtb2ZmIGhlcmUNCj4gPiBpcyBhIGJhbGFuY2luZyBh
Y3QgYmV0d2VlbiB0d28gZnVuY3Rpb25hbGl0aWVzOiBKSVRlZCBCUEYgYW5kIHRoZQ0KPiA+IGlu
dGVycHJldGVyLCBzaW5jZSByZW1vdmluZyBCUEYgYWx0b2dldGhlciBpcyBwcm9iYWJseSBub3Qg
YW4gb3B0aW9uDQo+ID4gaW4gcmVhbGlzdGljIHRlcm1zLiBUaGUgSklUZWQgQlBGIGhhcyBtb3Jl
IHRoYW4gY29udHJpYnV0ZWQgaXRzIGZhaXINCj4gPiBzaGFyZSBvZiBhc3Npc3RhbmNlIHRvIHZh
cmlvdXMgYXR0YWNrc1sxLTNdLCBpbmNsdWRpbmcgdGhlIG9yaWdpbmFsDQo+ID4gU3BlY3RyZSBh
dHRhY2tzWzRdLiBTbyBkaXNhYmxpbmcgSklUIGFuZCBrZWVwaW5nIHRoZSBpbnRlcnByZXRlciBp
bg0KPiA+IHBsYWNlIGlzLCBzZWN1cml0eS13aXNlLCBhbiBldmVuIGJldHRlciBtaXRpZ2F0aW9u
LCBpZiB3ZSBoYWQgdG8gcmVtb3ZlIG9uZQ0KPiBvZiB0aGUgdHdvIHBhdGhzLg0KPiA+DQo+ID4g
SSB3b3VsZCBhcmd1ZSB0aGF0IGtlZXBpbmcgdGhlIGludGVycHJldGVyLCBlc3BlY2lhbGx5IGhh
cmRlbmVkIHdpdGgNCj4gPiBkZWZlbnNlcyBwcm9wb3NlZCBpbiBFUEYsIGlzIGF0IHRoZSB2ZXJ5
IGxlYXN0IGEgY29tcGV0aXRpdmUgb3B0aW9uDQo+ID4gZm9yIHNlY3VyaXR5LiBJdCBlbmFibGVz
IHN5c3RlbSBhZG1pbnMgdG8gZGlzYWJsZSBKSVQgYXMNCj4gPiBtaXRpZ2F0aW9uL3ByZXZlbnRp
b24gYWdhaW5zdCBwb3RlbnRpYWwgcmlzayBmcm9tIHRoZSBKSVRlZCBjb21wb25lbnQNCj4gPiBv
ZiBCUEYgKHdoaWNoIGlzIG5vdyBpbXBvc3NpYmxlKSwgd2hpbGUgc3RpbGwgZW5qb3lpbmcgdGhl
IHNlY3VyaXR5DQo+IGVuaGFuY2VtZW50IHByb3ZpZGVkIGJ5IEVQRiBkZWZlbnNlcy4NCj4gPg0K
PiA+IElmIEkgY2FuIGhhdmUgeW91ciBibGVzc2luZyBvbiB0aGUgc2VjdXJpdHkgdHJhZGUtb2Zm
LCBJIGNhbiBtb3ZlDQo+ID4gZm9yd2FyZCB0byB0cnkgdG8gYWRhcHQgdGhlIHBhdGNoZXMgZm9y
IHN1Ym1pc3Npb24uDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IERpDQo+ID4NCj4gPiBbMV0gUmVz
aGV0b3ZhLCBFbGVuYSwgRmlsaXBwbyBCb25henppLCBhbmQgTi4gQXNva2FuLiAiUmFuZG9taXph
dGlvbg0KPiA+IGNhbuKAmXQgc3RvcCBCUEYgSklUIHNwcmF5LiIgSW4gTmV0d29yayBhbmQgU3lz
dGVtIFNlY3VyaXR5OiAxMXRoDQo+ID4gSW50ZXJuYXRpb25hbCBDb25mZXJlbmNlLCBOU1MgMjAx
NywgSGVsc2lua2ksIEZpbmxhbmQsIEF1Z3VzdCAyMeKAkzIzLA0KPiA+IDIwMTcsIFByb2NlZWRp
bmdzIDExLCBwcC4gMjMzLTI0Ny4gU3ByaW5nZXIgSW50ZXJuYXRpb25hbCBQdWJsaXNoaW5nLCAy
MDE3Lg0KPiA+IFsyXSBOZWxzb24sIEx1a2UsIEphY29iIFZhbiBHZWZmZW4sIEVtaW5hIFRvcmxh
aywgYW5kIFhpIFdhbmcuDQo+ID4gIlNwZWNpZmljYXRpb24gYW5kIHZlcmlmaWNhdGlvbiBpbiB0
aGUgZmllbGQ6IEFwcGx5aW5nIGZvcm1hbCBtZXRob2RzDQo+ID4gdG8ge0JQRn0ganVzdC1pbi10
aW1lIGNvbXBpbGVycyBpbiB0aGUgTGludXgga2VybmVsLiIgSW4gMTR0aCBVU0VOSVgNCj4gPiBT
eW1wb3NpdW0gb24gT3BlcmF0aW5nIFN5c3RlbXMgRGVzaWduIGFuZCBJbXBsZW1lbnRhdGlvbiAo
T1NESSAyMCksDQo+IHBwLiA0MS02MS4gMjAyMC4NCj4gPiBbM10gS2lyem5lciwgT2ZlaywgYW5k
IEFkYW0gTW9ycmlzb24uICJBbiBhbmFseXNpcyBvZiBzcGVjdWxhdGl2ZSB0eXBlDQo+ID4gY29u
ZnVzaW9uIHZ1bG5lcmFiaWxpdGllcyBpbiB0aGUgd2lsZC4iIEluIDMwdGggVVNFTklYIFNlY3Vy
aXR5DQo+ID4gU3ltcG9zaXVtIChVU0VOSVggU2VjdXJpdHkgMjEpLCBwcC4gMjM5OS0yNDE2LiAy
MDIxLg0KPiA+IFs0XSBLb2NoZXIsIFBhdWwsIEphbm4gSG9ybiwgQW5kZXJzIEZvZ2gsIERhbmll
bCBHZW5raW4sIERhbmllbCBHcnVzcywNCj4gPiBXZXJuZXIgSGFhcywgTWlrZSBIYW1idXJnIGV0
IGFsLiAiU3BlY3RyZSBhdHRhY2tzOiBFeHBsb2l0aW5nDQo+ID4gc3BlY3VsYXRpdmUgZXhlY3V0
aW9uLiIgQ29tbXVuaWNhdGlvbnMgb2YgdGhlIEFDTSA2Mywgbm8uIDcgKDIwMjApOg0KPiA+IDkz
LTEwMS4NCj4gDQo+IEEgY3JpdGljYWwgc3VidGV4dCBpcyB0aGF0IG1hbnkvbW9zdCBzZWN1cml0
eS1jb25zY2lvdXMgYnVpbGRzIChHb29nbGUncw0KPiBBbmRyb2lkIEdLSSwgaWlyYykgaGF2ZSBK
SVQgYWx3YXlzIGVuYWJsZWQuDQo+IA0KPiBBZnRlciBJIG1hZGUgdGhhdCB0eXBvIHRoYXQgc3dp
dGNoZWQgdXAgZW5hYmxlZC9kaXNhYmxlZCBpbiB0aGUgY2hhaW4NCj4geWVzdGVyZGF5LCBBbGV4
ZWkgdGhhbmtmdWxseSBub3RlZCAidGhlIHByZXNlbmNlIG9mIF9hbnlfIGludGVycHJldGVyIGlu
IHRoZQ0KPiBrZXJuZWwgdGV4dCBpcyBhIHByb2JsZW0gcmVnYXJkbGVzcyBvZiB3aGV0aGVyIEpJ
VC1pbmcgaXMgZW5hYmxlZCBvciBub3QiLiBKSVQNCj4gaGF2aW5nIHByb2JsZW1zIGRvZXNuJ3Qg
aW1wbHkgdGhhdCBhbiBpbnRlcnByZXRlciB3aWxsIG5vdCBoYXZlIGlzc3VlcyBvZiBpdHMNCj4g
b3duLiBJbnRlcnByZXRlcnMgYnVncyBjYW4gbGVhZCB0byBtb3JlIHNlY3VyaXR5IHByb2JsZW1z
IHJhdGhlciB0aGFuIGZld2VyLA0KPiBTcGVjdHJlIG9yIG90aGVyd2lzZSwgcmVzdWx0aW5nIGlu
IHRoZSBuZWNlc3NpdHkgb2YgYSBjcml0aWNhbCBnZW5lcmFsDQo+IGNvbW1pdG1lbnQgdG8gbWFp
bnRhaW5pbmcgYW5kIHZldHRpbmcgdGhlIGludGVycHJldGVyIHdpdGhpbiB0aGUga2VybmVsLg0K
PiBNYWpvciBwbGF5ZXJzIGxpa2UgSW50ZWwgYW5kIEdvb2dsZSBzZWVtIHRvIGhhdmUgdW5vZmZp
Y2lhbGx5IGNvbW1pdHRlZCB0byBKSVQNCj4gbWFpbnRlbmFuY2UgYW5kIHNlY3VyaXR5IGluc3Rl
YWQuIFRoZXJlIGFyZSBzb21lIGdvb2QgYXJndW1lbnRzIGZvciB0aGlzDQo+IG9uIHRoZSBub24t
c2VjdXJpdHkgc2lkZS4NCj4gDQo+IFdpdGggdGhlIGluY2x1c2lvbiBvZiBQZXRlcidzIENGSSBw
YXRjaGVzIGFuZCB0aGUgYWRhcHRpb24gb2YgdGhlc2UgdG8gQVJNLA0KPiB0aGVyZSdzIGFscmVh
ZHkgc3Ryb25nIHByb2dyZXNzIHRvd2FyZHMgc2VjdXJpdHkgZm9yIEJQRidzIEpJVC4gSWYgdGhl
IG1peGluZw0KPiBleGVjdXRhYmxlIGNvZGUgd2l0aCBkYXRhIGlzc3VlIGdldHMgZml4ZWQgdG9v
LCB0aGVuIGl0IHdpbGwgc29vbiBiZWNvbWUNCj4gcG9zc2libGUgdG8gdHJlYXQgQlBGIEpJVCBw
cm9ncmFtcyBsaWtlIGFueSBvdGhlciBwYXJ0IG9mIHRoZSAudGV4dCBzZWN0aW9uLA0KPiB3aGlj
aCBzZWVtcyBsaWtlIGEgaHVnZSB3aW4sIHNpbmNlIEJQRiB0aGVuIGdldHMgYWxsIG9yIG1hbnkg
b2YgdGhlIGZydWl0cyBvZg0KPiBzdGFuZGFyZCAudGV4dCBzZWN0aW9uIHNlY3VyaXR5Lg0KPiAN
Cj4gUmVnYXJkcywNCj4gTWF4d2VsbCBCbGFuZA0KDQpGb3JnZXQgdGhhdCBsYXN0IHBvaW50ICJt
aXhpbmcgZXhlY3V0YWJsZSBjb2RlLi4uIiAoaW4gQVJNKS4NCg0KSW4gdjYuNC1yYzMgTWFyayBS
dXRsYW5kIGZpeGVkIHRoZSBpc3N1ZTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJt
LWtlcm5lbC8yMDIzMDUzMDExMDMyOC4yMjEzNzYyLTEtbWFyay5ydXRsYW5kQGFybS5jb20vDQoN
CkkuZSB0aGUgQlBGIGNvZGUgaW4gdm1hbGxvYyByYW5nZSBpc3N1ZSBpcyBvbmx5IGluIEFuZHJv
aWQuIFdpbGwgYnJpbmcgdXAgQlBGLU5YIHRvIEdvb2dsZS4gTG9va2luZyBmb3J3YXJkIHRvIFBl
dGVyJ3MgQ0ZJIHBhdGNoZXMhDQoNClRoYW5rcywNCk1heHdlbGwgQmxhbmQNCg==


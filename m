Return-Path: <bpf+bounces-6567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13B476B7CB
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CBA281097
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52BF3DE29;
	Tue,  1 Aug 2023 14:33:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A083DE20
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:33:27 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::608])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED8E5C
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfbQnLiZnAUK3+AvBlY/o4QroLVC9kNaLAED5iNJ7jDaTTMddCvlwGQ+VTZUMtx5HljUnEkxZu1J5ilsSSuUDnF8HK+eh/CBVxRevt/2sOrM5YkiyohT0UrpMNkIylSFAxMy9aLCqgYv7V8QG7N2RJSM+8GEq061Y2CG/b12CxJVzRQcSsEtq4b9Xm8NwceWEtAw3SA9ZzIW3GUeTeraDOICowlNmdTL23IPrSPW9n5ZmW0w0LtduQG+By6KKG13rQ1EKYNN7h5jAfwaXQ6nUl8cpM8d+9kLmm47zGxuL2QS0ndVt+XFw7Vm8HquPCVcLKkWevMHYFCvzkceaoi9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NID+b1vdmF+sDhFmt/RKVqH4jiRouBYmRG362v+T26U=;
 b=VI7LsgsfKSgU03bgdaXOfRzfBBCxuHzUOFG/5/JACVZtQMJopErjXrLmGxEEfSSSQ0E47rdss6kt95NEniuS2MD9EsyVtnwDxRoH4ZSBopHP010rCatcqN2Hn5/jzsfOitV75npnihNFBwyucdN+iSyE76/LVX7OPYkCxp0xP/O1SYBFn0Z/Z2drGeRJ+y0uHt3V7hUwdVY+46GcBaA9ebtDwFz1haWMb95kitkJUj/svSYIRjAoZ9aTvJAmxe/14uxywpFWS+oCOe70PmojXWApB2EQXPfREtX1l17JsUDDzoN/VRqQVU3ldO0cd0yT5HqQDGui321flKsQND8jHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gdata.de; dmarc=pass action=none header.from=gdata.de;
 dkim=pass header.d=gdata.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=GDataSoftwareAG.onmicrosoft.com;
 s=selector2-GDataSoftwareAG-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NID+b1vdmF+sDhFmt/RKVqH4jiRouBYmRG362v+T26U=;
 b=cy6r243Nir8y26DzLmA0GfD/OZdB5OWz7Q79+uYl9ksiTKIEQ20OoYBh7P2TP2Uh5zWiPb8Wz+X4vqeAqkSRQnpU9MCaphOTBO7eihgIM9Fr8u6H2VerKBUGQQNW8meJ3mbb8sy5a1rVtCmBHoC2Qhk6QYAn/W2Vrct5xDRAQx4=
Received: from AS8PR03MB9626.eurprd03.prod.outlook.com (2603:10a6:20b:5ee::7)
 by AS4PR03MB8553.eurprd03.prod.outlook.com (2603:10a6:20b:580::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:33:20 +0000
Received: from AS8PR03MB9626.eurprd03.prod.outlook.com
 ([fe80::f76d:c42c:27b2:e75c]) by AS8PR03MB9626.eurprd03.prod.outlook.com
 ([fe80::f76d:c42c:27b2:e75c%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:33:20 +0000
From: =?utf-8?B?RnLDtmhsaW5nLCBNYXhpbWlsaWFu?= <Maximilian.Froehling@gdata.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Bagas Sanjaya
	<bagasdotme@gmail.com>
CC: Linux BPF <bpf@vger.kernel.org>
Subject: RE: bpf: bpf_probe_read_user_str() returns 0 for empty strings
Thread-Topic: bpf: bpf_probe_read_user_str() returns 0 for empty strings
Thread-Index: AQHZvQhvHQ03FgRWHEyZl1tV/PFVUq/GmWeAgA701lA=
Date: Tue, 1 Aug 2023 14:33:20 +0000
Message-ID:
 <AS8PR03MB9626904F00B4C8B0C679FE6AE50AA@AS8PR03MB9626.eurprd03.prod.outlook.com>
References: <bba66a5f-3605-e36b-2bf3-f25a48307a46@gmail.com>
 <CAADnVQKJ+SzCEaXxpSKemJo8p0bCOGcoOv1NDsJMsTsMmJmiZQ@mail.gmail.com>
In-Reply-To:
 <CAADnVQKJ+SzCEaXxpSKemJo8p0bCOGcoOv1NDsJMsTsMmJmiZQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gdata.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB9626:EE_|AS4PR03MB8553:EE_
x-ms-office365-filtering-correlation-id: 606691cd-5f88-4247-d7b7-08db929c40de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0zQhrIuTwlcvGog5MXw2MYftfmnAPtfCxeV1nzRGdNUMv2LtHUIl83HBklvhi24ZzmlXkrrVCFoM1v2Mw6S2+S98azPAj26zpy1LW5oOpoBoiASUxT58SvVF3FiwXnt+7v2K1i8qrKMAI1G0rsrnNNpV/3vhLeOhjslrHwp5/USxg2V9COMStFryRErHisjx6nmUbVEqr/pIToq1e5uhsXb9P/4v5mdNsJxO3sFChnFpQO4Sw7MI0Q8tJ0/cDPPrgwqhtptLNV5EBDa4Ke+Wr+qh5wwZgPA6eTwFy1R3++7Ygk2pipMl8XUZLp6AfUZGT02u4U6lUfDMV5Z7my9GkunEJpFXhVIZpiSqI7yrBl1FJ9obqPZD7OJSql5kBHprfc0l+zBx7jjchYjihZK/X0FJLsAHaY2efum4mcIrI5D8pZQyLEbObIPCeSn0fr3ncD3rVY2P0wK0CV5rjT1giO2d1Vc0d9RJnW/KOemY0Iems4+Wi4EmkCOC0Vs8C4Yz+HYYqsqapg1Uv9xx0/T6NA4wX6IjcNjiNc7er9/VQCkOJK4D042ro2ScABkngR7aestO/5vXviUc/DOZLFb4H5iNPEJorDf8m6hd/UCIlHEohb+4l8UZA50iqwKtTIfZQ6rjiyRYYRkw3S5XbW5GQD5SpQre755It3xXYUKyBVc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9626.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39850400004)(366004)(396003)(376002)(451199021)(1590799018)(41300700001)(5660300002)(76116006)(66946007)(8676002)(8936002)(55016003)(52536014)(110136005)(64756008)(1580799015)(478600001)(316002)(66476007)(2906002)(66556008)(66446008)(4326008)(7696005)(9686003)(966005)(71200400001)(38100700002)(53546011)(6506007)(186003)(85202003)(83380400001)(85182001)(33656002)(38070700005)(122000001)(66574015)(86362001)(554374003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0RPRklEYXJsaGRzOHlXYjVOa2wrd1V1aVVBT0ZxSEFSWEdKSFhyMGI1UXMv?=
 =?utf-8?B?UWlzNVJCWW53MVBjTjRLQVh5R3hqRnE0UDhQVVBvV3hhNUs1VFZnV09RNWlp?=
 =?utf-8?B?RW5yUXJYejU0UmlqTk5OZEx2QzJ1S2hRdSsxb2VQRSs5ZjJwM0Q2dVkyaHFZ?=
 =?utf-8?B?R0dBenRSZXRPVDN4cXoraTJub1o2U0lQWEtqRldpZG90emU4RGF5a2Rtem0y?=
 =?utf-8?B?WExLN0lCRlRrQTE1bG5VaTM0ck9tdnNjK2dlL05LcU05TmpFWllNYUk0cjRE?=
 =?utf-8?B?OWtLd3IzRVNwM2Y1ekxMWU9iOEZISlpRdzBlTFhoRS9paFovMWZrTzhWdXda?=
 =?utf-8?B?Um50MU5rM0ZUTlpaZHRNSjlsOU1xcitPSFJMVVdUcnVIbzhpSUhpVWpZOXpL?=
 =?utf-8?B?SnNrRkNwUjA0N2tNdWpnVWhuMys3Z3pvcjJLOVFkSWo3N3p3b0ZIRzZkRHRT?=
 =?utf-8?B?blc2WFVmcjlhbnZFc3VKOWx3bUo2aFdISHNiVEhtYUpROTZzY1cwNWcwUE9x?=
 =?utf-8?B?REw2aDJOUHF0Sklacnlhc1BEbEZzbVJydzRiRDQySlV1Z2NlSVF3S2Nmd1cw?=
 =?utf-8?B?bXFhMXpTd0x3WlBaTmZ5RjJXYlAvUGFGTXdLREYybS9vckcyQlRSWHpLOWVM?=
 =?utf-8?B?Mnc4dE1mNGtlZWt5R2pweWVSbXhCOEtnbHJHcTU1NHMveUt0Skw2YW5Ob0p2?=
 =?utf-8?B?dFpZcjk1dEd0K09XWlBrb011L0tGbS9JTzRnbW1jVzFYU1UrUFFib3QwTEJk?=
 =?utf-8?B?Um42R0ptL04yTlZNMVIwbExhSVVjZFN3a1pYdW1zV1N6Y21yQnVXMCtiK04y?=
 =?utf-8?B?Zk00R2dyUmt0N0FMZTdOdDgzZlFCRFlrOTBnU2l5VEJITndRT0Mva2YwNzBS?=
 =?utf-8?B?cXQ1SDdueWY5bElMVFYrZWhYd0ZzMHh4eDI5OHNUN3NJMW5Vck1ld3dRNzJ4?=
 =?utf-8?B?ZlVtNENLQkhwMENnRmtIVEgvMDJEWEhZejBVWUZubmw4UzM4MVNISE9vNktE?=
 =?utf-8?B?M0hyamxaeUJ4YXdDQzRXdEhQa0QvTEdyL29LRDBxMFNLM0pTZTBqM2VNc0E0?=
 =?utf-8?B?YWRZWUFsdmhEQWlKLzhkM2lZWlkrMHBML2FaZXJUOXo4Q2NCeWxjckdaU2xX?=
 =?utf-8?B?WGFHR3JOYlgwK0Znb29UdTFaVU5XL3N6YXIvd01GaVpKS09wQTRYdlJtcFlo?=
 =?utf-8?B?c3NuVTIrZDduM0F2RnJFMnYxVDlTUGJwQ3pDai9EMVE0TWNlSWZ1d0kxUkRN?=
 =?utf-8?B?VC8yeUdYcDFhZ2kza0NUSVNxcVBVT09GQXFuSjhZQmlhMDczQnpGRGEzbDBk?=
 =?utf-8?B?enZIbHk5Yk9kZ0p0Z2FRdFgrSmNXYzQ2VVhxMVRPYWxrYTc1NHVScDY4TXJX?=
 =?utf-8?B?cDhlVG00T2tFejRGdHVSN1I3L1I2ekszcVFDNm1jc3VBbVFvVnFFSUhRNFdp?=
 =?utf-8?B?S2RPMDdTVU1weC9TeXVXdVdjUjNXMm4wRVpEeXpoOVJ3b1ptd2FWOFZ0aGlN?=
 =?utf-8?B?N1R4eWhadDRpdHBmNE5mSlNxVXMrUlhrVzladkdBWTQ4WmhtdGZJb0dnVVpl?=
 =?utf-8?B?YWpESTl1Z08wb3ZIbmY4MUs5TkhBQm1JNDVsM0R0MjN6b05KZkIzNFJjTDg1?=
 =?utf-8?B?U3dRUnZ2ckU3SWdYb3BhbDZPVEpKc0MvSVU4ZEpIWDZseGEwR1JKRk1ZVTdB?=
 =?utf-8?B?azlIMGhIS2M2ekhtdU5jQ3J3WGh3WTFWd1JBQ01SV2JzUE9lYjFRSTRvamFj?=
 =?utf-8?B?QlVxc0JJMVYvSkprRHBNSFozSEZOMjl2aUxnY0cyTy96ZWNIMjhiTWdHZTFh?=
 =?utf-8?B?dWdIVEZQd0pDVVo2bDd1cGNqSjNrYWh2Wis0cDRqeGJURTFRaURoWjhVRFcr?=
 =?utf-8?B?WkRqNThuK2haSEZiSGZuRnNCdk01ZVMvcXdrZTJDRnZ2a29kRzY1MXBWUHJ0?=
 =?utf-8?B?M1ZobzVQS0UzUXRFUTVPQXJvWDdBRVdpTUo0dHgybi82QzBHUjB0QmdpMjV0?=
 =?utf-8?B?NjNHS1phMW4rZlBYMUw4QzJPY2hVVWFETEJSakxvQUFQSk1UM2tyMkw3TTFW?=
 =?utf-8?B?bHdET3BRM00vWUhjdGlxM05RR3NlT2FIbGRvU2VaU0ZWUU1kSzN4N2IvbU5G?=
 =?utf-8?B?Vkg1U3VPSk41N0lic3BlVmhXRmx5OE1zMk80VjZORXpteW9VUURoUjRrbzVk?=
 =?utf-8?B?a3VDNmlUaHJSZlBVNnIxMXFTUGZBMFBJZGk2R2NEZkI4NlpDYlNuSGlRYjNC?=
 =?utf-8?B?VW0zNFA2d0RYWTkxVms2S25TeDVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gdata.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9626.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606691cd-5f88-4247-d7b7-08db929c40de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 14:33:20.3936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 17a28b0e-dea1-4ab6-82fd-ccf73c7d198e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sH9AOWGX99/q0m9aGgxdksRFyS6tdl0iueb2T50S3CAYEahw5YgMbsiQN/MzdEjWdTXlNnMhLoeZGYcijDfgNQOtayFkOMBJ3a6NuWtHm04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8553
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGksDQoNCkknbSB0aGUgYXV0aG9yIG9mIHRoYXQgYnVnIHJlcG9ydC4gSSBiZWxpZXZlIHlvdSBh
cmUgbWlzdGFrZW46IEkgZG8gbm90IHRoaW5rIHRoYXQgdGhpcyBpcyBhIGRvY3VtZW50YXRpb24g
aXNzdWUuIEkgc3Ryb25nbHkgYmVsaWV2ZSB0aGF0IHRoZSBkb2N1bWVudGF0aW9uIGlzIGNvcnJl
Y3QgYW5kIHRoZSBmdW5jdGlvbiBiZWhhdmlvciBpdHNlbGYgaXMgd3JvbmcuDQoNCmJwZl9wcm9i
ZV9yZWFkX2tlcm5lbF9zdHIoKSBiZWhhdmVzIGxpa2UgaXQgc2hvdWxkIChhcyBkb2N1bWVudGVk
KS4NCmJwZl9wcm9iZV9yZWFkX3VzZXJfc3RyKCkgaGFzIHRoZSBzYW1lIGRvY3VtZW50YXRpb24g
YXMgdGhlIGFib3ZlIChzbyBzaG91bGQgaGF2ZSB0aGUgc2FtZSBiZWhhdmlvciksIHlldCBpdCBi
ZWhhdmVzIGRpZmZlcmVudGx5LiBJIHNlZSBubyByZWFzb24gd2h5IHRoZXNlIHR3byBmdW5jdGlv
bnMgc2hvdWxkIHJldHVybiBkaWZmZXJlbnQgKG5vbi1lcnJvcikgdmFsdWVzIGZvciB0aGUgc2Ft
ZSBzdHJpbmcuDQoNCkkgY2FuIHRyeSB0byBwcmVwYXJlIGEgY29kZSBwYXRjaCBmb3IgdGhpcyBp
c3N1ZSwgYnV0IEkgaGF2ZW4ndCBkb25lIHRoaXMgcHJldmlvdXNseSBzbyB0aGlzIGlzIGFsbCBh
IGJpdCBuZXcgdG8gbWUuDQoNCktpbmQgcmVnYXJkcywNCk1heA0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogQWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZA
Z21haWwuY29tPiANClNlbnQ6IFN1bmRheSwgSnVseSAyMywgMjAyMyA0OjAyIEFNDQpUbzogQmFn
YXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+DQpDYzogSW5nbyBNb2xuYXIgPG1pbmdv
QGtlcm5lbC5vcmc+OyBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPjsgU3Rl
dmVuIFJvc3RlZHQgKEdvb2dsZSkgPHJvc3RlZHRAZ29vZG1pcy5vcmc+OyBGcsO2aGxpbmcsIE1h
eGltaWxpYW4gPE1heGltaWxpYW4uRnJvZWhsaW5nQGdkYXRhLmRlPjsgTGludXggS2VybmVsIE1h
aWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4IEJQRiA8YnBm
QHZnZXIua2VybmVsLm9yZz47IExpbnV4IE1lbW9yeSBNYW5hZ2VtZW50IExpc3QgPGxpbnV4LW1t
QGt2YWNrLm9yZz4NClN1YmplY3Q6IFJlOiBicGY6IGJwZl9wcm9iZV9yZWFkX3VzZXJfc3RyKCkg
cmV0dXJucyAwIGZvciBlbXB0eSBzdHJpbmdzDQoNCk9uIFNhdCwgSnVsIDIyLCAyMDIzIGF0IDY6
NTPigK9QTSBCYWdhcyBTYW5qYXlhIDxiYWdhc2RvdG1lQGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+
IEhpLA0KPg0KPiBJIG5vdGljZSBhIGJ1ZyByZXBvcnQgb24gQnVnemlsbGEgWzFdLiBRdW90aW5n
IGZyb20gaXQ6DQo+DQo+ID4gT3ZlcnZpZXc6DQo+ID4NCj4gPiBGcm9tIHdpdGhpbiBlQlBGLCBj
YWxsaW5nIHRoZSBoZWxwZXIgZnVuY3Rpb24gYnBmX3Byb2JlX3JlYWRfdXNlcl9zdHIodm9pZCAq
ZHN0LCBfX3UzMiBzaXplLCBjb25zdCB2b2lkICp1bnNhZmVfcHRyIHJldHVybnMgMCB3aGVuIHRo
ZSBzb3VyY2Ugc3RyaW5nICh2b2lkICp1bnNhZmVfcHRyKSBjb25zaXN0cyBvZiBhIHN0cmluZyBj
b250YWluaW5nIG9ubHkgYSBzaW5nbGUgbnVsbC1ieXRlLg0KPiA+DQo+ID4gVGhpcyB2aW9sYXRl
cyB2YXJpb3VzIGZ1bmN0aW9ucyBkb2N1bWVudGF0aW9ucyAodGhlIGhlbHBlciBhbmQgdmFyaW91
cyBpbnRlcm5hbCBrZXJuZWwgZnVuY3Rpb25zKSwgd2hpY2ggYWxsIHN0YXRlOg0KDQpTb3VuZHMg
bGlrZSB0aGUgYnVnemlsbGEgYXV0aG9yIGJlbGlldmVzIGl0J3MgYSBkb2N1bWVudGF0aW9uIGlz
c3VlLg0KSWYgc28sIHBsZWFzZSBlbmNvdXJhZ2UgdGhlIGF1dGhvciB0byBzZW5kIHRoZSBwYXRj
aCB0byBmaXggdGhlIGRvYy4NCg0KPiA+DQo+ID4+IE9uIHN1Y2Nlc3MsIHRoZSBzdHJpY3RseSBw
b3NpdGl2ZSBsZW5ndGggb2YgdGhlIG91dHB1dCBzdHJpbmcsIA0KPiA+PiBpbmNsdWRpbmcgdGhl
IHRyYWlsaW5nIE5VTCBjaGFyYWN0ZXIuIE9uIGVycm9yLCBhIG5lZ2F0aXZlIHZhbHVlLg0KPiA+
DQo+ID4gVG8gbWUsIHRoaXMgc3RhdGVzIHRoYXQgdGhlIGZ1bmN0aW9uIHNob3VsZCByZXR1cm4g
MSBmb3IgY2hhciBteVN0cmluZ1tdID0gIiI7IEhvd2V2ZXIsIHRoaXMgaXMgbm90IHRoZSBjYXNl
LiBUaGUgZnVuY3Rpb24gcmV0dXJucyAwIGluc3RlYWQuDQo+ID4NCj4gPiBGb3Igbm9uLWVtcHR5
IHN0cmluZ3MsIGl0IHdvcmtzIGFzIGV4cGVjdGVkLiBGb3IgZXhhbXBsZSwgY2hhciBteVN0cmlu
Z1tdID0gImFiYyI7IHJldHVybnMgNC4NCj4gPg0KPiA+IFN0ZXBzIHRvIFJlcHJvZHVjZToNCj4g
PiAqIFdyaXRlIGFuIGVCUEYgcHJvZ3JhbSB0aGF0IGNhbGxzIGJwZl9wcm9iZV9yZWFkX3VzZXJf
c3RyKCksIHVzaW5nIGEgdXNlcnNwYWNlIHBvaW50ZXIgcG9pbnRpbmcgdG8gYW4gZW1wdHkgc3Ry
aW5nLg0KPiA+ICogU3RvcmUgdGhlIHJlc3VsdCB2YWx1ZSBvZiB0aGF0IGZ1bmN0aW9uDQo+ID4g
KiBEbyB0aGUgc2FtZSB0aGluZywgYnV0IHRyeSBvdXQgYnBmX3Byb2JlX3JlYWRfa2VybmVsX3N0
cigpLCBsaWtlIHRoaXM6DQo+ID4gY2hhciBlbXB0eVtdID0gIiI7DQo+ID4gY2hhciBjb3B5WzVd
Ow0KPiA+IGxvbmcgcmV0ID0gYnBmX3Byb2JlX3JlYWRfa2VybmVsX3N0cihjb3B5LCA1LCBlbXB0
eSk7DQo+ID4gKiBDb21wYXJlIHRoZSByZXR1cm4gdmFsdWUgb2YgYnBmX3Byb2JlX3JlYWRfdXNl
cl9zdHIoKSBhbmQgDQo+ID4gYnBmX3Byb2JlX3JlYWRfa2VybmVsX3N0cigpDQo+ID4NCj4gPiBF
eHBlY3RlZCBSZXN1bHQ6DQo+ID4NCj4gPiBCb3RoIGZ1bmN0aW9ucyByZXR1cm4gMSAoYmVjYXVz
ZSBvZiB0aGUgc2luZ2xlIE5VTEwgYnl0ZSkuDQo+ID4NCj4gPiBBY3R1YWwgUmVzdWx0Og0KPiA+
DQo+ID4gYnBmX3Byb2JlX3JlYWRfdXNlcl9zdHIoKSByZXR1cm5zIDAsIHdoaWxlIGJwZl9wcm9i
ZV9yZWFkX2tlcm5lbF9zdHIoKSByZXR1cm5zIDEuDQo+ID4NCj4gPiBBZGRpdGlvbmFsIEluZm9y
bWF0aW9uOg0KPiA+DQo+ID4gSSBiZWxpZXZlIEkgY2FuIHNlZSB0aGUgYnVnIG9uIHRoZSBjdXJy
ZW50IExpbnV4IGtlcm5lbCBtYXN0ZXIgYnJhbmNoLg0KPiA+DQo+ID4gSW4gdGhlIGZpbGUvZnVu
Y3Rpb24gbW0vbWFjY2Vzcy5jOjpzdHJuY3B5X2Zyb21fdXNlcl9ub2ZhdWx0KCkgdGhlIGhlbHBl
ciBpbXBsZW1lbnRhdGlvbiBjYWxscyBzdHJuY3B5X2Zyb21fdXNlcigpLCB3aGljaCByZXR1cm5z
IHRoZSBsZW5ndGggd2l0aG91dCB0cmFpbGluZyAwLiBIZW5jZSB0aGlzIGZ1bmN0aW9uIHJldHVy
bnMgMCBmb3IgYW4gZW1wdHkgc3RyaW5nLg0KPiA+DQo+ID4gSG93ZXZlciwgaW4gbGluZSAxOTIg
KGFzIG9mIGNvbW1pdCBmZGYwZWFmMTE0NTJkNzI5NDVhZjMxODA0ZTJhMTA0OGVlMWI1NzRjKSB0
aGVyZSBpcyBhIGNoZWNrIHRoYXQgb25seSBpbmNyZW1lbnRzIHJldCwgaWYgaXQgaXMgPiAwLiBU
aGlzIGFwcGVhcnMgdG8gYmUgdGhlIGxvZ2ljIHRoYXQgYWRkcyB0aGUgdHJhaWxpbmcgbnVsbCBi
eXRlLiBTaW5jZSB0aGUgY2hlY2sgb25seSBkb2VzIHRoaXMgZm9yIGEgcmV0ID4gMCwgYSByZXQg
b2YgMCByZW1haW5zIGF0IDAuDQo+ID4NCj4gPiBUaGlzIGlzIGEgcG9zc2libGUgb2ZmLWJ5LW9u
ZSBlcnJvciB0aGF0IG1pZ2h0IGNhdXNlIHRoZSBiZWhhdmlvci4NCj4NCj4gU2VlIEJ1Z3ppbGxh
IGZvciB0aGUgZnVsbCB0aHJlYWQuDQo+DQo+IEZZSSwgdGhlIGN1bHByaXQgbGluZSBpcyBpbnRy
b2R1Y2VkIGJ5IGNvbW1pdCAzZDcwODE4MjJmN2Y5ZSANCj4gKCJ1YWNjZXNzOiBBZGQgbm9uLXBh
Z2VmYXVsdCB1c2VyLXNwYWNlIHJlYWQgZnVuY3Rpb25zIikuIEkgQ2M6IA0KPiBjdWxwcml0IFNv
QiBzbyB0aGF0IHRoZXkgY2FuIGxvb2sgaW50byB0aGlzIGJ1Zy4NCj4NCj4gVGhhbmtzLg0KPg0K
PiBbMV06IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3Njc5
DQo+DQo+IC0tDQo+IEFuIG9sZCBtYW4gZG9sbC4uLiBqdXN0IHdoYXQgSSBhbHdheXMgd2FudGVk
ISAtIENsYXJhDQo+DQo=


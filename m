Return-Path: <bpf+bounces-5099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A134756751
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8BD2812F1
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4E2AD26;
	Mon, 17 Jul 2023 15:15:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3A253BB;
	Mon, 17 Jul 2023 15:15:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0DE10EB;
	Mon, 17 Jul 2023 08:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE3Ji0YY5L+nvdl5YhWofPHUidDv6/JdlJcnXOP6znSN9Eip47qn48abadtOcQ6d1C43SZFZuKfgfgE82zeKNUpn8CBz4hp21Na9J9bbLYR4g5ThhgFBNg/qc0V9ak3Ma4HDIh+wGp2kudHJR0y1bIMCPMv2iyo3lyxc4h6akjY9xlygU6n0oKL1uc9DtI5QtXxb9evRF/aTBWKOssHJZnu2qFZxHAzIyQ2VDaywZqxCFzxz2Y0EeZiX44e/hBUiEzOCTjiSvki4nKs/kE4/2XuvTTSzKf6EtiGM4IRvYPXFSVriOMxU+zfvl9T0uQHdngjyrMD3mfZT5wgyPJHGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8JaixuHez+RTHh0urYG2cCx3W242Ve63iwkdfU1jc8=;
 b=bfbLwaSZNM8WbQmEboryNan3/bJkNHcTgYt52k+ONd01w0vFRQHG+ct4N7wSSTY9Yrn1tZpq55e7BFpuFcXrHaR780NiIQTrEONVV6tW/PtuAln9M4VbJisCka4DE45TJy43OniiD9C3nazY/z5X4XVMADXMhl1tB7Etu+nrqu1Bcwz3cSGF8/h3cEfEzjcHxpJHMWenuTuhTYfTiHzQXN2PN9BIRIqtG7fHSnkIrqVpweMOU2PDuIQaPTxBYUIM0cMzlLX7f+G6quIzID1KP+REjjY1P1b/0QMNvyX4Y6N3EVT+M277A34qFLpLu4ymntBQYCuZDKQXc1JRnto8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8JaixuHez+RTHh0urYG2cCx3W242Ve63iwkdfU1jc8=;
 b=hUn1Ej2xZylgGLsmTzR3OOajNMwHfh57u14E1TCrbKmYQZNB9dJDf+gFxEjbFaQAzmLrUzRFeqhJONytJazLAWRFn2YUNDsAJDEY/+rFH1eFjoGolIT+mRtxnTfyjsdSwjyLS+PvhgRSQ0/GxHsfqnmRZ6cj98BTLAzRWeXNBffgYHQzBt9Mn3pcCKH7ZPio+PyCymw0Sc4BsvF3oB3YdO2MTtRo2s2C8YsSUkaZSb2TS+GOc+2qO07GHp5Z7u0NGu2gfgg5K0RHBe9rjFGiN/5TKwhwEbqLEwgev+Wk1sQZuO6RGmiX01xYAjqvNlBoWLCqXlscSKowA7BZNftpow==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:15:14 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::e9ca:72a9:17b1:f859]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::e9ca:72a9:17b1:f859%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:15:13 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "atzin@redhat.com" <atzin@redhat.com>, "linyunsheng@huawei.com"
	<linyunsheng@huawei.com>, "saeed@kernel.org" <saeed@kernel.org>,
	"ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>, "maxtram95@gmail.com"
	<maxtram95@gmail.com>, "jbrouer@redhat.com" <jbrouer@redhat.com>,
	"kheib@redhat.com" <kheib@redhat.com>, "brouer@redhat.com"
	<brouer@redhat.com>, "jbenc@redhat.com" <jbenc@redhat.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ilias.apalodimas@linaro.org"
	<ilias.apalodimas@linaro.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "fmaurer@redhat.com"
	<fmaurer@redhat.com>, "mkabat@redhat.com" <mkabat@redhat.com>, Tariq Toukan
	<tariqt@nvidia.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: Re: mlx5 XDP redirect leaking memory on kernel 6.3
Thread-Topic: mlx5 XDP redirect leaking memory on kernel 6.3
Thread-Index:
 AQHZjY743nR7ST598kifD6Q1M3DiL69oDfyAgE+tU4CAAA45gIAAUDMAgAAJPICABjpogIAAATIAgAAJRwA=
Date: Mon, 17 Jul 2023 15:15:13 +0000
Message-ID: <99774260e7e0f5f21215d6f4b00c5d8a7102f4ce.camel@nvidia.com>
References: <d862a131-5e31-bd26-84f7-fd8764ca9d48@redhat.com>
	 <00ca7beb7fe054a3ba1a36c61c1e3b1314369f11.camel@nvidia.com>
	 <6d47e22e-f128-ec8f-bbdc-c030483a8783@redhat.com>
	 <cc918a244723bffe17f528fc1b9a82c0808a22be.camel@nvidia.com>
	 <324a5a08-3053-6ab6-d47e-7413d9f2f443@redhat.com>
	 <2023071357-unscrew-customary-fbae@gregkh>
	 <32726772de5996305d0cfd4b6948933c47cb7927.camel@nvidia.com>
	 <2023071705-senorita-unafraid-25b8@gregkh>
In-Reply-To: <2023071705-senorita-unafraid-25b8@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|BL3PR12MB6476:EE_
x-ms-office365-filtering-correlation-id: 8f9755ef-3775-41f6-18f3-08db86d89ea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V7j2GywMq9KEcXG9bcwFpYgURahYiGlZQ2e3Q4IA1rJY7rTJGaU66uKp/oIVCy2a/G8n+zhAMhpVHOFIT+UrnFycWbY32n7lTS+E8nxSrWmJCW9qS5cII8mmwAwPymDKVydFcpjTlwPL+r2t/5JvbQ3kE/Oa1DaskQIkzBpi02XgzOJr7F/KmTnt3GDtTO5tWMW4jByQBbR69dVCOM2K7MXuC3GJGDeD1Hjogiuz4Sf81+2nBkqi5HLXljgnQKcDYGOqdDAbP9oEc3HqSpb3Bo4F0GuyYuTLK7D1pkBi7DNC6WFpNBi/Rqny/FygEy14+08pUrzVRs68QvrQPZL52NrvzvZXg32272JTGOeuGOa5km7Bm0wJ1+oDK18hDbHgjZJgBpQC6d+AMn7WN9dR9KTkU55p9A9Y3TW/Y28K6boF7urPSqg1HgNDg9FlQATy+EW4+zXD9m01AfstzdVjQRGt1Ru2iJqflStN4CNw46R3HDM+/ojPTb4lFwsSiKYvsTF7U8bAi/TmYxTlC6Zc85oQc6iRi5lZJOSUqix++Ixi8ejkOR2frx6pkyX72TiOg4qxKoLjElXSfUPtChlrzx5AqbEWwuAkL5KSrMu18pyizqymywaVwewVG3Ed67omN+otyfi8Yybmt4EIG97jxW60wzEQ6G1mOixmZRI3ATLCKl4luRmLgd7epPESDPto
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(186003)(54906003)(478600001)(6506007)(71200400001)(966005)(6486002)(6512007)(2616005)(86362001)(5660300002)(38100700002)(7416002)(8676002)(8936002)(41300700001)(316002)(6916009)(4326008)(2906002)(38070700005)(36756003)(122000001)(66556008)(76116006)(91956017)(64756008)(66946007)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkZmdkV3Y2M4bHpkS25zLzZPOGF4b3EweTV5TE5ZK29hNmQxMFN2cW1zcVVQ?=
 =?utf-8?B?NWs5TmFyTWNFM0p1UE8zWFdrTENxUVJyZ0Y1Mlo3NHUxSlNmajJzSVdLR3k2?=
 =?utf-8?B?dSt3dng1aG1UMkJ5OHJ6dFpuRzJtSmw0dFkvTkRNaVlPVmhQZVZBTEpUSVBZ?=
 =?utf-8?B?S1lNRkJpSGp4Y056QzJFOEg0S2d6U2dkcFpkSEwrQktWL1R5aUxiU2pXWUt1?=
 =?utf-8?B?UjVMekdUMitQSHJHeC9SWFRlNzYvMVdJd2dvWVZnUHBoZElETHZ3Z2hoekVE?=
 =?utf-8?B?eXR1dFY2L1AvQUo2aDJReWI3ajRyQyttUHJLckRTYXNMUlZPb2tNbGVTZzNI?=
 =?utf-8?B?NzVQcmlRTEhNZXVXK0ZjMFBCdlJJekt2TVoweHhDU3U4ZmE0ZlIvWTJLQzNu?=
 =?utf-8?B?bnhJZFAwY0hpclR4cStjdUErQjFlV2VpRWtIK283QTlaQ2lhOTIrK25zTm8w?=
 =?utf-8?B?emN5TS9OTHQ3a0RJQnNyWG93U1UwaW1DdjM2NFZRZFVWSkcyWnAwa01nSFIz?=
 =?utf-8?B?eEhZUElwZW9XMk9sVVhJbkRGZ0hhZEEwME1vVFpyNDdnaWJCRXpiQ0p5bHVj?=
 =?utf-8?B?Q0FXTkR2Ym1pOSs1cDNtaThvbkpoaVRCYlZkVS93bUovemp2elAyNys0dUFh?=
 =?utf-8?B?TVl5T1F4diszaFlOUnVyR3FmRTlHYmZwQTI5VHBqbnAyNkxyYjkvMFNocVlM?=
 =?utf-8?B?cS85NWdJSDVvZ1FCa3JMMHRNL2RIWFFiTEtqNXpNb0Zrb09yN2VXM2FTbUVw?=
 =?utf-8?B?b01jUmZ6c2pnNlRVUTRhTXVVelRxNGJsYXM3dWg5VGRKbVl4dWFIdXdmbk5K?=
 =?utf-8?B?Z0poZ1diRXNrVjJsMXJMaG5ZZTAwTGlTL1FUaDlTcmtaUFN5RTBZQzJBM3E2?=
 =?utf-8?B?U2t2MkQyUXVwM1JoWUlLSld1c2svYjF6UHZ1TVFkeDRoWW9DQU1yUzNjb3NJ?=
 =?utf-8?B?NWRzQzFJTDNRem01bkU3a2xqZERoSk5OY05aUTMzWDU2aktpL2hoYXVUMVpI?=
 =?utf-8?B?TGtXTGZDQ0VzRXZJSHVGcHNxcnlaMks2dVUrMGNYMlFSNVlaRS9nSE9ITVR1?=
 =?utf-8?B?enVQWmoyOEExVVM2cnN4ckhsNXg2d3RDQTBUdW1YaGhNLzJ4VnJ5K3lyeG1u?=
 =?utf-8?B?elcvQnJwTUZyc1kvUWNsNVhUb1RLQU9TK0EzcUFuYmpGYjkzcTdvdlF3MU11?=
 =?utf-8?B?enAxWFlqY0lRWUxXNzhoWnNxNTdJYjBETFQ3Vk9DY3d4WmZ4S2xzelp3RmJR?=
 =?utf-8?B?SUsxN1lFUnQ2Uk9XYWswQ2dOdmVuODBUdml2Qm1zeGVMaGFDOGllU0t2ZVVz?=
 =?utf-8?B?UU9CSlphOWE4eWdUbjJLK0lxUk5rczhPd0NQSkNCdFNvK2JpalF5NFM4Ump5?=
 =?utf-8?B?RFZTTkJnODRDQ3djbkczalVVR3dDMFh1VDhlVmhpUU5OS3JBVEgvR3VQQ2E3?=
 =?utf-8?B?VWFjTk9LM3V5S0grQzltUGp6M01sejZqMVErRXhrb1YxYkYyNnh6K3R4UVU0?=
 =?utf-8?B?dlltNmVyYjFRTFNGbU1rSFFXQjZmd25wMmpWd0xLN1Uya0ZGQlplNkk4UTRX?=
 =?utf-8?B?cVZsU1VPcDM2K3ZVQnQ1U29JNE5WV0ptMVBOdG5wOE44ZnI0b0NWa0dvYWIr?=
 =?utf-8?B?NkZwTTA2SWpYM1pYdVpId3RzcVdVYmhRb3pWSjZCYnEzL2tsdlA2QWEwZGhI?=
 =?utf-8?B?M3h0M250Zkl1Q2Y3RWQ4U0lCZWdWdHI2Y0pGYVk5QjZ6SDViaUYzZUViOHVa?=
 =?utf-8?B?dFVBSXhPUHdRaDV0ajlqS3RjM0Q0d0NyQjd1YXVQZzRBNTVkdExhbkhsclJt?=
 =?utf-8?B?aGpXazhSM3NqV3liY21UUmN6OVRZTVhWQTQ1aFZJMm5UbUtxTG1wd2xvY2Vh?=
 =?utf-8?B?L1YyL0svY3JreTdzVng0UUxxV3lRekxyWW5PV04rV0l0OHdRaEhiSDhWWm95?=
 =?utf-8?B?anRWeG5qTnBhc1E5N2JKRWZ4RDdSN2FncmcvZ2VlYnNyN3JVbndwTWU2ZU9D?=
 =?utf-8?B?NXd3RWMyQmZkcHpQcmtid2RTTEErMHdlampGa3k2TUE1bFlQV1ZGaVgxMDIw?=
 =?utf-8?B?bXBkOGpOSDRybWVLL0l3eXdEZ1MzUHMwbUREdW9xTVZpOE9kMTg2Z05YZHdv?=
 =?utf-8?B?bzlGZ0lLWU16Z3psZHAvU2gvbHczTUdTdU53Yjl4NnAvei9Eb1BYL05heUlS?=
 =?utf-8?Q?NO1/Ni0W9VcFFGbKR/Cw49sgTMW9M8I5LUGcY9j8ddIn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B89F5954DB389847B6C3EED5E87A5B4B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9755ef-3775-41f6-18f3-08db86d89ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 15:15:13.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lq2eHIjBE3uyAWvMBaf2DneKm+ag62FrWNykwTns9ayC3qZ6s6C6MEUD+L4m0T6phKssuy2/mxMHjQsXgpIdmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDE2OjQyICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gTW9uLCBKdWwgMTcsIDIwMjMgYXQgMDI6Mzc6NDRQTSArMDAwMCwg
RHJhZ29zIFRhdHVsZWEgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIzLTA3LTEzIGF0IDE3OjMxICsw
MjAwLCBHcmVnIEtIIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBKdWwgMTMsIDIwMjMgYXQgMDQ6NTg6
MDRQTSArMDIwMCwgSmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90ZToNCj4gPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiBPbiAxMy8wNy8yMDIzIDEyLjExLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToN
Cj4gPiA+ID4gPiBHaSBKZXNwZXIsDQo+ID4gPiA+ID4gT24gVGh1LCAyMDIzLTA3LTEzIGF0IDEx
OjIwICswMjAwLCBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIHdyb3RlOg0KPiA+ID4gPiA+ID4gSGkg
RHJhZ29zLA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBCZWxvdyB5b3UgcHJvbWlzZWQgdG8g
d29yayBvbiBhIGZpeCBmb3IgWERQIHJlZGlyZWN0IG1lbW9yeSBsZWFrLi4uDQo+ID4gPiA+ID4g
PiBXaGF0IGlzIHRoZSBzdGF0dXM/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgZml4IGdv
dCBtZXJnZWQgaW50byBuZXQgYSB3ZWVrIGFnbzoNCj4gPiA+ID4gPiBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0LmdpdC9jb21taXQvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlP2lkPTdhYmQ5NTVhNThmYjBmY2Q0
ZTc1NmZhMjA2NWMwM2FlNDg4ZmNmYTcNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBKdXN0IGZvcmdv
dCB0byBmb2xsb3cgdXAgb24gdGhpcyB0aHJlYWQuIFNvcnJ5IGFib3V0IHRoYXQuLi4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEdvb2QgdG8gc2VlIGl0IGJlaW5nIGZpeGVkIGluIG5l
dC5naXQgY29tbWl0Og0KPiA+ID4gPiDCoDdhYmQ5NTVhNThmYiAoIm5ldC9tbHg1ZTogUlgsIEZp
eCBwYWdlX3Bvb2wgcGFnZSBmcmFnbWVudCB0cmFja2luZyBmb3INCj4gPiA+ID4gWERQIikNCj4g
PiA+ID4gDQo+ID4gPiA+IFRoaXMgbmVlZCB0byBiZSBiYWNrcG9ydGVkIGludG8gc3RhYmxlIHRy
ZWUgNi4zLCBidXQgSSBjYW4gc2VlIDYuMy4xMyBpcw0KPiA+ID4gPiBtYXJrZWQgRU9MIChFbmQt
b2YtTGlmZSkuDQo+ID4gPiA+IENhbiB3ZSBzdGlsbCBnZXQgdGhpcyBmaXggYXBwbGllZD8gKENj
LiBHcmVnS0gpDQo+ID4gPiANCj4gPiA+IDxmb3JtbGV0dGVyPg0KPiA+ID4gDQo+ID4gPiBUaGlz
IGlzIG5vdCB0aGUgY29ycmVjdCB3YXkgdG8gc3VibWl0IHBhdGNoZXMgZm9yIGluY2x1c2lvbiBp
biB0aGUNCj4gPiA+IHN0YWJsZSBrZXJuZWwgdHJlZS7CoCBQbGVhc2UgcmVhZDoNCj4gPiA+IMKg
wqDCoA0KPiA+ID4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vz
cy9zdGFibGUta2VybmVsLXJ1bGVzLmh0bWwNCj4gPiA+IGZvciBob3cgdG8gZG8gdGhpcyBwcm9w
ZXJseS4NCj4gPiA+IA0KPiA+ID4gPC9mb3JtbGV0dGVyPg0KPiA+IFNvLi4uSSBhbSBhIGJpdCBj
b25mdXNlZDogc2hvdWxkIEkgc2VuZCB0aGUgcGF0Y2ggdG8gc3RhYmxlIGZvciA2LjEzDQo+ID4g
YWNjb3JkaW5nDQo+ID4gdG8gdGhlIHN0YWJsZSBzdWJtaXNzaW9uIHJ1bGVzIG9yIGlzIGl0IHRv
byBsYXRlPw0KPiANCj4gVGhlcmUgaXMgbm8gIjYuMTMiIGtlcm5lbCB2ZXJzaW9uIHlldCwgdGhh
dCBzaG91bGQgbm90IGhhcHBlbiBmb3INCj4gYW5vdGhlciB5ZWFyIG9yIHNvLg0KPiANClNvcnJ5
IGZvciB0aGUgdHlwby4uLg0KDQo+IElmIHlvdSBtZWFuIHRoZSAiNi4zLnkiIHRyZWUsIHllcywg
dGhlcmUgaXMgbm90aGluZyB0byBkbyBoZXJlIGFzIHRoYXQNCj4gdHJlZSBpcyBlbmQtb2YtbGlm
ZSBhbmQgeW91IHNob3VsZCBoYXZlIG1vdmVkIHRvIHRoZSA2LjQueSBrZXJuZWwgdHJlZQ0KPiBh
dCB0aGlzIHBvaW50IGluIHRpbWUuDQo+IA0KPiBXaGF0IGlzIHByZXZlbnRpbmcgeW91IGZyb20g
bW92aW5nPw0KPiANCkkgYW0gZmluZSB3aXRoIHRoZSBzdGF0ZSBvZiB0aGluZ3MuIEJ1dCBKZXNw
ZXIgd2FzIGFza2luZy4gSSBzdXBwb3NlIHRoZSBhbnN3ZXINCnRvIGhpcyBxdWVzdGlvbiBpcyAi
aXQncyB0b28gbGF0ZSIuDQoNClRoYW5rcywNCkRyYWdvcw0K


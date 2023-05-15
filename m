Return-Path: <bpf+bounces-577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D8703F6E
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C2C1C2090E
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E919BB7;
	Mon, 15 May 2023 21:14:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D371FBE
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 21:14:37 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72440D047
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 14:14:34 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJxUH5032501
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 14:14:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kywbLOslOgSdeZBvlr8+So/6P9P0iKvkushyXv3+CvU=;
 b=QSF3OqyJddv6leKOAUeFireGh8oPumjc686dbm8Vz+852AvJA1bqPJtOxvdgmgIrsWWI
 BN49OsTsDdLcHipmoAmj2T5UmRcUBmZpnVwteh92x2OZPjAOwuqggeFcRLLCwuw4hNH+
 UDXfX0D8ufuwSQ0UMR2q3YxJzOhun/9g85ryAMqjDL/Pm8rzrdK3bdTE8hZHd5PQvqN4
 nBNLFhV8sZbkT6nsrdYgfEoTVZ/dRyIAyE0Tt5FELoa2CM/7PvjU813kU1u3jhMFqm2p
 Ybh5tcOezluCW8vLOH32CdGobXjH7t0ltsIQkPs4oslscrZfRpaxipu/W/pq6IUmQRQp Mg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj830ekxw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 14:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNti5XNAOqbhL/osou5YrmKKygC2gDzzBnDTWGMu4g2gOucKI0OUxpIudOgfIYpZTE6edw80WPs/isK7MSVat5Hz0Ehx+0yDvij5EPhClKaTcrIq6DY7XbFFd7qeA0ggvFNgHUJiJVUGC6CN/EdURjK5TXNOPpjt6SIklLJMp1ti/owL5FCZgvCfOmgwW8nkW7bEF6VsMe3ZJlRcX33A+H6xLli7OtlPXvb8yEGL6yLZIZyQRZtUwwl0wUaB7GrXv8acoLNk4FoON5hcCWMgbezBl4d3oK9DGy6pZW3H0oyWingOsoeqyee9vjYQuw31RVpsKs5nIfI0TA3nifwRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kywbLOslOgSdeZBvlr8+So/6P9P0iKvkushyXv3+CvU=;
 b=ftpIJhmwXmbZtmjXgyBc0DwtIFNycCJF4+QRD6PoBBljaI3q/K94yAelnP5X7h9a0ih9rRpzv13yAwXQPWcqQFwZ4emIMFmT95IYRTXtzx34Dy2vEoj9K7gCnjLh5aDF0tpr4BfSuzZM1HYPg6uaqDdwp6nro+rlwGzoHKW2598oIjPClyVOm1RtNqrBJ64WSt5KWHpzLK1+qUDETB5A4pzdKuHx3j8PfAeF4O8XoQbiB4UiqEEDkSdqrebadJsTcb/6cG1Yt5XYM2GiiPmTVJigjsd0dxNUDE7dp6Or7rt05WmMOvCfOuwJG9aHwmQ1qyDrct9bl1L09ajnGlMLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CY8PR15MB6353.namprd15.prod.outlook.com (2603:10b6:930:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 21:14:30 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 21:14:30 +0000
From: Song Liu <songliubraving@meta.com>
To: Daniel Borkmann <daniel@iogearbox.net>
CC: Song Liu <song@kernel.org>, Yafang Shao <laoar.shao@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau
	<kafai@meta.com>,
        Yonghong Song <yhs@meta.com>,
        John Fastabend
	<john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix memleak due to fentry attach
 failure
Thread-Topic: [PATCH bpf-next v2 1/3] bpf: Fix memleak due to fentry attach
 failure
Thread-Index: AQHZhy5sM5JJe33z20m5RhTAfHtUT69bfA0AgABKJoCAAA/mgA==
Date: Mon, 15 May 2023 21:14:30 +0000
Message-ID: <5154108C-1556-4132-871B-D739C0B6751D@fb.com>
References: <20230515130849.57502-1-laoar.shao@gmail.com>
 <20230515130849.57502-2-laoar.shao@gmail.com>
 <CAPhsuW4_wBBKDfmCos+rXvYoT3H9=0W3EEzAWhS79i4-oHHYnA@mail.gmail.com>
 <f88e789f-b2e9-5a20-fbc7-4b4ad6f735c4@iogearbox.net>
In-Reply-To: <f88e789f-b2e9-5a20-fbc7-4b4ad6f735c4@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CY8PR15MB6353:EE_
x-ms-office365-filtering-correlation-id: 2d931589-2eb9-452e-dfb6-08db55895f8d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oxq5EdOsTIwh7QD/l3lLoAnjxChJi4eJx/xCo5OKBsBPcYzShu8E4DJ862hPZpYGstUJpD3s1zjc8D2VHe71xE8+s78CgFm+MV1GyPsN8QTCE2hhIJTOWz27wXcjZASNltrJqMvp66ZXtfXAPRG6Mk1CeXaADDNCp7gXJTzdlkswiZHqQ7Ctebn/XHzzY4yaoXpVl+RM5bjl8v4igNr82J/BW1bQQnnKDPxRX/uS2br8qhkXT2svEXHJSVcl4q2kGR6Dt9j1MOjsvBWmojd43bFgWEhezle45qkEGfGtXGRQZoT00QIJ83jRnU8rzxy/a+uix9sAaEPq76bBzoyWghExOp8ImviGuenJH6aNBSCkGuRp7aqXAga/up0p5T5bHEfNdTBhGdyiHtJUnGsrSPQaRV7tS0T99McCs6oa3UDmsLgv5iGOfWTKjJjutS2uU7RFlJSTuVTpS8yxfOMKdEOayDgmSK0OTEgXRlMY0aTpn/iD77c9llfe9iqnYK5F9nbRYMCUg/nr/nyCEcV8DhviGLT7s0QAOw2fDQeOpwvuqSPvP5gQS0l2iQ5ZLkL7wkFYaes4HwWjmrPwF/e+suhs0OsTxWdjgNGE10z/PZRF4f04yoqP5Ex8znkO5Rdv
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(66476007)(4326008)(66556008)(66446008)(6916009)(66946007)(64756008)(76116006)(478600001)(91956017)(316002)(54906003)(6486002)(33656002)(36756003)(83380400001)(6506007)(186003)(6512007)(53546011)(9686003)(41300700001)(5660300002)(8936002)(8676002)(7416002)(86362001)(2906002)(71200400001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ajdlNDJOYkdQY0wwd1FaY3Jsckw0QTF3UlAzanEyYXNacGZFVzhOQks2NGdZ?=
 =?utf-8?B?TUM3RER6YU9SSzZDeUNocWd4WG1qbW5nYmUwbXBDZ0lwTTBPbzdDM0c5K0JM?=
 =?utf-8?B?NFJiVlBLTkF1dGlkSitkOXhCMG9reXdNWHlXUDFoSEU1M1pneUtwQ1RQSDRB?=
 =?utf-8?B?bDhzbldYUDJtZmxWVlZKOTVtbi83ekFPbnM3Nko2dnlNd05INHZBTTFPcFRB?=
 =?utf-8?B?eUZRUXA3YWRCTlhZRWY1OFZpWXMrTGZQOE5JUEhDT1FuMzVZWnFVaHZqcm80?=
 =?utf-8?B?MkRCcWFSTHY5ckNoL1B2VVJ4SFFvQjFUdFdSZ2kvKzJ0N2dtYTFZcWJSWjRS?=
 =?utf-8?B?STMvK1V1U0NmTUFoam1qdkhXWEJpQ3pDQVFBR2MwWmZ0cUJTQ01GMS9JWjdU?=
 =?utf-8?B?TnlBQjJwZVVtMEU4MHpWY0VxemZtaC8ya1pKSm9VVUw2YmNUMzdiUlZvU1J3?=
 =?utf-8?B?dVh6Z0hiYXo4WENxVVo4aThtempLMUFyRURNK0F5WEZQRlJSQkdMOUdnTWJG?=
 =?utf-8?B?ZlN6aHY1Um9lckNyTGR3SkM2SzZHWWRVSnRSdWlxQXFocG9Wa3lQSEwvOTcw?=
 =?utf-8?B?Vjd1NitlM2VzR1pqWHVuMitza1BEZFNUMW1ibFNlWnc5YjlJREs4VCszaVJT?=
 =?utf-8?B?RWljVVNMdnRuV24xNFFPSWx0OXM0MUZiOGpnaGkxbXd5YWN1UXVySWN4aUV3?=
 =?utf-8?B?VDVtRTlIMWl6RnVSeFRmdGRZcmNOVjRLOFlWc1ZaSW8zcEZCSU1YY1pDZkRs?=
 =?utf-8?B?M3YvdG1EUGM1cWg2WjZHTHpPWmlXdDFoV2xZa0o3REFXUjBWdmp5clYvVDIw?=
 =?utf-8?B?MnNoeHoreU5CWlJiRk1zVUJsc1ByT3dvU1JJWVVRcFQvZFI4ZHFSMzNMb1JJ?=
 =?utf-8?B?MENZSjh4TkdGMnRHZE5YWXBJRThHT1hiTmhBVVNXelNYZHFLN3hrMnVuYVc3?=
 =?utf-8?B?bC9SL0x3dDgyajBYaXRIVDJmUldxTnpTVkI2dHFxVkFtaUVoY2JmeWJZMTJX?=
 =?utf-8?B?d1cwcjNleWVVYnNqMHdYeTNGaW1XL29hWURXaW1vak05TGdaY2s4WWZnNW9h?=
 =?utf-8?B?TFlKeFMrcEpxTlN0REZVSDgzMWRxM2cvUlQ5dkJtOVFVSWdkVTFaSXJPYkg3?=
 =?utf-8?B?T3hqZGVNTHR4MHg2dU0xTTdLK21sUFFLb2ZSVk9PaU9qMS9CY0NpWjlpaER0?=
 =?utf-8?B?dW1NU0J1LzlkS0FCRmtiK3dDVFlIdktmc243bW5BV3dyWWFqL0E1UWNzamtk?=
 =?utf-8?B?dlNDVjhxWVVQMXN3bnhvcDNvNCtnWUlQbVcxRnI1R3EwK0lZdEJyZmhBbXVN?=
 =?utf-8?B?NDY1U3dUU3htU2M2KzFRZkdVekNoUGhXckRLS0JQb25uM2RwcUtaS3B2cVRX?=
 =?utf-8?B?QWNGRXFnNHgybko5U21ZaldmNEhvNTlwQVpHd09qbEVjZGljT0xBOEdwOXFJ?=
 =?utf-8?B?ejI1VXVlUUdXMzVYNy9OR0pBK0lYN21KNDZNODFVYmJ2YW1HMTd3Mmlxa0Rw?=
 =?utf-8?B?NjBGM05OeHlWTy9tbU56QW16VUFJV1RtNTYxN0tzN2djRE1YZWlUdEdobjlG?=
 =?utf-8?B?bFpISlNhcldoWUNVdDl5OExaODZKcDRQdldGQ0xWL25taURnTzhqSGptMElC?=
 =?utf-8?B?c2xqNVlLNSt5MVJCN1lUWDhqUkxoR1A1UlEzd0lSalhDbDdVVTdOYTVzOGc3?=
 =?utf-8?B?NE5XWmNtaHNGaTgwT3FjNUUwMENlSmxHZnlpN1d3WjAzRk5rSXlCSVhUN0tv?=
 =?utf-8?B?bGYvZGtPbWM0Mlk5SVRiS3o2QjFZbGJyL0RMMGE0aU5WRjliVldNaEwvWWFJ?=
 =?utf-8?B?T1pSbEFPSkRJTzJWdkxjY0ZEQTFybTRzcGNDOGxUdnR6emxwbm9zOS9xcGlp?=
 =?utf-8?B?UzNsY1pjWGxpSmNocWwxa1ljRjQ5MktVVUxMTUM2aVZ3dHh1bUwzQ2V4OVhC?=
 =?utf-8?B?eUVPdVYweCtTdmlsdXJ2UitBTDZqdDZxMTliZldVTzJvMFVDem4vNVZUczBw?=
 =?utf-8?B?WG1GS1ltODRJVDVyOE9JV05iN0VJaDQzRThkYU04cWM1VHRFNU8vSkVZRDRF?=
 =?utf-8?B?QXVIVGI2OU1YNVNwNUN2TXpjQU42MnA0eTAvV1VpL2dEdUhOUVh0bG0xd2d0?=
 =?utf-8?B?ZnFVdytjbUllaU1qWVJYbDZnT2hkejUxbWV0d2tWMjFBV0FYVTFUc3ZkV3NU?=
 =?utf-8?Q?POtEt9zCFk2CW/PuHSPZmyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7ABC4E65478604CA5C31B66A4CED759@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d931589-2eb9-452e-dfb6-08db55895f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 21:14:30.4589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ct2gYpDEjEjmWaqU0c6c7UpEM++p+sYl5WoZCD8DnW31tIF+0Qw7bRetI9vzs1dI/0gscxwgM7fF2zVzjTziYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB6353
X-Proofpoint-GUID: PixduSUKvQZI5VboqUGUuR6NDxK26RtH
X-Proofpoint-ORIG-GUID: PixduSUKvQZI5VboqUGUuR6NDxK26RtH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_19,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gTWF5IDE1LCAyMDIzLCBhdCAxOjE3IFBNLCBEYW5pZWwgQm9ya21hbm4gPGRhbmll
bEBpb2dlYXJib3gubmV0PiB3cm90ZToNCj4gDQo+IE9uIDUvMTUvMjMgNTo1MiBQTSwgU29uZyBM
aXUgd3JvdGU6DQo+PiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCA2OjA54oCvQU0gWWFmYW5nIFNo
YW8gPGxhb2FyLnNoYW9AZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBJZiBpdCBmYWlscyB0
byBhdHRhY2ggZmVudHJ5LCB0aGUgYWxsb2NhdGVkIGJwZiB0cmFtcG9saW5lIGltYWdlIHdpbGwg
YmUNCj4+PiBsZWZ0IGluIHRoZSBzeXN0ZW0uIFRoYXQgY2FuIGJlIHZlcmlmaWVkIGJ5IGNoZWNr
aW5nIC9wcm9jL2thbGxzeW1zLg0KPj4+IA0KPj4+IFRoaXMgbWVhbWxlYWsgY2FuIGJlIHZlcmlm
aWVkIGJ5IGEgc2ltcGxlIGJwZiBwcm9ncmFtIGFzIGZvbGxvd3MsDQo+Pj4gDQo+Pj4gICBTRUMo
ImZlbnRyeS90cmFwX2luaXQiKQ0KPj4+ICAgaW50IGZlbnRyeV9ydW4oKQ0KPj4+ICAgew0KPj4+
ICAgICAgIHJldHVybiAwOw0KPj4+ICAgfQ0KPj4+IA0KPj4+IEl0IHdpbGwgZmFpbCB0byBhdHRh
Y2ggdHJhcF9pbml0IGJlY2F1c2UgdGhpcyBmdW5jdGlvbiBpcyBmcmVlZCBhZnRlcg0KPj4+IGtl
cm5lbCBpbml0LCBhbmQgdGhlbiB3ZSBjYW4gZmluZCB0aGUgdHJhbXBvbGluZSBpbWFnZSBpcyBs
ZWZ0IGluIHRoZQ0KPj4+IHN5c3RlbSBieSBjaGVja2luZyAvcHJvYy9rYWxsc3ltcy4NCj4+PiAg
ICQgdGFpbCAvcHJvYy9rYWxsc3ltcw0KPj4+ICAgZmZmZmZmZmZjMDYxMzAwMCB0IGJwZl90cmFt
cG9saW5lXzY0NDI0NTM0NjZfMSAgW2JwZl0NCj4+PiAgIGZmZmZmZmZmYzA2YzMwMDAgdCBicGZf
dHJhbXBvbGluZV82NDQyNDUzNDY2XzEgIFticGZdDQo+Pj4gDQo+Pj4gICAkIGJwZnRvb2wgYnRm
IGR1bXAgZmlsZSAvc3lzL2tlcm5lbC9idGYvdm1saW51eCB8IGdyZXAgIkZVTkMgJ3RyYXBfaW5p
dCciDQo+Pj4gICBbMjUyMl0gRlVOQyAndHJhcF9pbml0JyB0eXBlX2lkPTExOSBsaW5rYWdlPXN0
YXRpYw0KPj4+IA0KPj4+ICAgJCBlY2hvICQoKDY0NDI0NTM0NjYgJiAweDdmZmZmZmZmKSkNCj4+
PiAgIDI1MjINCj4+PiANCj4+PiBOb3RlIHRoYXQgdGhlcmUgYXJlIHR3byBsZWZ0IGJwZiB0cmFt
cG9saW5lIGltYWdlcywgdGhhdCBpcyBiZWNhdXNlIHRoZQ0KPj4+IGxpYmJwZiB3aWxsIGZhbGxi
YWNrIHRvIHJhdyB0cmFjZXBvaW50IGlmIC1FSU5WQUwgaXMgcmV0dXJuZWQuDQo+Pj4gDQo+Pj4g
Rml4ZXM6IGUyMWFhMzQxNzg1YyAoImJwZjogRml4IGZleGl0IHRyYW1wb2xpbmUuIikNCj4+PiBT
aWduZWQtb2ZmLWJ5OiBZYWZhbmcgU2hhbyA8bGFvYXIuc2hhb0BnbWFpbC5jb20+DQo+Pj4gQ2M6
IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+Pj4gQ2M6IEppcmkgT2xzYSA8b2xzYWppcmlA
Z21haWwuY29tPg0KPj4gQWNrZWQtYnk6IFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+IA0K
PiBXb24ndCB0aGlzIHRyaWdnZXIgYSBVQUYgZm9yIHRoZSBjYXNlIHdoZW4gcHJvZ3MgYXJlIGFs
cmVhZHkgcnVubmluZyBhdA0KPiB0aGlzIGFkZHJlc3MgYWthIG1vZGlmeV9mZW50cnkoKSBmYWls
cyB3aGVyZSB5b3Ugd291bGQgdGhlbiBhbHNvIGhpdCB0aGUNCj4gZ290byBvdXRfZnJlZSBwYXRo
PyBUaGlzIGxvb2tzIG5vdCBjb3JyZWN0IHRvIG1lLg0KDQpJIGFtIG5vdCBmb2xsb3dpbmcuIElm
IG1vZGlmeV9mZW50cnkoKSBmYWlscywgd2Ugd2lsbCBub3QgdXNlIHRoZSBuZXcgDQppbWFnZSBh
bnl3aGVyZSwgbm8/IERpZCBJIG1pc3Mgc29tZXRoaW5nPw0KDQpUaGFua3MsDQpTb25n


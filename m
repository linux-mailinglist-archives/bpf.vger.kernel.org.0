Return-Path: <bpf+bounces-14378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F17E354B
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 07:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B21F2143D
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 06:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CB4430;
	Tue,  7 Nov 2023 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="Apo0FMoy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C2C2C0
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 06:38:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D3126
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 22:37:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz/j2rdRBrrI3GZSVd7XsJWihMQ9VHiij568ZkIzLfyTqBkuaK2vsvGKUkDoR3GyIgFp74P4MK+i7cIHrxKGfGXi/VMTTf6Ub2Yik40tP/rlRV9b8sPdTHWg+Y3kjkc/0dopy5rOPuTk6bzWnNs9FZKbphWnbdVlH5C4PigEA2dffayYuvbxHMzAgxF2af9LVG4Y7p5Y0Jg2wibnyQe+LWpi8CJ8ifqbhKn5Af5jwIdSgoidZYw4RlKHemSU7awl6uxHUwGqnEUPE0Mzxjo/o/hzV0OIEhTbtfN0B4bkcjFUTco7TUb5jl0pj9F9jHLKlHFnS1nTMBv9sJOP/JbGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07qxiZPlTiL/n9+lD4l5vlhRp+FLQtFuGchKViY1Um4=;
 b=Zpm9bnK+Mg845etINjYq36iRDI3V/+NCSUnEqEIRM8SVrM/NtW2LAmF5oVJpJ7SHfyOAOuK5LuyoOH9a87Px/rMpA1XtLehrg33LpyMc8zRGPz684zsV+elJiiWypvcp6fAkco2Fs7S208qpfIr9ceMw3ta9ndExI+D7fJMqP5Smrmb4bpdLf3T0K5sfTilm69rJdViaJhb/XLpMo7yi0k1586i7h91ANVK/tYYH7WTmwHzG8Dr9jiIuDCEfGpAJAlnWNIGjfGu0mQsdPdogdV/DjBod3pZIl2tbMwnVjYJiCNKhdufGDWd/ZL6R0nICYX1ZSRkY6ASb2JYo3WWZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07qxiZPlTiL/n9+lD4l5vlhRp+FLQtFuGchKViY1Um4=;
 b=Apo0FMoyXIdYaZs3B1G7ZxLUPPAG8ghEZlpsVC8qaZY5mI2vYGb+Se4AAIGJtfADFg+I99b3EMvfFKjVGnpIYjZULewlP/CBjLmCwhM1sLThg3NsmKnI1mxxCQ9p4MaeXEvqwlr/rrRPTfcRu6PzFQYXwfU5yGkhS02VS5qxq1I=
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com (2603:10b6:a03:4c0::14)
 by IA1PR14MB5732.namprd14.prod.outlook.com (2603:10b6:208:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 06:37:47 +0000
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::6c27:f28a:7e74:4e6c]) by SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::6c27:f28a:7e74:4e6c%6]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 06:37:46 +0000
From: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Paul Chaignon
	<paul.chaignon@gmail.com>
CC: Srinivas Narayana <srinivas.narayana@rutgers.edu>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Paul Chaignon <paul@isovalent.com>, Andrii
 Nakryiko <andrii@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "martin.lau@kernel.org" <martin.lau@kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH v5 bpf-next 00/23] BPF register bounds logic and testing
 improvements
Thread-Topic: [PATCH v5 bpf-next 00/23] BPF register bounds logic and testing
 improvements
Thread-Index: AQHaDMBkWZSERI/Y4UCAV9pLw6+Q+bBls/IAgAi7xHM=
Date: Tue, 7 Nov 2023 06:37:46 +0000
Message-ID:
 <SJ2PR14MB650157D056A11DBD3FD25E438EA9A@SJ2PR14MB6501.namprd14.prod.outlook.com>
References: <20231027181346.4019398-1-andrii@kernel.org>
 <20231030175513.4zy3ubkpse2f6gqz@MacBook-Pro-49.local>
 <CAEf4BzZyLwO_ZppGObkY=4aXZEGE+k+tTtJug7MP63DffoxrYA@mail.gmail.com>
 <ZUJGkRGnw+qI15Pv@Mem>
 <CAEf4BzavMQ9kqjVWhasdOMweZKuvwfmthzfz8i38kLwp6jd8SA@mail.gmail.com>
In-Reply-To:
 <CAEf4BzavMQ9kqjVWhasdOMweZKuvwfmthzfz8i38kLwp6jd8SA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR14MB6501:EE_|IA1PR14MB5732:EE_
x-ms-office365-filtering-correlation-id: 112b0750-5460-48cf-a520-08dbdf5c0da3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IIt/DOc/4UlUgubIdVRQ3FoWKeaqDvFzTwaTyQzV6EtdbK4L+7Qzuzxy/A0a0SbMcomEFJMCuiluj4DR1fonsAobccbtwCRPMFTyn3LHEHbEWBlnYdY9T/GOWRhDW85C1XA5ycShgYks0J/OUD58h/WQjYPCfXAvBqtOQcknUD9e4HvNNnf8R6JIIZ0Dj8Bzpf8d4Q5N1Q3Z+HBmvahdMwUuszUEsm5HPyXidCEmfsEHa2PyQOxz7YmRXsNoqXt4/0Gluy3/81dtlmu3FMIvqnpCPmEMZVAFirRoKog/0hd2ohqHG9wrjy5muo+iziWlAIuik1YWEr3vprz1ID7Z4OjyI6DZPTNjJ6rUcgpeeUDBWcBpi8th1mkfHr2uFrku7JBfDeD3N7c+OE7BlsYerxwN7OYi2rVqBL9YZPe4UPEYZTOsEW6ljaLEEwW+nGhQvXGm2bco+DkCL25ApznG/Cp9N+O3MicuVzEpkoII/DHGyb3CDPFB/RT+PEbMRS6AWSKRABvZ34BohvSeCnhqpMaYvKb23pI84EXujW0WUdtGUHG7ndCm4HKSRBV3rpwCSPuFTk+1GlcDYqpBp7GyLAXS/l8xA2wbju1siP1aPEQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR14MB6501.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(75432002)(83380400001)(71200400001)(38100700002)(44832011)(966005)(8936002)(2906002)(786003)(52536014)(8676002)(5660300002)(7416002)(316002)(4326008)(41300700001)(54906003)(478600001)(9686003)(7696005)(6506007)(110136005)(64756008)(66446008)(66476007)(66946007)(76116006)(91956017)(66556008)(45080400002)(53546011)(86362001)(33656002)(38070700009)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFg5WWt2MHpvaUdOMnRqR010ZEVhdnFRK2d4VzdUTnRobVpHbHNETTdaUll1?=
 =?utf-8?B?VU5PRWVBbGszTlVJNFgyL250bGtRT0duN1VDdFMzbStnV3lHSDQ3b2pnTTda?=
 =?utf-8?B?U1Z5VXo5VFRkMTdUUVdkVUQyRFIyb0ZWRXlOcUJqR2xwR0pjcjI3TGJVT09U?=
 =?utf-8?B?cTNsY29rZTBTK3JTYzlvVFlucEtnWjNXYTVtNERscnliNzF2Uy9UUi9EeHFO?=
 =?utf-8?B?OEQrOUgzWmxUZFQ4RFJYZUZjWUpySHBLTXE4RytTeElxeFBuNjF6WXlRbzdr?=
 =?utf-8?B?eWQyblpndzlJVnlsY1IxWUFIbkVEbGtMMm1tUDNSN0FqNjBwWnp1K0k2Rkd1?=
 =?utf-8?B?SElDeFNWeS94elhJc2tGcmNvVmNCY0t4UXpBcXlCdnN3bFN0MGZRVjlZTUF3?=
 =?utf-8?B?cmdGVzNpUmJUVElzZThIZ2FWZTEwVThGVlFFallrVldaTHhmQjh5N09Uekxz?=
 =?utf-8?B?c3hXNHJ4cHh1UCtOdEdJNE1ZaWgzWXo2QTdGUU5Xdm9VNDZ6SXB1OWNvVnZy?=
 =?utf-8?B?K294eHVlVGZLRzV1N3hTbkMzOE9VTmJHMkNGTlYvNTFNd2FTSWVIN0VYaHFj?=
 =?utf-8?B?dUp0TTM1ejBpNEdaL2F3UFVuczhwZzUvcUltbngyY2RqSktDNndwNmk3cFAx?=
 =?utf-8?B?Sk10azl4OE5xYWRUWWxoY3VBWkFQd0hkNGI0b204c1dDZXpkU2hzcmdvUVZK?=
 =?utf-8?B?OHh3N29XU0tBc3BOa0swdUpONXUrTUpNUXRwK1k1UFZwUEYrYkJHNHQvK2g4?=
 =?utf-8?B?dWJ0bitHL3VhS0hhWm02b3lJejE1SFZOeC93amcrL0lrYVBmeU41ZHNUc3dB?=
 =?utf-8?B?VUtNVFBQWlpmbmVDUU5va0ZBbktTZVBuYXY3OEdtcS9NdWxmRW0rclBDSllX?=
 =?utf-8?B?RTN5MFJUQUhmMXZnTVhaaldRYVBOZzNQNGhYUU9oZlA0bWdyMEYyNEN3dzRD?=
 =?utf-8?B?TG5CQnlvRDJlcjVWUEhLb1JKcHdRSGd0NldNRkVGMWFhRTAzRkJOY1BGY01V?=
 =?utf-8?B?bHE4aW5MZXJWSlNOT0p5NnZiNVFpdWFqNmF0UW0vZUsvM2lWRktHaWZEcDZu?=
 =?utf-8?B?dUtmUk91OXdCU3B2cllHS3dTVVR0Q0VuZ2daSDk1NGpZK0k1d1MxbjZMMkl6?=
 =?utf-8?B?MVBWSUZSQzBieVhFR2h6VWc4Ly80TnphbzlyU2pGaStya2pTWUI2cFBDRXZo?=
 =?utf-8?B?OVBoR3NQWlpNdi9XKzc0Z0lxdEJGUlJ2aWRoZy9uMjZXcmJuRjBEYkNXYzJ1?=
 =?utf-8?B?NXRPQjdDQ3NqcjExV0VhajRKL3N5Q0RrUGF3ODNNKzhxQXByVU5VU2VwUm02?=
 =?utf-8?B?T3A1YmVzUGhBTnN1SGRGTlM1bWsyMURmMmVHVENhM0hGOWRDdkVxekpseUZr?=
 =?utf-8?B?Z2lwL3U5ZnlNWWJrSzVzUCtjS2xQaFE0WnRXanBiQ0pJcW42R3VkU291cHV4?=
 =?utf-8?B?L0tWWDM5MEl1Y1ZtWjE5bTF2b0NTOE1yaXhENkdvLzVERDhWOFI0R29oMVdk?=
 =?utf-8?B?cW1mWlIrUk8yREJySkcrVmZHYUw0RDZQNmYzQTRzeHBvSmRQTDZRL1JncTZB?=
 =?utf-8?B?T0hMdWZPRmptVUhnenNDdUkzbkZLb05kU1FLN3dMZVdFWldxN1diQ21TQ2U2?=
 =?utf-8?B?K0hTU09TZ1NWUlhCVjFZcWtUYTlxL2NnTndQNzkvSGFKY2FMN1JFaG9ZZmsw?=
 =?utf-8?B?a3o2Mm1wMGhLQ3NqSk1uWHgwYm5rSkhaMEUyYTl4NGk4WGxZVDYwYUxwdDRV?=
 =?utf-8?B?K0NwNUhiSWRLMXExZDFDYW12cnlSSk8vbytHazBUbUFlUXBCQ005ZzJlSmM5?=
 =?utf-8?B?NzZPVC9jZ0pRU05samVuazlFK3NIcFZYYmYxam1oUWFCR3pHQkZ3TjRuaktQ?=
 =?utf-8?B?dFdWSlR3THBPRHRPS2tzMFdZRUMxZVhGT1FwRjhpODFwNXFUT25UZUlRcGpy?=
 =?utf-8?B?VThnRjBzVnBIOCs4Z2duMzBEREZrNnpqekluWGRCMEEyUEJFZDNZVHBrTktD?=
 =?utf-8?B?cVBBQk5XNG9pOVpob2hLMDdvamZxUW5vQkVoYUhMS3h4WTdUL0NUaGd1YjZL?=
 =?utf-8?B?ZFZrSFkrZjhEQ1dEeGZLa2YvK2wzbXdJZC9DelZlRjNlNS8yRXhGNjhXSVo2?=
 =?utf-8?B?MDJKRW5pVVBaYk82MzBsMDd0dmJmQ09xSUZNUFJsYmlSNnhkWDRZeHViYVJu?=
 =?utf-8?Q?9F5cB86tUXntZOHUXNSSXoLfNM/XRzqeC+dgEBku8PEu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR14MB6501.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112b0750-5460-48cf-a520-08dbdf5c0da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 06:37:46.1484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2v2C2WiLOiDpuXYQdjoya8ULDXcd+CffbIakhxtoRBJJMbKQK9dNxMPpZQbvV6KCVlxtG5ZiUGO6lsPoXTrtdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR14MB5732

T24gV2VkLCBOb3YgMSwgMjAyMyAxOjEzIFBNIEFsZXhlaSBTdGFyb3ZvaXRvdg0KPGFsZXhlaS5z
dGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiBXZWQsIE5vdiAxLCAyMDIzIGF0IDU6
MzfigK9BTSBQYXVsIENoYWlnbm9uIDxwYXVsLmNoYWlnbm9uQGdtYWlsLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBPbiBNb24sIE9jdCAzMCwgMjAyMyBhdCAxMDoxOTowMVBNIC0wNzAwLCBBbmRyaWkg
TmFrcnlpa28gd3JvdGU6DQo+ID4gPiBPbiBNb24sIE9jdCAzMCwgMjAyMyBhdCAxMDo1NeKAr0FN
IEFsZXhlaSBTdGFyb3ZvaXRvdg0KPiA+ID4gPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+
IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBGcmksIE9jdCAyNywgMjAyMyBhdCAxMToxMzoy
M0FNIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBO
b3RlLCB0aGlzIGlzIG5vdCB1bmlxdWUgdG8gPHJhbmdlPiB2cyA8cmFuZ2U+IGxvZ2ljLiBKdXN0
IHJlY2VudGx5IChbMF0pDQo+ID4gPiA+ID4gYSByZWxhdGVkIGlzc3VlIHdhcyByZXBvcnRlZCBm
b3IgZXhpc3RpbmcgdmVyaWZpZXIgbG9naWMuIFRoaXMgcGF0Y2ggc2V0IGRvZXMNCj4gPiA+ID4g
PiBmaXggdGhhdCBpc3N1ZXMgYXMgd2VsbCwgYXMgcG9pbnRlZCBvdXQgb24gdGhlIG1haWxpbmcg
bGlzdC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2JwZi9DQUVmNEJ6YmdmLVdRU0N6OEQ0T21oM3pGZFM0b1dTNlhFTG5FN1Zlb1VXZ0tmM2NwaWdA
bWFpbC5nbWFpbC5jb20vDQo+ID4gPiA+DQo+ID4gPiA+IFF1aWNrIGNvbW1lbnQgcmVnYXJkaW5n
IHNoaWZ0IG91dCBvZiBib3VuZCBpc3N1ZS4NCj4gPiA+ID4gSSB0aGluayB0aGlzIHBhdGNoIHNl
dCBtYWtlcyBIYW8gU3VuJ3MgcmVwcm8gbm90IHdvcmtpbmcsIGJ1dCBJIGRvbid0IHRoaW5rDQo+
ID4gPiA+IHRoZSByYW5nZSB2cyByYW5nZSBpbXByb3ZlbWVudCBmaXhlcyB0aGUgdW5kZXJseWlu
ZyBpc3N1ZS4NCj4gPiA+DQo+ID4gPiBDb3JyZWN0LCB5ZXMsIEkgdGhpbmsgYWRqdXN0X3JlZ19t
aW5fbWF4X3ZhbHMoKSBtaWdodCBzdGlsbCBuZWVkIHNvbWUgZml4aW5nLg0KPiA+ID4NCj4gPiA+
ID4gQ3VycmVudGx5IHdlIGRvOg0KPiA+ID4gPiBpZiAodW1heF92YWwgPj0gaW5zbl9iaXRuZXNz
KQ0KPiA+ID4gPiAgIG1hcmtfcmVnX3Vua25vd24NCj4gPiA+ID4gZWxzZQ0KPiA+ID4gPiAgIGhl
cmUgd2VyZSB1c2Ugc3JjX3JlZy0+dTMyX21heF92YWx1ZSBvciBzcmNfcmVnLT51bWF4X3ZhbHVl
DQo+ID4gPiA+IEkgc3VzcGVjdCB0aGUgaW5zbl9iaXRuZXNzIGNoZWNrIGlzIGJ1Z2d5IGFuZCBp
dCdzIHN0aWxsIHBvc3NpYmxlIHRvIGhpdCBVQlNBTiBzcGxhdCB3aXRoDQo+ID4gPiA+IG91dCBv
ZiBib3VuZHMgc2hpZnQuIEp1c3QgbmVlZCB0byB0cnkgaGFyZGVyLg0KPiA+ID4gPiBpZiB3OCA8
IDB4ZmZmZmZmZmYgZ290byArMjsNCj4gPiA+ID4gaWYgcjggIT0gcjYgZ290byArMTsNCj4gPiA+
ID4gdzAgPj49IHc4Ow0KPiA+ID4gPiB3b24ndCBiZSBlbm91Z2ggYW55bW9yZS4NCj4gPiA+DQo+
ID4gPiBBZ3JlZWQsIGJ1dCBJIGZlbHQgdGhhdCBmaXhpbmcgYWRqdXN0X3JlZ19taW5fbWF4X3Zh
bHMoKSBpcyBvdXQgb2YNCj4gPiA+IHNjb3BlIGZvciB0aGlzIGFscmVhZHkgbGFyZ2UgcGF0Y2gg
c2V0LiBJZiBzb21lb25lIGNhbiB0YWtlIGEgZGVlcGVyDQo+ID4gPiBsb29rIGludG8gcmVnIGJv
dW5kcyBmb3IgYXJpdGhtZXRpYyBvcGVyYXRpb25zLCBpdCB3b3VsZCBiZSBncmVhdC4NCj4gPiA+
DQo+ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgb25lIG9mIHRob3NlIGFjYWRlbWljIHBhcGVycyBj
bGFpbWVkIHRvIHZlcmlmeQ0KPiA+ID4gc291bmRuZXNzIG9mIHZlcmlmaWVyJ3MgcmVnIGJvdW5k
cywgc28gSSB3b25kZXIgd2h5IHRoZXkgbWlzc2VkIHRoaXM/DQo+ID4NCj4gPiBBRkFJQ1MsIGl0
IHNob3VsZCBoYXZlIGJlZW4gYWJsZSB0byBkZXRlY3QgdGhpcyBidWcuIEVxdWF0aW9uICgzKSBm
cm9tDQo+ID4gWzEsIHBhZ2UgMTBdIGVuY29kZXMgdGhlIHNvdW5kbmVzcyBjb25kaXRpb24gZm9y
IGNvbmRpdGlvbmFsIGp1bXBzIGFuZA0KPiA+IHRoZSBpbXBsZW1lbnRhdGlvbiBkZWZpbml0ZWx5
IGNvdmVycyBCUEZfSkVRL0pORSBhbmQgdGhlIGxvZ2ljIGluDQo+ID4gY2hlY2tfY29uZF9qbXBf
b3AuIFNvIGVpdGhlciB0aGVyZSdzIGEgYnVnIGluIHRoZSBpbXBsZW1lbnRhdGlvbiBvciBJJ20N
Cj4gPiBtaXNzaW5nIHNvbWV0aGluZyBhYm91dCBob3cgaXQgd29ya3MuIExldCBtZSBjYyB0d28g
b2YgdGhlIHBhcGVyJ3MNCj4gPiBhdXRob3JzIDopDQo+ID4NCj4gPiBIYXJpLCBTcmluaXZhczog
SGFvIFN1biByZWNlbnRseSBkaXNjb3ZlcmVkIGEgYnVnIGluIHRoZSByYW5nZSBhbmFseXNpcw0K
PiA+IGxvZ2ljIG9mIHRoZSB2ZXJpZmllciwgd2hlbiBjb21wYXJpbmcgdHdvIHVua25vd24gc2Nh
bGFycyB3aXRoDQo+ID4gbm9uLW92ZXJsYXBwaW5nIHJhbmdlcy4gU2VlIFsyXSBmb3IgRWR1YXJk
IFppbmdlcm1hbidzIGV4cGxhbmF0aW9uLiBJdA0KPiA+IHNlZW1zIHRvIGhhdmUgZXhpc3RlZCBm
b3IgYSB3aGlsZS4gQW55IGlkZWEgd2h5IEFnbmkgZGlkbid0IHVuY292ZXIgaXQ/DQo+ID4NCj4g
PiAxIC0gaHR0cHM6Ly9oYXJpc2hhbmthcnYuZ2l0aHViLmlvL2Fzc2V0cy9maWxlcy9hZ25pLWNh
djIzLnBkZg0KPiA+IDIgLSBodHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvODczMTE5NmM5YTg0
N2ZmMzUwNzNhMjAzNDY2MmQzMzA2Y2VhODA1Zi5jYW1lbEBnbWFpbC5jb20vDQo+ID4NCj4gPiA+
IGNjIFBhdWwsIG1heWJlIGhlIGNhbiBjbGFyaWZ5IChhbmQgYWxzbywgUGF1bCwgcGxlYXNlIHRy
eSB0byBydW4gYWxsDQo+ID4gPiB0aGF0IGZvcm1hbCB2ZXJpZmljYXRpb24gbWFjaGluZXJ5IGFn
YWluc3QgdGhpcyBwYXRjaCBzZXQsIHRoYW5rcyEpDQo+ID4NCg0KVGhhbmtzIFBhdWwgZm9yIGJy
aW5naW5nIHRoaXMgdG8gb3VyIG5vdGljZSwgYW5kIGZvciB0aGUgdmFsdWFibGUgY2xhcmlmaWNh
dGlvbnMNCnlvdSBwcm92aWRlZC4gVGhlIGJ1ZyBkaXNjb3ZlcmVkIGJ5IEhhbyBTdW4gb2NjdXJz
IG9ubHkgZHVyaW5nIHZlcmlmaWNhaXRvbiwNCndoZW4gdGhlIHZlcmlmaWVyIGZvbGxvd3Mgd2hh
dCBpcyBlc3NlbnRpYWxseSBkZWFkIGNvZGUuIEFuIGV4ZWN1dGlvbiBvZiB0aGUNCmV4YW1wbGUg
ZUJQRiBwcm9ncmFtIGNhbm5vdCBtYW5pZmVzdCBhIG1pc21hdGNoIGJldHdlZW4gdGhlIHZlcmlm
aWVyJ3MgYmVsaWVmcw0KYWJvdXQgdGhlIHZhbHVlcyBpbiByZWdpc3RlcnMgYW5kIHRoZSBhY3R1
YWwgdmFsdWVzIGR1cmluZyBleGVjdXRpb24uIEFzIHN1Y2gsDQp0aGUgZXhhbXBsZSBlQlBGIHBy
b2dyYW0gY2Fubm90IGJlIHVzZWQgdG8gYWNoaWV2ZSBhbiBhY3R1YWwgdmVyaWZpZXIgYnlwYXNz
Lg0KDQpBcyBwb2ludGVkIG91dCBieSBFZHVhcmQgWmluZ2VybWFuIGluIHRoZSBtYWlsaW5nIGxp
c3QgdGhyZWFkLCB0aGUgaXNzdWUgYXJpc2VzDQp3aGVuIHRoZSB2ZXJpZmllciBmb2xsb3dzIHRo
ZSBmYWxzZSAoc2ltaWxhcmx5IHRydWUpIGJyYW5jaCBvZiBhDQpqdW1wLWlmLW5vdC1lcXVhbCAo
c2ltaWxhcmx5IGp1bXAtaWYtZXF1YWwpIGluc3RydWN0aW9uLCB3aGVuIGl0IGlzIG5ldmVyDQpw
b3NzaWJsZSB0aGF0IHRoZSBqdW1wIGNvbmRpdGlvbiBpcyBmYWxzZSAoc2ltaWxhcmx5IHRydWUp
LiBXaGlsZSBpdCBpcyBva2F5IGZvcg0KdGhlIHZlcmlmaWVyIHRvIGZvbGxvdyBkZWFkIGNvZGUg
Z2VuZXJhbGx5LCBpdCBzbyBoYXBwZW5zIHRoYXQgdGhlIGxvZ2ljIGl0IHVzZXMNCnRvIHVwZGF0
ZSB0aGUgcmVnaXN0ZXJzIHJhbmdlcyBkb2VzIG5vdCB3b3JrIGluIHRoaXMgc3BlY2lmaWMgY2Fz
ZSwgYW5kIGVuZHMgdXANCnZpb2xhdGluZyBvbmUgb2YgdGhlIGludmFyaWFudHMgaXQgaXMgc3Vw
cG9zZWQgdG8gbWFpbnRhaW4gKGEgPD0gYiBmb3IgYSByYW5nZQ0KW2EsIGJdKS4NCg0KQWduaSdz
IHZlcmlmaWNhdGlvbiBjb25kaXRpb24gWzFdIGlzIHN0cmljdGVyLiBJdCBmb2xsb3dzIHRoZSBm
YWxzZSAoc2ltaWxhcmx5DQp0cnVlKSBicmFuY2ggb2YgYSBqdW1wLWlmLW5vdC1lcXVhbCAoc2lt
aWxhcmx5IGp1bXAtaWYtZXF1YWwpIGluc3RydWN0aW9uICpvbmx5Kg0Kd2hlbiBpdCBpcyBwb3Nz
aWJsZSB0aGF0IHRoZSByZWdpc3RlcnMgYXJlIGVxdWFsIChzaW1pbGFybHkgbm90IGVxdWFsKS4g
SW4NCmVzc2VuY2UsIEFnbmkgZGlzY2FyZHMgdGhlIHJlcG9ydGVkIHZlcmlmaWVyIGJ1ZyBhcyBh
IGZhbHNlIHBvc2l0aXZlLg0KDQpXZSBjYW4gZWFzaWx5IHdlYWtlbiBBZ25pJ3MgdmVyaWZpY2F0
aW9uIGNvbmRpdGlvbiB0byBkZXRlY3Qgc3VjaCBidWdzLiBXZQ0KbW9kaWZpZWQgQWduaSdzIHZl
cmlmaWNhdGlvbiBjb25kaXRpb24gWzJdIHRvIGZvbGxvdyBib3RoIHRoZSBicmFuY2hlcyBvZiBh
DQpqdW1wLWlmLW5vdC1lcXVhbCBpbnN0cnVjdGlvbiwgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIGl0
IGlzIHBvc3NpYmxlIHRoYXQgdGhlDQpyZWdpc3RlcnMgY2FuIGJlIGVxdWFsLiBJbmRlZWQsIHRo
ZSBtb2RpZmllZCB2ZXJpZmljYXRpb24gY29uZGl0aW9uIHByb2R1Y2VkIHRoZQ0KdW1pbiA+IHVt
YXggdmVyaWZpZXIgYnVnIGZyb20gSGFvJ3MgZXhhbXBsZS4gVGhlIGV4YW1wbGUgcHJvZHVjZWQg
YnkgQWduaSwgYW5kDQphbiBleHRlbmRlZCBkaXNjdXNzaW9uIGNhbiBiZSBmb3VuZCBhdCBBZ25p
J3MgaXNzdWUgdHJhY2tlciBbM10uDQoNClsxXSBodHRwczovL3VzZXItaW1hZ2VzLmdpdGh1YnVz
ZXJjb250ZW50LmNvbS84NTg4NjQ1LzI4MDkxNzg4Mi1kYzk3MDkwZC0wNDBhLTQzYjAtOWJmOC04
MDYwODE5OTI3MTYucG5nDQpbMl0gaHR0cHM6Ly91c2VyLWltYWdlcy5naXRodWJ1c2VyY29udGVu
dC5jb20vODU4ODY0NS8yODA5MjU3NTYtMTkzMzYwODctODM2Zi00NWU1LTg3ZmItYzI0NTM1NThk
ZjA2LnBuZw0KWzNdIGh0dHBzOi8vZ2l0aHViLmNvbS9icGZ2ZXJpZi9lYnBmLXJhbmdlLWFuYWx5
c2lzLXZlcmlmaWNhdGlvbi1jYXYyMy9pc3N1ZXMvMTUjaXNzdWVjb21tZW50LTE3OTc4NTgyNDUN
Cg0KPiA+IEkgdHJpZWQgaXQgeWVzdGVyZGF5IGJ1dCBhbSBydW5uaW5nIGludG8gd2hhdCBsb29r
cyBsaWtlIGEgYnVnIGluIHRoZQ0KPiA+IExMVk0gSVIgdG8gU01UIGNvbnZlcnNpb24uIFByb2Jh
Ymx5IG5vdCBzb21ldGhpbmcgSSBjYW4gZml4IG15c2VsZg0KPiA+IHF1aWNrbHkgc28gSSdsbCBu
ZWVkIGhlbHAgZnJvbSBIYXJpICYgY28uDQo+ID4NCj4gPiBUaGF0IHNhaWQsIGV2ZW4gd2l0aG91
dCB5b3VyIHBhdGNoc2V0LCBJJ20gcnVubmluZyBpbnRvIGFub3RoZXIgaXNzdWUNCj4gPiB3aGVy
ZSB0aGUgZm9ybWFsIHZlcmlmaWNhdGlvbiB0YWtlcyBzZXZlcmFsIHRpbWVzIGxvbmdlciAodXAg
dG8gd2Vla3MNCj4gPiAvb1wpIHNpbmNlIHY2LjQuDQo+ID4NCg0KSSdtIGxvb2tpbmcgaW50byB0
aGlzIG5leHQsIHRoYW5rcyBmb3IgdGhlIGhlYWRzIHVwIQ0KDQo+IFRoYXQncyB1bmZvcnR1bmF0
ZS4gSWYgeW91IGZpZ3VyZSB0aGlzIG91dCwgSSdkIHN0aWxsIGJlIGludGVyZXN0ZWQgaW4NCj4g
ZG9pbmcgYW4gZXh0cmEgY2hlY2suIE1lYW53aGlsZSBJJ20gd29ya2luZyBvbiBkb2luZyBtb3Jl
IHNhbml0eQ0KPiBjaGVja3MgaW4gdGhlIGtlcm5lbCAoYW5kIGluZXZpdGFibHkgaGF2aW5nIHRv
IGRlYnVnIGFuZCBmaXggaXNzdWVzLA0KPiBzdGlsbCB3b3JraW5nIG9uIHRoaXMpLg0K


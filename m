Return-Path: <bpf+bounces-9860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D979DFB1
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05040282000
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF0156F4;
	Wed, 13 Sep 2023 06:10:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39AA45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:10:20 +0000 (UTC)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2043.outbound.protection.outlook.com [40.107.12.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D9172A
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ0DFfcWMllWPxZ1PXRhmOosrIzEOt3hoe1L4wxILCy1+FIp258HpwhaAnlX06XHFCKYdh3YGIRi0NTUomOqAEfYeYvH8voA1mRsR6MDnY/Uo38tOCdHYAULqgZZcz/bZLXRXgMfw4CX2r+CwBiSvLgTNWpi4Al4rJB6k5Fi8IGMuN/TXmoJgQ/WMN/ZFQEpP4or6e5GJ5Wg83TbJW1/nUyLntxYIcoAmNvBVv5VHLnzURp9HZBFYfKF7ONDkgwfqfqtcCubFG8s1PjSDF4ogMF2YSb0HcXB9o6b6QhFpOtGBWTdolfy8u2uwKfyUeMy243rgamQQ7NeuB5OlI5gTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtEcwmvdq4FPzdNPs2MTC4awqrljYB4CpqFxRng4fAc=;
 b=nPEeR8GjIvvyEbq7JP4Baf0vkQyXKfk6/UntsUwvcuJ4e18584lqqQz0+1GRKmPRzjiKcJMbWYQhlKW70zfDbFH/G5FvNKUapLaxGuOU493l2eu4dGeAjH58HxviUsNKLMCuDfKwWoz3bvYMu9YPDzOTaYmyjdsWkREQe4OgAiUMoh1l36vapimx/9iSUfcI0LxqbD17OlPZ8Yk69sJ6ArL5jQ9LHITPHktL+xkrkTmrMH97VZRg/4zNp8jbh7AdWQLWKyIt1gWiNoKymzyc9zdMbXurTGnQ/0NcEpi/RUPpnyJe9Cy8Ji7UU8D+dDDtNy3vRRNI11OHkL5M9Vut6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtEcwmvdq4FPzdNPs2MTC4awqrljYB4CpqFxRng4fAc=;
 b=A31h6U8/j/9anUH7mXafV7maC/Qt9ONqd/p4vOyjdPakUOBvQ39h5cf33S8j9zb1eZk+hs2j6Hvu3Egmvq4tff/if8qpmCJDuca6l9h4acVAgy5kAuozH2BzwT1vd/zQgOcJUG2AMrAPbJpECB6uVPEkN60Z2bmnV1FZ47uRc2aJrqekFMrp4SBICfqSt4CH3eTapGV5nJ6fqYiaI78JW/Wqgc6AZGSmw6vWu8Ph1notuyydwkGDoI6TesU0CNhtAzlkd/0TTfsIYNJtgl/BdJz5KQYCsZ9j9R5SRjcWeXcTgwoILjK0QMSnioVyz4+6oQCooeEofVxFQRz4UetOTw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 06:10:16 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:10:16 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>
CC: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
Thread-Topic: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
Thread-Index: AQHZ4d0Rf5x9GNIQg0iJUJHHonYpVrAX0xcAgAAWYQCAAANxgIAAYUoA
Date: Wed, 13 Sep 2023 06:10:16 +0000
Message-ID: <48ff9579-f15d-1623-f7ca-182d4174204c@csgroup.eu>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
 <20230830011128.1415752-2-iii@linux.ibm.com>
 <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
 <mb61p5y4u3ptd.fsf@amazon.com>
 <CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
 <mb61p4jk630a9.fsf@amazon.com>
 <CAADnVQJCc6t82H+iFXvhs=mfg1DMxZ-1PS3DP5h7mtbuCW79qQ@mail.gmail.com>
 <mb61pv8cm0wf9.fsf@amazon.com>
 <CAADnVQ+ccoQrTcOZW_BZXMv2A+uYEYdHqx0tSVgXK31vGS=+gA@mail.gmail.com>
 <CANk7y0hK9sQJ-kRx3nQpVJSxpP=NzzFaLitOYq8=Pb6Dvk9fpg@mail.gmail.com>
 <CAADnVQ+EpYBTGMJ0MBdK8=qKrYseicxpA1AE+BmHu1CFoOPUvQ@mail.gmail.com>
 <CANk7y0g73bZpikgHtV1Z=c+1msE8vzZx9ZWHjJd_6FBFOEZNXQ@mail.gmail.com>
In-Reply-To:
 <CANk7y0g73bZpikgHtV1Z=c+1msE8vzZx9ZWHjJd_6FBFOEZNXQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2025:EE_
x-ms-office365-filtering-correlation-id: 86528131-2ba3-440d-6456-08dbb420197f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7c4xBgolwnkGvLZPisqOt8ZAMxz+px+1mWngp5R0QtpcPMS/G8C8ppC2GygF1o+Qp7l2rkTC26t5rpv0YOlC7D1lHRa64X3dmV1AinYd/IPWakFQxmvfnSZjYuMMyDhy8d/uGH2DBG4BZn4KsKJu16jImaoRoqpH2PrELAgW0h41DK/WJmAC1woaTlEUSaoKguvwESTv7T9XESFYXfHCjyxt5+/Ws4aWYHnPzcZl8eYWbZ+4C6ZeLws1jKHf9hclEdwgnGOo/IrjM8UoFYPXZDfK9ZoIxDwyRGpWDB9h6ZpIJIyc6bRuNXLx1Zz9YhzeQS+95VeaLVS0dE1Qbp8W0jBhR+nveH2QP1aOUV2x9FYr8N2RILRoNDN6P+TmVQSpd0DyXz/494VzTq3KpcW2gBmzNAzxXnzdtRHwbkJUhLYQF14vlVDNYEwlnkOEf8w1j0162yjhg0ScBE0eAplv5qsjviR8f9iQqNtp5WVkXf/Oetl9YmGGQBIj+HEGw353L9NFwwdLY75yrvSAVlMxHuorHQQkiDZQyHN+BgfytWEvDviLPBHjy79Vc08plcWb3O0elgRUTZSaYjMjFipEQvUQDESFaBwTP4ZxjuJJ0Iw6k7JFkMTYUmGeU1Z9rZhxv0TuwRqHpwqiWQnOIHSHOpFMZjlbw/DjATtCy9rwsypsd/1n0c7rVUyEv1XsPvY5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199024)(1800799009)(186009)(31686004)(6506007)(53546011)(71200400001)(6486002)(478600001)(122000001)(38100700002)(38070700005)(2906002)(91956017)(7416002)(110136005)(2616005)(26005)(6512007)(36756003)(86362001)(31696002)(66446008)(76116006)(54906003)(66946007)(64756008)(66476007)(316002)(66556008)(41300700001)(8676002)(4326008)(8936002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b0FJOEFQcmNldlhKOEoxMTNVK2JtU1BnRks2RDJHUm5TVHU4eGFPMzRVZ3V1?=
 =?utf-8?B?UzdGbExpb1p6Ui96N2hWTzh3bXVDYSt1aUZxZ05kdjhzUjQ1UncySXZOVkhK?=
 =?utf-8?B?SWl5Ni9OUlBTa3A0aHJEV3c4K0IvWDluZE9DeE1nRGplSng2Mm4zcXNMR0ZH?=
 =?utf-8?B?Ry8zaEY5em9FL1BKL3J1NlhiWlFYUzFSK0FzZ082UGoxYi8rRkxqVWN4UHE4?=
 =?utf-8?B?ZEFISUlpSDNGWTFQZWxFQ1JOV1plMVlPSWJLNTVTNUJOc1l4bG4yTmh5WkdT?=
 =?utf-8?B?bFhnV0wvNENPQ0NZb1Zkd3oxcWp6S2dWZmFhUTFqVDRLallPYlNHRG9PUU5J?=
 =?utf-8?B?MDFLZlJuazFNNFZPeG1ZQ1liOXVPQkpJTmhBckxjcGdtSUZRcXJzQWRlMTdt?=
 =?utf-8?B?OFhCVUZPZW1qb0NKQWtEM0Y0VDlXSkN2a0J2aUhBNkpPK085Q01rNFZUdFZT?=
 =?utf-8?B?YXpJUVJLcTBKc3BVYTAzWTd4TXZrcDJIcFNVZkNqSXNHVnJ3MUREczZEbjVJ?=
 =?utf-8?B?VDRmREpXSTljWm0raGpyczRFYlpBa2hIckJwak82TmZLWHowTHZzMW9hbmYv?=
 =?utf-8?B?RStnSWdsc3FtRU5ocUR1VHdHSWNGby9JZ0ZCS0tyY3B3Tm5MbHcyNUdySHlh?=
 =?utf-8?B?N09YOEdBNFBzQm93K083UG00ZnZqOHA3UVluaVV1SEpBbHVRVWhCbVBmR1pN?=
 =?utf-8?B?bWhRRlJRYVNnSVhUZmsrZEQ0eVphVGZVUlY2SHY1UzVWYnc2M3RNOGo4WTdk?=
 =?utf-8?B?SUZ3M3FpSzRRcmpRZnZ1VWVBT2lZYnpMR3Z1ejMrUGp5MVZHdkNOT3hVTWVW?=
 =?utf-8?B?SnpNeWZOaW9ERzU3WVhxUTl0VTFXZHAyTE5aQVd1TGo3RlZQM0RDeW1abkpt?=
 =?utf-8?B?ZzVUSjEwVWNJYzBLejZFTHhJS3A4cUlxa2p1TXZxdDczcjhzQy9vVXY4amlM?=
 =?utf-8?B?TUJnSWJYRXhWMWRvM2UwanB5cFNQLzczcnRrUWhtWTdrNG0wTUN5VlVNa3My?=
 =?utf-8?B?eGk5aFAyM21HaU9MK205NkEyWTlDbkJGbDZUM2VLUEJ2U3p5MG9LaE9hMlZu?=
 =?utf-8?B?bjVUKzB2Vkk1NlJaYlFnOE9CVUw1ZTlIWEdUOStYTUUyVm9KNjFFNG9kQUhY?=
 =?utf-8?B?RW5hVnhZcjFCcjJwa0czUng4aCs5anRmNEd0dXFaamI1b1NtR3VmbVNORUVk?=
 =?utf-8?B?R0dMcUdkaWJiNTdqaURFZ2dKNHFRY2RDUXQvbklHZnBBSGNUZlpLNnhJZGVh?=
 =?utf-8?B?N2ZQSElGS0RGVnlSd3JrSjVGTUU1V0REdmZoN2JKT2VRRXRyamlBait5QnZF?=
 =?utf-8?B?Q1BPK3RSRDJlMDU0Zkd6eFpZRHdmVXlpNmI0Zzc4QUtxVC9QZnZVREZXT2Zv?=
 =?utf-8?B?TUM1MVVDRjM0bGV1dE80NWRBRHZJNTNwdzBrOXdaU3l4d2MrdnBqd0JZb0RK?=
 =?utf-8?B?M3kyZVB2ajJXVld5enBYSUE3NWh1bEcyUUNoak5hQ2V0REY0ZjVPS05TQmVK?=
 =?utf-8?B?U3JQZ0dTVFN3bmUwQkVzQmhXbEVpMWxnblk4cjZyU3g4QlVXYm4raFVWSkJT?=
 =?utf-8?B?UC9HbGVFKzhrdTlVa044TFRGcWhOZndrS2xobHVjdGUwS2pmMG9qQlE1d21i?=
 =?utf-8?B?RXNpeERQNFRuQXBxUXptenhhRWhGajQvK3RuY2pOclQxU0lmeW1yWUZYdDBC?=
 =?utf-8?B?RU5uNVlld2tnR3NFUDNQRVFNY2M2OVZaM0ZvS0hDTnkyV3laZkhRTDlveHFE?=
 =?utf-8?B?TGd1NWhub3FwVlRzd2t4K250ZjkxckpXZkZuWlIxdnFhTDZZa0x6cFFQNExn?=
 =?utf-8?B?NjdPM2Q3cDVONlgyS25yOEhBV3NRYlJ2YkdpRUNqQkE3U1oyTEtjQ3FCOEZp?=
 =?utf-8?B?N1BUMTVrblFJNUNsTjM1MDdCQi9reEhjL3ZwTHArMFBsRXVpMzNRWDlRbmpP?=
 =?utf-8?B?dDlTTWJ1RU5PNS90WEcvaVhDRlZwVXNZTFZhb3RXaE9VMDVzZ25JRXdVaUUy?=
 =?utf-8?B?cVZLWnRYeHJtS3N6OXc3R1Uyb1RRTkY2N2FBVjVmdUlGUHk3MUhFajluZnVV?=
 =?utf-8?B?MDNjSVpuR2pHODRxT1RyZDlDOHBDeS9xbU4rRU8yUDhhMkIyb0NEYU5aK2ds?=
 =?utf-8?B?elJNblA4K3BDcHkwSjl3WVB2b1JQZEZmekdmRHljb2VFckk3aWxmZUpRMk4z?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C37BFDD1053C5498EADA9FC92263121@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86528131-2ba3-440d-6456-08dbb420197f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 06:10:16.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fx8/JFxUjbmdA28d01k4aEbzZjtQ+sNtyu1OhDWXDBsHk4gFmsOkjAMZA0AXwnCttrDlMOXE+73m1DLGkTnM7kYP5P78x7Wee037k4piITQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2025

DQoNCkxlIDEzLzA5LzIwMjMgw6AgMDI6MjIsIFB1cmFuamF5IE1vaGFuIGEgw6ljcml0wqA6DQo+
IE9uIFdlZCwgU2VwIDEzLCAyMDIzIGF0IDI6MDnigK9BTSBBbGV4ZWkgU3Rhcm92b2l0b3YNCj4g
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIFR1ZSwgU2Vw
IDEyLCAyMDIzIGF0IDM6NDnigK9QTSBQdXJhbmpheSBNb2hhbiA8cHVyYW5qYXkxMkBnbWFpbC5j
b20+IHdyb3RlOg0KPj4+DQo+Pj4gSGkgQWxleGVpLA0KPj4+DQo+Pj4gWy4uLl0NCj4+Pg0KPj4+
PiBJIGd1ZXNzIHdlIG5ldmVyIGNsZWFybHkgZGVmaW5lZCB3aGF0ICduZWVkc196ZXh0JyBpcyBz
dXBwb3NlZCB0byBiZSwNCj4+Pj4gc28gaXQgd291bGRuJ3QgYmUgZmFpciB0byBjYWxsIDMyLWJp
dCBKSVRzIGJ1Z2d5Lg0KPj4+PiBCdXQgd2UgYmV0dGVyIGFkZHJlc3MgdGhpcyBpc3N1ZSBub3cu
DQo+Pj4+IFRoaXMgMzItYml0IHplcm9pbmcgYWZ0ZXIgTERYIGh1cnRzIG1pcHM2NCwgczM5MCwg
cHBjNjQsIHJpc2N2NjQuDQo+Pj4+IEkgYmVsaWV2ZSBhbGwgNCBKSVRzIGVtaXQgcHJvcGVyIHpl
cm8gZXh0ZW5zaW9uIGludG8gNjQtYml0IHJlZ2lzdGVyDQo+Pj4+IGJ5IHVzaW5nIHNpbmdsZSBj
cHUgaW5zdHJ1Y3Rpb24sDQo+Pj4+IGJ1dCB0aGV5IGFsc28gZGVmaW5lIGJwZl9qaXRfbmVlZHNf
emV4dCgpIGFzIHRydWUsDQo+Pj4+IHNvIGV4dHJhIEJQRl9aRVhUX1JFRygpIGlzIGFkZGVkIGJ5
IHRoZSB2ZXJpZmllcg0KPj4+PiBhbmQgaXQgaXMgYSBwdXJlIHJ1bi10aW1lIG92ZXJoZWFkLg0K
Pj4+DQo+Pj4gSSBqdXN0IHJlYWxpc2VkIHRoYXQgdGhlc2UgemV4dCBpbnN0cnVjdGlvbnMgd2ls
bCBub3QgYmUgYSBydW50aW1lDQo+Pj4gb3ZlcmhlYWQgYmVjYXVzZSB0aGUgSklUcyBpZ25vcmUg
dGhlbS4NCj4+PiBMaWtlDQo+Pj4gczM5MCBkb2VzOg0KPj4+IGNhc2UgQlBGX0xEWCB8IEJQRl9N
RU0gfCBCUEZfQjogLyogZHN0ID0gKih1OCAqKSh1bCkgKHNyYyArIG9mZikgKi8NCj4+PiBjYXNl
IEJQRl9MRFggfCBCUEZfUFJPQkVfTUVNIHwgQlBGX0I6DQo+Pj4gICAgICAgICAgLyogbGxnYyAl
ZHN0LDAob2ZmLCVzcmMpICovDQo+Pj4gICAgICAgICAgRU1JVDZfRElTUF9MSCgweGUzMDAwMDAw
LCAweDAwOTAsIGRzdF9yZWcsIHNyY19yZWcsIFJFR18wLCBvZmYpOw0KPj4+ICAgICAgICAgIGpp
dC0+c2VlbiB8PSBTRUVOX01FTTsNCj4+PiAgICAgICAgICBpZiAoaW5zbl9pc196ZXh0KCZpbnNu
WzFdKSkNCj4+PiAgICAgICAgICAgICAgICAgIGluc25fY291bnQgPSAyOyAvKiB0aGlzIHdpbGwg
c2tpcCB0aGUgbmV4dCB6ZXh0IGluc3RydWN0aW9uICovDQo+Pj4gICAgICAgICAgYnJlYWs7DQo+
Pj4NCj4+PiBwb3dlcnBjIGRvZXMgYWZ0ZXIgTERYOg0KPj4+IGlmIChzaXplICE9IEJQRl9EVyAm
JiBpbnNuX2lzX3pleHQoJmluc25baSArIDFdKSkNCj4+PiAgICAgICAgICBhZGRyc1srK2ldID0g
Y3R4LT5pZHggKiA0Ow0KPj4NCj4+DQo+PiBJIHNlZS4gSW5kZWVkIHRoZSA2NC1iaXQgSklUcyBp
Z25vcmUgdGhpcyBzcGVjaWFsIHpleHQgaW5zbiBhZnRlciBMRFguDQo+Pg0KPj4+PiBJdCdzIGJl
dHRlciB0byByZW1vdmUNCj4+Pj4gaWYgKHQgIT0gU1JDX09QKQ0KPj4+PiAgICAgIHJldHVybiBC
UEZfU0laRShjb2RlKSA9PSBCUEZfRFc7DQo+Pj4+IGZyb20gaXNfcmVnNjQoKSB0byBhdm9pZCBh
ZGRpbmcgQlBGX1pFWFRfUkVHKCkgaW5zbg0KPj4+PiBhbmQgZml4IDMyLWJpdCBKSVRzIGF0IHRo
ZSBzYW1lIHRpbWUuDQo+Pj4+IFJJU0NWMzIsIFBvd2VyUEMzMiwgeDg2LTMyIEpJVHMgZml4ZWQg
aW4gdGhlIGZpcnN0IDMgcGF0Y2hlcw0KPj4+PiB0byBhbHdheXMgemVybyB1cHBlciAzMi1iaXQg
YWZ0ZXIgTERYIGFuZA0KPj4+PiB0aGVuIDR0aCBwYXRjaCB0byByZW1vdmUgdGhlc2UgdHdvIGxp
bmVzLg0KPj4+DQo+Pj4gSSBoYXZlIHNlbnQgdGhlIHBhdGNoZXMgZm9yIGFib3ZlLCBhbHRob3Vn
aCBJIHRoaW5rIHRoaXMgb3B0aW1pemF0aW9uDQo+Pj4gaXMgdXNlZnVsIGJlY2F1c2UNCj4+PiB6
ZXJvIGV4dGVuc2lvbiBhZnRlciBMRFggaXMgb25seSByZXF1aXJlZCB3aGVuIHRoZSBsb2FkZWQg
dmFsdWUgaXMNCj4+PiBsYXRlciBiZWluZyB1c2VkIGFzDQo+Pj4gYSA2NC1iaXQgdmFsdWUuIElm
IGl0IGlzIG5vdCB0aGUgY2FzZSB0aGVuIHRoZSB2ZXJpZmllciB3aWxsIG5vdCBlbWl0DQo+Pj4g
dGhlIHpleHQgYW5kIDMyLWJpdCBKSVRzIHdpbGwgZW1pdA0KPj4+IDEgbGVzcyBpbnN0cnVjdGlv
biBiZWNhdXNlIHRoZXkgZXhwZWN0IHRoZSB2ZXJpZmllciB0byBkbyB0aGUgemV4dCBmb3INCj4+
PiB0aGVtIHdoZXJlIHJlcXVpcmVkLg0KPj4NCj4+IFlvdSdyZSBjb3JyZWN0Lg0KPj4gT2suIExl
dCdzIGtlZXAgemV4dCBmb3IgTERYIGFzLWlzLg0KPiANCj4gWWVzLA0KPiBsZXQncyBkbw0KPiAg
ICAgICAgICBpZiAoY2xhc3MgPT0gQlBGX0xEWCkgew0KPiAgICAgICAgICAgICAgICAgIGlmICh0
ICE9IFNSQ19PUCkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEJQRl9TSVpFKGNv
ZGUpID09IEJQRl9EVzsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIChCUEZfU0la
RShjb2RlKSA9PSBCUEZfRFcgfHwNCj4gQlBGX01PREUoY29kZSkgPT0gQlBGX01FTVNYKTsNCg0K
WW91IGRvbid0IG5lZWQgdGhlIHBhcmVudGhlc2lzLCBqdXN0IGRvDQoNCglyZXR1cm4gQlBGX1NJ
WkUoY29kZSkgPT0gQlBGX0RXIHx8IEJQRl9NT0RFKGNvZGUpID09IEJQRl9NRU1TWDsNCg0KDQpD
aHJpc3RvcGhlDQo=


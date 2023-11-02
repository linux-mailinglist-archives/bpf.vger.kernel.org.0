Return-Path: <bpf+bounces-14001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374D7DF9A4
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE148B211CE
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1882111C;
	Thu,  2 Nov 2023 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JLc/Xsgr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55C21111
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 18:12:01 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5307218E
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 11:11:45 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A2F3x4E024344
	for <bpf@vger.kernel.org>; Thu, 2 Nov 2023 11:11:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=UrPwGGQRauw7xh/9TbhvgKlEWQbNA5HaFj/WM4BhJow=;
 b=JLc/XsgrTCbonmb0LfZzTCMEO1tNCD09I2Wrnp0s9LAZLjVWRZVnHcEUucLnK/vph3sc
 B3ICXj5QD8HCqbm2T/7dOScldb1yXPa1E1TAPbEl0B982BCSaatR+AnRT+3xnJr1SAH3
 MEsdGkSMEFwWk+WbkQdsK6tAmQVu4w/Kz5rGYw5/FnqasPrek+BDWB1cq2ffHCKreons
 LZ6NZsMFot17LIcj1wNMCV0b3v0muLW/PT5uurl/qzrcEsGsNS25vyM7yxYxFQf/pKPx
 Pwhp3VUhq/Iy3hlEZU3zjxOX244t2l+04C0gmK2QmvunCB64q7t5R7k6CYeU0A+MW6lK Dw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u44f84wwm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 11:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBs+nyrHtX0Zxuk3gmUjqSS+akzTR1bsUo0yjHgHWcK28RqL7/YIUqxxaJwHfNr6BtQXTbs44Jug+ptv/pucw6sxAOL1RDoR4s5IL9iy+xMgCdBPZYvNNLxBC7yF4n7t3VvbOFdvKyWO5JjcVtjpt+SxEaf6QZLK8ku+ygeXX+9nrWjVpt+pZ+QhxXlZuQCy+AYLC9/AdonieMF5XzPEtrl/P3+jtTg1laIpqJOjl5V94p6YZ9vIpYAcAcLNje4qXsdqdieeqpcp47TUXKoASaWkEVnyyGSRGjY8G+XHRLyznh+5xZryNz+wS4R3wvEAJ9na3Ms9+h0HN4DDuCcTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrPwGGQRauw7xh/9TbhvgKlEWQbNA5HaFj/WM4BhJow=;
 b=DylxFHz9vWfjW3BS9UyhdktQG6Ij8IAP+7QUPpJI24PFYPhPZBuenhiaOkDqlP1UIDtgsJwSY5g5klDvUaDJgEG0sVZ4b2EhcWp2b/xE22i5xq0N921BC1wCJnfBcNGGnr6kLUKrcJ/P+Zacm+c+M1EIOaoQSGUilaCnqS73AidiHBrstgfUe/TM68hru0E9ZRM1+/8BMhFB+PDgZthOJnfntgglsolJXOUNkPgJcCsVF3zXC6CP6Tv0voBBxLZmOwF948Fi2bQ/7xBavCNpZq6dGv1WZKZnA0Uh+UFKshrSJZ3g7T/Z5nVAai9vUf6R0f4kGwzOSimBFDiiQReKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5117.namprd15.prod.outlook.com (2603:10b6:510:c4::8)
 by MW5PR15MB5241.namprd15.prod.outlook.com (2603:10b6:303:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15; Thu, 2 Nov
 2023 18:11:40 +0000
Received: from PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::9255:45ad:aadf:e172]) by PH0PR15MB5117.namprd15.prod.outlook.com
 ([fe80::9255:45ad:aadf:e172%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 18:11:40 +0000
From: Song Liu <songliubraving@meta.com>
To: =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
CC: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf] bpf: fix bpf_dynptr_slice() returning ERR_PTR() on
 erro
Thread-Topic: [PATCH bpf] bpf: fix bpf_dynptr_slice() returning ERR_PTR() on
 erro
Thread-Index: AQHaDbHBZHqRRzSzpUuqb84Emmc7W7BnUBUAgAABaYCAAAIjAIAAAQYA
Date: Thu, 2 Nov 2023 18:11:40 +0000
Message-ID: <980EFFAB-A79F-4B18-BCA7-52277939A5DC@fb.com>
References: <20231102172640.3790869-1-andrii@kernel.org>
 <877cn011mj.fsf@toke.dk>
 <CAEf4Bzb4VbH56S2D_5Sc3u9V=OXOy20JTr4wsObBOiUA32Md2Q@mail.gmail.com>
 <874ji4111d.fsf@toke.dk>
In-Reply-To: <874ji4111d.fsf@toke.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5117:EE_|MW5PR15MB5241:EE_
x-ms-office365-filtering-correlation-id: 2e767c78-073b-4043-2f30-08dbdbcf29b0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jLyp12rWlmP55bNcVBb1EzYmA9mZP3KyG5XOxsgffDDSiwps48urz6+FKWwZWquY2cOBuyhg6aLApycZdpBdtHavIsSl1qsFrekLsMHURzQT1psiUbs4DMcOE+87lQAWyg6uQrIBg1ogcaN4j1ZgKHZ5I1ioPCsHV8nI7nADxVwS9LvF+nmqPjwNQwT1sis0yBe45xTdmnsWbsAphCcuYMsA5+u9TUbSOoHUccpRfGEBeUzKe1VKcTPmX0itf9mfVn3OHOQ5++AjJ7RhnmlfUF/47nlbmdgKaiMoZqhvzNQGQ3k24BdkVQfIT+PcaMw00L3ufMRC7P5y+fJyme+fNFHjOCArQ0runJ1SLQmMovgrtTegdQgBsS4EJecJEnSmIYhL4SzOio5v4gIXHzWlrI8BqCPA66JuEKr43reUgtS9HX2mOsVNUov/QBM4je7p78c0halbTCGMiZYh4NLz5NSGWK5rcNTOvfc6CRIFKyAfsUJP+XANLfNvVqCalQMJOgjxY3wwmffYTXlFcv++5OjZLn/GsuIHHdh90wYn8NKl+V8ELceGbit3dAPoPgv808MhvlM/qxnoSKk0cLic/85+UA0BgiMnq4Jqqc2+EbndaMPWASUdAnHdKUdatCUY
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5117.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(76116006)(66446008)(66946007)(107886003)(64756008)(91956017)(6916009)(66556008)(66476007)(316002)(83380400001)(6486002)(38100700002)(122000001)(6512007)(53546011)(71200400001)(478600001)(9686003)(54906003)(66574015)(5660300002)(8936002)(8676002)(2906002)(41300700001)(4326008)(33656002)(36756003)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?KzZuQVFpZE01ZTl4MHJaM0tQVjlqdlhqc3ZQWGs3eC9wUUREYlI4K21RSFM2?=
 =?utf-8?B?MTF3TEVHRjlldzhqNGJONjJ6a2NoODVDYlJ1QUVBYWliQVhCcTg4aHEzZllJ?=
 =?utf-8?B?dlYzbTFxTStOZTNRWWcrUGQvNC9naEQydUpQT0xJQ2drOUVEV0h0dVBVRzl0?=
 =?utf-8?B?THc4a25iQmtpNTFCT0lhTEFRQklSeDVKY1JEY21uZEtHRUU4Vml2enZMOE9a?=
 =?utf-8?B?MzJOUnhHQlFuUW42WjdwNC9vODZIYTJlV3FBR1F1dHZrK1FnZXlrdlRBWU9Q?=
 =?utf-8?B?L3hsNDVpcjhwZVJMRGhsSUpkdEN4ZnZQOXB4bm93dWFldWQ5N0hMSWNTTGdZ?=
 =?utf-8?B?ejFhWEp0OVgvNFJEaFlpSWkzWHZBTmJ2Z3N4TDJmdVpXYmVNVlZEcHk0R3Nw?=
 =?utf-8?B?V0hjRUt2NkZOYUZTUUZmcUQxOEZseFJpc0MrTlNESXZRa3RoTzdVQmtWNnF6?=
 =?utf-8?B?aWQ1UWY1VXgwaUlrN1pFdWtRTmgzaFQxTmtHWDVkUGJLVWM4WVVoTmo0Wjd1?=
 =?utf-8?B?dW4zSXJuOS9BdU5aeEg0aGUxZGRUNDcyNHozck1ZSUNyUlFjVmZnMm5VZXhV?=
 =?utf-8?B?elFPb2dmdVU3WDBvYks1NDZVd0tlTUZiWlNQaGZwV3NHcjA0UCtXbXZienBF?=
 =?utf-8?B?bVo2YlkzNS9QdGN4L2J6TEJpeEkwK1gxUTMwV0tmYjlHQVN4SVg4WGd4Sk9k?=
 =?utf-8?B?cW9vUjRtSEhheUhSL0hXTm1rMmZRM252SHc2ai8wTHhleDhDR2QyU3hsNTQ4?=
 =?utf-8?B?UHd2UVpPOTAxU2VTL1Q1WEhpd1QwQVhNbmtpV29OcXdtOGErZjhlUWJOTzk3?=
 =?utf-8?B?UjhwVkEzcm9JZXhEMDVTNTdLdGZHZmNHZjlxN3E2Z3NNQzRQUk1ib3paNDBF?=
 =?utf-8?B?VlVuU2hod0c2YUtGbjBsK0hTWW5zYUJtcXkyWnFHVU01d0tzNnlmOUh2Z1NV?=
 =?utf-8?B?ZmoyQWs4Ty94S29aRncyK2RRU0xvNW9WM0lXWDdSbHd1TiswbEFKaGFaUFRo?=
 =?utf-8?B?M1ZtU0VYWmV2NFlpa0x4REVHSzM3Z1ZVQnNlOWZPR2dEVmdmV1c3cXkraHRQ?=
 =?utf-8?B?bXJwK2x0eTVzRDVFOUZxbG5VQnl0ajhqTGN4TjMxZEpFaGF3dUt4ZHJtbGZ5?=
 =?utf-8?B?NTVDTU52NUtkUVRralY5VkpHckRpTENiS2xOWEhNQUVYSWtxS3JoRmlnS3Bw?=
 =?utf-8?B?Q1pId3FjNUViOU0zUDNneGVOZTVmRHAvZVZCUzRGaUFzOFNwbUI3eWJHb0ZV?=
 =?utf-8?B?eGcwOE5jczlCOS9NUG1UZTB2MmZ0ZHdRQXNraWZKaWEzWUxkRXRGS0dPank4?=
 =?utf-8?B?MHo2S0R1UlA3N3E3TEJYTnU1Tzd0ejN2QTRYbmdKYVhaam5DS1N6d2VGN3VN?=
 =?utf-8?B?WDlKZHBHaVVsN0x6UWZUM3VFSDVtcG5HVjJJTXVMUmw1TlZQQWcvYmtocms3?=
 =?utf-8?B?TVk1anFySExxK3ByT0luK01SSWc4UG1iTytEMmpjWW4wbEV0Rnl2UVhGak16?=
 =?utf-8?B?OVY0cjRQSWtYU2FLaWRaNkdNUDRwQWVYeEV5d2d0dWkrN1IvZkthTEdPSXJm?=
 =?utf-8?B?ckF1V0ZvSis4VmFsa3l4bm5BdnRScXVacUg1ZDFQeEpnWUJTSXZ2QkhXdEhL?=
 =?utf-8?B?QWVNaEtpZnljZWFXcFNpK3A1QythV2RHZ1FPam5WRVQ5bXg4ODRsVm9HdXFy?=
 =?utf-8?B?VFNSSWZtV2VwQVU2TEo0YUhYL0ZLMGxiRWY2Ui9nVm4rL1JqN2xJTHFiZG54?=
 =?utf-8?B?b0psYkcrdDM1MGRGSUkxN3lpckNxS2hrZTdiS0JHUmZ6MUFuUE5NM3dsVTJZ?=
 =?utf-8?B?SVJjVVU5YVdWVGJoVUNML2c2TytEZktvWlNFOGNLdlZ2REZCZERoYVBVZjJ1?=
 =?utf-8?B?ckdUcTdub0JmQ1Y3YVFPd3RuUjdJZmJ6MEQzVkp6cmpXVS80dUNTelNxWTNk?=
 =?utf-8?B?Q2tsaWtOcU1FY2RkVzRSejlGN0NoYXNiem1ITjUvbU82TURWd2VzM2M4bUt6?=
 =?utf-8?B?aHNMZHRSWEhQMTBjemRTOFBxZmhoUzBjUVVNYWJoSzdYWDNscko0clRzbUlW?=
 =?utf-8?B?aVZWQVhGOXlVN1BmTnNaQ2pxV2l1SEJ6QTBNVDRFSXFySGJOOWlXQ3BtUzNt?=
 =?utf-8?B?YWdHL0ZKSUxieUpKUHlDMFh1MWdJQU5uWGZ3NVhvMS92RlIxdkVpZitsQ2xC?=
 =?utf-8?Q?Wygo/PBvBr6xy82k7fQRksA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3D55A34D2AF4C4C9CC04889603419CE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5117.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e767c78-073b-4043-2f30-08dbdbcf29b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 18:11:40.6959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTlNU0dY4YoTu52J71djfEgkGFFRQt20AAcj/VvMM65bJ91/pyVHKr4LykFbczFGOzBW11W37/bSB7MSeMwsKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5241
X-Proofpoint-GUID: Qj5lvGoABjlBYoCkXUFP5EVcPvX_W5Fk
X-Proofpoint-ORIG-GUID: Qj5lvGoABjlBYoCkXUFP5EVcPvX_W5Fk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_08,2023-11-02_03,2023-05-22_02

DQoNCj4gT24gTm92IDIsIDIwMjMsIGF0IDExOjA34oCvQU0sIFRva2UgSMO4aWxhbmQtSsO4cmdl
bnNlbiA8dG9rZUBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IEFuZHJpaSBOYWtyeWlrbyA8YW5k
cmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JpdGVzOg0KPiANCj4+IE9uIFRodSwgTm92IDIsIDIw
MjMgYXQgMTA6NTXigK9BTSBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gPHRva2VAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+Pj4gDQo+Pj4gQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWlAa2VybmVsLm9yZz4g
d3JpdGVzOg0KPj4+IA0KPj4+PiBMZXQncyBmaXggaXQgZm9yIHJlYWwgdGhpcyB0aW1lLiBJdCBz
aG91bGRuJ3QganVzdCBkZXRlY3QgRVJSX1BUUigpDQo+Pj4+IHJldHVybiBmcm9tIGJwZl94ZHBf
cG9pbnRlcigpLCBidXQgYWxzbyB0dXJuIHRoYXQgaW50byBOVUxMIHRvIGZvbGxvdw0KPj4+PiBi
cGZfZHlucHRyX3NsaWNlKCkgY29udHJhY3QuDQo+Pj4+IA0KPj4+PiBGaXhlczogNTQyNjcwMGU2
ODQxICgiYnBmOiBmaXggYnBmX2R5bnB0cl9zbGljZSgpIHRvIHN0b3AgcmV0dXJuIGFuIEVSUl9Q
VFIuIikNCj4+Pj4gRml4ZXM6IDY2ZTNhMTNlN2MyYyAoImJwZjogQWRkIGJwZl9keW5wdHJfc2xp
Y2UgYW5kIGJwZl9keW5wdHJfc2xpY2VfcmR3ciIpDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJp
aSBOYWtyeWlrbyA8YW5kcmlpQGtlcm5lbC5vcmc+DQo+Pj4+IC0tLQ0KPj4+PiBrZXJuZWwvYnBm
L2hlbHBlcnMuYyB8IDIgKy0NCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi9oZWxwZXJz
LmMgYi9rZXJuZWwvYnBmL2hlbHBlcnMuYw0KPj4+PiBpbmRleCA1NmIwYzFmNjc4ZWUuLjA0MDQ5
MDk3MTc2YyAxMDA2NDQNCj4+Pj4gLS0tIGEva2VybmVsL2JwZi9oZWxwZXJzLmMNCj4+Pj4gKysr
IGIva2VybmVsL2JwZi9oZWxwZXJzLmMNCj4+Pj4gQEAgLTIzMDksNyArMjMwOSw3IEBAIF9fYnBm
X2tmdW5jIHZvaWQgKmJwZl9keW5wdHJfc2xpY2UoY29uc3Qgc3RydWN0IGJwZl9keW5wdHJfa2Vy
biAqcHRyLCB1MzIgb2Zmc2V0DQo+Pj4+ICAgICAgew0KPj4+PiAgICAgICAgICAgICAgdm9pZCAq
eGRwX3B0ciA9IGJwZl94ZHBfcG9pbnRlcihwdHItPmRhdGEsIHB0ci0+b2Zmc2V0ICsgb2Zmc2V0
LCBsZW4pOw0KPj4+PiAgICAgICAgICAgICAgaWYgKCFJU19FUlJfT1JfTlVMTCh4ZHBfcHRyKSkN
Cj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVybiB4ZHBfcHRyOw0KPj4+PiArICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+Pj4gDQo+Pj4gRXJtLCB0aGUgY2hlY2sgaW4g
dGhlIGlmIGlzIGludmVydGVkIC0gc28gaXNuJ3QgdGhpcyAncmV0dXJuIHhkcF9wdHInDQo+Pj4g
Y292ZXJpbmcgdGhlIGNhc2Ugd2hlcmUgYnBmX3hkcF9wb2ludGVyKCkgKmRvZXMqIGluIGZhY3Qg
cmV0dXJuIGEgdmFsaWQNCj4+PiBwb2ludGVyPw0KPj4+IA0KPj4gDQo+PiBBaCwgeW91IGFyZSBy
aWdodCwgSSBtaXNzZWQgdGhlICEgcGFydC4uLiBPaywgdGhlbiBJIGRvbid0IHRoaW5rIHdlDQo+
PiBoYXZlIGFuIGlzc3VlLCBncmVhdC4gVGhhbmtzIGZvciBkb3VibGUgY2hlY2tpbmchDQo+PiBQ
ZXJoYXBzIHdlIHNob3VsZCBhZGQgYSBzaW1wbGUgY29tbWVudCAiLyogd2UgZ290IGEgdmFsaWQg
ZGlyZWN0DQo+PiBwb2ludGVyLCByZXR1cm4gaXQgKi8iLCBhcyB0aGlzIGxvb2tzIGxpa2UgYW4g
ZXJyb3ItaGFuZGxpbmcgY2FzZS4NCj4gDQo+IFl1cCwgdG90YWxseSBhZ3JlZSBpdCdzIGNvbmZ1
c2luZywgSSBoYWQgdG8gbG9vayBhdCB0aGUgY29kZSB0aHJlZSBvcg0KPiBmb3VyIHRpbWVzIGFz
IHdlbGwganVzdCBub3csIHRvIGJlIHN1cmUgdGhhdCBpdCB3YXNuJ3QgYnVnZ3kuIEFkZGluZyBh
DQo+IGNvbW1lbnQgd291bGQgY2VydGFpbmx5IGJlIHVzZWZ1bCEgOikNCg0KQWhhLCBJIHdhcyBj
b25mdXNlZCBieSB0aGlzIGZvciBtb3JlIHRoYW4gYSBtb250aC4gSSBhbSBnbGFkIHRoaXMgaXMg
DQpub3QgYW4gaXNzdWUuIA0KDQpUaGFua3MsDQpTb25nDQoNCg==


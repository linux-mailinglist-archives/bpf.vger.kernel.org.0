Return-Path: <bpf+bounces-13426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6AE7D9B43
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A93D1C21050
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDA37140;
	Fri, 27 Oct 2023 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="f44xOmcX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F2BE48
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:23:47 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D89CC
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:23:45 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39RE55Bp003328
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:23:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=yTEfeYM/s5rxb4jzRCZeyVYMMtREHw0Tqq6OVqNMAO8=;
 b=f44xOmcX5PzPBvy6PGVjvI4JcqhU1SsRiPyE7g7evSeVNNW/cFm2TFCnjo0U7+Q3D2DZ
 3nr/YRNZs30bV1xAdqkteTRZhQI8qv5gNCtOI38KwCKapSog5UUkcg4Q9KkwXQqXqNOA
 q1GywAXXffrpVFuwroo46RKhcxCj2bmrYO88qEDoiHNJrRFX+XBmen6zrw7q7hSZMk9k
 AiCfTlmGp5OldlNo5/koHTCT2W3Sr0dvJXr+gCrV7yzqjQ2PO2j6VqbDZB78CGpUugDn
 cQq1yCA7FM57VXvxvjkkiRItaqTlRSna/yarawFCN5TPtA9yxpPIwoqWUhqzNXOrorWa Dw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u089aan0e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlszB2qm2O7cPIqlQPM37ID++565Tp9JvVJOiIKmoHJ+l7qAoIv6kulqoUYa+T3cuvvz9oEX2N40Pu7k1c9CoUBzrMxfAh1pYr80p3am+xgAgX5fM5IQWOU1kGSgJUVN7F6arZH4PZ4nLWE2l1xLx6QYAGDw5IoFNuFSlk4FdzeuP2yPebkMyMDB/dNBu3Sr6NpAHRTImYj1PaXGSmKfYCg+qiHRTqlN/b+eIZj33kfpBMJXEJpvrDeYg60E4PCSEn447wPt3PUZcBtpS2lIw2iUZouFzRFFU10Co7jJBdBchkmY3pKdVteGrJTaaA+1blajbzhSvhbM+CPGmjH8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTEfeYM/s5rxb4jzRCZeyVYMMtREHw0Tqq6OVqNMAO8=;
 b=XwQ7HZ/FgUPwtFj7bylG/8Z1FsGApLQB/zKdDWxPDYMLc4lGJJ0NVoRG1GsR2IN/VVCLqYUCXfyZMNww+UjvTSjCQ9244e07eYWmXL9zriZu8u4en1PssboLcP/6nmjSbQ7e7Do40pZP6ige85KXNrFD7Wn1TaMhlf9zstaz8ksi6ggq2Jwl8KtvKVYK9vJZgUZrAuatAgNXXxuUlXO3zTNcxksS009vhrK8v0H+oP9ZBKJjNVUnfsv2p5h/J8Za0MgnQ9SQkP+FKQn3HByqvn12wUBXM85JN83SeG5jqjftlGv4OSH2XymNQHBhv0P8Rfe6UtHFIUmeoggDDvk25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV8PR15MB6439.namprd15.prod.outlook.com (2603:10b6:408:1eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 14:23:41 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c495:8487:66f1:18be]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c495:8487:66f1:18be%4]) with mapi id 15.20.6954.011; Fri, 27 Oct 2023
 14:23:41 +0000
From: Song Liu <songliubraving@meta.com>
To: Jiri Olsa <olsajiri@gmail.com>
CC: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Martin Lau <kafai@meta.com>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP
 Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo
	<haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Store ref_ctr_offsets values in
 bpf_uprobe array
Thread-Topic: [PATCH bpf-next 2/6] bpf: Store ref_ctr_offsets values in
 bpf_uprobe array
Thread-Index: AQHaB4FcGPiaUYBtQ0K1vezZO6f/U7BcRJgAgAFnIICAAAeXgA==
Date: Fri, 27 Oct 2023 14:23:41 +0000
Message-ID: <A7F70A35-B549-4162-9226-CAEF06E09BE0@fb.com>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-3-jolsa@kernel.org>
 <CAPhsuW7oOpsBhc=quoyzNgBFONdv=o67hHnieY1_kPyrZfLsQg@mail.gmail.com>
 <ZTvBhUP2uGqXAIRy@krava>
In-Reply-To: <ZTvBhUP2uGqXAIRy@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV8PR15MB6439:EE_
x-ms-office365-filtering-correlation-id: 014f36c5-3f5f-4202-4978-08dbd6f851d8
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZwK7Y8wel7I/UMsPPu4yr/YidgC8JXfR1zotFNuZLD1qHWXDhiuoBQhCdyo3zy98eqdQOJIjiKBm9v7s3b+2lRIXPSSL6Bb/7KaSPeROaHd8aXoaubJLRuhCxHxjZdcsfdAfu97ck8v6dq6oxvyrqNxl+phUuC9bt9LVg3ZGBKhQxQ+ysEHXRF+gq6+x68mBrFCsSejSlXIblP+DsmhQS6b/O+qNgIu1ccLp2IrAuoXcuX9gjw2AkPZSRINf8W0kU7UPSR7wYLQ+sr88BODZ+mZ2Ab9rRMayc40KpWHzOcNqq8lhCs9D0Jpm73oiqr44hl/nvh4ygLeNr4aL2wMg5xb1J/g4IhqeX/wO3AHL3RUFRKoJ/+7Fxm3aKXVnG9UcH1kwYr0On5nKtWwycTh/8YWoipuqD4Znb2+XCQLAQdum+nCaJbwy7FzNr6S0QM+tI009/P8JUtcb9kzw+wQu9PFvckt7hQ2BzyQklyNnhM/iQKEthJ9S3g4KulgK3jIUBPtDf8THxn5OCX9IOVn0xntEAHYVRT982nDBwy9vfF+mKxNhkGpbuzKoI9y2afLVq6Sra2nm9DBylsEz+LgP5luiM8oUuagVJMGbqU90j2vhn17IOuAwwBRkXKXdn/ZA
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(8936002)(8676002)(4326008)(9686003)(53546011)(76116006)(66556008)(66946007)(66446008)(54906003)(64756008)(66476007)(91956017)(6506007)(478600001)(83380400001)(316002)(6512007)(6916009)(71200400001)(41300700001)(5660300002)(7416002)(2906002)(38100700002)(122000001)(86362001)(33656002)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aHlSdzhjWTcwUzhSREErNUtoM0dueHJMVnpEVlJlVTh5VG5oUnBwNUdQSm9h?=
 =?utf-8?B?anZFblpXMHlmc2FDMS9Qb3Q2M3FOQnd3OXRIUUNVenpyUlFWRVRoUUNZODlH?=
 =?utf-8?B?eVpISnUyVXM4MXFrSHhqZHlBOFYzT2tIYUtlUkZwVE5tT0NBbUo1cU8zR1R4?=
 =?utf-8?B?UmF4MFRDQ09LTmZPeGxjSTVZUFp5dzFvZElvUllvNHd5Vi9yamFGVTZSWldJ?=
 =?utf-8?B?ditacG80bXhWeXdWNExVaXVyTXFrUURZZ05weGxhWFJPTHpCYVk4TFJ3bW9Q?=
 =?utf-8?B?Qm90cHdvN2ErNFZGeUNnbjB5UmRjNTc1WlY2REJZaDAvc1hIMHJ6NFpyd2w0?=
 =?utf-8?B?TjRXTmdRS3hTUmNHQWUzaU1ab3NMSXNhSk9TQ3FpLzlUN24ybVJEdjlGalp0?=
 =?utf-8?B?Q3g4QTNRdE9aUVZsRjVxU0lURHlibWJ4T2w0VVZzeU1DUVNyMDFwd0s4cUcx?=
 =?utf-8?B?Z3RMa0I2ZkZLMEVONmE4TkorMlZSRkFRMWgvUVJRZ0QxWXVNUUdOczh5MEw1?=
 =?utf-8?B?R2hTWnFHNlZib0N6R2xQbW40b0Z3MlN3Tk1QZjNuVERvVVJsTFBxc0lycjh3?=
 =?utf-8?B?NFR0NDVoV1kzM2VqZlpUd0Rnc1psNHdnTGttSHYvVzROT05xUEloYmFBNWFh?=
 =?utf-8?B?N2hKUzUrZFRvUS8zSWpoeFg4WmwrcW9NSFVsc0FwaHpKaEhGdmhaK0NuYjd2?=
 =?utf-8?B?bzB4Y3JCSUFvUU1Ua1JLbkhNVHltNXhocytyY010NU9NbC9xVUt6My9zUmg2?=
 =?utf-8?B?YjBHcDJMQ0wzYUtiVSsxS1lLU0lDeE9tWUxBQ1pUSzlqSlpCdlNiSGJKUnNG?=
 =?utf-8?B?Mk94ZjRPMk0wamkyWE01UUQwanRCRFRWaEtlUlpzUGRIQm11MEtxd1ppZm96?=
 =?utf-8?B?U2srdTg4aEk3dms1ZFdHMlVYNzEwak93MEJYNnpCajk0VGNJMTFuMVE2SlRE?=
 =?utf-8?B?bHdQK3g1YWFDQ2wvWlcwNXZRYWlPSHBVRnA1ZlJWUHNFVENHNjk4WGVvT3hK?=
 =?utf-8?B?MUJtOU8raXFoM1JMLy9VbnpEaUZWQlpLWGRneDBVUTJlS1dxWnQ1VkdtRW9k?=
 =?utf-8?B?ZFFqMlE0RVlOZzlySE1hcGRjaVh6L1dYMnZKOGR1c0ZNNTdMYmxqZWgxS3pu?=
 =?utf-8?B?cGMvN3JKenV6eWVIYVZKaGJpcm9zSFVlMEk1aGxNWHJtRVpJUmJIeU5ZTW5t?=
 =?utf-8?B?Zng4Q0tTZ3NZenBTQWVoN0tEcUJBc2wwZGlIeU9MZjhJQkRrbmMrblVENkZS?=
 =?utf-8?B?OGJYa29xY1JDeWIrbFlEeDBrVmpXOS8zRlRDL3pGNWpiRE92T2w2SVJ2ZmJF?=
 =?utf-8?B?eER5bUI5UDV2bnEydXpvaFBtQ3Z5aitFdnJjbWxYc0RSTElpL3lQcU1SRmFZ?=
 =?utf-8?B?ejF2REx0ZHgyZmRhM1B4Ukh4ZlNHSWZMckNhRCt1YytVOEYxeFRxeENYL0ho?=
 =?utf-8?B?R25zc2hJYmxSbnMzckNOdEo2K05WWDFUbG5RMjc0OG0zeGtRQllrOHRabDBY?=
 =?utf-8?B?eHVUbUF2bTQvSTIzcFZTekl3d2N6OFJrNGYyOUQ3bkVJeVg2c3doQzdJb0M5?=
 =?utf-8?B?YTZRQUJka2Yyazlzdm4xVzUrUThiQVRUSkxhUUhFaGJvYUlyRk5iWFFxWmxr?=
 =?utf-8?B?RnR6R2F4azlCM0FTd3lIVXlLWU5pc0Y4VkNQei9qVm5GTFhLWmR3L29xMHpu?=
 =?utf-8?B?eG8wa3VBS0Z4cGFDYkZJdnA2V0ZYWnJySWZmbm9QUXQ4VllLS3hhZHpiVEkr?=
 =?utf-8?B?TThTSnVmU2lDT2tJcHI5Mkp4WWs3aFlOMUFHZHkwRktnSDhhalg2MFZhWjh4?=
 =?utf-8?B?Y0Y2ZDEyQ2FEeFphckFyakZ2TkhuYTFpbHRQMDZ4UVE3ODRtOVJrV0RISUNx?=
 =?utf-8?B?dmVTYm5sYnFmaXU1Q05rUWJuSzBiOFFtVlJTSVp2MjJQLzZqRU1ya2p6MUNs?=
 =?utf-8?B?L3o3NDg5MTdBTHR0UWJubWVjS25Da05aY3hoTDJBNDZWd2Y2a1pRS3JUcnVG?=
 =?utf-8?B?bjBQK3lEZ2RHWFJya0FLZGxjQ2s5eVBIY240RlQ5UXVzQWJNck1KWEhFM1Vh?=
 =?utf-8?B?UWNvKzh6MXZpNDl3MUJkdVNrL1AydWVsZ1pmSlNxT0NOcnpMeVJNT0d3K1hG?=
 =?utf-8?B?THZudm8rK2dTZm9mMUJZNzgrLzF4dTFTRU9ybXF0NU9PcDd1bThiSS9HS1E1?=
 =?utf-8?Q?rO8fmRb0ISTHSjYU2HDCsHY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC6371F016378E4F8EBDB9B9D13EA356@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 014f36c5-3f5f-4202-4978-08dbd6f851d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 14:23:41.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VrdcXvCAmT/pbo9n0hVVbyKZKYsx4El0B9GwKRxmJn4kL7GiKlZJpKmP5tCsg3zEooyEDX0MKp94WeYHSGl5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6439
X-Proofpoint-GUID: vN6r-7foN2GZZo2DIkcoU4zxYfnUiFbc
X-Proofpoint-ORIG-GUID: vN6r-7foN2GZZo2DIkcoU4zxYfnUiFbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02

DQoNCj4gT24gT2N0IDI3LCAyMDIzLCBhdCA2OjU24oCvQU0sIEppcmkgT2xzYSA8b2xzYWppcmlA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgT2N0IDI2LCAyMDIzIGF0IDA5OjMxOjAw
QU0gLTA3MDAsIFNvbmcgTGl1IHdyb3RlOg0KPj4gT24gV2VkLCBPY3QgMjUsIDIwMjMgYXQgMToy
NOKAr1BNIEppcmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gV2Ug
d2lsbCBuZWVkIHRvIHJldHVybiByZWZfY3RyX29mZnNldHMgdmFsdWVzIHRocm91Z2ggbGlua19p
bmZvDQo+Pj4gaW50ZXJmYWNlIGluIGZvbGxvd2luZyBjaGFuZ2UsIHNvIHdlIG5lZWQgdG8ga2Vl
cCB0aGVtIGFyb3VuZC4NCj4+PiANCj4+PiBTdG9yaW5nIHJlZl9jdHJfb2Zmc2V0cyB2YWx1ZXMg
ZGlyZWN0bHkgaW50byBicGZfdXByb2JlIGFycmF5Lg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6
IEppcmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz4NCj4+IA0KPj4gQWNrZWQtYnk6IFNvbmcgTGl1
IDxzb25nQGtlcm5lbC5vcmc+DQo+PiANCj4+IHdpdGggb25lIG5pdHBpY2sgYmVsb3cuDQo+PiAN
Cj4+PiAtLS0NCj4+PiBrZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMgfCAxNCArKystLS0tLS0tLS0t
LQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0K
Pj4+IA0KPj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMgYi9rZXJuZWwv
dHJhY2UvYnBmX3RyYWNlLmMNCj4+PiBpbmRleCBkZjY5N2M3NGQ1MTkuLjg0M2IzODQ2ZDNmOCAx
MDA2NDQNCj4+PiAtLS0gYS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4+PiArKysgYi9rZXJu
ZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4+PiBAQCAtMzAzMSw2ICszMDMxLDcgQEAgc3RydWN0IGJw
Zl91cHJvYmVfbXVsdGlfbGluazsNCj4+PiBzdHJ1Y3QgYnBmX3Vwcm9iZSB7DQo+Pj4gICAgICAg
IHN0cnVjdCBicGZfdXByb2JlX211bHRpX2xpbmsgKmxpbms7DQo+Pj4gICAgICAgIGxvZmZfdCBv
ZmZzZXQ7DQo+Pj4gKyAgICAgICB1bnNpZ25lZCBsb25nIHJlZl9jdHJfb2Zmc2V0Ow0KPj4gDQo+
PiBuaXQ6IHMvdW5zaWduZWQgbG9uZy9sb2ZmX3QvID8NCj4gDQo+IGh1bSwgdGhlIHNpbmdsZSB1
cHJvYmUgaW50ZXJmYWNlIGFsc28ga2VlcHMgaXQgYXMgJ3Vuc2lnbmVkIGxvbmcnDQo+IGluICdz
dHJ1Y3QgdHJhY2VfdXByb2JlJyAuLiB3aGlsZSB1cHJvYmUgY29kZSBrZWVwcyBib3RoIG9mZnNl
dCBhbmQNCj4gcmVmX2N0cl9vZmZzZXQgdmFsdWVzIGFzIGxvZmZfdA0KPiANCj4gaXMgdGhlcmUg
YW55IGJlbmVmaXQgYnkgY2hhbmdpbmcgdGhhdCB0byBsb2ZmX3Q/DQoNCldlIGhhdmUgImxvZmZf
dCBvZmZzZXQ7IiByaWdodCBhYm92ZSB0aGlzIGxpbmUuIFNvIGl0IGlzIGJldHRlciB0byANCnVz
ZSBzYW1lIHR5cGUgZm9yIHRoZSB0d28gb2Zmc2V0cy4gDQoNClRoYW5rcywNClNvbmcNCg0K


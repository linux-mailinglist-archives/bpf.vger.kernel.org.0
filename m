Return-Path: <bpf+bounces-12491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F369C7CD014
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 00:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508EEB21221
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCE02DF7D;
	Tue, 17 Oct 2023 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XJ2XJA0+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1E43110
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 22:46:37 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69524D3
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:46:34 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HHmsXr009754
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:46:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=7Z2AOngQ1pleSuh0y98t/SrCGFoEebJfxlzTxFgYBc4=;
 b=XJ2XJA0+v+puPJxGnByuxhW3V18DYvR3sgEOds1fJLgbkVhX2n1P1ZxdFb1ibiVIr5zn
 TAr5cvA9+g2uSwZa2sdgjoR1VJmn2qbX+3VsLy+hSxE5IfhRTaqP2SyCoIGcQNcucWfL
 0DT0tcYf+NlZDUQmlUlbSzS8QjIgIMvPRO18WmVtdCR6Wd6oxdnr0UJ4uyd08cZII0l6
 bROaq+BWdwvhhXZA76o/ytU4lVWttBCOowuBxvJ4O68fIIXsqQ4FMpG2MQy2Dw45lgff
 e+AaNjU8aSiJXWyiJ2Hqbj6mg3mFfacSb71iGVL7bsgQLF4J0siY8/sslfjEhAS/FSUX mw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tsqqt5beh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:46:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr93asdTPOXXHG75uZQLCHwjBMZ8ecyMDPTMUxRhko2vJohj+TFG9p1UMCc4PXnqzAnf+FsYoOt/1FdAij15wQGekKmn3TI4rMnk6B+sMUhYRdHvNsaXfUEv8z1rZwb7pFLedMy8AlFuL9BKoF1aCZxNKcom4eNBxr7x2b/qSYSViAuyrzKrBtMzOCmhF0gUFZe1o12iIJzNeOcrgtPURJVQL9ovycxSc8CYmHyskTJTsRBp8JDNO4Z4nLcdRk1dv1LapcPnmwCI5jMRWr2iNqoPOUQ3r5cqKhQ+ixhwKU5cnAtqfUM38uoK8KrPWUu5hHQfr58vrpgYEkeG/ocPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Z2AOngQ1pleSuh0y98t/SrCGFoEebJfxlzTxFgYBc4=;
 b=KMfHKkZrLr5Hbg5/OpZl15RLEq3eG1UExf30EoAaEjYIjafyD5diu6BxxHr4/qHiGG+LKqVZJ78ReCV6xTApMCy6ZoiROiQiXpWKWWkICZRF58VG8EYpo6hqZ9pSazizoTkE9PR3ooplA9/OHvrd7O9sawB7B8bggm2/JKCz/16PqXuKO84HP4yG/Z34zrxGRdampms/tuBbkAmE0zsjyG8EQzLlix9yRO99FALWhQ39SdFXsmKZKWC95qY8drRYet+E0I3R/zJ9qTSU9HhKMKso3dQ1f/84fEzAVoC35eorG/OY8pxloa21G7i9wpIHNEIknqH2vwwENaIWe5zK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB4909.namprd15.prod.outlook.com (2603:10b6:510:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 22:46:30 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::526c:b078:a1d1:fba8%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 22:46:30 +0000
From: Song Liu <songliubraving@meta.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        bpf
	<bpf@vger.kernel.org>,
        "fsverity@lists.linux.dev" <fsverity@lists.linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Eric Biggers
	<ebiggers@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
        "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
Thread-Topic: [PATCH bpf-next 1/5] bpf: Add kfunc bpf_get_file_xattr
Thread-Index: 
 AQHZ/gM1jAkPDEgRp0q6fPvepF0WybBOW9CAgAAZ8ICAABaKgIAABrWAgAAG0ACAAAGoAA==
Date: Tue, 17 Oct 2023 22:46:30 +0000
Message-ID: <4072463E-332B-40BE-BC8B-D284FB88D143@fb.com>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-2-song@kernel.org>
 <CAEf4BzYbQzMU4T6KYt4UudXvZiPg4nQdQCxD9zqzoJLgqOE9bQ@mail.gmail.com>
 <0ABF7860-A331-4161-9599-C781E9650283@fb.com>
 <CAEf4BzaNA18CpG-E-OUynEZuhGoQsieyzTVTkVOF9qB=j4u+yA@mail.gmail.com>
 <5FBE8C27-0280-4434-BBF2-70344276F16D@fb.com>
 <CAEf4BzZXPMqLG95f5XXayvbTUOOJmzUKjyaurnjdMrt46S5d1Q@mail.gmail.com>
In-Reply-To: 
 <CAEf4BzZXPMqLG95f5XXayvbTUOOJmzUKjyaurnjdMrt46S5d1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.100.2.1.4)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB4909:EE_
x-ms-office365-filtering-correlation-id: ce602f6f-0cb3-4fb8-57d9-08dbcf62e7e0
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EamEBs0Co5PpWdh6y7Eus+ViMVLMfWr0gkoKYytqdsrFuckuQd5RX1UDP9ogPW/5HGYanVdB27AQwiKkUZeCi5hrTZ+LPrsQmaM4p1m+beKxRgK0L16gO3kEzcc1u2VcbDiqlQkGbaQdo9dNxwIF2qylNgXIe7RfTiMYl4dflZCpO6d8lLubZBmzzuUzLxEX9KseK1TGSKO0v9OX2Q8fAYOryidyv9YYYcyZxwvW2svwhG8VD7gxmT2FkPXPGB7VikDbJT4tp7/yrKqy6C8Q9JmqTZW/Od7Op3Vmykj/u/taFSSMLOrj3xOH7V2AnKqeOvYgOO3xNfygrOWuyKUM34e4ogHWJ/CjGKKuT1HY3VZ/3+1EZK2miNlyIOH53Ji/2ThqCaLglPvHih4WCKBrbyrepPysVbQk1DFGYBAE6FaAKiVHgQvoNIkhStn+fTSywkTG261TME/JorBCFiKkZNISxJ0Q9Evc9oFoAOfPpvZl7bMHLyEkLQhhtJmg2l7v5oP7c1e5pO40UemJH7oGkUNdMY+WZeMeoecosyG/NuwlvCoCh6agxpvqYskxVvzLc8WudqMDgkMOJsOr+HTfoQONBG8TDCNJa6e8j81A9mqyO6dTRrMSKIRSUkZZn9Mss6PNF05dIQxiOQx7BZO8eA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6486002)(36756003)(66446008)(478600001)(6916009)(66556008)(91956017)(41300700001)(7416002)(66476007)(316002)(4326008)(8676002)(8936002)(54906003)(76116006)(66946007)(64756008)(5660300002)(71200400001)(6506007)(53546011)(86362001)(38100700002)(38070700005)(9686003)(6512007)(83380400001)(2906002)(33656002)(122000001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MURBWUpPUkRLNXgwTGh5cExEVmJzVWVQMERQcVQrN2NmeHdsN01aRXlrUmVz?=
 =?utf-8?B?QlhmZ3ZLelBoUVZNdm9YSWp5UlRIVFBSUEt2TzlMNEtYZDhlNVIyRGxCdGRt?=
 =?utf-8?B?RUJqaWowSlZGcjFRaXhiWWpBcDEyVTZrUmt1cC9EbVRBOUFrbTdQQVpZMU1u?=
 =?utf-8?B?QjFOVFhadHZDWVZDQmM0RVFqSFVtckVEQmtyVDZtMUFKOHVSVVJvdmVVYWh1?=
 =?utf-8?B?Tk5vS3ArZUdJb0ZWMllDNUMyQWY0dWZmeWN4M0JhT1NGT1FHU0U5S3BuVlF5?=
 =?utf-8?B?cGF3L0R3QWtmZmwvS0xnVkVEQTRBZHBJTWdiWEFkanlzOTY4ZEg2bWxBQXgv?=
 =?utf-8?B?QytGWXp4NUp4cDNqbEFzZEJzSUw0S25NNzc1THRZVmxBcENEZXFoUC91d2lG?=
 =?utf-8?B?SHprQ0V4a3UwMm5lRDFQSnZrR3d0WHgxSitvdm9wdTMvS0p6RVdkM2hRZERK?=
 =?utf-8?B?WGV0ZXZwTmpIQll5NWZtRFZObWNib3dIbzV6MG5PZGtoNnUvQVEyQWNGUThR?=
 =?utf-8?B?ZVRUWEMybjlhRVhIYnh5YXduNXZhYmttYiszL2JXTWNLSmVmTk5zc1U5U1dT?=
 =?utf-8?B?a08vT0dWdFBHeHZKY2tGZ09TZUtjMDJodndTR0ZOR05sRnRsYTRjWXRyTUo4?=
 =?utf-8?B?a0h1ZzJhR3lhdE8rYmlCdWxDbUlEbzM0U1FIbE0yTHpqaHdBbmVZbHdYL29F?=
 =?utf-8?B?SkJKcVViTTlpeGRIcUE0eEljblM1OFpTd2h5Rnp2OVZCaVFxZEM0SGp1a1Qx?=
 =?utf-8?B?VFhoMTRBTmo4RlRTSTZpdkdCSWdkYW11Z1BEL1EySEhwaEhwYk1oeDNCclVI?=
 =?utf-8?B?SjFDOVVFdjFBc2tDbGdwdlVWS0NDbHNmSVgyMitaaWpmTW9KQWtwSVZ3NWdy?=
 =?utf-8?B?OCs4djVxZFVpcC9Pcm9uVE5ncTVEMTZjazAzQ24vOWZzL1Jnb0lZZkNLVnJB?=
 =?utf-8?B?blBmK1Jubk1YeXk0WFRqOHNyUEswNldtVG0vTTI3bjVOc0lmaWZkUkNnVzUy?=
 =?utf-8?B?VUhQblFSZERqUkxlRUlpZ1JhTkxZRUVpYktjcDJkemVEeUd5dzdRSGpvVjdj?=
 =?utf-8?B?VVZoZU5MYWRtbm51ak1uZG9CUDZ4WkUvVDkzOFlSb09GanRyWUR3eXZRTkdF?=
 =?utf-8?B?enoraTFMZnhhYVk5N3Y2TEhlTDBUOVZ1ZDdSMjNtT2pDR1ZxbFp4Q1VCSTJr?=
 =?utf-8?B?NmhlZTBWU3J3UnZXajhyU0EyQjhLZjhheUhDbGZ4QjZXelZueEM1VWQ2RGpz?=
 =?utf-8?B?ZmVXRE5PSVg0K2ZiaU1paXpJT2Y0Ry9VbzhNS0ZXQUZjTVhKRWdYbmVFZXR4?=
 =?utf-8?B?ZW5MdmM5a1VIMy85MThYQkdBcWhUUTFBdDRSeGVhSHFNRmFnNGlTaXJ1ZXlK?=
 =?utf-8?B?RmR0Wi9FMmhDUGYxdU9VR3RTYVJSeGV5eTZqMHI1MlZsMXRBWXRoVVlmVWUz?=
 =?utf-8?B?Q3RmbHgyQTdwNXcvMHJ0UmdudmVidnVJQjhZdlNNeEFaUlZoa0lTZm45NU9D?=
 =?utf-8?B?THBhRThUOUF2WGd1b1dMc1ZUL0x2ZURKZXVaQU5UUURRK2V4TDBXSEdFaEQv?=
 =?utf-8?B?RDQ5K1RBeVhjajdGTmV6b0RhK3pxaEZUL3B3ZE9wa3NEV3JNZFJJbVAwb25n?=
 =?utf-8?B?dEI0dVpwSWhYZUJFZXdiVVZQTFpCV0E1bDM3WTN1bENHT3N2VGtadWQydDUz?=
 =?utf-8?B?Vm5oMko4N2NQOEdKblJuRGdRYnZraUsreHRnQlFCalpZdVV6cGdVMHdUQ2JD?=
 =?utf-8?B?TzA3N29rOEJLOEtKTEk1Zm1oSHYvUlFDaFY1VTdDbEI1WTFwMGI3cDkyeWNK?=
 =?utf-8?B?cjcyMmYzTWVURnRzVDIwR3hXZkVnb0FwZjltSTQ0SW9qNFdoYmZ4VExmZU1C?=
 =?utf-8?B?YlF2bkRlUEo3Ym16R1Z2cVU3T0pmcHpNQ2NDdVd3ZC85dVJiODNnRkFFZWli?=
 =?utf-8?B?KzBZWEVWRkg5RnBjTThjR1VDY3MvNEpjSjROanExRFpUTElJbFJ1YWd1Kzda?=
 =?utf-8?B?NlpWOHZrVUc4NVNTaUttL1hudTlDSDVJSGVveWlWWmhrNFQxbFNiNjkzeGhD?=
 =?utf-8?B?WEMzSnVQQ3RHTEEwdzNxb1lvb1phbXNFWGpVWXh6dXU1YVVDOTJUZzVpRElk?=
 =?utf-8?B?cjRQQkZpbVdNVWlnZk81eHYxYXpzRkZzdG1kOHk1d0VLekVyVEN2VFZQOUZj?=
 =?utf-8?Q?+p+JLz/7sA6rmU9lYjFDp4w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F7CA668C7B9024F9BF1443CB50E42EB@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce602f6f-0cb3-4fb8-57d9-08dbcf62e7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 22:46:30.6896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/eUsSfcjtSAMDUoJfnum60Pu+sMg0VkgeAQJqLqZV9S7NvqnzqVTGGV+Se5f0LYt1RgBiChxOz/qWn4YWaPHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4909
X-Proofpoint-GUID: rmtbBkxK9y6PoCi12fmR5jaOAG2141jJ
X-Proofpoint-ORIG-GUID: rmtbBkxK9y6PoCi12fmR5jaOAG2141jJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gT24gT2N0IDE3LCAyMDIzLCBhdCAzOjQw4oCvUE0sIEFuZHJpaSBOYWtyeWlrbyA8YW5k
cmlpLm5ha3J5aWtvQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIE9jdCAxNywgMjAy
MyBhdCAzOjE24oCvUE0gU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQG1ldGEuY29tPiB3cm90ZToN
Cj4+IA0KPj4gDQo+PiANCj4+PiBPbiBPY3QgMTcsIDIwMjMsIGF0IDI6NTLigK9QTSwgQW5kcmlp
IE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBP
biBUdWUsIE9jdCAxNywgMjAyMyBhdCAxOjMx4oCvUE0gU29uZyBMaXUgPHNvbmdsaXVicmF2aW5n
QG1ldGEuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+PiANCj4+Pj4+IE9uIE9jdCAxNywg
MjAyMywgYXQgMTE6NTjigK9BTSwgQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWkubmFrcnlpa29AZ21h
aWwuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gRnJpLCBPY3QgMTMsIDIwMjMgYXQgMTE6
MjnigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+
PiBUaGlzIGtmdW5jIGNhbiBiZSB1c2VkIHRvIHJlYWQgeGF0dHIgb2YgYSBmaWxlLg0KPj4+Pj4+
IA0KPj4+Pj4+IFNpbmNlIHZmc19nZXR4YXR0cigpIHJlcXVpcmVzIG51bGwtdGVybWluYXRlZCBz
dHJpbmcgYXMgaW5wdXQgIm5hbWUiLCBhIG5ldw0KPj4+Pj4+IGhlbHBlciBicGZfZHlucHRyX2lz
X3N0cmluZygpIGlzIGFkZGVkIHRvIGNoZWNrIHRoZSBpbnB1dCBiZWZvcmUgY2FsbGluZw0KPj4+
Pj4+IHZmc19nZXR4YXR0cigpLg0KPj4+Pj4+IA0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNvbmcg
TGl1IDxzb25nQGtlcm5lbC5vcmc+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gaW5jbHVkZS9saW51eC9i
cGYuaCAgICAgIHwgMTIgKysrKysrKysrKysNCj4+Pj4+PiBrZXJuZWwvdHJhY2UvYnBmX3RyYWNl
LmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4g
MiBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCspDQo+Pj4+Pj4gDQo+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvYnBmLmggYi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+Pj4+Pj4g
aW5kZXggNjFiZGU0NTIwZjVjLi5mMTRmYWU0NWUxM2QgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvaW5j
bHVkZS9saW51eC9icGYuaA0KPj4+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4+Pj4+
PiBAQCAtMjQ3Miw2ICsyNDcyLDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBoYXNfY3VycmVudF9i
cGZfY3R4KHZvaWQpDQo+Pj4+Pj4gICAgICByZXR1cm4gISFjdXJyZW50LT5icGZfY3R4Ow0KPj4+
Pj4+IH0NCj4+Pj4+PiANCj4+Pj4+PiArc3RhdGljIGlubGluZSBib29sIGJwZl9keW5wdHJfaXNf
c3RyaW5nKHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnB0cikNCj4+Pj4+IA0KPj4+Pj4gaXNfemVy
b190ZXJtaW5hdGVkIHdvdWxkIGJlIG1vcmUgYWNjdXJhdGU/IHRob3VnaCB0aGVyZSBpcyBub3Ro
aW5nDQo+Pj4+PiByZWFsbHkgZHlucHRyLXNwZWNpZmljIGhlcmUuLi4NCj4+Pj4gDQo+Pj4+IGlz
X3plcm9fdGVybWluYXRlZCBzb3VuZHMgYmV0dGVyLg0KPj4+PiANCj4+Pj4+IA0KPj4+Pj4+ICt7
DQo+Pj4+Pj4gKyAgICAgICBjaGFyICpzdHIgPSBwdHItPmRhdGE7DQo+Pj4+Pj4gKw0KPj4+Pj4+
ICsgICAgICAgcmV0dXJuIHN0cltfX2JwZl9keW5wdHJfc2l6ZShwdHIpIC0gMV0gPT0gJ1wwJzsN
Cj4+Pj4+PiArfQ0KPj4+Pj4+ICsNCj4+Pj4+PiB2b2lkIG5vdHJhY2UgYnBmX3Byb2dfaW5jX21p
c3Nlc19jb3VudGVyKHN0cnVjdCBicGZfcHJvZyAqcHJvZyk7DQo+Pj4+Pj4gDQo+Pj4+Pj4gdm9p
ZCBicGZfZHlucHRyX2luaXQoc3RydWN0IGJwZl9keW5wdHJfa2VybiAqcHRyLCB2b2lkICpkYXRh
LA0KPj4+Pj4+IEBAIC0yNzA4LDYgKzI3MTUsMTEgQEAgc3RhdGljIGlubGluZSBib29sIGhhc19j
dXJyZW50X2JwZl9jdHgodm9pZCkNCj4+Pj4+PiAgICAgIHJldHVybiBmYWxzZTsNCj4+Pj4+PiB9
DQo+Pj4+Pj4gDQo+Pj4+Pj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBicGZfZHlucHRyX2lzX3N0cmlu
ZyhzdHJ1Y3QgYnBmX2R5bnB0cl9rZXJuICpwdHIpDQo+Pj4+Pj4gK3sNCj4+Pj4+PiArICAgICAg
IHJldHVybiBmYWxzZTsNCj4+Pj4+PiArfQ0KPj4+Pj4+ICsNCj4+Pj4+PiBzdGF0aWMgaW5saW5l
IHZvaWQgYnBmX3Byb2dfaW5jX21pc3Nlc19jb3VudGVyKHN0cnVjdCBicGZfcHJvZyAqcHJvZykN
Cj4+Pj4+PiB7DQo+Pj4+Pj4gfQ0KPj4+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvYnBm
X3RyYWNlLmMgYi9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4+Pj4+PiBpbmRleCBkZjY5N2M3
NGQ1MTkuLjk0NjI2ODU3NGUwNSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9rZXJuZWwvdHJhY2UvYnBm
X3RyYWNlLmMNCj4+Pj4+PiArKysgYi9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCj4+Pj4+PiBA
QCAtMjQsNiArMjQsNyBAQA0KPj4+Pj4+ICNpbmNsdWRlIDxsaW51eC9rZXkuaD4NCj4+Pj4+PiAj
aW5jbHVkZSA8bGludXgvdmVyaWZpY2F0aW9uLmg+DQo+Pj4+Pj4gI2luY2x1ZGUgPGxpbnV4L25h
bWVpLmg+DQo+Pj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9maWxlYXR0ci5oPg0KPj4+Pj4+IA0KPj4+
Pj4+ICNpbmNsdWRlIDxuZXQvYnBmX3NrX3N0b3JhZ2UuaD4NCj4+Pj4+PiANCj4+Pj4+PiBAQCAt
MTQyOSw2ICsxNDMwLDQ5IEBAIHN0YXRpYyBpbnQgX19pbml0IGJwZl9rZXlfc2lnX2tmdW5jc19p
bml0KHZvaWQpDQo+Pj4+Pj4gbGF0ZV9pbml0Y2FsbChicGZfa2V5X3NpZ19rZnVuY3NfaW5pdCk7
DQo+Pj4+Pj4gI2VuZGlmIC8qIENPTkZJR19LRVlTICovDQo+Pj4+Pj4gDQo+Pj4+Pj4gKy8qIGZp
bGVzeXN0ZW0ga2Z1bmNzICovDQo+Pj4+Pj4gK19fZGlhZ19wdXNoKCk7DQo+Pj4+Pj4gK19fZGlh
Z19pZ25vcmVfYWxsKCItV21pc3NpbmctcHJvdG90eXBlcyIsDQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgICAgImtmdW5jcyB3aGljaCB3aWxsIGJlIHVzZWQgaW4gQlBGIHByb2dyYW1zIik7DQo+Pj4+
Pj4gKw0KPj4+Pj4+ICsvKioNCj4+Pj4+PiArICogYnBmX2dldF9maWxlX3hhdHRyIC0gZ2V0IHhh
dHRyIG9mIGEgZmlsZQ0KPj4+Pj4+ICsgKiBAbmFtZV9wdHI6IG5hbWUgb2YgdGhlIHhhdHRyDQo+
Pj4+Pj4gKyAqIEB2YWx1ZV9wdHI6IG91dHB1dCBidWZmZXIgb2YgdGhlIHhhdHRyIHZhbHVlDQo+
Pj4+Pj4gKyAqDQo+Pj4+Pj4gKyAqIEdldCB4YXR0ciAqbmFtZV9wdHIqIG9mICpmaWxlKiBhbmQg
c3RvcmUgdGhlIG91dHB1dCBpbiAqdmFsdWVfcHRyKi4NCj4+Pj4+PiArICoNCj4+Pj4+PiArICog
UmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIGEgbmVnYXRpdmUgdmFsdWUgb24gZXJyb3IuDQo+Pj4+Pj4g
KyAqLw0KPj4+Pj4+ICtfX2JwZl9rZnVuYyBpbnQgYnBmX2dldF9maWxlX3hhdHRyKHN0cnVjdCBm
aWxlICpmaWxlLCBzdHJ1Y3QgYnBmX2R5bnB0cl9rZXJuICpuYW1lX3B0ciwNCj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBicGZfZHlucHRyX2tlcm4gKnZh
bHVlX3B0cikNCj4+Pj4+PiArew0KPj4+Pj4+ICsgICAgICAgaWYgKCFicGZfZHlucHRyX2lzX3N0
cmluZyhuYW1lX3B0cikpDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
Pj4+Pj4gDQo+Pj4+PiBzbyBkeW5wdHIgY2FuIGJlIGludmFsaWQgYW5kIG5hbWVfcHRyLT5kYXRh
IHdpbGwgYmUgTlVMTCwgeW91IHNob3VsZA0KPj4+Pj4gYWNjb3VudCBmb3IgdGhhdA0KPj4+PiAN
Cj4+Pj4gV2UgY2FuIGFkZCBhIE5VTEwgY2hlY2sgKG9yIHNpemUgY2hlY2spIGhlcmUuDQo+Pj4g
DQo+Pj4gdGhlcmUgbXVzdCBiZSBzb21lIGhlbHBlciB0byBjaGVjayBpZiBkeW5wdHIgaXMgdmFs
aWQsIGxldCdzIHVzZSB0aGF0DQo+Pj4gaW5zdGVhZCBvZiBOVUxMIGNoZWNrcw0KPj4gDQo+PiBZ
ZWFoLCB3ZSBjYW4gdXNlIGJwZl9keW5wdHJfaXNfbnVsbCgpLg0KPj4gDQo+Pj4gDQo+Pj4+IA0K
Pj4+Pj4gDQo+Pj4+PiBhbmQgdGhlcmUgY291bGQgYWxzbyBiZSBzcGVjaWFsIGR5bnB0cnMgdGhh
dCBkb24ndCBoYXZlIGNvbnRpZ3VvdXMNCj4+Pj4+IG1lbW9yeSByZWdpb24sIHNvIHNvbWVob3cg
eW91J2QgbmVlZCB0byB0YWtlIGNhcmUgb2YgdGhhdCBhcyB3ZWxsDQo+Pj4+IA0KPj4+PiBXZSBj
YW4gcmVxdWlyZSB0aGUgZHlucHRyIHRvIGJlIEJQRl9EWU5QVFJfVFlQRV9MT0NBTC4gSSBkb24n
dCB0aGluaw0KPj4+PiB3ZSBuZWVkIHRoaXMgZm9yIGR5bnB0ciBvZiBza2Igb3IgeGRwLiBXb3Vs
ZCB0aGlzIGJlIHN1ZmZpY2llbnQ/DQo+Pj4gDQo+Pj4gd2VsbCwgdG8ga2VlcCB0aGluZyBzaW1w
bGUgd2UgY2FuIGhhdmUgYSBzaW1wbGUgaW50ZXJuYWwgaGVscGVyIEFQSQ0KPj4+IHRoYXQgd2ls
bCB0ZWxsIGlmIGl0J3Mgc2FmZSB0byBhc3N1bWUgdGhhdCBkeW5wdHIgbWVtb3J5IGlzIGNvbnRp
Z3VvdXMNCj4+PiBhbmQgaXQncyBvayB0byB1c2UgZHlucHRyIG1lbW9yeS4gQnV0IHN0aWxsLCB5
b3Ugc2hvdWxkbid0IGFjY2VzcyBkYXRhDQo+Pj4gcG9pbnRlciBkaXJlY3RseSwgdGhlcmUgbXVz
dCBiZSBzb21lIGhlbHBlciBmb3IgdGhhdC4gUGxlYXNlIGNoZWNrLiBJdA0KPj4+IGhhcyB0byB0
YWtlIGludG8gYWNjb3VudCBvZmZzZXQgYW5kIHN0dWZmIGxpa2UgdGhhdC4NCj4+IA0KPj4gWWVh
aCwgd2UgY2FuIHVzZSBicGZfZHlucHRyX3dyaXRlKCksIHdoaWNoIGlzIGEgaGVscGVyIChub3Qg
a2Z1bmMpLg0KPj4gDQo+Pj4gDQo+Pj4gQWxzbywgYW5kIHNlcGFyYXRlbHkgZnJvbSB0aGF0LCB3
ZSBzaG91bGQgdGhpbmsgYWJvdXQgcHJvdmlkaW5nIGENCj4+PiBicGZfZHlucHRyX3NsaWNlKCkt
bGlrZSBoZWxwZXIgdGhhdCB3aWxsIGFjY2VwdCBhIGZpeGVkLXNpemVkDQo+Pj4gdGVtcG9yYXJ5
IGJ1ZmZlciBhbmQgcmV0dXJuIHBvaW50ZXIgdG8gZWl0aGVyIGFjdHVhbCBtZW1vcnkgb3IgY29w
eQ0KPj4+IG5vbi1jb250aWd1b3VzIG1lbW9yeSBpbnRvIHRoYXQgYnVmZmVyLiBUaGF0IHdpbGwg
bWFrZSBzdXJlIHlvdSBjYW4NCj4+PiB1c2UgYW55IGR5bnB0ciBhcyBhIHNvdXJjZSBvZiBkYXRh
LCBhbmQgb25seSBwYXkgdGhlIHByaWNlIG9mIG1lbW9yeQ0KPj4+IGNvcHkgaW4gcmFyZSBjYXNl
cyB3aGVyZSBpdCdzIG5lY2Vzc2FyeQ0KPj4gDQo+PiBJIGRvbid0IHF1aXRlIGZvbGxvdyBoZXJl
LiBDdXJyZW50bHksIHdlIGhhdmUNCj4+IA0KPj4gYnBmX2R5bnB0cl9kYXRhKCkNCj4+IGJwZl9k
eW5wdHJfc2xpY2UoKQ0KPj4gYnBmX2R5bnB0cl9zbGljZV9yZHdyKCkNCj4+IGJwZl9keW5wdHJf
d3JpdGUoKQ0KPj4gDQo+PiBBRkFJQ1QsIHRoZXkgYXJlIHN1ZmZpY2llbnQgdG8gY292ZXIgZXhp
c3RpbmcgdXNlIGNhc2VzIChhbmQgdGhlIG5ldw0KPj4gdXNlIGNhc2Ugd2UgYXJlIGFkZGluZyBp
biB0aGlzIHNldCkuIFdoYXQncyB0aGUgbmV3IGtmdW5jIGFyZSB5b3UNCj4+IHRoaW5raW5nIGFi
b3V0Pw0KPiANCj4gSSB3YXNuJ3QgdGFsa2luZyBhYm91dCBrZnVuY3MsIGJ1dCByYXRoZXIganVz
dCBpbnRlcm5hbCBoZWxwZXJzIHRvIGJlDQo+IHVzZWQgYnkgb3RoZXIga2Z1bmNzIHdoZW4gd29y
a2luZyB3aXRoIGR5bnB0cnMgYXMgaW5wdXQgYXJndW1lbnRzLg0KDQpBRkFJQ1QsIGtmdW5jcyBj
YW4gY2FsbCBvdGhlciBrZnVuY3MsIGZvciBleGFtcGxlIGJwZl9keW5wdHJfc2xpY2VfcmR3cigp
DQpjYWxscyBicGZfZHlucHRyX3NsaWNlKCkuIFRoaXMgaXMgbGltaXRlZCB0byB0aGUgc2FtZSBm
aWxlIGF0IHRoZSBtb21lbnQsIA0Kc2luY2Ugd2UgZG8gbm90IGV4cG9zZSBrZnVuY3MgaW4gaGVh
ZGVycy4gDQoNCg0KVGhhbmtzLA0KU29uZw0KDQo=


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6D585819
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 04:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiG3Cqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 22:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiG3Cqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 22:46:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF11447BA0
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 19:46:36 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26TLP6kb022727
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 19:46:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Owj/2Fpee/OMa2X5xGy9/+rMgRxv8TQqFEbvFuhiKQQ=;
 b=c2NwxjmMUnY9fEwdjRydD3rgIBwJ+H8CVCiYAmIzjQ147rmZYclSDHDreEFeQeuWrfIR
 JVsVM6vDBzWs4ZIy5pYRjrP6ANk5SKeirRoCz7zAj3k2nA06o8nA4M0nGHo1fu9E31g5
 N1ciJExoIGAfGE+x8Q4/chF2JV5XXopGmV0= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hmqetscum-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 19:46:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXBLdox3wbz0dPY4eV9gKw3zgI8AvUh6IFtSWOXhj1O2mqMIcsnwmFbG3ogwsSe7hR7XPriP3jVaE2aKIxrkilJLSLUsMj8t8R+ub98SJgh8094VSHZOoF+BUmOV1UedzIrDzeLgi9SDJYfgdspgVa8FTDeXWIUtSn3iNphLP4HHNQ4aFBlR8fxdlyvJ26IUpWPPJ4AO3ufNDYhBird8DT8UQ4H+quWlH1WHrkd/iFmX+po+th/fZDIYQYtrZku5L+pv5ZVFLYIxeRh6xIL/1SyAnoCwz7Aqs414WEJCzwy9gsVz5fJULR4giu3aCevtQmDN6h1Z9eDsQRsEzd7Xyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Owj/2Fpee/OMa2X5xGy9/+rMgRxv8TQqFEbvFuhiKQQ=;
 b=IyzuuVlmOjIk+Df2H0kNGJmW9hv5N2dYcthEttvg/IJOI8j43sKhLL9uY3NmmcP4EuBpD6WqtNCrW5udRQLt1IkRmqUD9lqoJ13bOacvUDLn6mfagCduUpq5MsJrijYMXK40pYN1lEH9JELXNAuWr+Vt5+WiDuPBJJmWmUkdH73BdY7w8qU0XurVPDHeyaqECHtUWjRRw5XMMgDGp/QQ8FNSlBwiiDlyn/+wckQK4MCsPrzbidH8kDHzXQTTn4EUz0XOT7seXShTfm7YgrhqrigMdf8uqgDJ3QVhCjqNvtFKbMp3A9dPY5CMzfH8U5hj7YSPh5r2F7yZNkIpnvDMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by PH0PR15MB4944.namprd15.prod.outlook.com (2603:10b6:510:c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Sat, 30 Jul
 2022 02:46:33 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5482.011; Sat, 30 Jul 2022
 02:46:33 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "memxor@gmail.com" <memxor@gmail.com>
CC:     Yonghong Song <yhs@fb.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYoK8StG1Y6n29KUSEV/VSsAjsP62QkM6AgAE54wCAABc7AIABYbAAgAA4cgCAAGyEgIAAEqgAgAAEzYCAAAW8AIACNgUA
Date:   Sat, 30 Jul 2022 02:46:33 +0000
Message-ID: <73a50faa6d9f36b1da75adb717887698cfe7d02a.camel@fb.com>
References: <20220726051713.840431-1-kuifeng@fb.com>
         <20220726051713.840431-2-kuifeng@fb.com> <Yt/aXYiVmGKP282Q@krava>
         <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
         <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
         <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
         <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
         <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com>
         <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
         <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com>
         <CAP01T74HRHapKDAfj104KNGnzCgNQSu_M5-KfEvGBNzLWNfd+Q@mail.gmail.com>
In-Reply-To: <CAP01T74HRHapKDAfj104KNGnzCgNQSu_M5-KfEvGBNzLWNfd+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2886b294-663b-4841-8c0d-08da71d5b699
x-ms-traffictypediagnostic: PH0PR15MB4944:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAibKN38qs/tIYnD5npnK9Kbyt/ALiHFO2XPLgqBo/eFrHEhDW6BBtGoDUkMZZhB0cHndz/kX+PncckCusctogkrYbcm74h7yfibICRj3yZZVWZ/8bbRplkmIOIaN/K4RWYT31SnDd62P8dwFJYXgF+8uhltCN6Fjse0K1hbR5KyI4h8/fk0xkGMpQtWOZD0CpH5yvhnApR7FzqS8wo0AACZ7RjerIY/6QHF6XFWTcgxugYjP/VvfQKifyua2jWGshW5YiCyXp7k5GTUsyr5uMs7SSiWN0YzfnvFuo3XCtBWVk5AOnbHjDyDhrdDBaai+6oiLY2n6ciMn5wWhR4/MhL8pVh5/fdMprNe0SKC8d1FTpMmB3tErHRnBYlzJjXpGSSVwa36dTv0ckjcIFLeDan478XKTdqxMUCZTz38HGoZlwe3dT4IUS5+RKhnfpwnwyBzIKWDkSa4y1W9XyL+BRkAS6Dy3mJPVLFp2jYk46wibS1weAhzydh1TMt3Im6VUg7uZLbph0NTXyM7Hj345/F++axvL7qUDWOACiPXD8skqmeCBYcCflVTimQ5Oj76ggbEUjw3WrNMwJuH8hXWuP7NTFbfhgZA4fhPcKKL3mWPqmCyrbX4kLsR/YvRmnrIYuyhyoYCnAcN/BHlfa53wdcslHGd1q0ILLMQIpjZEcHHR5riADLYbHF7muiNA4RuDzamvYw3xW7PKK63zE8T1geFgXiOjlFYgQgpCL/tAKHWrbX7CI4YYTOunMJOhE0jed9EAcUG3rTBvenSauZY+THBNXV/U0hkaXiktvRKMlJ11wB9qRY5niXCFHdCeaPv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(122000001)(5660300002)(38070700005)(41300700001)(8936002)(8676002)(66446008)(478600001)(71200400001)(76116006)(66946007)(4326008)(83380400001)(316002)(66476007)(66556008)(64756008)(2616005)(186003)(6916009)(6486002)(38100700002)(6506007)(54906003)(86362001)(36756003)(6512007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3IxaDhVMUNHZUczWDlueXpuLzZNYW14cmdTV2NwSmI5MUxmWExvcDNSWmZj?=
 =?utf-8?B?SXV4MUF0MU9kUVpocEppUnQyaFJoV3pmNGJlcFlLRTBldzdXalgySDNtbTNw?=
 =?utf-8?B?VTU5UDNTTVpxb05mc214aWR5OVp1UXduLzlncVo1dVlwRGdYWnNXcGxFdnpn?=
 =?utf-8?B?NG1XblY1UE16MVdxdmF4anArOVNKazdsS0c0SzdtMnYyNk04aTlmWXF1N3Ri?=
 =?utf-8?B?ZlAwbkZMY3dpZVpNc1NDNE43TFFGMHZJME5sY1Mzc1RSb2hQdEJ3cWxOV0sy?=
 =?utf-8?B?bHFMZDJlUU8wYjFzRnVuM01pQmlTdzM2bzZRUDgrZkZjNnVhRXRJRXRmNTBk?=
 =?utf-8?B?WFBtTzlDNzBqR0ZGcGRWSGtsUDNILzMzTVJjSGFEamxZcGhhV3VrbVRZQkcy?=
 =?utf-8?B?cGhLUEJaM2czKzIzTC8yR05DUS9nRExCaGU0K1dkcDBubmhRaUdBSWlham0v?=
 =?utf-8?B?aXZITThhQ3F6Z0NCQXByVkZVUHEvVlpGRjJXUlVwSk1wOVdjSmo4WWRuUTFB?=
 =?utf-8?B?anFDYzEyVGQwTVJjR050Sm1zekVUQk42Um11emFSZ0UvcjJwRUtyMUtSRzR3?=
 =?utf-8?B?R29iOGZoK2RHZGtES1lkODdQZGpVNkhIeHpWeVd3VjZvMy8xOHdUTjNHQWFo?=
 =?utf-8?B?NXJOa2tSekhBR0pmOGozTjhjRG84eUY2K0EvY2QvbmxrQ3lIanpMS1lCTUlk?=
 =?utf-8?B?eTBJZFY3djN6R0ZTbUZ2TCtyM2VSc1l2YktYVmhlcXNYbTNFbVBHUGFzRmls?=
 =?utf-8?B?dVU0UHhOZ1hBZjdUVWhaN2M4L05IeTNEeW9zY1NQTnhjblhhc2JtandxUEdz?=
 =?utf-8?B?RzM3MmU4QnZwd0pZRFhYVGNjY0kwNFdvMUljSkVMZHhLcWFUTG54c3lpellM?=
 =?utf-8?B?RWVCZnZSZ3p3VE1jQ1Bjc2xhLzdQTFEzMjVJMHZ6dnIvWlBGTE9BSnp5NTZT?=
 =?utf-8?B?bCtVZ2F5cy95VWNUWjF4NFpsbWY0UUMwMXR1US9GZm1wNTBNM2RjcURkRWZT?=
 =?utf-8?B?aXl0ZW1Wd2hWZVF5djVZVjVsb1E4TlE4S3BVQnBVTHlCN2IvdHoweFhoMkox?=
 =?utf-8?B?ZENhbllzNXl3eEs0SHR3VTV6Y1UvVUVld0VlZnpGbUJrU29aa1ljR3lORHpl?=
 =?utf-8?B?Kzlka2NRWFhzc1duL0pNdy9PRzhKQmRuQmVHU1hjbE1ESERxSVQybnZHbHNS?=
 =?utf-8?B?dUo1NlU1KzUrU0VMTy9zdURjZ2JJYmdMejFYSElXT0Z1ckNBUW1JYlZiUmgx?=
 =?utf-8?B?VWZKZC9EcHk5THRKbzNqMko4UTJuYjFoK0M5YURiYzFEMUJzQlBtcENuc0VX?=
 =?utf-8?B?eWhmMXR5NTRCaVR6UDJrdmczNjZqNGxGRU5YUFNXMjVQSVVIbXlhZ0RxZW9j?=
 =?utf-8?B?c214TUk4cmV6M1JYK012cjdJNTh1c1Yya1hpTG1mSktSa2x3UFlYQ280Q0sx?=
 =?utf-8?B?dEFCTEZxWHk3MEZHNkhWYjJxUHhRVGN1azd3ZHV0VHdSU1Q5ZEJWb2p2VElW?=
 =?utf-8?B?aURnbEhna2ZSUGtrTFE0QWROSEFHaWVyTTA5STBOYVRreWl3WWY1OUcrSzJB?=
 =?utf-8?B?dVhQZmVtTTlVelQ3K1F6dmwza25WaDQ1VTlpVUZZOGtucUcyVW5MZWFneFcy?=
 =?utf-8?B?d1B2Nzg3Y0hDWHFIV05XMTVsNHU3VlQ5MVBHcXMrMC96Z3ltTTJZay9HVWtX?=
 =?utf-8?B?amRGVk02Wkx4dFRrbTJGcllYZjNkbGVvTTZGQzU0aFZWYjNUM0ZKbkZNVXQr?=
 =?utf-8?B?UXhzQ0xVbTUwY1gxVlhLWkNHYmgzcjl1MDgwaXoyeXNvYVlkUUJEOHl1NTFY?=
 =?utf-8?B?WkRKbmg3MlNTcDVrQ1pha1Zzem9kekNKdGpCSG4yc2pFWmdLL2xJMy9CeXJm?=
 =?utf-8?B?T1ZZL21BSlA5WmMvY29JMlhaQjd2N1VSSHJWL1piKy9DZVRkeERqQkNFRGx1?=
 =?utf-8?B?aExRS0JWdG1MYzVKdWtXTmZjMXkwLzRmaGhDbXdhYjd5R3J0SUVVZHk3SlZT?=
 =?utf-8?B?SHRSQ1lGZkcyZEhDOG84dk5oeUU4clduRVlBZnpqWDZ0UUxCblZYd0pFSkpr?=
 =?utf-8?B?ZWdlVmltUzQ4QTZWTTBRdmdLODBFb3lTMTBFSmNpWkorb25ha1VMQWp0YmVN?=
 =?utf-8?B?WHBUL2pObm1TUFNBR1ZDdzY3SjhiMy8xN2FEdWxwZm1XMjdrRzBWNlRwU1ha?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64D66EBB0D9ABD43B15E64745B3278B4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2886b294-663b-4841-8c0d-08da71d5b699
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2022 02:46:33.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fy/jadnQbYAZ2vlQkLfZoomGPziSVYeI2yVaKau93h1FrPU8adCSeDhmz6Fp6z3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4944
X-Proofpoint-ORIG-GUID: KOrRdCpJQJYJuF8Pl4PzSAW7z6ptilPy
X-Proofpoint-GUID: KOrRdCpJQJYJuF8Pl4PzSAW7z6ptilPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-30_01,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTI4IGF0IDE5OjAwICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVk
aSB3cm90ZToNCj4gT24gVGh1LCAyOCBKdWwgMjAyMiBhdCAxODo0MCwgS3VpLUZlbmcgTGVlIDxr
dWlmZW5nQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIyLTA3LTI4IGF0IDE4
OjIyICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaSB3cm90ZToNCj4gPiA+IE9uIFRodSwg
MjggSnVsIDIwMjIgYXQgMTc6MTYsIEt1aS1GZW5nIExlZSA8a3VpZmVuZ0BmYi5jb20+DQo+ID4g
PiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFRodSwgMjAyMi0wNy0yOCBhdCAxMDo0NyAr
MDIwMCwgS3VtYXIgS2FydGlrZXlhIER3aXZlZGkNCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
T24gVGh1LCAyOCBKdWwgMjAyMiBhdCAwNzoyNSwgS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNv
bT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gV2VkLCAy
MDIyLTA3LTI3IGF0IDEwOjE5ICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVkaQ0KPiA+ID4g
PiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IE9uIFdlZCwgMjcgSnVsIDIwMjIgYXQgMDk6MDEs
IEt1aS1GZW5nIExlZQ0KPiA+ID4gPiA+ID4gPiA8a3VpZmVuZ0BmYi5jb20+DQo+ID4gPiA+ID4g
PiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAy
Mi0wNy0yNiBhdCAxNDoxMyArMDIwMCwgSmlyaSBPbHNhIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+
ID4gT24gTW9uLCBKdWwgMjUsIDIwMjIgYXQgMTA6MTc6MTFQTSAtMDcwMCwgS3VpLUZlbmcNCj4g
PiA+ID4gPiA+ID4gPiA+IExlZQ0KPiA+ID4gPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
PiA+ID4gPiA+IEFsbG93IGNyZWF0aW5nIGFuIGl0ZXJhdG9yIHRoYXQgbG9vcHMgdGhyb3VnaA0K
PiA+ID4gPiA+ID4gPiA+ID4gPiByZXNvdXJjZXMNCj4gPiA+ID4gPiA+ID4gPiA+ID4gb2YNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gb25lDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRhc2svdGhyZWFkLg0K
PiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gUGVvcGxlIGNvdWxkIG9u
bHkgY3JlYXRlIGl0ZXJhdG9ycyB0byBsb29wIHRocm91Z2gNCj4gPiA+ID4gPiA+ID4gPiA+ID4g
YWxsDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHJlc291cmNlcyBvZg0KPiA+ID4gPiA+ID4gPiA+ID4g
PiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0aG91Z2gNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gdGhleQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiB3ZXJlDQo+ID4gPiA+ID4g
PiA+ID4gPiA+IGludGVyZXN0ZWQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gaW4gb25seSB0aGUgcmVz
b3VyY2VzIG9mIGEgc3BlY2lmaWMgdGFzayBvcg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBwcm9jZXNz
Lg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBQYXNzaW5nDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZQ0K
PiA+ID4gPiA+ID4gPiA+ID4gPiBhZGRpdGlvbmFsIHBhcmFtZXRlcnMsIHBlb3BsZSBjYW4gbm93
IGNyZWF0ZSBhbg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBpdGVyYXRvciB0bw0KPiA+ID4gPiA+ID4g
PiA+ID4gPiBnbw0KPiA+ID4gPiA+ID4gPiA+ID4gPiB0aHJvdWdoIGFsbCByZXNvdXJjZXMgb3Ig
b25seSB0aGUgcmVzb3VyY2VzIG9mIGENCj4gPiA+ID4gPiA+ID4gPiA+ID4gdGFzay4NCj4gPiA+
ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEt1aS1G
ZW5nIExlZSA8a3VpZmVuZ0BmYi5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4g
PiA+ID4gPiA+ID4gPiDCoCBpbmNsdWRlL2xpbnV4L2JwZi5owqAgwqAgwqAgwqAgwqAgwqAgfMKg
IDQgKysNCj4gPiA+ID4gPiA+ID4gPiA+ID4gwqAgaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5owqAg
wqAgwqAgwqB8IDIzICsrKysrKysrKysNCj4gPiA+ID4gPiA+ID4gPiA+ID4gwqAga2VybmVsL2Jw
Zi90YXNrX2l0ZXIuY8KgIMKgIMKgIMKgIMKgfCA4MQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiArKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiAtLS0tDQo+ID4gPiA+
ID4gPiA+ID4gPiA+IC0tLS0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gwqAgdG9vbHMvaW5jbHVkZS91
YXBpL2xpbnV4L2JwZi5oIHwgMjMgKysrKysrKysrKw0KPiA+ID4gPiA+ID4gPiA+ID4gPiDCoCA0
IGZpbGVzIGNoYW5nZWQsIDEwOSBpbnNlcnRpb25zKCspLCAyMg0KPiA+ID4gPiA+ID4gPiA+ID4g
PiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+ID4gPiA+ID4gPiA+ID4gPiA+IGIv
aW5jbHVkZS9saW51eC9icGYuaA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCAxMTk1MDAyOTI4
NGYuLmM4ZDE2NDQwNGUyMCAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLS0tIGEvaW5jbHVk
ZS9saW51eC9icGYuaA0KPiA+ID4gPiA+ID4gPiA+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2Jw
Zi5oDQo+ID4gPiA+ID4gPiA+ID4gPiA+IEBAIC0xNzE4LDYgKzE3MTgsMTAgQEAgaW50IGJwZl9v
YmpfZ2V0X3VzZXIoY29uc3QNCj4gPiA+ID4gPiA+ID4gPiA+ID4gY2hhcg0KPiA+ID4gPiA+ID4g
PiA+ID4gPiBfX3VzZXINCj4gPiA+ID4gPiA+ID4gPiA+ID4gKnBhdGhuYW1lLCBpbnQgZmxhZ3Mp
Ow0KPiA+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+ID4gwqAgc3RydWN0IGJw
Zl9pdGVyX2F1eF9pbmZvIHsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gwqAgwqAgwqAgwqAgwqBzdHJ1
Y3QgYnBmX21hcCAqbWFwOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiArwqAgwqAgwqAgwqBzdHJ1Y3Qg
ew0KPiA+ID4gPiA+ID4gPiA+ID4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3UzMsKgIMKg
dGlkOw0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBzaG91bGQgYmUganVz
dCB1MzIgPw0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IE9yLCBzaG91bGQgY2hh
bmdlIHRoZSBmb2xsb3dpbmcgJ3R5cGUnIHRvIF9fdTg/DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gdXNlIGEgcGlkZmQgaW5zdGVhZCBvZiBhIHRp
ZCBoZXJlPw0KPiA+ID4gPiA+ID4gPiBVbnNldA0KPiA+ID4gPiA+ID4gPiBwaWRmZA0KPiA+ID4g
PiA+ID4gPiB3b3VsZCBtZWFuIGdvaW5nIG92ZXIgYWxsIHRhc2tzLCBhbmQgYW55IGZkID4gMCBp
bXBsaWVzDQo+ID4gPiA+ID4gPiA+IGF0dGFjaGluZw0KPiA+ID4gPiA+ID4gPiB0bw0KPiA+ID4g
PiA+ID4gPiBhDQo+ID4gPiA+ID4gPiA+IHNwZWNpZmljIHRhc2sgKGFzIGlzIHRoZSBjb252ZW50
aW9uIGluIEJQRiBsYW5kKS4gTW9zdCBvZg0KPiA+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+
ID4gbmV3DQo+ID4gPiA+ID4gPiA+IFVBUElzIHdvcmtpbmcgb24gcHJvY2Vzc2VzIGFyZSB1c2lu
ZyBwaWRmZHMgKHRvIHdvcmsgd2l0aA0KPiA+ID4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gPiA+IHN0
YWJsZQ0KPiA+ID4gPiA+ID4gPiBoYW5kbGUgaW5zdGVhZCBvZiBhIHJldXNhYmxlIElEKS4NCj4g
PiA+ID4gPiA+ID4gVGhlIGl0ZXJhdG9yIHRha2luZyBhbiBmZCBhbHNvIGdpdmVzIGFuIG9wcG9y
dHVuaXR5IHRvDQo+ID4gPiA+ID4gPiA+IEJQRg0KPiA+ID4gPiA+ID4gPiBMU01zDQo+ID4gPiA+
ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiA+IGF0dGFjaCBwZXJtaXNzaW9ucy9wb2xpY2llcyB0byBp
dCAob25jZSB3ZSBoYXZlIGEgZmlsZQ0KPiA+ID4gPiA+ID4gPiBsb2NhbA0KPiA+ID4gPiA+ID4g
PiBzdG9yYWdlDQo+ID4gPiA+ID4gPiA+IG1hcCkgZS5nLiB3aGV0aGVyIGNyZWF0aW5nIGEgdGFz
ayBpdGVyYXRvciBmb3IgdGhhdA0KPiA+ID4gPiA+ID4gPiBzcGVjaWZpYw0KPiA+ID4gPiA+ID4g
PiBwaWRmZA0KPiA+ID4gPiA+ID4gPiBpbnN0YW5jZSAoYmFja2VkIGJ5IHRoZSBzdHJ1Y3QgZmls
ZSkgd291bGQgYmUgYWxsb3dlZCBvcg0KPiA+ID4gPiA+ID4gPiBub3QuDQo+ID4gPiA+ID4gPiA+
IFlvdSBhcmUgdXNpbmcgZ2V0cGlkIGluIHRoZSBzZWxmdGVzdCBhbmQga2VlcGluZyB0cmFjayBv
Zg0KPiA+ID4gPiA+ID4gPiBsYXN0X3RnaWQNCj4gPiA+ID4gPiA+ID4gaW4NCj4gPiA+ID4gPiA+
ID4gdGhlIGl0ZXJhdG9yLCBzbyBJIGd1ZXNzIHlvdSBkb24ndCBldmVuIG5lZWQgdG8gZXh0ZW5k
DQo+ID4gPiA+ID4gPiA+IHBpZGZkX29wZW4NCj4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+
ID4gd29yayBvbiB0aHJlYWQgSURzIHJpZ2h0IG5vdyBmb3IgeW91ciB1c2UgY2FzZSAoYW5kDQo+
ID4gPiA+ID4gPiA+IGZkdGFibGUNCj4gPiA+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gPiA+IG1t
DQo+ID4gPiA+ID4gPiA+IGFyZQ0KPiA+ID4gPiA+ID4gPiBzaGFyZWQgZm9yIFBPU0lYIHRocmVh
ZHMgYW55d2F5LCBzbyBmb3IgdGhvc2UgdHdvIGl0DQo+ID4gPiA+ID4gPiA+IHdvbid0DQo+ID4g
PiA+ID4gPiA+IG1ha2UgYQ0KPiA+ID4gPiA+ID4gPiBkaWZmZXJlbmNlKS4NCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IFdoYXQgaXMgeW91ciBvcGluaW9uPw0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBEbyB5b3UgbWVhbiByZW1vdmVkIGJvdGggdGlkIGFuZCB0eXBlLCBhbmQgcmVw
bGFjZSB0aGVtDQo+ID4gPiA+ID4gPiB3aXRoIGENCj4gPiA+ID4gPiA+IHBpZGZkPw0KPiA+ID4g
PiA+ID4gV2UgY2FuIGRvIHRoYXQgaW4gdWFwaSwgc3RydWN0IGJwZl9saW5rX2luZm8uwqAgQnV0
LCB0aGUNCj4gPiA+ID4gPiA+IGludGVyYWwNCj4gPiA+ID4gPiA+IHR5cGVzLA0KPiA+ID4gPiA+
ID4gZXguIGJwZl9pdGVyX2F1eF9pbmZvLCBzdGlsbCBuZWVkIHRvIHVzZSB0aWQgb3Igc3RydWN0
IGZpbGUNCj4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiBhdm9pZA0KPiA+ID4gPiA+ID4gZ2V0
dGluZyBmaWxlIGZyb20gdGhlIHBlci1wcm9jZXNzIGZkdGFibGUuwqAgSXMgdGhhdCB3aGF0DQo+
ID4gPiA+ID4gPiB5b3UNCj4gPiA+ID4gPiA+IG1lYW4/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBZZXMsIGp1c3QgZm9yIHRoZSBVQVBJLCBpdCBpcyBzaW1pbGFyIHRvIHRh
a2luZyBtYXBfZmQgZm9yDQo+ID4gPiA+ID4gbWFwDQo+ID4gPiA+ID4gaXRlci4NCj4gPiA+ID4g
PiBJbiBicGZfbGlua19pbmZvIHdlIHNob3VsZCByZXBvcnQganVzdCB0aGUgdGlkLCBqdXN0IGxp
a2UgbWFwDQo+ID4gPiA+ID4gaXRlcg0KPiA+ID4gPiA+IHJlcG9ydHMgbWFwX2lkLg0KPiA+ID4g
PiANCj4gPiA+ID4gSXQgc291bmRzIGdvb2QgdG8gbWUuDQo+ID4gPiA+IA0KPiA+ID4gPiBPbmUg
dGhpbmcgSSBuZWVkIGEgY2xhcmlmaWNhdGlvbi4gWW91IG1lbnRpb25lZCB0aGF0IGEgZmQgPiAw
DQo+ID4gPiA+IGltcGxpZXMNCj4gPiA+ID4gYXR0YWNoaW5nIHRvIGEgc3BlY2lmaWMgdGFzaywg
aG93ZXZlciBmZCBjYW4gYmUgMC4gU28sIGl0DQo+ID4gPiA+IHNob3VsZCBiZQ0KPiA+ID4gPiBm
ZA0KPiA+ID4gPiA+ID0gMC4gU28sIGl0IGZvcmNlcyB0aGUgdXNlciB0byBpbml0aWFsaXplIHRo
ZSB2YWx1ZSBvZiBwaWRmZA0KPiA+ID4gPiA+IHRvIC0NCj4gPiA+ID4gPiAxLg0KPiA+ID4gPiBT
bywgZm9yIGNvbnZlbmllbmNlLCB3ZSBzdGlsbCBuZWVkIGEgZmllbGQgbGlrZSAndHlwZScgdG8g
bWFrZQ0KPiA+ID4gPiBpdA0KPiA+ID4gPiBlYXN5DQo+ID4gPiA+IHRvIGNyZWF0ZSBpdGVyYXRv
cnMgd2l0aG91dCBhIGZpbHRlci4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFJpZ2h0LCBidXQg
aW4gbG90cyBvZiBCUEYgVUFQSSBmaWVsZHMsIGZkIDAgbWVhbnMgZmQgaXMgdW5zZXQsIHNvDQo+
ID4gPiBpdA0KPiA+ID4gaXMgZmluZSB0byByZWx5IG9uIHRoYXQgYXNzdW1wdGlvbi4gRm9yIGUu
Zy4gZXZlbiBmb3IgbWFwX2ZkLA0KPiA+ID4gYnBmX21hcF9lbGVtIGl0ZXJhdG9yIGNvbnNpZGVy
cyBmZCAwIHRvIGJlIHVuc2V0LiBUaGVuIHlvdSBkb24ndA0KPiA+ID4gbmVlZA0KPiA+ID4gdGhl
IHR5cGUgZmllbGQuDQo+ID4gDQo+ID4gSSBqdXN0IHJlYWxpemUgdGhhdCBwaWRmZCBtYXkgYmUg
bWVhbmluZ2xlc3MgZm9yIHRoZSBicGZfbGlua19pbmZvDQo+ID4gcmV0dXJuZWQgYnkgYnBmX29i
al9nZXRfaW5mb19ieV9mZCgpIHNpbmNlIHRoZSBvcmlnaW4gZmQgbWlnaHQgYmUNCj4gPiBjbG9z
ZWQgYWxyZWFkeS7CoCBTbywgSSB3aWxsIGFsd2F5cyBzZXQgaXQgYSB2YWx1ZSBvZiAwLg0KPiA+
IA0KPiANCj4gRm9yIGJwZl9saW5rX2luZm8sIHdlIHNob3VsZCBvbmx5IGJlIHJldHVybmluZyB0
aGUgdGlkIG9mIHRoZSB0YXNrIGl0DQo+IGlzIGF0dGFjaGVkIHRvLCB5b3UgY2Fubm90IHJlcG9y
dCB0aGUgcGlkZmQgaW4gYnBmX2xpbmtfaW5mbw0KPiBjb3JyZWN0bHkgKGFzIHlvdSBhbHJlYWR5
IHJlYWxpc2VkKS4gQnkgZGVmYXVsdCB0aGlzIHdvdWxkIGJlIDAsDQo+IHdoaWNoIGlzIGFsc28g
YW4gaW52YWxpZCB0aWQsIGJ1dCB3aGVuIHBpZGZkIGlzIHNldCBpdCB3aWxsIGJlIHRoZQ0KPiB0
aWQgb2YgdGhlIHRhc2sgaXQgaXMgYXR0YWNoZWQgdG8sIHNvIGl0IHdvcmtzIHdlbGwuDQoNCg0K
V2UgaGF2ZSBhIGxvdCBvZiBkaWN1c3Npb25zIGFyb3VuZCB1c2luZyB0aWQgb3IgcGlkZmQ/DQpL
dW1hciBhbHNvIG1lbnRpb25lZCBhYm91dCByZW1vdmluZyAndHlwZScuDQpIb3dldmVyLCBJIGhh
dmUgYSBmZWVsIHRoYXQgd2UgbmVlZCB0byBrZWVwICd0eXBlJyBpbiBzdHJ1Y3QNCmJwZl9saW5r
X2luZm8uICBJIGNhbSBpbWFnaW5lIHRoYXQgd2UgbWF5IGxpa2UgdG8gY3JlYXRlIGl0ZXJhdG9y
cyBvZg0KdGFza3MgaW4gYSBjZ3JvdXAgb3Igb3RoZXIgcGFyYW10ZXJzIGluIGZ1dGh1cmUuICAn
dHlwZScgd2lsbCBoZWxwIHVzDQp0byB0ZWxsIHRoZSB0eXBlcyBvZiBhIHBhcmFtZXRlci4NCg0K
DQo=

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BF05A845D
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 19:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiHaR2b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 13:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiHaR2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 13:28:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0423F1DA
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:27:44 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27VGmikq025412
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:27:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7Ix1jHtXKJru51fqiaWDyHps3wTay31Tns6A8mSgPl4=;
 b=i7E8Uuzdq3+agS5Io+dgKl0DRYJqS1SAUReKuIOCnrKnZTx6N674TP03qu7HpwclbFuL
 UxO8t73a4NBuUjk3KVnO8CED0+NCnOBPiercvB3lk+tGt5em7FMWqi0R8WoBcNi1k72z
 0REvldDG0fxUbvvLLk7q2GNy74vF1Lxsd90= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j9nks0d7k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmdeuqN7xaw7/oFXjlpx7G1fIc+sjghaRhpMvt1k+qQqXG1ih4EJdjSoGBtfaGZl3U7Q80td/Uq6q71iIofmXiD6yuEbaBIx6txQQhirRJgXYdCV7jrBC/SEN5MfcB2n1po7Ozk2r5JQwpxDnxAsjQrvu88lqrov5u4o8cRaIJSo5MIJzpTuXdiZu1SSo09cXoH7W4iV+BQpZYAnXH5ecgKo43NWmYoi1UZRW7wCi8BklRHoA6dXF9+4gNGcj/sDPu8RUxzpfhcnKQAiRsUGPMQdtgKU7HGJp0IAOtiq0bgCgIrAxKum7DnS6Be0+c8ON6NiLygzZISFw7lp6wdAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ix1jHtXKJru51fqiaWDyHps3wTay31Tns6A8mSgPl4=;
 b=A0aefKJBnyhYHcbS0UXXdTsQ757CxwryY7frkY6JlwyBawJ5fDp+oYvf51YtnFPio5pGhyuddJjrUGSyXXJ1DKEZ2JDpZrBuEKgKLpa4WE17mkUMU9Zf3wse+9CYYXQTeuEapS9xsQ5FbZ8avA902R+X7h14v3Acjtq82CmeShDaH4rVhGXPwQzE98c4eIMg3XrtyKTRcW87bmgDNpbMmPkKM6C+Nzysr+Wk9CpaFaZ8E+/vXR/qzKok4/SD2y+dVV/dQQ4LNVDIPt9m1ovzHS5ppphBqn2uOQ9GtXKVo+zQmkn1x6R4AnlM/lvGsLKSBMIFda1g76DHjxX/midBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (2603:10b6:208:3d::12)
 by CY4PR15MB1543.namprd15.prod.outlook.com (2603:10b6:903:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 17:27:37 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::a4e3:718b:acfa:4422]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::a4e3:718b:acfa:4422%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 17:27:37 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "ashokd@nutanix.com" <ashokd@nutanix.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dave Thaler <dthaler@microsoft.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "james.r.harris@intel.com" <james.r.harris@intel.com>,
        "quentin@isovalent.com" <quentin@isovalent.com>,
        Kernel Team <Kernel-team@fb.com>
CC:     Mykola Lysenko <mykolal@fb.com>
Subject: BPF office hours summary, August 2022
Thread-Topic: BPF office hours summary, August 2022
Thread-Index: AQHYvV73HFlD7Flg60WH9SmFpt8WvA==
Date:   Wed, 31 Aug 2022 17:27:37 +0000
Message-ID: <A01D4A82-2BD8-48CD-AB39-D139A081A28A@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3e469f9-665a-4632-427f-08da8b761995
x-ms-traffictypediagnostic: CY4PR15MB1543:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VnuYFcWeyKc786mm0mLn/BuxRwqb61xpbLTG3JQd3gacs+vhFCXJV9KJ4z2IfG937ua3mGmWuQc8JL8kOQVY25Z40zfJ/HuNtiWTH9y8gBV5gq2vMACcElgdikxwqPnE/uy7zDqeeCwEcamRj1wO6JQQ1WmNCU1OYfwfG1/F+NB1ypwfJ6ec0yfKrQCEi0DLOF3AmssJleHm7abO/L8pbncqa30ZpSOBUm9tTR5wm0bhx3N4YEUs7IfYp6CnT/58CG519MJy1AnuECJ/AQsNBr+4blwCsg4V4kcRrWL4BBzGTd0oaB2XcpjOYInU/FoiWxEnC9gUknI4PrTG5R0VATkqGNf6HguPw8zURgGqJQl3jKesWPqg0I1oh7bNQjiTTDgr80MvoCRaRv/hiKYhQBoBs8QcZ/opvW35Tk/+OWKaOgVRRpO18FBob7TGOzQxi31iCz9pOhQeT3awVqseSP3erYh8B3tXQZ5UxtueOgeQKu7xsoh/OhvjPovI7slVnA7VItnImI8KeIPuxIRhTa76sKuyrLoSzGehL7Ix5a3pdaSxmdFmaPRh00NVXV6tmDh1CNw2V6IxUj0tlhjRWBazvdzSgZkyMui//5OkhWAXU7udKQVZppSX8vkpJlovoQh5AxGhxv+FR+FIoKcbR8AsR+rNeIsUchwr9T2FC0CaxuEa5wWtUXQfB6dqLNUXlexoMUH3OTE7dTnh4TWBGtd7J5x0Kud/1lvYaJRCOiIkC/2xwIwXR0EA8mAOkNsToO46HcN0BT5YwT6yTR5C/aEC7WpG+JvqbqdqqDIx0NM9NczLukRFDHGpcv4oNn3IEEFadoeFd+pi7I9ILOrPRXjdeX/rDqg7zP7oyL9v8RQRK8SYgh3R8QhWBBeSZ078
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3213.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(66446008)(33656002)(64756008)(66556008)(66946007)(66476007)(4326008)(91956017)(76116006)(6636002)(110136005)(45080400002)(86362001)(8676002)(921005)(186003)(41300700001)(71200400001)(6486002)(478600001)(8936002)(38070700005)(966005)(316002)(36756003)(7416002)(83380400001)(2616005)(5660300002)(38100700002)(6512007)(6506007)(122000001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alBNdUpMVEFvM0tKUE91K0prUkY0UHhjK2ZORVp6Tm1HejA2OTZCREhMcDVP?=
 =?utf-8?B?dVM4UHdValY1VkZ1ZkhtOUVnOTlQYTJBQThtaVlDZlphcU81NnZlRFppSnFT?=
 =?utf-8?B?ZmJKeklXVTZUMFJUYWo2cC81UlNPS1FyaUk2SzNSU2luYm1FeS9MOFRnaTUx?=
 =?utf-8?B?RU4vT2lOZURuSWRrb2phQ2RvaGNvKzh0Y2ROQXI3QlgxMk0vcEliTUlPQ1ly?=
 =?utf-8?B?Y2xxNjBvYmxiQ0dRc3kvZEpyUmtQQ0QyRy96ZkExWGJZWjlOdUgxU2l4NC9J?=
 =?utf-8?B?bHovOENRQmVWQkVpMVZxa294b3FGZW5ZZHBIVGhwRG9LWFRvSThoZXZ5VlJC?=
 =?utf-8?B?cC9sVHA1VUk5aUdVSm85dlI1WmozVGN6bjhyUGsreEVCY3VMNEpDR3R4RnFN?=
 =?utf-8?B?R1N2cHU4ZUQ0clFQcFNhaTJ1dnBDY2Q2Z0VrY2Q4L1NHSnpMcWU0YmFhUkVx?=
 =?utf-8?B?aWpjT3dEb2U2KzVRdW1CUVMwbTFDREIzUEpUdGxaYXA1ZnNtOUFjSGNmeHEz?=
 =?utf-8?B?ZDRoUmxzekEwQmlSdmZSOFFCQU1MSWRQWUNza3JKSk0vTkxwMFNGVEFwVmVS?=
 =?utf-8?B?U2RyMi9va3h3YVF6eDI4WWdrNFNmNXZncVRRMTNWeGliUS9PeFIwaUdrN0k5?=
 =?utf-8?B?NjNBanRVbFVNZEJ2YThXbXV5YW1jaGxDWTY5VmI3NUhNNXMwbDV4c0VBRFZn?=
 =?utf-8?B?dW02eUx0YU9zNUxBSUdHK3JLdTczN1l3Z2RnU0VJanJqVlV3OVMyek83TGV3?=
 =?utf-8?B?T2VRbWVSU1hLMnp2RmswWnkwY2ZQVGpNM2dmb2xkaVFIRkJuYUJyTzNqYU1l?=
 =?utf-8?B?TWRYS2NqVXhQWkV6ZzJGVXcrNkU2VjU3dk5abElvQ0trbHU3NWgxMGV5b0pZ?=
 =?utf-8?B?QTlYcWxyQStnc1ZmUGJPRENVeW9zMUZ5ZmozUGpPdGV1NmNJQjRnMGFOSzVR?=
 =?utf-8?B?T3M1SkRQQXN5SHoxYzFBR3BMUGExNjRPb3F1cjI5QUszdlZlOWJFUisvTStV?=
 =?utf-8?B?MVgxaGVpbThxOGYzc3dRSEZXM1dvQnhMUFVRM2dwbFlDWHdyYUFmTy9icC9P?=
 =?utf-8?B?UTdxaEw4MmJXMjdxMVlOdUVqQzk5OERHQkJVN3Axd1pKekJ0d1cvTlYvMEsy?=
 =?utf-8?B?Z2YyTDN3UVEwTWVrYlhFNm1CaXdxZTB5MW85RGVZMTRDaFNkdmlTQjlERjQw?=
 =?utf-8?B?djYzcFpIdzduV3A3cExEY09SQkZnaDF2Rnd6NGxmQTZFZGJEWllrYmlWYkd4?=
 =?utf-8?B?RmJKQ1Jwd2JjVCtwTFNGT29nalBjMnM3bk9jSFFibThKTmlFYzBSNWNpeXRr?=
 =?utf-8?B?bFFmdk5rbW5kajgrOHdGaExqSHphS3FvZzNaNVJHNlRvcTFIMlRKS3c4eGxr?=
 =?utf-8?B?RUxCejUrNGhwTDJ3V1AyaC9QYmovU0UwNjZDeDhnQlJkMkR6Ri8vU3UyWk05?=
 =?utf-8?B?eWFRWjBBWXViRmF4RTBvbnM2UnNqNXEyaitIMnZLa29JazJGWDh0TE13d3hF?=
 =?utf-8?B?WDlicFhzWjU0MFIzY0RXRXhYQ0NRMm9xREJnbGhsUTVVUzJZd3dZdFpzeFAy?=
 =?utf-8?B?clhaYU1rcmoxU1NzSmo2UUlzQ3E5N1MrTll2RkF3WTRJYmpaOUg0Vzd4dXVW?=
 =?utf-8?B?MkJqSnhIMHBQUzczTTIwV1k2aGRNVTlqMDVMQk1ZeU02ZTdZeE41VFZGUUxo?=
 =?utf-8?B?aXdId3RJNWtnSThNeTZ6aWttdHNIb0huUFlKTmJFRU9OTXdGZVRoYmVHSmpT?=
 =?utf-8?B?RCtqU3VvaUtDRWhWS1FkSWVncVdhd2FCdHFFemNRTXNFYjJ6TXh3Rkx0WUdh?=
 =?utf-8?B?VkI5VFdNTitNWmdWVkk2MWYrRTg4eEhOVGRjZXRLMHZlL05sVVBXS1BiNGYx?=
 =?utf-8?B?UHV5aDZEM3BweDVwMkJ4SXZYZTBmV3RQcDYyZjdIZElhVTBhWEpHd2hteE1p?=
 =?utf-8?B?dnNjc25mbDlXTHlBV1N0NkJjZEpCZ21rMU1NZ0d4dWRKVmZTamNMYjlTSVMz?=
 =?utf-8?B?NjdYVXQyU05EWmlNWk03MjViNVl3ODlPeThnemUyQmtRYVMyMDJiTmNJZG8r?=
 =?utf-8?B?L1VLSDMzblJPUFk4Qmh3Z2QxSCtkNmZSREQzc2JDc1E1MlNlM3BQOXNPNWdn?=
 =?utf-8?B?c2dndW9TbDFRa3plQm1MenpDQktHL0plSjUvb3A3TXRVUDZsWHpIZFhhV0lV?=
 =?utf-8?Q?eyandWE+xG6hQkSlcBdvUaM/u+CJ8/b1n/+TQkuuZx57?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF52FB04DA2C1F4B83C7C7FDE93181EA@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3213.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e469f9-665a-4632-427f-08da8b761995
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 17:27:37.7648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s6mttjtLs/PoFn89aMnvoH9EoLnisajtCybOP+Ab01VaCZflF+v5Ymhno4L0HLYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1543
X-Proofpoint-GUID: ZHOJjShOAc9oCGkScWJ2jFN1oJM-liyB
X-Proofpoint-ORIG-GUID: ZHOJjShOAc9oCGkScWJ2jFN1oJM-liyB
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_10,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGVsbG8sDQoNCkJlbG93IHlvdSBjYW4gZmluZCBzaG9ydCBzdW1tYXJ5IG9mIEJQRiBvZmZpY2Ug
aG91cnMgdGhhdCBoYXBwZW5lZCBpbiBBdWd1c3QgMjAyMi4NCg0KTGV0IG1lIGtub3cgaWYgeW91
IGhhdmUgYW55IGZlZWRiYWNrIG9uIGhvdyB0byBpbXByb3ZlIHRoaXMgc3VtbWFyeSBsZXR0ZXIu
DQoNClRoYW5rcywNCk15a29sYQ0KDQo4LzQ6IOKAnERpc2N1c3MgZml4IHRvIHRjcF9pbnEgZm9y
IGJwZiBzb2NrbWFwIHNvY2tldCByZWRpcmVjdOKAnSB3aXRoIEFzaG9rIER3YXJha2luYXRoIDxh
c2hva2RAbnV0YW5peC5jb20+OiANCg0KQXNob2sgaXMgcnVubmluZyBpbnRvIGFuIGlzc3VlIHdo
ZW4gYW4gaW9jdGwgcmV0dXJucyBhbiBpbmNvcnJlY3QgbnVtYmVyIG9mIGJ5dGVzIHdoZW4gc29j
a29wcyBpcyBlbmFibGVkIChzaW1pbGFyIHRvIFsxXSkuIEhlIHRyaWVkIHRvIGZpZ3VyZSBvdXQg
d2hldGhlciBpdOKAmXMgYSBzb2Nrb3BzIGlzc3VlIG9yIGEgVENQIHN0YWNrIGlzc3VlLiBBc2hv
ayBmb3VuZCB0aGF0IEZJT05SRUFEIGlzbuKAmXQgaW1wbGVtZW50ZWQgZm9yIHNvY2tldHMgdGhh
dCBhcmUgaW4gdGhlIHNvY2ttYXAuIEhlIGhhcyBhIGZpeCBmb3IgbG9va2luZyBhdCBob3cgbWFu
eSBieXRlcyBhcmUgaW4gdGhlIGluZ3Jlc3MgbWVzc2FnZSBxdWV1ZSBhbmQgd3JpdGluZyBkb3du
IHRoZSBudW1iZXIgb2YgYnl0ZXMgdGhhdCBhcmUgdGhlcmUuIEFzaG9rIHBsYW5zIHRvIHN1Ym1p
dCBhIHBhdGNoIGZvciByZXZpZXcgdXBzdHJlYW0uDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20v
Y2lsaXVtL2NpbGl1bS9pc3N1ZXMvMTkzMDQNCg0KOC80OiDigJxEaXNjdXNzIGJwZl92ZXJpZnlf
cGtjczdfc2lnbmF0dXJlKCkga2Z1bmPigJ0gd2l0aCBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNh
c3N1QGh1YXdlaS5jb20+Og0KDQpSb2JlcnRvIFNhc3N1IHdhbnRlZCB0byBjbGFyaWZ5IEFsZXhl
aSBTdGFyb3ZvaXRvduKAmXMgcmVzcG9uc2UgdG8gb25lIG9mIGhpcyBwYXRjaGVzIGluIHRoZSDi
gJxicGY6IEFkZCBrZnVuY3MgZm9yIFBLQ1MjNyBzaWduYXR1cmUgdmVyaWZpY2F0aW9u4oCdIHBh
dGNoc2V0LiBBbGV4ZWkgZXhwbGFpbmVkIHRoYXQgaGlzIHJlcXVlc3Qgd2FzIHRvIHJlbW92ZSB0
aGUgX19yZWYgcGFyYW1ldGVyIHN1ZmZpeCBiZWNhdXNlIHRoZXJlIHdhc27igJl0IGEgdXNlIGNh
c2UgZm9yIGl0IGFuZCB0aGF0IGFsbCB0aGUgYXJncyBjYW4gYmUgbWFya2VkIGFzIHRydXN0ZWQg
aW4gdGhlIGJwZl92ZXJpZnlfcGtjczdfc2lnbmF0dXJlKCkgc2luY2UgYWxsIG9mIHRoZW0gYXJl
IHZhbGlkLiBSb2JlcnRvIGFza2VkIHdoZXRoZXIgdGhpcyB3b3VsZCB3b3JrIHNpbmNlIHRoZSBz
eXN0ZW1fa2V5cmluZyBwYXJhbWV0ZXIgaXMgb2YgdHlwZSDigJxsb25n4oCdLCBub3QgYSBwb2lu
dGVyLiBBbGV4ZWkgY2xhcmlmaWVkIHRoYXQgdGhlIHRydXN0IGlzIG9ubHkgcmVsZXZhbnQgdG8g
cG9pbnRlcnMgYW5kIGludGVnZXJzIGFyZSBhdXRvbWF0aWNhbGx5IHRydXN0ZWQuIEFkZGl0aW9u
YWxseSwgUm9iZXJ0byBhc2tlZCBhYm91dCBob3cgdG8gbWFrZSBkeW5hbWljIHBvaW50ZXJzIHRy
dXN0ZWQgdXNpbmcgS0ZfVFJVU1RFRF9BUkdTIGFubm90YXRpb24uIEFsZXhlaSBub3RlZCB0aGF0
IHRoaXMgaXMgY3VycmVudGx5IG5vdCBzdXBwb3J0ZWQuIFRoZW4sIFJvYmVydG8gYXNrZWQgaG93
IGJwZl92ZXJpZnlfcGtjczdfc2lnbmF0dXJlKCkgc2hvdWxkIGhhbmRsZSBwb3NzaWJsZSBOVUxM
IHBvaW50ZXJzIHRvIHVzZXIgb3Igc3lzdGVtIGtleXJpbmdzLiBEYW5pZWwgQm9ya21hbm4gc3Vn
Z2VzdGVkIGdldHRpbmcgcmlkIG9mIHRoZSB0d28ga2V5LXJlbGF0ZWQgcGFyYW1ldGVycyBhbmQg
aW1wbGVtZW50aW5nIGEgYnBmX2xvb2t1cF9bc3lzdGVtL3VzZXJdX2tleSgpIGtmdW5jIHRvIHBy
b2R1Y2Ugc3RydWN0IGJwZl9rZXkgY29udGFpbmluZyBwb2ludGVycyB0byBzeXN0ZW0gYW5kIHVz
ZXIga2V5cmluZ3MuDQoNCjgvMTE6IOKAnGVCUEYgc3RhbmRhcmRpemF0aW9uL2RvY3VtZW50YXRp
b27igJ0gd2l0aCBEYXZlIFRoYWxlciAoZHRoYWxlckBtaWNyb3NvZnQuY29tKSwgSmFtZXMgSGFy
cmlzIChqYW1lcy5yLmhhcnJpc0BpbnRlbC5jb20pIGFuZCBRdWVudGluIE1vbm5ldCAocXVlbnRp
bkBpc292YWxlbnQuY29tKQ0KDQpEYXZlIFRoYWxlciBmcm9tIE1pY3Jvc29mdCBsZWQgdGhlIEJQ
RiBzdGFuZGFyZGl6YXRpb24gZGlzY3Vzc2lvbi4gSGUgcmV2aWV3ZWQgc2xpZGVzIGRlc2NyaWJp
bmcgaGlzIGlkZWFzIG9uIGhvdyBzdGFuZGFyZGl6YXRpb24gc2hvdWxkIHByb2NlZWQgYW5kIHRv
b2sgbm90ZXMgaW5saW5lLiBBbGV4ZWksIERhbmllbCBCb3JrbWFuLCBLUCBTaW5naCwgRGF2ZSBU
dWNrZXIsIENocmlzdG9waCBIZWxsd2lnLCBKaW0gSGFycmlzLCBRdWVudGluIE1vbm5ldCBhbW9u
ZyBvdGhlcnMgYWN0aXZlbHkgcGFydGljaXBhdGVkLiBUaGUgbWFpbiBnb2FsIG9mIHRoaXMgZWZm
b3J0IGlzIHRvIGhhdmUgYSBjZW50cmFsIHNvdXJjZSBvZiB0cnV0aCBvbiBob3cgQlBGIHNob3Vs
ZCBiZSBpbXBsZW1lbnRlZCB3aXRob3V0IGdldHRpbmcgaW50byBwbGF0Zm9ybSBzcGVjaWZpYyBp
bXBsZW1lbnRhdGlvbiBkZXRhaWxzLiBQYXJ0aWNpcGFudHMgYWdyZWVkIHRoYXQg4oCcbXVzdC9z
aG91bGQvbWF54oCdIGxhbmd1YWdlIHNob3VsZCBiZSB1c2VkIHRocm91Z2hvdXQgdGhlIGRvY3Vt
ZW50KHMpIGFuZCBkb2N1bWVudChzKSB3aWxsIGhhdmUgdmVyc2lvbnMuIEluaXRpYWwgc2NvcGUg
d2lsbCBpbmNsdWRlIGEgZGVzY3JpcHRpb24gb2YgSVNBIChpbnN0cnVjdGlvbiBzZXQgYXJjaGl0
ZWN0dXJlKSwgRUxGIEZvcm1hdCwgQlRGIChmb3IgZGVidWcvbWV0YWRhdGEgaW5mbykgYW5kIHNv
bWUgdmVyaWZpZXIgZXhwZWN0YXRpb25zIG5vdCBjb3ZlcmVkIGJ5IElTQS4gU3RhbmRhcmRpemF0
aW9uIGFydGlmYWN0cyB3aWxsIGJlIHVwc3RyZWFtZWQgaW4gdGhlIExpbnV4IGtlcm5lbCB0cmVl
LiBDb21tdW5pY2F0aW9uIHdpbGwgYmUgZG9uZSBvdmVyIHRoZSBlbWFpbCB1c2luZyBCUEYgbWFp
bGluZyBsaXN0cy4gTm93LCB0aGUgQlBGIGNvbW11bml0eSB3aWxsIGxvb2sgZm9yIHZvbHVudGVl
cnMgdG8gZHJpdmUgdGhlIGVmZm9ydC4NCg0KOC8xODog4oCcc2NoZWR1bGVyIEJQRuKAnSB3aXRo
IFJlbiBaaGlqaWUgKHJlbnpoaWppZTJAaHVhd2VpLmNvbSkgYW5kIEhhbmp1biBHdW8gKGd1b2hh
bmp1bkBodWF3ZWkuY29tKSAgDQoNClJlbiBaaGlqaWUgbGVkIGEgcHJlc2VudGF0aW9uIFsxXSBh
Ym91dCBIdWF3ZWkgQlBGIHNjaGVkdWxlciBpbXBsZW1lbnRhdGlvbiBhbmQgY29uc2lkZXJhdGlv
bnMuIEh1YXdlaSBCUEYgc2NoZWR1bGVyIGlzIGJhc2VkIG9uIFJvbWFu4oCZcyBwYXRjaHNldCBb
Ml0gdGhhdCBpbnRyb2R1Y2VzIGEgc2V0IG9mIGhvb2tzIGFuZCBoZWxwZXJzIGluIENGUy4gVGhl
IGdvYWwgaXMgdG8gaGF2ZSBhIHNjaGVkdWxlciB0aGF0IGNhbiBiZSBlYXNpbHkgYWRvcHRlZCBm
b3IgZGlmZmVyZW50IHdvcmtsb2FkcyBpbmNsdWRpbmcgY2xvdWQgY29tcHV0aW5nLCBkYXRhYmFz
ZXMgYW5kIG1vYmlsZSBwbGF0Zm9ybXMuIFRoZSBIdWF3ZWkgcGF0Y2hzZXQgaXMgcmVhZHkgZm9y
IGluY2x1c2lvbiBpbnRvIHRoZSBPcGVuRXVsZXIgTGludXggZGlzdHJpYnV0aW9uLiBIdWF3ZWkg
cGF0Y2hzZXQgYWRkcyB0YWcgbWFuYWdlbWVudCBzeXN0ZW0sIGFkZGl0aW9uYWwgaG9va3MsIGhl
bHBlcnMsIGFuZCBzZWxmLXRlc3RzLiBBbGwgY29kZSBpcyBpc29sYXRlZCBiZWhpbmQgQ09ORklH
X0JQRl9TQ0hFRC4gdGFnIG1hbmFnZW1lbnQgc3lzdGVtIGFsbG93cyBncm91cGluZyB0YXNrcyB1
c2luZyB0aGUgc2FtZSBzY2hlZHVsaW5nIHBvbGljeSBhcyB3ZWxsIGFzIGNvbW11bmljYXRpb24g
YmV0d2VlbiBkaWZmZXJlbnQgTGludXgga2VybmVsIHN1YnN5c3RlbXMgYW5kIHVzZXItc3BhY2Uu
IHRhZyBpcyBhIHM2NCB2YWx1ZSBhZGRlZCB0byB0aGUgc3RydWN0IHRhc2sgYW5kIHN0cnVjdCB0
YXNrX2dyb3VwLiBIdWF3ZWkgQlBGIHNjaGVkdWxlciBwYXRjaGVzIGRvIG5vdCBzdXBwb3J0IGFk
dmFuY2VkIENGUyBmZWF0dXJlcyBsaWtlIGxvYWQgYmFsYW5jaW5nLCBsb2FkIHRyYWNraW5nIGFu
ZCBvdGhlcnMsIGFuZCBhcmUgbGVmdCBvdXQgb2YgdGhlIHNjb3BlIG9mIHRoZSBjdXJyZW50IHBy
b2plY3QuIEh1YXdlaSBwbGFucyB0byBzdGFydCB1cHN0cmVhbWluZyBlZmZvcnQgYXJvdW5kIHRo
ZSBlbmQgb2YgU2VwdGVtYmVyLiBUaGVuIGZvbGxvd2VkIHRoZSBkaXNjdXNzaW9uIGJldHdlZW4g
UmVuIFpoaWppZSwgSGFuanVuIEd1bywgSGFvIEx1byAoaGFvbHVvQGdvb2dsZS5jb20pLCBEYW4g
U2NoYXR6YmVyZyAoZHNjaGF0emJlcmdAZmIuY29tKSBhbmQgVGVqdW4gSGVvICh0akBrZXJuZWwu
b3JnKS4gR29vZ2xlIGlzIHdvcmtpbmcgb24gYSBzaW1pbGFyIGVmZm9ydCBjYWxsZWQgR2hvc3Qg
WzNdLiBNZXRhIGVuZ2luZWVycyBoYXZlIGFsc28gYmVlbiBsb29raW5nIGludG8gdmFyaW91cyBr
aW5kcyBvZiBzY2hlZHVsZXIgb3B0aW1pemF0aW9ucy4gRW5naW5lZXJzIGRpc2N1c3NlZCBkaWZm
ZXJlbnQgYXBwcm9hY2hlcyB0byB0aGUgcHJvYmxlbTogZnJvbSBleHRlbmRpbmcgQ0ZTIHdpdGgg
aG9va3MgdG8gYnVpbGRpbmcgYSBjb21wbGV0ZWx5IG5ldyBzY2hlZHVsaW5nIGNsYXNzIHdpdGgg
bG9naWMgaW1wbGVtZW50ZWQgaW4gQlBGLiAgQ2xlYXJseSBldmVyeSBhcHByb2FjaCBoYXMgcHJv
cyBhbmQgY29ucy4gSW4gdGhlIGVuZCwgZW5naW5lZXJzIGZyb20gSHVhd2VpLCBNZXRhIGFuZCBH
b29nbGUgYWdyZWVkIHRvIGNvbGxhYm9yYXRlIG9uIHRoZSBhbGlnbm1lbnQgYW5kIHVwc3RyZWFt
aW5nIGVmZm9ydC4NCg0KWzFdIGh0dHBzOi8vZ2l0ZWUuY29tL29wZW5ldWxlci9rZXJuZWwvaXNz
dWVzL0k1S1VGQiAoc2VlIHRoZSBQREYgc2xpZGVzIGF0dGFjaGVkKQ0KWzJdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2JwZi8yMDIxMDkxNjE2MjQ1MS43MDkyNjAtMS1ndXJvQGZiLmNvbS8NClsz
XSBodHRwczovL2RsLmFjbS5vcmcvZG9pLzEwLjExNDUvMzQ3NzEzMi4zNDgzNTQyDQo=

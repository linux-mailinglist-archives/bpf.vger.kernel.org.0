Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD54E3077
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 20:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352429AbiCUTHk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352420AbiCUTHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 15:07:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62F488B5;
        Mon, 21 Mar 2022 12:06:12 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22LGQFLC027765;
        Mon, 21 Mar 2022 12:06:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=p38wh3OU62Fp/PhNpxBlKtYcMH2L7Usoj0xQ0JZ2BEs=;
 b=RnEu+POamACRmu7ZXUjIx9nSoIYjAF4QMbOd9WLo4iNUnMBgoXFOH4TdSzJe9hHTPXnp
 6TPFteRkLBr0Z6ylBSurzRMj4CG2k3jCXMSup/QbZCEvE/nYGGhioqFmQiN4kwm7UJjS
 qy1eDbigrHDbkdrlWkrmskOkiipO9ZCbumY= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ewcvm3vf7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 12:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZZKi0xfsMx+JVs/9fl+pb22dW0rodXYTYWq91CWuLLPNn+b7ulndbBe3ebhX2W6Tijbsz2l9xF0yMKvkVxUM/svPyGHPSrW68HFdCfPD3dN356jNILYdLFaFbMYjNDDXvW+d4l3wedVkR8zLSMWV+LlX3XAO18sbxjWz4QMWYOtDJsMsEhcbfKMBihwLoqw5w363NOKhn8NEgySqYkC9dv8/fp9SH7d3RMNcfGdC39/5XDYLjVE46huRvVdb5BsUZ6Sq1kwbiKglphu3TmAMks89qLw4pK36RIZwutDaG4dXT42j6XV7gzjPOJmJLK5PY5fRSzj29m83sSDz4J0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p38wh3OU62Fp/PhNpxBlKtYcMH2L7Usoj0xQ0JZ2BEs=;
 b=dxvPKcD4LhtSQgnxoXA/WyeOG9IFQGfs5jOVPEmu4/N6l3tOUMqrRoRBXHY3uQPKDZBefK5T4jWKeggf8PGtJsCXmNZ1SNJNwhKPlHpP9yIaWsAczTNHEPKNk0InhVAhojKFK4wyn/DVm8nNi3cdy3qqjD5+N/4iaeoPHJWfSnMVQ9pzAfPm3DJWlSwYwgRPpnMMAWO4xIThOim6gAtFS4IVPm0ebhXDQp4GQMeW7eTRopCdbFci9NUgNfa+dcwNerJxHHDJ3+sVyjyyb+zseuT8euoF4/uebgrPA5Y8P+1G5ZYrHCpRWlbEV96iou+w9ITQVrDSHLRLjYOrZn/Wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MWHPR15MB1920.namprd15.prod.outlook.com (2603:10b6:301:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 19:06:06 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 19:06:06 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "acme@kernel.org" <acme@kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
Thread-Topic: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
Thread-Index: AQHYEunVOisdcUIjZ0CcgaB8+KOaz6x1t32AgADtkICAP8IvgIABSaSAgABQ9wCAAAEcAIAShKaA
Date:   Mon, 21 Mar 2022 19:06:06 +0000
Message-ID: <c9c436a6935bb39e4135d4f0d7efd1ecc49d660b.camel@fb.com>
References: <20220126192039.2840752-1-kuifeng@fb.com>
         <20220126192039.2840752-2-kuifeng@fb.com>
         <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
         <YfJudZmSS1yTkeP/@kernel.org>
         <CAEf4Bza8xB+yFb4qGPvM7YwvHCb1zQ8yosGbKj63vcRM7d9aLg@mail.gmail.com>
         <Yij/BSPgMl8/HEhg@kernel.org>
         <CAEf4BzZX8Q5MPt62+68nRoQNPe=3jnVkcEMMJwPzoU51YCBszg@mail.gmail.com>
         <CAEf4BzYxOgNjC+nFJGY_wpnOZZ-Jik=15L0aSq3Uxbiamc0h+w@mail.gmail.com>
In-Reply-To: <CAEf4BzYxOgNjC+nFJGY_wpnOZZ-Jik=15L0aSq3Uxbiamc0h+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ca71e57-4933-4f28-0a7d-08da0b6dda32
x-ms-traffictypediagnostic: MWHPR15MB1920:EE_
x-microsoft-antispam-prvs: <MWHPR15MB192032949D59684091BB503CCC169@MWHPR15MB1920.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoBg5tlkD2fxetvSP45vJ9vD83WKQTsKulwdBdyHLkCLvtAzkq5vhzPL+nvcBy3itu78m4uDuwtepGlSdWMfi9KE+oUrQuER4OkscPYSN5HLzkLLHBPAjth/2Sa+u25vP5NXYdEkv1Qi4/EZXAEzCjMfZv6hCw9C/UyT+NRluWKYDPmn6ESqM0OvIFE60n8sNpDNo21hDGZVjJ2HgxNl9R9jKjg1S6nbEa4Y1VwHQJ1Vq0g8dAjdmFrzQCMcNuc9Ee4BpjJRFW7parZhdhrrLiGkoi4s8f8mKKbWISos+LgvSlqB5VVW01Maf5hd6uFNJdASf8JehhbySji2IjZ0/tFZ6ftad7KuJ+xkSWVIhyjtVXyvsgQ+pGylh5QBgdX4gId+oT7E7/LSMJAVCmpBuLVz6Enjuo9zB9NVOHfuXRvVO0Q1McOK6ra5XNR+enmVd2SBayz9+Nu9fPwtlPv4ohfd8H6c6os8qkyW0rAO/E1UkdU+vOMU7wi2nNmhJdx5buls0ee0aCOLNnGv9k0MxvAWMOCDP2OXK4Cg1k0TMxTazwJYWJPpJLKPJxOfh3D0pa/w9iXs52Q5wdS/MrTgGnI6RH0Thg0Id+9T4QIhiecm7zXfnlBvvT9gdJeZQ0q3ewu+jdsdSc69WLIYXhCZc6/Z7c/eUYp21bXjlT+6vSsGcRBUPfUY5I9mK6Auz0AZYfsWGGUNmtifLLA9hl7SSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(8936002)(5660300002)(2906002)(122000001)(83380400001)(186003)(2616005)(38100700002)(8676002)(66476007)(66946007)(66446008)(86362001)(64756008)(66556008)(4326008)(110136005)(6486002)(508600001)(91956017)(316002)(76116006)(54906003)(6512007)(53546011)(71200400001)(6506007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGE2Z1NTMmRUdW5HS1N1cDlUVHBCaFM0L1NXYi9MeUNTektQaE9nOXRUd2tm?=
 =?utf-8?B?WUpvZ3lhb1FNT2dTbG5mUENDRmQ2S0xZR2NmbmRtTEQvUERKcEhNYWZ6S0Va?=
 =?utf-8?B?b3dXenZRNnpobUxYQ00rSlk5cWZTYXVpWCtpQ0psdEluVHNyZGdUU1Vpb21G?=
 =?utf-8?B?ZlpwUDVObTVZRDkvSmtSRy9kOG5QNUk5RzhWbHdpTVlzMzJxUTVhWHB0RkF3?=
 =?utf-8?B?anNFUUlWOHNVbFNuVnRZcTEySFFoNG5DYlg4MWh3cFpXOHNGQXdySUh1WWVQ?=
 =?utf-8?B?Q3kxYW96QXRMTFZCYi83ekNGTGc5Vms5bnZCV2QwNXg0VWF1TldrUzNhdnZE?=
 =?utf-8?B?SDVvQTdZL2RLSlJFUEl2ZzJUbGtuT0hsRCtyTnRXaU1XV01RVFhETVdnL1F6?=
 =?utf-8?B?cFR6VDVEaDVXeE05Q2hyVmdzaWZERm4xMy9ubjNyd2RpN0d4UGQweU45MVZL?=
 =?utf-8?B?ZlFRVlM5L0ZGL2lIZ0UvNVlCN3Mvc2lCZi85NGNjSnVKZVBvaDZHcUpDVERa?=
 =?utf-8?B?czhuZS90Z0J6Ym8zZVFtcDZXSTEzRXNSb0t0aGwyTldMZWdlMzI1cjhnTHoy?=
 =?utf-8?B?NTVzWGFMbVRKSVpQQU9xYjJxckVOa29uTUIwSWhIaG5QT2srelpGdlgzekM0?=
 =?utf-8?B?a2JnWTlvak1CVTZ6dEUvMHIvUmEzVjFhMTdaRE5NUm9MODRlYnFQQjdFZlVY?=
 =?utf-8?B?Q2FUcldRaWg1elBIWUdJaFJNNnExQS8wNnYwVWlxa0hMVVgxRkN3N2hvVFhv?=
 =?utf-8?B?MjZ3ZHRkMDY0VU05VVo3a0MxcFdwN1NHNnBmQWdIMTh5ZUZrUTZFb0xsZVV0?=
 =?utf-8?B?UEpzRFp0SnlZMi9reHFkcnk3Z2FmeGF5VmJRdVdpaFZydTJWMm9JckQyYkNk?=
 =?utf-8?B?SkMrVlZROFE2a3JQL2RvT01CTVIxQXA1MitFV0ltRVVpZk1lNHhNc1A1b1JX?=
 =?utf-8?B?alpZcUh3V2Q3MTE3Vkw1cEd6YysvOVlaK1B5K1FhMUNmVkRaakpmVGNBWVZB?=
 =?utf-8?B?bUoxTGVwMUdWdktEQWxidkpUb3pPWmF1WUs5UXhXMHRHekVidGxJaEdwOGRu?=
 =?utf-8?B?TUxmNmpNRExIcllXQ3p0N2ZCM2xKRUVtUjVsdk5nSXhtYnA1Vm5tOTNyMkZo?=
 =?utf-8?B?Nko4VzZZdnBVNXhYV3A3ckVxYXVlbWFEcU1QYnV1dDZiWUcyd0xVa0dpWEVN?=
 =?utf-8?B?U2tNL3ZjKzBBVytNUUdiMnAvbEtacUlCUjBFNDlKdHFrR1hiOVNoL3VnUVNO?=
 =?utf-8?B?QjFDSzVoTjBCWDI3L3pIRlYyMU41bGlIV1ZHQXBiSjVZMHI3bHlRSGVXbTdt?=
 =?utf-8?B?RXlpVjQrUk9BOVBkRWd3QjFXbnRnbjFJN0VsL0N2Wnk2NDdpZ1cwUnljWVlT?=
 =?utf-8?B?SDhzVTJ4NElvakR6U0dsekRxYzFqNmFVRnZMbXdwN3pQZEJhK1JrOW9mRXJB?=
 =?utf-8?B?NG1iMGVzZ0ExNTBob3M5M0ZRY1hoTkdKWVBGRnRiamYwR0NPYkdibEJQcTZm?=
 =?utf-8?B?NHVwUmR4OE1IUTh5cm0zUVgwL2FqTElwVEJ1QThBR0ZzY1lTUnVpenZVSVYr?=
 =?utf-8?B?WnR3ZFFsOXFPQXBOT1dhcHFNU2Y4Nkx4dVVjWTVFVFJBLzdXZko1UWV3bEpY?=
 =?utf-8?B?TWJlMWdLR3Z6RUJxTHorVEtHT0V3Y0FkaWN1ZXQ1Tk9SOVI5WXd4cE1FbHNS?=
 =?utf-8?B?QTN6SU5JaENjNmh0TVA1Wm53L3c3Unh2QXZYcWovUm5CREVQK2FsSGpYcE9C?=
 =?utf-8?B?Sm9iYVpWMFU0ei9SUXFzUWdIK2M5L0o4cDdwenIyTXFmKzg5SEpzSGpzbFVm?=
 =?utf-8?B?ckpUclNtVzNhWmtOR3VMZ1NUdDZlWHJqNTUxZnRLNDFpbmZWYlorSGlKUXcw?=
 =?utf-8?B?Zm9iUW9xNGtvQjBEQjBIR1N4dTlramc0RUNZRjhHYlRDb05YV0I2aWxMd2ZF?=
 =?utf-8?B?SXREbUZzSkhpKzk2SGp5QmpPTEVLT0ZyMTdadTRVM2R2UjYvU2pscFVyS3FT?=
 =?utf-8?Q?RyQQAp/vwW9dy5KRGXK1sC6+MLl7l0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40CD8C5BB629D147B5281289A8DB3111@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca71e57-4933-4f28-0a7d-08da0b6dda32
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 19:06:06.4993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNpmupbdVulsZnsKvD82WDCjy1KdPc6T0s4dxgM+g/FXp8IR3D/o4dVo7ZjqY4Tb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1920
X-Proofpoint-ORIG-GUID: dS4wn36UQCZWw5b4-6pi1Y3BOhzdG3da
X-Proofpoint-GUID: dS4wn36UQCZWw5b4-6pi1Y3BOhzdG3da
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_08,2022-03-21_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTAzLTA5IGF0IDE2OjE4IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFdlZCwgTWFyIDksIDIwMjIgYXQgNDoxNCBQTSBBbmRyaWkgTmFrcnlpa28NCj4gPGFu
ZHJpaS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFdlZCwgTWFyIDks
IDIwMjIgYXQgMTE6MjQgQU0gQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+ID4gPGFjbWVAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IEVtIFR1ZSwgTWFyIDA4LCAyMDIyIGF0IDAz
OjQ1OjAzUE0gLTA4MDAsIEFuZHJpaSBOYWtyeWlrbw0KPiA+ID4gZXNjcmV2ZXU6DQo+ID4gPiA+
IE9uIFRodSwgSmFuIDI3LCAyMDIyIGF0IDExOjIyIEFNIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVs
bw0KPiA+ID4gPiA8YXJuYWxkby5tZWxvQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gRW0gV2VkLCBKYW4gMjYsIDIwMjIgYXQgMTE6NTU6MjVBTSAtMDgwMCwgQW5kcmlp
IE5ha3J5aWtvDQo+ID4gPiA+ID4gZXNjcmV2ZXU6DQo+ID4gPiA+ID4gPiBPbiBXZWQsIEphbiAy
NiwgMjAyMiBhdCAxMToyMCBBTSBLdWktRmVuZyBMZWUNCj4gPiA+ID4gPiA+IDxrdWlmZW5nQGZi
LmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBBZGQgYXJndW1lbnRz
IHRvIHN0ZWFsIGFuZCB0aHJlYWRfZXhpdCBjYWxsYmFja3Mgb2YNCj4gPiA+ID4gPiA+ID4gY29u
Zl9sb2FkIHRvDQo+ID4gPiA+ID4gPiA+IHJlY2VpdmUgcGVyLXRocmVhZCBkYXRhLg0KPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlm
ZW5nQGZiLmNvbT4NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IFBsZWFzZSBjYXJyeSBvdmVyIGFja3MgeW91IGdvdCBvbiBwcmV2aW91cyByZXZpc2lvbnMsDQo+
ID4gPiA+ID4gPiB1bmxlc3MgeW91IGRpZA0KPiA+ID4gPiA+ID4gc29tZSBkcmFzdGljIGNoYW5n
ZXMgdG8gYWxyZWFkeSBhY2tlZCBwYXRjaGVzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFllcywg
cGxlYXNlIGRvIHNvLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEknbGwgY29sbGVjdCB0aGVtIHRo
aXMgdGltZSwgbm8gbmVlZCB0byByZXNlbmQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4g
PiBIZXksIEFybmFsZG8hDQo+ID4gPiA+IA0KPiA+ID4gPiBBbnkgaWRlYSB3aGVuIHRoZXNlIHBh
dGNoZXMgd2lsbCBtYWtlIGl0IGludG8gbWFzdGVyIGJyYW5jaD8gSQ0KPiA+ID4gPiBzZWUNCj4g
PiA+ID4gdGhleSBhcmUgaW4gdG1wLm1hc3RlciByaWdodCBub3cuDQo+ID4gPiANCj4gPiA+IEkg
ZGlkIHNvbWUgbWlub3IgZml4dXBzIHRvIHRoZSBjc2V0IGNvbW1lbnQgYW5kIHRvIHRoZSBjb2Rl
IGluDQo+ID4gPiB0aGUNCj4gPiA+ICdwYWhvbGUgLS1jb21waWxlJyBuZXcgZmVhdHVyZSBhdCB0
aGUgaGVhZCBvZiBpdCBhbmQgcHVzaGVkIGFsbA0KPiA+ID4gdXAsDQo+ID4gPiBwbGVhc2UgY2hl
Y2suDQo+ID4gPiANCj4gPiANCj4gPiBJIGRpZCBjaGVjayBsb2NhbGx5IHdpdGggbGF0ZXN0IHBh
aG9sZSBtYXN0ZXIsIGFuZCBpdCBzZWVtcyBsaWtlDQo+ID4gc29tZXRoaW5nIGlzIHdyb25nIHdp
dGggZ2VuZXJhdGVkIEJURi4gSSBnZXQgdGhyZWUgc2VsZnRlc3RzDQo+ID4gZmFpbHVyZQ0KPiA+
IGlmIEkgdXNlIGxhdGVzdCBwYWhvbGUgY29tcGlsZWQgZnJvbSBtYXN0ZXIuDQo+ID4gDQo+ID4g
S3VpLUZlbmcsIHBsZWFzZSB0YWtlIGEgbG9vayB3aGVuIHlvdSBnZXQgYSBjaGFuY2UuIEFybmFs
ZG8sIHBsZWFzZQ0KPiA+IGhvbGQgb2ZmIGZyb20gcmVsZWFzaW5nIGEgbmV3IHZlcnNpb24gZm9y
IG5vdy4NCg0KSSBqdXN0IGZpZ3VyZSBvdXQgdGhlIHJvb3QgY3Vhc2UuDQpJdCBjYXVzZWQgYnkg
bWlzc2luZyBpbmZvIGZyb20gcGVyY3B1X3NlY2luZm8gd2hlbiBjb2xsZWN0aW5nIGRhdGEgZnJv
bQ0KdGhyZWFkcy4gIFRoZSBlbmNvZGVyIHN0b3JlcyBpdCBzZXBhcmF0ZWRseSBmcm9tIHN0cnVj
dCBidGYsIGFuZCB3ZQ0KaGF2ZSBzZXBhcmF0ZWQgZGlmZmVyZW50IGVuY29kZXJzIGZvciB0aHJl
YWRzLiAgVGhleSBhcmUgbm90IG1lcmdlZA0KdG9nZXRoZXIuICBJIHdpbGwgZml4ZWQgaXQgQVNB
UC4NCg0K

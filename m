Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FEC4FFFD6
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiDMUQg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiDMUQf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 16:16:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68981185
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 13:14:12 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23DHTYG7022807
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 13:14:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XJAzQKE6HbckD82UJC0DZ3EmY68Fo94KZ2tzVdXU1Xo=;
 b=WM3G2ri7X3uJuzJLA4iRdUMNcPC4G0jLwkmQ+G7dY9PCSTak93GO5u8H/ccdaconmaGF
 OPE5NXOhtK7DlV7vxOaeXe0DKxvuoTp/RhLYX/H4qgvhCEHKfCsZ+rJLXXllItBV1RQ2
 hx60DXx/wptaonmgM8ByzQpp/UAiQ9UG+eQ= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fdv18m48y-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 13:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4y8Y96dO455bOkJIni2cmkfKeRpDEEt/3cJ4zjolV40W4F13tsSx98XXbfC7bIDvMSsUN1KEjCeYvbNSKTfzdMQqf6Lw3X2s0qyWjs8jF2RdvkdOh01/vvXktcWF/xwt/nTrfIXcHzWetki1MD1u9kBYoBlOvP9EvMQnqxe8sPcl6kS/FAwZ2BDdoPPLZgTtGEfoEfHh0RxxmCQ49jJEm6MVgiIfX5W1iBuEg6HsuwT3F/m7JRPgHXykmKYJHPOxartiKia+Iv1A9abQ6/KLcWGifMdDiHYcXOoJV4aPyxGSLbdG5OV4B5r5ftJlJST38d46WQ/P0NwENvKxgu6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJAzQKE6HbckD82UJC0DZ3EmY68Fo94KZ2tzVdXU1Xo=;
 b=kDn9irvfXPY8zSG/DINpn2ohLCLc5WVR9Lo4fbeobHUobe4pbUyq4Gu0mvCqECMkLP5giHIMU9MG+qUpaZVowlLZszerUmdsPCGn6zPETok6HhDeVV9nC9BORtwfrptWP8ZhGkPlO0lCHumElGyI7TAwp8rR3gyUu/CtRqLAxLTk+U+6Cc37eZ7XgGclOQ4VlWNsjHL4ios/YT5gY2RM5CRbxkOA4oRSSmTtmQn5Xn5ZSy90748w2FOUhUr2ZT4ZZrfto/MNyEeK/MkQWQrzt7ze4glu3fBHQerfDYRCMl4bIAKjpaLRlPQssA6mSghiinCymRJoJJQkChmTQg+Jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by PH0PR15MB4350.namprd15.prod.outlook.com (2603:10b6:510:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 20:14:08 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 20:14:08 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
Thread-Topic: [PATCH bpf-next v5 2/5] bpf, x86: Create bpf_tramp_run_ctx on
 the caller thread's stack
Thread-Index: AQHYTo5JrCPxE7TvK0ycERVZYyswsaztJtcAgAEiG4A=
Date:   Wed, 13 Apr 2022 20:14:08 +0000
Message-ID: <f0ca703b8ab72c21d28dc4538a60a89bc6a7f26d.camel@fb.com>
References: <20220412165555.4146407-1-kuifeng@fb.com>
         <20220412165555.4146407-3-kuifeng@fb.com>
         <CAEf4BzZiEAysLb41XNzvZXdHqr4ikgw8ggTbvd8KpsWvqtS5zg@mail.gmail.com>
In-Reply-To: <CAEf4BzZiEAysLb41XNzvZXdHqr4ikgw8ggTbvd8KpsWvqtS5zg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27f21be2-bb09-44a0-e435-08da1d8a2aa0
x-ms-traffictypediagnostic: PH0PR15MB4350:EE_
x-microsoft-antispam-prvs: <PH0PR15MB4350235BDEBAF46E48A54586CCEC9@PH0PR15MB4350.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyF/lRvMafPj0Rz09YHwbb4dAYC3LYS0NZyF/Ce2ilfpvoWNL+N+4EFOzJIF9nOoahGxPGctRxNAfhlsWp19gBbyjkEY9HgUgQIE4Vw8Aga1ZYPQw+aYZY7irdPuMfzqL/gt9DSkVlfqjOyCMsHaLz81rnVOatTSgSZ5w7noO6K4TMKL9Tij8majt/D6PTvGDd4QbFktYfaXuXUzePZtbcunKVdoiK/GBvlYwRvc33YbarzhNAFF6ox234Zx8AELz3wLv9+B8Gl4/OcGiaAO5gqL2XfZWbf7cmFgE8g/rKFBOcqSb5yodEMxVQ1ZyVNrD61e1iZSkprSl25KfhQJuXNvSCEcY15Pd+rge+DCLFooIezL/eSREwe3du1c8MuCLUr1QRyadFMvHpeg7LLq4+eKeTpmuH8/qxyd6dmvcen9ROkzQcQAB4yMMEYZKs7d6rIsiowN1nRWhUiJhNp2ELjLNSe+p/b0KRFt/BTiyHY+SK0Kyw1cWIkCDSJveOBzDDC+NUK7SYp5s4rbFTiC1NgZHmoCs/HDQ6k4gbitm4OsKAZqfLkDx2wty6FK7yID8yhLAd/4GUkO46CilVmgW+RbTuNAHYtVwuDqOJVTcUxTiTqJfaajbSCQor4jq2rg+2sHXNzWeeCpmP+GifsOSEUI1IdTt9XO3SESWCVHkI5UdGcH1NP5RtVlmpTh6QquXJptnrVvKV2LkCPB3mujaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(8936002)(5660300002)(36756003)(54906003)(2906002)(71200400001)(6486002)(2616005)(186003)(316002)(508600001)(53546011)(6512007)(6506007)(38100700002)(38070700005)(83380400001)(122000001)(86362001)(66476007)(64756008)(76116006)(66556008)(8676002)(66946007)(66446008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkxXZ1plSUh5dG1NRUdOYm13bGRhelpMSWJ1aytwZDZwWUlNZldsa3ltWTVD?=
 =?utf-8?B?QXBwTXlqT2VIendtOERmRUFxcTl0ZFBMK1NYSWN5VTNOdVlKY2FKNTVUcjA3?=
 =?utf-8?B?MmNCNFJ3d2wyWlNFN25LZElaVE5jVGJnbk4xM1NCTFZZK2ExdS9uZ0RrVzN0?=
 =?utf-8?B?azNkZ05yVjNFa3NVUmE1aHBhV3BqRVVjUHppL0JXRk9GOEdKNFVtU1g1ckRY?=
 =?utf-8?B?aU01SEdKdTNkcjFibjVsRnhLNlZCNVZYQnExMkYrc0JmYk1laDlLWitCa1VR?=
 =?utf-8?B?cTNuT25MTEpEbjFydE1hUHp1VVozMW1mRW1OYTErL01qRWZmNDNxQkE2Q2Nv?=
 =?utf-8?B?akJZTU1XL0VMZnZMMXY0M0gzNnhYMkdpSGFjalNDdGxmTkJNV0dqZDlXQUhB?=
 =?utf-8?B?RGhkSWF4UVpwWmhsMEZLNjJlOTQzVTJpMXRydmFnQmsrNXYycU03Q0JONmor?=
 =?utf-8?B?WHZOLzdQR1gvVEloaDBrOGpFS0xlSWVZcTM2Wk83cmd3U2tVL0p0U2JnaW95?=
 =?utf-8?B?SThLUnBCQzFJSlBXMjNFMkIvMGpMcXViUERhd1l2SDZyUWI4b3BEVm16djZw?=
 =?utf-8?B?by9xL2Vpa2J0ek93SWJZaHJleGl6Mzc0YUdsQnFrY2laTkVnOUFKWmJJWWFm?=
 =?utf-8?B?b0xhWGNVTmM0RmN6WTFGaXlOanpwaTNSY3BHRVBjME5VR2ljMm1rYWFqWmVH?=
 =?utf-8?B?a3RQSjh5aENFMEhyS3dMTVYyeUlTVFpGeUVaYjZEdTBWWVhodzQ0SXYvL3NC?=
 =?utf-8?B?TVpWWXF3V3hRbXR2Qi9aZHlCQzhQU084M2ovNnhSV3NDUmh1cFlQSE91VDVY?=
 =?utf-8?B?YVA4dlhQT05PTS9XL3B0YnZOYTBUYzhmTVdUb3dGQzVzbVlyU1VUVU9NNGdO?=
 =?utf-8?B?aC9LMkhUbkM1eFVEOHRjczBocFp4Mm91eG1CL1RJOXB4a3BxdUpYa25MUGt2?=
 =?utf-8?B?OXowS1p3OGdRSTB4UTZtZDE3QVFkaU1jMWFmT3g3NUFZY1V5T0s2TEYvU1Uy?=
 =?utf-8?B?eDBDWkVraVE3Rlhwc1FFSlg5TkoxRmNDZ1NMSkw1WjA4cUlWcWJDaFVOUjBD?=
 =?utf-8?B?YVZacE5MQnFIb1R2bXREYWV5d2FERmh0bFRjKzl3WCtJUFN5MzgzY0tFWTZh?=
 =?utf-8?B?Y0hraVY0TmVjUWhRSUl4YXlQL0NualVhSWE3SXo2Z1JvQjkwVXd2MGNmQzRF?=
 =?utf-8?B?elVod1lmb3pVb3pzV05saFhLeWUza09SUExETVF3b3AxU0FPWUtJWE1jSk8v?=
 =?utf-8?B?dktGZ0RkeE96TnBEZnpTNHhCSmVXcVlpaGpVSUFlbkF2MktTZXJRZURBRjBh?=
 =?utf-8?B?R3krNWMwbndvdC90MnZrc3h1QmhDZDgyK2ZWRVpWSE5sY3FVZHhnWm9ORlRZ?=
 =?utf-8?B?a0E2MEpNZWdQNXJGZWM3TGZ5eWFmUHlKcXorR2VweFhnUm1KN2dzY1Rua01s?=
 =?utf-8?B?alhqQ1NLb3NIWmo1U09BUi9scHJsNDJNN05SZjE0VXdZN1o4SDA1RWhWeW5J?=
 =?utf-8?B?L3dsSXVJbjk2aFJOYkdqYkgzQlFud2E1U2xLUWNQS2NEUGZiak94MHZoc3dG?=
 =?utf-8?B?OVNwelFzQ1R3N2I4WndCYzY5YjJzWEg1WHVuK3JnUFRyaDBLMXU1S3pKQTM1?=
 =?utf-8?B?d3NSaTFXS0RlSG1pa0oxemtucVYxNjUwRkFKR2dXdEJyNmRYYkVyWEpjdlBX?=
 =?utf-8?B?eUU2M0ExVUpNZXNUdG8wN2NTckszSmR3Vi9FamRyUUY3aXpCVEZoTG5oZzhX?=
 =?utf-8?B?VHdRMC9GOHJQTmV0Z3RHbGJndExuK2MxOGVlVzlhVlJ3Z3NaUWlFYVZRa1V2?=
 =?utf-8?B?eGlFR3NuYzNiSjg0UUVGRjI2eC9IRHlzOFdyTlRMQ0xGR1B4N3V6ZFFtTTJp?=
 =?utf-8?B?aWNUS3MyT2lYWlYxSThPVkdoUEJqTkVSOFBDclA0U2oydnBTNWEvMkFBUnlR?=
 =?utf-8?B?SUMvOENDZXdqU1Z3QU5jQ3AzblpqRTlQblRCREZ4bk1SbnVRdmV4MXJHSEE3?=
 =?utf-8?B?Y0psRTEyK21MTVR2WmsrVytMNlFoZ2pNRld4Q2Rlb0E3MGdmaHFWM1dWSHov?=
 =?utf-8?B?VGpVQURFMC9zV2QvSk93bFZnQzFXakQwVFVUWkNVUGpheTEzRlFVVXJ5NHlG?=
 =?utf-8?B?VjJyTGE5dmsvK1psL0xNbHJkcVNEL21CNUlQcGI5TnBCYm41ZnYySUpqWFpS?=
 =?utf-8?B?VTl4ZWE0bW5IRUJ0Ti8wM1JhVnY2QzVzME5Ud2NYYlJFd0JIL00rZTkwV1pI?=
 =?utf-8?B?NlBMTWpVaEExZHlpZDVZa0pDR2cvZzc3blFIZ3ZzVEZycS9IZ2RibW5rNVd1?=
 =?utf-8?B?a2wvMnNEcm5RU0p2T2hqbnVNTnNLSFpMQjkvSGJ1NlMwdG9ZMElRSVJjL3Ix?=
 =?utf-8?Q?j+g7ZbGx001OoXYj2G5cGWC/blM9cisJOH7pD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDA5C18A1079C14FA7B74B8FBAB932B4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f21be2-bb09-44a0-e435-08da1d8a2aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 20:14:08.3757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihRfRHkmojnAiPvMyuFzEybmm8OFcS0ASuDA4IKrEGL1l11e7T8cPI5Tp/VyDSgB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4350
X-Proofpoint-ORIG-GUID: ZrwSzqXs8qPr6umyB27c0NWo88T8I2wH
X-Proofpoint-GUID: ZrwSzqXs8qPr6umyB27c0NWo88T8I2wH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_03,2022-04-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDE5OjU1IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgOTo1NiBBTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToKPiA+IAo+ID4gQlBGIHRyYW1wb2xpbmVzIHdpbGwgY3JlYXRlIGEgYnBm
X3RyYW1wX3J1bl9jdHgsIGEgYnBmX3J1bl9jdHgsIG9uCj4gPiBzdGFja3MgYW5kIHNldC9yZXNl
dCB0aGUgY3VycmVudCBicGZfcnVuX2N0eCBiZWZvcmUvYWZ0ZXIgY2FsbGluZyBhCj4gPiBicGZf
cHJvZy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNv
bT4KPiA+IC0tLQo+ID4gwqBhcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMgfCA1NQo+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gwqBpbmNsdWRlL2xpbnV4L2Jw
Zi5owqDCoMKgwqDCoMKgwqDCoCB8IDE3ICsrKysrKysrKy0tLQo+ID4gwqBrZXJuZWwvYnBmL3N5
c2NhbGwuY8KgwqDCoMKgwqDCoMKgIHzCoCA3ICsrKy0tCj4gPiDCoGtlcm5lbC9icGYvdHJhbXBv
bGluZS5jwqDCoMKgwqAgfCAyMCArKysrKysrKysrKy0tLQo+ID4gwqA0IGZpbGVzIGNoYW5nZWQs
IDg5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jCj4gPiBiL2FyY2gveDg2L25ldC9icGZfaml0X2Nv
bXAuYwo+ID4gaW5kZXggNGRjYzBiMWFjNzcwLi4wZjUyMWJlNjhmN2IgMTAwNjQ0Cj4gPiAtLS0g
YS9hcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMKPiA+ICsrKyBiL2FyY2gveDg2L25ldC9icGZf
aml0X2NvbXAuYwo+ID4gQEAgLTE3NjYsMTAgKzE3NjYsMjYgQEAgc3RhdGljIGludCBpbnZva2Vf
YnBmX3Byb2coY29uc3Qgc3RydWN0Cj4gPiBidGZfZnVuY19tb2RlbCAqbSwgdTggKipwcHJvZywK
PiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqAgdTggKnByb2cgPSAqcHByb2c7Cj4gPiDCoMKgwqDC
oMKgwqDCoCB1OCAqam1wX2luc247Cj4gPiArwqDCoMKgwqDCoMKgIGludCBjdHhfY29va2llX29m
ZiA9IG9mZnNldG9mKHN0cnVjdCBicGZfdHJhbXBfcnVuX2N0eCwKPiA+IGJwZl9jb29raWUpOwo+
ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJwZl9wcm9nICpwID0gbC0+bGluay5wcm9nOwo+ID4g
Cj4gPiArwqDCoMKgwqDCoMKgIC8qIG1vdiByZGksIDAgKi8KPiA+ICvCoMKgwqDCoMKgwqAgZW1p
dF9tb3ZfaW1tNjQoJnByb2csIEJQRl9SRUdfMSwgMCwgMCk7Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgIC8qIFByZXBhcmUgc3RydWN0IGJwZl90cmFtcF9ydW5fY3R4Lgo+ID4gK8KgwqDCoMKgwqDC
oMKgICoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGJwZl90cmFtcF9ydW5fY3R4IGlzIGFscmVhZHkg
cHJlc2VydmVkIGJ5Cj4gPiArwqDCoMKgwqDCoMKgwqAgKiBhcmNoX3ByZXBhcmVfYnBmX3RyYW1w
b2xpbmUoKS4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBtb3Yg
UVdPUkQgUFRSIFtyc3AgKyBjdHhfY29va2llX29mZl0sIHJkaQo+ID4gK8KgwqDCoMKgwqDCoMKg
ICovCj4gPiArwqDCoMKgwqDCoMKgIEVNSVQ0KDB4NDgsIDB4ODksIDB4N0MsIDB4MjQpOyBFTUlU
MShjdHhfY29va2llX29mZik7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCAvKiBhcmcxOiBtb3Yg
cmRpLCBwcm9nc1tpXSAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgZW1pdF9tb3ZfaW1tNjQoJnByb2cs
IEJQRl9SRUdfMSwgKGxvbmcpIHAgPj4gMzIsICh1MzIpCj4gPiAobG9uZykgcCk7Cj4gPiArwqDC
oMKgwqDCoMKgIC8qIGFyZzI6IG1vdiByc2ksIHJzcCAoc3RydWN0IGJwZl9ydW5fY3R4ICopICov
Cj4gPiArwqDCoMKgwqDCoMKgIEVNSVQzKDB4NDgsIDB4ODksIDB4RTYpOwo+ID4gKwo+ID4gwqDC
oMKgwqDCoMKgwqAgaWYgKGVtaXRfY2FsbCgmcHJvZywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5hdXgtPnNsZWVwYWJsZSA/Cj4gPiBfX2JwZl9wcm9n
X2VudGVyX3NsZWVwYWJsZSA6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgX19icGZfcHJvZ19lbnRlciwgcHJvZykpCj4gPiBAQCAtMTgxNSw2ICsxODMxLDgg
QEAgc3RhdGljIGludCBpbnZva2VfYnBmX3Byb2coY29uc3Qgc3RydWN0Cj4gPiBidGZfZnVuY19t
b2RlbCAqbSwgdTggKipwcHJvZywKPiA+IMKgwqDCoMKgwqDCoMKgIGVtaXRfbW92X2ltbTY0KCZw
cm9nLCBCUEZfUkVHXzEsIChsb25nKSBwID4+IDMyLCAodTMyKQo+ID4gKGxvbmcpIHApOwo+ID4g
wqDCoMKgwqDCoMKgwqAgLyogYXJnMjogbW92IHJzaSwgcmJ4IDwtIHN0YXJ0IHRpbWUgaW4gbnNl
YyAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgZW1pdF9tb3ZfcmVnKCZwcm9nLCB0cnVlLCBCUEZfUkVH
XzIsIEJQRl9SRUdfNik7Cj4gPiArwqDCoMKgwqDCoMKgIC8qIGFyZzM6IG1vdiByZHgsIHJzcCAo
c3RydWN0IGJwZl9ydW5fY3R4ICopICovCj4gPiArwqDCoMKgwqDCoMKgIEVNSVQzKDB4NDgsIDB4
ODksIDB4RTIpOwo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGVtaXRfY2FsbCgmcHJvZywKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5hdXgtPnNsZWVwYWJs
ZSA/IF9fYnBmX3Byb2dfZXhpdF9zbGVlcGFibGUKPiA+IDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2JwZl9wcm9nX2V4aXQsIHByb2cpKQo+ID4gQEAg
LTIwNzksNiArMjA5NywxNiBAQCBpbnQgYXJjaF9wcmVwYXJlX2JwZl90cmFtcG9saW5lKHN0cnVj
dAo+ID4gYnBmX3RyYW1wX2ltYWdlICppbSwgdm9pZCAqaW1hZ2UsIHZvaWQgKmkKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiDCoMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+
ICvCoMKgwqDCoMKgwqAgaWYgKG5yX2FyZ3MgPCAzICYmIChmZW50cnktPm5yX2xpbmtzIHx8IGZl
eGl0LT5ucl9saW5rcyB8fAo+ID4gZm1vZF9yZXQtPm5yX2xpbmtzKSkKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEVNSVQxKDB4NTIpO8KgwqDCoCAvKiBwdXNoIHJkeCAqLwo+IAo+
IHRoaXMgbnJfYXJncyA8IDMgY29uZGl0aW9uIGlzIG5ldywgbWF5YmUgbGVhdmUgYSBjb21tZW50
IG9uIHdoeSB3ZQo+IG5lZWQgdGhpcz8gQWxzbyBpbnN0ZWFkIG9mIHJlcGVhdGluZyB0aGlzIHdo
b2xlIChmZW50cnktPm5yX2xpbmtzIHx8Cj4gLi4uIHx8IC4uLikgY2hlY2ssIHdoeSBub3QgbW92
ZSBpZiAobnJfYXJncyA8IDMpIGluc2lkZSB0aGUgaWYgcmlnaHQKPiBiZWxvdz8KCkkgdGhvdWdo
dCByZHggaXMgYSBub252b2xhdGlsZSAoY2FsbGVlLXNhdmVkKSByZWdpc3Rlci4gIENoZWNraW5n
IEFCSQphZ2FpbiwgSSB3YXMgd3JvbmcuICBJIGFtIHJlbW92aW5nIHRoaXMgcGFydC4KCj4gCj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgIGlmIChmZW50cnktPm5yX2xpbmtzIHx8IGZleGl0LT5ucl9s
aW5rcyB8fCBmbW9kX3JldC0KPiA+ID5ucl9saW5rcykgewo+IAo+IGlmIChucl9hcmdzID4gMykg
aGVyZT8KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFByZXBhcmUgc3Ry
dWN0IGJwZl90cmFtcF9ydW5fY3R4Lgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIHN1YiByc3AsIHNpemVvZihzdHJ1Y3QgYnBmX3RyYW1wX3J1bl9jdHgpCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBFTUlUNCgweDQ4LCAweDgzLCAweEVDLCBzaXplb2Yoc3RydWN0Cj4gPiBicGZfdHJhbXBf
cnVuX2N0eCkpOwo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCBp
ZiAoZmVudHJ5LT5ucl9saW5rcykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoaW52b2tlX2JwZihtLCAmcHJvZywgZmVudHJ5LCByZWdzX29mZiwKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFncyAm
IEJQRl9UUkFNUF9GX1JFVF9GRU5UUllfUkVUKSkKPiAKPiBbLi4uXQo+IAo+ID4gwqDCoMKgwqDC
oMKgwqAgaWYgKGZtb2RfcmV0LT5ucl9saW5rcykgewo+ID4gQEAgLTIxMzMsNiArMjE3OSwxNSBA
QCBpbnQgYXJjaF9wcmVwYXJlX2JwZl90cmFtcG9saW5lKHN0cnVjdAo+ID4gYnBmX3RyYW1wX2lt
YWdlICppbSwgdm9pZCAqaW1hZ2UsIHZvaWQgKmkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBjbGVhbnVwOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0KPiA+IAo+ID4gK8KgwqDCoMKgwqDCoCAvKiBwb3Agc3RydWN0IGJw
Zl90cmFtcF9ydW5fY3R4Cj4gPiArwqDCoMKgwqDCoMKgwqAgKiBhZGQgcnNwLCBzaXplb2Yoc3Ry
dWN0IGJwZl90cmFtcF9ydW5fY3R4KQo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKg
wqDCoMKgIGlmIChmZW50cnktPm5yX2xpbmtzIHx8IGZleGl0LT5ucl9saW5rcyB8fCBmbW9kX3Jl
dC0KPiA+ID5ucl9saW5rcykKPiAKPiB3ZWxsLCBhY3R1YWxseSwgY2FuIGl0IGV2ZXIgYmUgdGhh
dCB0aGlzIGNvbmRpdGlvbiBkb2Vzbid0IGhvbGQ/IFRoYXQKPiB3b3VsZCBtZWFuIHdlIGFyZSBn
ZW5lcmF0aW5nIGVtcHR5IHRyYW1wb2xpbmUgZm9yIHNvbWUgcmVhc29uLCBubz8gRG8KPiB3ZSBk
byB0aGF0PyBDaGVja2luZyBicGZfdHJhbXBvbGluZV91cGRhdGUoKSBhbmQKPiBicGZfc3RydWN0
X29wc19wcmVwYXJlX3RyYW1wb2xpbmUoKSBkb2Vzbid0IHNlZW0gbGlrZSB3ZSBldmVyIGRvCj4g
dGhpcy4KPiBTbyBzZWVtcyBsaWtlIGFsbCB0aGVzZSBjaGVja3MgY2FuIGJlIGRyb3BwZWQ/Cj4g
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFTUlUNCgweDQ4LCAweDgzLCAweEM0
LCBzaXplb2Yoc3RydWN0Cj4gPiBicGZfdHJhbXBfcnVuX2N0eCkpOwo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoCBpZiAobnJfYXJncyA8IDMgJiYgKGZlbnRyeS0+bnJfbGlua3MgfHwgZmV4aXQtPm5y
X2xpbmtzIHx8Cj4gPiBmbW9kX3JldC0+bnJfbGlua3MpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgRU1JVDEoMHg1QSk7IC8qIHBvcCByZHggKi8KPiAKPiBzYW1lLCBtb3ZlIGl0
IGluc2lkZSBpZiBhYm92ZT8KPiAKPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChmbGFncyAm
IEJQRl9UUkFNUF9GX1JFU1RPUkVfUkVHUykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXN0b3JlX3JlZ3MobSwgJnByb2csIG5yX2FyZ3MsIHJlZ3Nfb2ZmKTsKPiA+IAo+IAo+
IFsuLi5dCgo=

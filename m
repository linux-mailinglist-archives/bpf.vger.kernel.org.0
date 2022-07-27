Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F98058208A
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiG0G4y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 02:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0G4w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 02:56:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994E5237DF
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:56:51 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QNDEFT019357
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:56:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yeqMjnSg/URr4n40iiBFFMXm39OpRL1AGIpzNmcLFSg=;
 b=dtaDmDNT5GB1LRqLD7Y6TKcL48rdAHMfqyKXMadOtYEtunKrcxOBcg8sKFOMiV2jiWE3
 3VZ7QrSxk59VTLIRacx8w5RxdbuWqkvUsKACCq0zh4BO5WJ6t6eSE8lbOAhSXEAjCCuj
 puSVRUCvLsisM+dZoQ5b6DGFjnJmvEo2UdU= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hhxbwuypu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:56:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpxziApWhhGcgnyYDB65yqwr8T4MAQI7cRMfp7sPhyeIE3sKmYJ69I7uXNSrc/+xxI/WIVDIJd3rFnHPCQ7aj8rEczMS3bmbTsakjtJPXUHwnr/5tadIs5mhUIfCQ1IR7lHmqJusMLtzx+boFKNwmrs16wLLg+CkDyqy5bePfKjvRGwpRTu00G2XzxfQC5ZpPdrvm0U/142k6plpV+vFyFMneOrtahmvX8ytcsy0v6bE9boBSgcJ24Q1f8Jkr48fq6oBktte6K9Y4hxdI+MJNQMxkeEfR52PnJko+xZ6z1bDtyXl2mTCuFtHlzq+ZCguNxfYDgOPogXY3cmYRzlWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeqMjnSg/URr4n40iiBFFMXm39OpRL1AGIpzNmcLFSg=;
 b=fh5tSzyjModlNghwpvoB1OpxvtDcXqYKgj5aY/6ii9AxMgrZErFt78Ftoa8ep3yb8EeRSjjt8Q+iKoBc0ntzp3v6EVUQlVcixBaKb8wdGvOr6IWAT8b4zbJ4CwGc746AtRyzXc2T5IBVzUapdvjF6oTYTpZ+VWnEEN9VHR/QDF88Gk5w/ZOJDNJox5sJHlya6TH6JWJH01GqSBLcuoW/b1mhkuH3bz6Ae9Xs+MVVcDJPzb7vdwmgpZFrjUr7gek6e7RyeZ9Tu71feEZ1cVmis4tEIbFI1E/1uEHGn7IfqllbsppgBfZVfnafR8OlChXBiJG/I/oHj3MY2irG/ckc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM6PR15MB2716.namprd15.prod.outlook.com (2603:10b6:5:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 06:56:46 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::cdef:5d3a:710a:4959]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::cdef:5d3a:710a:4959%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 06:56:46 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "olsajiri@gmail.com" <olsajiri@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYoK8StG1Y6n29KUSEV/VSsAjsP62QkM6AgAE54wA=
Date:   Wed, 27 Jul 2022 06:56:46 +0000
Message-ID: <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
References: <20220726051713.840431-1-kuifeng@fb.com>
         <20220726051713.840431-2-kuifeng@fb.com> <Yt/aXYiVmGKP282Q@krava>
In-Reply-To: <Yt/aXYiVmGKP282Q@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 115c09a0-a49a-41aa-19db-08da6f9d2c04
x-ms-traffictypediagnostic: DM6PR15MB2716:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u9gOxgwQNNMhVXLkeCJAAuQlQzbSd3oNSQ1tyrO5cEX04/LXyaE94+J/2y7Kd485xDD9IRfuoKwmnjPwDCmR3TkR0ZH1wqEvRyEpn6MaCJBGsCs7R7MD85jI5x/0d4BGMfBjOJMOYmgK7imyWEIuWDtqxGePCaRvyi0NRdI4YU6rIFv0MeSnUBQn1HT/3KmMaZVLgAR+eSjywrW8hlrVFLau4dNoRxgPYY6cmKCwSpnm5PrFvJQTVeYGSrPXFFDq7B8q3suNSXgjYxRFzMFVCJQ/5SRMWSK6cDgFgghSoSRoubhoADuX2xW11ScNdcuCcn63n3SXSAR4Y9VrSqI+5klS4WbYaNu0oQft4u+nScIIbMmbbWuOf4OxKeQhZPxHWNTlc/Vxg/CsJPX9YxV39JZ6gixvZOAkuIFs6nwrW7KWlZ9amhOIRvhbuOO6/UMiIHVtywLz/Ei0naSvmjLKZT1wDkOoOgxNrYVsxr0A7+AgqBJpDsKqOnyAXkBdBvlRYfzfZeJLZ9hbqiwpnKoaV14F6EhvDGH+wKnGqEKfHJcT+LgHWCzaiE1bLYBmuIDd9GeGXf+KpXJwruO3rGjZ1Un+6gGq6MqWzqx8PFwmCQl/zvRN0Jh46138fhsj284Gprma0Be43lW8L+vguxIIL+gg/480NCuvJaZsGv/3oU5fRKRAv/zEQ7iAXtr/WMZpza6Ho2ByPxdsF2y3KWFjzV4+X0whSHXeaAkrG8WmHGmQ89AZQf6zqgfoxaU6IxZj5C75l73xBXR7+8ywNgQF0lAcSYI5tmAJzjBzxCF1C/l/T8qaFYN0cVInujDllRd2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(6916009)(36756003)(54906003)(2616005)(2906002)(41300700001)(316002)(86362001)(66556008)(6486002)(71200400001)(66446008)(122000001)(83380400001)(478600001)(8676002)(38070700005)(76116006)(66946007)(64756008)(5660300002)(38100700002)(8936002)(66476007)(6512007)(186003)(4326008)(91956017)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTJVV2Jjb3NMODloNG95MXFxbXhrcGxjWFVtVWpEM0lkZVk1eHl5VHdMWitw?=
 =?utf-8?B?bWRmdi9LSmphN2NmNklwQnpveDhWSFpCaGFvYXRFemVQUGdpOXc3NHRKcnBr?=
 =?utf-8?B?WGVPdFYwMGpVZlZpSVVHaGFPRVZXdnRGc1B4Y3FnVGVESTA1VHY5N3VnZ2FR?=
 =?utf-8?B?NHdxOXpMQjJGL0NhZWpWTXNCOVRQQXZmWFl1VUxvMkVjVEQ2TFYrMjNHdzRn?=
 =?utf-8?B?ODUyZkd2a3FLYzBYSlI2dVBGUW4vdkREaVJFY1FwZmREL1Z5UDBQU3RZSGpy?=
 =?utf-8?B?UE82TFE1MEh5ekZpYTRURTAzOHdia211YlRHMTFKRGRMd2JScmovdGMzczVL?=
 =?utf-8?B?ZXROMzFFR2YxcUdvVnJxYWd4RzBaM2xkZi81Y0xWbzIzM0VoSS8zMU1vKzNG?=
 =?utf-8?B?N0FMaUhRcjRFcUptV1B2ay8xVjAzWkp3TDZuT2tCN0I3K0tldTd0RUJxSTJC?=
 =?utf-8?B?aU80WG0yOEFmdk1nSDFBQWRiWitrSEZIcnIvaGp2akswaG9kbDFXdDM1UGtF?=
 =?utf-8?B?aDdYRmZLY0liRFk5RjBZeFRqeTlUS0ErNXptMHExdUhiZFBnbnVXcVdhMm1R?=
 =?utf-8?B?L0xqeVl2dmtVNGM4c1M1YzdsVy9XQk04Sm5LcEpvRlZUOHVyN2c1b0ljdmRF?=
 =?utf-8?B?NnA5NjlpTVlxY01PK1BPK05wczhXRTdVcGRFbThJQlRTd09NcjAwUkMwWHlH?=
 =?utf-8?B?SkI0a2lsLy83Vk96cUgvMXBrT3NMZExyNGtWeGRxbmxjYkVIV0oyTVQxclhD?=
 =?utf-8?B?cnNUVHZTUUhFRHNlQ053SHJqTUZnQjg5a0gyTmlNNlo4N1BxMmw4YnR1WHpX?=
 =?utf-8?B?VWlpcGFVT0doSG5YZ3AyR090NEhiU205UUFCSytXM3RGNVFScFhhQmRQSS91?=
 =?utf-8?B?YXZTNDNLOXZNYnZ5MHNmay9ISlRadGFiaUFQc2xMNDlJV200ZFdHYzk2Rkk4?=
 =?utf-8?B?ZndDWHExVEI5MFVybXE5RzRYay8yVk5iNDIweTViSm5hQ1Z6Nk1mZE8rOE5X?=
 =?utf-8?B?dTgyZHA1bUhwN1BKRE8vMDR5VnBhNzNadlFZS01tN0poV0luclpDdVlUZ3Fx?=
 =?utf-8?B?WnR5T3hsOThZb2J0dDBNbng3MlNuL2p5ZGdKQVFrbzVHV0l4QkpOL1dETmgw?=
 =?utf-8?B?S0NuWEJjbVpGUHFZUSs4NEF0M0JGTHJWYVI5a1FTOUJ2a2dOK0dQRmZVa096?=
 =?utf-8?B?d3BlTGdnSFdJTUhqbEdYMXA0bjRINloxd1FBaWl5RGJSTjRCOVJDb2xHamFE?=
 =?utf-8?B?M01WelVsVkl6K0ZVWTJ2ZXh4Qm44N2cvM0huOUJza1o3Mm9DTDVuK2NrQ1dp?=
 =?utf-8?B?S3MvU2lwTXBQYlNMdi8zZ3pTL0hjVUtiTGFrczBraS9hMURRRGhYdFRITlFa?=
 =?utf-8?B?cCszNDNGd1lrak1iR3FnYVh4QTRWRFdFanh4dkM4NFB3bUxqcTNKbHorQVYv?=
 =?utf-8?B?VFpPWHIxRW01d3c0T05DMEg4ek5wUHJtVzN0N1prUmNhNVc1SkhaYzJGbERZ?=
 =?utf-8?B?Snh5eEwrK2VCcnhpbDZKQm9RTmthblFadFg0V0F4USsra3Z5cWh1ZnVrOGd1?=
 =?utf-8?B?QStCUnJjdWxIUi8zWGtOalF6eG1QSkx0WTg1YzQwRlRqSEQ4dEhPamFHTjJD?=
 =?utf-8?B?dHpCbG5FdU5VanhzS2RCaURzZG5LR0VLbmx4TkdPdkY0dkhLT3k1anFHM2Uy?=
 =?utf-8?B?OFN2WThOMGRlU2ZHWWtFTktDVzQ2ak90RnpXTmUzMnA2ek5ZaHR5QUc1b2Vt?=
 =?utf-8?B?SFhScmdGZWhhNTI1bHF1elNGMWFLMzdjQkF5VWQ1Yk1ZRmlqcytKV0UrZXBv?=
 =?utf-8?B?cXc2WWVVQjR0ZUlMR1JFY0E1a2lhbzJzalc0dVgveUN1NjB5QWNGVUR1L3Zx?=
 =?utf-8?B?c3VPalh6bzc0ZDBoekI3bWZNQU1saTBuSDRDS1NwQnVvb2I5Q09QS1lJL3pk?=
 =?utf-8?B?Y1B4OThJRE1qNmVtKzBaMTI2ZnpUeDVUSnhmL2s5UVlNT2RFejdmWTZzdm1M?=
 =?utf-8?B?cWlDRENGNzBqaGFyUmhVa3doQjZnajNYaUc2M0JrMzJzMXVieVRBVU81M3pz?=
 =?utf-8?B?dmVyNUl0M3NmRWxhTkpUc1hiVk5CRTNWb0hLdTl0djJWSyt6bWQ4WUU2d21H?=
 =?utf-8?B?WHIyc2ZOMmJQbkVBV3J1czV6NE9hRklheWxLdXZQQ2tGWW5OMk95RzBObG96?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF3180303EA46B49B278363EDC0B35F4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115c09a0-a49a-41aa-19db-08da6f9d2c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 06:56:46.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNerXjMSJVQm3e+agFQrxrSNT5M6UE1ykyudIDLElw5YrIk1oMkgv0R0m8keZFzH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2716
X-Proofpoint-GUID: tnAn3xx3k5-xRAdDjNNG94VEMzArCGB7
X-Proofpoint-ORIG-GUID: tnAn3xx3k5-xRAdDjNNG94VEMzArCGB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA3LTI2IGF0IDE0OjEzICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6Cj4gT24g
TW9uLCBKdWwgMjUsIDIwMjIgYXQgMTA6MTc6MTFQTSAtMDcwMCwgS3VpLUZlbmcgTGVlIHdyb3Rl
Ogo+ID4gQWxsb3cgY3JlYXRpbmcgYW4gaXRlcmF0b3IgdGhhdCBsb29wcyB0aHJvdWdoIHJlc291
cmNlcyBvZiBvbmUKPiA+IHRhc2svdGhyZWFkLgo+ID4gCj4gPiBQZW9wbGUgY291bGQgb25seSBj
cmVhdGUgaXRlcmF0b3JzIHRvIGxvb3AgdGhyb3VnaCBhbGwgcmVzb3VyY2VzIG9mCj4gPiBmaWxl
cywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0aG91Z2ggdGhleSB3ZXJlCj4g
PiBpbnRlcmVzdGVkCj4gPiBpbiBvbmx5IHRoZSByZXNvdXJjZXMgb2YgYSBzcGVjaWZpYyB0YXNr
IG9yIHByb2Nlc3MuwqAgUGFzc2luZyB0aGUKPiA+IGFkZGl0aW9uYWwgcGFyYW1ldGVycywgcGVv
cGxlIGNhbiBub3cgY3JlYXRlIGFuIGl0ZXJhdG9yIHRvIGdvCj4gPiB0aHJvdWdoIGFsbCByZXNv
dXJjZXMgb3Igb25seSB0aGUgcmVzb3VyY2VzIG9mIGEgdGFzay4KPiA+IAo+ID4gU2lnbmVkLW9m
Zi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4KPiA+IC0tLQo+ID4gwqBpbmNsdWRl
L2xpbnV4L2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArKwo+ID4gwqBpbmNsdWRl
L3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqAgfCAyMyArKysrKysrKysrCj4gPiDCoGtlcm5l
bC9icGYvdGFza19pdGVyLmPCoMKgwqDCoMKgwqDCoMKgIHwgODEgKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tCj4gPiAtLS0tCj4gPiDCoHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYu
aCB8IDIzICsrKysrKysrKysKPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygr
KSwgMjIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jw
Zi5oIGIvaW5jbHVkZS9saW51eC9icGYuaAo+ID4gaW5kZXggMTE5NTAwMjkyODRmLi5jOGQxNjQ0
MDRlMjAgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oCj4gPiArKysgYi9pbmNs
dWRlL2xpbnV4L2JwZi5oCj4gPiBAQCAtMTcxOCw2ICsxNzE4LDEwIEBAIGludCBicGZfb2JqX2dl
dF91c2VyKGNvbnN0IGNoYXIgX191c2VyCj4gPiAqcGF0aG5hbWUsIGludCBmbGFncyk7Cj4gPiDC
oAo+ID4gwqBzdHJ1Y3QgYnBmX2l0ZXJfYXV4X2luZm8gewo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCBicGZfbWFwICptYXA7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgewo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fdTMywqDCoMKgdGlkOwo+IAo+IHNob3VsZCBiZSBq
dXN0IHUzMiA/CgoKT3IsIHNob3VsZCBjaGFuZ2UgdGhlIGZvbGxvd2luZyAndHlwZScgdG8gX191
OD8KCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdTjCoMKgwqDCoMKgwqB0
eXBlOwo+ID4gK8KgwqDCoMKgwqDCoMKgfSB0YXNrOwo+ID4gwqB9Owo+ID4gwqAKPiAKPiBTTklQ
Cj4gCj4gPiDCoAo+ID4gwqAvKiBCUEYgc3lzY2FsbCBjb21tYW5kcywgc2VlIGJwZigyKSBtYW4t
cGFnZSBmb3IgbW9yZSBkZXRhaWxzLiAqLwo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdGFz
a19pdGVyLmMgYi9rZXJuZWwvYnBmL3Rhc2tfaXRlci5jCj4gPiBpbmRleCA4YzkyMTc5OWRlZjQu
Ljc5NzlhYWNiNjUxZSAxMDA2NDQKPiA+IC0tLSBhL2tlcm5lbC9icGYvdGFza19pdGVyLmMKPiA+
ICsrKyBiL2tlcm5lbC9icGYvdGFza19pdGVyLmMKPiA+IEBAIC0xMiw2ICsxMiw4IEBACj4gPiDC
oAo+ID4gwqBzdHJ1Y3QgYnBmX2l0ZXJfc2VxX3Rhc2tfY29tbW9uIHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgcGlkX25hbWVzcGFjZSAqbnM7Cj4gPiArwqDCoMKgwqDCoMKgwqB1MzLCoMKg
wqDCoMKgdGlkOwo+ID4gK8KgwqDCoMKgwqDCoMKgdTjCoMKgwqDCoMKgwqB0eXBlOwo+ID4gwqB9
Owo+ID4gwqAKPiA+IMKgc3RydWN0IGJwZl9pdGVyX3NlcV90YXNrX2luZm8gewo+ID4gQEAgLTIy
LDE4ICsyNCwzMSBAQCBzdHJ1Y3QgYnBmX2l0ZXJfc2VxX3Rhc2tfaW5mbyB7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgdTMyIHRpZDsKPiA+IMKgfTsKPiA+IMKgCj4gPiAtc3RhdGljIHN0cnVjdCB0YXNr
X3N0cnVjdCAqdGFza19zZXFfZ2V0X25leHQoc3RydWN0IHBpZF9uYW1lc3BhY2UKPiA+ICpucywK
PiA+ICtzdGF0aWMgc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrX3NlcV9nZXRfbmV4dChzdHJ1Y3QK
PiA+IGJwZl9pdGVyX3NlcV90YXNrX2NvbW1vbiAqY29tbW9uLAo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1MzIgKnRpZCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYm9vbAo+ID4gc2tpcF9pZl9kdXBfZmlsZXMpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2sgPSBOVUxMOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBwaWQgKnBpZDsKPiA+IMKgCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoY29tbW9uLT50
eXBlID09IEJQRl9UQVNLX0lURVJfVElEKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKCp0aWQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBOVUxMOwo+IAo+IEkgdGVzdGVkIGFuZCB0aGlzIGNvbmRpdGlvbiBi
cmVha3MgaXQgZm9yIGZkIGl0ZXJhdGlvbnMsIG5vdCBzdXJlCj4gYWJvdXQKPiB0aGUgdGFzayBh
bmQgdm1hLCBiZWNhdXNlIHRoZXkgc2hhcmUgdGhpcyBmdW5jdGlvbgo+IAo+IGlmIGJwZl9zZXFf
cmVhZCBpcyBjYWxsZWQgd2l0aCBzbWFsbCBidWZmZXIgdGhlcmUgd2lsbCBiZSBtdWx0aXBsZQo+
IGNhbGxzCj4gdG8gdGFza19maWxlX3NlcV9nZXRfbmV4dCBhbmQgc2Vjb25kIG9uZSB3aWxsIHN0
b3AgaW4gaGVyZSwgZXZlbiBpZgo+IHRoZXJlCj4gYXJlIG1vcmUgZmlsZXMgdG8gYmUgZGlzcGxh
eWVkIGZvciB0aGUgdGFzayBpbiBmaWx0ZXIKPiAKPiBpdCdkIGJlIG5pY2UgdG8gaGF2ZSBzb21l
IHRlc3QgZm9yIHRoaXMgOy0pIG9yIHBlcmhhcHMgY29tcGFyZSB3aXRoCj4gdGhlCj4gbm90IGZp
bHRlcmVkIG91dHB1dAo+IAo+IFNOSVAKPiAKPiA+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBzZXFf
b3BlcmF0aW9ucyB0YXNrX3NlcV9vcHMgPSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgLnN0YXJ0wqDC
oD0gdGFza19zZXFfc3RhcnQsCj4gPiDCoMKgwqDCoMKgwqDCoMKgLm5leHTCoMKgwqA9IHRhc2tf
c2VxX25leHQsCj4gPiBAQCAtMTM3LDggKzE2Niw3IEBAIHN0cnVjdCBicGZfaXRlcl9zZXFfdGFz
a19maWxlX2luZm8gewo+ID4gwqBzdGF0aWMgc3RydWN0IGZpbGUgKgo+ID4gwqB0YXNrX2ZpbGVf
c2VxX2dldF9uZXh0KHN0cnVjdCBicGZfaXRlcl9zZXFfdGFza19maWxlX2luZm8gKmluZm8pCj4g
PiDCoHsKPiA+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBwaWRfbmFtZXNwYWNlICpucyA9IGluZm8t
PmNvbW1vbi5uczsKPiA+IC3CoMKgwqDCoMKgwqDCoHUzMiBjdXJyX3RpZCA9IGluZm8tPnRpZDsK
PiA+ICvCoMKgwqDCoMKgwqDCoHUzMiBzYXZlZF90aWQgPSBpbmZvLT50aWQ7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IHRhc2tfc3RydWN0ICpjdXJyX3Rhc2s7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgdW5zaWduZWQgaW50IGN1cnJfZmQgPSBpbmZvLT5mZDsKPiA+IMKgCj4gPiBAQCAtMTUxLDIx
ICsxNzksMTggQEAgdGFza19maWxlX3NlcV9nZXRfbmV4dChzdHJ1Y3QKPiA+IGJwZl9pdGVyX3Nl
cV90YXNrX2ZpbGVfaW5mbyAqaW5mbykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY3Vycl90YXNrID0gaW5mby0+dGFzazsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY3Vycl9mZCA9IGluZm8tPmZkOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cnJfdGFzayA9IHRhc2tfc2VxX2dl
dF9uZXh0KG5zLCAmY3Vycl90aWQsCj4gPiB0cnVlKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBjdXJyX3Rhc2sgPSB0YXNrX3NlcV9nZXRfbmV4dCgmaW5mby0+Y29tbW9uLCAm
aW5mby0KPiA+ID50aWQsIHRydWUpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKCFjdXJyX3Rhc2spIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbmZvLT50YXNrID0gTlVMTDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPnRpZCA9IGN1cnJfdGlkOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBO
VUxMOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IAo+IG5pdCwgbG9v
a3MgbGlrZSB3ZSdyZSBtaXNzaW5nIHByb3BlciBpbmRlbnQgaW4gaGVyZQoKWWVzLCB3ZSBtaXhl
ZCBzcGFjZXMgYW5kIHRhYnMuICBTaG91bGQgSSBjaGFuZ2UgdGhlc2UgbGluZXMgdG8gdGFicz8K
PiAKPiAKPiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHNldCBp
bmZvLT50YXNrIGFuZCBpbmZvLT50aWQgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAvKiBzZXQgaW5mby0+dGFzayAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpbmZvLT50YXNrID0gY3Vycl90YXNrOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChjdXJyX3RpZCA9PSBpbmZvLT50aWQpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpZiAoc2F2ZWRfdGlkID09IGluZm8tPnRpZCkKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGN1cnJfZmQgPSBpbmZvLT5mZDsK
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpbmZvLT50aWQgPSBjdXJyX3Rp
ZDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4gCj4gU05JUAoK

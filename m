Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDF5962A0
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiHPSpV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbiHPSpQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 14:45:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB9C753BC
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 11:45:14 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GIhh3W031806
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 11:45:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4nd6YAYXDjYQaFxP+GJ+sehyWWDB0BOBEQKAIAW7hQs=;
 b=hMHLI4w/R6om8e0SlfstC0AJNr73A7rNosKgOVWFQ4NZPr0iVViljrRqwEBj6nKboOcN
 kC57/SEeWoA8dw2RQqsbejMG7yjsBTUboyiqCQ26OTY4si89EU7i0/FCchPq7h7zfKtX
 pYOknheewulMp12vzRNEJ+QWyWXg3syyBng= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j030hn7se-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 11:45:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGYQwvx9QpUD/VgTXq44lgjtCmQZdP23UWZXDxVXCrfqS5fTwa5qkxR/jHFXndPp4YpkIE9aWLDFGREN/g64ryZo9Jb/RpAkxiBtkZ/v+zNlRjOSsHLffcMC6/tVYFJHLb/bETGKuhsnbYm4ydbGESmuMfAffmUhXUWaANhPcYjXvt2U3ALg5XvRgWqGfG/8eS1R3QFLMsw0t9k6mIsSnMsiI4AZpCa+pdHGeluJtiNMX6RMsUxGagoYauhgUITZIY6abDo/B7hCueRoSKUNzFaT9YCJvmLoHQzO6jyXuP/Dx2kFkJZWZcSR3BJVcny2IWncK3X4kKj/Q/OQofPGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nd6YAYXDjYQaFxP+GJ+sehyWWDB0BOBEQKAIAW7hQs=;
 b=eGRqRvYMENJpRTW35K0XJR32Yw7AwkiLEH0HSElrSrljcYBXwsMg4b2Xf87H351PWNCy3THMGPscDLx8b1BzULh3hoNxyhDKgSoUMaY8BRePrvDCXqIpV0gcjzNQN9bxgAf9swxfCjBS3vEFGQTMHeo/30Qg57cIEbkIE8e9fwB2ngmRPUYlB4QdQJw7I88Je3aB0TsnryrUdp3yFq/Ds8tTqpgpGu2uy1HFHwtvL0cKVOkP7N9qiylrz4oF14T9kpktj22OpF64x3qe4FoosJZlShBgS53UZPIQ9kaXnzrIXNu6e18da4uPzofeY4KSckWBR3ju3E0S3zi8DPXrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MN2PR15MB3167.namprd15.prod.outlook.com (2603:10b6:208:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 18:45:08 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 18:45:08 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYrRe9v9ijmk2lSUWcf88n0+KKiq2xAH4AgADl7wA=
Date:   Tue, 16 Aug 2022 18:45:08 +0000
Message-ID: <8b351e7a743b9195f2dc96f22c342bb9147689a4.camel@fb.com>
References: <20220811001654.1316689-1-kuifeng@fb.com>
         <20220811001654.1316689-2-kuifeng@fb.com>
         <CAEf4Bzab06-dfmd3CpRekdQJ1gw5yFJJGJ5G-vN05Dx3+AOkGQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzab06-dfmd3CpRekdQJ1gw5yFJJGJ5G-vN05Dx3+AOkGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3661e8a-a269-4a0b-485d-08da7fb77189
x-ms-traffictypediagnostic: MN2PR15MB3167:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OybSR/rBO45O7jsB7gaq9HOuH/noy2D92D27NyS1j0arEZKBtXKJAmuT6txUCBz7ixmhG7yGsDp4nuUgYO8E89HcyNEn1ZTwC+ehHCaqxJVl+dwg2KTGIWwR0+3l2mqrl6x4BZgkoaoPsqiet8feeHwuQmW6srEJj+eIprfchoOr8hOJlfa6LnG1++TClnz9TH2tprCvpvvNi1RyKv8NydzB1sN0IGfPgABrFCKL7kJUQ9/gcBxravAnju6IHICB3ftlV3BNfyEoDxKOtEH9HFIBaBty5Nh+GVJZoLjdWX4zswa0ukN6khtq3/kT3Fbj4rn5j1hjfM0z0lUGQa9huBV6aHoPys3LAyTnaeo0tpwHMl7nQc+HQBY5gIYWIh7YsgOKYJaBASOQDKnOApNAoVvW5CUS5++GSiR7V+WW9YqHJs6wDgp8EUbNrM4mD96nzYxNVRxG/41ZcT+YxvgmZxrhxkxWbiN/IHzjHt80qMVyXoWxZ0Z8It647uZ5BRR9PQs2LhvCl1dELrcwT/NH6lOTvXWPEGk7e9NsB0d+anFj+ExdFQU06xQuM2Wux1Ue2rZFmAdAY0dkG1sMuaP10kNHob4EGBCZQ7cnWBjymoBg+8Jh3TkH9D8MYaLviTb/wa/dnUNlETaLzErjkRsyD1Nim4kJhC48VUzJm8sHm6eqENjolGsRv6BcEVC5xfVsY9ZQDKRhYgummltYdjDX5oisnsShDY1TKv3Lms8PtKWNUa+fgrelVqEnOoGLepZGcp9PWj8txDM6M3br7pXIN0SEKIyKTzU2l9QHGmszDtAlTYv8s2j6gsVOjlvxus8S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(316002)(71200400001)(6486002)(41300700001)(53546011)(6512007)(83380400001)(5660300002)(2906002)(6506007)(186003)(2616005)(478600001)(4326008)(66556008)(8676002)(76116006)(54906003)(64756008)(66476007)(66446008)(36756003)(66946007)(86362001)(122000001)(8936002)(38100700002)(38070700005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTkweGNsS0pMWXdsandLejVUVnhvLzE0UDM2RU41M3hrQWs0c3B3Y1g2Ri9E?=
 =?utf-8?B?eDhnRjRQUU5ZdzdFV3h2YjNhdGNUNUlBQlVQbE9mSmwyd1ovdm1wTlVaMENK?=
 =?utf-8?B?YjU4bjhLQ3NlM2FsR0lzL2hDWFluUnJzbnFGb0dFc1VBUGp4dVBjNXFiK0Zy?=
 =?utf-8?B?MElqNXBTQWNORmxGaW9WU2JJaGtIb0RrNUQ5NENBdzJtd3ErVVdTNVpOOHA5?=
 =?utf-8?B?cDlKYWtkQ3NtYi9ZZk92ekw0MjI1L25hdDZ4di9RVEU2ZXFkYUViN2xBRU9W?=
 =?utf-8?B?dk1ud3ptSmRkdDlkRHZUSStzNDkwdEZJaDh5cFJSODJkSTRjUTNoTEp2TjRH?=
 =?utf-8?B?UUlYcmdYNjRnSVRCZ1o4NGFPZ2x2Y0x1aE0ydTBGQi9HQUtLREJVTFkrRSth?=
 =?utf-8?B?VmVxRldHTDhlbU1nYnhFekE5K3dVbWxDb21IQUIvQnh4b1o1d0JNZUhqa3Ax?=
 =?utf-8?B?cTA2TU1DWFhsdmJzK1JBaXlpMDVEUnN0S2gyRERYY0x2NmFWdjlITEV3QmY3?=
 =?utf-8?B?Q0w2WlFZQThsbHRnR1p3VGc1VUJHd0lvRlpFUWROTk43REtUWThqK2ErbjBH?=
 =?utf-8?B?SXp0TGcwT1g3TTNXLzYrSFFKVDA4K0EyUlRWOFQrSno1ek5XdjZpYlpTTXJq?=
 =?utf-8?B?TXhObzRuRktPZW9CVzltY3R0T2VXUWtGR2FYMSszdk9ReEF1UHFpWU9wSCtV?=
 =?utf-8?B?dllxTUk3Kzl1a0J5MEY3dUV1cVg3YzBTcmhxS2dUU3dFMHFHZFFFNXNPTHUv?=
 =?utf-8?B?bjcrOGRTM3lsUTcrcXpIUVNFR0duVjFndzhZcnBNY2pSOEVIblJhc21OSS9n?=
 =?utf-8?B?YmdNWmREUUdyQ0V5SXpySzliRHdUdXhEMGlOMkNickRrcldVeGRoYStxUTBv?=
 =?utf-8?B?MkdzcExLeUdRZkxJcFkydWZocDlaNTdpZjZoVGhtVE5QRWRBWW5VLzdLSWVT?=
 =?utf-8?B?SWhObzR6dnMxdTJ5SWovNUlwWUp4OGlORzZOdTN6M0ttbVcxQTIzdjRFUUZ3?=
 =?utf-8?B?Z2laNm8vZGsvM2V3WGw2dncvV2dRaSt6ZitFSkNnSU5xQ0NRUzhSWk5ORlZu?=
 =?utf-8?B?eVJMRTRVQzl4Rmh6aDdNWU5WVEVQd3FVYlFNOEJSVDErT3lwYWhsTHRGRGpa?=
 =?utf-8?B?MEtQc2RjbkdrZnRQVlJubi8vVUlubHdLckNoaHlDWEc4eUNobmJRSlV6S2VU?=
 =?utf-8?B?QmhaZjEwY1Z3b1ZEUjVVWGVRME5qdS92NldkcWp2enJyWS9CTkVOQmtIblRJ?=
 =?utf-8?B?Nk9ZZXFQTWt0ZFZiN0lTRnZEOXh4UFZvbXdMOWMreE5iYXJHYkdpMmRvdGtD?=
 =?utf-8?B?bUtyY0ZSc1VuWjVvODBsejJ4Z3NQOUJYTXhNWE50UmQ0NWRXRDhLOHpyZ0tC?=
 =?utf-8?B?V0M4dXFweU9MRWtiK3FwMmh0VWNGZHNlalFUSm5uRXlUOVZIc3VjZ3VmQXdk?=
 =?utf-8?B?U3QyeTRxY2lQb2VVejRzZklGY0UyUGVjTTlHVit6RVc1dXVpMVBHQzM3cm91?=
 =?utf-8?B?Y21YNkpadGlBU0xzNk1GamI0WUJHd3lmdnB4dkllSC9STUpubVEvN2tNd2VC?=
 =?utf-8?B?bE9HV1ZJc2h3cmtzL3UrZlpkNFRtTzBBaTZRREVtdGVTZzlFRmZTSXc1ME5H?=
 =?utf-8?B?VjZGTkJSMEdOajNnazdsL28zU2tXZVZjRE1hV056YU14aWI5QXF0NitsUlY4?=
 =?utf-8?B?ZTNCcGR1bm9PbkZ3Q3BMTERlZW1ob1FHR0Z3Rm5sSk5DQ3FWYnI3ak9mT2o3?=
 =?utf-8?B?Z1owOGVhbWFmTVhEN3BJNW9UaG9Ud0IzZmpWUXdSWU1UbEhyTE9ReDRVR3VS?=
 =?utf-8?B?Q0FIaFVsN0FNdjJ6d3QyejRPd2FCU2h3TC8vZTd5MytkdERhbUs5TzZKdG9C?=
 =?utf-8?B?aEZOcWxaUmdielZ6bmxta05rU1ExYzBkSlJ4K0wyWDNNN3JMeHVveUJqc1dQ?=
 =?utf-8?B?V0QxOGNQRHE1Qy95SVNXVnZNMXg1OUVFSFVXSThBN0F2T2p0V0pBSnIyNDJC?=
 =?utf-8?B?YWp5aEZTSTFxQVc2NGNNc2J0TjNORUQzUm05UVVPTXpjVWFsdW5qbjMwa0lG?=
 =?utf-8?B?b1paQ1U1YmJjSFNxNG9JT1FyZ3ludzB5Z0p2UWNsWXgrcFF1cDdDTXNOY1U5?=
 =?utf-8?B?Y1Zib0c1VjJmRTc0Q2Ruc2swcVE2YmpnTlpSLy8zcndLd1ZpaE1SSGEzbVFz?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0E0E8919FCA92419B8A112F26C81D76@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3661e8a-a269-4a0b-485d-08da7fb77189
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 18:45:08.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vonqdG4XsfQY9NZsekJx66evcrJqgMBSsPMHUh41E1PhVSoMwDLnXnQLSfi5aA1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3167
X-Proofpoint-GUID: dK3V6PZiNqHDsqPpyL-aLE_ehoTSu-1R
X-Proofpoint-ORIG-GUID: dK3V6PZiNqHDsqPpyL-aLE_ehoTSu-1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTE1IGF0IDIyOjAyIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgNToxNyBQTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToKPiA+IAo+ID4gQWxsb3cgY3JlYXRpbmcgYW4gaXRlcmF0b3IgdGhhdCBs
b29wcyB0aHJvdWdoIHJlc291cmNlcyBvZiBvbmUKPiA+IHRhc2svdGhyZWFkLgo+ID4gCj4gPiBQ
ZW9wbGUgY291bGQgb25seSBjcmVhdGUgaXRlcmF0b3JzIHRvIGxvb3AgdGhyb3VnaCBhbGwgcmVz
b3VyY2VzIG9mCj4gPiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0
aG91Z2ggdGhleSB3ZXJlCj4gPiBpbnRlcmVzdGVkCj4gPiBpbiBvbmx5IHRoZSByZXNvdXJjZXMg
b2YgYSBzcGVjaWZpYyB0YXNrIG9yIHByb2Nlc3MuwqAgUGFzc2luZyB0aGUKPiA+IGFkZGl0aW9u
YWwgcGFyYW1ldGVycywgcGVvcGxlIGNhbiBub3cgY3JlYXRlIGFuIGl0ZXJhdG9yIHRvIGdvCj4g
PiB0aHJvdWdoIGFsbCByZXNvdXJjZXMgb3Igb25seSB0aGUgcmVzb3VyY2VzIG9mIGEgdGFzay4K
PiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4KPiA+
IC0tLQo+ID4gwqBpbmNsdWRlL2xpbnV4L2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MjkgKysrKysrKysKPiA+IMKgaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5owqDCoMKgwqDCoMKgIHzC
oMKgIDggKysrCj4gPiDCoGtlcm5lbC9icGYvdGFza19pdGVyLmPCoMKgwqDCoMKgwqDCoMKgIHwg
MTI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4gPiAtLS0tCj4gPiDCoHRvb2xzL2lu
Y2x1ZGUvdWFwaS9saW51eC9icGYuaCB8wqDCoCA4ICsrKwo+ID4gwqA0IGZpbGVzIGNoYW5nZWQs
IDE0NyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvYnBmLmggYi9pbmNsdWRlL2xpbnV4L2JwZi5oCj4gPiBpbmRleCAxMTk1
MDAyOTI4NGYuLjZiYmU1M2QwNmZhYSAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBm
LmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgKPiA+IEBAIC0xNzE2LDggKzE3MTYsMzcg
QEAgaW50IGJwZl9vYmpfZ2V0X3VzZXIoY29uc3QgY2hhciBfX3VzZXIKPiA+ICpwYXRobmFtZSwg
aW50IGZsYWdzKTsKPiA+IMKgwqDCoMKgwqDCoMKgIGV4dGVybiBpbnQgYnBmX2l0ZXJfICMjIHRh
cmdldChhcmdzKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gwqDC
oMKgwqDCoMKgwqAgaW50IF9faW5pdCBicGZfaXRlcl8gIyMgdGFyZ2V0KGFyZ3MpIHsgcmV0dXJu
IDA7IH0KPiA+IAo+ID4gKy8qCj4gPiArICogVGhlIHRhc2sgdHlwZSBvZiBpdGVyYXRvcnMuCj4g
PiArICoKPiA+ICsgKiBGb3IgQlBGIHRhc2sgaXRlcmF0b3JzLCB0aGV5IGNhbiBiZSBwYXJhbWV0
ZXJpemVkIHdpdGggdmFyaW91cwo+ID4gKyAqIHBhcmFtZXRlcnMgdG8gdmlzaXQgb25seSBzb21l
IG9mIHRhc2tzLgo+ID4gKyAqCj4gPiArICogQlBGX1RBU0tfSVRFUl9BTEwgKGRlZmF1bHQpCj4g
PiArICrCoMKgwqDCoCBJdGVyYXRlIG92ZXIgcmVzb3VyY2VzIG9mIGV2ZXJ5IHRhc2suCj4gPiAr
ICoKPiA+ICsgKiBCUEZfVEFTS19JVEVSX1RJRAo+ID4gKyAqwqDCoMKgwqAgSXRlcmF0ZSBvdmVy
IHJlc291cmNlcyBvZiBhIHRhc2svdGlkLgo+ID4gKyAqCj4gPiArICogQlBGX1RBU0tfSVRFUl9U
R0lECj4gPiArICrCoMKgwqDCoCBJdGVyYXRlIG92ZXIgcmVvc3VyY2VzIG9mIGV2ZXZyeSB0YXNr
IG9mIGEgcHJvY2VzcyAvIHRhc2sKPiA+IGdyb3VwLgo+ID4gKyAqLwo+ID4gK2VudW0gYnBmX2l0
ZXJfdGFza190eXBlIHsKPiA+ICvCoMKgwqDCoMKgwqAgQlBGX1RBU0tfSVRFUl9BTEwgPSAwLAo+
ID4gK8KgwqDCoMKgwqDCoCBCUEZfVEFTS19JVEVSX1RJRCwKPiA+ICvCoMKgwqDCoMKgwqAgQlBG
X1RBU0tfSVRFUl9UR0lELAo+ID4gK307Cj4gPiArCj4gPiDCoHN0cnVjdCBicGZfaXRlcl9hdXhf
aW5mbyB7Cj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX21hcCAqbWFwOwo+ID4gK8KgwqDC
oMKgwqDCoCBzdHJ1Y3Qgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW51bSBi
cGZfaXRlcl90YXNrX3R5cGUgdHlwZTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHVuaW9uIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1MzIgdGlkOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHUzMiB0Z2lkOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHUzMiBwaWRfZmQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+
ID4gK8KgwqDCoMKgwqDCoCB9IHRhc2s7Cj4gCj4gWW91IGRvbid0IHNlZW0gdG8gdXNlIHBpZF9m
ZCBpbiBicGZfaXRlcl9hdXhfaW5mbyBhdCBhbGwsIGlzIHRoYXQKPiByaWdodD8gRHJvcCBpdD8g
QW5kIGZvciB0aWQvdGdpZCwgSSdkIHVzZSBrZXJuZWwtc2lkZSB0ZXJtaW5vbG9neSBmb3IKPiB0
aGlzIGludGVybmFsIGRhdGEgc3RydWN0dXJlIGFuZCBqdXN0IGhhdmUgc2luZ2xlIHUzMiBwaWQg
aGVyZS4gVGhlbgo+IHR5cGUgZGV0ZXJtaW5lcyB3aGV0aGVyIHlvdSBhcmUgaXRlcmF0aW5nIHRh
c2tzIG9yIHRhc2sgbGVhZGVycwo+IChwcm9jZXNzZXMpLCBubyBhbWJpZ3VpdHkuCgpZZXMsIGl0
IHNob3VsZCBiZSByZW1vdmVkIGZyb20gc3RydWN0IGJwZl9pdGVyX2F1eF9pbmZvLgoKVXNpbmcg
anVzdCBzaW5nbGUgdTMyIHBpZCBoZXJlIGlzIGFsc28gZmluZSB0byBkaXN0aW5ndWlzaCBmaWVs
ZCBuYW1lcwpieSB0aGUgdHlwZSBvZiBkYXRhIGluc3RlYWQgb2YgdGhlIHB1cnBvc2Ugb2YgZGF0
YS4KCj4gCj4gPiDCoH07Cj4gPiAKPiA+IMKgdHlwZWRlZiBpbnQgKCpicGZfaXRlcl9hdHRhY2hf
dGFyZ2V0X3QpKHN0cnVjdCBicGZfcHJvZyAqcHJvZywKPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3VhcGkvbGludXgvYnBmLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgKPiA+IGluZGV4IGZm
Y2JmNzlhNTU2Yi4uNjMyOGFjYTBjZjVjIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xp
bnV4L2JwZi5oCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgKPiA+IEBAIC05MSw2
ICs5MSwxNCBAQCB1bmlvbiBicGZfaXRlcl9saW5rX2luZm8gewo+ID4gwqDCoMKgwqDCoMKgwqAg
c3RydWN0IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3UzMsKgwqAgbWFw
X2ZkOwo+ID4gwqDCoMKgwqDCoMKgwqAgfSBtYXA7Cj4gPiArwqDCoMKgwqDCoMKgIC8qCj4gPiAr
wqDCoMKgwqDCoMKgwqAgKiBQYXJhbWV0ZXJzIG9mIHRhc2sgaXRlcmF0b3JzLgo+ID4gK8KgwqDC
oMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCB7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBfX3UzMsKgwqAgdGlkOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgX191MzLCoMKgIHRnaWQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBfX3UzMsKgwqAgcGlkX2ZkOwo+ID4gK8KgwqDCoMKgwqDCoCB9IHRhc2s7Cj4gPiDCoH07Cj4g
PiAKPiAKPiBbLi4uXQoK

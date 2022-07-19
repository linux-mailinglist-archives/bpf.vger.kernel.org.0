Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DB657A9A9
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 00:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGSWNC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 18:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiGSWNB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 18:13:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D848EA9
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 15:13:00 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JI4xTB009727
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 15:13:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pF2PCp9aPwLcgpxB0aQRfrBUAh0W9AnRNhvzskRE6dU=;
 b=oFtkgpXygDAGg/BiPolZXrNhOHTZFko7J3FW30ZumV9PP8RohT9EsnvV4caaZT4VcYWt
 X30e9Di8PZddzl7aAOZhLF1BMdNImu4EYJuhw/gd24VnwAtg8x2xhlQNqtLLRX0jubIh
 wUH5957WmJwXjlicB1/VKEb22RiUwwWsEcE= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hdv1k47kx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 15:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo9zF9vGYFlI6rT67/1zL+XiEiLXxQvnhxR6H8fVfgX5dXSs4W9eZaAi8mlHoIH1z6h0sZjVEdxIuq75074Sb3ShIFqaIzdAcGezwtfNZl3kOCHoXbIrP5xGhrz7v9VUcjRqoYCCDw09CpeQLTuQB4O4w5z4zC2B/BVwYVsuDpEBMMCRKYafLYK59RzMFOprb9N7nM3rMTrIKC+T/NdkOQ2Ne/I2QJhk2mbkM+wukyWDJ+6K5QjYZIgbEIhGyc3gHe8adqIb7JUaVJvKdoC89Dgh+SQUzIIUh7RHq9qA4ulVoFca1Oj3X9afo8HCleUeAn7Xv9a1IHn4G0k81mql3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF2PCp9aPwLcgpxB0aQRfrBUAh0W9AnRNhvzskRE6dU=;
 b=gQDOc3NIWdAfRDWe6NHU33KYnupX5sFuGAuilZjlTttIudjn5sLxgqVZcvYeyJcFmb0PRyaQu5B6upTfSJcfP2/tl8ELwOX2pgUAQ3VIS7DDG6lACuaDKT00QDStvEIeH6aIZIWLNSbIMFTNSrUbEPspIvVvAgypOo2Dt884P8tkVe1ABUbKSnohyASO3a48cuf3hw58dUF199SNGA5NfB6jXKAT2f684A/EMMaipz/YitIUfvr6b4WFWLVn8FH464qH+st9RzTp+Bfy9IF8hDyLV2w25jq1tPo5e78sZ7Fh8ac5TYm+8jc/rKm8DZ7AVVt/nGRp4HU3oPl/Tiro+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB2683.namprd15.prod.outlook.com (2603:10b6:5:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 22:12:57 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 22:12:57 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "sdf@google.com" <sdf@google.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/3] Execution context callbacks
Thread-Topic: [PATCH RFC bpf-next 0/3] Execution context callbacks
Thread-Index: AQHYlW/snznW93TcsEKe6oR5OxPAGK17CZiAgAAIg4CAA52vAIABFUCAgAZUJwCAADPuAA==
Date:   Tue, 19 Jul 2022 22:12:57 +0000
Message-ID: <1ef3938729a61f2caa4cda9fe5784ea1d707f544.camel@fb.com>
References: <cover.1657576063.git.delyank@fb.com>
         <Ys24W4RJS0BAfKzP@google.com>
         <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
         <20220715015100.p7fwr7dbjyfbjjad@MacBook-Pro-3.local>
         <8ee9f9d1a5218ab23655d3f0d754aa5634a71d89.camel@fb.com>
         <20220719190204.vzkrfzsfkup6olfr@MacBook-Pro-3.local>
In-Reply-To: <20220719190204.vzkrfzsfkup6olfr@MacBook-Pro-3.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02b3eef2-4ec5-4d32-9eaa-08da69d3d5c5
x-ms-traffictypediagnostic: DM6PR15MB2683:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: apiUGH4RGmM7CAcTQtEJuV26SicWWdRQ+q5yR6sSk16Y8w6LgL7AibsHwMqfkyo64jROKVqN4BsNzXMxbS6gqHEnL5gI+A5UX1+KcZdlshf6hoHMRyhTB03AHdyIkt9/cBX+EBkGOcxCCnlgq16MNpJI3y9oXT6ekk8/N8HiGpc+EuiGp6+QX/wW4IBfaeMZyvnwto+P5GSj5K88s7Q5AXwFSUzEqwRmvQFIbviDVI+Kl7oytcaNFUDMWsYWcjsPEaO5m2So4/zM/CeCHVc5RGJsMOFoL5UX9clZUGLphp6XN5pV94AtGrRNrbsaO08RBEtxWP9QNFScvbxbjPQZ/bjc9HOAt8niPU8RTawySNbaoOVU560pAx+y9izGvj0FuEjSct3ZrtBDvheXYNZ8MzgUGjgfphZmauMsIJF8YJoJUMY/iLzC5admUbwaaGhTlbYQ20bQvLnTsBJOWZA6rxD2NfiIN71eKr4c20Ry6Z+pBf40py0XyuPdxVKM2QNSkwqBwvnZfmHs6EEXrmEMdTtEH8QwgoTGpEgKNGxfbcBXmaNbHM/ojbk6nFX7JaqQY9aqnHSbSyvdXJrOsOFjVoJMDOwVBikPdoCEvL7O7zGfW5q+m6cZGWeCpAsNQ0GlydG6C21Se1dtMf/pGKvtGKG1qeqmui/Eenmw2emTWK0da4fQtdRcVbfpR/S3tvvjCD1g25XU3gpC23gmMT8emuQxPSsq61UGpsvQxmldDpMWWkznsjs4IPHUaTf3O26W8fvquBOAIQzfI1wK87yggJPK6PPVUT4ndcni5LPAy+k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(36756003)(122000001)(186003)(86362001)(38070700005)(76116006)(83380400001)(41300700001)(38100700002)(64756008)(6512007)(54906003)(2906002)(6486002)(6916009)(478600001)(6506007)(26005)(2616005)(5660300002)(66476007)(71200400001)(4326008)(316002)(8936002)(66556008)(66946007)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXErQ0V3OVFBTjNOK0lkY0pzMloxOEdaQnE4aXJ0dmxjbnp1R2RuMFBZc1N1?=
 =?utf-8?B?clQ2NHpaV3dPKzduNDRUdXk4UTRzdC9YWU82eFU2bklENFUzUGN3eGhQdmpq?=
 =?utf-8?B?NHRmVE95T1hORW5VSHVTbzh0NmFWWVdhYm9mT2FqNVdwOFF5VDR0KzRGRFNy?=
 =?utf-8?B?ZWhKTVUwMjRGRDlSNjVkQWQraDA1L1lFWDhzSy9JN2tuTG9XUjQ2MHA1TURV?=
 =?utf-8?B?Y1BIMmp3VGxKQTRYSDNkMDdNaEkwNlRENnI0VWVxTitlRzFGNlBadWpQcEJW?=
 =?utf-8?B?QjZ4Wk1STld4Q3paVnZpaWhmdTNQOXJvdDNlZmltRk9FOEJxM0R5VHFPWVJJ?=
 =?utf-8?B?UjJPQ09VUjk4b1MwZ0FvMi8vcGVtdTdLUENJNEVmSzIxUW9WM3M5cmcxajJp?=
 =?utf-8?B?Wjl2NHUyK0d0YVd6Y1d2ZE0vbHdkL2J0Qm91U2QxSmpsU2lyK3JNUGpjN0pv?=
 =?utf-8?B?WEFyZ1JYNk5CcmlibXBYNHk2Y3NkNnJncitmMXpkSHhrblhsbmZ2R21Ub3Jo?=
 =?utf-8?B?V0xYZFBrRm5rbWZmWkNPSjVhcXc1UlR2QkxVbG5jcE03czZqK1NsRGVTSUR0?=
 =?utf-8?B?TnNQRTVENWRJUlowc1IyMk1TWXljZlFBWHN0MUpVUzZyTE0xRFFFUmRsQlpU?=
 =?utf-8?B?ek5Ya3R2M25rVm4za2RKUVlDSXRGdVFQeFZwY2lRd3F4aEEzNlVuNG9NODJq?=
 =?utf-8?B?YXUrQml0RTVzYU5RYlFRK1ozRldyNGEyb2ZQb01nb1ZKcEd5REJUdUFhWjRz?=
 =?utf-8?B?Tkg5VzBqdzRSbkVWdDR3ekl0L3p1ZUx1aFd0Y2ttb3ZzQ0I4RlovWU5jZGI1?=
 =?utf-8?B?aXN0U0dPaytHUUNoaUkzaXdDbmhhN3hwWis1YUpRSW5uY2RiVDRmYUVSdGs0?=
 =?utf-8?B?RDBhd2ZlUlRzQlFnWmp1WXpsaC84Nk1jTXU5YTh3YjhHMzM2ek5MNERXT1JY?=
 =?utf-8?B?cFpCV3hwdnRiZ2t5UWlSaUNtcTBsN1NRSFNWdlcwVzh5UXNOZWF2LzkvbUtp?=
 =?utf-8?B?NE94Q0ZTNHNyMVF6OUtCdzdvWE9DWjY5SWRFSzJVSUJ2dWRBWTZEOTQwT0tU?=
 =?utf-8?B?cjNpNXNMbGMvNk04L3ZKZ0dsYmJxTzdBaXNLclBDTWJWQTZWTTZpL2hXR2J0?=
 =?utf-8?B?YTAvMVZKWE5aMXQzQTJJdzl1UTJrVzVsQTZWc1RwL2w0cjM0WlY1eVQrSXdn?=
 =?utf-8?B?T2FQYUxqRWdYZ0NmZWx2Vi9XcmhubzdYUXVPUlF5dDFleTEwTDZZeG9JTlRD?=
 =?utf-8?B?VGtVTGdSaWhSOUNyM2xOZkdWMWNUcU84TnVJYmtzNGU4cGU0VXROK04vd3h4?=
 =?utf-8?B?bW9yUWNkWTZ3SkRSeWc3WmlOZUhGSm1tVExsVC9kVlFobWRUOVVMSXVxRmQy?=
 =?utf-8?B?aEVwTW9lK2M1NXhGWnJHUFBPNGZzdnpaY3BuZThkMDY1b0t2bXVDbi9NVWFu?=
 =?utf-8?B?VnhQS1VYWno3UURjZzZrK2xCaDZrSmdlN3gzVzRHZzRNMFVIR0xrZ0llQWR5?=
 =?utf-8?B?ck5aQnlBV3QxemlQZWZnaTZaeXhSOGpkTzVCRHN1V084c3VYVmFuMUVwbC9v?=
 =?utf-8?B?NzN0czQ0MGFjbi8yRHNZaVRhK1M1aC90cUJEYmovUEdMZzduOU1BVW9ZaVFQ?=
 =?utf-8?B?MlVTcE5QQXNHZmcyRVNnVGFSa1NrbUREYnA0TzRCUk1TUDJJU2RNb2F0a0JR?=
 =?utf-8?B?ZmFFZWQ3VmkwSlNnWHVmbm5GekIrS3dlc0Z4MUx5QUtyQVhVVXZKcFVLeEFa?=
 =?utf-8?B?YS92bzRRZG95dkxZL002TDJwWENvTit2NEhQTjRmbGdQS3RhaGRkNktENFIz?=
 =?utf-8?B?bzZFOG10aUpibGh1VTBTMjMwYVVnay94WkV4Nm9GbGRKTzRRajkzVk5kODQv?=
 =?utf-8?B?d05Ua2N3VFBKeTFMeGljeXVsRy9TV2pLamVWbzNBQy8vQjVtVjczWDFZWmdV?=
 =?utf-8?B?Zmx5SCtINnNmR3UzL3BObTBhZXJaa2Y5US83YUhWTW44dTNKY29pc1cyMHkr?=
 =?utf-8?B?YnhDbEFyaXNpSU03VXBiTWlxQTBHN2RtRllVSVBuMGdoWGlEZ3pFdkdObjds?=
 =?utf-8?B?WWJpZnU0MnEybFBLa2txNlYwUXJuTzNqS0xjYkVqMXlSQnhHdzcrRDNVOHla?=
 =?utf-8?Q?nBRciWRCAf5C2Latdq5m0lwqZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30731605D64D2B42B07CBE80C646EB7C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b3eef2-4ec5-4d32-9eaa-08da69d3d5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 22:12:57.1860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZKuyvE/DbDg+kCevFYQbxEuaBllnenxHw8aWgPd3uj5eGFOBWM1JxZtWMzwy5i7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2683
X-Proofpoint-ORIG-GUID: FLY7CbHsk2oh44gu7bVka_C5rkAaTsvM
X-Proofpoint-GUID: FLY7CbHsk2oh44gu7bVka_C5rkAaTsvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_08,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA3LTE5IGF0IDEyOjAyIC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIEZyaSwgSnVsIDE1LCAyMDIyIGF0IDA2OjI4OjIwUE0gKzAwMDAsIERlbHlhbiBL
cmF0dW5vdiB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjItMDctMTQgYXQgMTg6NTEgLTA3MDAsIEFs
ZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgSnVsIDEyLCAyMDIyIGF0IDA2
OjQyOjUyUE0gKzAwMDAsIERlbHlhbiBLcmF0dW5vdiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+
ID4gYnV0IGhhdmUgeW91IHRob3VnaCBvZiBtYXliZSBpbml0aWFsbHkgc3VwcG9ydGluZyBzb21l
dGhpbmcgbGlrZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBicGZfdGltZXJfaW5pdCgmdGltZXIs
IG1hcCwgU09NRV9ORVdfREVGRVJSRURfTk1JX09OTFlfRkxBRyk7DQo+ID4gPiA+ID4gYnBmX3Rp
bWVyX3NldF9jYWxsYmFjaygmdGltZXIsIGNnKTsNCj4gPiA+ID4gPiBicGZfdGltZXJfc3RhcnQo
JnRpbWVyLCAwLCAwKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJZiB5b3UgaW5pdCBhIHRpbWVy
IHdpdGggdGhhdCBzcGVjaWFsIGZsYWcsIEknbSBhc3N1bWluZyB5b3UgY2FuIGhhdmUNCj4gPiA+
ID4gPiBzcGVjaWFsIGNhc2VzIGluIHRoZSBleGlzdGluZyBoZWxwZXJzIHRvIHNpbXVsYXRlIHRo
ZSBkZWxheWVkIHdvcms/DQo+ID4gPiA+IA0KPiA+ID4gPiBQb3RlbnRpYWxseSBidXQgSSBoYXZl
IHNvbWUgcmVzZXJ2YXRpb25zIGFib3V0IGRyYXdpbmcgdGhpcyBlcXVpdmFsZW5jZS4NCj4gPiA+
IA0KPiA+ID4gaHJ0aW1lciBhcGkgaGFzIHZhcmlvdXM6IGZsYWdzLiBzb2Z0IHZzIGhhcmQgaXJx
LCBwaW5uZWQgYW5kIG5vdC4NCj4gPiA+IFNvIHRoZSBzdWdnZXN0aW9uIHRvIHRyZWF0IGlycV93
b3JrIGNhbGxiYWNrIGFzIHNwZWNpYWwgdGltZXIgZmxhZw0KPiA+ID4gYWN0dWFsbHkgZml0cyB3
ZWxsLg0KPiA+ID4gDQo+ID4gPiBicGZfdGltZXJfaW5pdCArIHNldF9jYWxsYmFjayArIHN0YXJ0
IGNhbiBiZSBhIHN0YXRpYyBpbmxpbmUgZnVuY3Rpb24NCj4gPiA+IG5hbWVkIGJwZl93b3JrX3N1
Ym1pdCgpIGluIGJwZl9oZWxwZXJzLmgNCj4gPiA+IChvciBzb21lIG5ldyBmaWxlIHRoYXQgd2ls
bCBtYXJrIHRoZSBiZWdpbm5pbmcgbGliYy1icGYgbGlicmFyeSkuDQo+ID4gPiBSZXVzaW5nIHN0
cnVjdCBicGZfdGltZXIgYW5kIGFkZGluZyB6ZXJvLWRlbGF5IGNhbGxiYWNrIGNvdWxkIHByb2Jh
Ymx5IGJlDQo+ID4gPiBlYXNpZXIgZm9yIHVzZXJzIHRvIGxlYXJuIGFuZCBjb25zdW1lLg0KPiA+
IA0KPiA+IFRvIGNsYXJpZnksIHdlJ3JlIHRhbGtpbmcgYWJvdXQgMSkgbWFraW5nIGJwZl90aW1l
ciBubWktc2FmZSBmb3IgX3NvbWVfIGJ1dCBub3QgYWxsDQo+ID4gY29tYmluYXRpb25zIG9mIHBh
cmFtZXRlcnMgYW5kIDIpIGFkZGluZyBuZXcgZmxhZ3MgdG8gc3BlY2lmeSBhbiBleGVjdXRpb24g
Y29udGV4dD8NCj4gPiBJdCdzIGFjaGlldmFibGUgYnV0IGl0J3MgaGFyZCB0byBzZWUgaG93IGl0
J3MgdGhlIHN1cGVyaW9yIHNvbHV0aW9uIGhlcmUuDQo+ID4gDQo+ID4gPiANCj4gPiA+IFNlcGFy
YXRlbHk6DQo+ID4gPiArc3RydWN0IGJwZl9kZWxheWVkX3dvcmsgew0KPiA+ID4gKyAgICAgICBf
X3U2NCA6NjQ7DQo+ID4gPiArICAgICAgIF9fdTY0IDo2NDsNCj4gPiA+ICsgICAgICAgX191NjQg
OjY0Ow0KPiA+ID4gKyAgICAgICBfX3U2NCA6NjQ7DQo+ID4gPiArICAgICAgIF9fdTY0IDo2NDsN
Cj4gPiA+ICt9IF9fYXR0cmlidXRlX18oKGFsaWduZWQoOCkpKTsNCj4gPiA+IGlzIG5vdCBleHRl
bnNpYmxlLg0KPiA+ID4gSXQgd291bGQgYmUgYmV0dGVyIHRvIGFkZCBpbmRpcmVjdGlvbiB0byBh
bGxvdyBrZXJuZWwgc2lkZSB0byBncm93DQo+ID4gPiBpbmRlcGVuZGVudGx5IGZyb20gYW1vdW50
IG9mIHNwYWNlIGNvbnN1bWVkIGluIGEgbWFwIHZhbHVlLg0KPiA+IA0KPiA+IEZhaXIgcG9pbnQs
IEkgd2FzIHdvbmRlcmluZyB3aGF0IHRvIGRvIHdpdGggaXQgLSBzdG9yaW5nIGp1c3QgYSBwb2lu
dGVyIHNvdW5kcw0KPiA+IHJlYXNvbmFibGUuDQo+ID4gDQo+ID4gPiBDYW4geW91IHRoaW5rIG9m
IGEgd2F5IHRvIG1ha2UgaXJxX3dvcmsvc2xlZXBhYmxlIGNhbGxiYWNrIGluZGVwZW5kZW50IG9m
IG1hcHM/DQo+ID4gPiBBc3N1bWUgYnBmX21lbV9hbGxvYyBpcyBhbHJlYWR5IGF2YWlsYWJsZSBh
bmQgTk1JIHByb2cgY2FuIGFsbG9jYXRlIGEgdHlwZWQgb2JqZWN0Lg0KPiA+ID4gVGhlIHVzYWdl
IGNvdWxkIGJlOg0KPiA+ID4gc3RydWN0IG15X3dvcmsgew0KPiA+ID4gICBpbnQgYTsNCj4gPiA+
ICAgc3RydWN0IHRhc2tfc3RydWN0IF9fa3B0cl9yZWYgKnQ7DQo+ID4gPiB9Ow0KPiA+ID4gdm9p
ZCBteV9jYihzdHJ1Y3QgbXlfd29yayAqdyk7DQo+ID4gPiANCj4gPiA+IHN0cnVjdCBteV93b3Jr
ICp3ID0gYnBmX21lbV9hbGxvYyhhbGxvY2F0b3IsIGJwZl9jb3JlX3R5cGVfaWRfbG9jYWwoKncp
KTsNCj4gPiA+IHctPnQgPSAuLjsNCj4gPiA+IGJwZl9zdWJtaXRfd29yayh3LCBteV9jYiwgU0xF
RVBBQkxFIHwgSVJRX1dPUkspOw0KPiA+ID4gDQo+ID4gPiBBbSBJIGRheSBkcmVhbWluZz8gOikN
Cj4gPiANCj4gPiBOb3RoaW5nIHdyb25nIHdpdGggZHJlYW1pbmcgb2YgYSBiZXR0ZXIgZnV0dXJl
IDopIA0KPiA+IA0KPiA+IChJJ20gYXNzdW1pbmcgeW91J3JlIHRoaW5raW5nIG9mIGJwZl9tZW1f
YWxsb2MgYmVpbmcgZnJvbnRlZCBieSB0aGUgYWxsb2NhdG9yIHlvdQ0KPiA+IHJlY2VudGx5IHNl
bnQgdG8gdGhlIGxpc3QuKQ0KPiA+IA0KPiA+IE9uIGEgZmlyc3QgcGFzcywgaGVyZSBhcmUgbXkg
Y29uY2VybnM6DQo+ID4gDQo+ID4gQSBwcm9ncmFtIGFuZCBpdHMgbWFwcyBjYW4gZ3VhcmFudGVl
IGEgY2VydGFpbiBhbW91bnQgb2Ygc3RvcmFnZSBmb3Igd29yayBpdGVtcy4NCj4gPiBTaXppbmcg
dGhhdCBzdG9yYWdlIGlzIGRpZmZpY3VsdCBidXQgaXQgaXMgeW91cnMgYWxvbmUgdG8gdXNlLiBU
aGUgZnJlZWxpc3QgYWxsb2NhdG9yDQo+ID4gY2FuIGJlIHRyYW5zaWVudGx5IGRyYWluZWQgYnkg
b3RoZXIgcHJvZ3JhbXMgYW5kIHN0YXJ2ZSB5b3Ugb2YgdGhpcyB1dGlsaXR5LiBUaGlzIGlzDQo+
ID4gYSBuZXcgZmFpbHVyZSBtb2RlLCBzbyBpdCdzIHdvcnRoIHRhbGtpbmcgYWJvdXQuDQo+IA0K
PiBUaGF0IHdvdWxkIGJlIHRoZSBpc3N1ZSBvbmx5IHdoZW4gcHJvZ3MgZGVsaWJlcmF0ZWx5IHNo
YXJlIHRoZSBhbGxvY2F0b3IuDQo+IEluIHRoaXMgc3RtdDoNCj4gc3RydWN0IG15X3dvcmsgKncg
PSBicGZfbWVtX2FsbG9jKGFsbG9jYXRvciwgYnBmX2NvcmVfdHlwZV9pZF9sb2NhbCgqdykpOw0K
PiBUaGUgJ2FsbG9jYXRvcicgY2FuIGJlIHVuaXF1ZSBmb3IgZWFjaCBwcm9nIG9yIHNoYXJlZCBh
Y3Jvc3MgZmV3IHByb2dzIGluIHRoZSBzYW1lIC5jIGZpbGUuDQo+IEkgd2Fzbid0IHBsYW5uaW5n
IHRvIHN1cHBvcnQgb25lIGdsb2JhbCBhbGxvY2F0b3IuDQo+IEp1c3QgbGlrZSBvbmUgZ2xvYmFs
IGhhc2ggbWFwIGRvZXNuJ3QgcXVpdGUgbWFrZSBzZW5zZS4NCj4gVGhlIHVzZXIgaGFzIHRvIGNy
ZWF0ZSBhbiBhbGxvY2F0b3IgZmlyc3QsIGdldCBpdCBjb25uZWN0ZWQgd2l0aCBtZW1jZywNCj4g
YW5kIHVzZSB0aGUgZXhwbGljaXQgb25lIGluIHRoZWlyIGJwZiBwcm9ncy9tYXBzLg0KPiANCj4g
PiBXaXRoIGEgZ2VuZXJpYyBhbGxvY2F0b3IgbWVjaGFuaXNtLCB3ZSdsbCBoYXZlIGEgaGFyZCB0
aW1lIGVuZm9yY2luZyB0aGUgY2FuJ3QtbG9hZC0NCj4gPiBvci1zdG9yZS1pbnRvLXNwZWNpYWwt
ZmllbGRzIGxvZ2ljLiBJIGxpa2UgdGhhdCBndWFyZHJhaWwgYW5kIEknbSBub3Qgc3VyZSBob3cg
d2UnZA0KPiA+IGFjaGlldmUgdGhlIHNhbWUgZ3VhcmFudGVlcy4gKEluIHlvdXIgc25pcHBldCwg
d2UgZG9uJ3QgaGF2ZSB0aGUgbGxpc3Rfbm9kZSBvbiB0aGUNCj4gPiB3b3JrIGl0ZW0gLSBkbyB3
ZSB3cmFwIG15X3dvcmsgaW50byBzb21ldGhpbmcgZWxzZSBpbnRlcm5hbGx5PyBUaGF0IHdvdWxk
IGhpZGUgdGhlDQo+ID4gZmllbGRzIHRoYXQgbmVlZCBwcm90ZWN0aW5nIGF0IHRoZSBleHBlbnNl
IG9mIGFuIGV4dHJhIGJwZl9tZW1fYWxsb2MgYWxsb2NhdGlvbi4pDQo+IA0KPiBicGZfbWVtX2Fs
bG9jIHdpbGwgcmV0dXJuIHJlZmVyZW5jZWQgUFRSX1RPX0JURl9JRC4NCj4gRXZlcnkgZmllbGQg
aW4gdGhpcyBzdHJ1Y3R1cmUgaXMgdHlwZWQuIFNvIGl0J3MgdHJpdmlhbCBmb3IgdGhlIHZlcmlm
aWVyIHRvIG1ha2UNCj4gc29tZSBvZiB0aGVtIHJlYWQgb25seSBvciBub3QgYWNjZXNpYmxlIGF0
IGFsbC4NCj4gJ3N0cnVjdCBteV93b3JrJyBjYW4gaGF2ZSBhbiBleHBsaWNpdCBzdHJ1Y3QgYnBm
X2RlbGF5ZWRfd29yayBmaWVsZC4gRXhhbXBsZToNCj4gc3RydWN0IG15X3dvcmsgew0KPiAgIHN0
cnVjdCBicGZfZGVsYXllZF93b3JrIHdvcms7IC8vIG5vdCBhY2Nlc3NpYmxlIGJ5IHByb2cNCj4g
ICBpbnQgYTsgLy8gc2NhbGFyIHJlYWQvd3JpdGUNCj4gICBzdHJ1Y3QgdGFza19zdHJ1Y3QgX19r
cHRyX3JlZiAqdDsgIC8vIGtwdHIgc2VtYW50aWNzDQo+IH07DQoNClN1cmUsIGFueXRoaW5nIGlz
IHBvc3NpYmxlLCBpdCdzIGp1c3QgbW9yZSBjb21wbGV4aXR5IGFuZCB0aGVzZSBjaGVja3MgYXJl
IG5vdA0KZXhhY3RseSBlYXN5IHRvIGZvbGxvdyByaWdodCBub3cuwqANCg0KQWx0ZXJuYXRpdmVs
eSwgd2UgY291bGQgZG8gdGhlIGNsYXNzaWMgYWxsb2NhdG9yIHRoaW5nIGFuZCBhbGxvY2F0ZSBh
Y2NvdW50aW5nIHNwYWNlDQpiZWZvcmUgdGhlIHBvaW50ZXIgd2UgcmV0dXJuLiBTb21lIG1hZ2lj
IGZsYWcgY291bGQgdGhlbiBleHBhbmQgdGhlIHNwYWNlIGVub3VnaCB0bw0KdXNlIGZvciBzdWJt
aXRfd29yay4gU29tZSBhbGxvY2F0aW9ucyB3b3VsZCBiZSBidW1wZWQgdG8gYSBoaWdoZXIgYnVj
a2V0IGJ1dCB0aGF0J3MNCm9rYXkgYmVjYXVzZSBpdCB3b3VsZCBiZSBjb25zdHN0ZW50IG92ZXJo
ZWFkIGZvciB0aG9zZSBhbGxvY2F0aW9uIHNpdGVzLg0KDQo+IA0KPiA+IE1hbmFnaW5nIHRoZSBz
dG9yYWdlIHJldHVybmVkIGZyb20gYnBmX21lbV9hbGxvYyBpcyBvZiBjb3Vyc2UgYWxzbyBhIGNv
bmNlcm4uIFdlJ2QNCj4gPiBuZWVkIHRvIHRyZWF0IGJwZl9zdWJtaXRfd29yayBhcyAicmVsZWFz
aW5nIiBpdCAocmVhbGx5LCB0YWtpbmcgb3duZXJzaGlwKS4gVGhpcyBwYXRoDQo+ID4gbWVhbnMg
bW9yZSBsaWZlY3ljbGUgYW5hbHlzaXMgaW4gdGhlIHZlcmlmaWVyIGFuZCBleHBsaWNpdCBhbmQg
aW1wbGljaXQgZnJlZSgpcy4NCj4gDQo+IFdoYXQgaXMgdGhlIGFjdHVhbCBjb25jZXJuPw0KPiBi
cGZfc3VibWl0X3dvcmsgd2lsbCBoYXZlIGNsZWFyICJyZWxlYXNlIiBzZW1hbnRpY3MuIFRoZSB2
ZXJpZmllciBhbHJlYWR5IHN1cHBvcnRzIGl0Lg0KPiBUaGUgJ215X2NiJyBjYWxsYmFjayB3aWxs
IHJlY2VpdmUgcmVmZXJlbmNlIFBUUl9UT19CVEZfSUQgYXMgd2VsbCBhbmQgd291bGQNCj4gaGF2
ZSB0byByZWxlYXNlIGl0IHdpdGggYnBmX21lbV9mcmVlKG1hLCB3KS4NCj4gSGVyZSBpcyBtb3Jl
IGNvbXBsZXRlIHByb3Bvc2FsOg0KPiANCj4gc3RydWN0IHsNCj4gICAgICAgICBfX3VpbnQodHlw
ZSwgQlBGX01FTV9BTExPQyk7DQo+IH0gYWxsb2NhdG9yIFNFQygiLm1hcHMiKTsNCg0KSSBsaWtl
IHRoaXMsIHNvIGxvbmcgYXMgd2UgcHJlLWFsbG9jYXRlIGVub3VnaCB0byBzdWJtaXQgbW9yZSBz
bGVlcGFibGUgd29yaw0KaW1tZWRpYXRlbHkgLSB0aGUgZmlyc3Qgd29yayBpdGVtIHRoZSBwcm9n
cmFtIHN1Ym1pdHMgY291bGQgdGhlbiBwcmVmaWxsIG1vcmUgaXRlbXMuDQoNCkZvciBhbiBldmVu
IGJldHRlciBleHBlcmllbmNlLCBpdCB3b3VsZCBiZSBncmVhdCBpZiB3ZSBjb3VsZCBzcGVjaWZ5
IGluIHRoZSBtYXANCmRlZmluaXRpb24gdGhlIG51bWJlciBvZiBpdGVtcyBvZiBzaXplIFggd2Un
bGwgbmVlZC4gSWYgd2UgZ2l2ZSB0aGF0IGxldmVyIHRvIHRoZQ0KZGV2ZWxvcGVyLCB0aGV5IGNh
biB0aGVuIHVzZSBpdCBzbyB0aGV5IG5ldmVyIGhhdmUgdG8gb3JjaGVzdHJhdGUgc2xlZXBhYmxl
IHdvcmsgdG8NCmNhbGwgYnBmX21lbV9wcmVhbGxvYyBleHBsaWNpdGx5Lg0KDQo+IA0KPiBzdHJ1
Y3QgbXlfd29yayB7DQo+ICAgc3RydWN0IGJwZl9kZWxheWVkX3dvcmsgd29yazsNCj4gICBpbnQg
YTsNCj4gICBzdHJ1Y3QgdGFza19zdHJ1Y3QgX19rcHRyX3JlZiAqdDsNCj4gfTsNCj4gDQo+IHZv
aWQgbXlfY2Ioc3RydWN0IG15X3dvcmsgKncpDQo+IHsNCj4gICAvLyBhY2Nlc3Mgdw0KPiAgIGJw
Zl9tZW1fZnJlZSgmYWxsb2NhdG9yLCB3KTsNCj4gfQ0KPiANCj4gdm9pZCBicGZfcHJvZyguLi4p
DQo+IHsNCj4gICBzdHJ1Y3QgbXlfd29yayAqdyA9IGJwZl9tZW1fYWxsb2MoJmFsbG9jYXRvciwg
YnBmX2NvcmVfdHlwZV9pZF9sb2NhbCgqdykpOw0KPiAgIHctPnQgPSAuLjsNCj4gICBicGZfc3Vi
bWl0X3dvcmsodywgbXlfY2IsIFVTRV9JUlFfV09SSyk7DQo+IH0NCj4gDQo+ID4gSSdtIG5vdCBv
cHBvc2VkIHRvIGl0IG92ZXJhbGwgLSB0aGUgZGV2ZWxvcGVyIGV4cGVyaWVuY2UgaXMgdmVyeSBm
YW1pbGlhciAtIGJ1dCBJIGFtDQo+ID4gcHJpbWFyaWx5IHdvcnJpZWQgdGhhdCBhbGxvY2F0b3Ig
ZmFpbHVyZXMgd2lsbCBiZSBpbiB0aGUgc2FtZSBjYXRlZ29yeSBvZiBpc3N1ZXMgYXMNCj4gPiB0
aGUgaGFzaCBtYXAgY29sbGlzaW9ucyBmb3Igc3RhY2tzLiBJZiB5b3Ugd2FudCByZWxpYWJpbGl0
eSwgeW91IGp1c3QgZG9uJ3QgdXNlIHRoYXQNCj4gPiB0eXBlIG9mIG1hcCAtIHdoYXQncyB0aGUg
YWx0ZXJuYXRpdmUgaW4gdGhpcyBoeXBvdGhldGljYWwgYnBmX21lbV9hbGxvYyBmdXR1cmU/DQo+
IA0KPiBSZWxpYWJpbGl0eSBvZiBhbGxvY2F0aW9uIGlzIGNlcnRpYW5seSBuZWNlc3NhcnkuDQo+
IGJwZl9tZW1fYWxsb2Mgd2lsbCBoYXZlIGFuIGFiaWxpdHkgdG8gX3N5bmNocm9ub3VzbHlfIHBy
ZWFsbG9jYXRlIGludG8gZnJlZWxpc3QNCj4gZnJvbSBzbGVlcGFibGUgY29udGV4dCwgc28gYnBm
IHByb2cgd2lsbCBoYXZlIGZ1bGwgY29udHJvbCBvZiB0aGF0IGZyZWUgbGlzdC4NCg0KSSB0aGlu
ayBoYXZpbmcgdGhlIG1hcCBpbml0aWFsaXplZCBhbmQgcHJlZmlsbGVkIG9uIGxvYWQgYW5kIGhh
dmluZyBzbGVlcGFibGUgd29yaw0KZnJvbSB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0aGlzIG1lY2hh
bmlzbSBiZWNvbWVzIGEgcmVxdWlyZW1lbnQgb2YgdGhpcyBkZXNpZ24uIEhhdmluZw0KdGhlIHBy
ZWZpbGwgcmVxdWlyZW1lbnRzIChudW1iZXIgb2YgaXRlbXMgYW5kIHNpemUpIG9uIHRoZSBtYXAg
ZGVmaW5pdGlvbiByZW1vdmVzIHRoZQ0KcmVxdWlyZW1lbnQgdG8gaGF2ZSBzbGVlcGFibGUgd29y
ayBmcm9tIGRheSBvbmUuDQoNCkhvdyBkbyB5b3Ugd2FudCB0byBzZXF1ZW5jZSB0aGlzPyBEbyB5
b3UgcGxhbiB0byBkbyB0aGUgd29yayB0byBleHBvc2UgYnBmX21lbV9hbGxvYw0KdG8gcHJvZ3Jh
bXMgYXMgcGFydCBvZiB0aGUgaW5pdGlhbCBzZXJpZXMgb3IgYXMgYSBsYXRlciBmb2xsb3d1cD8g
DQoNCi0tIERlbHlhbg0K

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A708B4D903E
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiCNXTs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 19:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiCNXTr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 19:19:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542121EAF4
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 16:18:35 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22EMaWku031962
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 16:18:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BE27d+aaEwWxv1Rn3yQOGh5/d18Bjf3hKYFyyFmGv/s=;
 b=NPrWZBtwdoHTaWD6W1aJ/aXEWFvX7cPtq+fDGzSjK5sUJO0yaCTGbhTpQQqV4fLBmp8z
 29/LxNp8lgrKUfNCiL4PIRPi0b5QwvNe0pphvZndZNabA4mxJ3tYuqHKLRPEAgflRlrE
 QuyJXvnK4kxNTi2hv77VnKOXibiGdCIF0eM= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by m0089730.ppops.net (PPS) with ESMTPS id 3et99mb8kp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 16:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5snjdpisyVobN0//kMEM/At8JiVhlfTS4jL/GYsuigb22+HY6e8Vg3Um/1Jwu5bDxNsLxtJmZtUITLc825ylS2FGSNV7tLb1bBiTLsiaPPkpfIFz+o8cN2S4s9fAzI02o8otzAOy+XLTO84nOouZTMQkPu7IzKWK4FmVBrDOr56fWTO4arzdPIcwtJC/LZxnrJ3ztNUJV/xilP6QEvzFv+B8eZx/aDO7mvWVFkIf2LS3CjAlkGj1t9w1kCu+1qDOEIcyHtzB48wgAVo103TDp6SkzhYZLewYlATQ2TtwA+Pd04q7TgTYWXmEm/IFjZLIkI9VbcYhTq+TqtIz9wwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE27d+aaEwWxv1Rn3yQOGh5/d18Bjf3hKYFyyFmGv/s=;
 b=QFJWhZTYMm/fMa0vgdmPyniwfljmUGmIJIuf9J0ZhScaBSWvqNf6Q8RriphC1PZSDdw8/mxI61rFXGSvZMbA3IIjMiSIpzgeVMRJ9E+fcLuRmBK0KLVkq8Dr8LiKNF/Y7SFXezEOEkTkRZf7VePuVRCnUVtg0/dSVPsU8O6CBXAhczVKUVquUfLb46L5M1Vt402Yv4WhuVv8uyveTXhd3y1dyBhAnnGiCT+Vn1cjxcGkraAT1BSlg416VD0KXfBtwf3TVqAAZnCm8GCmFew8/7x07+I/Gw+U9UE4VQLu2eH5skN6TMdxnDfi3BhJ49oGDGw795i+bF8S8lxjopa6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MN2PR15MB4253.namprd15.prod.outlook.com (2603:10b6:208:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 23:18:32 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 23:18:32 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/5] bpftool: add support for subskeletons
Thread-Topic: [PATCH bpf-next v2 4/5] bpftool: add support for subskeletons
Thread-Index: AQHYNNydupPAactdBUG4tOXk3PpOhqy61V6AgASzJoA=
Date:   Mon, 14 Mar 2022 23:18:32 +0000
Message-ID: <e3e84d87c2a0c13ae9f20e44493c1578e06b6618.camel@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
         <d3ee2b3bb282e8aa0e6ab01ca4be522004a7cba0.1646957399.git.delyank@fb.com>
         <CAEf4BzaeycEUjZVCd+7sxFaQWfbqhmsMd_G_bydS15+45LcDvA@mail.gmail.com>
In-Reply-To: <CAEf4BzaeycEUjZVCd+7sxFaQWfbqhmsMd_G_bydS15+45LcDvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 454c82f9-2fb2-499f-092b-08da0610f4d8
x-ms-traffictypediagnostic: MN2PR15MB4253:EE_
x-microsoft-antispam-prvs: <MN2PR15MB4253FCB32A8274E3A970C06EC10F9@MN2PR15MB4253.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLoUpAhS9oWAZU5qmE2Zj5LJfHAIdQuoi8etg2dXO/gIyz6p8QRWEyXeeCw5XXUT73FBgTztXrHaMrYVu/jyZWzFNNuIatItdSmGAUpI6rFY4pEe8Ufp1RSfjhFOnb2PG24icat9zvjCTDm+RzfkWey07SV62FzIZ3yElViMJ87TCz0EmUxztDm5ZWmmo1O+EHXKYDB1a8oWiw7Fg0DHi42eASQ8W8sQOd5COiTD2oduKAvSNIauRyxTbvAkeSIDwJFiUgQTi2rro7RHx+DLBRsSVyB9XTV1XunMjmq4hXM16DXCge3H/hs8HguT6TAFkmpUg36X0xGxs9E/HHwzdWBZuBNAaTBRJqRrGEfdGEBZhDUgpvMOwFFIAPy2QPottH+t2Q7KQfrVICKXwk9rwodvW3zOtaOWRFcOI1oHHOlc/lYGqEbHR3qBEknIb+ZpWkPgdDrKUAIf3Fu14ns5laWcUcWr1vQkx0H7AnnKE36Rye6OH2NgRJ+mzY3UuZxHWEp3K1xFtvyEyp9H5+uCoAbVS3UzIUezfi5q9s7q0JIh6n6BRKdyhz1qFma2uUJRKvpa3DrjGf2nWYW4tZQIL6O7g5Xccps6bfP8PemRRrTcPcuYbqBSE6b1SMeUCn1ZNirUKWYlIIDqZ8C1YMiV9X1jV+OMF7eSH5SjEhrbmouzwtHPvrTAFPaav8TUC4PnzZO5eMm5dgR9eHs4e4l1Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(6512007)(6506007)(54906003)(508600001)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(36756003)(83380400001)(4326008)(6486002)(8676002)(38070700005)(86362001)(122000001)(2906002)(2616005)(71200400001)(8936002)(38100700002)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1FDY0RxOU1GaVh0d1F6aEhjMzQzazZmZHZnOWhJd2pFcUFaL3pUNVMzcklU?=
 =?utf-8?B?L2Yvb2hYanhJdkN2L2FYaDhjTVVJcjMzSjJBRy9yVEluTlg4bzRQUmNMcE4y?=
 =?utf-8?B?WkIxOStZanFYWkdoQWRCMjE0SWtCVU03d0tYOFJqVDlGR1BVS3hSZlpaWmJ1?=
 =?utf-8?B?ZHNsam10NUFvQlVWb1pLV1BEMkpWd05tTmlmL3JqQy8vdm5vdGhqTGxiaUVV?=
 =?utf-8?B?TUhaQnIvY2JwTHB4VW5NMitFWlVwQytrNDRmVTBhOFRsa1lPUFZ5S2FBa0l4?=
 =?utf-8?B?dGwwUUlOSmxpbng2MGxJbkkxK0U5WUhKTGE5Mlptb3ZmN3pYWkFJTHM4b1Iv?=
 =?utf-8?B?eER3RmVUNXdrU1FwcXNIUHo5d0N0VnJwUHFOYi84aUtPeGV0d1RackJUdmhj?=
 =?utf-8?B?VlIxMmNlSVVIU2d2MGJoSCtyWDVnWnlTWTl4R0c2MTQ4SE5sVFpXUUhwQm0w?=
 =?utf-8?B?dDMzbEZrYmhMUTRmM2swUmF3OUpEM21RUUx3Y2RhTmplVGNrS1h0WjNqQzNY?=
 =?utf-8?B?akRGRjZhUjE4N05JcHgrTGtBR2hUcGZaQ0VYd05jbHUzaVJZaW1NbmdIbUlN?=
 =?utf-8?B?dDdBQ2RrOVdXWHJIeFhwdlRmWWFUY1Z4NDJUT003MlFPWkIwWTUrc2tydTBh?=
 =?utf-8?B?aTRyelVtb3BtdktMcWRiSEQ4UHkySU8zTklTakZITWZaOVM4Q3hQV2w4Q0F6?=
 =?utf-8?B?cm0veXN0SGhkRTZyOVZ0dGVlbkJqWXB5KzgvMHNQUm1raldmYW1aNE5PQXNr?=
 =?utf-8?B?THJZYTJyR2RsMUFuSlJEK3ZjR2tJclBxMXhwL0JFNzRCTDlITHFhMUJqK3dO?=
 =?utf-8?B?OG83WnlHM1drR2FRTzBEeVdKY05CYnh3UmNrNVVhLzMxQVJFeEJhc01sS2hv?=
 =?utf-8?B?WnVkQmZJSmRsUnhUdjk3V3poVHhtV2haNGJweVorMFF0U2x3YVp0enNHbDN0?=
 =?utf-8?B?S1BGbXFLQWV1K3JpRWpZUGFIemk1RWNiVzBHRUhtT29melFLelhUSzZKOXl0?=
 =?utf-8?B?TVo4YncxS1M0T0cxVjV6MEFpMDV3aDFqSytpcEFQKzVFb2ljY05sOVp6Q1JV?=
 =?utf-8?B?RGtVdGVaRXVaV1VBVWwwTUszK0xlQUQxTnpqaE9VdVNVdUU1Vkg2ckNRY1JR?=
 =?utf-8?B?VityMXpBQ1dhZVJJMldJZCtVVGVOanV2RGI4aHVLc2lVRjhuQ1RLbFVWczNC?=
 =?utf-8?B?bGlkYzFEK1Mrc002QWovQjBXdlRSTFhYNXNEdWpxNlNqN0gyaHZQQnhEZXk0?=
 =?utf-8?B?L0ptdFFLS3Q2Q1NlM3Zhc1BNV2I1K3JxVnVGZ05Sc3pOUHN5NSsreExKTzBY?=
 =?utf-8?B?OXU3M3Y5Q1kwd2V1UWgxbWJKZXhEMXI4NDVqWVJqWDgyb05lc2o4bExVKytj?=
 =?utf-8?B?NlU0cWhuRUxIZGJXaGZBWW9YN2VoOVR0OXVMZ3A0T05xd091ZzBGRndPRy8y?=
 =?utf-8?B?dEhwZ3pvZGtmbklpNFFPejZQRlpEK0NBOWx1ckt5aVZUSDBiMnYzZ1hkOElU?=
 =?utf-8?B?Qy92Ykg0V3lvR2FaaWMvUndnWEtpT1RWamcybUp1RHVIZnVMT0hlSkxobTUy?=
 =?utf-8?B?VzFLaVVjY0k5RUcwdUlXZjdwaFZOSTlEQUhxWmE4UFhNU1dwaFBVd0VQMFFE?=
 =?utf-8?B?c2dESHNYbXFJbTAvMUVUQTB0Vm1td09QUXh5S2twNkR3SG1vbFk3QS8wRnR5?=
 =?utf-8?B?dFlVQzgrNjdQVjNFdG5nMndubVVLZ0o5dFZtdGU4UmppemYrZldNRGVZa3I4?=
 =?utf-8?B?ZjVxMWhqazNDWkp0MWlxZjZGTDJuSlR0SXMrYnJnaVFoVDZmSXZHdlBDQU14?=
 =?utf-8?B?d29qd2YvMnYrUXJQSHdSUmVQdTJLQlo4WFNyTjR3UXZBbVZ1K3FlcGdqN0pn?=
 =?utf-8?B?d0N1TnNpYkV5VkhpaHJnN09wUHFSMHlTYWVzajVjYjJ2b1dBbTZXTkhUaUNt?=
 =?utf-8?B?RjJWTUFHQmNYQ3JaZ2xWdEJtWUoyTWRaeTNkZEM3V09VSi9POWR1UDJOOHFD?=
 =?utf-8?B?SGE1YVlTRGNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE2F8617B673234C8736D92941F91D00@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454c82f9-2fb2-499f-092b-08da0610f4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 23:18:32.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbxw+qFElsNnXLHtFmJhkeVgpVAjOl07jIuDVKUfBiTn8BUjb381KdKBpEKjPV4P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4253
X-Proofpoint-GUID: AxjZmJfO2791dxfG8vlu-pSCctxZzmva
X-Proofpoint-ORIG-GUID: AxjZmJfO2791dxfG8vlu-pSCctxZzmva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_14,2022-03-14_02,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzLCBBbmRyaWkhIFRoZSBuaXRzL3JlZmFjdG9ycyBhcmUgc3RyYWlnaHRmb3J3YXJkIGJ1
dCBoYXZlIHNvbWUgcXVlc3Rpb25zDQpiZWxvdzoNCg0KT24gRnJpLCAyMDIyLTAzLTExIGF0IDE1
OjI3IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIC8qIHNhbml0aXplIHZhcmlhYmxlIG5hbWUsIGUuZy4sIGZvciBzdGF0aWMg
dmFycyBpbnNpZGUNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBhIGZ1bmN0aW9uLCBp
dCdzIG5hbWUgaXMgJzxmdW5jdGlvbiBuYW1lPi48dmFyaWFibGUgbmFtZT4nLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAqIHdoaWNoIHdlJ2xsIHR1cm4gaW50byBhICc8ZnVuY3Rpb24g
bmFtZT5fPHZhcmlhYmxlIG5hbWU+Jy4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKi8N
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzYW5pdGl6ZV9pZGVudGlmaWVyKHZhcl9pZGVu
dCArIDEpOw0KPiANCj4gYnR3LCBJIHRoaW5rIHdlIGRvbid0IG5lZWQgc2FuaXRpemF0aW9uIGFu
eW1vcmUuIFdlIG5lZWRlZCBpdCBmb3INCj4gc3RhdGljIHZhcmlhYmxlcyAodGhleSB3b3VsZCBi
ZSBvZiB0aGUgZm9ybSA8ZnVuY19uYW1lPi48dmFyX25hbWU+IGZvcg0KPiBzdGF0aWMgdmFyaWFi
bGVzIGluc2lkZSB0aGUgZnVuY3Rpb25zKSwgYnV0IG5vdyBpdCdzIGp1c3QgdW5uZWNlc3NhcnkN
Cj4gY29tcGxpY2F0aW9uDQoNCkhvdyB3b3VsZCB3ZSBoYW5kbGUgc3RhdGljIHZhcmlhYmxlcyBp
bnNpZGUgZnVuY3Rpb25zIGluIGxpYnJhcmllcyB0aGVuPw0KDQo+IA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHZhcl9pZGVudFswXSA9ICcgJzsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgLyogVGhlIGRhdGFzZWMgbWVtYmVyIGhhcyBLSU5EX1ZBUiBidXQgd2Ugd2Fu
dCB0aGUNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKiB1bmRlcmx5aW5nIHR5cGUgb2Yg
dGhlIHZhcmlhYmxlIChlLmcuIEtJTkRfSU5UKS4NCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB2YXIgPSBidGZfX3R5cGVfYnlfaWQo
YnRmLCB2YXItPnR5cGUpOw0KPiANCj4geW91IG5lZWQgdG8gdXNlIHNraXBfbW9kc19hbmRfdHlw
ZWRlZnMoKSBvciBlcXVpdmFsZW50IHRvIHNraXAgYW55DQo+IGNvbnN0L3ZvbGF0aWxlL3Jlc3Ry
aWN0IG1vZGlmaWVycyBiZWZvcmUgY2hlY2tpbmcgYnRmX2lzX2FycmF5KCkNCg0KR29vZCBjYXRj
aCENCg0KPiANCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgLyogUHJlcGVuZCAq
IHRvIHRoZSBmaWVsZCBuYW1lIHRvIG1ha2UgaXQgYSBwb2ludGVyLiAqLw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHZhcl9pZGVudFswXSA9ICcqJzsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcHJpbnRmKCJcdFx0Iik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgLyogRnVuYyBhbmQgYXJyYXkgbWVtYmVycyByZXF1aXJlIHNwZWNpYWwgaGFuZGxpbmcuDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICogSW5zdGVhZCBvZiBwcm9kdWNpbmcgYHR5cGVu
YW1lICp2YXJgLCB0aGV5IHByb2R1Y2UNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBg
dHlwZW9mKHR5cGVuYW1lKSAqdmFyYC4gVGhpcyBhbGxvd3MgdXMgdG8ga2VlcCBhDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICogc2ltaWxhciBzeW50YXggd2hlcmUgdGhlIGlkZW50aWZp
ZXIgaXMganVzdCBwcmVmaXhlZA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIGJ5ICos
IGFsbG93aW5nIHVzIHRvIGlnbm9yZSBDIGRlY2xhcmF0aW9uIG1pbnV0YWUuDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGJ0
Zl9pc19hcnJheSh2YXIpIHx8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ0Zl9p
c19wdHJfdG9fZnVuY19wcm90byhidGYsIHZhcikpIHsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHByaW50ZigidHlwZW9mKCIpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLyogcHJpbnQgdGhlIHR5cGUgaW5zaWRlIHR5cGVvZigpIHdpdGhvdXQgYSBu
YW1lICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvcHRzLmZpZWxkX25h
bWUgPSAiIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IGJ0Zl9k
dW1wX19lbWl0X3R5cGVfZGVjbChkLCB2YXJfdHlwZV9pZCwgJm9wdHMpOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVycikNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwcmludGYoIikgJXMiLCB2YXJfaWRlbnQpOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
cnIgPSBidGZfZHVtcF9fZW1pdF90eXBlX2RlY2woZCwgdmFyX3R5cGVfaWQsICZvcHRzKTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIpDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoIjtcbiIp
Ow0KPiANCj4gd2UgY2FuIHNpbXBsaWZ5IHRoaXMgYSBiaXQgYXJvdW5kIHZhcl9pZGVudCBhbmQg
dHdvDQo+IGJ0Zl9kdW1wX19lbWl0X3R5cGVfZGVjbCgpIGludm9jYXRpb25zLiBXZSBrbm93IHRo
YXQgd2UgYXJlIGhhbmRsaW5nDQo+ICJub24tdW5pZm9ybSIgQyBzeW50YXggZm9yIGFycmF5IGFu
ZCBmdW5jIHBvaW50ZXIsIHNvIHdlIGRvbid0IG5lZWQgdG8NCj4gdXNlIG9wdHMuZmllbGRfbmFt
ZS4gRG9pbmcgdGhpcyAoc2NoZW1hdGljYWxseSkgc2hvdWxkIHdvcmsgKHRha2luZw0KPiBpbnRv
IGFjY291bnQgbm8gbmVlZCBmb3Igc2FuaXRpemF0aW9uIGFzIHdlbGwpOg0KPiANCj4gaWYgKGJ0
Zl9pc19hcnJheSgpIHx8IGJ0Zl9pc19wdHJfdG9fZnVuY19wcm90bygpKQ0KPiAgICAgcHJpbnRm
KCJ0eXBlb2YoIik7DQo+IGJ0Zl9kdW1wX19lbWl0X3R5cGVfZGVjbCguLi4gLyogb3B0cy5maWVs
ZF9uYW1lIHN0YXlzIE5VTEwgKi8pOw0KPiBwcmludGYoIiAqJXMiLCB2YXJfbmFtZSk7DQo+IA0K
PiBvciBkaWQgSSBtaXNzIHNvbWUgY29ybmVyIGNhc2U/DQoNCllvdSBkaWRuJ3QgY2xvc2UgdGhl
ICJ0eXBlb2YiIDopIA0KDQppZiAoYnRmX2lzX2FycmF5KCkgfHwgYnRmX2lzX3B0cl90b19mdW5j
X3Byb3RvKCkpDQogICAgIHByaW50ZigidHlwZW9mKCIpOw0KYnRmX2R1bXBfX2VtaXRfdHlwZV9k
ZWNsKC4uLiAvKiBvcHRzLmZpZWxkX25hbWUgc3RheXMgTlVMTCAqLyk7DQppZiAoYnRmX2lzX2Fy
cmF5KCkgfHwgYnRmX2lzX3B0cl90b19mdW5jX3Byb3RvKCkpDQogICAgIHByaW50ZigiKSIpOw0K
cHJpbnRmKCIgKiVzIiwgdmFyX25hbWUpOw0KDQpJZiB5b3UgZmVlbCB0aGF0J3MgZWFzaWVyIHRv
IHVuZGVyc3RhbmQsIHN1cmUuIEkgZG9uJ3QgbG92ZSBpdCBidXQgaXQncw0KdW5kZXJzdGFuZGFi
bGUgZW5vdWdoLg0KDQpbLi4uXQ0KDQoNCj4gd2UgZG9uJ3Qga25vdyB0aGUgbmFtZSBvZiB0aGUg
ZmluYWwgb2JqZWN0LCB3aHkgd291bGQgd2UgYWxsb3cgdG8gc2V0DQo+IGFueSBvYmplY3QgbmFt
ZSBhdCBhbGw/DQoNCldlIGRvbid0IHJlYWxseSBjYXJlIGFib3V0IHRoZSBmaW5hbCBvYmplY3Qg
bmFtZSBidXQgd2UgZG8gbmVlZCBhbiBvYmplY3QgbmFtZQ0KZm9yIHRoZSBzdWJza2VsZXRvbi4g
VGhlIHN1YnNrZWxldG9uIHR5cGUgbmFtZSwgaGVhZGVyIGd1YXJkIGV0YyBhbGwgdXNlIGl0Lg0K
V2UgY2FuIHNheSB0aGF0IGl0J3MgYWx3YXlzIHRha2VuIGZyb20gdGhlIGZpbGUgbmFtZSwgYnV0
IGdpdmluZyB0aGUgdXNlciB0aGUNCm9wdGlvbiB0byBvdmVycmlkZSBpdCBmZWVscyByaWdodCwg
Z2l2ZW4gdGhlIHBhcmFsbGVsIHdpdGggc2tlbGV0b25zIChhbmQgd2hhdA0Kd291bGQgd2UgZG8g
aWYgdGhlIGZpbGUgbmFtZSBpcyBhIHBpcGUgZnJvbSBhIHN1YnNoZWxsIGludm9jYXRpb24/KS4N
Cg0KPiA+IA0KPiA+ICsNCj4gPiArICAgICAgIC8qIFRoZSBlbXB0eSBvYmplY3QgbmFtZSBhbGxv
d3MgdXMgdG8gdXNlIGJwZl9tYXBfX25hbWUgYW5kIHByb2R1Y2UNCj4gPiArICAgICAgICAqIEVM
RiBzZWN0aW9uIG5hbWVzIG91dCBvZiBpdC4gKCIuZGF0YSIgaW5zdGVhZCBvZiAib2JqLmRhdGEi
KQ0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBvcHRzLm9iamVjdF9uYW1lID0gIiI7DQo+
IA0KPiB5ZXAsIGxpa2UgdGhpcy4gU28gdGhhdCAibmFtZSIgYXJndW1lbnQgInN1cHBvcnQiIGFi
b3ZlIGlzIGJvZ3VzLA0KPiBsZXQncyByZW1vdmUgaXQNCg0KU2VlIGFib3ZlLCBpdCBjaGFuZ2Vz
IHJlYWwgdGhpbmdzLg0KDQo+IA0KPiA+ICsgICAgICAgb2JqID0gYnBmX29iamVjdF9fb3Blbl9t
ZW0ob2JqX2RhdGEsIGZpbGVfc3osICZvcHRzKTsNCj4gPiArICAgICAgIGlmICghb2JqKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGNoYXIgZXJyX2J1ZlsyNTZdOw0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgbGliYnBmX3N0cmVycm9yKGVycm5vLCBlcnJfYnVmLCBzaXplb2YoZXJyX2J1Zikp
Ow0KPiA+ICsgICAgICAgICAgICAgICBwX2VycigiZmFpbGVkIHRvIG9wZW4gQlBGIG9iamVjdCBm
aWxlOiAlcyIsIGVycl9idWYpOw0KPiA+ICsgICAgICAgICAgICAgICBvYmogPSBOVUxMOw0KPiA+
ICsgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+IA0KPiBb
Li4uXQ0KPiANCj4gPiArICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGxlbjsgaSsrLCB2
YXIrKykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHZhcl90eXBlID0gYnRmX190eXBl
X2J5X2lkKGJ0ZiwgdmFyLT50eXBlKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB2YXJf
bmFtZSA9IGJ0Zl9fbmFtZV9ieV9vZmZzZXQoYnRmLCB2YXJfdHlwZS0+bmFtZV9vZmYpOw0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoYnRmX3Zhcih2YXJfdHlwZSktPmxp
bmthZ2UgPT0gQlRGX1ZBUl9TVEFUSUMpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdmFyX2lk
ZW50WzBdID0gJ1wwJzsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzdHJuY2F0KHZhcl9p
ZGVudCwgdmFyX25hbWUsIHNpemVvZih2YXJfaWRlbnQpIC0gMSk7DQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgc2FuaXRpemVfaWRlbnRpZmllcih2YXJfaWRlbnQpOw0KPiA+ICsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAvKiBOb3RlIHRoYXQgd2UgdXNlIHRoZSBkb3QgcHJlZml4
IGluIC5kYXRhIGFzIHRoZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIGZpZWxkIGFj
Y2VzcyBvcGVyYXRvciBpLmUuIG1hcHMlcyBiZWNvbWVzIG1hcHMuZGF0YQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvZGVnZW4o
IlwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBcblwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHMtPnZhcnNbJTQkZF0ubmFtZSA9IFwiJTEkc1wiOyAgICAgICAgICAg
ICAgXG5cDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzLT52YXJzWyU0JGRd
Lm1hcCA9ICZvYmotPm1hcHMlMyRzOyAgICAgICAgIFxuXA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcy0+dmFyc1slNCRkXS5hZGRyID0gKHZvaWQqKikgJm9iai0+JTIkcy4l
MSRzO1xuXA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICIsIHZhcl9pZGVudCwgaWRlbnQs
IGJwZl9tYXBfX25hbWUobWFwKSwgdmFyX2lkeCk7DQo+IA0KPiBtYXAgcmVmZXJlbmNlIHNob3Vs
ZCBiZSB1c2luZyBpZGVudCwgbm90IGJwZl9tYXBfX25hbWUoKSwgYXMgaXQgcmVmZXJzDQo+IHRv
IGEgZmllbGQuIFRoZSB3YXkgaXQgaXMgbm93IGl0IHNob3VsZG4ndCB3b3JrIGZvciBjdXN0b20N
Cj4gLmRhdGEubXlfc2VjdGlvbiBjYXNlIChkbyB5b3UgaGF2ZSBhIHRlc3QgZm9yIHRoaXM/KSBZ
b3Ugc2hvdWxkbid0DQo+IG5lZWQgYnBmX21hcF9fbmFtZSgpIGhlcmUgYXQgYWxsLg0KDQpHb29k
IGNhdGNoLCBJJ2xsIGFkZCBhIC5kYXRhLmN1c3RvbSB0ZXN0Lg0KDQpbLi4uXQ0KDQo+IA0KPiA+
ICsgICAgICAgICAgICAgICAiICAgICAgICUxJHMgJTIkcyBzdWJza2VsZXRvbiBGSUxFIFtuYW1l
IE9CSkVDVF9OQU1FXVxuIg0KPiANCj4gW25hbWUgT0JKRUNUX05BTUVdIHNob3VsZCBiZSBzdXBw
b3J0ZWQNCg0KTm90IHN1cmUgd2hhdCB5b3UgbWVhbiBieSAic3VwcG9ydGVkIiBoZXJlLg0KDQo+
IA0KPiA+ICAgICAgICAgICAgICAgICAiICAgICAgICUxJHMgJTIkcyBtaW5fY29yZV9idGYgSU5Q
VVQgT1VUUFVUIE9CSkVDVCBbT0JKRUNULi4uXVxuIg0KPiA+ICAgICAgICAgICAgICAgICAiICAg
ICAgICUxJHMgJTIkcyBoZWxwXG4iDQo+ID4gICAgICAgICAgICAgICAgICJcbiINCj4gPiBAQCAt
MTc4OCw2ICsyMjUwLDcgQEAgc3RhdGljIGludCBkb19taW5fY29yZV9idGYoaW50IGFyZ2MsIGNo
YXIgKiphcmd2KQ0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGNtZCBjbWRzW10gPSB7DQo+ID4g
ICAgICAgICB7ICJvYmplY3QiLCAgICAgICAgICAgICBkb19vYmplY3QgfSwNCj4gPiAgICAgICAg
IHsgInNrZWxldG9uIiwgICAgICAgICAgIGRvX3NrZWxldG9uIH0sDQo+ID4gKyAgICAgICB7ICJz
dWJza2VsZXRvbiIsICAgICAgICBkb19zdWJza2VsZXRvbiB9LA0KPiA+ICAgICAgICAgeyAibWlu
X2NvcmVfYnRmIiwgICAgICAgZG9fbWluX2NvcmVfYnRmfSwNCj4gPiAgICAgICAgIHsgImhlbHAi
LCAgICAgICAgICAgICAgIGRvX2hlbHAgfSwNCj4gPiAgICAgICAgIHsgMCB9DQo+ID4gLS0NCj4g
PiAyLjM0LjENCg0KLS0gRGVseWFuDQoNCg==

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF029583821
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 07:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiG1FZ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 01:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1FZ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 01:25:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB604D833
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 22:25:56 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26S183i1009785
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 22:25:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BPrfRgBheASxF9z+NmOfg9Pu0uadicKHzMntewwhNao=;
 b=mVbX1xyMUIB18BPzy5/C0K6bNs39PzDWJy/mZqILnarqE/8GvfnoYKTRHHF6nfhuWnua
 Dcy2z308JXjQiAfpFWnYJxvTWeUxX+A1/4pLBVfjqRPRmxoqozRBCh8u1mGCfTXyq0nh
 /8ojk/gVQn6ZqiNJOofH8NeuCGPT6wEzths= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkfsk151d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 22:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV8SaN0XyzWOREPKZrIAQAVA9lbiWBrhncqeLEB+3u1iTOIxQBOo9uy9H8Me6KpY3M8VPOF/53Kj9vQJVkA6Om29gEZ5JBTIS9i/ETpwWQVjD3iz6LqURzF+jgZbqBHIRIvpVOkIuic9B/YkAbQ3GBugsBnLtAvwfWGmfHSFWmMrB5yLw1dLZ0blLlWC3grvUin5E/9373Vwd4j2cEpXX1Byy/EDLhiLDyfMriuH6AaXwxf7ARRjDTcLJVMGTfHwq4eFLehfO2DKXddoN+z65e6OXV/pZUo0ep2L2geK/w2l88OJ4JhIR465DiLSXgqXGPtKUCbO9HWxsgqzJMm73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPrfRgBheASxF9z+NmOfg9Pu0uadicKHzMntewwhNao=;
 b=AQFkWhTfaTgZX3c1Ev3s+TDCUSYUKnV9SendFdq8z+7Jxu7+yb1BlkkZQ2iGFOXVZILZ37ocBba6PxfAVXvM5PvOM1h3MkEfMQCrIldzGddFeInxjvCfR28EHGCh0AIBPITQA9zPXjVQ/l1xI9sRwgK+I0cvyzUC7EJnutrVSRKZo8jbteXZdR6ljedBNmJVhn+AYhWKYgb8oacnoeVeWeB4A2jTVhNhtAv+ViTfiKVnOA4h4Dipdjmlnof56MBfTyOUlW/QBSkPWed2urzB1MHeFSkwK/wk+RYfFujzA/H0k+KynROzlQaloewVzYWj2Upt8/TCnhXasegtMqVY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM5PR15MB1129.namprd15.prod.outlook.com (2603:10b6:3:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 05:25:52 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 05:25:52 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "memxor@gmail.com" <memxor@gmail.com>
CC:     "brauner@kernel.org" <brauner@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYoK8StG1Y6n29KUSEV/VSsAjsP62QkM6AgAE54wCAABc7AIABYbAA
Date:   Thu, 28 Jul 2022 05:25:52 +0000
Message-ID: <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
References: <20220726051713.840431-1-kuifeng@fb.com>
         <20220726051713.840431-2-kuifeng@fb.com> <Yt/aXYiVmGKP282Q@krava>
         <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
         <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
In-Reply-To: <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b30e1df-3939-49ef-02c3-08da7059a3ac
x-ms-traffictypediagnostic: DM5PR15MB1129:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1NJF2KEoKMk+bND8Vdyqpv9WP0g3mE3aoJhtNhwP0X0B9Nv2Am0YU2hWy3AarHp//QNNZawMdWYEKxKbhNhTp+4OwQFX1ODU9LL08gEc1lECktrBFEsmW8Aj9c4/r1fbxxLIMjATNju19Hcw0SS/hucKlhjIPJQk5XkAdM92k+k74y+ErJJfolYb8BQ5YBCi/79phxsLFwJtHcLltMWSD/O1+CWn89ETfQS8eJOCM9kM3jqHsi1N3xQZd5Wvzwwl1SbrMgs2hKCWdMjJpfroCeoCXp+g1qsgLtHXVCGfaSY3kwCRrPXRTz4q7hSZuhP+6+m4b5x9zYBX/nbEtLV3eUMs69iwm0554EbnnbHgZOZNhWzVzG9pl5K1K46LHWSPGMrZH1dXAP1ggFYOsoTHc3Z5OtiusBc5ooWVtPhDmsNt3gGbWgPxWQ53i9TzWfPH4iBxFpRegYfqqA+zL5ps7ZWmInDZgGDyQ3rKJ6/2lBWn5keoaFNTQNEGNB/8YlgwivU7zQgUDXHxTSeGCVsYx9aFujSBPTfwYPyn+lk5tU5COQzJtefSt12AUHlESQ8NvST/KBdA0uLDwk/pzR+JDemW19JNgR+GN8PwvFRaIRcpCATb6g0n/aUA4RbR+S+BSVrLZ814qEUWJzDhZlWCaRyIhm9w+n4fz+RJ/I/6pD735LI/MG/2QoiXkfDY1TFEpVCt8uUbdeX33hIL8khabi+8v9dakdcwAUGy759KYUgUeG7s8EnSD33jwInggtAwPsTFCa2bwAa4wWik5PFot8PLRqU8Wiukjv6lDe0U7KoFhzvwLRelwPa/8KwU7YXR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(6512007)(478600001)(6916009)(41300700001)(6506007)(6486002)(54906003)(71200400001)(86362001)(316002)(38070700005)(38100700002)(122000001)(91956017)(66446008)(186003)(83380400001)(5660300002)(36756003)(66556008)(4326008)(66476007)(8936002)(66946007)(76116006)(8676002)(2616005)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmdYb3RkYmR5emdLSkhYUWVNSDVWYlJjbDBOTFlFRmVzSVpNTzFwQmJLZk1W?=
 =?utf-8?B?NkpYZW50aHltR0c4bVNDdWlNcWNkQVhsVWw1VjlCbUI3Ni9wTGJkMXh1cENx?=
 =?utf-8?B?Y1lHTE0yNnpuWXgreEoxU2Y2TTNqR2h4amJxOG5VdE93VkdRaUtKY2dHaFZ6?=
 =?utf-8?B?dyszZjZqRU9YdFJHZS8zYVdURjJQbmdMYmRpYVBqazdjZUsvdXlMcW9RREQ1?=
 =?utf-8?B?QmUrOHROUEhVZWJ3WmVlWGY3cnRqcG0rc1haYkQ0QTZFWTdjK2ZFL3UvdVd6?=
 =?utf-8?B?Y3JVdE04cjFZOGozc0pNWWE3T1o1N242WDhqTmFQRzI2dlQycXlYZ1J2Uk9R?=
 =?utf-8?B?R1R1L0t5Y1RMeE0xa1poY0ZiaG5HK2FyLzIyL2ZJSlpYSmlaQXhNWmJySlRp?=
 =?utf-8?B?TldvTGRBdno5RC9JaWMwRjBSQjZjTHJ0bTNLTEhWdURVaFo3RjA4c2JCd0Ir?=
 =?utf-8?B?OStOMk9YbkZjWUNJcUVnL05VandZbU9GY3hQc0NZYTZmSW1FdmVoYmdqZitK?=
 =?utf-8?B?OGNRZjBNMGhQcE5MZjZ1VVZDalVGNEF0NU84RVNFNzhUS3Zac3NscGFYRkJl?=
 =?utf-8?B?WnZaZy9iZXNHZUtuZEtld2F1ZmQ3bStkK1FEVzJ5K3J2VVZnVWJ5TUdNa1N4?=
 =?utf-8?B?UnB3QjJ0alBRL2p4eThlRStLODlEemNMNlRpMkNVenJjdk1BM0RtbHpVeEJn?=
 =?utf-8?B?UjVDbWEvOTFRMmNiZVAydEdiV0JRTUlZQ3VPYXB5VEFvcFZuSWlTZFIrN24r?=
 =?utf-8?B?VkpMbjZ5V0VTQzhHL2E1RlM5RW52QitBSGlYRytoZ2srM21iZkMvM2JwMGRC?=
 =?utf-8?B?ejluQmFSTWVMNXA5K1l0cERwUzFiRkthVHZ1Z3BlaFpxMXJFWmo2ZzE2Zk9y?=
 =?utf-8?B?YzBvRkpGQlVMd1lnVmRsYXlQbDdrNEpGNzMwTFk3RnpmUkY3c0dnekJzbHN4?=
 =?utf-8?B?Sk9NNUtKWDFmbFBQNm1lNktpa2lmbmxoeVZSRkdoNXBhMlp1Z2hVeW1RYUlQ?=
 =?utf-8?B?UnhWdHNZMXBDVGVueVJybDdTZkc2a3JUT3c4Y2RMTlhhbWFuRENMSERvclhM?=
 =?utf-8?B?NmRKNjRpbG9WaVU4bkVpd3FOVXRET0hpa1J5M01EV1ViQllUN2dqb1dQYWpp?=
 =?utf-8?B?QW1peUprZVR2ejBFZUVpczk1bk5seHU2eHdKTkNZUEFMTldYcWc0WW1kVlZF?=
 =?utf-8?B?NlY1SC84Rnpqb1RJUzEvUlBjTWFVSG5BZkN6MEFnMGlKRkxFMk9IYksvWURr?=
 =?utf-8?B?RXhPM1BSOFAyY2dFNGYrY24rcTFoRmNTWEorNXBETlJJRFN4d3V0bDJnOXR6?=
 =?utf-8?B?U1JvRDhNNkdTNzAwbUxrRkRCa1A4cjBGWXkzdUFhMUd0eEFSby9DSEYrMXB4?=
 =?utf-8?B?M1l5TzdFOTRZdEdNQ2dlaSt1US93OW1rMXQyM0UrNWtFVGkzd09oQmZUUTZW?=
 =?utf-8?B?aWVYZGJDWWRobTJsQ2I4NVBwdUVlODc5OVptMjJxMWxJL0tRNC9NanBqdWhV?=
 =?utf-8?B?VWNoUWJ2cktJdUlaenNZZTIvcWF3UU0wcEtlY2hkT1dQUnQ4VngzQ2tFODVW?=
 =?utf-8?B?ZzhlbElpWnN4eFVMS0dqZ3d3dUE2bGw3M0VoOW14ZG1nbGtYMzBiaXFpWm0v?=
 =?utf-8?B?Vm51YzhScUZhTnJUMEp5R0xaUnN3RE1aTHBWMHhoRlRoTnNGL0Jtc0FJWS8y?=
 =?utf-8?B?WldNOHB1dkdhdFBoRjZjLzZIbytBVkJmVDB6a2ZsWTJhSFRPS1NvYjJIZzBj?=
 =?utf-8?B?WTI3WlkrZktaTDFlZ3NYS2ppa1NNVko5UnRwcjk3N2ZqNy9zZi9sZThxcGox?=
 =?utf-8?B?dzFpUlhlVUxCZmhjaGt3ODU3NzJzWHJhTUpIRDNYUjBVWHA0K0wxZ2w4UjBJ?=
 =?utf-8?B?bUR1UTJ3T2M2SWUwRG5ZbDJnbDhKV3RSSGZYNjJkSExZWHBNMFl5dzlqQWpE?=
 =?utf-8?B?TGUwNTlMRnJWVmJlNUxqbjhqbG5aUERlbkNYbHlCQnBsclZjc0RGVXFVNlRU?=
 =?utf-8?B?VnNOL2swYzVXdXVxMThpVFBxNXZ6M0dxcDBnTHRITE0vS3Z1Y1IwbHBIWGI1?=
 =?utf-8?B?Q0d1RllIV1FFVkdTQzBKbTZXNHB1c0pXRFZ4RjNQbEFFamVZUWZib08vdWRH?=
 =?utf-8?B?SVZwL3lhU25uY1hOWGo5T1BiQzMxWFprOUQ3Z1RsS1h1NHcwUkxDVFBYclIx?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A94C3199BC6AF94D8ED335508D4356BA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b30e1df-3939-49ef-02c3-08da7059a3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 05:25:52.6393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: piuw9uHRYCPqUEYSzvmA26nhL935uuPG6g1V0FD1XERWN0hDI1zlaYgVSJfKLZET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1129
X-Proofpoint-GUID: v4Q_yuBzGJV7G91MxmOItsZCBoKP4YbJ
X-Proofpoint-ORIG-GUID: v4Q_yuBzGJV7G91MxmOItsZCBoKP4YbJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTA3LTI3IGF0IDEwOjE5ICswMjAwLCBLdW1hciBLYXJ0aWtleWEgRHdpdmVk
aSB3cm90ZToNCj4gT24gV2VkLCAyNyBKdWwgMjAyMiBhdCAwOTowMSwgS3VpLUZlbmcgTGVlIDxr
dWlmZW5nQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDIyLTA3LTI2IGF0IDE0
OjEzICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+ID4gPiBPbiBNb24sIEp1bCAyNSwgMjAyMiBh
dCAxMDoxNzoxMVBNIC0wNzAwLCBLdWktRmVuZyBMZWUgd3JvdGU6DQo+ID4gPiA+IEFsbG93IGNy
ZWF0aW5nIGFuIGl0ZXJhdG9yIHRoYXQgbG9vcHMgdGhyb3VnaCByZXNvdXJjZXMgb2Ygb25lDQo+
ID4gPiA+IHRhc2svdGhyZWFkLg0KPiA+ID4gPiANCj4gPiA+ID4gUGVvcGxlIGNvdWxkIG9ubHkg
Y3JlYXRlIGl0ZXJhdG9ycyB0byBsb29wIHRocm91Z2ggYWxsDQo+ID4gPiA+IHJlc291cmNlcyBv
Zg0KPiA+ID4gPiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0aG91
Z2ggdGhleSB3ZXJlDQo+ID4gPiA+IGludGVyZXN0ZWQNCj4gPiA+ID4gaW4gb25seSB0aGUgcmVz
b3VyY2VzIG9mIGEgc3BlY2lmaWMgdGFzayBvciBwcm9jZXNzLsKgIFBhc3NpbmcNCj4gPiA+ID4g
dGhlDQo+ID4gPiA+IGFkZGl0aW9uYWwgcGFyYW1ldGVycywgcGVvcGxlIGNhbiBub3cgY3JlYXRl
IGFuIGl0ZXJhdG9yIHRvIGdvDQo+ID4gPiA+IHRocm91Z2ggYWxsIHJlc291cmNlcyBvciBvbmx5
IHRoZSByZXNvdXJjZXMgb2YgYSB0YXNrLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKg
aW5jbHVkZS9saW51eC9icGYuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKysNCj4gPiA+
ID4gwqBpbmNsdWRlL3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqAgfCAyMyArKysrKysrKysr
DQo+ID4gPiA+IMKga2VybmVsL2JwZi90YXNrX2l0ZXIuY8KgwqDCoMKgwqDCoMKgwqAgfCA4MSAr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiAtLS0tDQo+ID4gPiA+IC0tLS0NCj4g
PiA+ID4gwqB0b29scy9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmggfCAyMyArKysrKysrKysrDQo+
ID4gPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25z
KC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9icGYuaCBi
L2luY2x1ZGUvbGludXgvYnBmLmgNCj4gPiA+ID4gaW5kZXggMTE5NTAwMjkyODRmLi5jOGQxNjQ0
MDRlMjAgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBmLmgNCj4gPiA+ID4g
KysrIGIvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+ID4gPiBAQCAtMTcxOCw2ICsxNzE4LDEwIEBA
IGludCBicGZfb2JqX2dldF91c2VyKGNvbnN0IGNoYXIgX191c2VyDQo+ID4gPiA+ICpwYXRobmFt
ZSwgaW50IGZsYWdzKTsNCj4gPiA+ID4gDQo+ID4gPiA+IMKgc3RydWN0IGJwZl9pdGVyX2F1eF9p
bmZvIHsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJwZl9tYXAgKm1hcDsNCj4gPiA+
ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qgew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBfX3UzMsKgwqAgdGlkOw0KPiA+ID4gDQo+ID4gPiBzaG91bGQgYmUganVzdCB1MzIg
Pw0KPiA+IA0KPiA+IE9yLCBzaG91bGQgY2hhbmdlIHRoZSBmb2xsb3dpbmcgJ3R5cGUnIHRvIF9f
dTg/DQo+IA0KPiBXb3VsZCBpdCBiZSBiZXR0ZXIgdG8gdXNlIGEgcGlkZmQgaW5zdGVhZCBvZiBh
IHRpZCBoZXJlPyBVbnNldCBwaWRmZA0KPiB3b3VsZCBtZWFuIGdvaW5nIG92ZXIgYWxsIHRhc2tz
LCBhbmQgYW55IGZkID4gMCBpbXBsaWVzIGF0dGFjaGluZyB0bw0KPiBhDQo+IHNwZWNpZmljIHRh
c2sgKGFzIGlzIHRoZSBjb252ZW50aW9uIGluIEJQRiBsYW5kKS4gTW9zdCBvZiB0aGUgbmV3DQo+
IFVBUElzIHdvcmtpbmcgb24gcHJvY2Vzc2VzIGFyZSB1c2luZyBwaWRmZHMgKHRvIHdvcmsgd2l0
aCBhIHN0YWJsZQ0KPiBoYW5kbGUgaW5zdGVhZCBvZiBhIHJldXNhYmxlIElEKS4NCj4gVGhlIGl0
ZXJhdG9yIHRha2luZyBhbiBmZCBhbHNvIGdpdmVzIGFuIG9wcG9ydHVuaXR5IHRvIEJQRiBMU01z
IHRvDQo+IGF0dGFjaCBwZXJtaXNzaW9ucy9wb2xpY2llcyB0byBpdCAob25jZSB3ZSBoYXZlIGEg
ZmlsZSBsb2NhbCBzdG9yYWdlDQo+IG1hcCkgZS5nLiB3aGV0aGVyIGNyZWF0aW5nIGEgdGFzayBp
dGVyYXRvciBmb3IgdGhhdCBzcGVjaWZpYyBwaWRmZA0KPiBpbnN0YW5jZSAoYmFja2VkIGJ5IHRo
ZSBzdHJ1Y3QgZmlsZSkgd291bGQgYmUgYWxsb3dlZCBvciBub3QuDQo+IFlvdSBhcmUgdXNpbmcg
Z2V0cGlkIGluIHRoZSBzZWxmdGVzdCBhbmQga2VlcGluZyB0cmFjayBvZiBsYXN0X3RnaWQNCj4g
aW4NCj4gdGhlIGl0ZXJhdG9yLCBzbyBJIGd1ZXNzIHlvdSBkb24ndCBldmVuIG5lZWQgdG8gZXh0
ZW5kIHBpZGZkX29wZW4gdG8NCj4gd29yayBvbiB0aHJlYWQgSURzIHJpZ2h0IG5vdyBmb3IgeW91
ciB1c2UgY2FzZSAoYW5kIGZkdGFibGUgYW5kIG1tDQo+IGFyZQ0KPiBzaGFyZWQgZm9yIFBPU0lY
IHRocmVhZHMgYW55d2F5LCBzbyBmb3IgdGhvc2UgdHdvIGl0IHdvbid0IG1ha2UgYQ0KPiBkaWZm
ZXJlbmNlKS4NCj4gDQo+IFdoYXQgaXMgeW91ciBvcGluaW9uPw0KDQpEbyB5b3UgbWVhbiByZW1v
dmVkIGJvdGggdGlkIGFuZCB0eXBlLCBhbmQgcmVwbGFjZSB0aGVtIHdpdGggYSBwaWRmZD8NCldl
IGNhbiBkbyB0aGF0IGluIHVhcGksIHN0cnVjdCBicGZfbGlua19pbmZvLiAgQnV0LCB0aGUgaW50
ZXJhbCB0eXBlcywNCmV4LiBicGZfaXRlcl9hdXhfaW5mbywgc3RpbGwgbmVlZCB0byB1c2UgdGlk
IG9yIHN0cnVjdCBmaWxlIHRvIGF2b2lkDQpnZXR0aW5nIGZpbGUgZnJvbSB0aGUgcGVyLXByb2Nl
c3MgZmR0YWJsZS4gIElzIHRoYXQgd2hhdCB5b3UgbWVhbj8NCg0K

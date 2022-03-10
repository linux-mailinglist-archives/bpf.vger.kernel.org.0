Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB954D3DE5
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 01:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiCJAKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 19:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiCJAKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 19:10:46 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC09BAF5
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 16:09:46 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 229Mw0Wf005090
        for <bpf@vger.kernel.org>; Wed, 9 Mar 2022 16:09:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Mn4P3pxP8xzfc456+uMgZkIIM/uhI8yg+1tMa3Vgv4g=;
 b=n9PfHQv7fJH5bNALTiuJ7TE3TBFlQCLvtVRN65AJ2S8PXidXK9uo7I7oSjfVE8dSeSQn
 XQmNOe/wJc9a0O0w5m45mWPugn3Z9XGihxIGR6tVyk2b8EzbXsyl0pUdwjslaynA9orC
 d/mORHJaAbStYsTOdCY/kxRpeHT/3thVrd4= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ep4b2wq3r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 16:09:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMgRl/X+aob2FfJ9bIUFqhgmNHyWhRtfksYhy+s8Ef1lOl3ly3tKJmKW8iV8yp/jiBReyPa44xS+21iesGczYAdzflZkfrfIXbLveR0aG8/JMkZlFXZMcRHowi6Zecvhq3+r9+HB5e606Rt7ZMcYQOSvQVS9snZHDjTK5ekQ2iBrXA/rQW115VRh3l/woDGxg/ih3UnQXtK1Oe7g+G3tLpTl0jzxXnQTdbzUlnYR/DjyQDtiYVMTYsZLpH7LHHEND4FvFwsJJXLDKxTXU3wbEEJiKCqsQJDeeckCgGXewlk/+oZqH8I9a+rNgNMIVPK0j9SEQdTRxNfRc8+VjHDLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn4P3pxP8xzfc456+uMgZkIIM/uhI8yg+1tMa3Vgv4g=;
 b=T5pmRcX7LJr0aSszT+NFJBk6o2Rvey+7HGdXlEH1hxQq0K1o9j0VBlBP/b4+P7GXhEpUZ+rKbwhbZQrmAdaPVR/pZ+ufDLYUpBI71kiZ1mG0ZxNKopitIArKHS0nTAaxxdyJpYXphg3Tz0dNlNow0Fe7F5LEytOd99iDdyP4njwiUUJbP3LkDuRrAdzi53Y1jXu7ZIJdneyTjtwmi93d8YNDrplLPx8e7YEHFUBcwL0O3B9DcKoULYs4PVzLu57zq+j9whw/xzc9fOvYzVh5Ej64EWT67VXJoyklp38IGV87j/2p7m1YnFVO0EpVkfZZ988Ygv2puUaaXCdPAopv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MN2PR15MB2605.namprd15.prod.outlook.com (2603:10b6:208:126::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Thu, 10 Mar
 2022 00:09:42 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%7]) with mapi id 15.20.5038.026; Thu, 10 Mar 2022
 00:09:42 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
Thread-Topic: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
Thread-Index: AQHYLeAOF8q5RjwbxUKWJ0TpgoNb3ays5SuAgAEewYCAAZyeAIAIKJeA
Date:   Thu, 10 Mar 2022 00:09:42 +0000
Message-ID: <8d80bcf5802fc707e0f8a31812625d717f133300.camel@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
         <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
         <CAEf4BzZzAToLHESKrddn2y1FoLHHUVGzJe7=1ih0E3EA7BBdHg@mail.gmail.com>
         <9028e60f908d30d5f156064cebfd5af8d66c5c9c.camel@fb.com>
         <CAEf4BzbuQ+7vkKw0ozkwX7E1D7ygfTbyhaUMJitxTgiYq9y7Fg@mail.gmail.com>
In-Reply-To: <CAEf4BzbuQ+7vkKw0ozkwX7E1D7ygfTbyhaUMJitxTgiYq9y7Fg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 088525f4-d4f5-49c9-8101-08da022a46a1
x-ms-traffictypediagnostic: MN2PR15MB2605:EE_
x-microsoft-antispam-prvs: <MN2PR15MB26051B01C18923AEDEA0B71DC10B9@MN2PR15MB2605.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOvFyAElq2xuSz5BoOriMyPsqyAnDUunNqQfQUOQBqetoERKILXaCESHdhfOcB15oRwXuxxgcgpNWgBxjuIjpJJSEZSuuhqRKn3diWYTgWL3++no2AEzF/xz2m98zmU0WRRO16DW2ghJjPzi31+343dW9cgJTVOj5H86E3Zd4DDVW53jY0SHg3q7XNdsLlZoU0VnoD7YnBgc7DU8Vb8/z8R5oQS0s45unVzXq1lLYXdPRvfeBaxwpOde3Xw+3PSp1fEDjr3IO16FkPmjO/Nyuq5eWwWoZZqFVCbsvYgfNkxCGuuoO6w/JtbDD/zOgDgn9wbeUwfxKsaTy7grEgSpN5Tzz4BALyJ7OcvAC3OKNrgkm9w6m6KgF57JGtJIdZdwGA9MWtht3XSN87Tc6L2u9fk7eBdRrUMeod25h36tX1Bcmzg/62+QaGXZhq8kHoaKteeGROqYM6gdXrsX1GWN1NGVWflenAhDTJD26Jrvb+OcHhFiddNkOspPh+wb11UxvEnKUjMCIRRe/n2vMtgT1uwaFx1v3rqXJ81FE+DyY9XnAAjdpGvLF5j+uP26RGRGhhhkbK3MCBQUkZrXp9hLnxlKPl0EY93NkJeiOTtLaHV1QXL5gQ7p8MA/lkZXZNfnMHgqXt6MN4o1uhQVfGf4Py8O8vKXRLj5iNlPkeQWLzC/3gCwtsFL2aogAbHj7VRWFD8ETaIFm2sQ6nB3uwpXfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(86362001)(64756008)(6506007)(26005)(66946007)(66476007)(66556008)(83380400001)(122000001)(71200400001)(4326008)(8676002)(5660300002)(6486002)(38100700002)(8936002)(2906002)(76116006)(2616005)(6916009)(66446008)(36756003)(508600001)(6512007)(38070700005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjRjZURhV3dUbGc0THIxcnMvaVoveFVSYUxYSElhcm5OV1VWQjdlMjVETElY?=
 =?utf-8?B?Wm1XcCtSL0F2c2NJanVaQUpya3hxSGhtOUlTQzZGclQzcFdTTmpwUkxoNVBF?=
 =?utf-8?B?bitHTVFwbGI3elJ3WU1kbE1tT1FiZGtLNWlCakNEWjd3VHRoSWI4NUlWcWxr?=
 =?utf-8?B?eTlwd3ZLWFRzU1hTSktrSVJ3cTROcURTV0xzb3BrcnJWR01JUVk0dkhEb29a?=
 =?utf-8?B?SHRKMkFTNWNXeVZKMXVYejdtblhGMGlEU2RFd0Z1bjlxRXFOL2tDTHlkMUZQ?=
 =?utf-8?B?aU03MTFURStFcWg1NUxHRURHaGQ4WDJJcm9odXBWZGoxV2ZsSkFMYUNFRDRo?=
 =?utf-8?B?SndZdWM3dGNxdGh4STdSY2ZtQVdMVkpJS2ptdFowU0x0aGFZSm1XbFNJcGVM?=
 =?utf-8?B?dkxZdTdyZnEyQUZhVTBLS0JGeWdrZTR1RWZibFd6bmZrNEV4NklrWUdscFZv?=
 =?utf-8?B?LzlxbnVTaTRuRTBMMnBhbXhoTlhMMEpoZDdFZlBrRjYxVUErUFBzUEtZTU5t?=
 =?utf-8?B?eHZ1R2RSc05rendIdlNiYldtbGxOMjQrTlA3ZXE5QkRWK0JadGQ4SkdWbjlx?=
 =?utf-8?B?NW1JenN4TXhLcXlFeXUwd3R2MEpJMWpKelIvOWZtcE93UWdkT3ZtR2JNNXN4?=
 =?utf-8?B?K1I5UmlwM3hzbnFZc0owQXBUZVB5dGVEK05aL3N1S1JoeExOSjNGKzVHTzNv?=
 =?utf-8?B?YkZUekU2YnkwV242WkJFZTc1UlRTdzNzZEdDclZCNXFBaVFqZW9xNVZWaVp0?=
 =?utf-8?B?RTg5bFJObHNZeE1WOU83ZzZRODltbDd0ODBMOEdydVR1aTVqc0hTWDliNXdM?=
 =?utf-8?B?UjB3b3pTdG45cmoyeTd5VHlnUmdBSWg5SHRLY0c4Sm1ZbFJFcHhWL3M5bTNh?=
 =?utf-8?B?U0w2b01vZ2tSd2d6dDNpNnZDeFFlME5NbGZuVGVGOWNQVnNqSTF5UzhyZnlh?=
 =?utf-8?B?ZFNNU3Q4MkdpWkdYVFk1a1dHM1c0L29RRUNtZ1lud2d0Ymp5OGhWK3FaaFRa?=
 =?utf-8?B?aDhkLzRIUjd1dmdjZERHQi9sK2UrNHR2ZmdKQllQWUY1YmFWWUZKSXQwZUpm?=
 =?utf-8?B?MUpkVW1SYTBEcHVtLzYvYUJKMVcvNEEvaGJVT3VrQkhtL01sU3IyRklWSjlr?=
 =?utf-8?B?dHQ0UlN4Tno3Yi95WlNwQUxXRXpwTGlHVEZMR2xpc3Nyd05rUEpURWtVZXhk?=
 =?utf-8?B?ZS9Ca0FQbHZ1TkNzd3h0MnpMcWkrUks4NFh1SVpyKzVzakFzcVRPakhpUVEy?=
 =?utf-8?B?Q2M5TU53QWxOWVRlZHlRZUVFMFdBWFJkOC9SUUcvQmZYSGoyeEN6ajlOdFNn?=
 =?utf-8?B?WlREQ0ZjNmdoOEVXM0pVTStwMWkxNTV5dDJFZzlmRFkvdFlseWwzckNpU2Ez?=
 =?utf-8?B?ZzJJSHpyL2lOUFNTaWd1OUhVZjZHN1lDWnlyNkg3YWJYQTZtUGtycjBQZ0po?=
 =?utf-8?B?aDk3NXB1em5xeDYrdUhQbElNSVBXRmdmREViTEZScVNhaVFhVEEyb2RoWVFv?=
 =?utf-8?B?c3AxcVdybUFrait0MHkrU2xOaW1VY1Rhb0Y2WkxSWWNjRDkvZ29zc3VyOXkr?=
 =?utf-8?B?cFc5dUp2L2xIQTlGNEVOWFVITXZYeFFIUHppRUwreU9aclNVYVRkdTNpZ1dh?=
 =?utf-8?B?OHViZ0FkOUY2WlcvVGluQUMxNklhdkNBUFFYckdrUFY4QVlpYkE0L0VVZG1z?=
 =?utf-8?B?a1J3QTZBam5oemJYZnYrUHZFOE92djRueFdWMW5veHEyRkp1dmhyVDdSSlFy?=
 =?utf-8?B?T25LN0JDWDJ5dzY2UXRrNE9aTFdPZElFY0p5OGsvN2RyWHd2dmlTSkhoL2R3?=
 =?utf-8?B?OTJNajcyc2NPK2x4QnFPcGZZMlp5T3Vaa1crVFIzWXRXNlRhOUVvZG03TEhN?=
 =?utf-8?B?cFZwT1RaRzJYNWFFMW1LMFhMYWR4eldKWGdvS0xQYzduZDA2M211aDFQTEFJ?=
 =?utf-8?B?dXFqVldxZlcxSWlwdnU3VEJ0MVZVWVRRRkFrUXUrVnRkZUVmOTNWT3hucmRQ?=
 =?utf-8?B?SzZKQk1PakFBM3UraHVPU1ZISVc1cjQxR2tsVVlZaWFmR2tISHNVWklHRHJZ?=
 =?utf-8?B?d3U4NTU5OERUMjhIc2JUVmlocUxqbEdlQkh5bW0razNZWDVYUitOZ2JCV2dM?=
 =?utf-8?Q?KOug=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E4AD4523383AC4D808DDB19FA5FD34C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088525f4-d4f5-49c9-8101-08da022a46a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 00:09:42.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2w4QzLaOaVNJPGDZfd4eRlgEtRZRV8aLcGIlIp5kEpXZL2YxjlYm1BB6GkSO4u4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2605
X-Proofpoint-ORIG-GUID: 8z7m_c5OXDE7Ef7JlQG4wBUxREUMlpLX
X-Proofpoint-GUID: 8z7m_c5OXDE7Ef7JlQG4wBUxREUMlpLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_10,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

U29ycnksIG1pc3NlZCB0aGlzIHF1ZXN0aW9uIG9yaWdpbmFsbHkuDQoNCk9uIEZyaSwgMjAyMi0w
My0wNCBhdCAxMToyOSAtMDgwMCwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiBTcGxpdCBCVEYg
YWRkZWQgb24gdG9wIG1ha2VzIGl0IGEgYml0IG1vcmUNCj4gdG9sZXJhYmxlICh0aG91Z2ggdGhl
cmUgaXMgc3RpbGwgYSBidW5jaCBvZiB1bm5lY2Vzc2FyeSBjb21wbGV4aXR5IGFuZA0KPiBvdmVy
aGVhZCBqdXN0IGZvciB0aGF0IHBlc2t5IGFzdGVyaXNrKS4NCj4gDQo+IEFub3RoZXIgYWx0ZXJu
YXRpdmUgd291bGQgYmU6DQo+IA0KPiB0eXBlb2YoY2hhclsxMjNdKSAqbXlfcHRyOw0KPiANCj4g
VGhpcyBjYW4gYmUgZG9uZSB3aXRob3V0IGdlbmVyYXRpbmcgZXh0cmEgQlRGLiBGb3IgY29tcGxl
eCB0eXBlcyBpdCdzDQo+IGFjdHVhbGx5IGV2ZW4gZWFzaWVyIHRvIHBhcnNlLCB0YmguIEkgaW5p
dGlhbGx5IGRpZG4ndCBsaWtlIGl0LCBidXQNCj4gbm93IEknbSB0aGlua2luZyBtYXliZSBmb3Ig
YXJyYXlzIGFuZCBmdW5jX3Byb3RvcyB3ZSBzaG91bGQgZG8ganVzdA0KPiB0aGlzPyBXRFlUPw0K
DQp0eXBlb2YgaXMgX3RlY2huaWNhbGx5XyBub3Qgc3RhbmRhcmQgQyAoSSB0aGluayBpdCdsbCBt
YWtlIGl0IGludG8gQzIzKS4gR0NDIGFuZA0KQ2xhbmcgZG8gYm90aCBzdXBwb3J0IGl0IGJ1dCBJ
IHdvdWxkIGd1ZXNzIHdlJ2Qgd2FudCB0aGUgZ2VuZXJhdGVkIHVzZXJzcGFjZQ0KY29kZSB0byBi
ZSBjb21wYXRpYmxlIHdpdGggYXMgbWFueSB0b29sY2hhaW5zIGFuZCBjb25maWd1cmF0aW9ucyBh
cyBwb3NzaWJsZT8NCihlLmcuIHBlb3BsZSB1c2luZyBjOTkgaW5zdGVhZCBvZiBnbnU5OSkNCg0K
QmV5b25kIHRoYXQsIEkgZmVlbCB0aGF0IGFueSBjb21wbGV4aXR5IHNhdmVkIGJ5IHRoZSB0eXBl
b2YgaXMgbG9zdCBpbiBzcGVjaWFsLQ0KY2FzaW5nIGFycmF5cyBhbmQgZnVuY3Rpb24gcHJvdG90
eXBlcyB3aGVuIHRoZSBjdXJyZW50IGNvZGUgaXMgdW5pZm9ybSBhY3Jvc3MNCmFsbCB0eXBlcy4N
Cg0KSWYgeW91IGluc2lzdCwgSSBjYW4gZ28gZG93biB0aGlzIHBhdGggYnV0IEknbSBub3Qgc3Vw
ZXIgZW50aHVzaWFzdGljIGFib3V0IGl0DQooYW5kIGl0J3MgaGFyZGVyIHRvIHJlYWQgb24gdG9w
IG9mIGV2ZXJ5dGhpbmcpLg0KDQotLSBEZWx5YW4NCg==

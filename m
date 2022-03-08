Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBEA4D1F1B
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 18:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbiCHRaE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 12:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCHRaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 12:30:04 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6654FA1
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 09:29:06 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228GgoW9013134
        for <bpf@vger.kernel.org>; Tue, 8 Mar 2022 09:29:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Mhju2TOWw3ztakpORY8dpxDHiMAIHFpmoiSXPIHh2j0=;
 b=CQBbeZxUQZn/qG6wONkULWBylXI5QQwOWFVLsIm8vyjLiYxitxCgWrB4l+bMo3ahb0IU
 jowIt2ZmKVz0vE5qdVvs1i/SEGd6pz9TnlTbScXXXYoq9hm1nr4uODjkq1yGeeOdihYv
 aARVwy+C7hljWsUaDJQwgcpRIdZDjj5yJxM= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3emr97r400-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 09:29:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqpomAG54NkWLWHu1Iz3tgUqb+EWEzmyW2GKLMo+FJkOQajRLGiyTDUUCK6/0HQOeVJMAnC+SYWL6j2g2XC/1kr2K3Mm2QCpUjy5clbgQrX35LTE/tUVf5RHkt/Dl+FhFT9E4JviO36Z6maD9mZ2pzHwq2+HaRk8fL4Kuyka3R7aIViEZSFuo5LCr9GEsMIaBGNxcdB/20H9i8wV/vP9bABMDyILtmsfK7ybSPX8DJrD1Aj19P1/0sEcp3Lz/NcHwjCqodNlxv5YGIPYMzEAk215GyrGApSXtns10TbyKs1tvSLzDVGtPDNWTUKOdOY7v36FdddcGhzsyTwH5UI3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mhju2TOWw3ztakpORY8dpxDHiMAIHFpmoiSXPIHh2j0=;
 b=KJQ2/zaMQpniwkbD6y1tq5J2HoYJXjex6MtqEhpCVtUybxZ2Hc1x2NvXLa6lLqqcaoutx0b7DF6mgvlmRP5E/D94/7lGwF83g7HyR/b0xiNZdX5DZT1RJyNH9wWOoNYEy8v2iHPmJrrDOXVz8n/qdQPfiY55TsrBcwL8saTHhgksvEaVcM/tRnAM75HMYFbpWr9CnC/77PIEGFIyB3eMR4dvFhr2JRogWN0VJ94WArQvyfKqk32cpts7HMcN0rtW9p7yp0KFGHPkSADSR926LXIPoe5RQYqbMivtr+0bZZZu9+HZlq3rBY4jVi/kwPsFZiCDNiwO2mYjWY8zWaVaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by SA1PR15MB5140.namprd15.prod.outlook.com (2603:10b6:806:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 17:29:02 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:29:02 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     Mykola Lysenko <mykolal@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Topic: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Index: AQHYLnxiZfEZocnpPEGc3tnOIrk6Fayty+SAgAAfmoCAADLEgIAHqMYA
Date:   Tue, 8 Mar 2022 17:29:02 +0000
Message-ID: <20935470-ECF3-4D64-A31C-7F02433D9FE1@fb.com>
References: <20220302212735.3412041-1-mykolal@fb.com>
 <8bb551bc-c687-04fe-d588-6beb1495f01d@iogearbox.net>
 <2DDD6C41-0584-44F5-8D85-4460EDFB2C40@fb.com>
 <e0f14903-9212-606c-bff2-29232b51ee1c@fb.com>
In-Reply-To: <e0f14903-9212-606c-bff2-29232b51ee1c@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f84bbff1-e5bf-485e-52a0-08da0129238e
x-ms-traffictypediagnostic: SA1PR15MB5140:EE_
x-microsoft-antispam-prvs: <SA1PR15MB5140D926A44BD484F042EAEFC0099@SA1PR15MB5140.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OXy9BqupBwUPHZa/S/4m6IasHlJffX52NIJ1TSzNy4Du5MOPyRNqewXABNchW/Mqn/zvpyB+eM2+ECTG+FAO4cohvrfeNoVMrZv+wQ1hA00Ij8ybQLJ+mVe69nZlt0wWzfl9pGc/Ogmd9u5+JINAl3z2Z7nqAiTxt2SJJSYVGEhdUcFl2ZpuTq7xJNLPwY3zwfisDBHvx5htRA4u0zR9Eu5HpF8nQZOXfPqM5i6n6l4iawRTmiyhURHt5AojyL/IEBKcKI4a9cU42Qs63x3wuGiTEjM+rB2JeO1DJ2wRvTFjJhCp1ufbNBdu7SWuMBEpTvnarfntegmxb7en8LmqHsfXQRUeMt6YS42tJ32gW2Aw6luNYUqJ+K84z1zPyHZPRJpR9iceKPL6mlwA+Yfq169Em/djLLud0PMA4a1aPYfoeJnPr9Gp+haRTLRwOvUUWVsHRA0ivPafOOFFgcE4dPm4PKmEDx/oY4alrcF7a3Y23+7PelAPnQJhQFzz9WP9B4DTnTFShW1JJHIcXTmz3akxLkU6xO8TkzFcFVk3FBTe8SZilP3ZR9mRqTOFfGWVyDrVxLd7pqSGZYaWus8mgqyhpKdIPYZ5ROlF5uTH1oL05ndbTfS+r1tCwhxVbudxHor5bZOThCmqEAL9sKg00rgn+/vuQR1EoPRht6i5zuQV38Km/3UWchJwnxdkDudGqzA80MBVTn90x6R9FERdIw1lVlbkPino/O7Oc8wLUzrx1qZo7tId/GRU5smDjVR3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(186003)(6512007)(5660300002)(6506007)(2906002)(83380400001)(53546011)(2616005)(33656002)(71200400001)(38070700005)(316002)(508600001)(8936002)(6486002)(66556008)(122000001)(54906003)(66946007)(38100700002)(6636002)(66446008)(76116006)(64756008)(66476007)(37006003)(86362001)(6862004)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEJLdXFHVDdPNDFTb2NRSmVoSWlSbnNXRFE5djJxMHY4Vm9UeTlJbVBvb0hs?=
 =?utf-8?B?RHBNK0R0dlg0Qk4rbkI4eE9EZlg3L1FZRENBb2dna1kzTW9HYi9LQUpLdkJu?=
 =?utf-8?B?VHc0bHpYS2FoL2xqT3NxbGRlK3RGS3ZFLzloUGUxUmhjaDNtd0w2WXhBODFW?=
 =?utf-8?B?L0FraFhWTGw0ODczNkNpNlpZQ1ZMRFY0RmdZeEt3SkxvREhkRHFVbW5RNHl3?=
 =?utf-8?B?NmxZRnltRDNOU2VaeUozMGhkem5sTjY2V0YveEI2K1dWRnVGa0dmSjdkT1VL?=
 =?utf-8?B?aEdVRDIxbWVUb0hKcXhMdXNMNDdUUjBKbXdUNVBxK1dEQTJTQjJ1MmVhd1VS?=
 =?utf-8?B?a0pISTJ6RmJIYjdiY0tjYWVnTFprSWxIT1B3QjF2NUp1TmkzRElycm9pVmR3?=
 =?utf-8?B?S1RmYmdkbVlkYzV0ZXM5bXV4WHhZZnVQaXFkbTdXZVRsOUZyK0RkRUMrb3BZ?=
 =?utf-8?B?S3J6ME9aNlhabXp3YU81N2xsYndaN24xdGdtVjNCNlBoRkhobzZHenhrSUxN?=
 =?utf-8?B?dG45MmFvSGVSaWRDdTVtNWxOekYvdkU2L21GWFRlT1VQMWFtR1VwakdHaXI3?=
 =?utf-8?B?YVhBc3hPYlVvVE9JRmpEN0JSa29zaVQvWmQ1SjgrUGdyRzhhdmVLYVp1eExR?=
 =?utf-8?B?SGZwdlBjeXdJUFZid0VZOTVuWUM3Z1ptL2tZaHRSenhHOWwvcE1DaENSbzd0?=
 =?utf-8?B?M3pFYVcyN1JvZzlycnA1Nkh4cFBCRlQwWXpzVWZ1SGFjQW5nVSt3MU5oUXZW?=
 =?utf-8?B?M1pGKzBxcFFvbXVPNlZub3JKanV3SElwd3VTNVhMRHVSNWIyNThEUkZodFVV?=
 =?utf-8?B?THYvVzIzTGhPVGVaS0RJamp0aStMeUpoMzBob0cxS1ZPYk1MZU1ZbE5hZU4x?=
 =?utf-8?B?akUySFgwUWVYTkJYbDYwNmVOMTlyTmZKL2NHOVpoWG4rdkJYYjNnSW1uKzg4?=
 =?utf-8?B?TElvRjYwYitYMFlxN2cwMXRsNzBsTkdoRTNWME9FUjRBbk1lMnNEeVlyMHpH?=
 =?utf-8?B?cG9oVEpTTWl5U3FoSVlGN0txQ2IwSkRaSHpNaUlqd2dLUlRXQVVROW9zTUpl?=
 =?utf-8?B?WVc4OWp1dmlwc1dEZlFmc2dCNkx1RHpHQ256SmFjbldtRUkvalc1Z0UzTGpz?=
 =?utf-8?B?NVNyTWZtQWxsTGV0NmJqaWhScytRWGplbXdEcGFKMXUwcmZ1N3hSMVRnZ0cz?=
 =?utf-8?B?ellBd29PUDRpWSt6aEZSVzZvdkpuUVFpUGpZNE8rdEsyK1hvY20rSVZKbFlm?=
 =?utf-8?B?TzFKN0ZleGdXTWVBT01MeThVcXU3TVI5cGdjYVZLUWV4V3piQ3hGeS9IelJY?=
 =?utf-8?B?U3c0VU5udWEzUEZpNGh4a2xCUWI5WW5wVTZHTEZmaXRIc3RZcVZVQnFLb1RQ?=
 =?utf-8?B?dUQycVQ1M0FRakZDc3Z6dEJoQ0VjdU94RVdoWEhQMjcwclNuZDVaQVM4Qk9C?=
 =?utf-8?B?WjIzTGZ4MDR4dlNoZ3ExS0FQT3BKTm1JU2FXNFNtdDRhRllWaFFKYjZNQy9L?=
 =?utf-8?B?QTBaRGtPTm9BVkxvVFIvU0JqNWdwYVh3U2VrRk0zeS95SG04M1FqSkRZWUph?=
 =?utf-8?B?MDFEVVNCdzFLbzhQaElkejZ5NkNVMm1ya1BBQnZtSHlTMzdBbFIrWm5PaG5x?=
 =?utf-8?B?NW50MFVsUFZNdEdCNEVRZWlVSmU0YjZxdzYrK0o0K3IvWFhqdnZzZUFQY1NT?=
 =?utf-8?B?N084RjBzNVFXSlRUWDZ2a3d3bWw0WnhXazJUNTRtWGFoMS9YSWZSUUI2d1Va?=
 =?utf-8?B?RG9kQmZDQ0tUd2hLNFE5OE0rQ3p6cjBKbkhpSkhOdnVOQXFNdFlIV3l6dW84?=
 =?utf-8?B?cFY2RlZacmdHZnk2ZUk5N1FsczNtNGYxK0F2bGQyYUFadVg0ZWNFVjROOFN1?=
 =?utf-8?B?VmgzQnJRaWZQbEdVaUVRcTFLQkVlcm4xelFJMGt0YkRQYjY2TVRob3plbGFn?=
 =?utf-8?B?V1BqZ09DOWEzVTQ2RVBSdHRmMlJkNUJoSEJyUDFqWWxRMXEvaEYxL3Jnajda?=
 =?utf-8?B?ak5RK1k4UUpIaGh0S0JrbGdmL3dDQzNobXAzVWtPVkRxSmVBTFBVSFlxYVRi?=
 =?utf-8?B?Y1VheGw2dktTNU5wVHhhaXZPUkRuaFdFclBFRzEzMzNHVTlQUGUwclM0T3RR?=
 =?utf-8?B?S3R4SW5UbGdlZTA2TDV5bVhYQ1EzRlF0aVgyZGg0WW1Qd0hpWGI2RE1VL3pW?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E43044BC579204AAA1C9E7C8AD04CDD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84bbff1-e5bf-485e-52a0-08da0129238e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 17:29:02.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpfdoWlkFCpHmdBxdoeej08OUdbVqFsOilFk7WEDsGoUGkrC9fCYJnfhdBWxEPpp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5140
X-Proofpoint-ORIG-GUID: hEakhPYhgN9w8fEOmpiZQ71oEimBgasB
X-Proofpoint-GUID: hEakhPYhgN9w8fEOmpiZQ71oEimBgasB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_06,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIFlvbmdob25nLA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5IGluIGhlcmUuDQoNCkkgaGF2
ZSBzcGxpdCBjb21taXRzIGludG8gMyBhcyB5b3UgYXNrZWQuIFdpbGwgc2VuZCBpdCBvdXQgc2hv
cnRseS4gSGF2ZSBmZXcgcXVlc3Rpb25zIGJlbG93IHJlOiBmaW5kX3ZtYSB0ZXN0Lg0KDQo+IE9u
IE1hciAzLCAyMDIyLCBhdCAxMjozMSBQTSwgWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4gd3Jv
dGU6DQo+IA0KPiANCj4gDQo+IE9uIDMvMy8yMiA5OjI5IEFNLCBNeWtvbGEgTHlzZW5rbyB3cm90
ZToNCj4+PiBPbiBNYXIgMywgMjAyMiwgYXQgNzozNiBBTSwgRGFuaWVsIEJvcmttYW5uIDxkYW5p
ZWxAaW9nZWFyYm94Lm5ldD4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gMy8yLzIyIDEwOjI3IFBNLCBN
eWtvbGEgTHlzZW5rbyB3cm90ZToNCj4+Pj4gSW4gc2VuZF9zaWduYWwsIHJlcGxhY2Ugc2xlZXAg
d2l0aCBkdW1teSBjcHUgaW50ZW5zaXZlIGNvbXB1dGF0aW9uDQo+Pj4+IHRvIGluY3JlYXNlIHBy
b2JhYmlsaXR5IG9mIGNoaWxkIHByb2Nlc3MgYmVpbmcgc2NoZWR1bGVkLiBBZGQgZmV3DQo+Pj4+
IG1vcmUgYXNzZXJ0cy4NCj4+Pj4gSW4gZmluZF92bWEsIHJlZHVjZSBzYW1wbGVfZnJlcSBhcyBo
aWdoZXIgdmFsdWVzIG1heSBiZSByZWplY3RlZCBpbg0KPj4+PiBzb21lIHFlbXUgc2V0dXBzLCBy
ZW1vdmUgdXNsZWVwIGFuZCBpbmNyZWFzZSBsZW5ndGggb2YgY3B1IGludGVuc2l2ZQ0KPj4+PiBj
b21wdXRhdGlvbi4NCj4+Pj4gSW4gYnBmX2Nvb2tpZSwgcGVyZl9saW5rIGFuZCBwZXJmX2JyYW5j
aGVzLCByZWR1Y2Ugc2FtcGxlX2ZyZXEgYXMNCj4+Pj4gaGlnaGVyIHZhbHVlcyBtYXkgYmUgcmVq
ZWN0ZWQgaW4gc29tZSBxZW11IHNldHVwcw0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBNeWtvbGEgTHlz
ZW5rbyA8bXlrb2xhbEBmYi5jb20+DQo+Pj4+IEFja2VkLWJ5OiBZb25naG9uZyBTb25nIDx5aHNA
ZmIuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvYnBm
X2Nvb2tpZS5jICAgICAgIHwgIDIgKy0NCj4+Pj4gIC4uLi90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYv
cHJvZ190ZXN0cy9maW5kX3ZtYS5jIHwgMTMgKysrKysrKysrKy0tLQ0KPj4+PiAgLi4uL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy9wZXJmX2JyYW5jaGVzLmMgICAgfCAgNCArKy0tDQo+Pj4+ICAu
Li4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3BlcmZfbGluay5jICAgICAgICB8ICAyICstDQo+
Pj4+ICAuLi4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3NlbmRfc2lnbmFsLmMgICAgICB8IDE3
ICsrKysrKysrKystLS0tLS0tDQo+Pj4+ICAuLi4vc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3Nl
bmRfc2lnbmFsX2tlcm4uYyB8ICAyICstDQo+Pj4+ICA2IGZpbGVzIGNoYW5nZWQsIDI1IGluc2Vy
dGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4+PiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvYnBmX2Nvb2tpZS5jIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvYnBmX2Nvb2tpZS5jDQo+Pj4+IGluZGV4IGNkMTBkZjZj
ZDBmYy4uMDYxMmU3OWE5MjgxIDEwMDY0NA0KPj4+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy9icGZfY29va2llLmMNCj4+Pj4gKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvYnBmX2Nvb2tpZS5jDQo+Pj4+IEBAIC0xOTksNyAr
MTk5LDcgQEAgc3RhdGljIHZvaWQgcGVfc3VidGVzdChzdHJ1Y3QgdGVzdF9icGZfY29va2llICpz
a2VsKQ0KPj4+PiAgCWF0dHIudHlwZSA9IFBFUkZfVFlQRV9TT0ZUV0FSRTsNCj4+Pj4gIAlhdHRy
LmNvbmZpZyA9IFBFUkZfQ09VTlRfU1dfQ1BVX0NMT0NLOw0KPj4+PiAgCWF0dHIuZnJlcSA9IDE7
DQo+Pj4+IC0JYXR0ci5zYW1wbGVfZnJlcSA9IDQwMDA7DQo+Pj4+ICsJYXR0ci5zYW1wbGVfZnJl
cSA9IDEwMDA7DQo+Pj4+ICAJcGZkID0gc3lzY2FsbChfX05SX3BlcmZfZXZlbnRfb3BlbiwgJmF0
dHIsIC0xLCAwLCAtMSwgUEVSRl9GTEFHX0ZEX0NMT0VYRUMpOw0KPj4+PiAgCWlmICghQVNTRVJU
X0dFKHBmZCwgMCwgInBlcmZfZmQiKSkNCj4+Pj4gIAkJZ290byBjbGVhbnVwOw0KPj4+PiBkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvZmluZF92bWEu
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2ZpbmRfdm1hLmMNCj4+
Pj4gaW5kZXggYjc0YjNjMGM1NTVhLi43Y2Y0ZmViNjQ2NGMgMTAwNjQ0DQo+Pj4+IC0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2ZpbmRfdm1hLmMNCj4+Pj4gKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvZmluZF92bWEuYw0KPj4+
PiBAQCAtMzAsMTIgKzMwLDIwIEBAIHN0YXRpYyBpbnQgb3Blbl9wZSh2b2lkKQ0KPj4+PiAgCWF0
dHIudHlwZSA9IFBFUkZfVFlQRV9IQVJEV0FSRTsNCj4+Pj4gIAlhdHRyLmNvbmZpZyA9IFBFUkZf
Q09VTlRfSFdfQ1BVX0NZQ0xFUzsNCj4+Pj4gIAlhdHRyLmZyZXEgPSAxOw0KPj4+PiAtCWF0dHIu
c2FtcGxlX2ZyZXEgPSA0MDAwOw0KPj4+PiArCWF0dHIuc2FtcGxlX2ZyZXEgPSAxMDAwOw0KPj4+
PiAgCXBmZCA9IHN5c2NhbGwoX19OUl9wZXJmX2V2ZW50X29wZW4sICZhdHRyLCAwLCAtMSwgLTEs
IFBFUkZfRkxBR19GRF9DTE9FWEVDKTsNCj4+Pj4gICAgCXJldHVybiBwZmQgPj0gMCA/IHBmZCA6
IC1lcnJubzsNCj4+Pj4gIH0NCj4+Pj4gICtzdGF0aWMgYm9vbCBmaW5kX3ZtYV9wZV9jb25kaXRp
b24oc3RydWN0IGZpbmRfdm1hICpza2VsKQ0KPj4+PiArew0KPj4+PiArCXJldHVybiBza2VsLT5i
c3MtPmZvdW5kX3ZtX2V4ZWMgPT0gMCB8fA0KPj4+PiArCQlza2VsLT5kYXRhLT5maW5kX2FkZHJf
cmV0ICE9IDAgfHwNCj4+PiANCj4+PiBTaG91bGQgdGhpcyBub3QgdGVzdCBmb3IgYHNrZWwtPmRh
dGEtPmZpbmRfYWRkcl9yZXQgPT0gLTFgID8NCj4+IEl0IHNlZW1zIHRoYXQgZmluZF9hZGRyX3Jl
dCBjaGFuZ2VzIHZhbHVlIGZldyB0aW1lcyB1bnRpbCBpdCBnZXRzIHRvIDAuIEkgYWRkZWQgcHJp
bnQgc3RhdGVtZW50cyB3aGVuIHZhbHVlIGlzIGNoYW5nZWQ6DQo+PiBmaW5kX2FkZHJfcmV0IC0x
ID0+IGluaXRpYWwgdmFsdWUNCj4+IGZpbmRfYWRkcl9yZXQgLTE2ID0+IC1FQlVTWQ0KPj4gZmlu
ZF9hZGRyX3JldCAwID0+IGZpbmFsIHZhbHVlDQo+PiBIZW5jZSwgaW4gdGhpcyBjYXNlIEkgdGhp
bmsgaXQgaXMgYmV0dGVyIHRvIHdhaXQgZm9yIHRoZSBmaW5hbCB2YWx1ZS4gV2UgZG8gaGF2ZSB0
aW1lIG91dCBpbiB0aGUgbG9vcCBhbnl3YXlzICh3aGVuIOKAnGkiIHJlYWNoZXMgMWJuKSwgc28g
dGVzdCB3b3VsZCBub3QgZ2V0IHN0dWNrLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgYWJvdmUgaW5m
b3JtYXRpb24uIEkgcmVhZCB0aGUgY29kZSBhZ2Fpbi4gSSB0aGluayBpdCBpcyBtb3JlIGNvbXBs
aWNhdGVkIHRoYW4gYWJvdmUuIExldCB1cyBsb29rIGF0IHRoZSBicGYgcHJvZ3JhbToNCj4gDQo+
IFNFQygicGVyZl9ldmVudCIpDQo+IGludCBoYW5kbGVfcGUodm9pZCkNCj4gew0KPiAgICAgICAg
c3RydWN0IHRhc2tfc3RydWN0ICp0YXNrID0gYnBmX2dldF9jdXJyZW50X3Rhc2tfYnRmKCk7DQo+
ICAgICAgICBzdHJ1Y3QgY2FsbGJhY2tfY3R4IGRhdGEgPSB7fTsNCj4gDQo+ICAgICAgICBpZiAo
dGFzay0+cGlkICE9IHRhcmdldF9waWQpDQo+ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiAN
Cj4gICAgICAgIGZpbmRfYWRkcl9yZXQgPSBicGZfZmluZF92bWEodGFzaywgYWRkciwgY2hlY2tf
dm1hLCAmZGF0YSwgMCk7DQo+IA0KPiAgICAgICAgLyogSW4gTk1JLCB0aGlzIHNob3VsZCByZXR1
cm4gLUVCVVNZLCBhcyB0aGUgcHJldmlvdXMgY2FsbCBpcyB1c2luZw0KPiAgICAgICAgICogdGhl
IGlycV93b3JrLg0KPiAgICAgICAgICovDQo+ICAgICAgICBmaW5kX3plcm9fcmV0ID0gYnBmX2Zp
bmRfdm1hKHRhc2ssIDAsIGNoZWNrX3ZtYSwgJmRhdGEsIDApOw0KPiAgICAgICAgcmV0dXJuIDA7
DQo+IH0NCj4gDQo+IEFzc3VtaW5nIHRhc2stPnBpZCA9PSB0YXJnZXRfcGlkLA0KPiB0aGUgZmly
c3QgYnBmIHByb2dyYW0gY2FsbCBzaG91bGQgaGF2ZQ0KPiAgICBmaW5kX2FkZHJfcmV0ID0gMCAg
ICAgLyogbG9jayBpcnFfd29yayAqLw0KPiAgICBmaW5kX3plcm9fcmV0ID0gLUVCVVNZDQo+IA0K
PiBGb3IgdGhlIHNlY29uZCBicGYgcHJvZ3JhbSBjYWxsLCB0aGVyZSBhcmUgdHdvIHBvc3NpYmls
aXRpZXM6DQo+ICAgLiBpcnFfd29yayBpcyB1bmxvY2tlZCwgc28gdGhlIHJlc3VsdCB3aWxsIGZp
bmRfYWRkcl9yZXQgPSAwLCBmaW5kX3plcm9fcmV0ID0gLUVCVVNZDQo+ICAgLiBvciBpcnFfd29y
ayBpcyBzdGlsbCBsb2NrZWQsIHRoZSByZXN1bHQgd2lsbCBiZSBmaW5kX2FkZHJfcmV0ID0gLUVC
VVNZLCBmaW5kX3plcm9fcmV0ID0gLUVCVVNZDQo+IA0KPiB0aGUgdGhpcmQgYnBmIHByb2dyYW0g
Y2FsbCB3aWxsIGJlIHNpbWlsYXIgdG8gdGhlIHNlY29uZCBicGYgcHJvZ3JhbSBydW4uDQo+IA0K
PiBTbyBmaW5hbCB2YWxpZGF0aW9uIGNoZWNrIHByb2JhYmx5IHNob3VsZCBjaGVjayBib3RoIDAg
YW5kIC1FQlVTWQ0KPiBmb3IgZmluZF9hZGRyX3JldC4NCj4gDQoNCkRvIHlvdSBtZWFuIHdlIG5l
ZWQgdG8gYWRkIGFkZGl0aW9uYWwgdGVzdCBpbiB0ZXN0X2FuZF9yZXNldF9za2VsIGZ1bmN0aW9u
IG9yIGluIGZpbmRfdm1hX3BlX2NvbmRpdGlvbj8NCg0KRG8gd2UgcmVhbGx5IG5lZWQgdG8gZG8g
ZmluYWwgY2hlY2sgZm9yIHNrZWwtPmRhdGEtPmZpbmRfYWRkcl9yZXQgaW4gdGVzdF9hbmRfcmVz
ZXRfc2tlbCBpZiB3ZSBhbHJlYWR5IGNvbmZpcm1lZA0KSXQgYmVjYW1lIDAgcHJldmlvdXNseT8N
Cg0KDQo+IExlYXZpbmcgc29tZSB0aW1lIHRvIHBvdGVudGlhbGx5IHVubG9jayB0aGUgaXJxX3dv
cmsgYXMgaW4gdGhlIG9yaWdpbmFsDQo+IGNvZGUgaXMgc3RpbGwgbmVlZGVkIHRvIHByZXZlbnQg
cG90ZW50aWFsIHByb2JsZW0gZm9yIHRoZSBzdWJzZXF1ZW50IHRlc3RzLg0KDQpCeSBsZWF2aW5n
IHNvbWUgdGltZSwgZG8geW91IG1lYW4gdG8gcmV2ZXJ0IHJlbW92YWwgb2YgdGhlIG5leHQgbGlu
ZSBpbiBzZXJpYWxfdGVzdF9maW5kX3ZtYSBmdW5jdGlvbj8NCnVzbGVlcCgxMDAwMDApOyAvKiBh
bGxvdyB0aGUgaXJxX3dvcmsgdG8gZmluaXNoICovDQoNCj4gDQo+IEkgdGhpbmsgdGhpcyBwYXRj
aCBjYW4gYmUgYnJva2UgaW50byB0aHJlZSBzZXBhcmF0ZSBjb21taXRzOg0KPiAgLSBmaW5kX3Zt
YSBmaXgNCj4gIC0gc2VuZF9zaWduYWwgZml4DQo+ICAtIG90aGVyDQo+IHRvIG1ha2UgY2hhbmdl
cyBhIGxpdHRsZSBiaXQgZm9jdXNlZC4NCj4gDQo+PiBUTDpEUiBjaGFuZ2UgaW4gdGhlIHRlc3Qg
dGhhdCBwcmludHMgdGhlc2UgdmFsdWVzDQo+PiAtICAgICAgIGZvciAoaSA9IDA7IGkgPCAxMDAw
MDAwMDAwICYmIGZpbmRfdm1hX3BlX2NvbmRpdGlvbihza2VsKTsgKytpKQ0KPj4gKyAgICAgICBp
bnQgZmluZF9hZGRyX3JldCA9IC0xOw0KPj4gKyAgICAgICBwcmludGYoImZpbmRfYWRkcl9yZXQg
JWRcbiIsIHNrZWwtPmRhdGEtPmZpbmRfYWRkcl9yZXQpOw0KPj4gKw0KPj4gKyAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgMTAwMDAwMDAwMCAmJiBmaW5kX3ZtYV9wZV9jb25kaXRpb24oc2tlbCk7ICsr
aSkgew0KPj4gKyAgICAgICAgICAgICAgIGlmIChmaW5kX2FkZHJfcmV0ICE9IHNrZWwtPmRhdGEt
PmZpbmRfYWRkcl9yZXQpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGZpbmRfYWRkcl9y
ZXQgPSBza2VsLT5kYXRhLT5maW5kX2FkZHJfcmV0Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcHJpbnRmKCJmaW5kX2FkZHJfcmV0ICVkXG4iLCBza2VsLT5kYXRhLT5maW5kX2FkZHJfcmV0
KTsNCj4+ICsgICAgICAgICAgICAgICB9DQo+PiAgICAgICAgICAgICAgICAgKytqOw0KPj4gKyAg
ICAgICB9DQo+PiArDQo+PiArICAgICAgIHByaW50ZigiZmluZF9hZGRyX3JldCAlZFxuIiwgc2tl
bC0+ZGF0YS0+ZmluZF9hZGRyX3JldCk7DQo+Pj4gDQo+Pj4+ICsJCXNrZWwtPmRhdGEtPmZpbmRf
emVyb19yZXQgPT0gLTEgfHwNCj4+Pj4gKwkJc3RyY21wKHNrZWwtPmJzcy0+ZF9pbmFtZSwgInRl
c3RfcHJvZ3MiKSAhPSAwOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4gVGhhbmtzLA0KPj4+IERhbmll
bA0KDQo=

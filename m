Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83D6588074
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiHBQr4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiHBQrz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 12:47:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB16E029
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 09:47:54 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272FdTBo021736
        for <bpf@vger.kernel.org>; Tue, 2 Aug 2022 09:47:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4h+I9Sen0F1A5PrddrlKMC5RF0odNEgiEhtR/p0Fn4g=;
 b=DedNAug7ctAfBa3fGMi7BL0zmxj36rOY/+WmWSchFpuGQWSPrDaPX2mCRzIh7lI8wFAe
 yPr7v1dUSImFyKaCSj++oK3iARUgHzHZqFDVErFIktTc46s9RBAkc1Fz6MHsJfm4ESqh
 7uhq0BFQsepNfed0gGLU94BQeAMp7ok1q1s= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn0pk4kwr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 09:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHhSvGYyvdFuGEH5onvefKmTlHgUTHoaVWr6p4GqI/Gjl1rZrPolUfsQXRkNi7rm+MvAglVRXV1knCNpA0KC6xzJeb03GN5LfCf8ArU9WRatrK9o2v5dCywY+exx2Uc4g6hA1uELap3whnQ7O+UP1QELDLlh40z/kJDO5tNBZMjE7bWy+vIKis0I9DXLxF6Wk7EWv0ViNvMnpeFDPi7gi3twRQkidzFzqVZD+d/pH7KzjHpEcsFb0oWGgeW/Fp6aOmexXUi9/oHyhwTmpLNQlgNBvSKSdO0HKM2llwTZnhUqXnJV5vYAIDCO+qT6NCMtGk+IUTz6axHa2JfvjrOdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h+I9Sen0F1A5PrddrlKMC5RF0odNEgiEhtR/p0Fn4g=;
 b=PvCyMUE1GVafpuFWnnxrGMloUxFx+45fnm6E8Dk3PHOcVZtZPkviD7fiOTvlKnqm/tq1fBNgcM5nKg6urjb0Hx0QsnkNe7tdKUV0db2WC6yYC92uFpXT+yaVWTG3LuF+SFEt02GgRmiPF2GF0BlQv2sNYwDyXduVRKSiA5wwUcO04ukMEVErCaoKyKy8Os9qZavEwhMDH7D2mvWTMItrgUTniC4Nq9WHISBzkivsIXwAEQh0fyYyIb40fxDjNmb2Ze4/5tlEpvdkyuMoPGNoRglFWuVnqfv8zANYHSeNKPqtZ7x3q0xo4hFIIkYYcS87ZOU9cAt35LMOnl6TTm6UZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by CO1PR15MB4825.namprd15.prod.outlook.com (2603:10b6:303:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 16:47:51 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 16:47:51 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v2 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYpf4+00grtixoB0ai67RLDHc1uq2a2EoAgAD67QA=
Date:   Tue, 2 Aug 2022 16:47:51 +0000
Message-ID: <abd48496db08b3f50df163267f37bb96616f355e.camel@fb.com>
References: <20220801232649.2306614-1-kuifeng@fb.com>
         <20220801232649.2306614-2-kuifeng@fb.com>
         <CAADnVQJp3GDjFw9H8nez4z8zSYME3h_fL3cuhiVSOrMc11T5KA@mail.gmail.com>
In-Reply-To: <CAADnVQJp3GDjFw9H8nez4z8zSYME3h_fL3cuhiVSOrMc11T5KA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac4c61fe-a6e7-4627-bb48-08da74a6bd4b
x-ms-traffictypediagnostic: CO1PR15MB4825:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVpX+zfj6VHeCpnFrrOIfMnIIW3aW3nz84yzqauqBGaTcMBO7+VDclR3WgEfgz7o3QnOzwDsbQXbhHZiYmj027iRTIF4x8q7IFZsC+jMMP4nAoPmVUAb8Yqyfv4h+SQsLTagIsqE73796+inQQTsEPurIbu7Z+yewVWNOMDSAW34Jxzr1Z/S1sJCb53kbog2r5DKXkZscvuxMfZ1t1Qod8l/ziCdef/n24bTNqcqOpHs03r5KLrCrdHTyzuPeuLrr8IwMYazlBZlQPTceprdQEnC1ika8n/pApo55Q1rq7j//8ZcnCfXW1Ct0EE8sBium/sCV6lwIg8Y2TP+u+AbGPyvSsD2GyeHf/CjvlOWo9j7y09foh+QdP8zwrwCh3Ved24QCtixq66toXu26KmDxMeYMVqfjXCycVkLMmHRufRo2fyfDwOU2TCg47P5v6DkilKEQMxAr5HAGnWIlWoRwYAP7YC5qf5z3OxknYq3K1NlmRBfdGsf1IUKkBJHoM+YRq+4non7Usvx4+fed1Vou0PBKis5iqW+Jh8Gfk0Ql2uhEU07rYCwzcAX7/ZX475RGXeiY5SDqOSlA2XWDudZkjd/2A6V/o3Tm3VnvZ6hJiv8qwVDETiEYwSwO7EpWHeP7Dn7jbhjHt+3tyAXD1x3IsSsVUMxPRUjo6hur1y9pHybBYD6M+bA46KFF8SgVEr+triK1yZbFkmPVsiOFQjqPCbvXt078bXbOCBkUxSgRpfXE9XFJoiRGm/A4KyMnssXyAxXLldHuJ8//8CGiEdNQoj0a2qabEkimG9+zmY3dh/5RyHC0R5heekswIyUo1b+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(71200400001)(6512007)(2616005)(478600001)(6486002)(186003)(36756003)(86362001)(6916009)(54906003)(316002)(53546011)(2906002)(6506007)(76116006)(122000001)(4326008)(66946007)(66446008)(66476007)(38070700005)(64756008)(66556008)(8676002)(38100700002)(5660300002)(83380400001)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEV3d3hFcDBKUVh0dENZSy9WaHM3TitYMUcwNjd0UlBQWEJwbGJETGhPOG5n?=
 =?utf-8?B?WkM3amQ3cVk1M2RTU3hRSVdUS09FbVIyQzlOTG44dmxDeEJETXh6OUNDWmhG?=
 =?utf-8?B?T2JzS2R0Q05YT0RGV2dwWmZseFc5V0hpNnM5NFhCS1NvVVJoUDNKL1FJMU9K?=
 =?utf-8?B?cXllZmVBbmZleWU2S0FUMHppaGwzaWR5MjYvYTFmUU4yek92K0k3M1JLQlRI?=
 =?utf-8?B?KzQ5bHZJS1EzK3hiTURpRGxac1Uvdk5kK0ROWFQyM0NqZktCcGpNNFIvRGtL?=
 =?utf-8?B?dnBhMFV2SkhMTXZ4cGgyR1FHZTJEa2cydjlUK3JBYmNBeVVobHduNXF1MGxs?=
 =?utf-8?B?TEpVMXBveGh3RiswQm1CZGtiNGRQaUhXY1BRVDRZZk40ZEoyWktyK0pkZkwz?=
 =?utf-8?B?M2QzVEFKTWFpdHBkZ1BIMm4yaExSU0xxSVN3b3ArbFZNWW80bitheXFRbGxB?=
 =?utf-8?B?M3diVzRpeEhkamVTV1QvQzJSNEF0RmhMZFpuc3VORUNNQ2Z3SWd5ZU5QRjRo?=
 =?utf-8?B?cVBZZ0ZtUzZDdHpSVjVab1BwaTNCUEtURys0Vmo3S1FKZTJYNWFwOU9tNE9P?=
 =?utf-8?B?WmRzL2x5cVp1M2JWaGVYc0J5aHBiSnV2anVtQUswRnNUUVN0YjcvVkF0dTY4?=
 =?utf-8?B?c1JZOTlQTWFNbVhXR3k4R0doUzBnV0lMSUdoNjBoWE1lbis1LzMvM2tpSmNs?=
 =?utf-8?B?QVA1VEZONVJaaENUbWdxTkZuK3pBVktja09JemRuWXJYcE92MHRJK20vSDFK?=
 =?utf-8?B?bzgvK3c4WnBxaHY3cytTUXVEVk1iYUpEWkpTd3VISnExcXhJK0IvYW1ZaTlS?=
 =?utf-8?B?cVhNc1l5SEcrUmpoYWNNbWp5U3lhNGlSTjdtZ3BQMG9SZ01Ma2JkSWQ1OHZK?=
 =?utf-8?B?Nm5IUGM5Y0w4V1ZPT2IvajJzQXZZSENKU2JEaXJQeTRkd2c1WjVyanlZM2lu?=
 =?utf-8?B?K1JGSVc3U3hINkVzNFRTc2FsSllIOHphR09nVzFNdmhVQlR2aGJFTkl3SmFk?=
 =?utf-8?B?VnQ1SE1Db1ZGS203N2tzOWw5cGY5U2NWSXFIa1Z5ek5aQkRZMi9TYTdUb0NN?=
 =?utf-8?B?L00vcWtpQklPV3hkOVJXQk5pWmJGS25WQmw2RWRiK09pbTRCYmdZcFdqVVc4?=
 =?utf-8?B?ai9yek80MG9uUHptSnRXMFRaL09tbnlTcWFKMVBhSVZDWmx6MVk3ekhsQXA0?=
 =?utf-8?B?b21TUnRBRXRLVS90Sm5PM3BnaTUyTnIrRlpGNkxmWnRsNkFyVnMyVVNxRTZh?=
 =?utf-8?B?bVo0aDJDK3FwSndmZ2tiRm9CL1p3TTFJd09sMGg4Rml1N1VxM3NJVVpVRmZO?=
 =?utf-8?B?Lzl1anVzdEJuazRRdldIYWlkU0tic0xnZ0xsZ042U016QWQvU08wYXZGUU9C?=
 =?utf-8?B?WWhSOW15V0U1eTZRTVVKQXMwcTg3aEgyc0NvSk5rVnhTRi9hdTRkaHc0SUNX?=
 =?utf-8?B?a1JxSFlmb1FQTG9tVnV4SXpLYW5EcVNveVNERFl1WXhCNWdESm9ybk1FeUU2?=
 =?utf-8?B?T2xPa0lxaTU1cFpuY080VUp6ZGY1VTNBa0xENkZxbjJ3QWp3MnQvWUFjVWFu?=
 =?utf-8?B?WlRySWpWeG45VUpHZXJwelliS1pKTVMvajlXRHNDaXdua29zNHBocklneU9R?=
 =?utf-8?B?dHFqa3pGWjRmVXlaRXRTN0cyZWgxclMwQ2VKSjF3ajhLWWVWTGI2YzdhZHVx?=
 =?utf-8?B?bVRNZ21ZSWxLd3hvblVsZmdmVnB4UjhZcndlUFVoSElqNCtqa0ZOMVdKSmxM?=
 =?utf-8?B?SFk5eEVnUmpsclM1ODdpS3Q5WXZyZVUvSW4weXVVdCtGZFA1emNvQUtIelBw?=
 =?utf-8?B?U2lwYUdsZjdGeDdyUHp3MzN0Q2Z2QXZlS1VoVjk2T1RGQlpEcFJaSlh2WFNQ?=
 =?utf-8?B?ajlnb0NsQklQblAwVjZhSmlLTG45ZWRSVkpYM3pLNWhoUUxLNjVZNWdyRFYy?=
 =?utf-8?B?UWdzUlc0RmowbGtYVjRKTUpXYUhlRFArbXh0ZnhlejV2ellMcVo5VW9CSGlG?=
 =?utf-8?B?OUM1WTNXdXFlTzY3UmE2M0JwR1d3TXdTVzhPVDBOcU5uVU1FWnJRbXNZY25w?=
 =?utf-8?B?a2dseFNFSG4wUThSUHBVV2w5OHdSdDdxSWdGZnJQbEFGeEh4UnFCMjVrL3kz?=
 =?utf-8?B?T05JNVFvMlJ0TDZmY3AwTDZ3M3NlT2dQV3hzeDZ1akJvOFNOU2NZYzJFTlk4?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <546FC4D38454D042A6E5E1B40B2F0BB7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4c61fe-a6e7-4627-bb48-08da74a6bd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 16:47:51.5127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6n2b0hMiON87HD2ZQKhvL0jcnIpQBc30606Iv+3CvkaqpvoWCMYIHbyb8/sbtec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4825
X-Proofpoint-ORIG-GUID: yGCWwEToGY9zPHkFm2zk40IU6hpfdjJw
X-Proofpoint-GUID: yGCWwEToGY9zPHkFm2zk40IU6hpfdjJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_11,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTAxIGF0IDE4OjQ5IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6Cj4gT24gTW9uLCBBdWcgMSwgMjAyMiBhdCA0OjI3IFBNIEt1aS1GZW5nIExlZSA8a3VpZmVu
Z0BmYi5jb20+IHdyb3RlOgo+ID4gCj4gPiBBbGxvdyBjcmVhdGluZyBhbiBpdGVyYXRvciB0aGF0
IGxvb3BzIHRocm91Z2ggcmVzb3VyY2VzIG9mIG9uZQo+ID4gdGFzay90aHJlYWQuCj4gPiAKPiA+
IFBlb3BsZSBjb3VsZCBvbmx5IGNyZWF0ZSBpdGVyYXRvcnMgdG8gbG9vcCB0aHJvdWdoIGFsbCBy
ZXNvdXJjZXMgb2YKPiA+IGZpbGVzLCB2bWEsIGFuZCB0YXNrcyBpbiB0aGUgc3lzdGVtLCBldmVu
IHRob3VnaCB0aGV5IHdlcmUKPiA+IGludGVyZXN0ZWQKPiA+IGluIG9ubHkgdGhlIHJlc291cmNl
cyBvZiBhIHNwZWNpZmljIHRhc2sgb3IgcHJvY2Vzcy7CoCBQYXNzaW5nIHRoZQo+ID4gYWRkaXRp
b25hbCBwYXJhbWV0ZXJzLCBwZW9wbGUgY2FuIG5vdyBjcmVhdGUgYW4gaXRlcmF0b3IgdG8gZ28K
PiA+IHRocm91Z2ggYWxsIHJlc291cmNlcyBvciBvbmx5IHRoZSByZXNvdXJjZXMgb2YgYSB0YXNr
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdWktRmVuZyBMZWUgPGt1aWZlbmdAZmIuY29tPgo+
ID4gLS0tCj4gPiDCoGluY2x1ZGUvbGludXgvYnBmLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCA0ICsrCj4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKgwqDCoCB8IDIzICsr
KysrKysrKwo+ID4gwqBrZXJuZWwvYnBmL3Rhc2tfaXRlci5jwqDCoMKgwqDCoMKgwqDCoCB8IDkz
ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4gLS0tLQo+ID4gwqB0b29scy9pbmNs
dWRlL3VhcGkvbGludXgvYnBmLmggfCAyMyArKysrKysrKysKPiA+IMKgNCBmaWxlcyBjaGFuZ2Vk
LCAxMjEgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIvaW5jbHVkZS9saW51eC9icGYuaAo+ID4gaW5kZXggMTE5
NTAwMjkyODRmLi4zYzI2ZGJmYzljZWYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Jw
Zi5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2JwZi5oCj4gPiBAQCAtMTcxOCw2ICsxNzE4LDEw
IEBAIGludCBicGZfb2JqX2dldF91c2VyKGNvbnN0IGNoYXIgX191c2VyCj4gPiAqcGF0aG5hbWUs
IGludCBmbGFncyk7Cj4gPiAKPiA+IMKgc3RydWN0IGJwZl9pdGVyX2F1eF9pbmZvIHsKPiA+IMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBicGZfbWFwICptYXA7Cj4gPiArwqDCoMKgwqDCoMKgIHN0cnVj
dCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzLCoMKgwqDCoCB0aWQ7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1OMKgwqDCoMKgwqAgdHlwZTsKPiA+ICvC
oMKgwqDCoMKgwqAgfSB0YXNrOwo+ID4gwqB9Owo+ID4gCj4gPiDCoHR5cGVkZWYgaW50ICgqYnBm
X2l0ZXJfYXR0YWNoX3RhcmdldF90KShzdHJ1Y3QgYnBmX3Byb2cgKnByb2csCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5o
Cj4gPiBpbmRleCBmZmNiZjc5YTU1NmIuLmVkNWJhNTAxNjA5ZiAxMDA2NDQKPiA+IC0tLSBhL2lu
Y2x1ZGUvdWFwaS9saW51eC9icGYuaAo+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5o
Cj4gPiBAQCAtODcsMTAgKzg3LDMzIEBAIHN0cnVjdCBicGZfY2dyb3VwX3N0b3JhZ2Vfa2V5IHsK
PiA+IMKgwqDCoMKgwqDCoMKgIF9fdTMywqDCoCBhdHRhY2hfdHlwZTvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIHByb2dyYW0gYXR0YWNoIHR5cGUKPiA+IChlbnVtIGJwZl9hdHRhY2hfdHlwZSkg
Ki8KPiA+IMKgfTsKPiA+IAo+ID4gK2VudW0gYnBmX3Rhc2tfaXRlcl90eXBlIHsKPiA+ICvCoMKg
wqDCoMKgwqAgQlBGX1RBU0tfSVRFUl9BTEwgPSAwLAo+ID4gK8KgwqDCoMKgwqDCoCBCUEZfVEFT
S19JVEVSX1RJRCwKPiA+ICt9Owo+ID4gKwo+ID4gwqB1bmlvbiBicGZfaXRlcl9saW5rX2luZm8g
ewo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBfX3UzMsKgwqAgbWFwX2ZkOwo+ID4gwqDCoMKgwqDCoMKgwqAgfSBtYXA7Cj4gPiAr
wqDCoMKgwqDCoMKgIC8qCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBQYXJhbWV0ZXJzIG9mIHRhc2sg
aXRlcmF0b3JzLgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgIHN0cnVj
dCB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3UzMsKgwqAgcGlkX2ZkOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKiBUaGUgdHlwZSBvZiB0aGUgaXRlcmF0b3IuCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiBJdCBjYW4gYmUgb25lIG9mIGVudW0gYnBmX3Rhc2tfaXRlcl90eXBlLgo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogQlBGX1RBU0tfSVRFUl9BTEwgKGRlZmF1bHQpCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICrCoMKgwqDCoMKgIFRoZSBpdGVyYXRvciBpdGVyYXRlcyBvdmVyIHJl
c291cmNlcyBvZgo+ID4gZXZlcnlwcm9jZXNzLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQlBGX1RBU0tf
SVRFUl9USUQKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKsKgwqDCoMKgwqAg
WW91IHNob3VsZCBhbHNvIHNldCAqcGlkX2ZkKiB0byBpdGVyYXRlCj4gPiBvdmVyIG9uZSB0YXNr
Lgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgX191OMKgwqDCoCB0eXBlO8KgwqAgLyogQlBGX1RBU0tfSVRFUl8q
ICovCj4gCj4gX191OCBtaWdodCBiZSBhIHBhaW4gZm9yIGZ1dHVyZSBleHRlbnNpYmlsaXR5LgoK
RG8geW91IG1lYW4gdGhlIHByb2JsZW0gY2F1c2VkIGJ5IHBhZGRpbmc/Cgo+IGJpZyB2cyBsaXR0
bGUgZW5kaWFuIHdpbGwgYmUgYW5vdGhlciBwb3RlbnRpYWwgaXNzdWUuCgpEbyB3ZSBuZWVkIGJp
bmFyeSBjb21wYXRpYmxlIGZvciBkaWZmZXJlbnQgcGxhdGZvcm1zPwpJIGRvbid0IGdldCB0aGUg
cG9pbnQgb2YgZW5kaWFuLiAgQ291bGQgeW91IGV4cGxhaW4gaXQgbW9yZT8KCj4gCj4gTWF5YmUg
dXNlIGVudW0gYnBmX3Rhc2tfaXRlcl90eXBlIHR5cGU7IGhlcmUgYW5kCj4gbW92ZSB0aGUgY29t
bWVudCB0byBlbnVtIGRlZiA/Cj4gT3IgcmVuYW1lIGl0IHRvICdfX3UzMiBmbGFnczsnID8KCg==

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864045854E6
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiG2SFF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiG2SFD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 14:05:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEF589EAF
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:05:01 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26THA6sH009666
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:05:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5Eu9+iuvYMZKeVPKKY7DgfeKFWJ3m22nQZcrh5AIvII=;
 b=ME42BpxAFEiIZA5FaVMvpsHbGj5P3YC4SnmhhF+UPeM3U1/Zm0AdYkLsincSN1I1VfBp
 2H8sWxlDt9sE1Z2bOZNEvCjQa+zzLL5O/XbZ9zeWtmeQWwDe6IVzmivbGXajimJaYOC7
 RE0ugDEESrdrsJaxqqL6NeVbf6PHSe/xRlM= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hm5smd2qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:05:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5FHpIsMW+OjfLTnAMxSZaj3JqGl1iPlPbYtDypmPgBVoietWAz6UF3PzhWL7PacKz4F+XXLyZ3YW6SOac4uex3il8rzgLlLERW+HCSGrkUoYTI8HL1mC9NuC/cv4xI+Zbr4BjfuHTfwfGJVv9yuzVH/D/XADjo9YtNSZ/MucMjn3PF3K8Leys4n0gq1i1Cx8498xYCtup5/6IOv7RReOvPBzM0qGRIjjBj9XRBx1BbzuwgiZi3I6PFGGKD5lM/55mmXRZNhaBOErbfYVF5g6TDCdTL3VbMA0eJVoHtQCbuZ/TzTxRWVV37EXShMcGjgPmBPbzrgLFsgqAgsOOMLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Eu9+iuvYMZKeVPKKY7DgfeKFWJ3m22nQZcrh5AIvII=;
 b=W7FPJxAfStmIhqfhzwTalT6v0Jyw+Zra8nNEPeGg41bIJjn5r7IA2V4VABZCDc9so+5R2/gFbwGBj6xjf9OkZfMmQXyIqwcNbLlIwyzA4hpIp1uD7+Tv0fLDkRxl8Q0Jzpt1RBZEDKjyFgGYhi/P4lRk4hzizh6aoiI7Z1D2V5ng40OgiKU3QdoKXBMmdr1jNhbIBn9V5DEfUUTuMnRxL+IWE2Ep7SOFWhcVve7Wy2YJyawTSKlKR46i2wzyLsyeCnyZv2fjJz+sc/rXrCKezsu0WPQCDtvcpM66KR4acz+vEVvHhOIn+0Z59Um17PYqSZhWFvVHAgQamrqZ+tSjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM6PR15MB4251.namprd15.prod.outlook.com (2603:10b6:5:172::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 18:04:55 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5482.011; Fri, 29 Jul 2022
 18:04:55 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Thread-Topic: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Thread-Index: AQHYoRLIz41WXjJWD0i8rSCksLxN2q2T8E8AgAAhcQCAACS6gIAAO4OAgAE3RIA=
Date:   Fri, 29 Jul 2022 18:04:55 +0000
Message-ID: <948ca89ada1e14ae21335eb5ded5aef4305fbf58.camel@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
         <aa998af64d0662af4c138175259244640cecfcbf.camel@fb.com>
         <18273e85-4e45-c395-0aa9-a10125d59e50@fb.com>
         <17dbbb831db12049ebfb5161e380c9078fbddad5.camel@fb.com>
         <a31dfd32-3065-1881-e2e2-3c420568232a@fb.com>
In-Reply-To: <a31dfd32-3065-1881-e2e2-3c420568232a@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a34f715f-fb9a-45cc-00f3-08da718cd77e
x-ms-traffictypediagnostic: DM6PR15MB4251:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3xiWlexNjKGI35eGny2athAIaF/FCSpb5AwRZFuTs1W0HemOruuTZtYzvZnV/y/vOET7k9vOaW5ue9GeE/UcugMoMqarJXpAXGCedulCTCJ0MsN6sh4/yEiU/wMvF6FkByDsSBocrfhXpnFy00fkmEkMJhoc39Tj1j+020IzyqohRJJvxEikzuw2wts9V6jj/FX1wsnTHOOdLOF2O+nNc5cMf6q8eRbsea0lhfh65aBVILqPz9K55JySAw6RYOq+xK55wqsq5e+rkOoyhdEi9Dbh0wPJyaF0BLMwu2lWCCVnMv21YtaAseUqgFP1E+Wu/eDVIC3HqXO8qhdmUF6xt/Cus82k5JkGl35I1G/DU2i/z6jlRRTt8cA6Z5+crp6wpIXXKdRm0pLSfNcj1at4YQ/N5f6HHBe86UIbGPano+qWCGm6gNyJHpgsT0QGX5Gu+1UkAFU/WSDrFOa7LuF1BU9GXFKL1WJGtj3IbBeLj0QiJktcK8YmdZhdwXppIWB4MeVauITPLNjsk36PeBcJ1smvglq0HJtA22YIO1nJj5HVKQ66F1QKnwZnsF3Bn0ny+iQQmb7EqRoSkCmsE4h7V8sOmsC1Md1sTdXLHlq3t/jQkL5Ogff3aCZJpj+Km6HBpbH52NNIUcJHqCwH90ooO7lDqlI3TbaEGgps3L1IVeFw4u1niCKrFcMkADhBZ5Fi3a4jenBkbQ4Jz7EAPP9sRyeAQi5n62egb82N2WE+ivpOeDldrUMteQ+uYGex8FnVkv1OyV+jrac/uXZDU0SB25Hpk8Q1ihFpUcPCU8AQYKESmiJcPGLtmoN/K/uvkfGi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(478600001)(38070700005)(8936002)(122000001)(38100700002)(83380400001)(36756003)(2906002)(91956017)(186003)(6512007)(76116006)(71200400001)(41300700001)(54906003)(110136005)(316002)(6486002)(66946007)(66556008)(66476007)(53546011)(2616005)(5660300002)(86362001)(8676002)(6506007)(66446008)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWUwczNUclIxT0J2TnJIK1B4bHlTVjRJNHVPdkdyekFHTUpBZmFkNFhmaDJS?=
 =?utf-8?B?VG52TGVkOUVVWVNtVVNySGFTQnY1SitEWWd5dmtyN3NHMVdSaUt6K2ROT3pB?=
 =?utf-8?B?cjcyeW0ybFZaRHNSZzJIY3V0Q09xeFZVcmdLN0E1bld1L1hjT2xuYW81ODVs?=
 =?utf-8?B?TkkvQ1ZudjRmWnlJYWpPOHYwczFVdUhoM2RLME45b09SSXJiSU10VURMa0kz?=
 =?utf-8?B?TlNOWXZCenUzZ2srNHdGcW9NcW1VaUJ6LzNDSnNwWE44bm1XMFhRTFdielZq?=
 =?utf-8?B?MldUYXpYcWI4RXJKd0w5ODNFVkYvNGNWWENYQm9qblBYSmZiRWpQZ2ZlMnBT?=
 =?utf-8?B?Z20rcHZISUhDR2RPb0pkUDNJaEJGZUxReFhlSDBUZmlZRTEzRXlnd0h5aGpo?=
 =?utf-8?B?ZGpGVWJEcnhvT05EOFFOMlM2M05aVTQwSndlbE9vRy9lcnZSQzdubUNTbitK?=
 =?utf-8?B?aFNLWnM4QWVlem5PZloyWXFGTXJDWlRsbithZHRPWTRHS2V6cm50UVd3bWdF?=
 =?utf-8?B?U1VXRk1IeDJSVEtwU1RoZUZVaU1ZdVhVTndXcU83Nk1RVEFyaUJCa2xzdi9G?=
 =?utf-8?B?REh3KzZhZzJwUk9ubW83RzFzTjJHTy9TSVBDb0JDMHh1SXAzUnZraVE1SnBp?=
 =?utf-8?B?MkdsVlVuQ1VNRUJKK0ErcVhHOTZtVWttK1E3NkR1TnQvL084clhGVGk5aXVv?=
 =?utf-8?B?UFJxRU5QWGpaNlVpd1FKeU5uR3F5WkFjTjI0MENmRC9mWDJmQ3djemdIWHhp?=
 =?utf-8?B?UTl1aklSZS8vN0lEdzR4NThXWHRHMUg5WUFRVVhlODlKdmN0M0tJOHlLQkxG?=
 =?utf-8?B?YWJkUEk1OElUeVg2YmhObkJOOFl3ZGJHTGFjTzRMQjlDN0U2S2VYQVlGVURi?=
 =?utf-8?B?dC9jLzJvT3RsOWUrZTJTV2hBWmwwdkJlMEp6Y0JTMTg4TEluZkpoN21kTEgz?=
 =?utf-8?B?STJvRmlTc2VnSXhNUlJoWndDVVdWLzZPeXk3ZVZIOTY3cWJzQjhDenZqTEEx?=
 =?utf-8?B?TTE2aUtuUlN6N1BTdGs5anFkY0c1amM3TUt3eFN4WFFJZkFFMlJOZkQvSTJR?=
 =?utf-8?B?VlFiUzNodnB0SkRON3RzMWlDUDVKV2VLMmtYNnp0WGhRd3pnbnkzbytmOXNU?=
 =?utf-8?B?dm04WUhWQU5BR29VZk15NS9Obm1Fc0hraS9Dd1MxM2VxcStXL0ZYcFlPb1or?=
 =?utf-8?B?cU45TkVJMEptbDZZNGJaZHBYVEd4cUVHZXZGY0Z2SEk2anZSWUVENVRvWWRv?=
 =?utf-8?B?YVQ2Z2VrYXVyOEpiNE1MWXBHMUw0d1FacWthaDlsNGxHRGd6aGhQcjRKSkpy?=
 =?utf-8?B?bDNNajJUWE55U05BbEEzQmxJaHg3ZW1FTGVrVHJkVzlqNGRmeXRzbkplTHli?=
 =?utf-8?B?UGpzZzNGVXF0cnV1WjNNc0hjbjk3NlJ0WGlPbDJQWkx3d0x3ZlNTZDcrMFpH?=
 =?utf-8?B?SnZmYm1GajN1cVFyaUxXU1E4SS9KM2FwMWxPMlEzOWZjNVpjamlpWmEvRjRt?=
 =?utf-8?B?UzYvVzJPdFUwRWRxVitqa2c2TE5OUUI2ZlUyd0ZCMVl0UU1XRHhjZHlVWVJ2?=
 =?utf-8?B?b1BVNnFoK1pkOTVWay9pYW5ZdWZHZlZVUE5yQWpkcjFZbDFlTnA0YUJWbmtX?=
 =?utf-8?B?OEV3Qjh4U0VpT0VTTm1IaVAvRkdzNUdFSmJrNmM4RGtTeTROcEpRaDNrcVhB?=
 =?utf-8?B?eXZoVVZuSDliT1F4L0tONkNuMzBneDJ6ek00cVQ2eEx1Q3AzRUJpL0pTZFFl?=
 =?utf-8?B?dWRxNVFBbUVjc1lmbU5VRGlrOGJRNzZoRGRPSm5sMDlPWGExT3gyWHg0UXhs?=
 =?utf-8?B?c1I5d3kwb1NIdDBNUFVMY1Z5bWl3SStic1VqZjE2cHpIN0FaUG1ERk04WU9U?=
 =?utf-8?B?RFBVbFVpU21pSXQ1ODQzd3o0MlpVb2xBbDVuRVZFdEQvMk94NmZib05sb3h2?=
 =?utf-8?B?aG9NUnNSNU1RUHB5VFFTMHhHK2doSzkyS3lpOHk2cVJrb2RnZEVFNE90RHpl?=
 =?utf-8?B?WWFkelpZSlc0MDdKZUdWVDRBS1c5eHR3aC9OaGpLRVlwcEhNMnovMHFIRXgr?=
 =?utf-8?B?Rkt5Tm9FLzhCR200YWgyanN5amtDaXJUUVVRWldaYUYwSEFkZHRyeWdoT1Jx?=
 =?utf-8?B?N3Nqc3dCUlhxWDN0UmVUdXgwa1hDZTNRQXBYMlY5WUNzZFRNU1hyQWN4OHIv?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DAD612D7532884F9952E07DE789D555@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34f715f-fb9a-45cc-00f3-08da718cd77e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 18:04:55.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3zcl+8t+y/HZir520o1e5GcgwOXjfmI5/q3/Acv6XSWRoCSCEtsAFCrhdR5Eg4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4251
X-Proofpoint-GUID: 7pvGUoVNg2aKqygNL_DEvCxltX4fqtjP
X-Proofpoint-ORIG-GUID: 7pvGUoVNg2aKqygNL_DEvCxltX4fqtjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-29_19,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTI4IGF0IDE2OjMwIC0wNzAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDcvMjgvMjIgMTI6NTcgUE0sIEt1aS1GZW5nIExlZSB3cm90ZToNCj4gPiBP
biBUaHUsIDIwMjItMDctMjggYXQgMTA6NDYgLTA3MDAsIFlvbmdob25nIFNvbmcgd3JvdGU6DQo+
ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gNy8yOC8yMiA4OjQ2IEFNLCBLdWktRmVuZyBMZWUgd3Jv
dGU6DQo+ID4gPiA+IE9uIFR1ZSwgMjAyMi0wNy0yNiBhdCAxMDoxMSAtMDcwMCwgWW9uZ2hvbmcg
U29uZyB3cm90ZToNCj4gPiA+ID4gPiBDdXJyZW50bHkgc3RydWN0IGFyZ3VtZW50cyBhcmUgbm90
IHN1cHBvcnRlZCBmb3IgdHJhbXBvbGluZQ0KPiA+ID4gPiA+IGJhc2VkDQo+ID4gPiA+ID4gcHJv
Z3MuDQo+ID4gPiA+ID4gT25lIG9mIG1ham9yIHJlYXNvbiBpcyB0aGF0IHN0cnVjdCBhcmd1bWVu
dCBtYXkgcGFzcyBieSB2YWx1ZQ0KPiA+ID4gPiA+IHdoaWNoDQo+ID4gPiA+ID4gbWF5DQo+ID4g
PiA+ID4gdXNlIG1vcmUgdGhhbiBvbmUgcmVnaXN0ZXJzLiBUaGlzIGJyZWFrcyB0cmFtcG9saW5l
IHByb2dzDQo+ID4gPiA+ID4gd2hlcmUNCj4gPiA+ID4gPiBlYWNoIGFyZ3VtZW50IGlzIGFzc3Vt
ZWQgdG8gdGFrZSBvbmUgcmVnaXN0ZXIuIGJjYyBjb21tdW5pdHkNCj4gPiA+ID4gPiByZXBvcnRl
ZA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IGlzc3VlIChbMV0pIHdoZXJlIHN0cnVjdCBhcmd1
bWVudCBpcyBub3Qgc3VwcG9ydGVkIGZvciBmZW50cnkNCj4gPiA+ID4gPiBwcm9ncmFtLg0KPiA+
ID4gPiA+IMKgwqDCoCB0eXBlZGVmIHN0cnVjdCB7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgIHVpZF90IHZhbDsNCj4gPiA+ID4gPiDCoMKgwqAgfSBrdWlkX3Q7DQo+ID4gPiA+ID4gwqDC
oMKgIHR5cGVkZWYgc3RydWN0IHsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgZ2lkX3Qg
dmFsOw0KPiA+ID4gPiA+IMKgwqDCoCB9IGtnaWRfdDsNCj4gPiA+ID4gPiDCoMKgwqAgaW50IHNl
Y3VyaXR5X3BhdGhfY2hvd24oc3RydWN0IHBhdGggKnBhdGgsIGt1aWRfdCB1aWQsDQo+ID4gPiA+
ID4ga2dpZF90DQo+ID4gPiA+ID4gZ2lkKTsNCj4gPiA+ID4gPiBJbnNpZGUgTWV0YSwgd2UgYWxz
byBoYXZlIGEgdXNlIGNhc2UgdG8gYXR0YWNoIHRvDQo+ID4gPiA+ID4gdGNwX3NldHNvY2tvcHQo
KQ0KPiA+ID4gPiA+IMKgwqDCoCB0eXBlZGVmIHN0cnVjdCB7DQo+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgIHVuaW9uIHsNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHZvaWTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICprZXJuZWw7DQo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkIF9fdXNlcsKgwqDCoMKgICp1c2Vy
Ow0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpc19rZXJuZWwgOiAxOw0KPiA+ID4g
PiA+IMKgwqDCoCB9IHNvY2twdHJfdDsNCj4gPiA+ID4gPiDCoMKgwqAgaW50IHRjcF9zZXRzb2Nr
b3B0KHN0cnVjdCBzb2NrICpzaywgaW50IGxldmVsLCBpbnQNCj4gPiA+ID4gPiBvcHRuYW1lLA0K
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNv
Y2twdHJfdCBvcHR2YWwsIHVuc2lnbmVkIGludA0KPiA+ID4gPiA+IG9wdGxlbik7DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gVGhpcyBwYXRjaCBhZGRlZCBzdHJ1Y3QgdmFsdWUgc3VwcG9ydCBmb3Ig
YnBmIHRyYWNpbmcNCj4gPiA+ID4gPiBwcm9ncmFtcw0KPiA+ID4gPiA+IHdoaWNoDQo+ID4gPiA+
ID4gdXNlcyB0cmFtcG9saW5lLiBzdHJ1Y3QgYXJndW1lbnQgc2l6ZSBuZWVkcyB0byBiZSAxNiBv
ciBsZXNzDQo+ID4gPiA+ID4gc28NCj4gPiA+ID4gPiBpdCBjYW4gZml0IGluIG9uZSBvciB0d28g
cmVnaXN0ZXJzLiBCYXNlZCBvbiBhbmFseXNpcyBvbiBsbHZtDQo+ID4gPiA+ID4gYW5kDQo+ID4g
PiA+ID4gZXhwZXJpbWVudHMsIGF0cnVjdCBhcmd1bWVudCBzaXplIGdyZWF0ZXIgdGhhbiAxNiB3
aWxsIGJlDQo+ID4gPiA+ID4gcGFzc2VkDQo+ID4gPiA+ID4gYXMgcG9pbnRlciB0byB0aGUgc3Ry
dWN0Lg0KPiA+ID4gPiANCj4gPiA+ID4gSXMgaXQgcG9zc2libGUgdG8gZm9yY2UgbGx2bSB0byBh
bHdheXMgcGFzcyBhIHBvaW50ZXIgdG8gYQ0KPiA+ID4gPiBzdHJ1Y3QNCj4gPiA+ID4gb3Zlcg0K
PiA+ID4gPiA4IGJ5dGVzICh0aGUgc2l6ZSBvZiBzaW5nbGUgcmVnaXN0ZXIpIGZvciB0aGUgQlBG
IHRyYWdldD8NCj4gPiA+IA0KPiA+ID4gVGhpcyBpcyBhbHJlYWR5IHRoZSBjYXNlIGZvciBicGYg
dGFyZ2V0LiBBbnkgc3RydWN0IHBhcmFtZXRlciAoMQ0KPiA+ID4gYnl0ZSwgMg0KPiA+ID4gYnl0
ZXMsIC4uLiwgOCB0eXBlcywgLi4uLCAxNiBieXRlcywgLi4uKSB3aWxsIGJlIHBhc3NlZCBhcyBh
DQo+ID4gPiByZWZlcmVuY2UuDQo+ID4gPiANCj4gPiA+IEJ1dCB0aGlzIGlzIG5vdCB0aGUgY2Fz
ZSBmb3IgbW9zdCBvdGhlciBhcmNoaXRlY3R1cmVzLiBGb3INCj4gPiA+IGV4YW1wbGUsDQo+ID4g
PiBmb3INCj4gPiA+IHg4Nl82NCwgaW4gbW9zdCBjYXNlcywgc3RydWN0IHNpemUgPD0gMTYgd2ls
bCBiZSBwYXNzZWQgd2l0aCB0d28NCj4gPiA+IHJlZ2lzdGVycyBpbnN0ZWFkIG9mIGFzIGEgcmVm
ZXJlbmNlLg0KPiA+IA0KPiA+IEkgYXNrIHRoaXMgcXVlc3Rpb24gYmVjYXVzZSB5b3UgbW9kaWZ5
IHRoZSBzaWduYXR1cmUgb2YgYSBicGYNCj4gPiBwcm9ncmFtDQo+ID4gdG8gYSBwb2ludGVyIHRv
IGEgc3RydWN0IGluIHBhdGNoICM0LsKgIElzIHRoYXQgbmVjZXNzYXJ5IGlmIHRoZQ0KPiA+IGNv
bXBpbGVyIHBhc3NlcyBhIHN0cnVjdCBwYXJhbXRlciBhcyBhIHJlZmVyZW5jZT8NCj4gDQo+IE5v
dGUgdGhhdCBUaGUgdHJ1ZSBicGYgcHJvZ3JhbSBzaWduYXR1cmUgaXMgb25seSBvbmUuDQo+IGxv
bmcgYnBmX3Byb2coPGN0eF90eXBlPiAqY3R4KQ0KPiBCUEZfUFJPRyBpcyBhIG1hY3JvIGZvciB1
c2VyIGZyaWVuZGx5IHB1cnBvc2UuDQo+IA0KPiBGb3IgZXhhbXBsZSwNCj4gK2ludCBCUEZfUFJP
Ryh0ZXN0X3N0cnVjdF9hcmdfMSwgc3RydWN0IGJwZl90ZXN0bW9kX3N0cnVjdF9hcmdfMiAqYSwN
Cj4gaW50IA0KPiBiLCBpbnQgYykNCj4gDQo+IGFmdGVyIG1hY3JvIGV4cGFuc2lvbjoNCj4gaW50
IHRlc3Rfc3RydWN0X2FyZ18xKHVuc2lnbmVkIGxvbmcgbG9uZyAqY3R4KTsNCj4gc3RhdGljIF9f
YXR0cmlidXRlX18oKGFsd2F5c19pbmxpbmUpKQ0KPiB0eXBlb2YodGVzdF9zdHJ1Y3RfYXJnXzEo
MCkpIF9fX190ZXN0X3N0cnVjdF9hcmdfMSgNCj4gwqDCoCB1bnNpZ25lZCBsb25nIGxvbmcgKmN0
eCwNCj4gwqDCoCBzdHJ1Y3QgYnBmX3Rlc3Rtb2Rfc3RydWN0X2FyZ18yICphLCBpbnQgYiwgaW50
IGMpOw0KPiAuLi4NCg0KSWYgY2FzdCB0aGUgcG9pbnRlciBvZiBfX3Rlc3Rfc3RydWN0X2FyZ18x
KCkgdG8gdGhlIHR5cGUgKGludA0KKCopKHZvaWQqLCB2b2lkKiwgdm9pZCosIHZvaWQqKSksIHRl
c3Rfc3RydWN0X2FyZ18xKCkgY2FuIHBhc3MgYWxsDQphcmd1bWVudHMgdG8gX190c3Rfc3RydWN0
X2FyZ18xKCkgaW4gdGhlIHR5cGUgKHZvaWQgKikgd2l0aG91dCBjaGFuZ2luZw0KdGhlIHR5cGVz
IG9mIHN0cnVjdCBhcmd1bWVudHMgdG8gdGhlIHBvaW50ZXIgdG8gYSBzdHJ1Y3Qgc2luY2UgYWxs
DQpzdHJ1Y3QgdHlwZXMgd2lsbCBiZSBwYXNzZWQgYXMgYSByZWZlcmVuY2UgZm9yIHRoZSBCUEYg
dGFyZ2V0Lg0KDQpGb3IgZXhhbXBsZSwgdGhlIG1hY3JvIGFib3ZlIGNhbiBiZSBleHBhbmRlZCBp
bnRvIHRoZSBmb2xsb3dpbmcgYmxvY2suDQogIC4uLi4uLg0KICBpbnQgdGVzdF9zdHJ1Y3RfYXJn
XzEodW5zaWduZWQgbG9uZyBsb25nICpjdHgpIHsNCiAgICAuLi4uLi4NCiAgICByZXR1cm4gKCh0
eXBlb2YobmFtZSgwKSkgKCopKHZvaWQqLCB2b2lkKiwgdm9pZCosDQp2b2lkKikpJl9fX190ZXN0
X3N0cnVjdF9hcmdfMSkoY3R4WzBdLCBjdHhbMV0sIGN0eFsyXSwgY3R4WzNdKTsNCiAgICAuLi4u
Li4NCiAgfQ0KICAuLi4uLi4NCg0K

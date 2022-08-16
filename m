Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ABC5960F5
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiHPRVP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 13:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHPRVO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 13:21:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD87757E38
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:21:13 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27GH6P02003312
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:21:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=UBICgUYmJSOVt8F1PQs+MkbXGJl8sO4aYd91Tk+4yAI=;
 b=qrhZo/SQyOdZ90paGeckvkkidR8wpxxoCJJ69QlC1JeTh8DVq5zyqHJ3c8CrrOdycnW5
 AQIHf+XGewIw5Va22DYQGw15/PoeqsgzFaJRIsz8UgYHYkja8cPnVQSyIDJNTNSuaOfW
 gbzER3ipCHVD8HwTgme3XBp2ynr5XIN8Dtw= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j08vdtyqc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 10:21:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkT2SfWyDlzzx5k6DNsNa9GB3AWOq5nBSgKydraej82ajPZ8ZDd2hNRPO7BoMwly+geNxzam+KwRD9AF66PMGsewvd6yaxIM8mG2YWqQK42rSlULOpB55SBJmtC0Ecsbl/M+S6V7sMKXcqhyLAzMwId7LfpS2LGfifnBJ4iBJLolmSadIRT0Ca2evESRcocl+mMt6FhKarlAQcsW1QRWQiuAIHnF3QFP0nPcIRtvqyqin9en0CbIa6hYIEMdX4EAKpp6UuQd41WlJLXhmMu3h6acGxwL5eDLtAi7Bt/E5QxCsu7il1MtIhTcgc+1/SgkNRU4i85wgT8uqkfLgf3sRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBICgUYmJSOVt8F1PQs+MkbXGJl8sO4aYd91Tk+4yAI=;
 b=LV/JB4jAxc0Gn556yPAQB12G/Ieu8ywZUFJgXOyIz1ZL/LNAfQcLd0iOeVzGNYF8PwzWxCrtowtuk2pJF4/yAup+gW0Et2SdjGpTiP0MV7+2I83kq7k2VxyVHCXg7YlN2EEvE8ndC1XhCa+WTyxnJKRC4XuMH1br/tc1cWpn6T6vXubSXPZHv4zJcoQ7bNhbc38r6ZKpEHluG4p95gUy54i5DkKIuKGVqeTdKVqnfqLHtiEWyWksHjRguTTjy9R9gLM3fONq41WLXtB8wEAxkPEoiXriABi7XZTBzoCWkdY6KGKnXNjemARi4dVyBdnKIpsHp1Mk02tsdBzVxcoKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM5PR15MB1883.namprd15.prod.outlook.com (2603:10b6:4:4f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Tue, 16 Aug 2022 17:21:03 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 17:21:03 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "olsajiri@gmail.com" <olsajiri@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYrRe9v9ijmk2lSUWcf88n0+KKiq2u3ZMAgALxXIA=
Date:   Tue, 16 Aug 2022 17:21:03 +0000
Message-ID: <7467b1e10b2693d037184559927a281488c25f5b.camel@fb.com>
References: <20220811001654.1316689-1-kuifeng@fb.com>
         <20220811001654.1316689-2-kuifeng@fb.com> <YvlaCMB6DRIu1vjI@krava>
In-Reply-To: <YvlaCMB6DRIu1vjI@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f3d96cb-1842-424b-00bc-08da7fabb297
x-ms-traffictypediagnostic: DM5PR15MB1883:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/GpVM2ikNvRf65LKSv4rp2VOzFzDt6yUSBUjAwHbTk4F/ozDpSSCCqgGED4LLcLA4mggya964ILu0hXlqJfwZRei3d+/zBx9SnJl0nAw3rjukxmI9NOibuQvGwd4m9fH5icLOVKMuV7Co2+P5TU41JS4bobBMjSY2MUuvpHe6ZLm8Pgz4L2WiWHu7golNHGdIUxHUNRHsJoqVY8TidyhwLw/5UMIGHhm4iVWWMJqR4b9QNcCnUqRNt1nK0ko7dnweJrN6PVsWH0ZNNZSikXLOYwoh3F/Fuz36WttgSxxlV2QMF72SuCkpiyIcYpmyBb2OVYPvJYLNjmGZz+KdYywVbh07hTwFcevmJEaRPg0EEm5Bl0S8/l0NCgdsv9zveGN80tDa9y0AJnC2KLNcDHs95VNL6cx6xKSP5wPlXX50TG39EySIazSH/fex+VGwKWvoCEIn5AowOJOmgqZNEdUArQNBg79EmyKOspOwAjtwShjW8+IeSXVdO9KSWGuH6DnY3T/ASDG+NA7dzq3J7BC8gyHLj/lIz92ll9xuDnqWHM7j7NJ9Hapa+lmdEOORlA3AjrAUGxZ1hEnq7eOZHkt4SkRFkK906+jibwkdWWwM758l6eBOlajC0rx5LHB0KhE00GvCLDgQrYAZlq302aCp/AcNnrCSRhA8H6IEFv8mv1IiJSioqFNqU/0V0OQtxjHu+fdCLEZUMkbQ+gbhYjOta5NOdUlhfjnnyYBji8MmajicavQYmH6PgloHNcZVZJroE6b7EOWvE/h5+IciFUrc4mHjJjQiWZchqharevTy0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(38070700005)(2616005)(316002)(122000001)(71200400001)(41300700001)(64756008)(66556008)(6506007)(66446008)(2906002)(66946007)(6512007)(76116006)(38100700002)(8676002)(4326008)(66476007)(6916009)(36756003)(478600001)(5660300002)(54906003)(8936002)(86362001)(186003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFFYUFM4RmlmZGZrejZvWEJRUUNDaldkREx0Sm1Zbjlvam8rdWtPSnNlRENk?=
 =?utf-8?B?K1NzdnVHb1dMZlpZWEt0RC9mNnpja2pIMG83OFlzM1QwVDQwbXE0SDNoOTJq?=
 =?utf-8?B?Q0FiZGJxSXV2Tm1SSU8xUWlOZVNpaEl0eitZSUJ3eVN4eUoxUTBxUHpITGt3?=
 =?utf-8?B?VEd4MUpoMDRkK1JFUjExNHNwRmRQNUJZUnErM2dWRkFUQVhPSUhhNDlMK09T?=
 =?utf-8?B?cGpya2w0M21UWGlqUmpFcHB1Q2h6OWQwV0NLbGlJYkVRV0kvcDVwY2RDeG1X?=
 =?utf-8?B?M043QTNYT2E1Tml3ci9WN1lWUmp1bnJCck5acC8xV1BZUC9vV1FWODBJaEYv?=
 =?utf-8?B?WkdtaHhLS0Zvblg5TXVDWmo2L1FqMjBGcXJxR0FFUFY1QWprVXhZNkhqOGlq?=
 =?utf-8?B?NEpKZVVSKy9SdE4vUEY4cXJhc0NZQjc0T0lKT2xLMDFZTjExWUpuaVhsRCth?=
 =?utf-8?B?aUE5TkI1dlJPVW0rS1hzU2FYSjUreDhLYUNhWlZLeFFpckVYOGFFR1ZhNGxH?=
 =?utf-8?B?UElTaE1FNndlQnBlb3hSZWxYZzdZTk9NbHd2ZmNLR1B2KzEyR3lnZElra2RX?=
 =?utf-8?B?enJpV1BObjFXankrQU45N2k0QTIvWm14NVlrNkpGQUQxNDNWRVpGZDRZZDRJ?=
 =?utf-8?B?Q2NiVmxpc3VIS0dtdTVJQWRjTUdIcmo2VTd3blc1elF0YWJ2Z2MvMWY3a1lW?=
 =?utf-8?B?dW5RQ2FLd0t5K3dueGJrVzl4d3RTMEozSGYyS0s3WkkwTHhsb3Q1SWNBSWtZ?=
 =?utf-8?B?YU5VZ0lsZURBUGdzMVllZGhvM2RhbU9sZHo2cHMycWFrVlZIbENRVHBWaWJp?=
 =?utf-8?B?Wi9leWJ2QkRTbDNMOGJzRjVMaW45K3h2cXpoNGRSTnUramdkNTZabmV3UEpn?=
 =?utf-8?B?ZWtacHNGRnVJQ3BWdFpleVVzU09aSkMwM2dGcmRrc01wSU9VdmFCV0pXdk5H?=
 =?utf-8?B?eFRnR0J6YXp5RUt2S1M5UEpzWW5YMUhkZnZLdXh4dzF5b251Qkt0VFpaSVM1?=
 =?utf-8?B?ZXZVeWMxcHh2cHhmemJCTk02eDN2cFVMdmNQN1dyZzF1OEw5L29MdzhwSnF5?=
 =?utf-8?B?SVF0QnlYa2pRbDhqcEhmd1Z6MG83OG0wL1NBYzRJWGdpcHI5MWFrb1JpMzBZ?=
 =?utf-8?B?QndHNllkMjJUU3h3WVBMaVV3SFBxQ1R2QU96UU9CemIzZXB3alk3dWVRRzF1?=
 =?utf-8?B?UnI0aWhiZWl6NEcweFVxVTljcEZ4aGx5UkdpNzVvREFPeTN4TkxiZ2llalJK?=
 =?utf-8?B?VUR0L0xmK2NwRXlET1ljeUx0OGN4Z1grRmFYV0RGSVhnNnJrUFF5SXM2S3dx?=
 =?utf-8?B?RUZFekVZSDg0ZmZscFJYREt3Q2ZQcFZzbHF3RU5mK0FWQ1ZUSTNwRTR4OGZz?=
 =?utf-8?B?NGIrcFRPbWFuSUtEejVyaWxNZER4TC9VTGhmVUZWaE9SY0RISlRFN0ZkMFdU?=
 =?utf-8?B?Skp6RTZMTjYvU2VSQzJXWGFPUzJsUXlYQXc2SXVYZGR5S0RhOXBSMzNaVDZF?=
 =?utf-8?B?RW9CcmtpNlRyYlJqRExWWjR2L3pKTzNHODBrSjBhcVBheTZrYmRTdFlrVEh6?=
 =?utf-8?B?RUpnYnVLeFNiQlRJRHJWdzNLSWp2TU56UnR5WjZxVlFpeHk3U3ZieWRRZ0lN?=
 =?utf-8?B?Y1BMdHdsb2hEdGhwTlBiSkNWNU8zRXVXUkxHNEpVWENxUkNIVWRMOFZoNHdj?=
 =?utf-8?B?NlFJZXdrdFhZNkJYc1NGQVp4MnU2ODBoSTgwWFRHdFBTV2t0OGNXK0w4S0Ny?=
 =?utf-8?B?bkZRc0w4Q2tuUVdIRVdzRWhZL1FMYTFFZ2J0dmdIT0F0RTJwb0UraGpvSk9K?=
 =?utf-8?B?SzJsOGh1MVRGc1kvWlBpbzNkbFFLS0N2TTNkbEVKdWtGNlpVZUkyZlBqSjND?=
 =?utf-8?B?bEdCck03Z0R1Q0pKaUNDTDl4Qk1ZOFNVWVk0dmNMQjdMYlFHaWJ6RU8xbjVM?=
 =?utf-8?B?MFhxY2xTNVFCK3hCQis4MTZxT0hwQ3VuMUdTVVUrYWdDVHVleTl2RHh0bGl4?=
 =?utf-8?B?akdrc2pSMFNSVjVHdGtrSHg5OTVMb21oZ0lpU093TGFEYk5aUGVPZjFMVG1u?=
 =?utf-8?B?UDJRS1lLVllRYmtoNzhYSmRhUDZVMDQ5OWo4djVtNU9IanBPNWZtTlRKSmJa?=
 =?utf-8?B?WmUwMWFQZlBBL2djc2hLRm82WWVURGw2Z2NadHRITEp2ZVpiL3IwSmtDL3ZP?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A1B263D6EE26D428BA107E868DDDD69@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3d96cb-1842-424b-00bc-08da7fabb297
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 17:21:03.8566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsfSurefD5ObUq5LLl3GfhLbqRsbz5smaWnS1v7Ri8dQ/BEKVcZuuC2xBbuyRsrC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1883
X-Proofpoint-GUID: MkDE8ZteLn9F5Z-ILrFwKLrzp3WnHCIX
X-Proofpoint-ORIG-GUID: MkDE8ZteLn9F5Z-ILrFwKLrzp3WnHCIX
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

T24gU3VuLCAyMDIyLTA4LTE0IGF0IDIyOjI0ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6Cj4gT24g
V2VkLCBBdWcgMTAsIDIwMjIgYXQgMDU6MTY6NTJQTSAtMDcwMCwgS3VpLUZlbmcgTGVlIHdyb3Rl
Ogo+IAo+IFNOSVAKPiAKPiA+ICtzdGF0aWMgaW50IGJwZl9pdGVyX2F0dGFjaF90YXNrKHN0cnVj
dCBicGZfcHJvZyAqcHJvZywKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVuaW9uIGJwZl9pdGVyX2xpbmtfaW5mbyAqbGlu
Zm8sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYnBmX2l0ZXJfYXV4X2luZm8gKmF1eCkKPiA+ICt7Cj4gPiAr
wqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgZmxhZ3M7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgcGlkX25hbWVzcGFjZSAqbnM7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGlkICpwaWQ7
Cj4gPiArwqDCoMKgwqDCoMKgwqBwaWRfdCB0Z2lkOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKg
aWYgKGxpbmZvLT50YXNrLnRpZCAhPSAwKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgYXV4LT50YXNrLnR5cGUgPSBCUEZfVEFTS19JVEVSX1RJRDsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBhdXgtPnRhc2sudGlkID0gbGluZm8tPnRhc2sudGlkOwo+ID4g
K8KgwqDCoMKgwqDCoMKgfSBlbHNlIGlmIChsaW5mby0+dGFzay50Z2lkICE9IDApIHsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhdXgtPnRhc2sudHlwZSA9IEJQRl9UQVNLX0lU
RVJfVEdJRDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhdXgtPnRhc2sudGdp
ZCA9IGxpbmZvLT50YXNrLnRnaWQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB9IGVsc2UgaWYgKGxpbmZv
LT50YXNrLnBpZF9mZCAhPSAwKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
YXV4LT50YXNrLnR5cGUgPSBCUEZfVEFTS19JVEVSX1RHSUQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcGlkID0gcGlkZmRfZ2V0X3BpZChsaW5mby0+dGFzay5waWRfZmQsICZm
bGFncyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VSUihwaWQp
KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gUFRSX0VSUihwaWQpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG5zID0gdGFza19hY3RpdmVfcGlkX25zKGN1cnJlbnQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGlmIChJU19FUlIobnMpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gUFRSX0VSUihucyk7Cj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGdpZCA9IHBpZF9ucl9ucyhwaWQsIG5zKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodGdpZCA8PSAwKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsK
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhdXgtPnRhc2sudGdpZCA9
IHRnaWQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB9IGVsc2Ugewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGF1eC0+dGFzay50eXBlID0gQlBGX1RBU0tfSVRFUl9BTEw7Cj4gPiArwqDC
oMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ICt9Cj4g
PiArCj4gPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2VxX29wZXJhdGlvbnMgdGFza19zZXFfb3Bz
ID0gewo+ID4gwqDCoMKgwqDCoMKgwqDCoC5zdGFydMKgwqA9IHRhc2tfc2VxX3N0YXJ0LAo+ID4g
wqDCoMKgwqDCoMKgwqDCoC5uZXh0wqDCoMKgPSB0YXNrX3NlcV9uZXh0LAo+ID4gQEAgLTEzNyw4
ICsxOTgsNyBAQCBzdHJ1Y3QgYnBmX2l0ZXJfc2VxX3Rhc2tfZmlsZV9pbmZvIHsKPiA+IMKgc3Rh
dGljIHN0cnVjdCBmaWxlICoKPiA+IMKgdGFza19maWxlX3NlcV9nZXRfbmV4dChzdHJ1Y3QgYnBm
X2l0ZXJfc2VxX3Rhc2tfZmlsZV9pbmZvICppbmZvKQo+ID4gwqB7Cj4gPiAtwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgcGlkX25hbWVzcGFjZSAqbnMgPSBpbmZvLT5jb21tb24ubnM7Cj4gPiAtwqDCoMKg
wqDCoMKgwqB1MzIgY3Vycl90aWQgPSBpbmZvLT50aWQ7Cj4gPiArwqDCoMKgwqDCoMKgwqB1MzIg
c2F2ZWRfdGlkID0gaW5mby0+dGlkOwo+IAo+IHdlIHVzZSAnY3Vycl8nIHByZWZpeCBmb3Igb3Ro
ZXIgc3R1ZmYgaW4gdGhlIGZ1bmN0aW9uLCBsaWtlCj4gY3Vycl90YXNrLCBjdXJyX2ZkIC4uIEkg
dGhpbmsgd2Ugc2hvdWxkIGVpdGhlciBjaGFuZ2UgYWxsIG9mCj4gdGhlbSBvciBhY3R1YWxseSBr
ZWVwIGN1cnJfdGlkLCB3aGljaCBzZWVtIGJldHRlciB0byBtZQoKVGhlIHB1cnBvc2Ugb2YgdGhl
IHZhcmlhYmxlIGlzIGNoYW5nZWQsIHNvIEkgdGhpbmsgJ2N1cnJfdGlkJyBpcyBub3QKZmVhc2li
bGUgYW55bW9yZS4gIEl0IHdhcyB0aGUgdGlkIG9mIHRoZSB0YXNrIHRoYXQgd2UgYXJlIHZpc2l0
aW5nLiAKQnV0LCBub3csIGl0IGlzIHRoZSB0aWQgb2YgdGhlIHRhc2sgdGhhdCB0aGUgaXRlcmF0
b3Igd2FzIHZpc2l0aW5nCndoZW4vYmVmb3JlIGVudGVyaW5nIHRoZSBmdW5jdGlvbi4gIEluIHRo
aXMgcGF0Y2gsIGluZm8tPnRpZCBpcyBhbHdheXMKdGhlIHZhbHVlIG9mIHRoZSBjdXJyZW50IHZp
c2l0aW5nIHRhc2suCgo+IAo+IGppcmthCj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHRh
c2tfc3RydWN0ICpjdXJyX3Rhc2s7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IGN1
cnJfZmQgPSBpbmZvLT5mZDsKPiA+IMKgCj4gPiBAQCAtMTUxLDIxICsyMTEsMTggQEAgdGFza19m
aWxlX3NlcV9nZXRfbmV4dChzdHJ1Y3QKPiA+IGJwZl9pdGVyX3NlcV90YXNrX2ZpbGVfaW5mbyAq
aW5mbykKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3Vycl90YXNrID0gaW5m
by0+dGFzazsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY3Vycl9mZCA9IGlu
Zm8tPmZkOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGN1cnJfdGFzayA9IHRhc2tfc2VxX2dldF9uZXh0KG5zLCAmY3Vycl90
aWQsCj4gPiB0cnVlKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjdXJyX3Rh
c2sgPSB0YXNrX3NlcV9nZXRfbmV4dCgmaW5mby0+Y29tbW9uLCAmaW5mby0KPiA+ID50aWQsIHRy
dWUpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFjdXJyX3Rhc2sp
IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
bmZvLT50YXNrID0gTlVMTDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGluZm8tPnRpZCA9IGN1cnJfdGlkOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gwqAKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLyogc2V0IGluZm8tPnRhc2sgYW5kIGluZm8tPnRpZCAqLwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIHNldCBpbmZvLT50YXNrICovCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGluZm8tPnRhc2sgPSBjdXJyX3Rhc2s7Cj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGN1cnJfdGlkID09IGluZm8tPnRpZCkgewo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChzYXZlZF90aWQgPT0gaW5mby0+
dGlkKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y3Vycl9mZCA9IGluZm8tPmZkOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0g
ZWxzZSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGluZm8tPnRpZCA9IGN1cnJfdGlkOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGVsc2UKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGN1cnJfZmQgPSAwOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKg
wqDCoMKgwqDCoMKgwqB9Cj4gPiDCoAo+IAo+IFNOSVAKCg==

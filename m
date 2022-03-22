Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1C4E43E7
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 17:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiCVQJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiCVQJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 12:09:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688E83
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 09:08:13 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MAiOgf024646
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 09:08:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uwDQ1qRDRp+u61pUraM9srH47Id6TkCvRKLp7U/XWYc=;
 b=FW6qSU51XyLMrsyvJLnlW3O7Fsx508XiFHMsQPC0HHIt16Nu98b83yOeduQYfDNA/mK+
 G7N8aHVgZDKpPw+YZrtaf9v9Q8QaYycq5mUSfIRlnxDOmrisfrklg9PXEwnTF6pcNIlf
 F2yeRhNhYe5POgP/WZBWJ0wv7USF3QicPFo= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eycy9tdfg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 09:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHx88QeyxcRn6rgi7xMHXPnfIj868KPsYPMpq0AgrmstRQexJu0GbFPML5uVRNMaSPy6FFWVmEZpDUQgjs9uxh4zuCGM+tXyXcyGyLpjIcepbt8LTxheFyDkxIwlw2mAsdC/pI8xKRrsTExg9gFIL84RZo4OoTLwAz1mb7uAeHDFDeHl5U9CmqFUKwpj93v1FhypExzuqP/i0riCsRneR4kl8gjIfAa3Pjl0fpic7oHH+JW+ZgP2mmT5ZHntp/CVpk8mwp2/85PM0R4hnXCSexfP+e2ZaU1Ix2tSYq5jn4yEh1znUTtbB1cbQtFK1fsDdebpsp/V3XgRGghzxAYWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwDQ1qRDRp+u61pUraM9srH47Id6TkCvRKLp7U/XWYc=;
 b=LURMWiMraif075eEZ7VXxt6aRwpw3Yw0O3b5kTuavjYuzBRJBdOuLoLfenwaKeXYAWQng29GlS/6edhTW9W4SqFxvKo/tqGtcYSF/aJunhEbcUlbYGTYtGwqmRTIlyRATXGkIYizvcooTCdD0AybcPtfRd2ZefqqxueZbjgYmbXaQpVEMk/4ji63yL2gxhLx3E+cqjYW8mHQIwiw12yfq2EdMnMIpXX/VBDmljlQPmzSc8dWPuF8gHxjIN8V4/8KM0taYM7bbCkFITSfKqx4RbBREqMb/Sq73/vylJKMfhd3g4uABT6LPs/tbo08vrERUTEM6DHmdHHZkjnxMn/07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 16:08:09 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 16:08:09 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Thread-Topic: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Thread-Index: AQHYOM8IO1xa8/UtYkS3jv5jd0HQ6KzKgjEAgAEaPIA=
Date:   Tue, 22 Mar 2022 16:08:09 +0000
Message-ID: <6a14b18ab0d17cacf5dbaa7689eaaa7938cd998b.camel@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
         <20220316004231.1103318-4-kuifeng@fb.com>
         <CAEf4BzYmFUKF0BFnJ62-yayopcwvxGMUogf+Wduwoab3L9m8fg@mail.gmail.com>
In-Reply-To: <CAEf4BzYmFUKF0BFnJ62-yayopcwvxGMUogf+Wduwoab3L9m8fg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecfe18b6-8775-40c4-eab5-08da0c1e28c4
x-ms-traffictypediagnostic: BYAPR15MB3413:EE_
x-microsoft-antispam-prvs: <BYAPR15MB34135E7DA1192940A284B6FDCC179@BYAPR15MB3413.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x1//2dz4Y4Swg0Og5XQaq60KZUJtVmDANDyK3/uFIcNnshVLBi11BDInTX9ZmsLMcqyg1wRoyDIWGtZd2JIoMW7Ya4gQIHbN3jPQ8gZwjHt86SqW9tWdP0Cq9g9zKkRZ1HYFe5tIWzrbXqHF3zaF4v92+xSr4I1ah3McVwsSiRKzBUQDlASD1CoASoMRxjhx1ZPzmC7lJr/29xCYnxjTAkW6TAq2YWhB092Ni7XwnWz2TK7euLX2JmFmSnXz68PLf3Sf2OOuKhil1YjB1C09NKpxLX94vJ0wM1hUNlWZtzuOy30AkL+OzWXb29ZfCFLuF77+BSn9u3i94ZGfGcJ5w1YLAcSjSvArfvf3mIQg6rLxbYwq6nMNFGGr18SgcStGfVFNNbpq7UU47I3POjwciTHo/DRlblkR8EvUHrhbsSFdoYuwXcI9We+Ojojtnjh6WUrzqNmUrQPI6ZMS/9ht3tI1azoeTP2x3CkklDR+/WFOzlRC6CM2EgoeudI+a9HzCty5zrNDkZ7w8axXiarvOXTXdJjRfjM08GpAvnx+ixEllndG5wESk/AitHN18ntf6wS+4HR+H3c5aHZy578NdNnqoXl6aCvMsFZxZYF2g0aAZE2tF2a2QlRl/1P0BecjyDwOfLm0BSv3DGUyFy3BkG9c7u5/JQA7r9rbVj5CuWKZZeEroDuBt2c4ZUxIkfG7cknhgTs8hA5lkKq3RD4evw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(8936002)(4326008)(6512007)(6506007)(71200400001)(5660300002)(6486002)(38100700002)(2906002)(8676002)(76116006)(66946007)(66446008)(66476007)(64756008)(66556008)(508600001)(53546011)(2616005)(38070700005)(86362001)(91956017)(54906003)(36756003)(6916009)(316002)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU5nRkppZmVqcm1CUTlUdTdMc3Uxa050LzI2cjFoaE02U3h3Ym1sNlpMRkNw?=
 =?utf-8?B?Y0ZIWnA4ZUxJdzNrWm51UzFlSUlBK1NxRGhXMnJ1NFVsVW1kaXYwdUhCcXc1?=
 =?utf-8?B?Z3F4cnJDMkFFNkcxb3lqMXhtNnlRSmRkNXR0ZExOV3d1MFpFeXgrbXlFSTBi?=
 =?utf-8?B?UkFtcitWR1pIQXFrUDNaRmdQaFljMnZNL0RqTll0bWRvdzBHbFVtckpmcmpa?=
 =?utf-8?B?ZExLc1haR2pkVFB5ZGxtTnhUUThnbUxrUHlOaFRXVitHYnMxVUdGM1BaMGVT?=
 =?utf-8?B?WjVPVmNTY1FGR2JIZHhINVRXS0VqUWkzb2xNWWI0M1hUam9MaU9sOEJGcVJH?=
 =?utf-8?B?dU43RmhBQmg1Wnl0Unp4UTdsc05wOGdXRXpVYk1rT0p2UEpBRGg0T29sMjVv?=
 =?utf-8?B?NC95ZFFRV2dkUVdKcEM0eFdnRjFORjNNTjV4NEpIZ0t2T21acGg1WDlsWUx0?=
 =?utf-8?B?YkpyUWJ5b09VRXNOTDQ4dXRBWVpYUFM4U3lBZ0UwV3lBTTFyMkIzMlZ6UGl6?=
 =?utf-8?B?UTBKMUNSU1hKYVFwcEI4OG9WZXdDWjMzWHdoQ1YvVmZ2WG1NcjZZUUtzdERi?=
 =?utf-8?B?M1dHZUlFSjdmQmR0R2k4VTdLM2liTHJTZk9Jcy8xQUo2N0Nsc0Q2Y2RGd1hG?=
 =?utf-8?B?TktxSFVKRlczNjRYUCtxTC93cTIvdU5hSFRhUjNGTVZmdmY2ekVlOFMwa0pa?=
 =?utf-8?B?a0RjcUZvZXVVZjJIWmlrRXBJSEdsY1J3bTdDVGhaZTZieW1YS1dLSzROb3l1?=
 =?utf-8?B?c3VCVytLTFAxUExLQkoxbkJKRGdoTmlEakJFRkxyRmlJZ0tGODFaNkd1Vm51?=
 =?utf-8?B?K2dXNU1ZVUxqcmE0NWd0Wjg1eWxveXVWL1hVSnhOOGxTUkhvdWJ0TUxqRXdN?=
 =?utf-8?B?TjdNdG93WDd6b0w4ZE5wTlBENkFIZkNnVEJtVFNrRGJOSU9Kc3pld3o2c0xq?=
 =?utf-8?B?RlhwS0lCVVVrRStKZzVQUzRKejJ4Tk5ySzFBd2tHMTNLejBZWG9wVmNQYlFU?=
 =?utf-8?B?UUI0bk5kRC9FTmVFRnUwN0dIUEN0eVUrMmkxNGJmd00rMFc1YnhjSjQvNFJp?=
 =?utf-8?B?V0JXeEpDc3l6bEk1OC9ZZHpNaEUyeENOYWtXRUJKUXVkUE1JRGNueW1XdGVn?=
 =?utf-8?B?bFZDWWFLSnNOVEtGM3FMd0pEa2EwcE1xTXhaWjRycHppWnU3SEt4b2kycXR6?=
 =?utf-8?B?NElkaFZxa3RXclArS1UwQ2FtYjBvMmgxeSs2VmZLSllmUnplL2pJamRSQlBE?=
 =?utf-8?B?L3NTdW4xQ3RJUSt0dTVDUFZLdEhEUnl6QVJhRTRPc3p1R1VRakF3eXNVUzZ2?=
 =?utf-8?B?dTAxNGY2d1FYa1pZMmlFT0E5cWdtVkx3VHdENkFJZmM2Ymc2Rk5RSkplb0c1?=
 =?utf-8?B?N093UVgyRk5WZWtzQmh6bXVRQy80d3VIbDdSV3YyajBZUGcvMHVGaFB2VTN4?=
 =?utf-8?B?d0JGSm15Nkp1azVvTzg5SzRXby9sSzdyUnhnc1NPR0E0L1AreDQxaHR6SkFi?=
 =?utf-8?B?OWs2WTYrSUJ6T2JST1ZKVWVyRmUvWG9TZWlCRFZWOHBoVFZzcDRoWlNFdFRn?=
 =?utf-8?B?NGYrTzhuTUxzTUJRWS9vYjBqZWc5M3RidzdiWDNFYmVRVSs5eHhWSUVVajZv?=
 =?utf-8?B?RG5tRXRHOFpUaURpeldHME1PbG5jbFdtVUZoM3Y2ckhBOU1jTWVRNWtWdTY3?=
 =?utf-8?B?Y1NlUUhjRExla3VsbnlyQ08vUElyZVQ1SzJNc2dCK3Zhb0FVbVVteWIxaTE2?=
 =?utf-8?B?SkxjN2JnMEJTK0tBVGYxQURERUR1RzRXVmNkSDRwNlRqRHFOekZ2WDZhU3Rw?=
 =?utf-8?B?N0MrUmRlZkI0RWpsTEFCSWhxY3NWUWYxLzZ0MUJIN2l6T1FrZDBmdlBtbHZz?=
 =?utf-8?B?S0M3OUIyY3ZKSUp4MmFtbklkRmsrZ0xLRWcwM1RSMVF0ZTl2Mm5IQ0p2M1Ns?=
 =?utf-8?B?em9wREY2V2FpRFg2d0lWNnY0c0NKRUNQS3pQdUJnRHlFWkM0ZHRuZmxjL3l4?=
 =?utf-8?Q?6LCqAgVI4vSIuWFUC1ydJQiY1a1JAo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BC763B4EB7A194281E38DC56E5F4F8C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfe18b6-8775-40c4-eab5-08da0c1e28c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 16:08:09.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ehzK7xlvsiUiLoe3rgKcpjWjZqVjvk4PvybVIXPFoX5rLmlq1OUxJw3RXbrRtyhX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-Proofpoint-GUID: j7y63ntFrOoKjwF_E8UpMwVMUwtu3Coa
X-Proofpoint-ORIG-GUID: j7y63ntFrOoKjwF_E8UpMwVMUwtu3Coa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTIxIGF0IDE2OjE4IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDU6NDQgUE0gS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQWRkIGEgYnBmX2Nvb2tpZSBmaWVsZCB0byBhdHRh
Y2ggYSBjb29raWUgdG8gYW4gaW5zdGFuY2Ugb2Ygc3RydWN0DQo+ID4gYnBmX2xpbmsuwqAgVGhl
IGNvb2tpZSBvZiBhIGJwZl9saW5rIHdpbGwgYmUgaW5zdGFsbGVkIHdoZW4gY2FsbGluZw0KPiA+
IHRoZQ0KPiA+IGFzc29jaWF0ZWQgcHJvZ3JhbSB0byBtYWtlIGl0IGF2YWlsYWJsZSB0byB0aGUg
cHJvZ3JhbS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPg0KPiA+IC0tLQ0KPiA+IMKgYXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jwqDCoMKg
IHzCoCA0ICsrLS0NCj4gPiDCoGluY2x1ZGUvbGludXgvYnBmLmjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxICsNCj4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKgwqDCoCB8
wqAgMSArDQo+ID4gwqBrZXJuZWwvYnBmL3N5c2NhbGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwg
MTEgKysrKysrKy0tLS0NCj4gPiDCoGtlcm5lbC90cmFjZS9icGZfdHJhY2UuY8KgwqDCoMKgwqDC
oCB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ID4gwqB0b29scy9pbmNsdWRlL3VhcGkvbGludXgv
YnBmLmggfMKgIDEgKw0KPiA+IMKgdG9vbHMvbGliL2JwZi9icGYuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxNCArKysrKysrKysrKysrKw0KPiA+IMKgdG9vbHMvbGliL2JwZi9icGYuaMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+IMKgdG9vbHMvbGliL2JwZi9saWJicGYubWFw
wqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiDCoDkgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbmV0
L2JwZl9qaXRfY29tcC5jDQo+ID4gYi9hcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMNCj4gPiBp
bmRleCAyOTc3NWE0NzU1MTMuLjVmYWI4NTMwZTkwOSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4
Ni9uZXQvYnBmX2ppdF9jb21wLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21w
LmMNCj4gPiBAQCAtMTc1Myw4ICsxNzUzLDggQEAgc3RhdGljIGludCBpbnZva2VfYnBmX3Byb2co
Y29uc3Qgc3RydWN0DQo+ID4gYnRmX2Z1bmNfbW9kZWwgKm0sIHU4ICoqcHByb2csDQo+ID4gDQo+
ID4gwqDCoMKgwqDCoMKgwqAgRU1JVDEoMHg1Mik7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IHB1c2ggcmR4ICovDQo+ID4gDQo+ID4gLcKgwqDCoMKgwqDCoCAvKiBtb3YgcmRpLCAwICovDQo+
ID4gLcKgwqDCoMKgwqDCoCBlbWl0X21vdl9pbW02NCgmcHJvZywgQlBGX1JFR18xLCAwLCAwKTsN
Cj4gPiArwqDCoMKgwqDCoMKgIC8qIG1vdiByZGksIGNvb2tpZSAqLw0KPiA+ICvCoMKgwqDCoMKg
wqAgZW1pdF9tb3ZfaW1tNjQoJnByb2csIEJQRl9SRUdfMSwgKGxvbmcpIGwtPmNvb2tpZSA+PiAz
MiwNCj4gPiAodTMyKSAobG9uZykgbC0+Y29va2llKTsNCj4gDQo+IHdoeSBfX3U2NCB0byBsb25n
IGNhc3Rpbmc/IEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdG8gY2FzdCBhbnl0aGluZyBhdA0KPiBh
bGwsIGJ1dCBpZiB5b3Ugd2FudCB0byBtYWtlIHRoYXQgbW9yZSBleHBsaWNpdCB0aGFuIGp1c3Qg
Y2FzdGluZyB0bw0KPiAodTMyKSBzaG91bGQgYmUgZmluZSwgbm8/DQo+IA0KPiA+IA0KPiA+IMKg
wqDCoMKgwqDCoMKgIC8qIFByZXBhcmUgc3RydWN0IGJwZl90cmFjZV9ydW5fY3R4Lg0KPiA+IMKg
wqDCoMKgwqDCoMKgwqAgKiBzdWIgcnNwLCBzaXplb2Yoc3RydWN0IGJwZl90cmFjZV9ydW5fY3R4
KQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIvaW5jbHVkZS9saW51eC9i
cGYuaA0KPiA+IGluZGV4IGQyMGEyMzk1MzY5Ni4uOTQ2OWY5MjY0YjRmIDEwMDY0NA0KPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvYnBmLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+
ID4gQEAgLTEwNDAsNiArMTA0MCw3IEBAIHN0cnVjdCBicGZfbGluayB7DQo+ID4gwqDCoMKgwqDC
oMKgwqAgc3RydWN0IGJwZl9wcm9nICpwcm9nOw0KPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB3
b3JrX3N0cnVjdCB3b3JrOw0KPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBobGlzdF9ub2RlIHRy
YW1wX2hsaXN0Ow0KPiA+ICvCoMKgwqDCoMKgwqAgdTY0IGNvb2tpZTsNCj4gDQo+IEkgd2FzIGEg
Yml0IGhlc2l0YW50IGFib3V0IGFkZGluZyB0cmFtcF9obGlzdCBpbnRvIGdlbmVyaWMgc3RydWN0
DQo+IGJwZl9saW5rLCBidXQgbm93IHdpdGggYWxzbyBjb29raWUgdGhlcmUgSSdtIGV2ZW4gbW9y
ZSBjb252aW5jZWQgdGhhdA0KPiBpdCdzIG5vdCB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uLi4gU29t
ZSBCUEYgbGlua3Mgd29uJ3QgaGF2ZSBjb29raWUsDQo+IHNvbWUgKGxpa2UgbXVsdGkta3Byb2Jl
KSB3aWxsIGhhdmUgbG90cyBvZiB0aGVtLg0KPiANCj4gU2hvdWxkIHdlIGNyZWF0ZSBzdHJ1Y3Qg
YnBmX3RyYW1wX2xpbmsge30gd2hpY2ggd2lsbCBoYXZlIHRyYW1wX2hsaXN0DQo+IGFuZCBjb29r
aWU/IEFzIGZvciB0cmFtcF9obGlzdCwgd2UgY2FuIHByb2JhYmx5IGFsc28ga2VlcCBpdCBiYWNr
IGluDQo+IGJwZl9wcm9nX2F1eCBhbmQganVzdCBmZXRjaCBpdCB0aHJvdWdoIGxpbmstPnByb2ct
PmF1eC0+dHJhbXBfaGxpc3QNCj4gaW4NCj4gdHJhbXBvbGluZSBjb2RlLiBUaGlzIG1pZ2h0IHJl
ZHVjZSBhbW91bnQgb2YgY29kZSBjaHVybiBpbiBwYXRjaCAxLg0KDQpEbyB5b3UgbWVhbiBhIHN0
cnVjdCBsaWtlcyBsaWtlPw0KDQpzdHJ1Y3QgYnBmX3RyYW1wX2xpbmsgew0KICBzdHJ1Y3QgYnBm
X2xpbmsgbGluazsNCiAgc3RydWN0IGhsaXN0X25vZGUgdHJhbXBfaGxpc3Q7DQogIHU2NCBjb29r
aWU7DQp9Ow0KDQpJIGxpa2UgdGhpcyBpZGVhIHNpbmNlIHdlIGRvbid0IHVzZSBjb29raWUgZm9y
IGV2ZXJ5IGJwZl9saW5rLg0KQnV0LCBjb3VsZCB5b3UgZ2l2ZSBtZSBhbiBleGFtcGxlIHRoYXQg
d2UgZG9uJ3Qgd2FudCBhIGNvb2tpZT8NCg0K

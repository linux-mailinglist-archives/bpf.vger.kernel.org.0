Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE023FBB30
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbhH3Rmt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 13:42:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238294AbhH3Rmo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 13:42:44 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17UHR60P027892;
        Mon, 30 Aug 2021 10:41:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=q4Qr7iQ7mzgMRgRdH3G/OZqQ9+PHMngQYTdcM9njpDY=;
 b=m+ukZ3jfVvRKb6IMY/acmrGSLF58wX4QObm5CihHA4qKmQFvR8NGkbiS9K2Ue+nHvPEI
 Y0N00sWm7L8D2+UDwwLokkxnq2zcKJOkYuqHu56o3wruhKyC/owwG5TDZQYJXql9OGP0
 jdAqcCyGcYu14py3T1u5BhrMl3nzhtOneOk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3aru4xbb76-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 10:41:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 10:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiibuhVBxSG8ogaITTAr0EgWv0Milqkp/q3GCMCfvbUwcXHI68g6/ZFEjVGXC495A1ua/IXW7pahBHW8x0+DO5IwtFuKeFZWj9me65lpdDRXXZ1cXHsqjbOz1uCJ5AvaeyuoEU2O2zSnKR8QcvDZhgJFGGK1FTILkrJ+HB+Sd0+9T1QE+WX2aLkgWZsItrhjWB1MEhxHv+eUS9CuTKqKgEESbvVJRr9bC0D6nTb+OggsmpyvRKv/0acO5iRpLRML+zUuIP5CowB4rbAX4qoHs+/JOXSpWCMuCrArKtBUofEgR8/sGcnj0WAMkam598sAhvrr/hup5U5kI2D3Zi4ZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4Qr7iQ7mzgMRgRdH3G/OZqQ9+PHMngQYTdcM9njpDY=;
 b=Q2vHPcEo18AIZdKxUI0jP+qeSlKfq6hgtylssQVnytkCPyqxeVfKEXYmBanGzadX0b2kg38YyO8emL67L802uRIRg6LOYhZhJjcBNgrmH9cGgbvcenaua8pVxg0qyM4AwzZWDejhdho24pwV0a/Zz5F206KWjCiboWlRf7AmFsCkVuBCdTbvPJccmZvdl/YuUEI1nY34XeDyDSLjN06/rOgd4ebu0w2lopI7IwbsRyoEUcnBvQP5iCpbccsP/gGQBs73ily4riy0/a9rx7LWa+G5OZ5e0DDke3O5Ua4BJiYR1scdC7SBwykYz86n8JxFjUng6ROy0rDZrrcvfoW41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 17:41:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 17:41:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXmsebo1O8tvcQbk6YyjOXJsK0SquL3HIAgAB6mIA=
Date:   Mon, 30 Aug 2021 17:41:46 +0000
Message-ID: <719D2DC2-CC5D-4C6A-94F4-DBCADDA291CC@fb.com>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830102258.GI4353@worktop.programming.kicks-ass.net>
In-Reply-To: <20210830102258.GI4353@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78d26818-4bdb-4174-286b-08d96bdd7066
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB51126342E4046C4433837FFEB3CB9@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1P941pabKd57yqKn+efkWDKe8QwNennc/SiE4CK5AXzf95X8D57T2f0+XHhTHVDs5RGZhbX67JvxzVWsxtk+xfOroxR6aVCBthskbllHczEdNWbQSbB0wPeUW5brQvjR4lLWzFj4EMuEWxs5SWQZsafrY52U+1iehWpRaS99MjUY+cf8TxkYvW5Qy24n4c3wbUZ0LCzn9rauCu8Vb7bRfi7dQoOjfIHIKOyCU6sJM+BikYuj4d10Rt1YhXjTnbCuVcst1FiZKiqh6XjWAG/MH4GFz23I4N5IYJ5SQBaLmdwhp2suMt8dsNikDlYv6RJi6mRsC08jUAFMqjvsX3GUTytpFmKmQ3C/cjosrHu0I4Gcr1tXR8DxZuvvuxEOMrWuEyJGdvV2fTvTl6mPwN9OeH6s6aQj8HepJ5NNdzBZl4aMrXGCepQPqCm+tzc+M/CxCaS/TvqTDzCrKl4fl1HqRtfyth5Cz2/GYi3+ydxFlY0vhIBu61pM8NqWjmmN15BS7E1HWKSR0U4fdVhvoi4DY/fJAaW3vDGqArsZh/1I6xxLx4rS3Cscczf/vedINQeiGSf7T4CM19zyh1/i8o4vNftGXm7s5lmHls2IfFTyVCQASodVXeKsGaH9iIQsJOJqgUa37BKreeG4JI3C2M/o4Fn97ILJCJ72SEOf8fN/wkoXvXC40/bqGPm+Y3FZx9hf8jlWsx0xz8eul4xt6Jdhabp2eKeBKoXnU3wqGZqZ122pX5LS6zqoWW6ed2e9g+Ri
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(6506007)(186003)(53546011)(8936002)(4326008)(2616005)(86362001)(66476007)(36756003)(71200400001)(91956017)(122000001)(83380400001)(66556008)(33656002)(5660300002)(66446008)(64756008)(76116006)(6486002)(38100700002)(8676002)(6916009)(66946007)(6512007)(54906003)(38070700005)(316002)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm5FTE4rNEpTckJNb3FsWllPMzlhS0xBMWJhSDlUR3pVckFlaElSU0FsTmV6?=
 =?utf-8?B?SG5Yb0Y0SHZQNFdGdnpoemxYKzU1OEJJMzRkQlo5dS9CSTFpZENSMDV4b09E?=
 =?utf-8?B?OGdxQkQ1TE9hb1VJSFU5WUtxdVQvQlpyQm5JWVZVRkxSV05yRy9BKzd1MFk4?=
 =?utf-8?B?QTdNWDNEaDlKTDhzdGdtNFBJVDVZNWVnQSsyRDA2VzVOVlAyVW4yckVJcUJF?=
 =?utf-8?B?c1ZpZm1DTEM0V0MvWDlvWUhjbjA1aTVyc0QwVUZ4ZjBIb1grK1l0OVF6eUM3?=
 =?utf-8?B?b2RlMWR4WGlaaXFnMTB3ZmQyVkdTR0tuR3hYMzU2a1VzUWp1M2Q3djlCU1My?=
 =?utf-8?B?WGhpamlwUThPdU9MSDlyU205czlnVUFnc3ZjU0NBMzZjUjQxQkdTdHVTTzdI?=
 =?utf-8?B?MVBxMkk2M2xJUW8ydnNiRE1tVTIzWGNlVXZLTDJMOU9HWEswNzlmWnhDa2RC?=
 =?utf-8?B?NXBBRnJ6ZGk0QW5ONTZaTW80T243THhubVBPaWg4Wnp2WDZ6TktkT1pJbnBo?=
 =?utf-8?B?bzhTOHA4WGt3K0dmTXdDZUJvMVNXUU9qdEJGcUFxcGFTZ1F2b1BnMTFuMUpi?=
 =?utf-8?B?MWR6SjQ1L09FcTh2aVU4NnpnNk0rRVA2Y05KamdERU1uc2dHVURsZjN2N2Vj?=
 =?utf-8?B?cHVYRTQwcEtuRlJhalk5MnpTL3d0T3FQVVFRd1VIZ0VEdGltRTdINGtlS1hr?=
 =?utf-8?B?TWw1WVBHMHNrWkRYcDZteGdsUndoUVdTaFVPbVFXZzBrbWRVcTRYQ1NtSzFW?=
 =?utf-8?B?TmdCOU1PSU5uNGx6NjFWaU9yZ3ZoZGlQNnFseHNtREFzQmIyR05aQ1IzVm1K?=
 =?utf-8?B?UDNoK045SEhUREJzRmlwb3dNZ2FpNndQZCtCbDJGaG5saDZ6UllSclN0dzRv?=
 =?utf-8?B?SldvcGVGcTFpZitiWjY4TVJsckdxdVJEbGtSOGdLTXlaZDdUTU04VDFmRW1x?=
 =?utf-8?B?T0s5SlNNeVRuVHZnRnpNWmRCRFdnT0VGZUY5M0l3OG9GN09sRWFXZHE1Q3hT?=
 =?utf-8?B?RXlVV2JjWHNkMkdRczdtVjBsbTdkOUFTZUZUOFF0QXd2OHZwNHBJeEF5UGlp?=
 =?utf-8?B?cEFLSFZSVHhFbUZ5bmRkdGl6REd1dGRlZlIyL0lQUkExa214SmpLU2V2T044?=
 =?utf-8?B?VFNvVGVoaFpLcU1TUmNzY1FQQ2ZoaklWVEJhSFYvb1MwM3ZJVis1bDdvUEs2?=
 =?utf-8?B?aFE4K0lrZElTUm1FTDRuVnRNcHVLMC9OaDFWdHJvWFNFU0NtYlorSWxKakQ2?=
 =?utf-8?B?RzcrNk5TZEZ3MlQyL1hOSVNIZWpDSW9BMEp5S0J3aDFDVXF1MWo4cUQ1emRk?=
 =?utf-8?B?Y2c0QnNwYWR6Q1V3N0Y1SXV6YTk4dm9HTnRqK1pOTWQvenpMSG82SXRaeFBR?=
 =?utf-8?B?dVFBbkloVklpcC9yRVZTK29NemdEVGtTeVpLTDZIVHo2c2VKdENKMkppQ3Jz?=
 =?utf-8?B?U3VHSlRjNkZBRmdJTkwwREpWVmxCT0o0RW9FRDRrRGdKSWg5R0J0MWxMdUd1?=
 =?utf-8?B?UFBYNjczeFIvRzVXZVB4Z2E2RmEyTXFoMENpQ3FMUnMwdFJOaSt3VEtVWkV1?=
 =?utf-8?B?VzRnODFma2puTTJoODdRbG00Wlo4cllERWlHRVk0RFl3NXN1bVNZbXkxMUJD?=
 =?utf-8?B?UWV5OVJyOGhwQ0F0S0hnZUlMQi9TRTNvc2lkWEx2aXlGT2lBdVEwQjhFYzdx?=
 =?utf-8?B?b0NsV2RqNGsrZVVrRDQ1MTA1K0tmV2N1bGs4UlRSSm5ja3pKazg4d2JZYVNF?=
 =?utf-8?B?SEhoakEwUkNsKzB6R2dhOG0xTUVpNlM1c1RwazAraHlwMmtlU0o5S2tkNjBq?=
 =?utf-8?Q?tZtjNAZnOwZAR/iYjGKLYHQYfb8JEUcDZJvTw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <485C951FA1F61640A5ECFA0A6BC8D4E3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d26818-4bdb-4174-286b-08d96bdd7066
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 17:41:46.6984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPKGj9JBdMkQb+CEQTR9T/I0/Rju6vKBAQ0nV6QPWt7lNdTicmxXjjWWezXnfe+gTlw/ZgLxxhFVHQxzoTAVww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 6NbMQUf5Xw_UgGk7MNx22pMJHmNPLaxL
X-Proofpoint-GUID: 6NbMQUf5Xw_UgGk7MNx22pMJHmNPLaxL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_06:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gQXVnIDMwLCAyMDIxLCBhdCAzOjIyIEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBBdWcgMjYsIDIwMjEgYXQgMDM6
MTM6MDRQTSAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiAraW50IGR1bW15X3BlcmZfc25hcHNo
b3RfYnJhbmNoX3N0YWNrKHN0cnVjdCBwZXJmX2JyYW5jaF9zbmFwc2hvdCAqYnJfc25hcHNob3Qp
Ow0KPj4gKw0KPj4gK0RFQ0xBUkVfU1RBVElDX0NBTEwocGVyZl9zbmFwc2hvdF9icmFuY2hfc3Rh
Y2ssIGR1bW15X3BlcmZfc25hcHNob3RfYnJhbmNoX3N0YWNrKTsNCj4+ICsNCj4+ICNlbmRpZiAv
KiBfTElOVVhfUEVSRl9FVkVOVF9IICovDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL2V2ZW50cy9j
b3JlLmMgYi9rZXJuZWwvZXZlbnRzL2NvcmUuYw0KPj4gaW5kZXggMDExY2M1MDY5YjdiYS4uYzUz
ZmU5MGU2MzBhYyAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9ldmVudHMvY29yZS5jDQo+PiArKysg
Yi9rZXJuZWwvZXZlbnRzL2NvcmUuYw0KPj4gQEAgLTEzNDM3LDMgKzEzNDM3LDYgQEAgc3RydWN0
IGNncm91cF9zdWJzeXMgcGVyZl9ldmVudF9jZ3JwX3N1YnN5cyA9IHsNCj4+IAkudGhyZWFkZWQJ
PSB0cnVlLA0KPj4gfTsNCj4+ICNlbmRpZiAvKiBDT05GSUdfQ0dST1VQX1BFUkYgKi8NCj4+ICsN
Cj4+ICtERUZJTkVfU1RBVElDX0NBTExfTlVMTChwZXJmX3NuYXBzaG90X2JyYW5jaF9zdGFjaywN
Cj4+ICsJCQlkdW1teV9wZXJmX3NuYXBzaG90X2JyYW5jaF9zdGFjayk7DQo+IA0KPiBUaGlzIGlz
bid0IHJpZ2h0Li4uDQo+IA0KPiBUaGUgd2hvbGUgZHVtbXlfcGVyZl9zbmFwc2hvdF9icmFuY2hf
c3RhY2soKSB0aGluZyBpcyBhIGRlY2xhcmF0aW9uIG9ubHkNCj4gYW5kIHVzZWQgYXMgYSB0eXBl
ZGVmLiBBbHNvLCBERUZJTkVfU1RBVElDX0NBTExfTlVMTCgpIGFuZA0KPiBzdGF0aWNfY2FsbF9j
b25kKCkgcmVseSBvbiBhIHZvaWQgcmV0dXJuIHZhbHVlLCB3aGljaCBpdCBkb2Vzbid0IGhhdmUu
DQo+IA0KPiBEaWQgeW91IHdhbnQ6DQo+IA0KPiAgREVDTEFSRV9TVEFUSUNfQ0FMTChwZXJmX3Nu
YXBzaG90X2JyYW5jaF9zdGFjaywgdm9pZCAoKikoc3RydWN0IHBlcmZfYnJhbmNoX3NuYXBzaG90
ICopKTsNCj4gDQo+ICBERUZJTkVfU1RBVElDX0NBTExfTlVMTChwZXJmX3NuYXBzaG90X2JyYW5j
aF9zdGFjaywgdm9pZCAoKikoc3RydWN0IHBlcmZfYnJhbmNoX3NuYXBzaG90ICopKTsNCj4gDQo+
ICBzdGF0aWNfY2FsbF9jb25kKHBlcmZfc25hcHNob3RfYnJhbmNoX3N0YWNrKSguLi4pOw0KPiAN
Cj4gKk9SKiwgZG8geW91IGFjdHVhbGx5IG5lZWQgdGhhdCByZXR1cm4gdmFsdWUsIGluIHdoaWNo
IGNhc2UgeW91J3JlDQo+IHByb2JhYmx5IGxvb2tpbmcgZm9yOg0KPiANCj4gIERFQ0xBUkVfU1RB
VElDX0NBTEwocGVyZl9zbmFwc2hvdF9icmFuY2hfc3RhY2ssIGludCAoKikoc3RydWN0IHBlcmZf
YnJhbmNoX3NuYXBzaG90ICopKTsNCj4gDQo+ICBERUZJTkVfU1RBVElDX0NBTExfUkVUMChwZXJm
X3NuYXBzaG90X2JyYW5jaF9zdGFjaywgaW50ICgqKShzdHJ1Y3QgcGVyZl9icmFuY2hfc25hcHNo
b3QgKikpOw0KPiANCj4gIHJldCA9IHN0YXRpY19jYWxsKHBlcmZfc25hcHNob3RfYnJhbmNoX3N0
YWNrKSguLi4pOw0KPiANCj4gPw0KDQpIbW1tLi4uIHNvbWV0aGluZyBkb2Vzbid0IHdvcmsgaGVy
ZS4gSSBoYXZlOg0KDQovKiBpbmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaCAqLw0KREVDTEFSRV9T
VEFUSUNfQ0FMTChwZXJmX3NuYXBzaG90X2JyYW5jaF9zdGFjaywNCiAgICAgICAgICAgICAgICAg
ICBpbnQgKCopKHN0cnVjdCBwZXJmX2JyYW5jaF9zbmFwc2hvdCAqKSk7DQoNCg0KLyoga2VybmVs
L2V2ZW50cy9jb3JlLmMgKi8NCkRFRklORV9TVEFUSUNfQ0FMTF9SRVQwKHBlcmZfc25hcHNob3Rf
YnJhbmNoX3N0YWNrLA0KICAgICAgICAgICAgICAgICAgICAgICBpbnQgKCopKHN0cnVjdCBwZXJm
X2JyYW5jaF9zbmFwc2hvdCAqKSk7DQoNCi8qIGtlcm5lbC9icGYvdHJhbXBvbGluZS5jICovDQog
ICAgICAgaWYgKHByb2ctPmNhbGxfZ2V0X2JyYW5jaCkNCiAgICAgICAgICAgICAgIHN0YXRpY19j
YWxsKHBlcmZfc25hcHNob3RfYnJhbmNoX3N0YWNrKSgNCiAgICAgICAgICAgICAgICAgICAgICAg
dGhpc19jcHVfcHRyKCZicGZfcGVyZl9icmFuY2hfc25hcHNob3QpKTsNCg0KLyogYXJjaC94ODYv
ZXZlbnRzL2ludGVsL2NvcmUuYyAqLw0KICAgICAgIGlmICh4ODZfcG11LmRpc2FibGVfYWxsID09
IGludGVsX3BtdV9kaXNhYmxlX2FsbCkNCiAgICAgICAgICAgICAgIHN0YXRpY19jYWxsX3VwZGF0
ZShwZXJmX3NuYXBzaG90X2JyYW5jaF9zdGFjaywNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnRlbF9wbXVfc25hcHNob3RfYnJhbmNoX3N0YWNrKTsNCg0KQW5kIHRoZSBjb21w
aWxlciBrZWVwcyBjb21wbGFpbiB3aXRoOg0KDQphcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5j
OiBJbiBmdW5jdGlvbiDigJhpbnRlbF9wbXVfaW5pdOKAmToNCi4vaW5jbHVkZS9saW51eC9zdGF0
aWNfY2FsbC5oOjEyMTo0MTogZXJyb3I6IGluaXRpYWxpemF0aW9uIG9mIOKAmGludCAoKiopKHN0
cnVjdCBwZXJmX2JyYW5jaF9zbmFwc2hvdCAqKeKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVy
IHR5cGUg4oCYaW50ICgqKShzdHJ1Y3QgcGVyZl9icmFuY2hfc25hcHNob3QgKinigJkgWy1XZXJy
b3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZSBdDQogIHR5cGVvZigmU1RBVElDX0NBTExfVFJB
TVAobmFtZSkpIF9fRiA9IChmdW5jKTsgICBcDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4NCmFyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmM6NjMwNTo0OiBub3Rl
OiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYc3RhdGljX2NhbGxfdXBkYXRl4oCZDQogICAgc3Rh
dGljX2NhbGxfdXBkYXRlKHBlcmZfc25hcHNob3RfYnJhbmNoX3N0YWNrLA0KICAgIF5+fn5+fn5+
fn5+fn5+fn5+fg0KDQoNClNvbWV0aGluZyBsaWtlIA0KDQp0eXBlZGVmIGludCAocGVyZl9zbmFw
c2hvdF9icmFuY2hfc3RhY2tfdCkoc3RydWN0IHBlcmZfYnJhbmNoX3NuYXBzaG90ICopOw0KREVD
TEFSRV9TVEFUSUNfQ0FMTChwZXJmX3NuYXBzaG90X2JyYW5jaF9zdGFjaywgcGVyZl9zbmFwc2hv
dF9icmFuY2hfc3RhY2tfdCk7DQoNCnNlZW1zIHRvIHdvcmsgZmluZS4gDQoNClRoYW5rcywNClNv
bmcNCg0K

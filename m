Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F66520ACD
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 03:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiEJBrs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 21:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiEJBrp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 21:47:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8322802F8
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 18:43:50 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249MUnd1006223
        for <bpf@vger.kernel.org>; Mon, 9 May 2022 18:43:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JuaAxr1zQmGE7So6lOxc9o8c2CuKVBAKD1uYJJupbQ8=;
 b=c4uFRRuC5JfGb14fRwvASpSxieM+EsfuWNtwJWG/wERkNwooTkwUWbpcdCLlktLAU9ql
 BdJzPPxCdv5Ky7UvhAybfhHYU9YU6Y9NQHe/cq5K9wDZEzRWYckJ7JvdnKHEZLMRqR+/
 xaMcmeNcWgHzRliU9HRJpKrQ+cponjPWkdc= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwm3pdbe7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 18:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEKMlfndBB3d1RBxMuXSbGU/7Pv73OIBrK20+J4yuLQ8mJe8bardSiDpHw+m+NTiE3cHqwIyeCz8fLwYE5+oiq2xTHJ8MCOnkL1a7VmdK9h2ykMx19Urgk+YW7KBVTw6pmQ6Arm62psmcLhgWMZpFYvbd0qNTb2T1gK7FjvuCmPPfbJ6N9sLH/x38JqKgjbqH7OB81SnpJ2em+fmRx+Eguji9mEY/YTsH6JN1jT6cg5sjNvZyNN6AWafRkeBFySsyC2M7ihBJli9xCniIh7B67771c049C0pc3TwtBN9GbASAmQjI3CsuruMeGN9wxsp+7KBohgiYf1+6xFnrEE2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuaAxr1zQmGE7So6lOxc9o8c2CuKVBAKD1uYJJupbQ8=;
 b=iFQcwJy4R39+6GzEM0BlMC8Vwqqkc257HA1wtAR5trBRESkUleuOGY39eqSWlU4tFSSYkKuwkESJ2uZ4GpClJiHrddwu9hFC33ZnQ9c3vxLCQc7va08nS+kxZalu2oqUcfn8qN/AafxvevnnwwyRTwjy5V2zG4451ZqcQS9Y3xn9b99XkMpQvy8A61PoueyWzkmkpkBlL8cLY40TFdF5S72uhjk47W/3qmmY4TmteMD71nyRAqmMfHakLpn4NwgaKcLfqFhKaeEAPxC0Q1BdaDQuQfbErgcZ5B7YnoKb05RYcF4JZLXS+LSvaq+rVKlf4KKcl89kr7ZJBVRckw+TBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM5PR15MB1482.namprd15.prod.outlook.com (2603:10b6:3:ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 01:43:46 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 01:43:46 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
Thread-Topic: [PATCH bpf-next v7 2/5] bpf, x86: Create bpf_tramp_run_ctx on
 the caller thread's stack
Thread-Index: AQHYYorCI9bE54qCe0CoDURzTgSB/60XC6SAgABKMQCAAAPcAA==
Date:   Tue, 10 May 2022 01:43:46 +0000
Message-ID: <34dd81b7fe8f0e683a56a8fbcb32957d1d61969e.camel@fb.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
         <20220508032117.2783209-3-kuifeng@fb.com>
         <20220509210425.igjjopd4virbtn3u@MBP-98dd607d3435.dhcp.thefacebook.com>
         <c3ade9c0ad19e9cef5864c0df948e0ae4cd54709.camel@fb.com>
In-Reply-To: <c3ade9c0ad19e9cef5864c0df948e0ae4cd54709.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5632eb91-7a9b-44d0-2ba8-08da3226861d
x-ms-traffictypediagnostic: DM5PR15MB1482:EE_
x-microsoft-antispam-prvs: <DM5PR15MB1482EB16FF2F772F4BA78588CCC99@DM5PR15MB1482.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1tVAxlZ/S9KIwENcK1aNF+QHbsLQ5unQMqQf79kbHUs7wsM6dK8jYuUHUpn8ZHGrKomXq2F2U9Toyl0G1ZRd6dflha3plQkcXgrsbTBeFvOwg6zCLxopEd+N8RRe+Jw7HYVMuUs1DMDMt4qzc3ylWsP+9bJ5++OQ3EWUsgFrz9YREmOmWiiQUFouMReFV4d77fS/L+3kWNmVKaLjJgzKZpCBm7MhRX++lSrcsSu1iUhGoX2G0G3M5V/bWqmZR084wsSIdrYaqdrpgAkKdrYl57N2pGjvXxxJWCtxam6O7XbsxrwNqs8WjIX3YiQd/rLg39i9Nglj4RSSBBnzRa0zsjlA4J1zFnIQSSi8Te13sDw5euQs2mVhCt3GE+84fnbqjo+2JIwHcf6fr2AeRhsaW39vAtvbNVVJrZFc431kdI5LLRxp3yjAWqmzBQE8mIbCBRzcgxi3nhOvwd7ScUq6PkIpAwEWhTiAayI4O8hJHgENGGb1fBRl7uMvWH+NsVZAoqfKUkJ9SoP45/MjsEjgWlG3ID67pOJ7r8FTu3g6qWXEsCXy4yzDqRqgC2mgQeMnalMVkNohC5smYJDYqn75zCuqcqfphHuF6eHhleS/+4hdVDslv6NkZYATgxRUjPig/rHmGM6vWRyvlt6vstjxHHaZ4SYCSsc6628OH9SRZ+dvHK165bI4IZ18hjHtc8xbmVXpdtBMXG0pBqf6ASaDxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(71200400001)(4326008)(2616005)(86362001)(6512007)(6506007)(2906002)(122000001)(6486002)(83380400001)(5660300002)(508600001)(316002)(6916009)(38070700005)(38100700002)(8936002)(36756003)(186003)(66946007)(66476007)(76116006)(54906003)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlpFOUtrZmNiSkdnVnptNnNQREZ0T1o2R3VjZHBuaHdzU1laMmpTU3lUbFNu?=
 =?utf-8?B?TVpWL0hCRlVOWkI4ZEZ2VTZTUGI1Q2ZJMG81Y3lZYXdLVlZySFhDNEFJTm0v?=
 =?utf-8?B?czBLVzdJa2c1QWtkY2FldTkrbXBhTVprWVhpbldCTGJ3SFVsUnRwOWtqcHgx?=
 =?utf-8?B?WXFNRTM2OVp2S2J0U1A2UzRlczVlTDA4bkpuTjNqdjhIYWRTN3NWcTlEMi9S?=
 =?utf-8?B?SEI0UjB1d09JU2prNDY1VXdxbElkRlIrZXBBbmJ4MlM1NXVMTTN2SFZpV0Vz?=
 =?utf-8?B?a1VzQVdrTFNGYmlYdWx0cGM0ZXM3bUMrMnVBTStWanhUTW9yVlhjRnZJZG12?=
 =?utf-8?B?MFNmdm1zaHlmRG15TlJmNFg2NEtOZUZNQ3MwcHdsMEVteFh5QlpiaHJuOGVM?=
 =?utf-8?B?TWJ1OFNrSkhoVHZQUWdVZFpWL1N0QU91NHdQODRzQ3ZFeVNXT21KQysrb1lq?=
 =?utf-8?B?MmlEUUpyTFFwR25TZDhTZE5Mb3NPK0ZyY3JCT2ltV2lnSFFDUnlYOXgyVkJp?=
 =?utf-8?B?TzBmeDltV1liTDhEYTFSVk1UVEt4TEljWDBNTkJxVGxSSTg4amVxRUIvUmJG?=
 =?utf-8?B?akZmSW1BNDFCSmJBUFZ2MzU0d2hRRGM4OVFSTE1qL2tkNTlxcW9wVHlic01T?=
 =?utf-8?B?cDhleE4yaVpua2loZkVxc2Z2c3VTSnZBVW5MUEM2dGlnMEZtZHQwSXE4YUtR?=
 =?utf-8?B?OGRXNHlGdTFXelhXRDJQZzYzUW5vVkpDS3dWTEVzMUc5KzRwVFExV0toeVEr?=
 =?utf-8?B?ZldZblc0Uy9UMW03R3F1TXh3SytMZnROQ1NWaDF3SVlVaHpQQy9aQ00zd1Nn?=
 =?utf-8?B?TW15RFJOTmNCMDlQeC92NDFmeUl5M2FkM1FmTnkxNFBqQ2h2WjJHRWFnTGd3?=
 =?utf-8?B?U1B3SnErekcweWJYMUdRcDhkL1RzalgrcHlvMDByWWVyWStTU3BDOG1wNU9i?=
 =?utf-8?B?a3NrdHEyWXU1ajUwdEF2NE5WeEdRWmZsZENzNUc4d2daMS83OENmdkM3d0I0?=
 =?utf-8?B?Q3c0MysvMVozdm1qNG9mV2xMci82MGxuQkEvZmZJR0tBeDBrcWN1VTJPSWFY?=
 =?utf-8?B?Snp2cFlISUNIa2pTNGhxQ3BxK1FrL3ByWE11dGpCQXppWUl4dzg5QlJqek9h?=
 =?utf-8?B?V01qVzYrMmxhbVNxK1lPbnl0S1oxNGw2dHRCWk90bXR1d1UyRVpZVzlWVjhk?=
 =?utf-8?B?b0JENXkxWW5jL0dYN1d6OFo3ME9yWkd2a0RCUVJ4UndEMmJiZHFiMytxNUZB?=
 =?utf-8?B?bHQ1eFI2cDlYOS9rMXZvZ0Y1SkdjYzBhZ0NHVjAwUFZ1WmdUMWJ6aXlGeUtv?=
 =?utf-8?B?dWswNXlkVkRMM0JkblJFK2U2dmd2V2hkSWNnUFNES2VVQ2dyQ0ppdDl5a1pU?=
 =?utf-8?B?MVVhWERrRVgwbWdqbzYwRWZKMmg1VHNIRnJvQ2JtTFcxUm1xMzNXbUthTjNo?=
 =?utf-8?B?Nkw2RGN2WjhZeEJ6T3ZuVHU3SGRLdzlUZXlXTElJbTM5TDYzd0oxbURPTEt1?=
 =?utf-8?B?M0kyR2YxZGZOcXpXeTU4KzZHdWYrUTNlclUxbUJpUmREbStILzY1M0JpYThr?=
 =?utf-8?B?RG5oazh1Um5YNndsbVNVVUhqemRydk42c1djNDJuSjFBcVF1YjV5aFA1a1RJ?=
 =?utf-8?B?NVVaM3MwbVo2dkJpRDJ5ZmhNYlZyZE9FYTRnM0tFRVkvNEZ2WVc4ditYYnBG?=
 =?utf-8?B?QjJ5dy80YXREYWNaWW83Z3JYOXRMMmFQODlJYmt6bkY4eDcwcmtXUytmNVF2?=
 =?utf-8?B?ZENyTCt6ZlRDbGdDTHR5VVZVc0tTcnN5UFJCaUUyWFRZbTlXakJGT0VWRkdt?=
 =?utf-8?B?NUtOR3pjSWpxT1dRQlQ1aCt6RFhJYWdaT3lhRlFyeUNzRmxHUFFxNG0zVUhj?=
 =?utf-8?B?aVQ5NEk1U0lHbmFlRUk3SURQV1p6SG5tRmxGMERvaFJXK05rLzVMS1VlRUZU?=
 =?utf-8?B?NktJTkI2Z1pxZTZXQVA4NkNxcEtwVjZmRkpmNjNpbElkV2tBU3ZyZVRzclcz?=
 =?utf-8?B?QzhiREt4YXV2UmYzU1MvZUR1S2IxOFpTV3NtWjB5KzNIWUl3WGxLeEJjYWtJ?=
 =?utf-8?B?NzVqYktlSVJZcVJJQWQ5K1BScnJmWmxzSGViR3NBdlY0bnhUcnhraFpMOWwz?=
 =?utf-8?B?SXFhSm0wZ2FZMVB1K3d1MmE5a2gxY2Y4cnNuUGJrblZjZ01YbkZiYktpOTNi?=
 =?utf-8?B?QWhoTEh5MHAvNEdycXUwVU0zSXRZOUtmYUtpOXJUTzV5N1FDNnIyaGJ0anFX?=
 =?utf-8?B?YUloNG11S3Axa0VPQlIrR293TnhmYVdSZlhJZndLL2NuOHZ1M1FzcHdzaEJN?=
 =?utf-8?B?RS9MQ0VoNTA1QkZ6dDk4dVV1clpuZTAwRG1POTJicTJoaXhzRzdXci9nVXll?=
 =?utf-8?Q?TaVlDW9AYc1AM3qXlLx0nqBvBJ1uZ/tAJDkgF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5009B0CE85F7714EA9828EF34ED07D9A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5632eb91-7a9b-44d0-2ba8-08da3226861d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 01:43:46.5926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7OVKblCLwCVd1uub7wq9A3RSgvJVpRlZN3dTIMpPNm7fVwctqBL40XoPy0spO+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1482
X-Proofpoint-GUID: yIAOlGp9gw-fD35pC-nbf1qwjLHgfqTt
X-Proofpoint-ORIG-GUID: yIAOlGp9gw-fD35pC-nbf1qwjLHgfqTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_06,2022-05-09_02,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTEwIGF0IDAxOjI5ICswMDAwLCBLdWktRmVuZyBMZWUgd3JvdGU6Cj4g
T24gTW9uLCAyMDIyLTA1LTA5IGF0IDE0OjA0IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6Cj4gPiBPbiBTYXQsIE1heSAwNywgMjAyMiBhdCAwODoyMToxNFBNIC0wNzAwLCBLdWktRmVu
ZyBMZWUgd3JvdGU6Cj4gPiA+IMKgCj4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qIFByZXBhcmUgc3Ry
dWN0IGJwZl90cmFtcF9ydW5fY3R4Lgo+ID4gPiArwqDCoMKgwqDCoMKgwqAgKiBzdWIgcnNwLCBz
aXplb2Yoc3RydWN0IGJwZl90cmFtcF9ydW5fY3R4KQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgKi8K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgRU1JVDQoMHg0OCwgMHg4MywgMHhFQywgc2l6ZW9mKHN0cnVj
dAo+ID4gPiBicGZfdHJhbXBfcnVuX2N0eCkpOwo+ID4gPiArCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqBpZiAoZmVudHJ5LT5ucl9saW5rcykKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBpZiAoaW52b2tlX2JwZihtLCAmcHJvZywgZmVudHJ5LCByZWdzX29mZiwKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGZsYWdzICYKPiA+ID4gQlBGX1RSQU1QX0ZfUkVUX0ZFTlRSWV9SRVQpKQo+ID4gPiBAQCAtMjA5
OCw2ICsyMTIxLDExIEBAIGludCBhcmNoX3ByZXBhcmVfYnBmX3RyYW1wb2xpbmUoc3RydWN0Cj4g
PiA+IGJwZl90cmFtcF9pbWFnZSAqaW0sIHZvaWQgKmltYWdlLCB2b2lkICppCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqB9Cj4gPiA+IMKgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoZmxhZ3MgJiBC
UEZfVFJBTVBfRl9DQUxMX09SSUcpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC8qIHBvcCBzdHJ1Y3QgYnBmX3RyYW1wX3J1bl9jdHgKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIGFkZCByc3AsIHNpemVvZihzdHJ1Y3QgYnBmX3RyYW1wX3J1bl9j
dHgpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEVNSVQ0KDB4NDgsIDB4ODMsIDB4QzQsIHNpemVvZihz
dHJ1Y3QKPiA+ID4gYnBmX3RyYW1wX3J1bl9jdHgpKTsKPiA+ID4gKwo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlc3RvcmVfcmVncyhtLCAmcHJvZywgbnJfYXJncywgcmVn
c19vZmYpOwo+ID4gPiDCoAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8q
IGNhbGwgb3JpZ2luYWwgZnVuY3Rpb24gKi8KPiA+ID4gQEAgLTIxMTAsNiArMjEzOCwxMSBAQCBp
bnQgYXJjaF9wcmVwYXJlX2JwZl90cmFtcG9saW5lKHN0cnVjdAo+ID4gPiBicGZfdHJhbXBfaW1h
Z2UgKmltLCB2b2lkICppbWFnZSwgdm9pZCAqaQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGltLT5pcF9hZnRlcl9jYWxsID0gcHJvZzsKPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBtZW1jcHkocHJvZywgeDg2X25vcHNbNV0sIFg4Nl9QQVRDSF9TSVpF
KTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcm9nICs9IFg4Nl9QQVRD
SF9TSVpFOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKiBQ
cmVwYXJlIHN0cnVjdCBicGZfdHJhbXBfcnVuX2N0eC4KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAqIHN1YiByc3AsIHNpemVvZihzdHJ1Y3QgYnBmX3RyYW1wX3J1bl9jdHgp
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoEVNSVQ0KDB4NDgsIDB4ODMsIDB4RUMsIHNpemVvZihzdHJ1
Y3QKPiA+ID4gYnBmX3RyYW1wX3J1bl9jdHgpKTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+
ID4gwqAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChmbW9kX3JldC0+bnJfbGlua3MpIHsKPiA+
ID4gQEAgLTIxMzMsNiArMjE2NiwxMSBAQCBpbnQgYXJjaF9wcmVwYXJlX2JwZl90cmFtcG9saW5l
KHN0cnVjdAo+ID4gPiBicGZfdHJhbXBfaW1hZ2UgKmltLCB2b2lkICppbWFnZSwgdm9pZCAqaQo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IGNsZWFudXA7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gPiDC
oAo+ID4gPiArwqDCoMKgwqDCoMKgwqAvKiBwb3Agc3RydWN0IGJwZl90cmFtcF9ydW5fY3R4Cj4g
PiA+ICvCoMKgwqDCoMKgwqDCoCAqIGFkZCByc3AsIHNpemVvZihzdHJ1Y3QgYnBmX3RyYW1wX3J1
bl9jdHgpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiArwqDCoMKgwqDCoMKgwqBFTUlU
NCgweDQ4LCAweDgzLCAweEM0LCBzaXplb2Yoc3RydWN0Cj4gPiA+IGJwZl90cmFtcF9ydW5fY3R4
KSk7Cj4gPiA+ICsKPiA+IAo+ID4gV2hhdCBpcyB0aGUgcG9pbnQgb2YgYWxsIG9mIHRoZXNlIGFk
ZGl0aW9uYWwgc3ViL2FkZCByc3AgPwo+ID4gSXQgc2VlbXMgdW5jb25kaXRpb25hbGx5IGluY3Jl
YXNpbmcgc3RhY2tfc2l6ZSBieSBzaXplb2Yoc3RydWN0Cj4gPiBicGZfdHJhbXBfcnVuX2N0eCkK
PiA+IHdpbGwgYWNoaWV2ZSB0aGUgc2FtZSBhbmQgYWJvdmUgNCBleHRyYSBpbnNucyB3b24ndCBi
ZSBuZWVkZWQuCj4gCj4gSSB0aGluayB5b3UgYXJlIHJpZ2h0Lgo+IAoKVGhlIHJlYXNvbiB0aGF0
IEkgZG9uJ3QgY2hhbmdlIHN0YWNrX3NpemUgaXMgdGhhdCB3ZSBhY2Nlc3MgYXJndW1lbnRzCm9y
IHNhdmVkIHJlZ2lzdGVycyBiYXNpbmcgb24gc3RhY2tfc2l6ZS4gIE9uY2UgdGhlIHN0YWNrX3Np
emUgaXMKY2hhbmdlZCwgYWxsIHRoZXNlIG9mZnNldHMgc2hvdWxkIGJlIGNoYW5nZWQgdG9vLgoK

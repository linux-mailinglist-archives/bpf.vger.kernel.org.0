Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2115A0512
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 02:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiHYAQl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 20:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHYAQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 20:16:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572726D559
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:16:39 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OMH9Ab029071
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:16:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=VMVkt8cyM71UfQP+52Obluy6qXsjAhyf3WD6tk9+y+s=;
 b=qOdkChL6TwhmvnhE6gmt4B/vy7QmkJTYodLbPmVOyYtTFMY20n2H2jGvuyqCn3uBh8RP
 p35M/n38bYk1TUO6OrXBTcNeKS6a9inOeof7+7y2pfGohMNEGvMU+mg7wVjS3P2yA9ek
 Q5Ru0Lx1K6CszUVV8jredM/vLpRWwPGily0= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5a8qyh55-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:16:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQa/cJjp5ayy/ziI5o+zYSMiKtZlhVaYORDWuzNN9diuzcERgfq7j0dnU9FkDpfIlzjjhPRafPMIgI5Omi49loObXtXHqk+a9Myed6O0y2FFQyOHn37sxhuMPiQc5UExIm6yAVuvTcdK8e5cMGYTqVE8bGN4cUatYpWueCK2bfdSL2cjP0hX8IoJyzH/Vx8mxEsrmx02SveEQoWxGGCiFr98XIYcBGV9D1zSNOgrrT7Jo2t+NxQBDukEgMqEa4anStkMjEiQI5Na2+x8VqKdfIv12YE2c2iIG30b5ahV1SxFjo7AXHE3Sn66A6GHxa0Peg+jJ8x/KAllTxbneiJtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMVkt8cyM71UfQP+52Obluy6qXsjAhyf3WD6tk9+y+s=;
 b=ER3/zt/a2ZKv5+yX/z1QumhZLzHJXPdDOiaHepsM5Hf1SOsHf5cJ5XWZeZ15srZP17b5Mw3edK+YZOEXFji+X0d+U7kNwtLHhJ8s0iiwcP6P0Z68cJ3AGazGxmpLNsuxmuLPYpI6YVB2f1uc+b5qZ3ibPPDs+I5qYQT2CutHRcmxnmRwz59erA/mIvuSdV16FOZTkz0gK2iFflNHmKYsfvmPL0k5QC4DyvMAXip2ILieGFpF9TlQ3ppH3V3lzYJHMKxq7KqrwCTL1F+p8uhnxbg9O2HCOyLzunT7PWz+NIPyS2t8HEfQLfUrseR/dpjAQ1cYAurMRYPEzCZdnXZeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BLAPR15MB3827.namprd15.prod.outlook.com (2603:10b6:208:254::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 00:16:35 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 00:16:35 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v6 1/4] bpf: Parameterize task iterators.
Thread-Index: AQHYtBhma+uwkbOpgku54fTHsnnakq2+p1GAgAAgXYA=
Date:   Thu, 25 Aug 2022 00:16:35 +0000
Message-ID: <52171bf63f54b311116988cefd275c0847396d45.camel@fb.com>
References: <20220819220927.3409575-1-kuifeng@fb.com>
         <20220819220927.3409575-2-kuifeng@fb.com>
         <CAEf4Bzai7s1E6Y5=+URKXvSO7h8NJ6aNLxZCQrTq2ucTUp=S_Q@mail.gmail.com>
In-Reply-To: <CAEf4Bzai7s1E6Y5=+URKXvSO7h8NJ6aNLxZCQrTq2ucTUp=S_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0cbb6fd-2c1f-4d35-7eae-08da862f1249
x-ms-traffictypediagnostic: BLAPR15MB3827:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CoGZ4zbBRJPkp5hRWivmy8pI913GfnZEFFvhOC9J62Etp7DA6lkM4Ym+ZhY87W69WwTb6bVoNKvj7e38zsw5VFDRD7fgYDYBdRYD9iw7yr8ciUymmnSim2A3k+ca1pOxE4PDU0q023S1iABNlsfgnBsVJ0ALXF19TTxncKhUVFsAkUDFgbwk/O6rBG1PlyTOrq59cf6f3lQ1zEzX7i6A6mfoheE0Me7Q7/MQNBECsh53VO7o48jvm6bfybbHW/CjIgdFOQXxBzvKyMqpcXFvXWt0P+0QoNRy98lUSS6peNYtTbfkJk1bPjiIvZz5KVCtGQgajLme/QWcmkDFSEA3y0lBnUWaHReXU/01OW4u2CA6bQqfX0aLObPakD+FGkQ7RIkzUGq7xjnq+a4YlpZrq1Q4MMQoZG6hynGiFUH7CRv2WuVjdWiT0Gl4PQsU7JCPWErlEFJcqPOSLJirxKNaCHp37gNMv7ycSg+JnrREZU37gVl1bQGEdM69oXUC6P1JF3jWFJqLT9NZQh8xNVwJHxgH/qob+6gVLVBPIPmzUE3ztXJsT1PUGwbbguDBkpMpyVDCu8/+ib1IATzBKkLyFmbM7Z6tx5aW1Vxzl91lhBRENZMU4ug08XEM1EjK0fKiFi4u4pfoC9VYVjHeJAwVtFPrFgqmKdjt11FaniZAMtwnWmiMIuYvtbr1USDZ7Md4ViRnnDR81tNhUFdsj0Qwkwi/r/KzO1zI/swJRaOuxC/9z3wJZLhqTktj90i4QEmSG2edaZ3P1pFI2tR6I4sBsjHW7XZ8hcXLbQ7wgT5Ha/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(6916009)(71200400001)(478600001)(53546011)(86362001)(6486002)(26005)(54906003)(186003)(2616005)(6506007)(6512007)(36756003)(76116006)(38100700002)(122000001)(66946007)(4326008)(66556008)(66446008)(64756008)(66476007)(8676002)(316002)(83380400001)(38070700005)(2906002)(5660300002)(41300700001)(8936002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkdwZWYyMll3NjRVRDV0V1VUZ2lzVWhINXBCYlRLa3lNT1MxTG01SzV4ei9L?=
 =?utf-8?B?Q0RRSGEzTmU1bHVzbk5IMG4wL21DaW9vTTFxZUIwRXJ2am8ya2IzdkM1Qm9N?=
 =?utf-8?B?MEJQYnZuaDBNOFhaeWI2Sk5hd1NRNjRNZ1pQdG5Hd1AraWsrRjg2YW5FNGFD?=
 =?utf-8?B?U0dKT0d5RlVXWEJteFNGUUNlRHJ5K3FnZGpwVzc4SzF1bnRLWmFad1dSOURJ?=
 =?utf-8?B?Z201b1VWT1ZVcUFBUWFZbm96Vk0rOUNkaVl0UlJXb1Y4aFhnQWt5YW9FU28v?=
 =?utf-8?B?SzlaY1k4UTB6dEczYUxqbEZZeEZwSXl1T0FrR1lzT3hlN1RzbFh0TWhDUmFK?=
 =?utf-8?B?amx3YzFoVjBRSG1zN05WaVpKNHZyS05MUEc0TUcrYlp1a2lhREw1VG1rQWF5?=
 =?utf-8?B?WVlFMEFnZTNJOFRGQi9aNTJNUm50bXMxYmZGLzZad0V1SU1EUFlZL2d6ZmlN?=
 =?utf-8?B?MDh5ajJmYUptS2FhSnhWZTIzMldGRWI5RGlkekl2VU1XYkdCUU52QzdCVHcx?=
 =?utf-8?B?TXVKd3VPd1RIU3gxTmR1ejNQVjk3SkdIM3BaZWxxS0x3TytraTFXQTJuUHZp?=
 =?utf-8?B?N2RXRWNlZ29Cck5sR2lnS29pY0wrUU5CMTgwbHhoYU0ydVJYTjhaY01wRUs5?=
 =?utf-8?B?Y1JaQWpncWgrYzBMQis5cFNmY3pSYTFEOEtDM0xCeHRpMjk4d0E1bHhVWVk2?=
 =?utf-8?B?bzNDdlZFTUwwVzhmTzNsNnZPTllNb2FLeVZmQ3gySWxrVW1WYnRNcDRkcWM0?=
 =?utf-8?B?bWZuWWpoM1duUEliYkZnQ1lLeDg4bDJldlVsMzRVa1ZwQXBQdTZNWmZhNnFJ?=
 =?utf-8?B?V0JxWkNyaU1xaWpENi9LNDJkUHFPTm9ZM0dzaWZNb1FIMER2SE1DNlhrRHJZ?=
 =?utf-8?B?aHFtNFQ4MnRBSUp0NXJXZWFVbDhFZjlRalFqUHBYSG5EZGU4YXo0SkNEU3VL?=
 =?utf-8?B?RUIvYTFoTmtHcjZwNTg2Ym4yRW9KMVNMTVlXS0YwNDg0STc1OFlqcDl6MjBP?=
 =?utf-8?B?U29VTzVNejRDNDZzL3owWS8xcENRV2VjSWFCRy9ybExYS2VxOGxZTUZEUFRx?=
 =?utf-8?B?RmFUQTNMUkNWV2VaRzdaN3NpUXVGOVVjczgyc1o2L0RYTEMxVkRLMmtsUVpk?=
 =?utf-8?B?TmFUbGxNdnVaYlczdmxpNHNqQUM2cjVzWUFjTnRSczFOSEdZem5waThuTzdJ?=
 =?utf-8?B?NmxNYnFEcGs3a2RPM0xqdVZJeUhWVXZscnMzb1ZJUmpGeTVaQTlzMXVOYlRW?=
 =?utf-8?B?V2VhWUUxVjFZZ21FYU1WVDVUM1NDaUZPbXdRM2V6d3NOa1EzaUwwZnU0THFY?=
 =?utf-8?B?Wmd6TDQ0MDg3R3czQUUvNTZxbkttV2llMUVpT2c0R2U3NnRncnliQUExa0o5?=
 =?utf-8?B?NzFEVWRvQ3g3aHpRdk5TeGxHdk1idmIzajZBdEwyc3g3REFsWnNjamNZQWh3?=
 =?utf-8?B?NWZvWjE2djlndUNHTVlUOEtlUXN0OVJMMiszUWdQT2Fjck1SR3YyWVM4bkk5?=
 =?utf-8?B?VDBSZEY0OFpFdlJQRzVqTDBaak03NE5uSm8zSVc2RFEzY3ExaU1SVUV1SDdT?=
 =?utf-8?B?dGNMelRvWFExWU5HdUw0ckNHZ0YzQUFZMDJ5eURudDRoVkRoOUVsaEwvN1p0?=
 =?utf-8?B?bTNYUGROZlIrNTVTbUxpRkFxamhDVk1UUFUzS2RGMmI3UEc5MlpPRXJDTkNi?=
 =?utf-8?B?NzZxMWE5L0ZpQTduQkFZWHNUcXBETzd6a3lUUFgwamlBT0diOXQ0SUxodURM?=
 =?utf-8?B?VEFsbzBYOXFSWkViR3pYQ1FzeWdoM1NwRUFvSFFvTjZPVG0zWk0wRjlGbnNo?=
 =?utf-8?B?bjNCZHJqQm5TMVZFQjc1UE1STzk0dC9zUzNHYjE0bHdTYnBHUjBFNWF6MXI2?=
 =?utf-8?B?TDRwK3p1Y0I5VWdEMmxwd1AvdDF6UFNtZitOczJTY1BEb1Z5Kzdvcm5CZlBE?=
 =?utf-8?B?LzJ5VGljNDM5MGl2dXdOUmFJV2R6b3Z5RW9PSlhFeVBPZTZGdUxHaXNVdXV5?=
 =?utf-8?B?RjByS3VjU2NnamRkMGJvRWRRZEpHT29wNzBlajM5NXNRQ2d4ejNFNThHUi9s?=
 =?utf-8?B?dTBjT0wrL2NXeVNSVXN2NmhtRXU3UlNZcHRjNitBZVBZQjdJaFNYREQ3aFl6?=
 =?utf-8?Q?Cbisj68MQh67Bjp92Y3AeHTB7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <073B3B3A881CC942941BB03736349651@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cbb6fd-2c1f-4d35-7eae-08da862f1249
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 00:16:35.4581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Dm3FE1tInbEprn/OCMmGnny9hnCkYlDSmE+U7dqHUTN3yZ7oQP+ZQtAartxrAZk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3827
X-Proofpoint-GUID: ZFzFMFS5Q9zpOn_r57P4HCRXMes1T_T3
X-Proofpoint-ORIG-GUID: ZFzFMFS5Q9zpOn_r57P4HCRXMes1T_T3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_15,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTI0IGF0IDE1OjIwIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gRnJpLCBBdWcgMTksIDIwMjIgYXQgMzowOSBQTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToKPiA+IAo+ID4gQWxsb3cgY3JlYXRpbmcgYW4gaXRlcmF0b3IgdGhhdCBs
b29wcyB0aHJvdWdoIHJlc291cmNlcyBvZiBvbmUKPiA+IHRhc2svdGhyZWFkLgo+ID4gCj4gPiBQ
ZW9wbGUgY291bGQgb25seSBjcmVhdGUgaXRlcmF0b3JzIHRvIGxvb3AgdGhyb3VnaCBhbGwgcmVz
b3VyY2VzIG9mCj4gPiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0
aG91Z2ggdGhleSB3ZXJlCj4gPiBpbnRlcmVzdGVkCj4gPiBpbiBvbmx5IHRoZSByZXNvdXJjZXMg
b2YgYSBzcGVjaWZpYyB0YXNrIG9yIHByb2Nlc3MuwqAgUGFzc2luZyB0aGUKPiA+IGFkZGl0aW9u
YWwgcGFyYW1ldGVycywgcGVvcGxlIGNhbiBub3cgY3JlYXRlIGFuIGl0ZXJhdG9yIHRvIGdvCj4g
PiB0aHJvdWdoIGFsbCByZXNvdXJjZXMgb3Igb25seSB0aGUgcmVzb3VyY2VzIG9mIGEgdGFzay4K
PiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4KPiA+
IC0tLQo+ID4gwqBpbmNsdWRlL2xpbnV4L2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MjUgKysrKysrKwo+ID4gwqBpbmNsdWRlL3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqAgfMKg
wqAgNiArKwo+ID4gwqBrZXJuZWwvYnBmL3Rhc2tfaXRlci5jwqDCoMKgwqDCoMKgwqDCoCB8IDEx
NiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQo+ID4gLS0tLQo+ID4gwqB0b29scy9pbmNs
dWRlL3VhcGkvbGludXgvYnBmLmggfMKgwqAgNiArKwo+ID4gwqA0IGZpbGVzIGNoYW5nZWQsIDEy
OSBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvYnBmLmggYi9pbmNsdWRlL2xpbnV4L2JwZi5oCj4gPiBpbmRleCAzOWJkMzYz
NTljMWUuLjU5NzEyZGQ5MTdkOCAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBmLmgK
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgKPiA+IEBAIC0xNzI5LDggKzE3MjksMzMgQEAg
aW50IGJwZl9vYmpfZ2V0X3VzZXIoY29uc3QgY2hhciBfX3VzZXIKPiA+ICpwYXRobmFtZSwgaW50
IGZsYWdzKTsKPiA+IMKgwqDCoMKgwqDCoMKgIGV4dGVybiBpbnQgYnBmX2l0ZXJfICMjIHRhcmdl
dChhcmdzKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gwqDCoMKg
wqDCoMKgwqAgaW50IF9faW5pdCBicGZfaXRlcl8gIyMgdGFyZ2V0KGFyZ3MpIHsgcmV0dXJuIDA7
IH0KPiA+IAo+ID4gKy8qCj4gPiArICogVGhlIHRhc2sgdHlwZSBvZiBpdGVyYXRvcnMuCj4gPiAr
ICoKPiA+ICsgKiBGb3IgQlBGIHRhc2sgaXRlcmF0b3JzLCB0aGV5IGNhbiBiZSBwYXJhbWV0ZXJp
emVkIHdpdGggdmFyaW91cwo+ID4gKyAqIHBhcmFtZXRlcnMgdG8gdmlzaXQgb25seSBzb21lIG9m
IHRhc2tzLgo+ID4gKyAqCj4gPiArICogQlBGX1RBU0tfSVRFUl9BTEwgKGRlZmF1bHQpCj4gPiAr
ICrCoMKgwqDCoCBJdGVyYXRlIG92ZXIgcmVzb3VyY2VzIG9mIGV2ZXJ5IHRhc2suCj4gPiArICoK
PiA+ICsgKiBCUEZfVEFTS19JVEVSX1RJRAo+ID4gKyAqwqDCoMKgwqAgSXRlcmF0ZSBvdmVyIHJl
c291cmNlcyBvZiBhIHRhc2svdGlkLgo+ID4gKyAqCj4gPiArICogQlBGX1RBU0tfSVRFUl9UR0lE
Cj4gPiArICrCoMKgwqDCoCBJdGVyYXRlIG92ZXIgcmVvc3VyY2VzIG9mIGV2ZXZyeSB0YXNrIG9m
IGEgcHJvY2VzcyAvIHRhc2sKPiA+IGdyb3VwLgo+IAo+IHR5cG9zOiByZXNvdXJjZXMsIGV2ZXJ5
Cj4gCj4gPiArICovCj4gPiArZW51bSBicGZfaXRlcl90YXNrX3R5cGUgewo+ID4gK8KgwqDCoMKg
wqDCoCBCUEZfVEFTS19JVEVSX0FMTCA9IDAsCj4gPiArwqDCoMKgwqDCoMKgIEJQRl9UQVNLX0lU
RVJfVElELAo+ID4gK8KgwqDCoMKgwqDCoCBCUEZfVEFTS19JVEVSX1RHSUQsCj4gPiArfTsKPiA+
ICsKPiAKPiBbLi4uXQo+IAo+ID4gwqDCoMKgwqDCoMKgwqAgcmN1X3JlYWRfbG9jaygpOwo+ID4g
wqByZXRyeToKPiA+IC3CoMKgwqDCoMKgwqAgcGlkID0gZmluZF9nZV9waWQoKnRpZCwgbnMpOwo+
ID4gK8KgwqDCoMKgwqDCoCBwaWQgPSBmaW5kX2dlX3BpZCgqdGlkLCBjb21tb24tPm5zKTsKPiA+
IMKgwqDCoMKgwqDCoMKgIGlmIChwaWQpIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICp0aWQgPSBwaWRfbnJfbnMocGlkLCBucyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqdGlkID0gcGlkX25yX25zKHBpZCwgY29tbW9uLT5ucyk7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFzayA9IGdldF9waWRfdGFzayhwaWQsIFBJRFRZUEVfUElE
KTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXRhc2spIHsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKysqdGlkOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIHJldHJ5
Owo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIGlmIChza2lwX2lmX2R1
cF9maWxlcyAmJgo+ID4gIXRocmVhZF9ncm91cF9sZWFkZXIodGFzaykgJiYKPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXNrLT5maWxlcyA9
PSB0YXNrLT5ncm91cF9sZWFkZXItCj4gPiA+ZmlsZXMpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoKHNraXBfaWZfZHVwX2ZpbGVzICYmCj4gPiAhdGhyZWFk
X2dyb3VwX2xlYWRlcih0YXNrKSAmJgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFzay0+ZmlsZXMgPT0gdGFzay0+Z3JvdXBfbGVhZGVy
LQo+ID4gPmZpbGVzKSB8fAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIChjb21tb24tPnR5cGUgPT0gQlBGX1RBU0tfSVRFUl9UR0lEICYmCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBf
X3Rhc2tfcGlkX25yX25zKHRhc2ssIFBJRFRZUEVfVEdJRCwKPiA+IGNvbW1vbi0+bnMpICE9IGNv
bW1vbi0+cGlkKSkgewo+IAo+IGl0IGdldHMgc3VwZXIgaGFyZCB0byBmb2xsb3cgdGhpcyBsb2dp
Yywgd291bGQgYSBzaW1wbGUgaGVscGVyCj4gZnVuY3Rpb24gdG8gY2FsY3VsYXRlIHRoaXMgY29u
ZGl0aW9uIChhbmQgbWF5YmUgc29tZSBjb21tZW50cyB0bwo+IGV4cGxhaW4gdGhlIGxvZ2ljIGJl
aGluZCB0aGVzZSBjaGVja3M/KSBtYWtlIGl0IGEgYml0IG1vcmUgcmVhZGFibGU/CgohbWF0Y2hl
ZF90YXNrKHRhc2ssIGNvbW1vbiwgc2tpcF9pZl9kdXBfZmlsZSk/Cgpib29sIG1hdGNoZWRfdGFz
ayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIAogICAgICAgICAgICAgICAgICBzdHJ1Y3QgYnBm
X2l0ZXJfc2VxX3Rhc2tfY29tbW9uICpjb21tb24sCiAgICAgICAgICAgICAgICAgIGJvb2wgc2tp
cF9pZl9kdXBfZmlsZSkgewogICAgICAgIC8qIFNob3VsZCBub3QgaGF2ZSB0aGUgc2FtZSAnZmls
ZXMnIGlmIHNraXBfaWZfZHVwX2ZpbGUgaXMgdHJ1ZQoqLwogICAgICAgIGJvb2wgZGlmZl9maWxl
c19pZiA9CiAgICAgICAgICAgICAgICAhc2tpcF9pZl9kdXBfZmlsZSB8fAogICAgICAgICAgICAg
ICAgKHRocmVhZF9ncm91cF9sZWFkZXIodGFzaykgJiYKICAgICAgICAgICAgICAgIHRhc2stPmZp
bGUgIT0gdGFzay0+Z29ydXBfbGVhZGVyLT5maWVzKTsKICAgICAgICAvKiBTaG91bGQgaGF2ZSB0
aGUgZ2l2ZW4gdGdpZCBpZiB0aGUgdHlwZSBpcyBCUEZfVEFTS19JVEVSX1RHSQoqLwogICAgICAg
IGJvb2wgaGF2ZV90Z2lkX2lmID0KICAgICAgICAgICAgICAgIGNvbW1vbi0+dHlwZSAhPSBCUEZf
VEFTS19JVEVSX1RHSUQgfHwKICAgICAgICAgICAgICAgIF9fdGFza19waWRfbnJfbnModGFzaywg
UElEVFlQRV9UR0lELAogICAgICAgICAgICAgICAgY29tbW9uLT5ucykgPT0gY29tbW9uLT5waWQ7
CiAgICAgICAgcmV0dXJuIGRpZmZfZmlsZXNfaWYgJiYgaGF2ZV90Z2lkX2lmOwp9CgpIb3cgYWJv
dXQgdGhpcz8KCj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHB1dF90YXNrX3N0cnVjdCh0YXNrKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFzayA9IE5VTEw7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICsrKnRpZDsKPiA+IEBAIC01Niw3ICs3Myw3
IEBAIHN0YXRpYyB2b2lkICp0YXNrX3NlcV9zdGFydChzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSwKPiA+
IGxvZmZfdCAqcG9zKQo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJwZl9pdGVyX3NlcV90YXNr
X2luZm8gKmluZm8gPSBzZXEtPnByaXZhdGU7Cj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnRhc2s7Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqAgdGFzayA9IHRhc2tfc2VxX2dl
dF9uZXh0KGluZm8tPmNvbW1vbi5ucywgJmluZm8tPnRpZCwKPiA+IGZhbHNlKTsKPiA+ICvCoMKg
wqDCoMKgwqAgdGFzayA9IHRhc2tfc2VxX2dldF9uZXh0KCZpbmZvLT5jb21tb24sICZpbmZvLT50
aWQsIGZhbHNlKTsKPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghdGFzaykKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsKPiA+IAo+ID4gQEAgLTczLDcgKzkwLDcg
QEAgc3RhdGljIHZvaWQgKnRhc2tfc2VxX25leHQoc3RydWN0IHNlcV9maWxlICpzZXEsCj4gPiB2
b2lkICp2LCBsb2ZmX3QgKnBvcykKPiA+IMKgwqDCoMKgwqDCoMKgICsrKnBvczsKPiA+IMKgwqDC
oMKgwqDCoMKgICsraW5mby0+dGlkOwo+ID4gwqDCoMKgwqDCoMKgwqAgcHV0X3Rhc2tfc3RydWN0
KChzdHJ1Y3QgdGFza19zdHJ1Y3QgKil2KTsKPiA+IC3CoMKgwqDCoMKgwqAgdGFzayA9IHRhc2tf
c2VxX2dldF9uZXh0KGluZm8tPmNvbW1vbi5ucywgJmluZm8tPnRpZCwKPiA+IGZhbHNlKTsKPiA+
ICvCoMKgwqDCoMKgwqAgdGFzayA9IHRhc2tfc2VxX2dldF9uZXh0KCZpbmZvLT5jb21tb24sICZp
bmZvLT50aWQsIGZhbHNlKTsKPiA+IMKgwqDCoMKgwqDCoMKgIGlmICghdGFzaykKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsKPiA+IAo+ID4gQEAgLTExNyw2
ICsxMzQsNDggQEAgc3RhdGljIHZvaWQgdGFza19zZXFfc3RvcChzdHJ1Y3Qgc2VxX2ZpbGUKPiA+
ICpzZXEsIHZvaWQgKnYpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHV0X3Rh
c2tfc3RydWN0KChzdHJ1Y3QgdGFza19zdHJ1Y3QgKil2KTsKPiA+IMKgfQo+ID4gCj4gPiArc3Rh
dGljIGludCBicGZfaXRlcl9hdHRhY2hfdGFzayhzdHJ1Y3QgYnBmX3Byb2cgKnByb2csCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHVuaW9uIGJwZl9pdGVyX2xpbmtfaW5mbyAqbGluZm8sCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBicGZf
aXRlcl9hdXhfaW5mbyAqYXV4KQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50
IGZsYWdzOwo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgcGlkX25hbWVzcGFjZSAqbnM7Cj4gPiAr
wqDCoMKgwqDCoMKgIHN0cnVjdCBwaWQgKnBpZDsKPiA+ICvCoMKgwqDCoMKgwqAgcGlkX3QgdGdp
ZDsKPiAKPiBpdCBzZWVtcyBpdCB3b3VsZCBiZSBzaW1wbGVyIHRvIGZpcnN0IGNoZWNrIHRoYXQg
YXQgbW9zdCBvbmUgb2YKPiB0aWQvcGlkL3BpZF9mZCBpcyBzZXQgaW5zdGVhZCBvZiBtYWtpbmcg
c3VyZSB0aGF0IGF1eC0+dGFzay50eXBlCj4gd2Fzbid0IGFscmVhZHkgc2V0Lgo+IAo+IEhvdyBh
Ym91dAo+IAo+IGlmICghIWxpbmZvLT50YXNrLnRpZCArICEhbGluZm8tPnRhc2sucGlkICsgISFs
aW5mby0+dGFzay5waWRfZmQgPiAxKQo+IMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPiAKPiA/CgpB
Z3JlZQoKPiAKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgYXV4LT50YXNrLnR5cGUgPSBCUEZfVEFT
S19JVEVSX0FMTDsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGxpbmZvLT50YXNrLnRpZCAhPSAwKSB7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdXgtPnRhc2sudHlwZSA9IEJQRl9U
QVNLX0lURVJfVElEOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXV4LT50YXNr
LnBpZCA9IGxpbmZvLT50YXNrLnRpZDsKPiA+ICvCoMKgwqDCoMKgwqAgfQo+ID4gK8KgwqDCoMKg
wqDCoCBpZiAobGluZm8tPnRhc2sucGlkICE9IDApIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChhdXgtPnRhc2sudHlwZSAhPSBCUEZfVEFTS19JVEVSX0FMTCkKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZB
TDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF1eC0+dGFzay50eXBl
ID0gQlBGX1RBU0tfSVRFUl9UR0lEOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YXV4LT50YXNrLnBpZCA9IGxpbmZvLT50YXNrLnBpZDsKPiA+ICvCoMKgwqDCoMKgwqAgfQo+ID4g
K8KgwqDCoMKgwqDCoCBpZiAobGluZm8tPnRhc2sucGlkX2ZkICE9IDApIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhdXgtPnRhc2sudHlwZSAhPSBCUEZfVEFTS19JVEVS
X0FMTCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVJTlZBTDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF1
eC0+dGFzay50eXBlID0gQlBGX1RBU0tfSVRFUl9UR0lEOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbnMgPSB0YXNrX2FjdGl2ZV9waWRfbnMoY3VycmVudCk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoSVNfRVJSKG5zKSkKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihucyk7Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaWQgPSBwaWRmZF9nZXRfcGlkKGxp
bmZvLT50YXNrLnBpZF9mZCwgJmZsYWdzKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChJU19FUlIocGlkKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihwaWQpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdGdpZCA9IHBpZF9ucl9ucyhwaWQsIG5zKTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF1eC0+dGFzay5waWQgPSB0Z2lkOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcHV0X3BpZChwaWQpOwo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gK30KPiA+ICsKPiAKPiBbLi4uXQoK

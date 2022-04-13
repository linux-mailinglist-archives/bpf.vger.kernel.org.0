Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349714FFD6F
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 20:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiDMSIh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 14:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiDMSIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 14:08:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D042E4C79C
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 11:06:14 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23DHTI3w023038
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 11:06:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=G8wO4+mpuQTwAffcdGv/FVOEFqPKR6Hz10+umEnv2BQ=;
 b=BckCaf9SDHfBUz96fIlZkXGoz1W+uDvBXFo6G45a3Kbu2CblXt3zz4BPJrT2hj3o6m+9
 Lz3RRuvw2mlTtXXqmnukym6hInvAH5rKhswMjjNcg5FhKK3cxDUfBmVHlgrfIBR8rGYt
 mo0Yuym4Oj7XIFxGhUmxRyTXB28QjHedo/g= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fdx3ujnxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 11:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcPhWr52VzW2/hDjykmAZ+Ja3NWcKsC91e7YFiCWyVz9qIP2twlkyrQWXp0PlDFH2NqgQfAvAC/PTLU2dliPEkB3XOiUtdjvPrGa9anCQuMXuoq6vWdmDt8qwlpHGHcQclJvVCzXXNvvLCc8fnTezeXTWop+3aRz56nb9vZ9IQd/AUNx4rWhV248U06XtnkgRgUWGEzgRA9wmDumkNPdOQRL29FDN7LTOcZDb9ES8OWEXIDTZHmdsdwlyq05PJhIR4a3vTcLggKMKuX4ijoU3hULleJJnls1CuW4WIwC+KdFsuktO4enW6QRR1e++QDQUia5x1nGQE4wVqkdjoUYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8wO4+mpuQTwAffcdGv/FVOEFqPKR6Hz10+umEnv2BQ=;
 b=iu0Cl7UArgHnsPpC/Z5jup7ty0DXV7CPheHCE815qXoX+yOpoSZ4Pr5dZAXAWdbOiDInvCk0YFAK3YVbPPvx/eqVmAdCXql/8fC9i9TSUKnNKIw4PDikcSbTcyNXO8nUv5koNry+9CraXyuc2kHmXCVPaNuPUhR9nx+b0v2isAGJiqtwdduK9zWrfukhaPpWa14ud83+gSPxSIjvu3Xs9bu+HU05Vm2U1Mgk+M1HGlGzfv9r33SGitaeBv4DU3UDcAJs7fXrTavaQsbBkU8dCKjHHB/mP7w/wov3tpl6tvhwRhnSQLfDEn6nT99ErfVnQtHDFaOJGNGgoKSj94gz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BN8PR15MB3393.namprd15.prod.outlook.com (2603:10b6:408:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 18:06:10 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 18:06:10 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 2/5] bpf, x86: Create bpf_tramp_run_ctx on the
 caller thread's stack
Thread-Topic: [PATCH bpf-next v5 2/5] bpf, x86: Create bpf_tramp_run_ctx on
 the caller thread's stack
Thread-Index: AQHYTo5JrCPxE7TvK0ycERVZYyswsaztJtcAgAD+WoA=
Date:   Wed, 13 Apr 2022 18:06:10 +0000
Message-ID: <7630e457becb4f08f5d0d55f78506d55cb5fdfc1.camel@fb.com>
References: <20220412165555.4146407-1-kuifeng@fb.com>
         <20220412165555.4146407-3-kuifeng@fb.com>
         <CAEf4BzZiEAysLb41XNzvZXdHqr4ikgw8ggTbvd8KpsWvqtS5zg@mail.gmail.com>
In-Reply-To: <CAEf4BzZiEAysLb41XNzvZXdHqr4ikgw8ggTbvd8KpsWvqtS5zg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e21d4eb2-4feb-4cc2-3179-08da1d784a23
x-ms-traffictypediagnostic: BN8PR15MB3393:EE_
x-microsoft-antispam-prvs: <BN8PR15MB33934B08912B2DDCFD499848CCEC9@BN8PR15MB3393.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 94+ry+bUSqqi+EI0Hq9d4l6mITdskNKcQnCeMp5gvZkX+BppOe7VSXP1w3b6dC+VJRoiB5dLXhkYCAi4sFzJVYRAgfktRQKfMx9WuK6gB9B7aJNtVt19HDz0SoFakbT5LnccvIDmOm9h0oY4giHW9irfr2VqHwj1reqcKbFK2ESVRNYa/7RPf5uPftk59+nirOfuhl+z9eJRayYrV9Rt5xiv5mQt/Za0mJ7/KCnQp8TtmcFkV7KyVeNIONlqlea7OaMDhk2vxwR/xnYkzZS4GFMcrp2iWIB6IYVwxaX3aGdn5qAf8becAkZ/mGaVT3D8FwrGrePHptEf+COKGA4cVosSd0aqyp4uxF0bXqRtZXu2/GvolbtEOeUAlz1h0Y1LGABHodse6pgIOgLviVcBAvygJzL5al6p9wug6/7ynWwk+e15yhK+wUNj7AJCyoHKxg8psB67yH+vNuEHRUiEHlgzG3hbO800JC8O49V/mz2Oe1bLF5EZgWHiLM4RHoeonfQBTy07v1XZLhnhu/8ftnHbk3geqrP045dJ98l1gpa7v7PuzcO9cFDzhwEnCir2iaQfmFCri7TLutB/fCg+Ol7ygO0q+YZU6Oy6uUmaBHZMWE074IOawT6+w72kfucWOwOoMMdBzmNJfkjbF9XBXcEqF1/kR8VaoXZU49QANjzcluNU61kfd1Li6sTk3wQFdwYc75qOp5CLlogUfTxvmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(4326008)(2906002)(508600001)(53546011)(8936002)(6486002)(122000001)(38100700002)(71200400001)(38070700005)(2616005)(6512007)(83380400001)(5660300002)(8676002)(316002)(36756003)(186003)(66556008)(66476007)(54906003)(66446008)(66946007)(64756008)(6916009)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFFKMkxaSGs4VzRlbHdDTm5kNkpSdGxGZkJJOU45aHZFcWo5R0l2K2RlUGdM?=
 =?utf-8?B?ZjVzOGtDWGZNeVhYbVZ2MXhNZ1puRzZ4QktMSTZUSitjRUR0ZE1WOGZJVmdN?=
 =?utf-8?B?Y2w0N2U0TC9IUTVydFVqREJRM0lOZkFsT09iRWtUV05IL1ljSDhvVVJJbndW?=
 =?utf-8?B?emkyZVJkOTVWRjF4cXR1KzB4NHBJMit6d3ZnZXJIL3h3TDJNZTVxVkxrTFdN?=
 =?utf-8?B?MnBmTmc3bkFqcTBnaTNDdmF2bUk2a3pNOUYwQThiRktnM0lSMmEvVVl4amJj?=
 =?utf-8?B?L2RHZW5FclpJV21udFRld242cUJKTm1jNmNNdENxY1ppSDZjeEx1ZFZLUmha?=
 =?utf-8?B?S0liLzZ2Q1RqVHMxWllCNkJaa21vc2d2ZnpIbEx4Q095azN2aVNsdGVoRkdP?=
 =?utf-8?B?S0diQlo3ck1yKzI3Z0VDRGpjdVZ5b1VJTkJkZDRodHpZSTdVSmVzcy9NaVFH?=
 =?utf-8?B?M2pQSmVHYTRuOTc1RitDWURTMmZXOUFJcnlOZkduYWtRQjRGelY4OFBsd3pJ?=
 =?utf-8?B?UDhBMzU3SmxEYno2T3lOTlhVVzhKRnc3RmYveE5EK2ZaS2MvQ1RBdkN5U3R1?=
 =?utf-8?B?cklCczRTdFVuT0NXNWd2WExwK2d5WlBqUVIxUnkxdlV0OUt5SExaNWh1RmVw?=
 =?utf-8?B?d3p3cjlia2psbk5jZGtzbXRvYm5aZDJyT2pmaUp4THBselk0em1OdThyUTVW?=
 =?utf-8?B?eFM1TG1VeHF1YzNGUTFPU2Z3dU9CUnZyZWZiQjdEd0RoWFdNTC9ON3EyTlZQ?=
 =?utf-8?B?WlIvamdaOGNOa0w0RDJoaUIrOVJvMU1OWHg4N3JkU1FvNnlhOElRKzdDMzBu?=
 =?utf-8?B?RnlaZlo5UDhyQVorSHJxNC9EYXRBUXlMSXo5SGxxcVJkVUFNaXp4Vko1YVpS?=
 =?utf-8?B?R2o1WHZiQWJVaXROZzdIa3lQVVZmbUVaOTVldlVFQ1p0QjNkb0xlc3I5TTk2?=
 =?utf-8?B?U1d5cjlVK29lOHVGbVo1amRIOUpVNzR5WHh0UFV5QktQbGRpeEo1MzhGSXJR?=
 =?utf-8?B?Q0FUMWxpc3pVOGZ0L1BVK1JUbFZTVXNIU3lJMVhNaWtlaG5WK0hzbjIvQ28w?=
 =?utf-8?B?K05RdTZVWkJaUGNtN2lpdW50dWNjSjNVNlQybUxFMloyNXVoT2p4eWNVM29W?=
 =?utf-8?B?ZTNza0RMYTR1a1NyOXpYbXcvZ3oxY3l3WmJ1bW1PR25tak5NcTJvMXpxU3My?=
 =?utf-8?B?RkNqVUQxQkpPb2gxWUxyVjd1NnFLak5FaEVFZFpRcXVaTkt4SmFoaXFKQ3ps?=
 =?utf-8?B?WnI2SEplWGlSZk1WdTNFTlNJNUR0cVB6ckQ2Y1dxRmd4bVErTDFueUtBR1Bo?=
 =?utf-8?B?UkpodUhuS1F2bzJDN3JZTXluM1dXWloyS2JoZHJtVktGYVpZTm1BZndhTDZW?=
 =?utf-8?B?R09aU2dUc0FWcnpkNERHTTNIdUZXT2gyLzk1QzNmN0RBMy9FMEVOUHgxZy9O?=
 =?utf-8?B?VE9QOVlRNUg4ajJyWWpIY2JtUGxTTEdHM2xEWUU2c3pWaDFiZWhWOTJCT0Rp?=
 =?utf-8?B?R1VkQnoyMlczSHZYTGhMVE9NbU9wbmJsS2JvUFE1a3cvaUdNY0c2T3NiWHo4?=
 =?utf-8?B?UUg1VU93VDA2Y1J3cHh5Yjd1eWVWcGhDYkZObnYrZnZSS0xNZHhwQ0V6eUQz?=
 =?utf-8?B?TVYxbCtoQ1FzSVBmRW5xdDFYU0FES0JhMHk3Ri9LMFkvcEpyR1dnclFYMlox?=
 =?utf-8?B?UkZRNytiTkg3aDEzemVpM3ZzRzRoVXhQdnVsVjZ4bDUzZk1qbWlnUUw3KzVz?=
 =?utf-8?B?cGdBQ3JnNlMxdkVyUGZUN2lTOGw4a1M4QmNiUEJRcUVNOEs2VXFQeGRGOENY?=
 =?utf-8?B?K3dkZk4vNVNmWk50Qy9NcUhheXVLcFpmeTk2WmFNWEorTlVJNldoOEdFQU1P?=
 =?utf-8?B?UEhFMURrQWtST1hldXN1akRFRFBMNitFRHU0b3hYODcveGgwdWpEazRtWGc2?=
 =?utf-8?B?cFozV1lIQXpQd0NTUjdXcUgzazVZR0pxZzhIL2M2L3dqU2Q5Qzdib2pIVWE5?=
 =?utf-8?B?YW8yYzA2YUtDZ2VKbnNQY0p6RkJ2TjFmMXM5UWVuUXpJUytGTG9ibDh6bi96?=
 =?utf-8?B?MWJFSlZiS3pvOWh0OWIxZ3JmaWptVVFTR2VoSnBLWTV6QktnWG5DY2xGYnRk?=
 =?utf-8?B?T1NxakN0UFI1K1pyT2V4bjMrditLdEV2bGkxc3M0d0dMTi9tcFY2Mm1QSnAz?=
 =?utf-8?B?a2FQSVNJbUpYMGlXVGFvV2sxbzk0Rmd1UDdZMjJCSGtqUTIxaitna0QxT3pp?=
 =?utf-8?B?MXQ2T29zRnpaSklMM2xnQ2tYckw1TjNFc2gxUG9XMVdKV2E4NkxWbmJyNVlR?=
 =?utf-8?B?ejc2UlNPVG1nbHE3aTdsVS93VzZoSDlzQzhJV2NucmwvQ01MYitkUzVlQW53?=
 =?utf-8?Q?VqN/zDqfnu5aTHJLxuThdb3BfH9hflMLOwm9o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28AF797F4DC3B1429B9439456D49EDF3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21d4eb2-4feb-4cc2-3179-08da1d784a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 18:06:10.2041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBqzjwxespL3B/F145QfUIrUPuRs0VJS62wxpOYVIzgcnQ/6TumEfbW0Vl2jrp2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3393
X-Proofpoint-ORIG-GUID: n6JrwxDM3aVrUdW_zxrLGD_egQvDu8Yc
X-Proofpoint-GUID: n6JrwxDM3aVrUdW_zxrLGD_egQvDu8Yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_03,2022-04-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDE5OjU1IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgOTo1NiBBTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToKPiA+IAo+ID4gQlBGIHRyYW1wb2xpbmVzIHdpbGwgY3JlYXRlIGEgYnBm
X3RyYW1wX3J1bl9jdHgsIGEgYnBmX3J1bl9jdHgsIG9uCj4gPiBzdGFja3MgYW5kIHNldC9yZXNl
dCB0aGUgY3VycmVudCBicGZfcnVuX2N0eCBiZWZvcmUvYWZ0ZXIgY2FsbGluZyBhCj4gPiBicGZf
cHJvZy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNv
bT4KPiA+IC0tLQo+ID4gwqBhcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMgfCA1NQo+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gwqBpbmNsdWRlL2xpbnV4L2Jw
Zi5owqDCoMKgwqDCoMKgwqDCoCB8IDE3ICsrKysrKysrKy0tLQo+ID4gwqBrZXJuZWwvYnBmL3N5
c2NhbGwuY8KgwqDCoMKgwqDCoMKgIHzCoCA3ICsrKy0tCj4gPiDCoGtlcm5lbC9icGYvdHJhbXBv
bGluZS5jwqDCoMKgwqAgfCAyMCArKysrKysrKysrKy0tLQo+ID4gwqA0IGZpbGVzIGNoYW5nZWQs
IDg5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jCj4gPiBiL2FyY2gveDg2L25ldC9icGZfaml0X2Nv
bXAuYwo+ID4gaW5kZXggNGRjYzBiMWFjNzcwLi4wZjUyMWJlNjhmN2IgMTAwNjQ0Cj4gPiAtLS0g
YS9hcmNoL3g4Ni9uZXQvYnBmX2ppdF9jb21wLmMKPiA+ICsrKyBiL2FyY2gveDg2L25ldC9icGZf
aml0X2NvbXAuYwo+ID4gQEAgLTE3NjYsMTAgKzE3NjYsMjYgQEAgc3RhdGljIGludCBpbnZva2Vf
YnBmX3Byb2coY29uc3Qgc3RydWN0Cj4gPiBidGZfZnVuY19tb2RlbCAqbSwgdTggKipwcHJvZywK
PiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqAgdTggKnByb2cgPSAqcHByb2c7Cj4gPiDCoMKgwqDC
oMKgwqDCoCB1OCAqam1wX2luc247Cj4gPiArwqDCoMKgwqDCoMKgIGludCBjdHhfY29va2llX29m
ZiA9IG9mZnNldG9mKHN0cnVjdCBicGZfdHJhbXBfcnVuX2N0eCwKPiA+IGJwZl9jb29raWUpOwo+
ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGJwZl9wcm9nICpwID0gbC0+bGluay5wcm9nOwo+ID4g
Cj4gPiArwqDCoMKgwqDCoMKgIC8qIG1vdiByZGksIDAgKi8KPiA+ICvCoMKgwqDCoMKgwqAgZW1p
dF9tb3ZfaW1tNjQoJnByb2csIEJQRl9SRUdfMSwgMCwgMCk7Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgIC8qIFByZXBhcmUgc3RydWN0IGJwZl90cmFtcF9ydW5fY3R4Lgo+ID4gK8KgwqDCoMKgwqDC
oMKgICoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGJwZl90cmFtcF9ydW5fY3R4IGlzIGFscmVhZHkg
cHJlc2VydmVkIGJ5Cj4gPiArwqDCoMKgwqDCoMKgwqAgKiBhcmNoX3ByZXBhcmVfYnBmX3RyYW1w
b2xpbmUoKS4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBtb3Yg
UVdPUkQgUFRSIFtyc3AgKyBjdHhfY29va2llX29mZl0sIHJkaQo+ID4gK8KgwqDCoMKgwqDCoMKg
ICovCj4gPiArwqDCoMKgwqDCoMKgIEVNSVQ0KDB4NDgsIDB4ODksIDB4N0MsIDB4MjQpOyBFTUlU
MShjdHhfY29va2llX29mZik7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCAvKiBhcmcxOiBtb3Yg
cmRpLCBwcm9nc1tpXSAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgZW1pdF9tb3ZfaW1tNjQoJnByb2cs
IEJQRl9SRUdfMSwgKGxvbmcpIHAgPj4gMzIsICh1MzIpCj4gPiAobG9uZykgcCk7Cj4gPiArwqDC
oMKgwqDCoMKgIC8qIGFyZzI6IG1vdiByc2ksIHJzcCAoc3RydWN0IGJwZl9ydW5fY3R4ICopICov
Cj4gPiArwqDCoMKgwqDCoMKgIEVNSVQzKDB4NDgsIDB4ODksIDB4RTYpOwo+ID4gKwo+ID4gwqDC
oMKgwqDCoMKgwqAgaWYgKGVtaXRfY2FsbCgmcHJvZywKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5hdXgtPnNsZWVwYWJsZSA/Cj4gPiBfX2JwZl9wcm9n
X2VudGVyX3NsZWVwYWJsZSA6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgX19icGZfcHJvZ19lbnRlciwgcHJvZykpCj4gPiBAQCAtMTgxNSw2ICsxODMxLDgg
QEAgc3RhdGljIGludCBpbnZva2VfYnBmX3Byb2coY29uc3Qgc3RydWN0Cj4gPiBidGZfZnVuY19t
b2RlbCAqbSwgdTggKipwcHJvZywKPiA+IMKgwqDCoMKgwqDCoMKgIGVtaXRfbW92X2ltbTY0KCZw
cm9nLCBCUEZfUkVHXzEsIChsb25nKSBwID4+IDMyLCAodTMyKQo+ID4gKGxvbmcpIHApOwo+ID4g
wqDCoMKgwqDCoMKgwqAgLyogYXJnMjogbW92IHJzaSwgcmJ4IDwtIHN0YXJ0IHRpbWUgaW4gbnNl
YyAqLwo+ID4gwqDCoMKgwqDCoMKgwqAgZW1pdF9tb3ZfcmVnKCZwcm9nLCB0cnVlLCBCUEZfUkVH
XzIsIEJQRl9SRUdfNik7Cj4gPiArwqDCoMKgwqDCoMKgIC8qIGFyZzM6IG1vdiByZHgsIHJzcCAo
c3RydWN0IGJwZl9ydW5fY3R4ICopICovCj4gPiArwqDCoMKgwqDCoMKgIEVNSVQzKDB4NDgsIDB4
ODksIDB4RTIpOwo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGVtaXRfY2FsbCgmcHJvZywKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwLT5hdXgtPnNsZWVwYWJs
ZSA/IF9fYnBmX3Byb2dfZXhpdF9zbGVlcGFibGUKPiA+IDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2JwZl9wcm9nX2V4aXQsIHByb2cpKQo+ID4gQEAg
LTIwNzksNiArMjA5NywxNiBAQCBpbnQgYXJjaF9wcmVwYXJlX2JwZl90cmFtcG9saW5lKHN0cnVj
dAo+ID4gYnBmX3RyYW1wX2ltYWdlICppbSwgdm9pZCAqaW1hZ2UsIHZvaWQgKmkKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiDCoMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+
ICvCoMKgwqDCoMKgwqAgaWYgKG5yX2FyZ3MgPCAzICYmIChmZW50cnktPm5yX2xpbmtzIHx8IGZl
eGl0LT5ucl9saW5rcyB8fAo+ID4gZm1vZF9yZXQtPm5yX2xpbmtzKSkKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEVNSVQxKDB4NTIpO8KgwqDCoCAvKiBwdXNoIHJkeCAqLwo+IAo+
IHRoaXMgbnJfYXJncyA8IDMgY29uZGl0aW9uIGlzIG5ldywgbWF5YmUgbGVhdmUgYSBjb21tZW50
IG9uIHdoeSB3ZQo+IG5lZWQgdGhpcz8gQWxzbyBpbnN0ZWFkIG9mIHJlcGVhdGluZyB0aGlzIHdo
b2xlIChmZW50cnktPm5yX2xpbmtzIHx8Cj4gLi4uIHx8IC4uLikgY2hlY2ssIHdoeSBub3QgbW92
ZSBpZiAobnJfYXJncyA8IDMpIGluc2lkZSB0aGUgaWYgcmlnaHQKPiBiZWxvdz8KPiAKPiA+ICsK
PiA+ICvCoMKgwqDCoMKgwqAgaWYgKGZlbnRyeS0+bnJfbGlua3MgfHwgZmV4aXQtPm5yX2xpbmtz
IHx8IGZtb2RfcmV0LQo+ID4gPm5yX2xpbmtzKSB7Cj4gCj4gaWYgKG5yX2FyZ3MgPiAzKSBoZXJl
Pwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogUHJlcGFyZSBzdHJ1Y3Qg
YnBmX3RyYW1wX3J1bl9jdHguCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
c3ViIHJzcCwgc2l6ZW9mKHN0cnVjdCBicGZfdHJhbXBfcnVuX2N0eCkKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEVNSVQ0KDB4NDgsIDB4ODMsIDB4RUMsIHNpemVvZihzdHJ1Y3QKPiA+IGJwZl90cmFtcF9ydW5f
Y3R4KSk7Cj4gPiArwqDCoMKgwqDCoMKgIH0KPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgIGlmIChm
ZW50cnktPm5yX2xpbmtzKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChp
bnZva2VfYnBmKG0sICZwcm9nLCBmZW50cnksIHJlZ3Nfb2ZmLAo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZsYWdzICYgQlBG
X1RSQU1QX0ZfUkVUX0ZFTlRSWV9SRVQpKQo+IAo+IFsuLi5dCj4gCj4gPiDCoMKgwqDCoMKgwqDC
oCBpZiAoZm1vZF9yZXQtPm5yX2xpbmtzKSB7Cj4gPiBAQCAtMjEzMyw2ICsyMTc5LDE1IEBAIGlu
dCBhcmNoX3ByZXBhcmVfYnBmX3RyYW1wb2xpbmUoc3RydWN0Cj4gPiBicGZfdHJhbXBfaW1hZ2Ug
KmltLCB2b2lkICppbWFnZSwgdm9pZCAqaQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXA7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfQo+ID4gCj4gPiArwqDCoMKgwqDCoMKgIC8qIHBvcCBzdHJ1Y3QgYnBmX3Ry
YW1wX3J1bl9jdHgKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGFkZCByc3AsIHNpemVvZihzdHJ1Y3Qg
YnBmX3RyYW1wX3J1bl9jdHgpCj4gPiArwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKg
wqAgaWYgKGZlbnRyeS0+bnJfbGlua3MgfHwgZmV4aXQtPm5yX2xpbmtzIHx8IGZtb2RfcmV0LQo+
ID4gPm5yX2xpbmtzKQo+IAo+IHdlbGwsIGFjdHVhbGx5LCBjYW4gaXQgZXZlciBiZSB0aGF0IHRo
aXMgY29uZGl0aW9uIGRvZXNuJ3QgaG9sZD8gVGhhdAo+IHdvdWxkIG1lYW4gd2UgYXJlIGdlbmVy
YXRpbmcgZW1wdHkgdHJhbXBvbGluZSBmb3Igc29tZSByZWFzb24sIG5vPyBEbwo+IHdlIGRvIHRo
YXQ/IENoZWNraW5nIGJwZl90cmFtcG9saW5lX3VwZGF0ZSgpIGFuZAo+IGJwZl9zdHJ1Y3Rfb3Bz
X3ByZXBhcmVfdHJhbXBvbGluZSgpIGRvZXNuJ3Qgc2VlbSBsaWtlIHdlIGV2ZXIgZG8KPiB0aGlz
Lgo+IFNvIHNlZW1zIGxpa2UgYWxsIHRoZXNlIGNoZWNrcyBjYW4gYmUgZHJvcHBlZD8KCllvdSBh
cmUgcmlnaHQuICBJIGhhZCBhZGRlZCB0aGlzIGNoZWNrIGZvciBkb2luZyB0aGUgZm9sbG93aW5n
IGxpbmUKb25seSBmb3Igc29tZSBjYXNlcywgYW5kIGRpZG4ndCBhd2FyZSB0aGUgY2hlY2sgaXMg
bm8gbW9yZSB1c2VmdWwgYWZ0ZXIKY2hhbmdpbmcgdGhlIHdheSBvZiBkb2luZyBpdC4KCgo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRU1JVDQoMHg0OCwgMHg4MywgMHhDNCwgc2l6
ZW9mKHN0cnVjdAo+ID4gYnBmX3RyYW1wX3J1bl9jdHgpKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqAgaWYgKG5yX2FyZ3MgPCAzICYmIChmZW50cnktPm5yX2xpbmtzIHx8IGZleGl0LT5ucl9saW5r
cyB8fAo+ID4gZm1vZF9yZXQtPm5yX2xpbmtzKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEVNSVQxKDB4NUEpOyAvKiBwb3AgcmR4ICovCj4gCj4gc2FtZSwgbW92ZSBpdCBpbnNp
ZGUgaWYgYWJvdmU/Cj4gCj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoZmxhZ3MgJiBCUEZf
VFJBTVBfRl9SRVNUT1JFX1JFR1MpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmVzdG9yZV9yZWdzKG0sICZwcm9nLCBucl9hcmdzLCByZWdzX29mZik7Cj4gPiAKPiAKPiBbLi4u
XQoK

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19B7582038
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiG0GjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 02:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiG0GjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 02:39:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9542A431
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:39:13 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QNDFV5019401
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:39:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GdDJWbCI7AF05JNEvK7iHw8bdv51UN02T2YLev/lTrk=;
 b=e6KkLufJ+FCeXc/gBdnlarKPM15KHuO8ePMOhoGj9RTwZyxZVWlYO9jiioo6X8RILUaP
 otbURaTPASq2bpYtEk/h5CSWRwfG+mWlXFENz0UQdi13vYMFA3C9yEQq/c53A6wkomAP
 cbChU9o93JxM2DGhZtHNwTkP8k3rBdA2XnM= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hhxbwuwpj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 23:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsAJg82MrWlevTXwTJ0i43rzkU4OiJZfpuLgrTRqq2yCRhxzmzFixBJcech3IMW/mR4BZRqhpDcZS0ZKuDitSRBO1ZMceqz5q84t9/yxUBJk9JOOn+I4IqMyAK22HEqecBKI3rdatav89THoUwJeWMXrKB9ar7mQql3opX8bv4vXleSRxflp11E/n3Jq5OyEQ1kAwVLUJKSu59t8j44W2QVXB5aFw8c05wk90HzJg3/7GcYXjz0oezxkKARFbyuP0c/qnAMrEgVSodZi4/11by3S64KXjov1Gr7F0zdl9mQ50j+qtXlVGb/PJsGNy5t6MmXBkmmrK7pi6rIoLe+w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdDJWbCI7AF05JNEvK7iHw8bdv51UN02T2YLev/lTrk=;
 b=LLtLVXLBASa1nxA1Ej/2HuPhO9Qg45YM2nmb+yZvzo49UefsA6bgPMVt6/XZJsTJDa6OggQp9iNzFcAlX9I7G0/aLx7qjP3OVS6Ozqp/NoyuUj9KLyqz3d6CIYcNVN+W7vhA4jAkBKGSET8gLpG6SrGW8s+MZTHJ8Plac6U2ULuKfFdgd/UA5lgChaLSn1yNa/ZT5r5jxaYl0iLq2SoBnGq8KVffgjDQjoY1rFS/Qlyh02ReA+111CvSfz9/ao7gQ8Fa6GjtB+3/fssQP0lWGZWTPAV6i2P4hh1ufd8+H92eheRobQYd/eR+qZVmSRVCjnKsB/IhJ0VwwpTY/wyonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MW4PR15MB4748.namprd15.prod.outlook.com (2603:10b6:303:10d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Wed, 27 Jul
 2022 06:39:10 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::cdef:5d3a:710a:4959]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::cdef:5d3a:710a:4959%6]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 06:39:10 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "olsajiri@gmail.com" <olsajiri@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYoK8StG1Y6n29KUSEV/VSsAjsP62QkM6AgAASYQCAASKYAA==
Date:   Wed, 27 Jul 2022 06:39:10 +0000
Message-ID: <31968bfd1f694439c2354f5ef3bd5117c2893dbd.camel@fb.com>
References: <20220726051713.840431-1-kuifeng@fb.com>
         <20220726051713.840431-2-kuifeng@fb.com> <Yt/aXYiVmGKP282Q@krava>
         <Yt/pyDUuvS1rwlpc@krava>
In-Reply-To: <Yt/pyDUuvS1rwlpc@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a48addfa-d575-4286-4ac8-08da6f9ab656
x-ms-traffictypediagnostic: MW4PR15MB4748:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8p/l88ibYqL6d0cIThFH80nCCuQCEeyFHYWaguFDURJYDWPEirxQL7nZOzlJ7sJEWGaqRkc6EDzrHfA9PcBl6+cI8pAwR1YR6MuyUAE7ErkIkGFQ1JyCfBB0Fz0zjs71b0vsXXrspaPDUwWR1Xqb7JwaVGw6NiY/zgudp9/Fl+d9W+wEm43RfHs234PRc1u556tcvP4JUsBOSlfaT6Txqk3tHtwTyTouWpnZVe+jBRmyVWZcGQYb8Day8qepT8pQd5NvS1t+gvD2amUNguzXtqCdLeppMnOJqJ9LJjydLEKE0XDHgVLNWeLHgSwPldDZxeCazg0hbG/Iq2wLYbUhlvjH9pM7Uvt2G8vThKtOk+G6vZb1ZAQfkaE34RPmsnwWpNgbmsp6xZ6D4j63E9UzLUpPstEkdPExhDIWgeWkl6QwPGKrVZL+3vJn83/9vtmCvsFJAGDV7SnULVAjcLc0YrOZiLnzLKcCsgg4Hr3ihcgm4I3vhdIy5iJtJPt84+exs+a1O3+9xLvDfH4BdhfwzSCbpm5N7zDurNUufR8cVrOgaoeCMKb8vlxIz7YR7b4nIxEkdhH5p7dnPGx2OkCpjf/Kl1F1fgw0GnrWhcbtiPAIuWoV/lyYEH/JOous1EDfFUL0OcvuuKrnpRTrIRYIL2zGIXNfNHai8u4VV5QkQ5yv5gB0CvP/2l+bH/sF8lFF7t/O2Ypj7uqn47l79ZzpUQVJz4D8vBfucEeYuLKMgOlywwhl0ihFgX3JPP7Z4rWkcUcjsp5JV/A6gD1FcrjKcpi+jc/HKJXgfsmxX3Mw47Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(316002)(6916009)(41300700001)(6486002)(54906003)(478600001)(71200400001)(4326008)(8676002)(5660300002)(76116006)(66446008)(66946007)(64756008)(66556008)(91956017)(66476007)(36756003)(122000001)(2906002)(2616005)(38070700005)(86362001)(38100700002)(186003)(6506007)(6512007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Si9WMlZJZHJyNlRmUXRjZFlBQU9BdmZFNU4yVnJjV3E2UkhNZGR2djdtSm1n?=
 =?utf-8?B?emc1MjVuOWV4Z2tqTWRHUnFaK2k5ck5SdVFXNlJ2NjJacjV2b091WVo2ZlZH?=
 =?utf-8?B?cUZTVkVxQUdkQ3NDamZ5TXpTMkVycUJvYXl0aXY4ZzR6MWdkT0xPRHhUYndX?=
 =?utf-8?B?WXdpM2o2R1pHSm1xczlXV0E0OFdKZjhFVVdpWkozWlJMSWg4b1NEaWVSYWx2?=
 =?utf-8?B?MEJMRUw1N1h0RElYMDRxTUFyd2hUZVRZOVlwQlB6bUJGczhrQU10Uk15dTcw?=
 =?utf-8?B?bEJhWVYyTXVTdE1adjNDVGtrQUpoTWZlVzJxMmFxSHd4SFNuOTByRkVTeXZr?=
 =?utf-8?B?Q3prVHcrMFpmMkdQSDZwVXNlTzZmOTVLRzN2bm9RUHd6aGt0anBva2hXUVpT?=
 =?utf-8?B?aU1ub3ZWT2dtWmE3OVAxaTFtaW1SVUczSjZrZUZ2REQ2YkR0YU01T3hXZGpi?=
 =?utf-8?B?d3FYQ0xQVEd0anRvTWRBaXVZalN4L291LzZHUjhXNHJrWnNQTkMyZ3A0dnVt?=
 =?utf-8?B?enJLOWFwMWVlUkh6cnZwRGdMMGh6TGxzdXUzU0dvQjh1Ymh0OER1UUVGYy9T?=
 =?utf-8?B?akFIZzdhOENVRWxDaG5IQi9QdGlYaTBFUmN0ZER5V0tiTkdNa2lueWhzWEV0?=
 =?utf-8?B?UlJtR1g3cXZqcUdsSG52WVB2ZE1qNnFtdkRNNzhIbWxYVlNIYU9mR25VS0px?=
 =?utf-8?B?cWZQS3hoTDJpdkQ5WERSUVNVOVNBU2xXMVQ4MXQxclZnY3JGT2FSYTdmeUVz?=
 =?utf-8?B?VVBVZXc4U1J0M0VKRklaeWU2YWYzWDJxMWZtT0l1bTVMV0dSQ2VFeFh4QWNN?=
 =?utf-8?B?Y3g5QUZlTlZHblNiYkJ5MzZBMGZCSEltd2hZWUkvbDZPZDVXMGlyNzYwWVJT?=
 =?utf-8?B?eUQ2YVVYOUk5eVNoQVZUclRoWVF4aUJ3UlZVdHo3eGkrTnZRVEVWRng2Y2hU?=
 =?utf-8?B?ajVSWkpmTElMbkZreDE1eUw1QUFpdVRCVE1iWHpUOTRiT085UVNmR0JLbkpz?=
 =?utf-8?B?L0lkZkRqdk53WVk3NEhhR2k3T1pMMVZYR3I3cXkwS3dNWkw4VHYyaHI1UHJM?=
 =?utf-8?B?NnQ5ZVVINXVjYmhSRmtQRytIS1hLQjI4YWpLSDQraDh5K1RqYkxnY2JHK3lY?=
 =?utf-8?B?TVYybUdSQXY1ZDJlalRmR0h5WGJyVHd1MXZaRE9SU3gvTXZtZ25zL3RNQ0Iw?=
 =?utf-8?B?RXdCYVpCSWxIajFvY1Foa1hYbE9pc0Q4NGpvOXBlenNKUUtGeUJWcUJ0NUdi?=
 =?utf-8?B?Y3JPbU1xbHJCVDY0QWo0MzBqcXpGQ28vK1V1bVAvYzhDdjNndTl3ZGFBYjhp?=
 =?utf-8?B?NmxhbmlkODJtRTRYNHFYL3F3c2Q3QUtqSUFXb3d6Y2pVMVFkejR6TFdXUVFs?=
 =?utf-8?B?MXBqVEF1MTFZR3EwT2owdWtjZ0J0b3YxZ1VyS2FkTi9BbWpJZlZpQ01OdUxG?=
 =?utf-8?B?SGhaK1dWd21CSVFxZzlqdHVsQlk0cG15V0FxOHVkb2ZoYkxtM25xTjVBRGk4?=
 =?utf-8?B?NGZhSEN2aFlvUzY0b0VudGpvZzAxSkIrT2FJcGFnYlZvTnNwajhuTFNXNkxq?=
 =?utf-8?B?QktlSmxoc1Jqak5xMzN6TmYwNHFWemhKdWVpOVhPVU0rUGl0Z2FUQzUyZnFD?=
 =?utf-8?B?c2VpMXZzdm9DQjFlS21temZva0xzOXMvWHdwT3djQldNL0lIaUJyR0dBeUx2?=
 =?utf-8?B?bzlKRkV2dmZSTXc4NzRFL0NzeDNBWjIwWUdma3BGVmE1dEE3OUNJMXpCQjRH?=
 =?utf-8?B?R3lULzRCNWh3c2poZWpGdmRvYloxY2xxYkEzV0Y5clFmc04xclhmczgzY0xH?=
 =?utf-8?B?SllUM2wrUk12RkI3QVJ1ajQzcHVTc3Q2RnFnRmhFU2IvRjZBaUZjajNsek5T?=
 =?utf-8?B?WWtqc2JhVjNyYjBrQm5OVVhvZlJVbHppc0JSV0U5M3ZCak4zRHNJeGZ0MGhN?=
 =?utf-8?B?ZEFDRnFRbThmVTRJZmVKcUF2bHZmd2ZNZGdydkZTaW90cmgreGlTcFd2MkYv?=
 =?utf-8?B?MmtqQjgrcU9WOFYybE4vODg4NWsrYkovbEFvK3FMQkNFZHFZRHlZbkRIZ1Z2?=
 =?utf-8?B?UlFqL0xkYWFoaURZdnlKZlRqQUt6RkljWHZWS2lSN1cyWjlSS0tsMkJzU1Uw?=
 =?utf-8?B?RmhERFlIUFRvdThrNWJoUDVaN2tBVW1hSVZzMCthd0tVTHlQT3lCRG1yT1NM?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B058504BBC58A44F8FDC9951FB4CC4CF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48addfa-d575-4286-4ac8-08da6f9ab656
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 06:39:10.0789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExWV2QObegTiwiLUhFxye+jespTmcbLk1FwEkUjVfeN3xS3M7d2epnsarCKHaqws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4748
X-Proofpoint-GUID: K5DXZ9nuggwo1JGqS3envmmPWof_dUxA
X-Proofpoint-ORIG-GUID: K5DXZ9nuggwo1JGqS3envmmPWof_dUxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA3LTI2IGF0IDE1OjE5ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6Cj4gT24g
VHVlLCBKdWwgMjYsIDIwMjIgYXQgMDI6MTM6MTdQTSArMDIwMCwgSmlyaSBPbHNhIHdyb3RlOgo+
ID4gPiAtc3RhdGljIHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFza19zZXFfZ2V0X25leHQoc3RydWN0
Cj4gPiA+IHBpZF9uYW1lc3BhY2UgKm5zLAo+ID4gPiArc3RhdGljIHN0cnVjdCB0YXNrX3N0cnVj
dCAqdGFza19zZXFfZ2V0X25leHQoc3RydWN0Cj4gPiA+IGJwZl9pdGVyX3NlcV90YXNrX2NvbW1v
biAqY29tbW9uLAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiAqdGlk
LAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wKPiA+ID4gc2tpcF9p
Zl9kdXBfZmlsZXMpCj4gPiA+IMKgewo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHRhc2tf
c3RydWN0ICp0YXNrID0gTlVMTDsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwaWQgKnBp
ZDsKPiA+ID4gwqAKPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKGNvbW1vbi0+dHlwZSA9PSBCUEZf
VEFTS19JVEVSX1RJRCkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KCp0aWQpCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIE5VTEw7Cj4gPiAKPiA+IEkgdGVzdGVkIGFuZCB0aGlzIGNvbmRpdGlvbiBicmVh
a3MgaXQgZm9yIGZkIGl0ZXJhdGlvbnMsIG5vdCBzdXJlCj4gPiBhYm91dAo+ID4gdGhlIHRhc2sg
YW5kIHZtYSwgYmVjYXVzZSB0aGV5IHNoYXJlIHRoaXMgZnVuY3Rpb24KPiA+IAo+ID4gaWYgYnBm
X3NlcV9yZWFkIGlzIGNhbGxlZCB3aXRoIHNtYWxsIGJ1ZmZlciB0aGVyZSB3aWxsIGJlIG11bHRp
cGxlCj4gPiBjYWxscwo+ID4gdG8gdGFza19maWxlX3NlcV9nZXRfbmV4dCBhbmQgc2Vjb25kIG9u
ZSB3aWxsIHN0b3AgaW4gaGVyZSwgZXZlbiBpZgo+ID4gdGhlcmUKPiA+IGFyZSBtb3JlIGZpbGVz
IHRvIGJlIGRpc3BsYXllZCBmb3IgdGhlIHRhc2sgaW4gZmlsdGVyCj4gCj4gSSBtZWFuIHRoZXJl
IHdpbGwgYmUgbXVsdGlwbGUgY2FsbHMgb2YgZm9sbG93aW5nIHNlcXVlbmNlOgo+IAo+IMKgIGJw
Zl9zZXFfcmVhZAo+IMKgwqDCoCB0YXNrX2ZpbGVfc2VxX3N0YXJ0Cj4gwqDCoMKgwqDCoCB0YXNr
X3NlcV9nZXRfbmV4dAo+IAo+IGFuZCAybmQgb25lIHdpbGwgcmV0dXJuIE5VTEwgaW4gdGFza19z
ZXFfZ2V0X25leHQsCj4gYmVjYXVzZSBpbmZvLT50aWQgaXMgYWxyZWFkeSBzZXQKCk9rISAgSSBn
b3QgeW91ciBwb2ludC4gIEkgd2lsbCBmaXggaXQgQVNBUC4KCgoK

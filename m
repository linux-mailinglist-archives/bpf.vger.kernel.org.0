Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C6E40BF17
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 07:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhIOFB7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 01:01:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27924 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhIOFB5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 01:01:57 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18F3mKq2025706;
        Tue, 14 Sep 2021 22:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FSVBAItEQFceedQlIfnQXVXrgbNFVsZYn4oyeWyLJFc=;
 b=rKiz/tSYTa+rOZCK5SsZsEyDB6GBRFi1lglM2eyJzwY0hEwMJl00kF2ER8xAuqo6GtjN
 4/dRWnFB0as/JM5A8F+M//slLUubJqhT6TCs76Xj5pC66o/TACaW5K4vzlVAeg58ByMS
 Cnp1T60I74vrHOpJv1gvPzz8dx4z0I1oKN4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b398a89gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 22:00:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 22:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR8fPY4yl3Y2xsje8wCjup4D0HapZtiIqQvZ4ZR01aWUsE2YVk0n4nEXT42tzs3i+xwNbNTDNVPfqX/vDrSg5hdD+2ndjQJX0Sbh5FxVcz9esj6eaeSABc26bvY+p+aMwA+HmlwAOlgSl6GX1g0AYHtEaWoB0Tv43fNWkt5t0sBSp4s4PNSum8d5dOsnjUDVvtSDwq7Ar8WReYY70rk02xBgiBHJOYDuKOQfxgCB4AjlWOHcjihKvq9uIM+Kb6YmvxPuhrer422MqmFlccrdYN5aNORtsY7NDwqcTKRzQZ6+X7F0UmWmpr191/KafeSxlxHGXg8tqMeJ91TTIqDSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FXJ7UoO7AgAX1RTfPc+jiVIU4tSSygssLzBkAoyCQng=;
 b=N2YC+dphzXJ7R08cT02YsQ/FERbgbVycjNEgVqmoZqxy8GQVe32RF5B6F6+0b1x96ZSX3ElvdQAHi4Uf2+sGVuOtPW6y/a+gLOJKykrG4ryhtOqr6/OVJCRrX7tpbHJgeakFWDmz2L0Fnqu6hNyTlHKZWhtkCrUCxkiod9d8K2gkvjuFct8p0zpP51cGZX6uknB08VEkLQ1Zg3tCOWNuUfel2DO7nPfCP/zLBkD5Ct1sNkZML2d7PNLUXopW2pq8mu1sCOrFTBBuVAG91igrQhYpeFyAawMvYdFMtVmnBC0C89omq/N+WwF2VNnvRuXhhPPngquw8q8DNN1NefWYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4920.namprd15.prod.outlook.com (2603:10b6:806:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 05:00:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 05:00:20 +0000
Subject: Re: [PATCH bpf-next v3 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210914223004.244411-1-yhs@fb.com>
 <CAADnVQ+aLj1897R76=TE5GueJVujnZT6G_Ow9mh9waAYfvGdfw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <16ce08f0-351f-d515-cd6b-fbc0af965bfa@fb.com>
Date:   Tue, 14 Sep 2021 22:00:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAADnVQ+aLj1897R76=TE5GueJVujnZT6G_Ow9mh9waAYfvGdfw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:4a08) by BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 05:00:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c121f04-d609-4166-7b0a-08d97805b7fd
X-MS-TrafficTypeDiagnostic: SA1PR15MB4920:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB49203248DB83A95473A58AF8D3DB9@SA1PR15MB4920.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viqfNEj8y4FlZ0Yw+BDkVwUpoTiZVog++xmXoGD9GaiqD17A6f+JQ+8k1sQgUkum4FOCiaEWUU7aRlU4bu6U4wiqjSd51m5mEmElx+Wz/ldTJaekC37RyUllhQqCYGzKc3+s//AlYnVEuKE4q+gtRfwfeoXn9PnPgPm0nVur1L85RvpkcMXysq9KqresUcP2ZrJYoDRjyAQDqMk8Q2kDaXdijuFcvhCNLVti0hlNMINQkeT7Ki7aDvoXNRx8cQj7DLBEV86Dxt1Zn7Tq4y+3sdRPL/TiIuT9JJkbrUaPxFXdLoZCT6Nhr31zR3o2NYEYn9WWAVlAvgj2Y7ZhI9ocPfRbBOEPzoJCd9IFV5gvEZf/7NtblrBQ1/gAC+2D+UsX3lhQieZ+QDlgyFdUvDih2Vkn6Yx10kdgHD81e4u5w0+bD+IzQ9rvMzTMj6AOLlauLV5LMxyaWw/95QerPYWHAwoWsbxQbrYiRlKw5zEOxiKJts7fTexGI7XXsSHAxUNMO7FI0/Zci3CbDKvU4xWP6PqlxFF4dUDxREwoymw9wmSb9LdFGMIC+2PzKUOPBZvPmqFxNYfHks+hpifD9pZWqALvSebKb+Accm3us7svbfTNImDobl+w6qyWfvHImUhnZzXHG5u9BJcuKZErxRUDXmThIs0U1pc3xuRnTpTA3HN1dePeu24PeWCo5q+mQY7DeOM0rbg+bZafKKD9jxngKVNjUucaMayxOF6mFUMnTx7OekCxRQkDbGGRH0h/mi6mQrQWo+hgfptkF5v23Sb8vtfyL5oAfuQtac+Zg26g3LwN6k0q98AwcN1y0rXZlKuRI2aVmLtZJLfcTR0+mI4DIsvd1o8BVSr0lpsWaX/jU3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(83380400001)(38100700002)(5660300002)(478600001)(8936002)(36756003)(66476007)(66556008)(66946007)(53546011)(86362001)(6916009)(8676002)(186003)(2906002)(52116002)(4326008)(966005)(2616005)(31696002)(31686004)(6486002)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVpFNE5pZkhKL0tsNXFVSEMwOTRkMUUvTEFja0tZaVlmK0ppRXpZZHdXK1NM?=
 =?utf-8?B?Mkt3ZENhcHRuMTFaSGw2U1pmbFgramVqdDFZSUhOY05IMkZTZW1JSFA1dU9v?=
 =?utf-8?B?S0gxdzdlOEZsK2ZnbVVCV0xwcnNuaGR1NEJVMW1UZVh5ZjFJYUh1aTRCaG54?=
 =?utf-8?B?QmxqVmtKd25oYWxSZlB4Y3lPUWJmcFVBb2xPUWc0WWZ0SGh2a09WRDNWMER1?=
 =?utf-8?B?Ylh0MUtlQml5ZkNvTzFhcU1LcU1ucGJsSGtQQ1YvN2RyRGVvNVJ4SHVYM2lX?=
 =?utf-8?B?SjN4RTVIT2FHWDFLYnZsSzVXOGl6WGp6OHMrMlFkMDRuYU90cGdWMktWMURO?=
 =?utf-8?B?VW5oZEZ6V1BUZ3I0WkdMVWc3bmp5TUZsM2dkaUEwNEl2dnBBVGljM1pxUDB5?=
 =?utf-8?B?LytZdVptQnBhK0NkSUZGTzBCZExmTHIrLytDVHFMQlVRWEFiZFJKQVorci9B?=
 =?utf-8?B?bTFHTUw2SEJqTWRvaEQwYk13c3lML20vVURETEs3TFZVcmVDR2FDenpDVGNw?=
 =?utf-8?B?SXMyKzEvOTRRNjFYMzVLRUdyeEhqR3JVV1d0bUZhU3dVaEExb2w1bUZMM1Rs?=
 =?utf-8?B?MWFXdkx0MlRiSk1rQS94MEF2S21GVHpFMkhmTjRMTjRkWVp6UGtQZHNjU2Z3?=
 =?utf-8?B?bForSXAxMVM0bFR5UDJqbnJTQ3JRLzhVaDBLVU5vZTRUek9WcE1LR25weEFv?=
 =?utf-8?B?TUQ3bis1U2FISExXdlZINnRuM0prajQvcGRrYzFZQjV2Mm44ckJBbnc1cUVN?=
 =?utf-8?B?OENNN1ZCTS9HZWNYa1lHRldvdFBrTWdxcUgyL2tLZGVXaEtqY2NKQ3ozbzQ4?=
 =?utf-8?B?V0tYdWlPSG5XNmdoRHkzcGo1bUM1eWVBNlNhTFhXdjFiMi9aZlhrY0krdnpz?=
 =?utf-8?B?Vk8vVXFrUmZWNnhNNEs4SFBDY2dRV3VrVjJ5ZEx4SmFaUE9NSjdvSElhd29i?=
 =?utf-8?B?cGxXNUhJaTZPYk04Y09mR1N4MWNsTEZ5REJsYWRBRkZDMTVEcmI1bmppYnBp?=
 =?utf-8?B?QWRVWjdGdkoxV1pMYjZpVWxqdFdTdUltTG1scHkzaUk1WFhTTm9KenY0Nkdl?=
 =?utf-8?B?MVR6L3grdTRhc0IrVG5mZTQrYlJJVjkrNksyd1BlbkxBb0luMHd4a1RYVTQ2?=
 =?utf-8?B?blVsOG1OTmJiMlZmbkc1RkVMQms2K0xSUjBkQ0Y3eE5ZUC9TaHBNb3BWbVF4?=
 =?utf-8?B?ZlI2enFpYmxwMC9DQTNWd2U1K2ZUaStwMWZCQjJzY0JsWnp6UGl1L1hlR1Rq?=
 =?utf-8?B?dFordEJMdi9zd2hEbTdqbEZQcG9yVElCWUliRDNIWmtEbGJwaExqOUttcjhr?=
 =?utf-8?B?K2xxRjJ3TmpGNTJIK1VHaGN3R1R3SFhBM3NLRUdNb1JGTFlBZGtObndzT05J?=
 =?utf-8?B?UkM0WHQrWkpRZVlFeEltNXB0c3dOS2FlMnVZdmZORHEvNC83WmZMQzhtN3NQ?=
 =?utf-8?B?bnVMZWllREpUQ1hiT2RReGFKQitNcFZHL1FCejUwaVFaTHdqUWRoZVBCQVgx?=
 =?utf-8?B?Y21NcDMwN2lrN1J6VW5rTCs1NEprei9oUjQ3cW93aWtwN3dBelBhQ29zWlBK?=
 =?utf-8?B?bVdXelR4ZERIV2lqSUFGeTlNYkdGWEN4VXlxVjRpMEdJUk93UnJ0TktkamF6?=
 =?utf-8?B?ZlNqTWJaWG56OGdhcVNBdnBHbXBkVjcvM0t4K3hhcXkrbVYwSXRTbHVvUklQ?=
 =?utf-8?B?Yzd2RUZkeWhpNVd4ZloyM1dkUVdWeU9uSXZJcm0yTkY1eDFhSXF4ZWlHb3Vt?=
 =?utf-8?B?blYzcGlNWW9MZWJXQXdvaE9wV25FZS9qZ05yRnRQQmZyTmk0ZDVpN3JRcGY1?=
 =?utf-8?Q?RWHuy96brcBqNgwOGD/8M+gyWM0pVAPlMXnBM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c121f04-d609-4166-7b0a-08d97805b7fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 05:00:20.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6v5fzmb6T+Qx0+cvJPfCJMNa7iP58oITAyVypkQ1z9EhHI7yyZMy2uiyvKJLQCv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4920
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CMx8oxKrWyQ9j70jcbLJX7MVL_OCKL-g
X-Proofpoint-ORIG-GUID: CMx8oxKrWyQ9j70jcbLJX7MVL_OCKL-g
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 4 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_10,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/14/21 6:55 PM, Alexei Starovoitov wrote:
> On Tue, Sep 14, 2021 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> LLVM14 added support for a new C attribute ([1])
>>    __attribute__((btf_tag("arbitrary_str")))
>> This attribute will be emitted to dwarf ([2]) and pahole
>> will convert it to BTF. Or for bpf target, this
>> attribute will be emitted to BTF directly ([3], [4]).
>> The attribute is intended to provide additional
>> information for
>>    - struct/union type or struct/union member
>>    - static/global variables
>>    - static/global function or function parameter.
>>
>> This new attribute can be used to add attributes
>> to kernel codes, e.g., pre- or post- conditions,
>> allow/deny info, or any other info in which only
>> the kernel is interested. Such attributes will
>> be processed by clang frontend and emitted to
>> dwarf, converting to BTF by pahole. Ultimiately
>> the verifier can use these information for
>> verification purpose.
>>
>> The new attribute can also be used for bpf
>> programs, e.g., tagging with __user attributes
>> for function parameters, specifying global
>> function preconditions, etc. Such information
>> may help verifier to detect user program
>> bugs.
>>
>> After this series, pahole dwarf->btf converter
>> will be enhanced to support new llvm tag
>> for btf_tag attribute. With pahole support,
>> we will then try to add a few real use case,
>> e.g., __user/__rcu tagging, allow/deny list,
>> some kernel function precondition, etc,
>> in the kernel.
>>
>> In the rest of the series, Patches 1-2 had
>> kernel support. Patches 3-4 added
>> libbpf support. Patch 5 added bpftool
>> support. Patches 6-10 added various selftests.
>> Patch 11 added documentation for the new kind.
>>
>>    [1] https://reviews.llvm.org/D106614
>>    [2] https://reviews.llvm.org/D106621
>>    [3] https://reviews.llvm.org/D106622
>>    [4] https://reviews.llvm.org/D109560
>>
>> Changelog:
>>    v2 -> v3:
>>      - put NR_BTF_KINDS and BTF_KIND_MAX into enum as well
>>      - check component_idx earlier (check_meta stage) in kernel
>>      - add more tests
>>      - fix misc nits
> 
> Applied. Please send an update to selftests/bpf/README.
> Since folks will be puzzled with messages:
> progs/tag.c:23:20: warning: unknown attribute 'btf_tag' ignored
> [-Wunknown-attributes]

Ya, this is not good. I too focused on the latest clang which
has btf_tag support.

> 
> Even with old clang:
> ./test_progs -t tag
> #21 btf_tag:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> The test probably should fail with old clang ?

I will follow atomics example, if btf_tag is not supported,
the test will be marked as SKIP. Will also update
selftests/bpf/README for when SKIP message may appear.
Will send the followup patch soon.

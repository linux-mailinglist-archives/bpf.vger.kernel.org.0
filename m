Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C354E62A2CB
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiKOU0m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiKOU0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:26:40 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC527934
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:26:38 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFJpJAG009247;
        Tue, 15 Nov 2022 12:26:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=2kES4x9R4uFWRsGEbOtNYyH05oXaQQDo/sqlyQsoLMw=;
 b=UndMptdYWrZsau6vs/J2XrQJXTahIN30MtEfYZjObLGN4WhUtBnQXAvseEpFqjUWTDNE
 zV/dbO7qabNDJEPErztl6c+wYmOZvgz/Y0FiHOSs6+Jq9XPfJTo60w6k9wSEtAKoIRcl
 8Ta2euJUvDCWHTxfPIVBlU+DOxFAvWFYB0pVGq99xJpWyDvLjaIkY5cji7C3zPgONH3b
 LqvOqJWimjc40mAMiO2ia4APuG8foBspo3O4WWS0v7K8koJhEp/DQTvOCEhC3f3wAGpD
 6l7ZNHNyZ+7uK3cYJvO3jeDPlVTf1Bzid1Qn7IsqXarWLLSLRUeeumQ//F9vO38fqemd +w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kvcghkbhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:26:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGo0n6hmqGGGWwxT5r53ubcSCqES0nDbhWbOX6agtTJ+ZT0GANJffMEqfPTQiYDpfz0tWaq2R2EOFlTheziiqAZB2AS77vYyC9DEweYiflRpwDcavncUzPr2NduzjL59HO+TCetGIFgV7LoDU2wG7ul1rZUH9xxyY619o3jzkzLXpnHePHO0N1Bp56aBajg8XwdqW1RJPar8r3BapBGdIlzh50QapsuWPeXwQQSCzZ7+7jmFuyHm2jH1YtbXMwslenu5WsOeLUAJkE3tAQwrpU1bAWJiuEw3GieI+74zJS2ENbr9NjaNslppj3Iyh6G7dy71hCLfJ6ZncGOfHhwvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kES4x9R4uFWRsGEbOtNYyH05oXaQQDo/sqlyQsoLMw=;
 b=ZVD+qcQ1OBXR/iHq4h5yeFUEmbDmF8dqNii/n2tTCMv4ORz3f5gLZxyso8xJ91+StkgO9EhZYaom7Fra1fOudg1D1UBFoE/GgwOSngvu+okB2wTpVxeMObeUTyGDYgXQ/dxLGNCTk1M2O+Xo4pxVdQH1YrXQkgNnbJGpUbhUah+sDTRfooPPgumEABfm+m09jmKFPog80jID9H8M1dlyYgv6WtdrvmAdR3Xlx2hqD4TMc01ZdkzOUQ61kVxY4MaveLVBY7vhL2xNsPA+CkQtLaxtTEbE1PHyqFpNdxtRoyHb3pELz+SQiTPkT4OtFzoo7HCkx7Vp1ssA+IlBK4Oz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3945.namprd15.prod.outlook.com (2603:10b6:303:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 20:26:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 20:26:18 +0000
Message-ID: <1f856abf-0161-c560-7941-423c9f8c472e@meta.com>
Date:   Tue, 15 Nov 2022 12:26:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: Implement bpf_get_kern_btf_id()
 kfunc
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221114162328.622665-1-yhs@fb.com>
 <20221114162339.625320-1-yhs@fb.com>
 <20221115194308.ej5lwd2jo6ulebut@MacBook-Pro-5.local.dhcp.thefacebook.com>
 <20221115200541.bm7xhdurhpxuv54u@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221115200541.bm7xhdurhpxuv54u@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbdb04c-a601-4229-f44b-08dac747a6ee
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dd5FSWcH676j5ZF3qMDk523CMIUrmc07GMqFiweMvcX6mgS6DN60lMVT3d6mzvLdXPZz4hHGtt6QUZX5zfc4GnEgW06hMdIc8YrVqwA4m5wQvYAS8P66cAgF7U1+PesmS+KVyBRO7W8cEu5NThUtL7aojKO8zNFcfuiqQ4DWW9RigWGxfcQrpIIizyks5lWx/JxcXykA0sM7KKUW7I2KJ3XLhFJJWrhFEOQobcXDbGZY1OKo1x2dWep/tZI1gPp56M6Ci6faem2NidGYuumjeMpFxisgGXOXBWAyCCqyfo0TZ+564cqnnKn4I3UwVnaweUuv7Pd9vLQ9K8Ngr/jrUXAPth10EbF0AepeRz4UhXy9NeMi0F3RlStLZnaZPyNGNvplb2vsjAcDVgW+oFLdJPug0cCxpyT6d8bji574DCRZRhOjX/XCfvxet3eMj0A0GmpfH7z+FB9S3qIGEpICK8/O0T24h0iy5emd96DXkZL8RRArSnz/dSviRXN1lyynlkgOHLjSI7vK4PfO79loUIeVbHamoK6k3dfjEBZHzsS0V3SvLckipWFWR6ZMnIcSpCZ2EqbX335/i+N8xiIMawNQBCU64LVUWVglQpVtsW1YdC/t9LG6tWHZIx+mHBhDEVdiCQbis0MRJfsot035+iOC7VBbtIUrpUBScxdDcRjFS9WSNRBhoXWa2TMbXJAYb6XK0WnN/WttoGn890QLCB5FJo3o2LFGQFIU6/sh0sKrgIBbuinvE2yxIposvfUI76wCmUwF6C6DltR8h43M9bOyq7563Kjgeehbd/dC/JkrDTd+vxFNqehfQ30IlG0yu0fk68mr4GRvXvWpkB9UpjWiWC+sCF3b+fuLv1m76Q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2906002)(66556008)(66476007)(31686004)(5660300002)(8936002)(66946007)(8676002)(4326008)(41300700001)(36756003)(6666004)(54906003)(53546011)(6506007)(110136005)(316002)(478600001)(186003)(6512007)(2616005)(83380400001)(966005)(6486002)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGJLWExkQWZxK0FhYnlka09uZ1FSNG11N3hGQXpKTWpZVjBORkpjQUlhQUlG?=
 =?utf-8?B?eXlCMitPdU1UUFkyWC91YXVSUkZCT2VwVG1FdXo2S2JJeUphOEtjUzM0ZFhR?=
 =?utf-8?B?Zmplbld5akNEVnczS1BXVmFQaDBmZ2RMbGk3L09wa3AyL1JEb2FCU0NkWUlF?=
 =?utf-8?B?RGs3eTRodXFNUDdSTGpyQmZTYlRwenRXRmRKaXdEaENVWkVvZzJyZ1RNM0sr?=
 =?utf-8?B?VjkxV3QzVVVGVTNQbzNrQ3BSM3BXY25wQmVsb3N4OHI3MUNzaHVTZmVzY09y?=
 =?utf-8?B?a3dmZGVLazhRSW5CMXZQaXNQSHJZQXB0T3M4NDBib1hmNkE5ZlNpY1FVbGxR?=
 =?utf-8?B?U1VDWUM0b1I1U1BXSUc3dTBGMUM1T0Fabk5VMmdYOFV3SkJ2N0hSSm1tMXRW?=
 =?utf-8?B?NmJ6WFF0bWc1d1RMWVE3L2FUNHlKZ204UVlEd1Y2dm0xa0xxN0FMRk5zc1Jp?=
 =?utf-8?B?NTNiMHhJYnYwckkxQ1NPZE9vVUJtTEllS1UrYVZQN1E4eHlXbWZlYzhaTTRO?=
 =?utf-8?B?TFpUNW4rbTgvRHRaREZvVHFTT2FrcXdTZXFSeUl4b0tFT0I4SUxzWFNnalZp?=
 =?utf-8?B?eHhFUCs4WkhrNGZmNnR1OGJZWXg3MjI0NFhMVzluRnViMnZxR1NXV3NiNjds?=
 =?utf-8?B?bGJmS0QvUmNsSkpvTHRCOTVqVG9CdjBoeThVSFVOY2NRRDdESk5yNDJFVmUr?=
 =?utf-8?B?dENzRll3RVU1b05rMTA4M2NaRlcreHY1aU54c0R0Yy8xZUcvMnZ3U0pMZ3Ex?=
 =?utf-8?B?UUdyTjZ6Q1Nid01oempybmQrR3JaUDl2d09YVFhpMUNZZXFWVkVNME96QXpm?=
 =?utf-8?B?cDBQdzFUV1lpakZiMkxxdzY4ak5iM0wyOW9YZnhyeWRuQjVRTDJzdlZUL0J1?=
 =?utf-8?B?bFZLaEdMT2ZlcWdSczIwMStlVmZaZGNSYUMraWprbVVpb1FIQkxiWlVKZ1hQ?=
 =?utf-8?B?MjI2V1J0a0ZxNU1ZVVNZZ1JDVjlUUUNsOTZsOThwcGRkeEpaUndnMGd4RHFa?=
 =?utf-8?B?QjdFdllrWGJHVHVmaXdKYU05MUM3SUYzcndHYkNDU05TSmxlZzVUUGxMSWtE?=
 =?utf-8?B?K2Qyc1NOWVd5TjZtV1VrTzA0dko4L3c3bVlZc1VUQ090UUpkeVNoTHM0SFF0?=
 =?utf-8?B?QmMxRWVQOVM3S2cwUW9Qa0pucE5KSElvWDYrRXBIQjVTd2FQTDljYnNkVGYz?=
 =?utf-8?B?SXBlaGRaR1A4dmlqZVlUenZQNjYyZDBsdWJQZjBrazBITFcvNlN4c2Z4UGY0?=
 =?utf-8?B?Sk5hTW5EcFU1anF1Y1RYbFl0QmIvZzJPY2NnL1hDK055RS9CRHZ2ZTVGdkpj?=
 =?utf-8?B?VmhJcVBkc2E3MERoYmZGem9tcG9KcUNNb3dicml0dU00cmtrcDBoRW1HaDRz?=
 =?utf-8?B?Rno2b1ViV05sTWpqbzJFK2Qxa2xNT2s2d1pGcmd1RkJNT1p5MGlrNjJnVjV2?=
 =?utf-8?B?QXRSci9XcjVSUWNlaGJQc0lSRE5rUG52Uk15TUI0a1QwOUVMMVJZTi95M3B6?=
 =?utf-8?B?NEw3a3RCS3lBOCtsOVplM1ZROWdDbzBFR0JYOCtycnd4RFJHYWpIQUFvaUhZ?=
 =?utf-8?B?OTY0Z1kyNTg4UExSNVhoeDZKaFZPQXVyTG1FWHd4TTdKa2cyU3VqME5vY3ps?=
 =?utf-8?B?TUxGdGpYczNrbGhFZVBtMWVpVTU4Umg2V1lsUXg3SEx1cHAyd0VkNFUxaVpu?=
 =?utf-8?B?MHVXdE9ScFdYb2hSeEsrUW5lUUphcVBYdVpYVkRCeHAvdzE3VlQ1VmJ2KzlK?=
 =?utf-8?B?QzI3OUhqUlI3aXFGWnRkWjI2dzE4NXJoc1RmL3Z3dXdJSzFwbVlKMWREbjd3?=
 =?utf-8?B?cS9vWFN0OXZ6YnRVT3dTMm5ZQlhVS3prWDdJZlNPREFGV0ptYUtheWxocmxI?=
 =?utf-8?B?aVduNGZ3RWlGTUZFSE1udDNkdnJQWmlKL1RsRHhmcHZzY0ZBSjBKYTJQTFVR?=
 =?utf-8?B?NE1aajV2SkZCVDNkeGh1cUt2N3kybm4zcEE1cVI2eGw5TEVYKzFTZUdzOWhz?=
 =?utf-8?B?SUl6RnNhSmFsV1RLYzltZHYrVWxGcmVNVTVhb0x3NVZQSE00QzVWNlFGUEtC?=
 =?utf-8?B?L2xubDE1TGVmb0YrQ1NsU0ZpUEdTSXl5Zm1OaFFJOWxDcXpnRGJ1NXNqMjhH?=
 =?utf-8?B?WHBBV0lPS0hzc0NSdTcxR2FaZTFLRGFtY2w5dWdOdDV0dFEwQ05PeFNaWTJl?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbdb04c-a601-4229-f44b-08dac747a6ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:26:18.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R68/FjvWcPffxvnRhWkLAnT0lPwLo6KXjUALl6B+Dn8zehiRApSgEVSfMW3HLA8+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3945
X-Proofpoint-GUID: 5sT71VP7dT6FM8mZ2c2DzqDgroxptRFK
X-Proofpoint-ORIG-GUID: 5sT71VP7dT6FM8mZ2c2DzqDgroxptRFK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/15/22 12:05 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, Nov 16, 2022 at 01:13:08AM IST, Alexei Starovoitov wrote:
>> On Mon, Nov 14, 2022 at 08:23:39AM -0800, Yonghong Song wrote:
>>> The signature of bpf_get_kern_btf_id() function looks like
>>>    void *bpf_get_kern_btf_id(obj, expected_btf_id)
>>> The obj has a pointer type. The expected_btf_id is 0 or
>>> a btf id to be returned by the kfunc. The function
>>> currently supports two kinds of obj:
>>>    - obj: ptr_to_ctx, expected_btf_id: 0
>>>      return the expected kernel ctx btf id
>>>    - obj: ptr to char/unsigned char, expected_btf_id: a struct btf id
>>>      return expected_btf_id
>>> The second case looks like a type casting, e.g., in kernel we have
>>>    #define skb_shinfo(SKB) ((struct skb_shared_info *)(skb_end_pointer(SKB)))
>>> bpf program can get a skb_shared_info btf id ptr with bpf_get_kern_btf_id()
>>> kfunc.
>>
>> Kumar has proposed
>> bpf_rdonly_cast(any_64bit_value, btf_id) -> PTR_TO_BTF_ID | PTR_UNTRUSTED.
>> The idea of bpf_get_kern_btf_id(ctx) looks complementary.
>> The bpf_get_kern_btf_id name is too specific imo.
>> How about two kfuncs:
>>
>> bpf_cast_to_kern_ctx(ctx) -> ptr_to_btf_id | ptr_trusted
>> bpf_rdonly_cast(any_scalar, btf_id) -> ptr_to_btf_id | ptr_untrusted

Sounds good. Two helpers can make sense as it is indeed true for
bpf_cast_to_kern_ctx(ctx), the btf_id is not needed.

>>
>> ptr_trusted flag will have semantics as discsused with David and Kumar in:
>> https://lore.kernel.org/bpf/CAADnVQ+KZcFZdC=W_qZ3kam9yAjORtpN-9+Ptg_Whj-gRxCZNQ@mail.gmail.com/
>>
>> The verifier knows how to cast safe pointer 'ctx' to kernel 'mirror' structure.
>> No need for additional btf_id argument.
>> We can express it as ptr_to_btf_id | ptr_trusted and safely pass to kfuncs.
>> bpf_rdonly_cast() can accept any 64-bit value.
>> There is no need to limit it to 'char *' arg. Since it's ptr_to_btf_id | ptr_untrusted
>> it cannot be passed to kfuncs and only rdonly acccess is allowed.
>> Both kfuncs need to be cap_perfmon gated, of course.
>> Thoughts?

Currently, we only have SCALAR_VALUE to represent 'void *', 'char *', 
'unsigned char *'. yes, some pointer might be long and cast to 'struct 
foo *', so the generalization of bpf_rdonly_cast() to all scalar value
should be fine. Although it is possible the it might be abused and 
incuring some exception handling, but guarding it with cap_perfmon
should be okay.

> 
> Here is the PoC I wrote when we discussed this:
> It still uses bpf_unsafe_cast naming, but that was before Alexei suggested the
> bpf_rdonly_cast name.
> https://github.com/kkdwivedi/linux/commits/unsafe-cast (see the 2 latest commits)
> The selftest showcases how it will be useful.

Sounds good. I can redo may patch for bpf_cast_to_kern_ctx(), which 
should cover some of existing cases. Kumar, since you are working on
bpf_rdonly_cast(), you could work on that later. If you want me to do 
it, just let me know I can incorporate it in my patch set.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134386276C1
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 08:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiKNHxH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 02:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiKNHws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 02:52:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7AE19039
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 23:52:39 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.5) with ESMTP id 2AE7a548010102;
        Sun, 13 Nov 2022 23:52:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=R7YDEjZTU4RUhePvEZtG3jtaEYo+VKeh+YDzicK2OuU=;
 b=jNjtmKwcR50yiI52TFkqzdb1aRrxMkZhce45OmWaZJSYNOtaxcaRszkz6PQE6k7VbqOt
 wRbb8AsUmV0HV6qDY8Wtz0W27sO6kXvFrAj3Ri/IKQNanCFwHPYiLt6Po4+2bcO+HjAG
 NbVfPhTVh9rexgW+o0w5Q/l4t5K6eJ6kY8st9dE8a5cHs1WtgljZ8c/7ocoGSmwtJl4l
 spgsXKDukj5SGHAgDnN5FvapFN9NYCH5jt53db7IKrk0STFeVUg4NvtTQUf+hHARVESi
 1noJyzQal8TPEUtxz1DlUzk7Ubzem8SrJTuCOHIoAmfvQ9VqYlRdPyinD+BjsUcTH8RC qQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kuhe58331-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 23:52:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tin93+SBX4AFxtuVFQSc+Rmxc40N4h2X67ZekBWTWaF9++6HG27wY8yg0qWu+XmG9Ch9kCNAPaYblkrXipOrK2MlAf8ZfWX7uGZLNniB3RNxKrL8ZIhmhlKB2J5iDUcfIvOdhQahasuaPzBW+3l9mnPmEg7DeQ3bPRNV+HlswJDMnRayEqdr3PJ2dZYaqdnOI2+xRQ2g8jZ7JjvSwVSFzHoZYgijuYza+wr+KtWddRp01DiAl6tdXdlPj38yR5zrj+n0ja+ao3Wjvv8kt5WNdtFW2gUmqRUzmyBp+dKBELXNTfGCWDtzu6y9wSCD4QyFktShnYkNm9RbBe/4/xjspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NSuYpu3d2Cl0kySb+epWhGW7T/rPl4xxgNf1l3zI6U=;
 b=Tyr3LMkpvi21OgSX+cmNJmWbo+4k4/QCUNSGxfEezfScpG46+W3z9QMA+ueh3LAHaieNlyUd4O4qGnAJK8jrIjw+houCJn2L77yLXxs2KOyXPh4oAQZIcGJcoPSABxyNDUEoIE77mKjF/+rl8giu0eqpXU/sC1NDgoSrJKp5OlUby3agFw7LVzH/L3EiTHjio0xBRpmFOtwTFV+8yBbbcsBYpnWpm6F5a0jShp1YshbLv41pelTJy0V8MIKqz5h9XhDKxd327og0i677mSVFoIuCuhrGZRFmPNTUeXFoxOymXT5mmN/Jm+IdDSWppRGwwwFny3/3BNyt41wgbD2ZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2337.namprd15.prod.outlook.com (2603:10b6:406:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 07:52:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Mon, 14 Nov 2022
 07:52:20 +0000
Message-ID: <67c5d476-b8f4-9007-ca00-a8a9c111c826@meta.com>
Date:   Sun, 13 Nov 2022 23:52:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC bpf-next 00/12] Use uapi kernel headers with vmlinux.h
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <CAEf4BzbScntAd4Yh5AWw+7bZhooYYaomwLYiuM0+iBtx_7LKoQ@mail.gmail.com>
 <f62834eb-fd3f-ba55-2cec-c256c328926e@meta.com>
 <CAEf4BzYT4pwmw64DaCTxR3_QjO5RRVadqVLO0h-hNa-+xOyLZw@mail.gmail.com>
 <af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com>
 <806f02669ee8930a2f5c5e3f2d5cb0b3166832bb.camel@gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <806f02669ee8930a2f5c5e3f2d5cb0b3166832bb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0138.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN7PR15MB2337:EE_
X-MS-Office365-Filtering-Correlation-Id: 73414809-15db-4618-37db-08dac61528ab
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4I7RnrHnAGy2ivhZgxUC1paO7MCYpwf4MY1e4HkUVexfgWbAaDnm0s5DcvG+XiwuCY8jbL2ABBPFI4paO006INfwACF6otlgJ/MrCu9v1fbj1wV8ifY3eIE6ifRm1rrWlnUNWbsd91pV3t/EYCak5zhZA04oMi5PwxCrQ8rX5Dvh45Q9gTKhsThuJsf/iNme2VF3VhK87h7slCLM2aPRCIPNu8pG+iWyhOuFDM+oF9/JzaMoA9bX7BOhQk52r/qtVKIZTti9qlWbEbNLBEffCbQpPeP1CD1QGqKiqieffFvPOfcaEOdCZh9UVaynlnKS1l4cJ2JiNEv5/fzoR5elNqLSSxMs1zJjktuEcaTGHndk8RueafHNRlJyakmEoaQo4svptDZt5cYrqIV5sOQkTvMJC3oXCkfra2UH8cwK8NyGt9kwggHenVKVuFfodVzj+emViBBngKZB0/2+xnYMKKTTNDE7EI05WK3UVHz9nO1X581hRWtZhmLRzaoQKNagPvEKfIumrlw5FHBMDgKWWTF8IlENvcAR4syVcQKC7GQhF0bC7/7gLNpa9SPc5TSExUhsEB/2NjFC81Un2Z8G32OWb634+lTNgZH1OyCyhiKDBDBmxT2svbz1VKFAHjJP4+TbcYKtSJhzuxtR81rIomBkpWmOS9k0wuue2gl52X9EqLyGEz6nKwlezq9FxHCvm0lNvPzldKREwV4Ik953bIYOz/FAqyzK+c8A6QuaW0Pzrh7KH4HfX/C02oV/Y+RaPU+7E6qF24U6YyxyT/O9D0YMFwHR2dM0jF9hkQ+MRu9/DzVDgwYtK5B3sbUnPISm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(41300700001)(83380400001)(316002)(8936002)(5660300002)(186003)(2616005)(31686004)(6512007)(36756003)(53546011)(4326008)(8676002)(6506007)(66476007)(66946007)(38100700002)(4001150100001)(2906002)(66556008)(966005)(6486002)(478600001)(110136005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhEQi92YmRhRTRuclNPczk1OHRtMFZxZ3lFSUdaUVJNTEh2Q09tRDJBZERq?=
 =?utf-8?B?UHgrek82NEVGVTErRHIxbWF5b0NacllYUHUwS2R2dXpOZlhjQ1B5a2hRS1ZJ?=
 =?utf-8?B?WUswOHg3UEFMSWxRQjNpakRoVmEzREFUdDdMZUR6OVlVSk90WWhsYVU1dHBG?=
 =?utf-8?B?ZzdCRlYrczd2TllDQjR4UEtHMWdJeUdKZDVRTkx0Z1JOWDRWbFpWdVlNSjdM?=
 =?utf-8?B?OG5uQmpuR3ltTkJtZ0JjYXFpMldObi9MMVZLdngrakJvYkNSYUxsMFdFNFBY?=
 =?utf-8?B?OEFTNW5yYUpEckZ3aytoamZVdldkaHE1cE13WDhSeVlSUC9URGVZMFAzcWV5?=
 =?utf-8?B?enBjY1F3dzF4SG43SXAyKzVSR3U3OW1rTXo2OGhxTndOTG5DaTVSSkV5VmVn?=
 =?utf-8?B?RDNFZHIzdGdnclFKL0RHbmx5OHNycDJpaEpPVDZxYTI3Um4rcDVsRk5yaVRx?=
 =?utf-8?B?bzc4MGg5MkJ0eUJPYXFJbVd1WGFXZnV3YTlCbzcwQmFXeUpDOTBWYWxrWFhG?=
 =?utf-8?B?V2ttQjhuRkVRZFRhY2VXOTJPZ0RhUUs0VlJpNFB0NVJwZ0NMNTE2cUUwVUpR?=
 =?utf-8?B?T3ZzRHlzdk9tcGxzUmtTRWhqRGtydXBsRTc3Z2NHdVZuMU83L0x4Uk9xa3dt?=
 =?utf-8?B?VjRsR0UrR3VCMXd2Wmo1RnQrUjViVC9KaWdLekJCem1RMXA2c3p3UWdSWitl?=
 =?utf-8?B?cjdUOHFBMlV6YWJ6eTc2UzA3b2VRWWVzb3pjM0NIWVIwZ3FUV3RVSVliZkor?=
 =?utf-8?B?UGo2eDdCZ0F1R3Y0S0Q3N0pLa3V4TkxCUlM5UHMvVjV4T0cvSFF0TTVvMm1L?=
 =?utf-8?B?V0Vld1ZZVjE1OVhFcFh6WVhxenAwUEpuak0wdjgrejV5UW9OdXRuV01DMUUw?=
 =?utf-8?B?bmZ3cW8zMUhrdGgvdzZJRzlFTExvdXMzWURUUmQ0WVhwWkEwZmRvdkRSbEJq?=
 =?utf-8?B?UFVabHhXc1BsQi9HeTh4d25EcW5VTEtSb1FVZ2dZYXcyY0RlVDQvZ0dkY0Q1?=
 =?utf-8?B?Q242YjF1cE83bmJWRXV6ZzZZQXRRNVc4UFlLMzE3M2cwRWFYNGk5eWxWL0M5?=
 =?utf-8?B?ZGhUclh5OHNDdmRQODJUS3NhR3hhU1Q4eFNhc0xZcWJVUmxvNUtoMGwzemNW?=
 =?utf-8?B?ODVWcUNXWU4zY2dlNXh5ekhXZ3ZML0tLRGI1RFhadDZ3NWZYVWhiQjM1TTBy?=
 =?utf-8?B?ZDRDQzNIZmVTVTFqaVF4R1hGSWppUHh5aFErVythLzBNdHFYYkRVam9mS3Zk?=
 =?utf-8?B?Uk9xeTNBdEJ2aStPT3lzekhhV1RXVG93VDNwTjgxRUsxQmR0SUpOZVlHYlhy?=
 =?utf-8?B?NVdLSHhmZ2Rvb0JsNXMzRTdFVllYNmQzckZ5dnR4ZTZwSnBibDBtTldFU1lo?=
 =?utf-8?B?TjBTU29nZ2NDUXZDQ2o2ZDFOQXg1TzNFTHMzOHd6QnpvZzlac2Fmbmc1KzBQ?=
 =?utf-8?B?WGdmSHk0VjFaMjNlcmdZUU1oYmcxaCtCVlRUZ0owWVBsRTdMZTFSbkhwUzJ0?=
 =?utf-8?B?eUgvSGJ1b0phZFc4UXU4ZlhmUDhiYUN4djBlT0txU3FEZmRtcE4wZG9BTGpo?=
 =?utf-8?B?TzRuazdzOXBTT3ppcDFVUmRPaWgwQ0FBdGRGNWNDZlc4RGhEWENEMjlaclhZ?=
 =?utf-8?B?T2FzZFZnZmV2Z0JpN2E1ek9vN1c3MGNQeDBpMno1Nmh2bGxpUUJYSHBsbXkx?=
 =?utf-8?B?MUo4ZVBkdkRlb3FKanB1SUJjVDN5Q2prdjZEN1g4YUl2R205RTAzSk1sSTRR?=
 =?utf-8?B?QkU3R0tlRVE4aHZyazFwcGlQSlNLR1RnOG5pYlIxdEtyOHhNalNiRVNNUFVZ?=
 =?utf-8?B?UHhhaEtJTmRpUG0xOUtDeldRbE1NR281TW5oeTlrMFYwalRaOHlDNzB5cjc0?=
 =?utf-8?B?aVVpK256cmdYV2RUYndMU2hqUHViTFFHbTBkVEJmcm9uNDhPOGpzN1NqRXBO?=
 =?utf-8?B?RDdhRVp4UDd1T3dWUlZGZWVGakR0a2FyZnRmYm8xaHVSdTNKVEUzOWtDVy82?=
 =?utf-8?B?cTd1V28yN2dlYWNtY2VxZktkam5Ndm5SQW1UZDAxbVcvQjFVLzlUNUNhMlh5?=
 =?utf-8?B?azg1YnJtS01tWlNHWm9KM05XR2RNN1hPSDBDbkJkeG1oTVE5MTdjWTFVWlFQ?=
 =?utf-8?B?ay8vOWR1bzFYdUtBME8rcDYreXpXUkNIT1A5aFlsWWpnUUJZaGJVYmdLK244?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73414809-15db-4618-37db-08dac61528ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 07:52:20.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ9Iab1uZ/rWMLO3RyDXxHeZAvGcrLuedHJqu7nJb4SjADiZSoKcVRz3aoIzxCZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2337
X-Proofpoint-ORIG-GUID: 7ghduVthMQGuDZA7LJCLLYJvwaoQkMNK
X-Proofpoint-GUID: 7ghduVthMQGuDZA7LJCLLYJvwaoQkMNK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_06,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/11/22 1:55 PM, Eduard Zingerman wrote:
> On Fri, 2022-10-28 at 11:56 -0700, Yonghong Song wrote:
>>>> [...]
>>>
>>> Ok, could we change the problem to detecting if some type is defined.
>>> Would it be possible to have something like
>>>
>>> #if !__is_type_defined(struct abc)
>>> struct abc {
>>> };
>>> #endif
>>>
>>> I think we talked about this and there were problems with this
>>> approach, but I don't remember details and how insurmountable the
>>> problem is. Having a way to check whether some type is defined would
>>> be very useful even outside of -target bpf parlance, though, so maybe
>>> it's the problem worth attacking?
>>
>> Yes, we discussed this before. This will need to add additional work
>> in preprocessor. I just made a discussion topic in llvm discourse
>>
>> https://discourse.llvm.org/t/add-a-type-checking-macro-is-type-defined-type/66268
>>
>> Let us see whether we can get some upstream agreement or not.
> 
> I did a small investigation of this feature.
> 
> The main pre-requirement is construction of the symbol table during
> source code pre-processing, which implies necessity to parse the
> source code at the same time. It is technically possible in clang, as
> lexing, pre-processing and AST construction happens at the same time
> when in compilation mode.
> 
> The prototype is available here [1], it includes:
> - Change in the pre-processor that adds an optional callback
>    "IsTypeDefinedFn" & necessary parsing of __is_type_defined
>    construct.
> - Change in Sema module (responsible for parsing/AST & symbol table)
>    that installs the appropriate "IsTypeDefinedFn" in the pre-processor
>    instance.
> 
> However, this prototype builds a backward dependency between
> pre-processor and semantic analysis. There are currently no such
> dependencies in the clang code base.
> 
> This makes it impossible to do pre-processing and compilation
> separately, e.g. consider the following example:
> 
> $ cat test.c
> 
>    struct foo { int x; };
>    
>    #if __is_type_defined(foo)
>      const int x = 1;
>    #else
>      const int x = 2;
>    #endif
>    
> $ clang -cc1 -ast-print test.c -o -
> 
>    struct foo {
>        int x;
>    };
>    const int x = 1;
> 
> $ clang -E test.c -o -
> 
>    # ... some line directives ...
>    struct foo { int x; };
>    const int x = 2;

Is it any chance '-E' could output the same one as '-cc1 -ast-print'?
That is, even with -E we could do some semantics analysis
as well, using either current clang semantics analysis or creating
an minimal version of sema analysis in preprocessor itself?

> 
> Note that __is_type_defined is computed to different value in the
> first and second calls. This is so because semantic analysis (AST,
> symbol table) is not done for -E.
> 
> It also breaks that C11 standard which clearly separates
> pre-processing and semantic analysis phases, see [2] 5.1.1.2.
> 
> So, my conclusion is as follows: this is technically possible in clang
> but has no chance to reach llvm upstream.
> 
> Thanks,
> Eduard
> 
> [1] https://github.com/llvm/llvm-project/compare/main...eddyz87:llvm-project:is-type-defined-experiment
> [2] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf
> 
> 
>>
>>>
>>>>
>>>>>
>>>>> BTW, I suggest splitting libbpf btf_dedup and btf_dump changes into a
>>>>> separate series and sending them as non-RFC sooner. Those improvements
>>>>> are independent of all the header guards stuff, let's get them landed
>>>>> sooner.
>>>>>
>>>>>> After some discussion with Alexei and Yonghong I'd like to request
>>>>>> your comments regarding a somewhat brittle and partial solution to
>>>>>> this issue that relies on adding `#ifndef FOO_H ... #endif` guards in
>>>>>> the generated `vmlinux.h`.
>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>> Eduard Zingerman (12):
>>>>>>      libbpf: Deduplicate unambigous standalone forward declarations
>>>>>>      selftests/bpf: Tests for standalone forward BTF declarations
>>>>>>        deduplication
>>>>>>      libbpf: Support for BTF_DECL_TAG dump in C format
>>>>>>      selftests/bpf: Tests for BTF_DECL_TAG dump in C format
>>>>>>      libbpf: Header guards for selected data structures in vmlinux.h
>>>>>>      selftests/bpf: Tests for header guards printing in BTF dump
>>>>>>      bpftool: Enable header guards generation
>>>>>>      kbuild: Script to infer header guard values for uapi headers
>>>>>>      kbuild: Header guards for types from include/uapi/*.h in kernel BTF
>>>>>>      selftests/bpf: Script to verify uapi headers usage with vmlinux.h
>>>>>>      selftests/bpf: Known good uapi headers for test_uapi_headers.py
>>>>>>      selftests/bpf: script for infer_header_guards.pl testing
>>>>>>
>>>>>>     scripts/infer_header_guards.pl                | 191 +++++
>>>>>>     scripts/link-vmlinux.sh                       |  13 +-
>>>>>>     tools/bpf/bpftool/btf.c                       |   4 +-
>>>>>>     tools/lib/bpf/btf.c                           | 178 ++++-
>>>>>>     tools/lib/bpf/btf.h                           |   7 +-
>>>>>>     tools/lib/bpf/btf_dump.c                      | 232 +++++-
>>>>>>     .../selftests/bpf/good_uapi_headers.txt       | 677 ++++++++++++++++++
>>>>>>     tools/testing/selftests/bpf/prog_tests/btf.c  | 152 ++++
>>>>>>     .../selftests/bpf/prog_tests/btf_dump.c       |  11 +-
>>>>>>     .../bpf/progs/btf_dump_test_case_decl_tag.c   |  39 +
>>>>>>     .../progs/btf_dump_test_case_header_guards.c  |  94 +++
>>>>>>     .../bpf/test_uapi_header_guards_infer.sh      |  33 +
>>>>>>     .../selftests/bpf/test_uapi_headers.py        | 197 +++++
>>>>>>     13 files changed, 1816 insertions(+), 12 deletions(-)
>>>>>>     create mode 100755 scripts/infer_header_guards.pl
>>>>>>     create mode 100644 tools/testing/selftests/bpf/good_uapi_headers.txt
>>>>>>     create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
>>>>>>     create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_header_guards.c
>>>>>>     create mode 100755 tools/testing/selftests/bpf/test_uapi_header_guards_infer.sh
>>>>>>     create mode 100755 tools/testing/selftests/bpf/test_uapi_headers.py
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>
> 

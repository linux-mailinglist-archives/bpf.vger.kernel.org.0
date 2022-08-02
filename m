Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760015884DF
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 01:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiHBXq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiHBXq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 19:46:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0ABE08F
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 16:46:25 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 272Ni5eI031735;
        Tue, 2 Aug 2022 16:46:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EIpnB3O50h3TMtjN4rGoZfs+XCarKBZ4r9bO5n4y884=;
 b=XIpf6K0HGzMpnQpnqE/YmWsQmk4FxSnwZz9h0n/t/vTexkCjF40cbVixABAs2HpXlPmk
 e4joKUa4RFkfYGmhj3K3X7Xxts8StqPJZEqiaEFQYLOL3xO61gtEttKYluUMEfZIeN0R
 POqco26SqZcINHhy2lvLV//D8hamzMEVuZQ= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hq51cvah7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 16:46:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im/8Qc0KHWOlZdt8HTQjr2rGQMdM4gk0ggaJAHxm73DNHUWCkDnkwCs+Q9TsKHDrb9ajKuY/Vym1gA+dUTHXXj1YpHCOdWeGWkKiBYhjpsWsO9gMzXjvphUsiR6TfriibXAVTtLXZH0zmf3hkkBYopidBWmsTwN1otvrZ7ywWQpkCS5w2WtOfDddtg4bGhLw3G1QbJ22YV4aFkVfGGZ2uT3Ey5ujRJg9sZ43ePGmBkKIbOICB8ocNk6z9R9V8jXGDoJTmkMLMwEFcHYAPs38uxdn0xtwc+dl4w6ny724AjOT4S5dQmTjXuzElrmi2IjfuRSbMfKB1DTzlBo84tT5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIpnB3O50h3TMtjN4rGoZfs+XCarKBZ4r9bO5n4y884=;
 b=ELeA0iyIfMfcifn1UC3lnEcDPp+mbJiaZ8CjT9xO6fIgIfFStiaxs8mkwRQhNpZqlVRexMJ+dNrWuQnckDFmJIFwjYFOiqtYGLRNXCYKgaxheNBI4asPTKTzyNZTg/YHi5mG5I1ga+bwwrAyYpiw+izshls51r/68c4tYaNOjWbjRe0xESQeAZoIIvUXMTPTjFkhhbC6rq2jV94W3cQJjcY0EjHBqn0V/lK5KHQbjwtN7QfJCyTfEHz2tM+mBYyzn1X5Ouo0UT/try9RuWloZDNF8H+9scamwLLA3h2Oezl59gt95fT8XRaBTGmSLdFl2wDvxtEvcpjFgR3ZymU0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2956.namprd15.prod.outlook.com (2603:10b6:5:140::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 23:46:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5482.015; Tue, 2 Aug 2022
 23:46:08 +0000
Message-ID: <2506a841-1485-7d61-3fba-21508077785d@fb.com>
Date:   Tue, 2 Aug 2022 16:46:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
References: <20220726171129.708371-1-yhs@fb.com>
 <aa998af64d0662af4c138175259244640cecfcbf.camel@fb.com>
 <18273e85-4e45-c395-0aa9-a10125d59e50@fb.com>
 <17dbbb831db12049ebfb5161e380c9078fbddad5.camel@fb.com>
 <a31dfd32-3065-1881-e2e2-3c420568232a@fb.com>
 <948ca89ada1e14ae21335eb5ded5aef4305fbf58.camel@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <948ca89ada1e14ae21335eb5ded5aef4305fbf58.camel@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:a03:80::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69bf2ef5-3b06-4053-1dab-08da74e12bdf
X-MS-TrafficTypeDiagnostic: DM6PR15MB2956:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNKqNnnmcLAks60gwe4sMAz2RYkcwNyyBQBImre6GGaunlDRLKE98GdPknbGDr2g/V1lp8Ry7b4D6Wf2NCuYvApJkrKzBXX4VC63cy3AHj1Zt43u2BcK8mlwXmwsEnyNhFZJ5CvuB7tlqzsV/Jyt3gimJL3coxhbqbZSR7O1adEHcIzYuKb2twyI2fRwNCbpXXPjfFpK+olB5zYaSJ0WkBs2L8w8Ig7eMcWr0EKAVlq4kDuU3Yu7KbyQsJQKX9O+lBIvVMwgyF7VhN4AXUqXOjrtoCGkrQgvQnN/o3ALzaucmwuJz/E+mJY/sS2yDcyMdpCrHf7cleaK5xj8hEVov2iR7c0Lg+loXd+yFobvAx3Lnu5Nb8OkXK8qpD3KKBXP8PoMW7ZfGXMSNWLt3goHlPiAGTGcR9/WtITrt1F9274ywyfuetTvsdTyvPzPKHjNCyV+9Ze7lDfGMGTx0VAx6xQNQHYqch6SggaQBQlst40uLUa7gajXUla22zFNwoJHm+9oxyOkDcw3wK2vcjnatJ4RhDlQvciM5TJcOFZad+rAMthoNLsC8uJEvgOZaYxWRBC4lPgRZIl05JB21HB4Zkyy6OXi3awcVXu2VomJS+3l312E4FlQKOATwTu0kbM9lpyxmhJvKfIXi09Oz49x5dG8XYemBQ0W11poK2XlIAqMYFgEgdakdfmUI3WFyB+7lhqt51Xr7VCVuhbSpFEEWGoWj5TrG/6wXbW4Pwdu6g9fhZkcxf6zLsw32JWr78nAPR4AG+XnvpP/mYVki/tBqXIIPniZoU251U18pSSHwmq0czHGlkLS4ZVnds3ph5rK79LwMLUGJhPj729rbjUwlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(6512007)(36756003)(2616005)(186003)(53546011)(31686004)(5660300002)(38100700002)(86362001)(6506007)(31696002)(316002)(66476007)(6486002)(66556008)(66946007)(110136005)(54906003)(41300700001)(4326008)(8676002)(8936002)(6666004)(2906002)(83380400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3VSMGF5UGE2R1dsNU1uMEIzZFpVT3dyY3I5K1RJdEZ4c1FsNWtzWTJ3VDFC?=
 =?utf-8?B?cnQrdTZBdXYwNW9MOG1Ra2tzcTltejNybkZzZEE2UlNlWVRXS0FBUWttMTIz?=
 =?utf-8?B?NzNyZlhMcHVGZFNQSmhvREVqSFFuUmJUL3lNbytZNFFLTmQxeGZvTXlXSGpI?=
 =?utf-8?B?RlIzYTFWL0lCOUhzSTlqQUF5bnZxZHJ3V3JPdTA4R25iSVR6T0tKdi9zaW5w?=
 =?utf-8?B?Zmw4Vnc0Rnk3Vnp1UkN6MU5INE9kUjUxN2pCM3pxeWtGSkZqSUZ1YzV5bEJQ?=
 =?utf-8?B?R1VwQit6WWZRdUJIb2FEU0JiWE9hVkxmQkRQb1dDWEF4NWZvMUFQK0JwTFBS?=
 =?utf-8?B?MERHTy9KL0NPSjMwTG4xa2VmcEhlT05jc3pVbUt0bm05bmFhQURwNXprOEl1?=
 =?utf-8?B?L2UwOFlhOFRac3NuTjFpaFY5ZW1WcHladTRqT3RyeTJXK1FKZnhrL3JiWlBw?=
 =?utf-8?B?QjdYeEwrUjJ3L0JlUjlwZjZLdk82Q0ljSXJnaDRWZThLWlRCTTE3VFFQS0x0?=
 =?utf-8?B?czArZm9idUdCK2JSdFlmWFgvQzQrZk12RHNPOUpQVnRDK1NybXV0ZFdNRzUw?=
 =?utf-8?B?aHhrRHFXS3h6Y05mTU00Q0hNOVpIU003Q1FXVE9HYUl4RVFIUVAzNTZTT3A3?=
 =?utf-8?B?bkxvSlFld3VHMW9Kc0xTUzRoZUxNQitYS2Y5QmFvRWt5NHNoc2FZOFZSOWVZ?=
 =?utf-8?B?Tk9YVitaZmFqTE9MWlFoS0ZjQUJFNkJmMWUzQ0NGaituRVlpY2hycm1Rd05m?=
 =?utf-8?B?UFdRYjVFY0F2d3NGaUJ1R0g1aVRmTVZ4QjdwUHJudHQ0TGJqMVUyU0tMUmJs?=
 =?utf-8?B?Y3ZuM2NSd3p6UWZqZ2Rnc1V6T29VZlhaaElvNDVlUURET2lLRnZ0Uis5QlFG?=
 =?utf-8?B?a1hwZW1oMmwzSVJSWmpneWQ4ZDVUdThEQ3prODIzK1NZK1JkRjBCQkkza1JJ?=
 =?utf-8?B?NnloZ3Y3NnBKQ2RETVNUakd2RlRYUTF2U2Y2eVRaMExhR3JLaGEvWkpJbW5v?=
 =?utf-8?B?R1JZMXhPSkswNkdSVVU3aFJGRUhSSFVlSU5lMlNVSFMwVUp5ellqVjlXZzRY?=
 =?utf-8?B?WnNkVk9yV2RjU1J0RXBTM2lmRXlRQ0R1NE5VWkloZExmc212a2VUUnZTenZJ?=
 =?utf-8?B?MnlqNVp3OEFWRDdCd3BVT3JPRjBZNWJ5Y3liRktuZmFXL05oMXFUZmxnUm5a?=
 =?utf-8?B?YzFlbXlxeUpUa1BIaWJMRHNQaHdyS1dFeDQvVm9SRCtpU1pOWC9wQVJpRmpw?=
 =?utf-8?B?OFdzT3locExSUm41dkZXYk5waDlyTzZ1eS9IRThxbE5Ca3lCajVTWk5ndHVv?=
 =?utf-8?B?eU1UMVFVbUhDa3dybEUwQjhjMGhENlBjS3lSWFF5bFA0UGxNOGxUYWs4aWVw?=
 =?utf-8?B?ZnVnbmhkUWdzOVJuelFmK0V4V1RnWUdRbGd4bnFoV2NKc3Yzd2w2dG9RRzVS?=
 =?utf-8?B?NGIxM3VIcHJseXZ3cmk3dnNiZjRNYVhHLzFYM29iRmROTWl2a3UrMTZFOTVP?=
 =?utf-8?B?SUN0L1FaUW9ia01iK0ZjQUwzMVRBZzhoOHVBQ05BZVA1anFyL2lKeTdVT3Nj?=
 =?utf-8?B?MEtvZllrcjlieGo1eVFkRDh4QnJnc1NmTVVqQ3R4aUZ0MGx6REFMeWRJZm00?=
 =?utf-8?B?cVhzbjhTVFVCTWNmVE5UbTI5RktEQmdrTzB1OVpVWmhLb0FNeCtYamluSE1Z?=
 =?utf-8?B?M0FxR0lKcEl5T2dpMW5HUnpwOGZmTXh4TFl5c3RjM0xhdFJZMDhFQjYwcE5k?=
 =?utf-8?B?OG5ZZ2lpTzFNM29zRzhheHRjRG1JbXlpbTFERktubm9LQ05nbTgrb2F3ZWlF?=
 =?utf-8?B?dmE2M2hsRkRvNVVjRWdTZ2hDbElxRUQ1R0Q1dnBVYVhXYTl5RFA3clJ2cXNN?=
 =?utf-8?B?OXFQRWgwZGh4OEdHWnNLcElwUVBodXlldEhDWmhBejVvV2VJZ0NuVkZ3RmJo?=
 =?utf-8?B?MFF3TDdjOXFNaTQzZ083UmNIWjI4VlhqTHQxdHQzd3h4aUFDb0pWZFpHd0NP?=
 =?utf-8?B?eDJqUzlMMC9SZi9hcmNtRUtjOEwrQVhQQ3pxdURyZ05ieU9TY2svSTI2VWc0?=
 =?utf-8?B?QVp1b0pxWWVleW8rYW02eXByMlREa3lEaEFuTGs3MTFtQTUwRjdYUytheTha?=
 =?utf-8?B?ZnVIb0FpL1ZERnp5VHF3U2lIYTZLTGpWSllpaDZ2SDB1K2NxRlk3dlc1TGo3?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bf2ef5-3b06-4053-1dab-08da74e12bdf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 23:46:07.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rozAoZY6leFsOgRtu9/Lknt+l48PsnzTJel9t/h2+teIv08rZ81Aakspg/2TCJ1y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2956
X-Proofpoint-GUID: 3LZYQYN_vJPC8pnkeMsPkEJ1fZHTWzuU
X-Proofpoint-ORIG-GUID: 3LZYQYN_vJPC8pnkeMsPkEJ1fZHTWzuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/29/22 11:04 AM, Kui-Feng Lee wrote:
> On Thu, 2022-07-28 at 16:30 -0700, Yonghong Song wrote:
>>
>>
>> On 7/28/22 12:57 PM, Kui-Feng Lee wrote:
>>> On Thu, 2022-07-28 at 10:46 -0700, Yonghong Song wrote:
>>>>
>>>>
>>>> On 7/28/22 8:46 AM, Kui-Feng Lee wrote:
>>>>> On Tue, 2022-07-26 at 10:11 -0700, Yonghong Song wrote:
>>>>>> Currently struct arguments are not supported for trampoline
>>>>>> based
>>>>>> progs.
>>>>>> One of major reason is that struct argument may pass by value
>>>>>> which
>>>>>> may
>>>>>> use more than one registers. This breaks trampoline progs
>>>>>> where
>>>>>> each argument is assumed to take one register. bcc community
>>>>>> reported
>>>>>> the
>>>>>> issue ([1]) where struct argument is not supported for fentry
>>>>>> program.
>>>>>>      typedef struct {
>>>>>>            uid_t val;
>>>>>>      } kuid_t;
>>>>>>      typedef struct {
>>>>>>            gid_t val;
>>>>>>      } kgid_t;
>>>>>>      int security_path_chown(struct path *path, kuid_t uid,
>>>>>> kgid_t
>>>>>> gid);
>>>>>> Inside Meta, we also have a use case to attach to
>>>>>> tcp_setsockopt()
>>>>>>      typedef struct {
>>>>>>            union {
>>>>>>                    void            *kernel;
>>>>>>                    void __user     *user;
>>>>>>            };
>>>>>>            bool            is_kernel : 1;
>>>>>>      } sockptr_t;
>>>>>>      int tcp_setsockopt(struct sock *sk, int level, int
>>>>>> optname,
>>>>>>                         sockptr_t optval, unsigned int
>>>>>> optlen);
>>>>>>
>>>>>> This patch added struct value support for bpf tracing
>>>>>> programs
>>>>>> which
>>>>>> uses trampoline. struct argument size needs to be 16 or less
>>>>>> so
>>>>>> it can fit in one or two registers. Based on analysis on llvm
>>>>>> and
>>>>>> experiments, atruct argument size greater than 16 will be
>>>>>> passed
>>>>>> as pointer to the struct.
>>>>>
>>>>> Is it possible to force llvm to always pass a pointer to a
>>>>> struct
>>>>> over
>>>>> 8 bytes (the size of single register) for the BPF traget?
>>>>
>>>> This is already the case for bpf target. Any struct parameter (1
>>>> byte, 2
>>>> bytes, ..., 8 types, ..., 16 bytes, ...) will be passed as a
>>>> reference.
>>>>
>>>> But this is not the case for most other architectures. For
>>>> example,
>>>> for
>>>> x86_64, in most cases, struct size <= 16 will be passed with two
>>>> registers instead of as a reference.
>>>
>>> I ask this question because you modify the signature of a bpf
>>> program
>>> to a pointer to a struct in patch #4.  Is that necessary if the
>>> compiler passes a struct paramter as a reference?
>>
>> Note that The true bpf program signature is only one.
>> long bpf_prog(<ctx_type> *ctx)
>> BPF_PROG is a macro for user friendly purpose.
>>
>> For example,
>> +int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a,
>> int
>> b, int c)
>>
>> after macro expansion:
>> int test_struct_arg_1(unsigned long long *ctx);
>> static __attribute__((always_inline))
>> typeof(test_struct_arg_1(0)) ____test_struct_arg_1(
>>     unsigned long long *ctx,
>>     struct bpf_testmod_struct_arg_2 *a, int b, int c);
>> ...
> 
> If cast the pointer of __test_struct_arg_1() to the type (int
> (*)(void*, void*, void*, void*)), test_struct_arg_1() can pass all
> arguments to __tst_struct_arg_1() in the type (void *) without changing
> the types of struct arguments to the pointer to a struct since all
> struct types will be passed as a reference for the BPF target.
> 
> For example, the macro above can be expanded into the following block.
>    ......
>    int test_struct_arg_1(unsigned long long *ctx) {
>      ......
>      return ((typeof(name(0)) (*)(void*, void*, void*,
> void*))&____test_struct_arg_1)(ctx[0], ctx[1], ctx[2], ctx[3]);
>      ......

This doesn't really work. Here ctx[0]/ctx[1]/... has type
'unsigned long long' since ctx has type 'unsigned long long *'.

But if later parameter type is 'struct bpf_testmod_struct_arg_2'
in the function prototype and definition. Then implicitly we will
have a type conversion like
    (struct bpf_testmod_struct_arg_2)(unsigned long long)ctx[...]
and the above won't work as you cannot convert a 'unsigned long long'
to a struct.

>    }
>    ......
> 

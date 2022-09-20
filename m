Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B8E5BDB2A
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 06:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiITEIa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 00:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiITEI3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 00:08:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D44D801
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 21:08:28 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMstB7019960;
        Mon, 19 Sep 2022 21:08:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yVkYbR95j0fUi9954TaxqU+ngDs9MaSTLq5wyNvOmzg=;
 b=cIZc6ZnSMnUefb7VPNUJTptAAWfEK4NBC9JeZw65SwBiPVEf7DmqETiJtEOlFe9EXRxK
 H2KM/cyINZDIRnMe88Mp3P4R46O5OoXw4Fos41G0kXqEnHq1Sd8r7l8Db04eBDE8gp3O
 y1+yKFwjpa9pSto9UhvgQjTYHeGLKi1TNUg= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jnbrxr4n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 21:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B60nhXYD++KDvoYC1TpELQB9oAy05RhHYrzvAwv8jtOPNIsRCLHxl0oo9LQ6x60Fvrij/g0k4vtkq535LJBEceh19eJb6lVavJcKlIvZO6GWcheFiBTTAKNA8MRuM37Wj9odCPkSCQIpRF17ydoV6IPCfnpQl9ZR5ahHfmSc5oEgQC/V9vDavlDBLrTmt2rk0XJ7OSvp30KGLhncdNRV3wUo0S9I1+OkztRyGUdHbGcyMLaIIJZvfRqxwlzsF0F3TEtF63KIY+LxNx+iAp0IB7vlbYL1AGaJosYOkRpHl7MCTQ3PFSotC1UdJ4AWtjs2ju/EGNofdl+/Pzru63pOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJjsMhgS2FeXFwhhjwkABPEteUIG/0YtECOfocAO9Ls=;
 b=M8hTRr/YFd+eqq23GMejyRSk0D63rL7JxCaBXSGDwzmjuX0/wapVybXbj8C3LKF+p8625/jcDnOMV3Ye/lCK/t+e1XwEzFNYIcmKq26Q6nYlwQSdKmuyWDssowDuiO+yYB1fwcCZttDvZumRS8u4RgioNJ87XtjQbMFYj9PS32Eve1A0PCfLb7EhOkyUI3t0DjMUo+ltwWIL6085LPaXEFIh/ma4kkq9nHbAFnZZ7sCRVrXPj7lFCDB+76VK0qbw4Y3A3kd/kMAMoiymDelblCGqe2m+tjTV5hQL5w9iz685d17No9vMLKIilrMOm12SGz8r5XjUr8WXyu+wiDws6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2519.namprd15.prod.outlook.com (2603:10b6:a03:14f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 04:08:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 04:08:09 +0000
Message-ID: <60c18ba0-6f3a-4385-8622-9db8013dee28@fb.com>
Date:   Mon, 19 Sep 2022 21:08:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH bpf-next v2 6/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
 <20220911201451.12368-7-quentin@isovalent.com>
 <00d4de2e-c7ac-7aa5-9d31-868d73af4fe2@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <00d4de2e-c7ac-7aa5-9d31-868d73af4fe2@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:208:237::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2519:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d485cd0-0366-43ed-5479-08da9abdba12
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkmCVtJ3anjiiU+7wzR3wOe8nnZ1CzHeK6Bzh/A7dj6lDMveE+wcFrDfFC01cdhZxG5xSQ5hXb9TYKPRcf/JvCXSk16YOCasWlujugY+UMQxQKjVWz8qbaoMIr94b/x4tQ+EOebOocTw3Jp+SsCYRtdRPMrLpW3elFL18/eVEH/J4PrZ/urC0UqswZAhVh0uL4+rs+r2Xf2lcRGTdnVxAoPOGjkMGCpntMjdERX6EoR6f5uCarKyyF5EoGuuEWwTLNX0PKFs+aeB3eKm6SxxRMBviWa2Wp2GPi4M2c9keP9XL/JTmKFXHs/8/2yNEbcTT7BEbqyRW1VNMFo1Y/Bu/zLvQFJOiTXYBIERGQLMhOgMZrcMFgMc+GWo3Kvpu5OERaZhkxekhJCkyT6apDrEJxnoVz6qMkC7cMXYtrdcZpt3Ade8hGHLgrIOF+1SrHMratuDiI3Q9yFmD2hNkrjbGOh9avufdtfP8jdaL29x7NWaQgSZyovArTPkRyG16l98Veyq6Y7eHQXVppP1uL0nChOv5pmiYMADleniKSM6tceiZKuNE1XlkNTBvbry6JyMVuf1Xr/Al1PYXlQn9RChvyS+5H1gMIA6b8JepV0dh7SPhHERjxRKfV5o3EvPGIEf3mcImW4tAyWIrfSM3rT3AgOG+cTHDifNrTjiGsZfWlj9vGhAG7A0T8rwWEFZ663XNEyQdtxptMwzLIRzPfHaymFj0QUUpopvy+mQCc3JuW0UDBV9llmomDm3ul7+yRspOnk5PaoiFYGH2vmkFQVp0iwDbmYJSk6Bv4jEwKnatsyeQQHRnRQUIxgOWzBgUweHXFlW+h2QajY+SxC7iRimJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(2906002)(36756003)(31686004)(316002)(66574015)(38100700002)(4326008)(8676002)(66556008)(7416002)(5660300002)(66946007)(66476007)(110136005)(31696002)(54906003)(86362001)(186003)(478600001)(2616005)(6512007)(53546011)(6666004)(8936002)(83380400001)(966005)(6506007)(6486002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVRnTUhFTktURiswYUpLSXdWaVRIVEc1NHFRb3RpQmZwcUJSTUtKYUt4dFVz?=
 =?utf-8?B?TEszVGlxYTN1YkZmU21xSnpqMHF2M3UzRS83RC9HQ1hGcE1DMW02S1Y2YTZC?=
 =?utf-8?B?M0szaXFnZmZHSHUxdWgyclJEaG4wQW9xdlFEbjB3QU9iMDZ3dlY3VjlOczA3?=
 =?utf-8?B?SFJpL1FGeTJqM1JRS2FDWkl3c3d0SlZWZXRueGNYNkxBMnI1NHNSc0FkNnIy?=
 =?utf-8?B?aGhYcXN5TmppZVU0T0ZJcFJUK3BRYUQvUUZ3dU5Dd3VCTHF2YWIzZWZmd0Za?=
 =?utf-8?B?N0YrQmd5NmVwQnZWODIvYnNGRmticnFOMGlwL0dwdkdxTlRDM2tWdTlnQ2tv?=
 =?utf-8?B?NU9uSXZkc0Z6QWsvWWM1cUU3bGNZYllTT1VMci9nbmxLU2NVbXNxV2grRVRP?=
 =?utf-8?B?MG10YXlWUVNzVW9rRFU4aWl3Y1JJUGhlUGZqRHhEK1FoeDVqSzlFL3owWHNZ?=
 =?utf-8?B?ZDQvUGR1MldST1oySjhvOXRMT0paU3F4SERnWUorZ3ZqY3BvYWd1RUY3NURJ?=
 =?utf-8?B?QUVjK0orUUZDVHc0QU9mRE05UVFCTXdld1RqYVBLbkI0Vm4xdk44TldLMG5q?=
 =?utf-8?B?QjlnYkZtK29QVTdxSmJqZmFGenZSd0tQdk5Vb0ErT2hveEZYU1JVbUJmRkxR?=
 =?utf-8?B?Yk14clR3R05EdTJwbm9ieUNtL0dQS2MzVDJKV2lxcy91cURIWnZtYkRlMEJE?=
 =?utf-8?B?djJzekkzajArTU95b01sTnJLWEpjUXZwU3RRSmhlZG5xYnVzenlVb0VmdDdN?=
 =?utf-8?B?SmUvbVNmNDJ2bXZaQlV4cFFKZ0RwdUl3ajVWWXJ0VktZV0ZBck1oak1uL1dO?=
 =?utf-8?B?TUpmZzVMVGEvNUVwVXA0NTJJNWgxRGpYbEtFU3R0Zm5wb3FaRVZ1YUo4WnJp?=
 =?utf-8?B?eEFLc1MyS1AwUjZCQTJ5MGdZZHlaSW84VG9zRkFMUFNqdkhJbXJpSWZEY2RS?=
 =?utf-8?B?QWM1UktiTFJJS2xYcUkrQkZJQUV3TjZCMkprZXdrcXMxVk5iN0ZMckIyTDZl?=
 =?utf-8?B?dGw5VGZFaE5mVm9RT2pHTTR2cTJDTnFhdGdDeW1sTnJIMnJTdUhrVmQwUjBF?=
 =?utf-8?B?NmdXVU92MElCVVJXRVVHbjMrZDBzVUVGNGNISW43ZVZhVE1yT3Z2a1g1NTlH?=
 =?utf-8?B?em1RWU82Z1krRllaaDJvSGNneVdNemxGNTl3QzZGdXhndTUvUzc2aXJyRk8r?=
 =?utf-8?B?OXJoQzRhOVR3ZXJRR012UDhhTDcwN0FvWUhlOUZJTlFwM2VHZGUzMWhoUStm?=
 =?utf-8?B?V2RueTd4bG40MlU3WGY0TjZ6Y2RZMWFHRkdrZkg1OHlXR0RSeXhqSDFsV1pL?=
 =?utf-8?B?RWtTdkNGUXoxNE1hbFpaU3RTdnV0Q2JWdHdlTTYwTzVFRlZUbUtoVVZ2N0h2?=
 =?utf-8?B?RVNqSnFzOENlbHA5NXJqaGY4R29RSzBubDdMMWMxd1RtSm00TEVHL1QzUFlK?=
 =?utf-8?B?TU00ZXA1dG5sTUlrdTYvTU9NZ3k2ek1yNGVrcmo1d3hSbkMxVzltd0huNTN6?=
 =?utf-8?B?L2dpdy8rOU9hSmNobHp6SUxzZHJSci9LRmc0NWlwN0RNaU0xTVlRd0hURHEx?=
 =?utf-8?B?UjErM1RxdG1DOUFZbmErQ1ErcDFZSXdIaUNiYkU5YW5ML3d4R2VpSkIyUHhB?=
 =?utf-8?B?R2RwZ0xheW5XeHRCY25sRFh5N1RMZFh6TmhNeHZWRmVMZnZiMFhtYVB4aEE0?=
 =?utf-8?B?eFlxWXRKVkt5UDFrbHlWTGFCNEdQemxYVm9kcXJXUjdHZWY1L09qaktKbitp?=
 =?utf-8?B?MU5Mb1VuMUVWRXpFdWFtSVY3dG5NWENhb1dJM0RUOFpyblkzSjFUL1d1OGxQ?=
 =?utf-8?B?WnpjeHVUQWFlek5DTEszYXNkQkloUEVxNnRrOGxIdDAwSEdFVDl0ZXhCUStx?=
 =?utf-8?B?YnBNS3MxUmErdFErS3kxdVhtY2VqVzBaY3pjQ09TQmZVMzVGUzU0TkxFSmZ1?=
 =?utf-8?B?VG1rVTRaVFBQaWxIdktCY1NUK0NpUWsvR2tsWDZwQ2pLSDRYci9SUUdpbVBO?=
 =?utf-8?B?VS85VGQ1M3FtUFBhbXNqV3dUMXhJblIzcGRMTU9VbmtIc3ppRlNFcW9zMnlV?=
 =?utf-8?B?WGlWNXR3UldKTVZwTGk5YWMvSjhrcENPdXdHUEQyMXU0M0JoWm1uRG1mZ1RI?=
 =?utf-8?B?OFoxb2xXdWhUUmFKWVFTWnRXTWpRWmVPdTJjQW1WQjNDaFZkZDYrM3RxUVdT?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d485cd0-0366-43ed-5479-08da9abdba12
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 04:08:08.8700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doZzpNtQNX/j1o2Eoi/3z2v1NzvYVBaM3++GoqxqROKPLCi8A6xRHHaBohytgVWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2519
X-Proofpoint-GUID: UUjhKrfj1enTW8Tm2Dqx0ncSVsXWNEEK
X-Proofpoint-ORIG-GUID: UUjhKrfj1enTW8Tm2Dqx0ncSVsXWNEEK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_13,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/16/22 2:09 PM, Daniel Borkmann wrote:
> On 9/11/22 10:14 PM, Quentin Monnet wrote:
>> To disassemble instructions for JIT-ed programs, bpftool has relied on
>> the libbfd library. This has been problematic in the past: libbfd's
>> interface is not meant to be stable and has changed several times. For
>> building bpftool, we have to detect how the libbfd version on the system
>> behaves, which is why we have to handle features disassembler-four-args
>> and disassembler-init-styled in the Makefile. When it comes to shipping
>> bpftool, this has also caused issues with several distribution
>> maintainers unwilling to support the feature (see for example Debian's
>> page for binutils-dev, which ships libbfd: "Note that building Debian
>> packages which depend on the shared libbfd is Not Allowed." [0]).
>>
>> For these reasons, we add support for LLVM as an alternative to libbfd
>> for disassembling instructions of JIT-ed programs. Thanks to the
>> preparation work in the previous commits, it's easy to add the library
>> by passing the relevant compilation options in the Makefile, and by
>> adding the functions for setting up the LLVM disassembler in file
>> jit_disasm.c.
> 
> Could you add more context around the LLVM lib? The motivation is that 
> libbfd's
> interface is not meant to be stable and has changed several times. How 
> does this
> look on the LLVM's library side? Also, for the 2nd part, what is 
> Debian's stance
> related to the LLVM lib? Would be good if both is explained in the 
> commit message.
> Right now it mainly reads 'that libbfd has all these issues, so we're 
> moving to
> something else', so would be good to provide more context to the ready 
> why the
> 'something else' is better than current one.

It will be good to mention that e.g., llvm development package
(e.g., llvm-devel for fedora) is needed for bpftool build with llvm.

> 
>> Naturally, the display of disassembled instructions comes with a few
>> minor differences. Here is a sample output with libbfd (already
>> supported before this patch):
>>
>>      # bpftool prog dump jited id 56
>>      bpf_prog_6deef7357e7b4530:
>>         0:   nopl   0x0(%rax,%rax,1)
>>         5:   xchg   %ax,%ax
>>         7:   push   %rbp
>>         8:   mov    %rsp,%rbp
>>         b:   push   %rbx
>>         c:   push   %r13
>>         e:   push   %r14
>>        10:   mov    %rdi,%rbx
>>        13:   movzwq 0xb4(%rbx),%r13
>>        1b:   xor    %r14d,%r14d
>>        1e:   or     $0x2,%r14d
>>        22:   mov    $0x1,%eax
>>        27:   cmp    $0x2,%r14
>>        2b:   jne    0x000000000000002f
>>        2d:   xor    %eax,%eax
>>        2f:   pop    %r14
>>        31:   pop    %r13
>>        33:   pop    %rbx
>>        34:   leave
>>        35:   ret
>>
>> LLVM supports several variants that we could set when initialising the
>> disassembler, for example with:
>>
>>      LLVMSetDisasmOptions(*ctx,
>>                           LLVMDisassembler_Option_AsmPrinterVariant);
>>
>> but the default printer is used for now. Here is the output with LLVM:
>>
>>      # bpftool prog dump jited id 56
>>      bpf_prog_6deef7357e7b4530:
>>         0:   nopl    (%rax,%rax)
>>         5:   nop
>>         7:   pushq   %rbp
>>         8:   movq    %rsp, %rbp
>>         b:   pushq   %rbx
>>         c:   pushq   %r13
>>         e:   pushq   %r14
>>        10:   movq    %rdi, %rbx
>>        13:   movzwq  180(%rbx), %r13
>>        1b:   xorl    %r14d, %r14d
>>        1e:   orl     $2, %r14d
>>        22:   movl    $1, %eax
>>        27:   cmpq    $2, %r14
>>        2b:   jne     0x2f
>>        2d:   xorl    %eax, %eax
>>        2f:   popq    %r14
>>        31:   popq    %r13
>>        33:   popq    %rbx
>>        34:   leave
>>        35:   retq
>>
>> The LLVM disassembler comes as the default choice, with libbfd as a
>> fall-back.
>>
>> Of course, we could replace libbfd entirely and avoid supporting two
>> different libraries. One reason for keeping libbfd is that, right now,
>> it works well, we have all we need in terms of features detection in the
>> Makefile, so it provides a fallback for disassembling JIT-ed programs if
>> libbfd is installed but LLVM is not. The other motivation is that libbfd
>> supports nfp instruction for Netronome's SmartNICs and can be used to
>> disassemble offloaded programs, something that LLVM cannot do. If
>> libbfd's interface breaks again in the future, we might reconsider
>> keeping support for it.
>>
>> [0] 
>> https://packages.debian.org/buster/binutils-dev
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> 
> Thanks,
> Daniel

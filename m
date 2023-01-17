Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FF66E494
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 18:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjAQROC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 12:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjAQRNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 12:13:36 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E111C4994D;
        Tue, 17 Jan 2023 09:12:02 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGB8d3031105;
        Tue, 17 Jan 2023 09:11:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=jHGdlh0adxogGlQqAv5TcIJ1DkMj0v0QZu1rJhm3YMc=;
 b=dxGhcXGikqx5GB1DeBLj+v4wtnGDb3NRMqvT547NB2PEdtL504neULf+R1WCFeRVaK48
 vpXjGl1BxVTIKNf2SSQoNQ61sjRSoFjyW4YuTtEH03L4GDp3ZOP2iIjlq1PNolzEMhI5
 utu+oXhhOPs29XSaxisdyHE7VxJBYZ5XwHVpmJ+gGbMwVKsSSfjEpZQSZTqziV90xya7
 NkqhmkWu1AKwioCYLxOFBvAYN4bs8rDFt2wKQNAZHKk7AigLPCNtQhTxUxxkbv2kWEBk
 5+f+nRX6chMcYIEpTorbZI40CvvoSXN/joL0XLqWlvrZMXm01U7IwZIxydJrGP5udkjs Yg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5x0e8xy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:11:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBQfZOihvstA17iDFcAxem9Gr9GCjwQju7Lxp3QOQyEulTZHcSesxT9cv63RFoqTGLLcFf2mY4ml0REtDhbMq92n/PLNSFLmJXBKNR7zSKc8QKEvps4QKXKXjtrUAydjYVh9cuqmoD2gKbAQj6gOSFwQdEvZsZAjvsBBJB/q8MMiHeOAT9u4oNHtbmGFKz2WZ0KvkTa6IZOMU95lYBm+V+fpsFD9sEXDlrrUPI9tqfykB6xUPBDHCYq5aPMbyoyRI48PWP8jc6ZfmK4MuGQIqhrH/s3QO8O2JVMRDfKe3N/da+L/WAMoSMiCa7kMh+wsv/uJld45W3mk7krIKZUj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHGdlh0adxogGlQqAv5TcIJ1DkMj0v0QZu1rJhm3YMc=;
 b=dgMsaDNzOkNrsh+PYP6nJY3uESxNmwzX5/achCrSkebMZP2MkyN0eDoafPozFYbjBUn9v3IUAtAOmhrLwL/UtWKpr4D3BM/RIA028B5R+I6MhFQ+ZDY5OXMLL0y+VTx2wgePgWO5Vi/etvLjokEODvl1dXLOvDZLl9f1AVsvwfJglAv9oHZGvtfZNu90kqRD/t/fSzF68Js6+j8H5R395miffEcrE2T7gC9YpmR0x3uwL+ie43JzhTIm/12dsWocLs++/xC5pMn8az/hmDdnL7DSyQtBTQXbeG0lcd/sD0Wa1WUc/hKZHx93ZPhmatLFa2esc7ACwTnBvNpQlAHsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB5181.namprd15.prod.outlook.com (2603:10b6:303:185::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 17:11:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 17:11:07 +0000
Message-ID: <389997bc-c7a9-4d17-1cd3-9d389c80e887@meta.com>
Date:   Tue, 17 Jan 2023 09:11:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tools: bpf: Disable stack protector
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Peter Foley <pefoley2@pefoley.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        david.faust@oracle.com, elena.zannoni@oracle.com
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
 <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
 <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
 <CAOFdcFOgAH1z7EKyM=Q4EvzLuKETOWWDMwuqp36SxV-X6PGP5Q@mail.gmail.com>
 <1135125e-6b8a-7b75-5f0b-3208f6b6e8ae@meta.com> <87bkmx9tw8.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <87bkmx9tw8.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 510b7801-266d-4da6-c99e-08daf8add2d1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqzOUs4nc26dttQqAcQtmRemDmdI4p0RHKIaQB8shnw/6hf2o2sAfegkfaou8/NrKsYMwbhP7gFQ4TkGg5eDiB8hRYo1UoI35pEKVsqocamg06dZsUH4O6H8CF2okQ3+lp12JasGwy4UtL1FYrpZOyW1WaREWp98Bb4GQnOL0JXyWL9dyL7UCF+GOMPR5J1QNqNif7ux7DT4X2SegQXrPeLyFPUg0uX3etVy2WbvOQuQgQc1ZDGWOapSupZ14L29zboLq5jR0LDGCytxu15b1/tDuj9KnMV30BSInxTogPtNbsnWXImw/k2YJWwW4ke6+3OnyPWHjyHdLf98xBB8Wk6pT7IVqrvgnUlQnyh/D4LXhUXfsXuLL3VjmDx/FcgndkpIzkEggZT3wryeCDBLcDTrEpZqvvNpj2S6cNZUfWqzlDM89nAjRu6z+gmok0InABsAU01lXNiKWpIIieyNeyIzIqH3VLlO4szUc1cA4Uv6rjlg0hj7mGUbYLvJ/qlB7CfFnyEGm8k+qhomhXkpwDmKQrUYKT/4S9rVtNWnMbBqx3a5sjE3SYN0Q2+KTI+dROE3iRspPUvbbHsX5HbyOfArUWtpGwdZ1aUyV4RFkPUE1Ya4hoWGZsRvQrQwrNxnswH8bcD2XnTPyzVnwsRjv6ET62vDJjK+jPbjnXIcvuL4siTO7gkqmWalBF+DZGB99VI/aeAYJ4IFtg/I6HcyUPEXn0qdKVA3vor7NWEOT3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(31696002)(86362001)(36756003)(6512007)(186003)(53546011)(6916009)(8676002)(4326008)(66556008)(2616005)(41300700001)(66476007)(66946007)(54906003)(6506007)(316002)(478600001)(38100700002)(2906002)(6486002)(83380400001)(7416002)(5660300002)(8936002)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K05SZ1lqdnhzV3pGNW1hWHl2eEdOSVdNcG1yRTNFb0JZODdvdXJBVWNwQTVF?=
 =?utf-8?B?UDVtV1l3cGpmRlllSVNtdnNXRGgzSDZBaHNDbHROaGQvNklPUnlpci9tamxu?=
 =?utf-8?B?YVVnTkFxOXFENitaQWlteXQwTUlMVGRuY2NqWXpvY0VMbGNISVluZ1ovSWxQ?=
 =?utf-8?B?V3c5Y0ZmOUN5ZkxKWXhuZ1B6czBJaWFNM3ZoNHJsMFAvekJaZzRLTmRBTGl4?=
 =?utf-8?B?Z1A0eUxWOFRuSUw0aUhTTkV4UzI0RVlBNFR3SlJyUXJ0WHgrVzJIMjhMRkEy?=
 =?utf-8?B?TUpWTGcrSk1sQTNrSGlNQ1V5STNWYnJWanVWT1dXTjdZeHhhVFJHRzVkTkRX?=
 =?utf-8?B?bTlGQWhWTml3MEpLVVJBajAwUEVxRVFZV050djZ0emhaYWtFV1g1Q1I1eW1M?=
 =?utf-8?B?MC9kaCtGU3lXSk9sWUs5d3hDU1JqOENwZkJOTmRZUnNTcEdkNVFEVGVCSXF1?=
 =?utf-8?B?SW4yVlUvT2pPWnB6aFdnV2JFNDBZWnJoVVJyWW1NbXZDcmtLblBRRG4vd0RM?=
 =?utf-8?B?T3gzV2I3cm03bUlHZlJvQzFJcC9Xc1VDR09aaU5LQlI2cWhvbkhqc1J5U3Vm?=
 =?utf-8?B?bXlwTEhUdUtSbWxDdUFMUTRnMlVqNGhOSU40d2hBa2UyVjRYRVVMRDdLVnlQ?=
 =?utf-8?B?RjF3VVluZlhhRWloWVJSeW8yN2w1dFA5SnBFdDFiS2tKcHpQSUJZUVZCVjI4?=
 =?utf-8?B?ZDF1UVo1M0VmcjZkbWR1bmdTTUp4TndaY0VpSzI0ZDcrVzNtMkw0MVVQWksv?=
 =?utf-8?B?d0NSaHgyNlBYeTd1dzZTNndadVF3eXpOekI3eWJPT1A2N3B2RzMzcjZ6K1dH?=
 =?utf-8?B?TXMrV0NmT0RNM1RWazNLUUw4SFJJZXozdkJCUW1lSnlhLzZGeW9VcmZEdERV?=
 =?utf-8?B?ZVR0ekNrcjA1Q1hGckFvSkNJWVcwQSs0YlRrZHZBYWdXNWszeFdTTS9ucURM?=
 =?utf-8?B?RTJrdTQyZm84RGZsdkR2S2VmQm93YUNkUDFFcDFSSkliajh0dGZsQnZjcXFq?=
 =?utf-8?B?TzNrV3VEZERIRk8ySXZyQ0pjY3VocHFyblZqMnN0OWRCWVpDMHRoQWdYTU4w?=
 =?utf-8?B?UW02d04xc3BBWjBMMG9KOG5JL2NHWGxtZVp0YlR2ajdhd2FDUDUwaFpUM1Mw?=
 =?utf-8?B?c09mSmpuTXg2RWJ4TlJJK1Fwa1UwYTRSMlpIeDkvOU04dWVJSDJNRUVoZFhv?=
 =?utf-8?B?dCtsOFhZL3RiR3JKVHFtN0wyT0x2c0s3Uk1YUWZrMFFTZ2lONlF6aXEzRlhB?=
 =?utf-8?B?elJwVHcrS2JGN25ZMTBaODcyUTBNMFVQRTRLNUhQbjlVK0hjSlk4ejRtTUt3?=
 =?utf-8?B?YUpERjVOR1VlaDd3NTc5L0RjcVlvYlhJN3FxSW5idkgxQmdZRkF2T0c5T3dk?=
 =?utf-8?B?WXZUdmgvSkZJNGFOK28yM243R2hxQk5OMzMraWZma0tIbUhCdXNYTkppK3RS?=
 =?utf-8?B?TTRGZXR0VnZpR2lzQkx4WGVZK2IzNVBPa2Rjb3pIaHdsQWwzSXlTRW10RFlt?=
 =?utf-8?B?azlGVjhCRFdTUUZDTXV4L28ycXZhV254UlhCaTFkWnpsSlJmNkZIbUs4bVlk?=
 =?utf-8?B?R2xBRmNjWC9nb2NGVG01VXliZDNrZENYcm1LTy9OTDBjVkQrUTBVc3JEYkMw?=
 =?utf-8?B?eEZ0czNSd2kyKzVPNzBmZVVBSmw3SUthQWtHUmt6Z1BpOWo0b2NUeWZjZVpW?=
 =?utf-8?B?NGhkeGlBanhINy9xcHEwa0JiVldoUlU1NkM5c1d1OUk0djk1KzBDdFIxNVpx?=
 =?utf-8?B?ZEkyWFVtbmtCVG5TVUFYOU9yYTVKMzhEUmFwTm0vUi9obEszam44dzlndG1J?=
 =?utf-8?B?WkUvRDRCNmhXdnkxODVlOExUR0t1ajJacTdtV3pTQkdqaXkya1ZJeVFxTlNZ?=
 =?utf-8?B?UTlXVjIwMTZnUThIUXRuRXVVaGJtYUFtMmVFa1lZcHFlTXNtWVBTQnZKME9E?=
 =?utf-8?B?SGFuNE1QYnNUd2ErSmEyenpiUEhjeTFKU0pUeVp3d25yY2JHcG54eGtRVndK?=
 =?utf-8?B?Vm1XUFJ2SWxzRUNlREJwN2o1NXZVdDFYcVY0RlI1RlI5YnZYOU1lUm54cHNj?=
 =?utf-8?B?QnU5c3NGcHFZVHNITjI4UjdPdURkbzhZcTN0OU5jYzFmL0RwVjduZ3haUm93?=
 =?utf-8?B?ZFpLZytONjhjWEk2ZWhrcE1lcGpGdUZSSVRmRjlMY25Ydlpqd2VFWDdwWnZN?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510b7801-266d-4da6-c99e-08daf8add2d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:11:07.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lkkw+muBpefyUH5aRe2CYx66wkX3d0IXuSsdiAOWgGb/BiIdroh4Qw8KVwkzUaiR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5181
X-Proofpoint-GUID: _pgWdmndgpiAHgxbZfGopQ159fzZmLtW
X-Proofpoint-ORIG-GUID: _pgWdmndgpiAHgxbZfGopQ159fzZmLtW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/17/23 5:23 AM, Jose E. Marchesi wrote:
> 
>> On 1/16/23 2:49 PM, Peter Foley wrote:
>>> On Mon, Jan 16, 2023 at 4:59 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>>
>>>> A bit tangential, but since BPF LLVM backend does not support the
>>>> stack protector (should it?) there is also an option to adjust LLVM
>>>> to avoid this instrumentation, WDYT?
>>>>
>>> That would probably be worth doing, yes.
>>> But given that won't help already released versions of clang, it
>>> should probably happen in addition to this patch.
>>
>> Peter,
>>
>> If I understand correctly (by inspecting clang code), the stack
>> protector is off by default. Do you have link to Gentoo build
>> page to show how they enable stack protector? cmake config or
>> a private patch?
>>
>> Jose,
>>
>> How gcc-bpf handle stack protector? The compiler just disables
>> stack protector for bpf target?
> 
> It doesn't.  -fstack-protector is disabled by default in GCC.  When you
> use it you get something like:
> 
>    $ echo 'int foo() { char s[256]; return s[3]; }' | bpf-unknown-none-gcc \
>      -fstack-protector -S -o foo.s -O2 -xc -
>    $ cat foo.s
>    	.file	"<stdin>"
>    	.text
>    	.align	3
>    	.global	foo
>    	.type	foo, @function
>    foo:
>    	lddw	%r1,__stack_chk_guard
>    	ldxdw	%r0,[%r1+0]
>    	stxdw	[%fp+-8],%r0
>    	ldxb	%r0,[%fp+-261]
>    	lsh	%r0,56
>    	arsh	%r0,56
>    	ldxdw	%r2,[%fp+-8]
>    	ldxdw	%r3,[%r1+0]
>   	jne	%r2,%r3,.L4
>    	exit
>    .L4:
>    	call	__stack_chk_fail
>    	.size	foo, .-foo
>    	.ident	"GCC: (GNU) 12.0.0 20211206 (experimental)"
> 
> i.e. it pushes a stack canary and checks it upon function exit, calling
> __stack_chk_fail.
> 
> If clang has -fstack-protector ON by default and you change the BPF
> backend in order to ignore the flag, I think we should do the same in
> GCC.

clang itself does not have -fstack-protector on by default. It is
hardened gentoo distribution unconditionally added -fstack-protector
to its clang distribution.

In clang/lib/Driver/ToolChains/Clang.cpp, we have
    ...
   // NVPTX doesn't support stack protectors; from the compiler's 
perspective, it
   // doesn't even have a stack!
   if (EffectiveTriple.isNVPTX())
     return;

and -fstack-protector is not effective for NVPTX. I guess we
could make it noop for BPF target as well.

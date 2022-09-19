Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC95BD888
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 01:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiISX65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 19:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiISX6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 19:58:53 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100C52085
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 16:58:47 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28JMsr3K012742;
        Mon, 19 Sep 2022 16:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BkTUdPQTrafGivgFtsYYt7bpd18wpFdrcBkqdWPcxxI=;
 b=ijQOyyRkwfc6P16exJLe2Kj3zStVyIk2EEq4lrWNYJ5tGAPblrbJqKl2VsSzlyNEJCID
 xTaofJGATyUUWSTpMDnmYItSWnDcZGuL1fom/I9gTxAnCSWKLWBoHKnKKNuVYlZT2jJL
 Kg7owqNUFCPMIguaXIDXcUM/HtLkGBz3+Ck= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by m0089730.ppops.net (PPS) with ESMTPS id 3jpm35ehsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 16:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWpXpK+/o6Z8S+mvzOYu8HcWG2S8SEIOBdRQbGA9SAsryF7OBFyla/OtlzeXevmAKtGMbQudaZYlSWA8OhClbAA+KVGkTiFNj+iiJqONRemIMAFXtrZFmtqbND7B5O5BJ/EnwUaVr25UeB4Qr1VmYtxLblY1YUW2LUiUz3o+uDYs9+EnbvfutG4CO+gYk5pn9ZX0POWnr/WcBwftKY+q/crTE9zFUU1wKfCnnTFCQhsAPz3dYsb/LvMwO3cBy/cRmZwKahMyGpqJAqTAhmRRqo1m8MmH8mEUPFay7gEHMmsiJ5LHcCaNpGma5knqVW+dKAkldb2C5J74xDIfiJXvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZKCMR9X3YFqz4p8z+tZCH6Bn/ei9+gsEFhmpfDLCik=;
 b=eHr7uumLIXPfL1oCmnQrt8hlIDzBDUpKxFp9WEBEjLvHy/VNa9dBbPKANmxnaV+7K8yr/j+dqobxpB6Ssso+mQCLnOYJCiL2liASz/pZUa04DI+ETqKhAXwSAPi9XyaMrajgW41HjDuW26ONjFEwcUniZofq4uSkPq1u3xcJqD1gANGFH3Q0oZr8l7tVe4Du3CHZar1sU16PDQyB6PV1f5At1L8Vb9mq6ZqULv3Z82zFOJAlKICaqhwQv872jxFHSGhQXjvJD93DD/DqgHew476qRx9F4pHi/U2tjjD+7LMZcNDWS22gUUZha/NX/DtkJZsOTya4hjyMCkUTzcajVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1187.namprd15.prod.outlook.com (2603:10b6:404:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 23:58:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 23:58:25 +0000
Message-ID: <3bfcfad6-e5b3-62c0-0f7a-ab3141376d65@fb.com>
Date:   Mon, 19 Sep 2022 16:58:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH bpf-next v2 6/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220911201451.12368-7-quentin@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN6PR15MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: fc26bcce-c6a6-4c5d-cd6d-08da9a9ad760
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7Hp9n/6du6TDRr4I0TyCkMPv/boPjR5QTBVwlrtQT7u0AEKdFiKvY57Ejwmf9vgz2kEEOonpLSEa1BnaxrleHBGNSFP2+XH0mR4aK1pudwNI7I3oCOUH1opOF63CgR2UETfhpvt3piIQjZYqSQWAQ/kLn0VlPObHXupt8kPMXHNOGpO9lC8Bukq4p7yEYOsxGSnCSXfZsFArqrHTsLrHyfzUF2mFCSC98x3FPjO8XhM3jMobPIzExXB4WlZXbClGxjozecNUALmh6UnuY+n28CJqqqhGQS6ivJPI3PTNwx2BzIryj7R+yu/06AlWhEd1gLKD8xjGUGa3gmkt+wFAQS+HlmqE+NoWPgPjkXC59FU5yJUo36YLwvzH1bW6XUpXCjBGZ5FPBpvgOA/DfVdEx+oMcD9LGDurmjBmrDOxFDheSdoOwNtelJmV6jqraQEZiE2yeDT9NJ0N+xnRMKozkKQy4bf3hnnWnjcEzit30zJabHmH/iY3HZ6gxo7tXuvhs85CZyTUwGdBWnObeKdj/VJW2Or23zZhyq/j8didtrz+gBirqw2s5b2hzvUV19ki7c3hhi3QZtXiydSALmshA2ND0zAwBK8ajR8jopuQn2+RpubFvub9P87GttruOlbJF9IKUP36kikjzU8Mb21qbtz0gwrjgEPnBfAs2ZLgKbtv2r8H1chJ8anOVs1/Se1tS8I5HsrRw8blkp8q4VxgsR6IM6rU6CGmwT1Petn8L9Uk3419eRyjU/Se4h2uFnFL/hUQ0EDv376f+GTPcsbTCYxf+pL3I2QEPiK0MPT6DZUn+l+IkFmXLyRFjdUQqYcJZ95ezLCbxH02o3VerGNYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(2616005)(2906002)(966005)(54906003)(53546011)(41300700001)(6506007)(6666004)(4326008)(8676002)(66556008)(66574015)(83380400001)(66476007)(66946007)(316002)(110136005)(6486002)(36756003)(7416002)(5660300002)(186003)(31696002)(8936002)(478600001)(86362001)(6512007)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SENTdXU4VnV3UVUvaGVjN2NNSXhxQUovNjdIOWIrdW9SWi9ZRC9JWkJiSmNy?=
 =?utf-8?B?U3lZN01FZHZUOHk5dFFSZ05EWnBCQjkyaXRHcVNuVWQyelkrYzhBQk5sbzEx?=
 =?utf-8?B?MDNHbFZvS1hpT0ZkVjZtbjR6VFdqTU4xUmcrakNrTy9ndXRFWWNVRk01QVB3?=
 =?utf-8?B?U3MybjJaN2FtKy92by80cjFlUTR2RUY1SE9EbXMxRmtjRGxZbFBLdnF1ajlw?=
 =?utf-8?B?WDRGazNteXJ4SGVTVGFLZlg3SjczS3lxd28yS1pEZDNUcndEQUZNMXFJYlVB?=
 =?utf-8?B?eFZzbmhseFc2blhhVGxMdHNNU0JFOGVLSDZOdUFON3lQOXdIa0pBK28vekNo?=
 =?utf-8?B?S1JjQVh3WHlIajhuQUVZTzU0KzJRR1dxT3d5YSs2cDBDaVhqcE4wQ3M3Q3J5?=
 =?utf-8?B?OHNncCtSazgwRHBMVXVoaWxlSFVHc2gya1V3bk4xcHVyL1drakoyZVJIdWhp?=
 =?utf-8?B?RlRZRU5lZVZvUHN0TW51Q0FrMVZCT0U0NWtobDJsUVU4Z3krLzcwTHBaNlVY?=
 =?utf-8?B?dVRtUk9MK2ZHZzZuZ0ZOWHBQa3VVOGFlTWl5d25iRHpiZy83aHpma0Z1amp0?=
 =?utf-8?B?eGpHSmxVWUJmVHZ5Zzc1UzkyUGZTeGRtV2ZFdE1rNDAzeE9uUmpJV0ZGRkhL?=
 =?utf-8?B?MVNtNUQxb2V1ZVlWNTdNUHJobjcrNUw5VTdxdEpCcXZDclhaZzBDejUraXB6?=
 =?utf-8?B?YXRUdkhjN1Blc3hpcnR5N1UwQXlFOEUzNzRNMiswUWFaT2RUdmxrRmxzeERs?=
 =?utf-8?B?K040dXUyekk2aTIxS3Y4RDdPWmJFaEJ5RVZvTTNqYVZoWURFUzZyRXcvbUlC?=
 =?utf-8?B?RWNlZlVmd1hPN21sTHplZktENjBQYW1rNFgrZkQwTGp2WmFpczBkcHNYOFZP?=
 =?utf-8?B?QlZnTXAxQUtMaC9uT3JTcmJMTUJMQk1UMlpCUHNXclBLSjB1UmlRdkd5bXdZ?=
 =?utf-8?B?TDc0eHNxZXVpVWV0Um95UGN3QTFQTHRqOWQwaWlnREVDdmd4OG05bUY2b0Ix?=
 =?utf-8?B?NzdYRDZKWjhJQXcyMnZqQ3k2MFFUNjFwdDVGd2JKeFo3cXpjcHpPVHlFUWF5?=
 =?utf-8?B?MU1GNlVoa0VDMVFFYVZxZklEMXdxaGZ0TCt0OUpnOVV4dmFTTTVVcm5BWmZu?=
 =?utf-8?B?cWtRcWp5RW12VnE5WE9Qb21sMFh0dkVNYzdka2ZQM1hyeGNDQWdaRC9nOGdQ?=
 =?utf-8?B?bnFiWnkzNGVMSGR0ZG4rT3RaL1pESTFjRFRLdFl2VXJ5VWpuaUpIRitNQVhF?=
 =?utf-8?B?YkV0OGtPdGxUaXI3QUZ2WmZRMjJlZy82WDNXRUE3Q0hlSExQNHRKQkJHQndV?=
 =?utf-8?B?RWRnd01XendoTVV5MkZPVy9IaTU3RFg4WkEwZXBiSldLbnZXdHJScWdzdHpr?=
 =?utf-8?B?eVpwSXZ2SUhqeldVaU8zZjBGdHhTM0dNSWU1YWF4R3QzMmJGc3E5a3dmSWxh?=
 =?utf-8?B?WXdRZnlnRy9Kc0ZCQzZlZTNjUzdaeFgwTHhzdGh0MTFhZ2E4clZSVVJaT0Fi?=
 =?utf-8?B?WndiRk9LOVNvK1BzaHBobDZlb0xVZzAxYkRDekhEU0ZxMWNEZTlWZVdoWmpE?=
 =?utf-8?B?TnBmNUY3eDdFenNUSVlvOEF4ZFdZc1BCNUVIL2RlTEEvNmQrMTYvSE5IOWxC?=
 =?utf-8?B?dmROKzBab3FXVWhqL1FYTHhIZ0VBZlZWanZRZHR5OVMrRDBwb2JsdWtVQXJP?=
 =?utf-8?B?dEhVR2s0L3dsQTFpVGxyM3RORDhQQTJDSzNtR3BaZ1YxU0FFU0VORWVOeC9w?=
 =?utf-8?B?dGRqdmNGNUNzd1RMVmRXM0RQZU1hSEYxZlJXQ1BwaFBYNE1UaUtEOVF3Vk1y?=
 =?utf-8?B?NFRNeGRMKzFRVEd5U0VqWkprZUordDVFVkZiM0RveUxybnNadklKdlNuL29X?=
 =?utf-8?B?WmJLOGNzMEt0VitGWWVSVSs4WkFQMW1FN0N1d3kzSnNVem5Rd2VEeWRYZ09m?=
 =?utf-8?B?S0VBUWphcnp2V2drc0tENnpadXJuUUhpSWhWcUFIaFNXOVJUZVMrTEtENzA5?=
 =?utf-8?B?UFJMcGhaSlJrMFdNa244WDc1TE4zaUI5UVhwYnBVdDM0Rm5Ecm1sbk5KOFhv?=
 =?utf-8?B?ZzYrS0tlbThPd3FBdVlDK3F5OXBBUkVLZHRWUkZpdVlrT0xGeGtwQnRQc0xF?=
 =?utf-8?Q?6+liHRIfkdsplt8GSal1AJz/T?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc26bcce-c6a6-4c5d-cd6d-08da9a9ad760
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 23:58:25.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct6wcaZgK2QK+ZX7uEUvdnWcQIyex7Zd4QTnKWE3PyzwCvKKw4udyJHR7m7Oiimk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1187
X-Proofpoint-ORIG-GUID: niDdyxqSUJah-ISmwpOLeNAUUUX-2xyi
X-Proofpoint-GUID: niDdyxqSUJah-ISmwpOLeNAUUUX-2xyi
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/11/22 1:14 PM, Quentin Monnet wrote:
> To disassemble instructions for JIT-ed programs, bpftool has relied on
> the libbfd library. This has been problematic in the past: libbfd's
> interface is not meant to be stable and has changed several times. For
> building bpftool, we have to detect how the libbfd version on the system
> behaves, which is why we have to handle features disassembler-four-args
> and disassembler-init-styled in the Makefile. When it comes to shipping
> bpftool, this has also caused issues with several distribution
> maintainers unwilling to support the feature (see for example Debian's
> page for binutils-dev, which ships libbfd: "Note that building Debian
> packages which depend on the shared libbfd is Not Allowed." [0]).
> 
> For these reasons, we add support for LLVM as an alternative to libbfd
> for disassembling instructions of JIT-ed programs. Thanks to the
> preparation work in the previous commits, it's easy to add the library
> by passing the relevant compilation options in the Makefile, and by
> adding the functions for setting up the LLVM disassembler in file
> jit_disasm.c.
> 
> Naturally, the display of disassembled instructions comes with a few
> minor differences. Here is a sample output with libbfd (already
> supported before this patch):
> 
>      # bpftool prog dump jited id 56
>      bpf_prog_6deef7357e7b4530:
>         0:   nopl   0x0(%rax,%rax,1)
>         5:   xchg   %ax,%ax
>         7:   push   %rbp
>         8:   mov    %rsp,%rbp
>         b:   push   %rbx
>         c:   push   %r13
>         e:   push   %r14
>        10:   mov    %rdi,%rbx
>        13:   movzwq 0xb4(%rbx),%r13
>        1b:   xor    %r14d,%r14d
>        1e:   or     $0x2,%r14d
>        22:   mov    $0x1,%eax
>        27:   cmp    $0x2,%r14
>        2b:   jne    0x000000000000002f
>        2d:   xor    %eax,%eax
>        2f:   pop    %r14
>        31:   pop    %r13
>        33:   pop    %rbx
>        34:   leave
>        35:   ret
> 
> LLVM supports several variants that we could set when initialising the
> disassembler, for example with:
> 
>      LLVMSetDisasmOptions(*ctx,
>                           LLVMDisassembler_Option_AsmPrinterVariant);
> 
> but the default printer is used for now. Here is the output with LLVM:
> 
>      # bpftool prog dump jited id 56
>      bpf_prog_6deef7357e7b4530:
>         0:   nopl    (%rax,%rax)
>         5:   nop
>         7:   pushq   %rbp
>         8:   movq    %rsp, %rbp
>         b:   pushq   %rbx
>         c:   pushq   %r13
>         e:   pushq   %r14
>        10:   movq    %rdi, %rbx
>        13:   movzwq  180(%rbx), %r13
>        1b:   xorl    %r14d, %r14d
>        1e:   orl     $2, %r14d
>        22:   movl    $1, %eax
>        27:   cmpq    $2, %r14
>        2b:   jne     0x2f
>        2d:   xorl    %eax, %eax
>        2f:   popq    %r14
>        31:   popq    %r13
>        33:   popq    %rbx
>        34:   leave
>        35:   retq
> 
> The LLVM disassembler comes as the default choice, with libbfd as a
> fall-back.
> 
> Of course, we could replace libbfd entirely and avoid supporting two
> different libraries. One reason for keeping libbfd is that, right now,
> it works well, we have all we need in terms of features detection in the
> Makefile, so it provides a fallback for disassembling JIT-ed programs if
> libbfd is installed but LLVM is not. The other motivation is that libbfd
> supports nfp instruction for Netronome's SmartNICs and can be used to
> disassemble offloaded programs, something that LLVM cannot do. If
> libbfd's interface breaks again in the future, we might reconsider
> keeping support for it.
> 
> [0] https://packages.debian.org/buster/binutils-dev
> 
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>

Acked-by: Yonghong Song <yhs@fb.com>

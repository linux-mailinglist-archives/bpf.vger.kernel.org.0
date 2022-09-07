Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E415B0C15
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 20:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiIGSDY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 14:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiIGSC7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 14:02:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741668768B
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 11:02:28 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287HncV7005933;
        Wed, 7 Sep 2022 11:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=R7YOvp05PmnJEgMES1JZnsLKpe6ZFgO2k2XFeMqhpII=;
 b=Wmg2Qou72hoxsgerIwUK2pNikye5pxw/j792/IwDyA+hSmKuYK/ptjKw2HqWjkeKPyWD
 2LktimDqMb0lcK9IsCzcjpG1qnPlFuh7w74rRvTLHSvcKFNq6EpDmTUz4cWtYpmWZ4Xl
 o26duZnaklEW8WAZ4lqD/waFZcVWrg5yhhI= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jeamhft5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 11:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8JoSbi9naqjessNne5wBzAUjtGuyQzq6wfoI7p6zAZF6AM6V1LJP/kwwxgFp4ta5WVPf9c6okiYkErUvEEuAPkKt2HeQ8lHGMov7tCE5/cT7aTW/quD5SU59yIO55HEEHOjGkPQI2TWpJ5yoQ8bSxiVmDFK50QbUpGNr5/yUrDlkbroDycL7+k1EawJvtTHVIBEHNXlf/ZCRK85dDGgPds/tipDYlAk8k1Xwg5xLGZXiy2KulWbxzRnvtYe+LSK2WGh6BQYFUFF3EeEQeWjGZ/INZBXMbGT5aKungXBTHN5+gUx4g+2csM5gi0NoWX1ZM/jStQHHExX32AaQFpYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWfiMolyDKQi/jbXW1hPVN+uGNXxFVT7eYS+Q/J5T6o=;
 b=Cusa0xfPj2+d75mOBs2pl60Arq76mWRyIDAO3w3Wkhw2mkZFimEnzZJGlvIjOVZ/jCSxeZXuZ9jAtYL44m9Y/NNmya4VuAuaUduIhvpBEdXB02VMs0wtx8aqKKQTHtQgudwc5S5RKPziGXLGG8/zSbVfZGHVmfNybx2ujdFMFvigHZ8InSWV3O14lj395sHy038t5khACm2ezYWz2BeVB7qPzqW00pU+Bq8qfv8a3yyWHul8fR+gQ2vM4+LSPl1fDSy6egYFWPb+B/4NQEuEgkRgDWfvHCdC5e3kjjkcitu90kUGhZNJsQxyKj1ehTozzemEQG+fvWsJLKGNG/fsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4658.namprd15.prod.outlook.com (2603:10b6:806:19d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 18:02:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 18:02:06 +0000
Message-ID: <ca1d357f-7901-8b01-65c2-a832f49deb81@fb.com>
Date:   Wed, 7 Sep 2022 11:02:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next 6/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Content-Language: en-US
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
 <20220906133613.54928-7-quentin@isovalent.com>
 <CAADnVQJ3K7cLTz9tiEEevyhuYVCO6BfB5NhAssReyYU7MNAyKw@mail.gmail.com>
 <f0d9d219-3e5b-94bc-3c90-897da8d27b12@isovalent.com>
 <CAADnVQKJCwMbvkY5ZNX7KLiB9YT35TK_S_cFH61csm1P2phDDw@mail.gmail.com>
 <ca16b420-a4ae-9f9c-1f60-2e2b8df6b4a0@isovalent.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <ca16b420-a4ae-9f9c-1f60-2e2b8df6b4a0@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d0d679-b885-4c34-d325-08da90fb1338
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dxgi/xwJUYj/x3DBvlZf4V5j+61teQD9zyHgf+gDMH/RzPaLGFd/AgNjDhLcRwg6SlkFFk6qcWygQ5GxLeHN4Sz4bbywa6Q7IAV+0UkqjH80Vxfg8PjWBhv9mJrnCAU95lyATfUwL68R7AH4FXfnaN9gAw8nCPI0pTYRGFgnrhQuXhyy7ipmZcWnbsn48zB+pY0Wca/b+GdfBiY3Rt2ohLUcoseoojzfJXmfV4FhNosx2eaT9BB3x9Di7kaZUbZwaNljL5IZK8K/uUf1x6nVNylQu0BX/6tNCJab5ccC6bpPlzIWZuGF71DcdVD9wcJiQCoAQ9AcwOq6mb2obwurh+N6sVVzCALEH2mSJd2RcmicJNDC2v9rc65mswaitcX+V3z8rn9k1k3xPPJGNuMOUBWRFIXqkJcRZPy00L9ad+VYJcZeX59wWEuxqWSe3shlsjFaniH+KA5pjiTcPG6d2e+JPrR9OBu/QY3Vq5KfXtYK0J+v4TsmLCF1XpPD+FbxMeWrMFf+RHld3U8LCoImJUx2oT8VlrBQEJ1nNTufAcDnqu8Jh4swxQqgsfsWbQg+FrcZpx3D08sFM+9CHQwTyESYoa99hZ/s/U7FpQzqe+r7IglfddRcpym5bc9/te3LNC84hgI53Wv8GRQ+FrkqmKobIzCeZM/9txiiJbWwucG09aFWKJ7wpuALP0MdAy2apJ1t+106u1qBNNQHGGJ88rPAle1JweSYpm2Vua4QxQY5J8RX8EYqCzQrNbpWOt7kCnqin89qJ/o7R/NaA+wBNe5+LNrIWxjjmFFBumuuUnqtsAz/p1fctR4CEbokIWNY6L8lBp248ru73yRQN6y+oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(31686004)(86362001)(31696002)(4326008)(38100700002)(8676002)(66476007)(66556008)(66946007)(36756003)(316002)(6666004)(6512007)(966005)(83380400001)(186003)(478600001)(6506007)(41300700001)(6486002)(2616005)(54906003)(110136005)(2906002)(53546011)(5660300002)(8936002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlp0d0p6SEZ0U21UZ0NFdkpEaENzTUJoN1B6QzFFMTRtWkhUcEFobjh4Y1JS?=
 =?utf-8?B?ZUl2UVBqUnpNY2RJUWlaZWtwa29NYSttbjQyTDdIN0F3cmtUSE1FSTBsZEs0?=
 =?utf-8?B?UG02aVZzVHduZk9lZnlHSW81SHhMSFFlSlFBZnJSV1hiRFVlZkZpVi9zaisv?=
 =?utf-8?B?ZmRGWWlDRUpoYklvTzVESGdyZ0NsdEhUUC93N3JNT3hIMjd6dHowcVlTUnEy?=
 =?utf-8?B?b1QzSW9oN2dJOGhWWDFVRVl2alhtUmhDbk1QMGFDd3pSNHgwZkplNnlNaTl1?=
 =?utf-8?B?eldhNVVIZ1VhWGh4d2JkKzdJN01iYUg4bVpHWXZSNnd2blBabVZob0xISURh?=
 =?utf-8?B?bmhQdjJERWppcUUzV1RHeDNDU1ZSY2VhSGcvQ0RnWVEzNjVNZFhIYWZibHpI?=
 =?utf-8?B?dm5hamh2M3R4Y0RsY3MrY3RNVGxXQmNreEJrM3pUQm5iSjJVbEJFNTlVY3Js?=
 =?utf-8?B?bXZzaFpZeC9FRjNzajRhWWlVTnF6Ty9XdGdCV2xtcnpGWWJDenFjQ2dDVlpz?=
 =?utf-8?B?emg5TWlwYk5WcnVjNzVTckQ2Z2ZlSVliWGk3Vnd0R2NpdENGZGpKMVRXcmVw?=
 =?utf-8?B?TU01c1d2L2ZidUg3Tk9Cc0ViZElveU0wYmdtYWpCS1d5ZDFpd3RPNkl3aDRB?=
 =?utf-8?B?WjhtNGlWRlYraWl5dWM5YVFLYTRBYjk0bFo5am1NOWpXenBsTGdrYyt3VlZ2?=
 =?utf-8?B?T3IvNEhCT0FGV2hMc1BjMW42dzF0OW5nL1FFWUczTVBpWGI0VU83RnhERU9j?=
 =?utf-8?B?VURjeE92MWkvV0FzRFRVSGUzbXQ0dlZXVURwWld1ZldvUW1HekRUZlk2djFU?=
 =?utf-8?B?YUhIandHZG1aSUNyQXFHUHBHc2svVTBodWpaeEgrTlpTaTIySjdMVWNzNVM2?=
 =?utf-8?B?RFBkWFJlZlR1UytwbUxSK0pPZFpudXNXY2xGM2JiMmxCc09sRzNibk55UndZ?=
 =?utf-8?B?YzJDY2pmMFlZZ0JkeXpDSjR6cXp1cm85RE9YeGhrRW1GdjJwRVJ2RC9uVmhn?=
 =?utf-8?B?S211OXQ1Tll5Q0Fha3BkYUFYRjFOZWdITGpaOTFvMWlybWxTdUVhaW5hWFZC?=
 =?utf-8?B?TnBQRkxPckJXTmZKOHJzcjUzRGI1djhUMDFiOCt0QnplNjRweVBQRCs2WjlI?=
 =?utf-8?B?K1ZtcjlET3lKZHplNVRBWi9RZWhQeS9SWTJlQVZaM2Q0MWh0N0xRdC9TdEpI?=
 =?utf-8?B?Z04yeGRONzhNdHJncklxMjAwYVBFRkdOOGNtVHJjVjZBSVk4M1hpbXJaVDBm?=
 =?utf-8?B?YUROOVEwT1JBa1paZEorTFFzTGxZZHF0TEZxU2M2Y2toMklOWW9RQTd0Vkw4?=
 =?utf-8?B?UjBLS0UvcXhrU3RUTjlCN3VDMU9Hek0vaEdWOUFSWnNBYlBnOTBUR3I4YkRD?=
 =?utf-8?B?Sm1HNkY5RFUyYXVPSFJKN0FGbFdxZEl0emlnR0o5NjNja1VCVHVmNnNsalZE?=
 =?utf-8?B?Y2kvN005YnNaVEhtVVJYZXRVdTJzSmRaNHFETCt1dnJVQTlrZEdNM1g5RzJt?=
 =?utf-8?B?dTdhUmZBRUU2S05yN3FYenhBY25yMGl4R3hCVFUzdHYxNXJ0aHdSUDZZQm8v?=
 =?utf-8?B?ZWZSR2J0N3V6SmhoMndqdGxJUEtRU0xwbXZPTGt3RGhleVp3L2NZNkxEV1RY?=
 =?utf-8?B?eDUvSHV1SkNOTTRZMUlkQXdzbkR3ODJlUnIzbm9ZY0paVHNpMHhvTjIvdWxD?=
 =?utf-8?B?TThGRytqTWMvNkIrRDJHYVE1MFhIVDlFNmRlbXdzWE02NGwrcmN5cUJzRjBJ?=
 =?utf-8?B?bjh6WlNyQ2Nna3lxejU4K3JpN0ZWSEFkQW1XR2tZTmZ4Nnd6eEh2MVBjbTVy?=
 =?utf-8?B?ME9OcnFjRjFmL3p2Mkpqa29HcGs4K1ZYZUFhWDJDbnJadVBJTkxnWG1lTVhS?=
 =?utf-8?B?K0x3YzFlUDhDdXBQWlRRWStZcW8xT2NZMGhDaG9BbzBUTVozSi9VWmd4b2Vm?=
 =?utf-8?B?UzMzR3pjRXhmUnFZMVdlU2JvSlBZS2pFYS9sY0c0VzFKbjF6b1VQTlkyU0o2?=
 =?utf-8?B?TjhFdloxeDAzelRnbzBWZnpzRkZNQ0s3bGRLTzQ0Q2U1OVJhcDhtbzZ1THhQ?=
 =?utf-8?B?eDNrcmdSaXBkaWJhbEorY2dHSFRSeWgveVNCTDdvYzVab3ozcmw4THNTOXFw?=
 =?utf-8?B?NVB4Q1poRk1UOWZMOFNBMUdiaDYxV2NUUE5VeFhSbzhuZ0p0Q3JMbmV1dTRQ?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d0d679-b885-4c34-d325-08da90fb1338
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:02:06.1434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMGOgTBJNrC7HISkDg45CWAXRCe0Iy26u/vkeoRy23QfIdvUNdZTdFjRM5HRt1Hk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4658
X-Proofpoint-ORIG-GUID: G6-Wizv-vTCNOjc6dyUS1K98n0OhwINe
X-Proofpoint-GUID: G6-Wizv-vTCNOjc6dyUS1K98n0OhwINe
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/7/22 9:33 AM, Quentin Monnet wrote:
> On 07/09/2022 17:10, Alexei Starovoitov wrote:
>> On Wed, Sep 7, 2022 at 7:20 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>
>>> On 07/09/2022 00:46, Alexei Starovoitov wrote:
>>>> On Tue, Sep 6, 2022 at 6:36 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>>>
>>>>> Naturally, the display of disassembled instructions comes with a few
>>>>> minor differences. Here is a sample output with libbfd (already
>>>>> supported before this patch):
>>>>>
>>>>>      # bpftool prog dump jited id 56
>>>>>      bpf_prog_6deef7357e7b4530:
>>>>>         0:   nopl   0x0(%rax,%rax,1)
>>>>>         5:   xchg   %ax,%ax
>>>>>         7:   push   %rbp
>>>>>         8:   mov    %rsp,%rbp
>>>>>         b:   push   %rbx
>>>>>         c:   push   %r13
>>>>>         e:   push   %r14
>>>>>        10:   mov    %rdi,%rbx
>>>>>        13:   movzwq 0xb0(%rbx),%r13
>>>>>        1b:   xor    %r14d,%r14d
>>>>>        1e:   or     $0x2,%r14d
>>>>>        22:   mov    $0x1,%eax
>>>>>        27:   cmp    $0x2,%r14
>>>>>        2b:   jne    0x000000000000002f
>>>>>        2d:   xor    %eax,%eax
>>>>>        2f:   pop    %r14
>>>>>        31:   pop    %r13
>>>>>        33:   pop    %rbx
>>>>>        34:   leave
>>>>>        35:   ret
>>>>>        36:   int3
>>>>>
>>>>> LLVM supports several variants that we could set when initialising the
>>>>> disassembler, for example with:
>>>>>
>>>>>      LLVMSetDisasmOptions(*ctx,
>>>>>                           LLVMDisassembler_Option_AsmPrinterVariant);
>>>>>
>>>>> but the default printer is kept for now. Here is the output with LLVM:
>>>>>
>>>>>      # bpftool prog dump jited id 56
>>>>>      bpf_prog_6deef7357e7b4530:
>>>>>         0:   nopl    (%rax,%rax)
>>>>>         5:   nop
>>>>>         7:   pushq   %rbp
>>>>>         8:   movq    %rsp, %rbp
>>>>>         b:   pushq   %rbx
>>>>>         c:   pushq   %r13
>>>>>         e:   pushq   %r14
>>>>>        10:   movq    %rdi, %rbx
>>>>>        13:   movzwq  176(%rbx), %r13
>>>>>        1b:   xorl    %r14d, %r14d
>>>>>        1e:   orl     $2, %r14d
>>>>>        22:   movl    $1, %eax
>>>>>        27:   cmpq    $2, %r14
>>>>>        2b:   jne     2
>>>>>        2d:   xorl    %eax, %eax
>>>>>        2f:   popq    %r14
>>>>
>>>> If I'm reading the asm correctly the difference is significant.
>>>> jne 0x2f was an absolute address and jmps were easy
>>>> to follow.
>>>> While in llvm disasm it's 'jne 2' ?! What is 2 ?
>>>> 2 bytes from the next insn of 0x2d ?
>>>
>>> Yes, that's it. Apparently, this is how the operand is encoded, and
>>> libbfd does the translation to the absolute address:
>>>
>>>      # bpftool prog dump jited id 7868 opcodes
>>>      [...]
>>>        2b:   jne    0x000000000000002f
>>>              75 02
>>>      [...]
>>>
>>> The same difference is observable between objdump and llvm-objdump on an
>>> x86-64 binary for example, although they usually have labels to refer to
>>> ("jne     -22 <_obstack_memory_used+0x7d0>"), making the navigation
>>> easier. The only mention I could find of that difference is a report
>>> from 2013 [0].
>>>
>>> [0] https://discourse.llvm.org/t/llvm-objdump-disassembling-jmp/29584/2
>>>
>>>> That is super hard to read.
>>>> Is there a way to tune/configure llvm disasm?
>>>
>>> There's a function and some options to tune it, but I tried them and
>>> none applies to converting the jump operands.
>>>
>>>      int LLVMSetDisasmOptions(LLVMDisasmContextRef DC, uint64_t Options);
>>>
>>>      /* The option to produce marked up assembly. */
>>>      #define LLVMDisassembler_Option_UseMarkup 1
>>>      /* The option to print immediates as hex. */
>>>      #define LLVMDisassembler_Option_PrintImmHex 2
>>>      /* The option use the other assembler printer variant */
>>>      #define LLVMDisassembler_Option_AsmPrinterVariant 4
>>>      /* The option to set comment on instructions */
>>>      #define LLVMDisassembler_Option_SetInstrComments 8
>>>      /* The option to print latency information alongside instructions */
>>>      #define LLVMDisassembler_Option_PrintLatency 16
>>>
>>> I found that LLVMDisassembler_Option_AsmPrinterVariant read better,
>>> although in my patch I kept the default output which looked closer to
>>> the existing from libbfd. Here's what the option produces:
>>>
>>>      bpf_prog_6deef7357e7b4530:
>>>         0:   nop     dword ptr [rax + rax]
>>>         5:   nop
>>>         7:   push    rbp
>>>         8:   mov     rbp, rsp
>>>         b:   push    rbx
>>>         c:   push    r13
>>>         e:   push    r14
>>>        10:   mov     rbx, rdi
>>>        13:   movzx   r13, word ptr [rbx + 180]
>>>        1b:   xor     r14d, r14d
>>>        1e:   or      r14d, 2
>>>        22:   mov     eax, 1
>>>        27:   cmp     r14, 2
>>>        2b:   jne     2
>>>        2d:   xor     eax, eax
>>>        2f:   pop     r14
>>>        31:   pop     r13
>>>        33:   pop     rbx
>>>        34:   leave
>>>        35:   re
>>>
>>> But the jne operand remains a '2'. I'm not aware of any option to change
>>> it in LLVM's disassembler :(.
>>
>> Hmm. llvm-objdump -d test_maps
>> looks fine:
>>    41bfcb: e8 6f f7 ff ff                   callq    0x41b73f
>> <find_extern_btf_id>
>>
>> the must be something llvm disasm is missing when you feed raw bytes
>> into it.
>> Please keep investigating. In this form I'm afraid it's no go.
> 
> OK, I'll keep looking

Quentin, if eventually there is no existing solution for this problem, 
we could improve llvm API to encode branch target in more 
easy-to-understand form.


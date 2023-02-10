Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB576925D4
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 19:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjBJSyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 13:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjBJSyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 13:54:20 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2678D45
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 10:54:19 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AIRvV0018006;
        Fri, 10 Feb 2023 10:54:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=iwqbRsmxm7sr1DsifgBmUbnVZwqoOpPZIdus6a8M+Mw=;
 b=gAYnxVIzHxe3z72p9ZTC+hbIjAZBOoya6F1DwRiYInr2zsXPI0BkhlASPr31X8jJ9OWp
 uHb+QWgGpjWiDXdsl9stVjbAqiGsiFVTka8kqBuYWGMjM2abIKtkUWsrYYbRxNHjcKd4
 IwfgzLUdkhBiwTPi68XP5myqijWP/3n7218LmM3whGnqdtbvM7kVojUICgvxYkuarYzZ
 M2rdNdqK8YXI1cBkJZ47Iu0qYQsylIVLJtXLc6gt5qs+r2UKNfijHCe6PpHk+DdLvN4N
 UlJGyBrP6gMCT71airfpwk/t65XqNZzBZU+5fkaP9hyuud2tv2xYxrM1JAZm7y7Tb+r8 fA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nn0xfautb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 10:54:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0Wb/tX2Dj3lxtpCb28e/V5+03w27EqxMS8kUrEMelGmOAXmb24m+tH8xVRfw2llWmatv3SbuTN7wat4LYXLIFyL22X80Cx7iOBpUkVFSgBOkYMbtxeMX9uCXIlS/mtsFiW+Gd+u0+62emvsP/g3BqmvtCS/MhI8elGd1gHzjjAMB2lbRFR/gqZf/sNgdMXDpGWBTAoX3Ql3WZ5mekVNnaPw/2Ki4om+h2hpHZuS/5AGHTZXhQg1MrKfKezl5SFlaTRN2i3bBbXnWQ3UJPJucgVKpKUI6hQvrugf3mNF9t04vSVnIyhETbTovRLE5/YrKiLqy3Ki4EijYuAiUXjrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwqbRsmxm7sr1DsifgBmUbnVZwqoOpPZIdus6a8M+Mw=;
 b=c3EdWVNSVG9hRhB4irgSBkW6uHQHcc4+G35we0M8SkbNChyMgKdTRekKy7ITC02NGIes0N6aeqxK+TkULjfOfgz7qRH5gLMdOu4e6b0btUiIh5p/IESLw0FHduX0avcZSbPKFslKc6sZqWuUAfDdlpDCb5lfYv4etU/tj790e5t1YYpJn6CxmDdSwQylElvMUpKEM/NnWCTdMCpkTSTFnEFq2aMhpBS+tUL/fA7CS778OmmwcwupWcmqb+33cSC/lMnHUwbINFtN1xP+bo1nuXIxIRZMx0J6iefaqwPinK6BgqnwD0V49S2YI5HlRCP7SV2a4FqLD9RMnKiBxQvLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4660.namprd15.prod.outlook.com (2603:10b6:806:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 18:54:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 18:54:00 +0000
Message-ID: <84a318e7-6f61-2912-7065-1e10a9e39e72@meta.com>
Date:   Fri, 10 Feb 2023 10:53:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
 <CAEf4BzZwTGWWvhMgNvNqrA0MurMeczok4Jz5dMWrvfKT2avPrw@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzZwTGWWvhMgNvNqrA0MurMeczok4Jz5dMWrvfKT2avPrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6a32ed-75f0-44c2-ed7d-08db0b982c02
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fR+aluGpZwRVtgTaHsbPS2RvrERIJpIWUPg2owPtWUoYpvyvmE3kJw8AYD9zb8DQrKuVMJIzd9iHqBwUuJnZRbIObyKSwcXRz9uJqjphdyFLqAh5hYrl0dAgFsDA3hhEp4yy1BSBW/ZsgltIDzTfJITDwlm38cr/i/cyehKt/M2E17SqTFMpZRHgIuMGjAwLxGES+mGqd3Vm9mvQURDMXf0RIzrJPNJNnXWwtmAxNfV2JjbKvoytRZHmWXFzhf5TprmUGlhzwvmMmLuh+9n2roHZGW3cP8nv+YrSXTm+KpL6C33syMp4ZG+tlerege/5IZVfK7BbDkeRb6C9uqZoVq4/qO1qVEXuKpdxfI2fPJTd0uogUXAWnwFUswWTqIl/UjEJxoxeiMHJwo07CtVgRHomf9qUEUVZUDr1NpjFE7MYllSt775Pb0WQhjaR1Z9JzcpJd+NQhCa0m/TNT5R+yGPmjcGhxs7arM0b6roAeCQG3B4A5TEhq10u4XeYQjFkVaoVQdy34uaZ99xqSQqUkg6AZb+/cBjGCZkTJuqnkCCkDIB3ao/hZvNQ2/1hXAFwAvp2F7GFpz0km7zHIWySk6GkpqNsGliVgNqxPKb+s2+NOeQj5vTwVe3+J3zHIyEm5tW8ShkN8rAwVh/QcfCqtuC/hESzY1nCLjn1r1SNo8R70nd0W3jbLKGJdrj6tWflEg4jhWH7Wa2Dy1aWwdwx6gFqXJJfR/yzf/sno0YFVsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199018)(36756003)(6486002)(6506007)(478600001)(186003)(54906003)(6512007)(316002)(8936002)(41300700001)(2906002)(5660300002)(4326008)(53546011)(8676002)(6666004)(2616005)(66476007)(6916009)(66946007)(86362001)(66556008)(31696002)(31686004)(38100700002)(66899018)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhybTRzSWJQMnFLK0cza2Jpa3NESGorS0trZlMySS84ZmFabjAwbEt4QXN1?=
 =?utf-8?B?RXlGQU1UODd6dkpDcEpCTFVZUFJGQU10WnkxMVVWc2E1TnZaaW81amE4Y3JD?=
 =?utf-8?B?VUcyU2dvbmZEcUtwRUg5Z3NoVHRBZFJKdXJ0RktSOGVFdDlGdGE1UFZlaFRF?=
 =?utf-8?B?NjZkTjBlaUF2V0dHMHlXUzZGTjIvb2JQZ1Q3b2pTU2FBdHdrN3JQYmlNekw5?=
 =?utf-8?B?SzU4VDEzcjZIckU5MENJZ3hESlVjSjVUbFkxQU9SZHNpcVMvY09yTTVFRXM1?=
 =?utf-8?B?MjVvZ3ZIKzliYWtZdDQ5d2hYVlVOTUFmbUZJZHVXd2k0cmRtNWdtNzFqMmZL?=
 =?utf-8?B?WE00clFPcFhST2VMWFJMM3IxNlBUOUdLSzR5TnpQS0dwejk3TktldXJONmJC?=
 =?utf-8?B?UGJZTEtPR1h3eDVkZnJ2V2RCY3B4Zm13eFBncFBNK2JxZTB4dWxGUGFjTjRD?=
 =?utf-8?B?OFFsbjEyM1RhaWhSVGtIdzhyZlFwSEhBUE9PNjkxa3cxV1Azd3drYmFtS0Nq?=
 =?utf-8?B?cUZMcVBxNG1BRWxsMHpWeHdON2MyTW50emFMZ2VrSHQ2S0hUSjV5YktEZU9W?=
 =?utf-8?B?UTV6OUVERzd2YVNDZVZ5eTFrS3BnWjlVMHZud3BDalhNYVUxb2RRODBHalhI?=
 =?utf-8?B?Zk4vaU9yS2h6NlBRblV3Ty9RRTdhZGdyVnZ2TnU4WW9NQlFkMC80czNTWWo4?=
 =?utf-8?B?c2Vwa3VBSEhsZ29PU0lGdDJocFlRWWFXeDRrV3JtaFJZRGNaMEU2REtsMkdl?=
 =?utf-8?B?UlhzdHNzZXdJRGFOeFpwL3hRMGIwOUFFZWdWbE9pdEVRMVYyQm4xazNPNThU?=
 =?utf-8?B?Z2VySWFKS3VhZ3ZlY3ZNcFZTZHVjd014Wk5uUTZrUGNKekNTQzBaREJUMlRk?=
 =?utf-8?B?Ymg3SUl6cG5qbVBSblhZaEJmSXg4OE5VY0RCbmpuZk1kWmVNRktOK1MxNGFn?=
 =?utf-8?B?RWVod2pyTjJobFVJc2ppc1Azc3ZSSDlJd0c0NmNQNEhzOXNzNGZXV091c3Bs?=
 =?utf-8?B?QzdxUi9iS0cvUk1zYmlBdE90YlRYZGZuVUpienpscGZsY1pzV2ZMV1l1QWtq?=
 =?utf-8?B?djk2d2VUTExvbDJXT3dFS0dpR3BHcjlaZWs3SHptRjRISDhMOEJxTTFoZHJS?=
 =?utf-8?B?T3UxVCtyR05COEt1OXhCVXh6R2ZwZ0pnczVjcEFLdmM1L0I0SCtLWVhhTlc3?=
 =?utf-8?B?d3ZKeHI5ZzlGVnlDemtlZjVUTkpycHF4OSs4cWZwN01jZTY0RGw3Q0lPY3lH?=
 =?utf-8?B?eWljWFl6VnZvaGJEZSt2MmdKeXRtVFJPQVNvZ21JWTNCRWtWZ1pYL01HZk5k?=
 =?utf-8?B?ck01THY0d2N1Y2VaZ1h6U2xONUh6cVl5UjFvVU1vbk9rR2xOU0NPazllcmlG?=
 =?utf-8?B?Mmd4cUp6M1JENkVZdzdYL1JXNjFNeDl1SUk4a2V2VzgwRGJheWxWak1HMU1V?=
 =?utf-8?B?dUI4QXdjeGp0NHlIWkJ3WEl0S3VCaFF0aXppNE8wTFZLaVZuMERvWVlZTmhE?=
 =?utf-8?B?cm1yenRZODUzenNEdk9LdzQwUkk1UGttNFFLbXVQWFdGaVpHZjFycVB4RXc1?=
 =?utf-8?B?ZzBmdGZhOXA1aWgxOUFydzV1MjlDRWZ1YTA1Mkg2WGJjdmxIRG9BL09oeGxH?=
 =?utf-8?B?azgrZUF5K1Q3MVRGdWFFclNUTTM3aEt5VGMxWGdUb0VOZXZUdGl3VUxTSGla?=
 =?utf-8?B?UGdtbG8yTGdPNDEwclZDWkdkRmRyYjgxb2VaRStVSVMrb0I5b1J2eW43Snk2?=
 =?utf-8?B?ZU1oem44ajNFU2E5aHBWNjN4WWc5bDJVZGxVemROVlpOdEVoOVpMVTVFa2FR?=
 =?utf-8?B?SXFsTDY4Z2JtM0dic0hYU0V0REhXU2tXNmZZeWoxNVFBNmZFQnRla2ZCS2ZV?=
 =?utf-8?B?b3RVMlRyamVTZGp5cVBoRFhDNXRlTHI3eDJPd0VjM1Eva1lEd1krQWh6RnpB?=
 =?utf-8?B?eVUvalMwb1FyNFFvVkRTVm9lSDErT3F6LzFVKzdSZnVtRGRsWUpSNllIUWJ4?=
 =?utf-8?B?aEcwOGRyS1RkRGFZL1ZyV2pqWUM0amlrd2hTT2xGWkJubm1SSkFRQkNKcFZM?=
 =?utf-8?B?eGlwbkpNdGFxL3gwaUxSaE8zWW9QSmgrdllWbGx4T25xaFlrUk95aFJsSXM0?=
 =?utf-8?B?MGhJb1hSVHpESnNtUlJvZWJsTnd5LzA4MVpQU0E5WnkyVGxpQk1xczRWeHls?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6a32ed-75f0-44c2-ed7d-08db0b982c02
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 18:54:00.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIVnbRUJwFFImIFOTAzAWfCelmPQShso3X2/3GYIvk4QidStHD/Fk018NzIhLSv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4660
X-Proofpoint-GUID: i9s1ZhmwWCor2jCDqQUi7v-DGBRwyJPi
X-Proofpoint-ORIG-GUID: i9s1ZhmwWCor2jCDqQUi7v-DGBRwyJPi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/9/23 3:39 PM, Andrii Nakryiko wrote:
> On Thu, Feb 9, 2023 at 2:55 PM Yonghong Song <yhs@meta.com> wrote:
>>
>> Over the past, there are some discussions to extend bpf
>> instruction ISA to accommodate some new use cases or
>> fix some potential issues. These new instructions will
>> be included in new cpu flavor -mcpu=v4.
>>
>> The following are the proposal
>> to add new instructions in 6 different categories.
>> The proposal is a little bit rough. You can find bpf insn
>> background information in Documentation/bpf/instruction-set.rst.
>> You comments or suggestions are welcome!
>>
> 
> Great that we are trying to fix and complete the instruction set! Just
> one comment/question below for condition jumps.
> 
> [...]
> 
>>
>> 32-bit JA
>> =========
>>
>> Currently, the whole range of operations with BPF_JMP32/BPF_JMP insn are
>> implemented like below
>>
>>     ========  =====  =========================  ============
>>     code      value  description                notes
>>     ========  =====  =========================  ============
>>     BPF_JA    0x00   PC += off                  BPF_JMP only
>>     BPF_JEQ   0x10   PC += off if dst == src
>>     BPF_JGT   0x20   PC += off if dst > src     unsigned
>>     BPF_JGE   0x30   PC += off if dst >= src    unsigned
>>     BPF_JSET  0x40   PC += off if dst & src
>>     BPF_JNE   0x50   PC += off if dst != src
>>     BPF_JSGT  0x60   PC += off if dst > src     signed
>>     BPF_JSGE  0x70   PC += off if dst >= src    signed
>>     BPF_CALL  0x80   function call
>>     BPF_EXIT  0x90   function / program return  BPF_JMP only
>>     BPF_JLT   0xa0   PC += off if dst < src     unsigned
>>     BPF_JLE   0xb0   PC += off if dst <= src    unsigned
>>     BPF_JSLT  0xc0   PC += off if dst < src     signed
>>     BPF_JSLE  0xd0   PC += off if dst <= src    signed
>>     ========  =====  =========================  ============
>>
>> Here the 'off' is 16 bit so the range of jump is [-32768, 32767].
>> In rare cases, people may have large programs or have loops fully unrolled.
>> This may cause some jump offset beyond the above range. In current
>> llvm implementation, wrong code (after truncation) will be generated.
>>
>> To fix this issue, the following new insn is proposed
>>
>>     ========  =====  =========================  ============
>>     code      value  description                notes
>>     ========  =====  =========================  ============
>>     BPF_JA    0x00   PC += imm                  BPF_JMP32 only, src = 1
>>
>> The way, the jump offset range become [-2^31, 2^31 - 1].
>>
>> For other jump instructions, e.g., BPF_JEQ, with a jmp offset
>> beyond [-32768, 32767]. It can be simulated with a
>> 'BPF_JA (PC += imm)' followed by the original
>> BPF_JEQ with the range 'off', or BPF_JEQ with a short range followed
>> by a BPF_JA.
> 
> Why not implement the same approach (using imm if src = 1) for all the
> conditional jumps? Just too much JIT work or some other reasons?

We cannot use 'src' since 'src' is used in conditional jump, e.g.,

   ========  =====  =========================  ============
   code      value  description                notes
   ========  =====  =========================  ============
   BPF_JEQ   0x10   PC += off if dst == src

In this particular case, there is no good way to extend
the insn with range [-2^31, 2^31 - 1] as 'off/dst/src' all
used by the above insn. The sample extension to original
BPF_JEQ seems not working so I came up with the above
BPF_JA (32bit range) + BPF_JEQ(16 bit range) approach.
It is ugly and increase implementation complexity, but
considering this is a corner case. It may not be
worthwhile to design a whole range of 32bit range of
BPF_JEQ/JGT/... instructions.

> 
> [...]

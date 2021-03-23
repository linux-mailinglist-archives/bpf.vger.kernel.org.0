Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41673461E2
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhCWOwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 10:52:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232394AbhCWOvv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 10:51:51 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NEmvwb005305;
        Tue, 23 Mar 2021 07:51:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=1eEB4VxhlfdMvPpZQF/AaFLvlmuJYDj+qE4SitByHuc=;
 b=dTydPGG1F/6B4D1cVPAWcY5L3JsW0sFLOU5iYkjPEfmUNN7cNrnQXEFXE1YuiejyhP/1
 +XtitsEDG2Ksa4YWKRRbgV2i6b/g75e5ls6rxiNgREc6OhNK5NlUUH2GGc0xRN0naDrD
 xxqIXwc9RyrsPdSZB0huUtzCetBBZ8i34rc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37e0rhm3c4-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Mar 2021 07:51:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Mar 2021 07:51:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnKOd/9C1TmdQEeftawYXnQBU/8ACzkAP8SI36bs5SMKKB0Mqa8q9qZSRCP5+C72MupN4ieZLi4rqMRDepyHDr5Ncf2wly10S/6f7iYvtCEpfS0rkted+PJ4DyhuOWsDvQj8QvCJdQ4DNIOgYe8QdLEV0B3UHlmlQeoEg3E5BTk8r6iLIf0RRnDuRD6PKVF16PXqhEHBDCGuKrzfhQ3galLaJvpBZ2RjFPjr0MpIpG5KdyiNmDOWUwOUJn3QnaP18bv8xcC3pIyYBvRrmSP4qyCFTKb5rBeCWZ2//ddP/KJyoUMJcg+ttFfyATBnf4BOonDp12nXxUD5iGnPqSGuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eEB4VxhlfdMvPpZQF/AaFLvlmuJYDj+qE4SitByHuc=;
 b=Vw1d+8KdhBWHZtCZ5Wn9jT+EyS3u9h6KwhlhPl1Ko0XWo1bw2ULYGSFV8vwBNjBhusw8ToHMC4GZWtlwz2kk4F4IUX42aMKnBuMieRWy1IC5PTjySNeyPcXLYL84mdB9tWzvHpL3MUawCsCZjKdJ9oa+CTu7NYtMdGACRwwH1jnwkEpQUSEu/9Kz32EAk0Cs29j23pvRsOqD1t2OuxpWnbFWcoc6zlE26MhQKBTOYwcIzoFoTtoh5w34TeIsVyjsKmgJXnuGCoQMBGzYdGtkaK75RJNHA1mluOiB4RBCp/5IUyLi+HHo4Um7fkeDLcSw+vyTFkmp35EsoIWiWZNFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB3289.namprd15.prod.outlook.com (2603:10b6:5:165::25)
 by DM6PR15MB3051.namprd15.prod.outlook.com (2603:10b6:5:141::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 14:51:00 +0000
Received: from DM6PR15MB3289.namprd15.prod.outlook.com
 ([fe80::f5c5:b681:9d22:70e8]) by DM6PR15MB3289.namprd15.prod.outlook.com
 ([fe80::f5c5:b681:9d22:70e8%4]) with mapi id 15.20.3955.025; Tue, 23 Mar 2021
 14:51:00 +0000
Subject: Re: [PATCH bpf] bpf: Fix fexit trampoline.
To:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@redhat.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <paulmck@kernel.org>, <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <20210316210007.38949-1-alexei.starovoitov@gmail.com>
 <YFfXcqnksPsSe0Bv@krava> <YFjEt42mrWejbzgJ@krava> <YFjnlqeqbkST7oPb@krava>
 <20210323085900.3bdc0002@gandalf.local.home>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <6d8ad633-b464-0a72-a310-2dda27dfeb99@fb.com>
Date:   Tue, 23 Mar 2021 07:50:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210323085900.3bdc0002@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:7d9f]
X-ClientProxiedBy: MW4PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:303:b8::18) To DM6PR15MB3289.namprd15.prod.outlook.com
 (2603:10b6:5:165::25)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:7d9f) by MW4PR03CA0193.namprd03.prod.outlook.com (2603:10b6:303:b8::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 14:50:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a590e90-1621-4db9-b8bb-08d8ee0b12c0
X-MS-TrafficTypeDiagnostic: DM6PR15MB3051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB30512FC37056B9EAEEA49FCED7649@DM6PR15MB3051.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEJxrJOhzJc4JZ9jE03MB2op3iaaASaB9JhvYSClxwxAYBAun+UBuVd2/b2VjdBs15KJq1ZTC4du1fUACcFbKO0kkEEyiB49508EWBwo0nm6cWCG/yP0Rhu9JW7eQeAit++B6NmM7WaEpucVe98u2ftAtB6qwqeMrUup4K9mu31HWB9NIo3vKtDREG4zka4XG5evVHgStPvOXlPd6P7K50XG/vUcHMNAvbX72sQpFf3QoYgT6PVtOxOQeK1uVqdSJWe+6Y8zxJSnrS5qr0wGmxipG7e3e1Oz8JGg3MUONf4hq81NpFutsNhpr12Gm2iH8/89xw6IF5H/rgWlxOnb1jN97rpgiCkhEQIyvam86rkdl65VlrvGmRMPQfIGKgsJrHp3S3tlhAKi23BYW8zjaNRKMxDblR7XPhw9WOLcQHPld/sQRCnjWt9R8XEHsyw3DFkk+oD6hE/qgl/DPbRxgz0KV4Rdbt80qeX9sDYYMQK7eSIylT51tSMDUDiPn5gFcW17GJcRzsgQWfUovbr/cIVP7l2FPkfHgSAseiG9RMyF4MK7mNIZ9b4vPPDb3/xRrSJJkmCqWElWOxjNUurf60PKgn7h/F6FNZFdSLR1I3yj1r8cvSuR8Usb/gLrfUv6/UbEp5nNoO4e/RTc1jyv2m5KUzD0BYz2U4rMOU/4IujTTc64KNxnNoRzcKrzYXbS2BMuZvkSjVxZLLKDwwJLl9TncHI60Zw5aSXdM5skQdSTJA1URwDqFvMCX5K9FiLNFFgMOXtpWsJB9L2V14tmDR5lDF1S3t9c9xGEpxFPO4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3289.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(53546011)(966005)(478600001)(5660300002)(6486002)(52116002)(36756003)(16526019)(186003)(6666004)(38100700001)(4326008)(31686004)(110136005)(66946007)(66556008)(86362001)(31696002)(2616005)(8676002)(2906002)(66476007)(316002)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S3dpdlJqeERYRlhSM2piQktpdTNRYnBqeHowcitaZFBuMUJ4enQwZE1Dd2xl?=
 =?utf-8?B?RUwxdnk1UEFtTjFaMjNkcEROTmZFNk56UHphUDJydTRHWW9iYjZhQU9GTG5h?=
 =?utf-8?B?b3JhZ3BzcDY0bmZkLy95dVdQWmFYbTloRmtyd2NPQUVnSnRLb2czLzBUWmhr?=
 =?utf-8?B?bVVCNmhBaTBJVFh3TUxqR2xHMGZRK2x3Ry9uTnRLMXNUZ2lUUWswRm81bXBm?=
 =?utf-8?B?OTZQWnNMbU5EM0N2czNValR0MHlaRjRCMXFVaXROVktmNUtPc1pvK1l6bG02?=
 =?utf-8?B?RTE3QWdoYTVoV1MrVkhiczBxN0xkZ1RXaHNvanBka05ldjRSbmFSN2oxMnBU?=
 =?utf-8?B?eEIxdExFaFpjQ0k3VkNpb0Q3eUhmVFVpNURHclBZeTJUQU1SVHI1VXQ5cVU4?=
 =?utf-8?B?bXhYS3FlWGN6Y04yZ1hWeXJBbWhLRFNQUzZRclZvZFpmT2Yyd2EvdVZwQ3dK?=
 =?utf-8?B?TW90K2RBNkFzRmEzVW1RbVAzMjkxbWIrTW9MR3Iya2Q3VmRFbGVSQUFQWjRj?=
 =?utf-8?B?clJ3ODAvNEduaWtYWTZ5Y2YxL3pFN0o2LzFYMFovUkNCcDROQU0zc3l6dDZr?=
 =?utf-8?B?OFVha2ZyOXUrLzJQOGVoa1N0dWU1czVQWWd4R1ZndWlPUW54R2FCZ2dtbFRK?=
 =?utf-8?B?eG4vblYvVGJabGNrN1FhZWw0Vzd0amhmTmdQa1V6MFVscjlWSGhFSnpCYUho?=
 =?utf-8?B?Y3U4RlJieGdSMkR0cEhPL1NiSk0xdnFHKzUwVG1nWkpINXc1Znc3T3Y4MjA1?=
 =?utf-8?B?dFhyc1hPV2tEbDZQckRGTFZiM1VHdVFKT2JydmR2V1Fad1pielBLK2RZUnBq?=
 =?utf-8?B?YytaSDNaQWFmTzRPZitJWjR5eFRZWnV5UmoxRUx0eUZRajdjUTFMSy9TREow?=
 =?utf-8?B?M3p3SGJESDMzSmo0THhkWEhGRUVxS0wwR2NWeGZpSG1mSmZvY2xxU00xVzc0?=
 =?utf-8?B?K1gwRm9CZkV0U1VzWWgzRzNPL2h6ekhmemNSMEhIK2sxYXVja2QwRkJadnZO?=
 =?utf-8?B?bU85R1pmTmEzSkh6Q3hpRmdNYkR5Nk9rT2htV25jS1U3UHgxcXVITndGMTdT?=
 =?utf-8?B?d20xZG5uV2hrb2k1WmJQcmc5NVVSNWRIUTlOdDRnb0FITDZyTmJtSlV4aktY?=
 =?utf-8?B?TCttS3Y0d3MrWDZXZTVMM3c2K0ZpSE41di9uZjZoZ1VFNUc2MnU4Y3hLem9o?=
 =?utf-8?B?bEN5Qy9ZNm56ZUpmUS9CbVZtRkR4RDBNemJRamRUb090UkNzOHhtRElXaEhR?=
 =?utf-8?B?V2RQbnlVNDdlSUlVNXdrWUtnMytESmM3a25GdXRETWV0WDFzdVhMREJ0TDUz?=
 =?utf-8?B?WFM2QUhQSUtrazNCOVBhWjZ0TmxsZU5ValdXT1pnU2xaKyt6V2NFUEorbGdk?=
 =?utf-8?B?WXpGY3R1ekNPUm1ybjdaR2d3VXlESktuRUtuVmZsaEtQekFCd0RERVpkV3Zv?=
 =?utf-8?B?OWJyR0Z1SkJETHhzNlpYZk8wdTdiRDY2R21seUpzOTFuNEZMYlp1TjlNQVJW?=
 =?utf-8?B?Smgzb0xGTnlkN2p3Nmd5ZGxJc3FIOUN1NjJ2VHRHWVpMWjI2a01uWVh5bGFV?=
 =?utf-8?B?VHlvNkZDd21NRUNmMVhjc296bHZYRitvMUVua1dXeDNFcks1UEYvcE56QmxR?=
 =?utf-8?B?MjcvNFBuVG1tcVljMWx3U21pUjBvdG9UM0ZTcVAvZ3FjMHpXTmVMU0dGdzMv?=
 =?utf-8?B?Qm8rVTlnNFVsZG81Tkh5clNrbWlWQ0k3ZWI2bHZIRzJGMEErQWdaMTk1QjNY?=
 =?utf-8?B?ZHZDSis2VXpJRS9qZDNrMmNCUXVLTE5zbWNaL0pvUndsQ3lvbktMMmRnZzFL?=
 =?utf-8?B?UmRwemVwY0lkOHphdU8rUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a590e90-1621-4db9-b8bb-08d8ee0b12c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB3289.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 14:51:00.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGhM/OOi+hBRyFbPzExQzrKtDmIIUcKewDF89CB12n2Oz6l5/CbxK8yDkV6LG3MR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3051
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_07:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/23/21 5:59 AM, Steven Rostedt wrote:
> On Mon, 22 Mar 2021 19:53:10 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
>> On Mon, Mar 22, 2021 at 05:24:26PM +0100, Jiri Olsa wrote:
>>> On Mon, Mar 22, 2021 at 12:32:05AM +0100, Jiri Olsa wrote:
>>>> On Tue, Mar 16, 2021 at 02:00:07PM -0700, Alexei Starovoitov wrote:
>>>>> From: Alexei Starovoitov <ast@kernel.org>
>>>>>
>>>>> The fexit/fmod_ret programs can be attached to kernel functions that can sleep.
>>>>> The synchronize_rcu_tasks() will not wait for such tasks to complete.
>>>>> In such case the trampoline image will be freed and when the task
>>>>> wakes up the return IP will point to freed memory causing the crash.
>>>>> Solve this by adding percpu_ref_get/put for the duration of trampoline
>>>>> and separate trampoline vs its image life times.
>>>>> The "half page" optimization has to be removed, since
>>>>> first_half->second_half->first_half transition cannot be guaranteed to
>>>>> complete in deterministic time. Every trampoline update becomes a new image.
>>>>> The image with fmod_ret or fexit progs will be freed via percpu_ref_kill and
>>>>> call_rcu_tasks. Together they will wait for the original function and
>>>>> trampoline asm to complete. The trampoline is patched from nop to jmp to skip
>>>>> fexit progs. They are freed independently from the trampoline. The image with
>>>>> fentry progs only will be freed via call_rcu_tasks_trace+call_rcu_tasks which
>>>>> will wait for both sleepable and non-sleepable progs to complete.
>>>>>
>>>>> Reported-by: Andrii Nakryiko <andrii@kernel.org>
>>>>> Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
>>>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>>>> Acked-by: Paul E. McKenney <paulmck@kernel.org>  # for RCU
>>>>> ---
>>>>> Without ftrace fix:
>>>>> https://patchwork.kernel.org/project/netdevbpf/patch/20210316195815.34714-1-alexei.starovoitov@gmail.com/
>>>>> this patch will trigger warn in ftrace.
>>>>>
>>>>>   arch/x86/net/bpf_jit_comp.c |  26 ++++-
>>>>>   include/linux/bpf.h         |  24 +++-
>>>>>   kernel/bpf/bpf_struct_ops.c |   2 +-
>>>>>   kernel/bpf/core.c           |   4 +-
>>>>>   kernel/bpf/trampoline.c     | 218 +++++++++++++++++++++++++++---------
>>>>>   5 files changed, 213 insertions(+), 61 deletions(-)
>>>>>    
>>>>
>>>> hi,
>>>> I'm on bpf/master and I'm triggering warnings below when running together:
>>>>
>>>>    # while :; do ./test_progs -t fentry_test ; done
>>>>    # while :; do ./test_progs -t module_attach ; done
>>>
>>> hum, is it possible that we don't take module ref and it can get
>>> unloaded even if there's trampoline attach to it..? I can't see
>>> that in the code.. ftrace_release_mod can't fail ;-)
>>
>> when I get the module for each module trampoline,
>> I can no longer see those warnings (link for Steven):
>>    https://lore.kernel.org/bpf/YFfXcqnksPsSe0Bv@krava/
>>
>> Steven,
>> I might be missing something, but it looks like module
>> can be unloaded even if the trampoline (direct function)
>> is registered in it.. is that right?
>>
> 
> Not with your patch below ;-)
> 
> But yes, ftrace does not currently manage module text for direct calls,
> it's assumed that whoever attaches to the module text would do that. But
> I'm not adverse to the patch below.

Jiri,

could you please refactor your patch to do the same in bpf trampoline?
The selftest/bpf would be great as well. It can come as a follow up.
Let's fix the issue for bpf tree first.

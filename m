Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D327F1788EB
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 04:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbgCDDDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 22:03:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29628 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387469AbgCDDDr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Mar 2020 22:03:47 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0242tIhY005650;
        Tue, 3 Mar 2020 19:03:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0PvD3gqPB8Tea69VF4wULI3fVd8x+xav89/zPrxPn4o=;
 b=WYDXvMTGA0h6MY20Oo8VvJUmYoo0PEQGkx8uFzx0FQKxDW8ME9pfv3J8frZ85mN/AWDr
 2az0ejMCfCWgfCp90etEI/IoyBiOMbcK93h9qqQvW3rE1a9jYZ58ZIW4nDPjbYVypXWL
 lbxUxSGlng7q9b2KLAl2vSs1mBa2L5vwNRk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yhmsm5266-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Mar 2020 19:03:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 3 Mar 2020 19:03:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFqWM+ZS1MqHKSgJAYjFqysmdrSjcHuEhnH0MQn5rjmg411xaNxBubdaQODv0MvSFObycF2dbEsT33rHKAs/OWNlQRUeW2o777AM/qt+KpjBHCNKRegUrM8Qzw5aIS0NWA10upZnHtGhDABJOOnvf1UqaNA3/p3u0l/iLqBuK5Ku3v1csiWwAl5sg7KWaj2CV2nWmbBK7kDi2kNyqJgsj9NKime8QpL2DlJBw7laL6Kw3bZcRH05j1HtnXR0IRIOMbfiryBYeyfAhKEQSx7vDsxbAPyEb9EskoynBVVKDPEgS3VQDeVCXstRn69lQZtht0m7TwyD05f6T9Cq57Resw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PvD3gqPB8Tea69VF4wULI3fVd8x+xav89/zPrxPn4o=;
 b=fOeX3gHtSH/IyjGOlXn4OBgc624ZEHDmOGHPwpRwTS2GCwFVOgu+pN0OAyoLjCK6bfAO43O5Z8v5WBxFuzAWYhdB/8Ilt3VdN84DIcayCIaJaBR/qWgzlVo+s3I9tZmqw1p+nVFIum4anolE7hJEtFPjP4cG/2Qzd/OvhJgcKEgBN+qgn7ufcXJ/hrG1yeargAWiFiKo36/Hso0v5cdMfwDb61pK7iEKjpJ1KQhVC8ZbvGZZhVuNRZ4LjNwThKrYBkBok/O8HlhvFgrU9Csq/8qrmN+iWPhxWN5C6ED8Au3v1bno7vUZiABwpGBKp7tLcG88izIbgHONPfY4QHe2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PvD3gqPB8Tea69VF4wULI3fVd8x+xav89/zPrxPn4o=;
 b=WyhYplGWxGhaQtTjqIPVHxo5U+gbo6CdA6hE/7s1+s0wBcmDDW7Rv8XzaGeYkzrBTTyJmp9KLqhYby2HGqkyUYeeLPQNGuCKBpaLBomrG08ZyUjaWIA17RNxZ0XIVYDwHcDyy4NMrQDmILtZg8JrX4An+yPd53JRzLS4QTllRRw=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (2603:10b6:5:13c::16)
 by DM6PR15MB3420.namprd15.prod.outlook.com (2603:10b6:5:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Wed, 4 Mar
 2020 03:03:21 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 03:03:21 +0000
Subject: Re: [PATCH bpf 1/2] bpf: fix
 bpf_send_signal()/bpf_send_signal_thread() helper in NMI mode
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>
References: <20200303231554.2553105-1-yhs@fb.com>
 <20200303231554.2553178-1-yhs@fb.com>
 <20200304010811.rfzdhvnyogib3woj@ast-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8dd9b480-d6d3-f086-2e9c-d2e10d98def1@fb.com>
Date:   Tue, 3 Mar 2020 19:03:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <20200304010811.rfzdhvnyogib3woj@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:300:db::17) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:4130) by MWHPR21CA0055.namprd21.prod.outlook.com (2603:10b6:300:db::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.3 via Frontend Transport; Wed, 4 Mar 2020 03:03:20 +0000
X-Originating-IP: [2620:10d:c090:400::5:4130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a595ed24-23ff-4247-059e-08d7bfe898d3
X-MS-TrafficTypeDiagnostic: DM6PR15MB3420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB342093609C7A351EB8B32F50D3E50@DM6PR15MB3420.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(366004)(39860400002)(199004)(189003)(66946007)(316002)(54906003)(4326008)(6916009)(8676002)(478600001)(36756003)(66476007)(66556008)(2906002)(6512007)(2616005)(31686004)(81166006)(81156014)(86362001)(186003)(52116002)(31696002)(5660300002)(8936002)(6486002)(53546011)(16526019)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3420;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBUgRxxQMxkp/WL+T2HDUcvtFcwEQf56ANQJW5wc2FhL7T1n6wCCASdYJoBGCuQotfEbt6zEUnobrDkesRUqIM/J8uw2NuWqSGi4iEXn4KGgyh0kLdgmbQEAROGieivRI1zCrPuhN6OYbaYouMCuQFBsqyHLCkDSxErlNmwXGiY9+Q6azPx2ROku3N8a6GymxZmOjoY12jc9CKkvwkPZOvxRP62zAlhTH+jMzMpXoYRPG+YxklUSJqq77RxUD+rso7MV1YrtW0a7LgVKTJlDzbrrc7IkUA35I0bplCRWinUNIMQmIeL/hyKYqmv74KHV86eRhuskzqbNlOIpa5e2b05bv84M/Y1hWfMTq6Is/7z4i3zKBY6stQIaj2Sxm/gohfDmSRRyFnMV4Q89JKKdxBOgP1VCtCCRsf0WhEeH8hFg18dhdPE6UBNjAsN4CJs6
X-MS-Exchange-AntiSpam-MessageData: sm9fQU05111ql62VBffTB0xMGh5hqAlBBkojtLPgPuzz9PEgwaa3l7diYDDY7p28nVi7OBiEomX26mogDGPCuonDbz2TipbClaUyNtJ4KNTd4VEzkmOuASovd4nSaaWeI5rLxS6hKDXyR93DeFG0qKxuQPHat5gfQFntdif2ZNNQoLuRN9fxKh2zUSqKttz5
X-MS-Exchange-CrossTenant-Network-Message-Id: a595ed24-23ff-4247-059e-08d7bfe898d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 03:03:21.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4iejsZSfk/RYCPsUQiHE8zOFDN+hkY2SX3WAzCTDUE4pXOO+ikcbNCPZafe6yX0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3420
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040019
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/3/20 5:08 PM, Alexei Starovoitov wrote:
> On Tue, Mar 03, 2020 at 03:15:54PM -0800, Yonghong Song wrote:
>> When experimenting with bpf_send_signal() helper in our production environment,
>> we experienced a deadlock in NMI mode:
>>     #0 [fffffe000046be58] crash_nmi_callback at ffffffff8103f48b
>>     #1 [fffffe000046be60] nmi_handle at ffffffff8101feed
>>     #2 [fffffe000046beb8] default_do_nmi at ffffffff8102027e
>>     #3 [fffffe000046bed8] do_nmi at ffffffff81020434
>>     #4 [fffffe000046bef0] end_repeat_nmi at ffffffff81c01093
>>        [exception RIP: queued_spin_lock_slowpath+68]
>>        RIP: ffffffff8110be24  RSP: ffffc9002219f770  RFLAGS: 00000002
>>        RAX: 0000000000000101  RBX: 0000000000000046  RCX: 000000000000002a
>>        RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff88871c96c044
>>        RBP: 0000000000000000   R8: ffff88870f11f040   R9: 0000000000000000
>>        R10: 0000000000000008  R11: 00000000acd93e4d  R12: ffff88871c96c044
>>        R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000001
>>        ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>>    --- <NMI exception stack> ---
>>     #5 [ffffc9002219f770] queued_spin_lock_slowpath at ffffffff8110be24
>>     #6 [ffffc9002219f770] _raw_spin_lock_irqsave at ffffffff81a43012
>>     #7 [ffffc9002219f780] try_to_wake_up at ffffffff810e7ecd
>>     #8 [ffffc9002219f7e0] signal_wake_up_state at ffffffff810c7b55
>>     #9 [ffffc9002219f7f0] __send_signal at ffffffff810c8602
>>    #10 [ffffc9002219f830] do_send_sig_info at ffffffff810ca31a
>>    #11 [ffffc9002219f868] bpf_send_signal at ffffffff8119d227
>>    #12 [ffffc9002219f988] bpf_overflow_handler at ffffffff811d4140
>>    #13 [ffffc9002219f9e0] __perf_event_overflow at ffffffff811d68cf
>>    #14 [ffffc9002219fa10] perf_swevent_overflow at ffffffff811d6a09
>>    #15 [ffffc9002219fa38] ___perf_sw_event at ffffffff811e0f47
>>    #16 [ffffc9002219fc30] __schedule at ffffffff81a3e04d
>>    #17 [ffffc9002219fc90] schedule at ffffffff81a3e219
>>    #18 [ffffc9002219fca0] futex_wait_queue_me at ffffffff8113d1b9
>>    #19 [ffffc9002219fcd8] futex_wait at ffffffff8113e529
>>    #20 [ffffc9002219fdf0] do_futex at ffffffff8113ffbc
>>    #21 [ffffc9002219fec0] __x64_sys_futex at ffffffff81140d1c
>>    #22 [ffffc9002219ff38] do_syscall_64 at ffffffff81002602
>>    #23 [ffffc9002219ff50] entry_SYSCALL_64_after_hwframe at ffffffff81c00068
>>
>> Basically, when task->pi_lock is taken, a NMI happens, bpf program executes,
>> which calls bpf program. The bpf program calls bpf_send_signal() helper,
>> which will call group_send_sig_info() in irq_work, which will try to
>> grab task->pi_lock again and failed due to deadlock.
>>
>> To break the deadlock, group_send_sig_info() call should be delayed
>> until it is safe to do.
>>
>> This patch registers a task_work callback inside the irq_work so
>> group_send_sig_info() in the task_work can be called later safely.
>>
>> This patch also fixed a potential issue where the "current"
>> task in nmi context is gone when the actual irq_work is triggered.
>> Hold a reference to the task and drop the reference inside
>> the irq_work to ensure the task is not gone.
>>
>> Fixes: 8482941f0906 ("bpf: Add bpf_send_signal_thread() helper")
>> Fixes: 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")
>> Cc: Rik van Riel <riel@surriel.com>
>> Suggested-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> I don't think that fixes it.
> The stack trace is not doing nmi.
> It's a sw event and 'if (in_nmi())' is false.
> try_to_wake_up() is safe to do from irq_work for both current and other tasks.
> I don't think task_work() is necessary here.

I thought nmi is there but is gone and irq_work takes over ...
But clearly I am wrong, looks like a perf_sw_event...

> It's a very similar issue that was addressed by
> commit eac9153f2b58 ("bpf/stackmap: Fix deadlock with rq_lock in bpf_get_stack()")
> Imo the same approach will work here.
> Please craft a reproducer first though.

Thanks for the tip. I am not aware of this. Will try to reproduce and 
then fix properly.

> I think the one Song did for the above commit may be adopted for this case too.
> 

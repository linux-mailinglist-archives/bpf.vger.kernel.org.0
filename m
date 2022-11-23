Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F4D634CC1
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 02:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiKWBPY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 20:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiKWBOp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 20:14:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B621401A
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:14:06 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMNVT8c028723;
        Tue, 22 Nov 2022 17:13:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=c0qD9S6QdDHPNBCkEwW00RwsOtGLm1QTijGsa0roj2I=;
 b=JfMXQFyFKMAGLYcvvur5E98sWwWLZE6VjW0bQ1Y/1xCD8VvkPbdvfkD4yPwhgfCeuwRd
 FCjp/mnUNUOv3DWbVrIySOTXNd9istCQ1sAdnl/tgXdY+XU8b2/rKiVl3Bq4Ro7nvPnG
 sR5H6OJsnlwuOuVsAk/7FkPbiVI3dtCwBULMo3ui6R+iVjj++ypJAkoMvQ2aIep3YRRf
 UnjK1ruap1k+vX6y9z2mfa8zW8QQ7nt3UrLLq22BR2h2rcuXzOClIWObAbHdoK0KS3iW
 0QDA6e2Txuz/xaxsgaE7LlMFs3rb/guj0Qc7Om8TI46Aiccfk6LDgvt8J8VA6LEVdi4p 3w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m17es8tkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 17:13:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECsKWs5fJ56ZUObWPacZRXkhuMgmBCjlrdgRsazLjx0f6Utdxv+kD7uahYODUoo0l97kZcCX+UxlSUG4PviEwSSd2XyfGYzZZ51F68zOuaZSUPrQ4kocM/QHrewDarZy2VyQYgRFYSqjZJm2dtPhlcZwoFyk8D57wIdvSwbsi4bEdBsW8qSyIaT3f/k4L19ByHeJgVURjHpFTOJhlHjodho8Opo7yyplpRCVl0am+xueJJJbbGkCbDqUV+Kn0/C/PlbF1aZ/LdvkALTagsKjLms95YXpdkfU8+NUVwA6XpfSEhZJvUXGxH/S8VaANh1yV49T8IKk8neRaUv6xrfiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0qD9S6QdDHPNBCkEwW00RwsOtGLm1QTijGsa0roj2I=;
 b=BuZrPMtpo7td2CZqUtSoauwR9mOt8abzDgAabzfCGZISAozuP+Sn37G1i5aSK2tDFdmNHXd02w0fq+QTjYL6oAVWZJDxbIzOg/wTiVw3uncdTDNOfrniKNOc5lN4fN/dfHqJK3nzy7pD1zxBlf/TnS6qltQi2C2QdHI3x+ciADPBFsdAnRUtT4TjQJ0qdtG+T8XTHEFx7O2FhONvwZnjq51Mi8APEtlrkJWXetv37DzdTe0YCnfD5wdB3bBL3gvEplRMEFaEmLchNvJ01Nr8UcPrRss0MK279FQHrQ8h0M+vSiKu1mtaPKjcF4Fp1KhuX6XcS7/vB+u6MuR977WeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1749.namprd15.prod.outlook.com (2603:10b6:910:1d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:13:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 01:13:49 +0000
Message-ID: <b1b8d321-1c3a-ca41-707f-95b3cef7f124@meta.com>
Date:   Tue, 22 Nov 2022 17:13:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v8 4/4] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195340.1783247-1-yhs@fb.com>
 <201c1603-cb3e-7893-c411-e7949ef8e9d3@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <201c1603-cb3e-7893-c411-e7949ef8e9d3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1749:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d5cde9-b870-4232-9606-08dacceff9e0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ze3d04UnCr9d/lX+Y2PvlwqUqRyV72MbqKc6LC/3BOI6bMYqZcXDsDl+Q0TC46SIsHtCxHN2djy8eODSBC0Vo51ZggvMG55G4S0dsSQMj1qFDoTEs9vH/GzeQeOh0MazsHKZp/NJUIxd2ULaZ1/vBAmOmHB8kjor1dQYFZe2EVRZt6AXr+NDi3kFtlkPlpoK5D7MiZTzfuPCLVoHCa6oSr1e7GrYGpYKD/rqusUpvA5U4NTLDPF7qWkWOs1nIcHTvKeWLXQzi8861T+9KL9fX7l2F4w+icblh7aOiSVFvPm9ZlDEMmldBhxXxa+B4YCC09rxwzI3XLahlDuQNDSyjepmrJlLWapUFpYuO2aDQh/18YCKjrgsR/MMIuDYbMlyg2M7hqQBQnU8k+1vsGuCgw5FIi56HsBQRshsj8u8d5Tto3h5p/aBW6xmZEz8rtfl4fGU7tf7Az4ugxiLFCw9s0/52fwlPhIMtYqzXnHnJ5Koyxr+o43ID7y+As4/oC2gikr+z920lchQnAW7iCNg3oJNPex6xpNt0p5Y2Ge/zRqz+K3XFjuTr641z58SdvaIHihTmYma2zMHuCUsTj+fIw1wYIQXh3zkhWDz9TP/7MNJDE5YZGNhg9hQZ3SYezpQ6hShqzc2tFIH7+4u1a4oP3Dx8C8W4p4EzurhS3RtyiX+DH62k7aIZTEN9YBHdqjdEzu+SHZOGmXweZmmiO22wJl4MK5UR6v52MFovsDNe+5jbvnzhFad2Xad7RoUn6TR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(31686004)(8936002)(83380400001)(41300700001)(5660300002)(8676002)(66476007)(66946007)(66556008)(31696002)(478600001)(86362001)(966005)(6486002)(2616005)(2906002)(4326008)(186003)(54906003)(110136005)(38100700002)(6512007)(36756003)(6506007)(53546011)(6666004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellxUEtML25NQVZ2TGNrRDB2OS9CRWRuTzFuTzRNNERRL0lWdDJCa0dqQkRq?=
 =?utf-8?B?aDBTQTRRQTROLytMNGhHUjluZXkrUXdZNXBIZ0VpNTBiclRkNEJpZTBwdSt5?=
 =?utf-8?B?eXZDZkxoVFVUck5BVFArWVNiYmlNWnV3K3FmS1loRE9HMWgrd1htV3VZY252?=
 =?utf-8?B?RmJKamtSMVR5d3pnWWIvV2gzbzl0QlhnUlJoamVEZExPaTZtajhOeHVwcnBk?=
 =?utf-8?B?UEpwRDJVUnAvZENTZmFzNGFBd3NLdkljQkFISk1OY1ltN0lxcldxeWE1RmlD?=
 =?utf-8?B?b1hvN2c3bEwxLzhMUVlORnNhQzM3ak0zdFJXaHNKQytSV1FYNmFZR21HTVR6?=
 =?utf-8?B?MytsVHdWSGZSbEdmSmMzMDN2eGk2V3lXSFQ0VWk2MUdRaG1oTkxFSE9OQlkw?=
 =?utf-8?B?dkFMdU12TkV5aWd4Tm5CdmZKN1c1clpqYWhuT3g0NFZjVmVOaVFLZmEwMkxa?=
 =?utf-8?B?S1ZScWd6d1pWSjRtWC8rYTJ5WERudkFhRXpmNlJ6bFVyMzlnMHFWQXBFWjYr?=
 =?utf-8?B?QXZUcUZQZ1NVZXByKy9CQVZnYXdZVkh6WkZjYXZrVDlKdERPVXlwUmFQMDNs?=
 =?utf-8?B?UjJGY2lIVUErWnJZZzhlK0tCb081NXJoMDh1RmZ5YUV0MlFodkpaRm5XRUpI?=
 =?utf-8?B?b2xtY1N1Q2Q5Y09lZlBCSHZ3VTFwZHU5bDlrdVVqRkV6Rk5ZM3dlUGlVYm1C?=
 =?utf-8?B?UmRxckVlZmxlM3ZIc2lLTTUxV2QwNTdFaElCb08zVWNTUTBZSUJFOTBUeUYv?=
 =?utf-8?B?U0JGYmg5YlFtMG1pam5xb00xOER6dnk2cWhFdTVXdXlqVVRqM0N0MlZ6YXF0?=
 =?utf-8?B?UkZOajgyQW44TmFxTE40UHhCOGJJYTU4Qi9UaTdKdnRUbXcyRk1mcTI0bGgx?=
 =?utf-8?B?eTlld1Y3YW5rUzVmVklBMDRKRkc1Qk9YMGFHaVlXTDNudlJNN3NGZkJ3S3g1?=
 =?utf-8?B?U29ycUdUYjVvMmpuY2FxUy9lU091MmlHZnltTWQyZ1JBMDhRanh5QUJFcGVR?=
 =?utf-8?B?SXZzU0krVGNDbkMzRlFVVWh3TlFFRi9scDBEK1J6aFVMSlFRbW1LaXV0Q0ZV?=
 =?utf-8?B?eGtaZEtGSzFoS0pJcFhLbExXN1VZNUkxYVQ1Qk1OVm5nNHBMNEx3MHlQRU9z?=
 =?utf-8?B?elNKYTk0aVVZYW1OY1VpQVFzRk0yV0QrbEtXTjZaOCtHUkgwRVNPMWEzRzFS?=
 =?utf-8?B?U3VPMlZVK1R0SjRkQnpIS2VPQngxa1ptUHJHTVE4YmpWZ3ppMjBVU2ZxaUVP?=
 =?utf-8?B?SGdhc0RPV25JTGxZc1dnSThzeTQ4c1Fvb05kdVpIaXJHdUNXVmhJOGhtY3Jy?=
 =?utf-8?B?Y2hkYS9uUTNjWHRURUFLWDZ4NjhUSUNuQjF5L21keGUwSlpKZ0dNSE5mQWl5?=
 =?utf-8?B?bml2RXowc2t3RnkzSW1SQmNXR2NFL292Y2VldmVWWkxCZzJ6RFZIN3hNZjdX?=
 =?utf-8?B?UnQ1QVY3RlhSNVArd0w0UVJCVFlSUnJMSTMwNEF5dXVmOW5kNVl5NTRGbFdX?=
 =?utf-8?B?K1BnUWRCU3FGR21zMzRaRWZ3ZjJIUDdaRVp0TStacHJtZzdPbXlxUUg3Y0pZ?=
 =?utf-8?B?NDJqUWoxMGRIZGVmS3Evc2UvYWovUkdIbjRUN3VuOFNLTjk4UFE0RDQvdE15?=
 =?utf-8?B?aWtKVzM1SVJYSUFlM2VHZHBJdUFMQzN3QjZCaWo2Q1l1Q2g1RXY2Mk1HQnZl?=
 =?utf-8?B?bDQvM3NqUDUyYmRtZjZ5RDk0NU1OYzAveUFUbWYzTFZZbkNtNmxrakNad2dv?=
 =?utf-8?B?aVUySmwzWW5ZUHczSFpBV2FSQUw4TzZCbjE5NXU4MW0xZno1cytuYnczOXFk?=
 =?utf-8?B?Wkhpb290OWtlc3lZUmlwRm41M0tjeVdIMHdMem1OTlNKbFRINGlQR2c2QVhR?=
 =?utf-8?B?OWdjWDVFRXJwTjRjZDVMaUdJYk0zcERHOStPVGF0ZUs4Rm5uK3Jwc29WVWxE?=
 =?utf-8?B?QzVtMXFyZ3VKdC8zSWptQnRCV0ZpNE9Yb1dkQUN3aUt3SkkyUFhBdDFPZmRD?=
 =?utf-8?B?UGl2bTgzQ09nNHp4ZGZibHl6Y2k0ckE4MzlDbzBTVy9mT1pDcDBJOS9YTDcr?=
 =?utf-8?B?dklqdml4WXdCYjBHMUNyNmdrV1A4TW9sRVhRSjViRkUxRTNBTk9MNGxuOHoz?=
 =?utf-8?B?a1V3WmxOWDlhYTFQY0w1ZDVYMFpjZUtjc1NKUVg3d01zanIrT25iVWpnNVBW?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d5cde9-b870-4232-9606-08dacceff9e0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:13:48.9560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFnZIRDartFAcWyhdGDlRjoURG47Dx9oAm/Fn+7PYaf0tIoT871amhkmS3zE/JDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1749
X-Proofpoint-GUID: x-eeFib_PMm8KYSIXmIyAlk-EhlHMDFF
X-Proofpoint-ORIG-GUID: x-eeFib_PMm8KYSIXmIyAlk-EhlHMDFF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/22 4:56 PM, Martin KaFai Lau wrote:
> On 11/22/22 11:53 AM, Yonghong Song wrote:
>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +int task_acquire(void *ctx)
>> +{
>> +    struct task_struct *task, *real_parent;
>> +
>> +    task = bpf_get_current_task_btf();
>> +    bpf_rcu_read_lock();
>> +    real_parent = task->real_parent;
>> +    /* acquire a reference which can be used outside rcu read lock 
>> region */
>> +    real_parent = bpf_task_acquire(real_parent);
> Does the bpf_task_acquire() kfunc need a change to do 
> refcount_inc_not_zero() and KF_RET_NULL?

We have this definition in kernel:
BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)

So the argument is trusted args so, either marked as 
PTR_TRUSTED/MEM_ALLOC or have a reference acquired already, so
I guess we should be fine here.

> 
> Also, some more 'skip' checks in prog_tests/rcu_read_lock.c is needed 
> for gcc. This is failing in gcc CI:
> 
> https://github.com/kernel-patches/bpf/actions/runs/3527747280/jobs/5917628248#step:6:5624
> 
>    ; bpf_rcu_read_lock();
>    2: (85) call bpf_rcu_read_lock#26650
>    ; real_parent = task->real_parent;
>    3: (79) r1 = *(u64 *)(r6 +1416)       ; 
> R1_w=ptr_task_struct(off=0,imm=0) R6_w=trusted_ptr_task_struct(off=0,imm=0)
>    ; real_parent = bpf_task_acquire(real_parent);
>    4: (85) call bpf_task_acquire#26666
>    R1 must be referenced or trusted
>    processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 
> 0 peak_states 0 mark_read 0
>    -- END PROG LOAD LOG --
>    libbpf: prog 'task_acquire': failed to load: -22

Yes, we should skip this for gcc compiled kernel since rcu tag is not
available.

> 
>> +    bpf_rcu_read_unlock();
>> +    (void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
>> +    bpf_task_release(real_parent);
>> +    return 0;
>> +}
>> +
>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +int no_lock(void *ctx)
>> +{
>> +    struct task_struct *task, *real_parent;
>> +
>> +    /* no bpf_rcu_read_lock(), old code still works */
>> +    task = bpf_get_current_task_btf();
>> +    real_parent = task->real_parent;
>> +    bpf_printk("pid %u\n", real_parent->pid);
> 
> nit. Can bpf_printk be avoided here?

I could add a target_pid comparison to prevent the issue. But
will follow your suggestion to use a different function instead
of bpf_printk.

> 
> Others lgtm.
> 

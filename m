Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4099D64AC8F
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 01:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiLMAmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 19:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiLMAmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 19:42:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6696EE08A
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 16:42:15 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD043bb027105;
        Mon, 12 Dec 2022 16:42:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=HDQMJXLS+gcMM9/U1lfJIQHY4uygukX61/ZKFvKlnkc=;
 b=fFMs0wGtc8fVPV8NNmqXQAErS2i4sRORIX1UlEPsVIWglqU8v4v1DcXNQUSG1svDrB5U
 QLvSulRG3klHNmPMiePw7yrTMZQMLjuBEm7241TMystdO6w2a/wYfrZakohZE8nYaLA6
 4IKsX4CoXXCFFzH0SBBvr9fQpQ4ehSkhDhdW4T9p3mG7wKhFdjKlKI/otwO/tRfzzVMV
 UMMzavsVZKv+1mEC5/65ORy2NfeBFFMci55plKRA2h2pidsLJmQKOjHFZsPcfnOwePqa
 6Hs+PosGuPL9GZNuw3yqqULn2J/hipmq8fEmPiKTRInoMIfN88pY2tBbgwXQ4IMM/iGo GA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me4h3ed4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 16:42:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLeErInEnWyIRQlh0mbpedKEf4MSnQG24cV/PX4uP1GSNdJbd5RDq10kSNbGpyNsyl3jwTtqLjgE8atOfQMk1aayZWgPuqEbbTZCpYZOIIzOSR3P00Nr2OlmpVw1jNH3IHwbNpOh2FOw4EEXci5X7ApNko4iQP0sOZCtyDEFA+4oxwljUDrKzFoHaf8B++950T+TgRt0oxxj7iYUPkdJzRReyd/eaZsP0fHCg1FMkWnTZDOV8t3CSNpNYgOfaljtnfQNlFVJcAaJp6xkhg/+Ow7Q56WezUvkl6caqoklsC8ZeVpUpUI+mBSnLrYStmxgf0vzXvH6CIE/FXzh7Hy6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDQMJXLS+gcMM9/U1lfJIQHY4uygukX61/ZKFvKlnkc=;
 b=E5GZnNsP6yz4wObnC4rZbbrW9kIQfv/uY3lgs5hVUCDOZxk17Hjnl3WQ5XTXsiYnb3XqetIvqiYf0ffDzpJbnuWZcodvYdBbv/m5CNgqxK0TqEHs/Ooh/SqnOM6zFuKzBSEPNqF5y1vMYzLwvFHc5EKf+bBuFOapkmU/n+zdL9x5eVh3+WwGOAP4W70B6zUDNL0cpI3tjGUnMPtS282j3uOV1on2jYmUUdiBJiPupD2Jpd21gmFoNIdFPBV3R10+c7zZe8C/gvnCs8t1QFvZA+s0IRVy8fT7CEo8OqpX6Dt+hP33NqbsbPCVqAKBGlWtacGOXNselp2qcFVTuzikpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2305.namprd15.prod.outlook.com (2603:10b6:406:91::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 13 Dec
 2022 00:41:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 00:41:51 +0000
Message-ID: <65954343-f164-4168-ea97-99ebf4f17445@meta.com>
Date:   Mon, 12 Dec 2022 16:41:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf] selftests/bpf: Fix a selftest compilation error with
 CONFIG_SMP=n
Content-Language: en-US
To:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20221212234617.4058942-1-yhs@fb.com>
 <Y5fAHJTI742+jte7@maniforge.lan>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y5fAHJTI742+jte7@maniforge.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN7PR15MB2305:EE_
X-MS-Office365-Filtering-Correlation-Id: bf256427-13d4-4d2d-cf2c-08dadca2d373
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQAC2OF+UYhY6gjK3TDz7FpHMKCVVOiYmtCxZmMLPlqhkEwyxmHk0Irq1LPPqbWF71YUG8cq2UwxrOnz+5oUWkhe36Tnkiu2GrWZdwP1IZeiofG5hmusy1LQziKHz0uJ9AZwyzHweaiM7LPwjw0doLIRSyj8H7ZMxe7qhSnsTAQeQ6FFc41f8Aci2aeF+Lm2xmzVpiGXGx0smEF2k7FUx780diR5RG3dz1cg91bcsq2zZjqd/nkMw5jmFkaZjwsSkEhGMip3CR+X69dZC9dmxLID/8Y5e0soJNQomN/eKQbXlc/k5QvG5tI1VYE9iyNM+kXy5BCz3FK3sXETK39EkmGRTZcmE3z5oMNFGL54/gIJE6pDid1S2/lk9hi2qSyyaZjjg4yB/5dz9GQpqW60KBX42rDnPmry49XqlgZKe9YgFGq3upqH0xb27+szKbTQuWeIGhPMz8PZrCj/YBJOxGTdjZg9H6HNSr4AlaIKzwcMINA2GvM9gR39xI/Jd/Fp23M75ePREDt313l86zxKhczpE+rrT7Hrv/6xhkG2Vq+9qm15d5p5lr9DhV3VfmYSqjZxdMivxyJtsnRw+Ai3Fa01sl0dXGalSsSA05+bIafW4T4ACxJ8Y3ivMksnU3Kp9rIhccDPakLXMhbQy4nNUYomINo/xzNCPGQRqy+ix6K8fZSXX28CKVXROtSArsAJJvlGqgSOTRpYIre5myfI+O6x0IZ4cXU4H0fp0gLlIILggbGPZdSK6Gx7NeIX3o3F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(110136005)(54906003)(316002)(83380400001)(5660300002)(8936002)(4326008)(66476007)(66556008)(41300700001)(66946007)(8676002)(36756003)(966005)(6486002)(86362001)(6666004)(6506007)(6512007)(53546011)(31696002)(478600001)(186003)(2616005)(2906002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEgrRm9taGN4UXpOSldtL011RzY1bmQ4NG5iQkhPcFRvM2hxOERlTVpXZGZm?=
 =?utf-8?B?WExBcDRESkxUdlMxZlo0ZlJWNXBBRDBicmk2czhaUEpWenJtTzcyWEJQMWRK?=
 =?utf-8?B?N2NQbjR0bGNtNkM1ZEVua0FXLzNkbE44cGxWYWZsVjJKQUlWZWRURC95SFNF?=
 =?utf-8?B?VEhscTNLcVFLSS9RN2NVb2J5M016a1FmeFRyNXl6L0hRMjJaMXppSUVMZzZZ?=
 =?utf-8?B?ZlZ4VlpSMExGaWVFQ1V3am5TTXBoUWlMU0FVUWQzaCs2V09PaVUyeGpGSlFl?=
 =?utf-8?B?OG1UNkxuaXBsR3ptbzVDOFl6Z2tsNVcyR0NOazIrZkx1MytSZ0djREc3c1A4?=
 =?utf-8?B?anBmZ0VYejB0OXVxUDVoZjYyNWtyT0RhdFBvSlF0K0FzZHhPdnVGdC8vazBh?=
 =?utf-8?B?WWVVMHJoazljYkY4MTdZcUFoQ3g2YjhkejFYOGd3R1V6ZFhqN0RQcXc2Qnk0?=
 =?utf-8?B?WjdtQU9sbXMybTBjZFhwUDlBTjdIemhPbEhBemo1U1ZYN0QvTTBybGthc0No?=
 =?utf-8?B?UlhoWmFDaFArZjZuUi9ocFEzOUxjQXdaOVpiQ3lkcWFwYjV1TXV5c3M5MFR0?=
 =?utf-8?B?amVKdHFPNVJnM1NNOEpUUGZrTmgvL0V3MXkvUnZmUTN4MlppRFlQczJlRGRx?=
 =?utf-8?B?VlJpS3hlZzljaW1sVTFCUDlCYjE4dXVyQ3N5NUVkNmhvWnVhdG9sSy9TeTRo?=
 =?utf-8?B?RjNWQS8vdWNvYlE4ZVRBT1pmaVZHNmFqQVFHVE1PcmpCbks5K2JNSCtzM24r?=
 =?utf-8?B?MkRhVHA2YmlmQTFHOC9QL0VjY3VJbzhmWVNVS0xGYkl4cVNwRDkvcmVYelZ5?=
 =?utf-8?B?TWwrQ01TeW5rcHVDclVYWjI4ZmdXOHRKZld2WUJ5SzhuVDlXeXlVZzJ6L0FX?=
 =?utf-8?B?b1RYbmt4a2lkUUZMb09kTjZkWGlmUEZDYkFTVGJLYmlyUXFzVE9tVlJsVHIz?=
 =?utf-8?B?RmVUeEVBTlYyNjBGS3dJMXFkYzBPOVJpSUtvbnp3T3FYWEx6ZzZaeTNjYmln?=
 =?utf-8?B?aUhPVVN3d09tblRFVGRCMXUyZHVkWjYvTTUzUG10RlZ3T3NmckNDcUlaZ1dy?=
 =?utf-8?B?YVlJMnUxS0JqN0V1VmZoUGZFV2hoWHdsZUx5UURoN1hER2JpYUYwZmdwM0N2?=
 =?utf-8?B?MzdEcE1NQld3N3daMXZQY2dkYk9nMktDbW4rQXhyVzZnamV3TlJZNzRpYm96?=
 =?utf-8?B?elFLVy94UEptdm4xREc3Z3gzWU9mWmZLbCtsVHlQemhtS2Q5eVdiamp1YUxM?=
 =?utf-8?B?ZUlsN1FsNU5zaUtPaVB3VVBHL3lvZEdOclpXdHBrL0ZCYitkSzIrdVgzYTQ5?=
 =?utf-8?B?aVJ0eFdQVng4N2RwK1BTKyt6b2VBWnphM1hQdXpvcVEzWllUSmVpcFJiMzlZ?=
 =?utf-8?B?TGZIT2MvTzB5SHJrS0tkM1NtSllDcmRxYS9jMytwSTV2TDJzanE3R1h5RnQ3?=
 =?utf-8?B?ZG1kOFljMGdTWXdqbENZQnR5MDhRelNEa2xFVmZ5cjQyR1JIaHpXYmVLUDdH?=
 =?utf-8?B?bkxPWVdzbXpnRy9yRmdONHkrUUNlMDVnZTRSc3ZYV1AzaFp4cVJuUUZuTFE2?=
 =?utf-8?B?TG8xUEZEbCtic2RxMVBXWmRNMCtQTDJUZE8vOE9pU2dJRGpWZ0JSd0RuY212?=
 =?utf-8?B?bTdWd0ZGVHJtaVFYM2xaVFlZSG85YlNUaG9FU1VTWlFUcDl1K2ptbEVta1Nj?=
 =?utf-8?B?OTU0NjVyOGJZQVVKQU52dHE4OEtBcVJJWWlDQzlmc1I1b1FySWgvT29aV0pO?=
 =?utf-8?B?V0R5d1FTVzB0T2ZPNVpDd0RyWXB3dVY4RUkrU2ZsdmxadFY0UzFrYkg5QUxE?=
 =?utf-8?B?R2w1THhpa0lkOEVWZDJnbm1LVmF0aUxPS2tIL3lWcnA0NTQydnlTUUNHbWtH?=
 =?utf-8?B?cWJvdVE0dEVzSmlJcmNxY0lqTFVrWmZWN3VDMFZFYUEwRGNQUXdqd2hXSE1B?=
 =?utf-8?B?blFEZlVsc0xOajBGakdZTjVWT1hYVUw4MXFRMjhORm9DWU9RN0I1QnhvZ1lv?=
 =?utf-8?B?UHVyK2o0ZWRRWHNlZHVZdENubWI1b2QxRDExYU9KNU5raVo4S3F2aUllUWFi?=
 =?utf-8?B?czVhSWhIWFNFOEpEQjgyUnR3QU5ma2dCeDMxaWZOaEFaNTE2NjdUSEsrdUNC?=
 =?utf-8?B?bkhudmZmNFM0NmdpMkJ0Yzd3ZzB3WEkwaGJnMEZRcUFHd0o2ZDdSUnE2L1hh?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf256427-13d4-4d2d-cf2c-08dadca2d373
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 00:41:51.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZFGqjhSTe+3Jxzn/IfSHpQiUdP5ZINVBzlOYda13DAWjDLeP3kl2YSiLjXnrsDp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2305
X-Proofpoint-GUID: L-dC5HIEnvl22Sg1kG-xgbwZWsQp9dZW
X-Proofpoint-ORIG-GUID: L-dC5HIEnvl22Sg1kG-xgbwZWsQp9dZW
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/12/22 3:58 PM, David Vernet wrote:
> On Mon, Dec 12, 2022 at 03:46:17PM -0800, Yonghong Song wrote:
>> Kernel test robot reported bpf selftest build failure when CONFIG_SMP
>> is not set. The error message looks below:
>>
>>    >> progs/rcu_read_lock.c:256:34: error: no member named 'last_wakee' in 'struct task_struct'
>>               last_wakee = task->real_parent->last_wakee;
>>                            ~~~~~~~~~~~~~~~~~  ^
>>       1 error generated.
>>
>> When CONFIG_SMP is not set, the field 'last_wakee' is not available in struct
>> 'task_struct'. Hence the above compilation failure. To fix the issue, let us
>> choose another field 'group_leader' which is available regardless of
>> CONDFIG_SMP set or not.
> 
> s/CONDFIG_SMP/CONFIG_SMP
> 
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/progs/rcu_read_lock.c      | 8 ++++----
>>   tools/testing/selftests/bpf/progs/task_kfunc_failure.c | 2 +-
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
>> index 125f908024d3..5cecbdbbb16e 100644
>> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
>> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
>> @@ -288,13 +288,13 @@ int nested_rcu_region(void *ctx)
>>   SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>>   int task_untrusted_non_rcuptr(void *ctx)
>>   {
>> -	struct task_struct *task, *last_wakee;
>> +	struct task_struct *task, *group_leader;
>>   
>>   	task = bpf_get_current_task_btf();
>>   	bpf_rcu_read_lock();
>> -	/* the pointer last_wakee marked as untrusted */
>> -	last_wakee = task->real_parent->last_wakee;
>> -	(void)bpf_task_storage_get(&map_a, last_wakee, 0, 0);
>> +	/* the pointer group_leader marked as untrusted */
>> +	group_leader = task->real_parent->group_leader;
>> +	(void)bpf_task_storage_get(&map_a, group_leader, 0, 0);
>>   	bpf_rcu_read_unlock();
>>   	return 0;
>>   }
>> diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
>> index 87fa1db9d9b5..1b47b94dbca0 100644
>> --- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
>> +++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
>> @@ -73,7 +73,7 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
>>   	struct task_struct *acquired;
>>   
>>   	/* Can't invoke bpf_task_acquire() on a trusted pointer obtained from walking a struct. */
>> -	acquired = bpf_task_acquire(task->last_wakee);
>> +	acquired = bpf_task_acquire(task->group_leader);
> 
> Ah, I missed that you'd sent this out before I sent out [0]. Thanks for
> fixing this for me. I'm fine with just merging this patch and dropping
> [0] if it's easier for the maintainers.
> 
> [0]: https://lore.kernel.org/all/20221212235344.1563280-1-void@manifault.com/

I found the above as well since with the kernel-test-bot config, both
rcu_read_lock.c and task_kfunc_failure.c caused compilation errors.

Let me send another version by fixing the above CONFIG_SMP typo,
adding proper fix tags and adding your sign-off and ack.

Thanks!

> 
>>   	bpf_task_release(acquired);
>>   
>>   	return 0;
>> -- 
>> 2.30.2
>>

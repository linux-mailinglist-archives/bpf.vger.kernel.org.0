Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3FA6330E6
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 00:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiKUXpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 18:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiKUXol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 18:44:41 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF40D634B
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 15:42:47 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALMtQCQ024976;
        Mon, 21 Nov 2022 15:42:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=khkfz519Z2Yx2qH/sfIM7mSZYBOk7UG2s8SXOjFn0+E=;
 b=l9KZPx+HhI4C3iXDaTZ3x1vlGSqociJL/zwcXOk2+67GHIMUSEHrl7s1RqvhAnH0+UEU
 SYpiw/HVGN7LDuM8EXmHjflKL7P6LhCEeeyDeTaQW09/2DFQthqDgHRAkHBmyGhtR89a
 zdiwYRYhd62SI7nqB3jhjZk4fA8A6dbVM48moeVOtMMrQT4nP/gohSzgp0WChhnDV5Pc
 9YAhmEOyTL7w64SChLSVl3k+CiC9Pkm/O00UYgx4UuFFwmkXfrY2Y+tYZXhquBwSIYnv
 m/3Sjv0WLFl0L/lxpo2/FexRAjMwp+xdNZIGoD4HsnJa8ztRWIhAqbYAr/gZFAGQg4NU DA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m08k5d8rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 15:42:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYRTmm6YvPjSCKymPoGEz6h9o77KVz8hBmJiZcTsr3IbjlTNa/LTaCBdWsywC4SnzyswCLzNEdlkp7vHVAWHcasV8XVmW1HMq608CYPgXjuGgQgchGelJ+Mt/ClGVs8Qa4bd3ZzzJKAs+bxBmkVXPjpbljBiKZWxLcXinMWgyx0BlZVaKFqtsPbi9yGs7hI2h3nS3yr5zSmHoYHgDXBP6pwP0uxJ8Nqy21d/qTOPJx86lwsMWnKNAKYE+cGQ2yOQRxFv1rmVIeu7FFIkiwQh/YI9vjcyFRyDNXX1uxImnKscZPQjjHlDqzPo9s5zvpXLJQBadOkK7AneiBaaW6JBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khkfz519Z2Yx2qH/sfIM7mSZYBOk7UG2s8SXOjFn0+E=;
 b=lZA28rQ8E9a340rijn9pXGBYpUJ5TV1+fTo81GRkdiQD98XYihl2GZhhQdaVbiE5nb269jS+326wH3PRxGJ9RFZNjF5pJtiKlM4BKNgFyyLcG3hzyU4UCWIbe8OQ2Utq6OAYB5WcYBZyZRSCqQFIRtV9PzOqRNdUawZFNl40YP8iWJT9MF7YhT3I6tJ2nRDXpzBgNCR68Dx+hcXdtyMuvzHpcATzJH+y+obqCn5P4Z2yfeH6gZRt9gzRDw3hl2zcmFgd1TlgEgSMYiRK54QVseqmNb/BmdIVEmRgpfXfF/UrT7sW1m3maLzu8f4yVkFQb4Nk14RpMbc7LGe2p40aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB4072.namprd15.prod.outlook.com (2603:10b6:5:2bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 23:42:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 23:42:28 +0000
Message-ID: <8166d67a-de10-7c6a-c0c5-976fbac37a55@meta.com>
Date:   Mon, 21 Nov 2022 15:42:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170530.1196341-1-yhs@fb.com>
 <ee7248b9-50ae-f4cf-5592-49634913b6ce@linux.dev>
 <7b09c839-ea51-fc8d-99b3-a32c94d175b9@meta.com>
 <1b1d17a5-8178-0cf8-21c3-b60c7f011942@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <1b1d17a5-8178-0cf8-21c3-b60c7f011942@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:a03:40::47) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d35930-085b-4789-a6ee-08dacc1a0cc0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjNP4HzFbFBLq0ZcqbYtPZFB/3o6zyww9Znw9TfKTNmHJNdqras1xrhwwVJTwdfWETFLkoeyBO3GDQqosUedYLREXOIg7hcYE2vZvCpNQN8v9nNVDeDAKKvfrpPjH1BjzL2TMHDcVOijNLri4lMryPYYGplqvyOT5nNo8jpqEIS+hOAVXqN/2JW/mm3KqUH7omRXs85MrtRjYrDLj7ruNtUDhKGOx20BdV4Rggj3Skfg8qx50EgTxR+M+cfQO5aEcGCoB1WA65d1R26EM5rgRgh+dD/WZIYWOiI8Gy1dSGHsU3S7vDkJUmD63BO0iP3iTox8CCFb4PCBLmFzJpAjs5Pq6Q0ovxmqtiSRkPd/c3mbYw82qR8Q+oFGorx6E1ncvruTrn6xdZSav3wNXZM3kY564g68+76XndVhQt5Q35w4b4hEODsNG2ID+ZBPBK4Lq4Eb5XFHcvneQ3WfjEhfcg0syVKRt076wCE8/fuegpKI4Q4tsZP4pKfxCMvauuUbWjj3lxeyPKRoUYoaqiBzle5uB5a/1u608Tw+JDHuJh+AoqsNHyMf1BDiaqQQsIbAQvihdOF99sC9BRxu0u1aMcgeMWZSzrkajagj5+yhncWq18AfXmIz2c4uyFraRw61uwhF1xY7TVhYyRBjOo21hdPy1qgj0z5VYeG6hTO1+Kj1VrN6l58fSAUQKEwBTILU/nx7iSBhToQfjmsWvPKkcWIUYwRAoUS5m4E5nicI8ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(6486002)(478600001)(54906003)(6512007)(6506007)(53546011)(86362001)(31696002)(4326008)(8936002)(41300700001)(66946007)(5660300002)(66556008)(6916009)(66476007)(8676002)(316002)(36756003)(2906002)(83380400001)(66899015)(31686004)(2616005)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWhkcmp5YWtYSWNNT2ROTU5ma3F3N1M5UjJ4cEZjWHl2N3EwNmh5RnV5bnRz?=
 =?utf-8?B?cFZ2QTJhMVhQMFNZK2RscWVyYVNRaUQvUGEycXJ2NzJqOVByenh5QWEvVUNV?=
 =?utf-8?B?Qk42anJCbG5KTEpJV3IyaVUyRjFxK2pwS2QreGZmUlNpVk9xVG5Sd1U0WW5M?=
 =?utf-8?B?cG5hZ0xOQnN3NjUxSldacHp4eHJwY0RRM1dHYWhVMXdTdCtqVXNsWStoZXpH?=
 =?utf-8?B?YTZFZWhkcVBlT0N3Q0p2cVlCMCtSYUxkUHVrK0pmQVhjeFI5d1htTmIwaEVh?=
 =?utf-8?B?TjM5ZHVhRzc5ZURQUTBRaW4rclhLRnpDOTdaQ09DVEtpNjJMa3RMV0xMNWly?=
 =?utf-8?B?QlBTRVJQczBzTEhITUs0akkwUGJ3Z1ozdlFGM01TQmZDWkVVUG9GeUtyTk15?=
 =?utf-8?B?RW54TTVkV0s5dnRYeFNWVFIyVlQ5RThKRzhLNHFvVXdOWU5YbTE2Qm01QlFX?=
 =?utf-8?B?Wm5iMFh5djNiUFpuaDlheWlSMHZwWGlHd3ZWN053d1g1cEJmRnZsWEQ3QmJ2?=
 =?utf-8?B?Vnhscm53N2hVc2krMFhCVWhKZzVGUmE1TVRObktRSmFra2JUcEN1ajN3Yy9W?=
 =?utf-8?B?U0hGakhiMDJ2R3NVYzI2aEorc2s2VnFZM2Z0bmFaY3NCanIyYWRiTEZPUzlM?=
 =?utf-8?B?QTJmWHRrbkRGMHc0dnVzUE5NN1ZiTnZINGFJdk5OcmlQamI1RmlmWU9USnVO?=
 =?utf-8?B?M1gwNVVqRWExQ3J3eDdabmNBNzM4NmpnZkhvT1dzTTBmYkhMRDloalpSbHVi?=
 =?utf-8?B?SUxtc0JkcitFSGc3K3h4WlBlWVJqTFdVVjFEK1RJYndDbkVDRVVLUzlQS3gv?=
 =?utf-8?B?NEs3MGpTWWVCNTh3Z2VYT21xOXE2a2ZoaFI2TDNac3NqNmVSYURrT1YvclJN?=
 =?utf-8?B?YTBqTlpieEdyeHlmMy9kaVVuWFpqcjM4Vkw1Um1IVjNQdUNzTmZYS0xFd1h3?=
 =?utf-8?B?aG5NMDkwZXF5RDk1TkYxMkRrT2ZrcVNDSDdDNk1XSm5hTjY0cHVobEt1Tzd6?=
 =?utf-8?B?RmtSUVU1VkIwY01XU2dPV25WMUh6UnVMRHMyNitTZlMrMHJRdXJVa29jNEQv?=
 =?utf-8?B?ekpmNUNhMXZGY1pQNWFWTUgwWVpzakNHSSsvZE0rVkt6OWxaMEllMUFCWEdj?=
 =?utf-8?B?Y1I1RGhoc0VDK1NvYlJzY09DNTZIRk1SOFdYZ0hRYnBycUhJYnlRb3QwSEZY?=
 =?utf-8?B?cVZkTzl5UTdyS2tGTGQ2MFVCbzZ0NEJMZVNmd0NQdmFaeVU0enB6Uy90dUV0?=
 =?utf-8?B?aFd4amU2WCtxQTJxb1NmYS95SlBzSUpGQTVsOGdqQ0REeVBrakJUK05zeTA1?=
 =?utf-8?B?L1d2UWxCMllkN29QWExvTkVBTEpwa3ZKaHREU1BFcXZCVVZWUHAzUnNEdytk?=
 =?utf-8?B?QUJ1c1RUdU5rTnUxbk0rYzVTVTI5T3gzbmk2d3laN0pQalhqOGFOcHFhRkhT?=
 =?utf-8?B?RnBuT0I4eDkzbFE0WC85Y2k2cGZIT2VjQ1BSWndJZTY1QVFpUUsydzlVYU9M?=
 =?utf-8?B?WUVtNGt1T1FXdy95aTlYTDM0V0M5aVZiQ0ZBQWZWYzA4TnJMQWNRQVgzaDZT?=
 =?utf-8?B?Z1phYjN6Q3B1MWw4d0IxSjVMc0M4QkhMN3htdTJCQ0RjWG0rM0drSXo5bDVK?=
 =?utf-8?B?cGtidHU1enJhWU9ocUtYOEJYdGhZdXo5b2thTUdvZW5OdEZzZjZSZnlOM1h1?=
 =?utf-8?B?UUd3M2I3c3VMQ3lYWXdLenJtbWlxNGVZQ0Z1SUhwbEs3QTlWUCtGTzFhWjZF?=
 =?utf-8?B?ZGdQajlQZXBHbnFoUG50bmtLbnhTK1paYmxRdmdMSHh1enNHRjUxcXQwVkYv?=
 =?utf-8?B?MHJxdmxwNW1sWTdCVVhmc0FPTklaOTRSL1FqUk9aUmJMS3dTdWpubXBMUSs1?=
 =?utf-8?B?ZVIyRXgzS3MrV2tVYVFpSkpOR2ZjM0phQzhtajlQQkNNOEZHMEgwSUtWWUlx?=
 =?utf-8?B?d095VnkrRDhpUFN2TjlTQWN6UWcrMDllbjVMYkh5ZjRlZlpSYVVnQW9MeUJU?=
 =?utf-8?B?WVNVYlNEaURWbUx5WU1SZ1NBZUNtb3ZQY1dmMFVlZHdNQ2J2YWZiblRRZmts?=
 =?utf-8?B?ZlZNUkJDa3pDOGVLNnluZThEZ2ZIWlNvaWFPbjFhb2F6ZHZpUVV4ZURHRW5v?=
 =?utf-8?B?dnBwNEdSSURaRTNsZzJMRjk5b3dQTGRubjNUeW51YzZoYko3Q0FnaXZSblUr?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d35930-085b-4789-a6ee-08dacc1a0cc0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 23:42:28.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UFbjj8fA2ea+iaBiyhnpi8ABI9sRIIJkJLjYpWFynSA7yHsU3HSd4VzwsoW5plG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4072
X-Proofpoint-GUID: wlVy7mE4lAiybJMzIiip2GlJ_lrJ0Sz1
X-Proofpoint-ORIG-GUID: wlVy7mE4lAiybJMzIiip2GlJ_lrJ0Sz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_18,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/21/22 2:56 PM, Martin KaFai Lau wrote:
> On 11/21/22 12:01 PM, Yonghong Song wrote:
>>
>>
>> On 11/21/22 11:41 AM, Martin KaFai Lau wrote:
>>> On 11/21/22 9:05 AM, Yonghong Song wrote:
>>>> @@ -4704,6 +4715,15 @@ static int check_ptr_to_btf_access(struct 
>>>> bpf_verifier_env *env,
>>>>           return -EACCES;
>>>>       }
>>>> +    /* Access rcu protected memory */
>>>> +    if ((reg->type & MEM_RCU) && env->prog->aux->sleepable &&
>>>> +        !env->cur_state->active_rcu_lock) {
>>>> +        verbose(env,
>>>> +            "R%d is ptr_%s access rcu-protected memory with off=%d, 
>>>> not rcu protected\n",
>>>> +            regno, tname, off);
>>>> +        return -EACCES;
>>>> +    }
>>>> +
>>>>       if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
>>>>           if (!btf_is_kernel(reg->btf)) {
>>>>               verbose(env, "verifier internal error: reg->btf must 
>>>> be kernel btf\n");
>>>> @@ -4731,12 +4751,27 @@ static int check_ptr_to_btf_access(struct 
>>>> bpf_verifier_env *env,
>>>>       if (ret < 0)
>>>>           return ret;
>>>> +    /* The value is a rcu pointer. The load needs to be in a rcu 
>>>> lock region,
>>>> +     * similar to rcu_dereference().
>>>> +     */
>>>> +    if ((flag & MEM_RCU) && env->prog->aux->sleepable && 
>>>> !env->cur_state->active_rcu_lock) {
>>>> +        verbose(env,
>>>> +            "R%d is rcu dereference ptr_%s with off=%d, not in 
>>>> rcu_read_lock region\n",
>>>> +            regno, tname, off);
>>>> +        return -EACCES;
>>>> +    }
>>>
>>> Would this make the existing rdonly use case fail?
>>>
>>> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
>>> int task_real_parent(void *ctx)
>>> {
>>>      struct task_struct *task, *real_parent;
>>>
>>>      task = bpf_get_current_task_btf();
>>>          real_parent = task->real_parent;
>>>          bpf_printk("pid %u\n", real_parent->pid);
>>>          return 0;
>>> }
>>
>> Right, it will fail. To fix the issue, user can do
>>     bpf_rcu_read_lock();
>>     real_parent = task->real_parent;
>>     bpf_printk("pid %u\n", real_parent->pid);
>>     bpf_rcu_read_unlock();
>>
>> But this raised a good question. How do we deal with
>> legacy sleepable programs with newly-added rcu tagging
>> capabilities.
>>
>> My current option is to error out if rcu usage is not right.
>> But this might break existing sleepable programs.
>>
>> Another option intends to not break existing, like above,
>> codes. In this case, MEM_RCU will not tagged if it is
>> not inside bpf_rcu_read_lock() region.
> 
> hmm.... it is to make MEM_RCU to mean a reg is protected by the current 
> active_rcu_lock or not?

Yes, for example, in 'real_parent = task->real_parent' where
'real_parent' in task_struct is tagged with __rcu in the struct
definition. So the 'real_parent' variable in the above assignment
will be tagged with MEM_RCU.

> 
>> In this case, the above non-rcu-protected code should work. And the
>> following should work as well although it is a little
>> bit awkward.
>>     real_parent = task->real_parent; // real_parent not tagged with rcu
>>     bpf_rcu_read_lock();
>>     bpf_printk("pid %u\n", real_parent->pid);
>>     bpf_rcu_read_unlock();
> 
> I think it should be fine.  bpf_rcu_read_lock() just not useful in this 
> example but nothing break or crash.  Also, after bpf_rcu_read_unlock(), 
> real_parent will continue to be readable because the MEM_RCU is not set?

That is correct. the variable real_parent is not tagged with MEM_RCU
and it will stay that way for the rest of its life cycle.

With new PTR_TRUSTED mechanism, real_parent will be marked as normal
PTR_TO_BTF_ID and it is not marked as PTR_UNTRUSTED for backward
compatibility. So in the above code, real_parent->pid is just a normal
load (not related to rcu/trusted/untrusted). People may think it
is okay, but actually it does not okay. Verifier could add more state
to issue proper warnings, but I am not sure whether it is worthwhile
or not. As you mentioned, nothing breaks. It is just the current
existing way. So we should be able to live with this.

> 
> On top of the active_rcu_lock, should MEM_RCU be set only when it is 
> dereferenced from a PTR_TRUSTED ptr (or with ref_obj_id != 0)?

I didn't consider PTR_TRUSTED because it is just introduced yesterday...

My current implementation inherits the old ptr_to_btf_id way where by
default any ptr_to_btf_id is trusted. But since we have PTR_TRUSTED
we should be able to use it for a stronger guarantee.

> I am thinking about the following more common case:
> 
>      /* bpf_get_current_task_btf() may need to be changed
>       * to set PTR_TRUSTED at the retval?
>       */
>      /* task: PTR_TO_BTF_ID | PTR_TRUSTED */
>      task = bpf_get_current_task_btf();
> 
>      bpf_rcu_read_lock();
> 
>      /* real_parent: PTR_TO_BTF_ID | PTR_TRUSTED | MEM_RCU */
>      real_parent = task->real_parent;
> 
>          /* bpf_task_acquire() needs to change to use 
> refcount_inc_not_zero */
>      real_parent = bpf_task_acquire(real_parent);
> 
>      bpf_rcu_read_unlock();
> 
>      /* real_parent is accessible here (after checking NULL) and
>       * can be passed to kfunc
>       */
> 

Yes, the above is a typical use case. Or alternatively after
     real_parent = task->real_parent;
     /* use real_parent inside the bpf_rcu_read_lock() region */

I will try to utilize PTR_TRUSTED concept in the next revision.

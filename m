Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104E8619D49
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 17:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiKDQ3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 12:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiKDQ3A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 12:29:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789C4121243
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 09:28:10 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4E1N83005779;
        Fri, 4 Nov 2022 09:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=AA5zIZSMYeVLC3M7xtruhQuGRorFlV6V85wkNQ7oZQM=;
 b=bHUcTycMkK1KzYBcrK1Jc4a2N5ukC1YoVcXAWTkYJpj+osSHRbxJgUPY+d9u1iYw0Y9Q
 Z3LkkCNoPkj8VFkEcLyE8zyuQcazCFc1XpaValQVPmL5Z0YmNhF0sw7M/Z/r+pR420l8
 K35x11TAOs1qaVjV2JZVNyEy6G/FKP9UVpcOypxUcZco4W+3YuQLCzN3Z6bxJv1hzrVi
 S0hzks2bHDZkINIoHrOUzHM2CnAV0imL1Xqz7gjzxH2ObQ6BUvGbVY9Ulrl+A5oGgDW8
 d4WO4rBsJfe3zgdqIfrfyiLkEDxtaz6K/4+XVpGcGzMPEdG4umKnD7CziWq8Q0ErjKMf BQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kn44n98gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 09:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLmZImGbRnt6NEE2ak2BGfPDa1QqADVtpBGDrjOEuQKKKp99ZVtYtCIw2fp9Abqb5+QROeqX4L/rSYe7iRECX/rMOKV0tCoaqXDj6ULiQECZ+R8hNxg6xr38nhUsnziQw0fSf2HZVoR2Ap4+dZcvyw5BKwm7WKcIB+uBZ1+2DH3vmfrD1aleMRZzS0ZM1gAg7N8JYrndiWcX7g6UNJR02O7C1IDPDnaPcpigtkiZRyMA6cPRB9UPrKUt+sN85wl5MhfO9epqDKht03dpHt7d0ZMCRddgCBymmqUUb561WBoAtLjDtG5XAWXw2U7hCY5+ihxdtN4OdmiJfAipJ/3qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA5zIZSMYeVLC3M7xtruhQuGRorFlV6V85wkNQ7oZQM=;
 b=jBQViWdotsKqa3ky3hNghY5BxZomuQkH1OS0pa080Vlx+Z8R8LNDcZ7xKY+7B67nWP/FOvcr5RQeEpIVrWy6uQT0hDDFCFk7wSNGE2jCLJ0YtvTvlrCZIRFn4NUhcit6R+vKKekHgfEjTQjkRZkY5TFeMGbieC1HmNVoZiWBrhEyQI2jFGNgBVlIKmP4UrB38/+ROX6a23IE/WpAK0WyULAWqrEj+g4a2XeWgZXLKXzE9CPdyGoKncKD09uVr7/RXxr8aBW+6fRsHU1Q6KTPmOmJ/yBbaup4duSrNQpnHPpzfyRWI8Uw7fQ8bYKS4cW3bLpJDcXvdKaNnkTVb+qhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2778.namprd15.prod.outlook.com (2603:10b6:5:1ab::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 16:27:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 16:27:49 +0000
Message-ID: <8b8ca9f8-b795-ee8a-28fd-f44138f0e707@meta.com>
Date:   Fri, 4 Nov 2022 09:27:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 3/5] bpf: Add rcu btf_type_tag verifier support
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@meta.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072118.2323222-1-yhs@fb.com>
 <20221103221715.zyegpoc3puz6oimx@apollo>
 <CACYkzJ6m_H4cq=7SgYcaoYE9qGgquEh6FPHe9Kpr=j-DUCnvXg@mail.gmail.com>
 <429dc3c0-f7f8-6d4f-16ba-63042d9f0487@meta.com>
 <CACYkzJ4ta8sKkpQS1VkPSz9zLwh2uBErHQhetuWWFEYdCs2cDQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CACYkzJ4ta8sKkpQS1VkPSz9zLwh2uBErHQhetuWWFEYdCs2cDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4396025e-3985-40e5-ba26-08dabe818334
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYlUO5pSPCcetUAwSTTALbkt5wIGUTAKVDN0oqRHm47RjERp6pnpOkp8DHk6uLEvSjEwNNBYU4jCFAQ9r/K2YlV+QB6x5pHqhl6QODHPH+xM6AhYZE9Q7MwNzPpvt/ezEZftYWSVLJoFzhWlmkIdgPDcNMpBasjTC8ZCCFjfOeFWgq4PgXs5tpzHdxaxPrj/VQuj4ORKNmYEzSER24rDpjWNyVgiu1x+ooM+UehV+zwN+7OqmgAyEwxLBDL/nCk+Wzzs+q9CqJ2kPL/efeR5pEO3BeUzvoQoHagHWFR/dOXCVq1zWuEu4rUlrwiiB7r8ubpm2kcqBRIzIsCJK/bTZuFOAUCZ9XLaUbIjL40n3QwPVFywACk8/FfQXzdSX1LaIcVHCZ8k6jKTpO0nqPH0ukJdMy16dD6Ts1EYPlsd0NktnQyhD07TRCi8V0ufuQIcUA2c4SUGL9Ie15PpTDFzdIxlsklGjTx4+CwLn39nyHgAZgfJWhuI3yMWKBsf/n9nUX13yfIZmtn0N4YsR0FaliGFQJe3QQD1DZ41g3C9qWtQkVs0Mer5/6KfEMSzCUWPpdr5KDJlSi07VINRyl7bnvxHcQfA9kWNiiPQR7ezvblYJNu9yWKDf1gKWZxjrSo5W1neppIMvQsXBWuon/3SgcaZNDzgwofdsuz51l7sGn3bRK9O2MIwAWYfnulClXeK6B3/kvfjDmEek+OfPj21ydHKO+oVAYzixnbL2q/+nZ21Gpzm8Axtrzdso1fhc+wNY9438DLiHnYsk05wiza4uCaKsVwhlF9cXY2wnutfCJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(4326008)(2906002)(36756003)(53546011)(8676002)(66476007)(66946007)(86362001)(83380400001)(31696002)(66556008)(54906003)(6666004)(316002)(6636002)(38100700002)(6506007)(110136005)(8936002)(41300700001)(478600001)(5660300002)(6512007)(2616005)(31686004)(6486002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWx1ODA1TkpTSFdxOHZhc2piWDc5SloxU2JQS2tZbTd5RjZZSnBVaUxSa0pu?=
 =?utf-8?B?eDhGaDBqTFRKakg2UlhYN3pYb0xVNFhxSGN4UlVTd1BKUTQzdGRYTVFtUHdO?=
 =?utf-8?B?SDdRYXFTOUFTVkNkVHJsWHBZWFl2aWhyajBzbzcyVUQvMnVxZ0NhOWdwWFdW?=
 =?utf-8?B?UUxBVXhYN1FTL09NQmIzd3JtSWlBWGo4WE9wQmVZSGtTRWxPNlcvRUJpSUxK?=
 =?utf-8?B?dCt1OElKbzEzQVJuTlJCakt6eWEzUExJWHJ0RVczejZudHJ1djUyQmtLUFFm?=
 =?utf-8?B?S1gvZldJNkxGYnZ0eW9ueW82WXU2QlRjby9QcjhUTGhmT3EybThiR2xwSGdJ?=
 =?utf-8?B?dVQ2RXdZNE1SL1owaCtMQUN3UkJ5V1lySk5Nc3d5MU9USUorb0NWbFlNcXNw?=
 =?utf-8?B?cWZVQ1pSUTFQb2ZJUGRXWDIrb3NPdHZVQTc5cTJlc2Q4NDB5a3FvTDNhNW1B?=
 =?utf-8?B?L3FzZGl2UzB5R05vL1pOcVFiNW9DMEdaaUc3ZVd1eSszSHhrME1LeFJ0MlFD?=
 =?utf-8?B?WUdVY0Y2dWx6QUp2QksxYzVCRDRmUGNlbWpHN0xCSXJ1Q3hXQ0NIRVJIZjJi?=
 =?utf-8?B?aXBBRXNNWGd1VzRmMWdWZFlJMEh5ZkpVK2JJcktMd2hqQ21UZHBnR1Q0MHVh?=
 =?utf-8?B?QWdSUkhBdml6R1g0c2RWU1NrNGFCVUhWQ25rQi9MSWFIVkdDbngrbEJiUUVF?=
 =?utf-8?B?Y0hWMDlpRXBybWxHeVdSRTVXUDBsL3BOejZXeFptb0ozaUZadWlSZEJsQUMy?=
 =?utf-8?B?ZUlKWko4ZUxoMHdlbkg2empWdHowb2hOU3BWcTFXYlhqcUFpaENMbGxvOE5i?=
 =?utf-8?B?WDhhRGd6eUNMMTRlYlVyQWkxd2xLUFBBcWNWSFBHZ0xpNGhISVpabjJrbzJ2?=
 =?utf-8?B?NzZBOC83dEZqY0VBY2Z2cW5ZbkRXWGY4SUhDRXFRNmpjdllsWVJDRjgwQ1Uz?=
 =?utf-8?B?V3dEZU5vU2MxQS9MVytmYlFTMXRUajVoUnlSTXJoVitkcWhvbG5JM3l2TVFW?=
 =?utf-8?B?UzRaeEl0WmFDUUhYdU1wSHNSRmxTS3pUa3kzRVV3cE04MHNIekJmU21KZ2px?=
 =?utf-8?B?aXRsY05qZENlSTMzSmdaWWRhd1k5aWZJODhHbXZ0Y1FjeHNvcFQ1SlBCSWky?=
 =?utf-8?B?SkpvcUJkRWhCWFVBenNzNklXRlJKQk5GekVIRU5CWVRxYnRJdTJCZEg3RDdt?=
 =?utf-8?B?d2FKWFRRaEx1ZGRwWWx6Rng4S2d5bkgwTDRlWHl2RndqTHcwR2t5dlNaN0Y2?=
 =?utf-8?B?eHlRemttWW1NUUtzR3ZINlU5Y1JqQlI2Zy95ZFpzUUpjUFJMWlRiUDFvay9a?=
 =?utf-8?B?SGFjNUp3ZXRoLzJFSmFMc3c5RVhZNDVDdXlnZ0pYQkpxOVM4aDFnNEdlQTRk?=
 =?utf-8?B?NU5HOGs4NjBiblY5d0ZzaUdRcFJUTUNmOVNsa2poUVc2NXdmc2wyTkY5eE5C?=
 =?utf-8?B?Qk9XanlWSUhkRlQyV0NTdmdzd1V5YlVXTzZjOXFXT3QzeEhJWGUvR3JEV1dN?=
 =?utf-8?B?ajB4RTJ3SEtBT3FCWE5yckJMUmwwVyszbi9iSis3RzdrRWNZNGV0eElwczBx?=
 =?utf-8?B?ZXVBRXdNZ3FKUGRXZGcyaXhiS1hJYnFMNFFHbGQvOHhxT2ptQjZpb0JxMHJs?=
 =?utf-8?B?eGJhTDNUd1R2d082QStXaXVvdndYM2haa2lObHk4eXJGYTdmeVRtbkdIN3Jy?=
 =?utf-8?B?WWk3UkVoTldsL0Jqay9Vb28weGRPVWMrMDhCaUJQUTQwNkJzaGhVOFV2OEs2?=
 =?utf-8?B?MHlOZWFrUDdVQXRvekk4SkJjV21jMENKWHcrb0FBSXVQVXpObjZYL3lmbE5x?=
 =?utf-8?B?Uk5abGtNU3FuV1Vjdkd4OFVNMTdCUUhnbU5ZVng0S0VlaXNsakRJNVZMRGVW?=
 =?utf-8?B?Tzh4TGZsTkZRRmh3bks4Y2FXZGZxK2FNSVRHUXlnVHNieU1kTW95bXgwS2wv?=
 =?utf-8?B?blJvck54TzRuKzhNVTF6V21IQ2tvRUdFdW52c1NvZSt3SlFWbFRmMnMxQlRi?=
 =?utf-8?B?UlFoYmluWHpCRTk5eHJOOFhEZ1lvdFd5aVh3dHpjcVlETE1xa2VqVXY3b0U2?=
 =?utf-8?B?ZWdLdE8zSTFqRXMydGZMc1ZSRnZ0c3ovREttd25YOEhxTjJpSm91Z3JrRUI2?=
 =?utf-8?B?MjRwbGt4di8xNmlJaXJiRGg3MFI1YXNNY0tvYzB5VE4waktRaVJOYm1wV2x3?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4396025e-3985-40e5-ba26-08dabe818334
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 16:27:48.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IJAmdg+BlgJlJDoSllDPHMh0I/vFqBx7Wi/1+TJJ8bffP0LxdN88/s6Mcgj35Cu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2778
X-Proofpoint-GUID: QwfMf1NdkT_D3RQVmeEnLRAx33zG_Bwm
X-Proofpoint-ORIG-GUID: QwfMf1NdkT_D3RQVmeEnLRAx33zG_Bwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/4/22 8:32 AM, KP Singh wrote:
> On Fri, Nov 4, 2022 at 4:27 PM Alexei Starovoitov <ast@meta.com> wrote:
>>
>> On 11/4/22 5:13 AM, KP Singh wrote:
>>> On Thu, Nov 3, 2022 at 11:17 PM Kumar Kartikeya Dwivedi
>>> <memxor@gmail.com> wrote:
>>>>
>>>> On Thu, Nov 03, 2022 at 12:51:18PM IST, Yonghong Song wrote:
>>>>> A new bpf_type_flag MEM_RCU is added to indicate a PTR_TO_BTF_ID
>>>>> object access needing rcu_read_lock protection. The rcu protection
>>>>> is not needed for non-sleepable program. So various verification
>>>>> checking is only done for sleepable programs. In particular, only
>>>>> the following insns can be inside bpf_rcu_read_lock() region:
>>>>>     - any non call insns except BPF_ABS/BPF_IND
>>>>>     - non sleepable helpers and kfuncs.
>>>>> Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
>>>>> allocation flag) should be GFP_ATOMIC.
>>>>>
>>>>> If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
>>>>> this pointer and the load which gets this pointer needs to be
>>>>> protected by bpf_rcu_read_lock(). The following shows a couple
>>>>> of examples:
>>>>>     struct task_struct {
>>>>>         ...
>>>>>         struct task_struct __rcu        *real_parent;
>>>>>         struct css_set __rcu            *cgroups;
>>>>>         ...
>>>>>     };
>>>>>     struct css_set {
>>>>>         ...
>>>>>         struct cgroup *dfl_cgrp;
>>>>>         ...
>>>>>     }
>>>>>     ...
>>>>>     task = bpf_get_current_task_btf();
>>>>>     cgroups = task->cgroups;
>>>>>     dfl_cgroup = cgroups->dfl_cgrp;
>>>>>     ... using dfl_cgroup ...
>>>>>
>>>>> The bpf_rcu_read_lock/unlock() should be added like below to
>>>>> avoid verification failures.
>>>>>     task = bpf_get_current_task_btf();
>>>>>     bpf_rcu_read_lock();
>>>>>     cgroups = task->cgroups;
>>>>>     dfl_cgroup = cgroups->dfl_cgrp;
>>>>>     bpf_rcu_read_unlock();
>>>>>     ... using dfl_cgroup ...
>>>>>
>>>>> The following is another example for task->real_parent.
>>>>>     task = bpf_get_current_task_btf();
>>>>>     bpf_rcu_read_lock();
>>>>>     real_parent = task->real_parent;
>>>>>     ... bpf_task_storage_get(&map, real_parent, 0, 0);
>>>>>     bpf_rcu_read_unlock();
>>>>>
>>>>> There is another case observed in selftest bpf_iter_ipv6_route.c:
>>>>>     struct fib6_info *rt = ctx->rt;
>>>>>     ...
>>>>>     fib6_nh = &rt->fib6_nh[0]; // Not rcu protected
>>>>>     ...
>>>>>     if (rt->nh)
>>>>>       fib6_nh = &nh->nh_info->fib6_nh; // rcu protected
>>>>>     ...
>>>>>     ... using fib6_nh ...
>>>>> Currently verification will fail with
>>>>>     same insn cannot be used with different pointers
>>>>> since the use of fib6_nh is tag with rcu in one path
>>>>> but not in the other path. The above use case is a valid
>>>>> one so the verifier is changed to ignore MEM_RCU type tag
>>>>> in such cases.
>>>>>
>>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>>> ---
>>>>>    include/linux/bpf.h          |   3 +
>>>>>    include/linux/bpf_verifier.h |   1 +
>>>>>    kernel/bpf/btf.c             |  11 +++
>>>>>    kernel/bpf/verifier.c        | 126 ++++++++++++++++++++++++++++++++---
>>>>>    4 files changed, 133 insertions(+), 8 deletions(-)
>>>
>>> [...]
>>>
>>>>> +
>>>>
>>>> This isn't right. Every load that obtains an RCU pointer needs to become tied to
>>>> the current RCU section, and needs to be invalidated once the RCU section ends.
>>>>
>>>> So in addition to checking that bpf_rcu_read_lock is held around MEM_RCU access,
>>>> you need to invalidate all MEM_RCU pointers when bpf_rcu_read_unlock is called.
>>>>
>>>> Otherwise, with the current logic, the following would become possible:
>>>>
>>>> bpf_rcu_read_lock();
>>>> p = rcu_dereference(foo->rcup);
>>>> bpf_rcu_read_unlock();
>>>>
>>>> // p is possibly dead
>>>>
>>>> bpf_rcu_read_lock();
>>>> // use p
>>>> bpf_rcu_read_unlock();
>>>>
>>>
>>> What do want to do about cases like:
>>>
>>> bpf_rcu_read_lock();
>>>
>>> q = rcu_derference(foo->rcup);
>>>
>>> bpf_rcu_read_lock();
>>
>> This one should be rejected for simplicity.
>> Let's not complicated things with nested cs-s.
> 
> Agreed, the current logic tries to count the number of active
> critical sections and the verifier should just reject if there
> is a nested bpf_rcu_read_lock() call.

Okay, will not allow nested bpf_rcu_read_lock() for now.

> 
>>
>>>
>>> p = rcu_derference(foo->rcup);
>>>
>>> bpf_rcu_read_unlock();
>>>
>>> // Use q
>>> // Use p
>>> bpf_rcu_read_unlock();
>>>
>>> I think this is probably implied in your statement but just making it clear,
>>>
>>> The invalidation needs to happen only when the outermost bpf_rcu_read_unlock
>>> is called. i.e. when active_rcu_lock goes back down to 0.
>>>
>>

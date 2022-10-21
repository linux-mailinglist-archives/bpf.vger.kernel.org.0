Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B3608080
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJUVGN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJUVGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:06:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66D12565EB
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:06:10 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LJTE7k012826;
        Fri, 21 Oct 2022 14:05:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=S3f6/4N8P3p0OcWnmqcFbd+q3ELRyMPlUW4KAXWiAz0=;
 b=hV1kQ9gItAsd2HFbKgsZgYfSP7ujYaPFfihhor7MAy5wICO5Sy8+5kjDkxGMh0YZm8Rr
 hjJFJbyeqwm8KmKe0RQbDbsktSxLHA1yOx/muWMk4OvnIV3rzEHVkpEVSF/JmF5Kiz4E
 I4PxPXMRBXo96nBAlWcV/NOwbFy/4rBFNpPXu3pNVtf4abVrBeyJVbSyc6kkKLAOKjUX
 z5S1eKUuyLDraQ86BkbBdPMMMvH4kB0jjvtxgoEY/6V2roUmOsfsYHe+pKlsPV4olmpn
 6fRubCEwEyqPMGfk0LgtrdQrNGq/wo3my/y3hez8rxNcD8uUgt7+UYJq9NoyTkawvB2A 8g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kbvcymbx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 14:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU0gc9peBJBq2Zb1gogUJDojnJpda0cj7eocC7nxumQ6X4To/5YLbdGMlADZnLsjaCT1X1kg8KzTbZiyjorLFxCmvS9gYUdtFMg4aCb0avVq3zEAWvFpkioBIK6+9tXLIcbQ2UoXvjVX67jimj1x7yeFOGpRKMdCoTzblpjmiEtl4QP7s1nrUw3joTBuuMM+ujkrU+cQh2mI0tO/wH/sHBSwxbuU+q54kMYkjeefM9wYcT2bJMN4YBxlTckjf87DC6m8+1M98sxnnfY2jjog8Gl6nlSRBzQQ192Ys65UGCVaHJiq0yVTfg+4W4WAGOP0BBx9sQfG8ppzkEn9h+Tydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3f6/4N8P3p0OcWnmqcFbd+q3ELRyMPlUW4KAXWiAz0=;
 b=CLbEYDCToXPQLwCcGc0yrPf5Y3D/zP7gq1oOygZECL5WD4dahRsmXn1HDYhNBBRsaY497619FeZUaGTKIWh2r6HaCH2Ni61JFI8vPcItp1uk1ZtGyBujl+ya1OxQGmWtjER3PzeLNo5vICe4huOOgy8UevW2kiojAvOhB52SKlE0yxvHY+BNlJjUUIBx+slZYs5k06cROaTwvR+2vIlBNZarYtNVvkQbKBK65fd1w4jaZPnPke/y1NSDwyvBixfmOBEZ9fRRxsoRHva4JuXcAAglTBaCSJGWVFsMxN/l11chautn6C3UTpSIBuAAgqvR7RuLTOvBulAhkmdDDuJhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3674.namprd15.prod.outlook.com (2603:10b6:5:1fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 21:05:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.036; Fri, 21 Oct 2022
 21:05:33 +0000
Message-ID: <9abed364-39a3-b8c0-78ba-9d9ec45277ee@meta.com>
Date:   Fri, 21 Oct 2022 14:05:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221306.3554250-1-yhs@fb.com>
 <CAJD7tkZb8vRWbBn5Z75MXf_g8tYTThYgkLXYKPUT0zzcRaK7+w@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAJD7tkZb8vRWbBn5Z75MXf_g8tYTThYgkLXYKPUT0zzcRaK7+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3674:EE_
X-MS-Office365-Filtering-Correlation-Id: 691269ea-de65-4c3f-f073-08dab3a7fe16
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6Wp5Newc5x7mVy6+yIyD97BOINWHcK7/eFphTjxqJfHGq8GAQVecRrlk4yTcGjNYoD6EzC2QrnyIp/ioZK5l6W9Uv4VV2u9KfQyn+RqGT+PAJ7q26vTqGgi1yuzYUaEtiuDUhzUuIY5R4MDlcYv32fC7KGQhG+IswwUxFqv99y5TLla9b18/srSKYEjJG+QXRIE/8ouowKPDY7/7q7xm26roR33ml2Z6b8yR88m6TYxaaHZym2hpBGy/XTIayvdgkUdxGuRaiiVSXDLwUTDlP10a/QUsQqJHC/2egQDSDgQxOClASo3LqwHD6OEryxPS/PctFVjTtIYqLOegJ2RcgnVzIfR3U0LHwtBq/oDPgz5ljOGWQWN8HOFcdQgzcbiVKqZ9UHs6GUzbHApjvqW64Mpy4U6lcwks0FB4fHJFFgPOZumsDX3+7KFjH5+mfpblm3hzGttzxaB3/BpdgMPhcmB1MrrQ602tgv+665M5mgX2Oq+gmqmCeFTHeKIEB979m71Wb+mdITsXXynQ2eEixR4lXONcUrbgu+UADdABJ0jd0+yCKQ9JXtorQjBGFCLeEPPDpbOsMrJGCN/omjdgY617heKp8uCflKTIKWIPzylWqZxUhKlNVpKrk0MBaYkF7tTHATW3q5WesmWKdUQDq+wfBFHvfu+QoC47MKc4UrjKekp9JrhDplVDOBcwKy0RLH19L+MRW2mBcDXFnkZrgGRysaZkHh6WXJqGhtMkTW1DUZEKuXWGwSHqWf+R7NFpVqgO2WFp5iuJ5mC51HP0Ca1BDfz6Es8kHp4r94lz5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(6486002)(66476007)(31686004)(31696002)(38100700002)(36756003)(6506007)(53546011)(2906002)(8936002)(86362001)(316002)(66946007)(8676002)(83380400001)(4326008)(2616005)(186003)(6666004)(5660300002)(6512007)(478600001)(41300700001)(110136005)(54906003)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlpbE41Nk5WdGZFU1hDSXE4eVRXV3VuV29oQWJwVlk1UWduTGllbGVqajFi?=
 =?utf-8?B?aktTay9HS0FjS0xzbVZkQVU3aU45R1BpQUR6TFZTWHlHL1ZPaFlMWUdYVitw?=
 =?utf-8?B?eGt1VlRWb2JSR1BmczhjeXF4T3VSZm0zak92ZXE5TGJyNjB2K3dkbkJyb0wz?=
 =?utf-8?B?Zy9KU0VneUlwYlVnV2h4VTczcTAyU25hWXNLWEp4L2hlZE5UZEhsVStvMG02?=
 =?utf-8?B?eFBGS1ZXdndmNlZnNjVTaXlmU0dtUDErdUJ0dTYvM2M1S2JLdWM5T3M4dGlG?=
 =?utf-8?B?M28vZmMrSS9WMks4cUJLV1E0Q2NzTHVKdkk5djVNQWFaeGNFWFZhSEp6TDVo?=
 =?utf-8?B?Yi9SQ1FFazdibDJVNzF2OWtPd3UvV1Z2NDd2Z3d5dDEvU0hQNjg4Q1Q2Mmd4?=
 =?utf-8?B?OVA5bVFXMm1rVWN5SzdJYW9GbURvQ2ZIMDhUalNmNkJDa2NPZWhhUnVnUHJy?=
 =?utf-8?B?cE9veEdYOHk1blc5QmdIRjM4Rkg5Q0tsQmhyaDFUdmEwRnl6V1hPYXg0T1E2?=
 =?utf-8?B?UURKUkxvMFUwYVBkSGFCVUpOZzFjZFhzSFBmcU5tdzdLQW1TalQ4Wi9teWh0?=
 =?utf-8?B?RVF1YVhEbjZsbWRPcVp6MlNhWUVMLzl3RVExaVhYbDVSSlJkTEg5aVViSWNR?=
 =?utf-8?B?a3BnenZIK3FpYmFoY2F1Y0JuSHdiV3hPeFAxbGNXWFYrTzlVOHV0UlRGY3JO?=
 =?utf-8?B?YlJzSkc5aWxuMlBBclN3MUJQaWRac2tQM2p3MGd1RTZyalpGUVBjWEhYT1g3?=
 =?utf-8?B?ZUdxYTB4SjNsNlhxRXFxNlE4RHUwRUpEZzltUDhjYkQwRXlDU2JudUxyWWFY?=
 =?utf-8?B?eEc1L1lmdytrTXp0MXFTL0tXKzJlSXhvTzUxZ25JSm1CTHkrSHRCdTNvdlNI?=
 =?utf-8?B?NlZMcDVwMVZYWXBGY1YwU0liUkphOW8rWVdEbUVWNVE2Rk5md1luR0g0ODlK?=
 =?utf-8?B?akxLN0xhKzVuSWFYUTlQdk9mSEx6cStHeVZYaDdoREFMUk5mMHk3TzlMZFBX?=
 =?utf-8?B?LzBsbVQ0aWhmRm92K0h1MGI4YWVpZnA3eG1hRURvSWNWdE55TjlpN2FpeUNK?=
 =?utf-8?B?VDZrczVxcWVsdnVHNzlyRHJycWV6S3hvek96NVMzK0ZYYVFuWTRoZXVKK2hk?=
 =?utf-8?B?cHlDWUN5bGNSanYrKzF0U083Z3FJQTVvcmN4dUROZWlQQit2dVh2WWN1T1dm?=
 =?utf-8?B?ejNRYTdpbGttRjQyQ0tNOUhrM3JJRERMcWZkMWNGOTF6MUJOMzhtRENHa0ZJ?=
 =?utf-8?B?SlZ3TFhwNW9TZGgzUVZzQTVZeHBZc3haaTM5dFVkOGZDTUs0R0dLTTh5RHpN?=
 =?utf-8?B?U21pUml6MUNTVm1GU3ZKUkJ1cGsrNi9OQzNnVmJvcERFRHpDSHM4YUpYd3Fa?=
 =?utf-8?B?ZDVtM1RzbU9td29wcXl6cXZjNXBIWVVNam55aUczK1hJeHJVQWFKbUN4VFUx?=
 =?utf-8?B?Y3BsUXRsTHprU24xdzB3WkJhZHNSQ0dadkgwZy8rdzJRQUZKOVgybDVHdHBl?=
 =?utf-8?B?SUdJK2I4MlA2Y1Y3Q1Zmcm1NdGtkdzNWVDl0Y1h3NjhYS0FIcVZRSzM1bGZV?=
 =?utf-8?B?SzZDMGJqeHFoUTg0Zmh4ZGM2YUdndnBSa00rVkJzQU0vaHlieEVUY0NucDlB?=
 =?utf-8?B?ZUFDYTY4amhCc1pJM3ZMVnV5Q2hCMkF1cW5KSlBzTVA2MnFjcUpjU2tUaHRx?=
 =?utf-8?B?SDgydWJQSEsvODVaVG9DMFA4eFF6R0RubHNTVnR6djlGT1daYzZYbDBPMU5Y?=
 =?utf-8?B?UmVSZy9lZHBXS0xQdzVGTGkyQ0VHeXByUHNSNSt5VXI0UzFrWGNtTWxWYkpa?=
 =?utf-8?B?WngyRmtVWVpGTit6ZkFrTGFpZlEvZFo3NTJWQjZMbEE4SS9DN0lsL3Z1aXR1?=
 =?utf-8?B?QmRvUzRCY3h1ZTRISmtpOTE1VjhCRGhpUThHQ0h4TEt0cVRWYk9HdzZOQ3RQ?=
 =?utf-8?B?UERlc1lDTy9seGtIdFcrb2t2bnRxUDc5YmFVeHQrcXpLU1JpRHN3ak8remxm?=
 =?utf-8?B?cGd4UGhudEFjbEQxcnhxR1QzdVpGMTVrU2Y0SDRkcjJzbWk2Tmx6M3JHdnMw?=
 =?utf-8?B?MHRFUExzcThrbXVPOUgySzczejA1KzRkZ2xUVU1JMitrN2tBamdQMVkxK2gr?=
 =?utf-8?Q?Tg/c0jh4OA+2WtCH+jJ5daiEu?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691269ea-de65-4c3f-f073-08dab3a7fe16
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 21:05:33.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDJ1zpa91T60zV4TmyWJ1Igz/iY3kdBY3u0mYK1h2FkmeNHbbszb2kZKMPtpJwQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3674
X-Proofpoint-GUID: apf-JlbOsFxMVIRonWJIBW4EeLEInJcF
X-Proofpoint-ORIG-GUID: apf-JlbOsFxMVIRonWJIBW4EeLEInJcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/21/22 12:29 PM, Yosry Ahmed wrote:
> On Thu, Oct 20, 2022 at 3:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Similar to sk/inode/task storage, implement similar cgroup local storage.
>>
>> There already exists a local storage implementation for cgroup-attached
>> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
>> bpf_get_local_storage(). But there are use cases such that non-cgroup
>> attached bpf progs wants to access cgroup local storage data. For example,
>> tc egress prog has access to sk and cgroup. It is possible to use
>> sk local storage to emulate cgroup local storage by storing data in socket.
>> But this is a waste as it could be lots of sockets belonging to a particular
>> cgroup. Alternatively, a separate map can be created with cgroup id as the key.
>> But this will introduce additional overhead to manipulate the new map.
>> A cgroup local storage, similar to existing sk/inode/task storage,
>> should help for this use case.
>>
>> The life-cycle of storage is managed with the life-cycle of the
>> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
>> with a callback to the bpf_cgrp_storage_free when cgroup itself
>> is deleted.
>>
>> The userspace map operations can be done by using a cgroup fd as a key
>> passed to the lookup, update and delete operations.
>>
>> Typically, the following code is used to get the current cgroup:
>>      struct task_struct *task = bpf_get_current_task_btf();
>>      ... task->cgroups->dfl_cgrp ...
>> and in structure task_struct definition:
>>      struct task_struct {
>>          ....
>>          struct css_set __rcu            *cgroups;
>>          ....
>>      }
>> With sleepable program, accessing task->cgroups is not protected by rcu_read_lock.
>> So the current implementation only supports non-sleepable program and supporting
>> sleepable program will be the next step together with adding rcu_read_lock
>> protection for rcu tagged structures.
>>
>> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup local
>> storage support, the new map name BPF_MAP_TYPE_CGRP_STORAGE is used
>> for cgroup storage available to non-cgroup-attached bpf programs. The old
>> cgroup storage supports bpf_get_local_storage() helper to get the cgroup data.
>> The new cgroup storage helper bpf_cgrp_storage_get() can provide similar
>> functionality. While old cgroup storage pre-allocates storage memory, the new
>> mechanism can also pre-allocate with a user space bpf_map_update_elem() call
>> to avoid potential run-time memory allocaiton failure.
>> Therefore, the new cgroup storage can provide all functionality w.r.t.
>> the old one. So in uapi bpf.h, the old BPF_MAP_TYPE_CGROUP_STORAGE is alias to
>> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED to indicate the old cgroup storage can
>> be deprecated since the new one can provide the same functionality.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h            |   3 +
>>   include/linux/bpf_types.h      |   1 +
>>   include/linux/cgroup-defs.h    |   4 +
>>   include/uapi/linux/bpf.h       |  48 +++++-
>>   kernel/bpf/Makefile            |   2 +-
>>   kernel/bpf/bpf_cgrp_storage.c  | 276 +++++++++++++++++++++++++++++++++
>>   kernel/bpf/helpers.c           |   6 +
>>   kernel/bpf/syscall.c           |   3 +-
>>   kernel/bpf/verifier.c          |  13 +-
>>   kernel/cgroup/cgroup.c         |   4 +
>>   kernel/trace/bpf_trace.c       |   4 +
>>   scripts/bpf_doc.py             |   2 +
>>   tools/include/uapi/linux/bpf.h |  48 +++++-
>>   13 files changed, 409 insertions(+), 5 deletions(-)
>>   create mode 100644 kernel/bpf/bpf_cgrp_storage.c
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 9e7d46d16032..674da3129248 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2045,6 +2045,7 @@ struct bpf_link *bpf_link_by_id(u32 id);
>>
>>   const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
>>   void bpf_task_storage_free(struct task_struct *task);
>> +void bpf_cgrp_storage_free(struct cgroup *cgroup);
>>   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>>   const struct btf_func_model *
>>   bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>> @@ -2537,6 +2538,8 @@ extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>>   extern const struct bpf_func_proto bpf_set_retval_proto;
>>   extern const struct bpf_func_proto bpf_get_retval_proto;
>>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>> +extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>> +extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
>>
>>   const struct bpf_func_proto *tracing_prog_func_proto(
>>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>> index 2c6a4f2562a7..f9d5aa62fed0 100644
>> --- a/include/linux/bpf_types.h
>> +++ b/include/linux/bpf_types.h
>> @@ -90,6 +90,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
>>   #ifdef CONFIG_CGROUP_BPF
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
>> +BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)
>>   #endif
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 8f481d1b159a..4a72bc3a0a4e 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -504,6 +504,10 @@ struct cgroup {
>>          /* Used to store internal freezer state */
>>          struct cgroup_freezer_state freezer;
>>
>> +#ifdef CONFIG_CGROUP_BPF
>> +       struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>> +#endif
> 
> Why is this protected by CONFIG_CGROUP_BPF as opposed to
> CONFIG_CGROUPS && CONFIG_BPF_SYSCALL?
> 
> It seems to me (and you also point this out in a different reply) that
> CONFIG_CGROUP_BPF is mostly used for bpf programs that attach to
> cgroups, right?

Right. It should be CONFIG_BPF_SYSCALL. My v1 actually used
CONFIG_BPF_SYSCALL and changed to CONFIG_CGROUP_BPF in v2 thinking
it should work, but kernel test bot complains. Will change back
to CONFIG_BPF_SYSCALL in v3.

> 
> (same for the freeing site)
> 
>> +
>>          /* All ancestors including self */
>>          struct cgroup *ancestors[];
>>   };
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 17f61338f8f8..2d7f79bf3500 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -922,7 +922,14 @@ enum bpf_map_type {
>>          BPF_MAP_TYPE_CPUMAP,
>>          BPF_MAP_TYPE_XSKMAP,
>>          BPF_MAP_TYPE_SOCKHASH,
>> -       BPF_MAP_TYPE_CGROUP_STORAGE,
>> +       BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>> +       /* BPF_MAP_TYPE_CGROUP_STORAGE is available to bpf programs attaching
>> +        * to a cgroup. The newer BPF_MAP_TYPE_CGRP_STORAGE is available to
>> +        * both cgroup-attached and other progs and supports all functionality
>> +        * provided by BPF_MAP_TYPE_CGROUP_STORAGE. So mark
>> +        * BPF_MAP_TYPE_CGROUP_STORAGE deprecated.
>> +        */
>> +       BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>>          BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>>          BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>>          BPF_MAP_TYPE_QUEUE,
>> @@ -935,6 +942,7 @@ enum bpf_map_type {
>>          BPF_MAP_TYPE_TASK_STORAGE,
>>          BPF_MAP_TYPE_BLOOM_FILTER,
>>          BPF_MAP_TYPE_USER_RINGBUF,
>> +       BPF_MAP_TYPE_CGRP_STORAGE,
>>   };
>>
[...]

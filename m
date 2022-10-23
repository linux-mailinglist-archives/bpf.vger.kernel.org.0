Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FCB609517
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiJWRUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 13:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJWRT5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 13:19:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D654D1F2D3
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 10:19:52 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29NGoTqi002713;
        Sun, 23 Oct 2022 10:19:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=0BIOAtNXyb1UW56Te4orJa15Ue3Xk1X4oZYOeh1CT3E=;
 b=dx6ui5XJ5kDanl8hEownESRao7OL5RfAYZKHNGeTiHYOMUdWE6hEF1hSTmLqeZnGqP47
 ahVlEzoG38Tp2887JioA3hCbCT57yGoohtWmvPuscoOUHFQ1qpmNqA/dkanOmhDDCgIb
 iBDlFfBKbS7/q8+WXt8ly1K11pr3KEqZspcjIpDmlINuHmu0veFuq8Lbbmb3dWm4Nuq4
 VEceflFmSEbGbXOU+gevYT5KnshbfKb+wlrVDdtrIsjyiN8rOAL5ZWT+dPJHJ5PVrwDc
 72Y1EJ5rNS4mvsALYN8lCNVOnHFvgtNMLPrRhmR0OSq6k4338hQP+MbpJzJyGLQn3zCn lw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kccjnbgtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Oct 2022 10:19:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdzEf44uyRgfCaK5jBawPHtQmP/W/61+lo21NPbEtk6maanYoeLL8C27dK1/vhVOjGTlYdOLewPluDM4IDbXO8poPStXZ8bNiVYkyJboN1dzjL9/sMrclu91sj7MnW+HoqwzGM8x9ziq291L+mkRx42Y+K3eaN/w057NanOSg1k6Qolpp2sYFuv1Mw/LesziWKLKieV0suzpLh5nOV2AdTQzINPiVkAYXlnBHebCqHY3SKYHXuzKmAYJQw87ZagbqpY3dTrWkBfC1XOnKtS6Lj3enlqMywyduWFH5L/+haLvSdVqXIHux7kHDSVONQ0N97miVQLdHAFKkbS39jlj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BIOAtNXyb1UW56Te4orJa15Ue3Xk1X4oZYOeh1CT3E=;
 b=TI7OSzAAmdDnWgpY//Eyk214vdvbIwY1NGGpyCOy5exFRT7ynYULmk+CTnL5Oaxn4ziMCXTiJQ7a8Ji0bTA7el6JTDzo52vvrc14FRSiaDJEYyFfSS/s9/QifQPvEkhwwJoge19AGIcKjsdmoBropR58jQsg33gIUvHxEWyM8VyAP3pxobfGfxkJb6N+etlbBfFUO8Qu7JcrmwtSZV1hH/Q9kR6GaQVAe3JIeZUd3N41cWRxzSt80xIsMFcE5qmeGT92NN81qpzl79UXbsaBDtzQ+rlJ/kQ1IMRnKTl+ZQLm/1TUNaB2Qz5QyT4meEBMDDHlWS0oaZivDzsfqR1+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2749.namprd15.prod.outlook.com (2603:10b6:208:127::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.36; Sun, 23 Oct
 2022 17:19:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 17:19:32 +0000
Message-ID: <8344762f-5f24-cf05-4062-876fd94a3e89@meta.com>
Date:   Sun, 23 Oct 2022 10:19:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v3 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Content-Language: en-US
To:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221021234416.2328241-1-yhs@fb.com>
 <20221021234432.2330783-1-yhs@fb.com>
 <Y1TQof8LPg1Btdbq@maniforge.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1TQof8LPg1Btdbq@maniforge.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB2749:EE_
X-MS-Office365-Filtering-Correlation-Id: beb2e816-256c-4bdb-841b-08dab51ac035
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6MUqXU7D9biknVH5kFVrU5V4q5WZB23s9zJ1GwVtMbdbPG/nXM1sXVfdMyrANdEEVVfEA05Gv9jzVvJ1eiqBE8NQ/uOdFn9+TMi3iu5mVvtmCAQH9Up9v7zD2IeUBOqpE6ps6BfwjyVoJ0jEt4Bz9B0uMnVUisPg9ugxWCZNFi98L/SYnim6VxFIkfZulPPBbI7V1up1tt1KzwWIF5iSTNiF9FFUJxH4u0Ny8xekDWc+ZRIMZSaKi5VcZtjGbei6U3bTwKtZ3Q//ijt1CFsQtf9SLUo7nOT4vCJ7cLEkN1GhApQKa2f/NznSmRMEVrnUNcLByirTcBwOTDUuL2ADb1Z9mHtEYZor++byAOTv9vaX1EugOPhweSccTU+2ew0N1I8W+ZNx3z7Z1l0oirlbcoLZRrJiPXuNGlw4xTcKU4/I+7keyIT0HZTwApMQ+QON7XyOCuJ2kztKx6gkIh3v7kOsAH6j9le40Nu+IQTjG8Clm+7Voo+1IPm4uTS3lKmIdwLIGFroQAvY8pRzcx/7ujADeeK4MG1xaF0Z+rqdYn5Kvzd/qmm5i85IshNuzpvjDb6f/f8LnsCRppPsqYQNeY1niZzjHLsUA2LbGrw8umUuJ06gFYspHOicWYfLsBeUMApKiBJckHmOnxzQKAiWICgm3F8DR9lAs02p3w0hIswdNqXlPxmaItQgehoPzpX7oPHG5Foa7RSL+/+dk7yq6o685RuHQvmz1A1z8ubSy4l18o1NEUgNFuzghaWfcsJRgwl91u04NwUnSZNgC/7KFWkBuZrmP4CogYGjWRrhnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(36756003)(31686004)(31696002)(2906002)(5660300002)(38100700002)(86362001)(186003)(83380400001)(53546011)(6512007)(2616005)(478600001)(6486002)(110136005)(54906003)(66946007)(8676002)(316002)(41300700001)(8936002)(4326008)(6666004)(66476007)(66556008)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWhzaHNYQmlhUTVMb1FRVUQxS3BjSmk1cVg5MlV1ZC9FOG5hMm9vaEx0S2FR?=
 =?utf-8?B?RjFlUGROU0FRaVJLWkZZVktYclRiQkxzZ2JUN3NVcUhoRmw5bjRwT1hXUXF5?=
 =?utf-8?B?R1N0L28rcTBHNWlLazBneDVCTWo3RXlVUkxENEJObmdhODRIV1dQSXYzTXZ5?=
 =?utf-8?B?ZkpmamRKL3EyekhOY1hZZlZxY1liTGxCYVNhRDhCN0Y4bllGWElJU05UY01k?=
 =?utf-8?B?aGpSVTJyU0ttZEpNblZWeHZndWcwYzNOK3dkOTZ4Zk5EVGRQY3RSOTJZTHFR?=
 =?utf-8?B?R1R0TkhRYlVBdnlLYUt1blZWRjZUQTY2MWV3RkVYRXB6eWhMMURZNkgrcHdJ?=
 =?utf-8?B?UGlrSDFMRmUwSzhiQ1JtQTNJOFJvczR4TWxxZUdMdmZPOUV0N2MwWjB0V24v?=
 =?utf-8?B?ZVBDS1ptR2ZOTGkvZHcrK2VmZmwxTlVuUzMwalNMV2pGQXFocTJ3QkE3QnNt?=
 =?utf-8?B?Y2psZDd1bXpEb3NQT3lQM1ovbzdwb0lRbTFzeWtJRXljaGVtZnZKTDZSMVF2?=
 =?utf-8?B?cy9nVFhYQUliRWJ3ZUJON3RIRkRyS1pvUjlNZThtaFlYMXNDZkYyNzhIRWRG?=
 =?utf-8?B?bWkrOG1oNXhjK0xTMW41R0ExUUFjQXBkUy9IaC9hOHgvVCt4bUtsbHpncTU1?=
 =?utf-8?B?UkNpS3BGQ3VoeEJ5TXJFV0VPWXFNajFuQ1hxNTJ0MXh1SHFLbWlqdTREQU9R?=
 =?utf-8?B?L25mMnNlMkZBR3M0VFhERjNVOWcxQkVHd1JaZlc1VnlMUGtyK0ZxcWlzczRs?=
 =?utf-8?B?VnhXZXZqNFBSN0tOVUQxNlEvYWZJWkFNS1hrZFhhSk4zcW9WZlJnaFBHdmxF?=
 =?utf-8?B?M05nY2tMelZmdWVkc0V2Nk1BSlE5Umw3TW5UWVB5TkQ3Zm1IK3FxNStXeG1r?=
 =?utf-8?B?UVRTR3BBaFB0L2hqclk3VkU4eC9NT3F0M3lmL2x3NDBmbmovOHdLRkxwYVQ1?=
 =?utf-8?B?RUpsbWxJUlBObFcwWFBRRTNwWTgvaTBueGxpZllmaER2VG5NUGc5czlEUm4y?=
 =?utf-8?B?RTB4OUpzeWpPS0xwVzd1Q0xHUjJFclduK2EwWGdrMlJ2dnpaenpvcGtsTWFx?=
 =?utf-8?B?R2hsN1VkWDBLUmNvZnJNV1IvZnpiYmR5N0JMMVhheGJRdmNYNHphSWZkZkd3?=
 =?utf-8?B?ZlBZOW5XZ0VvcTZWQmltaXl3dVdNRHdxTTU3SWtlTmZvRDIrSUJMYVU1U0pv?=
 =?utf-8?B?ZGIvaE0rN3p1dG44d2ZHUkJkMGZLUEpmZUFZdmxkaFQ5LzRoV0phaEVUVm05?=
 =?utf-8?B?dDdEMlVYR0RHT0FQUnM4eUgzaDYzRzVJcXhGWDJPYXd0YXdqQnFKU2UrYlQ3?=
 =?utf-8?B?MG8wWDZ6ZkpYMXZnUGpYN20vemhNQVhTOTVDR2Z1RkNhTHdGRThDNlV4R3Ry?=
 =?utf-8?B?QURQN0VaYzI2UEVpMld5REtqVFRmZ0Q5UDlZN0RUaW1DcXMwMytZajQwNEtW?=
 =?utf-8?B?UGpJaDhwd2M2Z01qa3hIUjZHWjNJQmUyN2tMbklEd1lTUDVobmJkNjZqKzFr?=
 =?utf-8?B?eC85YVB0dHVjNHNtNkJaVGNYeHR3VzE4S0NYZzZvQTNXcVRtanl1REhiYVJu?=
 =?utf-8?B?N05WSzhzdjJEUUdKc3F4S1V4UzdqY0pIWnNsNW5nODBsTjEyWU01TXM3K01D?=
 =?utf-8?B?K2NYeWlqeUI1ZUljT3d5STNscmNaU1dHUktma0taUFprTGY1am51bk9mOGJD?=
 =?utf-8?B?MjVhZmRpd3FodXdVNTNBY0NNaW44c1RlTVFydUpTNFBBNGNhMzBCYWlQRkpK?=
 =?utf-8?B?VGJiU0lnWWthdG9pYzE4WWplWE9ibzlJUW94QmtsdjJ1RFkyL0UyRGc2YWJv?=
 =?utf-8?B?OGdXQ1RUckNXQkdEN0lXL21wMTFuenk1SytldFNWRkNHVmxxYjUyVE91bXYw?=
 =?utf-8?B?SjJlYnFpU1g2Y2RmM3VORDI5djJ0QVY2T0haZUFrVFFrQTRnZGVMUyt1eFdX?=
 =?utf-8?B?RGgzTnB3TzIrMEsvdk4xelZvWklKZUdKZW1TejdWa29Ha0ZIM2k3MHg1ZHVq?=
 =?utf-8?B?eGgyMm9YaEdjakpQeTFySS9iM2pqRnRVQnVOQjVsTDdIVEhZbVMrZEpOOE1Q?=
 =?utf-8?B?elUzbkhiVy80MStsbzNNZCtGeU1TdnBjTDdqSUVSS0lkNWU4bk1ZYU1mVUtt?=
 =?utf-8?Q?pzJ4UjMPQYn3LO826yGL87dib?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb2e816-256c-4bdb-841b-08dab51ac035
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 17:19:32.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8QPk9mXjw5N4ONF0IoGDjr7B/pVElqmO0MkndRGLVnAJS7A3dzpr6s1CcskEfPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2749
X-Proofpoint-GUID: dXQrsOptYVtUBELMrAJ26DsXcXW8feCJ
X-Proofpoint-ORIG-GUID: dXQrsOptYVtUBELMrAJ26DsXcXW8feCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/22/22 10:26 PM, David Vernet wrote:
> On Fri, Oct 21, 2022 at 04:44:32PM -0700, Yonghong Song wrote:
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
> 
> Small nit: This isn't really done as a callback, it's just a normal
> function call, right?

Oh, yes, it is just a function call. Will make the change.

> 
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
>> to avoid potential run-time memory allocation failure.
>> Therefore, the new cgroup storage can provide all functionality w.r.t.
>> the old one. So in uapi bpf.h, the old BPF_MAP_TYPE_CGROUP_STORAGE is alias to
>> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED to indicate the old cgroup storage can
>> be deprecated since the new one can provide the same functionality.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> [...]
> 
>> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
>> new file mode 100644
>> index 000000000000..770c9c28215a
>> --- /dev/null
>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>> @@ -0,0 +1,268 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_local_storage.h>
>> +#include <uapi/linux/btf.h>
>> +#include <linux/btf_ids.h>
>> +
>> +DEFINE_BPF_STORAGE_CACHE(cgroup_cache);
>> +
>> +static DEFINE_PER_CPU(int, bpf_cgrp_storage_busy);
>> +
>> +static void bpf_cgrp_storage_lock(void)
>> +{
>> +	migrate_disable();
>> +	this_cpu_inc(bpf_cgrp_storage_busy);
>> +}
>> +
>> +static void bpf_cgrp_storage_unlock(void)
>> +{
>> +	this_cpu_dec(bpf_cgrp_storage_busy);
>> +	migrate_enable();
>> +}
>> +
>> +static bool bpf_cgrp_storage_trylock(void)
>> +{
>> +	migrate_disable();
>> +	if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) != 1)) {
>> +		this_cpu_dec(bpf_cgrp_storage_busy);
>> +		migrate_enable();
>> +		return false;
>> +	}
>> +	return true;
>> +}
>> +
>> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
>> +{
>> +	struct cgroup *cg = owner;
>> +
>> +	return &cg->bpf_cgrp_storage;
>> +}
>> +
>> +void bpf_cgrp_storage_free(struct cgroup *cgroup)
> 
> I was originally going to ask what you thought about also merging this
> logic into bpf_local_storage.h, but I think it's fine to just land this
> as is and refactor after.
> 
> I do think it would be a good cleanup to later refactor a lot of the
> local storage logic to be callback based (assuming we're ok with an
> extra indirect call), as much of what it's doing is almost the exact
> same thing in a very slightly different way. For example,
> bpf_pid_task_storage_lookup_elem() is looking up a pid by an fd,
> acquiring a reference, and then returning the struct
> bpf_local_storage_data * embedded in the task struct. If doing that in
> general sounds like a reasonable idea, I can take care of it as
> follow-on work after this lands.

Thanks!

> 
>> +{
>> +	struct bpf_local_storage *local_storage;
>> +	struct bpf_local_storage_elem *selem;
>> +	bool free_cgroup_storage = false;
>> +	struct hlist_node *n;
>> +	unsigned long flags;
>> +
>> +	rcu_read_lock();
>> +	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>> +	if (!local_storage) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +
>> +	/* Neither the bpf_prog nor the bpf_map's syscall
>> +	 * could be modifying the local_storage->list now.
>> +	 * Thus, no elem can be added to or deleted from the
>> +	 * local_storage->list by the bpf_prog or by the bpf_map's syscall.
>> +	 *
>> +	 * It is racing with __bpf_local_storage_map_free() alone
>> +	 * when unlinking elem from the local_storage->list and
>> +	 * the map's bucket->list.
>> +	 */
>> +	bpf_cgrp_storage_lock();
>> +	raw_spin_lock_irqsave(&local_storage->lock, flags);
>> +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>> +		bpf_selem_unlink_map(selem);
>> +		/* If local_storage list has only one element, the
>> +		 * bpf_selem_unlink_storage_nolock() will return true.
>> +		 * Otherwise, it will return false. The current loop iteration
>> +		 * intends to remove all local storage. So the last iteration
>> +		 * of the loop will set the free_cgroup_storage to true.
>> +		 */
>> +		free_cgroup_storage =
>> +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
>> +	}
>> +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>> +	bpf_cgrp_storage_unlock();
>> +	rcu_read_unlock();
>> +
>> +	if (free_cgroup_storage)
>> +		kfree_rcu(local_storage, rcu);
>> +}
>> +
>> +static struct bpf_local_storage_data *
>> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
>> +{
>> +	struct bpf_local_storage *cgroup_storage;
>> +	struct bpf_local_storage_map *smap;
>> +
>> +	cgroup_storage = rcu_dereference_check(cgroup->bpf_cgrp_storage,
>> +					       bpf_rcu_lock_held());
>> +	if (!cgroup_storage)
>> +		return NULL;
>> +
>> +	smap = (struct bpf_local_storage_map *)map;
>> +	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
>> +}
>> +
>> +static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +	struct cgroup *cgroup;
>> +	int fd;
>> +
>> +	fd = *(int *)key;
>> +	cgroup = cgroup_get_from_fd(fd);
>> +	if (IS_ERR(cgroup))
>> +		return ERR_CAST(cgroup);
>> +
>> +	bpf_cgrp_storage_lock();
>> +	sdata = cgroup_storage_lookup(cgroup, map, true);
>> +	bpf_cgrp_storage_unlock();
>> +	cgroup_put(cgroup);
>> +	return sdata ? sdata->data : NULL;
> 
> Do you think it's worth it to add a WARN_ON_ONCE(!rcu_read_lock_held());
> somewhere in this function?

We should be okay here.
bpf_map_lookup_elem() is not allowed for CGRP_STORAGE map
in bpf program.

         case BPF_MAP_TYPE_CGRP_STORAGE:
                 if (func_id != BPF_FUNC_cgrp_storage_get &&
                     func_id != BPF_FUNC_cgrp_storage_delete)
                         goto error;
                 break;


At syscall side, we have explicit rcu_read_lock/unlock()
in kernel/bpf/syscall.c to protect
	ptr = map->ops->map_lookup_elem(map, key);

So WARN_ON_ONCE(!rcu_read_lock_held()) will never hit.
We are fine here.

> 
> [...]
> 
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 764bdd5fd8d1..7e80e15fae4e 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -5227,6 +5227,10 @@ static void css_free_rwork_fn(struct work_struct *work)
>>   	struct cgroup_subsys *ss = css->ss;
>>   	struct cgroup *cgrp = css->cgroup;
>>   
>> +#ifdef CONFIG_CGROUP_BPF
> 
> I think this should be #ifdef CONFIG_BPF_SYSCALL?

Yes, this is my oversight. I forgot this place while changing the
structure definion site.

> 
>> +	bpf_cgrp_storage_free(cgrp);
>> +#endif
>> +
> 
> This looks pretty close to ready from my end, just a couple more
> small questions / comments.
> 
> Thanks,
> David

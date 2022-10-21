Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC944607D98
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 19:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJUReT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 13:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJUReR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 13:34:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EF72623E5
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 10:34:12 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29L9oFPg017944;
        Fri, 21 Oct 2022 10:33:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qv7a0Twku5zVBFAvZ3jonthpmBCdrYWuYDGVgW0EWrM=;
 b=QG4fI2Nu/lRztZl2cCn+hwM8Kv8LTBWl1xnFBEMU04gP9JZ1Toj+uPehWj55UTMJV+4w
 54eb/ytZdxirLOx4dxlzpZmtqdchVvYPOYEgnNSVtLv1I85bDgVLNUOVRGIVy/ERctG7
 vBpnoTjFcnnlFfSyY522CrocYx6Rkcz72rKo9gSt9uPfWDCuAKjtoFX4thAObh2XcwUB
 oKG4T4BXl1qJeoxIvdJLIc4eY4cbXkX6PDUk/HEqISFzfGHPzBSYc89vtdAzC/3NW01w
 XHWcbwIt5cBL7PejLkH5c1Nzy89+Zegq7I/xGumOE+aOMhb4C9SzNvkfPQzyWaZ6KNx/ Pg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kbs513uwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 10:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaClfAQ3vEBj9RcJycobANRat4TZhC22KK5hbFNE3hJpV96x+aKDe6SvE579JQt4w2gG9zJBHjKf5251tW1C2DYLNc8U5OHTU0iCQk1F235m35bIc8PcU/spKlzFtCfkEmJIeLOixcLNYUXOuBHjvUG+eWhbu6ezVIqCt84o9s59y4UJpzeXH32quj49Stc5TUm1vwO+jWDesVym0J/r7+/3tdoQZnP/CMcK5yR7/ke6O1jwF0Gqq0T2mmjSwU9K4nI2I0siAWMSgysyMTVQHRZfs4JhE8LKqfKG5auXTkpx8yhEj8JnjNk3CzaMcnBEiSUhuCDIdpxGPPg4E48OOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv7a0Twku5zVBFAvZ3jonthpmBCdrYWuYDGVgW0EWrM=;
 b=mDNMtJwefFTdBE03nxhnLx9PPUbW0W+Qf2vu2N0m0Me9izXfqqd/c7937Z6Q+e4alPBiiDVsM+k9P3nPgZk/+iVEl9qdvKrK6u9y6RiFADipIF7h88yVZOvXJn+tDAeSspIacotoXYp/3TOPROj6lr70AxO459Do4eHoDNd6MR6BTwh7eTANyeEvuzwAxIgyUW7sTykRjsFMM8xapc7BTfDjAIDcKvCFM8XGx76DwfqscHoDyvGP70KljTDAXMXd473yNSaL+sJNA7qM4UUf3AZy3wNmpOwkPiJJir34KhNLowvyaSq71wMwM/0JTA2zhgQdxnMdkbsoXwnCCW2yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2494.namprd15.prod.outlook.com (2603:10b6:805:28::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 17:33:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.036; Fri, 21 Oct 2022
 17:33:49 +0000
Message-ID: <a9f1be39-4f8e-3f33-f3e0-368f3beec1a8@meta.com>
Date:   Fri, 21 Oct 2022 10:33:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Content-Language: en-US
To:     David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221306.3554250-1-yhs@fb.com>
 <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN6PR15MB2494:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c8d8f0-6051-4114-336e-08dab38a6a30
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSY6YLrAOa3YQX42N1OocJgnuZiQcjX+rMy+E6AbokRyN88ecycRy2fPzXzRLU7xOndtCu7iB7J/98gCKvODdgaPQxHdUcNxbBb7lvJLxpbdsQP+v2Ev1afH73XU4RqD2CdUfFihVGwTxD2Y3mP4FuJgvWDq/repClxU3m/hjd0o58SwyKLfiC1VtrHksjI8/22C2pf6LH0Kq80riuuNMe50G/Oa7OYpUhPFXwVsuoz9vprZnp/xUx/7p+iq+3RoZwOioEGehgUCUn14Te1C7jbcNMg5M5QH1Kf0lxcjz8Cc3dMhJ5QpTrpsKFNsXO/ERH0Cy6BeUrMHzWd91eAcSzw8uo1nH3//o67r83xhapebY7lORsKGfjQvZzhcnAG8ohchBQqoyECwm6Z5GpvFQntUJU3N0oVYVSHWExNvfv0G8SP69sX2rkU+wksaJeTAIX/ZOOyP76ZvBi6Cp0aYRunm32tUmFmA0dBWTHq7USKtSKIegKs1QnDvjlA0OLU/Wo/wm13XPATI6k+iTxq9z6k5rbwlmHkmzjIIksrCcuJGPLYTjD2l0XC3dB0VcapwDn+K6wyDSdGE2UfgWvXZ8Ow2T+tRWjVYL+/fJ+TxxFngURpIReXdTc1xg3BeudZ1MC0weHu++LQzDuAJX6Xui2xxVeiEoCjkoCI3z0LUzHe6MeS0NJJ3TzuKpKXZro4SnnI+O6smvpcvZSvG6ZIoguFS5azG01cwXPz1vDNvNVLURpuD/rlmY6u+RJ8VSR/KsmqcS8huIGgOReNerYB5TDVbO08fAo3IwC5+dykjZe8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(8936002)(53546011)(6512007)(36756003)(2906002)(6666004)(6506007)(66946007)(8676002)(41300700001)(4326008)(66476007)(5660300002)(31696002)(86362001)(2616005)(30864003)(186003)(83380400001)(38100700002)(478600001)(31686004)(66556008)(54906003)(316002)(110136005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZSTDZsTjVwWnZody95NTF4VnYwR3JKQ2VBL0dGN1pZbTI5eUovb3R0M1lE?=
 =?utf-8?B?ZysxajNCc0lZSUNkYlQ4K2tIQ3ZGaDBybnZDRTNBdXBuZGFZRDV3Rk5xSmp6?=
 =?utf-8?B?Q25MbnptUHNoaFRIZE1WL29JZjdZbkRVdFZKaXo2WXA2YjFUUWJUZktvcDRm?=
 =?utf-8?B?R21hZWN5SFBkVlVqUVFMaXY1OVlRRVlxU0EzdUllcDlYVUVHc04ybnRzUTB1?=
 =?utf-8?B?L1BvVTZkNXZPMGZhSE9SblVJQU90RWQ0QWJTc3I2Q3Z6Rksra1ZPRkphZm1N?=
 =?utf-8?B?YUVyWkZadExnKzdLaVBKd3IxVVgybmVnUlRhSE9GdW1kZEdEWDV4clZkNktB?=
 =?utf-8?B?YTYxWjlWU1dibHlaaVcvc21aRjI1SGw5TVo2c1J2SGtJb0pRSDZ1eDg2SFVF?=
 =?utf-8?B?WStjUkJ6aFVUVWxjZWRKS2d2KzFhVlpJcVF1QnNDcDd0ZnI3OTZjUXBEWW54?=
 =?utf-8?B?TTkxZk5tMyt6YkV0Q3hZTlBPUzZrNVV3K2FFYmc5VExoMGhCVEpWK2hTRWVK?=
 =?utf-8?B?S2x3YzhXdlp6L3FHODJXVE05eGllUDhOUXJYT0Rla1FCckRISDl1clJnYS9H?=
 =?utf-8?B?V1lVOWQxNTRxcUZRTFZ6M0VNaHBaeTEzTjR4ZjN0SzZCWDNINXgyUmJmMnRp?=
 =?utf-8?B?Q0lUbENBSW9BVWY4aFlBYUxFUUVPYXd5cTJqOHN4Wk45dEd6a2RvanJ4SGZ4?=
 =?utf-8?B?RURETys4YWFqeXp3OWRxV2lQcmVhclJybTFkUnhvbTN1NURFQzN0VUJaTDJG?=
 =?utf-8?B?OWFxL0lvcDR4L2FYNnJPUFNxSlNoQlUwNDE3dEEvdWVZSVBxaks0eTYyaitY?=
 =?utf-8?B?aDZEeUJLYzR6V0RNdVZtNkl6M3dmQnRMSHpSQUNEUTUrUEdyTTh5aHN2enlI?=
 =?utf-8?B?dkV2blhmdjQwSUFDNTQyM0lkcmFlTW5tRy9UZlU1MmpUMXZ0TkxTV0tkY2oz?=
 =?utf-8?B?azJhQnkzWTBjUHJwT3JUSzZaRUF2MFk1TjkrZnVFY3FFVlNDOFhJZTIzUERj?=
 =?utf-8?B?WWpCL2VST1lHWGRBOEVrWFYyZ2RIbWtpQ0Z4N2dvNEloUURhOGlwQVRUOVlJ?=
 =?utf-8?B?aDZuUktiQjRrMkhWQWNYMmV2QzhXc2tUQ0E3ZEtDeXR2NEgvQUxFeitJcU5v?=
 =?utf-8?B?b3RLSU10SlFwYUljVU1kVW5EaXBVMUUwa2U0VnVFTEZ0NExWSFBjclAvY082?=
 =?utf-8?B?emJ2YXJ4V0ZTTnFoZDg0Y3BNV1R2cUhvRWxWbHIxVEZKZlJaN25EVzhSUkJj?=
 =?utf-8?B?RFVSVDNSZWh5bzY0VkZNTnBBK1dWNFRpSzVaQnByMFZMRStGa3pvb251dWQy?=
 =?utf-8?B?QWk0UFV0NnNiMlBsOEJhb2ZUekFpZG5LSnByczdDaFdTenRjdkRxb0JqNlV6?=
 =?utf-8?B?VnFtUXJWL1c4ZCtFb1Z1a2NUeFFRUldobStVSE1mVzJZZ1BRdGpDSHJPdWtY?=
 =?utf-8?B?N1pMTTdMdFhHRkluU09BSjluRDR4TysvbXlWek5VK2paYWxRS0M5VFVsV0dC?=
 =?utf-8?B?enhXTXRlQ0liRWR6V1NFZ25GbHlDMyt3VEdidUNXQ1dyQ2l5SG1vak5GMUQ4?=
 =?utf-8?B?SkNQUkVSQXN1VmZMeW96cGxZZ21ualJJY2VrK3JGUndKUGFpVGhiWUJCQklm?=
 =?utf-8?B?WWdmY3NXdHY4cW9ySWFScHMxelZTdnUrUFFLNjZsZEJRTk10dEJDQnpFZmtP?=
 =?utf-8?B?VnJ3YTR3RlZRbWx1V3U5K1p5RXFrSGNyTzN3aUtCSmdtQ0tvUGdDemZ6bmtE?=
 =?utf-8?B?UGtGSG1ROUFYZGt2eUNUbWlOTEdHdkFHejdKRGRpSGM1UUZuZStRb0x1OVlH?=
 =?utf-8?B?eFlHZHl6TVlkOWE4NGxNb0NNTjFTaXJGaXhldU5IbXlsTldPNklXanAvY25Z?=
 =?utf-8?B?K3B5N2dCT2Z2Mk5xM0I0KzI3VFZ5UzhoTUkyaldSbnFOeFlsMjRXMnZKRmR2?=
 =?utf-8?B?V3VUSHZEdVNiYkc0WENUVzJ1aUFOeS9ZOEJlN2tsR0lmWi9oNGxPMGFTeHV6?=
 =?utf-8?B?a1pTTmFvbTU0U2lPVEJlc1RrbE9ZRVUxbHFDVkE4bEdFVTgxaVRkZFM1d2dC?=
 =?utf-8?B?cWIwMmlFNXdBbmtIaWNMQVJ6bzlWbitQNHpqQnVvdzlBeXp4MThBQTBhSXJU?=
 =?utf-8?Q?lMwrPV539AlMfjz+k+Z424sog?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c8d8f0-6051-4114-336e-08dab38a6a30
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 17:33:49.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sbRoV+53VbDSLUSpzUr6k89mmoDGZwosW4pxp9M0LFg2N7qzWQgUCUupFZVtzqI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2494
X-Proofpoint-GUID: ReGGW8ft2BPSXXWksnqhIN5ee2Veyxum
X-Proofpoint-ORIG-GUID: ReGGW8ft2BPSXXWksnqhIN5ee2Veyxum
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



On 10/20/22 10:22 PM, David Vernet wrote:
> On Thu, Oct 20, 2022 at 03:13:06PM -0700, Yonghong Song wrote:
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
> 
> s/allocaiton/allocation

ack.

> 
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
>>   	/* Used to store internal freezer state */
>>   	struct cgroup_freezer_state freezer;
>>   
>> +#ifdef CONFIG_CGROUP_BPF
>> +	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>> +#endif
>> +
>>   	/* All ancestors including self */
>>   	struct cgroup *ancestors[];
>>   };
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 17f61338f8f8..2d7f79bf3500 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -922,7 +922,14 @@ enum bpf_map_type {
>>   	BPF_MAP_TYPE_CPUMAP,
>>   	BPF_MAP_TYPE_XSKMAP,
>>   	BPF_MAP_TYPE_SOCKHASH,
>> -	BPF_MAP_TYPE_CGROUP_STORAGE,
>> +	BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>> +	/* BPF_MAP_TYPE_CGROUP_STORAGE is available to bpf programs attaching
>> +	 * to a cgroup. The newer BPF_MAP_TYPE_CGRP_STORAGE is available to
>> +	 * both cgroup-attached and other progs and supports all functionality
>> +	 * provided by BPF_MAP_TYPE_CGROUP_STORAGE. So mark
>> +	 * BPF_MAP_TYPE_CGROUP_STORAGE deprecated.
>> +	 */
>> +	BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>>   	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>>   	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>>   	BPF_MAP_TYPE_QUEUE,
>> @@ -935,6 +942,7 @@ enum bpf_map_type {
>>   	BPF_MAP_TYPE_TASK_STORAGE,
>>   	BPF_MAP_TYPE_BLOOM_FILTER,
>>   	BPF_MAP_TYPE_USER_RINGBUF,
>> +	BPF_MAP_TYPE_CGRP_STORAGE,
>>   };
>>   
>>   /* Note that tracing related programs such as
>> @@ -5435,6 +5443,42 @@ union bpf_attr {
>>    *		**-E2BIG** if user-space has tried to publish a sample which is
>>    *		larger than the size of the ring buffer, or which cannot fit
>>    *		within a struct bpf_dynptr.
>> + *
>> + * void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
>> + *	Description
>> + *		Get a bpf_local_storage from the *cgroup*.
>> + *
>> + *		Logically, it could be thought of as getting the value from
>> + *		a *map* with *cgroup* as the **key**.  From this
>> + *		perspective,  the usage is not much different from
>> + *		**bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
>> + *		helper enforces the key must be a cgroup struct and the map must also
>> + *		be a **BPF_MAP_TYPE_CGRP_STORAGE**.
>> + *
>> + *		Underneath, the value is stored locally at *cgroup* instead of
>> + *		the *map*.  The *map* is used as the bpf-local-storage
>> + *		"type". The bpf-local-storage "type" (i.e. the *map*) is
>> + *		searched against all bpf_local_storage residing at *cgroup*.
> 
> IMO this paragraph is a bit hard to parse. Please correct me if I'm
> wrong, but I think what it's trying to convey is that when an instance
> of cgroup bpf-local-storage is accessed by a program in e.g.
> bpf_cgrp_storage_get(), all of the cgroup bpf_local_storage entries are
> iterated over in the struct cgroup object until this program's local
> storage instance is found. Is that right? If so, perhaps something like
> this would be more clear:

yes. your above interpretation is correct.

> 
> In reality, the local-storage value is embedded directly inside of the
> *cgroup* object itself, rather than being located in the
> **BPF_MAP_TYPE_CGRP_STORAGE** map. When the local-storage value is
> queried for some *map* on a *cgroup* object, the kernel will perform an
> O(n) iteration over all of the live local-storage values for that
> *cgroup* object until the local-storage value for the *map* is found.

Sounds okay. I can change the explanation like the above.

> 
> What do you think?
> 
>> + *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
>> + *		used such that a new bpf_local_storage will be
>> + *		created if one does not exist.  *value* can be used
>> + *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
>> + *		the initial value of a bpf_local_storage.  If *value* is
>> + *		**NULL**, the new bpf_local_storage will be zero initialized.
>> + *	Return
>> + *		A bpf_local_storage pointer is returned on success.
>> + *
>> + *		**NULL** if not found or there was an error in adding
>> + *		a new bpf_local_storage.
>> + *
>> + * long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgroup *cgroup)
>> + *	Description
>> + *		Delete a bpf_local_storage from a *cgroup*.
>> + *	Return
>> + *		0 on success.
>> + *
>> + *		**-ENOENT** if the bpf_local_storage cannot be found.
>>    */
>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>>   	FN(unspec, 0, ##ctx)				\
>> @@ -5647,6 +5691,8 @@ union bpf_attr {
>>   	FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)	\
>>   	FN(ktime_get_tai_ns, 208, ##ctx)		\
>>   	FN(user_ringbuf_drain, 209, ##ctx)		\
>> +	FN(cgrp_storage_get, 210, ##ctx)		\
>> +	FN(cgrp_storage_delete, 211, ##ctx)		\
>>   	/* */
>>   
>>   /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index 341c94f208f4..3a12e6b400a2 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -25,7 +25,7 @@ ifeq ($(CONFIG_PERF_EVENTS),y)
>>   obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
>>   endif
>>   ifeq ($(CONFIG_CGROUPS),y)
> 
> I assume that you double checked that it's valid to compile the helper
> with CONFIG_CGROUPS && !CONFIG_CGROUP_BPF, but I must admit that even if
> that's the case, I'm not following why we would want the map to be
> compiled with a different kconfig option than the helper that provides
> access to it. If theres's a precedent for doing this then I suppose it's
> fine, but it does seem wrong and/or at least wasteful to compile these
> helpers in if CONFIG_CGROUPS is defined but CONFIG_CGROUP_BPF is not.

The following is my understanding.
CONFIG_CGROUP_BPF guards kernel/bpf/cgroup.c which contains 
implementation mostly for cgroup-attached program types, helpers, etc.

A lot of other cgroup-related implementation like cgroup_iter, some
cgroup related helper (not related to cgroup-attached program types), 
etc. are guarded with CONFIG_CGROUPS and CONFIG_BPF_SYSCALL.

Note that it is totally possible CONFIG_CGROUP_BPF is 'n' while
CONFIG_CGROUPS and CONFIG_BPF_SYSCALL are 'y'.

So for cgroup local storage implemented in this patch set,
using CONFIG_CGROUPS and CONFIG_BPF_SYSCALL seems okay.

> 
>> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
>> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgrp_storage.o
>>   endif
>>   obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>>   ifeq ($(CONFIG_INET),y)
>> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
>> new file mode 100644
>> index 000000000000..bcc5f0fc20be
>> --- /dev/null
>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>> @@ -0,0 +1,276 @@
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
>> +	/* Neither the bpf_prog nor the bpf-map's syscall
> 
> Very minor nit, but I think using a hyphen in bpf-map like this is
> incorrect as it's not a compound adjective. Applies elsewhere as well. I
> don't believe "added-to" or "deleted-from" require hyphens either.

ack.

> 
>> +	 * could be modifying the local_storage->list now.
>> +	 * Thus, no elem can be added-to or deleted-from the
>> +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
>> +	 *
>> +	 * It is racing with bpf_local_storage_map_free() alone
>> +	 * when unlinking elem from the local_storage->list and
>> +	 * the map's bucket->list.
>> +	 */
>> +	bpf_cgrp_storage_lock();
>> +	raw_spin_lock_irqsave(&local_storage->lock, flags);
>> +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>> +		bpf_selem_unlink_map(selem);
>> +		free_cgroup_storage =
>> +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
> 
> This still requires a comment explaining why it's OK to overwrite
> free_cgroup_storage with a previous value from calling
> bpf_selem_unlink_storage_nolock(). Even if that is safe, this looks like
> a pretty weird programming pattern, and IMO doing this feels more
> intentional and future-proof:
> 
> if (bpf_selem_unlink_storage_nolock(local_storage, selem, false, false))
> 	free_cgroup_storage = true;

We have a comment a few lines below.
   /* free_cgroup_storage should always be true as long as
    * local_storage->list was non-empty.
    */
   if (free_cgroup_storage)
	kfree_rcu(local_storage, rcu);

I will add more explanation in the above code like

	bpf_selem_unlink_map(selem);
	/* If local_storage list only have one element, the
	 * bpf_selem_unlink_storage_nolock() will return true.
	 * Otherwise, it will return false. The current loop iteration
	 * intends to remove all local storage. So the last iteration
	 * of the loop will set the free_cgroup_storage to true.
	 */
	free_cgroup_storage =
		bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);

> 
>> +	}
>> +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>> +	bpf_cgrp_storage_unlock();
>> +	rcu_read_unlock();
>> +
>> +	/* free_cgroup_storage should always be true as long as
>> +	 * local_storage->list was non-empty.
>> +	 */
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
>> +}
> 
> Stanislav pointed out in the v1 revision that there's a lot of very
> similar logic in task storage, and I think you'd mentioned that you were
> going to think about generalizing some of that. Have you had a chance to
> consider?

It is hard to have a common function for 
lookup_elem/update_elem/delete_elem(). They are quite different as each 
heavily involves
task/cgroup-specific functions.

but map_alloc and map_free could have common helpers.

> 
>> +static int bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
>> +					  void *value, u64 map_flags)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +	struct cgroup *cgroup;
>> +	int fd;
>> +
>> +	fd = *(int *)key;
>> +	cgroup = cgroup_get_from_fd(fd);
>> +	if (IS_ERR(cgroup))
>> +		return PTR_ERR(cgroup);
>> +
>> +	bpf_cgrp_storage_lock();
>> +	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
>> +					 value, map_flags, GFP_ATOMIC);
>> +	bpf_cgrp_storage_unlock();
>> +	cgroup_put(cgroup);
>> +	return PTR_ERR_OR_ZERO(sdata);
>> +}
>> +
>> +static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +
>> +	sdata = cgroup_storage_lookup(cgroup, map, false);
>> +	if (!sdata)
>> +		return -ENOENT;
>> +
>> +	bpf_selem_unlink(SELEM(sdata), true);
>> +	return 0;
>> +}
>> +
>> +static int bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
>> +{
>> +	struct cgroup *cgroup;
>> +	int err, fd;
>> +
>> +	fd = *(int *)key;
>> +	cgroup = cgroup_get_from_fd(fd);
>> +	if (IS_ERR(cgroup))
>> +		return PTR_ERR(cgroup);
>> +
>> +	bpf_cgrp_storage_lock();
>> +	err = cgroup_storage_delete(cgroup, map);
>> +	bpf_cgrp_storage_unlock();
>> +	cgroup_put(cgroup);
>> +	return err;
>> +}
>> +
>> +static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>> +{
>> +	struct bpf_local_storage_map *smap;
>> +
>> +	smap = bpf_local_storage_map_alloc(attr);
>> +	if (IS_ERR(smap))
>> +		return ERR_CAST(smap);
>> +
>> +	smap->cache_idx = bpf_local_storage_cache_idx_get(&cgroup_cache);
>> +	return &smap->map;
>> +}
>> +
>> +static void cgroup_storage_map_free(struct bpf_map *map)
>> +{
>> +	struct bpf_local_storage_map *smap;
>> +
>> +	smap = (struct bpf_local_storage_map *)map;
>> +	bpf_local_storage_cache_idx_free(&cgroup_cache, smap->cache_idx);
>> +	bpf_local_storage_map_free(smap, NULL);
>> +}
>> +
[...]

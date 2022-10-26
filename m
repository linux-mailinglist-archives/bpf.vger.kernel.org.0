Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39B60DA30
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 06:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiJZEMR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 00:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiJZEMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 00:12:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D43B979A
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:12:14 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PMGmoZ027634;
        Tue, 25 Oct 2022 21:11:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=jzqDKu2P2OlkfYTfDBOgf1TJ4UDU4o3OY+QhI44fdwk=;
 b=c1RDgS0TcwxruU1gDTG45NmwvXZEfO9HrtWZRBhi3Om/pMTvG63I6UlJNHuIBjgW29Qb
 gS/CNyd224A61bqP62c6idZ035YovLuCdeA5RG7ZwmqzI44AKCTR1Ha+j25fNwENcvwe
 Jn11+Vcbxz0uCCqIDuZNIuMxtWirjx7kRCx7+/NNJBCwdg6rejEiDtPs1M8hBVmCtiDw
 h8MeFsr23JYywwVN4uMUcG+Sewq3RTZCzJUjAK/z7dUFItsK33gIvzCOnBwcC87WTrQQ
 zLDNQ12WyuLENE3Hgz926OHRYaY82TQW7i065XnRpQtB80AG6jltovZa0efdsjUTDCwt tA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ke5sn6735-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 21:11:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oacsAlCM+BUQH1CXVo82/urshs2w/6oUw1rhLblERWgeWnDVPFd8mNrFFfQMhKwSG+ZDtOAvlIl2xvhk1rKMAc2e+LSGzvi/fngStMKG4KjhNXy+UopYaQ+y7AteRv86+vI1JfLMKjrXv7vvABvwmOijyxYw8cGMNZ9ot/jAlFXuzWW6Z5+qU+X+E61ifg8Rf2B2Bb8MfW5BMSg5Xfuz0GZg9Mzzga84z/DxUY4s3Qx1+B18or4tsgByacCuITX1Rhce23sU9EIi/AH+uCdDy+lRN9MkFIh3Snq8p4smtMeK0IsWJdNF3Jf02rNTnSAorYGQ5OdZkJlt578iw0aGNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzqDKu2P2OlkfYTfDBOgf1TJ4UDU4o3OY+QhI44fdwk=;
 b=aATlUggTxVdEwHSYrm1l9x95smbWniMch+Eo3+REiDH2WcyquhotaK5MIVUuPrQHx8kWaEZkYGnSmiwvPztcGSNw/B/Y/TsPy5DAPvDBRVpVrOJBiglYY3V4neSwtYNRILoYP8aTv8PuoZAytYTGOHQ96R45TgEhxIr+XwrdkCV6NIFa0i0n/VhunSXg3Qu8CirV5mxEgzJz7roZqCqbMaoHh3BQk3v/VzQNzz80xlBET+lMsuxcDXuRU5aIGsP2IPFn+YmOuqwpuE5Wikx2/ZS1ud5OjMBXxF70Z0dj7ZWE5EXXj1cG4PsGCPSLky2LsRP1R12a6gaNTC5H4shqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3304.namprd15.prod.outlook.com (2603:10b6:a03:10a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 26 Oct
 2022 04:11:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 04:11:52 +0000
Message-ID: <c2f1a054-dd0e-1150-d1c1-d3a6b10c9c40@meta.com>
Date:   Tue, 25 Oct 2022 21:11:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
References: <20221025215352.4184578-1-yhs@fb.com>
 <20221025215408.4185261-1-yhs@fb.com>
 <CAJD7tkZCrmnof7Lq3YhFDAfdKXodhK=6_8kD1Utt-xPX_jJ7TQ@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAJD7tkZCrmnof7Lq3YhFDAfdKXodhK=6_8kD1Utt-xPX_jJ7TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:207:3d::48) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB3304:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2a9b31-2a22-4df2-fb2a-08dab708364d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ffI3hAktCt6YsH9saSq94cHtYWadJXB1xp9iaVyohfXhRjXlZXf7WCs1GTC8xHUFoIUaCpIbvG5dSqDXWm1PRJsZm13r7aYcocbm0YQ6v7AV5vhp/4qqK8rTsf5T9HRIjz8BiISeR5lyWA6DCLTrjgKHskd0Uf5HjLtowDh8UmzY54+Ihe5AZaB0gcOld9V6w9+fg6pG/D5OKBvvxtwCFpX5xKTe4JG9lp3Wc0PZ+C13KB60S/ASc2NZhev05/HL2SeIpN2GBTqZ4QeRvL0C5MLIDs8k8Bdno8TDq+WCdI8BN8CNN/9QeIgK/y/C8zi/PfpEZg2jcMLhVaASmGCWSZc7pPNmRmV5gvb3mqDSji26g3Liz2d8OzLKzciEZrEbTnoNCOK93iBm5VUg5bFP3XNpQBdQIAiH0HCm6UFrYKFig43k4aiVsXpugEKsev2gNg+XuJoPqtJPVbPDiH2knwp2FuPvsXgq6kye9U++834QXjt1u3AeBLOsOeetTVHrhUpjexKRogd650K6YPJFLBXE3D5yTAari1tkA/G/7tD4qFcYC5HbkfQ3nt6bB/c6G87CydovhODY1bhXZ8OklNOR63Pcu8WAV2uGKHx8X9ZTzI4h5Y5bvQqmKPmwuV+85A8k3tteJrwbi5tBp6USQbRLxbNQIozvYMOVw4Ot6+GxC7i0UH7mgQeRwULWtikfzr1LuWV3b9nFlnVg5dQvl/6cwNDg9Oe4GjUw9Ok+N08EsoxmAMdtsuFyRqARbGYBaZsDIlmuEpBqz0DDDFRREpWr8Xz4hd/9iyaLhiJ9d5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(30864003)(31686004)(6486002)(41300700001)(5660300002)(8936002)(38100700002)(66476007)(66946007)(31696002)(2906002)(6506007)(53546011)(8676002)(66556008)(4326008)(83380400001)(186003)(478600001)(2616005)(86362001)(6666004)(54906003)(6512007)(316002)(36756003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTFLMGlSby9xMjJDNVBoa1YyOC9ZaGlzcmZVbDBNWmJueVI1aS9CYVdlRWo2?=
 =?utf-8?B?SUZiUXowVjBhL1BGbWdmVUR1N1VkeFZwOUN5citQTFRaK3V3QUdrMkR5bmVL?=
 =?utf-8?B?MTY1dVVvWWVVWXZndDFUeHpVTllqak9oenNQalhCVWlCWVNWTGt4dmdNL1Mr?=
 =?utf-8?B?alNvMmZsMW1oaW5qNHVjcUJ3Rk12dEUrLzVNMU14U0hUM3JLYkhuREt4TDd2?=
 =?utf-8?B?R3RwVVlYZm05bUcxK09ZNGlTeVQxVFdac2FzRmVITWwvTjkrMzRicHpmMVph?=
 =?utf-8?B?VFI0MFAzeWk2dU15NVVyLzRlZmtaY3ppVm9uc1RsK09UZ2ZvbHNNRzZDRm5H?=
 =?utf-8?B?WFBDZ3ROREZuZFdHRjZMdW1YNzlEeEo0Y2dnQXYvTmpsbytqYW44SURFcWkr?=
 =?utf-8?B?YjBmRTFCWHZBZE1KZzJsUGVVSWs0NmI5aEUxaTAwbFVqR3VTQ1FZMm5lRnM0?=
 =?utf-8?B?dy9ZNlFxdVVwRWo1SlRrUWdNTVdxdTlwWURrQVpiaVJMV3NqandaODhmcnZi?=
 =?utf-8?B?bTQvLzJNY1VyT2dDRnFDaXEwK2VYTzRWeUhWTENQdG1aeTJuNENSbGk0OG9I?=
 =?utf-8?B?MHhIMngwWmlJd3VKcVFCRzQ1RE9iWEtmUUx5NUkycGlBWE9BcDJDY2VocUhT?=
 =?utf-8?B?dlNYNFdDdWlwdWY4OWJoYlk5clJUdjIwNXQ0dGtOdk5wb0k3WmRwSkIyNVYr?=
 =?utf-8?B?eHkrbXVvUmRGVjVsYTh3TWd0V2JKU2swRHpYUW1mRkE5cDVBNy9JZ0ZwVHE0?=
 =?utf-8?B?cE1XbjhuNTVZdTljM2x4WGRXYWdFT0RXaU96YUlIZDZPVXQ1UTc4bmZqa0Fj?=
 =?utf-8?B?WTAreXJaWDFSOTdYRUI0SDUrQWFXZThobTFEZEcvV3ZvTXErdlhiTVhMa0N0?=
 =?utf-8?B?OW5CVzl5Zno3NktGS1NTL2llUlhBczRsbkt1bG1FZi9UQUlJQUlld3cvOUtS?=
 =?utf-8?B?M2VMN29JZy9jTjNVaVlJR0I2QlNKMDBYMyszajJDb09TaWZhVVFXenR2SUMw?=
 =?utf-8?B?Vm1nNlhXZ2h1RUs5Z252ZktSZ2VNS2lwM29IU2pEZitDaTUraUpUNHFqSEM1?=
 =?utf-8?B?SFBvTFlqYnI3bTVMK3locDZPWTdtVURFS3hDN3F5RFRidlJhZHJ0NCt6WnZP?=
 =?utf-8?B?ME10VG82U2ZDUThKM0JBMHByRGczZkloWUFYQWxnaE5GaEpvMkxROEE5Ym1u?=
 =?utf-8?B?QWVEdzJzZVJlSlA3S0YwV3A5MFN0dElDUlROUFI4MnIrNmFDRDNmTzlsc3pJ?=
 =?utf-8?B?QmpkZDhOS2RrK0w3UjhleVUvbGV1amxSU3JEbDZ1N1hqcld4MjNybjdNQk8v?=
 =?utf-8?B?WXpMdWJ6MjdpOC9vY2VCdE9hZFIyQnhHQkdtZ3dBVXdxemNFSS9jMjkzdWRT?=
 =?utf-8?B?eHdCSFkySWpnSVNqRWFKL2NBZUJzblBQUmZnN3RQZ1VyV2J0anlsbGVlck9s?=
 =?utf-8?B?TytUV0IzTG8ybzRVRkZudnppRUM5U3ZiSkt2Sy9FWjN4dEJpQU53T2hZcTRP?=
 =?utf-8?B?MGJMQ1JMV0c1UWhOYmIyZkt3L3B3UE53MXJJS3FnVGNVc1ZRbkVqeWRRYW8w?=
 =?utf-8?B?bGRWd3lWRENHeFJDdGdNQ1ZDa2ZIc0RBbzNRellySXd0U1JzeTBCV282Wnd5?=
 =?utf-8?B?aW04andrRXJwWFpNcGJSRWZuQUMxU0IyekF0Y05yT0M3WkpzUFhZanZVc2tL?=
 =?utf-8?B?dzNXQnJUVjBkanRLWmwrOGc0aWdBWWVFSzhMNEtSNGJEN0F4bm54d3NKZU1x?=
 =?utf-8?B?c08zUE1sYkd3T0JsR3RQQW5jYWpKVDN5MEt1elR6WURwV1dpRzNjOXBBNXpS?=
 =?utf-8?B?b3oxenc2ZkE5ZkZ0WkpsYlFrOTZIU0YwRlJEaUtBTThYaHY5TE5PZTg2SnN2?=
 =?utf-8?B?dENlTVhqYVJUanBDM3Q4amFzeW5tM0pDNk81SE1nZnNuVkdWYVN3RHR1NjdZ?=
 =?utf-8?B?UmY3MEVSOWVhVWp1NmU0ZitPa04wVU9Mdlp5MFhUUG1MclFLQk1WZTVlZjFu?=
 =?utf-8?B?YzJadVdxWWRhMW1USldobDFKcGlZUzBMa0k0UUx2dldCNWF2S1N3Zm9MeWJj?=
 =?utf-8?B?QTdMUnp0eEorL0F0VjlMcFRtejVxdUVQL29yNm9makwyeENkNGtGQkJJRFJM?=
 =?utf-8?B?R3pGc1h5T1ZhdDUraTFtbXp0YXJrOWJHU3BHU2VLVVpOZllXdjBRT0lxeG84?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2a9b31-2a22-4df2-fb2a-08dab708364d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 04:11:52.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph5zBtGiBXiMdvxYGy8AR04ivlxkKaSC+0fxHtVfb95VdN7Ovt1RS76bnS19apit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3304
X-Proofpoint-ORIG-GUID: b3z1NWC1nfGSe1dPK0CqrWoC0Esi3Yuy
X-Proofpoint-GUID: b3z1NWC1nfGSe1dPK0CqrWoC0Esi3Yuy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_01,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/25/22 3:29 PM, Yosry Ahmed wrote:
> On Tue, Oct 25, 2022 at 2:54 PM Yonghong Song <yhs@fb.com> wrote:
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
>> with a call to bpf_cgrp_storage_free() when cgroup itself
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
>> Acked-by: David Vernet <void@manifault.com>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h            |   7 +
>>   include/linux/bpf_types.h      |   1 +
>>   include/linux/cgroup-defs.h    |   4 +
>>   include/uapi/linux/bpf.h       |  50 ++++++-
>>   kernel/bpf/Makefile            |   2 +-
>>   kernel/bpf/bpf_cgrp_storage.c  | 247 +++++++++++++++++++++++++++++++++
>>   kernel/bpf/helpers.c           |   6 +
>>   kernel/bpf/syscall.c           |   3 +-
>>   kernel/bpf/verifier.c          |  13 +-
>>   kernel/cgroup/cgroup.c         |   1 +
>>   kernel/trace/bpf_trace.c       |   4 +
>>   scripts/bpf_doc.py             |   2 +
>>   tools/include/uapi/linux/bpf.h |  50 ++++++-
>>   13 files changed, 385 insertions(+), 5 deletions(-)
>>   create mode 100644 kernel/bpf/bpf_cgrp_storage.c
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 9e7d46d16032..0fa3b4f6e777 100644
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
>> @@ -2299,6 +2300,10 @@ static inline bool has_current_bpf_ctx(void)
>>   static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
>>   {
>>   }
>> +
>> +static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
>> +{
>> +}
>>   #endif /* CONFIG_BPF_SYSCALL */
>>
>>   void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
>> @@ -2537,6 +2542,8 @@ extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>>   extern const struct bpf_func_proto bpf_set_retval_proto;
>>   extern const struct bpf_func_proto bpf_get_retval_proto;
>>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>> +extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>> +extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
>>
>>   const struct bpf_func_proto *tracing_prog_func_proto(
>>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>> index 2c6a4f2562a7..d4ee3ccd3753 100644
>> --- a/include/linux/bpf_types.h
>> +++ b/include/linux/bpf_types.h
>> @@ -86,6 +86,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_PROG_ARRAY, prog_array_map_ops)
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, perf_event_array_map_ops)
>>   #ifdef CONFIG_CGROUPS
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
>> +BPF_MAP_TYPE(BPF_MAP_TYPE_CGRP_STORAGE, cgrp_storage_map_ops)
>>   #endif
>>   #ifdef CONFIG_CGROUP_BPF
>>   BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index 8f481d1b159a..c466fdc3a32a 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -504,6 +504,10 @@ struct cgroup {
>>          /* Used to store internal freezer state */
>>          struct cgroup_freezer_state freezer;
>>
>> +#ifdef CONFIG_BPF_SYSCALL
>> +       struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>> +#endif
>> +
>>          /* All ancestors including self */
>>          struct cgroup *ancestors[];
>>   };
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 17f61338f8f8..94659f6b3395 100644
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
>>   /* Note that tracing related programs such as
>> @@ -5435,6 +5443,44 @@ union bpf_attr {
>>    *             **-E2BIG** if user-space has tried to publish a sample which is
>>    *             larger than the size of the ring buffer, or which cannot fit
>>    *             within a struct bpf_dynptr.
>> + *
>> + * void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
>> + *     Description
>> + *             Get a bpf_local_storage from the *cgroup*.
>> + *
>> + *             Logically, it could be thought of as getting the value from
>> + *             a *map* with *cgroup* as the **key**.  From this
>> + *             perspective,  the usage is not much different from
>> + *             **bpf_map_lookup_elem**\ (*map*, **&**\ *cgroup*) except this
>> + *             helper enforces the key must be a cgroup struct and the map must also
>> + *             be a **BPF_MAP_TYPE_CGRP_STORAGE**.
>> + *
>> + *             In reality, the local-storage value is embedded directly inside of the
>> + *             *cgroup* object itself, rather than being located in the
>> + *             **BPF_MAP_TYPE_CGRP_STORAGE** map. When the local-storage value is
>> + *             queried for some *map* on a *cgroup* object, the kernel will perform an
>> + *             O(n) iteration over all of the live local-storage values for that
>> + *             *cgroup* object until the local-storage value for the *map* is found.
>> + *
>> + *             An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
>> + *             used such that a new bpf_local_storage will be
>> + *             created if one does not exist.  *value* can be used
>> + *             together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
>> + *             the initial value of a bpf_local_storage.  If *value* is
>> + *             **NULL**, the new bpf_local_storage will be zero initialized.
>> + *     Return
>> + *             A bpf_local_storage pointer is returned on success.
>> + *
>> + *             **NULL** if not found or there was an error in adding
>> + *             a new bpf_local_storage.
>> + *
>> + * long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgroup *cgroup)
>> + *     Description
>> + *             Delete a bpf_local_storage from a *cgroup*.
>> + *     Return
>> + *             0 on success.
>> + *
>> + *             **-ENOENT** if the bpf_local_storage cannot be found.
>>    */
>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
>>          FN(unspec, 0, ##ctx)                            \
>> @@ -5647,6 +5693,8 @@ union bpf_attr {
>>          FN(tcp_raw_check_syncookie_ipv6, 207, ##ctx)    \
>>          FN(ktime_get_tai_ns, 208, ##ctx)                \
>>          FN(user_ringbuf_drain, 209, ##ctx)              \
>> +       FN(cgrp_storage_get, 210, ##ctx)                \
>> +       FN(cgrp_storage_delete, 211, ##ctx)             \
>>          /* */
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
>> -obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o
>> +obj-$(CONFIG_BPF_SYSCALL) += cgroup_iter.o bpf_cgrp_storage.o
>>   endif
>>   obj-$(CONFIG_CGROUP_BPF) += cgroup.o
>>   ifeq ($(CONFIG_INET),y)
>> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
>> new file mode 100644
>> index 000000000000..309403800f82
>> --- /dev/null
>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>> @@ -0,0 +1,247 @@
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
>> +       migrate_disable();
>> +       this_cpu_inc(bpf_cgrp_storage_busy);
>> +}
>> +
>> +static void bpf_cgrp_storage_unlock(void)
>> +{
>> +       this_cpu_dec(bpf_cgrp_storage_busy);
>> +       migrate_enable();
>> +}
>> +
>> +static bool bpf_cgrp_storage_trylock(void)
>> +{
>> +       migrate_disable();
>> +       if (unlikely(this_cpu_inc_return(bpf_cgrp_storage_busy) != 1)) {
>> +               this_cpu_dec(bpf_cgrp_storage_busy);
>> +               migrate_enable();
>> +               return false;
>> +       }
>> +       return true;
>> +}
>> +
>> +static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
>> +{
>> +       struct cgroup *cg = owner;
>> +
>> +       return &cg->bpf_cgrp_storage;
>> +}
>> +
>> +void bpf_cgrp_storage_free(struct cgroup *cgroup)
>> +{
>> +       struct bpf_local_storage *local_storage;
>> +       bool free_cgroup_storage = false;
>> +       unsigned long flags;
>> +
>> +       rcu_read_lock();
>> +       local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>> +       if (!local_storage) {
>> +               rcu_read_unlock();
>> +               return;
>> +       }
>> +
>> +       bpf_cgrp_storage_lock();
>> +       raw_spin_lock_irqsave(&local_storage->lock, flags);
>> +       free_cgroup_storage = bpf_local_storage_unlink_nolock(local_storage);
>> +       raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>> +       bpf_cgrp_storage_unlock();
>> +       rcu_read_unlock();
>> +
>> +       if (free_cgroup_storage)
>> +               kfree_rcu(local_storage, rcu);
>> +}
>> +
>> +static struct bpf_local_storage_data *
>> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
>> +{
>> +       struct bpf_local_storage *cgroup_storage;
>> +       struct bpf_local_storage_map *smap;
>> +
>> +       cgroup_storage = rcu_dereference_check(cgroup->bpf_cgrp_storage,
>> +                                              bpf_rcu_lock_held());
>> +       if (!cgroup_storage)
>> +               return NULL;
>> +
>> +       smap = (struct bpf_local_storage_map *)map;
>> +       return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
>> +}
>> +
>> +static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +       struct bpf_local_storage_data *sdata;
>> +       struct cgroup *cgroup;
>> +       int fd;
>> +
>> +       fd = *(int *)key;
>> +       cgroup = cgroup_get_from_fd(fd);
> 
> Sorry I didn't notice this before, but is there a reason why only
> cgroup v2 is supported here?
> 
> Can we also support cgroup v1 by using cgroup_v1v2_get_from_fd()
> instead, similar to cgroup_iter? or is there something else in the
> implementation that is cgroup v2 specific?

I can do that but cgroup_v1v2_get_from_fd() is not in bpf-next now.
I guess we can either wait for it if it can be merged into bpf-next
soon or we can do it as a followup.

> 
>> +       if (IS_ERR(cgroup))
>> +               return ERR_CAST(cgroup);
>> +
>> +       bpf_cgrp_storage_lock();
>> +       sdata = cgroup_storage_lookup(cgroup, map, true);
>> +       bpf_cgrp_storage_unlock();
>> +       cgroup_put(cgroup);
>> +       return sdata ? sdata->data : NULL;
>> +}
>> +

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB966094D6
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJWQqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJWQp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 12:45:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFECA2338C
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 09:45:57 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29NFDi6N025415;
        Sun, 23 Oct 2022 09:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=N0sJw31Pw5mSwPFkcR1t1t8YsexlehYzUCA++qYYYfk=;
 b=hCXgSXaiib7iK4/8UyI9tAsfbdhLzEfdqo/uT8R0zx/IPK4jQJDnUF1TyOH+XN6fH7ZB
 OfUZ2MbwcHyjT2ZoIvAaOPsMT/cxIqXqa9R+gOKx5ehG1yd/GOlqgxMPpwgu6bvGQlqD
 adXpvasv8wzCX34lMMLn2CxGOwE9V959Uida9dV+SFrA8l+Ljo2WuTXhp8gnbMIy3Ymo
 D/uMesMgGo84H+Fc0AYlP8IvsBI+qVLzpLSDZ7tIu88erCdiJB4TENUL4biwSxgk2154
 kY52AcZefg05hgWDci19vtDaOqCuYaDpZ+/4qwWcWU39TloY6qpUycibm6lINdARr6Q7 3g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kcebx1v2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Oct 2022 09:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6LxYqxlgWKbZI3zE6DMaSG212V+A6tEt7IiKffci+xqXNiVF0shS/MMy1gbw6Ik28LVW9tY3lSr/eIJxTOzBXren+1PWcoIBZ3LAUdb+6VrV9gA4fpzrDDQTKZQwakEGskgg/sNMnEhOnW1WTS0+sAqD3yzb1fOp2c3ID9VEWWP4W3JTywG98aGbQ9EeaJCLXULxeODfKrTyCPu+fkvMjSMCB6hnuZez/ILNc3lb/FanM8k+JTzFe+AdlZ6OIr1cqa2tthEzfrLkrrqn/nM1koNa1R9rQGRSzO/Hrr8X/2daLCwPf590XmibZKIXVLCckMbWKRF/IuDb9D7KWbe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0sJw31Pw5mSwPFkcR1t1t8YsexlehYzUCA++qYYYfk=;
 b=h8cKPKpcpOHl0Lqc/RCfv77C1yaE7ou6dkYYxm9sxrxue6EUn3gQA1LroRwqYL0zAa54KspNQYAgveOUcg76tSIlt8y4xf5r8MhRoVbiaH6D7JQitzUgeLJA8xAriZnGmZmXJIVn10pZo6wE8e15dJyuuNvHQds2gSepC+z0Yn4sZPYrHwXtLZ7QpC3kcWwZ48h7R35zoOYfd6+n/NtPv9ZAHxqyY2cdna0dKTtH8W6Gqpk5zLX9goXw4UyIy+R7YOWbA1qGA2qZxAZ8F1YtMbIpmSDay24ja/16SMWDjGGWa1QIw+mslXBhmKWk1DDXFc3qqvSYx/NdoAljT3Ap2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1137.namprd15.prod.outlook.com (2603:10b6:404:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Sun, 23 Oct
 2022 16:45:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 16:45:39 +0000
Message-ID: <95ff1fa3-124b-6886-64e0-adcf40085e55@meta.com>
Date:   Sun, 23 Oct 2022 09:45:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
To:     David Vernet <void@manifault.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221306.3554250-1-yhs@fb.com>
 <Y1IsqVB2H7kksOh8@maniforge.dhcp.thefacebook.com>
 <a9f1be39-4f8e-3f33-f3e0-368f3beec1a8@meta.com>
 <Y1L5oZdzn3kxZL+G@maniforge.dhcp.thefacebook.com>
 <c815edb6-b008-07f4-2377-17b53ccdc289@meta.com>
 <Y1NdLah/c38isGT+@maniforge.dhcp.thefacebook.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y1NdLah/c38isGT+@maniforge.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN6PR15MB1137:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d4d899-497d-47ec-298b-08dab5160433
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Md6ljG4VHwS4+lK3nrpTffO6C50o4IxRk2nZFXvTJZATC6sOFLMZtP6zU1rGt9111rqIrgQOfXDucSDNAXh1mSke6GZC8650nRww2+YJsJ7bZO2tdLpMoc7LOgY7Oz268JvTz/+TgYqRceLIXGbwAAwAG1sQVKZi0vfrw8CUS/VilTll/h0gzRt0F4IAS8xVBDjMQrht2w6VoihsR/7HiA0HcXM0UuYx0ef4ZEUYZ7SIbV/p5fO6a9IvRK9TvAA6EGK/0d/PMWKIr2I4EZh7CIrnVoe53e2evcg14q3r59/KUXzkCt1BS9/XNSTcAbYfDKQmHDMReH9IYHDgVS4ib09Xv5vi8/ZOQMu9GcRePH+HUJ7cfTeOa5MFPSuSF7KVDJdVRX9lU3xnifaR3grQ+bgVyUopg2xrrRUKNJFu3iUDGldFPdM2kRWUvzEGhg6CHAeIszUOChSSfZIY36LSqxBcDK+2XPdK9BSC0pBzvkEsAG7ffP6fA0mrusly4W5sKKznAE0ITUIXuImL5T8zrRh1mLLJO045ZtDUc6JBUvgTk7K2pEQh8Ay9NBhJzHsrw0eX2Ywo3ynSlXEt/uQEy9Y/nAZSUC2wD/KNGfMA3zP40s8gmIfnzyy8vdeYCQ5oV1e4bD8Hu5hmZfXj2olAC+8wbBZMNMs/9yqU4iSUyIxJL0AO/H2xB6QWwSnZ2dTO1h/Pfl9kECJoauQF4uMnEkwqU8oZ0m5xvxuFU3QnByRwYfF4YlcO5V9Eg9kZLWrKzIea/Mom3jUGK0By15MxNqihToHQd7ggN3WlFVby8tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(36756003)(31686004)(38100700002)(86362001)(2906002)(31696002)(2616005)(5660300002)(186003)(83380400001)(53546011)(6666004)(66476007)(6506007)(6512007)(6486002)(316002)(6916009)(54906003)(66946007)(66556008)(8676002)(4326008)(41300700001)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHVyQUU5RytMK3RRWlNrOXY3OWh1VzFYNkhkeTMzT3NqRFJXTEJ0Nm8xVDh6?=
 =?utf-8?B?RXBTM1ZQczVJRzY1VU5SZDUxOHdpR1ZiN0FsMWRXRFFWb0ZaUVBjNHVPWjJV?=
 =?utf-8?B?ZTlzUXkxa0VYVytLU2VjNzNNTkt3UmpCQzZHVWJEcitWZENiODQ0dkRKblha?=
 =?utf-8?B?OUdpL3F1OGw2MFhJVXBqNWZnbXdvTVRjM3lDQUFYaDlwdk1OSm1MNGRQSitC?=
 =?utf-8?B?a0ZnV0dSYmowUkJNQjhUQkFLMTlyd0JzZkw5ZXBycm56MDhGL3ZFREpVNEpD?=
 =?utf-8?B?TmhRYzF0WVZTWjI4VFNIeUdObktHV204UnBXUitIS2FsVVFNQ3lRcGFmVnZP?=
 =?utf-8?B?Q0VnSzIyZDA3cWRoNzVZbjl2VXBBZ3U3bmlsQk5TWXNqaStHRHpQek1YU1lY?=
 =?utf-8?B?OHVqUHdyVzhXREppU3hGeVZpd3VWRUxFQUlYb2xVVXd5WHBmZXErTzFOWkVi?=
 =?utf-8?B?Q296b240TGFuL0E0RnpjOHh1cVVFYUlWQkFZZ1grVjkxd0pOQTNodE82dWps?=
 =?utf-8?B?SHFpOWdWenVKc2F5dzNaZzltT29obGpFM0tuSjZtV0tubFNTbkxNcERXMXRu?=
 =?utf-8?B?czlKMjEyQ0Z5T2cvQ2djLzQxT0V5bGdJTTZTZWVmc0o4eEJjTERTWjlDSWgx?=
 =?utf-8?B?U1VTRFhpQWVIQ0t0MXYwYmpLM2ZPWU9kbmpkM29xRzFtc29LdUZrV2s1cFNV?=
 =?utf-8?B?bVJHTFdyUWJiblg2WXVDUUpIVjFqUVJFVG4xNkdqMnFDcUhYeWVtQjl5QTBV?=
 =?utf-8?B?QzdISkowclA1ZEdHYktrZnlNU3poTCtCV296aGVHMWMraUlYWDlrWW1YUml1?=
 =?utf-8?B?Z2w1bmJaVzdqMWthdDBhWXpxWk4rVGs2ZjN3Zk5rakI3RTgvZDR5U2ZpSnRY?=
 =?utf-8?B?WkhJT1RvVUlSc2RJeElpR3FHZnFrazJ5THhYMGV3Tll6YzZOL1VzRU1GVlpx?=
 =?utf-8?B?SmhRZXg2dGZyV2szUU5HK21xb05ya3RFekhPdVZtU1RwajRuLzFtU1VwQndM?=
 =?utf-8?B?c1hQSEpGblAvMXgvVy91dHdONmkycUlvRWhEU2RhVHFEMHQ2Tm5Xd0lkd0t5?=
 =?utf-8?B?N2xqcVNPVlU4K040WVBXNFZ3TWZybkwzUFRrRjIrdk90NWFWYktTTlJIZkYz?=
 =?utf-8?B?TVNRWXAvYlNjY0F0Rkt3ZXRWcEtqdW0vcjRJZmU5SlU1M3UwbnhvMDJna01B?=
 =?utf-8?B?a0NDTFAraGxHL1J4RVIwYVZFamFZVGVjR2pqRXVFTmE2THQ1OHdISGYrb1Ix?=
 =?utf-8?B?Y1hqME52UmtFSzRqZTNTY3pMdGlvbXZOYUZEUmVPditVYVY4dWtJSjJjMFUw?=
 =?utf-8?B?ZGEwV0Q4ek1CMGZyTnN2dW5JUXc3eTBjQi9aK1YxZjk2QXRtSFVxWVc0OXBB?=
 =?utf-8?B?ckNTN2kwc3RCTVNvS1lGK29nZ0drNmZhT0EwdWZ5OFkzbVFTcUwxOTRxK2Nn?=
 =?utf-8?B?UVM0bnl5emJScFhmY0psdmpKbWdVUStPejVFNlRwZUdhMS9RZVdTck5iVkg3?=
 =?utf-8?B?aHJaL2RpaE1hbU0xWkEvT2FMZjZRS3Q5MndrbnA1SzcyTlVGdlVCd0toc1lk?=
 =?utf-8?B?NG9yVEUzQUFNUFBoVzlacnFQVDhFRm5EMGI1amlHVUVFNndpSVBaWTdSTjJF?=
 =?utf-8?B?QkZBODdoSTF6aDhsT2FhcFZISCt5NVdxMGExMnBXTEcrSXg5anVyRGk2aGZR?=
 =?utf-8?B?ejBBTE1pRVFYZzArTXVCZ2ZrYVo3L3ZsNEJkU0hEdmx6Q1BKQ3czckxwYzlr?=
 =?utf-8?B?eEVGTGJYV1VCY1N6MUtKdWc1WmxtK25HK3BvYS9UcXd5ZEkycGJpWmQ0R29p?=
 =?utf-8?B?b3lTK1BDWjY1Q0VVbTFaWWJ1LzRsdlk4b2ZjS095Y1FFdDZINXZYd2xQeUU5?=
 =?utf-8?B?VngwQnI0M2thbXI1U3FUanZFcm9UVTZUWGwxMTE3MVlLMWNpRFhBdTFrOVVP?=
 =?utf-8?B?RzBYTGFKWG50YXVkcnNVMi8wcWR3OEdLN0RhSlpSenNkdkZESTkwcVY4d2dV?=
 =?utf-8?B?aWwwcUZ1R3RKL1Ivby9ZQjBQWXA3ZVJOQjJiWndvV2x0RDRLejdyMHdDYk5I?=
 =?utf-8?B?WWxPb0RBSVZTdVBnbVhtSTVVdFF0a1Q5TjZ4bnBLYVIvT3cyTUllak1jd3Mz?=
 =?utf-8?Q?nMcBeLcUsBacGkt6O1D5CcT14?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d4d899-497d-47ec-298b-08dab5160433
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2022 16:45:39.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfi4WFiwVqRAAljbgIS9csiZl1c5ypbAJJGZc21LEEsDaBHgHvvIc/00jLFpF7yy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1137
X-Proofpoint-GUID: SOyKDfong1oIGX85JRcXHZkkna9Xt7iq
X-Proofpoint-ORIG-GUID: SOyKDfong1oIGX85JRcXHZkkna9Xt7iq
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



On 10/21/22 8:02 PM, David Vernet wrote:
> On Fri, Oct 21, 2022 at 03:57:15PM -0700, Yonghong Song wrote:
> 
> [...]
> 
>>>>>> +	 * could be modifying the local_storage->list now.
>>>>>> +	 * Thus, no elem can be added-to or deleted-from the
>>>>>> +	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
>>>>>> +	 *
>>>>>> +	 * It is racing with bpf_local_storage_map_free() alone
>>>>>> +	 * when unlinking elem from the local_storage->list and
>>>>>> +	 * the map's bucket->list.
>>>>>> +	 */
>>>>>> +	bpf_cgrp_storage_lock();
>>>>>> +	raw_spin_lock_irqsave(&local_storage->lock, flags);
>>>>>> +	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
>>>>>> +		bpf_selem_unlink_map(selem);
>>>>>> +		free_cgroup_storage =
>>>>>> +			bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
>>>>>
>>>>> This still requires a comment explaining why it's OK to overwrite
>>>>> free_cgroup_storage with a previous value from calling
>>>>> bpf_selem_unlink_storage_nolock(). Even if that is safe, this looks like
>>>>> a pretty weird programming pattern, and IMO doing this feels more
>>>>> intentional and future-proof:
>>>>>
>>>>> if (bpf_selem_unlink_storage_nolock(local_storage, selem, false, false))
>>>>> 	free_cgroup_storage = true;
>>>>
>>>> We have a comment a few lines below.
>>>>     /* free_cgroup_storage should always be true as long as
>>>>      * local_storage->list was non-empty.
>>>>      */
>>>>     if (free_cgroup_storage)
>>>> 	kfree_rcu(local_storage, rcu);
>>>
>>> IMO that comment doesn't provide much useful information -- it states an
>>> assumption, but doesn't give a reason for it.
>>>
>>>> I will add more explanation in the above code like
>>>>
>>>> 	bpf_selem_unlink_map(selem);
>>>> 	/* If local_storage list only have one element, the
>>>> 	 * bpf_selem_unlink_storage_nolock() will return true.
>>>> 	 * Otherwise, it will return false. The current loop iteration
>>>> 	 * intends to remove all local storage. So the last iteration
>>>> 	 * of the loop will set the free_cgroup_storage to true.
>>>> 	 */
>>>> 	free_cgroup_storage =
>>>> 		bpf_selem_unlink_storage_nolock(local_storage, selem, false, false);
>>>
>>> Thanks, this is the type of comment I was looking for.
>>>
>>> Also, I realize this was copy-pasted from a number of other possible
>>> locations in the codebase which are doing the same thing, but I still
>>> think this pattern is an odd and brittle way to do this. We're relying
>>> on an abstracted implementation detail of
>>> bpf_selem_unlink_storage_nolock() for correctness, which IMO is a signal
>>> that bpf_selem_unlink_storage_nolock() should probably be the one
>>> invoking kfree_rcu() on behalf of callers in the first place.  It looks
>>> like all of the callers end up calling kfree_rcu() on the struct
>>> bpf_local_storage * if bpf_selem_unlink_storage_nolock() returns true,
>>> so can we just move the responsibility of freeing the local storage
>>> object down into bpf_selem_unlink_storage_nolock() where it's unlinked?
>>
>> We probably cannot do this. bpf_selem_unlink_storage_nolock()
>> is inside the rcu_read_lock() region. We do kfree_rcu() outside
>> the rcu_read_lock() region.
> 
> kfree_rcu() is non-blocking and is safe to invoke from within an RCU
> read region. If you invoke it within an RCU read region, the object will
> not be kfree'd until (at least) you exit the current read region, so I
> believe that the net effect here should be the same whether it's done in
> bpf_selem_unlink_storage_nolock(), or in the caller after the RCU read
> region is exited.

Okay. we probably still want to do kfree_rcu outside
bpf_selem_unlink_storage_nolock() as the function is to unlink storage
for a particular selem.

We could move
	if (free_cgroup_storage)
		kfree_rcu(local_storage, rcu);
immediately after hlist_for_each_entry_safe() loop.
But I think putting that 'if' statement after rcu_read_unlock() is
slightly better as it will not increase the code inside the lock region.

> 
>>> IMO this can be done in a separate patch set, if we decide it's worth
>>> doing at all.
>>>
>>>>>
>>>>>> +	}
>>>>>> +	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
>>>>>> +	bpf_cgrp_storage_unlock();
>>>>>> +	rcu_read_unlock();
>>>>>> +
>>>>>> +	/* free_cgroup_storage should always be true as long as
>>>>>> +	 * local_storage->list was non-empty.
>>>>>> +	 */
>>>>>> +	if (free_cgroup_storage)
>>>>>> +		kfree_rcu(local_storage, rcu);
>>>>>> +}
>>>>>> +
>>>>>> +static struct bpf_local_storage_data *
>>>>>> +cgroup_storage_lookup(struct cgroup *cgroup, struct bpf_map *map, bool cacheit_lockit)
>>>>>> +{
>>>>>> +	struct bpf_local_storage *cgroup_storage;
>>>>>> +	struct bpf_local_storage_map *smap;
>>>>>> +
>>>>>> +	cgroup_storage = rcu_dereference_check(cgroup->bpf_cgrp_storage,
>>>>>> +					       bpf_rcu_lock_held());
>>>>>> +	if (!cgroup_storage)
>>>>>> +		return NULL;
>>>>>> +
>>>>>> +	smap = (struct bpf_local_storage_map *)map;
>>>>>> +	return bpf_local_storage_lookup(cgroup_storage, smap, cacheit_lockit);
>>>>>> +}
>>>>>> +
>>>>>> +static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
>>>>>> +{
>>>>>> +	struct bpf_local_storage_data *sdata;
>>>>>> +	struct cgroup *cgroup;
>>>>>> +	int fd;
>>>>>> +
>>>>>> +	fd = *(int *)key;
>>>>>> +	cgroup = cgroup_get_from_fd(fd);
>>>>>> +	if (IS_ERR(cgroup))
>>>>>> +		return ERR_CAST(cgroup);
>>>>>> +
>>>>>> +	bpf_cgrp_storage_lock();
>>>>>> +	sdata = cgroup_storage_lookup(cgroup, map, true);
>>>>>> +	bpf_cgrp_storage_unlock();
>>>>>> +	cgroup_put(cgroup);
>>>>>> +	return sdata ? sdata->data : NULL;
>>>>>> +}
>>>>>
>>>>> Stanislav pointed out in the v1 revision that there's a lot of very
>>>>> similar logic in task storage, and I think you'd mentioned that you were
>>>>> going to think about generalizing some of that. Have you had a chance to
>>>>> consider?
>>>>
>>>> It is hard to have a common function for
>>>> lookup_elem/update_elem/delete_elem(). They are quite different as each
>>>> heavily involves
>>>> task/cgroup-specific functions.
>>>
>>> Yes agreed, each implementation is acquiring their own references, and
>>> finding the backing element in whatever way it was implemented, etc.
>>>
>>>> but map_alloc and map_free could have common helpers.
>>>
>>> Agreed, and many of the static functions that are invoked on those paths
>>> such as bpf_cgrp_storage_free(), bpf_cgrp_storage_lock(), etc possibly
>>> as well. In general this feels like something we could pretty easily
>>> simplify using something like a structure with callbacks to implement
>>> the pieces of logic that are specific to each local storage type, such
>>> as getting the struct bpf_local_storage __rcu
>>> * pointer from some context (e.g.  cgroup_storage_ptr()). It doesn't
>>> necessarily need to block this change, but IMO we should clean this up
>>> soon because a lot of this is nearly a 100% copy-paste of other local
>>> storage implementations.
>>
>> Further refactoring is possible. Martin is working to simplify the
>> locking mechanism. We can wait for that done before doing refactoring.
> 
> Sounds great, thanks!
> 
> - David

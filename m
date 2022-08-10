Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213758F1FA
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiHJRyv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiHJRyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:54:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71B1422E7
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:54:49 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuRXb004050;
        Wed, 10 Aug 2022 10:54:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AqVwiWhgaKV5dHEcPCF2WlmkYE+K9Lm44yP3L7oJACM=;
 b=Zr4UftHwH9K4pwhccIqr5I+fFAJCFzXdF+rUItFFnJV1o19svTSNPbYFWE9nYMiCENcW
 +dHTzysLFIVeJZMYe1saG9g5S3Fbrr+MawOBcG6N1z1xtXbcEKooAMEnUAj0NOVFGP7X
 eiRN/Dz/zGdTOMe3xMSD7sDB74dEORB000k= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb0tf7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 10:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/OqHpl7uNQz3VrwOsrK5EEuqwmiSeeJvcqJuYVbvHN12rCJIKKhb8AstaxSQsOkLCpXLnj5bRUgIjp5fDD28SFjvacC8y+deaHHo0SYXdjrqVkud54c0Bh9wBONCWPTKYirn6kIf8TlMmWDj6poVDf0iahJuZhNncdiI/twXFzvXMfNTJWoWQ3PMqQIzJ5nw063ifHUPvb52INZIMJsPgo7lVEXP3e+kkx0sBPGsuLd849V/bdis7DVcFPwbWeg4ZmX9M+vVN+ftDh+unLvDkBfMWZZOxOWtP+XnzfSoSUsCardec4yxYlvbMs/MnS4x3I8T9schTcHxHNeJiCVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqVwiWhgaKV5dHEcPCF2WlmkYE+K9Lm44yP3L7oJACM=;
 b=b1IGpF+9XCAWAEKdVvLUGIpM352WDIAeQvtzx0ALHj3kl010oHMaoVu5ErIHye7884S+27DoNekmoHTMOzq2QaTfTTZZ7KdPMEfrtHY6ONM4j+B5c0WjTtANl4UYEX7QxKAoQGtnzavWP3QGS7CY4Hje8Wb6BqNSRhYk5MoU27wV0kbd+oDhwX4lApYGxV13ZjFD9WomsSIduLRpYM4rCK8/T9CSxDflLjWPnTOMFKZ1sfcHnVNPL1n/S3el6JUrbs6DASMD9KaMuM5bQ8bjp29Kne2oW3JaJ+6gsHeLRYIKURnIQIuJLYNyYUuCXAMzN8aS4KvmmTNGxqk+SW/qJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by CO1PR15MB4971.namprd15.prod.outlook.com (2603:10b6:303:e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 10 Aug
 2022 17:54:33 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::8500:4ce4:51fb:6a8e]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::8500:4ce4:51fb:6a8e%7]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 17:54:33 +0000
Message-ID: <3a5a3c88-98e9-bc0e-c5b3-4c6bf0f49620@fb.com>
Date:   Wed, 10 Aug 2022 13:54:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH bpf-next 00/11] bpf: Introduce rbtree map
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <e7d884ee-e0d3-02b2-c3d4-3c7bac8f13fc@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <e7d884ee-e0d3-02b2-c3d4-3c7bac8f13fc@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:208:2be::23) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13db13f-e15a-4b41-27f6-08da7af96207
X-MS-TrafficTypeDiagnostic: CO1PR15MB4971:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEK3EN+yFwH3l18txXMQ/luXUlpD9Yl6v3BLrLoKSm50JcyviIWvqlcEaGy8L8jPKnJ2tPmVWRrIbdj9GdhgxedQd1Ao8yw89suRDIxsjRoDEAID9je49BX0h3xrBXORaJb2Fx3JPOZ3hQw1Yvg8IJJJbePNDYXjq3ykBhzHDeIBX5nbSewU0FX8ZS+IdKWFmODYxJGWxcQAjQlrYtnh2tzhUlO5cOzFtGi2iZKkqRiRgkaIITaBnl6BRyhYoRaOuzLxqRfUUtRBoY/BIXR/3pmZWuO8f82UM5D5C0+X+9F+UJZnUxvsZrmqD4qe9Qwgvlk0SqmAwLjUw7XzYAzaguEz+7ZmyiPuuPkM0wnKeAGcTJdJvFe3SYm9Su8Yq7/7t1gvl/JjasU1AWLwrVsvCQZpCZ3nbKIs+RV/QqzKoQvW+jGdVlGzrmMT1YYx11ZfwOzy1l9sffX12bSgD/edtcqT5te4tnJc92b1/RSl3YsFv3RHTOw7OWIyXGAM2I0CyNj2cj0f+dsFTeGmd1snot+/Lq+aBvIQDfmB8KipMDfmc9AVY1LEL53e7CfT2E7QojrRjCZ/KKxUbQZNJ0DuBoaZ/1aIhOQP0sI5N508Nl+7s/Et3rjrkmd72Ye51fvH60pLXW0X4Mub9ZqACVLT6am/SuDM09g3gwvKVai632BAaudh4g5fI5/DJIDZrc4HxTESHYRupEtV90pHtr9+hcXaXRuol1I17iT8+m+xnGKSm+/+IkEnkbX0XmaDluRGqAE+XSkixHl85iAxWO3SFcUhgNe3CCwuOw3xPwwaSX7z8DRKxeC8P/bbaXYwtNhhN0oxS3v5feWQH32p46+zfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(54906003)(316002)(31696002)(36756003)(8936002)(478600001)(86362001)(6486002)(5660300002)(2906002)(83380400001)(2616005)(38100700002)(53546011)(41300700001)(6506007)(66946007)(66556008)(31686004)(8676002)(66476007)(4326008)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUg5UDI4T3VZL002YXR3d2NBbG5KQ1J4czZlZEgxWTdjbmJ0cjdDVEJiZFI1?=
 =?utf-8?B?aWVVeGJqcGFPQjNTU2Z0OUNYZ2czSGtiVURKcFd4U0E3MHo5MVZCT0J5bkxX?=
 =?utf-8?B?dHJzaHZLSkVnNFVlR25ReFA2SFgxODVWSG1OUVVxZ2ZHR05KYjl6RUJIWWtz?=
 =?utf-8?B?bjM2eU1Mc0kwZE1lTVNuQ0tqNXNZWDF1akFBUzlLOXU5UUZWQ082UC9yYlBm?=
 =?utf-8?B?dE9sa3pqSWhQMnlBLzlRR1JQb1MrenA2NUpJa295VkhhdWZUWHFFMnZFaUI1?=
 =?utf-8?B?djVBS1pqeGJTY0VXM2dBMVc2WlBxYi9obVN6bnpjN29hWGkvKzk0bEpvRGs3?=
 =?utf-8?B?UFYvZGh0KzUxMHVqcmlYYmpEK1hvaFNKZklzTk9jYmVvdTdCaW1VaTNEcEpD?=
 =?utf-8?B?MG9SYVpkRnBlOVdzN1BveUVCdkJuSTdFMUpyUTNZYUEwQ3c1MFFMQTY2MFVR?=
 =?utf-8?B?QUVwbGpaa012dVNuT0VMdkRpRy94VmdhczltenVTMmV5UTdvOTcrQUhUZ2dB?=
 =?utf-8?B?eUNBdENjbFhJcklTM1N2MjNhZmFVbllEMlBsUDh0dURTSldEVzM5aC9HTTIy?=
 =?utf-8?B?bTU1UkREd015ZnptWXUxUkF4ODNCTmhWZVhtZmZkbkZtSDAvOU42aUNtVXFF?=
 =?utf-8?B?cEdjbHZiZkg2N0R4ZUdYd3VUY3cvVGZPd3RYNW5kb2hUVjBhd3ZpemM4RW1o?=
 =?utf-8?B?VmhRbE5ka3ZacTFscjB4Tmo1ZTRTL25qODNzbW56UHpsZ2QzdjNrRFd4Z2tn?=
 =?utf-8?B?TkxjdWpJS2o3b2NINFBxMGhCQWczUDhockFGK1REbUJORGlEei9yK2lIb0J4?=
 =?utf-8?B?MGR3SERlUHdNR2E1bGF2TEQ3R0xla0tDSmhITjVUa1U3NXJUS2R2SThvbFdP?=
 =?utf-8?B?Z0ZVd2p4QkI1dzY5U3NSQUNXZytmbzgyRFpLMkxnazlBb2VwKzAyUGY0VklZ?=
 =?utf-8?B?RE5aSnlMMDB3QVcyWkNuWnVnQmxoRlBucU1wZWE3MGNnT3VSQjZOV0NHSGwv?=
 =?utf-8?B?Vmk5Q3VKd1dGeE81VXZBUHYzaUlPdmdhdHA2dEtlL3pJcEh4ekM0ZlB2MDNY?=
 =?utf-8?B?dDhxYzdBbFppaWdXNHB3QjRGS3graC85Ynl0SHNKYkhtUmJWM2sxQWJJSHVv?=
 =?utf-8?B?SDFiSUZiKzRkdUZXbEdOWGtIaTVTMDhwbGhNa1hHYThYbFFzelY1OU0yL0d3?=
 =?utf-8?B?ZnFuY2lpODNmNlV6a3NkMlVPMmtCZllsa3U2N2Q0MXk3ZElsSlE4ZDM4UkEv?=
 =?utf-8?B?NjFoOUhaRWhrZ3YxK2wvaSszVi9RY1V6UnBUdlI0YVNRVmVnb3Q1ODN0N2Z2?=
 =?utf-8?B?c2VET1M0bnRrRzJWZlVseHQxTHZpcmVOYUUzYTNOTDZIN3hZK0lUVTVwRVNo?=
 =?utf-8?B?QXgzUDkzaHdDc2k2UGRyY2kxRHg3YUdmeEhkSzVTSzFhbTFEbUx1SGIwLzhn?=
 =?utf-8?B?YjQvRi9CVCtHYUdqRjZjc1dMcTBTVVdlTnMxQ3YzYUIvWnhncFNCRzJqbnBD?=
 =?utf-8?B?ZUFDSm5VYVlRem1QOHkzWWtQNHVWNWVGcm9LNmJ5U0NCczhFeEZISW9TMkdJ?=
 =?utf-8?B?eHRZRjNDbjEyMG1ITUhjR0Q0c1VzLzM2ZElDaEZtS2ZaQm1pWFFWM0RITi9W?=
 =?utf-8?B?UWc0djVqWGtvZXNXZ1dvV0hqellzZ3NQaVcyRy9wUWdVRUhaeDZkbE1ybnVK?=
 =?utf-8?B?UkJoR3hsU0tFcGhZSjlwWm42QzgwVXZCbHNESlQ5TmtKeUNZWlZsWTJabDFJ?=
 =?utf-8?B?a2x4QlFKVFN4OWVabGRrVnluWnpvUzIrU2IwTlBJUm1uUE5NVHZ5K1VkR0o1?=
 =?utf-8?B?STVsMElMVVhDVlRrWHQ4WWtDTTArd21Gc0tqVzBDR1dtWGpzNXBON213NTNB?=
 =?utf-8?B?dGJhb1FHM0lUQm1pVHlvN3prYkZDUXJvQmh1QWNLN244SXJQdU5mZE44YXo3?=
 =?utf-8?B?cnZJWFk2MUNMcDZ5ZzFOUlVBTENNaWZkeml1dFY2SlZyQUdjYTAwU21zZmp0?=
 =?utf-8?B?ZWNwUHNLODhNVnRTRkhBR3dtRThVQVRieE1mbGJOeVBNWjV2R1c0N1pNR3lO?=
 =?utf-8?B?R0dkbC96UWozQVpRK1pJQU8wdjVkbzBVUHV3UHZRQlNpcDRUbEloazBMUXdw?=
 =?utf-8?B?WVlhRUdsekZLRkdNUU5xaGljL2RJdWVOclk3bjlUVUFwc0NUNXFoNFZrL1ZF?=
 =?utf-8?Q?LXxpFhep5pU9uUkIz+rVTOA=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13db13f-e15a-4b41-27f6-08da7af96207
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 17:54:33.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0/7WL0EzlKI7dbU22Raxnb05KGviz0BrSzmKL9I8okchNZ8M7dsVIh3mtMGI9W/fYrOQeBJj32tsjKhkt14tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4971
X-Proofpoint-ORIG-GUID: h4tiGT5XARNghgZxDVEXa5E4M4CVDTXe
X-Proofpoint-GUID: h4tiGT5XARNghgZxDVEXa5E4M4CVDTXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_12,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/28/22 3:04 AM, Yonghong Song wrote:   
> 
> 
> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
>> Introduce bpf_rbtree map data structure. As the name implies, rbtree map
>> allows bpf programs to use red-black trees similarly to kernel code.
>> Programs interact with rbtree maps in a much more open-coded way than
>> more classic map implementations. Some example code to demonstrate:
>>
>>    node = bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
>>    if (!node)
>>      return 0;
>>
>>    node->one = calls;
>>    node->two = 6;
>>    bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
> 
> Can we just do
>      bpf_rbtree_lock(&rbtree)
>      bpf_rbtree_unlock(&rbtree)
> ? Looks like the only places bpf_rbtree_get_lock() used are
> as arguments of bpf_rbtree_lock/unlock or bpf_spin_lock/unlock?
> 

Summarizing our VC convo: the intent here is to have the lock live separately
from the tree, meaning it'd be separately initialized and passed into the tree
instead of current state where it's a bpf_rbtree field.

If the tree still keeps a pointer to the lock - ideally passed in when rbtree
map is instantiated - it'll be possible to move to a cleaner API as you
describe. The very explicit way it's done in this series is not the end state
I'd like either.

>>
>>    ret = (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
>>    if (!ret) {
>>      bpf_rbtree_free_node(&rbtree, node);
>>      goto unlock_ret;
>>    }
>>
>> unlock_ret:
>>    bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
>>    return 0;
>>
>>
>> This series is in a heavy RFC state, with some added verifier semantics
>> needing improvement before they can be considered safe. I am sending
>> early to gather feedback on approach:
>>
>>    * Does the API seem reasonable and might it be useful for others?
>>
>>    * Do new verifier semantics added in this series make logical sense?
>>      Are there any glaring safety holes aside from those called out in
>>      individual patches?
>>
>> Please see individual patches for more in-depth explanation. A quick
>> summary of patches follows:
>>
>>
>> Patches 1-3 extend verifier and BTF searching logic in minor ways to
>> prepare for rbtree implementation patch.
>>    bpf: Pull repeated reg access bounds check into helper fn
>>    bpf: Add verifier support for custom callback return range
>>    bpf: Add rb_node_off to bpf_map
>>
>>
>> Patch 4 adds basic rbtree map implementation.
>>    bpf: Add rbtree map
>>
>> Note that 'complete' implementation requires concepts and changes
>> introduced in further patches in the series. The series is currently
>> arranged in this way to ease RFC review.
>>
>>
>> Patches 5-7 add a spinlock to the rbtree map, with some differing
>> semantics from existing verifier spinlock handling.
>>    bpf: Add bpf_spin_lock member to rbtree
>>    bpf: Add bpf_rbtree_{lock,unlock} helpers
>>    bpf: Enforce spinlock hold for bpf_rbtree_{add,remove,find}
>>
>> Notably, rbtree's bpf_spin_lock must be held while manipulating the tree
>> via helpers, while existing spinlock verifier logic prevents any helper
>> calls while lock is held. In current state this is worked around by not
>> having the verifier treat rbtree's lock specially in any way. This
>> needs to be improved before leaving RFC state as it's unsafe.
>>
> [...]

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555915873D1
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiHAWRx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiHAWRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:17:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9920F45
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:17:50 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KBP7f023002;
        Mon, 1 Aug 2022 15:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+Y9OZXUx0q/7XHX9/6WknJaIf+Oud6a718UYrezng4s=;
 b=OcVLXiq/eJAlr4UDJW7Wp0N8Dujvy1kX0No7TeRKlfzMH3aQA7kiVAOXrfLktYxqFMGt
 BINkso0wD5bKSoncI4ZRmPJcp3wkiK1tjZVIcwYyAEtmaahCJ5haTdlbS16LAqhGvg2P
 7RN2kVtKKm+Nz9zEw31VfDCZv2iwkbaHPC4= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn0pjyaeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 15:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu5Y2f7g5BISZTPPyEE1yEh5cVYqg+3gygi/NO4P8JUnIQfASEikSIP2bw7rsHXnZ7K1f5FsuXm9+EGUfOHl3y2UYf+FyEpGe0v4NZAI8XM7xwWi8qfGMAEIyWB3RZEzVI+B5a0YtSvkyjrV5J7G301BLGjAV7qS6PkS6nya/aSLixokGMa2t+vQzVsPCth11uL28sIOMFU1JWhLi6OsEHsHD0iypcRQrnT5CL/RdBlh1F+ZwxxeCrm91vCQUP60bzMb2DlT6db+PPhsmARo8wNeB3Sh90N5PdXdXjjfC4d16avDLh/+V8L2Pfcxb+IS7Ly/uWh3OUzHGv+8qwGl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Y9OZXUx0q/7XHX9/6WknJaIf+Oud6a718UYrezng4s=;
 b=RiZOgplksFDdEDcG0GcoAYLah66LQuY1ZHNxWTlM2T7MYQA1AFoZCS4G/EwLh8TptW8a/3NcrvzisF0yswgzMqNX9qMCrCkAA5+cFBeSfC7nim4G3PgUjjMQbR1mL2vQgcEovm603/m5kMhooCFuhdGoqwwer6uY3U+U5D1SB4VBlB1d6cpnm3gI9jo0sKd+CbjrwhducgNxdm/MCB2+ZBqccGeHE0yE99UJpg5QvmajX1pI2HJLYPr093SJngNslNpeiOG4JXVA634LWtuaFOvU1b991MqXsREXUHp+GvF4Q95IdEmI+RxlQ/GI6kdxunGFOR8nfLERGptOLq83rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MW3PR15MB3946.namprd15.prod.outlook.com (2603:10b6:303:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 22:17:31 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:17:31 +0000
Message-ID: <61209d3a-bc15-e4f2-9079-7bdcfdd13cd0@fb.com>
Date:   Mon, 1 Aug 2022 15:17:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 05/11] bpf: Add bpf_spin_lock member to
 rbtree
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-6-davemarchevsky@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220722183438.3319790-6-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcbfdbd4-ef8b-47f4-73de-08da740ba099
X-MS-TrafficTypeDiagnostic: MW3PR15MB3946:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9B/dh1WdYYORnd6LWAaYtQnb57eJwPjUaGAYyLiByfyGzkDGuVv9zTYJCqrLdI5iGoGODTJhKbwkA2fW84uIEf79HNLHwH/H6D3fHm/mbCem9+Fi+YLkSR69uUVZldi7TZ97dcla5YCJHy5rZS9j4HU6PGH024lpMEu9KZ0TROoaQTSa757Pwh/4xYWbGGsSeFVYdHGKU0wUrNfCv591waTy6u7ClHhyQiNRrO6kgmMw0wuVbqD8ZDTnRPT3TQiQqSLszeDJfkoOo2rNacFeAWKLhTSAfZ4DdXqIYJ/xRx4QhIL0Ekv1qIEuYQKzvsucVGVAHSwM1OvlrfpXHPbgNXRT+vR0YRd0lvuJ1bGlQyTAYNOSpSZhfFcn3iAMb4ZcEmYmvZWroX7VCZfE0Rlf3v2etFGWCCY3KiZ/XkMCr9gw2vre/bvRNEirY0GalFmZ3XbUajvUbbtxVy6g1reiEmPkEIOe91nNAIeRLGsI9PO0pK5zdy5bZFvOaNUiSLeBMS8jyy3eMivI4daQ6AaQBGkKEoSdncL2iza0reAxGZZ+klW+qr29nHZEHUSyxZe2X4I5TpESa9kdRxASyD+dDb4e4o1qLQjjZoX9aEe8P2Ccf0ryO7CkErHwMu3CeY5ORUrRLksRYk9HHiKmeJ5ZOshfvOiokX0vsBM+RLG1w9Q0NtiYh0hYvu/G6tGMxJUIDNd8V4HxXRikUA6wEEX7GdmRV5lD6KX6J+Ua8Rj3cUznuIc5rDF/WtleYie5X9CibhMh7zx8FK764rtVhTKys4o/h1EwO7UH0AcXrIjw27lsI8TozuVWWn/u0OgGppzeW76yrBN82QVWil3MIOSIvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(2616005)(186003)(38100700002)(83380400001)(8936002)(66946007)(66556008)(5660300002)(66476007)(8676002)(4326008)(2906002)(41300700001)(6486002)(478600001)(6512007)(6506007)(52116002)(53546011)(316002)(54906003)(36756003)(31686004)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRlcm5oUnovbFJ1SWtiNGhJSUpxN3lXWWxOeEFEc2YzekY4aDFjdVJFRmRQ?=
 =?utf-8?B?TVlMWVBZSGEyYmFLT1RNL3pVWDBpdS91SUVwK2x0VVNCYURQOEVNcDloTWg1?=
 =?utf-8?B?Z0pYU09LOXNKL2VoTXExZXJNTnRONVg2WTZpQ3VMYW5XZFlsNXRiZW9BeFFw?=
 =?utf-8?B?MXJWbGJxRi82MEE4cVJ4T3N2Sk96TE1ZWUcwbjNSOWRySnBjMm82ZWd5ZW1i?=
 =?utf-8?B?bE1BWUJ3M3JLak85a200Y0FtVy9HbkxlT1daaWI5cndlZzdoNmtWVm9lR01s?=
 =?utf-8?B?NExaQzB1R0xWRzl3M3hFNGNoQ1I4aTRrTTJiUmRCWUsrbm4vQkNxMjFCOHJT?=
 =?utf-8?B?VWZHOFo5WWF2TGI3VWZSMkZSamhpbUV3eGNoMy9sTG9mT0NuZURsM2JiOWw2?=
 =?utf-8?B?cnBjaC9mV3dzTGhnRFg0Tm5aSng3WXpiQjZ5d1dueUlZRXVDYndaUGFNS3ZJ?=
 =?utf-8?B?YUhidGVvZHBJc0FQQldLVlM1S21Nb3VRMVRZcWdIakUrcUhRZHE3RnhBTllP?=
 =?utf-8?B?VWthWjNFRTlpcm5VTEhaVk5XL3JSRlVTZXhLMEhueU0wdFQwYkhwRHN6Vlhh?=
 =?utf-8?B?VUhVNE8reW1tS0pWNlUrNG55d1NyMVoxcTBuTlU3amV3OURoVlBmVk81UWhG?=
 =?utf-8?B?L0JtQ1IzR0Jrb2x2TTF1RUh5U0VpTGJwMFRzNjRtR3dzNDRvWllDSVhGNnky?=
 =?utf-8?B?YmNlYUdnQ2lPTDRhLzUvUlQxVDFDTTFIejM2NEQzN3B2ZklWaWVXblcxT3Rq?=
 =?utf-8?B?c2hsVzN0eHI0V1FWOFpXOEpHUXFyd2NhYmZpd3V6NFQ5NjRBV0YrQTNmeHha?=
 =?utf-8?B?ZHNmMFp6ODhFOUdISTJuSmQyenViMFlYckpaM2tSYjk0cWFPR3ZHZi9qUXAx?=
 =?utf-8?B?WSt3ZHdmM1JpZWZRVUVjbVdwNDRhTFozN21YL0orb1hwUnhLZkRLcVg4NjNu?=
 =?utf-8?B?SlpPTlByeTV6cmduK2NPWGFvcTB4SVpzZFBTK3pwZkg2TXNOQTNJdGdPNVR6?=
 =?utf-8?B?YURDcUt4RlpxSWdUdjNOWlI5alB2Yi85NVlCQ0twK3lZZzE2UWFxZXdCRXA4?=
 =?utf-8?B?ejh6MXdlVnVOaThSVWU4clNFQTlYcjFybThkUHJLbDkrQWRGdzN0ZmVxY1cz?=
 =?utf-8?B?ajJJQkFlTHJ5QlNseDBydkFSeUl6Z2hHazZRYzBtOHpOSjlRK0tzaGp3SG1j?=
 =?utf-8?B?N080ZDlZenZXS2VaTitlVnloRGxvV2NESWN0QUtBUitLWG1iczhCNkhtaXRl?=
 =?utf-8?B?enJpci83bXpVN0t4T0NNMW41Z0VNdGF5Qzk0M3pWMzJOeDdxcnJVSkZoTkti?=
 =?utf-8?B?QzY0d0RkSFo2dXl3Uk9pdnQ2MzFpeXFwOUFNUUV0dEdiRmN0Q2hEQVNraW9R?=
 =?utf-8?B?dU9PRmZIVVduQUpjaFQ0L1ZSUXZ0VFhoUzVrVVZMSGlBVzNzc3JGT3hEUHRl?=
 =?utf-8?B?ODk0QW5DSFcwTVlnaW0wKysvS244Vmh5OURNRDE2K1NCZzdvcmNqWmtmNmZp?=
 =?utf-8?B?eWVpRDMyQ1hqMnduaUZSbGw0c09ZOU5zUTJ0c01OUUJjc2VPblZxcGppTHBk?=
 =?utf-8?B?RWdmaG10T1BWWkxvc2paL0xwS3h1VkFDR0xzZmdRb05sZzd5UmozM0hMWjNq?=
 =?utf-8?B?c0NKdlZWTFdRMGNLMzIvMEhPbjh3dDlwYStVczZQUEtFS0VmYTJiZFRYR3A2?=
 =?utf-8?B?dnp0WG5sS1cwM04ybGxEdU5IYnJFbWxSZXdvczlwT2FYSGhWMXRkSEQzREtw?=
 =?utf-8?B?WCtJci9yYWYxVndyZEFyKzB5d010UitxblJ3dnpBNGliSGgybitadkRRVEYr?=
 =?utf-8?B?cnQwR1BneERQM2dXMEY1U3BPTGlxdktnbjVxUXN0QVJjMlZhcGNrNUN5MHJT?=
 =?utf-8?B?NzRDMlMxdGVxZjdMUWxmMUJyczMybVE5NE1Kc3dwak11ZFA2Tmt2UGZSZ3Vs?=
 =?utf-8?B?WW9lZnpxT29OR3VUVFA2OVRvdDJwWE9LR2ZNUElmdkpxMjNrbWRlSWhGZHJn?=
 =?utf-8?B?bWp2dVJvQ21VbnB2SmExWEcrcVRRTDJTdkFYOTRpd0VORUdLYnd3RldNaC90?=
 =?utf-8?B?bGJ5SmNOVDE1UTQ4eGR5Z252MHhxbERPbjNuZ01EeTJUT3pLK01oMk15U0c4?=
 =?utf-8?B?bkZ6WTFnemFlbndQbUNCQ0xjT2Q2c2VmSEJpaTBtWDh5dExqdEo5YWhQUXNp?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbfdbd4-ef8b-47f4-73de-08da740ba099
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:17:31.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOK18drGkVSGO1e4emFDy+rVS8wIte9KNQV1sGtrflaisUD36NL7pPUqMz5Hd9by
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3946
X-Proofpoint-ORIG-GUID: IDFR1ng6mpQZKpedQLapzvhJmnoiKP1x
X-Proofpoint-GUID: IDFR1ng6mpQZKpedQLapzvhJmnoiKP1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> This patch adds a struct bpf_spin_lock *lock member to bpf_rbtree, as
> well as a bpf_rbtree_get_lock helper which allows bpf programs to access
> the lock.
> 
> Ideally the bpf_spin_lock would be created independently oustide of the
> tree and associated with it before the tree is used, either as part of
> map definition or via some call like rbtree_init(&rbtree, &lock). Doing
> this in an ergonomic way is proving harder than expected, so for now use
> this workaround.
> 
> Why is creating the bpf_spin_lock independently and associating it with
> the tree preferable? Because we want to be able to transfer nodes
> between trees atomically, and for this to work need same lock associated
> with 2 trees.

Right. We need one lock to protect multiple rbtrees.
Since add/find/remove helpers will look into rbtree->lock
the two different rbtree (== map) have to point to the same lock.
Other than rbtree_init(&rbtree, &lock) what would be an alternative ?

> 
> Further locking-related patches will make it possible for the lock to be
> used in BPF programs and add code which enforces that the lock is held
> when doing any operation on the tree.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   include/uapi/linux/bpf.h       |  7 +++++++
>   kernel/bpf/helpers.c           |  3 +++
>   kernel/bpf/rbtree.c            | 24 ++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  7 +++++++
>   4 files changed, 41 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4688ce88caf4..c677d92de3bc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5385,6 +5385,12 @@ union bpf_attr {
>    *	Return
>    *		0
>    *
> + * void *bpf_rbtree_get_lock(struct bpf_map *map)
> + *	Description
> + *		Return the bpf_spin_lock associated with the rbtree
> + *
> + *	Return
> + *		Ptr to lock
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -5600,6 +5606,7 @@ union bpf_attr {
>   	FN(rbtree_find),		\
>   	FN(rbtree_remove),		\
>   	FN(rbtree_free_node),		\
> +	FN(rbtree_get_lock),		\
>   	/* */
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 35eb66d11bf6..257a808bb767 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1587,6 +1587,7 @@ const struct bpf_func_proto bpf_rbtree_add_proto __weak;
>   const struct bpf_func_proto bpf_rbtree_find_proto __weak;
>   const struct bpf_func_proto bpf_rbtree_remove_proto __weak;
>   const struct bpf_func_proto bpf_rbtree_free_node_proto __weak;
> +const struct bpf_func_proto bpf_rbtree_get_lock_proto __weak;
>   
>   const struct bpf_func_proto *
>   bpf_base_func_proto(enum bpf_func_id func_id)
> @@ -1686,6 +1687,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>   		return &bpf_rbtree_remove_proto;
>   	case BPF_FUNC_rbtree_free_node:
>   		return &bpf_rbtree_free_node_proto;
> +	case BPF_FUNC_rbtree_get_lock:
> +		return &bpf_rbtree_get_lock_proto;
>   	default:
>   		break;
>   	}
> diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
> index 250d62210804..c6f0a2a083f6 100644
> --- a/kernel/bpf/rbtree.c
> +++ b/kernel/bpf/rbtree.c
> @@ -9,6 +9,7 @@
>   struct bpf_rbtree {
>   	struct bpf_map map;
>   	struct rb_root_cached root;
> +	struct bpf_spin_lock *lock;
>   };
>   
>   BTF_ID_LIST_SINGLE(bpf_rbtree_btf_ids, struct, rb_node);
> @@ -39,6 +40,14 @@ static struct bpf_map *rbtree_map_alloc(union bpf_attr *attr)
>   
>   	tree->root = RB_ROOT_CACHED;
>   	bpf_map_init_from_attr(&tree->map, attr);
> +
> +	tree->lock = bpf_map_kzalloc(&tree->map, sizeof(struct bpf_spin_lock),
> +				     GFP_KERNEL | __GFP_NOWARN);
> +	if (!tree->lock) {
> +		bpf_map_area_free(tree);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>   	return &tree->map;
>   }
>   
> @@ -139,6 +148,7 @@ static void rbtree_map_free(struct bpf_map *map)
>   
>   	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &tree->root.rb_root)
>   		kfree(pos);
> +	kfree(tree->lock);
>   	bpf_map_area_free(tree);
>   }
>   
> @@ -238,6 +248,20 @@ static int rbtree_map_get_next_key(struct bpf_map *map, void *key,
>   	return -ENOTSUPP;
>   }
>   
> +BPF_CALL_1(bpf_rbtree_get_lock, struct bpf_map *, map)
> +{
> +	struct bpf_rbtree *tree = container_of(map, struct bpf_rbtree, map);
> +
> +	return (u64)tree->lock;
> +}
> +
> +const struct bpf_func_proto bpf_rbtree_get_lock_proto = {
> +	.func = bpf_rbtree_get_lock,
> +	.gpl_only = true,
> +	.ret_type = RET_PTR_TO_MAP_VALUE,

This hack and

+const struct bpf_func_proto bpf_rbtree_unlock_proto = {
+	.func = bpf_rbtree_unlock,
+	.gpl_only = true,
+	.ret_type = RET_INTEGER,
+	.arg1_type = ARG_PTR_TO_SPIN_LOCK,

may be too much arm twisting to reuse bpf_spin_lock.

May be return ptr_to_btf_id here and bpf_rbtree_lock
should match the type?
It could be new 'struct bpf_lock' in kernel's BTF.

Let's figure out how to associate locks with rbtrees.

Reiterating my proposal that was done earlier in the context
of Delyan's irq_work, but for different type:
How about:
struct bpf_lock *l;
l = bpf_mem_alloc(allocator, bpf_core_type_id_kernel(*l));

that would allocate ptr_to_btf_id object from kernel's btf.
The bpf_lock would have constructor and destructor provided by the 
kernel code.
constructor will set bpf_lock's refcnt to 1.
then bpf_rbtree_init(&map, lock) will bump the refcnt.
and dtor will eventually free it when all rbtrees are freed.
That would be similar to kptr's logic with kptr_get and dtor's 
associated with kernel's btf_id-s.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5F5873A4
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 23:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiHAV7Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 17:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiHAV7P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 17:59:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020761A83C
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 14:59:14 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KCThp005737;
        Mon, 1 Aug 2022 14:58:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FDWWPhSajy1aZShVppIU7LUGV6OqsGK/AzEishn4i/U=;
 b=dwYLKcsFFuHUoeJV43yyLpxMUzmf0gThs9yVtRNFReJf2uLKxhIjn9mC0KlcAgDtERTg
 LITtM7anyZSb+kqYudLP1DLmyUNSwcVwsEZ45hQ5MTO85CoeNPpYdr6dXrtfKDyG4oG1
 st1ceeNh8OlBlOH+Pa/uYjGBTMTp3vwdn6g= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn2bn6nyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 14:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj+aE5X4pbmMwIAXeWqc/Da1oyAs6aWbyFjJSu0ZOnxwxmd55Sp6z5ICXcTX3HjII8VeCZXEdYbQGnv5qcuC2jUf1Da+OhjPsVQE42XvRBuLaFXy1ccTko08RKUANbP0EIEn4rSo7Qq1y8xcqkwrhzR/cfrK+hTjQxjIsN6nXpTFVhnHDzBy5KfUCQtymkifMSJBVU1gFB7wK6iQeq0lU++yBDcL0Gsl1JSD59yEjz0PsHyJ6P21SCpwr+S1VNystAUMpFXn8m0QlOXLKg0vgM0dtH0x7cQPqJlf/KzjTC2MIeONJpTInnYW5dy/YRUT3kNqLaBcfHAQPKrAQLJiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDWWPhSajy1aZShVppIU7LUGV6OqsGK/AzEishn4i/U=;
 b=KCEWXDs1y74j3C32h0hIjSBnZ49WoL2dnbNSciwIdrBTeLVP5BTxKGPJFAEIpc5DPbvXATqZVqh9dXmmlxowhrpSnJCuQE8c/owMte5VfDDPCa52CaUbrw5/+hhEX7bFI8SlRwZGBbCt+3+dEbER35tJbZ0E0wzpuEYvmIwS419uFluK5jUQ1p0fZwRnMKRvyff6wjtdMm4D0Nh8Ty8Jx/krwU3/3y5HtIDDvLfUigubfoYkCsBkIvgGNvdWvu9Oq9en+deqNzx9FI3DmrBGpZQD+D3Lhn+mtFNV8mXSWi9CerKmMP9TcF2rqTA3VFfKtoZHzQfFa6NgXGHKWt+Gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by DM6PR15MB3831.namprd15.prod.outlook.com (2603:10b6:5:2b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 21:58:57 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 21:58:57 +0000
Message-ID: <93985c8f-1bcc-363e-ecf6-513b84d785ae@fb.com>
Date:   Mon, 1 Aug 2022 14:58:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 06/11] bpf: Add bpf_rbtree_{lock,unlock}
 helpers
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-7-davemarchevsky@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220722183438.3319790-7-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::25) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1541f96f-2b70-4787-7989-08da7409085c
X-MS-TrafficTypeDiagnostic: DM6PR15MB3831:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hemk2RrQGE4gOvbKY7UZnCKCeAzCYKvLxULA0NKSoqp/fTRCfWG9n+taoPO3tYIxz5ngAd/3DNSPGXsYe6ZFDWUln/NPeVP+Ocl0bbzWVq3V1LxcetX3z3onIjntcfLc3x3OhEUnPpSgF93hw5ous4vLEZoJHzyYf2DjVZ218K95roGRBc+R593Rpcc2vRM+tnBT7yn89X9YFTn8cVmT3xb9FovhEfdPKam1roOu0gPsjKflNFkq+J3yLh59zdDuTzH1CU+IcvsWqcXOaLVjSgXXX64fEHCk6zBmqWJ6XVCdn8kJ1MlU1+ZCBqq+TAPU5FxuyPDfzX86W/vpNPQh/ktWHg0VxBKhOfuhs1amIwtByFxXAaRyl0Xq71JW027gmUAGFcVbftaZSYLIQk4+tvqBuLw0V/FJw74A6emPAegi4qU3xG0GVR3WgmJyPkoVTFcZV5nJtUZTTzuAe9pQwSL/sBE0kmagol+ZY4fH1MX7ku6P8lVydkXsG4yVuF7zTol9iGhwRLeOc/RV4O0yx1a/TnnpuMMqzy9NDbPEVT8J1C9DmGsWTr+ki4tW7XFLgGIj9LKqR5AW+04aTh4yfUrd21Y/bhpj6v5D9IXD0a2IuPKMZ6EGO5YutyIf7w3qA0ntDaMg1pEyH1rUuG98hM5mzBUTPI1TpnlbbxmdYKLQ6mXq0rinUIQZolWcEGEP1pPOCfA+E0K51EsOFCxvaZ/nvggyWWU+ck/TeyfUa+h42dUK1DAeMMVyYkYwBPqZGRy57Cyk+47LmRklMGBC2RdjUqo7yTtnAkjY2noflawK3RkB88pFPvrIg9+hxPsdT/hbKXTsPNpCJHEWnvwttg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(66946007)(6506007)(6512007)(4326008)(8676002)(66476007)(66556008)(2906002)(53546011)(52116002)(38100700002)(41300700001)(6486002)(83380400001)(31686004)(5660300002)(54906003)(478600001)(86362001)(8936002)(2616005)(316002)(186003)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmxXWUw5MUhoNXVtOUFSVU5qR2t2YTFRaHZkK25DOEx3YW1kYksrbmh3Qi9n?=
 =?utf-8?B?VXZibzJFYktFK2lBVFV3M1NLY1Iybk9ULzhlME13aGtweWg1ZkFuNzI1MGpJ?=
 =?utf-8?B?bFcra0xnM25EWUlrR2lOem5wTmp3aHZ3WGM3NXg5MGNqY0RHVHUwcUo0NHVn?=
 =?utf-8?B?TEFFSENXWXFHRmpWZmk4Q3FtSmExQ1k2d0JDNTJWSUw5OTN4cmhNaDRFVmdB?=
 =?utf-8?B?VmNBeDRDcVBkT0s3VlVoU0xIYURiK0RzMWp3ZjZJLzdTV3NtaXh4ckxzUjFM?=
 =?utf-8?B?bjJYTEM5eEFteE9ndS8zQktSbERUNGpjcUQ4OHJIWURrV3BDSnFpd2dab1Ax?=
 =?utf-8?B?RUJ0dnJQc0cvSjEzVXJtZ01SUy9KVEUybEZFWmlUdG9KVmZLMHJOS0ZYK0Rz?=
 =?utf-8?B?QTMrckFEdUJVU2RUY3Z4VXpoM2hoSkxlZlJ0RXZQVzh6WU9EZndqMDVKWGp1?=
 =?utf-8?B?c3FLUmtTTUs2ZGx0eTF5WjJ5Q05UTC9mRWVGdkZDNFRTamt2d0Vzbk5LVUwr?=
 =?utf-8?B?czZONkhjNUR1VVhmajFJbDJJN1E4ZWd1cjJXQW94YXRqYU8vdVpSTnA4QnEx?=
 =?utf-8?B?d1F1RkVnL0p1SkgrWTIvLzBoUW5LNGlIc21wMzVFMmphS1dKd3ZUQkxpQzY1?=
 =?utf-8?B?Mk1NNkd1Y0xJTFBnelZaMnFwSHFzMDMvOG5zaDJtWk1ibFRzSUxPeUFVVFRt?=
 =?utf-8?B?NDMzNnpVa0lCVjhXM2kyMVFLWnNWM2JsRHVCRE1VNklMN0NZVXZDa0Zib2p3?=
 =?utf-8?B?T2lkRVdEVmo4eWFaWnZ5cGhxUXVWVEgvQnZGcnVDZWk0YnJJVVlHc00xUlYx?=
 =?utf-8?B?WEFUalpsZEpoZVRyaFpJS09JZWhPVkhHUVVUUzEwb3JiSlg4ZUJQVUhmY2tV?=
 =?utf-8?B?ekk1SDNyQXdWSWZMZTJiNzRzNkJQS1BOV3p6VEFKdEhVOFJLajBORERySVRY?=
 =?utf-8?B?bk1UeGx6MXoxU0hCWEdhQnF0MnNkNTloWlBSaWh6Z0hDNDhYaEpmb1lCaENs?=
 =?utf-8?B?d2lwQWJ3eW1hTEZIbVNPbHlTTlVHcVN5NlhWZTJDTUVQeVZnd1lsTUExNnph?=
 =?utf-8?B?aHFCTGpHWkRZVkF1MVlRdnY1cWpWZ2c2NzdNOWhCTWJ3WW10RWlnWXBITmpG?=
 =?utf-8?B?ellFVDVuVkFieG04Ny9ZSDExWXoyMzNGYXZhcDZyR0dnMUViSWk1S3VKZmZj?=
 =?utf-8?B?VHB1NlRvc1R1emFQSFVaelgrclRnSng5aS9pZG5heUNicnlKZCtOZ1daZm9Y?=
 =?utf-8?B?UUtEM1hDa2RKT0J1amJqM0F6T0F1ZU9SVG9heDMrRXNVYkk3akhWdURGbXhY?=
 =?utf-8?B?d1VMa3pFZHZ5VVp2WFI4UmVGdzJ6T05IRzh5cTZ5TUtKZEQyK09jckpwek1k?=
 =?utf-8?B?MCtLTjZxRzNaVUxVT05mRGMzbG1NcytZdEJPSzg1Zy9vMlEwYnJOdmcyT2lJ?=
 =?utf-8?B?ckpWRmdUdGdwZGJTdyt2Vld0SGsvbWp1UlZBL1M0bmswTjN4Q3B4ZHgvbFNC?=
 =?utf-8?B?NHNoc29KRDJjQ0RhbExYUHNzV0xjU0RZeUIxWXFTSm5NYXJDTEZocFBQQWM2?=
 =?utf-8?B?dC83WGxaRTRKdnA1QVB5ZGJmdlcvblNsdm93MUViU252TUhWNjFDdEwxMVI5?=
 =?utf-8?B?dElkMytXS2lzaHJSYVFLQ2JtbkVqTEJXQUxGekwvU011SUd1SlZzbUdSRS9m?=
 =?utf-8?B?WXNMTSt6ditNOU1yQ0hrdHZrckh6OHJEdnRaL2Y5elBtcWdRenhOZ1orQzlF?=
 =?utf-8?B?SXdyelhTMG5qc05FaDVkR3g1U2xWQUZqYlhMSnE1T2I4dTV4MG0wSncxcXUr?=
 =?utf-8?B?SzRqcGM4MERaSzBvZEZWaVBBeFZIMEdzRnRONzRLN2J1SzZwWHBEQ1pxckRK?=
 =?utf-8?B?eTk4YUxlQ1Bkc25uRmZHeGFBaTM1MENNMXczWThvd01ock05dWJNb0tQaEdF?=
 =?utf-8?B?T2p4VmhHYmxYVlRWOHJsT0J5KzNHMWRWS3lFU0cxUWwwdkh1ejlSL1dsdjY4?=
 =?utf-8?B?OCsvblpVVjF1VHhjd25IdEJQSFkvQ1p2d2hRR0FEd3l0U2xkbWRwZGFWcHNy?=
 =?utf-8?B?R0VwWGFteDVDUHJBVE9PdmRFR3psVW1UY1p0NWV0bisvNG5ZYWlMOUFzWG01?=
 =?utf-8?B?TS9RdWw5OTdRclJCcWVZQzR0YzVBYWJsdXVtUWZsM25KZkwyYWtnbW9qam16?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1541f96f-2b70-4787-7989-08da7409085c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 21:58:57.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN8U5TBkk6d3+F+rz8WBEz0fma7LzJEsuq6IfNzmcHF+25vnRA7CYtZih0kqJiaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3831
X-Proofpoint-GUID: cbnRbUIMF7gvYt1FvJMOfVHbQlz4R-EN
X-Proofpoint-ORIG-GUID: cbnRbUIMF7gvYt1FvJMOfVHbQlz4R-EN
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
> These helpers are equivalent to bpf_spin_{lock,unlock}, but the verifier
> doesn't try to enforce that no helper calls occur when there's an active
> spin lock.
> 
> [ TODO: Currently the verifier doesn't do _anything_ spinlock related
> when it sees one of these, including setting active_spin_lock. This is
> probably too lenient. Also, EXPORT_SYMBOL for internal lock helpers
> might not be the best code structure. ]
> 
> Future patches will add enforcement of "rbtree helpers must always be
> called when lock is held" constraint.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   include/uapi/linux/bpf.h       | 20 ++++++++++++++++++++
>   kernel/bpf/helpers.c           | 12 ++++++++++--
>   kernel/bpf/rbtree.c            | 29 +++++++++++++++++++++++++++++
>   kernel/bpf/verifier.c          |  2 ++
>   tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++++
>   5 files changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c677d92de3bc..d21e2c99ea14 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5391,6 +5391,24 @@ union bpf_attr {
>    *
>    *	Return
>    *		Ptr to lock
> + *
> + * void *bpf_rbtree_lock(struct bpf_spin_lock *lock)
> + *	Description
> + *		Like bpf_spin_lock helper, but use separate helper for now
> + *		as we don't want this helper to have special meaning to the verifier
> + *		so that we can do rbtree helper calls between rbtree_lock/unlock
> + *
> + *	Return
> + *		0
> + *
> + * void *bpf_rbtree_unlock(struct bpf_spin_lock *lock)
> + *	Description
> + *		Like bpf_spin_unlock helper, but use separate helper for now
> + *		as we don't want this helper to have special meaning to the verifier
> + *		so that we can do rbtree helper calls between rbtree_lock/unlock
> + *
> + *	Return
> + *		0
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -5607,6 +5625,8 @@ union bpf_attr {
>   	FN(rbtree_remove),		\
>   	FN(rbtree_free_node),		\
>   	FN(rbtree_get_lock),		\
> +	FN(rbtree_lock),		\
> +	FN(rbtree_unlock),		\
>   	/* */
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 257a808bb767..fa2dba1dcec8 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -303,7 +303,7 @@ static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
>   
>   static DEFINE_PER_CPU(unsigned long, irqsave_flags);
>   
> -static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
> +inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
>   {
>   	unsigned long flags;
>   
> @@ -311,6 +311,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
>   	__bpf_spin_lock(lock);
>   	__this_cpu_write(irqsave_flags, flags);
>   }
> +EXPORT_SYMBOL(__bpf_spin_lock_irqsave);

what is it for?
It's not used out of modules.

>   
>   notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
>   {
> @@ -325,7 +326,7 @@ const struct bpf_func_proto bpf_spin_lock_proto = {
>   	.arg1_type	= ARG_PTR_TO_SPIN_LOCK,
>   };
>   
> -static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
> +inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
>   {
>   	unsigned long flags;
>   
> @@ -333,6 +334,7 @@ static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
>   	__bpf_spin_unlock(lock);
>   	local_irq_restore(flags);
>   }
> +EXPORT_SYMBOL(__bpf_spin_unlock_irqrestore);
>   
>   notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
>   {
> @@ -1588,6 +1590,8 @@ const struct bpf_func_proto bpf_rbtree_find_proto __weak;
>   const struct bpf_func_proto bpf_rbtree_remove_proto __weak;
>   const struct bpf_func_proto bpf_rbtree_free_node_proto __weak;
>   const struct bpf_func_proto bpf_rbtree_get_lock_proto __weak;
> +const struct bpf_func_proto bpf_rbtree_lock_proto __weak;
> +const struct bpf_func_proto bpf_rbtree_unlock_proto __weak;
>   
>   const struct bpf_func_proto *
>   bpf_base_func_proto(enum bpf_func_id func_id)
> @@ -1689,6 +1693,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>   		return &bpf_rbtree_free_node_proto;
>   	case BPF_FUNC_rbtree_get_lock:
>   		return &bpf_rbtree_get_lock_proto;
> +	case BPF_FUNC_rbtree_lock:
> +		return &bpf_rbtree_lock_proto;
> +	case BPF_FUNC_rbtree_unlock:
> +		return &bpf_rbtree_unlock_proto;
>   	default:
>   		break;
>   	}
> diff --git a/kernel/bpf/rbtree.c b/kernel/bpf/rbtree.c
> index c6f0a2a083f6..bf2e30af82ec 100644
> --- a/kernel/bpf/rbtree.c
> +++ b/kernel/bpf/rbtree.c
> @@ -262,6 +262,35 @@ const struct bpf_func_proto bpf_rbtree_get_lock_proto = {
>   	.arg1_type = ARG_CONST_MAP_PTR,
>   };
>   
> +extern void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock);
> +extern void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock);
> +
> +BPF_CALL_1(bpf_rbtree_lock, void *, lock)
> +{
> +	__bpf_spin_lock_irqsave((struct bpf_spin_lock *)lock);
> +	return 0;
> +}

it doesn't have to be bpf_spin_lock.
Normal spin_lock will do.
bpf_spin_lock has specific size requirement, so when it's used inside
map value the value size doesn't change from kernel to kernel.
Since this lock is hidden it can be any lock.

Also it needs to remember current task or something.
Just spin_is_locked() from bpf_rbtree_add() is not enough.
Instead of remembering current we can pass hidden 'prog' pointer
and remember that in bpf_rbtree_lock.
Also pass that hidden prog ptr to add/remove/find and compare.
But probably overkill. Current task should be fine.


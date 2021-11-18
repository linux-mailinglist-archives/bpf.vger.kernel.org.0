Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA64561E8
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhKRSDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 13:03:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33036 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230481AbhKRSDJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 13:03:09 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIF0HHi004275;
        Thu, 18 Nov 2021 09:59:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VmNFVDaRUthSFgGP/xsb7BwXqp1Xqg1cRi6cFhGXeVA=;
 b=pEmeVVKAvhj7iaUiVGvFe+qNZp/MaQgcNm+fRkxTCsXgyNE8mEb6hmuTr4y7124fAQPi
 5wKjfU9F8rfbyZU+cbG8uM1D62CGtKEP2Ce08bXMCY0fp4rLU/rZqAR8UOUlj+6jcKrE
 qrXHA1DmXQATPsnwoVAXW4WgArFY3LzXFco= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cds3f1d5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 09:59:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 09:59:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXlkpT1SPKDKok1F4u53qY7m9cA+hMNBq78HvE+cidXMsMZTYvd4pkvtJxcqIfKZze60vXQtS0eU6OAiwllEMR9My+caIYiV7UKTkX4QGc0loSCgDPDteJmXlp2IXe1YDAJCw+eC1TmsxFq/0wo0ft1Q0T6AyvcD16awhOyki49NIe5UsWRXKZvSjMQROmSUZYM8DoKgWNN6PNQIBAtJL1yglbsMDQfhLPdm55iAgCLiE9es5mSi0D39caKiM+o49LCf7vZk9yancbYottquVSj0m9md3zW5sBaL7aMWf9pHqRNmucXpImmFV9vqU110Uvv//rp4TTvOTtLtwaNsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmNFVDaRUthSFgGP/xsb7BwXqp1Xqg1cRi6cFhGXeVA=;
 b=ehnXTc9EoFa9PDZpfQ4wKSN+bERvaClH6SSwLKzjND+oojal5u2SgmqtlytpB1moFY2ixtANR2as3otLaNgEij7VCLx5el2gxahc2W1yPU24voSjnLNOFWbtmNzHnuC6OgJQ57fo7SweyH2xjo5XvDfh7tQNRhrAR5gKdPZR/WEe61KzqfC/5ZJHRlNwWaz5gdjIxZ5bDRzj1DAkaS3Ma/T2+hE0zT+5LC/euk60iSnxYIOYc84AAO7z+cPjB/p/2VQf53rtbfQEwihfQE1hf+Gh4ArxnHn0vv9lOg4uLTQgd4XhVubkIWk1EjAU3m6FpfCcyDLg3MJJm1+cYltr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4418.namprd15.prod.outlook.com (2603:10b6:806:195::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 17:59:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a91b:fba1:b79c:812c%5]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 17:59:54 +0000
Message-ID: <90ff8227-875c-1ef5-95e5-eee608c8658a@fb.com>
Date:   Thu, 18 Nov 2021 09:59:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Add bpf_for_each helper
Content-Language: en-US
To:     Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-2-joannekoong@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211118010404.2415864-2-joannekoong@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0114.namprd15.prod.outlook.com
 (2603:10b6:101:21::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::1798] (2620:10d:c090:400::5:184a) by CO1PR15CA0114.namprd15.prod.outlook.com (2603:10b6:101:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 17:59:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35eddf64-af19-4728-a461-08d9aabd39e5
X-MS-TrafficTypeDiagnostic: SA1PR15MB4418:
X-Microsoft-Antispam-PRVS: <SA1PR15MB44185C86100607872A899024D39B9@SA1PR15MB4418.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rc3JkM6sxaBZUIKjCrafhAYlFrSSW5QRVNoqj2Y5avc4byfuRBGn2QOpQDFSxBsMZ5xBqeMoWnyZB3rodVOMrWbAE4zOw4jtQNJxxOAcI+V8J0VxW+wYJpd4ztrkXJZS2W016bh62BX3lWbSVCp+G5bHbcEDATm2KehnUkRCiO6JFon65Ar21fVuru7gmCgN7E0hJNBEl9wApB0zcHqI1ONQdJK8SbCX3n10hMfsp8T0uGFC4auDM2X1VVuJV8+o1xE2YZOaTVaU3g+iqByXZQA6ZX4K/CmhvEzJnEj2EVSSMYYNyeEaYePUJQONmi8Z0mp01QxrEZipVKaWAmIFUQ1nKNv4Jfd2jK6tmgc1WuNccrmzlj3tSXayO3KPbXL6ak+bkgvcxFxGbMtsfSbGIa2Mpb+Ld6w0jtW7cTU2HpIqtl2pzEquhA5wl2+OLN8xM+1xujyRRDWmZ7hEsW1oE3cw1MBIQlfnijHNxxKplBmFruAZJjaG/H4yrugc43rHKsAYXiNVm+lVadAam97dTrgpYyicGC3SzYkAcLFfkZVXq2GAY6mHfXcrMov9T/T+ryxMTmwurhm+NGoSAZ9d7A8qHgSNZUbLjgpPWfwZOD0R5tOrEs2NM1gi6za9esVimrkrbmBBpYfKbbFPvvEMEcB+DbIX/N+2eLu3epCYIsWF0rKRctbZH7CHoJocMS6qARF3Rf5tq1O7qCuPVsjMsQdZHpXPvmRfjVvs2UB3EtZrduAFAD5/YqzpiGrA/zmv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(66556008)(66946007)(66476007)(31686004)(6486002)(316002)(8676002)(86362001)(83380400001)(8936002)(186003)(2906002)(31696002)(5660300002)(53546011)(2616005)(52116002)(38100700002)(36756003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1JDdjRMcmxiMnlmamEwTmtyc09lUFB5MG1IZXpRQnhZZGdCTkJFcGpFbGZL?=
 =?utf-8?B?OS9nZWZxUjMwcU1YMWNHQ0RFMEdyTk5CbjRWUmQzOU1peG9HK2g2a09xSmQw?=
 =?utf-8?B?WFhkWGdzS2NGS2dzajhCK1d1SmpiQ3NlRDduS3FVN2N1dEY3ZDRhSWdFTjlt?=
 =?utf-8?B?czByZnZhMDBZNTZnTStJQVN6V0lKRUYyMnBlL3dsU1pGalExN1lTU0pTa1gw?=
 =?utf-8?B?L0ppUkdyK1Y2aVg3V1luTUdzNzUxVVI1YmZyY1p2aW40YXZaVnVMYUJNelBt?=
 =?utf-8?B?SzU5WDdrVTVsOVc1ajJYMEM0dzZhNFZ5ZDJWSFdnYUF4K0RRMlZGVGJXbHdo?=
 =?utf-8?B?ZlRZU2hrS3FrTnE0QTJOaEw2dkxHVWpmdWl1Q3FPYW5CbEtMQ1NxK1g1QW9Z?=
 =?utf-8?B?azZZUjUrK0QwNDd3RG5aK3FZTVZ2TXdXUElnNXpSMk93SGs0ZU5PUHcwZU15?=
 =?utf-8?B?bzErUm9rVGdsTnNVY2dvMzdZWXVXUDh2K3pzaGpnWGN0Vi9tNEUySmgrKy9T?=
 =?utf-8?B?TWFnUWFSWHYzQVdvck1aMGJ3dXdzOGhTSzhmMXFIUWR6dmk0anBBWGlaNnI5?=
 =?utf-8?B?V2dwVVUyc1ZCWjltV3pJNjB2ak02Mk8yaUhtZGE4UFpBUmFrR3RtemFvczBX?=
 =?utf-8?B?UHcrOWF5dGQrdFdUemxTRWZVNUFJc0RxcU9keHFHM3RFN0tyclJNV0VDUTYy?=
 =?utf-8?B?RXRVcWVLdmtPUFhwSDJGU0JrRmo1dmV2SjE1OWVVYm8xaFZML0dzOTQ5eGhF?=
 =?utf-8?B?UXZWay9SdGlNUTBVdGxqc1prUVpXblcrYmpVRitaK1FhV0plSzhEa1R0aWlT?=
 =?utf-8?B?VEpGUHVZeTNRTldKRVp0MUxuUVArbDFOZ21OWThrWVZxcjhOY3NoYkhkdHpk?=
 =?utf-8?B?d0ZwWkY4MTNEUThJTDB3MUczbTMxYXhidUpjQ0pmTVJkMGpISUZyS29yNVpR?=
 =?utf-8?B?Y2lXaFNzWi8zaHVhOGxFUlJkR3FQTTRsL0dqdTNrU0RvVDdpZ05XMjA2Um5j?=
 =?utf-8?B?L1h2VHBNaE5tSkpWR0pMV3NVZ1QwMDZncklZK0REc1E4QjZlZ3ZDREhWU2J0?=
 =?utf-8?B?clFXVGN1a0U5a1hZNm11RnNnNkVhbFRXUDJNUHVpWlIxUFRtQnoyYmhhemE1?=
 =?utf-8?B?UUdaZlJMUmhyMmpDVkY5WkFCbVpsZkVDUy82UXhYUythT09XK29qTWdnZ2oz?=
 =?utf-8?B?K3hTb3BhM2tyTzZPK0ZoczNMKzdlbkdaU2RrTWgwUDhzV2VKS1cvb1BpNnIr?=
 =?utf-8?B?aEhhTkNCOHBnLys3ekQ1MnFkNno5N2oyTUk4Uk84ZkZhdTFHbjg5bzgwcDI5?=
 =?utf-8?B?WW5EalNNQy9VaXpLVVIyK3REMGx0Uk1Wd291dnM2OXZNREt0VEdJRlB6ZGpl?=
 =?utf-8?B?T1YySGUrZ0wwVy90OEFDZWFOZTQ5eDBTdUFnSUhCR0RhbEh2RURYS09JcytP?=
 =?utf-8?B?cXRycHVoaDU2RDVlbmlDQWVhOGl2QktnZHFyeDYyMFQvWURoZ3JCUE0weCtD?=
 =?utf-8?B?VjUrZTYrMnFyL0lQVHI0T2VUNWNCUFN4Tk5PSFdqYmxONEdTNlYrejNtVGF2?=
 =?utf-8?B?SXJ0Q0xPV0FaVnY0OWtZWUFqOVFhSmQ2UEhKZFFmZFdzdldxbkpXYjBGeHMy?=
 =?utf-8?B?dm9BWXJOZHVuN1JORlYyNmtOZGVBS1dqbnRJWGRWVzkxT0twSWM2SEplUkN1?=
 =?utf-8?B?L0l5QW5SelpwRGNFcXg2ZUlEY2NNbUJxNVF5dHA4L2VEbjFJZm9ITW82cGlI?=
 =?utf-8?B?ZDFWSHZGTWt5c1NxeUUzNGo4R2ZCVTFjUjgxZ3RFRFJySElaaWx4NCtRa3JF?=
 =?utf-8?B?ZkZrWkdmbjg0NXBlTW1xdGZLaCtXUXB1OFNtZWxsT3E2cVIzMnluUzMxbUYz?=
 =?utf-8?B?WFI1dzBjWDgxcCtFd1haZ2JWa203UHRPVFgyaUhhQUcvTFRZMUVUMEpsbXZC?=
 =?utf-8?B?VnQ3RFUzeGpWQnlaZWFrdHJ3cEVSbG8xSFhha1g2R0NFWHdub1hCdTJaelRm?=
 =?utf-8?B?NmRPUUhlcFJkU2wyZmZOSWExb2thM0VkalZLUHIvTnNXTmJHNU9mNW9MbEVZ?=
 =?utf-8?B?WEhUOUFzMFcvVDkzRzdHa0ZIcm00OTNaL25MUm1VMFhCeHBjUithcHlOeXpu?=
 =?utf-8?B?VDUyanZKQ0VLWGFQYzlDT3I5TVd2YmxtZk5hYkh2bHcyZWx5Q3gwWmZaOWFV?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eddf64-af19-4728-a461-08d9aabd39e5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:59:54.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJRtNMYhU5iwzQ+YM+zARak6INchLIO8cEFblMsJN55X6s8/2W6360jtOd6zuFCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4418
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: v34CyV34MR_G2cbN4VvLFxOgzgTtLqmD
X-Proofpoint-GUID: v34CyV34MR_G2cbN4VvLFxOgzgTtLqmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/17/21 5:04 PM, Joanne Koong wrote:
> This patch adds the kernel-side and API changes for a new helper
> function, bpf_for_each:
> 
> long bpf_for_each(u32 nr_interations, void *callback_fn,
> void *callback_ctx, u64 flags);
> 
> bpf_for_each invokes the "callback_fn" nr_iterations number of times
> or until the callback_fn returns 1.
> 
> A few things to please note:
> ~ The "u64 flags" parameter is currently unused but is included in
> case a future use case for it arises.
> ~ In the kernel-side implementation of bpf_for_each (kernel/bpf/bpf_iter.c),
> bpf_callback_t is used as the callback function cast.
> ~ A program can have nested bpf_for_each calls but the program must
> still adhere to the verifier constraint of its stack depth (the stack depth
> cannot exceed MAX_BPF_STACK))
> ~ The next patch will include the tests and benchmark
> 
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>   include/linux/bpf.h            |  1 +
>   include/uapi/linux/bpf.h       | 23 +++++++++++++++++++++++
>   kernel/bpf/bpf_iter.c          | 32 ++++++++++++++++++++++++++++++++
>   kernel/bpf/helpers.c           |  2 ++
>   kernel/bpf/verifier.c          | 28 ++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h | 23 +++++++++++++++++++++++
>   6 files changed, 109 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6deebf8bf78f..d9b69a896c91 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2107,6 +2107,7 @@ extern const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto;
>   extern const struct bpf_func_proto bpf_task_storage_get_proto;
>   extern const struct bpf_func_proto bpf_task_storage_delete_proto;
>   extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
> +extern const struct bpf_func_proto bpf_for_each_proto;
>   extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>   extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
>   extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index bd0c9f0487f6..ea5098920ed2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4750,6 +4750,28 @@ union bpf_attr {
>    *		The number of traversed map elements for success, **-EINVAL** for
>    *		invalid **flags**.
>    *
> + * long bpf_for_each(u32 nr_iterations, void *callback_fn, void *callback_ctx, u64 flags)
> + *	Description
> + *		For **nr_iterations**, call **callback_fn** function with
> + *		**callback_ctx** as the context parameter.
> + *		The **callback_fn** should be a static function and
> + *		the **callback_ctx** should be a pointer to the stack.
> + *		The **flags** is used to control certain aspects of the helper.
> + *		Currently, the **flags** must be 0.
> + *
> + *		long (\*callback_fn)(u32 index, void \*ctx);
> + *
> + *		where **index** is the current index in the iteration. The index
> + *		is zero-indexed.
> + *
> + *		If **callback_fn** returns 0, the helper will continue to the next
> + *		iteration. If return value is 1, the helper will skip the rest of
> + *		the iterations and return. Other return values are not used now.
> + *
> + *	Return
> + *		The number of iterations performed, **-EINVAL** for invalid **flags**
> + *		or a null **callback_fn**.

I think verifier enforced non-null callback_fn, right?

> + *
>    * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data, u32 data_len)
>    *	Description
>    *		Outputs a string into the **str** buffer of size **str_size**
> @@ -5105,6 +5127,7 @@ union bpf_attr {
>   	FN(sock_from_file),		\
>   	FN(check_mtu),			\
>   	FN(for_each_map_elem),		\
> +	FN(for_each),			\

Please put for_each helper at the end of list. Otherwise, it will break 
uapi.

>   	FN(snprintf),			\
>   	FN(sys_bpf),			\
>   	FN(btf_find_by_name_kind),	\
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index b2ee45064e06..cb742c50898a 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -714,3 +714,35 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
>   	.arg3_type	= ARG_PTR_TO_STACK_OR_NULL,
>   	.arg4_type	= ARG_ANYTHING,
>   };
> +
[...]

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC145683E
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 03:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhKSCnv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 21:43:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhKSCnu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 21:43:50 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AILscnV004259;
        Thu, 18 Nov 2021 18:40:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AhW770tw/1AMtcQEJfCQW53dxj0SjdDxihG1dZ8Dzo0=;
 b=ScHCG8LyW77ICgteQJQoQ7EyR6IQWEmyuWYkFQpAhxfum43+XQ+ohniKIlkOO2utj8pG
 kFyZzOzBMS2Ycrphnrf7y+qVzpVueuaStI8LTX7HqLU7W9GPCjxiOb8AdFkCtCYERYH/
 GN3GGBN3slDbD9Y5qIJbAdo90Ba7WcHa59I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cds3f4n2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 18:40:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 18:40:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMEAKsL7uDOwj4IeFV1m3VxL3H0NZ0GCZDE0Ch9zzYzKCZXMyxWXCfSXsndx1Zf6IefLqaHySuPZ5EMlON/j/nY50uj/PL0F1By8bGdZ6jIDfxME4Cf9txeOunJ22efGBEXm6MvQswmdxZAZoqOlUfEhPH+TesQva/ojOupVKPSdQgu+fOMy9nfEVcwGTc2a0MUEHgAvuxqeUs8Tin5q96TeePbBEPBSgWRALDd4EiJ836irhMhy+ZBDNxAV03KxuZyxCzNuYaNJDalZXODSOxnGonSUbqlMIx5UR+TmjJfKZvzbHbIv2R3KA0eouKdyqZYOlA4JpbyiNok4hdbGhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhW770tw/1AMtcQEJfCQW53dxj0SjdDxihG1dZ8Dzo0=;
 b=Gq/yCk0aFtEGLEJj1Qs2VR5fNhmVlyKH9y+tcUh6LfySMVg95TdBull6i1greAr2MlTOikSvZH+GgDcJGX834msuEZqn6FMuaVLKe7NW4Q8cS/lrcjUMuFlsl52zX1NpldlYu+6D/gC7kU/dpMlHJBmPvQsOqjRgjbXpoADLROUlX8kQnceUaaby/po5dqlM/szy3z6RZsG5cNtVclRTTfhuKibORf5AowaBJd2gTFf/qbls24U3QlyqpRVFySzmRXpiz2A3FjtFrAC4m5V199qLEi7Hcs1N1Uy+toAaiW6RUVFF3KqdNkzVwOVV7sMb3OehNU1kdgP/BavLqKtyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SA1PR15MB5015.namprd15.prod.outlook.com (2603:10b6:806:1da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 02:40:32 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%9]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 02:40:32 +0000
Message-ID: <61ebdac5-5b12-8324-abc1-349f1445e95d@fb.com>
Date:   Thu, 18 Nov 2021 18:40:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH bpf-next 1/3] bpf: Add bpf_for_each helper
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-2-joannekoong@fb.com>
 <90ff8227-875c-1ef5-95e5-eee608c8658a@fb.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <90ff8227-875c-1ef5-95e5-eee608c8658a@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:300:93::13) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21d6::18af] (2620:10d:c090:400::5:8825) by MWHPR17CA0051.namprd17.prod.outlook.com (2603:10b6:300:93::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 02:40:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a73b5fde-5d86-4b51-541a-08d9ab05f521
X-MS-TrafficTypeDiagnostic: SA1PR15MB5015:
X-Microsoft-Antispam-PRVS: <SA1PR15MB501526756DE5B9BC4679AFFDD29C9@SA1PR15MB5015.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUzhY1lT1uEcvZh5wGIpdWsrsIK8lXCsd4mbudSOX2kxaILlbGnS9OGyF1+CbC/WlAogSEWuRyWTPYLWORREDDaZWyu/r+krItYLpPWfIM8S8uOH5acq4PR+5/4SkpCUvnNFMK8WXgFS0B3x765OwPA1yP1+OPsfSAiATOBJUn6edq61o1uMDRnapxk0x7FhxkD+RzVlvLKR4WITF99wXgi24kE/XksQV/6X4JlWn6ZPc8kB3YCLQAq4UT2uki+tGntzEdM1orG6CpQReo/SVPsFYRsmwB7h3dk0LzwuKDc/J7KjTq7lZkzqQhdw0tfhDjWmraIFHsudprU6UFkZpWizA348jTG8t5uLj8DDFupGEf8Umi453CnBqXdsuQ0u6/FTcpovxo853TZZg8nVp8Y15Of2EY1t4yxAyG1gtnrLyHcHK/WYwMyf/wRHFFC+BbnkevJIvWKPHeSy8En/22ip85qMLmLjtoeNRpa6SCNaB8E9FNCwQ5E0w3as2BZECy9a2369smYtX00VsirqNJE1FlW3xnG5nmIlGjGWfKBkg5Wjlb52/LLc99eT/CSEACgnAelXMPwPFlz8fBPlxRljTDne5jwcmLPBB+GfWBFhT0n1kBs72ZMyqL7FQu5IMKcGra/GLq1zEI+3o3Iz2ytBOM1Jd04+IyktItiSgXPa5jBrqoPQk0Ft2Saetd6Dqcofih7zaACvB6Nua1MQmxtizpLXAWZY1zPUYXvrbK9dd75TYpCAB/OHYMgG/IgQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(4326008)(66556008)(66946007)(66476007)(8676002)(186003)(31696002)(5660300002)(2616005)(508600001)(8936002)(53546011)(31686004)(2906002)(86362001)(36756003)(316002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FtVE1uZERkSEZDeUVLQ09rSHdTYkEwR3hFdisxR2pHVXBaSXdJR2lpb051?=
 =?utf-8?B?ZjNKcDFiVGduNGduVzlqYmM2RDRuTm94WE5USWNSWkRSWW5HMFpUbzk2QW5F?=
 =?utf-8?B?YmdFQTZaRERSTjdMeXE2V3BjSmlTYm1vZGR5b3VER01LNjRheTJ6am5XZHNI?=
 =?utf-8?B?Wjk3ZDZiakcvaDBTay9qNkNTNFNJNTFhQ3FPazFVQ2t4RkhPSm45bWhsLzZ1?=
 =?utf-8?B?T0crQmQzaHk2VjRLdGcxS0hpRzJhelZ3Qk9wTXpaakpPTk5MdzhvaUJDdHNZ?=
 =?utf-8?B?SGhHclB2c0oyeTZvbWYvZWNNTjQ0YTg3Vkg0Zk5SL2dkS3A1SnVVc3UrWlZK?=
 =?utf-8?B?d1RGU0tNb2diVnVMb1FCRlVWcW9BQzNWUHZVc29IRG40QnI3elczdDdtTWR1?=
 =?utf-8?B?RnVNd09yOWFpeE0rT2luUlozWlJ2Mkd0MlA2Qk5HUmtvcnhqZ3RxelByZVM2?=
 =?utf-8?B?TDJpQndTRE9zR3JJOWFMRnJCRjZ4RDNac2lyTnQ4UGVRVHlZa21XajVBNk5u?=
 =?utf-8?B?ZEpqWVh0MXFmQWtPakh5UFZhMDREY1cxeStjUFdHZmJ3UnVMUU96emxiT2JW?=
 =?utf-8?B?cXlUdHRQZnZGeldDSGxkZEtLVUdwMkk3WGVka2pkbEE1c0h5RnJxdGNNRVhh?=
 =?utf-8?B?VHk3a2JiWERRY0tYQnp5REtxWHN2RitMc2FTcE93ZVF6RVl6UVZ2NmRucFpR?=
 =?utf-8?B?Mk10MDFnRi9QTzh3NmxEZUJJcTdrcXVIekcxbHc2R3Fqd1NvZDhqek9SazNo?=
 =?utf-8?B?NjBSbEhubFpuU3pjRit2cTA5R29rN2N5cUZndnFKclA4bkplZmFHRE9US1o5?=
 =?utf-8?B?TUhpWXdZZTQzcWMzalorbGY5NEF5dEpVbW5KbWlxWE9jMTgzYW1KZHIxU25P?=
 =?utf-8?B?U0lUenJ4cHdZMDJTMy83OVBEWWVHV0tBYnhjT0EvcG1DRWpFRjdkTC9Ua2wx?=
 =?utf-8?B?VlpZdm1VSjNWRkhhL2tGS0EvVGpNQWVhNHdDaW53RHloVGVRWFNaQTFYdW9a?=
 =?utf-8?B?bEJkZk5VWmxodWt3Mjl4Y3NyeGVIeHp0Qzd1MW5ZVm93T1lwak1xUlZmTks2?=
 =?utf-8?B?MXpDSUhWMHhpeXQ2SXVJdGxVenJPUnhZTjU0WlhTcUtjRThXZkZDWjlKcjJB?=
 =?utf-8?B?Z1pHTmZLL0NxTVVuVW4rbUw3N1hsU2F3aWJvZVV6YU9WV0pVWWlvMzAzRVlv?=
 =?utf-8?B?LzRSeUJWMklXbjNtTGVmNDlRRWJLY0tPRGlrdHZrZWFRZFIycEk3d2FGZTBQ?=
 =?utf-8?B?U3NKWC8zWE5XRmJRQU5SYitWRUUreGFVYUIrdkpaMkw5dXl0SnI5SHpyRmR0?=
 =?utf-8?B?L2JJdEFTak03bGp5enI3akRSbXlnbU5TMEJ6dTdxdTAxSWVQcThMOHJrc1RF?=
 =?utf-8?B?OStwSjEycExoc0lpMmlaQVNBVFlrRjJPa0RsTHk3dVNaZ0VOU3dZQmRnZXV2?=
 =?utf-8?B?Ykw4bHVTdXhWWHpOTkZEQmtzaUM4eDJBdHlZalVoNURFaHY0V2E1eGZoekQ1?=
 =?utf-8?B?UE9WRkZBMVQ3UldYTDNBMVhkcklPalVOcFEyTFR2RG1zMGhJZkowRlpyMENh?=
 =?utf-8?B?cW52TFVUNnRpSDQ3N1ZkSktncU9rWDdwRE5rdnhLY1JCU0pmUTNKWExRQUlr?=
 =?utf-8?B?Uno5ekpLMWY3NFV3MGhVeDZsTWFjTGduOHRUb1luSlJkQ1JXd3RhYlBKNXZN?=
 =?utf-8?B?UEpCendDcUtLT3o4WkhkT2RiUFNVY2NBKzNSeFpKYlMyZkpJZHNmcGZXbzZB?=
 =?utf-8?B?NXVVZkJrUUtiNWNYZERjb1ZqaVhwTjVGVWhmWThndmdiWFl1SFhjM0p1cWs0?=
 =?utf-8?B?VndvQjhUeDg2d2hBRytXeUxDeXF0L2wyU2psVER2cytSalR4SHUybktIejVF?=
 =?utf-8?B?WDJUMTFCRXdFZWcxMGVkU0dzK0xsUUlmSkRielBsVWRudy9LeTZ1c05WSFZH?=
 =?utf-8?B?eVk5YmE0bnBESTc4cks5eFc0M21KaGJrYUJLODloV3krR09pN01JVC85RUZO?=
 =?utf-8?B?SDRxbzQwYktXVjBvVGpGdG4wTmJsSTNKaVRRdlI1VFhwTjNSbkM0cXNSTEQ1?=
 =?utf-8?B?bVMxbHAraTdtMFJxUXhjQWpMUUw4M0hJSVBlcHBlR0NRdGJqekJEdDF1ZFN5?=
 =?utf-8?B?LzVUWmEwRm9ReXV1Q3N0OFBwNGVWTURyNU45UG5ack05SklFbUVwbkI4T3Zl?=
 =?utf-8?B?MXZEcXlycUZ4L2dLYlh3N2pLN0lURjJGd0VvVThLU3ptR0lzbVo0K3JZZVZl?=
 =?utf-8?B?TlZrOTlYV1c2dkhBWmVZRWd4Rm13PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a73b5fde-5d86-4b51-541a-08d9ab05f521
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 02:40:32.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UexVGlRwIV0pGpJJV8xr6GV3jCrg5kZZ0u98xt6Mi5Lp/YXqkZ4Qqy9kwL+i/wmtFrmNtfGMtJNeva4fUASjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5015
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: dAbKHUD1yajL44QNvJhemkDwGxCAgiB_
X-Proofpoint-GUID: dAbKHUD1yajL44QNvJhemkDwGxCAgiB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_02,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/18/21 9:59 AM, Yonghong Song wrote:

>
>
> On 11/17/21 5:04 PM, Joanne Koong wrote:
>> This patch adds the kernel-side and API changes for a new helper
>> function, bpf_for_each:
>>
>> long bpf_for_each(u32 nr_interations, void *callback_fn,
>> void *callback_ctx, u64 flags);
>>
>> bpf_for_each invokes the "callback_fn" nr_iterations number of times
>> or until the callback_fn returns 1.
>>
>> A few things to please note:
>> ~ The "u64 flags" parameter is currently unused but is included in
>> case a future use case for it arises.
>> ~ In the kernel-side implementation of bpf_for_each 
>> (kernel/bpf/bpf_iter.c),
>> bpf_callback_t is used as the callback function cast.
>> ~ A program can have nested bpf_for_each calls but the program must
>> still adhere to the verifier constraint of its stack depth (the stack 
>> depth
>> cannot exceed MAX_BPF_STACK))
>> ~ The next patch will include the tests and benchmark
>>
>> Signed-off-by: Joanne Koong <joannekoong@fb.com>
>> ---
>>   include/linux/bpf.h            |  1 +
>>   include/uapi/linux/bpf.h       | 23 +++++++++++++++++++++++
>>   kernel/bpf/bpf_iter.c          | 32 ++++++++++++++++++++++++++++++++
>>   kernel/bpf/helpers.c           |  2 ++
>>   kernel/bpf/verifier.c          | 28 ++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h | 23 +++++++++++++++++++++++
>>   6 files changed, 109 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 6deebf8bf78f..d9b69a896c91 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2107,6 +2107,7 @@ extern const struct bpf_func_proto 
>> bpf_get_socket_ptr_cookie_proto;
>>   extern const struct bpf_func_proto bpf_task_storage_get_proto;
>>   extern const struct bpf_func_proto bpf_task_storage_delete_proto;
>>   extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
>> +extern const struct bpf_func_proto bpf_for_each_proto;
>>   extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
>>   extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
>>   extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index bd0c9f0487f6..ea5098920ed2 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -4750,6 +4750,28 @@ union bpf_attr {
>>    *        The number of traversed map elements for success, 
>> **-EINVAL** for
>>    *        invalid **flags**.
>>    *
>> + * long bpf_for_each(u32 nr_iterations, void *callback_fn, void 
>> *callback_ctx, u64 flags)
>> + *    Description
>> + *        For **nr_iterations**, call **callback_fn** function with
>> + *        **callback_ctx** as the context parameter.
>> + *        The **callback_fn** should be a static function and
>> + *        the **callback_ctx** should be a pointer to the stack.
>> + *        The **flags** is used to control certain aspects of the 
>> helper.
>> + *        Currently, the **flags** must be 0.
>> + *
>> + *        long (\*callback_fn)(u32 index, void \*ctx);
>> + *
>> + *        where **index** is the current index in the iteration. The 
>> index
>> + *        is zero-indexed.
>> + *
>> + *        If **callback_fn** returns 0, the helper will continue to 
>> the next
>> + *        iteration. If return value is 1, the helper will skip the 
>> rest of
>> + *        the iterations and return. Other return values are not 
>> used now.
>> + *
>> + *    Return
>> + *        The number of iterations performed, **-EINVAL** for 
>> invalid **flags**
>> + *        or a null **callback_fn**.
>
> I think verifier enforced non-null callback_fn, right?
>
Yes, great point - I will remove the "or a null **callback_fn**" part.
>> + *
>>    * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 
>> *data, u32 data_len)
>>    *    Description
>>    *        Outputs a string into the **str** buffer of size 
>> **str_size**
>> @@ -5105,6 +5127,7 @@ union bpf_attr {
>>       FN(sock_from_file),        \
>>       FN(check_mtu),            \
>>       FN(for_each_map_elem),        \
>> +    FN(for_each),            \
>
> Please put for_each helper at the end of list. Otherwise, it will 
> break uapi.
>
Gotcha. I will make this change for v2 and remember to do this in the 
future as well!
>>       FN(snprintf),            \
>>       FN(sys_bpf),            \
>>       FN(btf_find_by_name_kind),    \
>> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
>> index b2ee45064e06..cb742c50898a 100644
>> --- a/kernel/bpf/bpf_iter.c
>> +++ b/kernel/bpf/bpf_iter.c
>> @@ -714,3 +714,35 @@ const struct bpf_func_proto 
>> bpf_for_each_map_elem_proto = {
>>       .arg3_type    = ARG_PTR_TO_STACK_OR_NULL,
>>       .arg4_type    = ARG_ANYTHING,
>>   };
>> +
> [...]

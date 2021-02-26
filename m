Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A144325BE2
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 04:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhBZDXE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 22:23:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14940 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhBZDXC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 22:23:02 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q3Acop018968;
        Thu, 25 Feb 2021 19:22:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AJrwg2Ws6OFPa0HAnT+/92yEIZF3IBQeqHghSg092b0=;
 b=EceKhVQfAAebB/fUgf2IHXN4fI8l6jL+kE9fUf4AhgKfK7qHXLxlBQoxYuLrgzqYHB5i
 aXxrNp7p6Xrbk53zF/yDGcYH6bbJY8vlWODH+mAvY+T6537eNeplN3siPJqFG/PGaKtb
 H7b6/jh32l3F/uba4yXkf1SU3nyea3b85Q8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36wvqdh75h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 19:22:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 19:22:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luB7+lTRwx4fr8/cOMSCS/WZD9iQkqTjh5ivqhY9zgojz3Qgklpe6BDQdOpOzRKEDwJT3JzxGjnRnL7IPZN5x4s0r8JnSYxCdy+OpuLB5xku1ctxA6/4mVhq0AtEA8EaWsbjK8Lq4x73Sz+yo8DH5/AjrNAsQ10SQOq/9+I8PCiErZjHB13vYf3SpzkVbp/f8Kq+yENEK7L3Uf3dAH68+w512Gv7Iu8kJO1agWg4j1v80aqkyyvgdSHyi5CdQgpXsDnT6bMoK9RKm+mGh7LFvsZcqbWVVVjm+MJDOQLhJYma7KCZ3gavYPyCwDr6YsadePJqSLf0xx1fbK8SzO/Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJrwg2Ws6OFPa0HAnT+/92yEIZF3IBQeqHghSg092b0=;
 b=WPqfD84iuYwGP8KNXXqbY8v3noNbSM6FD5BW8T80F9YCxuUGVE+V95smPfqRfLyiyZrgDXPJgDgScG/6NCmi4e3Q3O9lztuOYL+8/7hzyW6Vx1x+Y3tU4mW+g72+sLiSO7XniXd1u/uJUjN3vxtIsQV62bem3GO4IdzWs1076XExE0owOHeHFJAsaymBspClYkk4RH2Vok6pOQf04Uf77WCtY5Hv8sUnJ7OdYaNjMnwF0jzERUT3SJENrh+JVVpSBnf3wWGTPHR6tw8tjUspDUcHTRaIlK/y94mHMigv94gnOZD/EAQaQ43l9ZN/e0NQSN3dihGvNSnCy8QQQIBZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2477.namprd15.prod.outlook.com (2603:10b6:805:28::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 03:22:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 03:22:03 +0000
Subject: Re: [PATCH bpf-next v3 04/11] bpf: add bpf_for_each_map_elem() helper
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
 <20210225073313.4120653-1-yhs@fb.com>
 <CAEf4BzZMCOi__1Y86AbQDD_=kgT22G10pJqzEVwF5r37M2CB6A@mail.gmail.com>
 <c042d2c7-a15f-c9b3-be7e-c729c1cf7184@fb.com>
Message-ID: <e02a20ad-4d1f-dfee-2dcc-a32d57cd182c@fb.com>
Date:   Thu, 25 Feb 2021 19:22:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <c042d2c7-a15f-c9b3-be7e-c729c1cf7184@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c091:480::1:1f06]
X-ClientProxiedBy: BL0PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:207:3c::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:1f06) by BL0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:207:3c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 03:22:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaef7118-dea2-4504-1f41-08d8da05affa
X-MS-TrafficTypeDiagnostic: SN6PR15MB2477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2477CDAF01B3D19E8766D1FFD39D9@SN6PR15MB2477.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aU7xG7kAA10yI1Ck2C5yiUeRMwyP4/RdC8BGEafRgqKWGfPSAxtZBhMF4+gIcKyio0gDEGErI92+FlRYWVQE1DZS9p4H5IAEHAUs1bX0051kbKJ/qGjEoSElpLbLbF8rIzEUb10FZsXhMLp9qn4/kf/QpQCQHKl7Q7qAOpsgDrxSHgKmEdCRhSrb86jxaAzgEHdTisslLzXo8UTzSe8zySjlg+Dq3oAAbphbRvYBCx9U2kndkUJYBJeovs9XX7SGRBGN7FtSrdvnstq4rzrcT86BjQrs13FEiDoXCPR7jL11hylRnjgkkfsWaJUqJfshI1y2nmI5zE+dtxxid7ZM4OKLpbfGZwAjv6shVzC1SwjzCPl/OaPFXwbg9sMDs4q4XbfxuROfBrVsTNIU9Nn0PDFveDhlr7jDm48h4kIV+8+IeSxzh0wDsUBqXr89Aeb2GPFgrz3qsZpggQlGiDUdKvK8S89sD1v6uQQqXyrHF+VjbSx4xnQPrVK64Zj/cbnibpmM4Hsje+xtjygQOQ3O3M31XGv/bu4KT3J7Kw7Obh3lPevzP6E64fgdn6c3fAspwI2RXLZ/WGwMaXRb88lDPQn4FdLdo02fBiZicBStC787crercChYS3L91EbAtrWhSas6GHXPlr9kKj0fVsWBw+4tD45qgDivS2OmcPwhN8eRhaqsu9JzdZcZN/JlBpKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(366004)(136003)(53546011)(8676002)(31686004)(6486002)(86362001)(186003)(54906003)(8936002)(4326008)(83380400001)(2616005)(36756003)(2906002)(66476007)(6916009)(31696002)(5660300002)(316002)(478600001)(52116002)(966005)(16526019)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2UwVHZUVFNoTUxSOEp4cVY2Ti84RXFUMWJiMEVXa2RWaUhET29COG5pUW9u?=
 =?utf-8?B?RE5BQWdYUDEwc3VyV2NBMWpVMStsUE9UazltbE1FNmpZaFR2Q2FTOHd3UUVy?=
 =?utf-8?B?dVQ0dngzRjBpWSsvekxCeHBoM0lKYWQ5QkFQUEk1Umtjb0wxSGhIRVJuYUtQ?=
 =?utf-8?B?UzRzU1lyb2dTL2NDRFgraFgzemZWYW9kZEl2VzMvWjFUKytuVzNlNVhsZDJr?=
 =?utf-8?B?VithWllZTXM5eHpsd1pCcW9xYVY4cmsyZTliRThENVMxUENxemZVbk9BV3hV?=
 =?utf-8?B?NXA0Smk3UnZaZUFEcXJWQjlreVRHb1h6ZU1PYzNvV0NrazZFRWg4T1hFRTIr?=
 =?utf-8?B?bDBnT3NyemNYRWkwbEQzRDZNWldwd3dhbjMrZWFnYTQ3Tk5qUm9TWVdocVJF?=
 =?utf-8?B?bTlJN2hxTDdPTEpkNlFycjRtVFFhRDRkbkR4N25pRWx5Vm1kK1M3ZHdnWFRY?=
 =?utf-8?B?LzhEdEhBU1cxUVBPdEMzTEc5d0RjQ05CUzNoM24rL0ZySEY5bktVaUZMNERG?=
 =?utf-8?B?eXUyVk9sVVo3M3QrOTNaYTN3MW1pMlZSUGFrbDNRNFFiZnVQZUE0eThrdnhs?=
 =?utf-8?B?WE51M2V4VCtiM0NRVmM4K1J4SytkbXhHZ0JkQzY1OUNSa2FkWFVEbkRjZUd2?=
 =?utf-8?B?SkhEL2pyUEZqcWhvalp0UWdZOEl0VVkrbzZpVjRIZmd0TzRuNDBDNUpNUHNz?=
 =?utf-8?B?Zm1ya0VFOUlkaUtJb01yZ2VMWDJ3NzhVaUdtb0NPYTFNLzl2a1pzQkFwOEdP?=
 =?utf-8?B?UTVqT1drSkFFUjMxUnZycWgvck5qN3lYWUVSd05sbUplNGNWb1gwOG5BUjBL?=
 =?utf-8?B?YlU3VnE5RE5RQkEzTm5BVEE2bjJ5dklQMjlBTngvOGZFbWJRTzVPS0JaVm1G?=
 =?utf-8?B?WEtRTGlYZC9LMFo5UG90OEpBa0tPNlFYV3owdkswU0drNWRMVVlmZWYrWGpM?=
 =?utf-8?B?MXVnSzZ0UW9yYVRDVTlGSktENmNsd2hGSmZiZy9pS283TDJ5N1A1a1hWNnRL?=
 =?utf-8?B?cDhxUVF6NCtTVk5yNm1ZVXh2MkxabjFxQTB2YU9MZ2E2eGhjMzV0eE5jZ2F5?=
 =?utf-8?B?a0ZraTl1aHdMdnV2ajRPK0ZtTWJDaHBqcUpVYUZ6K1Faa2EvV2YrMEVqZjJr?=
 =?utf-8?B?dkV1UUNtcFhEU28vTlcwL2xkMTZTU3NHeFNjQmU5SVU0eEM2SURVenluc2U0?=
 =?utf-8?B?MmczaXZnb3Nzb0JLWlZ4VnU2RUpORGdpeDd2RktWdjl6MjFENEMzRHMwSmsz?=
 =?utf-8?B?Yk9EMTBVcUFLRjdaWHU4MklSU1VnTHRpNnAzVWFwZSt6MkVtUnd5MlM5Z0JB?=
 =?utf-8?B?c09wckNQdzdTb0tUNjNrWVVmNFFnTDVvaVhjdmQ3V211akFCY1BadTdDZ1Vx?=
 =?utf-8?B?SysvQzgyNkxrMGZwVzg0K2srelk4T0VyT1hwWU84Zk5VRVNpVCtSdklSWkM0?=
 =?utf-8?B?V2NLcnlkRFJMMGhqcmtsQ2FpVVpIN2FEYjFDT2J0U29jamM0bnhicHc4d2tI?=
 =?utf-8?B?VC95RFlpc3VZRjl4b3Nucmo3b21OdURZZ0ZFbTRsUE1xREgyKzY4b2JROTFj?=
 =?utf-8?B?cUN4MGFsRHpsOExKS0VPNzcyZGE1c0V5YmRQMVJEcG1hOUcvdFJEK2RHVVRD?=
 =?utf-8?B?T0grK1NPb28rL29EUDBOSjN6MlBRdmJCMU51cEpycVZoOWFaR2lsN3UyUDMw?=
 =?utf-8?B?b29MYTAwNHFjd3ZxOWhUQlFldStwRUIvV1VEaHhQaElkeDBzQUxFdnJjYkZL?=
 =?utf-8?B?UTBzb3liUDFGSEFQMTIyL3hYYU1RN25rdFlhRE9lQXZib0p2S0tYMFhTVHV0?=
 =?utf-8?Q?tZYNJRL8g2fgZ0dXpKWWGVH2YD6jBuY86vb+A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaef7118-dea2-4504-1f41-08d8da05affa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 03:22:03.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk3XBJ2ue8QxIwkRCF7PbDUV0XYsoE5Lbj/exQ0RRBnoJw0Zjwf7MLg7bEoDfNQx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2477
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_15:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 6:16 PM, Yonghong Song wrote:
> 
> 
> On 2/25/21 2:41 PM, Andrii Nakryiko wrote:
>> On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> The bpf_for_each_map_elem() helper is introduced which
>>> iterates all map elements with a callback function. The
>>> helper signature looks like
>>>    long bpf_for_each_map_elem(map, callback_fn, callback_ctx, flags)
>>> and for each map element, the callback_fn will be called. For example,
>>> like hashmap, the callback signature may look like
>>>    long callback_fn(map, key, val, callback_ctx)
>>>
>>> There are two known use cases for this. One is from upstream ([1]) where
>>> a for_each_map_elem helper may help implement a timeout mechanism
>>> in a more generic way. Another is from our internal discussion
>>> for a firewall use case where a map contains all the rules. The packet
>>> data can be compared to all these rules to decide allow or deny
>>> the packet.
>>>
>>> For array maps, users can already use a bounded loop to traverse
>>> elements. Using this helper can avoid using bounded loop. For other
>>> type of maps (e.g., hash maps) where bounded loop is hard or
>>> impossible to use, this helper provides a convenient way to
>>> operate on all elements.
>>>
>>> For callback_fn, besides map and map element, a callback_ctx,
>>> allocated on caller stack, is also passed to the callback
>>> function. This callback_ctx argument can provide additional
>>> input and allow to write to caller stack for output.
>>>
>>> If the callback_fn returns 0, the helper will iterate through next
>>> element if available. If the callback_fn returns 1, the helper
>>> will stop iterating and returns to the bpf program. Other return
>>> values are not used for now.
>>>
>>> Currently, this helper is only available with jit. It is possible
>>> to make it work with interpreter with so effort but I leave it
>>> as the future work.
>>>
>>> [1]: 
>>> https://lore.kernel.org/bpf/20210122205415.113822-1-xiyou.wangcong@gmail.com/ 
>>>
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>
>> It looks good from the perspective of implementation (though I
>> admittedly lost track of all the insn[0|1].imm transformations). But
>> see some suggestions below (I hope you can incorporate them).
>>
>> Overall, though:
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>>>   include/linux/bpf.h            |  13 +++
>>>   include/linux/bpf_verifier.h   |   3 +
>>>   include/uapi/linux/bpf.h       |  29 ++++-
>>>   kernel/bpf/bpf_iter.c          |  16 +++
>>>   kernel/bpf/helpers.c           |   2 +
>>>   kernel/bpf/verifier.c          | 208 ++++++++++++++++++++++++++++++---
>>>   kernel/trace/bpf_trace.c       |   2 +
>>>   tools/include/uapi/linux/bpf.h |  29 ++++-
>>>   8 files changed, 287 insertions(+), 15 deletions(-)
>>>
[...]
>>
>>>   static int prepare_func_exit(struct bpf_verifier_env *env, int 
>>> *insn_idx)
>>>   {
>>>          struct bpf_verifier_state *state = env->cur_state;
>>> @@ -5400,8 +5487,22 @@ static int prepare_func_exit(struct 
>>> bpf_verifier_env *env, int *insn_idx)
>>>
>>>          state->curframe--;
>>>          caller = state->frame[state->curframe];
>>> -       /* return to the caller whatever r0 had in the callee */
>>> -       caller->regs[BPF_REG_0] = *r0;
>>> +       if (callee->in_callback_fn) {
>>> +               /* enforce R0 return value range [0, 1]. */
>>> +               struct tnum range = tnum_range(0, 1);
>>> +
>>> +               if (r0->type != SCALAR_VALUE) {
>>> +                       verbose(env, "R0 not a scalar value\n");
>>> +                       return -EACCES;
>>> +               }
>>> +               if (!tnum_in(range, r0->var_off)) {
>>
>> if (!tnum_in(tnum_range(0, 1), r0->var_off)) should work as well,
>> unless you find it less readable (I don't but no strong feeling here)
> 
> Will give a try.

Will keep it as is since range is used below for error reporting.

> 
>>
>>
>>> +                       verbose_invalid_scalar(env, r0, &range, 
>>> "callback return", "R0");
>>> +                       return -EINVAL;
>>> +               }
>>> +       } else {
>>> +               /* return to the caller whatever r0 had in the callee */
>>> +               caller->regs[BPF_REG_0] = *r0;
>>> +       }
>>>
>>>          /* Transfer references to the caller */
>>>          err = transfer_reference_state(caller, callee);
[...]

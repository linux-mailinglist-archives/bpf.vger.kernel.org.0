Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1472A325A94
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 01:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhBZAJG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 19:09:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8070 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229566AbhBZAJE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 19:09:04 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q04d3v011219;
        Thu, 25 Feb 2021 16:08:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aq3pGmzkjb5PAcQsWdfSWBpV3VxSnfpgOXsQ48bM1qA=;
 b=izgsu0nX3ZGoT3jj6WcBtb4JpqVyUPC4OV+bUg5ECjk25vJIuUkW3PSn0LfN0LtQWUW9
 dcu3UZyrIXbb5duvdayLqfkMDM8gK2XzReeRATK2qjbYzzHkYMlFkIsTqe2T+XgSKHPT
 Cbkj2Nv1d3Rp6AsO9JIis75/8V/kg1gmfH0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36xkfk8utn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 16:08:09 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 16:08:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qkns8fJPazWxmdm2QLrQPZj+UElqY2Eko2wEvN6aFXtiuQ78U3+aSaV0LPKDkR5tKj085wRoSjDsNt9C2wwpa7gKoPMTTOg61RP9mSodJ3WkE/tRihm5RTievkGFjTm+TYmRmi5JUoTPfgp3zgpCRl2VSLFGPYAlM1U6WyJ3dxQvMqAtj54h/ZPkygM7uTCFbjhs/jgOlLGbiVmmBKeAp/DProRKBDRStezDzfojEhoG0N2vHRaLWEwRu9KeF82MVt8wUbSiXv5jTqYdIs9ixI+eJPfSqwgJUZtmzhJdsPMh8RRNPvfN5J7RYPjNIMfzgqhMWZSvYW7+PPBCXce+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq3pGmzkjb5PAcQsWdfSWBpV3VxSnfpgOXsQ48bM1qA=;
 b=S+jdavqk6MywdkrOAtxceTknMYw2NcKhLZSUJwwAz6Wnt2fGpzX9wE3+k2HarWvNcmGCExBJtOlWmWcNXQW69KKYWLV/PMxqz0P/c9H1y3sCYh7yBl0ZCMirFZcOnQlrjmi04zaowpLwBK9VkzuB/NiEhr09DY+KgBOzUwRibe50FnmXTO/Fruz8fDHj1xINLhNWA1ntRhHg41yHKZqPDW5RnO277nWpsGvJRfzNnq1svuPGcjrL70eeg7wORKc8D1WTjS7TgN21bH3n/Ds/smnKpbCvUhtF+2BmUTJX18DHtoJOi11pRR7Jg0JbHJPV/Jqi9A7BdLgM9hSq1Q+VXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3760.namprd15.prod.outlook.com (2603:10b6:806:84::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 00:08:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 00:08:04 +0000
Subject: Re: [PATCH bpf-next v3 03/11] bpf: refactor check_func_call() to
 allow callback function
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
 <20210225073312.4120415-1-yhs@fb.com>
 <CAEf4BzZn125xN0p=mUvAfFzq+Pbequm9Yp0rSN0B=ru4X8X8Jg@mail.gmail.com>
 <CAEf4BzbdNTc4wqnhPPhfQeO0rARMHNocZ28xgR6cY1OVDAti1w@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <097fc269-07d8-1610-970e-a72900dae71d@fb.com>
Date:   Thu, 25 Feb 2021 16:08:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzbdNTc4wqnhPPhfQeO0rARMHNocZ28xgR6cY1OVDAti1w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:6469]
X-ClientProxiedBy: MN2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:208:134::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:6469) by MN2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:208:134::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 00:08:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2e077d8-9ae8-4277-6d6d-08d8d9ea96ae
X-MS-TrafficTypeDiagnostic: SA0PR15MB3760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3760CE6B58B8B65FAA80377ED39D9@SA0PR15MB3760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxKh+XL9NZ94iUu7RfGnBc0wj3p74GwhBjrB8dIfkV2ONQOdMFYBVfc51QPLWByzUpguZCv7/mYJg/0XxBtxQqyoLv9iKf/ixgQKIm+2L5gqM3xoYLI1FAxonF5/D77ica14eusqOq953//1lluRVkdOHsXecUHg5VMrnZBpPlp4bOoqbCRDC8zIlROmgg+g6Z2MCN04dQzmxwpGr/0eIIpLUZI+INjBFbw1fhnyXi1phjFqwO7TZZGo5jlYPhc4zi70LEPpZ5o1XnwrFsvZ3wCRP+mPQMwY47xexRyir7xewC4rHX5/mNG+ttBM6gSEz8TpxQQFiR315s2DaG7NJtTsFYNlHhfN4bI/dRFP2aiUMnJclEUx5MrEuG0A23f83OG+REQChsMlnV9gCbWXFVDrxPvV/km8nC218aCJTpOv1NnRPhJkvOzo/Zr6Bc7o709d5hDiAfZfWzKoCMrMhLbrMmUQsIO0eozo0Df//yNbKi6nbcBK0thq373tn9lbUwHFjJuNfVa7QG0w550q4PGYlg39ezLf1jkFNzy61yMAXrnQdfJKMGhxXeN+dhj/JrkYP8i4bkvDk7ip8XWzfpjne+SQ58whtynUxXTgSdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(31696002)(66476007)(16526019)(186003)(36756003)(5660300002)(83380400001)(478600001)(6916009)(66556008)(6486002)(8676002)(8936002)(2616005)(316002)(31686004)(53546011)(2906002)(66946007)(54906003)(86362001)(52116002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZitNTlhEVE5GZ3NFTkZJRHg3Tk13eGtUQlVLdlMxQ2dVUW9obU5IKy9wdmxG?=
 =?utf-8?B?THdZL2JIcnRpM2x4Rko5ajBSVk9JWitldTdDUWlIajRlNjJjcUwrWVVrdlVQ?=
 =?utf-8?B?bGQvcSs2bzJTdStrZ2M1aGhZOTlMK0MwWjRGTlpLbkNtZjloUTFuQ1JPdlF0?=
 =?utf-8?B?dXhnSXByaG1kYVhSOWNWQ2dwMHNDT0h1KzBsUnJoNUhXZmJ4ZEgyVTVQR2RG?=
 =?utf-8?B?aTYwM0dlSkdKTVErcmpOZ3FIK3QycnhjejRadnNyKzdQdk8rTlFGVXkxS2No?=
 =?utf-8?B?OWl3bEQ0bVlNMzdVWkk0VkRyZzhvZTZpZ1JEUDBTMUY2ZVV4MDVoTDc3QWtU?=
 =?utf-8?B?Mmp2L0M2WEtpS1MvcytMQXVzQlM3UC9vZ0RGVW1udnlCSWxldzUwQ0dVZTNY?=
 =?utf-8?B?bzEwSHR1c2k1S3dsQ1dWRGNQb3JNclhOMHRiRTQrNEo2UEVDVjg2L3pRYWNr?=
 =?utf-8?B?QkJzQnA3bGM2RHhPUDJFTy8rR2hPcmJmOFFZRFRkLzdLWEJocWJrQ0dQVTJz?=
 =?utf-8?B?NFB5eTlRUTZWSmVHbUY1cWlaR3NiTk1ad2Y5cFZ0U3JqQzd1cm9Ic2R0Zml5?=
 =?utf-8?B?b1lSalk1bWhRMVpIVVVhbGFISHJYYUcvMU9vU3FzZWNGY2J4TDNUUTZzNkJ1?=
 =?utf-8?B?bnFyUjRCMkdoWTVxSlA1Y2tEeXNuejh0bjR5WDMraWhUMmlSVERVQVFqRWFG?=
 =?utf-8?B?Zk9icGZySHJuRnVJZmhaZ2JDOXNBeHRVcVZmM1kvcDI3UE1PSW9PUGNDTjVh?=
 =?utf-8?B?U0hzMklENEVXR0NEQW1FS2R5ODNmR2dZekNsbXl2Z3k2TTBFWUkzK0lqdk1M?=
 =?utf-8?B?eUU2T0JvTDM3bkxFaHJkNERXUEttZUhCZVhMWC9IRHRIbGMyNGF5Zld2Mitx?=
 =?utf-8?B?NGdKeGZ6QmR4aUVsUEZndTNtS0ovN0t6Q0Era1JnN0EwcnFqb214SHZsS0g4?=
 =?utf-8?B?WjQxZ0E1MDUyWFJZNnYzL3hjc3IydzFXaWhsRVMxRVZkck9FejlwWU9VTy9j?=
 =?utf-8?B?Y1VxYVc5ajZPbVVkcE8yVlRLM1VJNFM4TmpBTlg4anplYXdMc3lGK3p3ZGZu?=
 =?utf-8?B?cmdQRzFqZ2s5Y1Y5MVQyYStLY0o4cWdzc1ZLMjBhTFBDZURIRUJibTgwRTNH?=
 =?utf-8?B?bVhrUEJZQkJDN09oTjc3b3laSG4xaW8wTk9VTDY2RSt6bzRRQ0RyUnVCeEI1?=
 =?utf-8?B?Z3ZEb2F0dGQySTdKVG50TXZxQm44Q1JGdVBRL2JoK0MwYU1reXhNNndMSEhR?=
 =?utf-8?B?QUVxWkN2UURVUWVscnZKZDBVQ0x1dThFSExPMFRVaWlKY1dTbjFscnVzTnFR?=
 =?utf-8?B?UVY4TUVmalVhVmp0cUpHTy9ndXFSeFdSQnBoUHJiZGI0UjhOOTF2Tnd2L0t0?=
 =?utf-8?B?bW1oS0VkcGdsYzZwU0dqTlZWY0NVRVZLZ2IwTEdCOUF3Q0RSdUdLUkJCTUJV?=
 =?utf-8?B?cnVUVllPZjM4TllTYmNPakxyaWJRazA3S3NLM3YwY1J3ZFZMN1JabUROdjl3?=
 =?utf-8?B?V0RpUVJ4ZVB5Tlozd2hrYzFycmtvOWlNVFNKRmIveHF5RkJtQ0tJb0kzenlI?=
 =?utf-8?B?b3BzOGNhcng1QzdpSXcwaTV2VEZEZjhYRXBVNFNDWEtkY1ZTaXFvL2lmSUJJ?=
 =?utf-8?B?RkxNOXptc0tIVm1PK0w2UXM2aFhiWDlJUlJOSS9xeDA5cDBlbVpqRFQzVVF3?=
 =?utf-8?B?aTkrL2xreFlBMzdUcmw4K3JOYkl5cWJHTXg2Qmo0TE1IOWliNEkvTVhkQzc5?=
 =?utf-8?B?eGZVNWJzeDJqTDFWRHdiWWwvc01ZcFl3V25XYzRQdU81cXpHaHI1aUk3TFU2?=
 =?utf-8?Q?XDVjxPT4VXkbVFykGsV16QbPAGAwEzGhepwy8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e077d8-9ae8-4277-6d6d-08d8d9ea96ae
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 00:08:04.7562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgLyWIHYWw9+NPtJlmRIJq6Q2ic7VunWB9B/BhlI6IA7c0yp9hpN9qj/+Hs8KPD3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3760
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_15:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250184
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 2:31 PM, Andrii Nakryiko wrote:
> On Thu, Feb 25, 2021 at 2:05 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> Later proposed bpf_for_each_map_elem() helper has callback
>>> function as one of its arguments. This patch refactored
>>> check_func_call() to permit callback function which sets
>>> callee state. Different callback functions may have
>>> different callee states.
>>>
>>> There is no functionality change for this patch except
>>> it added a case to handle where subprog number is known
>>> and there is no need to do find_subprog(). This case
>>> is used later by implementing bpf_for_each_map() helper.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++-----------
>>>   1 file changed, 41 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index a657860ecba5..092d2c734dd8 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -5250,13 +5250,19 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
>>>          }
>>>   }
>>>
>>> -static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>> -                          int *insn_idx)
>>> +typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
>>> +                                  struct bpf_func_state *caller,
>>> +                                  struct bpf_func_state *callee,
>>> +                                  int insn_idx);
>>> +
>>> +static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>> +                            int *insn_idx, int subprog,
> 
> ok, patch #4 confused me because of this `int *insn_idx`. You don't
> seem to be ever updating it, so why pass it by pointer?... What did I
> miss?

We do have something later:

         /* and go analyze first insn of the callee */
         *insn_idx = target_insn;

which is the old code and probably did not show up in the diff.
The above statement changed insn_idx such that when done with
examining the func call, the control will jump (*insn_idx)++ instruction.

> 
>>> +                            set_callee_state_fn set_callee_st)
>>
>> nit: s/set_callee_st/set_callee_state_cb|set_calle_state_fn/
>>
>> _st is quite an unusual suffix
>>
>>>   {
>>>          struct bpf_verifier_state *state = env->cur_state;
>>>          struct bpf_func_info_aux *func_info_aux;
>>>          struct bpf_func_state *caller, *callee;
>>> -       int i, err, subprog, target_insn;
>>> +       int err, target_insn;
>>>          bool is_global = false;
>>>
>>>          if (state->curframe + 1 >= MAX_CALL_FRAMES) {
>>> @@ -5265,12 +5271,16 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>                  return -E2BIG;
>>>          }
>>>
>>> -       target_insn = *insn_idx + insn->imm;
>>> -       subprog = find_subprog(env, target_insn + 1);
>>>          if (subprog < 0) {
>>> -               verbose(env, "verifier bug. No program starts at insn %d\n",
>>> -                       target_insn + 1);
>>> -               return -EFAULT;
>>> +               target_insn = *insn_idx + insn->imm;
>>> +               subprog = find_subprog(env, target_insn + 1);
>>> +               if (subprog < 0) {
>>> +                       verbose(env, "verifier bug. No program starts at insn %d\n",
>>> +                               target_insn + 1);
>>> +                       return -EFAULT;
>>> +               }
>>> +       } else {
>>> +               target_insn = env->subprog_info[subprog].start - 1;
>>>          }
>>>
>>>          caller = state->frame[state->curframe];
>>> @@ -5327,11 +5337,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>          if (err)
>>>                  return err;
>>>
>>> -       /* copy r1 - r5 args that callee can access.  The copy includes parent
>>> -        * pointers, which connects us up to the liveness chain
>>> -        */
>>> -       for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>>> -               callee->regs[i] = caller->regs[i];
>>> +       err = set_callee_st(env, caller, callee, *insn_idx);
>>> +       if (err)
>>> +               return err;
>>>
>>>          clear_caller_saved_regs(env, caller->regs);
>>>
>>> @@ -5350,6 +5358,26 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>          return 0;
>>>   }
>>>
>>> +static int set_callee_state(struct bpf_verifier_env *env,
>>> +                           struct bpf_func_state *caller,
>>> +                           struct bpf_func_state *callee, int insn_idx)
>>> +{
>>> +       int i;
>>> +
>>> +       /* copy r1 - r5 args that callee can access.  The copy includes parent
>>> +        * pointers, which connects us up to the liveness chain
>>> +        */
>>> +       for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>>> +               callee->regs[i] = caller->regs[i];
>>> +       return 0;
>>> +}
>>> +
>>> +static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>> +                          int *insn_idx)
>>> +{
>>> +       return __check_func_call(env, insn, insn_idx, -1, set_callee_state);
>>
>> I think it would be much cleaner to not have this -1 special case in
>> __check_func_call and instead search for the right subprog right here
>> in check_func_call(). Related question, is meta.subprogno (in patch
>> #4) expected to sometimes be < 0? If not, then I think
>> __check_func_call() definitely shouldn't support -1 case at all.
>>
>>
>>> +}
>>> +
>>>   static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>>   {
>>>          struct bpf_verifier_state *state = env->cur_state;
>>> --
>>> 2.24.1
>>>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53713325A8A
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 01:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBZAGa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 19:06:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52132 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhBZAG3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 19:06:29 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PNw33x027180;
        Thu, 25 Feb 2021 16:05:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QkNVKpCv/bPgp5LKn5K1DB99ODE6aJpeU/6NaIjhFJk=;
 b=d0wRqwE6q/3x6Yq2Mwxc9VryFHi6SUdV/QWIJFcRXXIWymdpeVEbskmzl8JWeXviV+/Z
 J2tyyc5wNs1rJp5WSeUPE7VnrAxdIa1SMXsPBG+nwJ72RQ/fjwLY0QZko34S3V58Y0qt
 CDp2kbYlXdDmdBczGioN4yDhmRaRauQI9Fg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36vx7s9tbe-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 16:05:36 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 16:05:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9AJrsr2DmCqM91pDxmTrYccFE63WIc1ABJ8J9408Nx8KZT8mdtogSLRXPiGlHnTOFB9wcuPR5AE1bQuBSfLsREBwZvwlJ3v2jQNywvpggvxNyd8JzIousAYYRqt5tXG73SsuAG6DI43U+POUaFYRMU3K8pGr6sc5TCrawW53WgldxVXpGk4Pu2cI6vbHwZfiZf8fArz58XnUYWvTIJnTgdid7eDGzIMgocJFvOTudTaPq7X/ZzCnOcRyFjtJ0yrnjtCVnVJiDp6dLXHR2KI4n2g7ejoHQupOpDcHhOWtFjgyzeDLlEL0KXO1zaC9+sSSQrttndIaDU8vX2lYrMsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkNVKpCv/bPgp5LKn5K1DB99ODE6aJpeU/6NaIjhFJk=;
 b=kT/1BsbKwmjr5LQVzS1hh8FA2TxylEJ1plfFE/FiZm1+ARYsyWT+1IgfTzN/NB3daC3ApiZjs/5UuuuP568iqeyIrklqA4telF3MsLMCZ+t35oKmzevAhtGhOtGhHjZQlJq9fxoJ96orw4dhYhhaRbkFAZNYGpfD7q2jB4IcSdOzULiyokV75kRChNv53zhpWEYVs7AK08Tv2ljVRmaqZmKioOp/Ukfrsiid8Z4pL9kyEauAAHCt1pMGcCvd8Nnyc6Icv/aulpqjjcTNLNl0VF9Qd14sXqRmRSTbj2UYmEHkKYHiyIZWfL5br6lGxOtqAhe9yeob8gdhQaJkLIiYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4737.namprd15.prod.outlook.com (2603:10b6:806:19c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 00:05:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 00:05:34 +0000
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <76c89d0c-f239-98d4-8e3c-32e7bd20aab3@fb.com>
Date:   Thu, 25 Feb 2021 16:05:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzZn125xN0p=mUvAfFzq+Pbequm9Yp0rSN0B=ru4X8X8Jg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:6469]
X-ClientProxiedBy: MN2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:208:23b::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:6469) by MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 00:05:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93df615f-fdaf-487e-b54c-08d8d9ea3cfd
X-MS-TrafficTypeDiagnostic: SA1PR15MB4737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4737111F38176D9BE95877A8D39D9@SA1PR15MB4737.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7X5vVC4axIQJQCVNfHM18QngXEIL5Bm3VnOsVIan7dKeIQ5shKDk+66ns1dPvytV2u74IUJ6d9rmmmt7H+V6m4pSXJLLzJ/vPztqVkd5gBfKg4DrKaIWZlxwzycoVs59tWmP0433RQL6xIxRJIxWxUiGI4dDpTHVYS4hCMR8EEiTLWx8YethFQHBDKr8YEmTAh4YCcEpDp78TZIHVCeqsNIC1v78eTEX0zi54NgUQ+Z0Tqs6lAC53il/1hoFo8dRFMbdNykJIajuKubg8lmX5ivtrDjP4espqixyws4rOEyUkgHv+uSesJVzrnFNJaYTCLisNpDHlV/8GFpqaPndVyG1Olx84FRzP1U66EVC8WbG34QSXv6vIw4QG1WLZb9sKGFwkKmB/AyacP7kciyAXXbnpg0yw8Jhp2hMYqLZt/ldgmjgVq50IQQJN9vxzDu2fCukMgbgrYhmkYqghZEeUkX1SMz2STMPOgEN0nA/zmhpYisnbMYrLiLS7WyiKGq13ARGNbQ4drp36AFlwc2OiiQ6zXELPD4t0JKDv/1TS2wBQazO2fyzbe/3rnD+lkdCgMiyKToFoaA4mU5lq4lmHtB++ji1brz1uhQvgB6cBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(66946007)(36756003)(66476007)(83380400001)(186003)(31696002)(6916009)(6486002)(66556008)(2616005)(16526019)(316002)(86362001)(5660300002)(53546011)(52116002)(478600001)(8936002)(2906002)(8676002)(31686004)(4326008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K0ZEdlNzbm9iSDNwM0RzbWROZGhKZ1g4cGxwU05QMjhZZ1hZRG5HZS9pQUhU?=
 =?utf-8?B?bWRJK2FlUEMrS0MyOGIvUUtnZlBmRTdVS3NxY1VEWk83cFFkRFVQQzJ3dE81?=
 =?utf-8?B?Ly9iSnZ5WGxuRncyakJqWmxoSC85SnVyZ01RVXZCVEp4QmYvaFUvQjIzR3Zj?=
 =?utf-8?B?bXBCNjJPOSthZWNxVGxzbXJscUl4cVdScGg3N1c0c2VVSk9HWDhveVFDWWdq?=
 =?utf-8?B?N1pKZS9hSzVndExkSnZIR0pPWkRxUWw5Zmw3a0k0c3AwMzRNdnEvRDN0RjZt?=
 =?utf-8?B?STczZnAwMWs1TjZrNWRaSk1uaVZVNnNnbDRsRU1IZ29GcERSQkl1dE9IVmRQ?=
 =?utf-8?B?aG1BVU1SVEV4cHJOekZVcWl0YWk5RDJCakhQUVE5OElmWXdHdlhTQ09mdmtp?=
 =?utf-8?B?ZEdGRTB2ZnZsNVE2dTdhQXdXTFBYRmdQZERPei9qWmxKcTZuWVZYMFZvZWpQ?=
 =?utf-8?B?SURlMUFVeG5DNzkzSEpwdStnNDRQR1JINGZkUGVIYkRNbTRNQ3NwNWhESytN?=
 =?utf-8?B?YXU0K0hkakxDU1hPbHhVUU1scTBVOEgwOEVjb0JoUVNUa2dmK2I2RG5Zcmx4?=
 =?utf-8?B?YXRzcDNWRzR5ZHEyNGtLOU9aMHNqem93b0NaZXhydWtlcXplT3Z0UGlxa3dO?=
 =?utf-8?B?dXRiUFZhK2RTQVNOb3lMNHFMR2VPTkhTTVpXY01oZGtCKy9yQlBGTHZXWkpl?=
 =?utf-8?B?S0RrS1BRRmdDM1pxdG5BRGdTaDkyVm00aTgyMk1NNVEvRCs1YjRXbFJFOVF3?=
 =?utf-8?B?Rll3Q0F5alJ5ME9hNFFaNWRUd3dWWTY0MExleXFZUHE1SG9lLzFoUTN4NzRE?=
 =?utf-8?B?TW1WSjhrT0RQY01EOVlUOXhDbnFvTG1mV3RNc1Z3SE02ZWpJVGZJelpGOVln?=
 =?utf-8?B?SW1GUWtYWk5qMG9qMDBlcnZ3Nnp2cFZwa2hnR3QwNXBlYk4vK0NLTCt3Ukcz?=
 =?utf-8?B?TkFDYjY3cis2TGczRTZLcFVnTHZ2V1FJSnJaaW1kZVJqM25QMjZSNVlMOVdw?=
 =?utf-8?B?SHZQcExFSVVydW00eFNDRktrQkVrREkya0lEOTQ0Q1lXWnRZUWFRTUtQSlpm?=
 =?utf-8?B?OGYxeFlzTGs2Z29pK2NRdHBtUHIvVzZtQnZudVZ5c2wveXJveE5OUElZbE1o?=
 =?utf-8?B?TGdCZjVoQnpGUmdsNDhZd3ltSWhHMFNLZUNIb0lKMUFNdUNrWW9JRUxIb2lP?=
 =?utf-8?B?V0o1bW5aYjRRQlpoRVFxZVJBa3A5Uk1UVW5EQ2p5WmR0L3RQbUlzMWt3Y2cy?=
 =?utf-8?B?ZWlOUmw2MDhDSjhZS2ZYK3dkT1lvY1hiSFlWZ0crSG1mZjFJVFpZUXl4NGc2?=
 =?utf-8?B?SzQ1RlZCUXJ2bk1VYUtCdGxRWC9rNVoxTmdqdW5mVElUZjloWE5TTWFYdW80?=
 =?utf-8?B?UWxOK2Fnb0p3L0U1Ui85K2RTUjNxdTNrSEVGMTlQa3QrOFpzc2poUC9qTmRt?=
 =?utf-8?B?TUxXRFVRd1VSRFdqamx1T0N5TXAzT2gyVFFjR3lIWDZMcEtOSjMzUE5tY1pT?=
 =?utf-8?B?M1N0NllVSUZuUUE2NVhQaStwUVJvVm9oTk5uMExndStWMG9abHo4ek52cEZC?=
 =?utf-8?B?QTNTeTJ2SkpDR3FudCtPVEV4Y0lRVTRXaHlVckdUWE15Q0J2b3FPd0RqS2Y2?=
 =?utf-8?B?dmdFVDdwallNeUNSM2JQcm9NQ2RpeGV6cGk3ZnhReVFmTTREd0dqN2dKYVhl?=
 =?utf-8?B?VVNXemdRRWlKN21xUm5iT0JEQk93U0VxN2VzSjQxMXNwenovUXdYWUo4b0gx?=
 =?utf-8?B?bWVnRmZGNG56SkdYZ2dXckZReWtwbkVrR0hoU2xrd3hvMHZmT1kzTVBIOTdn?=
 =?utf-8?Q?PY7qGB7/eXAdl8RRYpEcE7q6/G4pMXUs6yRaI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93df615f-fdaf-487e-b54c-08d8d9ea3cfd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 00:05:34.3508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9emLi8jOZXAjkbxSd/jBU+JMo6qqgcRo5ITc8NqZO3O7JpmHF1NH8RozNF+9vZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4737
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_15:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250183
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 2:05 PM, Andrii Nakryiko wrote:
> On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Later proposed bpf_for_each_map_elem() helper has callback
>> function as one of its arguments. This patch refactored
>> check_func_call() to permit callback function which sets
>> callee state. Different callback functions may have
>> different callee states.
>>
>> There is no functionality change for this patch except
>> it added a case to handle where subprog number is known
>> and there is no need to do find_subprog(). This case
>> is used later by implementing bpf_for_each_map() helper.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/bpf/verifier.c | 54 ++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 41 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a657860ecba5..092d2c734dd8 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5250,13 +5250,19 @@ static void clear_caller_saved_regs(struct bpf_verifier_env *env,
>>          }
>>   }
>>
>> -static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>> -                          int *insn_idx)
>> +typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
>> +                                  struct bpf_func_state *caller,
>> +                                  struct bpf_func_state *callee,
>> +                                  int insn_idx);
>> +
>> +static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>> +                            int *insn_idx, int subprog,
>> +                            set_callee_state_fn set_callee_st)
> 
> nit: s/set_callee_st/set_callee_state_cb|set_calle_state_fn/
> 
> _st is quite an unusual suffix
> 
>>   {
>>          struct bpf_verifier_state *state = env->cur_state;
>>          struct bpf_func_info_aux *func_info_aux;
>>          struct bpf_func_state *caller, *callee;
>> -       int i, err, subprog, target_insn;
>> +       int err, target_insn;
>>          bool is_global = false;
>>
>>          if (state->curframe + 1 >= MAX_CALL_FRAMES) {
>> @@ -5265,12 +5271,16 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                  return -E2BIG;
>>          }
>>
>> -       target_insn = *insn_idx + insn->imm;
>> -       subprog = find_subprog(env, target_insn + 1);
>>          if (subprog < 0) {
>> -               verbose(env, "verifier bug. No program starts at insn %d\n",
>> -                       target_insn + 1);
>> -               return -EFAULT;
>> +               target_insn = *insn_idx + insn->imm;
>> +               subprog = find_subprog(env, target_insn + 1);
>> +               if (subprog < 0) {
>> +                       verbose(env, "verifier bug. No program starts at insn %d\n",
>> +                               target_insn + 1);
>> +                       return -EFAULT;
>> +               }
>> +       } else {
>> +               target_insn = env->subprog_info[subprog].start - 1;
>>          }
>>
>>          caller = state->frame[state->curframe];
>> @@ -5327,11 +5337,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>          if (err)
>>                  return err;
>>
>> -       /* copy r1 - r5 args that callee can access.  The copy includes parent
>> -        * pointers, which connects us up to the liveness chain
>> -        */
>> -       for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>> -               callee->regs[i] = caller->regs[i];
>> +       err = set_callee_st(env, caller, callee, *insn_idx);
>> +       if (err)
>> +               return err;
>>
>>          clear_caller_saved_regs(env, caller->regs);
>>
>> @@ -5350,6 +5358,26 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>          return 0;
>>   }
>>
>> +static int set_callee_state(struct bpf_verifier_env *env,
>> +                           struct bpf_func_state *caller,
>> +                           struct bpf_func_state *callee, int insn_idx)
>> +{
>> +       int i;
>> +
>> +       /* copy r1 - r5 args that callee can access.  The copy includes parent
>> +        * pointers, which connects us up to the liveness chain
>> +        */
>> +       for (i = BPF_REG_1; i <= BPF_REG_5; i++)
>> +               callee->regs[i] = caller->regs[i];
>> +       return 0;
>> +}
>> +
>> +static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>> +                          int *insn_idx)
>> +{
>> +       return __check_func_call(env, insn, insn_idx, -1, set_callee_state);
> 
> I think it would be much cleaner to not have this -1 special case in
> __check_func_call and instead search for the right subprog right here
> in check_func_call(). Related question, is meta.subprogno (in patch
> #4) expected to sometimes be < 0? If not, then I think

meta.subprogno cannot be 0 or negative number.

> __check_func_call() definitely shouldn't support -1 case at all.

sounds reasonable. will do.

> 
> 
>> +}
>> +
>>   static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>   {
>>          struct bpf_verifier_state *state = env->cur_state;
>> --
>> 2.24.1
>>

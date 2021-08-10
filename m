Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D383E7D90
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 18:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhHJQhC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 12:37:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7788 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235657AbhHJQhB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 10 Aug 2021 12:37:01 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AGZ146019675;
        Tue, 10 Aug 2021 09:36:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lR6BXSJQxP6vZndsecjMMPrarT08LFWybOZQYzfva7Q=;
 b=c3/aFJaTD6yR35Z67rK8gN9qYN+6eVr1JaYsVzNxF2JHRj4LgaLkE7oAiEzoGbRHbeJZ
 e2we/cScYfGRx6U9i/4lmFTAU/uE7oPAoPSMhE5z4IwrWPGTGMVVjykhvScN4HSMFgG9
 x08z5HvqdTwcYu+LbGBVFISMi/B4MAWsdy8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ab7067ace-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Aug 2021 09:36:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 10 Aug 2021 09:36:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ju5JGc+prpzWVUP35sxp8eg44fn1dTJ6VK8ofTkO+7HTmfldzfRZsIq460HRE/5SkY2M8OduCZBl3Y0M7r/4wsPuIzu+n1rg8kl1q8/ewicpzZ3QdKW0iBeQ38CvJtDFrYXAl/uBPRWiZWmw3HCJMC/ACWuQHImpYFnbaz2BbT7gjyf/Mv7d30FrsUoepiuBHKscpOWdr+CnGgNme4hcnWGtZ6dPaoYqsaJLNiGRxahiOSxsOZmyB8CXstZUkIEtPVTwd6TyAG4wtRBByLZIyJhGnKGBJZqBd0Xd6gv9CCIC/UPdgy5aEtK/d3EB7/pcbz+/jmQcVLtXFu4bcuQaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR6BXSJQxP6vZndsecjMMPrarT08LFWybOZQYzfva7Q=;
 b=ofbxxKdoATqx4DKdRfk2RFB8eplT4i4px0gPDOcU7CMlLb0lQ53EI0DU9Vm7XqmS8BWNlsvhzr2FN9X2CGCfh0X5baC3qUdXumxgj4KGdo9PJsoecxMtHmSsWIkP2E6ekJuYvelFJ1J+5N7tiV0V6P6vDr3dnN2NGMKjL4KYWeJeJm+/HNJXea722ON2YGT0+Kq2HaQeDNoE9jgTCLHqLwN9mwa2mm56032vuV8gDim6UjeFnlqbZEGD560Rl/5TLrc2Nogob4IIPM9WiQDD7Qw50vlSZYadIsPY0o2s9rWlaO41H9KpNYjbM7zQu4hZF9xvgOQ/6ixCv9f7BdoiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4740.namprd15.prod.outlook.com (2603:10b6:806:19f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 16:36:21 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 16:36:21 +0000
Subject: Re: [PATCH bpf v3 1/2] bpf: add rcu read_lock in
 bpf_get_current_[ancestor_]cgroup_id() helpers
To:     <paulmck@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <kernel-team@fb.com>,
        <syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com>,
        <htejun@fb.com>
References: <20210809235141.1663247-1-yhs@fb.com>
 <20210809235146.1663522-1-yhs@fb.com>
 <d9947aba-ca93-200c-0299-1ab5574aa4c5@iogearbox.net>
 <20210810163225.GG4126399@paulmck-ThinkPad-P17-Gen-1>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8ef1734d-688d-ca5d-6016-9d76fc07f174@fb.com>
Date:   Tue, 10 Aug 2021 09:36:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210810163225.GG4126399@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1ad4] (2620:10d:c090:400::5:8082) by BYAPR11CA0080.namprd11.prod.outlook.com (2603:10b6:a03:f4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 16:36:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6934a13-b15e-4e1c-f961-08d95c1cfc8d
X-MS-TrafficTypeDiagnostic: SA1PR15MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB47402E9D48B461E4C3424AA0D3F79@SA1PR15MB4740.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3Lc8p5wP5jmjdvq3PVXoICnZO88jdeUKRMs9sif4sIZTlpY4XPozTs+2sdwkxIWn9jUPgw+ZZP23JjLo9sgwsw4hRtyYZZIBE37YWlLmh9uGz3ivJPKnDx/WX1sK5C+3mSk1/qP5orv6qTVOk/vGnTaMly73e8PgKncNNLhXFeu88lMh132by3vE4/PRnyLXApEC7CN5l4i+1NM2Y15Zl24yhUJpKQIgCk8fzz6GCW+0VpNaDtwFOaMP4CCVsxD883x81TFSvg1phUx1Txr+c5KwExCEPgZeZHYaqDCCi2dUusR/C2Rn2W+ALpYylq8XVsQWHVLr2X76Oj6J2EShaW9JBGVpFH+1ZooOC+9aXCpfnbpvHRMLoJPmfKM5aESKJc7/7V0qog09ccKBqLyua25BTLK0Oz0jW0gx84VaLmSBlbAxUWvtOLk7BdKBzQkAP0PwsMz59d6y6ZAKEkZs1Af292PBGTtUKYAIzHQMqN51R951hXufjRaD4jlDiLBMfhcPWWBKjaMdj7AazVnHFssmlOqFtKlgohgAFJQkZZBOtj97TK/khgkZsrnJr3AFTZi/7NwsQqxeLCYpjkqoaG5vRQKHk7RtzH3YckqZNIbrV8cOijF9fu535g75gery8wjJ/WsBwzQe7E17QiZ37PfOkaLp6bmzimDBquW0dwfMUbkJMmWAjvrPEYdJHNg46St0uNKKjeIFZcvrECDPI2L84SfIb9/QEfHlwxjV3vtMpU6nJeg/LsUtv6yKV18CaRSb8jtsHaE3+nKXvA/ah+HbM5tkLJVJ/gNxtMibGZP2/TBMCg0zSgWSm3riMhg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(4326008)(2906002)(53546011)(83380400001)(186003)(54906003)(478600001)(52116002)(966005)(316002)(66476007)(6486002)(6916009)(36756003)(31696002)(86362001)(8676002)(8936002)(66556008)(66946007)(38100700002)(5660300002)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0Niem9BeExBbHJST0dtMTdEbk44d2txR0c3TURsWE54dk43dGxaS2FwZzQ4?=
 =?utf-8?B?bnBuUFBUazRWYXpuazU2TzYyMVJrSzlzVmtyL0hXYXZSNGh6MENTdlA2Z2R2?=
 =?utf-8?B?WHB5bGpmMGFxZTZFekIxcjZrR2g2NDJVYUdHTlRoOWJkaElUT2lJR212SExD?=
 =?utf-8?B?Y0dQb000TzNPY2FXM2FYNDBoSTJUd1I3YmlmRk9FWmpGNElXT0orUlJXM1VY?=
 =?utf-8?B?dmhHTWg2OTgvNVllVUJLYUxDRnFtSFUrZ1cvZDlqN3R2TWtMeGpickd5cXEw?=
 =?utf-8?B?NlZEb0ZwNkJuOXlnNnlDSjJuNUFHT0Q4STNLSGY5TFVURHVGSVliUElQYUho?=
 =?utf-8?B?dGt0ZFg1NHFnVEkxN2t3cmFHbVFZaDdxcWYreldsR01oaEtMMzZKRmNzTUo5?=
 =?utf-8?B?ZmIzUG80azNRLy9JcURuWElmNGYvY0VXdEh2Q2FMdjVLYk5ubkg0bGk1WGV2?=
 =?utf-8?B?TlVHTkNZcGY1UFF5aG5wdEFITnRCaVpQdmRDRjRWRW81V09OaWVBZVN4ZGVh?=
 =?utf-8?B?eVMxQTBEWWZka0hkVVNqTVd6aXFSekhjRXdqaWhGK1BoMFhQZ1RNbXFwdm5J?=
 =?utf-8?B?S1pCclZ3UmlrcGVPSkI5ZWxtWEptdjdyMDhORWdueW9QdzBaVEY4UlUvMW5R?=
 =?utf-8?B?SGNNbTFKM3hlRjY4N0pOYkFSQlNYZy9RMkVycFRvcUorYWliSjFPeUcraUYy?=
 =?utf-8?B?anRNbEQ2MU1IZ1Q3SlF3SVB6ZWtSaDN3bCtoc1lXNk1vSGtybVRTK1ZZekEx?=
 =?utf-8?B?NjNFQ1AvWlAvNjVmTW1kSU81TGtmclJwNXo2Z3lMV1FoQXMvZnE2ZkhwZFh4?=
 =?utf-8?B?YzRraE9EbFJacmEvNjBTLzMvQ01LSHQxb0EvamZTcUN2dTFGdXhGR3gwdlVF?=
 =?utf-8?B?Vy9wYkR0b1NneTJCbTROUTMyenRSNzdMOW5yWnVneG1rWWVmNmJHTW15VzZr?=
 =?utf-8?B?T1hkL09TNE5KM0gwNnV6RG1nMGwxWXJmc1FLdTNXUTF1L0ZESVZFaGhiRWdw?=
 =?utf-8?B?RGZQYzg3dHhZUDg3WitudlgxdE5pa1JYWUlRWTJ4SG80SGVhTGF0SHc3emVz?=
 =?utf-8?B?YnB6V0ZkRnJuNEFLYVBaeFlPZURVMXRGSUJIOTIreURjRE9ZZXZsN0VaUmo4?=
 =?utf-8?B?Z29tc0RoTlBJSnBRT1N4ZU1LUjZOTmRmNE1QM3FCOGJrREFDSmRNdW0vNG4z?=
 =?utf-8?B?dUlkWDlQQjZLZ1U2cEpuU0xQMGlJcUJhdUhZUU9TZ0xmKytuM0VCNlpKeGxU?=
 =?utf-8?B?S0JxelhXVjJjY3c2YXI3Wld0ODRzNGZsalRhR3djZUloV21SMXdJMjduRDla?=
 =?utf-8?B?V3NSZ2FOQ2FUVUIrOHpZQ2Q2SnJkZjFtTWJCYXg4by9ueWNXU0NCVUxaSFFn?=
 =?utf-8?B?L28vL21NNEpWQjB5Z0Y2QmRLVUpOT284aHFsRGVBS2czcE1xOVB1a1JSamlq?=
 =?utf-8?B?VjZUZDAxck5SK3FJanJkanRUcWRGQnMzYlRWTEd5MWQrRXAzLzIvdzBwMGk0?=
 =?utf-8?B?ZnZhcVRXbEd2bERJSmM0dnpOdkh1R3djc0VHNFoxRnIwMVBLV2s5cm82WXBP?=
 =?utf-8?B?SzJOV1hHQXQwdkdwRTMvMUowbGdkOEF1ZlRmQzN4NU1SN0JRalRwRzVtZkJE?=
 =?utf-8?B?Mjh2aTFJMit2SDVnNmxPaEpKTnZObk9BMkFJREY3VUx6VjRpWndzOGVVVzVY?=
 =?utf-8?B?VzlnSk85SnVwWEJoOWVUSnE1dzNDQ0lZUVhRdTBJTWJ1RkQxRjQwWXhHMFFs?=
 =?utf-8?B?Vk1VeE43RTRTMGdLN2EvY0FITTJQMERFcDhhMWgybVgyMWVxd00yNUFMUXNC?=
 =?utf-8?B?MkJJSktJdGpSeE1FckVIQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6934a13-b15e-4e1c-f961-08d95c1cfc8d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 16:36:21.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfPvCBYsHTggboBCzJNpRM/GuW1KfpzcuVzBk5/FjAq4y2255i6J92cEhn6zZpj8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4740
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: iXzJA3zo4cqDKqad_TqhtACpIm1tycbE
X-Proofpoint-GUID: iXzJA3zo4cqDKqad_TqhtACpIm1tycbE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_08:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108100106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add Tejun to provide more clarification on cgroup side.

On 8/10/21 9:32 AM, Paul E. McKenney wrote:
> On Tue, Aug 10, 2021 at 10:08:58AM +0200, Daniel Borkmann wrote:
>> [ +Paul ]
>>
>> On 8/10/21 1:51 AM, Yonghong Song wrote:
>> [...]
>>> I will hit the following rcu warning:
>>>
>>>     include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
>>>     other info that might help us debug this:
>>>       rcu_scheduler_active = 2, debug_locks = 1
>>>       1 lock held by test_progs/260:
>>>         #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xa0
>>>       stack backtrace:
>>>       CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      5.14.0-rc2+ #176
>>>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>>       Call Trace:
>>>         dump_stack_lvl+0x56/0x7b
>>>         bpf_get_current_cgroup_id+0x9c/0xb1
>>>         bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
>>>         bpf_trampoline_6442469132_0+0x2d/0x1000
>>>         __x64_sys_setdomainname+0x5/0x110
>>>         do_syscall_64+0x3a/0x80
>>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> I can get similar warning using bpf_get_current_ancestor_cgroup_id() helper.
>>> syzbot reported a similar issue in [1] for syscall program. Helper
>>> bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
>>> has the following callchain:
>>>      task_dfl_cgroup
>>>        task_css_set
>>>          task_css_set_check
>>> and we have
>>>      #define task_css_set_check(task, __c)                                   \
>>>              rcu_dereference_check((task)->cgroups,                          \
>>>                      lockdep_is_held(&cgroup_mutex) ||                       \
>>>                      lockdep_is_held(&css_set_lock) ||                       \
>>>                      ((task)->flags & PF_EXITING) || (__c))
>>> Since cgroup_mutex/css_set_lock is not held and the task
>>> is not existing and rcu read_lock is not held, a warning
>>> will be issued. Note that bpf sleepable program is protected by
>>> rcu_read_lock_trace().
>>>
>>> The above sleepable bpf programs are already protected
>>> by migrate_disable(). Adding rcu_read_lock() in these
>>> two helpers will silence the above warning.
>>> I marked the patch fixing 95b861a7935b
>>> ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
>>> which added bpf_get_current_ancestor_cgroup_id() to tracing programs
>>> in 5.14. I think backporting 5.14 is probably good enough as sleepable
>>> progrems are not widely used.
>>>
>>> This patch should fix [1] as well since syscall program is a sleepable
>>> program protected with migrate_disable().
>>>
>>>    [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
>>>
>>> Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
>>> Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>    kernel/bpf/helpers.c | 12 ++++++++++--
>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 62cf00383910..4567d2841133 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -353,7 +353,11 @@ const struct bpf_func_proto bpf_jiffies64_proto = {
>>>    #ifdef CONFIG_CGROUPS
>>>    BPF_CALL_0(bpf_get_current_cgroup_id)
>>>    {
>>> -	struct cgroup *cgrp = task_dfl_cgroup(current);
>>> +	struct cgroup *cgrp;
>>> +
>>> +	rcu_read_lock();
>>> +	cgrp = task_dfl_cgroup(current);
>>> +	rcu_read_unlock();
>>>    	return cgroup_id(cgrp);
>>
>> I'm a bit confused, if cgroup object relies rcu_read_lock() and not rcu_read_lock_trace()
>> context, then the above is racy given you access the memory via cgroup_id() outside of it,
>> same below. If rcu_read_lock_trace() is enough and the above is really just to silence the
>> 'suspicious rcu_dereference_check() usage' splat, then the rcu_dereference_check() from
>> task_css_set_check() should be extended to check for _trace() flavor instead [meaning, as
>> a cleaner workaround], which one is it?

Thanks for pointing out. Definitely a bug on my side. rcu_read_lock() 
region should include cgroup_id(cgrp) as well.

> 
> At first glance, something like this would work from an RCU perspective:
> 
> BPF_CALL_0(bpf_get_current_cgroup_id)
> {
> 	struct cgroup *cgrp = task_dfl_cgroup(current);
> 	struct cgroup *cgrp;
> 	u64 ret;
> 
> 	rcu_read_lock();
> 	cgrp = task_dfl_cgroup(current);
>   	ret = cgroup_id(cgrp);
> 	rcu_read_unlock();
>   	return ret;
> }
> 
> If I am reading the code correctly, rcu_read_lock() is required to keep
> the cgroup from going away, and the rcu_read_lock_trace() is needed in
> addition in order to keep the BPF program from going away.
> 
> There might well be better ways to do this, but the above obeys the
> letter of the law.  Or at least the law as I understand it.  ;-)
> 
> Or does the fact that a cgroup contains a given task prevent that cgroup
> from going away?  (I -think- that tasks can be removed from cgroups
> without the cooperation of those tasks, but then again there is much
> about cgroups that I do not know.)
> 
> 							Thanx, Paul
> 
>>>    }
>>> @@ -366,9 +370,13 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
>>>    BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
>>>    {
>>> -	struct cgroup *cgrp = task_dfl_cgroup(current);
>>> +	struct cgroup *cgrp;
>>>    	struct cgroup *ancestor;
>>> +	rcu_read_lock();
>>> +	cgrp = task_dfl_cgroup(current);
>>> +	rcu_read_unlock();
>>> +
>>>    	ancestor = cgroup_ancestor(cgrp, ancestor_level);
>>>    	if (!ancestor)
>>>    		return 0;
>>>
>>
>> Thanks,
>> Daniel

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817B83E4B09
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 19:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhHIRl4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 13:41:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50460 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234154AbhHIRlz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 13:41:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 179HX5sE030887;
        Mon, 9 Aug 2021 10:41:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2ddx/5OmcWlqLqQO6kf5L9JQRR6AMLCZtJMJ3O7mQ1k=;
 b=mYikYMOEiDbyx95LxVxOwhq6EzKEW0ZmApf3U+bucvvonx1xsRqGBZIlkLGed8dEM56X
 iYITyyZyTTEIxhLAO0Hg6tjA1wXZg5tf89ITJWuZGFWEnk8M5QpSjOJqgyYp3rGdPyvA
 xBWrFw2t2vlKMGwJT3Yz9UFPiNS5enWK+sY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3a9nuxaaqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Aug 2021 10:41:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 10:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtHvcqlFo41Dukv4sxrcd34oHMKedodlOomi4jYr7VOBglqJOzsVeFpgTcYUJOHz/RnD/G3UTmTV2y1jQmsq2IAQau7aupripurDhAKSmyMoR7DBMbXrfjNCmVYJIxIH9mKbsJSZghRxIlgncX9W2ndmmtv8s2IKfO+YLtySqTA/v5NguKCTkM5lixazm0D3e5FFl28dPNowgjafw09C4bYLxT9ZEtRZqw2U9/A3NYDItHFv1o73RXeXJ1ReP6YZsY76XZEVNk4Tvt9TGQAMvzxlEQ7Qc9hhztg/sHdeBBnk5DlIAnHMk42i982UblJSIxStPdEFSm6bndjPHMlhAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ddx/5OmcWlqLqQO6kf5L9JQRR6AMLCZtJMJ3O7mQ1k=;
 b=JSe+pbEc//vgBz/Gn3zjWLXy+jrz4hr+MCIxssIbFVzJkXKm2vdIioFSYQ97Xu8xAOLcZ5esV9PQvXHmQRFk/z9TWItgc39C3nxw4fXU8uYaQ61WBVIzTevUNwdsRQSvgKDhH8EmOfYQnkciU1/WEfhGJ2C0ymcSYv3fquoZ03Sg+cxuuoBL2vTaSS8B+2qmlFe/+vKUGYD8y4GG9FgXVPgW9zT7pw4M6FMHxl0qX3GZSBFQvdtUJVYvdHOxr8DevkbRc545ws3maNC9cyGdC0wvjxWLsDSkLnnKwfjhLPVqLe+IDsViFm2XqzyOUaMUZfgpZSzZ84G36hHxZbjPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4451.namprd15.prod.outlook.com (2603:10b6:806:196::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 17:41:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 17:41:18 +0000
Subject: Re: [PATCH bpf v2 1/2] bpf: don't call
 bpf_get_current_[ancestor_]cgroup_id() in sleepable progs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        <syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com>
References: <20210809060310.1174777-1-yhs@fb.com>
 <20210809060315.1175802-1-yhs@fb.com>
 <CAEf4BzY+-v4NhMmHnr8agjWj6+O7O-J909+TM1HSZUE6WYifrA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0b299368-370f-2292-2ae6-e86a9bc9a240@fb.com>
Date:   Mon, 9 Aug 2021 10:41:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <CAEf4BzY+-v4NhMmHnr8agjWj6+O7O-J909+TM1HSZUE6WYifrA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::10d4] (2620:10d:c090:400::5:2d81) by BY5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:1d0::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Mon, 9 Aug 2021 17:41:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dcac03b-b9fa-425a-1c61-08d95b5ce4af
X-MS-TrafficTypeDiagnostic: SA1PR15MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB445138450B2E7C6E0CA8B978D3F69@SA1PR15MB4451.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRVY0dcqK1KKFOyxc0C+hiX0dQc2o0niRKnz4zD12ourhOwQoR/DHWivrScXxn0XvGuMqSsz6bW7vcWWK4tflMq0ZY7lSDwi3p6NFgVYx4Ho/SW1A3cjiCP/uDVRwz0FsWxXF+g0pyuMX5dTXpmNlBwipfWB3vQhMkWYg/Y9lxVsefslH4QOBKVL2yEijGXElYGsiYyLWgoQAwJHEx/BTELCuQvlAGm8ZBT1J6upCxg0hFWYwoRYFWJl5ePCin9gN5tWBAtqAZd6RQ7W4HcVv30XeijXZeOko/kPZ/CapZKMcHxb9j+guiLFhjsvsL9DxdEUGnScOvUsW7qMGqVUVpbAsIs9G9morOF4Y+F7t+9MSN8DuEt9grks6JfxBF378QWR0fXnJgMhPfODQ7bQbFMKNl6AJCIly+hEakAvI51iz5bBefw2hnpSRoGnpQHY6+U4tv8Va9AvezbcQdTz3QtT2KYJhgCfakt292BIvI26VEip6VW7e2wVxVXRRqLUEC3OASH58FvtYwDXJhRcgSttEtWarDZLLSG0xzT9lvp7hFEH8TYhMXHpTlRG+qZyljKVNi1TMIFBn8utiXLhIcljeN0nRKyAEH4D1EP2ozLPIMdJtKQnFpmaADnWz1Czsf9eUhRfKRdb3GS8qf+Yjx90QcySp/frqDXakDAZAGk8YrQSwVL8cRZehNTDSyHsgztrSPKA89nkxWThhlH9WTaiIOJTKcnpZVelqsLSNFcrPy6hYYA+t1lAzXTJpI7s1kkS+IXvDKWrJUjBxh/cu0R5m8Mmy4s1P4QkrR3Wp97yLp8TJizF+Etcsd8rue2e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(316002)(83380400001)(86362001)(6486002)(4326008)(54906003)(6916009)(66946007)(66556008)(66476007)(8676002)(31696002)(478600001)(8936002)(5660300002)(966005)(186003)(2906002)(36756003)(52116002)(38100700002)(31686004)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG5YL2hQL3ZBdzlWc214MUlMKytYblg2d2RIaUxKVi9CTUpuYjN0QVlqR2d5?=
 =?utf-8?B?d2tyd0l2UVdrcWdwK0ZpYlBBeXBkSmtxd080MmpqREI0N0NwWWNZTVYreGFL?=
 =?utf-8?B?VFpKOU81MElxMndvRjBuOXVoYTlRUnMvRlNzZFBKZ01sTmFib0tha3pRMWRQ?=
 =?utf-8?B?M1VRbzNaYTJQdmoyVHJtR3hsNE9NQSt5QThHeE9zbjRQZnBvbjl4elZueGFj?=
 =?utf-8?B?SUZmSWorTEcxVm1YdkUwREJXL05uclk0REFrbDNhekczV1NHdGZXazhaWmU3?=
 =?utf-8?B?UWIyeHduYS9idzAyc3NzWG8yTDQzSktuNDlsK2FvVnRyUmlvT2huNHBFWHNv?=
 =?utf-8?B?WEVlQ3ZjNEtZSWpRT3dlWkJHb2E5dTMyOHA4bnc2ak1ER1VnNjNjTFZxZ0Vl?=
 =?utf-8?B?OURHdlBSQnZQYkk2VFcwalpXNTl5aXR0eTV1bGpxTHZXMzZESFFjNFRZbTA4?=
 =?utf-8?B?YllNMStybkZvaTlJTmh4V1MwN0M5Q2IwWW1yLzJHcHpZNDZBb25ZcnFJelNy?=
 =?utf-8?B?T0dsRjdLbU9xZ25vMXlLVGJhZmN1MmFUa1dwVWdmZE03UjJrSlcwc1Z4cXAz?=
 =?utf-8?B?ZGFsalVndTc1N2pySllpd1M3bysxb2ZVSDBxVms2UFNjZDNiQ3ZnRHozbTVJ?=
 =?utf-8?B?K2JXZEt2Y2U4aW5wM3MxTFhXaWQ0V05FdWlZYmJER0tpdXk1clgzYjRlZzV4?=
 =?utf-8?B?TE0wVWp2aDhTSGFLZ1ZFK0phaDd4MENnMktmaU9vTUVYM1lWTVhiUklRNGp2?=
 =?utf-8?B?Z20yN2VERmlDOVRqS09rT1hPZTA2ZEVoRFVqZkxsdFFzcHoxUTMyOUVvQnI1?=
 =?utf-8?B?UExOOHRzbkZMdGRoL0dwemlyMUdLMHhxeWNabUk5N3laYjdWRXJBNGRxZGVi?=
 =?utf-8?B?VEVEalljWWVFT1A0RFFEcElZL0NCUjd6b0tIQ0RtTWt1QmF3S25XTUFnTTJU?=
 =?utf-8?B?TytkQ3ZaaklDaEhLTEt1aTBOcU50V1RzT1pFZlRudDk0SVlyNFY5YzVETlRm?=
 =?utf-8?B?dmFEcGdTd2VFb3RoQ0xFTW41RzFKZkpCWVgweWFhcytTYkk0aDlGSFhZby8y?=
 =?utf-8?B?bmNOY0t4WVA4TzBsN2MzOWt1OURhWkVSa0NjcFdpTGVld0x4N0RPTFJvTFRQ?=
 =?utf-8?B?UVYyZW9iOUR0M25VblBTYThOWWszL3FWT1EzYnZPNHJubHFaTm5hRmRxMDBp?=
 =?utf-8?B?NlJpVXdhakdrQmxNZWFibGhsdEI2bGFEMFMzTURacFhzRjRzaXhnc1dJbDFn?=
 =?utf-8?B?UFJzTWFCREhBTHkzR2psY2crZ0EyWTNXekdFUDRWeUZObitnYXRVUmJSY0ts?=
 =?utf-8?B?SmVXZDZ4enFtSTc2dFZtT0dPTjhCZkViVmZpeXlqTDZOd0ZhUGE0eTZkT3hl?=
 =?utf-8?B?bzdBblphdmkzQ2hiWmlBbElPVzNMUWNsS3VQUVE2cHRnZGZtMnhrL3h4aTQz?=
 =?utf-8?B?YnpTWnViT3NIRGZrY2wwWjVmMHJ1d1JhQXJWOFRjQlY2NGhrUFRUSk52VjVX?=
 =?utf-8?B?M3pKclFtRytYV0IySW5ESG04TzMxRWwwSEV0dkpEc1FGcmtoRkY0dkVvanJL?=
 =?utf-8?B?eWxNRmk2NTdmT2lIWEU3dmY5NkNMWnRRTS9tQ1E1L0Qxa09XcVFKZ0lROUZu?=
 =?utf-8?B?WUpyS0Rhd25CU1VSYXNBSWlWWitnSUZWd256WVEzOVpjNHQ2Sm9oT0dGWTJ3?=
 =?utf-8?B?dk1xWFZWeXpGYkxNcHE0ZGJ3cHpxcTFtcG15SzhKVnUvM3JyKy9VTUp6ek5F?=
 =?utf-8?B?R2x1K3QzVWNwOGhhUjBZOVJwa2pXbkNPd1RjckpkUVZhRkFUVGdkQlRvVXMv?=
 =?utf-8?B?ZlJ2TEQyK2lmU09LZ0dUQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcac03b-b9fa-425a-1c61-08d95b5ce4af
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 17:41:18.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9duCqa+3aXYLMSAYT5njfSNupsX8B3lCo1m6MYimCFySp/uvCiDsdZ4anp+oHAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4451
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: TwZUX-tYck-TT_BMIJvmqglUp1gLTBoN
X-Proofpoint-GUID: TwZUX-tYck-TT_BMIJvmqglUp1gLTBoN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_06:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108090124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/21 10:18 AM, Andrii Nakryiko wrote:
> On Sun, Aug 8, 2021 at 11:03 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, if bpf_get_current_cgroup_id() or
>> bpf_get_current_ancestor_cgroup_id() helper is
>> called with sleepable programs e.g., sleepable
>> fentry/fmod_ret/fexit/lsm programs, a rcu warning
>> may appear. For example, if I added the following
>> hack to test_progs/test_lsm sleepable fentry program
>> test_sys_setdomainname:
>>
>>    --- a/tools/testing/selftests/bpf/progs/lsm.c
>>    +++ b/tools/testing/selftests/bpf/progs/lsm.c
>>    @@ -168,6 +168,10 @@ int BPF_PROG(test_sys_setdomainname, struct pt_regs *regs)
>>            int buf = 0;
>>            long ret;
>>
>>    +       __u64 cg_id = bpf_get_current_cgroup_id();
>>    +       if (cg_id == 1000)
>>    +               copy_test++;
>>    +
>>            ret = bpf_copy_from_user(&buf, sizeof(buf), ptr);
>>            if (len == -2 && ret == 0 && buf == 1234)
>>                    copy_test++;
>>
>> I will hit the following rcu warning:
>>
>>    include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
>>    other info that might help us debug this:
>>      rcu_scheduler_active = 2, debug_locks = 1
>>      1 lock held by test_progs/260:
>>        #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xa0
>>      stack backtrace:
>>      CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      5.14.0-rc2+ #176
>>      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>      Call Trace:
>>        dump_stack_lvl+0x56/0x7b
>>        bpf_get_current_cgroup_id+0x9c/0xb1
>>        bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
>>        bpf_trampoline_6442469132_0+0x2d/0x1000
>>        __x64_sys_setdomainname+0x5/0x110
>>        do_syscall_64+0x3a/0x80
>>        entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> I can get similar warning using bpf_get_current_ancestor_cgroup_id() helper.
>> syzbot reported a similar issue in [1] for syscall program. Helper
>> bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
>> has the following callchain:
>>     task_dfl_cgroup
>>       task_css_set
>>         task_css_set_check
>> and we have
>>     #define task_css_set_check(task, __c)                                   \
>>             rcu_dereference_check((task)->cgroups,                          \
>>                     lockdep_is_held(&cgroup_mutex) ||                       \
>>                     lockdep_is_held(&css_set_lock) ||                       \
>>                     ((task)->flags & PF_EXITING) || (__c))
>> Since cgroup_mutex/css_set_lock is not held and the task
>> is not existing and rcu read_lock is not held, a warning
>> will be issued. Note that bpf sleepable program is protected by
>> rcu_read_lock_trace().
>>
>> To fix the issue, let us make these two helpers not available
>> to sleepable program. I marked the patch fixing 95b861a7935b
>> ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
>> which added bpf_get_current_ancestor_cgroup_id() to
>> 5.14. I think backporting 5.14 is probably good enough as sleepable
>> progrems are not widely used.
>>
>> This patch should fix [1] as well since syscall program is a sleepable
>> program and bpf_get_current_cgroup_id() is not available to
>> syscall program any more.
>>
>>   [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
>>
>> Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
>> Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   kernel/trace/bpf_trace.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index b4916ef388ad..eaa8a8ffbe46 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1016,9 +1016,11 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>   #endif
>>   #ifdef CONFIG_CGROUPS
>>          case BPF_FUNC_get_current_cgroup_id:
>> -               return &bpf_get_current_cgroup_id_proto;
>> +               return prog->aux->sleepable ?
>> +                      NULL : &bpf_get_current_cgroup_id_proto;
>>          case BPF_FUNC_get_current_ancestor_cgroup_id:
>> -               return &bpf_get_current_ancestor_cgroup_id_proto;
>> +               return prog->aux->sleepable ?
>> +                      NULL : &bpf_get_current_ancestor_cgroup_id_proto;
> 
> This feels too extreme. I bet these helpers are as useful in sleepable
> BPF progs as they are in non-sleepable ones.
> 
> Why don't we just implement a variant of get_current_cgroup_id (and
> the ancestor variant as well) which takes that cgroup_mutex lock, and
> just pick the appropriate implementation. Wouldn't that work?

This may not work. e.g., for sleepable fentry program,
if the to-be-traced function is inside in cgroup_mutex, we will
have a deadlock.

Currently, affected program types are tracing/fentry.s,
tracing/fexit.s, tracing/fmod_ret.s, lsm.s and syscall.
For fmod_ret.s, lsm.s, they all have
some kind of predefined attachment/context, we might
be able to check all potential attachment points and
allow these two helpers when attachment point is not
surrounded by cgroup_mutex.
For syscall program, we should be okay as it is
called with bpf_prog_test_run interface but I am
not sure why user wants a cgroup_id for that.

> 
>>   #endif
>>          case BPF_FUNC_send_signal:
>>                  return &bpf_send_signal_proto;
>> --
>> 2.30.2
>>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA92927B8A2
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 02:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI2AHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 20:07:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21598 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726715AbgI2AHI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Sep 2020 20:07:08 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T06Ogl016286;
        Mon, 28 Sep 2020 17:07:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=X7yr1p4favvsE5EC1aMuFB66EfX27ZKBPknKXR9hRRE=;
 b=kDj76HuJLSKojPHniTMPHMJ8iF+FLxAMsBoGp+Mm4QP49K/dnMbcDGvTb9ZJotjT0dLP
 zFmChBK2Egr31ft41PV9/75NRfwHc0IUqIRYi0amlYmScXbs/9kxx+qoRPQ+6jIknwcR
 DrbC4aUJIBxjF0gsuNirbEHcAQKx0Kq/8uk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33tnq47kjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Sep 2020 17:07:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Sep 2020 17:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QboXpbWA7GywdRBs204PVS1x2HppJiVlPsjwIpbtSb9xLs2LCEGJqvysoGUC3jqFzvyL1AcIhbQzw2+mQko8q/ZZMunJacY5/gHVBlB5Gs0q5x6BQQtgSwCWXNhY9eGczVbEK+RMFUe+PLL1+XHO2B/QK6d5i6pvSUeRGqcOA/HZiVyrsKN2pKxNVMeaB0RVd9AXPzFAFxBncayrIPamkA1ZalBlBNT/Rznf9r0gJYHodBzqfkaZzNad3+FlFqh3SuSb4X90Z/Y//gGdsJlMXSbTE6kEzxDoSym0lxUlqFsJxCwIX+awTPIMcfYwfuRSW9o1vcB4oFdxND8l+80VGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7yr1p4favvsE5EC1aMuFB66EfX27ZKBPknKXR9hRRE=;
 b=X7qCdRHJ7x0GcbKO0dJnhWtu1X0dwv+JpbCK7+eWX7cAxJLxGsTi12nqNa107yVECzAppGT+t1OdEdKzorF3iF97M05Q3FstGEy87hTxDbHSOrM+rRY2IwQuiQuUDhQaITS5ufpMFp1GNGXqg/v55Zf69vjoBk0ULYwdq1BWIaM5p0dVKgjL+u4cxmGKLbrlfu4cLq/3fqRAZgtvrCmA1jUNVoNlHqG7WWezGrUBW4zhK9USYrg5aa6dgfatEkwl6XjIuIyI4CdKXLab7szilTKnmJ37hdJgoIyXAv0SsW/gikzMs9cFbaj4oRh4iqps6CBZcWEc2kueRPvXQsS1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7yr1p4favvsE5EC1aMuFB66EfX27ZKBPknKXR9hRRE=;
 b=lG0JerqGTWgfFCUOkcrQWX3AphpOy+uPtx4dCNPQ50MspG0j947qoQ+JWU0tYax5ezrr6UznSq8ot3mdtffra4xudO5Pxzg7IXG6uiLIiimmxzoZrSqDxO7Sy0htJCvQuqMHRdZYv94PCVR+l7WtC7Di2ZhY9VrAcfmNHx4lavI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3618.namprd15.prod.outlook.com (2603:10b6:a03:1b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 00:07:04 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 00:07:04 +0000
Subject: Re: Help using libbpf with kernel 4.14
To:     Yaniv Agman <yanivagman@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>
References: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
 <CAEf4Bza00DMqu09vPL+1-_1361cw5HoDyE3pY6hSDkD0M-PGjA@mail.gmail.com>
 <CAMy7=ZVCUJKFA5AbaE3DeyCNsWXffWwcYtA6d5t9R5kgnzPi2A@mail.gmail.com>
 <CAEf4BzaTXz6s2xfV0swvcpKFz=U+K1DzD0+DEHSZ+e4Yf0xxPA@mail.gmail.com>
 <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <429e4b06-9f0c-0565-65fd-fd21a8183c0c@fb.com>
Date:   Mon, 28 Sep 2020 17:07:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <CAMy7=ZUgWyZNVs6haL4MF2hZ24MuvfE_mEOXopgVZFGF_D8miA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:3d50]
X-ClientProxiedBy: MWHPR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:300:6c::12) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1502] (2620:10d:c090:400::5:3d50) by MWHPR04CA0050.namprd04.prod.outlook.com (2603:10b6:300:6c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 29 Sep 2020 00:07:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cf9dff2-c1c6-4c89-df78-08d8640b98b1
X-MS-TrafficTypeDiagnostic: BY5PR15MB3618:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3618E9FC2CEFF0E12DDF2692D3320@BY5PR15MB3618.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HdjUFwtJ9a4GqKEwPqiY6YzB0do/hrCJkunih4bZdzT8X0Fhajd5zKj7waswVEAGW70+W8gBKFoqDuMIg/ZY3o/eOvH+tVscsng1lK6p/az+UzEHyuj6/4N09t2XDJwePtQ1Nmek4XhGkSF9c79QzUEFyDc5Jvr7fXm1AZo0cEuMu6My/ftnPP1drR7+6odJlnKYeQrcXPFQmgg5v34siW1Hw8GJ/Q206VedSEgTyzO70UWA1+MePszyqcsLdozWZnsrgfNJFNlurajbsdb2VF6NONem94O1GfVWLB52HJ6fVTFCRs3MK8vTHG8sb8YbTRWvxBHKQHySkZYN/PBPD4dZPRbxiWYA0+K7dTn+iOuFNtUiOK/XwXmjjRtEtHCrIugUAqlNojHdNnNk2VPnHJ5Ou1ZuG8EX5tTO1/rnw8eRmbb3xmyIY6zNc2RDbqt8cpojw4JfeFSTFiU6GpEJKzG+MBYLWwwJQ6kRNVO0sQkBeofJbbFfhxYT2vv5UyXp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(39860400002)(346002)(52116002)(5660300002)(83380400001)(31686004)(186003)(53546011)(16526019)(86362001)(2906002)(4326008)(36756003)(31696002)(66946007)(66556008)(66476007)(8936002)(478600001)(8676002)(316002)(6486002)(2616005)(110136005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OdSw0vC6d9PJCBeSjKcBc/2J8oaCKxJplvpe/eaR5xxj38GFKqX4+LAGfg3XkBiIA0T3K9uugrzbltNNQX44YXQFPqs5uEO9cFgwBHQYrydBWCFz5fxpyQwaSEWByU1lLs7I1uvluOJm3eL5T20mKITtsEKsbuCInfFICadNT9DAQBhkqWJg6uVtgJCT6XkhGYUNi5bmfSOOXoj12P61mutKcCZNJGXlRqW7HQtYUzS+3S1nehAnJqV0Rw+0QhoAFKI1VRvLvUZ+ehn6vlEAIHpaE5VYUIrEi/JXqKHnnyEniascKi7Dv4x25Cz3TPVZ6H0uvoACwZ2pbVR1f52TcqZt0bUx0EUdzG+aOkX+O/9E1N85d3VtlAdu16jZyEXUF8PjTdC7xbLavSDdZpKnvGJDdcOOFS6ImpsZaKJWr1ajlqKnILu3RTU1TviPYf+qqdBJBwFt0hr7HRkgqbI78/ic5bJ1HH9YqSkk/wxyv2d2Fj85wpax+fgobaTwY6H3NpyxaWg3GVGiSzWqJtCk0syhjWIPmuo3NewISJLXGOlsSE2ON0vBpe1asFqpc2K1nd+nmi0QCFa4KE8+7SbQuK7Y3+6m7efII5gIqjFjUvyyEinUpWhj7dfdg9HjBAIdgpZW/CnTLnM7nSVQsdrqLR3iU0wLfP7EsrTAKFXt1Nw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf9dff2-c1c6-4c89-df78-08d8640b98b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 00:07:04.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDCjsDCCTI27lpzwh8zWc36ZMAtu7VO/7pGnRNBRVMZE+KoIrIthfozhgbAOe6wW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3618
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_25:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280188
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/28/20 5:00 PM, Yaniv Agman wrote:
> Hi Andrii,
> 
> I used BPF skeleton as you suggested, which did work with kernel 4.19
> but not with 4.14.
> I used the exact same program,  same environment, only changed the
> kernel version.
> The error message I get on 4.14:
> 
> libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
> libbpf: failed to determine kprobe perf type: No such file or directory
> libbpf: prog 'kprobe__do_sys_open': failed to create kprobe
> 'do_sys_open' perf event: No such file or directory
> libbpf: failed to auto-attach program 'kprobe__do_sys_open': -2
> failed to attach BPF programs: No such file or directory
> 
> As the program I made is small, I'm copying it here:
> 
> ===========================================
> #include <linux/version.h>
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include <uapi/linux/bpf.h>
> #include <uapi/linux/ptrace.h>
> 
> struct bpf_map_def SEC("maps") open_fds = {
>    .type = BPF_MAP_TYPE_LRU_HASH,
>    .key_size = sizeof(int),
>    .value_size = sizeof(int),
>    .max_entries = 1024,
> };
> 
> SEC("kprobe/do_sys_open")
> int BPF_KPROBE(kprobe__do_sys_open)
> {
>    int err;
> 
>    u32 id = bpf_get_current_pid_tgid();
>    int dfd = PT_REGS_PARM1(ctx);
> 
>    if ((err = bpf_map_update_elem(&open_fds, &id, &dfd, BPF_ANY))) {
>      char log[] = "bpf_map_update_elem %d\n";

put the above definition as global like
const char log[] = "bpf_map_update_elem %d\n";
might help.

>      bpf_trace_printk(log, sizeof(log), err);
>      return 1;
>    }
> 
>    return 0;
> }
> 
> char LICENSE[] SEC("license") = "GPL";
> ==================================================
> 
> Can you think of a reason why this only happens on 4.14?
> 
> Thanks,
> Yaniv
> 
> ‫בתאריך יום ב׳, 28 בספט׳ 2020 ב-23:24 מאת ‪Andrii Nakryiko‬‏
> <‪andrii.nakryiko@gmail.com‬‏>:‬
>>
>> On Mon, Sep 28, 2020 at 1:08 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>>>
>>> ‫בתאריך יום ב׳, 28 בספט׳ 2020 ב-8:50 מאת ‪Andrii Nakryiko‬‏
>>> <‪andrii.nakryiko@gmail.com‬‏>:‬
>>>>
>>>> On Fri, Sep 25, 2020 at 4:58 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> I'm developing a tool which is now based on BCC, and would like to
>>>>> make the move to libbpf.
>>>>> I need the tool to support a minimal kernel version 4.14, which
>>>>> doesn't have CO-RE.
>>>>
>>>> You don't need kernel itself to support CO-RE, you just need that
>>>> kernel to have BTF in it. If the kernel is too old to have
>>>> CONFIG_DEBUG_INFO_BTF config, you can still add BTF by running `pahole
>>>> -J <path-to-vmlinux-image>`, if that's at all an option for your
>>>> setup.
>>>>
>>>
>>> Thanks, I didn't know that
>>>
>>>>>
>>>>> I have read bcc-to-libbpf-howto-guide, and looked at the libbpf-tools of bcc,
>>>>> but both only deal with newer kernels, and I failed to change them to
>>>>> run with a 4.14 kernel.
>>>>>
>>>>> Although some of the bpf samples in the kernel source don't use CO-RE,
>>>>> they all use bpf_load.h,
>>>>> and have dependencies on the tools dir, which I would like to avoid.
>>>>
>>>> Depending on what exactly you are trying to achieve with your BPF
>>>> application, you might not need BPF CO-RE, and using libbpf without
>>>> CO-RE would be enough for your needs. This would be the case if you
>>>> don't need to access any of the kernel data structures (e.g., all sort
>>>> of networking BPF apps: TC programs, cgroup sock progs, XDP). But if
>>>> you need to do anything tracing related (e.g., looking at kernel's
>>>> task_struct or any other internal structure), then you have no choice
>>>> and you either have to do on-the-target-host runtime compilation (BCC
>>>> way) or relocations (libbpf + BPF CO-RE). This is because of changing
>>>> memory layout of kernel structures.
>>>>
>>>> So, unless you can compile one specific version of your BPF code for a
>>>> one specific version of the kernel, you need either BCC or BPF CO-RE.
>>>>
>>>
>>> I'm working on a tracing application
>>> (https://github.com/aquasecurity/tracee) which now uses bcc. We now
>>> require a minimal kernel version 4.14, and bcc, but eventually we
>>> would like to support CO-RE. I thought that we could do the move in
>>> two steps. First moving to libbpf and keeping the 4.14 minimal
>>> requirement, then adding CO-RE support in the future.
>>> In order to do that, I thought of changing bcc requirement to clang
>>> requirement, and compile the program once during installation on the
>>> target host. This way we get the added value of fast start time
>>> without the need to compile every time the program starts (like bcc
>>> does), plus having an easier move to CO-RE in the future.
>>
>> Right, pre-compiling on the target machine with host kernel headers
>> should work. So just don't use any of CO-RE features (no CO-RE
>> relocations, no vmlinux.h), and it should just work.
>>
>>>
>>> A problem that I encountered with kernel 4.14 and libbpf was that when
>>> using bpf_prog_load (If I remember correctly), it returned an error of
>>> invalid argument (-22). Doing a small investigation I saw that it
>>> happened when trying to create bpf maps with names. Indeed I saw that
>>> libbpf API changed between kernel 4.14 and 4.15 and the function
>>> bpf_create_map_node now takes map name as an argument. Is there a way
>>> to workaround this with kernel 4.14 and still use map names in
>>> userspace to refer to bpf maps with libbpf?
>>
>> So we do run a few simple tests loading BPF programs (using libbpf) on
>> 4.9 kernel, so map name should definitely not be a problem at all
>> (libbpf is smart about detecting what's not supported in kernel and
>> omitting non-essential things). It might be because of bpf_prog_load
>> itself, which was long deprecated and you shouldn't use it for
>> real-world applications. Please either use BPF skeleton or bpf_object
>> APIs. It should just work, but if it doesn't please report back.
>>
>>>
>>>>>
>>>>> I would appreciate it if someone can help with a simple working
>>>>> example of using libbpf on 4.14 kernel, without having any
>>>>> dependencies. Specifically, I'm looking for an example makefile, and
>>>>> to know how to load my bpf code with libbpf.
>>>>
>>>> libbpf-tools's Makefile would still work. Just drop dependency on
>>>> vmlinux.h and include system headers directly, if necessary (and if
>>>> you considered implications of kernel memory layout changes).
>>>>
>>>
>>> Thanks, I'll try that
>>>
>>>>>
>>>>> Thanks,
>>>>> Yaniv

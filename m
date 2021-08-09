Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA13E4DCD
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHIUaM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 16:30:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:34670 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhHIUaL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 16:30:11 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDBu9-000Csd-49; Mon, 09 Aug 2021 22:29:49 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDBu8-000W5m-T8; Mon, 09 Aug 2021 22:29:48 +0200
Subject: Re: [PATCH bpf v2 1/2] bpf: don't call
 bpf_get_current_[ancestor_]cgroup_id() in sleepable progs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
References: <20210809060310.1174777-1-yhs@fb.com>
 <20210809060315.1175802-1-yhs@fb.com>
 <CAEf4BzY+-v4NhMmHnr8agjWj6+O7O-J909+TM1HSZUE6WYifrA@mail.gmail.com>
 <0b299368-370f-2292-2ae6-e86a9bc9a240@fb.com>
 <CAEf4BzaoLuTqp+c7HKmV98=v59xWRhAnCBJ8Ztt0=Vk6zavCVg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <db0d54d5-8c11-54f1-45e2-0b85d5f02bd6@iogearbox.net>
Date:   Mon, 9 Aug 2021 22:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaoLuTqp+c7HKmV98=v59xWRhAnCBJ8Ztt0=Vk6zavCVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26258/Mon Aug  9 10:18:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/9/21 7:58 PM, Andrii Nakryiko wrote:
> On Mon, Aug 9, 2021 at 10:41 AM Yonghong Song <yhs@fb.com> wrote:
>> On 8/9/21 10:18 AM, Andrii Nakryiko wrote:
>>> On Sun, Aug 8, 2021 at 11:03 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> Currently, if bpf_get_current_cgroup_id() or
>>>> bpf_get_current_ancestor_cgroup_id() helper is
>>>> called with sleepable programs e.g., sleepable
>>>> fentry/fmod_ret/fexit/lsm programs, a rcu warning
>>>> may appear. For example, if I added the following
>>>> hack to test_progs/test_lsm sleepable fentry program
>>>> test_sys_setdomainname:
>>>>
>>>>     --- a/tools/testing/selftests/bpf/progs/lsm.c
>>>>     +++ b/tools/testing/selftests/bpf/progs/lsm.c
>>>>     @@ -168,6 +168,10 @@ int BPF_PROG(test_sys_setdomainname, struct pt_regs *regs)
>>>>             int buf = 0;
>>>>             long ret;
>>>>
>>>>     +       __u64 cg_id = bpf_get_current_cgroup_id();
>>>>     +       if (cg_id == 1000)
>>>>     +               copy_test++;
>>>>     +
>>>>             ret = bpf_copy_from_user(&buf, sizeof(buf), ptr);
>>>>             if (len == -2 && ret == 0 && buf == 1234)
>>>>                     copy_test++;
>>>>
>>>> I will hit the following rcu warning:
>>>>
>>>>     include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
>>>>     other info that might help us debug this:
>>>>       rcu_scheduler_active = 2, debug_locks = 1
>>>>       1 lock held by test_progs/260:
>>>>         #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xa0
>>>>       stack backtrace:
>>>>       CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      5.14.0-rc2+ #176
>>>>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>>>>       Call Trace:
>>>>         dump_stack_lvl+0x56/0x7b
>>>>         bpf_get_current_cgroup_id+0x9c/0xb1
>>>>         bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
>>>>         bpf_trampoline_6442469132_0+0x2d/0x1000
>>>>         __x64_sys_setdomainname+0x5/0x110
>>>>         do_syscall_64+0x3a/0x80
>>>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>
>>>> I can get similar warning using bpf_get_current_ancestor_cgroup_id() helper.
>>>> syzbot reported a similar issue in [1] for syscall program. Helper
>>>> bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
>>>> has the following callchain:
>>>>      task_dfl_cgroup
>>>>        task_css_set
>>>>          task_css_set_check
>>>> and we have
>>>>      #define task_css_set_check(task, __c)                                   \
>>>>              rcu_dereference_check((task)->cgroups,                          \
>>>>                      lockdep_is_held(&cgroup_mutex) ||                       \
>>>>                      lockdep_is_held(&css_set_lock) ||                       \
>>>>                      ((task)->flags & PF_EXITING) || (__c))
>>>> Since cgroup_mutex/css_set_lock is not held and the task
>>>> is not existing and rcu read_lock is not held, a warning
>>>> will be issued. Note that bpf sleepable program is protected by
>>>> rcu_read_lock_trace().
>>>>
>>>> To fix the issue, let us make these two helpers not available
>>>> to sleepable program. I marked the patch fixing 95b861a7935b
>>>> ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
>>>> which added bpf_get_current_ancestor_cgroup_id() to
>>>> 5.14. I think backporting 5.14 is probably good enough as sleepable
>>>> progrems are not widely used.
>>>>
>>>> This patch should fix [1] as well since syscall program is a sleepable
>>>> program and bpf_get_current_cgroup_id() is not available to
>>>> syscall program any more.
>>>>
>>>>    [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
>>>>
>>>> Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
>>>> Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    kernel/trace/bpf_trace.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>> index b4916ef388ad..eaa8a8ffbe46 100644
>>>> --- a/kernel/trace/bpf_trace.c
>>>> +++ b/kernel/trace/bpf_trace.c
>>>> @@ -1016,9 +1016,11 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>>>    #endif
>>>>    #ifdef CONFIG_CGROUPS
>>>>           case BPF_FUNC_get_current_cgroup_id:
>>>> -               return &bpf_get_current_cgroup_id_proto;
>>>> +               return prog->aux->sleepable ?
>>>> +                      NULL : &bpf_get_current_cgroup_id_proto;
>>>>           case BPF_FUNC_get_current_ancestor_cgroup_id:
>>>> -               return &bpf_get_current_ancestor_cgroup_id_proto;
>>>> +               return prog->aux->sleepable ?
>>>> +                      NULL : &bpf_get_current_ancestor_cgroup_id_proto;
>>>
>>> This feels too extreme. I bet these helpers are as useful in sleepable
>>> BPF progs as they are in non-sleepable ones.
>>>
>>> Why don't we just implement a variant of get_current_cgroup_id (and
>>> the ancestor variant as well) which takes that cgroup_mutex lock, and
>>> just pick the appropriate implementation. Wouldn't that work?
>>
>> This may not work. e.g., for sleepable fentry program,
>> if the to-be-traced function is inside in cgroup_mutex, we will
>> have a deadlock.
> 
> We can also do preempty_disable() + rcu_read_lock() inside the helper
> itself, no? I mean in the new "sleepable" variant.

Yep, we do that for example in c5dbb89fc2ac ("bpf: Expose bpf_get_socket_cookie
to tracing programs") as well (the sock_gen_cookie() disables preemption).

Thanks,
Daniel

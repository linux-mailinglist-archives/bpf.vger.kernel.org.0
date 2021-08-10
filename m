Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853EB3E54C2
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 10:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhHJIJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 04:09:46 -0400
Received: from www62.your-server.de ([213.133.104.62]:51350 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhHJIJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 04:09:37 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDMok-00035w-SS; Tue, 10 Aug 2021 10:08:58 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDMok-0005MJ-M8; Tue, 10 Aug 2021 10:08:58 +0200
Subject: Re: [PATCH bpf v3 1/2] bpf: add rcu read_lock in
 bpf_get_current_[ancestor_]cgroup_id() helpers
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com,
        paulmck@kernel.org
References: <20210809235141.1663247-1-yhs@fb.com>
 <20210809235146.1663522-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d9947aba-ca93-200c-0299-1ab5574aa4c5@iogearbox.net>
Date:   Tue, 10 Aug 2021 10:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210809235146.1663522-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26258/Mon Aug  9 10:18:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ +Paul ]

On 8/10/21 1:51 AM, Yonghong Song wrote:
[...]
> I will hit the following rcu warning:
> 
>    include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
>    other info that might help us debug this:
>      rcu_scheduler_active = 2, debug_locks = 1
>      1 lock held by test_progs/260:
>        #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xa0
>      stack backtrace:
>      CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      5.14.0-rc2+ #176
>      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>      Call Trace:
>        dump_stack_lvl+0x56/0x7b
>        bpf_get_current_cgroup_id+0x9c/0xb1
>        bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
>        bpf_trampoline_6442469132_0+0x2d/0x1000
>        __x64_sys_setdomainname+0x5/0x110
>        do_syscall_64+0x3a/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> I can get similar warning using bpf_get_current_ancestor_cgroup_id() helper.
> syzbot reported a similar issue in [1] for syscall program. Helper
> bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
> has the following callchain:
>     task_dfl_cgroup
>       task_css_set
>         task_css_set_check
> and we have
>     #define task_css_set_check(task, __c)                                   \
>             rcu_dereference_check((task)->cgroups,                          \
>                     lockdep_is_held(&cgroup_mutex) ||                       \
>                     lockdep_is_held(&css_set_lock) ||                       \
>                     ((task)->flags & PF_EXITING) || (__c))
> Since cgroup_mutex/css_set_lock is not held and the task
> is not existing and rcu read_lock is not held, a warning
> will be issued. Note that bpf sleepable program is protected by
> rcu_read_lock_trace().
> 
> The above sleepable bpf programs are already protected
> by migrate_disable(). Adding rcu_read_lock() in these
> two helpers will silence the above warning.
> I marked the patch fixing 95b861a7935b
> ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
> which added bpf_get_current_ancestor_cgroup_id() to tracing programs
> in 5.14. I think backporting 5.14 is probably good enough as sleepable
> progrems are not widely used.
> 
> This patch should fix [1] as well since syscall program is a sleepable
> program protected with migrate_disable().
> 
>   [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
> 
> Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
> Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   kernel/bpf/helpers.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 62cf00383910..4567d2841133 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -353,7 +353,11 @@ const struct bpf_func_proto bpf_jiffies64_proto = {
>   #ifdef CONFIG_CGROUPS
>   BPF_CALL_0(bpf_get_current_cgroup_id)
>   {
> -	struct cgroup *cgrp = task_dfl_cgroup(current);
> +	struct cgroup *cgrp;
> +
> +	rcu_read_lock();
> +	cgrp = task_dfl_cgroup(current);
> +	rcu_read_unlock();
>   
>   	return cgroup_id(cgrp);

I'm a bit confused, if cgroup object relies rcu_read_lock() and not rcu_read_lock_trace()
context, then the above is racy given you access the memory via cgroup_id() outside of it,
same below. If rcu_read_lock_trace() is enough and the above is really just to silence the
'suspicious rcu_dereference_check() usage' splat, then the rcu_dereference_check() from
task_css_set_check() should be extended to check for _trace() flavor instead [meaning, as
a cleaner workaround], which one is it?

>   }
> @@ -366,9 +370,13 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
>   
>   BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
>   {
> -	struct cgroup *cgrp = task_dfl_cgroup(current);
> +	struct cgroup *cgrp;
>   	struct cgroup *ancestor;
>   
> +	rcu_read_lock();
> +	cgrp = task_dfl_cgroup(current);
> +	rcu_read_unlock();
> +
>   	ancestor = cgroup_ancestor(cgrp, ancestor_level);
>   	if (!ancestor)
>   		return 0;
> 

Thanks,
Daniel

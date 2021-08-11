Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64583E97E6
	for <lists+bpf@lfdr.de>; Wed, 11 Aug 2021 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhHKSr1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhHKSr0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 14:47:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA7C061765
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 11:47:02 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z128so6518074ybc.10
        for <bpf@vger.kernel.org>; Wed, 11 Aug 2021 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYsp/urBj0q8R+SDZPazL4JPRcUMib51vL6fsU0fD8g=;
        b=AiJ6L9aKdKoDpm58/nNLb0YYDASMA2ym0yBK8YMJ7q9tp4c7sjcOaYvnnvRMDeD0z+
         F+HEMp1u0YsMkExK+4v6SLxVR/4wksqxriCp+rVUEm2rb9oz5ui5dB9fJ1B5Au2c/3Hy
         WyAfvRnFHJa11Bb2xjcs8/tMQhvQasjlLu4/CGmvnk4+v769PuftFijywSz1RzvhnJhR
         vHvzYD8Jx3xjqx1LCmQ4DHY2H4FXgzwrBXBcHCzapEPZiAjRr7ikv9WJozeRWO5yLlxX
         Bd6k7kgfO7Wa4T/uf/GkQdGgTks8UwklT0unoEf2VZH5mA6hLSgjbG52kBzqTWFgKwFI
         8l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYsp/urBj0q8R+SDZPazL4JPRcUMib51vL6fsU0fD8g=;
        b=BpLc4kPsEKn4AdE+1UtQFQvcNhae2hUl3IWOTvjsRLoQEvlhe9iL/z7j2YI2NlR2um
         3TvmgJ3qA0MZ3u6IU5FfEAhOMIhTMrUp7uuUCd8RjDAPYBv3BnxK3GZvhfLA/J/TnqRF
         vzzQP3hd2XGp0YqGwamFZ+oxbP5BU3FGQS6fyp3wwpMmKLZL8xZfCLP0xBFeI8F7jns1
         1vrthTt6NvStWSBAGyQBtb4OUQuAME7VcaGW97LzyzIPmz8VwUqoOgk0FgylyQ5ZOJDK
         r9xjQ90NAgmOTqLoGm+NJHHHJVOvOCwqD8upMx3vcssRoTKtvdYcRccjOKScdADWEYfd
         kg/g==
X-Gm-Message-State: AOAM533YyZpkOnY8Y7vPlxCHRRI0dta1CxYrMYcBZSQXe5RMHD37r5CS
        6tC7gHAOLokkRPDsJ4NhvFOAUs+WB7jsiDEo2Js=
X-Google-Smtp-Source: ABdhPJzjgT+5tDzVOO28cgdovFdsBwaDoaQkhoAT5SFVmutVbZdJdoiz4OEiqNykZh5ugpHwpFViGAhyBWelk6hhpVo=
X-Received: by 2002:a25:24cd:: with SMTP id k196mr5044868ybk.459.1628707622125;
 Wed, 11 Aug 2021 11:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210810230537.2864668-1-yhs@fb.com>
In-Reply-To: <20210810230537.2864668-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Aug 2021 11:46:51 -0700
Message-ID: <CAEf4BzbJgCHox451DA1p3KFNNyKMf1uomDOmPfdMK9zvbvgbgA@mail.gmail.com>
Subject: Re: [PATCH bpf v4] bpf: add rcu read_lock in bpf_get_current_[ancestor_]cgroup_id()
 helpers
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 10, 2021 at 4:05 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, if bpf_get_current_cgroup_id() or
> bpf_get_current_ancestor_cgroup_id() helper is
> called with sleepable programs e.g., sleepable
> fentry/fmod_ret/fexit/lsm programs, a rcu warning
> may appear. For example, if I added the following
> hack to test_progs/test_lsm sleepable fentry program
> test_sys_setdomainname:
>
>   --- a/tools/testing/selftests/bpf/progs/lsm.c
>   +++ b/tools/testing/selftests/bpf/progs/lsm.c
>   @@ -168,6 +168,10 @@ int BPF_PROG(test_sys_setdomainname, struct pt_regs *regs)
>           int buf = 0;
>           long ret;
>
>   +       __u64 cg_id = bpf_get_current_cgroup_id();
>   +       if (cg_id == 1000)
>   +               copy_test++;
>   +
>           ret = bpf_copy_from_user(&buf, sizeof(buf), ptr);
>           if (len == -2 && ret == 0 && buf == 1234)
>                   copy_test++;
>
> I will hit the following rcu warning:
>
>   include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
>   other info that might help us debug this:
>     rcu_scheduler_active = 2, debug_locks = 1
>     1 lock held by test_progs/260:
>       #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xa0
>     stack backtrace:
>     CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      5.14.0-rc2+ #176
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>     Call Trace:
>       dump_stack_lvl+0x56/0x7b
>       bpf_get_current_cgroup_id+0x9c/0xb1
>       bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
>       bpf_trampoline_6442469132_0+0x2d/0x1000
>       __x64_sys_setdomainname+0x5/0x110
>       do_syscall_64+0x3a/0x80
>       entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> I can get similar warning using bpf_get_current_ancestor_cgroup_id() helper.
> syzbot reported a similar issue in [1] for syscall program. Helper
> bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
> has the following callchain:
>    task_dfl_cgroup
>      task_css_set
>        task_css_set_check
> and we have
>    #define task_css_set_check(task, __c)                                   \
>            rcu_dereference_check((task)->cgroups,                          \
>                    lockdep_is_held(&cgroup_mutex) ||                       \
>                    lockdep_is_held(&css_set_lock) ||                       \
>                    ((task)->flags & PF_EXITING) || (__c))
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
>  [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
>
> Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
> Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/helpers.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> Changelog:
>   v3 -> v4:
>     - ensure rcu_read_lock() region enclosing all accesses to cgroup.

Applied to bpf, thanks!

>   v2 -> v3:
>     - use rcu_read_lock() protection for
>       bpf_get_current_[ancestor_]cgroup_id() helper.
>   v1 -> v2:
>     - disallow bpf_get_current_[ancestor_]cgroup_id() helper.
>

[...]

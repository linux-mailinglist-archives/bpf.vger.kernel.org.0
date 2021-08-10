Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74A3E5054
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhHJA0Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhHJA0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 20:26:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E8AC0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 17:26:03 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z18so32922651ybg.8
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1MtUS+GGUt7Eg7ls2aGrXGss6vhdIDcS/w4ObQjMto=;
        b=dzsKAWhmTAK0K7Ggai0rjnRRjWM6lrfxD1mDjrc8K865ECxsQDalQaVGR47+10kFeU
         Dz99z8e3gN5scjRZDrBN/NVllvvnEbyY1SmCkb6OqQ4C3LNnKUUBgpZZuTk78TA+L6d7
         KlIkqX1uzX5hoqouPUussFmmIQn5WYEgREEiR52RgNK5oYnGTgLXJ94hCVOAlXaYpuu2
         01Pmzl/oI9CuizuW2V8sCibp80e6XIUFSBDsGrlQ2nWs3kSW0WbMJSHF9vWJKWGqGv/Y
         /SRYTmQWFyhj+d1KC8XlCv9HFbJd08yG0eMHgmvkQx6ICgn+VreTNUyhiICy7U2QRAEj
         d8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1MtUS+GGUt7Eg7ls2aGrXGss6vhdIDcS/w4ObQjMto=;
        b=KELzrjdUKqfoDarLwNn6LcEHVIlMELWRn7sGKOfn304C9xgSHzDmkYNeh9lYpb5iW3
         JfHj7Jf8L2RcpW0HuFDKwL4g66LoXQDdSFHUDs5MxwRc0fSQNhFCfT4HTMhW5j5tW5J/
         SCI90eJf2OdajjyTPml9FRtVnFT4wQwZFv14sgAYcaO7Ow9ADEphu9Ru9kR0KR5kK5ue
         xW8r991F+epvY8VrIUAe4QfnkJK9eTCWid2xZPUPEH0Z5q694xguMAH5TvWQmJjTLQLy
         ZT+Erb4KdEGMNsCEhU4dZ6kGg2bWIA9q+yxkSRAh0F1msrjCgDuJmLfcIkwnuBIQTvbU
         oc0g==
X-Gm-Message-State: AOAM531+QSW16vey3BLIJrqroezv4aNZShfCOFmhuMagMYK01r8imWuW
        E6+nkWbmXqK3dm2X1CgPuv2Kf5NPfut5LVPP4Yo=
X-Google-Smtp-Source: ABdhPJzs4OgtvUqcTmg/1vI8AGPwZO5BNzrTvbOo1zmPd8WFO5RKUBdiC5RQFZNSkh2DlcvaZzbeI2kjQr5kB1hk3WQ=
X-Received: by 2002:a5b:648:: with SMTP id o8mr35720583ybq.260.1628555162838;
 Mon, 09 Aug 2021 17:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210809235141.1663247-1-yhs@fb.com> <20210809235146.1663522-1-yhs@fb.com>
In-Reply-To: <20210809235146.1663522-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 Aug 2021 17:25:51 -0700
Message-ID: <CAEf4BzYYzTPdD4so=pD-XmmdjN=JXxWj9LkwhK1qpbsEoP=sBg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: add rcu read_lock in bpf_get_current_[ancestor_]cgroup_id()
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

On Mon, Aug 9, 2021 at 4:51 PM Yonghong Song <yhs@fb.com> wrote:
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

LGTM, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/helpers.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 62cf00383910..4567d2841133 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -353,7 +353,11 @@ const struct bpf_func_proto bpf_jiffies64_proto = {
>  #ifdef CONFIG_CGROUPS
>  BPF_CALL_0(bpf_get_current_cgroup_id)
>  {
> -       struct cgroup *cgrp = task_dfl_cgroup(current);
> +       struct cgroup *cgrp;
> +
> +       rcu_read_lock();
> +       cgrp = task_dfl_cgroup(current);
> +       rcu_read_unlock();
>
>         return cgroup_id(cgrp);
>  }
> @@ -366,9 +370,13 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
>
>  BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
>  {
> -       struct cgroup *cgrp = task_dfl_cgroup(current);
> +       struct cgroup *cgrp;
>         struct cgroup *ancestor;
>
> +       rcu_read_lock();
> +       cgrp = task_dfl_cgroup(current);
> +       rcu_read_unlock();
> +
>         ancestor = cgroup_ancestor(cgrp, ancestor_level);
>         if (!ancestor)
>                 return 0;
> --
> 2.30.2
>

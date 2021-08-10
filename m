Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233C63E7D88
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhHJQcs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 12:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhHJQcr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 12:32:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B217060F02;
        Tue, 10 Aug 2021 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628613145;
        bh=y/9o0ZZbGSbYr24bIz3kWsGEuQu0cTajWixUsQ+eZAo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H5Mhx2D0IYBw3f/yl2SnI8gR6yKianzBAQ45r6p1fpYBC5onjBGzbc3jCggeEKMw3
         j5sHkEwPWT4xvJbDUVsdR/ypMJ6ZuU7NVEMPQ1HgTQtM4jLanasWvEXdW/13VreUF6
         RsuJ8mtWegjMX4pKAvOGPo3DQ0w7WNImoW3nVVTt4kKQa7MNGshTfl6tRWrniR+dxy
         aLRrUmZaKebrAUiJ5NhPyxhodgwh99xpNfDIq1rub+20o8D29u61wWBHGjjwFU2aUU
         t8FT3DAkNRU4gcYyWWs6ex8yWKecxOeJKTUahaXdCQ22G9gkxhvJ8k83CunLpB8QwR
         Ww6POwuQGAHjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 77C115C0527; Tue, 10 Aug 2021 09:32:25 -0700 (PDT)
Date:   Tue, 10 Aug 2021 09:32:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf v3 1/2] bpf: add rcu read_lock in
 bpf_get_current_[ancestor_]cgroup_id() helpers
Message-ID: <20210810163225.GG4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210809235141.1663247-1-yhs@fb.com>
 <20210809235146.1663522-1-yhs@fb.com>
 <d9947aba-ca93-200c-0299-1ab5574aa4c5@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9947aba-ca93-200c-0299-1ab5574aa4c5@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 10, 2021 at 10:08:58AM +0200, Daniel Borkmann wrote:
> [ +Paul ]
> 
> On 8/10/21 1:51 AM, Yonghong Song wrote:
> [...]
> > I will hit the following rcu warning:
> > 
> >    include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> >    other info that might help us debug this:
> >      rcu_scheduler_active = 2, debug_locks = 1
> >      1 lock held by test_progs/260:
> >        #0: ffffffffa5173360 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xa0
> >      stack backtrace:
> >      CPU: 1 PID: 260 Comm: test_progs Tainted: G           O      5.14.0-rc2+ #176
> >      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >      Call Trace:
> >        dump_stack_lvl+0x56/0x7b
> >        bpf_get_current_cgroup_id+0x9c/0xb1
> >        bpf_prog_a29888d1c6706e09_test_sys_setdomainname+0x3e/0x89c
> >        bpf_trampoline_6442469132_0+0x2d/0x1000
> >        __x64_sys_setdomainname+0x5/0x110
> >        do_syscall_64+0x3a/0x80
> >        entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > I can get similar warning using bpf_get_current_ancestor_cgroup_id() helper.
> > syzbot reported a similar issue in [1] for syscall program. Helper
> > bpf_get_current_cgroup_id() or bpf_get_current_ancestor_cgroup_id()
> > has the following callchain:
> >     task_dfl_cgroup
> >       task_css_set
> >         task_css_set_check
> > and we have
> >     #define task_css_set_check(task, __c)                                   \
> >             rcu_dereference_check((task)->cgroups,                          \
> >                     lockdep_is_held(&cgroup_mutex) ||                       \
> >                     lockdep_is_held(&css_set_lock) ||                       \
> >                     ((task)->flags & PF_EXITING) || (__c))
> > Since cgroup_mutex/css_set_lock is not held and the task
> > is not existing and rcu read_lock is not held, a warning
> > will be issued. Note that bpf sleepable program is protected by
> > rcu_read_lock_trace().
> > 
> > The above sleepable bpf programs are already protected
> > by migrate_disable(). Adding rcu_read_lock() in these
> > two helpers will silence the above warning.
> > I marked the patch fixing 95b861a7935b
> > ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
> > which added bpf_get_current_ancestor_cgroup_id() to tracing programs
> > in 5.14. I think backporting 5.14 is probably good enough as sleepable
> > progrems are not widely used.
> > 
> > This patch should fix [1] as well since syscall program is a sleepable
> > program protected with migrate_disable().
> > 
> >   [1] https://lore.kernel.org/bpf/0000000000006d5cab05c7d9bb87@google.com/
> > 
> > Reported-by: syzbot+7ee5c2c09c284495371f@syzkaller.appspotmail.com
> > Fixes: 95b861a7935b ("bpf: Allow bpf_get_current_ancestor_cgroup_id for tracing")
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
> >   kernel/bpf/helpers.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 62cf00383910..4567d2841133 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -353,7 +353,11 @@ const struct bpf_func_proto bpf_jiffies64_proto = {
> >   #ifdef CONFIG_CGROUPS
> >   BPF_CALL_0(bpf_get_current_cgroup_id)
> >   {
> > -	struct cgroup *cgrp = task_dfl_cgroup(current);
> > +	struct cgroup *cgrp;
> > +
> > +	rcu_read_lock();
> > +	cgrp = task_dfl_cgroup(current);
> > +	rcu_read_unlock();
> >   	return cgroup_id(cgrp);
> 
> I'm a bit confused, if cgroup object relies rcu_read_lock() and not rcu_read_lock_trace()
> context, then the above is racy given you access the memory via cgroup_id() outside of it,
> same below. If rcu_read_lock_trace() is enough and the above is really just to silence the
> 'suspicious rcu_dereference_check() usage' splat, then the rcu_dereference_check() from
> task_css_set_check() should be extended to check for _trace() flavor instead [meaning, as
> a cleaner workaround], which one is it?

At first glance, something like this would work from an RCU perspective:

BPF_CALL_0(bpf_get_current_cgroup_id)
{
	struct cgroup *cgrp = task_dfl_cgroup(current);
	struct cgroup *cgrp;
	u64 ret;

	rcu_read_lock();
	cgrp = task_dfl_cgroup(current);
 	ret = cgroup_id(cgrp);
	rcu_read_unlock();
 	return ret;
}

If I am reading the code correctly, rcu_read_lock() is required to keep
the cgroup from going away, and the rcu_read_lock_trace() is needed in
addition in order to keep the BPF program from going away.

There might well be better ways to do this, but the above obeys the
letter of the law.  Or at least the law as I understand it.  ;-)

Or does the fact that a cgroup contains a given task prevent that cgroup
from going away?  (I -think- that tasks can be removed from cgroups
without the cooperation of those tasks, but then again there is much
about cgroups that I do not know.)

							Thanx, Paul

> >   }
> > @@ -366,9 +370,13 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
> >   BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
> >   {
> > -	struct cgroup *cgrp = task_dfl_cgroup(current);
> > +	struct cgroup *cgrp;
> >   	struct cgroup *ancestor;
> > +	rcu_read_lock();
> > +	cgrp = task_dfl_cgroup(current);
> > +	rcu_read_unlock();
> > +
> >   	ancestor = cgroup_ancestor(cgrp, ancestor_level);
> >   	if (!ancestor)
> >   		return 0;
> > 
> 
> Thanks,
> Daniel

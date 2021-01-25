Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041893029B7
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbhAYRyl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 12:54:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731288AbhAYRyZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 12:54:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75C9822D58
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611597223;
        bh=z7ZEwgEyo1DkAbr17wKjs/gmsvfNReQhT8oX1NAoQtc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M5YYk9Q+HiuO1qzfnDuF9GeUcxKmSthOmaUd/6zldqgvLw7/eTTLDeRmqjRFz8KDM
         iWtkIKZ+GsndUKUXe3JS/cu/zTlytjKUpA/tncdvhRlrGm5NzLGTQPewlls/a1RbXL
         Wi6Nb27sNHACADbbFOtEZd0IS3yJ8bMmi0LcDZPXLsJb5l2+ErIAiqyH9d8CjdZsmf
         TIefQkih84ewV1tZPpk593QNC6SGKsjxGRksKoBuZ5k/D4vfZv1yzjYbQWQi955sDE
         2TwT1/zdqD5enlrRn8rUk7AqgxuIILEOiFnsJpzILpcfvW8PbcC4fd8tClTHMPQbU5
         V7KMqVxajg/Ag==
Received: by mail-lf1-f41.google.com with SMTP id v67so19105059lfa.0
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 09:53:43 -0800 (PST)
X-Gm-Message-State: AOAM530F5/DoKl8C/uNYZBixHL3x3xbF0lJMhAXP1Qi4sInrW+DT09QW
        xWPKjqL2BjpWY+ayW5JAdA9JcTsV6E+UBjPlgbIa9Q==
X-Google-Smtp-Source: ABdhPJzLREzSfutcfhEGZ7klxFEWP0ekfWgtDyyGvOKTvWaAjgO4MPmIZN4NJZz9/FQM4GqSLdmbDKCZ3sbGB8sWpMw=
X-Received: by 2002:a19:4941:: with SMTP id l1mr772526lfj.80.1611597220968;
 Mon, 25 Jan 2021 09:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20210123004445.299149-1-kpsingh@kernel.org> <20210123004445.299149-2-kpsingh@kernel.org>
 <0d436bbc-7409-2947-7322-f21241df6025@fb.com> <e539bbeb-a667-6ae1-fe40-ddb30bd7c13d@fb.com>
In-Reply-To: <e539bbeb-a667-6ae1-fe40-ddb30bd7c13d@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 25 Jan 2021 18:53:29 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6SuDm7FzQ5Cqk=BrZf1sykh947SNKJffmC7RYS=dydHA@mail.gmail.com>
Message-ID: <CACYkzJ6SuDm7FzQ5Cqk=BrZf1sykh947SNKJffmC7RYS=dydHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Helper script for running BPF
 presubmit tests
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 6:22 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/24/21 11:06 AM, Yonghong Song wrote:
> >
> >
> > On 1/22/21 4:44 PM, KP Singh wrote:
> >> The script runs the BPF selftests locally on the same kernel image
> >> as they would run post submit in the BPF continuous integration
> >> framework.
> >>
> >> The goal of the script is to allow contributors to run selftests locally
> >> in the same environment to check if their changes would end up breaking
> >> the BPF CI and reduce the back-and-forth between the maintainers and the
> >> developers.
> >>
> >> Signed-off-by: KP Singh <kpsingh@kernel.org>
> >
> > Thanks! I tried the script, and it works great.
> >
> > Tested-by: Yonghong Song <yhs@fb.com>
> >
> > When I tried to apply the patch locally, I see the following warnings:
> > -bash-4.4$ git apply ~/p1.txt
> > /home/yhs/p1.txt:306: space before tab in indent.
> >                  : )
> > /home/yhs/p1.txt:307: space before tab in indent.
> >                          echo "Invalid Option: -$OPTARG requires an
> > argument"
> > warning: 2 lines add whitespace errors.
> >
> > Maybe you want to fix them.
> >
> > One issue I found with the following script,
> > KBUILD_OUTPUT=/home/yhs/work/linux-bld/
> > tools/testing/selftests/bpf/run_in_vm.sh -- cat /sys/fs/bpf/progs.debug
> > I see the following warning:
> >
> > [    1.081000] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid:
> > 101, name: cat
> > [    1.081684] 3 locks held by cat/101:
> > [    1.082032]  #0: ffff8880047770a0 (&p->lock){+.+.}-{3:3}, at:
> > bpf_seq_read+0x3a/0x3d0
> > [    1.082734]  #1: ffffffff82d69800 (rcu_read_lock){....}-{1:2}, at:
> > bpf_iter_run_prog+0x5/0x160
> > [    1.083521]  #2: ffff88800618c148 (&mm->mmap_lock#2){++++}-{3:3}, at:
> > exc_page_fault+0x1a1/0x640
> > [    1.084344] Preemption disabled at:
> > [    1.084346] [<ffffffff8108f913>] migrate_disable+0x33/0x80
> > [    1.085207] CPU: 2 PID: 101 Comm: cat Not tainted
> > 5.11.0-rc4-00524-g6e66fbb10597-dirty #1257
> > [    1.085933] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.9.3-1.el7.centos 04/01
> > /2014
> > [    1.086747] Call Trace:
> > [    1.086961]  dump_stack+0x77/0x97
> > [    1.087294]  ___might_sleep.cold.119+0xf2/0x106
> > [    1.087702]  exc_page_fault+0x1c1/0x640
> > [    1.088056]  asm_exc_page_fault+0x1e/0x30
> > [    1.088413] RIP: 0010:bpf_prog_0a182df2d34af188_dump_bpf_prog+0xf5/0xbc8
> > [    1.089009] Code: 00 00 8b 7d f4 41 8b 76 44 48 39 f7 73 06 48 01 fb
> > 49 89 df 4c 89 7d d8 49 8b
> > bd 20 01 00 00 48 89 7d e0 49 8b bd e0 00 00 00 <48> 8b 7f 20 48 01 d7
> > 48 89 7d e8 48 89 e9 48 83 c
> > 1 d0 48 8b 7d c8
> > [    1.090635] RSP: 0018:ffffc90000197dc8 EFLAGS: 00010282
> > [    1.091100] RAX: 0000000000000000 RBX: ffff888005a60458 RCX:
> > 0000000000000024
> > [    1.091727] RDX: 00000000000002f0 RSI: 0000000000000509 RDI:
> > 0000000000000000
> > [    1.092384] RBP: ffffc90000197e20 R08: 0000000000000001 R09:
> > 0000000000000000
> > [    1.093014] R10: 0000000000000002 R11: 0000000000000000 R12:
> > 0000000000020000
> > [    1.093660] R13: ffff888006199800 R14: ffff88800474c480 R15:
> > ffff888005a60458
> > [    1.094314]  ? bpf_prog_0a182df2d34af188_dump_bpf_prog+0xc8/0xbc8
> > [    1.094871]  bpf_iter_run_prog+0x75/0x160
> > [    1.095231]  __bpf_prog_seq_show+0x39/0x40
> > [    1.095602]  bpf_seq_read+0xf6/0x3d0
> > [    1.095915]  vfs_read+0xa3/0x1b0
> > [    1.096226]  ksys_read+0x4f/0xc0
> > [    1.096527]  do_syscall_64+0x2d/0x40
> > [    1.096831]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [    1.097287] RIP: 0033:0x7f13a43e3ec2
> > [    1.097625] Code: c0 e9 b2 fe ff ff 50 48 8d 3d aa 36 0a 00 e8 65 eb
> > 01 00 0f 1f 44 00 00 f3 0f
> > 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77
> > 56 c3 0f 1f 44 00 00 48 83 e
> > c 28 48 89 54 24
> > [    1.099232] RSP: 002b:00007fffed256bb8 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000000
> > [    1.099922] RAX: ffffffffffffffda RBX: 0000000000020000 RCX:
> > 00007f13a43e3ec2
> > [    1.100576] RDX: 0000000000020000 RSI: 00007f13a42d0000 RDI:
> > 0000000000000003
> > [    1.101197] RBP: 00007f13a42d0000 R08: 00007f13a42cf010 R09:
> > 0000000000000000
> > [    1.101868] R10: 0000000000000022 R11: 0000000000000246 R12:
> > 0000561599794c00
> > [    1.102486] R13: 0000000000000003 R14: 0000000000020000 R15:
> > 0000000000020000
> >
> > Note that above `cat` is called during /sbin/init init process.
> > ......
> > [    0.964879] Run /sbin/init as init process
> > starting pid 84, tty '': '/etc/init.d/rcS'
> > ......
> >
> > I checked the assembly code and the above error info and the reason
> > is due to an exception (address 0) happens in bpf_prog iterator.
> >
> > SEC("iter/bpf_prog")
> > int dump_bpf_prog(struct bpf_iter__bpf_prog *ctx)
> > {
> >          struct seq_file *seq = ctx->meta->seq;
> >          __u64 seq_num = ctx->meta->seq_num;
> >          struct bpf_prog *prog = ctx->prog;
> >          struct bpf_prog_aux *aux;
> >
> >          if (!prog)
> >                  return 0;
> >
> >          aux = prog->aux;
> >          if (seq_num == 0)
> >                  BPF_SEQ_PRINTF(seq, "  id name             attached\n");
> >
> >          BPF_SEQ_PRINTF(seq, "%4u %-16s %s %s\n", aux->id,
> >                         get_name(aux->btf, aux->func_info[0].type_id,
> > aux->name),
> >                         aux->attach_func_name, aux->dst_prog->aux->name);
> >          return 0;
> > }
> >
> > In the above, aux->dst_prog == 0 and exception does not get caught
> > properly and kernel complains. This might be due to
> > ths `cat /sys/fs/bpf/progs.debug` is called too early (in init process)
> > and something is not set up properly yet.
> >
> > In a different rootfs, I called `cat /sys/fs/bpf/progs.debug` after
> > login prompt, and I did not see the error.
> >
> > If somebody knows what is the possible reason, that will be great.
> > Otherwise, I will continue to debug this later.
>
> I did some investigation and found the root cause.
>
> In arch/x86/mm/fault.c, function do_user_addr_fault(),
>
> The following if condition is false when /sys/fs/bpf/progs.debug is
> run during init time and is true when it is run after login prompt.
>
>          if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
>                       !(hw_error_code & X86_PF_USER) &&
>                       !(regs->flags & X86_EFLAGS_AC)))
>          {
>                  bad_area_nosemaphore(regs, hw_error_code, address);
>                  return;
>          }
>
> Specifically, cpu_feature_enabled(X86_FEATURE_SMAP) is false when bpf
> program is run at /sbin/init time and is true after login prompt.
>
> The false condition eventually leads the control to the following
> code in do_user_addr_fault().
>
>          if (unlikely(!mmap_read_trylock(mm))) {
>                  if (!user_mode(regs) &&
> !search_exception_tables(regs->ip)) {
>                          /*
>                           * Fault from code in kernel from
>                           * which we do not expect faults.
>                           */
>                          bad_area_nosemaphore(regs, hw_error_code, address);
>                          return;
>                  }
> retry:
>                  mmap_read_lock(mm);
>          } else {
>                  /*
>                   * The above down_read_trylock() might have succeeded in
>                   * which case we'll have missed the might_sleep() from
>                   * down_read():
>                   */
>                  might_sleep();
>          }
>
> and since mmap_read_trylock(mm) is successful with return value 1,
> might_sleep() is called and hence the warning.

Do you think this needs to be worked around in the script? If so, I would
prefer to do it in a separate patch so that we capture all the details.

- KP

>
> >

[...]

> >> +}
> >> +
> > [...]

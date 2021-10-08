Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC04273D5
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhJHWol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhJHWok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:44:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB471C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:42:44 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z5so24248501ybj.2
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkFJC/12PiIatr+4KcsK8Ah2HXyiM2X7bUZgvOyX6Zw=;
        b=ps/Omu0475S52xCvnDnS1vNVFsa/y1ER8ngnjQoJRs0spuIi1Gdoz86IEkua7Ee9/A
         Usit/mc0wq+6ZvviFEcqZAULnvncn23x3SlBS8KGpYZch/jRn/UFdP9N1tTtZwlWMvCt
         wApo/HxGXmDcCTcn3mLWtlnkRmmhOD2PrQUg3wahOgjnZCJDmvge0UUM9TbWsAL6SgUv
         jW27k5oj5bX+4STU0ESD+gGoEOTt2/8hT44i8//hNTVggXLnRosnUo3irsbaGo75VGP0
         ab3hTikELnwg0Ddrw/dz6PkrwMEtGBPXXRD0w3bDG81Ypbc0sBkRe1SU4zXpobV/Z0AV
         QLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkFJC/12PiIatr+4KcsK8Ah2HXyiM2X7bUZgvOyX6Zw=;
        b=QLl2KG3Kh7Z5iC//MSU3NXGnRMC6L/UWNsYJcAfnJT5mBX6OEmAdxzh0QemSg9dkdE
         iAStS8xbPNPykq4ICZxlS7Hp+mdlBtmsqj/3V0+bG4R4YrzF1VlpV7Tx8OHTdbE544nF
         HWWHZOTDRT8dkXxt+/gdH04DqfN1XpbDI/2JKMeNdZ9Dv5xrV3Cl+kR+IFA7wPiWywec
         tTUKI2lGi8IrsD6Xy27q3yxBmfKminWAa8zQjDV1hd/DZmqnZTqbfv6Z582OU33I+6LA
         1V377nhwz3391Jpmege2S/zgR/h+0gECXJOxM9dfHx9EkfOSuvKbSkKxC45eTm0UL4sY
         rpvw==
X-Gm-Message-State: AOAM532qa7eVyghc3uKhXIhnQvoymavWxJnUF1atG97+XbkbrnDlpr64
        OZYpoOA9GfC2MYujtXLLmxudzuUkxz6xUCmywW2wM9LEAuYYfA==
X-Google-Smtp-Source: ABdhPJySG194IRrZHrFtFbsbE8HZAgpvSlaAzt1aG45aKX36mGW5sr/fWvvu0yjBqxWqr6k1h4MNn+76Zh9gYdJJMYA=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr6581645ybj.504.1633732962661;
 Fri, 08 Oct 2021 15:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <CAEf4BzaE-vXu0zFi=ePTbRfZ=XMCV12oBAz+3p7QBa-E=CAdWw@mail.gmail.com>
In-Reply-To: <CAEf4BzaE-vXu0zFi=ePTbRfZ=XMCV12oBAz+3p7QBa-E=CAdWw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:42:31 -0700
Message-ID: <CAEf4BzZAiZWfKEtc=1qpu8W+WQAcJ6L6BJOftCjjQbF6mzAeoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/14] selftests/bpf: Add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:26 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > This patch series adds "-j" parelell execution to test_progs, with "--debug" to
> > display server/worker communications. Also, some Tests that often fails in
> > parallel are marked as serial test, and it will run in sequence after parallel
> > execution is done.
> >
> > This patch series also adds a error summary after all tests execution finished.
> >
>
> Huge milestone, good job! Applied most patches to bpf-next. See
> comments below in respective patches.
>
> We'll need to iterate on improving the stability of parallel mode, but
> this is a great start. I've dropped a bunch of "fix up" patches where
> I didn't feel confident yet about the approach. We should discuss it
> independently from the parallelization changes in this patch set. See
> some more thoughts below, but overall:
>
> time sudo ./test_progs -j
> ...
> Summary: 181/977 PASSED, 3 SKIPPED, 0 FAILED
>
> real    0m36.949s
> user    0m4.546s
> sys     0m30.872s
>
> VS
>
> $ time sudo ./test_progs
> ...
> Summary: 181/977 PASSED, 3 SKIPPED, 0 FAILED
>
> real    1m3.031s
> user    0m4.157s
> sys     0m28.820s
>
> 2x speed up and the gap will just grow over time as we add more tests.
> And that's also with bpf_verif_scale as is, which we should break up
> into individual tests to parallelize them.
>
> So few things worth mentioning:
>
> 1. To focus future efforts on parallelizing existing tests, we should
> probably emit how long did the test take.
>
> 2. We are losing subtest progress when running in parallel mode. That
> sucks. While it's not easy to parallelize subtests, it's easy to send
> separate logs for each subtest and display them as they come. Let's do
> that?
>
> 3. Parallel execution times are not consistent, once I got 30 seconds
> (which is 8 seconds faster than sequential, I excluded
> bpf_verif_scale), other times it was 45 seconds and more than 1
> minute. Not sure what's going on there, but this doesn't look right.
>
> 4. A bunch of tests still fail from time to time (see examples below).
> What's even scarier that once I got the "failed to determine
> tracepoint perf event ID" message, subsequent sequential executions
> kept failing. I don't see what selftest could have done to cause this,
> so this is concerning and seems to point to the kernel.
> /sys/kernel/debug and /sys/kernel/tracing directories were empty at
> this point. cc Steven, is there any situation when tracefs can become
> "defunct"?
>

Forgot to actually cc Steven, oops. Steven, I've run into the problem
when running a few selftests that do uprobe/kprobe attachment. At some
point, they started complaining that files like
/sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/id don't
exist. And this condition persisted. When I checked
/sys/kernel/debug/tracing in QEMU, it was empty. Is this a known
problem?

> #84 ns_current_pid_tgid:FAIL
> test_current_pid_tgid:PASS:skel_open_load 0 nsec
> test_current_pid_tgid:PASS:stat 0 nsec
> libbpf: failed to determine tracepoint 'syscalls/sys_enter_nanosleep'
> perf event ID: No such file or directory
> libbpf: prog 'handler': failed to create tracepoint
> 'syscalls/sys_enter_nanosleep' perf event: No such file or directory
> libbpf: failed to auto-attach program 'handler': -2
> test_current_pid_tgid:FAIL:skel_attach skeleton attach failed: -2
> #84/1 ns_current_pid_tgid/ns_current_pid_tgid_root_ns:FAIL
> test_ns_current_pid_tgid_new_ns:PASS:clone 0 nsec
> test_ns_current_pid_tgid_new_ns:PASS:waitpid 0 nsec
> test_ns_current_pid_tgid_new_ns:FAIL:newns_pidtgid failed#84/2
> ns_current_pid_tgid/ns_current_pid_tgid_new_ns:FAIL
>
> #88 perf_buffer:FAIL
> serial_test_perf_buffer:PASS:nr_cpus 0 nsec
> serial_test_perf_buffer:PASS:nr_on_cpus 0 nsec
> serial_test_perf_buffer:PASS:skel_load 0 nsec
> libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' perf
> event ID: No such file or directory
> libbpf: prog 'handle_sys_enter': failed to create tracepoint
> 'raw_syscalls/sys_enter' perf event: No such file or directory
> libbpf: failed to auto-attach program 'handle_sys_enter': -2
> serial_test_perf_buffer:FAIL:attach_kprobe err -2
>
> #110 send_signal_sched_switch:FAIL
> serial_test_send_signal_sched_switch:PASS:skel_open_and_load 0 nsec
> libbpf: failed to determine tracepoint 'syscalls/sys_enter_nanosleep'
> perf event ID: No such file or directory
> libbpf: prog 'send_signal_tp': failed to create tracepoint
> 'syscalls/sys_enter_nanosleep' perf event: No such file or directory
> libbpf: failed to auto-attach program 'send_signal_tp': -2
> serial_test_send_signal_sched_switch:FAIL:skel_attach skeleton attach failed
>
> #161 tp_attach_query:FAIL
> serial_test_tp_attach_query:FAIL:open err -1 errno 2
>
> #163 trace_printk:FAIL
> serial_test_trace_printk:PASS:trace_printk__open 0 nsec
> serial_test_trace_printk:PASS:skel->rodata->fmt[0] 0 nsec
> serial_test_trace_printk:PASS:trace_printk__load 0 nsec
> serial_test_trace_printk:PASS:trace_printk__attach 0 nsec
> serial_test_trace_printk:FAIL:fopen(TRACEBUF) unexpected error: -2
>
> #164 trace_vprintk:FAIL
> serial_test_trace_vprintk:PASS:trace_vprintk__open_and_load 0 nsec
> serial_test_trace_vprintk:PASS:trace_vprintk__attach 0 nsec
> serial_test_trace_vprintk:FAIL:fopen(TRACEBUF) unexpected error: -2
>
> #46 fexit_stress:FAIL
> test_fexit_stress:PASS:find_vmlinux_btf_id 0 nsec
> test_fexit_stress:PASS:fexit loaded 0 nsec
> test_fexit_stress:PASS:fexit attach failed 0 nsec
> test_fexit_stress:PASS:fexit loaded 0 nsec
>
> ...
>
> test_fexit_stress:PASS:fexit loaded 0 nsec
> test_fexit_stress:PASS:fexit attach failed 0 nsec
> test_fexit_stress:PASS:fexit loaded 0 nsec
> test_fexit_stress:FAIL:fexit attach failed prog 37 failed: -7 err 7
>
>
>
> > V6 -> V5:
> >   * adding error summary logic for non parallel mode too.
> >   * changed how serial tests are implemented, use main process instead of worker 0.
> >   * fixed a dozen broken test when running in parallel.
> >
> > V5 -> V4:
> >   * change to SOCK_SEQPACKET for close notification.
> >   * move all debug output to "--debug" mode
> >   * output log as test finish, and all error logs again after summary line.
> >   * variable naming / style changes
> >   * adds serial_test_name() to replace serial test lists.
> >
> >
> > Yucong Sun (14):
> >   selftests/bpf: Add parallelism to test_progs
> >   selftests/bpf: Allow some tests to be executed in sequence
> >   selftests/bpf: disable perf rate limiting when running tests.
> >   selftests/bpf: add per worker cgroup suffix
> >   selftests/bpf: adding read_perf_max_sample_freq() helper
> >   selftests/bpf: fix race condition in enable_stats
> >   selftests/bpf: make cgroup_v1v2 use its own port
> >   selftests/bpf: adding a namespace reset for tc_redirect
> >   selftests/bpf: Make uprobe tests use different attach functions.
> >   selftests/bpf: adding pid filtering for atomics test
> >   selftests/bpf: adding random delay for send_signal test
> >   selftests/bpf: Fix pid check in fexit_sleep test
> >   selftests/bpf: increase loop count for perf_branches
> >   selfetest/bpf: make some tests serial
> >
> >  tools/testing/selftests/bpf/cgroup_helpers.c  |   6 +-
> >  tools/testing/selftests/bpf/cgroup_helpers.h  |   2 +-
> >  .../selftests/bpf/prog_tests/atomics.c        |   1 +
> >  .../selftests/bpf/prog_tests/attach_probe.c   |   8 +-
> >  .../selftests/bpf/prog_tests/bpf_cookie.c     |  10 +-
> >  .../bpf/prog_tests/bpf_iter_setsockopt.c      |   2 +-
> >  .../selftests/bpf/prog_tests/bpf_obj_id.c     |   2 +-
> >  .../bpf/prog_tests/cg_storage_multi.c         |   2 +-
> >  .../bpf/prog_tests/cgroup_attach_autodetach.c |   2 +-
> >  .../bpf/prog_tests/cgroup_attach_multi.c      |   2 +-
> >  .../bpf/prog_tests/cgroup_attach_override.c   |   2 +-
> >  .../selftests/bpf/prog_tests/cgroup_link.c    |   2 +-
> >  .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   2 +-
> >  .../selftests/bpf/prog_tests/check_mtu.c      |   2 +-
> >  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |   3 +-
> >  .../prog_tests/flow_dissector_load_bytes.c    |   2 +-
> >  .../bpf/prog_tests/flow_dissector_reattach.c  |   2 +-
> >  .../bpf/prog_tests/get_branch_snapshot.c      |   2 +-
> >  .../selftests/bpf/prog_tests/kfree_skb.c      |   3 +-
> >  .../bpf/prog_tests/migrate_reuseport.c        |   2 +-
> >  .../selftests/bpf/prog_tests/modify_return.c  |   3 +-
> >  .../bpf/prog_tests/ns_current_pid_tgid.c      |   3 +-
> >  .../selftests/bpf/prog_tests/perf_branches.c  |  10 +-
> >  .../selftests/bpf/prog_tests/perf_buffer.c    |   2 +-
> >  .../selftests/bpf/prog_tests/perf_link.c      |   5 +-
> >  .../selftests/bpf/prog_tests/probe_user.c     |   3 +-
> >  .../bpf/prog_tests/raw_tp_writable_test_run.c |   3 +-
> >  .../bpf/prog_tests/select_reuseport.c         |   2 +-
> >  .../selftests/bpf/prog_tests/send_signal.c    |   6 +-
> >  .../bpf/prog_tests/send_signal_sched_switch.c |   3 +-
> >  .../bpf/prog_tests/sk_storage_tracing.c       |   2 +-
> >  .../selftests/bpf/prog_tests/snprintf_btf.c   |   2 +-
> >  .../selftests/bpf/prog_tests/sock_fields.c    |   2 +-
> >  .../selftests/bpf/prog_tests/sockmap_listen.c |   2 +-
> >  .../bpf/prog_tests/stacktrace_build_id_nmi.c  |  19 +-
> >  .../selftests/bpf/prog_tests/task_pt_regs.c   |   8 +-
> >  .../selftests/bpf/prog_tests/tc_redirect.c    |  14 +
> >  .../testing/selftests/bpf/prog_tests/timer.c  |   3 +-
> >  .../selftests/bpf/prog_tests/timer_mim.c      |   2 +-
> >  .../bpf/prog_tests/tp_attach_query.c          |   2 +-
> >  .../selftests/bpf/prog_tests/trace_printk.c   |   2 +-
> >  .../selftests/bpf/prog_tests/trace_vprintk.c  |   2 +-
> >  .../bpf/prog_tests/trampoline_count.c         |   3 +-
> >  .../selftests/bpf/prog_tests/xdp_attach.c     |   2 +-
> >  .../selftests/bpf/prog_tests/xdp_bonding.c    |   2 +-
> >  .../bpf/prog_tests/xdp_cpumap_attach.c        |   2 +-
> >  .../bpf/prog_tests/xdp_devmap_attach.c        |   2 +-
> >  .../selftests/bpf/prog_tests/xdp_info.c       |   2 +-
> >  .../selftests/bpf/prog_tests/xdp_link.c       |   2 +-
> >  tools/testing/selftests/bpf/progs/atomics.c   |  16 +
> >  .../selftests/bpf/progs/connect4_dropper.c    |   2 +-
> >  .../testing/selftests/bpf/progs/fexit_sleep.c |   4 +-
> >  .../selftests/bpf/progs/test_enable_stats.c   |   2 +-
> >  tools/testing/selftests/bpf/test_progs.c      | 671 +++++++++++++++++-
> >  tools/testing/selftests/bpf/test_progs.h      |  37 +-
> >  55 files changed, 790 insertions(+), 116 deletions(-)
> >
> > --
> > 2.30.2
> >

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11B134080F
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 15:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhCROn2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 10:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229960AbhCROnP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 10:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616078594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPcMM3n8/pYC84E3p9b1l5ECBBMPXnd1iVtKwDS7AmM=;
        b=hejiSka0kirZ9KlvzmdbHpWhhHK8j88GwPVPjJ9grUGyUTWEzWIqEN6ANQdeOdaESNNauh
        WYFCFnTLeMp+FKKL+d7nrWV/0xfKsjVMQmrgWq963aZCq9W+Yi31/u9gMZXCcRbS7gkequ
        ha4UZ86N7e2OOg39/cFJZPuc1H5TuNs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-JFVDrdXaN5i3BCbC4IbekA-1; Thu, 18 Mar 2021 10:43:12 -0400
X-MC-Unique: JFVDrdXaN5i3BCbC4IbekA-1
Received: by mail-wr1-f72.google.com with SMTP id o11so4207744wrc.4
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 07:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPcMM3n8/pYC84E3p9b1l5ECBBMPXnd1iVtKwDS7AmM=;
        b=uLfVpg7kv9lRq9rkt3Q2t4CqPMAEB20xY01hy6G29WlBZwpFa38Uu3Eh+1Rimhfwei
         KSp4WuPvj0tNougym0UTx+e3+aq6lcJ1270B5ocenDsBYNqRMQMJffhXq/u+mgmLgsao
         uRRgQ8a63e5pOqITbosb7oAKxPGQA6Gm24KWiqq4hdVIaS1BpYvfvJOwGaCxWOxTm77w
         BfG6Zt2+WYTiWKCBcyHLjIImWLj0RWM0qpyg98ciioh1g54yi8Z99ek4A3VgOt1FKGEH
         KRRXa0suN+b7r1SKXDHMk+XGHZbfvhvA7jyyYM+RsG2pgKf5J/mRUaZflfH3QE4SOUpd
         IQVg==
X-Gm-Message-State: AOAM531AoOqiodcqfGBcZM7SkoVvvPQUhWIMsm2USI6czlJrfPWyNUV5
        RDn/ulHBGnt1uwlT5rW45bWp74nhGdmVRNsoVet2TeGUkbM+A4qNBvMxBPiHahw3Gd3/XiAaJj7
        dDLk7/IjZl4mBC9+BxZP2eIOYpSpa
X-Received: by 2002:a7b:c119:: with SMTP id w25mr3902675wmi.127.1616078591476;
        Thu, 18 Mar 2021 07:43:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc91/rmskzXwDPJOXr+NnjFFqgVZqspjAtksuNV6aqn4sURUFqcRtOzXWbLKC29K147a03NojCoQ6YBocVmxw=
X-Received: by 2002:a7b:c119:: with SMTP id w25mr3902658wmi.127.1616078591263;
 Thu, 18 Mar 2021 07:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <2ed7a55e-7def-7faf-fc47-991b867bff9e@iogearbox.net>
 <CANYvDQOfygmqv0V-1PuzXV8ZFzk0uD566oEF3v9uX21G4fSFKg@mail.gmail.com>
 <1e410caf-019a-ade7-465d-3d936d2f7dc6@iogearbox.net> <5845cef9-5aaf-f85e-8280-472f61ddaeed@iogearbox.net>
 <CANYvDQNCKmEy9ZzPRvhNYvK0=TKk1pRS=seUuAkby92ic8tVqw@mail.gmail.com>
 <f97bd923-bf12-69a0-f0a8-c9a764abbed2@iogearbox.net> <YFIwzhE00OpU1zro@krava>
 <ff0db44e-aa55-da94-785f-ba10792a5ae1@iogearbox.net> <YFKOeGqUwBPTkPzT@krava>
 <61494cfb-1ceb-4886-3023-1ac0b35697d6@iogearbox.net> <YFM+Ijeu4bN4IzH1@krava>
In-Reply-To: <YFM+Ijeu4bN4IzH1@krava>
From:   Serhei Makarov <smakarov@redhat.com>
Date:   Thu, 18 Mar 2021 10:43:00 -0400
Message-ID: <CANYvDQN7H5tVp47fbYcRasv4XF07eUbsDwT_eDCHXJUj43J7jQ@mail.gmail.com>
Subject: deadlock bug related to bpf,audit subsystems
To:     linux-audit@redhat.com, bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        Frank Eigler <fche@redhat.com>, guro@fb.com,
        Jerome Marchand <jmarchan@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Serhei Makarov <smakarov@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Moving this discussion to kernel mailing lists.

Problem description:

Upstream kernel 5.11.0-rc7 and later was found to deadlock during a
bpf_probe_read_compat call within a sched_switch tracepoint. The
problem is reproducible with the reg_alloc3 testcase from SystemTap's
BPF backend testsuite on x86_64 as well as the runqlat,runqslower
tools from bcc on ppc64le. Example stack trace from [1]:

[  730.868702] stack backtrace:
[  730.869590] CPU: 1 PID: 701 Comm: in:imjournal Not tainted
5.12.0-0.rc2.20210309git144c79ef3353.166.fc35.x86_64 #1
[  730.871605] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.13.0-2.fc32 04/01/2014
[  730.873278] Call Trace:
[  730.873770]  dump_stack+0x7f/0xa1
[  730.874433]  check_noncircular+0xdf/0x100
[  730.875232]  __lock_acquire+0x1202/0x1e10
[  730.876031]  ? __lock_acquire+0xfc0/0x1e10
[  730.876844]  lock_acquire+0xc2/0x3a0
[  730.877551]  ? __wake_up_common_lock+0x52/0x90
[  730.878434]  ? lock_acquire+0xc2/0x3a0
[  730.879186]  ? lock_is_held_type+0xa7/0x120
[  730.880044]  ? skb_queue_tail+0x1b/0x50
[  730.880800]  _raw_spin_lock_irqsave+0x4d/0x90
[  730.881656]  ? __wake_up_common_lock+0x52/0x90
[  730.882532]  __wake_up_common_lock+0x52/0x90
[  730.883375]  audit_log_end+0x5b/0x100
[  730.884104]  slow_avc_audit+0x69/0x90
[  730.884836]  avc_has_perm+0x8b/0xb0
[  730.885532]  selinux_lockdown+0xa5/0xd0
[  730.886297]  security_locked_down+0x20/0x40
[  730.887133]  bpf_probe_read_compat+0x66/0xd0
[  730.887983]  bpf_prog_250599c5469ac7b5+0x10f/0x820
[  730.888917]  trace_call_bpf+0xe9/0x240
[  730.889672]  perf_trace_run_bpf_submit+0x4d/0xc0
[  730.890579]  perf_trace_sched_switch+0x142/0x180
[  730.891485]  ? __schedule+0x6d8/0xb20
[  730.892209]  __schedule+0x6d8/0xb20
[  730.892899]  schedule+0x5b/0xc0
[  730.893522]  exit_to_user_mode_prepare+0x11d/0x240
[  730.894457]  syscall_exit_to_user_mode+0x27/0x70
[  730.895361]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Jiri Olsa also reports seeing a similar deadlock at v5.10. I'm in the
middle of double-checking my bisection which ended up at a
seemingly-unrelated commit [2]

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1938312
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.11-rc7&id=2dcb3964544177c51853a210b6ad400de78ef17d

Reasonable amount of context below:

On Thu, Mar 18, 2021 at 7:48 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > In that case the issue is in the selinux / audit department, not on bpf side.
> >
> > To be honest, I'm actually puzzled that from bpf_probe_read_*() we end up sending
> > audit messages, this seems highly questionable given those BPF helpers are used in
> > performance critical code, and they can be called from any contexts. So going and
> > allocating an skb for audit is just completely wrong. It should probably be at min
> > avc_has_perm_noaudit() if anything ...
>
> I just noticed this discussion is not on the list ;-)
> let's bring it there and include some audit folks

Yes, my apologies. This started as a quick note from me to Daniel to
glance at the RHBZ and the cc:s gradually snowballed from there.

- Serhei

> jirka
>
> >
> > > ----
> > > [   56.866377] =============================
> > > [   56.866397] [ BUG: Invalid wait context ]
> > > [   56.866407] 5.11.0 #4 Tainted: G            E
> > > [   56.866420] -----------------------------
> > > [   56.866438] swapper/69/0 is trying to lock:
> > > [   56.866458] c000000002120038 (notif_lock){....}-{3:3}, at: avc_compute_av.isra.0+0x14c/0x430
> > > [   56.866508] other info that might help us debug this:
> > > [   56.866528] context-{2:2}
> > > [   56.866545] 3 locks held by swapper/69/0:
> > > [   56.866566]  #0: c000001fff1f7a98 (&rq->lock){-.-.}-{2:2}, at: sched_ttwu_pending+0x5c/0x1e0
> > > [   56.866613]  #1: c00000000208b9d8 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run1+0x8/0x240
> > > [   56.866659]  #2: c00000000208b9d8 (rcu_read_lock){....}-{1:3}, at: avc_compute_av.isra.0+0x7c/0x430
> > > [   56.866704] stack backtrace:
> > > [   56.866724] CPU: 69 PID: 0 Comm: swapper/69 Tainted: G            E     5.11.0 #4
> > > [   56.866761] Call Trace:
> > > [   56.866778] [c0000000109fb310] [c000000000a42784] dump_stack+0xe8/0x144 (unreliable)
> > > [   56.866817] [c0000000109fb360] [c0000000001f02a0] __lock_acquire+0xaa0/0x2800
> > > [   56.866857] [c0000000109fb490] [c0000000001f2b40] lock_acquire.part.0+0xc0/0x390
> > > [   56.866885] [c0000000109fb570] [c00000000118af0c] _raw_spin_lock_irqsave+0x6c/0xc0
> > > [   56.866923] [c0000000109fb5b0] [c00000000089cc4c] avc_compute_av.isra.0+0x14c/0x430
> > > [   56.866961] [c0000000109fb670] [c00000000089e0a0] avc_has_perm+0x2c0/0x300
> > > [   56.866997] [c0000000109fb780] [c0000000008a7d34] selinux_lockdown+0xd4/0x100
> > > [   56.867034] [c0000000109fb810] [c000000000891140] security_locked_down+0x50/0xb0
> > > [   56.867086] [c0000000109fb840] [c000000000346b7c] bpf_probe_read_compat+0xbc/0x130
> > > [   56.867125] [c0000000109fb880] [c00800000e63bd38] bpf_prog_3de2db9929262fab_raw_tracepoint__sched_wakeup+0x5c/0x4324
> > > [   56.867167] [c0000000109fb8f0] [c000000000349784] bpf_trace_run1+0xe4/0x240
> > > [   56.867204] [c0000000109fb940] [c00000000018f238] __bpf_trace_sched_wakeup_template+0x18/0x30
> > > [   56.867243] [c0000000109fb960] [c000000000190834] trace_sched_wakeup+0xe4/0x200
> > > [   56.867281] [c0000000109fb9a0] [c0000000001983bc] ttwu_do_wakeup+0x4c/0x1f0
> > > [   56.867317] [c0000000109fba20] [c00000000019c190] sched_ttwu_pending+0x120/0x1e0
> > > [   56.867355] [c0000000109fbac0] [c00000000026cd6c] flush_smp_call_function_queue+0x1bc/0x3c0
> > > [   56.867397] [c0000000109fbb50] [c000000000059fd4] smp_ipi_demux_relaxed+0xf4/0x100
> > > [   56.867436] [c0000000109fbb90] [c0000000000537fc] doorbell_exception+0xbc/0x370
> > > [   56.867474] [c0000000109fbbd0] [c0000000000168d4] replay_soft_interrupts+0x1f4/0x2d0
> > > [   56.867512] [c0000000109fbdb0] [c000000000016a20] arch_local_irq_restore+0x70/0xe0
> > > [   56.867550] [c0000000109fbde0] [c000000000df9d34] cpuidle_enter_state+0x124/0x500
> > > [   56.867587] [c0000000109fbe40] [c000000000dfa1ac] cpuidle_enter+0x4c/0x70
> > > [   56.867613] [c0000000109fbe80] [c0000000001a5dc8] do_idle+0x338/0x450
> > > [   56.867649] [c0000000109fbf10] [c0000000001a62bc] cpu_startup_entry+0x3c/0x40
> > > [   56.867686] [c0000000109fbf40] [c00000000005ac34] start_secondary+0x2a4/0x2b0
> > > [   56.867727] [c0000000109fbf90] [c00000000000c054] start_secondary_prolog+0x10/0x14
> > >
> >
>


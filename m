Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279674276DC
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 05:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhJIDQ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 23:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhJIDQ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 23:16:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F24C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 20:15:01 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z5so25128597ybj.2
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=geVXmNhoJ/bnRrBpJOj9sFJnu7l2mcrFALBF9VtPjo4=;
        b=qtLz1Os4dzsSFNYcwuFvzQmJH5pCORAdf43nnUjMq6rIy3VhETNyVnwXUCD8xkXGo4
         MSypHXkY969wu8OFGyFB6u6VtW8HNLUrzYGqYVO+heG6KOwtFYUM2+2zKTQ3ewms5jcm
         DvE2lGG2xQHiYnv2gSaJizZ4E+9Z3h6toqNH+2GxyuHPoYMjb86Kn/TmiAmWZnINYdxA
         u2WXGHXMoriHjCTZk8mB+T733Clqpx6SHPJl8XrL0WH/tWTt0UgIbP+BYDF3gyBKu3f1
         wqezzFBQs8iyhkBchylLvTJ7PUNpoWehGvD5r9ylHSFdD1rEuA+AfTzQ59l9P8gHo9Dv
         zJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=geVXmNhoJ/bnRrBpJOj9sFJnu7l2mcrFALBF9VtPjo4=;
        b=nKk/kvsgbjWQYe2CEhLpJyA//OEn8Ev0AH105M8Z/mIQ3oOK3dbZUe+Lry7FbrQ11G
         cykwUOq+w/Iqhs0BoiIKDo3gQ4zVatsG6wcJJ9jln/APhmkZebq0xZ5TvwpBGL3qBhfQ
         boO48NeXco4ucfLHVdF5RJlpnZqVRSHYHb8NEsXLRAVPMsmr2c9jvt4VLefgb3ie2fS2
         i7UWYJBq37elNgTzQ8V984L7IPOgIHGM+may2p5zgHG1KGsc0JfU5bdAEqOtI1pKzEqW
         9UwyFes49nbLux/yEsXbJCn0J+YiC72kdKE8gaTA9/WJlBHQCTxLuXThBmLzXr4gZG1D
         0mdA==
X-Gm-Message-State: AOAM530UbnikY784Hwef84pCcbGPspn/bYZEtzlub/rkzOpkldCfSP56
        BxpJpJrm9dYHHHjF/qlE2SFPXDD//X3sl2UBLjHYnMWhmmM=
X-Google-Smtp-Source: ABdhPJzG2pIFw7w8Y+gReXUE51OmTqNH1wZ5klu1NCuyoBSs6rqHPFTf4CY3Oy818UDeRfjh5NaBoWAddbz1hGE+nLs=
X-Received: by 2002:a25:5606:: with SMTP id k6mr7404913ybb.51.1633749300628;
 Fri, 08 Oct 2021 20:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-15-fallentree@fb.com>
 <CAEf4BzYfmMOpfZ2ti-e9z-1_oB4_E0R064_RD8a_QDt2=JLsnQ@mail.gmail.com> <CAJygYd09TT9N5PYMv48bJp7wgVCqj4o5vMjMMk6m1z7+A=fpHg@mail.gmail.com>
In-Reply-To: <CAJygYd09TT9N5PYMv48bJp7wgVCqj4o5vMjMMk6m1z7+A=fpHg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 20:14:47 -0700
Message-ID: <CAEf4BzZxTf6WcJ4Q_0DNAHLFTYbs+LGF+et6etDMChaD+pzfHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 14/14] selfetest/bpf: make some tests serial
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:55 PM sunyucong@gmail.com <sunyucong@gmail.com> wrote:
>
> On Fri, Oct 8, 2021 at 3:27 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> > >
> > > From: Yucong Sun <sunyucong@gmail.com>
> > >
> > > Change tests that often fails in parallel execution mode to serial.
> > >
> > > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > > ---
> >
> > I hope we'll be able to parallelise these tests over time. See some
> > notes on cover letter for how to target this effort better. But here's
> > another thought I had while thinking about this.
> >
> > Some tests are inherently testing unshareable resources, e.g., like
> > XDP tests. So we might never be able to completely parallelize all the
> > tests. But it probably will be too restrictive to just bunde all of
> > them into the one "serial" group of tests. It's a good starting point,
> > but I think we'll have to have something like "serialization" group,
> > where we'll be able to mark a bunch of tests like
> > "serial_xdp_<testname>" and each test with "serial_xdp_" prefix will
> > run sequentially relative to each other, but they might run completely
> > parallel to, say, "serial_perf_" tests. WDYT?
>
> I think someone was talking about being able to attach multiple XDP
> programs in the future?
>

that's all built on top of single XDP attach point using a bunch of
conventions, so that's not a solution here

> another approach I want to suggest is for each test to test for
> EBUSY/EEXIST error code on attach and simply sleep/retry,  Then in the
> future when it doesn't return this error there is nothing to change on
> test side.

This won't work reliably, sometimes test just makes some system-wide
assumptions or modifications, it's not always resulting in EBUSY

> >
> >
> > >  tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c   | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c            | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c      | 2 +-
> > >  .../selftests/bpf/prog_tests/cgroup_attach_autodetach.c        | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c   | 2 +-
> > >  .../testing/selftests/bpf/prog_tests/cgroup_attach_override.c  | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/cgroup_link.c           | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/check_mtu.c             | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c         | 3 ++-
> > >  .../selftests/bpf/prog_tests/flow_dissector_load_bytes.c       | 2 +-
> > >  .../testing/selftests/bpf/prog_tests/flow_dissector_reattach.c | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c   | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/kfree_skb.c             | 3 ++-
> > >  tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c     | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/modify_return.c         | 3 ++-
> > >  tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c   | 3 ++-
> > >  tools/testing/selftests/bpf/prog_tests/perf_buffer.c           | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
> > >  tools/testing/selftests/bpf/prog_tests/probe_user.c            | 3 ++-
> > >  .../selftests/bpf/prog_tests/raw_tp_writable_test_run.c        | 3 ++-
> > >  tools/testing/selftests/bpf/prog_tests/select_reuseport.c      | 2 +-
> > >  .../selftests/bpf/prog_tests/send_signal_sched_switch.c        | 3 ++-
> > >  tools/testing/selftests/bpf/prog_tests/sk_storage_tracing.c    | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/snprintf_btf.c          | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/sock_fields.c           | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c        | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/timer.c                 | 3 ++-
> > >  tools/testing/selftests/bpf/prog_tests/timer_mim.c             | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/tp_attach_query.c       | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/trace_printk.c          | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/trace_vprintk.c         | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/trampoline_count.c      | 3 ++-
> > >  tools/testing/selftests/bpf/prog_tests/xdp_attach.c            | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c           | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c     | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c     | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/xdp_info.c              | 2 +-
> > >  tools/testing/selftests/bpf/prog_tests/xdp_link.c              | 2 +-
> > >  38 files changed, 48 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> > > index 85babb0487b3..b52ff8ce34db 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> > > @@ -179,7 +179,7 @@ static void do_bpf_iter_setsockopt(struct bpf_iter_setsockopt *iter_skel,
> > >         free_fds(est_fds, nr_est);
> > >  }
> > >
> >
> > [...]

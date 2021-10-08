Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC814273F5
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbhJHW5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHW5b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:57:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650C6C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:55:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id j5so45106088lfg.8
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gy2YYuuDxyxSD4ACl/9xwpW7I8BqkQz386riRFoXoA=;
        b=Grat8kOh94wrHYWtqQ+yY3xCRV/XtN2VmCcix+9TGkUf2v7xpYhGiVFTvwhQmH0ojM
         CxZySxuHWn+u1gCi7Ih8iBj1q5LLhq/ZVRdspWCPmlEzpLDB3cIPrOoK75q4K2RE3Dyc
         59AMi+XLcScZTe2uuEdaWSIFQkzK7zpEGgZzkIby8Jjj1brDVuc+Uce2srXc8Jlh2gAD
         Akxe3vu6E3SyIU5NOBymCfPv5fMNcBjEY9fADCGGU7hzkr5NbpWreE2mPgHulPcn6ZBv
         VI6v9bUqbQgxOyqDN3TNLRXH3NYKScI53qUyTu1nYuYm6XbAr4iJhGNCIFvSA2WsjiOc
         iMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gy2YYuuDxyxSD4ACl/9xwpW7I8BqkQz386riRFoXoA=;
        b=Z4Q1BLgEjtFWeAgOrKkQJF5+Y/brkCHmfzKFzgwWb8tW+nXtZRfK8Ieyq3I76q8av/
         T0aA1Kide3kKJNFlzNpPljEL07NzkQXpwzUA9Mi5t/QykyF74px9k6DgPwLRNGhdWzbd
         zX81V1dc15HuPIT4jkYtS4QgNr9IMlsowspZOujUk90RjQ03WjWmZ62SKPKXJNDkG1Cf
         2t9b1fdz4P8BRuJVljDFMM3yVrBe3Z8j36+m4XC0Fy30FfUMcva3qNSALnS2nWljZ6bh
         YAqgK74E0uOmGR2cop4Wr68HgTeRPFc9QMSua7ei2jAaK2sRvxNyCkR85UU+2FLZppyE
         hdsw==
X-Gm-Message-State: AOAM530Oz8R2GVhXUL/lJwMXyGhj24vRdzZ1u+ZpAOmzgj/T7jok6Zuq
        LciWmVt+thB8DE3A8hzyKu8YDJ86DaRDDcb8ouk=
X-Google-Smtp-Source: ABdhPJzGJqbqfsUFG1vZwbBTnr1vNEBMdEAUCs5qj9sM0aNBaQVFQujolYQYnLtTvcV1Ye4JQ3lWZXOq9kktumJ7ohs=
X-Received: by 2002:a2e:9f10:: with SMTP id u16mr6175673ljk.143.1633733733565;
 Fri, 08 Oct 2021 15:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-15-fallentree@fb.com>
 <CAEf4BzYfmMOpfZ2ti-e9z-1_oB4_E0R064_RD8a_QDt2=JLsnQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYfmMOpfZ2ti-e9z-1_oB4_E0R064_RD8a_QDt2=JLsnQ@mail.gmail.com>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Fri, 8 Oct 2021 15:55:07 -0700
Message-ID: <CAJygYd09TT9N5PYMv48bJp7wgVCqj4o5vMjMMk6m1z7+A=fpHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 14/14] selfetest/bpf: make some tests serial
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yucong Sun <fallentree@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 3:27 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > Change tests that often fails in parallel execution mode to serial.
> >
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
>
> I hope we'll be able to parallelise these tests over time. See some
> notes on cover letter for how to target this effort better. But here's
> another thought I had while thinking about this.
>
> Some tests are inherently testing unshareable resources, e.g., like
> XDP tests. So we might never be able to completely parallelize all the
> tests. But it probably will be too restrictive to just bunde all of
> them into the one "serial" group of tests. It's a good starting point,
> but I think we'll have to have something like "serialization" group,
> where we'll be able to mark a bunch of tests like
> "serial_xdp_<testname>" and each test with "serial_xdp_" prefix will
> run sequentially relative to each other, but they might run completely
> parallel to, say, "serial_perf_" tests. WDYT?

I think someone was talking about being able to attach multiple XDP
programs in the future?

another approach I want to suggest is for each test to test for
EBUSY/EEXIST error code on attach and simply sleep/retry,  Then in the
future when it doesn't return this error there is nothing to change on
test side.
>
>
> >  tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c   | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c            | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c      | 2 +-
> >  .../selftests/bpf/prog_tests/cgroup_attach_autodetach.c        | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c   | 2 +-
> >  .../testing/selftests/bpf/prog_tests/cgroup_attach_override.c  | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/cgroup_link.c           | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/check_mtu.c             | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c         | 3 ++-
> >  .../selftests/bpf/prog_tests/flow_dissector_load_bytes.c       | 2 +-
> >  .../testing/selftests/bpf/prog_tests/flow_dissector_reattach.c | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c   | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/kfree_skb.c             | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c     | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/modify_return.c         | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c   | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/perf_buffer.c           | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/probe_user.c            | 3 ++-
> >  .../selftests/bpf/prog_tests/raw_tp_writable_test_run.c        | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/select_reuseport.c      | 2 +-
> >  .../selftests/bpf/prog_tests/send_signal_sched_switch.c        | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/sk_storage_tracing.c    | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/snprintf_btf.c          | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/sock_fields.c           | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c        | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/timer.c                 | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/timer_mim.c             | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/tp_attach_query.c       | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/trace_printk.c          | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/trace_vprintk.c         | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/trampoline_count.c      | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/xdp_attach.c            | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c           | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c     | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c     | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/xdp_info.c              | 2 +-
> >  tools/testing/selftests/bpf/prog_tests/xdp_link.c              | 2 +-
> >  38 files changed, 48 insertions(+), 38 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> > index 85babb0487b3..b52ff8ce34db 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> > @@ -179,7 +179,7 @@ static void do_bpf_iter_setsockopt(struct bpf_iter_setsockopt *iter_skel,
> >         free_fds(est_fds, nr_est);
> >  }
> >
>
> [...]

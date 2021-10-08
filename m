Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242414273C4
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbhJHW3f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbhJHW3e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 18:29:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA0FC061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 15:27:38 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i84so24071867ybc.12
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPGNGpuXsSj7iImL7Bk1uRzQFazCObJX8Z7FSku7rwk=;
        b=KBZtDFZtfTXYUg7LbzK5l+yazPlfitMwck1zs73/d6XOYg+pKgOWrtBVCQPY/NEAPX
         WepItpzXhl7DFMQ/oaINJxzlmrBwD3nbMLexuQOkjH/ZJcn0eArikaityq79yT7SG8MF
         oBHdMKWiMeEcVgoFR7KzyyfiAg/zS29YzERLSiAIaljdm8ysEmTwr0KK/QW5ugt/oA7J
         nDMa3tKSSASVhVveW8VCgB3Pk+d/NShC/PsVT6DebHRoHV5l97xnMR2OQafpSTQYF8Up
         vJgM6LVxoxggetaVKCNTzkaDQLHfsDWUkLbTrUkBGZjfjaaljAa2My8AOwZDD0xCk1Aw
         RD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPGNGpuXsSj7iImL7Bk1uRzQFazCObJX8Z7FSku7rwk=;
        b=Toq5Hz8AsiIQlcgghDvhvsdXMXHEPCdp2du9SYUlFtMfkaf7aD5ziWXjuDerZJvC+/
         qeGS/8gwOY9fxWdPEeJp8Ni/n5KVkYZIZg6G1t5MhfmIQmiuk0KQXQ06ck/DJB29i2Eb
         0uzoI3EpctDLxrRp+wtrGLjb0iY/Em8qUf5PzS0NNpFxZNMBIKDVjTVGZXDWonRQ5/l9
         n0kSqCnVbBArfqGhOe/lsicTUxZDu/LW7YrEsHNfAW3Ay3p0fBvjlar2TQFCZCzLzkSx
         IsuaMzfdo1auU2kAvwyHlLzldlNQQ4AG2GtRaJriRKAsx2MPFfRDyt2KVxDVLgoPn52s
         aXFA==
X-Gm-Message-State: AOAM5301CAFV6tezmJAuepKx2wwa33EiP95mArK+WTMLEjo99SUwh8Be
        Kj34zG9/OETsqlYF365cck87QoCiicBPsI6Yf4I0j92SqQo=
X-Google-Smtp-Source: ABdhPJwzHwYfwLCva+ROdK5Au+p4AAtQoihFG2b/CO98MWU/b0CTy5hV32oVUJ7KjEEmlCEMKG2Hnh6VQIPdlo9cn5Q=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr6237262ybh.267.1633732058230;
 Fri, 08 Oct 2021 15:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211006185619.364369-1-fallentree@fb.com> <20211006185619.364369-15-fallentree@fb.com>
In-Reply-To: <20211006185619.364369-15-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Oct 2021 15:27:27 -0700
Message-ID: <CAEf4BzYfmMOpfZ2ti-e9z-1_oB4_E0R064_RD8a_QDt2=JLsnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 14/14] selfetest/bpf: make some tests serial
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 11:56 AM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> Change tests that often fails in parallel execution mode to serial.
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---

I hope we'll be able to parallelise these tests over time. See some
notes on cover letter for how to target this effort better. But here's
another thought I had while thinking about this.

Some tests are inherently testing unshareable resources, e.g., like
XDP tests. So we might never be able to completely parallelize all the
tests. But it probably will be too restrictive to just bunde all of
them into the one "serial" group of tests. It's a good starting point,
but I think we'll have to have something like "serialization" group,
where we'll be able to mark a bunch of tests like
"serial_xdp_<testname>" and each test with "serial_xdp_" prefix will
run sequentially relative to each other, but they might run completely
parallel to, say, "serial_perf_" tests. WDYT?


>  tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c   | 2 +-
>  tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c            | 2 +-
>  tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c      | 2 +-
>  .../selftests/bpf/prog_tests/cgroup_attach_autodetach.c        | 2 +-
>  tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c   | 2 +-
>  .../testing/selftests/bpf/prog_tests/cgroup_attach_override.c  | 2 +-
>  tools/testing/selftests/bpf/prog_tests/cgroup_link.c           | 2 +-
>  tools/testing/selftests/bpf/prog_tests/check_mtu.c             | 2 +-
>  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c         | 3 ++-
>  .../selftests/bpf/prog_tests/flow_dissector_load_bytes.c       | 2 +-
>  .../testing/selftests/bpf/prog_tests/flow_dissector_reattach.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/get_branch_snapshot.c   | 2 +-
>  tools/testing/selftests/bpf/prog_tests/kfree_skb.c             | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/migrate_reuseport.c     | 2 +-
>  tools/testing/selftests/bpf/prog_tests/modify_return.c         | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c   | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/perf_buffer.c           | 2 +-
>  tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/probe_user.c            | 3 ++-
>  .../selftests/bpf/prog_tests/raw_tp_writable_test_run.c        | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/select_reuseport.c      | 2 +-
>  .../selftests/bpf/prog_tests/send_signal_sched_switch.c        | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/sk_storage_tracing.c    | 2 +-
>  tools/testing/selftests/bpf/prog_tests/snprintf_btf.c          | 2 +-
>  tools/testing/selftests/bpf/prog_tests/sock_fields.c           | 2 +-
>  tools/testing/selftests/bpf/prog_tests/sockmap_listen.c        | 2 +-
>  tools/testing/selftests/bpf/prog_tests/timer.c                 | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/timer_mim.c             | 2 +-
>  tools/testing/selftests/bpf/prog_tests/tp_attach_query.c       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/trace_printk.c          | 2 +-
>  tools/testing/selftests/bpf/prog_tests/trace_vprintk.c         | 2 +-
>  tools/testing/selftests/bpf/prog_tests/trampoline_count.c      | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/xdp_attach.c            | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c           | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c     | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c     | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_info.c              | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_link.c              | 2 +-
>  38 files changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> index 85babb0487b3..b52ff8ce34db 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c
> @@ -179,7 +179,7 @@ static void do_bpf_iter_setsockopt(struct bpf_iter_setsockopt *iter_skel,
>         free_fds(est_fds, nr_est);
>  }
>

[...]

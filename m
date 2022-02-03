Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264734A7FA6
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 08:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiBCHLq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 02:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbiBCHLq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 02:11:46 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6FC061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 23:11:45 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e79so2062957iof.13
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 23:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsY0mQNp2zmFv5SI4lBYw68nZOCpsmKEGZo2BOjHXbI=;
        b=FATEjcojJ3xiqLxa0O6Ef1o4iTytylUTYpuFm90XKSy1AO7Pl5WFVtSjNch+uleTH1
         0dMt0S2de5gdtn7POQDlASC/ymJwttj628N+mJ+0rFC50mnt6u+hRD+1zRNCSR+44P6c
         mZvrWudXcvaMuLrQGO9ad05xKbfKehEpWTKiL5u9Ho0jfwb3dadrz4abDfqJHfQmpWxP
         +DqSYB6vXzm4ro6FWjvZqbdsod3yii4PnISWMPtRUUtmRIe4OMfZy1/xi89Y+OYygBwl
         8M+RSuBVA/cCe8usiiZ445KXiKXty2SG7asb8a4mbomiv3uk/Qkc+rzcOPXxEq2vvuGM
         KrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsY0mQNp2zmFv5SI4lBYw68nZOCpsmKEGZo2BOjHXbI=;
        b=OXeZfbfIghrGd0Z1BLLwfo0jY6Wb214CXMjomNAdyJ1N792Fj1PAdXJjCa2RHUy+tE
         GreeAqeGRAyXriu6cn7mmndfPzemKOMLrmzHn4Yd8j3+EreXMRpSzYXZc6nFk2znEw/V
         g69QxxVhybouK89AiX7B75ZTOWr/4K0jflrKmv7cwIz7W7reT8xPMBuT8knvoxTO4SB5
         FH/fg6SNE9jCsabO3KNEPKtfe+F9pCvkBEWvhAutQAM5QTjhG7upeoe9dQ1M5vT3Dthz
         zm7RqVGAZVFVk2JxHe83xPIM5h/EYEVSqs/hJIMc373Y0tWhzRAD6BeBWVVKbn7Cs1Vz
         j7EA==
X-Gm-Message-State: AOAM5331jG+v0ZQ9ODRuZqlBxh40wqN9Cih/90ZaCaZD3KpI8JI56+Ce
        YIB3V62h7FoJ3Op6F6RXArlKOdBEc4gp8NlPfm15y/6Q
X-Google-Smtp-Source: ABdhPJx6Mw23LxBh/U1Z/EqpIKzzcAAm5YSAsid7INXB/EKF5+U+xivDjBvQmWEdp62TNhGJ9C+0B1nah5JCOxzzm+Q=
X-Received: by 2002:a05:6602:2e88:: with SMTP id m8mr11517423iow.79.1643872305126;
 Wed, 02 Feb 2022 23:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20220202235423.1097270-1-delyank@fb.com>
In-Reply-To: <20220202235423.1097270-1-delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Feb 2022 23:11:34 -0800
Message-ID: <CAEf4Bzat-xt_4Kdh0RkfRhHdMd8Sm0N5c8j6voamOWmQu=kv7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] migrate from bpf_prog_test_run{,_xattr}
To:     Delyan Kratunov <delyank@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 2, 2022 at 3:56 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Fairly straight-forward mechanical transformation from bpf_prog_test_run
> and bpf_prog_test_run_xattr to the bpf_prog_test_run_opts goodness.
>
> I did a fair amount of drive-by CHECK/CHECK_ATTR cleanups as well, though
> certainly not everything possible. Primarily, I did not want to just change
> arguments to CHECK calls, though I had to do a bit more than that
> in some cases (overall, -119 CHECK calls and all CHECK_ATTR calls).
>
> v2 -> v3:
> Don't introduce CHECK_OPTS, replace CHECK/CHECK_ATTR usages we need to touch
> with ASSERT_* calls instead.
> Don't be prescriptive about the opts var name and keep old names where that would
> minimize unnecessary code churn.
> Drop _xattr-specific checks in prog_run_xattr and rename accordingly.
>
> v1 -> v2:
> Split selftests/bpf changes into two commits to appease the mailing list.
>
>
> Delyan Kratunov (4):
>   selftests/bpf: migrate from bpf_prog_test_run
>   selftests/bpf: migrate from bpf_prog_test_run_xattr
>   bpftool: migrate from bpf_prog_test_run_xattr
>   libbpf: Deprecate bpf_prog_test_run_xattr and bpf_prog_test_run
>
>  tools/bpf/bpftool/prog.c                      |   5 +-
>  tools/lib/bpf/bpf.h                           |   4 +-
>  .../selftests/bpf/prog_tests/atomics.c        |  72 +++---
>  .../testing/selftests/bpf/prog_tests/bpf_nf.c |  10 +-
>  .../selftests/bpf/prog_tests/check_mtu.c      |  38 +--
>  .../selftests/bpf/prog_tests/cls_redirect.c   |  10 +-
>  .../selftests/bpf/prog_tests/dummy_st_ops.c   |  27 +-
>  .../selftests/bpf/prog_tests/fentry_fexit.c   |  24 +-
>  .../selftests/bpf/prog_tests/fentry_test.c    |   7 +-
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  32 ++-
>  .../selftests/bpf/prog_tests/fexit_stress.c   |  22 +-
>  .../selftests/bpf/prog_tests/fexit_test.c     |   7 +-
>  .../selftests/bpf/prog_tests/flow_dissector.c |  31 ++-
>  .../prog_tests/flow_dissector_load_bytes.c    |  24 +-
>  .../selftests/bpf/prog_tests/for_each.c       |  32 ++-
>  .../bpf/prog_tests/get_func_args_test.c       |  12 +-
>  .../bpf/prog_tests/get_func_ip_test.c         |  10 +-
>  .../selftests/bpf/prog_tests/global_data.c    |  24 +-
>  .../bpf/prog_tests/global_func_args.c         |  13 +-
>  .../selftests/bpf/prog_tests/kfree_skb.c      |  16 +-
>  .../selftests/bpf/prog_tests/kfunc_call.c     |  46 ++--
>  .../selftests/bpf/prog_tests/ksyms_module.c   |  23 +-
>  .../selftests/bpf/prog_tests/l4lb_all.c       |  35 ++-
>  .../selftests/bpf/prog_tests/map_lock.c       |  15 +-
>  .../selftests/bpf/prog_tests/map_ptr.c        |  16 +-
>  .../selftests/bpf/prog_tests/modify_return.c  |  33 +--
>  .../selftests/bpf/prog_tests/pkt_access.c     |  26 +-
>  .../selftests/bpf/prog_tests/pkt_md_access.c  |  14 +-
>  .../selftests/bpf/prog_tests/prog_run_opts.c  |  77 ++++++
>  .../selftests/bpf/prog_tests/prog_run_xattr.c |  83 ------
>  .../bpf/prog_tests/queue_stack_map.c          |  46 ++--
>  .../bpf/prog_tests/raw_tp_test_run.c          |  64 ++---
>  .../bpf/prog_tests/raw_tp_writable_test_run.c |  16 +-
>  .../selftests/bpf/prog_tests/signal_pending.c |  23 +-
>  .../selftests/bpf/prog_tests/skb_ctx.c        |  81 +++---
>  .../selftests/bpf/prog_tests/skb_helpers.c    |  16 +-
>  .../selftests/bpf/prog_tests/sockmap_basic.c  |  20 +-
>  .../selftests/bpf/prog_tests/spinlock.c       |  14 +-
>  .../selftests/bpf/prog_tests/syscall.c        |  10 +-
>  .../selftests/bpf/prog_tests/tailcalls.c      | 238 +++++++++---------
>  .../selftests/bpf/prog_tests/test_profiler.c  |  14 +-
>  .../bpf/prog_tests/test_skb_pkt_end.c         |  15 +-
>  .../testing/selftests/bpf/prog_tests/timer.c  |   7 +-
>  .../selftests/bpf/prog_tests/timer_mim.c      |   7 +-
>  .../selftests/bpf/prog_tests/trace_ext.c      |  28 ++-
>  tools/testing/selftests/bpf/prog_tests/xdp.c  |  34 ++-
>  .../bpf/prog_tests/xdp_adjust_frags.c         |  32 ++-
>  .../bpf/prog_tests/xdp_adjust_tail.c          | 122 +++++----
>  .../selftests/bpf/prog_tests/xdp_bpf2bpf.c    |  14 +-
>  .../selftests/bpf/prog_tests/xdp_noinline.c   |  44 ++--
>  .../selftests/bpf/prog_tests/xdp_perf.c       |  19 +-
>  tools/testing/selftests/bpf/test_lru_map.c    |  11 +-
>  tools/testing/selftests/bpf/test_verifier.c   |  16 +-
>  53 files changed, 872 insertions(+), 807 deletions(-)

Massive work, thanks a lot! Applied to bpf-next.

>  create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
>  delete mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
>
> --
> 2.30.2

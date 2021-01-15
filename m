Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0722F7160
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 05:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAOEGB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 23:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbhAOEGA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 23:06:00 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7153FC061757
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 20:05:14 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id z11so10577542qkj.7
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 20:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRF5Zef/uHRf9jZnJ+8Z3cYsn4c/jEwASX8fR7WUFS8=;
        b=LDS7gDhiFVyXHqmD54o9Mw6mXo3UUTuHe9gmY/t7Z1QCfuIdyCJOuTbRcrISRXZrjF
         rTrPwlgl8Nf/hnWnMXWgDHtfP5LQ5yxAmt5lpPx//iQjexmO1gNBpQ61/NMBXkQF4ES9
         nAdBicXvv3xuDkLEx5p4i9jgPo4WZVUaWQ4AfLQWOumoJROTdZ+S+HDVLY9hPneVno+x
         WmwK+42sZlDWln32AKSqWHjgC5AWx6TmJQ9KfKvY6swF9AaZNecO9RjcgK4hU9JAfCWB
         0UFqkIJDi3aAaY3qDpWDV+N91P+jpUEdokqWJ5J2OFqMcSi22pg+obrNMGs2igkLr6o+
         cu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRF5Zef/uHRf9jZnJ+8Z3cYsn4c/jEwASX8fR7WUFS8=;
        b=WEnZ7X4kYXM+F/wo1CawZLSpg6t8qrlr47L9+NPMSY9MYGuQTi6R7KXAnLBZPaAMRx
         JiQJRVX0F29pIK/5N74w0dnlIczWJMrs+TTcGtj5o2T3PZ5Y1xobY04/cI2MrIee0agJ
         SDe1Q6ankZ0/5carEIh8wyjCrfa5rNeN0EV24oOGWeqWj2F8tlnMH1QrFvJmS2j0x+H3
         7dLUqS9QKw5xw2l4XQftHZ+mcsdbZmBkY5Ncq1T3FEIdU/oeptz4MFNHP4y1SsLua/XJ
         xHxPZ22fsXC+8+daXP5G2hy+n9Evss3CAqjYxJCyyfqgfYbKyrVf498PVqsDnnJ3npU8
         rqUA==
X-Gm-Message-State: AOAM533Ew6T/XoP12DhFexi9CM6nQJXiPfkJurzuPer22MIDUvr4FBo+
        73HGK5486D4CvCp9NUZKWKICV2Sqzax/o/lqNINLHg==
X-Google-Smtp-Source: ABdhPJwGZtayhCv5CTdSPyRoQ+FxfQsky4cZ1bHUzWPOsphbo8RP6OupEbuh2t9BPUuB0/r/aM2MZH1uaq2QskcRDYM=
X-Received: by 2002:a37:6245:: with SMTP id w66mr10484240qkb.422.1610683513260;
 Thu, 14 Jan 2021 20:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20210113213321.2832906-1-sdf@google.com> <20210113213321.2832906-2-sdf@google.com>
 <CAADnVQLssJ4oStg7C4W-nafFKaka1H3-N0DhsBrB3FdmgyUC_A@mail.gmail.com>
 <CAKH8qBsaZjOkvGZuNCtG=V2M9YfAJgtG+moAejwtBCB6kNJUwA@mail.gmail.com> <CAADnVQ+2MDGVEKRZ+B-q+GcZ8CExN5VfSZpkvntg48dpww3diA@mail.gmail.com>
In-Reply-To: <CAADnVQ+2MDGVEKRZ+B-q+GcZ8CExN5VfSZpkvntg48dpww3diA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 14 Jan 2021 20:05:02 -0800
Message-ID: <CAKH8qBuMUj0j7eS+O87=U6jzndXnCPiJ+4RbQ7nAdzbHY7cqAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/3] bpf: remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 7:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 14, 2021 at 7:40 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Thu, Jan 14, 2021 at 7:27 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jan 13, 2021 at 1:33 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > Add custom implementation of getsockopt hook for TCP_ZEROCOPY_RECEIVE.
> > > > We skip generic hooks for TCP_ZEROCOPY_RECEIVE and have a custom
> > > > call in do_tcp_getsockopt using the on-stack data. This removes
> > > > 3% overhead for locking/unlocking the socket.
> > > >
> > > > Without this patch:
> > > >      3.38%     0.07%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt
> > > >             |
> > > >              --3.30%--__cgroup_bpf_run_filter_getsockopt
> > > >                        |
> > > >                         --0.81%--__kmalloc
> > > >
> > > > With the patch applied:
> > > >      0.52%     0.12%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt_kern
> > > >
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > Cc: Martin KaFai Lau <kafai@fb.com>
> > > > Cc: Song Liu <songliubraving@fb.com>
> > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > Acked-by: Martin KaFai Lau <kafai@fb.com>
> > >
> > > Few issues in this patch and the patch 2 doesn't apply:
> > > Switched to a new branch 'tmp'
> > > Applying: bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
> > > .git/rebase-apply/patch:295: trailing whitespace.
> > > #endif
> > > .git/rebase-apply/patch:306: trailing whitespace.
> > > union tcp_word_hdr {
> > > .git/rebase-apply/patch:309: trailing whitespace.
> > > };
> > > .git/rebase-apply/patch:311: trailing whitespace.
> > > #define tcp_flag_word(tp) ( ((union tcp_word_hdr *)(tp))->words [3])
> > > .git/rebase-apply/patch:313: trailing whitespace.
> > > enum {
> > > warning: squelched 1 whitespace error
> > > warning: 6 lines add whitespace errors.
> > > Applying: bpf: Try to avoid kzalloc in cgroup/{s,g}etsockopt
> > > error: patch failed: kernel/bpf/cgroup.c:1390
> > > error: kernel/bpf/cgroup.c: patch does not apply
> > > Patch failed at 0002 bpf: Try to avoid kzalloc in cgroup/{s,g}etsockopt
> > Sorry, I mentioned in the cover letter that the series requires
> > 4be34f3d0731 ("bpf: Don't leak memory in bpf getsockopt when optlen == 0")
> > which is only in the bpf tree. No sure when bpf & bpf-next merge.
> > Or are you trying to apply on top of that?
>
> hmm. It will take a while to wait for the trees to converge.
> Ok. I've cherry-picked that bpf commit and applied 3 patches on top,
> but the test failed to build:
>
> progs/sockopt_sk.c:60:47: error: use of undeclared identifier
> 'TCP_ZEROCOPY_RECEIVE'
>         if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
>                                                      ^
> progs/sockopt_sk.c:66:16: error: invalid application of 'sizeof' to an
> incomplete type 'struct tcp_zerocopy_receive'
>                 if (optval + sizeof(struct tcp_zerocopy_receive) > optval_end)
>
> Looks like copied uapi/tcp.h into tools/ wasn't in the include path.
Interesting, let me try to understand where it comes on my system
because it did work even without this uapi/tcp.h so I might
have messed something up. Thank you!

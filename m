Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C4D2EA169
	for <lists+bpf@lfdr.de>; Tue,  5 Jan 2021 01:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbhAEAT4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jan 2021 19:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbhAEAT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jan 2021 19:19:56 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE974C061574
        for <bpf@vger.kernel.org>; Mon,  4 Jan 2021 16:19:12 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id h4so25213908qkk.4
        for <bpf@vger.kernel.org>; Mon, 04 Jan 2021 16:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdIK62Nsb2mBU96tPb+7Rj1tHQmb2N/TLttudMXPCv0=;
        b=WyyUC2ZQj2ywWBrojf5u7YaM1sTw312Kl48LMWPOEWR0RYeDhcBifxxglLPj3ePqsI
         q9uKePa1gDw5HwKDCQF9Hi5nmZhzix6BxWEi+yPZ7h1Bluj36RuxNr/Nn++pCPyfCU1x
         BEKwXbO0an3wtSDdRn+BgB/OLISe4Am2ZbrGknUcQY8nmt5BvLrD4QekWFXMgAUfX0kX
         2JEbBu+acLpucWBwTRtA0yCRGgbsCWq8YlyGUoZ9UhH7e0B8K4SKodcpEF6RNFasQ6jL
         paUn5cHA1blC9lgE/BTELjtUicYUObgTm8BqdfL3jU0eFq1xbzg7wfaFiBXtVCMDzhSP
         gk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdIK62Nsb2mBU96tPb+7Rj1tHQmb2N/TLttudMXPCv0=;
        b=nr1aa29n5dj2Cwv+lNXA89X7EXhHIySGI68ciVkfYyMmKpHQwtmel04kZlNdjpo2j9
         64OUsjjRHmaQwzEY6r1KCrd2nYIHOzmCsXTtyBiOWUTAnUhHWJwsP/DAjckHF69LpVlN
         2DytymMuJaGNdKuaKjB83GPIP/tyLl0gzd3vvOQqdlxyc8zBcysInJ1oblYAEeVUnq2Y
         n8VPbWc95EOGX5EvTYIh0MNvn7/Y9Vaid9w7txFozw26XkR4UuhpzYZxsJipFlShfanQ
         sCD4mzazOL76Ydow8glAHrJKOpqmpEYh9xANYHydNTSkmtrI8SbaSJQavY/Kv4R3lC0V
         QDrg==
X-Gm-Message-State: AOAM532uXgBoMAUMWBjZe9sfR6W7TTRDnAhELwU9ENpJDKb8ALzOuhEB
        Rgj94bb3Uomn7CImataNJRKva1dxSHDz98GdiIie6g==
X-Google-Smtp-Source: ABdhPJzzr+fx8H6sSsnk5rd15OiQTqt8RS54F/HzPflW7OF/cGKwuokpad61A4bLRPuGZx4DhPKQ3nkXOcPhBez+MSM=
X-Received: by 2002:a37:6245:: with SMTP id w66mr73464348qkb.422.1609805951850;
 Mon, 04 Jan 2021 16:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20210104221454.2204239-1-sdf@google.com> <20210104221454.2204239-2-sdf@google.com>
 <20210105000329.augyugyaucykt35r@kafai-mbp>
In-Reply-To: <20210105000329.augyugyaucykt35r@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 4 Jan 2021 16:19:01 -0800
Message-ID: <CAKH8qBueX4vFbFs0O4sAzbpFjf_G98eVGu6dG-APWV7cVrdWEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 4, 2021 at 4:03 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Jan 04, 2021 at 02:14:53PM -0800, Stanislav Fomichev wrote:
> > When we attach a bpf program to cgroup/getsockopt any other getsockopt()
> > syscall starts incurring kzalloc/kfree cost. While, in general, it's
> > not an issue, sometimes it is, like in the case of TCP_ZEROCOPY_RECEIVE.
> > TCP_ZEROCOPY_RECEIVE (ab)uses getsockopt system call to implement
> > fastpath for incoming TCP, we don't want to have extra allocations in
> > there.
> >
> > Let add a small buffer on the stack and use it for small (majority)
> > {s,g}etsockopt values. I've started with 128 bytes to cover
> > the options we care about (TCP_ZEROCOPY_RECEIVE which is 32 bytes
> > currently, with some planned extension to 64).
> >
> > It seems natural to do the same for setsockopt, but it's a bit more
> > involved when the BPF program modifies the data (where we have to
> > kmalloc). The assumption is that for the majority of setsockopt
> > calls (which are doing pure BPF options or apply policy) this
> > will bring some benefit as well.
> >
> > Collected some performance numbers using (on a 65k MTU localhost in a VM):
> > $ perf record -g -- ./tcp_mmap -s -z
> > $ ./tcp_mmap -H ::1 -z
> > $ ...
> > $ perf report --symbol-filter=__cgroup_bpf_run_filter_getsockopt
> >
> > Without this patch:
> >      4.81%     0.07%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_>
> >             |
> >              --4.74%--__cgroup_bpf_run_filter_getsockopt
> >                        |
> >                        |--1.06%--__kmalloc
> >                        |
> >                        |--0.71%--lock_sock_nested
> >                        |
> >                        |--0.62%--__might_fault
> >                        |
> >                         --0.52%--release_sock
> >
> > With the patch applied:
> >      3.29%     0.07%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt
> >             |
> >              --3.22%--__cgroup_bpf_run_filter_getsockopt
> >                        |
> >                        |--0.66%--lock_sock_nested
> >                        |
> >                        |--0.57%--__might_fault
> >                        |
> >                         --0.56%--release_sock
> >
> > So it saves about 1% of the system call. Unfortunately, we still get
> > 2-3% of overhead due to another socket lock/unlock :-(
> That could be a future exercise to optimize the fast path sockopts. ;)
Yeah, I couldn't think about anything simple so far. The only idea I have
is to allow custom implementation for tcp/udp (where we do lock_sock)
and then have existing BPF_CGROUP_RUN_PROG_{S,G}ETSOCKOPT
in net/socket.c as a fallback. Need to experiment more with it.

> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/bpf-cgroup.h>
> >  #include <net/sock.h>
> >  #include <net/bpf_sk_storage.h>
> > +#include <net/tcp.h> /* sizeof(struct tcp_zerocopy_receive) */
> To be more specific, it should be <uapi/linux/tcp.h>.
Sure, let's do that. I went with net/tcp.h because
most of the code under net/* doesn't include uapi directly.

> >
> >  #include "../cgroup/cgroup-internal.h"
> >
> > @@ -1298,6 +1299,7 @@ static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
> >       return empty;
> >  }
> >
> > +
> Extra newline.
Oops, thanks, will fix.

> >  static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
> >  {
> >       if (unlikely(max_optlen < 0))
> > @@ -1310,6 +1312,18 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
> >               max_optlen = PAGE_SIZE;
> >       }
> >
> > +     if (max_optlen <= sizeof(ctx->buf)) {
> > +             /* When the optval fits into BPF_SOCKOPT_KERN_BUF_SIZE
> > +              * bytes avoid the cost of kzalloc.
> > +              */
> If it needs to respin, it will be good to have a few words here on why
> it only BUILD_BUG checks for "struct tcp_zerocopy_receive".
Sounds good, will add. I'll wait a day to let others comment and will respin.

> > +             BUILD_BUG_ON(sizeof(struct tcp_zerocopy_receive) >
> > +                          BPF_SOCKOPT_KERN_BUF_SIZE);
> > +
> > +             ctx->optval = ctx->buf;
> > +             ctx->optval_end = ctx->optval + max_optlen;
> > +             return max_optlen;
> > +     }
> > +

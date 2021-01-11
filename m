Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732342F1E3D
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 19:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbhAKSvJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 13:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbhAKSvJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 13:51:09 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74BCC061786
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 10:50:26 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id w79so462090qkb.5
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 10:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlmsHumriIeZFkGIWL8CXyjzNmfnJGx+2xjc3r/ZmFQ=;
        b=U7aBs2xTOmg8KAWmmTwcvIgVGB07de/QjCTKO47jFZLffZVHr6b7fk89HgvJdxBI/V
         jCa65yaEUTKorm8shqeRaKBACxo55k46UFv/Re/Mb4M0qCMM8F6PNcUhKz7o44grEI2l
         nnm+6fxwN9Zet3KOzgOBQ4L/DKzH9itSo4W2cu3Kpc11Lg1/PDQpYj5iREPH7W7IG8BF
         2T8S6Zaui2ibGjV/4Zv3WIfjALZWLYTuyu9ccjzx7zDfrfiti4XDfD9vv2HERLrzvhQp
         m/Fw05m8bUtpaGxkymugvMPv7O8fttj6jNINDnci0hUpPAZIa0u8/cZM59ottM0IhvVH
         LXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlmsHumriIeZFkGIWL8CXyjzNmfnJGx+2xjc3r/ZmFQ=;
        b=hcL1ZJIlKm62epUe7qJlJfA/IIaDcjqyrQgIoPbn4IpJ3Nxlqx59OYcdZRViJq4QDT
         pRHOg3xjJkzufPQdgx/BBnfHwVD+hZDxkkj8p/o4asta+3DLB1fzbekASd1yVXrOGRK1
         XcMVKm9pMRUin58kh/k2fkF53M00nSQSmIi87ZyB7Ig6W6r3mik4JooQrn8eFsJtnQFK
         3O0B9KtO8ayxn8VYyPzlg7bMnFLuqxAQ/K0DDAWlysnLl5azI2K30nM5GlP5wFg6K9ux
         sG07rmB29TO2iD+8aC2kL+PzR1E9FVprOUFZGJB3nig2p4p8a/V3QuHwV6VGs0WgeJ8J
         5p8Q==
X-Gm-Message-State: AOAM532wv6nXL5mYAs6YhtUAO1K5NgFCQuaaJw0C2mZBvM1JV0+q4Lfm
        UfKUSxVxmYxhe/wysDMqhLvPx0aYlvmCdDVThr6GhMh9fgl0FQ==
X-Google-Smtp-Source: ABdhPJw93xrBCTVRvqsvjD0OSRrQVpsKmv7Tg7nIXxieWjP5yuY6SSxV3gJg55uZ8vNyf98MicpvbiT3lgB5bOHOOZs=
X-Received: by 2002:a37:a80a:: with SMTP id r10mr741799qke.448.1610391025650;
 Mon, 11 Jan 2021 10:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20210108210223.972802-1-sdf@google.com> <20210108210223.972802-2-sdf@google.com>
 <20210109013739.vbqm4gllpo7g5xro@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210109013739.vbqm4gllpo7g5xro@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 11 Jan 2021 10:50:14 -0800
Message-ID: <CAKH8qBscw4NkOavRZ2nDiB7Yz_BbO5nLwmczkMraMYgrDWWxGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 8, 2021 at 5:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jan 08, 2021 at 01:02:21PM -0800, Stanislav Fomichev wrote:
> > Add custom implementation of getsockopt hook for TCP_ZEROCOPY_RECEIVE.
> > We skip generic hooks for TCP_ZEROCOPY_RECEIVE and have a custom
> > call in do_tcp_getsockopt using the on-stack data. This removes
> > 3% overhead for locking/unlocking the socket.
> >
> > Without this patch:
> >      3.38%     0.07%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt
> >             |
> >              --3.30%--__cgroup_bpf_run_filter_getsockopt
> >                        |
> >                         --0.81%--__kmalloc
> >
> > With the patch applied:
> >      0.52%     0.12%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt_kern
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/linux/bpf-cgroup.h                    | 27 +++++++++++--
> >  include/linux/indirect_call_wrapper.h         |  6 +++
> >  include/net/sock.h                            |  2 +
> >  include/net/tcp.h                             |  1 +
> >  kernel/bpf/cgroup.c                           | 38 +++++++++++++++++++
> >  net/ipv4/tcp.c                                | 14 +++++++
> >  net/ipv4/tcp_ipv4.c                           |  1 +
> >  net/ipv6/tcp_ipv6.c                           |  1 +
> >  net/socket.c                                  |  3 ++
> >  .../selftests/bpf/prog_tests/sockopt_sk.c     | 22 +++++++++++
> >  .../testing/selftests/bpf/progs/sockopt_sk.c  | 15 ++++++++
> >  11 files changed, 126 insertions(+), 4 deletions(-)
> >
> [ ... ]
>
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 6ec088a96302..c41bb2f34013 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -1485,6 +1485,44 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
> >       sockopt_free_buf(&ctx);
> >       return ret;
> >  }
> > +
> > +int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
> > +                                         int optname, void *optval,
> > +                                         int *optlen, int retval)
> > +{
> > +     struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > +     struct bpf_sockopt_kern ctx = {
> > +             .sk = sk,
> > +             .level = level,
> > +             .optname = optname,
> > +             .retval = retval,
> > +             .optlen = *optlen,
> > +             .optval = optval,
> > +             .optval_end = optval + *optlen,
> > +     };
> > +     int ret;
> > +
> The current behavior only passes kernel optval to bpf prog when
> retval == 0.  Can you explain a few words here about
> the difference and why it is fine?
> Just in case some other options may want to reuse the
> __cgroup_bpf_run_filter_getsockopt_kern() in the future.
IIRC, whatever we do in __cgroup_bpf_run_filter_getsockopt
with skipping the copy for retval != 0 is just an optimization.
I was assuming that on the error, kernel wouldn't copy
anything back to the users (not sure how true in real
life it is). I'll add a comment here to signify the difference.

> > +     ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
> > +                              &ctx, BPF_PROG_RUN);
> > +     if (!ret)
> > +             return -EPERM;
> > +
> > +     if (ctx.optlen > *optlen)
> > +             return -EFAULT;
> > +
> > +     /* BPF programs only allowed to set retval to 0, not some
> > +      * arbitrary value.
> > +      */
> > +     if (ctx.retval != 0 && ctx.retval != retval)
> > +             return -EFAULT;
> > +
> > +     /* BPF programs can shrink the buffer, export the modifications.
> > +      */
> > +     if (ctx.optlen != 0)
> > +             *optlen = ctx.optlen;
> > +
> > +     return ctx.retval;
> > +}
> >  #endif
> >
> >  static ssize_t sysctl_cpy_dir(const struct ctl_dir *dir, char **bufp,
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > index b25c9c45c148..6bb18b1d8578 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> > @@ -11,6 +11,7 @@ static int getsetsockopt(void)
> >               char u8[4];
> >               __u32 u32;
> >               char cc[16]; /* TCP_CA_NAME_MAX */
> > +             struct tcp_zerocopy_receive zc;
> I suspect it won't compile at least in my setup.
>
> However, I compile tools/testing/selftests/net/tcp_mmap.c fine though.
> I _guess_ it is because the net's test has included kernel/usr/include.
>
> AFAIK, bpf's tests use tools/include/uapi/.
>
> Others LGTM.
Sure, let me add export it to tools/include/uapi. I didn't do it
because it also compiled for me and I assumed that
tcp_zerocopy_receive was exported too long ago to care (we are using
the first field anyway so don't really need the latest layout).

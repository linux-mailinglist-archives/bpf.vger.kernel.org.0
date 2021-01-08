Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3E2EF79A
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 19:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbhAHSln (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 13:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbhAHSlm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 13:41:42 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99530C0612FD
        for <bpf@vger.kernel.org>; Fri,  8 Jan 2021 10:41:02 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id w18so10736796iot.0
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRxYmbHMb5EuFQjaezpYLz1hGZgj9lDf0Tk18VBvDgI=;
        b=pt5b08c7ItN3H4tTqGeHjbyN1nI5sE0rlSuKTBq2Ihlk96fvp4b0RN6/hB9Bileiwx
         BXUkvOe+nvwoLPLtUUVykSX3jgahj3QrMopiyO2Oa9c/hsjOnOmNTva03kG2GxMLQPvy
         fPE5CoPSZijQiZZ8zJHVh7edrbEwFhagvWHjYrosb2/+nIAsbpeFHFOICDoLa8MWUWW3
         nNom1E3PexkEwrZtnV32g0/f6LmIG5ZM7TOPlqs2iMGlK0m02ovzBkJgsCkeMOjeDKnr
         VkCuo0ZkGDGHSFSV+Gn+pDB+6cAeZKcLU5pAIAOk+LnqF2p3+jFQLqHH6XX6gqFLF0Df
         UDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRxYmbHMb5EuFQjaezpYLz1hGZgj9lDf0Tk18VBvDgI=;
        b=ia9MbH7r7bhgKm4RCFkrXgZNJO2TO4UwyDIHMzPmY1zLV/sxI+7LyvTCJBju4BsPoU
         hO9qhod1OXQ60SbbrWcpONoFXsE54rorYLgAB9ht1Z4ztBB5dOcyboox16dA6W7ul7Aa
         VHxLyO+I4PpzxHgBG6Yky+GPJmtFfNxYdJ+LKLCS+mJ1swLxNt2bZrYLwFT2PCtwnwn4
         oqhBS1nY7Kw/C2vKt4iYRsawQdfki/GIj2EDBo4QhYzvp1BhZ2uGW6hWAsDUO3TPgOW6
         WreqoJ7CQZSkBl1ZLve9nMIxF+5/rw5iRFWw+cRr+4ue7I3X4vBh5hniGcDad+MBXa1I
         e1cA==
X-Gm-Message-State: AOAM530A3WJfrKNslh6Ix+wEIKQBDoNsXz4Z+RAETjlbhcOMouysiJ3B
        Z6wfq/npwqStHh1cOTfHD3e38FZ7XWXAUuHYv5Vt/A==
X-Google-Smtp-Source: ABdhPJwY7XQ/2kIyjg2PzPyE6pJzIbb1kA7YHVi0RZBYLAJlrpDT0jRnMMt1WlyQgrgzQAx9u+ImzDZPTj9MbyNo+fU=
X-Received: by 2002:a6b:f112:: with SMTP id e18mr6399883iog.195.1610131261662;
 Fri, 08 Jan 2021 10:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20210108180333.180906-1-sdf@google.com> <20210108180333.180906-2-sdf@google.com>
 <CANn89i+GvEUmoapF+C0Mf1qw+AuWhU5_MMPz-jy8fND0HmUJ=Q@mail.gmail.com> <CAKH8qBsWsKVxAyvhEYqXytTFMGEN=C3ZMKBPLs2RKcEpM4hXXQ@mail.gmail.com>
In-Reply-To: <CAKH8qBsWsKVxAyvhEYqXytTFMGEN=C3ZMKBPLs2RKcEpM4hXXQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Jan 2021 19:40:49 +0100
Message-ID: <CANn89iKv1aKE3Tcyr-vqv2mHeDompWjUn6txeK-qEO6-G-pBBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 8, 2021 at 7:26 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Fri, Jan 8, 2021 at 10:10 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Jan 8, 2021 at 7:03 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > Add custom implementation of getsockopt hook for TCP_ZEROCOPY_RECEIVE.
> > > We skip generic hooks for TCP_ZEROCOPY_RECEIVE and have a custom
> > > call in do_tcp_getsockopt using the on-stack data. This removes
> > > 3% overhead for locking/unlocking the socket.
> > >
> > > Without this patch:
> > >      3.38%     0.07%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt
> > >             |
> > >              --3.30%--__cgroup_bpf_run_filter_getsockopt
> > >                        |
> > >                         --0.81%--__kmalloc
> > >
> > > With the patch applied:
> > >      0.52%     0.12%  tcp_mmap  [kernel.kallsyms]  [k] __cgroup_bpf_run_filter_getsockopt_kern
> > >
> >
> >
> > OK but we are adding yet another indirect call.
> >
> > Can you add a patch on top of it adding INDIRECT_CALL_INET() avoidance ?
> Sure, but do you think it will bring any benefit?

Sure, avoiding an indirect call might be the same gain than the
lock_sock() avoidance :)

> We don't have any indirect avoidance in __sys_getsockopt for the
> sock->ops->getsockopt() call.
> If we add it for this new bpf_bypass_getsockopt, we might as well add
> it for sock->ops->getsockopt?

Well, that is orthogonal to this patch.
As you may know, Google kernels do have a mitigation there already and
Brian may upstream it.

> And we need some new INDIRECT_CALL_INET2 such that f2 doesn't get
> disabled when ipv6 is disabled :-/

The same handler is called for IPv4 and IPv6, so you need the variant
with only one known handler (tcp_bpf_bypass_getsockopt)

Only it needs to make sure CONFIG_INET is enabled.

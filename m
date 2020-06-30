Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBCF20F0A5
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgF3Ijk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgF3Ijj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 04:39:39 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326E9C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 01:39:39 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 95so7136465otw.10
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJMt4WVmYovPqG5eJVjJcpMYP+qk+CQvvpa2yfUPoJE=;
        b=CI8s6J1+81ZNf9IDuMD/68vcGy+z2xDpHKKxiuq7PM87KyXIVyQglQ1EBxvsZqodjN
         fZm3ZC0b6llsPxfUK7D7zb+n0l/13p2scgftUA8bcfwcG244iGIjd1jOk70s0Hb4Bsv7
         tljappofaTMumv4dTjLTS5EmDYkA6YzPa34wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJMt4WVmYovPqG5eJVjJcpMYP+qk+CQvvpa2yfUPoJE=;
        b=JEHbc+sZEyVSIqAm9as4/hG7qyQvuhgag8veOmFlLTYM7klfsLzFTcuQ4HslRetKoR
         LfkN8JXK93xkff2PSvRvZDNhMUnHNDIhoww/ZPokTNDH3YLo65M9+L2ltikfpoSS+Bqs
         xaPuhv0vem6KV5jmrRscLrL5QH/l/PL6Aw3MQQZL+isSEgV7k61BZST9fwK28wehEvSu
         tgtD9t9SR1KgHFV1Op1eQ3Ag+hsD/sAQlUh2n5bgIO+Z0746VnAptE6Wh0konC0QkI2p
         lQlN4T0PJS4ZJChHQz5sS5xs/lxEcDM6SHTrHzmGcFieEFlzANEtqEXmfzNLypIfp/hK
         6YCA==
X-Gm-Message-State: AOAM532ZjwxMwSuxnWFwNzgC9ELltlyJd+CKXgxQP6RPfBwKltESXyki
        vdetNSlZKmK3qBO90UeUyL27z9UmuopvU6EjWxMtb9cATBqObw==
X-Google-Smtp-Source: ABdhPJyN2PMuHBwjKjZJQTuUYkcM08Rh13ohklAV8GkroOFBsso25c2Wrms37bkFf2rdyGB53GFDFa6AXRiZhsAoawE=
X-Received: by 2002:a9d:1c7:: with SMTP id e65mr15423971ote.147.1593506378463;
 Tue, 30 Jun 2020 01:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200629095630.7933-1-lmb@cloudflare.com> <07d10dab-64f7-d7af-25b9-a61b39c8daf2@fb.com>
In-Reply-To: <07d10dab-64f7-d7af-25b9-a61b39c8daf2@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 30 Jun 2020 09:39:27 +0100
Message-ID: <CACAyw9_5Dg=dTMk3TQiYFE3vzUuq68V2-NcpZCuiQqJFPn-0Dw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and flow_dissector
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 30 Jun 2020 at 06:48, Yonghong Song <yhs@fb.com> wrote:
>
> Since bpf_iter is mentioned here, I would like to provide a little
> context on how target_fd in link_create is treated there.

Thanks!

> Currently, target_fd is always 0 as it is not used. This is
> just easier if we want to use it in the future.
>
> In the future, bpf_iter can maintain that target_fd must be 0
> or it may not so. For example, it can add a flag value in
> link_create such that when flag is set it will take whatever
> value in target_fd and use it. Or it may just take a non-0
> target_fd as an indication of the flag is set. I have not
> finalized patches yet. I intend to do the latter, i.e.,
> taking a non-0 target_fd. But we will see once my bpf_iter
> patches for map elements are out.

I had a piece of code for sockmap which did something like this:

    prog = bpf_prog_get(attr->attach_bpf_fd)
    if (IS_ERR(prog))
        if (!attr->attach_bpf_fd)
            // fall back to old behaviour
        else
            return PTR_ERR(prog)
    else if (prog->type != TYPE)
        return -EINVAL

The benefit is that it continues to work if a binary is invoked with
stdin closed, which could lead to a BPF program with fd 0.

Could this work for bpf_iter as well?

>
> There is another example where 0 and non-0 prog_fd make a difference.
> The attach_prog_fd field when doing prog_load.
> When attach_prog_fd is 0, it means attaching to vmlinux through
> attach_btf_id. If attach_prog_fd is not 0, it means attaching to
> another bpf program (replace). So user space (libbpf) may
> already need to pay attention to this.

That is unfortunate. What was the reason to use 0 instead of -1 to
attach to vmlinux?

>
> > work around for fd 0 should we need to in the future.
> >
> > The detach case is more problematic: both cgroups and lirc2 verify
> > that attach_bpf_fd matches the currently attached program. This
> > way you need access to the program fd to be able to remove it.
> > Neither sockmap nor flow_dissector do this. flow_dissector even
> > has a check for CAP_NET_ADMIN because of this. The patch set
> > addresses this by implementing the desired behaviour.
> >
> > There is a possibility for user space breakage: any callers that
> > don't provide the correct fd will fail with ENOENT. For sockmap
> > the risk is low: even the selftests assume that sockmap works
> > the way I described. For flow_dissector the story is less
> > straightforward, and the selftests use a variety of arguments.
> >
> > I've includes fixes tags for the oldest commits that allow an easy
> > backport, however the behaviour dates back to when sockmap and
> > flow_dissector were introduced. What is the best way to handle these?
> >
> > This set is based on top of Jakub's work "bpf, netns: Prepare
> > for multi-prog attachment" available at
> > https://lore.kernel.org/bpf/87k0zwmhtb.fsf@cloudflare.com/T/
> >
> > Since v1:
> > - Adjust selftests
> > - Implement detach behaviour
> >
> > Lorenz Bauer (6):
> >    bpf: flow_dissector: check value of unused flags to BPF_PROG_ATTACH
> >    bpf: flow_dissector: check value of unused flags to BPF_PROG_DETACH
> >    bpf: sockmap: check value of unused args to BPF_PROG_ATTACH
> >    bpf: sockmap: require attach_bpf_fd when detaching a program
> >    selftests: bpf: pass program and target_fd in flow_dissector_reattach
> >    selftests: bpf: pass program to bpf_prog_detach in flow_dissector
> >
> >   include/linux/bpf-netns.h                     |  5 +-
> >   include/linux/bpf.h                           | 13 ++++-
> >   include/linux/skmsg.h                         | 13 +++++
> >   kernel/bpf/net_namespace.c                    | 22 ++++++--
> >   kernel/bpf/syscall.c                          |  6 +--
> >   net/core/sock_map.c                           | 53 +++++++++++++++++--
> >   .../selftests/bpf/prog_tests/flow_dissector.c |  4 +-
> >   .../bpf/prog_tests/flow_dissector_reattach.c  | 12 ++---
> >   8 files changed, 103 insertions(+), 25 deletions(-)
> >



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com

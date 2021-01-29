Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C67B3083BB
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 03:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhA2CTg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 21:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhA2CTb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 21:19:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 832E764E0E
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 02:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611886730;
        bh=XYPuFwwSZqrWzZncG+yO9VOwYufuCb47vMjFWLsHddk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LLH0DMqoHgfgXgr+ZuyVHEJycv371Un3wf7Hy4nUVJy2ZfKSJm1AvZgShsK0JlB1S
         SoFLGnFvzAKF+zvxQm3QYpF+cJGnXLWRUS3fwv5F77wdTw5SL/07I3Th1wyCXnZ750
         Y0y/rnRVE5NfFPaqW0Thljkk2DT2WwMYcsZeV8/bmeFf8p0UoDwI80gcQrd6EYll8i
         lGShc835dr2muarLVwCizlonB+9WgEShSN2OOAoOilKwshkWKKhsJV7Ppu9lVaRlAH
         BwDAYcfXwfR/DsgnZ3QgiAQcu5Ur+l1HcXsoAGgZgCzdMm4Ol9nLjL6a1YzBiLLQnG
         ycLZLIW3GEJ5g==
Received: by mail-ed1-f50.google.com with SMTP id c2so8861115edr.11
        for <bpf@vger.kernel.org>; Thu, 28 Jan 2021 18:18:50 -0800 (PST)
X-Gm-Message-State: AOAM531R2Khk2cNmi1FVbxjIQnJAKd6q+BdBR/Gbwk0WjZ/3wbqiq0Xl
        17gW/p4KtfFSj5/NZqm7FsSQZSx5gzo1ELbDz9xUrw==
X-Google-Smtp-Source: ABdhPJz2Xu2N1aF/Z7Sx/w1w3ilfhIvP0SEQsl2LdvoY2ZYkgCzacJ0xTs8UTPT4gmnnkfeYrX7gdRGIWsKUS12vcQ8=
X-Received: by 2002:a05:6402:b30:: with SMTP id bo16mr2883829edb.84.1611886728896;
 Thu, 28 Jan 2021 18:18:48 -0800 (PST)
MIME-Version: 1.0
References: <92a66173-6512-f1bc-0f9a-530c6c9a1ef0@fb.com> <CALCETrVZRiG+qQFrf_7NaCZ9o9f2-aUTgLNJgCzBfsswpG7kTA@mail.gmail.com>
 <20210129001130.3mayw2e44achrnbt@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVXdbXUMA_CJj1knMNxsHR2ao67apwk_BTTMPaQGxusag@mail.gmail.com>
 <20210129002642.iqlbssmp267zv7f2@ast-mbp.dhcp.thefacebook.com>
 <CALCETrUQuf6FX9EmuZur7vRwbeZBmoKeSYb9Rvx2ETp76SukOg@mail.gmail.com>
 <20210129004131.wzwnvdwjlio4traw@ast-mbp.dhcp.thefacebook.com>
 <CALCETrXdmdG2o20VY16vBMJ0p5nSuKOv7sTQtboKFDfuQr1nZA@mail.gmail.com>
 <20210129010441.4gaa4vzruenfb7zf@ast-mbp.dhcp.thefacebook.com>
 <CALCETrXeaEp5Q5UadA2_frxNFiUDyFx643N6SQf3Gy6G+ZtcNA@mail.gmail.com> <20210129015322.wngmsmyyon2ozcj6@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210129015322.wngmsmyyon2ozcj6@ast-mbp.dhcp.thefacebook.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 28 Jan 2021 18:18:37 -0800
X-Gmail-Original-Message-ID: <CALCETrU2pJUufTvr0c9jM2+ymSnYFWJ_mSJnCeEzaAiySkQyiA@mail.gmail.com>
Message-ID: <CALCETrU2pJUufTvr0c9jM2+ymSnYFWJ_mSJnCeEzaAiySkQyiA@mail.gmail.com>
Subject: Re: [PATCH bpf] x86/bpf: handle bpf-program-triggered exceptions properly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@fb.com>, X86 ML <x86@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 5:53 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 28, 2021 at 05:31:35PM -0800, Andy Lutomirski wrote:
> >
> > What exactly could the fault code even do to fix this up?  Something like:
> >
> > if (addr == 0 && SMAP off && error_code says it's kernel mode && we
> > don't have permission to map NULL) {
> >   special care for bpf;
> > }
>
> right. where 'special care' is checking extable and skipping single
> load instruction.
>
> > This seems arbitrary and fragile.  And it's not obviously
> > implementable safely without taking locks,
>
> search_bpf_extables() needs rcu_read_lock() only.
> Not the locks you're talking about.

I mean the locks in the if statement.  How am I supposed to tell
whether this fault is a special bpf fault or a normal page fault
without taking a lock to look up the VMA or to do some other hack?
Also, why should BPF get special dispensation to generate a special
kind of nonsensical page fault that no other kernel code is allowed to
do?

>
> > which we really ought not
> > to be doing from inside arbitrary bpf programs.
>
> Not in arbitrary progs. It's only available to progs loaded by root.
>
> > Keep in mind that, if
> > SMAP is unavailable, the fault code literally does not know whether
> > the page fault originated form a valid uaccess region.
> >
> > There's also always the possibility that you simultaneously run bpf
> > and something like Wine or DOSEMU2 that actually maps the zero page,
> > in which case the effect of the bpf code is going to be quite erratic
> > and will depend on which mm is loaded.
>
> It's tracing. Folks who write those progs accepted the fact that
> the data returned by probe_read is not going to be 100% accurate.

Is this really all tracing or is some of it actual live network code?

>
> bpf jit can insert !null check before every such special load
> (since it knows all of them), but it's an obvious performance loss
> that would be good to avoid. If fault handler can do this
> if (addr == 0 && ...) search_bpf_extables()
> at least in some conditions and cpu flags it's already a win.
> In all other cases bpf jit will insert !null checks.

Again, there is no guarantee that a page fault is even generated for
this.  And it doesn't seem very reasonable for the fault code to have
to decide whether a NULL pointer dereference is a special BPF fault or
a real user access fault against a VMA at address 9.

--Andy

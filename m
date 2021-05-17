Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D943837EF
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbhEQPrU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 11:47:20 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:35969 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343758AbhEQPmF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 May 2021 11:42:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 27C19273;
        Mon, 17 May 2021 11:40:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 17 May 2021 11:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wst7L607Txv7R6hkiDuGqcVCA4a
        4080QIuIbxzlHCcU=; b=vdWhaeQ8Ry88uZH2ZQx7NTjdu982iHmRxpRteix8qpH
        q8OidQcWzX9HF68eMo5a6DuPvSLtXiz9pe1n+xpUQ/s7KyQZoV+d3JdXLgbeqbZ5
        km38NOqL2Y0bvgMYBKGIZYS/Mk5M73Np2qewnaeXNMWiL/FTBtxaXN9kCnyZNGHd
        TBS67A8rMpZZb/gFsmHA5zjeMj4K4EK6N6X5/f2jWTTJBeJFGsgYwTRpMnl1IEjL
        3Kl73TGQmgKdEhW568XKsrJ3eXd04pCCWsqbpPeIvJmfgBZ9+hS6Os8osWpbDo0y
        iw9gtqnPKPd4kV2VlO81LBWdEGuChuciXfpZsBvCIeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wst7L6
        07Txv7R6hkiDuGqcVCA4a4080QIuIbxzlHCcU=; b=gsOQPxbTg6IkY5X0kjex4H
        GYEIJDZrSrb8/WrmXu6/RhfHgoCo1jhYNxNhY5/7wnUi+hyPTf2rkQbEvzpuzlQv
        /g3yd3hlSKHY+/SDpY/wB+f9hZYZ63j+XGKXzci7jE1tLvEPGMvgAslxzfjI32A3
        xd2JuZsZXAvZfhFIpt5ZLJYuXSy9U3rCVIJSBcvOe+wZa7qrqzRdQVOO9FksjGVE
        hwvHU0iSc/eH04VV0f4T3Z0qjq5CUnV09p09hsagRubYNPbjS4TzI8g+PmK1aobH
        bjUtnDLlb4NqQ9jvjGfR9MFnPS7UzcOKNrb2ZPS2R11gE9h15SX0ESZXnqN337bA
        ==
X-ME-Sender: <xms:bo6iYKvN-acJkgM1LrBFpFo8Uvu0L9UYI1QgZEzBoLfjgFm6HDES2w>
    <xme:bo6iYPdPvh-GHCmDpFdx9-UcUa8A8BMRdt604NE1vRAdgYdTWhxO-0fzJ5XWiNPlv
    SP38q0KUtMV5WlZMBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeihedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpedttdeljeetiedthfetueevudegudfgjedvvdeifeehgfeuhfeileeihfej
    veduveenucffohhmrghinhepuhhrlhguvghfvghnshgvrdgtohhmnecukfhppeduvdekrd
    dutdejrddvgedurddukedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:bo6iYFxO9GBF_VOTjiIC81q_-53fpwmmv0TirqPNjFSC1Sec9p8rZw>
    <xmx:bo6iYFNxHxDdGYtBqSGGv4QBkgREYKL5Hxp0rIn26tpOPXWCGoPBrQ>
    <xmx:bo6iYK-W-8vvBB5e-GzqJzmx-8HiqDH-hmvtV9tcOepHFH4StdaW5A>
    <xmx:b46iYAndTQNYU9J2HasiQmBT3hX_Q1Fe4y2z3tFw10ie5SViaccYCKVn7ks>
Received: from cisco (unknown [128.107.241.182])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 17 May 2021 11:40:25 -0400 (EDT)
Date:   Mon, 17 May 2021 09:40:24 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Tianyin Xu <tyxu@illinois.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        bpf <bpf@vger.kernel.org>, "Zhu, YiFei" <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        "Jia, Jinghao" <jinghao7@illinois.edu>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
Message-ID: <20210517154024.GE1964106@cisco>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 16, 2021 at 03:38:00AM -0500, Tianyin Xu wrote:
> On Sat, May 15, 2021 at 10:49 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On 5/10/21 10:21 PM, YiFei Zhu wrote:
> > > On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > >>>
> > >>> From: YiFei Zhu <yifeifz2@illinois.edu>
> > >>>
> > >>> Based on: https://urldefense.com/v3/__https://lists.linux-foundation.org/pipermail/containers/2018-February/038571.html__;!!DZ3fjg!thbAoRgmCeWjlv0qPDndNZW1j6Y2Kl_huVyUffr4wVbISf-aUiULaWHwkKJrNJyo$
> > >>>
> > >>> This patchset enables seccomp filters to be written in eBPF.
> > >>> Supporting eBPF filters has been proposed a few times in the past.
> > >>> The main concerns were (1) use cases and (2) security. We have
> > >>> identified many use cases that can benefit from advanced eBPF
> > >>> filters, such as:
> > >>
> > >> I haven't reviewed this carefully, but I think we need to distinguish
> > >> a few things:
> > >>
> > >> 1. Using the eBPF *language*.
> > >>
> > >> 2. Allowing the use of stateful / non-pure eBPF features.
> > >>
> > >> 3. Allowing the eBPF programs to read the target process' memory.
> > >>
> > >> I'm generally in favor of (1).  I'm not at all sure about (2), and I'm
> > >> even less convinced by (3).
> > >>
> > >>>
> > >>>   * exec-only-once filter / apply filter after exec
> > >>
> > >> This is (2).  I'm not sure it's a good idea.
> > >
> > > The basic idea is that for a container runtime it may wait to execute
> > > a program in a container without that program being able to execve
> > > another program, stopping any attack that involves loading another
> > > binary. The container runtime can block any syscall but execve in the
> > > exec-ed process by using only cBPF.
> > >
> > > The use case is suggested by Andrea Arcangeli and Giuseppe Scrivano.
> > > @Andrea and @Giuseppe, could you clarify more in case I missed
> > > something?
> >
> > We've discussed having a notifier-using filter be able to replace its
> > filter.  This would allow this and other use cases without any
> > additional eBPF or cBPF code.
> >
> 
> A notifier is not always a solution (even ignoring its perf overhead).
> 
> One problem, pointed out by Andrea Arcangeli, is that notifiers need
> userspace daemons. So, it can hardly be used by daemonless container
> engines like Podman.

I'm not sure I buy this argument. Podman already has a conmon instance
for each container, this could be a child of that conmon process, or
live inside conmon itself.

Tycho

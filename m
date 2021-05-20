Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A738A400
	for <lists+bpf@lfdr.de>; Thu, 20 May 2021 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhETKAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 06:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235188AbhETJ5w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 May 2021 05:57:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50D4061411;
        Thu, 20 May 2021 09:38:02 +0000 (UTC)
Date:   Thu, 20 May 2021 11:37:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tianyin Xu <tyxu@illinois.edu>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20210520093759.mj5diqjdmj2dekdr@wittgenstein>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com>
 <108b4b9c2daa4123805d2b92cf51374b@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEEkDeUBcJAswpBjcQNWk7QDcO8BZR=uvVfm-+qe714tYg@mail.gmail.com>
 <20210520085613.gvshk4jffmzggvsm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520085613.gvshk4jffmzggvsm@wittgenstein>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 20, 2021 at 10:56:13AM +0200, Christian Brauner wrote:
> On Thu, May 20, 2021 at 03:16:10AM -0500, Tianyin Xu wrote:
> > On Mon, May 17, 2021 at 10:40 AM Tycho Andersen <tycho@tycho.pizza> wrote:
> > >
> > > On Sun, May 16, 2021 at 03:38:00AM -0500, Tianyin Xu wrote:
> > > > On Sat, May 15, 2021 at 10:49 AM Andy Lutomirski <luto@kernel.org> wrote:
> > > > >
> > > > > On 5/10/21 10:21 PM, YiFei Zhu wrote:
> > > > > > On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > > >> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > > > > >>>
> > > > > >>> From: YiFei Zhu <yifeifz2@illinois.edu>
> > > > > >>>
> > > > > >>> Based on: https://urldefense.com/v3/__https://lists.linux-foundation.org/pipermail/containers/2018-February/038571.html__;!!DZ3fjg!thbAoRgmCeWjlv0qPDndNZW1j6Y2Kl_huVyUffr4wVbISf-aUiULaWHwkKJrNJyo$
> > > > > >>>
> > > > > >>> This patchset enables seccomp filters to be written in eBPF.
> > > > > >>> Supporting eBPF filters has been proposed a few times in the past.
> > > > > >>> The main concerns were (1) use cases and (2) security. We have
> > > > > >>> identified many use cases that can benefit from advanced eBPF
> > > > > >>> filters, such as:
> > > > > >>
> > > > > >> I haven't reviewed this carefully, but I think we need to distinguish
> > > > > >> a few things:
> > > > > >>
> > > > > >> 1. Using the eBPF *language*.
> > > > > >>
> > > > > >> 2. Allowing the use of stateful / non-pure eBPF features.
> > > > > >>
> > > > > >> 3. Allowing the eBPF programs to read the target process' memory.
> > > > > >>
> > > > > >> I'm generally in favor of (1).  I'm not at all sure about (2), and I'm
> > > > > >> even less convinced by (3).
> > > > > >>
> > > > > >>>
> > > > > >>>   * exec-only-once filter / apply filter after exec
> > > > > >>
> > > > > >> This is (2).  I'm not sure it's a good idea.
> > > > > >
> > > > > > The basic idea is that for a container runtime it may wait to execute
> > > > > > a program in a container without that program being able to execve
> > > > > > another program, stopping any attack that involves loading another
> > > > > > binary. The container runtime can block any syscall but execve in the
> > > > > > exec-ed process by using only cBPF.
> > > > > >
> > > > > > The use case is suggested by Andrea Arcangeli and Giuseppe Scrivano.
> > > > > > @Andrea and @Giuseppe, could you clarify more in case I missed
> > > > > > something?
> > > > >
> > > > > We've discussed having a notifier-using filter be able to replace its
> > > > > filter.  This would allow this and other use cases without any
> > > > > additional eBPF or cBPF code.
> > > > >
> > > >
> > > > A notifier is not always a solution (even ignoring its perf overhead).
> > > >
> > > > One problem, pointed out by Andrea Arcangeli, is that notifiers need
> > > > userspace daemons. So, it can hardly be used by daemonless container
> > > > engines like Podman.
> > >
> > > I'm not sure I buy this argument. Podman already has a conmon instance
> > > for each container, this could be a child of that conmon process, or
> > > live inside conmon itself.
> > >
> > > Tycho
> > 
> > I checked with Andrea Arcangeli and Giuseppe Scrivano who are working on Podman.
> > 
> > You are right that Podman is not completely daemonless. However, “the
> > fact it's no entirely daemonless doesn't imply it's a good idea to
> > make it worse and to add complexity to the background conmon daemon or
> > to add more daemons.”
> > 
> > TL;DR. User notifiers are surely more flexible, but are also more
> > expensive and complex to implement, compared with ebpf filters. /*
> > I’ll reply to Sargun’s performance argument in a separate email */
> > 
> > I'm sure you know Podman well, but let me still move some jade from
> > Andrea and Giuseppe (all credits on podmon/crun are theirs) to
> > elaborate the point, for folks cced on the list who are not very
> > familiar with Podman.
> > 
> > Basically, the current order goes as follows:
> > 
> >          podman -> conmon -> crun -> container_binary
> >                                \
> >                                 - seccomp done at crun level, not conmon
> > 
> > At runtime, what's left is:
> > 
> >          conmon -> container_binary  /* podman disappears; crun disappears */
> > 
> > So, to go through and use seccomp notify to block `exec`, we can
> > either start the container_binary with a seccomp agent wrapper, or
> > bloat the common binary (as pointed out by Tycho).
> > 
> > If we go with the first approach, we will have:
> > 
> >          podman -> conmon -> crun -> seccomp_agent -> container_binary
> > 
> > So, at runtime we'd be left with one more daemon:
> > 
> >         conmon -> seccomp_agent -> container_binary
> 
> That seems like a strawman. I don't see why this has to be out of
> process or a separate daemon. Conmon uses a regular event loop. Adding
> support for processing notifier syscall notifications is
> straightforward. Moving it to a plugin as you mentioned below is a
> design decision not a necessity.
> 
> > 
> > Apparently, nobody likes one more daemon. So, the proposal from
> 
> I'm not sure such a blanket statements about an indeterminate group of
> people's alleged preferences constitutes a technical argument wny we
> need ebpf in seccomp.

I was missing a :) here.

> 
> > Giuseppe was/is to use user notifiers as plugins (.so) loaded by
> > conmon:
> > https://github.com/containers/conmon/pull/190
> > https://github.com/containers/crun/pull/438
> > 
> > Now, with the ebpf filter support, one can implement the same thing
> > using an embarrassingly simple ebpf filter and, thanks to Giuseppe,
> > this is well supported by crun.
> 
> So I think this is trying to jump the gun by saying "Look, the result
> might be simpler.". That may even be the case - though I'm not yet
> convinced - but Andy's point stands that this brings a slew of issues on
> the table that need clear answers. Bringing stateful ebpf features into
> seccomp is a pretty big step and especially around the
> privilege/security model it looks pretty handwavy right now.
> 
> Christian
> 

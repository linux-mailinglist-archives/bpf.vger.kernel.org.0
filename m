Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027A038A08B
	for <lists+bpf@lfdr.de>; Thu, 20 May 2021 11:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhETJHO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 05:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhETJHO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 May 2021 05:07:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3C49610CB;
        Thu, 20 May 2021 09:05:47 +0000 (UTC)
Date:   Thu, 20 May 2021 11:05:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, containers@lists.linux.dev,
        bpf <bpf@vger.kernel.org>, YiFei Zhu <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Austin Kuo <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        Jinghao Jia <jinghao7@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
Message-ID: <20210520090543.vay4guole7hkeaf3@wittgenstein>
References: <cover.1620499942.git.yifeifz2@illinois.edu>
 <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <b3a1684b-86e4-74c4-184b-7700613aa838@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3a1684b-86e4-74c4-184b-7700613aa838@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 15, 2021 at 08:49:01AM -0700, Andy Lutomirski wrote:
> On 5/10/21 10:21 PM, YiFei Zhu wrote:
> > On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.org> wrote:
> >> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> >>>
> >>> From: YiFei Zhu <yifeifz2@illinois.edu>
> >>>
> >>> Based on: https://lists.linux-foundation.org/pipermail/containers/2018-February/038571.html
> >>>
> >>> This patchset enables seccomp filters to be written in eBPF.
> >>> Supporting eBPF filters has been proposed a few times in the past.
> >>> The main concerns were (1) use cases and (2) security. We have
> >>> identified many use cases that can benefit from advanced eBPF
> >>> filters, such as:
> >>
> >> I haven't reviewed this carefully, but I think we need to distinguish
> >> a few things:
> >>
> >> 1. Using the eBPF *language*.
> >>
> >> 2. Allowing the use of stateful / non-pure eBPF features.
> >>
> >> 3. Allowing the eBPF programs to read the target process' memory.
> >>
> >> I'm generally in favor of (1).  I'm not at all sure about (2), and I'm
> >> even less convinced by (3).
> >>
> >>>
> >>>   * exec-only-once filter / apply filter after exec
> >>
> >> This is (2).  I'm not sure it's a good idea.
> > 
> > The basic idea is that for a container runtime it may wait to execute
> > a program in a container without that program being able to execve
> > another program, stopping any attack that involves loading another
> > binary. The container runtime can block any syscall but execve in the
> > exec-ed process by using only cBPF.
> > 
> > The use case is suggested by Andrea Arcangeli and Giuseppe Scrivano.
> > @Andrea and @Giuseppe, could you clarify more in case I missed
> > something?
> 
> We've discussed having a notifier-using filter be able to replace its
> filter.  This would allow this and other use cases without any
> additional eBPF or cBPF code.

Are you referring to sm like I sketched in
https://lore.kernel.org/containers/20210301110907.2qoxmiy55gpkgwnq@wittgenstein/
?

> 
> >> eBPF doesn't really have a privilege model yet.  There was a long and
> >> disappointing thread about this awhile back.
> > 
> > The idea is that “seccomp-eBPF does not make life easier for an
> > adversary”. Any attack an adversary could potentially utilize
> > seccomp-eBPF, they can do the same with other eBPF features, i.e. it
> > would be an issue with eBPF in general rather than specifically
> > seccomp’s use of eBPF.
> > 
> > Here it is referring to the helpers goes to the base
> > bpf_base_func_proto if the caller is unprivileged (!bpf_capable ||
> > !perfmon_capable). In this case, if the adversary would utilize eBPF
> > helpers to perform an attack, they could do it via another
> > unprivileged prog type.
> > 
> > That said, there are a few additional helpers this patchset is adding:
> > * get_current_uid_gid
> > * get_current_pid_tgid
> >   These two provide public information (are namespaces a concern?). I

If they are seen from userspace in any way then these must be resolved
relative to the caller's userns or caller's pidns. So yes, namespaces
need to be taken into account.

> > have no idea what kind of exploit it could add unless the adversary
> > somehow side-channels the task_struct? But in that case, how is the
> > reading of task_struct different from how the rest of the kernel is
> > reading task_struct?
> 
> Yes, namespaces are a concern.  This idea got mostly shot down for kdbus
> (what ever happened to that?), and it likely has the same problems for
> seccomp.
> 
> >>
> >> What is this for?
> > 
> > Memory reading opens up lots of use cases. For example, logging what
> > files are being opened without imposing too much performance penalty
> > from strace. Or as an accelerator for user notify emulation, where
> > syscalls can be rejected on a fast path if we know the memory contents
> > does not satisfy certain conditions that user notify will check.
> > 
> 
> This has all kinds of race conditions.
> 
> 
> I hate to be a party pooper, but this patchset is going to very high bar
> to acceptance.  Right now, seccomp has a couple of excellent properties:
> 
> First, while it has limited expressiveness, it is simple enough that the
> implementation can be easily understood and the scope for
> vulnerabilities that fall through the cracks of the seccomp sandbox
> model is low.  Compare this to Windows' low-integrity/high-integrity
> sandbox system: there is a never ending string of sandbox escapes due to
> token misuse, unexpected things at various integrity levels, etc.
> Seccomp doesn't have tokens or integrity levels, and these bugs don't
> happen.
> 
> Second, seccomp works, almost unchanged, in a completely unprivileged
> context.  The last time making eBPF work sensibly in a less- or

Yeah, which is pretty important.

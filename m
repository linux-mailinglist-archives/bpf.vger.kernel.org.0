Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8AC3AD111
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 19:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhFRRXN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 13:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhFRRXN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 13:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B60F4611CD;
        Fri, 18 Jun 2021 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624036863;
        bh=+Jg/bfxNuGBmNHrK+MRsqTgFzVE+q+JmRTexmJwVyWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKam7Y1M05dH9OH6xEF5PVqpdIE1n/Beq8rf4VMgLnzexQXixdGNKHxt6+XkSFJtH
         5Z4Ydug6Rm522DpuFZ+nGv7OMvyswv010rHxbF1fZwOpwutnyULLdKN8+gY0nyMpU0
         319ar+aHvI7FrVQSrrSPrSjyuPIWVhRnjLnoUutmwuWM+IgLJzBmO9hd72kNkFwcmB
         T4qt1TI007gzIMauluWLi7jfixKb1TXLtYY+Eg9K6pVHQ4IeBNUA8qpNSO36JdhZ2S
         sQJPY+61iktVMlWFHALWv5bqWI/FF9nAcvSqCLD30nfx/z3s3va3E462BPuLoEbbAP
         gHNWfrhCf++hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C42340B1A; Fri, 18 Jun 2021 14:21:00 -0300 (-03)
Date:   Fri, 18 Jun 2021 14:21:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, siudin@fb.com
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
Message-ID: <YMzV/C2A0PAHsLuD@kernel.org>
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org>
 <YMopYxHgmoNVd3Yl@kernel.org>
 <YMph3VeKA1Met65X@kernel.org>
 <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
 <YMtgz+hcE/7iO7Ux@kernel.org>
 <CAEf4BzbK4jN7c8aa05xGyLm_FJKgywW8Ju8dA11VAJ9Nx8drVQ@mail.gmail.com>
 <YMuzAfK6vwbeN3XX@kernel.org>
 <CAEf4BzZWq21zP+1C4=qqWGQ3WUXK-pvt+rWpcsh_971qAw4Wzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZWq21zP+1C4=qqWGQ3WUXK-pvt+rWpcsh_971qAw4Wzw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 17, 2021 at 02:52:57PM -0700, Andrii Nakryiko escreveu:
> On Thu, Jun 17, 2021 at 1:39 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Thu, Jun 17, 2021 at 01:00:11PM -0700, Andrii Nakryiko escreveu:
> > > On Thu, Jun 17, 2021 at 7:48 AM Arnaldo Carvalho de Melo
> > > <arnaldo.melo@gmail.com> wrote:
> > > >
> > > > Em Wed, Jun 16, 2021 at 03:36:54PM -0700, Andrii Nakryiko escreveu:
> > > > > On Wed, Jun 16, 2021 at 1:41 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > > > And if I use pahole's BTF loader I find the info about that function:
> > > > > >
> > > > > > [acme@seventh linux]$ strace -e openat -o /tmp/bla pfunct -F btf tcp_cong_avoid_ai  ; grep vmlinux /tmp/bla
> > > > > > void tcp_cong_avoid_ai(struct tcp_sock * tp, u32 w, u32 acked);
> > > > > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 3
> > > > > >
> > > > > > So this should be unrelated to the breakage you noticed in the CI.
> > > > > >
> > > > > > I'm trying to to reproduce the CI breakage by building the kernel and
> > > > > > running selftests after a reboot.
> > > > > >
> > > > > > I suspect I'm missing something, can you see what it is?
> > > > >
> > > > > Oh, I didn't realize initially what it is. This is not kernel-related,
> > > > > you are right. You just need newer Clang. Can you please use nightly
> > > > > version or build from sources? Basically, your Clang is too old and it
> > > > > doesn't generate BTF information for extern functions in BPF code.
> > > >
> > > > Oh well, I thought that that clang was new enough, the system being
> > > > Fedora rawhide:
> > > >
> > > > [acme@seventh ~]$ clang -v |& head -1
> > > > clang version 12.0.0 (https://github.com/llvm/llvm-project 87369c626114ae17f4c637635c119e6de0856a9a)
> > > >
> > > > I'm now building the single-repo main...
> > > >
> > > > Would you consider a patch for libbpf that would turn this:
> > > >
> > > > > > > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > > > > > > Error: failed to open BPF object file: No such file or directory
> > > > > > > make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 255
> > > > > > > make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h'
> > > > > > > make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
> > > >
> > > > Into:
> > > >
> > > > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > > > HINT: Please update your clang/llvm toolchain to at least cset abcdef123456
> > > > HINT: That is where clang started generating BTF information for extern functions in BPF code.
> > > >
> > > > ?
> > > >
> > > > :-)
> > >
> > > I'd rather not :)
> >
> > Not even a "please update clang?"
> >
> 
> It could be old clang, it could also be because BPF program wasn't
> built with BTF (i.e., you didn't specify -g during clang invocation),
> it could probably be due to some other problems as well.

Perhaps:

"Please look at http://bla.html/known-reasons-for-failure.html?

Perhaps we could even ask the Cilium people to take care of that since
they have such wonderful, detailed docs? 8-)

I understand that it is indeed difficult (albeit I find it valid/useful)
to give useful information about the myriad ways this can blown up, but
reducing to some degree the difficulties of testing libbpf, etc, is
something I think is important.
 
> I don't want libbpf to turn into a library that's constantly trying to
> guess possible problems. It will become a complete mess to maintain.
> And when it will still be wrong sometimes, causing more harm than
> being helpful. Especially for relatively uncommon problems like this.
> 
> Those people who are trying to use features like BPF unstable helpers
> (calling whitelisted kernel functions), should know that they need
> Clang of some version and build with BTF. We have that also mentioned
> in selftest/bpf/README.rst. I'd rather not duplicate all that in
> libbpf code as well.

Perhaps then just say:

"Please run: cat tools/testing/selftest/bpf/README.rst"

8-)

This could be in the makefile, no need to bother libbpf with that.

You're working on this daily, some people do it from time to time, but
nah, I'll stop here, felt just that I had to say it fwiw.

- Arnaldo
 
> > "-2" and "Error 255" doesn't seem that helpful :-\
> 
> But "failed to find BTF for extern 'tcp_cong_avoid_ai'" is pretty
> helpful. -2 is for more involved debugging, if necessary.

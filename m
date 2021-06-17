Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904173AB678
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhFQOu7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 10:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231759AbhFQOu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 10:50:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7BED613E9;
        Thu, 17 Jun 2021 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623941330;
        bh=diSD2DV+ZMSbg7QBx9qRA4lRHgK0oR6VJQGUEUYjj4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opkK5Rty+mv8NbdpPEsQjyN1t2JTj02HtkNefuZ+uC7DScdpkGrr5n/rpVvBj4A6J
         7ms+c9cBkuL/gkovXTfd4q32/TIWyLrXi74Kni3OiJcgWybEgut/QS74Kupa3QUjfU
         WnbesIrb7O3zuhJKssszI2bJzb4BrGQN5di3JBxTe3M3jsNJOQ4M9u9fXyAOEbDML3
         Nv+OVALG83VMOIOy2nHXwQamP7oE0326KB0XGcQu71SBf+RIShcxfuhQBEUEHp1IVz
         M43v4ofF8KRvLsXEM+7/WMThsAVvqxmSJlTyNjsrPhaiEIW2IXdzZ+kXfgtwkyy2ue
         e4GthMF48EH/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DDE7140B1A; Thu, 17 Jun 2021 11:48:47 -0300 (-03)
Date:   Thu, 17 Jun 2021 11:48:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, siudin@fb.com
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
Message-ID: <YMtgz+hcE/7iO7Ux@kernel.org>
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org>
 <YMopYxHgmoNVd3Yl@kernel.org>
 <YMph3VeKA1Met65X@kernel.org>
 <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 16, 2021 at 03:36:54PM -0700, Andrii Nakryiko escreveu:
> On Wed, Jun 16, 2021 at 1:41 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > And if I use pahole's BTF loader I find the info about that function:
> >
> > [acme@seventh linux]$ strace -e openat -o /tmp/bla pfunct -F btf tcp_cong_avoid_ai  ; grep vmlinux /tmp/bla
> > void tcp_cong_avoid_ai(struct tcp_sock * tp, u32 w, u32 acked);
> > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 3
> >
> > So this should be unrelated to the breakage you noticed in the CI.
> >
> > I'm trying to to reproduce the CI breakage by building the kernel and
> > running selftests after a reboot.
> >
> > I suspect I'm missing something, can you see what it is?
> 
> Oh, I didn't realize initially what it is. This is not kernel-related,
> you are right. You just need newer Clang. Can you please use nightly
> version or build from sources? Basically, your Clang is too old and it
> doesn't generate BTF information for extern functions in BPF code.

Oh well, I thought that that clang was new enough, the system being
Fedora rawhide:

[acme@seventh ~]$ clang -v |& head -1
clang version 12.0.0 (https://github.com/llvm/llvm-project 87369c626114ae17f4c637635c119e6de0856a9a)

I'm now building the single-repo main...

Would you consider a patch for libbpf that would turn this:

> > > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > > Error: failed to open BPF object file: No such file or directory
> > > make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 255
> > > make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h'
> > > make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'

Into:

libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
HINT: Please update your clang/llvm toolchain to at least cset abcdef123456
HINT: That is where clang started generating BTF information for extern functions in BPF code.

?

:-)

- Arnaldo

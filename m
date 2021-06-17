Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E823ABD29
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 21:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhFQTzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 15:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhFQTzt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 15:55:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED035613D6;
        Thu, 17 Jun 2021 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623959621;
        bh=fJ2mqovoHORvauCeZ9VxN8n7wJ8L94nfBBooCEaeJeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQfSzXiBbpUBGM5IALEwWyjK1x/wBgNiCeZwiUdZAbGgpxBP0gVGXQXyCXx6VThNO
         nmiyTQalHAicfUaIE9Szh3odcSrf2CVcTu0muXCNiKAdkEKK6dnn7THJkYtisI/Oy+
         sH2oc3KIzTeI6ie7TmFh3CwDWCqtu4El0MEuy6u/M4ePP49cB2lwF0ksHzSrcrCjdx
         CAx4c0/hFJ5cJ77ZyzMoegPHVqfHsWgOD28VCpajUItmyaO0jNJl7xurrUgXJakEhj
         cm+DnBAcU0lzRbMPMF0T8s6oMSG9iyiDVwy73elU2zuUbLqutpJpkOG0j3AbZpSKKL
         oZ82KLIZkDWUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FE6140B1A; Thu, 17 Jun 2021 16:53:38 -0300 (-03)
Date:   Thu, 17 Jun 2021 16:53:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, siudin@fb.com
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
Message-ID: <YMuoQntxW1zOujHU@kernel.org>
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org>
 <YMopYxHgmoNVd3Yl@kernel.org>
 <YMph3VeKA1Met65X@kernel.org>
 <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
 <YMtgz+hcE/7iO7Ux@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMtgz+hcE/7iO7Ux@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jun 17, 2021 at 11:48:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jun 16, 2021 at 03:36:54PM -0700, Andrii Nakryiko escreveu:
> > On Wed, Jun 16, 2021 at 1:41 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > And if I use pahole's BTF loader I find the info about that function:

> > > [acme@seventh linux]$ strace -e openat -o /tmp/bla pfunct -F btf tcp_cong_avoid_ai  ; grep vmlinux /tmp/bla
> > > void tcp_cong_avoid_ai(struct tcp_sock * tp, u32 w, u32 acked);
> > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 3

> > > So this should be unrelated to the breakage you noticed in the CI.

> > > I'm trying to to reproduce the CI breakage by building the kernel and
> > > running selftests after a reboot.

> > > I suspect I'm missing something, can you see what it is?

> > Oh, I didn't realize initially what it is. This is not kernel-related,
> > you are right. You just need newer Clang. Can you please use nightly
> > version or build from sources? Basically, your Clang is too old and it
> > doesn't generate BTF information for extern functions in BPF code.

> Oh well, I thought that that clang was new enough, the system being
> Fedora rawhide:

> [acme@seventh ~]$ clang -v |& head -1
> clang version 12.0.0 (https://github.com/llvm/llvm-project 87369c626114ae17f4c637635c119e6de0856a9a)

> I'm now building the single-repo main...

So I updated clang and now I'm stumbling on another one, again using
pahole 1.21 + fixes, without any of my changes, is this a known issue?

[root@seventh bpf]# pwd
/mnt/linux/tools/testing/selftests/bpf
[root@seventh bpf]# git log --oneline -5
94f0b2d4a1d0 (HEAD -> master, torvalds/master) proc: only require mm_struct for writing
a33d62662d27 afs: Fix an IS_ERR() vs NULL check
009c9aa5be65 (tag: v5.13-rc6) Linux 5.13-rc6
e4e453434a19 Merge tag 'perf-tools-fixes-for-v5.13-2021-06-13' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
960f0716d80f Merge tag 'nfs-for-5.13-3' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
[root@seventh bpf]#
[root@seventh bpf]# make run_tests
<SNIP>
  GEN-SKEL [test_progs] atomic_bounds.skel.h
  GEN-SKEL [test_progs] atomics.skel.h
  GEN-SKEL [test_progs] bind4_prog.skel.h
libbpf: elf: skipping unrecognized data section(6) .rodata.str1.1
  GEN-SKEL [test_progs] bind6_prog.skel.h
libbpf: elf: skipping unrecognized data section(6) .rodata.str1.1
  GEN-SKEL [test_progs] bind_perm.skel.h
  GEN-SKEL [test_progs] bpf_cubic.skel.h
libbpf: ELF relo #0 in section #15 has unexpected type 2 in /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.o
Error: failed to link '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.o': Unknown error -22 (-22)
make: *** [Makefile:456: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 234
[root@seventh bpf]# clang -v |& head -2
clang version 13.0.0 (https://github.com/llvm/llvm-project dee2c76b4c46e71903e3d86ab7555a80d51d1288)
Target: x86_64-unknown-linux-gnu
[root@seventh bpf]#

- Arnaldo
 
> Would you consider a patch for libbpf that would turn this:
> 
> > > > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > > > Error: failed to open BPF object file: No such file or directory
> > > > make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 255
> > > > make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h'
> > > > make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
> 
> Into:
> 
> libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> HINT: Please update your clang/llvm toolchain to at least cset abcdef123456
> HINT: That is where clang started generating BTF information for extern functions in BPF code.
> 
> ?
> 
> :-)

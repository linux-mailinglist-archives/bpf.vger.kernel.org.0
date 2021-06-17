Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8325E3ABD43
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhFQUFi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 16:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhFQUFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 16:05:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF9CC061574;
        Thu, 17 Jun 2021 13:03:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q16so5190281qkm.9;
        Thu, 17 Jun 2021 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StOKYIiM/dV/OSQpwU3+g7HtlFaLeIW/pcen05uYEvc=;
        b=pyl6qARipAL1WPg+pB/N8hfrcQyY4KLD6kG8Ks0IkAcKPsvvmkawFCV0rDT1YErwIA
         KwDJ4Jbivh0BGTpKh0jt2ok4P02/ozjrqA8/4yFNQTS6VXem5Wt9SarI5VvIeyHW8+ru
         95Q9lK4J5/pw8EkgnytdL6P68f0PBhyGfpRARped9cNS8Pjsd+MfenDbUh6PYVvl3ImT
         u0V4r2u2dSu1t4Hs00oNv0LHPshl7bh1w4Dxfdj7oIlGuCDJAhDW1WstEX8aXvoM83v0
         IUjYGrr0oJ/y3mYOKTMN0tc4roBr3Xqxj73q1MGgEQuH9UeEgMNHZe0VfXXbCJS9Ljoz
         FuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StOKYIiM/dV/OSQpwU3+g7HtlFaLeIW/pcen05uYEvc=;
        b=aHWOPCbfmlGGGrfyABjNxFOofUPugWoXDRBWspas5xAGVpnxpeTc7YqnioarOe/TfH
         9yohgZHjFuTiinaaxKnW8nqiYZCI1VMJxmR1FtfRt2yK221cdm6+OTLf1echl/xl47OO
         gJ2v7olTf7EuhWb7ATzK8L/s5m7stO88rNwblBdaHSnMDY7dh5Ah08OnBxwCwZzwXOpT
         U2n5imn+2L7513xT3ft3lAGHyyW8L44YpJo7p6ft60AG+Hwu4h/xw+rJu9WwirF7wiIZ
         vScfzKGfK7SE8YiQTmW9bRauIonmEhD5nLHYDumgZvWr1WDpR9h1SBsmf9kdenuMgrnK
         t33A==
X-Gm-Message-State: AOAM532XhTjEAOO3UAkkht6Uc6oe2w1tTp9Wp8d93/kGc9c5WnZN7/ZP
        ulsAd/izvvtGFWG6MMxSubQ4QQ6lp4iFDz1h7qs=
X-Google-Smtp-Source: ABdhPJxEoWVxpMLcTa0ub8BWld426Y6pKJn0kgsdzHFEhSR8o06KA6Qx9jUhRXs+h8H4/f+ZqIwmaNUr11p9lA0XN1o=
X-Received: by 2002:a25:870b:: with SMTP id a11mr916888ybl.260.1623960208827;
 Thu, 17 Jun 2021 13:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org> <YMopYxHgmoNVd3Yl@kernel.org>
 <YMph3VeKA1Met65X@kernel.org> <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
 <YMtgz+hcE/7iO7Ux@kernel.org> <YMuoQntxW1zOujHU@kernel.org>
In-Reply-To: <YMuoQntxW1zOujHU@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 13:03:17 -0700
Message-ID: <CAEf4BzaA2XwjeVNWTa2eyMvzkwp9eUHSXqMVJukMf0_mzh8CnQ@mail.gmail.com>
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 12:53 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Jun 17, 2021 at 11:48:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Jun 16, 2021 at 03:36:54PM -0700, Andrii Nakryiko escreveu:
> > > On Wed, Jun 16, 2021 at 1:41 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > And if I use pahole's BTF loader I find the info about that function:
>
> > > > [acme@seventh linux]$ strace -e openat -o /tmp/bla pfunct -F btf tcp_cong_avoid_ai  ; grep vmlinux /tmp/bla
> > > > void tcp_cong_avoid_ai(struct tcp_sock * tp, u32 w, u32 acked);
> > > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 3
>
> > > > So this should be unrelated to the breakage you noticed in the CI.
>
> > > > I'm trying to to reproduce the CI breakage by building the kernel and
> > > > running selftests after a reboot.
>
> > > > I suspect I'm missing something, can you see what it is?
>
> > > Oh, I didn't realize initially what it is. This is not kernel-related,
> > > you are right. You just need newer Clang. Can you please use nightly
> > > version or build from sources? Basically, your Clang is too old and it
> > > doesn't generate BTF information for extern functions in BPF code.
>
> > Oh well, I thought that that clang was new enough, the system being
> > Fedora rawhide:
>
> > [acme@seventh ~]$ clang -v |& head -1
> > clang version 12.0.0 (https://github.com/llvm/llvm-project 87369c626114ae17f4c637635c119e6de0856a9a)
>
> > I'm now building the single-repo main...
>
> So I updated clang and now I'm stumbling on another one, again using
> pahole 1.21 + fixes, without any of my changes, is this a known issue?
>
> [root@seventh bpf]# pwd
> /mnt/linux/tools/testing/selftests/bpf
> [root@seventh bpf]# git log --oneline -5
> 94f0b2d4a1d0 (HEAD -> master, torvalds/master) proc: only require mm_struct for writing

Please use bpf-next tree. Bleeding edge clang started generating new
ELF relocation types, so you need bleeding edge libbpfs in selftests
to handle that during static linking.

> a33d62662d27 afs: Fix an IS_ERR() vs NULL check
> 009c9aa5be65 (tag: v5.13-rc6) Linux 5.13-rc6
> e4e453434a19 Merge tag 'perf-tools-fixes-for-v5.13-2021-06-13' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> 960f0716d80f Merge tag 'nfs-for-5.13-3' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
> [root@seventh bpf]#
> [root@seventh bpf]# make run_tests

I never use make run_tests.

Try `make clean && make -j60 && sudo ./test_progs`.

> <SNIP>
>   GEN-SKEL [test_progs] atomic_bounds.skel.h
>   GEN-SKEL [test_progs] atomics.skel.h
>   GEN-SKEL [test_progs] bind4_prog.skel.h
> libbpf: elf: skipping unrecognized data section(6) .rodata.str1.1
>   GEN-SKEL [test_progs] bind6_prog.skel.h
> libbpf: elf: skipping unrecognized data section(6) .rodata.str1.1
>   GEN-SKEL [test_progs] bind_perm.skel.h
>   GEN-SKEL [test_progs] bpf_cubic.skel.h
> libbpf: ELF relo #0 in section #15 has unexpected type 2 in /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.o
> Error: failed to link '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.o': Unknown error -22 (-22)
> make: *** [Makefile:456: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 234
> [root@seventh bpf]# clang -v |& head -2
> clang version 13.0.0 (https://github.com/llvm/llvm-project dee2c76b4c46e71903e3d86ab7555a80d51d1288)
> Target: x86_64-unknown-linux-gnu
> [root@seventh bpf]#
>
> - Arnaldo
>
> > Would you consider a patch for libbpf that would turn this:
> >
> > > > > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > > > > Error: failed to open BPF object file: No such file or directory
> > > > > make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 255
> > > > > make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h'
> > > > > make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
> >
> > Into:
> >
> > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > HINT: Please update your clang/llvm toolchain to at least cset abcdef123456
> > HINT: That is where clang started generating BTF information for extern functions in BPF code.
> >
> > ?
> >
> > :-)

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4223ABE7B
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhFQV6e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhFQV6e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 17:58:34 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CA4C061574;
        Thu, 17 Jun 2021 14:56:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j184so5962929qkd.6;
        Thu, 17 Jun 2021 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pIotqpF97rFU+a3KQY/swaNTPZAaGEl+4hGajF23LSo=;
        b=GlJANo/T9i/0g9F8i/5H+SHY7yc6Lbk47Xz443GPQfZVjBb2yHGd6489VOLr3qokED
         B3yIWhVQaW6hKzbBiGvaU1zAu4cFLZHX8+tHf9DklGR5kItsrAc8jq1ZPV6PYZA0sDZq
         /eZHETGMt6FqT6Cy/K5O761goQZewNAgix6ayrNMsgSjQZ8qibc1xVdGvsEqSoTEjCdd
         h1zZZ65PhDmj02uWZyuDeTKDNmvPApDD5v90UKPpaXXdPnYUiX6FmvfuHkmaCJd3qBJu
         l2/D44sjLKsQqN0ikJrJ94EJRVr8O58nAjlhu2NgEZZaXjXhw78GoBVkKfYuaxaA+OwZ
         VKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pIotqpF97rFU+a3KQY/swaNTPZAaGEl+4hGajF23LSo=;
        b=AwhYTJ6XNj/2Y5CYyVSniaZ/9r4O5wmmQc/XdC1ukn42ETE4yT5gc7sLwtJFQPTuzM
         97M4GXbjowjBiFXE2dT9+4osfOFIL6vayzpDBSJS3WdzL84nnv2+ipjrRsnIWMhkX0oz
         T6K9AZX/+eUfuj5l5YbvJHQY2V2cxHL1OGrlifwcNVeqOtmxENM08JM6pNJkKlvRWIHV
         OglptTYdkG1B5/WeG6Xse9iDC4U+DDC+2XQinwKl4wgfNKHdmYntdf6TwgLAuoWkeWxl
         fO1oRVRLlFYQZYgEJvZBJY0+AZZkkqZ9uBq5IXIGURn3fnzLpQ0qEWOxz6SdumljIqHu
         HpUg==
X-Gm-Message-State: AOAM533n5KMJ63nwDWQIbrJ+fZnRxlshpR1KpL5iocvFFWuOc73X1tk2
        1/kFahhXCcU00Ef9VOGfD9tt4zj9cqZ02EVnfIE=
X-Google-Smtp-Source: ABdhPJw2W+aGr/Iez8CTCsozua2cvQ+nh2eE5RdnHaNH7x9rOndy/YxtA/8KHi2vXTW0pDmMxl5bM9u0/vRYwrAlrmE=
X-Received: by 2002:a25:9942:: with SMTP id n2mr9161421ybo.230.1623966984179;
 Thu, 17 Jun 2021 14:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org> <YMopYxHgmoNVd3Yl@kernel.org>
 <YMph3VeKA1Met65X@kernel.org> <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
 <YMtgz+hcE/7iO7Ux@kernel.org> <YMuoQntxW1zOujHU@kernel.org>
 <CAEf4BzaA2XwjeVNWTa2eyMvzkwp9eUHSXqMVJukMf0_mzh8CnQ@mail.gmail.com> <YMuzbVZoCbiq0CAz@kernel.org>
In-Reply-To: <YMuzbVZoCbiq0CAz@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 14:56:13 -0700
Message-ID: <CAEf4BzZjqFZ4i0Utez2r67CSPCdDhHuOMiuePpKidjtTaogF0g@mail.gmail.com>
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 1:41 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Jun 17, 2021 at 01:03:17PM -0700, Andrii Nakryiko escreveu:
> > On Thu, Jun 17, 2021 at 12:53 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Thu, Jun 17, 2021 at 11:48:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Wed, Jun 16, 2021 at 03:36:54PM -0700, Andrii Nakryiko escreveu:
> > > > > On Wed, Jun 16, 2021 at 1:41 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > > > And if I use pahole's BTF loader I find the info about that function:
> > >
> > > > > > [acme@seventh linux]$ strace -e openat -o /tmp/bla pfunct -F btf tcp_cong_avoid_ai  ; grep vmlinux /tmp/bla
> > > > > > void tcp_cong_avoid_ai(struct tcp_sock * tp, u32 w, u32 acked);
> > > > > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 3
> > >
> > > > > > So this should be unrelated to the breakage you noticed in the CI.
> > >
> > > > > > I'm trying to to reproduce the CI breakage by building the kernel and
> > > > > > running selftests after a reboot.
> > >
> > > > > > I suspect I'm missing something, can you see what it is?
> > >
> > > > > Oh, I didn't realize initially what it is. This is not kernel-related,
> > > > > you are right. You just need newer Clang. Can you please use nightly
> > > > > version or build from sources? Basically, your Clang is too old and it
> > > > > doesn't generate BTF information for extern functions in BPF code.
> > >
> > > > Oh well, I thought that that clang was new enough, the system being
> > > > Fedora rawhide:
> > >
> > > > [acme@seventh ~]$ clang -v |& head -1
> > > > clang version 12.0.0 (https://github.com/llvm/llvm-project 87369c626114ae17f4c637635c119e6de0856a9a)
> > >
> > > > I'm now building the single-repo main...
> > >
> > > So I updated clang and now I'm stumbling on another one, again using
> > > pahole 1.21 + fixes, without any of my changes, is this a known issue?
> > >
> > > [root@seventh bpf]# pwd
> > > /mnt/linux/tools/testing/selftests/bpf
> > > [root@seventh bpf]# git log --oneline -5
> > > 94f0b2d4a1d0 (HEAD -> master, torvalds/master) proc: only require mm_struct for writing
> >
> > Please use bpf-next tree. Bleeding edge clang started generating new
> > ELF relocation types, so you need bleeding edge libbpfs in selftests
> > to handle that during static linking.
>
> Yeah, bleeding edge indeed, will use that then
>
> > > a33d62662d27 afs: Fix an IS_ERR() vs NULL check
> > > 009c9aa5be65 (tag: v5.13-rc6) Linux 5.13-rc6
> > > e4e453434a19 Merge tag 'perf-tools-fixes-for-v5.13-2021-06-13' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
> > > 960f0716d80f Merge tag 'nfs-for-5.13-3' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
> > > [root@seventh bpf]#
> > > [root@seventh bpf]# make run_tests
> >
> > I never use make run_tests.
>
> One more thing to put into my BTF development cheat sheet, thanks.
>
> I looked at git log tools/testing/selftests/bpf and looked for the first
> commit, which I thought would have instructions on how to use it, and
> there I found about 'make run_tests'.
>

There is probably nothing wrong with running make run_tests, it's just
not something that I regularly do. Our CIs also run only test_progs,
test_verifier and test_maps, so that's what is tested all the time.

Speaking of CIs, please see [0]. Please look around and see if you can
subscribe to notifications about failures for that pahole staging
test. That way you'll get notification that something in tmp.master
breaks libbpf CI. Thanks!

  [0] https://github.com/libbpf/libbpf/actions/runs/947856692


> > Try `make clean && make -j60 && sudo ./test_progs`.
> >
> > > <SNIP>
> > >   GEN-SKEL [test_progs] atomic_bounds.skel.h
> > >   GEN-SKEL [test_progs] atomics.skel.h
> > >   GEN-SKEL [test_progs] bind4_prog.skel.h
> > > libbpf: elf: skipping unrecognized data section(6) .rodata.str1.1
> > >   GEN-SKEL [test_progs] bind6_prog.skel.h
> > > libbpf: elf: skipping unrecognized data section(6) .rodata.str1.1
> > >   GEN-SKEL [test_progs] bind_perm.skel.h
> > >   GEN-SKEL [test_progs] bpf_cubic.skel.h
> > > libbpf: ELF relo #0 in section #15 has unexpected type 2 in /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.o
> > > Error: failed to link '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.o': Unknown error -22 (-22)
> > > make: *** [Makefile:456: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 234
> > > [root@seventh bpf]# clang -v |& head -2
> > > clang version 13.0.0 (https://github.com/llvm/llvm-project dee2c76b4c46e71903e3d86ab7555a80d51d1288)
> > > Target: x86_64-unknown-linux-gnu
> > > [root@seventh bpf]#
> > >
> > > - Arnaldo
> > >
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
>
> --
>
> - Arnaldo

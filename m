Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB822F2171
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 22:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbhAKVEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 16:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbhAKVEN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 16:04:13 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04462C061794;
        Mon, 11 Jan 2021 13:03:33 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b64so116034ybg.7;
        Mon, 11 Jan 2021 13:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sr6/zdAN1ePdPU/u9jwgN3xFE95QXTOcFpupXWfT+mc=;
        b=k7e1fhegsMbKukxiKcEfhfFbsgCGor0Zac/03/SXCx5ptcQkBKEMXJTVYsMQzGVo/V
         BH7LG+9mn8tioBxzlsyp3JXlm90ebuQxev6ojf65v490SyDlik1EUwHIwA/gy90kMoNw
         e3Dy2+2ZX0KZLB+liIPlhNDbDO63uvCnJGrs3rKWsG9oG75s67ggKWTBqbm8hIqPkRLa
         w0LyhVv2mCMKAW/4VjLRj7e7tSDjHFlUBQyDcRViRZI5tpwY3TdXv6py00oyybHpNS+D
         21Bs9lx0DxXbyo3Z8NGvRD7I3+rRzHXYfebfh3oPyMS4ze6n5/mKVRnmWOcDaBLxp2jV
         cs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sr6/zdAN1ePdPU/u9jwgN3xFE95QXTOcFpupXWfT+mc=;
        b=Y1noMr5PPNL5QKsvlGACRenxMamnDB6p5Z4+M+w/8haufEiHSMsrnNfA3yptheuh2L
         6u5g5wrAQTQLo73NOiG+7mcWphdf1IvKytulQSOeR96sSKA+mi5PVz/Z+jN6GyS3iwrT
         4HFlnRzl3H8H6kXZkwMa2/dQxgyHTmJX6Ot936lyE+ArpAu+LUVuJeTKG+9QTTb31ncs
         PRAwLYh08udKO/sYVTLVUAYsI7hRSkQz4ZcJstyqIYPhA52IpHpdGbf/YCHMhKzNYHLn
         y37Gz2K5aWmEohnC/jFmO7+j1PhiiRqdtKS7iy8HWWACiebab3Q4btcrvmFN7TfDjSbG
         37Dw==
X-Gm-Message-State: AOAM533EA1ZiP4R8i5J7HdS9JeY7NoRrvgY28EDCuI8dslB2OoafEzgW
        FiDOKAQFcv5k/d56tZKkttEfWRGA9QYJvAoSTrIrB1Cj4N0=
X-Google-Smtp-Source: ABdhPJxF5h5Q6I72PcbYxRlDwsPmwKWhV/fChmjgneTuNgu77ckz8JQzADnDNv9SpAlcjRJau/9T+qjFVD6CKIsZfIs=
X-Received: by 2002:a25:aea8:: with SMTP id b40mr2357439ybj.347.1610399012161;
 Mon, 11 Jan 2021 13:03:32 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com> <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
In-Reply-To: <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jan 2021 13:03:21 -0800
Message-ID: <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     sedat.dilek@gmail.com, Jiri Olsa <jolsa@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 11, 2021 at 9:56 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Jan 11, 2021 at 5:05 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 1/11/21 4:48 AM, Sedat Dilek wrote:
> > > Hi BPF maintainers and Mashiro,
> > >
> > > Debian started to use CONFIG_DEBUG_INFO_BTF=y.
> > >
> > > My kernel-build fails like this:
> > >
> > > + info BTFIDS vmlinux
> > > + [  != silent_ ]
> > > + printf   %-7s %s\n BTFIDS vmlinux
> > >   BTFIDS  vmlinux
> > > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > FAILED: load BTF from vmlinux: Invalid argument
> > >
> > > The root cause is my selfmade LLVM toolchain has no BPF support.
> >
> > linux build should depend on LLVM toolchain unless you use LLVM to build
> > kernel.
> >
> > >
> > > $ which llc
> > > /home/dileks/src/llvm-toolchain/install/bin/llc
> > >
> > > $ llc --version
> > > LLVM (http://llvm.org/ ):
> > >   LLVM version 11.0.1
> > >   Optimized build.
> > >   Default target: x86_64-unknown-linux-gnu
> > >   Host CPU: sandybridge
> > >
> > >   Registered Targets:
> > >     x86    - 32-bit X86: Pentium-Pro and above
> > >     x86-64 - 64-bit X86: EM64T and AMD64
> > >
> > > Debian's llc-11 shows me BPF support is built-in.
> > >
> > > I see the breakag approx. 3 hours after the start of my kernel-build -
> > > in the stage "vmlinux".
> > > After 2 faulures in my build (2x 3 hours of build-time) I have still
> > > no finished Linux v5.11-rc3 kernel.
> > > This is a bit frustrating.
> >
> > You mean "BTFIDS  vmlinux" takes more than 3 hours here?
> > Maybe a bug in resolve_btfids due to somehow different ELF format
> > resolve_btfids need to handle?
> >
>
> [ CC Tom ]
>
> OMG no.
>
> 3 hours up to running scripts/link-vmlinux.sh.
>
> In the meantime I have built a LLVM toolchain with BPF support.
>
> $ llc --version
> LLVM (http://llvm.org/):
>  LLVM version 11.0.1
>  Optimized build.
>  Default target: x86_64-unknown-linux-gnu
>  Host CPU: sandybridge
>
>  Registered Targets:
>    bpf    - BPF (host endian)
>    bpfeb  - BPF (big endian)
>    bpfel  - BPF (little endian)

As Yonghong mentioned, you don't need BPF target support in Clang to
build the kernel, so the issue is elsewhere. It's somewhere between
generated DWARF (we've seen multiple bugs in DWARF over time),
pahole's BTF output and resolve_btfids's handling of that BTF. I've
CC'ed Jiri, who can help with resolve_btfids.

Meanwhile, if you can provide SHA from which you built Clang, kernel
config you used, and probably exact invocation of the build you used,
it would help reproduce the issue.

>    x86    - 32-bit X86: Pentium-Pro and above
>    x86-64 - 64-bit X86: EM64T and AMD64
>
> Tom reported BTF issues with pahole v1.19 (see [2] and [3]):
> "I ran into this same bug trying to build the Fedora kernel. The
> problem is that pahole segfaults at: scripts/link-vmlinux.sh:131. This
> looks to me like a bug in pahole."
>
> pahole ToT (post v1.19) offers some BTF fixes - I have manually build
> and use it.
>
> Building a new Linux-kernel...
>
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
> [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553

There are no significant bug fixes between pahole 1.19 and master that
would solve this problem, so let's try to repro this.

>
>
>
> > >
> > > What about doing pre-checks - means before doing a single line of
> > > compilation - to check for:
> > > 1. Required binaries
> > > 2. Required support of whatever feature in compiler, linker, toolchain etc.
> > >
> > > Recently, I fell over depmod binary not found in my PATH - in one of
> > > the last steps (modfinal) of the kernel build.
> > >
> > > Any ideas to improve the situation?
> > > ( ...and please no RTFM, see links below. )
> > >
> > > Thanks.
> > >
> > > Regards,
> > > - Sedat -
> > >
> > >
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh#n144
> > > [1] https://salsa.debian.org/kernel-team/linux/-/commit/929891281c61ce4403ddd869664c949692644a2f
> > > [2] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html?highlight=pahole#llvm
> > > [3] https://www.kernel.org/doc/html/latest/bpf/btf.html?highlight=pahole#btf-generation
> > >

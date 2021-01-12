Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD02F26EB
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 05:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbhALEKK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 23:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbhALEKK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 23:10:10 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D0C061786;
        Mon, 11 Jan 2021 20:09:29 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p187so1308833iod.4;
        Mon, 11 Jan 2021 20:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=21DSZhIADyM80UXtZ6t3GJQcw6jBTaBnuujNVrs2BiY=;
        b=LAD2/Alh9gICYvjjs3FCFJEUfRBT65BauB0F3mecxbXjaRZ0teKJZfXz6O7hfhTU6Q
         5YXUTOOGuQ72nCjWE/6PLeUZagUWaYGwUogavL0cKaVDftRIUB9zbw/SGVsLMLPcVm2f
         XAx9k99vuEfL/mu1woYRwSXF7oDG9eXdH0SI8DYmDuK4kMjf61gQxPgUlp1U9nQ+Ec9B
         iP0cgu+SNOuSAkGVr7AuqhPYNfPSR2kZVeCmnNnH+4t9RSAs4J57jUsaeLBX3WZSRggp
         W2v9V1vDUZVk3I19UkmsTCrzmRhR7ltA9U1wKWO+I9v+uEV7frPZ5l9k7V5ur55l63AZ
         Vdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=21DSZhIADyM80UXtZ6t3GJQcw6jBTaBnuujNVrs2BiY=;
        b=d/vM42duO+EgeXjTc1yjDu1pgH5fv+gkbriNBPeOhVcZA/+fxyXImZ8VTlsOg5OZ7x
         lzEQ29h7kBbI/zPGJln82pzoG9cC8gw3Og6ausLQNjs6cT6jbYYx+736kHnrh5xlWlwm
         +wzyBP+eTEuVVo9TdlT6us9Orwp4uJCiZH3bYtS+itd7qNnMpR4gvahX/7IPEMdNMVF6
         cLKKKM8BV2xhiCb8RQzyB3wo2neg/UpSqKg5c/bSjUrTrGFsiARnwyL6v+y6YWs2JhfG
         gsxjd+mPI0JV5V+zyY1fxj1/x0RireLTUcQR9WIbFa9nDu6U3jufcyCq7iJapk8nU61/
         eXtw==
X-Gm-Message-State: AOAM532kxsttRuqMbg8+nJDnQkPTmjl/qGBDwv5v+UiOsdXL70rZGy3A
        HkYc8HkKSzjKqYm7n6K0vcgwmZU/CUO6TG37NYZvsRKxIn+hCg==
X-Google-Smtp-Source: ABdhPJzKhhErzBBN2Z80DOboIFZ3ILIpKklBM7XUz4FkQ3HlJBoqbCkH+LZMVF0CmGj3btK9b4RP28vvffLM4AJeT1k=
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr1842525iok.171.1610424569019;
 Mon, 11 Jan 2021 20:09:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com> <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
 <CAEf4BzaEA5aWeCCvHp7ASo9TdfotcBtqNGexirEynHDSo7ufgg@mail.gmail.com>
 <CA+icZUVrF_LCVhELbNLA7=FzEZK4=jk3QLD9XT2w5bQNo=nnOA@mail.gmail.com> <cb37bffa-b2c7-4395-40eb-2d39f5570214@fb.com>
In-Reply-To: <cb37bffa-b2c7-4395-40eb-2d39f5570214@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 12 Jan 2021 05:09:17 +0100
Message-ID: <CA+icZUV5dP8Fjj2NhTKJnnumKZd2-gYHwSo3samscHz7LZCx4w@mail.gmail.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Tue, Jan 12, 2021 at 1:57 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/11/21 1:30 PM, Sedat Dilek wrote:
> > On Mon, Jan 11, 2021 at 10:03 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, Jan 11, 2021 at 9:56 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>>
> >>> On Mon, Jan 11, 2021 at 5:05 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 1/11/21 4:48 AM, Sedat Dilek wrote:
> >>>>> Hi BPF maintainers and Mashiro,
> >>>>>
> >>>>> Debian started to use CONFIG_DEBUG_INFO_BTF=y.
> >>>>>
> >>>>> My kernel-build fails like this:
> >>>>>
> >>>>> + info BTFIDS vmlinux
> >>>>> + [  != silent_ ]
> >>>>> + printf   %-7s %s\n BTFIDS vmlinux
> >>>>>    BTFIDS  vmlinux
> >>>>> + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> >>>>> FAILED: load BTF from vmlinux: Invalid argument
> >>>>>
> >>>>> The root cause is my selfmade LLVM toolchain has no BPF support.
> >>>>
> >>>> linux build should depend on LLVM toolchain unless you use LLVM to build
> >>>> kernel.
> >>>>
> >>>>>
> >>>>> $ which llc
> >>>>> /home/dileks/src/llvm-toolchain/install/bin/llc
> >>>>>
> >>>>> $ llc --version
> >>>>> LLVM (http://llvm.org/  ):
> >>>>>    LLVM version 11.0.1
> >>>>>    Optimized build.
> >>>>>    Default target: x86_64-unknown-linux-gnu
> >>>>>    Host CPU: sandybridge
> >>>>>
> >>>>>    Registered Targets:
> >>>>>      x86    - 32-bit X86: Pentium-Pro and above
> >>>>>      x86-64 - 64-bit X86: EM64T and AMD64
> >>>>>
> >>>>> Debian's llc-11 shows me BPF support is built-in.
> >>>>>
> >>>>> I see the breakag approx. 3 hours after the start of my kernel-build -
> >>>>> in the stage "vmlinux".
> >>>>> After 2 faulures in my build (2x 3 hours of build-time) I have still
> >>>>> no finished Linux v5.11-rc3 kernel.
> >>>>> This is a bit frustrating.
> >>>>
> >>>> You mean "BTFIDS  vmlinux" takes more than 3 hours here?
> >>>> Maybe a bug in resolve_btfids due to somehow different ELF format
> >>>> resolve_btfids need to handle?
> >>>>
> >>>
> >>> [ CC Tom ]
> >>>
> >>> OMG no.
> >>>
> >>> 3 hours up to running scripts/link-vmlinux.sh.
> >>>
> >>> In the meantime I have built a LLVM toolchain with BPF support.
> >>>
> >>> $ llc --version
> >>> LLVM (http://llvm.org/ ):
> >>>   LLVM version 11.0.1
> >>>   Optimized build.
> >>>   Default target: x86_64-unknown-linux-gnu
> >>>   Host CPU: sandybridge
> >>>
> >>>   Registered Targets:
> >>>     bpf    - BPF (host endian)
> >>>     bpfeb  - BPF (big endian)
> >>>     bpfel  - BPF (little endian)
> >>
> >> As Yonghong mentioned, you don't need BPF target support in Clang to
> >> build the kernel, so the issue is elsewhere. It's somewhere between
> >> generated DWARF (we've seen multiple bugs in DWARF over time),
> >> pahole's BTF output and resolve_btfids's handling of that BTF. I've
> >> CC'ed Jiri, who can help with resolve_btfids.
> >>
> >> Meanwhile, if you can provide SHA from which you built Clang, kernel
> >> config you used, and probably exact invocation of the build you used,
> >> it would help reproduce the issue.
> >>
> >
> > OK, I see I have here DWARF v5 support patchset applied and enabled.
> >
> > Furthermore: I applied latest clang-cfi.
> >
> > This is with LLVM v11.0.1 final aka 43ff75f2c3feef64f9d73328230d34dac8832a91.
>
> Did you use llvm to compile kernel? If this is the case, latest pahole
> will segfault. I am using latest trunk llvm. It is possible that
> generated dwarf with llvm is different from generated dwarf with gcc
> and pahole did not process it correctly. I did not get time to
> debug this though.
>

Yes, I used LLVM/Clang to compile the kernel.

- Sedat -

> >
> > My kernel-config is attached.
> >
> > [1] https://patchwork.kernel.org/project/linux-kbuild/patch/20201204011129.2493105-1-ndesaulniers@google.com/
> > [2] https://patchwork.kernel.org/project/linux-kbuild/patch/20201204011129.2493105-2-ndesaulniers@google.com/
> > [3] https://github.com/samitolvanen/linux/commits/clang-cfi
> >
> >>>     x86    - 32-bit X86: Pentium-43ff75f2c3feef64f9d73328230d34dac8832a91
> > Pro and above
> >>>     x86-64 - 64-bit X86: EM64T and AMD64
> >>>
> >>> Tom reported BTF issues with pahole v1.19 (see [2] and [3]):
> >>> "I ran into this same bug trying to build the Fedora kBROKEN_5-11-rc3-CONFIG_DEBUG_INFO_BTF-y-FAILED-load-BTF-from-vmlinux.txt
> > ernel. The
> >>> problem is that pahole segfaults at: scripts/link-vmlinux.sh:131. This
> >>> looks to me like a bug in pahole."
> >>>
> >>> pahole ToT (post v1.19) offers some BTF fixes - I have manually build
> >>> and use it.
> >>>
> >>> Building a new Linux-kernel...
> >>>
> >>> - Sedat -
> >>>
> >>> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> >>> [2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
> >>> [3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553
> >>
> >> There are no significant bug fixes between pahole 1.19 and master that
> >> would solve this problem, so let's try to repro this.
> >>
> >
> > You are right pahole fom latest Git does not solve the issue.
> >
> > + info BTFIDS vmlinux
> > + [  != silent_ ]
> > + printf   %-7s %s\n BTFIDS vmlinux
> >   BTFIDS  vmlinux
> > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > FAILED: load BTF from vmlinux: Invalid argument
> >
> > - Sedat -
> >
> >>>
> >>>
> >>>
> >>>>>
> >>>>> What about doing pre-checks - means before doing a single line of
> >>>>> compilation - to check for:
> >>>>> 1. Required binaries
> >>>>> 2. Required support of whatever feature in compiler, linker, toolchain etc.
> >>>>>
> >>>>> Recently, I fell over depmod binary not found in my PATH - in one of
> >>>>> the last steps (modfinal) of the kernel build.
> >>>>>
> >>>>> Any ideas to improve the situation?
> >>>>> ( ...and please no RTFM, see links below. )
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>> Regards,
> >>>>> - Sedat -
> >>>>>
> >>>>>
> >>>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh#n144
> >>>>> [1] https://salsa.debian.org/kernel-team/linux/-/commit/929891281c61ce4403ddd869664c949692644a2f
> >>>>> [2] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html?highlight=pahole#llvm
> >>>>> [3] https://www.kernel.org/doc/html/latest/bpf/btf.html?highlight=pahole#btf-generation
> >>>>>

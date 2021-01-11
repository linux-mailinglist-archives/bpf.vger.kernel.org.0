Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9944A2F1D31
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 18:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbhAKR5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 12:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbhAKR5P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 12:57:15 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28868C061794;
        Mon, 11 Jan 2021 09:56:35 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x15so452208ilq.1;
        Mon, 11 Jan 2021 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cEH5d4sSAKnEhpBNXXBVw3jPQh/cz1wtGrgSWX+H6mU=;
        b=WjNx3F3zs5pFJD1qGm4zfO38ChpEbRUW7XaxQwcOl6jlLsJGNBCS3q5Os7aAIFlSsl
         6TlnUiwX6jPufm9acYbo+wQ09tKyacufSdpsUMJHFdT5szDnJvnGEElRFXHCUrBxjy8p
         eoL1TK8DsTuTFsSODDt7XeM/+hpTgeozfwFcro1N4pXipB2gzaxStX5+Mfd9Rh1qmbj9
         6WM+8pBsEziJOv8Os/XL6OgyWvJ6NEy5Y/tqbYYI5+Y3/JPM/9BCW1vkXT4s086MbsBN
         2JDZf+TWdleqgalAOkAdjKOpISH2nMWe99mZXxigxSfRFfzOaO3u/5To/ZThesX+dScp
         Ip+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cEH5d4sSAKnEhpBNXXBVw3jPQh/cz1wtGrgSWX+H6mU=;
        b=e9UvjOsOAk7+G0Mwx4RG//MWe+PdPVZt2Qx2rmU4ExVuiJM9broIa+mkTp7c0ic9ER
         mCeWgXwwn6v9BLc45uZCX7EYRTvUQU+2jhAY9jZnRr+1bqpFSW3ezfhzxh34O3Ia1nhy
         ZZwjWCpJf75zoocWQDeVgpDY5F9sjICwh8B6fL+cA+pyGzsS9NSRhp/63PTw2pE3O3E4
         gGMQVqfc8Uu3oUZGXqlShmKLHg9IHoMGYHJrw8WyKCGD2t1O2mnCdEsy7ByV0Scy77P8
         ZLraZ92g64n6PTQMRbJo+sGDZHp1kmCDwBE5Pph62JFDvR5hcJxxjE2qiSGLK4smYzYG
         E/bA==
X-Gm-Message-State: AOAM5334p8MRYbSazNSW9XiTbjImm/BMegNQqKPZehWTbxavTL4pkxhe
        b8lmT/r9MYznn0TuJKXf2mwDpnE0Pe6IWGacM8E=
X-Google-Smtp-Source: ABdhPJydoKJpXHnkEVK9HPmA7WHJ8Nf3o/Zv07gD6MtJLoxi7dkMsRI5eWScePYSO39ig9hrMU/ZABTVuWYbdZ/SCfk=
X-Received: by 2002:a92:9e57:: with SMTP id q84mr334072ili.112.1610387794410;
 Mon, 11 Jan 2021 09:56:34 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVuk5PVY4_HoCoY2ymd27UjuDi6kcAmFb_3=dqkvOA_Qw@mail.gmail.com>
 <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
In-Reply-To: <fa019010-9d7c-206c-d2c6-0893381f5913@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 11 Jan 2021 18:56:22 +0100
Message-ID: <CA+icZUVm6ZZveqVoS83SVXe1nqkqZVRjLO+SK1_nXHKkgh4yPQ@mail.gmail.com>
Subject: Re: Check pahole availibity and BPF support of toolchain before
 starting a Linux kernel build
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 11, 2021 at 5:05 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/11/21 4:48 AM, Sedat Dilek wrote:
> > Hi BPF maintainers and Mashiro,
> >
> > Debian started to use CONFIG_DEBUG_INFO_BTF=y.
> >
> > My kernel-build fails like this:
> >
> > + info BTFIDS vmlinux
> > + [  != silent_ ]
> > + printf   %-7s %s\n BTFIDS vmlinux
> >   BTFIDS  vmlinux
> > + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > FAILED: load BTF from vmlinux: Invalid argument
> >
> > The root cause is my selfmade LLVM toolchain has no BPF support.
>
> linux build should depend on LLVM toolchain unless you use LLVM to build
> kernel.
>
> >
> > $ which llc
> > /home/dileks/src/llvm-toolchain/install/bin/llc
> >
> > $ llc --version
> > LLVM (http://llvm.org/ ):
> >   LLVM version 11.0.1
> >   Optimized build.
> >   Default target: x86_64-unknown-linux-gnu
> >   Host CPU: sandybridge
> >
> >   Registered Targets:
> >     x86    - 32-bit X86: Pentium-Pro and above
> >     x86-64 - 64-bit X86: EM64T and AMD64
> >
> > Debian's llc-11 shows me BPF support is built-in.
> >
> > I see the breakag approx. 3 hours after the start of my kernel-build -
> > in the stage "vmlinux".
> > After 2 faulures in my build (2x 3 hours of build-time) I have still
> > no finished Linux v5.11-rc3 kernel.
> > This is a bit frustrating.
>
> You mean "BTFIDS  vmlinux" takes more than 3 hours here?
> Maybe a bug in resolve_btfids due to somehow different ELF format
> resolve_btfids need to handle?
>

[ CC Tom ]

OMG no.

3 hours up to running scripts/link-vmlinux.sh.

In the meantime I have built a LLVM toolchain with BPF support.

$ llc --version
LLVM (http://llvm.org/):
 LLVM version 11.0.1
 Optimized build.
 Default target: x86_64-unknown-linux-gnu
 Host CPU: sandybridge

 Registered Targets:
   bpf    - BPF (host endian)
   bpfeb  - BPF (big endian)
   bpfel  - BPF (little endian)
   x86    - 32-bit X86: Pentium-Pro and above
   x86-64 - 64-bit X86: EM64T and AMD64

Tom reported BTF issues with pahole v1.19 (see [2] and [3]):
"I ran into this same bug trying to build the Fedora kernel. The
problem is that pahole segfaults at: scripts/link-vmlinux.sh:131. This
looks to me like a bug in pahole."

pahole ToT (post v1.19) offers some BTF fixes - I have manually build
and use it.

Building a new Linux-kernel...

- Sedat -

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
[2] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758026878
[3] https://github.com/ClangBuiltLinux/tc-build/issues/129#issuecomment-758056553



> >
> > What about doing pre-checks - means before doing a single line of
> > compilation - to check for:
> > 1. Required binaries
> > 2. Required support of whatever feature in compiler, linker, toolchain etc.
> >
> > Recently, I fell over depmod binary not found in my PATH - in one of
> > the last steps (modfinal) of the kernel build.
> >
> > Any ideas to improve the situation?
> > ( ...and please no RTFM, see links below. )
> >
> > Thanks.
> >
> > Regards,
> > - Sedat -
> >
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh#n144
> > [1] https://salsa.debian.org/kernel-team/linux/-/commit/929891281c61ce4403ddd869664c949692644a2f
> > [2] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html?highlight=pahole#llvm
> > [3] https://www.kernel.org/doc/html/latest/bpf/btf.html?highlight=pahole#btf-generation
> >

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B58571143
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 06:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiGLEZB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 00:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLEZA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 00:25:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA61209D
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:24:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k30so8571250edk.8
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 21:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTZ29Djs1K2rGMWRHC1oF7IO9W8CKaXRW058M7JBt7A=;
        b=UsomvnAHBEKnIvC1a4bY1rCxxrnTXu+WYCa4nO36NHvPSvff5fdM+Gtamf6EBGGT5L
         5pq78DyJ4Gu1BbPfz+en2H07X4XSNOhRB7THKCufRhrysHnoC/vNFq3BvhPtDhFKryFc
         guWYhB36IUID46Sb3b+aVcgsbq31yBPkHUha89LsjYB7CWtUXRnyKZU9dIAUlCHhvC7f
         kPeLA5h/VtQdvry7+78oggjZSNETR/Wl5+Uo0t7q8gj+S7859GzOhGekhFKWOcYynB17
         3ISvwPAVJMFgrfj30ugjCfLtjuQ4n8kqDs9LMRv/KuG3wTo1+YvoQBTNe8RErWFDUGry
         jMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTZ29Djs1K2rGMWRHC1oF7IO9W8CKaXRW058M7JBt7A=;
        b=nbUfjjuFO+9wyWuLBqo0yXtrc15z/OlT4di6JK5J2aZtON7TVoq/Lp/9g6Ho5E3RD0
         +3GkfgTN7ffaMoot2KVvPVgJYARRX8ZY4ZQw4fMGMmwIi/8iS1T2IMWNCYw2alcyRyvj
         GbtHC0MJ+H1/EXU6kLTPj3VSfhPjAt1MFYk8F81kk25k0VtSQl56eqIGXhVBfMAhHPWm
         5C+10uJ4HdmtYM0Def8exfxbwNUsBJXTCXiFZ/+H16L72XEz8PtMP921feHerEjeRu9n
         Z62XDXQMaQPfGsPbi40vdpGXite4XL5tvH6CX5g3mvDBKwvpdLGRKNoDXAM5VdEzwAlV
         PiDw==
X-Gm-Message-State: AJIora/wnG66ej/OKWsZxb/bouvKX6AAovjjB3woZ8eNXQFjcCNea83y
        GcqB4lbeaoyWTleSnyJYqivKl1hbFVDNYoC9Tw0RYSUMY+g=
X-Google-Smtp-Source: AGRyM1s9WgKOeVTytVoA+Z1ynw4NRhveYCPWtEDEaWLlLEq5ORCLEPcogjYxsi2qxNyo3ls9bn2cv7eXILWBNv1jCAc=
X-Received: by 2002:a05:6402:c92:b0:43a:7177:5be7 with SMTP id
 cm18-20020a0564020c9200b0043a71775be7mr29321486edb.224.1657599897774; Mon, 11
 Jul 2022 21:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <50414987fbd393cde6d28ac9877e9f9b1527cb28.camel@linux.ibm.com>
 <CAEf4BzaocVmZrdSg4d5xiTeqK+n5ZNUuMso6BW-2x15Wj3rGmQ@mail.gmail.com> <cc50280e54d463d5da703e85770c87ede3f2655d.camel@linux.ibm.com>
In-Reply-To: <cc50280e54d463d5da703e85770c87ede3f2655d.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Jul 2022 21:24:46 -0700
Message-ID: <CAEf4Bzb=oT5PzYjM+aDeAg76yB8KpROWcdanqLZ+G6qtdFsAqA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/3] libbpf: add better syscall kprobing support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 11:25 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Thu, 2022-07-07 at 13:59 -0700, Andrii Nakryiko wrote:
> > On Thu, Jul 7, 2022 at 8:51 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > On Wed, 2022-07-06 at 17:41 -0700, Andrii Nakryiko wrote:
> > > > This RFC patch set is to gather feedback about new
> > > > SEC("ksyscall") and SEC("kretsyscall") section definitions meant
> > > > to
> > > > simplify
> > > > life of BPF users that want to trace Linux syscalls without
> > > > having to
> > > > know or
> > > > care about things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER and
> > > > related
> > > > arch-specific
> > > > vs arch-agnostic __<arch>_sys_xxx vs __se_sys_xxx function names,
> > > > calling
> > > > convention woes ("nested" pt_regs), etc. All this is quite
> > > > annoying
> > > > to
> > > > remember and care about as BPF user, especially if the goal is to
> > > > write
> > > > achitecture- and kernel version-agnostic BPF code (e.g., things
> > > > like
> > > > libbpf-tools, etc).
> > > >
> > > > By using SEC("ksyscall/xxx")/SEC("kretsyscall/xxx") user clearly
> > > > communicates
> > > > the desire to kprobe/kretprobe kernel function that corresponds
> > > > to
> > > > the
> > > > specified syscall. Libbpf will take care of all the details of
> > > > determining
> > > > correct function name and calling conventions.
> > > >
> > > > This patch set also improves BPF_KPROBE_SYSCALL (and renames it
> > > > to
> > > > BPF_KSYSCALL to match SEC("ksyscall")) macro to take into account
> > > > CONFIG_ARCH_HAS_SYSCALL_WRAPPER instead of hard-coding whether
> > > > host
> > > > architecture is expected to use syscall wrapper or not (which is
> > > > less
> > > > reliable
> > > > and can change over time).
> > > >
> > > > It would be great to get feedback about the overall feature, but
> > > > also
> > > > I'd
> > > > appreciate help with testing this, especially for non-x86_64
> > > > architectures.
> > > >
> > > > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > Cc: Kenta Tada <kenta.tada@sony.com>
> > > > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > > >
> > > > Andrii Nakryiko (3):
> > > >   libbpf: improve and rename BPF_KPROBE_SYSCALL
> > > >   libbpf: add ksyscall/kretsyscall sections support for syscall
> > > > kprobes
> > > >   selftests/bpf: use BPF_KSYSCALL and SEC("ksyscall") in
> > > > selftests
> > > >
> > > >  tools/lib/bpf/bpf_tracing.h                   |  44 +++++--
> > > >  tools/lib/bpf/libbpf.c                        | 109
> > > > ++++++++++++++++++
> > > >  tools/lib/bpf/libbpf.h                        |  16 +++
> > > >  tools/lib/bpf/libbpf.map                      |   1 +
> > > >  tools/lib/bpf/libbpf_internal.h               |   2 +
> > > >  .../selftests/bpf/progs/bpf_syscall_macro.c   |   6 +-
> > > >  .../selftests/bpf/progs/test_attach_probe.c   |   6 +-
> > > >  .../selftests/bpf/progs/test_probe_user.c     |  27 +----
> > > >  8 files changed, 172 insertions(+), 39 deletions(-)
> > >
> > > Hi Andrii,
> > >
> > > Looks interesting, I will give it a try on s390x a bit later.
> > >
> > > In the meantime just one remark: if we want to create a truly
> > > seamless
> > > solution, we might need to take care of quirks associated with the
> > > following kernel #defines:
> > >
> > > * __ARCH_WANT_SYS_OLD_MMAP (real arguments are in memory)
> > > * CONFIG_CLONE_BACKWARDS (child_tidptr/tls swapped)
> > > * CONFIG_CLONE_BACKWARDS2 (newsp/clone_flags swapped)
> > > * CONFIG_CLONE_BACKWARDS3 (extra arg: stack_size)
> > >
> > > or at least document that users need to be careful with mmap() and
> > > clone() probes. Also, there might be more of that out there, but
> > > that's
> > > what I'm constantly running into on s390x.
> > >
> >
> > Tbh, this space seems so messy, that I don't think it's realistic to
> > try to have a completely seamless solution. As I replied to Alexei, I
> > didn't have an intention to support compat and 32-bit syscalls, for
> > example. This seems to be also a quirk that users will have to
> > discover and handle on their own. In my mind there is always plain
> > SEC("kprobe") if SEC("ksyscall") gets in a way to handle
> > compat/32-bit/quirks like the ones you mentioned.
> >
> > But maybe the right answer is just to not add SEC("ksyscall") at all?
>
> I think it's a valuable feature, even if it doesn't handle compat
> syscalls and all the other calling convention quirks. IMHO these things
> just need to be clearly spelled in the documentation.
>
> In order to keep the possibility to handle them in the future, I would
> write something like:
>
>     At the moment SEC("ksyscall") does not handle all the calling
>     convention quirks for mmap(), clone() and compat syscalls. This may
>     or may not change in the future. Therefore it is recommended to use
>     SEC("kprobe") for these syscalls.
>
> What do you think?

Sounds good! I'll add that to bpf_program__attach_ksyscall() doc
comment (and to commit message). I'll implement those new virtual
__kconfig variables that I mentioned in another thread and post it as
v1, hopefully some time this week.

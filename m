Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EC456ACF1
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiGGUuv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 16:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiGGUuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 16:50:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7616F2CDC7
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 13:50:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d2so34521414ejy.1
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uykjR29GkbnHjyRVVbVUjIpKgBv3751vHkOU1K+cSHs=;
        b=HxUlzjBAeLb5Mu5RiYfYiFeZo6eylqFW+ObVVwmR4eg3Ty/GVJMoqT+lk5R9N/DUH9
         wzfqkJoXKFWoeQaqWSi6FDEDPerWym/TnObcuHi24iWP+Jp+YCF2V4gqTmFPsJhsFzFO
         i2I8MHqL55UDaBFh2Dtl6/gRK0EdP+10yyPV8bkaLv8n1d0VlWq3joEBnK7VTtocY8T4
         x9xPtn8hm8OjntMiPEsnpkckmrTIzo6adZx1ELwAl2ydplTZ/LE/v4hnVKMJ8OtZoTwT
         ymXMh7IBU5lUPf07W5ywReisd8FQ7u4g8stanPN+voiKa0Ej3BeAFjuEwQqVp9/w9Fjq
         i2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uykjR29GkbnHjyRVVbVUjIpKgBv3751vHkOU1K+cSHs=;
        b=dLJrgbHxwimDt2PyLL5p/FazppzPs5KjQuEjfSlaUNFDGNdQAgv1ssrDTK1GzvV86F
         UBLLKfwQbn9pxIV3o/6n13ah1HKynffK13ZrbuOSKsMn0EN6dBtfF+WNF1WG94pbMYG4
         E+IDn56TSmoI1eStFp6sH0mcmCm2b0qLRgnnByc8+iOOcp3utmAWSTX2P6hWFTgltw/Q
         fLZWcjtcr8Wz7meEkf7hTXN7g8tuCbwofUQFBTcdOHo+AYv/X/0s0woqVz0Rs6Ig72Cp
         PyHf7oyVE8grc8QtNYs2lUDslmZ5P9Jn4lNp/pvZxbzYhj1yMKPL8g4Ud+nG6+HpQbSA
         ClgA==
X-Gm-Message-State: AJIora/B+K8LDtoVsWeexQRH9PG0HphIdTkY1czIqHWcguDUM0CuGwAU
        kIhUWiFM95zqDrfaaDjkexOT4mYCmYKWr+EELu8=
X-Google-Smtp-Source: AGRyM1vuKIBH5T3tDAdqa2b4pJkJAjBuAgxRNyDMtZ/sqcZ2brX0bz6esL5PHMKIHyQvp5BKVMlHlsiZFqG02vi8zdo=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr7612044ejc.745.1657227047958; Thu, 07
 Jul 2022 13:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220707004118.298323-1-andrii@kernel.org> <20220707004118.298323-3-andrii@kernel.org>
 <CAADnVQLxWDD3AAp73BcXW4ArWMgJ-fSUzSjw=-gzq=azBrXdqA@mail.gmail.com>
 <CAEf4BzaXBD86k8BYv7q4fFeyHALHcVUCbSpSG4=kfC0orydrCQ@mail.gmail.com> <CAADnVQKm5otAmeoseC9=x7Co91CgY1oYpHFR1R+pRSB+X_mYFQ@mail.gmail.com>
In-Reply-To: <CAADnVQKm5otAmeoseC9=x7Co91CgY1oYpHFR1R+pRSB+X_mYFQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 7 Jul 2022 13:50:36 -0700
Message-ID: <CAEf4BzbB67xTKzW2ajZMU6yC64m98xk3tLJZs35vTrjTWVdoeQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall
 sections support for syscall kprobes
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
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

On Thu, Jul 7, 2022 at 12:36 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 12:10 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jul 7, 2022 at 10:23 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jul 6, 2022 at 5:41 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > >
> > > > Add SEC("ksyscall")/SEC("ksyscall/<syscall_name>") and corresponding
> > > > kretsyscall variants (for return kprobes) to allow users to kprobe
> > > > syscall functions in kernel. These special sections allow to ignore
> > > > complexities and differences between kernel versions and host
> > > > architectures when it comes to syscall wrapper and corresponding
> > > > __<arch>_sys_<syscall> vs __se_sys_<syscall> differences, depending on
> > > > CONFIG_ARCH_HAS_SYSCALL_WRAPPER.
> > > >
> > > > Combined with the use of BPF_KSYSCALL() macro, this allows to just
> > > > specify intended syscall name and expected input arguments and leave
> > > > dealing with all the variations to libbpf.
> > > >
> > > > In addition to SEC("ksyscall+") and SEC("kretsyscall+") add
> > > > bpf_program__attach_ksyscall() API which allows to specify syscall name
> > > > at runtime and provide associated BPF cookie value.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c          | 109 ++++++++++++++++++++++++++++++++
> > > >  tools/lib/bpf/libbpf.h          |  16 +++++
> > > >  tools/lib/bpf/libbpf.map        |   1 +
> > > >  tools/lib/bpf/libbpf_internal.h |   2 +
> > > >  4 files changed, 128 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index cb49408eb298..4749fb84e33d 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -4654,6 +4654,65 @@ static int probe_kern_btf_enum64(void)
> > > >                                              strs, sizeof(strs)));
> > > >  }
> > > >
> > > > +static const char *arch_specific_syscall_pfx(void)
> > > > +{
> > > > +#if defined(__x86_64__)
> > > > +       return "x64";
> > > > +#elif defined(__i386__)
> > > > +       return "ia32";
> > > > +#elif defined(__s390x__)
> > > > +       return "s390x";
> > > > +#elif defined(__s390__)
> > > > +       return "s390";
> > > > +#elif defined(__arm__)
> > > > +       return "arm";
> > > > +#elif defined(__aarch64__)
> > > > +       return "arm64";
> > > > +#elif defined(__mips__)
> > > > +       return "mips";
> > > > +#elif defined(__riscv)
> > > > +       return "riscv";
> > > > +#else
> > > > +       return NULL;
> > > > +#endif
> > > > +}
> > > > +
> > > > +static int probe_kern_syscall_wrapper(void)
> > > > +{
> > > > +       /* available_filter_functions is a few times smaller than
> > > > +        * /proc/kallsyms and has simpler format, so we use it as a faster way
> > > > +        * to check that __<arch>_sys_bpf symbol exists, which is a sign that
> > > > +        * kernel was built with CONFIG_ARCH_HAS_SYSCALL_WRAPPER and uses
> > > > +        * syscall wrappers
> > > > +        */
> > > > +       static const char *kprobes_file = "/sys/kernel/tracing/available_filter_functions";
> > > > +       char func_name[128], syscall_name[128];
> > > > +       const char *ksys_pfx;
> > > > +       FILE *f;
> > > > +       int cnt;
> > > > +
> > > > +       ksys_pfx = arch_specific_syscall_pfx();
> > > > +       if (!ksys_pfx)
> > > > +               return 0;
> > > > +
> > > > +       f = fopen(kprobes_file, "r");
> > > > +       if (!f)
> > > > +               return 0;
> > > > +
> > > > +       snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
> > > > +
> > > > +       /* check if bpf() syscall wrapper is listed as possible kprobe */
> > > > +       while ((cnt = fscanf(f, "%127s%*[^\n]\n", func_name)) == 1) {
> > > > +               if (strcmp(func_name, syscall_name) == 0) {
> > > > +                       fclose(f);
> > > > +                       return 1;
> > > > +               }
> > > > +       }
> > >
> > > Maybe we should do the other way around ?
> > > cat /proc/kallsyms |grep sys_bpf
> > >
> > > and figure out the prefix from there?
> > > Then we won't need to do giant
> > > #if defined(__x86_64__)
> > > ...
> > >
> >
> > Unfortunately this won't work well due to compat and 32-bit APIs (and
> > bpf() syscall is particularly bad with also bpf_sys_bpf):
> >
> > $ sudo cat /proc/kallsyms| rg '_sys_bpf$'
> > ffffffff811cb100 t __sys_bpf
> > ffffffff811cd380 T bpf_sys_bpf
> > ffffffff811cd520 T __x64_sys_bpf
> > ffffffff811cd540 T __ia32_sys_bpf
> > ffffffff8256fce0 r __ksymtab_bpf_sys_bpf
> > ffffffff8259b5a2 r __kstrtabns_bpf_sys_bpf
> > ffffffff8259bab9 r __kstrtab_bpf_sys_bpf
> > ffffffff83abc400 t _eil_addr___ia32_sys_bpf
> > ffffffff83abc410 t _eil_addr___x64_sys_bpf
>
> That actually means that the current and proposed approaches
> are both somewhat wrong, since they don't attach to both.
> Meaning all syscalls done by 32-bit userspace will not be seen
> by bpf prog.
>
> Probably libbpf should attach to both:
> __x64_sys_bpf and __ia32_sys_bpf.
>

I actually was intending to attach to "native" syscall, I haven't seen
any application/use case attaching to ia32 variants on 64-bit
architectures. Same for compat, if the kernel has it.

My thinking was that compat and 32-bit syscalls are not a typical use
case, and if user cares about them, they should be capable of figuring
out __x64_sys_xxx and __ia32_sys_xxx and __compact_whatever the name
as well.

But that's why I sent it as an RFC, to discuss stuff like this.


> __ksym and __kstr are easy to filter out, since they are
> standard prefixes.
> No idea what eil_addr is.
>
> > $ sudo cat /proc/kallsyms| rg '_sys_mmap$'
> > ffffffff81024480 T __x64_sys_mmap
> > ffffffff810244c0 T __ia32_sys_mmap
> > ffffffff83abae30 t _eil_addr___ia32_sys_mmap
> > ffffffff83abae40 t _eil_addr___x64_sys_mmap
> >
> > We have similar arch-specific switches in few other places (USDT and
> > lib path detection, for example), so it's not a new precedent (for
> > better or worse).
> >
> >
> > > /proc/kallsyms has world read permissions:
> > > proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> > > unlike available_filter_functions.
> > >
> > > Also tracefs might be mounted in a different dir than
> > > /sys/kernel/tracing/
> > > like
> > > /sys/kernel/debug/tracing/
> >
> > Yeah, good point, was trying to avoid parsing more expensive kallsyms,
> > but given it's done once, it might not be a big deal.
>
> Soon we'll have an iterator for them so doing in-kernel
> search of sys_bpf would be fast.

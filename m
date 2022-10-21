Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259F56080F0
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJUVtf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJUVtd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:49:33 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1ADD11C;
        Fri, 21 Oct 2022 14:49:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m16so10598836edc.4;
        Fri, 21 Oct 2022 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6lz31d9qvODy/+YzXxTbbN3fpreRhI0QwWPeqaSVENc=;
        b=hkRepDIyCPQlTuG3ehlzYNbZ05cgs5JRUHl7KdWDqLGeLR0DY1MmrF23IVNjoty/sY
         8JDyZvFvIzlV6vdfl751Zk9zKAQ5aRKiWXjLrbLn2QQykH1p9WseF7l4qN2FUeZhPNIx
         K0XOpY+hnIyeAuNl0VdOB0Mi150TLCGhVU6h5BhC0VW216sTfI3pGszG9wfnUXs8sTRB
         TIsexCCg5tLzZn2BCNT4yZPsYFWHDQC6tmNv1xzRU4zalnlkkEm/yZvq/qtRrbZGaByY
         g2OOSEo/OQHPouNmV18UV4fCXePx++QqDh5tFnVBbWyFsEO1765ADL73IbZ847zrpZZ3
         hrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lz31d9qvODy/+YzXxTbbN3fpreRhI0QwWPeqaSVENc=;
        b=UYl5BDcGd3m5sezxcsIBM7WS3OoTJ+Dc+OHQglpbkomLSFLEc7M+F2LOJBkznyvs8/
         d3EINz7GrhgWcHFPhIeTReFMxbg2mWsfdXtwqtw9E4fa/BwHLhwyP7eyFDS29TSuZQN0
         2U2Gx9rqbpKvJk3Vt2BXL3fFv57NaItir0goyKOGlqE1IVpZb9Ur6P9JxHz9ZW+I4d7Q
         XlRSRvMD2tRta+aajBHC/Uolr8xLWihC8UFjrs24j05HBkQ2heKK9yt4/UBL7dwQEx6x
         vbGhXiPHcjeC+a6szdJybopu+ddjf5trrwR/J8J4n79DWPk0243Fpl+HIM3LDHcOR38t
         8QEw==
X-Gm-Message-State: ACrzQf3HGjlHOsdth1nPDv3nLBkfxS6UazQZIZrcCrpCj7kaGWdHSlRX
        gDPi6rP1ZMlXvjrqrftSGwi4NotVfLK7a1P4fjE=
X-Google-Smtp-Source: AMsMyM6+mrpTCl9vWrtieZkhWzaaIOC3pdM2YAu+5FQhHM7SgA5KzQAmPILvmV2IqpwoxvxbIeBiOB0IJkZPZsc+Hoc=
X-Received: by 2002:a17:907:2cca:b0:78d:ec48:ac29 with SMTP id
 hg10-20020a1709072cca00b0078dec48ac29mr17253005ejc.114.1666388966591; Fri, 21
 Oct 2022 14:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221018122708.823792-1-jolsa@kernel.org> <Y07vGVPIf913gND8@google.com>
 <Y0/Do4l0bALGrD0p@krava>
In-Reply-To: <Y0/Do4l0bALGrD0p@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 14:49:14 -0700
Message-ID: <CAEf4BzZ1jFaF2JSZXZw1pSYw76=PspXPF6rWRED+7Akjzb-9fA@mail.gmail.com>
Subject: Re: [PATCH] x86: Include asm/ptrace.h in syscall_wrapper header
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     sdf@google.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Akihiro HARAI <jharai0815@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 2:30 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Oct 18, 2022 at 11:23:21AM -0700, sdf@google.com wrote:
> > On 10/18, Jiri Olsa wrote:
> > > From: Jiri Olsa <olsajiri@gmail.com>
> >
> > > With just the forward declaration of the 'struct pt_regs' in
> > > syscall_wrapper.h, the syscall stub functions:
> >
> > >    __[x64|ia32]_sys_*(struct pt_regs *regs)
> >
> > > will have different definition of 'regs' argument in BTF data
> > > based on which object file they are defined in.
> >
> > > If the syscall's object includes 'struct pt_regs' definition,
> > > the BTF argument data will point to 'struct pt_regs' record,
> > > like:
> >
> > >    [226] STRUCT 'pt_regs' size=168 vlen=21
> > >           'r15' type_id=1 bits_offset=0
> > >           'r14' type_id=1 bits_offset=64
> > >           'r13' type_id=1 bits_offset=128
> > >    ...
> >
> > > If not, it will point to fwd declaration record:
> >
> > >    [15439] FWD 'pt_regs' fwd_kind=struct
> >
> > > and make bpf tracing program hooking on those functions unable
> > > to access fields from 'struct pt_regs'.
> >
> > Is the core issue here is that we can't / don't resolve FWD declarations
> > at load time (or dedup time)? I'm assuming 'struct pt_regs' is still
> > exposed somewhere in BTF via some other obj file, it's just those
> > syscall definitions that have FWD decl?
>
> yes, BTF is generated from dwarf debug info, so it's object based,
> and in some objects the regs argument will point to full struct
> definition and in some just to forward declaration
>
> >
> > Applying this patch seems fine for now, but also seems fragile. Should
> > we instead/also teach verifier/dedup/whatever to resolve those FWD
> > declarations?
>
> I'm not sure how hard it'd be to connect forward declarations
> to definitions.. it'd need to be probably in dedup or verifier
> as you suggest
>
> and I think it'd need to be done just based on struct name search,
> so I expect all sort of unexpected problems ;-) other than to be
> sure you connect to proper struct

exactly, which is why BTF dedup algorithm resolves FWD to STRUCT/UNION
only when we have to outer structs/unions that we are deduplicating,
and one of their field points to FWD on one side and STRUCT on another
side. Looking up by name is ambiguous and could be incorrect, so BTF
dedup needs sort of a "structural proof".

As far as the patch goes, it's a good thing to have more complete
types wherever possible, so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Andrii will have probably better idea if and where this is possible
>
> jirka
>
> >
> > > Including asm/ptrace.h directly in syscall_wrapper.h to make
> > > sure all syscalls see 'struct pt_regs' definition and resulted
> > > BTF for '__*_sys_*(struct pt_regs *regs)' functions point to
> > > actual struct, not just forward declaration.
> >
> > > Reported-by: Akihiro HARAI <jharai0815@gmail.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >   arch/x86/include/asm/syscall_wrapper.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > > diff --git a/arch/x86/include/asm/syscall_wrapper.h
> > > b/arch/x86/include/asm/syscall_wrapper.h
> > > index 59358d1bf880..fd2669b1cb2d 100644
> > > --- a/arch/x86/include/asm/syscall_wrapper.h
> > > +++ b/arch/x86/include/asm/syscall_wrapper.h
> > > @@ -6,7 +6,7 @@
> > >   #ifndef _ASM_X86_SYSCALL_WRAPPER_H
> > >   #define _ASM_X86_SYSCALL_WRAPPER_H
> >
> > > -struct pt_regs;
> > > +#include <asm/ptrace.h>
> >
> > >   extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
> > >   extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
> > > --
> > > 2.37.3
> >

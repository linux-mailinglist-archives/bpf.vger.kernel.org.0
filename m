Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B194112D399
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 19:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfL3SxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 13:53:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36602 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfL3SxG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 13:53:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id q20so30210025qtp.3;
        Mon, 30 Dec 2019 10:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+c40Umyv+PJGdt3spV+EstIvDbkd5D0AGvQSQkDVHlE=;
        b=X0ZUb3rTrrFjYcz72psK9SsBIyQgQr6b3bN68P+4IBUyFSjzGkgJhGqPD5RvOLNyFV
         G8zKkV4NleJSlxF6LpRW8fiqGLUf3m7I34JV/rBYgE3bP7d+KxNkTcoYSMOLZitR5PUY
         hYVWwuaW4vtw4nU45SIjjaVyqs2l2bcsYlHMMq6bLOqNBipNXUNM/TuDb/gC0z+oTZN6
         YPD6fhVEbtrV0gcvyv7Slj32vsHs2jEZ1JG8PGePMutRa0j+YpI8t/JF2ZLfQDeH5z4s
         3Wg5cWcJ6co/4y7bf6pOHOJcbyqd/9O8YQCMHPI6/q8Uk3Wx2awsX2+HIDXFg8m26whB
         jiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+c40Umyv+PJGdt3spV+EstIvDbkd5D0AGvQSQkDVHlE=;
        b=dbjhU2j583/3yae5hsZB7K4wMLvrjRA8OxPvPjV4OGn1vs0uLk+RyZ0rDOUhkYwujm
         I9VoMV2p1gp4BTsZcm4ffpufhY8Rba9XJXsYoRO1Jhd2XAXBIIq9OQzKE8hf9fg/QcjZ
         I2FvHdh5jDKPmpnvyzhGI9BWHphAODqIys8kgS/JbczwcHXT5iSlLOZSM1gdIbV95YQy
         Gt25n1zOd/KZN0AvxzYRCwPvMIQ4dKfpCWe7wLhetFRHef+IAIYoa+3lfF+DZCI25WzX
         rFqNjVe8hn9sSxI80OhrprcjDgcslWpdWtKZT0fdWgf9NeLL29fApgWMnJDhKRp11N9E
         cBqg==
X-Gm-Message-State: APjAAAUOLU4cxwQyzFsFA0U4hm7bInxrXn0DN74x8blh2UF+NFP6VZxW
        z/6SXTsg7n4AsIfIlscy7fnylAZvXHOwGdbnXQo=
X-Google-Smtp-Source: APXvYqzet2GpbojUKcLCDtYFJKQt7QGPuD359wUZPKWOUBYf2AvhYSaCGvtSpLCmR6p4XB+Xeun539/qyMaK8whl59k=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr49752689qtj.117.1577731985066;
 Mon, 30 Dec 2019 10:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-7-kpsingh@chromium.org>
 <CAEf4BzZ+wMTjghpr4=e5AY9xeFjvm-Rc+JooJzJstBW1r73z4A@mail.gmail.com> <20191230153711.GD70684@google.com>
In-Reply-To: <20191230153711.GD70684@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Dec 2019 10:52:53 -0800
Message-ID: <CAEf4BzaGkbcsL=NCVteeWEPZ5UMEV6vo+DqTn0YF+hg+y7TsDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 06/13] bpf: lsm: Init Hooks and create files
 in securityfs
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 30, 2019 at 7:37 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 23-Dec 22:28, Andrii Nakryiko wrote:
> > On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > The LSM creates files in securityfs for each hook registered with the
> > > LSM.
> > >
> > >     /sys/kernel/security/bpf/<h_name>
> > >
> > > The list of LSM hooks are maintained in an internal header "hooks.h"
> > > Eventually, this list should either be defined collectively in
> > > include/linux/lsm_hooks.h or auto-generated from it.
> > >
> > > * Creation of a file for the hook in the securityfs.
> > > * Allocation of a bpf_lsm_hook data structure which stores
> > >   a pointer to the dentry of the newly created file in securityfs.
> > > * Creation of a typedef for the hook so that BTF information
> > >   can be generated for the LSM hooks to:
> > >
> > >   - Make them "Compile Once, Run Everywhere".
> > >   - Pass the right arguments when the attached programs are run.
> > >   - Verify the accesses made by the program by using the BTF
> > >     information.
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  include/linux/bpf_lsm.h        |   12 +
> > >  security/bpf/Makefile          |    4 +-
> > >  security/bpf/include/bpf_lsm.h |   63 ++
> > >  security/bpf/include/fs.h      |   23 +
> > >  security/bpf/include/hooks.h   | 1015 ++++++++++++++++++++++++++++++++
> > >  security/bpf/lsm.c             |  138 ++++-
> > >  security/bpf/lsm_fs.c          |   82 +++
> > >  7 files changed, 1333 insertions(+), 4 deletions(-)
> > >  create mode 100644 include/linux/bpf_lsm.h
> > >  create mode 100644 security/bpf/include/bpf_lsm.h
> > >  create mode 100644 security/bpf/include/fs.h
> > >  create mode 100644 security/bpf/include/hooks.h
> > >  create mode 100644 security/bpf/lsm_fs.c
> > >
> >
> > [...]
> >
> > > +
> > > +/*
> > > + * The hooks can have an int or void return type, these macros allow having a
> > > + * single implementation of DEFINE_LSM_HOOK irrespective of the return type.
> > > + */
> > > +#define LSM_HOOK_RET(ret, x) LSM_HOOK_RET_##ret(x)
> > > +#define LSM_HOOK_RET_int(x) x
> > > +#define LSM_HOOK_RET_void(x)
> > > +
> > > +/*
> > > + * This macro defines the body of a LSM hook which runs the eBPF programs that
> > > + * are attached to the hook and returns the error code from the eBPF programs if
> > > + * the return type of the hook is int.
> > > + */
> > > +#define DEFINE_LSM_HOOK(hook, ret, proto, args)                                \
> > > +typedef ret (*lsm_btf_##hook)(proto);                                  \
> > > +static ret bpf_lsm_##hook(proto)                                       \
> > > +{                                                                      \
> > > +       return LSM_HOOK_RET(ret, LSM_RUN_PROGS(hook##_type, args));     \
> > >  }
> >
> > I'm probably missing something, but according to LSM_HOOK_RET
> > definition for when ret==void, bpf_lsm_##hook will be a noop and won't
> > call any BPF program. Did I miss some additional macro magic?
> >
>
> Good catch! You're right. These macros will not be there in v2 as
> we move to using trampolines based callbacks.

Cool, no worries.

>
> > >
> > > +/*
> > > + * Define the body of each of the LSM hooks defined in hooks.h.
> > > + */
> > > +#define BPF_LSM_HOOK(hook, ret, args, proto) \
> > > +       DEFINE_LSM_HOOK(hook, ret, BPF_LSM_ARGS(args), BPF_LSM_ARGS(proto))
> > > +#include "hooks.h"
> > > +#undef BPF_LSM_HOOK
> > > +#undef DEFINE_LSM_HOOK
> > > +
> > > +/*
> > > + * Initialize the bpf_lsm_hooks_list for each of the hooks defined in hooks.h.
> > > + * The list contains information for each of the hook and can be indexed by the
> > > + * its type to initialize security FS, attach, detach and execute eBPF programs
> > > + * for the hook.
> > > + */
> > > +struct bpf_lsm_hook bpf_lsm_hooks_list[] = {
> > > +       #define BPF_LSM_HOOK(h, ...)                                    \
> > > +               [h##_type] = {                                          \
> > > +                       .h_type = h##_type,                             \
> > > +                       .mutex = __MUTEX_INITIALIZER(                   \
> > > +                               bpf_lsm_hooks_list[h##_type].mutex),    \
> > > +                       .name = #h,                                     \
> > > +                       .btf_hook_func =                                \
> > > +                               (void *)(lsm_btf_##h)(bpf_lsm_##h),     \
> >
> > this btf_hook_func, is it assigned just so that type information for
> > bpf_lsm_xxx typedefs are preserved, is that right? It doesn't seem to
> > be ever called or read. If I'm not missing anything, check out
> > Martin's latest STRUCT_OPS patch set. He defines EMIT_TYPE_INFO(type)
> > macro, which will ensure that BTF for specified type is emitted into
> > vmlinux BTF, without actually using any extra space, defining extra
> > fields or static variables, etc. I suggest using the same for the
> > cleanest result.
> >
> > One more thing regarding lsm_bpf_ typedefs. Currently you are defining
> > them as a pointer to func_proto, matching LSM hook. There is an
> > alternative approach, which has few benefits over using func_proto. If
> > instead you define a struct, where each argument of func prototype is
> > represented as 8-byte aligned field, this will contain all the
> > necessary information for BPF verifier to do its job (just like
> > func_proto). But in addition to that, when vmlinux.h is generated, it
> > will contain a nice struct bpf_lsm_<hook_name> with correct structure
> > to be used **directly** in BPF program, as a single context argument.
> > So with vmlinux.h, users won't have to re-define all the argument
> > types and names in their BPF_TRACE_x definition. Let me provide
> > concrete example from your cover letter. This is what you provide as
> > an example:
>
> Is this also doable for the new approach suggsted by Alexei
> and prototyped in?
>
> https://lore.kernel.org/bpf/CAEf4BzYiUZtSJKh-UBL0jwyo6d=Cne2YtEyGU8ONykmSUSsuNA@mail.gmail.com/T/#m7c7ec0e7d8e803c6c357495d9eea59028a67cac6
>
> which uses trampolines. The new approach gets rid of any type
> generation and macros in security/bpf/lsm_hooks.h. Maybe the
> btf_vmlinux can be augmented at runtime to generate context struct
> upon attachment?

If it doesn't generate "controllable" types (and seems like existing
types are not readily usable as well), then we can't use vmlinux's BTF
as is. But we can augment vmlinux.h header during generation time,
based on naming convention and extra post-processing of vmlinux BTF.
That's sort of a point of special `format core` mode in bpftool, which
we currently discuss on mailing list as well, see [0].

  [0] https://lore.kernel.org/bpf/CAEf4BzY4ffWaeFckPuqNGNAU1uBG3TmTK+CjY1LVa2G+RGz=cA@mail.gmail.com/T/#u


>
> >
> > BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
> >             struct vm_area_struct *, vma,
> >             unsigned long, reqprot, unsigned long, prot) {...}
> >
> > on kernel side, you'll have:
> >
> > typedef int (*bpf_lsm_file_mprotect)(struct vm_area_struct *vma,
> >                                      unsigned long reqprot,
> >                                      unsigned long prot);
> >
> > So you can see that user has to go and copy/paste all the arguments
> > and their types and paste them in this verbose BPF_TRACE_3 macro to
> > define correct BPF program.
> >
> > Now, imagine that instead of typedef above, we define equivalent struct:
> >
> > struct bpf_lsm_file_mprotect {
> >     struct vm_area_struct *vma;
> >     unsigned long reqprot;
> >     unsigned long prot;
> > };
> >
> > This type will get dumped into vmlinux.h, which can be used from BPF
> > user code as such:
> >
> > SEC("lsm/file_mprotect")
> > int mprotect_audito(struct bpf_lsm_file_mprotect *ctx)
> > {
> >     ... here you can use ctx->vma, ctx->reqprot, ctx->prot ...
> > }
> >
> >
> > Meanwhile, there will be just minimal changes to BPF verifier to use
> > such struct instead of func_proto for verification of LSM programs.
> >
> > We currently have similar issue with raw_tp programs and I've been
> > thinking about switching that to structs instead of func_proto, so we
> > might as well coordinate that and reuse the same logic in BPF
> > verifier.
> >
> > Thoughts?
>
> Thanks for the explanation!
>
> Using structs is definitely better if we chose to go with static type
> generation.
>

Yes, that's what I think is preferable for tp_btf programs as well.

> - KP
>
> >
> >
> >
> > > +               },
> > > +       #include "hooks.h"
> > > +       #undef BPF_LSM_HOOK
> > > +};
> > > +
> >
> > [...]

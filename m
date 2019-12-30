Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B230012D183
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2019 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfL3PhQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Dec 2019 10:37:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38790 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfL3PhQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Dec 2019 10:37:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so33010819wrh.5
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2019 07:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tiCQCdakK6fDzgexzkvgBKYze7/iADTMOOF8ok0L44Q=;
        b=GyWA8d6l1wSFYn+MXTH0j033hlQ6iyw/Lzss52IlF8YLd1QFxQZA9Sda+viMXfwcTA
         PggMcMNSEE+xLPY/pCT+PmagRxk/VulDXWdUaSO4rgp0zs2C5CfGaRFVCKyRbX0l10ym
         n+qk40Is4zLPZOjIGPqwrT5dbs+dEZSyaiYUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tiCQCdakK6fDzgexzkvgBKYze7/iADTMOOF8ok0L44Q=;
        b=Mz4bxV0UrT2GjjMMXxFoIUhm4VkB1FeiPG4Eu1Ii5VMZhEeYH42fqnVonPn5j0TyZC
         eFouUmj1EdhuPNtkRVh0ydInZJ5Ek8HDqnAeLHMo/t7fZRBuDea4NE/2AGQTPuAuIe4A
         N6Y18m+4z66K1VxCnL+E0mV4P+Hd+ji6EWQPbshhX1DZ2vTk8D8xup4g8f1QCX5PaWcZ
         LW2ieFer+aCCf8OqnTmibe1fNUHYy2B3cXW33S99WHZD2Nnu2LkgVN0mFhvhrsLJRCv3
         0WsVHkcD8xH0OxRaEPuUA38GZQljoswWO8YQsCcgJO+oqE/A+ih1QMEPU3idjcUHBI+u
         xYQQ==
X-Gm-Message-State: APjAAAW8LG6V9YqtKs7bveMcnHdiZfTq171h1Jdhhs1YFXLoq1/16rIT
        Nb7DUlPvMBfoJ/1dJtvTyiuLFA==
X-Google-Smtp-Source: APXvYqyAbNjc9WooFzSxz1dE7NsCeFomKkKb2dBfao+ScDJ9PR4H//GCLBuhWCPjZnrj1YeC7CZ5Fw==
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr68738440wrp.142.1577720233670;
        Mon, 30 Dec 2019 07:37:13 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id a9sm20487173wmm.15.2019.12.30.07.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:37:13 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 30 Dec 2019 16:37:11 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
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
Subject: Re: [PATCH bpf-next v1 06/13] bpf: lsm: Init Hooks and create files
 in securityfs
Message-ID: <20191230153711.GD70684@google.com>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-7-kpsingh@chromium.org>
 <CAEf4BzZ+wMTjghpr4=e5AY9xeFjvm-Rc+JooJzJstBW1r73z4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ+wMTjghpr4=e5AY9xeFjvm-Rc+JooJzJstBW1r73z4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Dec 22:28, Andrii Nakryiko wrote:
> On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > The LSM creates files in securityfs for each hook registered with the
> > LSM.
> >
> >     /sys/kernel/security/bpf/<h_name>
> >
> > The list of LSM hooks are maintained in an internal header "hooks.h"
> > Eventually, this list should either be defined collectively in
> > include/linux/lsm_hooks.h or auto-generated from it.
> >
> > * Creation of a file for the hook in the securityfs.
> > * Allocation of a bpf_lsm_hook data structure which stores
> >   a pointer to the dentry of the newly created file in securityfs.
> > * Creation of a typedef for the hook so that BTF information
> >   can be generated for the LSM hooks to:
> >
> >   - Make them "Compile Once, Run Everywhere".
> >   - Pass the right arguments when the attached programs are run.
> >   - Verify the accesses made by the program by using the BTF
> >     information.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  include/linux/bpf_lsm.h        |   12 +
> >  security/bpf/Makefile          |    4 +-
> >  security/bpf/include/bpf_lsm.h |   63 ++
> >  security/bpf/include/fs.h      |   23 +
> >  security/bpf/include/hooks.h   | 1015 ++++++++++++++++++++++++++++++++
> >  security/bpf/lsm.c             |  138 ++++-
> >  security/bpf/lsm_fs.c          |   82 +++
> >  7 files changed, 1333 insertions(+), 4 deletions(-)
> >  create mode 100644 include/linux/bpf_lsm.h
> >  create mode 100644 security/bpf/include/bpf_lsm.h
> >  create mode 100644 security/bpf/include/fs.h
> >  create mode 100644 security/bpf/include/hooks.h
> >  create mode 100644 security/bpf/lsm_fs.c
> >
> 
> [...]
> 
> > +
> > +/*
> > + * The hooks can have an int or void return type, these macros allow having a
> > + * single implementation of DEFINE_LSM_HOOK irrespective of the return type.
> > + */
> > +#define LSM_HOOK_RET(ret, x) LSM_HOOK_RET_##ret(x)
> > +#define LSM_HOOK_RET_int(x) x
> > +#define LSM_HOOK_RET_void(x)
> > +
> > +/*
> > + * This macro defines the body of a LSM hook which runs the eBPF programs that
> > + * are attached to the hook and returns the error code from the eBPF programs if
> > + * the return type of the hook is int.
> > + */
> > +#define DEFINE_LSM_HOOK(hook, ret, proto, args)                                \
> > +typedef ret (*lsm_btf_##hook)(proto);                                  \
> > +static ret bpf_lsm_##hook(proto)                                       \
> > +{                                                                      \
> > +       return LSM_HOOK_RET(ret, LSM_RUN_PROGS(hook##_type, args));     \
> >  }
> 
> I'm probably missing something, but according to LSM_HOOK_RET
> definition for when ret==void, bpf_lsm_##hook will be a noop and won't
> call any BPF program. Did I miss some additional macro magic?
> 

Good catch! You're right. These macros will not be there in v2 as
we move to using trampolines based callbacks.

> >
> > +/*
> > + * Define the body of each of the LSM hooks defined in hooks.h.
> > + */
> > +#define BPF_LSM_HOOK(hook, ret, args, proto) \
> > +       DEFINE_LSM_HOOK(hook, ret, BPF_LSM_ARGS(args), BPF_LSM_ARGS(proto))
> > +#include "hooks.h"
> > +#undef BPF_LSM_HOOK
> > +#undef DEFINE_LSM_HOOK
> > +
> > +/*
> > + * Initialize the bpf_lsm_hooks_list for each of the hooks defined in hooks.h.
> > + * The list contains information for each of the hook and can be indexed by the
> > + * its type to initialize security FS, attach, detach and execute eBPF programs
> > + * for the hook.
> > + */
> > +struct bpf_lsm_hook bpf_lsm_hooks_list[] = {
> > +       #define BPF_LSM_HOOK(h, ...)                                    \
> > +               [h##_type] = {                                          \
> > +                       .h_type = h##_type,                             \
> > +                       .mutex = __MUTEX_INITIALIZER(                   \
> > +                               bpf_lsm_hooks_list[h##_type].mutex),    \
> > +                       .name = #h,                                     \
> > +                       .btf_hook_func =                                \
> > +                               (void *)(lsm_btf_##h)(bpf_lsm_##h),     \
> 
> this btf_hook_func, is it assigned just so that type information for
> bpf_lsm_xxx typedefs are preserved, is that right? It doesn't seem to
> be ever called or read. If I'm not missing anything, check out
> Martin's latest STRUCT_OPS patch set. He defines EMIT_TYPE_INFO(type)
> macro, which will ensure that BTF for specified type is emitted into
> vmlinux BTF, without actually using any extra space, defining extra
> fields or static variables, etc. I suggest using the same for the
> cleanest result.
> 
> One more thing regarding lsm_bpf_ typedefs. Currently you are defining
> them as a pointer to func_proto, matching LSM hook. There is an
> alternative approach, which has few benefits over using func_proto. If
> instead you define a struct, where each argument of func prototype is
> represented as 8-byte aligned field, this will contain all the
> necessary information for BPF verifier to do its job (just like
> func_proto). But in addition to that, when vmlinux.h is generated, it
> will contain a nice struct bpf_lsm_<hook_name> with correct structure
> to be used **directly** in BPF program, as a single context argument.
> So with vmlinux.h, users won't have to re-define all the argument
> types and names in their BPF_TRACE_x definition. Let me provide
> concrete example from your cover letter. This is what you provide as
> an example:

Is this also doable for the new approach suggsted by Alexei
and prototyped in?

https://lore.kernel.org/bpf/CAEf4BzYiUZtSJKh-UBL0jwyo6d=Cne2YtEyGU8ONykmSUSsuNA@mail.gmail.com/T/#m7c7ec0e7d8e803c6c357495d9eea59028a67cac6

which uses trampolines. The new approach gets rid of any type
generation and macros in security/bpf/lsm_hooks.h. Maybe the
btf_vmlinux can be augmented at runtime to generate context struct
upon attachment?

> 
> BPF_TRACE_3("lsm/file_mprotect", mprotect_audit,
>             struct vm_area_struct *, vma,
>             unsigned long, reqprot, unsigned long, prot) {...}
> 
> on kernel side, you'll have:
> 
> typedef int (*bpf_lsm_file_mprotect)(struct vm_area_struct *vma,
>                                      unsigned long reqprot,
>                                      unsigned long prot);
> 
> So you can see that user has to go and copy/paste all the arguments
> and their types and paste them in this verbose BPF_TRACE_3 macro to
> define correct BPF program.
> 
> Now, imagine that instead of typedef above, we define equivalent struct:
> 
> struct bpf_lsm_file_mprotect {
>     struct vm_area_struct *vma;
>     unsigned long reqprot;
>     unsigned long prot;
> };
> 
> This type will get dumped into vmlinux.h, which can be used from BPF
> user code as such:
> 
> SEC("lsm/file_mprotect")
> int mprotect_audito(struct bpf_lsm_file_mprotect *ctx)
> {
>     ... here you can use ctx->vma, ctx->reqprot, ctx->prot ...
> }
> 
> 
> Meanwhile, there will be just minimal changes to BPF verifier to use
> such struct instead of func_proto for verification of LSM programs.
> 
> We currently have similar issue with raw_tp programs and I've been
> thinking about switching that to structs instead of func_proto, so we
> might as well coordinate that and reuse the same logic in BPF
> verifier.
> 
> Thoughts?

Thanks for the explanation!

Using structs is definitely better if we chose to go with static type
generation.

- KP

> 
> 
> 
> > +               },
> > +       #include "hooks.h"
> > +       #undef BPF_LSM_HOOK
> > +};
> > +
> 
> [...]

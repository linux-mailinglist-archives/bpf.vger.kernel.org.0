Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35C33734B3
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 07:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhEEFXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 01:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhEEFXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 01:23:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C3CC061574;
        Tue,  4 May 2021 22:22:55 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s25so914541lji.0;
        Tue, 04 May 2021 22:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9Y/yp+q451c1G9V1HjAAuASbzFos41wdSkhh22mJrM=;
        b=OGQyZNQEp57ynybRHUJIyF981Gi0/xBVLN3xAiO8WkzepB1TjzOK/NPkTgVJNkNx4t
         7/jYtRDq2TROp0MMICm5+2ZP5K/7d710ZfIvNlDaIOB3OPgKGmlF9Oq0vsUo39Hhi4Hc
         fkxJ8N0OryQ+gwRA4Lka9iihbC7HY0EEcaVcWpt78/DKBp5dBYYHOgbnyixQr9ThOZp7
         aSFfw9our/j5RmUKhwH560yySls9A8UvtHI4ooQ57aLFvdkIdAX+QzAggxzwCkfVhUQC
         ttGtp5SjPytfBVzBl+U78qwSW7LUiGrO88ZTN6pkabGDKIiABqq0B2d8LuSaeqgGwyfK
         B2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9Y/yp+q451c1G9V1HjAAuASbzFos41wdSkhh22mJrM=;
        b=Q15WNjGc6pF4mYQPG+Tf4AcZs/BZuI9y821y343YP02NBwMcSFm/jxXGzr7CcrIDYt
         VKM/xedrHqU5Qom5AFHE5ai/AUQSld5MHBpe+IjKU7DthegacR9BohLOKe0DArJdgoNL
         fdTg4wLg4tZiI+PhVHzBkwdTe22RwUb4MpA5A00gtLPniUiWsoq6x1y0HYLEfE3rOXaY
         stPYi2xf9dHzWa+YS9dMRKXX4A5qrf8U60midng9GizmIGt4bThlYnvQx0vDojL4TT9a
         sQ0FAAMn75lPv4KIXCf8ZPz1eruIzwOHkG79LLXnygCOjneqJYG5iLrMX0RX8cxpF/Td
         rDDg==
X-Gm-Message-State: AOAM533Ib50QVywX8BAtghbW45HBj5UCSCmlbwo7Ct/94pD0xGf6tG8Q
        tZLUR7SduxBauc14f9H6iWnadKDl2lt1mGYgrt4=
X-Google-Smtp-Source: ABdhPJzI1EwLElx4VbExzACEToz/l9OLPB4uSMIGVplZ+YH2da2/jcHNsqIS/o07liZIJSwsQ0Vi2ABf4S2LefuH5BY=
X-Received: by 2002:a2e:a489:: with SMTP id h9mr10049668lji.21.1620192173535;
 Tue, 04 May 2021 22:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQKo+efxMvgrqYqVvUEgiz_GXgBVOt4ddPTw_mLuvr2HUw@mail.gmail.com>
 <CAEf4BzZifOFHr4gozUuSFTh7rTWu2cE_-L4H1shLV5OKyQ92uw@mail.gmail.com>
 <CAADnVQ+h78QijAjbkNqAWn+TAFxrd6vE=mXqWRcy815hkTFvOw@mail.gmail.com>
 <CAEf4BzZOmCgmbYDUGA-s5AF6XJFkT1xKinY3Jax3Zm2OLNmguA@mail.gmail.com>
 <20210426223449.5njjmcjpu63chqbb@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzYZX9YJcoragK20cvQvr_tPTWYBQSRh7diKc1KoCtu4Dg@mail.gmail.com>
 <20210427022231.pbgtrdbxpgdx2zrw@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZOwTp4vQxvCSXaS4-94fz_eZ7Q4n6uQfkAnMQnLRaTbQ@mail.gmail.com>
 <20210428045545.egqvhyulr4ybbad6@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZo7_r-hsNvJt3w3kyrmmBJj7ghGY8+k4nvKF0KLjma=w@mail.gmail.com> <20210504044204.kpt6t5kaomj7oivq@ast-mbp>
In-Reply-To: <20210504044204.kpt6t5kaomj7oivq@ast-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 May 2021 22:22:42 -0700
Message-ID: <CAADnVQ+WV8xZqJfWx8em5Ch8aKA8xcPqR0wT0BdFf9M==W5_FQ@mail.gmail.com>
Subject: Re: bpf libraries and static variables. Was: [PATCH v2 bpf-next 2/6]
 libbpf: rename static variables during linking
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 3, 2021 at 9:42 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 28, 2021 at 12:33:36PM -0700, Andrii Nakryiko wrote:
> > > At least I'm only starting to grasp the complexity of the problem.
> >
> > I did and didn't find anything satisfactory. But I think we are coming
> > at this from two different angles, which is why we can't agree on
> > anything. So just a reminder, static is about two properties:
> >     1) access protection
> >     2) naming collisions.
> >
> > I'm trying to let name collisions on BPF side happen and be allowed
> > *while* also allowing access to those same name-collisioned entities
> > (maps and vars, both) from user-space in some non-random fashion. That
> > inevitably requires some compromises/conventions on the user-space
> > side. Such an approach preserves both 1) and 2).
> >
> > You are trying to enforce unique names (or at least aliases) for
> > static variables, if I understand correctly, which preserves 1) at the
> > expense of 2). It seems to be a similar idea with custom SEC(), though
> > you ignored my request to elaborate on how you see that used, so I'm
> > guessing here a bit.
> >
> > But I think we can get just 1) with global variables with custom
> > visibilities. E.g., just marking map/variable as __hidden would
> > disallow extern'ing it from other files. That's obviously limiting for
> > extern'ing within the library, so we can keep digging deeper and
> > define __internal (STV_INTERNAL) that would be "upgraded" to
> > STV_HIDDEN after the initial linking pass. So you'd compile your BPF
> > library with __internal, but your lib.bpf.o will have those global
> > variables as STV_HIDDEN and thus inaccessible from other libraries and
> > BPF app itself.
> >
> > So if we are ok breaking existing static variable users, then just
> > dropping statics from BPF skeleton and supporting extra __hidden and
> > __internal semantics for variables and maps would bypass these issues.
> > I wanted statics mostly for property 2), but if I can't get it, then
> > I'd drop statics from skeletons altogether.
> >
> > If I could drop statics for skeletons that were statically linked,
> > that wouldn't be a regression. It's impossible to do right now, but we
> > can also add a new SHT_NOTE section, which we can use to detect
> > statically linked vs Clang-generated .bpf.o. Certainly more ELF
> > fussing around than I'd like, but not the end of the world either.
> >
> > Thoughts? Did that summarize the issue well enough?
>
> Background for all:
>
> Until Nov 2019 libbpf didn't support global variables, so bpf programs
> contained code like 'static volatile const int var = 1;'
> Then the skeleton was introduced which went through BTF of a given
> datasec and emitted all variables from that section into .skel.h.
> It didn't bother filtering static vs global variables, so
> static vars in *.bpf.c world became visible into user space *.c world.
> While libbpf supported single bpf.o file such extern-ing of statics
> was fine, but with support of linking multiple *.bpf.o there
> is a question of what to do with static variables with the same names
> in different files.
>
> Consider the following scenario:
> One bpf developer creates a library conntrack. It has
> impl.bpf.c
> ct_api.bpf.c
> and corresponding user space ct.c that uses skel.h to access
> data in these two bpf files.
>
> Another bpf developer creates a library for lru. It has
> impl.bpf.c
> lru_api.bpf.c
> and corresponding user space lru.c.
>
> Now the 3rd developer is writing its main.bpf.c and wants to use these libs.
>
> The libs should be usable in pre-compiled form. The availability of
> the source code is nice, but it shouldn't be mandatory.
>
> So there is libct.a (with user space) and libct.bpf.a (with bpf code)
> and liblru.a (user) and liblru.bpf.a (bpf code).
>
> The developer should be able to link
> main.bpf.o liblru.bpf.a libct.bpf.a
> into final_main.bpf.o
> And link main.o liblru.a libct.a with user space bits into a.out.
>
> The lru.skel.h and ct.skel.h used by these libs were generated
> out of corresponding *.bpf.o and independent of each other.
> There should be no need to recompile user space lru.c and ct.c after
> linking of final_main.bpf.o and generating final skeleton.
>
> I think all three developers should be able to use static variables
> in their .bpf.c files without worrying about conflicts across three
> projects.
> They can use global vars with __attribute__("hidden"),
> but it's not equivalent to static. The linker will complain of
> redefinition if the same name is used across multiple files
> or multiple libs.
> So doing 'int var __attribute__("hidden");' in libct.bpf.a and
> in liblru.bpf.a will prevent linking together.
> That's traditional static linking semantics.
>
> Using file name as a prefix for static vars doesn't work in general,
> since file names can be the same.
> What can work is the library name. The library name is guaranteed to be
> unique in the final linking phase.
> I think we can use it to namespace static variables across
> three sets of bpf programs.
> Also I think it's ok to require a single developer to enforce
> uniqueness of static vars within a project.
>
> In other words 'static int a;' in impl.bpf.c will conflict
> with 'static int a;' in ct_api.bpf.c
> But the static variable in ct_api.bpf.c will not conflict
> with the same variable in lru_api.bpf.c and will not conflict
> with such var in main.bpf.c because they're in a different namespaces.
>
> Here are few ways for the programmer to indicate the library namespaces:
>
> - similar to 'char license[]' use 'char library[]="lru";' in *.bpf.c
> The static linker will handle this reserved name specially just like
> it does 'license' and 'version'.
>
> - #pragma clang attribute push (__attribute__((annotate("lib=lru"))), apply_to = variable)
>
> - #pragma comment(lib, "lru")
>
> I think it's important to define namespaces within *.bpf.c.
> Defining them outside on linker command line or linker script is cumbersome.
>
> I think combining *.o into .a can happen with traditional 'ar'. No need for
> extra checks for now.
> The linking of main.bpf.o liblru.bpf.a libct.bpf.a
> will fail if static vars with the same name are present within the same library.
> The library namespaces will prevent name conflicts across libs and main.bpf.o
> If namespace is not specified it means it's empty, so the existing
> hacks of 'static volatile const int var;' will continue working.
>
> The skeleton can have library name as anon struct in skel.h.
> All vars can be prefixed too, but scoping them into single struct is cleaner.
>
> I think it doesn't hurt if final_main.skel.h includes all bpf vars from lru and
> ct libraries, but I think it's cleaner to omit them.
>
> It's not clear to me yet how final_main__open() and final_main__load() skeleton
> methods will work since lru and ct libs might need their specific initialization
> that is done by user space lru.c and ct.c.
> Also the whole scheme should work with upcoming light skeleton too.
> The design for bpf libraries should accommodate signed libraries.
>
> All of the above is up for discussion. I'd love to hear what golang folks
> are thinking, since above proposal is C centric.

I want to clarify a few things that were brought up in offline discussions.
There are several options:
1. don't emit statics at all.
That will break some skeleton users and doesn't solve the name conflict issue.
The library authors would need to be careful and use a unique enough
prefix for all global vars (including attribute("hidden") ones).
That's no different with traditional static linking in C.
bpf static linker already rejects linking if file1.bpf.c is trying to
'extern int foo()'
when it was '__hidden int foo();' in file2.bpf.c
That's safer than traditional linker and the same approach can be
applied to vars.
So externing of __hidden vars won't be possible, but they will name conflict.

2. emit statics when they don't conflict and fail skel gen where there
is a naming conflict.
That helps a bit, but library authors still have to be careful with
both static and global names.
Which is more annoying than traditional C.

3. do #2 style of failing skel gen if there is a naming conflict, but
also introduce namespacing concept, so that both global and static
vars can be automatically namespaced.
That's the proposal above.
This way, I'm guessing, some libraries will use namespaces to avoid
prefixing everything.
The folks that hate namespaces and #pragmas will do manual prefixes for
both static and global vars.

For approaches
char library[]="lru";'
and
#pragma comment(lib, "lru")
the scope of namespace is the whole .bpf.c file.
The clang/llvm already support it, so the job of name mangling would
belong to linker.

For __attribute__((annotate("lib=lru"))) the scope could be any number
of lines in C files between pragma push/pop and can be nested.
This attribute is supported by clang, but not in the bpf backend.
The llvm would prefix both global and static names
in elf file and in btf.
If another file.bpf.c needs to call a function from namespace "lru"
it would need to prefix such a call.
The skel gen job would be #2 above (emit both static and globals if
they don't conflict).
Such namespacing concept would be the closest to c++ namespaces.

If I understood what folks were saying no one is excited about namespaces in C.
So probably #3 is out and sounds like 1 is prefered?
So don't emit statics ?

Daniel, Lorenz, John,

what's your take ?

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3F84708A0
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245302AbhLJS3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 13:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbhLJS3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 13:29:02 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2D0C061746
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 10:25:27 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d10so23327769ybe.3
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 10:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NusEZVJ6wqGQwjU0pjnx1p04JQ0anfRPnYEaQG2tneg=;
        b=KFkY952SjT6eB1td4AN5pAkseaNRynwxNftQXl2+K+n69SQ+D6hTozdHOeqslFe26w
         Drlm9kiuIldL19oNRVqg4SepHn0y4f3O7YE+U24Z4T9bG6E4uU8t/Q285vTVEUphnUhr
         J8iK1MI44jXx2F7PiJQsHDUr2to2EtWO293AyCoJ1CHlmQPkRGJ7RbpkNoXoyS5KJqzQ
         zL9G6PGgXKONckM1JlWLqzhusm4seOS1YU+c1TlvO3GrpE4Ts5SaP/OLemNkWTbnl6+P
         F3yJlPWaYCfwNODa8L+bp3o7eRGcyBDkVhqvwkU34Qdw9L7CzPZXjQ1rzzvb/igYmzie
         rEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NusEZVJ6wqGQwjU0pjnx1p04JQ0anfRPnYEaQG2tneg=;
        b=6h0ZzHnv3re4DsVB1gVkjMbEHbDf/ujJxPFbeI+WIYT82JNSQuwjF95DPfjIPaBD5F
         8B+s4D9Ey74yLzb1Yc/FJyX6VqHqikdML0bLYNeFgka/YUHrmZI1tDKyTTcgKdyrKVT+
         pS1XdwXzUB3q1Ukuiv0mirbR1x3dpwHeXU1eOMXv/7phPJJRH3sAsgZEF7j8JiTeZMZg
         msFrkyykHuA/65sMdYSKyDz4nuoLt1Ql8Iz2Xsa6pBz7ulvPJvPwyCi68AizUCRaWr9x
         YBakAmpttI96VY0ruKsFbWLU66yf6R8FmZiO8EatvVsEbS7ontO4QJy3wld4RxtsD8kF
         tl0g==
X-Gm-Message-State: AOAM5321xo4thC8fD2iBCiAaNd4x4uP3GxIs5AYuFOeXi2DNN5RMLeXE
        Hxw9yi9I/JZjHrR9LZgF5UcPkAjwC7TYdrSUkPI=
X-Google-Smtp-Source: ABdhPJww98jNjS9SbtAk42rM4zF/RdVNjxrD9R9CK8cFLrYkzKAoylj1/weSEigJ99zMLu3fJhiJU6w3pjlu5EK2HC0=
X-Received: by 2002:a25:e90a:: with SMTP id n10mr15788392ybd.180.1639160726855;
 Fri, 10 Dec 2021 10:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20211210061517.642835-1-andrii@kernel.org> <87fsr0wwd3.fsf@toke.dk>
In-Reply-To: <87fsr0wwd3.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Dec 2021 10:25:15 -0800
Message-ID: <CAEf4BzaeUZ1Pk3Yr5RqCwV9+WLRgeUxZ4k0zqgk5NyHNfFhsjw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if kernel
 needs it for BPF
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 10, 2021 at 3:08 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Andrii Nakryiko <andrii@kernel.org> writes:
>
> > The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
> > one of the first extremely frustrating gotchas that all new BPF users g=
o
> > through and in some cases have to learn it a very hard way.
> >
> > Luckily, starting with upstream Linux kernel version 5.11, BPF subsyste=
m
> > dropped the dependency on memlock and uses memcg-based memory accountin=
g
> > instead. Unfortunately, detecting memcg-based BPF memory accounting is
> > far from trivial (as can be evidenced by this patch), so in practice
> > most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
> >
> > As we move towards libbpf 1.0, it would be good to allow users to forge=
t
> > about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
> > automatically. This patch paves the way forward in this matter. Libbpf
> > will do feature detection of memcg-based accounting, and if detected,
> > will do nothing. But if the kernel is too old, just like BCC, libbpf
> > will automatically increase RLIMIT_MEMLOCK on behalf of user
> > application ([0]).
> >
> > As this is technically a breaking change, during the transition period
> > applications have to opt into libbpf 1.0 mode by setting
> > LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
> > libbpf_set_strict_mode().
> >
> > Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
> > with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
> > nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
> > called before the first bpf_prog_load(), bpf_btf_load(), or
> > bpf_object__load() call, otherwise it has no effect and will return
> > -EBUSY.
> >
> >   [0] Closes: https://github.com/libbpf/libbpf/issues/369
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c             | 122 ++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/bpf.h             |   2 +
> >  tools/lib/bpf/libbpf.c          |  47 +++---------
> >  tools/lib/bpf/libbpf.map        |   1 +
> >  tools/lib/bpf/libbpf_internal.h |  39 ++++++++++
> >  tools/lib/bpf/libbpf_legacy.h   |  12 +++-
> >  6 files changed, 184 insertions(+), 39 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 4e7836e1a7b5..5b14111b80dd 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -29,6 +29,7 @@
> >  #include <errno.h>
> >  #include <linux/bpf.h>
> >  #include <limits.h>
> > +#include <sys/resource.h>
> >  #include "bpf.h"
> >  #include "libbpf.h"
> >  #include "libbpf_internal.h"
> > @@ -94,6 +95,119 @@ static inline int sys_bpf_prog_load(union bpf_attr =
*attr, unsigned int size, int
> >       return fd;
> >  }
> >
> > +/* Probe whether kernel switched from memlock-based (RLIMIT_MEMLOCK) t=
o
> > + * memcg-based memory accounting for BPF maps and progs. This was done=
 in [0],
> > + * but it's not straightforward to detect those changes from the user-=
space.
> > + * So instead we'll try to detect whether [1] is in the kernel, which =
follows
> > + * [0] almost immediately and made it into the upstream kernel in the =
same
> > + * release.
> > + *
> > + * For this, we'll upload a trivial BTF into the kernel and will try t=
o load
> > + * a trivial BPF program with attach_btf_obj_fd pointing to our BTF. I=
f it
> > + * returns anything but -EOPNOTSUPP, we'll assume we still need
> > + * RLIMIT_MEMLOCK.
> > + *
> > + *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.=
com/
> > + *   [1] Fixes: 8bdd8e275ede ("bpf: Return -ENOTSUPP when attaching to=
 non-kernel BTF")
> > + */
> > +int probe_memcg_account(void)
> > +{
> > +     const size_t bpf_load_attr_sz =3D offsetofend(union bpf_attr, att=
ach_btf_obj_fd);
> > +     const size_t btf_load_attr_sz =3D offsetofend(union bpf_attr, btf=
_log_level);
> > +     int prog_fd =3D -1, btf_fd =3D -1, err;
> > +     struct bpf_insn insns[1] =3D {}; /* instructions don't matter */
> > +     const void *btf_data;
> > +     union bpf_attr attr;
> > +     __u32 btf_data_sz;
> > +     struct btf *btf;
> > +
> > +     /* create the simplest BTF object and upload it into the kernel *=
/
> > +     btf =3D btf__new_empty();
> > +     err =3D libbpf_get_error(btf);
> > +     if (err)
> > +             return err;
> > +     err =3D btf__add_int(btf, "int", 4, 0);
> > +     btf_data =3D btf__raw_data(btf, &btf_data_sz);
> > +     if (!btf_data) {
> > +             err =3D -ENOMEM;
> > +             goto cleanup;
> > +     }
> > +
> > +     /* we won't use bpf_btf_load() or bpf_prog_load() because they wi=
ll
> > +      * be trying to detect this feature and will cause an infinite lo=
op
> > +      */
> > +     memset(&attr, 0, btf_load_attr_sz);
> > +     attr.btf =3D ptr_to_u64(btf_data);
> > +     attr.btf_size =3D btf_data_sz;
> > +     btf_fd =3D sys_bpf_fd(BPF_BTF_LOAD, &attr, btf_load_attr_sz);
> > +     if (btf_fd < 0) {
> > +             err =3D -errno;
> > +             goto cleanup;
> > +     }
> > +
> > +     /* attempt loading freplace trying to use custom BTF */
> > +     memset(&attr, 0, bpf_load_attr_sz);
> > +     attr.prog_type =3D BPF_PROG_TYPE_TRACING;
> > +     attr.expected_attach_type =3D BPF_TRACE_FENTRY;
> > +     attr.insns =3D ptr_to_u64(insns);
> > +     attr.insn_cnt =3D sizeof(insns) / sizeof(insns[0]);
> > +     attr.license =3D ptr_to_u64("GPL");
> > +     attr.attach_btf_obj_fd =3D btf_fd;
> > +
> > +     prog_fd =3D sys_bpf_fd(BPF_PROG_LOAD, &attr, bpf_load_attr_sz);
> > +     if (prog_fd >=3D 0)
> > +             /* bug? we shouldn't be able to successfully load program=
 */
> > +             err =3D -EFAULT;
> > +     else
> > +             /* assume memcg accounting is supported if we get -EOPNOT=
SUPP */
> > +             err =3D errno =3D=3D 524 /* ENOTSUPP */ ? 1 : 0;
>
> Nit: comment and code seems to be in disagreement over the name of the
> error code here.

One careful reader there :) There is also a comment about
bpf_link_create, which I removed because BPF_LINK_CREATE didn't depend
on memlock. I'll update both and will send v2, thanks.

>
> (side note, since we've ended up using ENOTSUPP everywhere in BPF, any
> reason we can't export it in a UAPI header somewhere?)

No opinion here, tbh, but certainly not part of this change.

>
> -Toke
>

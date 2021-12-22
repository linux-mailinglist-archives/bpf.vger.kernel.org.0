Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3152247D93D
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 23:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbhLVWOs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 17:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhLVWOr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Dec 2021 17:14:47 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA237C061574
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 14:14:46 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q5so4711835ioj.7
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 14:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7pUOWT8WZ+nXJAMbNstV8aGKgks3P9pOK+8MjvHbHs=;
        b=VQF5L9RRiMT0epnbdQ58AsBOLBDCDFQ+nThtUYjHhTjxTTfpt1U04NxxOoUlJKzGgZ
         agj/h5IS6dyT98cb23Bpn+lMyBzEriS4rB23WplzY/PbRVHqfMZYSIpq0E1rWTRT+e+/
         saJRSq0/ug1pKCIAVgdrXmDp9UrYyGyXdqpPnkjAS0NMmtMhYAFmwJInIqXydt2QbVrM
         DUPwar3qT91BBU/C4NtEcZLHzB3/3C8ujQWqh6efvmihSNPfx/VbqL6SjnMRNyw6x36F
         5WOdAjxET02e1FO0LeKv4Mfj6EmdI3xxucnaNAebdf5aDRS2l27IEDoEai3WzG9kP0uv
         ttSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7pUOWT8WZ+nXJAMbNstV8aGKgks3P9pOK+8MjvHbHs=;
        b=QZFfKWrs9N9JqESXOK/ojynC94ZcCQA7wghK7BVkW3LN/H4jJEkafhX7srW61VX3b5
         dX+puiah2oDoseT1y/YZc6bAK6v0pjEwRPrLNn15zdIH1QRiNkuctxhgaCI08I6Icb2X
         n2Nv7yiOAVP8NTISdqqInI7OyU/senyWzv2VxgFHuDrhjHd/MWiKS/l3JCpaTG6EreZr
         wkZhMpsKYiOPZhBhYBaX3Nc2T4tmUeOlXIXX5dOrABnFGnwM7HdUUS7tAYDeQXA8Al7c
         HaNpW7+P7W+nieLRCJJvo5872fVu8tPvcJazfuTxC012u2w6j+nzaFf2uVbWUNmznNrL
         qpvw==
X-Gm-Message-State: AOAM531utj3JGbGUOFydef1N1jenVNQZRto9ulwE61aMPuQ/KusQcAfJ
        TUAAs33QG2RL0h+MEq5v7EeaS2lqlT27QW+d3fQ=
X-Google-Smtp-Source: ABdhPJz4qp2HfTJuye1r4Yiuka9WBOxc6ZxgBRzWFZBc+P72JuxQZRE1pXc71fVEpjLu908Lk8koKmNeiKKM36y1TO8=
X-Received: by 2002:a02:c72e:: with SMTP id h14mr2800496jao.103.1640211286201;
 Wed, 22 Dec 2021 14:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20211111053624.190580-1-andrii@kernel.org> <20211111053624.190580-5-andrii@kernel.org>
 <YcM8eAFRIlLZmE59@krava>
In-Reply-To: <YcM8eAFRIlLZmE59@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Dec 2021 14:14:35 -0800
Message-ID: <CAEf4BzZGwUkE0aYLdVk6QaXfuv=BHFwOiJdqM=_RVm3BzNYKfw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/9] libbpf: ensure btf_dump__new() and
 btf_dump_opts are future-proof
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 22, 2021 at 6:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Nov 10, 2021 at 09:36:19PM -0800, Andrii Nakryiko wrote:
> > Change btf_dump__new() and corresponding struct btf_dump_ops structure
> > to be extensible by using OPTS "framework" ([0]). Given we don't change
> > the names, we use a similar approach as with bpf_prog_load(), but this
> > time we ended up with two APIs with the same name and same number of
> > arguments, so overloading based on number of arguments with
> > ___libbpf_override() doesn't work.
> >
> > Instead, use "overloading" based on types. In this particular case,
> > print callback has to be specified, so we detect which argument is
> > a callback. If it's 4th (last) argument, old implementation of API is
> > used by user code. If not, it must be 2nd, and thus new implementation
> > is selected. The rest is handled by the same symbol versioning approach.
> >
> > btf_ext argument is dropped as it was never used and isn't necessary
> > either. If in the future we'll need btf_ext, that will be added into
> > OPTS-based struct btf_dump_opts.
> >
> > struct btf_dump_opts is reused for both old API and new APIs. ctx field
> > is marked deprecated in v0.7+ and it's put at the same memory location
> > as OPTS's sz field. Any user of new-style btf_dump__new() will have to
> > set sz field and doesn't/shouldn't use ctx, as ctx is now passed along
> > the callback as mandatory input argument, following the other APIs in
> > libbpf that accept callbacks consistently.
> >
> > Again, this is quite ugly in implementation, but is done in the name of
> > backwards compatibility and uniform and extensible future APIs (at the
> > same time, sigh). And it will be gone in libbpf 1.0.
> >
> >   [0] Closes: https://github.com/libbpf/libbpf/issues/283
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/btf.h      | 51 ++++++++++++++++++++++++++++++++++++----
> >  tools/lib/bpf/btf_dump.c | 31 +++++++++++++++++-------
> >  tools/lib/bpf/libbpf.map |  2 ++
> >  3 files changed, 71 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index 6aae4f62ee0b..45310c65e865 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -267,15 +267,58 @@ LIBBPF_API int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, c
> >  struct btf_dump;
> >
> >  struct btf_dump_opts {
> > -     void *ctx;
> > +     union {
> > +             size_t sz;
> > +             void *ctx; /* DEPRECATED: will be gone in v1.0 */
> > +     };
> >  };
> >
> >  typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
> >
> >  LIBBPF_API struct btf_dump *btf_dump__new(const struct btf *btf,
> > -                                       const struct btf_ext *btf_ext,
> > -                                       const struct btf_dump_opts *opts,
> > -                                       btf_dump_printf_fn_t printf_fn);
> > +                                       btf_dump_printf_fn_t printf_fn,
> > +                                       void *ctx,
> > +                                       const struct btf_dump_opts *opts);
> > +
> > +LIBBPF_API struct btf_dump *btf_dump__new_v0_6_0(const struct btf *btf,
> > +                                              btf_dump_printf_fn_t printf_fn,
> > +                                              void *ctx,
> > +                                              const struct btf_dump_opts *opts);
> > +
> > +LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
> > +                                                  const struct btf_ext *btf_ext,
> > +                                                  const struct btf_dump_opts *opts,
> > +                                                  btf_dump_printf_fn_t printf_fn);
> > +
> > +/* Choose either btf_dump__new() or btf_dump__new_deprecated() based on the
> > + * type of 4th argument. If it's btf_dump's print callback, use deprecated
> > + * API; otherwise, choose the new btf_dump__new(). ___libbpf_override()
> > + * doesn't work here because both variants have 4 input arguments.
> > + *
> > + * (void *) casts are necessary to avoid compilation warnings about type
> > + * mismatches, because even though __builtin_choose_expr() only ever evaluates
> > + * one side the other side still has to satisfy type constraints (this is
> > + * compiler implementation limitation which might be lifted eventually,
> > + * according to the documentation). So passing struct btf_ext in place of
> > + * btf_dump_printf_fn_t would be generating compilation warning.  Casting to
> > + * void * avoids this issue.
> > + *
> > + * Also, two type compatibility checks for a function and function pointer are
> > + * required because passing function reference into btf_dump__new() as
> > + * btf_dump__new(..., my_callback, ...) and as btf_dump__new(...,
> > + * &my_callback, ...) (not explicit ampersand in the latter case) actually
> > + * differs as far as __builtin_types_compatible_p() is concerned. Thus two
> > + * checks are combined to detect callback argument.
> > + *
> > + * The rest works just like in case of ___libbpf_override() usage with symbol
> > + * versioning.
> > + */
> > +#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(                         \
> > +     __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||               \
> > +     __builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),  \
> > +     btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),       \
> > +     btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
>
> hi,
> this change breaks bpftrace g++ build that includes btf.h,
> because there's no typeof and __builtin_types_compatible_p in c++
>
> I guess there could be some c++ solution doing similar check,
> but I wonder we want to polute btf.h with that, I'll need to
> check on that
>
> I think I can add some detection code to bpftrace, to find out
> which version of btf_dump__new to use
>
> the build error can be generated with test_cpp.cpp below,
> so far I'm using __cplusplus ifdef in btf.h to workaround
> the issue
>
> thoughts?

This has been reported before, see [0]. I think the simplest solution
is what you did, just to opt-out on __cplusplus.

Please send the below as a proper two patches and I'll apply them and
sync to Github. Also let's add a comment explaining that
__builtin_types_compatible_p doesn't work with C++ compiler to make it
clear why we do this.

In the [0] I was proposing the following comment, feel free to reuse it.

/* C++ compilers don't support __builtin_types_compatible_p(), so at least
 * don't screw up compilation for them and let C++ users pick btf_dump__new vs
 * btf_dump__new_deprecated explicitly.
 */

  [0] https://github.com/libbpf/libbpf/issues/283#issuecomment-986100727

>
> thanks,
> jirka
>
>
> ---
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 742a2bf71c5e..bd2d77979571 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -314,11 +314,13 @@ LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
>   * The rest works just like in case of ___libbpf_override() usage with symbol
>   * versioning.
>   */
> +#ifndef __cplusplus
>  #define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(                           \
>         __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||               \
>         __builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),  \
>         btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),       \
>         btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
> +#endif
>
>  LIBBPF_API void btf_dump__free(struct btf_dump *d);
>
> diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
> index a8d2e9a87fbf..e00201de2890 100644
> --- a/tools/testing/selftests/bpf/test_cpp.cpp
> +++ b/tools/testing/selftests/bpf/test_cpp.cpp
> @@ -7,9 +7,15 @@
>
>  /* do nothing, just make sure we can link successfully */
>
> +static void dump_printf(void *ctx, const char *fmt, va_list args)
> +{
> +}
> +
>  int main(int argc, char *argv[])
>  {
> +       struct btf_dump_opts opts = { };
>         struct test_core_extern *skel;
> +       struct btf *btf;
>
>         /* libbpf.h */
>         libbpf_set_print(NULL);
> @@ -18,7 +24,8 @@ int main(int argc, char *argv[])
>         bpf_prog_get_fd_by_id(0);
>
>         /* btf.h */
> -       btf__new(NULL, 0);
> +       btf = btf__new(NULL, 0);
> +       btf_dump__new(btf, dump_printf, nullptr, &opts);
>
>         /* BPF skeleton */
>         skel = test_core_extern__open_and_load();
>

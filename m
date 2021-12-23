Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3882547E15C
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 11:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbhLWKXT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Dec 2021 05:23:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239344AbhLWKXS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Dec 2021 05:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640254998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8L9NAAUNRWZ5ctquQ/DIIrqCumuXrfZaeF3iaP7xLs=;
        b=JmLKngelWDNa2dXCU5Osp9Hq9e+suNBzCZzOAq/9JWZduI8tiLcY1lFIIeSTLq2y4lsQ6y
        jyZkxjkYIdpqEEdayxzQ6Z+m4Ich5M2PD2b28BRkwWdVzeUNuOefrLVIS0J0k4jC/gwUR3
        +SWH460lYAlJ/9QV8WB4WG1j6/VJaUQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-ZN9yuHbqMOCxtGV68JCwvw-1; Thu, 23 Dec 2021 05:23:16 -0500
X-MC-Unique: ZN9yuHbqMOCxtGV68JCwvw-1
Received: by mail-ed1-f69.google.com with SMTP id c19-20020a05640227d300b003f81c7154fbso4172568ede.7
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 02:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r8L9NAAUNRWZ5ctquQ/DIIrqCumuXrfZaeF3iaP7xLs=;
        b=lL3LgNHlCien0zmSsAkjowVwEa0F+UQXsycR66VUXcL/+hSZe4C9553gxVT61bnTPD
         DQwu4l4kvnvgAEuDp5TfFIy/bXuIp5/G/uYuYHqwOWTzLhk4BzIISJjRNxL7c1N/7AUE
         F1EqU+cJQ+tf/3qNJeyiAuGeB13eP5P/PUiUl2lc8oZJTajgRgEgUFSbQPQ538bFZSKE
         9Wzjzl1xv2BYnxhoumdJ7G2BN1YLJRP5CEraz/zXLx9+0kBnabkB793h1C9g8QjoLRCL
         ad5sd0YVbxMq36lKYHrL1NvRBDn1XBe+2T4CWurIbepBgkbpc7uVQPNxjHUPn4u0Mdx6
         Ve3A==
X-Gm-Message-State: AOAM531iqd1GcIQKjxc8CAdgHyVJwQ13Au86gfVjftpmuZlyCXkTO6Ll
        VG2OWruyLc7oar3z6c3hDY542nOHvjbMpKMrHS9GMDBNsZ95OBxJUZisGdfXhGxYq962rG0/5q3
        sZdAEjaMm0484
X-Received: by 2002:a05:6402:51cc:: with SMTP id r12mr1513063edd.92.1640254995503;
        Thu, 23 Dec 2021 02:23:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyu2m2pn8mCJ/kQD8bGlmxyOUzO/W8WjP2BWVM0zW+X+IHZEHQdMU23/MEtjPGBqg1CpuIvIA==
X-Received: by 2002:a05:6402:51cc:: with SMTP id r12mr1513054edd.92.1640254995277;
        Thu, 23 Dec 2021 02:23:15 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id y5sm1593440ejk.203.2021.12.23.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 02:23:14 -0800 (PST)
Date:   Thu, 23 Dec 2021 11:23:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/9] libbpf: ensure btf_dump__new() and
 btf_dump_opts are future-proof
Message-ID: <YcROEf9Ei3pUfuyF@krava>
References: <20211111053624.190580-1-andrii@kernel.org>
 <20211111053624.190580-5-andrii@kernel.org>
 <YcM8eAFRIlLZmE59@krava>
 <CAEf4BzZGwUkE0aYLdVk6QaXfuv=BHFwOiJdqM=_RVm3BzNYKfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZGwUkE0aYLdVk6QaXfuv=BHFwOiJdqM=_RVm3BzNYKfw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 22, 2021 at 02:14:35PM -0800, Andrii Nakryiko wrote:

SNIP

> > > +/* Choose either btf_dump__new() or btf_dump__new_deprecated() based on the
> > > + * type of 4th argument. If it's btf_dump's print callback, use deprecated
> > > + * API; otherwise, choose the new btf_dump__new(). ___libbpf_override()
> > > + * doesn't work here because both variants have 4 input arguments.
> > > + *
> > > + * (void *) casts are necessary to avoid compilation warnings about type
> > > + * mismatches, because even though __builtin_choose_expr() only ever evaluates
> > > + * one side the other side still has to satisfy type constraints (this is
> > > + * compiler implementation limitation which might be lifted eventually,
> > > + * according to the documentation). So passing struct btf_ext in place of
> > > + * btf_dump_printf_fn_t would be generating compilation warning.  Casting to
> > > + * void * avoids this issue.
> > > + *
> > > + * Also, two type compatibility checks for a function and function pointer are
> > > + * required because passing function reference into btf_dump__new() as
> > > + * btf_dump__new(..., my_callback, ...) and as btf_dump__new(...,
> > > + * &my_callback, ...) (not explicit ampersand in the latter case) actually
> > > + * differs as far as __builtin_types_compatible_p() is concerned. Thus two
> > > + * checks are combined to detect callback argument.
> > > + *
> > > + * The rest works just like in case of ___libbpf_override() usage with symbol
> > > + * versioning.
> > > + */
> > > +#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(                         \
> > > +     __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||               \
> > > +     __builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),  \
> > > +     btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),       \
> > > +     btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
> >
> > hi,
> > this change breaks bpftrace g++ build that includes btf.h,
> > because there's no typeof and __builtin_types_compatible_p in c++
> >
> > I guess there could be some c++ solution doing similar check,
> > but I wonder we want to polute btf.h with that, I'll need to
> > check on that
> >
> > I think I can add some detection code to bpftrace, to find out
> > which version of btf_dump__new to use
> >
> > the build error can be generated with test_cpp.cpp below,
> > so far I'm using __cplusplus ifdef in btf.h to workaround
> > the issue
> >
> > thoughts?
> 
> This has been reported before, see [0]. I think the simplest solution
> is what you did, just to opt-out on __cplusplus.
> 
> Please send the below as a proper two patches and I'll apply them and
> sync to Github. Also let's add a comment explaining that
> __builtin_types_compatible_p doesn't work with C++ compiler to make it
> clear why we do this.

ok, will send

thanks,
jirka

> 
> In the [0] I was proposing the following comment, feel free to reuse it.
> 
> /* C++ compilers don't support __builtin_types_compatible_p(), so at least
>  * don't screw up compilation for them and let C++ users pick btf_dump__new vs
>  * btf_dump__new_deprecated explicitly.
>  */
> 
>   [0] https://github.com/libbpf/libbpf/issues/283#issuecomment-986100727
> 
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index 742a2bf71c5e..bd2d77979571 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -314,11 +314,13 @@ LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
> >   * The rest works just like in case of ___libbpf_override() usage with symbol
> >   * versioning.
> >   */
> > +#ifndef __cplusplus
> >  #define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(                           \
> >         __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||               \
> >         __builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),  \
> >         btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),       \
> >         btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
> > +#endif
> >
> >  LIBBPF_API void btf_dump__free(struct btf_dump *d);
> >
> > diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
> > index a8d2e9a87fbf..e00201de2890 100644
> > --- a/tools/testing/selftests/bpf/test_cpp.cpp
> > +++ b/tools/testing/selftests/bpf/test_cpp.cpp
> > @@ -7,9 +7,15 @@
> >
> >  /* do nothing, just make sure we can link successfully */
> >
> > +static void dump_printf(void *ctx, const char *fmt, va_list args)
> > +{
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> > +       struct btf_dump_opts opts = { };
> >         struct test_core_extern *skel;
> > +       struct btf *btf;
> >
> >         /* libbpf.h */
> >         libbpf_set_print(NULL);
> > @@ -18,7 +24,8 @@ int main(int argc, char *argv[])
> >         bpf_prog_get_fd_by_id(0);
> >
> >         /* btf.h */
> > -       btf__new(NULL, 0);
> > +       btf = btf__new(NULL, 0);
> > +       btf_dump__new(btf, dump_printf, nullptr, &opts);
> >
> >         /* BPF skeleton */
> >         skel = test_core_extern__open_and_load();
> >
> 


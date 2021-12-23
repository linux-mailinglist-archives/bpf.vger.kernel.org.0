Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0374A47E3FC
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 14:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348567AbhLWNQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Dec 2021 08:16:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236068AbhLWNQQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Dec 2021 08:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640265374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXdBIwQMsFQy5mCxs9SMnTzDXi2hfrOPaLWtk+NtYW0=;
        b=V3gYQqCo2uigrJuyMW8p6TqFHUf1jcJB8UbMEvIeaRq43d3Ulvui8Xp//hTJuGfGFLts/u
        wJbzv9pDXMJvBsSgXObScSAyH3Kp4TTjJ/o9wBhz/XOXJzPkwIW3dg8/InAwb8eF3f7u8Q
        7sUnNg3jZ6uOeyT2c0v+7yjZptSwXXY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-gDlHdQnLP92GdQlN4_VFvQ-1; Thu, 23 Dec 2021 08:16:13 -0500
X-MC-Unique: gDlHdQnLP92GdQlN4_VFvQ-1
Received: by mail-ed1-f70.google.com with SMTP id dz8-20020a0564021d4800b003f897935eb3so4489558edb.12
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 05:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nXdBIwQMsFQy5mCxs9SMnTzDXi2hfrOPaLWtk+NtYW0=;
        b=fHTVWdc/8rrgfvpiS+ijEExsbQcPEKWobQvhTszMx77VHjKykwGd5DJKjFyLQegqIr
         VPxGp360a1lfNL6NafvAGEPMiEcgWk0EjTTfvlv2Li/HkSDzv0uZiIQOdyh7073ZOTt9
         t+b2FJWsPQciOwmSQkDC11Un5G/DQqFPfBJQDPzM/etEJX4vtilyc/Aa6RTL+8OQTJQw
         1kP4aHZFp7Bj99MdZmNx01KDGzHBL7MGrTOVpGgi0pRh11ZC+r3p1lJeAlVChxNCcqHp
         BBLkV7tpI1mYoV+PFE97o7umc3i3zV0e1s9BaHuvbVVGimcBgYIg0bLk5TF5O9RosAgY
         u2/g==
X-Gm-Message-State: AOAM532iJNrQVolxeqv56n21PZs1zxKAQsM206FuVGkWKBMUGBlLakHB
        a3ntrjcPycBWwoJPIQR73rc3T3wK31Cxy8Ci3MyTHT25FlrEbLhiloc9xtek7H0vbu3ArSkml50
        3G6OU14jkYljp
X-Received: by 2002:a17:907:3e8f:: with SMTP id hs15mr1860980ejc.340.1640265372161;
        Thu, 23 Dec 2021 05:16:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdvck44QEJLVsAyTDk1kd1vD2x1ZfVQsqnCyzxf0j264SQNAlwyXteZmn5Lekoa9b7dsrvxA==
X-Received: by 2002:a17:907:3e8f:: with SMTP id hs15mr1860959ejc.340.1640265371844;
        Thu, 23 Dec 2021 05:16:11 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id 3sm1727664ejr.20.2021.12.23.05.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 05:16:11 -0800 (PST)
Date:   Thu, 23 Dec 2021 14:16:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/9] libbpf: ensure btf_dump__new() and
 btf_dump_opts are future-proof
Message-ID: <YcR2mXO2/XBqueUo@krava>
References: <20211111053624.190580-1-andrii@kernel.org>
 <20211111053624.190580-5-andrii@kernel.org>
 <YcM8eAFRIlLZmE59@krava>
 <CAEf4BzZGwUkE0aYLdVk6QaXfuv=BHFwOiJdqM=_RVm3BzNYKfw@mail.gmail.com>
 <YcROEf9Ei3pUfuyF@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcROEf9Ei3pUfuyF@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 23, 2021 at 11:23:13AM +0100, Jiri Olsa wrote:
> On Wed, Dec 22, 2021 at 02:14:35PM -0800, Andrii Nakryiko wrote:
> 
> SNIP
> 
> > > > +/* Choose either btf_dump__new() or btf_dump__new_deprecated() based on the
> > > > + * type of 4th argument. If it's btf_dump's print callback, use deprecated
> > > > + * API; otherwise, choose the new btf_dump__new(). ___libbpf_override()
> > > > + * doesn't work here because both variants have 4 input arguments.
> > > > + *
> > > > + * (void *) casts are necessary to avoid compilation warnings about type
> > > > + * mismatches, because even though __builtin_choose_expr() only ever evaluates
> > > > + * one side the other side still has to satisfy type constraints (this is
> > > > + * compiler implementation limitation which might be lifted eventually,
> > > > + * according to the documentation). So passing struct btf_ext in place of
> > > > + * btf_dump_printf_fn_t would be generating compilation warning.  Casting to
> > > > + * void * avoids this issue.
> > > > + *
> > > > + * Also, two type compatibility checks for a function and function pointer are
> > > > + * required because passing function reference into btf_dump__new() as
> > > > + * btf_dump__new(..., my_callback, ...) and as btf_dump__new(...,
> > > > + * &my_callback, ...) (not explicit ampersand in the latter case) actually
> > > > + * differs as far as __builtin_types_compatible_p() is concerned. Thus two
> > > > + * checks are combined to detect callback argument.
> > > > + *
> > > > + * The rest works just like in case of ___libbpf_override() usage with symbol
> > > > + * versioning.
> > > > + */
> > > > +#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(                         \
> > > > +     __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||               \
> > > > +     __builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),  \
> > > > +     btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),       \
> > > > +     btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
> > >
> > > hi,
> > > this change breaks bpftrace g++ build that includes btf.h,
> > > because there's no typeof and __builtin_types_compatible_p in c++
> > >
> > > I guess there could be some c++ solution doing similar check,
> > > but I wonder we want to polute btf.h with that, I'll need to
> > > check on that
> > >
> > > I think I can add some detection code to bpftrace, to find out
> > > which version of btf_dump__new to use
> > >
> > > the build error can be generated with test_cpp.cpp below,
> > > so far I'm using __cplusplus ifdef in btf.h to workaround
> > > the issue
> > >
> > > thoughts?
> > 
> > This has been reported before, see [0]. I think the simplest solution
> > is what you did, just to opt-out on __cplusplus.
> > 
> > Please send the below as a proper two patches and I'll apply them and
> > sync to Github. Also let's add a comment explaining that
> > __builtin_types_compatible_p doesn't work with C++ compiler to make it
> > clear why we do this.
> 
> ok, will send

I see you've already provided the same patch in the github comment,
so I'll put your Signed-off-by in the patch as well

jirka

> 
> thanks,
> jirka
> 
> > 
> > In the [0] I was proposing the following comment, feel free to reuse it.
> > 
> > /* C++ compilers don't support __builtin_types_compatible_p(), so at least
> >  * don't screw up compilation for them and let C++ users pick btf_dump__new vs
> >  * btf_dump__new_deprecated explicitly.
> >  */
> > 
> >   [0] https://github.com/libbpf/libbpf/issues/283#issuecomment-986100727
> > 
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > > index 742a2bf71c5e..bd2d77979571 100644
> > > --- a/tools/lib/bpf/btf.h
> > > +++ b/tools/lib/bpf/btf.h
> > > @@ -314,11 +314,13 @@ LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
> > >   * The rest works just like in case of ___libbpf_override() usage with symbol
> > >   * versioning.
> > >   */
> > > +#ifndef __cplusplus
> > >  #define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(                           \
> > >         __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||               \
> > >         __builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),  \
> > >         btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),       \
> > >         btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
> > > +#endif
> > >
> > >  LIBBPF_API void btf_dump__free(struct btf_dump *d);
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
> > > index a8d2e9a87fbf..e00201de2890 100644
> > > --- a/tools/testing/selftests/bpf/test_cpp.cpp
> > > +++ b/tools/testing/selftests/bpf/test_cpp.cpp
> > > @@ -7,9 +7,15 @@
> > >
> > >  /* do nothing, just make sure we can link successfully */
> > >
> > > +static void dump_printf(void *ctx, const char *fmt, va_list args)
> > > +{
> > > +}
> > > +
> > >  int main(int argc, char *argv[])
> > >  {
> > > +       struct btf_dump_opts opts = { };
> > >         struct test_core_extern *skel;
> > > +       struct btf *btf;
> > >
> > >         /* libbpf.h */
> > >         libbpf_set_print(NULL);
> > > @@ -18,7 +24,8 @@ int main(int argc, char *argv[])
> > >         bpf_prog_get_fd_by_id(0);
> > >
> > >         /* btf.h */
> > > -       btf__new(NULL, 0);
> > > +       btf = btf__new(NULL, 0);
> > > +       btf_dump__new(btf, dump_printf, nullptr, &opts);
> > >
> > >         /* BPF skeleton */
> > >         skel = test_core_extern__open_and_load();
> > >
> > 


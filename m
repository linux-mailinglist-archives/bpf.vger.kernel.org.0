Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD944B98D
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 01:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhKJAN6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 19:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKJAN5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 19:13:57 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F724C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 16:11:11 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id v138so1769475ybb.8
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 16:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgncBtrXFzVCi2N9ix8ccJmBlIKp7RYtuPgzhpGd53E=;
        b=kUNT1k6Z4puctOH996IrnOzjZxX3Q9nLSN/o2f2WhafUqnEoM4w3Xhm0f7PIp+q9C9
         /+6Fer62mJkk+PcxfMW2Rk/2dagErUeRN1giwjWn39ByVNe94FU5HFcSn70GKlcomUqf
         GnAQUQSaftqErh1YB8O4qSmo7DIk9OdGPBX6PbfrFfZxi2GIye0tdrQ8O+EWfBdmggQU
         K8RyceWTC5UP8kaJbL7QfZl42WtbSAenLuykcxDamscXm05zMC+zizhEVAEswBiW1+IB
         UyW5JCRRu6nvjq++scnieIMdoEWF4qVyDMvrMBS+4vvyyAKTDUN0NXDhsx5O8UcNMWhm
         PfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgncBtrXFzVCi2N9ix8ccJmBlIKp7RYtuPgzhpGd53E=;
        b=6Z+Tw3b05ppZCnJHsaGaSJPWlHg8h1D9p6WmhVcriwZiWY9LCvpcKx0auvSKkK5Yeb
         owVPn4QzEAX6Tqbe6FchwrpY9giFXuQEnQaR6IxXlxZWicIbJBPwo2ACYdE55U9pw0Br
         W2mX/xtpBfjFSWtKGDdwn9LjRuKxopRnlWHFKt18+iehpdLQuOWjmQg4wTjEuz9nPppR
         bIn3WzHJJE0v3kyCVFOW6ZKl9qy6m042saHjPOxQtR6LQQ/0LQHbXR4qPt8Rncrms4q/
         YB/9u6HzpybJb1JuagtIkGeOi2Q1AmdW4g91Q3B5SJUPTmMARajm5ZzoO/OEwGYAqwPo
         99dA==
X-Gm-Message-State: AOAM531ANMna4dcwf/c+S527VAV/11cneKoL09jpNNeMNcTS9ECISd6I
        PrY4rmb251I6GMQFP2YT5RF00q4NPKaVW7rrRt4=
X-Google-Smtp-Source: ABdhPJzgv2sXQXRMxARmT0C+kW0Ut0bPn5tS8NPbHWvbE2KERkYjxrgLl+puwJWKJ9rxzOF2ja5/8nBtHz1XxPSnjo4=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr13073053ybt.267.1636503069401;
 Tue, 09 Nov 2021 16:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20211108061316.203217-1-andrii@kernel.org> <20211108061316.203217-7-andrii@kernel.org>
 <20211109033839.yf3v7xcbqco6fddp@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzYoF3233To8EQb3qHA_NASN+1c5Xw3WJAyMq9CBZ9N2Lg@mail.gmail.com> <20211109174048.dzovealltpr3rwcq@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211109174048.dzovealltpr3rwcq@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 9 Nov 2021 16:10:58 -0800
Message-ID: <CAEf4BzYYqTNmMeO4EDLGYf=J--DAn62C24Yr7QA71NgGGz8+fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/11] libbpf: ensure btf_dump__new() and
 btf_dump_opts are future-proof
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:40 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 09, 2021 at 07:37:48AM -0800, Andrii Nakryiko wrote:
> > On Mon, Nov 8, 2021 at 7:38 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sun, Nov 07, 2021 at 10:13:11PM -0800, Andrii Nakryiko wrote:
> > > > +#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(               \
> > > > +     __builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) +      \
> > > > +     __builtin_types_compatible_p(typeof(a4),                              \
> > > > +                                  void(void *, const char *, va_list)),    \
> > > > +     btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),\
> > > > +     btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
> > >
> > > why '+' in the above? The return type of __builtin_types_compatible_p() is bool.
> > > What is bool + bool ?
> > > It suppose to be logical 'OR', right?
> >
> > __builtin_types_compatible_p() is defined as returning 0 or 1 (not
> > true/false). And __builtin_choose_expr() is also defined as comparing
> > first argument against 0, not as true/false. But in practice it
> > doesn't matter because bool is converted to 0 or 1 in arithmetic
> > operations. So I can switch to || with no effect. Let me know if you
> > still prefer logical || and I'll change.
> >
> > But yes to your last question, it's logical OR.
>
> Interesting. Looking at LLVM code it does indeed returns 'int'.
> At least typeof(_builtin_types_compatible_p(..)) seems to be 'int'.
>
> At the same type LLVM tests are using this macro:
> #define check_same_type(type1, type2) __builtin_types_compatible_p(type1, type2) && __builtin_types_compatible_p(type1 *, type2 *)
>
> While kernel has this macro:
> #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>
> Guessing that extra typeof() may resolve the difference between fn and &fn ?

no, btf_dump_printf_fn_t is already a type and typeof() doesn't seem
to change anything. I had a test like below. It produces the same
results with or without typeof.


static void test1(btf_dump_printf_fn_t arg, int val1, int val2, int
val3, int val4)
{
        fprintf(stderr, "TEST1 VAL %d %d %d %d\n", val1, val2, val3, val4);
}

static void test2(struct btf *arg, int val1, int val2, int val3, int val4)
{
        fprintf(stderr, "TEST2 VAL %d %d %d %d\n", val1, val2, val3, val4);
}

#define test_variad(arg) \
        __builtin_choose_expr(\
                __builtin_types_compatible_p(typeof(arg),
typeof(btf_dump_printf_fn_t)) + \
                __builtin_types_compatible_p(typeof(arg),
typeof(void(void *, const char *, va_list))),\
                test1((void *)arg,\
                      __builtin_types_compatible_p(typeof(arg),
typeof(btf_dump_printf_fn_t)),\
                      __builtin_types_compatible_p(typeof(arg),
typeof(void(void *, const char *, va_list))),\
                      __builtin_types_compatible_p(typeof(arg), struct btf *),\
                      __builtin_types_compatible_p(typeof(arg), void *)\
                ), \
                test2((void *)arg,\
                      __builtin_types_compatible_p(typeof(arg),
typeof(btf_dump_printf_fn_t)),\
                      __builtin_types_compatible_p(typeof(arg),
typeof(void(void *, const char *, va_list))),\
                      __builtin_types_compatible_p(typeof(arg), struct btf *),\
                      __builtin_types_compatible_p(typeof(arg), void *)\
                )\
        )

And then I call

        test_variad(codegen_btf_dump_printf);
        test_variad(&codegen_btf_dump_printf);
        test_variad(btf);
        test_variad(NULL);


I always get this (both with and without extra typeof()):

TEST1 VAL 0 1 0 0
TEST1 VAL 1 0 0 0
TEST2 VAL 0 0 1 0
TEST2 VAL 0 0 0 1


> Not sure why LLVM took that approach.

I think kernel's __same_type() doesn't handle this well. I've changed
kernel/bpf/hashtab.c like this:

        BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
-                    (void *(*)(struct bpf_map *map, void *key))NULL));
+                    void *(struct bpf_map *map, void *key)));

And it triggered compilation assertion.

Then I "fixed" it like this:

-       BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
-                    (void *(*)(struct bpf_map *map, void *key))NULL));
+       BUILD_BUG_ON(!__same_type(__htab_map_lookup_elem,
+                    void *(struct bpf_map *map, void *key)));

And it compiled just fine. So __same_type() is sensitive to &.

>
> Anyway it will be removed once we hit 1.0, so no need to dig too deep.
> I think changing + to || is still worth doing.

ok, I'll update in next revision

>
> > >
> > > Maybe checking for ops type would be more robust ?
> >
> > opts can be NULL. At which point it's actually only compatible with
> > void *.
>
> Assuming that fn pointer in btf_dump__new_deprecated() will never be NULL?

If fn pointer is NULL, btf_dump APIs will crash in runtime. I'll add
an explicit check and error out in such case with -EINVAL.

The way the check is written right now, if someone passes NULL we'll
choose non-deprecated btf_dump__new() variant, which seems to be a
good "default" (even though it will still crash later when calling a
callback).

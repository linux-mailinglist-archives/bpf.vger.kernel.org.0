Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC96155D1A6
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiF0S3k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 14:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiF0S3X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 14:29:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC113F54
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 11:26:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so20845784ejj.12
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ldk5OwFdUhDgTCzVhEOFOSoP8hvxHWwvKsvo65xI5o=;
        b=iChmE+RQRJNRemIZOsX9GUWBP3TE6akqNw76ICZVr3BCWGlPXSdVyuMZOReVrmtOol
         EAdZUoOAAOxwQONLL44ZunIz6ygIxh9l37QcUYMX313RY4Yo4NdYGifW9YTOugvth3AE
         CYqUqpd82b7dE6GSp37wc+wu0ayyZb+PhT8w7Q1y4vywXon0f5r+LUMKS4W4CyD08Npi
         RVFL1S6TC9YNr3ZjSC1mx8l6TWp4j4+PeEMK6UGL2O5ATZuvVpd8/XZsVMzPF27HokD2
         Ez+TYCu43lP1U3QQMbOP8u8109NRpSvnYO+yKOA8NyhaqDeiwvj3F8OngKkqSzrhUzk0
         9cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ldk5OwFdUhDgTCzVhEOFOSoP8hvxHWwvKsvo65xI5o=;
        b=qm41Jtt8LcqrW8wOmisLLbRLmoU/oP6FnLxRNCCoUk6N6fQwNDPV2nR05cjzL3rAUT
         H4ydvKkmhFn1RsSf3ALIPz8uYe7xLB4Hw8C44FM/aMfqngPn72Z+leEYQZjMZ5O25ZfC
         sS1GeFsIh1Inh8buJljWOq1tCU/6k3eaxjJTQPM2M42A+w8FYkOEUoy/1XLJunvsYxri
         90luA1J8zcu6J2lKHPiUjrOQsZU+LgRauVkjFmXXLueXi+7NzMCho1f/StaXq09+nHmh
         lcKjTd923IsqOsAzdzWCPOA1WSeiBg3cLMtVjf0m8PKt6cqQB00A7qtFg8tWsdFPrUz4
         eiRQ==
X-Gm-Message-State: AJIora8HWKnuW1Qp6MOOKD0w0i2B8cOBtEKfhT6R/hrI0O7jmBpTa+2f
        X/KbZdBXnI9rKgjskQzo2QyPeny+bD/etjgqHJ0=
X-Google-Smtp-Source: AGRyM1s4ZY5zJDPiJAd1kJjNOmiwFoy8BNC/bILCAkAYU2TYc9Xd0kW52fE6KYcBzFJmvG3zKJDi8aeArkk2vLN0Twc=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr13837826ejj.302.1656354364564; Mon, 27
 Jun 2022 11:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220624045636.3668195-1-kpsingh@kernel.org> <20220624045636.3668195-3-kpsingh@kernel.org>
 <CAEf4Bza_ZWmFN0YreF7Oqj+jerGkydcJc9bKe=+DDT0LJAZLCw@mail.gmail.com> <CACYkzJ6aiw9dRrt_YLvJ3x=cok+WiKWCx+X8FkOyO=NV1HF7vA@mail.gmail.com>
In-Reply-To: <CACYkzJ6aiw9dRrt_YLvJ3x=cok+WiKWCx+X8FkOyO=NV1HF7vA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Jun 2022 11:25:52 -0700
Message-ID: <CAEf4BzboJHx6E661-nvQ2NwWqRsKs6k_F_pyEDMN31Yf9ZVHAQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/5] bpf: kfunc support for ARG_PTR_TO_CONST_STR
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Fri, Jun 24, 2022 at 6:26 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Fri, Jun 24, 2022 at 5:03 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jun 23, 2022 at 9:56 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > kfuncs can handle pointers to memory when the next argument is
> > > the size of the memory that can be read and verify these as
> > > ARG_CONST_SIZE_OR_ZERO
> > >
> > > Similarly add support for string constants (const char *) and
> > > verify it similar to ARG_PTR_TO_CONST_STR.
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  include/linux/bpf_verifier.h |  2 +
> > >  kernel/bpf/btf.c             | 25 ++++++++++
> > >  kernel/bpf/verifier.c        | 89 +++++++++++++++++++++---------------
> > >  3 files changed, 78 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 81b19669efba..f6d8898270d5 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -560,6 +560,8 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> > >                              u32 regno);
> > >  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > >                    u32 regno, u32 mem_size);
> > > +int check_const_str(struct bpf_verifier_env *env,
> > > +                   const struct bpf_reg_state *reg, int regno);
> > >
> > >  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> > >  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 668ecf61649b..b31e8d8f2d4d 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6162,6 +6162,23 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
> > >         return true;
> > >  }
> > >
> > > +static bool btf_param_is_const_str_ptr(const struct btf *btf,
> > > +                                      const struct btf_param *param)
> > > +{
> > > +       const struct btf_type *t;
> > > +
> > > +       t = btf_type_by_id(btf, param->type);
> > > +       if (!btf_type_is_ptr(t))
> > > +               return false;
> > > +
> > > +       t = btf_type_by_id(btf, t->type);
> > > +       if (BTF_INFO_KIND(t->info) != BTF_KIND_CONST)
> > > +               return false;
> > > +
> > > +       t = btf_type_skip_modifiers(btf, t->type, NULL);
> >
> > nit: this looks a bit fragile, you assume CONST comes first and then
> > skip the rest of modifiers (including typedefs). Maybe either make it
> > more permissive and then check that CONST is somewhere there in the
> > chain (you'll have to open-code btf_type_skip_modifiers() loop), or
> > make it more restrictive and say that it has to be `const char *` and
> > nothing else (no volatile, no restrict, no typedefs)?
>
> I did not bother doing that since they are kfuncs and we have a limited set of
> types, but I agree that it will confuse someone, someday. So, I updated it.
> Also, while I was at it, I moved the comment for the arg_mem_size below
> where it should have.
>
> Does this seem okay to you?
>

yep, thanks!

>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9f289b346790..a97e664e4d4d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6166,17 +6166,21 @@ static bool btf_param_is_const_str_ptr(const
> struct btf *btf,
>                                        const struct btf_param *param)
>  {
>         const struct btf_type *t;
> +       bool is_const = false;
>
>         t = btf_type_by_id(btf, param->type);
>         if (!btf_type_is_ptr(t))
>                 return false;
>
>         t = btf_type_by_id(btf, t->type);
> -       if (BTF_INFO_KIND(t->info) != BTF_KIND_CONST)
> -               return false;
> +       while (btf_type_is_modifier(t)) {
> +               if (BTF_INFO_KIND(t->info) == BTF_KIND_CONST)
> +                       is_const = true;
> +               t = btf_type_by_id(btf, t->type);
> +       }
>
> -       t = btf_type_skip_modifiers(btf, t->type, NULL);
> -       return !strcmp(btf_name_by_offset(btf, t->name_off), "char");
> +       return (is_const &&
> +               !strcmp(btf_name_by_offset(btf, t->name_off), "char"));
>  }
>
>  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> @@ -6366,12 +6370,7 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
>                         if (is_kfunc) {
>                                 bool arg_mem_size = i + 1 < nargs &&
> is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
>
> -                               /* Permit pointer to mem, but only when argument
> -                                * type is pointer to scalar, or struct composed
> -                                * (recursively) of scalars.
> -                                * When arg_mem_size is true, the pointer can be
> -                                * void *.
> -                                */
> +
>                                 if (btf_param_is_const_str_ptr(btf, &args[i])) {
>                                         err = check_const_str(env, reg, regno);
>                                         if (err < 0)
> @@ -6379,6 +6378,12 @@ static int btf_check_func_arg_match(struct
> bpf_verifier_env *env,
>                                         continue;
>                                 }
>
> +                               /* Permit pointer to mem, but only when argument
> +                                * type is pointer to scalar, or struct composed
> +                                * (recursively) of scalars.
> +                                * When arg_mem_size is true, the pointer can be
> +                                * void *.
> +                                */
>                                 if (!btf_type_is_scalar(ref_t) &&
>                                     !__btf_type_is_scalar_struct(log,
> btf, ref_t, 0) &&
>                                     (arg_mem_size ?
> !btf_type_is_void(ref_t) : 1)) {
>
>
> >
> > > +       return !strcmp(btf_name_by_offset(btf, t->name_off), "char");
> > > +}
> > > +
> >
> > [...]

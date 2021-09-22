Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB956415317
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 23:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhIVVzv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 17:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbhIVVzv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 17:55:51 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF56C061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 14:54:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 72so14920373qkk.7
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gEIBRZFBZdbhga9iVJSFwmEJLgetLJR1A7AMn5Osj8=;
        b=gHURVMJqa0E06TlsS3lqbMxr5/+3fGys1PuOskkf9+MSoQtF6ZccyoRyRAWV0/GS0Y
         Bc6Vntt/0CDt+WcDpdc8jKJkJZShXYZeHymTfZnpOw1vSVgDUN0ADfgZjm4zBRglQvht
         n6ZJRv9LpPeZga/2pdm9JFIGvDtv29uaT1BfPTx/MyhOmJl6ihorG7gW/1kP2bKWG5Cp
         okQmnOpqM/btdrbxhtS70J9uXAkIrNplAxzSCfbnp2Q/Btj06T/0YhEp79+R5UxlsMIm
         Rfd3KD+MmzbiGLh+dV+FgyomiSKXXCMQctGbD+N0UFzL1f31uKQFoga3exBZgAOSMskv
         CKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gEIBRZFBZdbhga9iVJSFwmEJLgetLJR1A7AMn5Osj8=;
        b=mzcu8skrBq+sIJbsFSIEQGXEgtAfusYUwPTc86IHbAZr59JGh/DOm2JfxJBRQVyN6r
         6/AG2tamozpmLeB8lkdJuDJnWJ1GEudWwUkbiH2Fgy7u/29WkAofEqbGKM4kPR/bNkZn
         cMGPuExtAfunJj6Ab3z4AKCm8SifhLDtXK9Y4LZQ3uPs8f5fudDMcfG4eGwzOSL1CoPp
         WW1CCe8f05+U0zuTHdXsFtBJ1O9oPn4M+Ar+zRdfAaaYgg+r2LQ426rrED30vwonJ9hS
         ABa3i1Ue7Ven54YoDPr+t1BNiGdCPvighLp4LAi+AKZLofgfCOaYo+0iL+dwI0m8A7I+
         aVWA==
X-Gm-Message-State: AOAM532pYdb/4Bw86Vpy5zAnrDIbzgK4laHNUu5lwjJUWUVopeXIpGEw
        0l9VeMBo6umvNZeTGm9EgbYv43Lz2gzQrqH5M1NYS6VD
X-Google-Smtp-Source: ABdhPJx5GlU6x3ULxsLSgKlw1U+BmENQpGKMOk7lmYS5R22O24VTdUPCPbhkuvoxc6dKfS7UOEYcCW4QyIk/qnkp9MM=
X-Received: by 2002:a25:1884:: with SMTP id 126mr1691029yby.114.1632347660223;
 Wed, 22 Sep 2021 14:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210920234320.3312820-1-andrii@kernel.org> <20210920234320.3312820-7-andrii@kernel.org>
 <78a539a7-7c1b-d9ce-e4e1-8e8fa66e04bb@fb.com>
In-Reply-To: <78a539a7-7c1b-d9ce-e4e1-8e8fa66e04bb@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 14:54:09 -0700
Message-ID: <CAEf4BzYZ+OZC82=aKwdxSHz7CQaHBe3snkZiJebSGK5sLO+ayw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/9] libbpf: refactor ELF section handler definitions
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 6:34 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/20/21 7:43 PM, Andrii Nakryiko wrote:
> > Refactor ELF section handler definitions table to use a set of flags and
> > unified SEC_DEF() macro. This allows for more succinct and table-like
> > set of definitions, and allows to more easily extend the logic without
> > adding more verbosity (this is utilized in later patches in the series).
> >
> > This approach is also making libbpf-internal program pre-load callback
> > not rely on bpf_sec_def definition, which demonstrates that future
> > pluggable ELF section handlers will be able to achieve similar level of
> > integration without libbpf having to expose extra types and APIs.
> >
> > For starters, update SEC_DEF() definitions and make them more succinct.
> > Also convert BPF_PROG_SEC() and BPF_APROG_COMPAT() definitions to
> > a common SEC_DEF() use.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 183 ++++++++++++++++-------------------------
> >  1 file changed, 73 insertions(+), 110 deletions(-)
>
> To summarize VC convo we had about this patch, you don't expect custom sec_def
> writers to necessarily follow your sec_def_flags approach, but it's a good
> demonstration that a long's worth of flags is plenty for enabling custom
> functionality. And custom sec_def writers can treat the cookie as a ptr to a
> config struct if they need something more complicated, without imposing the
> struct format on all other sec_defs.

Right.

>
> [...]
>
> > @@ -7955,15 +7965,14 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
> >               .sec = string,                                              \
> >               .prog_type = ptype,                                         \
> >               .expected_attach_type = eatype,                             \
> > -             .is_exp_attach_type_optional = eatype_optional,             \
> > -             .is_attachable = attachable,                                \
> > -             .is_attach_btf = attach_btf,                                \
> > +             .cookie = (long) (                                          \
> > +                     (eatype_optional ? SEC_EXP_ATTACH_OPT : 0) |   \
> > +                     (attachable ? SEC_ATTACHABLE : 0) |                 \
> > +                     (attach_btf ? SEC_ATTACH_BTF : 0)                   \
> > +             ),                                                          \
> >               .preload_fn = libbpf_preload_prog,                          \
> >       }
> >
> > -/* Programs that can NOT be attached. */
>
> I found this comment and APROG_COMPAT comment useful. Not as clear to me what
> SEC_NONE implies without some comment explaining or giving example. The other
> flags are more obvious to me but might be worth being explicit there as well.

I actually find that particular comment misleading and harmful, tbh.
All BPF programs are attachable to some BPF hook, it's the whole BPF
workflow. In this case it meant that these programs can't be attached
with BPF_PROG_ATTACH command of bpf() syscall. Which is technically in
a legacy mode and it is nowadays recommended to use bpf_link-based
approach instead. So this comment isn't that useful or precise
anymore.

>
> > -#define BPF_PROG_SEC(string, ptype) BPF_PROG_SEC_IMPL(string, ptype, 0, 0, 0, 0)
> > -
> >  /* Programs that can be attached. */
> >  #define BPF_APROG_SEC(string, ptype, atype) \
> >       BPF_PROG_SEC_IMPL(string, ptype, atype, true, 1, 0)
> > @@ -7976,14 +7985,11 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
> >  #define BPF_PROG_BTF(string, ptype, eatype) \
> >       BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 0, 1)
> >
> > -/* Programs that can be attached but attach type can't be identified by section
> > - * name. Kept for backward compatibility.
> > - */
> > -#define BPF_APROG_COMPAT(string, ptype) BPF_PROG_SEC(string, ptype)
> > -
> > -#define SEC_DEF(sec_pfx, ptype, ...) {                                           \
> > +#define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                     \
> >       .sec = sec_pfx,                                                     \
> >       .prog_type = BPF_PROG_TYPE_##ptype,                                 \
> > +     .expected_attach_type = atype,                                      \
> > +     .cookie = (long)(flags),                                            \
> >       .preload_fn = libbpf_preload_prog,                                  \
> >       __VA_ARGS__                                                         \
> >  }
> > @@ -7996,92 +8002,49 @@ static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
> >  static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
> >
> >  static const struct bpf_sec_def section_defs[] = {
> > -     BPF_PROG_SEC("socket",                  BPF_PROG_TYPE_SOCKET_FILTER),
> > +     SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
>
> Didn't know how strictly you felt about checkpatch line-length complaints,
> won't comment on them further since you mentioned 100 chars being the new
> standard. But would complain about the alignment here and elsewhere in
> changes to section_defs even if checkpatch didn't exist :)

the goal here was to have one entry per line for quick and easy
overview of all supported section definitions

>
> >       BPF_EAPROG_SEC("sk_reuseport/migrate",  BPF_PROG_TYPE_SK_REUSEPORT,
> >                                               BPF_SK_REUSEPORT_SELECT_OR_MIGRATE),
> >       BPF_EAPROG_SEC("sk_reuseport",          BPF_PROG_TYPE_SK_REUSEPORT,
> >                                               BPF_SK_REUSEPORT_SELECT),
>
> [...]

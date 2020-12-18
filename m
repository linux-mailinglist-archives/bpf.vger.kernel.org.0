Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211BE2DE9F1
	for <lists+bpf@lfdr.de>; Fri, 18 Dec 2020 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgLRTxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Dec 2020 14:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgLRTxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Dec 2020 14:53:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C1C0617A7
        for <bpf@vger.kernel.org>; Fri, 18 Dec 2020 11:52:31 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id a16so2974894ybh.5
        for <bpf@vger.kernel.org>; Fri, 18 Dec 2020 11:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGf7i30IEkmqKcwLL72Ab3QRHApgDm93l44T5mMltuQ=;
        b=PnTGetishi75w6Gz7cY+ZMs1wf7RbZI8WVsKI9aL6ocjPAfjwLFlCZs3NIbkuf1xwi
         1jJs8xciMM4X5bMSGoREdH2shKZB4JaiBJY/tEkA7SSUihmRt4twfjJuo91uRGKXv9n3
         FTfjjRuNGtR7MJswKvXwHhep60ZH4EG59csyTHVsoO1OaaFXwCfusK/7eZ/re0tyD21c
         BybHHD2P1PeVgUilPBrawqtGxLyxxdaC9iLDKvRGBnVsv72soOJx2MTLR229EXe4KEoF
         orp+j7JTSgPerGibMLr4H+VdQdbQkj4LU7mzExokp5CGuM7bLxSV6hYTzzookAEUa7rA
         TJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGf7i30IEkmqKcwLL72Ab3QRHApgDm93l44T5mMltuQ=;
        b=LLHTYrq1N9AU2VRTzQ3eZhHgd4qxtFAHpj9zznb3KO+glmaMwWjNRc7hMTpdGdQvTV
         h9kEskYN2qsLDyB52MndStaZBdZ2A6NSjI/xkhB41LywaarrPG1wzXqQ2VXUY55OlxVq
         U/EtGa7Qi8/HgiXKsrmNGTpi86U0eqXc4zsTQDWqDBcas6PTMMr2DQr7namASA9ZMPlu
         zTwV0eCpmIlV4M3fYQbGH4t2NsHJv/bt1iShnPVEemGx8OwLy53Guo23nTeK42sgZVkd
         LADi9bPkI8JpIxQBC9Y6kmIOMCn7h2Vlu7PPBnPbVEDiqTBKkcspEpvdH9p1DxTHwFzS
         WRsw==
X-Gm-Message-State: AOAM5313qOSEl1N4xj5feCR2DCfV1mqLnbeYqpaeh01OeqlFedHFyM1m
        br2oCSvHbWHPcufnxC+428cCdJ3LsK4N6XCclgA=
X-Google-Smtp-Source: ABdhPJz7y6yY607g16zDrCr7qvdTLPcgDBAAsbWupBhrPhS7F3Go+VNHXdhjJ909PCNNMe5TIdC82Fohg3mDLeAkV7M=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr8111502ybe.403.1608321150845;
 Fri, 18 Dec 2020 11:52:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607973529.git.me@ubique.spb.ru> <5e2ca46ecadda0bde060a7cc0da7edba746b68da.1607973529.git.me@ubique.spb.ru>
 <CAEf4BzY3RaxvPcmQkTYsDa8MB+v6XpWuftdZEkFfgVVKgeLPbQ@mail.gmail.com> <20201217061307.e4m7ezbc73ga7lke@amnesia>
In-Reply-To: <20201217061307.e4m7ezbc73ga7lke@amnesia>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 18 Dec 2020 11:52:20 -0800
Message-ID: <CAEf4BzZ-6ocyCASKt8r-q=GY2WY4u_bs+ybb2F5Q7ph+sfxDBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Support pointer to struct in global
 func args
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 16, 2020 at 10:13 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> On Wed, Dec 16, 2020 at 03:35:41PM -0800, Andrii Nakryiko wrote:
> > On Mon, Dec 14, 2020 at 11:53 AM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
> > >
> > > Add an ability to pass a pointer to a struct in arguments for a global
> > > function. The struct may not have any pointers as it isn't possible to
> > > verify them in a general case.
> > >
> >
> > If such a passed struct has a field which is a pointer, will it
> > immediately reject the program, or that field is just going to be
> > treated as an unknown scalar. The latter makes most sense and if the
> > verifier behaves like that already, it would be good to clarify that
> > here.
>
> Such a field is treated as an unknown scalar.
>

Cool. That's great, please reword the commit then to make this clear.
It sounds like passing a struct with a pointer field won't work at
all, even if no one is reading that field. Scary stuff :)

>
> >
> > > Passing a struct pointer to a global function allows to overcome the
> > > limit on maximum number of arguments and avoid expensive and tricky
> > > workarounds.
> > >
> > > The implementation consists of two parts: if a global function has an
> > > argument that is a pointer to struct then:
> > >   1) In btf_check_func_arg_match(): check that the corresponding
> > > register points to NULL or to a valid memory region that is large enough
> > > to contain the struct.
> > >   2) In btf_prepare_func_args(): set the corresponding register type to
> > > PTR_TO_MEM_OR_NULL and its size to the size of the struct.
> > >
> > > Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> > > ---
> > >  include/linux/bpf_verifier.h |  2 ++
> > >  kernel/bpf/btf.c             | 59 +++++++++++++++++++++++++++++++-----
> > >  kernel/bpf/verifier.c        | 30 ++++++++++++++++++
> > >  3 files changed, 83 insertions(+), 8 deletions(-)
> > >

[...]

> >
> > With the above change, this would be better to adjust to look like an
> > expected, but not supported case (E.g., "Arg is not supported because
> > it's impossible to determine the size of accessed memory" or something
> > along those lines).
> >
> > A small surprising bit:
> >
> > int foo(char arr[123]) { return arr[0]; }
> >
> > would be legal, but arr[1] not. Which is a C type system quirk, but
> > it's probably fine to allow.
>
> If an array size is known at compile time then it should be
> possible to use pointer to array type and support access to the
> entire array:
>
> int foo (char (*arr)[123]) { return arr[1]; }

well, even better then

>
>
> >
> >
> > > +                                               tname, PTR_ERR(ret));
> > > +                                       return -EINVAL;
> > > +                               }
> > > +
> > > +                               reg[i + 1].type = PTR_TO_MEM_OR_NULL;
> > > +                               reg[i + 1].id = i + 1;
> >
> > this reg[i + 1] addressing is error-prone and verbose, let's just have
> > a local pointer variable? Probably would want to rename `struct
> > bpf_reg_state *reg` to regs.
> >
> > > +
> > > +                               continue;
> > > +                       }
> > >                 }
> > >                 bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
> > >                         i, btf_kind_str[BTF_INFO_KIND(t->info)], tname);
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index dee296dbc7a1..a08f85fffdb2 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3886,6 +3886,29 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> > >         }
> > >  }
> > >
> > > +int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > +                 int regno, u32 mem_size)
> > > +{
> > > +       if (register_is_null(reg))
> > > +               return 0;
> > > +
> > > +       if (reg_type_may_be_null(reg->type)) {
> >
> > this looks wrong, we expect the register to be PTR_TO_MEM or
> > PTR_TO_MEM_OR_NULL here. So any other NU
>
> check_mem_reg() is called from btf_check_func_arg_match() which
> is called from check_func_call() which is called when the
> verifier encounters BPF_CALL(from calle). For example it should
> be possible to pass a return value of bpf_map_lookup_elem()
> directly to a global function. Without any additional checks in
> callee the type of a register would be PTR_TO_MAP_VALUE_OR_NULL.
>
> In other words the goal of check_mem_reg() is to ensure that a
> register has a value that points to NULL or any valid memory
> region(PTR_TO_STACK, PTR_TO_MAP_VALUE etc.). If a register has a
> nullable type we temporarly convert the register type to its
> corresponding type with a value and check if the access would be
> safe.
>
> A caller works just with PTR_TO_MEM_OR_NULL which abstracts all
> the possible underlying types. btf_prepare_func_args() prepares
> registers on entry to a verification of a global function.
>
> A callee handles all the possible types of a register while a
> caller uses PTR_TO_MEM_OR_NULL only.

Yeah, you are right. mem register is not just PTR_TO_MEM_OR_NULL. I
now remember I actually saw that in verifier.c later while reviewing
the rest of your code and was a bit surprised initially, but it looked
sensible. Just forgot to remove this comment, sorry.


>
>
> >
> > > +               const struct bpf_reg_state saved_reg = *reg;
> >
> > this saving and restoring of the original state due to
> > mark_ptr_not_null_reg() is a bit ugly. Maybe it's better to refactor
> > mark_ptr_not_null_reg to just return a new register type on success or
> > 0 (NOT_INIT) on failure? Then you won't have to do this.
>
> It is not enough just to convert register's type - e.g. we also
> want to change map_ptr to map->inner_map_meta for a case of
> PTR_TO_MAP_VALUE_OR_NULL and inner_map_meta because it may be
> used in check_helper_mem_access() -> check_map_access().


Yep, missed that part in patch #1. But thinking about this more, I'm
now missing the point of saving and restoring the register state. A
comment would be welcome here, if it's really needed. I.e., if
mark_ptr_not_null_reg fails, it doesn't change the state of the
register. If check_helper_mem_access fails and changes the sate, then
you have a similar problem few lines below anyway. So what's the case
when check_helper_mem_access() succeeds and changes register state,
but you still need to restore the register?

>
>
> >
> > > +               int rv;
> > > +
> > > +               if (mark_ptr_not_null_reg(reg)) {
> > > +                       verbose(env, "R%d type=%s expected nullable\n", regno,
> > > +                               reg_type_str[reg->type]);
> > > +                       return -EINVAL;
> > > +               }
> > > +               rv = check_helper_mem_access(env, regno, mem_size, 1, NULL);
> > > +               *reg = saved_reg;
> > > +               return rv;
> > > +       }
> > > +
> > > +       return check_helper_mem_access(env, regno, mem_size, 1, NULL);
> >
> >
> > here and above, use true instead of 1, it's a bool argument, not
> > integer, super confusing
> >
> > > +}
> > > +
> > >  /* Implementation details:
> > >   * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
> > >   * Two bpf_map_lookups (even with the same key) will have different reg->id.
> > > @@ -11435,6 +11458,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
> > >                                 mark_reg_known_zero(env, regs, i);
> > >                         else if (regs[i].type == SCALAR_VALUE)
> > >                                 mark_reg_unknown(env, regs, i);
> > > +                       else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
> > > +                               const u32 mem_size = regs[i].mem_size;
> > > +
> > > +                               mark_reg_known_zero(env, regs, i);
> > > +                               regs[i].mem_size = mem_size;
> > > +                               regs[i].id = i;
> >
> > I don't think we need to set id, we don't use that for PTR_TO_MEM registers.
>
> If we don't set id then in check_cond_jump_id() ->
> mark_ptr_or_null_regs() -> mark_ptr_or_null_reg() we don't
> transform register type either to SCALAR(NULL case) or
> PTR_TO_MEM(value case):
> ...
> if (reg_type_may_be_null(reg->type) && reg->id == id &&
> ...
>
> The end result is that the verifier mem access checks fail for a
> PTR_TO_MEM_OR_NULL register.

Hm... I see now. I was looking at check_helper_call() and handling of
RET_PTR_TO_ALLOC_MEM_OR_NULL return result for bpf_ringbuf_reserve().
It didn't seem to set id at all and yet works just fine. But now I see
extra

if (reg_type_may_be_null(regs[BPF_REG_0].type))
    regs[BPF_REG_0].id = ++env->id_gen;

after the big if/else if block there, so it makes sense. Thanks.


regs[i].id = i; might not be wrong, but is unconventional, so let's
stick with `++env->id_gen`?


>
>
> >
> > > +                       }
> > >                 }
> > >         } else {
> > >                 /* 1st arg to a function */
> > > --
> > > 2.25.1
> > >
>
> --
>
> Dmitrii Banshchikov

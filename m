Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5317861A
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 00:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgCCXDh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 18:03:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40500 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgCCXDh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 18:03:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so5223727qka.7;
        Tue, 03 Mar 2020 15:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ULQ8Ww0+zX2XI5Cz9WZdhm5XRSdywFUQRM8EyK7ZIlk=;
        b=jzQlv0ijPviWdjpZX9KaKbCYdr9QLqShtXay6oEFPIGMt06YzQADwwIV6ulDB2ygV4
         y/jWCTlKAhUSSid4e0ZwSIdXyG9uLtVA/sLHrj90rwlo1hGw93cBxuFko0n9K7nDV9RJ
         fZvKBsBh+WAHoFwQ1du5kZI8SB3ed0Nvgpv6Ff+HC/MffCDP61Pa8H37vUvdsppch5wW
         a/5PkbPgMYmWw9+0OZqccGsJ41q6OeDy51Z5tM82ZOdDhZR94B8ApwtB+LKTB9P2Zc9W
         uTr/pNwqaEu7YCHtwIHIxptF/qJiw2de7GNp2Hu9eOa8uEui1onevbXjzOZcNm2fn3Kb
         D/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ULQ8Ww0+zX2XI5Cz9WZdhm5XRSdywFUQRM8EyK7ZIlk=;
        b=Js+apCyNab3x59Clz67vBT9iCaiiQWxLIPKDFonQytetbDtyLV27ngTLgNNfdhD8vt
         PvYcvNDgewhuEuj/MUo/VKRki2346L2HAyMMQUzDT09WV/ppRsLxKVNlH7xf6uK+h64U
         gce7Fd4nDDg4j5T0P0Hzbktf/85/2YuCbiaM9o90fKNlJtUDMhSDUiBr7O6YXgbiIU6i
         yI4D48D+WuVPov78Q+HGJWEa6PU62rikMin4zDi/EdAFhBEdQ+daerH9wL4qZffIND8L
         FXE67gk4N7FuEiBUSzFmVMc9Hxd6hv93F+MgZjztsPRtfiykMvNMwS8ooV9dZaBdtMGr
         FSpg==
X-Gm-Message-State: ANhLgQ2Sk2nPknMzIBGb0tFn0CO8qbMZgUgPEFLRpjMDH3F9XoIP9DbR
        JPmOD4yJz8/1ko/eB+xdsmQBiT38Dq2/JG+AZs8=
X-Google-Smtp-Source: ADFU+vtidiVlDFkCmPxOE1YEArwXhR3v+doHtIdn8TMG8RnR30gklEBC78oFMTsDj2ILlPjM8ri1bPeGxg0mjmJ7DOQ=
X-Received: by 2002:a37:6716:: with SMTP id b22mr345307qkc.437.1583276615676;
 Tue, 03 Mar 2020 15:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org> <20200303140950.6355-2-kpsingh@chromium.org>
 <CAEf4BzZj1+G7D2eZ9Enp_FtmmNPEkX7f6BDj2q=iZ1D8ZxxTMQ@mail.gmail.com> <20200303222433.GA3272@chromium.org>
In-Reply-To: <20200303222433.GA3272@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 15:03:24 -0800
Message-ID: <CAEf4BzZey65RjDtAWojvtnakQgNiids4x8R-Hak6pZW1BqUfaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Refactor trampoline update code
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 2:24 PM KP Singh <kpsingh@chromium.org> wrote:
>
> On 03-M=C3=A4r 14:12, Andrii Nakryiko wrote:
> > On Tue, Mar 3, 2020 at 6:13 AM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > As we need to introduce a third type of attachment for trampolines, t=
he
> > > flattened signature of arch_prepare_bpf_trampoline gets even more
> > > complicated.
> > >
> > > Refactor the prog and count argument to arch_prepare_bpf_trampoline t=
o
> > > use bpf_tramp_progs to simplify the addition and accounting for new
> > > attachment types.
> > >
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 31 +++++++++---------
> > >  include/linux/bpf.h         | 13 ++++++--
> > >  kernel/bpf/bpf_struct_ops.c | 13 +++++++-
> > >  kernel/bpf/trampoline.c     | 63 +++++++++++++++++++++--------------=
--
> > >  4 files changed, 75 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index 9ba08e9abc09..15c7d28bc05c 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -1362,12 +1362,12 @@ static void restore_regs(const struct btf_fun=
c_model *m, u8 **prog, int nr_args,
> > >  }
> > >
> > >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> > > -                     struct bpf_prog **progs, int prog_cnt, int stac=
k_size)
> > > +                     struct bpf_tramp_progs *tp, int stack_size)
> >
> > nit: it's `tp` here, but `tprogs` in arch_prepare_bpf_trampoline. It's
> > minor, but would be nice to stick to consistent naming.
>
> I did this to ~distinguish~ that rather than being an array of
> tprogs it's a pointer to one of its members e.g.
> &tprogs[BPF_TRAMP_FEXIT]).
>
> I change it if you feel this is not a valuable disntinction.

I think it's important distinction, but naming doesn't really help
with it... Not sure how you can make it more clear, though.
>
> >
> > >  {
> > >         u8 *prog =3D *pprog;
> > >         int cnt =3D 0, i;
> > >
> > > -       for (i =3D 0; i < prog_cnt; i++) {
> > > +       for (i =3D 0; i < tp->nr_progs; i++) {
> > >                 if (emit_call(&prog, __bpf_prog_enter, prog))
> > >                         return -EINVAL;
> > >                 /* remember prog start time returned by __bpf_prog_en=
ter */
> > > @@ -1376,17 +1376,17 @@ static int invoke_bpf(const struct btf_func_m=
odel *m, u8 **pprog,
> > >                 /* arg1: lea rdi, [rbp - stack_size] */
> > >                 EMIT4(0x48, 0x8D, 0x7D, -stack_size);
> > >                 /* arg2: progs[i]->insnsi for interpreter */
> > > -               if (!progs[i]->jited)
> > > +               if (!tp->progs[i]->jited)
> > >                         emit_mov_imm64(&prog, BPF_REG_2,
> > > -                                      (long) progs[i]->insnsi >> 32,
> > > -                                      (u32) (long) progs[i]->insnsi)=
;
> > > +                                      (long) tp->progs[i]->insnsi >>=
 32,
> > > +                                      (u32) (long) tp->progs[i]->ins=
nsi);
> > >                 /* call JITed bpf program or interpreter */
> > > -               if (emit_call(&prog, progs[i]->bpf_func, prog))
> > > +               if (emit_call(&prog, tp->progs[i]->bpf_func, prog))
> > >                         return -EINVAL;
> > >
> > >                 /* arg1: mov rdi, progs[i] */
> > > -               emit_mov_imm64(&prog, BPF_REG_1, (long) progs[i] >> 3=
2,
> > > -                              (u32) (long) progs[i]);
> > > +               emit_mov_imm64(&prog, BPF_REG_1, (long) tp->progs[i] =
>> 32,
> > > +                              (u32) (long) tp->progs[i]);
> > >                 /* arg2: mov rsi, rbx <- start time in nsec */
> > >                 emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
> > >                 if (emit_call(&prog, __bpf_prog_exit, prog))
> > > @@ -1458,12 +1458,13 @@ static int invoke_bpf(const struct btf_func_m=
odel *m, u8 **pprog,
> > >   */
> > >  int arch_prepare_bpf_trampoline(void *image, void *image_end,
> > >                                 const struct btf_func_model *m, u32 f=
lags,
> > > -                               struct bpf_prog **fentry_progs, int f=
entry_cnt,
> > > -                               struct bpf_prog **fexit_progs, int fe=
xit_cnt,
> > > +                               struct bpf_tramp_progs *tprogs,
> > >                                 void *orig_call)
> > >  {
> > >         int cnt =3D 0, nr_args =3D m->nr_args;
> > >         int stack_size =3D nr_args * 8;
> > > +       struct bpf_tramp_progs *fentry =3D &tprogs[BPF_TRAMP_FENTRY];
> > > +       struct bpf_tramp_progs *fexit =3D &tprogs[BPF_TRAMP_FEXIT];
> > >         u8 *prog;
> > >
> > >         /* x86-64 supports up to 6 arguments. 7+ can be added in the =
future */
> >
> > [...]
> >
> > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.=
c
> > > index c498f0fffb40..a011a77b21fa 100644
> > > --- a/kernel/bpf/bpf_struct_ops.c
> > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > @@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct =
bpf_map *map, void *key,
> > >         struct bpf_struct_ops_value *uvalue, *kvalue;
> > >         const struct btf_member *member;
> > >         const struct btf_type *t =3D st_ops->type;
> > > +       struct bpf_tramp_progs *tprogs =3D NULL;
> > >         void *udata, *kdata;
> > >         int prog_fd, err =3D 0;
> > >         void *image;
> > > @@ -425,10 +426,19 @@ static int bpf_struct_ops_map_update_elem(struc=
t bpf_map *map, void *key,
> > >                         goto reset_unlock;
> > >                 }
> > >
> > > +               tprogs =3D kcalloc(BPF_TRAMP_MAX, sizeof(struct bpf_t=
ramp_progs),
> >
> > nit: sizeof(*tprogs) ?
>
> Sure. I can fix it.
>
> >
> > > +                                GFP_KERNEL);
> > > +               if (!tprogs) {
> > > +                       err =3D -ENOMEM;
> > > +                       goto reset_unlock;
> > > +               }
> > > +
> > > +               *tprogs[BPF_TRAMP_FENTRY].progs =3D prog;
> >
> > I'm very confused what's going on here, why * at the beginning here,
> > but no * below?.. It seems unnecessary.
>
> The progs member of bpf_tramp_progs is
>
>   struct bpf_tramp_progs {
>         struct bpf_prog *progs[BPF_MAX_TRAMP_PROGS];
>         int nr_progs;
>   };
>
> Equivalent to the **progs we had before in the signature of
> arch_prepare_bpf_trampoline.
>
>     *tprogs[BPF_TRAMP_FENTRY].progs =3D prog;
>
> is setting the program in the **progs. The one below is setting the
> count. Am I missing something :)

Ok, so it's setting entry 0 in bpf_tramp_progs->progs array, right?
Wouldn't it be less mind-bending and confusing written this way:

tprogs[BPF_TRAMP_FENTRY].progs[0] =3D prog;

?

Syntax you used treats fixed-length progs array as a pointer, which is
valid C, but not the best C either.

>
> >
> > > +               tprogs[BPF_TRAMP_FENTRY].nr_progs =3D 1;
> > >                 err =3D arch_prepare_bpf_trampoline(image,
> > >                                                   st_map->image + PAG=
E_SIZE,
> > >                                                   &st_ops->func_model=
s[i], 0,
> > > -                                                 &prog, 1, NULL, 0, =
NULL);
> > > +                                                 tprogs, NULL);
> > >                 if (err < 0)
> > >                         goto reset_unlock;
> > >
> > > @@ -469,6 +479,7 @@ static int bpf_struct_ops_map_update_elem(struct =
bpf_map *map, void *key,
> > >         memset(uvalue, 0, map->value_size);
> > >         memset(kvalue, 0, map->value_size);
> > >  unlock:
> > > +       kfree(tprogs);
> > >         mutex_unlock(&st_map->lock);
> > >         return err;
> > >  }
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 704fa787fec0..9daeb094f054 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -190,40 +190,50 @@ static int register_fentry(struct bpf_trampolin=
e *tr, void *new_addr)
> > >         return ret;
> > >  }
> > >
> > > -/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit=
 is ~50
> > > - * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
> > > - */
> > > -#define BPF_MAX_TRAMP_PROGS 40
> > > +static struct bpf_tramp_progs *
> > > +bpf_trampoline_update_progs(struct bpf_trampoline *tr, int *total)
> > > +{
> > > +       struct bpf_tramp_progs *tprogs;
> > > +       struct bpf_prog **progs;
> > > +       struct bpf_prog_aux *aux;
> > > +       int kind;
> > > +
> > > +       *total =3D 0;
> > > +       tprogs =3D kcalloc(BPF_TRAMP_MAX, sizeof(struct bpf_tramp_pro=
gs),
> >
> > same nit as above, sizeof(*tprogs) is shorter and less error-prone
>
> Sure, can fix it.
>
> - KP
>
> >
> > > +                        GFP_KERNEL);
> > > +       if (!tprogs)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       for (kind =3D 0; kind < BPF_TRAMP_MAX; kind++) {
> > > +               tprogs[kind].nr_progs =3D tr->progs_cnt[kind];
> > > +               *total +=3D tr->progs_cnt[kind];
> > > +               progs =3D tprogs[kind].progs;
> > > +
> > > +               hlist_for_each_entry(aux, &tr->progs_hlist[kind], tra=
mp_hlist)
> > > +                       *progs++ =3D aux->prog;
> > > +       }
> > > +       return tprogs;
> > > +}
> > >
> >
> > [...]

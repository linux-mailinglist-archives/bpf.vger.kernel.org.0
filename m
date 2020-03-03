Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA07B178591
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCCWYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:24:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42553 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgCCWYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:24:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id z11so6447801wro.9
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=40e6DTgB56dV3R1i2G6eE8mEU0qiesh3B85VcDut/6w=;
        b=K2kLOtZWxXcIALYynzYEtgquSgGMsiizyUYYZ6xj7d2/PdrJFdzOTaIt8I77jUmUiN
         Vd/LiHU3MyrpnGkqEbw6r7wuHRSC//daMbpfBeD5lF/rpbrHpFWDgfxx0ylp1YIyHITj
         ihLOqF5FQ4nHDLTGDpLjwdvy0NcT4+uQQsBuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=40e6DTgB56dV3R1i2G6eE8mEU0qiesh3B85VcDut/6w=;
        b=C790rz02uwQ/z9Wt3KLtjDyeqqQ0ElXlMwwisSvOUP7DXKrnrBouZwGFe1Uz90Udrt
         Li7MPtlAJzgKjcjgf8o0lTdPEelg+YzsdrLju6LVDpeAm0yKKPybFKsYOrCoEaLYoNxh
         WR/Oy9X5sBwR3pA0ByRrFIl3NOSKFHqfD2g6C2pOKVjhF89MUacRD6dMML51n5X9RtBb
         Gg0Mgn3W8AcHCLJuDtl5P7oKI5vJhCmihI+GRyRv1kJrvTVZzzQkhYO7ywh+3NZ1P5iM
         1IZdt7euyIMQLyDXy0mwRXj3KI1v2Az9pe3jYukJ+L/82hmlRt8BNzJg/AMJN9ot7p4l
         LIzQ==
X-Gm-Message-State: ANhLgQ1fp+p/TL6WhsuUV8bpW4EaE1iYO6D1r+jaBWbu710BT/httkkG
        MQhgYP7cXSS5CsdQXwZNhsNjAQ==
X-Google-Smtp-Source: ADFU+vt2ZN0HOeF5zQmhWJCP/7siB5Sn6+j4aXz6yTM1e4COWJpXgO3qTtK/v6YpOsw3o8fymTshTQ==
X-Received: by 2002:adf:ebca:: with SMTP id v10mr163109wrn.307.1583274275715;
        Tue, 03 Mar 2020 14:24:35 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id i204sm731361wma.44.2020.03.03.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:24:35 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 3 Mar 2020 23:24:33 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 1/7] bpf: Refactor trampoline update code
Message-ID: <20200303222433.GA3272@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-2-kpsingh@chromium.org>
 <CAEf4BzZj1+G7D2eZ9Enp_FtmmNPEkX7f6BDj2q=iZ1D8ZxxTMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZj1+G7D2eZ9Enp_FtmmNPEkX7f6BDj2q=iZ1D8ZxxTMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 14:12, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 6:13 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > As we need to introduce a third type of attachment for trampolines, the
> > flattened signature of arch_prepare_bpf_trampoline gets even more
> > complicated.
> >
> > Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> > use bpf_tramp_progs to simplify the addition and accounting for new
> > attachment types.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 31 +++++++++---------
> >  include/linux/bpf.h         | 13 ++++++--
> >  kernel/bpf/bpf_struct_ops.c | 13 +++++++-
> >  kernel/bpf/trampoline.c     | 63 +++++++++++++++++++++----------------
> >  4 files changed, 75 insertions(+), 45 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 9ba08e9abc09..15c7d28bc05c 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1362,12 +1362,12 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
> >  }
> >
> >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> > -                     struct bpf_prog **progs, int prog_cnt, int stack_size)
> > +                     struct bpf_tramp_progs *tp, int stack_size)
> 
> nit: it's `tp` here, but `tprogs` in arch_prepare_bpf_trampoline. It's
> minor, but would be nice to stick to consistent naming.

I did this to ~distinguish~ that rather than being an array of
tprogs it's a pointer to one of its members e.g.
&tprogs[BPF_TRAMP_FEXIT]).

I change it if you feel this is not a valuable disntinction.

> 
> >  {
> >         u8 *prog = *pprog;
> >         int cnt = 0, i;
> >
> > -       for (i = 0; i < prog_cnt; i++) {
> > +       for (i = 0; i < tp->nr_progs; i++) {
> >                 if (emit_call(&prog, __bpf_prog_enter, prog))
> >                         return -EINVAL;
> >                 /* remember prog start time returned by __bpf_prog_enter */
> > @@ -1376,17 +1376,17 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> >                 /* arg1: lea rdi, [rbp - stack_size] */
> >                 EMIT4(0x48, 0x8D, 0x7D, -stack_size);
> >                 /* arg2: progs[i]->insnsi for interpreter */
> > -               if (!progs[i]->jited)
> > +               if (!tp->progs[i]->jited)
> >                         emit_mov_imm64(&prog, BPF_REG_2,
> > -                                      (long) progs[i]->insnsi >> 32,
> > -                                      (u32) (long) progs[i]->insnsi);
> > +                                      (long) tp->progs[i]->insnsi >> 32,
> > +                                      (u32) (long) tp->progs[i]->insnsi);
> >                 /* call JITed bpf program or interpreter */
> > -               if (emit_call(&prog, progs[i]->bpf_func, prog))
> > +               if (emit_call(&prog, tp->progs[i]->bpf_func, prog))
> >                         return -EINVAL;
> >
> >                 /* arg1: mov rdi, progs[i] */
> > -               emit_mov_imm64(&prog, BPF_REG_1, (long) progs[i] >> 32,
> > -                              (u32) (long) progs[i]);
> > +               emit_mov_imm64(&prog, BPF_REG_1, (long) tp->progs[i] >> 32,
> > +                              (u32) (long) tp->progs[i]);
> >                 /* arg2: mov rsi, rbx <- start time in nsec */
> >                 emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
> >                 if (emit_call(&prog, __bpf_prog_exit, prog))
> > @@ -1458,12 +1458,13 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> >   */
> >  int arch_prepare_bpf_trampoline(void *image, void *image_end,
> >                                 const struct btf_func_model *m, u32 flags,
> > -                               struct bpf_prog **fentry_progs, int fentry_cnt,
> > -                               struct bpf_prog **fexit_progs, int fexit_cnt,
> > +                               struct bpf_tramp_progs *tprogs,
> >                                 void *orig_call)
> >  {
> >         int cnt = 0, nr_args = m->nr_args;
> >         int stack_size = nr_args * 8;
> > +       struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
> > +       struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
> >         u8 *prog;
> >
> >         /* x86-64 supports up to 6 arguments. 7+ can be added in the future */
> 
> [...]
> 
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index c498f0fffb40..a011a77b21fa 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> >         struct bpf_struct_ops_value *uvalue, *kvalue;
> >         const struct btf_member *member;
> >         const struct btf_type *t = st_ops->type;
> > +       struct bpf_tramp_progs *tprogs = NULL;
> >         void *udata, *kdata;
> >         int prog_fd, err = 0;
> >         void *image;
> > @@ -425,10 +426,19 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> >                         goto reset_unlock;
> >                 }
> >
> > +               tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(struct bpf_tramp_progs),
> 
> nit: sizeof(*tprogs) ?

Sure. I can fix it.

> 
> > +                                GFP_KERNEL);
> > +               if (!tprogs) {
> > +                       err = -ENOMEM;
> > +                       goto reset_unlock;
> > +               }
> > +
> > +               *tprogs[BPF_TRAMP_FENTRY].progs = prog;
> 
> I'm very confused what's going on here, why * at the beginning here,
> but no * below?.. It seems unnecessary.

The progs member of bpf_tramp_progs is

  struct bpf_tramp_progs {
	struct bpf_prog *progs[BPF_MAX_TRAMP_PROGS];
	int nr_progs;
  };

Equivalent to the **progs we had before in the signature of
arch_prepare_bpf_trampoline.

    *tprogs[BPF_TRAMP_FENTRY].progs = prog;

is setting the program in the **progs. The one below is setting the
count. Am I missing something :)

> 
> > +               tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
> >                 err = arch_prepare_bpf_trampoline(image,
> >                                                   st_map->image + PAGE_SIZE,
> >                                                   &st_ops->func_models[i], 0,
> > -                                                 &prog, 1, NULL, 0, NULL);
> > +                                                 tprogs, NULL);
> >                 if (err < 0)
> >                         goto reset_unlock;
> >
> > @@ -469,6 +479,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> >         memset(uvalue, 0, map->value_size);
> >         memset(kvalue, 0, map->value_size);
> >  unlock:
> > +       kfree(tprogs);
> >         mutex_unlock(&st_map->lock);
> >         return err;
> >  }
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 704fa787fec0..9daeb094f054 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -190,40 +190,50 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
> >         return ret;
> >  }
> >
> > -/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
> > - * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
> > - */
> > -#define BPF_MAX_TRAMP_PROGS 40
> > +static struct bpf_tramp_progs *
> > +bpf_trampoline_update_progs(struct bpf_trampoline *tr, int *total)
> > +{
> > +       struct bpf_tramp_progs *tprogs;
> > +       struct bpf_prog **progs;
> > +       struct bpf_prog_aux *aux;
> > +       int kind;
> > +
> > +       *total = 0;
> > +       tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(struct bpf_tramp_progs),
> 
> same nit as above, sizeof(*tprogs) is shorter and less error-prone

Sure, can fix it.

- KP

> 
> > +                        GFP_KERNEL);
> > +       if (!tprogs)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
> > +               tprogs[kind].nr_progs = tr->progs_cnt[kind];
> > +               *total += tr->progs_cnt[kind];
> > +               progs = tprogs[kind].progs;
> > +
> > +               hlist_for_each_entry(aux, &tr->progs_hlist[kind], tramp_hlist)
> > +                       *progs++ = aux->prog;
> > +       }
> > +       return tprogs;
> > +}
> >
> 
> [...]

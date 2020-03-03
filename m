Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7F8178552
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCCWMq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:12:46 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39375 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCWMp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:12:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id e13so4150123qts.6;
        Tue, 03 Mar 2020 14:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yX7SAwUD3SiuK4YKn5lNeb4SBU8XYQV9n9efJll51FI=;
        b=eYMll79hi4j/mcfzxzdZtGc/kLf+/rOdMexxW4MXp6BasErUivRPmc4vS2gcD/hKj7
         5y11my/lmMjMAYw5ABR8VC8QMXp18tm2BsT2PojF0O4NDxls5Aegw/ISkhlDuTVG/D5g
         XcRIuQAk9eD+ONMoDkEK9trz7BfA9ViFJVybHhgFM4fzKwpXkbDkWglDcoFfxX/hN/7r
         Wa0AqeKRQEzUpUtKRBNibgV5eTosn/9XdsmzzEBWU2yjH9XZF8qy89E1ANVFbrdfyF28
         hP5Ut2G+8jcP+ZahGZPvzgJiZLGOcLGQpGSSskUbkjUmOqwzVnJd0o3PxrKhsKyrzEYk
         /Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yX7SAwUD3SiuK4YKn5lNeb4SBU8XYQV9n9efJll51FI=;
        b=kLx1CgfNolc8RgmSppJCxqqged+rSfMR1/haJpgVMDc5NSteQ6JLGGGl733m9avB6w
         zcIuMjldYnR368px5IGcXlBHM6tcweIq2kyhOt6T3xuh6fCCxFzUeiAn4WwMTQPDxbgM
         wlH2bCxbj0J9/DtN4j+nfD1GcW4l/YLFgVVYLSF3RVaQaCgf9Sxt4Ytj7RW6EpadrrBv
         we09FJ/l1Qb8Y0gZc5yiwLpabwpOOlLYNOygIUa9k3WAn07JbRe4jVQdiNrPkPh12Q8X
         +yzaPU0wSE0Sj2qOdQdjcbW1wvLWGHIKQXs1Fru+UWC1/DtIUc4sM4T9UQrNcRm7pY0v
         5TkA==
X-Gm-Message-State: ANhLgQ2ZwsOuVdocvzLSkoBBU27743KP7EGjU5JkH4CNGo+SkNAFJUXI
        3M8U4M5O+PhPC4im4wxWFWj+Y8cNgWBvmuVHQo4=
X-Google-Smtp-Source: ADFU+vvI3zxkMe27WrXtuIWVLqJI+C4mgUDVyAcjpazJxCsZ4gC250YvDzSgpNsbgy0SrhreY3m7kJ9PQ3jtQXJaDkM=
X-Received: by 2002:ac8:4581:: with SMTP id l1mr6378408qtn.59.1583273564200;
 Tue, 03 Mar 2020 14:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org> <20200303140950.6355-2-kpsingh@chromium.org>
In-Reply-To: <20200303140950.6355-2-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 14:12:32 -0800
Message-ID: <CAEf4BzZj1+G7D2eZ9Enp_FtmmNPEkX7f6BDj2q=iZ1D8ZxxTMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Refactor trampoline update code
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 6:13 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> As we need to introduce a third type of attachment for trampolines, the
> flattened signature of arch_prepare_bpf_trampoline gets even more
> complicated.
>
> Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> use bpf_tramp_progs to simplify the addition and accounting for new
> attachment types.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 31 +++++++++---------
>  include/linux/bpf.h         | 13 ++++++--
>  kernel/bpf/bpf_struct_ops.c | 13 +++++++-
>  kernel/bpf/trampoline.c     | 63 +++++++++++++++++++++----------------
>  4 files changed, 75 insertions(+), 45 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 9ba08e9abc09..15c7d28bc05c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1362,12 +1362,12 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
>  }
>
>  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> -                     struct bpf_prog **progs, int prog_cnt, int stack_size)
> +                     struct bpf_tramp_progs *tp, int stack_size)

nit: it's `tp` here, but `tprogs` in arch_prepare_bpf_trampoline. It's
minor, but would be nice to stick to consistent naming.

>  {
>         u8 *prog = *pprog;
>         int cnt = 0, i;
>
> -       for (i = 0; i < prog_cnt; i++) {
> +       for (i = 0; i < tp->nr_progs; i++) {
>                 if (emit_call(&prog, __bpf_prog_enter, prog))
>                         return -EINVAL;
>                 /* remember prog start time returned by __bpf_prog_enter */
> @@ -1376,17 +1376,17 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
>                 /* arg1: lea rdi, [rbp - stack_size] */
>                 EMIT4(0x48, 0x8D, 0x7D, -stack_size);
>                 /* arg2: progs[i]->insnsi for interpreter */
> -               if (!progs[i]->jited)
> +               if (!tp->progs[i]->jited)
>                         emit_mov_imm64(&prog, BPF_REG_2,
> -                                      (long) progs[i]->insnsi >> 32,
> -                                      (u32) (long) progs[i]->insnsi);
> +                                      (long) tp->progs[i]->insnsi >> 32,
> +                                      (u32) (long) tp->progs[i]->insnsi);
>                 /* call JITed bpf program or interpreter */
> -               if (emit_call(&prog, progs[i]->bpf_func, prog))
> +               if (emit_call(&prog, tp->progs[i]->bpf_func, prog))
>                         return -EINVAL;
>
>                 /* arg1: mov rdi, progs[i] */
> -               emit_mov_imm64(&prog, BPF_REG_1, (long) progs[i] >> 32,
> -                              (u32) (long) progs[i]);
> +               emit_mov_imm64(&prog, BPF_REG_1, (long) tp->progs[i] >> 32,
> +                              (u32) (long) tp->progs[i]);
>                 /* arg2: mov rsi, rbx <- start time in nsec */
>                 emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
>                 if (emit_call(&prog, __bpf_prog_exit, prog))
> @@ -1458,12 +1458,13 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
>   */
>  int arch_prepare_bpf_trampoline(void *image, void *image_end,
>                                 const struct btf_func_model *m, u32 flags,
> -                               struct bpf_prog **fentry_progs, int fentry_cnt,
> -                               struct bpf_prog **fexit_progs, int fexit_cnt,
> +                               struct bpf_tramp_progs *tprogs,
>                                 void *orig_call)
>  {
>         int cnt = 0, nr_args = m->nr_args;
>         int stack_size = nr_args * 8;
> +       struct bpf_tramp_progs *fentry = &tprogs[BPF_TRAMP_FENTRY];
> +       struct bpf_tramp_progs *fexit = &tprogs[BPF_TRAMP_FEXIT];
>         u8 *prog;
>
>         /* x86-64 supports up to 6 arguments. 7+ can be added in the future */

[...]

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index c498f0fffb40..a011a77b21fa 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>         struct bpf_struct_ops_value *uvalue, *kvalue;
>         const struct btf_member *member;
>         const struct btf_type *t = st_ops->type;
> +       struct bpf_tramp_progs *tprogs = NULL;
>         void *udata, *kdata;
>         int prog_fd, err = 0;
>         void *image;
> @@ -425,10 +426,19 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>                         goto reset_unlock;
>                 }
>
> +               tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(struct bpf_tramp_progs),

nit: sizeof(*tprogs) ?

> +                                GFP_KERNEL);
> +               if (!tprogs) {
> +                       err = -ENOMEM;
> +                       goto reset_unlock;
> +               }
> +
> +               *tprogs[BPF_TRAMP_FENTRY].progs = prog;

I'm very confused what's going on here, why * at the beginning here,
but no * below?.. It seems unnecessary.

> +               tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
>                 err = arch_prepare_bpf_trampoline(image,
>                                                   st_map->image + PAGE_SIZE,
>                                                   &st_ops->func_models[i], 0,
> -                                                 &prog, 1, NULL, 0, NULL);
> +                                                 tprogs, NULL);
>                 if (err < 0)
>                         goto reset_unlock;
>
> @@ -469,6 +479,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>         memset(uvalue, 0, map->value_size);
>         memset(kvalue, 0, map->value_size);
>  unlock:
> +       kfree(tprogs);
>         mutex_unlock(&st_map->lock);
>         return err;
>  }
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 704fa787fec0..9daeb094f054 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -190,40 +190,50 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>         return ret;
>  }
>
> -/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
> - * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
> - */
> -#define BPF_MAX_TRAMP_PROGS 40
> +static struct bpf_tramp_progs *
> +bpf_trampoline_update_progs(struct bpf_trampoline *tr, int *total)
> +{
> +       struct bpf_tramp_progs *tprogs;
> +       struct bpf_prog **progs;
> +       struct bpf_prog_aux *aux;
> +       int kind;
> +
> +       *total = 0;
> +       tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(struct bpf_tramp_progs),

same nit as above, sizeof(*tprogs) is shorter and less error-prone

> +                        GFP_KERNEL);
> +       if (!tprogs)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
> +               tprogs[kind].nr_progs = tr->progs_cnt[kind];
> +               *total += tr->progs_cnt[kind];
> +               progs = tprogs[kind].progs;
> +
> +               hlist_for_each_entry(aux, &tr->progs_hlist[kind], tramp_hlist)
> +                       *progs++ = aux->prog;
> +       }
> +       return tprogs;
> +}
>

[...]
